Return-Path: <netdev+bounces-139937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AB19B4B93
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A0F1F23CE2
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 13:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738FA206E77;
	Tue, 29 Oct 2024 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTBc4hu5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B2A206962
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730210323; cv=none; b=kdgk0s98lg5dJaFVbat4hkJXKYdNtZqczz+UB2/rjw8nXHNMBHPnyQgq+Fma6c5iafNknaaZc/i0Q4Dv8P+s2wlUUFkYpKyZrIiU93aTCQQ921BoCanWecPY1wOIQCyhGtH+055cY9lMk5GlP2CWIDs1/0HvhxjJ2SXrhN0d4+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730210323; c=relaxed/simple;
	bh=x2jNO/kTA0H/Vj2uIn8nBbf6CkfW1gy043bvjGQVrwU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RPWhNRCyXAvWXYpgfAiQaHI72pYSFRSbTEDFealuD/dJEs+yL5cUVNWeg8zYqj87dDFRHBEUx6BN7Yj4IOJ7ob6oN549zc1HQNv7e9waKZkfAm5e3fO6uewWC1xWJfK6IrUjQsUwQg6RPuoxH2gyEzshkUCGpsSJ3SirsZOcRkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jTBc4hu5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730210320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G1jV1/Yzm8C7w0dHBYs7ihPXUdLAMbLSEy37RaAfnIE=;
	b=jTBc4hu5RKNV1jvvqd4EymrbI7GY9i577w7WmB5QiY/WhQC6fYxcZK4Uo9/WWMMze0Aeag
	cOQgyIB2NcFx+atXlMfqEcOmVRYBhreVZ1EZpB91i0HlFTFpCDTPKn5eoEAsGBj++5hTJU
	SSpesqLxSTYQBaDUOVZ5etgUdKHPr44=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-CjUejjskOqOW_jIofdewYQ-1; Tue, 29 Oct 2024 09:58:36 -0400
X-MC-Unique: CjUejjskOqOW_jIofdewYQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315ad4938fso39114825e9.0
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 06:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730210315; x=1730815115;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1jV1/Yzm8C7w0dHBYs7ihPXUdLAMbLSEy37RaAfnIE=;
        b=GCQOWmksyPB8w+egrCitDZ/glEVtAl3K+ahFUlPuLCHWEVTshFprmYIesRj1wiw81S
         Q4Aq9VZvuh1fGuO1lbryzdhSJJoyIEBkmUiMGNHso/dy2E2xhK249gQ52EuGGERB3QTC
         QKTXtvn8aLHyWY41pCOy2EZk2yF2pOkmJqkjK96oZu5TRAINGGN+9pw3oHkZqVfpT1RH
         kGc4zR6HoTOmE1EhxK/LbKcUzd13ALaqXZ+9Jmm9cLRtov7c7p04S0/oEKhpRJbuJ4Ns
         og3gFOfy1iogzGzqQh/vsBMyLkSpaRSZ/ziflCHuPze6F4kEfNdde8yPkzrF2X6JMaIF
         knEw==
X-Forwarded-Encrypted: i=1; AJvYcCUrZaLxX2xsK3q4qptlfKAm4ubtfOIcBhd5rHt8b6b2h2nHK+1uktq8jxgWdttOcWILc5bgLyI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx0MsPd+mab18nyETB33VLniNQwjCjR9C0xwBazIu9TxhjCcH5
	Vfsgy5tcuA1X5Rapa6iQpo7uiiHSa2KqIN7fjEEgu7FChDTtM6UYZ0VUqOfHUZHoJmhc3HvoCY8
	fxBK+Uf3TWBPQZ3OLNCimQKKXqUh9PAPI0+FCducTL5m5KCg4e1LdiQ==
X-Received: by 2002:a05:600c:4fcb:b0:425:7bbf:fd07 with SMTP id 5b1f17b1804b1-4319ac6fb93mr108811445e9.5.1730210314926;
        Tue, 29 Oct 2024 06:58:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmjNhzuq00pUPaKiJbsibQab44XUqMBzjhRGWk84vFKvwkmvCnitvIW369yK4nhBxXErWTvQ==
