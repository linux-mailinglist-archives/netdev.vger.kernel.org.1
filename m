Return-Path: <netdev+bounces-142218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7A19BDD95
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 04:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5031F2427E
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 03:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842F319066D;
	Wed,  6 Nov 2024 03:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XjLkZ2Aj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF80419048A;
	Wed,  6 Nov 2024 03:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730863750; cv=none; b=Z4BGKBYMqAJW/bjByCxzWze4YQfbHFmwYjdCHWtBcOhD8Cn7P56BxRO1AeUeDGTpjKVAMYp0AJvvXFgRf9ROS79rH01X75RTjUtvu19oF6pY9MHoHOO/6QSoscwj8cLNbdaD1t6jthkdt7psOWThU5qt7/kT24faImruTBfN6GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730863750; c=relaxed/simple;
	bh=qC1wnd1WwW47fQVNwxJjJihB3ApMLG2UMI1x7ljhGu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXQy2xiDYAwKQgwwLZRXKRFZqXlAyo0pG3GXpDY6Ss+Mr5bQvt5X5TVXoFI0wNx3VnJjo/3r0Z85SCJGMGJ0b5b3xv6/QHiYA2G8wPA7lkH0iaFamjuWwQslAKhTO2+VzkT1zMzo1bRkV1HcfAl2dq/qv4iNgkX1i98JRJnrbN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XjLkZ2Aj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730863749; x=1762399749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qC1wnd1WwW47fQVNwxJjJihB3ApMLG2UMI1x7ljhGu8=;
  b=XjLkZ2Aj4cE77oDzieTyMXIV9Ae6bCYba8w9OZPJw3p5yyxkhSUNIC2f
   pCZo5eZgFegHN8awXzQMWUSM15yFGcH4HI9BbfnmZ1GZhs6Zi64mwYY0h
   KHixMcLKwDpOOKbQuWJ7E9ilto+BMmOI5ubXXKbhgFRMTQl5StsVBbOdg
   K4YwqzGuLWHs2Lu1VnUy7LOzLSTjZ/JgVfUze49bt0iMH7Mpnpsz2czR4
   e55qIwpeRW+DrmSb+F9XBEgYOUILVCYf2DJD7kWfJcRaMzzxxtQPjFeuA
   YeElh/jQR7oMZhQrr9FB4tmKAFh63KVw+L7UW4ThsRW2ybIxKZ9N8AsCQ
   Q==;
X-CSE-ConnectionGUID: 7PHUuiICSBKAtQFukx4EGQ==
X-CSE-MsgGUID: 7IkPjOfjSl2snCaxdJqsjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="41269991"
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="41269991"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 19:29:08 -0800
X-CSE-ConnectionGUID: o4ttEnRoTteCZ5MHOpisWQ==
X-CSE-MsgGUID: 0P0Yqix6TiK6L7VzCX4pjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="84694585"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 05 Nov 2024 19:29:04 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8Wj7-000mtG-0t;
	Wed, 06 Nov 2024 03:29:01 +0000
Date: Wed, 6 Nov 2024 11:29:00 +0800
From: kernel test robot <lkp@intel.com>
To: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, willemdebruijn.kernel@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org,
	antony.antony@secunet.com, steffen.klassert@secunet.com,
	linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com,
	jakub@cloudflare.com, fred.cc@alibaba-inc.com,
	yubing.qiuyubing@alibaba-inc.com
Subject: Re: [PATCH v7 net-next 4/4] ipv6/udp: Add 4-tuple hash for connected
 socket
Message-ID: <202411061155.g9trZ6rZ-lkp@intel.com>
References: <20241105121225.12513-5-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105121225.12513-5-lulie@linux.alibaba.com>

Hi Philo,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Philo-Lu/net-udp-Add-a-new-struct-for-hash2-slot/20241105-201454
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241105121225.12513-5-lulie%40linux.alibaba.com
patch subject: [PATCH v7 net-next 4/4] ipv6/udp: Add 4-tuple hash for connected socket
config: arc-randconfig-002-20241106 (https://download.01.org/0day-ci/archive/20241106/202411061155.g9trZ6rZ-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241106/202411061155.g9trZ6rZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411061155.g9trZ6rZ-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "udp_lib_hash4" [net/ipv6/ipv6.ko] undefined!
>> ERROR: modpost: "udp_ehashfn" [net/ipv6/ipv6.ko] undefined!
>> ERROR: modpost: "udp4_hash4" [net/ipv6/ipv6.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

