Return-Path: <netdev+bounces-271483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A6BDgO3w2litgQAu9opvQ
	(envelope-from <netdev+bounces-271483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 11:20:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 248E3322CB4
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 11:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47C2E304021E
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A128D3AA4ED;
	Wed, 25 Mar 2026 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jhn0uOGz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EAD39A814
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433675; cv=none; b=Z3x8NnAsZTTdExhExvuMDAJiEhj0XyBlewMjyXBnqMwX5mFp9a+wXFEhjIhrgJPDFHkX5FVN9qIy15nDAQLfe8oc4CtbNWEWx8nDh3T9bVaGRCC6oTwqeBlVVLn7lWDTR2s46F5J8vTq0hmpqIGhzrpL5NgvgUjiCBKD7os2YsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433675; c=relaxed/simple;
	bh=1HQunXwctl1ifAye9q05SCcLeZKJxhkVVazF3cGdS/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvn1ZhRifG0UzR2/wNKuFzFLa3r7BeClL55DDgEsdNYUJvVFmNQFHsfSBiW1rgMaWAxsa1iOkZ6bt2G/asm36KFuHUk22A1DqOIZZUPSZQhzrHAEOR69AhS42Dze86E67eL5T2pZ4GQFOj399+Mibklhrgehfmyo9R6CtTb426Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jhn0uOGz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774433671; x=1805969671;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1HQunXwctl1ifAye9q05SCcLeZKJxhkVVazF3cGdS/A=;
  b=Jhn0uOGzUaHGjbL3dsPYvBFat5WPaP5GtG6JM3mk2HzWCqwtkx0uVuN8
   +gZCip4tye5Dal3FcNfibARo0K8K3X5AJA7rdIe6JqscA1Ekldw/sOgAG
   fqndgaf32R7UfWPKyyKwlI/FtF6JpAF1Y9x1dx+4Yw83E3TKX9ixMPX0p
   kz2baqdGEjYRZrIR1ae49GZpw6wooN/TzDeaVMQp/c9+goi5EtRhnwWc9
   kvcxomp59pkXQwnWr1ejlcgA+mrXo1Us17R9K0n/NXUcdOAVa8p9rJ+a5
   AI6By/NrdOO8zzzB5QNCahPyR1GPQl6EQD8hj/h2VL/sLa05rn2PiQiWj
   A==;
X-CSE-ConnectionGUID: uCkaTkXrTSafzVVbJFs3Eg==
X-CSE-MsgGUID: xHMCnF//TpaRLLnHRezvvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79062176"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="79062176"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 03:14:31 -0700
X-CSE-ConnectionGUID: FvRNbSgoTFKR59qMuZurBg==
X-CSE-MsgGUID: MkgIVVB9TSK+pj5/yK7LWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="224645513"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa008.jf.intel.com with ESMTP; 25 Mar 2026 03:14:30 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5LFr-0000000074P-2A6z;
	Wed, 25 Mar 2026 10:14:27 +0000
Date: Wed, 25 Mar 2026 11:14:09 +0100
From: kernel test robot <lkp@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	intel-wired-lan@lists.osuosl.org, Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next] devlink: unify
 devlink_shd_get_priv() into devlink_priv()
Message-ID: <202603251148.Sjx5pVxc-lkp@intel.com>
References: <20260323132136.13191-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323132136.13191-1-przemyslaw.kitszel@intel.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-271483-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: 248E3322CB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Przemek,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Przemek-Kitszel/devlink-unify-devlink_shd_get_priv-into-devlink_priv/20260325-130848
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260323132136.13191-1-przemyslaw.kitszel%40intel.com
patch subject: [Intel-wired-lan] [PATCH net-next] devlink: unify devlink_shd_get_priv() into devlink_priv()
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260325/202603251148.Sjx5pVxc-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260325/202603251148.Sjx5pVxc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603251148.Sjx5pVxc-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/devlink/sh_dev.c: In function 'devlink_to_shd':
>> net/devlink/sh_dev.c:36:16: error: returning 'char (*)[]' from a function with incompatible return type 'struct devlink_shd *' [-Wincompatible-pointer-types]
      36 |         return &devlink->priv;
         |                ^~~~~~~~~~~~~~


vim +36 net/devlink/sh_dev.c

    33	
    34	static struct devlink_shd *devlink_to_shd(struct devlink *devlink)
    35	{
  > 36		return &devlink->priv;
    37	}
    38	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

