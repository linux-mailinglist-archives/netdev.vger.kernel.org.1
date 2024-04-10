Return-Path: <netdev+bounces-86473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8DC89EEAA
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 11:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB891F28025
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B193155737;
	Wed, 10 Apr 2024 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UZx16Te9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92416156861
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740792; cv=none; b=tn7h2MvPlOqpHoDuOs/PIYxgOkKV2tBwwovmn2gTWhUFUbo7aukd/UntdaZZG0laJFsuLJXkm8ddmVySdWPkprgXxNcm8VdzDxIG+RMFpmy92BMYGBxoAxxEJfyxuC2kaNmwzrP7EtPJyYExzLDhSBThk8InFntBWWZbwnK69Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740792; c=relaxed/simple;
	bh=bpEx6lesNO01hEoTbkw8bxC20naSE4lPpM/miPIqRUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjJKahWW2sp6QDQWvbjWsoUfUWDwjTu9lDSEOEdEn9YXcwKEMKmKQe8OkgjyibJ5vnOfPcv7VD/aTk6gRhkFVcKbfEUbUmJ66aBX2kE8oLYv70AeqBwQvjUlJFfGXAFQ5Dg2GcB9Q2OARnuY/r0n1VlFCsBrlgzKuny/N5IoUlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UZx16Te9; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712740791; x=1744276791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bpEx6lesNO01hEoTbkw8bxC20naSE4lPpM/miPIqRUE=;
  b=UZx16Te9nB8Ds/Y8y6Ze5BZtMmn0t2i8uVwphROYfZFTz3NkBZqn9lj0
   Fma+g/Qe3UjE/URGfZDzdDSTSrr9ruhZXsXByaI3uXK9IVBuLD5FG4vh0
   YsM08UDvPBErWODav/vN7jtCOBIrgxxRNEhlya8+og0nOuHPe2LdEn81P
   SHe9JzV60/QOX0Nx0Zkx5wc0WzUKDxp/d9aVg6l+YH3lDShv3pZgFXr6D
   CFn8eogaGNM/aKMuJtyiB/IaMrdDiw9rOiCuyhjZdZwhR6Fb7lxNaB+WV
   YRNBgyokvv/neSa+vwUp7huGLbDiR+nRbDft0lcroIa42e20sbVU/1PYM
   g==;
X-CSE-ConnectionGUID: ps3dGV+wT9iU+XaW/ksB2Q==
X-CSE-MsgGUID: x/bnJp5cT2KcNI9OeiiJrA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19479687"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="19479687"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 02:19:34 -0700
X-CSE-ConnectionGUID: Pp66azp0SPOq1W//AzkeiQ==
X-CSE-MsgGUID: ujWKxFWMSXywwezJSHYRvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="57937857"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 10 Apr 2024 02:19:31 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ruU77-0007A0-28;
	Wed, 10 Apr 2024 09:19:29 +0000
Date: Wed, 10 Apr 2024 17:18:58 +0800
From: kernel test robot <lkp@intel.com>
To: zijianzhang@bytedance.com, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, edumazet@google.com,
	willemdebruijn.kernel@gmail.com, davem@davemloft.net,
	kuba@kernel.org, cong.wang@bytedance.com, xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: Re: [PATCH net-next 1/3] sock: add MSG_ZEROCOPY_UARG
Message-ID: <202404101756.S6ltBayX-lkp@intel.com>
References: <20240409205300.1346681-2-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409205300.1346681-2-zijianzhang@bytedance.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/zijianzhang-bytedance-com/sock-add-MSG_ZEROCOPY_UARG/20240410-045616
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240409205300.1346681-2-zijianzhang%40bytedance.com
patch subject: [PATCH net-next 1/3] sock: add MSG_ZEROCOPY_UARG
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20240410/202404101756.S6ltBayX-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240410/202404101756.S6ltBayX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404101756.S6ltBayX-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/core/sock.c: In function '__sock_cmsg_send':
>> net/core/sock.c:2845:14: error: 'SO_ZEROCOPY_NOTIFICATION' undeclared (first use in this function)
    2845 |         case SO_ZEROCOPY_NOTIFICATION:
         |              ^~~~~~~~~~~~~~~~~~~~~~~~
   net/core/sock.c:2845:14: note: each undeclared identifier is reported only once for each function it appears in


