Return-Path: <netdev+bounces-64531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DAE8359EE
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 05:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240AB1C21330
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 04:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB121865;
	Mon, 22 Jan 2024 04:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1251C2E
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 04:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705896023; cv=none; b=L31egahU9y+xNDfaEivqilKolyoLdIRag09AYuDbSa3l8y7NeaIsJhS9227v7pVW4gyEq+aVmSJt/ges7wjOfEotPzv0PRgszdwURIitP5OwbOpa2A4lqCa0IkSXryA0ITkO+p7SL/XChHLpGpkcSHwSOazqIundh62t2/cNHe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705896023; c=relaxed/simple;
	bh=RfCaWemPxqhlPZ8heu498e3IkoMYZhqHxG5JY9rCOw8=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=tb02+1HtA6eBaRYwTDdA8BuAQyUvOBK5OrtU0ITG17CX0+mgh2ZyJ92AP+5l9A+jPR5fMcQen5CYO6M6Ub8fL8Kpl+8PotVMdhNvfWpVlZSFrfqoXIP+oH+CRnTQa7VmBukXNZMK8PL32BWZm3Ujv1ODNGYJ1i1J0wT9de03s2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W.0SWkz_1705896011;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.0SWkz_1705896011)
          by smtp.aliyun-inc.com;
          Mon, 22 Jan 2024 12:00:12 +0800
Message-ID: <1705895881.6990144-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/1] virtio_net: Add timeout handler to avoid kernel hang
Date: Mon, 22 Jan 2024 11:58:01 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
 Heng Qi <hengqi@linux.alibaba.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Zhu Yanjun <yanjun.zhu@intel.com>,
 mst@redhat.com,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 virtualization@lists.linux.dev,
 netdev@vger.kernel.org,
 Zhu Yanjun <yanjun.zhu@linux.dev>
References: <20240115012918.3081203-1-yanjun.zhu@intel.com>
 <ea230712e27af2c8d2d77d1087e45ecfa86abb31.camel@redhat.com>
 <667a9520-a53f-40a2-810a-6c1e45146589@linux.dev>
 <7dd89fc0-f31e-4f83-9c02-58ee67c2d436@linux.alibaba.com>
 <430b899c-aed4-419d-8ae8-544bb9bec5d9@lunn.ch>
 <64270652-8e0c-4db7-b245-b970d9588918@linux.dev>
 <CACGkMEs18hjxiZRDT5-+PMDHkLbEyiviafGiCWsAE6CGBrj+9g@mail.gmail.com>
In-Reply-To: <CACGkMEs18hjxiZRDT5-+PMDHkLbEyiviafGiCWsAE6CGBrj+9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 22 Jan 2024 11:14:30 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Jan 22, 2024 at 10:12=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux.dev=
> wrote:
> >
> >
> > =E5=9C=A8 2024/1/20 1:29, Andrew Lunn =E5=86=99=E9=81=93:
> > >>>>>        while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > >>>>> -           !virtqueue_is_broken(vi->cvq))
> > >>>>> +           !virtqueue_is_broken(vi->cvq)) {
> > >>>>> +        if (timeout)
> > >>>>> +            timeout--;
> > >>>> This is not really a timeout, just a loop counter. 200 iterations =
could
> > >>>> be a very short time on reasonable H/W. I guess this avoid the soft
> > >>>> lockup, but possibly (likely?) breaks the functionality when we ne=
ed to
> > >>>> loop for some non negligible time.
> > >>>>
> > >>>> I fear we need a more complex solution, as mentioned by Micheal in=
 the
> > >>>> thread you quoted.
> > >>> Got it. I also look forward to the more complex solution to this pr=
oblem.
> > >> Can we add a device capability (new feature bit) such as ctrq_wait_t=
imeout
> > >> to get a reasonable timeout=EF=BC=9F
> > > The usual solution to this is include/linux/iopoll.h. If you can sleep
> > > read_poll_timeout() otherwise read_poll_timeout_atomic().
> >
> > I read carefully the functions read_poll_timeout() and
> > read_poll_timeout_atomic(). The timeout is set by the caller of the 2
> > functions.
>
> FYI, in order to avoid a swtich of atomic or not, we need convert rx
> mode setting to workqueue first:
>
> https://www.mail-archive.com/virtualization@lists.linux-foundation.org/ms=
g60298.html
>
> >
> > As such, can we add a module parameter to customize this timeout value
> > by the user?
>
> Who is the "user" here, or how can the "user" know the value?
>
> >
> > Or this timeout value is stored in device register, virtio_net driver
> > will read this timeout value at initialization?
>
> See another thread. The design needs to be general, or you can post a RFC.
>
> In another thought, we've already had a tx watchdog, maybe we can have
> something similar to cvq and use timeout + reset in that case.

But we may block by the reset ^_^ if the device is broken?

Thanks.


>
> Thans
>
> >
> > Zhu Yanjun
> >
> > >
> > >       Andrew
> >
>

