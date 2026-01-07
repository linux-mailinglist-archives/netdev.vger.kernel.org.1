Return-Path: <netdev+bounces-247606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB7ECFC45D
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 08:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64B943017850
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 07:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956751A0BD0;
	Wed,  7 Jan 2026 07:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="fxR5tmCs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A4F18C008
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 07:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767769387; cv=none; b=GM0HWQncJHs0Ba5uFj+1uc7QLhDbJon2wBWrCEnzcHzaboosisZG6tivtsircVnHM/rSj5VUieovpml8vY2Fe+yQM/74QmoZRGMotsnYZUI/utCCucqY9U0DNJSxpW4056TiksC4VKvJYlWx0U5mZTqJtyUmjsUVIgmt61p2Fx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767769387; c=relaxed/simple;
	bh=f5KQClzdkISt8MA/o0aAgcqO+l1HBxpxp+8Kat+ePuU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cdiBH1JLFe5wBNkxz8VMVnFBOtY/BouCRuk157kMr2ZtxIz1IOBHA1jqEi/nqrJkVNPmdC3jyuZT/e+qk9HK7bb3nlObw4E0cVLAmr+XpRL/zM5/usikUknywJbIDvGI61xCIwuZYlrwuyqzL2F2wrF+6RuSFrBp2Y2r/9+4feA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=fxR5tmCs; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47d1d8a49f5so11262685e9.3
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 23:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1767769384; x=1768374184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nAh5k++gnHaZeYrAcDXrBPA+w2UfA/thEoEjkR6fMmw=;
        b=fxR5tmCsuJ57DZZv9qHycLKIg0rILOTzKGnSrkQp4GlK3k0xzrD0FpOpmEeOnC6mSE
         x+wCy1+kzXzsrXObeUAZVAyIUfFWnQVRWlQJQA3/PKshNOXbQLjBwZ/u4/p324YoEG7H
         Yc/utmRQnWqD97n+4XyXhvMB2LIN2RBLgjA+nW3JxIerWz0F4HKFqyDaZUzrKBbv8nfO
         IGbMRIads2lSvbSedV37/LhaRerAC/J/w/GoEScYNJaru4bFFmdV7W/zhOxz8oMy7qFm
         2sLLCMK2nO1IfeyceZcn2u9l0V5Hr0kJWnthMuDejLuYCdkR5WKNGMeVMDcyzb9IxYPo
         aCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767769384; x=1768374184;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAh5k++gnHaZeYrAcDXrBPA+w2UfA/thEoEjkR6fMmw=;
        b=NicJxkr+oVA+Nn84FeLvQDKU0+M3hR1ei4XJOR+pPkTN6rr3YKU+LEvdJZ55mwdsAt
         dmERS2sYj1h11aLs8O8jNjCCVc1n1TdilmmAQPNcdKVOexVphbb5zorpoOSWCyuUsCoF
         RU26Zfhl25yeIXysf+cJa1Yv+nJyB7Yd2mgqJ9+6yVXEaAVEfm3njsbDYUmBiRZUueTG
         /3KYkZZv0RQnBXFzHA5l113Y5BGz1OmmBF0bqa6sIr24tBrUk8EYMzxu9CNfhSbmLrBj
         6wW2kQAbVGKjVW+AJiivNiyXyu71ywQe0fqWUnDxbg1c/MuO/EMsTapEBUA/SLCMLd07
         P5Jg==
X-Forwarded-Encrypted: i=1; AJvYcCX5SYg2ixPzfx41ZC9OZW464qLSul0l51mPwjPOXo53UsdSTz2zGg18H3HORL4jzBfnEUDtR+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUa0ualmsYEf0nTH3l0MohhUxo9xOb749I2XWDWKxCzsnB76yv
	17uxZxyb3N3zXvt6hqM2u549pdbyUA3+c2YJKWAWpAQbFX1BIQUnExyStG8Z3Kcg31g=
