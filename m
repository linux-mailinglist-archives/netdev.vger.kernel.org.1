Return-Path: <netdev+bounces-136849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACC39A33FA
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 06:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4982C1C20F82
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895F01714C0;
	Fri, 18 Oct 2024 04:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kXfsufB8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C960920E318
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 04:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729227429; cv=none; b=C/omnopBb8Ay6oSD7XXjS7pYsYZW0Lognn0FRkWXyZNjOpDYe+pGjqLm/WAMi8wpi82mtaOlUacKJn+TuDtdBOvBK0DRhoVPgR4rd9pFPVkAB4miI3v0qL9kQZKdJ4VicwzXwIu8f0ABFtfkSos9v5yN0yzo1EpxtinmA1vNHcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729227429; c=relaxed/simple;
	bh=xjRPRAsN2+MS07nXvehs+xN3Fwavhb8T/rE5f5K8OXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBxI/JmPAKNx86DFQEolYU2kFeCB4skxMEjL8UDwqrfwo+CieZLRMGtQvpzUbIlOvq8GBL2+jzMB3HJSf2lXkHg/J/gM8uo96ehzmiFT0yItkztZYBfTd5E3EN6o0nbFG1yhZoRl13MIo/rmy1sqHCpHaFmbdUHlIVsHenj1UUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kXfsufB8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729227428; x=1760763428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xjRPRAsN2+MS07nXvehs+xN3Fwavhb8T/rE5f5K8OXg=;
  b=kXfsufB8ximt8AAOifgDAEztE65xuALySOTG1uN6WxWit+VmjS4FFsjO
   V5NCZgDK86wQ8yEDhjk0c4LliyBxTmRFiKeeQ2tNAp3ptw2wUUZn06++p
   nHRsY4qfZVLHFH/BzaWiLsChP0ZTLhC1PNGFp2DJzQwyqcPSovJfEVkko
   p0c9pHMK2q3rVAydyG/bYMoAv5I1Ekk9nT5M2/HYTKYWMbrE3GHGPADTQ
   jZWBTcOTGvJsMva0OofTtj9WoIwE4dJ0UK9Je+VKLUVK76B8JCNLFnQjm
   p3QyM9zBEA1zjtOQchORRn2HGc8FxagY/wOAQ69kpJeQlnSJ8oUenG3LS
   A==;
X-CSE-ConnectionGUID: fYGV2FIDQ9acRAKbECSlLQ==
X-CSE-MsgGUID: z+N/QxYDRyykTpnaYuLnCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28877891"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28877891"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 21:57:07 -0700
X-CSE-ConnectionGUID: FZD2wJcsSAi76JatAAQYzA==
X-CSE-MsgGUID: oRFh4Y9NS22CWyQJkaWzPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="109497746"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 17 Oct 2024 21:57:05 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1f2s-000NHj-2y;
	Fri, 18 Oct 2024 04:57:02 +0000
Date: Fri, 18 Oct 2024 12:56:25 +0800
From: kernel test robot <lkp@intel.com>
To: Gilad Naaman <gnaaman@drivenets.com>, netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net-next v5 5/6] Remove bare neighbour::next pointer
Message-ID: <202410181237.GEcWZ6xL-lkp@intel.com>
References: <20241017070445.4013745-6-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017070445.4013745-6-gnaaman@drivenets.com>

Hi Gilad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Gilad-Naaman/Add-hlist_node-to-struct-neighbour/20241017-150629
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241017070445.4013745-6-gnaaman%40drivenets.com
patch subject: [PATCH net-next v5 5/6] Remove bare neighbour::next pointer
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20241018/202410181237.GEcWZ6xL-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241018/202410181237.GEcWZ6xL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410181237.GEcWZ6xL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/core/neighbour.c: In function 'neigh_remove_one':
>> net/core/neighbour.c:210:34: warning: variable 'nht' set but not used [-Wunused-but-set-variable]
     210 |         struct neigh_hash_table *nht;
         |                                  ^~~


vim +/nht +210 net/core/neighbour.c

   207	
   208	bool neigh_remove_one(struct neighbour *ndel, struct neigh_table *tbl)
   209	{
 > 210		struct neigh_hash_table *nht;
   211		bool retval = false;
   212	
   213		nht = rcu_dereference_protected(tbl->nht,
   214						lockdep_is_held(&tbl->lock));
   215	
   216		write_lock(&ndel->lock);
   217		if (refcount_read(&ndel->refcnt) == 1) {
   218			hlist_del_rcu(&ndel->hash);
   219			neigh_mark_dead(ndel);
   220			retval = true;
   221		}
   222		write_unlock(&ndel->lock);
   223		if (retval)
   224			neigh_cleanup_and_release(ndel);
   225		return retval;
   226	}
   227	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

