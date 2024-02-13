Return-Path: <netdev+bounces-71159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C59098527EB
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 05:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F081C227ED
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 04:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3FA8F72;
	Tue, 13 Feb 2024 04:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="shaJaJol"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D9BA923
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 04:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707797234; cv=none; b=F5LPXpSzBKF0SzHf+b3IjP0SYyK+6rXojONFd937IYvNYjy1MSck91H12Uc23RElT0hP4rl3r+2qK+UQu4zxcKUaRAIp/gfXay7IBosrpyUFeHk6upD2OhPN4tvG8aBxrFw2FjKgmpyA63K4xma2/jUcbhngwkmROaQJMzVQb/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707797234; c=relaxed/simple;
	bh=jKXLgG2BA4ME+OnpO5CLdKj4KBU2BAs6G7T7Yq0YKiA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPo5HQ9CF5E59koW4wNLdiPhBUUb9/DQV589dOQlBOxgHtDGe2BIX+tpTK4V9bQtbNt6k8cCw9n38azBjKT+ylko13Ek+1fVYe5xmyDb7fxNHSmIkXtYgkoDhPIYaMTwoLVGiSiMrZiqda6QaTig/u4Lo5tko4iwVr8Pw0CEX14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=shaJaJol; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707797233; x=1739333233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aZDg7RJacymGlceWD4rkjekoADMSwLdhtjay/fxV/vI=;
  b=shaJaJoltVBsxlwad5erJWq04k0c8SM0HkLhe73+PRaPG5VZHsbgwgCu
   lxaf1w9aUENdqzwDe5Q/x9ktcL4ROxVkoU3Jl1/qqgey+ovBeV1F8JWjG
   MbueYdtl/1f2XxV4UCVo/2wggliv93lBotVfX1lNIXaTE3DGg2GrI8VYa
   g=;
X-IronPort-AV: E=Sophos;i="6.06,156,1705363200"; 
   d="scan'208";a="612653442"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 04:07:10 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:28599]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.22:2525] with esmtp (Farcaster)
 id 31ce2559-56ff-41b4-a71a-4054d5957e89; Tue, 13 Feb 2024 04:07:09 +0000 (UTC)
X-Farcaster-Flow-ID: 31ce2559-56ff-41b4-a71a-4054d5957e89
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 13 Feb 2024 04:07:09 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Tue, 13 Feb 2024 04:07:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 3/6] tcp: add dropreasons in tcp_rcv_state_process()
Date: Mon, 12 Feb 2024 20:06:58 -0800
Message-ID: <20240213040658.86261-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAL+tcoAWURoNQEq-WckGs6eVQX6VFpHtw4CC9u4Nc7ab0aD+oA@mail.gmail.com>
References: <CAL+tcoAWURoNQEq-WckGs6eVQX6VFpHtw4CC9u4Nc7ab0aD+oA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 13 Feb 2024 09:48:04 +0800
> On Mon, Feb 12, 2024 at 11:33 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Mon, Feb 12, 2024 at 10:29 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> >
> >
> > >                         if (!acceptable)
> > > -                               return 1;
> > > +                               /* This reason isn't clear. We can refine it in the future */
> > > +                               return SKB_DROP_REASON_TCP_CONNREQNOTACCEPTABLE;
> >
> > tcp_conn_request() might return 0 when a syncookie has been generated.
> >
> > Technically speaking, the incoming SYN was not dropped :)
> 
> Hi Eric, Kuniyuki
> 
> Sorry, I should have checked tcp_conn_request() carefully last night.
> Today, I checked tcp_conn_request() over and over again.
> 
> I didn't find there is any chance to return a negative/positive value,
> only 0. It means @acceptable is always true and it should never return
> TCP_CONNREQNOTACCEPTABLE for TCP ipv4/6 protocol and never trigger a
> reset in this way.

Ah right, I remember I digged the same thing before and even in the
initial commit, conn_request() always returned 0 and tcp_rcv_state_process()
tested it with if (retval < 0).

I think we can clean up the leftover with some comments above
->conn_request() definition so that we can convert it to void
when we deprecate DCCP in the near future.


> 
> For DCCP, there are chances to return -1 in dccp_v4_conn_request().
> But I don't think we've already added drop reasons in DCCP before.
> 
> If I understand correctly, there is no need to do any refinement or
> even introduce TCP_CONNREQNOTACCEPTABLE new dropreason about the
> .conn_request() for TCP.
> 
> Should I add a NEW kfree_skb_reason() in tcp_conn_request() for those
> labels, like drop_and_release, drop_and_free, drop, and not return a
> drop reason to its caller tcp_rcv_state_process()?

Most interested reasons will be covered by

  - reqsk q : net_info_ratelimited() in tcp_syn_flood_action() or
              net_dbg_ratelimited() in pr_drop_req() or
              __NET_INC_STATS(net, LINUX_MIB_LISTENDROPS) in tcp_listendrop()
  - accept q: NET_INC_STATS(net, LINUX_MIB_LISTENOVERFLOWS) or
              __NET_INC_STATS(net, LINUX_MIB_LISTENDROPS) in tcp_listendrop()

and could be refined by drop reason, but I'm not sure if drop reason
is used under such a pressured situation.

Also, these failures are now treated with consume_skb().

Whichever is fine to me, no strong preference.


> 
> Please correct me if I'm wrong...
> 
> Thanks,
> Jason
> 
> >
> > I think you need to have a patch to change tcp_conn_request() and its
> > friends to return a 'refined' drop_reason
> > to avoid future questions / patches.

