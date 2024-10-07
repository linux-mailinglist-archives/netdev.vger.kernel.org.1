Return-Path: <netdev+bounces-132628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB6199288A
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 11:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C731F23E70
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 09:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4BD1BBBD2;
	Mon,  7 Oct 2024 09:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j72V6fRe"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD0A1BA862
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728295015; cv=none; b=GN+5ZnOA3Qnc5qNWou020ild1dzjJA2B3FZgVtPbHBwqwt1ddYxWW+6wpG8BdgNMkXlVvcsyiqe/R2wMnAEFPiXkT9Z1N4nyQk7vt1rclC57V3k7u+XY50BhfvLx/UR74R0PFdM7Bl/45AwYqhqW2S+FuYq5Nw1Iaiz1OtUUSu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728295015; c=relaxed/simple;
	bh=bGXPJNPZ9bbivmMFlovfROrjazfAe8iawaLYrNfE2k4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+nAZyvE4NrNbWEYCTmzebpSzCvg2I1v7wtezqck/xdZaE4ZwLcBAGTJ/icOvuj/CwJjyqNgwiAyyo+v2jyXu1aIrTb8XnWokFjpH0YvLt5Pb5E5SL2LHiYvsLtZHbYKvJ+CmGPcZTxdROHWrvhBVb4H0UJQF8ktPxgxIg9HgXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j72V6fRe; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ac195016-a05a-4757-9876-94d076937af7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728295009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6slEjR74uKJlOpAJ51VDLSo02Voe1Vq0sLlNh4SQ+4Y=;
	b=j72V6fReEyOZKN53Er3c/nhLT7Dz7CZi7Qm2Fk8M44gxZgeZLDCvpEVKMWt1dPuxxqBn3A
	K0PFedaBWtEdFvfOe/cbl0Dqw3npkBev+cajXrsHthsAMydOoMzKgRe3m7vFDuVTLSIaKp
	a9MiA33E4QJj+TGZUDRPaC9oN9qZgI0=
Date: Mon, 7 Oct 2024 10:56:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 1/5] eth: fbnic: add software TX timestamping
 support
To: Jacob Keller <jacob.e.keller@intel.com>, Vadim Fedorenko
 <vadfed@meta.com>, Jakub Kicinski <kuba@kernel.org>,
 David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Alexander Duyck <alexanderduyck@fb.com>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>
References: <20241003123933.2589036-1-vadfed@meta.com>
 <20241003123933.2589036-2-vadfed@meta.com>
 <57d913bb-a320-4885-9477-a2e287f3f027@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <57d913bb-a320-4885-9477-a2e287f3f027@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 04/10/2024 23:55, Jacob Keller wrote:
> 
> 
> On 10/3/2024 5:39 AM, Vadim Fedorenko wrote:
>> Add software TX timestamping support. RX software timestamping is
>> implemented in the core and there is no need to provide special flag
>> in the driver anymore.
>>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
>>   drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c | 11 +++++++++++
>>   drivers/net/ethernet/meta/fbnic/fbnic_txrx.c    |  3 +++
>>   2 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
>> index 5d980e178941..ffc773014e0f 100644
>> --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
>> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
>> @@ -6,6 +6,16 @@
>>   #include "fbnic_netdev.h"
>>   #include "fbnic_tlv.h"
>>   
>> +static int
>> +fbnic_get_ts_info(struct net_device *netdev,
>> +		  struct kernel_ethtool_ts_info *tsinfo)
>> +{
>> +	tsinfo->so_timestamping =
>> +		SOF_TIMESTAMPING_TX_SOFTWARE;
>> +
>> +	return 0;
>> +}
>> +
> 
> You could use ethtool_op_get_ts_info(), but I imagine future patches
> will update this for hardware timestamping, so I don't think thats a big
> deal.
> 
> I think you *do* still want to report SOF_TIMESTAMPING_RX_SOFTWARE and
> SOF_TIMESTAMPING_SOFTWARE to get the API correct... Perhaps that could
> be improved in the core stack though.... Or did that already get changed
> recently?

Yeah, as you found in the next mail, software RX timestamping was moved
to the core recently.

> You should also set phc_index to -1 until you have a PTP clock device.

That's definitely missing, thanks! I'll add it to the next version.

> 
>>   static void
>>   fbnic_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
>>   {
>> @@ -66,6 +76,7 @@ fbnic_get_eth_mac_stats(struct net_device *netdev,
>>   
>>   static const struct ethtool_ops fbnic_ethtool_ops = {
>>   	.get_drvinfo		= fbnic_get_drvinfo,
>> +	.get_ts_info		= fbnic_get_ts_info,
>>   	.get_eth_mac_stats	= fbnic_get_eth_mac_stats,
>>   };
>>   
>> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
>> index 6a6d7e22f1a7..8337d49bad0b 100644
>> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
>> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
>> @@ -205,6 +205,9 @@ fbnic_tx_map(struct fbnic_ring *ring, struct sk_buff *skb, __le64 *meta)
>>   
>>   	ring->tail = tail;
>>   
>> +	/* Record SW timestamp */
>> +	skb_tx_timestamp(skb);
>> +
>>   	/* Verify there is room for another packet */
>>   	fbnic_maybe_stop_tx(skb->dev, ring, FBNIC_MAX_SKB_DESC);
>>   
> 


