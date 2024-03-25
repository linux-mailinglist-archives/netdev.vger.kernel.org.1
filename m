Return-Path: <netdev+bounces-81514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3B788A0DA
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 14:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44AF01F3AFB8
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7903145FFF;
	Mon, 25 Mar 2024 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqE2oUkj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734CC156C5F;
	Mon, 25 Mar 2024 06:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348131; cv=none; b=U1x7jvGGKDUrLQX7aKDhTLb0/v2tV04To3CIimKcsuiDdNUPPbMtvuEXqQTvoF6LbakdJSFF2ZVuOOW1VV1ZaNUILPYQWt71V/scdLKlYVE5EgjAdrNvhG85CKsIGYkZ3ekcFGPHFhniCYfoHkdooLJqYpaeQQGuL7w2BFP0DRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348131; c=relaxed/simple;
	bh=3e+bKGS7nVCM9PafOTPvFasjLkFs4xeF2YQpN+kaq04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ga+Cv0ymTsOGthZppcdkSYVTLabGW+DUVNRJePG+OnNVExIXjcojILnHUMtwpfJg432BUZxfsLCCRL/D9wJUJ+ySgMbzJ68+nM142PmcRTycnq/DQ/bf7PjU8IMjJTFVdiBdy2W0sWq7/wAxvxwbkKr1ZONkXLA4kn19pMDwwcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqE2oUkj; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60a3c48e70fso41355757b3.1;
        Sun, 24 Mar 2024 23:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711348128; x=1711952928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8tlSAyV4jJqvA7JB/3bzev+6NIo6ODATMwDvyBATkc=;
        b=YqE2oUkjt75Y0uI7xxpnTDtqKllgU7SETcSCe8j0yXlArS8Q4b8s0dTpoUHLBhiadW
         k06OGIN+s3zPLdzCEA//TrRcws/UgQ0RsgsStvCCKg0KE+QYUXpOxdIgtaPgCMaq/SjL
         K7vhD5R/oXv5nRTjo4aahrElKKfJBdWK1p0OH0SuH8nUfyZba9wZaIbb88AUub1eVDJj
         jRmRh74hi8aPdVrt7XpxFwC8lcV0HPb/fbAMXe6+0PxtmC7yjM3aM3XgizcyLjKvzsEh
         lzHiLrincgbbi07DVoQGkz0v6af7lgGJpAy8LKDvIKlT2vXP/jM9YHn4roywwsB+pILR
         LeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711348128; x=1711952928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8tlSAyV4jJqvA7JB/3bzev+6NIo6ODATMwDvyBATkc=;
        b=bBmcu8I7DxhwTWNbcoG+OzK4sYAiYGUE333UizJcKV0wCLgiAW3vugv3iCE6v5zzli
         1C952tPneJmb8hGZGxBSEMtUJihu1nlNoinr63KN0nY6UIHPqyPUaeK4QA0f6XRYn6vG
         hXXCSI397+7glalJUfV8Thk1ZYbVBBEmXNQOXoq4lguE2WmNnaZnDdFUEwRpfaiZ0o6u
         +PWOaczluue/aVGyOVNJE69SR0At3hl8bpNwNrZda1QeXhy1hiZRTXFKI5uTwfHSiGML
         IQxwCyizNY/LyddTGvkmCu1yy8WPaPVWLS/DEp8royBMFCWypr3E4Usr0RKcOwRt5Lmq
         2LXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAeLaPvneqRSed9mCFnbiBj6o5Ca4NRtpv+gU0kPqAYyzvzWMXn7NprBkuZPDTSpZiqXjrm0ZfI8N78YFIuEg7b1fjz8LHR9PzGSgmF9X3UbHh
X-Gm-Message-State: AOJu0YzKeNpfM111EmHlsBeOobEhgqnhHulNeY652w2W3GyvRJt3p7oT
	JHIX7qLzLxIGK53bpGRnSbJyQ5B2BTelEsE3lxIA/N9vq/C5VmF5TRS6TYTt
