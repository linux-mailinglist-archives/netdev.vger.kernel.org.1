Return-Path: <netdev+bounces-95674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 250508C2FA9
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 07:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9C11F228AF
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 05:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEF847773;
	Sat, 11 May 2024 05:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oKBDJB/Y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E86802
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 05:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715405452; cv=none; b=doh5wqr2AjLnn0k22RD7m3rhOTVvY/v0aSfvQAQo3wP08rvSn8aCitxcqOjkToYADwS2/GrEuh/Nyo92SEY2WB98VtLIgTDNRDrupBZQxzymCD31ybPcr76RCIonr9v+7nKiYUzhswlsbkrLswivabpNwlf2ztNM/+rvVEYIFJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715405452; c=relaxed/simple;
	bh=t1Wa/ORkxoiZFScZXqDJExHy2HHmHBy9lkNVpy/H5Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMUidINOBCrl/VIHhWUUramPJ6alDAPwrFNpOGOS0nrCzIzrPum9QFPYz0zhi6Axhrc8W2o4jh0ug2yr3cAuRNuJsKFyChpPZhHo+3eGwvY0S+Ml2FF49LG6EWCvMcBthFoAyFRtOGQwV0vKj/YJriXmyG/c8SxwcE2B0UQB5PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oKBDJB/Y; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715405451; x=1746941451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t1Wa/ORkxoiZFScZXqDJExHy2HHmHBy9lkNVpy/H5Ww=;
  b=oKBDJB/YdfhXWT/KscXxbLDWf238WzxPIYaEaa5JELu7EYudB1VzyiSu
   OatyMB6n6VHtz7XRcc+rxw//qoitRMT8Kr/EjG+Gu3bS+SYH6yvMUkLxW
   xaGyVVbPFNgC9pbO5CSeJSYUB1KxJk6SLYhT7IrpABL70SPnj9ZYQUPl4
   6JOb3MQn7NSJK9SeBlx27CPnbE04N48HvEpWT2+Z/05XMVrBRZuNxUP4U
   YrV/7eS7plzUemifJpKFS/qoixmiroUlOntp4KWSaHZXnj2WsD5VwduB0
   hei38tSK3Qva67jbMi6y4RfA8HkwTjhwU0e4ckFdSu/KPFvsF5NQt/21W
   A==;
X-CSE-ConnectionGUID: hPPWVLrMTi+orzq2cDI+5w==
X-CSE-MsgGUID: 9wv6VSLsTNazo2xuzFY/yQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="11627136"
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="11627136"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 22:30:50 -0700
X-CSE-ConnectionGUID: 5yvWyHkNQpKQAzQfqBEikg==
X-CSE-MsgGUID: EU96LY/FQEudV2nEqAcr+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="34347204"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 10 May 2024 22:30:48 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5fJl-0006yd-29;
	Sat, 11 May 2024 05:30:45 +0000
Date: Sat, 11 May 2024 13:30:00 +0800
From: kernel test robot <lkp@intel.com>
To: zijianzhang@bytedance.com, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	edumazet@google.com, willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com, xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: Re: [PATCH net-next v3 2/3] sock: add MSG_ZEROCOPY notification
 mechanism based on msg_control
Message-ID: <202405111306.MOClscNA-lkp@intel.com>
References: <20240510155900.1825946-3-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510155900.1825946-3-zijianzhang@bytedance.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/zijianzhang-bytedance-com/selftests-fix-OOM-problem-in-msg_zerocopy-selftest/20240511-000153
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240510155900.1825946-3-zijianzhang%40bytedance.com
patch subject: [PATCH net-next v3 2/3] sock: add MSG_ZEROCOPY notification mechanism based on msg_control
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240511/202405111306.MOClscNA-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240511/202405111306.MOClscNA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405111306.MOClscNA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/core/sock.c:2808:5: warning: stack frame size (1608) exceeds limit (1024) in '__sock_cmsg_send' [-Wframe-larger-than]
   int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
       ^
   1 warning generated.


vim +/__sock_cmsg_send +2808 net/core/sock.c

