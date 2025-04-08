Return-Path: <netdev+bounces-180106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5A3A7F977
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA5B07A8CD8
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42CA264FAC;
	Tue,  8 Apr 2025 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjFf/ewd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A9A264F9F
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744104542; cv=none; b=BUBzlpZnD2qkNl4lnwJGscC3MZqbYqwQHkzdYUOQJ4YhurDZ1GkFCg5GAEKM0odjtajMHQuBMxFG5/9l4YwUVn2Yxum/EHiz/6gFNIeAYDjVRs02mC/oNsVHyR82aB0EpUU6cTWuW1HddGj75VfWUcFpWq2gFDlfzHZNv8foInc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744104542; c=relaxed/simple;
	bh=6GXjoR9+j3K5oqC5DbXewEtoWag0AaWHJyjmg134Js8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZU+K9HWGH1sujrdxpEeAyg/FajzIJJT/U2nhjkCrUy7/2d7LSc6Qlx0Fp7+3vbc2S9d0J3gF47mxzu0ElK29F9zKfBGuPNnGYYDYUOYXbzihkP14LboUMJU4LR0D5grFVy9l3P4EYVCOHk2wUHpGSuKUUELGkABdDXnQGtyp0Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AjFf/ewd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744104539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5kFJkKUSX4bPqKPH1LRnxjH0+XkR8hOBduchqaJy8g8=;
	b=AjFf/ewdlHHT0pmbgyMqtX2TkSZVxkm1qzBrWkeTmYiNcYF0gD0pvOp3tbR8L0mDkUbFn4
	3R4HtoMxPzpNSkRWByoOgVivYK8rbSZNgf7CMPFFTbyywp59JScdM1fFBW6quxCjjg/YWc
	H2HQqTs3Ctwhc38C4pdqBuYg8QTMNAk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-DRELgfFoO3GWgMb9qvkEIg-1; Tue, 08 Apr 2025 05:28:58 -0400
X-MC-Unique: DRELgfFoO3GWgMb9qvkEIg-1
X-Mimecast-MFC-AGG-ID: DRELgfFoO3GWgMb9qvkEIg_1744104537
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso26565215e9.0
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 02:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744104537; x=1744709337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5kFJkKUSX4bPqKPH1LRnxjH0+XkR8hOBduchqaJy8g8=;
        b=MgNn0D5ocSUbFqDNx+uTAuv7Ii9OZf80lDY1apeU8e666FxCnYxUUxIUmXaNX388Or
         eX99SrgjZG4eyMdgHHqfjCsLuYS1YJGdpu7c1G43S3Bl8YWEBaQrs+INtFDPNLokf1k0
         izvmagB3UMvoYN5Po5WhyLMmG72up1I10uB25Ny6UDB+WY/VnCa//kt1gyiWhajxm2Fw
         TSH1yzjppym4M/8F7NAVXUckD+rGnUvCr+SIAX6t5K+4W9em3fc+tuphteipDAeBY20/
         EXSQLRn1sGdoT94QhD+Ffw6xF8Vu1jLejivSsUfFsLU27wyR07QQV+6p6+4eLxLmnVLt
         w++w==
X-Forwarded-Encrypted: i=1; AJvYcCUXrtWaiNldPUcuyJbLmFLI1tii+4zX3j04KmVMwHUUsC4No5uYFHxKJ2ICb4ggbOxij1jPkHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvIodf+sYEdGuMlRG/NaVOu1w6h0iaSnkwXeo/5YWgY17aG1ez
	hapGzpVxWkyoOxfr3e86Lbq27rGItQ/7q50TpPOdlHHSPYkb/zZ6+J2tqVKEJW4wv0APyjp4XVR
	3g8UP8vAlMzfBTK/GM5TEzeaTe90rTu0h1VzMQy/UBSCyDVgCBd/psg==
