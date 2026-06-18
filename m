Return-Path: <netdev+bounces-300463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WZtoEQIENGp2LAYAu9opvQ
	(envelope-from <netdev+bounces-300463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 16:43:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FF46A0FB3
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 16:43:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ovG0N4Jh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300463-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300463-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68CA6302F5BD
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 14:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2262BE656;
	Thu, 18 Jun 2026 14:43:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2673127FD4B
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 14:43:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781793791; cv=none; b=T7LdKgHs8/eY4LFeSydw8Zgp0KTQ7R8LWBt70m4Ze5O4FCpmSH7IODl0znBP8wgpPWiKMINVIZEBUA141vCNunNl0B9tDpnWAWqs7Z0RZyaLvrlNv6aGMLlMA2aMk50pXDc/VDxoFX5A/I5t/VDabutC12xc9OnpElMQgw+ZTfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781793791; c=relaxed/simple;
	bh=/QXwfvJmE1EEjx3frmn8qeIGTsvyxSWOwZedhD06bl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WVNbFFPv7Xt2Uqpk0aJ/Vf2p8YGLQ1z3jm60XEUOWowurt21tiAun3JLV6ofZV7VBCBwLaSLW9xKFswdFxHpvpxvBXtW15VqAtynEA6YUDNhUpL4L+WatJbEiTuSU7msSFKyfiHdBNrpmoTW1TaLRPlSPEcpJ+Et0IXpnsTVBoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovG0N4Jh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1711F000E9;
	Thu, 18 Jun 2026 14:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781793789;
	bh=t2sz7xBgbes68OQYaz1UZdhDaI89v08U9XWvCznymZQ=;
	h=From:To:Cc:Subject:Date;
	b=ovG0N4JhZUVubxU0GdLvX7m72BhPMWCpGjL7lyrjS5zMytpESJ8/MT2+LxL3zHHpg
	 u7yWknuNxKdISY36OHS7cjfTzMPLXReeVlVj8fS1Q+aPP3+PlyR6jbdW/fTgFx49WQ
	 8tWjchfxd+pkgTRFISvsCqKEJN/4p8Kk3tA9BMihQISgizJqJ1AmOTN+3do9ROoikF
	 NdQwLyUlrMWj+e9Z71jB49UDZ7W547wXKzHkOokXwU1yLb5uxldcG05iJscsGoXDeU
	 pqWMW+PSALrqbGtlVOe5Px4dzNaG/d9FosjauJ7cxUsyHhX/DyzJ6SQLpz5jRiq9P1
	 D89jHEsA4ch0g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: lorenzo@kernel.org,
	aleksander.lobakin@intel.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org
Subject: [RFC v3 net-next] net: airoha: add HW GRO offload support
Date: Thu, 18 Jun 2026 16:42:46 +0200
Message-ID: <58ea436731ed961d0b2259a38952c0a485b50ee0.1781793607.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lorenzo@kernel.org,m:aleksander.lobakin@intel.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300463-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95FF46A0FB3

Add hardware GRO offload support to the airoha_eth driver, leveraging
the EN7581/AN7583 SoC's 8 dedicated LRO hardware queues mapped to RX
queues 24-31. HW GRO offloading does not support Scatter-Gather (SG) so
it is required to increase the page_pool allocation order to 2 for RX
queues 24-31 (LRO queues).
Since HW GRO is configured per-QDMA and shared across all devices using
it, HW GRO is mutually exclusive with multiple active devices on the
same QDMA block. Call netdev_update_features() on sibling devices in
ndo_open/ndo_stop so that NETIF_F_GRO_HW availability is re-evaluated
when the QDMA user count changes.
Set CHECKSUM_PARTIAL with pseudo-header checksum on aggregated packets
so that L3-forwarded traffic is correctly handled by the GSO/TSO path
on the egress device.

Performance comparison between GRO and HW GRO has been carried out using
a 10Gbps NIC:
GRO: ~2.7 Gbps
HW GRO: ~8.1 Gbps

Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in RFC v3:
- Add missing TCP header length check.
- Fix TCP checkum calculation.
- Disable LRO running ndo_stop callback.
- Implement packet header split in order to support HW-GRO
- Link to v2: https://lore.kernel.org/r/20260610-airoha-eth-lro-v2-1-54be99b9a2d5@kernel.org

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
 drivers/net/ethernet/airoha/airoha_eth.c  | 364 ++++++++++++++++++++--
 drivers/net/ethernet/airoha/airoha_eth.h  |  24 ++
 drivers/net/ethernet/airoha/airoha_regs.h |  22 +-
 3 files changed, 386 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 64dde6464f3f..2aa6915d424e 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -10,8 +10,10 @@
 #include <linux/tcp.h>
 #include <linux/u64_stats_sync.h>
 #include <net/dst_metadata.h>
+#include <net/ip6_checksum.h>
 #include <net/page_pool/helpers.h>
 #include <net/pkt_cls.h>
+#include <net/tcp.h>
 #include <uapi/linux/ppp_defs.h>
 
 #include "airoha_regs.h"
@@ -486,6 +488,73 @@ static void airoha_fe_crsn_qsel_init(struct airoha_eth *eth)
 				 CDM_CRSN_QSEL_Q1));
 }
 
