Return-Path: <netdev+bounces-115425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 784B394659C
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 23:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222741F22F10
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 21:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD0F13A3F9;
	Fri,  2 Aug 2024 21:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGsVikAL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ED413A268;
	Fri,  2 Aug 2024 21:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635633; cv=none; b=A8JJZ76nvvCxbCGFRJwqwaDUGO58OKJg2+sqSKWvnodhg2TPgN+CnJ79jtqKnZ2aKAcnyybpsBEuR9OtRdNrhrCwc3QpGwOH0swm+xx9eYdMl00ZgnYTZmLLhrq2V/N7WmWaD4Vysgn1fED9CovEpp8Slkkjb4+DyFWKGcB1+3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635633; c=relaxed/simple;
	bh=OaZmfObyG8RIuSIXZpApM2ZGi8H+ykIS3A7Hi5dZOng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKd/N3LQRwCc+KhG+Of2LtRfouBrbU3JCRF/VizHStRDUbBb6zjghmUqQvhJnkxgAgJPuumj7BxNRh3aRjSEI3CLZxEX9WQwowoKX3BMI9Nt9WNE+Sbsxb9JcXMwsOMV5XmIvHI5pLyyq1dyugsF3o1i92s2lSqv/CsQUjL444I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGsVikAL; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b7a3b75133so62841656d6.2;
        Fri, 02 Aug 2024 14:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722635631; x=1723240431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GceTv74Bj559z0JmK+lblKlugOtaOtEJSekU4nkUvCs=;
        b=NGsVikAL81F1HB3HhWtyRGz9HsZQzjzIk/FqzD4Au4sCTuy1AJwtXjQV0UgeNEhLkb
         LckyPenFwS+gFMq2qwVSgFEz0JVSkCar5r44ReujwyR+vmCU+M2obxtyNhypIiGxx/ZQ
         w8kvECfz4BNRP9BmItPedy5iccOCWsa//eChkCukW9UMfUji2LvnwvymXKTgFYUXuTmH
         priy4XrBeOH1GhXX98jPYJOoKYKPRlGFh3GjJ3qr0RddU7JW9bPwhood6SycboXij+QZ
         dHmG6oYytpEuWwASmk1x3eaVUTjk+4uZtBpGE4zjQMu/QQWiwat/YIun/af3R3gqWKic
         LFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722635631; x=1723240431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GceTv74Bj559z0JmK+lblKlugOtaOtEJSekU4nkUvCs=;
        b=qq4DkohattffyZEOhgaQmWlxY2msF8QypIE2NzEhx0SksAJIx+zTBkOnlpm0yNhg9R
         ORf8oDXJ3RGadiHajkwIzQPP/UdW+VsFszCVF5w/sjRn1P0Ef1iSFu4TG4hyZOgP25of
         dhpzIIXmScrKCge1FDSv31EA09N1OgDO7YlTfjiGpEnY6NvsElxxZuOC4bknx2Iv01bL
         IB+X2NoqHaFtlFW6wGuTLI3Zo9fGipjpCSMvvK2jyLjvCzMPrUEJv8GIvsAL7Qj1Wb9b
         jnXV+ciBRMwhurbAIDP0Sr5OQC5GpR8bJjKPPmC6kkS75Y2OLCQ/FxLRJW7bAlto4FqC
         iqag==
X-Forwarded-Encrypted: i=1; AJvYcCV7Hy1mFXtPMz15geV/7/9KoSdPRgWay2wZjEqzlM+iG6KhjVltST1pgXqziVkH+MDer8r9djz9G4MN32ZpSVcVos1kfi+Xan5aDGJYRdakah5lqpTp2XW9tSSdDjS43zLFT/ni
X-Gm-Message-State: AOJu0YwwLMx6jbzlPkOW9Ji6JM69Tynf4IYP3sYrNHb/FAS7b+j6QDJi
	/ECQsHLXCRuwlWgCfKI9wLdh9a5ZR5HsaHLb6lUuwYoRL93TRJ8t
X-Google-Smtp-Source: AGHT+IGGtLIzikJjuZmrrT/xpFqJklxkSPlbCER54x1UIhW0jePnCTPyQ2rjPOg74x9QeyQJIGkg5A==
X-Received: by 2002:a05:6214:43c9:b0:6b5:a5:f5f2 with SMTP id 6a1803df08f44-6bb98423b2cmr54369946d6.55.1722635630600;
        Fri, 02 Aug 2024 14:53:50 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6bb9c7b8826sm10525716d6.64.2024.08.02.14.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 14:53:49 -0700 (PDT)
Message-ID: <b20a19cd-8428-4ff2-844c-c214a0099284@gmail.com>
Date: Fri, 2 Aug 2024 14:53:44 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/6] net: dsa: vsc73xx: pass value in phy_write
 operation
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org
References: <20240802080403.739509-1-paweldembicki@gmail.com>
 <20240802080403.739509-3-paweldembicki@gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240802080403.739509-3-paweldembicki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/2/24 01:03, Pawel Dembicki wrote:
> In the 'vsc73xx_phy_write' function, the register value is missing,
> and the phy write operation always sends zeros.
> 
> This commit passes the value variable into the proper register.
> 
> Fixes: 975ae7c69d51 ("net: phy: vitesse: Add support for VSC73xx")
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


