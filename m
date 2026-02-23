Return-Path: <netdev+bounces-260150-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGSUMxecnGmhJgQAu9opvQ
	(envelope-from <netdev+bounces-260150-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:27:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3961417B785
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EE2F3038F0E
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF57340A49;
	Mon, 23 Feb 2026 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QllClLnj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXIYjMiR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6139F33067F
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771871248; cv=none; b=dG2RhdAGWTg1KbGomM7eGo1MJ/IVCakaZM3H5ct16TRrjyTqNto2FuqZnO0Ekt5Nuh60NOQB5y/EPqHcSNNe1N48oZqlaMXo2E8sddb8sRHWuRcZgzcf3995OWkZLfUVUn6kafJjlDggjmgI4D/aIm29WJ4gvBL1tJUnwYosrB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771871248; c=relaxed/simple;
	bh=YCLfdn1bn+lJmo678qf8h+QRy0LFExblSq7mmj+U3us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lygicgMIupmiMGY4QgICL3hptsOQ/h5vf0pmM7nxLbrwds1JQhihnYMkULifjlZM8N94kS53pRyVLY8QgZ5NZzTvhntkgc625ZNgPmH+7Mn2YQxMpC6HI7I84SUuIYvpJVCqc6wIsPbZcu15u/Qsyu4AIzLVa8zw8uYbutUXQSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QllClLnj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HXIYjMiR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771871245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xWIBQj/oRJLiJVZw03Ixo50scmX5dz0UgCzqhi3tqoQ=;
	b=QllClLnj7Etx/t3BXGxA0PsitAYC0MdppWSqyF9B19u5fstiYbWiFPKtLKIe7Hqkq23VZf
	6tJy220aPuNsw4J+XjxHk0WJgH/jYJvq/T7E3t/0lk23Va6D7qbCSCh2XGreiAXANA0x3F
	N05u1kzB183cgffRqXGn/v++356uQuM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-e5p0sESbMku4vDY-VuRKGA-1; Mon, 23 Feb 2026 13:27:24 -0500
X-MC-Unique: e5p0sESbMku4vDY-VuRKGA-1
X-Mimecast-MFC-AGG-ID: e5p0sESbMku4vDY-VuRKGA_1771871243
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4836ff58111so58147695e9.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 10:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771871242; x=1772476042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWIBQj/oRJLiJVZw03Ixo50scmX5dz0UgCzqhi3tqoQ=;
        b=HXIYjMiRj9w1OTLDkOuCa8QW4AcTsyGlhZ4lD15VW+zigDTqMGiH0RFQARiOHK8DWj
         dePziraIKEE0xdgTpNMO4D5+8oz8WyOSm9udrjr6SynwUYuJFidrAJrgED2fuKcg2nei
         btLguwLKKayySq9ThLBbFSDxM5EAGFa3l2p+vmkTtTtKuorFXwLXdN0gB4Fa87oIWoty
         3QC8Y6DJuSGXowWDBmlUkNdEfsn3mzgn0dG3cdO115WfDYFnR4v4ISA7Q0bkk+BtPXUU
         Z6SvoYEmUHaagSJRU4RLRNHVZCQQOG53p/0I8nXdXb+7Uary7zL8g3d1niM5OdUfaAv1
         gVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771871242; x=1772476042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xWIBQj/oRJLiJVZw03Ixo50scmX5dz0UgCzqhi3tqoQ=;
        b=FjT1xF20q712y0y07ZW4mdX8DP5P13gFPTFNG0xsy2xMbDtzx03fBk3nxNocRF6BXF
         bpbeUl111dkckFVSv5U+5VAlfhMz4ia+VMnfyrjnECBcEj/LqUXe4iSWtbCg5PscXsUB
         R7WxcHVzr6H6x1tiachkN2rArF2G8WmBIkFwJhf+JZg+H9OMJbI7qXMwX0uiE95IRcKY
         snhAbZuMEGJWTOrKe5wYOyK/OQg68uO3vrj+KX8PMfecyz9Yytw0LjTC91jHymYDeKkC
         XMS17vtbwnXm5Ux1Gruv9ibyN+wYoJDMBB2HXGnhStirDbk/6TQ4SulK18l9rLcoTNgR
         W/cw==
X-Gm-Message-State: AOJu0YzfDyU9H5eO8lcHZh6oFhUPZ7JoxrZMA+Phr1lFKdNgjUUUpgBB
	FVDa4zPNzu3loQp2tRi29O8AiTHwFN6X6wXfIonku62mtjnXouBuiMBdaQf9jP1eVh/tHzyDllA
	iiW8dbg+0O7zMGxBBmSXdwbgFeGLADRAEdcedTyCJUmHH4cR7SSpK7sbKRnQPz/GMvJwOaMZ46a
	PsBCbnCqrIU/sbQkMLu4XFl0DYtznGdbYkmC2SS1yPpg==
X-Gm-Gg: AZuq6aKVCFD5R7lBpqanQjzpqN353FLhqxn0wboi8g6ZULzc5EjuVjMI4q3EfpdjnLT
	2xwLYF+LA90IEvjmVkmwN5neKr3Z9yDHJOF+ZQ6Jq1tWFbs7ipvmUe7Fb194Q7ElCaGprYJH8Qy
	NqG3usQNKkJI7918grSEvz/ovgt/sGsuxZGY0upE0kIiVk56NNiAJmA7s/b8FQPFMAF7NiETbZq
	zyK8GYWLazmya3/Sm3lauD4oQ9yrlYzPS44QVXax42+IFqV873BxXCX8R9usqQ/TMGA0GbxD3no
	qdYyDAEtzeWuP/uwUvO1/J9wyJT0VcKkVgm0dXiY6C2uFEiZdarTxe1Hyzm3ddujeix3Xwoazs5
	GudJaXY7VJeu0EAhr/CwDFUzRQEBuKiHBk6dzZKHEDtQND76Hq3C8ENM/kuE=
X-Received: by 2002:a05:600c:4e45:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-483a95e957bmr195916675e9.16.1771871241855;
        Mon, 23 Feb 2026 10:27:21 -0800 (PST)
X-Received: by 2002:a05:600c:4e45:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-483a95e957bmr195916035e9.16.1771871241319;
        Mon, 23 Feb 2026 10:27:21 -0800 (PST)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9b668f3sm217119255e9.3.2026.02.23.10.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 10:27:19 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next v2 5/8] net: macb: add XDP support for gem
