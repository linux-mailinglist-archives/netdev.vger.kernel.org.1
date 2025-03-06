Return-Path: <netdev+bounces-172299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C224BA54192
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 05:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BCE97A2674
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 04:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF24C19992C;
	Thu,  6 Mar 2025 04:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qM201Grf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0618B10E4
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 04:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741234359; cv=none; b=qF7w3uVzDVILKFd93jBAuzkht71Jv3NgEkRv0dgeWJ6+BTBgCBc1vjoxzXLaNf4bZM0yVR7WM/+DAryKeAhIeULIg0ZRZHwwJHjEsT6v9Vg0ITd68dSgznHqh3W6Y53sxdjwlVKXIPg77Nu3rltXO5O+Hb/MO6D4Guedh+WEbVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741234359; c=relaxed/simple;
	bh=k2vXnU3pcfITIk3PWqY2sAkZ7zI7JvoWj2E52zcRWU0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b7KTmRM+7Ez2KQWWstsT6qvTCbuGIQ2DlsSFQqEX35KHfbfm9exUmVblp5E4krQNVP+BKXBlbs6ECDYB+p1FXfpU1kwxVC6UDTEWcd9fijozbELOTTUGpGhhkC3piUvVlP90O9n8jQsGShbAH5zh8jferaZ92t8f1cw9Ix8YQ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qM201Grf; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741234358; x=1772770358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aAIn2+nQS8CbTNQwuNNJFHxy2iVt6BlArG69S784GIs=;
  b=qM201GrfiFkjPksd/kbHe1tQHet5wG3awH1tdM4qmNEoO1r3sl+dS55b
   RMb/5GM6YIacpP1Lw9FHs8efDdxUAWbM+HxsPNgZdPCxBJT/xUMIKRljg
   iJrCzxPJByr/IV7GywA2lJgODf2TlBe721oZOSAg0XiDYcWoKdmZ+QjJj
   0=;
X-IronPort-AV: E=Sophos;i="6.14,225,1736812800"; 
   d="scan'208";a="276769971"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 04:12:35 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:63373]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.238:2525] with esmtp (Farcaster)
 id 25f8aaae-3f94-403a-94bc-a7a293addd6c; Thu, 6 Mar 2025 04:12:33 +0000 (UTC)
X-Farcaster-Flow-ID: 25f8aaae-3f94-403a-94bc-a7a293addd6c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 6 Mar 2025 04:12:33 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.191.155) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 6 Mar 2025 04:12:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <eric.dumazet@gmail.com>,
	<horms@kernel.org>, <kernelxing@tencent.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <ncardwell@google.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net-next] tcp: bring back NUMA dispersion in inet_ehash_locks_alloc()
