Return-Path: <netdev+bounces-68978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE56F849049
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 21:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775EA1F21EF2
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 20:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DD3250FD;
	Sun,  4 Feb 2024 20:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AsQ87Mi9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B51525542
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707077346; cv=none; b=CXERUlJdcNWn7HUfgsp5hiVde2dhZqLIyrP+uJY3htC13c8oVk0cj8Stz7G0o7ZQlQvE/U5mJM7D3Ngtrbs7bb+flhaDwaFZ6udtAniGx7PVAhRQxRNeP4sa/22wvgxjxMT/5KCPlkm2tPiBoFju+bDtSFigvICVjE6mTdCL8H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707077346; c=relaxed/simple;
	bh=iAxMkmIBEx6JRTOgplejPllumoRaDR5CtoZ4eNtC3bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+DmkAE1VdPFEqfodrqerC3lHMRS1tB6lqyG782zOA35lbMA7fLbizVnFTb8feVa6Le1KMYJ2FvPqi7Uu9MBGooOwlC+0GAkbsanFVZJLTnNIKP4dPppWemA2KsqiEZiBfvQO2gLFC4F3j1hbu+3KOwwsg82K5pAfIZmoqP0Wp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AsQ87Mi9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707077345; x=1738613345;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iAxMkmIBEx6JRTOgplejPllumoRaDR5CtoZ4eNtC3bc=;
  b=AsQ87Mi9pINtRQ2p3EX/rgtZMWdD55RirzmVNuIoSrjhCpeVcZ06Nnbw
   L+gYJ+uYJ86scNmJOFv57KkSFpwhi1zkNk3oa40SA9rzIeKaHfZ3rpdPt
   x58nQep87W7KTyEnVa3ywtXkDI7GR1+77Hri5hGUObe8mMYN+5Cx6J/wf
   GOJgNwZoA7sRk5PJY5trfyyqVU24OvnmlsTF0w/IDvQUYh8FqHdYC29/s
   Biw1roptblwnlGADZAUVOwmp0O3t0LaNbwjzEuDtC0vrQUQa4lpE1cagJ
   tr/O/0n6kR4dgt9n7Szq893bucqoJmCQrl5CMXUgtHcESecT8k6BE9mM/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="304421"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="304421"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 12:09:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="5185667"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.124.132.248]) ([10.124.132.248])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 12:08:59 -0800
Message-ID: <2b2029bd-083f-444f-ab55-ac63827a9f5e@linux.intel.com>
Date: Sun, 4 Feb 2024 22:08:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-next 3/3] igc: Unify filtering
 rule fields
Content-Language: en-US
To: Kurt Kanzenbach <kurt@linutronix.de>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: netdev@vger.kernel.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Eric Dumazet <edumazet@google.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
References: <20240124085532.58841-1-kurt@linutronix.de>
 <20240124085532.58841-4-kurt@linutronix.de>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20240124085532.58841-4-kurt@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/24/2024 10:55, Kurt Kanzenbach wrote:
> All filtering parameters such as EtherType and VLAN TCI are stored in host
> byte order except for the VLAN EtherType. Unify it.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h         |  2 +-
>   drivers/net/ethernet/intel/igc/igc_ethtool.c |  4 ++--
>   drivers/net/ethernet/intel/igc/igc_main.c    | 10 ++++++----
>   3 files changed, 9 insertions(+), 7 deletions(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>

