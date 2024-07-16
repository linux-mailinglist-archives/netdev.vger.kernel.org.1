Return-Path: <netdev+bounces-111766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEA69327F1
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 16:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266E71F23AB5
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 14:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B3D198E98;
	Tue, 16 Jul 2024 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kBUPy7Bk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1D5152E02
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721138461; cv=none; b=NP5EtAQip1+V26PkaLxqBzoIsP6iTf0cKCgSllD1RdQyUq+r1mv9XUw7TzY28Wc2TNmTta6QqNWLcEW7ybOI7yPPfW0MJD7ILAmmcLZuxJFL3mo2l/vH3Mp6hix1PiOq7eXmLmcMkhYHpYetdvIdSzQ9yYuQLhKs8PaCKrkToD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721138461; c=relaxed/simple;
	bh=czNvutpG6PPjyDQStpbBq48lutxp6eM7GmFhS+Nes/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8vTZYay5P4dAe+NZdQtTDPRulRY6owuDQrpwkIh4+P7uHZ5uRaBXinrWCc+73C4S1eqoNXObIb4jZSFD99tMdwQ9+2/sss3w/+XRQg0EGLBKY6x88g3AESAaEo4HzXKWPIk2usP0rDvd6H8miYq2n2QgbHyXhXXE4T0DJ9TKpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kBUPy7Bk; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721138459; x=1752674459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=czNvutpG6PPjyDQStpbBq48lutxp6eM7GmFhS+Nes/Q=;
  b=kBUPy7BkbfWYZ4jgbyDyuVVcySHwFYRXfHK4Eb88Ppvp0DC0lYbbGqFl
   P2rw+Ml1qjf14NhvTIoTj5EsNmf+D5FdUWnM+xsiSUTIuCZ4vIIH9EJMr
   cLYepxcV5VsuZeIqcz9Eh2ED/lhK9iAJ0ltX+e9FhPDJI0jsAA/OuVOcY
   YuBWAbpsBO4PYzz7u0FCVX2qBxFz3/IVk7SBPymkrldNSAKkKQkSkUSku
   deIFJJKEkI8SutqLZHQB3Iw4jAV2DOBmEfdmAwaxo+pb3k4X3tcJzsh+D
   GgigmOH5Xhel+Xg5hLberAyerWJl6Y4eeMsI4LLjBwTqLlHto+WTXPdYr
   Q==;
X-CSE-ConnectionGUID: IjLdc4ymT3aKg2JHCoRr8w==
X-CSE-MsgGUID: dxbiu4odQgmVnbaLZQsHvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="22439598"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="22439598"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 07:00:59 -0700
X-CSE-ConnectionGUID: Qrr2rGirRP+KF/xcveC19g==
X-CSE-MsgGUID: YzG3ubOpSXea9IPkdDJxBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="54871942"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 16 Jul 2024 07:00:57 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sTijf-000fHe-0d;
	Tue, 16 Jul 2024 14:00:55 +0000
Date: Tue, 16 Jul 2024 22:00:35 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org
Cc: oe-kbuild-all@lists.linux.dev,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@chopps.org>
Subject: Re: [PATCH ipsec-next v5 09/17] xfrm: iptfs: add user packet (tunnel
 ingress) handling
Message-ID: <202407162110.8Xuwy6GR-lkp@intel.com>
References: <20240714202246.1573817-10-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240714202246.1573817-10-chopps@chopps.org>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on klassert-ipsec-next/master]
[also build test ERROR on next-20240716]
[cannot apply to klassert-ipsec/master netfilter-nf/main linus/master nf-next/master v6.10]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Hopps/xfrm-config-add-CONFIG_XFRM_IPTFS/20240715-042948
base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
patch link:    https://lore.kernel.org/r/20240714202246.1573817-10-chopps%40chopps.org
patch subject: [PATCH ipsec-next v5 09/17] xfrm: iptfs: add user packet (tunnel ingress) handling
config: i386-randconfig-061-20240716 (https://download.01.org/0day-ci/archive/20240716/202407162110.8Xuwy6GR-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240716/202407162110.8Xuwy6GR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407162110.8Xuwy6GR-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: net/xfrm/xfrm_iptfs.o: in function `iptfs_user_init':
>> net/xfrm/xfrm_iptfs.c:586:(.text+0x2a0): undefined reference to `__udivdi3'


vim +586 net/xfrm/xfrm_iptfs.c

   547	
   548	/**
   549	 * iptfs_user_init() - initialize the SA with IPTFS options from netlink.
   550	 * @net: the net data
   551	 * @x: xfrm state
   552	 * @attrs: netlink attributes
   553	 * @extack: extack return data
   554	 */
   555	static int iptfs_user_init(struct net *net, struct xfrm_state *x,
   556				   struct nlattr **attrs,
   557				   struct netlink_ext_ack *extack)
   558	{
   559		struct xfrm_iptfs_data *xtfs = x->mode_data;
   560		struct xfrm_iptfs_config *xc;
   561	
   562		xc = &xtfs->cfg;
   563		xc->max_queue_size = net->xfrm.sysctl_iptfs_max_qsize;
   564		xtfs->init_delay_ns =
   565			(u64)net->xfrm.sysctl_iptfs_init_delay * NSECS_IN_USEC;
   566	
   567		if (attrs[XFRMA_IPTFS_PKT_SIZE]) {
   568			xc->pkt_size = nla_get_u32(attrs[XFRMA_IPTFS_PKT_SIZE]);
   569			if (!xc->pkt_size) {
   570				xtfs->payload_mtu = 0;
   571			} else if (xc->pkt_size > x->props.header_len) {
   572				xtfs->payload_mtu = xc->pkt_size - x->props.header_len;
   573			} else {
   574				NL_SET_ERR_MSG(extack,
   575					       "Packet size must be 0 or greater than IPTFS/ESP header length");
   576				return -EINVAL;
   577			}
   578		}
   579		if (attrs[XFRMA_IPTFS_MAX_QSIZE])
   580			xc->max_queue_size = nla_get_u32(attrs[XFRMA_IPTFS_MAX_QSIZE]);
   581		if (attrs[XFRMA_IPTFS_INIT_DELAY])
   582			xtfs->init_delay_ns =
   583				(u64)nla_get_u32(attrs[XFRMA_IPTFS_INIT_DELAY]) *
   584				NSECS_IN_USEC;
   585	
 > 586		xtfs->ecn_queue_size = (u64)xc->max_queue_size * 95 / 100;
   587	
   588		return 0;
   589	}
   590	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

