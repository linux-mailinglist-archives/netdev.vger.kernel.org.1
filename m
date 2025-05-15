Return-Path: <netdev+bounces-190834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CC7AB9087
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 22:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764B61BC3480
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D95266B66;
	Thu, 15 May 2025 20:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="E7BM5X20"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFF04B1E42;
	Thu, 15 May 2025 20:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339745; cv=none; b=lJQKwzZQZMizI5f2H48d/cg16p3kqDq98ud5JTuHQOvP0vjH2+7OtCBoisuhvCy+9pG7aexNtWKq3P7Egqciq9DGL2KWhjsVkxPBeD4s76Tq9DRzs9iSVEwvPcOfuB4OQSFp8nNacutSp3Rqyj1OsMHjk9n6eBYcn/w54t00Pgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339745; c=relaxed/simple;
	bh=uf+Uec8jqK+aCOyw7H+7MiHxFd2PaALAT6F2kPyWT/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lr29pLnvoR1qEzLFseO5fsZiLWpDnsDLwzgqIl24dB25I/gDbRkU0mEfxcgtrwmSnS/cyDTTxAy5+498JUZDg/rP3/YiW4jvLP0iALDlvVfuK1O9hdJdDYtVz8ggOtXW06aVGXwy+67bfmA7VauwxLpWbpU6fqK3QYEGmnwPwaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=E7BM5X20; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id FekBuCN6oIqMPFekCugnJy; Thu, 15 May 2025 21:59:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1747339196;
	bh=MYe7aSMySa0ucT08nhb3OZlqYbxJUD++vh68yJRzj6M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=E7BM5X20UrwkEoUQAe0akEYh/tAT6ODI+2Oc/9Zi6/yaf7wCBUufOmzwAsAZhcbZR
	 9EgyqFCZ22tONOH0iqWDXw9v1xOKD2p27aOT2oJRtZyqOnQF/TZNzH1upW5SLFaoO1
	 nASJ0dTx9oSlX1a/qPD2FvxfClJHSu5nQrv4N8Y+DCe4WJ04jvjw9dq0Bp2htyYABD
	 SMqiEpVPcKXnGIdWS7RiOdM/6YjXCd/nhWE2sHCifxJkoF5sbjjKWXCre8JtDyCs88
	 K35SYFUK6ZSLXgkFs4pvltoWu6X9uv4WsQNzgOzUArPzmHb8wUNjN+HWdPdwallz5B
	 nJ6Cn7upIXDGw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 15 May 2025 21:59:56 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 1/4] net: airoha: Fix an error handling path in airoha_alloc_gdm_port()
Date: Thu, 15 May 2025 21:59:35 +0200
Message-ID: <5c94b9b345017f29ed653e2f05d25620d128c3f0.1746715755.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If register_netdev() fails, the error handling path of the probe will not
free the memory allocated by the previous airoha_metadata_dst_alloc() call
because port->dev->reg_state will not be NETREG_REGISTERED.

So, an explicit airoha_metadata_dst_free() call is needed in this case to
avoid a memory leak.

Fixes: af3cf757d5c9 ("net: airoha: Move DSA tag in DMA descriptor")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Changes in v3:
  - None

Changes in v2:
  - New patch
v2: https://lore.kernel.org/all/5c94b9b3850f7f29ed653e2205325620df28c3ff.1746715755.git.christophe.jaillet@wanadoo.fr/

Compile tested only.
---
 drivers/net/ethernet/airoha/airoha_eth.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 16c7896f931f..af8c4015938c 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2873,7 +2873,15 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 	if (err)
 		return err;
 
-	return register_netdev(dev);
+	err = register_netdev(dev);
+	if (err)
+		goto free_metadata_dst;
+
+	return 0;
+
+free_metadata_dst:
+	airoha_metadata_dst_free(port);
+	return err;
 }
 
 static int airoha_probe(struct platform_device *pdev)
-- 
2.49.0


