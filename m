Return-Path: <netdev+bounces-117872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7DC94FA42
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 01:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0AC71C212BD
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 23:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68FE183CCC;
	Mon, 12 Aug 2024 23:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="grw0ioEX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5C4170A22
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 23:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723505350; cv=none; b=VWxzxBk/Jfcl0Z5GV9nUvjrwJMTyDKTO68P6gPbMHUrmCPi+W1tBveB9Ri1jLxmfw0HdItOKWuzgi5l71ffHdmp3K0ZdrTE9TauNs9VhQn1QpxMi61tsmdNvBYNOoxf/2KHpahT6Ch81D9C3HjLyuvrxRAnh4aRccpEo8+qhFFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723505350; c=relaxed/simple;
	bh=BJoAiKoOPQQ8RbsZqA30uCaV8fqkvtk2O95bdqPVM6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U42sKIKhhPXjoRUdcJlM08k6t7Iwr6DtiRiYLPieHNu4FB4eG+2OmZYR1NUxzJSiLCcQhDnIANinOBHyWrfwAgYeCWZSLLQEyMdLKmpTy1rVaiRLPy8oLlXOdmdMSfCK7yf2btx4srREQ8Guto4Y9tcT9GhdfiR9fHverUgrncA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=grw0ioEX; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723505349; x=1755041349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S6tLE4VNe1gxX6/y61DxILsFGTtmTVGb/Ehqjx9w0mc=;
  b=grw0ioEX3tiqzILQWe+6TaHrYdHHzw4E6CXFUdspYxX0wzaYmYezLe7Q
   v94kHNas2uubDONxiaY+51kKPiPSUFNNG2sNSNUvCzgOmdrWNFbu328+A
   jul7LyJDqMI6dZ8CoJ6KclVuay+llbnk40IpC/fUJOTrw08lsf3Gv2Pzk
   w=;
X-IronPort-AV: E=Sophos;i="6.09,284,1716249600"; 
   d="scan'208";a="224939857"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 23:29:06 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:63322]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.23:2525] with esmtp (Farcaster)
 id dc18885e-82dc-47a8-9634-e78345369b8b; Mon, 12 Aug 2024 23:28:54 +0000 (UTC)
X-Farcaster-Flow-ID: dc18885e-82dc-47a8-9634-e78345369b8b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 12 Aug 2024 23:28:53 +0000
Received: from 88665a182662.ant.amazon.com (10.142.139.164) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 12 Aug 2024 23:28:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <fw@strlen.de>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kerneljasonxing@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com>
Subject: Re: [PATCH net] tcp: prevent concurrent execution of tcp_sk_exit_batch
Date: Mon, 12 Aug 2024 16:28:42 -0700
Message-ID: <20240812232842.92219-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240812222857.29837-1-fw@strlen.de>
References: <20240812222857.29837-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Florian Westphal <fw@strlen.de>
Date: Tue, 13 Aug 2024 00:28:25 +0200
> Its possible that two threads call tcp_sk_exit_batch() concurrently,
> once from the cleanup_net workqueue, once from a task that failed to clone
> a new netns.  In the latter case, error unwinding calls the exit handlers
> in reverse order for the 'failed' netns.
> 
> tcp_sk_exit_batch() calls tcp_twsk_purge().
> Problem is that since commit b099ce2602d8 ("net: Batch inet_twsk_purge"),
> this function picks up twsk in any dying netns, not just the one passed
> in via exit_batch list.
> 
> This means that the error unwind of setup_net() can "steal" and destroy
> timewait sockets belonging to the exiting netns.
> 
> This allows the netns exit worker to proceed to call
> 
> WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount));
> 
> without the expected 1 -> 0 transition, which then splats.
> 
> At same time, error unwind path that is also running inet_twsk_purge()
> will splat as well:
> 
> WARNING: .. at lib/refcount.c:31 refcount_warn_saturate+0x1ed/0x210
> ...
>  refcount_dec include/linux/refcount.h:351 [inline]
>  inet_twsk_kill+0x758/0x9c0 net/ipv4/inet_timewait_sock.c:70
>  inet_twsk_deschedule_put net/ipv4/inet_timewait_sock.c:221
>  inet_twsk_purge+0x725/0x890 net/ipv4/inet_timewait_sock.c:304
>  tcp_sk_exit_batch+0x1c/0x170 net/ipv4/tcp_ipv4.c:3522
>  ops_exit_list+0x128/0x180 net/core/net_namespace.c:178
>  setup_net+0x714/0xb40 net/core/net_namespace.c:375
>  copy_net_ns+0x2f0/0x670 net/core/net_namespace.c:508
>  create_new_namespaces+0x3ea/0xb10 kernel/nsproxy.c:110
> 
> ... because refcount_dec() of tw_refcount unexpectedly dropped to 0.
> 
> This doesn't seem like an actual bug (no tw sockets got lost and I don't
> see a use-after-free) but as erroneous trigger of debug check.

I guess the reason you don't move the check back to tcp_sk_exit() is
to catch a potential issue explained in solution 4 in the link, right ?

Then,

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

> 
> Add a mutex to force strict ordering: the task that calls tcp_twsk_purge()
> blocks other task from doing final _dec_and_test before mutex-owner has
> removed all tw sockets of dying netns.
> 
> Fixes: e9bd0cca09d1 ("tcp: Don't allocate tcp_death_row outside of struct netns_ipv4.")
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Jason Xing <kerneljasonxing@gmail.com>
> Reported-by: syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/0000000000003a5292061f5e4e19@google.com/
> Link: https://lore.kernel.org/netdev/20240812140104.GA21559@breakpoint.cc/
> Signed-off-by: Florian Westphal <fw@strlen.de>