X-Google-Smtp-Source: AGHT+IF1kzeNUWm31FACJIzIuh9WTQatwj1HVeXuF2LwlipBd82E6t2tVA2ipRQ3Qp71T2TKgcURrg==
X-Received: by 2002:a81:6d4a:0:b0:611:27ce:9bb0 with SMTP id i71-20020a816d4a000000b0061127ce9bb0mr5231703ywc.4.1711348128487;
        Sun, 24 Mar 2024 23:28:48 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id p1-20020aa78601000000b006e697bd5285sm3520253pfn.203.2024.03.24.23.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 23:28:47 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/3] tcp: add location into reset trace process
Date: Mon, 25 Mar 2024 14:28:31 +0800
Message-Id: <20240325062831.48675-4-kerneljasonxing@gmail.com>
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

In addition to knowing the 4-tuple of the flow which generates RST,
the reason why it does so is very important because we have some
cases where the RST should be sent and have no clue which one
exactly.

Adding location of reset process can help us more, like what
trace_kfree_skb does.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/trace/events/tcp.h | 14 ++++++++++----
 net/ipv4/tcp_ipv4.c        |  2 +-
 net/ipv4/tcp_output.c      |  2 +-
 net/ipv6/tcp_ipv6.c        |  2 +-
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index a13eb2147a02..8f6c1a07503c 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -109,13 +109,17 @@ DEFINE_EVENT(tcp_event_sk_skb, tcp_retransmit_skb,
  */
 TRACE_EVENT(tcp_send_reset,
 
-	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
+	TP_PROTO(
+		const struct sock *sk,
+		const struct sk_buff *skb,
+		void *location),
 
-	TP_ARGS(sk, skb),
+	TP_ARGS(sk, skb, location),
 
 	TP_STRUCT__entry(
 		__field(const void *, skbaddr)
 		__field(const void *, skaddr)
+		__field(void *, location)
 		__field(int, state)
 		__array(__u8, saddr, sizeof(struct sockaddr_in6))
 		__array(__u8, daddr, sizeof(struct sockaddr_in6))
@@ -141,12 +145,14 @@ TRACE_EVENT(tcp_send_reset,
 			 */
 			TP_STORE_ADDR_PORTS_SKB(skb, entry->daddr, entry->saddr);
 		}
+		__entry->location = location;
 	),
 
-	TP_printk("skbaddr=%p skaddr=%p src=%pISpc dest=%pISpc state=%s",
+	TP_printk("skbaddr=%p skaddr=%p src=%pISpc dest=%pISpc state=%s location=%pS",
 		  __entry->skbaddr, __entry->skaddr,
 		  __entry->saddr, __entry->daddr,
-		  __entry->state ? show_tcp_state_name(__entry->state) : "UNKNOWN")
+		  __entry->state ? show_tcp_state_name(__entry->state) : "UNKNOWN",
+		  __entry->location)
 );
 
 /*
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index d5c4a969c066..fec54cfc4fb3 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -870,7 +870,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 		arg.bound_dev_if = sk->sk_bound_dev_if;
 	}
 
-	trace_tcp_send_reset(sk, skb);
+	trace_tcp_send_reset(sk, skb,  __builtin_return_address(0));
 
 	BUILD_BUG_ON(offsetof(struct sock, sk_bound_dev_if) !=
 		     offsetof(struct inet_timewait_sock, tw_bound_dev_if));
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e3167ad96567..fb613582817e 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3608,7 +3608,7 @@ void tcp_send_active_reset(struct sock *sk, gfp_t priority)
 	/* skb of trace_tcp_send_reset() keeps the skb that caused RST,
 	 * skb here is different to the troublesome skb, so use NULL
 	 */
-	trace_tcp_send_reset(sk, NULL);
+	trace_tcp_send_reset(sk, NULL,  __builtin_return_address(0));
 }
 
 /* Send a crossed SYN-ACK during socket establishment.
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 8e9c59b6c00c..7eba9c3d69f1 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1128,7 +1128,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 			label = ip6_flowlabel(ipv6h);
 	}
 
-	trace_tcp_send_reset(sk, skb);
+	trace_tcp_send_reset(sk, skb,  __builtin_return_address(0));
 
 	tcp_v6_send_response(sk, skb, seq, ack_seq, 0, 0, 0, oif, 1,
 			     ipv6_get_dsfield(ipv6h), label, priority, txhash,
-- 
2.37.3


