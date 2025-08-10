Return-Path: <netdev+bounces-212351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F3BB1F9B5
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 12:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C414E1897D0E
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 10:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F055239E7C;
	Sun, 10 Aug 2025 10:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QQQ37w/Y"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1FE2E36F1
	for <netdev@vger.kernel.org>; Sun, 10 Aug 2025 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754823231; cv=none; b=WF8dYB0bRgDDk/oCrTnsPovCZqYlVH9SyaBz2bJkGsyty7mFzeBJyBo/912fb9zSVg+PCN11T/eSnPxitY8mkFaH7LpPP/Mb5kmloo3R9sLEFPk6j7diVR9WSycr0gv4y0hklXikoOA7okg1M4r2G3A3XM7fUeJrRAZ4kfueZEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754823231; c=relaxed/simple;
	bh=sqHeBdCK1S81WhduKgiYc1nbZR02E0yF7GBV6EoVe/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+rYExeQYwU49A86GJQOGT0X6EUpNen/XiT/SFhyoBcv/IkFHZK+t9ko8oufhbUTWQNL5rlOs1MT/U1bVkhRu7qqwUzj/RGcBPhEqmEZ47KN5ZnEOxIH0Q7Mc/H3in+BV1iRZLPYdhYxAJQTDmkSxW4+Yo6MLYgevMZS9EAo8zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QQQ37w/Y; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ec9e7da6-30f0-40aa-8cb7-bfa0ff814126@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754823226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1OD/fs97lJSnzwe5rHz5qP8Wlog8IOWL6QwAL84Y1g=;
	b=QQQ37w/YI/SfcG3Zp/Hf1ZO5W1fzmDFWZUzGSlKSN1aQWiwobf+1TkHMJAEjVJ0QaqXkBT
	m0z6rGFWi2n+n0G1kQRo4lypAMVR5X9oCtSJlQ1Qbj7wIPik3NhH3I60o8yGPwOZ39/VPl
	+sZ0KwK/wGR5UificM2Z9siE6qpIfJg=
Date: Sun, 10 Aug 2025 11:52:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v4] ethtool: add FEC bins histogramm report
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org,
 Donald Hunter <donald.hunter@gmail.com>, Carolina Jubran
 <cjubran@nvidia.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20250807155924.2272507-1-vadfed@meta.com>
 <20250808131522.0dc26de4@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250808131522.0dc26de4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/08/2025 21:15, Jakub Kicinski wrote:
> On Thu, 7 Aug 2025 08:59:24 -0700 Vadim Fedorenko wrote:
>> +		/* add FEC bins information */
>> +		len += (nla_total_size(0) +  /* _A_FEC_HIST */
>> +			nla_total_size(4) +  /* _A_FEC_HIST_BIN_LOW */
>> +			nla_total_size(4) +  /* _A_FEC_HIST_BIN_HI */
>> +			/* _A_FEC_HIST_BIN_VAL + per-lane values */
>> +			nla_total_size_64bit(sizeof(u64) *
>> +					     (1 + ETHTOOL_MAX_LANES))) *
> 
> That's the calculation for basic stats because they are reported as a
> raw array. Each nla_put() should correspond to a nla_total_size().
> This patch nla_put()s things individually.
> 
>> +			ETHTOOL_FEC_HIST_MAX;
>> +	}
>>   
>>   	return len;
>>   }
>>   
>> +static int fec_put_hist(struct sk_buff *skb, const struct ethtool_fec_hist *hist)
>> +{
>> +	const struct ethtool_fec_hist_range *ranges = hist->ranges;
>> +	const struct ethtool_fec_hist_value *values = hist->values;
>> +	struct nlattr *nest;
>> +	int i, j;
>> +
>> +	if (!ranges)
>> +		return 0;
>> +
>> +	for (i = 0; i < ETHTOOL_FEC_HIST_MAX; i++) {
>> +		if (i && !ranges[i].low && !ranges[i].high)
>> +			break;
>> +
>> +		if (WARN_ON_ONCE(values[i].bin_value == ETHTOOL_STAT_NOT_SET))
>> +			break;
>> +
>> +		nest = nla_nest_start(skb, ETHTOOL_A_FEC_STAT_HIST);
>> +		if (!nest)
>> +			return -EMSGSIZE;
>> +
>> +		if (nla_put_u32(skb, ETHTOOL_A_FEC_HIST_BIN_LOW,
>> +				ranges[i].low) ||
>> +		    nla_put_u32(skb, ETHTOOL_A_FEC_HIST_BIN_HIGH,
>> +				ranges[i].high) ||
>> +		    nla_put_uint(skb, ETHTOOL_A_FEC_HIST_BIN_VAL,
>> +				 values[i].bin_value))
>> +			goto err_cancel_hist;
>> +		for (j = 0; j < ETHTOOL_MAX_LANES; j++) {
>> +			if (values[i].bin_value_per_lane[j] == ETHTOOL_STAT_NOT_SET)
>> +				break;
>> +			nla_put_uint(skb, ETHTOOL_A_FEC_HIST_BIN_VAL_PER_LANE,
>> +				     values[i].bin_value_per_lane[j]);
> 
> TBH I'm a bit unsure if this is really worth breaking out into
> individual nla_puts(). We generally recommend that, but here it's
> an array of simple ints.. maybe we're better of with a binary / C
> array of u64. Like the existing FEC stats but without also folding
> the total value into index 0.

Well, the current implementation is straight forward. Do you propose to
have drivers fill in the amount of lanes they have histogram for, or
should we always put array of ETHTOOL_MAX_LANES values and let
user-space to figure out what to show?

