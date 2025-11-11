Return-Path: <netdev+bounces-237640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AF1C4E4B5
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 15:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3098E189C12E
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 14:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989F430AAC1;
	Tue, 11 Nov 2025 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6r6ZUGx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C349C306B39
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869817; cv=none; b=Aw8eY2iK37Hob3NDxjYAKI7m4nsQlFQypbcSCbwkfLbJtCfbgT3D4waAYtCOG/U1EgvHCxcPxXUqSXyf3mPyp+T7bWyiUCrfZUcLJuwKMqIHG8gWacIxklBsoFdp2DZxRIAID4qgUOxu/WV3MEto4twp6PJTISjx7LL3JWw1N1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869817; c=relaxed/simple;
	bh=K0Z2ySIFKx3PKPiK4P6YQ5+78mUXMIM5vSlFfWNQ4dQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pE68qLR7AYrpIBmDLJPeCt87qsqJZiTGpUXwEOevMZ3Y22I3SWhvbBgMvW+XsNnDnJToK4BgtNTj309tPJiePiGgXJKajjARjRFpHGS7qsm2vgvJkb1yPYKRoFEXvQDGeuLIK9t6S//eA5B1/UcSkIQum0VDR8R+C6Wy1Ki3SDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6r6ZUGx; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-4330ef18d8aso25746425ab.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 06:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762869815; x=1763474615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VibbC+5mk65vMHz2LaNUPLHvms8z1KT5kdMPNVMdO3U=;
        b=C6r6ZUGxcJ27v9+XxBACOZqimYIrjQIEX410DJepy6DXGygOrztIpIGS9uK18e+Eo7
         teng0aFq9OzP9RNasJ3cY3SrE1J3yaOlewpCq8m/qy/IEjt0VtxH0xeEaIQu6CgI9hXr
         3F/DT5AcbhV/kLvliaGxHGk27fYB6yx55fBICJ3cx6qvOLMXCaJeibwx3+nwQ9EvNFbf
         VASKVtrC2o2YXpXrM7lnJjJF2NCdGwYpfWxCGZ1WHoFoiAdSygP/bYvJFT7miLSNB1I4
         SYMRU3sX0QnNAlDRUy0/UtbgUY76SReohOsIX1dI5Y5rE0/B0K6CXrgcseY2xGWnoUV5
         pdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762869815; x=1763474615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VibbC+5mk65vMHz2LaNUPLHvms8z1KT5kdMPNVMdO3U=;
        b=Jl7JOtK13+Z0xXkf1ogKL5BrSTYsR4vDzfqbUal5+V8/GxV7PWY83OashZhPi6CwNQ
         AEX3XB1LJVBeYYphqvUJ77LNE6ofYWcFzCPdFB/tuSjfC1fCMqB44U7L0debZBiCiJOK
         NB6P2e2Pdk19BgK78Qak8AXhfqQdPygG05sv2C7uAx2hDallLKAYOTq08mFoLPy39CbF
         Kz3nG1bCUK7SUZHbEbQmRrVYeABOkwfXNqivdSuhuZGaUkz6isqrturMCIK72SUtSfnW
         Ba8hLaECSI2OtFImDZkRzHdyX9jhBXV+m48HEt1YMNU9Ey+uzLrmKim6A5OlSKeO+/ne
         eLJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM5BCJsQdqvEr4D9VFhn753PepKpSFXVgnNfA8u6Qw0f/GA38vY6XtempmWakjkc4c9Wt7Myk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOnphqyTHKj4U0B73yoYNCRj/NQy4WKfwieUUxFA8Dp0pDAPUY
	uKs0Ix8/svlbya/ZLsYMfimm4dNhYi3h73tIHQGAx9ktkPzfsgYYoMDT6Knu5R3y5EyjUHvO5zI
	RdRzlHzurIiIGjd9qEweFz/wEUKm9Sec=
