Return-Path: <netdev+bounces-240216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5D7C719EC
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 01:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B0542349C92
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 00:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32E022424C;
	Thu, 20 Nov 2025 00:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bI9g39ct"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5E0223DC0
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 00:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763600104; cv=none; b=Imkze40+5mCfmvzBFzeRPfd48CdySaEyroAoduxdYPk629DLgc2YCholy0k586wSynpF34e1lK0BSaX1sepHRVOp2SkNrAk1J4jsBT4AZSbzQpD06QXgG1eDZ2a1MR1BBeBoA4tjkPTDccP03miaZm8W/9U9Re/kqb3jt/NnC3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763600104; c=relaxed/simple;
	bh=vPH6Yy1uBNJbHoprMDZK+Zi5/Zu1im6iJecndrUoKk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8WUbChWG6p5WdrrjO3tJczQWVr0PHKhWR0i+IFPy0vraShhT1AfrYTO6yTjv6dDH5yZz5I6pxoRtouisDZfBebSq5Yq1ai0qpEuMaRUf8y9jsoD35ao4cBOyvaq9vj6BlqhEOPJE/7sW2Bdw5YS+zYFk5zoZKXFFb2AsS7eh38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bI9g39ct; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763600103; x=1795136103;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vPH6Yy1uBNJbHoprMDZK+Zi5/Zu1im6iJecndrUoKk4=;
  b=bI9g39ct3BrXJlJLgXDfJUcdpjC+R8ySZvEYoAjkPbRW380U47VmKJbs
   fGrCTXPmdC6Q76ySffkLPU4OiiG6+ZgDrdQn1IlWVZi68tYsc0d2D+OQy
   FXZ8IQYJ6HPiyv/HRjzZfR8xQF1rNeaSlekH7DxpdDUCVe7GGRdeqiRkM
   cOyKdCzdr0y54YoFVmy1tXu3yhqUGxRr2f+5ZaqOWFkJSR41onSV/QnE9
   MV7wKiXo3TeQhzOBcfR+XZN/Jvd7/szHe21TuBkdZiS4D0m9V9TfKI7iU
   BN4ZTvvVgJvCwgz9MKnUNoRMvqrImTYAtMdM9VYyFD+a23XlsObguigqR
   A==;
X-CSE-ConnectionGUID: F1k8JAuCQ0WZbauNKTEtKA==
X-CSE-MsgGUID: 09mQMJxHTSu8Xvk0LHpUhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65553043"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="65553043"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 16:55:02 -0800
X-CSE-ConnectionGUID: aOq6aHVbRJGjbSO39R3BGw==
X-CSE-MsgGUID: Rnghr5/BQkmFjOjuCOH0fw==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 19 Nov 2025 16:54:59 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLswq-0003Sl-32;
	Thu, 20 Nov 2025 00:54:56 +0000
Date: Thu, 20 Nov 2025 08:54:43 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v6 2/2] virtio-net: correct hdr_len handling for
 tunnel gso
Message-ID: <202511200817.29vdvG8S-lkp@intel.com>
References: <20251119055522.617-3-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119055522.617-3-xuanzhuo@linux.alibaba.com>

Hi Xuan,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio-net-correct-hdr_len-handling-for-VIRTIO_NET_F_GUEST_HDRLEN/20251119-135650
base:   net/main
patch link:    https://lore.kernel.org/r/20251119055522.617-3-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH net v6 2/2] virtio-net: correct hdr_len handling for tunnel gso
config: arm-jornada720_defconfig (https://download.01.org/0day-ci/archive/20251120/202511200817.29vdvG8S-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 0bba1e76581bad04e7d7f09f5115ae5e2989e0d9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251120/202511200817.29vdvG8S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511200817.29vdvG8S-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/packet/af_packet.c:86:
>> include/linux/virtio_net.h:218:7: error: use of undeclared identifier 'sinfo'
     218 |                 if (sinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
         |                     ^~~~~
   1 error generated.


vim +/sinfo +218 include/linux/virtio_net.h

   209	
   210	static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
   211						 struct virtio_net_hdr *hdr,
   212						 bool little_endian,
   213						 bool guest_hdrlen)
   214	{
   215		u16 hdr_len;
   216	
   217		if (guest_hdrlen) {
 > 218			if (sinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
   219					       SKB_GSO_UDP_TUNNEL_CSUM)) {
   220				hdr_len = skb_inner_transport_offset(skb);
   221	
   222				if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
   223					hdr_len += sizeof(struct udphdr);
   224				else
   225					hdr_len += inner_tcp_hdrlen(skb);
   226			} else {
   227				hdr_len = skb_transport_offset(skb);
   228	
   229				if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
   230					hdr_len += sizeof(struct udphdr);
   231				else
   232					hdr_len += tcp_hdrlen(skb);
   233			}
   234		} else {
   235			/* This is a hint as to how much should be linear. */
   236			hdr_len = skb_headlen(skb);
   237		}
   238	
   239		hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
   240	}
   241	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

