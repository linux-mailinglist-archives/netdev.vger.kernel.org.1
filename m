Return-Path: <netdev+bounces-223604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FC1B59AD9
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C581BC0B21
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C972A352092;
	Tue, 16 Sep 2025 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCVLr8ii"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7E235207A
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034141; cv=none; b=NNr2l7nuijI9hEXISbeYgLpS2Tg4wk1EPEgTk8A+mwumsH7pO1Xole0adVomP72DUQJ8SV7VsBDyP9nvikcmJg+xJJt7CjRENgKcGsZwj2eggLAww6Nu1SHC8/PHaCCRp1ZhlC22NXwH3ySWMTWQnJLHEu0feKJgk+PUEpHmFLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034141; c=relaxed/simple;
	bh=USAi/gOC4Gd3dmiYQ7sYFTZdRsnH0JxGjY8OHY6vf8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eFE2FMm+Ao/C8wb4lWUrPw8eeGyeB4APRXm3rekUb11bRba/S2SKOkFjVkGHqpMsrTFZfSs7krOJ/bn6oGgrgARVEMsTwDQKPeci0eQB9HJL6TAyKwLGiU+G7HpNNZCjnf03NFx/gAZFsH0CukFpkA7DegfuXRWcJOZOyKKpq30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCVLr8ii; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so53409615e9.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758034138; x=1758638938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWo6LZdJOajM7eDBZoJDuM0DMuX04TB4v3UVMrne7AM=;
        b=GCVLr8iisDMCTRWy3bfAw70+I+y+jo2+h0RgU7NP9GiNyD1iormL7M3DVerKAafaUg
         lbiZ2nnmsFMwejBwq07nZ4FIruztkH4BW7wUMcA9+NJiOcqw30XitYmQSvG0kL9yjWmv
         BmZPLY3HqPZHTR6TjEApbS3qNtvtefieAXhMt7B25QQEQPrUNAyHQmzqNo4xubwY89X5
         SksrQH07lQUBxB2MFvlNESHxg2y/oKeYHCMPXur6QfwNtFgh232mY9Shtw6kItmf5pmQ
         zI+Rav/I+tdKaUYbPpIarKmDTHHfhU7ZjGv/yMS8kA7L7sAVj/o2GN5ZU9D02ryntlOi
         GY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034138; x=1758638938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWo6LZdJOajM7eDBZoJDuM0DMuX04TB4v3UVMrne7AM=;
        b=GlWUezngl4dNQvsXj40w/E/c8JrRoJ2pg/P96ji1y/A4lRr1ftIk5+dCcSZr+tyatf
         WNSOlogizn6wOaEKVnYDfd5Yc9mqQW09pADYZTZ+SfNgiltvESipH5/qlTv8bRDn0FTP
         dfI2pXXbnUu/2x0PBQM2WsYlwWAuovLmAyngPXtcCD/xgBwXFUWqoKSh/9pfb6XM3CZD
         Q0DnR6Up29vokcMW6IuuEp4OdQ70TPCzllpMb45dCSnzvyUc7xCraFfhsLO1LqSxTKV9
         jTsoH6IXIB0k8qrTSvh1fOOn7Gx0vX3YBYHjNuwloQcC9BOTwWKy4OM1yw1iLizNQLwC
         LRxg==
X-Gm-Message-State: AOJu0Yy/DBOADWKQGiLqjNIeLcAU2kQHkI/MoX/tseUNQKYOiT7YzOo1
	cnPsAMZnHzuKOVEQgIpcMyvB+TcpbZM++two9tpt4EgHJwbcb0m3GpfhYO1aeA==
X-Gm-Gg: ASbGnctfYjsqjHgxhbHTn+7zbgR+TEzQOi35VVHT+Pgk59Rb/RpmYKGb8ahjRpqFSgs
	5dg2GD8dKmr5BGXGRLaWj0Qn+/0XlYtixHrkT9AkpEp4Bj3NtNLo9gWYaFS4oiptLGZJGSMjfxl
	duU6YLzFbVE/JkikyqK4dWf0lZ10ZvxrN3ATG1jZyaPbbkLHNlhSs1P7AoLyJWlUk1srU4rh1p8
	TOQnbOE3c+bR3P6pl15e6TGXpkzWdRxBt53pFM4IAkqxjeMwxeeN3E3ejAXtoVJVyJSntmuXLuv
	TywsAwZiL6cxyTg2l1WqWlQccI7+zY/zsMKHp2Ca+Fa8+FFn9PetkxlPrbtf5nr1exyVKrhQEbg
	Pw2eIWprY6NmjN5xxSjufKDv62gE4+IGlBz42Xedi0g/g
X-Google-Smtp-Source: AGHT+IECQDpx8uDkJukMSlAaZlGuYXrMM/nUC/I/0i4Je3s1LVzYNcv4ugUXJlo/JPsgHamnIdfbyw==
X-Received: by 2002:a05:6000:178b:b0:3ec:7ff4:23c5 with SMTP id ffacd0b85a97d-3ec7ff42654mr3571534f8f.26.1758034137998;
        Tue, 16 Sep 2025 07:48:57 -0700 (PDT)
