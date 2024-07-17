Return-Path: <netdev+bounces-111835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A94C2933657
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 07:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2D21C216E8
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 05:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C02C2FC;
	Wed, 17 Jul 2024 05:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iFNaAiym"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D31BAD59
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 05:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721193703; cv=none; b=r9D0quRhgstzbsgekDr53LiRnBueO2rrkHWmY5ze/RPSmXEpZv20rOtaAVhIuoYdVfL9Phe9p8ZvqzzI8+6dEUjd/IOesZpX7/Uz4KgQuKSXT/VAqKheMOPlZC475k2DM2TGJzs4K/DE3X6Fv7wDi2musQqfpEXfp4DCSteJuzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721193703; c=relaxed/simple;
	bh=3RPa+hVZ0abYHOwn6eiDtxIodcfnMY+EzjllUsJKtY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnbMlkWMDMoodGRJEQL7ZK1I0cVylpRWeWT2gE4ZuOJ/d7DvHKE+X91oQb3gC+P2NP2rYhLr9qAnYiMM0kNVEWRg6LYcNqPKMLvOjthNGrxRNdi3Nlvmm3Gaqfx6qU5V5FoWMMWR+nzNycJMvqZGX0gui1FDKUKisSeDrAMMrz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iFNaAiym; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721193701; x=1752729701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3RPa+hVZ0abYHOwn6eiDtxIodcfnMY+EzjllUsJKtY0=;
  b=iFNaAiymBcEMsadGWJP8jTYdxxy7WpqOwk7/iixJupWjNno6B9Lcxpf7
   GIVbWn3sMO2YUBLt8HSVZoM82380g5D69akqmdzcnxokrDNawen3arq4c
   fcH2adjpPYQJoOAMuF1/As7Cihr6B1rLx3LiQSspi41ZTmGQ8prcOEIfW
   vjnKzej5y6AMdy27z7bL4dzM5NlANIZd48XEKFjCgSGBFtufSla+oDknH
   SL7irDInCAn5R0zrCptn8Q3QGpP49mA9LqTHEIO9IXL/F3pELpC2iXTOg
   xLV/7zbQSpFrp1idLPsQNJWZrsVU+WLyPe2f6rshI5cUVr8soVlgCAZmP
   g==;
X-CSE-ConnectionGUID: 5dPJCMdQRRamA/7kF1lc4Q==
X-CSE-MsgGUID: girYRQhlS/6n14puW50zMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="18783628"
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; 
   d="scan'208";a="18783628"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 22:21:41 -0700
X-CSE-ConnectionGUID: UzogHpeLS/exJR68m/BKig==
X-CSE-MsgGUID: Yx6x0Hi4T2CZ0taZhnQIog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; 
   d="scan'208";a="50330889"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 16 Jul 2024 22:21:39 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sTx6f-000fza-11;
	Wed, 17 Jul 2024 05:21:37 +0000
Date: Wed, 17 Jul 2024 13:21:07 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org
Cc: oe-kbuild-all@lists.linux.dev,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@chopps.org>
Subject: Re: [PATCH ipsec-next v5 17/17] xfrm: iptfs: add tracepoint
 functionality
Message-ID: <202407171316.DNF21j3K-lkp@intel.com>
References: <20240714202246.1573817-18-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240714202246.1573817-18-chopps@chopps.org>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on klassert-ipsec-next/master]
[also build test WARNING on next-20240716]
[cannot apply to klassert-ipsec/master netfilter-nf/main linus/master nf-next/master v6.10]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Hopps/xfrm-config-add-CONFIG_XFRM_IPTFS/20240715-042948
base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
patch link:    https://lore.kernel.org/r/20240714202246.1573817-18-chopps%40chopps.org
patch subject: [PATCH ipsec-next v5 17/17] xfrm: iptfs: add tracepoint functionality
config: i386-randconfig-061-20240716 (https://download.01.org/0day-ci/archive/20240717/202407171316.DNF21j3K-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240717/202407171316.DNF21j3K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407171316.DNF21j3K-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/xfrm/xfrm_iptfs.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, net/xfrm/trace_iptfs.h):
>> include/trace/../../net/xfrm/trace_iptfs.h:22:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] tail @@     got unsigned char *[usertype] tail @@
   include/trace/../../net/xfrm/trace_iptfs.h:22:1: sparse:     expected unsigned int [usertype] tail
   include/trace/../../net/xfrm/trace_iptfs.h:22:1: sparse:     got unsigned char *[usertype] tail
