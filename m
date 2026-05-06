Return-Path: <netdev+bounces-284712-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNGjHN7e+mmGTgMAu9opvQ
	(envelope-from <netdev+bounces-284712-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 08:25:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD70B4D690E
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 08:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C70B3015A42
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 06:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5222FE042;
	Wed,  6 May 2026 06:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AY8Q68c9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DD92E975E;
	Wed,  6 May 2026 06:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778048731; cv=none; b=guw8pxNDxYk9jxeXn7o0ZTu6ERrBBpteuGgiS/+Pmnwdhn8m+6zUvJYCf8Sb9AZCs8SLIoYRAr9eTeF5kpa7CjsIy/Zp9HLwTB82u1r5A5DRZ54TG8dFdb2N86AxafrPP2OMyr94rs6Q88TGNmde0Daq4ZPuDF8batiSWFJKkfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778048731; c=relaxed/simple;
	bh=R4bPcjPlqNPWP683/yZmV5MoC5B7pmWZIA6XXvjemv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Atl8Be4hiI2lStOD8tp832kHmUReS1lyJVGv4te4WFr801XchpfmUvf797P+j2sucV/itGHl3qlkGe7mrkfOas/yzkS4rCbKIu89S8rOJ9IhYOSKpy/tu3EO588GkTvaWgvEadElRCnFoFh503wWaBKV6AykT+StMgfuJy/8mTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AY8Q68c9; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778048730; x=1809584730;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R4bPcjPlqNPWP683/yZmV5MoC5B7pmWZIA6XXvjemv0=;
  b=AY8Q68c9doVXd8zmzG/6L0aL9GFlGi1ze8HbxfG0N0+drf0uXmpmLf9E
   m6mZUiRX60HmxInI7e+zXI1nHihrMotg6ElcXwS+7yUiD+JNKolIsUN1g
   P7kfnuTPE9uAxI0j/kShw5Ahb2cAMaD+RLG28e2mChXeNPY7isMGUw/vS
   ABFIb8QsvtWhK0ssqAyrOveKXIIk1ItVNMSO6UxAT1rq5ZUY6eW7HeyUg
   s98rEivzbLMWdIUo+sRnGvGLLjSjzaAX2o//KP17SixrjEATKGqtHtBps
   18HFcmF/NlrMV5XLL0Nh84KFKAdWJlT4usyw8hvd1Qr5gYnpNUkO7Dh29
   Q==;
X-CSE-ConnectionGUID: W5QUSzJFTsenp3oLLP7QbA==
X-CSE-MsgGUID: Am2bs66qQGOWllYyn/GiIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78995681"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="78995681"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 23:25:29 -0700
X-CSE-ConnectionGUID: HrPAXSirRGapphNQmPPsnQ==
X-CSE-MsgGUID: nrdfDvlkRbupitL8MziVjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="235181845"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.37.237]) ([10.247.37.237])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 23:25:26 -0700
Message-ID: <16b18088-8fe3-4a38-9eb9-d39842e6b94f@linux.intel.com>
Date: Wed, 6 May 2026 14:25:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4 3/3] igc: add support for forcing link speed
 without autonegotiation
To: Simon Horman <horms@kernel.org>, khai.wen.tan@linux.intel.com
Cc: anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, faizal.abdul.rahim@intel.com,
 hong.aun.looi@intel.com, khai.wen.tan@intel.com
References: <20260428060009.311393-4-khai.wen.tan@linux.intel.com>
 <20260430135057.1653330-1-horms@kernel.org>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20260430135057.1653330-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DD70B4D690E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284712-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[faizal.abdul.rahim@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,linux.intel.com:mid]



