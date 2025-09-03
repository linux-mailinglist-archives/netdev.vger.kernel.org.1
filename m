Return-Path: <netdev+bounces-219627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FA8B42673
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 18:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01EE317C319
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 16:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FAD2C0288;
	Wed,  3 Sep 2025 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0ZcdiMv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4BE36B;
	Wed,  3 Sep 2025 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916195; cv=none; b=pHgAAO+RqoxpJN3wbng8K1gLFKSEofW5WrQH3jPkggHBJDZzVnLSYqXPvo9YSIsKTIpN72qDaOMtqTB9spsqYtxrQ1Rblj68B6O/NPgLrlblKYnHiM29W7jEaK6XL3kU2VWQBBSfsbqF9NOvyiUN3tAuIKesiT6/nhYo2PWiRQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916195; c=relaxed/simple;
	bh=QrZ1xBXZfnmeUYwuf4tYL7a2LZz7hVimzmzBV48W7SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twE1fmRB/OY8T2Udgij3MIUM6a1sbfpw7v1AKk3yzHWhx8Axl/13uOdRc7eIcPN9s8YIvaqEArfyo8xb+mdkiwqtpq804xYJC4VqSm94AtkvROlYEj+MA74U2FZ0L3NUZ0mQBqVKV6COL1lR3r8Eh10HJDLhSQnh7iC8UaP66So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0ZcdiMv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756916193; x=1788452193;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QrZ1xBXZfnmeUYwuf4tYL7a2LZz7hVimzmzBV48W7SM=;
  b=U0ZcdiMvUSV+U0mscu9PbmxHDerTEW3igfgQ+9q2pWBuDybMyjj32hDK
   uVuqwiXxyKZJajzMZXvaCrOzHO7RKg0VPym2KI/5inddZ/98PvPUJCS8Z
   9500UxWMm2o26oiq9+gx+gspcnRIc18wwUjKgqqkBw8REJUXKUeJ65WZU
   1STxwPHh2L66YRTDPI7Hiv+Q7omex/xUn0wwcRt0gvMNdBgLtHOjbNtQ8
   b16LPQLtzO8x6Z8sahqOXTkCv3D71AvepA8d7obseaqpHy9QUGvAAXKr6
   mZ7/erHscACTZNlbEixjXQugQ9kJf6q1ZDr4UywcLxGJfSPHAeaWCo8gH
   w==;
X-CSE-ConnectionGUID: vBCy4yW6RQSPPzbSUcs+Rg==
X-CSE-MsgGUID: y3mq2aQNTjSopV0jFzOEAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="76839620"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="76839620"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 09:16:31 -0700
X-CSE-ConnectionGUID: h2nnzHojS7WwighpkOdYcQ==
X-CSE-MsgGUID: L3aVKnAYRX+fBoJTiDYFkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="195279702"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 03 Sep 2025 09:16:25 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utq8g-00047n-23;
	Wed, 03 Sep 2025 16:15:24 +0000
Date: Thu, 4 Sep 2025 00:14:25 +0800
From: kernel test robot <lkp@intel.com>
To: MD Danish Anwar <danishanwar@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Xin Guo <guoxin09@huawei.com>, Lei Wei <quic_leiwei@quicinc.com>,
	Lee Trager <lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>,
	Fan Gong <gongfan1@huawei.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	Suman Anna <s-anna@ti.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Tero Kristo <kristo@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/8] net: rpmsg-eth: Add basic rpmsg skeleton
Message-ID: <202509032343.1y6JMbSq-lkp@intel.com>
References: <20250902090746.3221225-5-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902090746.3221225-5-danishanwar@ti.com>

Hi MD,

kernel test robot noticed the following build errors:

[auto build test ERROR on 2fd4161d0d2547650d9559d57fc67b4e0a26a9e3]