X-Gm-Gg: ASbGnctwENPjsLPykVDWqrMxrK6gUKgPpObb8KYmomUkABW2ujemTOQhHCCn2Q5e1Xo
	7O9QHAKuIDPYclc82Om5gVzwndP5lHhVqadT8a5xEERohmmZ83tUfGL38+VCd8/IAMZtNycwO21
	qdtibXgNlzsrlCPoGTbEprTgh1QoRCwrBfXxb/VsnIriaMvSBHJRu1XSoY8kke4MYRNdOvhflvn
	OybbGTs9Ft8NlbpcwiiDQgvHfukR5//eNFKfLuWOv1+3cTh8KwjI1gEHTeGSRw2
X-Google-Smtp-Source: AGHT+IHuoHFU6FYkv3l9u96xec1YaIlfxleDt4yGphqk53vvSYJtLCUXD8JZMVEb4IB6UksKud8d04ljIXLqqbIMwE8=
X-Received: by 2002:a05:6e02:152c:b0:433:7b82:307f with SMTP id
 e9e14a558f8ab-4337b823291mr122812125ab.15.1762869814589; Tue, 11 Nov 2025
 06:03:34 -0800 (PST)
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
 <CAJ8uoz2ZaJ5uYhd-MvSuYwmWUKKKBSfkq17rJGO98iTJ+iUrQg@mail.gmail.com>
In-Reply-To: <CAJ8uoz2ZaJ5uYhd-MvSuYwmWUKKKBSfkq17rJGO98iTJ+iUrQg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 11 Nov 2025 22:02:58 +0800
X-Gm-Features: AWmQ_bmSMzXXqE569VVMBugamvS7-t3lSqZ_J028auD5hU_BTicFSrEV42vogww
Message-ID: <CAL+tcoBw4eS8QO+AxSk=-vfVSb-7VtZMMNfZTZtJCp=SMpy0GQ@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 2/2] xsk: introduce a cached cq to
 temporarily store descriptor addrs
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	fmancera@suse.de, csmate@nop.hu, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Magnus,