On 30/4/2026 9:50 pm, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> igc: add support for forcing link speed without autonegotiation
> 
> This commit allows users to force 10/100 Mb/s link speed and duplex via
> ethtool when autonegotiation is disabled. Previously, the driver rejected
> these requests.
> 
>> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> index cfcbf2fdad6e..9997ebbdf778 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> [ ... ]
>> @@ -2000,6 +2013,41 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
>>  	return 0;
>>  }
>>  
>> +/**
>> + * igc_handle_autoneg_disabled - Configure forced speed/duplex settings
>> + * @adapter: private driver structure
>> + * @speed: requested speed (must be SPEED_10 or SPEED_100)
>> + * @duplex: requested duplex
>> + *
>> + * Records forced speed/duplex when autoneg is disabled.
>> + * Caller must validate speed before calling this function.
>> + */
>> +static void igc_handle_autoneg_disabled(struct igc_adapter *adapter, u32 speed,
>> +					u8 duplex)
>> +{
>> +	struct igc_mac_info *mac = &adapter->hw.mac;
>> +
>> +	switch (speed) {
>> +	case SPEED_10:
>> +		mac->forced_speed_duplex = (duplex == DUPLEX_FULL) ?
>> +			IGC_FORCED_10F : IGC_FORCED_10H;
>> +		break;
>> +	case SPEED_100:
>> +		mac->forced_speed_duplex = (duplex == DUPLEX_FULL) ?
>> +			IGC_FORCED_100F : IGC_FORCED_100H;
>> +		break;
>> +	default:
>> +		WARN_ONCE(1, "Unsupported speed %u\n", speed);
>> +		return;
>> +	}
>> +
>> +	mac->autoneg_enabled = false;
>> +
>> +	/* Half-duplex cannot support flow control per IEEE 802.3 */
>> +	if (duplex != DUPLEX_FULL)
>> +		adapter->hw.fc.requested_mode = igc_fc_none;
> 
> Does this permanently overwrite the user's flow control preference?
> 
> If half-duplex is requested, requested_mode is set to igc_fc_none. Because
> requested_mode represents the persistent state for the user's flow control
> preference, the user might permanently lose their configuration. If they later
> switch back to full-duplex, requested_mode remains igc_fc_none, and flow
> control stays disabled.
> 
> Would it be better to dynamically override hw->fc.current_mode to
> igc_fc_none during link configuration instead of mutating requested_mode?
> 

Yes you're right, thanks, will update.

>> +}
> [ ... ]
>> @@ -2071,14 +2126,20 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
>>  		}
>>  	}
>>  
>> +	if (cmd->base.autoneg == AUTONEG_DISABLE &&
>> +	    cmd->base.speed != SPEED_10 && cmd->base.speed != SPEED_100) {
>> +		netdev_info(dev, "Unsupported speed for forced link\n");
>> +		return -EINVAL;
>> +	}
>> +
> 
> Should we also validate cmd->base.duplex here to prevent a fallback to
> half-duplex?
> 
> If a user runs a command like "ethtool -s eth0 speed 100 autoneg off" while
> the link is down, ethtool queries and preserves the current duplex value,
> which is DUPLEX_UNKNOWN (0xff).
> 
> In igc_handle_autoneg_disabled(), the code checks if duplex == DUPLEX_FULL,
> which evaluates to false, and forces the interface to 100 Mbps half-duplex.
> 
> Could we explicitly check that cmd->base.duplex is either DUPLEX_HALF or
> DUPLEX_FULL and return -EINVAL otherwise?

Will update.

> 
>>  	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
>>  		usleep_range(1000, 2000);
> 
> This isn't a bug introduced by this patch, but does this ad-hoc
> synchronization loop reimplement locking without fairness or lockdep support?
> 
> According to the Networking Subsystem Guidelines, using bit operations as a
> substitute for real locks violates core kernel locking rules and introduces
> potential races.
> 
> Could this be replaced with a proper concurrency mechanism such as a mutex?
> 

Hi Simon, you've raised this issue in v2, and after discussion, you've
agreed that this change doesn't belong in this patch series.

Not sure if I missed anything?

>>  
>> -	if (cmd->base.autoneg == AUTONEG_ENABLE) {
>> +	if (cmd->base.autoneg == AUTONEG_ENABLE)
>>  		igc_handle_autoneg_enabled(adapter, cmd);
>> -	} else {
>> -		netdev_info(dev, "Force mode currently not supported\n");
>> -	}
>> +	else
>> +		igc_handle_autoneg_disabled(adapter, cmd->base.speed,
>> +					    cmd->base.duplex);
>>  
>>  	/* MDI-X => 2; MDI => 1; Auto => 3 */
>>  	if (cmd->base.eth_tp_mdix_ctrl) {
> 


