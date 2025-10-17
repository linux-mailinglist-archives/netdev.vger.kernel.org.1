Return-Path: <netdev+bounces-230519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B06BE9E1F
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 17:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9737434B2
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 15:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE03A331A7C;
	Fri, 17 Oct 2025 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ka27QqaR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76D12F692A
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713876; cv=none; b=gHjoDh+EdVQh0VS54p09BuYaF6o3yGYs4DekdgC87Of0GVoG3RgovmGdkYN/5x0Co68Hdm+UEuVW1atUzW2pA7lxTcrtr46rFZyb76AiFYBwxIJ42dm7Fv7pAB6/M7dhXKDel/oiznLiDJPDLCMBKD3JUDMk2t8v8C/n9UwcU9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713876; c=relaxed/simple;
	bh=H/95EBfuWUHWxUFD4Lyj6YbVhj1SzAqoMPXpyRPBk2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9qx1kulGhef/RIR9PuH8v0mJgq7r3+80nMlc9NRRW1lXQo8iefKs6EwH5NYGoGzWS5Y+qyhSJgfsScP9dllfFkAEh0FWorhGQ18/ds/CBmzwDlm9CBDaVcrXrKQQcJ6Q6jWcIx/ikK2qVEetSVXDtWUHyYkdy2rNYdnor9k7Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ka27QqaR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760713872; x=1792249872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H/95EBfuWUHWxUFD4Lyj6YbVhj1SzAqoMPXpyRPBk2w=;
  b=ka27QqaRRoRggjZsqsD/a8tSmwz65Iy7PQLIJDA5a8hzaTKud6XopuXV
   BwqTMLpqlenmDBQayBZeKuLJIl+wbqGk4C1wznAapNjnekmjBcOSRsDEi
   SWlzod5paBwCYmjJgYwqr+Kq5Y3ucfewsfI2gvLNuEsIzBRg01KkfhFlo
   wKtA6de/Ol1oZNJhHbpfGUJS0gI74b4fdPJC5mkNeggGoFBykoKiG/STw
   0Av8V8GaIYosY57N3TQukP8AeCWBNHwOKy/4yJa6lra0FwDDE/5gkRzDa
   SUaJCd7zHiVnlQ4iqH3vWA+8Y0Pb0FFF+TooMy1gVophWz4jxwnoTFA82
   A==;
X-CSE-ConnectionGUID: tnHLLRqTQbmNcb6M1Y0mnQ==
X-CSE-MsgGUID: sDDN3WLUSl+3vRtEt+ZZWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="62828489"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="62828489"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 08:11:11 -0700
X-CSE-ConnectionGUID: xIfHTDIaS7SpR8XqiWWhNg==
X-CSE-MsgGUID: SruBDmDyTRC4zskXL5JwOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="183245944"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 17 Oct 2025 08:11:09 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9m6l-0006GF-0V;
	Fri, 17 Oct 2025 15:11:07 +0000
Date: Fri, 17 Oct 2025 23:10:36 +0800
From: kernel test robot <lkp@intel.com>
To: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, steffen.klassert@secunet.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH ipsec 6/6] xfrm: check all hash buckets for leftover
 states during netns deletion
Message-ID: <202510172159.iLR9bfcc-lkp@intel.com>
References: <2a743a05bbad7ebdc36c2c86a5fcbb9e99071c7b.1760610268.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a743a05bbad7ebdc36c2c86a5fcbb9e99071c7b.1760610268.git.sd@queasysnail.net>

Hi Sabrina,

kernel test robot noticed the following build warnings:

