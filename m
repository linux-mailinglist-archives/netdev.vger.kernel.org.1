Return-Path: <netdev+bounces-81513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F6F88A0D9
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 14:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C69A1F3AF37
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE2B13BC21;
	Mon, 25 Mar 2024 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FU8XB2ZH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F9013CFBE;
	Mon, 25 Mar 2024 06:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348127; cv=none; b=DwJFpn6TCsTyVact/S3LL4I1flSSIS6xbvva+JVO4Kz3qbmbsj221nFDuu6LTgf77v3qwPCx2r/rJG9wt7N4uKWhSQ17mW6VIfsj8rilA8MzQoawxJBPtu015XQOQmStK7HoR/ePyIzWb9LPVuw+Q89vI/4iPYFNUrpZK3qU4HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348127; c=relaxed/simple;
	bh=3TsbrJSOzVBfSEm1f87KiGiSTFzU3nb1hXePHthz8hc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DC9it4uQ2zFKdYFZ7xelxDGAb8WuP8UEyaHA40v36kkvX0fExEkv2DsVeybRjMCZzFN2Q7mF9T6Q40ec6+h1Lp1hPIpNmulKu+JsPemh/9vq7r/SFNUHBf9L/sw7nj49PuSEXRKhkUiRtN11ck0mF0u2+sZ6sXI9PUclcUZiL9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FU8XB2ZH; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e6c0098328so2583799b3a.3;
        Sun, 24 Mar 2024 23:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711348125; x=1711952925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fn59/faPZWJa6DQ5/FMJVOqEKj7CPmJpuG2HGQTJjws=;
        b=FU8XB2ZHRzOvKsq5bUtIwASc1CjWDVXcfghcXJ/DNU5B+2AepMGKk3HaXZsMx3T2Ly
         gaZbjj6RJS4OsXfx13kaB+a7d3RY7qKYddumyQobVX/TXsrKEtqWbC6sxkDZqJmsitGf
         2Je298jkSE9V2HXDRpprw7HN0lXT6kKNg5b+KZWZPlo2afZ2B+1vmMmmpFEZS97tGLdS
         eYXVZqNBcRqfldkaSkW7+E0LcCPfHyo32DEFe/VwJZvvw+yvtm5kcRy3irv77HCMkOdI
         RrEm1bAtbW31sYcHhjf1Os2QpukK/NjX50loQ0wShFYaIdEJyVgD8z+vf7I3/npi+/7t
         tKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711348125; x=1711952925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fn59/faPZWJa6DQ5/FMJVOqEKj7CPmJpuG2HGQTJjws=;
        b=A5+cjNSEibpiceMmtktBNMJ/s2vjoKZlHoXigefV9QgbQZ26th40ZmUb52A5hej6Zl
         gR0zG1vmvYrIuBBUTpNx2BfaZHC+mFAZSQ64HsX8nXYOXnLtIhARRFuDHLV+OVJJCOVn
         ZVdj//fRLHnK6OncBD9Ijx+HeJB8Ae/RJrlujVSryuFTDnRtAd67IHPgYghg/si9LA5k
         pafRuT5rmGFdHzLkdsWl1nM2HERfVP+v6I66/mZjLoj9xbNZ3gxImerH063zBojhXbfz
         x7uqQ6cctPTDEvfMGK8NASWb4mNFoJZ2O9r9mVqOwYCLyoFFvngLsv8qLtWllJEtlXHU
         Ul9g==
X-Forwarded-Encrypted: i=1; AJvYcCVE5z3kIZD7QVTLP8kMcnV1FvD20uHEst7EdDgz4Uahg8F7zlRHHD5uQbe5uu9hN7oZPiZCgMNhNhwpBxmR7DCl+mTrdzFR/SMrEAZnHLNCUu7n
X-Gm-Message-State: AOJu0YwE56vDv8UdrjrZWAkgdkawB2tHqH5Mt2wGlrrFWwmmeLXlcG7x
	TwYrDOOQPT1/oua9G5xve+49NN/3yliFrqcOmEvH5QdZofHOa7py
X-Google-Smtp-Source: AGHT+IFbqw90SWM21645DIJ0EKl3OIi9Sh4/7rB3TNE7E9MIWrlaxsjoIh0ttuQ59GzLuabX9DQ3Sg==
X-Received: by 2002:aa7:888f:0:b0:6e6:8ca5:c0d4 with SMTP id z15-20020aa7888f000000b006e68ca5c0d4mr6366926pfe.12.1711348125187;
        Sun, 24 Mar 2024 23:28:45 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id p1-20020aa78601000000b006e697bd5285sm3520253pfn.203.2024.03.24.23.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 23:28:44 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	rostedt@goodmis.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 2/3] trace: tcp: fully support trace_tcp_send_reset
