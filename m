Return-Path: <netdev+bounces-152502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D25699F457B
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 08:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AF89188C467
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 07:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCDD126C08;
	Tue, 17 Dec 2024 07:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1bG7wDv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB5DA29
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734421805; cv=none; b=B9v+A3uySvqX18F8znMAUwZn3XqZtXlEpXsRxCB83a4KuPApH3jOF76r+ctyIQE5Y47LKsbBTzO1OlFUvtpm/8MpFWXfn7unNjNgV5ydS7UEtVt6OzONLHquC6rrcvtZlcCrr489477WaQMcHTTRHkzCxwgQf0P62do0unNKLME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734421805; c=relaxed/simple;
	bh=SABiS5i1p8xANzIoHxI5Vh7fJmYgwwHFRssu5D4aaX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nrFuqAbsFMw+D4vZT9cHhEedeN+DwNM26itgGA/FetCaPV3Dm2Jz/KsVux42aY19LtrNSJCSOWGV4zdD6QAXDegzdkUutaB3Pg9LEeXqpYlNUFHe0cqiOqKoK/+bpMLVzpJhf/1kEzra4f6UoBs1hiRbvqRZtbZ7OCBNJp4jLDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1bG7wDv; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aab925654d9so646047266b.2
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 23:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734421802; x=1735026602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gk4RcM9aoEcltTSIN+UAXyLDoftjcHRAxwNl+W6CGjA=;
        b=f1bG7wDvsJjOcJWfhYPIshykrg2XaPe7YTPbkD4dfJagGW1FZnhb2wUENdMBgf3fPV
         9J69IBL536SljhLlJa7ZJa5OmnQ6KR4vrVwadgY4z9PlVq6f2YMw8u6Li6UnyuaUI9ub
         OM1KdiakyBo81bMTB1XyNH1ZKtNmxjAj9r29KHLr/FRWf0P0awd292k3PQ9yl7e1OEZU
         /j8emcFgMNxj38gzw+MRbwGw5BDDkb6iwSX7zDLC9Y9AuEiuA/aEUtdJuJC+x2RhWQUv
         Y4fPquKtffGIS+RfXBLFcGKe4XHpVTmXiXLeTpqzrGByoes99nzq7JlZ+AA+S6iiZeer
         Qe0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734421802; x=1735026602;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gk4RcM9aoEcltTSIN+UAXyLDoftjcHRAxwNl+W6CGjA=;
        b=Y75vVYhgXh/hpBrIZQ1sF2Ymh7B8S7B55rsxKy3x2OjO/6Xxb72xFZG2LnPEF96k3N
         tjTzkmgc+X1f3vNhX4TdmXQijfvEmSK9NqrdwsAW9HBqzUOuoDEnbLB7P6YLYhydcQUk
         OZXZTvfQINUf6KFMYRMJJNauy6jHiKCJ/fjOmkKAbVPSZWilwdAPNhwjO6GmHVLZAq/3
         6Mo4GZiKSbOfEPnl1GATjp1WE9S0pCJ70CS+To4snH7pbL8J6d1428YoFp74LT6+fcbB
         GbeA7O0CtSFP6VFrg74IJVDF0C+U4dkB7xORtHaOkziOQpqONCeQ6ctAY+VkVLp4MPqb
         14Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUYbyWxw0mcm/+4eMbhoHOWI1PfwcF9yqO4UVEMaS5HhrJd+X2r25qwlhp0/ZMnLdWHX2iTzyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxXga31qpMOhcyvcOEh5qa9YMun0S0lu+Q3S83bvfhwt5ECRLl
	1UhW0/cBfw/bntDZl5+jTSrnpXU95YEDJa+Rkq4Uh9FT2Ay/BqHF
X-Gm-Gg: ASbGnctbIFnLyvFMqZHj0CZXhcm+0OuU+B0mp/eb+qUm2i4Eo534CEzQtFxFC23/+jl
	lfcxBEzi9DIWk1b6x5Rm7lrBWH3u7z+RykdvME6DZSJnbjCX+13LcWiuFNaMhjiGxOKuJKI+OSd
	2UiBzbl73slsw6eUhLvBNxA72WOln2SEo1g8x3zwInFnfdhumWWRFLoTRsloyWPXE95Mh9+dd74
	SmZ3YeDCGrUTT2LA9KXgh1Qe8Uufg/UNWx9Ocrf38CtMgikULIVPpXqK60XJdN+yp7mumy97GGF
	9If78hE3ujkqHuel5Pv7dxWPmwYAPRV6wxl9MnXFvnJPvYFd0hH+WlZHy0RoawPGDxHKnmuRJPf
	oAOeD59rHjb+rEmHI2RLJDygo0BHJVsI=
X-Google-Smtp-Source: AGHT+IHbCRByMXBtQymiivOVjXWEpEJtUdTZwAxA7kak7fLa7ofz1GdLtTXeNFcTkveghwVJFd7PcQ==
X-Received: by 2002:a17:906:7da:b0:aab:de31:52d0 with SMTP id a640c23a62f3a-aabde315b3dmr177449966b.18.1734421801590;
        Mon, 16 Dec 2024 23:50:01 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963b33b0sm416941066b.184.2024.12.16.23.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 23:50:01 -0800 (PST)
Message-ID: <e1e271e3-b684-46d2-879d-e3481d25a712@gmail.com>
Date: Tue, 17 Dec 2024 08:49:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: pcs: pcs-mtk-lynxi: implement
 pcs_inband_caps() method
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexander Couzens <lynxis@fe80.eu>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <Z1F1b8eh8s8T627j@shell.armlinux.org.uk>
 <E1tJ8NR-006L5P-E3@rmk-PC.armlinux.org.uk>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <E1tJ8NR-006L5P-E3@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 12/5/24 10:42 AM, Russell King (Oracle) wrote:
> Report the PCS in-band capabilities to phylink for the LynxI PCS.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/pcs/pcs-mtk-lynxi.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
> index 4f63abe638c4..7de804535229 100644
> --- a/drivers/net/pcs/pcs-mtk-lynxi.c
> +++ b/drivers/net/pcs/pcs-mtk-lynxi.c
> @@ -88,6 +88,21 @@ static struct mtk_pcs_lynxi *pcs_to_mtk_pcs_lynxi(struct phylink_pcs *pcs)
>  	return container_of(pcs, struct mtk_pcs_lynxi, pcs);
>  }
>  
> +static unsigned int mtk_pcs_lynxi_inband_caps(struct phylink_pcs *pcs,
> +					      phy_interface_t interface)
> +{
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +	case PHY_INTERFACE_MODE_2500BASEX:

Isn't this the place now where to report to phylink, that this PCS does
not support in-band at 2500base-x?

Best regards,

Eric

> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_QSGMII:
> +		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
> +
> +	default:
> +		return 0;
> +	}
> +}
> +
>  static void mtk_pcs_lynxi_get_state(struct phylink_pcs *pcs,
>  				    struct phylink_link_state *state)
>  {
> @@ -241,6 +256,7 @@ static void mtk_pcs_lynxi_disable(struct phylink_pcs *pcs)
>  }
>  
>  static const struct phylink_pcs_ops mtk_pcs_lynxi_ops = {
> +	.pcs_inband_caps = mtk_pcs_lynxi_inband_caps,
>  	.pcs_get_state = mtk_pcs_lynxi_get_state,
>  	.pcs_config = mtk_pcs_lynxi_config,
>  	.pcs_an_restart = mtk_pcs_lynxi_restart_an,


