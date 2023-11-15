Return-Path: <netdev+bounces-47920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC187EBF2F
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 10:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40AE9281148
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 09:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15BF46B5;
	Wed, 15 Nov 2023 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uvB2hYHE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13F07E;
	Wed, 15 Nov 2023 09:11:39 +0000 (UTC)
Received: from mout.web.de (mout.web.de [217.72.192.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47128F5;
	Wed, 15 Nov 2023 01:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700039466; x=1700644266; i=markus.elfring@web.de;
	bh=8WDhLtoKLy35+5PZZkcN/p57I6TCKqVmJkti5fQEovQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=uvB2hYHE1ss1gh45DyYuVHCQ+SFSnwdYkgCcfdjHbDEo1ZjSL7hQAtmJnLDirxNs
	 44dv0yBjXSFTG0gqdt4bfkB5FI7kNDOt/AfaD60eOiTSec9Vn20fBcMYhw0rSEWay
	 pCy+CCt3U6i4sDWT1BtIv2+OjOCkDtHDQl5NXQFL11mVm86n99eDj6vKjos8zBBbf
	 biwCFyrgCNwWeVmsNR2NMaBkPIBeNp26X6PEIEjQF/gtypFiCkmHyXTHTJ+feKyuV
	 RiALRyZNtn5mPGhRYgd6hDmtVH1I286Vryqbv2Ft/w8akwNlkHv5VvxnzvnbmgToB
	 GvKoKZNmug36i1L2oA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MfKtN-1rasmg3irj-00gYZt; Wed, 15
 Nov 2023 10:11:05 +0100
Message-ID: <38279cb8-ff60-427e-ae9f-5f973955ffa6@web.de>
Date: Wed, 15 Nov 2023 10:10:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] net: bcmasp: Use common error handling code in
 bcmasp_probe()
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Justin Chen <justin.chen@broadcom.com>, Jakub Kicinski <kuba@kernel.org>,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Simon Horman <horms@kernel.org>
References: <0b2972cb-03b2-40c7-a728-6ebe2512637f@web.de>
 <20231106145806.669875f4@kernel.org>
 <dce77105-47ab-4ec7-8d46-b983c630dad8@web.de>
 <CALSSxFYRgPwEq+QhCOYPqrtae8RvL=jTOcz4mk3vbe+Fc0QwbQ@mail.gmail.com>
 <4053e838-e5cf-4450-8067-21bdec989d1b@broadcom.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4053e838-e5cf-4450-8067-21bdec989d1b@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I94ylgcLIavmxXuQAjZzu347c3BuJq6r19TRqpcys5o9rMY4Z07
 cAe5iF72kk3KOacACYzxzkvgLhtpWsiiyiXl3hTtYY13LrFw5d+gq/MGGl2IAK4xwWuNpBn
 yaEhUa/rpnzdLidZi1Dvx40gaefJbIBko4pYP4t5IQu4ZNa+KWnf1hdk2DIdXlnmH6InOKv
 OwprYWJD/jDe2p1/5l9fA==
UI-OutboundReport: notjunk:1;M01:P0:UJzgLR3r644=;9l9e178ekyfMaX4XD04XVuMv49K
 7Mqj3jLbG/s8KWo5KoO353ouaqHxVb8NIAPrlv6Iv4eTjtTbQUhoE1u0xxEXnN1fHlOyu455X
 +NzyYFHDPvL/m+X4NXIUfxAdTEZKEk3Mc4wRApdjKYtdQcjJN+FJnYzkoMwJFiDJ6LYKOCVcE
 Ox5K+gMhA8az5HP/A8rGx0zEyvlPuhiHfljkRVMpEBMy+AqldPSSHSj6QwCdLm/bdF8kVkM3B
 pxOhIF3Yzw/hOYCSExtG6bdNlH6sUE2tO8U6aQWPqQ+2Z2cfnRiyTaszxe0DH4h5RUVMBSkCH
 GgKkENeHonmWLxeqZdjXVziEAfX7Ja9pACo6HqViksHQp66XHCDERFBvO9nomEwQzA3Xo+mBF
 W5Gh41uw4jfLjs5PDWt91HifPyLRwaGHSADyRoxTpwhECRChXpw62o76UbUNx/wF60SsHfACT
 KqwJyOnFdTSmSMNCI/af2JvQL+k0eLv4xitOZVvhuGU0DAm8tOKmXZmBC6Ks+mk0LnXlO50v5
 c5EfF9SaPFephv4xAhRO8OfDlmqF9mbr2Em7WaB9WmzhBEf4P+ipOqjVULJnHb9ljxfwt8fK5
 eawnf/G7DhEM0pbr9J2Pvxb72Q+FvojKDdxIQdkzBY2Mbwko2B0ERDja9OEbL/g1TixZESdUI
 yd/OCnocPqbKjyw7eskYipEc8eIuGDhtDCHY/+CBtlbXS04UW+OQVAa/aMw5pBqUBWjTfvxWR
 C7QH1I4wCHvBAHQL3C18j8SQ7q2QpJlEQMAJ8A1lFE0XOc1EaOzQ9EG75aBKvEE7revZ5qTna
 L0lSw/851jTxXgNg2PhqQwGh3oznLblL4VLAerGfUr7cxhr5u1MrMdfRWdn3Tqdmahnz2tn8r
 j0lsq23i5B+9AuWF2adW8OA7PThueej38kETISwB75vWm/q9aZmttyvP5fsGLLx5VdLq+CaVI
 7C61Cw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 15 Nov 2023 09:38:56 +0100

Add a jump target so that a bit of exception handling can be better reused
in this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

v2:
Special expectations were expressed for the previous patch size.

* Jakub Kicinski
  https://lore.kernel.org/netdev/20231106145806.669875f4@kernel.org/

* Justin Chen
  https://lore.kernel.org/netdev/CALSSxFYRgPwEq+QhCOYPqrtae8RvL=3DjTOcz4mk=
3vbe+Fc0QwbQ@mail.gmail.com/

* Florian Fainelli
  https://lore.kernel.org/netdev/4053e838-e5cf-4450-8067-21bdec989d1b@broa=
dcom.com/


Thus another change variant can eventually be integrated.


 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/eth=
ernet/broadcom/asp2/bcmasp.c
index 29b04a274d07..7d6c15732d9f 100644
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
@@ -1331,6 +1330,7 @@ static int bcmasp_probe(struct platform_device *pdev=
)
 			netdev_err(intf->ndev,
 				   "failed to register net_device: %d\n", ret);
 			priv->destroy_wol(priv);
+remove_intfs:
 			bcmasp_remove_intfs(priv);
 			goto of_put_exit;
 		}
=2D-
2.42.1


