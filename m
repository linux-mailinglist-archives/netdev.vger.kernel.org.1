Return-Path: <netdev+bounces-175286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63C8A64DCF
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 13:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D3547A4BEE
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 12:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70744226D16;
	Mon, 17 Mar 2025 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFNoo1/1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B4C19DF64
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742213005; cv=none; b=ameNsZoppcvLDDf19WJitNwwhjRNrm2rxxom0HnaB+4ueUyG5brXvbsMpiCH5K9rCDrLy3Fif5LTMoyqHEgE8i8VtEmQdPCClxlBf0eWxMGQwGwN+WXUBZUHoSUFB8Ngts/UMLIpPAY1JMt0l07VkjvJfqnuGmRgC2h4Nbl7B7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742213005; c=relaxed/simple;
	bh=tvKt0IBQOFOscCPgNvBzBW3C0jSt8n0TRBcclRCWTgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gEt4ZIfenBgCYK8AmPGW6b84Po3zCelqJGSeguoJ973WNfdPBe4RzRp+uOjvapWCEphXz4uf2EnAprA5zv0L3C29Wv55gCccovouJunIwU0Bh49VvH5vCFKGQkjb7IJy0c39tF7R34DVTvhUZO38DNSN/8hlLkb6YlYT7uVTeKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFNoo1/1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22401f4d35aso76606175ad.2
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 05:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742213003; x=1742817803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kf6DxGuSScGEoN+1w6aBjA7f/gOaQi5M3ePcErz6rUs=;
        b=RFNoo1/1r5LEDoI8EeyJG4vjMDw4PoWZ87nlLNskvWwsB+If+mf+IGGVOIh2is5pPT
         sgIb48xnvfT3Y0PK3cibIKUDoLuKtbOvi9c5zApbu6bAEz5I3UTLu6G0tjjbJLu5dBjZ
         7nqb/30XcvXahW+Ntv5QMsEWap5RJ3CgPAoPtx2bZTvRhLCZwPCR2LV3xzYXshUz5uCf
         G7YGp/8TBgDhvQdOi3muDsklH36swE/I74wGpr6aESrIT5chQ+cyfLqHLEQ/MZEMRxfm
         /XNovVTbv+dcdhlEtUrAuzfj4dk9nC/v1k6Q4Q44w0xx/0qUN6wz5oweAR7e3lAQOx5q
         AKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742213003; x=1742817803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kf6DxGuSScGEoN+1w6aBjA7f/gOaQi5M3ePcErz6rUs=;
        b=hKnYtNYoziGVx1DcMCLr4ZnYJoITYDrU95qWxFgQzzpnuHiX8XwA2D1sWPR7EthrS3
         xfv36LkTwgVZN2OiPrUDISfqw3k4TqI5IZOqDIWlN5iAoFopPz53UHTsASOAIOk7VfY+
         IMeqRdzJvHlnzJvMlPjDxVhW6mvyGyIaQ/lL22uqGsRv6QZeWz8/KG9jlBQh0Q1lBPHi
         DGqcR0joIVc4/Z/vxpSQ9NxsF69lNfO1M7S4NEihRjoWYzCoDFQzIyW/CC0qRVgKL4Ih
         wRYYagllHMA628rSZfVCyWEI9nIpMyGPdVYngP1QJLlsZZGr6dT+5h1IiswPR4GLH5t2
         28gw==
X-Gm-Message-State: AOJu0YzRQumqKG0sMxzvV8FO/1GhPFK82taaPcrE+4B2SQsvy009bSHD
	1Ju29njEjvMsFI/kwKiGL25xFiK0kKcreFJxUEPQQBXvuzgRdBoY
X-Gm-Gg: ASbGnctVFgHZQH5bKZDoyrvmZF7MLIfoQuFpXYRtVYB8N/93EibGpVHssD7Ksy3xmmx
	3cq4+thbgrGHsZssmESr8AOYPC1M2c//0D9uTEASy2JBsDxMAf2EV5QKewdBAyV5jn1Hw1Pxu1K
	HONxZvEcaGF6WYBDD4TLBbh2vnT1F/TVVzWjf2+DTgcvSiRl742ZQe/OPsxObgvzE0Azloq1Bbr
	pqdDJ4cY25zlO1FlLOXcfWKVpexa4xVBW9PlMbrNqRuE53Xi4/c1qQrTepy6w9s/ecmqxQx9p8I
	Nd50Ot2d92tgAU17IOcqo5Fyn9VPeeGzGuuyfZmZnpzC/cS9+mj1m1KmBtB29HUiSf036mRW9S7
	EY2Rqb+frdyD/BD+B
X-Google-Smtp-Source: AGHT+IGHROTMz5O7pgnhFkAxvrqNuivQeoNJNIxt8kazouZEN4X3OfyGHZUuDSgXobkv1EGJv9m8Ug==
X-Received: by 2002:a17:902:d502:b0:224:1eaa:5de1 with SMTP id d9443c01a7336-225e0a4fd9cmr141278545ad.18.1742213002860;
        Mon, 17 Mar 2025 05:03:22 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4e02sm73045835ad.226.2025.03.17.05.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 05:03:22 -0700 (PDT)
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
Subject: [PATCH net-next v4 1/2] tcp: support TCP_RTO_MIN_US for set/getsockopt use
Date: Mon, 17 Mar 2025 20:03:13 +0800
Message-Id: <20250317120314.41404-2-kerneljasonxing@gmail.com>
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

Support adjusting/reading RTO MIN for socket level by using set/getsockopt().

This new option has the same effect as TCP_BPF_RTO_MIN, which means it
doesn't affect RTAX_RTO_MIN usage (by using ip route...). Considering that
bpf option was implemented before this patch, so we need to use a standalone
new option for pure tcp set/getsockopt() use.

When the socket is created, its icsk_rto_min is set to the default
value that is controlled by sysctl_tcp_rto_min_us. Then if application
calls setsockopt() with TCP_RTO_MIN_US flag to pass a valid value, then
icsk_rto_min will be overridden in jiffies unit.

This patch adds WRITE_ONCE/READ_ONCE to avoid data-race around
icsk_rto_min.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 Documentation/networking/ip-sysctl.rst |  4 ++--
 include/net/tcp.h                      |  2 +-
 include/uapi/linux/tcp.h               |  1 +
 net/ipv4/tcp.c                         | 13 ++++++++++++-
 4 files changed, 16 insertions(+), 4 deletions(-)

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
index 46951e749308..b89c1b676b8e 100644
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
@@ -4672,6 +4680,9 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 	case TCP_RTO_MAX_MS:
 		val = jiffies_to_msecs(tcp_rto_max(sk));
 		break;
+	case TCP_RTO_MIN_US:
+		val = jiffies_to_usecs(READ_ONCE(inet_csk(sk)->icsk_rto_min));
+		break;
 	default:
 		return -ENOPROTOOPT;
 	}
-- 
2.43.5


