Return-Path: <netdev+bounces-201591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E81CAEA031
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6EF174836
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E08287271;
	Thu, 26 Jun 2025 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fE1yKSxu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3741FFC77
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947451; cv=none; b=IHZXU6/h0bAtRbE/Qctf9p+MuFTsdgu41hXaq/T1g7BUunC2U2DPnyrNEn5z3Y7vRYkxciXNmRX1tf8H3TFHPlEOtq/fffgTmtlyoiYWHrviD2b0MpqpQWG0hhC2G3qh1quqwLLC44YjDVICA6Cr0G8Ga1bo/3mgnlvnjkuZ9qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947451; c=relaxed/simple;
	bh=XqYClj/5pBa3GX06fk9cdq2WQFGn81GtU1URfAAqPEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHmrZrvwVz0UYIcxOIVgwD7FWoBHqjC0/6iClkIufsLiJS5JuruvBGE9g9RNQuAVI6uJSVHJ275U57VH3vruKwl/ePk9fFZgUgIAbDrh6iOoXJG1gw40Lom9dD/Ify/GU+QPvDyyiAz+rGLdFxz7EFf3aw1+jaeonb6YRHvHdAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fE1yKSxu; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750947450; x=1782483450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XqYClj/5pBa3GX06fk9cdq2WQFGn81GtU1URfAAqPEA=;
  b=fE1yKSxu6SKZjcjrEaWj7tyAlyQuihtR8HZrM+VixkQY7iao/eSO44kn
   EYv6bDaNAWQMVsj1psTqs3aY5HgZfX1jNrJAk9W45+OH/2mOBZ+8t8M7+
   Nru3ubDyMZulr8/CTPoowkUle7WsJ25l3ST+jA6M3yryoK9zmFgwScMi/
   Ak5MBBVa69ugY1kJTrT+htLGnCQL4yLcKbzeDvXVq8oCM0IVs0+U0MH+r
   AbSVPlQN2l+ledZ7tsncRCoyPoX+UktbB2Zk0cA/2zG1e9sQIVqS1qg/k
   y3JT+oAiCYozi0/+r1iW8O3W+MMGZXIMBLFq4nEbKWHjk3s5bmViirPT7
   g==;
X-CSE-ConnectionGUID: wE1g2acAQdaHuA2ZHpuGKA==
X-CSE-MsgGUID: oq+p+1MARJeI/eX8jILNzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="57052617"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="57052617"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 07:17:24 -0700
X-CSE-ConnectionGUID: JUHEvcgrQ+a5oGO82lC68g==
X-CSE-MsgGUID: tZdw/BDBQoChW6TnhG5NiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="183558913"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 26 Jun 2025 07:17:20 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUnPh-000U8Y-1k;
	Thu, 26 Jun 2025 14:17:17 +0000
Date: Thu, 26 Jun 2025 22:17:00 +0800
From: kernel test robot <lkp@intel.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 02/14] net: mctp: test: make cloned_frag
 buffers more appropriately-sized
Message-ID: <202506262133.SOMnmRa5-lkp@intel.com>
References: <20250625-dev-forwarding-v3-2-2061bd3013b3@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625-dev-forwarding-v3-2-2061bd3013b3@codeconstruct.com.au>

