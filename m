Return-Path: <netdev+bounces-101393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E00108FE5F7
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 14:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE54288ADB
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 12:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B3314D29E;
	Thu,  6 Jun 2024 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFK7woP3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47028C153
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675265; cv=none; b=SxsU0FRAvuk22di408BxbU+lrZY4UyuyT6LMq4fDKMrTVp00NfqUe8/DrgIGncZsKn8HJ8H8Ta7JCKUr219eRx0pTuBrzvck5X5ZnblKCbiflwYqm8btR1foxSemL1RWxXiXgRcAYIVy5aD1NJpvNyh79pmewXyfEQazlR76470=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675265; c=relaxed/simple;
	bh=VE9LD88tG1B8qpR9VqW3jtsJJ1umFxLdZM4g0IpzOAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nym27WpeJKvYXKcoo0JB9B9bF+wtHEBDN8amf13Xs8mwGpNYXQsc0NbXjDbbgiaq3Qf+lIRie8nliXwW+JUYJ5C1rrhKgK6BU9XLZAOOBGTTYAN6uHodXl7xN5liEEJXlmNvJkeNbTpE1lG+38Jdj7Knr1a5N+zzyyYaf9SlIg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DFK7woP3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717675262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4S9PyIZ2WPPemiOD/j57hDL0LYoz1XGW158BpHw80Q=;
	b=DFK7woP39nLLH9iEevtgV1yu5IT9a5bktxCedokQdiXYpvb9FFn46EpWxpUeoegl4+R9EE
	2Kz0+q3Whprbe6ZE4gt82gMMhvAJjSvQ4JuQ4pjk1sVsMuNleWNfrXU819lZ6QKcqULCfN
	VSWqu72oKywTFCFDOvXiDK8ZaqVHPCY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-VsKjFbSJNdupf-rYd2b6Ng-1; Thu, 06 Jun 2024 08:01:00 -0400
X-MC-Unique: VsKjFbSJNdupf-rYd2b6Ng-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a68e85d466dso53055666b.1
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 05:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717675260; x=1718280060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4S9PyIZ2WPPemiOD/j57hDL0LYoz1XGW158BpHw80Q=;
        b=tEDM+gb9filHCwoFj6D8vS6uqi6wO0QunuKwoJBU80QppUYzZJpNiFCxF9BKTyHL5L
         0b129EqF6kU+SoGu7TffhxH2uwj0WFXrqpf5bavdpG11g9V+Q3uC5V1ELSYhq/hKsW93
         Dxj4/2Yi+gDJ49wsq815Z4yL0EvM1R6TM4bQwvpj0wSies+eR7AHUj/BoRzuTR+m+vLB
         b+LihqUvDXKiVvcJkIVBwbGLHDZuWo1x4YgYNpDI9RlCAG0ATUszDNHZZvHdVFBWycUq
         F1/66HvF/+1UJYOEroDoocLQKgd+rtV5U0GZEQqqU5FnOAJX5Bf6wtCvE+pJ0xuOg2qY
         UoKg==
X-Forwarded-Encrypted: i=1; AJvYcCVXUmB6FpqFm1aA2XE+UYi+OlDO4nBkWiG3qoq8eOQaWQh37QWFcV5kED0QgS6S4UgFCu200Vl7LeXjnOqCCU4HGbJIzxyy
X-Gm-Message-State: AOJu0Yy2ZkfWFxpHMDroWMIdCsQ/tr7h8PWQRnAR+V71XBuOULrJva64
	9ZT2B03v2GrJc+z0ClKR7Qg9LdNAmOSlUiG5B2CrY61rOlp4beE7HPnC6p4B1Pv6R2MUa1FTugk
	uru957eLSphMit2gpDtZ2KTokuLKCibuzBfGezeNdcIaWthIAlRcSKQ==
X-Received: by 2002:a50:c88a:0:b0:57a:321f:cc4f with SMTP id 4fb4d7f45d1cf-57a8b6f1b0emr3501157a12.19.1717675259564;
        Thu, 06 Jun 2024 05:00:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB7Vks4wFFWfi34BdrVfF+Y5s/7VwpN5xp0R8MpdVPxup8WU6P2hYMotoXBQEc2co8tC+S0Q==