X-Received: by 2002:a05:600c:4fcb:b0:425:7bbf:fd07 with SMTP id 5b1f17b1804b1-4319ac6fb93mr108811095e9.5.1730210314561;
        Tue, 29 Oct 2024 06:58:34 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b567e18sm173445365e9.26.2024.10.29.06.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 06:58:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1A9D9164B204; Tue, 29 Oct 2024 14:58:33 +0100 (CET)
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
In-Reply-To: <cf1911c5-622f-484c-9ee5-11e1ac83da24@huawei.com>
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
 <20241022032214.3915232-4-linyunsheng@huawei.com>
 <dbd7dca7-d144-4a0f-9261-e8373be6f8a1@kernel.org>
 <113c9835-f170-46cf-92ba-df4ca5dfab3d@huawei.com> <878qudftsn.fsf@toke.dk>
 <d8e0895b-dd37-44bf-ba19-75c93605fc5e@huawei.com> <87r084e8lc.fsf@toke.dk>
 <cf1911c5-622f-484c-9ee5-11e1ac83da24@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 29 Oct 2024 14:58:33 +0100
Message-ID: <878qu7c8om.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yunsheng Lin <linyunsheng@huawei.com> writes:

>>> I would prefer the waiting too if simple waiting fixed the test cases that
>>> Youglong and Haiqing were reporting and I did not look into the rabbit hole
>>> of possible caching in networking.
>>>
>>> As mentioned in commit log and [1]:
>>> 1. ipv4 packet defragmentation timeout: this seems to cause delay up to 30
>>>    secs, which was reported by Haiqing.
>>> 2. skb_defer_free_flush(): this may cause infinite delay if there is no
>>>    triggering for net_rx_action(), which was reported by Yonglong.
>>>
>>> For case 1, is it really ok to stall the driver unbound up to 30 secs for the
>>> default setting of defragmentation timeout?
>>>
>>> For case 2, it is possible to add timeout for those kind of caching like the
>>> defragmentation timeout too, but as mentioned in [2], it seems to be a normal
>>> thing for this kind of caching in networking:
>> 
>> Both 1 and 2 seem to be cases where the netdev teardown code can just
>> make sure to kick the respective queues and make sure there's nothing
>> outstanding (for (1), walk the defrag cache and clear out anything
>> related to the netdev going away, for (2) make sure to kick
>> net_rx_action() as part of the teardown).
>
> It would be good to be more specific about the 'kick' here, does it mean
> taking the lock and doing one of below action for each cache instance?
> 1. flush all the cache of each cache instance.
> 2. scan for the page_pool owned page and do the finegrained flushing.

Depends on the context. The page pool is attached to a device, so it
should be possible to walk the skb frags queue and just remove any skbs
that refer to that netdevice, or something like that.

As for the lack of net_rx_action(), this is related to the deferred
freeing of skbs, so it seems like just calling skb_defer_free_flush() on
teardown could be an option.

>>> "Eric pointed out/predicted there's no guarantee that applications will
>>> read / close their sockets so a page pool page may be stuck in a socket
>>> (but not leaked) forever."
>> 
>> As for this one, I would put that in the "well, let's see if this
>> becomes a problem in practice" bucket.
>
> As the commit log in [2], it seems it is already happening.
>
> Those cache are mostly per-cpu and per-socket, and there may be hundreds of
> CPUs and thousands of sockets in one system, are you really sure we need
> to take the lock of each cache instance, which may be thousands of them,
> and do the flushing/scaning of memory used in networking, which may be as
> large as '24 GiB' mentioned by Jesper?

Well, as above, the two issues you mentioned are per-netns (or possibly
per-CPU), so those seem to be manageable to do on device teardown if the
wait is really a problem.

But, well, I'm not sure it is? You seem to be taking it as axiomatic
that the wait in itself is bad. Why? It's just a bit memory being held
on to while it is still in use, and so what?

-Toke


