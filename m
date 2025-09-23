Return-Path: <netdev+bounces-225605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9055B9611D
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168EE446678
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56AE1F8724;
	Tue, 23 Sep 2025 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eH6ofvrX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02D91E480
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635276; cv=none; b=f90HicvLmc20Q3f8HLdA/Nk/y4tNDi8Q78rW0JSumd2kHOjmn5KxznQMYIU6k7EvT4d6h4CMNJMs7WDxDKy6WNnefi0e4hzz+g9UfofiUbqL88k5nOnc3RyIsb9OtHKLsHNJIHIt1vnm4lI2Vy47NGy0yr9jYXYdV27yGS+H/7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635276; c=relaxed/simple;
	bh=2XEhzamOXNoHtGDmfcua3doePdk44InoVeWudWYt+Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtTdVRu8v5FAhlyYP/f2Y/3f3Pi1Ge7S2juTCPInNQHyKmPDwB1ZrDVNQ5S7WXLGfSkCowgiZ1WvyvoHvHl3FN63o7RSacZ/chZ26xyiV6UB/Zw89VPSk31RUgeq8WLBv1n8PnUOfzQak/Ogp1Z69hzcKs8oUWAVke1rbUkJims=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eH6ofvrX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3eebc513678so3842498f8f.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 06:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758635273; x=1759240073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmrSSDg07f4YlSSGCDoNLUP0oKTdFP4GAjUzPP3vhAs=;
        b=eH6ofvrXuk+dW0AccKWS/wTdWGBEES+shM3z74YN2KK1N86lOq4mQr6D+IT8Jmu6BP
         qBP1al4LOvEjUVSkiNZpju/5dUU/SHdk/56CIRxpfzT/XKe6+Lw7MMSr9F0RIa7End7z
         1jdMH0wD3RlUmdpl7use9vTd3ofXP3Gz+h25+VBWMWL3dhjCsiUQ0gjf4v52BjNClhM1
         4p48T9P92lLcCJos6ZvY62MOt/DV7jMmZRz2ZU9rmXB6lAz5zLl0/E1ussavVwryT1P3
         d9YvS/4zoZ12KbDwKD/GuT0jSchw6ls1Xv5qsj7UXuYA2TBhwezs0RUqFzKg9Y2wtUi3
         D//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758635273; x=1759240073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmrSSDg07f4YlSSGCDoNLUP0oKTdFP4GAjUzPP3vhAs=;
        b=mlLY34RfTuJF0QHRcBzjpZbHw/zd1nj2+t2DazwifV8BWsOZrVIE8yLTzCKGxIkQDM
         WoB3qXEoeBk/LzhmKKU1Vo+oDHrD5RjWsiY+HIsAkz2r3WJak//rGcxZ9Je7UZusjiCS
         EWRAMfoQ4Y1nspqC6SZjJWbBarqLnO3ZL/GC4bS61kI+/vGtQbncx3wj+rB3111bt9I1
         o6u1ArbN6fGwSMl3UQwJQKDgkGRXbiQVi+Ix/htnC/4Cyr6Cs1nVsGOeaNZyYXdbIHAE
         9qaB1ofJQroI7gfXyt9mqyWKN7WWFVFZHr7w9zthnLEJxVRdlU6yghvnsgsJaKKM/PXA
         L/ZA==
X-Gm-Message-State: AOJu0Yz6D0LqBgwISEM1R2KKCtiXI9p/iDBstCZfJ6D/vm+mSISbwKmn
	62pKSJjjW0T+XKNA+liTerID21I+yTWmwX39JIH5uRuS40aSi4BebgCJ
