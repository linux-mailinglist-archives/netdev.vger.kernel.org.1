Return-Path: <netdev+bounces-185758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF94FA9BAC3
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 00:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6923492696C
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 22:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E421221278;
	Thu, 24 Apr 2025 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ss/NJLNm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4235D1FA178
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 22:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745533600; cv=none; b=tJ9TkXCz+qHaHCK+GM/X5LRXqFcxDd4bt8iN+l35re6LEbWDNU1qgamHSRQSYg5vu8ySAO86IuzcLZmgdHhWm6Y/ZKXBTICbsR6GBswvUfHP4DgRYEC7pNnyqduOwdqagjuqTrH4aRt8+EsTa8P2MqimuQc/GzxF2sqppylJ088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745533600; c=relaxed/simple;
	bh=syuBhkNtH2bkZxZv5HVueABSFMLgwP82SiOCRlS1mAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYx38m68Tv1b5rDHxFQULi1N1a+OCDv3ga4yPedrSkkodXzs0VbSO/qtIF/rlaEOt/9b7YVQFOC3q6YQXzdI5Lowf8x6YagJPwl3RO1pLsNuwhEn7umumG65KMn1v1KP6Sv6mw5udXKpr2diD1Q3ILiEqnqQCW04WgWYZemLNu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ss/NJLNm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2240aad70f2so62425ad.0
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 15:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745533597; x=1746138397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QP9VRLcmsVvp0rC3tf1y+aWZAq5OUegXkhZghCla8mI=;
        b=Ss/NJLNmg0uA04kjRPUn2HRMNK4XEhtgLDNj7uolXe2iSmbUKNaTUFlGbhTuCch5zq
         DnlPSO69eest/wBzJJ9sSxdl8D4PCLDRuxYWtcut1e5lJk1rddaVEjS5cCCo4xPy4F8i
         TPkwDcBysms83f6BEMEKmZ586M4xL1HAPFQ86MNLlweKjgygRBmIIFEe7vY0dEoaOLku
         nXe5PmUc/D7r2Q1eruUQc1R1N4bGs0zHkC5ylqSmPyfIaw4Sy6UlRyDNoNAEGocRijN9
         y2VvKvSH3OWn5AVk5wcdeKSBlRAuHmpA4FvMq/Ha5dPNSEoTr8sMQDGmnhRE9rxD1aCP
         Fo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745533597; x=1746138397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QP9VRLcmsVvp0rC3tf1y+aWZAq5OUegXkhZghCla8mI=;
        b=P48CKEVo8DToMsP0yEke1SSlFgqAq3t97s4AilyG83NWNhzmTGCsE08w6iuVkxR6rb
         zyje0ikse6wZik0/B+BeUVqLEkZ7ST8VsMfDROIBs4T73HA2i1+AXxY30/WaKwbBoqpc
         C+FJKUqsfW17uNIFCp+HQofGvXrE4V+sYt3U/pAGXIEpcK1uMABSOlFMdcY4BG0LnZFh
         EEr+kgR+WdlqDrtuUYN4RizvKre3BtaQCmgmOIlMlOY+3pjRH3llv9wF3C1fnuatrQRM
         E7RwCQ7dStdXtTrLOwKxVbFe3HSkwkwoHj+zImFdA8z4R4HBFyWHbgfcVCC0fNiPbGf5
         yvDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpyarcvmKEksGsa3y4Yc6k+DhZpIzCCNmV8S1d8MT6hNGxiR82BJgpPaxirapAPn5RRb1m1/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ0wv7Z/rltU5p4NSCXLBnJ5FfgwTaDK8e6ihXqBrU2deH7Otb
	i1Ox8IOHqfbpotbUbOeX+fZl0KlEFq+g0RiFDGCv8uyP19+ZXlyZpafDNbZlfpVbQULEhPz+Z75
	WswlVCiwkgrMpyFC1jMxAafiX+8bOQIfzOk4HlKSc65gXJBwivw==
X-Gm-Gg: ASbGnctUzomux/8yUT96rOe0mKoM3ZYSIPma6HtPJGAJX04mlS5Xq635bihFG8GhW1E
	NJvsL+KhY80dnhMUn9HlPAOjZef2rdQKeOjkwUAFREBGyYq/r91LG+FaGL9SHlSe7wlwDHFr6M5
	rihneqnFZt+37Tv5cktnHhAojdsPbGjvsJVjojBAyR1QQ51CRkPuQEpd3h8YvqwRQ=
