Return-Path: <netdev+bounces-191340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38740ABB010
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 13:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07BA17563E
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 11:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A578F21770C;
	Sun, 18 May 2025 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EcGhw+yk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3D320458A
	for <netdev@vger.kernel.org>; Sun, 18 May 2025 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747567593; cv=none; b=VylxZKIgoB+gyVjYoTBz2oQ/ET9+BhOxrEQbMBNacXyiTMIzagUIh1APDxlgcaTeP/iq4Le0Wc8dF4eYf0zu8nk/MzBDTmcwXXvyIYS5CAemNb/0w5V0zfONvOq7uEbAS3bmZ2i640FFU37/ARFT+KGFZy8zia1E8B1IWLjZGg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747567593; c=relaxed/simple;
	bh=X4FLcD9CPlrbVSA5eiBFd1Za/NDlJcFjuo167iNkPf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7rd5TwV/gXDp5GuIRfNv1qDf4ElFDKFTREDCSGlznnCjiSQ3NGW6Plb6h6xsaFEHu3xurooALnrN2e2lrQmUNNQHvwE5Vk/7TWdluGzgiRHxtJiA4uEgos+mkZXHL6CCsK5EguwFS8SwMqsks/fBuqUQF+79125cXYA5o+zvu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EcGhw+yk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747567591; x=1779103591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X4FLcD9CPlrbVSA5eiBFd1Za/NDlJcFjuo167iNkPf8=;
  b=EcGhw+ykwho2VEAxfVk1tEb5GaXS32/Lxd4MhmVC38ExXnWpDLUVJazi
   vy9aPT4skF6BhY1iq3xXMav78YjjS7Ug64Fjiaf7OSAeyYh758k3BPtCS
   AOCF6dlM+09+1c7ARJhVFt8l5oQ5+ERxhEHYgmoIvZ1lTdMT1/TsgTGHT
   6pCW6VnTPFPmHAeNNkaqM7s309jCNxBZ8VonX8K+2uyxp5giJPPBawatl
   r2CRXBsgMYbECy42DOtUkJSBczC3IzLwKyz4+lbNaJBAsLXbEstk9ex5O
   SPvM57hCEWeBTfDvEa2+znTk5I9AsjvpWr9rnk9qezKZz1ybs/p/pT3bZ
   w==;
X-CSE-ConnectionGUID: sB0/H0Y9Q5KfN2Y4P7yZ1A==
X-CSE-MsgGUID: jSV9PqOfQZ6lQ4gCf5nERg==
X-IronPort-AV: E=McAfee;i="6700,10204,11436"; a="60133844"
X-IronPort-AV: E=Sophos;i="6.15,298,1739865600"; 
   d="scan'208";a="60133844"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 04:26:30 -0700
X-CSE-ConnectionGUID: RqcLCHJEQwqT1rfMT3rA3Q==
X-CSE-MsgGUID: sypfrONYS9O/hzIzj6+XwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,298,1739865600"; 
   d="scan'208";a="138957861"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 18 May 2025 04:26:24 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uGc9t-000Km3-13;
	Sun, 18 May 2025 11:26:21 +0000
Date: Sun, 18 May 2025 19:26:00 +0800
From: kernel test robot <lkp@intel.com>
To: Andrey Albershteyn <aalbersh@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v5 7/7] fs: introduce file_getattr and file_setattr
 syscalls
Message-ID: <202505181900.UGh2tVRs-lkp@intel.com>
References: <20250513-xattrat-syscall-v5-7-22bb9c6c767f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513-xattrat-syscall-v5-7-22bb9c6c767f@kernel.org>

Hi Andrey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0d8d44db295ccad20052d6301ef49ff01fb8ae2d]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrey-Albershteyn/fs-split-fileattr-related-helpers-into-separate-file/20250513-172128
base:   0d8d44db295ccad20052d6301ef49ff01fb8ae2d
patch link:    https://lore.kernel.org/r/20250513-xattrat-syscall-v5-7-22bb9c6c767f%40kernel.org
patch subject: [PATCH v5 7/7] fs: introduce file_getattr and file_setattr syscalls
config: s390-randconfig-r112-20250518 (https://download.01.org/0day-ci/archive/20250518/202505181900.UGh2tVRs-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250518/202505181900.UGh2tVRs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505181900.UGh2tVRs-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/file_attr.c:362:1: sparse: sparse: Using plain integer as NULL pointer
>> fs/file_attr.c:362:1: sparse: sparse: Using plain integer as NULL pointer
>> fs/file_attr.c:362:1: sparse: sparse: Using plain integer as NULL pointer
>> fs/file_attr.c:362:1: sparse: sparse: Using plain integer as NULL pointer
   fs/file_attr.c:416:1: sparse: sparse: Using plain integer as NULL pointer
   fs/file_attr.c:416:1: sparse: sparse: Using plain integer as NULL pointer
   fs/file_attr.c:416:1: sparse: sparse: Using plain integer as NULL pointer
   fs/file_attr.c:416:1: sparse: sparse: Using plain integer as NULL pointer

vim +362 fs/file_attr.c

   361	
 > 362	SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
   363			struct fsxattr __user *, ufsx, size_t, usize,
   364			unsigned int, at_flags)
   365	{
   366		struct fileattr fa = {};
   367		struct path filepath __free(path_put) = {};
   368		int error;
   369		unsigned int lookup_flags = 0;
   370		struct filename *name;
   371		struct fsxattr fsx = {};
   372	
   373		BUILD_BUG_ON(sizeof(struct fsxattr) < FSXATTR_SIZE_VER0);
   374		BUILD_BUG_ON(sizeof(struct fsxattr) != FSXATTR_SIZE_LATEST);
   375	
   376		if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
   377			return -EINVAL;
   378	
   379		if (!(at_flags & AT_SYMLINK_NOFOLLOW))
   380			lookup_flags |= LOOKUP_FOLLOW;
   381	
   382		if (usize > PAGE_SIZE)
   383			return -E2BIG;
   384	
   385		if (usize < FSXATTR_SIZE_VER0)
   386			return -EINVAL;
   387	
   388		name = getname_maybe_null(filename, at_flags);
   389		if (IS_ERR(name))
   390			return PTR_ERR(name);
   391	
   392		if (!name && dfd >= 0) {
   393			CLASS(fd, f)(dfd);
   394	
   395			filepath = fd_file(f)->f_path;
   396			path_get(&filepath);
   397		} else {
   398			error = filename_lookup(dfd, name, lookup_flags, &filepath,
   399						NULL);
   400			putname(name);
   401			if (error)
   402				return error;
   403		}
   404	
   405		error = vfs_fileattr_get(filepath.dentry, &fa);
   406		if (error)
   407			return error;
   408	
   409		fileattr_to_fsxattr(&fa, &fsx);
   410		error = copy_struct_to_user(ufsx, usize, &fsx, sizeof(struct fsxattr),
   411					    NULL);
   412	
   413		return error;
   414	}
   415	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

