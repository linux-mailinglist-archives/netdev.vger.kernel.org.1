Return-Path: <netdev+bounces-134634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE4D99A9A0
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 19:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B031F2381B
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 17:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F951A3BC8;
	Fri, 11 Oct 2024 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iRJk3LXq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E23319E993;
	Fri, 11 Oct 2024 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666754; cv=none; b=WH1qCqYsbD/tTRAzLc/k6xKVMAHMDqxsMvioq88Jlrl36EXLLUveJXAOWr1nPzK0qZfPc2Y6ydUnAD/34De+XGxtfKbB/7wMfBuiNonfFUqHxRgpTm208u8hY9i19B+qpXY+HkFc0TSpNnjQ0ShEDrxOt4xtR6QAsxwzYHFmNtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666754; c=relaxed/simple;
	bh=HyzgzEpwQ6CUwvYBP98vuPcTjkwqLs1z7z5alGx6okQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjGf1HIU5MsP8UfgLgqkkU3B3hwe2wmahIDpAzYDp6AaLxFba7IyaJCBrbvZMaw9J3CRM/qHTd+Kf1Zd2LB1u+Es6SlHHtNVWFRoteqtm9IgobGwuMBrK2wECE3cxGrmMgfJdSAQvJjIwlo2ykYjFbwn2oS1cs958nuNs9xcDsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iRJk3LXq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728666752; x=1760202752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HyzgzEpwQ6CUwvYBP98vuPcTjkwqLs1z7z5alGx6okQ=;
  b=iRJk3LXqDJ5GqOh8pU/Fy8zXJxCgg8bLNf83WGtBYs6RY3qw96Ks+5lP
   ZE+RrGYQhPTCXM6L16UCkpTx4HxMq6efhrns5ZE4v5wavmXLe0hemrS1f
   C5S7D2I+nAG3c4r/i30zdKIFkN8swQ9xRfAGD2JPjDDKGB2kKQ3EzQaiA
   23tYStp9495fBt23iucqFFMmEjElywgwPNo80O4is0dr13/p0Ftqb2kdy
   pEMUDkrrAVrWmmKYl1eJQDxF53QaFqXqhhtU0wpYMP+Ajsh/tNCUpA3m/
   RDRW9kmDLrESUhJPQhkRV2J89MhrN0UHGr2P+FwgOyFKRX4JSlgWYRGzH
   A==;
X-CSE-ConnectionGUID: Au0y+OHaRxKGNZfsgGKHtQ==
X-CSE-MsgGUID: bAt50xgDSuiSI5ywKlIJ2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39199839"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="39199839"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 10:12:31 -0700
X-CSE-ConnectionGUID: TPnuj3nzQkSC8HF/G6hGcg==
X-CSE-MsgGUID: EgMvq0ZMSj2HDRuNpYuKxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="114426526"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 11 Oct 2024 10:12:28 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szJBi-000CXX-18;
	Fri, 11 Oct 2024 17:12:26 +0000
Date: Sat, 12 Oct 2024 01:11:42 +0800
From: kernel test robot <lkp@intel.com>
To: Stefan Wiehler <stefan.wiehler@nokia.com>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: Re: [PATCH net v3 3/4] ip6mr: Lock RCU before ip6mr_get_table() call
 in ip6mr_compat_ioctl()
Message-ID: <202410120109.QyXpPs23-lkp@intel.com>
References: <20241010090741.1980100-7-stefan.wiehler@nokia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010090741.1980100-7-stefan.wiehler@nokia.com>

Hi Stefan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Wiehler/ip6mr-Lock-RCU-before-ip6mr_get_table-call-in-ip6mr_ioctl/20241010-171634
base:   net/main
patch link:    https://lore.kernel.org/r/20241010090741.1980100-7-stefan.wiehler%40nokia.com
patch subject: [PATCH net v3 3/4] ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_compat_ioctl()
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20241012/202410120109.QyXpPs23-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241012/202410120109.QyXpPs23-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410120109.QyXpPs23-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/ipv6/ip6mr.c:1970:18: warning: variable 'mrt' is uninitialized when used here [-Wuninitialized]
    1970 |                 if (vr.mifi >= mrt->maxvif)
         |                                ^~~
   net/ipv6/ip6mr.c:1963:22: note: initialize the variable 'mrt' to silence this warning
    1963 |         struct mr_table *mrt;
         |                             ^
         |                              = NULL
   1 warning generated.


