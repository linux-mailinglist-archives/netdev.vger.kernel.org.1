Return-Path: <netdev+bounces-154767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4E09FFB6B
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBFF3A0838
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 16:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC15DDC1;
	Thu,  2 Jan 2025 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VcvNqtHT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D257DEEB3
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735834616; cv=none; b=gFdRwzrGnqtzy/V9eo7GFpV5nso/3LLaE4eIgALqTLqwxhebRlfG3/lhbDwdXPONupv9AxKywlp4M741T5pPHO9EeWjXEs85DLQqC8p66ZD0yl7wyX99k3bkB+o2wRJ1RlBb7r/1AkC00cs1E6w6GlbZxU9CsW1zlzJ17i4Rglk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735834616; c=relaxed/simple;
	bh=MRVSix7MEuvTGNdsAmN9Ay8zQR/fCYDefQbTWsHFavA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utGf/nzvAIrylcDqqPUxAKYVMtvC9AYWVJGho6+IZuEU2PRlAJgLGHydFRSmOgTdaahFWqxznFFdeIeWwjFdmz/4wT64ToEiszvCZzpm4Hjo4a2sHBCyKecRdWqb+HHD4LlHTdlny+3xZK2tD+6e8QtUqR49F03I2+IyXgeOaNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VcvNqtHT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735834615; x=1767370615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MRVSix7MEuvTGNdsAmN9Ay8zQR/fCYDefQbTWsHFavA=;
  b=VcvNqtHT2i3ZwNqB/hwANKDgwY7fc5Ye8cq04Idp0exdonKbL3f/jM/B
   rWkxeL5UdVhpDjj4mjxDp4sGkBqD6XWrVKHZ4268b7aJi83zVpom5DuC/
   swQU2MU4OUyJlcjalZ1SGwCZp6b3viA8n4GQ8SUT785BiSJ8cyNA75nfV
   GiZP9l0mvZbJmluD6OhoJKP3tTiStOIj5y0A5MRPjqV0z6ZIqG0q80GuE
   X2H1aHIMjpCHujZbWCIEBGRNFymzPt9WFpnL0cBUmN/wVk48C1mMZNYpx
   VGz4uPWLhklNCSU+zYnlOFWyqCH3lCjqS7NbrKWm52rZqtyDxt1RkBvVL
   w==;
X-CSE-ConnectionGUID: tVEDauIyRA6lTUNxUY0g/g==
X-CSE-MsgGUID: l1gsA7oDQKi3FjVRW4tOaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="39757989"
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="39757989"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 08:16:54 -0800
X-CSE-ConnectionGUID: faAVO2VrRnedw4eBxhOMuw==
X-CSE-MsgGUID: yklNlrysQPCxrKWA4b3jAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="106597283"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 02 Jan 2025 08:16:51 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tTNsO-0008db-1X;
	Thu, 02 Jan 2025 16:16:48 +0000
Date: Fri, 3 Jan 2025 00:16:06 +0800
From: kernel test robot <lkp@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, linux@armlinux.org.uk,
	horms@kernel.org, jacob.e.keller@intel.com, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	mengyuanlou@net-swift.com, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH net-next 1/4] net: wangxun: Add support for PTP clock
Message-ID: <202501022323.HDFZ6FVp-lkp@intel.com>
References: <20250102103026.1982137-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102103026.1982137-2-jiawenwu@trustnetic.com>

