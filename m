Return-Path: <netdev+bounces-175287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 328A7A64DD0
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 13:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A5AC7A32EE
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 12:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABD6238166;
	Mon, 17 Mar 2025 12:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khXG73zo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7924238146
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742213008; cv=none; b=adII2EHGD2A540Yet1VmxQjZp+bbquk3YElLniYUhGu5Z1eHbQ19tyIQgufZqAMxBhv+BBTvHEu051TcOL+nP3w2I9RoefcUtayvsnBDtDCar2hZJaadq6z6k78xGvgo9JuebXdl5R55V777C5hYu3EzjQE+K647LuM0ai5d8pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742213008; c=relaxed/simple;
	bh=MHnizJDMJeBm/LrHcC8OCzYI37asgxjyeyvIUK03+/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VIfDgiAT5Ai/DEAqQC1FdKw3/ttAHmPw2Ux29p1X2jx+SH0HomEKcfAn0Z3fLx1DLDyxnwIdntNx4kP1QMSkHjHipaLjGsy20y3i6HGqvDnweGUPJlHh438Sea6PlA69mNXaaCk/NisXhj2gWn88sTGVvu/FgjreJWoRPD99s7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khXG73zo; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22622ddcc35so5588535ad.2
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 05:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742213006; x=1742817806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s66STxKtwWxJhm+J05CzZyQ2UdqL5FlNUNwHDphGfrU=;
        b=khXG73zoVvddqxjko3y/Zl2C71Hok1hDmsoVELZDoS34qtpwQY16S1PkGJRIxTh5m+
         Mr+X1H9gpRs5klfMkKhf0BdH4ZaPiUZMCINh2Zz4rUi5VHfoRJOBP6eQcIbjYwzHfY1w
         LX9/fU1OcW5bVACeK8mPHy2iZrKBzGsTF858ntsMkkumdIHS9BCAhYHPcFTqKkzjugq/
         +hNRxb2eEfIOIu+aPgPM9+gMOTWgzEwuxMQJC5Gy+edTleYToQZC4JZpB2H8/ci/lkzE
         hH3VfMzVC4nTzxqEwescEpBnqUb+/iaTbnhH9ZKNz24m/V20xYtXMRFR+Ae2kZV4Q82A
         oMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742213006; x=1742817806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s66STxKtwWxJhm+J05CzZyQ2UdqL5FlNUNwHDphGfrU=;
        b=a3xTiQkxBoJCrrT47OelI9K34QQIjTsW//FxV4K9SYhgLAOMJkBkA8CW1SYW72syBm
         fLxUJet/sMRhIvrn+KhGijkdBELMRXy/Ho0EM8abo1Wc7rXnobmAPLMq8OsxEQSzuZDq
         4JhhGEsSxiJIgi6gg0/dQQtCI2BMXuSEqxqMC+I1sxUxYRbV1JMASouvuT1dmzVBjpU7
         s10N8fIkSP1FS20kZFV8L2ZXwALFN2fkqVWgAqIRiUo7z3x5oBRpeTITWi1nOg3Nt2ns
         8FHfqzktPOJLCrkU3zhYN3l8BqbuZdFXsv+UhXl/WFvgrU/T669LXrLd+3mk4iDzIWwG
         xFkA==
X-Gm-Message-State: AOJu0Yxv2z9S9gbuG95MLUzzvf+GpLHtnv9fcclvlUfi/wrqJOUOJjZ9
	UzuPHG/is1NxMMwcdqIZQ9BZNEJxCxHsXRZThitzd7tXiZX8/Drs
X-Gm-Gg: ASbGncunJHPat7uOTzlEAcbJnWBoOQb4mQ2HdVC2cQBZI6SBRYrY1flOdwdQJwr0vZi
	6X4C35LxI/IAtwdIpBiBBgSWBa1z2btCOBvP72jeT3pAMMxKL1iCFRMGH/OTSair3vVx6DGIjUR
	iTUjgTF28fiX1SnWIYDB9xLgL68yEJO3mBDRx4tVq64lYNP0XTl+jv9ul7mp+SAn5SEAPm9ZRBd
	LE9i7OMX8jPfYH5xqCqQ4NSy2olRB/JS28eXTaO1739vhcuz6EJMy6t/RfR4C5dvoaPLxKJmYpc
	vkqeQfU0yujnpd7SBGQRA5bjr3pGPBSmYLm5dQPWoH08M1wMCgZrEXk5Ji1Yr4g4Nd8ar58QbLs
	VLL3dnlYyRQAK+dpf
