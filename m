Return-Path: <netdev+bounces-46097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A823B7E1517
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 17:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1645FB21677
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 16:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFEC15ACE;
	Sun,  5 Nov 2023 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iFxkHu/L"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC57C23762;
	Sun,  5 Nov 2023 16:34:30 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BE2171E;
	Sun,  5 Nov 2023 08:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1699202030; x=1699806830; i=markus.elfring@web.de;
	bh=AJzJ0pD7PIrmE6AzU/uMIyD8mCJuDdnySvLzrjiZPgM=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=iFxkHu/LmKUzE7S3sWGb0x4Z0Si2kJw3v9Ae09arSrdgVRc6Fi105NuBq2Z1Ylv9
	 8yR7W77jIKyW5gUFVPDOvZqM0bc+TKfy172l5np+GBShr0twy4uFqgC/GF0SRiPDY
	 DM2Bo3Q8znVpICuMWFI8gorlGul6C0s53EOtngGwvWyF+dWb1RYDuWn0aWLnjK4CH
	 RMOFV5pCyV8mGVbQ77VkzGq+cO3+3IGe1u/FXk/mXKSDGinMX/qEaD72lC626Lsk7
	 edjURE0XZulkQSZ4vK1hc28kJd3FT9oBJiIBoIk+L20uBakjrODYsu1QCWUPAX1qW
	 lUZ0ooU0xBstE0Sd8w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6Jxd-1rWFi30wKv-016iJC; Sun, 05
 Nov 2023 17:33:50 +0100
Message-ID: <0b2972cb-03b2-40c7-a728-6ebe2512637f@web.de>
Date: Sun, 5 Nov 2023 17:33:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <Julia.Lawall@inria.fr>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jakub Kicinski <kuba@kernel.org>, Justin Chen <justin.chen@broadcom.com>,
 Paolo Abeni <pabeni@redhat.com>, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] net: bcmasp: Use common error handling code in bcmasp_probe()
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6++zPlahvKLDI/Fdz1N+9LgnJ3iTWU2g1ZWw7sjCgkR189sh42S
 vxLUehhG8l5lgi5q8GrndZwdbXiCmh5iaUD9WkLR/AmFoJmOZDW3DPvmMq5VULEJv/R4aBi
 WKc0kXfXRjmsW5SAIzOgHGKR64T0WbQ0zPoLNIYH0UzM4Gs3ulpp8NbNBwuppkdKOVWtH5V
 SdtkFxUusIPUfqzHtoKMw==
UI-OutboundReport: notjunk:1;M01:P0:Io53oQfVKEs=;rXX/5a1ZB50YgxR0EkBnJzYrQvN
 L+FvVojPLFM3b7oWBkU7AlOl3gUM3ekqmaZuYC7RcNONUzUWJ8noMYWpUEpo85NJJxgSfhE3j
 u4auKRdiSKOaBJEJyitSALkBPHw6lVGfr054SugCmeoWqVkIxoM3l94uPDtqPMLp+CCLpfgM/
 wIogfEzvjN8lC3X/kvls+yA7JO77MDmbM736OzPCa+nlPgJRkLCTucpxgbe4K9B1T7VtGaR7q
 5WzIIC8v7KHu4Ae2tpKwDgnuKFeOC18N8U57AladnM93hO/odtIcDgse7rlKfV2vLOeto9Qtp
 YEsRLpV0D4AdrL/yYSBTIPxvmtoszHEmCdWE4B9325Hc7QVdgL/uVutUvLi1zB9QZxn/Ywy1I
 udLtABZsQpChihcn+QK8DMusaG5KFLtvBuol/tG4es8kQ+hcbvTZo7Pi1za2TV+e7Uxtu3lk1
 UmO6yc51LCQSDLU4k1DNVRA8o5u/jco8JzkMAyBbAg41YOJWBeYp2vtfTuXnJs3feBwO9VsLq
 k/ZrwPsZwyJhBu8S+0GC23ORJt8HoVf+0SJiKApGIAlyjHAHTJVqrgsrlnhRWzEURfiGV0/Aj
 ubI5irwxYo3DZMuJxV9YfABQjw2ztt/dlUmSm5urq1kecriv+TpMkMaETaykfd6hlAGZ+ERsb
 Bk1vmoiF4FyTxllfSZ5XUkdiBS9DeYrdKtT5JV2dYCaY+sbdph5cVXFUVdUClLvHUoYVMN+Nt
 UzsEaCNz1+9a/06SpiC/T6HlGKXvM1JhpbdaNlmBcridp9rHUTPYckUV8hX4tAgxcv+IzGjF8
 n1vxiZMjDCwFfLyYf+D+Cxe47I9H0advvup3Mhc/olt/F5DHdTKX+2v4xsqTNOMnBOCknBIaA
 zgrbN+4aUOxe6QIiyBI8S3Sib1jLVe8uFrbKGkxfs3SyO+ejATdPSDM8+mboYRF/g+65HZKme
 +0rE+w==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 5 Nov 2023 17:24:01 +0100

Add a jump target so that a bit of exception handling can be better
reused at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/eth=
ernet/broadcom/asp2/bcmasp.c
index 29b04a274d07..675437e44b94 100644
=2D-- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1304,9 +1304,8 @@ static int bcmasp_probe(struct platform_device *pdev=
)
 		intf =3D bcmasp_interface_create(priv, intf_node, i);
 		if (!intf) {
 			dev_err(dev, "Cannot create eth interface %d\n", i);
-			bcmasp_remove_intfs(priv);
 			of_node_put(intf_node);
-			goto of_put_exit;
+			goto remove_intfs;
 		}
 		list_add_tail(&intf->list, &priv->intfs);
 		i++;
@@ -1331,8 +1330,7 @@ static int bcmasp_probe(struct platform_device *pdev=
)
 			netdev_err(intf->ndev,
 				   "failed to register net_device: %d\n", ret);
 			priv->destroy_wol(priv);
-			bcmasp_remove_intfs(priv);
-			goto of_put_exit;
+			goto remove_intfs;
 		}
 		count++;
 	}
@@ -1342,6 +1340,10 @@ static int bcmasp_probe(struct platform_device *pde=
v)
 of_put_exit:
 	of_node_put(ports_node);
 	return ret;
+
+remove_intfs:
+	bcmasp_remove_intfs(priv);
+	goto of_put_exit;
 }

 static void bcmasp_remove(struct platform_device *pdev)
=2D-
2.42.0


