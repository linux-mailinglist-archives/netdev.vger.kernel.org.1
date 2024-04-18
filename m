Return-Path: <netdev+bounces-89073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2158A95C1
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 11:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC5B1C20CE9
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33EF158858;
	Thu, 18 Apr 2024 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DnUXUTKQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C1B6F53D
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713431626; cv=none; b=Ur0wcYGpzHfGVzcFQTNXAKaV2vaE1jXiL/LuMHLP62YXFQtq4dVnlMuK6MPTDNpxTh20BkLAT3nMwnPz/Ah9hocbvgeKVI5Y/fuKunYee1Z+nF5nBXktBD9GuSk70CleQAECdP0ReDe/iEbNlso65QwdEwNRFNTUdugxhmylvgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713431626; c=relaxed/simple;
	bh=rQGVQURqecrBOAPb1l2hVI6jUgQPxnMOVRcXI3wTpIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e7eq4r3QNR/1UZmbz7DaU9dHTwSG7GehRYbDZ94NtvZJRjokkJhwEcEjWMjuwy86APqf8bsUqgjSTgAVHF6xKcDXrxd+I1jgg9jK29OgWVPBKOdX2QYQieAbjGLxkLG7F8OYp/HzpVHhavHnwp2LQVyQ6Sh20bwKctC5Qf9oGFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DnUXUTKQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713431626; x=1744967626;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rQGVQURqecrBOAPb1l2hVI6jUgQPxnMOVRcXI3wTpIM=;
  b=DnUXUTKQ/SJjWfRvGTyIzM0pnyG3pLYXncfLylWFSvRPdBj4SJRtuAK+
   EKCeXAN/phe0SLzEh8tDagjV/h/K5NNfGDgq+2y58WUxUTJuk3DIBmBEf
   eEzC/GLoEVOvCRcbhz6dpBBlHmJHJaSPtP+uT/7yUIipt85WurPN6Qa/P
   eoZ/kIL8MgsFTQt0cpEd5H41uTnWTdWdtSVEzoEDASLqhJvJhsad8qteu
   8hrE8x+KOhTF5ZwZPaghpeQBvuV2TDdkU6TsJjMIBNnuKZUKYlfwiQNiI
   xwfTj2VBM42H3HWnxIaHEpvxy7hamOhCUcEmXYhViS88ZnlT6Wo44xIAk
   A==;
X-CSE-ConnectionGUID: nEb0oQswTIGj73cHu3r0kQ==
X-CSE-MsgGUID: foapRs5tRgy4tPzvlJxStA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="31446458"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="31446458"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 02:13:41 -0700
X-CSE-ConnectionGUID: Q80yaZIkSROABstXCsNY9g==
X-CSE-MsgGUID: q9OQ6LECSp20L9+ZHhLUXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="53852345"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.245.136.172]) ([10.245.136.172])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 02:13:37 -0700
Message-ID: <ebb704a3-eb09-4433-8858-990e17a87721@linux.intel.com>
Date: Thu, 18 Apr 2024 12:13:17 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] igc: Fix LED-related deadlock on
 driver unbind
To: Lukas Wunner <lukas@wunner.de>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Sasha Neftin <sasha.neftin@intel.com>,
 netdev@vger.kernel.org, Kurt Kanzenbach <kurt@linutronix.de>,
 intel-wired-lan@lists.osuosl.org, Roman Lozko <lozko.roma@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
References: <2f1be6b1cf2b3346929b0049f2ac7d7d79acb5c9.1713188539.git.lukas@wunner.de>
Content-Language: en-US
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <2f1be6b1cf2b3346929b0049f2ac7d7d79acb5c9.1713188539.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/2024 16:48, Lukas Wunner wrote:
> Roman reports a deadlock on unplug of a Thunderbolt docking station
> containing an Intel I225 Ethernet adapter.
> 
> The root cause is that led_classdev's for LEDs on the adapter are
> registered such that they're device-managed by the netdev.  That
> results in recursive acquisition of the rtnl_lock() mutex on unplug:
> 
> When the driver calls unregister_netdev(), it acquires rtnl_lock(),
> then frees the device-managed resources.  Upon unregistering the LEDs,
> netdev_trig_deactivate() invokes unregister_netdevice_notifier(),
> which tries to acquire rtnl_lock() again.
> 
> Avoid by using non-device-managed LED registration.
> 
> Stack trace for posterity:
> 
>    schedule+0x6e/0xf0
>    schedule_preempt_disabled+0x15/0x20
>    __mutex_lock+0x2a0/0x750
>    unregister_netdevice_notifier+0x40/0x150
>    netdev_trig_deactivate+0x1f/0x60 [ledtrig_netdev]
>    led_trigger_set+0x102/0x330
>    led_classdev_unregister+0x4b/0x110
>    release_nodes+0x3d/0xb0
>    devres_release_all+0x8b/0xc0
>    device_del+0x34f/0x3c0
>    unregister_netdevice_many_notify+0x80b/0xaf0
>    unregister_netdev+0x7c/0xd0
>    igc_remove+0xd8/0x1e0 [igc]
>    pci_device_remove+0x3f/0xb0
> 
> Fixes: ea578703b03d ("igc: Add support for LEDs on i225/i226")
> Reported-by: Roman Lozko <lozko.roma@gmail.com>
> Closes: https://lore.kernel.org/r/CAEhC_B=ksywxCG_+aQqXUrGEgKq+4mqnSV8EBHOKbC3-Obj9+Q@mail.gmail.com/
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h      |  2 ++
>   drivers/net/ethernet/intel/igc/igc_leds.c | 38 ++++++++++++++++++++++++-------
>   drivers/net/ethernet/intel/igc/igc_main.c |  3 +++
>   3 files changed, 35 insertions(+), 8 deletions(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>

