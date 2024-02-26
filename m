Return-Path: <netdev+bounces-75122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEC7868483
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 00:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6901C2205C
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 23:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CE0133285;
	Mon, 26 Feb 2024 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXq0pOSz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01F560864
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708989243; cv=none; b=DQ5p8DJKNakZU32RA2RGwMWSHn2XkdTp61nb9b4NaUqdAVbSlodo/cIJOVyYBTBdgDYMHjir9rqB+simniPSj3IGSxxGrFr6obd+7p+SCsCpJUXUgntijlSZ/U/2m0XzF71zeT3IKAV+AeYcBwp2xNTWa+EcrXxrUM/fRc3rBiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708989243; c=relaxed/simple;
	bh=Jjcv+xa9kh2Wiw+Zd+ky5XQ7X+A7ycL7jBCIoB0zquE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGvJ1l7fv6rqYfVh5peqk48V75ofhlC7utoYGB23ze0T5JgKwrlxj0z5xQ9PFtZ0nLV5qfIpPYDPlO15plBvgWHWmnYP8KJNwV18cPW8UFFz3GtgX2cXQN/Hd8/8co0uI/BeIB1bBIFE/bsvy/yXk1N0vWZmeO1dxd3/VimEop8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXq0pOSz; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c1a3384741so966113b6e.0
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 15:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708989241; x=1709594041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AcbfQ2ZMtTXwvOmlNhigDtqzxobvdNMDqUZ3xL5Yzrg=;
        b=NXq0pOSzrOCsGiB/jfsJyo+P/FnEnMS2e4jfZ0CcundQEtpZdu8V2d19lBvMvr4xmT
         zoiDJXDPI1cTi5NJokv6XDqsjFW8OsPzbhuDkAxbyk1C7D9PTt5dZxr2DAh5V08zQyN3
         19qPG1RLW4zsohLiBNd68u7cLouJsuADW8KlFvXPfk6AgxejiVh+aQ7116kBMDPUkEeG
         fNJi5M2kR3xbC7YICzEJgsaZDDsYUlN+khXpTAVeDCJsuk9cWBcjulfWudMneRAdeOwp
         p5Wl9ZVvphErLueMq37rRLu2vfD3rDwrXbOpEW4wQxcOa1AxzwGmxPGYTLyPNGtx8/aa
         QG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708989241; x=1709594041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AcbfQ2ZMtTXwvOmlNhigDtqzxobvdNMDqUZ3xL5Yzrg=;
        b=dUZlMp9c0qPgq3NSJnGeSWrn+XkGN0SBhTD/BPtThwOYWeeUN6AoqLQVim1Z/9iqZC
         /bKV/DYqrvC+YNZL90C1jtG0jKfSaz9aaPVv85i271RH3iBWV4nGngePSHibd1t+UkS0
         2js+iXpCsS1sbobGrpmnXdLMI5lOnrWCNntNB9RWx4uZ04HDyHszmltmin9gJcGG/WPM
         iuxcARNoUtHM0X/QPpEgJZOSyXDMf+79JYNg3cohXPZ5j0m6bx/0e7XSmHlBjH92PUx6
         yRKUOS2LsP0bGbdNXWStLGJIp/ChiXJhPL9U3PkRxmNbXgXmha7ero/le5ZBZfSG/DXm
         b0IQ==
X-Gm-Message-State: AOJu0YxL+QeMdbBg5yNZ9X/XOU1EsJvNOOTdTxfaUrkvUEW0HWRju2mW
	gVylP4/aH6SY54CsOZXHbD2nwACpqIfwFg/0HP8j0cQfugYl8k2U
X-Google-Smtp-Source: AGHT+IEz7EQPvsPHPkhJo9iBgVKGCv1SFtqJqmM8InXvJaSJHbur/eZEZ+WKl/Ce19kgt3bqw+UUpg==
X-Received: by 2002:a05:6808:159d:b0:3c1:9519:1c19 with SMTP id t29-20020a056808159d00b003c195191c19mr587672oiw.37.1708989240717;
        Mon, 26 Feb 2024 15:14:00 -0800 (PST)