On Tue, Nov 11, 2025 at 9:44=E2=80=AFPM Magnus Karlsson
<magnus.karlsson@gmail.com> wrote:
>
> On Tue, 11 Nov 2025 at 14:06, Jason Xing <kerneljasonxing@gmail.com> wrot=
e:
> >
> > Hi Maciej,
> >
> > On Mon, Nov 3, 2025 at 11:00=E2=80=AFPM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Sat, Nov 01, 2025 at 07:59:36AM +0800, Jason Xing wrote:
> > > > On Fri, Oct 31, 2025 at 10:02=E2=80=AFPM Maciej Fijalkowski
> > > > <maciej.fijalkowski@intel.com> wrote:
> > > > >
> > > > > On Fri, Oct 31, 2025 at 05:32:30PM +0800, Jason Xing wrote:
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > Before the commit 30f241fcf52a ("xsk: Fix immature cq descripto=
r
> > > > > > production"), there is one issue[1] which causes the wrong publ=
ish
> > > > > > of descriptors in race condidtion. The above commit fixes the i=
ssue
> > > > > > but adds more memory operations in the xmit hot path and interr=
upt
> > > > > > context, which can cause side effect in performance.
> > > > > >
> > > > > > This patch tries to propose a new solution to fix the problem
> > > > > > without manipulating the allocation and deallocation of memory.=
 One
> > > > > > of the key points is that I borrowed the idea from the above co=
mmit
> > > > > > that postpones updating the ring->descs in xsk_destruct_skb()
> > > > > > instead of in __xsk_generic_xmit().
> > > > > >
> > > > > > The core logics are as show below:
> > > > > > 1. allocate a new local queue. Only its cached_prod member is u=
sed.
> > > > > > 2. write the descriptors into the local queue in the xmit path.=
 And
> > > > > >    record the cached_prod as @start_addr that reflects the
> > > > > >    start position of this queue so that later the skb can easil=
y
> > > > > >    find where its addrs are written in the destruction phase.
> > > > > > 3. initialize the upper 24 bits of destructor_arg to store @sta=
rt_addr
> > > > > >    in xsk_skb_init_misc().
> > > > > > 4. Initialize the lower 8 bits of destructor_arg to store how m=
any
> > > > > >    descriptors the skb owns in xsk_update_num_desc().
> > > > > > 5. write the desc addr(s) from the @start_addr from the cached =
cq
> > > > > >    one by one into the real cq in xsk_destruct_skb(). In turn s=
ync
> > > > > >    the global state of the cq.
> > > > > >
> > > > > > The format of destructor_arg is designed as:
> > > > > >  ------------------------ --------
> > > > > > |       start_addr       |  num   |
> > > > > >  ------------------------ --------
> > > > > > Using upper 24 bits is enough to keep the temporary descriptors=
. And
> > > > > > it's also enough to use lower 8 bits to show the number of desc=
riptors
> > > > > > that one skb owns.
> > > > > >
> > > > > > [1]: https://lore.kernel.org/all/20250530095957.43248-1-e.kuban=
ski@partner.samsung.com/
> > > > > >
> > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > ---
> > > > > > I posted the series as an RFC because I'd like to hear more opi=
nions on
> > > > > > the current rought approach so that the fix[2] can be avoided a=
nd
> > > > > > mitigate the impact of performance. This patch might have bugs =
because
> > > > > > I decided to spend more time on it after we come to an agreemen=
t. Please
> > > > > > review the overall concepts. Thanks!
> > > > > >
> > > > > > Maciej, could you share with me the way you tested jumbo frame?=
 I used
> > > > > > ./xdpsock -i enp2s0f1 -t -q 1 -S -s 9728 but the xdpsock utiliz=
es the
> > > > > > nic more than 90%, which means I cannot see the performance imp=
act.
> > > >
> > > > Could you provide the command you used? Thanks :)
> > > >
> > > > > >
> > > > > > [2]:https://lore.kernel.org/all/20251030140355.4059-1-fmancera@=
suse.de/
> > > > > > ---
> > > > > >  include/net/xdp_sock.h      |   1 +
> > > > > >  include/net/xsk_buff_pool.h |   1 +
> > > > > >  net/xdp/xsk.c               | 104 ++++++++++++++++++++++++++++=
--------
> > > > > >  net/xdp/xsk_buff_pool.c     |   1 +
> > > > > >  4 files changed, 84 insertions(+), 23 deletions(-)
> > > > >
> > > > > (...)
> > > > >
> > > > > > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > > > > > index aa9788f20d0d..6e170107dec7 100644
> > > > > > --- a/net/xdp/xsk_buff_pool.c
> > > > > > +++ b/net/xdp/xsk_buff_pool.c
> > > > > > @@ -99,6 +99,7 @@ struct xsk_buff_pool *xp_create_and_assign_um=
em(struct xdp_sock *xs,
> > > > > >
> > > > > >       pool->fq =3D xs->fq_tmp;
> > > > > >       pool->cq =3D xs->cq_tmp;
> > > > > > +     pool->cached_cq =3D xs->cached_cq;
> > > > >
> > > > > Jason,
> > > > >
> > > > > pool can be shared between multiple sockets that bind to same <ne=
tdev,qid>
> > > > > tuple. I believe here you're opening up for the very same issue E=
ryk
> > > > > initially reported.
> > > >
> > > > Actually it shouldn't happen because the cached_cq is more of the
> > > > temporary array that helps the skb store its start position. The
> > > > cached_prod of cached_cq can only be increased, not decreased. In t=
he
> > > > skb destruction phase, only those skbs that go to the end of life n=
eed
> > > > to sync its desc from cached_cq to cq. For some skbs that are relea=
sed
> > > > before the tx completion, we don't need to clear its record in
> > > > cached_cq at all and cq remains untouched.
> > > >
> > > > To put it in a simple way, the patch you proposed uses kmem_cached*
> > > > helpers to store the addr and write the addr into cq at the end of
> > > > lifecycle while the current patch uses a pre-allocated memory to
> > > > store. So it avoids the allocation and deallocation.
> > > >
> > > > Unless I'm missing something important. If so, I'm still convinced
> > > > this temporary queue can solve the problem since essentially it's a
> > > > better substitute for kmem cache to retain high performance.
> > >
> > > I need a bit more time on this, probably I'll respond tomorrow.
> >
> > I'd like to know if you have any further comments on this? And should
> > I continue to post as an official series?
>
> Hi Jason,
>
> Maciej has been out-of-office for a couple of days. He should
> hopefully be back later this week, so please wait for his comments.

Thanks for letting me know. I will wait :)

Thanks,
Jason