Date: Mon, 23 Feb 2026 19:26:29 +0100
Message-ID: <20260223182632.1681809-6-pvalerio@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260223182632.1681809-1-pvalerio@redhat.com>
References: <20260223182632.1681809-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260150-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xdp.data:url]
X-Rspamd-Queue-Id: 3961417B785
X-Rspamd-Action: no action

Introduce basic XDP support for macb/gem with the XDP_PASS,
XDP_DROP, XDP_REDIRECT verdict support.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb.h      |   3 +
 drivers/net/ethernet/cadence/macb_main.c | 207 ++++++++++++++++++++---
 2 files changed, 188 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index a78ad00f53b1..33a963b6dd4d 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -15,6 +15,7 @@
 #include <linux/phy/phy.h>
 #include <linux/workqueue.h>
 #include <net/page_pool/helpers.h>
+#include <net/xdp.h>
 
 #define MACB_GREGS_NBR 16
 #define MACB_GREGS_VERSION 2
@@ -1269,6 +1270,7 @@ struct macb_queue {
 	struct queue_stats stats;
 	struct page_pool	*page_pool;
 	struct sk_buff		*skb;
+	struct xdp_rxq_info	xdp_rxq;
 };
 
 struct ethtool_rx_fs_item {
@@ -1369,6 +1371,7 @@ struct macb {
 
 	struct macb_pm_data pm_data;
 	const struct macb_usrio_config *usrio;
+	struct bpf_prog	__rcu *prog;
 };
 
 #ifdef CONFIG_MACB_USE_HWSTAMP
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 708107e47ae3..26b517ed251c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -6,6 +6,7 @@
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/bpf_trace.h>
 #include <linux/circ_buf.h>
 #include <linux/clk-provider.h>
 #include <linux/clk.h>
@@ -1247,9 +1248,27 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	return packets;
 }
 
