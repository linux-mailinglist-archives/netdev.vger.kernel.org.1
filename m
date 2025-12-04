Return-Path: <netdev+bounces-243557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF55CA39B2
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 13:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99178304E15C
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 12:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539DA33F8AA;
	Thu,  4 Dec 2025 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBx5tQZ0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mi/TCkEx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D523328EA
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764851355; cv=none; b=eJeOL3HZQtHCAw0ZO2QW7OeA8BXFKolyt30iulLLokMuOvBdC6kW3Y50+lF66lQNfyXUS9ZDf5n3IWdt2ceosnqx+FPTtt2j7RhTPJsQeBnwnZXaocERE+mmkUvHf4OfSTgyGDs42iQqew2/cgZ4IY9UrBYFT+GrmQUox7EOFjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764851355; c=relaxed/simple;
	bh=aSIBWYCNwgDk1UlfAAk8VUbh+jdliIdHqhPEAbJD0os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDxgHNj8FYqQKxjl5n07BKNReQJSIKnUnFiEXceXOL8hFCMP383WFIKcDvnxrCbGBQEX86ZyH04Z2tb7pYlfmqEFyOz25izh0Anq2/UozVsJIhMCt026XY8gpJg+imjzl+Ue5Wmoy5B+zlWFGFFKlGGbzkXuLQQPHh3YZl+E2DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QBx5tQZ0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mi/TCkEx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764851352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2cw6+693ss+qtfKEzOVnBtcb+kbTVg/8yjh0OUOPKCQ=;
	b=QBx5tQZ0Z7kZGi77R8+n2Jwr7IRJnT4/9Ggm9bEtV0NgbSekc+54BepaMkknsbuEW+r3za
	VwsuLvDz2Y2IuEMkP+4f9pzYqEZl6gZ00m4EJHpqlbtL5sATG54jP7eiqBlxqSLKwaTRRH
	RnRrwtyiF1z6EjfVyDRwj+09XADrndM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-b7qAy4OVNd2PZdnAJq3pDw-1; Thu, 04 Dec 2025 07:29:10 -0500
X-MC-Unique: b7qAy4OVNd2PZdnAJq3pDw-1
X-Mimecast-MFC-AGG-ID: b7qAy4OVNd2PZdnAJq3pDw_1764851350
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b3c965ce5so966116f8f.2
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 04:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764851349; x=1765456149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2cw6+693ss+qtfKEzOVnBtcb+kbTVg/8yjh0OUOPKCQ=;
        b=mi/TCkExqJt736gs26Cjj4f1tdBXLDMrK8f0ELj1P5y7ak8FVIkjf9SgRVn+SKGCsn
         WsBowRBZZFNnrS6ikw9Z9uAxCiI7abbMS1sUh8Rgq3bCG2ama2zG6KyRvfQmRXttYvlc
         Q/6uPSN+sa/GfmgLRy3mhLBaY+geoBcTsIVIswoSsqkJHimNhyj8hguaMJ/gr5fc/Jcx
         aBcuANbIxFLFt5eLKm2wlHXaiuPA5AQ+qbe3ha3s7TpwQ1VCurwmvuMYlrI5FI5bYj90
         tcsJzODvTrpS/5K9dRNDCoYrOCnBlV73NBLRpq9KMqEcg+mba4fO8TVTMVywUPT1EbZQ
         lP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764851349; x=1765456149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2cw6+693ss+qtfKEzOVnBtcb+kbTVg/8yjh0OUOPKCQ=;
        b=DUSwhwWS+cXXQw7/b8s2G3Lx1GfDoXnA22ph0dnUfz+98hO6x1UEiDHUkIDGPZc5Bw
         tbrGVLx4nRle1hNBFl1cYCplLTJgRC3UGZd1Ei4QYTjBXLglO+DEjaEIorrPSHReLce8
         xx7wEF9yzHTJZ0ObBY2RZNR2iR9Uj7iY24iLrVrlQoQZIPsS/tkP8ARdtyfYPLKl6Oic
         aleMwDL+dP2lQyUBfE+K2gsLAJFOh9KlIWtH7k2hquKKLByGNGQCQEDGCGPNl9IsUgUC
         0CrDlsCa1V3M7hGM9vnrHmHeFkL9qnQBZdrDpbp2SrdYOkOUlgJuVfbrvw5ntDcvQlId
         x5pg==
X-Forwarded-Encrypted: i=1; AJvYcCXpA5tfm/wTvm8RKTqpvilKS+qciPfxfPBQpjnRocNDO3Oacb3I2bcdq7giRCsbF6XQEiU3lig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0xM1yREf/Fez0bj2O3ycPCyOQ0U/V5/M9ifsiU+sNzztQBrGk
	4Y+7z6HOGlJqSpHzJq6PGCzAPSl5vUMwWkNyxjf9LleB9rb1a1+kLXEfMEc2pTMhfuHw73KgE1F
	8gyiBgZ7bnnUTNeAPvdG5yAX0DYOxTvT5Nc2LCvnjbUplMJ39R8nmNp8FSvOpvJXm4Q==
