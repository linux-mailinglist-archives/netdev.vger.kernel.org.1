Return-Path: <netdev+bounces-107976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 552A891D5B3
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 03:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489D51F2128A
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 01:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFB028F4;
	Mon,  1 Jul 2024 01:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSGHgfsu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCA420ED
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 01:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719796633; cv=none; b=cMCYqpPBVzHHr5FGXaSVrgXmSTEOhVZgzGG012E0w5CL8/n9jIDRGtnywBVBfTbd1Cu86LSKEFWcjyNQhaYrc4Y0CqtrPuNaahLffFr94Ubwa3Ol4DT/s/suBoB0siU40wAE5QEzrUcQdu44up1n+FXTUsxAnbKyWQ1hFIbBaSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719796633; c=relaxed/simple;
	bh=UyrndfkZJV+yjMqMATxLmGvB6vOe0g8clWQn4rBHavo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWvFnU0I4uktFrmvdNq3VlDqPXir98uRFnUwPX+ZH8dNRLaEvbQ4QUAyZFBzTqGk94ZyYy9OGx3yORSwDCLkmyY4RWp+myErc6wFbdMGDsx/FD/RLCeRFoGlW/33aDmSCYSK8vpVf8Mx+MTLB45fpusiEnpSSbRGq6WZXRq36Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSGHgfsu; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52cdd03d6aaso2817860e87.0
        for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 18:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719796629; x=1720401429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VV8tEZkLDJvsQlfX8e6DtpflSHdQ3c/YWD+CmbcU8MM=;
        b=XSGHgfsuReDa5fIARitJk5K9W7thc+Z9jH03yGamuxndGfNAetycQwq1pY/3nHgxKv
         lGYF5kTDpRVNwIR0HlygLa15AQlso+lRG/P2StzGhIhZPiVUe1rs26nw/zPJkW9YlpjW
         nXEh3XS+lIeu0GyROTzeL5tbqdzKloJxwvLf1WsqmKyG8xskLsWDBooWpB3zUxuZoB0c
         9LvcKj0PohCTlK3WWixDlq708g6dU7mUlXRG05CeMTsiGLTylmp9x0LqoHt7M8NI8+vV
         XS+xbdy9DtfAVfoGFi90UKnZ+Tu3qZZWrXeCe0sZrxVIH0ERbLk4teSAfCIugPyOCBUV
         7i/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719796629; x=1720401429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VV8tEZkLDJvsQlfX8e6DtpflSHdQ3c/YWD+CmbcU8MM=;
        b=CR5rf66hoQ+riMZLRfoyDljmaYIFO8mBfy47+l0cTWNdLrJ2Xu6omsw6XM53SuwkEt
         Uf/ZBjev40BTXHlapFdARdGOJx6/bLOMSydBA/jLEnVfgVpc71rDh2B0wqI6wgNxWD8S
         g0L6BA3dfAXHepVaxDGiOymzg1QHDLQzAKFGicU4rBeGvEYDKvXXdZ7870CGEg/Os3U2
         +JCpGjkBBri2O3jVRlCTlT0hFkhvwPf28pJCMnuY+emk/sAyikJWd0C4B9fL599+rN05
         P+wABHC4wVLnRHpTmN+dkmyhLIPdsW3168APkTZOx8bWOysm66v5Msw8ArZ3njRD1opS
         4Y9A==
X-Forwarded-Encrypted: i=1; AJvYcCW8wUDwGkr0TOdmWkewcJLj37pyTlNjbC1mI5sbtGn3pC83wH3Yj9imcZ/ArEWAWoZa9kReBdY7krCB323RbWZGEcJHCyPH
X-Gm-Message-State: AOJu0Yzr/RkHMkfdc+CMjSI5U0TeEWY/YtqFr3fRGnxQTgoK891M1iTk
	tqnTXUQ0Th39NmU9pSp67ntOKVnHwaDmOQeBn9zDS13ZW5dZvouY
