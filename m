Return-Path: <netdev+bounces-99885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8958D6D5A
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 03:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1B01F23196
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 01:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC8F1946F;
	Sat,  1 Jun 2024 01:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YD4BtylA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C786D14287
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 01:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717206179; cv=none; b=QD+kjCM5GFTKJc3WJGq0thogqfz43QH5MVJ7LIMPopURiU0/MZumV/l94UnUf4Tq1fy+Db1S/GAAI4SjVwCVay39tB0+eZ8kAL4bhf2ZzJ5k9Krlh1szbNMQ7bIMENx3JpFfb7YADlXhlyyWVpl6CPsWZayukMm5muqBfsi5Cwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717206179; c=relaxed/simple;
	bh=kSyvuVmoawm0A1229Z9cjCnSswrtkKHtT2WgaP8HoEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLjCtPdTnXma5CebD6GQe+r+2DNnC9BqoytSqmN3ZrrO7egIZCnz2kQrCxK7p++/oHY7TC+IeUBy3RDYjRjx/rhZyF3vhFzOQ8YrF95vRRzNKccEHxYKbTTAjoEuTW/Vpvy4v2s6u2yKBYmlJGhpbIt7gDb2iDuiLgnI00Ljo4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YD4BtylA; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-62a08b250a2so26622937b3.3
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 18:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717206176; x=1717810976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GJDm6iwovalgWz0sxMpvGD5PNxGmSKas+lavj2Qq0ow=;
        b=YD4BtylARo6CiEtgUKYej8A3xKc7kvOxKEg7U2CcUZeVW/+6hz6E6WEAJkuzo9hnQl
         Bn25RhH4kyt0BUK9NirWMskx1dcIZvxAmB+iiime/jhO4R2ibp1nWjNsb9xu2R3niQRo
         v4OnhKU3uzkd9vasOojq8uwWvXB5PHwx2LQiIcMdrkf30TunowZoeJe2c746vO08gagK
         /38xK/4ya0qqXp4DSd7vYVSGKgGHzDoZ8E+Dzv8HRQKpbY4fXjRsWj/qRxgD5TSZfMZ8
         yxUbC0oOV3nifgyUtsVJZHJ+9RW9LksglHg63o83I0M1r4vymnprh/+E091i3PIkVLOP
         wPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717206176; x=1717810976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJDm6iwovalgWz0sxMpvGD5PNxGmSKas+lavj2Qq0ow=;
        b=gedX/9moBGIJkaO2dAx/siuiTfZCxhdxm6Xw0xwr3ApG5PCmc3AtJYq6y4Wl3/edDz
         rhwkG1zCab2R60y9vByoPfk2ETW0qYwQ7Io6U8uNYhKDFqd2ODDD/QUwEvd4g6tQ9++U
         sXucSqaFQTIgpjDY9YsJ539vvJgTK+TuBlv/N8wM4LAXq3bf/qJnjreLeiDVIeDOTD7+
         beD+AqaS8xHX03PgtOGCJBcidqGTvJfU/V0WVLJ0pRFhTPBnojOkALaXak/XIxf7OJPh
         +d+fekulwT7OeH2CNcXJr8PVHPy7QtATq9Q7pSrO0WoTFv8fXTyT+gVyWVxChPn5sAby
         UqRw==
X-Gm-Message-State: AOJu0YyXb+acPyqMGA9kvR8HVXQhNdSWthXDOKvFjm7WtqBwa4/3sSLp
	Txjka7aczu3FH2LDyfc/vUJIX4UplXWc+xxa+PSJVps1nQ2uKJkR1pd/6NaaeI9isQQfnFQF3cQ
	W4aI=
X-Google-Smtp-Source: AGHT+IH/j2vzJwaTlUPRMs2EMQDMQa6P7RZLullnU/Y5B7uu39vSuoijNLKOBF04J9MmRcLjvexeoQ==
X-Received: by 2002:a81:ce03:0:b0:618:8e76:af45 with SMTP id 00721157ae682-62c797ef694mr32229037b3.52.1717206174989;
        Fri, 31 May 2024 18:42:54 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62c765e6efesm5424497b3.42.2024.05.31.18.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 18:42:54 -0700 (PDT)
Date: Fri, 31 May 2024 18:42:52 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Mina Almasry <almasrymina@google.com>,
	Florian Westphal <fw@strlen.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	David Howells <dhowells@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
	Jesper Dangaard Brouer <hawk@kernel.org>
Subject: [RFC v2 net-next 4/7] net: raw: use sk_skb_reason_drop to free rx
 packets
Message-ID: <0ecd499cd2e43560f22997b3aed0b72eb585dd7a.1717206060.git.yan@cloudflare.com>
References: <cover.1717206060.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717206060.git.yan@cloudflare.com>

Replace kfree_skb_reason with sk_skb_reason_drop and pass the receiving
socket to the tracepoint.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 net/ipv4/raw.c | 4 ++--
 net/ipv6/raw.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 1a0953650356..474dfd263c8b 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -301,7 +301,7 @@ static int raw_rcv_skb(struct sock *sk, struct sk_buff *skb)
 
 	ipv4_pktinfo_prepare(sk, skb, true);
 	if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0) {
-		kfree_skb_reason(skb, reason);
+		sk_skb_reason_drop(sk, skb, reason);
 		return NET_RX_DROP;
 	}
 
@@ -312,7 +312,7 @@ int raw_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	if (!xfrm4_policy_check(sk, XFRM_POLICY_IN, skb)) {
 		atomic_inc(&sk->sk_drops);
-		kfree_skb_reason(skb, SKB_DROP_REASON_XFRM_POLICY);
+		sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_XFRM_POLICY);
 		return NET_RX_DROP;
 	}
 	nf_reset_ct(skb);
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index f838366e8256..608fa9d05b55 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -362,14 +362,14 @@ static inline int rawv6_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	if ((raw6_sk(sk)->checksum || rcu_access_pointer(sk->sk_filter)) &&
 	    skb_checksum_complete(skb)) {
 		atomic_inc(&sk->sk_drops);
-		kfree_skb_reason(skb, SKB_DROP_REASON_SKB_CSUM);
+		sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_SKB_CSUM);
 		return NET_RX_DROP;
 	}
 
 	/* Charge it to the socket. */
 	skb_dst_drop(skb);
 	if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0) {
-		kfree_skb_reason(skb, reason);
+		sk_skb_reason_drop(sk, skb, reason);
 		return NET_RX_DROP;
 	}
 
@@ -390,7 +390,7 @@ int rawv6_rcv(struct sock *sk, struct sk_buff *skb)
 
 	if (!xfrm6_policy_check(sk, XFRM_POLICY_IN, skb)) {
 		atomic_inc(&sk->sk_drops);
-		kfree_skb_reason(skb, SKB_DROP_REASON_XFRM_POLICY);
+		sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_XFRM_POLICY);
 		return NET_RX_DROP;
 	}
 	nf_reset_ct(skb);
@@ -415,7 +415,7 @@ int rawv6_rcv(struct sock *sk, struct sk_buff *skb)
 	if (inet_test_bit(HDRINCL, sk)) {
 		if (skb_checksum_complete(skb)) {
 			atomic_inc(&sk->sk_drops);
-			kfree_skb_reason(skb, SKB_DROP_REASON_SKB_CSUM);
+			sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_SKB_CSUM);
 			return NET_RX_DROP;
 		}
 	}
-- 
2.30.2



