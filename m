Return-Path: <netdev+bounces-235125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90626C2C6E9
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 15:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727F63B4023
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 14:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0558E27EC7C;
	Mon,  3 Nov 2025 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CcqTrDvF"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC0918E3F
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762180237; cv=none; b=hgo1gsL2x7NWdp7XpBMA1KFcMtILdIilxAZBZfb0k/7O1aty3/xJuUsl8zObXip2MfJla/VN5KGODX+geUkzFBNpq9edLaVBje8Dr7UKkg2vo1S9xPxR7/AOl3uosCP4Q91sxcDv3VjgEgiOx940CGoxDGIqWwNkBqyT/OBwJ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762180237; c=relaxed/simple;
	bh=NZolMgJmw3SWu/joKXEZ2r7zR5on7lJk+Soi1nmwlJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JKYVnU6vt6P5MYBfEqgAKo6yA4hGu7sFRq6/KtaIhRKyJeGwpAFMOJdNIG985GbF9zxKdXGL7ssGldF1p1r6t1UClqBEEvdRRo8AkPl38N8NgblkkRsJi5YUAaYwgUpvE6T2Z/KmPqP+zg+uuGtTs86HDspnd5nml51H/pxrYOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CcqTrDvF; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <04d22523-34ed-45f1-ba59-ab8170d749e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762180233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SRwPUktMFGp/Comr5LxB75bQkPyJT9fVhB6SL5uplVg=;
	b=CcqTrDvFulflmHynUwnickQYQCFq4t8CE4PwdAmPujfMOwui7gI8S2olXAhbWue7OCcveD
	ecbLLXCpe/vGRm6BfXccmU2m7mbp21wGicq/nrW74fVNhbOJDYffL4x8u7J9wtKkckNNTB
	xjRFzL41d1EnE96DYP/ewai31vzD5Ag=
Date: Mon, 3 Nov 2025 14:30:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 6/7] net: pch_gbe: convert to use ndo_hwtstamp
 callbacks
To: Jakub Kicinski <kuba@kernel.org>,
 Kory Maincent <kory.maincent@bootlin.com>
Cc: Sudarsana Kalluru <skalluru@marvell.com>,
 Manish Chopra <manishc@marvell.com>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Sunil Goutham <sgoutham@marvell.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
References: <20251031004607.1983544-1-vadim.fedorenko@linux.dev>
 <20251031004607.1983544-7-vadim.fedorenko@linux.dev>
 <20251031183525.5b8b8110@kmaincent-XPS-13-7390>
 <20251031113840.067ef711@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251031113840.067ef711@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 31/10/2025 18:38, Jakub Kicinski wrote:
> On Fri, 31 Oct 2025 18:35:25 +0100 Kory Maincent wrote:
>>>   	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
>>> -		adapter->hwts_rx_en = 0;
>>> +		adapter->hwts_rx_en = cfg->rx_filter;
>>
>> It seems there is a functional change here.
>>
>>> 		pch_ch_control_write(pdev, SLAVE_MODE | CAP_MODE0);
> 
> Good catch. Looks like SLAVE | MODE0 translates to 0 | 0
> so presumably the device doesn't actually support timestamping
> of V1 L4 SYNC messages? Unclear what to do about this.
> Maybe let's leave it be? keep the hwts_rx_en = 0; ?
> Not strictly correct but at least we won't break anything.

Ok, it looked like typo as the function actually does the register
manipulation while it's not doing anything for disabling RX timestamping
which probably means it's enabled by default.
But as the code was added back in 2012, and nobody complained, we should 
probably keep it as is. I'll send v2 shortly.