>> include/trace/../../net/xfrm/trace_iptfs.h:22:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] end @@     got unsigned char *[usertype] end @@
   include/trace/../../net/xfrm/trace_iptfs.h:22:1: sparse:     expected unsigned int [usertype] end
   include/trace/../../net/xfrm/trace_iptfs.h:22:1: sparse:     got unsigned char *[usertype] end
   net/xfrm/xfrm_iptfs.c: note: in included file (through include/trace/perf.h, include/trace/define_trace.h, net/xfrm/trace_iptfs.h):
>> include/trace/../../net/xfrm/trace_iptfs.h:22:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] tail @@     got unsigned char *[usertype] tail @@
   include/trace/../../net/xfrm/trace_iptfs.h:22:1: sparse:     expected unsigned int [usertype] tail
   include/trace/../../net/xfrm/trace_iptfs.h:22:1: sparse:     got unsigned char *[usertype] tail
>> include/trace/../../net/xfrm/trace_iptfs.h:22:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] end @@     got unsigned char *[usertype] end @@
   include/trace/../../net/xfrm/trace_iptfs.h:22:1: sparse:     expected unsigned int [usertype] end
   include/trace/../../net/xfrm/trace_iptfs.h:22:1: sparse:     got unsigned char *[usertype] end

vim +22 include/trace/../../net/xfrm/trace_iptfs.h

    21	
  > 22	TRACE_EVENT(iptfs_egress_recv,
    23		    TP_PROTO(struct sk_buff *skb, struct xfrm_iptfs_data *xtfs, u16 blkoff),
    24		    TP_ARGS(skb, xtfs, blkoff),
    25		    TP_STRUCT__entry(__field(struct sk_buff *, skb)
    26				     __field(void *, head)
    27				     __field(void *, head_pg_addr)
    28				     __field(void *, pg0addr)
    29				     __field(u32, skb_len)
    30				     __field(u32, data_len)
    31				     __field(u32, headroom)
    32				     __field(u32, tailroom)
    33				     __field(u32, tail)
    34				     __field(u32, end)
    35				     __field(u32, pg0off)
    36				     __field(u8, head_frag)
    37				     __field(u8, frag_list)
    38				     __field(u8, nr_frags)
    39				     __field(u16, blkoff)),
    40		    TP_fast_assign(__entry->skb = skb;
    41				   __entry->head = skb->head;
    42				   __entry->skb_len = skb->len;
    43				   __entry->data_len = skb->data_len;
    44				   __entry->headroom = skb_headroom(skb);
    45				   __entry->tailroom = skb_tailroom(skb);
    46				   __entry->tail = skb->tail;
    47				   __entry->end = skb->end;
    48				   __entry->head_frag = skb->head_frag;
    49				   __entry->frag_list = (bool)skb_shinfo(skb)->frag_list;
    50				   __entry->nr_frags = skb_shinfo(skb)->nr_frags;
    51				   __entry->blkoff = blkoff;
    52				   __entry->head_pg_addr = page_address(virt_to_head_page(skb->head));
    53				   __entry->pg0addr = (__entry->nr_frags
    54						       ? page_address(netmem_to_page(skb_shinfo(skb)->frags[0].netmem))
    55						       : NULL);
    56				   __entry->pg0off = (__entry->nr_frags
    57						      ? skb_shinfo(skb)->frags[0].offset
    58						      : 0);
    59			    ),
    60		    TP_printk("EGRESS: skb=%p len=%u data_len=%u headroom=%u head_frag=%u frag_list=%u nr_frags=%u blkoff=%u\n\t\ttailroom=%u tail=%u end=%u head=%p hdpgaddr=%p pg0->addr=%p pg0->data=%p pg0->off=%u",
    61			      __entry->skb, __entry->skb_len, __entry->data_len, __entry->headroom,
    62			      __entry->head_frag, __entry->frag_list, __entry->nr_frags, __entry->blkoff,
    63			      __entry->tailroom, __entry->tail, __entry->end, __entry->head,
    64			      __entry->head_pg_addr, __entry->pg0addr, __entry->pg0addr + __entry->pg0off,
    65			      __entry->pg0off)
    66		)
    67	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

