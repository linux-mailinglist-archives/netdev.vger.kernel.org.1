Return-Path: <netdev+bounces-178133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83722A74D98
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 16:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588CD189D258
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 15:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928AA14D70E;
	Fri, 28 Mar 2025 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4XEoKyv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0651A0BF1
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743175011; cv=none; b=oBkAgQ7CcDsyzWH3uaWuDLMExgnCKXPtJ9hpMu39celeQnVdfylrkPN/7mKIanGUPdQC4FqqfI+ufhUQO9LGHBX9Aam81eMjLwbpzgUX+l0M1HtnQeul2crjKcbUS9EYfPSyNCt9Q9OaqPrdZzMLeUxIe+RvZ9Wd337EC5RtJIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743175011; c=relaxed/simple;
	bh=4SnwxLLBkWx0+ZCJqyNcxPhL2Bq9A/HVjU3Ps8/PtME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IQ18qrvzfXB5vrVHBA3FSABwsY8xsFGKGgQo9vhqmn8p6/xfBVyseVutIXTjAO2kflK2IM/uiLsQqPZr0qWf7zpWgUQcb3yAknWTPpVHOSojSKEVNxJBDLfxkwgmSd+E42Ty+YWXGyFGdu/Pv7+Tljjp/F3KYEGd/Lv0/Nv7Z40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4XEoKyv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223a7065ff8so7879255ad.0
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 08:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743175009; x=1743779809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1y+MZkpFmvZAsuIP1i/mAxNPe+4zrWSQdw12KSayMc=;
        b=U4XEoKyv/Sfox8/qABfLaD0OeIMU9IMdP5f1SIJ+Ed+TvaDJLya8pQc0jozdAV+UWN
         F+pc7QAhuCdoR+W+PtOV2Zxa9goCz+eErC1ifXdmzardbgsJWmh7b8lyq/Ozs8Zd+k5C
         3o6Hb7QnCqGMo3bjPdj9ucXhi0avh37PHDyoybItlluG8Eujrs0J0Qk+qWy4Wt1jysCj
         9LjKasG6Ay5ScWeyh0LqeRAOXlGfh7blyMjNCV2lgEylcm/z1QUHLxttE0tYT+T+L0AD
         rtxF76C4TCHYeWrODyeTUiDkzgCc9uBppHujL8LPu9j0v/7iu/6SXz3l0jnEdQp5vct6
         qdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743175009; x=1743779809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1y+MZkpFmvZAsuIP1i/mAxNPe+4zrWSQdw12KSayMc=;
        b=lEIqNgcdlzAlSfdkoM2qmQgQBONMF2M/ZspWiabAeE83S6jYmAENe3JOIO+5wiXv3b
         11Pk6vBFikwpT1osEPt0I3YPpui47SelgGzVit0K9RLNau/7dKdA6zjZb2hIG+EJt8RK
         If+FdEDFdNGFf/913mUUp8k7L7uskwNgW+54tgoJjH2DXWveTZ2pKHwdIDHejbR4UX9U
         kr+nh6p0i7NdVwLm/vSF6yX/hduIJo2FsH7wX6VBVT4d884pZWwS5Rsm6Eev/iIM750L
         oLOGFDTRhMpUi0ANV7ZXOSNcXaXdgfE8ynfNSkTlxzRoHmH1zt7DvGJcA3IEGBT2KxQg
         qZ5w==
X-Gm-Message-State: AOJu0Ywbnyuwny2Ya/FdFBeqLDjRdyyyYKczhtG3u9ZvcyJWqI13TQy6
	5yEI4TqrrTZj9RNdmFDrWnLJ4gquEWp6M47xoioaXgEdlUxnDD2O
X-Gm-Gg: ASbGncs6vNYqVmvsFwB4ZaXEVGZeLSGP6nzp509CWMasrMxoei9cWZVEsYXa1MlZHCr
	/a0cxcwm84dd8+HyQ4mDpO7D43v7RYjsj0gFSG/Gc6VLvugg9saR3FCGjkltzAqhE8kJSrScuM3
	1fHyx1ixU+u2OS7NTnRZVyjBcM3W4/0pjK8SyNOht6FqzrO1K7JQHmSDTY6YGhfYEPs8n8XYSs2
	44/We2mvO5N3cmE4Unb1UrSxC5+TRrgR2rFHvq7Rwxr345k+P3jn3u4dA9taHGyCTHQ1i/Ez0Ft
	9I90NpyKPI91sMQBRMO0fDogZG7ijvEC8ohOeR3P5U3wE5NZSesyOopU03bcKgLT8I79gZ2s5lL
	nShcxECj1SM6YJCtllA==
X-Google-Smtp-Source: AGHT+IEHgkxQQajYmbCDTPvdQEFPf/5P0CanfjMFYyisOCC2sBl7piRP/fho0YqQZqxuHrmFbobqJA==
X-Received: by 2002:a05:6a21:496:b0:1ee:ef0b:7bf7 with SMTP id adf61e73a8af0-1fea2d9afa8mr14210244637.19.1743175008799;
        Fri, 28 Mar 2025 08:16:48 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7397109200csm1853985b3a.128.2025.03.28.08.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 08:16:48 -0700 (PDT)
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
Subject: [PATCH RFC net-next 2/2] tcp: introduce dynamic initcwnd adjustment
Date: Fri, 28 Mar 2025 23:16:33 +0800
Message-Id: <20250328151633.30007-3-kerneljasonxing@gmail.com>
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

