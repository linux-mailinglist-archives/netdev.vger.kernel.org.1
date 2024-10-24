Return-Path: <netdev+bounces-138699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFEC9AE923
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A051F230CB
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAB11EF925;
	Thu, 24 Oct 2024 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zi4n8rIu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DD81EC01D
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780848; cv=none; b=GboLiCawppdaZq4zYYLKwPZCZZlYjVQ3EA6OzevZgm13KbReDUA0lFw37xaHztGxQMFLZuZdLcJ+Byqy5362SUJqn9gqf3bA/qI+y1VlsVcivsfOmIKsQyPmKxNPROTlgdZVj84uUEJFldJmPjFt/WZqSTKtETqu7gJx/Ii3HYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780848; c=relaxed/simple;
	bh=+CjMdzWLILQKd2T9F7nyB4WETCRS6M6pCeZeEmGLW54=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XPPjlWMGWA+6aDvmqq07RUZUHssmamuwiGv7KXN2bzozNgzxAX2Zb4ILr9lLQXQXLGwAxg5qdHueUMU7KuQ6hxGFKdyrInYRP6SIpcISnUhWwtbPusTEfwTqU0Fd3DVFLKFe+Vpi0os+E51uskEvDc4iVEE0M4F5NrWvirX4q1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zi4n8rIu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729780844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+CjMdzWLILQKd2T9F7nyB4WETCRS6M6pCeZeEmGLW54=;
	b=Zi4n8rIul7a4Ekl7q5eEHBGJvrx/Nm7RJ1qdB2Vnnx+upMOkU6oTKzlGbO9wot5NGE0WmG
	PpRYiGNbwrXCwhs4IgDPtR32OjHx03GIHXp06656e92fvnw020yIN7hyDOjkKKqHoNlAdo
	8UiOzdmTRep6sN6CJtT1UmB5y34BH8o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-3KivHT3XOGyVY5jMWphEOQ-1; Thu, 24 Oct 2024 10:40:43 -0400
X-MC-Unique: 3KivHT3XOGyVY5jMWphEOQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d4a211177so551924f8f.0
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 07:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729780842; x=1730385642;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CjMdzWLILQKd2T9F7nyB4WETCRS6M6pCeZeEmGLW54=;
        b=w54xMrCx9t7QWH2qMvaMoNG83m8aA9Lt5mbmP8YqED5b4JIUVkdv1sCXnTCu0H6u6h
         /xzxrmV7LH9KSQeU2IvUQkoSe8Mpmvnle2wIee/LiU+4bEyhbZtcTLObi54sqhnoUR5U
         Za3di27JkKvIvqnPzSE8MKifz8d14Gf4obl6EJag5p76Z5UxSAVgd2t4p5qpS8pefjzF
         evDmItob3eQjvpYrYv+Qcpm2mkBMoMKmZsVL/zq0tuUmJ5ohXjiWwaHRRFwFDZodtRMv
         yo5kp+8XinU13DLDBl9KqxrwmA+PrM4f/CwtTcC1WM2x7p27rQ4yzSdiL2G6AtITKEZZ
         hqcA==
X-Forwarded-Encrypted: i=1; AJvYcCWS3Lno+bdVBMbs6vrn9zMwq0Z/l+J9zdD5h/wSFF9qOuphOv7tAyi0NkQLPw1DQdQGGSFlmd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+4DVhc9s/Oe8wsuBOXt6lEvPxX3e9vrpWt9vDmOZRyZi/hvdm
	yQ1KVO7OfbR05fy7D8QmoXeURQNqGDxO3PRJGDY5sOGv2SgqLXoDAxk758DHjaYd04fKvp0sCbj
	zPODV1agGE8K1uChjNPKBFRNjM4sINU48B0JjtSafJdBzHUaQ6W8lKw==
X-Received: by 2002:adf:f850:0:b0:37d:50f8:a801 with SMTP id ffacd0b85a97d-380458ec65bmr1564905f8f.47.1729780842079;
        Thu, 24 Oct 2024 07:40:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHlCZfIV1vlnJ8aUV+taDRYgNoiomN86d8HqIw3XbXDwesM0GycuE5hSHY+Pb/gN5r8/Xadw==
X-Received: by 2002:adf:f850:0:b0:37d:50f8:a801 with SMTP id ffacd0b85a97d-380458ec65bmr1564881f8f.47.1729780841620;
        Thu, 24 Oct 2024 07:40:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94356sm11505321f8f.67.2024.10.24.07.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 07:40:41 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 41B6B160B4E3; Thu, 24 Oct 2024 16:40:40 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: zhangkun09@huawei.com, fanghaiqing@huawei.com, liuyonglong@huawei.com,
 Robin Murphy <robin.murphy@arm.com>, Alexander Duyck
 <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kernel-team
 <kernel-team@cloudflare.com>
