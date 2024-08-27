Return-Path: <netdev+bounces-122491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE39A961804
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB631C2329E
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 19:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4191D3186;
	Tue, 27 Aug 2024 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RnAVsYhV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932921D2F51
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724786956; cv=none; b=mpS9o99aDrXSawzCdExLiXicZef96Hiamhp9gaGGkLUMCO766UNJsaoxngT7a2OTw1+hV1nNWTRkwQOdO/o5zxenBS2IvY5r3hL8cidqVB5TsG3FoLIwgjX0BCcP162eDkXCKDZyUd6Cdb1PEV2dOK2meMBIMqF2IzIKKFUfZb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724786956; c=relaxed/simple;
	bh=XmCKE1yAFFK3hqkryW2KkaSx2PKqUdv57bUBardyjb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffq7kgUfs+NEyVI5TxPxVIQLC9wFWsolsDNAv/ENKclVA2at7QGOijh27p3K6nid5W5lxWuwj6vNJOdwN2oROTR/WWHtVscTockIt1/JJMqn+a6BTpazCnmaUZqE/yIdqyM2Nvi8NUMrqvNGoIRrAzw2GC/oKQrbwsO8H9XkB18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RnAVsYhV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724786955; x=1756322955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XmCKE1yAFFK3hqkryW2KkaSx2PKqUdv57bUBardyjb8=;
  b=RnAVsYhVcbNWJs3IqnVjQD+hgstFd4WOFGt9ID88cejGkZ4W7QPIE0p3
   ramK4ZPzn8wMFpvV4bTNRbvYJ677QDqWjdC1vBpadsx+G+4IBJzryoa98
   P0le04bEsk77QYJwz5c028FSsP1nO3hpEeTsi6+YEdG4O6AmLT/i7PXtq
   pZjW15I3Ptdjr7IMBrmOOfYnKoRw81n0PftuEOy2uI7xP1r5xU/UwgssB
   cBxxNwKsZi5pQpNzxjRbDwOp1cyq7fZlMY7wt21n7j7WHOy1N9Smt+P7U
   7atsS8/ilXwUuKskM5X3Xow7Sfg7luYPzLRhZZ12j82lGTleowQr9Ti6+
   Q==;
X-CSE-ConnectionGUID: W24j828FRrmnuFHo1DwNGA==
X-CSE-MsgGUID: YXATg3bcQPesV0Qncz0IuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="33861379"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="33861379"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 12:29:14 -0700
X-CSE-ConnectionGUID: /9tq97SySTyv2uBoJnvGgw==
X-CSE-MsgGUID: rA87ujF4TZuIkwOehkX/Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="63283879"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 27 Aug 2024 12:29:13 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sj1sL-000K0K-1w;
	Tue, 27 Aug 2024 19:29:09 +0000
Date: Wed, 28 Aug 2024 03:28:12 +0800
From: kernel test robot <lkp@intel.com>
To: Karol Kolacinski <karol.kolacinski@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [Intel-wired-lan] [PATCH v8 iwl-next 2/7] ice: Remove
 unncecessary ice_is_e8xx() functions
Message-ID: <202408280349.0Wn5wfHn-lkp@intel.com>
References: <20240827130814.732181-11-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827130814.732181-11-karol.kolacinski@intel.com>

Hi Karol,

kernel test robot noticed the following build errors:

[auto build test ERROR on 025f455f893c9f39ec392d7237d1de55d2d00101]

url:    https://github.com/intel-lab-lkp/linux/commits/Karol-Kolacinski/ice-Don-t-check-device-type-when-checking-GNSS-presence/20240827-211218
base:   025f455f893c9f39ec392d7237d1de55d2d00101
patch link:    https://lore.kernel.org/r/20240827130814.732181-11-karol.kolacinski%40intel.com
patch subject: [Intel-wired-lan] [PATCH v8 iwl-next 2/7] ice: Remove unncecessary ice_is_e8xx() functions
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240828/202408280349.0Wn5wfHn-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240828/202408280349.0Wn5wfHn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408280349.0Wn5wfHn-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_service_task':
>> ice_main.c:(.text+0x267ca): undefined reference to `ice_is_generic_mac'
   s390-linux-ld: drivers/net/ethernet/intel/ice/ice_controlq.o: in function `ice_is_sbq_supported':
>> ice_controlq.c:(.text+0x2fb6): undefined reference to `ice_is_generic_mac'
   s390-linux-ld: drivers/net/ethernet/intel/ice/ice_ptp.o: in function `ice_ptp_init':
>> ice_ptp.c:(.text+0xad28): undefined reference to `ice_is_e825c'
>> s390-linux-ld: ice_ptp.c:(.text+0xadde): undefined reference to `ice_is_e825c'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

