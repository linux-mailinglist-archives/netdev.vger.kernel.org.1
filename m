Return-Path: <netdev+bounces-270223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLeYOpuuvmmEWgMAu9opvQ
	(envelope-from <netdev+bounces-270223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 15:43:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AA62E5DE4
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 15:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3E1C3023379
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 14:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A003F38D682;
	Sat, 21 Mar 2026 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILV3TUUI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9FD38D680
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774104119; cv=none; b=UFYSLbHKw2VyB8TBNsIONkBDF76aHWZ+GAeoXiWVvRPQ0ZIhayZBHLFGbitIMhat4LJWclSXiuiE2TFd4uXh5XpkKq/DAkDK4eViV3G8+etAFKZwatfE0KQKP38N7pCLPu6w/+a7WAfrnxwo0SC10i7i69F+1h8BMfZS3udLEBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774104119; c=relaxed/simple;
	bh=ObYld9zxOf6gTfGXzgKx7yFASQiWGAHw3Ikee/ABTwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SMPsksIAHcfJGUuEwQZuXRB0FwPzEYplaelXP7P2RZAlGMGDtF27+kqTe9FY4FC00LavXWaHOtwvIPClPTf91ooTU/FyHgxfDszniyQZ1tD4U1CmbHATvQL5R9mQaGHMK7YX/lIO2S4EAf2vjYf8Eeiw1dFzIkTzCUQxTaFwDZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILV3TUUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19BBC19421;
	Sat, 21 Mar 2026 14:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774104119;
	bh=ObYld9zxOf6gTfGXzgKx7yFASQiWGAHw3Ikee/ABTwE=;
	h=From:Date:Subject:To:Cc:From;
	b=ILV3TUUIr7ndjs9F0yQRz4drfu7tdZJuJwE6Z0Si0AUcUO9TEizrQcWeREYKsD5h1
	 tJwlaSSSoUAfoF3mQJByQwESStrnna+vHCRaT13NAWx9zJYWLguuHcvz1Mj3Z7sDz5
	 2BYqHs4r8N0TcWzCju46/0z/vuNENF4zevW+2uGdlXPXl0VX5lgoMvaKUEhjbadJ0B
	 k9fZK4KGKt2oQB7X8Jf3/IxdP2B1Mjbz7R1pdauk3VQEC3VDqhdUeEkweFfKEYi5lG
	 F8Vvxu+jJJNpqQSiCaICtou6otCNZLPGd6C5X2pcEiyCbqru3lHRSJomn2x2s6y298
	 NR3ZIg5+GkR9g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 21 Mar 2026 15:41:44 +0100
Subject: [PATCH net-next v2] net: airoha: Rework the code flow in
 airoha_remove() and in airoha_probe() error path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260321-airoha-remove-rework-v2-1-16c7bade5fe5@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NTQ6CMBCFr2Jm7Zj+gBBX3sOwaOgAE7Q1U1Ixh
 LvbcABXL19e3vc2SCRMCW6nDYQyJ46hgDmfoJ9cGAnZFwajzFVZo9CxxMmh0CtmKvGJMmNrW1t
 XlW/q1kOZvoUGXg/tAwItGGhdoCvNxGmJ8j3+sj76/+qsUaPzRENDtld6uM8kgZ6XKCN0+77/A
 LfZdOLDAAAA
X-Change-ID: 20260320-airoha-remove-rework-8383544d758d
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270223-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64AA62E5DE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As suggested by Simon in [0], rework the code flow in airoha_remove()
and in the airoha_probe() error path in order to rely on a more common
approach un-registering configured net-devices first and destroying the
hw resources at the end of the code.
Introduce airoha_qdma_cleanup routine to release QDMA resources.

[0] https://lore.kernel.org/netdev/20251214-airoha-fix-dev-registration-v1-1-860e027ad4c6@kernel.org/

Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Fix eth->napi_dev leak if airoha_hw_init() fails in airoha_probe()
- Link to v1: https://lore.kernel.org/r/20260320-airoha-remove-rework-v1-1-adeef7e3c01f@kernel.org
---
 drivers/net/ethernet/airoha/airoha_eth.c | 76 ++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 961325da833b27eee31dfa03be26dfc82071097e..82e53c60f561f6314fbf201ba8bc8711e40edc68 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1368,6 +1368,33 @@ static int airoha_qdma_init(struct platform_device *pdev,
 	return airoha_qdma_hw_init(qdma);
 }
 
+static void airoha_qdma_cleanup(struct airoha_qdma *qdma)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
+		if (!qdma->q_rx[i].ndesc)
+			continue;
+
+		netif_napi_del(&qdma->q_rx[i].napi);
+		airoha_qdma_cleanup_rx_queue(&qdma->q_rx[i]);
+		if (qdma->q_rx[i].page_pool) {
+			page_pool_destroy(qdma->q_rx[i].page_pool);
+			qdma->q_rx[i].page_pool = NULL;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++)
+		netif_napi_del(&qdma->q_tx_irq[i].napi);
+
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
+		if (!qdma->q_tx[i].ndesc)
+			continue;
+
+		airoha_qdma_cleanup_tx_queue(&qdma->q_tx[i]);
+	}
+}
+
 static int airoha_hw_init(struct platform_device *pdev,
 			  struct airoha_eth *eth)
 {
@@ -1395,41 +1422,30 @@ static int airoha_hw_init(struct platform_device *pdev,
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++) {
 		err = airoha_qdma_init(pdev, eth, &eth->qdma[i]);
 		if (err)
-			return err;
+			goto error;
 	}
 
 	err = airoha_ppe_init(eth);
 	if (err)
-		return err;
+		goto error;
 
 	set_bit(DEV_STATE_INITIALIZED, &eth->state);
 
 	return 0;
+error:
+	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
+		airoha_qdma_cleanup(&eth->qdma[i]);
+
+	return err;
 }
 