+static void airoha_fe_lro_rxq_enable(struct airoha_eth *eth, int qdma_id,
+				     int lro_queue_index, int qid,
+				     int buf_size)
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
+static void airoha_dev_lro_enable(struct airoha_gdm_dev *dev)
+{
+	struct airoha_qdma *qdma = dev->qdma;
+	struct airoha_eth *eth = qdma->eth;
+	int qdma_id = qdma - &eth->qdma[0];
+	int i, lro_queue_index = 0;
+
+	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
+		struct airoha_queue *q = &qdma->q_rx[i];
+		u32 size;
+
+		if (!q->ndesc)
+			continue;
+
+		if (!airoha_qdma_is_lro_queue(q))
+			continue;
+
+		size = SKB_WITH_OVERHEAD(AIROHA_RX_LEN(q->buf_size));
+		size = min_t(u32, size, CDM_LRO_AGG_SIZE_MASK);
+		airoha_fe_lro_rxq_enable(eth, qdma_id, lro_queue_index, i,
+					 size);
+		lro_queue_index++;
+	}
+}
+
 static int airoha_fe_init(struct airoha_eth *eth)
 {
 	airoha_fe_maccr_init(eth);
@@ -611,6 +680,7 @@ static int airoha_qdma_fill_rx_queue(struct airoha_queue *q)
 		e->dma_addr = page_pool_get_dma_addr(page) + offset;
 		e->dma_len = SKB_WITH_OVERHEAD(AIROHA_RX_LEN(q->buf_size));
 
+		WRITE_ONCE(desc->tcp_ts_reply, 0);
 		val = FIELD_PREP(QDMA_DESC_LEN_MASK, e->dma_len);
 		WRITE_ONCE(desc->ctrl, cpu_to_le32(val));
 		WRITE_ONCE(desc->addr, cpu_to_le32(e->dma_addr));
@@ -652,12 +722,173 @@ airoha_qdma_get_gdm_dev(struct airoha_eth *eth, struct airoha_qdma_desc *desc)
 	return port->devs[d] ? port->devs[d] : ERR_PTR(-ENODEV);
 }
 