[auto build test WARNING on klassert-ipsec-next/master]
[also build test WARNING on klassert-ipsec/master net/main net-next/main linus/master v6.18-rc1 next-20251016]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sabrina-Dubroca/xfrm-drop-SA-reference-in-xfrm_state_update-if-dir-doesn-t-match/20251016-184507
base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
patch link:    https://lore.kernel.org/r/2a743a05bbad7ebdc36c2c86a5fcbb9e99071c7b.1760610268.git.sd%40queasysnail.net
patch subject: [PATCH ipsec 6/6] xfrm: check all hash buckets for leftover states during netns deletion
config: x86_64-randconfig-r123-20251017 (https://download.01.org/0day-ci/archive/20251017/202510172159.iLR9bfcc-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510172159.iLR9bfcc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510172159.iLR9bfcc-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/xfrm/xfrm_state.c:1737:9: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:1744:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1744:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1744:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1744:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1744:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1744:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1744:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1744:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1744:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1744:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1744:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:1744:17: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1744:17: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:1751:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1751:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1751:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1751:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1751:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1751:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1751:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1751:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1751:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1751:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1751:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:1751:17: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1751:17: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:1871:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1871:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1871:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1871:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1871:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1871:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1871:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1871:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1871:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1871:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1871:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:1871:17: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1871:17: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:1874:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1874:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1874:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1874:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1874:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1874:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1874:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1874:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1874:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1874:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1874:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:1874:17: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1874:17: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:2506:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2506:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2506:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2506:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2506:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2506:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2506:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2506:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2506:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2506:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2605:25: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2605:25: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2605:25: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2605:25: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2605:25: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2605:25: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2605:25: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2605:25: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2605:25: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2605:25: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2605:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:2605:25: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:2605:25: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:3270:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hlist_head [noderef] __rcu *state_bydst @@     got struct hlist_head * @@
   net/xfrm/xfrm_state.c:3270:31: sparse:     expected struct hlist_head [noderef] __rcu *state_bydst
   net/xfrm/xfrm_state.c:3270:31: sparse:     got struct hlist_head *
   net/xfrm/xfrm_state.c:3273:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hlist_head [noderef] __rcu *state_bysrc @@     got struct hlist_head * @@
   net/xfrm/xfrm_state.c:3273:31: sparse:     expected struct hlist_head [noderef] __rcu *state_bysrc
   net/xfrm/xfrm_state.c:3273:31: sparse:     got struct hlist_head *
   net/xfrm/xfrm_state.c:3276:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hlist_head [noderef] __rcu *state_byspi @@     got struct hlist_head * @@
   net/xfrm/xfrm_state.c:3276:31: sparse:     expected struct hlist_head [noderef] __rcu *state_byspi
   net/xfrm/xfrm_state.c:3276:31: sparse:     got struct hlist_head *
   net/xfrm/xfrm_state.c:3279:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hlist_head [noderef] __rcu *state_byseq @@     got struct hlist_head * @@
   net/xfrm/xfrm_state.c:3279:31: sparse:     expected struct hlist_head [noderef] __rcu *state_byseq
   net/xfrm/xfrm_state.c:3279:31: sparse:     got struct hlist_head *
   net/xfrm/xfrm_state.c:3297:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_byseq @@
   net/xfrm/xfrm_state.c:3297:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:3297:33: sparse:     got struct hlist_head [noderef] __rcu *state_byseq
   net/xfrm/xfrm_state.c:3299:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_byspi @@
   net/xfrm/xfrm_state.c:3299:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:3299:33: sparse:     got struct hlist_head [noderef] __rcu *state_byspi
   net/xfrm/xfrm_state.c:3301:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_bysrc @@
   net/xfrm/xfrm_state.c:3301:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:3301:33: sparse:     got struct hlist_head [noderef] __rcu *state_bysrc
   net/xfrm/xfrm_state.c:3303:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_bydst @@
   net/xfrm/xfrm_state.c:3303:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:3303:33: sparse:     got struct hlist_head [noderef] __rcu *state_bydst
>> net/xfrm/xfrm_state.c:3320:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head const *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:3320:17: sparse:     expected struct hlist_head const *h
   net/xfrm/xfrm_state.c:3320:17: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:3321:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head const *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:3321:17: sparse:     expected struct hlist_head const *h
   net/xfrm/xfrm_state.c:3321:17: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:3322:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head const *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:3322:17: sparse:     expected struct hlist_head const *h
   net/xfrm/xfrm_state.c:3322:17: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:3323:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head const *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:3323:17: sparse:     expected struct hlist_head const *h
   net/xfrm/xfrm_state.c:3323:17: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:3327:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_byseq @@
   net/xfrm/xfrm_state.c:3327:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:3327:33: sparse:     got struct hlist_head [noderef] __rcu *state_byseq
   net/xfrm/xfrm_state.c:3328:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_byspi @@
   net/xfrm/xfrm_state.c:3328:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:3328:33: sparse:     got struct hlist_head [noderef] __rcu *state_byspi
   net/xfrm/xfrm_state.c:3329:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_bysrc @@
   net/xfrm/xfrm_state.c:3329:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:3329:33: sparse:     got struct hlist_head [noderef] __rcu *state_bysrc
   net/xfrm/xfrm_state.c:3330:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_bydst @@
   net/xfrm/xfrm_state.c:3330:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:3330:33: sparse:     got struct hlist_head [noderef] __rcu *state_bydst
   net/xfrm/xfrm_state.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/uio.h, ...):
   include/linux/rcupdate.h:897:25: sparse: sparse: context imbalance in 'xfrm_register_type' - unexpected unlock
   include/linux/rcupdate.h:897:25: sparse: sparse: context imbalance in 'xfrm_unregister_type' - unexpected unlock
   include/linux/rcupdate.h:897:25: sparse: sparse: context imbalance in 'xfrm_get_type' - unexpected unlock
   include/linux/rcupdate.h:897:25: sparse: sparse: context imbalance in 'xfrm_register_type_offload' - unexpected unlock
   include/linux/rcupdate.h:897:25: sparse: sparse: context imbalance in 'xfrm_unregister_type_offload' - unexpected unlock
   include/linux/rcupdate.h:897:25: sparse: sparse: context imbalance in 'xfrm_set_type_offload' - unexpected unlock
   net/xfrm/xfrm_state.c:934:17: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:976:17: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:58:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:58:39: sparse:     expected struct refcount_struct [usertype] *r
   net/xfrm/xfrm_state.c:58:39: sparse:     got struct refcount_struct [noderef] __rcu *
   net/xfrm/xfrm_state.c:58:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:58:39: sparse:     expected struct refcount_struct [usertype] *r
   net/xfrm/xfrm_state.c:58:39: sparse:     got struct refcount_struct [noderef] __rcu *
   net/xfrm/xfrm_state.c:58:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:58:39: sparse:     expected struct refcount_struct [usertype] *r
   net/xfrm/xfrm_state.c:58:39: sparse:     got struct refcount_struct [noderef] __rcu *
   net/xfrm/xfrm_state.c:58:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:58:39: sparse:     expected struct refcount_struct [usertype] *r
   net/xfrm/xfrm_state.c:58:39: sparse:     got struct refcount_struct [noderef] __rcu *
   net/xfrm/xfrm_state.c:58:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:58:39: sparse:     expected struct refcount_struct [usertype] *r
   net/xfrm/xfrm_state.c:58:39: sparse:     got struct refcount_struct [noderef] __rcu *
   net/xfrm/xfrm_state.c:1655:9: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:58:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:58:39: sparse:     expected struct refcount_struct [usertype] *r
   net/xfrm/xfrm_state.c:58:39: sparse:     got struct refcount_struct [noderef] __rcu *
   net/xfrm/xfrm_state.c:1778:9: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:1814:9: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:2094:17: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:2113:17: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:2315:17: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c: note: in included file:
   include/net/xfrm.h:1971:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/xfrm.h:1971:16: sparse:    struct sock [noderef] __rcu *
   include/net/xfrm.h:1971:16: sparse:    struct sock *

