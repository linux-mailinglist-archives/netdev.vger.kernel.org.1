Return-Path: <netdev+bounces-280019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFJkMLoa52nT3wEAu9opvQ
	(envelope-from <netdev+bounces-280019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 08:35:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F0C437031
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 08:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24EDC30094F9
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 06:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C13427F01E;
	Tue, 21 Apr 2026 06:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MP50jThU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A2D1925BC
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776753336; cv=none; b=LFWcAS+5QIp0dkkJb8PkN9QEKugD23EJMXq9LbunqYMySLvXDpAKu2D82zInX2EsQkgcNq/uFPTiuSDu6npIyk5rNFbcCAYcxR7TFnQSoMkpg0I2I3uVLme2Q4TN5jcge+8xsxGKkA3aBzZIMM4Bngz/T2ax+MyNh0zMKizzJgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776753336; c=relaxed/simple;
	bh=HFRROKnDutWrDUQ/r5EJQStec0lggxTMibf91XTkYuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=M67osjmfnd04BK/T8rijnqSypgGItU8gYOH84PxhDttWBv4zm4jVDC/RY89woKZsJwiqrc7EC4Be9DlSQb2bOq0/7ElrAvAe8oG/bM7IS1jKa5ML610Dyn4qd26EcdRsj1X4KeTu08Sqcnl2xVS78HrSMRcVGfBmWzZofSYwjrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MP50jThU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405FBC2BCB0;
	Tue, 21 Apr 2026 06:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776753335;
	bh=HFRROKnDutWrDUQ/r5EJQStec0lggxTMibf91XTkYuk=;
	h=From:Date:Subject:To:Cc:From;
	b=MP50jThUvzNGx0PUcXjmv7mIOARG3zBySFo5paK3DNunG/Sen7sttndf8JSAmjDt0
	 5nwj3V/xu8DVn4INc0A0l4VtBfG74GR2jUy/XkbAV2Cqy2HpfgtKbcvV429w9X/r4P
	 D7Opi/NsoL06ACklTc9aBOfWoSEz4N4x3NOpaXAGvBc1nix7DvgvnFbGovCu53Uui8
	 NBcwmt41X2aht08casV2T+9vVvP92oOIaXCMFlQSYXDh1P6FXVONcVNdFX5cl+sQoo
	 1qFxY55vIv7V2TvqOAmeq6vv/Kwdu3G+96bmlniBRdMGFZm6kI3APDsp/81t8L1Vjv
	 HgOpFkL3mpd3g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 21 Apr 2026 08:35:11 +0200
Subject: [PATCH net] net: airoha: fix BQL imbalance in TX path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-airoha-fix-bql-v1-1-f135afe4275b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bsEkkvpKdFBbcyGsNCIQ/550H
 IaZDIkiU4KpyRDp4cRHqNC1DVivw0bIa2WQQg6ilx1qjofX6PhFc+2onHPKkjF21FCjM1JV/3C
 GQDcspXzouyTAZQAAAA==
X-Change-ID: 20260421-airoha-fix-bql-7fff7cebbc9a
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Hariprasad Kelam <hkelam@marvell.com>
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
	TAGGED_FROM(0.00)[bounces-280019-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41F0C437031
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix a possible BQL imbalance in airoha_dev_xmit(), where inflight
packets are accounted only for the AIROHA_NUM_TX_RING netdev TX
queues. The queue index is computed as:

    qid = skb_get_queue_mapping(skb) % ARRAY_SIZE(qdma->q_tx)
    txq = netdev_get_tx_queue(dev, qid);

However, airoha_qdma_tx_napi_poll() accounts completions across all
netdev TX queues (num_tx_queues), leading to inconsistent BQL
accounting.

Also reset all netdev TX queues in the ndo_stop callback.

Fixes: 1d304174106c ("net: airoha: Implement BQL support")
Fixes: c9f947769b77 ("net: airoha: Reset BQL stopping the netdevice")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 19f67c7dd8e1..6c7390f0de5d 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -929,10 +929,9 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 		q->queued--;
 
 		if (skb) {
-			u16 queue = skb_get_queue_mapping(skb);
 			struct netdev_queue *txq;
 
-			txq = netdev_get_tx_queue(skb->dev, queue);
+			txq = skb_get_tx_queue(skb->dev, skb);
 			netdev_tx_completed_queue(txq, 1, skb->len);
 			dev_kfree_skb_any(skb);
 		}
@@ -1711,7 +1710,7 @@ static int airoha_dev_stop(struct net_device *dev)
 	if (err)
 		return err;
 
-	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++)
+	for (i = 0; i < dev->num_tx_queues; i++)
 		netdev_tx_reset_subqueue(dev, i);
 
 	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
@@ -2002,7 +2001,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 
 	spin_lock_bh(&q->lock);
 
-	txq = netdev_get_tx_queue(dev, qid);
+	txq = skb_get_tx_queue(dev, skb);
 	nr_frags = 1 + skb_shinfo(skb)->nr_frags;
 
 	if (q->queued + nr_frags >= q->ndesc) {

---
base-commit: a663bac71a2f0b3ac6c373168ca57b2a6e6381aa
change-id: 20260421-airoha-fix-bql-7fff7cebbc9a

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


