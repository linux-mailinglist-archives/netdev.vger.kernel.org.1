Return-Path: <netdev+bounces-243816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6431CCA7E44
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 15:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 742AC307CA33
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 14:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600F730E85C;
	Fri,  5 Dec 2025 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UThSoObJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AD33191D2
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764943553; cv=none; b=lLQ25TG18o9lpuaZDAcwB3qCWngGOaaK5V//uuhu8B7fEkYzvZc7ZVZaIr7dfCjQKX/oRTfpGFdjzuT2jQ+VzjO4ZvVHA8kphRjYcCKCo98/Ot1airf9mKCKmRQLfIJ4hb2OVhillXTuJ7a4aiYpt97hIF++gZvDUYzgdKp4iL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764943553; c=relaxed/simple;
	bh=1ebN/mub/XGHQpA6c9xS82G7qUSI+5BmVC6EoVhV5yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6Mo1i+kQvPXcFiUEsf8oXiHrrne8xfE2OkkilGKPrykPikS8cCfXaDtAFv/FuvglpZBnvgAfr6AAcsHoonHJD6maGgHDZR5q7v7EsO1ALI7ZMloDZbLPKy8OfmtzKvvS1LfBaC4Y8duIBkdjHgueqtPZRV7ZN1VIvGMJxF9WQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UThSoObJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764943548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jd2csdLvIN741lGvpo5iBtdxkbN3obvlSf8w+gqrvi4=;
	b=UThSoObJdnt0wA9px/Uv34Vs9L6Azs/Tu6yTIqcgw0hvqQOvJH+4s5C5uytzU1LqP4YDJJ
	V7bjsYLKjnzZ5l9aKMlLCHTvKcfCvrSzf0ifM9/T7NUVqcTM5LMXzSh0ZaQEyyS80PwAX9
	zzar1QNxMdR3EjC6uEj7Ios9feVfplw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-JChz4epgNR-aY9guZX2D9A-1; Fri,
 05 Dec 2025 09:04:28 -0500
X-MC-Unique: JChz4epgNR-aY9guZX2D9A-1
X-Mimecast-MFC-AGG-ID: JChz4epgNR-aY9guZX2D9A_1764943466
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B520195606F;
	Fri,  5 Dec 2025 14:04:26 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B00A19560BE;
	Fri,  5 Dec 2025 14:04:23 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>
Subject: [RFC PATCH 1/2] net: gro: avoid relaying on skb->transport_header at receive time
Date: Fri,  5 Dec 2025 15:03:30 +0100
Message-ID: <98a7e20010265e3ebf9d7e6d6dfb7339d5db7b99.1764943231.git.pabeni@redhat.com>
In-Reply-To: <cover.1764943231.git.pabeni@redhat.com>
References: <cover.1764943231.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Currently {tcp,udp}_gro_receive relay on the gro network stage setting
the correct transport header offset for all the skbs held by the GRO
engine.

Such assumption is not necessary, as the code can instead leverage the
offset already available for the currently processed skb. Add a couple
of helpers to for readabilty' sake.

As skb->transport_header lays on a different cacheline wrt skb->data,
this should save a cacheline access for each packet aggregation.
Additionally this will make the next patch possible.

Note that the compiler (gcc 15.2.1) does inline the tcp_gro_lookup()
call in tcp_gro_receive(), so the additional argument is only relevant
for the fraglist case.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/gro.h        | 26 ++++++++++++++++++++++++++
 include/net/tcp.h        |  3 ++-
 net/ipv4/tcp_offload.c   | 15 ++++++++-------
 net/ipv4/udp_offload.c   |  4 ++--
 net/ipv6/tcpv6_offload.c |  2 +-
 5 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index b65f631c521d..fdb9285ab117 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -420,6 +420,18 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 				struct udphdr *uh, struct sock *sk);
 int udp_gro_complete(struct sk_buff *skb, int nhoff, udp_lookup_t lookup);
 
+/* Return the skb hdr corresponding to the specified skb2 hdr.
+ * skb2 is held in the gro engine, i.e. its headers are in the linear part.
+ */
+static inline const void *
+skb_gro_header_from(const struct sk_buff *skb, const struct sk_buff *skb2,
+		    const void *hdr2)
+{
+	size_t offset = (unsigned char *)hdr2 - skb2->data;
+
+	return skb->data + offset;
+}
+
 static inline struct udphdr *udp_gro_udphdr(struct sk_buff *skb)
 {
 	struct udphdr *uh;
@@ -432,6 +444,13 @@ static inline struct udphdr *udp_gro_udphdr(struct sk_buff *skb)
 	return uh;
 }
 
