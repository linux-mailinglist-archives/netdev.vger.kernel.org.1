Return-Path: <netdev+bounces-91454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E497E8B2A14
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 22:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D085B259EA
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 20:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4287C14D70C;
	Thu, 25 Apr 2024 20:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rfJWzMPD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7D911720
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714078065; cv=none; b=rMErIvNRyFgef/pV8teAXje2DCRvC9UXUK7SfEW/EcvsKODH3darJ3iu3KdYRRuxgQgFDfHSq44WaKR7xiqE7cpqYRHB/H0H0NbpJdXmR8q/rOsJOjNX9V/xTnB/e+fXqIFHx0l2fu/Djd98oz3qCJJ+SZMmEWZY3UlNA0xIbjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714078065; c=relaxed/simple;
	bh=EHt5zUjV7ZwuDQ2H7UEWfaVlfS8B58QFgaOjD97oCwg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZulQ1dpWcQnG8236a4NyF7mpOm3i4YHIda5cDVwYsMckQwDiHBSDYUI8YUAvFekW4G7YM7MCE814trF7kgfTT8Kzlv6IEoild0kf2BMxYXv4ILRZRAJuxtGkKrKNWfZ2GDKdkxvk4WQ0pzRPDlbY5hJMBIfzOveTnQq5P80606U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rfJWzMPD; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714078064; x=1745614064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7wgKOBh4p3y58lQMH90G9dgFHv1WgB4EdXkcuO04BfQ=;
  b=rfJWzMPDma6RLA6oWxpjwvE8uGdjASPDyN611KYgxctCn1Scy91Wx3sR
   Jtcrau0hC8BKWfhDAiW+roNQEzn/x+DX6fX8TOTCkdPy0WuVIGT6SyRY+
   Y+6QvW1UWgGlYCriXAyzV3MjCyoT5hRtaUr1StOGinJc/jt6faxegfuA0
   k=;
X-IronPort-AV: E=Sophos;i="6.07,230,1708387200"; 
   d="scan'208";a="290816250"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 20:47:42 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:32013]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.195:2525] with esmtp (Farcaster)
 id ba221815-1192-4c72-9808-e795cf1f8c4f; Thu, 25 Apr 2024 20:47:41 +0000 (UTC)
X-Farcaster-Flow-ID: ba221815-1192-4c72-9808-e795cf1f8c4f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 25 Apr 2024 20:47:36 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 25 Apr 2024 20:47:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 6/6] arp: Convert ioctl(SIOCGARP) to RCU.
Date: Thu, 25 Apr 2024 13:47:25 -0700
Message-ID: <20240425204725.98034-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iJGJQeYiUYX9a_tPB00fCibuOED_mbxZwcJAQLbMYiy8w@mail.gmail.com>
References: <CANn89iJGJQeYiUYX9a_tPB00fCibuOED_mbxZwcJAQLbMYiy8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Apr 2024 22:35:38 +0200
> On Thu, Apr 25, 2024 at 7:52 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > From: Eric Dumazet <edumazet@google.com>
> > Date: Thu, 25 Apr 2024 19:12:56 +0200
> > > On Thu, Apr 25, 2024 at 7:02 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > > >
> > > > ioctl(SIOCGARP) holds rtnl_lock() for __dev_get_by_name() and
> > > > later calls neigh_lookup(), which calls rcu_read_lock().
> > > >
> > > > Let's replace __dev_get_by_name() with dev_get_by_name_rcu() to
> > > > avoid locking rtnl_lock().
> > > >
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > ---
> > > >  net/ipv4/arp.c | 26 +++++++++++++++++---------
> > > >  1 file changed, 17 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
> > > > index 5034920be85a..9430b64558cd 100644
> > > > --- a/net/ipv4/arp.c
> > > > +++ b/net/ipv4/arp.c
> > > > @@ -1003,11 +1003,15 @@ static int arp_rcv(struct sk_buff *skb, struct net_device *dev,
> > > >   *     User level interface (ioctl)
> > > >   */
> > > >
> > > > -static struct net_device *arp_req_dev_by_name(struct net *net, struct arpreq *r)
> > > > +static struct net_device *arp_req_dev_by_name(struct net *net, struct arpreq *r,
> > > > +                                             bool getarp)
> > > >  {
> > > >         struct net_device *dev;
> > > >
> > > > -       dev = __dev_get_by_name(net, r->arp_dev);
> > > > +       if (getarp)
> > > > +               dev = dev_get_by_name_rcu(net, r->arp_dev);
> > > > +       else
> > > > +               dev = __dev_get_by_name(net, r->arp_dev);
> > > >         if (!dev)
> > > >                 return ERR_PTR(-ENODEV);
> > > >
> > > > @@ -1028,7 +1032,7 @@ static struct net_device *arp_req_dev(struct net *net, struct arpreq *r)
> > > >         __be32 ip;
> > > >
> > > >         if (r->arp_dev[0])
> > > > -               return arp_req_dev_by_name(net, r);
> > > > +               return arp_req_dev_by_name(net, r, false);
> > > >
> > > >         if (r->arp_flags & ATF_PUBL)
> > > >                 return NULL;
> > > > @@ -1166,7 +1170,7 @@ static int arp_req_get(struct net *net, struct arpreq *r)
> > > >         if (!r->arp_dev[0])
> > > >                 return -ENODEV;
> > > >
> > > > -       dev = arp_req_dev_by_name(net, r);
> > > > +       dev = arp_req_dev_by_name(net, r, true);
> > > >         if (IS_ERR(dev))
> > > >                 return PTR_ERR(dev);
> > > >
> > > > @@ -1287,23 +1291,27 @@ int arp_ioctl(struct net *net, unsigned int cmd, void __user *arg)
> > > >         else if (*netmask && *netmask != htonl(0xFFFFFFFFUL))
> > > >                 return -EINVAL;
> > > >
> > > > -       rtnl_lock();
> > > > -
> > > >         switch (cmd) {
> > > >         case SIOCDARP:
> > > > +               rtnl_lock();
> > > >                 err = arp_req_delete(net, &r);
> > > > +               rtnl_unlock();
> > > >                 break;
> > > >         case SIOCSARP:
> > > > +               rtnl_lock();
> > > >                 err = arp_req_set(net, &r);
> > > > +               rtnl_unlock();
> > > >                 break;
> > > >         case SIOCGARP:
> > > > +               rcu_read_lock();
> > > >                 err = arp_req_get(net, &r);
> > > > +               rcu_read_unlock();
> > >
> > >
> > > Note that arp_req_get() uses :
> > >
> > > strscpy(r->arp_dev, dev->name, sizeof(r->arp_dev));
> > >
> > > This currently depends on RTNL or devnet_rename_sem
> >
> > Ah, I missed this point, thanks for catching!
> >
> >
> > >
> > > Perhaps we should add a helper and use a seqlock to safely copy
> > > dev->name into a temporary variable.
> >
> > So it's preferable to add seqlock around memcpy() in dev_change_name()
> > and use a helper in arp_req_get() rather than adding devnet_rename_sem
> > locking around memcpy() in arp_req_get() ?
> 
> Under rcu_read_lock(), we can not sleep.
> 
> devnet_rename_sem is a semaphore... down_read() might sleep.

yes... -ENOCOFFEE :)


> 
> So if you plan using current netdev_get_name(), you must call it
> outside of rcu_read_lock() section.
>

Will add seqlock helper in v3.

Thanks!

