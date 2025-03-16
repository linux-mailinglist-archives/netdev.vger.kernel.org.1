Return-Path: <netdev+bounces-175091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4601A63359
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 03:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 244827A7607
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 02:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6658624B;
	Sun, 16 Mar 2025 02:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eO3iY0JN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4572E3377
	for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 02:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742092038; cv=none; b=LBqtVJCRfTZHLWPs8tiyyaj0/DGoPdfSzh+fPbVWVEVfvsooSoRMXtCdOjzGTftLsPf6JG0A6BtLz7EWBNPWJFwcWBCdPCVsMIJx/gI2L1RVacxu+1ksRWgLiwYB2WrO1mpuynVOGeOSQ7a3l/zkjUPBcLJhWKbgWOx8mQfEOOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742092038; c=relaxed/simple;
	bh=ziXJIE4y4CbMqCuaLmgpy6uFPZqfngQ1rD3e79h12qA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NVjAOyjVfRbXxtWW/UJ6W5a7gRoPsnN7BVGu0bT9kgbsxfq4C5PB8yP124djKpJO3uWKqMKIN1ft2R4/iaktvILZvdoppATcnd82LLsoN4u8Yw6gokfUg1LXPBucc4w0mrpHE6IFAndGKzq3cU/VNU4wTfw1RUf3jZCb91z+Jx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eO3iY0JN; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-301302a328bso1689433a91.2
        for <netdev@vger.kernel.org>; Sat, 15 Mar 2025 19:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742092036; x=1742696836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOOyceZKtiLLkqFLTDrKns86ff2lusWlqud2kZfX7Qk=;
        b=eO3iY0JNsTJ+VV3V1AE2RLd+O0Vg2ZXxvYVTFeiZbN261WCaXBcAysqkR/6kOAVQ9+
         idhgD/Rk0CUarqdPoHvXit+Ythg9eGLodja/WwXwtepBK7HX2XP2icaJHralwTrwCBZx
         ZMGeWEu+mZ57btw2pj1EYgjfRq8qAIxJTVfJXplCSLlkN90i5RnN97A9kaq/JRlKEHHr
         2iN6QsdWvhLff+B0yJ1FKqqcflCX0L9WP/+2oWjt2cTzTZKDaI4LB5PuuR9+fG24q74w
         xnZhUnLts2pp6mZugmVbR6QZVMYMZNoSFSbEC0jACCt2XLZfKOydtMkxOrKFE9maPt3y
         Zcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742092036; x=1742696836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOOyceZKtiLLkqFLTDrKns86ff2lusWlqud2kZfX7Qk=;
        b=VoY1iMi9+xaba1jSo38cWhLUdiYNoIxAoxABmR6SjbUzuSAQM9VsYbb7yHdpBxIYA8
         nXybe3kiNikFUX7d1jNqdiYAnG4E5rhXpwHG+BU1QgSvrjIEe7Z/WlWwzdle9H02TWQf
         5ty0yxhWocMhou0AGfF8yGCkAMVi/IyY1YL/sP8XvH6zhUUZWTifwdrvsfhhRsH7jVie
         8VFGuyPA0B6GSqoRi1aznJWDpWBpIeyPzt4ZrZnPFikIZT773GeEeJN+hFZB5IXzsqTw
         lYuRUPQPAd4kdAGhkN+UaRbmki6RxM53w4zIEzEj24NcI3Umvi0Ksqu+Q84ymhHGFWqC
         7E3g==
X-Gm-Message-State: AOJu0YxznP4Bvl7oZo8VZONQZo8waD2CuPmTUDfrM/+P/oZIsCLSa7nP
	aLjs3v7DNabHme/ufQaK0rAxhHos4yLqagTsGpQM5HL62KLO4mG3
X-Gm-Gg: ASbGncsZ4ThVYR32WwvPzp7K3HfLpV0fpghrAknxjAO45FxkwvUv0bB6cvFPWVgInQA
	S/zG9lP8bfYqTTq2/swqznrRW/LD0OxTltCnzGD9gM9p8TTsDghdxG9msYPar77Ea4p1XcXPKVp
	PqfQ3FWCk7ctunTpU81JODRAcGNKahRAxqNgXolnXTvTXtoW0490hEjJpIOXn/pK9/fjj3+kCe2
	eQN7tWpmXYcNm+YbjpVdc85ucNx5W2C/BUbLK019L3OizXZeu3umzSeFw5EXNadrOClqd9xyB0k
	2+6Np4/NoOS0m8Eng6g50b4sd3+jYeB8y9VZOdz1xmem+WkXcYvn5rdi5eZb792hhmFk8xddlDP
	BnBSpDexaZKaq+sWOHA==
