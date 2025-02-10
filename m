Return-Path: <netdev+bounces-164704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98844A2EC65
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 13:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0E9165CC9
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6721F790B;
	Mon, 10 Feb 2025 12:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SkhThR/j"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBFD1F63D9
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739190137; cv=none; b=Ip3qUyLQ5jm5gBfE1sN6J2U3BIvXvpfZgr1i73r7HzgJmpBT2Bnzy/wYblO1H2Rn4tIAqIfe1opRZFAZf18JH8aOz26gUF5uS6OQgbZuYUIIEGGacKE/na08TFsPmLMMb9lOxPx2qOJalN1DIo0hKogr7pXusC4P6XDcGHhPSG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739190137; c=relaxed/simple;
	bh=50lo+NS4m5x2uDlPQZ8aQ3mcL/1ULcSrRyXwyJXV3R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqk4tHB3tbLPcrw6y2s2zi9IcZeY6boYLHr31+rzl2z/Wh7Yj8m9uhWOejO0Jeh9mdETTCOYj9enSnlSsXGCwXB0Q19xkVc0q/bb77N0VkupmrTnJV+YD6ryj6xr5H1pjiJM/5vujwqyBkL+Fqr0UGYCIwBkRtMks8DXOSWN1tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SkhThR/j; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739190136; x=1770726136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=50lo+NS4m5x2uDlPQZ8aQ3mcL/1ULcSrRyXwyJXV3R8=;
  b=SkhThR/jQAB/kti8A/Wk2DIvrHCG6RK1W1cuH6NfwfMFk0h/dFr4dqKk
   EPK3BBjXavC5L6qtevxWsO7SXSOKFS2JZA76/Z5Pet1zZd+XE2kotTVEN
   KOkcz1hXuBiZWEJwCTsegYoQXgKce01lYcT5+PvBJCEErIvimbAwthoiV
   GdrOy7MWktTw6pUOTf53ljvX5EFrQ4wKN2A88u5hkwvaYn2o9bMjtXeeP
   ZJ6ufOWUWMkFk04G3OXs6eWoIVCOP0KOMPEV1R+B3EFJytYuTnYKLDY17
   GT+0AhLN7P8UCy9AJrlPsB6ZZ+tmGuvJgPExpU8wZxf6bX0rfIwewN77k
   g==;
X-CSE-ConnectionGUID: uwTrVwzESOeIARekXxh0UA==
X-CSE-MsgGUID: SRtT5FizRlORPaZNPPBnTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="42607669"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="42607669"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 04:22:15 -0800
X-CSE-ConnectionGUID: 6OZZDLepRRekYF51AlHpDw==
X-CSE-MsgGUID: 5oFox5N0Q4+ifotWdID6HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="135423823"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 10 Feb 2025 04:22:12 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1thSni-0012jT-1i;
	Mon, 10 Feb 2025 12:22:10 +0000
Date: Mon, 10 Feb 2025 20:21:22 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 3/4] tcp: use EXPORT_IPV6_MOD[_GPL]()
Message-ID: <202502102052.AL2TIjxx-lkp@intel.com>
References: <20250210082805.465241-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210082805.465241-4-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-introduce-EXPORT_IPV6_MOD-and-EXPORT_IPV6_MOD_GPL/20250210-163000
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250210082805.465241-4-edumazet%40google.com
patch subject: [PATCH net-next 3/4] tcp: use EXPORT_IPV6_MOD[_GPL]()
config: i386-buildonly-randconfig-002-20250210 (https://download.01.org/0day-ci/archive/20250210/202502102052.AL2TIjxx-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250210/202502102052.AL2TIjxx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502102052.AL2TIjxx-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in fs/exportfs/exportfs.o
>> ERROR: modpost: "tcp_memory_pressure" [net/tls/tls.ko] undefined!
>> ERROR: modpost: "tcp_poll" [net/tls/tls.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

