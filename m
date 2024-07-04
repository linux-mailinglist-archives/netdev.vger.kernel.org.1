Return-Path: <netdev+bounces-109239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE30492782E
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AACFB21114
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603281AED3A;
	Thu,  4 Jul 2024 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDHuusqG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3B01AE0AB;
	Thu,  4 Jul 2024 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102911; cv=none; b=rOfQoKLFD3cApB1HaN2WX0bLhJhG3fJpuGm020muADQgtA5d/YzH70sJ38jo6C9b8DZ3MZs7NYA96hsgPyEIA/PqfNC5ljXk/tWnvvUqWYQWncafqOnPg6U6FqR1fX0DscC0YJZxCTdXAJmEzBqch5qxSLpXI/DkK4CF+bJa7vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102911; c=relaxed/simple;
	bh=OELSDEbGXuE+5Ii5XnPxV3waGSkZAEDKq0R+2uIOPvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHgaHGUaTKqOOt64R1PQKKU6B2lm+uWV3xxfsmbYyfRHPAWJBKooMPnFs5V2lyDH0klwE65ua88IcWiPnlQJju3rouirBAM8Y8kBL9Hzo06Gk5MTrwA1dy1P894iDk8fG0zb2Ik6bfubhekuSy6Y68d8pECFfNzxp5gC1tXT0X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDHuusqG; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7f624e70870so40178939f.3;
        Thu, 04 Jul 2024 07:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720102909; x=1720707709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J5fyPBjPUBCKVmbvyq71bQNOaVFWHBH/kjYshsTtryg=;
        b=ZDHuusqGURXEReBoHPI4krtDJCDRlgdbXMhvnd+b/GlfVICn6Ez6Cb0zURHjnxswS5
         ifhR7Mt4P4sZ1XgVOdw13UYmoa7vITLJJvoPoUFperRcJzVF7c05ot1R/Sp1BrmIJlye
         JWF1xZ7D5UZfMWWiZRV8k+lvx0pCjhbXa3PQAjE+GXXLFlrAnGYIJdcP8ExFafsWsfHn
         +6p0ZqT/lzLXfwloFwR0h0ihznGmhcTboxfSyH3TRZ0MO3uDBl3SqjF3wA5Cve3Yji6M
         QiEMsIhs7zFBRfbFx4NlstWLDLbvFy5oM5mKcsV/413UVNe/PgRZBF9v0MqhjUWl9k/Y
         fjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720102909; x=1720707709;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5fyPBjPUBCKVmbvyq71bQNOaVFWHBH/kjYshsTtryg=;
        b=CjqnMahpascZKGnjvxzVVfMsbHUWZlZfw0Vx+R7p0Tl0hiDvfHb96GSj1L/kA0j6qk
         qsQnR5GA5VtAkOj48Zrr2s6sYvuJVvn9wnwe52agaLFd9H8hybktIrJMdEs0/s4ntTWE
         hEXZsWG0GALYszKvNJOtpsg6b1FSLFOfzY0m473s96EB/XLnPAFPdsBvb76uFGRCZp6B
         lI5lXZ64XAjxiwUKCyHIueE1gC+c9baS+n6tYgqNid/Q2dorSgYbiHWzO0FwqW8g5iYD
         kz0xnGEmZr7gEGK8yrhApwlSjb1dK3CzuLDFdYxWsYLwpfir6CLQvAMnNC8AoKwMRPDh
         OjIA==
X-Forwarded-Encrypted: i=1; AJvYcCUr9SN/lEY/8YgmuRNbKa/JhEt4XhGuZ+eJMxHDhjTFYLNs81Pwy1POfGTv6COABtg/7AHk0/evJZlf1K7nPDE/+IBwJ5UuH74thUSupsSJfEfggCZlhiTN5y12oQfUnygJrDRd
X-Gm-Message-State: AOJu0Yyk72VkOCnu9a6fZeV8xH8VSSbEJfq5HAe09V6YsbbTsSIeJ015
	87Y6btcQ3qh49p3dEEAUPC5rIE+4M4jprMu3XyhHKRW1T7YaGXgG
X-Google-Smtp-Source: AGHT+IFXuK4SnhhNZ1DTpuAh5BgsW+bAjreDCI9lM9uxL2Gd/JhZgyJFY4k3M0+yEOTBnxv98ZY2tw==
X-Received: by 2002:a05:6602:6412:b0:7f6:1f5d:3e02 with SMTP id ca18e2360f4ac-7f66de8cd82mr228626239f.2.1720102908979;
        Thu, 04 Jul 2024 07:21:48 -0700 (PDT)