X-Google-Smtp-Source: AGHT+IGgxLmaf+JIA+oMoQQWIB1E38kKK/OZUQH04/rUc2Vbe/5uysMNyxMgBGKdLuycjvOY73iZ0w==
X-Received: by 2002:a05:6512:3191:b0:52c:dd21:8d09 with SMTP id 2adb3069b0e04-52e82742b70mr2422433e87.63.1719796629207;
        Sun, 30 Jun 2024 18:17:09 -0700 (PDT)
Received: from mobilestation ([176.213.1.81])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab3b48bsm1161493e87.295.2024.06.30.18.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 18:17:08 -0700 (PDT)
Date: Mon, 1 Jul 2024 04:17:06 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v13 13/15] net: stmmac: dwmac-loongson: Drop
 pci_enable/disable_msi temporarily
Message-ID: <zniayk52akd6dfbfoga7f6m6ubdmteijkr2luubccmqiflhuya@x2cfleoodqlh>
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <2c5e376641ac8e791245815aa9e81fbc163dfb5a.1716973237.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c5e376641ac8e791245815aa9e81fbc163dfb5a.1716973237.git.siyanteng@loongson.cn>

> [PATCH net-next v13 13/15] net: stmmac: dwmac-loongson: Drop pci_enable/disable_msi temporarily

You don't drop the methods call "temporarily" but forever. So fix
the subject like this please:
[PATCH net-next v13 13/15] net: stmmac: dwmac-loongson: Drop pci_enable_msi/disable_msi methods call

I understand that you meant that the MSI IRQs support will be
added later in framework of another commit and for the multi-channel
device case. But mentioning that in a way you did makes the commit log
more confusing than better explaining the change.

On Wed, May 29, 2024 at 06:21:08PM +0800, Yanteng Si wrote:
> The LS2K2000 patch added later will alloc vectors, so let's
> remove pci_enable/disable_msi temporarily to prepare for later
> calls to pci_alloc_irq_vectors/pci_free_irq_vectors. This does
> not affect the work of gmac devices, as they actually use intx.

As I mentioned in v12 AFAICS the MSI IRQs haven't been utilized on the
Loongseon GMAC devices so far since the IRQ numbers have been retrieved
directly from device DT-node. That's what you should have mentioned in
the log. Like this:
"The Loongson GMAC driver currently doesn't utilize the MSI IRQs, but
retrieves the IRQs specified in the device DT-node. Let's drop the
direct pci_enable_msi()/pci_disable_msi() calls then as redundant."

If what I said was correct and MSIs enable wasn't required for the
platform IRQs to work, then please use the log and move this patch to
being submitted between
[PATCH net-next v13 04/15] net: stmmac: dwmac-loongson: Drop duplicated hash-based filter size init
and
[PATCH net-next v13 05/15] net: stmmac: dwmac-loongson: Use PCI_DEVICE_DATA() macro for device identification

so the redundant pci_enable_msi()/pci_disable_msi() code wouldn't be
getting on a way of the subsequent preparation changes.

I'll get back to reviewing the rest of the patches tomorrow. That new
LS2K2000 + LS GMAC info made things much harder to comprehend than I
thought. But I think I finally managed to come up with what should be
done with the commit logs and the changes, to make it being taken into
account.

-Serge(y)

> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index fdd25ff33d02..45dcc35b7955 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -167,7 +167,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  		res.irq = pdev->irq;
>  	}
>  
> -	pci_enable_msi(pdev);
>  	memset(&res, 0, sizeof(res));
>  	res.addr = pcim_iomap_table(pdev)[0];
>  
> @@ -176,12 +175,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  
>  	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>  	if (ret)
> -		goto err_disable_msi;
> +		goto err_disable_device;
>  
>  	return ret;
>  
> -err_disable_msi:
> -	pci_disable_msi(pdev);
>  err_disable_device:
>  	pci_disable_device(pdev);
>  err_put_node:
> @@ -205,7 +202,6 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
>  		break;
>  	}
>  
> -	pci_disable_msi(pdev);
>  	pci_disable_device(pdev);
>  }
>  
> -- 
> 2.31.4
> 

