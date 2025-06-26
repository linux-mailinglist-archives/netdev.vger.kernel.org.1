Return-Path: <netdev+bounces-201615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621BDAEA105
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A281B3ABB77
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A48A2ECD0F;
	Thu, 26 Jun 2025 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P8GuJ4N0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32B62EE61F
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948634; cv=none; b=N5u94Ljt0RW578biMMlCwzuEc9TL35DpNlkhXbXQ7301KV36aT5iFQI2tXP9+h9DRIBSAj/EZ8z40lVO8dRf0TrX8MTpNC7relXvTGsMd34/YcK+raNRIYapkULGpR5sk2iyO/NhTGHsG7lGPcpD69538FRjkCBOZe77dxKgcsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948634; c=relaxed/simple;
	bh=WeSYKeo8nSYlqU6LzMV421mpU+3qYgQDPodL7aZnKYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lb+fPcprMRfjg9Y0G8Aak8Z62OYrq7luZLoHyQsOGnYcJHTOIcO1RxDzqTRAFdGqDhrs/3pHks+5vHI0ZIrc/5bGpkm0RYx2znZG816+y6cjLNjAwOS/KJS4CuKycJI4t/HTUbOsJXctoJZYYVXDoGNaxFYtaDcfM2pNyQGfNQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P8GuJ4N0; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a43e277198so7780321cf.1
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750948631; x=1751553431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEfdxf5q6Pb2md6aAw42bcu5bCGLqhdn+nDjkFCqT0M=;
        b=P8GuJ4N0Xsxe27wc6/liWZdIgUGk4XAXPHT3qi0H5ovTnJ3SHlvbpi8srZGvJuYh2a
         shwj80YMixT/TQJzESu6MGCYAE4q/ASZ5WgvS2x/c5hJKYkTpUObAzzm3ME8lJ3LUQkJ
         Xgh+edqrh38yVNTKue5XSDhY1nsH+/uO5BBYCY1WA+99gi7rg1e6BeXi+kLWLLaextL5
         yTc1NqddHOgeOOkmE0uArhA9qwEUrAk9o91hHr5CCbLxStlAyr+bLUWDPuh7eJLyUg/G
         gfy9nZQTpIJucQcg6SOlAhqjapE/1kqHfUukkGZuVVgIqYVvdmWrXqtMSu6+ILZCbGnv
         ktOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750948631; x=1751553431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEfdxf5q6Pb2md6aAw42bcu5bCGLqhdn+nDjkFCqT0M=;
        b=M8j2twitiLEu2gV8dE3rcum6Nqxhb7TyNqpA+z7v7Wkd8wrgC7jeKJ1EYWspGdnqVK
         ihBuxkIokaE5ZaovgAxVO5JTYhaYwXbH8eR2ipKmoEkLA2jY6lngbGvHl0AdmLDwDIYV
         7fk3zKnTRarmdFU9SV7BbHy89ZLcdJP+6IhTgbcx79W+aSaLfXar4l1wda6V8FvZRozB
         pW2XA509X63L1afHemDf7MhoazZVl4+8aVc2Sa7vdpo5c4Oo5nrMv42Mhr644jyC+M81
         ZWfHMt49TeGfV43p7ITpa43yXJE7XiawlBN6rpaoySggKoguFQ91bnPzNaUmaOSAMLMJ
         +V2g==
X-Forwarded-Encrypted: i=1; AJvYcCV2DiFPf1ytdQCqvW1ahl6iKEt7+5jv+N/0gAJCqrBRsmMes2ER/U89A4g4+wvwhplbZcAPBSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5b5wYuuKDx1HXcOhrzltZavOcPvWm8/dqwIrjjQeE9IuicQc/
	mQc7ktkeGbV50H/J0IITBAk87QktTWhzD9CXMx5Gud6lj8hoLbdqCiVLO9z68ztocE2bSW/zV2Y
	dbM1Mq8/8F4YI/xiLkhj/A90nch5D+jDCdX5Ic89L
X-Gm-Gg: ASbGncup+AVegR6BBgRQGROEfn/boqMc2VplKs7JFOQb0wAf4UmhPSyYFB6ZGpBWg5u
	mhEbKDn3Qvf9w58CqeIzyl+OAKmJVy9vbKH83Vuc7dYaVljKyh8ShoMTs9kP05zSI0VyJ42j62H
	+/urC+8xDtY9vJPU61xu1nu0OZDBj8CMTncMVs0VVTNiaqaJm3Rs7v8g==
