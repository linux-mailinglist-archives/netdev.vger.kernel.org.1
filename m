Return-Path: <netdev+bounces-237629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8968FC4E047
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 14:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31CEF3A2F32
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 13:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0BF324708;
	Tue, 11 Nov 2025 13:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KExtMmOt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F8F324713
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 13:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762866230; cv=none; b=gwWAZqRzMUqUB67Ws4B4OMPCMm2G3p4lPI4NchL5xrjDsNNOhEh/3LYDWwmKvGv2wlJcnDNSosazjNn0Ks9E96thbZCbUHdmT0cLKLpt1vtYBnwizKIf4Weo/Kvv+aTEyLtiiKjfJFbClt2Rq19DQKaURZrVMw1INTcOnBfgouQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762866230; c=relaxed/simple;
	bh=nyry5tPd6eSPS1V0yTOVSu3GcfPnIhCroP6tlcVCKFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=by8dcKEM34U9RFgw+mDxRwalGWOCqDwleAHykgYHvzKQ01eY081lv4L+QoMZq6nbHrlWfVgCyF5RxE3I7b+AqTLR1FzNwxY/JdgkAzwlBHFcCDeW0Cf3I4GlqLPksWtZDi47OluMEF4JYozI+LwtBkWkPVRP5LGtALxrJqP/Qto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KExtMmOt; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-434717509afso788365ab.2
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 05:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762866227; x=1763471027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ysG6rPd91dJcwoPy6Yaj41oJbZ+5w7sFRShlyVTsV8=;
        b=KExtMmOtNL51jzgq2FmCjAplZr5KlI5WJoFcYuu/O3zYJt7o4VAlLtliJ911TSSnKJ
         qs1h8WJMd08orZzSVJiX9OyanBfKdm9IipCZrlg188jELLnRWraU6ePHy0nw4qjwtfOH
         NISGUUwqFfsoI2bvNHtm3nNw4p/qoWu+1W5kM4Hnhc3SqnbMDgxPEd7JcmSo5suq4dTu
         DFXK1IVwBFzIYjpYpkv0gS0pKxaOquDh5uuUOPASdZuqf9bon6yNuLu6rQ5OjlmMS4/B
         WXWb/i6HuOW5dJ3OOmF2ppMwdrE0PbyrN0HxWxdT0WCL9jwP5tHRiG2RvPexyTI91LrG
         gKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762866227; x=1763471027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ysG6rPd91dJcwoPy6Yaj41oJbZ+5w7sFRShlyVTsV8=;
        b=kkHOkBApBwy0Xs1ufP5BeMUUgY7qsvHdMSQizCjYWkShHoEXaV7NyVG7d4HUs0zkCh
         nmyL7Kt09rOUAJXqkErF6OH3tzayVnkFH1BG4Cvqgn7FrD57azWy+6cZlEMDI/qZePfK
         xHXXBK2lRQyEn5uWoQguAP3XYAWHzROsryFyvEI64G6DN1p6XkPZV8RwPOlWEV0gN4yu
         Ar2s3IXXXqPMlIweF8o/aIi4DUXREyvAV3fvfEycWY9HfgF64tRe3G2etrpR4DGVznvK
         ErGT+nPLXEinhJATaVlOrktdBMsOBDKrWivhzTbSWq1U1f8r4+hZ/zMARR/xwL4ETv3w
         y3Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWOslYkmUVQ45DK3nsdQ62AkFQpRJ/VSbUnP63sMGNqcP+UBhUGIwsxP3SeC3r8jDVFv0+0sWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHT0tVQiaEsh7PpKVXKyPAhrOp7ijZgWKXB95KzeYXSvty0Fbd
	ZAbv6xoMqfUmzo1jS+dGRZlKoqakTWoKCO8xTCey5baa3PHwtYZh5D+PXbA51zq4FrYct+yUhiJ
	DAXHgP+1jM7paZitNNI87wf1hgIeiU4g=
X-Gm-Gg: ASbGncv6O5qUZLa0TVu/DpdX3Z9vCvedUqeUZOVmxriJmf23UAaZk/adBA8VilcAGrK
	Kur1fi58tEpDPSJ+gT/okhp1Rhr0ntemJNm9Gq2+D1WkjywgkvWVYRzEBSo8GFxRZqhqWVWqUpB
	7qmJekF166P4B2quStMr6O/7Y4f52mJQ4iKb0d74OnVBB7xAa5b/ArjPrFYxahFc0OWwjU+eGB9
	qfWVYZTZgaLM0f9OonvCXRKNnX+NthHlPMcz461bIrClwxaQhP/FjhUN/LGzkUSDluCLHvdSTo=
X-Google-Smtp-Source: AGHT+IHm5FKq17U6bUB4G4vYuoY4gBQDWJl5cBlmk7+PbgpzMRH5EZDOkTEdcI78FV7KX8/0AmwR0/svTkwfACGZBNQ=
X-Received: by 2002:a05:6e02:1486:b0:433:481d:fd61 with SMTP id
 e9e14a558f8ab-43367e838cbmr175614835ab.18.1762866226617; Tue, 11 Nov 2025
 05:03:46 -0800 (PST)
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
Date: Tue, 11 Nov 2025 21:03:09 +0800
X-Gm-Features: AWmQ_bmcyI7qTp6reHM1LUQhQs6GB0kg4w2G5GcbSnGLrzkiA8VKmS-O9Mj0uIM
Message-ID: <CAL+tcoBkO98eBGX0uOUo_bvsPFbnGvSYvY-ZaKJhSn7qac464g@mail.gmail.com>
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

Hi Maciej,

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

I'd like to know if you have any further comments on this? And should
I continue to post as an official series?

Thanks,
Jason

