Return-Path: <netdev+bounces-137370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11CE9A59F0
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 07:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D47D28184B
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 05:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1642A194151;
	Mon, 21 Oct 2024 05:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RGX3DT5Z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947A61CF7A6
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 05:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729489969; cv=none; b=j1zKhV+e+oprlfJAUsX3G/4hwPec//tM8yFOQzZF9094eUagh6gU9HnKQR1gKWe9zwIR67TNMghEpfbop+14oRPKnFktw65KIX1OAuJ8ow3mDurmbLLnGQlZCPCCB2wGJdqt5Ir1qpsL9x5YsjxtoVRHTlyvcR8LUWX7b3uPYg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729489969; c=relaxed/simple;
	bh=ndSVzp5aVTjhu+Ocj6rffiQ/hO3qVsTOCe5Nx3K6jDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDD8LIHsVG8wBigs/mDPu68NDpnEk7CFZsP/q9mnMKfNIi8cDIsIHOatJfeLtpbX05RUadVsSl1CIN0pDQWbbKh98yM7SsCw19XomiZcwTkj7h1MjgkKx1K8T9lUWBe38+uc93GPjkTKucPOUhiS3PgdNVf1ciaCPFyLDiQ/C9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RGX3DT5Z; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729489966; x=1761025966;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ndSVzp5aVTjhu+Ocj6rffiQ/hO3qVsTOCe5Nx3K6jDE=;
  b=RGX3DT5Z2XtB/RH15XHz7eoL1qg82n1KH5Dm8tnH//QCQWxliFrHgy+z
   SMX/HBBHhNeFYy2cbM21UkThW8JeyBvMw0zSVuNxHfwkCddokLnv5fvyE
   fTWAbFkE2je7OLt0+LEevT1bmYd2M/zdx3rVU5m/qTZKaRse5Mg0TzeJV
   AKC1QC9Yz6ujLwV4Oru9663EWNzeF8L6y3fCmIUVaiaHkFJUVUOH6HrTW
   yMyvidihb1wOfvRH1GKt7Dsf9Xc32L24XvCCl9ETA9KbDPkzysss8DEtr
   b/La8ia72duQUCUPpSAyB6bNHa24FNAq4WJxNGTGvtUW7E+d/MyVM3k66
   Q==;
X-CSE-ConnectionGUID: RiMEFiqaTLWfgPer93pm0g==
X-CSE-MsgGUID: UUP7LCOXRPe1wnoyQEHWFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29072962"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29072962"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 22:52:45 -0700
X-CSE-ConnectionGUID: 7AhA8KBpQK+pWM9GFaK1qQ==
X-CSE-MsgGUID: GWdCtCabSLmX3GjC7o0/7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="116879169"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 20 Oct 2024 22:52:43 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2lLM-000RF5-1L;
	Mon, 21 Oct 2024 05:52:40 +0000
Date: Mon, 21 Oct 2024 13:52:06 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	dsahern@kernel.org, ncardwell@google.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next 2/2] tcp: add more warn of socket in
 tcp_send_loss_probe()
Message-ID: <202410211313.7YBoFLNS-lkp@intel.com>
References: <20241020145029.27725-3-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241020145029.27725-3-kerneljasonxing@gmail.com>

Hi Jason,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/tcp-add-a-common-helper-to-debug-the-underlying-issue/20241020-225356
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241020145029.27725-3-kerneljasonxing%40gmail.com
patch subject: [PATCH net-next 2/2] tcp: add more warn of socket in tcp_send_loss_probe()
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241021/202410211313.7YBoFLNS-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241021/202410211313.7YBoFLNS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410211313.7YBoFLNS-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/bug.h:99,
                    from include/linux/bug.h:5,
                    from include/linux/fortify-string.h:6,
                    from include/linux/string.h:390,
                    from include/linux/bitmap.h:13,
                    from include/linux/cpumask.h:12,
                    from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/tsc.h:10,
                    from arch/x86/include/asm/timex.h:6,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/skbuff.h:15,
                    from include/linux/tcp.h:17,
                    from include/net/tcp.h:20,
                    from net/ipv4/tcp_output.c:40:
   In function 'tcp_warn_once',
       inlined from 'tcp_warn_once' at include/net/tcp.h:2433:20,
       inlined from 'tcp_send_loss_probe' at net/ipv4/tcp_output.c:2957:3:
>> include/net/tcp.h:2436:19: warning: '%s' directive argument is null [-Wformat-overflow=]
    2436 |                   "%s"
         |                   ^~~~
   include/asm-generic/bug.h:106:31: note: in definition of macro '__WARN_printf'
     106 |                 __warn_printk(arg);                                     \
         |                               ^~~
   include/linux/once_lite.h:31:25: note: in expansion of macro 'WARN'
      31 |                         func(__VA_ARGS__);                              \
         |                         ^~~~
   include/asm-generic/bug.h:152:9: note: in expansion of macro 'DO_ONCE_LITE_IF'
     152 |         DO_ONCE_LITE_IF(condition, WARN, 1, format)
         |         ^~~~~~~~~~~~~~~
   include/net/tcp.h:2435:9: note: in expansion of macro 'WARN_ONCE'
    2435 |         WARN_ONCE(cond,
         |         ^~~~~~~~~
   include/net/tcp.h: In function 'tcp_send_loss_probe':
   include/net/tcp.h:2436:20: note: format string is defined here
    2436 |                   "%s"
         |                    ^~


vim +2436 include/net/tcp.h

1a91bb7c3ebf95 Mubashir Adnan Qureshi 2022-10-26  2432  
4fe1493c15028c Jason Xing             2024-10-20  2433  static inline void tcp_warn_once(const struct sock *sk, bool cond, const char *str)
4fe1493c15028c Jason Xing             2024-10-20  2434  {
4fe1493c15028c Jason Xing             2024-10-20  2435  	WARN_ONCE(cond,
4fe1493c15028c Jason Xing             2024-10-20 @2436  		  "%s"
d21098f05ea727 Jason Xing             2024-10-20  2437  		  "cwnd:%u "
4fe1493c15028c Jason Xing             2024-10-20  2438  		  "out:%u sacked:%u lost:%u retrans:%u "
4fe1493c15028c Jason Xing             2024-10-20  2439  		  "tlp_high_seq:%u sk_state:%u ca_state:%u "
d21098f05ea727 Jason Xing             2024-10-20  2440  		  "mss:%u advmss:%u mss_cache:%u pmtu:%u\n",
4fe1493c15028c Jason Xing             2024-10-20  2441  		  str,
d21098f05ea727 Jason Xing             2024-10-20  2442  		  tcp_snd_cwnd(tcp_sk(sk)),
4fe1493c15028c Jason Xing             2024-10-20  2443  		  tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
4fe1493c15028c Jason Xing             2024-10-20  2444  		  tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
4fe1493c15028c Jason Xing             2024-10-20  2445  		  tcp_sk(sk)->tlp_high_seq, sk->sk_state,
4fe1493c15028c Jason Xing             2024-10-20  2446  		  inet_csk(sk)->icsk_ca_state,
d21098f05ea727 Jason Xing             2024-10-20  2447  		  tcp_current_mss((struct sock *)sk),
4fe1493c15028c Jason Xing             2024-10-20  2448  		  tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
4fe1493c15028c Jason Xing             2024-10-20  2449  		  inet_csk(sk)->icsk_pmtu_cookie);
4fe1493c15028c Jason Xing             2024-10-20  2450  }
4fe1493c15028c Jason Xing             2024-10-20  2451  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

