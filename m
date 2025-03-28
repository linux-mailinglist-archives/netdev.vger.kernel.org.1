Return-Path: <netdev+bounces-178132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BC8A74D95
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 16:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1DE17535E
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 15:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA13B1D0F5A;
	Fri, 28 Mar 2025 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1tOiVD/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A3F1A0BF1
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743175007; cv=none; b=Tl4nd5fE1cd+5qjJfIQjFhA99UrcrJZKitGcQFnajyOQxut7TcFnLOPo0v3zlLw3z8W+TLpl0I7nHwkCu2iKa87HAOvFHjvfRtqFs3S8uj4MKo/jhEjO2Ga5AGQARbxdzGgEgtArgsHl8oRT7iO/KXXxbfECzukREHKf5pujBWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743175007; c=relaxed/simple;
	bh=JHm+uMRHWuJq856dNBjuBmMtclG48cX2nmLJ03lVEoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l6lNDLgpY7OT681ObBZUZxWFDIUjWax51BoscDWaJ1dWofWkl523VjFlAG7tY3o4uEolOIYZz1lNxsYwIrtBIktoOMXqeTKOfTgqQM6pVmdwn9gGo5HcvNpMbE8BHSBsyWTKPLLU57YFRKaz7QNOKxKunMOGquz4DIZiu8HbYzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1tOiVD/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223fb0f619dso48285885ad.1
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 08:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743175005; x=1743779805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kf5afqsjgjIRk5/Q6TfdvHjUnd0Q1P2i+m90V/ZcveU=;
        b=i1tOiVD/A+P2TJGGTDu/CPpsiHMpixeVGsZCqW47fsuOK21+KEFaOGyhlkV1A6xevE
         3IOK06QNp8wSsb5YLkr9ub9tXvBZAo7BGrITVQIEW2ngqjWF/kQDrUqTi0+qORpLKFGO
         9ytpu7KePRI8wI+zWQKZvjhxC4c2+8FQNDyzlXuk1y66npzcjoOQyIyrhall/kzx0ieX
         mozBLUcc6XifJ/zKCDMo78lGYySk77XUNG8IL/VY1gqGpIIBOm+Byuja6ssrHv/oRXD/
         3pFXc62d/bGrH3e5GozToxIctKuS20zuX7+RXWB8JLAOhOH/+IL0jaZCtmlqXOmxonEY
         XGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743175005; x=1743779805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kf5afqsjgjIRk5/Q6TfdvHjUnd0Q1P2i+m90V/ZcveU=;
        b=voESjfW/pNt8u5jkD/RsI1alw1pn8tp+9TGpJrgD55mxFXgEZe+R/fDRoCiM2uKNXE
         uB8Iy+yg3fpXFe1yc9OdltakOiy2OQrMFZAl7BSqO8slowZnk7mOUKiW/bclWCrr5wzB
         16hv4z1kKVSEHu99txZP9ke7NZCjhbq1SR5tJCcOIqY9Hge4qjHzJRLesoPZAAOI2snE
         HXIVFbwJxqCT0pL9pQuJEmPV1LD6qmeIC9tSoRTPI4TxbrA75VSx0dcT4NgbwZvmPSXF
         GXyiQnpp34XN96PXidnlygsJ9X/GUNfP9d8YOnAORVRt4+XuUuFOfK6vfjZQdyljqW1Y
         1Abg==
X-Gm-Message-State: AOJu0YwIz2n/zu98d/9D96eR69UN6R/XYpEZt2zl0CboeRW6zaBk6WS8
	4R+tY/zPe/So+RnxnhCUquFroKJFUJFswWUYnoB9+RPgJNi44Dl1
X-Gm-Gg: ASbGncvS04qfisRhNiBROWg+6WOgHDTS+C6WSbMppIMqLCDBZRItP3BVNni4VU/fVyY
	ydf1u7X2fmqqNZUl4Z1RdwjMfq3n2bWHsM/r8vq2OjR6SVQ7drB0aPY7N3ubJPpYkjlz9/TGloH
	cMl6MLENu9wmChHEBFUlYMTSSOi962tEkVeTYLeKY9OQHaRSaM/iPH2UekMuBt/yPveWAIahsBg
	xD0gO6XYjBnUFow2qTT223bi9r3cldpYEDX+1nEFE2fzNZww1NE8ov8PHVfur8AxKOkdmPtsetm
	DzfupsQiSK57W0xSAQVMdLyawidE4zGldAUVOvdoyBdY1ulDcNc47jQh2m2aAXisD+UPEOe0QOH
	QUEActv8=
