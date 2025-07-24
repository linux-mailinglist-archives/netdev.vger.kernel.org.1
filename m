Return-Path: <netdev+bounces-209670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1A8B104EC
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 10:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53EA03A76FD
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 08:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F6E275B1D;
	Thu, 24 Jul 2025 08:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKHtRMei"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF694275851
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753346599; cv=none; b=sD0gqzANlnV+gs37iH8lIxR98yRkRam+68HbemesCjt0pRAuXAHuxqa0Q3s5ggssLZ3EIOt4BnjL2j1eTXWWz1/8BdFkd7rPxGdletKOWBiXTBdLWP6w5UeSC61r7LAbfg9ToRxua5kTfz8e0MmlsZZYwFWWi5+TwDcrtfUMPjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753346599; c=relaxed/simple;
	bh=9zN1dEpSPCgnoKMhnC9SNhHXxUcvr2JCUuRwjjhjxwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XUuiQwyt2zu48U4MVO2Mip9dCT8gHHuPNkQ4S1MbO/aN876+qTw0qBHo/yTQa+ELvA+4vGbVhQ4D3u5MYJ99arEwtP9HzeL7YWBqHnGdv+IBcxwV9Oi7+jLWNvaRoBnfbKK/1cRZKPVuHwwKvcrRfPPd9CkgXchNyAOHkymjUVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VKHtRMei; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753346594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=131oVeJbbxdBC3wo7pqtqaJG7n7zzMzTYT4OnzIeYJg=;
	b=VKHtRMei/ir5d+wLmwO8e+6U9Tkplg8zWKGyVxlvaRUxcRQAEZdEvVB//6+fLjT4oCpwqU
	SVDb3nZv8odLEh0JOKlM9QztR0uu0KivcZPh/gHd7+zTBkcylUpImuLDbqbilWRv7M3I4z
	KxBAXjv2YSUUcwsunIgDQHtmDKzxLhg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-u6705_gsNZSKJazdlUE58g-1; Thu, 24 Jul 2025 04:43:12 -0400
X-MC-Unique: u6705_gsNZSKJazdlUE58g-1
X-Mimecast-MFC-AGG-ID: u6705_gsNZSKJazdlUE58g_1753346591
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a523ce0bb2so390596f8f.0
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 01:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753346591; x=1753951391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=131oVeJbbxdBC3wo7pqtqaJG7n7zzMzTYT4OnzIeYJg=;
        b=n3efvlxK9eoKuebIPmltuxfD48DAtK2iOTbN/ziJK0+rgZx34956bp7FupQNCDMqBf
         ZXoH+ho8JbPrafsVuLAe2U5V+pAnCRCwXdQFIk36xhCXmVFHvXZykaHRa2udh0XPHu4q
         TnuoEZaAKIQrqN1Imli0Tr08ta7N1URAy2PHUH9daBY/C1HUATz1hhZBmZt8nppfzdl0
         SHgJANP543lcIAn2evrvvcdKICVR79Zg4WQqRz0IswNEInP0qEAi6lvCzW+IMZeXsboA
         3Hu/bXMWqUPyPwhE9FHCozFgRLSX6r4AADPYsj/0+d7B8GsJBN+GMpeSNN2gxNl9cx7+
         5xDA==
X-Forwarded-Encrypted: i=1; AJvYcCVo2qZjD2DI+yXG4RYvetmo1Q6LRKxdH/ppTonRu/SKpyts6hnLx0H/KwWF3kA/6w0RmFFKr8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5c9R+5mcoq4Ijl2O0uOpAHXv5MAkk7QXG3iAGFpvc8jAtF46p
	J0AmGFFMwdkDvTLYnLI9AriadOp7nB+dDfe/iN0VKbc41q6MEYjVgPsLWBdw7PGu43svmQRJHJn
	8PRXpbsWxIgKqfd0J7Q1VrYT0yhmns1aeBHjaZacqQGsX04M8aLrqXrz0aQ==