+static struct sk_buff *airoha_qdma_lro_rx_skb(struct airoha_queue *q,
+					      struct airoha_qdma_desc *desc,
+					      struct airoha_queue_entry *e)
+{
+	u32 len, th_off, tcp_ack_seq, agg_count, data_off, data_len;
+	u32 desc_ctrl = le32_to_cpu(READ_ONCE(desc->ctrl));
+	u32 msg1 = le32_to_cpu(READ_ONCE(desc->msg1));
+	u32 msg2 = le32_to_cpu(READ_ONCE(desc->msg2));
+	u32 msg3 = le32_to_cpu(READ_ONCE(desc->msg3));
+	struct skb_shared_info *shinfo;
+	u16 tcp_win, l2_len;
+	struct sk_buff *skb;
+	struct tcphdr *th;
+	struct page *page;
+	bool ipv4, ipv6;
+
+	ipv4 = FIELD_GET(QDMA_ETH_RXMSG_IP4_MASK, msg1);
+	ipv6 = FIELD_GET(QDMA_ETH_RXMSG_IP6_MASK, msg1);
+	if (!ipv4 && !ipv6)
+		return NULL;
+
+	l2_len = FIELD_GET(QDMA_ETH_RXMSG_L2_LEN_MASK, msg2);
+	len = FIELD_GET(QDMA_DESC_LEN_MASK, desc_ctrl);
+
+	if (ipv4) {
+		struct iphdr *iph;
+
+		if (len < l2_len + sizeof(*iph))
+			return NULL;
+
+		iph = (struct iphdr *)(e->buf + l2_len);
+		if (iph->protocol != IPPROTO_TCP)
+			return NULL;
+
+		if (iph->ihl < 5)
+			return NULL;
+
+		th_off = l2_len + (iph->ihl << 2);
+		if (len < th_off)
+			return NULL;
+
+		iph->tot_len = cpu_to_be16(len - l2_len);
+		iph->check = 0;
+		iph->check = ip_fast_csum((void *)iph, iph->ihl);
+	} else {
+		struct ipv6hdr *ip6h;
+
+		th_off = l2_len + sizeof(*ip6h);
+		if (len < th_off)
+			return NULL;
+
+		ip6h = (struct ipv6hdr *)(e->buf + l2_len);
+		if (ip6h->nexthdr != NEXTHDR_TCP)
+			return NULL;
+
+		ip6h->payload_len = cpu_to_be16(len - th_off);
+	}
+
+	if (len < th_off + sizeof(*th))
+		return NULL;
+
+	th = (struct tcphdr *)(e->buf + th_off);
+	if (th->doff < 5)
+		return NULL;
+
+	data_off = th_off + (th->doff << 2);
+	if (len < data_off)
+		return NULL;
+
+	tcp_win = FIELD_GET(QDMA_ETH_RXMSG_TCP_WIN_MASK, msg3);
+	tcp_ack_seq = le32_to_cpu(READ_ONCE(desc->data));
+	th->ack_seq = cpu_to_be32(tcp_ack_seq);
+	th->window = cpu_to_be16(tcp_win);
+
+	/* Check tcp timestamp option */
+	if (th->doff == (sizeof(*th) + TCPOLEN_TSTAMP_ALIGNED) / 4) {
+		u32 topt = get_unaligned_be32(th + 1);
+
+		if (topt == ((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
+			     (TCPOPT_TIMESTAMP << 8) | TCPOLEN_TIMESTAMP)) {
+			u8 *ptr = (u8 *)th + sizeof(*th) + 2 * sizeof(__be32);
+			__le32 tcp_ts_reply = READ_ONCE(desc->tcp_ts_reply);
+
+			put_unaligned_be32(le32_to_cpu(tcp_ts_reply), ptr);
+		}
+	}
+
+	if (ipv4) {
+		struct iphdr *iph = (struct iphdr *)(e->buf + l2_len);
+
+		th->check = ~tcp_v4_check(len - th_off, iph->saddr,
+					  iph->daddr, 0);
+	} else {
+		struct ipv6hdr *ip6h = (struct ipv6hdr *)(e->buf + l2_len);
+
+		th->check = ~tcp_v6_check(len - th_off, &ip6h->saddr,
+					  &ip6h->daddr, 0);
+	}
+
+	/* Split network headers and payload to rely on GRO.
+	 * We need to do it in the driver since the NIC does
+	 * not support it.
+	 */
+	skb = napi_alloc_skb(&q->napi, data_off);
+	if (!skb)
+		return NULL;
+
+	__skb_put(skb, data_off);
+	memcpy(skb->data, e->buf, data_off);
+
+	page = virt_to_head_page(e->buf);
+	data_len = len - data_off;
+	shinfo = skb_shinfo(skb);
+	skb_add_rx_frag(skb, shinfo->nr_frags, page,
+			e->buf + data_off - page_address(page), data_len,
+			q->buf_size);
+
+	shinfo->gso_type = ipv4 ? SKB_GSO_TCPV4 : SKB_GSO_TCPV6;
+	agg_count = FIELD_GET(QDMA_ETH_RXMSG_AGG_COUNT_MASK, msg2);
+	shinfo->gso_size = DIV_ROUND_UP(data_len, agg_count);
+	shinfo->gso_segs = agg_count;
+
+	skb->csum_start = skb_headroom(skb) + th_off;
+	skb->csum_offset = offsetof(struct tcphdr, check);
+	skb->ip_summed = CHECKSUM_PARTIAL;
+
+	return skb;
+}
+
+static struct sk_buff *airoha_qdma_build_rx_skb(struct airoha_queue *q,
+						struct airoha_qdma_desc *desc,
+						struct airoha_queue_entry *e,
+						struct net_device *dev)
+{
+	u32 msg2 = le32_to_cpu(READ_ONCE(desc->msg2));
+	int qid = q - &q->qdma->q_rx[0];
+	struct sk_buff *skb;
+
+	if (FIELD_GET(QDMA_ETH_RXMSG_AGG_COUNT_MASK, msg2) > 1) { /* LRO */
+		skb = airoha_qdma_lro_rx_skb(q, desc, e);
+		if (!skb)
+			return NULL;
+	} else {
+		u32 desc_ctrl = le32_to_cpu(READ_ONCE(desc->ctrl));
+		u32 len = FIELD_GET(QDMA_DESC_LEN_MASK, desc_ctrl);
+
+		skb = napi_build_skb(e->buf - AIROHA_RX_HEADROOM, q->buf_size);
+		if (!skb)
+			return NULL;
+
+		skb_reserve(skb, AIROHA_RX_HEADROOM);
+		__skb_put(skb, len);
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+	}
+
+	skb_mark_for_recycle(skb);
+	skb->dev = dev;
+	skb_record_rx_queue(skb, qid);
+	skb->protocol = eth_type_trans(skb, dev);
+
+	return skb;
+}
+
 static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 {
 	enum dma_data_direction dir = page_pool_get_dma_dir(q->page_pool);
-	struct airoha_qdma *qdma = q->qdma;
-	struct airoha_eth *eth = qdma->eth;
-	int qid = q - &qdma->q_rx[0];
+	struct airoha_eth *eth = q->qdma->eth;
 	int done = 0;
 
 	while (done < budget) {
@@ -693,18 +924,9 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 
 		netdev = netdev_from_priv(dev);
 		if (!q->skb) { /* first buffer */
-			q->skb = napi_build_skb(e->buf - AIROHA_RX_HEADROOM,
-						q->buf_size);
+			q->skb = airoha_qdma_build_rx_skb(q, desc, e, netdev);
 			if (!q->skb)
 				goto free_frag;
-
-			skb_reserve(q->skb, AIROHA_RX_HEADROOM);
-			__skb_put(q->skb, len);
-			skb_mark_for_recycle(q->skb);
-			q->skb->dev = netdev;
-			q->skb->protocol = eth_type_trans(q->skb, netdev);
-			q->skb->ip_summed = CHECKSUM_UNNECESSARY;
-			skb_record_rx_queue(q->skb, qid);
 		} else { /* scattered frame */
 			struct skb_shared_info *shinfo = skb_shinfo(q->skb);
 			int nr_frags = shinfo->nr_frags;
@@ -795,12 +1017,10 @@ static int airoha_qdma_rx_napi_poll(struct napi_struct *napi, int budget)
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
@@ -808,9 +1028,10 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 	struct airoha_eth *eth = qdma->eth;
 	int qid = q - &qdma->q_rx[0], thr;
 	dma_addr_t dma_addr;
+	bool lro_q;
 
-	q->buf_size = PAGE_SIZE / 2;
 	q->qdma = qdma;
+	lro_q = airoha_qdma_is_lro_queue(q);
 
 	q->entry = devm_kzalloc(eth->dev, ndesc * sizeof(*q->entry),
 				GFP_KERNEL);
@@ -822,6 +1043,9 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 	if (!q->desc)
 		return -ENOMEM;
 
+	pp_params.order = lro_q ? AIROHA_LRO_PAGE_ORDER : 0;
+	pp_params.max_len = PAGE_SIZE << pp_params.order;
+
 	q->page_pool = page_pool_create(&pp_params);
 	if (IS_ERR(q->page_pool)) {
 		int err = PTR_ERR(q->page_pool);
@@ -830,6 +1054,7 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 		return err;
 	}
 
+	q->buf_size = lro_q ? pp_params.max_len : pp_params.max_len / 2;
 	q->ndesc = ndesc;
 	netif_napi_add(eth->napi_dev, &q->napi, airoha_qdma_rx_napi_poll);
 
@@ -843,7 +1068,12 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
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
 
@@ -865,6 +1095,7 @@ static void airoha_qdma_cleanup_rx_queue(struct airoha_queue *q)
 					page_pool_get_dma_dir(q->page_pool));
 		page_pool_put_full_page(q->page_pool, page, false);
 		/* Reset DMA descriptor */
+		WRITE_ONCE(desc->tcp_ts_reply, 0);
 		WRITE_ONCE(desc->ctrl, 0);
 		WRITE_ONCE(desc->addr, 0);
 		WRITE_ONCE(desc->data, 0);
@@ -1802,6 +2033,37 @@ static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
 	spin_unlock(&port->stats_lock);
 }
 
+static void airoha_update_netdev_features(struct airoha_gdm_dev *dev)
+{
+	struct airoha_eth *eth = dev->eth;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
+		struct airoha_gdm_port *port = eth->ports[i];
+		int j;
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
@@ -1809,6 +2071,17 @@ static int airoha_dev_open(struct net_device *netdev)
 	struct airoha_gdm_port *port = dev->port;
 	u32 cur_len, pse_port = FE_PSE_PORT_PPE1;
 	struct airoha_qdma *qdma = dev->qdma;
+	int qdma_id = qdma - &qdma->eth->qdma[0];
+
+	/* HW GRO is configured on the QDMA and it is shared between
+	 * all the devices using it. Refuse to open a second device on
+	 * the same QDMA if HW GRO is enabled on any device sharing it.
+	 */
+	if (qdma->users && airoha_fe_lro_is_enabled(qdma->eth, qdma_id)) {
+		netdev_warn(netdev, "required to disable HW GRO on QDMA%d\n",
+			    qdma_id);
+		return -EBUSY;
+	}
 
 	netif_tx_start_all_queues(netdev);
 	err = airoha_set_vip_for_gdm_port(dev, true);
@@ -1848,6 +2121,11 @@ static int airoha_dev_open(struct net_device *netdev)
 	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
 				    pse_port);
 
+	if (netdev->features & NETIF_F_GRO_HW)
+		airoha_dev_lro_enable(dev);
+
+	airoha_update_netdev_features(dev);
+
 	return 0;
 }
 
@@ -1895,6 +2173,9 @@ static int airoha_dev_stop(struct net_device *netdev)
 					    FE_PSE_PORT_DROP);
 
 	if (!--qdma->users) {
+		int qdma_id = qdma - &qdma->eth->qdma[0];
+
+		airoha_fe_lro_disable(qdma->eth, qdma_id);
 		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
 				  GLOBAL_CFG_TX_DMA_EN_MASK |
 				  GLOBAL_CFG_RX_DMA_EN_MASK);
