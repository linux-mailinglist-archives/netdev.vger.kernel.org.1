Return-Path: <netdev+bounces-124503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 882B0969BEC
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 13:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15AC3B22697
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 11:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957C31A42D1;
	Tue,  3 Sep 2024 11:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4qshJK5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C56F1AB6E7
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363294; cv=none; b=Mu1yJxch88q4rgAhVhYjQlF+GXTE0A9ydVaGJ7y337Pqx2pvHirU2aVviezfX7imzcul51yagzvkKV3SosV/DSsOvzMbh/Vkoctct82k+I7MalCtulGHpw1yZOnMGkGGxBlXYiXU7NXGDBz4K8eO2/N8gL+FAKRa50hwX6KrszM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363294; c=relaxed/simple;
	bh=lPGpDFIxjO26BmIlvHeo4a2Y8K4xsirWwR5AmhwAEPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xa1F2iMDUZlkT0KFJYqgWPVYlljwDmTYxv+baNd7xICkUmcIlUjEAj0zoNbfzN2hpWR3ylzufBCws2klXOWk9HZkOftfa3sKQ53evTQXQjfYxCDMQJ+CVWsKwi534VuDF60J6uOQmrhvikYTD1stesvsnAYxU4g8A1a4qtFNik4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D4qshJK5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725363292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fknKQZlY31b2phIXK9/2OsBWa/UbsZhM0MNeK2dQa9U=;
	b=D4qshJK5VO8TrCtJ9jO3kaCaWTYV2lt2dd1isX1jp/nGRLliwYiPxdkQDbEIo36U209MfJ
	BWZYJcpBzi/vFiyTHz/RAGLZf+5JdYMLS1O7qK9CqNIB6Y2YileumVFoFARzvmb6Y8BlIH
	u1jSf0L+bWO69jk+OK+khGkLuwYWcyM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-t3tvjoyKPY2wQwhqGKLiTg-1; Tue, 03 Sep 2024 07:34:50 -0400
X-MC-Unique: t3tvjoyKPY2wQwhqGKLiTg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42c82d3c7e5so19742475e9.2
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 04:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725363290; x=1725968090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fknKQZlY31b2phIXK9/2OsBWa/UbsZhM0MNeK2dQa9U=;
        b=KXTIOxnAxb18Rw1qjVXBh7WTfnl2M3GZsmUXsfN26ICg2kVKSRRtgG0L+zHPnN41jX
         B31Z9sKL5yJ71J72itcimkP8dzdILCGhEIKGTG1EJuPZ2IEBvdQuDV84vUYL+8jT1FVR
         PlP09b+31OzSkyR05ziftwoSjyN/VbZpZ0sUaXs27Xut8XX+tTNjVg18adJapnYcGpaq
         lnydzhznzgOqCYqKlr40sAmpmsMMOIjdkHkD38dGo9qaMs1bNg9LTQUbe4GlLXHUu9Zv
         ASBRQyDx7pZdbJ07lVs8YbJG2Cprzr5++Y6JyApIMKcvpmTpXjzV0yDg0NcFBcq+HCAR
         xZlg==
X-Forwarded-Encrypted: i=1; AJvYcCXMiYSD3LrcS8bZ34MfuxgPPh0Q/ZrHuyQtlV25QApmnW8B9Ma4EjMF5qBBI/4PpeZ1FPyxfD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ1VH+yhkI4YMi8BDu7DULEuS8a7QW/+WcPKi371E0A0m8P+LB
	vziK5dtA1dlMNx726r9CPqJCJ20y9XaUpBf3wOJasGoxfuj0e3SsS6lXBoFHMMPYYJzYZdmP64T
	ZO0H6nR/v0z0nGOmxcT2DHfbkSXFrAf1EYohXwm3M5NYD2hSQxxrnvw==
X-Received: by 2002:a05:600c:3b9b:b0:426:62c6:4341 with SMTP id 5b1f17b1804b1-42c7b5b4bdfmr71914005e9.20.1725363289706;
        Tue, 03 Sep 2024 04:34:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZUnGiuR0PixuyoW7zSGsoBoNGc8eZZKvEgRk899uB1evbQo7IUhE+P26hwYsUUy/wSzuATQ==
X-Received: by 2002:a05:600c:3b9b:b0:426:62c6:4341 with SMTP id 5b1f17b1804b1-42c7b5b4bdfmr71913755e9.20.1725363289176;
        Tue, 03 Sep 2024 04:34:49 -0700 (PDT)
Received: from [192.168.88.27] (146-241-5-217.dyn.eolo.it. [146.241.5.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c046685fsm8912358f8f.79.2024.09.03.04.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 04:34:48 -0700 (PDT)
Message-ID: <9d56ddd6-ce40-40ff-b729-48f56d0fa08d@redhat.com>
Date: Tue, 3 Sep 2024 13:34:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] net: sched: use RCU read-side critical section in
 taprio_dump()
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Dmitry Antipov <dmantipov@yandex.ru>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240830101754.1574848-1-dmantipov@yandex.ru>
 <20240830101754.1574848-4-dmantipov@yandex.ru>
 <857dceaa-7ef7-40c6-b519-2781acaa8209@intel.com>
 <905b141a-7c7e-408b-bcd1-7935b8fdba0e@yandex.ru>
 <1811760f-ea09-46cb-9918-b8f46995b415@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1811760f-ea09-46cb-9918-b8f46995b415@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/30/24 15:53, Alexander Lobakin wrote:
> From: Dmitry Antipov <dmantipov@yandex.ru>
> Date: Fri, 30 Aug 2024 16:48:39 +0300
> 
>> On 8/30/24 4:02 PM, Alexander Lobakin wrote:
>>
>>> Why did you invert this condition and introduced +1 indent level?
>>
>> Just to reduce amount of labels and related gotos. After adding 'unlock'
>> at the end of RCU critical section, it was too much of them IMHO.
>>
>>> The original code doesn't have nla_nest_cancel(), why was it added?
>>
>> IIUC both original and new code has 'nla_nest_start_noflag()' and
>> 'nla_nest_{end,chancel}()' calls balanced correctly.
> 
> Ah sorry, I haven't noticed you removed the related label below.
> That's why it's not a good idea to refactor the code in the patch
> targeted as a fix.
> You just need to fix the actual issue, not refactor anything / change
> the code flow.

+2, the fix will be small and simple without the mixed-in refactor, 
which is a big plus.

Additionally goto and labels are still the preferred way to handle error 
paths in networking.

Please add the target tree (net) in the prefix subj when you repost.

Thanks,

Paolo