Date: Wed, 5 Mar 2025 20:12:16 -0800
Message-ID: <20250306041221.68626-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CAL+tcoBvzg=+3i=pGbkP0o3RkH6Yy8-FUTdN4tMMM+BdBUv1oQ@mail.gmail.com>
References: <CAL+tcoBvzg=+3i=pGbkP0o3RkH6Yy8-FUTdN4tMMM+BdBUv1oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Mar 2025 11:35:27 +0800
> On Wed, Mar 5, 2025 at 9:06 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > We have platforms with 6 NUMA nodes and 480 cpus.
> >
> > inet_ehash_locks_alloc() currently allocates a single 64KB page
> > to hold all ehash spinlocks. This adds more pressure on a single node.
> >
> > Change inet_ehash_locks_alloc() to use vmalloc() to spread
> > the spinlocks on all online nodes, driven by NUMA policies.
> >
> > At boot time, NUMA policy is interleave=all, meaning that
> > tcp_hashinfo.ehash_locks gets hash dispersion on all nodes.
> >
> > Tested:
> >
> > lack5:~# grep inet_ehash_locks_alloc /proc/vmallocinfo
> > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_alloc+0x90/0x100 pages=16 vmalloc N0=2 N1=3 N2=3 N3=3 N4=3 N5=2
> >
> > lack5:~# echo 8192 >/proc/sys/net/ipv4/tcp_child_ehash_entries
> > lack5:~# numactl --interleave=all unshare -n bash -c "grep inet_ehash_locks_alloc /proc/vmallocinfo"
> > 0x000000004e99d30c-0x00000000763f3279   36864 inet_ehash_locks_alloc+0x90/0x100 pages=8 vmalloc N0=1 N1=2 N2=2 N3=1 N4=1 N5=1
> > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_alloc+0x90/0x100 pages=16 vmalloc N0=2 N1=3 N2=3 N3=3 N4=3 N5=2
> >
> > lack5:~# numactl --interleave=0,5 unshare -n bash -c "grep inet_ehash_locks_alloc /proc/vmallocinfo"
> > 0x00000000fd73a33e-0x0000000004b9a177   36864 inet_ehash_locks_alloc+0x90/0x100 pages=8 vmalloc N0=4 N5=4
> > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_alloc+0x90/0x100 pages=16 vmalloc N0=2 N1=3 N2=3 N3=3 N4=3 N5=2
> >
> > lack5:~# echo 1024 >/proc/sys/net/ipv4/tcp_child_ehash_entries
> > lack5:~# numactl --interleave=all unshare -n bash -c "grep inet_ehash_locks_alloc /proc/vmallocinfo"
> > 0x00000000db07d7a2-0x00000000ad697d29    8192 inet_ehash_locks_alloc+0x90/0x100 pages=1 vmalloc N2=1
> > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_alloc+0x90/0x100 pages=16 vmalloc N0=2 N1=3 N2=3 N3=3 N4=3 N5=2
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> Tested-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> 
> > ---
> >  net/ipv4/inet_hashtables.c | 37 ++++++++++++++++++++++++++-----------
> >  1 file changed, 26 insertions(+), 11 deletions(-)
> >
> > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> > index 9bfcfd016e18275fb50fea8d77adc8a64fb12494..2b4a588247639e0c7b2e70d1fc9b3b9b60256ef7 100644
> > --- a/net/ipv4/inet_hashtables.c
> > +++ b/net/ipv4/inet_hashtables.c
> > @@ -1230,22 +1230,37 @@ int inet_ehash_locks_alloc(struct inet_hashinfo *hashinfo)
> >  {
> >         unsigned int locksz = sizeof(spinlock_t);
> >         unsigned int i, nblocks = 1;
> > +       spinlock_t *ptr = NULL;
> >
> > -       if (locksz != 0) {
> > -               /* allocate 2 cache lines or at least one spinlock per cpu */
> > -               nblocks = max(2U * L1_CACHE_BYTES / locksz, 1U);
> > -               nblocks = roundup_pow_of_two(nblocks * num_possible_cpus());
> > +       if (locksz == 0)
> > +               goto set_mask;
> >
> > -               /* no more locks than number of hash buckets */
> > -               nblocks = min(nblocks, hashinfo->ehash_mask + 1);
> > +       /* Allocate 2 cache lines or at least one spinlock per cpu. */
> > +       nblocks = max(2U * L1_CACHE_BYTES / locksz, 1U) * num_possible_cpus();
> >
> > -               hashinfo->ehash_locks = kvmalloc_array(nblocks, locksz, GFP_KERNEL);
> > -               if (!hashinfo->ehash_locks)
> > -                       return -ENOMEM;
> > +       /* At least one page per NUMA node. */
> > +       nblocks = max(nblocks, num_online_nodes() * PAGE_SIZE / locksz);
> > +
> > +       nblocks = roundup_pow_of_two(nblocks);
> > +
> > +       /* No more locks than number of hash buckets. */
> > +       nblocks = min(nblocks, hashinfo->ehash_mask + 1);
> >
> > -               for (i = 0; i < nblocks; i++)
> > -                       spin_lock_init(&hashinfo->ehash_locks[i]);
> > +       if (num_online_nodes() > 1) {
> > +               /* Use vmalloc() to allow NUMA policy to spread pages
> > +                * on all available nodes if desired.
> > +                */
> > +               ptr = vmalloc_array(nblocks, locksz);
> 
> I wonder if at this point the memory shortage occurs, is it necessary
> to fall back to kvmalloc() later

If ptr is NULL here, kvmalloc_array() is called below.


> even when non-contiguous allocation
> fails? Could we return with -ENOMEM directly here? If so, I can cook a
> follow-up patch so that you don't need to revise this version:)
> 
> Thanks,
> Jason
> 
> > +       }
> > +       if (!ptr) {
> > +               ptr = kvmalloc_array(nblocks, locksz, GFP_KERNEL);
> > +               if (!ptr)
> > +                       return -ENOMEM;
> >         }
> > +       for (i = 0; i < nblocks; i++)
> > +               spin_lock_init(&ptr[i]);
> > +       hashinfo->ehash_locks = ptr;
> > +set_mask:
> >         hashinfo->ehash_locks_mask = nblocks - 1;
> >         return 0;
> >  }
> > --
> > 2.48.1.711.g2feabab25a-goog

