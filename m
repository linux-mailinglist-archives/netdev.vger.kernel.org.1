Return-Path: <netdev+bounces-132633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB05992931
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 12:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9AA1C22F20
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 10:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E70D1BA874;
	Mon,  7 Oct 2024 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ExmkQURw"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245211B9854
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296797; cv=none; b=VwiayReTNcYiwInOP16Nninlrr/9qx0fiB4AaAVhuQn6/VIQFMU7xjZKMqKGJSbHN3GKYMj52B1ScY9OUUivFqPW/Bq8jQwnZM41U04liyF78q8LUp/4AM73pu/RFxaAkbihCwfsBrQeQwSUrXmTLbTogY/rjhtso7bXOJuyyc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296797; c=relaxed/simple;
	bh=2xY0b0CZZBBzKNneQ5Wd97uT1bSmv4rjyM5XLAiW5bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJgc8FbHGHo/wYF7hG6iSmCghjX+pEvwD4nEX/86S+93qte5bKfK6DF/yRyPn+ILgw5fGNLIwaV93VmHV3fAFwZThSAlmoCwHJIMrP5GM2s2F/EacYIGY1fNTvGJDxitSTzF5ENIuWY2saC+ixyi5HxuD2TM97riQzf4ZE/ngr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ExmkQURw; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d6d91341-e278-4d3f-967e-3c45f7323878@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728296793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8UEedaZu4yvV7GUL+y/5aFYMFIGvJEckeLlm6LZgu8=;
	b=ExmkQURwNPALWo4TWaA/SIQBcv2w9jgnc6IzfW2I8xJjZdN0JXdEVtHqUM2f3udo3GA51e
	pZ8m+5OiMawDT+MeVyfzzESmxMvabv3AWn+YTLltzR+Z3Qj3IsxZA5inmuEbHjB1SqL44g
	kvUtonYylQmM408k66mQjMtJIhSlmV4=
Date: Mon, 7 Oct 2024 11:26:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 3/5] eth: fbnic: add RX packets timestamping
 support
To: Jacob Keller <jacob.e.keller@intel.com>, Vadim Fedorenko
 <vadfed@meta.com>, Jakub Kicinski <kuba@kernel.org>,
 David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Alexander Duyck <alexanderduyck@fb.com>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>
References: <20241003123933.2589036-1-vadfed@meta.com>
 <20241003123933.2589036-4-vadfed@meta.com>
 <6015e3d3-e35b-4e6c-b6cf-3348e8b6d4f6@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <6015e3d3-e35b-4e6c-b6cf-3348e8b6d4f6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/10/2024 00:18, Jacob Keller wrote:
> 
> 
> On 10/3/2024 5:39 AM, Vadim Fedorenko wrote:
>> Add callbacks to support timestamping configuration via ethtool.
>> Add processing of RX timestamps.
>>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
>> +static int fbnic_hwtstamp_set(struct net_device *netdev,
>> +			      struct kernel_hwtstamp_config *config,
>> +			      struct netlink_ext_ack *extack)
>> +{
>> +	struct fbnic_net *fbn = netdev_priv(netdev);
>> +	int old_rx_filter;
>> +
>> +	if (config->source != HWTSTAMP_SOURCE_NETDEV)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (!kernel_hwtstamp_config_changed(config, &fbn->hwtstamp_config))
>> +		return 0;
>> +
>> +	/* Upscale the filters */
>> +	switch (config->rx_filter) {
>> +	case HWTSTAMP_FILTER_NONE:
>> +	case HWTSTAMP_FILTER_ALL:
>> +	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
>> +	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
>> +	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
>> +	case HWTSTAMP_FILTER_PTP_V2_EVENT:
>> +		break;
>> +	case HWTSTAMP_FILTER_NTP_ALL:
>> +		config->rx_filter = HWTSTAMP_FILTER_ALL;
>> +		break;
>> +	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
>> +	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
>> +		config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
>> +		break;
>> +	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
>> +	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
>> +		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
>> +		break;
>> +	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
>> +	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
>> +		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
>> +		break;
>> +	case HWTSTAMP_FILTER_PTP_V2_SYNC:
>> +	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
>> +		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
>> +		break;
>> +	default:
>> +		return -ERANGE;
>> +	}
>> +
>> +	/* Configure */
>> +	old_rx_filter = fbn->hwtstamp_config.rx_filter;
>> +	memcpy(&fbn->hwtstamp_config, config, sizeof(*config));
>> +
>> +	if (old_rx_filter != config->rx_filter && netif_running(fbn->netdev)) {
>> +		fbnic_rss_reinit(fbn->fbd, fbn);
>> +		fbnic_write_rules(fbn->fbd);
>> +	}
>> +
>> +	/* Save / report back filter configuration
>> +	 * Note that our filter configuration is inexact. Instead of
>> +	 * filtering for a specific UDP port or L2 Ethertype we are
>> +	 * filtering in all UDP or all non-IP packets for timestamping. So
>> +	 * if anything other than FILTER_ALL is requested we report
>> +	 * FILTER_SOME indicating that we will be timestamping a few
>> +	 * additional packets.
>> +	 */
> 
> Is there any benefit to implementing anything other than
> HWTSTAMP_FILTER_ALL?
> 
> Those are typically considered legacy with the primary reason being to
> support hardware which does not support timestamping all frames.
> 
> I suppose if you have measurement that supporting them is valuable (i.e.
> because of performance impact on timestamping all frames?) it makes
> sense to support. But otherwise I'm not sure its worth the extra complexity.
> 
> Upgrading the filtering modes to HWTSTAMP_FILTER_ALL is acceptable and
> is done by a few drivers.

Even though the hardware is able to timestamp TX packets at line rate,
we would like to avoid having 2x times more interrupts for the cases
when we don't need all packets to be timestamped. And as it mentioned
in the comment, we don't have very precise HW filters, but we would like
to avoid timestamping TCP packets when TCP is the most used one on the
host.

