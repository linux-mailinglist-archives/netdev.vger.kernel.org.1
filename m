Return-Path: <netdev+bounces-146754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2386E9D57D7
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 02:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF9B283775
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 01:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F135170A37;
	Fri, 22 Nov 2024 01:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TJdje9J/"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0FC1632ED
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 01:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732240235; cv=none; b=pGdvIexGp9MAu81o7KxCFlzI2viKn2/St4I8dwq0GiLNMp+L/6Jn92M//yuoKZ/7XMCw826SjvfyKYJi3GIEebb01VavjWys4snTiUddXQgGwkb0+ch2uuREvHrxot1S0CNlbOc7TsWtmGTQ9hblQUJ2Dh1ARR6B3IXyjyZ/OZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732240235; c=relaxed/simple;
	bh=cXpDmyn33in5Fa8dyvvfJlLToJhicL+aatcN6whh24Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=cejFJJzR9ma7bPysSIqjdAJFpYciaKMbYalkECVwlBAHoVsIkz+E+27FGXXTleWkBoejXyAn6/bNZUSwe/+7sNZN8bee9xxWjLbckmZ/0SbLVZZcZMaIMuihKV8gej9NSgCM3Ei2pkDWlhKiLebBE82Owbly/DC8YBcQAWVNmKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TJdje9J/; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <acd9c54a-bfaa-44f3-94b3-85442277a65f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732240229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxFBHyCfR1b/b/rcf1vFgtY1e+9LjtgPoQX8t871uJ0=;
	b=TJdje9J/ipd+VMz4LzAHvC28+5aXpUPdi8KvG6J4c2Igx/hsmzExNfkrH+iyOrbhi3Ts9/
	L/bqmj57GhlSK6LDkNHdqWlwiI+0Jswt6IXJndFKr4P233uqJnO0h5jPKmYqLfSn9DXE1w
	8XBmvkHpoJJz/Q4sZsoQNpHeGZZN0KQ=
Date: Thu, 21 Nov 2024 17:50:25 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v1] ice: do not reserve resources for RDMA when
 disabled
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jesse Brandeburg <jesse.brandeburg@linux.dev>
To: "Ertman, David M" <david.m.ertman@intel.com>,
 "jbrandeb@kernel.org" <jbrandeb@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20241114000105.703740-1-jbrandeb@kernel.org>
 <IA1PR11MB619459AFADE5BB3A515C0577DD5B2@IA1PR11MB6194.namprd11.prod.outlook.com>
 <45ce4333-57da-4c32-ad06-c368d90b1328@linux.dev>
Content-Language: en-US
In-Reply-To: <45ce4333-57da-4c32-ad06-c368d90b1328@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/15/24 10:46 AM, Jesse Brandeburg wrote:
> On 11/14/24 10:06 AM, Ertman, David M wrote:
>>>       case ICE_AQC_CAPS_RDMA:
>>> -        caps->rdma = (number == 1);
>>> +        if (IS_ENABLED(CONFIG_INFINIBAND_IRDMA))
>>> +            caps->rdma = (number == 1);
>>>           ice_debug(hw, ICE_DBG_INIT, "%s: rdma = %d\n", prefix,
>>
>> The HW caps struct should always accurately reflect the capabilities 
>> of the HW being probed.  Since this
> 
> why must it accurately reflect the capability of the hardware? The 
> driver state and capability is a reflection of the combination of both, 
> so I'm not sure what the point of your statement.
> 
>> is a kernel configuration (i.e. software) consideration, the more 
>> appropriate approach would be to control
>> the PF flag "ICE_FLAG_RDMA_ENA" based on the kernel CONFIG setting.
> 
> I started making the changes you suggested, but the ICE_FLAG_RDMA_ENA is 
> blindly set by the LAG code, if the cap.rdma is enabled. see 
> ice_set_rdma_cap(). This means the disable won't stick.
> 
> Unless I'm misunderstanding something, ICE_FLAG_RDMA_ENA is used both as 
> a gate and as a state, which is a design issue. This leaves no choice 
> but to implement the way I did in this v1 patch. Do you see any other 
> option to make a simple change that is safe for backporting to stable?

Any comments here Dave?

