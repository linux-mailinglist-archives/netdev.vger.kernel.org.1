Return-Path: <netdev+bounces-170246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35671A47F30
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989FE3A53F2
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 13:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B3D22F397;
	Thu, 27 Feb 2025 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ihRs/256"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D068A224246
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663067; cv=none; b=dtMzOIjxS8ZPzxIDlRUBvunKBZujA/tfppjhqrX1NhuoOsuVjjY2ZcsPJbsrmx1Ea2AqJ+daalYG728URH6gkq4lNREwFi0onCuhYIA5IxstGvDu9g/VcXGHJAODhxhIB+Lf6ufGTHcKO5Ksxdzt6V5MqjaiGE8mNFowNLEDr8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663067; c=relaxed/simple;
	bh=5K1DQgpCnV8OGVSz6GIqpEfTt8kjItGXwWAZ4X3AWLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qm73SVt5p92s8OamMee4cPaUer8Ws2Vf46Xk+tHCWxNFbsOQ41TN3mh/EkxFTq5reVcVREc6ZmD7OevJKV/sVzE7k3geJJctKV7ermRs3Vr0Xr0NXoDR0PlvQc03WtRMbp/08BUrh6rnxreL5zP9qGAQax/quj1fxASRgtlSqoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=ihRs/256; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abb892fe379so139527266b.0
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 05:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1740663064; x=1741267864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7wXFTKX1544/JIF02ehdLe2SrnajJcR6+uQqWAAhPPY=;
        b=ihRs/256BSg5Z5Cbra1h9RobjQnf2t4kdPCyir05PZiMdHHq2oLTr9+YSTW2Uxs6a/
         gprp/a+hdm2GYPbvkQZbSPKMOJ208igladzRPsXOF/+5oE6KnU+hy3oNqQ4Fo5stVxOX
         UsEB92c8vXgcvgnlTbuKBOgiJidholdphkNBvweODGLqY9EkSzUx/Cbl/jGWqcSbafWy
         iI2HFPvWEJXsEBGDS7v3+20X1//GKO7PokvUK11CmDnJB+rjSkNEk3ehgUg2iBRlZnHT
         qLTnjIhXJYAAhMueyiZeni/wQoSlXZDOX7ordoirjSy3tCOCyHvjxouD4XgyY6lvWgy/
         ZEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740663064; x=1741267864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wXFTKX1544/JIF02ehdLe2SrnajJcR6+uQqWAAhPPY=;
        b=A0/CUrwfCkGGfPxZsUzsh3YwNdrcDl2VHU9vJiiU7oXfzHbnynpTh0Rl889uTUBAO8
         wIqLhBZmTveajeF8mSk2vsRXgGEykwghAwsc1gziT8PbDn+TRn1fmcKOh1koY7la9VCh
         x1hcTwfocgReOvGkmvmABD9N/KBuolAM16fdLlgF9iLk2+dTpyL5mf/in2aHpwin5ADi
         l5CidLDwoSDjEETgEyomVqI2FCzty3NG1MWcuvFt1Sobt7RyiKeMf+U+Sd4rLenyDNW/
         m1bdWhhbiy8SxBQjpUQ8bIlCBkRYtBkaOcSsCibr4vuv2J9mIQaYkXOJdGq9dfj0UPRw
         ZxUA==
X-Gm-Message-State: AOJu0YzwFsd0iLlSiz6sTgDvzyiruySicxDqF86U1hKsZDiYYV0fy2bn
	wr5D5v/K12dc2VLE1/CK+9KEtUfu10HVkqRqw1qTax1dWgZzZUyZByOhvuf2OPM=
X-Gm-Gg: ASbGncvexU9kvPzcimG3eoDfV4H/ZqNxLubII5ttfi2MtoFJxaZeOlqExPdlmQqrxHN
	s4/S5kpQB/yDgx8zEjvBmMio/KIRus326fLRXqIRTBuQF/CwatQbxANXtPHrdHWtTSjIdaR4WHy
	r/tQ4PRPhL0eCVAexY56Msuvz0VKAxg1UISOYxqUiwRRRlSCXzmJU+wREZ5vm/k+zvX5vJ2bMLE
	ROaSA2nGB9ConlK5RDhc4rofjbE+n3JoGMoJ/ATHB64p89vUIOqBbgld7RlNF9YutDc322CU5cR
	/QPQxx0bRmEa724/UHQ+u+ysLd/E3SVKiqAT2eu15ta1ZblM95FvcoLcCQ==
