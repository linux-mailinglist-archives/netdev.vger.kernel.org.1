Return-Path: <netdev+bounces-72267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 707DE85754B
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 05:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BAAF284572
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 04:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DCC101C4;
	Fri, 16 Feb 2024 04:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gEd7/KEY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6AD17C7F
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 04:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708056711; cv=none; b=ZGRH608dVD9yIRyWcoQRLk3QHxSHKaQqHWRuXAsXD2rWWPOp5wEBjGUzZuKiKGj/uhgfkjUyS3BrbEkJMTTEz3BdnLFtUItaggHrJNDW59zQItO+gOPY0gULeJ88w2rFwwtTEvyV2jYQdZ5Rw3KxsSFQW7onHSxXo9wrY3ExENs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708056711; c=relaxed/simple;
	bh=DwuzLJiqE3ijOafzau+XaL5fc1iImxoGdxMoQ8lb4kk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ClHS+lqwDi1by8sw+hxB1smEOak3VSGT49HHzX9gf/v/vIDd+MfTFmK/SqJXijGCcrwG37GgYHfDW5Wh0AnpkS+dfT08hn9REd+IHaloQCrQhzD9/lzpG+yzmjMdKcJuzFi37hgDVpeN3Z/7KN0/FlUNYDOPY7usiv9vNt1Gf6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gEd7/KEY; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708056710; x=1739592710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lRzeR97kr34sC0M88m+WwF8So/Qs3yOJSxn+69st+4w=;
  b=gEd7/KEYuvl2xqUcfRt8lzOn9HHwTq7j2hMlogcl5w5Rie6UIuhgzBy1
   Iivdky7XmV/QfW7nCg79aMztJ8zhFSLCNbdvue8hTHbPhlrX9FVAsigcs
   fd7zvxc4Z9J8Gl36MmLAuqnjI6oZbBLOoxpbIQAWkD9m218OyB7Pi8ewN
   c=;
X-IronPort-AV: E=Sophos;i="6.06,163,1705363200"; 
   d="scan'208";a="274515852"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 04:11:47 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:20127]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.175:2525] with esmtp (Farcaster)
 id 4f23a2bd-5dbc-4b8b-8b7a-4a2a4ebc5e34; Fri, 16 Feb 2024 04:11:46 +0000 (UTC)
X-Farcaster-Flow-ID: 4f23a2bd-5dbc-4b8b-8b7a-4a2a4ebc5e34
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 04:11:46 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 04:11:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v5 03/11] tcp: use drop reasons in cookie check for ipv4
Date: Thu, 15 Feb 2024 20:11:36 -0800
Message-ID: <20240216041136.60555-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAL+tcoCrqUbHp1k9giaJL5AmGtsumVpMYDdcaXuNqpyKihLbkg@mail.gmail.com>
References: <CAL+tcoCrqUbHp1k9giaJL5AmGtsumVpMYDdcaXuNqpyKihLbkg@mail.gmail.com>
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
Date: Fri, 16 Feb 2024 11:50:45 +0800
> On Fri, Feb 16, 2024 at 11:03 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > From: Jason Xing <kerneljasonxing@gmail.com>
> > Date: Fri, 16 Feb 2024 09:28:26 +0800
> > > On Fri, Feb 16, 2024 at 5:09 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > > >
> > > > From: Jason Xing <kerneljasonxing@gmail.com>
> > > > Date: Thu, 15 Feb 2024 09:20:19 +0800
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > Now it's time to use the prepared definitions to refine this part.
> > > > > Four reasons used might enough for now, I think.
> > > > >
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > --
> > > > > v5:
> > > > > Link: https://lore.kernel.org/netdev/CANn89i+iELpsoea6+C-08m6+=JkneEEM=nAj-28eNtcOCkwQjw@mail.gmail.com/
> > > > > Link: https://lore.kernel.org/netdev/632c6fd4-e060-4b8e-a80e-5d545a6c6b6c@kernel.org/
> > > > > 1. Use SKB_DROP_REASON_IP_OUTNOROUTES instead of introducing a new one (Eric, David)
> > > > > 2. Reuse SKB_DROP_REASON_NOMEM to handle failure of request socket allocation (Eric)
> > > > > 3. Reuse NO_SOCKET instead of introducing COOKIE_NOCHILD
> > > > > ---
> > > > >  net/ipv4/syncookies.c | 18 +++++++++++++-----
> > > > >  1 file changed, 13 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > > > > index 38f331da6677..aeb61c880fbd 100644
> > > > > --- a/net/ipv4/syncookies.c
> > > > > +++ b/net/ipv4/syncookies.c
> > > > > @@ -421,8 +421,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
> > > > >               if (IS_ERR(req))
> > > > >                       goto out;
> >
> > I noticed in this case (ret == sk) we can set drop reason in
> > tcp_v4_do_rcv() as INVALID_COOKIE or something else.
> 
> If cookie_v4_check() returns the sk which is the same as the first
> parameter of its caller (tcp_v4_do_rcv()), then we cannot directly
> drop it

