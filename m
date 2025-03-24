Return-Path: <netdev+bounces-177026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C58EA6D602
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 09:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA43416695F
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 08:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C78E25D20C;
	Mon, 24 Mar 2025 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ozkfcmcL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3855525D1F4
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742804332; cv=none; b=ksZggYgdvbfjPy/kecowd2yvLJmav9VxBoiQjW8hVvOw1qaIhRaAToFYQrkyFj1tnnRdJeg12Mu4U/Vt0Od+9V6cffjiEdwiv8KAhln8mqWtwFR6KfFLIXah2N4195SKf3mAtgbhZVQVvJ3XBMCVxuK8WMQNkb+CdxR0cTUhb7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742804332; c=relaxed/simple;
	bh=6/FGJEt1RK3xrrnf30jQkcciY1Tncfe7Lc4lNDrYdyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=di+SiKY8T1F7YGOoV9CvZgaQoL3FUrZXBrwrx7gfxpX+kRTSe6CI35ZGmqmnSoKdYmJFu/spuCWkW6499IOqOMl1dI+xM0ETgPgSolkiZwMz7aGVY4PehXBFv0HeSGVZIn6uqMJFlHw9P8DwhHaIezEF13fHu0/dVMZUTipypr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ozkfcmcL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so43275905e9.3
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 01:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1742804327; x=1743409127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wUV72th4YLID8Yi5m5TOOfAU6k/l5ItTBGhCs4wlkd4=;
        b=ozkfcmcLabBiV8WInbkjifw8S9L2Zi6QGtbu159iGGTj1dk7e1flwO+DjVqdbp6L8a
         AFClaxAiVkc37l0akScbEVeDUuI3j7I/VPJmH9oOCp7D2AhSsKWVk7C3Bqs4g7wbRnqS
         /QGUR5J2gvmx70juqkZK+UnsjsCMQu8kg/PmjsnOcK0RL6tB68lPPiMHN9dZG46etYcq
         xa4ypLHNRirSpL/i5sNb6L7Aja5PPgVUPgynSPsnO9oHgbCpG87bm97cSFoq1QVcEz3U
         dqzNLUIPP50q5eSOp53alb0lPiSAp504dZMQ1ddZqxRZQGXshjFVXNVlcJnrPtH+9Qn1
         uODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742804327; x=1743409127;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUV72th4YLID8Yi5m5TOOfAU6k/l5ItTBGhCs4wlkd4=;
        b=VuUclSFOsQn6Tr0D59P9D9LlqROVNK2G8lnFk5tWpsqaWKshvM7z6ZoCBDBGHTFx9N
         7izR1PWWL7Z+5ChmnUZY1h8al15UsN2NcYAY7VP2st2by0Q8Up4eb+onMmiBS6cBJzrs
         vjJZDczKzuz6FKjZY6WdsccKTT0OYAeqObNBix9+NETBoYfpEuKR1VdJQ7HyAC45VEH/
         PIMAvqL6uGeZKfdwJ7qPezRnId1uFx7lCAuNDcIf4OugqliZlHhsIfKA3Pl5A4/IRC0O
         K6c+JGIsknjlUe7Jo9qWIdRSUMquFxE7alyDt9x2FsYyAilVzGmI37h4soYiDUOqF8fO
         Xe5A==
X-Gm-Message-State: AOJu0Yz4RrN/6jlJ6rL7v46rphpiiEpU+oOzZg6OL5xtfeZiDWjt0pw5
	YsEcDaDTAQGdCfqpQYkxKDEN6o0m0VhVWfl8bDb3m6jhE/bn57e6aWKN2UqfzJU=
X-Gm-Gg: ASbGncsL9Qn1WO55FvU3VR1sN/ur1P2nXvg8W10QJZ0ODzNFYBWhn+ELI7uLp/UBkvi
	cpci+XSruK7rBUgkDhAfC2jAA9Pj2/0Otr70nM4S0nCqAKV7pS8nVZXtNrV1oFPHwN2H1fp84xI
	LLnMK3Yefdayixl+rjKaQfIH3NcQwY8aHZe3c0fZaDyaCfaM1n2V4ETHOUUogFb7i6fvPPn2zwy
	m8153OuDUjoSynF+GaPfH4AQXWXGokC65iosftfrs0nSL1KpHGofg0Q9/tskRBvMeHQ/gmqmdr6
	ExlHOD1TUUDYuA4TxCNzig3N4OYRZX1ToZYhJ/yWlhipUvg8iIgh
X-Google-Smtp-Source: AGHT+IGsHxYn5Ee/W35yKht21ggLacnLCdw5GuAkDQDpS+0jTcweaq4u/g3gFV75Q5DOsSvSYrtVtQ==
X-Received: by 2002:a05:600c:1d16:b0:43d:ac5:11e8 with SMTP id 5b1f17b1804b1-43d58db52e1mr44341605e9.21.1742804327367;
        Mon, 24 Mar 2025 01:18:47 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43fdab7asm163827855e9.29.2025.03.24.01.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 01:18:46 -0700 (PDT)
Message-ID: <3e6cb322-bc8d-471c-87c8-286b98f12ad9@tuxon.dev>
Date: Mon, 24 Mar 2025 10:18:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/13] net: macb: add no LSO capability
 (MACB_CAPS_NO_LSO)
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Samuel Holland <samuel.holland@sifive.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-mips@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>
References: <20250321-macb-v1-0-537b7e37971d@bootlin.com>
 <20250321-macb-v1-5-537b7e37971d@bootlin.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250321-macb-v1-5-537b7e37971d@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Theo,

On 21.03.2025 21:09, Théo Lebrun wrote:
> LSO is runtime-detected using the PBUF_LSO field inside register
> designcfg_debug6/GEM_DCFG6. Allow disabling that feature if it is
> broken by using struct macb_config->caps.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb.h      | 1 +
>  drivers/net/ethernet/cadence/macb_main.c | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index 3b43cb9468e3618754ff2bc6c5f360447bdeeed0..e9da6e3b869fc772613a0d6b86308917c9bff7fe 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -739,6 +739,7 @@
>  #define MACB_CAPS_MIIONRGMII			BIT(9)
>  #define MACB_CAPS_NEED_TSUCLK			BIT(10)
>  #define MACB_CAPS_QUEUE_DISABLE			BIT(11)
> +#define MACB_CAPS_NO_LSO			BIT(12)
>  #define MACB_CAPS_PCS				BIT(24)
>  #define MACB_CAPS_HIGH_SPEED			BIT(25)
>  #define MACB_CAPS_CLK_HW_CHG			BIT(26)
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index b5797c1ac0a41e9472883b013c1e44a01092f257..807f7abbd9941bf624f14a5ddead68dad1c8deb2 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4373,8 +4373,9 @@ static int macb_init(struct platform_device *pdev)
>  	/* Set features */
>  	dev->hw_features = NETIF_F_SG;
>  
> -	/* Check LSO capability */
> -	if (GEM_BFEXT(PBUF_LSO, gem_readl(bp, DCFG6)))
> +	/* Check LSO capability; capability is for buggy HW */

The comment here is a bit confusing to me.

> +	if (!(bp->caps & MACB_CAPS_NO_LSO) &&
> +	    GEM_BFEXT(PBUF_LSO, gem_readl(bp, DCFG6)))
>  		dev->hw_features |= MACB_NETIF_LSO;
>  
>  	/* Checksum offload is only available on gem with packet buffer */
> 