vim +/SO_ZEROCOPY_NOTIFICATION +2845 net/core/sock.c

  2807	
  2808	int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
  2809			     struct sockcm_cookie *sockc)
  2810	{
  2811		u32 tsflags;
  2812	
  2813		switch (cmsg->cmsg_type) {
  2814		case SO_MARK:
  2815			if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
  2816			    !ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
  2817				return -EPERM;
  2818			if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
  2819				return -EINVAL;
  2820			sockc->mark = *(u32 *)CMSG_DATA(cmsg);
  2821			break;
  2822		case SO_TIMESTAMPING_OLD:
  2823		case SO_TIMESTAMPING_NEW:
  2824			if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
  2825				return -EINVAL;
  2826	
  2827			tsflags = *(u32 *)CMSG_DATA(cmsg);
  2828			if (tsflags & ~SOF_TIMESTAMPING_TX_RECORD_MASK)
  2829				return -EINVAL;
  2830	
  2831			sockc->tsflags &= ~SOF_TIMESTAMPING_TX_RECORD_MASK;
  2832			sockc->tsflags |= tsflags;
  2833			break;
  2834		case SCM_TXTIME:
  2835			if (!sock_flag(sk, SOCK_TXTIME))
  2836				return -EINVAL;
  2837			if (cmsg->cmsg_len != CMSG_LEN(sizeof(u64)))
  2838				return -EINVAL;
  2839			sockc->transmit_time = get_unaligned((u64 *)CMSG_DATA(cmsg));
  2840			break;
  2841		/* SCM_RIGHTS and SCM_CREDENTIALS are semantically in SOL_UNIX. */
  2842		case SCM_RIGHTS:
  2843		case SCM_CREDENTIALS:
  2844			break;
> 2845		case SO_ZEROCOPY_NOTIFICATION:
  2846			if (sock_flag(sk, SOCK_ZEROCOPY)) {
  2847				int i = 0;
  2848				struct tx_usr_zcopy_info sys_zcopy_info;
  2849				struct tx_msg_zcopy_node *zcopy_node_p, *tmp;
  2850				struct tx_msg_zcopy_queue *zcopy_queue;
  2851				struct tx_msg_zcopy_node *zcopy_node_ps[SOCK_USR_ZC_INFO_MAX];
  2852				unsigned long flags;
  2853	
  2854				if (cmsg->cmsg_len != CMSG_LEN(sizeof(void *)))
  2855					return -EINVAL;
  2856	
  2857				if (sk_is_tcp(sk))
  2858					zcopy_queue = &tcp_sk(sk)->tx_zcopy_queue;
  2859				else if (sk_is_udp(sk))
  2860					zcopy_queue = &udp_sk(sk)->tx_zcopy_queue;
  2861				else
  2862					return -EINVAL;
  2863	
  2864				spin_lock_irqsave(&zcopy_queue->lock, flags);
  2865				list_for_each_entry_safe(zcopy_node_p, tmp, &zcopy_queue->head, node) {
  2866					sys_zcopy_info.info[i].lo = zcopy_node_p->info.lo;
  2867					sys_zcopy_info.info[i].hi = zcopy_node_p->info.hi;
  2868					sys_zcopy_info.info[i].zerocopy = zcopy_node_p->info.zerocopy;
  2869					list_del(&zcopy_node_p->node);
  2870					zcopy_node_ps[i++] = zcopy_node_p;
  2871					if (i == SOCK_USR_ZC_INFO_MAX)
  2872						break;
  2873				}
  2874				spin_unlock_irqrestore(&zcopy_queue->lock, flags);
  2875	
  2876				if (i > 0) {
  2877					sys_zcopy_info.length = i;
  2878					if (unlikely(copy_to_user(*(void **)CMSG_DATA(cmsg),
  2879								  &sys_zcopy_info,
  2880								  sizeof(sys_zcopy_info))
  2881						)) {
  2882						spin_lock_irqsave(&zcopy_queue->lock, flags);
  2883						while (i > 0)
  2884							list_add(&zcopy_node_ps[--i]->node,
  2885								 &zcopy_queue->head);
  2886						spin_unlock_irqrestore(&zcopy_queue->lock, flags);
  2887						return -EFAULT;
  2888					}
  2889	
  2890					while (i > 0)
  2891						consume_skb(zcopy_node_ps[--i]->skb);
  2892				}
  2893			}
  2894			break;
  2895		default:
  2896			return -EINVAL;
  2897		}
  2898		return 0;
  2899	}
  2900	EXPORT_SYMBOL(__sock_cmsg_send);
  2901	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

