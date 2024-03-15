Return-Path: <netdev+bounces-80187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2FB87D65C
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 22:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664082835AF
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 21:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CC254908;
	Fri, 15 Mar 2024 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jSwoDIdH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8A917984
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 21:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710539070; cv=none; b=DOGH21PhDNlIpMsD5dQKwxC542p9WnHYUWI3Uf2iPfup2ejo0iEJNOC7pOnlEudVFGcnMYceSHbz7rkpFkqsrQgXzB+WsEjOXqPaGFZMn6UFClDixIGmB4PQ5cPC06J0lnBp4BGcK9IiaEXmRnLqeH8MPf5uA/0cu+/9qrEoniI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710539070; c=relaxed/simple;
	bh=Vc68BX9M37hBcSzBZecsWwCYOHNZgEWJfCZ8h1c56y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZS/I6VOUTWqMaEMIYX23T57lQOOVK0T6eLLsUdzZnNDPgVR57HzVi8qrComEijnS23b5gwK+yJi7mRG5k4rr5r2Kn+XNVoKTKuU0C8ZeSYSmSXroTnaQZ0mCQKTbQpr2prEy8GUlvP4sme3RZf3N7O9Kga1wTyhBvkrPTLzuI3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jSwoDIdH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710539066; x=1742075066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vc68BX9M37hBcSzBZecsWwCYOHNZgEWJfCZ8h1c56y8=;
  b=jSwoDIdHisXQWtK8l13SzxsqAUCtEgAd8DNft7XUTL96sYKNuBbFSfD2
   LNaKQtRoWhQf8vW9WJoaIiT7ZL2ZDpj0nfwoHuD7cTyPovqkT+6tkXw8f
   yPt1Th5K7+X9RqZgPoCXnDCbvHMgoQ/+we23XG/29O0MjofIgwYKupsgL
   ULgfwOreG5nRBndKNoNopyjD0qYpEVlCWlcXwk3sm1EA82lb0Q2gUWIYr
   HUuTEGnuoolYhmzpD5Sdt5f8NMuRFz8TWw0yhYqBioGa9EVTuPpzP27nL
   Jo7i0j/Kvxohy+oSKVvk9o2rr0ulyBzzH9i/Zr88ufLrqYjwxZ28c6MOc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="16077956"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="16077956"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 14:44:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="35935716"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 15 Mar 2024 14:44:24 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rlFLh-000EpN-1t;
	Fri, 15 Mar 2024 21:44:21 +0000
Date: Sat, 16 Mar 2024 05:43:38 +0800
From: kernel test robot <lkp@intel.com>
To: Antoine Tenart <atenart@kernel.org>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: oe-kbuild-all@lists.linux.dev, Antoine Tenart <atenart@kernel.org>,
	steffen.klassert@secunet.com, netdev@vger.kernel.org
Subject: Re: [PATCH net 1/4] udp: do not accept non-tunnel GSO skbs landing
 in a tunnel
Message-ID: <202403160550.1TZ0mDSX-lkp@intel.com>
References: <20240315151722.119628-2-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315151722.119628-2-atenart@kernel.org>

Hi Antoine,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Antoine-Tenart/udp-do-not-accept-non-tunnel-GSO-skbs-landing-in-a-tunnel/20240315-232048
base:   net/main
patch link:    https://lore.kernel.org/r/20240315151722.119628-2-atenart%40kernel.org
patch subject: [PATCH net 1/4] udp: do not accept non-tunnel GSO skbs landing in a tunnel
config: nios2-defconfig (https://download.01.org/0day-ci/archive/20240316/202403160550.1TZ0mDSX-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240316/202403160550.1TZ0mDSX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403160550.1TZ0mDSX-lkp@intel.com/

All errors (new ones prefixed by >>):

   nios2-linux-ld: net/ipv4/udp.o: in function `raw_atomic_read':
   include/linux/atomic/atomic-arch-fallback.h:457:(.text+0x4b28): undefined reference to `udpv6_encap_needed_key'
>> nios2-linux-ld: include/linux/atomic/atomic-arch-fallback.h:457:(.text+0x4b2c): undefined reference to `udpv6_encap_needed_key'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

