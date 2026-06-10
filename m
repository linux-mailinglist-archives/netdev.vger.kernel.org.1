Return-Path: <netdev+bounces-297715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5QTkNTl+KWp5XwMAu9opvQ
	(envelope-from <netdev+bounces-297715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:09:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC2366A927
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:09:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FdKjrPjy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297715-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297715-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58499312F495
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A361240B392;
	Wed, 10 Jun 2026 15:01:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D70372680
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 15:01:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103685; cv=none; b=tyZjX49bFi28A6yvq4a1QmOfwDmM/x/y2ZnN6qak119EfhfSJXhBOSVMe2DvvdIv4BTHfvh15hJnqIm4EgqFdN81LkS6F1KqgKkJlY/I9TTBSHWTnC3ORQ6gq6FW2T+blW7YLk2hcf0EoHz0ZUwh9D/2uUzCnovZnqdaIC1Isyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103685; c=relaxed/simple;
	bh=ye5UlYoTho/L1nbSdnbzh6cdXU3TpmdlS1jFuw4fqHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d9FHF6Wr/9BnU78kuHH9pRjRg/64p2jCcXY0XIkqurMp9EAi4XwxDsbJSlku82qlyHZMgoFIh9z0PhHA4WnNMfc8xlgozJ7YugyQY2hqZTrRhALna7WO6GV59WzF9FbJbSrMorLhb6WDYAIRS7bMpad3Rp/k1igOqvHvMmSymWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdKjrPjy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0085C1F00893;
	Wed, 10 Jun 2026 15:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781103683;
	bh=UJwDgipGaGGKFRXXef48U2RFmZ3ldSQgH3cWn1IYnVw=;
	h=From:Date:Subject:To:Cc;
	b=FdKjrPjySmV0uQrc2iqWpCXJWZx5EXnkZAlldc02Itk2fJmdXXopot2kIEavD3Fbq
	 UDv0NMTZ3D9H97ePcIcVZKiT5fTyqzJGQTLc9xZ/tIylWHIcBRA7OyCQ91DrzEiJJl
	 O/vlrw3YUOg9iJWQ3psTJomlCxkeLkl/N0r2nroKLNPDXPoOuKF1ENp9hZbXnjMQKm
	 VVL1Sjz03HLrBL6mRM5cSZ8cPUocpCMLEV/dR0drQCimu+wlYgQ/YZ+XCXXoZQEfaS
	 l2nc5ePFQVtOue5UHuC6Zzfxso1nmQU+Dyb8my8XCsh1tH1c0pq/+oplfsu7FeNZzO
	 6WmRyh91ZwJSg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 10 Jun 2026 17:00:32 +0200
Subject: [PATCH net-next v2] net: airoha: Add TCP LRO support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260610-airoha-eth-lro-v2-1-54be99b9a2d5@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XOQQrCMBAF0KtI1kYmE22NK+8hLtL01wYlkbQUR
 Xp3Y1eVKrMahvf/vESH5NGJw+olEgbf+RjywuuVcK0NF0hf510wcUE7Jml9iq2V6Ft5S1HaXa2
 cLrTaKyUyuic0/jEFnkRALwMevTjnS+u7Pqbn1DSo6f4vdFAyDxvntC6LAuZ4RQq4bWK6fEoml
 +enI1QOFcE2Ts/d54eB571Lz9nzFmwNSqtNufB67vcLr7OvazJONRUR4cuP4/gGpjNCAm8BAAA
 =
X-Change-ID: 20260520-airoha-eth-lro-a5d1c3631811
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, Madhur Agrawal <madhur.agrawal@airoha.com>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297715-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lorenzo@kernel.org,m:aleksander.lobakin@intel.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:madhur.agrawal@airoha.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6CC2366A927

Add hardware TCP Large Receive Offload (LRO) support to the airoha_eth
driver, leveraging the EN7581/AN7583 SoC's 8 dedicated LRO hardware queues
mapped to RX queues 24–31. LRO hw offloading does not support
Scatter-Gather (SG) so it is required to increase the page_pool allocation
order to 2 for RX queues 24–31 (LRO queues).
Since HW LRO is configured per-QDMA and shared across all devices using
it, LRO is mutually exclusive with multiple active devices on the same
QDMA block. Call netdev_update_features() on sibling devices in
ndo_open/ndo_stop so that NETIF_F_LRO availability is re-evaluated when
the QDMA user count changes.

Performance comparison between GRO and hw LRO has been carried out using
a 10Gbps NIC:
GRO: ~2.7 Gbps
LRO: ~8.1 Gbps

Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Rebase on top of net-next main branch.
- Link to v1: https://lore.kernel.org/r/20260606-airoha-eth-lro-v1-1-0ebceb0eafc3@kernel.org

Changes in v1:
- Please note this patch depends on the following patch not applied yet
  to net-next
  https://lore.kernel.org/netdev/20260606-airoha_qdma_users-no-atomic-v1-1-86e2d6a1bfaf@kernel.org/T/#u
- Restrict LRO to single user QDMA.
- Introduce some more sanity checks.
- Disable scatter-gather for LRO queues.
- Run netif_receive_skb() for LRO packets.
- Link to v3: https://lore.kernel.org/r/20260528-airoha-eth-lro-v3-1-dd09c1fb000e@kernel.org

Changes in RFC v3:
- Fix double-free of the page_pool of airoha_qdma_lro_rx_process()
  fails.
- Set AIROHA_LRO_PAGE_ORDER according to PAGE_SIZE.
- Add missig gso metadata for the LRO packet.
- Link to v2: https://lore.kernel.org/r/20260526-airoha-eth-lro-v2-1-24e2a9e7a397@kernel.org

Changes in RFC v2:
- Improve performances fixing buf_size computation.
- Fix possible overflow in REG_CDM_LRO_LIMIT() register configuration.
- Require the device to be not running before configuring LRO.
- Fix configuration order in airoha_fe_lro_is_enabled().
- Check skb header length in airoha_qdma_lro_rx_process().
- Do not check net_device feature in airoha_qdma_rx_process() before
  executing airoha_qdma_lro_rx_process() but rely on
  airoha_qdma_lro_rx_process() logic.
- Fix possible double recycle in airoha_qdma_rx_process() for LRO
  packets.
- Always use AIROHA_RXQ_LRO_MAX_AGG_COUNT macro for max LRO aggregated
  fragments in airoha_fe_lro_init_rx_queue().
- Link to v1: https://lore.kernel.org/r/20260520-airoha-eth-lro-v1-1-129cc33766e9@kernel.org
---
 drivers/net/ethernet/airoha/airoha_eth.c  | 282 ++++++++++++++++++++++++++++--
 drivers/net/ethernet/airoha/airoha_eth.h  |  24 +++
 drivers/net/ethernet/airoha/airoha_regs.h |  22 ++-
 3 files changed, 315 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 5a8e84fa9918..851005b86314 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -12,6 +12,7 @@
 #include <net/dst_metadata.h>
 #include <net/page_pool/helpers.h>
 #include <net/pkt_cls.h>
+#include <net/tcp.h>
 #include <uapi/linux/ppp_defs.h>
 
 #include "airoha_regs.h"
@@ -486,6 +487,48 @@ static void airoha_fe_crsn_qsel_init(struct airoha_eth *eth)
 				 CDM_CRSN_QSEL_Q1));
 }
 
