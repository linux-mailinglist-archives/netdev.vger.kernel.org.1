Return-Path: <netdev+bounces-150024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8429E8A1A
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 05:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C26163A13
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 04:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5CA14AD0E;
	Mon,  9 Dec 2024 04:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iG+yl8cA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3753042070
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 04:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733717108; cv=none; b=EkyrqNmOPw09JSGyoHPNDZZ8LKrv+i88VtVKPhDGcoANWhSjspLio9U12YW+5lK1KB/wpVwOqTXSODMtLNX6QLtbX7N0P+u3MlSzwSFaYbagiXihReBk4LaZqh3L823Ic2q9YggBTbqdpuBCF/CiE6Rtt5macA4caXP/YFui1Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733717108; c=relaxed/simple;
	bh=tnFN3cKLuaolTpd0KOneZQrwC6WFLR7ZhF2p0bYuJwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qlh0MwqRa6Td6sj962RR9es3coXFXH7AXSI5nM7dleuklnWZueG8+/eGe/AH15UWhcqucuQ9mskixdgZSu47Vk790mOGrpXSeeFR5p/T5C769UPOUhMgAUrUJ+3DxrZaTEb7clvoFRBD6IZ0ixh2bW4m0LY8dLlhDFWu39EFomU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iG+yl8cA; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733717107; x=1765253107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tnFN3cKLuaolTpd0KOneZQrwC6WFLR7ZhF2p0bYuJwk=;
  b=iG+yl8cA9nxaF0I3u99FHNgdopaI6y/yIVMFaeKg7tfCpY1PlOSX6El9
   29A+JNwKQCcYmgPKO5eX7WDVTZDtH7JllRjwLAuT8rAeeL0ZoQaDnbh//
   4OasZfg/7Xztn1GbISpCo+/jlnTxRIrJPfiUXbBsu5iyQ36Uk0g/8kEBx
   V13bGEC2+S1cBZoKb3fT3u5YlBG/Ijto3pOSvypDMi1GNf3CnfiGe0369
   ZL61JZTb4dTY3ptAAOwXXdygwnZu8IN9vIwswCzEelcaPgmi7s/2y/jzK
   4NkFeAGMtcsRNGM4UNSUz0tFgl0/mL/OAHIb1GBM8PmiUWCGRKxs8t9ra
   Q==;
X-CSE-ConnectionGUID: cH+hs5EkQtOC9hbAAnCk9g==
X-CSE-MsgGUID: 4UzENW6rQ72yyCT4yWI4Hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="34235275"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="34235275"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:05:07 -0800
X-CSE-ConnectionGUID: oVNjYBGfRsGlxE8W03ASyA==
X-CSE-MsgGUID: eL0kmTS8QjeB8IHS+Sx9QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="94822674"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 Dec 2024 20:05:04 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKV14-0003mh-0Z;
	Mon, 09 Dec 2024 04:05:02 +0000
Date: Mon, 9 Dec 2024 12:04:10 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v1 net-next 08/15] socket: Pass hold_net to sk_alloc().
Message-ID: <202412071110.UY8rjRf1-lkp@intel.com>
References: <20241206075504.24153-9-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206075504.24153-9-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/socket-Un-export-__sock_create/20241206-160139
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241206075504.24153-9-kuniyu%40amazon.com
patch subject: [PATCH v1 net-next 08/15] socket: Pass hold_net to sk_alloc().
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20241207/202412071110.UY8rjRf1-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241207/202412071110.UY8rjRf1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412071110.UY8rjRf1-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/iucv/af_iucv.c: In function 'iucv_sock_alloc':
>> net/iucv/af_iucv.c:455:14: error: too few arguments to function 'sk_alloc'
     455 |         sk = sk_alloc(&init_net, PF_IUCV, prio, &iucv_proto, kern);
         |              ^~~~~~~~
   In file included from net/iucv/af_iucv.c:30:
   include/net/sock.h:1745:14: note: declared here
    1745 | struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
         |              ^~~~~~~~


vim +/sk_alloc +455 net/iucv/af_iucv.c

