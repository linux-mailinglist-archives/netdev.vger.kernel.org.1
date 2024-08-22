Return-Path: <netdev+bounces-121056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 281E395B855
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 16:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47E61F26059
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5599F1CBEAE;
	Thu, 22 Aug 2024 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u5CE2yN5"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE9E1CC17E
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724336717; cv=none; b=MmDDCbAR/i9OuiCb3IJoCsk6O9A0RUxoBiwnzkjFrnWcMTLaTY13MGc3QHl5M4i+Bl1yp1tDJZbQCtNHmIg4jgQdQg6IP3JdL+SYjr8NjeMm7KB1RoNGU6S5xxZeXMORioaWYTMO9zJz6KAbOIqhN1f9ezAxyAJLSKHwV6/VQS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724336717; c=relaxed/simple;
	bh=XIwJYyLZAEQvZs1LqqSkaLJPuX6sDMS09+9teyUe6NA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lrF9/GOwduTTIYNurPomfP8VKLHvCuUbZrMdx1dno9pbiDgxk0+PgCgZ2BgtKCoBvlV+AHALCclJZwUX65qSXaUQEF66Botoxobmq7cEN4zfKLWaLAZGbkAhVnU9BC99Md+voaoXOjblWEypdGv18ihxytBEwyILc/1QHsmtsn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u5CE2yN5; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <aeb2b005-8205-4060-8f72-e7b2f0c1d744@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724336712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LpB+Ifhf2bxD9pHYqJFvxBYsnuv1V6nOurdtT7+oTQk=;
	b=u5CE2yN5E9OXLRBlQQ4eFSBK6QbUyfhFgyfsW5bVqYwmne4C5BrrRnm2DTU9zQKHREIdOP
	N/XF7xb22UaoSpFvuW19xGr91vCxbp3b3HDVEpnBsQAtrXlMFh9dBZSPLeGYMTF6pT+pJn
	D50GGmDvvutI3ABzqwsqKnZHz08NS8k=
Date: Thu, 22 Aug 2024 10:25:06 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 1/5] net: xilinx: axienet: Always disable
 promiscuous mode
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <michal.simek@amd.com>, Daniel Borkmann <daniel@iogearbox.net>,
 linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
References: <20240815193614.4120810-1-sean.anderson@linux.dev>
 <20240815193614.4120810-2-sean.anderson@linux.dev>
 <20240819183041.2b985755@kernel.org>
 <7e6caa8b-ae79-4eb0-8ccb-d57471e8a3d5@linux.dev>
Content-Language: en-US
In-Reply-To: <7e6caa8b-ae79-4eb0-8ccb-d57471e8a3d5@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/20/24 10:24, Sean Anderson wrote:
> On 8/19/24 21:30, Jakub Kicinski wrote:
>> On Thu, 15 Aug 2024 15:36:10 -0400 Sean Anderson wrote:
>>> If promiscuous mode is disabled when there are fewer than four multicast
>>> addresses, then it will to be reflected in the hardware. Fix this by
>> 
>> it will *not* be reflected?
>> Something is off with this commit messages, or at least I can't parse
>> 
>>> always clearing the promiscuous mode flag even when we program multicast
>>> addresses.
>>> 
>>> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
>> 
>> I think we should ship it as a fix to net?
> 
> Yes, probably. I put these patches first so they could be easily cherry-picked.

OK, so to be clear: how should I send these patches?

--Sean


