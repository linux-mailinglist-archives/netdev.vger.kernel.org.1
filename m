Return-Path: <netdev+bounces-163469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A76A2A52A
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 10:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED314162302
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083BC22616D;
	Thu,  6 Feb 2025 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XXKGbobf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7832144BE
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835568; cv=none; b=lkYgjzxCg7Vhz5XZeTD99ubcA1aJwojB0HBv84tR2msndJTnaSbVu0xapf8RS9sX1Ct0e/jsi91aZYzAivOY/yDBhVi9fThoZCDfgw15gt8nUCGMx4hCiJQuJMapYL0G68+7F4KGAnYJZIBryAE9XBT40FjI29w1zQdE7QK4BGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835568; c=relaxed/simple;
	bh=DgodfuHLRgkFj/DWoIK1bX+rP0f/j1FS8C/1AC1vT98=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WnFi6m3vNts2ErtYHOR1/YjiLYvcUOTOTs3+nL29i04X4tJarY/FZjTbIAVsyxE2YhuvCw0+p9A/OH0dntgLckjAkSHuUDlVwLv2XsuZ1T2WcXZfeGHYosf3jl+6F9zvTmlkXNnP5zuWO8Re3qvc17tXRTZw8tIPUO7xlcSe714=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XXKGbobf; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738835568; x=1770371568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hFaL0uRp6QiU6/Z90M4mLdiEF1NJq9McWw+rEMf4mFM=;
  b=XXKGbobfNBLNTXz/oZyO1zpEiG74uLkJ4DuaZNFTI9Fw1zdtqgJnP38K
   37iM2l9rzE24oFS3BCqF/Pt1if+hqFkERshynZfpU9OowSkd7pQHY4oBe
   /MwaZvFghWWTnSApVyTtBCbZsJtrAD3SufKgnU7l79XMkH4nETgiIN0y2
   g=;
X-IronPort-AV: E=Sophos;i="6.13,264,1732579200"; 
   d="scan'208";a="491630563"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 09:52:42 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:28235]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.183:2525] with esmtp (Farcaster)
 id ec64845d-d886-45c4-9acd-3dcc3742c661; Thu, 6 Feb 2025 09:52:41 +0000 (UTC)
X-Farcaster-Flow-ID: ec64845d-d886-45c4-9acd-3dcc3742c661
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 6 Feb 2025 09:52:40 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 6 Feb 2025 09:52:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <horms@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 6/6] fib: rules: Convert RTM_DELRULE to per-netns RTNL.
Date: Thu, 6 Feb 2025 18:52:21 +0900
Message-ID: <20250206095221.24542-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CANn89iLhtzeM+0oO_SQuK5sbj_ueVk63wE37qhS84wPdc-jbzw@mail.gmail.com>
References: <CANn89iLhtzeM+0oO_SQuK5sbj_ueVk63wE37qhS84wPdc-jbzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Feb 2025 10:41:12 +0100
> On Thu, Feb 6, 2025 at 9:49 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > fib_nl_delrule() is the doit() handler for RTM_DELRULE but also called
> > 1;95;0cfrom vrf_newlink() in case something fails in vrf_add_fib_rules().
> >
> > In the latter case, RTNL is already held and the 3rd arg extack is NULL.
> >
> > Let's hold per-netns RTNL in fib_nl_delrule() if extack is NULL.
> >
> > Now we can place ASSERT_RTNL_NET() in call_fib_rule_notifiers().
> >
> > While at it, fib_rule r is moved to the suitable scope.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/core/fib_rules.c | 29 +++++++++++++++++++----------
> >  1 file changed, 19 insertions(+), 10 deletions(-)
> >
> > diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
> > index cc26c762fa9e..3430d026134d 100644
> > --- a/net/core/fib_rules.c
> > +++ b/net/core/fib_rules.c
> > @@ -371,7 +371,8 @@ static int call_fib_rule_notifiers(struct net *net,
> >                 .rule = rule,
> >         };
> >
> > -       ASSERT_RTNL();
> > +       ASSERT_RTNL_NET(net);
> 
> This warning will then fire in the vrf case, because vrf_fib_rule() is
> only holding the real RTNL,
> but not yet the net->rtnl_mutex ?

As it's RTM_NEWLINK, dev_net(net)'s per-netns RTNL is held here and
vrf_fib_rule() sets skb->sk = dev_net(dev)->rtnl, so I think it won't fire.


> 
> > +
> >         /* Paired with READ_ONCE() in fib_rules_seq() */
> >         WRITE_ONCE(ops->fib_rules_seq, ops->fib_rules_seq + 1);
> >         return call_fib_notifiers(net, event_type, &info.info);
> > @@ -909,13 +910,13 @@ EXPORT_SYMBOL_GPL(fib_nl_newrule);
> >  int fib_nl_delrule(struct sk_buff *skb, struct nlmsghdr *nlh,
> >                    struct netlink_ext_ack *extack)
> >  {
> > -       struct net *net = sock_net(skb->sk);
> > +       bool user_priority = false, hold_rtnl = !!extack;
> 
> I am not pleased with this heuristic hidden here.
> 
> At the very least a fat comment in drivers/net/vrf.c would be welcomed.

Will add a comment there in v2.

Thanks!

