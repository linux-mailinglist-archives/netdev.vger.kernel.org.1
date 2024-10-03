Return-Path: <netdev+bounces-131549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5072C98ED28
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09352283E36
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 10:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBA513D882;
	Thu,  3 Oct 2024 10:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/qBHmbR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DDB14BF9B
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727952043; cv=none; b=QbmN2p51Sbjt50d47k2Kcdo5/89a6FuPATemNxGhE36s+ePOO/s6N32IlM8RyJ1uAuxuNHC3IaBepsv4LSnr1ueiWw0Sml5ATFA757NuP3CHMVb5ifPn+amRa8uVIn1W4macaT2vmrCznr23yDztDXuasiJVHhyN3gCFbAgI4io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727952043; c=relaxed/simple;
	bh=i7+HgOj7Z8RNZZKx6TudM4UZymaXMep3n7N6qKhLWLw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d11vf99yzt6X6bJvJCKhYZ4cRge6jGMBKULBWfJfRRdjpkTyn1bCKQjgLx85HfeEOwaHuoSTzTWlGWnQYXb8mt3NbOiw0vNJsUaPGW4YmsmidbPnonZp50pUJTS0zw8FbsaYTY+2xi77cByfXaf6tzGeKXirOahiAM/iCUb/UXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/qBHmbR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b7eb9e81eso8414605ad.2
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 03:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727952042; x=1728556842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KlcNgGKfAEEPB8a3gKL78DgiC4WYfSjDvVQ6ADZAh1Q=;
        b=N/qBHmbRbZT7wqV7UCZVU1SPws2T26XiZU6VGlw1LubawBjiqk1CP3JH6PuhNjO4IX
         WxLmbI/qedKjqXxwalBzmkKK45lhPeB02j+/jQpmb5fi885kwfgpPPzUvC8DcI3wMPj/
         7U1MM2lT+oLEEE9ou6T6x0/7EqZwjyIM5NWu/BaeJGzDvto6hxTzywLZm5m7sKBGv9hU
         GMR3Mt37ruffrx6fvK0lv+v8QoUIcBQIjHzkBY+LcBbh3Z0+WFapUcjFaNRpTSDyrHNt
         +2+uw83RF2YxdSVIlPKyrxF2FuIi6vthTW/qezYhgvA/Jow4lPVNC3cX/TDhw3fWkTgl
         7BrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727952042; x=1728556842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlcNgGKfAEEPB8a3gKL78DgiC4WYfSjDvVQ6ADZAh1Q=;
        b=alSRLfRRLQshrxARUVM2PkmT1Y277+3En9LomYreOED7UFnL+UhUW7GKmnkpHtJE47
         cIkNQ2v215tx2ljiA9yFZyVxfE6hsoH4UAKkBOacTKWrWHMPzYpp8exLtqv7ZCoAw6lF
         v737uKvalkjUfuQl0uDzF2L+0iL8dgIP9bGbhSk//6CvFJ/6LDSjcI2kBDcqrcj3ZeOx
         8cLl4Mik+yH6SY+OIqQ69zZ2BfxyzVvokhdW0IiuIzc+/beyY8ZD0Or1tMKMwuDEnBpE
         /05ksdPlHKnJNaolgDTnQito7VUuwvA1S9TMk9zfgAt2OjOWtbESWGTCpO+2T99KVu5Z
         f4Fg==
X-Gm-Message-State: AOJu0YxDH+spOCQilXm+B+utfzd1Knqbu297KF1rWnHn5dZMXiAqyLWG
	i+QYUgCwSsKYQlXZ8g+CUSDcg0aCZvbynge1L3E1rHMkdfKyYoKQ
