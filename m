Return-Path: <netdev+bounces-193570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2E3AC489C
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 08:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 460D07A24CA
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 06:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AF81F582A;
	Tue, 27 May 2025 06:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dRhTprsx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6838823A6
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 06:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748328464; cv=none; b=geEtTUGWCP7NiVf6v41iL50q8fC6y9K4ApUIk44Ue+pp6iyvXk2FAOxbBrBAHGJ3K3AXIRnbaoGUj/W6MGSDZJtLYJx/pG9RqChbkEcxXbekPn6KccKc51M14qN1bujfE6oi6oshNYO9yu+NBzJGbxj3vKCXPR2Eofow9fX5mJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748328464; c=relaxed/simple;
	bh=I4wzHzDJ+8zZKxQvV9AlV/3OFAijXL/3idDMRGdsPps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahrN+E87VA3aL3Yw4YtNzco3+dI63cHEoxgcL8PVzWzG4qr4UWvjpNFVFR7fSce1LIOAHWrhURNT9X6ucGBfmeqdCyeF4ajiMqIl8KElHxqhmE5jvN9ewjH3QV1WgGqTdp7xk+a/hwyWOS36OR35wGUvOK5KaHTi7rcbmw/k+Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dRhTprsx; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748328462; x=1779864462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I4wzHzDJ+8zZKxQvV9AlV/3OFAijXL/3idDMRGdsPps=;
  b=dRhTprsxluo5a7j4+RAAGFlePZGM/7qYFtG54xar2yXI8bVxOHOoaJ4Y
   0DQAmaYwE+4IfJhc3l3v6odhVJ0m2SRCj9rpCyGCADuwBrfrXWpYWokd+
   Rce3W1XISHUbjnpH5w7eHci24Z/5CHmDaphGjQnGN7Hxp7cuWVPEXEOh3
   QlrlSYdjImWkLkI3fJ/dO6rlAu++b4QnHoE9dXmMcAPEtnu60sl/ojO+s
   a9nNc3QaDwRfUr2zR+axv2wttIqHk52mGw/WNTKJXYzY9xcKYd3mybjdg
   Jxk44SE72jxOC+7D8l/OZPOBSa/w9/Sjlt+JBpkbQdaKjAKPOGPKjJVXV
   w==;
X-CSE-ConnectionGUID: YlRnB0MVQRe0UHsShxo4ow==
X-CSE-MsgGUID: lP2AxKgoTkaeXu28JTPfSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="53958187"
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; 
   d="scan'208";a="53958187"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 23:47:42 -0700
X-CSE-ConnectionGUID: 1hBslaCfT9C9WHYXTGbumw==
X-CSE-MsgGUID: EgBudyivS7SiG4jfkgBRVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; 
   d="scan'208";a="179862687"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 26 May 2025 23:47:38 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uJo63-000Sym-0W;
	Tue, 27 May 2025 06:47:35 +0000
Date: Tue, 27 May 2025 14:46:37 +0800
From: kernel test robot <lkp@intel.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saikrishnag@marvell.com,
	gakula@marvell.com, hkelam@marvell.com, sgoutham@marvell.com,
	lcherian@marvell.com, bbhushan2@marvell.com, jerinj@marvell.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Subbaraya Sundeep <sbhatta@marvell.com>
Subject: Re: [net PATCH] octeontx2-pf: Avoid typecasts by simplifying
 otx2_atomic64_add macro
Message-ID: <202505271459.ZZab1GQF-lkp@intel.com>
References: <1748274232-20835-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1748274232-20835-1-git-send-email-sbhatta@marvell.com>

