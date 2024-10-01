Return-Path: <netdev+bounces-130841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744D398BBBC
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35A51C23729
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342A0188CAD;
	Tue,  1 Oct 2024 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PBSjfFJ+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F1C186607
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727784061; cv=none; b=uPEjx8USFIEX8gowlbIt/RrOmORULkmpNhsn478ZxeT697fzT63PGJnHSrAy7uBfX6PPNW6uEVLAFgFOtAxvy9KljbT6Y65apkvYoZcz7ut/6UVoYuiO7gwSREn4q6G90+2lHvW6lDtrWGuNKXLqyuf38sKTZ+DaeTBd2m5Usyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727784061; c=relaxed/simple;
	bh=IKIVvq/Cyglp1jeBg3AyVeHo+lhJ14utN7qA3vCuOT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdtDMUxhjmWifxnTzrjixZGbtZcvkQLqyxzfzadHlTLF/m7jUW+Rctb5j9vDEu8u2mrKEcYbAio7CYnDywvof0hOu+bIEtxFdr/raFB2p0WlIew4DAfZGIp9QjscPo+EVFLMP3iOyfjVPAKtV2b5IzsKdaCRWFjgyf/IYNtkNF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PBSjfFJ+; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727784059; x=1759320059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IKIVvq/Cyglp1jeBg3AyVeHo+lhJ14utN7qA3vCuOT8=;
  b=PBSjfFJ+hr46Ccmi2BP5RSjw4xYoLjcVIzgUNtpYpmAijRYz27BeZPiM
   gDaNCALaTaq72u4MEne6RynYzxBwVsgTmLhZwmDd0To92YjOoLm65Ra+O
   zvWvr+Wc2/0YRsSksrG2Or16Hnapu1nJIsJDG2FUZ+koJMEbkObt1tKCC
   tfiXPMMjXy+4P4cvZ7S1fW2oFgJPsHbqhO6iYSvr87Ew74zi3brMZCmq9
   D+LG4jOAJTUEENzS3o9BnHRnQnuCFU2OJVGnwcCT0guAtmTySeY5wY5L6
   yIMiduRhhtPOAwqPpt4aHf3i0W20MRowW68vb6QuKRLUWxYomRprHQGAm
   Q==;
X-CSE-ConnectionGUID: E3qt+yc9RmyhQikj8UNEGQ==
X-CSE-MsgGUID: NjtRysGZRxauuQIXkr0aaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="26374345"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="26374345"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 05:00:58 -0700
X-CSE-ConnectionGUID: oC5VCxHaRpKA7s4lLsktzg==
X-CSE-MsgGUID: B5vfAF7GQJO3zdAjkY+8OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="73961734"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 01 Oct 2024 05:00:14 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svbY3-000QeH-1c;
	Tue, 01 Oct 2024 12:00:11 +0000
Date: Tue, 1 Oct 2024 20:00:09 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v1 net-next 1/3] rtnetlink: Add per-net RTNL.
Message-ID: <202410011928.ux2dA2GV-lkp@intel.com>
References: <20240930202524.59357-2-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930202524.59357-2-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/rtnetlink-Add-per-net-RTNL/20241001-043219
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240930202524.59357-2-kuniyu%40amazon.com
patch subject: [PATCH v1 net-next 1/3] rtnetlink: Add per-net RTNL.
config: x86_64-kismet-CONFIG_PROVE_LOCKING-CONFIG_DEBUG_NET_SMALL_RTNL-0-0 (https://download.01.org/0day-ci/archive/20241001/202410011928.ux2dA2GV-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20241001/202410011928.ux2dA2GV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410011928.ux2dA2GV-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for PROVE_LOCKING when selected by DEBUG_NET_SMALL_RTNL
   WARNING: unmet direct dependencies detected for PROVE_LOCKING
     Depends on [n]: DEBUG_KERNEL [=n] && LOCK_DEBUGGING_SUPPORT [=y]
     Selected by [y]:
     - DEBUG_NET_SMALL_RTNL [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

