Return-Path: <netdev+bounces-237638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CECC4E3A3
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 14:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053A8189A3D8
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 13:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96749342519;
	Tue, 11 Nov 2025 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFcQaUDH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5066342515
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868697; cv=none; b=rviHKNfrozqJlrSW4nxqR3WowQtNPJk3k1AHvlZa5ECjSrH3uiCorINXC/+0+nq1iazyC5L+BTFHDAo4iH+kLhb8oge5jlNB6TStMBBNZSECuDJtEMOo+XRHPvBKZ3RMRL8M/15vUQzBsoOxo1l2UFs9NKca0RjUbPJkUStW+04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868697; c=relaxed/simple;
	bh=oLsD2TSfEIKfdiyyU9EoRAA2hJRpe1ZZHizRgZNpWLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKhs1JFxxZgk7ugK1Um87fNHmH5/QsYuhr4Y0Izw2DzkV3m0A9Iph23pTTCWKpsJW4jNabc3F/l/CVLHiNwduPSDxnGAc1YlXBvL1NmlUfNyyPTjOedV5RxaLmkw2Ew3Svr+hlK0dkbJSgczPArWsFqHtvNRNz43hHC8knpuQmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFcQaUDH; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-880503ab181so40673536d6.2
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 05:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762868695; x=1763473495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3S3dY6bKvP0n4ahRE6N1id+11JXyHy7qLMupyaTb7JA=;
        b=cFcQaUDHiJPhnyt7CZqSuHQGhNgW9iH9BDIcV11vWht8ffvHQGL1sLQdIN3Ygzqell
         6d9qSsfgGIsSGS2MZ982hdceQAxNmrcycH/5+9+55Vb5+pNi/IHt+SVfv34RfLr3U+Zl
         p95/TyhZTcLQ91sSD2+AiUoU34+tKJXUVtgtgwTbLarS8akBF0N7ux3ycjeHzjoVEOBD
         bwOOExOKv5tKVddHby2ev28UpO2PFRP980ywbUjvZrT/N2DNz7jqUYGIMRwvqKoKGotq
         KFeBeoGcUFSFNcgmChthW2gNdaPZWOaE98qvd7uOBGv+oj8pk7jT1YaiGt1DI8H7v9dr
         Dn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762868695; x=1763473495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3S3dY6bKvP0n4ahRE6N1id+11JXyHy7qLMupyaTb7JA=;
        b=Oi5GPdPhgAC7cRY+lI013mW0r+LFQSQFM+Z/OEmPvq87tBqs2xghZFsP5sdr29CAXe
         lv+sVwupaLOzfKVEgDFXGYn9DRfPNLodKNbmyZ8n0mErS5xeqzLBs9Iq8zYmliRLEHhd
         90nntJLpYonARG8UGgLw1BAMu/l51BFwKETYzFzsPb107Ep2/TQRqYzDNS3NIlaX99vS
         dKHlniaaKcrD3IvcvkqaerB0/HJKOIy8cuHwixIDpJCxsCvmZz4XImg7jCnT6Ql9m1kv
         XmIGlDPBDr8cLLCvp69RcuBNlfAAhkwzw6iDEAawYADEWXXMy6HwMoOFBuDiFeYdPO7+
         jrkA==
X-Forwarded-Encrypted: i=1; AJvYcCXWJElxaKYs7TN4qyLflJGHeP1j0pGsj569N89a+Gw+14ANZLUN8S8K50z8J8Nn8RY9KcdkYHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEF47yXndsoLdlb4V6Lj+8TbyqLq/4WlxkhOltjeSyy2fO/OOG
	2bbJtXjhS26LWoS9v62H1a3Eh18+soUjP1Vzy9+8EqWwj9sGT6efVYR6vdATukYUoawn7Msuv53
	Gbeqinw906WklDUMpLiKezurH9rxVyng=
