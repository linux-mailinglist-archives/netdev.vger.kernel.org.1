Return-Path: <netdev+bounces-217443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB319B38B56
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 23:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 807E77AC00C
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 21:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8134D30C625;
	Wed, 27 Aug 2025 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCHn1LHk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC927280A5F
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 21:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756330182; cv=none; b=C21VejYRyA5IlguTAf+aSyqhuUnoIcCk6O0O8Y7OfKufpREpiDK4+ngNosUJwl2c+j6DuPrucT14x7UJqGDycpCvdIb+xDhHcea5s/c8hIGFRvpSEiFNJePeePSAXynNXizf8a3pFdPAC3mB89pRkZMpVjSJS26XcD+VyYOWfWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756330182; c=relaxed/simple;
	bh=eM0brod7RzR2A1wMnlvVP0hb9bLCRCpIx+xpRUuCMCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tqllwk7s4iJb6HpyTRkqxlcp5pbbvLMiPlOaeDR0WNmdFh0SJ0wCZXhV3pEhZLFferOWli0URlRn8w6HKHT96itWx/lL2BAp1yvsyyhsvq9lAweUv6rx/5b94qVDH4ohsnsD510oVi8NXXUXLNhnitSO3WBpAI+bSz0qkeSGYus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCHn1LHk; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3cdc54cabb1so114208f8f.0
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 14:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756330179; x=1756934979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NJ94hmW0Goxas7B35HqOH9O/NglOR9+/zo5wZDjOxGs=;
        b=UCHn1LHknH6ECMY36fdP9Rk0hkV9QHOjcQNHe/kGU0lcUwLCiRX8X2tj9I9fK/+3HY
         BaxPNNeJlDBCiEt9TEd+Az++qPKeEMcqEORZKb5GVYYY4iBb1u1hC5D+M3kWTu0Ww0qP
         Lojkfi5F1LesR0A44witirYjkbBEtHEf7u0uIb5K1366uzC77OCfuRpHB2tHu7owSFz3
         eKQoMVVSxmSgCBvfTk1tH2xCQb4YCMHHt6QvVHQ+04dgrk6wbOr1Mv05Zs/CXQElXph7
         XwBV460zg9e+CDy8A/jojxHAHCcLZkM4TvS1axbWgxk+qZ4fQ9lF+z+T4vnCtldmkKdH
         2gLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756330179; x=1756934979;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJ94hmW0Goxas7B35HqOH9O/NglOR9+/zo5wZDjOxGs=;
        b=vmNMuUC46zi75drveuqhjbUz8FNYVEcSBWG0sqxCX+mEPaovKTwVFLU638Vuer8aNo
         03CzDwXKsVwGvDQOkA5pqoQ2RZrm98FG/jykoc55dFmW/WnkKpXG90MslWdPxZZ7iXSR
         RPAWxXneodfYplFtJ7ENFg+T+aekEwXD45jzFxJt6KoumWKoD8yQ/3yONdqBZac2CsOD
         3G1jvZmoKlTy7kySWOtzOFJVC2VeRrfUBlgn5X6x5SltxJJrSFRYsLU8otbt3yzqoVFp
         Qp6XY9yYkx7BG1kdZSkXAORCjtsdMm9T57mewWmPPSnIL2vK8JQLul0nnE5human2Ish
         JkRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN+FspDmtKAmnEC7jud790kKYqpTWETTZdaOzX931h6yd3JDbAG740p0MnBEuyUzFqrNQVJIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywejwr74CWVXXpAIte0P6Me2kSft4FilDX/p011yEr0IQ/l+FfT
	DMTV3xMdhXJ5XIYStG5wsHbk2xKQ9kS8fvS/cNm4tfiWNKeGWhTaerOE