vim +3320 net/xfrm/xfrm_state.c

  3307	
  3308	void xfrm_state_fini(struct net *net)
  3309	{
  3310		unsigned int sz;
  3311		int i;
  3312	
  3313		flush_work(&net->xfrm.state_hash_work);
  3314		xfrm_state_flush(net, 0, false);
  3315		flush_work(&xfrm_state_gc_work);
  3316	
  3317		WARN_ON(!list_empty(&net->xfrm.state_all));
  3318	
  3319		for (i = 0; i <= net->xfrm.state_hmask; i++) {
> 3320			WARN_ON(!hlist_empty(net->xfrm.state_byseq + i));
  3321			WARN_ON(!hlist_empty(net->xfrm.state_byspi + i));
  3322			WARN_ON(!hlist_empty(net->xfrm.state_bysrc + i));
  3323			WARN_ON(!hlist_empty(net->xfrm.state_bydst + i));
  3324		}
  3325	
  3326		sz = (net->xfrm.state_hmask + 1) * sizeof(struct hlist_head);
  3327		xfrm_hash_free(net->xfrm.state_byseq, sz);
  3328		xfrm_hash_free(net->xfrm.state_byspi, sz);
  3329		xfrm_hash_free(net->xfrm.state_bysrc, sz);
  3330		xfrm_hash_free(net->xfrm.state_bydst, sz);
  3331		free_percpu(net->xfrm.state_cache_input);
  3332	}
  3333	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