X-Google-Smtp-Source: AGHT+IESfKEZFs1U16gzuiEGSvNXR2AD5y8vTGzCoLIAhsmf+LbE4GaBeQz6jKs7z8fHA2/f7YLqVKKHLWjS1I7S7EY=
X-Received: by 2002:a17:903:8c5:b0:22c:33b4:c2ed with SMTP id
 d9443c01a7336-22dbda00905mr1090235ad.26.1745533597286; Thu, 24 Apr 2025
 15:26:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423153504.1085434-1-cratiu@nvidia.com> <CAHS8izPxT_SB6+fc7dPcojv3mui3BjDZB5xmz3u6oYuA2805FA@mail.gmail.com>
 <aAlKaELj0xIbJ45c@mini-arch> <CAHS8izOm4QbHECZDB+imV2eVXs=KXRKzJsDw2gKGp_gx0ja7Ng@mail.gmail.com>
 <aAq2y_awPoGqhjdp@mini-arch>
In-Reply-To: <aAq2y_awPoGqhjdp@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 24 Apr 2025 15:26:24 -0700
X-Gm-Features: ATxdqUGtlFF7acNnnMcbJ0VKd5NGlgAB3nb5-8NBe1iaHF-xV5oSOLCGrYjVLbk
Message-ID: <CAHS8izNAtzyjY94qPq1-2sPUUDaN14SCXrgM5XkwCNDz4SgbvQ@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/devmem: Reject insufficiently large dmabuf pools
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Cosmin Ratiu <cratiu@nvidia.com>, netdev@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 3:10=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 04/24, Mina Almasry wrote:
> > On Wed, Apr 23, 2025 at 1:15=E2=80=AFPM Stanislav Fomichev <stfomichev@=
gmail.com> wrote:
> > >
> > > On 04/23, Mina Almasry wrote:
> > > > On Wed, Apr 23, 2025 at 9:03=E2=80=AFAM Cosmin Ratiu <cratiu@nvidia=
.com> wrote:
> > > > >
> > > > > Drivers that are told to allocate RX buffers from pools of DMA me=
mory
> > > > > should have enough memory in the pool to satisfy projected alloca=
tion
> > > > > requests (a function of ring size, MTU & other parameters). If th=
ere's
> > > > > not enough memory, RX ring refill might fail later at inconvenien=
t times
> > > > > (e.g. during NAPI poll).
> > > > >
> > > >
> > > > My understanding is that if the RX ring refill fails, the driver wi=
ll
> > > > post the buffers it was able to allocate data for, and will not pos=
t
> > > > other buffers. So it will run with a degraded performance but nothi=
ng
> > > > overly bad should happen. This should be the same behavior if the
> > > > machine is under memory pressure.
> > > >
> > > > In general I don't know about this change. If the user wants to use
> > > > very small dmabufs, they should be able to, without going through
> > > > hoops reducing the number of rx ring slots the driver has (if it
> > > > supports configuring that).
> > > >
> > > > I think maybe printing an error or warning that the dmabuf is too
> > > > small for the pool_size may be fine. But outright failing this
> > > > configuration? I don't think so.
> > > >
> > > > > This commit adds a check at dmabuf pool init time that compares t=
he
> > > > > amount of memory in the underlying chunk pool (configured by the =
user
> > > > > space application providing dmabuf memory) with the desired pool =
size
> > > > > (previously set by the driver) and fails with an error message if=
 chunk
