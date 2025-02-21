Return-Path: <netdev+bounces-168499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4168CA3F2A0
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 12:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19ADA175056
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 11:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ACC20766F;
	Fri, 21 Feb 2025 11:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VsuFwFTr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1548D204F87
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 11:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740135819; cv=none; b=eyjlfsbTRNjJj+zqEWx/sxwJruSASx5F72it41C/t84fKvcxyB86qBIi9KU1MmB3EIN6ZNQ1dJYgZhc6OGQJjFvr5jOWn/B9KqLhTNtG6rbKY7sUACCp6ElmsYMDsLfc245A0S9zOf1lTCa6yRvZvaMcei8/1RmjoYdnCL/ocS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740135819; c=relaxed/simple;
	bh=snnEVPABr213rxG2cZJJ4jzivrBdGZfw43MRyOP2wIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKOsEPN/VByNF2y83MGPszVVn52XNa3uh34cU5Ov1IQHcTB0IUfJLcu+VTtGXdbXy9pisif3C7Jqg2JDFN0E12ljnKPsYtkQbUiHfPq6+uk9p8482Tz5FTPgvk8vlR/I1SzfKIFwHlGUIC6Rmdb3aHJ4K2BXfOjiDHq2RazCQME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VsuFwFTr; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740135818; x=1771671818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=snnEVPABr213rxG2cZJJ4jzivrBdGZfw43MRyOP2wIg=;
  b=VsuFwFTrCHMdT2lwgZmqYtpPwWBL5KFvm97BGg1PlH01DfyvgihA6bjN
   xwql24YYo5qCyb/ZPhhfM87irr6IZVA4eQ9SK7FCjGbmiuvW9K+bjTFqf
   4kL+ROsRPqqm/QQmTqKPEJov3yIVaWZL3YnE7zNxRBlPXVo9lPwVT+nJZ
   9/2690SUc/2VYEVC+ssEAx+KcyM4cKY1RPpRBbCe+sVzqeaJGb/0B6NY3
   s9AoMIkUzcv1nL9oatI0fd+KrEdS8kdjsDQZJJvrLt3gSi6RZsJQPU+Sf
   eQ7ZPZCd1FzI7c6tz5qTmjfVRjmKlLHoF01UDPPe5OSfbBDQO+tg5FhVB
   A==;
X-CSE-ConnectionGUID: 393buS+pRiKMMGSyirnj3g==
X-CSE-MsgGUID: PGQ3t9q5Sta0GActtI3u+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40142646"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="40142646"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 03:03:37 -0800
X-CSE-ConnectionGUID: fz8xbawGRyyLu3xx341crQ==
X-CSE-MsgGUID: d8+RGgAOQXCmONOaRA+BXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115839992"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 21 Feb 2025 03:03:35 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlQoe-0005QJ-1d;
	Fri, 21 Feb 2025 11:03:32 +0000
Date: Fri, 21 Feb 2025 19:02:44 +0800
From: kernel test robot <lkp@intel.com>
To: Chiachang Wang <chiachangwang@google.com>
Cc: oe-kbuild-all@lists.linux.dev, leonro@nvidia.com,
	netdev@vger.kernel.org, stanleyjhu@google.com,
	steffen.klassert@secunet.com, yumike@google.com
Subject: Re: [PATCH ipsec v2 1/1] xfrm: Migrate offload configuration
Message-ID: <202502211807.52eely9f-lkp@intel.com>
References: <20250220073515.3177296-2-chiachangwang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220073515.3177296-2-chiachangwang@google.com>

Hi Chiachang,

kernel test robot noticed the following build errors:

[auto build test ERROR on klassert-ipsec-next/master]
[also build test ERROR on linus/master v6.14-rc3 next-20250221]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chiachang-Wang/xfrm-Migrate-offload-configuration/20250220-153752
base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
patch link:    https://lore.kernel.org/r/20250220073515.3177296-2-chiachangwang%40google.com
patch subject: [PATCH ipsec v2 1/1] xfrm: Migrate offload configuration
config: i386-buildonly-randconfig-004-20250221 (https://download.01.org/0day-ci/archive/20250221/202502211807.52eely9f-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250221/202502211807.52eely9f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502211807.52eely9f-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/key/af_key.c: In function 'pfkey_migrate':
>> net/key/af_key.c:2632:16: error: too few arguments to function 'xfrm_migrate'
    2632 |         return xfrm_migrate(&sel, dir, XFRM_POLICY_TYPE_MAIN, m, i,
         |                ^~~~~~~~~~~~
   In file included from net/key/af_key.c:28:
   include/net/xfrm.h:1883:5: note: declared here
    1883 | int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
         |     ^~~~~~~~~~~~


vim +/xfrm_migrate +2632 net/key/af_key.c

08de61beab8a21c Shinta Sugimoto   2007-02-08  2546  
08de61beab8a21c Shinta Sugimoto   2007-02-08  2547  static int pfkey_migrate(struct sock *sk, struct sk_buff *skb,
4c93fbb0626080d David S. Miller   2011-02-25  2548  			 const struct sadb_msg *hdr, void * const *ext_hdrs)
08de61beab8a21c Shinta Sugimoto   2007-02-08  2549  {
08de61beab8a21c Shinta Sugimoto   2007-02-08  2550  	int i, len, ret, err = -EINVAL;
08de61beab8a21c Shinta Sugimoto   2007-02-08  2551  	u8 dir;
08de61beab8a21c Shinta Sugimoto   2007-02-08  2552  	struct sadb_address *sa;
13c1d18931ebb5c Arnaud Ebalard    2008-10-05  2553  	struct sadb_x_kmaddress *kma;
08de61beab8a21c Shinta Sugimoto   2007-02-08  2554  	struct sadb_x_policy *pol;
08de61beab8a21c Shinta Sugimoto   2007-02-08  2555  	struct sadb_x_ipsecrequest *rq;
08de61beab8a21c Shinta Sugimoto   2007-02-08  2556  	struct xfrm_selector sel;
08de61beab8a21c Shinta Sugimoto   2007-02-08  2557  	struct xfrm_migrate m[XFRM_MAX_DEPTH];
13c1d18931ebb5c Arnaud Ebalard    2008-10-05  2558  	struct xfrm_kmaddress k;
8d549c4f5d92d80 Fan Du            2013-11-07  2559  	struct net *net = sock_net(sk);
08de61beab8a21c Shinta Sugimoto   2007-02-08  2560  
08de61beab8a21c Shinta Sugimoto   2007-02-08  2561  	if (!present_and_same_family(ext_hdrs[SADB_EXT_ADDRESS_SRC - 1],
08de61beab8a21c Shinta Sugimoto   2007-02-08  2562  				     ext_hdrs[SADB_EXT_ADDRESS_DST - 1]) ||
08de61beab8a21c Shinta Sugimoto   2007-02-08  2563  	    !ext_hdrs[SADB_X_EXT_POLICY - 1]) {
08de61beab8a21c Shinta Sugimoto   2007-02-08  2564  		err = -EINVAL;
08de61beab8a21c Shinta Sugimoto   2007-02-08  2565  		goto out;
08de61beab8a21c Shinta Sugimoto   2007-02-08  2566  	}
08de61beab8a21c Shinta Sugimoto   2007-02-08  2567  
13c1d18931ebb5c Arnaud Ebalard    2008-10-05  2568  	kma = ext_hdrs[SADB_X_EXT_KMADDRESS - 1];
08de61beab8a21c Shinta Sugimoto   2007-02-08  2569  	pol = ext_hdrs[SADB_X_EXT_POLICY - 1];
13c1d18931ebb5c Arnaud Ebalard    2008-10-05  2570  
13c1d18931ebb5c Arnaud Ebalard    2008-10-05  2571  	if (pol->sadb_x_policy_dir >= IPSEC_DIR_MAX) {
08de61beab8a21c Shinta Sugimoto   2007-02-08  2572  		err = -EINVAL;
08de61beab8a21c Shinta Sugimoto   2007-02-08  2573  		goto out;
08de61beab8a21c Shinta Sugimoto   2007-02-08  2574  	}
08de61beab8a21c Shinta Sugimoto   2007-02-08  2575  
13c1d18931ebb5c Arnaud Ebalard    2008-10-05  2576  	if (kma) {
13c1d18931ebb5c Arnaud Ebalard    2008-10-05  2577  		/* convert sadb_x_kmaddress to xfrm_kmaddress */
13c1d18931ebb5c Arnaud Ebalard    2008-10-05  2578  		k.reserved = kma->sadb_x_kmaddress_reserved;
13c1d18931ebb5c Arnaud Ebalard    2008-10-05  2579  		ret = parse_sockaddr_pair((struct sockaddr *)(kma + 1),
13c1d18931ebb5c Arnaud Ebalard    2008-10-05  2580  					  8*(kma->sadb_x_kmaddress_len) - sizeof(*kma),
13c1d18931ebb5c Arnaud Ebalard    2008-10-05  2581  					  &k.local, &k.remote, &k.family);
13c1d18931ebb5c Arnaud Ebalard    2008-10-05  2582  		if (ret < 0) {
13c1d18931ebb5c Arnaud Ebalard    2008-10-05  2583  			err = ret;
08de61beab8a21c Shinta Sugimoto   2007-02-08  2584  			goto out;
08de61beab8a21c Shinta Sugimoto   2007-02-08  2585  		}
13c1d18931ebb5c Arnaud Ebalard    2008-10-05  2586  	}
08de61beab8a21c Shinta Sugimoto   2007-02-08  2587  
08de61beab8a21c Shinta Sugimoto   2007-02-08  2588  	dir = pol->sadb_x_policy_dir - 1;
08de61beab8a21c Shinta Sugimoto   2007-02-08  2589  	memset(&sel, 0, sizeof(sel));
08de61beab8a21c Shinta Sugimoto   2007-02-08  2590  
08de61beab8a21c Shinta Sugimoto   2007-02-08  2591  	/* set source address info of selector */
08de61beab8a21c Shinta Sugimoto   2007-02-08  2592  	sa = ext_hdrs[SADB_EXT_ADDRESS_SRC - 1];
08de61beab8a21c Shinta Sugimoto   2007-02-08  2593  	sel.family = pfkey_sadb_addr2xfrm_addr(sa, &sel.saddr);
08de61beab8a21c Shinta Sugimoto   2007-02-08  2594  	sel.prefixlen_s = sa->sadb_address_prefixlen;
08de61beab8a21c Shinta Sugimoto   2007-02-08  2595  	sel.proto = pfkey_proto_to_xfrm(sa->sadb_address_proto);
08de61beab8a21c Shinta Sugimoto   2007-02-08  2596  	sel.sport = ((struct sockaddr_in *)(sa + 1))->sin_port;
08de61beab8a21c Shinta Sugimoto   2007-02-08  2597  	if (sel.sport)
582ee43dad8e411 Al Viro           2007-07-26  2598  		sel.sport_mask = htons(0xffff);
08de61beab8a21c Shinta Sugimoto   2007-02-08  2599  
08de61beab8a21c Shinta Sugimoto   2007-02-08  2600  	/* set destination address info of selector */
47162c0b7e26ef2 Himangi Saraogi   2014-05-30  2601  	sa = ext_hdrs[SADB_EXT_ADDRESS_DST - 1];
08de61beab8a21c Shinta Sugimoto   2007-02-08  2602  	pfkey_sadb_addr2xfrm_addr(sa, &sel.daddr);
08de61beab8a21c Shinta Sugimoto   2007-02-08  2603  	sel.prefixlen_d = sa->sadb_address_prefixlen;
08de61beab8a21c Shinta Sugimoto   2007-02-08  2604  	sel.proto = pfkey_proto_to_xfrm(sa->sadb_address_proto);
08de61beab8a21c Shinta Sugimoto   2007-02-08  2605  	sel.dport = ((struct sockaddr_in *)(sa + 1))->sin_port;
08de61beab8a21c Shinta Sugimoto   2007-02-08  2606  	if (sel.dport)
582ee43dad8e411 Al Viro           2007-07-26  2607  		sel.dport_mask = htons(0xffff);
08de61beab8a21c Shinta Sugimoto   2007-02-08  2608  
08de61beab8a21c Shinta Sugimoto   2007-02-08  2609  	rq = (struct sadb_x_ipsecrequest *)(pol + 1);
08de61beab8a21c Shinta Sugimoto   2007-02-08  2610  
08de61beab8a21c Shinta Sugimoto   2007-02-08  2611  	/* extract ipsecrequests */
08de61beab8a21c Shinta Sugimoto   2007-02-08  2612  	i = 0;
08de61beab8a21c Shinta Sugimoto   2007-02-08  2613  	len = pol->sadb_x_policy_len * 8 - sizeof(struct sadb_x_policy);
08de61beab8a21c Shinta Sugimoto   2007-02-08  2614  
08de61beab8a21c Shinta Sugimoto   2007-02-08  2615  	while (len > 0 && i < XFRM_MAX_DEPTH) {
08de61beab8a21c Shinta Sugimoto   2007-02-08  2616  		ret = ipsecrequests_to_migrate(rq, len, &m[i]);
08de61beab8a21c Shinta Sugimoto   2007-02-08  2617  		if (ret < 0) {
08de61beab8a21c Shinta Sugimoto   2007-02-08  2618  			err = ret;
08de61beab8a21c Shinta Sugimoto   2007-02-08  2619  			goto out;
08de61beab8a21c Shinta Sugimoto   2007-02-08  2620  		} else {
08de61beab8a21c Shinta Sugimoto   2007-02-08  2621  			rq = (struct sadb_x_ipsecrequest *)((u8 *)rq + ret);
08de61beab8a21c Shinta Sugimoto   2007-02-08  2622  			len -= ret;
08de61beab8a21c Shinta Sugimoto   2007-02-08  2623  			i++;
08de61beab8a21c Shinta Sugimoto   2007-02-08  2624  		}
08de61beab8a21c Shinta Sugimoto   2007-02-08  2625  	}
08de61beab8a21c Shinta Sugimoto   2007-02-08  2626  
08de61beab8a21c Shinta Sugimoto   2007-02-08  2627  	if (!i || len > 0) {
08de61beab8a21c Shinta Sugimoto   2007-02-08  2628  		err = -EINVAL;
08de61beab8a21c Shinta Sugimoto   2007-02-08  2629  		goto out;
08de61beab8a21c Shinta Sugimoto   2007-02-08  2630  	}
08de61beab8a21c Shinta Sugimoto   2007-02-08  2631  
13c1d18931ebb5c Arnaud Ebalard    2008-10-05 @2632  	return xfrm_migrate(&sel, dir, XFRM_POLICY_TYPE_MAIN, m, i,
bd12240337f4352 Sabrina Dubroca   2022-11-24  2633  			    kma ? &k : NULL, net, NULL, 0, NULL);
08de61beab8a21c Shinta Sugimoto   2007-02-08  2634  
08de61beab8a21c Shinta Sugimoto   2007-02-08  2635   out:
08de61beab8a21c Shinta Sugimoto   2007-02-08  2636  	return err;
08de61beab8a21c Shinta Sugimoto   2007-02-08  2637  }
08de61beab8a21c Shinta Sugimoto   2007-02-08  2638  #else
08de61beab8a21c Shinta Sugimoto   2007-02-08  2639  static int pfkey_migrate(struct sock *sk, struct sk_buff *skb,
7f6daa635c28ed6 Stephen Hemminger 2011-03-01  2640  			 const struct sadb_msg *hdr, void * const *ext_hdrs)
08de61beab8a21c Shinta Sugimoto   2007-02-08  2641  {
08de61beab8a21c Shinta Sugimoto   2007-02-08  2642  	return -ENOPROTOOPT;
08de61beab8a21c Shinta Sugimoto   2007-02-08  2643  }
08de61beab8a21c Shinta Sugimoto   2007-02-08  2644  #endif
08de61beab8a21c Shinta Sugimoto   2007-02-08  2645  
08de61beab8a21c Shinta Sugimoto   2007-02-08  2646  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

