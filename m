Return-Path: <netdev+bounces-201721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE95AEAC1F
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 03:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4213A3D34
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 01:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AE5219E8;
	Fri, 27 Jun 2025 01:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/11EOQB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66432145FE0
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 01:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750986078; cv=none; b=Fo/5zpSUjdk3ohOMjHqqWrh+WGv9NlUpWnQ6T3HkA9fbF61Xs48HlnJz5KKe7jwGLTIYxGO5x2nmbkqDfAL6zv2/ttPC6emvCRspfStzX2ls89oepez7HWXFGDNwzAiBV+RKEDCPqfdwdKe0/j112neBjeifP0FU6rKRzrAEo58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750986078; c=relaxed/simple;
	bh=JUuEWzSsrJvQA/NSb5mgqarAsvIaA4K6b4L1Jtfn9c0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0OsaqbylBg8DBhNnr7P+ZIyz5Tae/x+rNFoCjYHih74doEE4MSu3g2AuHMM6i2z8Z8umEuYSL4okkINyAnHQdolTco4Tb+zVZjIFOjOV66RPdX627uCRZiiovwsd/NInoRQtUX4jkUte2XcRjjBrvJA8HMdrcvswGFYj/DnjLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q/11EOQB; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3138e64b42aso1956824a91.0
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 18:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750986077; x=1751590877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFCgNkNtLTPi2qftxx19oPErN+QtXy8c4/pxZTBK1RI=;
        b=q/11EOQBUtEeAQCvSX4ng3djlLn70/+s4UvYA108aUKUgkY5I8CmVKlpYc3DK/xdrj
         9pCVN0ysS7Y5w+laFAnVJQAE+mhPIDVMfQfxTPudKI4GqFYt6EU/nQz214GerrG3JRFK
         akjqJhr1C3NRK3ebTmLm/ICSg9lso8A3LH5e4VnAad2ZFKKHJDIezjmIT5IKrYQmdBj7
         Xc/fP7lGZjaWi79U6Lnqjq9AX1+FMsdFOKvcT0g3y8lDTgCTl69AZBTmwfmVyGQnrK9B
         81vNbq1Zt4yQpm7qNXgBjxQr9GuXkY957H36zj5IaqdEEWVDa8KmdkX8DGR2wTWn6iEZ
         aONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750986077; x=1751590877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFCgNkNtLTPi2qftxx19oPErN+QtXy8c4/pxZTBK1RI=;
        b=qDoTmod5xwfAeYXia4veK4vqjryyvCofcJ/6lMH4NGvCrGEHFnSEoUf/v3QsowTKNe
         XN76MDqgDVFOJGrZODvE3WRtmVqlKPfKTUOC5HuMfuMB9Ligva8vEnwjEfAZbaLFMU22
         4sFl18LNPw7SDddoj7hR1JH38BnUmnFXj6xz+ub3uVVuKADccZ0YXV4UgfrOlvmeVNLv
         4mncNtSq75zzymdWs/S6yiJ6mKqrq/H3/dW4U5auPAQ/m21xyApPeOCl8eTbbDMN9s+/
         F/u6pl1+2bC7sKDXQ26JnHc721aVrANsN1jo3F1lY/MUhQQn+RhOSVgT1La/avk19Hpe
         K+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWauhaUDsjajnlwVT7rd2hKXrnrY5HT1rbpDToZ/OZXFHwNjwUyquxqa5JPmbe//MPBnX7BTUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxPxUXHagcudBr+O/OcVL3fnrCW6fWVIJKSBdz6B4f3+7Bg86M
	pkqjF8FtwNQ5B7G51IpyaBZDitIsYAIpAHOrxIIRRDzrXVXjsvlnQT1SwSrUAl6f83oUXGz6WhY
	WoLBqySIwwbgAyqp/M7S+x/cbr6fJhGuNIupNoyGz
X-Gm-Gg: ASbGncsiADA8xLL3fBTpjUN4pS9+zI2xIkB2WF6+8S77MnI2Wn5zZ9fFJVjelmV6oYw
	ISqj+d3rYZnBRUqNNZuHIcl4iUIAMJR3JFYkTLsGetWZnJvbElLwkUTt5l5svTkV+W8Kf8BrGod
	DfsezCAauWkHZRVBb4/uIUSMq8Nf3nOo6xeXq/m+6KnbI4eKkp/51FrDulaUlJudXW+uNtcbHHS
	Td+
X-Google-Smtp-Source: AGHT+IFNb5tJ01q1Fymb8qgReZd+LFacrQhDkllfDQkLn22VNIRpx4Mw0vpAeff/iEL0Z9IpoU8QDW98sRDnozCQKQo=
X-Received: by 2002:a17:90b:2252:b0:312:959:dc3f with SMTP id
 98e67ed59e1d1-318c8ee5339mr1588930a91.3.1750986075940; Thu, 26 Jun 2025
 18:01:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624202616.526600-1-kuni1840@gmail.com> <20250624202616.526600-7-kuni1840@gmail.com>
 <CANn89i+aMsdJ+oQmo1y4sbjJM40NJpFNYn2YT5Gf1WrfMc1nOg@mail.gmail.com>
