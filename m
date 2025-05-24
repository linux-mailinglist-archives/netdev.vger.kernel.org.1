Return-Path: <netdev+bounces-193202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3EAAC2E94
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 11:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0364E0267
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 09:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C6815A856;
	Sat, 24 May 2025 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q36a4Lmy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BA972617;
	Sat, 24 May 2025 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748078746; cv=none; b=NCML96m1T2+GwuMx4P56SXoK/S8h/ROgdjv9kz3P5MxTqSy/WONpXdXC1vIkllRtDdcC8C/IDKz8s3/7/qLUgAX4OldYiXSZfcZTHkca0I7YrvWWy+HB9wJFU3itEaek0EgERPeSxXa2BJaRaWPa7gg00T63/EBpIsB6MDX7fBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748078746; c=relaxed/simple;
	bh=kyU2amj6osJGwnLgXhlWOF/c7MgKBXzBWPVbi2oSDKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oyw+fQAm6KcNX8BY/XM+f3DoAM/0UrgZfQ2vbUtxsigWt3WjD63KYgz0zNP+ovlu8MAuLcrLagJISiCC1EJP5kocgMQmPjKlbPv4W4vSP07dQJZeYO1wRoC6ZBqfbwbPbVo2Y1QOyeRfDEZ0iwKRrDhn8P+0fTGgMhidbaL39yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q36a4Lmy; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748078744; x=1779614744;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kyU2amj6osJGwnLgXhlWOF/c7MgKBXzBWPVbi2oSDKQ=;
  b=Q36a4LmyUkbBDRAXa51wn+rv3X2zWIRdmNDU3SJROuc1VicoT57AfsZr
   xyXaXL0laobyhwo/abQyji09l6UhJv9dhyfWFCGv+CarzFlKJ3c4wpUNB
   a8YQgHNTm26szOXvJwXQNzIN7H49xF3WgX7WiF9eHpNjAoYRdXmIsRaKh
   zlkOB0Dyrpt7YLfdXyPM82mMqS2RgNzYlGzgH8S+0cP9Kg3vj9CwiyhKD
   BB94kuulW5YetUwPWa2MlCCnDexwBSmkfPkKjksQAyfQUSbkmizZwC6Bq
   pSQObqhGcqOCDwpKGfhXBu9PwolRLEfEIGfFmXX0bU/i+fh/h6EDwJXJl
   A==;
X-CSE-ConnectionGUID: 8IexZ0glRI+BA/iGFAToOQ==
X-CSE-MsgGUID: R5LHQ+8wRl6E/MhIWEJhYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="50006542"
X-IronPort-AV: E=Sophos;i="6.15,311,1739865600"; 
   d="scan'208";a="50006542"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2025 02:25:43 -0700
X-CSE-ConnectionGUID: 0yyWQubXT4K7oJNm5YdosA==
X-CSE-MsgGUID: nL3pssZiST6r5K/fqX6LrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,311,1739865600"; 
   d="scan'208";a="146489161"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 24 May 2025 02:25:39 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uIl8K-000R52-2Z;
	Sat, 24 May 2025 09:25:36 +0000
Date: Sat, 24 May 2025 17:25:00 +0800
From: kernel test robot <lkp@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Lei Wei <quic_leiwei@quicinc.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Michal Simek <monstr@monstr.eu>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Robert Hancock <robert.hancock@calian.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [net-next PATCH v5 06/10] net: pcs: Add Xilinx PCS driver
Message-ID: <202505241748.uSxf3hT5-lkp@intel.com>
References: <20250523203339.1993685-7-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523203339.1993685-7-sean.anderson@linux.dev>

Hi Sean,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Anderson/dt-bindings-net-Add-Xilinx-PCS/20250524-043901
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250523203339.1993685-7-sean.anderson%40linux.dev
patch subject: [net-next PATCH v5 06/10] net: pcs: Add Xilinx PCS driver
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250524/202505241748.uSxf3hT5-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250524/202505241748.uSxf3hT5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505241748.uSxf3hT5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/pcs/pcs-xilinx.c:295:2: warning: label at end of compound statement is a C23 extension [-Wc23-extensions]
     295 |         }
         |         ^
   1 warning generated.


