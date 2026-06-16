Return-Path: <netdev+bounces-299736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DHr6F8ffMGrhYAUAu9opvQ
	(envelope-from <netdev+bounces-299736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 07:31:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D0268C307
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 07:31:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=BRgLH8Lb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299736-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299736-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE9A63055081
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 05:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F493D16E3;
	Tue, 16 Jun 2026 05:31:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2343F3D0926;
	Tue, 16 Jun 2026 05:31:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587908; cv=none; b=XQC7TSPPbq37AIBuwCdMmpofBeNOCbTbtMk3xrPC0SjgUyxLeEHUZw45dj6vOd6Og3597o5iM00HPsupyLEY6azALCPYA+KurufZrKHqJ8o7irNNiOHosw7NxDXm30+axjHzyLAGFKugbBgZKFMKsVoADKg2EhaOC87XEHFh1Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587908; c=relaxed/simple;
	bh=2DHGdkh+LxkF8N/SJ1IAj8JluhHq4Cb1Ynj6/3QS7GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ta0K5svlzRiToi6j2SoDKToM3eCqO0jBzwM1wa0dZ4dvCDa0CQbhbbYiB1zODJcH/d5+VhvSimseSmZmbqa2tgN8YcwX5UvjQqpIwubxPDli14wqmQTHCGEqfBpWHMOuXAogsP7v38mTZ06i1j+aNN9yFU2Ykei/WeQlmKSv5Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BRgLH8Lb; arc=none smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781587906; x=1813123906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2DHGdkh+LxkF8N/SJ1IAj8JluhHq4Cb1Ynj6/3QS7GQ=;
  b=BRgLH8LbqIixV1lzdvD+/kDlrpb2vNtWOKc8v3AranJxS4IsMhnK3M0P
   gVoIS8vSofNmQXRtQ8o/JH/1KaovXX4DDrhPsXSdtuN8pQy62Pz+ULriK
   M5JO3C7EC+177KCPatTklmI4ODzW4l1QpD3UCLa0ouv595OQNwMsdmB/S
   X2ThSmQY1KjF2IGpgF1CEnO9CcdwAVr88w2VLKNvzijeuhCWBMQP5OcP9
   wl3dCkdoyawPa4sD+rn9q2zh9iOD/ervPIzllZerFzeHwOp47hvQ2wN0x
   wUgYAGt00+pPDJG/htUMtdy5L/D5ppjufY7qlWbBB8PxFZxafEdUuwFgA
   Q==;
X-CSE-ConnectionGUID: AkqlWstqQdmAPgGZdVXZhg==
X-CSE-MsgGUID: N/Br3uTuSFy58WtrL/AWGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="107772717"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="107772717"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 22:31:45 -0700
X-CSE-ConnectionGUID: n42ZcPFkR/isOZj3lnwUSg==
X-CSE-MsgGUID: gqesfjdSSDG/SZHim1et1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="285784566"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 15 Jun 2026 22:31:41 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wZMOf-00000000Skg-0Hmh;
	Tue, 16 Jun 2026 05:31:37 +0000
Date: Tue, 16 Jun 2026 13:31:14 +0800
From: kernel test robot <lkp@intel.com>
To: Luigi Rizzo <lrizzo@google.com>, rizzo.unipi@gmail.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com, willemb@google.com,
	kuniyu@google.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	gregkh@linuxfoundation.org, rafael@kernel.org,
	akpm@linux-foundation.org, david@kernel.org, netdev@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux.dev,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
Message-ID: <202606161322.zGyw68Qa-lkp@intel.com>
References: <20260615234220.3946885-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615234220.3946885-1-lrizzo@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299736-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lrizzo@google.com,m:rizzo.unipi@gmail.com,m:m.szyprowski@samsung.com,m:robin.murphy@arm.com,m:willemb@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:llvm@lists.linux.dev,m:oe-kbuild-all@lists.linux.dev,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:netdev@vger.kernel.org,m:linux-mm@kvack.org,m:iommu@lists.linux.dev,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:rizzounipi@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[google.com,gmail.com,samsung.com,arm.com,davemloft.net,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,git-scm.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 26D0268C307

Hi Luigi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v7.1 next-20260615]
[cannot apply to driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luigi-Rizzo/swiotlb-avoid-double-copy-with-swiotlb-on-tx-socket/20260616-074655
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260615234220.3946885-1-lrizzo%40google.com
patch subject: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
config: powerpc-pmac32_defconfig (https://download.01.org/0day-ci/archive/20260616/202606161322.zGyw68Qa-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project e19d1f51a2c80b63cd8ca95bcc757b7077112808)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260616/202606161322.zGyw68Qa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606161322.zGyw68Qa-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: net/core/sock.c:3215 function parameter 'sk' not described in '__skb_page_frag_refill'
>> Warning: net/core/sock.c:3215 expecting prototype for skb_page_frag_refill(). Prototype was for __skb_page_frag_refill() instead

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

