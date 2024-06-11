Return-Path: <netdev+bounces-102450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 407C4902FB7
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 06:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D771F239EC
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 04:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D1017082E;
	Tue, 11 Jun 2024 04:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fT6X6U6K"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BDE14290
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 04:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718081922; cv=none; b=aGr2i3OngmpNuJYqepMywyGqvuLvwTcOoQYenjN97kgoakficu357JXFGqG2NHrZj9J7Z32oYPQoUIcUGX9oAm4pNVSn+wHax+7AZU0AZEhCRh+mFWlQ0McdWR8tBkTJ9jNB/bYG2AU7yxSM79MYXrsu+pR46Es/0vv/FIp+Srk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718081922; c=relaxed/simple;
	bh=6RGwrNaaHr3z9VGDfzp14bTAGG202zfRdOc59P8l/S0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nU37h9tfW3pgY5kZSTUsV8ghDkt/McFhoqQr8RM5pK1fd1+xQdOW2apoW6RpTDBghV1p27t3GIgclS02Xwef7/1+XnAv63kTxk7RQ9XX3YfxhqcAAGkJ9AxIHN7X3dsQmcXu9vaIsXKWd4HADWtCV9OnoC56DaeJdzig1UbFOdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fT6X6U6K; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718081912; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UzqPJmuJBJVSGrRTHXc3s1XMNZUucZQwNji/b+ux6XE=;
	b=fT6X6U6KXUByXWgGgp0qsYp2zv6124g+7hlGpLjg2vuCKBm977NY2vApw96TtuERWIChr5J/oaSr0DPygRARiF6OeR8UUPXm38AUNlv64Loxo2SDdDr96nOizFFtWv2UFVHToavyT76K3gu/vAkSreVhCT2DW5BOfqOt5+gRXRA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W8F5RRb_1718081910;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W8F5RRb_1718081910)
          by smtp.aliyun-inc.com;
          Tue, 11 Jun 2024 12:58:31 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com,
	dust.li@linux.alibaba.com
Subject: [PATCH net-next] tcp: Add tracepoint for rxtstamp coalescing
Date: Tue, 11 Jun 2024 12:58:30 +0800
Message-Id: <20240611045830.67640-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During tcp coalescence, rx timestamps of the former skb ("to" in
tcp_try_coalesce), will be lost. This may lead to inaccurate
timestamping results if skbs come out of order.

Here is an example.
Assume a message consists of 3 skbs, namely A, B, and C. And these skbs
are processed by tcp in the following order:
A -(1us)-> C -(1ms)-> B
If C is coalesced to B, the final rx timestamps of the message will be
those of C. That is, the timestamps show that we received the message
when C came (including hardware and software). However, we actually
received it 1ms later (when B came).

With the added tracepoint, we can recognize such cases and report them
if we want.

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 include/trace/events/tcp.h | 61 ++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_input.c       |  2 ++
 2 files changed, 63 insertions(+)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 49b5ee091cf6..c4219ca2bcf0 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -411,6 +411,67 @@ TRACE_EVENT(tcp_cong_state_set,
 		  __entry->cong_state)
 );
 
+/*
+ * When called, TCP_SKB_CB(from)->has_rxtstamp must be true, but TCP_SKB_CB(to)->has_rxtstamp may
+ * not. So has_rxtstamp is checked before reading timestamps of skb "to".
+ */
+TRACE_EVENT(tcp_rxtstamp_coalesce,
+
+	TP_PROTO(const struct sock *sk, const struct sk_buff *to, const struct sk_buff *from),
+
+	TP_ARGS(sk, to, from),
+
+	TP_STRUCT__entry(
+		__field(__u16, sport)
+		__field(__u16, dport)
+		__field(__u16, family)
+		__array(__u8, saddr, 4)
+		__array(__u8, daddr, 4)
+		__array(__u8, saddr_v6, 16)
+		__array(__u8, daddr_v6, 16)
+		__field(__u64, to_tstamp)
+		__field(__u64, to_hwtstamp)
+		__field(__u64, from_tstamp)
+		__field(__u64, from_hwtstamp)
+	),
+
+	TP_fast_assign(
+		const struct inet_sock *inet = inet_sk(sk);
+		__be32 *p32;
+
+		__entry->sport = ntohs(inet->inet_sport);
+		__entry->dport = ntohs(inet->inet_dport);
+		__entry->family = sk->sk_family;
+
+		p32 = (__be32 *) __entry->saddr;
+		*p32 = inet->inet_saddr;
+
+		p32 = (__be32 *) __entry->daddr;
+		*p32 = inet->inet_daddr;
+
+		TP_STORE_ADDRS(__entry, inet->inet_saddr, inet->inet_daddr,
+			       sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
+
+		if (TCP_SKB_CB(to)->has_rxtstamp) {
+			__entry->to_tstamp = to->tstamp;
+			__entry->to_hwtstamp = skb_shinfo(to)->hwtstamps.hwtstamp;
+		} else {
+			__entry->to_tstamp = 0;
+			__entry->to_hwtstamp = 0;
+		}
+
+		__entry->from_tstamp = from->tstamp;
+		__entry->from_hwtstamp = skb_shinfo(from)->hwtstamps.hwtstamp;
+	),
+
+	TP_printk("family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c to_tstamp=%llu to_hwtstamp=%llu from_tstamp=%llu from_hwtstamp=%llu",
+		  show_family_name(__entry->family),
+		  __entry->sport, __entry->dport, __entry->saddr, __entry->daddr,
+		  __entry->saddr_v6, __entry->daddr_v6,
+		  __entry->to_tstamp, __entry->to_hwtstamp,
+		  __entry->from_tstamp, __entry->from_hwtstamp)
+);
+
 #endif /* _TRACE_TCP_H */
 
 /* This part must be outside protection */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index eb187450e4d7..7024c6ba20ae 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4827,6 +4827,8 @@ static bool tcp_try_coalesce(struct sock *sk,
 	TCP_SKB_CB(to)->tcp_flags |= TCP_SKB_CB(from)->tcp_flags;
 
 	if (TCP_SKB_CB(from)->has_rxtstamp) {
+		trace_tcp_rxtstamp_coalesce(sk, to, from);
+
 		TCP_SKB_CB(to)->has_rxtstamp = true;
 		to->tstamp = from->tstamp;
 		skb_hwtstamps(to)->hwtstamp = skb_hwtstamps(from)->hwtstamp;
-- 
2.32.0.3.g01195cf9f


