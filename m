Return-Path: <netdev+bounces-232920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFF9C09EE2
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 20:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BF1B4E1B74
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 18:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F59E2BE7B1;
	Sat, 25 Oct 2025 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iav1FlIC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968FA20ED
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761418755; cv=none; b=GweaUKZpOJTDPHNEj2rZp5ZTj/mE3IZq40y6JkOn8FRUGZZaiY10O391lLwa2a9FtH4znFYpyNBGRn0F4iUYkx/jEbm7kWt9PidiFxKqk2OG68yk9QaACzgIuqk9POmA3Djx/CeUjKyNt4sw6PmDRV7I2R6HCGCnvBNq7EaSszc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761418755; c=relaxed/simple;
	bh=8IETgLyA0+Ngz3PKpmB401z5C+rsj/BceKj1LriSqkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AiUZFHiFE01HUoiHZThDnLtQN82HCxV9tlgP0sSsN35+ABD6micOTvC1HV05TFKtJRv/Jj3NTsDSuhBiJg8RLy2QIxN2VPtaCY9YbjrdiNsubYbXzU+ksbAqJLe0BolOdvC6cnof9ZRncCF9XlfvdTloViAebD10hyZ/s2tPAVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iav1FlIC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-475dae5d473so9068155e9.2
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 11:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761418752; x=1762023552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GGPaeWFh3EC8/caqMOlhaVYPJ2R1kTiC1Nt5c5qtc+E=;
        b=iav1FlICnL7bsERa8+FA6zqeI2ViXmw+FKf97R12QLrXzqGzzOOHb2OSeTUIGbfeVc
         XM4hR8BpFHboPJgHkCvqAiWpW8X6j3usNpWLWjNS9FFYL47jQpmKyp+fcwCxXwfJGo6L
         ZjJwrIXiWjAz7oq1beO4SXwYBbSw8yAZdZeBcJSf/VkB6u/jAFlBaAKX/I6nA5WGH1zP
         spgZILNLMJwCEWMgbcCDeJSzH2pPMZC+NSoyeMFoVXUa3ak/sB4xZE1MIoJizk31ZCA6
         lhdrO8tpLQZ/m7QX30DrDf+jVCTj5xzecASwmrwsV1aE++ZmLdFRcCupVujL9h6/898P
         hViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761418752; x=1762023552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GGPaeWFh3EC8/caqMOlhaVYPJ2R1kTiC1Nt5c5qtc+E=;
        b=oNJCwW1kceSkociXh9cEJdORtM0HNfF70pubBN0cTP7TX28wcD8tW1ROQtwrep17Cl
         UWli3AP8fLwnG0P0AXU4DX+ndDqaXgNmeOmXKelPpDK8cjlZS0niik01Ps5ulPewDQ95
         GxCaEFejceaHScDFRasBHHaSaYQvXzkin7b7e4fXWFZooI7ZBxYHgWiUZ7Qs1sucmZvd
         G6T7P91Jmz98uaFlJsKoBbHBg0iXHN+EXs8Do3zN1EvA7ywBke6+n4dKsWxEWDwu4a17
         yzMQW1iu6p4E9dWdOTfNMjLSBK1JFo98qjmuFkD6Ff7HMhdkJ+WD/o8mb+vG2f7LQ0kh
         Rmkw==
X-Forwarded-Encrypted: i=1; AJvYcCUcXV8ffZgd2wLdyodA65gDln5VbQiawd+j9U7li+m0zc7ncw3FleXs6M8WeghoLAputO4v4Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZhifNAPqdCqp6LkBTyG49Tc4M2m6ErSVGwm88QgyVhNBW1n0a
	LE+AV3w2WoX+IhZlMHnoBZzqDHHNPWUkRaOO1I2fvFvsVA+qNbc2Ils3
X-Gm-Gg: ASbGncvidMu/FYjWa5rHt+HDdEPQfOFKDzDzeWjhwPk/hK7WheYLsl5gBBcMZ2BWth1
	XmAhb0ykfOFt8a13fWnhem/Jwkhn4hQApDn8UtoStV1Rjcy8kAEy4hox9Olcb/14Z2DOwVMwvHF
	5xvbM1h/eiZulAb6euzOMu4dP8DysL+q0VC6+2nU3OzSV1iMxRfGYCKQS2sZUfMCzGi44hUq8Aa
	Xadt9Nn2Z5IIaCkLZWvVRPAHbqE04h6UeA6hUZlh9VFat7l/G7HKw/mmKGe8EB+5IvpizTQcLpe
	VCnTDwqL21RLvqhF9UmJqoOnnLrIHL4XgT5FOpYWL/OPDAmX38P2k3fmnCDQkXrGFbTlHev5cq1
	nqicCJnKGdE7TfuBVka9rQxqRg/8ydlsBobXcKqOMhgx3QUEctpSrzFVRL19sVj51JjCt1ULSAY
	qPe89FMtyZegJyxu3OXLleN6JC/XuPFm6g039i5s0WzjQoS+Sv46Cn2jI1cfADZmus+k5dlyGJX
	AkZMsIodO6nBCngYRTboKDrR2G8/Zs16XV1jsYhYveyWdhGuHgxcQ==
X-Google-Smtp-Source: AGHT+IHZl0AnjfRRRKOYUZEXYm6W5vCY/z1ACKaTyuhGbN8vVZt4Y2hVsl3T1hwFAEO0MkBJHhP5Ng==
X-Received: by 2002:a05:600c:6085:b0:471:133c:4b9a with SMTP id 5b1f17b1804b1-4711786c79emr272187845e9.6.1761418751765;
        Sat, 25 Oct 2025 11:59:11 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f39:8b00:d401:6211:9005:e76e? (p200300ea8f398b00d40162119005e76e.dip0.t-ipconnect.de. [2003:ea:8f39:8b00:d401:6211:9005:e76e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd374e41sm45569965e9.12.2025.10.25.11.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 11:59:11 -0700 (PDT)
Message-ID: <17b8fed7-fb42-4409-a831-1bdbf0eac33f@gmail.com>
Date: Sat, 25 Oct 2025 20:59:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] net: phy: fixed_phy: add helper
 fixed_phy_register_100fd
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <d6598983-83b1-4e1c-b621-8976520869c7@gmail.com>
 <20251021182021.15223c1e@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20251021182021.15223c1e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/2025 3:20 AM, Jakub Kicinski wrote:
> On Fri, 17 Oct 2025 22:11:44 +0200 Heiner Kallweit wrote:
>> In few places a 100FD fixed PHY is used. Create a helper so that users
>> don't have to define the struct fixed_phy_status. First user is the
>> dsa loop driver. A follow-up series will remove the usage of
>> fixed_phy_add() from bcm47xx and coldfire/m5272, then this helper
>> will be used too.
> 
> Not knowing the area too well it looks like struct fixed_phy_status
> is an argument struct to make it easier to add / pass thru extra
> attrs without having to modify all the callers. This series goes
> in the opposite direction trying to make the callers not have to
> declare the argument struct.
> 
> When reading the code it may also be easier to graps the code if 
> the definition is local vs having to look at fixed_phy_register_100fd()
> Granted the function name kinda makes it obvious what it does.
> 
> Lastly: 19 insertions(+), 6 deletions(-)
> 
> So the improvement here is not immediately obvious to me.
> Maybe it'd be easier to appreciate this series if it was in one
> piece with what you mentioned as a follow up?

Makes sense, I'll prepare and submit the full series.

