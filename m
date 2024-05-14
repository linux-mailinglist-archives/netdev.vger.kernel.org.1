Return-Path: <netdev+bounces-96338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A018C53E7
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 13:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A122B1F22781
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 11:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D3513D2A9;
	Tue, 14 May 2024 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ce2oCoZZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D46A13D2A1
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686844; cv=none; b=syOsq5gLsqd/WJczsNTEuPhoNI0e95LN4i1ZQlXjHi2c7p4T+oOgY9RaI052uN+BoukU7KwPQshLNQOc2MiFQ4kJgJWMnLRSIQx6HAV08X6Xqj7a6WVEPUCBlMQHflXpudRmbJK2NPBs1sCulvviT0ICIWm7Fus8aCN/AdiZzVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686844; c=relaxed/simple;
	bh=EizvK6NiypAryqbr9puCN+NBPUhrjN24qD6765a6SHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0EQDU0uSkI0PreU9tYN5sNMH1LFmCP3SJHGgSa+cIchGKwsbm3euKhCv7v3Eek7j14DxVC2ljGtg1lqw3++Gv/dZlx7XL3Pla6eNOGWr18Pi/qccExbrQLV4NK5jfNnYWyWnUufUmb7VAYmcUyB4lIgJkVwbqEoObDehSWCX1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ce2oCoZZ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a599a298990so13408366b.2
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 04:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715686840; x=1716291640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=piVXB2tNVGCv/VoMYGVjSbvA/rEe3BaLT1WIaJUiHG8=;
        b=Ce2oCoZZTwrrX3bmR9yJNpRebUxAaSjrRQPylkmwQ1j4WNvdmjJaeaRWZWbyH8xj0w
         n978uQsBTaxdWOpu4JJl5jX04p0E8ycAYB2X3eU7fbvuuxC+k5slyCiSI/6vAvO0l9VU
         7bjWi/Sd9raOowz5K4eGFvFOssDwaToB6cJcf8SOwWC3qk0ApIxUDqDxlxi0iT1buL7A
         EVIoB9U2yToZ9h9wzs8XpfLXY/jh5H8SCUTUob3ywAYQy2UQmXoV6kQD84WJM8OQmZGL
         cuUw84loBPBMSj/wzEOYc0dOkDaERhB+IAZd5c2Zq16NdPQFtcLX+giZ9iCRTsDB/d0S
         UINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715686840; x=1716291640;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=piVXB2tNVGCv/VoMYGVjSbvA/rEe3BaLT1WIaJUiHG8=;
        b=OItcHZ4CsmZC4IGy4v4q2x9DoKR0hb9MO+yMvtTzc5+gYORAXeG2fvxMobL5mNCr+q
         EwYCw2NHt2T42vwOV+Mz9on/Onfwv6dYF9fqpG9cOMO127dLoQmPUBTnQMNDqvMEX5je
         5FHkTVhwzZkRHNWoL9mUzv6YLdLfgwCdDOqKvuvfnOIosWTAfBDyhFhuMgCI5zKw7Whu
         SKsmktUBqV0mOkYZifmniXtJsC8FWeYR1Rl7fcnaqCxyA/ST/oPAdqDXLzGMkrQSOk3J
         c5j+QAvptIvISnD0C01JjuwGq+Wx+D/93jCbDMivJcTYbxCPHeZ3HDw7zZTn8DUQr8Eh
         VpCg==
X-Forwarded-Encrypted: i=1; AJvYcCXzbWf8nRJWBefy6Jkm9ineXUJ1SGyM57tzshFjsF1PrIu/CBOBcB/4K4IPZPxz2pDCAbs8NWL6MvicLvtoqMkZY7w4b0bn
X-Gm-Message-State: AOJu0YzXcZNcAm5BDDHcVP5oTmPxOtJb+Fy4SeQzLCkzUvuvKEadG0cw
	GJ83wYxax0c9CmJuNAXX9f3rg9itH3o0JXNH0y/WInzHnFqGbob9
X-Google-Smtp-Source: AGHT+IFqIo7r3bNyKkvi+f4bT0CPT+VWAEML1LzGBab75He/6WUvSCcZkBkBjxbCPc29THZcvM8Zbg==
X-Received: by 2002:a17:906:e8d:b0:a5a:88e8:4229 with SMTP id a640c23a62f3a-a5a88e8441bmr87699166b.25.1715686840421;
        Tue, 14 May 2024 04:40:40 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9109:bf00:539:dc8b:b45e:f9bb? (dynamic-2a02-3100-9109-bf00-0539-dc8b-b45e-f9bb.310.pool.telefonica.de. [2a02:3100:9109:bf00:539:dc8b:b45e:f9bb])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a5a17b01a2esm710394566b.185.2024.05.14.04.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 04:40:40 -0700 (PDT)
Message-ID: <b2dd4c19-5846-4d67-9de9-829f0c417193@gmail.com>
Date: Tue, 14 May 2024 13:40:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: add napi_schedule_prep variant with more
 granular return value
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Ken Milmore <ken.milmore@gmail.com>
References: <6d4a0450-9be1-4d91-ba18-5e9bd750fa40@gmail.com>
 <d739aa6d-f1e0-45fa-aad8-b4a1da779b30@gmail.com>
 <CANn89iKGRuHpHJwWe3FYB9km2=V5S3g3a_-SxMmf5pkPNCUjeQ@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <CANn89iKGRuHpHJwWe3FYB9km2=V5S3g3a_-SxMmf5pkPNCUjeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14.05.2024 13:07, Eric Dumazet wrote:
> On Tue, May 14, 2024 at 8:50 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> For deciding whether to disable device interrupts, drivers may need the
>> information whether NAPIF_STATE_DISABLE or NAPIF_STATE_SCHED was set.
>> Therefore add a __napi_schedule_prep() which returns -1 in case
>> NAPIF_STATE_DISABLE was set.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
> 
> net-next is closed.
> 
This patch is a prerequisite for the other one. Therefore I don't see it
as net-next material. If it would be a standalone patch, I'd agree.

> See my feedback on the other patch.


