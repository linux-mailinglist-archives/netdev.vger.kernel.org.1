Return-Path: <netdev+bounces-91798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F20D18B3F3A
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 20:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB872882E8
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 18:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D4816DEDC;
	Fri, 26 Apr 2024 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCmKD97K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7194016DEA7
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714156120; cv=none; b=eYaclleCL6vVOXVAiof9Kg+S8z8hRekIJ4LozkY3nEl6JFKpMdiouH+/c+OnmPI/QQmAgX16GFRpsiGBc6p11PaNlJVt/1BwZQ8cZqOOiIJ5DvQelpAcFos7GHGJ/DK/c0IcB5z4QR6LiIpFpKIHmkKGiNvrcT+pynC2BWlyLh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714156120; c=relaxed/simple;
	bh=MSY19cjBPMgB2E7mJiIvjuoJYxmIFi9AMnM4X2G0uVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBbME5b4J8oddynUnDXXGBQpfw06Tn5Ko7brkJaTFvQI4d1koU6Ft6vZzleBfqScxyYtymcbICcpEn85Cjfnm8YMn3y9FN8zkALkrTEO36zcIC7tGynn+mcgbHMyItcqM2oa8NRwFp6HHE3HUPeULyjnTFNHziSkXqE1NaH723U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCmKD97K; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a9ec68784cso1818883eaf.2
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 11:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714156118; x=1714760918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lD1w9h6w6Hov0FAHeajBqnLOUi8FStjxF3GgaqM6sVM=;
        b=lCmKD97KM/QsXdopUuNQbc454EnnwPLjJ/c8H5bmTIJ5jhgumhnPhScqfHNs1Bt1//
         R+DnHeTw9B2SVYAH/hnO1x0991yJIke2d3bG1tHTQLnus2yYuJPDZjWPcdxM1FoClQnS
         7Qkf3QVyns9d1RzhUscn9FtK2gS3Z+EsXHl4TuJOsqm/Z/zScxfiMAtczgMP4CA1/NVW
         gqfEkhny8rjUZoDa+B6jqDGVyM2MlxGZhD9BpW/3IA6eJ22D5rDzMMskQlTp6FbByHV6
         nw4sTWFVouq6BJsekBNheDVt+o/QKSlYL+bxakacNhB/ju+Bc2lsIo4Xy5RZYsvflmXX
         WHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714156118; x=1714760918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lD1w9h6w6Hov0FAHeajBqnLOUi8FStjxF3GgaqM6sVM=;
        b=S/A+D0RiKbqj86SkXi8vVbGhnQltmZvybnNQoEc6UlXQ54TZ6a5uoSzx0gjNEXwbJ5
         N9L4LUAW2Su/NatSFSaAbJBHSGY/snZGKMY9Z1m64HdNjnmZzOa8oXUZKtkWMDnMV/ff
         dr8EPgGqaSA7Rq7GZm8pP1Bw6LvvCT5rjFSetW56Nn1qEHaA9oB1kMZf1tSW8Hp/O04+
         U326DWesAY0WFelCpwPUND2OET3dV5jZTgZ0ZJYKiLQm3WnT5/+OtDp6Qp5ebf84Oi7r
         Q0GCTif9RhmNAAs7e9wgzWCBVHKvRGf9Uo+wz62jTQHXvnydCf6IW3HLa5fc/Tpmi8Pq
         hYQw==
X-Forwarded-Encrypted: i=1; AJvYcCVJfKVyR32/yQZ+m5SBUt8kRubtvAISEjTBrkiPTAMIZiK90VqyXKMsZlwMdF/nhBvlo87DdgVLvlCpsW8uaIEcCn8bTFtW
X-Gm-Message-State: AOJu0YwTcVCNHitUKAYwXKY5q85dzwqnB5Qacf8ydhEZJxXoofH4lled
	01dJyWjJ+17LuwMjYIg4RNED2kob9qzajyKyKpaSObns+Z4cIguX
X-Google-Smtp-Source: AGHT+IEYq4r30aKjEYxlbDy5f9kh6b2RDUCUZ0UJD6x7lLAPCnO9Egm/QG4lLQypMnwXNVbTgCImjA==
X-Received: by 2002:a05:6358:793:b0:183:fb12:39f6 with SMTP id n19-20020a056358079300b00183fb1239f6mr4072569rwj.14.1714156118433;
        Fri, 26 Apr 2024 11:28:38 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id y8-20020a0cf148000000b0069f50e7ff97sm8016502qvl.66.2024.04.26.11.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 11:28:34 -0700 (PDT)
Message-ID: <4c423d99-af9e-4855-9cd3-7a3405680f15@gmail.com>
Date: Fri, 26 Apr 2024 11:28:30 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] net: dsa: ksz_common: remove
 phylink_mac_config from ksz_dev_ops
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>
Cc: UNGLinuxDriver@microchip.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <ZivP/R1IwKEPb5T6@shell.armlinux.org.uk>
 <E1s0O7C-009gpk-Dh@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <E1s0O7C-009gpk-Dh@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/24 09:07, Russell King (Oracle) wrote:
> The phylink_mac_config function pointer member of struct ksz_dev_ops is
> never initialised, so let's remove it to simplify the code.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


