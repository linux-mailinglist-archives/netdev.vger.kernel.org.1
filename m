Return-Path: <netdev+bounces-213164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B207B23E4B
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 04:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8101E1AA7BC3
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 02:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316C11E47A5;
	Wed, 13 Aug 2025 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DPOtYuaL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629CA139D0A;
	Wed, 13 Aug 2025 02:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755052645; cv=none; b=h/LwthEkpGURlKZKoYBkvitx54DJYcRwCEccYpX9I0H9cC8LQKh4NbFUWutRsrfUJsTkzk2MVOMGmY8ABWhSC24nLmasBbWYp86NdN4kzVhGimHK7Nd/zGCzFDHfE6AbbZZdPPT1dT9aifrCMHJOgwu+XolqAq6lRGS2kw9U7JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755052645; c=relaxed/simple;
	bh=mZe7gpS/9sl+TjlQKK4plRQeU8GkfylF8j0ySV/dbV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nr900UwYUEILABY5Dv0nsGumsSLvdVjocMXpC2swtmIzjiT3rLi/44Ro+HeLAA2tmI/+WOUoc0JWl39gZindoF1b8ZNLNpC9CtVhohYEyHNwYAW549XgZ2tAKez3zZHPB0+wfpHLtSGbxE+k6J3WEOMsewF+948H0mZTry7Kkv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DPOtYuaL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755052643; x=1786588643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mZe7gpS/9sl+TjlQKK4plRQeU8GkfylF8j0ySV/dbV4=;
  b=DPOtYuaL2HdmZs1OiJOM9/UT9HtrJzXyL3vHZRTrwKiMdB8NoCyy6H0Q
   x9KE5u7teq6wD36zHgV9ePuWVc/PXV6sL9sNNcCcmm75iRZsKvPhiyPiP
   bF+rhzUFboVL6FjMBAb9tj9AzlrCqB+CREi/NU5dcne496xte+qV0tFOr
   CVuDMo7vnPBI06eyXnjqKyjtC4/nskuEdsrylD7qKhwM5LsQ1hScavntF
   PtlwZ/A+sSkf+p6n6/1NG9S3FrIAg2WNr5Aay/l0OlKEqv7hqrVqXgE4h
   o7WK/TBcmgq0lBmdRXlQS6lCvwTzAHeg9v9SU+2vdhtFLqOOgd8gULGAX
   A==;
X-CSE-ConnectionGUID: nlFEKjqIQQW4UUKRoyDFVA==
X-CSE-MsgGUID: CfTU10uzRqiRRdW6uk2kHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="82770119"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="82770119"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 19:37:22 -0700
X-CSE-ConnectionGUID: SSYInxC6R0ipR4eBMymsYg==
X-CSE-MsgGUID: iOthpAQBQnmB7/U7wdUA3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="171684930"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 12 Aug 2025 19:37:16 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1um1ME-0009TY-2a;
	Wed, 13 Aug 2025 02:37:06 +0000
Date: Wed, 13 Aug 2025 10:35:26 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Fang <wei.fang@nxp.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, richardcochran@gmail.com,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	vadim.fedorenko@linux.dev, Frank.Li@nxp.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, fushi.peng@nxp.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: Re: [PATCH v3 net-next 06/15] ptp: netc: add periodic pulse output
 support
Message-ID: <202508131027.y3pyBEJQ-lkp@intel.com>
References: <20250812094634.489901-7-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812094634.489901-7-wei.fang@nxp.com>

Hi Wei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Fang/dt-bindings-ptp-add-NETC-Timer-PTP-clock/20250812-181510
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250812094634.489901-7-wei.fang%40nxp.com
patch subject: [PATCH v3 net-next 06/15] ptp: netc: add periodic pulse output support
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20250813/202508131027.y3pyBEJQ-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 3769ce013be2879bf0b329c14a16f5cb766f26ce)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250813/202508131027.y3pyBEJQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508131027.y3pyBEJQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/ptp/ptp_netc.c:394:33: warning: variable 'pp' is uninitialized when used here [-Wuninitialized]
     394 |                 priv->fs_alarm_bitmap &= ~BIT(pp->alarm_id);
         |                                               ^~
   drivers/ptp/ptp_netc.c:348:20: note: initialize the variable 'pp' to silence this warning
     348 |         struct netc_pp *pp;
         |                           ^
         |                            = NULL
   1 warning generated.


vim +/pp +394 drivers/ptp/ptp_netc.c

   337	
   338	/* Note that users should not use this API to output PPS signal on
   339	 * external pins, because PTP_CLK_REQ_PPS trigger internal PPS event
   340	 * for input into kernel PPS subsystem. See:
   341	 * https://lore.kernel.org/r/20201117213826.18235-1-a.fatoum@pengutronix.de
   342	 */
   343	static int netc_timer_enable_pps(struct netc_timer *priv,
   344					 struct ptp_clock_request *rq, int on)
   345	{
   346		struct device *dev = &priv->pdev->dev;
   347		unsigned long flags;
   348		struct netc_pp *pp;
   349		int err = 0;
   350	
   351		spin_lock_irqsave(&priv->lock, flags);
   352	
   353		if (on) {
   354			int alarm_id;
   355			u8 channel;
   356	
   357			if (priv->pps_channel < NETC_TMR_FIPER_NUM) {
   358				channel = priv->pps_channel;
   359			} else {
   360				channel = netc_timer_select_pps_channel(priv);
   361				if (channel == NETC_TMR_INVALID_CHANNEL) {
   362					dev_err(dev, "No available FIPERs\n");
   363					err = -EBUSY;
   364					goto unlock_spinlock;
   365				}
   366			}
   367	
   368			pp = &priv->pp[channel];
   369			if (pp->enabled)
   370				goto unlock_spinlock;
   371	
   372			alarm_id = netc_timer_get_alarm_id(priv);
   373			if (alarm_id == priv->fs_alarm_num) {
   374				dev_err(dev, "No available ALARMs\n");
   375				err = -EBUSY;
   376				goto unlock_spinlock;
   377			}
   378	
   379			pp->enabled = true;
   380			pp->type = NETC_PP_PPS;
   381			pp->alarm_id = alarm_id;
   382			pp->period = NSEC_PER_SEC;
   383			priv->pps_channel = channel;
   384	
   385			netc_timer_enable_periodic_pulse(priv, channel);
   386		} else {
   387			/* pps_channel is invalid if PPS is not enabled, so no
   388			 * processing is needed.
   389			 */
   390			if (priv->pps_channel >= NETC_TMR_FIPER_NUM)
   391				goto unlock_spinlock;
   392	
   393			netc_timer_disable_periodic_pulse(priv, priv->pps_channel);
 > 394			priv->fs_alarm_bitmap &= ~BIT(pp->alarm_id);
   395			pp = &priv->pp[priv->pps_channel];
   396			memset(pp, 0, sizeof(*pp));
   397			priv->pps_channel = NETC_TMR_INVALID_CHANNEL;
   398		}
   399	
   400	unlock_spinlock:
   401		spin_unlock_irqrestore(&priv->lock, flags);
   402	
   403		return err;
   404	}
   405	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

