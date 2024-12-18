Return-Path: <netdev+bounces-153116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C819F6D00
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 19:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55DCE1619A5
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 18:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0324E1F37A9;
	Wed, 18 Dec 2024 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJhAj6Rp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4350F3597C;
	Wed, 18 Dec 2024 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734545878; cv=none; b=rRCxoq6dpC4qyYlJToarxNmpYrs2apsc1Fu4boY3vlXGJ5kG2wgj4IyH8eXveWLIYoojDV/ZdPVagCaZk+jdJmwelRaFFSJK65a1GxO4TR4IvidgJ+n1FRby5cnnqGt6XkESZ9Ro85HdOfaS6QLZPzpT1k8OR1rlDHXVsDItoxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734545878; c=relaxed/simple;
	bh=Bfqej/8h7exhQ/DpCIwAkr+qsz9hqnvbaRrljCHWRGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kslaJxazBr7p8Sc2B3pu6rBZxN729pqy5I/EFT34q+iRJz4/nkXn4RsAfG2mt3Xw1mpMSVbc2dkMDU2wfdRUBSwbbyqiG9yrf+KiWi3+vGqv8Wx36xJ3SqBbzrWzRV5c6nl6WHxIUC5hhXDIfB8Vs5YYGY8r8yKdvzAfQOBPidA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJhAj6Rp; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3862df95f92so3491842f8f.2;
        Wed, 18 Dec 2024 10:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734545875; x=1735150675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D9MO5AgRVeqkAvCvRP1BQ9WqUe1aP3TH6/7vgKbg8bM=;
        b=JJhAj6Rpx8fIiniBkZ8RLgQPvOy2sVg1x5gdEyWy8wuZLYAXaXRcEVDd1HWGjJBw3s
         +clqKUnWzLKwaBLZzpQu+9001pHvq/wkKc1aXRo3q5FbVJATCxGmvaGMB6dbxCEXXJM1
         3MbRrObEqwVTC3I+39IrT2a1i4eGr0hhymP6kU2SNFpir0E053Pbt6b2P1acNe9fIiR6
         KJyRfHJHx+kZs7qvSqvYyGNQ4ZlE/7b5ofi5vR9kps3FWFNNL8fjQLomR6J6mEOGlXdK
         QkOmFubuh/+aIse+vpxM6lPDd3fS7xQv7aTDFU931YkKY/0wyrHf5BpQgpJdkK+dUNJv
         /2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734545875; x=1735150675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9MO5AgRVeqkAvCvRP1BQ9WqUe1aP3TH6/7vgKbg8bM=;
        b=DOiSCBxHfKerIIL9eF4N8Wxp/HRdvnU0zBvaX+BpUV2HtbtV3y+lZCaazSo+ptanmJ
         N4XwtPRkz11oHbf5HOk7rLG4dAX5GFfm/EU/kGM5zo194S/rt4Kkg0CkdbBHjwsOK5WN
         2RFxnaq6T2kMdzVPXrsVEZR88Xla8k8tl36SpOAa/DKJ3RJ9oOXf4C61EXzkAsCRX7Gu
         T5nqRxQ/dHP0DHgZ6lsEGXaIqv5l7fE0mViLAKkAq67TVlfeKjY3Qt7C0cUem48BYDhK
         iIFIGWRx5p1h45omDrCsZIzuwS14aOopB9RxRUDugfp26ww5KkBiEpxEhiwDpBWJN089
         7tSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJQHpau2Dl4ExUaPtrzMvfSSuLi/PIj4vs5QGrHwbf5gavY2Pl82qLbn0TOHJjmklcdrpDqywU@vger.kernel.org, AJvYcCW/YgtW1ld5IMBH4jfcJ4okG2uVk2GwzwacYPXHCH052KYFkbAaV3vz/DAjI18fPsDzc0IYRTc6ekGK8+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YywlOmD/ZM9BE/u7kZydBiM1eYdrNZWM9vVIhr1ED2mi2tRZ9fz
	SLPhjDAF9tNMP469wJfM/9Z+6L20xNyep+aUVadtw56BK+MT0a/qmVPWQQ==
X-Gm-Gg: ASbGncsilIu5lyx9JpiTg4pjMs4owffBcVhjVVIFTEV5kS4zJHk2VwA4X4LYV3kVsPR
	6/4BmtSiX2E9KKBPSG1IN5kR3cz2TGLGRaGhRFDCP7Ht5uVGgzBaVs8LObCDisYdLcs7ocng6Mz
	+9NOoDq1/D+M6cW4ac8XkZYKUdxF/ErKEm4M0N+WYQMxz/6P38SRRJOLeryqpBSbzoQBvGmWUCY
	WrjoQpXwGV3Vev/d66VqvIulfN/G7vVtZMh4Owo/85lJC6TPUpM
X-Google-Smtp-Source: AGHT+IEhFUyB6msirp0NARg569JwgRujMOp2H1OJIbUN6sasReqQB95TuqEOVZ8XfViMi17xDfsbaQ==
X-Received: by 2002:a05:6000:4603:b0:386:3b93:6cc6 with SMTP id ffacd0b85a97d-388e4d5e5bemr3422470f8f.15.1734545875318;
        Wed, 18 Dec 2024 10:17:55 -0800 (PST)
Received: from debian ([2a00:79c0:622:b100:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b01c88sm28249235e9.17.2024.12.18.10.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 10:17:54 -0800 (PST)
Date: Wed, 18 Dec 2024 19:17:52 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: dp83822: Add support for PHY LEDs on
 DP83822
Message-ID: <20241218181752.GA792287@debian>
References: <20241217-dp83822-leds-v1-1-800b24461013@gmail.com>
 <1a7513fd-c78f-47de-94d7-757c83e9b94c@lunn.ch>
 <20241218085400.GA779107@debian>
 <c63316ac-696d-4ca9-8169-109ed1739f2a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c63316ac-696d-4ca9-8169-109ed1739f2a@lunn.ch>

Am Wed, Dec 18, 2024 at 06:16:20PM +0100 schrieb Andrew Lunn:
> > By the way. Wouldn't it be helpful adding a u32 max_leds to
> > struct phy_driver ? Every driver supporting PHY LEDs validates index at the
> > moment. With max_leds it should be easy to check it in of_phy_leds and
> > return with an error if index is not valid.
> 
> I have been considering it. However, so far developers have been good
> at adding the checks, because the first driver had the checks, cargo
> cult at its best.
> 
> If we are going to add it, we should do it early, before there are too
> many PHY drivers which need updating.
>
Another solution without breaking others driver would be to add a
callback in struct phy_driver:
int (*led_validate_index)(struct phy_device *dev, int index)
It should be called in of_phy_led right after reading in reg property:
if (phydev->drv->led_validate_index)
	ret = phydev->drv->led_validate_index(phydev, index);

This would solve another isssue I have. The LED pins of the DP83822 can
be multiplexed. Not all of them have per default a LED function. So I
need to set them up. In dp83822_of_init_leds I iterate over all DT nodes
in leds to get the information which of the pins should output LED
function. Using the callback would eleminate the need for copying code of
functions of_phy_leds and of_phy_led.

I can come up with a patch if you agree. I would add it to the patch
series and then we would also have a example with the DP83822.

Best regards,
Dimitri