Received: from [10.40.5.113] ([89.207.175.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080256d3c5sm12292331b3a.83.2024.07.04.07.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 07:21:45 -0700 (PDT)
Message-ID: <b4a666f1-99d5-4baa-a087-2aa433d2be7c@gmail.com>
Date: Thu, 4 Jul 2024 15:21:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/1] net: phy: microchip: lan937x: add support
 for 100BaseTX PHY
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Woojung Huh <woojung.huh@microchip.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Yuiko Oshino <yuiko.oshino@microchip.com>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
References: <20240704135850.3939342-1-o.rempel@pengutronix.de>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 xsDiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz80nRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wmYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2DvCVAJ4u4/bPF4P3jxb4qEY8I2gS
 6hG0gACffNWlqJ2T4wSSn+3o7CCZNd7SLSDOw00ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
 WQ6hgYVON905q2ndEoA2J0dQxJNRw3snabHDDzQBAcqOvdi7YidfBVdKi0wxHhSuRBfuOppu
 pdXkb7zxuPQuSveCLqqZWRQ+Cc2QgF7SBqgznbe6Ngout5qXY5Dcagk9LqFNGhJQzUGHAsIs
 hap1f0B1PoUyUNeEInV98D8Xd/edM3mhO9nRpUXRK9Bvt4iEZUXGuVtZLT52nK6Wv2EZ1TiT
 OiqZlf1P+vxYLBx9eKmabPdm3yjalhY8yr1S1vL0gSA/C6W1o/TowdieF1rWN/MYHlkpyj9c
 Rpc281gAO0AP3V1G00YzBEdYyi0gaJbCEQnq8Vz1vDXFxHzyhgGz7umBsVKmYwZgA8DrrB0M
 oaP35wuGR3RJcaG30AnJpEDkBYHznI2apxdcuTPOHZyEilIRrBGzDwGtAhldzlBoBwE3Z3MY
 31TOpACu1ZpNOMysZ6xiE35pWkwc0KYm4hJA5GFfmWSN6DniimW3pmdDIiw4Ifcx8b3mFrRO
 BbDIW13E51j9RjbO/nAaK9ndZ5LRO1B/8Fwat7bLzmsCiEXOJY7NNpIEpkoNoEUfCcZwmLrU
 +eOTPzaF6drw6ayewEi5yzPg3TAT6FV3oBsNg3xlwU0gPK3v6gYPX5w9+ovPZ1/qqNfOrbsE
 FRuiSVsZQ5s3AAMFD/9XjlnnVDh9GX/r/6hjmr4U9tEsM+VQXaVXqZuHKaSmojOLUCP/YVQo
 7IiYaNssCS4FCPe4yrL4FJJfJAsbeyDykMN7wAnBcOkbZ9BPJPNCbqU6dowLOiy8AuTYQ48m
 vIyQ4Ijnb6GTrtxIUDQeOBNuQC/gyyx3nbL/lVlHbxr4tb6YkhkO6shjXhQh7nQb33FjGO4P
 WU11Nr9i/qoV8QCo12MQEo244RRA6VMud06y/E449rWZFSTwGqb0FS0seTcYNvxt8PB2izX+
 HZA8SL54j479ubxhfuoTu5nXdtFYFj5Lj5x34LKPx7MpgAmj0H7SDhpFWF2FzcC1bjiW9mjW
 HaKaX23Awt97AqQZXegbfkJwX2Y53ufq8Np3e1542lh3/mpiGSilCsaTahEGrHK+lIusl6mz
 Joil+u3k01ofvJMK0ZdzGUZ/aPMZ16LofjFA+MNxWrZFrkYmiGdv+LG45zSlZyIvzSiG2lKy
 kuVag+IijCIom78P9jRtB1q1Q5lwZp2TLAJlz92DmFwBg1hyFzwDADjZ2nrDxKUiybXIgZp9
 aU2d++ptEGCVJOfEW4qpWCCLPbOT7XBr+g/4H3qWbs3j/cDDq7LuVYIe+wchy/iXEJaQVeTC
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU8JPBBgRAgAPAhsMBQJU
 X9LxBQkeXB3fAAoJEGFXmRW1Y3YOj4UAn3nrFLPZekMeqX5aD/aq/dsbXSfyAKC45Go0YyxV
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240704135850.3939342-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/4/2024 2:58 PM, Oleksij Rempel wrote:
> Add support of 100BaseTX PHY build in to LAN9371 and LAN9372 switches.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

