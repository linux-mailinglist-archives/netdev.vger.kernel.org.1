Return-Path: <netdev+bounces-231114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 235D6BF5589
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 10:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9E3AD351588
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 08:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025D4328B4D;
	Tue, 21 Oct 2025 08:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmIDUXCW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6D2324B21
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 08:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761036391; cv=none; b=Fo2LPvA8piQK+cFDaBVjWiNWPD8vDkXR3/X0VSr8pxAgwv4kvr+4/H+8T4HP88To4alGW+LT+pJXiCFjsv+L2lqz1R/5QOeCpIPkXcO6aE84/vA6zMB6w9X3GGbqBDbzKvNVohvgXoqv/Cjhkh+v/LH2/SFpOoe+FGFieBiy58s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761036391; c=relaxed/simple;
	bh=TpzzFfcks+i/8NbAyOtY67RjKecMIpCXc/ht890k5AA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jkhp/oEASjfxp45CbN8iRuX+SIyFlDqmXKexRSLSZJyF/ZoDeJbqghdpofkP+CeQjahnzudPRwNuWvr+fFwcmKSwMgFX+QBkzDVNODWbbn1kcJU92ZEzajqKkprxYX8FVP2i63A1aZn3poOS87bRa7wJX+21TyCMI5DcFCzOBs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QmIDUXCW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761036388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00fUrBf0Q4px2FT8LQcfYm3XMw7xBPoyqZCdVsDVhGA=;
	b=QmIDUXCWxliNH46pBcXQ50QsRTzfO4BA800tENTgKXw9FOLrRwiDYJ6GIHV1sH8tlM7yQX
	f34QeMafsSkW4pQr6kwzzgRXasxKPOw5Oa0ZQ6mXqCsnZUQIFnmOw2WcEPsEFIyWRfAF/r
	aTlEfzKwRK5vRv3zvjoPAwz+kD3ucgk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-eLY_59DYOfeY23O-h_mLoA-1; Tue, 21 Oct 2025 04:46:26 -0400
X-MC-Unique: eLY_59DYOfeY23O-h_mLoA-1
X-Mimecast-MFC-AGG-ID: eLY_59DYOfeY23O-h_mLoA_1761036386
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47113dfdd20so16682965e9.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 01:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761036385; x=1761641185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00fUrBf0Q4px2FT8LQcfYm3XMw7xBPoyqZCdVsDVhGA=;
        b=qQQx+d5A+CCclL2QsD8iZeQT7VfSEojwXgBukeeJY6HtnbUKgNP+n48lIe0hP1xgyy
         c++UOraSFlfXIzhYTyguAcOkc7Mb8R3lnQiwjVMOUAQM+w4z8WB17Pw4DiYd5YUjVy3M
         sz5U5AO8YJl23WoqomLzGOvUdyD3rJ37dLqAvevbInfePhnrcaJOpROn/peRRMeLyVOP
         oBoOyyh3PKKIjN4e4cBwh/CchnA7X7bOjsz3BXlgQNd6W8d1mD/dasmYWpsQMQwe0ZOO
         PxO0dhNY4Ms42yHFSghHBHXtyeVbLuS3I+FQ2xVgbzjCBvDR6rp+CEbx+Rq1gJl7Uua9
         c8TQ==
X-Gm-Message-State: AOJu0Yw2qFbJmXwZJjT8u5C9LSB59i4CaU67CkdbwxQMQRxkoHeZluRx
	A/iq0thbloFIWmYxJpy9pIEsf2O6WLTcORG3E3yBu7bbSuxZ471tPuCXMYiC6V7kqZcPFKOe6F4
	rk7iUz+GEkxezYT4Y6SqEqxWzI11fvP41vV8ow4YcjxsezJFIoA2mgpyNTw==
