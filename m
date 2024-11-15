Return-Path: <netdev+bounces-145365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C869CF4A9
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A371B3022E
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 18:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F311D90DF;
	Fri, 15 Nov 2024 18:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a3aSdSCB"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126FF1D8E07
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 18:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731696406; cv=none; b=WwjIacCUPKj50iS3LDCZq9tiUdpKWCr297LT+cMWVtzYtMxWM3lC17MzBhB7emZs+o0z8B78OQIa4x8U+TFUeG/54jXh1dEK2uPCzmZUxlAGwPi1LND/4zLIrErJI744Ci1Dtl73k/7BpjBYb/LLbK3mPHH/WDYI1hTO2yRoxKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731696406; c=relaxed/simple;
	bh=UMZsuqIXsMNjrLrBmRM6NB3tbO9w54frE/n64st8XFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNv+UnoVmNzDRgNAkhORhUAv7Chx0+KUid4bu4TIvwStuq9OpxSRvaHr5pPcDsh+DzUkdVe/qcqYJt1Itbf46atuUfSUkR7Lgrwu1dOIAPJrf64R6gi4e8v003P9afRWRqsRTgrCtowXqmKi8pRhMzM4uFyuW5RxSBjUCjwlrpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a3aSdSCB; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <45ce4333-57da-4c32-ad06-c368d90b1328@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731696401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Ek8GZMqSIHsbViNoOmI/afu8qDdzMVOCvqTdcyOFGw=;
	b=a3aSdSCBDEfbuHo20XXAjfSzxgH0naWNRG5aRe8DOIKWSvHNMhTJRRdHbO/i0Ih3akEBES
	LOUEAX2eR42bRGlkJTruanZCRku7uKChPbOwJVtwEecYMmTzBh6v/InGWZ0nL9oALBozlR
	DRlAZ9uCJpzBKW6x5XC4Cr9bsa+VybQ=
Date: Fri, 15 Nov 2024 10:46:33 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v1] ice: do not reserve resources for RDMA when
 disabled
To: "Ertman, David M" <david.m.ertman@intel.com>,
 "jbrandeb@kernel.org" <jbrandeb@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20241114000105.703740-1-jbrandeb@kernel.org>
 <IA1PR11MB619459AFADE5BB3A515C0577DD5B2@IA1PR11MB6194.namprd11.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jesse Brandeburg <jesse.brandeburg@linux.dev>
In-Reply-To: <IA1PR11MB619459AFADE5BB3A515C0577DD5B2@IA1PR11MB6194.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/14/24 10:06 AM, Ertman, David M wrote:
>>   	case ICE_AQC_CAPS_RDMA:
>> -		caps->rdma = (number == 1);
>> +		if (IS_ENABLED(CONFIG_INFINIBAND_IRDMA))
>> +			caps->rdma = (number == 1);
>>   		ice_debug(hw, ICE_DBG_INIT, "%s: rdma = %d\n", prefix,
> 
> The HW caps struct should always accurately reflect the capabilities of the HW being probed.  Since this

why must it accurately reflect the capability of the hardware? The 
driver state and capability is a reflection of the combination of both, 
so I'm not sure what the point of your statement.

> is a kernel configuration (i.e. software) consideration, the more appropriate approach would be to control
> the PF flag "ICE_FLAG_RDMA_ENA" based on the kernel CONFIG setting.

I started making the changes you suggested, but the ICE_FLAG_RDMA_ENA is 
blindly set by the LAG code, if the cap.rdma is enabled. see 
ice_set_rdma_cap(). This means the disable won't stick.

Unless I'm misunderstanding something, ICE_FLAG_RDMA_ENA is used both as 
a gate and as a state, which is a design issue. This leaves no choice 
but to implement the way I did in this v1 patch. Do you see any other 
option to make a simple change that is safe for backporting to stable?

Thanks,
Jesse

