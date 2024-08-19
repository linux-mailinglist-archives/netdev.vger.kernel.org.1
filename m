Return-Path: <netdev+bounces-119588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D736095648E
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8D91F25267
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD0F15749C;
	Mon, 19 Aug 2024 07:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="1/BYSrVg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B58156C65
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 07:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724052343; cv=none; b=XM8UuAKXZXniW6+JYsToht1zR3KMz8PmHLuad836+y3cf8gTAwVk7UwEN38OqtUFFb2UOUSlEvrDBw3ZycXbh3UcBN4yYYz5X2JF5eVaT0c1znWHmm2P8rU3v0N5DqarlfBgH03Qoje3StPcJZoXt4LaP79/BEaNjXYjhJICSh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724052343; c=relaxed/simple;
	bh=Xcyh7dCgSveqOOOM11EEatEczd5kKcEmKfaWijkMVZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8hPx/5hq2MJ0XpuPCYztJimqysnmuhMl50RUoocJrw70AiamE7F5AfPAWelmL+IHCjM/p2K2rC5sZrN4H3WETtAzFmbsyJ062/L/3qp7awqT2zQdN7XFXRRtMr8izXywEvRsNNOAy0e4os80IGcgK1uFOH78R16DI4o5MilAJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=1/BYSrVg; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso452144866b.0
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 00:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1724052339; x=1724657139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6P9bDJD99l5MPRWrRcbVskk3239IjN7GasiwRuKDMco=;
        b=1/BYSrVgJ5FCpwqChhgGfaYJ8mgCKJEgywog/FsdgL7Yw9BXf7h/nERISch4UNLHiN
         JIA68MoK9fQYPOhB7wsGTcv5NTmIkHn3XG+f/dXGH7JwZlcrqZtIREBztscJdwiPUKxt
         9Qw45TnB6ICLYrksXaFyii/IfHXxILe5RHn5biAV/5jyJKHA33HV1Hd9wrogE1Ua2CEc
         GVcWZ8jj1neu7FB2aaQO05zSeZRTaAJQAigPkjNnSi1bfLlmEvVTSWYrH8vRU8fLXXTI
         kT8BRkqYruW2MzbsBbyvObAvebQfvCE64Wah2KCyrbfqWb6FGUpntyUXwj+nkGlFF4Gz
         3ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724052339; x=1724657139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6P9bDJD99l5MPRWrRcbVskk3239IjN7GasiwRuKDMco=;
        b=v45KqkaLB3POWGAXB10g4c4JYSfjGEKCQzfzm1zUFbxmGppY9tLaal/BTSFaBdSwZc
         t6nQgPuNgQE/+4YUWr80L7UXkfJnJQZbi/P2HcYin5chTI1/mFKbXeLdY54CYZarEsOV
         uiEPPdG7P3GPVloMzL5aPs18O53ckcfJoYPKh5D4gwJ8tp8Vxi8AW4ELkJzxv0WAOis1
         LI5LNyRL7BfvftzgiKwnkukgq6O9Eb+7iI2WCbTis7xqNSuqtkjdMOpzHZqPBguYXY49
         x5VfNTAYGrruogZV2WNmBDxPxPgOjpoNxLVNWiQgy0q6bwQx16prx8ZM/FONJewcIpvH
         dKgA==
X-Gm-Message-State: AOJu0YyEOcwFCKJVvGfLwvDcLKHxU3E95FU9yo1c2aK8OjHVBVpiJ2YR
	IW8CwTmXEuakQiTk72372O8xEbDwREHUqzwEctCwVSM2g6eutQw/UqXOt1DTp5A=
X-Google-Smtp-Source: AGHT+IF8fPlofNM3xtw2nAeVLJ+IgVn5ykURJ/o7/CYLz7Hg0z+zhogY5kuMpOzvZ4s66HPhp/8/4A==
X-Received: by 2002:a17:907:d3c9:b0:a7a:b643:654f with SMTP id a640c23a62f3a-a839292f3ccmr697609166b.15.1724052338873;
        Mon, 19 Aug 2024 00:25:38 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396c695sm594046366b.201.2024.08.19.00.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 00:25:38 -0700 (PDT)
Message-ID: <a8ebc617-dc20-4803-9332-246d54ccf8d8@blackwall.org>
Date: Mon, 19 Aug 2024 10:25:37 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/4] bonding: fix null pointer deref in
 bond_ipsec_offload_ok
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
 davem@davemloft.net, jv@jvosburgh.net, andy@greyhouse.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jarod@redhat.com
References: <20240816114813.326645-1-razor@blackwall.org>
 <20240816114813.326645-3-razor@blackwall.org> <ZsKzmpnXsKLAneIe@Laptop-X1>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZsKzmpnXsKLAneIe@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/08/2024 05:53, Hangbin Liu wrote:
> On Fri, Aug 16, 2024 at 02:48:11PM +0300, Nikolay Aleksandrov wrote:
>> We must check if there is an active slave before dereferencing the pointer.
>>
>> Fixes: 18cb261afd7b ("bonding: support hardware encryption offload to slaves")
>> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
>> ---
>>  drivers/net/bonding/bond_main.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>> index 85b5868deeea..65ddb71eebcd 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -604,6 +604,8 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
>>  	bond = netdev_priv(bond_dev);
>>  	rcu_read_lock();
>>  	curr_active = rcu_dereference(bond->curr_active_slave);
>> +	if (!curr_active)
>> +		goto out;
>>  	real_dev = curr_active->dev;
>>  
>>  	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
>> -- 
>> 2.44.0
>>
> 
> BTW, the bond_ipsec_offload_ok() only checks !xs->xso.real_dev, should we also
> add WARN_ON(xs->xso.real_dev != slave->dev) checking?
> 
> Thanks
> Hangbin

We could, but not a warn_on() because I bet it can be easily triggered
by changing the active slave in parallel. real_dev is read without a
lock here so we cannot guarantee a sane state if policies are changed
under us. I think the callback should handle it by checking that the
new device doesn't have the policy setup yet, because the case happens
when an active slave changes which means policies are about to be
installed on the new one.

Cheers,
 Nik


