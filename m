Return-Path: <netdev+bounces-108370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C25B9239A9
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284C428692E
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 09:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEADF14C5BF;
	Tue,  2 Jul 2024 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWSuon+j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7174963F
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719911932; cv=none; b=gyXMdQY8mVdlnFjRpNsN7qGR2Jt6wWGVCYDZpysNLFh6o/m8El2SB7CN5utKDC2/odcM927mzWAGhq5xy43GqzqUuMlXOgSCT9vasFlRd+HuYWZZz21XyfCzpevQ+RGfsOMLvCj0UowehDkiRw3igUQAis5c094BlhFLjT6qI0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719911932; c=relaxed/simple;
	bh=QAOD82h6ooiqJ0JVKg+R4mQhBIzcD5a4lUX4RWA8pWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoNxl/IWxdVlp+srJa1uM3xXmS8/FG58EtHMeNjUJJ57MxA+iNzFhYLv86FZbJYLeh6FUNeQWB9jC11+l6TFKZUaA1LV9UJqcOIsU2GYzW8CtuMnEfxzEL2Lqb/HtsqBim6TcF0JfSlkOuQUkGme2ciiDz5KspnAahTwzs3wPHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWSuon+j; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52cecba8d11so4772045e87.1
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 02:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719911929; x=1720516729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ze1mCA3IMhS4v96v2WxBvrlDZHv3v3wHviX7XM44X2A=;
        b=PWSuon+jmMIGiXPGcHooYuUOXwag6tZtfVEVzksk3tATj3576ooYbDg8mGxlAWcCTe
         0LvHOr5c86E4xrDq6HK0aAkZ4Uc7NJ2UtfRhcPYJ65AM3MjeUEbiD6HVOLnnL3dCH/h/
         yHoiSAiz5kXcAaRycSIaP6ZaSK0G7HckGiCuHiR2gsgFVqh0ZXO/ACVY/N0B0jPBJpsD
         GasbYoZ9zFEXaRHnhp/ASa4FoHkxofhBRWUjbyJQNhbCV6QIvdJwX5vxRa+Tp8iL2PRR
         4KexuXntLaU4ES27VoeaYywvsfzc01JFpwkfsisbJGX1KvmXTT2CxR3+KKI067O5Iw5+
         6cXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719911929; x=1720516729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ze1mCA3IMhS4v96v2WxBvrlDZHv3v3wHviX7XM44X2A=;
        b=QDFxyx811SfKRmU0R2xmWirKI5juVU2amSXiCh2N5O/y8tW5hugbh7eKolPO15eSp8
         U1Jk1+8LOeqdJT8jwID6yQt0tdWLzQ2g9IsevvxrtsC0gj8dhYg3xEqP4y+e54RJ1Ik3
         W18VCUgKNqQxllIfumCh6WAMKcldzpFgrMwEIbJWn6exhZgHxoOx0xuIuXVyARRhX5Fz
         4FAa5H2FhR0Ix+fnKoM/Co/StVASMlz3l8hOfWxNBUolCd/H2AlE+KEc1nS6RIa+znPp
         yaya/zwr84BIJvGpd9ytw0Sdu5AuQ13noDumiX69AGGh2gmElXYun4DkZebM4IH+Z93Z
         VC2A==
X-Forwarded-Encrypted: i=1; AJvYcCXOZUZW5QqnM5jpebxaTlOie/EEMC4Nr9oQ2lthEfYeT7hPbAJFlmvkturNwI83wHCpMS8ksGMZYszpTjTa8r1TaNf/jlGg
X-Gm-Message-State: AOJu0YzJsjVpLSu5gIXH/hcVy3HfDgRY9OjZo0Ur++EMoQaAdQcdfq56
	Fq8l/c3skYMis4x5hmnecAFnhVAgkJlv/t0OZ+I41DwbXAc2FAA8
X-Google-Smtp-Source: AGHT+IERWc5oInRvdvoDBQPRy757J6hg8k0JMwUyAmWNi3KQVzHIYKfmstNpvdfRdD76DHWA+5DMKw==
X-Received: by 2002:a05:6512:10d6:b0:52c:dc57:868b with SMTP id 2adb3069b0e04-52e8264b5bdmr5992643e87.13.1719911928776;
        Tue, 02 Jul 2024 02:18:48 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab27864sm1733389e87.136.2024.07.02.02.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 02:18:48 -0700 (PDT)
Date: Tue, 2 Jul 2024 12:18:45 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v13 09/15] net: stmmac: dwmac-loongson:
 Introduce PCI device info data
Message-ID: <3k5aa676afjee64acvwa4dd4vlhzusjxvktwfzrvqzh7xahd5a@am6cxil2i5kw>
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <817880fd50d623ac84f6a01fc7eb3748864386a8.1716973237.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <817880fd50d623ac84f6a01fc7eb3748864386a8.1716973237.git.siyanteng@loongson.cn>

On Wed, May 29, 2024 at 06:19:48PM +0800, Yanteng Si wrote:
> Just introduce PCI device info data to prepare for later
> ACPI-base support. Loongson machines may use UEFI (implies
> ACPI) or PMON/UBOOT (implies FDT) as the BIOS.
> 
> The BIOS type has no relationship with device types, which
> means: machines can be either ACPI-based or FDT-based.

AFAICS the commit log is misleading because the DT-less (ACPI-based)
setups is being added in the next commit and it's implemented by using
the if-else statement with no setup() callback infrastructure
utilized.

But this change is still needed for adding the Loongson GNET support
later in the series. The setup() callback will be pre-initialized with
the network controller specific method based on the PCIe Device ID. So
to speak, please alter the commit log with the correct justification.
Like this:

"The Loongson GNET device support is about to be added in one of the
next commits. As another preparation for that introduce the PCI device
info data with a setup() callback performing the device-specific
platform data initializations. Currently it is utilized for the
already supported Loongson GMAC device only."

-Serge(y)

> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c    | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 0289956e274b..fec2aa0607d4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -11,6 +11,10 @@
>  
>  #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
>  
> +struct stmmac_pci_info {
> +	int (*setup)(struct plat_stmmacenet_data *plat);
> +};
> +
>  static void loongson_default_data(struct plat_stmmacenet_data *plat)
>  {
>  	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
> @@ -54,9 +58,14 @@ static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
>  	return 0;
>  }
>  
> +static struct stmmac_pci_info loongson_gmac_pci_info = {
> +	.setup = loongson_gmac_data,
> +};
> +
>  static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct plat_stmmacenet_data *plat;
> +	struct stmmac_pci_info *info;
>  	struct stmmac_resources res;
>  	struct device_node *np;
>  	int ret, i, phy_mode;
> @@ -107,6 +116,11 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  		break;
>  	}
>  
> +	info = (struct stmmac_pci_info *)id->driver_data;
> +	ret = info->setup(plat);
> +	if (ret)
> +		goto err_disable_device;
> +
>  	plat->bus_id = of_alias_get_id(np, "ethernet");
>  	if (plat->bus_id < 0)
>  		plat->bus_id = pci_dev_id(pdev);
> @@ -122,7 +136,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  
>  	pci_set_master(pdev);
>  
> -	loongson_gmac_data(plat);
>  	pci_enable_msi(pdev);
>  	memset(&res, 0, sizeof(res));
>  	res.addr = pcim_iomap_table(pdev)[0];
> @@ -224,7 +237,7 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
>  			 loongson_dwmac_resume);
>  
>  static const struct pci_device_id loongson_dwmac_id_table[] = {
> -	{ PCI_DEVICE_DATA(LOONGSON, GMAC, NULL) },
> +	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
> -- 
> 2.31.4
> 