X-Received: by 2002:a50:c88a:0:b0:57a:321f:cc4f with SMTP id 4fb4d7f45d1cf-57a8b6f1b0emr3501139a12.19.1717675258923;
        Thu, 06 Jun 2024 05:00:58 -0700 (PDT)
Received: from redhat.com ([2.55.8.167])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae202396sm973075a12.74.2024.06.06.05.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 05:00:53 -0700 (PDT)
Date: Thu, 6 Jun 2024 08:00:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>,
	Jiri Pirko <jiri@resnulli.us>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240606075842-mutt-send-email-mst@kernel.org>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <1715325076.4219763-2-hengqi@linux.alibaba.com>
 <ZktGj4nDU4X0Lxtx@nanopsycho.orion>
 <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
 <1717587768.1588957-5-hengqi@linux.alibaba.com>
 <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
 <CAL+tcoA3JpS3S6Hzwpc5F0dzm92AnfYfqj-4uLmTsgQ5hj1fTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoA3JpS3S6Hzwpc5F0dzm92AnfYfqj-4uLmTsgQ5hj1fTA@mail.gmail.com>

On Thu, Jun 06, 2024 at 07:42:35PM +0800, Jason Xing wrote:
> On Thu, Jun 6, 2024 at 12:25 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Thu, Jun 6, 2024 at 10:59 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
> > >
> > > Hello Jason,
> > >
> > > On Thu, Jun 6, 2024 at 8:21 AM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Wed, Jun 5, 2024 at 7:51 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
> > > > >
> > > > > On Wed, 5 Jun 2024 13:30:51 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
> > > > > > Mon, May 20, 2024 at 02:48:15PM CEST, jiri@resnulli.us wrote:
> > > > > > >Fri, May 10, 2024 at 09:11:16AM CEST, hengqi@linux.alibaba.com wrote:
> > > > > > >>On Thu,  9 May 2024 13:46:15 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
> > > > > > >>> From: Jiri Pirko <jiri@nvidia.com>
> > > > > > >>>
> > > > > > >>> Add support for Byte Queue Limits (BQL).
> > > > > > >>
> > > > > > >>Historically both Jason and Michael have attempted to support BQL
> > > > > > >>for virtio-net, for example:
> > > > > > >>
> > > > > > >>https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
> > > > > > >>
> > > > > > >>These discussions focus primarily on:
> > > > > > >>
> > > > > > >>1. BQL is based on napi tx. Therefore, the transfer of statistical information
> > > > > > >>needs to rely on the judgment of use_napi. When the napi mode is switched to
> > > > > > >>orphan, some statistical information will be lost, resulting in temporary
> > > > > > >>inaccuracy in BQL.
> > > > > > >>
> > > > > > >>2. If tx dim is supported, orphan mode may be removed and tx irq will be more
> > > > > > >>reasonable. This provides good support for BQL.
> > > > > > >
> > > > > > >But when the device does not support dim, the orphan mode is still
> > > > > > >needed, isn't it?
> > > > > >
> > > > > > Heng, is my assuption correct here? Thanks!
> > > > > >
> > > > >
> > > > > Maybe, according to our cloud data, napi_tx=on works better than orphan mode in
> > > > > most scenarios. Although orphan mode performs better in specific benckmark,
> > > >
> > > > For example pktgen (I meant even if the orphan mode can break pktgen,
> > > > it can finish when there's a new packet that needs to be sent after
> > > > pktgen is completed).
> > > >
> > > > > perf of napi_tx can be enhanced through tx dim. Then, there is no reason not to
> > > > > support dim for devices that want the best performance.
> > > >
> > > > Ideally, if we can drop orphan mode, everything would be simplified.
> > >
> > > Please please don't do this. Orphan mode still has its merits. In some
> > > cases which can hardly be reproduced in production, we still choose to
> > > turn off the napi_tx mode because the delay of freeing a skb could
> > > cause lower performance in the tx path,
> >
> > Well, it's probably just a side effect and it depends on how to define
> > performance here.
> 
> Yes.
> 
> >
> > > which is, I know, surely
> > > designed on purpose.
> >
> > I don't think so and no modern NIC uses that. It breaks a lot of things.
> 
> To avoid confusion, I meant napi_tx mode can delay/slow down the speed
> in the tx path and no modern nic uses skb_orphan().

Clearly it's been designed for software NICs and when the
cost of interrupts is very high.

> I think I will have some time to test BQL in virtio_net.
> 
> Thanks,
> Jason