Subject: Re: [PATCH net-next v3 3/3] page_pool: fix IOMMU crash when driver
 has already unbound
In-Reply-To: <113c9835-f170-46cf-92ba-df4ca5dfab3d@huawei.com>
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
 <20241022032214.3915232-4-linyunsheng@huawei.com>
 <dbd7dca7-d144-4a0f-9261-e8373be6f8a1@kernel.org>
 <113c9835-f170-46cf-92ba-df4ca5dfab3d@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 24 Oct 2024 16:40:40 +0200
Message-ID: <878qudftsn.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunsheng Lin <linyunsheng@huawei.com> writes:

> On 2024/10/23 2:14, Jesper Dangaard Brouer wrote:
>>=20
>>=20
>> On 22/10/2024 05.22, Yunsheng Lin wrote:
>>> Networking driver with page_pool support may hand over page
>>> still with dma mapping to network stack and try to reuse that
>>> page after network stack is done with it and passes it back
>>> to page_pool to avoid the penalty of dma mapping/unmapping.
>>> With all the caching in the network stack, some pages may be
>>> held in the network stack without returning to the page_pool
>>> soon enough, and with VF disable causing the driver unbound,
>>> the page_pool does not stop the driver from doing it's
>>> unbounding work, instead page_pool uses workqueue to check
>>> if there is some pages coming back from the network stack
>>> periodically, if there is any, it will do the dma unmmapping
>>> related cleanup work.
>>>
>>> As mentioned in [1], attempting DMA unmaps after the driver
>>> has already unbound may leak resources or at worst corrupt
>>> memory. Fundamentally, the page pool code cannot allow DMA
>>> mappings to outlive the driver they belong to.
>>>
>>> Currently it seems there are at least two cases that the page
>>> is not released fast enough causing dma unmmapping done after
>>> driver has already unbound:
>>> 1. ipv4 packet defragmentation timeout: this seems to cause
>>> =C2=A0=C2=A0=C2=A0 delay up to 30 secs.
>>> 2. skb_defer_free_flush(): this may cause infinite delay if
>>> =C2=A0=C2=A0=C2=A0 there is no triggering for net_rx_action().
>>>
>>> In order not to do the dma unmmapping after driver has already
>>> unbound and stall the unloading of the networking driver, add
>>> the pool->items array to record all the pages including the ones
>>> which are handed over to network stack, so the page_pool can
>>=20
>> I really really dislike this approach!
>>=20
>> Nacked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>=20
>> Having to keep an array to record all the pages including the ones
>> which are handed over to network stack, goes against the very principle
>> behind page_pool. We added members to struct page, such that pages could
>> be "outstanding".
>
> Before and after this patch both support "outstanding", the difference is
> how many "outstanding" pages do they support.
>
> The question seems to be do we really need unlimited inflight page for
> page_pool to work as mentioned in [1]?
>
> 1. https://lore.kernel.org/all/5d9ea7bd-67bb-4a9d-a120-c8f290c31a47@huawe=
i.com/

Well, yes? Imposing an arbitrary limit on the number of in-flight
packets (especially such a low one as in this series) is a complete
non-starter. Servers have hundreds of gigs of memory these days, and if
someone wants to use that for storing in-flight packets, the kernel
definitely shouldn't impose some (hard-coded!) limit on that.

>>=20
>> The page_pool already have a system for waiting for these outstanding /
>> inflight packets to get returned.=C2=A0 As I suggested before, the page_=
pool
>> should simply take over the responsability (from net_device) to free the
>> struct device (after inflight reach zero), where AFAIK the DMA device is
>> connected via.
>
> It seems you mentioned some similar suggestion in previous version,
> it would be good to show some code about the idea in your mind, I am sure
> that Yonglong Liu Cc'ed will be happy to test it if there some code like
> POC/RFC is provided.

I believe Jesper is basically referring to Jakub's RFC that you
mentioned below.

> I should mention that it seems that DMA device is not longer vaild when
> remove() function of the device driver returns, as mentioned in [2], which
> means dma API is not allowed to called after remove() function of the dev=
ice
> driver returns.
>
> 2. https://www.spinics.net/lists/netdev/msg1030641.html
>
>>=20
>> The alternative is what Kuba suggested (and proposed an RFC for),=C2=A0 =
that
>> the net_device teardown waits for the page_pool inflight packets.
>
> As above, the question is how long does the waiting take here?
> Yonglong tested Kuba's RFC, see [3], the waiting took forever due to
> reason as mentioned in commit log:
> "skb_defer_free_flush(): this may cause infinite delay if there is no
> triggering for net_rx_action()."

Honestly, this just seems like a bug (the "no triggering of
net_rx_action()") that should be root caused and fixed; not a reason
that waiting can't work.

-Toke


