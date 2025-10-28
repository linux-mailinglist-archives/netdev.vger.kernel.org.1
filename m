Return-Path: <netdev+bounces-233422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D7FC12DD8
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 05:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B73E4E1D7F
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 04:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1731C3F0C;
	Tue, 28 Oct 2025 04:33:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C1D271
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 04:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761626036; cv=none; b=KVZTRxtDJZcqbl1+RDY4HRiU19eUdKdSmITb8vYYSaCMC+rwi63n65+IdRQjxSjpvP8hLuszsuznEt3qlzjOU+NaKMpD9s7cTQjvhQ7yVIsCnmzQhCv3vv8MWVus0REStt+N9MruKpNJen0cj3Qv9m+YiZNzh7IItBM2A4L8Iy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761626036; c=relaxed/simple;
	bh=as07/dPrxmzqQLahs6G2sHAVLOTrehCI2ymXP4ySSJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RDwZN8rgTf65k2j3ke8pabzOOLgcKgKh/XE5Tnknj6/OsaHB19D5P64q9+/kte58bS0FdPVCaCaQgpVM1U9Av96dB6bLLJKmZqfeX/oktQE2jviV9jwyROFz+ArshrpXu9RGQefSOU5bY+KeDdDIdDRHrR0PXqPt0Cj3986gQZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz10t1761625969t06a1d11a
X-QQ-Originating-IP: HksmOUYL87llrRbdwQT6oORL0WJet6ObUW/QEiyYosw=
Received: from localhost.localdomain ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Oct 2025 12:32:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7279934464400958128
EX-QQ-RecipientCnt: 10
From: Tonghao Zhang <tonghao@bamaicloud.com>
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>,
	Eran Ben Elisha <eranbe@mellanox.com>,
	Jiri Pirko <jiri@mellanox.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>
Subject: [PATCH net-next] net: add net cookie for net device trace events
Date: Tue, 28 Oct 2025 12:32:44 +0800
Message-Id: <20251028043244.82288-1-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MZQHlr9Il6uOBNH5VHVmavYxV6UXrF4R6wGwNK6pmQlekwIN83VijbZu
	C9qW+4RIRbQtT02M8ToafYho1XtHP7eOmJKrmR0ng17Bek6wk5RH3d0TKHFzrbm0ywZdFej
	T4k7ts92v4JqTr/VuMhvk1NfiJDW+7OWVhj31fIsiRcafkyXQik6Lym4At1IHRcC1tZ5M3N
	LtK1RZw5QjF7tpez/cbhGJv/yt9/LmjrN+slQzVh2gjyYCDgoFPJK6h9XZXUM20LWEzUn9f
	8knTx1qU8b8B+RBnN1XRp4KaA2bszvW6iYPtYBBBF1gRU4U1ohrUepQcnJzMAOWli3XQKHs
	/ID2pt8PyiytGlDdQEzot9Gm/Ld+q6M+Umt0R/L3i7UAy08L+ZDjznGmldD07Ki5qW1+uqq
	KwuVJjf1cQHGHneJBDGjHuZ61e5TnpVWYzGxu/lhxlu2rpMDrC0WAz3rv7Ob5PgNXpk2GOF
	OlUE5/FxdrfwK4ZRuPehdBZE5SNnrS9+8/bqLSVyWIB+NWPhrrJwvzJkUfdLlr7ZzLu/vZs
	1K3tDFpQFeFMC3k+OltiLIsgh/lHjLLFmMsiy2szERqxL+vcerIpmXskq3YU3Ea33joe5mE
	C9MWDneX3CIdrhLa8j/xXIBNRkl3nkRATkbNpXS9uir1GiuQVYEJ3akkFNmFgFwhKA+IDo/
	lVA3tIn58ZckZfFJUDE3jJue7oXp7YsskjPwf0+UGb8D6ceAtT/8SYjwbyI/59FlKSH6Y2n
	5bT2NQTyPTgWlz5aNxvoEBiUgfhggWpUfh/6GrOWaAtg4SrYnoeBG54B+JNrAO9MzbuOyja
	wXFJk0vALXtEtjYVHO5T2IHartdzVbcAw5YTQpYKX6GqkG7iuDSmnnyPtdnhDX/NvrobF1w
	2+JIrQmNSY0pKQgug3xHGXh5+Q+A3OZTKstK8LoJbUss1JnZYSdVHVFwG35yjxZhAyNTEuA
	6FAT8ffLP0NnOH8U/qrpkHHneadXNmKfQ2oumqpb1OwuqQ2kTL5hCn9NUDZ0yT2GUMpYeh2
	EcT6BKjGh+FkqkYR1Tusv5qM3swS+gcIlos0S2qS4klTXH7VoeGp7Tq94YpnVXigOmDUI+6
	xPK5rhf5zLN
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

