Return-Path: <netdev+bounces-197949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 693E0ADA81A
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 08:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D6518909B7
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 06:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD871CAA82;
	Mon, 16 Jun 2025 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gUrbovJU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D323D156228
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 06:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750054768; cv=none; b=IMCr/iFQ7SU4pAAe0feSs9htzey0/QP0VN39TNevpUvNiW3xADyTmZSXrwXwAm4ebhn4tXNl+TmTm0enDLfgw6OfSHfVPeOFDIa7feCkJM5qn06CN/GRn/S5JnRDVnK4na054KTJ2Wki8cf/ZheXSV+h+I6ctyhI7QrrcQ/ESEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750054768; c=relaxed/simple;
	bh=K8IQ3inhhwcVlDH/GVeLQStlboqAYJS91qtzQftORFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvzkIEc/PFlyEXRPgiIf0scPf+bMvXsi2kH86kxAo7N/gdGW5J+PmKCnmRFbWH26oYRwUwriSMPjDB+TaWOG9tiooYZEaanR3E7njkd9XQX5d37gDGNSPw+PB4me83tyhB/UXSKxex9/mHz96wP7sscw4HQ++QyOkIY+c73ueto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gUrbovJU; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750054766; x=1781590766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K8IQ3inhhwcVlDH/GVeLQStlboqAYJS91qtzQftORFk=;
  b=gUrbovJUYHGrkq6LOetX/9JfqElqPcZCc79+OdQKhRn28yRbisnmscYH
   loSK5MNMwbJ99/RzE2wd9Da++SZjIz9OsIy/6bG7jI6SdrH6Y3zNPipPz
   3uBymKUo8man5W5X+Qj4bHhpFgcZk5bmQm/wQxhtD/MEmPAfVWUo5UVLd
   FyhZhteX6eflJ0706dCZ/M9GQocv/eIDDuB4gSET/97Tje7vvazYecoUp
   PZV/W0FxcYK6DT0EsnbUtbYug7ij5Eth3mindyo9iyX5ro7CuyA/QVXar
   fUMk+Clv01WeZ60n7qCOKsNtFPx+gRQGfH7wqNPwginxxA2eokbWAYuWa
   w==;
X-CSE-ConnectionGUID: 1sXzyMo2T66rZTSZbOFf6Q==
X-CSE-MsgGUID: SLw69X9gQXCWU0KNtgF2hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="62461097"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="62461097"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 23:19:26 -0700
X-CSE-ConnectionGUID: utMW0UdyTROqSUp873fbVg==
X-CSE-MsgGUID: vM9rNMYRQLeQ2OCKX13K5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="148372684"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 15 Jun 2025 23:19:23 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uR3Bh-000Emu-15;
	Mon, 16 Jun 2025 06:19:21 +0000
Date: Mon, 16 Jun 2025 14:19:21 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH net-next 2/2] net: airoha: Differentiate hwfd buffer size
 for QDMA0 and QDMA1
Message-ID: <202506161459.ENhGD33a-lkp@intel.com>
References: <20250615-airoha-hw-num-desc-v1-2-8f88daa4abd7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250615-airoha-hw-num-desc-v1-2-8f88daa4abd7@kernel.org>

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8909f5f4ecd551c2299b28e05254b77424c8c7dc]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/net-airoha-Compute-number-of-descriptors-according-to-reserved-memory-size/20250615-163827
base:   8909f5f4ecd551c2299b28e05254b77424c8c7dc
patch link:    https://lore.kernel.org/r/20250615-airoha-hw-num-desc-v1-2-8f88daa4abd7%40kernel.org
patch subject: [PATCH net-next 2/2] net: airoha: Differentiate hwfd buffer size for QDMA0 and QDMA1
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20250616/202506161459.ENhGD33a-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250616/202506161459.ENhGD33a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506161459.ENhGD33a-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__udivdi3" [drivers/net/ethernet/airoha/airoha-eth.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

