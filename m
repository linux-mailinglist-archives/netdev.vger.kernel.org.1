Return-Path: <netdev+bounces-238297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBD4C57242
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F5B0341CD8
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3E921B9F1;
	Thu, 13 Nov 2025 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nSMpKKu3"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C7D207A20
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 11:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032814; cv=none; b=hd8RHXDSpiDQ7DOTXT/PAzw4VEqtihyN6CmW01nF/QPccXld9ZwOpj1tOW6Bnsma3xlhPbCa+KkYOWahhixSJR02rEHuMRwVpT09xjZJxZsQK8CQsDlKTcPTIbwHXSkk9Y0QRND6gpLz4WrBWk9cHeU3sdvBBKdHwmdmA2ul9yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032814; c=relaxed/simple;
	bh=Vjc1WJSX88xblSnnKMaZLg8GTAhoNym76AoZ0mVAkXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iR5lZ1P6+1GkRJ09npJwAj4qPnoZ/mNTy4FzfuO/wS4zJbqseWymA3+z+tZQUBjEcJUPore47M9RjHRASXswAetwP3DeUo2n1q0Bg9K37+rxgmRtH8LB3giUSwg6wGhSKxdsORJZgLpo7kbm1fQU9WqbHPF1lp6byXltiW9x2cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nSMpKKu3; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3458a837-d7aa-45f0-9c3e-af6c4efed70c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763032810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mnSTNvUT+1yJ2piMH3ilwc4xIJaH6Ywt2gVpDSgvTSI=;
	b=nSMpKKu3aRptwQlNgkvezJeD2LJxMSarbOCE5oA1xg1yNDQOlHvwurhIBC969HPeurNSh6
	FTmBhBJ6D5N1xf8gzTcafKQzGbsn3jgPNPpvcgq0hA9n7JkmaUa5ybk6pCGF21t95HLf3x
	kS9Xu44ElEa3mdlvei+6mvN57tw2i+c=
Date: Thu, 13 Nov 2025 11:20:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 2/2] qede: convert to use ndo_hwtstamp
 callbacks
To: Jakub Kicinski <kuba@kernel.org>
Cc: Manish Chopra <manishc@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 Kory Maincent <kory.maincent@bootlin.com>, netdev@vger.kernel.org
References: <20251111151900.1826871-1-vadim.fedorenko@linux.dev>
 <20251111151900.1826871-3-vadim.fedorenko@linux.dev>
 <20251112183508.3c20e21d@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251112183508.3c20e21d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13.11.2025 02:35, Jakub Kicinski wrote:
> On Tue, 11 Nov 2025 15:19:00 +0000 Vadim Fedorenko wrote:
>> The driver implemented SIOCSHWTSTAMP ioctl cmd only, but it stores
>> configuration in private structure, so it can be reported back to users.
>> Implement both ndo_hwtstamp_set and ndo_hwtstamp_set callbacks.
>> ndo_hwtstamp_set implements a check of unsupported 1-step timestamping
>> and qede_ptp_cfg_filters() becomes void as it cannot fail anymore.
>>
>> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
>> -static int qede_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>> -{
>> -	struct qede_dev *edev = netdev_priv(dev);
>> -
>> -	if (!netif_running(dev))
>> -		return -EAGAIN;
> 
> Isn't this running check gone after conversion?

Ah, yeah, I'll keep it in v4

> 
>> -	switch (cmd) {
>> -	case SIOCSHWTSTAMP:
>> -		return qede_ptp_hw_ts(edev, ifr);
>> -	default:
>> -		DP_VERBOSE(edev, QED_MSG_DEBUG,
>> -			   "default IOCTL cmd 0x%x\n", cmd);
>> -		return -EOPNOTSUPP;
>> -	}
>> -
>> -	return 0;
>> -}
>> -
> 
>> +	switch (config->tx_type) {
>> +	case HWTSTAMP_TX_ONESTEP_SYNC:
>> +	case HWTSTAMP_TX_ONESTEP_P2P:
>> +		NL_SET_ERR_MSG_MOD(extack,
>> +				   "One-step timestamping is not supported");
>> +		return -ERANGE;
>> +	}
> 
> Eh, I guess the warning I was imagining isn't actually enabled at W=1 :(
> And config->.x_type does not use enums..

Yeah, looks like it's because config::tx_type/rx_filter are not enums but plain
int type.

> 
> Could you switch this to the slightly more resilient:
> 
> 	switch (config->tx_type) {
> 	case HWTSTAMP_TX_ON:
> 	case HWTSTAMP_TX_OFF:
> 		break;
> 	default:
> 		NL_SET_ERR_MSG_MOD(extack,
> 				   "One-step timestamping is not supported");
> 		return -ERANGE;
> 	}
> 
> ? Guess similar adjustment would also work for patch 1.

Sure, will do in v4 in both patches.


