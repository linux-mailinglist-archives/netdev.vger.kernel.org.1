Return-Path: <netdev+bounces-248467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D56A4D08DB9
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 12:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F9C13025A7D
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 11:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61E6329390;
	Fri,  9 Jan 2026 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j86qp2+r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C7A2DFA31
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767957520; cv=none; b=hS4GIN6KUX4oWXIb83BYfKs0fmBoa4kVBj9jrk132+3fGKn7dzAcJz/3b/yHkyY/ndqMgkOXy4yPxFBumuDzokiWhQUBl9K+Dd9npkYwNH5Y8BZPEScLSBDCz1z6m+N07j+oVpurVY/Y3ItqE9ppcu6L5br6eJzu1Er6xaaX+dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767957520; c=relaxed/simple;
	bh=cFE6DfqchhS/MsePbTTtkbZC7OoBsvnKqbnUge9K/RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhuUYojR6VKTQbeFRAWDju6LjG+poOAnFv1BBGdwQPTMUfkfCztyuPMsK1WtUWgXv7DnCuDtZDHGbvM4lZPTAzxtN3PmLh2qRf3IcZDlbukzqu/ctTd1H0F/8zQNAACA69G0bA90rWeWyGtRfdWo5WhCyDDCLOMS2zm7nUNQrKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j86qp2+r; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fbc544b09so3027564f8f.1
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 03:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767957518; x=1768562318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C9BgDVIQLYNmTvVvvLen7v9Kl7aDcwG0aPvsK7qitkA=;
        b=j86qp2+r4zQZhmqQnSb9f+a1ZfxhDOEmlGAJaOsgPeniby3RdiIfN/jtvWWD8EZ8cu
         sICZ19aLO1W5SIToxc4Ne1D3C2kHI2uNvibTUw4ARCFYsYdV0QsppWrVaTlw1PCURgcO
         ft0QzPD1nfTW8HRnj4X7zOXKWpHA2l9EXbcs5YH6q5jc/vChvnxW12dh409r9a9T1DfP
         hMy9dv3rrEYgGm054IpfDQ9Z4F1erc+CXigNiJp7NjsUlgvXK1Ylig/b697i8POaQZZb
         T3Kw1R2X6NdbiR3kLctRMKiWt3yDmCE4I6O/s+Q4ycA42LBCB7AIIJVAbwJ8qq/X3hXX
         gh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767957518; x=1768562318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9BgDVIQLYNmTvVvvLen7v9Kl7aDcwG0aPvsK7qitkA=;
        b=p79Nuk+9Kcth5Al3LjGGmGauAFhwkEKIG2Nv/40I18inNFM7ybInTYKjiQASETrIG+
         PWS3VQRXRZiQ+spvN5pkV/+/9nHzECG30/oY3vxIYqV6gK99HyTf2UhB0SHBEut45Pro
         m5rBxlAw5MtP8g6OfBVnOfI8DxY3Ql+a0gWmkhryYbBTnnslQbSGxVbxC7y0ykkk2cPP
         3WRct8pR+Y0jKVk6cj/8ZuOzavO02c0Acyxwm1nN0dqVu7yApNYGMp5zXKAOcFNmIi+F
         RX+6JVNQRHziGiGWZ7xtCoKXLMpuyBZQ9iLu9BSQQ3gswhNjfZL6uLurJN6GngQK+ZsI
         2+TA==
X-Forwarded-Encrypted: i=1; AJvYcCVM5LjgcI4Hn/HL67EHoCm7UECOXnlfCXl5pYbIDbyIdcNgih/xgD/w+XLsqElrbB41amx/kTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy55dvaOrI/ar/DxYZiVdycuaEabMdd6XSWz/PZjWxBSDs0Nbba
	iWUGh9IGt74ehI3ocH82SEOoPfp/5kshoIay5V7myIOhcobbQ67vtElw
X-Gm-Gg: AY/fxX5OO36qMXl1mgn0TlssQ9JM++KBPQOB1ErvdDbd0dnhT6B2hLsmUSOvsoPOh7Y
	cdy2VudVsuyWG9mbkylh3Rorgrysq1OxEt8B5r/M6HMVBfBe/gHmy570JvUNjUoAKQoe7NQKRM4
	9kOd6y2io6ZuD2LRRp7si/kI0jYDEBN2zTzwrf9K1dhL/r64HerJbG0Gh8s+u4m5fts83gBr/5n
	q5sNvdan1AfvgHPYLSQr0BL9cohtQKC6IfLw16b7Lbp4jMytzDfJLBocuGLhxaGEzoQ39OP/7oi
	NXvO49DRvu/Kmsd42da3sPwGH32o7/A9o4+W9Re5HMdq9plYHBPS5X0NKydc6boKGe/vTxUbSe0
	nEWCZ1G0GXUNkoGM1ssG6JPis25SdW7YK2R+hq1VNh2blHytX1OG6LREo/ZaQchD/mzHwtsW82J
	TA0ofMzsKYNSp8qIxSAXV9zMmPBOHaPYUtzm2bVnFqhXW5dqZrqjjvn2EHm1VdRR+/nN41eG5Dg
	D62IkMPkOPF9NvUM0q8WIKSOYJr7BC1yVrLXbjxBkymCauqLhnohg==
X-Google-Smtp-Source: AGHT+IFG4cDRzbpnu8yIfh89Ae8ZJP4uz288m7TYW/NsoAPQ3KmUN9edUogC2QzZEC5p0JaDgG79QA==
X-Received: by 2002:a05:6000:144f:b0:3f7:b7ac:f3d2 with SMTP id ffacd0b85a97d-432c37d2e34mr11549297f8f.43.1767957517581;
        Fri, 09 Jan 2026 03:18:37 -0800 (PST)
Received: from ?IPV6:2003:ea:8f34:b700:c079:f905:5470:9a28? (p200300ea8f34b700c079f90554709a28.dip0.t-ipconnect.de. [2003:ea:8f34:b700:c079:f905:5470:9a28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0daa78sm21938297f8f.6.2026.01.09.03.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 03:18:37 -0800 (PST)
Message-ID: <74dfa0bd-8917-48ae-972e-afbd292f4afb@gmail.com>
Date: Fri, 9 Jan 2026 12:18:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: phy: realtek: add PHY driver for
 RTL8127ATF
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Michael Klein <michael@fossekall.de>,
 Daniel Golle <daniel@makrotopia.org>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Aleksander Jan Bajkowski <olek2@wp.pl>,
 Fabio Baltieri <fabio.baltieri@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <52011433-79d3-4097-a2d3-d1cca1f66acb@gmail.com>
 <492763d9-9ece-41a1-a542-d09d9b77ab4a@gmail.com>
 <20260108172814.5d98954f@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260108172814.5d98954f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/2026 2:28 AM, Jakub Kicinski wrote:
> On Thu, 8 Jan 2026 21:27:06 +0100 Heiner Kallweit wrote:
>> --- /dev/null
>> +++ b/include/linux/realtek_phy.h
> 
> How would you feel about putting this in include/net ?
> Easy to miss things in linux/, harder to grep, not to
> mention that some of our automation (patchwork etc) has
> its own delegation rules, not using MAINTAINERS.

Fine with me. It was just placed in linux/ because there
are similar PHY headers already.

