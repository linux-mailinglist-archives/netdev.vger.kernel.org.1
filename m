Return-Path: <netdev+bounces-152819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1619F5D76
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 04:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356F616565E
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10BF13C83D;
	Wed, 18 Dec 2024 03:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="16lwB0yt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C9F13775E
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 03:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734492452; cv=none; b=QUvZ+RQlSC80766W9THgqcpo2voEPoR58nwCIsuR1flGUT0CGkbtvSClQ2DP3wWsjN/N16YoDS44VfBR8B0mjQiNw2u4ME7kD3SwXU3NZ9EbMi0y1V9j9BnQcpmhdueoie/4oWYLF3QA7zxaWVSVPqRBSqvDd3hhnqvQT7jXRis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734492452; c=relaxed/simple;
	bh=MhJAXBMgivp528yJcts2MYR4i3JinVhdlQd1YG0d5VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWuxVoa3BK9RaC8OOckbc+m+G+I4gh4/VaF2W6ATqzPKTkUFQ1LOMr0806VX1q3BEx7ou53XlTtAJ8RMBngFx0Cc4DCE0EsOm7JjSU9SIS6wni/RoJhbcZXspiVETDPhW+U3zogglmO5uKIKb9hiC4TILeJWyGHHC041rv1N+Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=16lwB0yt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21644aca3a0so71412635ad.3
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 19:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734492450; x=1735097250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vmANM5aXFU7RXcqWqCXYYVfLh1poLVg2UnyEEuiTxEY=;
        b=16lwB0yta4IzynLM/ysKLbMmPvZkidKmfQFO33JUKRIvlSpsthnATw47RAf9RrLlgK
         YQGdn15HDcu3EBF4IwRGQmHb87KxQsWqH2Of1Dl/un/pvMX+l6TFakQawpbGp7OxX2bn
         kpjJ2+WhsWukLLu25CSer9rBx1IOcgpbLoRJqh16tMUSHV1Dsel/59ILvjmQlcTgsZIz
         yhxeU8g54XoVkwvIf9rtCtjUyVOX8MXBcxdngOOQPyuUkCEnq5O1foXdJhsYackaPl6G
         tmS2Kj5+KRpUmtYBl/G0cMceyZGTSQfSMUVeExzlDzxtLuOH44v4KAkOeDzfkNujPCTs
         vR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734492450; x=1735097250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vmANM5aXFU7RXcqWqCXYYVfLh1poLVg2UnyEEuiTxEY=;
        b=U4ialNPNKbWIl10t1cPMPYo+9rVQsixyeMyNhAffX1d1cg1XaUZQbUT1KM8prDkcFZ
         R4wiP2F5Oy2l35WQOgNlfWINDdIcjUoYoa0PT11hwydVApkutcpov//tmGd+vTixKxHo
         4ffl0FmTtIxO1zZyQmyT/MGzaEEmfmKXx+sNW5mRMqLsH+oTCf5kfH93AUJyK+jLFET/
         c+Axitd7PdZSuuWLfIVo8enQq8iFpn767W0Y8v21jd0LR0U2Tn5SjuH5mX8WTPZ9Vopg
         /KVMxL3v4oo7CISKtqke3rzraPJUH2RfqGvsFvM90GJ1ReOPFtbFUGC3NxMNRywtBG4i
         QKFg==
X-Forwarded-Encrypted: i=1; AJvYcCVuCQRNVyZZQvY0bxpIL2EJqjNDfY7NKXsRGQ4CjNc5g3CClJLKzKpLhs1M+zTqx3RujUnrALk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoYG+M8RkHuYj6NWN/5xOlzbA+VoCOimw9czCvhT0tz+vaBUCb
	NPX/TEpphi6muOUQexVb3El0BVp2wCS2D+KOCaqGppmjwTrITtU6UkhbeGulXG4=
X-Gm-Gg: ASbGncsh0gJyN+cnT+5K6pTJywRVigSAgQ9H5PeoZ7xCOKkkNp6dDlQuYqHdAf6fGOz
	9aJwdfe4gKM6OaqOB72cC1hYrZi+j/AfJ5yxsxWnD5FV3+8RpxUaiHjNrM3czKNgT+zZsVSCdtw
	NlXHSPatKQOWcV0W/zhzW2A8ZX59vlfgg+P1xVvQ4zXZ7+XWR33+1TM154pZ+3ZN8+aabNu/Aox
	jEC+LVAzlEi+Sqbi2bKlZkJttPHvnaxTZjOnPC7eouha/+Sf9Owe7HRIK8DaJ9jumA05s3USWzF
	xsAVHcazflgeFNlem4BHmznwY6UYEaAnyA==
X-Google-Smtp-Source: AGHT+IECLnJw6vZc7Cdh/sOmNpn4evMiFTCntoURb+9rvSbMdWdpuWTJ7fYwS7ylqdoyZJwIJkPOtA==
X-Received: by 2002:a17:902:eccc:b0:215:bf1b:a894 with SMTP id d9443c01a7336-218d70f6be5mr18127935ad.24.1734492450655;
        Tue, 17 Dec 2024 19:27:30 -0800 (PST)
Received: from [192.168.0.78] (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e50250sm64912615ad.122.2024.12.17.19.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 19:27:30 -0800 (PST)
Message-ID: <a288732f-001c-42ed-99ce-e0f6db160918@pf.is.s.u-tokyo.ac.jp>
Date: Wed, 18 Dec 2024 12:27:26 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: call stmmac_remove_config_dt() in error
 paths in stmmac_probe_config_dt()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org
References: <20241217033243.3144184-1-joe@pf.is.s.u-tokyo.ac.jp>
 <ec8509c2-1124-4f8a-b831-459d084ac726@stanley.mountain>
Content-Language: en-US
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <ec8509c2-1124-4f8a-b831-459d084ac726@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/17/24 20:27, Dan Carpenter wrote:
> On Tue, Dec 17, 2024 at 12:32:43PM +0900, Joe Hattori wrote:
>> Also, remove the first argument of stmmac_remove_config_dt() as it is not
>> used.
> 
> Don't do that.  It makes the patch difficult to review.

True, the patch is now split into two in v2.

> 
> regards,
> dan carpenter
> 

Best,
Joe