X-Google-Smtp-Source: AGHT+IFvW7Fod85UgdMm8X9wu3TuVje5qyTb3kvcrKDhy3RPoD8i93i1oxbb7v/rQhoSe5lTrslrkrl+cmeRgCsrB6Y=
X-Received: by 2002:a05:622a:1aa3:b0:4a4:41d5:2a03 with SMTP id
 d75a77b69052e-4a7c061434bmr125928071cf.4.1750948630999; Thu, 26 Jun 2025
 07:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624202616.526600-1-kuni1840@gmail.com> <20250624202616.526600-7-kuni1840@gmail.com>
In-Reply-To: <20250624202616.526600-7-kuni1840@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Jun 2025 07:36:58 -0700
X-Gm-Features: Ac12FXwTpwsREL5xhwj_7he_WsOVXCue52LaupXmR2MCM-y0X8f2UsEXmFZfU9A
Message-ID: <CANn89i+aMsdJ+oQmo1y4sbjJM40NJpFNYn2YT5Gf1WrfMc1nOg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 06/15] ipv6: mcast: Don't hold RTNL for
 IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 1:26=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail.c=
om> wrote:
>
> From: Kuniyuki Iwashima <kuniyu@google.com>
>
> In __ipv6_sock_mc_join(), per-socket mld data is protected by lock_sock()=
,
> and only __dev_get_by_index() requires RTNL.
>
> Let's use dev_get_by_index() and drop RTNL for IPV6_ADD_MEMBERSHIP and
> MCAST_JOIN_GROUP.
>
> Note that we must call rt6_lookup() and dev_hold() under RCU.
>
> If rt6_lookup() returns an entry from the exception table, dst_dev_put()
> could change rt->dev.dst to loopback concurrently, and the original devic=
e
> could lose the refcount before dev_hold() and unblock device registration=
.
>
> dst_dev_put() is called from NETDEV_UNREGISTER and synchronize_net() foll=
ows
> it, so as long as rt6_lookup() and dev_hold() are called within the same
> RCU critical section, the dev is alive.
>
> Even if the race happens, they are synchronised by idev->dead and mcast
> addresses are cleaned up.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v2: Hold rcu_read_lock() around rt6_lookup & dev_hold()
> ---
>  net/ipv6/ipv6_sockglue.c |  2 --
>  net/ipv6/mcast.c         | 22 ++++++++++++----------
>  2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
> index 1e225e6489ea..cb0dc885cbe4 100644
> --- a/net/ipv6/ipv6_sockglue.c
> +++ b/net/ipv6/ipv6_sockglue.c
> @@ -121,11 +121,9 @@ static bool setsockopt_needs_rtnl(int optname)
>  {
>         switch (optname) {
>         case IPV6_ADDRFORM:
> -       case IPV6_ADD_MEMBERSHIP:
>         case IPV6_DROP_MEMBERSHIP:
>         case IPV6_JOIN_ANYCAST:
>         case IPV6_LEAVE_ANYCAST:
> -       case MCAST_JOIN_GROUP:
>         case MCAST_LEAVE_GROUP:
>         case MCAST_JOIN_SOURCE_GROUP:
>         case MCAST_LEAVE_SOURCE_GROUP:
> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> index b3f063b5ffd7..9fc7672926bf 100644
> --- a/net/ipv6/mcast.c
> +++ b/net/ipv6/mcast.c
> @@ -175,14 +175,12 @@ static int unsolicited_report_interval(struct inet6=
_dev *idev)
>  static int __ipv6_sock_mc_join(struct sock *sk, int ifindex,
>                                const struct in6_addr *addr, unsigned int =
mode)
>  {
> -       struct net_device *dev =3D NULL;
> -       struct ipv6_mc_socklist *mc_lst;
>         struct ipv6_pinfo *np =3D inet6_sk(sk);
> +       struct ipv6_mc_socklist *mc_lst;
>         struct net *net =3D sock_net(sk);
> +       struct net_device *dev =3D NULL;
>         int err;
>
> -       ASSERT_RTNL();
> -
>         if (!ipv6_addr_is_multicast(addr))
>                 return -EINVAL;
>
> @@ -202,13 +200,18 @@ static int __ipv6_sock_mc_join(struct sock *sk, int=
 ifindex,
>
>         if (ifindex =3D=3D 0) {
>                 struct rt6_info *rt;
> +
> +               rcu_read_lock();
>                 rt =3D rt6_lookup(net, addr, NULL, 0, NULL, 0);
>                 if (rt) {
>                         dev =3D rt->dst.dev;

We probably need safety here, READ_ONCE() at minimum.

This can probably be done in a separate series.

Reviewed-by: Eric Dumazet <edumazet@google.com>

