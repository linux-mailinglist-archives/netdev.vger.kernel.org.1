Return-Path: <netdev+bounces-126859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5F8972B20
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 09:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B53288F06
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 07:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E8617E00A;
	Tue, 10 Sep 2024 07:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLUmpnF7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896C91514DA
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954479; cv=none; b=XzXWeYRZkZE3xiRqGd+zxbE5y3NbWQ0He6cojt6iAXn42v+PoTjhx8V6M3YbiD8nry71Rx2PclmNOxb0J9r0yzKFn6ZoCwVfThUqxRQtkJqKW2ZHg1b4L7hdVDHwil9xsWUcXpqK92TW87cM+VL91zjnOaWVXRgP80lQlLOyeoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954479; c=relaxed/simple;
	bh=zVV2U5WsC00MQWtbvoRJZ3qYkkI8CKr2jzERKCY4UvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuR05pIiPxAVjFo5yTtG6XkeAnWL5J0GufwYdMFTGsMiyxl5/HUSTuavVTgw3687asHtw8xP0eDDvFVV4c2G+Yj65H45E7ikGfxYOiag8d8JiZ7h6Sud9tqaQJyM5VZtHkSWXQFQBAM50KTmiyXJZmtgdS8xddyW+sh3UtlTXBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLUmpnF7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725954478; x=1757490478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zVV2U5WsC00MQWtbvoRJZ3qYkkI8CKr2jzERKCY4UvE=;
  b=HLUmpnF76tZcOBh27m8x42HnVScJkOjreUy6tP7OT4WOS4hZYfm8Tt9a
   xPyGiPW9qhdrwrRqYFtgBERvs82Tw+4PesHnt1qI2B1+Ar3RH7IBFCSk2
   +XgcY69x2wulHMfcz0wBjgiIsMYvxNQjIQjyssmuEsb4nHz6YDPD0dbSo
   62Es5AbH0RQq/rgBXoymRe6gO/v73OQEig7Y3Eri0XyCU3/0giTCk1sCE
   qbQnMFpuzjqYd9gFLcQ9wybqeNeRyIVK8J6QhSgCDvkz4tY9P/RHCUpxB
   73eeA3W1Q+62aNU4YgL/rD5BH1f4gDEaer/90XYfJSZ2f+ba4dVE0kwLv
   A==;
X-CSE-ConnectionGUID: ZErj8lRZS1i5fZcr+V995Q==
X-CSE-MsgGUID: ZiOHaShCQsqXki4+F5OHcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24230632"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="24230632"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 00:47:57 -0700
X-CSE-ConnectionGUID: 2+Pvi28wQUmN+5s+RV5fcQ==
X-CSE-MsgGUID: qzVTPtF/SvOwhPIGBp/Olg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="66571611"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 10 Sep 2024 00:47:54 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snvbM-0000Ew-2T;
	Tue, 10 Sep 2024 07:47:52 +0000
Date: Tue, 10 Sep 2024 15:47:35 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/3] net_tstamp: add SCM_TS_OPT_ID for RAW
 sockets
Message-ID: <202409101515.ChJ52ksO-lkp@intel.com>
References: <20240909165046.644417-3-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909165046.644417-3-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/net_tstamp-add-SCM_TS_OPT_ID-to-provide-OPT_ID-in-control-message/20240910-005324
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240909165046.644417-3-vadfed%40meta.com
patch subject: [PATCH net-next v4 2/3] net_tstamp: add SCM_TS_OPT_ID for RAW sockets
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20240910/202409101515.ChJ52ksO-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240910/202409101515.ChJ52ksO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409101515.ChJ52ksO-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/ipv4/tcp.c: In function 'tcp_tx_timestamp':
>> net/ipv4/tcp.c:485:39: error: 'sockc' undeclared (first use in this function); did you mean 'sock'?
     485 |                 sock_tx_timestamp(sk, sockc, &shinfo->tx_flags);
         |                                       ^~~~~
         |                                       sock
   net/ipv4/tcp.c:485:39: note: each undeclared identifier is reported only once for each function it appears in


vim +485 net/ipv4/tcp.c

   476	
   477	static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
   478	{
   479		struct sk_buff *skb = tcp_write_queue_tail(sk);
   480	
   481		if (tsflags && skb) {
   482			struct skb_shared_info *shinfo = skb_shinfo(skb);
   483			struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
   484	
 > 485			sock_tx_timestamp(sk, sockc, &shinfo->tx_flags);
   486			if (tsflags & SOF_TIMESTAMPING_TX_ACK)
   487				tcb->txstamp_ack = 1;
   488			if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
   489				shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
   490		}
   491	}
   492	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

