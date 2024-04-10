Return-Path: <netdev+bounces-86576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1E189F350
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 15:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2101F285B7
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 13:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6382915B565;
	Wed, 10 Apr 2024 13:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOTUsok2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA60D155390
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754309; cv=none; b=qs/YgXDmzgxFWFcNiB0sXVDY43CuhGdtvEQwWwUzmQAM794G0g7UP/TbSpAjN26BDsnH9Lp2PgrxMZAE17ZT4nvF12rBAU1cToOQapTjU5pk2VV3Qwl/nLSqTmjmZOWeT2fBDyji3tsE/e7sUjwGwSD5POxtjsXwVIB16vh9LXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754309; c=relaxed/simple;
	bh=YNDRDhQD6gf/O6Mgip7hqpJ4zELYNA11wmsQ9yGKDnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbJcG0+Laic+UcGKMZ+TVTbc/VRoV8xmMWtUh78j+j2PDgen9LF7Ubbag1BE3Iol+rAh7yo0LMSBDrFCxPwR0mc+uXirKsTY5tZ3KyebuPoE19hA4iZ7a+ERx+Jms8gpoIzUmC3EJfDZYnA2h+qCPmmOx20/n5M6hK1eSMqdK6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOTUsok2; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e6e08d328so2634026a12.2
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 06:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712754306; x=1713359106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J28dD2QBJGO+wC+YCBNkYps9KpvWphZ3YMQCaXDjWaI=;
        b=IOTUsok2RyFWCDUTdy14mTOid0Bav4s9ItORLKT5m81AF8KoWndodUUBuXMMpZtpUS
         Nd8jkqcj31AHBV3It18qlply7cEs29H4aA9p2ije7quiZM7fR3pDPjqowwUKADMufPc+
         z2fB0xoN9TnXuDQIhpA1+t82KRv7eUbuoM6VSUZpyKCMbnu8W2jP4gawn4p2fvmS1TAe
         5NdMFzasjbRnCdZhgVKfc/jmv1gJkV+kTcsa+gGoG9Zlrk/NhbXI3fX3jn1luDw3zRr8
         /PDqHoLzfuDTyVCclmflxi7DiFA0xKfgbAVKslfwF3H9c7yuVisJC2i//iembY2bnTRc
         Jakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712754306; x=1713359106;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J28dD2QBJGO+wC+YCBNkYps9KpvWphZ3YMQCaXDjWaI=;
        b=fkpQWFHL0mXJoAjDDruYB9YasFJ8saclD20Vdg1KVCmi/8w3MQ0vbMt8vdv81pFkhm
         egabADHcMyhy40bANWhdOT8wRGtPOk1JS5u88KaQWJl+fMKSKX/3hFzRIxtD3cm6Sqx4
         TCaDSz0gOamG3j590Zv3VmiuIP5CvQL8NzWEtMhM61+p4b3hfGD7dOgKNePRo4+SzlOR
         UTaBQlJdlMAJSDg+Vj77h5xwqNYs+ZRHAlHnsnfJBrOLV7XHEj4OWnK8ovQTM+zOwx0g
         i3iJ3lWo6m/I1AgMXyMtDIwceU2+4D8qZuql5s+QwnkTjONRl88MWKcha0LG6XHq1o/J
         G8iQ==
X-Gm-Message-State: AOJu0YwSXS/0KHMmzxiio0OllrKWS15yAlf2l4g3FCrqFGU7qgF6WRXz
	B6MUpo0Sl0Lcgi3fcrKBh0s0tZWSHVmcYghs+pC0qwD48lnXlOGf
X-Google-Smtp-Source: AGHT+IEIogcT+8VEsEZrNISPzm5xp4WhmWyaAySFHTsYpGDwzYgIdRSy3+Sz2IPGdz0wMyp+NyvG2g==
X-Received: by 2002:a50:d718:0:b0:56e:514:e153 with SMTP id t24-20020a50d718000000b0056e0514e153mr1668488edi.12.1712754305629;
        Wed, 10 Apr 2024 06:05:05 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bc0e:8e00:f084:5a91:c3d5:fff9? (dynamic-2a01-0c23-bc0e-8e00-f084-5a91-c3d5-fff9.c23.pool.telefonica.de. [2a01:c23:bc0e:8e00:f084:5a91:c3d5:fff9])
        by smtp.googlemail.com with ESMTPSA id c93-20020a509fe6000000b005689bfe2688sm6698524edf.39.2024.04.10.06.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 06:05:05 -0700 (PDT)
Message-ID: <db9314a8-cb17-4cc0-b64a-7642f46679bc@gmail.com>
Date: Wed, 10 Apr 2024 15:05:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [netdev/net]Kernel Compliation Fails on PowerPC
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>, davem@davemloft.net,
 andrew@lunn.ch, lukas@wunner.de
Cc: netdev@vger.kernel.org, abdhalee@linux.vnet.ibm.com,
 mputtash@linux.vnet.com, sachinp@linux.vnet.com
References: <c02a14f9-670c-42be-bf27-7d788575e3c9@linux.vnet.ibm.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <c02a14f9-670c-42be-bf27-7d788575e3c9@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10.04.2024 14:33, Venkat Rao Bagalkote wrote:
> Greetings!!!
> 
> 
> 
> I see kernel compliation fails with below error, on PowerPC.
> 
> 
> ERROR: modpost: "r8169_remove_leds" [drivers/net/ethernet/realtek/r8169.ko] undefined!
> make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
> make[1]: *** [/home/linux_src/linux/Makefile:1871: modpost] Error 2
> make: *** [Makefile:240: __sub-make] Error 2
> 
> After reverting the below patch, compilation is successful.
> 
Thanks for the report. Conditional compiling is missing in one place. Fix follows.

> Commit ID: 19fa4f2a85d777a8052e869c1b892a2f7556569d
> 
> r8169: fix LED-related deadlock on module removal
> 
> Regards,
> 
> Venkat.
> 
Heiner

