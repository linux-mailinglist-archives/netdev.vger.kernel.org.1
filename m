Return-Path: <netdev+bounces-82357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 032A788D70D
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 08:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922351F27F9E
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 07:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB01B24B26;
	Wed, 27 Mar 2024 07:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qTARX97f"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4E224211
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 07:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711523776; cv=none; b=JqEepNx6xbM7ICc8nfYB3dudY3CEYPXv1awz3T6VD4Tgj7xBEiXQFHjKr6n4WaLHcXDLSF097qJvwwH26b9vTfnxIaEPoi4E0CfTjLqDCAbEmxYBbhWpICYnpti8MOC9L0prQKYsoOIV+nU4jIIUsLK9Xin1XBVSdfXeU5OENzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711523776; c=relaxed/simple;
	bh=kDdm8hEYohfXelRrmZggLCcWeFW6IOJLlADSDE4d4CE=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=B0ix2Me/6fnWMr+O7oXsZsdN4G/7AFWiaMZtKbGyLrE8Ve53n4FlMbydmwfLRDskrtUyyNH9Ycq+ZJwIDQaMmuAj1PExIjg3e0hsONJEcp3zGu/2Gi8Ce9j2fJE0w2sgLTQ6YxSbrhooOkB0+LfiqqFsbEEfvDa4w4A7hfK28Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qTARX97f; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711523772; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=oWppE/QA18ZHv4BeAUEMpkgtAUE7wCmySEaGiLBMekQ=;
	b=qTARX97fPYYngFcOrV8tUnDfcxer0ao85TESqwlJBNQ1iZn1P6UDT/bQsGcvgh4Run/1NSrIgASwKmAovGBS2qJp3trqmJ6kD2f5Zr0dK8GMvdMpReZ5cIEL5hYR9/DHLqAvZkrO2ZMP9pfgR5ogP1mAAd/tYEHxl8Hgh/FAGGM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W3NsP.d_1711523771;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3NsP.d_1711523771)
          by smtp.aliyun-inc.com;
          Wed, 27 Mar 2024 15:16:12 +0800
Message-ID: <1711523698.8996527-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v5 00/10] virtio: drivers maintain dma info for premapped vq
Date: Wed, 27 Mar 2024 15:14:58 +0800
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
In-Reply-To: <CACGkMEtEWCjb8+Zcfizij2+0ef-wb8YJD2bfyAvP_72hKZrGvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 26 Mar 2024 14:35:21 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Mar 25, 2024 at 4:54=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > As discussed:
> >
> > http://lore.kernel.org/all/CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVmJ3rH=
YqRZxYg@mail.gmail.com
> >
> > If the virtio is premapped mode, the driver should manage the dma info =
by self.
> > So the virtio core should not store the dma info. We can release the me=
mory used
> > to store the dma info.
> >
> > For virtio-net xmit queue, if the virtio-net maintains the dma info,
> > the virtio-net must allocate too much memory(19 * queue_size for per-qu=
eue), so
> > we do not plan to make the virtio-net to maintain the dma info by defau=
lt. The
> > virtio-net xmit queue only maintain the dma info when premapped mode is=
 enable
> > (such as AF_XDP is enable).
> >
> > So this patch set try to do:
> >
> > 1. make the virtio core to do not store the dma info when driver can do=
 that
> >     - But if the desc_extra has not dma info, we face a new question,
> >       it is hard to get the dma info of the desc with indirect flag.
> >       For split mode, that is easy from desc, but for the packed mode,
> >       it is hard to get the dma info from the desc. And hardening
> >       the dma unmap is safe, we should store the dma info of indirect
> >       descs when the virtio core does not store the bufer dma info.
> >
> >       The follow patches to this:
> >          * virtio_ring: packed: structure the indirect desc table
> >          * virtio_ring: split: structure the indirect desc table
> >
> >     - On the other side, in the umap handle, we mix the indirect descs =
with
> >       other descs. That make things too complex. I found if we we disti=
nguish
> >       the descs with VRING_DESC_F_INDIRECT before unmap, thing will be =
clearer.
> >
> >       The follow patches do this.
> >          * virtio_ring: packed: remove double check of the unmap ops
> >          * virtio_ring: split: structure the indirect desc table
> >
> > 2. make the virtio core to enable premapped mode by find_vqs() params
> >     - Because the find_vqs() will try to allocate memory for the dma in=
fo.
> >       If we set the premapped mode after find_vqs() and release the
> >       dma info, that is odd.
> >
> >
> > Please review.
> >
> > Thanks
>
> This doesn't apply cleany on vhost.git linux-next branch.
>
> Which tree is this based on?


Sorry. That is on the top of "[PATCH vhost v5 0/6] refactor the params of
find_vqs()".

Lore-URL: http://lore.kernel.org/all/20240325090419.33677-1-xuanzhuo@linux.=
alibaba.com

Thanks.

>
> Thanks
>

