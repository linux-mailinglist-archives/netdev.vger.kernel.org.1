Return-Path: <netdev+bounces-297683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J4QMNyJpKWqYWQMAu9opvQ
	(envelope-from <netdev+bounces-297683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:39:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8A5669D36
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:39:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dkAkY5IB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297683-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297683-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BF69300AD7F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7357340DFB6;
	Wed, 10 Jun 2026 13:34:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8F240BCD3
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 13:34:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781098460; cv=none; b=WBRyqBQxPX14UM6HbsWnGazileme2g4chEuMCyMsAXN0EQENUt1FYXXeEc3o+XbiWq8fTyCc5Vbc7ybpg89S3NxPmynUEj0luezGrqnM79f8uGOLHCipJkswVH6XZroXjrFgG6T0Kp6lbEa9yhY9+u6JGr/iKWA43N2ESbJuGmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781098460; c=relaxed/simple;
	bh=ujYjaKQmH/43BAUSYahWwODlSqyewlW/Te4uswwIl+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rvy7K3VzW5fiB/Atw6xOJp6fMeOs1lCqDdeSiF1M1XbquwpwGg6RxrHclVEHL0BjUfUp8HJNa3TQKWyPYS+O615RFEIuKO+gGxoJZtSz+c9uOqOnZWGLFhDaxgQZOWcs/7ACUzp1EIjdcS8Y/P0t9DQJYpEp1wc1n+abJIC+gos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkAkY5IB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E681F00899;
	Wed, 10 Jun 2026 13:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781098455;
	bh=c2swTuD8KfvTTLbEuvUbdA4Gtz8qC+3kctJH8isA5Ig=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dkAkY5IBJa0H60g+Dd5GekRjIxrLf2l390iTQAc1+DEsmDoZluqAPB3fJPOuYK1+n
	 k+Ia2baEqc0XMPhPWYaENYejP+E+0RYFpfOHTUNokeigulc2FY5i7SncIln5tP+4c4
	 wGfgar0/yV8K3YJevIEkXx8Nm3plf4flN65JXgu7UP9tvg+5Mj2DBxMXw0v9IG7q4w
	 ag+3FjABlKQkjCkJL4mBooTHVxmExwWb5CzcZlbMiwtmNazW7cXzWc9qwcCd09XKn0
	 uZRWLzr44rIaKo/nW9DkSLZYQz5y8952SBv5pWtvry1g9toLPVMXtsN2iRDhFbIywa
	 qYW8QOWobCF/g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 10 Jun 2026 15:33:36 +0200
Subject: [PATCH net-next v4 1/2] net: airoha: refactor QDMA start/stop into
 reusable helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-airoha-ethtool-priv_flags-v4-1-60e89cf28fea@kernel.org>
References: <20260610-airoha-ethtool-priv_flags-v4-0-60e89cf28fea@kernel.org>
In-Reply-To: <20260610-airoha-ethtool-priv_flags-v4-0-60e89cf28fea@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Madhur Agrawal <madhur.agrawal@airoha.com>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297683-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lorenzo@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:madhur.agrawal@airoha.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF8A5669D36

Factor out airoha_qdma_start() and airoha_qdma_stop() from
airoha_dev_open() and airoha_dev_stop(). These helpers will be reused
by the QDMA hot-migration logic introduced in the next patch to
dynamically switch GDM3/GDM4 ports between LAN and WAN QDMA blocks.
Add a DMA engine busy poll in airoha_qdma_stop() to wait for in-flight
DMA transfers to complete before cleaning up TX queues.

Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 53 ++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 5a8e84fa9918..aeac66df5f3b 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1771,6 +1771,40 @@ static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
 	spin_unlock(&port->stats.lock);
 }
 
+static void airoha_qdma_start(struct airoha_qdma *qdma)
+{
+	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
+			GLOBAL_CFG_TX_DMA_EN_MASK |
+			GLOBAL_CFG_RX_DMA_EN_MASK);
+	atomic_inc(&qdma->users);
+}
+
+static void airoha_qdma_stop(struct airoha_qdma *qdma)
+{
+	u32 status;
+
+	if (!atomic_dec_and_test(&qdma->users))
+		return;
+
+	airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
+			  GLOBAL_CFG_TX_DMA_EN_MASK |
+			  GLOBAL_CFG_RX_DMA_EN_MASK);
+
+	if (read_poll_timeout(airoha_qdma_rr, status,
+			      !(status & (GLOBAL_CFG_TX_DMA_BUSY_MASK |
+					  GLOBAL_CFG_RX_DMA_BUSY_MASK)),
+			      USEC_PER_MSEC, 50 * USEC_PER_MSEC, true,
+			      qdma, REG_QDMA_GLOBAL_CFG))
+		dev_warn(qdma->eth->dev, "QDMA DMA engine busy timeout\n");
+
+	for (int i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
+		if (!qdma->q_tx[i].ndesc)
+			continue;
+
+		airoha_qdma_cleanup_tx_queue(&qdma->q_tx[i]);
+	}
+}
+
 static int airoha_dev_open(struct net_device *netdev)
 {
 	int err, len = ETH_HLEN + netdev->mtu + ETH_FCS_LEN;
@@ -1806,10 +1840,7 @@ static int airoha_dev_open(struct net_device *netdev)
 	}
 	port->users++;
 
-	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
-			GLOBAL_CFG_TX_DMA_EN_MASK |
-			GLOBAL_CFG_RX_DMA_EN_MASK);
-	atomic_inc(&qdma->users);
+	airoha_qdma_start(qdma);
 
 	if (!airoha_is_lan_gdm_dev(dev) &&
 	    airoha_ppe_is_enabled(qdma->eth, 1))
@@ -1862,19 +1893,7 @@ static int airoha_dev_stop(struct net_device *netdev)
 		airoha_set_gdm_port_fwd_cfg(qdma->eth,
 					    REG_GDM_FWD_CFG(port->id),
 					    FE_PSE_PORT_DROP);
-
-	if (atomic_dec_and_test(&qdma->users)) {
-		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
-				  GLOBAL_CFG_TX_DMA_EN_MASK |
-				  GLOBAL_CFG_RX_DMA_EN_MASK);
-
-		for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
-			if (!qdma->q_tx[i].ndesc)
-				continue;
-
-			airoha_qdma_cleanup_tx_queue(&qdma->q_tx[i]);
-		}
-	}
+	airoha_qdma_stop(qdma);
 
 	return 0;
 }

-- 
2.54.0