X-Gm-Gg: ASbGnctkZ2BdgMSrwSeuex9Hrsv0C6R9yyldIaqu3/EzRpUfUUW0Gxu3fob7yzGb5IT
	ipwjJJL/zdYBlbv0S/bcqgYTuGLPoETffB5H/KyJXLoxengof49DZtDRxb5rKKrgUKtZugAQ+Ir
	mnM/Fvu0k/O4O+CJ/znbhI6N8mONRRSnj0VvOSHcmGKyUZLmU/J1g5nBYAK1v2xQskkEF4A2cR6
	O5QzZ5ZnwyD9cZYMQBFfh6iIee26aixpJW8Out0PE1P3ave0UJr9GDlHpFNJ+5Djw1dOdilVGEB
	k0MPRgqXCoNeE3bQV27n5U08EJ1PBu0zeAf3t7NrWHId25iogc9Li4deZLVR3vO7hAQNu91UZgd
	Xgy785HdTgsXayS7Zojc8KZxP+clhTirpueasdUgShps1nT6l8XETtFDZMzY=
X-Google-Smtp-Source: AGHT+IGqgiX52nwf8jWgThz9NHfwkexw79/VZ61iPAk548QRJ/IwSv4yoKdfvHUjXYGCHc0KxXl+mg==
X-Received: by 2002:a05:6000:1a8f:b0:3ee:1521:95fc with SMTP id ffacd0b85a97d-405c6751d5fmr2380798f8f.14.1758635273017;
        Tue, 23 Sep 2025 06:47:53 -0700 (PDT)
Received: from localhost (tor.caspervk.net. [31.133.0.235])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee07407ccasm24069320f8f.15.2025.09.23.06.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:47:52 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	tcpdump-workers@lists.tcpdump.org,
	Guy Harris <gharris@sonic.net>,
	Michael Richardson <mcr@sandelman.ca>,
	Denis Ovsienko <denis@ovsienko.info>,
	Xin Long <lucien.xin@gmail.com>,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH net-next 02/17] net/ipv6: Drop HBH for BIG TCP on TX side
Date: Tue, 23 Sep 2025 16:47:27 +0300
Message-ID: <20250923134742.1399800-3-maxtram95@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250923134742.1399800-1-maxtram95@gmail.com>
References: <20250923134742.1399800-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

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
index 44c4b791eceb..116219ce2c3b 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -175,7 +175,6 @@ struct inet6_skb_parm {
 #define IP6SKB_L3SLAVE         64
 #define IP6SKB_JUMBOGRAM      128
 #define IP6SKB_SEG6	      256
-#define IP6SKB_FAKEJUMBO      512
 #define IP6SKB_MULTIPATH      1024
 #define IP6SKB_MCROUTE        2048
 };
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f904739e99b9..ed1b8e62ef61 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -179,8 +179,7 @@ ip6_finish_output_gso_slowpath_drop(struct net *net, struct sock *sk,
 static int ip6_finish_output_gso(struct net *net, struct sock *sk,
 				 struct sk_buff *skb, unsigned int mtu)
 {
-	if (!(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
-	    !skb_gso_validate_network_len(skb, mtu))
+	if (!skb_gso_validate_network_len(skb, mtu))
 		return ip6_finish_output_gso_slowpath_drop(net, sk, skb, mtu);
 
 	return ip6_finish_output2(net, sk, skb);
@@ -273,8 +272,6 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	struct in6_addr *first_hop = &fl6->daddr;
 	struct dst_entry *dst = skb_dst(skb);
 	struct inet6_dev *idev = ip6_dst_idev(dst);
-	struct hop_jumbo_hdr *hop_jumbo;
-	int hoplen = sizeof(*hop_jumbo);
 	struct net *net = sock_net(sk);
 	unsigned int head_room;
 	struct net_device *dev;
@@ -287,7 +284,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	rcu_read_lock();
 
 	dev = dst_dev_rcu(dst);
-	head_room = sizeof(struct ipv6hdr) + hoplen + LL_RESERVED_SPACE(dev);
+	head_room = sizeof(struct ipv6hdr) + LL_RESERVED_SPACE(dev);
 	if (opt)
 		head_room += opt->opt_nflen + opt->opt_flen;
 
@@ -312,19 +309,8 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
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
2.50.1


