Return-Path: <netdev+bounces-80183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADED487D618
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 22:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1691C20B06
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 21:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7AE5478B;
	Fri, 15 Mar 2024 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKN5SjLn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9581E4F8A1
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710537749; cv=none; b=kJ0aHToLmBu3ADck5oNorLXOb0BNA835TZP7mXwZDRyY1wqnZyQ6Xe3WpVoiAIWlEN/8LdqeBxpETjCVyvcTfY7ou+6c6UurWEdfavZzvrm/6xfIYydAWwTyW4dhZBwgLbD/Y3ZinPxGFjLWkUeUH7aZ/XmnApOCYGx/6d6I2H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710537749; c=relaxed/simple;
	bh=N5jN9prsoF2U/vBmsQEy64bjDJL2q722lap31bPOsw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrWkv+xmXRkxhZQt1YWto8ADhSJ2iqz0GZwh2CnoaD08DX2Nd5HdxF+xh/eyraVeMBC5EN6xqmc+sH0tHCjNQnYRl/a8gpiG58+Ks+rUBE1DP2pApuX2Tlq7Utlg1K1+ifQ3i/cEVd1mdSp9E20nrFrIyM75R02Ojf4gc3ZOlg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKN5SjLn; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710537746; x=1742073746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N5jN9prsoF2U/vBmsQEy64bjDJL2q722lap31bPOsw0=;
  b=LKN5SjLnO8cx00fWsB5CcjDuGPvTrVPKFYpMNDVsYjM26zq7MKLBy59K
   7eRzVZBd4AZEpiGbC3QKpVTwVseArfZDfV3EnbhTIhPRb2yR2EZVvpDxz
   z750pNsCM1T18/LujR+48SjgyI3Xnm9RlpsqoIXs+7N9bWxKYZI1pOXN0
   s6kdk4FpJAitE63k+vrfjSV2FmG0FP22LAliXIoBrxCt2OgNcTwEPFGNy
   OCiCs7UGxIkCCbgrq2shHmVKU6teFdyrF9saTQhwj0CV0hbl0i0GleAS2
   KVv/Fb7XvbmBWZP+ZdM8pn0oY9wGHymgjrA+nVbpyBosca/yH62kV2nrF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="30871703"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="30871703"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 14:22:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="17504289"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 15 Mar 2024 14:22:24 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rlF0P-000EoW-0j;
	Fri, 15 Mar 2024 21:22:21 +0000
Date: Sat, 16 Mar 2024 05:21:50 +0800
From: kernel test robot <lkp@intel.com>
To: Antoine Tenart <atenart@kernel.org>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: oe-kbuild-all@lists.linux.dev, Antoine Tenart <atenart@kernel.org>,
	steffen.klassert@secunet.com, netdev@vger.kernel.org
Subject: Re: [PATCH net 1/4] udp: do not accept non-tunnel GSO skbs landing
 in a tunnel
Message-ID: <202403160519.XghWVi81-lkp@intel.com>
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
config: arc-defconfig (https://download.01.org/0day-ci/archive/20240316/202403160519.XghWVi81-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240316/202403160519.XghWVi81-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403160519.XghWVi81-lkp@intel.com/

All errors (new ones prefixed by >>):

   arc-elf-ld: net/ipv4/udp.o: in function `udp_queue_rcv_skb':
>> udp.c:(.text+0x3aca): undefined reference to `udpv6_encap_needed_key'
>> arc-elf-ld: udp.c:(.text+0x3aca): undefined reference to `udpv6_encap_needed_key'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

