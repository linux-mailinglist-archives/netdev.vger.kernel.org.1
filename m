Return-Path: <netdev+bounces-101659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 836F88FFC30
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 08:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75DBB1C20B6C
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 06:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566FE14F118;
	Fri,  7 Jun 2024 06:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRoo7kY6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C141CABF
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 06:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717741375; cv=none; b=RP3h70f9bWJI9qfrtg5EUPtxGAARzgpS1t6cdV5nB01bxyI+F+3yBe61tLj22ZYh+BRyCTa80mDr4H+Qy0vNJXyVVY32pBEYiV99ZXe96VRAJs6zm0CVJY0Yp4bCRMTvfwTs/ggLvnnX5kIWnak2bcqSaKz4WagGWrXITqByWuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717741375; c=relaxed/simple;
	bh=LKuBQ28/1yz/CT83kCvNLcsL4DfCoTKrprm3yfzJhlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gH0B9DWC3NYeMo8zR9ufJHsc2R3a4SQdbHjh7nKBQS30+fYH3hMCi1+yOikJ0udrlp26aI5Rab4gH8QDTE1vWTfHAfm+is0rfMx/OekHnA082KGvFKF+EVkAHa3lAJxuVPPMg1QiL4jV+b/YMzKJZnmf2FGboNShvmU8QilvnKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CRoo7kY6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717741372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8BpY/LvUhfACDsxU4VlJjRaAtdugouYaei4Fra/b/gc=;
	b=CRoo7kY6GOLthQfLMzqLWVBq0XxaOdCHfIgNfa3ahAks+lCRp4Y1s7go1EHMhgPXaqZnVw
	oSfWTl79Cjm4fSDxXk9mBLr3E4v53PW1roSQyXcjE9QdIYoO/kOpvOgM6pk5EudTkJS27i
	PYrTuvXz8CZWaJShQ5+YPq2kmmv/NYA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-LKk5DmUsNv-hE-pG1GBa2g-1; Fri, 07 Jun 2024 02:22:45 -0400
X-MC-Unique: LKk5DmUsNv-hE-pG1GBa2g-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c2c330704aso250779a91.2
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 23:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717741364; x=1718346164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BpY/LvUhfACDsxU4VlJjRaAtdugouYaei4Fra/b/gc=;
        b=HN3voyOWFLmXln6JgwMZBhPHPuI9WotKcMctGWFKCpvsYT4BTu8o9F8QWyffK8fKI7
         qlV2iYYwaf2kVe8VIwlmvHBfoqs52UBfdnkSq+e+rJ8etqNhnO+Y8k74o72h18oX0yO4
         AjAyt8ZrXmQLYfEBStFAZepZJT0hIfe9ALyAEvkzQDkdBsXZf8FXgq4N9Rhfx1B1SNum
         d04+cphU8YVsKcv941eYhR+w4P7JmuJzQRWj12fm98tkWF8kGCI6xBCh57jTgQryj9tB
         W06ipXlxo+hpr8JS7KYUsayNpmjLXuury0kf6BAytpx/Vj80TM26eM7tCmFwnBhEHL9j
         ecWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc/yS8FSO6RuUbgIjuR1+1+ovYmSg/FzbFFc4E5w7FPUGSfnHC3Xe1rvjyleG3DuIu9ESI9b3V5AVrAsdxX292WNFP3S4J
X-Gm-Message-State: AOJu0YycLsga8PQ4ksmwUewX0A+73JW89UoAdxyG4RRJdH/1h8vvfjrs
	GCQUhzVl7SpVyZ57rNX02rzlpUxMRF089mJ0FMN/gcRMlyIe3DOf72F6/r9XZEN6sWk3ctw8fnX
	US9KslF//jMpqP6/jhi479ydxeQE/hcKOl653Bwl8Y1hvKIQZYVd9RgRc7eBThk6dPPj36puQ19
	fkR2PWz35kS9eWgX89XGElKu8rIWrn
X-Received: by 2002:a17:90a:34c9:b0:2c2:c65f:2061 with SMTP id 98e67ed59e1d1-2c2c65f22femr416851a91.31.1717741363968;
        Thu, 06 Jun 2024 23:22:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyBZS5h+R8JA9Tc22RmwY8UoPLjde+OK53I9oajlQ717pQ3ervU6OuHFyTP+CRXM9T7JkR3n43g0OFCRYv8dw=
