Return-Path: <netdev+bounces-251990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLwdGI4lcWl8eQAAu9opvQ
	(envelope-from <netdev+bounces-251990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 20:14:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E29C65BEB7
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 20:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1799E7A56D7
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F45439E6E4;
	Wed, 21 Jan 2026 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f0f04g+y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A292B221543
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012103; cv=none; b=rzofouCdghyiET0u2fT89QCjmOt6BmSCy6t1ET0JKZPnk1WUUXhq5nWsEzOiY2/nZGmM700Zz75hYEhXAJKAcGoFExF6By1Gs5v9eQ9h3H3TARNT7j/4dVxJlZxMTaAFwdHwpW7F4JcE3itEusFKaanOOoQBBvLH5eJjdrizcEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012103; c=relaxed/simple;
	bh=zIuSoMgJqAYcCGMiETp2ZAMaZrK+fTmd7PCFpBvK3IE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YksDmH1foePp2GRSOHbWo9cGR8zaeBvdjzlWwOZm0iXR5qjSWlDfhiQjDZbIH7LtDpJkF60EPKP5iigU0sIZUjIiSPZE0iy7iwoZkvEfIrjU31+veAI89IF7rdw+SITba0tEcmsUTZs+LU+56StTH7o3SQ/sOWPDxBtbAz5dlzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f0f04g+y; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-432d2c96215so5496707f8f.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 08:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769012093; x=1769616893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hlXlhcr6/DYLKPgrxbgTpw1meSaotSsfgIntKJEXx9Y=;
        b=f0f04g+yoAnbMFcMslDJr5g7/leJ2cnJqkUeKHIMKJ00mp2KAMQ/hj8lNy4UqqpLK+
         gPimR7pP6yBZcuPWuK5GsUXNIKCCsluOXE5laWg63DJ01GtxKy/E5GozktXIBHEjf8Xu
         WfteJXIgIDcYsET5QvGKtUytRRGUjt2DWPaTQConMfnlS1zac911iX720UwSyrGllRkY
         1k6iQhsEhNEIeLerwfhZGgxZ5YJdjW0B/cNrJgOQ3btxLD8ASNxnXjG7qoF7EL2OptHH
         7JCrjfrB5kAWOke1ukmjM1hpqIup3sFceGM6QNdtdf/K+JPzeGZTt8dgqxinYolRpgvj
         Xi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769012093; x=1769616893;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlXlhcr6/DYLKPgrxbgTpw1meSaotSsfgIntKJEXx9Y=;
        b=n6weLBWqgXpw2N4oxIpm6wSJzPiHwx+hV1ITpJ5D9oJzc7eEdfouGKjquPmCxjeLgn
         0Y0QTZhUCnd36C9EBs85RfUed69dpFNPDnzDXv7NfI8OlU/GEQ2uOIUt6II4P1cMoRyA
         4ItAP+0ZAziA/YtJPHi+LdDRJsaDz+cjXgIfVToK4rssazYpgmFaQm7nSEqxbEAvYWIr
         HqayFAnkuWa56Rmk7Ds8RE9QHH3nlodwkAQbFec5DvBjbNKDO87v490BvyVVgwdUkpkZ
         RmkdpQ1+JuHFf7nl4pX/DCgHZ1CUOJJkARrafATuHl2Ohn+2PfdgmgviYH38jkL/bPjo
         Clfw==
X-Gm-Message-State: AOJu0Yz3aHMnv3WFwhgJrN+IW95aB6SC+6mulXDaOpzJL0cVkbm0VujK
	o+LBfB3BJOPHFk7X5PTTNFPgl66Vmau6RJAw93S2P/KCuWKWEC/ofeOYWutzCRC+40Y=
X-Gm-Gg: AZuq6aKZbR21UlDkMxZdOSKsVEVMvRF4KHeAIfEchLDsNq65TLDJN4O39nqsnM6xecQ
	8khMqK5A3MfRh0ap9KV8uO6bly9mrJ67eP+Nvl7tKGqsDHMvbc1n3m2rGPQ8yVgQMsHcgmFcU38
	B67ZKE9YCQKwGf6gUfGGv6BKy2ba39MM76KsCc608yz3iolFnqkmRLSaB58chVJhaWQWsZguhL4
	4J+o/FZq5E7xZIM1yrHcGcAmQCDbKJ0LSE3sIDK30vFcdvIKfPpdv1dzVD1PNfQnfesRVs3tAzv
	+MJ8Wk6fJWGVaZlL/optq0zk22pEPY2r7o2Azbn5AmKt5Dm4f/hBgzLoyLPFtsU0yIld7HHQ+YH
	2vJURp2SmBwhSTpSoNAOtHzk8atRFdN6SBJkXGvFC9pZ4KHL1gW+LvgZR36lmEiipz64yqlNT92
	g5hG/R8jlfUbfxi6FvcYp4HvdhHYMEUNVZeMbfCfAG8r5NXVQMUjbi3A==
X-Received: by 2002:a05:6000:2dc9:b0:432:8504:f67a with SMTP id ffacd0b85a97d-43569998f9cmr26906178f8f.20.1769012092538;
        Wed, 21 Jan 2026 08:14:52 -0800 (PST)
Received: from [192.168.0.29] (static-95-59-231-77.ipcom.comunitel.net. [77.231.59.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569926ffcsm36687408f8f.18.2026.01.21.08.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 08:14:52 -0800 (PST)
Message-ID: <122dceeb-3221-4715-91e9-3bad43889ee6@suse.com>
Date: Wed, 21 Jan 2026 17:14:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/4] dt-bindings: net: nxp,s32-dwmac: Declare
 per-queue interrupts
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
 <20260121-dwmac_multi_irq-v2-2-3b829230d071@oss.nxp.com>
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
In-Reply-To: <20260121-dwmac_multi_irq-v2-2-3b829230d071@oss.nxp.com>
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
	TAGGED_FROM(0.00)[bounces-251990-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: E29C65BEB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 21/01/2026 15:23, Jan Petrous via B4 Relay wrote:
> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> 
> The DWMAC IP on NXP S32G/R SoCs has connected queue-based IRQ lines,
> set them to allow using Multi-IRQ mode when supported.
> 
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   .../devicetree/bindings/net/nxp,s32-dwmac.yaml     | 42 +++++++++++++++++++---
>   1 file changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
> index 2b8b74c5feec..e1ebc3bea095 100644
> --- a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
> @@ -1,5 +1,5 @@
>   # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> -# Copyright 2021-2024 NXP
> +# Copyright 2021-2026 NXP
>   %YAML 1.2
>   ---
>   $id: http://devicetree.org/schemas/net/nxp,s32-dwmac.yaml#
> @@ -33,10 +33,22 @@ properties:
>         - description: GMAC PHY mode control register
>   
>     interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 11
>   
>     interrupt-names:
> -    const: macirq
> +    - items:
> +        - const: macirq
> +        - const: rx-queue-0
> +        - const: tx-queue-0
> +        - const: rx-queue-1
> +        - const: tx-queue-1
> +        - const: rx-queue-2
> +        - const: tx-queue-2
> +        - const: rx-queue-3
> +        - const: tx-queue-3
> +        - const: rx-queue-4
> +        - const: tx-queue-4
>   
>     clocks:
>       items:
> @@ -75,8 +87,28 @@ examples:
>           reg = <0x0 0x4033c000 0x0 0x2000>, /* gmac IP */
>                 <0x0 0x4007c004 0x0 0x4>;    /* GMAC_0_CTRL_STS */
>           interrupt-parent = <&gic>;
> -        interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> -        interrupt-names = "macirq";
> +        interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> +                     /* CHN 0: tx, rx */
> +                     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> +                     /* CHN 1: tx, rx */
> +                     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
> +                     /* CHN 2: tx, rx */
> +                     <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
> +                     /* CHN 3: tx, rx */
> +                     <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> +                     /* CHN 4: tx, rx */
> +                     <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "macirq",
> +                          "tx-queue-0", "rx-queue-0",
> +                          "tx-queue-1", "rx-queue-1",
> +                          "tx-queue-2", "rx-queue-2",
> +                          "tx-queue-3", "rx-queue-3",
> +                          "tx-queue-4", "rx-queue-4";
>           snps,mtl-rx-config = <&mtl_rx_setup>;
>           snps,mtl-tx-config = <&mtl_tx_setup>;
>           clocks = <&clks 24>, <&clks 17>, <&clks 16>, <&clks 15>;
> 


