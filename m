Return-Path: <netdev+bounces-297423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fObSJNPeKGo0LAMAu9opvQ
	(envelope-from <netdev+bounces-297423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:49:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C8D665AA1
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:49:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=iAICHqWT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297423-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297423-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B36A5300AD67
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFCB331EB9;
	Wed, 10 Jun 2026 03:49:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2052FE56A
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 03:49:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781063373; cv=none; b=VTm/LqnR3qWew38U+MA7Y7guh8bntZpYBfVYiAyS0rxgfeJIiYryK73PKJX7ZodNVn0+OxYAhgrluh03KxME1YWTj42tSUyUQKYpMOo5ERkqxHhPfaMnHAceEU66PKgD1AKUa5lFDhs7iiteDqOKIAvMHLGrQdN0MZ/mNBAEPQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781063373; c=relaxed/simple;
	bh=KYpIDmSexgrTILzapC+3rrNyZFokBG++p4LHZiLCPvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5T6NodhjuiWI9behGYhu6MU09JK0GB1O19jewnlSEidUyTu9sVaJNK6qGOrSqcb3xvLxrHdAt9Wyffy8svvqUzCnZ9pnouBZci/tMoGsWgqEmpVmuCPhYfucRNE/EaO88wUs108Oxu+WRkSb2mcRR0EaUGw10lSP/2pl96t9PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iAICHqWT; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781063372; x=1812599372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KYpIDmSexgrTILzapC+3rrNyZFokBG++p4LHZiLCPvQ=;
  b=iAICHqWTR5kI8e13TYUk1T2BywmbiHjlPa8COpK9FVdpfjfA/rJE/mH/
   WYa3EUXo0JVVaKla2VTp6jUtktlG+LcyXDFscE5SLl56Ya5NtGmxs8sgK
   N7657Aiy5ioRM4wScUVeue0lR/jNoBzAhsCOmE9a0Umh15adMPsgJlvWP
   bLj/xzEVBxFB+pm7djgvkal9zu6IluaUWodDmm6u+BzFoFj9mRKvoD8NS
   iKmJJAMS+R2QXINYwjykZRlEkRI7nzLDk783FluL/esZlof+X4R9EWBLs
   vNXi3zFtYSXyN0RFFTf5URD+uy6jywkklTtLnEgTNnMU2WjcivuFvN/ol
   A==;
X-CSE-ConnectionGUID: 4myzRNj/RCOOFGcFkTIJSw==
X-CSE-MsgGUID: Vdo0KVnIRBqAxfjbdDYkZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="82039530"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="82039530"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 20:49:32 -0700
X-CSE-ConnectionGUID: IsPE+VdaRuSR6HvyLHOUGQ==
X-CSE-MsgGUID: 2E+NuBHdQgq8eMn5EIyVlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="244909650"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by orviesa006.jf.intel.com with ESMTP; 09 Jun 2026 20:49:30 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wX9wU-000000003bt-2z3n;
	Wed, 10 Jun 2026 03:49:26 +0000
Date: Wed, 10 Jun 2026 05:49:05 +0200
From: kernel test robot <lkp@intel.com>
To: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH net-next 2/2] net: remove some unused EXPORT_SYMBOL()s
Message-ID: <202606100534.VKtBus9X-lkp@intel.com>
References: <cbf1457c5d192a206f2f244ea3453766cb5dbbf9.1781013810.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbf1457c5d192a206f2f244ea3453766cb5dbbf9.1781013810.git.sd@queasysnail.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297423-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sd@queasysnail.net,m:netdev@vger.kernel.org,m:oe-kbuild-all@lists.linux.dev,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,01.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86C8D665AA1

Hi Sabrina,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sabrina-Dubroca/tls-remove-tls_toe-and-the-related-driver/20260609-223704
base:   net-next/main
patch link:    https://lore.kernel.org/r/cbf1457c5d192a206f2f244ea3453766cb5dbbf9.1781013810.git.sd%40queasysnail.net
patch subject: [PATCH net-next 2/2] net: remove some unused EXPORT_SYMBOL()s
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project f43d6834093b19baf79beda8c0337ab020ac5f17)
docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
reproduce: (https://download.01.org/0day-ci/archive/20260610/202606100534.VKtBus9X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606100534.VKtBus9X-lkp@intel.com/

All warnings (new ones prefixed by >>):

   ===================================================== [docutils]
   Documentation/networking/ipvs-sysctl.rst:88: ERROR: Unexpected indentation. [docutils]
>> Documentation/networking/tls-offload.rst:29: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
   MAINTAINERS:40: WARNING: Inline strong start-string without end-string. [docutils]
   Documentation/userspace-api/landlock:504: ./security/landlock/errata/abi-4.h:5: ERROR: Unexpected section title.


vim +29 Documentation/networking/tls-offload.rst

f42c104f2ec94a Jakub Kicinski 2019-05-21  17  
f42c104f2ec94a Jakub Kicinski 2019-05-21  18   * Software crypto mode (``TLS_SW``) - CPU handles the cryptography.
f42c104f2ec94a Jakub Kicinski 2019-05-21  19     In most basic cases only crypto operations synchronous with the CPU
f42c104f2ec94a Jakub Kicinski 2019-05-21  20     can be used, but depending on calling context CPU may utilize
f42c104f2ec94a Jakub Kicinski 2019-05-21  21     asynchronous crypto accelerators. The use of accelerators introduces extra
f42c104f2ec94a Jakub Kicinski 2019-05-21  22     latency on socket reads (decryption only starts when a read syscall
f42c104f2ec94a Jakub Kicinski 2019-05-21  23     is made) and additional I/O load on the system.
f42c104f2ec94a Jakub Kicinski 2019-05-21  24   * Packet-based NIC offload mode (``TLS_HW``) - the NIC handles crypto
f42c104f2ec94a Jakub Kicinski 2019-05-21  25     on a packet by packet basis, provided the packets arrive in order.
f42c104f2ec94a Jakub Kicinski 2019-05-21  26     This mode integrates best with the kernel stack and is described in detail
f42c104f2ec94a Jakub Kicinski 2019-05-21  27     in the remaining part of this document
f42c104f2ec94a Jakub Kicinski 2019-05-21  28     (``ethtool`` flags ``tls-hw-tx-offload`` and ``tls-hw-rx-offload``).
f42c104f2ec94a Jakub Kicinski 2019-05-21 @29  The operation mode is selected automatically based on device configuration,
f42c104f2ec94a Jakub Kicinski 2019-05-21  30  offload opt-in or opt-out on per-connection basis is not currently supported.
f42c104f2ec94a Jakub Kicinski 2019-05-21  31  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

