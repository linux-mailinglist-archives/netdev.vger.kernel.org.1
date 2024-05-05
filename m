Return-Path: <netdev+bounces-93544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F698BC413
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 23:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27841F20F5E
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 21:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83758136E16;
	Sun,  5 May 2024 21:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cw9zNT0q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7092D60A
	for <netdev@vger.kernel.org>; Sun,  5 May 2024 21:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714946033; cv=none; b=Vdf4qGe4Wxtp19637j/zZOMh069+XWlaAMXxDZP6iatS/H6/P27bLGaqBWtswGRtG3lyr+SJQI0fy3kq6J2mjB+8KXCelBOhk8EQ+5Hj2d2jJyXkainkw3OkzZS+y+Lv/+ADtPmqNv2RxfOqDmgbIHcKUcz7DdX6Pl47U38GrqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714946033; c=relaxed/simple;
	bh=l0EioHE7oAlSH3RrqJSRsv7ROcyIUn7ptm0DYJd/DUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7S/1Ib8xt4pNeFpNUDJnvDO4IvcLEYaGPOpK8DXEIFPnQvMTOsdR9UBAfL4atup1JCSVMrEohbfy/g3o4y5V9Bn3CP404IR1aOkXhPDWi39YhSrKVgjXuFj3Dw1uOz9My/tiDG5OV+Q0FYWDPVkWK5YajoEt+mD0TdqUcX0tAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cw9zNT0q; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-518931f8d23so1238345e87.3
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 14:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714946030; x=1715550830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CYCIhw1QBuel0uG+OWIloPGatsbLWT/hVoZRb96HjKA=;
        b=cw9zNT0q0BpzAdiRuk5YKINM0mSDk+m9fsWzQbXvDy4Qi3jCaE7Tben/vVnSeKib20
         Ve3Yh/w9MVqgQQHGMcUmd5IINKUOf4kocH9qH7CRlaF9Jueus5MREQqT5hGPCpIwRny4
         h1ioWLeuJyejM3MVKIeY/iIFFWJFYJxHzM1YxziYwyzE4OKUJRc2RsAkbUS8C9d6bBQ9
         amAzbPCa+QiPsU4IQuYudrBOYbU8IL7TCHBJqyU4bwBgZv5HmO75Rf2LTLAyqbaG4bnR
         QRTS1BYgDoTd2VPCajRU2d4cINHAzZ7VWUxaUYKG1C0z6+dobMoj6lavPVITLnrjAmZX
         /0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714946030; x=1715550830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYCIhw1QBuel0uG+OWIloPGatsbLWT/hVoZRb96HjKA=;
        b=CKAhbysif6LSWRYXO/y4tvsJGN9uZsn3bYm1EGE5XuCdaRhZhQZaUzAvQvOisxWhzi
         GyoN2dKJMt5To1J7vJ8f/Y3e6Tx8jaeSssu9yALUniVmCJHGliO57Aphcpj7Y9AT2TtV
         HbGgtYA6G0qxfkBwaOkamqom40+5kz/kZ0WqUP5L9BjSKOILkDJWsZku4kEXnPbX+bMj
         XRclTUkLohTP4Z6hHcHJgGRxpV1pEu4OCrRkga3opBwI4FA5XziPX/yb9clelyAreMrN
         zz1+u8iDFX/qjfB4BRgvu96vUZ+tDeFOHVvB0eNf4xDBBeA+OFQXEn2yfE+3hsLYxllv
         +8Jw==
X-Forwarded-Encrypted: i=1; AJvYcCW6GBMv3q2JbsDPWyMZ/0/tL/MeQixpIumZuc+4+gAj3/jhgAfKEoKM+pmLJqSvB10h+6o6/a4b2MMTgd/fx9mSG3hK5Bgt
X-Gm-Message-State: AOJu0YyzXuQeRDb1N9ZNo3ZLZvD/vJ1BRJP9gcCAipHjUQK27Z2ZIm5N
	ShdOVds+tpIQvANDkXlkqQg7HyftVBOpJ+tsKcXNUOsTsaCb3RNy
X-Google-Smtp-Source: AGHT+IEW1t2lIMVr2VK3wAC+uzcQknzi0abg05n1cFlCEjVI0MWECVAE4uHBmOxf7Efmi3SHN+QfFg==
X-Received: by 2002:ac2:43a7:0:b0:51c:348:3ba9 with SMTP id t7-20020ac243a7000000b0051c03483ba9mr5080299lfl.22.1714946029739;
        Sun, 05 May 2024 14:53:49 -0700 (PDT)
Received: from mobilestation ([95.79.182.53])
        by smtp.gmail.com with ESMTPSA id h3-20020a056512054300b0051d94297380sm1370455lfl.241.2024.05.05.14.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 14:53:49 -0700 (PDT)
Date: Mon, 6 May 2024 00:53:47 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 14/15] net: stmmac: dwmac-loongson: Move
 disable_force flag to _gnet_date
Message-ID: <djycwp72pttsu6tnczzhgzncq77ljg7ugb4mvhi2sgqcirielg@uknifyazm3dt>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <7235e4af89c169e79f0404a3dc953f1756bab196.1714046812.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7235e4af89c169e79f0404a3dc953f1756bab196.1714046812.git.siyanteng@loongson.cn>

On Thu, Apr 25, 2024 at 09:11:37PM +0800, Yanteng Si wrote:
> We've already introduced loongson_gnet_data(), so the
> STMMAC_FLAG_DISABLE_FORCE_1000 should be take away from
> loongson_dwmac_probe().
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-loongson.c    | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 68de90c44feb..dea02de030e6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -286,6 +286,12 @@ static int loongson_gnet_data(struct pci_dev *pdev,
>  	plat->mdio_bus_data->phy_mask = ~(u32)BIT(2);
>  	plat->fix_mac_speed = loongson_gnet_fix_speed;
>  

> +	/* GNET devices with dev revision 0x00 do not support manually
> +	 * setting the speed to 1000.
> +	 */
> +	if (pdev->revision == 0x00)
> +		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000;
> +

Just introduce the change above in the framework of the patch 
[PATCH net-next v12 13/15] net: stmmac: dwmac-loongson: Add Loongson GNET support
and ...

>  	return 0;
>  }
>  
> @@ -540,13 +546,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  		break;
>  	}
>  

> -	/* GNET devices with dev revision 0x00 do not support manually
> -	 * setting the speed to 1000.
> -	 */
> -	if (pdev->device == PCI_DEVICE_ID_LOONGSON_GNET &&
> -	    pdev->revision == 0x00)
> -		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000;
> -

... you won't to have this being undone. So this patch won't be even
needed to be introduced.

See my comment sent to
[PATCH net-next v12 12/15] net: stmmac: dwmac-loongson: Fixed failure to set network speed to 1000.

-Serge(y)

>  	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>  	if (ret)
>  		goto err_disable_device;
> -- 
> 2.31.4
> 

