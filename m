Return-Path: <netdev+bounces-193106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C410CAC2863
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 19:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34441B66673
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 17:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA842253E4;
	Fri, 23 May 2025 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nrDIlR+5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062552DCBFE;
	Fri, 23 May 2025 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020657; cv=none; b=qlfRGvKDK8FkUijyjQa5G/OqSWFkoWpKLOu5ddCYRfcECMO3wh0NPI3biEgWian2YbcF8+G+niuYrJwEfvXcT4u0Ybb4pA1pckKouiTT6NgPo/a+0RabaATOtzmjdGG1zEOPcylbuT0jwa2wlaxjaPh4ZmzD5jjSS5nNshfMYc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020657; c=relaxed/simple;
	bh=VtqYDADSD+9g4gOpQfp0t5SIzJac5qrHjWQds4iw7C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+FafVMkIXaNVSy2KAzNGr7IQgJh1wPMoAewG4gXvCnEQ8iUH+u83ghvAX643FZX6Q+FnTvADuh/gQNWyNrvBoTjw+RsPi6cpuCTe4VcMWDZO6/n41ddn2ebLwv6NLYHyUxrzPAxORcCEmicFvo8kYF/cL2Yx0tWR9NYTMAA/Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nrDIlR+5; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748020656; x=1779556656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VtqYDADSD+9g4gOpQfp0t5SIzJac5qrHjWQds4iw7C8=;
  b=nrDIlR+5vaf6LTGy0Ryz+nfn31Ug76cyDo5k44YdKANBJpMg28JYJNDL
   MVdqxAVH4NbdGks3wSVjWoLwh9RBWAfONd/I3GZGmyjPp7lgzm5NGspKk
   KUlEYpteHQxSn8ggIsR5jSs+U2kwdxY1GjLeN0/WiDBN+ewGPDkhkobHB
   hDyzgSB0LqZoI/sGnUqlM474VdltSRucGXyq/QhPSbJlYl1quPNuQIPtO
   NsQATCS7YjnyfWyIJhmW8sdu5+9Kp7oldhBZPyLTN4I/HV1LDuzvmwjH2
   Bxm9CVv6T9Hr9Wd5OBdQQ/yVFMEWAfnVf5f+HztLStp0CpcnKhajjTZbY
   A==;
X-CSE-ConnectionGUID: aEATL9OISO+z47F85dVVJQ==
X-CSE-MsgGUID: R3PUfUbETQikCTYOEoqF+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="50008200"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="50008200"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 10:17:22 -0700
X-CSE-ConnectionGUID: qVEhXmnVRtiLQvylOYTIwQ==
X-CSE-MsgGUID: jyr4rZg6S3+79dGN0sHlfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="146198911"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 23 May 2025 10:17:15 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uIW1B-000Qc0-0b;
	Fri, 23 May 2025 17:17:13 +0000
Date: Sat, 24 May 2025 01:16:35 +0800
From: kernel test robot <lkp@intel.com>
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org,
	almasrymina@google.com, ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com, hawk@kernel.org, akpm@linux-foundation.org,
	davem@davemloft.net, john.fastabend@gmail.com,
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com,
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
	saeedm@nvidia.com, leon@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com
Subject: Re: [PATCH 18/18] mm, netmem: remove the page pool members in struct
 page
Message-ID: <202505240152.9ODpQBK0-lkp@intel.com>
References: <20250523032609.16334-19-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523032609.16334-19-byungchul@sk.com>

Hi Byungchul,

kernel test robot noticed the following build errors:

