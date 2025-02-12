Return-Path: <netdev+bounces-165605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86A3A32B49
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 17:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4EF1883B95
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 16:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09761DC9B0;
	Wed, 12 Feb 2025 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FVPa09A4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E39271838
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739376954; cv=none; b=uXazbyilTCyzO46rZHhNWREeAF6msoiJpbhMZMjIPwsITvdp4J6RHdATxP/ycraccC9gFZb64ZcQFr9UYGIsUkJ2/TuI2lMTLpXhVmOoSFvVrYAjDN4oZHdjc4Sb0KW291UuEsjBvOiosRJ9WcfiMF3d04hfxHh+Wx7q38/cxd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739376954; c=relaxed/simple;
	bh=w8HMuypFJGp6SXenYUCEOt5ZI+T0gTnTEWY6eId7eOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQRUjxUyY5E2HhjSQm5HqG/lMoMBG9T1tXDo2QGPm1iqWPO6ODCgGqGrDrbguYvcqy3ZFm9xEZfdOKlmM5POF25qCGa/kj284N7uqF0qjD6zpu0dKWZ3oK0yfBcHKIU7e/OdXycIavxGtKGmlatE7jsSRnGOYcOQwhUIF7iGZbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FVPa09A4; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6f9625c0fccso62576277b3.1
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 08:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1739376952; x=1739981752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMuuhLs0PMito5dKiiFYo0zicBM71Kv8qQtIQBFDcD4=;
        b=FVPa09A4YiKDOgiCVwNwDSgap5JnFkDXxE07y/XKC4HALpdwzd0hTbxGYQn5Z/7WEK
         YfLjwHtCTINJka+ZCkgVt7FMDm2JbgDbEtJKuBJG4xhfTQbxqP8aIWAgO2amCeAF6RbI
         emlQUSknHzhS9MOT0gohQs8MSOdvBWm67NR09LVEmJod5E7bPOyqEmcYB57FaS7qh8fg
         WLNIwF+baC6CNWPIK5ZJal2fhrfsstU6id31NXBXcAN4Km81L4TeHkSFklb/hA2xm0KV
         HKHIirPhiKDuypLnsgJLwz3MVmUcibwFEWyjJEci1OYDVaPU+8QMjtTEkwC17l3Nutpc
         mcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739376952; x=1739981752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMuuhLs0PMito5dKiiFYo0zicBM71Kv8qQtIQBFDcD4=;
        b=IlMG58lZbL9g0nUOlAY6uxH3OZR0XGR0bdvHTMzSwfjQ7qO/eiObGO3njbDr+d7tEr
         CUq1QgBN9BPRUBrDxGKwVvQ4JJyDxHfw/wWdAbWvli3qN1Rs15NPBXscDy9nTo/76Usw
         m8IYwOk8xWwM2iYM6a4EHkS+JfY+6rg2BpfYD1wGur3LIExuX/FaMdzdqrMDTaGEZwLP
         5uuNaEm1KlNJkury98o4HkJEA0miHIJ6QvJaTjpXgkwyKIepU72SrSYY7GsUAp4ENAdu
         ko9nLe8cQnYDE2Y+bKHgKS/LmN1Z4VgkyY0EZWRhlj7g0qSH4YZBe0yQ74eb1o5fKa+o
         psQA==
X-Forwarded-Encrypted: i=1; AJvYcCV+UQW8WoVZXOAquQ2KhX92gmQEIxb69k7YQM2BykVZVeVHwKO46aWSRY+5peHqE5IEu4YwGro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrP4jC7hgOVMmTGTgbqmLtgnQ7vdPE6A7omSdfRpdnTV5J5RZu
	+Ma2X81/QEjcRwNJpPGClIrb6qka2HwjATIo+MNmrdkUkYeEVJ+nbRr5rVHxNctQfTLQc7Qoiqu
	4No+gQoAd05tFnHOmPZ4l8t6iTIwRtXDkQkzeP814pgkXxYEY4g==
X-Gm-Gg: ASbGncuRMox1SMbTGDc2JJDsl6Zx/rb0v/qic3iJbgQpw5Jm2K4t84UupdXSMrXGOGn
	2+9bh7JYzd/wOpybFrc6GOmzumU/84x3WczIq8M1F/GNML/r123j4Tw5VyxBhn/B0nKO/wfc=
