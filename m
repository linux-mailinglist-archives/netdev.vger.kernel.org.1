Return-Path: <netdev+bounces-275874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJLKGN+o1GmkwAcAu9opvQ
	(envelope-from <netdev+bounces-275874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 08:49:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E044E3AA76C
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 08:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89BBD300D143
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 06:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6F538AC96;
	Tue,  7 Apr 2026 06:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7RyjkJP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63C337E2FF
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 06:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544518; cv=none; b=c6FsP8YKaz8qCUKqqT2IeS27xQhg0JL5ier8oHD0xuwrVO8hjjLpNrgPfPygAz3li8jNvcOhAsW8ROFTflYJubvEBukbunZD2K4erhbSwSf284x1Od3AIRqwgs4+llfTk6K0c28uhqHLq4yn2vF1kbpfFZb6FIpIAN1O3BCYhRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544518; c=relaxed/simple;
	bh=sO9aQuhE+niwJIm1bqiOtD3Jjz6qnYB8L83GRriDkrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q80cxgNEpyfNinyuCQbTKzO+qi0RZxsDlc21sa++l7TE/Pz0FCXjkpWN2V0zGCeCUoSiFT2bdtOBDaLOfL6KBHT/9NMjZ1vP9/tGCaOPVXaBOXPAf+LCpd9CPVRPj84SaL6i7SXlEFHLJ690Kle36051MHQxBhqNF4fI2L9S/Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7RyjkJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A990C116C6;
	Tue,  7 Apr 2026 06:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775544518;
	bh=sO9aQuhE+niwJIm1bqiOtD3Jjz6qnYB8L83GRriDkrA=;
	h=From:Date:Subject:To:Cc:From;
	b=W7RyjkJPbc9QY9ImPBHkmjo0uS84hXK7K/BSLw6m6mt+L9Y6FaXWxApbiloGeOI49
	 MO+z5Z2rMK1/BgV1bIFHqNSaXzJTEtrPCqO2xkAJUXzYxiLwtDdg79S1CiJLQ3MJXR
	 nRERo2iz9AwoFN0eBfPSC1I21LHmaklRVfmdP1FoYDSbJ6zyvfr2DjkCoIvNa3Du9l
	 OpS8xCNQnTvj3bxcwjnKpKqZdS7aIuqxj0XE9F+GlfCPYJeOE+69VSHzgjg1eE5AMN
	 XHn4GAOCbmEl687Akghnl9byCiBaJU5iA1OX/KUPavRUrtkLdC7+VPrEMQhlGMfpxb
	 GAltvef+phLjw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 07 Apr 2026 08:48:04 +0200
Subject: [PATCH net v3] net: airoha: Add dma_rmb() and READ_ONCE() in
 airoha_qdma_rx_process()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-airoha_qdma_rx_process-fix-reordering-v3-1-91c36e9da31f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XNSw6CMBCA4auQrq1pp1CIK+9hDOExQKO2OCUNh
 nB3m650p8t55Ps35pEMenbKNkYYjDfOxkEdMtZNjR2Rmz7ODARokQvgjSE3NfWzfzQ1rfVMrkP
 v+WBWTuioj5wdeQmgRAVF0eqCRWsmjB+pc2EWF3aNy8n4xdErtYNMpz8zQXLJCwVllZf5IDScb
 0gW70dHY0oE+GTVryxEVlYSNYLqoWy/2H3f374jibI3AQAA
X-Change-ID: 20260402-airoha_qdma_rx_process-fix-reordering-722308255b65
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Xuegang Lu <xuegang.lu@airoha.com>, Simon Horman <horms@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-275874-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E044E3AA76C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add missing dma_rmb() in airoha_qdma_rx_process routine to make sure the
DMA read operations are completed when the NIC reports the processing on
the current descriptor is done. Moreover, add missing READ_ONCE() in
airoha_qdma_rx_process() for DMA descriptor control fields in order to
avoid any compiler reordering.

Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v3:
- Move page pointer initialization before checking error condition on
  payload length in order avoid using page pointer uninitialized in the
  airoha_qdma_rx_process() error path.
- Link to v2: https://lore.kernel.org/r/20260403-airoha_qdma_rx_process-fix-reordering-v2-1-181e6e23d27b@kernel.org

Changes in v2:
- Use msg1 in airoha_qdma_get_gdm_port() signature to avoid missing
  READ_ONCE().
- Link to v1: https://lore.kernel.org/r/20260402-airoha_qdma_rx_process-fix-reordering-v1-1-53278474f062@kernel.org
---
 drivers/net/ethernet/airoha/airoha_eth.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 91cb63a32d99..9285a68f435f 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -584,7 +584,7 @@ static int airoha_qdma_fill_rx_queue(struct airoha_queue *q)
 static int airoha_qdma_get_gdm_port(struct airoha_eth *eth,
 				    struct airoha_qdma_desc *desc)
 {
-	u32 port, sport, msg1 = le32_to_cpu(desc->msg1);
+	u32 port, sport, msg1 = le32_to_cpu(READ_ONCE(desc->msg1));
 
 	sport = FIELD_GET(QDMA_ETH_RXMSG_SPORT_MASK, msg1);
 	switch (sport) {
@@ -612,21 +612,24 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 	while (done < budget) {
 		struct airoha_queue_entry *e = &q->entry[q->tail];
 		struct airoha_qdma_desc *desc = &q->desc[q->tail];
-		u32 hash, reason, msg1 = le32_to_cpu(desc->msg1);
-		struct page *page = virt_to_head_page(e->buf);
-		u32 desc_ctrl = le32_to_cpu(desc->ctrl);
+		u32 hash, reason, msg1, desc_ctrl;
 		struct airoha_gdm_port *port;
 		int data_len, len, p;
+		struct page *page;
 
+		desc_ctrl = le32_to_cpu(READ_ONCE(desc->ctrl));
 		if (!(desc_ctrl & QDMA_DESC_DONE_MASK))
 			break;
 
+		dma_rmb();
+
 		q->tail = (q->tail + 1) % q->ndesc;
 		q->queued--;
 
 		dma_sync_single_for_cpu(eth->dev, e->dma_addr,
 					SKB_WITH_OVERHEAD(q->buf_size), dir);
 
+		page = virt_to_head_page(e->buf);
 		len = FIELD_GET(QDMA_DESC_LEN_MASK, desc_ctrl);
 		data_len = q->skb ? q->buf_size
 				  : SKB_WITH_OVERHEAD(q->buf_size);
@@ -670,8 +673,8 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 			 * DMA descriptor. Report DSA tag to the DSA stack
 			 * via skb dst info.
 			 */
-			u32 sptag = FIELD_GET(QDMA_ETH_RXMSG_SPTAG,
-					      le32_to_cpu(desc->msg0));
+			u32 msg0 = le32_to_cpu(READ_ONCE(desc->msg0));
+			u32 sptag = FIELD_GET(QDMA_ETH_RXMSG_SPTAG, msg0);
 
 			if (sptag < ARRAY_SIZE(port->dsa_meta) &&
 			    port->dsa_meta[sptag])
@@ -679,6 +682,7 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 						  &port->dsa_meta[sptag]->dst);
 		}
 
+		msg1 = le32_to_cpu(READ_ONCE(desc->msg1));
 		hash = FIELD_GET(AIROHA_RXD4_FOE_ENTRY, msg1);
 		if (hash != AIROHA_RXD4_FOE_ENTRY)
 			skb_set_hash(q->skb, jhash_1word(hash, 0),

---
base-commit: a9d4f4f6e65e0bf9bbddedecc84d67249991979c
change-id: 20260402-airoha_qdma_rx_process-fix-reordering-722308255b65

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