+static void airoha_fe_lro_init_rx_queue(struct airoha_eth *eth, int qdma_id,
+					int lro_queue_index, int qid,
+					int buf_size)
+{
+	int id = qdma_id + 1;
+
+	airoha_fe_rmw(eth, REG_CDM_LRO_LIMIT(id),
+		      CDM_LRO_AGG_NUM_MASK | CDM_LRO_AGG_SIZE_MASK,
+		      FIELD_PREP(CDM_LRO_AGG_SIZE_MASK, buf_size) |
+		      FIELD_PREP(CDM_LRO_AGG_NUM_MASK,
+				 AIROHA_RXQ_LRO_MAX_AGG_COUNT));
+	airoha_fe_rmw(eth, REG_CDM_LRO_AGE_TIME(id),
+		      CDM_LRO_AGE_TIME_MASK | CDM_LRO_AGG_TIME_MASK,
+		      FIELD_PREP(CDM_LRO_AGE_TIME_MASK,
+				 AIROHA_RXQ_LRO_MAX_AGE_TIME) |
+		      FIELD_PREP(CDM_LRO_AGG_TIME_MASK,
+				 AIROHA_RXQ_LRO_MAX_AGG_TIME));
+	airoha_fe_rmw(eth, REG_CDM_LRO_RXQ(id, lro_queue_index),
+		      LRO_RXQ_MASK(lro_queue_index),
+		      __field_prep(LRO_RXQ_MASK(lro_queue_index), qid));
+	airoha_fe_set(eth, REG_CDM_LRO_EN(id), BIT(lro_queue_index));
+}
+
+static void airoha_fe_lro_disable(struct airoha_eth *eth, int qdma_id)
+{
+	int i, id = qdma_id + 1;
+
+	airoha_fe_clear(eth, REG_CDM_LRO_EN(id), LRO_RXQ_EN_MASK);
+	airoha_fe_clear(eth, REG_CDM_LRO_LIMIT(id),
+			CDM_LRO_AGG_NUM_MASK | CDM_LRO_AGG_SIZE_MASK);
+	airoha_fe_clear(eth, REG_CDM_LRO_AGE_TIME(id),
+			CDM_LRO_AGE_TIME_MASK | CDM_LRO_AGG_TIME_MASK);
+	for (i = 0; i < AIROHA_MAX_NUM_LRO_QUEUES; i++)
+		airoha_fe_clear(eth, REG_CDM_LRO_RXQ(id, i), LRO_RXQ_MASK(i));
+}
+
+static bool airoha_fe_lro_is_enabled(struct airoha_eth *eth, int qdma_id)
+{
+	return airoha_fe_get(eth, REG_CDM_LRO_EN(qdma_id + 1),
+			     LRO_RXQ_EN_MASK);
+}
+
 static int airoha_fe_init(struct airoha_eth *eth)
 {
 	airoha_fe_maccr_init(eth);
@@ -603,6 +646,7 @@ static int airoha_qdma_fill_rx_queue(struct airoha_queue *q)
 		e->dma_addr = page_pool_get_dma_addr(page) + offset;
 		e->dma_len = SKB_WITH_OVERHEAD(AIROHA_RX_LEN(q->buf_size));
 
+		WRITE_ONCE(desc->tcp_ts_reply, 0);
 		val = FIELD_PREP(QDMA_DESC_LEN_MASK, e->dma_len);
 		WRITE_ONCE(desc->ctrl, cpu_to_le32(val));
 		WRITE_ONCE(desc->addr, cpu_to_le32(e->dma_addr));
@@ -644,6 +688,104 @@ airoha_qdma_get_gdm_dev(struct airoha_eth *eth, struct airoha_qdma_desc *desc)
 	return port->devs[d] ? port->devs[d] : ERR_PTR(-ENODEV);
 }
 
