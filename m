Return-Path: <netdev+bounces-190272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7E1AB5F99
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 00:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5912E4C05D1
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 22:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B9121129C;
	Tue, 13 May 2025 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPUDvgrQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6951220CCDA
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 22:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747176021; cv=none; b=PIf36h1IapbOiZlArs0wZYmZq5/WNTSouzrL3ln5zpj/RKr+4s7j01vbbL9i1V+CaOY0n/zO29vdOtvoy/Q74pWyXMUZvKgCe+AwBAWPCT6cYTpsTgntor6cqWRkuZQWOgjWP8ZxQCeZ/wombvrDmIkX6YvfBp2/az9naIES7jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747176021; c=relaxed/simple;
	bh=dNZVh3682iLnPx8sHAGcB8F0fkoQhLBOqQPVDI3jg7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5BUobFcz3YzFS2dOeciX8B+e5dWyFGQvcGSUwoKZoXBM5UDEkgt7tOSdgAvBhyuavC4wiQc6gd5QZa2kAjj7swB3AefcuJuaqGa6maIaHXn4w9pCLBmIf5r7sugTqsdLDtNe2neq+iRT0DtRzFoCmKyXPWxzpikxgNa0cIuYJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPUDvgrQ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747176019; x=1778712019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dNZVh3682iLnPx8sHAGcB8F0fkoQhLBOqQPVDI3jg7E=;
  b=gPUDvgrQbo6PUK1WFYYZoJleLumqYkE1ukkbpeikWmRddv4JEDccfpvW
   DSe5hPoubNSmFfeCKBmg8wXuvoLoZF93sD5YVnaGmYoqcpD20hjCVZsbV
   4l6FAClYcGNYFJRwONpSzNucworoYbTTPH9VlL76k2OfFWU89oozY3Hjs
   b9cN3IrAT3QF1C7ngpQPJONyMcn8v5akYUtzyQPNFwnVMAmd2vzhTAAyE
   456aFt0Mh/bcK+kv4byXdqlsXOOYL5o2X7ikJypcpNPxTFzPxBKNtokEA
   8rejMvINjsUVFN4YNqatFUqH+qU+v2DxA95/nkRRGLAEAnumUAYVm6BcR
   Q==;
X-CSE-ConnectionGUID: IH7JFCwORIyCcSD5M0GLlg==
X-CSE-MsgGUID: UqoDc4c1Q1iWNIDTCtS4DA==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="48302306"
X-IronPort-AV: E=Sophos;i="6.15,286,1739865600"; 
   d="scan'208";a="48302306"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 15:40:18 -0700
X-CSE-ConnectionGUID: KeopJDPkRa2lxJNzJG8TGA==
X-CSE-MsgGUID: sxLnACadQe6xMr7jNEJRTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,286,1739865600"; 
   d="scan'208";a="137724524"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 13 May 2025 15:40:12 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uEyIE-000GSp-0L;
	Tue, 13 May 2025 22:40:10 +0000
Date: Wed, 14 May 2025 06:39:26 +0800
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
Message-ID: <202505140614.Hqk46aA8-lkp@intel.com>
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
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20250514/202505140614.Hqk46aA8-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250514/202505140614.Hqk46aA8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505140614.Hqk46aA8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> <stdin>:1618:2: warning: #warning syscall file_getattr not implemented [-Wcpp]
>> <stdin>:1621:2: warning: #warning syscall file_setattr not implemented [-Wcpp]
--
>> <stdin>:1618:2: warning: #warning syscall file_getattr not implemented [-Wcpp]
>> <stdin>:1621:2: warning: #warning syscall file_setattr not implemented [-Wcpp]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