X-Gm-Gg: ASbGncveaDtSmkZqel8nS3nDlcMKTj0mfx1YxCp0lkDlHWaqx7aqBUzgmyvIs/21ML5
	ij+LLr9a0iNInjsSodzBnuJLSVdjzn89mgr36G4kVjcGapscB53sx+e2mqKD+5YPhmKdtCzUSkD
	9m/oKHdbi1eGG8tH9gyS14mkHohira8SFpzBLKNcSegyQi0YuXBpfhqoCDd7cUOfPSPCWEwZa0B
	x0EDZkP+Ada+liOonXr+XojU/9yhuFkUHNqNIi5m86fN1hWUnaIoj7E9Io0G23aFAcK1UYO60Xl
	El5TFrHPrdi5hIdbh/y7Zu93nAJwLX9GAS31KPK5Ul/Nt3R94iNroAZzuGB8uZtvwXbQOBJ/ZRf
	VDJkN4tAbkb0=
X-Received: by 2002:a05:6000:25c5:b0:3a4:f744:e01b with SMTP id ffacd0b85a97d-3b768efff24mr5893571f8f.39.1753346590780;
        Thu, 24 Jul 2025 01:43:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw2ZCsLSC8U30AYmY/u4VF/S1+ls/wQ2DtYhThaRcAJMKg+XGgueYBxIEB3uBg9YGMehdIgQ==
X-Received: by 2002:a05:6000:25c5:b0:3a4:f744:e01b with SMTP id ffacd0b85a97d-3b768efff24mr5893538f8f.39.1753346590308;
        Thu, 24 Jul 2025 01:43:10 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcb888csm1456929f8f.59.2025.07.24.01.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 01:43:09 -0700 (PDT)
Message-ID: <83470afc-31f1-4696-91f3-2587317cb3a1@redhat.com>
Date: Thu, 24 Jul 2025 10:43:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: virtio_close() stuck on napi_disable_locked()
To: Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Zigit Zo <zuozhijie@bytedance.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <c5a93ed1-9abe-4880-a3bb-8d1678018b1d@redhat.com>
 <20250722145524.7ae61342@kernel.org>
 <CACGkMEsnKwYqRi_=s4Uy8x5b2M8WXXzmPV3tOf1Qh-7MG-KNDQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEsnKwYqRi_=s4Uy8x5b2M8WXXzmPV3tOf1Qh-7MG-KNDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/23/25 7:14 AM, Jason Wang wrote:
> On Wed, Jul 23, 2025 at 5:55 AM Jakub Kicinski <kuba@kernel.org> wrote:
>> On Tue, 22 Jul 2025 13:00:14 +0200 Paolo Abeni wrote:
>>> The NIPA CI is reporting some hung-up in the stats.py test caused by the
>>> virtio_net driver stuck at close time.
>>>
>>> A sample splat is available here:
>>>
>>> https://netdev-3.bots.linux.dev/vmksft-drv-hw-dbg/results/209441/4-stats-py/stderr
>>>
>>> AFAICS the issue happens only on debug builds.
>>>
>>> I'm wild guessing to something similar to the the issue addressed by
>>> commit 4bc12818b363bd30f0f7348dd9ab077290a637ae, possibly for tx_napi,
>>> but I could not spot anything obvious.
>>>
>>> Could you please have a look?
>>
>> It only hits in around 1 in 5 runs.
> 
> I tried to reproduce this locally but failed. Where can I see the qemu
> command line for the VM?
> 
>> Likely some pre-existing race, but
>> it started popping up for us when be5dcaed694e ("virtio-net: fix
>> recursived rtnl_lock() during probe()") was merged.
> 
> Probably but I didn't see a direct connection with that commit. It
> looks like the root cause is the deadloop of napi_disable() for some
> reason as Paolo said.
> 
>> It never hit before.
>> If we can't find a quick fix I think we should revert be5dcaed694e for
>> now, so that it doesn't end up regressing 6.16 final.

I tried hard to reproduce the issue locally - to validate an eventual
revert before pushing it. But so far I failed quite miserably.

Given the above, I would avoid the revert and just mention the known
issue in the net PR to Linus.

/P


