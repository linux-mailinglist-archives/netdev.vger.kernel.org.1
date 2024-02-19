Return-Path: <netdev+bounces-72831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40613859D2C
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 08:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9263280ED6
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 07:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E25020B28;
	Mon, 19 Feb 2024 07:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OriH2JLG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211F520B11
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708328576; cv=none; b=Dl85Z3PgYNSqTAzK/RMCSBPT1h/F5QNTrNysJSzLeF4AlASPBLK6xuGmk5YOAQXidUk+dL7Q3lni3QvOHdDngXwwuu0407qbLH65tuoPHo2DAPdUsl4YB9sxkVQXzm4XAyPJ3nSIVDpIwvXlesW1NS+izDvGo8LYgfg8Vl6bUNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708328576; c=relaxed/simple;
	bh=H6HS8aXcA0phttHQmIXAy+Qejo7NuWmi1ZNP9TIx+6g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qR6ySFfKuyumd2uENZPB/NkdlwCyAg+wgJAzjSK3ytnDsEkyi8ARK0OUQ7BjR/09/WWFLtraAn9PcdcLSLo97Ja/TUMmPJm2naS53HIB7V4eVYUYRV0hlE072HrF9duH69cdurVAR46YzCsHTCJYcbazLR1jFOzOkTTdtiga+Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OriH2JLG; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5645960cd56so1108015a12.1
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 23:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708328572; x=1708933372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2OA5VUeXGlUxx1p4CTB7toa8KK4Ozgk3yIuXsj4pkl8=;
        b=OriH2JLG5C6B4DPJvqrIO7FEQejXbt4jYwDox0563oyPpiNm9JLAYiNPJwaA0sUlSq
         G0c/Pi9f6hYad6SWlUnPR0r9CR4BfFx1iaTxT+L406yceuZ8zqyJCe2c5oq1hikuiKK0
         io5gAEj1ICyZbw2e+SECkXtmYpMEyGr6WP+vWcn26C/CTTqHbvdzUYG9vZfGabqBcCIw
         l+eHO/AGyqOoPLcRM2WjP+tMhOUoXGpvgmTGXTT0A67FeVsdzHhAwlPNuTAwIP8dNCM0
         ovNHqOZh1sSwdicNF/OQ81iB6oVNkCOM42Lu688+TG+9BwyDq6XGv/HV+l91tIw8QiY/
         JO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708328572; x=1708933372;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2OA5VUeXGlUxx1p4CTB7toa8KK4Ozgk3yIuXsj4pkl8=;
        b=SaVAPf3VfybEkbebLRS3jMkOGnhGJ/pRs4vKHGe75PK8NvvIEh6vm+Q5rEiLeMF6in
         QzXuU7wOGN7OGLHCVC25FEXGwJCOa2ndqnJnuXAQi0PDdYKHjgUW3zgeG+rCpeAY0Dmr
         FeRdMteUmBc4SpBjUkkYhN/kDilttnuUsGl6AhEv9IbYDkKo8KXt96HTVtBO7zdYAtLr
         1yWQUzBHQJ4iZbnSmSEVjXs2jqF1XEsYURIJWVRwvdo34poxuvDwwJl9uWylok7a3aM6
         RJxnQHusvjFtI+umMdJBGUDiYjGIjPxyWJKbzp+R7YB9eSn6egw3F0g+Y19NADcFoYUD
         GqEA==
X-Forwarded-Encrypted: i=1; AJvYcCUWp7zhblEA3RnmJvIvbtHwzoXMdzfDvlz9Gmu7DIiN+aoAcixelGvMc4Tzdpl7IfA4EgqLR6dsY8zZt8thbzia/spqJe+H
X-Gm-Message-State: AOJu0YwUGOxAOO4a3OCwGHMIyJxuooRmeo53Dl4TPCjvC2raoWaao1Sf
	sfKvytmv4QCcnsVrz/wMyiJ7wto4L4ka2m72maZo8/cIdC2N3mtSxEeINfPpvqM=