@@ -1907,6 +2188,8 @@ static int airoha_dev_stop(struct net_device *netdev)
 		}
 	}
 
+	airoha_update_netdev_features(dev);
+
 	return 0;
 }
 
@@ -2176,6 +2459,41 @@ int airoha_get_fe_port(struct airoha_gdm_dev *dev)
 	}
 }
 
+static netdev_features_t airoha_dev_fix_features(struct net_device *netdev,
+						 netdev_features_t features)
+{
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_qdma *qdma = dev->qdma;
+
+	if (qdma->users > 1)
+		features &= ~NETIF_F_GRO_HW;
+
+	return features;
+}
+
+static int airoha_dev_set_features(struct net_device *netdev,
+				   netdev_features_t features)
+{
+	netdev_features_t diff = netdev->features ^ features;
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+
+	if (!(diff & NETIF_F_GRO_HW))
+		return 0;
+
+	if (!netif_running(netdev))
+		return 0;
+
+	if (features & NETIF_F_GRO_HW) {
+		airoha_dev_lro_enable(dev);
+	} else {
+		int qdma_id = dev->qdma - &dev->eth->qdma[0];
+
+		airoha_fe_lro_disable(dev->eth, qdma_id);
+	}
+
+	return 0;
+}
+
 static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 				   struct net_device *netdev)
 {
@@ -3102,6 +3420,8 @@ static const struct net_device_ops airoha_netdev_ops = {
 	.ndo_stop		= airoha_dev_stop,
 	.ndo_change_mtu		= airoha_dev_change_mtu,
 	.ndo_select_queue	= airoha_dev_select_queue,
+	.ndo_fix_features	= airoha_dev_fix_features,
+	.ndo_set_features	= airoha_dev_set_features,
 	.ndo_start_xmit		= airoha_dev_xmit,
 	.ndo_get_stats64        = airoha_dev_get_stats64,
 	.ndo_set_mac_address	= airoha_dev_set_macaddr,
@@ -3189,11 +3509,9 @@ static int airoha_alloc_gdm_device(struct airoha_eth *eth,
 	netdev->ethtool_ops = &airoha_ethtool_ops;
 	netdev->max_mtu = AIROHA_MAX_MTU;
 	netdev->watchdog_timeo = 5 * HZ;
-	netdev->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM | NETIF_F_TSO6 |
-			      NETIF_F_IPV6_CSUM | NETIF_F_SG | NETIF_F_TSO |
-			      NETIF_F_HW_TC;
-	netdev->features |= netdev->hw_features;
-	netdev->vlan_features = netdev->hw_features;
+	netdev->hw_features = AIROHA_HW_FEATURES | NETIF_F_GRO_HW;
+	netdev->features |= AIROHA_HW_FEATURES;
+	netdev->vlan_features = AIROHA_HW_FEATURES;
 	SET_NETDEV_DEV(netdev, eth->dev);
 
 	/* reserve hw queues for HTB offloading */
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 41d2e7a1f9fb..c13757a88aba 100644
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
 
@@ -673,6 +685,18 @@ static inline bool airoha_is_7583(struct airoha_eth *eth)
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
-- 
2.54.0