In-Reply-To: <CANn89i+aMsdJ+oQmo1y4sbjJM40NJpFNYn2YT5Gf1WrfMc1nOg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 26 Jun 2025 18:01:04 -0700
X-Gm-Features: Ac12FXzfJ9coAs9cLOA2TaMhVhqmWkLFZXFXx54cEtCYfs6cGyXyhYqTTBFLfSI
Message-ID: <CAAVpQUDa8w49-mvf4=nAYLKv0aX9hmAt312_0CD+u4nSWWAv3A@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 06/15] ipv6: mcast: Don't hold RTNL for
 IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 7:37=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Jun 24, 2025 at 1:26=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail=
.com> wrote:
> >
> > From: Kuniyuki Iwashima <kuniyu@google.com>
> >
> > In __ipv6_sock_mc_join(), per-socket mld data is protected by lock_sock=
(),
> > and only __dev_get_by_index() requires RTNL.
> >
> > Let's use dev_get_by_index() and drop RTNL for IPV6_ADD_MEMBERSHIP and
> > MCAST_JOIN_GROUP.
> >
> > Note that we must call rt6_lookup() and dev_hold() under RCU.
> >
> > If rt6_lookup() returns an entry from the exception table, dst_dev_put(=
)
> > could change rt->dev.dst to loopback concurrently, and the original dev=
ice
> > could lose the refcount before dev_hold() and unblock device registrati=
on.
> >
> > dst_dev_put() is called from NETDEV_UNREGISTER and synchronize_net() fo=
llows
> > it, so as long as rt6_lookup() and dev_hold() are called within the sam=
e
> > RCU critical section, the dev is alive.
> >
> > Even if the race happens, they are synchronised by idev->dead and mcast
> > addresses are cleaned up.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> > v2: Hold rcu_read_lock() around rt6_lookup & dev_hold()
> > ---
> >  net/ipv6/ipv6_sockglue.c |  2 --
> >  net/ipv6/mcast.c         | 22 ++++++++++++----------
> >  2 files changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
> > index 1e225e6489ea..cb0dc885cbe4 100644
> > --- a/net/ipv6/ipv6_sockglue.c
> > +++ b/net/ipv6/ipv6_sockglue.c
> > @@ -121,11 +121,9 @@ static bool setsockopt_needs_rtnl(int optname)
> >  {
> >         switch (optname) {
> >         case IPV6_ADDRFORM:
> > -       case IPV6_ADD_MEMBERSHIP:
> >         case IPV6_DROP_MEMBERSHIP:
> >         case IPV6_JOIN_ANYCAST:
> >         case IPV6_LEAVE_ANYCAST:
> > -       case MCAST_JOIN_GROUP:
> >         case MCAST_LEAVE_GROUP:
> >         case MCAST_JOIN_SOURCE_GROUP:
> >         case MCAST_LEAVE_SOURCE_GROUP:
> > diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> > index b3f063b5ffd7..9fc7672926bf 100644
> > --- a/net/ipv6/mcast.c
> > +++ b/net/ipv6/mcast.c
> > @@ -175,14 +175,12 @@ static int unsolicited_report_interval(struct ine=
t6_dev *idev)
> >  static int __ipv6_sock_mc_join(struct sock *sk, int ifindex,
> >                                const struct in6_addr *addr, unsigned in=
t mode)
> >  {
> > -       struct net_device *dev =3D NULL;
> > -       struct ipv6_mc_socklist *mc_lst;
> >         struct ipv6_pinfo *np =3D inet6_sk(sk);
> > +       struct ipv6_mc_socklist *mc_lst;
> >         struct net *net =3D sock_net(sk);
> > +       struct net_device *dev =3D NULL;
> >         int err;
> >
> > -       ASSERT_RTNL();
> > -
> >         if (!ipv6_addr_is_multicast(addr))
> >                 return -EINVAL;
> >
> > @@ -202,13 +200,18 @@ static int __ipv6_sock_mc_join(struct sock *sk, i=
nt ifindex,
> >
> >         if (ifindex =3D=3D 0) {
> >                 struct rt6_info *rt;
> > +
> > +               rcu_read_lock();
> >                 rt =3D rt6_lookup(net, addr, NULL, 0, NULL, 0);
> >                 if (rt) {
> >                         dev =3D rt->dst.dev;
>
> We probably need safety here, READ_ONCE() at minimum.

Will add it and the corresponding WRITE_ONCE() in dst_dev_put().

>
> This can probably be done in a separate series.

I'll post a follow-up for other rt6_lookup() users and dst.dev
users under RCU.

Thanks!

