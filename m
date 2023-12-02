Return-Path: <netdev+bounces-53173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CD18018EE
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 01:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D777281076
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 00:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9AD193;
	Sat,  2 Dec 2023 00:30:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 47852 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Dec 2023 16:30:45 PST
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F67710D
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 16:30:44 -0800 (PST)
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.160])
	by sina.com (10.75.12.45) with ESMTP
	id 656A7AAD00003FCA; Sat, 2 Dec 2023 08:30:39 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 67029331458185
X-SMAIL-UIID: 5EEAF98AFD5D40A386376B2B1A6BDC33-20231202-083039-1
From: Hillf Danton <hdanton@sina.com>
To: Eric Dumazet <edumazet@google.com>
Cc: xingwei lee <xrivendell7@gmail.com>,
	syzbot+9ada62e1dc03fdc41982@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in cleanup_net (3)
Date: Sat,  2 Dec 2023 08:30:27 +0800
Message-Id: <20231202003027.1081-1-hdanton@sina.com>
In-Reply-To: <CANn89iJsY8-_wBwpQt4oV7uF5hP73rFY-GX_GHLVaTUiys6Yig@mail.gmail.com>
References: <CANn89iJ7h_LFSV6n_9WmbTMwTMsZ0UgdBj_oGrnzcrZu7oCxFw@mail.gmail.com> <CABOYnLzq7XwbFncos1p8FOnDyVes4VDkjWE277TngdJqSie14A@mail.gmail.com> <20231201111253.1029-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 1 Dec 2023 13:52:49 +0100 Eric Dumazet <edumazet@google.com>
> On Fri, Dec 1, 2023 at 12:13 PM Hillf Danton <hdanton@sina.com> wrote:
> > On Fri, 1 Dec 2023 08:39:32 +0800 xingwei lee <xrivendell7@gmail.com>
> > > I forgot to CC others, repeat mail.
> > > Sorry, Dumazet. I found this bug with my modified syzkaller in my
> > > local environment.
> > > You are right, I crashed this bug about 10 times and used some
> > > heuristic solutions to increase the chances of luck with modifying
> > > syz-repro during this process.
> > > I can confirm the reproduction can trigger the bug soon and I hope it helps you.
> > > I'll test your patch and give your feedback ASAP.
> > >
> > > I apply your patch at
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3b47bc037bd44f142ac09848e8d3ecccc726be99
> > > with a little fix:
> > >
> > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > index fef349dd72fa..36d2871ac24f 100644
> > > --- a/net/core/sock.c
> > > +++ b/net/core/sock.c
> > > @@ -2197,8 +2197,6 @@ static void __sk_destruct(struct rcu_head *head)
> > >
> > >         if (likely(sk->sk_net_refcnt))
> > >                 put_net_track(sock_net(sk), &sk->ns_tracker);
> > > -       else
> > > -               __netns_tracker_free(sock_net(sk), &sk->ns_tracker, false);
> > >
> > >         sk_prot_free(sk->sk_prot_creator, sk);
> > >  }
> > > @@ -2212,6 +2210,9 @@ void sk_destruct(struct sock *sk)
> > >                 use_call_rcu = true;
> > >         }
> > >
> > > +       if (unlikely(!sk->sk_net_refcnt))
> > > +               __netns_tracker_free(sock_net(sk), &sk->ns_tracker, false);
> > > +
> > >         if (use_call_rcu)
> > >                 call_rcu(&sk->sk_rcu, __sk_destruct);
> > >         else
> > >
> > > and It's also trigger the crash like below:
> >
> > Looks like a refcount leak that could be cured with the diff below.
> > Only for thoughts.
> >
> > --- x/include/net/net_namespace.h
> > +++ y/include/net/net_namespace.h
> > @@ -320,7 +320,7 @@ static inline int check_net(const struct
> >         return 1;
> >  }
> >
> > -#define net_drop_ns NULL
> > +static void net_drop_ns(void *w) { }
> >  #endif
> >
> >
> > @@ -355,7 +355,7 @@ static inline void __netns_tracker_free(
> >  static inline struct net *get_net_track(struct net *net,
> >                                         netns_tracker *tracker, gfp_t gfp)
> >  {
> > -       get_net(net);
> > +       refcount_inc(&net->passive);
> >         netns_tracker_alloc(net, tracker, gfp);
> >         return net;
> >  }
> > @@ -363,7 +363,7 @@ static inline struct net *get_net_track(
> >  static inline void put_net_track(struct net *net, netns_tracker *tracker)
> >  {
> >         __netns_tracker_free(net, tracker, true);
> > -       put_net(net);
> > +       net_drop_ns(net);
> >  }
> >
> >  typedef struct {
> > --
> 
> I do not think so.If you saw my prior patch, my thinking was :
> 
> At netns dismantle, RDS is supposed to close all kernel sockets it created.
> 
> Because of RCU grace period imposed on TCP listeners, my concern was
> that we might have to release the sk->ns_tracker before
> the RCU grace period ended. (I think my patch makes sense anyway, I
> mentioned this race possibility in the past)
> 
> If the splat still occurs, this means that at the end of
> rds_tcp_listen_stop(), rds_tcp_listen_sock->sk refcount had not
> reached yet 0.
> 
> Therefore I think the bug is in RDS.

I suspect it is in RDS because we knew the synchronize_rcu() in
cleanup_net() failed to work [1].

[1] https://lore.kernel.org/lkml/CANn89iJj_VR0L7g3-0=aZpKbXfVo7=BG0tsb8rhiTBc4zi_EtQ@mail.gmail.com/
> 
> We could add a debug point in rds_tcp_listen_sock(), I suspect
> something in RDS got a sock_hold(sk)
> and did not release the refcount before we exit from rds_tcp_listen_stop()
> 
> Another way would be to add a tracker on sockets, but this seems a lot of work.

