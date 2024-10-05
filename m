Return-Path: <netdev+bounces-132429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2888991B37
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 00:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79001283416
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 22:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C589A1662F4;
	Sat,  5 Oct 2024 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKdiZtMP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41060231C8F
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 22:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728167181; cv=none; b=AHVcE2SkPeSI0FmqpCqkp7oTNuvkMo+yZkzKERXmLw3XgxTdKOzoJReV+5tXUBmokeYO9Mt6cdwJKEfWwwvD+N8+UjePLSl7Hmr5zs1gg+BFM0/8hsh3+D2tFVTH7z4doeeuY/hmYPYrSPKiSMVSe9npDqyjfFhh5Dgb4wCmTZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728167181; c=relaxed/simple;
	bh=YFB8KjUSfUdBBdFf75PUfS5XqwtXi5ctE611v01rqNM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NMDx6Y95/J+BipI9SWk5V2brWKq26PttAPsI09XDdsMn0nOX9nbiKErGrTxnoisk+zrATN1ogYcz7YW84YJxsNnYnM+asJ3szOs8JDdYmW5L4DUWlpMNYbV7ijDwMPFoZs1b3nGVSmou9WxGnkUNrVnJbeqXPGxVk1pT4eG4E0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKdiZtMP; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e109539aedso2775772a91.0
        for <netdev@vger.kernel.org>; Sat, 05 Oct 2024 15:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728167179; x=1728771979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sZajQrQR4yR7nGn4bgSkD3D9Fp7/ivUS8OLj9sv9mJU=;
        b=XKdiZtMPRDc29IgWmhjmZmcsCJBYDkiyOaW+/oA6MdWYpOPEqxY+h5cw3EYlgcUbJa
         vdwQr1Kq79LoCjb9le51nRTjs7L2EqKVaRaDJoTnFTgk6BIXMkZ1HVv2arfHIj2gerXL
         piIGZHj84owm+ZG78qP/KmJSWbH/j6WqRfesFg9fjuY/i+fO2zz2LL9JaAQTnx9rEUTg
         wBF152tiI7mMPwlW7UK3mDlkT0erqFoGX3bjnv0ljOfSko4o5Dhhxk13ovzKzH4x+AyV
         Csxac78Bm20+1rTPDjNhJCr28DNAPPQzqyzWqEdXeCoiuaafJWvZYJAG/Sc6XhcIS4wu
         hPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728167179; x=1728771979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZajQrQR4yR7nGn4bgSkD3D9Fp7/ivUS8OLj9sv9mJU=;
        b=w2DxkgXu6bzDrz2rZNo32+BlDUxtRP1eHox6fDk10SLIkW1o837PvYE7P3ACuRQjWY
         CAS4yYKIxB576b4hYZRXlnsd9m4CjNgTmwzfj+iQ4XDGALDfEBP6mFgxg7Ln+upHb4tx
         Fnip1xNGBoGOkMrxoLiJAX82/q+a+rZGVbad40G7rHhaw4wewAFCCjphKjp2DbR/NdbT
         ZxbiCj4VgM0ix8Tb0xglFAmRy8qR4YpdmiHl/8unWSCsHG42z8eBCUjY5No+D6zUjupK
         mF+zHgZyJSJcXjrOCqvI+GoCHsJOkmLorLLKE9QZaRS6imAczPnRoe9NO3DwW0kX/9FE
         wZpw==
X-Gm-Message-State: AOJu0YwGc0Nzf9X1V3a/5uDWQwQOFEy6+c411HHM/GsaEXBJsl6yZDOW
	zLAbn8jGyvLTPo2GHieuX0/zWuB1lVZPW/llAOl0xANjr/76g4gJ
X-Google-Smtp-Source: AGHT+IG0l7CWMoBODII2rsi9SMqxC6sJCPkT1pfgQKN5oc9PsBFpUd0kaokM/oXGoqIWO/A95aHhcg==
X-Received: by 2002:a17:90b:17c4:b0:2e0:9d3e:bc2a with SMTP id 98e67ed59e1d1-2e1e636f96fmr8190045a91.32.1728167179517;
        Sat, 05 Oct 2024 15:26:19 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([103.30.248.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20ae7169esm2373536a91.10.2024.10.05.15.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 15:26:19 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4] net-timestamp: namespacify the sysctl_tstamp_allow_data
Date: Sun,  6 Oct 2024 07:26:09 +0900
Message-Id: <20241005222609.94980-1-kerneljasonxing@gmail.com>
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
v4
Link: https://lore.kernel.org/all/20241003104035.22374-1-kerneljasonxing@gmail.com/
1. use u8 instead of int to save more bytes (Kuniyuki)

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
index 78214f1b43a2..9b36f0ff0c20 100644
--- a/include/net/netns/core.h
+++ b/include/net/netns/core.h
@@ -15,6 +15,7 @@ struct netns_core {
 	int	sysctl_somaxconn;
 	int	sysctl_optmem_max;
 	u8	sysctl_txrehash;
+	u8	sysctl_tstamp_allow_data;
 
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
index 86a2476678c4..b60fac380cec 100644
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
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE
+	},
 	/* sysctl_core_net_init() will set the values after this
 	 * to readonly in network namespaces
 	 */
-- 
2.37.3


