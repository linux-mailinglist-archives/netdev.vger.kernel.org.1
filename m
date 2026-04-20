Return-Path: <netdev+bounces-279651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCxtJnab5WlvmAEAu9opvQ
	(envelope-from <netdev+bounces-279651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 05:20:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E75426890
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 05:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD5753001CCD
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 03:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A3137648D;
	Mon, 20 Apr 2026 03:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5ohoV2t"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B2433EF;
	Mon, 20 Apr 2026 03:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776655216; cv=none; b=Q3cwiPu6QgpDoJpoNNz7kgo1pgkyNqwqhXWt8tPf86rV4J6j+vHMT+eoqO9MMZvP4nRwj1f7rD/hvgY5zC097XDmT9/u8UumJCMXD99d80W8mH2i8+rsXRTx1Ceiwl2Qt3Va+yISa9UvwQ4xVRRLJtc5ktNcoxARHxw91+yw/Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776655216; c=relaxed/simple;
	bh=I96x05WWbxNDXdYnL1sEhcmWSmBoa7yu/uYaLcjrTYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WqDYWm+5Bcn3S9fFb+b7coR7NmgB7mbtSvaz2WhrYw3/I6suCOaLuQHeW61aFYvK+PlcJLkqIxN5+/GkIuTp8cPfFB95s3s2f53sOac1zsSKxIuxNR0BhmYrdwxgDqb/rDtSsAiTbG25QW+OecxAQBW0ehvQnfC999agYG2i+KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5ohoV2t; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776655215; x=1808191215;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I96x05WWbxNDXdYnL1sEhcmWSmBoa7yu/uYaLcjrTYE=;
  b=c5ohoV2t7xy9Z10H112j+R/FUXTB37pSBt0uoV5jNLiDhnXfYmpqGxX5
   gkMGMoFK5i36KViAR2sxQ1fjQAf3SJyYuUTVQLS6TLB7Q0+Ql0/P2rDCT
   HCKEo1nW40BCJtEQ2tUj7H+7DwZW5dDP6Yy6ajtndwB6eyx9DL70pkr2D
   W38AkoNPDny9x0RmVWHqLjDISjK2Gs3KLrL0J+mpf1DOgTqWu856Jau+o
   LeUGmEhsSK7dfQN+l352ldwTWP/doyScWQW3TNLQG8KEet8+mV1X0q71/
   ONfBONM0u/wpbTH5Eh9vHgDsmyHQUQL8fPe/kgMLWb79UKEG7P4243Te9
   w==;
X-CSE-ConnectionGUID: cgkVj5cfTd+TTbFnxBDHWQ==
X-CSE-MsgGUID: MeezGUq2SwqRSvtRhFYKQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="89032154"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="89032154"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2026 20:20:14 -0700
X-CSE-ConnectionGUID: qPAi+K2FSGeq+PDZXEyAuw==
X-CSE-MsgGUID: eNtEGU/+Shq84y5c6COEFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="231880747"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.8.237]) ([10.247.8.237])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2026 20:20:11 -0700
Message-ID: <3481ae84-5c36-4591-94c1-78b70fff4d7b@linux.intel.com>
Date: Mon, 20 Apr 2026 11:20:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 3/3] igc: add support for forcing link speed
 without autonegotiation
To: Simon Horman <horms@kernel.org>, khai.wen.tan@linux.intel.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 faizal.abdul.rahim@intel.com, hong.aun.looi@intel.com, khai.wen.tan@intel.com
References: <20260416015520.6090-4-khai.wen.tan@linux.intel.com>
 <20260418164837.380985-2-horms@kernel.org>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20260418164837.380985-2-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279651-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[faizal.abdul.rahim@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: A2E75426890
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 19/4/2026 12:48 am, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> igc: add support for forcing link speed without autonegotiation
> 
> This commit adds support to allow users to force 10/100 Mb/s link speed
> and duplex via ethtool when autonegotiation is disabled.
> 
>> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> index cfcbf2fdad6ea..5bd37d1be1688 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> 
> [ ... ]
> 
>> @@ -2000,6 +2013,41 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
>>   	return 0;
>>   }
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
>> +	if (duplex == DUPLEX_HALF)
>> +		adapter->hw.fc.requested_mode = igc_fc_none;
>> +}
> 
> If userspace issues an ethtool command without specifying duplex, the duplex
> value can be DUPLEX_UNKNOWN. In this case, forced_speed_duplex correctly
> defaults to half-duplex since duplex == DUPLEX_FULL evaluates to false.
> 
> However, since DUPLEX_UNKNOWN is not equal to DUPLEX_HALF, the check above
> fails, and the requested flow control mode remains unchanged. Could this leave
> flow control enabled on a forced half-duplex link, violating IEEE 802.3?
> Should this check be based on the resolved mac->forced_speed_duplex state
> instead?
>

You're right, thanks for pointing that out.

That said, it feels simpler to address it with [1]:
if (duplex != DUPLEX_FULL)
     adapter->hw.fc.requested_mode = igc_fc_none;

Rather than [2]:
  if (mac->forced_speed_duplex == IGC_FORCED_10H ||
         mac->forced_speed_duplex == IGC_FORCED_100H)
         adapter->hw.fc.requested_mode = igc_fc_none;

Are you okay with [1] ?

> [ ... ]
> 
>> @@ -2071,14 +2120,20 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
>>   		}
>>   	}
>>   
>> +	if (cmd->base.autoneg == AUTONEG_DISABLE &&
>> +	    cmd->base.speed != SPEED_10 && cmd->base.speed != SPEED_100) {
>> +		netdev_info(dev, "Unsupported speed for forced link\n");
>> +		return -EINVAL;
>> +	}
>> +
>>   	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
>>   		usleep_range(1000, 2000);
> 
> This isn't a bug introduced by this patch, but does this ad-hoc
> synchronization using bit flags circumvent proper locking guarantees? The
> networking subsystem guidelines forbid using bit flags as ad-hoc locks.
> 
> Using a bit flag in a polling loop bypasses lockdep analysis, fairness, and
> strict memory ordering. Could this be replaced with a real synchronization
> mechanism like a mutex?

It looks like a worthwhile cleanup. However, it likely doesn’t belong in 
this series, since the synchronization pattern predates these patches and 
is used throughout the igc driver (set_ringparam, set_pauseparam, 
set_channels, etc.). We could address it in different patch series and 
align the other code paths at the same time ?


