Return-Path: <netdev+bounces-299024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DH+DA3q1LWqEiwQAu9opvQ
	(envelope-from <netdev+bounces-299024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 21:54:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CC467F7A3
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 21:54:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=GfxcOS87;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299024-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299024-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C24603011BFA
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03027358368;
	Sat, 13 Jun 2026 19:54:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FE39475;
	Sat, 13 Jun 2026 19:54:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781380469; cv=none; b=ZoNUPjq7p66CayQf0AIPctNepmKBeH6TcjeRWKcmEKEhs/YgK4of4WTnechmF5qaqImaR+Ni0Rh4ENEoGIhpeEjQgFkOcGWvLgzl0tV99Ve2DAOi7sTvJ4dKTUb3lJS3f3cy2fgz6gtGLiZH5ZBc1Cv4W0W5oKQZt+hEOn/CGEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781380469; c=relaxed/simple;
	bh=S0w8M6qCDJ6gXh8F3IfP3mlUbRAFp8ddpBIoN5jNze8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjgSe1ToEmrf1USF3dW6dl89PHfG+dfhLKfmRvj96SZwbM4or6UGmMTO8pwjcyl1IGa/nylFyfa9+zGbVCHA6MXESd3Gu+uetcA578zV9JoGyRWPo7D26tXxQTMUk2u0imlEeXQy7mo71zj4WAPBwEK8DKXmf+k4rQ+aplG1N8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GfxcOS87; arc=none smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781380468; x=1812916468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S0w8M6qCDJ6gXh8F3IfP3mlUbRAFp8ddpBIoN5jNze8=;
  b=GfxcOS87vlmzLnuHKxs25XaY4Bf7TTQqoSr61/BhXxEw2B7qEPEuRFBt
   1ClDS+86jC4J0mQRpq7o5BYz6Jll28BimWz97wLMw5wFpBLJTyLfm4iCZ
   t8L04J2UMy+RSdlWWuyXAWUOjAKOHGoYssJQUEYZ2Gpw3A8Z7SaaN3LBl
   7rw/LlN8dteOhSofJHmzQ7eeZaPCgdP+uEMFooRYPRbxD9i/BK0QJ5WIQ
   HioKCQgISN++Z33wWCNbZtDJ+bs0IVxhKI/UCspbrI+FJfwOOfLgChsZ5
   xplL3IWKud0ov/BK9SymX4WJDSCp4pzfJaFt9v+nOTrBlvhiDeoYpK4t+
   w==;
X-CSE-ConnectionGUID: bnCjuwRITk6Ip77L1RmEyA==
X-CSE-MsgGUID: pITXstsaTr6yr8HQ2FWIUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11816"; a="107612488"
X-IronPort-AV: E=Sophos;i="6.24,203,1774335600"; 
   d="scan'208";a="107612488"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 12:54:28 -0700
X-CSE-ConnectionGUID: TB/2Ou0YSA+0y250S7NZxQ==
X-CSE-MsgGUID: OAMjj7BtQGaejf5jiCpGtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,203,1774335600"; 
   d="scan'208";a="247134552"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 13 Jun 2026 12:54:22 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wYUQs-00000000QEc-3KLN;
	Sat, 13 Jun 2026 19:54:18 +0000
Date: Sun, 14 Jun 2026 03:54:07 +0800
From: kernel test robot <lkp@intel.com>
To: chia-yu.chang@nokia-bell-labs.com, andrii@kernel.org, eddyz87@gmail.com,
	horms@kernel.org, dsahern@kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
	kuba@kernel.org, stephen@networkplumber.org, davem@davemloft.net,
	edumazet@google.com, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
	kuniyu@google.com, ij@kernel.org, ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: oe-kbuild-all@lists.linux.dev,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: Re: [PATCH v1 net-next 1/1] tcp: Replace min_tso_segs() with
 tso_segs() CC callback for TCP Prague
Message-ID: <202606140311.15fhp3QN-lkp@intel.com>
References: <20260613080831.236636-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613080831.236636-1-chia-yu.chang@nokia-bell-labs.com>
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
	TAGGED_FROM(0.00)[bounces-299024-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:chia-yu.chang@nokia-bell-labs.com,m:andrii@kernel.org,m:eddyz87@gmail.com,m:horms@kernel.org,m:dsahern@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:kuba@kernel.org,m:stephen@networkplumber.org,m:davem@davemloft.net,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:donald.hunter@gmail.com,m:kuniyu@google.com,m:ij@kernel.org,m:ncardwell@google.com,m:koen.de_schepper@nokia-bell-labs.com,m:g.white@cablelabs.com,m:ingemar.s.johansson@ericsson.com,m:mirja.kuehlewind@ericsson.com,m:cheshire@apple.com,m:rs.ietf@gmx.at,m:Jason_Livingood@comcast.com,m:vidhi_goel@apple.com,m:oe-kbuild-all@lists.linux.dev,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[nokia-bell-labs.com,kernel.org,gmail.com,vger.kernel.org,redhat.com,mojatatu.com,networkplumber.org,davemloft.net,google.com,lunn.ch,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	FORGED_SENDER(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,01.org:url,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59CC467F7A3

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/chia-yu-chang-nokia-bell-labs-com/tcp-Replace-min_tso_segs-with-tso_segs-CC-callback-for-TCP-Prague/20260613-160954
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260613080831.236636-1-chia-yu.chang%40nokia-bell-labs.com
patch subject: [PATCH v1 net-next 1/1] tcp: Replace min_tso_segs() with tso_segs() CC callback for TCP Prague
config: x86_64-randconfig-075 (https://download.01.org/0day-ci/archive/20260614/202606140311.15fhp3QN-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260614/202606140311.15fhp3QN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606140311.15fhp3QN-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "tcp_tso_autosize" [net/ipv4/tcp_bbr.ko] undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