X-Google-Smtp-Source: AGHT+IGPGJJALaTgZfCF5BzEO3PhSVeETXzzbIDGyaPWr85IXPq0IE57G2aVqy6gyeN9o2dGzdrUIg==
X-Received: by 2002:a05:6a00:88e:b0:730:79bf:c893 with SMTP id d2e1a72fcca58-73960e0ea8bmr12362364b3a.4.1743175005247;
        Fri, 28 Mar 2025 08:16:45 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7397109200csm1853985b3a.128.2025.03.28.08.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 08:16:44 -0700 (PDT)
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
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH RFC net-next 1/2] tcp: add TCP_IW for socksetopt
Date: Fri, 28 Mar 2025 23:16:32 +0800
Message-Id: <20250328151633.30007-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250328151633.30007-1-kerneljasonxing@gmail.com>
References: <20250328151633.30007-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

ip route command adjusts the initcwnd for the certain flows. And it
takes effect in the slow start and slow start from idle cases.

Now this patch introduces a socket-level option for applications to
have the same ability. After this, I think TCP_BPF_IW can be adjusted
accordingly for slow start from idle case.

Introduce a new field to store the initial cwnd to help socket remember
what the value is when it begins to slow start after idle.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/linux/tcp.h      | 1 +
 include/uapi/linux/tcp.h | 1 +
 net/ipv4/tcp.c           | 8 ++++++++
 net/ipv4/tcp_input.c     | 2 +-
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 1669d95bb0f9..aba0a1fe0e36 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -403,6 +403,7 @@ struct tcp_sock {
 	u32	snd_cwnd_used;
 	u32	snd_cwnd_stamp;
 	u32	prior_cwnd;	/* cwnd right before starting loss recovery */
+	u32	init_cwnd;	/* init cwnd controlled by setsockopt */
 	u32	prr_delivered;	/* Number of newly delivered packets to
 				 * receiver in Recovery. */
 	u32	last_oow_ack_time;  /* timestamp of last out-of-window ACK */
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index dc8fdc80e16b..acf77114efed 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -142,6 +142,7 @@ enum {
 #define TCP_RTO_MAX_MS		44	/* max rto time in ms */
 #define TCP_RTO_MIN_US		45	/* min rto time in us */
 #define TCP_DELACK_MAX_US	46	/* max delayed ack time in us */
+#define TCP_IW			47	/* initial congestion window */
 
 #define TCP_REPAIR_ON		1
 #define TCP_REPAIR_OFF		0
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index ea8de00f669d..9da7ece57b20 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3863,6 +3863,11 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		WRITE_ONCE(inet_csk(sk)->icsk_delack_max, delack_max);
 		return 0;
 	}
+	case TCP_IW:
+		if (val <= 0 || tp->data_segs_out > tp->syn_data)
+			return -EINVAL;
+		tp->init_cwnd = val;
+		return 0;
 	}
 
 	sockopt_lock_sock(sk);
@@ -4708,6 +4713,9 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 	case TCP_DELACK_MAX_US:
 		val = jiffies_to_usecs(READ_ONCE(inet_csk(sk)->icsk_delack_max));
 		break;
+	case TCP_IW:
+		val = tp->init_cwnd;
+		break;
 	default:
 		return -ENOPROTOOPT;
 	}
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e1f952fbac48..00cbe8970a1b 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1019,7 +1019,7 @@ static void tcp_set_rto(struct sock *sk)
 
 __u32 tcp_init_cwnd(const struct tcp_sock *tp, const struct dst_entry *dst)
 {
-	__u32 cwnd = (dst ? dst_metric(dst, RTAX_INITCWND) : 0);
+	__u32 cwnd = tp->init_cwnd ? : (dst ? dst_metric(dst, RTAX_INITCWND) : 0);
 
 	if (!cwnd)
 		cwnd = TCP_INIT_CWND;
-- 
2.43.5


