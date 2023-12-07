Return-Path: <netdev+bounces-54869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAFC808ABD
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 15:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA901F2143C
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 14:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAF341C8F;
	Thu,  7 Dec 2023 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hui9haKW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6129293;
	Thu,  7 Dec 2023 06:37:09 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50be3eed85aso1002345e87.2;
        Thu, 07 Dec 2023 06:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701959827; x=1702564627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P/n/DJfS500DzkD8o2lIXV8iW85crXSXBVQD2G7alNw=;
        b=Hui9haKWfVL2J2RO7YyWFL84qDbS3MzfZgZdgV/n9IDs9BrBkg+P3PF1I7DZbBmsOO
         BCmUmrfPg2pDAOOYtKaxYZfKJdFalR99mWuoPDtK8m3c5tdv2iNnkKGko+Sivg3AMsB6
         O54nb/J44N7IU9dkqJ5lJVStpoQt6cO2ngf5ZXwkbAgvEp1ig3FRogJv8aOhIJBrG1M0
         DWkW552Hz/epr5G/N+4mX1A9MOe0a5bYgqO82aYV6ArrsKZTSnGpWpHr0M7TjWMVOIqr
         g7tUKELNGNYunltrMXxGDqsC99xNrxP7Isl0Bs3f56nMi6rSgx8s8sL+DADqZhUh15Kj
         ytyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701959827; x=1702564627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/n/DJfS500DzkD8o2lIXV8iW85crXSXBVQD2G7alNw=;
        b=grN+gkFa1iU9WzElc9TG598WYOZQYRMU/Y19BbJAQ/dmehyTI9Hr0l5y97TaosVG6U
         3Xv2WpzYJzSpfeItuT5PTpMIgCx3jdWmpdJ9MfEx1UYT/z5yeODuAGObU3/uSRP6Fdqo
         ihji3a3o8RkkjIqTp13DhdvSO2DYWvNgDsxZwM6iYUa8R8QURtsytZldQ8A4fihES7yV
         rvK5yJZzm3ZyPQj2A+YXUzihiLms3fMKvvR50sRWhvQZ9GXmWrvvQG1bT9nL/QKXdgbR
         5I9fXitGA7RbCazVrvbBsgDDWFba1AiYkD8heEGz38W3GlkA2AQrbnSE4MZjf+0+S/HK
         8fWQ==
X-Gm-Message-State: AOJu0Yy2ZAMjF0L/XoPbp2kbDEEFh0TMjEuYB7DXOkymCIRgiXHnbXOg
	X6WXPVVKXFyX6dyP6v3TGuQ=
X-Google-Smtp-Source: AGHT+IGovfLmkKIpNWXQzCi7+4Z29EuCi9BtTtr8LpMmdT8CKQjdK8hgB4jjJwsDKG30N8bWSXmUog==
X-Received: by 2002:a05:6512:230a:b0:50b:c8a0:5657 with SMTP id o10-20020a056512230a00b0050bc8a05657mr2022447lfu.17.1701959827365;
        Thu, 07 Dec 2023 06:37:07 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id q9-20020a0565123a8900b0050c0bbbe3d2sm186046lfu.256.2023.12.07.06.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:37:06 -0800 (PST)
Date: Thu, 7 Dec 2023 17:37:03 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Tomer Maimon <tmaimon77@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vladimir Oltean <olteanv@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org, 
	openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 11/16] net: pcs: xpcs: Change
 xpcs_create_mdiodev() suffix to "byaddr"
Message-ID: <jiblfzhnqjztssy76dojx6g7vyqgpjymnt4hz6yg6xv2psn3fo@pro373rkjbbq>
References: <20231205103559.9605-12-fancer.lancer@gmail.com>
 <202312060634.Cblfigt2-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312060634.Cblfigt2-lkp@intel.com>