+static int airoha_qdma_lro_rx_process(struct sk_buff *skb,
+				      struct airoha_qdma_desc *desc)
+{
+	u32 desc_ctrl = le32_to_cpu(READ_ONCE(desc->ctrl));
+	u32 len, th_off, tcp_ack_seq, agg_count, data_off;
+	struct skb_shared_info *shinfo = skb_shinfo(skb);
+	u32 msg1 = le32_to_cpu(READ_ONCE(desc->msg1));
+	u32 msg2 = le32_to_cpu(READ_ONCE(desc->msg2));
+	u32 msg3 = le32_to_cpu(READ_ONCE(desc->msg3));
+	u16 tcp_win, l2_len;
+	struct tcphdr *th;
+	bool ipv4, ipv6;
+
+	agg_count = FIELD_GET(QDMA_ETH_RXMSG_AGG_COUNT_MASK, msg2);
+	if (agg_count <= 1)
+		return 0;
+
+	ipv4 = FIELD_GET(QDMA_ETH_RXMSG_IP4_MASK, msg1);
+	ipv6 = FIELD_GET(QDMA_ETH_RXMSG_IP6_MASK, msg1);
+	if (!ipv4 && !ipv6)
+		return -EOPNOTSUPP;
+
+	l2_len = FIELD_GET(QDMA_ETH_RXMSG_L2_LEN_MASK, msg2);
+	len = FIELD_GET(QDMA_DESC_LEN_MASK, desc_ctrl);
+	if (ipv4) {
+		struct iphdr *iph, _iph;
+
+		iph = skb_header_pointer(skb, l2_len, sizeof(*iph), &_iph);
+		if (!iph)
+			return -EINVAL;
+
+		if (iph->protocol != IPPROTO_TCP)
+			return -EOPNOTSUPP;
+
+		if (iph->ihl < 5)
+			return -EINVAL;
+
+		th_off = l2_len + (iph->ihl << 2);
+		if (!pskb_may_pull(skb, th_off))
+			return -EINVAL;
+
+		iph = (struct iphdr *)(skb->data + l2_len);
+		iph->tot_len = cpu_to_be16(len - l2_len);
+		iph->check = 0;
+		iph->check = ip_fast_csum((void *)iph, iph->ihl);
+	} else {
+		struct ipv6hdr *ip6h;
+
+		th_off = l2_len + sizeof(*ip6h);
+		if (!pskb_may_pull(skb, th_off))
+			return -EINVAL;
+
+		ip6h = (struct ipv6hdr *)(skb->data + l2_len);
+		if (ip6h->nexthdr != NEXTHDR_TCP)
+			return -EOPNOTSUPP;
+
+		ip6h->payload_len = cpu_to_be16(len - th_off);
+	}
+
+	tcp_win = FIELD_GET(QDMA_ETH_RXMSG_TCP_WIN_MASK, msg3);
+	tcp_ack_seq = le32_to_cpu(READ_ONCE(desc->data));
+
+	if (!pskb_may_pull(skb, th_off + sizeof(*th)))
+		return -EINVAL;
+
+	th = (struct tcphdr *)(skb->data + th_off);
+	data_off = th_off + (th->doff << 2);
+	if (len <= data_off)
+		return -EINVAL;
+
+	th->ack_seq = cpu_to_be32(tcp_ack_seq);
+	th->window = cpu_to_be16(tcp_win);
+
+	/* Check tcp timestamp option */
+	if (th->doff == (sizeof(*th) + TCPOLEN_TSTAMP_ALIGNED) / 4) {
+		u32 topt;
+
+		if (!pskb_may_pull(skb, data_off))
+			return -EINVAL;
+
+		th = (struct tcphdr *)(skb->data + th_off);
+		topt = get_unaligned_be32(th + 1);
+		if (topt == ((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
+			     (TCPOPT_TIMESTAMP << 8) | TCPOLEN_TIMESTAMP)) {
+			u8 *ptr = (u8 *)th + sizeof(*th) + 2 * sizeof(__be32);
+			__le32 tcp_ts_reply = READ_ONCE(desc->tcp_ts_reply);
+
+			put_unaligned_be32(le32_to_cpu(tcp_ts_reply), ptr);
+		}
+	}
+
+	shinfo->gso_type = ipv4 ? SKB_GSO_TCPV4 : SKB_GSO_TCPV6;
+	shinfo->gso_size = (len - data_off) / agg_count;
+	shinfo->gso_segs = agg_count;
+
+	return 0;
+}
+
 static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 {
 	enum dma_data_direction dir = page_pool_get_dma_dir(q->page_pool);
@@ -694,9 +836,17 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 			__skb_put(q->skb, len);
 			skb_mark_for_recycle(q->skb);
 			q->skb->dev = netdev;
-			q->skb->protocol = eth_type_trans(q->skb, netdev);
 			q->skb->ip_summed = CHECKSUM_UNNECESSARY;
 			skb_record_rx_queue(q->skb, qid);
+
+			if (airoha_qdma_lro_rx_process(q->skb, desc) < 0) {
+				netdev->stats.rx_dropped++;
+				dev_kfree_skb(q->skb);
+				q->skb = NULL;
+				continue;
+			}
+
+			q->skb->protocol = eth_type_trans(q->skb, netdev);
 		} else { /* scattered frame */
 			struct skb_shared_info *shinfo = skb_shinfo(q->skb);
 			int nr_frags = shinfo->nr_frags;
@@ -741,7 +891,10 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 					     false);
 
 		done++;
-		napi_gro_receive(&q->napi, q->skb);
+		if (skb_is_gso(q->skb))
+			netif_receive_skb(q->skb);
+		else
+			napi_gro_receive(&q->napi, q->skb);
 		q->skb = NULL;
 		continue;
 free_frag:
@@ -787,12 +940,10 @@ static int airoha_qdma_rx_napi_poll(struct napi_struct *napi, int budget)
 static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 				     struct airoha_qdma *qdma, int ndesc)
 {
-	const struct page_pool_params pp_params = {
-		.order = 0,
+	struct page_pool_params pp_params = {
 		.pool_size = 256,
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 		.dma_dir = DMA_FROM_DEVICE,
-		.max_len = PAGE_SIZE,
 		.nid = NUMA_NO_NODE,
 		.dev = qdma->eth->dev,
 		.napi = &q->napi,
@@ -800,9 +951,10 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 	struct airoha_eth *eth = qdma->eth;
 	int qid = q - &qdma->q_rx[0], thr;
 	dma_addr_t dma_addr;
+	bool lro_q;
 
-	q->buf_size = PAGE_SIZE / 2;
 	q->qdma = qdma;
+	lro_q = airoha_qdma_is_lro_queue(q);
 
 	q->entry = devm_kzalloc(eth->dev, ndesc * sizeof(*q->entry),
 				GFP_KERNEL);
@@ -814,6 +966,9 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 	if (!q->desc)
 		return -ENOMEM;
 
+	pp_params.order = lro_q ? AIROHA_LRO_PAGE_ORDER : 0;
+	pp_params.max_len = PAGE_SIZE << pp_params.order;
+
 	q->page_pool = page_pool_create(&pp_params);
 	if (IS_ERR(q->page_pool)) {
 		int err = PTR_ERR(q->page_pool);
@@ -822,6 +977,7 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 		return err;
 	}
 
+	q->buf_size = lro_q ? pp_params.max_len : pp_params.max_len / 2;
 	q->ndesc = ndesc;
 	netif_napi_add(eth->napi_dev, &q->napi, airoha_qdma_rx_napi_poll);
 
@@ -835,7 +991,12 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 			FIELD_PREP(RX_RING_THR_MASK, thr));
 	airoha_qdma_rmw(qdma, REG_RX_DMA_IDX(qid), RX_RING_DMA_IDX_MASK,
 			FIELD_PREP(RX_RING_DMA_IDX_MASK, q->head));
-	airoha_qdma_set(qdma, REG_RX_SCATTER_CFG(qid), RX_RING_SG_EN_MASK);
+	if (lro_q)
+		airoha_qdma_clear(qdma, REG_RX_SCATTER_CFG(qid),
+				  RX_RING_SG_EN_MASK);
+	else
+		airoha_qdma_set(qdma, REG_RX_SCATTER_CFG(qid),
+				RX_RING_SG_EN_MASK);
 
 	airoha_qdma_fill_rx_queue(q);
 
@@ -857,6 +1018,7 @@ static void airoha_qdma_cleanup_rx_queue(struct airoha_queue *q)
 					page_pool_get_dma_dir(q->page_pool));
 		page_pool_put_full_page(q->page_pool, page, false);
 		/* Reset DMA descriptor */
+		WRITE_ONCE(desc->tcp_ts_reply, 0);
 		WRITE_ONCE(desc->ctrl, 0);
 		WRITE_ONCE(desc->addr, 0);
 		WRITE_ONCE(desc->data, 0);
@@ -1771,6 +1933,36 @@ static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
 	spin_unlock(&port->stats.lock);
 }
 
