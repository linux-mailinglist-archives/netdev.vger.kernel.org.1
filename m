Return-Path: <netdev+bounces-168205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA195A3E1A2
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 17:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09EC863503
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC0E214A97;
	Thu, 20 Feb 2025 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K524BASU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03062214803;
	Thu, 20 Feb 2025 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070223; cv=none; b=kk/0tx2y5TQFajYEnUsx7divRGJOilyGuLt74IvNl8b7Dt+qO/2c/HLtCyNEkfKyYOR940LF0lz30gC7CbD5wKNYmtQotSBFGnV+6QnHzMmwejI7qWobQcd5sh8oytisyizw4788zIZ4b2N4Sq8UjKXAJLKfCzmV7Kv+HWpI7cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070223; c=relaxed/simple;
	bh=rUnSm1CHBOZ8g5EsPwsntxRI3qbpAPNrKv7/VWM6RoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cX9X86uH6liwMQM2kAPmHYyxd4C4SgrfI4cRr/TO88aCo4K2+aZJDEfJ3whEJJtOI7Qc9/+f7fleeAGdQeUxce/w/N02F8Pn69uXTzK9lYZWr1cXSpn6P7/OKT7cZsFVcxJqbr5R34cJHKZZXQ4JZKmsPHPhGJXXejGAIogvycE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K524BASU; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740070222; x=1771606222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rUnSm1CHBOZ8g5EsPwsntxRI3qbpAPNrKv7/VWM6RoY=;
  b=K524BASUI/S0WbcKCFa1/3D0Q2+fjoq+3T9SpucNjwsjIybUZqFjopjY
   ANYxtDtWtTYIssjjB3LTgtESbd6vzouHd01Edzoj6mgq3FYMllxi4kgRU
   MgiBaiK4zZfH5GottRJONkmJwtORDPa92b8LqKXAiTMRQg2fjR1elSiQa
   IwK0qJaPuXtaTZmrWbKkqnYG3Kz5j+WZSO7aUK70Rj2lyfaSiI+MBKBXc
   jfZiLYmpHc7BwxMGKKazpuldFA50s4eAlpNMprMIa7rBe21rEB/IxlmTf
   3Ru6EXrQsNxGWWNAUUBP0DhCqYX962drXaF8H8rC+DbMD+fqX5uwpyp9O
   A==;
X-CSE-ConnectionGUID: y+frKJM+Qc26pu/R/aiwTA==
X-CSE-MsgGUID: zCDOosf8QiiTaoPgmYDbew==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52292193"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52292193"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 08:50:21 -0800
X-CSE-ConnectionGUID: 3Zyn0mScTl2y3B3P+rYNXQ==
X-CSE-MsgGUID: cDJKx+U1RqmAtuBofdVP0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="120196006"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 20 Feb 2025 08:50:18 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tl9jq-0004Wh-1F;
	Thu, 20 Feb 2025 16:49:44 +0000
Date: Fri, 21 Feb 2025 00:49:02 +0800
From: kernel test robot <lkp@intel.com>
To: Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>
Subject: Re: [PATCH net-next 2/2] net: hsr: Add KUnit test for PRP
Message-ID: <202502210240.ZO6FLmH9-lkp@intel.com>
References: <20250219124831.544318-2-jaakko.karrenpalo@fi.abb.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219124831.544318-2-jaakko.karrenpalo@fi.abb.com>

Hi Jaakko,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jaakko-Karrenpalo/net-hsr-Add-KUnit-test-for-PRP/20250219-205153
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250219124831.544318-2-jaakko.karrenpalo%40fi.abb.com
patch subject: [PATCH net-next 2/2] net: hsr: Add KUnit test for PRP
config: riscv-randconfig-001-20250220 (https://download.01.org/0day-ci/archive/20250221/202502210240.ZO6FLmH9-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250221/202502210240.ZO6FLmH9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502210240.ZO6FLmH9-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in net/hsr/prp_dup_discard_test.o
>> ERROR: modpost: "prp_register_frame_out" [net/hsr/prp_dup_discard_test.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

