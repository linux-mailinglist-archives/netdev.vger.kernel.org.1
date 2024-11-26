Return-Path: <netdev+bounces-147377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77F79D94B4
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D929282A7D
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B4F1BC063;
	Tue, 26 Nov 2024 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFKsGixv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C700E1B87DC;
	Tue, 26 Nov 2024 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613981; cv=none; b=PLzOkhfucPhhoto2bkpKIJQ5MDkMFpZSCOpZbIZp4F83yUkOPfiJGCzkZgra8L/FUT8TqYeGwP8G2X3k5P1p23jOexlfyp8PIymJLKfH/2/HDeVytrDbVGJOEm7BBGJklVr7VMSUhtAZOay65meqZajsiFLWARFOTGZaSd4DAps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613981; c=relaxed/simple;
	bh=x5vz3UvNPlBdlG60StyTVo9p138kaUqViCWZ0XC3kVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLe/Ms15hYMHhgXMAQId4qOgq244XzkRmdpnVJ10qCwcoUB1nVZIgqZ6XJTGE8JIVZnDroJyquZofgpCtTan162WrCH3rir8zsWArOsy1Jr7DL8+yI2JksUAupvKYT6fx0dZFeHn3zYY/ryqPsGySu5QaaIXzFmw9tYLE5ty5eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFKsGixv; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3ea55a2a38bso584732b6e.1;
        Tue, 26 Nov 2024 01:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732613979; x=1733218779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5VqTNP1l3I0fkOuZ3WrWUQyb1/49E8EQXioZGwnik0g=;
        b=MFKsGixvD+9eJSCnbOjLSu8R1F3nLmWN5vBUZVVms4M1hzpOl4hRj6k49N0oFfXXMB
         Mf9pqyGkwYlWMdAes3JlxwpWyi6k/q9D/l2R2jB248F23QsM+ya/4Y5VjvzvqkMnf/o1
         x6N9JKQ9NqA+doG29aPJXWG6XKIMwwkthWt6d519JJcbQ+GF1A9SHoMTnk/hvcRF6tPm
         u5FriqD3nxf2zZRfvO8to/YRT+xYHIdE3q4uRCcsyCV2zeOEnSw6muLkS/Q2vvAZbvDr
         fX7U6W1QCuEhmpd7xF3rOMT/+3q1xteiAwgSu1lrVMCQMY5bu2rRJidX/rGmbS/Shlz3
         cM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732613979; x=1733218779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5VqTNP1l3I0fkOuZ3WrWUQyb1/49E8EQXioZGwnik0g=;
        b=rS53xcxawP3F3Ol1kTFgEl4ljZ19LmGUbHZLqS8/3VZ/o5UPMDJbjuWS55QcZSrYPP
         hx+hqD5UQ5UjYThtPLaCPjvaSjL/+Fgt7tXwhrlMEVV5X9RKMDJtHfQ4gK43TANkpaZ4
         OkwmZj3ZYygFlyRW8L9M9BnSBru3LdQ08T4mSOd8TTiQev7s+99K8iOpc/DmjtC4WxDC
         thiJs5M61EQvM1NUAIzUiZ8kMXy1vkWNMuxbmnp0ISX/2mGiH+y3XC64OYnOXrKJZ2M3
         BvYOVx/Wzh2W2/Z2yYsLwX4x/9gKVPGQ5SLpu1i2DryzXQyT13fjyu3daxWPshx7T9r7
         Jh3A==
X-Forwarded-Encrypted: i=1; AJvYcCX1vNpXOiBDTudc0bOU191ejyB/pojWSkZ29L5T9gCsbp5H6D4FT7dkKCBK2JO18J59Wgf+BVO0Wm/mWYQG@vger.kernel.org, AJvYcCX6wtAs7U0kwd/49WgPA/lIVK8AjUTghnmIN2aIj5jwdHgu2qwUTNy5DfBM7kRv//EHz58DLDDEV9U3@vger.kernel.org, AJvYcCXhRUdhCrKLZj/vEe2im7T7oOKCcQSVMKcae+rkI/OAf7qW71M+mqxyLHyRaGNU4mwapnUc5Lcx@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ1jHbxdEmJosLKbPz+BT2aOwb6QBeKunoguYjRPj0Y4iO4pJZ
	FSrEK9MGPpT6xxQUwhmkhs/XvOaQD9j5OFd0c/1c9C9f3yQDFHzW
X-Gm-Gg: ASbGncvUx5cKifdopJVgOdfWOqhSCGgTj+Jv+Ee+F9KAD6Ip+B8RrbNc5kKP7yVDCwG
	4GbT5PBmwVmkHS21ZqTqNwlin43YhfeKPPc9rQ1Kc6wHMNP7ITbP5+8/UoUm+DN84zWLFdueK1B
	oOHAUZ9ZVqAk7AH+8Q72yJNu/iz0FeAQudN/p4ih3Y0fJdVj0MvJiySwZu3rmlnKxnCTRHCK8u2
	pK4mDHurBTXlqilo/4zUbCUkgmn1fZvVbAt8LjA5VRV6sXNemdb/qm5/TniN9JCL6+qtl1DLRQT
	rF3X66GGegtpONqpdfhTahRvJXrO
X-Google-Smtp-Source: AGHT+IGrPjDu68pnnnryOtllFazbBZWaKbpvb8qp33lzobhDwUA1rKma6IACU9y0c2nXW4nq4Bk1hA==
X-Received: by 2002:a05:6808:2395:b0:3e7:5cfa:87d1 with SMTP id 5614622812f47-3e915aef033mr13135476b6e.27.1732613978760;
        Tue, 26 Nov 2024 01:39:38 -0800 (PST)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de531247sm8159148b3a.104.2024.11.26.01.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 01:39:38 -0800 (PST)
Message-ID: <75e4881c-8b04-4b57-ab0d-e7eb18b31a84@gmail.com>
Date: Tue, 26 Nov 2024 17:39:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] net: stmmac: dwmac-nuvoton: Add dwmac glue for
 Nuvoton MA35 family
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, peppe.cavallaro@st.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
References: <20241118082707.8504-1-a0987203069@gmail.com>
 <20241118082707.8504-4-a0987203069@gmail.com>
 <klp4a7orsswfvh7s33575glcxhlwql2b7otrpchvucajydihsi@dqdkugwf5ze5>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <klp4a7orsswfvh7s33575glcxhlwql2b7otrpchvucajydihsi@dqdkugwf5ze5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Uwe,

Thank you for the details!

Uwe Kleine-König 於 11/20/2024 10:56 PM 寫道:
> Hello,
>
> On Mon, Nov 18, 2024 at 04:27:07PM +0800, Joey Lu wrote:
>> +static struct platform_driver nuvoton_dwmac_driver = {
>> +	.probe  = nuvoton_gmac_probe,
>> +	.remove_new = stmmac_pltfr_remove,
> Please use .remove instead of .remove_new.
>
> Thanks
> Uwe

I will use .remove instead.

Thanks!

BR,

Joey


