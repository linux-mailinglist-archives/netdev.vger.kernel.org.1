Return-Path: <netdev+bounces-223649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CF2B59D0D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B97D17A88D1
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E107E29DB64;
	Tue, 16 Sep 2025 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gWTiKL0y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2823427E076
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039004; cv=none; b=sR8T7G48s3A4eWvzGqMZ+vm2rbH4BOVte+8lckx/yaEOPMjZeN1hwMw5QiYOcrE5smEiWf/uBH+kaa4LQ2rLyoHlIqUN6RLnafvrvOulVOv2W+vpXSjUMGPCrazhQ+GCXYS9S1ueq3B8kJ2+rCDcX01yOmmP1X2FlYGaek9rCFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039004; c=relaxed/simple;
	bh=uV1zwOQANSuCdiJDCDM2bNcH1MMnYnUp+EQkLo9Mv2k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r1ifs7jFpigVnPhfVUlFcX3iQiVdaQDBJQaHRhPLLSxYbLUSb+fnEy/eoIEI6vUONEz8sIFRumum/APeuhetVs83jRK1L6CFPM9ob1iKaD9hX/Wo3kpMtHdzEEnwf9HGGTrqafw6lIcdlHGAF3fcp4lwaaoKpBXqgvBTvMIEuhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gWTiKL0y; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-82b1934907dso327730885a.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758039002; x=1758643802; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+4xxXVL8Parx6CuDjnbk6PvH6kIz/LppsEYSr/fhdAs=;
        b=gWTiKL0yPx67rymoRZkkkpXx3yB9jAqf4ek/wlfiuY01KpNb8+cGWngdRh+9975+0C
         urIWSiXFatAfrBF5WhD+7mWxfASLSDiG7QQdYYPRSIDLLbNj/dajlnMjBz3ftMOZ94g2
         5d9eIFfbP51L7RrjfRD5TcV1H60tI4dYEnT/FwWYgXdq6ZplSIHk8L1vRlKiqZ4LS69M
         QCAYA+RnfGHTjUmc+jBKOX2F+MGQzUwkHJeUSFJ+0nQnrQZW8xFdEDhNaQF08Yo150fZ
         XR6FFKybNNf0WCTkmsSN+gviG4/0mMNFoJTIOJHH/xkAwHZ+90AhiJJVtjT4GfOZLpXj
         Orbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758039002; x=1758643802;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4xxXVL8Parx6CuDjnbk6PvH6kIz/LppsEYSr/fhdAs=;
        b=Y0Uugb+PKgmxpUmi8A4YXn8ET4VGDKfiDX8fzPetQUOAAa5SViIm6fhKRWgh3VazbW
         u07HnKrIy56dMiVdpH4HUf1y1kDzBpKDFlje2SVM2ublzZ+meDK9nn4ELirtnJ1PM3dr
         ZYtU1RVQdg+kJakevBFcdFzEjmnNLI/yFMRgQ6XTbJ5i5MNZ6Nzc6mTJv5uGWGzhRxwv
         hqEGda+g5Qjy3UUcTpyZryHcWpayPlK6Rk2u6QrXKs7tTFVge73O1Ra7w/SWTksRpzgF
         /YKGUkcZqHVnLytJvWnI7KS7fmEWu+XIYnAw8CZ9uvsk0ssXODkaTRNdwvBv3e+UD6am
         LU+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5aEzCoUBaC3Z/lFQu+qGBZnZSVBDiAAdIV7nDK1VfL5abq5gMGRaeayKvOpAju2EAt5+Erq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCCmqTVUSoC2sf4C3g9J4ZNIkR1Am4kuBXbkoAUD+0gw+9qzzB
	LFjR3B6o0BuKeJcNWmNbwKzG59tgCp9wj/KBLYNNEO7y2O5TBhiCSiT/WGMx5h5kwBFtoUEbHoV
	xJqqGNVkD78+3MQ==
X-Google-Smtp-Source: AGHT+IHSXTt5E1gjPk2pm43LDRgcTGvGfBIyUMU+He+hUvCrsVsEEO1DclewyRabLjJLVtxh7YeG1kInAAIQDA==
X-Received: from qts10.prod.google.com ([2002:a05:622a:a90a:b0:4b2:9bf3:9666])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:344:b0:4b3:30d:5384 with SMTP id d75a77b69052e-4b77d078aecmr216538051cf.70.1758039001859;
 Tue, 16 Sep 2025 09:10:01 -0700 (PDT)
Date: Tue, 16 Sep 2025 16:09:45 +0000
In-Reply-To: <20250916160951.541279-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250916160951.541279-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916160951.541279-5-edumazet@google.com>
Subject: [PATCH net-next 04/10] ipv6: reorganise struct ipv6_pinfo
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Move fields used in tx fast path at the beginning of the structure,
and seldom used ones at the end.

Note that rxopt is also in the first cache line.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/ipv6.h | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 8e6d9f8b3dc80c3904ff13e1d218b9527a554e35..43b7bb82873881b38a461031b784f55c740a0741 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -214,18 +214,21 @@ struct inet6_cork {
 
 /* struct ipv6_pinfo - ipv6 private area */
 struct ipv6_pinfo {
+	/* Used in tx path (inet6_csk_route_socket(), ip6_xmit()) */
 	struct in6_addr 	saddr;
-	struct in6_pktinfo	sticky_pktinfo;
+	__be32			flow_label;
+	u32			dst_cookie;
+	struct ipv6_txoptions __rcu	*opt;
+	s16			hop_limit;
+	u8			pmtudisc;
+	u8			tclass;
 #ifdef CONFIG_IPV6_SUBTREES
 	bool			saddr_cache;
 #endif
 	bool			daddr_cache;
 
-	__be32			flow_label;
-	__u32			frag_size;
-
-	s16			hop_limit;
 	u8			mcast_hops;
+	u32			frag_size;
 
 	int			ucast_oif;
 	int			mcast_oif;
@@ -233,7 +236,7 @@ struct ipv6_pinfo {
 	/* pktoption flags */
 	union {
 		struct {
-			__u16	srcrt:1,
+			u16	srcrt:1,
 				osrcrt:1,
 			        rxinfo:1,
 			        rxoinfo:1,
@@ -250,29 +253,25 @@ struct ipv6_pinfo {
 				recvfragsize:1;
 				/* 1 bits hole */
 		} bits;
-		__u16		all;
+		u16		all;
 	} rxopt;
 
 	/* sockopt flags */
-	__u8			srcprefs;	/* 001: prefer temporary address
+	u8			srcprefs;	/* 001: prefer temporary address
 						 * 010: prefer public address
 						 * 100: prefer care-of address
 						 */
-	__u8			pmtudisc;
-	__u8			min_hopcount;
-	__u8			tclass;
+	u8			min_hopcount;
 	__be32			rcv_flowinfo;
+	struct in6_pktinfo	sticky_pktinfo;
 
-	__u32			dst_cookie;
+	struct sk_buff		*pktoptions;
+	struct sk_buff		*rxpmtu;
+	struct inet6_cork	cork;
 
 	struct ipv6_mc_socklist	__rcu *ipv6_mc_list;
 	struct ipv6_ac_socklist	*ipv6_ac_list;
 	struct ipv6_fl_socklist __rcu *ipv6_fl_list;
-
-	struct ipv6_txoptions __rcu	*opt;
-	struct sk_buff		*pktoptions;
-	struct sk_buff		*rxpmtu;
-	struct inet6_cork	cork;
 };
 
 /* We currently use available bits from inet_sk(sk)->inet_flags,
-- 
2.51.0.384.g4c02a37b29-goog


