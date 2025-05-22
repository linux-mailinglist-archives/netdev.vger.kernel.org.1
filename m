Return-Path: <netdev+bounces-192542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB278AC04C4
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 329B57A4680
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 06:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA49221D8F;
	Thu, 22 May 2025 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z/6eVQFF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981D4317D
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747896266; cv=none; b=eBOpPbWBfzHaKxBwFaphDALUAA0jntA52OBG27mjEAAuo6a8Lh83kTxr6d5Tokxego8wR6BbjCuPhlOygRSwUx+25oK/UhfZ4ZwdQD6peDdv53R/nXsKEBsjZ0RITrSSFZfm+f8bcZhTunSdM4Uwt6ksuMXEDlEaQTOoM33kzkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747896266; c=relaxed/simple;
	bh=oYIYnqSBWlXfF2kein8Om3ts5PCb6cQXT7KcxCPK8Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cV+xG4VaFfVNRHH6MokIemdcKhjfMOG/n8/0x5H15q0s4Gey176tZWlTFfX6f/LyUyj88ByqpafUkixb0mF9768X5iMDT3kcga/br7Jb3Z8a8Vq4967ZXoq0Zotfa2UCBT8rniFUM+7bPgg7TpLpIh3Zx4uEM3IiZga1o8oe9YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z/6eVQFF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747896265; x=1779432265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oYIYnqSBWlXfF2kein8Om3ts5PCb6cQXT7KcxCPK8Oo=;
  b=Z/6eVQFFjeZRRQWk1KiNcpwFloyyydILnbYTahk6L687IEe+n5gUQXdM
   1W9HyCHlI72eXqSndUfktb+eg2HaA6/MLZDZ/zbcmf4cAIAuWkp4mkWQO
   3itsthhy2EoczeY7CBt0lQs9ifFjVrTwN9I98npoESmswrUeZGALSORxb
   Ia9n6Xbk90Gjwul2CsRu7Cbo3/6mKdH/D3RKkPoXqdQvDe0kYrOrNREaK
   CrrMRKO8kJmwHGjtlgKOt9AXlfFP3Jz4ZYC4l+0Lh3+0jyCy4sTZ/+5lf
   drgTyGu4xCnjWdI+9bjVwvoPU2jEqrOMbxCpcbeM+1xcx2o5IU0fqdYEd
   w==;
X-CSE-ConnectionGUID: i9eJOHnrRz6ays9JW7hJHA==
X-CSE-MsgGUID: yhY85VfLRPePda7G948M0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="61248481"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="61248481"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 23:44:23 -0700
X-CSE-ConnectionGUID: cKYEd3ERRTqi4+9dHdxZYQ==
X-CSE-MsgGUID: lBPlgVxURfGqH321POF61g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="140971499"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 21 May 2025 23:44:11 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHzey-000P0K-2X;
	Thu, 22 May 2025 06:44:08 +0000
Date: Thu, 22 May 2025 14:43:50 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH net-next 8/8] vhost/net: enable gso over UDP tunnel
 support.
Message-ID: <202505221428.67HNn025-lkp@intel.com>
References: <f95716aed2c65d079cdb10518431088f3e103899.1747822866.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f95716aed2c65d079cdb10518431088f3e103899.1747822866.git.pabeni@redhat.com>

Hi Paolo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Abeni/virtio-introduce-virtio_features_t/20250521-183700
base:   net-next/main
patch link:    https://lore.kernel.org/r/f95716aed2c65d079cdb10518431088f3e103899.1747822866.git.pabeni%40redhat.com
patch subject: [PATCH net-next 8/8] vhost/net: enable gso over UDP tunnel support.
config: i386-buildonly-randconfig-001-20250522 (https://download.01.org/0day-ci/archive/20250522/202505221428.67HNn025-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250522/202505221428.67HNn025-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505221428.67HNn025-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/vhost/net.c:1633:30: warning: shift count >= width of type [-Wshift-count-overflow]
    1633 |         has_tunnel = !!(features & (VIRTIO_BIT(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/virtio_features.h:18:24: note: expanded from macro 'VIRTIO_BIT'
      18 | #define VIRTIO_BIT(b)           BIT_ULL(b)
         |                                 ^~~~~~~~~~
   include/vdso/bits.h:8:30: note: expanded from macro 'BIT_ULL'
       8 | #define BIT_ULL(nr)             (ULL(1) << (nr))
         |                                         ^  ~~~~
   drivers/vhost/net.c:1634:9: warning: shift count >= width of type [-Wshift-count-overflow]
    1634 |                                     VIRTIO_BIT(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO)));
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/virtio_features.h:18:24: note: expanded from macro 'VIRTIO_BIT'
      18 | #define VIRTIO_BIT(b)           BIT_ULL(b)
         |                                 ^~~~~~~~~~
   include/vdso/bits.h:8:30: note: expanded from macro 'BIT_ULL'
       8 | #define BIT_ULL(nr)             (ULL(1) << (nr))
         |                                         ^  ~~~~
   2 warnings generated.


vim +1633 drivers/vhost/net.c

  1622	
  1623	static int vhost_net_set_features(struct vhost_net *n, virtio_features_t features)
  1624	{
  1625		size_t vhost_hlen, sock_hlen, hdr_len;
  1626		bool has_tunnel;
  1627		int i;
  1628	
  1629		hdr_len = (features & ((1ULL << VIRTIO_NET_F_MRG_RXBUF) |
  1630				       (1ULL << VIRTIO_F_VERSION_1))) ?
  1631				sizeof(struct virtio_net_hdr_mrg_rxbuf) :
  1632				sizeof(struct virtio_net_hdr);
> 1633		has_tunnel = !!(features & (VIRTIO_BIT(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
  1634					    VIRTIO_BIT(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO)));
  1635		hdr_len += has_tunnel ? sizeof(struct virtio_net_hdr_tunnel) : 0;
  1636		if (features & (1 << VHOST_NET_F_VIRTIO_NET_HDR)) {
  1637			/* vhost provides vnet_hdr */
  1638			vhost_hlen = hdr_len;
  1639			sock_hlen = 0;
  1640		} else {
  1641			/* socket provides vnet_hdr */
  1642			vhost_hlen = 0;
  1643			sock_hlen = hdr_len;
  1644		}
  1645		mutex_lock(&n->dev.mutex);
  1646		if ((features & (1 << VHOST_F_LOG_ALL)) &&
  1647		    !vhost_log_access_ok(&n->dev))
  1648			goto out_unlock;
  1649	
  1650		if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
  1651			if (vhost_init_device_iotlb(&n->dev))
  1652				goto out_unlock;
  1653		}
  1654	
  1655		for (i = 0; i < VHOST_NET_VQ_MAX; ++i) {
  1656			mutex_lock(&n->vqs[i].vq.mutex);
  1657			n->vqs[i].vq.acked_features = features;
  1658			n->vqs[i].vhost_hlen = vhost_hlen;
  1659			n->vqs[i].sock_hlen = sock_hlen;
  1660			mutex_unlock(&n->vqs[i].vq.mutex);
  1661		}
  1662		mutex_unlock(&n->dev.mutex);
  1663		return 0;
  1664	
  1665	out_unlock:
  1666		mutex_unlock(&n->dev.mutex);
  1667		return -EFAULT;
  1668	}
  1669	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

