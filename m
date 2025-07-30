Return-Path: <netdev+bounces-210937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EA5B15B6E
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 11:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C50179E9E
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 09:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195212701AB;
	Wed, 30 Jul 2025 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OYO6I5Y2"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A776F26F477
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867368; cv=none; b=qBlppuSBU+eNXn1XmTPXig75MPv8aSNXdepCVTT1mViu4brjxPfSfZok9CZpgU116NAsgmvGbZhQgjWpaJeb388p8b1Npv7MuPYbhURvnQtYMuKW2fvbwDwR3HOS3+7svwo+3SDLKk8aS33fUmzzP1LivvUJ+T57+F18Ibp+rZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867368; c=relaxed/simple;
	bh=0g6yrhcHleSYoJQFukFLDCb6sos/Nm01PM+MbE7gxiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RC+0o+03dyfVWlhrDhzD8DxY+dejTbYGMY7MosaE7RhMKLdvV29gHx2lWP23Pb4KKCwkKGHRHYvwBEDve19eXpbubPSiI9VhXaFNfWZGMfwtWOTZjaew+HcEFr+IWzELmKFrVJaLi2fR3l05aumCqPZ7GTjZoSAPDZCG7B9vvyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OYO6I5Y2; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <15ca2392-1dbd-4f4d-a478-3d8edc32bc90@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753867361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtrloE9sFpUz4h4rprIGtpQUhs6s4RahC3fvX1JZSkY=;
	b=OYO6I5Y2fAu0bstwMe43ByGLLWKHievWt+034SohhkqtNmRH2hqsj8WL126qhCJAAfaW4W
	L5ZUAaGYvyGAnNTo6k14Xmeo9Bcy9nCyKqY2OR8+dS+/G/oSrSJ/YTM8dg8yRsrnyYmrWv
	RFSFRyzu/0SCSpt6VRQTTSDe5bxC1GA=
Date: Wed, 30 Jul 2025 10:22:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH] ethtool: add FEC bins histogramm report
To: Jakub Kicinski <kuba@kernel.org>, Vadim Fedorenko <vadfed@meta.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org,
 Donald Hunter <donald.hunter@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20250729102354.771859-1-vadfed@meta.com>
 <20250729184529.149be2c3@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250729184529.149be2c3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 30/07/2025 02:45, Jakub Kicinski wrote:
> On Tue, 29 Jul 2025 03:23:54 -0700 Vadim Fedorenko wrote:
>> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
>> index 1063d5d32fea2..3781ced722fee 100644
>> --- a/Documentation/netlink/specs/ethtool.yaml
>> +++ b/Documentation/netlink/specs/ethtool.yaml
>> @@ -1239,6 +1239,30 @@ attribute-sets:
>>           name: corr-bits
>>           type: binary
>>           sub-type: u64
>> +      -
>> +        name: hist
>> +        type: nest
>> +        multi-attr: True
>> +        nested-attributes: fec-hist
>> +      -
>> +        name: fec-hist-bin-low
>> +        type: s32
>> +      -
>> +        name: fec-hist-bin-high
>> +        type: s32
>> +      -
>> +        name: fec-hist-bin-val
>> +        type: u64
>> +  -
>> +    name: fec-hist
>> +    subset-of: fec-stat
> 
> no need to make this a subset, better to make it its own attr set

like a set for general histogram? or still fec-specific?

> 
>> +    attributes:
>> +      -
>> +        name: fec-hist-bin-low
>> +      -
>> +        name: fec-hist-bin-high
>> +      -
>> +        name: fec-hist-bin-val
>>     -
>>       name: fec
>>       attr-cnt-name: __ethtool-a-fec-cnt
> 
>> +static const struct ethtool_fec_hist_range netdevsim_fec_ranges[] = {
>> +	{  0,  0},
>> +	{  1,  3},
>> +	{  4,  7},
>> +	{ -1, -1}
>> +};
> 
> Let's add a define for the terminating element?

I believe it's about (-1, -1) case. If we end up using (0, 0) then there
is no need to define anything, right?

> 
>> +/**
>> + * struct ethtool_fec_hist_range - byte range for FEC bins histogram statistics
> 
> byte range? thought these are bit errors..
> 
>> + * sentinel value of { -1, -1 } is used as marker for end of bins array
>> + * @low: low bound of the bin (inclusive)
>> + * @high: high bound of the bin (inclusive)
>> + */
> 
>> +		len += nla_total_size_64bit(sizeof(u64) * ETHTOOL_FEC_HIST_MAX);
> 
> I don't think it's right, each attr is its own nla_total_size().
> Add a nla_total_size(8) to the calculation below

got it

> 
>> +		/* add FEC bins information */
>> +		len += (nla_total_size(0) +  /* _A_FEC_HIST */
>> +			nla_total_size(4) +  /* _A_FEC_HIST_BIN_LOW */
>> +			nla_total_size(4)) * /* _A_FEC_HIST_BIN_HI */
>> +			ETHTOOL_FEC_HIST_MAX;


