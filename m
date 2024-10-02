Return-Path: <netdev+bounces-131110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9CB98CC0C
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 06:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF571C2125B
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 04:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624FA18049;
	Wed,  2 Oct 2024 04:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeVieW0p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29E0E56C;
	Wed,  2 Oct 2024 04:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727843375; cv=none; b=KNmHQURlxvv8XO4jnrW4WhSP6I4vodKJYGe8J7ZPduBNyl2WBr9zm9VdkV+W4ZpToXCdwg+nzJuxpkyyDUALKx+dfDU7SJbpnZimfl7l/dGz/RXTdKDUhsQuRUE+t4O8Q3cOXgp0KorTM/Yn7h/KcU/C+LC07IpfPryLpMpmfO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727843375; c=relaxed/simple;
	bh=3BNmKtj4D4swYXXXHuY5gShlGkJba5UJw39ydnSka7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/iF4LJsiADirREzTV79X8DCVqM7KaUk4Ews1UGc5eSyBG8uUL4as2Jq2k7KJqff1ElBMqbheSVYAMVu1E8pGCS7YCRDhc4mSh5xeHvgTiseP/hHetwXPi2ALMd0twb3KAkE5jTFlow/dTvbssxWODlRiK+Mf/TdoPsW5PZKyK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeVieW0p; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e0b0142bbfso329230a91.1;
        Tue, 01 Oct 2024 21:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727843373; x=1728448173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1aqbtvkr7o9HD9T9YGWxyc03LOcKwSp/b8mCVE0XMhw=;
        b=eeVieW0pIx7zHhCtDjbVQzuayOO8PJbJqcqAnKfhp7Xqd/GkDHhCn//aeR9bDPrnb5
         OnyjKvLJ5hAJyd+KttGFiK45DEtfcH6URR0qDNccyRBgDxlqURRcWWeINHWqd71w1w46
         t+YAVFfBOf/FlhpU5GiOPW90zRhNQYE7RVnrimOqzEQQca/oeCobdGfAsh8hdg15XHhC
         bSDyHi1y2hrn04Yw0SputFp8IK2mitL08blsKwNraxbhlMoeRKEX2M83hAwre+iM2My+
         FmcLNHfL34YQZwyTk1DkeQy3vlhKGOuoV9TMOapM3Mj9POtwPBhKdMYFxuNKmD4DRrOg
         fifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727843373; x=1728448173;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aqbtvkr7o9HD9T9YGWxyc03LOcKwSp/b8mCVE0XMhw=;
        b=xEWooXQBEjMpSB0rt/LChogo7qCVhlL3IoAXI0MfIv12fEMQggBJhzahmSjlMOFRyc
         Cmd8RIDWWiLbMia785RlbwW10nhXz2BZpv51rno3Oin/k5B5OdhPSn+Be7wJ6er/WySH
         W+RI27sEIAUZsdnLPOmGaboTj/++vb4sSZfq9fDvi7vmv5FCv8aGng2+LxA0Gx909qv5
         sTTOkP08sop0YdPtSXJxdAwT7gl37qc9eycdRXFZ9jC8oS34ISG/ZgJRQkwn80hxj8Qv
         uY2LZQD5sBsTqKfNpmwX1yByiNbS6Vn0FV/R5U6+i+XFFmt8jW2D2eIi4UsvwNYHvcbG
         6Fow==
X-Forwarded-Encrypted: i=1; AJvYcCWR9b9AbqGEyFbhwf7juOowpNMUARBWab5v5qHhE7nv1SPdLb04VMyL16etaqFwsd7gPPnozi3I@vger.kernel.org, AJvYcCWUdyGd/x/KXkLZTtbIDovN5Lej8YYXbHYsHBmSPFvac3xhqV8xvIMFxEIqfizlkScEOGNvbXDqTS33@vger.kernel.org, AJvYcCX/ZNOoGxaHCTNu/7QtLMxiZ5rnm6704b31SlWkGO/wxD2nEh2cm3/QlB5qCN0TL7Yaa11HL6hsKHmD12Oi@vger.kernel.org
X-Gm-Message-State: AOJu0YyvIrkaDKCt43JTCu+dAwMm2Wc6p3Rp4J2MPNEzWyP/ef9y6m3w
	juRUkhdBxIqrV3yijQBX9pjMa0reMSHJYeIT/8bo03ZW4eEhp5Pg
X-Google-Smtp-Source: AGHT+IFcuOK1+fCsRy8o8dlxNxccaY2uqup3/aALtFnjEzbZozpAlH3V3f7eL7oTFOli+hXpHZyP9A==
X-Received: by 2002:a17:90b:11cf:b0:2da:88b3:cff8 with SMTP id 98e67ed59e1d1-2e1851c6ec4mr2864194a91.6.1727843372986;
        Tue, 01 Oct 2024 21:29:32 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f74654fsm551159a91.6.2024.10.01.21.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 21:29:32 -0700 (PDT)
Message-ID: <9ef2457d-c882-41ed-aec3-b62adb65f3c8@gmail.com>
Date: Tue, 1 Oct 2024 21:29:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/2] net: phy: Add support for PHY timing-role
 configuration via device tree
To: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Russell King <rmk+kernel@armlinux.org.uk>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org
References: <20241001073704.1389952-1-o.rempel@pengutronix.de>
 <20241001073704.1389952-3-o.rempel@pengutronix.de>
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
In-Reply-To: <20241001073704.1389952-3-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/1/2024 12:37 AM, Oleksij Rempel wrote:
> Introduce support for configuring the master/slave role of PHYs based on
> the `timing-role` property in the device tree. While this functionality
> is necessary for Single Pair Ethernet (SPE) PHYs (1000/100/10Base-T1)
> where hardware strap pins may be unavailable or incorrectly set, it
> works for any PHY type.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