X-Gm-Gg: ASbGncvilIsUbKehwcsOo3GF+a7YHrbwtHvdmBixxmKJMhTn981MJR5WHhOhie0DMkX
	+n4MZ1SfJE+vaaccLWP0V1QH93h7IRxDCp0IvhoiGKKFKBbDIcJojinFB+Zp6spnw3pqvNXVWO/
	mPHuSqvMvDaAQSUx1SYpRMX2Hu1tPYPSUkpHaDu5Td+8dWFfMrIQvTdrxvm4Ef8xm5Z08Zls/Qx
	SxduRTkqaYsowtlKUlEkA3SBMbMJ610Ucvn19sYzO683lqJdJXxLN/QEodLLxRoM+b/UCIZiS82
	fS69sG6UpE6q8RAlKQbgi0kVawPOIGAiB89Iv2NfLb6ptIa/b8imW6f/hrdKxl29Veqkwy4ktPw
	DhzTDSIcSNOEB
X-Received: by 2002:a05:6000:1865:b0:429:d170:b3ac with SMTP id ffacd0b85a97d-42f79800d49mr2643741f8f.13.1764851349475;
        Thu, 04 Dec 2025 04:29:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1MUzLjZeszsPNAFDddkwTC1qrZue+HIEjQp/Zp+cxbNLvb7xYNmwaGkexh79w3v5hDeQ5Gg==
X-Received: by 2002:a05:6000:1865:b0:429:d170:b3ac with SMTP id ffacd0b85a97d-42f79800d49mr2643707f8f.13.1764851349024;
        Thu, 04 Dec 2025 04:29:09 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d22249esm2948337f8f.25.2025.12.04.04.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 04:29:08 -0800 (PST)
Message-ID: <171b63b4-44f1-40e3-a1ba-a504c77a3d6b@redhat.com>
Date: Thu, 4 Dec 2025 13:29:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: mxl-gsw1xx: fix SerDes RX polarity
To: Daniel Golle <daniel@makrotopia.org>, Vladimir Oltean <olteanv@gmail.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rasmus Villemoes <ravi@prevas.dk>,
 "Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>
References: <ca10e9f780c0152ecf9ae8cbac5bf975802e8f99.1764668951.git.daniel@makrotopia.org>
 <ca10e9f780c0152ecf9ae8cbac5bf975802e8f99.1764668951.git.daniel@makrotopia.org>
 <20251203094959.y7pkzo2wdhkajceg@skbuf> <aTDJNvLR9evdCaDl@makrotopia.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aTDJNvLR9evdCaDl@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/4/25 12:35 AM, Daniel Golle wrote:
> On Wed, Dec 03, 2025 at 11:49:59AM +0200, Vladimir Oltean wrote:
>> On Tue, Dec 02, 2025 at 09:57:21AM +0000, Daniel Golle wrote:
>>> According to MaxLinear engineer Benny Weng the RX lane of the SerDes
>>> port of the GSW1xx switches is inverted in hardware, and the
>>> SGMII_PHY_RX0_CFG2_INVERT bit is set by default in order to compensate
>>> for that. Hence also set the SGMII_PHY_RX0_CFG2_INVERT bit by default in
>>> gsw1xx_pcs_reset().
>>>
>>> Fixes: 22335939ec90 ("net: dsa: add driver for MaxLinear GSW1xx switch family")
>>> Reported-by: Rasmus Villemoes <ravi@prevas.dk>
>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>>> ---
>>
>> This shouldn't impact the generic device tree property work, since as
>> stated there, there won't be any generically imposed default polarity if
>> the device tree property is missing.
>>
>> We can perhaps use this thread to continue a philosophical debate on how
>> should the device tree deal with this situation of internally inverted
>> polarities (what does PHY_POL_NORMAL mean: the observable behaviour at
>> the external pins, or the hardware IP configuration?). I have more or
>> less the same debate going on with the XPCS polarity as set by
>> nxp_sja1105_sgmii_pma_config().
> 
> In this case it is really just a bug in the datasheet, because the
> switch does set the GSW1XX_SGMII_PHY_RX0_CFG2_INVERT bit by default
> after reset, which results in RX polarity to be as expected (ie.
> negative and positive pins as labeled).
> 
> However, the driver was overwriting the register content which resulted
> in the polarity being inverted (despite the fact that the
> GSW1XX_SGMII_PHY_RX0_CFG2_INVERT wasn't set, because it is actually
> inverted internally, which just isn't well documented).
> 
>>
>> But the patch itself seems fine regardless of these side discussions.
> 
> As net-next-6.19 has been tagged by now, should I resend the patch
> via 'net' tree after the tag was merged?

Not needed, I'm applying this patch to net directly.

Thanks,

Paolo


