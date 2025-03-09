Return-Path: <netdev+bounces-173231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0D5A5805C
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 03:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291243AD23F
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 02:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDA026ACC;
	Sun,  9 Mar 2025 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nignk+6X"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82A514A85;
	Sun,  9 Mar 2025 02:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741488691; cv=none; b=dbMfTPvf8/r+6zJve6ujcRqlitmiW85TpPe2qUZUQgvTDhxbAY+Nc9TnUUCIMiKP0KhL+gyb5Wgub7G5o6sKKieeCP86Cm3D0gzIcP69ztP3R+1qgbyM5qnfrXYkgXZKTA1DP7ISA72Sus4U3K8mtX1nGgbquGDfcTk3IvuMj+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741488691; c=relaxed/simple;
	bh=+AxKQzQOhFvyAjlz5Ur/xA8zBv34fgRsUJBCR73dObM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOuagLYWuhf/khAdmwXgRHF5w3W6ND0WL+69prAKh97Twbf2J+27fQilaNs7wmYZc0wLIO6xkyQ4fX/aZhItmWZ+4EILg7CosKSoXJ/UF644H1OvlfvqY7pE0+jTpsTup6EoJ4nSv61WH922DaJ8skj9Gl1QeMZYpe1v4CpRjkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nignk+6X; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741488690; x=1773024690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+AxKQzQOhFvyAjlz5Ur/xA8zBv34fgRsUJBCR73dObM=;
  b=Nignk+6X5m/DDD0/excdVZGpeQaQCZfAVdLlljII+ypjmL25SyV08sVX
   2Fiqz5fHPTgqq4VtIajNbKlHUQzyI/ncDozDLm9xMeCmfM6UJsDXk7xzE
   2dE6HDte/5dNGFLuKd6Torls2LxTUCjmGbqS7EgIvUhu53bQafDeaKqDy
   l5wGVU9B7ZfXB3g+aRSsgEoJkDTSW3ZKFvOhmqZyCGMG9VhZzLqmyi8Nk
   G0YH0wKToQ641ExRmFrhv1xsCs0JM9dlnTewEB1ODArlfFJTqgq+iFKOG
   jI+o8HCyb36upvW6plqZqWR71/PRKG9pyVXcHQ9fECWeRW0oiTG6msT8I
   A==;
X-CSE-ConnectionGUID: 0SYZgyh+QmC9wMqMn5LRbA==
X-CSE-MsgGUID: k4cFiNEfTTCxZDKJBv/D9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="41666197"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="41666197"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 18:51:29 -0800
X-CSE-ConnectionGUID: HiQhBS2oTKiKQ/8IseH6xA==
X-CSE-MsgGUID: E3Auo7O4QWawkzLNtPKfXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="119670936"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 08 Mar 2025 18:51:26 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tr6lA-0002aG-0r;
	Sun, 09 Mar 2025 02:51:24 +0000
Date: Sun, 9 Mar 2025 10:50:43 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch, sdf@fomichev.me
Subject: Re: [PATCH net-next 1/3] eth: bnxt: switch to netif_close
Message-ID: <202503091014.T0oUWfdo-lkp@intel.com>
References: <20250308010840.910382-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308010840.910382-1-sdf@fomichev.me>

Hi Stanislav,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Fomichev/eth-bnxt-request-unconditional-ops-lock/20250308-091318
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250308010840.910382-1-sdf%40fomichev.me
patch subject: [PATCH net-next 1/3] eth: bnxt: switch to netif_close
config: arm-randconfig-004-20250309 (https://download.01.org/0day-ci/archive/20250309/202503091014.T0oUWfdo-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250309/202503091014.T0oUWfdo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503091014.T0oUWfdo-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in arch/arm/probes/kprobes/test-kprobes.o
WARNING: modpost: missing MODULE_DESCRIPTION() in mm/kasan/kasan_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/slub_kunit.o
>> ERROR: modpost: "netif_close" [drivers/net/ethernet/broadcom/bnxt/bnxt_en.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

