Return-Path: <netdev+bounces-159758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB86A16BF0
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 13:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6025188044F
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 12:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC581C5F25;
	Mon, 20 Jan 2025 12:02:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B63374F1;
	Mon, 20 Jan 2025 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737374557; cv=none; b=Gmr7bT5vCPxxx1PsBmKrOoXignxnE9/u8Pv3VM5wNEJj/CxzKwPfG9fZo7n+1JXkjyeH9hgA5RORN7sbeyA3JcSuyYFNyx4KcSEbHj0llwA19aMuyf8qmbuJKehRr79Evw5huoZ4xDrizG7tArtxVmcvMLMaU02xy2tsMzvXoNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737374557; c=relaxed/simple;
	bh=G55ENzFSQQiZRu3K8xPXIIEFu4EfHQWWpwYfBwdjqYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f26sSRfTgO1AQGhq/nNhtj0ttK3Nc7rHH4l2ybAb5LN4T/4U50qixAZwDYRgYD6qdbBbQo7ciUOOCi+M6vJGgRAEbp9+9AAA0KeEjoNz3FBqWJeVctw+aqpluM0asSTNf9LqCqH4MThFux22rnm4kxZKRVyqEOlCzTydMxJDqmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso6178558a12.0;
        Mon, 20 Jan 2025 04:02:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737374553; x=1737979353;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHLSeT75ZypoZC2lSnYbrFjd8muHX4/LpYhdwyY+nqM=;
        b=sDlQak+Rbi/8LCFp9yAQlgcO+4r3RThqcf4Cyb5T4At5/fdI2cXBbdpiAL7A0ywXHW
         wNX2Wipd9wr6CHAahfwWsOGI41J6LVflcUc+dTBbH418iFVBjGWFnsvzuQd/UKSP5AZ8
         pm8JVHn9bp2mwUnH1Ls29HD4HJKoEx1zORe12/uoHD1RBKKEIC/VZ5Cz4dn2179EBNQR
         5ZTBIZDr1W+OItBkTCxmsPR20xA2IQRO/OYjHymgzDOVK8zYgiNfazFzfBJaP7O1lXby
         eDcnYRQ0hp7g5AOwjPvDjA02sdTtfzLE/ADH5UB6sY2QnkUAoq6HEO4tF8mceG0F9Oeh
         IS9g==
X-Forwarded-Encrypted: i=1; AJvYcCW4ypfhGM44dqi492g8n0ydtLQeq2VAnLvZ4lq4X0H4GTkN5Hsgxm6FxSxR6jJGJBa4k/coyNSf6ZA8gFDdaYqS2ROt@vger.kernel.org, AJvYcCX+q7UywLOfq5EAlbOaib3xfGJ+qPPkxOMwKY1iclh5Z0gPfBZAjty+ozyvM7L/PqqIepJyWDC6xB9Xt10=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUFVaw8eHrD3mPLZR5ZlPJF13wgXxDQsRPYya7hIW+4Tqpi9gx
	vUbA7fOIVdoPdYEVNT+9ik5xsYPPA4Mn8BrUvjI7lvjeUO+8V30o
X-Gm-Gg: ASbGncuzFO8yHdSI9xrGnOTOuOWrNemOwZJpHCAYtANAvy3I7cC3aPHTLOHeZEknyLP
	uUoeK6kNBDl6vYlG+131WYZlMzKLvK+BKX1Aqx06PLG8KuzhjH9TPkLvuHTp6YQdIcjATihAvJI
	fgEZ3N+OVQnIJ/MPvWA/U5F2quBGU5phabyKDpAKTA/7tKcJaninjTx4WFwrEIdsEL0CInejdHI
	onOpj9dRoA6FjcZLxhPWhcecALEc6qpOLJmF2oq6GdnzzAZSyGoWGn1pYix
X-Google-Smtp-Source: AGHT+IHrt+2sfNUB35EyeZm0rjqdP1R6Tj77bsNolAVfgVkGu0oNiO44Vp8LKi7WIRH1Ujs6BIV06A==
X-Received: by 2002:a05:6402:210c:b0:5da:11f4:f6ad with SMTP id 4fb4d7f45d1cf-5db7db2bfaemr13857889a12.28.1737374552963;
        Mon, 20 Jan 2025 04:02:32 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73eb54c3sm5688073a12.54.2025.01.20.04.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 04:02:32 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 20 Jan 2025 04:02:24 -0800
Subject: [PATCH RFC net-next] trace: tcp: Add tracepoint for
 tcp_cwnd_reduction()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-cwnd_tracepoint-v1-1-36b0e0d643fa@debian.org>
X-B4-Tracking: v=1; b=H4sIAE87jmcC/x3MQQrCMBAF0KsMf91AElBItoIHcCsicTrqbKYlC
 bVQenfR7Vu8DU2qSkOmDVUWbToZMoWBwO9iL3E6IhOijwcfonf8sfHea2GZJ7XuooTAKR1L4gc
 Gwlzlqet/vOJyPv3MpDuTteO271+OGjCGcgAAAA==
