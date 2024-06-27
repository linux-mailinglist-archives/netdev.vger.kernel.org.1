Return-Path: <netdev+bounces-107327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348DB91A92A
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B05283EBB
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129C5195F22;
	Thu, 27 Jun 2024 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HH8laEF2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6AE195FC2
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719498303; cv=none; b=Yf6hx+QyGVdduMprZBsa0d0asUg98l860VRQ3/fR6z5HM6H9qYudaSncV9VW2NXewd3J0AFLxkZZsnHMPTNEftr43D50GQaN4oqbBIXZdYOYXevurAXpf4VBEhGxhk8rWXwH8HNg3CJn4d8aTVwPan9uvNHjQW88AG2ux/ZTXtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719498303; c=relaxed/simple;
	bh=Mf/UhFmdW3NuMdmcNMD5KvtDlYOnYFFbT67izZSmnlc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JcX9jFX8N8cN1WBlzxIy+82lsHnFZm5uapV3VWTdCguGSnXOx071Lx03Lcx70RsAbD2KKwE1Irhvh7HV+UpjwKDjF7r/ddQ/qudzVEzwuXBTJDY9uBenq8EzLDrRjhM18uhhtZAI43piGenqDiN7vxW2hk971Cu7Hgvyb4BHlIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HH8laEF2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-424720e73e1so64447185e9.1
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 07:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719498300; x=1720103100; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdRrSOWC1E6Ygr/Gm2G848Cn8YTszF/bu+fZACxBnhY=;
        b=HH8laEF2GTBQGYUYuMoSV1OYvSc8Z3jtq7zIJtPQFkCg2Msw+gHvun6LcBWpgzP/31
         h9Ei24L9RQulaoAT1+1B74Xzg4dTjZxrfwrpo2XB7o+iCwaPEnEwipYGMW1Ihur5vFWh
         +NSK+8nA++OvOv5fUBHX4KF/YF5WFGkzrGeCrGOuAvvVZbTs+i8sFIVz4FqsHlnvQ8qV
         SQiHw4e//72oA22UcHQT8Li3qeatRTpeqNuNHOJmBMiRjfr0zPec/NoyoctqWiJWqQhC
         0EKJsurTtjOsWnrxMmr5wOOZXws4ITp5Iu0HWzGxOq0dr4zPNRvgXxvte1bv6JeJjBv/
         Am4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719498300; x=1720103100;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cdRrSOWC1E6Ygr/Gm2G848Cn8YTszF/bu+fZACxBnhY=;
        b=LUNDh92b/WFMtjSgh7PpSm6PLMtxUc4Em6H3lvtV/MGRYGUr3dy9AfHviTrCeXzyxp
         6EbsUx0Pd9h80N+D08n/oKl382iXlatscrvFDfsSVQHIGlBbcOaXn73miKUIDLZrKfu0
         SPIsSKDIUSUwYXaP8k8W5eASJN/OIwyqQ8BgeIwAQTScqtcbvRcUrWF7bQlsTdnZFWes
         dHJ4N1NP0wBP1jwzks1V1v7oXx3bddUPjHEKjsmdROVqVrajs2nmjgP1Hn555QPGPJGz
         Eq/hLz/x3NHFfYhPOyszxJ7meRspGfbliR86j+MXDOtavdHcJuZX0VCWS+BnYnxvhroG
         8vcA==
X-Forwarded-Encrypted: i=1; AJvYcCVNaMU19AJRZQD8slALATiZsnrKZ7ufHfLef2bWK8qfKjDyE6ZJZzhgLQSERhfoG0KLG6KgEnMIQQj8+HiwiUerMRY9EfrV
X-Gm-Message-State: AOJu0Yz2lr8shiWEutlYWjSIYy2sjMwJHE61750bZXyZA87TRKPJFUWS
	TGN/6wjkXbB1cd4C27tAR/Wb1GTudvPXd4EdzMAHlX8OvDn5aM1H
X-Google-Smtp-Source: AGHT+IHPPlIeTQ3BRXIm4vOFy12dTM8+IEr26wqbxpNql07Cy8PotGNgSAkzz3GJu4lEOKt1mVlmLA==
X-Received: by 2002:a05:600c:4881:b0:424:aa41:4c15 with SMTP id 5b1f17b1804b1-424aa414d2bmr43901765e9.22.1719498299544;
        Thu, 27 Jun 2024 07:24:59 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564a4ef51sm29512405e9.6.2024.06.27.07.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 07:24:59 -0700 (PDT)
Subject: Re: [PATCH v6 net-next 3/9] net: ethtool: record custom RSS contexts
 in the XArray
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, edward.cree@amd.com
Cc: linux-net-drivers@amd.com, netdev@vger.kernel.org,
 habetsm.xilinx@gmail.com, sudheer.mogilappagari@intel.com,
 jdamato@fastly.com, mw@semihalf.com, linux@armlinux.org.uk,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, saeedm@nvidia.com, leon@kernel.org,
 jacob.e.keller@intel.com, andrew@lunn.ch, ahmed.zaki@intel.com,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com, pabeni@redhat.com
References: <cover.1718862049.git.ecree.xilinx@gmail.com>
 <e5b4739cd6b2d3324b5c639fa9006f94fc03c255.1718862050.git.ecree.xilinx@gmail.com>
 <ca867437-1533-49d6-a25b-6058e2ee0635@intel.com>
 <5ac63907-1982-0511-0121-194f09d9f30a@gmail.com>
 <b6f4adee-76c2-466d-9d0c-f681fe32baf8@intel.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <582527ed-802b-f20e-4c50-f6f2ba460c4c@gmail.com>
Date: Thu, 27 Jun 2024 15:24:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b6f4adee-76c2-466d-9d0c-f681fe32baf8@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

On 26/06/2024 10:05, Przemek Kitszel wrote:
> On 6/25/24 15:39, Edward Cree wrote:
>> On 20/06/2024 07:32, Przemek Kitszel wrote:
>>> why no error code set?
>>
>> Because at this point the driver *has* created the context, it's
>>   in the hardware.  If we wanted to return failure we'd have to
>>   call the driver again to delete it, and that would still leave
>>   an ugly case where that call fails.
> 
> driver is creating both HW context and ID at the same time, after
> you call it from ethtool, eh :(
> 
> then my only concern is why do we want to keep old context instead of
> update? (my only and last concern for this series by now)
> say dumb driver always says "ctx=1" because it does not now better,
> but wants to update the context

Tbh I'm not sure there's a clear case either way, if driver is
 screwing up we don't know why or how.  The old context could
 still be present too for all we know.  So my preference is to
 say "we don't know what happened, let's just not touch the
 xarray at all".
In any case the WARN_ON should hopefully quickly catch any
 drivers that are hitting this, and going forward new drivers
 using this API shouldn't get added.

If you still feel strongly this should be changed, please
 elaborate further on the reasoning.

