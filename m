Return-Path: <netdev+bounces-163490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C387A2A6A2
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 12:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B933A11EA
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 11:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6269722CBC7;
	Thu,  6 Feb 2025 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ikm7+dAx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B6E22B5AD
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839452; cv=none; b=idF13R/6GetUcJf2JyzdILQv3QY883MmYS3qGMVhptbMViY0RTIcaWNMBX6/Pjoh4E1SrqCgCmOEu8v4AnD9mfRYMHcmz2wUs6WI9PQVxAx9A1pAIDTCYr2Zj6evJvPhajkelQtiUZENzhKOWpXEfYqU6RY6vjSNpZPIzF76kz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839452; c=relaxed/simple;
	bh=yS97H7q7oRB/+hqX0gPtpYGL7M2XhZjxHI0JhIpPcoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLMotR+OsF9KfSVDcx7YB9rORy1yly0nlkl3HTnYrST/3EZROL9ijef/YLnbzoCulkwZATzfbdpSvOeFCnu276cv3FXrL0LY1Y444/WznZjpsnAkFZTDAGicA9NMXXtB2rJkSy60+k3D8YHKpwSMKnc4O1+2gdHSqzCPRNAfY6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ikm7+dAx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738839449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ks1EJyaV3dJWopJIxPGTdysgQbtxzRdmygE8oecODfI=;
	b=Ikm7+dAxneZRtIfnyXXwxGJuOfGnf0ZVEQwQq4QH3ArFiNxcrAph9E8kXrGFxu3+Kae937
	yXhtgiAp9shhVHGMrxwMXb/qAtthfdbdhq2FzbEhBrt8M5B0GEN6lEg1AUjl+JGeNtkP1q
	BAAYjhUN3G5zicbnk4GPly/SkR4GymI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-OWP2KXczM-K1o0-m3Z5nag-1; Thu, 06 Feb 2025 05:57:27 -0500
X-MC-Unique: OWP2KXczM-K1o0-m3Z5nag-1
X-Mimecast-MFC-AGG-ID: OWP2KXczM-K1o0-m3Z5nag
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-436289a570eso6289705e9.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 02:57:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839446; x=1739444246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ks1EJyaV3dJWopJIxPGTdysgQbtxzRdmygE8oecODfI=;
        b=m7r+E1O1vJ82ma+H0nePrXR9xOp5WHKrSuUfhlZT03zDRFr8hVbIwOfFzmVaHcYeBw
         t7k5VXsYuMWwxxPsI1qWprHFoKAmqposTPmC4546LM5O90srwjSv9CTjWFipaau151f5
         CJdVLIYk9WvhbkakAoY2ofqhj9Nwibfc/hOEVbm4zQ+r+L9JyA52sx7xgZFgbSBg/Jjx
         HmjctIdQiAtdWieWO4ymTCex0w/3uCAxHtlxFS3UDaeV2tSQJp6Zm5P4XornsMGkwNFd
         vNxZVOBPkfjQIuVpnkOgpPynJjVzTl2+owkzRs8F7QTERJPYVQgjzT9iVEJ5USIwOGfb
         RQOg==
X-Forwarded-Encrypted: i=1; AJvYcCVuxdDw3bdPhyKIhS9NvudzvHTHJ74UP5NVRAGC0cSLRm+oHTgRhwi8O0D2k4VQz6VizEg91o0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS3C8xmokYaQBlLwjVbKI6JyD4vhL6lgv0yG293z6fzlsMKf/N
	inm+KQjgTdevnuoc6qu39QLoaygpqnlS2wFR9aJEPHIrQuVi0AIN7bZgUS/grEp6Jjyb1KCT1qr
	HMUVgs89KA0k+lDekNrqY6VOrCLJukMIJrWqC2V59OXEd+fGaHNjUpw==
