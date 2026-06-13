Return-Path: <netdev+bounces-298919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q+JGEooPLWoZaQQAu9opvQ
	(envelope-from <netdev+bounces-298919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 10:06:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E51367E0F6
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 10:06:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=RphBBd7E;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298919-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298919-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1749D3006B5A
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 08:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A1C3B38B9;
	Sat, 13 Jun 2026 08:06:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A31C343899;
	Sat, 13 Jun 2026 08:06:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781337987; cv=none; b=Ataiw7MfD6448TqIXXKb7veJQmoL1WQCAC4poYgxwO238ypzk20B1sdA7o3S8bjKu2CLDnLZ2BUdch0Fc2jXd3e7cuhxU6hseROjQaYQIkhp1sU/UcVQoegIQB5ChoNulRT2rYJtgLtxeHS8RyVCfsrPaQV/WsDF/6vw7j8yL5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781337987; c=relaxed/simple;
	bh=o0LWqic+72nuI6gnGf1tCPfCLx4sFK1P3umA/isHRZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p95VPxj4M13lR+RJPlBJJ+peIxOLQ7gj9cGvk5NWZqQKJUSHs3DxSCFG01TBTW7ecer95bvXqpWOEEWOZg7TtuA8tdecuyJ1fXvCBvqv2etYu1epL4eNYAhS4DpjUoT/raFSRXwQoTRXKyGe5KEE0EnK/zw+9Ncbm0r+fjos0RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RphBBd7E; arc=none smtp.client-ip=198.175.65.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781337986; x=1812873986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o0LWqic+72nuI6gnGf1tCPfCLx4sFK1P3umA/isHRZM=;
  b=RphBBd7E/wlbB0uP21/nbcXomkO8DQaewr9wWxo1UzditopCkDEgKbC9
   ZUTqll47aGw8EL6C1qTCDZjtSg0u1cRMdp43x792RG15VWndUOaJr0tzf
   wnQmyqRT0NQy7Wh3sG3/HVLyq/DYCOJJ6uodFV1ucEX0Wbg+nwAQwb2qh
   Z5/jUtDclzROlod47Q8pYsmu/cA0WAyBozk0l9FM+L8Mgg4GQSPhep7KM
   vjORCIwC21T/skRHBQNb0aSIgShcm5ntibJteOtoTO1prU4S2YI/WDbWl
   TKt8DinZ1R3D9kn/PMEaWMwZglVvW3QYIE6qsS46srJW//Wfhi//VznAZ
   Q==;
X-CSE-ConnectionGUID: 3gy2QeFFRt2HR7rUt014iw==
X-CSE-MsgGUID: dPjUmM/TTA2aWhMorufDzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="93274255"
X-IronPort-AV: E=Sophos;i="6.24,202,1774335600"; 
   d="scan'208";a="93274255"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 01:06:25 -0700
X-CSE-ConnectionGUID: zxpGxI25SySLHMo9tIS3hA==
X-CSE-MsgGUID: Sr4z/Zy3Rm6hJaKZSqoWsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,202,1774335600"; 
   d="scan'208";a="271070754"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by fmviesa001.fm.intel.com with ESMTP; 13 Jun 2026 01:06:18 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wYJNg-000000004Sb-1EtN;
	Sat, 13 Jun 2026 08:06:16 +0000
Date: Sat, 13 Jun 2026 10:05:56 +0200
From: kernel test robot <lkp@intel.com>
To: xur@google.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Yue Haibing <yuehaibing@huawei.com>,
	Jeff Layton <jlayton@kernel.org>, Kees Cook <kees@kernel.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: correcting section tags for .init and .exit
 data/functions
Message-ID: <202606131033.U9FHCI7B-lkp@intel.com>
References: <20260612162257.896792-1-xur@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612162257.896792-1-xur@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298919-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[google.com,davemloft.net,kernel.org,redhat.com,gmail.com,nvidia.com,suse.de,huawei.com,queasysnail.net,linux.dev,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:xur@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:willemdebruijn.kernel@gmail.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:afaerber@suse.de,m:mani@kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:maze@google.com,m:yuehaibing@huawei.com,m:jlayton@kernel.org,m:kees@kernel.org,m:fmancera@suse.de,m:gustavoars@kernel.org,m:sd@queasysnail.net,m:masahiroy@kernel.org,m:nicolas.schier@linux.dev,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-actions@lists.infradead.org,m:llvm@lists.linux.dev,m:oe-kbuild-all@lists.linux.dev,m:netdev@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,lkml];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E51367E0F6

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2b414a95b8f7307d42173ba9e580d6d3e2bcbfce]

url:    https://github.com/intel-lab-lkp/linux/commits/xur-google-com/net-correcting-section-tags-for-init-and-exit-data-functions/20260613-002737
base:   2b414a95b8f7307d42173ba9e580d6d3e2bcbfce
patch link:    https://lore.kernel.org/r/20260612162257.896792-1-xur%40google.com
patch subject: [PATCH] net: correcting section tags for .init and .exit data/functions
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260613/202606131033.U9FHCI7B-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project f43d6834093b19baf79beda8c0337ab020ac5f17)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260613/202606131033.U9FHCI7B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606131033.U9FHCI7B-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: tcpv6_init+0x68 (section: .text) -> mptcpv6_init (section: .init.text)

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

