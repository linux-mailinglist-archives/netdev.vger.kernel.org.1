Return-Path: <netdev+bounces-166433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7D1A35FD3
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CF0F7A49DC
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E76A265625;
	Fri, 14 Feb 2025 14:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CCrWJsCr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E5A264A71;
	Fri, 14 Feb 2025 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739541990; cv=none; b=COawP0m58HjXY7Xk6yXyBQdmWWsNWx/lINbnBahHMOHMIszD6M3wGIzrnNBWZL597hQZppiNxaO0flQx53XnhvtTxLnyP/FcbfSnP014fLtRAqYwzSjqwOfYdFXq/TnOKbStjl74da/nGL0hr3E+gixL79+N5lLuqyqGie8aLcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739541990; c=relaxed/simple;
	bh=9cBFlk2elfhIUBovJUgc2pj982hQ8Go+77xQ1AoDVOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pmoxsa0OA03OlB89yL0QpWI5fZaiE69NO9ZlY7PLq+AzklWibh31j7+Nfu9yMbn1F//PH8DB36xXjFZtlf/U+43Pgf6WVOp/7EdteKBTmujabM0UggXzKpqqlTTVBC24kmKHyHSOzp5Iq4/OmpkmAvRxNNq685Lexy1UlC3/N7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CCrWJsCr; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739541987; x=1771077987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9cBFlk2elfhIUBovJUgc2pj982hQ8Go+77xQ1AoDVOk=;
  b=CCrWJsCruHl4hK68obUB2qrJNgX96WuWIl0gz62cmUKUCge3e7tUjKEP
   D7e7kDRKJbEZ6NvwA9DcZ9WGioeXz13GJfTqO0gVXCfCIuv82dnFtIJBO
   c7PcL4hlsj514wbfmzIyFbD+GhxEDyt/+jXw4N0Hor4u247XEYwFeQLKz
   k6hkxf3OFbNAg9dI3HSuK8JZgUbRtSfPyvgPtGj6zRwoB1XvqWfP6EWKt
   rxOotn4sVQhImIcGjWmAAlSXNjR6Sn22ncuMpi1hQBSpd3HJPzAkFeJt5
   BzsJF4is7FXDq6jneZbOFWybr3FQ0OJG4VcYRU57Udfu47V4Gqe0urQuW
   g==;
X-CSE-ConnectionGUID: DfCo0bqJT/Wb6v0vNvQH9g==
X-CSE-MsgGUID: IE228LZhQJ+8w0UpPc5AZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="51690475"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="51690475"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 06:06:26 -0800
X-CSE-ConnectionGUID: GAM0Tt/hQbO7u9VXlp1RNg==
X-CSE-MsgGUID: OeYg75QKQSWqKE5danBI+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118399870"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 14 Feb 2025 06:06:22 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiwKg-0019df-34;
	Fri, 14 Feb 2025 14:06:18 +0000
Date: Fri, 14 Feb 2025 22:06:02 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH net-next v4 14/16] net: airoha: Introduce flowtable
 offload support
Message-ID: <202502142131.na71FjkW-lkp@intel.com>
References: <20250213-airoha-en7581-flowtable-offload-v4-14-b69ca16d74db@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-airoha-en7581-flowtable-offload-v4-14-b69ca16d74db@kernel.org>

Hi Lorenzo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c3a97ccaed80986fc3c0581661bf9170847d23ba]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/net-airoha-Fix-TSO-support-for-header-cloned-skbs/20250213-234737
base:   c3a97ccaed80986fc3c0581661bf9170847d23ba
patch link:    https://lore.kernel.org/r/20250213-airoha-en7581-flowtable-offload-v4-14-b69ca16d74db%40kernel.org
patch subject: [PATCH net-next v4 14/16] net: airoha: Introduce flowtable offload support
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20250214/202502142131.na71FjkW-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250214/202502142131.na71FjkW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502142131.na71FjkW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/airoha/airoha_ppe.c:818:6: warning: variable 'err' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     818 |         if (!eth->npu)
         |             ^~~~~~~~~
   drivers/net/ethernet/airoha/airoha_ppe.c:820:7: note: uninitialized use occurs here
     820 |         if (!err)
         |              ^~~
   drivers/net/ethernet/airoha/airoha_ppe.c:818:2: note: remove the 'if' if its condition is always true
     818 |         if (!eth->npu)
         |         ^~~~~~~~~~~~~~
     819 |                 err = airoha_ppe_offload_setup(eth);
   drivers/net/ethernet/airoha/airoha_ppe.c:811:9: note: initialize the variable 'err' to silence this warning
     811 |         int err;
         |                ^
         |                 = 0
   1 warning generated.


vim +818 drivers/net/ethernet/airoha/airoha_ppe.c

   803	
   804	int airoha_ppe_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
   805					 void *cb_priv)
   806	{
   807		struct flow_cls_offload *cls = type_data;
   808		struct net_device *dev = cb_priv;
   809		struct airoha_gdm_port *port = netdev_priv(dev);
   810		struct airoha_eth *eth = port->qdma->eth;
   811		int err;
   812	
   813		if (!tc_can_offload(dev) || type != TC_SETUP_CLSFLOWER)
   814			return -EOPNOTSUPP;
   815	
   816		mutex_lock(&flow_offload_mutex);
   817	
 > 818		if (!eth->npu)
   819			err = airoha_ppe_offload_setup(eth);
   820		if (!err)
   821			err = airoha_ppe_flow_offload_cmd(port, cls);
   822	
   823		mutex_unlock(&flow_offload_mutex);
   824	
   825		return err;
   826	}
   827	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

