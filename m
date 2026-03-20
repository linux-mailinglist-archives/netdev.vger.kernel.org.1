Return-Path: <netdev+bounces-269851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEsMNKkIvWkO5gIAu9opvQ
	(envelope-from <netdev+bounces-269851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:43:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6242D75AB
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73FBC3021B81
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B024375F7D;
	Fri, 20 Mar 2026 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmYBuxEV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBE9375ACB
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996173; cv=none; b=Xnp9fl0RpM9GXpQmWmhz4hdwCs/oEfocxwqRpU8/8orCv0wLi3I7hz+6lM3hKrR+MV0wAIHWx71DpM6IpMbDFk0DYB/EJmM7xPyR1CDmii5y16H2KHadWSyMdEO8Xz5SHxkdsBS7E1+yuUXWd75TCpAGh5XA62Si2ppROWWi15U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996173; c=relaxed/simple;
	bh=IftfdfYj6xOLoTQ320B8JN0lhYVBzgNKhPmRTvF/cps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oGaDKFvk6g6Jijuf2F2xjoim1R4YOYQS1h9c0+toTNxlmZGjzz71i9TKdZOy/tEOGnDsnL0OOGBDvDnRN5YSvy0xxEwl2OKpysc2EVmuQVqctF7zhBhdOxjTX3W5eJ/69b5xeXyR0ErlF9JAzvSx5/K2JCSkpr4tAOFM6rBtCRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmYBuxEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B84BC4CEF7;
	Fri, 20 Mar 2026 08:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773996172;
	bh=IftfdfYj6xOLoTQ320B8JN0lhYVBzgNKhPmRTvF/cps=;
	h=From:Date:Subject:To:Cc:From;
	b=VmYBuxEVM321VPfsqQgzg+EuF/RDtIogR8Wq0NpFLv830DJfohD+hZsPmuad3k5Zn
	 0ooCUo9KgCtYx7XkhxqqRCO93Z4h1MJgKEtun4rZyucYuaHSz6ZQ0k7fzhLdyUYHlZ
	 0xnApmSWGawPyxuOotC/u9aU032yoS9zPHPdaSc0ZYzltEUxymHDZ6CpTZrBE7Embe
	 MCtZp8bt2qHTVULBwTIShUyx4WuHBsjLaXSutR5WcwwfezJxRcGvI2E0Zw+qLQ/193
	 4NRgRGVijIVFKepBMslRPirZr/aZkwmVU5nS9BKoxatffk972UJCJa/Ri8bmahsfR4
	 pYWqmAmE2AhIw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 20 Mar 2026 09:42:28 +0100
Subject: [PATCH net-next] net: airoha: Rework the code flow in
 airoha_remove() and in airoha_probe() error path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-airoha-remove-rework-v1-1-adeef7e3c01f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MwQqDMBAFf0X23IU0URv8ldJDMK+6lCayESuI/
 27oaZjDzEEFKig0NAcpNimSU5X7raFxDmkCS6xO1tjeOGs4iOY5sOKbN1T8sn7YO++6to2Pzke
 q6aJ4y/7fPilh5YR9pdd5Xn86C/hwAAAA
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269851-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7D6242D75AB
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
 drivers/net/ethernet/airoha/airoha_eth.c | 82 ++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index db9d9531711e3afc02095bb5fba983880c63ebf4..2caef0f74a3ee6c907ec000357d96422cbfee28b 100644
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
@@ -3028,7 +3044,7 @@ static int airoha_probe(struct platform_device *pdev)
 
 	err = airoha_hw_init(pdev, eth);
 	if (err)
-		goto error_hw_cleanup;
+		return err;
 
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
 		airoha_qdma_start_napi(&eth->qdma[i]);
@@ -3043,23 +3059,19 @@ static int airoha_probe(struct platform_device *pdev)
 		err = airoha_alloc_gdm_port(eth, np);
 		if (err) {
 			of_node_put(np);
-			goto error_napi_stop;
+			goto error;
 		}
 	}
 
 	err = airoha_register_gdm_devices(eth);
 	if (err)
-		goto error_napi_stop;
+		goto error;
 
 	return 0;
 
-error_napi_stop:
+error:
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
 		airoha_qdma_stop_napi(&eth->qdma[i]);
-	airoha_ppe_deinit(eth);
-error_hw_cleanup:
-	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
-		airoha_hw_cleanup(&eth->qdma[i]);
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
@@ -3071,6 +3083,8 @@ static int airoha_probe(struct platform_device *pdev)
 			unregister_netdev(port->dev);
 		airoha_metadata_dst_free(port);
 	}
+	airoha_hw_cleanup(eth);
+
 	free_netdev(eth->napi_dev);
 	platform_set_drvdata(pdev, NULL);
 
@@ -3082,10 +3096,8 @@ static void airoha_remove(struct platform_device *pdev)
 	struct airoha_eth *eth = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++) {
+	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
 		airoha_qdma_stop_napi(&eth->qdma[i]);
-		airoha_hw_cleanup(&eth->qdma[i]);
-	}
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
@@ -3096,9 +3108,9 @@ static void airoha_remove(struct platform_device *pdev)
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
base-commit: ca7e99335aea7c5977683624ba319157a4603f96
change-id: 20260320-airoha-remove-rework-8383544d758d

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