In a multi-network card or container environment, this is needed in order
to differentiate between trace events relating to net devices that exist
in different network namespaces and share the same name.

for xmit_timeout trace events:
[002] ..s1.  1838.311662: net_dev_xmit_timeout: dev=eth0 driver=virtio_net queue=10 net_cookie=3
[007] ..s1.  1839.335650: net_dev_xmit_timeout: dev=eth0 driver=virtio_net queue=10 net_cookie=4100
[007] ..s1.  1844.455659: net_dev_xmit_timeout: dev=eth0 driver=virtio_net queue=10 net_cookie=3
[002] ..s1.  1850.087647: net_dev_xmit_timeout: dev=eth0 driver=virtio_net queue=10 net_cookie=3

Cc: Eran Ben Elisha <eranbe@mellanox.com>
Cc: Jiri Pirko <jiri@mellanox.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Suggested-by: Ido Schimmel <idosch@idosch.org>
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
---
original patch: https://patchwork.kernel.org/project/netdevbpf/patch/20251024121853.94199-1-tonghao@bamaicloud.com/
---
 include/trace/events/net.h | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/include/trace/events/net.h b/include/trace/events/net.h
index d55162c12f90..fdd9ad474ce3 100644
--- a/include/trace/events/net.h
+++ b/include/trace/events/net.h
@@ -35,6 +35,7 @@ TRACE_EVENT(net_dev_start_xmit,
 		__field(	u16,			gso_size	)
 		__field(	u16,			gso_segs	)
 		__field(	u16,			gso_type	)
+		__field(	u64,			net_cookie	)
 	),
 
 	TP_fast_assign(
@@ -57,16 +58,18 @@ TRACE_EVENT(net_dev_start_xmit,
 		__entry->gso_size = skb_shinfo(skb)->gso_size;
 		__entry->gso_segs = skb_shinfo(skb)->gso_segs;
 		__entry->gso_type = skb_shinfo(skb)->gso_type;
+		__entry->net_cookie = dev_net(dev)->net_cookie;
 	),
 
-	TP_printk("dev=%s queue_mapping=%u skbaddr=%p vlan_tagged=%d vlan_proto=0x%04x vlan_tci=0x%04x protocol=0x%04x ip_summed=%d len=%u data_len=%u network_offset=%d transport_offset_valid=%d transport_offset=%d tx_flags=%d gso_size=%d gso_segs=%d gso_type=%#x",
+	TP_printk("dev=%s queue_mapping=%u skbaddr=%p vlan_tagged=%d vlan_proto=0x%04x vlan_tci=0x%04x protocol=0x%04x ip_summed=%d len=%u data_len=%u network_offset=%d transport_offset_valid=%d transport_offset=%d tx_flags=%d gso_size=%d gso_segs=%d gso_type=%#x net_cookie=%llu",
 		  __get_str(name), __entry->queue_mapping, __entry->skbaddr,
 		  __entry->vlan_tagged, __entry->vlan_proto, __entry->vlan_tci,
 		  __entry->protocol, __entry->ip_summed, __entry->len,
 		  __entry->data_len,
 		  __entry->network_offset, __entry->transport_offset_valid,
 		  __entry->transport_offset, __entry->tx_flags,
-		  __entry->gso_size, __entry->gso_segs, __entry->gso_type)
+		  __entry->gso_size, __entry->gso_segs,
+		  __entry->gso_type, __entry->net_cookie)
 );
 
 TRACE_EVENT(net_dev_xmit,
@@ -83,17 +86,21 @@ TRACE_EVENT(net_dev_xmit,
 		__field(	unsigned int,	len		)
 		__field(	int,		rc		)
 		__string(	name,		dev->name	)
+		__field(	u64,		net_cookie	)
 	),
 
 	TP_fast_assign(
 		__entry->skbaddr = skb;
 		__entry->len = skb_len;
 		__entry->rc = rc;
+		__entry->net_cookie = dev_net(dev)->net_cookie;
 		__assign_str(name);
 	),
 
-	TP_printk("dev=%s skbaddr=%p len=%u rc=%d",
-		__get_str(name), __entry->skbaddr, __entry->len, __entry->rc)
+	TP_printk("dev=%s skbaddr=%p len=%u rc=%d net_cookie=%llu",
+		__get_str(name), __entry->skbaddr,
+		__entry->len, __entry->rc,
+		__entry->net_cookie)
 );
 
 TRACE_EVENT(net_dev_xmit_timeout,
@@ -107,16 +114,19 @@ TRACE_EVENT(net_dev_xmit_timeout,
 		__string(	name,		dev->name	)
 		__string(	driver,		netdev_drivername(dev))
 		__field(	int,		queue_index	)
+		__field(	u64,		net_cookie	)
 	),
 
 	TP_fast_assign(
 		__assign_str(name);
 		__assign_str(driver);
 		__entry->queue_index = queue_index;
+		__entry->net_cookie = dev_net(dev)->net_cookie;
 	),
 
-	TP_printk("dev=%s driver=%s queue=%d",
-		__get_str(name), __get_str(driver), __entry->queue_index)
+	TP_printk("dev=%s driver=%s queue=%d net_cookie=%llu",
+		__get_str(name), __get_str(driver),
+		__entry->queue_index, __entry->net_cookie)
 );
 
 DECLARE_EVENT_CLASS(net_dev_template,
@@ -129,16 +139,20 @@ DECLARE_EVENT_CLASS(net_dev_template,
 		__field(	void *,		skbaddr		)
 		__field(	unsigned int,	len		)
 		__string(	name,		skb->dev->name	)
+		__field(	u64,		net_cookie	)
 	),
 
 	TP_fast_assign(
 		__entry->skbaddr = skb;
 		__entry->len = skb->len;
+		__entry->net_cookie = dev_net(skb->dev)->net_cookie;
 		__assign_str(name);
 	),
 
-	TP_printk("dev=%s skbaddr=%p len=%u",
-		__get_str(name), __entry->skbaddr, __entry->len)
+	TP_printk("dev=%s skbaddr=%p len=%u net_cookie=%llu",
+		__get_str(name), __entry->skbaddr,
+		__entry->len,
+		__entry->net_cookie)
 )
 
 DEFINE_EVENT(net_dev_template, net_dev_queue,
@@ -188,6 +202,7 @@ DECLARE_EVENT_CLASS(net_dev_rx_verbose_template,
 		__field(	unsigned char,		nr_frags	)
 		__field(	u16,			gso_size	)
 		__field(	u16,			gso_type	)
+		__field(	u64,			net_cookie	)
 	),
 
 	TP_fast_assign(
@@ -214,16 +229,18 @@ DECLARE_EVENT_CLASS(net_dev_rx_verbose_template,
 		__entry->nr_frags = skb_shinfo(skb)->nr_frags;
 		__entry->gso_size = skb_shinfo(skb)->gso_size;
 		__entry->gso_type = skb_shinfo(skb)->gso_type;
+		__entry->net_cookie = dev_net(skb->dev)->net_cookie;
 	),
 
-	TP_printk("dev=%s napi_id=%#x queue_mapping=%u skbaddr=%p vlan_tagged=%d vlan_proto=0x%04x vlan_tci=0x%04x protocol=0x%04x ip_summed=%d hash=0x%08x l4_hash=%d len=%u data_len=%u truesize=%u mac_header_valid=%d mac_header=%d nr_frags=%d gso_size=%d gso_type=%#x",
+	TP_printk("dev=%s napi_id=%#x queue_mapping=%u skbaddr=%p vlan_tagged=%d vlan_proto=0x%04x vlan_tci=0x%04x protocol=0x%04x ip_summed=%d hash=0x%08x l4_hash=%d len=%u data_len=%u truesize=%u mac_header_valid=%d mac_header=%d nr_frags=%d gso_size=%d gso_type=%#x net_cookie=%llu",
 		  __get_str(name), __entry->napi_id, __entry->queue_mapping,
 		  __entry->skbaddr, __entry->vlan_tagged, __entry->vlan_proto,
 		  __entry->vlan_tci, __entry->protocol, __entry->ip_summed,
 		  __entry->hash, __entry->l4_hash, __entry->len,
 		  __entry->data_len, __entry->truesize,
 		  __entry->mac_header_valid, __entry->mac_header,
-		  __entry->nr_frags, __entry->gso_size, __entry->gso_type)
+		  __entry->nr_frags, __entry->gso_size,
+		  __entry->gso_type, __entry->net_cookie)
 );
 
 DEFINE_EVENT(net_dev_rx_verbose_template, napi_gro_frags_entry,
-- 
2.34.1


