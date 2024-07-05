Return-Path: <netdev+bounces-109454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2030C928851
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5CECB25BAB
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 11:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEADC14A096;
	Fri,  5 Jul 2024 11:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f23+dVZX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E6A149C52
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720180425; cv=none; b=KAkoYZr16pDPsXQe4A6dhh3DI0JbQwparLAJk5Ymjhr67y5JObhEZRdl3IPMoQ13eRDrtlM53dqIPh9Yl6G1wiWq6odkI94JD5syRybbCcCw/JVE7RG2p15hoiVGoFb6gAiBvsid88V6ohxZnQfZo4dqUjusnLMMWyC8L92LnBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720180425; c=relaxed/simple;
	bh=LCWBulzYyy3vE/3iXlk2lQ91iIsjUqrdsKQEIPY2C38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsv+pDNYzXUv2JPjvTYZYz9T7CzMl3r9yJN7riRVANmDjicySy8dCY6ujCq4szBMBX0YMs8GHFEIxFtikYtunNj+TSlPYnegHSCQF+OuiHGuVGrM7dx3dmzaRcjukK8NtLo1rsCmZVJOiMGzUW2XdkCoYIFZnXNjPv+azyJnUsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f23+dVZX; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52ea0f18500so1455467e87.3
        for <netdev@vger.kernel.org>; Fri, 05 Jul 2024 04:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720180422; x=1720785222; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7wtyBA9Hv+4jkQr/27GbfOi4Rr6dt1z1yDo8fxeCJQY=;
        b=f23+dVZXheS3avTJBmP/0O9dPt2S1bcCsV5Ac+TS6ZOiFsHHhXynAHm0uP9YKJ+INs
         u8+eDkoY4HF2Bd+5pNYovMBLh0e+5LguBReCz9aSMKyRapKXOPZ66Ps/QauNZLcx4gJq
         /Xz8mu2ToOUPPhMaUi3wRa9fxUF3EDgW8UfF7eAtwKq8gR84X80SvLdJZnp4bLRRwVzp
         bVCA41VIyLZ09DomjFjF1ydfcVq/6WcDEA32v8ZENzNz8OAGATk1rCMSehmIuDX6nDiY
         NzGZOcWmK6+gnbUrqPYWx0vpRLD21T5gpi9jUONFzQn0BxWy5KNqF3MrDPNidbuCgT5m
         jVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720180422; x=1720785222;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wtyBA9Hv+4jkQr/27GbfOi4Rr6dt1z1yDo8fxeCJQY=;
        b=jS2HYZActQQ+TGTn2LIZr8N9xygYdgjtQSsYf88fqQwu1K8C4br0DBxJOaJ1Hp0J8h
         S+Kw+sMV6v3f+NXhQsJJ5aLmweJ/oPjqHRngihhbY04YaWMAsHqMTxihgQJAM278eVzA
         8al0ahO9q2+9eMNFH+Yzywfz8YSVXdeGE+wDJ70gNQShc2nb1u0DBCNzhlP88Rx7k+Sr
         H5X7hz9sZOSvTYg4LSF9gfkFM9JRZ20sSRfLDzVBGjvoIEJdyYNw3QWL7Q+6QAKqNUjK
         sQZYqYWvLcUBRQ5LEfcroNDl+TSMq33IPgH+K/kYr3Hhy87iBT2ziBngoGNuKiV18bh7
         6AQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUibQMy1/GYk7OxGpgB6vflGSWJBWDYFAwLt/rylLkXBkg8nsr1ZLvD6BmJlL19Zb8MdojMoAOUeKcoKbssU5I7IQRHwMuN
X-Gm-Message-State: AOJu0YyATLR27PQm9N4fWWX87BeDkkr/Wke+Lfxn22vKxv0rwyO7egvg
	/oTYUZPAEPR9Tb5qAvC8rzte5aUW6iP73jK9laX0a27ldX7Ez3jx82Axlg==