+static unsigned int gem_rx_headroom(struct macb *bp)
+{
+	if (rcu_access_pointer(bp->prog))
+		return XDP_PACKET_HEADROOM;
+
+	return NET_SKB_PAD;
+}
+
+static unsigned int gem_max_rx_data_size(int base_sz)
+{
+	return SKB_DATA_ALIGN(base_sz + ETH_HLEN + ETH_FCS_LEN);
+}
+
+static unsigned int gem_max_rx_buffer_size(int data_sz, struct macb *bp)
+{
+	return SKB_HEAD_ALIGN(data_sz + bp->rx_headroom);
+}
+
 static unsigned int gem_total_rx_buffer_size(struct macb *bp)
 {
-	return SKB_HEAD_ALIGN(bp->rx_buffer_size + bp->rx_headroom);
+	return gem_max_rx_buffer_size(bp->rx_buffer_size, bp);
 }
 
 static int gem_rx_refill(struct macb_queue *queue, bool napi)
@@ -1285,7 +1304,8 @@ static int gem_rx_refill(struct macb_queue *queue, bool napi)
 				break;
 			}
 
-			paddr = page_pool_get_dma_addr(page) + NET_SKB_PAD + offset;
+			paddr = page_pool_get_dma_addr(page) +
+				gem_rx_headroom(bp) + offset;
 
 			dma_sync_single_for_device(&bp->pdev->dev,
 						   paddr + bp->rx_ip_align,
@@ -1340,12 +1360,61 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
 	 */
 }
 
