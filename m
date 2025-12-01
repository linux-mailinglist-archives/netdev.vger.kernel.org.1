Return-Path: <netdev+bounces-242937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F50C96A6C
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 11:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AE174E1C8B
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 10:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6F0304BB9;
	Mon,  1 Dec 2025 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="opIxaEGW"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D2C303C8E
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764584917; cv=none; b=qf5ghmKFRBlAT/Jr2CXjH4sCZUv9t7K/W+NbyCdnbz+L5G0E8EsJY8fMMw9EOBzFAMwTO947+2HC0K6lZHSBVLkSXj3X5JTPcRnyGdLyq13u+pZReGWWuez4ZjpjcuyImIX/noNWg4vXmyxC+0rR82hRtXGKhUKnkEtwI/Fy+KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764584917; c=relaxed/simple;
	bh=Prg6WqzVJDmzSC12RQZYm9DT3NAx4vUDtfz17hwHL/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMP7x0mYkpHULJi1uh9S2/12/m+nreEH0FYSzNNwnO9xe8EOpSsni4EQ++ICM8xlqZ4G8c+10Vpdw6gBKikkbXq7iCYYtbnqdP2tQAUQJKsh7OpsbzA7Pv0qiPXxO91bDbH1k3EwSG5m+EJ6sBNnNdb70X8ffoRagmYnPQoFicA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=opIxaEGW; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f9919964-236c-4f2e-a7ec-9fe7969aaa55@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764584912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=raevJtH4CPnP5vPCkH/r+tShfhA3eaFlWkqVRyC8CRQ=;
	b=opIxaEGWGr1wW+ZqhPKQYo9LZylLmrIa5mSokBi+1IVAFQADQ9Q9yMHZ76e011Bj20x2UR
	i2/y624GpZW/JI53AoveVV8kJFITrTRAduNkok6uNMxfrJP8nQQXEQzPyxAq0cfVAX/Ag0
	96PxhObHw3Meq7Y+zsvHHD2rsewzAHs=
Date: Mon, 1 Dec 2025 10:28:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 3/4] net: phy: microchip_rds_ptp: improve HW
 ts config logic
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20251129195334.985464-1-vadim.fedorenko@linux.dev>
 <20251129195334.985464-4-vadim.fedorenko@linux.dev>
 <20251201103440.0ddf9c42@kmaincent-XPS-13-7390>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251201103440.0ddf9c42@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 01/12/2025 09:34, Kory Maincent wrote:
> On Sat, 29 Nov 2025 19:53:33 +0000
> Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:
> 
>> The driver stores new HW timestamping configuration values
>> unconditionally and may create inconsistency with what is actually
>> configured in case of error. Improve the logic to store new values only
>> once everything is configured.
>>
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> ---
>>   drivers/net/phy/microchip_rds_ptp.c | 21 ++++++++++++++++-----
>>   1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/phy/microchip_rds_ptp.c
>> b/drivers/net/phy/microchip_rds_ptp.c index 4c6326b0ceaf..6a7a0bb95301 100644
>> --- a/drivers/net/phy/microchip_rds_ptp.c
>> +++ b/drivers/net/phy/microchip_rds_ptp.c
>> @@ -488,9 +488,6 @@ static int mchp_rds_ptp_hwtstamp_set(struct
>> mii_timestamper *mii_ts, unsigned long flags;
>>   	int rc;
>>   
>> -	clock->hwts_tx_type = config->tx_type;
>> -	clock->rx_filter = config->rx_filter;
>> -
>>   	switch (config->rx_filter) {
>>   	case HWTSTAMP_FILTER_NONE:
>>   		clock->layer = 0;
>> @@ -518,6 +515,15 @@ static int mchp_rds_ptp_hwtstamp_set(struct
>> mii_timestamper *mii_ts, return -ERANGE;
>>   	}
>>   
>> +	switch (config->rx_filter) {
> 
> You want to check tx_type here not rx_filter.

Damn it, copy-paste didn't work well :(

> 
>> +	case HWTSTAMP_TX_ONESTEP_SYNC:
>> +	case HWTSTAMP_TX_ON:
>> +	case HWTSTAMP_TX_OFF:
>> +		break;
>> +	default:
>> +		return -ERANGE;
>> +	}
>> +
> 
> Regards,