X-Change-ID: 20250120-cwnd_tracepoint-2e11c996a9cb
To: Eric Dumazet <edumazet@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, 
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
 Martin KaFai Lau <martin.lau@kernel.org>, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3418; i=leitao@debian.org;
 h=from:subject:message-id; bh=G55ENzFSQQiZRu3K8xPXIIEFu4EfHQWWpwYfBwdjqYI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnjjtXX16nbSOEG5eP6QzJHpv64svzQ0VBt37v1
 O0cZj31vn2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ447VwAKCRA1o5Of/Hh3
 bSD0EACEOp8Jlct6BfqX2d4IG3/NyxZ5U8N4n1+vopLJ1njUt7DqOzJakom+BaQCs+YzD1lx5Y1
 7Uy0ZENaYl687dq8wzM/4qVSqzvsduUmEQoniho1/H4tJY/kbFJDzJmif06K+ELW339o4tp1Ffi
 UDQ7x5f5o3EL4PohuLlNmecVDSOYzSZe/kygBwSR12H8+aJ6PL+21lim1hJh4RDpYvE+0bVQTs4
 fs2Cdrfy/zz4vH86i7xx/szm8dq9vzMKWMNH52MKO63mWX26vDLehZ5ccCq4WJUTPRXl/jrv+V9
 JWuN2K8xvMlZouOv4ArE5PELX6uCmWwCuHDj8cnNgX5jaJqIS6tzyBe/goG1rowqwYRhKbqiB5n
 twou2U1HVsAi8Oh8VpFzp/rs43CAURqNFLVd4czujGyChqTChrZkhU1kRiuLqOtj0/Gdu5SlJaJ
 2MQXlGnN/DhAusBLFUmDv4f+F9DjokXe2G4ZynPUjepxu4iU2juoAqVUnFDh+q/rnG10vEeVvp4
 3vgQQKjdecj7ER1N5MS55UuCLQrDJDksUtGY3l+ax75Rsik16ADjApmbDViKf2lEjOLke66S6Uk
 ASg+PTyt2btbdYV6x3o0t2rc31vwkNMDkqXUCYTjxlo5ZFY6iX6ttP2yI5+2wzOYh4AfFGw+rV1
 Z5pmuBSlRIR5fDg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a tracepoint to monitor TCP congestion window adjustments through the
tcp_cwnd_reduction() function. This tracepoint helps track:
  - TCP window size fluctuations
  - Active socket behavior
  - Congestion window reduction events

Meta has been using BPF programs to monitor this function for years. By
adding a proper tracepoint, we provide a stable API for all users who
need to monitor TCP congestion window behavior.

The tracepoint captures:
  - Socket source and destination IPs
  - Number of newly acknowledged packets
  - Number of newly lost packets
  - Packets in flight

Here is an example of a tracepoint when viewed in the trace buffer:

tcp_cwnd_reduction: src=[2401:db00:3021:10e1:face:0:32a:0]:45904 dest=[2401:db00:3021:1fb:face:0:23:0]:5201 newly_lost=0 newly_acked_sacked=27 in_flight=34

CC: Yonghong Song <yonghong.song@linux.dev>
CC: Song Liu <song@kernel.org>
CC: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/trace/events/tcp.h | 34 ++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_input.c       |  2 ++
 2 files changed, 36 insertions(+)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index a27c4b619dffd7dcc72fffa71bf0fd5e34fe6681..b3a636658b39721cca843c0000eaa573cf4d09d5 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -259,6 +259,40 @@ TRACE_EVENT(tcp_retransmit_synack,
 		  __entry->saddr_v6, __entry->daddr_v6)
 );
 
+TRACE_EVENT(tcp_cwnd_reduction,
+
+	TP_PROTO(const struct sock *sk, const int newly_acked_sacked,
+		 const int newly_lost, const int flag),
+
+	TP_ARGS(sk, newly_acked_sacked, newly_lost, flag),
+
+	TP_STRUCT__entry(
+		__array(__u8, saddr, sizeof(struct sockaddr_in6))
+		__array(__u8, daddr, sizeof(struct sockaddr_in6))
+		__field(int, in_flight)
+
+		__field(int, newly_acked_sacked)
+		__field(int, newly_lost)
+	),
+
+	TP_fast_assign(
+		const struct inet_sock *inet = inet_sk(sk);
+		const struct tcp_sock *tp = tcp_sk(sk);
+
+		memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
+		memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
+
+		TP_STORE_ADDR_PORTS(__entry, inet, sk);
+		__entry->in_flight = tcp_packets_in_flight(tp);
+		__entry->newly_lost = newly_lost;
+		__entry->newly_acked_sacked = newly_acked_sacked;
+	),
+
+	TP_printk("src=%pISpc dest=%pISpc newly_lost=%d newly_acked_sacked=%d in_flight=%d",
+		  __entry->saddr, __entry->daddr, __entry->newly_lost,
+		  __entry->newly_acked_sacked, __entry->in_flight)
+);
+
 #include <trace/events/net_probe_common.h>
 
 TRACE_EVENT(tcp_probe,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 4811727b8a02258ec6fa1fd129beecf7cbb0f90e..fc88c511e81bc12ec57e8dc3e9185a920d1bd079 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2710,6 +2710,8 @@ void tcp_cwnd_reduction(struct sock *sk, int newly_acked_sacked, int newly_lost,
 	if (newly_acked_sacked <= 0 || WARN_ON_ONCE(!tp->prior_cwnd))
 		return;
 
+	trace_tcp_cwnd_reduction(sk, newly_acked_sacked, newly_lost, flag);
+
 	tp->prr_delivered += newly_acked_sacked;
 	if (delta < 0) {
 		u64 dividend = (u64)tp->snd_ssthresh * tp->prr_delivered +

---
base-commit: 96e12defe5a8fa3f3a10e3ef1d20fee503245a10
change-id: 20250120-cwnd_tracepoint-2e11c996a9cb

Best regards,
-- 
Breno Leitao <leitao@debian.org>