X-Google-Smtp-Source: AGHT+IFMLJJOUdAvQn6WqpmarjOkICRRJxH0ekTkQZC7RNkkHRILtnuPRR/W1tdtHcVE4NMYeiPaCA==
X-Received: by 2002:a17:902:da85:b0:224:910:23f0 with SMTP id d9443c01a7336-225e0b11989mr150714955ad.49.1742213005802;
        Mon, 17 Mar 2025 05:03:25 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4e02sm73045835ad.226.2025.03.17.05.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 05:03:25 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ncardwell@google.com,
	kuniyu@amazon.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next v4 2/2] tcp: support TCP_DELACK_MAX_US for set/getsockopt use
Date: Mon, 17 Mar 2025 20:03:14 +0800
Message-Id: <20250317120314.41404-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250317120314.41404-1-kerneljasonxing@gmail.com>
References: <20250317120314.41404-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support adjusting/reading delayed ack max for socket level by using
set/getsockopt().

This option aligns with TCP_BPF_DELACK_MAX usage. Considering that bpf
option was implemented before this patch, so we need to use a standalone
new option for pure tcp set/getsockopt() use.

Add WRITE_ONCE/READ_ONCE() to prevent data-race if setsockopt()
happens to write one value to icsk_delack_max while icsk_delack_max is
being read.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/uapi/linux/tcp.h |  1 +
 net/ipv4/tcp.c           | 13 ++++++++++++-
 net/ipv4/tcp_output.c    |  2 +-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index b2476cf7058e..2377e22f2c4b 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -138,6 +138,7 @@ enum {
 #define TCP_IS_MPTCP		43	/* Is MPTCP being used? */
 #define TCP_RTO_MAX_MS		44	/* max rto time in ms */
 #define TCP_RTO_MIN_US		45	/* min rto time in us */
+#define TCP_DELACK_MAX_US	46	/* max delayed ack time in us */
 
 #define TCP_REPAIR_ON		1
 #define TCP_REPAIR_OFF		0
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b89c1b676b8e..578e79024955 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3353,7 +3353,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	icsk->icsk_probes_tstamp = 0;
 	icsk->icsk_rto = TCP_TIMEOUT_INIT;
 	WRITE_ONCE(icsk->icsk_rto_min, TCP_RTO_MIN);
-	icsk->icsk_delack_max = TCP_DELACK_MAX;
+	WRITE_ONCE(icsk->icsk_delack_max, TCP_DELACK_MAX);
 	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
 	tcp_snd_cwnd_set(tp, TCP_INIT_CWND);
 	tp->snd_cwnd_cnt = 0;
@@ -3841,6 +3841,14 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		WRITE_ONCE(inet_csk(sk)->icsk_rto_min, rto_min);
 		return 0;
 	}
+	case TCP_DELACK_MAX_US: {
+		int delack_max = usecs_to_jiffies(val);
+
+		if (delack_max > TCP_DELACK_MAX || delack_max < TCP_TIMEOUT_MIN)
+			return -EINVAL;
+		WRITE_ONCE(inet_csk(sk)->icsk_delack_max, delack_max);
+		return 0;
+	}
 	}
 
 	sockopt_lock_sock(sk);
@@ -4683,6 +4691,9 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 	case TCP_RTO_MIN_US:
 		val = jiffies_to_usecs(READ_ONCE(inet_csk(sk)->icsk_rto_min));
 		break;
+	case TCP_DELACK_MAX_US:
+		val = jiffies_to_usecs(READ_ONCE(inet_csk(sk)->icsk_delack_max));
+		break;
 	default:
 		return -ENOPROTOOPT;
 	}
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 24e56bf96747..65aa26d65987 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4179,7 +4179,7 @@ u32 tcp_delack_max(const struct sock *sk)
 {
 	u32 delack_from_rto_min = max(tcp_rto_min(sk), 2) - 1;
 
-	return min(inet_csk(sk)->icsk_delack_max, delack_from_rto_min);
+	return min(READ_ONCE(inet_csk(sk)->icsk_delack_max), delack_from_rto_min);
 }
 
 /* Send out a delayed ack, the caller does the policy checking
-- 
2.43.5