> > > > > memory isn't enough.
> > > > >
> > > > > Fixes: 0f9214046893 ("memory-provider: dmabuf devmem memory provi=
der")
> > > > > Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> > > > > ---
> > > > >  net/core/devmem.c | 11 +++++++++++
> > > > >  1 file changed, 11 insertions(+)
> > > > >
> > > > > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > > > > index 6e27a47d0493..651cd55ebb28 100644
> > > > > --- a/net/core/devmem.c
> > > > > +++ b/net/core/devmem.c
> > > > > @@ -299,6 +299,7 @@ net_devmem_bind_dmabuf(struct net_device *dev=
, unsigned int dmabuf_fd,
> > > > >  int mp_dmabuf_devmem_init(struct page_pool *pool)
> > > > >  {
> > > > >         struct net_devmem_dmabuf_binding *binding =3D pool->mp_pr=
iv;
> > > > > +       size_t size;
> > > > >
> > > > >         if (!binding)
> > > > >                 return -EINVAL;
> > > > > @@ -312,6 +313,16 @@ int mp_dmabuf_devmem_init(struct page_pool *=
pool)
> > > > >         if (pool->p.order !=3D 0)
> > > > >                 return -E2BIG;
> > > > >
> > > > > +       /* Validate that the underlying dmabuf has enough memory =
to satisfy
> > > > > +        * requested pool size.
> > > > > +        */
> > > > > +       size =3D gen_pool_size(binding->chunk_pool) >> PAGE_SHIFT=
;
> > > > > +       if (size < pool->p.pool_size) {
> > > >
> > > > pool_size seems to be the number of ptr_ring slots in the page_pool=
,
> > > > not some upper or lower bound on the amount of memory the page_pool
> > > > can provide. So this check seems useless? The page_pool can still n=
ot
> > > > provide this amount of memory with dmabuf (if the netmems aren't be=
ing
> > > > recycled fast enough) or with normal memory (under memory pressure)=
.
> > >
> > > I read this check more as "is there enough chunks in the binding to
> > > fully fill in the page pool". User controls the size of rx ring
> >
> > Only on drivers that support ethtool -G, and where it will let you
> > configure -G to what you want.
>
> gve is the minority here, any major nic (brcm/mlx/intel) supports resizin=
g
> the rings.
>

GVE supports resizing rings. Other drivers may not. Even on drivers
that support resizing rings. Some users may have a use case for a
dmabuf smaller than the minimum ring size their driver accepts.

> > > which
> > > controls the size of the page pool which somewhat dictates the minima=
l
> > > size of the binding (maybe).
> >
> > See the test I ran in the other thread. Seems at least GVE is fine
> > with dmabuf size < ring size. I don't know what other drivers do, but
> > generally speaking I think specific driver limitations should not
> > limit what others can do with their drivers. Sure for the GPU mem
> > applications you're probably looking at the dmabufs are huge and
> > supporting small dmabufs is not a concern, but someone somewhere may
> > want to run with 1 MB dmabuf for some use case and if their driver is
> > fine with it, core should not prevent it, I think.
> >
> > > So it's more of a sanity check.
> > >
> > > Maybe having better defaults in ncdevmem would've been a better optio=
n? It
> > > allocates (16000*4096) bytes (slightly less than 64MB, why? to fit in=
to
> > > default /sys/module/udmabuf/parameters/size_limit_mb?) and on my setu=
p
> > > PP wants to get 64MB at least..
> >
> > Yeah, udmabuf has a limitation that it only supports 64MB max size
> > last I looked.
>
> We can use /sys/module/udmabuf/parameters/size_limit_mb to allocate
> more than 64MB, ncdevmem can change it.

The udmabuf limit is hardcoded, in udmabuf.c or configured on module
load, and ncdevmem doesn't load udmabuf. I guess it could be changed
to that, but currently ncdevmem works with CONFIG_UDMABUF=3Dy

> Or warn the user similar
> to what kperf does: https://github.com/facebookexperimental/kperf/blob/ma=
in/devmem.c#L308
>
> So either having a kernel warn or tuning 63MB up to something sensible
> (1G?) should prevent people from going through the pain..
>

Agreed with both. Another option is updating the devmem.rst docs:

"Some drivers may struggle to run devmem TCP when the dmabuf size is
too small, especially when it's smaller than the number of rx ring
slots. Look for this warning in dmesg." etc.

But I don't see the need to outright disable this "dmabuf size < ring
size" use case for everyone to solve this.

> > I added devmem TCP support with udmabuf selftests to demonstrate that
> > the feature is non-proprietary, not to advertise that devmem tcp +
> > udmabuf is a great combination. udmabuf is actually terrible for
> > devmem TCP. The 64MB limit is way too small for anyone to do anything
> > performant on it and by dmaing into host memory you lose many of the
> > benefits of devmem TCP (lower mem bw + pcie bw utilization).
>
> It would still be nice to have a udmabuf as a properly supported option.
> This can drive the UAPI performance conversions: for example, comparing
> existing tcp rx zerocopy vs MSG_SOCK_DEVMEM.. So let's not completely
> dismiss it. We've played internally with doing 2MB udmabuf huge-pages,
> might post it at some point..
>
> > If you're running real experiments with devmem TCP I suggest moving to
> > real dmabufs as soon as possible, or at least hack udmabuf to give you
> > large sizes. We've open sourced our production devmem TCP userspace:
> >
> > https://github.com/google/tcpgpudmarxd
> > https://github.com/google/nccl-plugin-gpudirecttcpx
> >
> > Porting it to upstream APIs + your dmabuf provider will have you run
> > much more interesting tests than anything you do with udmabuf I think,
> > unless you hack the udmabuf size.
>
> I found these a bit too late, so I reimplemented the plugin over
> upstream APIs :-[

Oh, where? Is it open source?

> Plus, you yourself have acked [0], guess why
> I sent this patch :-D Once the tx part is accepted, we'll upstream
> kperf cuda support as well..
>

Cool!

> 0: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/co=
mmit/?id=3D8b9049af8066b4705d83bb7847ee3c960fc58d09

--=20
Thanks,
Mina