X-Gm-Gg: AY/fxX7moebmHS3+8rQEKL8BLuDgAGhp58qM+JQpuDwK1VpWOn6yA4hv82BsQapMSNj
	opEtHVVKvqRqikuUys9jzb1mQTZuH/mkPhQTULkfwoUbrObRJclXCEJRytwuMIoHdhSzX0Y6VCe
	o79t9EhV8qgd9etDLstCsRJ+ooVdSuvtjY4G95emAvNVQ2XuQntMXQVA/WHZ8r6mON79cBgAw97
	9PGnJWdwdA6FTzgJ8voZvnb+zbg3RrP9YmrGC1mUean6SVp8B1ZVaRUvWV8Vdl2Pl6yfVXmSQyi
	mSAaKURePuAhdgjb+P/52AxblkTZ7P2LBEXrRDk6xia9UEOMIFi3jCYwqfiNgBTnqCSLm4awFHX
	77cpdMJNjqrJPcC4vgQY51grIEBa5USsYgMVe395qp4IHILwMp3P0NSFbl9wEY8ucDJWInt5yEL
	UCCdRO41KJ9KQlH4FVFDe+1RJ0wIrXGhCAvZDB6cD8mdT4O7UkuurrbGhEttHN66vh6DkEHA==
X-Google-Smtp-Source: AGHT+IFEd6rnJkyS2OuN22aWa07ho5A5/jUuAjBvoajuVegltCFuo3vr18sw5wD1QBQBB6r8kwgmzA==
X-Received: by 2002:a05:600c:1d14:b0:477:9a28:b0a4 with SMTP id 5b1f17b1804b1-47d849c7aa8mr13363945e9.0.1767769383129;
        Tue, 06 Jan 2026 23:03:03 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8702534dsm5285845e9.2.2026.01.06.23.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 23:03:02 -0800 (PST)
Message-ID: <5452a132-448c-43db-b6f2-53f0f207dc67@blackwall.org>
Date: Wed, 7 Jan 2026 09:03:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: annotate data-race in br_fdb_update()
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260106194022.2133543-1-edumazet@google.com>
 <f3bf9a76-c110-481a-a89a-c54d5856cfe3@blackwall.org>
 <6a7cb6d7-b337-4b21-b236-5419b785dc90@blackwall.org>
Content-Language: en-US
In-Reply-To: <6a7cb6d7-b337-4b21-b236-5419b785dc90@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/01/2026 09:00, Nikolay Aleksandrov wrote:
> On 06/01/2026 23:26, Nikolay Aleksandrov wrote:
>> On 06/01/2026 21:40, Eric Dumazet wrote:
>>> fdb->updated is read and written locklessly.
>>>
>>> Add READ_ONCE()/WRITE_ONCE() annotations.
>>>
>>> Fixes: 31cbc39b6344 ("net: bridge: add option to allow activity 
>>> notifications for any fdb entries")
>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>>> Cc: Nikolay Aleksandrov <razor@blackwall.org>
>>> ---
>>>   net/bridge/br_fdb.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
>>> index 
>>> 58d22e2b85fc3551bd5aec9c20296ddfcecaa040..e7bd20f0e8d6b7b24aef43d7bed34adf171c34a8 100644
>>> --- a/net/bridge/br_fdb.c
>>> +++ b/net/bridge/br_fdb.c
>>> @@ -1002,8 +1002,8 @@ void br_fdb_update(struct net_bridge *br, 
>>> struct net_bridge_port *source,
>>>               unsigned long now = jiffies;
>>>               bool fdb_modified = false;
>>> -            if (now != fdb->updated) {
>>> -                fdb->updated = now;
>>> +            if (now != READ_ONCE(fdb->updated)) {
>>> +                WRITE_ONCE(fdb->updated, now);
>>>                   fdb_modified = __fdb_mark_active(fdb);
>>>               }
>>
>> Thanks,
>> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
> 
> Actually on second thought, ->updated is used lockless in a few more
> places, e.g. br_fdb_fillbuf(), fdb_fill_info(), br_fdb_cleanup().
> 

I mean I see the subject, but since this patch will get backported
perhaps we can annotate all instances in one go.

Cheers,
  Nik


