Return-Path: <netdev+bounces-83167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7201891223
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 04:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99AD1C22E95
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 03:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAC439FD7;
	Fri, 29 Mar 2024 03:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHH5prrY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC88538FB6;
	Fri, 29 Mar 2024 03:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711683788; cv=none; b=KO6AG+yyZhOl6+lc2Ww/1OeNgEBk8teXH21Gk5UgNsKQmKxMSWN1x/wkGET9WKThorfH5FUFrBihJE0TkkR1S6kA7yx3mM4ogku3W76RkmT0YF8kMZk4v9GUAz6B5WPfC7qHwe1lmpJmRruSxgkjRd7kspp87KC/HmpFSmCc/Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711683788; c=relaxed/simple;
	bh=NW6SOAzOCmfHj7YzA9farLoUt7EnPGzCIYemqeUl0uo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FA0RA8VZE565qYUxkg6ITXoKSlPiC8v9PowkXyi0hwqali0pl1fTjkcb4gpr21CTPxWUgOvXJxHQ5jMj3bllaMnA/hDDyzKz0GqXLyd74yry1GBGGvUDegkhMASNssOvVUwjhypWVTLtXBI3FnkRbqTFmZN7ReDF66Kz8F9OHUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHH5prrY; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e703e0e5deso1407694b3a.3;
        Thu, 28 Mar 2024 20:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711683786; x=1712288586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kn212XxO4831NlLN6pezB/sv+pGx9/PfTNcOe8l6A6E=;
        b=VHH5prrYf//YIyg7971hHS8ZGDGqymfZlkvuTXH+vFY9p16E8j1rOBQWPpAtvYd5F5
         gHDm0A2U/j+LiK+M6T3++XrIbdpJ+/xXR37Lhw4EQCQF7xAWaHumYrCHhK6ep/LXBaTN
         1pcMEDmaMTaNB38jFN0gDxR2q5QQ9J7UidTZOARzNT39g3E72CA9AGWCCGW3Z+pvdtfs
         FIbTraV9MB4AZmKCZ9atue3g90F53lk8wIybA3T5gKwNuhd1HUZpSQtRJ1ueFREh0HXN
         b/qgBPDKEUEw/CbL78NM95jK7xdl4V1e6VgqIMHuNd78TMV+sNtiw/lvIZ27KDty01Iq
         Bv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711683786; x=1712288586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kn212XxO4831NlLN6pezB/sv+pGx9/PfTNcOe8l6A6E=;
        b=dWjjmfaGg+gCEed6blN6OYuSMpFZu1o1UGmEofGdqz68sV9YT0/96Fl9v6pjiqFK08
         eynZuwXBQzATsfA1HXnRNZ92xZW5+YFaZZeALfiPzQuNJT2R060U+pvvSuChKdEChzRX
         XVJ+t4N44gSAgcMHG1Dn/2JNbcHmREUskYEW9Ms+tEDyASSEKdGw1bXQCtZ5JXMn54SY
         NwKn2U0HPHL4EFVSyx6pWvHyRve6aBecDXx7FfxpxivboDO0ZSYNm35AXpNrdeOS1HTi
         Ge/NBEydRiqpzjL/CeT4R3E52CrXDJJ0J6GQIWXvA1aEOvX2rprhVlpEXJdaF08TuOuh
         TSFA==
X-Forwarded-Encrypted: i=1; AJvYcCV6XQ7HNLSW7uD496Zt3UGTjD2t4dEjKNCIKsdhGxJCDiAmYXKyk3psE4AS0SKc3KSCU9v2oLpIQG8+27tkcFLBSao5uJxjSjwG6JGAtEnz8Q9o
X-Gm-Message-State: AOJu0YyyUIViBwFmsM5p5XJRubG6+YQsxIle8ouHprtjmzs5/DWFZG4Y
	QP4OH3CUOXerR7KG+Q7YhVnVoVW5mpLo2KQn4oOVNBR5pWD3bFjU
X-Google-Smtp-Source: AGHT+IHeGy9+tq6qSPAoMpL+xc6kUdTfRLfg33kTS1IkNpVXoONOTkmnR829wgACn5DbiIjXo/HMzQ==
X-Received: by 2002:a05:6a00:2354:b0:6ea:7f6e:f451 with SMTP id j20-20020a056a00235400b006ea7f6ef451mr1298097pfj.1.1711683786127;
        Thu, 28 Mar 2024 20:43:06 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id a18-20020aa78e92000000b006e6c0080466sm2201854pfr.176.2024.03.28.20.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 20:43:05 -0700 (PDT)
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
Subject: [PATCH net-next v3 3/3] tcp: add location into reset trace process
Date: Fri, 29 Mar 2024 11:42:43 +0800
Message-Id: <20240329034243.7929-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240329034243.7929-1-kerneljasonxing@gmail.com>
References: <20240329034243.7929-1-kerneljasonxing@gmail.com>
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
 include/trace/events/tcp.h | 13 +++++++++----
 net/ipv4/tcp_ipv4.c        |  2 +-
 net/ipv4/tcp_output.c      |  2 +-
 net/ipv6/tcp_ipv6.c        |  2 +-
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 289438c54227..7a6dc525bfc7 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -80,13 +80,16 @@ DEFINE_EVENT(tcp_event_sk_skb, tcp_retransmit_skb,
  */
 TRACE_EVENT(tcp_send_reset,
 
-	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
+	TP_PROTO(const struct sock *sk,
+		 const struct sk_buff *skb,
+		 void *location),
 
-	TP_ARGS(sk, skb),
+	TP_ARGS(sk, skb, location),
 
 	TP_STRUCT__entry(
 		__field(const void *, skbaddr)
 		__field(const void *, skaddr)
+		__field(void *, location)
 		__field(int, state)
 		__array(__u8, saddr, sizeof(struct sockaddr_in6))
 		__array(__u8, daddr, sizeof(struct sockaddr_in6))
@@ -112,12 +115,14 @@ TRACE_EVENT(tcp_send_reset,
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


