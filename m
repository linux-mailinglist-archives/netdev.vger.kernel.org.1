Return-Path: <netdev+bounces-112069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 072A6934CBC
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12D51F2211F
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 11:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00432139CEF;
	Thu, 18 Jul 2024 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zrb7lt6g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA8313A258
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303059; cv=none; b=cr7TXXxHB3valIFt+oBVMLE8y6um/ROI5aNuWDe0DnKYYrtX1q3hdJE4SgFE3oTqBmuR7F1GmVf7WQlSXpyZ54IT+urA74yM4j9/Fz19DLRPWsitAGg8kgjOAgqRRy4K8CPwyCtngYLHqt0QaNXUJBxn14MALOcDmoVm8co3UX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303059; c=relaxed/simple;
	bh=C6oSFQciKjrIpg5YyTMPeO9o9RJI+KjeuZalz3nWogw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlfcAt929q/nlen3pibIJwFu0qdwsJkuDQZhjkg3W0gYyZofokrVo21qscF1BbPSXJD0F8fI3NuqmYwf0gN04uaGn1ixoHW1lB5oe/sk9GU38Ugh4bIffJnpanohFbxoD4tQgwuCnfCZG6oil4WZoKJEazlqQhrhxAKX67WkriE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zrb7lt6g; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-795d2aa4ba4so445426a12.3
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 04:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721303058; x=1721907858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JzoIT3/YlCEDVJd2vMQE2OR2k3/QT8sX2bL4JBa26ec=;
        b=Zrb7lt6gPVvPDjFPmU1LryZVuvtkhYGLNskNdFjAWdh6/scg7G9w5Q4mgQ812WfgEs
         zuzj+p8f+u00HiRAGXTUqwdFoc/ldQ2WBPV4LZfP/1AuN9QQ8WOu9pNaEoabEqLuFtM+
         RGED/Z5sQLoTDO7OhiR9+UyagdexPytveqkrW07pUicc9pb4K3noRSQxnEMAIQQBllf2
         NjNKe3wXqubO9EVj+COP0WOZ5/tRhu3z11NCU5yIBfJpaxHQKzacKgXyrRA3J1p7Af9Z
         +huONMSXekEUyDAwr3c+d0ZlMFn6T5OmEPpT11tFKgBGESCG2xypOZplY1gJ6xpV8yuU
         z3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721303058; x=1721907858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzoIT3/YlCEDVJd2vMQE2OR2k3/QT8sX2bL4JBa26ec=;
        b=AoMlaWTwU/ygHMXVssgDnGwKCg7nREeK/nSoWWEW5+wlxByyw+Mtfcsfc7DNx0n1Li
         soyivwGB8TQpOD7vXBuQZ1VfHaApY/WKaO2AhEzs4gwueV9yY55QK2CZMXsQIM7IbTCo
         vSAfJzVfb4HdJIRGynsUHtKqdjGbMZPdkufbujDeNck7SVT5/HnhcQ5+eza5+hVjJRAF
         7/8JVq++noWwndEWlXLfAZhro1iT9TwtgoYEKuO3HvwQ4HMzPT73lgx7V5sysoI9Uod2
         ylRY/ZcwA0yjN/eghOqIo8s+y4t0mbSiN0v8xzvqVUA+1CXctcblyCBlv6FBWtTlvFkq
         zNVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1oCoqu+vmam3Hey5TS0XOAUk+v45RBGNKxzDv2XGoXUATbwB9ckmNlVrdRYBXtuvW2cpaRtEb1mHJKoS9ZHhhkduj8QsX
X-Gm-Message-State: AOJu0Yx7ghZvNVZ/khk5Qg0OyHUNCpOclMlyO4nZOCHBzF/+5Dw3JfsF
	OlVJt+tspQgNeYbt3hnmR1dQJlnKB76jflZFrXiGzmuA16Li7I1V
X-Google-Smtp-Source: AGHT+IHi4gshdxd6MG32fUdicEsAZv2VbNQthkdkgNNtROSAW7k0QVud7NhPkkAA+PseXcTCGihrUw==
X-Received: by 2002:a05:6a20:1582:b0:1bd:2562:6a06 with SMTP id adf61e73a8af0-1c3fdcc6a85mr4929145637.32.1721303057815;
        Thu, 18 Jul 2024 04:44:17 -0700 (PDT)
Received: from mobilestation ([176.15.242.109])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ecc947fsm9859906b3a.195.2024.07.18.04.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 04:44:17 -0700 (PDT)
Date: Thu, 18 Jul 2024 14:44:09 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v14 09/14] net: stmmac: dwmac-loongson: Add
 phy_interface for Loongson GMAC
Message-ID: <i7ebf34gpwxuurhxdxeb76o7jcgiv4psuakrmb4zayp3v6xz7t@sg5mjlooub6u>
References: <cover.1720512634.git.siyanteng@loongson.cn>
 <101fcae2d48bda09ea9d49a1faa7a0c5c4e02873.1720512634.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <101fcae2d48bda09ea9d49a1faa7a0c5c4e02873.1720512634.git.siyanteng@loongson.cn>

On Tue, Jul 09, 2024 at 05:37:02PM +0800, Yanteng Si wrote:
> PHY-interface of the Loongson GMAC device is RGMII with no internal
> delays added to the data lines signal. So to comply with that let's
> pre-initialize the platform-data field with the respective enum
> constant.
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 327275b28dc2..7d3f284b9176 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -52,6 +52,8 @@ static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
>  	plat->tx_queues_to_use = 1;
>  	plat->rx_queues_to_use = 1;
>  
> +	plat->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
> +
>  	return 0;
>  }
>  
> -- 
> 2.31.4
> 

