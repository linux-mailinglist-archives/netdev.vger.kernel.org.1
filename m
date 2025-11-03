Return-Path: <netdev+bounces-235267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6047AC2E670
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 00:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B55044E5F6A
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 23:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED7D3016F2;
	Mon,  3 Nov 2025 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaLY0DwL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E2F30CDAB
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 23:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762212605; cv=none; b=g/RxNRakRPsKMgYLURDJ83DiwJcRXjmUpLwToQ0d9TDJwWz60Y8BG3Oy8D9+TGaFWbjaWtJBr0WqX6rpMP2kLYqDNqIHn56gSgy0uDuokKRIyTBm1CrTmrAgkA2EkzAatpM3RXhtI39EBu+B14uutcgc/Bsn4tIKwlvmjGBRvlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762212605; c=relaxed/simple;
	bh=moAdDmNBvq3XmEJHL/R6fXhafULeL+9J6djD8/6gNHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTUH7FQAfnIVh9p8pyI5UCG2fx90gHkFpi1t73CKod48gKPQXZ5uDj1FS+XyLZeOHqGo7I1AspfqL1cLI79Xshmsr74oJPg/iK43AISGJCpydi0T4PGkySEAcO4H2XJdmMJ530IRt8DLQVeKxjXiMLlLHRrFsoqglbPDptfZT+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaLY0DwL; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-945a6c8721aso204135939f.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 15:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762212603; x=1762817403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4GhNF6njxVwD/9HD3S5eYMmT/e8p8/jDrBmM/w02Ts=;
        b=LaLY0DwLjRSyufNuN/p6MbRetp51Sum2+5ICijWWq4XBt90OTUfb5KhoUgcsyWSC+Z
         pYpSUO9PcAkjC1qLVroqqgQykOCiC9zGxyQVZsSBdyi/6zioMvV6DAzj2qvry0TuH9mD
         amMJHALb5Ss93CyHa65RsxibbrKxQxNW82AzHS+e8begyTKWvI4Rzns6RKJioIzm+Pe/
         6qba32di3aI5pxAPIQvtSVigSRCnMMageXOxnHNGmcBXgQYE0V4rBV/WH57uDEJkNIbV
         oWfDfflN+AJ6JDhf7v7lmL9CVJbmyy/c/sI6o0OaUi6OgReQw8+knEI+1wJnFJ0RYrJ2
         jGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762212603; x=1762817403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4GhNF6njxVwD/9HD3S5eYMmT/e8p8/jDrBmM/w02Ts=;
        b=QoiJEmBtGE5bddxXvcC//SbALoxutVrRabfYVibMglt8vMeAMXYr6OHC2nreoBpIIn
         5JJji1z+azpbzDL9thRUeDyYHx0943GU+n0ziQYNIo/wFDOS39RDy7/whREgaksq08nF
         Q9xQ7zrEBfevEZ0NuHrrVVFT0r6A9MtIfRmd77or0CkoM6gAhb2jzdrtbX2wjtixTY6Q
         EUxq/Z3wpAPxyN/EuYi0+OgKkS5O5r312ZZweZh0mdITuzoMv4qkDYsjMzhMrkdugFf2
         j8eNYJ72eJ42/6RZXaf/HpOvhjjM240DqOh3MziV27r1fI17saUA5qhYdB+uhskuDWrZ
         zK8A==
X-Forwarded-Encrypted: i=1; AJvYcCX6uYW4RnMSQXNQOun6lEzKhP/PAqT+Z4kdImsOwNqmvkqqx99so3bG5sh8yo12NTRjq+45lNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxqsZzsVjNHacbIOa68QpPxSew4s1njxcq//YQ9oKg0LmN1JMe
	zd5AIBhlAd5oqP+5KFyVjbN73yeU/xv7PNYYZrOiLnuHj5bRUETn7QeNDYc9k+M8waB9cpeYDaQ
	CXJGY2qtgddgTDbn9DIi+Z/FWBumvzOs=
X-Gm-Gg: ASbGnctxy2ghhIxHGaW5PZDXMuYko69xbUxSgPb0mUmJuX0Z+kz/ca49sjihdt46yMG
	E4L9vg/MvEGBdgQArVeSxLLfMW/g3mGuVk68zk7dlIMVFsQjBAdfdlbo+VgpyeNBnapdgezzgd6
	aYDA7MzaExvZxyxaAvLTT/Ag8dYkf2bVRPvavi8onhhENAkg6iTNc1CpcbuPc74pdzw6eVUTT8I
	hyYQDq1utbCsDZRFk8XjZP/dlePrNBixUaJhh2uf/8yjOqtIEP6LNRnIG49YVcccyWZtZiIRQ==
X-Google-Smtp-Source: AGHT+IHYoDEXCbsqAnSP9vJ+Kj7uAHQgLtv/9kElhfYD+zC5IILDq2XFKXg76UNGWbp+ykvBbyN6QaNikgYtgIHz2Tc=
X-Received: by 2002:a05:6e02:2481:b0:433:31aa:69fc with SMTP id
 e9e14a558f8ab-43331aa6c1cmr54573105ab.21.1762212602715; Mon, 03 Nov 2025
 15:30:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031093230.82386-1-kerneljasonxing@gmail.com>
 <20251031093230.82386-3-kerneljasonxing@gmail.com> <aQTBajODN3Nnskta@boxer>
 <CAL+tcoDGiYogC=xiD7=K6HBk7UaOWKCFX8jGC=civLDjsBb3fA@mail.gmail.com> <aQjDjaQzv+Y4U6NL@boxer>
