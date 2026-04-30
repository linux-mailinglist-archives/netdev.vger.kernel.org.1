Return-Path: <netdev+bounces-282911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNtOF6d382mt4AEAu9opvQ
	(envelope-from <netdev+bounces-282911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:39:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D851C4A4F0E
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24D01302BA2B
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68DB3358B0;
	Thu, 30 Apr 2026 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DU2Qdlgu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64531336891
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563492; cv=none; b=A5PtbnSJAn5PBUDZLd+f4HkN3/NbT6J9NHnbfrckfuc2hEkx8RwA3wHz3cQNQwgOGaRyX/wR0otTte1Pi/fc30/pUdyJ6cAKDAHwkidMLy5Xb2xJKa9wadjeVG6mQeH5Qu3w8oR4RvbqF/nrgpBF/HiGknqGcoNnD1kTUpbANdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563492; c=relaxed/simple;
	bh=cas+fx9QXakeDSvStqAi7Mu9SLnLX6s+1H6MiiTcWN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2t0WXTJosw+9U9xWPAXrLEG5jZDRYm3F3i+fLHjr5O9g0uxvao3i8U1K1wjPB0TSaOLXRiqtrb+nvUUA8u5rdp6XeNdT+6MGmaPhgQV0njPpkobvPk/61lcoKtyg3TpYd9ke63ScLDo5VAo9mTljP5lv8kSrfCvn2HD77457OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DU2Qdlgu; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777563488; x=1809099488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cas+fx9QXakeDSvStqAi7Mu9SLnLX6s+1H6MiiTcWN4=;
  b=DU2QdlguVrB9zAqGwlOaZu8LpV+fi+nBGPbXfCjgfGQtp5kEX64xYjAW
   mmRPwlLfIjanNfgk4Vufqv6FpdcPikNMe96+yXd1GTxur6nkVWCNGNUKI
   JqHKGZtPj6RBKXOFT1YQ94czGxWO27Act36j1K8CO3hZNaYLP2N31uxVR
   HluoUWzsifm3ClEfVen0vLEjHNPZUHduluPtZchFykAmTeOUvgcz7iSSg
   UqG/1EyJqxsTbkGWz86gLVG+zew6OXfoYC33B7JPtjC/4dEYMWBLQsoxP
   WSSaFyV3Wvq7Ksqdhdc+1TnxPmcmS3PO91RkiRwZhTjLtIBExmnbh093E
   Q==;
X-CSE-ConnectionGUID: HaT2ZI3ST/Wn0q9CG5k7Vg==
X-CSE-MsgGUID: YgfMftBeTn+SOtv1XX9CrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="78711877"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="78711877"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 08:36:41 -0700
X-CSE-ConnectionGUID: 0mtNTPv5QliVKNuQbrjNuQ==
X-CSE-MsgGUID: dPci9gAPRvmQGjxZuj+76g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="230261005"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 30 Apr 2026 08:36:38 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wITRK-00000000CXY-2GqI;
	Thu, 30 Apr 2026 15:36:34 +0000
Date: Thu, 30 Apr 2026 23:36:17 +0800
From: kernel test robot <lkp@intel.com>
To: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, jbenc@redhat.com,
	yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
	bird@lzu.edu.cn, lx24@stu.ynu.edu.cn, caoruide123@gmail.com,
	n05ec@lzu.edu.cn
Subject: Re: [PATCH net 1/1] net: nsh: handle nested NSH headers during GSO
Message-ID: <202604302359.kU59LnTI-lkp@intel.com>
References: <6112cce99b4e3571444a616d0fb19e91e2fcca72.1776597598.git.caoruide123@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6112cce99b4e3571444a616d0fb19e91e2fcca72.1776597598.git.caoruide123@gmail.com>
X-Rspamd-Queue-Id: D851C4A4F0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282911-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lzu.edu.cn,stu.ynu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]

Hi Ren,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ren-Wei/net-nsh-handle-nested-NSH-headers-during-GSO/20260423-084001
base:   net/main
patch link:    https://lore.kernel.org/r/6112cce99b4e3571444a616d0fb19e91e2fcca72.1776597598.git.caoruide123%40gmail.com
patch subject: [PATCH net 1/1] net: nsh: handle nested NSH headers during GSO
config: i386-randconfig-003-20260430 (https://download.01.org/0day-ci/archive/20260430/202604302359.kU59LnTI-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260430/202604302359.kU59LnTI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604302359.kU59LnTI-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "skb_network_protocol" [net/nsh/nsh.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