Date: Mon, 25 Mar 2024 14:28:30 +0800
Message-Id: <20240325062831.48675-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240325062831.48675-1-kerneljasonxing@gmail.com>
References: <20240325062831.48675-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Prior to this patch, what we can see by enabling trace_tcp_send is
only happening under two circumstances:
1) active rst mode
2) non-active rst mode and based on the full socket

That means the inconsistency occurs if we use tcpdump and trace
simultaneously to see how rst happens.

It's necessary that we should take into other cases into considerations,
say:
1) time-wait socket
2) no socket
...

By parsing the incoming skb and reversing its 4-tuple can
we know the exact 'flow' which might not exist.

Samples after applied this patch:
1. tcp_send_reset: skbaddr=XXX skaddr=XXX src=ip:port dest=ip:port
state=TCP_ESTABLISHED
2. tcp_send_reset: skbaddr=000...000 skaddr=XXX src=ip:port dest=ip:port
state=UNKNOWN
Note:
1) UNKNOWN means we cannot extract the right information from skb.
2) skbaddr/skaddr could be 0

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/trace/events/tcp.h | 39 ++++++++++++++++++++++++++++++++++++--
 net/ipv4/tcp_ipv4.c        |  4 ++--
 net/ipv6/tcp_ipv6.c        |  3 ++-
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 2495a1d579be..a13eb2147a02 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -107,11 +107,46 @@ DEFINE_EVENT(tcp_event_sk_skb, tcp_retransmit_skb,
  * skb of trace_tcp_send_reset is the skb that caused RST. In case of
  * active reset, skb should be NULL
  */
-DEFINE_EVENT(tcp_event_sk_skb, tcp_send_reset,
+TRACE_EVENT(tcp_send_reset,
 
 	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
 
-	TP_ARGS(sk, skb)
+	TP_ARGS(sk, skb),
+
+	TP_STRUCT__entry(
+		__field(const void *, skbaddr)
+		__field(const void *, skaddr)
+		__field(int, state)
+		__array(__u8, saddr, sizeof(struct sockaddr_in6))
+		__array(__u8, daddr, sizeof(struct sockaddr_in6))
+	),
+
+	TP_fast_assign(
+		__entry->skbaddr = skb;
+		__entry->skaddr = sk;
+		/* Zero means unknown state. */
+		__entry->state = sk ? sk->sk_state : 0;
+
+		memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
+		memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
+
+		if (sk && sk_fullsock(sk)) {
+			const struct inet_sock *inet = inet_sk(sk);
+
+			TP_STORE_ADDR_PORTS(__entry, inet, sk);
+		} else {
+			/*
+			 * We should reverse the 4-tuple of skb, so later
+			 * it can print the right flow direction of rst.
+			 */
+			TP_STORE_ADDR_PORTS_SKB(skb, entry->daddr, entry->saddr);
+		}
+	),
+
+	TP_printk("skbaddr=%p skaddr=%p src=%pISpc dest=%pISpc state=%s",
+		  __entry->skbaddr, __entry->skaddr,
+		  __entry->saddr, __entry->daddr,
+		  __entry->state ? show_tcp_state_name(__entry->state) : "UNKNOWN")
 );
 
 /*
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index a22ee5838751..d5c4a969c066 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -868,10 +868,10 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 	 */
 	if (sk) {
 		arg.bound_dev_if = sk->sk_bound_dev_if;
-		if (sk_fullsock(sk))
-			trace_tcp_send_reset(sk, skb);
 	}
 
+	trace_tcp_send_reset(sk, skb);
+
 	BUILD_BUG_ON(offsetof(struct sock, sk_bound_dev_if) !=
 		     offsetof(struct inet_timewait_sock, tw_bound_dev_if));
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 3f4cba49e9ee..8e9c59b6c00c 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1113,7 +1113,6 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 	if (sk) {
 		oif = sk->sk_bound_dev_if;
 		if (sk_fullsock(sk)) {
-			trace_tcp_send_reset(sk, skb);
 			if (inet6_test_bit(REPFLOW, sk))
 				label = ip6_flowlabel(ipv6h);
 			priority = READ_ONCE(sk->sk_priority);
@@ -1129,6 +1128,8 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 			label = ip6_flowlabel(ipv6h);
 	}
 
+	trace_tcp_send_reset(sk, skb);
+
 	tcp_v6_send_response(sk, skb, seq, ack_seq, 0, 0, 0, oif, 1,
 			     ipv6_get_dsfield(ipv6h), label, priority, txhash,
 			     &key);
-- 
2.37.3


