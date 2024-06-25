Return-Path: <netdev+bounces-106420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B34591624E
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 11:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80E1CB2375E
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 09:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16241487D4;
	Tue, 25 Jun 2024 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5scD+/i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF3B49656
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719307674; cv=none; b=a3qiTBapMQ3Oh16jxfNHwai6VqszGG/yUmkD4yvc8ehBv8iPG8m1W5sJuiI/BrnvcB1QCcxhb5b01Zy5Ao91YZlWqGpz549OSS5Ucu0194fx0cCrEHuCS5j1rOhR5+AyL34bqGqw4pfsJp/z0LGcUs4a0bGAZ5BlpN9aqHJod1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719307674; c=relaxed/simple;
	bh=7ogrpwimxtHfwlPoLIeeXD0uDtKMEy+7ZiLeuEX1dg4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=h0HCTKkfjUwuXzRW88qJM2MbmOlBXO9HLjYE2uTuEVzgN1xlDP6LXQ/33s42yTOyHkWrTGNwVjnRqqddKJFbZwpdWM7qZ59pDAv4rdQZw+bG8MAuLZq9SiRNXbjvfq6qfKU155WVozZT6rvSjo9ft9K2FW2oCRrGib4XniYWiXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5scD+/i; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52cecba8d11so759273e87.1
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 02:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719307671; x=1719912471; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ogrpwimxtHfwlPoLIeeXD0uDtKMEy+7ZiLeuEX1dg4=;
        b=m5scD+/iw9BVnTJQbfsGSrzS57OtJJwL3H5ylT14FatU+ebQq51wH26viyJOMqLg4H
         ut6fDIBCDsmRvvBtTnzehAOu9s1W/jZ7pm9Uvq6V4MlPjD3+ciXcIf1eo8tkGB/4d7tJ
         Qtcws2hsMSpLa+bEOUEy9hdnBjUnoxIeh2X7Zave3zvI/ghUgJRk6Glm5ipnpXP03uGr
         kKy0sxhZCRGQzdAzaUMvNhjOT7/2yGVfTtZms+0HNXghY946ukoX+c/guMZdb1hFQT1/
         msX4KbqDVlEGsECTlTkX+fiiIwQY9CuPk5hbpyOUzye7ytXy51zs8+M4p6TTZ9hAyAgB
         WhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719307671; x=1719912471;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ogrpwimxtHfwlPoLIeeXD0uDtKMEy+7ZiLeuEX1dg4=;
        b=MdXJYWdCz2Lazky8Ds5Gh/F3cYS2G1W9G6SZ7T4L7eNgvl24XH1ve5C4B8Ny9X0pEb
         6EFSlAMyq6OW4LYDJ0LYSfP1HGofuliXgpxPQZ88SVgwrFL3IU2RKsVyMn5yEnKcgglF
         qaoE1ss9DO2Ds12hPwLfKSCwSUwalEovxEQq5R5k41/ULi6UUJFlQJpus7kgi/FWf48E
         FUJnLuES9CEqvZEjo45oJC8nk47lYiHdwRwuMEF8nBMyZKCeh7A8/zIDlC+ZRq4AzaLI
         roVkNVKMDuyY5dRE8kOrVsLhvKxSo8zt1XoNtit0jXaJNC3/L6E2LVGBy5RRBqlt+FCk
         KxEw==
X-Forwarded-Encrypted: i=1; AJvYcCUGfWhi5MxvNR/GHJWSIJPHOyjnxPK9/gZHwSCgud2g62TmOgROaIpSgLIvd9ITXsmVqVK6f6wAEnhkuY+jgm+vJECagglL
X-Gm-Message-State: AOJu0Yyx9C4925MCcZR10eQsZXTg0b1ooIHrABhas84ys7FxbKA5HI2r
	WTVsiSpDHENX1bjEV6KEjhVr4VK0njtWh0w3bgzv+a46UorWwxtn
X-Google-Smtp-Source: AGHT+IGu+3UvCQ+z6DH5S5xbL+sSRR7FXHiU33k4g42NwGMLfHvKYYTSfIscmjxWbBUIT596MbwU3A==
X-Received: by 2002:a05:6512:3a8b:b0:52c:e402:4dc1 with SMTP id 2adb3069b0e04-52ce4024e00mr4144649e87.55.1719307671188;
        Tue, 25 Jun 2024 02:27:51 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366388c40c3sm12397173f8f.30.2024.06.25.02.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 02:27:50 -0700 (PDT)
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
 <08a85083-8c61-8ca5-e860-2b051c043229@gmail.com>
 <90e2bda8-5f5d-409f-8b4a-b2cd12747c95@intel.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <343b81aa-a717-0ff2-d13e-8d7a5249cc42@gmail.com>
Date: Tue, 25 Jun 2024 10:27:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <90e2bda8-5f5d-409f-8b4a-b2cd12747c95@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 25/06/2024 08:17, Przemek Kitszel wrote:
> I know that there are is v7 already, but I don't know if you just missed
> my other comments to this v6 patch, or they are not relevant after you
> answering the first question? (Code is not removed in subsequent patch,
> so I guess you just missed).

Didn't spot them, sorry.
Will look through and address.

