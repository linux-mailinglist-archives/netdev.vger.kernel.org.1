Return-Path: <netdev+bounces-156615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD91A0726E
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880B71884F31
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A352215793;
	Thu,  9 Jan 2025 10:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRClaXeA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5298B215772
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417351; cv=none; b=mEQoBGcvRDuiM+ZhscPdRufmLszdRGAI2yXusYzfo6CdyL0uwlW6zAqfMJgKJXly75M03OmKmXcGMpKZTvOUgdpkiS0jj8C/Bdaql2DJujxfpnPkGtMfO+QR0EroJO7EJAZdo0hB8xwXiGaCW/FwSrfG4tJOtJ9JYD6WiupdpWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417351; c=relaxed/simple;
	bh=MGOqvgCMMqB4CiOIclpLXZcXuiS7g7yW1cgotaTi84I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eyr3oLHpoS4mHqOmDUIT1roXxDW9vmTbz3xnkHZBhjRSnU7JLmamnNaBYuE+rFt40QAz/jH8xOuhUgsmPkD06JCb0D3Ep4gTAw3MPAyIYx1BOdUAlYvLL2n3qy30Im2lzObjOYYIvNBfcVt67XyIazBeKa8zyE5kMIn50IT5mus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LRClaXeA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736417348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0GQJaa0rnxulvwHWTT5/nSo9UoN71EPOBQMB5Lxp+kA=;
	b=LRClaXeAEUvhu+zAtYtZ9YVn6rTtFrpyY/bCFiXa04JXded3pEg9ueztiAycUJZO/R0BLn
	jr1xI5eFLYiF0URxBQ1/ihtDRpxHPo4Ct8v21s7/FZNYiJbk1xsUFIZ+AdbzhBeqmxmHHt
	B3ytro3JE+Z7MMWrAsxlDrI+o4J66T4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-5VPU_r9TN56vyPpCnTd5uA-1; Thu, 09 Jan 2025 05:09:06 -0500
X-MC-Unique: 5VPU_r9TN56vyPpCnTd5uA-1
X-Mimecast-MFC-AGG-ID: 5VPU_r9TN56vyPpCnTd5uA
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d899291908so22585026d6.0
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 02:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736417346; x=1737022146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0GQJaa0rnxulvwHWTT5/nSo9UoN71EPOBQMB5Lxp+kA=;
        b=QsVYbtX5g3pv/KZZMN2v3AtqIQcSWTFktsVUPYUZDrjf01cO18/IKVRq4QVB+MmdzR
         /o2VifSHwhqv3XG6JywJ2vUC3mIzwmUUmiT3Fp5kgCJiW/gh2PMyX2tzSupVUaHPJHtE
         CXo90SMsVZjHIMUDJvzOqouROvYUCVUpqSAPXy/2ihsnHBIdww3TASRtHCnYTgZJMcXt
         BhMaKkjwFbPp85GkDAOHxuVUR9CJHjzDaYAwf1Q9H2w+1mHaB/wq+V4kYva+fzVxK0l2
         zrhpkJYwsRS00tzbwp6bmcd1E9t1jdWC8t+xviX/pXYQIzvAZEy2s7qJi6XMX/DtyXt0
         aMhQ==
X-Gm-Message-State: AOJu0YzkixmmtgI9fvUZwkJj5D/Y95/m4E/2SRCbzl931miZOx2Irb0b
	Pn96rkUlNld6CPkLYw38WDESlgsfxQD5zlLiJe96Q2avd027gUQ/AjzN9I1XOerokqyN8VWzgVw
	8EgMispksJgwX3qB76YzF4itQaIOwUA8vwBGXFu5xNc7HVkp5EGVJYw==
X-Gm-Gg: ASbGncu613n/dW8mU8fTsdyoARNwRTtKEAXEAQ2cVbLsCFtbRROjGTFzm9qEZ5wvB92
	CM+EkgM0sGKe76kKu7Hwp0XE/UWAx81/9LzWpZ1cgNruLnUHsV+C+GxPC6qiC7TUpKRrTKrkqWe
	UJ9n3vkeD8RYfn7n3vyRQksGSZF3KnA8CSTrqFckZDHFeYNbIUkN5GJ+JjFwzo9RTayCE254QSV
	lFHManfhrxnxrW1w3+cxUWa8oI7WNLS84a9nThq/FGIExpYJTgGQ+p9KQXZVv/fzj2Sdvlvkp8j
	gBiykZc3
X-Received: by 2002:a05:6214:3386:b0:6d8:8874:2127 with SMTP id 6a1803df08f44-6df9b1ce252mr101036596d6.5.1736417345851;
        Thu, 09 Jan 2025 02:09:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtJLUeZRNR8S6rjtijwq4ZYVawXsnNI4bNczTbzYYMZXyt3xn6XoA8n4AVAIoAeZz6TqG3hg==
X-Received: by 2002:a05:6214:3386:b0:6d8:8874:2127 with SMTP id 6a1803df08f44-6df9b1ce252mr101036106d6.5.1736417345215;
        Thu, 09 Jan 2025 02:09:05 -0800 (PST)
Received: from [192.168.88.253] (146-241-2-244.dyn.eolo.it. [146.241.2.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd18134babsm197276376d6.53.2025.01.09.02.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 02:09:04 -0800 (PST)
Message-ID: <362d84f1-5adf-4fae-a826-01c39f891f1e@redhat.com>
Date: Thu, 9 Jan 2025 11:09:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] page_pool: check for dma_sync_size earlier
To: Furong Xu <0x1207@gmail.com>, Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
References: <20250106030225.3901305-1-0x1207@gmail.com>
 <CAL+tcoBfZRNrHarZzmRh0ep+QrfZOntm82hECNb=aMO-FdmH8g@mail.gmail.com>
 <20250106113123.0000384b@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250106113123.0000384b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/6/25 4:31 AM, Furong Xu wrote:
> On Mon, 6 Jan 2025 11:15:45 +0800, Jason Xing <kerneljasonxing@gmail.com> wrote:
> 
>> On Mon, Jan 6, 2025 at 11:02 AM Furong Xu <0x1207@gmail.com> wrote:
>>>
>>> Setting dma_sync_size to 0 is not illegal, fec_main.c and ravb_main.c
>>> already did.
>>> We can save a couple of function calls if check for dma_sync_size earlier.
>>>
>>> This is a micro optimization, about 0.6% PPS performance improvement
>>> has been observed on a single Cortex-A53 CPU core with 64 bytes UDP RX
>>> traffic test.
>>>
>>> Before this patch:
>>> The average of packets per second is 234026 in one minute.
>>>
>>> After this patch:
>>> The average of packets per second is 235537 in one minute.  
>>
>> Sorry, I keep skeptical that this small improvement can be statically
>> observed? What exact tool or benchmark are you using, I wonder?
> 
> A x86 PC send out UDP packet and the sar cmd from Sysstat package to report
> the PPS on RX side:
> sar -n DEV 60 1

I agree with Jason: in my experience this kind of delta on UDP pps tests
is quite below the noise level.

I suggest to do a micro-benchmarking, measuring the CPU cycles required
for whole page_pool_dma_sync_for_device() call via get_cycles(), on
vanilla and with your patch - assuming the arch you have handy supports it.

The delta in such testing should be significant.

Thanks,

Paolo


