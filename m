Return-Path: <netdev+bounces-91415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8051F8B27BF
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 19:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E2028789E
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 17:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7803A14E2FA;
	Thu, 25 Apr 2024 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XRY6xKb2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85E414A4F9
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714067526; cv=none; b=KnHNi3svtmJjdNcki+9dbIne7+04jE6RsxHXvTbdnnpQfQTIkM7AYXcb8dsI6soydirXJS8jLajJ+1JXVU6aMIIQ/KPc0vxTgnvAJXzqinYoEyBPNqtbWQhet3DbVG/2PofcPzREIuYLBglNCbrcpERdmYMnFD+vYkOl5B0iOxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714067526; c=relaxed/simple;
	bh=07rOLN/apJK4cUkxhMiVe9naMk5B4dH94gqA6pwdIuo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kqIgg/yzmm7p+q3o8Fwnglf33elyJP1RlapY1SDojncnTNI7odyWx8OgoLX/UN7JwCBnXO33lG8Br821kRzGOpdq0d6wTMLpQ0oB31+wC2W8nV4IJlzdoSzIPTp/i/Y91nJnx21zjC7Ep1REhpTR1IUCYUPt0LJpZy87RdIUy8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XRY6xKb2; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714067525; x=1745603525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NRtFTe5DBtAas7TWac3P+pYCV7q67bcCm7kmg42An+8=;
  b=XRY6xKb2JAalUqIfi4GuktgZ2Xm5cdFnFagL/5EvYwylP3XOaF4oPQ3U
   Qb9x4SvkGmuC5iqaLHbw5jQ3oMZKjLWfrU+xxMx6tfL0Ox32C/BycI1Y5
   tYnV8utzgY5/MqJCEY+E54FyyL+KV4rWz5K8RE3fya5jltucW+c7Mcdjr
   k=;
X-IronPort-AV: E=Sophos;i="6.07,230,1708387200"; 
   d="scan'208";a="414720318"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 17:51:59 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:43638]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.211:2525] with esmtp (Farcaster)
 id a46698b2-be7b-4179-99a1-117ce1305c80; Thu, 25 Apr 2024 17:51:58 +0000 (UTC)
X-Farcaster-Flow-ID: a46698b2-be7b-4179-99a1-117ce1305c80
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 25 Apr 2024 17:51:57 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 25 Apr 2024 17:51:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 6/6] arp: Convert ioctl(SIOCGARP) to RCU.
Date: Thu, 25 Apr 2024 10:51:46 -0700
Message-ID: <20240425175146.73458-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iJEWs7AYSJqGCUABeVqOCTkErponfZdT5kV-iD=-SajnQ@mail.gmail.com>
References: <CANn89iJEWs7AYSJqGCUABeVqOCTkErponfZdT5kV-iD=-SajnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Apr 2024 19:12:56 +0200
> On Thu, Apr 25, 2024 at 7:02 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > ioctl(SIOCGARP) holds rtnl_lock() for __dev_get_by_name() and
> > later calls neigh_lookup(), which calls rcu_read_lock().
> >
> > Let's replace __dev_get_by_name() with dev_get_by_name_rcu() to
> > avoid locking rtnl_lock().
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/ipv4/arp.c | 26 +++++++++++++++++---------
> >  1 file changed, 17 insertions(+), 9 deletions(-)
> >
> > diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
> > index 5034920be85a..9430b64558cd 100644
> > --- a/net/ipv4/arp.c
> > +++ b/net/ipv4/arp.c
> > @@ -1003,11 +1003,15 @@ static int arp_rcv(struct sk_buff *skb, struct net_device *dev,
> >   *     User level interface (ioctl)
> >   */
> >
> > -static struct net_device *arp_req_dev_by_name(struct net *net, struct arpreq *r)
> > +static struct net_device *arp_req_dev_by_name(struct net *net, struct arpreq *r,
> > +                                             bool getarp)
> >  {
> >         struct net_device *dev;
> >
> > -       dev = __dev_get_by_name(net, r->arp_dev);
> > +       if (getarp)
> > +               dev = dev_get_by_name_rcu(net, r->arp_dev);
> > +       else
> > +               dev = __dev_get_by_name(net, r->arp_dev);
> >         if (!dev)
> >                 return ERR_PTR(-ENODEV);
> >
> > @@ -1028,7 +1032,7 @@ static struct net_device *arp_req_dev(struct net *net, struct arpreq *r)
> >         __be32 ip;
> >
> >         if (r->arp_dev[0])
> > -               return arp_req_dev_by_name(net, r);
> > +               return arp_req_dev_by_name(net, r, false);
> >
> >         if (r->arp_flags & ATF_PUBL)
> >                 return NULL;
> > @@ -1166,7 +1170,7 @@ static int arp_req_get(struct net *net, struct arpreq *r)
> >         if (!r->arp_dev[0])
> >                 return -ENODEV;
> >
> > -       dev = arp_req_dev_by_name(net, r);
> > +       dev = arp_req_dev_by_name(net, r, true);
> >         if (IS_ERR(dev))
> >                 return PTR_ERR(dev);
> >
> > @@ -1287,23 +1291,27 @@ int arp_ioctl(struct net *net, unsigned int cmd, void __user *arg)
> >         else if (*netmask && *netmask != htonl(0xFFFFFFFFUL))
> >                 return -EINVAL;
> >
> > -       rtnl_lock();
> > -
> >         switch (cmd) {
> >         case SIOCDARP:
> > +               rtnl_lock();
> >                 err = arp_req_delete(net, &r);
> > +               rtnl_unlock();
> >                 break;
> >         case SIOCSARP:
> > +               rtnl_lock();
> >                 err = arp_req_set(net, &r);
> > +               rtnl_unlock();
> >                 break;
> >         case SIOCGARP:
> > +               rcu_read_lock();
> >                 err = arp_req_get(net, &r);
> > +               rcu_read_unlock();
> 
> 
> Note that arp_req_get() uses :
> 
> strscpy(r->arp_dev, dev->name, sizeof(r->arp_dev));
> 
> This currently depends on RTNL or devnet_rename_sem

Ah, I missed this point, thanks for catching!


> 
> Perhaps we should add a helper and use a seqlock to safely copy
> dev->name into a temporary variable.

So it's preferable to add seqlock around memcpy() in dev_change_name()
and use a helper in arp_req_get() rather than adding devnet_rename_sem
locking around memcpy() in arp_req_get() ?

