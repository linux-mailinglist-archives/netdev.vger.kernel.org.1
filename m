Return-Path: <netdev+bounces-225152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DA9B8F9A0
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 10:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E6718A1269
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 08:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745451862A;
	Mon, 22 Sep 2025 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRmbwzQF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989A727F749
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530488; cv=none; b=cnm8x/Spi1MZPz+FXBb5OvgkSCbYRYy6iXt91Ps7SewH7sbxDVQ2yfmWZSgH6jXU3TFPfDdwz+11xGNiLxfUIRWRIf1Vf1o3SPcKGOz5/houerjYUpQFr1/08c3eNT9Flwkn9vc0CrFLQ71HzJemSWtIPQuR9mXFNe7rpkmkcLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530488; c=relaxed/simple;
	bh=USAi/gOC4Gd3dmiYQ7sYFTZdRsnH0JxGjY8OHY6vf8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PDz7FbAxbf++Tf9J7E1BOAj/bDuz2/bC/WuOWq9RwVDkiVprIWQyPGwf3T3s+kl2eOffFzznQH1iy5quHAO2wa7WKPD7GtF8+xTZ4NwMW49IqAN4FpnU4hSMfyZAhF781AoaXI44+E2TxK6GyfGCuOcvqMYFT6I2NBXW9XfSrJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRmbwzQF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dfb8e986aso36893845e9.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 01:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758530484; x=1759135284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWo6LZdJOajM7eDBZoJDuM0DMuX04TB4v3UVMrne7AM=;
        b=kRmbwzQFbEZUwO67OupfT20Ah6mq0KPaXpqhdXt51cixFCVVV8lQM6JW/soHcM93Jg
         UFsqtg6LxXUBh2FnMbzZIV+KiicwTcSFS2/f8SmtUDUzx7J8vkkYztniJ5h17KyPmEqB
         Y/pEAXa0ZacovWgjHMxbCnITf+Spn7w21I5zokwDHxxnyXT8nomTvMT8Ua/bS+2lWLpq
         zILZYVJZAhocYwc2jG3vBKX1kO1fOYF2aMDYPtSgvcgZaJC0yLfKq1lBGJzHnRGphWxn
         cv+LNaxYiFypfU5i7vjWPkujww3PVFnK2fxH1VrOPmyPquQGeE3+kZcv3VMT8fU/FxM7
         ClJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758530484; x=1759135284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWo6LZdJOajM7eDBZoJDuM0DMuX04TB4v3UVMrne7AM=;
        b=UGJCyNYIdPBex75Pn0JMNOdchFLFsPEfFfNj1HDqyakM69aHdDpFr7+1Yje88/Z1pF
         9xdj626uTF9X/SGbJAFniTzJGUQW/9RLDdsKLwEeUMV3lX+QEKX4+w4ypclRrRLk0IPd
         enVd1a9QJwIUSiMTFgcW9rcBz0jqAJjXqYARzP2oC8DSJtwXlbHpcf8qJ1tQUk+JoeDj
         Bhf9GPHp7hSeCJam532icBhv+o6OWZ90GNnTwpqyhNnPeIt02wZqKr2hQEU5nlIafHsd
         2j8YM81FukChTjfymEVC+bxayzBBkQ/SVu6T4RxwMqb3vPrmHa9u0v9m1fe0iKzyrHsO
         b/Kg==
X-Gm-Message-State: AOJu0YyLbAnd0bP3eaIvnTVnN3SzNpIyxv8tz/nqLE51XmAJHksbhbbE
	ejhxaQ8HPV+G0s9CJ+DtQaZe4VhB3f22Q5AXmd0TJizk5IAWnvu7kmc6vHTfbQ==
X-Gm-Gg: ASbGncudMa8VjEBrTi/1oh32XYAOFfX8zO0fN1b09uLVg++FBU5MpyNmc8io8DaxRWE
	zvhGTnQ6Ui0RPG7SkhBxrXDbj56D/OHYpSxLdxTgUlTH2M/4L/JQ/uqrh7k8SNAplpK2zOJXzr/
	H1KeuB4g2vIzEkiCMA1TO4B75wWNYWW+qXbIwHyTJYVXPC+Ou7T5WiIbxewKbgjXXzsZuxhhDPk
	Z8qwvtsrcgEVOCa+0fDLXNZ62wJbpMRD957rDjyVZjFFXo8sYFRmW8N/VQprqlzPiSquJ1UbEYn
	grzifGN3BqILsOU+EOEoiGYBz4oc14LytVFxP6DY2x7QYzk8j2K7xeQpX9uTFVOBF9nFEgWPpVl
	2weLtrQw5tmWamN1a2PkfwQo=
X-Google-Smtp-Source: AGHT+IFrGiXGA7LHSS3EIQjiUfLhqP2WxXsbFkQVDxEHVdRpBujBxAxj+ebAXjLWlrRcB+JKw7SlRA==
X-Received: by 2002:a05:600c:35ca:b0:45d:d0d6:223f with SMTP id 5b1f17b1804b1-4682c93f43emr132704465e9.0.1758530483632;
        Mon, 22 Sep 2025 01:41:23 -0700 (PDT)
Received: from localhost ([45.10.155.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464eadd7e11sm203246715e9.0.2025.09.22.01.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 01:41:23 -0700 (PDT)
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
Subject: [PATCH net-next v7 2/5] net: gro: only merge packets with incrementing or fixed outer ids
Date: Mon, 22 Sep 2025 10:41:00 +0200
Message-Id: <20250922084103.4764-3-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250922084103.4764-1-richardbgobert@gmail.com>
References: <20250922084103.4764-1-richardbgobert@gmail.com>
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


