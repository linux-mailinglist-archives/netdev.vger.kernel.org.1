Return-Path: <netdev+bounces-117877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1976494FA86
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 02:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164021C221C6
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 00:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC4E19A;
	Tue, 13 Aug 2024 00:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="m3nW1T3t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B7018E
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 00:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723507304; cv=none; b=iZFSZKoNNCjkxAyr5UqxRGe8CFVyRSaCpoB6APHnQ3sRy6dxpxXSRvCTh5TY6FiaY5usFQhQgkmJRkkORy1WUKwEuF3bN93QR5vMvrK4xG5KpIiLktB1NaNJY5MsUImjCtsjAGcoV+9AYyWdteZNa3vkNNo4fdnmGv/KG4jFEFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723507304; c=relaxed/simple;
	bh=T1J8xxlfC1Z7twrySOR4NPP4u/Js6trBWP7ECxBAhLk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1+L8JR+8frwumQ9htcsL5015rh3/ywo5ugqyLzHHF4w+FOsjzFfyuvXX4nWuvECxJREago5HmXMEkkDqAGCOdw7g9mONXxcOUlUD24KGcOvRcbIGWhlpItvVtNjtKBadRoz3r121m+b0xVhpYthWnkmtl/ius4qOfW+1dFvuZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=m3nW1T3t; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723507304; x=1755043304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LFSIxs5NHVsTXm9RZhZ8Cl36iSh/BWEJoO8dXTfomPI=;
  b=m3nW1T3t2Rw6BqQVn8mUQeEM0nmwavpo7ygwfjuznVuL+sTCPr02oz8/
   zWhjSQtpzNAAH1B47AiW1bYqsEhUpI314JFOZ+UmTsMIb1vV+IFSH5qvv
   +v4kQkTuoRpHoUOtQiESqz6bH0+3YlcyP7zWxCKmSjnomcN9H1IlkrtOo
   M=;
X-IronPort-AV: E=Sophos;i="6.09,284,1716249600"; 
   d="scan'208";a="320369520"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 00:01:40 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:49232]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.23:2525] with esmtp (Farcaster)
 id 4c895e93-ed58-4370-902b-a7bc9197c87e; Tue, 13 Aug 2024 00:01:39 +0000 (UTC)
X-Farcaster-Flow-ID: 4c895e93-ed58-4370-902b-a7bc9197c87e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 13 Aug 2024 00:01:38 +0000
Received: from 88665a182662.ant.amazon.com (10.142.139.164) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 13 Aug 2024 00:01:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <fw@strlen.de>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kerneljasonxing@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com>
Subject: Re: [PATCH net] tcp: prevent concurrent execution of tcp_sk_exit_batch
Date: Mon, 12 Aug 2024 17:01:28 -0700
Message-ID: <20240813000128.95086-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240812235259.GA6030@breakpoint.cc>
References: <20240812235259.GA6030@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Florian Westphal <fw@strlen.de>
Date: Tue, 13 Aug 2024 01:52:59 +0200
> Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > > ... because refcount_dec() of tw_refcount unexpectedly dropped to 0.
> > > 
> > > This doesn't seem like an actual bug (no tw sockets got lost and I don't
> > > see a use-after-free) but as erroneous trigger of debug check.
> > 
> > I guess the reason you don't move the check back to tcp_sk_exit() is
> 
> No, it would not work. .exit runs before .exit_batch, we'd splat.

ahh, sorry, somehow I checked the order of exit_batch_rtnl() and
ops_exit_list() ... :/


> 
> Before e9bd0cca09d1 ordering doesn't matter because
> refcount_dec_and_test is used consistently, so it was not relevant
> if the 0-transition occured from .exit or later via inet_twsk_kill.
> 
> > to catch a potential issue explained in solution 4 in the link, right ?
> 
> Yes, it would help to catch such issue wrt. twsk lifetime.
> Having the WARN ensures no twsk can escape .exit_batch completion.
> 
> E.g. if twsk destructors in the future refer to some other
> object that has to be released before netns pointers become invalid
> or something like that.
> 
> Does that make sense?

Yes.


> Otherwise I'm open to alternative approaches.
> Or we can wait until syzbot finds a reproducer, I don't think its
> a real/urgent bug.

Agree, also I guess syzbot will not find a repro as it's been
3 months since the first report.

Thanks!

