Return-Path: <netdev+bounces-70950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59298512EA
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 13:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0486D1C21F18
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 12:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC83139AE1;
	Mon, 12 Feb 2024 11:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gMyrg/oK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A18C39AD4
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739039; cv=none; b=DWl1JDIBHUoedkTvWaXn56nPOsR+01uwNJwnksi6gfhu1Rj+M5l9D8xbEHEcD1XFx45pX9a6g2peb2KVcS8Elt57nJVegGrLUiNbRPulHzVBEFRP9XiK6H1PFyssabsMLzLbRImiQsAl3LGeMxgUNzv83nfr5GgNdXevZKHxRJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739039; c=relaxed/simple;
	bh=f6EiuWub7HHpiZW+ID8+bBipEsnHV42m62i4qfxzd5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+BQ/zkGV8FgCQ4jxN3zXnE0OMRbf+M9n4UV0t4W28RGgI6/6QurrgiQBiclMCcGs5cet+juM1RqPKbWb6qG00s1WmcffYZ3uqIwbI7bYVCk/0H4ONPCdTei5JQoYYPy6v6951DZHBOeZTeuZW/nSWQ9zIGwb26Twm4nFsz94ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gMyrg/oK; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707739036; x=1739275036;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f6EiuWub7HHpiZW+ID8+bBipEsnHV42m62i4qfxzd5A=;
  b=gMyrg/oKOmezOZn7oi1Zzc0fZn1XQfFk66J78LvSLYrCgZhv/vcr1JuT
   sNRCycfkQEW+wr9mQEUzldPl4yOoKY8OgktbwHGR/z2Nx6y0Rv1wX80vB
   ZdcErlCNk5kcEDC8QiXu/5n9cV9VU+OrS5Xwub7JIfJJH72G8fRY3ZfPY
   3aUv+ZRRVIez9MwPiJ+jlsVdGc+pal4ATUFFIFKFRHutdPFDTvZR3wuvk
   1FjCxTnGgVEw0VImOdJtQsYLyGH+Mz3ZROsalT2S2x7ydYawpANrwjhKg
   nzzGCforEYyY25/GwJ/+7snM7dCMjEnJzOtrR5/w2PPf7oRuKprSwKLJl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="12347856"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="12347856"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 03:57:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="7203745"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.12.48.215]) ([10.12.48.215])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 03:57:12 -0800
Message-ID: <aa9a43d6-6558-4af6-9a7b-2e35341c179c@linux.intel.com>
Date: Mon, 12 Feb 2024 13:57:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igc: Add support for LEDs
 on i225/i226
Content-Language: en-US
To: Kurt Kanzenbach <kurt@linutronix.de>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
References: <20240206-igc_leds-v3-1-390ce3d18250@linutronix.de>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20240206-igc_leds-v3-1-390ce3d18250@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/6/2024 16:27, Kurt Kanzenbach wrote:
> Add support for LEDs on i225/i226. The LEDs can be controlled via sysfs
> from user space using the netdev trigger. The LEDs are named as
> igc-<bus><device>-<led> to be easily identified.
> 
> Offloading link speed and activity are supported. Other modes are simulated
> in software by using on/off. Tested on Intel i225.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
> Changes since v2:
> 
>   * Offload activity if possible (Andrew)
> 
> Changes since v1:
> 
>   * Add brightness_set() to allow software control (Andrew)
>   * Remove offloading of activity, because the software control is more flexible
>   * Fix smatch warning (Simon)
> 
> Previous versions:
> 
>   * v1: https://lore.kernel.org/netdev/20240124082408.49138-1-kurt@linutronix.de/
>   * v2: https://lore.kernel.org/netdev/20240201125946.44431-1-kurt@linutronix.de/
> ---
>   drivers/net/ethernet/intel/Kconfig        |   8 +
>   drivers/net/ethernet/intel/igc/Makefile   |   1 +
>   drivers/net/ethernet/intel/igc/igc.h      |   5 +
>   drivers/net/ethernet/intel/igc/igc_leds.c | 280 ++++++++++++++++++++++++++++++
>   drivers/net/ethernet/intel/igc/igc_main.c |   6 +
>   drivers/net/ethernet/intel/igc/igc_regs.h |   1 +
>   6 files changed, 301 insertions(+)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>

