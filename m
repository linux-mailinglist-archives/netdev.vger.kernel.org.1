Return-Path: <netdev+bounces-68855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB35B8488B0
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 21:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B86AB235E2
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 20:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A79C5FDCD;
	Sat,  3 Feb 2024 20:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="loCvL83k"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8F85FDC2
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706991693; cv=none; b=YUMtILf1l8JXEJu9iOZWL0ADcV8l+U44xoaihOC0S3GyebicEWDEwxZIKvzffjhtrrI2YgjATaxF3U1Oehz8EGFVEr/Gu0JZ1NBJSdhuD5lFPqmnC5r9kRiPlFY7fgaLFGC4OGarWq4e4rky5JeQwaDsb/rAGeV8oZbkL3v6Hfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706991693; c=relaxed/simple;
	bh=qKd01ALOyqbsunjpDJoT21lcqvlrrXO1HM+cWnjbXm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKX8JgSt2tgyB4+7E1etqYX9GVkRXwubpA0CvsPT7avetWgtqirz/gyM6RsuMzBiTEEVbA4fIe/kmBgsrEvnoqROIc+4FRphAXK2qJSF5YwQs+eDEbebnZx/g452ipojdDQnublbrbz2KExzpXFxjqVSyN4UEIRXoit1KOh/3+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=loCvL83k; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706991691; x=1738527691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qKd01ALOyqbsunjpDJoT21lcqvlrrXO1HM+cWnjbXm0=;
  b=loCvL83kFLfz6LrUnRDS/tpbydQaBPHowh2++qaKTiHt3rJLtb49QDO7
   FVVT9bZTzS3aecUl4SE4wi3+St/6fdVF77noE+jB2wGHXk+9uAF8KQfzz
   P+KLN9EfGnPBoDCoubuMcNfCRdclMBcLRNg6D50hXshK7NlDuKj5U83ND
   ICC3GpnnH78V232HY74iXWQSG8A4pXVzUskxUYpdgHMQMG8Uac/sfCCon
   Df/1NC/2vjEGEO4x71one3tVw3dC4gnP8hjgS71Fs00eVd13qj7Cixsmx
   GfomoGYJcdMim9PbLmWHQL/lOeBvmxe0YDrylMqRwMnIkulk0t+3b67Ec
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="17860118"
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="17860118"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 12:21:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="4979777"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 03 Feb 2024 12:21:28 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWMVw-0005Ys-2U;
	Sat, 03 Feb 2024 20:21:24 +0000
Date: Sun, 4 Feb 2024 04:20:46 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v1 net-next 02/16] af_unix: Allocate struct unix_edge for
 each inflight AF_UNIX fd.
Message-ID: <202402040416.3h4bSPKV-lkp@intel.com>
References: <20240203030058.60750-3-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203030058.60750-3-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/af_unix-Add-struct-unix_vertex-in-struct-unix_sock/20240203-110847
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240203030058.60750-3-kuniyu%40amazon.com
patch subject: [PATCH v1 net-next 02/16] af_unix: Allocate struct unix_edge for each inflight AF_UNIX fd.
config: i386-buildonly-randconfig-004-20240203 (https://download.01.org/0day-ci/archive/20240204/202402040416.3h4bSPKV-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240204/202402040416.3h4bSPKV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402040416.3h4bSPKV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/core/scm.c:90:8: error: no member named 'edges' in 'struct scm_fp_list'
      90 |                 fpl->edges = NULL;
         |                 ~~~  ^
   net/core/scm.c:381:12: error: no member named 'edges' in 'struct scm_fp_list'
     381 |                 new_fpl->edges = NULL;
         |                 ~~~~~~~  ^
   2 errors generated.


vim +90 net/core/scm.c

    66	
    67	static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
    68	{
    69		int *fdp = (int*)CMSG_DATA(cmsg);
    70		struct scm_fp_list *fpl = *fplp;
    71		struct file **fpp;
    72		int i, num;
    73	
    74		num = (cmsg->cmsg_len - sizeof(struct cmsghdr))/sizeof(int);
    75	
    76		if (num <= 0)
    77			return 0;
    78	
    79		if (num > SCM_MAX_FD)
    80			return -EINVAL;
    81	
    82		if (!fpl)
    83		{
    84			fpl = kmalloc(sizeof(struct scm_fp_list), GFP_KERNEL_ACCOUNT);
    85			if (!fpl)
    86				return -ENOMEM;
    87			*fplp = fpl;
    88			fpl->count = 0;
    89			fpl->count_unix = 0;
  > 90			fpl->edges = NULL;
    91			fpl->max = SCM_MAX_FD;
    92			fpl->user = NULL;
    93		}
    94		fpp = &fpl->fp[fpl->count];
    95	
    96		if (fpl->count + num > fpl->max)
    97			return -EINVAL;
    98	
    99		/*
   100		 *	Verify the descriptors and increment the usage count.
   101		 */
   102	
   103		for (i=0; i< num; i++)
   104		{
   105			int fd = fdp[i];
   106			struct file *file;
   107	
   108			if (fd < 0 || !(file = fget_raw(fd)))
   109				return -EBADF;
   110			/* don't allow io_uring files */
   111			if (io_is_uring_fops(file)) {
   112				fput(file);
   113				return -EINVAL;
   114			}
   115			if (unix_get_socket(file))
   116				fpl->count_unix++;
   117	
   118			*fpp++ = file;
   119			fpl->count++;
   120		}
   121	
   122		if (!fpl->user)
   123			fpl->user = get_uid(current_user());
   124	
   125		return num;
   126	}
   127	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