X-Received: by 2002:a17:90a:34c9:b0:2c2:c65f:2061 with SMTP id
 98e67ed59e1d1-2c2c65f22femr416835a91.31.1717741363472; Thu, 06 Jun 2024
 23:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509114615.317450-1-jiri@resnulli.us> <1715325076.4219763-2-hengqi@linux.alibaba.com>
 <ZktGj4nDU4X0Lxtx@nanopsycho.orion> <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
 <1717587768.1588957-5-hengqi@linux.alibaba.com> <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com> <ZmG8eMl3E4GvGl2b@nanopsycho.orion>
In-Reply-To: <ZmG8eMl3E4GvGl2b@nanopsycho.orion>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 7 Jun 2024 14:22:31 +0800
Message-ID: <CACGkMEv1+ZSPiy5w1SN=a73-XCwCR6vE35LWNpqhaVAom71afQ@mail.gmail.com>
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jason Xing <kerneljasonxing@gmail.com>, Heng Qi <hengqi@linux.alibaba.com>, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 9:41=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Thu, Jun 06, 2024 at 06:25:15AM CEST, jasowang@redhat.com wrote:
> >On Thu, Jun 6, 2024 at 10:59=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >>
> >> Hello Jason,
> >>
> >> On Thu, Jun 6, 2024 at 8:21=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> >> >
> >> > On Wed, Jun 5, 2024 at 7:51=E2=80=AFPM Heng Qi <hengqi@linux.alibaba=
.com> wrote:
> >> > >
> >> > > On Wed, 5 Jun 2024 13:30:51 +0200, Jiri Pirko <jiri@resnulli.us> w=
rote:
> >> > > > Mon, May 20, 2024 at 02:48:15PM CEST, jiri@resnulli.us wrote:
> >> > > > >Fri, May 10, 2024 at 09:11:16AM CEST, hengqi@linux.alibaba.com =
wrote:
> >> > > > >>On Thu,  9 May 2024 13:46:15 +0200, Jiri Pirko <jiri@resnulli.=
us> wrote:
> >> > > > >>> From: Jiri Pirko <jiri@nvidia.com>
> >> > > > >>>
> >> > > > >>> Add support for Byte Queue Limits (BQL).
> >> > > > >>
> >> > > > >>Historically both Jason and Michael have attempted to support =
BQL
> >> > > > >>for virtio-net, for example:
> >> > > > >>
> >> > > > >>https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521=
e1bc3@redhat.com/
> >> > > > >>
> >> > > > >>These discussions focus primarily on:
> >> > > > >>
> >> > > > >>1. BQL is based on napi tx. Therefore, the transfer of statist=
ical information
> >> > > > >>needs to rely on the judgment of use_napi. When the napi mode =
is switched to
> >> > > > >>orphan, some statistical information will be lost, resulting i=
n temporary
> >> > > > >>inaccuracy in BQL.
> >> > > > >>
> >> > > > >>2. If tx dim is supported, orphan mode may be removed and tx i=
rq will be more
> >> > > > >>reasonable. This provides good support for BQL.
> >> > > > >
> >> > > > >But when the device does not support dim, the orphan mode is st=
ill
> >> > > > >needed, isn't it?
> >> > > >
> >> > > > Heng, is my assuption correct here? Thanks!
> >> > > >
> >> > >
> >> > > Maybe, according to our cloud data, napi_tx=3Don works better than=
 orphan mode in
> >> > > most scenarios. Although orphan mode performs better in specific b=
enckmark,
> >> >
> >> > For example pktgen (I meant even if the orphan mode can break pktgen=
,
> >> > it can finish when there's a new packet that needs to be sent after
> >> > pktgen is completed).
> >> >
> >> > > perf of napi_tx can be enhanced through tx dim. Then, there is no =
reason not to
> >> > > support dim for devices that want the best performance.
> >> >
> >> > Ideally, if we can drop orphan mode, everything would be simplified.
> >>
> >> Please please don't do this. Orphan mode still has its merits. In some
> >> cases which can hardly be reproduced in production, we still choose to
> >> turn off the napi_tx mode because the delay of freeing a skb could
> >> cause lower performance in the tx path,
> >
> >Well, it's probably just a side effect and it depends on how to define
> >performance here.
> >
> >> which is, I know, surely
> >> designed on purpose.
> >
> >I don't think so and no modern NIC uses that. It breaks a lot of things.
> >
> >>
> >> If the codes of orphan mode don't have an impact when you enable
> >> napi_tx mode, please keep it if you can.
> >
> >For example, it complicates BQL implementation.
>
> Well, bql could be disabled when napi is not used. It is just a matter
> of one "if" in the xmit path.

Maybe, care to post a patch?

The trick part is, a skb is queued when BQL is enabled but sent when
BQL is disabled as discussed here:

https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.=
com/

Thanks

>
>
> >
> >Thanks
> >
> >>
> >> Thank you.
> >>
> >
>


