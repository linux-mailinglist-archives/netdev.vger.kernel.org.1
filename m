Return-Path: <netdev+bounces-83692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A828936C4
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 03:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE171F2168C
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 01:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B66E623;
	Mon,  1 Apr 2024 01:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rye7xJfP"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28235EC2
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 01:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711935844; cv=none; b=FpmcZ/8jjxwRGoyDB7ahEbw4B5wjFnPUpivWJIoFOFB96ltj8SOR445ishhFi5MDPYCBUDr2KtGQgEgzNEsrXX1eRM4vsD47M4BGYnxKgnyyGlYvd7Cod80+8qnMZYao/RPT4Pn4r7MTeEuEmwCmoBxPIf1yBcYDpGr5Z4q8adw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711935844; c=relaxed/simple;
	bh=G1zsdzxNZSjo0YzlMUK20UPCUkx9TojW4k8K3GVcE/E=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=RdoPhC03V4dOkAqWGryLDLlqmIj/4g4eDbDWHVcQlAiL4njVg3BEsZCS3VgcrxEDqOBvby6XLrx6nxb+dxOVndc7VsNB2cI9gZk1p27O2Bn/xpE+A2LOcZtIeoOLzuKm1VU2DS2pX/2+K/2mhHd/eSNXNCpUxjFsWeiKMjMoyc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rye7xJfP; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711935833; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=G1zsdzxNZSjo0YzlMUK20UPCUkx9TojW4k8K3GVcE/E=;
	b=rye7xJfPSR4Dnckxt7DzpFMvXoZmOejoCKem9CigNJnzOy4t3AKEQstd5QdLUEhLtp+B8QjnHzwPD11PvNVdU81Whx3FJ3NCuFNDOeOXaP8jv7fAuJDdZhoofl+siuuDEgCRGwpZp+EcStMuTWJG0qiZpanoGHTsiX9wMXwKEYs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W3cmnlR_1711935832;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3cmnlR_1711935832)
          by smtp.aliyun-inc.com;
          Mon, 01 Apr 2024 09:43:53 +0800
Message-ID: <1711935607.4691076-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v6 09/10] virtio_net: set premapped mode by find_vqs()
Date: Mon, 1 Apr 2024 09:40:07 +0800
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
In-Reply-To: <CACGkMEuBhfMwrfaiburLG7gFw36GuVHSbRTtK+FycrGFVTgOcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 29 Mar 2024 11:20:08 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, Mar 28, 2024 at 4:27=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Thu, 28 Mar 2024 16:05:02 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > Now, the virtio core can set the premapped mode by find_vqs().
> > > > If the premapped can be enabled, the dma array will not be
> > > > allocated. So virtio-net use the api of find_vqs to enable the
> > > > premapped.
> > > >
> > > > Judge the premapped mode by the vq->premapped instead of saving
> > > > local variable.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > >
> > > I wonder what's the reason to keep a fallback when premapped is not e=
nabled?
> >
> > Rethink this.
> >
> > I think you are right. We can remove the fallback.
> >
> > Because we have the virtio dma apis that wrap all the cases.
> > So I will remove the fallback from the virtio-net in next version.
>
> Ok.
>
> >
> > But we still need to export the premapped to the drivers.
> > Because we can enable the AF_XDP only when premapped is true.
>
> I may miss something but it should work like
>
> enable AF_XDP -> enable remapping
>
> So can we fail during remapping enablement?


YES.

Enabling the premapped mode may fail, then we must stop to enable AF_XDP.

AF-XDP requires that we export the dma dev to the af-xdp.
We can do that only when the virtio core works with use_dma_api.
Other other side, if we support the page-pool in future, we may have the
same requirement.


Thanks.


>
> THanks
>
> >
> > Thanks
> >
> >
> > >
> > > Thanks
> > >
> >
>

