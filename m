Return-Path: <netdev+bounces-239899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DC7C6DAF1
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 041882DEB9
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B841F3FEC;
	Wed, 19 Nov 2025 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9g/hXfn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38462D73B1
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 09:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544071; cv=none; b=SMf3S4M1V3BazEbQggxVq9SKqy12obNTGPWel8pyTA0dfyJwakoB6IE2OEpZXnLuaus2atAQJo0bo/OpZXF1wDn5qBXooPfRKncPXd1zkmPipYkPXv+58jHONc5ppi/nq4Wka5d0VZxiTf3GJnQY03Va7tDNquH1q+tNdpCKtqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544071; c=relaxed/simple;
	bh=BZaHmz0UjtYmBSZ/DzxGCA02YNOXclhY41JV2pPLJiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAaWnmlrIJQoly9ikdHHbiw4luvy43shO2v3126acOp2h6iflVY5XLPTx/hRYEoy12Lv5MsqZpN4+bCL//AcdrSdqhHg1G8HxhsJEvccCDPW2gBkxGdTZJj6tYApRs9b9q8hMFSnToN5u7ZQlZhSc3umFQem6xje4/KzzlIdu7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9g/hXfn; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-43346da8817so3906705ab.0
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 01:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763544067; x=1764148867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uYZQmHvBni59A4kp/aHfZAdbJ2ZbIsaSwdg5+PhBZw=;
        b=m9g/hXfnlHzbGVL8uo1TGjCzRHa93KWIPSwg1aOO0t4bII63VQPccG30boC8gfN1f4
         7JLVOb6fsdq5ij+XsYy96F6JzNkx/XoYJVT0dI/lv9+pLx9LGkl4jmrf1dKdOrWQs6MF
         uIJPyMARmeirDxSXgfwSFsMA3igBnFU/sdG/aQGwxzz4W3hed8UR7CzU3S3xQuccgHV2
         eUJGWYqVyaweM2kL2Puzy7SQuvWngjPyaKKsQac5nzN9eY/LjmlxeBz9VX9e7ypCX7++
         4ENbUU6gLWcxiP/zpOuirt6/nHAGm2NciNbib+WUcJjsaVgK1MNPd44r0MW3vHV7+tLd
         uYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763544067; x=1764148867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6uYZQmHvBni59A4kp/aHfZAdbJ2ZbIsaSwdg5+PhBZw=;
        b=kPxwOrMr5+TlzMNZLAEmQmhrdH8woRPtMa2Eo0APdlzsthLqPgHgNBek+tsZ8O27qm
         IyhQzADimpPi8eRvw6vyuXTMfFeyXWTkrIklnWFPkv6JYWG4rXug7z0sneaeO2jXy5Ia
         1gPUbuerQTUkjSUoS6wOlGJ1bimcx9s1JP7Ds0KCsRoxnnS0/QTL4XhaEGAvMmx95SJy
         bR6odVKJEI2v6BbXS6DyvOxFB0jmDmkQWA7HwR0qeU/h2KfT7L4QNBhkxesQGsG3uk+f
         cFdIIbS4VcuAGKNl7c7iNKLPaPC6OpRVJrmqQPIJhEZ6S5dL9+yR57NwTC/zGRSR4fSe
         ECbA==
X-Forwarded-Encrypted: i=1; AJvYcCXR0Etb2xZ94E7hi4jUfR1yqBl3EYoIj+JEqZdZqgHwY6flYnq0IswnEPjzczJyMHDV9GCBYBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFzMMF3Z9kTq95DIiKTPdbTP7TuX4IihghDJ1kRm1CeTwYvRjz
	91kYzAficj+VRdjh8+fn1u54aP0rpX5V6c3SM1OmhKlaxPfZYs8eJPFplzXemehTxERByRtoOG6
	DlXQQkUGOVkMtQ88WSi0noVc88J3E48c=
X-Gm-Gg: ASbGncsvbkpxEHV9EMSrl15HFADeT50wr7sh79iygJ1WjKM+Mlunnw/qIY7D+Fs+K5Z
	OIq9l+5bOzXLDqNQVmMKc2XYQj8p6SlR3WiuvigE+r7r13jEybK17YzIEPBXoKwTdFFHfaRD1TP
	AjKVNDVFvK+2su7QoLl4u4lg3+whNtIcf0rZfmEQ/c5bBz7DydfYF1qXx7HivyY5nNAoaPBs5/A
	RUV8L4QjbrmUtT/8uDJAUBnoc/E9a6N9d8ZBcX14P6v+s4OwiV2RiaOFOjJlhGH4NfhSSo5dAuV
	6zBmmaXXHQ==