-static void airoha_hw_cleanup(struct airoha_qdma *qdma)
+static void airoha_hw_cleanup(struct airoha_eth *eth)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
-		if (!qdma->q_rx[i].ndesc)
-			continue;
-
-		netif_napi_del(&qdma->q_rx[i].napi);
-		airoha_qdma_cleanup_rx_queue(&qdma->q_rx[i]);
-		if (qdma->q_rx[i].page_pool)
-			page_pool_destroy(qdma->q_rx[i].page_pool);
-	}
-
-	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++)
-		netif_napi_del(&qdma->q_tx_irq[i].napi);
-
-	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
-		if (!qdma->q_tx[i].ndesc)
-			continue;
-
-		airoha_qdma_cleanup_tx_queue(&qdma->q_tx[i]);
-	}
+	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
+		airoha_qdma_cleanup(&eth->qdma[i]);
+	airoha_ppe_deinit(eth);
 }
 
 static void airoha_qdma_start_napi(struct airoha_qdma *qdma)
@@ -3012,7 +3028,7 @@ static int airoha_probe(struct platform_device *pdev)
 
 	err = airoha_hw_init(pdev, eth);
 	if (err)
-		goto error_hw_cleanup;
+		goto error_netdev_free;
 
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
 		airoha_qdma_start_napi(&eth->qdma[i]);
@@ -3040,10 +3056,6 @@ static int airoha_probe(struct platform_device *pdev)
 error_napi_stop:
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
 		airoha_qdma_stop_napi(&eth->qdma[i]);
-	airoha_ppe_deinit(eth);
-error_hw_cleanup:
-	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
-		airoha_hw_cleanup(&eth->qdma[i]);
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
@@ -3055,6 +3067,8 @@ static int airoha_probe(struct platform_device *pdev)
 			unregister_netdev(port->dev);
 		airoha_metadata_dst_free(port);
 	}
+	airoha_hw_cleanup(eth);
+error_netdev_free:
 	free_netdev(eth->napi_dev);
 	platform_set_drvdata(pdev, NULL);
 
@@ -3066,10 +3080,8 @@ static void airoha_remove(struct platform_device *pdev)
 	struct airoha_eth *eth = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++) {
+	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
 		airoha_qdma_stop_napi(&eth->qdma[i]);
-		airoha_hw_cleanup(&eth->qdma[i]);
-	}
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
@@ -3080,9 +3092,9 @@ static void airoha_remove(struct platform_device *pdev)
 		unregister_netdev(port->dev);
 		airoha_metadata_dst_free(port);
 	}
-	free_netdev(eth->napi_dev);
+	airoha_hw_cleanup(eth);
 
-	airoha_ppe_deinit(eth);
+	free_netdev(eth->napi_dev);
 	platform_set_drvdata(pdev, NULL);
 }
 

---
base-commit: fb78a629b4f0eb399b413f6c093a3da177b3a4eb
change-id: 20260320-airoha-remove-rework-8383544d758d

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


