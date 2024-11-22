Return-Path: <netdev+bounces-146847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D479D64C0
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 21:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F3D283087
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 20:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB35F70823;
	Fri, 22 Nov 2024 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBpsX0+K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23BEAD2F
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732305847; cv=none; b=SGXYQR57/HjF2g87rKS50NBmtlmjYWdf2z7M+jPt6qryyfMul/d7TZqs+sITtDpL2yGOpwo+Dg7RPDV6Mbtdq1e85o60aLPWNhfXM3CxzkCmFuW0X3Zg1hKTYyG4qvM5w0fswrjADVzVUrnnxNPsh4LgJucegDkSoVkKaAmar7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732305847; c=relaxed/simple;
	bh=bPTYGLZnEdyPPllzdzxwBlKIstlyKZd2wELd1y65u6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o5hcjQyM4lTULtjsPE2lz1QfHqlO1WTUifmzpo0RkfmTfsiEl+uAHd2cs+aL0jtuGf1J4NTngPI3Y4HcCfCUna2XH+14KBG6/j0Rhof7SU1nIsh0QF6eOaYPsZ+KmbJFHGCFMbixVGLsphscXlU3Z6nyXh3yPwS5tZtRJVYzrRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBpsX0+K; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a850270e2so419539966b.0
        for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 12:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732305844; x=1732910644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=da0hh2hHMrMKQdZlEZKZSFhWOWAzKl3GpLVZvWc9cF8=;
        b=OBpsX0+KgYaMgU6rRlp/f63MkiAgh4hS82x+fgaM2UiiWHMr/DHtgTTlvoHP9gCJbC
         Clw9jLtfP1aE+X+fxLhK6F3ZrrSEA6pMws+wGBp6OXOO0ZS7B+au48/nciXgPwA4s8MD
         4mIDeDu9PXbdP/Z/w/8gJ7MY1+HIj5ddNWacrj4ZhUR75Mte+9o1cC8fG+6h2VVQIS3B
         5/jDklH3/czSfCTBK6KVuE3LUnRSGNfUAleOr5pmCUdy3kbQUVKZa02XZVBRONmBCtca
         y17g1pBxgh1llMXDcBLWGg1M0uEstEa1l8T5LzWZJIiL43zaK/8xMorCXOGJsaAly1Y3
         a1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732305844; x=1732910644;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=da0hh2hHMrMKQdZlEZKZSFhWOWAzKl3GpLVZvWc9cF8=;
        b=RCbs7mSVmVXIblYobFsTigAN8t8t95alA0K3w7T0TqBUpCVn7WdN2xh2VMusjV2vWt
         lsmb8yYP4J5zoj1SYyIq181MwUzly6scKSkVtsNGPaEb4JIXBHfHHeIfCoNFKIdpgKFs
         Mpsi7bL7QAFfiwzBlbJQOCEzHrO1i5mgjcEzLzvUTuniwfZ/h/YNbrG972fWsa6+na9r
         8x39T6551ot7umiRsyV1g7Va+3A+XLVWJm5PF5vbI2zD5qz/csuUNmFDM2v7l1U5jJg1
         Xr2T0e/FMrIw5LtWEJisGrUNoPvrwCQn4m5ve46BuuWu5BV/BBjlYBiQHR2vpDz4uwEM
         wjDg==
X-Forwarded-Encrypted: i=1; AJvYcCUhrUOcjGQg6OaCMJdCIdOQyr74wrpUs6sm2xCiH7Aml7o6HsJHAsFFYXQM6rNu8SBDytLnRhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu46EJHqbNa+fiykMwbrF0nq/gP0s4G7TysFNDUba8DsMvpZhz
	AL5l9u0dosLzGvhzRewZBifxaah/tAz/2t7IG7Ft9jthlkSBbr+Q
X-Gm-Gg: ASbGncvLg9RcO19ytzIkeu3Rn4SWArDPR8+hoHDABFQg6TkJdO96n1RgaCbipqE5f9o
	UeX1eOggPlu5e6Nyj0dsxBg5REQ8thVVo+fHJFWEHJ1zTuqnFgzawAGn+23qODiBqAszr6VCUGl
	sWKXlLRh/rNkPwX/edAE69MxlsXv9CYPHF1gB5TA4unezMvO3THABF0Kiga4ldFTzkC35jAwBwX
	RrHtYysY201oioEuPPn1OlC0I8eEIz81rBi+JAzGSohwFmxlDIRjNsdZkYHn39FMjcd4V4Quhf2
	uKGu9WEId4dHz9wuYxTvqpbo4SqD4l7J1TVKBmfuUAwxY4jbBq0QMpaAPCcSggTsALC6rvldP5d
	mOPOhhDsTgwmuxXhhgZ8lVVLF7wQ+/rpkdj299zBN5g==
