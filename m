Return-Path: <netdev+bounces-192506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0256AC0289
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 04:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2BE1BC1653
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 02:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ED98635E;
	Thu, 22 May 2025 02:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJuBuVqf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3743535D8
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 02:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747881589; cv=none; b=PruGSDBXPdcRp7CvKPDTM8SD0NwHC+l1djls+kEhGVSBcr+fOnfgD3XTmMGPx+mBSOE4G/Zzhefd4nwlph9bpifTuNnIOdkUsTgNVOf9Ztu+ulH/W0WOUhhum4C54qrF3bRwB+tU3mQt/7HvcT6hVSeeNZPQmPRh2yTw+AhP8gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747881589; c=relaxed/simple;
	bh=phKHx9/7oTeLSJAqcd2GF16+Sb91wgmoZ1J7S96RqfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Th22+vSaVaP9X9BGwUdkQ4USnlolCTfMdPcDpiubynHrEU2+bmme2yGCVfgrWdVvx19cUs0jdZN93oWRQw3GcKHFNGj2fJtOljfuNqfVU+x3m2xTJeqOyPE/sRhi2yW9sf2JIkSy8SPJCoKRRQpr9HpaaVTO126bFUzrqqi/wYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJuBuVqf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747881587; x=1779417587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=phKHx9/7oTeLSJAqcd2GF16+Sb91wgmoZ1J7S96RqfI=;
  b=OJuBuVqfXvVeLbatGp/3xiEu4iESwvVhLOfOK3gCiJqtnfMHPvbqYp4B
   mYqxE0r3y7pJQ5cPYLgmXk+9lq2G+FlqmvDVTxRBLZu9NWNsmfCuNC8GS
   kZnr+9KzVbuezx4sWz3fuIN7R5X+JmMbdOOnEFBW+v0TDxkmzWdk41TAN
   IOaqD50Q7dN+yk9IEw1w5nq7mQ3rdZvGCjjV8zzkR972u1kGnRXqKUFIB
   upqxknmXFIGZhk6PsMSfTE+L0CutStYLe7dbnv28y+1w1QUtd/4GFe+ZN
   k0VWu6KMKFYop4T8U1km3Lm1Nr4JEAaemKBG8XUd3Eyg49V6o88PE+cri
   Q==;
X-CSE-ConnectionGUID: SVfCpXFiT+m5MWYA7ZgYIw==
X-CSE-MsgGUID: xErNm7BpStWCXWAqI4cY8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="53685024"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="53685024"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 19:39:46 -0700
X-CSE-ConnectionGUID: QAGoGIXEQUismPKRQwrypA==
X-CSE-MsgGUID: gP37IznOTAuktSxZxhxCfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="163633867"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 21 May 2025 19:39:44 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHvqP-000Oqo-1N;
	Thu, 22 May 2025 02:39:41 +0000
Date: Thu, 22 May 2025 10:39:12 +0800
From: kernel test robot <lkp@intel.com>
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Sabrina Dubroca <sd@queasysnail.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Antonio Quartulli <antonio@openvpn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH net-next 1/3] ovpn: properly deconfigure UDP-tunnel
Message-ID: <202505221029.XIguAT57-lkp@intel.com>
References: <20250520233937.5161-2-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520233937.5161-2-antonio@openvpn.net>

Hi Antonio,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Antonio-Quartulli/ovpn-properly-deconfigure-UDP-tunnel/20250521-081355
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250520233937.5161-2-antonio%40openvpn.net
patch subject: [PATCH net-next 1/3] ovpn: properly deconfigure UDP-tunnel
config: sparc-randconfig-001-20250522 (https://download.01.org/0day-ci/archive/20250522/202505221029.XIguAT57-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250522/202505221029.XIguAT57-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505221029.XIguAT57-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc-linux-ld: net/ipv4/udp_tunnel_core.o: in function `cleanup_udp_tunnel_sock':
>> net/ipv4/udp_tunnel_core.c:122:(.text+0x880): undefined reference to `udpv6_encap_disable'


vim +122 net/ipv4/udp_tunnel_core.c

   100	
   101	void cleanup_udp_tunnel_sock(struct sock *sk)
   102	{
   103		/* Re-enable multicast loopback */
   104		inet_set_bit(MC_LOOP, sk);
   105	
   106		/* Disable CHECKSUM_UNNECESSARY to CHECKSUM_COMPLETE conversion */
   107		inet_dec_convert_csum(sk);
   108	
   109		rcu_assign_sk_user_data(sk, NULL);
   110	
   111		udp_sk(sk)->encap_type = 0;
   112		udp_sk(sk)->encap_rcv = NULL;
   113		udp_sk(sk)->encap_err_rcv = NULL;
   114		udp_sk(sk)->encap_err_lookup = NULL;
   115		udp_sk(sk)->encap_destroy = NULL;
   116		udp_sk(sk)->gro_receive = NULL;
   117		udp_sk(sk)->gro_complete = NULL;
   118	
   119		udp_clear_bit(ENCAP_ENABLED, sk);
   120	#if IS_ENABLED(CONFIG_IPV6)
   121		if (READ_ONCE(sk->sk_family) == PF_INET6)
 > 122			udpv6_encap_disable();
   123	#endif
   124		udp_encap_disable();
   125		udp_tunnel_cleanup_gro(sk);
   126	}
   127	EXPORT_SYMBOL_GPL(cleanup_udp_tunnel_sock);
   128	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

