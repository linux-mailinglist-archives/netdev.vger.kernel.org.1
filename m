Return-Path: <netdev+bounces-204715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84879AFBDE4
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 23:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA151BC04FE
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 21:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0389D285C95;
	Mon,  7 Jul 2025 21:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1s7+89zi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5900F1C6FE1
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 21:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751925326; cv=none; b=BzNoa87K3WxArrl8b8MbPVMjPb7hbD46oNxc4OSu9X6ylEsncLPl3RFnETlILDIlFjiAu77iqP/FrvvxqTx2sKMdI8DqAR5rrBz/irxY3kSatGYrq8w4BJLnwkFflh6KSuI7pmhBoIJI/pFnryduKEIQPbbj2vbeE5IdvisLlFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751925326; c=relaxed/simple;
	bh=9AGMi6aOUv8lZr+RXfz2XCf31Nuvt0TeuQmn1A5hoCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSP4bmM2kyAVpP6xyPDuSfM/LtfUt2oBcab2WYWjRNTx9ICbUpYGGn+oS9jb4PILoUcNLdNRrejJ6z9bUlzqhZFmgVcOPkRJX3X2USNNQtXr5HKOBSX+EJFHqWJLxFLH5B8Ljr7AcmnHQSlYsxVWe409o/YN7BfD6ezl0gTPINU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1s7+89zi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-235e389599fso82785ad.0
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 14:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751925325; x=1752530125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjODZ7b3pUgkuHWTOlB6q0MkE7zknx2t+C23plqUGVI=;
        b=1s7+89ziOyRjmhJfH/FQ+bDNeXbN5cONQvBuKNGoUepXlaG2u9sJM79RqrNVQGCb90
         uBtqf/0oy5lfNYzHeYjJOsNwlvYUjPAvBVk9H7evj0w4jFAL/D+uJXvqWbqr9J0l3BRj
         Iz6vmgHZPRugHTl7shBlWzM2mt/7HNyZ9z95kBdY4MuLSFlePtue91cVeuh9DqBzEV9l
         6VRPueZGShp4niLyBW93uv3bvQ+Kcer4u/vsfAddhBPUQUmy87QDHBF1l24dakmJ5ZJJ
         RkwjWuCjtVuSxiKK9FT7nPHwE0+jYydjHB3Ib7JfpqduMOGddTbti3KIQyo33svAq47h
         9LPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751925325; x=1752530125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjODZ7b3pUgkuHWTOlB6q0MkE7zknx2t+C23plqUGVI=;
        b=WcxKSVfLy+RDyQCHLbEFGkcM3joQ1YafVBPnzRffKS44bf9fJyQ2Ak17AuRGioXEjr
         ZwX3/st6jn1yGtPDtNmD03x+ns+5OmDmHdVAUPjFd/f/2FP1EFFf7Nrd/E5FhggW8h4k
         PdNXcpdeHkw13dpj3HLUqInrlN3QCXL96SfABjwYwSZ2TDWGmr7gHKhNKlZlZYxmrcJr
         O6YLg1UQMnx34LYxyrKEQFPBC4ZWydPUbIVbicvZGnH35vbVshqVrPjTCCMsFir5o9Fx
         tiJulmUc/NtSCaMH9vzSb9/gofu6y66al4GZ/iJ7yCH1nSpOiVUx1My1l/iCDiVYhiyc
         bOZg==
X-Forwarded-Encrypted: i=1; AJvYcCU6WJnfkwCLXnxgqr9oNeG8tUCNb05ZD082nWpXeGudf3/AEaO+lRB1CIur8mwR/W80/r2cm0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyr5YSCUNLm/JjhYBupviEyuyq51g6dpWDZx+STuuKL6LOylfK
	AMtsJvdJ36oOjA3RbbSbwptRChrBkzHYIz0OGlg8CP0hJEQuzXUJ3vm0khFakB4YsDjpr78fmI8
	yIOU1dluoKj3QQZsR9L1rw6MXoZI4cTRW2iYgBJXH
