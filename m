Return-Path: <netdev+bounces-229556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CE4BDE045
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 12:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C1FE3343463
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 10:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE6631B83A;
	Wed, 15 Oct 2025 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GqimG2sU"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1812E2DCB
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524393; cv=none; b=B+d8YQiD7XOTuibVu/psA0YBTLRx262XOh6RwROhmVYrmGYWQ2cuosJKZtNBTlMZLSOHGpj6rYEZkIBdGeyygzpU7AdKNbVTMbWHemOh+0EWxhq1QojI53TbNlbo+lsqYFM5tfLn2gZb17pHAqJliJLj2KIcV2nIOOJR8ikBMiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524393; c=relaxed/simple;
	bh=ckaq9GGGu+5YnLKpDgmKmdvxz17Q5A71vh/sxnf64T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9Qz+AgqCkO5o2aQhQiccsFaOumV5pwlFUpvdRE6/INigTkoT15SWxaP+WxJDaxAlA5W0b74VmlEO2Xc0mOugvEkjmSjJBe3tshxrsQFc8S42yqZfSJUJZsVASUs9mxLXDmfz3Nz2GmUmOMb6cPKgAXkUS8Qbx6qY5bsV0hHtN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GqimG2sU; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <193627cf-a8c7-4428-a5d3-8813b1edc04d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760524388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s5jxJeQVvQA+SmHuoyYptlsgDQEOQQBgy3mY10Q6WB4=;
	b=GqimG2sUXJFqbcxxtr+cJMPtuh4OA2FwMapjdjFv62vWVQtUw78MxZXnbXNITujD9el5Nz
	q+thP7VNh2GaeJg2Y6QlX9yUdo3ck1h9U7vUYrmnIETHqFbmfcWCqQv7D4wPIz9G/dFUh4
	kSuD8BsJnOwcq68uMkM2MmL718B3l40=
Date: Wed, 15 Oct 2025 11:33:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 5/7] cxgb4: convert to ndo_hwtstamp API
To: Simon Horman <horms@kernel.org>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Egor Pomozov <epomozov@marvell.com>, Potnuri Bharat Teja
 <bharat@chelsio.com>, Dimitris Michailidis <dmichail@fungible.com>,
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-6-vadim.fedorenko@linux.dev>
 <aO9x7EpgTMiBBfER@horms.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <aO9x7EpgTMiBBfER@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 15/10/2025 11:05, Simon Horman wrote:
> On Tue, Oct 14, 2025 at 10:42:14PM +0000, Vadim Fedorenko wrote:
>> Convert to use .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks.
>>
>> Though I'm not quite sure it worked properly before the conversion.
>>
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
> Hi Vadim,
> 
> There is quite a lot of change here. Probably it's not worth "fixing"
> the current code before migrating it. But I think it would be worth
> expanding a bit on the statement about not being sure it worked?

Hi Simon!

Well, let me try to explain the statement about not being sure it
worked. The original code was copying new configuration into netdev's
private structure before validating that the values are acceptable by
the hardware. In case of error, the driver was not restoring original
values, and after the call:

ioctl(SIOCSHWTSTAMP, <unsupported_config>) = -ERANGE

the driver would have configuration which could not be reapplied and not 
synced to the actual hardware config:

ioctl(SIOCGHWTSTAMP) = <unsupported_config>

The logic change in the patch is to just keep original configuration in
case of -ERANGE error. Otherwise the logic is not changed.


