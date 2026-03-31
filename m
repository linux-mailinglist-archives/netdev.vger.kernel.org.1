Return-Path: <netdev+bounces-273714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ3RLbYKzGnGNgYAu9opvQ
	(envelope-from <netdev+bounces-273714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:56:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D60136F809
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C9983056150
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF28401A05;
	Tue, 31 Mar 2026 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S5oaBaBC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC91B3E024E;
	Tue, 31 Mar 2026 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978412; cv=none; b=inDkRmexHrzKzLLNqLBwAjyBnNd8Lu6UkMKZ96xptnHOOMdH0WfTYRgSyM7kfn9TvDK4W98J2PbSkpwMhFO5BmFk9Gr1Xo/FekWUZ5vS3Sk4zp0eg4lCQk0Osf9VTYsExHy/9e+TpRGDiiA4y9Z10jLVZDZX/0MOij8GdC/kSsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978412; c=relaxed/simple;
	bh=6yuP0HLOVGo5gujSvyYIlb0a329339oNKp1hUorFe+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zlx52aL8guPK8dmgREXKjfFU944SV4QorAF8CKDSIc+lQPqtwabFQGznQ8zORkIcEgV3xJEZFpKr0g7ctOS/lm/0DWGDUrAtrrtky6QocZFm/yjz0PiCg42bGzseExIbrcKiMWA2maiQc6ZM0nyhz4tGqA+/OeWPfxflB5o74H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S5oaBaBC; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774978411; x=1806514411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6yuP0HLOVGo5gujSvyYIlb0a329339oNKp1hUorFe+k=;
  b=S5oaBaBCFw8kAbu7/75wuveKU345oYzL+UiShjioTO1YMBaY0519Dr7U
   iaCdJdRjodzKYqLAvSVe/RlozjUiI6BjnSq6xyIiYsQPc2XsQsjhcFAgK
   3Woill/hxo6ymgpK6upjWw6x+Hcsv1fMvNroaOiQSHw2cBM9j5unOyB0M
   4j3rDX8T886VP0MSaMagLKpL3QUr9swpkVtoijHuIsEu5Ug5Yt/ueej2m
   +xxbEbBerCZGeT0Txbj78E+1S5GzR8C81c01A6QSpcK2cnkh2nWUlJlS2
   S3pis0exh39gPQgzCci+OVp9qZD21UpIrt9289SgWJsbZwgEBRzDrn8sz
   Q==;
X-CSE-ConnectionGUID: MWWUhUofRbqtUicLzvwklA==
X-CSE-MsgGUID: NMJAlDnxTrm0JYH6ZwsrBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75035936"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="75035936"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 10:33:30 -0700
X-CSE-ConnectionGUID: S6A6JxILTJ+fszX8afT7Vg==
X-CSE-MsgGUID: uXebTl5ESbGFHy0OO877Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="225431662"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 31 Mar 2026 10:33:27 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7cxv-000000003wT-3ows;
	Tue, 31 Mar 2026 17:33:23 +0000
Date: Wed, 1 Apr 2026 01:33:14 +0800
From: kernel test robot <lkp@intel.com>
To: Jordan Rife <jrife@google.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jordan Rife <jrife@google.com>,
	bpf@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH net-next v3 2/4] udp: Remove disconnected sockets from
 the 4-tuple hash
Message-ID: <202604010147.jxlA7slL-lkp@intel.com>
References: <20260330215707.2374657-3-jrife@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330215707.2374657-3-jrife@google.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lists.linux.dev,google.com,vger.kernel.org,gmail.com,iogearbox.net,linux.dev,fomichev.me,kernel.org,isovalent.com];
	TAGGED_FROM(0.00)[bounces-273714-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 0D60136F809
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jordan,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jordan-Rife/udp-Only-compare-daddr-dport-when-sk_state-TCP_ESTABLISHED/20260331-082300
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260330215707.2374657-3-jrife%40google.com
patch subject: [PATCH net-next v3 2/4] udp: Remove disconnected sockets from the 4-tuple hash
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20260401/202604010147.jxlA7slL-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260401/202604010147.jxlA7slL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604010147.jxlA7slL-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/ipv4/udp.c: In function 'udp_disconnect_unhash4':
>> net/ipv4/udp.c:2182:38: error: implicit declaration of function 'udp_get_table_prot'; did you mean 'vm_get_page_prot'? [-Wimplicit-function-declaration]
    2182 |         struct udp_table *udptable = udp_get_table_prot(sk);
         |                                      ^~~~~~~~~~~~~~~~~~
         |                                      vm_get_page_prot
>> net/ipv4/udp.c:2182:38: error: initialization of 'struct udp_table *' from 'int' makes pointer from integer without a cast [-Wint-conversion]


vim +2182 net/ipv4/udp.c

  2179	
  2180	static int udp_disconnect_unhash4(struct sock *sk, int flags)
  2181	{
> 2182		struct udp_table *udptable = udp_get_table_prot(sk);
  2183	
  2184		udp_unhash4(udptable, sk);
  2185		__udp_disconnect(sk, flags);
  2186	
  2187		return 0;
  2188	}
  2189	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

