Return-Path: <netdev+bounces-145042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E4E9C9312
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 21:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6073D1F229B0
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 20:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1561F1A00D2;
	Thu, 14 Nov 2024 20:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhzaGdXD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5EC148827;
	Thu, 14 Nov 2024 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615376; cv=none; b=O/Ldw97rCQE4fhDx/9PETp2aftZ+M2BF6FUQgSvmGQg4vZBcLzLW3RcQNJBg9BsLMuLGkuNa4tK2Kq48SgMQrrudw6fcnz+sBLVjtj9WnfKr7WhW0Hv1ZUZ6jR2Rt9rvDybk+Hbl8CawvZStpVfPwrq4x/T+9RvzwrOWDUI0/Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615376; c=relaxed/simple;
	bh=qezj+4iRFTa5uw7ZJVpA+h8jatTkWdVZnDzucmXJiD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=elgHBlZ2g/Foijf/nuuWNyKTzP84WPSPaBZwadsAiawKCaBq9CGdqKYoihxU2xvDN2amaPHLSoVj2YxNw/+HN5bHH8YwG2LvY9qeeJFyMPnDuq8nuN0xB0SxtK7LWak5cvsyN1CxUO45PfdSdtMdCPAqd9aBIcQ++ZhMFuyzF2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhzaGdXD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso11925925e9.0;
        Thu, 14 Nov 2024 12:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731615373; x=1732220173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VF8vYJ/nyoA/hRfc/5vPhgLG0Ij1q7aNxIm6EqBVvgs=;
        b=AhzaGdXDpOsMd9tNJe8SLOPKlL9I9zBGhMUzp6bgUTXPrVqMxZGvclmIxpk3LZ860m
         kSQtp8zTdujnPgIQyZqDntNlSSDdowqdmWmhOQ2DvtqVRDuRvZIPkDG6FKnD6JiyRUud
         zeuQMnkxhD68TZ5CKcYmxcxz38U6wk0ZXITzDUPTOJ8KZgpQaQUeTy1rhe3Bzazl6s66
         xEB373DsfPfIXkd9rvEq0kWEyT+uBHsk2sB0AWkGJnSRJ8Y9SzlsfMSbs6t/T0JtMMFz
         5X9XEC2BV8XfhAbM5kx7f2LTYYs9aYwmmMaihkNjHd4xfwvF4cbBRDGtUbu+d35huxwb
         MiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731615373; x=1732220173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VF8vYJ/nyoA/hRfc/5vPhgLG0Ij1q7aNxIm6EqBVvgs=;
        b=tVmh+jlz9d62oXAbpJohjY+CxET627cS2Aap6TZtrbEVmzN6IOxlXp85efHZPxN+xN
         oeYAqXQH8IJea7l16hC5z9aKg8fYA8zFEOSeHTNRaR54e8vZ3RYgsCCi46GLg35LjC/L
         QHvYJih0Ib1kd9Tj75o691tG9+WLhFOr4wrWFIhpYrtngtdwFytt4KoLQfbrb9WzQqw1
         In8duGxBS6yiqWwbpHMTnjzBHhnf6ZjMgICo1vC92B54xC3LsubjdoCApZdz/UqZbLyQ
         tRk65evKYQi2SZJpU2JunVQBvmnFePWA2PfUaOa89z3qxz0vE1nP+80mK6b9ne1DwggX
         LhZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY/JHC7OrLmS08YAi5n87ltBztPWn4o+PBJcSNumCCYwKKlLF2xpNujegZDQBLYugfDqgdNsl3@vger.kernel.org, AJvYcCWNldl2TXP2HEcVkPISXeB378bvAXqTy1VQslYG2MOARN0ogRv+07MchJ7IoR0bujxx3V0pFIqaHQ57XiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbZgxucKkJr1H/O3aJjJ7pJINK4+QeF15tbNPbKDiU9RQDZG20
	R2dxSsNvLqX7LkXiOyS2SVMn3gEJ5XvQA5944TlfrcCA03kTtlUHoWYij6Ao
X-Google-Smtp-Source: AGHT+IFfrFebZdXPIuwVPcS63wedzxK/tK2B+2J+cZeEizh6Hpb8NbPH3BGx2/JDucWDdutCcki2mw==
X-Received: by 2002:a5d:584f:0:b0:381:f5a7:9a56 with SMTP id ffacd0b85a97d-38225a21bcbmr99296f8f.10.1731615372400;
        Thu, 14 Nov 2024 12:16:12 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae160f2sm2424016f8f.75.2024.11.14.12.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 12:16:12 -0800 (PST)
Message-ID: <60875bc8-bc45-4168-8568-38ec73499d1b@gmail.com>
Date: Thu, 14 Nov 2024 22:16:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: wwan: Add WWAN sahara port type
To: =?UTF-8?B?SmVycnkgTWVuZyjokpnmnbAp?= <jerry.meng@quectel.com>
Cc: "loic.poulain@linaro.org" <loic.poulain@linaro.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <KL1PR06MB6133B5403AA55BC79C13FF3B935B2@KL1PR06MB6133.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <KL1PR06MB6133B5403AA55BC79C13FF3B935B2@KL1PR06MB6133.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Jerry,

On 14.11.2024 10:45, Jerry Meng(蒙杰) wrote:
> Add a Sahara protocol-based interface for downloading ramdump
> from Qualcomm modems in SBL ramdump mode.
> 
> Signed-off-by: Jerry Meng <jerry.meng@quectel.com>
> ---
>   drivers/net/wwan/mhi_wwan_ctrl.c | 3 ++-
>   drivers/net/wwan/wwan_core.c     | 4 ++++
>   include/linux/wwan.h             | 2 ++
>   3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
> index e9f979d2d..2c6a754af 100644
> --- a/drivers/net/wwan/mhi_wwan_ctrl.c
> +++ b/drivers/net/wwan/mhi_wwan_ctrl.c
> @@ -263,7 +263,8 @@ static const struct mhi_device_id mhi_wwan_ctrl_match_table[] = {
>   	{ .chan = "QMI", .driver_data = WWAN_PORT_QMI },
>   	{ .chan = "DIAG", .driver_data = WWAN_PORT_QCDM },
>   	{ .chan = "FIREHOSE", .driver_data = WWAN_PORT_FIREHOSE },
> -	{},
> +        { .chan = "SAHARA", .driver_data = WWAN_PORT_SAHARA},
                                                               ^
          White space is missed between the port type and '}' -'

Please run the checkpatch.pl before submission, and use 
git-send-email(1) when it is possible.


$ ./scripts/checkpatch.pl net-wwan-Add-WWAN-sahara-port-type.patch
...
total: 6 errors, 6 warnings, 33 lines check

--
Sergey

