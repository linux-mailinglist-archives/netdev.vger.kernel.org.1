Return-Path: <netdev+bounces-172037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 088E9A4FFB5
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 14:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1761895ACF
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 13:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAF624A04A;
	Wed,  5 Mar 2025 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xVWV1KSL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C178A1FCF6D
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179955; cv=none; b=NpXujPw8wVQrufGQxU19IsC1ti0axEJiEP/AHitG5A1o3TWt+x6XJQi0JG8/d15L4/u0SkfUXJBaBlIewotTHxDZOPnPB0MFnrUnYVHxeXez2OtIhorooqVkeMOM9DlXK49JzoXNIKc+vXHWr++3s4SEz3AnWjZSV5o+XAPkLqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179955; c=relaxed/simple;
	bh=cxNPbuUWxiRcKsQCxYcG3hyJ4ms8HxFnFqPiC/3LUPk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=e1QjdBm9GxsIMXn3i06HFDXA1sQyeOlS23G9S9pAjFYHs6kH1uxENBc7viuJbvEPAQKS+wSqlnxh6il91dAqKmJTIfyiFGW7wO0fGbr2ZbGd7eXFM8iY6Xm3J8VT2LmTT4HQ8T454mD6+ftzXiA9+lfgIwajwEvmQyPVYycUM8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xVWV1KSL; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4750a8fe4b9so9973301cf.0
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 05:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741179951; x=1741784751; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vLorXLD1vFJAFzD8hbfLIh9DSlboowr+CM92bsJMkV8=;
        b=xVWV1KSLJ/I+QB23ykSpe2740NnME2yMMob+VX5mLp4fiVXVYTO90X6ZzgzgPJaJIj
         c5CNCb/pOhPVgkPH05McE78yvoPKBsthDQfJipRIEHP1sfk7QGMcb3YUbIFymlrTADgH
         p8F8gl8yd2xTDJhHgyg3OnXBFCqcBh1XAmCIh3637Sn/OK+7Xx+j35KlbmR9voxrK2Ff
         n91VSILQx/QDUgHndpOMTC9QVXdMAvweErodEXv2X0ha76aHkK6hGJJRCCJgHNv4lyg4
         OvjJvJNqk6mX5ZrXgMkpajC5X4fycDxUxCMIxqxJurY9QmBdspX0VffsyVrFE2yfDr8A
         ceCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741179951; x=1741784751;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vLorXLD1vFJAFzD8hbfLIh9DSlboowr+CM92bsJMkV8=;
        b=GDE1X0J5SZuWCnSNfW7ltQwPF9cpRbnlMaBl+tfxDgHsSvgOrjIZW/iSLKcglu7SVY
         Q1mcLywghOB/7YOSB67FPqKHFCyFczwu+X22uD4jZMIOxv+Oq6zcAXZcMpM1yFtsFyKh
         Tm0yHtfds0Tf8tAmhswIDpg1zTFaNMhabZDzoqU6BiRiiFExvMfoObz3pCk85LaXS4a9
         WRdDjRyVSV+K74ZFpDjNNzgC/Sodt1WEwZUAirdDHOZEJc3qgv4PlSQRfwTSMnnVY2HZ
         ZJ7rUtrSEmlaBbn0jHOWHZ3NHtvv5Fk4iG42pO8qrxsSQLEKxzoIyhw4lSLkDfwZjWdD
         ApeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa80PFPm1lNCsG9fthJyJbaLtUizSdDjqDCcOehbtb2/LLV808fGUGKiCyqKYSsUhrxjHy+9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+1IEtkqS9neturUQYM+g2vsn7vJ2e/Y6AAalX4gpV6gSAi+KP
	EMB1XNFi98RYKUsxACw6O5JDyeLxOTqF/dH8EWcKwgyICSNS1zXCbHXkVG+aGNMkNPC/2jvov3Y
	l6NjyaeJHJA==
X-Google-Smtp-Source: AGHT+IFcpJBTx0Oczblt/ST24rRAPUbwKx65ucZycVVC6/EnVMi81zBYXb1NOtEE5gNfVXgsaRJOSe5UKrIVvQ==
X-Received: from qtbbb18.prod.google.com ([2002:a05:622a:1b12:b0:474:eec0:7770])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:50b:b0:474:f979:3e64 with SMTP id d75a77b69052e-4750b4ec755mr45841641cf.52.1741179951553;
 Wed, 05 Mar 2025 05:05:51 -0800 (PST)
Date: Wed,  5 Mar 2025 13:05:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250305130550.1865988-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: bring back NUMA dispersion in inet_ehash_locks_alloc()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Jason Xing <kernelxing@tencent.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We have platforms with 6 NUMA nodes and 480 cpus.

