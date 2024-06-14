Return-Path: <netdev+bounces-103438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B2E908078
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 03:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC30DB22013
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 01:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB81158D78;
	Fri, 14 Jun 2024 01:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ELkRxXvR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A6B157E7D;
	Fri, 14 Jun 2024 01:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718327166; cv=none; b=fXXKqpgf2+JbvpSb6hitr/+CwugV7dkv8nVjE2nT3SIpTzrE323rWt0OJ1Wx2NIfjlPwzHXplARRjSP+EIPX1jYl1eLl9tkYFPd1Otbdc1l5lK7rBTLK6LPLGiN51bvDXoZ6FVGBcTpAt7MuSz0rv2dDNtsim5sJfJjvLW1WOgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718327166; c=relaxed/simple;
	bh=YTjukw/BGV8mYAKxsl/K54ofbjuLrNGSXQDE42MMWnI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CyyZtbg5FTqvzYCWjpBSXaVA8d3pD1SG9G8jpQ4aRttfUvUEcXn0tBGSC36S4tKHsF3d683VBSlo/Vq6av+DK/ktpTr1LP/Nx1AjJMFZH3VL38HqCw7lk4U1Byqv4kgNyQyOEstqM8s/BiH5Dp4y4lk5MEPxTaoA2oy9QITudGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ELkRxXvR; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718327165; x=1749863165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rILIpK3Rb2EspulcRW6/eoNsK8bJDymZjW/BlfMedfU=;
  b=ELkRxXvR4L7E2lE4ebqeEsUT8BzTwXpXBC41uBPOcL60ces7lxpgFM9d
   FqXIYztBLv1hk5t9FewFJNhZK4Qo2Q9cMukbLNUjZbh/3Ov7qLZRb4rhy
   p6n3osDXn/Z9vGLB9HTY6nL0yOL/UMa4vtFpalKJpMPCXHOvuwWT+QIA8
   M=;
X-IronPort-AV: E=Sophos;i="6.08,236,1712620800"; 
   d="scan'208";a="4903152"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 01:06:02 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:47220]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.14:2525] with esmtp (Farcaster)
 id 7be474e4-5fa9-4293-97e0-606460cbbe37; Fri, 14 Jun 2024 01:06:00 +0000 (UTC)
X-Farcaster-Flow-ID: 7be474e4-5fa9-4293-97e0-606460cbbe37
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 01:06:00 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 01:05:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <penguin-kernel@i-love.sakura.ne.jp>
CC: <davem@davemloft.net>, <edumazet@google.com>, <jhs@mojatatu.com>,
	<jiri@resnulli.us>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <xiyou.wangcong@gmail.com>,
	<kuniyu@amazon.com>
Subject: Re: [net/sched] Question: Locks for clearing ERR_PTR() value from idrinfo->action_idr ?
Date: Thu, 13 Jun 2024 18:05:48 -0700
Message-ID: <20240614010548.71803-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <8d61200a-a739-4200-a8a3-5386a834d44f@I-love.SAKURA.ne.jp>
References: <8d61200a-a739-4200-a8a3-5386a834d44f@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Fri, 14 Jun 2024 09:58:48 +0900
> Hello.
> 
> syzbot is reporting hung task problems involving rtnl_muxex. A debug printk()
> patch added to linux-next-20240611 suggested that many of them are caused by
> an infinite busy loop inside tcf_idr_check_alloc().

I think the fix is:
https://lore.kernel.org/netdev/20240613071021.471432-1-druth@chromium.org/


> 
> ----------
> again:
> 		rcu_read_lock();
> 		p = idr_find(&idrinfo->action_idr, *index);
> 
> 		if (IS_ERR(p)) {
> 			/* This means that another process allocated
> 			 * index but did not assign the pointer yet.
> 			 */
> 			rcu_read_unlock();
> 			goto again;
> 		}
> ----------
> 
> Since there is no sleep (e.g. cond_resched()/schedule_timeout_uninterruptible(1))
> before "goto again;", once idr_find() returns an IS_ERR() value, all of that CPU's
> computation resource is wasted forever with rtnl_mutex held (and anybody else who
> tries to hold rtnl_mutex at rtnl_lock() is reported as hung task, resulting in
> various hung task reports waiting for rtnl_mutex at rtnl_lock()).
> 
> Therefore, I tried to add a sleep before "goto again;", but I can't know whether
> a sleep added to linux-next-20240612 solves the hung task problem because syzbot
> currently cannot test linux-next kernels due to some different problem.
> 
> Therefore, I'm posting a question here before syzbot can resume testing of
> linux-next kernels. As far as I can see, the ERR_PTR(-EBUSY) assigned at
> 
> 	mutex_lock(&idrinfo->lock);
> 	ret = idr_alloc_u32(&idrinfo->action_idr, ERR_PTR(-EBUSY), index, max,
> 			    GFP_KERNEL);
> 	mutex_unlock(&idrinfo->lock);
> 
> in tcf_idr_check_alloc() is cleared by either
> 
> 	mutex_lock(&idrinfo->lock);
> 	/* Remove ERR_PTR(-EBUSY) allocated by tcf_idr_check_alloc */
> 	WARN_ON(!IS_ERR(idr_remove(&idrinfo->action_idr, index)));
> 	mutex_unlock(&idrinfo->lock);
> 
> in tcf_idr_cleanup() or
> 
> 	mutex_lock(&idrinfo->lock);
> 	/* Replace ERR_PTR(-EBUSY) allocated by tcf_idr_check_alloc */
> 	idr_replace(&idrinfo->action_idr, a, a->tcfa_index);
> 	mutex_unlock(&idrinfo->lock);
> 
> in tcf_idr_insert_many().
> 
> But is there a possibility that rtnl_mutex is released between
> tcf_idr_check_alloc() and tcf_idr_{cleanup,insert_many}() ? If yes,
> adding a sleep before "goto again;" won't be sufficient. But if no,
> how can
> 
> 	/* This means that another process allocated
> 	 * index but did not assign the pointer yet.
> 	 */
> 
> happen (because both setting ERR_PTR(-EBUSY) and replacing with an !IS_ERR()
> value are done without temporarily releasing rtnl_mutex) ?
> 
> Is there a possibility that tcf_idr_check_alloc() is called without holding
> rtnl_mutex? If yes, adding a sleep before "goto again;" would help. But if no,
> is this a sign that some path forgot to call tcf_idr_{cleanup,insert_many}() ?