X-Google-Smtp-Source: AGHT+IE0aNnzvv1Qi4koQK1Hzo4GjpUtdykg2u0L4Pn0RkAUHo9vRWuUm6DYMvxfLSo0bViwlkQMRQ==
X-Received: by 2002:a05:6402:2553:b0:5de:594d:e9aa with SMTP id 4fb4d7f45d1cf-5e4455c30f9mr28084142a12.8.1740663063527;
        Thu, 27 Feb 2025 05:31:03 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0b86e84csm125023766b.0.2025.02.27.05.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 05:31:03 -0800 (PST)
Message-ID: <f88b234a-37ec-46a4-b920-35f598ab6c38@blackwall.org>
Date: Thu, 27 Feb 2025 15:31:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net 1/3] bonding: move IPsec deletion to
 bond_ipsec_free_sa
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Jarod Wilson <jarod@redhat.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250227083717.4307-1-liuhangbin@gmail.com>
 <20250227083717.4307-2-liuhangbin@gmail.com>
 <446e8ef4-7ac0-43ad-99ff-29c21a2ee117@blackwall.org>
 <13cb4b16-51b0-4042-8435-6dac72586e55@blackwall.org>
 <Z8Bm9i9St0zzDhRZ@fedora>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <Z8Bm9i9St0zzDhRZ@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/25 15:21, Hangbin Liu wrote:
> On Thu, Feb 27, 2025 at 11:21:51AM +0200, Nikolay Aleksandrov wrote:
>>>> @@ -617,6 +611,12 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
>>>>  
>>>>  	mutex_lock(&bond->ipsec_lock);
>>>>  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
>>>> +		if (ipsec->xs->km.state == XFRM_STATE_DEAD) {
>>>> +			list_del(&ipsec->list);
>>>
>>> To be able to do this here, you'll have to use list_for_each_entry_safe().
>>>
>>
>> One more thing - note I'm not an xfrm expert by far but it seems to me here you have
>> to also call  xdo_dev_state_free() with the old active slave dev otherwise that will
>> never get called with the original real_dev after the switch to a new
>> active slave (or more accurately it might if the GC runs between the switching
>> but it is a race), care must be taken wrt sequence of events because the XFRM
> 
> Can we just call xs->xso.real_dev->xfrmdev_ops->xdo_dev_state_free(xs)
> no matter xs->xso.real_dev == real_dev or not? I'm afraid calling
> xdo_dev_state_free() every where may make us lot more easily.
> 

You'd have to check all drivers that implement the callback to answer that and even then
I'd stick to the canonical way of how it's done in xfrm and make the bond just passthrough.
Any other games become dangerous and new code will have to be carefully reviewed every
time, calling another device's free_sa when it wasn't added before doesn't sound good.

>> GC may be running in parallel which probably means that in bond_ipsec_free_sa()
>> you'll have to take the mutex before calling xdo_dev_state_free() and check
>> if the entry is still linked in the bond's ipsec list before calling the free_sa
>> callback, if it isn't then del_sa_all got to it before the GC and there's nothing
>> to do if it also called the dev's free_sa callback. The check for real_dev doesn't
>> seem enough to protect against this race.
> 
> I agree that we need to take the mutex before calling xdo_dev_state_free()
> in bond_ipsec_free_sa(). Do you think if this is enough? I'm a bit lot here.
> 
> Thanks
> Hangbin

Well, the race is between the xfrm GC and del_sa_all, in bond's free_sa if you
walk the list under the mutex before calling real_dev's free callback and
don't find the current element that's being freed in free_sa then it was
cleaned up by del_sa_all, otherwise del_sa_all is waiting to walk that
list and clean the entries. I think it should be fine as long as free_sa
was called once with the proper device.




