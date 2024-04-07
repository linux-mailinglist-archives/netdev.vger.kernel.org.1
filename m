Return-Path: <netdev+bounces-85479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF4489AEBF
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 08:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ED6BB22D3C
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 06:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF09184D;
	Sun,  7 Apr 2024 06:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qW7sHlqE"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A3E17F0
	for <netdev@vger.kernel.org>; Sun,  7 Apr 2024 06:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712469804; cv=none; b=N3xbwMcPMqg6H4NipgqfrzuK5GzilGVn0OsuTjeD+CWJhdzIfVQMtSYjC0tRvkMsrk9x/DQkiIUATNnvnpLO570nXgqd8BOH8T732mS2sBRhaJE706oFxpU60zPetzlWUvFCeCK5luRJtveSPalOq/1VeMnzlX68VvymjEKvx7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712469804; c=relaxed/simple;
	bh=dV7TKtHxf+IaIUw1dxawpCy/kf4dYptOrfI1cMpEC8g=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=IK5rOYC29yMu0UJlfOsEIsmD+PPgzfYccYcQpnBx7ccHNIORfadJOInDYiICAH/PRtvrNVXl9nzXaqHfZytgfi9brXB7WOh6ZzkEkXdd2hXE4puCOu6moIW0n0tOnPxKfDd9O9p7Ut7il7DnIu3ENPSZu202jaCWJTLIs3bkNP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qW7sHlqE; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712469794; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=dV7TKtHxf+IaIUw1dxawpCy/kf4dYptOrfI1cMpEC8g=;
	b=qW7sHlqENZQtY+ZyaV6OfUzplLg3NyUBRvHkE8/Lvbg4Bg5QbNs9RcUxfno2ZtuLSrKeXm+Tk0NeJf9dznmzFc61wxLEt5NvKrA5Ne6IiNZ908pQ2HyO74wge2Zu7YSZwUIjZU8QGAvr/Js7DeKJq3iGYeety3SMqV0lZW7fT0Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W4.LB8O_1712469793;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4.LB8O_1712469793)
          by smtp.aliyun-inc.com;
          Sun, 07 Apr 2024 14:03:13 +0800
Message-ID: <1712469641.4145665-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v6 09/10] virtio_net: set premapped mode by find_vqs()
Date: Sun, 7 Apr 2024 14:00:41 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com>
 <20240327111430.108787-10-xuanzhuo@linux.alibaba.com>
 <CACGkMEs=NZGkkA7ye0wY7YcPBPfbKkYq84KCRX1gS0e=bZDX-w@mail.gmail.com>
 <1711614157.5913072-7-xuanzhuo@linux.alibaba.com>
 <CACGkMEuBhfMwrfaiburLG7gFw36GuVHSbRTtK+FycrGFVTgOcA@mail.gmail.com>
 <1711935607.4691076-1-xuanzhuo@linux.alibaba.com>
 <1711940418.2573907-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEvPZKa-au=2XaXrjT4t1vpPF4mPRNYNZ6uTPNyUpT8dfA@mail.gmail.com>
In-Reply-To: <CACGkMEvPZKa-au=2XaXrjT4t1vpPF4mPRNYNZ6uTPNyUpT8dfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Sun, 7 Apr 2024 12:24:00 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Apr 1, 2024 at 11:10=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Mon, 1 Apr 2024 09:40:07 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
> > > On Fri, 29 Mar 2024 11:20:08 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Thu, Mar 28, 2024 at 4:27=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > On Thu, 28 Mar 2024 16:05:02 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@lin=
ux.alibaba.com> wrote:
> > > > > > >
> > > > > > > Now, the virtio core can set the premapped mode by find_vqs().
> > > > > > > If the premapped can be enabled, the dma array will not be
> > > > > > > allocated. So virtio-net use the api of find_vqs to enable the
> > > > > > > premapped.
> > > > > > >
> > > > > > > Judge the premapped mode by the vq->premapped instead of savi=
ng
> > > > > > > local variable.
> > > > > > >
> > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > ---
> > > > > >
> > > > > > I wonder what's the reason to keep a fallback when premapped is=
 not enabled?
> > > > >
> > > > > Rethink this.
> > > > >
> > > > > I think you are right. We can remove the fallback.
> > > > >
> > > > > Because we have the virtio dma apis that wrap all the cases.
> > > > > So I will remove the fallback from the virtio-net in next version.
> > > >
> > > > Ok.
> > > >
> > > > >
> > > > > But we still need to export the premapped to the drivers.
> > > > > Because we can enable the AF_XDP only when premapped is true.
> > > >
> > > > I may miss something but it should work like
> > > >
> > > > enable AF_XDP -> enable remapping
> > > >
> > > > So can we fail during remapping enablement?
> > >
> > >
> > > YES.
> > >
> > > Enabling the premapped mode may fail, then we must stop to enable AF_=
XDP.
> > >
> > > AF-XDP requires that we export the dma dev to the af-xdp.
> > > We can do that only when the virtio core works with use_dma_api.
> > > Other other side, if we support the page-pool in future, we may have =
the
> > > same requirement.
> >
> > Rethink this.
> >
> > Enable premapped MUST NOT fail. No care the use_dma_api is true or not,=
 because
> > we have the DMA APIs for virtio. Then the virtio-net rx will work with
> > premapped (I will make the big mode work with premapped mode)
>
> Just to make sure we're at the same page. Rx will always work in the
> mode or pre mapping. So we can easily fail the probe if we fail to
> enable RX premapping?


NO, enabling premapped mode can not fail. So the rx will always work
in the premapping mode.


>
> >
> > AF_XDP checks the virtqueue_dma_dev() when enabling.
> >
> > But disabling premapped mode may fail, because that virtio ring need to
> > allocate memory for dma.
>
> That's kind of too tricky, what if we just allocate the memory for dma
> unconditionally?

It's ok, but we waste the memory.

Thanks.



>
> Thanks
>
> >
> > Thanks.
> >
> >
> >
> > >
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > THanks
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > >
> > > >
> > >
> >
>

