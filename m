Return-Path: <netdev+bounces-156789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F85A07D60
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75EAC3A06BE
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B8121D5B0;
	Thu,  9 Jan 2025 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cyZq0yg0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C93721A45C
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439753; cv=none; b=r8wZsA0epUVTNVW1TelZWNyR6RIx2KMt/TnUQ3zJ6GhBARcC/KAHumt4Us5BhjSb/KQVAjD3F9ReVRD5vw/IBfErUPkSyv0E+T6i9xrrKcqripoMqiy+JTi1DmK8isJKacDmiKnIkgvRwEyAziTS2g0EaMWCcqYRQYs9QqFdAaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439753; c=relaxed/simple;
	bh=slClvMRLksGJnHOC5mmlvtCDQJdDqdhjqWVObxG4H8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqN9Em9hnOnB2l030IWOD9eTRRDY+Oay9B7XhzOdgdlIKUS8dwd93dJPtkWOPpVpFq9TsxpRYW7brBC1PkGBB333sPw+dLWWiNAHP023aFyuPPmNUgnOlNmL2gvUMTSmWNglmFvdDq2rzitofBtIfHyhZFEocGtyV6xTjvo05m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cyZq0yg0; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736439750; x=1767975750;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=slClvMRLksGJnHOC5mmlvtCDQJdDqdhjqWVObxG4H8Y=;
  b=cyZq0yg03lnfnuRGs7ufT/Ajf7szOFCHZmvJu8L4Pu7oJp6zq/9Gy2I7
   higaJwIztSW5qYsxke4V5dcnDeZFG1iuuyyGTw+CYQ+FakwZtzYSmOqCA
   t0mfDYvX7Pbx15wHMaR/2MoKro1Idwny8y4txrzOoiQBu8Vy5TLrecKlx
   vDSr+vWPu9yZPEpgblGpG/P9IRu+UixlfrPu16q4k/mvckqh0FAF/6USk
   oz1isInrBBAj6bGHNglMvBDBrQRX9Uf+BYJaLs0vu6zo4Myf7X22T++Su
   WWJ6qtC1GN5VK3rzJaIQ8SmEPqZKXmG7KagFLwA+/fl4Cx5RZZYshl+4t
   A==;
X-CSE-ConnectionGUID: r2EbFU3gQCm+LJV3xPGzDA==
X-CSE-MsgGUID: dr+RQVKFR5KPgDhYKuJeuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="39536562"
X-IronPort-AV: E=Sophos;i="6.12,301,1728975600"; 
   d="scan'208";a="39536562"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 08:22:29 -0800
X-CSE-ConnectionGUID: 45uewqfnRLiPAp4NRhb0vA==
X-CSE-MsgGUID: 86M+42S8QpOS9HE13+5Pfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107495899"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 Jan 2025 08:22:28 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tVvIf-000Hov-14;
	Thu, 09 Jan 2025 16:22:25 +0000
Date: Fri, 10 Jan 2025 00:21:36 +0800
From: kernel test robot <lkp@intel.com>
To: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, willemdebruijn.kernel@gmail.com,
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net] udp: Make rehash4 independent in udp_lib_rehash()
Message-ID: <202501100021.rFUCRD3l-lkp@intel.com>
References: <20250108114321.128249-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108114321.128249-1-lulie@linux.alibaba.com>

Hi Philo,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Philo-Lu/udp-Make-rehash4-independent-in-udp_lib_rehash/20250108-194559
base:   net/main
patch link:    https://lore.kernel.org/r/20250108114321.128249-1-lulie%40linux.alibaba.com
patch subject: [PATCH net] udp: Make rehash4 independent in udp_lib_rehash()
config: openrisc-randconfig-r073-20250109 (https://download.01.org/0day-ci/archive/20250110/202501100021.rFUCRD3l-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250110/202501100021.rFUCRD3l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501100021.rFUCRD3l-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   net/ipv4/udp.c: In function 'udp_lib_rehash':
>> net/ipv4/udp.c:2187:58: error: 'struct udp_sock' has no member named 'udp_lrpa_hash'
    2187 |                                                udp_sk(sk)->udp_lrpa_hash);
         |                                                          ^~
   net/ipv4/udp.c:2189:35: error: 'struct udp_sock' has no member named 'udp_lrpa_hash'
    2189 |                         udp_sk(sk)->udp_lrpa_hash = newhash4;
         |                                   ^~