Hi Subbaraya,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Subbaraya-Sundeep/octeontx2-pf-Avoid-typecasts-by-simplifying-otx2_atomic64_add-macro/20250526-234505
base:   net/main
patch link:    https://lore.kernel.org/r/1748274232-20835-1-git-send-email-sbhatta%40marvell.com
patch subject: [net PATCH] octeontx2-pf: Avoid typecasts by simplifying otx2_atomic64_add macro
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20250527/202505271459.ZZab1GQF-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250527/202505271459.ZZab1GQF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505271459.ZZab1GQF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:22:
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h: In function 'otx2_aura_allocptr':
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:52: warning: dereferencing 'void *' pointer
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ^
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:804:16: note: in expansion of macro 'otx2_atomic64_add'
     804 |         return otx2_atomic64_add(incr, ptr);
         |                ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:57: error: invalid use of void expression
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                         ^~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:804:16: note: in expansion of macro 'otx2_atomic64_add'
     804 |         return otx2_atomic64_add(incr, ptr);
         |                ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c: In function 'otx2_q_intr_handler':
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:52: warning: dereferencing 'void *' pointer
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1314:23: note: in expansion of macro 'otx2_atomic64_add'
    1314 |                 val = otx2_atomic64_add((qidx << 44), ptr);
         |                       ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:57: error: invalid use of void expression
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                         ^~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1314:23: note: in expansion of macro 'otx2_atomic64_add'
    1314 |                 val = otx2_atomic64_add((qidx << 44), ptr);
         |                       ^~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:52: warning: dereferencing 'void *' pointer
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1353:23: note: in expansion of macro 'otx2_atomic64_add'
    1353 |                 val = otx2_atomic64_add((qidx << 44), ptr);
         |                       ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:57: error: invalid use of void expression
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                         ^~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1353:23: note: in expansion of macro 'otx2_atomic64_add'
    1353 |                 val = otx2_atomic64_add((qidx << 44), ptr);
         |                       ^~~~~~~~~~~~~~~~~
--
   In file included from drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:17:
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h: In function 'otx2_aura_allocptr':
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:52: warning: dereferencing 'void *' pointer
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ^
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:804:16: note: in expansion of macro 'otx2_atomic64_add'
     804 |         return otx2_atomic64_add(incr, ptr);
         |                ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:57: error: invalid use of void expression
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                         ^~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:804:16: note: in expansion of macro 'otx2_atomic64_add'
     804 |         return otx2_atomic64_add(incr, ptr);
         |                ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c: In function 'otx2_nix_rq_op_stats':
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:52: warning: dereferencing 'void *' pointer
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:34:24: note: in expansion of macro 'otx2_atomic64_add'
      34 |         stats->bytes = otx2_atomic64_add(incr, ptr);
         |                        ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:57: error: invalid use of void expression
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                         ^~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:34:24: note: in expansion of macro 'otx2_atomic64_add'
      34 |         stats->bytes = otx2_atomic64_add(incr, ptr);
         |                        ^~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:52: warning: dereferencing 'void *' pointer
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:37:23: note: in expansion of macro 'otx2_atomic64_add'
      37 |         stats->pkts = otx2_atomic64_add(incr, ptr);
         |                       ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:57: error: invalid use of void expression
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                         ^~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:37:23: note: in expansion of macro 'otx2_atomic64_add'
      37 |         stats->pkts = otx2_atomic64_add(incr, ptr);
         |                       ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c: In function 'otx2_nix_sq_op_stats':
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:52: warning: dereferencing 'void *' pointer
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:47:24: note: in expansion of macro 'otx2_atomic64_add'
      47 |         stats->bytes = otx2_atomic64_add(incr, ptr);
         |                        ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:57: error: invalid use of void expression
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                         ^~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:47:24: note: in expansion of macro 'otx2_atomic64_add'
      47 |         stats->bytes = otx2_atomic64_add(incr, ptr);
         |                        ^~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:52: warning: dereferencing 'void *' pointer
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:50:23: note: in expansion of macro 'otx2_atomic64_add'
      50 |         stats->pkts = otx2_atomic64_add(incr, ptr);
         |                       ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:57: error: invalid use of void expression
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                         ^~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:50:23: note: in expansion of macro 'otx2_atomic64_add'
      50 |         stats->pkts = otx2_atomic64_add(incr, ptr);
         |                       ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c: In function 'otx2_sqb_flush':
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:52: warning: dereferencing 'void *' pointer
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:873:23: note: in expansion of macro 'otx2_atomic64_add'
     873 |                 val = otx2_atomic64_add(incr, ptr);
         |                       ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:57: error: invalid use of void expression
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                         ^~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:873:23: note: in expansion of macro 'otx2_atomic64_add'
     873 |                 val = otx2_atomic64_add(incr, ptr);
         |                       ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h: In function 'otx2_aura_allocptr':
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:805:1: warning: control reaches end of non-void function [-Wreturn-type]
     805 | }
         | ^
--
   In file included from drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c:18:
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h: In function 'otx2_aura_allocptr':
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:52: warning: dereferencing 'void *' pointer
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ^
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:804:16: note: in expansion of macro 'otx2_atomic64_add'
     804 |         return otx2_atomic64_add(incr, ptr);
         |                ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:57: error: invalid use of void expression
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                         ^~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:804:16: note: in expansion of macro 'otx2_atomic64_add'
     804 |         return otx2_atomic64_add(incr, ptr);
         |                ^~~~~~~~~~~~~~~~~
