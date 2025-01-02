Return-Path: <netdev+bounces-154679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF13E9FF6B6
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 09:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81DB07A1040
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 08:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0971918FDC8;
	Thu,  2 Jan 2025 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sr16UcBm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8FA43ABD
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735805012; cv=none; b=WuU6fMgg3XZ0oqwkx57iZKJaaya90XrSwQGkSZShfvLpV8F6oFTI8Zb/2eHgCJ4Pfvj90IZk/JvNpr+vltehUfKVxFu0FgMH6qkCHGoQ0ZFMpGDdGVh6INz2LhA4Af09EVfJvBg1zgVl3hYAfWoJ9v4AHGaDURcJr6C6V3FRnY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735805012; c=relaxed/simple;
	bh=DR4wdnenOG8vHLkdyZnSN0AALnVlaywfGc5jqq5OiZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TmrhtcBR0oh9Ga6JyRs52hfIQgeaUqLciuBgkQqJ3TgViOWOkm63mynu+459EoLbjr4Hk7vaTDIesVdSiOriEmm8MZZL6bqq/bTld7Rk23FaWj2DMfskA2gtKegowYUCHGzw3bwVAtcOQ5XbbS4Chk/YGKvaOYyKNVndvcD34hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=sr16UcBm; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1735805012; x=1767341012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vTdFBj5R34xDjaxAEwjE5WkscJhpe8Yv2EvjwqGM+qE=;
  b=sr16UcBmaX1h6YRkJW5wdSIeK5dmgCW1TNReF1z23QHUqeLyEl53TsNb
   y+f22mmMxIPQFotLFaE2Mg25maAg3q1wKmJuaCQyUdAbIODICd567AdGa
   WcAtsOgWSqgoF4BlcEkWZB8TKW8+2gShuC5L1/XxmsL367I5mSOL54V2U
   I=;
X-IronPort-AV: E=Sophos;i="6.12,284,1728950400"; 
   d="scan'208";a="455844596"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 08:03:12 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:38769]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.219:2525] with esmtp (Farcaster)
 id 74d38b1e-fb68-4743-9f04-52dee7d2e846; Thu, 2 Jan 2025 08:03:11 +0000 (UTC)
X-Farcaster-Flow-ID: 74d38b1e-fb68-4743-9f04-52dee7d2e846
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 2 Jan 2025 08:03:11 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.0.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 2 Jan 2025 08:03:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <dzq.aishenghu0@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kerneljasonxing@gmail.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<kuniyu@amazon.com>
Subject: Re: perhaps inet_csk_reqsk_queue_is_full should also allow zero backlog
Date: Thu, 2 Jan 2025 17:02:58 +0900
Message-ID: <20250102080258.53858-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CAFmV8NffAhhBR74xiq6QmkmyDq00u9_GxORNk+0kbFHk9yNjcw@mail.gmail.com>
References: <CAFmV8NffAhhBR74xiq6QmkmyDq00u9_GxORNk+0kbFHk9yNjcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Zhongqiu Duan <dzq.aishenghu0@gmail.com>
Date: Wed, 1 Jan 2025 23:02:56 +0800
> On Wed, Jan 1, 2025 at 9:53 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
> >
> > On Tue, Dec 31, 2024 at 4:24 PM Zhongqiu Duan <dzq.aishenghu0@gmail.com> wrote:
> > >
> > > Hi all,
> > >
> > > We use a proprietary library in our product, it passes hardcoded zero
> > > as the backlog of listen().
> > > It works fine when syncookies is enabled, but when we disable syncookies
> > > by business requirement, no connection can be made.
> >
> > I'm not that sure that the problem you encountered is the same as
> > mine. I manage to reproduce it locally after noticing your report:
> > 1) write the simplest c code with passing 0 as the backlog
> > 2) adjust the value of net.ipv4.tcp_syncookies to see the different results
> >
> > When net.ipv4.tcp_syncookies is set zero only, the connection will not
> > be established.
> >
> 
> Yes, that's the problem I want to describe.
> 
> > >
> > > After some investigation, the problem is focused on the
> > > inet_csk_reqsk_queue_is_full().
> > >
> > > static inline int inet_csk_reqsk_queue_is_full(const struct sock *sk)
> > > {
> > >         return inet_csk_reqsk_queue_len(sk) >=
> > > READ_ONCE(sk->sk_max_ack_backlog);
> > > }
> > >
> > > I noticed that the stories happened to sk_acceptq_is_full() about this
> > > in the past, like
> > > the commit c609e6a (Revert "net: correct sk_acceptq_is_full()").
> > >
> > > Perhaps we can also avoid the problem by using ">" in the decision
> > > condition like
> > > `inet_csk_reqsk_queue_len(sk) > READ_ONCE(sk->sk_max_ack_backlog)`.
> >
> > According to the experiment I conducted, I agree the above triggers
> > the drop in tcp_conn_request(). When that sysctl is set to zero, the
> > return value of tcp_syn_flood_action() is false, which leads to an
> > immediate drop.
> >
> > Your changes in tcp_conn_request() can solve this issue, but you're
> > solving a not that valid issue which can be handled in a decent way as
> > below [1]. I can't see any good reason for passing zero as a backlog
> > value in listen() since the sk_max_ack_backlog would be zero for sure.
> >
> > [1]
> > I would also suggest trying the following two steps first like other people do:
> > 1) pass a larger backlog number when calling listen().
> > 2) adjust the sysctl net.core.somaxconn, say, a much larger one, like 40960
> >
> > Thanks,
> > Jason
> 
> Even though only one connection is needed for this proprietary library
> to work properly, I don't see any reason to set the backlog to zero
> either. But it just happened. We simply bin patch the 3rd party
> library to set a larger value for the backlog as a workaround.

A common technique is to specify -1 for listen() backlog.

Then you even need not know somaxconn but can use it as the max
backlog. (see __sys_listen_socket())

This is especially useful in a container env where app is not
allowed to read sysctl knobs.


> 
> Thanks for your suggestions, and I almost totally agree with you. I
> just want to discuss whether it should and deserves to make some
> changes in the kernel to keep the same behavior between
> sk_acceptq_is_full() and inet_csk_reqsk_queue_is_full().

I think you can post a patch to make it consistent with 64a146513f8f:

---8<---
commit 64a146513f8f12ba204b7bf5cb7e9505594ead42
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Tue Mar 6 11:21:05 2007 -0800

    [NET]: Revert incorrect accept queue backlog changes.
...
    A backlog value of N really does mean allow "N + 1" connections
    to queue to a listening socket.  This allows one to specify
    "0" as the backlog and still get 1 connection.
---8<---