vim +295 drivers/net/pcs/pcs-xilinx.c

   240	
   241	static int xilinx_pcs_probe(struct mdio_device *mdiodev)
   242	{
   243		struct device *dev = &mdiodev->dev;
   244		struct fwnode_handle *fwnode = dev->fwnode;
   245		int ret, i, j, mode_count;
   246		struct xilinx_pcs *xp;
   247		const char **modes;
   248		u32 phy_id;
   249	
   250		xp = devm_kzalloc(dev, sizeof(*xp), GFP_KERNEL);
   251		if (!xp)
   252			return -ENOMEM;
   253		xp->mdiodev = mdiodev;
   254		dev_set_drvdata(dev, xp);
   255	
   256		xp->irq = fwnode_irq_get_byname(fwnode, "an");
   257		/* There's no _optional variant, so this is the best we've got */
   258		if (xp->irq < 0 && xp->irq != -EINVAL)
   259			return dev_err_probe(dev, xp->irq, "could not get IRQ\n");
   260	
   261		mode_count = fwnode_property_string_array_count(fwnode,
   262								"xlnx,pcs-modes");
   263		if (!mode_count)
   264			mode_count = -ENODATA;
   265		if (mode_count < 0) {
   266			dev_err(dev, "could not read xlnx,pcs-modes: %d", mode_count);
   267			return mode_count;
   268		}
   269	
   270		modes = kcalloc(mode_count, sizeof(*modes), GFP_KERNEL);
   271		if (!modes)
   272			return -ENOMEM;
   273	
   274		ret = fwnode_property_read_string_array(fwnode, "xlnx,pcs-modes",
   275							modes, mode_count);
   276		if (ret < 0) {
   277			dev_err(dev, "could not read xlnx,pcs-modes: %d\n", ret);
   278			kfree(modes);
   279			return ret;
   280		}
   281	
   282		for (i = 0; i < mode_count; i++) {
   283			for (j = 0; j < ARRAY_SIZE(xilinx_pcs_interfaces); j++) {
   284				if (!strcmp(phy_modes(xilinx_pcs_interfaces[j]), modes[i])) {
   285					__set_bit(xilinx_pcs_interfaces[j],
   286						  xp->pcs.supported_interfaces);
   287					goto next;
   288				}
   289			}
   290	
   291			dev_err(dev, "invalid pcs-mode \"%s\"\n", modes[i]);
   292			kfree(modes);
   293			return -EINVAL;
   294	next:
 > 295		}
   296	
   297		kfree(modes);
   298		if ((test_bit(PHY_INTERFACE_MODE_SGMII, xp->pcs.supported_interfaces) ||
   299		     test_bit(PHY_INTERFACE_MODE_1000BASEX, xp->pcs.supported_interfaces)) &&
   300		    test_bit(PHY_INTERFACE_MODE_2500BASEX, xp->pcs.supported_interfaces)) {
   301			dev_err(dev,
   302				"Switching from SGMII or 1000Base-X to 2500Base-X not supported\n");
   303			return -EINVAL;
   304		}
   305	
   306		xp->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
   307		if (IS_ERR(xp->reset))
   308			return dev_err_probe(dev, PTR_ERR(xp->reset),
   309					     "could not get reset gpio\n");
   310	
   311		xp->done = devm_gpiod_get_optional(dev, "done", GPIOD_IN);
   312		if (IS_ERR(xp->done))
   313			return dev_err_probe(dev, PTR_ERR(xp->done),
   314					     "could not get done gpio\n");
   315	
   316		xp->refclk = devm_clk_get_optional_enabled(dev, "refclk");
   317		if (IS_ERR(xp->refclk))
   318			return dev_err_probe(dev, PTR_ERR(xp->refclk),
   319					     "could not get/enable reference clock\n");
   320	
   321		gpiod_set_value_cansleep(xp->reset, 0);
   322		if (xp->done) {
   323			if (read_poll_timeout(gpiod_get_value_cansleep, ret, ret, 1000,
   324					      100000, true, xp->done))
   325				return dev_err_probe(dev, -ETIMEDOUT,
   326						     "timed out waiting for reset\n");
   327		} else {
   328			/* Just wait for a while and hope we're done */
   329			usleep_range(50000, 100000);
   330		}
   331	
   332		if (fwnode_property_present(fwnode, "#clock-cells")) {
   333			const char *parent = "refclk";
   334			struct clk_init_data init = {
   335				.name = fwnode_get_name(fwnode),
   336				.ops = &xilinx_pcs_clk_ops,
   337				.parent_names = &parent,
   338				.num_parents = 1,
   339				.flags = 0,
   340			};
   341	
   342			xp->refclk_out.init = &init;
   343			ret = devm_clk_hw_register(dev, &xp->refclk_out);
   344			if (ret)
   345				return dev_err_probe(dev, ret,
   346						     "could not register refclk\n");
   347	
   348			ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
   349							  &xp->refclk_out);
   350			if (ret)
   351				return dev_err_probe(dev, ret,
   352						     "could not register refclk\n");
   353		}
   354	
   355		/* Sanity check */
   356		ret = get_phy_c22_id(mdiodev->bus, mdiodev->addr, &phy_id);
   357		if (ret)
   358			return dev_err_probe(dev, ret, "could not read id\n");
   359		if ((phy_id & 0xfffffff0) != 0x01740c00)
   360			dev_warn(dev, "unknown phy id %x\n", phy_id);
   361	
   362		if (xp->irq < 0) {
   363			xp->pcs.poll = true;
   364		} else {
   365			/* The IRQ is enabled by default; turn it off */
   366			ret = mdiodev_write(xp->mdiodev, XILINX_PCS_ANICR, 0);
   367			if (ret) {
   368				dev_err(dev, "could not disable IRQ: %d\n", ret);
   369				return ret;
   370			}
   371	
   372			/* Some PCSs have a bad habit of re-enabling their IRQ!
   373			 * Request the IRQ in probe so we don't end up triggering the
   374			 * spurious IRQ logic.
   375			 */
   376			ret = devm_request_threaded_irq(dev, xp->irq, NULL, xilinx_pcs_an_irq,
   377							IRQF_SHARED | IRQF_ONESHOT,
   378							dev_name(dev), xp);
   379			if (ret) {
   380				dev_err(dev, "could not request IRQ: %d\n", ret);
   381				return ret;
   382			}
   383		}
   384	
   385		xp->pcs.ops = &xilinx_pcs_ops;
   386		ret = devm_pcs_register(dev, &xp->pcs);
   387		if (ret)
   388			return dev_err_probe(dev, ret, "could not register PCS\n");
   389	
   390		if (xp->irq < 0)
   391			dev_info(dev, "probed with irq=poll\n");
   392		else
   393			dev_info(dev, "probed with irq=%d\n", xp->irq);
   394		return 0;
   395	}
   396	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

