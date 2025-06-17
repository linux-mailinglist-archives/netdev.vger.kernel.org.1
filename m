Return-Path: <netdev+bounces-198670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9620EADD03A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F2116DC8E
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68DE2E3AFE;
	Tue, 17 Jun 2025 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+CCH8/O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67042DBF42
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171358; cv=none; b=fSbyukcpZ41PcY74OSyMJ2mbaPhjMNQhyAInXYBZyijf8Aa8UGOmES1qtWrMqroqXOV64TyzSAWcl3UV4H2uAvGHvGZ43is6qx4yOkJcfYMeF3H82rzYG2EGlDShEBy5FwffNkBMEYye4y4ep9GivvFoBnSAyvSRBxhAbxM9ziA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171358; c=relaxed/simple;
	bh=IegmjPvlK+2eaqca8FHEsJE1BBpU5tDViSJR5RESvaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJf0lhLkruyyBOVCMHM6ZVLdJIibjU924ubP2/O9EIuHp1MDjf4rWDHjXhImCk/QPAvVFQt2lyZ3qIn8STtAr2XNdG/CAne8+X+wip6iutweFCEjW85zVOejJ7fQ/wLBKlexJKYlAEBmLDzpkoBTgoFJAtrfdFI6ZEdnXD4d4y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+CCH8/O; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-adb47e0644dso172541666b.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 07:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750171354; x=1750776154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNcjhNHLJgms0N+J8LYYR17b67MpXyJeE5sqGVi01Wc=;
        b=T+CCH8/OVb0+L0UwkTCytyzZzHVeuTnezrfwyOKFE84J+08GFGlOJ1jD02dpIUvyQ4
         Cfmjqn/YwMlHJV2xPG9lHhUcm4GZINb7w/4fACKEmAC1r5fB9nwa0CyH+JjHPQGVN8yE
         PZFtxBkw2gy4xg08FfmDwSPZWGelapOimC811w8GyWXzAiGd1XnHQqZ0FgTeMaopMEYS
         tiH1mKIzjEWxWvwKpmMEDX49RZTdhQNrvwgpQzbDQuobZ5T6Qsa4/reNA5xIMYCEHDO1
         P60yuXbqiqJ2YHsV6ZaY8LRc5KlSs9sB74xqhbFyhnQj37sOmpn+ve3CGZ4Bggr7YHU3
         XsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750171354; x=1750776154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNcjhNHLJgms0N+J8LYYR17b67MpXyJeE5sqGVi01Wc=;
        b=WNSm0WNADeFtrc86KA0XW2fLNasbTw+I5ryCDUobaoiWfhuFDiXxHwfYzopItHjmOO
         dpsMXP01eBfTXQrIoeuQufpWlsD4gS8/D02el50Q0IN+mG3LWwsBWnHX4maFPd+B4ZH+
         EB3LAXBKuUjPUgxWztKz5oMztFx+hG2DwGqBiuY4eUvZwQzg/RC+lczyor0zYCPArYnG
         tVQ6BbIQtC6tlul0qLrj4C5aTLsIGlM4wEsSbpv/GQKJhb0bhrKxZMbk8/9aMEcuxVjc
         twXUiUt4cpLMJOIchEKrd+TjTJmK7lXfcGVJItrYs74Z1TfWu8LvAfZUE7+7JNWpgWvK
         baqA==
X-Gm-Message-State: AOJu0YxJalEINS6rPCKCh4QepkrFkrf7A6skd0ij2hPFfXur+G+LWHlE
	s9igyrBQewP89W3eC8S13LnJmzf1jRnY1H8yfrjq5WFgGZWzXidGDQT2
X-Gm-Gg: ASbGncu8d+4yA3gAHUkK7HgacGj5LSKIGQ4dYRktUtCcSCcRN1WRdBzQeHPkMWFd7Sb
	FagWpBtBJGe+gG3cXlehNhoU/MtD1lf3Nq1ENHr1Rn19mGdKbhPKehjxpB/IWA6K+i6xARjVBhy
	ppp3FMfMJh6Y3A6AlWaxt3NA7eCF/HCH5rUzZlbDhPsVc11Mo1vlsHYYaIJI5LhdJDKlf5oLMD1
	OmLMydy1cbnB2D0U2UjC6dc2jwUCHVT/TsQnoDBH1kGZdBOnnrSGpmoG8HeiTTmG/kePOA8e0Nv
	RJiRmjJDaC7uzsYrRTwdPlHgnuLCaHjJxH4IsQBkVktvyRST5jtCisufjc1GpTjoRalDLEZuqiJ
	gMpePbTQItPf0
