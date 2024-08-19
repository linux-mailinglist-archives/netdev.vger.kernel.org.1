Return-Path: <netdev+bounces-119622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 965E79565F7
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 10:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40EAB1F25D06
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 08:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8552315B546;
	Mon, 19 Aug 2024 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="K8xOYRzT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A6715CD58
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724057317; cv=none; b=RBlwo97Mun2cgzTztuhtlLddzG7A5L9X84VRjnjTXReR9vW/GiInTCR8cM+oD0t2owJznMenwp0MW45sN00z3Ayg/WxWx/4uI+ix636OM4gVh17vFMApu+yZilGx8oFhl6H7S7OC00dAylC/oISs9d4xgo6ocAw2g9BqNHGVNgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724057317; c=relaxed/simple;
	bh=QgWNdxuaXxowMM7Zad8szQ8kTHb3DEg2AE7frDExoyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tT8+te4OlzeOHjeEwOYovIMmb9nNbhbJQBlwrsAoDQuP10yd+JhCLgytgj4r29QhZI8UwFPAKzCAcsyyZb9twOefF9UAKwS62dmtrYB3HjusLl35Cr6OVZZV26QQ1+DSiWVAfYiXkbf4RlgTUIsLmJ7Ctsn4g97CxB0cP/wK2Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=K8xOYRzT; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a83597ce5beso613156266b.1
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 01:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1724057314; x=1724662114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Fg7adxtw1wHc/80Fw03H7ZBiEBIGBaYUl+MvLIdJnU=;
        b=K8xOYRzTaT5dLW4VYeKaOHoS4v82bNV33Zdh14BJ4AhKoCQw1WQaLEzC4vcXaH/9zu
         vAHcsL0pShWBAboYmZy4F1vRl2jHUS+ILmBhJ2kcP8iwyrgdbZntwtHJkWjLabiNmPrT
         BFp1x0JttFd9RuURjHrZnVt0nhlKUOsuZFxuQdiPj1KxRwGRPtWYuFIJ6SK/ALCQql3Z
         zxo+ZRYalu9dJdlq76wCq+5UtYtkF0neqiD84tT4GDfK4beMugDDya3DInXCtbEPQDKY
         BBYbIfNFWQYJ1gAFDTEN+JqzWdX/AKivuOgSTUHZQLd11A5MM2wEh9FL+M4WcQVzUrf6
         jqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724057314; x=1724662114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Fg7adxtw1wHc/80Fw03H7ZBiEBIGBaYUl+MvLIdJnU=;
        b=twSZ48qdNx4YCwlYsx9mvlaoxxoF0hMYooZVHEU59PO8MqUCVFMrwgz9zTkg3uMSFE
         lbHe0845vjbwWFa+WNwvWGcmZ5bkWmJfa7tQfVmVz8PK/WI2xFY0ysoAlqxHvgCYgYWy
         MgUOGkxIrgdvNHk4H7e96bSwYxohmqmYuuTSYBMubEbRByaw14WBEUV1rQv1mCN18iVQ
         ZnTBkXd+RRq/o/LzsJOc6HOsEw2mnjBiTJSds58mtucTW1crIJFKq+C+ldVaMqSQUj0W
         jnHMiLddGCFOku9N7culUL1RmR+P+4jS8t6vBGPgWIDTgc5Q0+Y6oWR/jelrqGy0IOE5
         h4iQ==
X-Gm-Message-State: AOJu0YzrDQ0QwHjir79D2TRFRCZhD9YkrvnOUVcl8c52XKElcvNz4V/i
	MekNK4AHVEldqyJR41tfQy1a8FHGlRFZpMCegRDUL2oi1G471xgbeHDe7Yke2o0=
X-Google-Smtp-Source: AGHT+IFPJMZp1Zs/cpJsATp7EFOjfpi5/Ke8sqnNIdnRsaYtIlkv656ev5mPGA9YjYhrj+nB4yBerw==
X-Received: by 2002:a17:907:7f15:b0:a77:f5fc:cb61 with SMTP id a640c23a62f3a-a8394afbf80mr925164666b.0.1724057313592;
        Mon, 19 Aug 2024 01:48:33 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfe4csm606490066b.89.2024.08.19.01.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 01:48:33 -0700 (PDT)
Message-ID: <b591649f-ada5-42c1-984c-7e358c0337fa@blackwall.org>
Date: Mon, 19 Aug 2024 11:48:32 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 1/3] bonding: add common function to check
 ipsec device
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <20240819075334.236334-1-liuhangbin@gmail.com>
 <20240819075334.236334-2-liuhangbin@gmail.com>
 <a60116a2-bcbd-4d0f-9cfb-7717c188e26f@blackwall.org>
 <ZsMFspiLZojq3EIO@Laptop-X1>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZsMFspiLZojq3EIO@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/08/2024 11:43, Hangbin Liu wrote:
> On Mon, Aug 19, 2024 at 11:02:14AM +0300, Nikolay Aleksandrov wrote:
>>> +static struct net_device bond_ipsec_dev(struct xfrm_state *xs)
>>> +{
>>> +	struct net_device *bond_dev = xs->xso.dev;
>>> +	struct net_device *real_dev;
>>> +	struct bonding *bond;
>>> +	struct slave *slave;
>>> +
>>> +	if (!bond_dev)
>>> +		return NULL;
>>> +
>>> +	bond = netdev_priv(bond_dev);
>>> +	slave = rcu_dereference(bond->curr_active_slave);
>>> +	real_dev = slave ? slave->dev : NULL;
>>> +
>>> +	if ((BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP) ||
>>> +	    !slave || !real_dev || !xs->xso.real_dev)
>>> +		return NULL;
>>
>> No need to check !slave again here.  !real_dev implies !slave and
>> vice-versa, if it is set then we must have had a slave.
> 
> Ah yes, I missed this.
> 

This is exactly my point about it being easier to follow if it's not all
combined in this way.

>> I prefer the more obvious way - check slave after deref and
>> bail out, similar to my fix, I think it is easier to follow the
>> code and more obvious. Although I don't feel strong about that
>> it's just a preference. :)
> 
> I don't have a inclination, I just want to check all the error and fail out.
> If we check each one separately, do you think if I should do like
> 
> 	if (!bond_dev)
> 		return NULL;
> 
> 	bond = netdev_priv(bond_dev);
> 	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
> 		return NULL;
> 
> 	slave = rcu_dereference(bond->curr_active_slave);
> 	if (!slave)
> 		return NULL;
> 

I like this, even though it's more verbose, it's also easier to follow.
The alternative I have to track all code above and then verify the
combined check below. Depending on how complex it is, might be ok.
As I said it's a preference, if you prefer the other way - I don't mind.

>>> +	WARN_ON(xs->xso.real_dev != slave->dev);
> 
> Here as you said, the WARN_ON would be triggered easily, do you think if I
> should change to pr_warn or salve_warn?
> 

I haven't verified it, but yeah. Given how these are synced, it should be something
that's limited (we're talking about packets here, we shouldn't flood the logs) and
not a WARN_ON(). We can see any mid-state while changing.

> Thanks
> Hangbin

Cheers,
 Nik


