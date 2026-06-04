Return-Path: <netdev+bounces-295359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bML1MY6uIWqvLAEAu9opvQ
	(envelope-from <netdev+bounces-295359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:57:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AA26421EF
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:57:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=lTve8epX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295359-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295359-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27743301C5BD
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 16:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8530347F2EE;
	Thu,  4 Jun 2026 16:52:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC91A2DCF4C;
	Thu,  4 Jun 2026 16:52:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780591925; cv=none; b=fOPVyvqUWyuUsotNpvLENC6lS9ojWRYI7IeNRovVBDbieE5yBOCFB/KZJCssdFqv/qZA0OXamX1acKGSUmosZ2STtV+AcHKWgXrqk2cvc+jOtjiEI029oCIKynmZh5SeVvq1o4a+tuhrKmywhtURZJWUq34OaCV520ySHIC32sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780591925; c=relaxed/simple;
	bh=bGekkKMrvCJEuovAEAIlT2J2j0aiywvMyBg8Z6i9Vzs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=R3kjfadvIitHLLvUYZebJZ44y1tOqPCF6eDWfHQX4Ie24Ipg0vaRU2zOkTq7NhUf9le1oxseD6ob9+s4et3Xllg6reuZ7LfCEDBldVqgxpbfDqcI361I7sSNxMZWy7Daidgkdi0QI38Hk7fNFrok17qYLdZUrVNOdH1N6keP+Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTve8epX; arc=none smtp.client-ip=192.198.163.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780591923; x=1812127923;
  h=date:from:to:cc:subject:message-id;
  bh=bGekkKMrvCJEuovAEAIlT2J2j0aiywvMyBg8Z6i9Vzs=;
  b=lTve8epXJRUX7449wRVw6hOXJYZxTCge2b3iUU/HX2+BOowQWnHcoLWG
   DDirIFItHckFogNPB15wQYgHRpskRUlnuk0XieG9NfxfWNqbt4iTxrFpm
   20opisnklGfDr5xj6xRRIgCgT2thuJloa6i6/aZ0q79yGbUzqsK8m5sct
   YutyZ79AC+8Fbm1xZj+OQQmH5bJjDqcucFxi2rTO6DfpXFXFh2V7ouAqy
   +3HxVq7ZISIDJ4Dl9ywiYmiyuOncSb549jYnxb2EHBV9WVWMxunHwgSLQ
   iiv4lWBUvjRb0E7CJ5ZqaGGf/cAgW0gjKo9p2n76sQ9hYrBPOfwhEfrVk
   g==;
X-CSE-ConnectionGUID: pEQuQOx3SHGyxvfYvSU0bQ==
X-CSE-MsgGUID: IIn+ulVeQI2VoaAn7VXNyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="92106473"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="92106473"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 09:52:03 -0700
X-CSE-ConnectionGUID: BEgr8ZQkSpu+xFIcKwRHeA==
X-CSE-MsgGUID: /48/aHS1TOy2K90wato3CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="238251939"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by fmviesa009.fm.intel.com with ESMTP; 04 Jun 2026 09:52:01 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wVBIV-000000002MH-2epl;
	Thu, 04 Jun 2026 16:51:59 +0000
Date: Thu, 04 Jun 2026 18:51:45 +0200
From: kernel test robot <lkp@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org
Subject: [mst-vhost:balloon 8/38] Warning: mm/page_alloc.c:7002
 function parameter 'user_addr' not described in '__alloc_contig_frozen_range'
Message-ID: <202606041824.6UhiUn3N-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-295359-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:llvm@lists.linux.dev,m:oe-kbuild-all@lists.linux.dev,m:kvm@vger.kernel.org,m:virtualization@lists.linux-foundation.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,01.org:url,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00AA26421EF

Hi Michael,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git balloon
head:   ffd91da19b20a15bbcff7438ef1ad0031c110395
commit: c2b251ca61f1a3911a1c9ea9d1a5511a4da1aa1c [8/38] mm: add alloc_contig_frozen_pages_user for cache-friendly zeroing
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260604/202606041824.6UhiUn3N-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project f43d6834093b19baf79beda8c0337ab020ac5f17)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260604/202606041824.6UhiUn3N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606041824.6UhiUn3N-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: mm/page_alloc.c:7002 function parameter 'user_addr' not described in '__alloc_contig_frozen_range'
>> Warning: mm/page_alloc.c:7002 expecting prototype for alloc_contig_frozen_range(). Prototype was for __alloc_contig_frozen_range() instead
>> Warning: mm/page_alloc.c:7266 function parameter 'user_addr' not described in 'alloc_contig_frozen_pages_user'
>> Warning: mm/page_alloc.c:7266 expecting prototype for alloc_contig_frozen_pages(). Prototype was for alloc_contig_frozen_pages_user() instead

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