--
   In file included from drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h:11,
                    from drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c:11:
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h: In function 'otx2_aura_allocptr':
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:52: warning: dereferencing 'void *' pointer
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ^
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:804:16: note: in expansion of macro 'otx2_atomic64_add'
     804 |         return otx2_atomic64_add(incr, ptr);
         |                ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:57: error: invalid use of void expression
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                         ^~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:804:16: note: in expansion of macro 'otx2_atomic64_add'
     804 |         return otx2_atomic64_add(incr, ptr);
         |                ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c: In function 'otx2_qos_sqb_flush':
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:52: warning: dereferencing 'void *' pointer
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
   drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c:159:15: note: in expansion of macro 'otx2_atomic64_add'
     159 |         val = otx2_atomic64_add(incr, ptr);
         |               ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:57: error: invalid use of void expression
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                         ^~
   drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c:159:15: note: in expansion of macro 'otx2_atomic64_add'
     159 |         val = otx2_atomic64_add(incr, ptr);
         |               ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h: In function 'otx2_aura_allocptr':
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:805:1: warning: control reaches end of non-void function [-Wreturn-type]
     805 | }
         | ^
--
   In file included from drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c:13:
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h: In function 'otx2_aura_allocptr':
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:52: warning: dereferencing 'void *' pointer
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ^
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:804:16: note: in expansion of macro 'otx2_atomic64_add'
     804 |         return otx2_atomic64_add(incr, ptr);
         |                ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:57: error: invalid use of void expression
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                         ^~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:804:16: note: in expansion of macro 'otx2_atomic64_add'
     804 |         return otx2_atomic64_add(incr, ptr);
         |                ^~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:805:1: warning: control reaches end of non-void function [-Wreturn-type]
     805 | }
         | ^


vim +751 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h

