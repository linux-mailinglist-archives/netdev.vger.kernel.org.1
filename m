Return-Path: <netdev+bounces-211390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809F9B1881C
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 22:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B705443DE
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 20:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAC621B9E0;
	Fri,  1 Aug 2025 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AD7/PbQs"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A666A21ABC9
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754080103; cv=none; b=d62cG3C9rnajcxYDhmt3NMYdBWA1sMgeppSkNJew7A27+/pkivlePz1PNfklcZY1xROs6YTQ/ppeUJ6ijjWq5IA26KC5OhCHCDiJt4lOfQuF5wcZNYGlO4hRdcJPyWWwSqT5e2UkILrQZ0RPYXlTrVtVW9yIj2VEKjXaR1+Av40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754080103; c=relaxed/simple;
	bh=4ib4+xzsHC1/0TZhWE3BN4v1BckJxywhLUIMY9sPQWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Df9uJ7c+74Bv9yuCJYT9KwZ3lmbYOjO0BMaj1+eMeFaBnJOKHUnxoArHq6uo04yh1/Aeguy/2vl6X+7j9A2fSplWoQ5ZJNgUZFiVT42ShjFovTDeMBo+DT3LYRsPTYV7PHfmi3OScvWYcTe2NweRwedg2hMmEZo6sfnyxfbBWwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AD7/PbQs; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7e995c4d-8245-4e47-88fb-6a735dbc0dda@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754080100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9HGI5G6xJ5gNX1PxU74iWvEIs3HCLmfr9kJA+OqtV40=;
	b=AD7/PbQs7GfdEHxJLn0x2lH4HKdmbtOyabwBdhMLWEyeBLlx66GYyQeUv9sengG0PMOrjm
	EJnQQoMM/lgTEHwwECiKyQY3lsW0sQlVl4mowjvb6bwwWZzYGY3WyXlYIBaMMLv58Bh73M
	eHTOjVfq9lw8E+zxgsGjZtPs8tJDu0o=
Date: Fri, 1 Aug 2025 21:28:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v2] ethtool: add FEC bins histogramm report
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org,
 Donald Hunter <donald.hunter@gmail.com>, Carolina Jubran
 <cjubran@nvidia.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20250731231019.1809172-1-vadfed@meta.com>
 <20250801130648.341995ba@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250801130648.341995ba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 01/08/2025 21:06, Jakub Kicinski wrote:
> On Thu, 31 Jul 2025 16:10:19 -0700 Vadim Fedorenko wrote:
>> - remove sentinel (-1, -1) and use (0, 0) as common array break.
>>    bin (0, 0) is still possible but only as a first element of
>>    ranges array
> 
> I don't see this change in the diff? It's still -1,-1
> 
> Also, not seeing per-lane support here.

My bad, didn't commit after testing :(
I'll wait 24h and submit v3...


>> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
>> index 1063d5d32fea2..69779b51f1dfd 100644
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
>> +        type: uint
>> +      -
>> +        name: fec-hist-bin-high
>> +        type: uint
> 
> The bounds can be u32, TBH. The value really is a u16 but we don't want
> to waste space on padding in Netlink. Still, no need to go all the way
> to uint.

Got it

>> +        name: fec-hist-bin-val
>> +        type: uint