X-Gm-Gg: ASbGnct6vNtr3uqnHclEf6wjwvhAKy/qcvEyQt8mTBO5uvFZaQxYEWZVSmL5KNbPsCE
	lVsXTkoL6sQoTNkCGJKghhlfkUqDbSwx73gE7jbCyif3fdin+BdhPOFrS7tGDGns+m2+nZX9Ph4
	hfR6F/b7wULXibHxr0DS3EXQGqIOefZBvH/tTJ8tVC8ujcxwzCYyJ8aXG6Vds/bKHMnUmznisDv
	DjXsrXuBUQf7l5doj4IlKHz+qoe5yrmsR3sv6XHzKlYZ6nJPkeOOAlfS2YzsISCW4yWR/a8qiGb
	bwOvzJGYxnbMpB0iaCCUsFKdPEt29T92DK6Z6/bdPkCVICZb5nWZ4dpDCXeWItShq9PANmFyOPv
	e6JEM1/pFoRIDofEIrk1zkJxUCMkDwwgdZdl57oV3JTNbgP5sH4xKXmbHwEV/UzJsX3BbCg5wLT
	4jKOlBFuJsQtxZMNPErCB4P/SeSW1ZOj/aFoQO3JwCTorq45Eoi+Y1hmX2KkaiJw==
X-Google-Smtp-Source: AGHT+IF3MkkDvks83nwl2FF9QMy+I/ZuzgBTI3VVtbWLgDoNOzgyw/bBScRG1OPEQOfxqzIvkKXNUQ==
X-Received: by 2002:a05:6000:2c0e:b0:3ca:43ce:8a7d with SMTP id ffacd0b85a97d-3ca43ce8e01mr7716812f8f.3.1756330179022;
        Wed, 27 Aug 2025 14:29:39 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f31:dd00:bc79:d64a:f2ec:1eae? (p200300ea8f31dd00bc79d64af2ec1eae.dip0.t-ipconnect.de. [2003:ea:8f31:dd00:bc79:d64a:f2ec:1eae])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45b6f3125ccsm44790185e9.19.2025.08.27.14.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 14:29:38 -0700 (PDT)
Message-ID: <78b5c985-9d48-4383-af34-1f8b09d0243d@gmail.com>
Date: Wed, 27 Aug 2025 23:29:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net] net: phy: fixed_phy: fix missing calls to
 gpiod_put in fixed_mdio_bus_exit
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>
References: <b3fae8d9-a595-4eb8-a90e-de2f9caebca0@gmail.com>
 <aK90BbEGJAVFiPAC@shell.armlinux.org.uk>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <aK90BbEGJAVFiPAC@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/2025 11:09 PM, Russell King (Oracle) wrote:
> On Wed, Aug 27, 2025 at 11:02:55PM +0200, Heiner Kallweit wrote:
>> Cleanup in fixed_mdio_bus_exit() misses to call gpiod_put().
>> Easiest fix is to call fixed_phy_del() for each possible phy address.
>> This may consume a few cpu cycles more, but is much easier to read.
>>
>> Fixes: a5597008dbc2 ("phy: fixed_phy: Add gpio to determine link up/down.")
> 
> Here's a question that should be considered as well. Do we still need
> to keep the link-gpios for fixed-phy?
> 
> $ grep -r link-gpios arch/*/boot/dts/
> arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts:                              link-gpios = <&gpio6 2
> arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts:                              link-gpios = <&gpio6 3
> 
> These are used with the mv88e6xxx DSA switch, and DSA being fully
> converted to phylink, means that fixed-phy isn't used for these
> link-gpios properties, and hasn't been for some time.
> 
Means we can remove all "fixed-link" blocks from vf610-zii-dev-rev-b.dts?

> So, is this now redundant code that can be removed, or should we
> consider updating it for another kernel cycle but print a deprecation
> notice should someone use it (e.g. openwrt.)
> 
Good question. I just grepped the openwrt repo for link-gpios,
and there's no use either.

link-gpio is referenced here (apart from vf610-zii-dev-rev-b.dts):
Documentation/devicetree/bindings/net/ethernet-controller.yaml
Documentation/devicetree/bindings/net/nixge.txt

So once we have removed link-gpios from vf610-zii-dev-rev-b.dts,
I'd propose to remove fixed phy gpio support and see whether
any out-of-tree user complains.

> Should we also describe the SFF modules on Zii rev B properly?
> 