X-Gm-Gg: ASbGncucxHoPFKFDXVcs2Hm6OpOS5HYK1BWFZPvYOGhgPK6xDeSHygKlclhiQX4Xr/J
	CRfTABAhfuQQdj3JDxon0bJWJptOTWSvouB/A/sghfjS0s4xFq9yNVjT5eM5MM9q7dqbnWH+t99
	De8qNzN1ExE3f9/OMHpJOOl052s2+FQykxk5ahmiQQ7GJyvw6NNfwVqdsXy2C8k9Tc+VSM+jx0N
	6iQXzjuVTH2Eq9mTr25w4eEUNAm8jCeuwHtpmddYWSgx9VWV/1iby2h88qCtAxy9Z6gX6JkjOG2
	eb8xkAay5gaC+f4x7VqKBhvPsTsGL2VEkGZJtw4cCghWGiuhq3CEs54zcpPxCmcu8aXalTotWmr
	EIv16vYx6EUlEwe6qdzbetEjEDEh0Mp7JaG3vwaUmsyW9UMM=
X-Received: by 2002:a05:600c:870e:b0:46e:37a7:48d1 with SMTP id 5b1f17b1804b1-4711791f94dmr149275775e9.34.1761036385506;
        Tue, 21 Oct 2025 01:46:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER23LbhF/waeMFxIZ3tVMBTzNNjsK3AFz1Qz2WEJLL+1IU3R8oWYr1yCKAHDnzB9vrI2gn0Q==
X-Received: by 2002:a05:600c:870e:b0:46e:37a7:48d1 with SMTP id 5b1f17b1804b1-4711791f94dmr149275465e9.34.1761036385083;
        Tue, 21 Oct 2025 01:46:25 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47154d382d8sm189481805e9.12.2025.10.21.01.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 01:46:24 -0700 (PDT)
Message-ID: <a2e85a2b-58b0-4460-ae7a-b1ea01e4d7e4@redhat.com>
Date: Tue, 21 Oct 2025 10:46:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 net-next 1/4] net: add a common function to compute
 features for upper devices
To: Sabrina Dubroca <sd@queasysnail.net>, Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Stanislav Fomichev <stfomichev@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, bridge@lists.linux.dev
References: <20251017034155.61990-1-liuhangbin@gmail.com>
 <20251017034155.61990-2-liuhangbin@gmail.com> <aPX8di8QX96JvIZY@krikkit>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aPX8di8QX96JvIZY@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 11:10 AM, Sabrina Dubroca wrote:
> 2025-10-17, 03:41:52 +0000, Hangbin Liu wrote:
>> Some high level software drivers need to compute features from lower
>> devices. But each has their own implementations and may lost some
>> feature compute. Let's use one common function to compute features
>> for kinds of these devices.
>>
>> The new helper uses the current bond implementation as the reference
>> one, as the latter already handles all the relevant aspects: netdev
>> features, TSO limits and dst retention.
>>
>> Suggested-by: Paolo Abeni <pabeni@redhat.com>
>> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> No objection to this patch/series, just a nit and some discussion below, so:
> 
> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
> 
> 
> [...]
>> +/**
>> + *	netdev_compute_master_upper_features - compute feature from lowers
> 
> nit: I'm slightly annoyed (that's not quite the right word, sorry)
> that we're adding a new function to "compute features" that doesn't
> touch netdev->features, but I can't come up with a better name
> (the best I got was "compute extra features" and it doesn't help).

I'm not the right person to ask a good name, and I'm ok with the current
one, but since the question is pending... what about:

netdev_{compute,update}_offloads_from_lower()

?

As it actually updates (some of) the offloads available to the (upper)
device?

>> + *	@dev: the upper device
>> + *	@update_header: whether to update upper device's header_len/headroom/tailroom
>> + *
>> + *	Recompute the upper device's feature based on all lower devices.
>> + */
>> +void netdev_compute_master_upper_features(struct net_device *dev, bool update_header)
>> +{
> [...]
>> +	netif_set_tso_max_segs(dev, tso_max_segs);
>> +	netif_set_tso_max_size(dev, tso_max_size);
>> +
>> +	netdev_change_features(dev);
> 
> Maybe a dumb idea: I'm wondering if we're doing this from the wrong
> side.
> 
> Right now we have:
> 
> [some device op] -> [this new function] -> netdev_change_features -> __netdev_update_features -> ndo_fix_features
> 
> Would it make more sense to go instead:
> 
> [some device op] -> netdev_change_features -> __netdev_update_features -> ndo_fix_features -> [this new function]
> 
> ?

Uhmmm.... this function touches a few more things beyond dev->*features,
calling it from ndo_fix_features() looks a bit out-of-scope.

/P