Hi Jiawen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiawen-Wu/net-wangxun-Add-support-for-PTP-clock/20250102-181338
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250102103026.1982137-2-jiawenwu%40trustnetic.com
patch subject: [PATCH net-next 1/4] net: wangxun: Add support for PTP clock
config: x86_64-buildonly-randconfig-004-20250102 (https://download.01.org/0day-ci/archive/20250102/202501022323.HDFZ6FVp-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250102/202501022323.HDFZ6FVp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501022323.HDFZ6FVp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/wangxun/libwx/wx_ptp.c:4:
   In file included from include/linux/ptp_classify.h:14:
   In file included from include/linux/ip.h:16:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/net/ethernet/wangxun/libwx/wx_ptp.c:358:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
     358 |         case HWTSTAMP_TX_ON:
         |         ^
   drivers/net/ethernet/wangxun/libwx/wx_ptp.c:358:2: note: insert 'break;' to avoid fall-through
     358 |         case HWTSTAMP_TX_ON:
         |         ^
         |         break; 
   2 warnings generated.


vim +358 drivers/net/ethernet/wangxun/libwx/wx_ptp.c

   315	
   316	/**
   317	 * wx_ptp_set_timestamp_mode - setup the hardware for the requested mode
   318	 * @wx: the private board structure
   319	 * @config: the hwtstamp configuration requested
   320	 *
   321	 * Returns 0 on success, negative on failure
   322	 *
   323	 * Outgoing time stamping can be enabled and disabled. Play nice and
   324	 * disable it when requested, although it shouldn't cause any overhead
   325	 * when no packet needs it. At most one packet in the queue may be
   326	 * marked for time stamping, otherwise it would be impossible to tell
   327	 * for sure to which packet the hardware time stamp belongs.
   328	 *
   329	 * Incoming time stamping has to be configured via the hardware
   330	 * filters. Not all combinations are supported, in particular event
   331	 * type has to be specified. Matching the kind of event packet is
   332	 * not supported, with the exception of "all V2 events regardless of
   333	 * level 2 or 4".
   334	 *
   335	 * Since hardware always timestamps Path delay packets when timestamping V2
   336	 * packets, regardless of the type specified in the register, only use V2
   337	 * Event mode. This more accurately tells the user what the hardware is going
   338	 * to do anyways.
   339	 *
   340	 * Note: this may modify the hwtstamp configuration towards a more general
   341	 * mode, if required to support the specifically requested mode.
   342	 */
   343	static int wx_ptp_set_timestamp_mode(struct wx *wx,
   344					     struct hwtstamp_config *config)
   345	{
   346		u32 tsync_tx_ctl = WX_TSC_1588_CTL_ENABLED;
   347		u32 tsync_rx_ctl = WX_PSR_1588_CTL_ENABLED;
   348		DECLARE_BITMAP(flags, WX_PF_FLAGS_NBITS);
   349		u32 tsync_rx_mtrl = PTP_EV_PORT << 16;
   350		bool is_l2 = false;
   351		u32 regval;
   352	
   353		memcpy(flags, wx->flags, sizeof(wx->flags));
   354	
   355		switch (config->tx_type) {
   356		case HWTSTAMP_TX_OFF:
   357			tsync_tx_ctl = 0;
 > 358		case HWTSTAMP_TX_ON:
   359			break;
   360		default:
   361			return -ERANGE;
   362		}
   363	
   364		switch (config->rx_filter) {
   365		case HWTSTAMP_FILTER_NONE:
   366			tsync_rx_ctl = 0;
   367			tsync_rx_mtrl = 0;
   368			clear_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
   369			clear_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
   370			break;
   371		case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
   372			tsync_rx_ctl |= WX_PSR_1588_CTL_TYPE_L4_V1;
   373			tsync_rx_mtrl |= WX_PSR_1588_MSG_V1_SYNC;
   374			set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
   375			set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
   376			break;
   377		case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
   378			tsync_rx_ctl |= WX_PSR_1588_CTL_TYPE_L4_V1;
   379			tsync_rx_mtrl |= WX_PSR_1588_MSG_V1_DELAY_REQ;
   380			set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
   381			set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
   382			break;
   383		case HWTSTAMP_FILTER_PTP_V2_EVENT:
   384		case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
   385		case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
   386		case HWTSTAMP_FILTER_PTP_V2_SYNC:
   387		case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
   388		case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
   389		case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
   390		case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
   391		case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
   392			tsync_rx_ctl |= WX_PSR_1588_CTL_TYPE_EVENT_V2;
   393			is_l2 = true;
   394			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
   395			set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
   396			set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
   397			break;
   398		default:
   399			/* register RXMTRL must be set in order to do V1 packets,
   400			 * therefore it is not possible to time stamp both V1 Sync and
   401			 * Delay_Req messages unless hardware supports timestamping all
   402			 * packets => return error
   403			 */
   404			clear_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, wx->flags);
   405			clear_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, wx->flags);
   406			config->rx_filter = HWTSTAMP_FILTER_NONE;
   407			return -ERANGE;
   408		}
   409	
   410		/* define ethertype filter for timestamping L2 packets */
   411		if (is_l2)
   412			wr32(wx, WX_PSR_ETYPE_SWC(WX_PSR_ETYPE_SWC_FILTER_1588),
   413			     (WX_PSR_ETYPE_SWC_FILTER_EN | /* enable filter */
   414			      WX_PSR_ETYPE_SWC_1588 | /* enable timestamping */
   415			      ETH_P_1588)); /* 1588 eth protocol type */
   416		else
   417			wr32(wx, WX_PSR_ETYPE_SWC(WX_PSR_ETYPE_SWC_FILTER_1588), 0);
   418	
   419		/* enable/disable TX */
   420		regval = rd32ptp(wx, WX_TSC_1588_CTL);
   421		regval &= ~WX_TSC_1588_CTL_ENABLED;
   422		regval |= tsync_tx_ctl;
   423		wr32ptp(wx, WX_TSC_1588_CTL, regval);
   424	
   425		/* enable/disable RX */
   426		regval = rd32(wx, WX_PSR_1588_CTL);
   427		regval &= ~(WX_PSR_1588_CTL_ENABLED | WX_PSR_1588_CTL_TYPE_MASK);
   428		regval |= tsync_rx_ctl;
   429		wr32(wx, WX_PSR_1588_CTL, regval);
   430	
   431		/* define which PTP packets are time stamped */
   432		wr32(wx, WX_PSR_1588_MSG, tsync_rx_mtrl);
   433	
   434		WX_WRITE_FLUSH(wx);
   435	
   436		/* configure adapter flags only when HW is actually configured */
   437		memcpy(wx->flags, flags, sizeof(wx->flags));
   438	
   439		/* clear TX/RX timestamp state, just to be sure */
   440		wx_ptp_clear_tx_timestamp(wx);
   441		rd32(wx, WX_PSR_1588_STMPH);
   442	
   443		return 0;
   444	}
   445	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