+static void airoha_update_netdev_features(struct airoha_gdm_dev *dev)
+{
+	struct airoha_eth *eth = dev->eth;
+	int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
+		struct airoha_gdm_port *port = eth->ports[i];
+
+		if (!port)
+			continue;
+
+		for (j = 0; j < ARRAY_SIZE(port->devs); j++) {
+			struct airoha_gdm_dev *iter_dev = port->devs[j];
+			struct net_device *netdev;
+
+			if (!iter_dev || iter_dev == dev)
+				continue;
+
+			if (iter_dev->qdma != dev->qdma)
+				continue;
+
+			netdev = netdev_from_priv(iter_dev);
+			if (netdev->reg_state != NETREG_REGISTERED)
+				continue;
+
+			netdev_update_features(netdev);
+		}
+	}
+}
+
 static int airoha_dev_open(struct net_device *netdev)
 {
 	int err, len = ETH_HLEN + netdev->mtu + ETH_FCS_LEN;
@@ -1778,6 +1970,18 @@ static int airoha_dev_open(struct net_device *netdev)
 	struct airoha_gdm_port *port = dev->port;
 	u32 cur_len, pse_port = FE_PSE_PORT_PPE1;
 	struct airoha_qdma *qdma = dev->qdma;
+	int qdma_id = qdma - &qdma->eth->qdma[0];
+
+	/* HW LRO is configured on the QDMA and it is shared between
+	 * all the devices using it. Refuse to open a second device on
+	 * the same QDMA if LRO is enabled on any device sharing it.
+	 */
+	if (atomic_read(&qdma->users) &&
+	    airoha_fe_lro_is_enabled(qdma->eth, qdma_id)) {
+		netdev_warn(netdev, "required to disable LRO on QDMA%d\n",
+			    qdma_id);
+		return -EBUSY;
+	}
 
 	netif_tx_start_all_queues(netdev);
 	err = airoha_set_vip_for_gdm_port(dev, true);
@@ -1817,6 +2021,8 @@ static int airoha_dev_open(struct net_device *netdev)
 	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
 				    pse_port);
 