X-Google-Smtp-Source: AGHT+IGZmjZqn/hUOAqgNVCzkDv9VdOtX+ZmaH86c7wCo7QItYKHYAqC0DkTIg7iMBixvcwmCz0PiA==
X-Received: by 2002:a17:903:1103:b0:20b:9078:707b with SMTP id d9443c01a7336-20bc5a10233mr90278035ad.30.1727952041597;
        Thu, 03 Oct 2024 03:40:41 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([103.30.248.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beeca1c9fsm6752635ad.62.2024.10.03.03.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 03:40:41 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3] net-timestamp: namespacify the sysctl_tstamp_allow_data
Date: Thu,  3 Oct 2024 19:40:35 +0900
Message-Id: <20241003104035.22374-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Let it be tuned in per netns by admins.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v3
Link: https://lore.kernel.org/all/CANn89iLVRPHQ0TzWWOs8S1hA5Uwck_j=tPAQquv+qDf8bMkmYQ@mail.gmail.com/
1. move sysctl_tstamp_allow_data after sysctl_txrehash (Eric)

v2
Link: https://lore.kernel.org/all/66fa81b2ddf10_17948d294bb@willemb.c.googlers.com.notmuch/
1. remove the static global from sock.c
2. reorder the tests
3. I removed the patch [1/3] because I made one mistake
4. I also removed the patch [2/3] because Willem soon will propose a
packetdrill test that is better.
Now, I only need to write this standalone patch.
---
 include/net/netns/core.h   |  1 +
 include/net/sock.h         |  2 --
 net/core/net_namespace.c   |  1 +
 net/core/skbuff.c          |  2 +-
 net/core/sock.c            |  2 --
 net/core/sysctl_net_core.c | 18 +++++++++---------
 6 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/include/net/netns/core.h b/include/net/netns/core.h
index 78214f1b43a2..7a4f9588b1b2 100644
--- a/include/net/netns/core.h
+++ b/include/net/netns/core.h
@@ -15,6 +15,7 @@ struct netns_core {
 	int	sysctl_somaxconn;
 	int	sysctl_optmem_max;
 	u8	sysctl_txrehash;
+	int	sysctl_tstamp_allow_data;
 
 #ifdef CONFIG_PROC_FS
 	struct prot_inuse __percpu *prot_inuse;
diff --git a/include/net/sock.h b/include/net/sock.h
index c58ca8dd561b..4f31be0fd671 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2808,8 +2808,6 @@ void sk_get_meminfo(const struct sock *sk, u32 *meminfo);
 extern __u32 sysctl_wmem_max;
 extern __u32 sysctl_rmem_max;
 
-extern int sysctl_tstamp_allow_data;
-
 extern __u32 sysctl_wmem_default;
 extern __u32 sysctl_rmem_default;
 
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index e39479f1c9a4..e78c01912c64 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -317,6 +317,7 @@ static __net_init void preinit_net_sysctl(struct net *net)
 	 */
 	net->core.sysctl_optmem_max = 128 * 1024;
 	net->core.sysctl_txrehash = SOCK_TXREHASH_ENABLED;
+	net->core.sysctl_tstamp_allow_data = 1;
 }
 
 /* init code that must occur even if setup_net() is not called. */
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 74149dc4ee31..00afeb90c23a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5506,7 +5506,7 @@ static bool skb_may_tx_timestamp(struct sock *sk, bool tsonly)
 {
 	bool ret;
 
-	if (likely(READ_ONCE(sysctl_tstamp_allow_data) || tsonly))
+	if (likely(tsonly || READ_ONCE(sock_net(sk)->core.sysctl_tstamp_allow_data)))
 		return true;
 
 	read_lock_bh(&sk->sk_callback_lock);
diff --git a/net/core/sock.c b/net/core/sock.c
index fe87f9bd8f16..93b6c1d0317d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -286,8 +286,6 @@ EXPORT_SYMBOL(sysctl_rmem_max);
 __u32 sysctl_wmem_default __read_mostly = SK_WMEM_MAX;
 __u32 sysctl_rmem_default __read_mostly = SK_RMEM_MAX;
 
-int sysctl_tstamp_allow_data __read_mostly = 1;
-
 DEFINE_STATIC_KEY_FALSE(memalloc_socks_key);
 EXPORT_SYMBOL_GPL(memalloc_socks_key);
 
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 86a2476678c4..83622799eb80 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -491,15 +491,6 @@ static struct ctl_table net_core_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-	{
-		.procname	= "tstamp_allow_data",
-		.data		= &sysctl_tstamp_allow_data,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE
-	},
 #ifdef CONFIG_RPS
 	{
 		.procname	= "rps_sock_flow_entries",
@@ -665,6 +656,15 @@ static struct ctl_table netns_core_table[] = {
 		.extra2		= SYSCTL_ONE,
 		.proc_handler	= proc_dou8vec_minmax,
 	},
+	{
+		.procname	= "tstamp_allow_data",
+		.data		= &init_net.core.sysctl_tstamp_allow_data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE
+	},
 	/* sysctl_core_net_init() will set the values after this
 	 * to readonly in network namespaces
 	 */
-- 
2.37.3


