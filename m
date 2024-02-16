Return-Path: <netdev+bounces-72265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EED8573EC
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 04:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DBED1F22F47
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 03:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039C5DF58;
	Fri, 16 Feb 2024 03:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Gu9v1r6h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BFDFBE9
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 03:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708052607; cv=none; b=Fq0TuAR47pkSsz2B0n+F0YxlbwCesIgRePvbs4lMN4rxwW7etRCKXYJjJ/tZJ2aPHde9W+QiLxW808eqru8OzxQpDmejlULeWV0U1cyxUrFt0sqWEUMxsSeaKPPuGrlLJ+Xpe8cblv/oD9v1xBCmYB5NqEYS42ceZkAQYe7lRds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708052607; c=relaxed/simple;
	bh=FGWloxTrh/7U0Nt0BqWJYRTc/9xkuiOu14urztv2FKY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHKTkzfo46BpuXp73NSC21JXRR0cPnqSgA0izPMsWaSH83O4l4cStS9YLBYLVERV91afucAGpnDpfO4Insbk/Gk6O07tABq0Po1ZyBnJUDB95gBPp6MQJ1GpW5BUhkEu24EVibpahdDV7HsSZB/0s4964j6Z65HQgDcd6Q52ED4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Gu9v1r6h; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708052606; x=1739588606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DkyHHfqdNctWOCDb0mnrhOOWiqqDmE5txxs3C8tVI/s=;
  b=Gu9v1r6hg5BuiGd7XhG0G94CdF+LIfvZE4PI9kuBpdUaquJEIqo7N2/Z
   LQqydDcjiW6TjfoEn4A4OK7VWRVxcufg7ZZYEHjFJWP5Rwd28icX2jGZz
   SRUqIFdU5wtPNEtPXEEHhFJ0FIVx6vKS2YVS+iGE5d4YEvkv9zcvYvU7A
   M=;
X-IronPort-AV: E=Sophos;i="6.06,163,1705363200"; 
   d="scan'208";a="638286708"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:03:23 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:42673]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.203:2525] with esmtp (Farcaster)
 id ed73ecf4-112c-4660-afd8-605ddeb40063; Fri, 16 Feb 2024 03:03:22 +0000 (UTC)
X-Farcaster-Flow-ID: ed73ecf4-112c-4660-afd8-605ddeb40063
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 03:03:22 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 03:03:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v5 03/11] tcp: use drop reasons in cookie check for ipv4
Date: Thu, 15 Feb 2024 19:03:11 -0800
Message-ID: <20240216030311.54629-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAL+tcoDCOJCX8NerEpu_0gxhdPCABADRKSpBAJEXohTXBBqTSQ@mail.gmail.com>
References: <CAL+tcoDCOJCX8NerEpu_0gxhdPCABADRKSpBAJEXohTXBBqTSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D042UWB003.ant.amazon.com (10.13.139.135) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 16 Feb 2024 09:28:26 +0800
> On Fri, Feb 16, 2024 at 5:09 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > From: Jason Xing <kerneljasonxing@gmail.com>
> > Date: Thu, 15 Feb 2024 09:20:19 +0800
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Now it's time to use the prepared definitions to refine this part.
> > > Four reasons used might enough for now, I think.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > --
> > > v5:
> > > Link: https://lore.kernel.org/netdev/CANn89i+iELpsoea6+C-08m6+=JkneEEM=nAj-28eNtcOCkwQjw@mail.gmail.com/
> > > Link: https://lore.kernel.org/netdev/632c6fd4-e060-4b8e-a80e-5d545a6c6b6c@kernel.org/
> > > 1. Use SKB_DROP_REASON_IP_OUTNOROUTES instead of introducing a new one (Eric, David)
> > > 2. Reuse SKB_DROP_REASON_NOMEM to handle failure of request socket allocation (Eric)
> > > 3. Reuse NO_SOCKET instead of introducing COOKIE_NOCHILD
> > > ---
> > >  net/ipv4/syncookies.c | 18 +++++++++++++-----
> > >  1 file changed, 13 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > > index 38f331da6677..aeb61c880fbd 100644
> > > --- a/net/ipv4/syncookies.c
> > > +++ b/net/ipv4/syncookies.c
> > > @@ -421,8 +421,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
> > >               if (IS_ERR(req))
> > >                       goto out;

I noticed in this case (ret == sk) we can set drop reason in
tcp_v4_do_rcv() as INVALID_COOKIE or something else.


> > >       }
> > > -     if (!req)
> > > +     if (!req) {
> > > +             SKB_DR_SET(reason, NOMEM);
> >
> > NOMEM is not appropriate when mptcp_subflow_init_cookie_req() fails.
> 
> Thanks for your careful check. It's true. I didn't check the MPTCP
> path about how to handle it.
> 
> It also means that what I did to the cookie_v6_check() is also wrong.

Yes, same for the v6 change.


> 
> [...]
> > >       /* Try to redo what tcp_v4_send_synack did. */
> > >       req->rsk_window_clamp = tp->window_clamp ? :dst_metric(&rt->dst, RTAX_WINDOW);
> > > @@ -476,10 +482,12 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
> > >       /* ip_queue_xmit() depends on our flow being setup
> > >        * Normal sockets get it right from inet_csk_route_child_sock()
> > >        */
> > > -     if (ret)
> > > +     if (ret) {
> > >               inet_sk(ret)->cork.fl.u.ip4 = fl4;
> > > -     else
> > > +     } else {
> > > +             SKB_DR_SET(reason, NO_SOCKET);
> >
> > This also seems wrong to me.
> >
> > e.g. syn_recv_sock() could fail with sk_acceptq_is_full(sk),
> > then the listener is actually found.
> 
> Initially I thought using a not-that-clear name could be helpfull,
> though. NO_SOCKET here means no child socket can be used if I add a
> new description to SKB_DROP_REASON_NO_SOCKET.

Currently, NO_SOCKET is used only when sk lookup fails.  Mixing
different reasons sounds like pushing it back to NOT_SPECIFIED.
We could distinguish them by the caller IP though.


> 
> If the idea is proper, how about using NO_SOCKET for the first point
> you said to explain that there is no request socket that can be used?
> 
> If not, for both of the points you mentioned, it seems I have to add
> back those two new reasons (perhaps with a better name updated)?
> 1. Using SKB_DROP_REASON_REQSK_ALLOC for the first point (request
> socket allocation in cookie_v4/6_check())
> 2. Using SKB_DROP_REASON_GET_SOCK for the second point (child socket
> fetching in cookie_v4/6_check())
> 
> Now I'm struggling with the name and whether I should introduce some
> new reasons like what I did in the old version of the series :S

Why naming is hard would be because there are multiple reasons of
failure.  One way to be more specific is moving kfree_skb_reason()
into callee as you did in patch 2.


> If someone comes up with a good name or a good way to explain them,
> please tell me, thanks!

For 1. no idea :p

For 2. Maybe VALID_COOKIE ?  we drop the valid cookie in the same
function, but due to LSM or L3 layer, so the reason could be said
as L4-specific ?


> 
> also cc Eric, David
> 
> Thanks,
> Jason
> 

