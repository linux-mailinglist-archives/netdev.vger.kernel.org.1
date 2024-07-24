Return-Path: <netdev+bounces-112794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF92B93B3BA
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 17:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB7428199B
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 15:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1674B15CD58;
	Wed, 24 Jul 2024 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfBryDjG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FFD15B97C;
	Wed, 24 Jul 2024 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835099; cv=none; b=UO1A8dDnBoen3KkO5NPRB4DztcASe0oTL8zp8/VejbsvwMgwroe1d2UzVu22xqv6Syg6kpvNn2KLKUryUFMYyoaww/gU6SWyuPp+oiBnd41LTCwblaJbBPdW73rOOWU+HC7rTw95aAijSFExshFlNMZEIliYNxL9NQHYBfc30Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835099; c=relaxed/simple;
	bh=NSVxTjMae1Bx/+hhRYv5GEpIddtRRspNEEkO3N5REBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=szh/NwX++/5sOfZwNvHCR3MalWH0PFfV1W8tqzVfmoKROFaL+m1GuMM9HQEOaCOzuejOhbFD1/Grep8BtHwJwHpoJUkMTkuQnO1LLjN1uJfLzKxvIzgmrV/bXVtde5xAIt6y5FhRRb7ZI8/eBzWSBW6dZr4hh23clx1BJwyTQzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfBryDjG; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b5d3113168so39731776d6.2;
        Wed, 24 Jul 2024 08:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721835096; x=1722439896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1tbL2oJTejNN0wsTP/gMwmfeWI2fp0Jph/s0VC70w1g=;
        b=dfBryDjG3ah3Is26aLQ8K1sKxi0LbSozxS23wd7SoHE8b71ZH9TK+mUCCaS/zBnRj/
         BkUSrAOseJXyyFhwdTqlbWF/PcM1iaZ0Qdr+ZnpHKk/siDTNDm5LRa/BW/rZK2//IV2G
         7cYO865CAYv/UQJuEwjHP5HTBU2bjD4e8M+HOjWnJ1j9nHwUJ0BIbOnZzfKX/Eqzl4zq
         pw4Slfi5EzVeY52zSYlDhhrun1roODvO90v54VTfXDV9Xm5zCKqJxmBD3WhEznxSr/KA
         sWS7cHURxUGQ1xVYkmrFQeoqFfiZC1rYSI1x4Q+904TKfigt7A1h4JBjAodF+PBqbWJo
         IaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721835096; x=1722439896;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tbL2oJTejNN0wsTP/gMwmfeWI2fp0Jph/s0VC70w1g=;
        b=ZrPcvdESRQhKC3ftlT45psQs76tuuZGwGheG1PWS0q+TJMzbLrQ7eSXh4CIws9sOcx
         /OUekM6b3BOP4oSeFLR2LbdiqHDPTjffjBCD6OJpOtX8LpnyaWSkMEoXXkvCVg01ZRmd
         2ofnOrUkUJw3ukBXEbns8qY29PqSh7tB1uIaJhSd+Rpw97IXPAUTua2on/uDtvhNUBkE
         KVOpwZXJJmcAjIg2Vzhm7CKIxLDj8A/Bnfuyf4cyYI9qtxWXrghUfH0SpiOJgfxdQD/N
         /MZWlfxLeuCmtqy2sySIu+JWZq1mZ2C/oeVbSj3nhWqcLutSEEKFvH9nEU9+pGqXQDvo
         woFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2Di9pxu5EuUHFcGHFKXCpEjJeb2xaY9cPmjxk0/tiH51M/wgXdmXFkkTskLBphMV0U0LscHZZBMxt9/Z2RXYeuZRDCmbhHuulU0pi+NF7v7F5XChPljEcqBp6TU9frJ1iTkhEi/s8E/syLOBdCRcP9QN4XEhQze+AI5cPT17q
X-Gm-Message-State: AOJu0Yw5Z8EA+mnihDODrepRCgjQ59ECg6ujS2/B0Q7msUJuSmHZm2TH
	mPIo8Upj4eW/N1IW6VpHjjbeaAOV7iL7r2voepYGcv25cHETkHNd
X-Google-Smtp-Source: AGHT+IGBUmgZMThOGyavjxH711/T/NO3ceqcYGOPaJRLoh7bNPhZYeVdvXNea8I9n9yfF8kuKZLEXw==
X-Received: by 2002:ad4:5ecb:0:b0:6b5:e0b7:2fed with SMTP id 6a1803df08f44-6b9907d5c16mr27552066d6.47.1721835096366;
        Wed, 24 Jul 2024 08:31:36 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b963afab3asm44156946d6.62.2024.07.24.08.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 08:31:35 -0700 (PDT)
Message-ID: <999bc5f0-5b4c-4676-a085-ba2258c6a1d6@gmail.com>
Date: Wed, 24 Jul 2024 08:31:30 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usb: lan78xx: add weak dependency with micrel phy
 module
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, andrew@lunn.ch,
 gregkh@linuxfoundation.org
Cc: UNGLinuxDriver@microchip.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, woojung.huh@microchip.com
References: <2024072430-scorn-pushover-7d8a@gregkh>
 <20240724144626.439632-1-jtornosm@redhat.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240724144626.439632-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/24/2024 7:46 AM, Jose Ignacio Tornos Martinez wrote:
> Hello Andrew,
> 
>> Is MODULE_WEAKDEP new?
> Yes, and it has been merged into torvalds/linux.git from today:
> https://git.kernel.org/torvalds/c/f488790059fe7be6b2b059ddee10835b2500b603
> Here the commit reference in torvalds/linux.git if you update your repo:
> https://github.com/torvalds/linux/commit/61842868de13aa7fd7391c626e889f4d6f1450bf

What is the difference with the existing MODULE_SOFTDEP() which has pre 
and post qualifiers and seems just as fit?

> 
> I will include more references in case you want to get more information:
> kmod reference:
> https://github.com/kmod-project/kmod/commit/05828b4a6e9327a63ef94df544a042b5e9ce4fe7
> kmod test-suite has also been completed:
> https://github.com/kmod-project/kmod/commit/d06712b51404061eef92cb275b8303814fca86ec
> dracut patch has also been approved:
> https://github.com/dracut-ng/dracut-ng/commit/8517a6be5e20f4a6d87e55fce35ee3e29e2a1150
> 
>> It seems like a "Wack a Mole" solution, which is not going to
>> scale. Does dracut not have a set of configuration files indicating
>> what modules should be included, using wildcards? If you want to have
>> NFS root, you need all the network drivers, and so you need all the
>> PHY drivers?
> The intention is to have a general solution not only related to the
> possible phy modules. That is, it is a solution for any module dependencies
> that are solved within the kernel but need to be known by user tools to
> build initramfs. We could use wildcards for some examples but it is not
> always easy to reference them.
> In addition, initramfs needs to be as small as possible so we should avoid
> wildcards and in this case, include the only possible phy modules (indeed
> not all phy's are compatible with a device). In this way, with the default
> behavior, initramfs would include only the drivers for the current machine
> and the only related phy modules.
> 
> Thanks
> 
> Best regards
> José Ignacio
> 
> 

-- 
Florian