On Wed, Dec 06, 2023 at 07:03:46AM +0800, kernel test robot wrote:
> Hi Serge,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Serge-Semin/net-pcs-xpcs-Drop-sentinel-entry-from-2500basex-ifaces-list/20231205-183808
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20231205103559.9605-12-fancer.lancer%40gmail.com
> patch subject: [PATCH net-next 11/16] net: pcs: xpcs: Change xpcs_create_mdiodev() suffix to "byaddr"
> config: arc-randconfig-001-20231206 (https://download.01.org/0day-ci/archive/20231206/202312060634.Cblfigt2-lkp@intel.com/config)
> compiler: arc-elf-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312060634.Cblfigt2-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312060634.Cblfigt2-lkp@intel.com/
> 
> All error/warnings (new ones prefixed by >>):
> 
>    drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c: In function 'txgbe_mdio_pcs_init':
> >> drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c:150:16: error: implicit declaration of function 'xpcs_create_mdiodev'; did you mean 'xpcs_create_byaddr'? [-Werror=implicit-function-declaration]
>      150 |         xpcs = xpcs_create_mdiodev(mii_bus, 0, PHY_INTERFACE_MODE_10GBASER);
>          |                ^~~~~~~~~~~~~~~~~~~
>          |                xpcs_create_byaddr
> >> drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c:150:14: warning: assignment to 'struct dw_xpcs *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>      150 |         xpcs = xpcs_create_mdiodev(mii_bus, 0, PHY_INTERFACE_MODE_10GBASER);
>          |              ^
>    cc1: some warnings being treated as errors
> 
> 
> vim +150 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c

Ah, right. I had been creating the series some times earlier than this
code was introduced and just missed it on the last rebase. I'll fix
this on v2.

-Serge(y)

> 
> 854cace61387b6 Jiawen Wu      2023-06-06  121  
> 854cace61387b6 Jiawen Wu      2023-06-06  122  static int txgbe_mdio_pcs_init(struct txgbe *txgbe)
> 854cace61387b6 Jiawen Wu      2023-06-06  123  {
> 854cace61387b6 Jiawen Wu      2023-06-06  124  	struct mii_bus *mii_bus;
> 854cace61387b6 Jiawen Wu      2023-06-06  125  	struct dw_xpcs *xpcs;
> 854cace61387b6 Jiawen Wu      2023-06-06  126  	struct pci_dev *pdev;
> 854cace61387b6 Jiawen Wu      2023-06-06  127  	struct wx *wx;
> 854cace61387b6 Jiawen Wu      2023-06-06  128  	int ret = 0;
> 854cace61387b6 Jiawen Wu      2023-06-06  129  
> 854cace61387b6 Jiawen Wu      2023-06-06  130  	wx = txgbe->wx;
> 854cace61387b6 Jiawen Wu      2023-06-06  131  	pdev = wx->pdev;
> 854cace61387b6 Jiawen Wu      2023-06-06  132  
> 854cace61387b6 Jiawen Wu      2023-06-06  133  	mii_bus = devm_mdiobus_alloc(&pdev->dev);
> 854cace61387b6 Jiawen Wu      2023-06-06  134  	if (!mii_bus)
> 854cace61387b6 Jiawen Wu      2023-06-06  135  		return -ENOMEM;
> 854cace61387b6 Jiawen Wu      2023-06-06  136  
> 854cace61387b6 Jiawen Wu      2023-06-06  137  	mii_bus->name = "txgbe_pcs_mdio_bus";
> 854cace61387b6 Jiawen Wu      2023-06-06  138  	mii_bus->read_c45 = &txgbe_pcs_read;
> 854cace61387b6 Jiawen Wu      2023-06-06  139  	mii_bus->write_c45 = &txgbe_pcs_write;
> 854cace61387b6 Jiawen Wu      2023-06-06  140  	mii_bus->parent = &pdev->dev;
> 854cace61387b6 Jiawen Wu      2023-06-06  141  	mii_bus->phy_mask = ~0;
> 854cace61387b6 Jiawen Wu      2023-06-06  142  	mii_bus->priv = wx;
> 854cace61387b6 Jiawen Wu      2023-06-06  143  	snprintf(mii_bus->id, MII_BUS_ID_SIZE, "txgbe_pcs-%x",
> d8c21ef7b2b147 Xiongfeng Wang 2023-08-08  144  		 pci_dev_id(pdev));
> 854cace61387b6 Jiawen Wu      2023-06-06  145  
> 854cace61387b6 Jiawen Wu      2023-06-06  146  	ret = devm_mdiobus_register(&pdev->dev, mii_bus);
> 854cace61387b6 Jiawen Wu      2023-06-06  147  	if (ret)
> 854cace61387b6 Jiawen Wu      2023-06-06  148  		return ret;
> 854cace61387b6 Jiawen Wu      2023-06-06  149  
> 854cace61387b6 Jiawen Wu      2023-06-06 @150  	xpcs = xpcs_create_mdiodev(mii_bus, 0, PHY_INTERFACE_MODE_10GBASER);
> 854cace61387b6 Jiawen Wu      2023-06-06  151  	if (IS_ERR(xpcs))
> 854cace61387b6 Jiawen Wu      2023-06-06  152  		return PTR_ERR(xpcs);
> 854cace61387b6 Jiawen Wu      2023-06-06  153  
> 854cace61387b6 Jiawen Wu      2023-06-06  154  	txgbe->xpcs = xpcs;
> 854cace61387b6 Jiawen Wu      2023-06-06  155  
> 854cace61387b6 Jiawen Wu      2023-06-06  156  	return 0;
> 854cace61387b6 Jiawen Wu      2023-06-06  157  }
> 854cace61387b6 Jiawen Wu      2023-06-06  158  
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

