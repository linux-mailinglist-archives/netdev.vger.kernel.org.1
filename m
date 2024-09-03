Return-Path: <netdev+bounces-124741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7847B96AA8B
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 23:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E05282B0B
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 21:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE618126C02;
	Tue,  3 Sep 2024 21:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ER9jIvJ0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7088BB647;
	Tue,  3 Sep 2024 21:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725400111; cv=none; b=sYEb/tM7fNjSvOQBt6mXpgjDr1cHtCWXLplRFJ5KNKUbyMollSc8afT70kXRwvth9MPCaM+L5unany2qYWHns59yUcukMhRko1m1w3BbOAkKGBAiKL2CcJTVzCtRzeSrjWGxN6Rp65KlfNdBunGxUaJh2hWtGK7Gbp6dtpFAdAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725400111; c=relaxed/simple;
	bh=60NYC0M5TX2Rie8WIpxDH8StGvDAha+7Nld7q0MVPCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVTMLWaBVjiho94P9mUM9zVqo6aNt1HTk070jAH8mzwZ8jPTi2+V9OZQ+9IqYsDfKyDCiggQDuYb3wrMNfNf9rPD1QVMshCjTB3Qyn1sXmgm+nJ+duQEhROlRzA55AcoEAiUuCgbyICwP+jA0oc6Bam3/R4wOcCf3DPbtddKmYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ER9jIvJ0; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a8049d4a40so325956985a.1;
        Tue, 03 Sep 2024 14:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725400109; x=1726004909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=se2FtAO7iN2pqUgiakHe8ZkpdVtZFx51CeOE7clkB90=;
        b=ER9jIvJ0KDJxDw1fxPZwY6nd60EFD2F/WKYj0Czl7QaEp+ehRQ9yXB0IOjwvDFAxcS
         cFXyAgiV4LoMAFK+MgQPiP2spNs1K4VILAtb93KXx1E4GMgJH8KHJet/abjE28AXNgkl
         HsG+zz79akoy7Jgjtwzl4yTbY6eGJ4CI9xC89GUhQ2GqDjWcWXtqdjRNrKLc62cMsemA
         lWPIGlMNl17f2nY6XEXv/IqSC2J7nN2cjU4FTgi2O/xT3v0FG9mDtWHEjrpXcdSgrX0N
         oVvknEFYKpU0lPoy+swHkNl9wJEw8zY17vDnsWu/a2RgxlveZLYDGtR0SEnQnB7lXLEo
         Tcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725400109; x=1726004909;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=se2FtAO7iN2pqUgiakHe8ZkpdVtZFx51CeOE7clkB90=;
        b=nbtlho9iR69xNHQLCBg8fpBdtL2Xirn5Rc0CiV9/MdeMOqyzidNLI3uS6KDg33jCzq
         L2Wzeo0Qi02tqzf7Wn1nMyFjSWBthFScHkVz5kkotd43eVilMm04HerqElDm8beizyYs
         CXYgvpNp7Z6i2mojZyg93+1YhcEQJY8QG52SIkYzmbZ9BDy+JdlhEvJYflydlP0Xr1El
         cOj71byWzVkl6wABVTgb0QcBFLgofA4XScs9luKkj5NKvmINNSoLaC+ZX2iWxD23gKy8
         9Fp5PIKJ73U2N5l9EuhrDo7+PV9FvdKbz3I8m+xpRJa75Y42tHoOa2Q2xG36XoYlbbeg
         vaAA==
X-Forwarded-Encrypted: i=1; AJvYcCUD72X6Rof296QoulmfRCuzrLuiZVyUGBkw+WI/4APipdfFqaR5Qz79qHKK3ErDWp5Qwv0l7EUn@vger.kernel.org, AJvYcCWzVku8QGUwBGFpTZs0j08sORc1m/iY268hAymcQBViosuz8mpz+NwGKbWcSx3I+oxPTr66veqeXS+J1sU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyFu8fPBcLrqbBBGu7Y6Tn2XKnPDUUOgT0iL1VFH2dutzNsoE2
	upU4E79xi3665WJbb4vfasZT88+1RT+Pwfb6dhehhj0Fkpg51ewS
X-Google-Smtp-Source: AGHT+IG9EF/ZPqaA7IIOjPt6oONb+qYHpH6/TmM4UriUq0JpWXlIEBSX8R0OL4kqdK/0qc6UQW5mvA==
X-Received: by 2002:a05:620a:31a3:b0:79e:fbca:5ceb with SMTP id af79cd13be357-7a97bd0acbdmr464694885a.47.1725400109161;
        Tue, 03 Sep 2024 14:48:29 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d830a8sm568566785a.125.2024.09.03.14.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 14:48:28 -0700 (PDT)
Message-ID: <d7c82c78-9f7f-4083-aeec-013f338df11e@gmail.com>
Date: Tue, 3 Sep 2024 14:48:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: vsc73xx: fix possible subblocks range of
 CAPT block
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org
References: <20240903203340.1518789-1-paweldembicki@gmail.com>
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
 FgIDAQIeAQIXgAUCZtdNBQUJMNWh3gAKCRBhV5kVtWN2DhBgAJ9D8p3pChCfpxunOzIK7lyt
 +uv8dQCgrNubjaY9TotNykglHlGg2NB0iOLOw00ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
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
In-Reply-To: <20240903203340.1518789-1-paweldembicki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/24 13:33, Pawel Dembicki wrote:
> CAPT block (CPU Capture Buffer) have 7 sublocks: 0-3, 4, 6, 7.
> Function 'vsc73xx_is_addr_valid' allows to use only block 0 at this
> moment.
> 
> This patch fix it.

No objection to targeting 'net' as it is a proper bug fix, however there 
is nothing in 'net' that currently depends upon VSC73XX_BLOCK_CAPTURE, 
so this has no functional impact at the moment.

> 
> Fixes: 05bd97fc559d ("net: dsa: Add Vitesse VSC73xx DSA router driver")
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

