Return-Path: <netdev+bounces-123741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5336E9665DA
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 17:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764CA1C23DDC
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 15:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308DE1B583F;
	Fri, 30 Aug 2024 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJeERuT9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9260C1B5307
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032281; cv=none; b=ivCMgq35RZVJMY4S/h/sGASfHFNaXhLeWWBVSRE5qekbQs6QZgoGVyL+D1iAvxMeh/a4uFONlYST6TII2g6KLz0JTIUlOywDxZh3rwJUwFRlMx47esnTXGo9nzXlardsp6at9eliy8v1K9TuVq0Erp4k6cRIQuwgIFx6qZCxVCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032281; c=relaxed/simple;
	bh=5ueKriG21q/E6jvCcclpCGtuZjw0L8bOYqaK3xC5BjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S41ulSqR2+VS8nsNx+I8pjQZHzlc+KHplARMTGFmDsvDeRfvSs74oHi0QkTcqrPvYM34OLRJRQnkzcZR75LeUV4NiCDH1ndQJCu1PrTT8RQ+Cn8mEXGi6qmS1ssO7V5sdIU7g7NWWfXyflTnldYRwp/gQPxx5wNywktrSmBfFDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJeERuT9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20203988f37so19335565ad.1
        for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 08:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725032279; x=1725637079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIRna+VK+efdPqniPGomIkjoK65+9IgoA8XYwMuK0SE=;
        b=RJeERuT9vyLOtw5Z4oZy8vS3TCOdp719UkDD6ytQm/PzkFbRvBDZIf858ggfpBx7Ga
         X5v4zXxV98EZg3fvvJ7Ry62RvSxdjz1vuhHE2OO0A8EnlMjQUjfq3vm8KQi4J9l+IUk8
         gMkOfHwF134dSmbsqyonxky7SfSJth5ZTj+15ne/B84ybK7o5k68JaWbAucdbrgShOEZ
         hI5Dcd7h/BVjfnS6Eek3zH4ut0rdzdNCbIzcWxvvvfFEM0KBSIRubwhi9EzoqmPLoxNY
         9ZMojfAJexXVL+pYQMSKum1pxDpTDFfRE6jXG8DzCRCw3PmmhSSDO+L0gtC53CSLMllL
         drJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725032279; x=1725637079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIRna+VK+efdPqniPGomIkjoK65+9IgoA8XYwMuK0SE=;
        b=rCgupcvYa0n/JSq7uNey/S56oFeDf4RgQ2/WvKmMENj3JJ7IZke+rnuYqpIyzvONWZ
         R5n1CFoqC/dwhHb1TnJWr3WcP15Rx4SDh7KujG4hLRusojiDWIGKAm0wfgJdcIXnX5xD
         KJqNoZOAxTFF1gHg3hdFAIOVi5YwvVS5WUExW6E2OAba5eo78ZCd5gXWaZ+Vt0M0otmG
         Rs6XsHgu33HVQdVhO3yYXOXLrW9u131diMS726PAy41ks+SdRQv7Iils87CIYk38scAW
         8xqsG9pwCBIA9aIXPx6GYk6QD3EvVEfiIGylQuofUatyGAAR6Z2w5IrXFj0FcyiEqrVh
         fuog==
X-Gm-Message-State: AOJu0Yzu6+mK3s8bpUM1cn6VlN82JnLAQQXq2fFUZOfPBf7LHo6B3UkS
	rJjlBR2xWkVE6MBBPLAprm3DKinDjDurtkvUtu94eMyjM/NBSBt+
X-Google-Smtp-Source: AGHT+IFHWS2WmPJ8gqOssjbMuFB5JS9drnODsUiZZ+PuKohopY9eJYireNrKKZy3XJSKwNVMC+15lQ==
X-Received: by 2002:a17:902:e882:b0:201:fd3c:a321 with SMTP id d9443c01a7336-2050c4c367amr63207795ad.62.1725032278792;
        Fri, 30 Aug 2024 08:37:58 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152cd59esm28504795ad.81.2024.08.30.08.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 08:37:58 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemb@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next v3 1/2] net-timestamp: filter out report when setting SOF_TIMESTAMPING_SOFTWARE
Date: Fri, 30 Aug 2024 23:37:50 +0800
Message-Id: <20240830153751.86895-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240830153751.86895-1-kerneljasonxing@gmail.com>
References: <20240830153751.86895-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

introduce a new flag SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER in the
receive path. User can set it with SOF_TIMESTAMPING_SOFTWARE to filter
out rx timestamp report, especially after a process turns on
netstamp_needed_key which can time stamp every incoming skb.

Previously, We found out if an application starts first which turns on
netstamp_needed_key, then another one only passing SOF_TIMESTAMPING_SOFTWARE
could also get rx timestamp. Now we handle this case by introducing this
new flag without breaking users.

In this way, we have two kinds of combination:
1. setting SOF_TIMESTAMPING_SOFTWARE|SOF_TIMESTAMPING_RX_SOFTWARE, it
will surely allow users to get the rx timestamp report.
2. setting SOF_TIMESTAMPING_SOFTWARE|SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER
while the skb is timestamped, it will stop reporting the rx timestamp.

