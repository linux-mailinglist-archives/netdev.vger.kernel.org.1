Return-Path: <netdev+bounces-81991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC1E88C04C
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 12:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD1F1F36F94
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33D23EA90;
	Tue, 26 Mar 2024 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WiSRK5vm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBBF14AB8
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 11:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451582; cv=none; b=Up97kGslZtTUdbSBYaJqThCaLfw2xQrKTZe/8Yt1+D0gxPhKCBji5e2heaQWeqG65IzMUY4EXjK/VRe4ly8tfuR1cvorzfBTaMhNHDJjhfQOvJevt7kQb3Hf8FOGZVZAPTh/+encaH8rdcnH0XWp5vTILjjiL7WtIg9bkokBjCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451582; c=relaxed/simple;
	bh=K/jjWGwDddPYSsUMpDxNJxL3gxVe+J5waRLRWI3JsoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLWLzUGshlJs6+O9TkVz/C4NCG9ICkvsxtnc1uW15kkFJTWwfG0iC0rsbL5tgvK9MqbBZnJYNT6S5e3EOHVsH2TaIPQ4ha/io1EIEabHzyuWAZmEoDmI9J7Ao3V61lvpTFekS/NjtwUGfXUIHGj54mclNKu3CB3/RKQdAnAjHxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WiSRK5vm; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711451581; x=1742987581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K/jjWGwDddPYSsUMpDxNJxL3gxVe+J5waRLRWI3JsoY=;
  b=WiSRK5vmtAdaT3qNsQx3T4PpBBegE0rfZxYnGKQZVGvi/hBv6CT69t54
   zbpkrXpPUDMh4i9ooSAJ4mpuXDFR+NBxAs9gKVNQzc7gmf8hDTvun/bjy
   whu4X0b1P5+d4R4KHGGj1GFt9FssOLdosMO1JYYUrKrMVPtkzGsLxPZCJ
   /BX2dX1RVuuEbgYw+w+UGnhCvQjmvLibKjvzyRrixvOF+UynulkIwnna1
   2GpBhvC8yUjQ7YyZzeLY3jwkGxNrE/dX6Xuj9429tHqa+Po4YZX0UR1IG
   14GlR32k0pxrTEbiRsukdk7zpi5ySonBVdJgwZrjwkujfq9myl/RpO616
   w==;
X-CSE-ConnectionGUID: 0ySrLWQ+ThWeXyOpOnZyxQ==
X-CSE-MsgGUID: fqr26iQuRr6ZkMWOFS293Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6327397"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6327397"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 04:12:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="15903463"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 26 Mar 2024 04:12:55 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rp4jd-000NK8-27;
	Tue, 26 Mar 2024 11:12:53 +0000
Date: Tue, 26 Mar 2024 19:11:56 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>,
	Jianguo Wu <wujianguo106@163.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v1 net 1/8] tcp: Fix bind() regression for v6-only
 wildcard and v4-mapped-v6 non-wildcard addresses.
Message-ID: <202403261821.5fkObY55-lkp@intel.com>
References: <20240325181923.48769-2-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325181923.48769-2-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/tcp-Fix-bind-regression-for-v6-only-wildcard-and-v4-mapped-v6-non-wildcard-addresses/20240326-024257
base:   net/main
patch link:    https://lore.kernel.org/r/20240325181923.48769-2-kuniyu%40amazon.com
patch subject: [PATCH v1 net 1/8] tcp: Fix bind() regression for v6-only wildcard and v4-mapped-v6 non-wildcard addresses.
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20240326/202403261821.5fkObY55-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240326/202403261821.5fkObY55-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403261821.5fkObY55-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/ipv4/inet_connection_sock.c:207:59: error: no member named 'skc_v6_rcv_saddr' in 'struct sock_common'; did you mean 'skc_rcv_saddr'?
     207 |             (sk->sk_family == AF_INET || ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr)))
         |                                                                  ^
   include/net/sock.h:375:37: note: expanded from macro 'sk_v6_rcv_saddr'
     375 | #define sk_v6_rcv_saddr __sk_common.skc_v6_rcv_saddr
         |                                     ^
   include/net/sock.h:155:11: note: 'skc_rcv_saddr' declared here
     155 |                         __be32  skc_rcv_saddr;
         |                                 ^
   1 error generated.


vim +207 net/ipv4/inet_connection_sock.c

   201	
   202	static bool __inet_bhash2_conflict(const struct sock *sk, struct sock *sk2,
   203					   kuid_t sk_uid, bool relax,
   204					   bool reuseport_cb_ok, bool reuseport_ok)
   205	{
   206		if (ipv6_only_sock(sk2) &&
 > 207		    (sk->sk_family == AF_INET || ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr)))
   208			return false;
   209	
   210		return inet_bind_conflict(sk, sk2, sk_uid, relax,
   211					  reuseport_cb_ok, reuseport_ok);
   212	}
   213	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

