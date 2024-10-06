Return-Path: <netdev+bounces-132503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2186F991F55
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 17:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF2A1F21899
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 15:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534E717B4F5;
	Sun,  6 Oct 2024 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BKc0qCxr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F45170A0E
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728228343; cv=none; b=BtX/nW/QDi2LTz27Q1I6BrEO1wo/v/wuAzA2uXwGaBhCJkG5efDsw8p0Pyg+JdDU56ONtFxWgvjuI/+kJ1SLkJ4hIERWCaEt1jrPz9rWcxsOllDSKE9mpJqsr/dj+dA21P6rY6zB2azQg1O1oG3bN8xFHTYkeeehW3x3S45nDl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728228343; c=relaxed/simple;
	bh=fUGPi7y1Z1MeKw2rJyLqTCEe1aTyQnplUpiJugATJxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+yK+QMQC+A2Y1Vj6z/27t2eR5LvtGvJ4hK2GUEAVu9+myW2810bjY+9aiRHlNqXYSlvCB7pDh2ZEOv9mOWXT0bg1fObezqdBOOKLRUc8qssImizz7pkURvkBUUsCgUdW0qLQw3eaYjx7RSX1N6RKzUSNiJittvLRYdtORY5sXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BKc0qCxr; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728228341; x=1759764341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aWWbf+on6FNKtybcgVLVDrigjYp8ubzMo2TLHr1tep0=;
  b=BKc0qCxrjNfnvGYORei0gGh1jEs16nqk8hGXdNw6fTGCJGxG+rULOSIY
   45vhznbzlkqHoir1LNsvnEKCiRjW/2791Mm23HyFKd2ybjek9/wq2BgBb
   G8US1x+X9Nk+L+aY2wPy8YaD8XBd+3WAp9aD5y8eFfhp9XVO6lCcr1Ma1
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,182,1725321600"; 
   d="scan'208";a="685458451"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2024 15:25:38 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:5282]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.41:2525] with esmtp (Farcaster)
 id 378cbe4b-9350-4f34-bb83-0a52ec673c46; Sun, 6 Oct 2024 15:25:38 +0000 (UTC)
X-Farcaster-Flow-ID: 378cbe4b-9350-4f34-bb83-0a52ec673c46
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sun, 6 Oct 2024 15:25:37 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.11) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Sun, 6 Oct 2024 15:25:35 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net 1/6] rtnetlink: Add bulk registration helpers for rtnetlink message handlers.
Date: Sun, 6 Oct 2024 08:25:27 -0700
Message-ID: <20241006152527.55776-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iKEaY22wrYoi9NbZ3CN+fwXqmLnM_P+zgucv_Unna64UQ@mail.gmail.com>
References: <CANn89iKEaY22wrYoi9NbZ3CN+fwXqmLnM_P+zgucv_Unna64UQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Sat, 5 Oct 2024 10:25:20 +0200
> On Sat, Oct 5, 2024 at 12:24 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > Before commit addf9b90de22 ("net: rtnetlink: use rcu to free rtnl message
> > handlers"), once rtnl_msg_handlers[protocol] was allocated, the following
> > rtnl_register_module() for the same protocol never failed.
> >
> > However, after the commit, rtnl_msg_handler[protocol][msgtype] needs to
> > be allocated in each rtnl_register_module(), so each call could fail.
> >
> > Many callers of rtnl_register_module() do not handle the returned error,
> > and we need to add many error handlings.
> >
> > To handle that easily, let's add wrapper functions for bulk registration
> > of rtnetlink message handlers.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  include/net/rtnetlink.h | 19 +++++++++++++++++++
> >  net/core/rtnetlink.c    | 30 ++++++++++++++++++++++++++++++
> >  2 files changed, 49 insertions(+)
> >
> > diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
> > index b45d57b5968a..b6b91898dc13 100644
> > --- a/include/net/rtnetlink.h
> > +++ b/include/net/rtnetlink.h
> > @@ -29,6 +29,14 @@ static inline enum rtnl_kinds rtnl_msgtype_kind(int msgtype)
> >         return msgtype & RTNL_KIND_MASK;
> >  }
> >
> > +struct rtnl_msg_handler {
> 
> Since we add a structure, we could stick here a
> 
>             struct module *owner;

Will add it and remove _module version in v3.

Thanks!


> 
> > +       int protocol;
> > +       int msgtype;
> > +       rtnl_doit_func doit;
> > +       rtnl_dumpit_func dumpit;
> > +       int flags;
> > +};
> > +
> >  void rtnl_register(int protocol, int msgtype,
> >                    rtnl_doit_func, rtnl_dumpit_func, unsigned int flags);
> >  int rtnl_register_module(struct module *owner, int protocol, int msgtype,
> > @@ -36,6 +44,17 @@ int rtnl_register_module(struct module *owner, int protocol, int msgtype,
> >  int rtnl_unregister(int protocol, int msgtype);
> >  void rtnl_unregister_all(int protocol);
> >
> > +int __rtnl_register_many(struct module *owner,
> > +                        struct rtnl_msg_handler *handlers, int n);
> > +void __rtnl_unregister_many(struct rtnl_msg_handler *handlers, int n);
> > +
> > +#define rtnl_register_many(handlers)                                           \
> > +       __rtnl_register_many(NULL, handlers, ARRAY_SIZE(handlers))
> > +#define rtnl_register_module_many(handlers)                                    \
> > +       __rtnl_register_many(THIS_MODULE, handlers, ARRAY_SIZE(handlers))
> 
> 
> This would allow a simpler api, no need for rtnl_register_module_many()