No, I meant we can just set drop reason, not calling kfree_skb_reason()
just after cookie_v4_check().

Then, in tcp_v4_do_rcv(), the default reason is NOT_SPECIFIED, but
INVALID_COOKIE only when cookie_v4_check() returns the listener.

---8<---
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 0c50c5a32b84..05cd697a7c07 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1923,6 +1923,8 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 			}
 			return 0;
 		}
+
+		reason = SKB_DROP_REASON_INVALID_COOKIE;
 	} else
 		sock_rps_save_rxhash(sk, skb);
 
---8<---


> because it is against old behaviours and causes errors. It
> should go into tcp_rcv_state_process() later. The similar mistake I
> made was reported by Paolo in the patch [0/11] (see link[1] as below).
> 
> link[1]: https://lore.kernel.org/netdev/c987d2c79e4a4655166eb8eafef473384edb37fb.camel@redhat.com/
> 
> >
> >
> > > > >       }
> > > > > -     if (!req)
> > > > > +     if (!req) {
> > > > > +             SKB_DR_SET(reason, NOMEM);
> > > >
> > > > NOMEM is not appropriate when mptcp_subflow_init_cookie_req() fails.
> > >
> > > Thanks for your careful check. It's true. I didn't check the MPTCP
> > > path about how to handle it.
> > >
> > > It also means that what I did to the cookie_v6_check() is also wrong.
> >
> > Yes, same for the v6 change.
> >
> >
> > >
> > > [...]
> > > > >       /* Try to redo what tcp_v4_send_synack did. */
> > > > >       req->rsk_window_clamp = tp->window_clamp ? :dst_metric(&rt->dst, RTAX_WINDOW);
> > > > > @@ -476,10 +482,12 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
> > > > >       /* ip_queue_xmit() depends on our flow being setup
> > > > >        * Normal sockets get it right from inet_csk_route_child_sock()
> > > > >        */
> > > > > -     if (ret)
> > > > > +     if (ret) {
> > > > >               inet_sk(ret)->cork.fl.u.ip4 = fl4;
> > > > > -     else
> > > > > +     } else {
> > > > > +             SKB_DR_SET(reason, NO_SOCKET);
> > > >
> > > > This also seems wrong to me.
> > > >
> > > > e.g. syn_recv_sock() could fail with sk_acceptq_is_full(sk),
> > > > then the listener is actually found.
> > >
> > > Initially I thought using a not-that-clear name could be helpfull,
> > > though. NO_SOCKET here means no child socket can be used if I add a
> > > new description to SKB_DROP_REASON_NO_SOCKET.
> >
> > Currently, NO_SOCKET is used only when sk lookup fails.  Mixing
> > different reasons sounds like pushing it back to NOT_SPECIFIED.
> > We could distinguish them by the caller IP though.
> 
> It makes some sense, but I still think NO_SOCKET is just a mixture of
> three kinds of cases (no sk during lookup process, no child sk, no
> reqsk).
> Let me think about it.
> 
> >
> >
> > >
> > > If the idea is proper, how about using NO_SOCKET for the first point
> > > you said to explain that there is no request socket that can be used?
> > >
> > > If not, for both of the points you mentioned, it seems I have to add
> > > back those two new reasons (perhaps with a better name updated)?
> > > 1. Using SKB_DROP_REASON_REQSK_ALLOC for the first point (request
> > > socket allocation in cookie_v4/6_check())
> > > 2. Using SKB_DROP_REASON_GET_SOCK for the second point (child socket
> > > fetching in cookie_v4/6_check())
> > >
> > > Now I'm struggling with the name and whether I should introduce some
> > > new reasons like what I did in the old version of the series :S
> >
> > Why naming is hard would be because there are multiple reasons of
> > failure.  One way to be more specific is moving kfree_skb_reason()
> > into callee as you did in patch 2.
> >
> >
> > > If someone comes up with a good name or a good way to explain them,
> > > please tell me, thanks!
> >
> > For 1. no idea :p
> >
> > For 2. Maybe VALID_COOKIE ?  we drop the valid cookie in the same
> > function, but due to LSM or L3 layer, so the reason could be said
> > as L4-specific ?
> 
> Thanks for your idea :)
> 
> For 2, if we're on the same page and talk about how to handle
> tcp_get_cookie_sock(), the name is not that appropriate because as you
> said in your previous email it could fail due to full of accept queue
> instead of cookie problem.

That's why I wrote _VALID_ COOKIE.  Here we know the cookie was valid
but somehow 3WHS failed.  If we want to be more specific, what is not
appropriate would be the place where we set the reason or call kfree_skb().


> 
> If we're talking about cookie_tcp_check(), the name is also not that
> good because the drop reason could be no memory which is unrelated to
> cookie, right?
> 
> COOKIE, it seems, cannot be the keyword/generic reason to conclude all
> the reasons for either of them...
> 
> Thanks,
> Jason
> 
> >
> >
> > >
> > > also cc Eric, David
> > >
> > > Thanks,
> > > Jason
> > >

