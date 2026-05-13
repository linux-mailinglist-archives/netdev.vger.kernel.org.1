Return-Path: <netdev+bounces-287641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGuBC4WdBGpNMAIAu9opvQ
	(envelope-from <netdev+bounces-287641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:49:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F89536791
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2674D30ACB2E
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8403C38CFE1;
	Wed, 13 May 2026 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjBDGjnb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B58315D58
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684651; cv=none; b=HnEk6z8fhmombvh+cTMvltJrOiHgrX1KNoVQT7K+vDDaDMDW7qvCCDfH5jJND2zaBT8W/8/GQgUKr+GBYNRsDIHrU31tlqZR7RLVHFpkquxESmBmtC19o8mtRCssCvXqEwdnXR3059mWcNJO39SN2zTDMt+wdpnNLXTo12+V77I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684651; c=relaxed/simple;
	bh=iliNH01E0zCiR4ewRpQV15XeBpC7YO/HdMRcKK4W6Pc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=facL3UbGRiND/Gkcgk2rpZMLCa+KNCEAV9IRcaGFnzLrf4tv1c8VdOtVbfB+4v6LdEb9XhlOkt3RYjbkGJNfoaPZK4I7fhPGpNe6GIhi6fgYQfVOzc0Wliag2mmQ67vwUVFunOCmhftmwHAqZfBZdid2uOCbxJHQYcDtPhuZG0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjBDGjnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDDBC19425;
	Wed, 13 May 2026 15:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778684651;
	bh=iliNH01E0zCiR4ewRpQV15XeBpC7YO/HdMRcKK4W6Pc=;
	h=From:Date:Subject:To:Cc:From;
	b=bjBDGjnbHvLYaOEiG9nuqJk7YEMQb2VQpKoPHXjdQXblqZcdm561Qe/3MuOtCDaZd
	 FKzh1KCl0FBkts3VT4Ks6sJnnoKYOe3ByrO5mKx83nfoN9tTZOgSqXS9CE9B/n3luX
	 Qb4lv/pVLkbf8crrPPNsUQnFnvwJlhUodzxSqAj7l6L+VM+s0O2wjqn2E2Bx7XtZut
	 uikhh8u5QNKm9F00CxrprCmzOSoon4Wu8vkvafONK2ukxs3StgVssSdLXYasSisvpl
	 K9Fj1rBSe2VxTBm36tKU+Dqei+6/lRU5bEbPFlQNPZOqyrFPSKKQYCY+RtTd70IbM7
	 70tS4jddPVnLQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 13 May 2026 17:03:59 +0200
Subject: [PATCH net-next] net: airoha: Reserve RX headroom to avoid skb
 reallocation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-airoha-rx-headroom-v1-1-bd87798e422d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqEMAxA0atI1hNonSp1rjLMIthos7AdUpGCe
 HeLy7f4/4TCKlzg052gfEiRnBrsq4M5UloZJTRDb/rRDPaNJJojoVaMTEFz3tAFO83knSfroIV
 /5UXqM/1C4h0T1x1+13UDkkWbjm4AAAA=
X-Change-ID: 20260513-airoha-rx-headroom-4d19ca848a14
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Xuegang Lu <xuegang.lu@airoha.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 82F89536791
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-287641-lists,netdev=lfdr.de];
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
X-Rspamd-Action: no action

Reserve NET_SKB_PAD + NET_IP_ALIGN bytes of headroom for received packets
to avoid skb head reallocation when pushing protocol headers into the skb.

Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 14 ++++++++------
 drivers/net/ethernet/airoha/airoha_eth.h |  2 ++
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index f71fb18197ec..5a027cc7ffcb 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -543,9 +543,10 @@ static int airoha_qdma_fill_rx_queue(struct airoha_queue *q)
 		q->queued++;
 		nframes++;
 
+		offset += AIROHA_RX_HEADROOM;
 		e->buf = page_address(page) + offset;
 		e->dma_addr = page_pool_get_dma_addr(page) + offset;
-		e->dma_len = SKB_WITH_OVERHEAD(q->buf_size);
+		e->dma_len = SKB_WITH_OVERHEAD(AIROHA_RX_LEN(q->buf_size));
 
 		val = FIELD_PREP(QDMA_DESC_LEN_MASK, e->dma_len);
 		WRITE_ONCE(desc->ctrl, cpu_to_le32(val));
@@ -611,13 +612,12 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		q->tail = (q->tail + 1) % q->ndesc;
 		q->queued--;
 
-		dma_sync_single_for_cpu(eth->dev, e->dma_addr,
-					SKB_WITH_OVERHEAD(q->buf_size), dir);
+		dma_sync_single_for_cpu(eth->dev, e->dma_addr, e->dma_len,
+					dir);
 
 		page = virt_to_head_page(e->buf);
 		len = FIELD_GET(QDMA_DESC_LEN_MASK, desc_ctrl);
-		data_len = q->skb ? q->buf_size
-				  : SKB_WITH_OVERHEAD(q->buf_size);
+		data_len = q->skb ? AIROHA_RX_LEN(q->buf_size) : e->dma_len;
 		if (!len || data_len < len)
 			goto free_frag;
 
@@ -627,10 +627,12 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 
 		port = eth->ports[p];
 		if (!q->skb) { /* first buffer */
-			q->skb = napi_build_skb(e->buf, q->buf_size);
+			q->skb = napi_build_skb(e->buf - AIROHA_RX_HEADROOM,
+						q->buf_size);
 			if (!q->skb)
 				goto free_frag;
 
+			skb_reserve(q->skb, AIROHA_RX_HEADROOM);
 			__skb_put(q->skb, len);
 			skb_mark_for_recycle(q->skb);
 			q->skb->dev = port->dev;
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 58530d096de7..d3781103abb5 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -32,6 +32,8 @@
 #define AIROHA_FE_MC_MAX_VLAN_TABLE	64
 #define AIROHA_FE_MC_MAX_VLAN_PORT	16
 #define AIROHA_NUM_TX_IRQ		2
+#define AIROHA_RX_HEADROOM		(NET_SKB_PAD + NET_IP_ALIGN)
+#define AIROHA_RX_LEN(_n)		((_n) - AIROHA_RX_HEADROOM)
 #define HW_DSCP_NUM			2048
 #define IRQ_QUEUE_LEN(_n)		((_n) ? 1024 : 2048)
 #define TX_DSCP_NUM			1024

---
base-commit: 8ebd24a7822cbae25beeafba49b2159d6a68a5f2
change-id: 20260513-airoha-rx-headroom-4d19ca848a14

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


