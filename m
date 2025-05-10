Return-Path: <netdev+bounces-189485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABD9AB2554
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 23:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3453B46DA
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 21:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8024F286D75;
	Sat, 10 May 2025 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GHZ38t9q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368A11D86F7
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746911188; cv=none; b=spIpG+pgmsf3alf5JalypDGV/Xfu7TwmaxKOXzgcZXxlBKKiRU/lQczNzQxMXGva2NWewD325KrG/v9I1XjqHq/sTNL8itwHV973KDeYL+qw0RBiWG6eNwx7e2V7q0xC7Cayn/LlnD748zBcNbEIGZHiH6JzRWJ3ZeYtuf6eWYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746911188; c=relaxed/simple;
	bh=eNejcWYmJPv0gooUpzTCxEDeJ7VrsdKJJ8ZFmXWw8T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qz4/ThNg224HqW+n9Y3hRxi7flZifiR47abyp7ZBXIfjVK0k5Rqke/IaOyg2vkHY4Y1tUywMU1aILyDFbl/i2fnSDDy/4N65KyraWJKVtTwo3yv5XK5bFmoWFDW8sg2vxLDEHy9L9jS+ibsDaFbqmDmjZpj+MyfDIKjeVchNa7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GHZ38t9q; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746911186; x=1778447186;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eNejcWYmJPv0gooUpzTCxEDeJ7VrsdKJJ8ZFmXWw8T4=;
  b=GHZ38t9qs1nh9kNEdMKbXajFDEKBjnSDVFl8jY620pN2R13IGr6CvJvh
   GujP3VNX5I69XZDRczw3kp7M/LYpj1yIjowNWBFuCtzGd/tK3dTdARem3
   nR5n2oaHVotwFjgcqXzNRCagx/LDvwFXWPzDUCjNYLIgeKvdkLTcfBhc8
   r/Z7bLUIV9rCRGF0yumcmkxO4rgwSxYi+m6RvbiixhXgJqPaQjAI3P98Z
   MLfu/c5ldvGXbEwmIZXvWHQLTOxxO5RyC/IqcGEI3apV4n6UK7OH+OlwF
   g3XNr+eJLEhXeWuKVb/rOFBUv0EpFpnISGtgAFJf97zJk7hjJu5VKrFHb
   A==;
X-CSE-ConnectionGUID: oCZsSIE+RsqZfSaDmZIEjA==
X-CSE-MsgGUID: 5D+dkTP+QjuhnMpc+JY+tQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11429"; a="52378771"
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="52378771"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 14:06:25 -0700
X-CSE-ConnectionGUID: 2Ygold1gQX6/+xm+SgyEHg==
X-CSE-MsgGUID: IiXttIPBRuudII5nNDdaaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="141714835"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 10 May 2025 14:06:22 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDrOm-000DNv-0m;
	Sat, 10 May 2025 21:06:20 +0000
Date: Sun, 11 May 2025 05:06:13 +0800
From: kernel test robot <lkp@intel.com>
To: David J Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jv@jvosburgh.net, wilder@us.ibm.com,
	pradeeps@linux.vnet.ibm.com, pradeep@us.ibm.com, i.maximets@ovn.org,
	amorenoz@redhat.com, haliu@redhat.com
Subject: Re: [PATCH net-next v1 2/2] bonding: Extend arp_ip_target format to
 allow for a list of vlan tags.
Message-ID: <202505110414.ebTXSare-lkp@intel.com>
References: <20250508183014.2554525-3-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508183014.2554525-3-wilder@us.ibm.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/David-J-Wilder/bonding-Adding-struct-arp_target/20250509-023255
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250508183014.2554525-3-wilder%40us.ibm.com
patch subject: [PATCH net-next v1 2/2] bonding: Extend arp_ip_target format to allow for a list of vlan tags.
config: csky-randconfig-r123-20250510 (https://download.01.org/0day-ci/archive/20250511/202505110414.ebTXSare-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250511/202505110414.ebTXSare-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505110414.ebTXSare-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/bonding/bond_main.c:6126:55: sparse: sparse: Using plain integer as NULL pointer

vim +6126 drivers/net/bonding/bond_main.c

  6109	
  6110	/* Convert vlan_list into struct bond_vlan_tag.
  6111	 * Inspired by bond_verify_device_path();
  6112	 */
  6113	static struct bond_vlan_tag *vlan_tags_parse(char *vlan_list, int level)
  6114	{
  6115		struct bond_vlan_tag *tags;
  6116		char *vlan;
  6117	
  6118		if (!vlan_list || strlen(vlan_list) == 0) {
  6119			tags = kcalloc(level + 1, sizeof(*tags), GFP_ATOMIC);
  6120			if (!tags)
  6121				return ERR_PTR(-ENOMEM);
  6122			tags[level].vlan_proto = BOND_VLAN_PROTO_NONE;
  6123			return tags;
  6124		}
  6125	
> 6126		for (vlan = strsep(&vlan_list, "/"); (vlan != 0); level++) {
  6127			tags = vlan_tags_parse(vlan_list, level + 1);
  6128			if (IS_ERR_OR_NULL(tags)) {
  6129				if (IS_ERR(tags))
  6130					return tags;
  6131				continue;
  6132			}
  6133	
  6134			tags[level].vlan_proto = __cpu_to_be16(ETH_P_8021Q);
  6135			if (kstrtou16(vlan, 0, &tags[level].vlan_id))
  6136				return ERR_PTR(-EINVAL);
  6137	
  6138			if (tags[level].vlan_id < 1 || tags[level].vlan_id > 4094) {
  6139				kfree(tags);
  6140				return ERR_PTR(-EINVAL);
  6141			}
  6142	
  6143			return tags;
  6144		}
  6145	
  6146		return NULL;
  6147	}
  6148	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

