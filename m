Return-Path: <netdev+bounces-257659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNarJwRohmm4MwQAu9opvQ
	(envelope-from <netdev+bounces-257659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 23:15:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B62ED103B03
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 23:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CB0E3052341
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 22:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766F930E856;
	Fri,  6 Feb 2026 22:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HWGEoAqD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3E030E821
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 22:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770416096; cv=none; b=fCsMGAmFhC4dLvHYrTm3awfCxFnwSth8t6Ue+zbYLkvUfEjNMgWDxupceOtYBx9wiRem4f5Hr3qR8f39pJ9sBmJY7SfOS+SzRu32BqCfBiv6U59+d8+18KUx6Vb/fpmQRu28ZjYhghYk8S0Jz4PoEJBXFhd+9mlr7At6P/8ggG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770416096; c=relaxed/simple;
	bh=uh56Ld9r8AlvRahEXfLHL1h+qo6PypS4yomZDOxd6Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWOmiWUC/RRrC4n43ao01LctN4Vv864qmbJnjP7kRFVXLrKbpIorynfhmCbUXvSJsjNkl/XxQngeEnc6408o47phNcS0yMMQvOuURKBiyfFu3SOHVTKzXLS+w09Ek+JTxqi/Dyf+MwM2nkY+chkw12+kqWevMvJxh2v/QFpJt1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HWGEoAqD; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770416096; x=1801952096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uh56Ld9r8AlvRahEXfLHL1h+qo6PypS4yomZDOxd6Lc=;
  b=HWGEoAqDE9DiT+MvJyBpXMEeeBtnSGWpPPjJV09dFsnKB7BfzHtU/aNp
   j22JER303vYmvC8I5NAL5uOWbOlObXNbejsFR88eilkMx4Oaab+LKK0kr
   FqsXb7L+HlbDleLJbmociyguJzeKpomBCNuPTKj46g+xfe9xYu9rSSUhC
   lYzo9eF7/9FYj3UhRq9PAZgVVeFZ0heOS6xtGRi57ta7WNM5yIPRMj3iE
   8XByFitFzezwZChsfZfh9Qs9UqhKGvAV2Ffnz1oQlOfoQKaVIKmdpFgux
   lBOz4it2KsDU+a/X1gYaB1Vtb086ZQEIgzyBGKNtmBpl094DYIwtlh4DT
   w==;
X-CSE-ConnectionGUID: T3e4W/obTzKTnjFwattvZw==
X-CSE-MsgGUID: JcaNHFmvS9qpxo9bSlGbxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="71810296"
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="71810296"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 14:14:55 -0800
X-CSE-ConnectionGUID: kAf8gZC2Tui2/R+mVQeRxA==
X-CSE-MsgGUID: O9MtuTLWQIemjHxFGGIiVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="233939442"
Received: from igk-lkp-server01.igk.intel.com (HELO afc5bfd7f602) ([10.211.93.152])
  by fmviesa002.fm.intel.com with ESMTP; 06 Feb 2026 14:14:52 -0800
Received: from kbuild by afc5bfd7f602 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1voU6D-000000004j3-14lf;
	Fri, 06 Feb 2026 22:14:49 +0000
Date: Fri, 6 Feb 2026 23:14:46 +0100
From: kernel test robot <lkp@intel.com>
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, virtualization@lists.linux.dev,
	parav@nvidia.com, shshitrit@nvidia.com, yohadt@nvidia.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgg@ziepe.ca,
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	edumazet@google.com, Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [PATCH net-next v20 05/12] virtio_net: Query and set flow filter
 caps
Message-ID: <202602062314.1P5VPlUN-lkp@intel.com>
References: <20260205224707.16995-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205224707.16995-6-danielj@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257659-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.961];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: B62ED103B03
X-Rspamd-Action: no action

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Jurgens/virtio_pci-Remove-supported_cap-size-build-assert/20260206-065356
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260205224707.16995-6-danielj%40nvidia.com
patch subject: [PATCH net-next v20 05/12] virtio_net: Query and set flow filter caps
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260206/202602062314.1P5VPlUN-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260206/202602062314.1P5VPlUN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602062314.1P5VPlUN-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/virtio_net_ff.h:9:10: fatal error: uapi/linux/stddef.h: No such file or directory
       9 | #include <uapi/linux/stddef.h>
         |          ^~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