X-Google-Smtp-Source: AGHT+IELJC5m7gUhex9waWAAaxot5t+lCBTJg5R6LFSTeHgiGTGX+fKEJoLlvpYH8nmU8PKU/UstTg==
X-Received: by 2002:a17:907:1591:b0:a9e:d7e3:cced with SMTP id a640c23a62f3a-aa509b8fce7mr343424766b.45.1732305843878;
        Fri, 22 Nov 2024 12:04:03 -0800 (PST)
Received: from ?IPV6:2a02:3100:a006:e900:3c67:b590:8a92:868e? (dynamic-2a02-3100-a006-e900-3c67-b590-8a92-868e.310.pool.telefonica.de. [2a02:3100:a006:e900:3c67:b590:8a92:868e])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa50b5b98ffsm134948466b.199.2024.11.22.12.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 12:04:02 -0800 (PST)
Message-ID: <f430fb95-362d-4436-8b33-0eebc15333a8@gmail.com>
Date: Fri, 22 Nov 2024 21:04:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: phy: fix phy_ethtool_set_eee() incorrectly
 enabling LPI
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <E1tESfx-004evI-NH@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <E1tESfx-004evI-NH@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.11.2024 13:22, Russell King (Oracle) wrote:
> ---
>  drivers/net/phy/phy-c45.c |  2 +-
>  drivers/net/phy/phy.c     | 32 ++++++++++++++++++--------------
>  include/linux/phy.h       |  1 +
>  3 files changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
> index 96d0b3a5a9d3..944ae98ad110 100644
> --- a/drivers/net/phy/phy-c45.c
> +++ b/drivers/net/phy/phy-c45.c
> @@ -1530,7 +1530,7 @@ int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
>  		return ret;
>  
>  	data->eee_enabled = is_enabled;
> -	data->eee_active = ret;
> +	data->eee_active = phydev->eee_active;
>  	linkmode_copy(data->supported, phydev->supported_eee);
>  
>  	return 0;
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 4f3e742907cb..e174107b96e2 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -990,14 +990,14 @@ static int phy_check_link_status(struct phy_device *phydev)
>  		phydev->state = PHY_RUNNING;
>  		err = genphy_c45_eee_is_active(phydev,
>  					       NULL, NULL, NULL);
> -		if (err <= 0)
> -			phydev->enable_tx_lpi = false;
> -		else
> -			phydev->enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled;
> +		phydev->eee_active = err > 0;
> +		phydev->enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled &&
> +					phydev->eee_active;
>  
>  		phy_link_up(phydev);
>  	} else if (!phydev->link && phydev->state != PHY_NOLINK) {
>  		phydev->state = PHY_NOLINK;
> +		phydev->eee_active = false;
>  		phydev->enable_tx_lpi = false;
>  		phy_link_down(phydev);
>  	}
> @@ -1685,16 +1685,20 @@ EXPORT_SYMBOL(phy_ethtool_get_eee);
>  static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
>  				      struct ethtool_keee *data)
>  {
> -	if (phydev->eee_cfg.tx_lpi_enabled != data->tx_lpi_enabled ||
> -	    phydev->eee_cfg.tx_lpi_timer != data->tx_lpi_timer) {
> -		eee_to_eeecfg(&phydev->eee_cfg, data);
> -		phydev->enable_tx_lpi = eeecfg_mac_can_tx_lpi(&phydev->eee_cfg);
> -		if (phydev->link) {
> -			phydev->link = false;
> -			phy_link_down(phydev);
> -			phydev->link = true;
> -			phy_link_up(phydev);
> -		}
> +	bool enable_tx_lpi = data->tx_lpi_enabled &&
> +			     phydev->eee_active;
> +
> +	eee_to_eeecfg(&phydev->eee_cfg, data);
> +
> +	if ((phydev->enable_tx_lpi != enable_tx_lpi ||
> +	     phydev->eee_cfg.tx_lpi_timer != data->tx_lpi_timer) &&
> +	    phydev->link) {
> +		phydev->enable_tx_lpi = false;
> +		phydev->link = false;
> +		phy_link_down(phydev);
> +		phydev->enable_tx_lpi = enable_tx_lpi;
> +		phydev->link = true;
> +		phy_link_up(phydev);

This part collides with a pending patch:
https://patchwork.kernel.org/project/netdevbpf/patch/a5efc274-ce58-49f3-ac8a-5384d9b41695@gmail.com/
I think you have to rebase and resubmit once the pending patch has been applied.

>  	}
>  }
>  
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 77c6d6451638..6a17cc05f876 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -723,6 +723,7 @@ struct phy_device {
>  	/* Energy efficient ethernet modes which should be prohibited */
>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(eee_broken_modes);
>  	bool enable_tx_lpi;
> +	bool eee_active;
>  	struct eee_config eee_cfg;
>  
>  	/* Host supported PHY interface types. Should be ignored if empty. */
> -- 2.30.2