X-Gm-Gg: ASbGncsjOYsAnJ3iK7nuHcs0YIlqx4Zv0a9FjyGuRKen8krjCmDWH06snug9cwIfr5R
	FwL7Gftz0YyUMmPo31CBbl+IA9E1v8JpJRVrIfCrmqydC9L+Di/ZZPUwcVAPdIql8Yujp7z6AXk
	D0Q5dVSH1cR7G6fwKmiKbfKin5iTIwg9fUj/vL1MI2+iWqvUO469AfouReZuJe/RxW2k0upJfpF
	Q==
X-Google-Smtp-Source: AGHT+IEUyNA21PNLfpesvG5K4xIaoCzv68+pnS1VVkTUe7gUYeQrdXt9UG8p4qMQV0+grM07E7RHnYwdtIk1mXmGjiA=
X-Received: by 2002:a17:903:32c8:b0:235:f18f:291f with SMTP id
 d9443c01a7336-23dd1c67ccbmr300755ad.23.1751925324336; Mon, 07 Jul 2025
 14:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702172433.1738947-1-dtatulea@nvidia.com> <20250702172433.1738947-2-dtatulea@nvidia.com>
 <20250702113208.5adafe79@kernel.org> <c5pxc7ppuizhvgasy57llo2domksote5uvo54q65shch3sqmkm@bgcnojnxt4hh>
 <20250702135329.76dbd878@kernel.org> <CY8PR12MB7195361C14592016B8D2217DDC43A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <22kf5wtxym5x3zllar7ek3onkav6nfzclf7w2lzifhebjme4jb@h4qycdqmwern>
 <CAHS8izN-yJ1tm0uUvQxq327-bU1Vzj8JVc6bqns0CwNnWhc_XQ@mail.gmail.com> <sdy27zexcqivv4bfccu36koe4feswl5panavq3t2k6nndugve3@bcbbjxiciaow>
In-Reply-To: <sdy27zexcqivv4bfccu36koe4feswl5panavq3t2k6nndugve3@bcbbjxiciaow>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 7 Jul 2025 14:55:11 -0700
X-Gm-Features: Ac12FXy6PtsGridoKCc-iCQycbBbvTllmo3prjwvZXhIWiUYJxClF9O2WMIZiK0
Message-ID: <CAHS8izPTBY9vL-H31t26kEc4Y4UEMm+jW0K0NtbqmcsOA9s4Cw@mail.gmail.com>
Subject: Re: [RFC net-next 1/4] net: Allow non parent devices to be used for
 ZC DMA
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, 
	"asml.silence@gmail.com" <asml.silence@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 2:35=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> On Mon, Jul 07, 2025 at 11:44:19AM -0700, Mina Almasry wrote:
> > On Fri, Jul 4, 2025 at 6:11=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.=
com> wrote:
> > >
> > > On Thu, Jul 03, 2025 at 01:58:50PM +0200, Parav Pandit wrote:
> > > >
> > > > > From: Jakub Kicinski <kuba@kernel.org>
> > > > > Sent: 03 July 2025 02:23 AM
> > > > >
> > > [...]
> > > > > Maybe someone with closer understanding can chime in. If the kind=
 of
> > > > > subfunctions you describe are expected, and there's a generic way=
 of
> > > > > recognizing them -- automatically going to parent of parent would=
 indeed be
> > > > > cleaner and less error prone, as you suggest.
> > > >
> > > > I am not sure when the parent of parent assumption would fail, but =
can be
> > > > a good start.
> > > >
> > > > If netdev 8 bytes extension to store dma_dev is concern,
> > > > probably a netdev IFF_DMA_DEV_PARENT can be elegant to refer parent=
->parent?
> > > > So that there is no guess work in devmem layer.
> > > >
> > > > That said, my understanding of devmem is limited, so I could be mis=
taken here.
> > > >
> > > > In the long term, the devmem infrastructure likely needs to be
> > > > modernized to support queue-level DMA mapping.
> > > > This is useful because drivers like mlx5 already support
> > > > socket-direct netdev that span across two PCI devices.
> > > >
> > > > Currently, devmem is limited to a single PCI device per netdev.
> > > > While the buffer pool could be per device, the actual DMA
> > > > mapping might need to be deferred until buffer posting
> > > > time to support such multi-device scenarios.
> > > >
> > > > In an offline discussion, Dragos mentioned that io_uring already
> > > > operates at the queue level, may be some ideas can be picked up
> > > > from io_uring?
> > > The problem for devmem is that the device based API is already set in
> > > stone so not sure how we can change this. Maybe Mina can chime in.
> > >
> >
> > I think what's being discussed here is pretty straight forward and
> > doesn't need UAPI changes, right? Or were you referring to another
> > API?
> >
> I was referring to the fact that devmem takes one big buffer, maps it
> for a single device (in net_devmem_bind_dmabuf()) and then assigns it to
> queues in net_devmem_bind_dmabuf_to_queue(). As the single buffer is
> part of the API, I don't see how the mapping could be done in a per
> queue way.
>

