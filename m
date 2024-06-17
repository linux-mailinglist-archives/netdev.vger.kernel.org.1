Return-Path: <netdev+bounces-104225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEBC90B997
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 20:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589481F225DA
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEF8198A20;
	Mon, 17 Jun 2024 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Sv0IFZBU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47418198E8A
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648522; cv=none; b=MT4uY8hxFYnUyaSNok7K3OktKPjOQzRh11S7LBJN4m8uYIKDrTS0J61hT35qt+eWoTKXlL78hyAZWmaFG5x/3Z7M9g/1n1rJDEeagaEl1fB4zKEC8lqMAbM4s6tMZgdmOglxt+FxsRNy4vZKZ+JgY8V5QnlQrujGFSU6IVatFqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648522; c=relaxed/simple;
	bh=j2iFptuFlKvieivzm6je2n52dQSVubzPbK/W+dtg0eM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SH+zWXjYKgfWSYfrHFGsf04ZjDjggpGpdYfw7veTmZ1EIJBBWvBhMm26tewgsn990C2xBugMJFzog15HAAucgimczzTVB/O5g0fU6RIgwWzEKGOppXRwmC7779JtWmxJy799WR6jUVi8FLxwtTkUAvMOCLY228NBqja0XBMqyJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Sv0IFZBU; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718648521; x=1750184521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hp/EheK6EeJkt+jx20AcYHoCWAKkcq2DI1H5D3qWHs0=;
  b=Sv0IFZBUTpLYhNEMqcg28BulubhoDBnBIX8R1NqbGa72/9lo4ZmO86E8
   Sd6HMCpWRlL88Yz900X+Hhjuc3hB08yEqe1W2pvkOBOCnAVF3BpNAzgdz
   xNZbDHiigDWPnxrSrs8ex52/he+tEHFZhDN/rzuEzAnqabTnfoF5Ilifo
   8=;
X-IronPort-AV: E=Sophos;i="6.08,245,1712620800"; 
   d="scan'208";a="302777127"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 18:21:59 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:10641]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.242:2525] with esmtp (Farcaster)
 id 2d868d75-1900-4c4c-b50a-aa1c21f734c8; Mon, 17 Jun 2024 18:21:57 +0000 (UTC)
X-Farcaster-Flow-ID: 2d868d75-1900-4c4c-b50a-aa1c21f734c8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 17 Jun 2024 18:21:57 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 17 Jun 2024 18:21:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mhal@rbox.co>
CC: <cong.wang@bytedance.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net 01/15] af_unix: Set sk->sk_state under unix_state_lock() for truly disconencted peer.
Date: Mon, 17 Jun 2024 11:21:46 -0700
Message-ID: <20240617182146.62299-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <4b894ffd-9fe2-4c15-a901-6765ab538a01@rbox.co>
References: <4b894ffd-9fe2-4c15-a901-6765ab538a01@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 17 Jun 2024 01:28:52 +0200
> On 6/10/24 19:49, Kuniyuki Iwashima wrote:
> > From: Michal Luczaj <mhal@rbox.co>
> > Date: Mon, 10 Jun 2024 14:55:08 +0200
> >> On 6/9/24 23:03, Kuniyuki Iwashima wrote:
> >>> (...)
> >>> Sorry, I think I was wrong and we can't use smp_store_release()
> >>> and smp_load_acquire(), and smp_[rw]mb() is needed.
> >>>
> >>> Given we avoid adding code in the hotpath in the original fix
> >>> 8866730aed510 [0], I prefer adding unix_state_lock() in the SOCKMAP
> >>> path again.
> >>>
> >>> [0]: https://lore.kernel.org/bpf/6545bc9f7e443_3358c208ae@john.notmuch/
> >>
> >> You're saying smp_wmb() in connect() is too much for the hot path, do I
> >> understand correctly?
> > 
> > Yes, and now I think WARN_ON_ONCE() would be enough because it's unlikely
> > that the delay happens between the two store ops and concurrent bpf()
> > is in progress.
> > 
> > If syzkaller was able to hit this on vanilla kernel, we can revisit.
> > 
> > Then, probably we could just do s/WARN_ON_ONCE/unlikely/ because users
> > who call bpf() in such a way know that the state was TCP_CLOSE while
> > calling bpf().
> > 
> > ---8<---
> > diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
> > index bd84785bf8d6..46dc747349f2 100644
> > --- a/net/unix/unix_bpf.c
> > +++ b/net/unix/unix_bpf.c
> > @@ -181,6 +181,9 @@ int unix_stream_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool r
> >  	 */
> >  	if (!psock->sk_pair) {
> >  		sk_pair = unix_peer(sk);
> > +		if (WARN_ON_ONCE(!sk_pair))
> > +			return -EINVAL;
> > +
> >  		sock_hold(sk_pair);
> >  		psock->sk_pair = sk_pair;
> >  	}
> > ---8<---
> 
> Oh. That's a peculiar approach :) But, hey, it's your call.
> 
> Another AF_UNIX sockmap issue is with OOB. When OOB packet is sent, skb is
> added to recv queue, but also u->oob_skb is set. Here's the problem: when
> this skb goes through bpf_sk_redirect_map() and is moved between socks,
> oob_skb remains set on the original sock.

Good catch!

> 
> [   23.688994] WARNING: CPU: 2 PID: 993 at net/unix/garbage.c:351 unix_collect_queue+0x6c/0xb0
> [   23.689019] CPU: 2 PID: 993 Comm: kworker/u32:13 Not tainted 6.10.0-rc2+ #137
> [   23.689021] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
> [   23.689024] Workqueue: events_unbound __unix_gc
> [   23.689027] RIP: 0010:unix_collect_queue+0x6c/0xb0
> 
> I wanted to write a patch, but then I realized I'm not sure what's the
> expected behaviour. Should the oob_skb setting follow to the skb's new sock
> or should it be dropped (similarly to what is happening today with
> scm_fp_list, i.e. redirect strips inflights)?

The former will require large refactoring as we need to check if the
redirect happens for BPF_F_INGRESS and if the redirected sk is also
SOCK_STREAM etc.

So, I'd go with the latter.  Probably we can check if skb is u->oob_skb
and drop OOB data and retry next in unix_stream_read_skb(), and forbid
MSG_OOB in unix_bpf_recvmsg().

Both features were merged in 5.15 and OOB was a month later than SOCKMAP,
so the Fixes tag would be 314001f0bf927 again, where ioctl(SIOCATMARK)
(and epoll(EPOLLPRI) after d9a232d435dcc was backported to all stable)
is lying due to redirected OOB msg.

Thanks!