Hi Jeremy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0097c4195b1d0ca57d15979626c769c74747b5a0]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeremy-Kerr/net-mctp-don-t-use-source-cb-data-when-forwarding-ensure-pkt_type-is-set/20250625-154020
base:   0097c4195b1d0ca57d15979626c769c74747b5a0
patch link:    https://lore.kernel.org/r/20250625-dev-forwarding-v3-2-2061bd3013b3%40codeconstruct.com.au
patch subject: [PATCH net-next v3 02/14] net: mctp: test: make cloned_frag buffers more appropriately-sized
config: microblaze-allyesconfig (https://download.01.org/0day-ci/archive/20250626/202506262133.SOMnmRa5-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250626/202506262133.SOMnmRa5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506262133.SOMnmRa5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/mctp/route.c:1549:
   net/mctp/test/route-test.c: In function 'mctp_test_route_input_cloned_frag':
>> net/mctp/test/route-test.c:937:12: warning: argument to variable-length array is too large [-Wvla-larger-than=]
     937 |         u8 compare[data_len * ARRAY_SIZE(hdrs)];
         |            ^~~~~~~
   net/mctp/test/route-test.c:937:12: note: limit is 1 bytes, but argument is 15
   net/mctp/test/route-test.c:938:12: warning: argument to variable-length array is too large [-Wvla-larger-than=]
     938 |         u8 flat[data_len * ARRAY_SIZE(hdrs)];
         |            ^~~~
   net/mctp/test/route-test.c:938:12: note: limit is 1 bytes, but argument is 15


vim +937 net/mctp/test/route-test.c

   923	
   924	/* Input route to socket, using a fragmented message created from clones.
   925	 */
   926	static void mctp_test_route_input_cloned_frag(struct kunit *test)
   927	{
   928		/* 5 packet fragments, forming 2 complete messages */
   929		const struct mctp_hdr hdrs[5] = {
   930			RX_FRAG(FL_S, 0),
   931			RX_FRAG(0, 1),
   932			RX_FRAG(FL_E, 2),
   933			RX_FRAG(FL_S, 0),
   934			RX_FRAG(FL_E, 1),
   935		};
   936		const size_t data_len = 3; /* arbitrary */
 > 937		u8 compare[data_len * ARRAY_SIZE(hdrs)];
   938		u8 flat[data_len * ARRAY_SIZE(hdrs)];
   939		struct mctp_test_route *rt;
   940		struct mctp_test_dev *dev;
   941		struct sk_buff *skb[5];
   942		struct sk_buff *rx_skb;
   943		struct socket *sock;
   944		size_t total;
   945		void *p;
   946		int rc;
   947	
   948		total = data_len + sizeof(struct mctp_hdr);
   949	
   950		__mctp_route_test_init(test, &dev, &rt, &sock, MCTP_NET_ANY);
   951	
   952		/* Create a single skb initially with concatenated packets */
   953		skb[0] = mctp_test_create_skb(&hdrs[0], 5 * total);
   954		mctp_test_skb_set_dev(skb[0], dev);
   955		memset(skb[0]->data, 0 * 0x11, skb[0]->len);
   956		memcpy(skb[0]->data, &hdrs[0], sizeof(struct mctp_hdr));
   957	
   958		/* Extract and populate packets */
   959		for (int i = 1; i < 5; i++) {
   960			skb[i] = skb_clone(skb[i - 1], GFP_ATOMIC);
   961			KUNIT_ASSERT_TRUE(test, skb[i]);
   962			p = skb_pull(skb[i], total);
   963			KUNIT_ASSERT_TRUE(test, p);
   964			skb_reset_network_header(skb[i]);
   965			memcpy(skb[i]->data, &hdrs[i], sizeof(struct mctp_hdr));
   966			memset(&skb[i]->data[sizeof(struct mctp_hdr)], i * 0x11, data_len);
   967		}
   968		for (int i = 0; i < 5; i++)
   969			skb_trim(skb[i], total);
   970	
   971		/* SOM packets have a type byte to match the socket */
   972		skb[0]->data[4] = 0;
   973		skb[3]->data[4] = 0;
   974	
   975		skb_dump("pkt1 ", skb[0], false);
   976		skb_dump("pkt2 ", skb[1], false);
   977		skb_dump("pkt3 ", skb[2], false);
   978		skb_dump("pkt4 ", skb[3], false);
   979		skb_dump("pkt5 ", skb[4], false);
   980	
   981		for (int i = 0; i < 5; i++) {
   982			KUNIT_EXPECT_EQ(test, refcount_read(&skb[i]->users), 1);
   983			/* Take a reference so we can check refcounts at the end */
   984			skb_get(skb[i]);
   985		}
   986	
   987		/* Feed the fragments into MCTP core */
   988		for (int i = 0; i < 5; i++) {
   989			rc = mctp_route_input(&rt->rt, skb[i]);
   990			KUNIT_EXPECT_EQ(test, rc, 0);
   991		}
   992	
   993		/* Receive first reassembled message */
   994		rx_skb = skb_recv_datagram(sock->sk, MSG_DONTWAIT, &rc);
   995		KUNIT_EXPECT_EQ(test, rc, 0);
   996		KUNIT_EXPECT_EQ(test, rx_skb->len, 3 * data_len);
   997		rc = skb_copy_bits(rx_skb, 0, flat, rx_skb->len);
   998		for (int i = 0; i < rx_skb->len; i++)
   999			compare[i] = (i / data_len) * 0x11;
  1000		/* Set type byte */
  1001		compare[0] = 0;
  1002	
  1003		KUNIT_EXPECT_MEMEQ(test, flat, compare, rx_skb->len);
  1004		KUNIT_EXPECT_EQ(test, refcount_read(&rx_skb->users), 1);
  1005		kfree_skb(rx_skb);
  1006	
  1007		/* Receive second reassembled message */
  1008		rx_skb = skb_recv_datagram(sock->sk, MSG_DONTWAIT, &rc);
  1009		KUNIT_EXPECT_EQ(test, rc, 0);
  1010		KUNIT_EXPECT_EQ(test, rx_skb->len, 2 * data_len);
  1011		rc = skb_copy_bits(rx_skb, 0, flat, rx_skb->len);
  1012		for (int i = 0; i < rx_skb->len; i++)
  1013			compare[i] = (i / data_len + 3) * 0x11;
  1014		/* Set type byte */
  1015		compare[0] = 0;
  1016	
  1017		KUNIT_EXPECT_MEMEQ(test, flat, compare, rx_skb->len);
  1018		KUNIT_EXPECT_EQ(test, refcount_read(&rx_skb->users), 1);
  1019		kfree_skb(rx_skb);
  1020	
  1021		/* Check input skb refcounts */
  1022		for (int i = 0; i < 5; i++) {
  1023			KUNIT_EXPECT_EQ(test, refcount_read(&skb[i]->users), 1);
  1024			kfree_skb(skb[i]);
  1025		}
  1026	
  1027		__mctp_route_test_fini(test, dev, rt, sock);
  1028	}
  1029	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

