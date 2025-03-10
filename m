Return-Path: <netdev+bounces-173581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25F5A59A74
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 16:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B939F3A6997
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 15:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB0C22E3F1;
	Mon, 10 Mar 2025 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8Pgzb2W"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2DE22B8CA
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622222; cv=none; b=n61HC+wmlZHtW2mPxN1ol5j26dxAR6q6f6+yUS/qsR8DcrApHc/9IbbUHRe76wZ6NCFm7Ppfh7IWMp91T1Q3v8qrxmPiQ4dDsfjJm3kyAfgt6Mnjk8xAGRi1FU3EcfKriOLOeO4V5TPCUY++qxbhaRqFu2XqsLs5mKo4JuiJgXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622222; c=relaxed/simple;
	bh=UfzIwipQYZKlD1IFnNP2s2QWol3tOEz3nnLOdVk3cVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMg1VwTeSIn+NMh5pzo+MifOnAgMbSDJdbHBvFPDRdIqOeMxgKbnaAO4qIEvsbOKFOgm5UqiQXbk7/NC//r/DVz0IuDTcU0PUoQQ73lloiKH3E76Z7G7x+jSeX1OmDiWxqL5qqW35q1L+fOOULP3yShrXab8fxj7UIO1wC0eyeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8Pgzb2W; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741622221; x=1773158221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UfzIwipQYZKlD1IFnNP2s2QWol3tOEz3nnLOdVk3cVc=;
  b=n8Pgzb2WOV14A7NUxzKlisL7+yWvmExgEK7NllyK4kWi9XtDGxfzzgk0
   t6iXnlsNHxXxeBhNhpfZnATHg7RNrAzcdrRRmkxQbSms6zo/gWecCCl5l
   RDpjmVhoCW/w++1y6rJ4bW0bsp9ATkQ0JBH+/idvkiOKXtXJZQGZRd6gC
   eNX2pNe3626ph63MdonCrfjRsWX7siNhlROxHCSRAzvFixsBH5wMqk0+j
   3+ahzQhKjUnpJKcG8Jud/rg5MU+JjiIH61DczgXD3HM0fP5qFrvhXvvtc
   EUBPPBa3Igy89jy84FYZdciBB+gTSNSFoBEeQBfyDVwGhCgKUZSyRIWKL
   Q==;
X-CSE-ConnectionGUID: sHmntlULTyi2Beu5s2VMkQ==
X-CSE-MsgGUID: 15GO/qbyTbOooLxhB1xG1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="53614649"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="53614649"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 08:57:00 -0700
X-CSE-ConnectionGUID: c+imipRMR2WxBNHrZmx4uQ==
X-CSE-MsgGUID: jfQTKGA0TxWiiROmb069Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="124931255"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 10 Mar 2025 08:56:57 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trfUs-0004Py-39;
	Mon, 10 Mar 2025 15:56:54 +0000
Date: Mon, 10 Mar 2025 23:56:46 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 3/4] inet: frags: change inet_frag_kill() to
 defer refcount updates
Message-ID: <202503102308.1uTA6Uxr-lkp@intel.com>
References: <20250309173151.2863314-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309173151.2863314-4-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/inet-frags-add-inet_frag_putn-helper/20250310-013501
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250309173151.2863314-4-edumazet%40google.com
patch subject: [PATCH net-next 3/4] inet: frags: change inet_frag_kill() to defer refcount updates
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20250310/202503102308.1uTA6Uxr-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project e15545cad8297ec7555f26e5ae74a9f0511203e7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250310/202503102308.1uTA6Uxr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503102308.1uTA6Uxr-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/ieee802154/6lowpan/reassembly.c:312:45: error: too few arguments to function call, expected 4, have 3
     312 |                 ret = lowpan_frag_queue(fq, skb, frag_type);
         |                       ~~~~~~~~~~~~~~~~~                   ^
   net/ieee802154/6lowpan/reassembly.c:86:12: note: 'lowpan_frag_queue' declared here
      86 | static int lowpan_frag_queue(struct lowpan_frag_queue *fq,
         |            ^                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      87 |                              struct sk_buff *skb, u8 frag_type,
         |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      88 |                              int *refs)
         |                              ~~~~~~~~~
   1 error generated.