X-Google-Smtp-Source: AGHT+IFn0vvI15FOm0hm9fBfmMug0eVA+sg+PcxWiJV8jwIW8heejIH/AKw2HTydXw+E/W8TUsViqs4xYHmYqpECzl8=
X-Received: by 2002:a05:690c:a90:b0:6f5:2793:2897 with SMTP id
 00721157ae682-6fb1f2822b0mr44028337b3.30.1739376951898; Wed, 12 Feb 2025
 08:15:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <879a4592e4e4bd0c30dbe29ca189e224ec1739a5.1739201151.git.sd@queasysnail.net>
 <CANn89iJbzed1HnW7QHSRWno92hLAbQH+iaitAutqRh=CK9koaw@mail.gmail.com> <Z6ucMj5FukT_lecR@hog>
In-Reply-To: <Z6ucMj5FukT_lecR@hog>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 12 Feb 2025 11:15:41 -0500
X-Gm-Features: AWEUYZm6yAfEQlI7tsePpNrXiZDPnbGM7b244oUw0uXXQfiAuNQncdwKViw7NbM
Message-ID: <CAHC9VhQZ+k1J0UidJ-bgdBGBuVX9M18tQ+a+fuqXQM_L-PFvzA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: drop skb extensions before skb_attempt_defer_free
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, Xiumei Mu <xmu@redhat.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 1:51=E2=80=AFPM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
> 2025-02-10, 17:24:43 +0100, Eric Dumazet wrote:
> > On Mon, Feb 10, 2025 at 5:02=E2=80=AFPM Sabrina Dubroca <sd@queasysnail=
.net> wrote:
> > >
> > > Xiumei reported hitting the WARN in xfrm6_tunnel_net_exit while
> > > running tests that boil down to:
> > >  - create a pair of netns
> > >  - run a basic TCP test over ipcomp6
> > >  - delete the pair of netns
> > >
> > > The xfrm_state found on spi_byaddr was not deleted at the time we
> > > delete the netns, because we still have a reference on it. This
> > > lingering reference comes from a secpath (which holds a ref on the
> > > xfrm_state), which is still attached to an skb. This skb is not
> > > leaked, it ends up on sk_receive_queue and then gets defer-free'd by
> > > skb_attempt_defer_free.
> > >
> > > The problem happens when we defer freeing an skb (push it on one CPU'=
s
> > > defer_list), and don't flush that list before the netns is deleted. I=
n
> > > that case, we still have a reference on the xfrm_state that we don't
> > > expect at this point.
> > >
> > > tcp_eat_recv_skb is currently the only caller of skb_attempt_defer_fr=
ee,
> > > so I'm fixing it here. This patch also adds a DEBUG_NET_WARN_ON_ONCE
> > > in skb_attempt_defer_free, to make sure we don't re-introduce this
> > > problem.
> > >
> > > Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu=
 lists")
> > > Reported-by: Xiumei Mu <xmu@redhat.com>
> > > Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> > > ---
> > > A few comments:
> > >  - AFAICT this could not happen before 68822bdf76f1, since we would
> > >    have emptied the (per-socket) defer_list before getting to ->exit(=
)
> > >    for the netns
> > >  - I thought about dropping the extensions at the same time as we
> > >    already drop the dst, but Paolo said this is probably not correct =
due
> > >    to IP_CMSG_PASSSEC
> >
> > I think we discussed this issue in the past.
> >
> > Are you sure IP_CMSG_PASSSEC  is ever used by TCP ?
>
> After checking, I don't think so. The only way TCP can get to
> IP_CMSG_PASSSEC is through the error queue, so it shouldn't matter.
>
> The original commit (2c7946a7bf45 ("[SECURITY]: TCP/UDP getpeersec"))
> also says that TCP should be using SO_PEERSEC for that purpose
> (although likely based on the secpath as well, but not packet per
> packet).
>
> Based on the chat you had with Paul Moore back in November, it seems
> any point after tcp_filter should be fine:
> https://lore.kernel.org/netdev/CAHC9VhS3yuwrOPcH5_iRy50O_TtBCh_OVWHZgzfFT=
Yqyfrw_zQ@mail.gmail.com

[NOTE: CC'ing the LSM so others are aware of this discussion]

I can't say I've got the full context for this discussion, but my
comments from last November should still hold true: if a packet/skb is
still "alive" and able to be accessed by a task then we need to
preserve it from a LSM perspective.

As far as IP_CMSG_PASSSEC is concerned, while I would normally expect
TCP/stream connections to use the SO_PEERSEC method to determine the
peer security information, unless there is something in the stack or
socket API that explicitly prevents the use of IP_CMSG_PASSSEC on
UDP/datagram packets I would imagine it is possible that there is an
application somewhere which makes use of it.  The LSM framework, and
all of the LSMs that implement the IP_CMSG_PASSSEC hook callback,
should work just fine regardless of if the packet is TCP or UDP.

--=20
paul-moore.com

