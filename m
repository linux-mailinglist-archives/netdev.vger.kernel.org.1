Return-Path: <netdev+bounces-211015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA322B162F6
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 16:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D18418C7E71
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 14:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F532D97A7;
	Wed, 30 Jul 2025 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z1mwff7a"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54F02D662D
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753886397; cv=none; b=UaCQi2PnHBg/3MVsXkPoHY7eW7L4L4roqxRcRDtLlmfNe2i67u3UkXBkgZT55npgKkZAZZRBWvJGkb6XGnSK8N1fVkXquBn+NpqaQICGCjUis4+n7/ZuZaLt3B+ko+pEMiych4EriINaBMN2Z56UPwUJFXCal7lgskdbkFrDudg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753886397; c=relaxed/simple;
	bh=0kFiixHW4qgcnzPziw8EX0Lq6m3LwF24VOms/TwJHFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ch3yV06VJooEfj86ePcvt9YnyXoswsmzhH2/Donm2j2M7+c1jKD5FNPnsuKW2/phDHH6NLrrXBpCQhmGFS5hRkhsPzglDsYoNVeVVrm2keiHHAznEPYc6vm0ViKibMZ75qHX+bU8qAYsgP+wABxlr7VnmuNmJbPIyFnhWf1zd+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z1mwff7a; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f6941817-6be2-400e-bee9-0be075884aa2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753886393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+4H2xiBKW5X0cWt2WZdKgHJgvToyDebbzm/YnZuTIQ=;
	b=Z1mwff7aBKUCInA4WktPHH02b14TVa1a+4f21oXqNUuC2yY1uVQvuPdzQSzbJRFuYu5Jxu
	g68ZeyxPSJG4/bexRebzH+uQUWZm/a37uBeSHgBQ0ziDiALXOCdqKqu7O7COhQJShOA0fx
	+7b/KPPMsC7MaxQ9ulrWlOMT23zNeFQ=
Date: Wed, 30 Jul 2025 15:39:50 +0100
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
 <bb66c931-ac17-4a70-ba11-2a109794b9e2@linux.dev>
 <20250730064419.2588a5e3@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250730064419.2588a5e3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 30/07/2025 14:44, Jakub Kicinski wrote:
> On Wed, 30 Jul 2025 10:18:46 +0100 Vadim Fedorenko wrote:
>>> IDK, 0,0 means all symbols were completely correct.
>>> It may be useful for calculating bit error rate?
>>
>> The standard doesn't have this bin, its value can be potentially
>> deducted from all packets counter.
> 
> We have a number of counters outside of the standard. Here the
> extension is pretty trivial, so I don't see why we'd deprive
> the user of the information HW collects. The translation between
> bytes and symbols is not exact. Not sure we care about exactness
> but, again, trivial to keep the 0,0 bin.
> 
>>> A workaround for having the {-1, -1} sentinel could also be to skip
>>> the first entry:
>>>
>>> 	if (i && !ranges[i].low && !ranges[i].high)
>>> 		break;
>>
>> I was thinking of this way, the problem is that in the core we rely on
>> the driver to provide at least 2 bins and we cannot add any compile-time
>> checks because it's all dynamic.
> 
> 1 bin is no binning, its not a legit use of the histogram API.
> We have a counter for corrected symbols already, that's the "1 bin".

Got it. Ok, I agree, we can keep bin (0,0) as the very first one, I'll
implement it in the way you suggested above

