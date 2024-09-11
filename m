Return-Path: <netdev+bounces-127535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4565E975B08
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 21:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59DFA1C21B2C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 19:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5EC1B4C56;
	Wed, 11 Sep 2024 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m/iPmynf"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC301BA26A
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 19:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726084202; cv=none; b=JuXWx+UF7wsuMo+9bmygcJseRGK0BLqiYNJPdThhxgn3BcozJ4u8aXU6PxJfex/H7s2K7PnJJXxeYpvNNesgnqRXb1yYAF3jQMcF3trImt5EfSY9ExqtxFuNbD6CkX+Ry6MOPq+aGK1GDVOy+53o58SQaKCmal0VKO/iYUyY+n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726084202; c=relaxed/simple;
	bh=AZW0+DV+RzwvIKs6hhRTsk4aECYNvYcz1nk4vkWdZrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OUuaDLPwSRCXuMijofJZdwaXEhHiK+jX/oftnQ8p4h5pBAnJcTkveWcr00dN0qnwH66sO5fcyYhVMPFZaDe9rm+jC3LC4JkYEdmFl5YdZYe9y7QN1nhEsRVvlN3vebFbLI4d4a6nVM4T4CVC22xkSOSRrk3XgW+kJhxRCaAIiiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m/iPmynf; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c1003a1b-cf6f-4332-b0c7-5461a164097e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726084197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6PtIzQSr8OEpG98Dbie2vA/FaByJ+h1HpVwHV7nlfu8=;
	b=m/iPmynfJPa63Hb5+7L2gyZOz7H+5Z9zvPn1dPLirWooIOLW1cMN58C8Nfps+9lQIKWb/9
	FTnjC1oWARZjwuCUoDDjM4uwlP2j0wjzC1e+toOgwIFMqXgDPEPrAwno7Xlo/kXc8NoMWo
	XAaW7J/8KqH0GLGV0eDHHVVIALCOweo=
Date: Wed, 11 Sep 2024 20:49:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/5] eth: fbnic: add initial PHC support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Alexander Duyck <alexanderduyck@fb.com>, netdev@vger.kernel.org
References: <20240911124513.2691688-1-vadfed@meta.com>
 <20240911124513.2691688-3-vadfed@meta.com>
 <006042c0-e1d5-4fbc-aa7f-94a74cfbef0e@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <006042c0-e1d5-4fbc-aa7f-94a74cfbef0e@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/09/2024 17:25, Andrew Lunn wrote:
> It appears that Richard has not been Cc:ed.

Ah, will do it in v2 for sure

>> +/* FBNIC timing & PTP implementation
>> + * Datapath uses truncated 40b timestamps for scheduling and event reporting.
>> + * We need to promote those to full 64b, hence we periodically cache the top
>> + * 32bit of the HW time counter. Since this makes our time reporting non-atomic
>> + * we leave the HW clock free running and adjust time offsets in SW as needed.
>> + * Time offset is 64bit - we need a seq counter for 32bit machines.
>> + * Time offset and the cache of top bits are independent so we don't need
>> + * a coherent snapshot of both - READ_ONCE()/WRITE_ONCE() + writer side lock
>> + * are enough.
>> + *
>> + * TBD: alias u64_stats_sync & co. with some more appropriate names upstream.
> 
> This is upstream, so maybe now is a good time to decide?

That's good question. Do we need another set of helpers just because of 
names? Obviously, the internals will be the same sequence magic.

