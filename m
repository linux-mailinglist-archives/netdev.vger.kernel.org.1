Return-Path: <netdev+bounces-66795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A640840B0A
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 17:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006A328DAD9
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 16:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17776155A31;
	Mon, 29 Jan 2024 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqjR61/p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A273B155A2B
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544816; cv=none; b=nrsULzjuJz5liRoZr41/p5jTDcsGl5bF40XCu0yzeFfGryibKRe64uhN5ZbUANI7DNq0aeHIqCDpyrpwJUmNAT2zcpIerBxtTdvwjL7GzF57J6yC3CYXJQpJMnUwqLXqPIETdLZdyueqHKr995sYCUdm0JFcBgvdTWvkB9eV/wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544816; c=relaxed/simple;
	bh=GuTrkPVtTfp3gaSXDnTZmtw3Qq6ip6G9yN5aeq2cJes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cxuvbhVuUKwXYY7THMFqTs/C9KyFN/4bRKUnX/eF+mICGGj7j2HFM/vJi13vQvE4ayE/qGTSo3RBdXLqKKTPbrIvVkNMpf9RRzKGixBz5EDxJESY8YL82vxk/Sotu9gWMs6h0EvMAMzFP2cyw24aPke1onLCBBFEiIYs81ut044=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqjR61/p; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so1339001a12.0
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 08:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706544814; x=1707149614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Dwdg+oyupRSZU6pjXvtV9lpQKQTS76WHL59uibN+zs=;
        b=EqjR61/pRv/nTSzat9KOyr4v27yhssWtTdZdQbh9wK1Qey7TJXrl8+qIkyOvG8c7QU
         rb1/vtpYctSVJYRJVVjwKbQR+n4bzlOhDEtt9FD5EwzyArg3pHWDOAXNslHyFrqv4csH
         y9gJy6axhWdHZEsDhfEHijCKNYyeVRmKpHtYAR0C8GK4oRUcv3EQPCt9hndqeT8rueoq
         DDZwmMmSpceacfuvlH87RTqrEMQ7aDFBcxd3bmSUmACjdI/E0OyXJN/X/EYILiZivwaw
         1AhmpXQWNSNzATFz6ZZJ49jlecbDCfgudLRqCwIMt9jPSwa9Tc7nqmxrI0W9MLjdUnE5
         ay2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706544814; x=1707149614;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Dwdg+oyupRSZU6pjXvtV9lpQKQTS76WHL59uibN+zs=;
        b=USNCoGF2t4p6L8tepFsI4kMb15HK5Ge3nHZeN8lrXQJAkuBpxRC0Ojw4D6PPjdCBjJ
         BrerlDVKmxnIUmLLE5Q2II+Hhi34A/lf5xwKizWtR07CNAeHUT7mNXtlVszIIFnPfjtM
         1b00jjKBqkljIfAsp0AxNl+/6saDsKhnhkGhbxBYJVKB73Fwe7fCbJ+5ulrhmrK0VV/5
         5u2iiZ0YXgMwxDWH90e6ijJ8fXzKwy+FATBRvcIT/CBT0VHNfVb96drxv72ezvsI3FMs
         euw3v64xb0gc+zCShZ7eMbuQiwKGlkQjcKosvn14QWmNE3X8JLl+AoCMxrePKU7gKcst
         T/jw==
X-Gm-Message-State: AOJu0YzG+N2WZ7m3pQO/jG2GRxoWl6A05BlwJdQp0AGcZAcjypGgD3LK
	+sl5zVBtj3wsz7VpjGOQb03m8O3Q80fCvs3tubeJwHrGLIoCrKS9IOJZ80Z5
X-Google-Smtp-Source: AGHT+IF+l5C4ebagL2PFS8ckD0hgYJX+UWPO/Mkxo3YssCfQWRtVwohG4XOgMr3sBZuVYHnfocj/gQ==
X-Received: by 2002:a05:6a20:2d0f:b0:19c:a389:dd6b with SMTP id g15-20020a056a202d0f00b0019ca389dd6bmr2498617pzl.20.1706544813825;
        Mon, 29 Jan 2024 08:13:33 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:ba1:8853:5abd:d9f3:2a01? ([2600:8802:b00:ba1:8853:5abd:d9f3:2a01])
        by smtp.gmail.com with ESMTPSA id ne1-20020a17090b374100b00295494f6c45sm3770065pjb.2.2024.01.29.08.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 08:13:33 -0800 (PST)
Message-ID: <b154d03f-1194-48e3-909d-d26498a689ba@gmail.com>
Date: Mon, 29 Jan 2024 08:13:32 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 06/11] net: dsa: realtek: merge rtl83xx and
 interface modules into realtek-dsa
Content-Language: en-US
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, arinc.unal@arinc9.com,
 ansuelsmth@gmail.com
References: <20240123215606.26716-1-luizluca@gmail.com>
 <20240123215606.26716-7-luizluca@gmail.com>
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
In-Reply-To: <20240123215606.26716-7-luizluca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/23/2024 1:55 PM, Luiz Angelo Daros de Luca wrote:
> Since rtl83xx and realtek-{smi,mdio} are always loaded together,
> we can optimize resource usage by consolidating them into a single
> module.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