eac3731bd04c713 Jennifer Hunt     2007-02-08  448  
8424c284851b97e Kuniyuki Iwashima 2024-12-06  449  static struct sock *iucv_sock_alloc(struct socket *sock, int proto, gfp_t prio,
8424c284851b97e Kuniyuki Iwashima 2024-12-06  450  				    bool kern, bool hold_net)
eac3731bd04c713 Jennifer Hunt     2007-02-08  451  {
eac3731bd04c713 Jennifer Hunt     2007-02-08  452  	struct sock *sk;
493d3971a65c921 Ursula Braun      2011-08-08  453  	struct iucv_sock *iucv;
eac3731bd04c713 Jennifer Hunt     2007-02-08  454  
11aa9c28b420924 Eric W. Biederman 2015-05-08 @455  	sk = sk_alloc(&init_net, PF_IUCV, prio, &iucv_proto, kern);
eac3731bd04c713 Jennifer Hunt     2007-02-08  456  	if (!sk)
eac3731bd04c713 Jennifer Hunt     2007-02-08  457  		return NULL;
493d3971a65c921 Ursula Braun      2011-08-08  458  	iucv = iucv_sk(sk);
eac3731bd04c713 Jennifer Hunt     2007-02-08  459  
eac3731bd04c713 Jennifer Hunt     2007-02-08  460  	sock_init_data(sock, sk);
493d3971a65c921 Ursula Braun      2011-08-08  461  	INIT_LIST_HEAD(&iucv->accept_q);
493d3971a65c921 Ursula Braun      2011-08-08  462  	spin_lock_init(&iucv->accept_q_lock);
493d3971a65c921 Ursula Braun      2011-08-08  463  	skb_queue_head_init(&iucv->send_skb_q);
493d3971a65c921 Ursula Braun      2011-08-08  464  	INIT_LIST_HEAD(&iucv->message_q.list);
493d3971a65c921 Ursula Braun      2011-08-08  465  	spin_lock_init(&iucv->message_q.lock);
493d3971a65c921 Ursula Braun      2011-08-08  466  	skb_queue_head_init(&iucv->backlog_skb_q);
493d3971a65c921 Ursula Braun      2011-08-08  467  	iucv->send_tag = 0;
3881ac441f642d5 Ursula Braun      2011-08-08  468  	atomic_set(&iucv->pendings, 0);
493d3971a65c921 Ursula Braun      2011-08-08  469  	iucv->flags = 0;
3881ac441f642d5 Ursula Braun      2011-08-08  470  	iucv->msglimit = 0;
ef6af7bdb9e6c14 Julian Wiedmann   2021-01-28  471  	atomic_set(&iucv->skbs_in_xmit, 0);
3881ac441f642d5 Ursula Braun      2011-08-08  472  	atomic_set(&iucv->msg_sent, 0);
3881ac441f642d5 Ursula Braun      2011-08-08  473  	atomic_set(&iucv->msg_recv, 0);
493d3971a65c921 Ursula Braun      2011-08-08  474  	iucv->path = NULL;
3881ac441f642d5 Ursula Braun      2011-08-08  475  	iucv->sk_txnotify = afiucv_hs_callback_txnotify;
b5d8cf0af167f3a Kees Cook         2021-11-18  476  	memset(&iucv->init, 0, sizeof(iucv->init));
3881ac441f642d5 Ursula Braun      2011-08-08  477  	if (pr_iucv)
3881ac441f642d5 Ursula Braun      2011-08-08  478  		iucv->transport = AF_IUCV_TRANS_IUCV;
3881ac441f642d5 Ursula Braun      2011-08-08  479  	else
3881ac441f642d5 Ursula Braun      2011-08-08  480  		iucv->transport = AF_IUCV_TRANS_HIPER;
eac3731bd04c713 Jennifer Hunt     2007-02-08  481  
eac3731bd04c713 Jennifer Hunt     2007-02-08  482  	sk->sk_destruct = iucv_sock_destruct;
eac3731bd04c713 Jennifer Hunt     2007-02-08  483  	sk->sk_sndtimeo = IUCV_CONN_TIMEOUT;
eac3731bd04c713 Jennifer Hunt     2007-02-08  484  
eac3731bd04c713 Jennifer Hunt     2007-02-08  485  	sock_reset_flag(sk, SOCK_ZAPPED);
eac3731bd04c713 Jennifer Hunt     2007-02-08  486  
eac3731bd04c713 Jennifer Hunt     2007-02-08  487  	sk->sk_protocol = proto;
eac3731bd04c713 Jennifer Hunt     2007-02-08  488  	sk->sk_state	= IUCV_OPEN;
eac3731bd04c713 Jennifer Hunt     2007-02-08  489  
eac3731bd04c713 Jennifer Hunt     2007-02-08  490  	iucv_sock_link(&iucv_sk_list, sk);
eac3731bd04c713 Jennifer Hunt     2007-02-08  491  	return sk;
eac3731bd04c713 Jennifer Hunt     2007-02-08  492  }
eac3731bd04c713 Jennifer Hunt     2007-02-08  493  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

