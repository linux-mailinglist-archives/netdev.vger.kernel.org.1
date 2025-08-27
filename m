Return-Path: <netdev+bounces-217404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D31ABB388F5
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 19:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 964277A8CB1
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B9F2D7DED;
	Wed, 27 Aug 2025 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OH6omwl0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA332D7D2E;
	Wed, 27 Aug 2025 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756317318; cv=none; b=HsudBPll7RHb3/ufmvFQ27dyb1UJX5LR7H40uSNlIEJWTw1r3GMJ0CuoIReSiOzvM92vRRDimBFELkFPnxi8/mm2IkiRQrYdfEGwEjNlpo7juB/EojFwvlc31uMxJqrH2Kqp6CwDDFXglZ0VDPm9c1i2p/z0e2iNugsc1Ak/5Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756317318; c=relaxed/simple;
	bh=kwd198YuCgA0kZ9xjDCn4ZtyCIY8uP5Rn5q+t2dyKX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnQC8cMlfNAznc4Jbk54UHZJfZkSxyuY57C0+Qfn29RD5o+di7FwS4Lb8M35jP38ux0/8moUQ4Mb8IYX9fglyKXgtdE+uERsxTrTbVeDYeaQy6Ltq8g4GDlEJlbrMH4MskLB+CX0jyfINeKQPbbj6DXlOvl7TLAFmpYKesVGnKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OH6omwl0; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756317317; x=1787853317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kwd198YuCgA0kZ9xjDCn4ZtyCIY8uP5Rn5q+t2dyKX4=;
  b=OH6omwl0wypxKmY5p8vMJ/joYLwk3qUtBI8QTQKd8NBJFCKIUlswQXd9
   oDe37oODsOwuBSzsqRoj6nw6/dnVj03pRXDz5V1UkzTtj0Wo0hHOFcdr7
   ZVzBqg1xJ7S6HRADfr3WDNnLwGar4jy3tYwEnEJVJn/Vv7kGUbni86WfE
   B+QHiFxKBzadn+KLzdh3Ilvv4vWWLPXHj6lzNXwG+0vWuYCgETDNU8mqJ
   AHG46J74NiUvSfJiDcmnGehNRpUGwAcDmYfIkKYPZoLriPLSI+Ee3uCQr
   K1CbCKv3FULE1mL9s2LL0wl1CR2r9aBpmGu9EUdxi187bmFgSSxfbvKnw
   w==;
X-CSE-ConnectionGUID: yz0s/XILSO+Jj1EemJBQqw==
X-CSE-MsgGUID: uIqsf7B5RnK/Q1x3EzarhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="62220510"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="62220510"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 10:55:16 -0700
X-CSE-ConnectionGUID: knnLbb9kSuCnrXBl4xYRgg==
X-CSE-MsgGUID: st431V+TTTabCjdhhUGtfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="207062895"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 27 Aug 2025 10:55:13 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1urKMO-000T8R-18;
	Wed, 27 Aug 2025 17:55:02 +0000
Date: Thu, 28 Aug 2025 01:54:48 +0800
From: kernel test robot <lkp@intel.com>
To: admiyo@os.amperecomputing.com, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH net-next v25 1/1] mctp pcc: Implement MCTP over PCC
 Transport
Message-ID: <202508280145.bix2s4fv-lkp@intel.com>
References: <20250827044810.152775-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827044810.152775-2-admiyo@os.amperecomputing.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/admiyo-os-amperecomputing-com/mctp-pcc-Implement-MCTP-over-PCC-Transport/20250827-124953
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250827044810.152775-2-admiyo%40os.amperecomputing.com
patch subject: [PATCH net-next v25 1/1] mctp pcc: Implement MCTP over PCC Transport
config: i386-randconfig-002-20250827 (https://download.01.org/0day-ci/archive/20250828/202508280145.bix2s4fv-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250828/202508280145.bix2s4fv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508280145.bix2s4fv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/mctp/mctp-pcc.c:110:24: warning: variable 'mctp_pcc_ndev' set but not used [-Wunused-but-set-variable]
     110 |         struct mctp_pcc_ndev *mctp_pcc_ndev;
         |                               ^
   1 warning generated.


vim +/mctp_pcc_ndev +110 drivers/net/mctp/mctp-pcc.c

   107	
   108	static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
   109	{
 > 110		struct mctp_pcc_ndev *mctp_pcc_ndev;
   111		struct mctp_pcc_mailbox *box;
   112		struct sk_buff *skb = NULL;
   113		struct sk_buff *curr_skb;
   114	
   115		mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
   116		box = container_of(c, struct mctp_pcc_mailbox, client);
   117		spin_lock(&box->packets.lock);
   118		skb_queue_walk(&box->packets, curr_skb) {
   119			skb = curr_skb;
   120			if (skb->data == mssg) {
   121				__skb_unlink(skb, &box->packets);
   122				break;
   123			}
   124		}
   125		spin_unlock(&box->packets.lock);
   126	
   127		if (skb)
   128			dev_consume_skb_any(skb);
   129	}
   130	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