X-Gm-Gg: ASbGnct324Ct8cU98FvtHIeQegdeeJXBBuz4XY3Ok3PT9b6/mHXzwqTuOYBClSngaCD
	l/XFeS4IiA5xvxlpUVojaPD7Y3SBOkru3kjovM3R8oYee7NZaCPbgsivpTb5hA7di4+/OZBmK6T
	oV4jGV9RThS3ch+P+bq/Jmyz4kcUZjonYB7bIfh4v+prISz0UxUcTXLQIvpCln/aJY/1HOz1KXG
	Q5wT7okF0RWN35LXx42yk6AlJABlvj1Pd6gUyKGek7jXtdQuPJtg2YX27EwLXWVJpGZ+xzyPjN/
	h10rLqLbbOs7vYo5WQEtsUKGtABoZLp1FYXYuUA394Y=
X-Received: by 2002:a05:600c:4fcf:b0:439:8878:5029 with SMTP id 5b1f17b1804b1-43f0e559b59mr17275505e9.2.1744104537136;
        Tue, 08 Apr 2025 02:28:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhpOS2RXvhgff3wksFzuaqSdXSfMzYI4OqpbYjwZCmgj2nkzJ65yFcKEppTsA1r/gQVzTICQ==
X-Received: by 2002:a05:600c:4fcf:b0:439:8878:5029 with SMTP id 5b1f17b1804b1-43f0e559b59mr17275315e9.2.1744104536739;
        Tue, 08 Apr 2025 02:28:56 -0700 (PDT)
Received: from [192.168.88.253] (146-241-84-24.dyn.eolo.it. [146.241.84.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1660eb3sm159792645e9.11.2025.04.08.02.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 02:28:56 -0700 (PDT)
Message-ID: <1b78c63b-7c07-4d25-8785-bfb0e28c71ad@redhat.com>
Date: Tue, 8 Apr 2025 11:28:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: disable delayed refill when pausing rx
To: Jason Wang <jasowang@redhat.com>,
 Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20250404093903.37416-1-minhquangbui99@gmail.com>
 <1743987836.9938157-1-xuanzhuo@linux.alibaba.com>
 <30419bd6-13b1-4426-9f93-b38b66ef7c3a@gmail.com>
 <CACGkMEs7O7D5sztwJVn45c+1pap20Oi5f=02Sy_qxFjbeHuYiQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEs7O7D5sztwJVn45c+1pap20Oi5f=02Sy_qxFjbeHuYiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/8/25 9:34 AM, Jason Wang wrote:
> On Mon, Apr 7, 2025 at 10:27 AM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> On 4/7/25 08:03, Xuan Zhuo wrote:
>>> On Fri,  4 Apr 2025 16:39:03 +0700, Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>>>> When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
>>>> napi_disable() on the receive queue's napi. In delayed refill_work, it
>>>> also calls napi_disable() on the receive queue's napi. This can leads to
>>>> deadlock when napi_disable() is called on an already disabled napi. This
>>>> scenario can be reproducible by binding a XDP socket to virtio-net
>>>> interface without setting up the fill ring. As a result, try_fill_recv
>>>> will fail until the fill ring is set up and refill_work is scheduled.
>>>
>>> So, what is the problem? The refill_work is waiting? As I know, that thread
>>> will sleep some time, so the cpu can do other work.
>>
>> When napi_disable is called on an already disabled napi, it will sleep
>> in napi_disable_locked while still holding the netdev_lock. As a result,
>> later napi_enable gets stuck too as it cannot acquire the netdev_lock.
>> This leads to refill_work and the pause-then-resume tx are stuck altogether.
> 
> This needs to be added to the chagelog. And it looks like this is a fix for
> 
> commit 413f0271f3966e0c73d4937963f19335af19e628
> Author: Jakub Kicinski <kuba@kernel.org>
> Date:   Tue Jan 14 19:53:14 2025 -0800
> 
>     net: protect NAPI enablement with netdev_lock()
> 
> ?
> 
> I wonder if it's simpler to just hold the netdev lock in resize or xsk
> binding instead of this.

Setting:

	dev->request_ops_lock = true;

in virtnet_probe() before calling register_netdevice() should achieve
the above. Could you please have a try?

Thanks,

Paolo


