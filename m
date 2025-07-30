Return-Path: <netdev+bounces-210935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF38B15B5A
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 11:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD503ABDAE
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 09:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6789A255F4C;
	Wed, 30 Jul 2025 09:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="govjFJeD"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F7419BBC
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867138; cv=none; b=Mp1xy1f7lcuDyEIq/yT9zt5B3l1CJXmdNW9+kNt0ZPWACQSMoFGA5rHR2pq+eN70CbsPKslIa3ExXxRQV5CnpINkVIPdk/83KAAk/HDHlvPyn+TnDVmd+TSqOo8KFHtxvyhGgrEh6/vFioDVKkp8fc9J6F2QlHK2Jaxu/HgtoQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867138; c=relaxed/simple;
	bh=qHxnN+p8N/4J+cxhjDNSi04wdr1M2gsZYRjoWDmHqb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vog7PHd6Siwrn5/5gae9CxUA3hcoa2XrnarHRbSL0sD/q4Oq1lzpWzEMwb5cppzybbYDoX8LedNJ8TnIa0CEp+DnPpUxMkP0hZMtrOP3I0/3Re1G37Lh0/Ko983LiaeZsT4061C92yhuQ/tKd3FLQYID2u2cKve6KdCHKYD3V2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=govjFJeD; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bb66c931-ac17-4a70-ba11-2a109794b9e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753867133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VmYBlQQFDG3sZpmVqr5cFhNHXDXlESp4GGVgtRZrgiI=;
	b=govjFJeD4BfWbwfYKN2D0S82Fa3yJlgdQYp6pXamckQuhsH1SG0q/pUo5qVm2MQgkZGKUe
	jflU6UsZUtdNr3rh9wAklaq4Hjl6nk8gX0rlDJT75KOzUTMyTSAHHPYSNpBwmspge2n8D/
	fI3ZR/k6ytyBzeGRYcyc/YHpNtfM/+U=
Date: Wed, 30 Jul 2025 10:18:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH] ethtool: add FEC bins histogramm report
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org,
 Donald Hunter <donald.hunter@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20250729102354.771859-1-vadfed@meta.com>
 <982c780a-1ff1-4d79-9104-c61605c7e802@lunn.ch>
 <1a7f0aa0-47ae-4936-9e55-576cdf71f4cc@linux.dev>
 <9c1c8db9-b283-4097-bb3f-db4a295de2a5@lunn.ch>
 <4270ff14-06cd-4a78-afe7-1aa5f254ebb6@linux.dev>
 <c52af63b-1350-4574-874e-7d6c41bc615d@lunn.ch>
 <424e38be-127d-49d8-98bf-1b4a2075d710@linux.dev>
 <20250729185146.513504e0@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250729185146.513504e0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 30/07/2025 02:51, Jakub Kicinski wrote:
> On Tue, 29 Jul 2025 19:07:59 +0100 Vadim Fedorenko wrote:
>> On 29/07/2025 18:31, Andrew Lunn wrote:
>>>> The only one bin will have negative value is the one to signal the end
>>>> of the list of the bins, which is not actually put into netlink message.
>>>> It actually better to change spec to have unsigned values, I believe.
>>>
>>> Can any of these NICs send runt packets? Can any send packets without
>>> an ethernet header and FCS?
>>>
>>> Seems to me, the bin (0,0) is meaningless, so can could be considered
>>> the end marker. You then have unsigned everywhere, keeping it KISS.
>>
>> I had to revisit the 802.3df-2024, and it looks like you are right:
>> "FEC_codeword_error_bin_i, where i=1 to 15, are optional 32-bit
>> counters. While align_status is true, for each codeword received with
>> exactly i correctable 10-bit symbols"
>>
>> That means bin (0,0) doesn't exist according to standard, so we can use
>> it as a marker even though some vendors provide this bin as part of
>> histogram.
> 
> IDK, 0,0 means all symbols were completely correct.
> It may be useful for calculating bit error rate?

The standard doesn't have this bin, its value can be potentially
deducted from all packets counter.

> 
> A workaround for having the {-1, -1} sentinel could also be to skip
> the first entry:
> 
> 	if (i && !ranges[i].low && !ranges[i].high)
> 		break;

I was thinking of this way, the problem is that in the core we rely on
the driver to provide at least 2 bins and we cannot add any compile-time
checks because it's all dynamic.

