Return-Path: <netdev+bounces-290630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAnbOW+SD2oJNgYAu9opvQ
	(envelope-from <netdev+bounces-290630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 01:17:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 600A45AC89F
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 01:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0EC9301572E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 23:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54A234EF1F;
	Thu, 21 May 2026 23:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+N8k20L"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DD1344D9B;
	Thu, 21 May 2026 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779405416; cv=none; b=DjUVpFWhJYvVJoqcpDgQQzCxIJXPfK2luCIGoo5j8sAlsWojRX5W/usX1O7BPhf8501W2iWj+oBNTdyST/J450lIGvoRpBUImmBoraHI1+sUspvNN6EmkaVo36K1HHaEDjdZ19J8/NMWrcL8X5wXoo+Wvl1ycUKVBdFTIfGcdeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779405416; c=relaxed/simple;
	bh=cTlRn69Eqnrfv5gb6kYtbXsB/t6BrmvwRAeux77JNp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJtxKgOt7z5FM5WpkB9r80tlFUn9jjkhII47V7Uqcflth5QEwW2unw7pbZHvRIPGODoTX3lkPwhaflxhdqRYsnu2rDU01qasVSsvdT18L0nSDET4j2exkZ42USZowSjK0HbK5xERdcB345CkQTalO70gTozvraHzbO/73GpPLj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+N8k20L; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779405413; x=1810941413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cTlRn69Eqnrfv5gb6kYtbXsB/t6BrmvwRAeux77JNp8=;
  b=G+N8k20Lgek1sDK2hjP0h3yJDVUqiV0j/+zw3H+ja3Bgq7AeDu8yVOf3
   ndy6Bz7VQUeYSnx0GhiMSLm4PAnZLXb6s2I4myuwptdn0xJGpQxe7mkc6
   q85yZc64txaMG+ZvKQR6ViRwBWgajUIPbW73Pb5lHuV8Lc4adgQnRJh46
   RekidDomww5CjTLsY6uAab0fYIdu/wVzb/XyMF9XzgZwiWlZSTHGceyEx
   zR4vgtv0Lm8S04gCwdryIZx1LKTt6dqbuLvaFFsd57H7oQ9j7OvYyqxE5
   YtUR8nSwTAp8yFbLHYazyw+LdJL/x6oN6QKDCAqt+O4toqo9CfO3XGYdt
   Q==;
X-CSE-ConnectionGUID: NMhggxavQ3C5aZTwdcnolw==
X-CSE-MsgGUID: fiiSiRukQxKwgXw/JYVD9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="97758578"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="97758578"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 16:16:51 -0700
X-CSE-ConnectionGUID: ZiLJkafsQWuVlPOboch67g==
X-CSE-MsgGUID: Qjr/RMbbSCaDuosBYtPq8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="240737782"
Received: from lkp-server01.sh.intel.com (HELO fdb68b0ce653) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 21 May 2026 16:16:48 -0700
Received: from kbuild by fdb68b0ce653 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wQCdA-000000001L3-2qe3;
	Thu, 21 May 2026 23:16:44 +0000
Date: Fri, 22 May 2026 07:16:09 +0800
From: kernel test robot <lkp@intel.com>
To: Chuang Wang <nashuiliang@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Chuang Wang <nashuiliang@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: reduce RFS/ARFS flow updates by
 checking LLC affinity
Message-ID: <202605220754.aEHPLGaI-lkp@intel.com>
References: <20260521133711.20725-1-nashuiliang@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521133711.20725-1-nashuiliang@gmail.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290630-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmail.com,google.com,kernel.org,redhat.com,fomichev.me,linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,01.org:url]
X-Rspamd-Queue-Id: 600A45AC89F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Chuang,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Chuang-Wang/net-reduce-RFS-ARFS-flow-updates-by-checking-LLC-affinity/20260521-223039
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260521133711.20725-1-nashuiliang%40gmail.com
patch subject: [PATCH net-next v4] net: reduce RFS/ARFS flow updates by checking LLC affinity
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20260522/202605220754.aEHPLGaI-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260522/202605220754.aEHPLGaI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605220754.aEHPLGaI-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "rps_llc_check" [net/sctp/sctp.ko] undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

