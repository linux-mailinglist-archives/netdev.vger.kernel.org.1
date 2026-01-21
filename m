Return-Path: <netdev+bounces-251993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KzNKWkjcWl8eQAAu9opvQ
	(envelope-from <netdev+bounces-251993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 20:05:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 582165BC9C
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 20:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D4795ED81F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B015330311;
	Wed, 21 Jan 2026 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z18vNEvJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61E7329E66
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012221; cv=none; b=foJl7B+XJjA8wqdYKipMPpptr6tTEKuh8qBvzNHmcVspucM+ZoHDdFCFwGnk9RblYmQhEmYtAFnBCqLN6CuTl4vuF77XFLtZfcqQ8lBXyLvC+Y/ELdnVrfuOnNsE7fZQxJOqEonnZe1VZkpomKp3uJjMQp7+o6jEe9bgrQ/OdRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012221; c=relaxed/simple;
	bh=DyXg/G7iri322bhIBm8DDllUjPJ9msomjgd9hyUfkhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LV10OFD1sMVkg1ivHtUAeODI5NFJIyORABFzdG4vxLgib+TB5gOecHudUMK/tuDuX7OsxweMQxZvYeaqZ1JrnUPYO2pztwRL5JFGaz2iT5l9rarDdjTVy1NMPXulBrPH+ePpenIJx2RCcLpFiw5YA1jOXSK8VsdJhLWUA7Flr3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z18vNEvJ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso3972359f8f.2
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 08:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769012217; x=1769617017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BzzB/JdMiWn1k4ZgZ9PFa4Ldz6czCrDQgy/x5b2bitI=;
        b=Z18vNEvJPtK3YQHwQYS0ICvgaMgicSZzqNQEPTJ2HjXMz5CDGDAITJVS1fTTldJv73
         MOGkzmw+583yx/QC223V7pZZoreGOddAzYmgkq3ecqAziLCSN8IIhqhd3ahSjPZCPS2x
         dKrZY/cIHEhj3NqxvdHXKR75bKlI/RpZnIKBPof6GrayOJMY9NhmtwXkKQweoh/+bUZl
         dD2+RSJ32qvv1qkom47Q0sRgDb4d9NVBJDZPROZMinYcPHnrE0ggW7g9s//rUeK/imua
         NCzDE4LYcyyLobXMqoF9V6vWBgtwRPlMbgJQRj/xS5SEUyRAohWBxdF/2ljJBO5Whb/y
         ECUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769012217; x=1769617017;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzzB/JdMiWn1k4ZgZ9PFa4Ldz6czCrDQgy/x5b2bitI=;
        b=VVQ1b59lXPX9timDh2nZpqgKIhdEM51kye7LRD9l9q9D5Mz8UdIHdrjk45BOgHgGYd
         FEtvESyt3bvkOTyTJ4ld/fCecebgczSDaPIYfNkS6A71vwdJBfp5i8LeUbZ9YmIBWpXP
         smpIKRGFbY3KldgLPgBU85IEiNcVS+/JHLMVCIjJny9tMT/SO22SfAB1DGFYm75Ea9Fe
         kXBvdpO0BIMPOKgK9SIj58/GVF6qKQ1MM3DprMsQG3FhZS4IV+yUJOql6rSz7bnDAQit
         0K7U/3mToDKyvhGbUHfN2qKYUJv/aT4OzCnMbCa+rVY3jBNRK0osVEj33xbqCeZdJbw+
         1Qkw==
X-Gm-Message-State: AOJu0Yy0Itm01iPP01o3uRqa/LlQBFQ3ae5D+/PNDWKJrToX6kwtYSUs
	B163F/6rpNibjuhlfOlnU65L9ZywSGeH9P1v896QgoIR1nKNQ72pwpJC4rW28e8EwJI=
X-Gm-Gg: AZuq6aJ/JiB8cRe2OXPfof60i/2G0ljoxHJx5hb6FFXkfMNkIhsZn0IiK/BB5hUML2L
	9nh1OO/rqVAXvuDk3dy9KaVQybcC39OBmVzAZxgccYcSlEZsbyd/UTOcb+I+kKHGQfMXpd8nmCs
	qlj+fheN+kjb0WxmEaVXbFJOnVZ3quGFtZDVgnanHVGIiPTlVllpasB/kAsJIR/lpsNPzAV1Wd2
	Or7/ZA7SH8B8XR8hbF8LlbTOtrbu/IHoNDGDJGdaxMiFwXl8oGS3AEsUWrbzJT7dbJoU1cN4Cwl
	Z7zv0NxRgXLUj8wTQTCCgFAQCZxfApfmri0yf5/PMfa79Ngx7BXBJmbfiRJtZHnsVTQdoyNpJJT
	j++CoJ+R3+pVs+Lu5NDLtAC516CX1l4OrIfC1KgGlhlA88iiwAxpHER/JdRktdJL40B3W+r0wwJ
	lQgXq8zJN4GgwLJGGblZio8yYra+ZqMa3uSASWF/Y9p9RHFaxckbuhHM0ERmt7Wylf
X-Received: by 2002:a05:6000:220e:b0:435:9770:9eb8 with SMTP id ffacd0b85a97d-4359770a243mr7280369f8f.25.1769012216858;
        Wed, 21 Jan 2026 08:16:56 -0800 (PST)
Received: from [192.168.0.29] (static-95-59-231-77.ipcom.comunitel.net. [77.231.59.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4358e24cef3sm12633429f8f.0.2026.01.21.08.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 08:16:56 -0800 (PST)
Message-ID: <1e2d0c75-35d1-4096-a96f-c3fc6f7ce52a@suse.com>
Date: Wed, 21 Jan 2026 17:16:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 4/4] stmmac: s32: enable support for Multi-IRQ mode
To: jan.petrous@oss.nxp.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Chester Lin <chester62515@gmail.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org
References: <20260121-dwmac_multi_irq-v2-0-3b829230d071@oss.nxp.com>
 <20260121-dwmac_multi_irq-v2-4-3b829230d071@oss.nxp.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 xsFNBFP1zgUBEAC21D6hk7//0kOmsUrE3eZ55kjc9DmFPKIz6l4NggqwQjBNRHIMh04BbCMY
 fL3eT7ZsYV5nur7zctmJ+vbszoOASXUpfq8M+S5hU2w7sBaVk5rpH9yW8CUWz2+ZpQXPJcFa
 OhLZuSKB1F5JcvLbETRjNzNU7B3TdS2+zkgQQdEyt7Ij2HXGLJ2w+yG2GuR9/iyCJRf10Okq
 gTh//XESJZ8S6KlOWbLXRE+yfkKDXQx2Jr1XuVvM3zPqH5FMg8reRVFsQ+vI0b+OlyekT/Xe
 0Hwvqkev95GG6x7yseJwI+2ydDH6M5O7fPKFW5mzAdDE2g/K9B4e2tYK6/rA7Fq4cqiAw1+u
 EgO44+eFgv082xtBez5WNkGn18vtw0LW3ESmKh19u6kEGoi0WZwslCNaGFrS4M7OH+aOJeqK
 fx5dIv2CEbxc6xnHY7dwkcHikTA4QdbdFeUSuj4YhIZ+0QlDVtS1QEXyvZbZky7ur9rHkZvP
 ZqlUsLJ2nOqsmahMTIQ8Mgx9SLEShWqD4kOF4zNfPJsgEMB49KbS2o9jxbGB+JKupjNddfxZ
 HlH1KF8QwCMZEYaTNogrVazuEJzx6JdRpR3sFda/0x5qjTadwIW6Cl9tkqe2h391dOGX1eOA
 1ntn9O/39KqSrWNGvm+1raHK+Ev1yPtn0Wxn+0oy1tl67TxUjQARAQABzSRNYXR0aGlhcyBC
 cnVnZ2VyIDxtYnJ1Z2dlckBzdXNlLmNvbT7CwXgEEwECACIFAlV6iM0CGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAAAoJENkUC7JWEwLx6isQAIMGBgJnFWovDS7ClZtjz1LgoY8skcMU
 ghUZY4Z/rwwPqmMPbY8KYDdOFA+kMTEiAHOR+IyOVe2+HlMrXv/qYH4pRoxQKm8H9FbdZXgL
 bG8IPlBu80ZSOwWjVH+tG62KHW4RzssVrgXEFR1ZPTdbfN+9Gtf7kKxcGxWnurRJFzBEZi4s
 RfTSulQKqTxJ/sewOb/0kfGOJYPAt/QN5SUaWa6ILa5QFg8bLAj6bZ81CDStswDt/zJmAWp0
 08NOnhrZaTQdRU7mTMddUph5YVNXEXd3ThOl8PetTyoSCt04PPTDDmyeMgB5C3INLo1AXhEp
 NTdu+okvD56MqCxgMfexXiqYOkEWs/wv4LWC8V8EI3Z+DQ0YuoymI5MFPsW39aPmmBhSiacx
 diC+7cQVQRwBR6Oz/k9oLc+0/15mc+XlbvyYfscGWs6CEeidDQyNKE/yX75KjLUSvOXYV4d4
 UdaNrSoEcK/5XlW5IJNM9yae6ZOL8vZrs5u1+/w7pAlCDAAokz/As0vZ7xWiePrI+kTzuOt5
 psfJOdEoMKQWWFGd/9olX5ZAyh9iXk9TQprGUOaX6sFjDrsTRycmmD9i4PdQTawObEEiAfzx
 1m2MwiDs2nppsRr7qwAjyRhCq2TOAh0EDRNgYaSlbIXX/zp38FpK/9DMbtH14vVvG6FXog75
 HBoOzsFNBF3VOUgBEACbvyZOfLjgfB0hg0rhlAfpTmnFwm1TjkssGZKvgMr/t6v1yGm8nmmD
 MIa4jblx41MSDkUKFhyB80wqrAIB6SRX0h6DOLpQrjjxbV46nxB5ANLqwektI57yenr/O+ZS
 +GIuiSTu1kGEbP5ezmpCYk9dxqDsAyJ+4Rx/zxlKkKGZQHdZ+UlXYOnEXexKifkTDaLne6Zc
 up1EgkTDVmzam4MloyrA/fAjIx2t90gfVkEEkMhZX/nc/naYq1hDQqGN778CiWkqX3qimLqj
 1UsZ6qSl6qsozZxvVuOjlmafiVeXo28lEf9lPrzMG04pS3CFKU4HZsTwgOidBkI5ijbDSimI
 CDJ+luKPy6IjuyIETptbHZ9CmyaLgmtkGaENPqf+5iV4ZbQNFxmYTZSN56Q9ZS6Y3XeNpVm6
 FOFXrlKeFTTlyFlPy9TWcBMDCKsxV5eB5kYvDGGxx26Tec1vlVKxX3kQz8o62KWsfr1kvpeu
 fDzx/rFpoY91XJSKAFNZz99xa7DX6eQYkM2qN9K8HuJ7XXhHTxDbxpi3wsIlFdgzVa5iWhNw
 iFFJdSiEaAeaHu6yXjr39FrkIVoyFPfIJVyK4d1mHe77H47WxFw6FoVbcGTEoTL6e3HDwntn
 OGAU6CLYcaQ4aAz1HTcDrLBzSw/BuCSAXscIuKuyE/ZT+rFbLcLwOQARAQABwsF2BBgBCAAg
 FiEE5rmSGMDywyUcLDoX2RQLslYTAvEFAl3VOUgCGwwACgkQ2RQLslYTAvG11w/+Mcn28jxp
 0WLUdChZQoJBtl1nlkkdrIUojNT2RkT8UfPPMwNlgWBwJOzaSZRXIaWhK1elnRa10IwwHfWM
 GhB7nH0u0gIcSKnSKs1ebzRazI8IQdTfDH3VCQ6YMl+2bpPz4XeWqGVzcLAkamg9jsBWV6/N
 c0l8BNlHT5iH02E43lbDgCOxme2pArETyuuJ4tF36F7ntl1Eq1FE0Ypk5LjB602Gh2N+eOGv
 hnbkECywPmr7Hi5o7yh8bFOM52tKdGG+HM8KCY/sEpFRkDTA28XGNugjDyttOI4UZvURuvO6
 quuvdYW4rgLVgAXgLJdQEvpnUu2j/+LjjOJBQr12ICB8T/waFc/QmUzBFQGVc20SsmAi1H9c
 C4XB87oE4jjc/X1jASy7JCr6u5tbZa+tZjYGPZ1cMApTFLhO4tR/a/9v1Fy3fqWPNs3F4Ra3
 5irgg5jpAecT7DjFUCR/CNP5W6nywKn7MUm/19VSmj9uN484vg8w/XL49iung+Y+ZHCiSUGn
 LV6nybxdRG/jp8ZQdQQixPA9azZDzuTu+NjKtzIA5qtfZfmm8xC+kAwAMZ/ZnfCsKwN0bbnD
 YfO3B5Q131ASmu0kbwY03Mw4PhxDzZNrt4a89Y95dq5YkMtVH2Me1ZP063cFCCYCkvEAK/C8
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20260121-dwmac_multi_irq-v2-4-3b829230d071@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[suse.com,quarantine];
	TAGGED_FROM(0.00)[bounces-251993-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[oss.nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,nxp.com,pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCPT_COUNT_TWELVE(0.00)[24];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbrugger@suse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 582165BC9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 21/01/2026 15:23, Jan Petrous via B4 Relay wrote:
> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> 
> To get enabled Multi-IRQ mode, the driver checks:
> 
>    1) property of 'snps,mtl-xx-config' subnode
>       defines 'snps,xx-queues-to-use' bigger then one, ie:
> 
>       ethernet@4033c000 {
>           compatible = "nxp,s32g2-dwmac";
>           ...
>           snps,mtl-rx-config = <&mtl_rx_setup>;
>           ...
> 
>           mtl_rx_setup: rx-queues-config {
>               snps,rx-queues-to-use = <2>;
>           };
> 
>    2) queue based IRQs are set, ie:
> 
>       ethernet@4033c000 {
>           compatible = "nxp,s32g2-dwmac";
>           ...
>           interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
>                        /* CHN 0: tx, rx */
>                        <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
>                        <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
>                        /* CHN 1: tx, rx */
>                        <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
>                        <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
>           interrupt-names = "macirq",
>                             "tx-queue-0", "rx-queue-0",
>                             "tx-queue-1", "rx-queue-1";
> 
> If those prerequisites are met, the driver switch to Multi-IRQ mode,
> using per-queue IRQs for rx/tx data pathr:
> 
> [    1.387045] s32-dwmac 4033c000.ethernet: Multi-IRQ mode (per queue IRQ) selected
> 
> Now the driver owns all queues IRQs:
> 
> root@s32g399aevb3:~# grep eth /proc/interrupts
>   29:    0    0    0    0    0    0    0    0    GICv3  89 Level   eth0:mac
>   30:    0    0    0    0    0    0    0    0    GICv3  91 Level   eth0:rx-0
>   31:    0    0    0    0    0    0    0    0    GICv3  93 Level   eth0:rx-1
>   32:    0    0    0    0    0    0    0    0    GICv3  95 Level   eth0:rx-2
>   33:    0    0    0    0    0    0    0    0    GICv3  97 Level   eth0:rx-3
>   34:    0    0    0    0    0    0    0    0    GICv3  99 Level   eth0:rx-4
>   35:    0    0    0    0    0    0    0    0    GICv3  90 Level   eth0:tx-0
>   36:    0    0    0    0    0    0    0    0    GICv3  92 Level   eth0:tx-1
>   37:    0    0    0    0    0    0    0    0    GICv3  94 Level   eth0:tx-2
>   38:    0    0    0    0    0    0    0    0    GICv3  96 Level   eth0:tx-3
>   39:    0    0    0    0    0    0    0    0    GICv3  98 Level   eth0:tx-4
> 
> Otherwise, if one of the prerequisite don't met, the driver
> continue with MAC IRQ mode:
> 
> [    1.387045] s32-dwmac 4033c000.ethernet: MAC IRQ mode selected
> 
> And only MAC IRQ will be attached:
> 
> root@s32g399aevb3:~# grep eth /proc/interrupts
>   29:    0    0    0    0    0    0    0    0    GICv3  89 Level   eth0:mac
> 
> What represents the original MAC IRQ mode and is fully backward
> compatible.
> 
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> index 5a485ee98fa7..823700219534 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> @@ -2,7 +2,7 @@
>   /*
>    * NXP S32G/R GMAC glue layer
>    *
> - * Copyright 2019-2024 NXP
> + * Copyright 2019-2026 NXP
>    *
>    */
>   
> @@ -149,6 +149,17 @@ static int s32_dwmac_probe(struct platform_device *pdev)
>   	plat->core_type = DWMAC_CORE_GMAC4;
>   	plat->pmt = 1;
>   	plat->flags |= STMMAC_FLAG_SPH_DISABLE;
> +
> +	/* Check for multi-IRQ config. Assumption: symetrical rx/tx queues */
> +	if (plat->rx_queues_to_use > 1 &&
> +	    (res.rx_irq[0] >= 0 || res.tx_irq[0] >= 0)) {
> +		plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> +		dev_info(dev, "Multi-IRQ mode (per queue IRQ) selected\n");
> +	} else {
> +		dev_info(dev, "MAC IRQ mode selected\n");
> +	}
> +
> +	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
>   	plat->rx_fifo_size = 20480;
>   	plat->tx_fifo_size = 20480;
>   
> 


