Return-Path: <netdev+bounces-88032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECC88A564C
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 17:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719191C2074A
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD67B78297;
	Mon, 15 Apr 2024 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brGdpK8p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F55642047
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194749; cv=none; b=OyD/17+Zgch8tQGR1ywFfJeqbBZVzYRsh3Ei7yI5Ac8zgrvbzWiokipOPkAcdtnVs8uhk3If1TgPenAWBURu8R8/3kvMmuqt/PfwPbtcjIcBiVWtDsDOERkYVid2vA7X0/gUGV44EGUlPgo9MaZ/UpzBCl+jqJgUYpHFszuXg10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194749; c=relaxed/simple;
	bh=afcKoWY3BS3iKrsLoB2PpUjmru6accZAQPrSMQKHF4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q7IidFa26mjraCgC4nnmvxfr9ihhLZ1jMSXoBrDHYLH+0J7LzrjgIn/OPr3FiJ9PyBwkEWwFEGKvJi/KJq1Q2UxpXJ2Tu5pEGOXmTiN3naPzgg9S4xmCbH0eokWaY7v+qKkjinvRrnji4xQrnFR1UV4PAj/aUTcBQsbWU0hMMxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brGdpK8p; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ecf05fd12fso3233488b3a.2
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 08:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713194748; x=1713799548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3QzitXRHy8s+eVCe3/z2aGXhzIMD/8ZtUdVLyvRy4Sg=;
        b=brGdpK8prtPBDJEjmw3XstXXz6d5ynABu1AH6RG2jqaWZttNllQtAk6tDkajeM5J55
         6GOYdEtWK6MMZh+MHKGPTtH+5dWhLXR4pST9zGoin1h0JAsdXTRZmoBDbbYl2TiGsRwS
         di3Kv5rrJWedb1Y7a+YQ/VXPEQ1Q9YgWo1Z7v8Up9zzn/UEh3+5oadmJUzlk9oRa4RK9
         H1AzK2AFF9GZWykfwl6RC5IK+HxSEkRFnFNtmmUzlyiWdjzI2YgG8wHVEJpcXzy8eC1W
         aRgm1xCE4k+wM5gZCecEJnUxcTzNnVmDiaD8+zjyS/+Ro6jjWVLr0vX5gdUxJ/h4728Y
         FsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713194748; x=1713799548;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QzitXRHy8s+eVCe3/z2aGXhzIMD/8ZtUdVLyvRy4Sg=;
        b=OLI/8nShpMZ4YcvscDB8uP/Zpcw8VkGJxzDqcmFxCOsO1PlZ0yqdP7aKrv6EXtbXj0
         9IXcf1Ewhb3TcFmHtwU3Aeq3cnLp+khKiCBlstL+OrX47CNXRhPKk/lrPstATzTUXnPl
         JxSESe9Ifgcv5dtNpMp7lss2rHtzLeEQbYsmLQnWZ/J2tRyj6DTuwPDGsm41aBlGl+om
         v9cz7W+p39A7EkZweq7y4z+nAnGe5BIFEXoeenE/uUO+ly9Qjo+7miLGyOcw1LOHDu4Y
         kK1DDGRvzJEu62XxY8YKylDQBKaRA4R8smtiBb85DjcKEmNkjLUZYgI5ms2sG8S/yOqp
         UV9w==
X-Forwarded-Encrypted: i=1; AJvYcCVws6QHz4UUojzhsamfgdnhbj8r34ha8gDbAEJbqljxO7cPrmhaUIqM5JuEMnbeMHMM+6MGqVb7iH/1k/FSzwN94MwCcT6M
X-Gm-Message-State: AOJu0YyCcKdmjQpdzBgUhXQZv5HbLwEv6Dpc3YDqJNYhVnyvs583qQNj
	1xjX2PM9WsUybcJyPtBYUKHysky9L2cnw2HDp7rQ/RXdWJ2rBOgi
X-Google-Smtp-Source: AGHT+IEOwxRngl/fS3a3B6seKT/kfVXi/GGoLTbp+QuVxeGCzTDfl8c3LRpw6gNmvq64X4qDAEMDEQ==
X-Received: by 2002:a05:6a21:3405:b0:1a9:d24d:9439 with SMTP id yn5-20020a056a21340500b001a9d24d9439mr8100406pzb.56.1713194747623;
        Mon, 15 Apr 2024 08:25:47 -0700 (PDT)
Received: from [10.230.29.214] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w9-20020a62c709000000b006e6c88d7690sm7678554pfg.160.2024.04.15.08.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 08:25:46 -0700 (PDT)
Message-ID: <ecf820bf-57fc-40ca-99db-a0274dceb2ac@gmail.com>
Date: Mon, 15 Apr 2024 08:25:42 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: sja1105: provide own phylink MAC
 operations
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <E1rvIcT-006bQW-S3@rmk-PC.armlinux.org.uk>
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
In-Reply-To: <E1rvIcT-006bQW-S3@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/12/2024 8:15 AM, Russell King (Oracle) wrote:
> Convert sja1105 to provide its own phylink MAC operations, thus
> avoiding the shim layer in DSA's port.c
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

