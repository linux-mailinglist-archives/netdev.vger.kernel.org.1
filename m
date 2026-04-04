Return-Path: <netdev+bounces-275386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MPJE7oo0WkXGAcAu9opvQ
	(envelope-from <netdev+bounces-275386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 17:05:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B342939B78A
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 17:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B3A3300D94D
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 15:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABE32765F8;
	Sat,  4 Apr 2026 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLGrpVTq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDD32749ED
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775315107; cv=none; b=ApU4cLdPTXAV50CVxjjyjyyhPjlNgpBOL6OlyilVYAdVfWNxW948Mwwi3S5lK/oSPEdLIt0uOm1EEpVq8um3xzJqWmEjDF4L/T+5uP8qW3Xy9nUDmpdKQhb7hJA2a7SVXcbYrW7iUXLXzeqYIhpRrfMX7J1JijTU0UapoGnJI2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775315107; c=relaxed/simple;
	bh=ObziIMZJptMx5wFSI3BwWls1eWUIp1bWLKEkqSnRD1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gCE/tz0THw/opKG0hRO2Im5LiZOmNKUUqWKLyJ/hkKSlxzDh0PwdSwOdQs4XnYSSx90+ZpdfmC/1xfmn+m8YLNcuLXisr/Nx4UsWYQ6I3wfG1hYCoRkFq06T63mXxXQwyOZeXoFIKC2QfoieEl/6FsOd0KAnFumK3cvd8Pttx+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLGrpVTq; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso1687816a91.3
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 08:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775315106; x=1775919906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7ow+y9L/LhofY2oGoxcrOm0+fzcC/letzWATueLsqs=;
        b=FLGrpVTqmzCjI6iQntr8QytJAztCKBReyE/YmfzLImxWehx8q8YKVZf3La2FTA8RTe
         xYqvZsBI6uxv9Wz+KgdWKYEOKIM08xmUu/cXcyXOGh3eAuqhPtGN/MxXByLkkcKehYsg
         +sEe5hnVsIOB6XoQWlluxfBc+akXDntPypBJY0A7fQhUZSrHoCeDdrW8rsytHOOGAmEX
         0yYuGJsXXZmeUgUDy21yM9GT6p+K82DpPn5DB3D+rFNq7mQvSAuDoUFu9uCF0+VEPxcx
         oDcrvxcw8yMJTu00O4vgAB9zBA46ZXOlUOtPvjUfIBJRk0wPTalELRdB4eopAwqhSIsS
         ZOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775315106; x=1775919906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K7ow+y9L/LhofY2oGoxcrOm0+fzcC/letzWATueLsqs=;
        b=i5qlPiDgKq7+8r1fb0T8/fnoC1P03Hje+6ytT+XdEne12OHDEcshyDnJRAM1IhwnrZ
         Z95KMGTQ8i5vPw3a/SRhaUuJ6Hk1t5IBPs19RwSawIf404y1vRVWXnAJVlLQxQkU0agW
         9evP+A8L5UGoQc6k6bQf7NJ761XFNSpZ7uYdeobjew+JP0aBI1WGx4tVFL0UCUr7cB95
         O04mCqdnEXsiwasROIUSF8jHtSSJqkeGg7Dt1d1ch+BgghcQELf9XvSBmkB0hqLzXHQa
         kJS7CA74nB+BnfiCE4KC/zXpmGIQR26DOUTNeqNjDNpWAr/Sd5QmLVrKSfw1Dm5yQkCH
         kdiA==
X-Gm-Message-State: AOJu0Yxvvk8FvS+loPdFtFoVzjXQ9XEnlHTIv65ylXRHrxPR+Gh19nxo
	FyyAD4JRARAXrV9hCI4ZWCz6bACyuyWX5E3GnKFDUUU3K8466tjsJB5J
X-Gm-Gg: AeBDiet6WUIk6ZAzBY8XB+MJwVwoj7PFtPBcrytILEgETQPqMIVtwtNA/v6+3YuFifU
	EmRPqioJ8Uya4GrbDxPPOA56fYviXI7BD06Ws14e8kpBV4NVGpkLfntEa+Z0WHtnYOiWP9kWU5C
	7j8aNZ9Cco0OrSVjxln8oTs9mINsGc5bgachA4AokiYf3JAlvQeQOVTj6S6QZdwFj8W/JDUTwkj
	j0FRB98LIKd82uU1zK89ScLGehFIJuARH+quNvWYygRjBSoyN6/2V3nPUbRH2h98+XJtzLm+T4e
	Z0voJrq3ZFYV8F8xJq6CAUlPUTmHhcPRegqd7B7BXS8wf4f4TYHTBQF/HIScDIHKy7haHyRBIoH
	gONnySGdYIfOh4+d/Hw4Xv0scekFlQSpQPNLZyv+TkkiaUxcwSCevEs3Slz+J0dKxcMXAbEeHH9
	G+Kk2Nj0llIT45ZKy8vRzF37em452H+83/cpEft5CAeNKHkD6XCM/tVz6vISg=
X-Received: by 2002:a17:902:db0f:b0:2b2:4b6a:f3b8 with SMTP id d9443c01a7336-2b2818b4279mr71216535ad.29.1775315105726;
        Sat, 04 Apr 2026 08:05:05 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([121.25.96.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65935cbsm8051444a12.26.2026.04.04.08.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 08:05:05 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	martin.lau@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Yushan Zhou <katrinzhou@tencent.com>
Subject: [PATCH net-next v2 1/4] tcp: separate BPF timestamping from tcp_tx_timestamp
Date: Sat,  4 Apr 2026 23:04:49 +0800
Message-Id: <20260404150452.83904-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260404150452.83904-1-kerneljasonxing@gmail.com>
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275386-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Queue-Id: B342939B78A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

Add a tcp_bpf_tx_timestamp() inline function as a prep for the later
patches.

Put it under the restriction of CONFIG_CGROUP_BPF.

Add a SKBTX_BPF check to avoid duplicated call of SENDMSG_CB if the
skb was tagged before. If we've already tagged this skb, only update
its tskey. It prevents the tskey from using an old value after more
data are all written into one skb, which is compatible with socket
timestamping.

Note: I didn't add back the process of reading skb from rtx queue which
was introduced by commit 838eb9687691 ("tcp: tcp_tx_timestamp() must look
at the rtx queue") because in BPF timestamping scenario:
1) BPF_SOCK_OPS_TSTAMP_SENDMSG_CB is the starting point for each skb
   that needs record.
2) BPF script must correlate sendmsg and the skb in this phase first
   and then will be able to record the SCHED/DRV/ACK timestamps to
   construct the correct timeline.
   Please see how progs/net_timestamping.c works with map.
3) at this point, notify the BPF script is too late to take care of
   the timestamp in sendmsg in time.
In conclusion, that doesn't work for BPF timestamping.

Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/tcp.h | 20 ++++++++++++++++++++
 net/ipv4/tcp.c    |  5 +----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 565943c34b7e..6705205ff236 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2883,12 +2883,32 @@ static inline void bpf_skops_init_skb(struct bpf_sock_ops_kern *skops,
 	skops->skb = skb;
 	skops->skb_data_end = skb->data + end_offset;
 }
+static inline void tcp_bpf_tx_timestamp(struct sock *sk)
+{
+	struct sk_buff *skb;
+
+	if (!cgroup_bpf_enabled(CGROUP_SOCK_OPS) ||
+	    !SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING))
+		return;
+
+	skb = tcp_write_queue_tail(sk);
+	if (!skb)
+		return;
+
+	if (!(skb_shinfo(skb)->tx_flags & SKBTX_BPF))
+		bpf_skops_tx_timestamping(sk, skb, BPF_SOCK_OPS_TSTAMP_SENDMSG_CB);
+	else
+		skb_shinfo(skb)->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
+}
 #else
 static inline void bpf_skops_init_skb(struct bpf_sock_ops_kern *skops,
 				      struct sk_buff *skb,
 				      unsigned int end_offset)
 {
 }
+static inline void tcp_bpf_tx_timestamp(struct sock *sk)
+{
+}
 #endif
 
 /* Call BPF_SOCK_OPS program that returns an int. If the return value
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index bd2c3c4587e1..169c3fff4f6d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -500,10 +500,6 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
 			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
 	}
-
-	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
-	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb)
-		bpf_skops_tx_timestamping(sk, skb, BPF_SOCK_OPS_TSTAMP_SENDMSG_CB);
 }
 
 /* @wake is one when sk_stream_write_space() calls us.
@@ -1417,6 +1413,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 out:
 	if (copied) {
 		tcp_tx_timestamp(sk, &sockc);
+		tcp_bpf_tx_timestamp(sk);
 		tcp_push(sk, flags, mss_now, tp->nonagle, size_goal);
 	}
 out_nopush:
-- 
2.41.3