X-Google-Smtp-Source: AGHT+IGnMl4ont+tiQ9Mt7qysXO3sKu5I62tPeXSyrXT2pBqFsXC57dVP498crQUTmPiMCZardSCLw==
X-Received: by 2002:a05:6512:328f:b0:52d:b182:9664 with SMTP id 2adb3069b0e04-52ea072449bmr2481280e87.69.1720180421383;
        Fri, 05 Jul 2024 04:53:41 -0700 (PDT)
Received: from mobilestation ([81.9.126.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab101c5sm2778432e87.79.2024.07.05.04.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 04:53:40 -0700 (PDT)
Date: Fri, 5 Jul 2024 14:53:38 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v13 06/15] net: stmmac: dwmac-loongson: Detach
 GMAC-specific platform data init
Message-ID: <3pmtzvpk5mu75forbcro7maegum2dehzkqajwbxyyjhauakapr@j7sovtlzc6c6>
References: <io5eoyp7eq656fzrrd5htq3d7rc22tm7b5zpi6ynaoawhdb7sp@b5ydxzhtqg6x>
 <475878c7-f386-4dd3-acb8-9f5a5f1b9102@loongson.cn>
 <7creyrbprodoh2p2wvdx52mijqyu53ypf3dzjgx3tuawpoz4xm@cfls65sqlwq7>
 <d9e684c5-52b3-4da3-8119-d2e3b7422db6@loongson.cn>
 <vss2wuq5ivfnpdfgkjsp23yaed5ve2c73loeybddhbwdx2ynt2@yfk2nmj5lmod>
 <648058f6-7e0f-4e6e-9e27-cecf48ef1e2c@loongson.cn>
 <y7uzja4j5jscllaq52fdlcibww7pp5yds4juvdtgob275eek5c@hlqljyd7nlor>
 <d8a15267-8dff-46d9-adb3-dffb5216d539@loongson.cn>
 <qj4ogerklgciopzhqrge27dngmoi7ijui274zlbuz6qozubi7n@itih73kfumhn>
 <c26f0926-7a2e-4634-8004-52a5929cd80a@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c26f0926-7a2e-4634-8004-52a5929cd80a@loongson.cn>

On Fri, Jul 05, 2024 at 07:29:23PM +0800, Yanteng Si wrote:
> 
> 在 2024/7/5 18:59, Serge Semin 写道:
> > On Fri, Jul 05, 2024 at 06:45:50PM +0800, Yanteng Si wrote:
> > > 在 2024/7/5 18:16, Serge Semin 写道:
> > > > > > Seeing the discussion has started anyway, could you please find out
> > > > > > whether the multi-channel controller will still work if the MSI IRQs
> > > > > > allocation failed? Will the multi-channel-ness still work in that
> > > > > > case?
> > > > > Based on my test results:
> > > > > 
> > > > > In this case, multi-channel controller don't work. If the MSI IRQs
> > > > > allocation
> > > > > 
> > > > > failed, NIC will work in single channel.
> > > > What does "NIC will work in single channel" mean? Do the driver
> > > > (network traffic flow with a normal performance) still work even with
> > > > the plat->tx_queues_to_use and plat->rx_queues_to_use fields set to
> > > > eight? If it's then the multi-channel-ness still seems to be working
> > > > but the IRQs are delivered via the common MAC IRQ. If you get to
> > > > experience the data loss, or poor performance, or no traffic flowing
> > > > at all, then indeed the non-zero channels IRQs aren't delivered.
> > > > 
> > > > So the main question how did you find out that the controller work in
> > > > single channel?
> > > sorry, I meant that if the MSI allocation failed, it will fallback to INTx,
> > > in which case
> > > 
> > > only the single channel works.  if the MSI allocation failed, the
> > > multi-channel-ness
> > > 
> > > don't work.
> > Could you please clarify what are the symptoms by which you figured
> > out that the "multi-channel-ness" didn't work?
> > 
> > Suppose you have an LS2K2000 SoC-based device, the
> > plat->tx_queues_to_use and plat->rx_queues_to_use to eight and the
> > loongson_dwmac_msi_config() function call is omitted. What is
> > happening with the activated network interface and with the traffic
> > flow then?
> 
> Ok, here are the results of my test in LS2K2000:
> 
> 
> v14 based.
> 
> $: git diff
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 25ddd99ae112..f05b600a19cf 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -576,11 +576,11 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
> const struct pci_device_id
>         if (ret)
>                 goto err_disable_device;
> 
> -       if (ld->loongson_id == DWMAC_CORE_LOONGSON_MULTI_CH) {
> -               ret = loongson_dwmac_msi_config(pdev, plat, &res);
> -               if (ret)
> -                       goto err_disable_device;
> -       }
> +       // if (ld->loongson_id == DWMAC_CORE_LOONGSON_MULTI_CH) {
> +               // ret = loongson_dwmac_msi_config(pdev, plat, &res);
> +               // if (ret)
> +                       // goto err_disable_device;
> +       // }

Ok. This makes the common MAC IRQ to be used for all controller
events. Let's see what was in your boot-test further.

> 
>         ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>         if (ret)
> 
> 
> boot on LS2K2000.
> 
> dmesg:
> 
> ...
> [    3.711438] dwmac-loongson-pci 0000:00:03.0: User ID: 0xd1, Synopsys ID:
> 0x10
> [    3.718543] dwmac-loongson-pci 0000:00:03.0: DMA HW capability register
> supported
> [    3.725993] dwmac-loongson-pci 0000:00:03.0: RX Checksum Offload Engine
> supported
> [    3.733439] dwmac-loongson-pci 0000:00:03.0: COE Type 2
> [    3.738635] dwmac-loongson-pci 0000:00:03.0: TX Checksum insertion
> supported
> [    3.745641] dwmac-loongson-pci 0000:00:03.0: Wake-Up On Lan supported
> [    3.752045] dwmac-loongson-pci 0000:00:03.0: Enhanced/Alternate
> descriptors
> [    3.758968] dwmac-loongson-pci 0000:00:03.0: Enabled extended descriptors
> [    3.765715] dwmac-loongson-pci 0000:00:03.0: Ring mode enabled
> [    3.771517] dwmac-loongson-pci 0000:00:03.0: Enable RX Mitigation via HW
> Watchdog Timer
> [    3.779480] dwmac-loongson-pci 0000:00:03.0: device MAC address
> aa:ee:21:fb:67:ac
> [    3.789812] mdio_bus stmmac-18:02: attached PHY driver [unbound]
> (mii_bus:phy_addr=stmmac-18:02, irq=POLL)
> [    3.800170] dwmac-loongson-pci 0000:00:03.1: User ID: 0xd1, Synopsys ID:
> 0x10
> [    3.807296] dwmac-loongson-pci 0000:00:03.1: DMA HW capability register
> supported
> [    3.814741] dwmac-loongson-pci 0000:00:03.1: RX Checksum Offload Engine
> supported
> [    3.822191] dwmac-loongson-pci 0000:00:03.1: COE Type 2
> [    3.827392] dwmac-loongson-pci 0000:00:03.1: TX Checksum insertion
> supported
> [    3.834404] dwmac-loongson-pci 0000:00:03.1: Wake-Up On Lan supported
> [    3.840814] dwmac-loongson-pci 0000:00:03.1: Enhanced/Alternate
> descriptors
> [    3.847735] dwmac-loongson-pci 0000:00:03.1: Enabled extended descriptors
> [    3.854487] dwmac-loongson-pci 0000:00:03.1: Ring mode enabled
> [    3.860283] dwmac-loongson-pci 0000:00:03.1: Enable RX Mitigation via HW
> Watchdog Timer
> [    3.868244] dwmac-loongson-pci 0000:00:03.1: device MAC address
> 5e:ee:cb:23:62:f9
> [    3.878410] mdio_bus stmmac-19:02: attached PHY driver [unbound]
> (mii_bus:phy_addr=stmmac-19:02, irq=POLL)
> [    3.888777] dwmac-loongson-pci 0000:00:03.2: User ID: 0xd1, Synopsys ID:
> 0x10
> [    3.895894] dwmac-loongson-pci 0000:00:03.2: DMA HW capability register
> supported
> [    3.903355] dwmac-loongson-pci 0000:00:03.2: RX Checksum Offload Engine
> supported
> [    3.910803] dwmac-loongson-pci 0000:00:03.2: COE Type 2
> [    3.916008] dwmac-loongson-pci 0000:00:03.2: TX Checksum insertion
> supported
> [    3.923027] dwmac-loongson-pci 0000:00:03.2: Wake-Up On Lan supported
> [    3.929452] dwmac-loongson-pci 0000:00:03.2: Enhanced/Alternate
> descriptors
> [    3.936382] dwmac-loongson-pci 0000:00:03.2: Enabled extended descriptors
> [    3.943138] dwmac-loongson-pci 0000:00:03.2: Ring mode enabled
> [    3.948940] dwmac-loongson-pci 0000:00:03.2: Enable RX Mitigation via HW
> Watchdog Timer
> [    3.956915] dwmac-loongson-pci 0000:00:03.2: device MAC address
> 2e:38:a1:7d:5e:af

> [    3.974895] YT8531 Gigabit Ethernet stmmac-1a:00: attached PHY driver
> (mii_bus:phy_addr=stmmac-1a:00, irq=POLL)

* The line from which we figured out your PHY vendor.)