X-Gm-Gg: ASbGncussrc7OAZ07iq/rkWBXNd0ZUEcJ67mbj2hB+HMSsEd4Rh2fp4bHknbqEdzgPO
	xiiE+OnfV5PfwvsazG3Z1XNY1U/hq0+7YSFnf8WuHxzEvah5fbJxAZSejWqIzZAvlsmC5hljK71
	LRUATksecfuh0MzfH8lHwJRQuuaAiIcssdCEZNrS958rKTcIBJr21DNYQOjniDDeL1CHSZsspw8
	kIyHlHJ1O4jcDCUAE4OUeFEgq6dBwwEGqUCfyU1DwFI8uunvssFoQp9Za7TBFl8T/BjE3f/vD2F
	xl++lyLndEljXj/U5maQBLO688pf61/7bXI=
X-Received: by 2002:a05:6000:401e:b0:38d:be61:2592 with SMTP id ffacd0b85a97d-38dbe61266bmr1223899f8f.42.1738839446082;
        Thu, 06 Feb 2025 02:57:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLyD8qKeYPHkk51RV7daxUs9XqUUKgX6jSRdYNwnc255CmiNF1pLJ6S6c+04Q/17xlRqYqpA==
X-Received: by 2002:a05:6000:401e:b0:38d:be61:2592 with SMTP id ffacd0b85a97d-38dbe61266bmr1223877f8f.42.1738839445638;
        Thu, 06 Feb 2025 02:57:25 -0800 (PST)
Received: from [192.168.88.253] (146-241-41-201.dyn.eolo.it. [146.241.41.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbde31d9bsm1414982f8f.94.2025.02.06.02.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 02:57:25 -0800 (PST)
Message-ID: <8f891a0b-249c-4c4c-ac76-da9ac41ca857@redhat.com>
Date: Thu, 6 Feb 2025 11:57:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Revert "net: stmmac: Specify hardware capability
 value when FIFO size isn't specified"
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <E1tfeyR-003YGJ-Gb@rmk-PC.armlinux.org.uk>
 <2cff81d8-9bda-4aa0-80b6-2ef92cd960a6@redhat.com>
 <Z6STSb0ZSKN1e1rX@shell.armlinux.org.uk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z6STSb0ZSKN1e1rX@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/25 11:47 AM, Russell King (Oracle) wrote:
> On Thu, Feb 06, 2025 at 09:08:10AM +0100, Paolo Abeni wrote:
>> On 2/5/25 1:57 PM, Russell King (Oracle) wrote:
>>> This reverts commit 8865d22656b4, which caused breakage for platforms
>>> which are not using xgmac2 or gmac4. Only these two cores have the
>>> capability of providing the FIFO sizes from hardware capability fields
>>> (which are provided in priv->dma_cap.[tr]x_fifo_size.)
>>>
>>> All other cores can not, which results in these two fields containing
>>> zero. We also have platforms that do not provide a value in
>>> priv->plat->[tr]x_fifo_size, resulting in these also being zero.
>>>
>>> This causes the new tests introduced by the reverted commit to fail,
>>> and produce e.g.:
>>>
>>> 	stmmaceth f0804000.eth: Can't specify Rx FIFO size
>>>
>>> An example of such a platform which fails is QEMU's npcm750-evb.
>>> This uses dwmac1000 which, as noted above, does not have the capability
>>> to provide the FIFO sizes from hardware.
>>>
>>> Therefore, revert the commit to maintain compatibility with the way
>>> the driver used to work.
>>>
>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>> Link: https://lore.kernel.org/r/4e98f967-f636-46fb-9eca-d383b9495b86@roeck-us.net
>>> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>>
>> Given the fallout caused by the blamed commit, the imminent net PR, and
>> the substantial agreement about the patch already shared by many persons
>> on the ML, unless someone raises very serious concerns very soon, I'm
>> going to apply this patch (a little) earlier than the 24h grace period,
>> to fit the mentioned PR.
> 
> Thanks. Here's the missing Fixes tag that I missed:
> 
> Fixes: 8865d22656b4 ("net: stmmac: Specify hardware capability value when
> FIFO size isn't specified")
> 
> Not sure if patchwork will pick that up.

Thank you indeed for the missing piece. I'll add that when applying the
patch (~now).

/P


