Return-Path: <netdev+bounces-282367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKz1Hnj08WmElwEAu9opvQ
	(envelope-from <netdev+bounces-282367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:07:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04054493DEC
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F43230F6329
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281853F65E1;
	Wed, 29 Apr 2026 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoPsHaFN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002D73F54B8
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 12:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777464172; cv=none; b=Bu0lG9eCBIoVEBEsqod/AlpQgDPR5CTcaQG+el4D1U4P7ijOx9YnJaRsflmeCm8loXqlYVspeWpQI+WEXuU2PdH8JN0A+NjDT9COJdX8fc6bXh7TLAutem2+JFRbrqGGTj/c3ny+LTOaM9sLdRdaq1gMBtT7q5JJknJURvRrB5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777464172; c=relaxed/simple;
	bh=ehMxJE2bllJpJXWhiWSKWBM2mpdz3RpLy82UZ8OKVCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kSszwzkEIng7TCpmMypiEAKhQf5CrQQ6j+mfmjOf64AHQSGb+EuQqLtqBXSPRWMuQxpsAV+xSpyYcp/Hg46rjw08HeJbVZslEBcx8Vtbc9j+tW9WKZ2z7WuTM4JSuje65OdtpLQEV3/cMUMoySdL3ciQ06qnrY52j163LochwJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoPsHaFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEA7C19425;
	Wed, 29 Apr 2026 12:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777464169;
	bh=ehMxJE2bllJpJXWhiWSKWBM2mpdz3RpLy82UZ8OKVCk=;
	h=From:Date:Subject:To:Cc:From;
	b=MoPsHaFNQHlTQgukGqCZUHgOecjRH80xznRv4Oo6llI6MC0Kkd2WL1FiYouzRuEl6
	 t575P7VzrM5dCRU6jAILzsc+kf89aztJPJlGl6lijpEyCrbHwp1ekeMfMjbEFdmQxv
	 i5+4pxc+vHo5WPrtCxzCkn5MRuM9CEBbOnQi60B3IrRgwbEY6p0F6iqxQQTlIuMWJI
	 DJph38vrExVmvUyUslg4UN5XxOT16Uss0JfiOlsDDVXMRDNul8P/0ZYsiA+BSu23ef
	 ss6wlAWz8SS75qpcjCcyowNxXaHR2/u6VdxT3xzoLcsaGMzgKigyl5sx0ivqu9o+8C
	 murZ++x0DDtVA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 29 Apr 2026 14:02:31 +0200
Subject: [PATCH net v2] net: airoha: Move entries to queue head in case of
 DMA mapping failure in airoha_dev_xmit()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-airoha-xmit-unmap-error-path-v2-1-32e43b7c6d25@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0Jm7RhaC6Ir72FY1DrQidKSKRIM4
 e42nMDlez95f4VEwpTgWqwgNHPiGDLoQwHO29AT8jMz6FLXpdENWpboLS4DT/gJgx2RRKLgaCe
 PjdJVdTHUPfQJcmIU6njZ83cINEGbpec0Rfnul7Pap//qs0KFlpwxrj7XlVO3F0mg9zFKD+22b
 T/DtsuIzgAAAA==
X-Change-ID: 20260428-airoha-xmit-unmap-error-path-8125594efb23
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 04054493DEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282367-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

In order to respect the original descriptor order and avoid any
potential IOMMU fault or memory corruption, move pending queue entries
to the head of hw queue tx_list if the DMA mapping of current inflight
packet fails in airoha_dev_xmit routine.

Fixes: 3f47e67dff1f7 ("net: airoha: Add the capability to consume out-of-order DMA tx descriptors")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Remove leftover airoha_queue_entry initialization inside the loop from
  the previous version.
- Link to v1: https://lore.kernel.org/r/20260428-airoha-xmit-unmap-error-path-v1-1-aec44c6765c1@kernel.org
---
 drivers/net/ethernet/airoha/airoha_eth.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 5effb4a4ae84..fb4f51d67dd7 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2123,14 +2123,12 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 
 error_unmap:
-	while (!list_empty(&tx_list)) {
-		e = list_first_entry(&tx_list, struct airoha_queue_entry,
-				     list);
+	list_for_each_entry(e, &tx_list, list) {
 		dma_unmap_single(dev->dev.parent, e->dma_addr, e->dma_len,
 				 DMA_TO_DEVICE);
 		e->dma_addr = 0;
-		list_move_tail(&e->list, &q->tx_list);
 	}
+	list_splice(&tx_list, &q->tx_list);
 
 	spin_unlock_bh(&q->lock);
 error:

---
base-commit: 0c7a5ba011d336df4fcd1f667fcc16ea5549be12
change-id: 20260428-airoha-xmit-unmap-error-path-8125594efb23

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


