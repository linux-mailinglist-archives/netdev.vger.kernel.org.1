Return-Path: <netdev+bounces-236985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5624FC42CFB
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 13:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 380974E05E5
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 12:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637CC20FAB2;
	Sat,  8 Nov 2025 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wnwlRTrz"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0191B81D3
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762605513; cv=none; b=aR06H9ap70j0e8dRF6q8zepiN3QrVbgJa066x05mn76FCkrbXl2RdtNO6Pam92Yz7HzxZGGclFKXxT1pARMQ94lyBCM0Nd/PHF9/cmBnh6XWxAFNd3HlGBiwvPx0WVyPwgpmdzHz/Et2qOzhsOHLg1wLcJeGgHsTYgCdmBYGXQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762605513; c=relaxed/simple;
	bh=MYHYN5qzKXop9lvGaSibS7GcQ0sNR05ozHuJQIlbfQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/9DSAU/TJKmyIFMlPngU0oln3TdQX17JMkUQ2byyG30wzzcrkWxWBL+Wd2QquObOwB4OxsNhCYZ65dGX7tfzi16XL5xuhJmOvnO6tyssP47lBCoLdj/Ht7+w4eOTG24enIHVcjFLNqZmIT41Lt68TKrSZl8c4NtBOERPxEDw0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wnwlRTrz; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dd7258b4-266f-420a-b751-4429772a47b5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762605508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aFwgmMZpF46H1YJT1vv08j5XXEeGRW9anj5W6TnLCUA=;
	b=wnwlRTrzb0myArXED9YZ/rMZyo1meKBFMCBV3Rv5ul7YGzqwi7Nwjm3dVUc7usVu3/0oqP
	9omcznAdlayoeWq5OM+Q1gG7P9+DZAVaGlU+JxF9ANJjv13JVebZyrBwXS4yVrnuJhLpU4
	50dg9vnjKx9jsZsw7PqeTj+C0iCnBDc=
Date: Sat, 8 Nov 2025 12:38:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 1/2] bnx2x: convert to use ndo_hwtstamp
 callbacks
To: Jakub Kicinski <kuba@kernel.org>
Cc: Manish Chopra <manishc@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 Kory Maincent <kory.maincent@bootlin.com>, netdev@vger.kernel.org
References: <20251106213717.3543174-1-vadim.fedorenko@linux.dev>
 <20251106213717.3543174-2-vadim.fedorenko@linux.dev>
 <20251107184102.65b0f765@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251107184102.65b0f765@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/11/2025 02:41, Jakub Kicinski wrote:
> On Thu,  6 Nov 2025 21:37:16 +0000 Vadim Fedorenko wrote:
>> +	switch (config->tx_type) {
>> +	case HWTSTAMP_TX_ONESTEP_SYNC:
>> +	case HWTSTAMP_TX_ONESTEP_P2P:
>> +		NL_SET_ERR_MSG_MOD(extack,
>> +				   "One-step timestamping is not supported");
>> +		return -ERANGE;
>> +	default:
>> +		break;
>> +	}
> 
> This is the wrong way around, if someone adds a new value unsupported
> by the driver it will pass. We should be listing the supported types
> and
> 
> 	default:
> 		...ERR_MSG..
> 		return -ERANGE;
> 	}

But that's the original logic of the driver. Should I change it within
the same patch, or is it better to make a follow-up work to clean such
things in net-next?