Oh, I see. devmem does support mapping a single buffer to multiple
queues in a single netlink API call, but there is nothing stopping the
user from mapping N buffers to N queues in N netlink API calls.

> > > To sum the conversation up, there are 2 imperfect and overlapping
> > > solutions:
> > >
> > > 1) For the common case of having a single PCI device per netdev, goin=
g one
> > >    parent up if the parent device is not DMA capable would be a good
> > >    starting point.
> > >
> > > 2) For multi-PF netdev [0], a per-queue get_dma_dev() op would be ide=
al
> > >    as it provides the right PF device for the given queue.
> >
> > Agreed these are the 2 options.
> >
> > > io_uring
> > >    could use this but devmem can't. Devmem could use 1. but the
> > >    driver has to detect and block the multi PF case.
> > >
> >
> > Why? AFAICT both io_uring and devmem are in the exact same boat right
> > now, and your patchset seems to show that? Both use dev->dev.parent as
> > the mapping device, and AFAIU you want to use dev->dev.parent.parent
> > or something like that?
> >
> Right. My patches show that. But the issue raised by Parav is different:
> different queues can belong to different DMA devices from different
> PFs in the case of Multi PF netdev.
>
> io_uring can do it because it maps individual buffers to individual
> queues. So it would be trivial to get the DMA device of each queue throug=
h
> a new queue op.
>

Right, devmem doesn't stop you from mapping individual buffers to
individual queues. It just also supports mapping the same buffer to
multiple queues. AFAIR, io_uring also supports mapping a single buffer
to multiple queues, but I could easily be very wrong about that. It's
just a vague recollection from reviewing the iozcrx.c implementation a
while back.

In your case, I think, if the user is trying to map a single buffer to
multiple queues, and those queues have different dma-devices, then you
have to error out. I don't see how to sanely handle that without
adding a lot of code. The user would have to fall back onto mapping a
single buffer to a single queue (or multiple queues that share the
same dma-device).

> > Also AFAIU the driver won't need to block the multi PF case, it's
> > actually core that would need to handle that. For example, if devmem
> > wants to bind a dmabuf to 4 queues, but queues 0 & 1 use 1 dma device,
> > but queues 2 & 3 use another dma-device, then core doesn't know what
> > to do, because it can't map the dmabuf to both devices at once. The
> > restriction would be at bind time that all the queues being bound to
> > have the same dma device. Core would need to check that and return an
> > error if the devices diverge. I imagine all of this is the same for
> > io_uring, unless I'm missing something.
> >
> Agreed. Currently I didn't see an API for Multi PF netdev to expose
> this information so my thinking defaulted to "let's block it from the
> driver side".
>

Agreed.

> > > I think we need both. Either that or a netdev op with an optional que=
ue
> > > parameter. Any thoughts?
> > >
> >
> > At the moment, from your description of the problem, I would lean to
> > going with Jakub's approach and handling the common case via #1. If
> > more use cases that require a very custom dma device to be passed we
> > can always move to #2 later, but FWIW I don't see a reason to come up
> > with a super future proof complicated solution right now, but I'm
> > happy to hear disagreements.
> But we also don't want to start off on the left foot when we know of
> both issues right now. And I think we can wrap it up nicely in a single
> function similary to how the current patch does it.
>

FWIW I don't have a strong preference. I'm fine with the simple
solution for now and I'm fine with the slightly more complicated
future proof solution.

--=20
Thanks,
Mina