[auto build test ERROR on f44092606a3f153bb7e6b277006b1f4a5b914cfc]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/netmem-introduce-struct-netmem_desc-struct_group_tagged-ed-on-struct-net_iov/20250523-112806
base:   f44092606a3f153bb7e6b277006b1f4a5b914cfc
patch link:    https://lore.kernel.org/r/20250523032609.16334-19-byungchul%40sk.com
patch subject: [PATCH 18/18] mm, netmem: remove the page pool members in struct page
config: x86_64-rhel-9.4-kunit (https://download.01.org/0day-ci/archive/20250524/202505240152.9ODpQBK0-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250524/202505240152.9ODpQBK0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505240152.9ODpQBK0-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/net/intel/libie/rx.h:7,
                    from drivers/net/ethernet/intel/iavf/iavf_txrx.c:5:
   include/net/libeth/rx.h: In function 'libeth_rx_sync_for_cpu':
   include/net/libeth/rx.h:140:40: error: 'struct page' has no member named 'pp'
     140 |         page_pool_dma_sync_for_cpu(page->pp, page, fqe->offset, len);
         |                                        ^~
   drivers/net/ethernet/intel/iavf/iavf_txrx.c: In function 'iavf_add_rx_frag':
>> drivers/net/ethernet/intel/iavf/iavf_txrx.c:1200:33: error: 'struct page' has no member named 'pp'
    1200 |         u32 hr = rx_buffer->page->pp->p.offset;
         |                                 ^~
   drivers/net/ethernet/intel/iavf/iavf_txrx.c: In function 'iavf_build_skb':
   drivers/net/ethernet/intel/iavf/iavf_txrx.c:1217:33: error: 'struct page' has no member named 'pp'
    1217 |         u32 hr = rx_buffer->page->pp->p.offset;
         |                                 ^~
--
   In file included from drivers/net/ethernet/intel/idpf/idpf_txrx.c:4:
   include/net/libeth/rx.h: In function 'libeth_rx_sync_for_cpu':
   include/net/libeth/rx.h:140:40: error: 'struct page' has no member named 'pp'
     140 |         page_pool_dma_sync_for_cpu(page->pp, page, fqe->offset, len);
         |                                        ^~
   drivers/net/ethernet/intel/idpf/idpf_txrx.c: In function 'idpf_rx_page_rel':
>> drivers/net/ethernet/intel/idpf/idpf_txrx.c:389:45: error: 'struct page' has no member named 'pp'
     389 |         page_pool_put_full_page(rx_buf->page->pp, rx_buf->page, false);
         |                                             ^~
   drivers/net/ethernet/intel/idpf/idpf_txrx.c: In function 'idpf_rx_add_frag':
   drivers/net/ethernet/intel/idpf/idpf_txrx.c:3254:30: error: 'struct page' has no member named 'pp'
    3254 |         u32 hr = rx_buf->page->pp->p.offset;
         |                              ^~
   drivers/net/ethernet/intel/idpf/idpf_txrx.c: In function 'idpf_rx_hsplit_wa':
   drivers/net/ethernet/intel/idpf/idpf_txrx.c:3286:64: error: 'struct page' has no member named 'pp'
    3286 |         dst = page_address(hdr->page) + hdr->offset + hdr->page->pp->p.offset;
         |                                                                ^~
   drivers/net/ethernet/intel/idpf/idpf_txrx.c:3287:64: error: 'struct page' has no member named 'pp'
    3287 |         src = page_address(buf->page) + buf->offset + buf->page->pp->p.offset;
         |                                                                ^~
   drivers/net/ethernet/intel/idpf/idpf_txrx.c: In function 'idpf_rx_build_skb':
   drivers/net/ethernet/intel/idpf/idpf_txrx.c:3305:27: error: 'struct page' has no member named 'pp'
    3305 |         u32 hr = buf->page->pp->p.offset;
         |                           ^~
--
   In file included from drivers/net/wireless/mediatek/mt76/mt76x2/../mt76x02.h:12,
                    from drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h:23,
                    from drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c:9:
   drivers/net/wireless/mediatek/mt76/mt76x2/../mt76.h: In function 'mt76_put_page_pool_buf':
>> drivers/net/wireless/mediatek/mt76/mt76x2/../mt76.h:1788:37: error: 'struct page' has no member named 'pp'
    1788 |         page_pool_put_full_page(page->pp, page, allow_direct);
         |                                     ^~


vim +1200 drivers/net/ethernet/intel/iavf/iavf_txrx.c

7f12ad741a4870 drivers/net/ethernet/intel/i40evf/i40e_txrx.c Greg Rose         2013-12-21  1184  
ab9ad98eb5f95b drivers/net/ethernet/intel/i40evf/i40e_txrx.c Jesse Brandeburg  2016-04-18  1185  /**
56184e01c00d6d drivers/net/ethernet/intel/iavf/iavf_txrx.c   Jesse Brandeburg  2018-09-14  1186   * iavf_add_rx_frag - Add contents of Rx buffer to sk_buff
ab9ad98eb5f95b drivers/net/ethernet/intel/i40evf/i40e_txrx.c Jesse Brandeburg  2016-04-18  1187   * @skb: sk_buff to place the data into
5fa4caff59f251 drivers/net/ethernet/intel/iavf/iavf_txrx.c   Alexander Lobakin 2024-04-18  1188   * @rx_buffer: buffer containing page to add
a0cfc3130eef54 drivers/net/ethernet/intel/i40evf/i40e_txrx.c Alexander Duyck   2017-03-14  1189   * @size: packet length from rx_desc
ab9ad98eb5f95b drivers/net/ethernet/intel/i40evf/i40e_txrx.c Jesse Brandeburg  2016-04-18  1190   *
ab9ad98eb5f95b drivers/net/ethernet/intel/i40evf/i40e_txrx.c Jesse Brandeburg  2016-04-18  1191   * This function will add the data contained in rx_buffer->page to the skb.
fa2343e9034ce6 drivers/net/ethernet/intel/i40evf/i40e_txrx.c Alexander Duyck   2017-03-14  1192   * It will just attach the page as a frag to the skb.
ab9ad98eb5f95b drivers/net/ethernet/intel/i40evf/i40e_txrx.c Jesse Brandeburg  2016-04-18  1193   *
fa2343e9034ce6 drivers/net/ethernet/intel/i40evf/i40e_txrx.c Alexander Duyck   2017-03-14  1194   * The function will then update the page offset.
ab9ad98eb5f95b drivers/net/ethernet/intel/i40evf/i40e_txrx.c Jesse Brandeburg  2016-04-18  1195   **/
5fa4caff59f251 drivers/net/ethernet/intel/iavf/iavf_txrx.c   Alexander Lobakin 2024-04-18  1196  static void iavf_add_rx_frag(struct sk_buff *skb,
5fa4caff59f251 drivers/net/ethernet/intel/iavf/iavf_txrx.c   Alexander Lobakin 2024-04-18  1197  			     const struct libeth_fqe *rx_buffer,
a0cfc3130eef54 drivers/net/ethernet/intel/i40evf/i40e_txrx.c Alexander Duyck   2017-03-14  1198  			     unsigned int size)
ab9ad98eb5f95b drivers/net/ethernet/intel/i40evf/i40e_txrx.c Jesse Brandeburg  2016-04-18  1199  {
5fa4caff59f251 drivers/net/ethernet/intel/iavf/iavf_txrx.c   Alexander Lobakin 2024-04-18 @1200  	u32 hr = rx_buffer->page->pp->p.offset;
efa14c3985828d drivers/net/ethernet/intel/iavf/iavf_txrx.c   Mitch Williams    2019-05-14  1201  
fa2343e9034ce6 drivers/net/ethernet/intel/i40evf/i40e_txrx.c Alexander Duyck   2017-03-14  1202  	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
5fa4caff59f251 drivers/net/ethernet/intel/iavf/iavf_txrx.c   Alexander Lobakin 2024-04-18  1203  			rx_buffer->offset + hr, size, rx_buffer->truesize);
9a064128fc8489 drivers/net/ethernet/intel/i40evf/i40e_txrx.c Alexander Duyck   2017-03-14  1204  }
9a064128fc8489 drivers/net/ethernet/intel/i40evf/i40e_txrx.c Alexander Duyck   2017-03-14  1205  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

