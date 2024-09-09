Return-Path: <netdev+bounces-126324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D56970B8E
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 03:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7369B216F6
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 01:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD0A14A82;
	Mon,  9 Sep 2024 01:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZuv4xuN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4C5134AB;
	Mon,  9 Sep 2024 01:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725846999; cv=none; b=UCbow+2fAM5gpYzRnsovM7IlVvpSW4gbwFmsSHBIDlDdFt39B4lqgIoji5ljqIGb/Mk+NrbC7OItfUgjBqZO4WLvhMzCJfH5lqgvD4b3d71HzpUYMkZyu3E/u0zB3njOsy58PjEFNIw8MzrXkeuh72h2thaj4p92PDYyIO0cjiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725846999; c=relaxed/simple;
	bh=enIvY0jBjMtZWu7KIntVOKTqwh4lYZLQdQePxI1eSzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a5yLnKIyqD2+eY4qx4hxPFmJqXTz+weV6zS+zlD2rJE6geW2eVdfDf3Oa5uTIph4U1JXepOVX7GAnQkoYjRYzmthvYs6yGWsvTdMHkR+J+Bd4fKK8X9vN7iHfNXRzk2rFh090QdvV6xLjWQkP2q4bkhI7GKibIX13+SVzMviRto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZuv4xuN; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-277efdcfa63so2316124fac.2;
        Sun, 08 Sep 2024 18:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725846997; x=1726451797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmpvGUlufIsuRLgFl3ptqugrr6qxsxrTOdZDDaaBcB4=;
        b=DZuv4xuNWTKne2p1zw0pY+462SAQTUnS0DjUhUtbSCkW8K7FwdgC/Kd1280BPt6wgl
         M5QTd6PnDCaY0AnRRNFQfy4vYCACdSJydiGqBZPzY930HfI0yWqaZMFKEl9pGTnDZT/H
         oG7JIb0Eg1PYnM1eI6PmyJ0BLH6VLTpGVVGvHcuhk+aKZHG3HK06Wlnb6PqymcbdJ2j8
         xS4oBBttAsV9lcii9hY9sMz8VWhR3pGlTCTdXBigCzS4S0lpsTCpyKJPuksXxtUFKeyb
         Xs63QOpPhk/ad0GYi04EPvGLqUouqpfvJolTPBvUrLGncgB9nh8sWn9Cd6vuWPSbq1p4
         OZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725846997; x=1726451797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmpvGUlufIsuRLgFl3ptqugrr6qxsxrTOdZDDaaBcB4=;
        b=rkzhT4erXp6Jmoly6yHytF9W6Ws9fR3y8GeaUiUDCSGgo9eXrVxy0nBzNFGR0lySZh
         +7Ar9eic443WQm+dfbV6pXOW78JHhyRt4H2JBZ7VRXbuI6Aytv+zsuoP9px91FqjMK4k
         AxQvoFPucqD7lxbHvbHe7XndgIlZGnCFJdEcrtXFYq7zkJE91NhvbsNWrOq4jjuxEuY1
         XdECqASETcisj8fkcLeeNzl+TTmYblp1IJ5kXVsRpnzznW2sXQ4eGuuROqUNS71ZhN1n
         tdYuhZ3IaiKBcAp0BXZ/Bx0uQnkRnn5C14qdOx9dZX10ON7j8Xp5R9iqAOx6zgcKycdv
         pf8g==
X-Forwarded-Encrypted: i=1; AJvYcCXmVSkkBrZ8SNqvFxaPyL6cCXcdx1l7QiMF++ox75WnlnqJswz7RuuUOnjOEhVfu8XLPaDoocM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBAEAbt5pKWMeGqTllBbs/Tw3eUP8PBK7yvanVxKZMhjOsFDx6
	W8DpfFbZ1EhKo++8/z08Z/Tc0XiWCj2L8Fmn3C/DndDmsXa9+wS45J0aUJ29pNg=
