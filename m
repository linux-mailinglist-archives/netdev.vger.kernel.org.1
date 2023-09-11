Return-Path: <netdev+bounces-32890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05E679AAB1
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 20:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1837A28137A
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 18:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D23156E3;
	Mon, 11 Sep 2023 18:05:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845C4AD2E
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 18:05:26 +0000 (UTC)
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC69103
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 11:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1694455525; x=1725991525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e3HOPvm9ivWd3LMjjSsdKnEcLSvXAqB/AXMmmqLhdZk=;
  b=r7Ug4Yb4O8WCQMbCDGKD5aLAHf2kADXL64ZE7Lu4V9gTHDhvCYMQW9aF
   iweAXqYJYBYocQWoAGg4cuzGLLhiamTHAbfjyqFCkMNONo2LpCSpdoQ22
   D8K0hHJdwvqK1IL8YlZi9tdaG0bTyuRDRAKQfDK4g0qvB9ogCMR9TgvpI
   M=;
X-IronPort-AV: E=Sophos;i="6.02,244,1688428800"; 
   d="scan'208";a="1153583988"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-9fe6ad2f.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 18:05:18 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1a-m6i4x-9fe6ad2f.us-east-1.amazon.com (Postfix) with ESMTPS id 23BF8815E0;
	Mon, 11 Sep 2023 18:05:14 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 11 Sep 2023 18:05:14 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 11 Sep 2023 18:05:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <joannelkoong@gmail.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net 2/5] tcp: Fix bind() regression for v4-mapped-v6 non-wildcard address.
Date: Mon, 11 Sep 2023 11:05:03 -0700
Message-ID: <20230911180503.50024-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iLGDTb0FFL7=+e9zXz156+RZk0dSJXatgFmMx0vakOAAQ@mail.gmail.com>
References: <CANn89iLGDTb0FFL7=+e9zXz156+RZk0dSJXatgFmMx0vakOAAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.187.171.14]
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SPF_PERMERROR autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 11 Sep 2023 19:51:44 +0200
> On Mon, Sep 11, 2023 at 6:52 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > Since bhash2 was introduced, the example below does now work as expected.
> > These two bind() should conflict, but the 2nd bind() now succeeds.
> >
> >   from socket import *
> >
> >   s1 = socket(AF_INET6, SOCK_STREAM)
> >   s1.bind(('::ffff:127.0.0.1', 0))
> >
> >   s2 = socket(AF_INET, SOCK_STREAM)
> >   s2.bind(('127.0.0.1', s1.getsockname()[1]))
> >
> > During the 2nd bind() in inet_csk_get_port(), inet_bind2_bucket_find()
> > fails to find the 1st socket's tb2, so inet_bind2_bucket_create() allocates
> > a new tb2 for the 2nd socket.  Then, we call inet_csk_bind_conflict() that
> > checks conflicts in the new tb2 by inet_bhash2_conflict().  However, the
> > new tb2 does not include the 1st socket, thus the bind() finally succeeds.
> >
> > In this case, inet_bind2_bucket_match() must check if AF_INET6 tb2 has
> > the conflicting v4-mapped-v6 address so that inet_bind2_bucket_find()
> > returns the 1st socket's tb2.
> >
> > Note that if we bind two sockets to 127.0.0.1 and then ::FFFF:127.0.0.1,
> > the 2nd bind() fails properly for the same reason mentinoed in the previous
> > commit.
> >
> > Fixes: 28044fc1d495 ("net: Add a bhash2 table hashed by port and address")
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/ipv4/inet_hashtables.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> > index 0a9b20eb81c4..54505100c914 100644
> > --- a/net/ipv4/inet_hashtables.c
> > +++ b/net/ipv4/inet_hashtables.c
> > @@ -816,8 +816,15 @@ static bool inet_bind2_bucket_match(const struct inet_bind2_bucket *tb,
> >                                     int l3mdev, const struct sock *sk)
> >  {
> >  #if IS_ENABLED(CONFIG_IPV6)
> > -       if (sk->sk_family != tb->family)
> > +       if (sk->sk_family != tb->family) {
> > +               if (sk->sk_family == AF_INET)
> > +                       return net_eq(ib2_net(tb), net) && tb->port == port &&
> > +                               tb->l3mdev == l3mdev &&
> > +                               ipv6_addr_v4mapped(&tb->v6_rcv_saddr) &&
> > +                               tb->v6_rcv_saddr.s6_addr32[3] == sk->sk_rcv_saddr;
> > +
> >                 return false;
> > +       }
> >
> >         if (sk->sk_family == AF_INET6)
> >                 return net_eq(ib2_net(tb), net) && tb->port == port &&
> > --
> 
> Could we first factorize all these "net_eq(ib2_net(tb), net) &&
> tb->port == port" checks ?

That's much cleaner :)
I'll add a prep patch first in v2.

Thanks!

> 
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 7876b7d703cb5647086c45ca547c4caadc00c091..6240c802ed772272028e6e65bf90f345dd2d1619
> 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -832,24 +832,24 @@ static bool inet_bind2_bucket_match(const struct
> inet_bind2_bucket *tb,
>  bool inet_bind2_bucket_match_addr_any(const struct inet_bind2_bucket
> *tb, const struct net *net,
>                                       unsigned short port, int l3mdev,
> const struct sock *sk)
>  {
> +       if (!net_eq(ib2_net(tb), net) || tb->port != port)
> +               return false;
> +
>  #if IS_ENABLED(CONFIG_IPV6)
>         if (sk->sk_family != tb->family) {
>                 if (sk->sk_family == AF_INET)
> -                       return net_eq(ib2_net(tb), net) && tb->port == port &&
> -                               tb->l3mdev == l3mdev &&
> +                       return  tb->l3mdev == l3mdev &&
>                                 ipv6_addr_any(&tb->v6_rcv_saddr);
> 
>                 return false;
>         }
> 
>         if (sk->sk_family == AF_INET6)
> -               return net_eq(ib2_net(tb), net) && tb->port == port &&
> -                       tb->l3mdev == l3mdev &&
> +               return  tb->l3mdev == l3mdev &&
>                         ipv6_addr_any(&tb->v6_rcv_saddr);
>         else
>  #endif
> -               return net_eq(ib2_net(tb), net) && tb->port == port &&
> -                       tb->l3mdev == l3mdev && tb->rcv_saddr == 0;
> +               return tb->l3mdev == l3mdev && tb->rcv_saddr == 0;
>  }
> 
>  /* The socket's bhash2 hashbucket spinlock must be held when this is called */

