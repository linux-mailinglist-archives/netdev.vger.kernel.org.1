Return-Path: <netdev+bounces-157074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94535A08D48
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A3BD1888111
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A62A20ADE1;
	Fri, 10 Jan 2025 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="T430dLon"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F54E20ADC1
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736503456; cv=none; b=QFaFgS4G9Em1GYrCHcgwshhCCZy6ugL7E2Qn9gesyENKawcSybM4M4SUOk+nYCSJ9W17u7eSS7xjNq4UL9HtVJtJtmorVPC96OSXcD6kLISZnzYst2Xrk8atK29Owu2MW3m1GGJasHYzhwBgePw2DUnoQvF/YlaFsUvNYCokwkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736503456; c=relaxed/simple;
	bh=qNaQzpehQQCjP6U1Smo/Nd38XDFDvWBgAvAJl4KW8uA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rAwzCTpudlgcqiu+K5hXehj6cXbEPuRIayae0vXmOxlD0gdkbLvACb1EBfQpccLL3guiOy6MIip+J2g2QMGu/Bk3o0m+HW7C44aja3FGhPMSxF+4ZkrnhR6+ZSLBOtiwJwmV6GU1wm5+jhKZHCGuoWhyK1V50BkIUfqgRmGd1uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=T430dLon; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-218c8aca5f1so38272895ad.0
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 02:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736503453; x=1737108253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SbCDbM8KQIXhK7Foj8Bp5mpZOBTNVuVCawxI33XikWY=;
        b=T430dLonjsSAlmOPpq7K62Twr27dL4/lXuDT+WU9UJck6NoShVeGAWEMj3/qYGuPUH
         8mFqeyWqrs3KumgimS1EVzKIAbfut7Q6WFp3lbwPxwNIlQW+OXhm2kvjOrHKOSu6iqPI
         sz/FqNdIYJA4ikICrLBHVmtTbdwxQopPQElXiVYW7dAqXkWuZoKMx6Zw89YIS/Th91ce
         Ns0K96mE2Zn4xFfW4n87qUJX3hCp1Gib74kwWQA+fZkHc86483l3Pjv4ZrGuT8cAcCyA
         BBkYOpeD6sTng1k2vf1MDl18Lz3AF5XyU9d57Jr5VnFpopMkpnaVZ8zaYlzJEQ7HL9kX
         0Lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736503453; x=1737108253;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SbCDbM8KQIXhK7Foj8Bp5mpZOBTNVuVCawxI33XikWY=;
        b=qDWGK1H4GaMxJgQJ3MsMk0HSNSL0ijytGoB/X1B+cRVk/Ju/SzkV3NtVgXFpXsoNbi
         WlhTq/pzQbz/ikBTyw3SxcqClHlY9r3ZCsIVlgzLcN/0KbusC9WUuOhOmCs0ajZS6w+t
         Ems1Lf5wL+gNaNUo/XCngA8Dr5ul+lIm7gHQGYUHFEvQaDHCWHO7cRklxLJclZAN4MsU
         xZUsNjJUawQdQZCI/jvMSuWLrkxfHKNKT3hUwdhCBtOIQJXGpdKxgU+bmvo3fzweinbA
         l5jIRIcfV+BiT4H4PbPlC6IgzUtK4Q7ULWtgxh473MVna0P65jsS131NG3VUpPnct5gk
         Lg2g==
X-Forwarded-Encrypted: i=1; AJvYcCX45R9jVjc0lOyVKDpFZCg7wqp/6DPRKMaG12iuaOjGv/T5cwzq9E9lBJsQiy7krgiSL6hdfWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqJfm8HjcXRNCQQxE0U6X80PcXbPdW/qAyGPfDfve76f4eVjeq
	H3iplyCkLZg50LDdBPlbaHl8oOZ4emEzpPVPh7V+K6A28InU0vLdITcsZuyJtEg=
X-Gm-Gg: ASbGncsmG51O4vtP7j5C/UzwO8JrSo6pzXdSsBXSrXIpcW+pSDlaSLvsUh7xkKR0woQ
	h+z6I0ZGtH1W7pIiIT8v19iPHyObG4qIoAjWgbXr97LCXA1tByKn1+xbFfetcnLm6tW2y9qGpuE
	CzFZNEWXzeUr7Hywy6qaLMMTnA/CibE6+Q4VlrDv4Dkd9QUIZDhLX7C4M7IcNj8hmHbrclh5CA+
	vhSOfIvMmSeLkBrieSXkudVkIQi50IOLahO0bTvdb44rdv+hVjSaN+hIUHHqzClvJ4=
X-Google-Smtp-Source: AGHT+IGwGJ74ps/x/Eb/FXDjZwvLuJmQUxKHNbskjBfpmMO+fHvECFMcSxYPTjF3D4hGyGv0Hh3cVw==
X-Received: by 2002:a05:6a00:179f:b0:72a:bc54:84f7 with SMTP id d2e1a72fcca58-72d21f4f2e5mr15271389b3a.12.1736503453610;
        Fri, 10 Jan 2025 02:04:13 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4067e9e1sm1247468b3a.131.2025.01.10.02.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 02:04:13 -0800 (PST)
Message-ID: <1f2908ed-e938-4365-8f1e-9f1c7753fb9b@daynix.com>
Date: Fri, 10 Jan 2025 19:04:07 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v2 3/3] tun: Set num_buffers for virtio 1.0
To: Jason Wang <jasowang@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-3-388d7d5a287a@daynix.com>
 <CACGkMEsm5DCb+n3NYeRjmq3rAANztZz5QmV8rbPNo+cH-=VzDQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CACGkMEsm5DCb+n3NYeRjmq3rAANztZz5QmV8rbPNo+cH-=VzDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/01/10 12:27, Jason Wang wrote:
> On Thu, Jan 9, 2025 at 2:59 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> The specification says the device MUST set num_buffers to 1 if
>> VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
> 
> Have we agreed on how to fix the spec or not?
> 
> As I replied in the spec patch, if we just remove this "MUST", it
> looks like we are all fine?

My understanding is that we should fix the kernel and QEMU instead. 
There may be some driver implementations that assumes num_buffers is 1 
so the kernel and QEMU should be fixed to be compatible with such 
potential implementations.

It is also possible to make future drivers with existing kernels and 
QEMU by ensuring they will not read num_buffers when 
VIRTIO_NET_F_MRG_RXBUF has not negotiated, and that's what "[PATCH v3] 
virtio-net: Ignore num_buffers when unused" does.
https://lore.kernel.org/r/20250110-reserved-v3-1-2ade0a5d2090@daynix.com

Regards,
Akihiko Odaki

