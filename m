Return-Path: <netdev+bounces-135277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3AF99D55A
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 19:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9F71F2358B
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4117B1BFE01;
	Mon, 14 Oct 2024 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqedvPhQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E873CF73;
	Mon, 14 Oct 2024 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925921; cv=none; b=KaKpZgyzyqlZ753RiT2QgP+DoBAlgXKhIO5DABH2XMqV05dvlRC4/vVHpEB3+FCwUjZxDPxiujxTBcSbEazBQa6+O0cny6uoEhafRhD7bF/FWO2Er0ClSGSgE8S/VX3p9CaNC29vUf+ScepmZFSa6iAi5LwKadT35MNCqtdowzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925921; c=relaxed/simple;
	bh=n78VtZTzrDt4cV+PqA1asH4sCyjPndIKN7+7HPoZ5Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVH683mzq1GtZ58XNelQJtb2dge6mnyOV8uYMQuZC0eihQJIEmWcTO4hgdCcW0mR35oN4t8YV7FQsx/VLCLQi+y6+/i8hLeE7+4/eHj7x1vswFV8m8XcsArNSRI1jxaCSUKWs5eAJGd63I0EBibrNEE3scuxHb92O8Q0NYnXImE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqedvPhQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cdb889222so12892115ad.3;
        Mon, 14 Oct 2024 10:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728925919; x=1729530719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=97toLKcxrlitdPqCj6gpVIZ1FabROU5nT6FwVDoDabQ=;
        b=TqedvPhQEWylv4q/6UoWDzTRu34AHXAgDPU4M0WRgKD1RsNdsbzonWx0pXWPvCbDlA
         lSj6TjJBrMhDti+wnQ8J6AYBKuVJMcAmM/7/zIMWjC7LWgHuXUIAgsX8gOBVzVDDy03q
         BFg1K8LaVVDDSxC4g6FqrDeiNi7/toAw2rVAEH3ZpWNcMaO/Wpg1peVuYN8l3srIvICN
         cNDli88ZJvez/OpysrwEZSF6FuXeegqfzEE6RKVMQ+ufcA6ZYk3M1RzlkGS+3xN2NncL
         dWXLC0+GJL/RhzBUQIA/XSgVWDRxS18eIWwth/ztz8ZFH9tcvt/6Rgj3DxfaKunpnQaU
         kDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728925919; x=1729530719;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97toLKcxrlitdPqCj6gpVIZ1FabROU5nT6FwVDoDabQ=;
        b=MzUKMTrTFo2mD/yl3ptqG561OjsHD3jXwvaRtUFhMGdy3ExShsnHMgFHaTjXQWsEa1
         1Thn/CIEfB3UV9wwEyC5qq3VOnsnsMwqcHGG2ioPfy0qYx8bc1v14RVSEg6CRn6ZrqkH
         b8QB5Cd/wHUbGMmq/6Pb1Z5HjRKP83Q7m4F8QnALMvDSaUM8XV82VbtZ07wr+NteyiaQ
         W4ds49tnJBeOZYeZzXtE9Kstopx2PNKwVWQtdTxYe0d8zmrzF80Hn68pgkFPu1Rac4iO
         PTHCPhWctj2JbmX9g/Zn2rRbiSKB95dN2M9RjcUAYVI1ColWT/ZbzyaBwcG2UCLty4ZX
         Je/g==
X-Forwarded-Encrypted: i=1; AJvYcCVSmGg8LmyEMbAq2oXQn2fdvKJZVpH0uqdBQCZfaI5ZAPPhtlblo/z9R4uZG2bLyoAj+OIx81mq@vger.kernel.org, AJvYcCWPuhKx+NWhjgx2SDoUPoGSuGK3z8KvpPk40gAvuZghz6A3A8VQWx8h03sFWidehSpKhMCvSgGdDS3Sv1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3sCbOyl/pK50PLL1X6Ok63CGUmnEBHwieV+UuwJD4yC8nHn1J
	/CZh6odCfN73hKB8D2g5s6gV3LdMuI2nsZFvKW6xhv9DC5LEncai
X-Google-Smtp-Source: AGHT+IGm4Nnen65Eq0CK3IH5VR41EeivQUE3maqsX8T+5sxy1654/bCTpRTAkhzOx/yO0iKelWH0Tw==
X-Received: by 2002:a17:902:d548:b0:20c:8b07:c657 with SMTP id d9443c01a7336-20ca169e8b1mr143252145ad.42.1728925919041;
        Mon, 14 Oct 2024 10:11:59 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c345e39sm68389055ad.275.2024.10.14.10.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 10:11:58 -0700 (PDT)
Message-ID: <42ef31b5-7e3a-4a28-9b55-be97833d8d92@gmail.com>
Date: Mon, 14 Oct 2024 10:11:56 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: dsa: vsc73xx: fix reception from VLAN-unaware
 bridges
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Pawel Dembicki <paweldembicki@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org
References: <20241014153041.1110364-1-vladimir.oltean@nxp.com>
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
In-Reply-To: <20241014153041.1110364-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/24 08:30, Vladimir Oltean wrote:
> Similar to the situation described for sja1105 in commit 1f9fc48fd302
> ("net: dsa: sja1105: fix reception from VLAN-unaware bridges"), the
> vsc73xx driver uses tag_8021q and doesn't need the ds->untag_bridge_pvid
> request. In fact, this option breaks packet reception.
> 
> The ds->untag_bridge_pvid option strips VLANs from packets received on
> VLAN-unaware bridge ports. But those VLANs should already be stripped
> by tag_vsc73xx_8021q.c as part of vsc73xx_rcv() - they are not VLANs in
> VLAN-unaware mode, but DSA tags. Thus, dsa_software_vlan_untag() tries
> to untag a VLAN that doesn't exist, corrupting the packet.
> 
> Fixes: 93e4649efa96 ("net: dsa: provide a software untagging function on RX for VLAN-aware bridges")
> Tested-by: Pawel Dembicki <paweldembicki@gmail.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

