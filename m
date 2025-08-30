Return-Path: <netdev+bounces-218521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 810BEB3CF8F
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 23:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B93D206AD6
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 21:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FA725784A;
	Sat, 30 Aug 2025 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLlM42NQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4D82566F7;
	Sat, 30 Aug 2025 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756590003; cv=none; b=FlHnCAgMjayhQdUmKK6ZwMF/W3TGcmdTcx2iGlP5T+mWR3uWfuhtqqlS1Zydgw/wRyO32dwcJfawN+ckOQAVvGJMj6xkPHoTQZ7orIfMUgrj6WMlWiLH33ryabhGrENkl6Ix5EBfatEnCTDK6GexK4utPgu4bD9CSZ1wIJdvPig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756590003; c=relaxed/simple;
	bh=MAo4kwgPr732+/S3xWgrFOJuk5JKExvcr+mQaCVsKjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A38bnnYprojNTIwvfD2Q5KlizpofQMA8F5/MOdQYCk/EX4+zqwM4a94BMAWrQ6BOndtdwDPlBL/1MzROBiWC7ImSx8hYDLrtBtnL+9fMhk31c7nzCkKfgW/kEiQhP668dCFEfOJCwU6nrdsKMwrcOJXWOwWSYFkDB/rQo2YfH9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLlM42NQ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3d44d734cabso191243f8f.3;
        Sat, 30 Aug 2025 14:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756590000; x=1757194800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9i2CcwLoRc0/4DfODi5u3sulqCWGxz4FU0iotFMg42M=;
        b=jLlM42NQXTQWTL2t18Nobxylre/4R3eJeWRuzJW5kdesdg+tqCLMIasQvM4FfWuBZb
         JJSICHh6GZQnpg6wTrDLW0yB0inOsn1F3mCm3S/cSrdYUdIoho1hvHZ6C70LpCmR5mA8
         U6RJO4TDMDgyMmOVuEfsHnOx+BSbm3m6tQrqemCP880hUnl1jLUqYGX0DeHxrUEOE9FX
         Z5s6rrxaPoayHlzRVqJy8HQfMis6X+9SZ4208luwc5MweuConhnnwi4c5dmK4y6Ug0VT
         yxpWqIu1A+0G+awMWKtfsS5vvKqzHIFo13TzSZ+SfszRGXN3bOtEVyfnvUbX1ip7C6y+
         r49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756590000; x=1757194800;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9i2CcwLoRc0/4DfODi5u3sulqCWGxz4FU0iotFMg42M=;
        b=jUEfDZoau2/tqTNCFVOgfUSfIK3k8q/75zJ1Q1b2jQ0iYNx8qHLgxDtqD6ZQreegGi
         CZIzg8Pmt/ONFRNBl0be9Lmy7nTHDvaUUdQzXnS4ZaMP5IkiC2n+ExxkS/xMwkt2mSpt
         sNM4TcI6PXWLNAsf0LH6krU1lMwAict4Akp8Hl4uGJ2KW3fLI2tKE3/zL4ynOOqTvyAB
         4hEEUSVXle2jxrf/bdbi/QMCx36E6WZBlIA2debGKz2EqYm7OWY5HN5iW9T0EN5YO48g
         AXt+64Q8fqUI3P68je5pAZxCkccuxL2QWibYI//h/lYn6kzNO6litbvVk38H6jqqmQ24
         e+kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqJbKRlwb5o/2+oLNKRjOvqoYm7//UAxYGJMEW657ZMFOEini/TXoUDBqNR2fLWVz8kUZ+KxBMBS9L@vger.kernel.org, AJvYcCXsLBl9oTQVwX/w387OK1W0/jN63HI6S6L28js9mJwSMEKV1U82WKcQ73WJfhO1h/JwExSlep2g@vger.kernel.org
X-Gm-Message-State: AOJu0YxScnMxEH08U007Jrf5L12j+aSDCgeJaiya8TikjUfvWzV1+EiS
	w7JLpj7G+42w80Fz5o9unYZlMS9eCIakteN7RQ13p4gcHKZkrYJkqWt9
X-Gm-Gg: ASbGncuNrSkFkdFnmzc9zMloXOzBTvTtstEhOj42bXXLj3usnsWTQ/+7ZusDxV1ZyCm
	Pugd2r7TY81Uz7posJPeTNKOpq8Lp8/pDdiBwOPeCtkZaCxr6gkknCL1sF4e59Y1AgMS7sE0yzV
	AwYpCrGIExF8vcqzUIlGRmD2jgSlTnJA06hWYNpWaY7ZvktNZ70ETQvnUcdoMSO2EcQfBi1vwQY
	gp/0tbOGXIhHSZ6mMEUCRGvregjhbc2V+GoSyrXTq74W2wYbep7hReOsnZ2qiI65d68jJF/QNB+
	KXE9lUns0O9zJz3KhHyrA55eilyFzKdzAZzPKODUg2Bv37Zbm7CwWVLEP3IVroR1uQbOMERMLIA
	zxLDvUqRJJV+Po3vv0mIm+9Eql4h095QX/YO0p7cUdRfpsJbEAQ4NqR9t42k28ZDD4LnuUSVK8b
	YxW4ZHR10vaqCIA7JidNpC+JYMxdivMvpkbxB61+vEJq5AMcWX9eHYGlehyzZtE8khz3VM4Z4j1
	5LdXg==
X-Google-Smtp-Source: AGHT+IE8zMxy4QIJKmBaOp8B+Mn301+XTbxCl7ZfysM567oIa9PnEQlaczOhMzDV2wCsdIfOswZE+g==
X-Received: by 2002:a05:6000:2007:b0:3d1:abf7:e1d9 with SMTP id ffacd0b85a97d-3d1dfcfb948mr1993389f8f.35.1756590000139;
        Sat, 30 Aug 2025 14:40:00 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2f:9b00:d113:449:b8c4:341? (p200300ea8f2f9b00d1130449b8c40341.dip0.t-ipconnect.de. [2003:ea:8f2f:9b00:d113:449:b8c4:341])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3cf274dde69sm8561940f8f.14.2025.08.30.14.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 14:39:59 -0700 (PDT)
Message-ID: <d2012185-0403-4bad-ad4a-e0468e11928d@gmail.com>
Date: Sat, 30 Aug 2025 23:39:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] arm64: dts: ls1043a-qds: switch to new
 fixed-link binding
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a3c2f8d3-36e6-4411-9526-78abbc60e1da@gmail.com>
 <fe4c021d-c188-4fc2-8b2f-9c3c269056eb@gmail.com>
 <aLNst1V_OSlvpC3t@shell.armlinux.org.uk>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <aLNst1V_OSlvpC3t@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/30/2025 11:27 PM, Russell King (Oracle) wrote:
> On Sat, Aug 30, 2025 at 12:27:23PM +0200, Heiner Kallweit wrote:
>> The old array-type fixed-link binding has been deprecated
>> for more than 10 yrs. Switch to the new binding.
> 
> ... and the fact we have device trees that use it today means that we
> can't remove support for it from the kernel.
> 
After this series there is no in-tree user of the old binding any longer.
So why shouldn't we remove support for the old binding?
Do you think of out-of-tree users, or of new dts files using the
old binding?

> I think it would make sense to update the dts files, and add a noisy
> warning when we detect that it's being used to prevent future usage.
> 

The old binding is marked deprecated in the schema, not sure whether
this results in any warning.

  fixed-link:
    oneOf:
      - $ref: /schemas/types.yaml#/definitions/uint32-array
        deprecated: true

