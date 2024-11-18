Return-Path: <netdev+bounces-145988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C2C9D194D
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 20:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F25286B1F
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 19:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7F01E630D;
	Mon, 18 Nov 2024 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXbIxAI0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAFC191F99;
	Mon, 18 Nov 2024 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731959493; cv=none; b=rOf8ChhapmxLbby/gwLvgoejV7LKMdVVsKE3k/U/laC3GdXGq+DPdRjajA92AHmn7KzOywxZ4pmrRKoQQX8GFb5BkLU9PcFbro5aBgxU06m2P/bnsI96sk6a/LYdzJfR7+nANTXYEQ/Hv95qoLYoCsVBKcsC5liuwjd1/RmQXDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731959493; c=relaxed/simple;
	bh=GHixYrJ1x07M3jD1M1FiEAYqXF3dU1cwh+uCvNG1lVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9m7pfI/p49mW8JGLZKbbdQYVH8d04YnkpWmulwAdWBMsjDzdv8eVOGx45rT56fSD50SJdzL7iIAvtmeR2kBgJRzXDX8xbqemr60s8m9brtGm/MpFxHrlsetoxud125IxNE/AIhEPNcJMXif0YCsc3e0pwpIMT/3bKF/CCynWp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXbIxAI0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43161c0068bso20521115e9.1;
        Mon, 18 Nov 2024 11:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731959490; x=1732564290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TqGu+uXYYrHTakuMeQQsilwXyfHug/xVXhU8NF+CzFU=;
        b=kXbIxAI0SJLAQMCoTp6JF2efozp2GrmL4RUTRwNqpfKXDGzTNWsCMJjqKapF7HHpVN
         FlrNXrJmf5JIPTrvEVobNFNyk6ptXuqFiDF+CJM5Duok/y9nhUpB4lIV/0fXJCCHx9zu
         KLchnzA+b1xNY2EU1G9Bk5pqZqLW96ZKScfByq5vhgIxqYsVhKnI4qxqinazkSwgUP0l
         Tanteqxmamnwe7knz3y213SKHo5WPwFkKh3KLEkAR8TZIg5T/t5LFFJCGV7qmz8E1Qra
         nR/43qdrlnqSsu1Y8z7DDTKzrGBVw9pVjsyiHpcHgaVKzTShUJiGFWsLK2kdpv/kUlup
         5FtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731959490; x=1732564290;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TqGu+uXYYrHTakuMeQQsilwXyfHug/xVXhU8NF+CzFU=;
        b=ik0ptw5BJ7Ik2/ejBO6d1faDiCMdIClmsHtS9GZ3mQPSDIRdzOQJ53TAytuZeJsd26
         wrkxOgIHa4GTHHXO6GwFEVB24oo7dVKDEKlVNtUAOwUr03d4e2IqOc7jgchBfRs/8Ibw
         cwqihtDs/VApodRBuQW4SuJ6PXQ6/a+ZjXLk2LZRw97N3X/36eD/+auvBp1RmLOZvqg0
         qhfvLJyDqUY88X8K3K3SlRSGWs5Atitwv7cuAlQo7sEezbgsMUeIL4+t004hGYgi/GoJ
         m2l4anbl8r0ceHQX2eLdThH+4DibSq0yCD0ETchGUCS8rHXN8rh7wU09Q8PiGSQy3hRI
         +dvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3o69JPW0SnWyt61BsXyKvGwaavTrBiPEK4WmQUWooOkIfU/vXWdiNJ0LPaT2KubOl5IHx6kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxlpVRNrstTQ4Oq8cCVsPTCqOSfeL7j1Wmswqnt9td9LQK3M7q
	QD0Nn67Fn0uAod9FPr3yK6gxMfu154SIlfdtNmlJXrqWwEW6A91t
X-Google-Smtp-Source: AGHT+IGOb8vMGxRxVtw8SCxNu2za26WydpCvIj/AdUfMeUUMHq9FK0WSsLnEm7vdhgAOFW83gOCr5g==
X-Received: by 2002:a05:600c:3111:b0:431:5c7b:e937 with SMTP id 5b1f17b1804b1-432df74c8bdmr132729305e9.17.1731959490148;
        Mon, 18 Nov 2024 11:51:30 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da28cb89sm169139855e9.34.2024.11.18.11.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 11:51:29 -0800 (PST)
Message-ID: <17c64a08-53b4-4d34-8bbe-f7d29653a2f8@gmail.com>
Date: Mon, 18 Nov 2024 21:52:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/15] net: wwan: t7xx: don't include 'pm_wakeup.h'
 directly
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org,
 Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
 Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
 Liu Haijun <haijun.liu@mediatek.com>,
 Ricardo Martinez <ricardo.martinez@linux.intel.com>,
 Loic Poulain <loic.poulain@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20241118072917.3853-1-wsa+renesas@sang-engineering.com>
 <20241118072917.3853-11-wsa+renesas@sang-engineering.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241118072917.3853-11-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.11.2024 09:29, Wolfram Sang wrote:
> The header clearly states that it does not want to be included directly,
> only via 'device.h'. 'platform_device.h' works equally well. Remove the
> direct inclusion.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