X-Gm-Gg: ASbGnct3iNCNhhQypOiE4UNA4BKopmNG8qSnDDYcDKrhESo9K0JdjTok5FtN97yjVsI
	xQ3RaiRwLvxXMEs5fhZdzCCLL7NWvMlSkWnS6u/6cCO3VbcI9cWCbM+JF5AvlIlnRnnXuixClCP
	hNT1ElrPTmSH/hby2jQ30aonVyoqy/usAjZ6Lr7YY2HMSnTj0bZLn1PhpBcZzoXSfjpUfhe379C
	sLnOTL6toU6w698Z8fdPPiO11pMP7iGn2ce2/PfV3zQYQjikzK9/iqAMlYeBaA5B75ZfJ0=
X-Google-Smtp-Source: AGHT+IHcvWjRFzm3DFl2bF0mBn2FsVeemXN04w1pD3d2UeoFqmy6OyxfJ+Q5qyWgF6aqniqerly0e6d3p0foVYeaflM=
X-Received: by 2002:a05:6214:5c88:b0:882:398d:3cf5 with SMTP id
 6a1803df08f44-882398d3fafmr148224866d6.52.1762868694561; Tue, 11 Nov 2025
 05:44:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031093230.82386-1-kerneljasonxing@gmail.com>
 <20251031093230.82386-3-kerneljasonxing@gmail.com> <aQTBajODN3Nnskta@boxer>
 <CAL+tcoDGiYogC=xiD7=K6HBk7UaOWKCFX8jGC=civLDjsBb3fA@mail.gmail.com>
 <aQjDjaQzv+Y4U6NL@boxer> <CAL+tcoBkO98eBGX0uOUo_bvsPFbnGvSYvY-ZaKJhSn7qac464g@mail.gmail.com>
In-Reply-To: <CAL+tcoBkO98eBGX0uOUo_bvsPFbnGvSYvY-ZaKJhSn7qac464g@mail.gmail.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 11 Nov 2025 14:44:43 +0100
X-Gm-Features: AWmQ_bnJsQYucXIQLRyXEubhZWaoNKhyzmjTiQkcqT9rS3ijhzs1ywmfo-1ohMQ
Message-ID: <CAJ8uoz2ZaJ5uYhd-MvSuYwmWUKKKBSfkq17rJGO98iTJ+iUrQg@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 2/2] xsk: introduce a cached cq to
 temporarily store descriptor addrs
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	fmancera@suse.de, csmate@nop.hu, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Nov 2025 at 14:06, Jason Xing <kerneljasonxing@gmail.com> wrote:
>
> Hi Maciej,
>
> On Mon, Nov 3, 2025 at 11:00=E2=80=AFPM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Sat, Nov 01, 2025 at 07:59:36AM +0800, Jason Xing wrote:
> > > On Fri, Oct 31, 2025 at 10:02=E2=80=AFPM Maciej Fijalkowski
> > > <maciej.fijalkowski@intel.com> wrote:
> > > >
> > > > On Fri, Oct 31, 2025 at 05:32:30PM +0800, Jason Xing wrote:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > Before the commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> > > > > production"), there is one issue[1] which causes the wrong publis=
h
> > > > > of descriptors in race condidtion. The above commit fixes the iss=
ue
> > > > > but adds more memory operations in the xmit hot path and interrup=
t
> > > > > context, which can cause side effect in performance.
> > > > >
> > > > > This patch tries to propose a new solution to fix the problem
> > > > > without manipulating the allocation and deallocation of memory. O=
ne
> > > > > of the key points is that I borrowed the idea from the above comm=
it
> > > > > that postpones updating the ring->descs in xsk_destruct_skb()
> > > > > instead of in __xsk_generic_xmit().
> > > > >
> > > > > The core logics are as show below:
> > > > > 1. allocate a new local queue. Only its cached_prod member is use=
d.
> > > > > 2. write the descriptors into the local queue in the xmit path. A=
nd
> > > > >    record the cached_prod as @start_addr that reflects the
> > > > >    start position of this queue so that later the skb can easily
> > > > >    find where its addrs are written in the destruction phase.
> > > > > 3. initialize the upper 24 bits of destructor_arg to store @start=
_addr
> > > > >    in xsk_skb_init_misc().
> > > > > 4. Initialize the lower 8 bits of destructor_arg to store how man=
y
> > > > >    descriptors the skb owns in xsk_update_num_desc().
> > > > > 5. write the desc addr(s) from the @start_addr from the cached cq
> > > > >    one by one into the real cq in xsk_destruct_skb(). In turn syn=
c
> > > > >    the global state of the cq.
> > > > >
> > > > > The format of destructor_arg is designed as:
> > > > >  ------------------------ --------
> > > > > |       start_addr       |  num   |
> > > > >  ------------------------ --------
> > > > > Using upper 24 bits is enough to keep the temporary descriptors. =
And
> > > > > it's also enough to use lower 8 bits to show the number of descri=
ptors
> > > > > that one skb owns.
> > > > >
> > > > > [1]: https://lore.kernel.org/all/20250530095957.43248-1-e.kubansk=
i@partner.samsung.com/
> > > > >
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > ---
> > > > > I posted the series as an RFC because I'd like to hear more opini=
ons on
> > > > > the current rought approach so that the fix[2] can be avoided and
> > > > > mitigate the impact of performance. This patch might have bugs be=
cause
> > > > > I decided to spend more time on it after we come to an agreement.=
 Please