In-Reply-To: <aQjDjaQzv+Y4U6NL@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 4 Nov 2025 07:29:26 +0800
X-Gm-Features: AWmQ_bnwv1gjQB2BbGXm0t1ss5acQUMLjqTzkou2ezouiXjr9MvQiP9dn4MHP8U
Message-ID: <CAL+tcoDjczzAz0d9Pu54pxuJDzVKWBE+6KXRFG17ew+nf7YA2g@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 2/2] xsk: introduce a cached cq to
 temporarily store descriptor addrs
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to, 
	willemdebruijn.kernel@gmail.com, fmancera@suse.de, csmate@nop.hu, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 11:00=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Sat, Nov 01, 2025 at 07:59:36AM +0800, Jason Xing wrote:
> > On Fri, Oct 31, 2025 at 10:02=E2=80=AFPM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Fri, Oct 31, 2025 at 05:32:30PM +0800, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Before the commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> > > > production"), there is one issue[1] which causes the wrong publish
> > > > of descriptors in race condidtion. The above commit fixes the issue
> > > > but adds more memory operations in the xmit hot path and interrupt
> > > > context, which can cause side effect in performance.
> > > >
> > > > This patch tries to propose a new solution to fix the problem
> > > > without manipulating the allocation and deallocation of memory. One
> > > > of the key points is that I borrowed the idea from the above commit
> > > > that postpones updating the ring->descs in xsk_destruct_skb()
> > > > instead of in __xsk_generic_xmit().
> > > >
> > > > The core logics are as show below:
> > > > 1. allocate a new local queue. Only its cached_prod member is used.
> > > > 2. write the descriptors into the local queue in the xmit path. And
> > > >    record the cached_prod as @start_addr that reflects the
> > > >    start position of this queue so that later the skb can easily
> > > >    find where its addrs are written in the destruction phase.
> > > > 3. initialize the upper 24 bits of destructor_arg to store @start_a=
ddr
> > > >    in xsk_skb_init_misc().
> > > > 4. Initialize the lower 8 bits of destructor_arg to store how many
> > > >    descriptors the skb owns in xsk_update_num_desc().
> > > > 5. write the desc addr(s) from the @start_addr from the cached cq
> > > >    one by one into the real cq in xsk_destruct_skb(). In turn sync
> > > >    the global state of the cq.
> > > >
> > > > The format of destructor_arg is designed as:
> > > >  ------------------------ --------
> > > > |       start_addr       |  num   |
> > > >  ------------------------ --------
> > > > Using upper 24 bits is enough to keep the temporary descriptors. An=
d
> > > > it's also enough to use lower 8 bits to show the number of descript=
ors
> > > > that one skb owns.
> > > >
> > > > [1]: https://lore.kernel.org/all/20250530095957.43248-1-e.kubanski@=
partner.samsung.com/
> > > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > > I posted the series as an RFC because I'd like to hear more opinion=
s on
> > > > the current rought approach so that the fix[2] can be avoided and
> > > > mitigate the impact of performance. This patch might have bugs beca=
use
> > > > I decided to spend more time on it after we come to an agreement. P=
lease
> > > > review the overall concepts. Thanks!
> > > >
> > > > Maciej, could you share with me the way you tested jumbo frame? I u=
sed
> > > > ./xdpsock -i enp2s0f1 -t -q 1 -S -s 9728 but the xdpsock utilizes t=
he
> > > > nic more than 90%, which means I cannot see the performance impact.
> >
> > Could you provide the command you used? Thanks :)
> >
> > > >
> > > > [2]:https://lore.kernel.org/all/20251030140355.4059-1-fmancera@suse=
.de/
> > > > ---
> > > >  include/net/xdp_sock.h      |   1 +
> > > >  include/net/xsk_buff_pool.h |   1 +
> > > >  net/xdp/xsk.c               | 104 ++++++++++++++++++++++++++++----=
----
> > > >  net/xdp/xsk_buff_pool.c     |   1 +
> > > >  4 files changed, 84 insertions(+), 23 deletions(-)
> > >
> > > (...)
> > >
> > > > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > > > index aa9788f20d0d..6e170107dec7 100644
> > > > --- a/net/xdp/xsk_buff_pool.c
> > > > +++ b/net/xdp/xsk_buff_pool.c
> > > > @@ -99,6 +99,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(s=
truct xdp_sock *xs,
> > > >
> > > >       pool->fq =3D xs->fq_tmp;
> > > >       pool->cq =3D xs->cq_tmp;
> > > > +     pool->cached_cq =3D xs->cached_cq;
> > >
> > > Jason,
> > >
> > > pool can be shared between multiple sockets that bind to same <netdev=
,qid>
> > > tuple. I believe here you're opening up for the very same issue Eryk
> > > initially reported.
> >
> > Actually it shouldn't happen because the cached_cq is more of the
> > temporary array that helps the skb store its start position. The
> > cached_prod of cached_cq can only be increased, not decreased. In the
> > skb destruction phase, only those skbs that go to the end of life need
> > to sync its desc from cached_cq to cq. For some skbs that are released
> > before the tx completion, we don't need to clear its record in
> > cached_cq at all and cq remains untouched.
> >
> > To put it in a simple way, the patch you proposed uses kmem_cached*
> > helpers to store the addr and write the addr into cq at the end of
> > lifecycle while the current patch uses a pre-allocated memory to
> > store. So it avoids the allocation and deallocation.
> >
> > Unless I'm missing something important. If so, I'm still convinced
> > this temporary queue can solve the problem since essentially it's a
> > better substitute for kmem cache to retain high performance.
>
> I need a bit more time on this, probably I'll respond tomorrow.

Take your time - if we all come to an agreement on this series, then I
can proceed to take care of some minor details to avoid bugs
happening. Thanks in advance.

Thanks,
Jason

