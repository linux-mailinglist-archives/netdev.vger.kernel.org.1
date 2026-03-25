Return-Path: <netdev+bounces-271409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHVWJJ2Bw2n9rAQAu9opvQ
	(envelope-from <netdev+bounces-271409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:33:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3826D3202EE
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7012C303056F
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 06:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6FE287246;
	Wed, 25 Mar 2026 06:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QgsfJL9P"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D974351C3B
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 06:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420377; cv=none; b=P6rzC8x0hO42DnfIcojWollMZ87CkU1Ggs/klFL8ClWziD+Ck5QqS7GCgj5i2TXU/nxEFcfQB0aSZ0BOUCqDqJril+780KxeVrQWBHv2baqoOz7IhMgOYUPJ7VDN4U+674ankGZHmD/efiu5b1fqmKGyEdPCuvEfxQAZRBlQbxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420377; c=relaxed/simple;
	bh=oYwPXbaOwoZmhcz/naCViHjgv4Y6SembpEQdxfDRqDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKQUwjHY3rraxlIPaa4uEZgZZD4lhxYrKkcR6qZUqhgQz64BqOoXzkorkFupsWt4eAJTGvb1r9DuWzJzCloVfKSwE8VBXFVvD3/cZIiAdBNpofbvVZgkbAolpEsT5h81E66kLlWn4O3emOXjYnCO5UvsbgA+LqTkE6KjUWqjzSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QgsfJL9P; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774420376; x=1805956376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oYwPXbaOwoZmhcz/naCViHjgv4Y6SembpEQdxfDRqDc=;
  b=QgsfJL9P4L7k1ngW7gxnmOdCRH4JP3Fdt/ffaYXqr3UB4BCKrtK2YRBs
   mjpmtcOQ5anQYCgLyKsUXHhi3f+lxV4e1kqdaxgtVByrWRpfS6GnVmbj9
   aJ0qU1+7wZW/PHdiTYf5ysRiBv7QQ6lk9FZ7ZmWBDIdVtmAzjXSUps5mC
   oR65/4U8E+4OsoUP2zFhV4qLxBZAWQPc3uq1H+ErylptzrAaDcMgIEhCY
   Wlul4ZQpFWYJXgB6LTGEebf8OnSYRteEgJQPyI0+iGBhMNCSJEP61sdSl
   ar1bnoNpLg9lsJhxxhMKXpweBoafQvl75DGNRwcUq2I37t+1SEk/awh0x
   w==;
X-CSE-ConnectionGUID: mkANyr1sSe2YlA+PoQ5IOg==
X-CSE-MsgGUID: J+PYyHf7Qim6htNwAB8hCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79308162"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="79308162"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 23:32:56 -0700
X-CSE-ConnectionGUID: YxGPiFp7SEa3gZ7PN+NBdQ==
X-CSE-MsgGUID: g4+FIKLCR86QZvYaJpm/Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="221693864"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 24 Mar 2026 23:32:53 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5HnO-000000006JF-0so4;
	Wed, 25 Mar 2026 06:32:50 +0000
Date: Wed, 25 Mar 2026 14:32:47 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v4 net-next] tcp: add cwnd_event_tx_start to
 tcp_congestion_ops
Message-ID: <202603251430.gQ3VuiKV-lkp@intel.com>
References: <20260323234920.1097858-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323234920.1097858-1-edumazet@google.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-271409-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 3826D3202EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Eric,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/tcp-add-cwnd_event_tx_start-to-tcp_congestion_ops/20260325-042334
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260323234920.1097858-1-edumazet%40google.com
patch subject: [PATCH v4 net-next] tcp: add cwnd_event_tx_start to tcp_congestion_ops
config: i386-randconfig-141-20260325 (https://download.01.org/0day-ci/archive/20260325/202603251430.gQ3VuiKV-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch: v0.5.0-9004-gb810ac53

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603251430.gQ3VuiKV-lkp@intel.com/

New smatch warnings:
include/net/tcp.h:1449 tcp_ca_event() warn: inconsistent indenting
include/net/tcp.h:1449 tcp_ca_event() warn: inconsistent indenting

Old smatch warnings:
net/ipv4/tcp_output.c:779 tcp_options_write() error: we previously assumed 'tp' could be null (see line 747)

vim +1449 include/net/tcp.h

  1441	
  1442	static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
  1443	{
  1444		const struct inet_connection_sock *icsk = inet_csk(sk);
  1445	
  1446		if (event == CA_EVENT_TX_START) {
  1447		    if (icsk->icsk_ca_ops->cwnd_event_tx_start)
  1448				icsk->icsk_ca_ops->cwnd_event_tx_start(sk);
> 1449			return;
  1450		}
  1451		if (icsk->icsk_ca_ops->cwnd_event)
  1452			icsk->icsk_ca_ops->cwnd_event(sk, event);
  1453	}
  1454	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