X-Google-Smtp-Source: AGHT+IFHUB3RKo29gxOq9e6hD8jdgO3UuDSFuRSLSxb5UigTDuC4viIQv/8DzWxEnLRr5nGmIQ13Sg==
X-Received: by 2002:a17:906:c143:b0:ad5:2d5d:2069 with SMTP id a640c23a62f3a-adf9c458189mr1376549166b.13.1750171353956;
        Tue, 17 Jun 2025 07:42:33 -0700 (PDT)
Received: from localhost (tor-exit-56.for-privacy.net. [185.220.101.56])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-adf37467a91sm781703366b.166.2025.06.17.07.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:42:33 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
X-Google-Original-From: Maxim Mikityanskiy <maxim@isovalent.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH RFC net-next 02/17] net/ipv6: Drop HBH for BIG TCP on TX side
Date: Tue, 17 Jun 2025 16:40:01 +0200
Message-ID: <20250617144017.82931-3-maxim@isovalent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617144017.82931-1-maxim@isovalent.com>
References: <20250617144017.82931-1-maxim@isovalent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

BIG TCP IPv6 inserts a hop-by-hop extension header to indicate the real
IPv6 payload length when it doesn't fit into the 16-bit field in the
IPv6 header itself. While it helps tools parse the packet, it also
requires every driver that supports TSO and BIG TCP to remove this
8-byte extension header. It might not sound that bad until we try to
apply it to tunneled traffic. Currently, the drivers don't attempt to
strip HBH if skb->encapsulation = 1. Moreover, trying to do so would
require dissecting different tunnel protocols and making corresponding
adjustments on case-by-case basis, which would slow down the fastpath
(potentially also requiring adjusting checksums in outer headers).

At the same time, BIG TCP IPv4 doesn't insert any extra headers and just
calculates the payload length from skb->len, significantly simplifying
implementing BIG TCP for tunnels.

Stop inserting HBH when building BIG TCP GSO SKBs.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 include/linux/ipv6.h  |  1 -
 net/ipv6/ip6_output.c | 20 +++-----------------
 2 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index bb53eca1f218..87d3723ce520 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -174,7 +174,6 @@ struct inet6_skb_parm {
 #define IP6SKB_L3SLAVE         64
 #define IP6SKB_JUMBOGRAM      128
 #define IP6SKB_SEG6	      256
-#define IP6SKB_FAKEJUMBO      512
 #define IP6SKB_MULTIPATH      1024
 };
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 7bd29a9ff0db..446de2f37d8c 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -185,8 +185,7 @@ ip6_finish_output_gso_slowpath_drop(struct net *net, struct sock *sk,
 static int ip6_finish_output_gso(struct net *net, struct sock *sk,
 				 struct sk_buff *skb, unsigned int mtu)
 {
-	if (!(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
-	    !skb_gso_validate_network_len(skb, mtu))
+	if (!skb_gso_validate_network_len(skb, mtu))
 		return ip6_finish_output_gso_slowpath_drop(net, sk, skb, mtu);
 
 	return ip6_finish_output2(net, sk, skb);
@@ -273,8 +272,6 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	struct dst_entry *dst = skb_dst(skb);
 	struct net_device *dev = dst->dev;
 	struct inet6_dev *idev = ip6_dst_idev(dst);
-	struct hop_jumbo_hdr *hop_jumbo;
-	int hoplen = sizeof(*hop_jumbo);
 	unsigned int head_room;
 	struct ipv6hdr *hdr;
 	u8  proto = fl6->flowi6_proto;
@@ -282,7 +279,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	int hlimit = -1;
 	u32 mtu;
 
-	head_room = sizeof(struct ipv6hdr) + hoplen + LL_RESERVED_SPACE(dev);
+	head_room = sizeof(struct ipv6hdr) + LL_RESERVED_SPACE(dev);
 	if (opt)
 		head_room += opt->opt_nflen + opt->opt_flen;
 
@@ -309,19 +306,8 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 					     &fl6->saddr);
 	}
 
-	if (unlikely(seg_len > IPV6_MAXPLEN)) {
-		hop_jumbo = skb_push(skb, hoplen);
-
-		hop_jumbo->nexthdr = proto;
-		hop_jumbo->hdrlen = 0;
-		hop_jumbo->tlv_type = IPV6_TLV_JUMBO;
-		hop_jumbo->tlv_len = 4;
-		hop_jumbo->jumbo_payload_len = htonl(seg_len + hoplen);
-
-		proto = IPPROTO_HOPOPTS;
+	if (unlikely(seg_len > IPV6_MAXPLEN))
 		seg_len = 0;
-		IP6CB(skb)->flags |= IP6SKB_FAKEJUMBO;
-	}
 
 	skb_push(skb, sizeof(struct ipv6hdr));
 	skb_reset_network_header(skb);
-- 
2.49.0