> > > > > review the overall concepts. Thanks!
> > > > >
> > > > > Maciej, could you share with me the way you tested jumbo frame? I=
 used
> > > > > ./xdpsock -i enp2s0f1 -t -q 1 -S -s 9728 but the xdpsock utilizes=
 the
> > > > > nic more than 90%, which means I cannot see the performance impac=
t.
> > >
> > > Could you provide the command you used? Thanks :)
> > >
> > > > >
> > > > > [2]:https://lore.kernel.org/all/20251030140355.4059-1-fmancera@su=
se.de/
> > > > > ---
> > > > >  include/net/xdp_sock.h      |   1 +
> > > > >  include/net/xsk_buff_pool.h |   1 +
> > > > >  net/xdp/xsk.c               | 104 ++++++++++++++++++++++++++++--=
------
> > > > >  net/xdp/xsk_buff_pool.c     |   1 +
> > > > >  4 files changed, 84 insertions(+), 23 deletions(-)
> > > >
> > > > (...)
> > > >
> > > > > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > > > > index aa9788f20d0d..6e170107dec7 100644
> > > > > --- a/net/xdp/xsk_buff_pool.c
> > > > > +++ b/net/xdp/xsk_buff_pool.c
> > > > > @@ -99,6 +99,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem=
(struct xdp_sock *xs,
> > > > >
> > > > >       pool->fq =3D xs->fq_tmp;
> > > > >       pool->cq =3D xs->cq_tmp;
> > > > > +     pool->cached_cq =3D xs->cached_cq;
> > > >
> > > > Jason,
> > > >
> > > > pool can be shared between multiple sockets that bind to same <netd=
ev,qid>
> > > > tuple. I believe here you're opening up for the very same issue Ery=
k
> > > > initially reported.
> > >
> > > Actually it shouldn't happen because the cached_cq is more of the
> > > temporary array that helps the skb store its start position. The
> > > cached_prod of cached_cq can only be increased, not decreased. In the
> > > skb destruction phase, only those skbs that go to the end of life nee=
d
> > > to sync its desc from cached_cq to cq. For some skbs that are release=
d
> > > before the tx completion, we don't need to clear its record in
> > > cached_cq at all and cq remains untouched.
> > >
> > > To put it in a simple way, the patch you proposed uses kmem_cached*
> > > helpers to store the addr and write the addr into cq at the end of
> > > lifecycle while the current patch uses a pre-allocated memory to
> > > store. So it avoids the allocation and deallocation.
> > >
> > > Unless I'm missing something important. If so, I'm still convinced
> > > this temporary queue can solve the problem since essentially it's a
> > > better substitute for kmem cache to retain high performance.
> >
> > I need a bit more time on this, probably I'll respond tomorrow.
>
> I'd like to know if you have any further comments on this? And should
> I continue to post as an official series?

Hi Jason,

Maciej has been out-of-office for a couple of days. He should
hopefully be back later this week, so please wait for his comments.

> Thanks,
> Jason
>