More than one decade ago, Google published an important paper[1] that
describes how different initcwnd values have different impacts. Three
years later, initcwnd is set to 10 by default[2] for common use. But
nowadays, more and more small features have been developed for certain
particular cases instead of all the cases.

As we may notice some CDN teams try to increase it even to more than 100
for uncontrollable global network to speed up transmitting data in the slow
start phase. In data center, we also need such a similar change to ramp up
slow start especially for the case where application sometime tries to send
a small amount of data, say, 50K at one time in the persistent connection.
Asking users to tune by 'ip route' might not be that practical because 1)
it may affect those unwanted flows, 2) too big global-wide value may cause
burst for all kinds of flows.

This patch adds a dynamic adjustment feature for initcwnd in the slow start
or slow start from idle phase so that it only accelerates the in first
round trip time and doesn't affect too much for the massive data transfer
case.

Use 65535 as an upper bound to calculate the proper initcwnd. This number
is derived from the case where an skb carries the 65535 window when sending
syn ack at __tcp_transmit_skb(). Without it, the passive open side
sending data is able to see a very big value from the last ack in 3-WHS,
say, 2699776 which means it possibly generates a 1912 initcwnd that is
too big.

This patch can help the small data transfer case accelerate the speed. I
tested transmitting 50k at one time and managed to see the time consumed
decreased from 1400us to 80us. A 1750% delta!

The idea behind this is I often see the small data transfer consumes
more than 2 or 3 rtt because of limited snd_cwnd. In data center, we can
afford the bandwidth if we choose to accelerate transmission.

Why I chose the tp->max_window/tp->mss_cache? It's because cwnd is
increased by per mss packet and max_window is the signal that the other
side tries to tell us the max capacity it can bear. As we can see at
tcp_set_skb_tso_segs(), tcp_gso_size is equal to mss.

[1]: https://developers.google.com/speed/protocols/tcp_initcwnd_techreport.pdf
[2]: https://datatracker.ietf.org/doc/html/rfc6928

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
I'm not sure what the upper bound of this window should be. 65535 used
as max window generates a 46 initcwnd with the 1412 mss in my vm.
---
 include/linux/tcp.h      |  3 ++-
 include/uapi/linux/tcp.h |  1 +
 net/ipv4/tcp.c           |  8 ++++++++
 net/ipv4/tcp_input.c     | 11 +++++++++--
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index aba0a1fe0e36..445db706f3cd 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -385,7 +385,8 @@ struct tcp_sock {
 		syn_fastopen:1,	/* SYN includes Fast Open option */
 		syn_fastopen_exp:1,/* SYN includes Fast Open exp. option */
 		syn_fastopen_ch:1, /* Active TFO re-enabling probe */
-		syn_data_acked:1;/* data in SYN is acked by SYN-ACK */
+		syn_data_acked:1,/* data in SYN is acked by SYN-ACK */
+		dynamic_initcwnd:1;  /* dynamic adjustment for initcwnd */
 
 	u8	keepalive_probes; /* num of allowed keep alive probes	*/
 	u32	tcp_tx_delay;	/* delay (in usec) added to TX packets */
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index acf77114efed..7c63d0d0b5e1 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -143,6 +143,7 @@ enum {
 #define TCP_RTO_MIN_US		45	/* min rto time in us */
 #define TCP_DELACK_MAX_US	46	/* max delayed ack time in us */
 #define TCP_IW			47	/* initial congestion window */
+#define TCP_IW_DYNAMIC         48      /* dynamic adjustment for initcwnd */
 
 #define TCP_REPAIR_ON		1
 #define TCP_REPAIR_OFF		0
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 9da7ece57b20..3d419a714f2d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3868,6 +3868,11 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 			return -EINVAL;
 		tp->init_cwnd = val;
 		return 0;
+	case TCP_IW_DYNAMIC:
+		if (val < 0 || val > 1)
+			return -EINVAL;
+		tp->dynamic_initcwnd = val;
+		return 0;
 	}
 
 	sockopt_lock_sock(sk);
@@ -4716,6 +4721,9 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 	case TCP_IW:
 		val = tp->init_cwnd;
 		break;
+	case TCP_IW_DYNAMIC:
+		val = tp->dynamic_initcwnd;
+		break;
 	default:
 		return -ENOPROTOOPT;
 	}
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 00cbe8970a1b..05dbec734aa5 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6341,10 +6341,17 @@ void tcp_init_transfer(struct sock *sk, int bpf_op, struct sk_buff *skb)
 	 * initRTO, we only reset cwnd when more than 1 SYN/SYN-ACK
 	 * retransmission has occurred.
 	 */
-	if (tp->total_retrans > 1 && tp->undo_marker)
+	if (tp->total_retrans > 1 && tp->undo_marker) {
 		tcp_snd_cwnd_set(tp, 1);
-	else
+	} else {
+		if (tp->dynamic_initcwnd) {
+			u32 win = min(tp->max_window, 65535);
+
+			tp->init_cwnd = max(win / tp->mss_cache, TCP_INIT_CWND);
+		}
+
 		tcp_snd_cwnd_set(tp, tcp_init_cwnd(tp, __sk_dst_get(sk)));
+	}
 	tp->snd_cwnd_stamp = tcp_jiffies32;
 
 	bpf_skops_established(sk, bpf_op, skb);
-- 
2.43.5