X-Google-Smtp-Source: AGHT+IF1ZBu/1AfPH6YyJj0vPaNbIltOj8yb1PLGrjCwIyDTqkRm605bsW5xJFxh/mKgi9mnMWpe3A==
X-Received: by 2002:a05:6a21:1519:b0:1f3:4661:d19e with SMTP id adf61e73a8af0-1f5c10faca9mr10879069637.9.1742092036469;
        Sat, 15 Mar 2025 19:27:16 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711694b2csm5068255b3a.129.2025.03.15.19.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 19:27:16 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	kuniyu@amazon.com,
	ncardwell@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next v3 1/2] tcp: support TCP_RTO_MIN_US for set/getsockopt use
Date: Sun, 16 Mar 2025 10:27:05 +0800
Message-Id: <20250316022706.91570-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250316022706.91570-1-kerneljasonxing@gmail.com>
References: <20250316022706.91570-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support adjusting RTO MIN for socket level by using setsockopt().

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 Documentation/networking/ip-sysctl.rst |  4 ++--
 include/net/tcp.h                      |  2 +-
 include/uapi/linux/tcp.h               |  1 +
 net/ipv4/tcp.c                         | 16 +++++++++++++++-
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 054561f8dcae..5c63ab928b97 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1229,8 +1229,8 @@ tcp_pingpong_thresh - INTEGER
 tcp_rto_min_us - INTEGER
 	Minimal TCP retransmission timeout (in microseconds). Note that the
 	rto_min route option has the highest precedence for configuring this
-	setting, followed by the TCP_BPF_RTO_MIN socket option, followed by
-	this tcp_rto_min_us sysctl.
+	setting, followed by the TCP_BPF_RTO_MIN and TCP_RTO_MIN_US socket
+	options, followed by this tcp_rto_min_us sysctl.
 
 	The recommended practice is to use a value less or equal to 200000
 	microseconds.
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 7207c52b1fc9..6a7aab854b86 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -806,7 +806,7 @@ u32 tcp_delack_max(const struct sock *sk);
 static inline u32 tcp_rto_min(const struct sock *sk)
 {
 	const struct dst_entry *dst = __sk_dst_get(sk);
-	u32 rto_min = inet_csk(sk)->icsk_rto_min;
+	u32 rto_min = READ_ONCE(inet_csk(sk)->icsk_rto_min);
 
 	if (dst && dst_metric_locked(dst, RTAX_RTO_MIN))
 		rto_min = dst_metric_rtt(dst, RTAX_RTO_MIN);
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 32a27b4a5020..b2476cf7058e 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -137,6 +137,7 @@ enum {
 
 #define TCP_IS_MPTCP		43	/* Is MPTCP being used? */
 #define TCP_RTO_MAX_MS		44	/* max rto time in ms */
+#define TCP_RTO_MIN_US		45	/* min rto time in us */
 
 #define TCP_REPAIR_ON		1
 #define TCP_REPAIR_OFF		0
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 46951e749308..f2249d712fcc 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3352,7 +3352,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	icsk->icsk_probes_out = 0;
 	icsk->icsk_probes_tstamp = 0;
 	icsk->icsk_rto = TCP_TIMEOUT_INIT;
-	icsk->icsk_rto_min = TCP_RTO_MIN;
+	WRITE_ONCE(icsk->icsk_rto_min, TCP_RTO_MIN);
 	icsk->icsk_delack_max = TCP_DELACK_MAX;
 	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
 	tcp_snd_cwnd_set(tp, TCP_INIT_CWND);
@@ -3833,6 +3833,14 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 			return -EINVAL;
 		WRITE_ONCE(inet_csk(sk)->icsk_rto_max, msecs_to_jiffies(val));
 		return 0;
+	case TCP_RTO_MIN_US: {
+		int rto_min = usecs_to_jiffies(val);
+
+		if (rto_min > TCP_RTO_MIN || rto_min < TCP_TIMEOUT_MIN)
+			return -EINVAL;
+		WRITE_ONCE(inet_csk(sk)->icsk_rto_min, rto_min);
+		return 0;
+	}
 	}
 
 	sockopt_lock_sock(sk);
@@ -4672,6 +4680,12 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 	case TCP_RTO_MAX_MS:
 		val = jiffies_to_msecs(tcp_rto_max(sk));
 		break;
+	case TCP_RTO_MIN_US: {
+		int rto_min = READ_ONCE(inet_csk(sk)->icsk_rto_min);
+
+		val = jiffies_to_usecs(rto_min);
+		break;
+	}
 	default:
 		return -ENOPROTOOPT;
 	}
-- 
2.43.5


