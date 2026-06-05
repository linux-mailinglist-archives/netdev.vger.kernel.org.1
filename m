Return-Path: <netdev+bounces-295639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id spCLKfFmImqSWgEAu9opvQ
	(envelope-from <netdev+bounces-295639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 08:04:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9222B645641
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 08:04:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=jeCFhNRL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295639-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295639-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98E8F3009FAA
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 06:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC48C3B47E2;
	Fri,  5 Jun 2026 06:01:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120373A63FB;
	Fri,  5 Jun 2026 06:01:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780639280; cv=none; b=hu9Oez0YF/Cwo5ah5Z/3ygnC8lkUCp1ytWgh2P9kn5wfzC27yIDAHQYhVjoVjV90JkvlNscLnqvb2Ir+zzy3Kf+8Jes0ICJT8M3rrADLrXQ5NelbDK0z9KImlvS2oACWF1pWxD0jfDRWzJPRA057BnXg4EN5/4hmZTdB02VJQM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780639280; c=relaxed/simple;
	bh=pwf0wZycWIB74FEdk6ZWRdAr2lkOkJJ4eHWOmuTLt90=;
	h=Date:From:To:Cc:Subject:Message-ID; b=klfn1ghPd+UPyJKnhynFj/gUfocn0lmYgbMRPP4Yu5vso/nRynBxXLjVPYqQnqw6xtHQmRLfblRX+hWMkIZOYy+IKzMtAkpKBhw6oQqfEbOHYWYE3uE5SXEikA7OlH+fGZx/dO1cv/6YmqdJxd86EJTnWdrEGPOnXDJDbIcViXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jeCFhNRL; arc=none smtp.client-ip=192.198.163.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780639278; x=1812175278;
  h=date:from:to:cc:subject:message-id;
  bh=pwf0wZycWIB74FEdk6ZWRdAr2lkOkJJ4eHWOmuTLt90=;
  b=jeCFhNRLPs3CZvlmDAiM6w1oqIqj8/ujK5y5Rh4ldwsOYGwRZ9xWL6Fd
   VaPzIitpF2gKml/Fujw5xYRbw/MhLBvp0m/kht98Z5bW9aG+Fmg5CtiEC
   PkBHZDuJFkrLOVMII3He96pS9eEs6gBBQ4gWSEVlB81uCNf/+ApyMwXRi
   1Cd7kH3EJTB9v4iLXrpCKw76u1CwE2TCfsXcNEqTvW2lzALlqkkVuwNI2
   KtGuebpNW3nHTIYOPcGUAYaSawCitsKmJG9Jn768QnL2OGfM4iD/TnJDK
   uog/9lW8YXlx199XUzQUSdt1SmwVkUKEXlPqCGSTucSUmdBDXMTABKXaK
   g==;
X-CSE-ConnectionGUID: JxICuhytSAWctW762vd9yQ==
X-CSE-MsgGUID: lJXHzsE8TuSRlQ/Luugldw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="80508287"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="80508287"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 23:01:18 -0700
X-CSE-ConnectionGUID: FH3mjjDCQb6yF94GuzbviA==
X-CSE-MsgGUID: 3X7qmvnbQ8qRqa0ddK/Tuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="238401965"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 04 Jun 2026 23:01:16 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wVNcH-00000000Faw-293F;
	Fri, 05 Jun 2026 06:01:13 +0000
Date: Fri, 05 Jun 2026 14:00:32 +0800
From: kernel test robot <lkp@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [mst-vhost:balloon 12/38] page_alloc.c:undefined reference
 to `folio_zero_user'
Message-ID: <202606051337.Pac8xsTQ-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-295639-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:oe-kbuild-all@lists.linux.dev,m:kvm@vger.kernel.org,m:virtualization@lists.linux-foundation.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9222B645641

Hi Michael,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git balloon
head:   b145636d693114d343a0a47a4400f5b31e211fec
commit: c4af912c65bc897b31264a3403f18b0cf52fa10c [12/38] mm: use folio_zero_user for user pages in post_alloc_hook
config: m68k-allnoconfig (https://download.01.org/0day-ci/archive/20260605/202606051337.Pac8xsTQ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260605/202606051337.Pac8xsTQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606051337.Pac8xsTQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: mm/page_alloc.o: in function `post_alloc_hook':
>> page_alloc.c:(.text+0x3b42): undefined reference to `folio_zero_user'
   m68k-linux-ld: mm/page_alloc.o: in function `get_page_from_freelist':
   page_alloc.c:(.text+0x546a): undefined reference to `folio_zero_user'
>> m68k-linux-ld: page_alloc.c:(.text+0x550c): undefined reference to `folio_zero_user'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

