Return-Path: <netdev+bounces-68874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEBD8489BD
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 00:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30661F23A6C
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 23:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635E71078B;
	Sat,  3 Feb 2024 23:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrDghqiU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C2D13AC2
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 23:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707001564; cv=none; b=YldQq5ZRfGJ28ZgoZKN3wX8jRBH7SEWLAggoK2uk3ozWByWjcs6UrBHCrVg/fb6xWlODX/1RhVH4TwkTjwx3FIZaYPOuPttpCsEpDjs7bWx9hPtDB4MucFhDy7dPZBpwCxlbel20HoP0ZJVr2WmRwVbY4JVfxJ8OlaUlX3AU3LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707001564; c=relaxed/simple;
	bh=qwfGeC4IDFJLFMs8uSy96FkChZLCP5xJkv7afYOYIgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dl+/fmuONMgOnOetyzgvqGFjamo5jHRWdxG8DgMMs2O1PeBqntLTWwveXRbdtVyhQDBzGCCq8p7qTktQ2YARVD64r89uLs9whSw1rIvHflvwn17FjDjEwlm7f/bIziu3q/kKuuAqcc3ywgsBQq6Z1hIWEd6Nx4wenjvuzjiRTOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrDghqiU; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56003c97d98so1567270a12.3
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 15:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707001561; x=1707606361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fRrGLc2WDTZE9U41Zrs2MIdg9O5K5Kb8o7zDkfbGDaY=;
        b=FrDghqiUG6NYSofpNSkdrpBxq0SD4tEHIFGnWwu/fjxoInkz7GtiRhXK7XB4IYHSq5
         R8Ls8UKZjLxKfVI+xYGZNl6hfNeYzI/7EuxOtlJ7ZdMFqfq905YmghBfnX7noM0GWmcm
         ITToR+eiQBpEHaAWyMZNdhCT/6TcUOyXA0FQevm8Q0uOEJY1oC4RWx99KMbqH9S//pH6
         v+klqznlaa6pomBU/CBlyQEneqbbp3dOSt/WPA4idr2q0B3dwh8pUfOn+h5uxxekKtK+
         7gHIiCLCf03j+Re2VES3VDURv2LujExoMPUzpvRiPEUragSbuyDe5oGfzFnc2joiZpG3
         XmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707001561; x=1707606361;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRrGLc2WDTZE9U41Zrs2MIdg9O5K5Kb8o7zDkfbGDaY=;
        b=rbmP1WVibvpxH6nqosb+UI5Z305FmJr2BLeRG/jwowz3IcXxNlUDWybWwCN4iEPKuu
         2rD22VVOwlQMkqm0Rx+VW3ZbwSTMdLXV+aHPglZlgdMsq+NpgicPhlMShh0qZqykBIsH
         vFLwk3B8p1xBeHyXTg69x0Y1f3vwzaUdDPk7hWQgT10eitK3zHoOlpmS++Krkf088TvL
         tBy4y/9bVCh3oPHDtkpX1dznCRtPdKCI6rb1TJOeY6STVPF0xCsWUjUbTJZsmHpqnOuH
         F/ZE8WhqcXJ217oCiz15KzoVuMJ9az5RJkuDYctxW0SCZNcCSdwleX/DVwkemXBXGYu8
         Rgig==
X-Gm-Message-State: AOJu0Yz1zxFUrdehrgRXs41+OP6C90+quQ7f6uSU6gLOmrGZlZ0zTHqT
	G5nOc6k06qc+5BO/l3+R1XZ8qSxRCy5AWQdA+4VeTLHgLPdSYWQY
X-Google-Smtp-Source: AGHT+IGJb+4xjbjz2d9+2Rme5OsKuCElGdzWG5yxY2L3k/oRF7ov1xDwrif3DJMPh//BE3i+RnGN2Q==
X-Received: by 2002:a17:907:7851:b0:a37:1a8d:dfc1 with SMTP id lb17-20020a170907785100b00a371a8ddfc1mr3654562ejc.70.1707001560529;
        Sat, 03 Feb 2024 15:06:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXIIixLyjHJotp8bbDV16QA9p/BICXZwcVYHzM/PILAUhLTt86l22y024ax+xOaELki1dl8LlqVu8pVzxex6DLoALSnpGT+N+6zBAjpKlVs1K92xfK//wrF92N3yd5UC4s8ZL7jgFx8RO3gYVw+Yn1N7sDNRgiyaJM85Y0wOy275O+dJExo0p7ZKC8ImyR6VNVro5NUsm0BFqB6ZqxUChY+zIY3torMwANZ8EtxL85aJ+O/8rrB
Received: from ?IPV6:2a01:c23:bde4:a000:48dd:a4bf:88d3:e6ac? (dynamic-2a01-0c23-bde4-a000-48dd-a4bf-88d3-e6ac.c23.pool.telefonica.de. [2a01:c23:bde4:a000:48dd:a4bf:88d3:e6ac])
        by smtp.googlemail.com with ESMTPSA id s14-20020a17090699ce00b00a36c6b0485asm2452597ejn.103.2024.02.03.15.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 15:06:00 -0800 (PST)
Message-ID: <4d6e5d5d-66b4-4d7c-91b7-ac7aea30d5f9@gmail.com>
Date: Sun, 4 Feb 2024 00:05:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bnxt: convert EEE handling to use linkmode
 bitmaps
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Michael Chan <michael.chan@broadcom.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <10510abd-ac26-42d0-8222-8b01fe9b8059@gmail.com>
 <e65b8525-eae0-4143-aa57-009b47f09005@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <e65b8525-eae0-4143-aa57-009b47f09005@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03.02.2024 22:59, Andrew Lunn wrote:
>> -	if (!edata->advertised_u32) {
>> -		edata->advertised_u32 = advertising & eee->supported_u32;
>> -	} else if (edata->advertised_u32 & ~advertising) {
>> -		netdev_warn(dev, "EEE advertised %x must be a subset of autoneg advertised speeds %x\n",
>> -			    edata->advertised_u32, advertising);
> 
> That warning text looks wrong. I think it should be
> 
> EEE advertised %x must be a subset of autoneg supported speeds %x
> 
> and it should print eee->supported, not advertising.
> 
> Lets leave that to Broadcom to fix.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
I just saw that I overlooked needed conversions, will send a v2.

>     Andrew
Heiner

