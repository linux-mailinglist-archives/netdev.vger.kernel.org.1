Return-Path: <netdev+bounces-101663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F91B8FFC57
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 08:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1CF1F28210
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 06:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4346A15279C;
	Fri,  7 Jun 2024 06:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkNa8gwT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A73152791
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 06:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742405; cv=none; b=Y5gBUp5LRbHgN3DwGiazRyvJ8R6YQN2Y1OMuzD7coL5+yQT7YBe5shEIq7gz7aGlnEg0U/d7LqPPWfX6Qz/3kIxo1gHVZelSan1Rh7FN1PyY+xTHqWaurOoOSWEbXBVpK2pi5ttDlhfEHIO2RatiBBh3IHw25XMVqKwJ5Y6nlT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742405; c=relaxed/simple;
	bh=AKCGweRURmDBUnQOXI2rqeJMFl+907yXROT9IJrV0+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mxyp5zUilz9YQ4SahUE1S9mf9ubn8p81tCqrEPZa/vRHPIQ+YNBMRvbFVkzickxXr0VMmZPy9y3K1dmBz1hpJ6Wj84eonqhnL8vMfvd2JfPpnoEPUHxQUhzNjW03+SQ3zpCJi7QvAK5o8PXq7Yhwv2Jo35bEaSqKzqgbxFauofA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OkNa8gwT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717742402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kQmpBmdVffr5jwW6Krv4yv1UP5UH4NOMMf579PC1cCA=;
	b=OkNa8gwTj7j1wzfjo77LIRPKRv04jLMgxoEeW87EbhVQgC3189/FyHnZgbUBbUBHLoe7N6
	B+2ktfL0xOksZJd8OwwuSrIB32HLNs0p7ebnsQXjlYFj53oBCHZtwMxeZ6yaCsWPoa1vBJ
	qWugE2a3bmB3VLyX/mGEqzrzbwIuUTo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-66CanF-9PaW9SKicrQAAHg-1; Fri, 07 Jun 2024 02:40:00 -0400
X-MC-Unique: 66CanF-9PaW9SKicrQAAHg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-57a33a589b3so832701a12.0
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 23:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717742399; x=1718347199;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQmpBmdVffr5jwW6Krv4yv1UP5UH4NOMMf579PC1cCA=;
        b=Sk8nX4N3ZQP2KQ5oa+LOrhCgozi2b9KM5KkpH37JatChWxEvBAaiIHvssiGNEH7VS3
         S3IVHa8htLIdFh+e/koDNh6BEn+f9psxSARyY7DQweLPrhXT5Slw2tNAYjLW9/PaWQ9H
         4gXyCkSzYjfxIufBQoVS8m8Hs6y4PU7E0nIl3Jiuh+/Z4qpeIpzlX/Ulwv5YQyJWvWBI
         vjQvIuomqw25iSqj7OVQHGpeniUwoqOFyVxaGedNBaVkv8Seslr32JEAYpq9IgGa4kdJ
         XZjCdp3jxgdiGfd+m8SUa/XwoCD8qw16ZmH9aj1JpueroqaTHOqsqMmLt1ucYrID3ewL
         flmg==
X-Forwarded-Encrypted: i=1; AJvYcCXcxs+X1ZYYV7NGcNqmGEPKihMkX0Z3/OL6VuBDYLJ99+uKY421J4iiR754YjOKE/mFFS6cMj2xSIPgOZ9lSplGqEEEvl3u
X-Gm-Message-State: AOJu0YzepUc3sKbf4GGiTEOVlm0f3N7ovfa+LFHCsHbVfFFDuXiGKNh4
	NELHhpbjHswIzO1Xhy9rt0OIgYHe8UAzXV71F3uC/hN5Ycflf9Ndl0UMQlvD4I7UjpeWUPKX/QA
	tpvznz2G5foJ9jkv3yOXP4UB1yfy9Ah/rFMxSKF4FVC7yvuOhD3eKsQ==
X-Received: by 2002:a50:ab1b:0:b0:57c:5764:15e7 with SMTP id 4fb4d7f45d1cf-57c576416ccmr457007a12.36.1717742399196;
        Thu, 06 Jun 2024 23:39:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG44KNJ431HoiCfVrtYoo/wgg6mAw+TVADuXjxD8XLlagNU3bOR05lU/dyZo7uSOdTJ1xqFXg==
X-Received: by 2002:a50:ab1b:0:b0:57c:5764:15e7 with SMTP id 4fb4d7f45d1cf-57c576416ccmr456990a12.36.1717742398612;
        Thu, 06 Jun 2024 23:39:58 -0700 (PDT)
