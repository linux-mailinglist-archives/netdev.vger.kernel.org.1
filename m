Return-Path: <netdev+bounces-272913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sq2hCRcryWknvgUAu9opvQ
	(envelope-from <netdev+bounces-272913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 15:37:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DDB35243C
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 15:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E262F300D17F
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 13:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB54376496;
	Sun, 29 Mar 2026 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YmSevEbM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAC32FD7D3
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774791444; cv=none; b=i0EMmqhBLuc9nMt0dMunS39/irj6NwC6iwC0f37RH2zeM7y4CfE0vGiG6uD81EHyJhEeuNbT18BqeptJihXR3EcjOh18eT25+d3izmYc+AfcB/TRuV9/QEOKLJ+DJpQM/INrNSwpfG5vGAwarqwQomZFZQcyypFVeDDuvyzQuII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774791444; c=relaxed/simple;
	bh=+NPB4+U54CnySQbbYNe0q8Y65DxLgkl44ShfLtlVrXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hf3Bfqn5YfhuJHQG8prApJKkw7JmSFcPyhKkSf2XkW/97ZsI0GAytoUOYIqbTM2PIxbalFQHglpcKTY5aWfx91O6PyREfg8cJW+YazIvsUJya+tBJqbHXmQD4A88IDU/+fIjqR10rDXcQ15E4dIdEZOcLplC5qcSyCKPF8hYfII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YmSevEbM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774791442; x=1806327442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+NPB4+U54CnySQbbYNe0q8Y65DxLgkl44ShfLtlVrXo=;
  b=YmSevEbMDfsyTxivhOqcqEZhKcepFlCTABjVLHchzmROx9k4QTZIHtHO
   CuCUg0n5Qk3vc5nkPyhVwHvNlPH/S1YbmEj2jb1r3s9J5hhO8Cosz+Nte
   zO1MdJjPc6ixf9BQeFNyPcPUeN35vAZLPMCrn0U+NqxLLCBsAJPzuti1e
   N1B5tOKc6jmpAMHkkfXH/BSVaDQhIRkkTJMsk//qU6ZpJ5p+yDMBDglfU
   qW13ODEo9TMqbXuBPeC+Q8E7IYkuZxqpjSafXu9+JZ+/xD+DoErSg6D7t
   yjp7ESpkxl29fTnLyf60VbU+/frEpZ95FqvDyO4427sEHuoPVWkFRiTT8
   A==;
X-CSE-ConnectionGUID: iqW5Xr/RQjmde1bVC26gxw==
X-CSE-MsgGUID: DVjAsLmATM2naPd8LGlLEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="86875731"
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="86875731"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 06:37:22 -0700
X-CSE-ConnectionGUID: oX11cyCCQS6eQJ9hA5avmA==
X-CSE-MsgGUID: HzRgGmydTnacvrbm6zSnVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="224981427"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 29 Mar 2026 06:37:20 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6qKK-00000000COT-1e0n;
	Sun, 29 Mar 2026 13:37:16 +0000
Date: Sun, 29 Mar 2026 21:36:30 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH v1 net-next] tun: Ignore tun in netdev_lock_pos().
Message-ID: <202603292142.PWqbqFZ4-lkp@intel.com>
References: <20260327213441.3781433-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327213441.3781433-1-kuniyu@google.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272913-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[google.com,davemloft.net,kernel.org,redhat.com,gmail.com,lunn.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73DDB35243C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/tun-Ignore-tun-in-netdev_lock_pos/20260328-220059
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260327213441.3781433-1-kuniyu%40google.com
patch subject: [PATCH v1 net-next] tun: Ignore tun in netdev_lock_pos().
config: x86_64-randconfig-016-20260329 (https://download.01.org/0day-ci/archive/20260329/202603292142.PWqbqFZ4-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260329/202603292142.PWqbqFZ4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603292142.PWqbqFZ4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: tun_link_ops
   >>> referenced by if_tun.h:27 (include/linux/if_tun.h:27)
   >>>               vmlinux.o:(register_netdevice)
   >>> referenced by if_tun.h:27 (include/linux/if_tun.h:27)
   >>>               vmlinux.o:(alloc_netdev_mqs)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

