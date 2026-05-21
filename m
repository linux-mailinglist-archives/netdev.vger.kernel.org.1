Return-Path: <netdev+bounces-290602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOL/OTVnD2pKKgYAu9opvQ
	(envelope-from <netdev+bounces-290602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 22:12:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E535ABAAA
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 22:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0784330234DB
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553873769E3;
	Thu, 21 May 2026 20:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="buyHC+V8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE36202997;
	Thu, 21 May 2026 20:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779394354; cv=none; b=Mw9jp9yqwMd1PxJ6uK7ee7MVx0cuDKDIKwpDaXxYC0fgqIcDwohPne7NOaLMh4l7KOZsoy8NJ5EV1LHKDOUrP6XNmRUAh1cCcyp9mGoMu0vX/6c6df84WgspCtVG46AVDDhDccfmm+bBvh+v1C3me34XYbvkTO+wfNSKuD0rDK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779394354; c=relaxed/simple;
	bh=Cfj4pAEMUJXQ0LlOrL+bUWwL556VY9ZDnN4iJSVIhUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1oxYkBLzs4WTQZV2C7GpKK2dlLYBeE+PtfBuEkrI0TDGXgOcKVDzYLvFE6IlGy4PkSSEeDpWxA8neh6h/2abzd7/C3AwJ1rPvngtT8ZlXBvu+g20E7T7e8GJcPgqAbXgOQPtVH9PRfQ3EAfDREjxC8KPGiuA/63IQjI31CSyO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=buyHC+V8; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779394352; x=1810930352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cfj4pAEMUJXQ0LlOrL+bUWwL556VY9ZDnN4iJSVIhUk=;
  b=buyHC+V8sYY0VaKJlWQj0+8bmA4AKx0LjaNTTh74LjtMhUUaMojxgt6b
   7vX6iDI3igETKPI32DP9+XW/DkVg2l6J+jthxQ7YOo7GeyAuROM9367/9
   U9dGdfX4s3zzm3oRKvZMyLNlAS20zTegerrc1HAVtUy9EPl0JFF5Vr6ne
   /8k0AcI01x1lYAM2VhfHM6SC3mto26jMuZ+KSyft6DWMkv/U2TeD7Bv59
   X4WZS5GThcCnWf4/QIsuaQWfus0y1BlSUKqHs5UzlG63OmzqM/CQ1e4+v
   /EiRhafENbFWVK7qg0Oq+yy+WUFLW2ysp07TPc1Erkwru4g4KIihDmuWA
   w==;
X-CSE-ConnectionGUID: 3CWsu73jSKmBWytvx6Moww==
X-CSE-MsgGUID: rK5f8fQLRi+WIium+epHUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="91793298"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="91793298"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 13:12:32 -0700
X-CSE-ConnectionGUID: K97JLA7+TfCzLu/0fxkLmA==
X-CSE-MsgGUID: HFoLqunTSUybqUnZVQXJuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="270989249"
Received: from lkp-server01.sh.intel.com (HELO fdb68b0ce653) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 21 May 2026 13:12:29 -0700
Received: from kbuild by fdb68b0ce653 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wQ9ko-00000000169-0hCv;
	Thu, 21 May 2026 20:12:26 +0000
Date: Fri, 22 May 2026 04:12:05 +0800
From: kernel test robot <lkp@intel.com>
To: Chuang Wang <nashuiliang@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Chuang Wang <nashuiliang@gmail.com>,
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
Message-ID: <202605220442.6N3NuEDL-lkp@intel.com>
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
	TAGGED_FROM(0.00)[bounces-290602-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmail.com,google.com,kernel.org,redhat.com,fomichev.me,linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,01.org:url,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 45E535ABAAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Chuang,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Chuang-Wang/net-reduce-RFS-ARFS-flow-updates-by-checking-LLC-affinity/20260521-223039
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260521133711.20725-1-nashuiliang%40gmail.com
patch subject: [PATCH net-next v4] net: reduce RFS/ARFS flow updates by checking LLC affinity
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20260522/202605220442.6N3NuEDL-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260522/202605220442.6N3NuEDL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605220442.6N3NuEDL-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "sock_rps_record_flow_hash" [drivers/net/tun.ko] undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