+static u32 gem_xdp_run(struct macb_queue *queue, void *buff_head,
+		       unsigned int len)
+{
+	struct net_device *dev;
+	struct bpf_prog *prog;
+	struct xdp_buff xdp;
+
+	u32 act = XDP_PASS;
+
+	rcu_read_lock();
+
+	prog = rcu_dereference(queue->bp->prog);
+	if (!prog)
+		goto out;
+
+	xdp_init_buff(&xdp, gem_total_rx_buffer_size(queue->bp), &queue->xdp_rxq);
+	xdp_prepare_buff(&xdp, buff_head, queue->bp->rx_headroom, len, false);
+	xdp_buff_clear_frags_flag(&xdp);
+	dev = queue->bp->dev;
+
+	act = bpf_prog_run_xdp(prog, &xdp);
+	switch (act) {
+	case XDP_PASS:
+		goto out;
+	case XDP_REDIRECT:
+		if (unlikely(xdp_do_redirect(dev, &xdp, prog))) {
+			act = XDP_DROP;
+			break;
+		}
+		goto out;
+	default:
+		bpf_warn_invalid_xdp_action(dev, prog, act);
+		fallthrough;
+	case XDP_ABORTED:
+		trace_xdp_exception(dev, prog, act);
+		fallthrough;
+	case XDP_DROP:
+		break;
+	}
+
+	page_pool_put_full_page(queue->page_pool,
+				virt_to_head_page(xdp.data), true);
+out:
+	rcu_read_unlock();
+
+	return act;
+}
+
 static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		  int budget)
 {
 	struct skb_shared_info *shinfo;
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
+	bool xdp_flush = false;
 	unsigned int entry;
 	struct page *page;
 	void *buff_head;
@@ -1353,11 +1422,11 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 	int data_len;
 	int nr_frags;
 
-
 	while (count < budget) {
 		bool rxused, first_frame, last_frame;
 		dma_addr_t addr;
 		u32 ctrl;
+		u32 ret;
 
 		entry = macb_rx_ring_wrap(bp, queue->rx_tail);
 		desc = macb_rx_desc(queue, entry);
@@ -1407,6 +1476,15 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 					page_pool_get_dma_dir(queue->page_pool));
 
 		if (first_frame) {
+			if (last_frame) {
+				ret = gem_xdp_run(queue, buff_head, data_len);
+				if (ret == XDP_REDIRECT)
+					xdp_flush = true;
+
+				if (ret != XDP_PASS)
+					goto next_frame;
+			}
+
 			queue->skb = napi_build_skb(buff_head, gem_total_rx_buffer_size(bp));
 			if (unlikely(!queue->skb)) {
 				netdev_err(bp->dev,
@@ -1443,10 +1521,6 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		}
 
 		/* now everything is ready for receiving packet */
-		queue->rx_buff[entry] = NULL;
-
-		netdev_vdbg(bp->dev, "%s %u (len %u)\n", __func__, entry, data_len);
-
 		if (last_frame) {
 			bp->dev->stats.rx_packets++;
 			queue->stats.rx_packets++;
@@ -1473,6 +1547,8 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			queue->skb = NULL;
 		}
 
+next_frame:
+		queue->rx_buff[entry] = NULL;
 		continue;
 
 free_frags:
@@ -1491,6 +1567,9 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		queue->rx_buff[entry] = NULL;
 	}
 
+	if (xdp_flush)
+		xdp_do_flush();
+
 	gem_rx_refill(queue, true);
 
 	return count;
@@ -2428,13 +2507,15 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 static void macb_init_rx_buffer_size(struct macb *bp, unsigned int mtu)
 {
 	unsigned int overhead;
-	size_t size;
 
 	if (!macb_is_gem(bp)) {
 		bp->rx_buffer_size = MACB_RX_BUFFER_SIZE;
 	} else {
-		size = mtu + ETH_HLEN + ETH_FCS_LEN;
-		bp->rx_buffer_size = SKB_DATA_ALIGN(size);
+		bp->rx_headroom = gem_rx_headroom(bp);
+		bp->rx_ip_align = (!(bp->caps & MACB_CAPS_RSC)) ? NET_IP_ALIGN : 0;
+		bp->rx_headroom += bp->rx_ip_align;
+
+		bp->rx_buffer_size = gem_max_rx_data_size(mtu);
 		if (gem_total_rx_buffer_size(bp) > PAGE_SIZE) {
 			overhead = bp->rx_headroom +
 				SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
@@ -2485,6 +2566,8 @@ static void gem_free_rx_buffers(struct macb *bp)
 
 		kfree(queue->rx_buff);
 		queue->rx_buff = NULL;
+		if (xdp_rxq_info_is_reg(&queue->xdp_rxq))
+			xdp_rxq_info_unreg(&queue->xdp_rxq);
 		page_pool_destroy(queue->page_pool);
 		queue->page_pool = NULL;
 	}
@@ -2641,21 +2724,23 @@ static int macb_alloc_consistent(struct macb *bp)
 	return -ENOMEM;
 }
 
-static int gem_create_page_pool(struct macb_queue *queue)
+static int gem_create_page_pool(struct macb_queue *queue, int qid)
 {
 	struct page_pool_params pp_params = {
 		.order = 0,
 		.flags = PP_FLAG_DMA_MAP,
 		.pool_size = queue->bp->rx_ring_size,
 		.nid = NUMA_NO_NODE,
-		.dma_dir = DMA_FROM_DEVICE,
+		.dma_dir = rcu_access_pointer(queue->bp->prog)
+				? DMA_BIDIRECTIONAL
+				: DMA_FROM_DEVICE,
 		.dev = &queue->bp->pdev->dev,
 		.netdev = queue->bp->dev,
 		.napi = &queue->napi_rx,
 		.max_len = PAGE_SIZE,
 	};
 	struct page_pool *pool;
-	int err = 0;
+	int err;
 
 	/* This can happen in the case of HRESP error.
 	 * Do nothing as page pool is already existing.
@@ -2667,11 +2752,34 @@ static int gem_create_page_pool(struct macb_queue *queue)
 	if (IS_ERR(pool)) {
 		netdev_err(queue->bp->dev, "cannot create rx page pool\n");
 		err = PTR_ERR(pool);
-		pool = NULL;
+		goto clear_pool;
 	}
 
 	queue->page_pool = pool;
 
+	err = xdp_rxq_info_reg(&queue->xdp_rxq, queue->bp->dev, qid,
+			       queue->napi_rx.napi_id);
+	if (err < 0) {
+		netdev_err(queue->bp->dev, "xdp: failed to register rxq info\n");
+		goto destroy_pool;
+	}
+
+	err = xdp_rxq_info_reg_mem_model(&queue->xdp_rxq, MEM_TYPE_PAGE_POOL,
+					 queue->page_pool);
+	if (err) {
+		netdev_err(queue->bp->dev, "xdp: failed to register rxq memory model\n");
+		goto unreg_info;
+	}
+
+	return 0;
+
+unreg_info:
+	xdp_rxq_info_unreg(&queue->xdp_rxq);
+destroy_pool:
+	page_pool_destroy(pool);
+clear_pool:
+	queue->page_pool = NULL;
+
 	return err;
 }
 
@@ -2713,7 +2821,7 @@ static int gem_init_rings(struct macb *bp, bool fail_early)
 		/* This is a hard failure, so the best we can do is try the
 		 * next queue in case of HRESP error.
 		 */
-		err = gem_create_page_pool(queue);
+		err = gem_create_page_pool(queue, q);
 		if (err) {
 			last_err = err;
 			if (fail_early)
@@ -3167,11 +3275,27 @@ static int macb_close(struct net_device *dev)
 	return 0;
 }
 
+static bool gem_xdp_valid_mtu(struct macb *bp, int mtu)
+{
+	int max_frame_size;
+
+	max_frame_size = gem_max_rx_buffer_size(gem_max_rx_data_size(mtu), bp);
+
+	return max_frame_size <= PAGE_SIZE;
+}
+
 static int macb_change_mtu(struct net_device *dev, int new_mtu)
 {
+	struct macb *bp = netdev_priv(dev);
+
 	if (netif_running(dev))
 		return -EBUSY;
 
+	if (rcu_access_pointer(bp->prog) && !gem_xdp_valid_mtu(bp, new_mtu)) {
+		netdev_err(dev, "MTU %d too large for XDP", new_mtu);
+		return -EINVAL;
+	}
+
 	WRITE_ONCE(dev->mtu, new_mtu);
 
 	return 0;
@@ -3189,6 +3313,48 @@ static int macb_set_mac_addr(struct net_device *dev, void *addr)
 	return 0;
 }
 
+static int gem_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
+			 struct netlink_ext_ack *extack)
+{
+	struct macb *bp = netdev_priv(dev);
+	struct bpf_prog *old_prog;
+	bool need_update, running;
+
+	if (prog && !gem_xdp_valid_mtu(bp, dev->mtu)) {
+		NL_SET_ERR_MSG_MOD(extack, "MTU too large for XDP");
+		return -EOPNOTSUPP;
+	}
+
+	running = netif_running(dev);
+	need_update = !!bp->prog != !!prog;
+	if (running && need_update)
+		macb_close(dev);
+
+	old_prog = rcu_replace_pointer(bp->prog, prog, lockdep_rtnl_is_held());
+	if (old_prog)
+		bpf_prog_put(old_prog);
+
+	if (running && need_update)
+		return macb_open(dev);
+
+	return 0;
+}
+
+static int gem_xdp(struct net_device *dev, struct netdev_bpf *xdp)
+{
+	struct macb *bp = netdev_priv(dev);
+
+	if (!macb_is_gem(bp))
+		return -EOPNOTSUPP;
+
+	switch (xdp->command) {
+	case XDP_SETUP_PROG:
+		return gem_xdp_setup(dev, xdp->prog, xdp->extack);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static void gem_update_stats(struct macb *bp)
 {
 	struct macb_queue *queue;
@@ -4447,6 +4613,7 @@ static const struct net_device_ops macb_netdev_ops = {
 	.ndo_hwtstamp_set	= macb_hwtstamp_set,
 	.ndo_hwtstamp_get	= macb_hwtstamp_get,
 	.ndo_setup_tc		= macb_setup_tc,
+	.ndo_bpf		= gem_xdp,
 };
 
 /* Configure peripheral capabilities according to device tree
@@ -5744,13 +5911,9 @@ static int macb_probe(struct platform_device *pdev)
 	if (err)
 		goto err_out_phy_exit;
 
-	if (macb_is_gem(bp)) {
-		bp->rx_headroom = NET_SKB_PAD;
-		if (!(bp->caps & MACB_CAPS_RSC)) {
-			bp->rx_ip_align = NET_IP_ALIGN;
-			bp->rx_headroom += NET_IP_ALIGN;
-		}
-	}
+	if (macb_is_gem(bp))
+		dev->xdp_features = NETDEV_XDP_ACT_BASIC |
+				    NETDEV_XDP_ACT_REDIRECT;
 
 	netif_carrier_off(dev);
 
-- 
2.52.0


