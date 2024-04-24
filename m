Return-Path: <netdev+bounces-90844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF208B06DD
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 12:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A067D1C231DC
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 10:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA95158D9A;
	Wed, 24 Apr 2024 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Vyh5/lXo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985061E898
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953058; cv=none; b=rltxHQxO8oUkJ9F17e9hnMfAvNZoTErfs4Q+rEh9KNX53WOwXQ5XWP7YAA3mnAfJnN9EE015nAEyOEwoEQHgEM7pt9FrQE7wDXoVaOOgca+1o74+MJcdbCbyc/kp0PQmW34JmZIOKa/N77vB8uVA5g4xYxYyVXnN4NW62REPZi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953058; c=relaxed/simple;
	bh=4+JjLrbOLMMKP1sBMMLRSIqX24mfnQVHp/47WjVRhtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rjeFQ76ZoCrEHr/nr3jiKfqapiCeBSGPV982Indul8w5GkN04gXNaZQ0l7RzuTM90/tlCp6+QWY1XeMkymzbx4Et9J13mizWWXVumhf7LkRKskCA8QzCmaoN5BUko8IESS5jJql0ca2f5JkDh1Kh9NJz371Hcfg6aPeeFTDXabE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Vyh5/lXo; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d8b2389e73so80736891fa.3
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 03:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1713953055; x=1714557855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KgcVwocqP2YbLy6NL13HVtSQT66j5JozsGISUPnxO2s=;
        b=Vyh5/lXoASJd3GKyGxqb7ztlE6tY+MELtCRj0s9HXf4KO5G/L/ksMrC7fk7559GBbf
         Xcj2qWOuyLJTUd4IUCS/Jb8BsrCaO1bI8F2AyQ7CpPisVO66sw3JArLQ6G1qbjFwefT+
         0g6DhWLsyvE/bzgGRLvCe5VdDr4TuO4fnPPm+iNwuy+llDz2h/mQfE4jtOgDkJ6zP+SF
         +xDmeyE5YxMIDDnmW8ImjjqDeYXyoiT5bUzO19mGY8IrWhDNzD5e1UBxaFlEs6aOMDQr
         +g6VCc95R98QwTUSJ06xD2ucSLBZHWHcK/UhWRB81IRq8Cl7T7nHFb/egXLrCFT8T4+1
         FRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713953055; x=1714557855;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KgcVwocqP2YbLy6NL13HVtSQT66j5JozsGISUPnxO2s=;
        b=tIeAvNuidp/8HesDl1UMZZVjVTGmJiIowpNw2mMi+0VAMkcutIgMD7CfTl62cQBhUU
         F+oUAejJ2zCwNCR7N069yrqTUbdI8AC7VvAyVj7Ej/tG1bgo0VCMuw6fb1hGO+Ci3ypA
         SrcU82mAqojFKvQp2RcHRXMaF/ToCqWSx/nss8Dp0pZGHzMXqoUIUL3YK2bdVUTbIK3I
         wk4246+ZRqmN0HOnrPKQEi77W0w3KJLDbbS6eTdElyUd89A/BgURuw1rb/oD/sGSy7m8
         Up8hrSewnUnPqJ34+fmLRBmS2ZyskQzQozuRJDvOUOwPMDkWS+8SCNQmAeZKhVERVN25
         1Ziw==
X-Forwarded-Encrypted: i=1; AJvYcCV/4h4lXpgE8xhc613I3Wr0y1+a9sO1Su6Q8zn4TWoBxZlpZQQJZlXfTrh35YR7tmdHLhtDdQjxRCrCaxUGLiYVJoTdSimv
X-Gm-Message-State: AOJu0YxLxg1wHRKjDVd3j58oddjIidu2TOYKw20bGGvnqWcYNm5VOsAL
	RkyYZxsLu0fhiDNzDJwxN2hY5dcDquVTTcC/3M+kblS54GjDy+D9kAZgGbFag1g=
X-Google-Smtp-Source: AGHT+IEP24wS8u8mzc2ca3/kBXsBKQJqrYF2bPbHVmrpuug1RJhDJKKIOCpL9Tm8LQQuTpkl+XMU0A==
X-Received: by 2002:a2e:a0c8:0:b0:2d8:658e:7e9f with SMTP id f8-20020a2ea0c8000000b002d8658e7e9fmr1178086ljm.39.1713953054761;
        Wed, 24 Apr 2024 03:04:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:eaf5:c8c0:ef:8210? ([2a01:e0a:b41:c160:eaf5:c8c0:ef:8210])
        by smtp.gmail.com with ESMTPSA id d18-20020adffbd2000000b0034b2141dcb3sm6842675wrs.75.2024.04.24.03.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 03:04:13 -0700 (PDT)
Message-ID: <80f3257c-e214-41d2-8b40-b29af32310aa@6wind.com>
Date: Wed, 24 Apr 2024 12:04:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH ipsec-next v12 3/4] xfrm: Add dir validation to "in" data
 path lookup
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: antony.antony@secunet.com, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, devel@linux-ipsec.org,
 Leon Romanovsky <leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>
References: <cover.1713874887.git.antony.antony@secunet.com>
 <f7492e95b2a838f78032424a18c3509e0faacba5.1713874887.git.antony.antony@secunet.com>
 <8ac397dc-5498-493c-bcbc-926555ab60ab@6wind.com> <ZijFmMDST_ksUUnk@hog>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <ZijFmMDST_ksUUnk@hog>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 24/04/2024 à 10:40, Sabrina Dubroca a écrit :
[snip]
>>> diff --git a/Documentation/networking/xfrm_proc.rst b/Documentation/networking/xfrm_proc.rst
>>> index c237bef03fb6..b4f4d9552dea 100644
>>> --- a/Documentation/networking/xfrm_proc.rst
>>> +++ b/Documentation/networking/xfrm_proc.rst
>>> @@ -73,6 +73,9 @@ XfrmAcquireError:
>>>  XfrmFwdHdrError:
>>>  	Forward routing of a packet is not allowed
>>>
>>> +XfrmInStateDirError:
>>> +        State direction input mismatched with lookup path direction
>> It's a bit confusing because when this error occurs, the state direction is not
>> 'input'.
> 
> Agree.
> 
>> This statistic is under 'Inbound errors', so may something like this is enough:
>> 'State direction is output.'
> 
> Maybe something like:
> 
> State direction mismatch (lookup found an output state on the input path, expected input or no direction)
> 
> It's a bit verbose, but I think those extra details would help users
> understand what went wrong.
> 
Sure, it's ok for me.

