Return-Path: <netdev+bounces-67575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F583844199
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 15:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38921C2197E
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 14:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EBA80C0F;
	Wed, 31 Jan 2024 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNd0F3+O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B0D80BFA;
	Wed, 31 Jan 2024 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710586; cv=none; b=INf06ARS7w8BJYYGEdrDqiuTZM259uASc70n9CfWT4g76ZZF5QvkhZzZyQNosEniyKjVSl338yylJbpu27ptLRuXy/zxn+Jk2ml5TC/zTmrWz7QFSr2eRfxr2b+GitiVRpSG5dHBoWVfkeWQXmrE+MrM5vcr/9v8YIvSafosBTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710586; c=relaxed/simple;
	bh=qY7KJbkfKAPcrp8h/TbUufMAsBlpcUMM5A8zsbhUkYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b52jMtKCejXll6osc6OfIGfaAAffhuOq1gr4o2syxQR8BDnQsNiWQoKefsdI2en0F20g40DKQaMTA4aabRQMl7BbZNvn5aQH5A/ZvS+cdFtKITV/p91U9QxA9j3L5oY9uUtcvfT2+bMt9K7PwgBtfqhe3SoYAwObXolN3dGgAJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNd0F3+O; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a36126ee41eso289497766b.2;
        Wed, 31 Jan 2024 06:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706710583; x=1707315383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mt0Ydnsei0ZtvI0baBAGS79fnUB26TVzQGSFDRjXzxU=;
        b=jNd0F3+OgulSjL31FFf+IeYdjbUtw9sgr4wtndZmcR8iaEvXK1ML8ZVaShsjX+hR+I
         ucQMJOR/90C40dSsVYUWsEyGFU9YYgWLm3HaqoLGGygXuz02DeQsDHG9NTmrqQNcFvVb
         aykUDE/QNBzfobdldLI5024Z0EgpG3+xaj9wzdV3g9op/XviliKQ+b1qds8Lo1JLPxVy
         LpNOSmaf4hY5ai8+JNZ7X3/AQveNCKnG/+Qy3NEuC6h+t8z6qWeIMMjORpoBnuAjiU+S
         dWU3vzxjqMx6Qy8iGxf/gXQReXyndsf77ICSnEdlghMECCqcFNhdpt43VOi5Zy4NAJ3o
         X3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706710583; x=1707315383;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mt0Ydnsei0ZtvI0baBAGS79fnUB26TVzQGSFDRjXzxU=;
        b=uHDzKv2RE5E3ASSuFTrVwYLRJcVKzXTXpHbzLCJOsLoQ1eZF8SKbiS4dYjgOt3Vfgf
         VCJdW4N1ZosTiPJO3lPmvzAXOvdSp4VgXLRPYwBWMRiOC2eiCFsQXJ1hu6Ar5UxUFG5H
         27YOlvoayJFo24U7vgDeTKUyPFIMpKR+IxSqwifMKvmVf2BOd1UNExEh+vN43kTKNgz+
         aLCEz1WNnKbRv1g5WKVMkeXyNWFWXs3V/7X5Vg3kYH1TYYga7Z3kahv5fnCkv1IxKOBb
         K2J5hvFxcx9XD+8K9nryGKtoFUVwuCRqtf4uubNjdsGxs3pXPaxtX6OQVtdOI1er5F3J
         I57w==
X-Gm-Message-State: AOJu0Yywxe2Kfs0Hr6M00DzdddeKeM+6xuf40mAma2l12kw/licmz2WQ
	uKGYCz+B6Iq0HMKKw3qwHnFx0FfJulfjHv/wwIumi2Bs/ZuPjLrI
X-Google-Smtp-Source: AGHT+IEuvfGKjiVZeuBo6tpP8YoWQWU2TYwGXJ2j5we92yCj7+j0d5kgc5ITy/eBn6qliAEDtAnAJQ==
X-Received: by 2002:a17:906:4157:b0:a35:c7b8:5414 with SMTP id l23-20020a170906415700b00a35c7b85414mr1253981ejk.64.1706710582968;
        Wed, 31 Jan 2024 06:16:22 -0800 (PST)
Received: from ?IPV6:2a01:c23:b988:d300:edee:b71e:7331:fed8? (dynamic-2a01-0c23-b988-d300-edee-b71e-7331-fed8.c23.pool.telefonica.de. [2a01:c23:b988:d300:edee:b71e:7331:fed8])
        by smtp.googlemail.com with ESMTPSA id fj18-20020a1709069c9200b00a3496fa1f7fsm6257336ejc.91.2024.01.31.06.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 06:16:22 -0800 (PST)
Message-ID: <2b69548a-79c4-42ca-8202-664696164488@gmail.com>
Date: Wed, 31 Jan 2024 15:16:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] net-next is OPEN
Content-Language: en-US
To: Ido Schimmel <idosch@idosch.org>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
References: <20240122091612.3f1a3e3d@kernel.org> <ZbedgjUqh8cGGcs3@shredder>
 <ZbeeKFke4bQ_NCFd@shredder> <20240129070057.62d3f18d@kernel.org>
 <ZbfZwZrqdBieYvPi@shredder> <20240129091810.0af6b81a@kernel.org>
 <ZbpJ5s6Lcl5SS3ck@shredder>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <ZbpJ5s6Lcl5SS3ck@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31.01.2024 14:23, Ido Schimmel wrote:
> On Mon, Jan 29, 2024 at 09:18:10AM -0800, Jakub Kicinski wrote:
>> On Mon, 29 Jan 2024 19:00:49 +0200 Ido Schimmel wrote:
>>>> Installed both (from source) just in time for the
>>>> net-next-2024-01-29--15-00 run.. let's see.  
>>>
>>> Thanks!
>>>
>>> The last two tests look good now, but the first still fails. Can you
>>> share the ndisc6 version information? I tested with [1] from [2].
>>>
>>> If your copy of ndisc6 indeed works, then I might be missing some
>>> sysctl. I will be AFK tomorrow so I will look into it later this week.
>>
>> Hm. Looks like our versions match. I put the entire tools root dir up on
>> HTTP now: https://netdev-2.bots.linux.dev/tools/fs/ in case you wanna
>> fetch the exact binary, it only links with libc, it seems.
> 
> I tried with your binary and on other setups and I'm unable to reproduce
> the failure. From the test output it seems the NS is never sent. If you
> can, attaching the verbose test output might help:
> 
> ./test_bridge_neigh_suppress.sh -t neigh_suppress_ns -v
> 
> Thanks
> 
Maybe change the subject of the mail thread? At least I'm confused if I
read several times a day "net-next is OPEN".


