Return-Path: <netdev+bounces-96248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4012C8C4B8C
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 05:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE481C20AD6
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 03:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34726BA45;
	Tue, 14 May 2024 03:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HMVoaVoE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5FEAD53
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 03:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715658078; cv=none; b=czfJy8pEqvn5SHOxL8q/UQQgRC5Z5sa1+BjV199CsMsqM1yQCPYSRBnZZvqcvN5+4VIo+gIh3m4na/R/WVVhvsE8tjLU3FzEyMErn6KC8z8BzuPSFxoT/K+pVKuuD8CLbm5k0178SByi+96LwzMRa+iNoxcSpJS5bRPYG1nCnVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715658078; c=relaxed/simple;
	bh=FGRwMTq/Mo0xUUMXD7Y5KEeyZwN0z6WnuUGUhZKjFQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxtsIAhCdN7qrQFUR8/bYhjRVRetk/y+eMVVxgW2saCJbWkdYJ6LfA0OBk4ODB0fJD51oRSYwnirVHghGo62L93igBMXFV9Y/R2ubsGpIQ8n+DrOEC+krAFaE4QS/P0ezVjfyhxdvN1+HrGSuuKeGxqFHlChE1hzWefVpD75lck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HMVoaVoE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715658075; x=1747194075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FGRwMTq/Mo0xUUMXD7Y5KEeyZwN0z6WnuUGUhZKjFQw=;
  b=HMVoaVoE+7UaeSGnXu9XV9BGuPXDk17yEX3Tamyod5th8oK5m0jxRN37
   UNizZXNjHFSvVc1Bg0zgRlE+PCYnXyDlKD2cFf+P+KXkMvt6WG2O6AsSm
   f6S2PWetMCn99ELCoFb4avSAhahjMj5rGFy9Vs3KzQ7/hVGlqqLGBNm08
   zXUwa3DPSrGnxHicd4eqZ2cUPgxdFf+zc0M69f2JSW0bGsr6B3iXup0h4
   Id0Av5iXDViyGthBTNocMzw0Hk0YKWSGnwYki1gUWmcqtIZjhMwGCexxJ
   Oii5mKTv2LZ1wxVWYsF2cOVpb0pCMCVB0w+wsWxLUJUSrmg3qzimHKFG8
   g==;
X-CSE-ConnectionGUID: B2sTYwt5SAeFsPMVB2u0og==
X-CSE-MsgGUID: 6m1tc08GTgu2HbN4w9pOgQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="29110806"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="29110806"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 20:41:15 -0700
X-CSE-ConnectionGUID: DG29+5awSzmcBlIREUO0LQ==
X-CSE-MsgGUID: IXzWdtmPQ+yqLozkpfPcoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="53747983"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 13 May 2024 20:41:12 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6j2M-000B1L-0h;
	Tue, 14 May 2024 03:41:10 +0000
Date: Tue, 14 May 2024 11:40:32 +0800
From: kernel test robot <lkp@intel.com>
To: zijianzhang@bytedance.com, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, edumazet@google.com,
	willemdebruijn.kernel@gmail.com, cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com, Zijian Zhang <zijianzhang@bytedance.com>
Subject: Re: [PATCH net-next v4 2/3] sock: add MSG_ZEROCOPY notification
 mechanism based on msg_control
Message-ID: <202405141135.xZDS5YLg-lkp@intel.com>
References: <20240513211755.2751955-3-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513211755.2751955-3-zijianzhang@bytedance.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/zijianzhang-bytedance-com/selftests-fix-OOM-problem-in-msg_zerocopy-selftest/20240514-051839
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240513211755.2751955-3-zijianzhang%40bytedance.com
patch subject: [PATCH net-next v4 2/3] sock: add MSG_ZEROCOPY notification mechanism based on msg_control
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20240514/202405141135.xZDS5YLg-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240514/202405141135.xZDS5YLg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405141135.xZDS5YLg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/core/sock.c: In function '__sock_cmsg_send':
>> net/core/sock.c:2850:39: warning: unused variable 'tmp' [-Wunused-variable]
    2850 |                 struct sk_buff *skb, *tmp;
         |                                       ^~~


vim +/tmp +2850 net/core/sock.c

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
  2845		case SCM_ZC_NOTIFICATION: {
  2846			struct zc_info_elem zc_info_kern[SOCK_ZC_INFO_MAX];
  2847			int cmsg_data_len, zc_info_elem_num;
  2848			struct sk_buff_head *q, local_q;
  2849			struct sock_exterr_skb *serr;
> 2850			struct sk_buff *skb, *tmp;
  2851			void __user	*usr_addr;
  2852			unsigned long flags;
  2853			int ret, i = 0;
  2854	
  2855			if (!sock_flag(sk, SOCK_ZEROCOPY) || sk->sk_family == PF_RDS)
  2856				return -EINVAL;
  2857	
  2858			cmsg_data_len = cmsg->cmsg_len - sizeof(struct cmsghdr);
  2859			if (cmsg_data_len % sizeof(struct zc_info_elem))
  2860				return -EINVAL;
  2861	
  2862			zc_info_elem_num = cmsg_data_len / sizeof(struct zc_info_elem);
  2863			if (!zc_info_elem_num || zc_info_elem_num > SOCK_ZC_INFO_MAX)
  2864				return -EINVAL;
  2865	
  2866			if (in_compat_syscall())
  2867				usr_addr = compat_ptr(*(compat_uptr_t *)CMSG_DATA(cmsg));
  2868			else
  2869				usr_addr = (void __user *)*(void **)CMSG_DATA(cmsg);
  2870			if (!access_ok(usr_addr, cmsg_data_len))
  2871				return -EFAULT;
  2872	
  2873			q = &sk->sk_error_queue;
  2874			skb_queue_head_init(&local_q);
  2875			spin_lock_irqsave(&q->lock, flags);
  2876			skb = skb_peek(q);
  2877			while (skb && i < zc_info_elem_num) {
  2878				struct sk_buff *skb_next = skb_peek_next(skb, q);
  2879	
  2880				serr = SKB_EXT_ERR(skb);
  2881				if (serr->ee.ee_errno == 0 &&
  2882				    serr->ee.ee_origin == SO_EE_ORIGIN_ZEROCOPY) {
  2883					zc_info_kern[i].hi = serr->ee.ee_data;
  2884					zc_info_kern[i].lo = serr->ee.ee_info;
  2885					zc_info_kern[i].zerocopy = !(serr->ee.ee_code
  2886									& SO_EE_CODE_ZEROCOPY_COPIED);
  2887					__skb_unlink(skb, q);
  2888					__skb_queue_tail(&local_q, skb);
  2889					i++;
  2890				}
  2891				skb = skb_next;
  2892			}
  2893			spin_unlock_irqrestore(&q->lock, flags);
  2894	
  2895			ret = copy_to_user(usr_addr,
  2896					   zc_info_kern,
  2897						i * sizeof(struct zc_info_elem));
  2898	
  2899			if (unlikely(ret)) {
  2900				spin_lock_irqsave(&q->lock, flags);
  2901				skb_queue_splice_init(&local_q, q);
  2902				spin_unlock_irqrestore(&q->lock, flags);
  2903				return -EFAULT;
  2904			}
  2905	
  2906			while ((skb = __skb_dequeue(&local_q)))
  2907				consume_skb(skb);
  2908			break;
  2909		}
  2910		default:
  2911			return -EINVAL;
  2912		}
  2913		return 0;
  2914	}
  2915	EXPORT_SYMBOL(__sock_cmsg_send);
  2916	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

