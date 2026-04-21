Return-Path: <netdev+bounces-280021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHcvKyAd52lR4AEAu9opvQ
	(envelope-from <netdev+bounces-280021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 08:45:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A4C4371C1
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 08:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BF243012C90
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 06:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0099F386436;
	Tue, 21 Apr 2026 06:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6CZ42TN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA6C3859CF
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 06:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776753804; cv=none; b=O4uSYgcRF0NWBU8XVXFJQ+u9IMi9QrZIcnBpyI309gnmJGcUUtna26sxI44hFErOkK8ZCzjiZkYtWeK6wMVtlH3Qtf0DymztUybQC2ZJMt+4kwxByyQYrQVnXZbdjWkXW73uR+sW+Sw9doQxvg+owbPEqLe3RKFerNOTyRchSKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776753804; c=relaxed/simple;
	bh=ZKZG+O0J9kV7ldRJcMabcJRwOJQwoGJwOtsehsIKW+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SF8npBT633JmCDT0/rTGs2nhUNdmESHbmBPm5bIh4DaNQAba6tu0B99RA4h/UcSfhewrmfst8CsQSFQ6T0brWw/hu/jD970KOMPnpsbPzJWBKD5krLSyMBPErAQtta2UIfXhoS5HjRA4osCLMN7E1poxNuNrXns5zQktLFDRdEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6CZ42TN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32B3C2BCB0;
	Tue, 21 Apr 2026 06:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776753804;
	bh=ZKZG+O0J9kV7ldRJcMabcJRwOJQwoGJwOtsehsIKW+Q=;
	h=From:Date:Subject:To:Cc:From;
	b=S6CZ42TNemFsGJ28k4IRpJ+UpPcHGjRTYozI1fnJHUuYU7Hsul5zU4Fdy+6GQwfpS
	 txFENVglu/DsDsyrjf7APABe27rQrbHxBMhuFDZ24YzrpnkfQhTIdFosNgmEkbcT3O
	 8eJSsHEBUHI6J4rsCe0qqijarKgU+AS/0zH2y9F2Z+4IYbY5x3NNuynzz2TZ0J4BqA
	 Ce5hbmsR0+USuYkQZlS4H4DAh4arZYrQbwV03bl0rQfKEgI4VuEgBOObDw4oha90QJ
	 bQgvPkqnsUPdvbZylAavVsSIU19H//hro1TJ429V4Dfrr40SxAFP5LdX+eGQaWwOoR
	 OVsVJxPEEPDTQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 21 Apr 2026 08:43:07 +0200
Subject: [PATCH net] net: airoha: stop net_device TX queue before updating
 CPU index
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-airoha-xmit-stop-condition-v1-1-e670d6a48467@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBvQSYK6SrQQnWoWaahEEN49a
 fkW/7+QOQlnmLsXEt+SJYYG3XfgDht2RvHNQIpGZUijlRQPi88pBXOJF7oYvJSW4WCMd4omsnq
 CNrgSb/L88wUCF1hr/QDdzUd0cQAAAA==
X-Change-ID: 20260421-airoha-xmit-stop-condition-344dc0292a19
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280021-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59A4C4371C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, airoha_eth driver updates the CPU index register prior of
verifying whether the number of free descriptors has fallen below the
threshold.
Move net_device TX queue length check before updating the TX CPU index
in order to update TX CPU index even if there are more packets to be
transmitted but the net_device TX queue is going to be stopped
accounting the inflight packets.

Fixes: 1d304174106c ("net: airoha: Implement BQL support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 19f67c7dd8e1..5d327237e274 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2058,17 +2058,16 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 
 	skb_tx_timestamp(skb);
 	netdev_tx_sent_queue(txq, skb->len);
+	if (q->ndesc - q->queued < q->free_thr) {
+		netif_tx_stop_queue(txq);
+		q->txq_stopped = true;
+	}
 
 	if (netif_xmit_stopped(txq) || !netdev_xmit_more())
 		airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid),
 				TX_RING_CPU_IDX_MASK,
 				FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
 
-	if (q->ndesc - q->queued < q->free_thr) {
-		netif_tx_stop_queue(txq);
-		q->txq_stopped = true;
-	}
-
 	spin_unlock_bh(&q->lock);
 
 	return NETDEV_TX_OK;

---
base-commit: a663bac71a2f0b3ac6c373168ca57b2a6e6381aa
change-id: 20260421-airoha-xmit-stop-condition-344dc0292a19

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