>> net/ipv4/udp.c:2194:69: error: 'struct udp_sock' has no member named 'udp_lrpa_node'
    2194 |                                 hlist_nulls_del_init_rcu(&udp_sk(sk)->udp_lrpa_node);
         |                                                                     ^~
   net/ipv4/udp.c:2199:69: error: 'struct udp_sock' has no member named 'udp_lrpa_node'
    2199 |                                 hlist_nulls_add_head_rcu(&udp_sk(sk)->udp_lrpa_node,
         |                                                                     ^~
   net/ipv4/udp.c: At top level:
>> net/ipv4/udp.c:491:13: warning: 'udp_rehash4' defined but not used [-Wunused-function]
     491 | static void udp_rehash4(struct udp_table *udptable, struct sock *sk,
         |             ^~~~~~~~~~~


vim +2187 net/ipv4/udp.c

  2140	
  2141	/*
  2142	 * inet_rcv_saddr was changed, we must rehash secondary hash
  2143	 */
  2144	void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
  2145	{
  2146		if (sk_hashed(sk)) {
  2147			struct udp_hslot *hslot, *hslot2, *nhslot2, *hslot4, *nhslot4;
  2148			struct udp_table *udptable = udp_get_table_prot(sk);
  2149	
  2150			hslot = udp_hashslot(udptable, sock_net(sk),
  2151					     udp_sk(sk)->udp_port_hash);
  2152			hslot2 = udp_hashslot2(udptable, udp_sk(sk)->udp_portaddr_hash);
  2153			nhslot2 = udp_hashslot2(udptable, newhash);
  2154			udp_sk(sk)->udp_portaddr_hash = newhash;
  2155	
  2156			if (hslot2 != nhslot2 ||
  2157			    rcu_access_pointer(sk->sk_reuseport_cb)) {
  2158				/* we must lock primary chain too */
  2159				spin_lock_bh(&hslot->lock);
  2160				if (rcu_access_pointer(sk->sk_reuseport_cb))
  2161					reuseport_detach_sock(sk);
  2162	
  2163				if (hslot2 != nhslot2) {
  2164					spin_lock(&hslot2->lock);
  2165					hlist_del_init_rcu(&udp_sk(sk)->udp_portaddr_node);
  2166					hslot2->count--;
  2167					spin_unlock(&hslot2->lock);
  2168	
  2169					spin_lock(&nhslot2->lock);
  2170					hlist_add_head_rcu(&udp_sk(sk)->udp_portaddr_node,
  2171								 &nhslot2->head);
  2172					nhslot2->count++;
  2173					spin_unlock(&nhslot2->lock);
  2174				}
  2175	
  2176				spin_unlock_bh(&hslot->lock);
  2177			}
  2178	
  2179			/* Now process hash4 if necessary:
  2180			 * (1) update hslot4;
  2181			 * (2) update hslot2->hash4_cnt.
  2182			 * Note that hslot2/hslot4 should be checked separately, as
  2183			 * either of them may change with the other unchanged.
  2184			 */
  2185			if (udp_hashed4(sk)) {
  2186				hslot4 = udp_hashslot4(udptable,
> 2187						       udp_sk(sk)->udp_lrpa_hash);
  2188				nhslot4 = udp_hashslot4(udptable, newhash4);
  2189				udp_sk(sk)->udp_lrpa_hash = newhash4;
  2190	
  2191				spin_lock_bh(&hslot->lock);
  2192				if (hslot4 != nhslot4) {
  2193					spin_lock(&hslot4->lock);
> 2194					hlist_nulls_del_init_rcu(&udp_sk(sk)->udp_lrpa_node);
  2195					hslot4->count--;
  2196					spin_unlock(&hslot4->lock);
  2197	
  2198					spin_lock(&nhslot4->lock);
  2199					hlist_nulls_add_head_rcu(&udp_sk(sk)->udp_lrpa_node,
  2200								 &nhslot4->nulls_head);
  2201					nhslot4->count++;
  2202					spin_unlock(&nhslot4->lock);
  2203				}
  2204	
  2205				if (hslot2 != nhslot2) {
  2206					spin_lock(&hslot2->lock);
  2207					udp_hash4_dec(hslot2);
  2208					spin_unlock(&hslot2->lock);
  2209	
  2210					spin_lock(&nhslot2->lock);
  2211					udp_hash4_inc(nhslot2);
  2212					spin_unlock(&nhslot2->lock);
  2213				}
  2214				spin_unlock_bh(&hslot->lock);
  2215			}
  2216		}
  2217	}
  2218	EXPORT_SYMBOL(udp_lib_rehash);
  2219	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

