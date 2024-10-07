Return-Path: <netdev+bounces-132854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6219938CE
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 23:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF1328415E
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 21:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D971DE4EE;
	Mon,  7 Oct 2024 21:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Awgs3+rR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3126313698F;
	Mon,  7 Oct 2024 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728335659; cv=none; b=OR5hU1gJ9UKZr8ckHnHhOb+D8di1LPyKAADJGJTaxFLqJZnhSEQrSUTTc9KA1zUN0o4huwHKs6hNWtfwU8+9h4r2GhE+0o6qXM/bGeWw+VMVwARFlEDBdOPTG/xNl9ojQ+eFOkGwnjjC1h4ltUuh1DKsK5oq3E0OhTGBKMAxSak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728335659; c=relaxed/simple;
	bh=myn0LaGgPDnuYmsJ3XpcmcFx6LG52VM3eP42s2hw6l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7+9DwKiZZP7RiZiZD81qj9q1jQhahZBBv3JobW4vaHGsMTJzQH+Q25nYepcTNq9APCOZiVf9dOCyrE8Mcbd8gp1MfxuF6GSOBxIBSd+gPQqSzkMeObofzW+XMIqmuzk+G8c8yl1t1Q4/1dsg1ay2Cxm8AOJ0NnF55ru+u5W7HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Awgs3+rR; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728335658; x=1759871658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=myn0LaGgPDnuYmsJ3XpcmcFx6LG52VM3eP42s2hw6l0=;
  b=Awgs3+rRGykgiedv/DnzxjZNbFBWj1d7eIDBm3c60AfJ8lTho/hrbumD
   ty0akVNHk8lLbVLXUPEe+hwoLYkNraSHeH6uUflrZ5HQGqOGDzC0KyPC9
   obPzzE4iVIsd1cEH8uVwsiF98qTx/unRGqt2HfqF4LSts8h/liIEMg+/Q
   MfTTsEXIUZNBN1M9g64WQ8G0MPusCg19usrC0loKB7f5s2vrMma4S+/AD
   BuEEjajUkdo3C+ni58uFbeYKZ0bXUnMMekj0VM5/w844Lbcskv4jpjhzS
   s/8cbB2qRFQLaygtTvomZWkFxwmgqORXyImxC2/9W+RnHPhUN4C3eJePP
   g==;
X-CSE-ConnectionGUID: StKMNmeAQFS+VmvB84buiA==
X-CSE-MsgGUID: 8dO76rGRTZOkEcvIyHNwvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="26963069"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="26963069"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 14:14:18 -0700
X-CSE-ConnectionGUID: mE9aykswSt2I/Ex5Ki+iOQ==
X-CSE-MsgGUID: g3j6tNFlT5KZ7UdNFjCdyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="79590986"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 07 Oct 2024 14:14:15 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxv3V-0005Wu-0C;
	Mon, 07 Oct 2024 21:14:13 +0000
Date: Tue, 8 Oct 2024 05:13:24 +0800
From: kernel test robot <lkp@intel.com>
To: Mohammed Anees <pvmohammedanees2003@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Mohammed Anees <pvmohammedanees2003@gmail.com>
Subject: Re: [PATCH v2] net: dsa: Fix conditional handling of Wake-on-Lan
 configuration in dsa_user_set_wol
Message-ID: <202410080459.sbnWWj91-lkp@intel.com>
References: <20241006231938.4382-1-pvmohammedanees2003@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006231938.4382-1-pvmohammedanees2003@gmail.com>

Hi Mohammed,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]
[also build test ERROR on net-next/main linus/master v6.12-rc2 next-20241004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mohammed-Anees/net-dsa-Fix-conditional-handling-of-Wake-on-Lan-configuration-in-dsa_user_set_wol/20241007-072229
base:   net/main
patch link:    https://lore.kernel.org/r/20241006231938.4382-1-pvmohammedanees2003%40gmail.com
patch subject: [PATCH v2] net: dsa: Fix conditional handling of Wake-on-Lan configuration in dsa_user_set_wol
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20241008/202410080459.sbnWWj91-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241008/202410080459.sbnWWj91-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410080459.sbnWWj91-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/dsa/user.c: In function 'dsa_user_set_wol':
>> net/dsa/user.c:1220:13: error: void value not ignored as it ought to be
    1220 |         ret = phylink_ethtool_get_wol(dp->pl, w);
         |             ^

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +1220 net/dsa/user.c

  1213	
  1214	static int dsa_user_set_wol(struct net_device *dev, struct ethtool_wolinfo *w)
  1215	{
  1216		struct dsa_port *dp = dsa_user_to_port(dev);
  1217		struct dsa_switch *ds = dp->ds;
  1218		int ret;
  1219	
> 1220		ret = phylink_ethtool_get_wol(dp->pl, w);
  1221	
  1222		if (ret != -EOPNOTSUPP)
  1223			return ret;
  1224	
  1225		if (ds->ops->set_wol)
  1226			return ds->ops->set_wol(ds, dp->index, w);
  1227	
  1228		return -EOPNOTSUPP;
  1229	}
  1230	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