url:    https://github.com/intel-lab-lkp/linux/commits/MD-Danish-Anwar/dt-bindings-net-ti-rpmsg-eth-Add-DT-binding-for-RPMSG-ETH/20250902-171411
base:   2fd4161d0d2547650d9559d57fc67b4e0a26a9e3
patch link:    https://lore.kernel.org/r/20250902090746.3221225-5-danishanwar%40ti.com
patch subject: [PATCH net-next v2 4/8] net: rpmsg-eth: Add basic rpmsg skeleton
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20250903/202509032343.1y6JMbSq-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250903/202509032343.1y6JMbSq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509032343.1y6JMbSq-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/net/ethernet/rpmsg_eth.c: In function 'rpmsg_eth_get_shm_info':
>> drivers/net/ethernet/rpmsg_eth.c:88:29: error: implicit declaration of function 'devm_ioremap' [-Werror=implicit-function-declaration]
      88 |         common->port->shm = devm_ioremap(common->dev, rmem->base, rmem->size);
         |                             ^~~~~~~~~~~~
>> drivers/net/ethernet/rpmsg_eth.c:88:27: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      88 |         common->port->shm = devm_ioremap(common->dev, rmem->base, rmem->size);
         |                           ^
   cc1: some warnings being treated as errors


vim +/devm_ioremap +88 drivers/net/ethernet/rpmsg_eth.c

    34	
    35	/**
    36	 * rpmsg_eth_get_shm_info - Retrieve shared memory region for RPMsg Ethernet
    37	 * @common: Pointer to rpmsg_eth_common structure
    38	 *
    39	 * This function locates and maps the reserved memory region for the RPMsg
    40	 * Ethernet device by traversing the device tree hierarchy. It first identifies
    41	 * the associated remote processor (rproc), then locates the "rpmsg-eth" child
    42	 * node within the rproc's device tree node, and finally retrieves the
    43	 * "memory-region" phandle that points to the reserved memory region.
    44	 * Once found, the shared memory region is mapped into the
    45	 * kernel's virtual address space using devm_ioremap()
    46	 *
    47	 * Return: 0 on success, negative error code on failure.
    48	 */
    49	static int rpmsg_eth_get_shm_info(struct rpmsg_eth_common *common)
    50	{
    51		struct device_node *np, *rpmsg_eth_node, *rmem_np;
    52		struct reserved_mem *rmem;
    53		struct rproc *rproc;
    54	
    55		/* Get the remote processor associated with this device */
    56		rproc = rproc_get_by_child(&common->rpdev->dev);
    57		if (!rproc) {
    58			dev_err(common->dev, "rpmsg eth device not child of rproc\n");
    59			return -EINVAL;
    60		}
    61	
    62		/* Get the device node from rproc or its parent */
    63		np = rproc->dev.of_node ?: (rproc->dev.parent ? rproc->dev.parent->of_node : NULL);
    64		if (!np) {
    65			dev_err(common->dev, "Cannot find rproc device node\n");
    66			return -ENODEV;
    67		}
    68	
    69		/* Get the rpmsg-eth child node */
    70		rpmsg_eth_node = of_get_child_by_name(np, "rpmsg-eth");
    71		if (!rpmsg_eth_node) {
    72			dev_err(common->dev, "Couldn't get rpmsg-eth node from np\n");
    73			return -ENODEV;
    74		}
    75	
    76		/* Parse the memory-region phandle */
    77		rmem_np = of_parse_phandle(rpmsg_eth_node, "memory-region", 0);
    78		of_node_put(rpmsg_eth_node);
    79		if (!rmem_np)
    80			return -EINVAL;
    81	
    82		/* Lookup the reserved memory region */
    83		rmem = of_reserved_mem_lookup(rmem_np);
    84		of_node_put(rmem_np);
    85		if (!rmem)
    86			return -EINVAL;
    87	
  > 88		common->port->shm = devm_ioremap(common->dev, rmem->base, rmem->size);
    89		if (IS_ERR(common->port->shm))
    90			return PTR_ERR(common->port->shm);
    91	
    92		common->port->buf_size = rmem->size;
    93	
    94		return 0;
    95	}
    96	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

