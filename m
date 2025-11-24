Return-Path: <netdev+bounces-241146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3849EC803D6
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 12:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D84763448AA
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 11:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EF22FD7B2;
	Mon, 24 Nov 2025 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bBisRkAx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0892FB962
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763984550; cv=none; b=n9V9XXVeNuM5YNBhfX17f6VbLGnMo6G89FgHZAUuXM3GYHRfqrF3Xr0KMIRf/lm6BZtywrYPiVIRzlwNyzguo71VoW3nypnywf+Pp10wa2A+0K1q3B58ol3l6MQpPzQEPGLCFqiNcyHAMNE+0tjnVS95rvq3LsF/n6aeZuG0JQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763984550; c=relaxed/simple;
	bh=q4ntfVxQRZkW2CuKNeZO79nxICArr40RgNvtkzd65V4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Slf5aXhaNjEuDCSqUd1qxSaHkwW1aRpp0qfaPYL9J9VBdfCDcax94pHYXOVuNk/Xa8FTzvkGzVnG3RvGHwadWcTbDHLoLrm1xdFZAHN8z6YSTgIm8WwCNodINVcRNEDEhHjlNuV0RyLf0Sh8A1eVQ9QLYTkQTNMjdwoaMNIHOKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bBisRkAx; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763984548; x=1795520548;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q4ntfVxQRZkW2CuKNeZO79nxICArr40RgNvtkzd65V4=;
  b=bBisRkAx1VBfJ9gk+La1/9c7hGneyIzsDESqjIkSP7YiaBNiLTRqj0Aw
   fPqbak0zPDP+QlvvHZJ6ACwnvDN+DRBzALsDQ+P57in+tF3vJmBFBp4JP
   YPn52bKcC6pIk/vGFS38hdTPOLSKC/1h1Lr6YdKJ1loWNpS4yUXfdIjQu
   vgsAXhm8Orkb/+pzl8h/eDdVOM+t/eaKYSPDx0/3O9CoHUe37yFfad2AT
   Nito5oQVAjzCGtRaVuDRF0YcaiLXomdOS5D4Zn2suT6p+0fvvfUFpwvDH
   PN4f6TS15gmkZ8DLyJsLorJ03cUFCHTB8RHvun+VG2zFmJyo+OzrJoXJi
   A==;
X-CSE-ConnectionGUID: 2NQWNILlS1OSQq28KS+tCA==
X-CSE-MsgGUID: vCi4C0rETpCYGEjJgTlsKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="88633389"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="88633389"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 03:42:27 -0800
X-CSE-ConnectionGUID: 2IUEq4b2SGOmPHJmaemNTQ==
X-CSE-MsgGUID: o8R/nalYQP2UEybVJILtaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="193095019"
Received: from unknown (HELO [10.217.181.108]) ([10.217.181.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 03:42:26 -0800
Message-ID: <e822ab45-0fa7-43bd-8236-3497d8ec0ca3@linux.intel.com>
Date: Mon, 24 Nov 2025 12:42:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-firmware] ice: update DDP LAG package to 1.3.2.0
To: Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20251118121709.122512-1-marcin.szycik@linux.intel.com>
 <84d7bbbd-5902-4b9d-9bc2-eb1704b81d57@intel.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <84d7bbbd-5902-4b9d-9bc2-eb1704b81d57@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 21.11.2025 22:38, Tony Nguyen wrote:
> 
> 
> On 11/18/2025 4:17 AM, Marcin Szycik wrote:
>> Highlights of changes since 1.3.1.0:
>>
>> - Add support for Intel E830 series SR-IOV Link Aggregation (LAG) in
>>    active-active mode. This uses a dual-segment package with one segment
>>    for E810 and one for E830, which increases package size.
>>
>> Testing hints:
>> - Install ice_lag package
>> - Load ice driver
>> - devlink dev eswitch set $PF1_PCI mode switchdev
>> - ip link add $BR type bridge
>> - echo 1 > /sys/class/net/$PF1/device/sriov_numvfs
>> - ip link add $BOND type bond miimon 100 mode 802.3ad
>> - ip link set $PF1 down
>> - ip link set $PF1 master $BOND
>> - ip link set $PF2 down
>> - ip link set $PF2 master $BOND
>> - ip link set $BOND master $BR
>> - ip link set $VF1_PR master $BR
>> - Configure link partner in 802.3ad bond mode
>> - Verify both links in bond are transmitting/receiving VF traffic
>> - Verify bond still works after pulling one of the cables
>>
>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>> ---
>>   ...ce_lag-1.3.1.0.pkg => ice_lag-1.3.2.0.pkg} | Bin 692776 -> 1360772 bytes
>>   1 file changed, 0 insertions(+), 0 deletions(-)
>>   rename intel/ice/ddp-lag/{ice_lag-1.3.1.0.pkg => ice_lag-1.3.2.0.pkg} (49%)
> 
> The WHENCE file needs to be updated to reflect the new version.

Sorry, will update in v2.

Marcin

>>
>> diff --git a/intel/ice/ddp-lag/ice_lag-1.3.1.0.pkg b/intel/ice/ddp-lag/ice_lag-1.3.2.0.pkg
>> similarity index 49%
>> rename from intel/ice/ddp-lag/ice_lag-1.3.1.0.pkg
>> rename to intel/ice/ddp-lag/ice_lag-1.3.2.0.pkg
> 
> 


