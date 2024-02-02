Return-Path: <netdev+bounces-68716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D081E847A88
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 21:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3433B2234C
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 20:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2136C18050;
	Fri,  2 Feb 2024 20:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fs8tR0sm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A8018021
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 20:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906191; cv=none; b=HPY/UYLtX+2vZfBFI+v2YxOaqN5pQ+bp/0CGinEpWJt3qvqiLw0CUPOgfx6XuSd+jAyMxsFFygY5YeZktGpKeBskkbbKcdoSsyrUGZaVO7b21DRszIL/PTlX7o8uTEkMjkusUxdDPrWEj2/JbOOIqMLJkeNJcSW0KkDPEzhvLfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906191; c=relaxed/simple;
	bh=rL1lW4km98gq7/oS28Zo1duG7JsTMe58RiLskUB9Pa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g5FxA4Hv25UpkFXwyW7+6YKabJBsDVPapvtysXSXK6j7GD7rMNa9qgduT8OpxcquZZYQCJziF9r12BulH/DZq3OScJbZmONh9WghtrWlco6+sA/JMNi0WY+uQVuaXY3RKMB9rwWo5iO6w0hHwXtWIjcE14yvgnUp78v28Na3CmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fs8tR0sm; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55ff4dbe6a8so1378232a12.2
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 12:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706906188; x=1707510988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2py5wM6kwhov6R9mcaN5/uUzV3lruDwhhxoZ88sAVk8=;
        b=Fs8tR0smH+yGEEItI9DmBrgsOR2kQEL4vgkf0mr0ZZ/Kr/WeYXzof12krOsTuUKSmY
         EK1/Esy83uAUCfJlVxzhHhEw0NmdnSkm6jsjTU5Y/nTUHnmo4T3YVlKU7rMWvcTvTheo
         RYGVBQ4KnBV2k9DVOHvtG6ZUa5Q835W1UeCNmlSKZgwp4ALQh6jai9XLt037KRRYMV5F
         acjg5avXkrpV7fmLeFBWixvPIhFuduMnmjDa2UbORDf7duFuaHZQLych2uxj0TiWKtNM
         murZR6SuA3rx1+yq5KIZ23ohYiFif+Ak03iHqRj0crqHLCJVVNEL7ovzwMMPG0MiQRDJ
         jwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706906188; x=1707510988;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2py5wM6kwhov6R9mcaN5/uUzV3lruDwhhxoZ88sAVk8=;
        b=iwcF1CObvrI9nhPmoPJ++4E5BEvW49nXNvNxdtozpTzN01eXo6tVII1tfLIYjPsUtY
         SAasib5a2Y5EkA+wItB/C3Qo1ydub1CVIrfA4Z8mP8HU+lslmYfy3qW+qVay/gYunHEM
         JbJ9iDhJLwsJhpZEbN+uVBOb4bzN3Dvukp5OQO5/7D4r3Lrkkzt0ON1GAV0Vf0fxb9XR
         lk1hv27sq7Xv1YuOWyX1Q4i8ni/JXHK9OGBhtVKM8tdMsMo74GWpdmW3Zjha1Xs+4EEv
         9OPAoh0/GPiQO66tJB4K6VVVMekmvFRJ9tNxW5F9bP4hn2067qd5LRLI+r05J/zvIyVa
         m/iw==
X-Forwarded-Encrypted: i=0; AJvYcCX6SLkJWZcIXGjZ8P8dp+QpMDblHEYXkcqja2YTXh9//dAn1DNJ7OVbHP9Stju3pr60gJo2Ps8YVEKP/L9JhSYRQmZfrHlT
X-Gm-Message-State: AOJu0YxVZLYVROxiCtKBGtXvPzZjFruNI+wDi3El4I/uJuHQhDc77kMp
	gjnu6xW/N00OTCUEiDhiVbFZMt4k80b/N4GKIu1lZoDHW4bqf9xb
X-Google-Smtp-Source: AGHT+IFqmIKhO5ihTlUrf8OfxxByY5UlYrHar9c1cGaomRFVd1s7+EOI5BmJp7cjq4SWRQJuIWS+YQ==
X-Received: by 2002:a50:ed97:0:b0:55e:aca4:aab2 with SMTP id h23-20020a50ed97000000b0055eaca4aab2mr503197edr.19.1706906187422;
        Fri, 02 Feb 2024 12:36:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV3MN6SFpyegKdxX9zBNddpyYu5NF1tDo+xPRn7Qgp8ai4z7orAkPyeqLJgTK2JcXRkfy+VLS6Piy6sTPYqF527xiQlDaXyA29pPnvwt5vA7dUtI0D60pUEK0eSoXuaTh7McOIrRTCX/BTKQDGMd7V7m43p3eRW/dStlAeFzw7v6NmMNcuHA74v7ki+Bq+0uPkuQ6cG6PWzrqc=
Received: from ?IPV6:2a01:c22:7392:d000:2834:713e:737c:78c3? (dynamic-2a01-0c22-7392-d000-2834-713e-737c-78c3.c22.pool.telefonica.de. [2a01:c22:7392:d000:2834:713e:737c:78c3])
        by smtp.googlemail.com with ESMTPSA id cq21-20020a056402221500b0056011a877dasm154178edb.29.2024.02.02.12.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 12:36:27 -0800 (PST)
Message-ID: <6b89ec8a-230b-43f2-a7d4-d9f4fd4520de@gmail.com>
Date: Fri, 2 Feb 2024 21:36:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESUBMIT net-next] r8169: simplify EEE handling
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <27c336a8-ea47-483d-815b-02c45ae41da2@gmail.com>
 <d5d18109-e882-43cd-b0e5-a91ffffa7fed@lunn.ch>
 <be436811-af21-4c8e-9298-69706e6895df@gmail.com>
 <219c3309-e676-48e0-9a24-e03332b7b7b4@lunn.ch>
 <7122d90b-cdfe-4733-bfad-45ce63f75536@gmail.com>
 <20240202081511.3d4374f4@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240202081511.3d4374f4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02.02.2024 17:15, Jakub Kicinski wrote:
> On Fri, 2 Feb 2024 17:06:10 +0100 Heiner Kallweit wrote:
>>>> Alternative would be to change phy_advertise_supported(), but this may
>>>> impact systems with PHY's with EEE flaws.  
>>>
>>> If i remember correctly, there was some worry enabling EEE by default
>>> could upset some low latency use cases, PTP accuracy etc. So lets
>>> leave it as it is. Maybe a helper would be useful
>>> phy_advertise_eee_all() with a comment about why it could be used.
>>>   
>> Yes, I think that's the way to go.
>> To minimize efforts I'd like to keep this patch here as it is, then I'll
>> add the helper and change this place in r8169 to use the new helper.
> 
> Sorry for being slow - on top or as v2? :)

I'll do it on top.

