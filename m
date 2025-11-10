Return-Path: <netdev+bounces-237278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55259C48564
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 18:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E8D3B29DC
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 17:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7952BEC30;
	Mon, 10 Nov 2025 17:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdA61oTN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89DC2BE655
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762795658; cv=none; b=M9/YqF03sc7x7rw7Q/ryoxLUtdqz7EV9JgwFMieYuLizJAVBCdOh1oeFHY/S0r3DNy2/SXLiC4lxrSTiQvHz17Mi5WQaHn5UUDg9f/7eUpxbhLqDXc3cObHCZIKMXlHAdsVGBS5Y8ihyP4v2NcQnGLFawx/J62pjvp6qMVf68/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762795658; c=relaxed/simple;
	bh=qletO7ZLb6ssek75YbmCFHdcAca6r9JGiXOKUOzxs6A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hqM5tn0oPxyVHsg/MNmaql/9rkOnKKedWFdDcETiQVk5KuuCt+rcgpR5vbsVzr2Fb3N0kJMy82D+UDNmwe6/WdRZc321qjKFf0FsRshj3W9H3OONCrM9JDauanfZzVuClZpMUuSWQjdq9he60MF9eHS1bgG3lP6tzbIYBcJwJ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdA61oTN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA6CC4CEF5;
	Mon, 10 Nov 2025 17:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762795657;
	bh=qletO7ZLb6ssek75YbmCFHdcAca6r9JGiXOKUOzxs6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kdA61oTNFH3cvOCtIisu64XCtdLs9ILS4dt/c3lK1aEs4u6kYw1NozIr8kytUYstD
	 V76QOBTj0syQjQqRuAhOvRue38K/dUmZ7Ml2i6Fc7ysv5N4W4BCwOK5gtaAlz04sRk
	 mApoPSS5Frc+cr7ZfYuoQ2ogqg57ia0GhYKf7x5EF1/J76sroE6TRnVD+//246s+YY
	 /c+KwX5uSuAI/dw2MEBFljd+8LMFnkGew0viJTs+i/xQ4o+Osed/1YgxknQmX7vXYl
	 Wi9BxgkGDYkCKuyj1aj5m8+BUGcO3jMpQ8GsCDFVN82Vw7u+lrLFp2th3yEBwfDDpS
	 9FYTj8QSZoKfQ==
Date: Mon, 10 Nov 2025 09:27:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 00/10] net_sched: speedup qdisc dequeue
Message-ID: <20251110092736.5642f227@kernel.org>
In-Reply-To: <CANn89i+KtA5C3rY2ump7qr=edvhvFw8fJ0HwRkiNHs=5+wwR3Q@mail.gmail.com>
References: <20251110094505.3335073-1-edumazet@google.com>
	<20251110084432.7fdf647b@kernel.org>
	<CANn89i+KtA5C3rY2ump7qr=edvhvFw8fJ0HwRkiNHs=5+wwR3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Nov 2025 09:15:46 -0800 Eric Dumazet wrote:
> On Mon, Nov 10, 2025 at 8:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Mon, 10 Nov 2025 09:44:55 +0000 Eric Dumazet wrote: =20
> > > Avoid up to two cache line misses in qdisc dequeue() to fetch
> > > skb_shinfo(skb)->gso_segs/gso_size while qdisc spinlock is held.
> > >
> > > Idea is to cache gso_segs at enqueue time before spinlock is
> > > acquired, in the first skb cache line, where we already
> > > have qdisc_skb_cb(skb)->pkt_len.
> > >
> > > This series gives a 8 % improvement in a TX intensive workload.
> > >
> > > (120 Mpps -> 130 Mpps on a Turin host, IDPF with 32 TX queues) =20
> >
> > According to CI this breaks a bunch of tests.
> >
> > https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-2025-11-10=
--12-00
> >
> > I think they all hit:
> >
> > [   20.682474][  T231] WARNING: CPU: 3 PID: 231 at ./include/net/sch_ge=
neric.h:843 __dev_xmit_skb+0x786/0x1550 =20
>=20
> Oh well, I will add this in V2, thank you !
>=20
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index b76436ec3f4aa412bac1be3371f5c7c6245cc362..79501499dafba56271b9ebd97=
a8f379ffdc83cac
> 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -841,7 +841,7 @@ static inline unsigned int qdisc_pkt_segs(const
> struct sk_buff *skb)
>         u32 pkt_segs =3D qdisc_skb_cb(skb)->pkt_segs;
>=20
>         DEBUG_NET_WARN_ON_ONCE(pkt_segs !=3D
> -                              skb_is_gso(skb) ? skb_shinfo(skb)->gso_seg=
s : 1);
> +                       (skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs : 1)=
);
>         return pkt_segs;
>  }

Hm, I think we need more..

The non-debug workers are also failing and they have DEBUG_NET=3Dn

Looks like most of the non-debug tests are tunnel and bridge related.
VxLAN, GRE etc.=20

https://netdev.bots.linux.dev/contest.html?pass=3D0&branch=3Dnet-next-2025-=
11-10--12-00&executor=3Dvmksft-forwarding