>
> ...
>
> [   16.257892] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: Register
> MEM_TYPE_PAGE_POOL RxQ-0
> [   16.266096] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: Register
> MEM_TYPE_PAGE_POOL RxQ-1
> [   16.274199] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: Register
> MEM_TYPE_PAGE_POOL RxQ-2
> [   16.282258] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: Register
> MEM_TYPE_PAGE_POOL RxQ-3
> [   16.290336] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: Register
> MEM_TYPE_PAGE_POOL RxQ-4
> [   16.298461] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: Register
> MEM_TYPE_PAGE_POOL RxQ-5
> [   16.306519] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: Register
> MEM_TYPE_PAGE_POOL RxQ-6
> [   16.314567] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: Register
> MEM_TYPE_PAGE_POOL RxQ-7
> [   16.324050] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: PHY [stmmac-18:02]
> driver [Generic PHY] (irq=POLL)
> [   16.343589] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: No Safety Features
> support found
> [   16.351552] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: IEEE 1588-2008
> Advanced Timestamp supported
> [   16.360581] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: registered PTP
> clock
> [   16.367439] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: configuring for
> phy/gmii link mode
> [   16.382079] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: Register
> MEM_TYPE_PAGE_POOL RxQ-0
> [   16.390170] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: Register
> MEM_TYPE_PAGE_POOL RxQ-1
> [   16.398229] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: Register
> MEM_TYPE_PAGE_POOL RxQ-2
> [   16.406279] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: Register
> MEM_TYPE_PAGE_POOL RxQ-3
> [   16.414351] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: Register
> MEM_TYPE_PAGE_POOL RxQ-4
> [   16.422422] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: Register
> MEM_TYPE_PAGE_POOL RxQ-5
> [   16.430504] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: Register
> MEM_TYPE_PAGE_POOL RxQ-6
> [   16.438555] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: Register
> MEM_TYPE_PAGE_POOL RxQ-7
> [   16.448025] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: PHY [stmmac-19:02]
> driver [Generic PHY] (irq=POLL)
> [   16.467550] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: No Safety Features
> support found
> [   16.475464] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: IEEE 1588-2008
> Advanced Timestamp supported
> [   16.484478] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: registered PTP
> clock
> [   16.491354] dwmac-loongson-pci 0000:00:03.1 enp0s3f1: configuring for
> phy/gmii link mode
> [   16.506012] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: Register
> MEM_TYPE_PAGE_POOL RxQ-0
> [   16.514105] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: Register
> MEM_TYPE_PAGE_POOL RxQ-1
> [   16.522167] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: Register
> MEM_TYPE_PAGE_POOL RxQ-2
> [   16.530235] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: Register
> MEM_TYPE_PAGE_POOL RxQ-3
> [   16.538288] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: Register
> MEM_TYPE_PAGE_POOL RxQ-4
> [   16.546331] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: Register
> MEM_TYPE_PAGE_POOL RxQ-5
> [   16.554379] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: Register
> MEM_TYPE_PAGE_POOL RxQ-6
> [   16.562424] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: Register
> MEM_TYPE_PAGE_POOL RxQ-7
> [   16.571852] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: PHY [stmmac-1a:00]
> driver [YT8531 Gigabit Ethernet] (irq=POLL)
> [   16.582549] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: No Safety Features
> support found
> [   16.590745] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: IEEE 1588-2008
> Advanced Timestamp supported
> [   16.599830] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: registered PTP
> clock
> [   16.607330] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: configuring for
> phy/rgmii-id link mode
> [   16.618296] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: Link is Up -
> 1Gbps/Full - flow control off
> [  329.951433] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: Link is Down
> [  332.832685] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: Link is Up -
> 1Gbps/Full - flow control off
> [  333.855327] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: Link is Down
> [  336.928480] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: Link is Up -
> 1Gbps/Full - flow control off
> [  349.215440] dwmac-loongson-pci 0000:00:03.0 enp0s3f0: Link is Down
> [  351.456477] dwmac-loongson-pci 0000:00:03.2 enp0s3f2: Link is Up -
> 1Gbps/Full - flow control off
> 
> The device(7a03 and 7a13) can access the network.
> 
> $: cat /proc/interrupts
> 
>            CPU0       CPU1
>  20:       3826      12138   CPUINTC  12  IPI
>  21:      15242      11791   CPUINTC  11  timer
>  22:          0          0   PCH PIC   1  acpi
>  28:          0          0   PCH PIC   7  loongson-alarm
>  29:          0          0   PCH PIC   8  ls2x-i2c, ls2x-i2c, ls2x-i2c,
> ls2x-i2c, ls2x-i2c, ls2x-i2c
>  34:       7456          0   LIOINTC  10  ttyS0
>  42:       1192          0   PCH PIC  17  0000:00:06.1
>  43:          0          0   PCH PIC  18  ahci[0000:00:08.0]
>  44:         40          0   PCH PIC  19  enp0s3f0
>  45:          0          0   PCH PIC  20  enp0s3f1
>  46:       1446          0   PCH PIC  21  enp0s3f2
>  47:      11164          0   PCH PIC  22  xhci-hcd:usb1
>  48:        338          0   PCH PIC  23  xhci-hcd:usb3
>  49:          0          0   PCH PIC  24  snd_hda_intel:card0
> IPI0:       117        132  LoongArch  1  Rescheduling interrupts
> IPI1:      3713      12007  LoongArch  2  Function call interrupts
> ERR:          1
> 
> 

So, what made you thinking that the enp0s3f0, enp0s3f1 and enp0s3f2
interfaces weren't working? I failed to find any immediate problem in
the log.

The driver registered eight Rx-queues (and likely eight Tx-queues).
enp0s3f0 and enp0s3f2 links got up. Even the log reported that two
interfaces have some network access (whatever it meant in your
boot-script):

> The device(7a03 and 7a13) can access the network.

Yes, there is only one IRQ registered for each interface. But that's
what was expected seeing you have a single MAC IRQ detected. The
main question is: do the network traffic still get to flow in this
case? Are you able to send/receive data over all the DMA-channels?

-Serge(y)