+	airoha_update_netdev_features(dev);
+
 	return 0;
 }
 
@@ -1876,6 +2082,8 @@ static int airoha_dev_stop(struct net_device *netdev)
 		}
 	}
 
+	airoha_update_netdev_features(dev);
+
 	return 0;
 }
 
@@ -2154,6 +2362,56 @@ int airoha_get_fe_port(struct airoha_gdm_dev *dev)
 	}
 }
 
+static netdev_features_t airoha_dev_fix_features(struct net_device *netdev,
+						 netdev_features_t features)
+{
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_qdma *qdma = dev->qdma;
+
+	if (atomic_read(&qdma->users) > 1)
+		features &= ~NETIF_F_LRO;
+
+	return features;
+}
+
+static int airoha_dev_set_features(struct net_device *netdev,
+				   netdev_features_t features)
+{
+	netdev_features_t diff = netdev->features ^ features;
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_qdma *qdma = dev->qdma;
+	struct airoha_eth *eth = qdma->eth;
+	int qdma_id = qdma - &eth->qdma[0];
+
+	if (!(diff & NETIF_F_LRO))
+		return 0;
+
+	if (features & NETIF_F_LRO) {
+		int i, lro_queue_index = 0;
+
+		for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
+			struct airoha_queue *q = &qdma->q_rx[i];
+			u32 size;
+
+			if (!q->ndesc)
+				continue;
+
+			if (!airoha_qdma_is_lro_queue(q))
+				continue;
+
+			size = SKB_WITH_OVERHEAD(AIROHA_RX_LEN(q->buf_size));
+			size = min_t(u32, size, CDM_LRO_AGG_SIZE_MASK);
+			airoha_fe_lro_init_rx_queue(eth, qdma_id,
+						    lro_queue_index, i, size);
+			lro_queue_index++;
+		}
+	} else {
+		airoha_fe_lro_disable(eth, qdma_id);
+	}
+
+	return 0;
+}
+
 static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 				   struct net_device *netdev)
 {
@@ -3082,6 +3340,8 @@ static const struct net_device_ops airoha_netdev_ops = {
 	.ndo_stop		= airoha_dev_stop,
 	.ndo_change_mtu		= airoha_dev_change_mtu,
 	.ndo_select_queue	= airoha_dev_select_queue,
+	.ndo_fix_features	= airoha_dev_fix_features,
+	.ndo_set_features	= airoha_dev_set_features,
 	.ndo_start_xmit		= airoha_dev_xmit,
 	.ndo_get_stats64        = airoha_dev_get_stats64,
 	.ndo_set_mac_address	= airoha_dev_set_macaddr,
@@ -3169,11 +3429,9 @@ static int airoha_alloc_gdm_device(struct airoha_eth *eth,
 	netdev->ethtool_ops = &airoha_ethtool_ops;
 	netdev->max_mtu = AIROHA_MAX_MTU;
 	netdev->watchdog_timeo = 5 * HZ;
-	netdev->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM | NETIF_F_TSO6 |
-			      NETIF_F_IPV6_CSUM | NETIF_F_SG | NETIF_F_TSO |
-			      NETIF_F_HW_TC;
-	netdev->features |= netdev->hw_features;
-	netdev->vlan_features = netdev->hw_features;
+	netdev->hw_features = AIROHA_HW_FEATURES | NETIF_F_LRO;
+	netdev->features |= AIROHA_HW_FEATURES;
+	netdev->vlan_features = AIROHA_HW_FEATURES;
 	SET_NETDEV_DEV(netdev, eth->dev);
 
 	/* reserve hw queues for HTB offloading */
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 8f42973f9cf5..e78ef751f244 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -44,6 +44,18 @@
 	 (_n) == 15 ? 128 :		\
 	 (_n) ==  0 ? 1024 : 16)
 
+#define AIROHA_LRO_PAGE_ORDER		order_base_2(SZ_16K / PAGE_SIZE)
+#define AIROHA_MAX_NUM_LRO_QUEUES	8
+#define AIROHA_RXQ_LRO_EN_MASK		GENMASK(31, 24)
+#define AIROHA_RXQ_LRO_MAX_AGG_COUNT	64
+#define AIROHA_RXQ_LRO_MAX_AGG_TIME	100
+#define AIROHA_RXQ_LRO_MAX_AGE_TIME	2000
+
+#define AIROHA_HW_FEATURES			\
+	(NETIF_F_IP_CSUM | NETIF_F_RXCSUM |	\
+	 NETIF_F_TSO6 | NETIF_F_IPV6_CSUM |	\
+	 NETIF_F_SG | NETIF_F_TSO | NETIF_F_HW_TC)
+
 #define PSE_RSV_PAGES			128
 #define PSE_QUEUE_RSV_PAGES		64
 
@@ -672,6 +684,18 @@ static inline bool airoha_is_7583(struct airoha_eth *eth)
 	return eth->soc->version == 0x7583;
 }
 
+static inline bool airoha_qdma_is_lro_queue(struct airoha_queue *q)
+{
+	struct airoha_qdma *qdma = q->qdma;
+	int qid = q - &qdma->q_rx[0];
+
+	/* EN7581 SoC supports at most 8 LRO rx queues */
+	BUILD_BUG_ON(hweight32(AIROHA_RXQ_LRO_EN_MASK) >
+		     AIROHA_MAX_NUM_LRO_QUEUES);
+
+	return !!(AIROHA_RXQ_LRO_EN_MASK & BIT(qid));
+}
+
 int airoha_get_fe_port(struct airoha_gdm_dev *dev);
 bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
 			     struct airoha_gdm_dev *dev);
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index 436f3c8779c1..dfc786583774 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -122,6 +122,20 @@
 #define CDM_CRSN_QSEL_REASON_MASK(_n)	\
 	GENMASK(4 + (((_n) % 4) << 3),	(((_n) % 4) << 3))
 
