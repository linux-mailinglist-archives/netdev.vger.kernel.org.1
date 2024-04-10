Return-Path: <netdev+bounces-86528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CB089F1C0
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 14:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB872285728
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 12:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E6715B0FF;
	Wed, 10 Apr 2024 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jLzeR86+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33592159599
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712751128; cv=none; b=ZtcvhgqG5c8yBAaTv3NP/1S4kW9Oxdcwu7pxBg0HdcbaZIBTY56oWG6hFxHfRMUVk4aWVCX01YoChPtVAHitKSDHuZTqbj7HJQ3sVS81VblVb4osqiQ8h/uYhmjfbaykcjODA81dekrSmjFNogBUk6nmTJrYqJRbUNG2dGjJi+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712751128; c=relaxed/simple;
	bh=5YMqMDRaXj4Von9b/H8JmMP7Ll5GImNilbUuPUfK+1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eS3vuGW0Gr4KgU+knSV3+Q4NgtpBJlQJKjLlPu9hXTKYYjidaZGBSWvnB/kRDIPGJW3bdKpFqREQM9Yg5r0QZf4ZNXhAZDpgRPT4ZJ02QrjLlWe7BICLETpicuMfUR0fu3fygWSXHk0DEs9sFYDqppIEr0VN+ZywQf/ErjwRetw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jLzeR86+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712751126; x=1744287126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5YMqMDRaXj4Von9b/H8JmMP7Ll5GImNilbUuPUfK+1A=;
  b=jLzeR86+qmtXrrmYQMAOgV3MGmBlvVFYqqcYqpdxsostXD1wffRuDfm7
   7ROUMaxjHmrNsGWufQAU5ewvZlopZa87kP38ZMCliYSCqT7+S7xEHq0+n
   jrS4BXNTOv0zKqcZnYlJueFyVS7Bk8wugMnEcHcBpQXnt99mX1HtHvPqo
   SdMqRBfmKAtKSrJlFSRVacC0V+H6Nhh2ujm604c4ndvVljEMRLTQceBpA
   Ln+2Qp3T3TWk5GIFypLy6UAmUs5Kw+7KrBOxSiEbXCRQjsauQWZCMLsdU
   QmCslK/2oS17WbyImYFXoaXUoWBxo7oqXLtqr5Vg75lnyeImhW45VO57w
   Q==;
X-CSE-ConnectionGUID: Jg5vqMorRj2D39hsq15HyQ==
X-CSE-MsgGUID: oYSH7iVCSPS/kTJ+rWNW9w==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19534969"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="19534969"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 05:12:06 -0700
X-CSE-ConnectionGUID: iwxB65u1S9CyRrE0PPz4Tw==
X-CSE-MsgGUID: gFi+XHuMT+qS3ZM+DXa6Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="21019113"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 10 Apr 2024 05:12:03 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ruWo4-0007O6-2y;
	Wed, 10 Apr 2024 12:12:00 +0000
Date: Wed, 10 Apr 2024 20:11:23 +0800
From: kernel test robot <lkp@intel.com>
To: zijianzhang@bytedance.com, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, edumazet@google.com,
	willemdebruijn.kernel@gmail.com, davem@davemloft.net,
	kuba@kernel.org, cong.wang@bytedance.com, xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: Re: [PATCH net-next 1/3] sock: add MSG_ZEROCOPY_UARG
Message-ID: <202404101954.FBZojOXG-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/zijianzhang-bytedance-com/sock-add-MSG_ZEROCOPY_UARG/20240410-045616
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240409205300.1346681-2-zijianzhang%40bytedance.com
patch subject: [PATCH net-next 1/3] sock: add MSG_ZEROCOPY_UARG
config: i386-randconfig-061-20240410 (https://download.01.org/0day-ci/archive/20240410/202404101954.FBZojOXG-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240410/202404101954.FBZojOXG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404101954.FBZojOXG-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/core/sock.c:2878:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got void * @@
   net/core/sock.c:2878:37: sparse:     expected void [noderef] __user *to
   net/core/sock.c:2878:37: sparse:     got void *
   net/core/sock.c:2393:9: sparse: sparse: context imbalance in 'sk_clone_lock' - wrong count at exit
   net/core/sock.c:2397:6: sparse: sparse: context imbalance in 'sk_free_unlock_clone' - unexpected unlock
   net/core/sock.c:4083:13: sparse: sparse: context imbalance in 'proto_seq_start' - wrong count at exit
   net/core/sock.c:4095:13: sparse: sparse: context imbalance in 'proto_seq_stop' - wrong count at exit

vim +2878 net/core/sock.c

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
  2845		case SO_ZEROCOPY_NOTIFICATION:
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
> 2878					if (unlikely(copy_to_user(*(void **)CMSG_DATA(cmsg),
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