X-Google-Smtp-Source: AGHT+IGfBFKc2io/hG8bglxGBHu/HKl6TWTQ1yNh4Be+3EZf98UmW6+if6fGn49esHVtpFEbdoSVqg==
X-Received: by 2002:a05:6402:2885:b0:563:c438:89e8 with SMTP id eg5-20020a056402288500b00563c43889e8mr6695793edb.35.1708328572412;
        Sun, 18 Feb 2024 23:42:52 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id b17-20020aa7d491000000b00563ffa219b5sm2384234edr.97.2024.02.18.23.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 23:42:52 -0800 (PST)
Date: Mon, 19 Feb 2024 10:42:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Raju Rangoju <Raju.Rangoju@amd.com>,
	netdev@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Shyam-sundar.S-k@amd.com, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: Re: [PATCH v5 net-next 4/5] amd-xgbe: Add XGBE_XPCS_ACCESS_V3
 support to xgbe_pci_probe()
Message-ID: <f6ab6e62-9f40-4858-9b4e-33d54bf98105@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214154842.3577628-5-Raju.Rangoju@amd.com>

Hi Raju,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Raju-Rangoju/amd-xgbe-reorganize-the-code-of-XPCS-access/20240215-000248
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240214154842.3577628-5-Raju.Rangoju%40amd.com
patch subject: [PATCH v5 net-next 4/5] amd-xgbe: Add XGBE_XPCS_ACCESS_V3 support to xgbe_pci_probe()
config: openrisc-randconfig-r071-20240215 (https://download.01.org/0day-ci/archive/20240218/202402180755.pdt7twL2-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202402180755.pdt7twL2-lkp@intel.com/

smatch warnings:
drivers/net/ethernet/amd/xgbe/xgbe-pci.c:312 xgbe_pci_probe() error: uninitialized symbol 'reg'.

vim +/reg +312 drivers/net/ethernet/amd/xgbe/xgbe-pci.c

47f164deab22a0 Lendacky, Thomas 2016-11-10  209  static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
47f164deab22a0 Lendacky, Thomas 2016-11-10  210  {
47f164deab22a0 Lendacky, Thomas 2016-11-10  211  	void __iomem * const *iomap_table;
eec387ef1b0556 Raju Rangoju     2024-02-14  212  	unsigned int port_addr_size, reg;
eec387ef1b0556 Raju Rangoju     2024-02-14  213  	struct device *dev = &pdev->dev;
eec387ef1b0556 Raju Rangoju     2024-02-14  214  	struct xgbe_prv_data *pdata;
47f164deab22a0 Lendacky, Thomas 2016-11-10  215  	unsigned int ma_lo, ma_hi;
eec387ef1b0556 Raju Rangoju     2024-02-14  216  	struct pci_dev *rdev;
eec387ef1b0556 Raju Rangoju     2024-02-14  217  	int bar_mask, ret;
eec387ef1b0556 Raju Rangoju     2024-02-14  218  	u32 address;
47f164deab22a0 Lendacky, Thomas 2016-11-10  219  
47f164deab22a0 Lendacky, Thomas 2016-11-10  220  	pdata = xgbe_alloc_pdata(dev);
47f164deab22a0 Lendacky, Thomas 2016-11-10  221  	if (IS_ERR(pdata)) {
47f164deab22a0 Lendacky, Thomas 2016-11-10  222  		ret = PTR_ERR(pdata);
47f164deab22a0 Lendacky, Thomas 2016-11-10  223  		goto err_alloc;
47f164deab22a0 Lendacky, Thomas 2016-11-10  224  	}
47f164deab22a0 Lendacky, Thomas 2016-11-10  225  
47f164deab22a0 Lendacky, Thomas 2016-11-10  226  	pdata->pcidev = pdev;
47f164deab22a0 Lendacky, Thomas 2016-11-10  227  	pci_set_drvdata(pdev, pdata);
47f164deab22a0 Lendacky, Thomas 2016-11-10  228  
47f164deab22a0 Lendacky, Thomas 2016-11-10  229  	/* Get the version data */
47f164deab22a0 Lendacky, Thomas 2016-11-10  230  	pdata->vdata = (struct xgbe_version_data *)id->driver_data;
47f164deab22a0 Lendacky, Thomas 2016-11-10  231  
47f164deab22a0 Lendacky, Thomas 2016-11-10  232  	ret = pcim_enable_device(pdev);
47f164deab22a0 Lendacky, Thomas 2016-11-10  233  	if (ret) {
47f164deab22a0 Lendacky, Thomas 2016-11-10  234  		dev_err(dev, "pcim_enable_device failed\n");
47f164deab22a0 Lendacky, Thomas 2016-11-10  235  		goto err_pci_enable;
47f164deab22a0 Lendacky, Thomas 2016-11-10  236  	}
47f164deab22a0 Lendacky, Thomas 2016-11-10  237  
47f164deab22a0 Lendacky, Thomas 2016-11-10  238  	/* Obtain the mmio areas for the device */
47f164deab22a0 Lendacky, Thomas 2016-11-10  239  	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);
47f164deab22a0 Lendacky, Thomas 2016-11-10  240  	ret = pcim_iomap_regions(pdev, bar_mask, XGBE_DRV_NAME);
47f164deab22a0 Lendacky, Thomas 2016-11-10  241  	if (ret) {
47f164deab22a0 Lendacky, Thomas 2016-11-10  242  		dev_err(dev, "pcim_iomap_regions failed\n");
47f164deab22a0 Lendacky, Thomas 2016-11-10  243  		goto err_pci_enable;
47f164deab22a0 Lendacky, Thomas 2016-11-10  244  	}
47f164deab22a0 Lendacky, Thomas 2016-11-10  245  
47f164deab22a0 Lendacky, Thomas 2016-11-10  246  	iomap_table = pcim_iomap_table(pdev);
47f164deab22a0 Lendacky, Thomas 2016-11-10  247  	if (!iomap_table) {
47f164deab22a0 Lendacky, Thomas 2016-11-10  248  		dev_err(dev, "pcim_iomap_table failed\n");
47f164deab22a0 Lendacky, Thomas 2016-11-10  249  		ret = -ENOMEM;
47f164deab22a0 Lendacky, Thomas 2016-11-10  250  		goto err_pci_enable;
47f164deab22a0 Lendacky, Thomas 2016-11-10  251  	}
47f164deab22a0 Lendacky, Thomas 2016-11-10  252  
47f164deab22a0 Lendacky, Thomas 2016-11-10  253  	pdata->xgmac_regs = iomap_table[XGBE_XGMAC_BAR];
47f164deab22a0 Lendacky, Thomas 2016-11-10  254  	if (!pdata->xgmac_regs) {
47f164deab22a0 Lendacky, Thomas 2016-11-10  255  		dev_err(dev, "xgmac ioremap failed\n");
47f164deab22a0 Lendacky, Thomas 2016-11-10  256  		ret = -ENOMEM;
47f164deab22a0 Lendacky, Thomas 2016-11-10  257  		goto err_pci_enable;
47f164deab22a0 Lendacky, Thomas 2016-11-10  258  	}
47f164deab22a0 Lendacky, Thomas 2016-11-10  259  	pdata->xprop_regs = pdata->xgmac_regs + XGBE_MAC_PROP_OFFSET;
47f164deab22a0 Lendacky, Thomas 2016-11-10  260  	pdata->xi2c_regs = pdata->xgmac_regs + XGBE_I2C_CTRL_OFFSET;
47f164deab22a0 Lendacky, Thomas 2016-11-10  261  	if (netif_msg_probe(pdata)) {
47f164deab22a0 Lendacky, Thomas 2016-11-10  262  		dev_dbg(dev, "xgmac_regs = %p\n", pdata->xgmac_regs);
47f164deab22a0 Lendacky, Thomas 2016-11-10  263  		dev_dbg(dev, "xprop_regs = %p\n", pdata->xprop_regs);
47f164deab22a0 Lendacky, Thomas 2016-11-10  264  		dev_dbg(dev, "xi2c_regs  = %p\n", pdata->xi2c_regs);
47f164deab22a0 Lendacky, Thomas 2016-11-10  265  	}
47f164deab22a0 Lendacky, Thomas 2016-11-10  266  
47f164deab22a0 Lendacky, Thomas 2016-11-10  267  	pdata->xpcs_regs = iomap_table[XGBE_XPCS_BAR];
47f164deab22a0 Lendacky, Thomas 2016-11-10  268  	if (!pdata->xpcs_regs) {
47f164deab22a0 Lendacky, Thomas 2016-11-10  269  		dev_err(dev, "xpcs ioremap failed\n");
47f164deab22a0 Lendacky, Thomas 2016-11-10  270  		ret = -ENOMEM;
47f164deab22a0 Lendacky, Thomas 2016-11-10  271  		goto err_pci_enable;
47f164deab22a0 Lendacky, Thomas 2016-11-10  272  	}
47f164deab22a0 Lendacky, Thomas 2016-11-10  273  	if (netif_msg_probe(pdata))
47f164deab22a0 Lendacky, Thomas 2016-11-10  274  		dev_dbg(dev, "xpcs_regs  = %p\n", pdata->xpcs_regs);
47f164deab22a0 Lendacky, Thomas 2016-11-10  275  
4eccbfc3618692 Lendacky, Thomas 2017-01-20  276  	/* Set the PCS indirect addressing definition registers */
4eccbfc3618692 Lendacky, Thomas 2017-01-20  277  	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
597d9659e35b7d Raju Rangoju     2024-02-14  278  	if (rdev && rdev->vendor == PCI_VENDOR_ID_AMD) {
597d9659e35b7d Raju Rangoju     2024-02-14  279  		switch (rdev->device) {
597d9659e35b7d Raju Rangoju     2024-02-14  280  		case XGBE_RV_PCI_DEVICE_ID:
4eccbfc3618692 Lendacky, Thomas 2017-01-20  281  			pdata->xpcs_window_def_reg = PCS_V2_RV_WINDOW_DEF;
4eccbfc3618692 Lendacky, Thomas 2017-01-20  282  			pdata->xpcs_window_sel_reg = PCS_V2_RV_WINDOW_SELECT;
597d9659e35b7d Raju Rangoju     2024-02-14  283  			break;
597d9659e35b7d Raju Rangoju     2024-02-14  284  		case XGBE_YC_PCI_DEVICE_ID:
dbb6c58b5a61d0 Raju Rangoju     2021-12-20  285  			pdata->xpcs_window_def_reg = PCS_V2_YC_WINDOW_DEF;
dbb6c58b5a61d0 Raju Rangoju     2021-12-20  286  			pdata->xpcs_window_sel_reg = PCS_V2_YC_WINDOW_SELECT;
6f60ecf233f9a8 Raju Rangoju     2021-12-20  287  
6f60ecf233f9a8 Raju Rangoju     2021-12-20  288  			/* Yellow Carp devices do not need cdr workaround */
6f60ecf233f9a8 Raju Rangoju     2021-12-20  289  			pdata->vdata->an_cdr_workaround = 0;
f97fc7ef414603 Raju Rangoju     2022-10-20  290  
f97fc7ef414603 Raju Rangoju     2022-10-20  291  			/* Yellow Carp devices do not need rrc */
f97fc7ef414603 Raju Rangoju     2022-10-20  292  			pdata->vdata->enable_rrc = 0;
597d9659e35b7d Raju Rangoju     2024-02-14  293  			break;
eec387ef1b0556 Raju Rangoju     2024-02-14  294  		case XGBE_RN_PCI_DEVICE_ID:
eec387ef1b0556 Raju Rangoju     2024-02-14  295  			pdata->xpcs_window_def_reg = PCS_V3_RN_WINDOW_DEF;
eec387ef1b0556 Raju Rangoju     2024-02-14  296  			pdata->xpcs_window_sel_reg = PCS_V3_RN_WINDOW_SELECT;
eec387ef1b0556 Raju Rangoju     2024-02-14  297  			break;
597d9659e35b7d Raju Rangoju     2024-02-14  298  		default:
597d9659e35b7d Raju Rangoju     2024-02-14  299  			pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
597d9659e35b7d Raju Rangoju     2024-02-14  300  			pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
597d9659e35b7d Raju Rangoju     2024-02-14  301  			break;
597d9659e35b7d Raju Rangoju     2024-02-14  302  		}
4eccbfc3618692 Lendacky, Thomas 2017-01-20  303  	} else {
4eccbfc3618692 Lendacky, Thomas 2017-01-20  304  		pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
4eccbfc3618692 Lendacky, Thomas 2017-01-20  305  		pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
4eccbfc3618692 Lendacky, Thomas 2017-01-20  306  	}
4eccbfc3618692 Lendacky, Thomas 2017-01-20  307  	pci_dev_put(rdev);
4eccbfc3618692 Lendacky, Thomas 2017-01-20  308  
47f164deab22a0 Lendacky, Thomas 2016-11-10  309  	/* Configure the PCS indirect addressing support */
eec387ef1b0556 Raju Rangoju     2024-02-14  310  	if (pdata->vdata->xpcs_access == XGBE_XPCS_ACCESS_V3) {
eec387ef1b0556 Raju Rangoju     2024-02-14  311  		port_addr_size = PCS_RN_PORT_ADDR_SIZE *
eec387ef1b0556 Raju Rangoju     2024-02-14 @312  				 XP_GET_BITS(reg, XP_PROP_0, PORT_ID);
                                                                                             ^^^
reg isn't initalized until 2 lines below.

eec387ef1b0556 Raju Rangoju     2024-02-14  313  		pdata->smn_base = PCS_RN_SMN_BASE_ADDR + port_addr_size;
eec387ef1b0556 Raju Rangoju     2024-02-14  314  
eec387ef1b0556 Raju Rangoju     2024-02-14  315  		address = pdata->smn_base + (pdata->xpcs_window_def_reg);
eec387ef1b0556 Raju Rangoju     2024-02-14  316  		reg = XP_IOREAD(pdata, XP_PROP_0);
eec387ef1b0556 Raju Rangoju     2024-02-14  317  		amd_smn_read(0, address, &reg);
eec387ef1b0556 Raju Rangoju     2024-02-14  318  	} else {
4eccbfc3618692 Lendacky, Thomas 2017-01-20  319  		reg = XPCS32_IOREAD(pdata, pdata->xpcs_window_def_reg);
eec387ef1b0556 Raju Rangoju     2024-02-14  320  	}
eec387ef1b0556 Raju Rangoju     2024-02-14  321  
47f164deab22a0 Lendacky, Thomas 2016-11-10  322  	pdata->xpcs_window = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, OFFSET);
47f164deab22a0 Lendacky, Thomas 2016-11-10  323  	pdata->xpcs_window <<= 6;
47f164deab22a0 Lendacky, Thomas 2016-11-10  324  	pdata->xpcs_window_size = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, SIZE);
47f164deab22a0 Lendacky, Thomas 2016-11-10  325  	pdata->xpcs_window_size = 1 << (pdata->xpcs_window_size + 7);
47f164deab22a0 Lendacky, Thomas 2016-11-10  326  	pdata->xpcs_window_mask = pdata->xpcs_window_size - 1;
47f164deab22a0 Lendacky, Thomas 2016-11-10  327  	if (netif_msg_probe(pdata)) {
40452f0ec84a3b Lendacky, Thomas 2017-08-18  328  		dev_dbg(dev, "xpcs window def  = %#010x\n",

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