^1da177e4c3f41 Linus Torvalds        2005-04-16  2807  
233baf9a1bc46f xu xin                2022-10-20 @2808  int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
f28ea365cdefc3 Edward Jee            2015-10-08  2809  		     struct sockcm_cookie *sockc)
f28ea365cdefc3 Edward Jee            2015-10-08  2810  {
3dd17e63f5131b Soheil Hassas Yeganeh 2016-04-02  2811  	u32 tsflags;
3dd17e63f5131b Soheil Hassas Yeganeh 2016-04-02  2812  
f28ea365cdefc3 Edward Jee            2015-10-08  2813  	switch (cmsg->cmsg_type) {
f28ea365cdefc3 Edward Jee            2015-10-08  2814  	case SO_MARK:
91f0d8a4813a9a Jakub Kicinski        2022-01-31  2815  		if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
91f0d8a4813a9a Jakub Kicinski        2022-01-31  2816  		    !ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
f28ea365cdefc3 Edward Jee            2015-10-08  2817  			return -EPERM;
f28ea365cdefc3 Edward Jee            2015-10-08  2818  		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
f28ea365cdefc3 Edward Jee            2015-10-08  2819  			return -EINVAL;
f28ea365cdefc3 Edward Jee            2015-10-08  2820  		sockc->mark = *(u32 *)CMSG_DATA(cmsg);
f28ea365cdefc3 Edward Jee            2015-10-08  2821  		break;
7f1bc6e95d7840 Deepa Dinamani        2019-02-02  2822  	case SO_TIMESTAMPING_OLD:
382a32018b74f4 Thomas Lange          2024-01-04  2823  	case SO_TIMESTAMPING_NEW:
3dd17e63f5131b Soheil Hassas Yeganeh 2016-04-02  2824  		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
3dd17e63f5131b Soheil Hassas Yeganeh 2016-04-02  2825  			return -EINVAL;
3dd17e63f5131b Soheil Hassas Yeganeh 2016-04-02  2826  
3dd17e63f5131b Soheil Hassas Yeganeh 2016-04-02  2827  		tsflags = *(u32 *)CMSG_DATA(cmsg);
3dd17e63f5131b Soheil Hassas Yeganeh 2016-04-02  2828  		if (tsflags & ~SOF_TIMESTAMPING_TX_RECORD_MASK)
3dd17e63f5131b Soheil Hassas Yeganeh 2016-04-02  2829  			return -EINVAL;
3dd17e63f5131b Soheil Hassas Yeganeh 2016-04-02  2830  
3dd17e63f5131b Soheil Hassas Yeganeh 2016-04-02  2831  		sockc->tsflags &= ~SOF_TIMESTAMPING_TX_RECORD_MASK;
3dd17e63f5131b Soheil Hassas Yeganeh 2016-04-02  2832  		sockc->tsflags |= tsflags;
3dd17e63f5131b Soheil Hassas Yeganeh 2016-04-02  2833  		break;
80b14dee2bea12 Richard Cochran       2018-07-03  2834  	case SCM_TXTIME:
80b14dee2bea12 Richard Cochran       2018-07-03  2835  		if (!sock_flag(sk, SOCK_TXTIME))
80b14dee2bea12 Richard Cochran       2018-07-03  2836  			return -EINVAL;
80b14dee2bea12 Richard Cochran       2018-07-03  2837  		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u64)))
80b14dee2bea12 Richard Cochran       2018-07-03  2838  			return -EINVAL;
80b14dee2bea12 Richard Cochran       2018-07-03  2839  		sockc->transmit_time = get_unaligned((u64 *)CMSG_DATA(cmsg));
80b14dee2bea12 Richard Cochran       2018-07-03  2840  		break;
779f1edec664a7 Soheil Hassas Yeganeh 2016-07-11  2841  	/* SCM_RIGHTS and SCM_CREDENTIALS are semantically in SOL_UNIX. */
779f1edec664a7 Soheil Hassas Yeganeh 2016-07-11  2842  	case SCM_RIGHTS:
779f1edec664a7 Soheil Hassas Yeganeh 2016-07-11  2843  	case SCM_CREDENTIALS:
779f1edec664a7 Soheil Hassas Yeganeh 2016-07-11  2844  		break;
274b6fd4a3053e Zijian Zhang          2024-05-10  2845  	case SCM_ZC_NOTIFICATION: {
274b6fd4a3053e Zijian Zhang          2024-05-10  2846  		int ret, i = 0;
274b6fd4a3053e Zijian Zhang          2024-05-10  2847  		int cmsg_data_len, zc_info_elem_num;
274b6fd4a3053e Zijian Zhang          2024-05-10  2848  		void __user	*usr_addr;
274b6fd4a3053e Zijian Zhang          2024-05-10  2849  		struct zc_info_elem zc_info_kern[SOCK_ZC_INFO_MAX];
274b6fd4a3053e Zijian Zhang          2024-05-10  2850  		unsigned long flags;
274b6fd4a3053e Zijian Zhang          2024-05-10  2851  		struct sk_buff_head *q, local_q;
274b6fd4a3053e Zijian Zhang          2024-05-10  2852  		struct sk_buff *skb, *tmp;
274b6fd4a3053e Zijian Zhang          2024-05-10  2853  		struct sock_exterr_skb *serr;
274b6fd4a3053e Zijian Zhang          2024-05-10  2854  
274b6fd4a3053e Zijian Zhang          2024-05-10  2855  		if (!sock_flag(sk, SOCK_ZEROCOPY) || sk->sk_family == PF_RDS)
274b6fd4a3053e Zijian Zhang          2024-05-10  2856  			return -EINVAL;
274b6fd4a3053e Zijian Zhang          2024-05-10  2857  
274b6fd4a3053e Zijian Zhang          2024-05-10  2858  		cmsg_data_len = cmsg->cmsg_len - sizeof(struct cmsghdr);
274b6fd4a3053e Zijian Zhang          2024-05-10  2859  		if (cmsg_data_len % sizeof(struct zc_info_elem))
274b6fd4a3053e Zijian Zhang          2024-05-10  2860  			return -EINVAL;
274b6fd4a3053e Zijian Zhang          2024-05-10  2861  
274b6fd4a3053e Zijian Zhang          2024-05-10  2862  		zc_info_elem_num = cmsg_data_len / sizeof(struct zc_info_elem);
274b6fd4a3053e Zijian Zhang          2024-05-10  2863  		if (!zc_info_elem_num || zc_info_elem_num > SOCK_ZC_INFO_MAX)
274b6fd4a3053e Zijian Zhang          2024-05-10  2864  			return -EINVAL;
274b6fd4a3053e Zijian Zhang          2024-05-10  2865  
274b6fd4a3053e Zijian Zhang          2024-05-10  2866  		if (in_compat_syscall())
274b6fd4a3053e Zijian Zhang          2024-05-10  2867  			usr_addr = compat_ptr(*(compat_uptr_t *)CMSG_DATA(cmsg));
274b6fd4a3053e Zijian Zhang          2024-05-10  2868  		else
274b6fd4a3053e Zijian Zhang          2024-05-10  2869  			usr_addr = (void __user *)*(void **)CMSG_DATA(cmsg);
274b6fd4a3053e Zijian Zhang          2024-05-10  2870  		if (!access_ok(usr_addr, cmsg_data_len))
274b6fd4a3053e Zijian Zhang          2024-05-10  2871  			return -EFAULT;
274b6fd4a3053e Zijian Zhang          2024-05-10  2872  
274b6fd4a3053e Zijian Zhang          2024-05-10  2873  		q = &sk->sk_error_queue;
274b6fd4a3053e Zijian Zhang          2024-05-10  2874  		skb_queue_head_init(&local_q);
274b6fd4a3053e Zijian Zhang          2024-05-10  2875  		spin_lock_irqsave(&q->lock, flags);
274b6fd4a3053e Zijian Zhang          2024-05-10  2876  		skb = skb_peek(q);
274b6fd4a3053e Zijian Zhang          2024-05-10  2877  		while (skb && i < zc_info_elem_num) {
274b6fd4a3053e Zijian Zhang          2024-05-10  2878  			struct sk_buff *skb_next = skb_peek_next(skb, q);
274b6fd4a3053e Zijian Zhang          2024-05-10  2879  
274b6fd4a3053e Zijian Zhang          2024-05-10  2880  			serr = SKB_EXT_ERR(skb);
274b6fd4a3053e Zijian Zhang          2024-05-10  2881  			if (serr->ee.ee_errno == 0 &&
274b6fd4a3053e Zijian Zhang          2024-05-10  2882  			    serr->ee.ee_origin == SO_EE_ORIGIN_ZEROCOPY) {
274b6fd4a3053e Zijian Zhang          2024-05-10  2883  				zc_info_kern[i].hi = serr->ee.ee_data;
274b6fd4a3053e Zijian Zhang          2024-05-10  2884  				zc_info_kern[i].lo = serr->ee.ee_info;
274b6fd4a3053e Zijian Zhang          2024-05-10  2885  				zc_info_kern[i].zerocopy = !(serr->ee.ee_code
274b6fd4a3053e Zijian Zhang          2024-05-10  2886  								& SO_EE_CODE_ZEROCOPY_COPIED);
274b6fd4a3053e Zijian Zhang          2024-05-10  2887  				__skb_unlink(skb, q);
274b6fd4a3053e Zijian Zhang          2024-05-10  2888  				__skb_queue_tail(&local_q, skb);
274b6fd4a3053e Zijian Zhang          2024-05-10  2889  				i++;
274b6fd4a3053e Zijian Zhang          2024-05-10  2890  			}
274b6fd4a3053e Zijian Zhang          2024-05-10  2891  			skb = skb_next;
274b6fd4a3053e Zijian Zhang          2024-05-10  2892  		}
274b6fd4a3053e Zijian Zhang          2024-05-10  2893  		spin_unlock_irqrestore(&q->lock, flags);
274b6fd4a3053e Zijian Zhang          2024-05-10  2894  
274b6fd4a3053e Zijian Zhang          2024-05-10  2895  		ret = copy_to_user(usr_addr,
274b6fd4a3053e Zijian Zhang          2024-05-10  2896  				   zc_info_kern,
274b6fd4a3053e Zijian Zhang          2024-05-10  2897  					i * sizeof(struct zc_info_elem));
274b6fd4a3053e Zijian Zhang          2024-05-10  2898  
274b6fd4a3053e Zijian Zhang          2024-05-10  2899  		if (unlikely(ret)) {
274b6fd4a3053e Zijian Zhang          2024-05-10  2900  			spin_lock_irqsave(&q->lock, flags);
274b6fd4a3053e Zijian Zhang          2024-05-10  2901  			skb_queue_reverse_walk_safe(&local_q, skb, tmp) {
274b6fd4a3053e Zijian Zhang          2024-05-10  2902  				__skb_unlink(skb, &local_q);
274b6fd4a3053e Zijian Zhang          2024-05-10  2903  				__skb_queue_head(q, skb);
274b6fd4a3053e Zijian Zhang          2024-05-10  2904  			}
274b6fd4a3053e Zijian Zhang          2024-05-10  2905  			spin_unlock_irqrestore(&q->lock, flags);
274b6fd4a3053e Zijian Zhang          2024-05-10  2906  			return -EFAULT;
274b6fd4a3053e Zijian Zhang          2024-05-10  2907  		}
274b6fd4a3053e Zijian Zhang          2024-05-10  2908  
274b6fd4a3053e Zijian Zhang          2024-05-10  2909  		while ((skb = __skb_dequeue(&local_q)))
274b6fd4a3053e Zijian Zhang          2024-05-10  2910  			consume_skb(skb);
274b6fd4a3053e Zijian Zhang          2024-05-10  2911  		break;
274b6fd4a3053e Zijian Zhang          2024-05-10  2912  	}
f28ea365cdefc3 Edward Jee            2015-10-08  2913  	default:
f28ea365cdefc3 Edward Jee            2015-10-08  2914  		return -EINVAL;
f28ea365cdefc3 Edward Jee            2015-10-08  2915  	}
39771b127b4123 Willem de Bruijn      2016-04-02  2916  	return 0;
39771b127b4123 Willem de Bruijn      2016-04-02  2917  }
39771b127b4123 Willem de Bruijn      2016-04-02  2918  EXPORT_SYMBOL(__sock_cmsg_send);
39771b127b4123 Willem de Bruijn      2016-04-02  2919  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

