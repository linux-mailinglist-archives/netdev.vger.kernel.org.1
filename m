Return-Path: <netdev+bounces-82396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B85F88D861
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 09:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00CAE29D13B
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 08:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A972C694;
	Wed, 27 Mar 2024 08:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OK8UOyKQ"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282F42577D
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 08:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526851; cv=none; b=KsHp3pTDlHWUiAXMmr3dhlebdP2tS4c4spS1lVlXy+7Wab8PCv84RF5Sgq2shcs2r0cHzg0rPN457EZ+0W/y2X5QdBttNGyWmDeIOfWNuxX+YwULG2p4QrcB6swF22UW1/Rm2LjiSdO95H2lAJIj3BC6HXjnKDJmlUcXiVuiu9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526851; c=relaxed/simple;
	bh=zb9pTWa4v6J7bjx0jnI6uWcGPwFOi+i8kDB7D26ywz4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=mFnRyxHrTrn09OwGmcUT7jNVZFc8JSqrEYRLwaRE442rfnL8UJBvnr34ZmpBwc1shR05oXIypLNWkHHL4ex3/DtAo3FP4TLQ0K2Y+vU9ZyTvKdIsr3ZFKf50N4UVOwsxuIB6SxPmppdrEzygvK3vDeFc2otV1XN8ZqMJsWjUGPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OK8UOyKQ; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711526840; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=HqBglzuBzXwHz8JFm548qIsgg7kLqHB9t6RwxUvdavE=;
	b=OK8UOyKQsVDuIcAS7ycoSvlI/l3b4EC4eUdvB4DYR/Fx1peuxEhmnYrGb5Psm6Aq8K+T/vLJzRJoWFOu8UGj+9fwOE1Nw8BAhRdKCVZxCzQdoki5Cy2asdxgsX8UKUKJiMmUdWs3nLGwRgngzabONkg0nHtSY3x4H8dH53R6zWs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W3NzNmQ_1711526839;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3NzNmQ_1711526839)
          by smtp.aliyun-inc.com;
          Wed, 27 Mar 2024 16:07:20 +0800
Message-ID: <1711526642.5018039-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v5 00/10] virtio: drivers maintain dma info for premapped vq
Date: Wed, 27 Mar 2024 16:04:02 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20240325085428.7275-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtEWCjb8+Zcfizij2+0ef-wb8YJD2bfyAvP_72hKZrGvA@mail.gmail.com>
 <1711523698.8996527-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEvzMKyYTNwCwept1HJKLM8FZBa2FZq1oyQ0tFVL2TvMeQ@mail.gmail.com>
In-Reply-To: <CACGkMEvzMKyYTNwCwept1HJKLM8FZBa2FZq1oyQ0tFVL2TvMeQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 27 Mar 2024 15:50:17 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Mar 27, 2024 at 3:16=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Tue, 26 Mar 2024 14:35:21 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Mon, Mar 25, 2024 at 4:54=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > As discussed:
> > > >
> > > > http://lore.kernel.org/all/CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVm=
J3rHYqRZxYg@mail.gmail.com
> > > >
> > > > If the virtio is premapped mode, the driver should manage the dma i=
nfo by self.
> > > > So the virtio core should not store the dma info. We can release th=
e memory used
> > > > to store the dma info.
> > > >
> > > > For virtio-net xmit queue, if the virtio-net maintains the dma info,
> > > > the virtio-net must allocate too much memory(19 * queue_size for pe=
r-queue), so
> > > > we do not plan to make the virtio-net to maintain the dma info by d=
efault. The
> > > > virtio-net xmit queue only maintain the dma info when premapped mod=
e is enable
> > > > (such as AF_XDP is enable).
> > > >
> > > > So this patch set try to do:
> > > >
> > > > 1. make the virtio core to do not store the dma info when driver ca=
n do that
> > > >     - But if the desc_extra has not dma info, we face a new questio=
n,
> > > >       it is hard to get the dma info of the desc with indirect flag.
> > > >       For split mode, that is easy from desc, but for the packed mo=
de,
> > > >       it is hard to get the dma info from the desc. And hardening
> > > >       the dma unmap is safe, we should store the dma info of indire=
ct
> > > >       descs when the virtio core does not store the bufer dma info.
> > > >
> > > >       The follow patches to this:
> > > >          * virtio_ring: packed: structure the indirect desc table
> > > >          * virtio_ring: split: structure the indirect desc table
> > > >
> > > >     - On the other side, in the umap handle, we mix the indirect de=
scs with
> > > >       other descs. That make things too complex. I found if we we d=
istinguish
> > > >       the descs with VRING_DESC_F_INDIRECT before unmap, thing will=
 be clearer.
> > > >
> > > >       The follow patches do this.
> > > >          * virtio_ring: packed: remove double check of the unmap ops
> > > >          * virtio_ring: split: structure the indirect desc table
> > > >
> > > > 2. make the virtio core to enable premapped mode by find_vqs() para=
ms
> > > >     - Because the find_vqs() will try to allocate memory for the dm=
a info.
> > > >       If we set the premapped mode after find_vqs() and release the
> > > >       dma info, that is odd.
> > > >
> > > >
> > > > Please review.
> > > >
> > > > Thanks
> > >
> > > This doesn't apply cleany on vhost.git linux-next branch.
> > >
> > > Which tree is this based on?
> >
> >
> > Sorry. That is on the top of "[PATCH vhost v5 0/6] refactor the params =
of
> > find_vqs()".
> >
> > Lore-URL: http://lore.kernel.org/all/20240325090419.33677-1-xuanzhuo@li=
nux.alibaba.com
> >
> > Thanks.
>
> I've tried that but it doesn't work:
>
> % git am ~/Downloads/\[PATCH\ vhost\ v5\ 01_10\]\ virtio_ring_\
> introduce\ vring_need_unmap_buffer.eml
> Applying: virtio_ring: introduce vring_need_unmap_buffer
> error: patch failed: drivers/virtio/virtio_ring.c:2080
> error: drivers/virtio/virtio_ring.c: patch does not apply
> Patch failed at 0001 virtio_ring: introduce vring_need_unmap_buffer
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> I'm using vhost.git linux-next branch, HEAD is
>
> commit 56e71885b0349241c07631a7b979b61e81afab6a
> Author: Maxime Coquelin <maxime.coquelin@redhat.com>
> Date:   Tue Jan 9 12:10:24 2024 +0100
>
>     vduse: Temporarily fail if control queue feature requested


NOT ON the vhost directly.

That is on the top of "refactor the params of find_vqs"

"refactor the params of find_vqs" said:

	"""
	This pathset is splited from the

	     http://lore.kernel.org/all/20240229072044.77388-1-xuanzhuo@linux.alib=
aba.com

	That may needs some cycles to discuss. But that notifies too many people.
	"""

But now that is broken due to the change of the that patch set.

I will post the new version of these two patch set soon.

Thanks.


>
> Thanks
>
> >
> > >
> > > Thanks
> > >
> >
>

