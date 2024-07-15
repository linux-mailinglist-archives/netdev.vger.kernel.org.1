Return-Path: <netdev+bounces-111471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EFE931380
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 13:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC211C224CB
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 11:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0D718A937;
	Mon, 15 Jul 2024 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0djX3x7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ED3189F5C
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721044442; cv=none; b=ANwcfUm0BCvyQ/J5dcSk8apeUQejMTc5fYDlAZnJIW/zvpWGp4FGssQoY9wZo+CQt+KMwKjaDnPIexiIAoiwBEQeWRvpPIB2luu+Vj+mwCSCFl//gnJ/vxogu+FvzXf/mSSMITu+ywdJaqiIvFHTFaFlx4OucunLZCpaB8KIEsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721044442; c=relaxed/simple;
	bh=q2MNFGrYos0TV2OoL2Y4eixBsaG641x2ivZYCOOjUDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSfogxhn2PWdgzh9pBIiUo3fdr9dtf9EKHeLBkw9sxUSUzlbwflmTY/szukUIed9N1wKF0h5mtGR8XX6LY6Tv7ZlreZqTUhMHh+HGeHekWTMcg4Ls8ld/DWr/nuGUWGxa5xJecl8wOUnQ3I/sofcBQ4aBxDXvZNEOJ1THA80RQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0djX3x7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721044440; x=1752580440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q2MNFGrYos0TV2OoL2Y4eixBsaG641x2ivZYCOOjUDs=;
  b=V0djX3x7En85ywO+4p0jjgc5Q1OXWobkS9nonlxwt1smELqycUfscLNi
   j760AuZjESi29K/GGxcifnSGQ5cQvCQha7pu8hT5si8U16OGbcU7INBag
   g7A1+zR8XuzcmIsufQomLh1jINguv/2ee+3C6eOmreXD4Tgy+cGy4Hhdn
   2ueHRv6XR/+43Ey+cUrksZpubP96bPQIGlkhoiv/NZKo6VZp78moh83kK
   fuO36dOazc+T2AuUhFLiRDfsd7ySnT0u6IKT301XzZjHB1N6djI5LhNug
   Q6ZMdOknMAXDYpQyBgsblMGkBH3LtLrUl1+GDg/FAf7YZeOvObopofvOx
   g==;
X-CSE-ConnectionGUID: pJJX35/+Sz+yVkobL7q9Gg==
X-CSE-MsgGUID: 1QsrJeWvSYua063VHz7uAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="35957988"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="35957988"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 04:53:59 -0700
X-CSE-ConnectionGUID: 4yYZ++m2RPmzqXd0nQa6uw==
X-CSE-MsgGUID: Cd5CvnjPTU2eRhdc3QNN/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="49685668"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 15 Jul 2024 04:53:57 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sTKHD-000eGU-0m;
	Mon, 15 Jul 2024 11:53:55 +0000
Date: Mon, 15 Jul 2024 19:53:15 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org
Cc: oe-kbuild-all@lists.linux.dev,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@chopps.org>
Subject: Re: [PATCH ipsec-next v5 17/17] xfrm: iptfs: add tracepoint
 functionality
Message-ID: <202407151936.lWZK9Xnp-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on klassert-ipsec-next/master]
[also build test ERROR on next-20240715]
[cannot apply to klassert-ipsec/master netfilter-nf/main linus/master nf-next/master v6.10]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Hopps/xfrm-config-add-CONFIG_XFRM_IPTFS/20240715-042948
base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
patch link:    https://lore.kernel.org/r/20240714202246.1573817-18-chopps%40chopps.org
patch subject: [PATCH ipsec-next v5 17/17] xfrm: iptfs: add tracepoint functionality
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20240715/202407151936.lWZK9Xnp-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240715/202407151936.lWZK9Xnp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407151936.lWZK9Xnp-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:102,
                    from net/xfrm/trace_iptfs.h:218,
                    from net/xfrm/xfrm_iptfs.c:445:
   include/trace/../../net/xfrm/trace_iptfs.h: In function 'trace_event_raw_event_iptfs_egress_recv':
