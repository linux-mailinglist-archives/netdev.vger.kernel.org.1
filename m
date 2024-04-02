Return-Path: <netdev+bounces-84142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBCD895BC5
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 20:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A74628380F
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 18:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B2415AD89;
	Tue,  2 Apr 2024 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hy6CAgtd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A8215AAD6
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 18:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712082716; cv=none; b=SzU2XseyIv74ezUo5fYcbyLD3br1tZ3WeisGAknAFZ51mmmf53AM5o5Kj9jyPWUhWV52El4TVSTkObz842fzqQNaRHFQ2UEy5EDTTNkouNCbeIchDseKHmpRzKULimZWdu2+9MAYP1Hdbkav5AjGLB/LqwQsDDWJyqoBKuXgOkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712082716; c=relaxed/simple;
	bh=ZtEzkevvYrbsBCpk4vt2VpxG94oQF7dBbJS1xUxcuHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7FSe0mIL7hnmJ0lfm/0dioQdeHRQ/bYEWX91/y5867YKDZwWkJdekh6awDDQgL6XV5DB9N2An6i/iveJC6MZnUcNtHis53AMq08x1Gx22L35g2eRLD66tg3M9YTDFEs2jV7cLy7uPf27DCN/gSyr3CCBaxbKlTUT2xQnXYzsRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hy6CAgtd; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a47385a4379so29980866b.0
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 11:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712082713; x=1712687513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D1RyXym3lIAycfrQv2LUeFbMEteI3ICy1L3WtaJTa/E=;
        b=Hy6CAgtd7ZBzhD9CzL3jzFdTxhiUGFMFO2zZrrg79huiXZkYcFkWoJ89l3CuQReml7
         F+qROgrxeYkfP1lY6lD2AYF+R7LkAIblebaLb9dXilYMDyzFfvwmAEZmfTqxfuX+iWVZ
         OlsXcFRTcX1ZVQJBhBXNUamGbayg86NRQN1VDJO9zP9Cp+zsGSN4Az/u7YyuPeV5//6l
         MX2x7gb/pWPKW/rvHdYoSi/Zfx4qbNogbvfOhH8g/dQNN0N6Tm5pbDNLP7OdB+KmCrPG
         ve2RZBNXrooqM+jEWc3u+LghnxqF2CGECuXRjXabfbjkTOQP1URqWLtcLtdLBHZcaPY3
         cvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712082713; x=1712687513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1RyXym3lIAycfrQv2LUeFbMEteI3ICy1L3WtaJTa/E=;
        b=lakqBHNnQSipggZFgaGEAeL/cpgj/20mijHf4jeoBVMnz+ns25rUPUd1pI2J1hImEg
         IupYxN/7HnI67VwILB50azXl5k/6G4C3pwZxmLpll4mLG3vKWkKxKtmE33SKzZA9r7pq
         5Laq729d1eVZsTVgfziTCHQzOmL9YsKjHq/LPrVa2IR+Fc22rVt8fT3pudmxVUC30neK
         zqy7wW4sqwRsp2oSxFe4BKfK9kdvLSLjwHnzQJcvkY5oSlDdiuxPOOqEWAXKdXHasmlD
         E3/6E5NIrzFBpg4TjuKjhi4xW1bxnvdgS2v2naOtHq5BiekPsMQt0ua3KpEjh83naGzX
         XwvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHfVO4Dhq0Af0AjfCo+42jBGyMr0RjwD11cg3uLhFpCGscV7Vi/LKHqt9d6v8zWm++8rSe8fRu2XEx/yJJJ1SL2MK+AD+b
X-Gm-Message-State: AOJu0Yz2B93+cwGOpbjHgMRICFK0Bdw+k8xVKY3ogPrsVLpuo+LOyGpr
	oFDpSrqv9UA9lpU6MJxvsFePj+ICmBQTSd4r77LtxZ4FyAk8DP8R
X-Google-Smtp-Source: AGHT+IE3p+d9Hj9mTWrlr8eVQJpSqqRwTtCnQCYQYjdZ9H6/msWZTWZwCQ+Vco5YX90dfwUpKBlwdg==
X-Received: by 2002:a17:906:9b1:b0:a4a:3b69:66a0 with SMTP id q17-20020a17090609b100b00a4a3b6966a0mr237786eje.15.1712082712957;
        Tue, 02 Apr 2024 11:31:52 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id q17-20020a17090609b100b00a4e0a98befdsm6792934eje.213.2024.04.02.11.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 11:31:52 -0700 (PDT)
Message-ID: <c493af30-053e-4f05-be81-fb701a84951a@gmail.com>
Date: Tue, 2 Apr 2024 20:31:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 5/6] net: phy: realtek: add
 rtl822x_c45_get_features() to set supported ports
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org
References: <20240402055848.177580-1-ericwouds@gmail.com>
 <20240402055848.177580-6-ericwouds@gmail.com>
 <ZgwnHhUnWXC0buuT@makrotopia.org>
Content-Language: en-US
From: Eric Woudstra <ericwouds@gmail.com>
In-Reply-To: <ZgwnHhUnWXC0buuT@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/2/24 17:41, Daniel Golle wrote:
> On Tue, Apr 02, 2024 at 07:58:47AM +0200, Eric Woudstra wrote:
>> Sets ETHTOOL_LINK_MODE_TP_BIT and ETHTOOL_LINK_MODE_MII_BIT in
>> phydev->supported.
> 
> Why ETHTOOL_LINK_MODE_MII_BIT? None of those phys got MII as external
> interface. Or am I getting something wrong here?
> 

I have copied it from my rtl8153:

# ethtool enu1u1
Settings for enu1u1:
	Supported ports: [ TP	 MII ]

But I see on rtl8125 it is indeed only TP, so it looks like I chose the
wrong example. I'll remove MII then if, this should not be there.

The thing is, if no ports are set here, then from ethtool it looks like
all ports are supported.