X-Google-Smtp-Source: AGHT+IHWjs2UVxEWlDZ7fIQFetZXtUMTs5XbEaw7Crboqv51TI2RzucyJ1ggpPArH8oQiV3LXoX9f5D2IgRpcGIo1VY=
X-Received: by 2002:a05:6e02:f0f:b0:434:96ea:ff43 with SMTP id
 e9e14a558f8ab-4359ff9d08cmr12918235ab.17.1763544067401; Wed, 19 Nov 2025
 01:21:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQjDjaQzv+Y4U6NL@boxer> <CAL+tcoBkO98eBGX0uOUo_bvsPFbnGvSYvY-ZaKJhSn7qac464g@mail.gmail.com>
 <CAJ8uoz2ZaJ5uYhd-MvSuYwmWUKKKBSfkq17rJGO98iTJ+iUrQg@mail.gmail.com>
 <CAL+tcoBw4eS8QO+AxSk=-vfVSb-7VtZMMNfZTZtJCp=SMpy0GQ@mail.gmail.com>
 <aRdQWqKs29U7moXq@boxer> <CAL+tcoAv+dTK-Z=HNGUJNohxRu_oWCPQ4L1BRQT9nvB4WZMd7Q@mail.gmail.com>
 <aRtHvooD0IWWb4Cx@boxer> <CAL+tcoBTuOnnhAUD9gwbt8VBf+m=c08c-+cOUyjuPLyx29xUWw@mail.gmail.com>
 <aRxHDvUBcr+jx49C@boxer> <CAL+tcoCPiDq807u4wmqNx+j_jMmYYzNVA5ySGmp_V5gDLYz02A@mail.gmail.com>
 <aRy64Wr2UBhr4KLF@boxer> <CAL+tcoBA-0BZnSTvUJXDEWS4xB-t_eoOW3RgTDOqvP9HP+3rDg@mail.gmail.com>
In-Reply-To: <CAL+tcoBA-0BZnSTvUJXDEWS4xB-t_eoOW3RgTDOqvP9HP+3rDg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 19 Nov 2025 17:20:29 +0800
X-Gm-Features: AWmQ_bl6qxV2H25VO2yaMpVED9SIa1rXkbvNd2w7w6aC37rEzsR7gu0Nwqy4W9E
Message-ID: <CAL+tcoDoMC4iaWfom=QbcmScXM6T0F+9r2U4EAZ3vxkTrcmUUQ@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 2/2] xsk: introduce a cached cq to
 temporarily store descriptor addrs
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	fmancera@suse.de, csmate@nop.hu, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 7:37=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Wed, Nov 19, 2025 at 2:29=E2=80=AFAM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Tue, Nov 18, 2025 at 07:40:52PM +0800, Jason Xing wrote:
> > > On Tue, Nov 18, 2025 at 6:15=E2=80=AFPM Maciej Fijalkowski
> > > <maciej.fijalkowski@intel.com> wrote:
> > > >
> > > > On Tue, Nov 18, 2025 at 08:01:52AM +0800, Jason Xing wrote:
> > > > > On Tue, Nov 18, 2025 at 12:05=E2=80=AFAM Maciej Fijalkowski
> > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > >
> > > > > > On Sat, Nov 15, 2025 at 07:46:40AM +0800, Jason Xing wrote:
> > > > > > > On Fri, Nov 14, 2025 at 11:53=E2=80=AFPM Maciej Fijalkowski
> > > > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Nov 11, 2025 at 10:02:58PM +0800, Jason Xing wrote:
> > > > > > > > > Hi Magnus,
> > > > > > > > >
> > > > > > > > > On Tue, Nov 11, 2025 at 9:44=E2=80=AFPM Magnus Karlsson
> > > > > > > > > <magnus.karlsson@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, 11 Nov 2025 at 14:06, Jason Xing <kerneljasonxi=
ng@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Maciej,
> > > > > > > > > > >
> > > > > > > > > > > On Mon, Nov 3, 2025 at 11:00=E2=80=AFPM Maciej Fijalk=
owski
> > > > > > > > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Sat, Nov 01, 2025 at 07:59:36AM +0800, Jason Xin=
g wrote:
> > > > > > > > > > > > > On Fri, Oct 31, 2025 at 10:02=E2=80=AFPM Maciej F=
ijalkowski
> > > > > > > > > > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Fri, Oct 31, 2025 at 05:32:30PM +0800, Jason=
 Xing wrote:
> > > > > > > > > > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Before the commit 30f241fcf52a ("xsk: Fix imm=
ature cq descriptor
> > > > > > > > > > > > > > > production"), there is one issue[1] which cau=
ses the wrong publish
> > > > > > > > > > > > > > > of descriptors in race condidtion. The above =
commit fixes the issue
> > > > > > > > > > > > > > > but adds more memory operations in the xmit h=
ot path and interrupt
> > > > > > > > > > > > > > > context, which can cause side effect in perfo=
rmance.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > This patch tries to propose a new solution to=
 fix the problem
> > > > > > > > > > > > > > > without manipulating the allocation and deall=
ocation of memory. One
> > > > > > > > > > > > > > > of the key points is that I borrowed the idea=
 from the above commit
> > > > > > > > > > > > > > > that postpones updating the ring->descs in xs=
k_destruct_skb()
> > > > > > > > > > > > > > > instead of in __xsk_generic_xmit().
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The core logics are as show below:
> > > > > > > > > > > > > > > 1. allocate a new local queue. Only its cache=
d_prod member is used.
> > > > > > > > > > > > > > > 2. write the descriptors into the local queue=
 in the xmit path. And
> > > > > > > > > > > > > > >    record the cached_prod as @start_addr that=
 reflects the
> > > > > > > > > > > > > > >    start position of this queue so that later=
 the skb can easily
> > > > > > > > > > > > > > >    find where its addrs are written in the de=
struction phase.
> > > > > > > > > > > > > > > 3. initialize the upper 24 bits of destructor=
_arg to store @start_addr
> > > > > > > > > > > > > > >    in xsk_skb_init_misc().
> > > > > > > > > > > > > > > 4. Initialize the lower 8 bits of destructor_=
arg to store how many
> > > > > > > > > > > > > > >    descriptors the skb owns in xsk_update_num=
_desc().
> > > > > > > > > > > > > > > 5. write the desc addr(s) from the @start_add=
r from the cached cq
> > > > > > > > > > > > > > >    one by one into the real cq in xsk_destruc=
t_skb(). In turn sync
> > > > > > > > > > > > > > >    the global state of the cq.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The format of destructor_arg is designed as:
> > > > > > > > > > > > > > >  ------------------------ --------
> > > > > > > > > > > > > > > |       start_addr       |  num   |
> > > > > > > > > > > > > > >  ------------------------ --------
> > > > > > > > > > > > > > > Using upper 24 bits is enough to keep the tem=
porary descriptors. And
> > > > > > > > > > > > > > > it's also enough to use lower 8 bits to show =
the number of descriptors
> > > > > > > > > > > > > > > that one skb owns.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > [1]: https://lore.kernel.org/all/202505300959=
57.43248-1-e.kubanski@partner.samsung.com/
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Signed-off-by: Jason Xing <kernelxing@tencent=
.com>
> > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > > I posted the series as an RFC because I'd lik=
e to hear more opinions on
> > > > > > > > > > > > > > > the current rought approach so that the fix[2=
] can be avoided and
> > > > > > > > > > > > > > > mitigate the impact of performance. This patc=
h might have bugs because
> > > > > > > > > > > > > > > I decided to spend more time on it after we c=
ome to an agreement. Please
> > > > > > > > > > > > > > > review the overall concepts. Thanks!
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Maciej, could you share with me the way you t=
ested jumbo frame? I used
> > > > > > > > > > > > > > > ./xdpsock -i enp2s0f1 -t -q 1 -S -s 9728 but =
the xdpsock utilizes the
> > > > > > > > > > > > > > > nic more than 90%, which means I cannot see t=
he performance impact.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Could you provide the command you used? Thanks :)
> > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > [2]:https://lore.kernel.org/all/2025103014035=
5.4059-1-fmancera@suse.de/
> > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > >  include/net/xdp_sock.h      |   1 +
> > > > > > > > > > > > > > >  include/net/xsk_buff_pool.h |   1 +
> > > > > > > > > > > > > > >  net/xdp/xsk.c               | 104 ++++++++++=
++++++++++++++++++--------
> > > > > > > > > > > > > > >  net/xdp/xsk_buff_pool.c     |   1 +
> > > > > > > > > > > > > > >  4 files changed, 84 insertions(+), 23 deleti=
ons(-)
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > (...)
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > diff --git a/net/xdp/xsk_buff_pool.c b/net/xd=
p/xsk_buff_pool.c
> > > > > > > > > > > > > > > index aa9788f20d0d..6e170107dec7 100644
> > > > > > > > > > > > > > > --- a/net/xdp/xsk_buff_pool.c
> > > > > > > > > > > > > > > +++ b/net/xdp/xsk_buff_pool.c
> > > > > > > > > > > > > > > @@ -99,6 +99,7 @@ struct xsk_buff_pool *xp_cr=
eate_and_assign_umem(struct xdp_sock *xs,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >       pool->fq =3D xs->fq_tmp;
> > > > > > > > > > > > > > >       pool->cq =3D xs->cq_tmp;
> > > > > > > > > > > > > > > +     pool->cached_cq =3D xs->cached_cq;
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Jason,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > pool can be shared between multiple sockets tha=
t bind to same <netdev,qid>
> > > > > > > > > > > > > > tuple. I believe here you're opening up for the=
 very same issue Eryk
> > > > > > > > > > > > > > initially reported.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Actually it shouldn't happen because the cached_c=
q is more of the
> > > > > > > > > > > > > temporary array that helps the skb store its star=
t position. The
> > > > > > > > > > > > > cached_prod of cached_cq can only be increased, n=
ot decreased. In the
> > > > > > > > > > > > > skb destruction phase, only those skbs that go to=
 the end of life need
> > > > > > > > > > > > > to sync its desc from cached_cq to cq. For some s=
kbs that are released
> > > > > > > > > > > > > before the tx completion, we don't need to clear =
its record in
> > > > > > > > > > > > > cached_cq at all and cq remains untouched.
> > > > > > > > > > > > >
> > > > > > > > > > > > > To put it in a simple way, the patch you proposed=
 uses kmem_cached*
> > > > > > > > > > > > > helpers to store the addr and write the addr into=
 cq at the end of
> > > > > > > > > > > > > lifecycle while the current patch uses a pre-allo=
cated memory to
> > > > > > > > > > > > > store. So it avoids the allocation and deallocati=
on.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Unless I'm missing something important. If so, I'=
m still convinced
> > > > > > > > > > > > > this temporary queue can solve the problem since =
essentially it's a
> > > > > > > > > > > > > better substitute for kmem cache to retain high p=
erformance.
> > > > > > > >
> > > > > > > > Back after health issues!
> > > > > > >
> > > > > > > Hi Maciej,
> > > > > > >
> > > > > > > Hope you're fully recovered:)
> > > > > > >
> > > > > > > >
> > > > > > > > Jason, I am still not convinced about this solution.
> > > > > > > >
> > > > > > > > In shared pool setups, the temp cq will also be shared, whi=
ch means that
> > > > > > > > two parallel processes can produce addresses onto temp cq a=
nd therefore
> > > > > > > > expose address to a socket that it does not belong to. In o=
rder to make
> > > > > > > > this work you would have to know upfront the descriptor cou=
nt of given
> > > > > > > > frame and reserve this during processing the first descript=
or.
> > > > > > > >
> > > > > > > > socket 0                        socket 1
> > > > > > > > prod addr 0xAA
> > > > > > > > prod addr 0xBB
> > > > > > > >                                 prod addr 0xDD
> > > > > > > > prod addr 0xCC
> > > > > > > >                                 prod addr 0xEE
> > > > > > > >
> > > > > > > > socket 0 calls skb destructor with num desc =3D=3D 3, placi=
ng 0xDD onto cq
> > > > > > > > which has not been sent yet, therefore potentially corrupti=
ng it.
> > > > > > >
> > > > > > > Thanks for spotting this case!
> > > > > > >
> > > > > > > Yes, it can happen, so let's turn into a per-xsk granularity?=
 If each
> > > > > > > xsk has its own temp queue, then the problem would disappear =
and good
> > > > > > > news is that we don't need extra locks like pool->cq_lock to =
prevent
> > > > > > > multiple parallel xsks accessing the temp queue.
> > > > > >
> > > > > > Sure, when you're confident this is working solution then you c=
an post it.
> > > > > > But from my POV we should go with Fernando's patch and then you=
 can send
> > > > > > patches to bpf-next as improvements. There are people out there=
 with
> > > > > > broken xsk waiting for a fix.
> > > > >
> > > > > Fine, I will officially post it on the next branch. But I think a=
t
> > > > > that time, I have to revert both patches (your and Fernando's
> > > > > patches)? Will his patch be applied to the stable branch only so =
that
> > > > > I can make it on the next branch?
> > > >
> > > > Give it some time and let Fernando repost patch and then after appl=
ying
> > > > all the backport machinery will kick in. I suppose after bpf->bpf-n=
ext
> > > > merge you could step in and in the meantime I assume you've got ple=
nty of
> > > > stuff to work on. My point here is we already hesitated too much in=
 this
> > > > matter IMHO.
> > >
> > > I have no intention to stop that patch from being merged :)
> > >
> > > I meant his patch will be _only_ merged into the net/stable branch an=
d
> > > _not_ be merged into the next branch, right? If so, I can continue my
> > > approach only targetting the next branch without worrying about his
> > > patch which can cause conflicts.
> >
> > net/bpf branches are merged periodically to -next variants, AFAICT. New
> > kernels carry the fixes as well. Purpose of net/bpf branches is to addr=
ess
> > the stable kernels with developed fixes.
>
> Oh, well. I wonder if we can stop merging that patch in
> net-next/bpf-next since I can post my series today? For now, there are
> two things to be done: one is to revert only one patch and the other
> is to add a temp queue function.

I found that it might be easier for me to continue my work on top of
his patch....

My plan is to include his patch as the first one (which of course
needs to be rebased) along with a few patches of temp cq approach. I
will finish it as soon as possible.

Thanks,
Jason