Received: from [10.69.40.148] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id kv5-20020a056214534500b0068d191dfa9fsm3478310qvb.94.2024.02.26.15.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 15:14:00 -0800 (PST)
Message-ID: <f189f3c9-0ea7-4863-aba7-1c7d0fe11ee2@gmail.com>
Date: Mon, 26 Feb 2024 15:13:57 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bcmgenet: Reset RBUF on first open
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Maarten Vanraes <maarten@rmail.be>
Cc: netdev@vger.kernel.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Phil Elwell <phil@raspberrypi.com>
References: <20240224000025.2078580-1-maarten@rmail.be>
 <bc73b1e2-d99d-4ac2-9ae0-a55a8b271747@broadcom.com>
Content-Language: en-US
From: Doug Berger <opendmb@gmail.com>
In-Reply-To: <bc73b1e2-d99d-4ac2-9ae0-a55a8b271747@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/26/2024 9:34 AM, Florian Fainelli wrote:
> On 2/23/24 15:53, Maarten Vanraes wrote:
>> From: Phil Elwell <phil@raspberrypi.com>
>>
>> If the RBUF logic is not reset when the kernel starts then there
>> may be some data left over from any network boot loader. If the
>> 64-byte packet headers are enabled then this can be fatal.
>>
>> Extend bcmgenet_dma_disable to do perform the reset, but not when
>> called from bcmgenet_resume in order to preserve a wake packet.
>>
>> N.B. This different handling of resume is just based on a hunch -
>> why else wouldn't one reset the RBUF as well as the TBUF? If this
>> isn't the case then it's easy to change the patch to make the RBUF
>> reset unconditional.
> 
> The real question is why is not the boot loader putting the GENET core 
> into a quasi power-on-reset state, since this is what Linux expects, and 
> also it seems the most conservative and prudent approach. Assuming the 
> RDMA and Unimac RX are disabled, otherwise we would happily continuing 
> to accept packets in DRAM, then the question is why is not the RBUF 
> flushed too, or is it flushed, but this is insufficient, if so, have we 
> determined why?
> 
>>
>> See: https://github.com/raspberrypi/linux/issues/3850
>>
>> Signed-off-by: Phil Elwell <phil@raspberrypi.com>
>> Signed-off-by: Maarten Vanraes <maarten@rmail.be>
>> ---
>>   drivers/net/ethernet/broadcom/genet/bcmgenet.c | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> This patch fixes a problem on RPI 4B where in ~2/3 cases (if you're using
>> nfsroot), you fail to boot; or at least the boot takes longer than
>> 30 minutes.
> 
> This makes me wonder whether this also fixes the issues that Maxime 
> reported a long time ago, which I can reproduce too, but have not been 
> able to track down the source of:
> 
> https://lore.kernel.org/linux-kernel/20210706081651.diwks5meyaighx3e@gilmour/
> 
>>
>> Doing a simple ping revealed that when the ping starts working again
>> (during the boot process), you have ping timings of ~1000ms, 2000ms or
>> even 3000ms; while in normal cases it would be around 0.2ms.
> 
> I would prefer that we find a way to better qualify whether a RBUF reset 
> is needed or not, but I suppose there is not any other way, since there 
> is an "RBUF enabled" bit that we can key off.
> 
> Doug, what do you think?
I agree that the Linux driver expects the GENET core to be in a "quasi 
power-on-reset state" and it seems likely that in both Maxime's case and 
the one identified here that is not the case. It would appear that the 
Raspberry Pi bootloader and/or "firmware" are likely not disabling the 
GENET receiver after loading the kernel image and before invoking the 
kernel. They may be disabling the DMA, but that is insufficient since 
any received data would likely overflow the RBUF leaving it in a "bad" 
state which this patch apparently improves.

So it seems likely these issues are caused by improper 
bootloader/firmware behavior.

That said, I suppose it would be nice if the driver were more robust. 
However, we both know how finicky the receive path of the GENET core can 
be about its initialization. Therefore, I am unwilling to "bless" this 
change for upstream without more due diligence on our side.

-Doug

