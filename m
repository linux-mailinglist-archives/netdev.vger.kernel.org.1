Return-Path: <netdev+bounces-131108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C9798CBF9
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 06:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8351C21057
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 04:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12693E56C;
	Wed,  2 Oct 2024 04:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fuv2q/dy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7122E1B964
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 04:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727842735; cv=none; b=YDXlXHUW25OykFM1SlevhNeyRi6dpOf800qh4It23PgvpZp6n7AGe9acYYUZluQXpKzmkB7Df9pRohOnkARSnX9pd8cZDONcGmCRuJaLo7JcJYFp6wGittvLzfafp1Gm98tuImWUYi+LE5+BAigyd3rjTHvSTSMpp75MFYGbsdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727842735; c=relaxed/simple;
	bh=GN+2f+Gt6jqVECGnTutO0R5gohKqlZgIdeRWiG3BPWw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EL0PDy+xr/wbxza1Lz1pzY3A26WYCp+7+G3i9Y2gilgG6FGKPtYBMxU9ENZN2D3BEfHYPCZ+DiRgyDihc5/Q3+qaK3UMqqE56jN59ksRedNCQF+AsgBVb8awak8GW/mV1PDL4TbKLCv7eWA2ZhRqP9hNlXVHoJJvhv6W6clJu3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fuv2q/dy; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7e6ed072cdaso2301881a12.0
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 21:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727842732; x=1728447532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mJDtiJ/HPViVPN/OtaeAK5jan4gjZABOb3RhurC+7DU=;
        b=Fuv2q/dyulnZ1ftXhpfdbVYAgH3//j/Xob9pMcaaD6TZkUJRviEhjwCA9I+wbc6/N0
         NUjdMJP6FVXnGINYssSyzMexkhJcY4Ou0KcFt4EzXwufLgZBYxr6yobS+VvjpPJ/cXKW
         QeUe1jtG/slnnLJi0EBt/8uPpeg4eEvgJOG+72Y2RQ2UJke0s1dHiJPH94jEEuUaIpCO
         EuO19H+2KIa1lk9pU1m6biOmZ2LP1/IhGr6Oh4cb58f4M34l76tmG7D9SX6RGfc7Pxip
         b+wBtVa3zwUzPku3DoMsA7ZjJ/n0C++zOjkfvIFHyJoG9Kags9D9zuuakDcn8aVfDLAw
         l88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727842732; x=1728447532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJDtiJ/HPViVPN/OtaeAK5jan4gjZABOb3RhurC+7DU=;
        b=bsyYJIk/p48GpkNOADFxq5jhw6wVYD3T4/02K8z1YwH8IWIqACQMmahnuyLvRLx1n1
         vsliHsdg8lQ7xA21LdBiTPFDKyimpHwq9O2D88VVKE2VmzvpvUqQbdPicbaPxtWNOxLB
         xKthXcANo10YaXOFasb2tB/FZLBQZlj3bRdnMt9OCozf9hhIdFI/rTH3VTJ+MXdB11rn
         5XeXPNf7a4tOXKr8xRC6oSsaxJrW+QlBCEbTEFUeGl8+uaYTaXbT2xDbo7nYvJcqnXes
         wRwYL26APr4EBYj+GmkyLkBWfpRI5q40ebED5/K4jFdB64NQFnhTWKBUfKFpZSNaoxBA
         w7Zw==
X-Gm-Message-State: AOJu0Yz4PjNsjFYqoJeFShJWN7jacuG1S/Ya3XE9BvATov9W9+8io+82
	bQcJw9Pkjh2OZuOqJcqTXb6Zo49tpzWzbaUY8WIMBb8rdh1aO+/w
X-Google-Smtp-Source: AGHT+IFIFo1EElrJowbX1JEdMw8CLNK/1vnbEnY2nWHjvmZzWu+RVDfggCmckrtu1d5TuN0jKNKD2g==
X-Received: by 2002:a17:90a:ac11:b0:2d8:816a:69c5 with SMTP id 98e67ed59e1d1-2e1846c5158mr2540506a91.23.1727842732565;
        Tue, 01 Oct 2024 21:18:52 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([202.68.200.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f541021sm543536a91.6.2024.10.01.21.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 21:18:52 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2] net-timestamp: namespacify the sysctl_tstamp_allow_data
Date: Wed,  2 Oct 2024 12:18:44 +0800
Message-Id: <20241002041844.8243-1-kerneljasonxing@gmail.com>
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
index 78214f1b43a2..ef8b3105c632 100644
--- a/include/net/netns/core.h
+++ b/include/net/netns/core.h
@@ -23,6 +23,7 @@ struct netns_core {
 #if IS_ENABLED(CONFIG_RPS) && IS_ENABLED(CONFIG_SYSCTL)
 	struct cpumask *rps_default_mask;
 #endif
+	int	sysctl_tstamp_allow_data;
 };
 
 #endif
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


