Return-Path: <netdev+bounces-70299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5475984E4C2
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 17:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9131C24F74
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 16:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F947D40E;
	Thu,  8 Feb 2024 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="abngXb4v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD487D416
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408700; cv=none; b=ese+5EoNqN8MwKFto//BOUv0uoV91H08Ax2ilvV4bb7G/Porj5Mn3U2cO7+dsEfHOgnlvCed6fD4bs12edg52Lay4AlWdD/k5/b09KAltrQpSdau5ELuxI64oBnbCPWcF05tB3HUCUToBOTqWjcYjXHNdtE9gKf/2osPnPUIkZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408700; c=relaxed/simple;
	bh=cWTgoqU7fKZA8BhxehN7Fk4Nd65sWiM55lgOVVf+Zao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YEm60BMzfLOZw4KbVORTln2KXG0TITXYzx1jvdQGbLj9md2efw/sGDv3mI7kyZpugDwcM19E1B0H778E7eU6mhikT+UOLgIlCAn8FYA3+1DEju0QEDgzfWuMZ6Ot3PIF9DsPNOpE1EKdFIkEernyuT98QxCbSxalKY24BuAd7Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=abngXb4v; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d09faadba5so527441fa.1
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 08:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707408697; x=1708013497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NG4oPoKOQKy+o5+bEySCHk6cc22upqmzFvBUacEPxcY=;
        b=abngXb4vNsvyMLhezzANFWD1PYSJJRZOklkpx0P5HkvtBVKRCCGkkwfcmYNp6qpN+k
         Th/jibZUgvR49tAscC4aKyJQw+2uqNqNGbbINx63EfR/om8zfwATtsY1H4TiMFEpG1Oj
         RmReAIh+lcXch9EeQQrrI2zOb0+OUyoY+xrmQ7vQdENJI8eIjGSy5CvM/PHAHwVDk96L
         lS8z+HMs+gW9YtXL4bhfeR6xuyHoR47lDLF9T773OzDa0NO6k++hibI4WkiXiEpulgq4
         CqtfVM4cZhSXujdSmJdVfVOMRzrg8jqgvUnXXIvtiJrdERKsoU85ItcGO1vgr4Z8yqD8
         ARoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707408697; x=1708013497;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NG4oPoKOQKy+o5+bEySCHk6cc22upqmzFvBUacEPxcY=;
        b=nSIaNm2zkEgUODHPcDIyZHt/w9InpLJe4KvvCnU2RFV4PwuiUCZA6/5+589Xqr9R8z
         /+tOtHvalFzEfSSdBeI+qAd0ignORjA2rUw7Rb4hyYm4IJZML7nAyfnE4b5ziKBVinVs
         Iqagp5CIECPjVSYz9K1gT+KVYwZFvR/RTF2A0gA/s+x8Ad8FTJ1SDCLgXUQsEpQpYOJG
         J8uzNEk4s4VWjlzEygHwKpS8DzOHCadRDV6xTaDgKuhDDZ/9sXIGJDcW1aESpXTs4X/N
         ZRMHZK3hUQ9sqlBFykjY0bqrpO4yR0BRvG0h26dsakFJgcCBKHUYXYIpbdWQKQZdsBxq
         mtfg==
X-Gm-Message-State: AOJu0YzGrXhe1xpyzxroCOs4YY9fqAJiAjwcN9efSFm5823yndG/eCgh
	BaWFwUENkKqRVsj+USaiqLDg87jCOfvrRlLUYV2m6pWu6lG3outvPzpPzsoh1qU=
X-Google-Smtp-Source: AGHT+IE/ZHP9/CZGYr5vSh05z2v+idxqaCPOmz6Zoi/9FgOTKp+Qtno5s3Gwklmnu2m5kkxiYYd5Cw==
X-Received: by 2002:a2e:b24d:0:b0:2d0:908e:d825 with SMTP id n13-20020a2eb24d000000b002d0908ed825mr6525245ljm.21.1707408696828;
        Thu, 08 Feb 2024 08:11:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVYmG5ePPIRG4hWIMZIDpk/ukfhSXLR4iAj9vF2lng21pdqbASmaiLEbLoPdxqI6T9WFP+7dkUwFJAM53EZ46M/2YEpcWce+MZtNRr0GqRdMYUMtgTd4vpP4erj7blx/NwSXoEnBUEa0wW+KzW5prIwegoI5+tFqpCaFiN4HNOhOa/0clk7rjcjbHTTFf2xC5KRsjQO/EPvYisj0XHnmBd+GXzFqn313HiVADvoDckLNh0jzTpuMFRTF38aVYNJkZCg/x/3orRbtIY+EJQNSfh1e2O664sUk4NHH7XaR9jd/cAse9lEoLPkgrnw/HpT7aG/Ia8zvboliQI=
Received: from [192.168.50.4] ([82.78.167.45])
        by smtp.gmail.com with ESMTPSA id iv6-20020a05600c548600b0040ef3ae26cdsm2048079wmb.37.2024.02.08.08.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 08:11:36 -0800 (PST)
Message-ID: <cf24ed20-c2c1-4f36-a747-e01f5a36b61d@tuxon.dev>
Date: Thu, 8 Feb 2024 18:11:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] net: ravb: Do not apply RX checksum settings
 to hardware if the interface is down
Content-Language: en-US
To: Sergey Shtylyov <s.shtylyov@omp.ru>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240207120733.1746920-1-claudiu.beznea.uj@bp.renesas.com>
 <20240207120733.1746920-5-claudiu.beznea.uj@bp.renesas.com>
 <82a95cae-29bc-06c1-0fab-5fa6302b4654@omp.ru>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <82a95cae-29bc-06c1-0fab-5fa6302b4654@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 07.02.2024 22:50, Sergey Shtylyov wrote:
> On 2/7/24 3:07 PM, Claudiu wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Do not apply the RX checksum settings to hardware if the interface is down.
>> In case runtime PM is enabled, and while the interface is down, the IP will
>> be in reset mode (as for some platforms disabling the clocks will switch
>> the IP to reset mode, which will lead to losing registers content) and
> 
>    The register contents? I thought I'd pointed out all of these...
> 
>> applying settings in reset mode is not an option. Instead, cache the RX
>> checksum settings and apply them in ravb_open() through ravb_emac_init().
>> This has been solved by introducing pm_runtime_active() check. The device
>> runtime PM usage counter has been incremented to avoid disabling the device
>> clocks while the check is in progress (if any).
>>
>> Commit prepares for the addition of runtime PM.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
>    I'm afraid such check now needs to be added to ravb_set_features_gbeth()
> that's populated by Biju Das' checksum patches (which I've already ACKed)...

Yes, it's on my radar. I'll check it and update it (if any) in the next
version.

Thank you,
Claudiu Beznea

> 
> [...]
> 
> MBR, Sergey