inet_ehash_locks_alloc() currently allocates a single 64KB page
to hold all ehash spinlocks. This adds more pressure on a single node.

Change inet_ehash_locks_alloc() to use vmalloc() to spread
the spinlocks on all online nodes, driven by NUMA policies.

At boot time, NUMA policy is interleave=all, meaning that
tcp_hashinfo.ehash_locks gets hash dispersion on all nodes.

Tested:

lack5:~# grep inet_ehash_locks_alloc /proc/vmallocinfo
0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_alloc+0x90/0x100 pages=16 vmalloc N0=2 N1=3 N2=3 N3=3 N4=3 N5=2

lack5:~# echo 8192 >/proc/sys/net/ipv4/tcp_child_ehash_entries
lack5:~# numactl --interleave=all unshare -n bash -c "grep inet_ehash_locks_alloc /proc/vmallocinfo"
0x000000004e99d30c-0x00000000763f3279   36864 inet_ehash_locks_alloc+0x90/0x100 pages=8 vmalloc N0=1 N1=2 N2=2 N3=1 N4=1 N5=1
0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_alloc+0x90/0x100 pages=16 vmalloc N0=2 N1=3 N2=3 N3=3 N4=3 N5=2

lack5:~# numactl --interleave=0,5 unshare -n bash -c "grep inet_ehash_locks_alloc /proc/vmallocinfo"
0x00000000fd73a33e-0x0000000004b9a177   36864 inet_ehash_locks_alloc+0x90/0x100 pages=8 vmalloc N0=4 N5=4
0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_alloc+0x90/0x100 pages=16 vmalloc N0=2 N1=3 N2=3 N3=3 N4=3 N5=2

lack5:~# echo 1024 >/proc/sys/net/ipv4/tcp_child_ehash_entries
lack5:~# numactl --interleave=all unshare -n bash -c "grep inet_ehash_locks_alloc /proc/vmallocinfo"
0x00000000db07d7a2-0x00000000ad697d29    8192 inet_ehash_locks_alloc+0x90/0x100 pages=1 vmalloc N2=1
0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_alloc+0x90/0x100 pages=16 vmalloc N0=2 N1=3 N2=3 N3=3 N4=3 N5=2

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inet_hashtables.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 9bfcfd016e18275fb50fea8d77adc8a64fb12494..2b4a588247639e0c7b2e70d1fc9b3b9b60256ef7 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -1230,22 +1230,37 @@ int inet_ehash_locks_alloc(struct inet_hashinfo *hashinfo)
 {
 	unsigned int locksz = sizeof(spinlock_t);
 	unsigned int i, nblocks = 1;
+	spinlock_t *ptr = NULL;
 
-	if (locksz != 0) {
-		/* allocate 2 cache lines or at least one spinlock per cpu */
-		nblocks = max(2U * L1_CACHE_BYTES / locksz, 1U);
-		nblocks = roundup_pow_of_two(nblocks * num_possible_cpus());
+	if (locksz == 0)
+		goto set_mask;
 
-		/* no more locks than number of hash buckets */
-		nblocks = min(nblocks, hashinfo->ehash_mask + 1);
+	/* Allocate 2 cache lines or at least one spinlock per cpu. */
+	nblocks = max(2U * L1_CACHE_BYTES / locksz, 1U) * num_possible_cpus();
 
-		hashinfo->ehash_locks = kvmalloc_array(nblocks, locksz, GFP_KERNEL);
-		if (!hashinfo->ehash_locks)
-			return -ENOMEM;
+	/* At least one page per NUMA node. */
+	nblocks = max(nblocks, num_online_nodes() * PAGE_SIZE / locksz);
+
+	nblocks = roundup_pow_of_two(nblocks);
+
+	/* No more locks than number of hash buckets. */
+	nblocks = min(nblocks, hashinfo->ehash_mask + 1);
 
-		for (i = 0; i < nblocks; i++)
-			spin_lock_init(&hashinfo->ehash_locks[i]);
+	if (num_online_nodes() > 1) {
+		/* Use vmalloc() to allow NUMA policy to spread pages
+		 * on all available nodes if desired.
+		 */
+		ptr = vmalloc_array(nblocks, locksz);
+	}
+	if (!ptr) {
+		ptr = kvmalloc_array(nblocks, locksz, GFP_KERNEL);
+		if (!ptr)
+			return -ENOMEM;
 	}
+	for (i = 0; i < nblocks; i++)
+		spin_lock_init(&ptr[i]);
+	hashinfo->ehash_locks = ptr;
+set_mask:
 	hashinfo->ehash_locks_mask = nblocks - 1;
 	return 0;
 }
-- 
2.48.1.711.g2feabab25a-goog