caa2da34fd25a3 Sunil Goutham     2020-01-27  748  
caa2da34fd25a3 Sunil Goutham     2020-01-27  749  #else
4c236d5dc8b862 Geetha sowjanya   2021-02-11  750  #define otx2_write128(lo, hi, addr)		writeq((hi) | (lo), addr)
caa2da34fd25a3 Sunil Goutham     2020-01-27 @751  #define otx2_atomic64_add(incr, ptr)		({ *ptr += incr; })
caa2da34fd25a3 Sunil Goutham     2020-01-27  752  #endif
caa2da34fd25a3 Sunil Goutham     2020-01-27  753  
4c236d5dc8b862 Geetha sowjanya   2021-02-11  754  static inline void __cn10k_aura_freeptr(struct otx2_nic *pfvf, u64 aura,
ef6c8da71eaffe Geetha sowjanya   2021-09-01  755  					u64 *ptrs, u64 num_ptrs)
4c236d5dc8b862 Geetha sowjanya   2021-02-11  756  {
ef6c8da71eaffe Geetha sowjanya   2021-09-01  757  	struct otx2_lmt_info *lmt_info;
4c236d5dc8b862 Geetha sowjanya   2021-02-11  758  	u64 size = 0, count_eot = 0;
4c236d5dc8b862 Geetha sowjanya   2021-02-11  759  	u64 tar_addr, val = 0;
4c236d5dc8b862 Geetha sowjanya   2021-02-11  760  
ef6c8da71eaffe Geetha sowjanya   2021-09-01  761  	lmt_info = per_cpu_ptr(pfvf->hw.lmt_info, smp_processor_id());
4c236d5dc8b862 Geetha sowjanya   2021-02-11  762  	tar_addr = (__force u64)otx2_get_regaddr(pfvf, NPA_LF_AURA_BATCH_FREE0);
4c236d5dc8b862 Geetha sowjanya   2021-02-11  763  	/* LMTID is same as AURA Id */
ef6c8da71eaffe Geetha sowjanya   2021-09-01  764  	val = (lmt_info->lmt_id & 0x7FF) | BIT_ULL(63);
4c236d5dc8b862 Geetha sowjanya   2021-02-11  765  	/* Set if [127:64] of last 128bit word has a valid pointer */
4c236d5dc8b862 Geetha sowjanya   2021-02-11  766  	count_eot = (num_ptrs % 2) ? 0ULL : 1ULL;
4c236d5dc8b862 Geetha sowjanya   2021-02-11  767  	/* Set AURA ID to free pointer */
4c236d5dc8b862 Geetha sowjanya   2021-02-11  768  	ptrs[0] = (count_eot << 32) | (aura & 0xFFFFF);
4c236d5dc8b862 Geetha sowjanya   2021-02-11  769  	/* Target address for LMTST flush tells HW how many 128bit
4c236d5dc8b862 Geetha sowjanya   2021-02-11  770  	 * words are valid from NPA_LF_AURA_BATCH_FREE0.
4c236d5dc8b862 Geetha sowjanya   2021-02-11  771  	 *
4c236d5dc8b862 Geetha sowjanya   2021-02-11  772  	 * tar_addr[6:4] is LMTST size-1 in units of 128b.
4c236d5dc8b862 Geetha sowjanya   2021-02-11  773  	 */
4c236d5dc8b862 Geetha sowjanya   2021-02-11  774  	if (num_ptrs > 2) {
4c236d5dc8b862 Geetha sowjanya   2021-02-11  775  		size = (sizeof(u64) * num_ptrs) / 16;
4c236d5dc8b862 Geetha sowjanya   2021-02-11  776  		if (!count_eot)
4c236d5dc8b862 Geetha sowjanya   2021-02-11  777  			size++;
4c236d5dc8b862 Geetha sowjanya   2021-02-11  778  		tar_addr |=  ((size - 1) & 0x7) << 4;
4c236d5dc8b862 Geetha sowjanya   2021-02-11  779  	}
c5d731c54a1767 Geetha sowjanya   2022-01-21  780  	dma_wmb();
ef6c8da71eaffe Geetha sowjanya   2021-09-01  781  	memcpy((u64 *)lmt_info->lmt_addr, ptrs, sizeof(u64) * num_ptrs);
4c236d5dc8b862 Geetha sowjanya   2021-02-11  782  	/* Perform LMTST flush */
4c236d5dc8b862 Geetha sowjanya   2021-02-11  783  	cn10k_lmt_flush(val, tar_addr);
4c236d5dc8b862 Geetha sowjanya   2021-02-11  784  }
4c236d5dc8b862 Geetha sowjanya   2021-02-11  785  
4c236d5dc8b862 Geetha sowjanya   2021-02-11  786  static inline void cn10k_aura_freeptr(void *dev, int aura, u64 buf)
4c236d5dc8b862 Geetha sowjanya   2021-02-11  787  {
4c236d5dc8b862 Geetha sowjanya   2021-02-11  788  	struct otx2_nic *pfvf = dev;
4c236d5dc8b862 Geetha sowjanya   2021-02-11  789  	u64 ptrs[2];
4c236d5dc8b862 Geetha sowjanya   2021-02-11  790  
4c236d5dc8b862 Geetha sowjanya   2021-02-11  791  	ptrs[1] = buf;
55ba18dc62deff Kevin Hao         2023-01-18  792  	get_cpu();
ef6c8da71eaffe Geetha sowjanya   2021-09-01  793  	/* Free only one buffer at time during init and teardown */
ef6c8da71eaffe Geetha sowjanya   2021-09-01  794  	__cn10k_aura_freeptr(pfvf, aura, ptrs, 2);
55ba18dc62deff Kevin Hao         2023-01-18  795  	put_cpu();
4c236d5dc8b862 Geetha sowjanya   2021-02-11  796  }
4c236d5dc8b862 Geetha sowjanya   2021-02-11  797  
caa2da34fd25a3 Sunil Goutham     2020-01-27  798  /* Alloc pointer from pool/aura */
caa2da34fd25a3 Sunil Goutham     2020-01-27  799  static inline u64 otx2_aura_allocptr(struct otx2_nic *pfvf, int aura)
caa2da34fd25a3 Sunil Goutham     2020-01-27  800  {
22f5790bc6ba33 Subbaraya Sundeep 2025-05-26  801  	void __iomem *ptr = otx2_get_regaddr(pfvf, NPA_LF_AURA_OP_ALLOCX(0));
caa2da34fd25a3 Sunil Goutham     2020-01-27  802  	u64 incr = (u64)aura | BIT_ULL(63);
caa2da34fd25a3 Sunil Goutham     2020-01-27  803  
caa2da34fd25a3 Sunil Goutham     2020-01-27 @804  	return otx2_atomic64_add(incr, ptr);
caa2da34fd25a3 Sunil Goutham     2020-01-27 @805  }
caa2da34fd25a3 Sunil Goutham     2020-01-27  806  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