Another thing about errqueue in this patch I have a few words to say:
In this case, we need to handle the egress path carefully, or else
reporting the tx timestamp will fail. Egress path and ingress path will
finally call sock_recv_timestamp(). We have to distinguish them.
Errqueue is a good indicator to reflect the flow direction.

Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
1. Willem suggested this alternative way to solve the issue, so I
added his Suggested-by tag here. Thanks!
---
 Documentation/networking/timestamping.rst | 12 ++++++++++++
 include/uapi/linux/net_tstamp.h           |  3 ++-
 net/core/sock.c                           |  4 ++++
 net/ethtool/common.c                      |  1 +
 net/ipv4/tcp.c                            |  7 +++++--
 net/socket.c                              |  5 ++++-
 6 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
index 5e93cd71f99f..ef2a334d373e 100644
--- a/Documentation/networking/timestamping.rst
+++ b/Documentation/networking/timestamping.rst
@@ -266,6 +266,18 @@ SOF_TIMESTAMPING_OPT_TX_SWHW:
   two separate messages will be looped to the socket's error queue,
   each containing just one timestamp.
 
+SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER:
+  Used in the receive software timestamp. Enabling the flag along with
+  SOF_TIMESTAMPING_SOFTWARE will not report the rx timestamp to the
+  userspace so that it can filter out the case where one process starts
+  first which turns on netstamp_needed_key through setting generation
+  flags like SOF_TIMESTAMPING_RX_SOFTWARE, then another one only passing
+  SOF_TIMESTAMPING_SOFTWARE report flag could also get the rx timestamp.
+
+  SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER prevents the application from
+  being influenced by others and let the application finally choose
+  whether to report the timestamp in the receive path or not.
+
 New applications are encouraged to pass SOF_TIMESTAMPING_OPT_ID to
 disambiguate timestamps and SOF_TIMESTAMPING_OPT_TSONLY to operate
 regardless of the setting of sysctl net.core.tstamp_allow_data.
diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
index a2c66b3d7f0f..0042e91fa213 100644
--- a/include/uapi/linux/net_tstamp.h
+++ b/include/uapi/linux/net_tstamp.h
@@ -32,8 +32,9 @@ enum {
 	SOF_TIMESTAMPING_OPT_TX_SWHW = (1<<14),
 	SOF_TIMESTAMPING_BIND_PHC = (1 << 15),
 	SOF_TIMESTAMPING_OPT_ID_TCP = (1 << 16),
+	SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER = (1 << 17),
 
-	SOF_TIMESTAMPING_LAST = SOF_TIMESTAMPING_OPT_ID_TCP,
+	SOF_TIMESTAMPING_LAST = SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER,
 	SOF_TIMESTAMPING_MASK = (SOF_TIMESTAMPING_LAST - 1) |
 				 SOF_TIMESTAMPING_LAST
 };
diff --git a/net/core/sock.c b/net/core/sock.c
index 468b1239606c..c4488f6a3ce8 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -908,6 +908,10 @@ int sock_set_timestamping(struct sock *sk, int optname,
 	    !(val & SOF_TIMESTAMPING_OPT_ID))
 		return -EINVAL;
 
+	if (val & SOF_TIMESTAMPING_RX_SOFTWARE &&
+	    val & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)
+		return -EINVAL;
+
 	if (val & SOF_TIMESTAMPING_OPT_ID &&
 	    !(sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {
 		if (sk_is_tcp(sk)) {
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 7257ae272296..6fde55a904b0 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -430,6 +430,7 @@ const char sof_timestamping_names[][ETH_GSTRING_LEN] = {
 	[const_ilog2(SOF_TIMESTAMPING_OPT_TX_SWHW)]  = "option-tx-swhw",
 	[const_ilog2(SOF_TIMESTAMPING_BIND_PHC)]     = "bind-phc",
 	[const_ilog2(SOF_TIMESTAMPING_OPT_ID_TCP)]   = "option-id-tcp",
+	[const_ilog2(SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)] = "option-rx-software-filter",
 };
 static_assert(ARRAY_SIZE(sof_timestamping_names) == __SOF_TIMESTAMPING_CNT);
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8514257f4ecd..863cc6b8a208 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2235,6 +2235,7 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 			struct scm_timestamping_internal *tss)
 {
 	int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
+	u32 tsflags = READ_ONCE(sk->sk_tsflags);
 	bool has_timestamping = false;
 
 	if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
@@ -2274,14 +2275,16 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 			}
 		}
 
-		if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_SOFTWARE)
+		if (tsflags & SOF_TIMESTAMPING_SOFTWARE &&
+		    (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
+		     !(tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)))
 			has_timestamping = true;
 		else
 			tss->ts[0] = (struct timespec64) {0};
 	}
 
 	if (tss->ts[2].tv_sec || tss->ts[2].tv_nsec) {
-		if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_RAW_HARDWARE)
+		if (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)
 			has_timestamping = true;
 		else
 			tss->ts[2] = (struct timespec64) {0};
diff --git a/net/socket.c b/net/socket.c
index fcbdd5bc47ac..5ede4146198c 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -946,7 +946,10 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 
 	memset(&tss, 0, sizeof(tss));
 	tsflags = READ_ONCE(sk->sk_tsflags);
-	if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
+	if ((tsflags & SOF_TIMESTAMPING_SOFTWARE &&
+	     (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
+	     skb_is_err_queue(skb) ||
+	     !(tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER))) &&
 	    ktime_to_timespec64_cond(skb->tstamp, tss.ts + 0))
 		empty = 0;
 	if (shhwtstamps &&
-- 
2.37.3


