Return-Path: <netdev+bounces-236682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC349C3EE75
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 09:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB493B0A3E
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 08:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5346130F938;
	Fri,  7 Nov 2025 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Ka3+8ENh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBEF7494
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762503064; cv=none; b=KtLJprFyX8KNfc6zfEAq/tzNhoZae2B9vCBdv4AawcQgbGt9IWuZiaEkLq+bTUP4vMEmC1DqybAumjHLHtngGzthhpgi6t8ECiDk6l0xBbIHu3VHS/gokcTKqC6YLIOXn2A3Or4c/dj9uIljpMeKkiGYuUHV39Q5r6Y1Y5tJgg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762503064; c=relaxed/simple;
	bh=ANbBlDybzIuvOvxPQ+p/UGfcsoCYgDkuZx/uVSbPJyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8U3wr8/4kqT5qPDtsbhjQZ1YbrMelvLgXik49FX9tKVSp+tHWPTsiLSWlD396lr2Dl15K/iuOd5RS5rX6IegpyRsduUoOBODrWdOk5B4rC1XTSvRLyWK6YKeRL/Bb3hOsRRfVrEgQRmB7bOMqlpGooaMOd1Kl+BUiOsfgybvtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Ka3+8ENh; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429cbdab700so24383f8f.1
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 00:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1762503060; x=1763107860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7397pxHNAXwBohR9lc9E4FlGhR2oTpTFUMV69GMqlgM=;
        b=Ka3+8ENh5XbQ3grlpI7CuJ6NliH3K6X4imwbcbNz06EwRKvHVdyFELrpkLZhzFVwHz
         ReiC5XATDO4yWNf0wJGIg7me87HDQnfnNXRIFPvJ9XTK/rm4GDA7HJOgKTcqw3JlmjDY
         wB5j3dFv99d7ez9Poy3sPiGvHlO7BpsBvrG7bS39EgR+P5yz6cvsMMX+9SAI2lHYYSSw
         l/Fu+U7tHnnZ9j8mpMcLREh1ZZ36iYxklCQB0MC6I2t+v/jSxxIdhNq493xRlp8fzykl
         jlC1cn3yKNB0qQPtQFm7SNyZA0Q4VSUwpzwSSFIPbKXEfKdAcYtgXGbw+sQzNCWgnuGZ
         //rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762503060; x=1763107860;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7397pxHNAXwBohR9lc9E4FlGhR2oTpTFUMV69GMqlgM=;
        b=Z+FwJ0/sk+IwrXjopLURbYY9hFKNsyIxgAw38jZePcIfWfr/b+Y/jbtSHQlhy1Ufds
         3vYNaFJ0k+VQZ7HyqTEmjVSMJ2ZGl7TdFeyMPH4VuU59fm3icD2w8Bgaa1rr870m+/W+
         O4ms7xQL1Z1dgh+LaSEo37olM+llyVoRwiCSHMlgjG3R6hYH0rGCFeQ4PsFJ/UTzv11d
         9oJ4AaicRMETcVBns9UbmgvkPrsTjtukdXsg8VgCrK6mEkD8nQviZUrU7dmK5nebaLsN
         vbyyfhvivCxvNZ6aFBOTpef6hwuMSZKH0bvJoX3gu0dqLjlRoYCvHCOu2+Ye6St6OxwS
         RbyA==
X-Forwarded-Encrypted: i=1; AJvYcCUsSZg2NBGfSn/TJTPlhuDrA1g8momy9Im2RcByVfYv7wBja7LSWTSZ1ugp4rzZrKqeITE3Jms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyWAX1Zz5zv6PpK3X+t+KujLQk/3Hvqg8W7XCUWSiubtTMPF0/
	s+yK2woUOONTMGLP7tml7amGqo6ellDgKythG98eBO60xTDSUESBJtzPGfMvqprJxxY=
X-Gm-Gg: ASbGncufyuzeNtbY8IsJHN4A94OS8kA00vv1zX5A6FRakcCf6nWpTBJgHIXZbh1RMHI
	yTFAmL1sqsGKVEwLk0ty+PbWP/Q6kz30LurCPWn40yHOd4aXKf76FJ0Aqm0AGVdhN6WiviDrfIB
	Jxj4NeZFB0aE9EUqNPBEeDGCc6k584VpSLwDdAzwzhiofr6v5S4zjClruB5kD0pFqyPkFLZYJZy
	du+/fWYk4cfoZf5OBhdt9lBGlTmlQmlkTK1g+6JxAgejzb6aNlnqGMgjNqFUbb5dVnSrxD+XlAD
	JKoVNtRJWm0GsiYNpxUb4Ydvgwf6z+6toPS/7f9ckFhBr6lsYLtTRxb4O08zQcMFkKSmtHPUfGV
	hgkScs1PHiXAcnN1LmHoeEX9xRLU6+tzr9Jdg5v3r5pMkIzemAHqnU4KwzAlqETf8rAGC466FTV
	IufMdSD3maGBgeUVW8S62SYUOpi/1UNYyRxjQdpPtGpZWmYxx+bUWt
X-Google-Smtp-Source: AGHT+IG9ChVNYrBBCO8kR0wcOpsDkgCmhBqeBE/GhXOifeh//7dfAIxgTQv3O5f6cncyaPLIX23UEQ==
X-Received: by 2002:a05:600c:1f92:b0:475:dc06:b5a8 with SMTP id 5b1f17b1804b1-4776bcdb5f7mr9360895e9.7.1762503059742;
        Fri, 07 Nov 2025 00:10:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce211d8sm160736625e9.11.2025.11.07.00.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 00:10:59 -0800 (PST)
Message-ID: <80576ce0-7383-4b46-bd3a-3ecb0837007e@6wind.com>
Date: Fri, 7 Nov 2025 09:10:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net] bonding: fix mii_status when slave is down
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Stanislav Fomichev <sdf@fomichev.me>,
 netdev@vger.kernel.org
References: <20251106180252.3974772-1-nicolas.dichtel@6wind.com>
 <7a6372b3-b170-49b9-ae62-eb0d1266bd6c@lunn.ch>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <7a6372b3-b170-49b9-ae62-eb0d1266bd6c@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 07/11/2025 à 03:36, Andrew Lunn a écrit :
> On Thu, Nov 06, 2025 at 07:02:52PM +0100, Nicolas Dichtel wrote:
>> netif_carrier_ok() doesn't check if the slave is up. Before the below
>> commit, netif_running() was also checked.
> 
> I assume you have a device which is reporting carrier, despite being
> admin down? That is pretty unusual, and suggests its PHY handing is
> broken. What device is it? You might want to also fix it.
Yes, one slave is put down administratively. Before the mentioned commit, the
status was correctly reported; it's no longer the case.
It's a regression.

Thanks,
Nicolas

