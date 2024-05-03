Return-Path: <netdev+bounces-93280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D48B98BADF4
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 15:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6A61C20F72
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 13:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA998153BCB;
	Fri,  3 May 2024 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpDhu2At"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3328915358D
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714743844; cv=none; b=eD2kjbjcmWak27YM9MitFeUiyWVfsp527hsZ+A6Tzv2L/59V13ww/i6YZGPw0lPM1vlxCnnUhecEn4kvTzv3gVnN4wE2Ue2erQLFtohO+ITR/EZGMJmsY03qzsxxGEukNrYRHaGdIsDOtl+nsGbYATbwO41i1LeX0250H8E+6lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714743844; c=relaxed/simple;
	bh=/PO70+zYBQns0nMX2KpQcb3dK+f8ps+iAGqItinz3z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGSpq9zOSGoYjZLpjKMSavX9IwkT02knhBsAHgnzSIU21+kf91+MZ3zKGGvYxmLo2XWDiQQNtk9Z8LncBaayoWSbWrZ72Qo1FmY30Y3J3KrUtATdOH/ov6Y9Qi/Nt69CGfm0s9B/2fQTWQzQ7DoQftnR9JTA49IPVATlms6lJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpDhu2At; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51f74fa2a82so1079059e87.0
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 06:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714743841; x=1715348641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cdoofNTFCQTWbwZ1YOxaQiJWmkmzp9JJYJt8fvb4y74=;
        b=HpDhu2AtmzAZlqglcPpMBKvSXBIg8T/px/uITuA4p8M0XYecbFHHRLxdhoICxXpyvd
         tl7hCUkwd0HEu/Zj7q/ZAnl39CVLWmV7sB0hC6NkmHRDmeSzbcaTBrukEBTaXXon6cts
         TU4ogMrhVtOupCB+RWPCIO4qMXk8X8ITx7TTU0QV8bH/7/ekf1VrHARbuUXghNw3p0em
         D+Q+HjGq/InCrQrzx/YaaYoy20eUNjWrGuzPSyVRdYPdNwahxESPWVG9TndvaX0uYPGJ
         ID6Xr1JoPR0I55wYq/5McIQTdHPS/F2um/1pxu/zUCufCPeTsv3UeK24TnE4VXRoTxCF
         b7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714743841; x=1715348641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdoofNTFCQTWbwZ1YOxaQiJWmkmzp9JJYJt8fvb4y74=;
        b=CUuep7fazZmUvPS/dPaowpdzSdRcno5FMBknY6kHq5yX/RDi/m7RdUF5GDJUi+0nl+
         XjwpZvyBeWIvD7NJHgkuWGdYbMyrCZoJgSMTa333C5CBBUYHo1K1helPcIxSrfMM4GbM
         FDLW6Goiouc0ITx2EgXD+Gf1qHezxJA1cGpkEInMS7p/fQ47RZJZxQ8tR1fsPMn7/aV5
         Z2dJFJ57VjImnqdkw8ytVBkFhK7RLHW7yAGgUOnFb9TYOu+P8iq+sr12AH4q1fOkcfhp
         hjavbUJSzV0NYBw4TKH4PVIXHwcSWnxITb6nr195Cnf/FlvGqEBReuU52iuw/fCxaBQq
         YMxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFau0SJM8hKyMfSwkkgslI7O4ksj77/bDO0nTsYx8VKDK4xMWRQhKSD+CcZJhgToDnz8H2GUyUeU737fdekgg5UmvSSCRr
X-Gm-Message-State: AOJu0YzFWJwAbhMZJzAhw1FWZ3h/z6iaHvo2BmuxAI6+SiKiCX8fey91
	KrXrpSheRWT9eHLW4fpVFsz4bWezixkywYXfGqnS6Xgip0dY5irl
X-Google-Smtp-Source: AGHT+IGnNAw0f780I76ZxCeqnHwDer12gyK4ciZWfbbfmAhJZYRNDBopz18se8NLo4XWTvNn66AD9g==
X-Received: by 2002:a19:ac48:0:b0:51e:e754:27dd with SMTP id r8-20020a19ac48000000b0051ee75427ddmr2178030lfc.41.1714743841073;
        Fri, 03 May 2024 06:44:01 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id n6-20020ac242c6000000b0051b402a3809sm540435lfl.307.2024.05.03.06.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 06:44:00 -0700 (PDT)
Date: Fri, 3 May 2024 16:43:57 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 05/15] net: stmmac: dwmac-loongson: Use
 PCI_DEVICE_DATA() macro for device identification
Message-ID: <xh34h5zd3f4hjjpafsg2i6uzeigxjb7g6zwbybgvkgmydw6ouy@ueeozv6lottf>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <46cd3872bef7854dbdb3cc41161a65147f4a7e2c.1714046812.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46cd3872bef7854dbdb3cc41161a65147f4a7e2c.1714046812.git.siyanteng@loongson.cn>

On Thu, Apr 25, 2024 at 09:04:36PM +0800, Yanteng Si wrote:
> Just use PCI_DEVICE_DATA() macro for device identification,
> No changes to function functionality.

Some more verbose commit log:

"For the readability sake convert the hard-coded Loongson GMAC PCI ID to
the respective macro and use the PCI_DEVICE_DATA() macro-function to
create the pci_device_id array entry. The later change will be
specifically useful in order to assign the device-specific data for the
currently supported device and for about to be added Loongson GNET
controller."

Other than that the change looks good:

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 19906ea67636..4e0838db4259 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -9,6 +9,8 @@
>  #include <linux/of_irq.h>
>  #include "stmmac.h"
>  
> +#define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
> +
>  static int loongson_default_data(struct plat_stmmacenet_data *plat)
>  {
>  	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
> @@ -210,7 +212,7 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
>  			 loongson_dwmac_resume);
>  
>  static const struct pci_device_id loongson_dwmac_id_table[] = {
> -	{ PCI_VDEVICE(LOONGSON, 0x7a03) },
> +	{ PCI_DEVICE_DATA(LOONGSON, GMAC, NULL) },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
> -- 
> 2.31.4
> 

