Return-Path: <netdev+bounces-138400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECCF9AD53D
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 21:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2651C20ACD
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 19:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADCE1D9A61;
	Wed, 23 Oct 2024 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EYGB+MgC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B961D9667
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 19:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729713117; cv=none; b=SWbX4uvvipxYJpLpTc9Qezd4btyPTG8ITKH8JMdJ2zTMHdckIcUaHJr6WYLhWer/eId9XNsbinqCAgiEFpzXMvLn7vPmlv53RJqV/7UOvpDj/WzIz01e2M1twjTKdQmpemwcP/QLPMXu2cY2pJvdQYtArlDw7UFqRoifauJwNPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729713117; c=relaxed/simple;
	bh=BwmpP8pJYe+gJRkKW0sZ8HvTA8xcFJe9KtJTO796xcs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gj1Kt3iF+xRiuZyzEQn7k+XPMFqLZnPk3mpdZDr+qGUcPVnwoV3s60y2hJ55y0VbqAK9dnobN2YMdYsXFDXfqWdZm5N7j51eNborI7JOvOWUssXJK7rIlJHug7SQtIltFHFUhlJzfzf8OEtJ4nWY/9CHbakehowlHHr4Ps6LAQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EYGB+MgC; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729713116; x=1761249116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KDtl5cL6xeEdRYnbT3DONURZo/i5NXov44FGquxroZs=;
  b=EYGB+MgCvxYQjSIdpBevbA68oEhttgDvgc6IJBwZw5pr+wPF/2RtqPIu
   UgU1poWXnVRULwOmfvaLoIoJDwti6xw/SLYwTVkH/1eJRcgBJEa1t/b5u
   KhJD5mVDHdH9Panlljo9O4Lq3c/9XYxy061knHzS3wpLdZaO+jnjIdBgE
   A=;
X-IronPort-AV: E=Sophos;i="6.11,227,1725321600"; 
   d="scan'208";a="434071578"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 19:51:51 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:64785]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.226:2525] with esmtp (Farcaster)
 id 1f7577bd-d61b-41a8-850a-8fbd97c88e10; Wed, 23 Oct 2024 19:51:50 +0000 (UTC)
X-Farcaster-Flow-ID: 1f7577bd-d61b-41a8-850a-8fbd97c88e10
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 23 Oct 2024 19:51:50 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 23 Oct 2024 19:51:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <ignat@cloudflare.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next] socket: Print pf->create() when it does not clear sock->sk on failure.
Date: Wed, 23 Oct 2024 12:51:44 -0700
Message-ID: <20241023195144.60048-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CANn89iLEvu-bkrDWZnzG66vcbQbb2NS=U0XqH-iwa=ONE3tiQA@mail.gmail.com>
References: <CANn89iLEvu-bkrDWZnzG66vcbQbb2NS=U0XqH-iwa=ONE3tiQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Oct 2024 21:45:26 +0200
> On Wed, Oct 23, 2024 at 9:18 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > I suggested to put DEBUG_NET_WARN_ON_ONCE() in __sock_create() to
> > catch possible use-after-free.
> >
> > But the warning itself was not useful because our interest is in
> > the callee than the caller.
> >
> > Let's define DEBUG_NET_WARN_ONCE() and print the name of pf->create()
> > and the socket identifier.
> >
> > While at it, we enclose DEBUG_NET_WARN_ON_ONCE() in parentheses too
> > to avoid a checkpatch error.
> >
> > Note that %pf or %pF were obsoleted and later removed as per comment
> > in lib/vsprintf.c.
> >
> > Link: https://lore.kernel.org/netdev/202410231427.633734b3-lkp@intel.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  include/net/net_debug.h | 4 +++-
> >  net/socket.c            | 4 +++-
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/net/net_debug.h b/include/net/net_debug.h
> > index 1e74684cbbdb..9fecb1496be3 100644
> > --- a/include/net/net_debug.h
> > +++ b/include/net/net_debug.h
> > @@ -149,9 +149,11 @@ do {                                                               \
> >
> >
> >  #if defined(CONFIG_DEBUG_NET)
> > -#define DEBUG_NET_WARN_ON_ONCE(cond) (void)WARN_ON_ONCE(cond)
> > +#define DEBUG_NET_WARN_ON_ONCE(cond) ((void)WARN_ON_ONCE(cond))
> > +#define DEBUG_NET_WARN_ONCE(cond, format...) ((void)WARN_ONCE(cond, format))
> >  #else
> >  #define DEBUG_NET_WARN_ON_ONCE(cond) BUILD_BUG_ON_INVALID(cond)
> > +#define DEBUG_NET_WARN_ONCE(cond, format...) BUILD_BUG_ON_INVALID(cond)
> >  #endif
> >
> >  #endif /* _LINUX_NET_DEBUG_H */
> > diff --git a/net/socket.c b/net/socket.c
> > index 9a8e4452b9b2..da00db3824e3 100644
> > --- a/net/socket.c
> > +++ b/net/socket.c
> > @@ -1578,7 +1578,9 @@ int __sock_create(struct net *net, int family, int type, int protocol,
> >                 /* ->create should release the allocated sock->sk object on error
> >                  * and make sure sock->sk is set to NULL to avoid use-after-free
> >                  */
> > -               DEBUG_NET_WARN_ON_ONCE(sock->sk);
> > +               DEBUG_NET_WARN_ONCE(sock->sk,
> > +                                   "%pS must clear sock->sk on failure, family: %d, type: %d, protocol: %d\n",
> 
> %ps would be more appropriate, the offset should be zero, no need to
> display a full 'symbol+0x0/0x<size>'

Ah, exactly!
Will use %ps in v2.

Thanks!

---
pw-bot: cr

