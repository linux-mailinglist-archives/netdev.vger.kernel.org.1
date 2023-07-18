Return-Path: <netdev+bounces-18640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3397175819A
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 18:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F501C20D3C
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 16:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C2B134C4;
	Tue, 18 Jul 2023 16:02:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B86125D8
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 16:02:12 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690B419B0
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 09:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689696123; x=1721232123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xL6WxhmjH95u23FvD75u4ipup5vjAlrQDvtHqBp7oM4=;
  b=WZvt1yzyDF9OUm+Jys36Zhwcm80LSC2Y4sJwVzzd93A7DoGktWngHU7T
   s/DAUUq72bEHVLoB9KGBsZdJu9tbJiDqgkDHzoQruF+HpjJOtwayTX+2b
   TLydIIq6DjZMzWxMdvrK7dwjrweXJEUURq5QkgGEcIcLej20+VFLU6flf
   G4R7IjO1z98htcDKNvDyDzR8UmgLgFzne65day/lADOFrHR62ntYhnZWO
   Q3o9W+EfJ/ap/wFzZ65kJZtLeOH/GmFDWJ63OMCJ1A9rvMbriMp306V5a
   wfEdjxBCyxaa6BnfeJmwiK8HX2BmeNFiYhBZpMwLecbGQZWbCVBV8r/F6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="366285409"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="366285409"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 09:00:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="837330276"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="837330276"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jul 2023 09:00:46 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qLn82-0000hf-0p;
	Tue, 18 Jul 2023 16:00:46 +0000
Date: Wed, 19 Jul 2023 00:00:36 +0800
From: kernel test robot <lkp@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxim Georgiev <glipus@gmail.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>, UNGLinuxDriver@microchip.com,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Simon Horman <simon.horman@corigine.com>,
	Casper Andersson <casper.casan@gmail.com>,
	Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH v8 net-next 11/12] net: phy: provide phylib stubs for
 hardware timestamping operations
Message-ID: <202307182350.0885cXDi-lkp@intel.com>
References: <20230717152709.574773-12-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717152709.574773-12-vladimir.oltean@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Vladimir,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vladimir-Oltean/net-add-NDOs-for-configuring-hardware-timestamping/20230718-174836
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230717152709.574773-12-vladimir.oltean%40nxp.com
patch subject: [PATCH v8 net-next 11/12] net: phy: provide phylib stubs for hardware timestamping operations
config: parisc-randconfig-r021-20230718 (https://download.01.org/0day-ci/archive/20230718/202307182350.0885cXDi-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230718/202307182350.0885cXDi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307182350.0885cXDi-lkp@intel.com/

All errors (new ones prefixed by >>):

>> make[6]: *** No rule to make target 'drivers/net/phy/stubs.o', needed by 'drivers/net/phy/built-in.a'.
   make[6]: *** [scripts/Makefile.build:243: drivers/net/phy/phy_device.o] Error 1 shuffle=702664809
   make[6]: Target 'drivers/net/phy/' not remade because of errors.
--
>> drivers/net/phy/phy_device.c:30:10: fatal error: linux/phylib_stubs.h: No such file or directory
      30 | #include <linux/phylib_stubs.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +30 drivers/net/phy/phy_device.c

    11	
    12	#include <linux/acpi.h>
    13	#include <linux/bitmap.h>
    14	#include <linux/delay.h>
    15	#include <linux/errno.h>
    16	#include <linux/etherdevice.h>
    17	#include <linux/ethtool.h>
    18	#include <linux/init.h>
    19	#include <linux/interrupt.h>
    20	#include <linux/io.h>
    21	#include <linux/kernel.h>
    22	#include <linux/list.h>
    23	#include <linux/mdio.h>
    24	#include <linux/mii.h>
    25	#include <linux/mm.h>
    26	#include <linux/module.h>
    27	#include <linux/of.h>
    28	#include <linux/netdevice.h>
    29	#include <linux/phy.h>
  > 30	#include <linux/phylib_stubs.h>
    31	#include <linux/phy_led_triggers.h>
    32	#include <linux/pse-pd/pse.h>
    33	#include <linux/property.h>
    34	#include <linux/rtnetlink.h>
    35	#include <linux/sfp.h>
    36	#include <linux/skbuff.h>
    37	#include <linux/slab.h>
    38	#include <linux/string.h>
    39	#include <linux/uaccess.h>
    40	#include <linux/unistd.h>
    41	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

