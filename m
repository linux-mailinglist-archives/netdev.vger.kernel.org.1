Return-Path: <netdev+bounces-133032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17F09944EA
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D2B1C21408
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 09:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB3B18BC03;
	Tue,  8 Oct 2024 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BxDKvFJH"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDED718C35A
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381512; cv=none; b=Tmku2nFhYkYrewbB0zoX0dw7xSs0nmQ2gJVYFYgG2KJcTuGuLolUNduzUGWVkg4rtOZ3vW5+YMbfTqaeONd/MWKvuQN8RaZh/Nh+rUG1j/txo2f2X0X8b2XeyFPl+4a6SA0rssuBgDi7239+sjjAj/gb1lUpfyHfBninyanjATI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381512; c=relaxed/simple;
	bh=sB9kstd0TxA9d/DIOEnhvB5iQgrs+RwsAkGLAEaQDeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XeNqaZQDGKHlCpboz2zps31HM8VpeK90jH7ZKNu6adhwLa52ASa1UHyaoqLKFMTY5pGYZokMir+DNV8wOmZ5n3jvLM5Z6IgkKaIJqN6WFLYc2v5dWLe/hlNgtnqx0LCyMNkS8SmTtPJqSszRgT5GohwcfI6yVvmovTdUmi5eXCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BxDKvFJH; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cd571d61-2ad2-4020-ac73-e2db1543d32d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728381507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M+9V/De2M0z5fv/QHuDdiAtrtoSVx1Y201ZCCr8IJ40=;
	b=BxDKvFJHpdo278W8l+PhBa3rdjHNmYnmtLHgaM5bjPp/sI4pUklsjse44h2ySTewH+RZVg
	v4z17QU0qS4OQPfOnOAfWPIFAn31Vg1HPYvEUNpK5Kr8ZzPi4p10Q1U4U9CV9wXnpK3YDM
	G+wbg3NVC4B30e0dzBxMm63Z4in48fo=
Date: Tue, 8 Oct 2024 10:58:24 +0100
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
 <d6d91341-e278-4d3f-967e-3c45f7323878@linux.dev>
 <a8f04d66-5ed5-42e1-9a5a-8cb097769410@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <a8f04d66-5ed5-42e1-9a5a-8cb097769410@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/10/2024 00:51, Jacob Keller wrote:
> 
> 
> On 10/7/2024 3:26 AM, Vadim Fedorenko wrote:
>> On 05/10/2024 00:18, Jacob Keller wrote:
>>> Is there any benefit to implementing anything other than
>>> HWTSTAMP_FILTER_ALL?
>>>
>>> Those are typically considered legacy with the primary reason being to
>>> support hardware which does not support timestamping all frames.
>>>
>>> I suppose if you have measurement that supporting them is valuable (i.e.
>>> because of performance impact on timestamping all frames?) it makes
>>> sense to support. But otherwise I'm not sure its worth the extra complexity.
>>>
>>> Upgrading the filtering modes to HWTSTAMP_FILTER_ALL is acceptable and
>>> is done by a few drivers.
>>
>> Even though the hardware is able to timestamp TX packets at line rate,
>> we would like to avoid having 2x times more interrupts for the cases
>> when we don't need all packets to be timestamped. And as it mentioned
>> in the comment, we don't have very precise HW filters, but we would like
>> to avoid timestamping TCP packets when TCP is the most used one on the
>> host.
> 
> Tx timestamps don't use the filters in the first place. The filter only
> applies to Rx timestamps. You should only initiate a Tx timestamp when
> requested, which will generally not be the case for TCP.
> 
> Are you saying that Rx timestamps generate interrupts?

Sorry for the confusion with TX timestamping.
For RX we will utilize additional buffer to provide timestamp metadata,
and we will have to process this metadata even if it will not be needed
later in the stack. For 100G links that will add some delays which we
would like to avoid.