Received: from localhost ([45.10.155.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e01575fadsm227287445e9.6.2025.09.16.07.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:48:57 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	corbet@lwn.net,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	dsahern@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	florian.fainelli@broadcom.com,
	alexander.duyck@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v6 2/5] net: gro: only merge packets with incrementing or fixed outer ids
Date: Tue, 16 Sep 2025 16:48:38 +0200
Message-Id: <20250916144841.4884-3-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250916144841.4884-1-richardbgobert@gmail.com>
References: <20250916144841.4884-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only merge encapsulated packets if their outer IDs are either
incrementing or fixed, just like for inner IDs and IDs of non-encapsulated
packets.

Add another ip_fixedid bit for a total of two bits: one for outer IDs (and
for unencapsulated packets) and one for inner IDs.

This commit preserves the current behavior of GSO where only the IDs of the
inner-most headers are restored correctly.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 include/net/gro.h      | 26 +++++++++++---------------
 net/ipv4/tcp_offload.c |  5 ++++-
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 87c68007f949..e7997a9fb30b 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -75,7 +75,7 @@ struct napi_gro_cb {
 		u8	is_fou:1;
 
 		/* Used to determine if ipid_offset can be ignored */
-		u8	ip_fixedid:1;
+		u8	ip_fixedid:2;
 
 		/* Number of gro_receive callbacks this packet already went through */
 		u8 recursion_counter:4;
@@ -442,29 +442,26 @@ static inline __wsum ip6_gro_compute_pseudo(const struct sk_buff *skb,
 }
 
 static inline int inet_gro_flush(const struct iphdr *iph, const struct iphdr *iph2,
-				 struct sk_buff *p, bool outer)
+				 struct sk_buff *p, bool inner)
 {
 	const u32 id = ntohl(*(__be32 *)&iph->id);
 	const u32 id2 = ntohl(*(__be32 *)&iph2->id);
 	const u16 ipid_offset = (id >> 16) - (id2 >> 16);
 	const u16 count = NAPI_GRO_CB(p)->count;
 	const u32 df = id & IP_DF;
-	int flush;
 
 	/* All fields must match except length and checksum. */
-	flush = (iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF));
-
-	if (flush | (outer && df))
-		return flush;
+	if ((iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF)))
+		return true;
 
 	/* When we receive our second frame we can make a decision on if we
 	 * continue this flow as an atomic flow with a fixed ID or if we use
 	 * an incrementing ID.
 	 */
 	if (count == 1 && df && !ipid_offset)
-		NAPI_GRO_CB(p)->ip_fixedid = true;
+		NAPI_GRO_CB(p)->ip_fixedid |= 1 << inner;
 
-	return ipid_offset ^ (count * !NAPI_GRO_CB(p)->ip_fixedid);
+	return ipid_offset ^ (count * !(NAPI_GRO_CB(p)->ip_fixedid & (1 << inner)));
 }
 
 static inline int ipv6_gro_flush(const struct ipv6hdr *iph, const struct ipv6hdr *iph2)
@@ -479,7 +476,7 @@ static inline int ipv6_gro_flush(const struct ipv6hdr *iph, const struct ipv6hdr
 
 static inline int __gro_receive_network_flush(const void *th, const void *th2,
 					      struct sk_buff *p, const u16 diff,
-					      bool outer)
+					      bool inner)
 {
 	const void *nh = th - diff;
 	const void *nh2 = th2 - diff;
@@ -487,19 +484,18 @@ static inline int __gro_receive_network_flush(const void *th, const void *th2,
 	if (((struct iphdr *)nh)->version == 6)
 		return ipv6_gro_flush(nh, nh2);
 	else
-		return inet_gro_flush(nh, nh2, p, outer);
+		return inet_gro_flush(nh, nh2, p, inner);
 }
 
 static inline int gro_receive_network_flush(const void *th, const void *th2,
 					    struct sk_buff *p)
 {
-	const bool encap_mark = NAPI_GRO_CB(p)->encap_mark;
 	int off = skb_transport_offset(p);
 	int flush;
 
-	flush = __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->network_offset, encap_mark);
-	if (encap_mark)
-		flush |= __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->inner_network_offset, false);
+	flush = __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->network_offset, false);
+	if (NAPI_GRO_CB(p)->encap_mark)
+		flush |= __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->inner_network_offset, true);
 
 	return flush;
 }
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index e6612bd84d09..1949eede9ec9 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -471,6 +471,7 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
 	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
 	struct tcphdr *th = tcp_hdr(skb);
+	bool is_fixedid;
 
 	if (unlikely(NAPI_GRO_CB(skb)->is_flist)) {
 		skb_shinfo(skb)->gso_type |= SKB_GSO_FRAGLIST | SKB_GSO_TCPV4;
@@ -484,8 +485,10 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
 				  iph->daddr, 0);
 
+	is_fixedid = (NAPI_GRO_CB(skb)->ip_fixedid >> skb->encapsulation) & 1;
+
 	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4 |
-			(NAPI_GRO_CB(skb)->ip_fixedid * SKB_GSO_TCP_FIXEDID);
+			(is_fixedid * SKB_GSO_TCP_FIXEDID);
 
 	tcp_gro_complete(skb);
 	return 0;
-- 
2.36.1