X-Google-Smtp-Source: AGHT+IFn7Yc2fitt1F3WGDFENZBMNbJNNvndtCGCAH/9+bdURdFJkiKJd/GScJJuv3XHO8w3z/oRLw==
X-Received: by 2002:a05:6870:4694:b0:270:7a7:eaa5 with SMTP id 586e51a60fabf-27b82db8b25mr10311762fac.10.1725846997192;
        Sun, 08 Sep 2024 18:56:37 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e5982f09sm2645616b3a.149.2024.09.08.18.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 18:56:36 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v6 1/2] net-timestamp: introduce SOF_TIMESTAMPING_OPT_RX_FILTER flag
Date: Mon,  9 Sep 2024 09:56:11 +0800
Message-Id: <20240909015612.3856-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240909015612.3856-1-kerneljasonxing@gmail.com>
References: <20240909015612.3856-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

introduce a new flag SOF_TIMESTAMPING_OPT_RX_FILTER in the receive
path. User can set it with SOF_TIMESTAMPING_SOFTWARE to filter
out rx software timestamp report, especially after a process turns on
netstamp_needed_key which can time stamp every incoming skb.

Previously, we found out if an application starts first which turns on
netstamp_needed_key, then another one only passing SOF_TIMESTAMPING_SOFTWARE
could also get rx timestamp. Now we handle this case by introducing this
new flag without breaking users.

Quoting Willem to explain why we need the flag:
"why a process would want to request software timestamp reporting, but
not receive software timestamp generation. The only use I see is when
the application does request
SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_TX_SOFTWARE."

Similarly, this new flag could also be used for hardware case where we
can set it with SOF_TIMESTAMPING_RAW_HARDWARE, then we won't receive
hardware receive timestamp.

Another thing about errqueue in this patch I have a few words to say:
In this case, we need to handle the egress path carefully, or else
reporting the tx timestamp will fail. Egress path and ingress path will
finally call sock_recv_timestamp(). We have to distinguish them.
Errqueue is a good indicator to reflect the flow direction.

Suggested-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v6
Link: https://lore.kernel.org/all/20240906095640.77533-1-kerneljasonxing@gmail.com/
1. add the description in doc provided by Willem
2. align the if statements (Willem)

v5
Link: https://lore.kernel.org/all/20240905071738.3725-1-kerneljasonxing@gmail.com/
1. squash the hardware case patch into this one (Willem)
2. update corresponding commit message and doc (Willem)
3. remove the limitation in sock_set_timestamping() and restore the
simplification branches. (Willem)

v4
Link: https://lore.kernel.org/all/20240830153751.86895-2-kerneljasonxing@gmail.com/
1. revise the commit message and doc (Willem)
2. simplify the test statement (Jakub)
3. add Willem's reviewed-by tag (Willem)

v3
1. Willem suggested this alternative way to solve the issue, so I
added his Suggested-by tag here. Thanks!
---
 Documentation/networking/timestamping.rst | 17 +++++++++++++++++
 include/uapi/linux/net_tstamp.h           |  3 ++-
 net/ethtool/common.c                      |  1 +
 net/ipv4/tcp.c                            |  9 +++++++--
 net/socket.c                              | 10 ++++++++--
 5 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
index 9c7773271393..8199e6917671 100644
--- a/Documentation/networking/timestamping.rst
+++ b/Documentation/networking/timestamping.rst
@@ -267,6 +267,23 @@ SOF_TIMESTAMPING_OPT_TX_SWHW:
   two separate messages will be looped to the socket's error queue,
   each containing just one timestamp.
 
+SOF_TIMESTAMPING_OPT_RX_FILTER:
+  Filter out spurious receive timestamps: report a receive timestamp
+  only if the matching timestamp generation flag is enabled.
+
+  Receive timestamps are generated early in the ingress path, before a
+  packet's destination socket is known. If any socket enables receive
+  timestamps, packets for all socket will receive timestamped packets.
+  Including those that request timestamp reporting with
+  SOF_TIMESTAMPING_SOFTWARE and/or SOF_TIMESTAMPING_RAW_HARDWARE, but
+  do not request receive timestamp generation. This can happen when
+  requesting transmit timestamps only.
+
+  Receiving spurious timestamps is generally benign. A process can
+  ignore the unexpected non-zero value. But it makes behavior subtly
+  dependent on other sockets. This flag isolates the socket for more
+  deterministic behavior.
+
 New applications are encouraged to pass SOF_TIMESTAMPING_OPT_ID to
 disambiguate timestamps and SOF_TIMESTAMPING_OPT_TSONLY to operate
 regardless of the setting of sysctl net.core.tstamp_allow_data.
diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
index a2c66b3d7f0f..858339d1c1c4 100644
--- a/include/uapi/linux/net_tstamp.h
+++ b/include/uapi/linux/net_tstamp.h
@@ -32,8 +32,9 @@ enum {
 	SOF_TIMESTAMPING_OPT_TX_SWHW = (1<<14),
 	SOF_TIMESTAMPING_BIND_PHC = (1 << 15),
 	SOF_TIMESTAMPING_OPT_ID_TCP = (1 << 16),
+	SOF_TIMESTAMPING_OPT_RX_FILTER = (1 << 17),
 
-	SOF_TIMESTAMPING_LAST = SOF_TIMESTAMPING_OPT_ID_TCP,
+	SOF_TIMESTAMPING_LAST = SOF_TIMESTAMPING_OPT_RX_FILTER,
 	SOF_TIMESTAMPING_MASK = (SOF_TIMESTAMPING_LAST - 1) |
 				 SOF_TIMESTAMPING_LAST
 };
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 781834ef57c3..6c245e59bbc1 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -427,6 +427,7 @@ const char sof_timestamping_names[][ETH_GSTRING_LEN] = {
 	[const_ilog2(SOF_TIMESTAMPING_OPT_TX_SWHW)]  = "option-tx-swhw",
 	[const_ilog2(SOF_TIMESTAMPING_BIND_PHC)]     = "bind-phc",
 	[const_ilog2(SOF_TIMESTAMPING_OPT_ID_TCP)]   = "option-id-tcp",
+	[const_ilog2(SOF_TIMESTAMPING_OPT_RX_FILTER)] = "option-rx-filter",
 };
 static_assert(ARRAY_SIZE(sof_timestamping_names) == __SOF_TIMESTAMPING_CNT);
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8a5680b4e786..e359a9161445 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2235,6 +2235,7 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 			struct scm_timestamping_internal *tss)
 {
 	int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
+	u32 tsflags = READ_ONCE(sk->sk_tsflags);
 	bool has_timestamping = false;
 
 	if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
@@ -2274,14 +2275,18 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 			}
 		}
 
-		if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_SOFTWARE)
+		if (tsflags & SOF_TIMESTAMPING_SOFTWARE &&
+		    (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
+		     !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER)))
 			has_timestamping = true;
 		else
 			tss->ts[0] = (struct timespec64) {0};
 	}
 
 	if (tss->ts[2].tv_sec || tss->ts[2].tv_nsec) {
-		if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_RAW_HARDWARE)
+		if (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE &&
+		    (tsflags & SOF_TIMESTAMPING_RX_HARDWARE ||
+		     !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER)))
 			has_timestamping = true;
 		else
 			tss->ts[2] = (struct timespec64) {0};
diff --git a/net/socket.c b/net/socket.c
index fcbdd5bc47ac..1e5c463fb4c5 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -946,11 +946,17 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 
 	memset(&tss, 0, sizeof(tss));
 	tsflags = READ_ONCE(sk->sk_tsflags);
-	if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
+	if ((tsflags & SOF_TIMESTAMPING_SOFTWARE &&
+	     (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
+	      skb_is_err_queue(skb) ||
+	      !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))) &&
 	    ktime_to_timespec64_cond(skb->tstamp, tss.ts + 0))
 		empty = 0;
 	if (shhwtstamps &&
-	    (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE) &&
+	    (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE &&
+	     (tsflags & SOF_TIMESTAMPING_RX_HARDWARE ||
+	      skb_is_err_queue(skb) ||
+	      !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))) &&
 	    !skb_is_swtx_tstamp(skb, false_tstamp)) {
 		if_index = 0;
 		if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDEV)
-- 
2.37.3


