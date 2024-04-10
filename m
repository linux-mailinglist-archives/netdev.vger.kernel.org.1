Return-Path: <netdev+bounces-86682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A53D89FE81
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 19:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7AA28CC5A
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 17:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3969F17BB1E;
	Wed, 10 Apr 2024 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zb2lXa79"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62E4178CEE
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770117; cv=none; b=GwihIzOMWYFjjwZk6/F96Y80w5bAm63HxgTGW0SV6W74v187JpBFf0Av0cNQDjTjMUr8SgRFrlxUWXZhdDAZ6zA3jnRGOkz8SUMea1CMzXLn4WHep68F9dMwqBfKiSg3n9UbqhpjXQFFsp6I49nIuAuh2XS1h44iB+YH5JcJomY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770117; c=relaxed/simple;
	bh=f3Xt/dZfBXBIQcYbl1nJPSnlAT4JgWHq8FYToJaQzHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kuJE48+lehAu8XxLjUSwNPTEpaVG3gPP7r1F11oBoU1AQpP93/Gz6dmyKIJBQJXpsI+m76AJXjH/GkWXZkSOJAQNPrWZ1KV8RqruSljutMBitW2AIExUh5uaqGhv0fjQ1sQlnv/9KD8XkCIScOq82Tab+qCJFuvm5xrpKnm0LL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zb2lXa79; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6eaf1005fcaso4780530b3a.3
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 10:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712770115; x=1713374915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zq4d+AiOVD5bmBrgseTVTs7156g17/GtSiUjyHq5BcM=;
        b=Zb2lXa79WbKOnoTW2Kld3BTirq8KOYH8Izczobk8SLp+IUPWrdE+O1sZ2Ip17YbfkF
         zCms48bGaweCF1+fcvGw4dFPjPMbBKjs1i/+3GEgqYlMtKM9LYjPAgeSuqKccj6yAfcV
         Zo5mM0PjX+lnv4gbuW0EmYEPZb0EQ77fY7uKbk33SQsLKq86HffxXfZhUyXo0fUSaXuJ
         n2fw3GQ3Dngw9tLACG5a/3L0vUn9zsTC9f54qP5Q4pSHNPfWWEs7R5XCZsWcDimTjJAN
         WeJYFAYKC4X2+NRc4MaNOPY2s8l1F86nsqILy/5ROokqHTuwPQ7rWZZwG3Xdr/7/rprb
         SutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712770115; x=1713374915;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zq4d+AiOVD5bmBrgseTVTs7156g17/GtSiUjyHq5BcM=;
        b=VTgFtFAomGD2Mvar6OlAPmGB9z2mDIe6pKI4P01uHpTOP1dMA2LYo7TEkd5rQ1yMpt
         pWKD2wnfhyOp+tfbzE1M3HDA97+HROpvmD1gJaVULRdpjsCmJrf9ke5U06yA4EHFxFki
         dbEXCoTQnFMTc1hrqSPf5o3Oj8cmL06fbIwlekqdfahV/X5kp9Eb2lHjgejJIC2CyGsO
         3WQwB6f3CaTKuZ7a19g1BCjNXqP5uoCg2HU2KTRgZaoBZdmBFH/Wd4xDUv7sz3FIxt6T
         tTqGGi2vuODrsflmQTaTREl6/4AbORUtQQkJheS0kRrfgQvEfGci62B+qQUoM1KSwXoZ
         IKlA==
X-Forwarded-Encrypted: i=1; AJvYcCW9n5b+KeZVEso68fqGdn81jfzzH5yC3y1N56ImmnzL4UU2CpB5pZgHvY019+niezyi4UjmwtnplMQ2OaXdVfEgADkULdUJ
X-Gm-Message-State: AOJu0YzC7QFHf86c+ThAvFbmQC0fpKZNUgCfJMytDpWAJ5txjeYzA+TG
	zmKUVPrwodSwJdqL1dTrkuBLWXx3NFkJCc20zrr6A/k5Ul0qFmi/
X-Google-Smtp-Source: AGHT+IGIHil3mApRP9h1oyA+lEyfdCYJsOMLxEB1v3XLb5vQtFzdv6rWoHVqJv60PpJI2f5a5ZjGEg==
X-Received: by 2002:a05:6a00:803:b0:6eb:40:6bff with SMTP id m3-20020a056a00080300b006eb00406bffmr3877766pfk.14.1712770114852;
        Wed, 10 Apr 2024 10:28:34 -0700 (PDT)
Received: from [10.230.29.214] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f21-20020a63dc55000000b005ce472f2d0fsm10064336pgj.66.2024.04.10.10.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 10:28:34 -0700 (PDT)
Message-ID: <db4d4a48-b581-4060-b611-996543336cd2@gmail.com>
Date: Wed, 10 Apr 2024 10:28:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next:main 26/50] net/ipv4/tcp.c:4673:2: error: call to
 '__compiletime_assert_1030' declared with 'error' attribute: BUILD_BUG_ON
 failed: offsetof(struct tcp_sock, __cacheline_group_end__tcp_sock_write_txrx)
 - offsetofend(struct tcp_sock, __cacheline_group_begin__tcp_sock_...
To: Eric Dumazet <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
References: <202404082207.HCEdQhUO-lkp@intel.com>
 <20240408230632.5ml3amaztr5soyfs@skbuf>
 <CANn89iJ8EcqiF8YCPhDxcp5t79J1RLzTh6GHHgAxbTXbC+etRA@mail.gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <CANn89iJ8EcqiF8YCPhDxcp5t79J1RLzTh6GHHgAxbTXbC+etRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/8/2024 10:08 PM, Eric Dumazet wrote:
> On Tue, Apr 9, 2024 at 1:06 AM Vladimir Oltean <olteanv@gmail.com> wrote:
>>
>> Hi Eric,
>>
>> On Mon, Apr 08, 2024 at 10:49:35PM +0800, kernel test robot wrote:
>>>>> net/ipv4/tcp.c:4673:2: error: call to '__compiletime_assert_1030' declared with 'error' attribute: BUILD_BUG_ON failed: offsetof(struct tcp_sock, __cacheline_group_end__tcp_sock_write_txrx) - offsetofend(struct tcp_sock, __cacheline_group_begin__tcp_sock_write_txrx) > 92
>>>> 4673                CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 92);
>>
>> I can confirm the same compile time assertion with an armv7 gcc 7.3.1 compiler.
>> If I revert commit 86dad9aebd0d ("Revert "tcp: more struct tcp_sock adjustments")
>> it goes away.
>>
>> Before the change (actually with it reverted), I can see that the
>> tcp_sock_write_txrx cacheline group begins at offset 1821 with a 3 byte
>> hole, and ends at offset 1897 (it has 76 bytes).
> 
> 
> ...
> 
>> It gained 20 bytes in the change. Most notably, it gained a 4 byte hole
>> between pred_flags and tcp_clock_cache.
>>
>> I haven't followed the development of these optimizations, and I tried a
>> few trivial things, some of which didn't work, and some of which did.
>> Of those that worked, the most notable one was letting the 2 u64 fields,
>> tcp_clock_cache and tcp_mstamp, be the first members of the group, and
>> moving the __be32 pred_flags right below them.
>>
>> Obviously my level of confidence in the fix is quite low, so it would be
>> great if you could cast an expert eye onto this.
> 
> I am on it, do not worry, thanks !

Also just got hit by this on an ARMv7 build configuration as well.

Jakub, I do not see a 32-bit build in the various checks being run for a 
patch, could you add one, if nothing else a i386 build and a 
multi_v7_defconfig build would get us a good build coverage.

Thanks!
-- 
Florian

