Return-Path: <netdev+bounces-163809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B214A2BA0C
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 05:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9596A1660AD
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 04:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18105231C9F;
	Fri,  7 Feb 2025 04:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XXEzZ+qN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8BA1EA6F
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 04:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738901542; cv=none; b=KIJTUPRKUWSUgGo5Z2OJoHfQzWXJ312FtLgRvcUigc46bOZwe5jJKJ54pS8Nk+KxugIBXYDuBd3+beekm4BgGLSTS34pGzhlWlu1d9zw6hE6mNgUc0LhzacLF+Xeub8pXZgMpv4H6hGCDWT9C9NYmGQCnGIqAMQfYEA6gFVsM0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738901542; c=relaxed/simple;
	bh=mRaIO3udB9dectaJlJREBdkDNSd8K3lU2ZSVb/N2IJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWuejiHMTymo/76DnFGuQkatFwZH0Akilw1M1G7+Z18GzcCMNcm5IcC2E6yhsPDZHo5E7yB8aPWGvt82H89q8MX/Mbu53+Vqo0+vobbqJHU9/q53NF90ByvWa2b2onkEmTo1TrMB3rU/GGd2eLszF/251ZBse2wrU27nRpdaVJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XXEzZ+qN; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738901540; x=1770437540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R1lfpvRTxdPRzruPT7643d7A59CEqbl0rJSWU1SdDJ8=;
  b=XXEzZ+qNI/u7pfKvYxboCskjmUGP66u7Sb7cBpabQ1MgkmYA4eWUgtn8
   cYuwLUS6EFff7iSQHiB1d24qKbeDs29svxqjfIFjnvdupipbe5fP2+vmP
   51yJ25BE5dgPvbDSxZ54vUPbBtj/nsJq1KQvtYx9n4+M1Bg6NavWIJP4n
   0=;
X-IronPort-AV: E=Sophos;i="6.13,266,1732579200"; 
   d="scan'208";a="20484489"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 04:12:18 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:61475]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.120:2525] with esmtp (Farcaster)
 id 0c61e30d-8503-4325-8fe8-0b3dbd232361; Fri, 7 Feb 2025 04:12:17 +0000 (UTC)
X-Farcaster-Flow-ID: 0c61e30d-8503-4325-8fe8-0b3dbd232361
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 7 Feb 2025 04:12:16 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.243.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Feb 2025 04:12:13 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <idosch@idosch.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 6/6] fib: rules: Convert RTM_DELRULE to per-netns RTNL.
Date: Fri, 7 Feb 2025 13:12:04 +0900
Message-ID: <20250207041204.55334-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <Z6SbdEENQ9Qku6av@shredder>
References: <Z6SbdEENQ9Qku6av@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Ido Schimmel <idosch@idosch.org>
Date: Thu, 6 Feb 2025 13:22:28 +0200
> On Thu, Feb 06, 2025 at 06:52:21PM +0900, Kuniyuki Iwashima wrote:
> > From: Eric Dumazet <edumazet@google.com>
> > Date: Thu, 6 Feb 2025 10:41:12 +0100
> > > On Thu, Feb 6, 2025 at 9:49 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > > >
> > > > fib_nl_delrule() is the doit() handler for RTM_DELRULE but also called
> > > > 1;95;0cfrom vrf_newlink() in case something fails in vrf_add_fib_rules().
> > > >
> > > > In the latter case, RTNL is already held and the 3rd arg extack is NULL.
> > > >
> > > > Let's hold per-netns RTNL in fib_nl_delrule() if extack is NULL.
> > > >
> > > > Now we can place ASSERT_RTNL_NET() in call_fib_rule_notifiers().
> > > >
> > > > While at it, fib_rule r is moved to the suitable scope.
> > > >
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > ---
> > > >  net/core/fib_rules.c | 29 +++++++++++++++++++----------
> > > >  1 file changed, 19 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
> > > > index cc26c762fa9e..3430d026134d 100644
> > > > --- a/net/core/fib_rules.c
> > > > +++ b/net/core/fib_rules.c
> > > > @@ -371,7 +371,8 @@ static int call_fib_rule_notifiers(struct net *net,
> > > >                 .rule = rule,
> > > >         };
> > > >
> > > > -       ASSERT_RTNL();
> > > > +       ASSERT_RTNL_NET(net);
> > > 
> > > This warning will then fire in the vrf case, because vrf_fib_rule() is
> > > only holding the real RTNL,
> > > but not yet the net->rtnl_mutex ?
> > 
> > As it's RTM_NEWLINK, dev_net(net)'s per-netns RTNL is held here and
> > vrf_fib_rule() sets skb->sk = dev_net(dev)->rtnl, so I think it won't fire.
> 
> Yes, I believe you're correct. I ran fib_rule_tests.sh with a debug
> config and CONFIG_DEBUG_NET_SMALL_RTNL=y and didn't see any splats.
> 
> BTW, did you consider adding this config option to
> kernel/configs/debug.config under "Networking Debugging"?

I haven't because CONFIG_DEBUG_NET_SMALL_RTNL is not strictly a
debugging config and will not help debugging for real issues like
other DEBUG_NET configs, but I don't have strong preference.