vim +312 net/ieee802154/6lowpan/reassembly.c

7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  280  
72a5e6bb5120d64 net/ieee802154/6lowpan/reassembly.c Alexander Aring    2015-09-02  281  int lowpan_frag_rcv(struct sk_buff *skb, u8 frag_type)
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  282  {
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  283  	struct lowpan_frag_queue *fq;
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  284  	struct net *net = dev_net(skb->dev);
72a5e6bb5120d64 net/ieee802154/6lowpan/reassembly.c Alexander Aring    2015-09-02  285  	struct lowpan_802154_cb *cb = lowpan_802154_cb(skb);
f18fa5de5ba7f1d net/ieee802154/6lowpan/reassembly.c Alexander Aring    2018-04-20  286  	struct ieee802154_hdr hdr = {};
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  287  	int err;
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  288  
72a5e6bb5120d64 net/ieee802154/6lowpan/reassembly.c Alexander Aring    2015-09-02  289  	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
72a5e6bb5120d64 net/ieee802154/6lowpan/reassembly.c Alexander Aring    2015-09-02  290  		goto err;
ae531b9475f62c5 net/ieee802154/reassembly.c         Phoebe Buckheister 2014-03-14  291  
72a5e6bb5120d64 net/ieee802154/6lowpan/reassembly.c Alexander Aring    2015-09-02  292  	err = lowpan_get_cb(skb, frag_type, cb);
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  293  	if (err < 0)
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  294  		goto err;
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  295  
72a5e6bb5120d64 net/ieee802154/6lowpan/reassembly.c Alexander Aring    2015-09-02  296  	if (frag_type == LOWPAN_DISPATCH_FRAG1) {
72a5e6bb5120d64 net/ieee802154/6lowpan/reassembly.c Alexander Aring    2015-09-02  297  		err = lowpan_invoke_frag_rx_handlers(skb);
72a5e6bb5120d64 net/ieee802154/6lowpan/reassembly.c Alexander Aring    2015-09-02  298  		if (err == NET_RX_DROP)
72a5e6bb5120d64 net/ieee802154/6lowpan/reassembly.c Alexander Aring    2015-09-02  299  			goto err;
72a5e6bb5120d64 net/ieee802154/6lowpan/reassembly.c Alexander Aring    2015-09-02  300  	}
72a5e6bb5120d64 net/ieee802154/6lowpan/reassembly.c Alexander Aring    2015-09-02  301  
72a5e6bb5120d64 net/ieee802154/6lowpan/reassembly.c Alexander Aring    2015-09-02  302  	if (cb->d_size > IPV6_MIN_MTU) {
6697dabe27e0330 net/ieee802154/reassembly.c         Martin Townsend    2014-08-19  303  		net_warn_ratelimited("lowpan_frag_rcv: datagram size exceeds MTU\n");
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  304  		goto err;
6697dabe27e0330 net/ieee802154/reassembly.c         Martin Townsend    2014-08-19  305  	}
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  306  
72a5e6bb5120d64 net/ieee802154/6lowpan/reassembly.c Alexander Aring    2015-09-02  307  	fq = fq_find(net, cb, &hdr.source, &hdr.dest);
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  308  	if (fq != NULL) {
aec42e105cebf42 net/ieee802154/6lowpan/reassembly.c Eric Dumazet       2025-03-09  309  		int ret, refs = 1;
4710d806fcb8251 net/ieee802154/reassembly.c         Varka Bhadram      2014-07-02  310  
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  311  		spin_lock(&fq->q.lock);
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28 @312  		ret = lowpan_frag_queue(fq, skb, frag_type);
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  313  		spin_unlock(&fq->q.lock);
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  314  
aec42e105cebf42 net/ieee802154/6lowpan/reassembly.c Eric Dumazet       2025-03-09  315  		inet_frag_putn(&fq->q, refs);
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  316  		return ret;
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  317  	}
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  318  
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  319  err:
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  320  	kfree_skb(skb);
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  321  	return -1;
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  322  }
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  323  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