+#define REG_CDM_LRO_RXQ(_n, _m)		(CDM_BASE(_n) + 0x78 + ((_m) & 0x4))
+#define LRO_RXQ_MASK(_n)		GENMASK(4 + (((_n) & 0x3) << 3), ((_n) & 0x3) << 3)
+
+#define REG_CDM_LRO_EN(_n)		(CDM_BASE(_n) + 0x80)
+#define LRO_RXQ_EN_MASK			GENMASK(7, 0)
+
+#define REG_CDM_LRO_LIMIT(_n)		(CDM_BASE(_n) + 0x84)
+#define CDM_LRO_AGG_NUM_MASK		GENMASK(23, 16)
+#define CDM_LRO_AGG_SIZE_MASK		GENMASK(15, 0)
+
+#define REG_CDM_LRO_AGE_TIME(_n)	(CDM_BASE(_n) + 0x88)
+#define CDM_LRO_AGE_TIME_MASK		GENMASK(31, 16)
+#define CDM_LRO_AGG_TIME_MASK		GENMASK(15, 0)
+
 #define REG_GDM_FWD_CFG(_n)		GDM_BASE(_n)
 #define GDM_PAD_EN_MASK			BIT(28)
 #define GDM_DROP_CRC_ERR_MASK		BIT(23)
@@ -883,9 +897,15 @@
 #define QDMA_ETH_RXMSG_SPORT_MASK	GENMASK(25, 21)
 #define QDMA_ETH_RXMSG_CRSN_MASK	GENMASK(20, 16)
 #define QDMA_ETH_RXMSG_PPE_ENTRY_MASK	GENMASK(15, 0)
+/* RX MSG2 */
+#define QDMA_ETH_RXMSG_AGG_COUNT_MASK	GENMASK(31, 24)
+#define QDMA_ETH_RXMSG_L2_LEN_MASK	GENMASK(6, 0)
+/* RX MSG3 */
+#define QDMA_ETH_RXMSG_AGG_LEN_MASK	GENMASK(31, 16)
+#define QDMA_ETH_RXMSG_TCP_WIN_MASK	GENMASK(15, 0)
 
 struct airoha_qdma_desc {
-	__le32 rsv;
+	__le32 tcp_ts_reply;
 	__le32 ctrl;
 	__le32 addr;
 	__le32 data;

---
base-commit: 660a9e399ab02c0cb86d277ed6b0c9d10c350fdd
change-id: 20260520-airoha-eth-lro-a5d1c3631811

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