vim +/mrt +1970 net/ipv6/ip6mr.c

e2d57766e6744f David S. Miller   2011-02-03  1955  
e2d57766e6744f David S. Miller   2011-02-03  1956  int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
e2d57766e6744f David S. Miller   2011-02-03  1957  {
e2d57766e6744f David S. Miller   2011-02-03  1958  	struct compat_sioc_sg_req6 sr;
e2d57766e6744f David S. Miller   2011-02-03  1959  	struct compat_sioc_mif_req6 vr;
6853f21f764b04 Yuval Mintz       2018-02-28  1960  	struct vif_device *vif;
e2d57766e6744f David S. Miller   2011-02-03  1961  	struct mfc6_cache *c;
e2d57766e6744f David S. Miller   2011-02-03  1962  	struct net *net = sock_net(sk);
b70432f7319eb7 Yuval Mintz       2018-02-28  1963  	struct mr_table *mrt;
9135a3aca0c10d Stefan Wiehler    2024-10-10  1964  	int err;
e2d57766e6744f David S. Miller   2011-02-03  1965  
e2d57766e6744f David S. Miller   2011-02-03  1966  	switch (cmd) {
e2d57766e6744f David S. Miller   2011-02-03  1967  	case SIOCGETMIFCNT_IN6:
e2d57766e6744f David S. Miller   2011-02-03  1968  		if (copy_from_user(&vr, arg, sizeof(vr)))
e2d57766e6744f David S. Miller   2011-02-03  1969  			return -EFAULT;
e2d57766e6744f David S. Miller   2011-02-03 @1970  		if (vr.mifi >= mrt->maxvif)
e2d57766e6744f David S. Miller   2011-02-03  1971  			return -EINVAL;
9135a3aca0c10d Stefan Wiehler    2024-10-10  1972  		break;
9135a3aca0c10d Stefan Wiehler    2024-10-10  1973  	case SIOCGETSGCNT_IN6:
9135a3aca0c10d Stefan Wiehler    2024-10-10  1974  		if (copy_from_user(&sr, arg, sizeof(sr)))
9135a3aca0c10d Stefan Wiehler    2024-10-10  1975  			return -EFAULT;
9135a3aca0c10d Stefan Wiehler    2024-10-10  1976  		break;
9135a3aca0c10d Stefan Wiehler    2024-10-10  1977  	default:
9135a3aca0c10d Stefan Wiehler    2024-10-10  1978  		return -ENOIOCTLCMD;
9135a3aca0c10d Stefan Wiehler    2024-10-10  1979  	}
9135a3aca0c10d Stefan Wiehler    2024-10-10  1980  
9135a3aca0c10d Stefan Wiehler    2024-10-10  1981  
638cf4a24a09d1 Eric Dumazet      2022-06-23  1982  	rcu_read_lock();
9135a3aca0c10d Stefan Wiehler    2024-10-10  1983  	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
9135a3aca0c10d Stefan Wiehler    2024-10-10  1984  	if (!mrt) {
9135a3aca0c10d Stefan Wiehler    2024-10-10  1985  		err = -ENOENT;
9135a3aca0c10d Stefan Wiehler    2024-10-10  1986  		goto out;
9135a3aca0c10d Stefan Wiehler    2024-10-10  1987  	}
9135a3aca0c10d Stefan Wiehler    2024-10-10  1988  
9135a3aca0c10d Stefan Wiehler    2024-10-10  1989  	switch (cmd) {
9135a3aca0c10d Stefan Wiehler    2024-10-10  1990  	case SIOCGETMIFCNT_IN6:
9135a3aca0c10d Stefan Wiehler    2024-10-10  1991  		if (vr.mifi >= mrt->maxvif) {
9135a3aca0c10d Stefan Wiehler    2024-10-10  1992  			err = -EINVAL;
9135a3aca0c10d Stefan Wiehler    2024-10-10  1993  			goto out;
9135a3aca0c10d Stefan Wiehler    2024-10-10  1994  		}
9135a3aca0c10d Stefan Wiehler    2024-10-10  1995  		vr.mifi = array_index_nospec(vr.mifi, mrt->maxvif);
b70432f7319eb7 Yuval Mintz       2018-02-28  1996  		vif = &mrt->vif_table[vr.mifi];
b70432f7319eb7 Yuval Mintz       2018-02-28  1997  		if (VIF_EXISTS(mrt, vr.mifi)) {
638cf4a24a09d1 Eric Dumazet      2022-06-23  1998  			vr.icount = READ_ONCE(vif->pkt_in);
638cf4a24a09d1 Eric Dumazet      2022-06-23  1999  			vr.ocount = READ_ONCE(vif->pkt_out);
638cf4a24a09d1 Eric Dumazet      2022-06-23  2000  			vr.ibytes = READ_ONCE(vif->bytes_in);
638cf4a24a09d1 Eric Dumazet      2022-06-23  2001  			vr.obytes = READ_ONCE(vif->bytes_out);
638cf4a24a09d1 Eric Dumazet      2022-06-23  2002  			rcu_read_unlock();
e2d57766e6744f David S. Miller   2011-02-03  2003  
e2d57766e6744f David S. Miller   2011-02-03  2004  			if (copy_to_user(arg, &vr, sizeof(vr)))
e2d57766e6744f David S. Miller   2011-02-03  2005  				return -EFAULT;
e2d57766e6744f David S. Miller   2011-02-03  2006  			return 0;
e2d57766e6744f David S. Miller   2011-02-03  2007  		}
638cf4a24a09d1 Eric Dumazet      2022-06-23  2008  		rcu_read_unlock();
9135a3aca0c10d Stefan Wiehler    2024-10-10  2009  		err = -EADDRNOTAVAIL;
9135a3aca0c10d Stefan Wiehler    2024-10-10  2010  		goto out;
e2d57766e6744f David S. Miller   2011-02-03  2011  	case SIOCGETSGCNT_IN6:
e2d57766e6744f David S. Miller   2011-02-03  2012  		c = ip6mr_cache_find(mrt, &sr.src.sin6_addr, &sr.grp.sin6_addr);
e2d57766e6744f David S. Miller   2011-02-03  2013  		if (c) {
494fff56379c4a Yuval Mintz       2018-02-28  2014  			sr.pktcnt = c->_c.mfc_un.res.pkt;
494fff56379c4a Yuval Mintz       2018-02-28  2015  			sr.bytecnt = c->_c.mfc_un.res.bytes;
494fff56379c4a Yuval Mintz       2018-02-28  2016  			sr.wrong_if = c->_c.mfc_un.res.wrong_if;
87c418bf1323d5 Yuval Mintz       2018-02-28  2017  			rcu_read_unlock();
e2d57766e6744f David S. Miller   2011-02-03  2018  
e2d57766e6744f David S. Miller   2011-02-03  2019  			if (copy_to_user(arg, &sr, sizeof(sr)))
e2d57766e6744f David S. Miller   2011-02-03  2020  				return -EFAULT;
e2d57766e6744f David S. Miller   2011-02-03  2021  			return 0;
e2d57766e6744f David S. Miller   2011-02-03  2022  		}
9135a3aca0c10d Stefan Wiehler    2024-10-10  2023  		err = -EADDRNOTAVAIL;
9135a3aca0c10d Stefan Wiehler    2024-10-10  2024  		goto out;
e2d57766e6744f David S. Miller   2011-02-03  2025  	}
9135a3aca0c10d Stefan Wiehler    2024-10-10  2026  
9135a3aca0c10d Stefan Wiehler    2024-10-10  2027  out:
9135a3aca0c10d Stefan Wiehler    2024-10-10  2028  	rcu_read_unlock();
9135a3aca0c10d Stefan Wiehler    2024-10-10  2029  	return err;
e2d57766e6744f David S. Miller   2011-02-03  2030  }
e2d57766e6744f David S. Miller   2011-02-03  2031  #endif
7bc570c8b4f75d YOSHIFUJI Hideaki 2008-04-03  2032  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