Received: from redhat.com ([2.55.8.167])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9d064sm2230021a12.10.2024.06.06.23.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 23:39:57 -0700 (PDT)
Date: Fri, 7 Jun 2024 02:39:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Xing <kerneljasonxing@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240607023358-mutt-send-email-mst@kernel.org>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <1715325076.4219763-2-hengqi@linux.alibaba.com>
 <ZktGj4nDU4X0Lxtx@nanopsycho.orion>
 <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
 <1717587768.1588957-5-hengqi@linux.alibaba.com>
 <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
 <ZmG8eMl3E4GvGl2b@nanopsycho.orion>
 <CACGkMEv1+ZSPiy5w1SN=a73-XCwCR6vE35LWNpqhaVAom71afQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEv1+ZSPiy5w1SN=a73-XCwCR6vE35LWNpqhaVAom71afQ@mail.gmail.com>

On Fri, Jun 07, 2024 at 02:22:31PM +0800, Jason Wang wrote:
> On Thu, Jun 6, 2024 at 9:41 PM Jiri Pirko <jiri@resnulli.us> wrote:
> >
> > Thu, Jun 06, 2024 at 06:25:15AM CEST, jasowang@redhat.com wrote:
> > >On Thu, Jun 6, 2024 at 10:59 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
> > >>
> > >> Hello Jason,
> > >>
> > >> On Thu, Jun 6, 2024 at 8:21 AM Jason Wang <jasowang@redhat.com> wrote:
> > >> >
> > >> > On Wed, Jun 5, 2024 at 7:51 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
> > >> > >
> > >> > > On Wed, 5 Jun 2024 13:30:51 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
> > >> > > > Mon, May 20, 2024 at 02:48:15PM CEST, jiri@resnulli.us wrote:
> > >> > > > >Fri, May 10, 2024 at 09:11:16AM CEST, hengqi@linux.alibaba.com wrote:
> > >> > > > >>On Thu,  9 May 2024 13:46:15 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
> > >> > > > >>> From: Jiri Pirko <jiri@nvidia.com>
> > >> > > > >>>
> > >> > > > >>> Add support for Byte Queue Limits (BQL).
> > >> > > > >>
> > >> > > > >>Historically both Jason and Michael have attempted to support BQL
> > >> > > > >>for virtio-net, for example:
> > >> > > > >>
> > >> > > > >>https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
> > >> > > > >>
> > >> > > > >>These discussions focus primarily on:
> > >> > > > >>
> > >> > > > >>1. BQL is based on napi tx. Therefore, the transfer of statistical information
> > >> > > > >>needs to rely on the judgment of use_napi. When the napi mode is switched to
> > >> > > > >>orphan, some statistical information will be lost, resulting in temporary
> > >> > > > >>inaccuracy in BQL.
> > >> > > > >>
> > >> > > > >>2. If tx dim is supported, orphan mode may be removed and tx irq will be more
> > >> > > > >>reasonable. This provides good support for BQL.
> > >> > > > >
> > >> > > > >But when the device does not support dim, the orphan mode is still
> > >> > > > >needed, isn't it?
> > >> > > >
> > >> > > > Heng, is my assuption correct here? Thanks!
> > >> > > >
> > >> > >
> > >> > > Maybe, according to our cloud data, napi_tx=on works better than orphan mode in
> > >> > > most scenarios. Although orphan mode performs better in specific benckmark,
> > >> >
> > >> > For example pktgen (I meant even if the orphan mode can break pktgen,
> > >> > it can finish when there's a new packet that needs to be sent after
> > >> > pktgen is completed).
> > >> >
> > >> > > perf of napi_tx can be enhanced through tx dim. Then, there is no reason not to
> > >> > > support dim for devices that want the best performance.
> > >> >
> > >> > Ideally, if we can drop orphan mode, everything would be simplified.
> > >>
> > >> Please please don't do this. Orphan mode still has its merits. In some
> > >> cases which can hardly be reproduced in production, we still choose to
> > >> turn off the napi_tx mode because the delay of freeing a skb could
> > >> cause lower performance in the tx path,
> > >
> > >Well, it's probably just a side effect and it depends on how to define
> > >performance here.
> > >
> > >> which is, I know, surely
> > >> designed on purpose.
> > >
> > >I don't think so and no modern NIC uses that. It breaks a lot of things.
> > >
> > >>
> > >> If the codes of orphan mode don't have an impact when you enable
> > >> napi_tx mode, please keep it if you can.
> > >
> > >For example, it complicates BQL implementation.
> >
> > Well, bql could be disabled when napi is not used. It is just a matter
> > of one "if" in the xmit path.
> 
> Maybe, care to post a patch?
> 
> The trick part is, a skb is queued when BQL is enabled but sent when
> BQL is disabled as discussed here:
> 
> https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
> 
> Thanks

Yes of course. Or we can stick a dummy value in skb->destructor after we
orphan, maybe that's easier.


> >
> >
> > >
> > >Thanks
> > >
> > >>
> > >> Thank you.
> > >>
> > >
> >


