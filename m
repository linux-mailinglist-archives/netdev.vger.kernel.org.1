Return-Path: <netdev+bounces-191752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A691ABD188
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 10:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A9D189DFCE
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 08:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC4725CC7E;
	Tue, 20 May 2025 08:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPLpdPyQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC44125B69F;
	Tue, 20 May 2025 08:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747728690; cv=none; b=EY62TvGTwlJ4ie2cSpxo/XVvh98PcWA79g1SQWHosaT1gVsOUddHYy4rDllOSgnr/XsFJgAXOio04erj/EoFHunJU+nxZl0DtnGPiRVXLCr0cHN0MypNm1ECnSNpSaqj02ByE9r595/M0DeErrUCZwP6EkdQuEKC/LCevg7u3/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747728690; c=relaxed/simple;
	bh=y5EmAe9o1zmGJZdkHBYv6dujAOOGfoyt38w5bFxu95I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWn0u90aqBErE+pfvVvjgvnNqvaQ1mZKOKVeUYSE20NYPlZDV2n5hCNbIaW2PQT9WAnsfJwzAbJ10dujfC33idKt/bBBboak4UKby8MGoDAzMtbtybGTZYmrawONm+SGBFcv7FOi1DtZNqQdmBR3Hl4LMevpjck78qWEAh0odis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPLpdPyQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a374f727dbso1115509f8f.0;
        Tue, 20 May 2025 01:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747728687; x=1748333487; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bMQS8LhbxO7fSprRTvxryhpgj+eGd6U/hKwb3rgYqas=;
        b=dPLpdPyQ/diMCvML3rVnBxhasqaTAI21vGtqgDZey5kAwDokH2ZBa6fsW785ycMEjL
         XW1cvgxnSD5DSHgs93cAwnaFNEVn5cxKX2QA1PoSRtUph7Z0u2rqHnUHlFdllg7+iBfT
         wPDmkYZhWVeZHcF+YAuMW1dmLEYlAK73CznvELmUVPdzR0uQtJoyqA4uodq36d1+Dr1n
         rW7cWCnfCyee5pyHv6oM+u77WYKH8KcGVbaO2ddMac7YHKjrKC67f5c9PvDxRSVoFOWP
         ZfdWnbkAZjeHrz6KeF/Ra4Eqta18P6UbJVEEwkhuYRF+euX+g5pU6w/tZIK/JPj0WJ0C
         85nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747728687; x=1748333487;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bMQS8LhbxO7fSprRTvxryhpgj+eGd6U/hKwb3rgYqas=;
        b=qQFybqCQPAIUwjTc4xd3l6cHM6NBFEkyDQY1bmSLThtAUjqeoTqKUzwI9/mkBVG6H0
         VzXSbEgwGo92vN2Cs0o79R6xuPJPowzj6ZRLyX4Zof8vWTyoVOyHYb33i2vRzuSFVMpP
         qbB9zHw5Im9dTntO0GjZMUCR0Pjc0Hip3SYRXXyCn0HcxxF1PcMRok2aQ1kKjWLYJ/yN
         jJMongL5xTyHBMDlyKlUv+fej1nT+t/eijIGtNH5WQePq0vBc5yV1X18Hzj1OhZr98or
         C5CW10WUdC3Cb4VlyzocqGrRYcRifk6yT8pugHJFnpNcRIX+D2smoSKvCbvemQxqwZxU
         /dJw==
X-Forwarded-Encrypted: i=1; AJvYcCWaZtSZ/UYgytJyK2E01uc+fj6cO5hgvB1jzzG9Tbi0ZB3KAS5Yg3MFT3m42p3rK7vnk6+oyFkoHExXvj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/xh5UCnilXLu4d0yXLfKY1spnmVqmjBrMFNHadjLpPIXyawpV
	qHz8UKt649t6GuwTqF6HWgpZTS6VNd+uvuxsjbrMeFAGLIsRGvrGQc3F
X-Gm-Gg: ASbGncsWr+63mGDEkUmPZGK8gDxoMFTeT0z0mQ8hBg0pqPhXhazYTlRGvCRZREaiX4W
	zqA+NmhAzl+GtGHFbDMaNxNjw1r34/KjsBFw656WnvrO+jbv4fuwPRqUiImvNaPJmTOpP7wIaif
	h7ECgD+cNBoY69IsAI4i+Pd3T5vilRvz89NUEvZCtMQE1leCbJMf4wqQP1MsLaVC3xDz+xwLKxU
	1RpikOHMgo2U7sEgDjEBtQZgxtu0cyG1Zv9HTQ9PUdoPfUyLM5hw2n7bID8++yMbLV0kxyeWKRO
	nU2fREtAKG31hALA7LHWrRIyXPcvEw9uFs6SSSdWbHrVfkRbYzRZ
X-Google-Smtp-Source: AGHT+IHPt5mJFjG5oAuprYIeJnO/pC95ipGYDXia9QgdBEyS/izQKeoP0AicXPY7/tdYWNp50rrG9Q==
X-Received: by 2002:a05:6000:2510:b0:3a3:5c8b:5581 with SMTP id ffacd0b85a97d-3a35fe5c56bmr11561628f8f.4.1747728687040;
        Tue, 20 May 2025 01:11:27 -0700 (PDT)
Received: from Red ([2a01:cb1d:897:7800:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a3632a2bffsm13922363f8f.32.2025.05.20.01.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 01:11:26 -0700 (PDT)
Date: Tue, 20 May 2025 10:11:24 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] net: dwmac-sun8i: Use parsed internal PHY address
 instead of 1
Message-ID: <aCw5LAx1Nmfxk8Y4@Red>
References: <20250519164936.4172658-1-paulk@sys-base.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250519164936.4172658-1-paulk@sys-base.io>

Le Mon, May 19, 2025 at 06:49:36PM +0200, Paul Kocialkowski a écrit :
> While the MDIO address of the internal PHY on Allwinner sun8i chips is
> generally 1, of_mdio_parse_addr is used to cleanly parse the address
> from the device-tree instead of hardcoding it.
> 
> A commit reworking the code ditched the parsed value and hardcoded the
> value 1 instead, which didn't really break anything but is more fragile
> and not future-proof.
> 
> Restore the initial behavior using the parsed address returned from the
> helper.
> 
> Fixes: 634db83b8265 ("net: stmmac: dwmac-sun8i: Handle integrated/external MDIOs")
> Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 85723a78793a..6c7e8655a7eb 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -964,7 +964,7 @@ static int sun8i_dwmac_set_syscon(struct device *dev,
>  		/* of_mdio_parse_addr returns a valid (0 ~ 31) PHY
>  		 * address. No need to mask it again.
>  		 */
> -		reg |= 1 << H3_EPHY_ADDR_SHIFT;
> +		reg |= ret << H3_EPHY_ADDR_SHIFT;
>  	} else {
>  		/* For SoCs without internal PHY the PHY selection bit should be
>  		 * set to 0 (external PHY).
> -- 
> 2.49.0
> 

Acked-by: Corentin LABBE <clabbe.montjoie@gmail.com>
Tested-by: Corentin LABBE <clabbe.montjoie@gmail.com>
Tested-on: sun50i-h6-orangepi-one-plus
Tested-on: sun8i-h3-orangepi-pc

Thanks
Regards