+static inline const struct udphdr *
+udp_gro_udphdr_from(const struct sk_buff *skb, const struct sk_buff *skb2,
+		    const struct udphdr *uh)
+{
+	return (const struct udphdr *)skb_gro_header_from(skb, skb2, uh);
+}
+
 static inline __wsum ip6_gro_compute_pseudo(const struct sk_buff *skb,
 					    int proto)
 {
@@ -620,4 +639,11 @@ static inline struct tcphdr *tcp_gro_pull_header(struct sk_buff *skb)
 	return th;
 }
 
+static inline const struct tcphdr *
+tcp_gro_header_from(const struct sk_buff *skb, const struct sk_buff *skb2,
+		    const struct tcphdr *th)
+{
+	return (const struct tcphdr *)skb_gro_header_from(skb, skb2, th);
+}
+
 #endif /* _NET_GRO_H */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 0deb5e9dd911..a4c239daf2ea 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2313,7 +2313,8 @@ void tcp_v4_destroy_sock(struct sock *sk);
 
 struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 				netdev_features_t features);
-struct sk_buff *tcp_gro_lookup(struct list_head *head, struct tcphdr *th);
+struct sk_buff *tcp_gro_lookup(struct list_head *head, struct sk_buff *skb,
+			       struct tcphdr *th);
 struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 				struct tcphdr *th);
 INDIRECT_CALLABLE_DECLARE(int tcp4_gro_complete(struct sk_buff *skb, int thoff));
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index fdda18b1abda..fa36686df6d7 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -261,16 +261,17 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	return segs;
 }
 
-struct sk_buff *tcp_gro_lookup(struct list_head *head, struct tcphdr *th)
+struct sk_buff *tcp_gro_lookup(struct list_head *head, struct sk_buff *skb,
+			       struct tcphdr *th)
 {
-	struct tcphdr *th2;
+	const struct tcphdr *th2;
 	struct sk_buff *p;
 
 	list_for_each_entry(p, head, list) {
 		if (!NAPI_GRO_CB(p)->same_flow)
 			continue;
 
-		th2 = tcp_hdr(p);
+		th2 = tcp_gro_header_from(p, skb, th);
 		if (*(u32 *)&th->source ^ *(u32 *)&th2->source) {
 			NAPI_GRO_CB(p)->same_flow = 0;
 			continue;
@@ -287,8 +288,8 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 {
 	unsigned int thlen = th->doff * 4;
 	struct sk_buff *pp = NULL;
+	const struct tcphdr *th2;
 	struct sk_buff *p;
-	struct tcphdr *th2;
 	unsigned int len;
 	__be32 flags;
 	unsigned int mss = 1;
@@ -298,11 +299,11 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 	len = skb_gro_len(skb);
 	flags = tcp_flag_word(th);
 
-	p = tcp_gro_lookup(head, th);
+	p = tcp_gro_lookup(head, skb, th);
 	if (!p)
 		goto out_check_final;
 
-	th2 = tcp_hdr(p);
+	th2 = tcp_gro_header_from(p, skb, th);
 	flush = (__force int)(flags & TCP_FLAG_CWR);
 	flush |= (__force int)((flags ^ tcp_flag_word(th2)) &
 		  ~(TCP_FLAG_FIN | TCP_FLAG_PSH));
@@ -398,7 +399,7 @@ static void tcp4_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
 	if (likely(!(skb->dev->features & NETIF_F_GRO_FRAGLIST)))
 		return;
 
-	p = tcp_gro_lookup(head, th);
+	p = tcp_gro_lookup(head, skb, th);
 	if (p) {
 		NAPI_GRO_CB(skb)->is_flist = NAPI_GRO_CB(p)->is_flist;
 		return;
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 19d0b5b09ffa..7048cb2a28a2 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -701,7 +701,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 {
 	struct udphdr *uh = udp_gro_udphdr(skb);
 	struct sk_buff *pp = NULL;
-	struct udphdr *uh2;
+	const struct udphdr *uh2;
 	struct sk_buff *p;
 	unsigned int ulen;
 	int ret = 0;
@@ -726,7 +726,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 		if (!NAPI_GRO_CB(p)->same_flow)
 			continue;
 
-		uh2 = udp_hdr(p);
+		uh2 = udp_gro_udphdr_from(p, skb, uh);
 
 		/* Match ports only, as csum is always non zero */
 		if ((*(u32 *)&uh->source != *(u32 *)&uh2->source)) {
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index effeba58630b..ae481bf95651 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -27,7 +27,7 @@ static void tcp6_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
 	if (likely(!(skb->dev->features & NETIF_F_GRO_FRAGLIST)))
 		return;
 
-	p = tcp_gro_lookup(head, th);
+	p = tcp_gro_lookup(head, skb, th);
 	if (p) {
 		NAPI_GRO_CB(skb)->is_flist = NAPI_GRO_CB(p)->is_flist;
 		return;
-- 
2.52.0


