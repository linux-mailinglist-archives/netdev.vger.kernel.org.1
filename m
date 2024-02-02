Return-Path: <netdev+bounces-68313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAFE846895
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 07:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CBAE28EC0C
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 06:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED221756E;
	Fri,  2 Feb 2024 06:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyVi7olY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5DC8839
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856940; cv=none; b=FQpglEHBvp64q1+//pcyri7tCL0YTCEMqB61sjokhvxxG+JkEm6qNTHK5Ty1TrX6MZbK2IVOJn6IjNq7Nya0HPFDKdq0/9S9HPMn7EfLoDo0ZYzyhODJosSUgWV3i2Hj1gUq19+MWCBQF1rxNOiIVHKxVGxrd33u+rJOnioauMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856940; c=relaxed/simple;
	bh=KKV5FdJu09zQlf34ImVtSkp2fIyle0as5aI9VeevpzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f68t+yZMyGZiQRPbmqE2ySR/QIdl2NUena/9sBywNJRLRjj/HWU7BEjA+lWI0BDl2Qu5YPB0z/VChGGx0vi94QOpWCwHdkxnvc7q9lJEw2mfOSMCdHXSBkUjclBQYQ2noBMOOSlMH0DmqqdKB07t/HLTUGVGsF0PHSNbmKUpfdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyVi7olY; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a370315191dso38758566b.2
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 22:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706856937; x=1707461737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J+mPhCAZTO8qXZbfn+XWuigGuKnc9jyu67YmPlgv3mg=;
        b=KyVi7olYvXmldNhJxVtFndvXW0S3ZYeY4sVrGnWWFfdOzAgM6scQcD//yhlPcW69WS
         vqLykmpvk5AC1SMz5kyWYb0k5R10vcLh4NVHbHupEcwkZHahHPdNShL9xLP7NHDtuYYY
         CriAkmuuGAteBKNELL68ZEufqqWyoKqA/E72QzmkRwhlOsYyAD7VtaA53B/OOjvZ3tGV
         uN+EsrmaLkUXcY47sfDvo9EhddCYLr59pdLm6pZNOIH0UPzNTgvt2S9AlQSIhG4r1PXn
         oWOdwW/BV9wmru6XngDfEHFtuYWdhsvbI5QnKYfv19KdDqoOGIUxIEbfJac39qKXIDx1
         leDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706856937; x=1707461737;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+mPhCAZTO8qXZbfn+XWuigGuKnc9jyu67YmPlgv3mg=;
        b=r8E99CYOw2r0eonBDsIEN6I0MBraMpfzF3SfmR56xgWX1C9q2oIEd7PF7AAjzlAGO7
         shsC+obUD2I7XgpecMAjNxZElSgLQnbG6DPocmjZnxdK8ElSPbD+Wy5uFbLT7TUYu7Gn
         /X+Dy/tDfEChGQxqX2XaN98bYQj7tQMGTosYZ0oa4lQiVNIP+XZ4xzU1L0K+jvBA4av7
         wMeRVhUPcgzxY0J9vaKdOjQlsvEsP4XIkmEOIalw1TrVEqapn1tcgmDB0M540yyM4d/o
         GRd7rzmjNiUyRyrkZCvYfPqSVvWFiXPsltD8S9zAF+txIxAxRMYFm5a/6IvfiXD1Y1qn
         cwMA==
X-Gm-Message-State: AOJu0Yzyds3uAZrRgv1FGHLsmCnDzVuES9LkegTxonK/EgHE2vuv3Sdx
	++XWhkaidCQC+aHJ+gqKealbi+buFRIP+n2zqQ4gDLgpllRgnpZ7
X-Google-Smtp-Source: AGHT+IEkjsw9kAE2qCb6mu48Jz5N+V7EZGBKELHLYiD44c+BsQoX3tpyN98C6zPTFE0Tm6KFNusj2Q==
X-Received: by 2002:a17:906:195a:b0:a36:884b:ed4f with SMTP id b26-20020a170906195a00b00a36884bed4fmr3139242eje.38.1706856936688;
        Thu, 01 Feb 2024 22:55:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU19e/p5O0jJJyYRk5gj+gXeAZCS3VjMvSXK4Y4PR22MOwjYpR0YKyxsi6+ODZJiGaMWAOHPkTcwvxJcH21PR4bT+RZjtia8kKorHOnFuDw412/emogysMwHKbNocN0+RZ+flwaURZPD0XuzYx/ZI2V3wTCfRgFvdvHboYFYSfgUV/lbQ2APTIA+mVeZOoofd03hfjj
Received: from ?IPV6:2a01:c22:7392:d000:5c1a:bcfc:a8a4:5bea? (dynamic-2a01-0c22-7392-d000-5c1a-bcfc-a8a4-5bea.c22.pool.telefonica.de. [2a01:c22:7392:d000:5c1a:bcfc:a8a4:5bea])
        by smtp.googlemail.com with ESMTPSA id cx7-20020a170907168700b00a3161adb239sm550878ejd.158.2024.02.01.22.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 22:55:36 -0800 (PST)
Message-ID: <be436811-af21-4c8e-9298-69706e6895df@gmail.com>
Date: Fri, 2 Feb 2024 07:55:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESUBMIT net-next] r8169: simplify EEE handling
To: Andrew Lunn <andrew@lunn.ch>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <27c336a8-ea47-483d-815b-02c45ae41da2@gmail.com>
 <d5d18109-e882-43cd-b0e5-a91ffffa7fed@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <d5d18109-e882-43cd-b0e5-a91ffffa7fed@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02.02.2024 01:16, Andrew Lunn wrote:
>> @@ -5058,7 +5033,9 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
>>  	}
>>  
>>  	tp->phydev->mac_managed_pm = true;
>> -
>> +	if (rtl_supports_eee(tp))
>> +		linkmode_copy(tp->phydev->advertising_eee,
>> +			      tp->phydev->supported_eee);
> 
> This looks odd. Does it mean something is missing on phylib?
> 
Reason is that we treat "normal" advertising and EEE advertising differently
in phylib. See this code snippet from phy_probe().

        phy_advertise_supported(phydev);
        /* Get PHY default EEE advertising modes and handle them as potentially
         * safe initial configuration.
         */
        err = genphy_c45_read_eee_adv(phydev, phydev->advertising_eee);

For EEE we don't change the initial advertising to what's supported,
but preserve the EEE advertising at the time of phy probing.
So if I want to mimic the behavior of phy_advertise_supported() for EEE,
I have to populate advertising_eee in the driver.

Alternative would be to change phy_advertise_supported(), but this may
impact systems with PHY's with EEE flaws.

> 	Andrew
Heiner

