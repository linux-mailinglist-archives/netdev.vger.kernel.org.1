Return-Path: <netdev+bounces-273722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9Xz5BVsOzGmHNwYAu9opvQ
	(envelope-from <netdev+bounces-273722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 20:11:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF6D36FC4C
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 20:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 41A96300F29F
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB02C4418DC;
	Tue, 31 Mar 2026 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sp8yYlAU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1189D425CC4;
	Tue, 31 Mar 2026 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979801; cv=none; b=cajhfywXGuZWRnZYzNsf+mfumiT3xBQK9wGCsA18+C3rC5aMpriuiEsu5QUNu6lFCLG8w6tC1PLD/Y2NZVB90HwfkD4XbqKk/qTeYXT3ketJytw711cMCNk5nVq1g09f04atbJUwyd+y88dyqN5e9o1yxX8wv/8FYIcXbRZpTAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979801; c=relaxed/simple;
	bh=DwkTCA5YmgJHm81msbMX/aBjsel/Wf5D82F5TzSEOqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdxqIfn/5yJgvsuwls64PiQnWGq/M6rsrNAlnQZHjewz86CYm40fsQnj+hLkPO//Qm3B/DIoSiNHaDUo7Tap1mL/AdwM50qdQUE/jjACtSwGFNncUkPyf/KZEKcICq9U8GbNkRp7cn3rt8VSG2XM75TBPqlywuQ6xyXrvvCAzVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sp8yYlAU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774979799; x=1806515799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DwkTCA5YmgJHm81msbMX/aBjsel/Wf5D82F5TzSEOqY=;
  b=Sp8yYlAUZ+FWSJm2EhytySrNyJIq2XxSyspqU8JZ7erRj+CJR9PaMZu5
   gtw4RUKdFWL9wwgLSN/7cO/UzWZDrrFtSBJ9aTgG62haXoVNvxfpdTH0+
   Ai6GfBjg5QpD4IKCXEETuc9WhuSF8vNan/+axtycsguyBBE0uTdaA98KR
   R3tBCT/QP34JsdMOe0cZbUSBzkdyV0jdt4eS9cB8jCvAkjZ4u8Rpb2dSU
   jGNhJKDkCo9onvvOeY9z30Yv89rBGUQNISgebEv+5DQci6iy5Xr6Pcpzr
   kBbPDtwG/Yzn4vmPJnFUMO7ak2OIBA5elcz2O69yebEt2h63kh+ia9n6C
   g==;
X-CSE-ConnectionGUID: dFQJIvm8Twqvzdz2KzLzvQ==
X-CSE-MsgGUID: lIasQNU+TmyNd3/oKWIjEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="87078481"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="87078481"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 10:56:38 -0700
X-CSE-ConnectionGUID: TKI0kEJZTii6/2w99M5+yg==
X-CSE-MsgGUID: 7PbP8QNgS1SXzDQYsDBchw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="230501582"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 31 Mar 2026 10:56:33 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7dKI-00000000461-3IPB;
	Tue, 31 Mar 2026 17:56:30 +0000
Date: Wed, 1 Apr 2026 01:55:44 +0800
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
Message-ID: <202604010154.iewJbUya-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lists.linux.dev,google.com,vger.kernel.org,gmail.com,iogearbox.net,linux.dev,fomichev.me,kernel.org,isovalent.com];
	TAGGED_FROM(0.00)[bounces-273722-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,01.org:url,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 1CF6D36FC4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jordan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jordan-Rife/udp-Only-compare-daddr-dport-when-sk_state-TCP_ESTABLISHED/20260331-082300
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260330215707.2374657-3-jrife%40google.com
patch subject: [PATCH net-next v3 2/4] udp: Remove disconnected sockets from the 4-tuple hash
config: sparc64-randconfig-r071-20260331 (https://download.01.org/0day-ci/archive/20260401/202604010154.iewJbUya-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
smatch: v0.5.0-9004-gb810ac53
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260401/202604010154.iewJbUya-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604010154.iewJbUya-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/ipv4/udp.c: In function 'udp_disconnect_unhash4':
   net/ipv4/udp.c:2182:31: error: implicit declaration of function 'udp_get_table_prot'; did you mean 'vm_get_page_prot'? [-Werror=implicit-function-declaration]
     struct udp_table *udptable = udp_get_table_prot(sk);
                                  ^~~~~~~~~~~~~~~~~~
                                  vm_get_page_prot
>> net/ipv4/udp.c:2182:31: warning: initialization of 'struct udp_table *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   cc1: some warnings being treated as errors


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