>> include/trace/../../net/xfrm/trace_iptfs.h:46:42: error: assignment to 'u32' {aka 'unsigned int'} from 'sk_buff_data_t' {aka 'unsigned char *'} makes integer from pointer without a cast [-Wint-conversion]
      46 |                            __entry->tail = skb->tail;
         |                                          ^
   include/trace/trace_events.h:402:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
     402 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   include/trace/../../net/xfrm/trace_iptfs.h:22:1: note: in expansion of macro 'TRACE_EVENT'
      22 | TRACE_EVENT(iptfs_egress_recv,
         | ^~~~~~~~~~~
   include/trace/../../net/xfrm/trace_iptfs.h:40:13: note: in expansion of macro 'TP_fast_assign'
      40 |             TP_fast_assign(__entry->skb = skb;
         |             ^~~~~~~~~~~~~~
   include/trace/../../net/xfrm/trace_iptfs.h:47:41: error: assignment to 'u32' {aka 'unsigned int'} from 'sk_buff_data_t' {aka 'unsigned char *'} makes integer from pointer without a cast [-Wint-conversion]
      47 |                            __entry->end = skb->end;
         |                                         ^
   include/trace/trace_events.h:402:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
     402 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   include/trace/../../net/xfrm/trace_iptfs.h:22:1: note: in expansion of macro 'TRACE_EVENT'
      22 | TRACE_EVENT(iptfs_egress_recv,
         | ^~~~~~~~~~~
   include/trace/../../net/xfrm/trace_iptfs.h:40:13: note: in expansion of macro 'TP_fast_assign'
      40 |             TP_fast_assign(__entry->skb = skb;
         |             ^~~~~~~~~~~~~~
   In file included from include/trace/define_trace.h:103:
   include/trace/../../net/xfrm/trace_iptfs.h: In function 'perf_trace_iptfs_egress_recv':
>> include/trace/../../net/xfrm/trace_iptfs.h:46:42: error: assignment to 'u32' {aka 'unsigned int'} from 'sk_buff_data_t' {aka 'unsigned char *'} makes integer from pointer without a cast [-Wint-conversion]
      46 |                            __entry->tail = skb->tail;
         |                                          ^
   include/trace/perf.h:51:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
      51 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   include/trace/../../net/xfrm/trace_iptfs.h:22:1: note: in expansion of macro 'TRACE_EVENT'
      22 | TRACE_EVENT(iptfs_egress_recv,
         | ^~~~~~~~~~~
   include/trace/../../net/xfrm/trace_iptfs.h:40:13: note: in expansion of macro 'TP_fast_assign'
      40 |             TP_fast_assign(__entry->skb = skb;
         |             ^~~~~~~~~~~~~~
   include/trace/../../net/xfrm/trace_iptfs.h:47:41: error: assignment to 'u32' {aka 'unsigned int'} from 'sk_buff_data_t' {aka 'unsigned char *'} makes integer from pointer without a cast [-Wint-conversion]
      47 |                            __entry->end = skb->end;
         |                                         ^
   include/trace/perf.h:51:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
      51 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   include/trace/../../net/xfrm/trace_iptfs.h:22:1: note: in expansion of macro 'TRACE_EVENT'
      22 | TRACE_EVENT(iptfs_egress_recv,
         | ^~~~~~~~~~~
   include/trace/../../net/xfrm/trace_iptfs.h:40:13: note: in expansion of macro 'TP_fast_assign'
      40 |             TP_fast_assign(__entry->skb = skb;
         |             ^~~~~~~~~~~~~~


vim +46 include/trace/../../net/xfrm/trace_iptfs.h

    21	
    22	TRACE_EVENT(iptfs_egress_recv,
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
  > 46				   __entry->tail = skb->tail;
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

