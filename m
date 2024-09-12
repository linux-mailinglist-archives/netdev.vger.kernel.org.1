Return-Path: <netdev+bounces-127825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A3A976BDF
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 16:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788711F264F1
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 14:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6021AD24C;
	Thu, 12 Sep 2024 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dmzhz82m"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502D31A76D7
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726150995; cv=none; b=ebfsSpAhvy8Mek0AR4TmxUxnTLOE+/gO3kMoP1qT5sYezVG7vUp/wRHhRi1uGO1DOYyLZRWB09brXjVnj58s4fC38l9cKmMyMDS0sgpq25BDNQd60RyNHGvoyNLdQMv9W56j4A4VRMioVBKQKWwonX1HJoAVjO2Nqess9vr3ucA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726150995; c=relaxed/simple;
	bh=oWzSbl9SOryhrEfvgC31aG2vf60JanCUGc273K6cBVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OOZmdcRhCN0vWznUBmwYXYz2XrDX6RDXwONkeqSDLlUNiMfviFTMpXlHgv7sFcC4gduPTWmmag5w6fY8v2Xe2pzqglVcBlbv3p+yHqf4bO2yhHFYuLv4d+Ef+kgX6nqe8WIMUwrQRMk+ftCuoJesnQy9dCkJkUdTRexqO/QX+dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dmzhz82m; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f63bf0ad-2846-4108-9a3f-9ea113959af0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726150991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JQcj2YDJcPOkha5AjFb9sgabfqS/mkYXHsp1WXdSRE0=;
	b=Dmzhz82mKpoK7vDeWNHJ8FrrSmRqWeE4p4A2Gg7IU4qsDs5hfY+ZYc7GEvOoOQOfqMkUMX
	kncnb80/XNvOBRgi8lkmllfzNjB7cho4BWysXMLUfH7qP1RXO8+3J8wi6763V7vo77VvX7
	l+qodB+IidCdHyBcI9NN0+g9d/sni84=
Date: Thu, 12 Sep 2024 10:23:06 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: xilinx: axienet: Schedule NAPI in two steps
To: Jakub Kicinski <kuba@kernel.org>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Robert Hancock <robert.hancock@calian.com>,
 linux-kernel@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
 linux-arm-kernel@lists.infradead.org
References: <20240909231904.1322387-1-sean.anderson@linux.dev>
 <20240910185801.42b7c17f@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240910185801.42b7c17f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/10/24 21:58, Jakub Kicinski wrote:
> On Mon,  9 Sep 2024 19:19:04 -0400 Sean Anderson wrote:
>> Additionally, since we are running
>> in an IRQ context we can use the irqoff variant as well.
> 
> The _irqoff variant is a bit of a minefield. It causes issues if kernel
> is built with forced IRQ threading. With datacenter NICs forced
> threading is never used so we look the other way. Since this is a fix
> and driver is embedded I reckon we should stick to __napi_schedule().

Does it?

__napi_schedule_irqoff selects between __napi_schedule and
____napi_schedule based on whether PREEMPT_RT is enabled. Is there some
other way to force IRQ threading?

--Sean

