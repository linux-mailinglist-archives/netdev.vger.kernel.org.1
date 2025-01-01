Return-Path: <netdev+bounces-154649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C11C9FF39E
	for <lists+netdev@lfdr.de>; Wed,  1 Jan 2025 10:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817793A2CAF
	for <lists+netdev@lfdr.de>; Wed,  1 Jan 2025 09:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB46D3D0D5;
	Wed,  1 Jan 2025 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="B8YUSRDD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6F73A1DB
	for <netdev@vger.kernel.org>; Wed,  1 Jan 2025 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735723677; cv=none; b=KSe+5kf+yoIn/ORMd9WQkBz8IeKNA8aT6iKlUUqqIS0UTtdlRxxppWdQevyMtaIf1CmOnnhijgAxx7IpLAqXgcLJ/ZGKfwkigttSqbAyDuF09suBgAaoQQ9kZtWoegViOqVUXuyWZTef1t5EjWIqXq3Jouog9SJlcreMF2mLwuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735723677; c=relaxed/simple;
	bh=6znzFBK3VCevw8nyfKTei4yTPRVHkxfc7WRN3LYAMtA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCxN2RpyeD3FazzqzlIgVeOVTsLHGnBjHMXEFfG6t6anoQYV/B3M5toGoFMIkIUfmEjODW4uTbJGmS8iYih+92Qucj1B32VDTiGHZtJymUaCP+0kakM1zPuwFZnWKOgMGS0v1a4W/aWOD/1DJmmW68ebHfrgVH3N94KXw7YNT1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=B8YUSRDD; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1735723674; x=1767259674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/xaSi/izF/0uQ/W5n+w/MST+0AZRV+K+aHTXbCGuEyQ=;
  b=B8YUSRDDrIKWzpNby/Xu49r3widGKwd93icbmHYNw/U9nHWGUGe4CFMM
   bZezw1F5lRHuF7A5XLLCIAyO/V2sUw5pJIUrxdLevGKdvqbfwr1gHtIXg
   KCpvNA4KTIJuiN/YsObnN8PYE06VP88GOBI1Zmty4DyhSkPdQKcyR0LBK
   U=;
X-IronPort-AV: E=Sophos;i="6.12,281,1728950400"; 
   d="scan'208";a="451010021"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2025 09:27:50 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:54162]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.75:2525] with esmtp (Farcaster)
 id 9ea0ef61-e037-40a5-9d5b-c5d7b1d07309; Wed, 1 Jan 2025 09:27:51 +0000 (UTC)
X-Farcaster-Flow-ID: 9ea0ef61-e037-40a5-9d5b-c5d7b1d07309
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 1 Jan 2025 09:27:51 +0000
Received: from 6c7e67c6786f.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 1 Jan 2025 09:27:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kafai@fb.com>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzbot+b3e02953598f447d4d2a@syzkaller.appspotmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v2 net] net: restrict SO_REUSEPORT to inet sockets
Date: Wed, 1 Jan 2025 18:27:36 +0900
Message-ID: <20250101092736.29054-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241231160527.3994168-1-edumazet@google.com>
References: <20241231160527.3994168-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 31 Dec 2024 16:05:27 +0000
> After blamed commit, crypto sockets could accidentally be destroyed
> from RCU call back, as spotted by zyzbot [1].
> 
> Trying to acquire a mutex in RCU callback is not allowed.
> 
> Restrict SO_REUSEPORT socket option to inet sockets.
> 
> v1 of this patch supported TCP, UDP and SCTP sockets,
> but fcnal-test.sh test needed RAW and ICMP support.
> 
> [1]
> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:562
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 24, name: ksoftirqd/1
> preempt_count: 100, expected: 0
> RCU nest depth: 0, expected: 0
> 1 lock held by ksoftirqd/1/24:
>   #0: ffffffff8e937ba0 (rcu_callback){....}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
>   #0: ffffffff8e937ba0 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2561 [inline]
>   #0: ffffffff8e937ba0 (rcu_callback){....}-{0:0}, at: rcu_core+0xa37/0x17a0 kernel/rcu/tree.c:2823
> Preemption disabled at:
>  [<ffffffff8161c8c8>] softirq_handle_begin kernel/softirq.c:402 [inline]
>  [<ffffffff8161c8c8>] handle_softirqs+0x128/0x9b0 kernel/softirq.c:537
> CPU: 1 UID: 0 PID: 24 Comm: ksoftirqd/1 Not tainted 6.13.0-rc3-syzkaller-00174-ga024e377efed #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>  <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   __might_resched+0x5d4/0x780 kernel/sched/core.c:8758
>   __mutex_lock_common kernel/locking/mutex.c:562 [inline]
>   __mutex_lock+0x131/0xee0 kernel/locking/mutex.c:735
>   crypto_put_default_null_skcipher+0x18/0x70 crypto/crypto_null.c:179
>   aead_release+0x3d/0x50 crypto/algif_aead.c:489
>   alg_do_release crypto/af_alg.c:118 [inline]
>   alg_sock_destruct+0x86/0xc0 crypto/af_alg.c:502
>   __sk_destruct+0x58/0x5f0 net/core/sock.c:2260
>   rcu_do_batch kernel/rcu/tree.c:2567 [inline]
>   rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
>   handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
>   run_ksoftirqd+0xca/0x130 kernel/softirq.c:950
>   smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
>   kthread+0x2f0/0x390 kernel/kthread.c:389
>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> 
> Fixes: 8c7138b33e5c ("net: Unpublish sk from sk_reuseport_cb before call_rcu")
> Reported-by: syzbot+b3e02953598f447d4d2a@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6772f2f4.050a0220.2f3838.04cb.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> Cc: Martin KaFai Lau <kafai@fb.com>
> ---
>  net/core/sock.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 74729d20cd0099e748f4c4fe0be42a2d2d47e77a..be84885f9290a6ada1e0a3f987273a017a524ece 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1295,7 +1295,10 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>  		sk->sk_reuse = (valbool ? SK_CAN_REUSE : SK_NO_REUSE);
>  		break;
>  	case SO_REUSEPORT:
> -		sk->sk_reuseport = valbool;
> +		if (valbool && !sk_is_inet(sk))
> +			ret = -EOPNOTSUPP;
> +		else
> +			sk->sk_reuseport = valbool;
>  		break;
>  	case SO_DONTROUTE:
>  		sock_valbool_flag(sk, SOCK_LOCALROUTE, valbool);
> -- 
> 2.47.1.613.gc27f4b7a9f-goog

