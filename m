Return-Path: <netdev+bounces-145972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDE69D1718
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 18:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8276EB23F2E
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1874A1A01B3;
	Mon, 18 Nov 2024 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z0vICdKI"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3841D199EA3
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731950671; cv=none; b=YJFBaEfs4K4vit8kgjn8s9oxavxqOmzOTZlQu6qNDrZbwQPZELJ78w2QYnmlEZzhdGQCRPqaBju9pUObAqt5GzeQfrHqjsf5GthvQtnMkWNz/ja0BMGD0VurP2QyruZEM+bVx0NcBsu5cT2NRKoymME3TRij8Ca1d+TJTBQQo0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731950671; c=relaxed/simple;
	bh=p7Cxv97VIV/7CQGh+QYxHAG4oaknMrQ30qV3y0x4vUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5urV1XFX9Uk0rwwMgiyssplCDYO2iMyNmINa9OmIkDheZEUYgMqRg5aLwiAPnDjG0Uh2cB+eHx2FVqHxyyTGFab9H5kEJwSfOjcVhU8aLhKW+fWkcLBbjQaK8dS56FhhKqpr9MxkqVOaLiRY9z4JNwoaMb12Byk/gz7kiBVx4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z0vICdKI; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <82643a3a-e71d-4fb9-a65f-43e6af195112@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731950664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rUXx7AHuL5dCXpI2cGqfImWmgJC3Jxc0yzSlNk/JcyE=;
	b=Z0vICdKIL4FoxAIhKzQmCluuWuCPYsObPbxRM0Jls0GTbzNtalDUwdsY1lvUyr8NIO2eGi
	roypuSLDTd8F9jcK8v9pAcYWOueQUiyx4qdDqTN1Nh0yuXV/MZbAk4j1iLHUW200nSHCu5
	Y0y6K2ZBYnAFn5CSfQ0ymKWB/9PN7F4=
Date: Mon, 18 Nov 2024 09:24:18 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH iwl-net 08/10] idpf: add Tx timestamp flows
To: "Olech, Milena" <milena.olech@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "Hay, Joshua A" <joshua.a.hay@intel.com>,
 "Lobakin, Aleksander" <aleksander.lobakin@intel.com>
References: <20241113154616.2493297-1-milena.olech@intel.com>
 <20241113154616.2493297-9-milena.olech@intel.com>
 <2dc0096d-93be-42f9-b646-e74c3b36126c@linux.dev>
 <PH7PR11MB5885BBAC43E3D85550852C278E272@PH7PR11MB5885.namprd11.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <PH7PR11MB5885BBAC43E3D85550852C278E272@PH7PR11MB5885.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18/11/2024 07:07, Olech, Milena wrote:
> On 11/14/2024 1:52 PM, Vadim Fedorenko wrote:
> 
>> On 13/11/2024 15:46, Milena Olech wrote:
>>> Add functions to request Tx timestamp for the PTP packets, read the Tx
>>> timestamp when the completion tag for that packet is being received,
>>> extend the Tx timestamp value and set the supported timestamping modes.
>>>
>>> Tx timestamp is requested for the PTP packets by setting a TSYN bit and
>>> index value in the Tx context descriptor. The driver assumption is that
>>> the Tx timestamp value is ready to be read when the completion tag is
>>> received. Then the driver schedules delayed work and the Tx timestamp
>>> value read is requested through virtchnl message. At the end, the Tx
>>> timestamp value is extended to 64-bit and provided back to the skb.
>>>
>>> Co-developed-by: Josh Hay <joshua.a.hay@intel.com>
>>> Signed-off-by: Josh Hay <joshua.a.hay@intel.com>
>>> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>> Signed-off-by: Milena Olech <milena.olech@intel.com>

[skipped]

>>> +/**
>>> + * idpf_ptp_extend_ts - Convert a 40b timestamp to 64b nanoseconds
>>> + * @adapter: Driver specific private structure
>>> + * @in_tstamp: Ingress/egress timestamp value
>>> + *
>>> + * It is assumed that the caller verifies the timestamp is valid prior to
>>> + * calling this function.
>>> + *
>>> + * Extract the 32bit nominal nanoseconds and extend them. Use the cached PHC
>>> + * time stored in the device private PTP structure as the basis for timestamp
>>> + * extension.
>>> + *
>>> + * Return: Tx timestamp value extended to 64 bits.
>>> + */
>>> +u64 idpf_ptp_extend_ts(const struct idpf_adapter *adapter, u64 in_tstamp)
>>> +{
>>> +	unsigned long discard_time;
>>> +
>>> +	discard_time = adapter->ptp->cached_phc_jiffies + 2 * HZ;
>>> +
>>> +	if (time_is_before_jiffies(discard_time))
>>> +		return 0;
>>
>> It might be a good idea to count such events, just to provide at least
>> some information to the client regarding zero timestamp?
> 
> You mean to calculate skipped Tx timestamps?

Yes, we have special metric in ethtool to provide info about issues with
TX timestamp, it would be great to have idpf implemented this interface.

> 
>>
>>> +
>>> +	return idpf_ptp_tstamp_extend_32b_to_64b(adapter->ptp->cached_phc_time,
>>> +						 lower_32_bits(in_tstamp));
>>> +}
>>
>>
>> [... skip ...]
> 
> Thanks,
> Milena


