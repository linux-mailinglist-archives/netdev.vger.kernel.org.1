Return-Path: <netdev+bounces-195788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F89AD23B8
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 18:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9715D7A4C1A
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 16:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1524921B191;
	Mon,  9 Jun 2025 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MzRpHoUg"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528D721ADDB
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486150; cv=none; b=afk+1fe9ookfeKLbMcR7cLnsvgeUwTiGku8YB3TzTaJ3w05rnpqTqT9DQAlSb5jrM5MMtEqsDNWk0wZ+w5+yAKO4eooYuntwT31gbvIpvXVPXy15FtJ8mDhkyGvQRRrn9YdraXVHvQFu+fjP2HSaIT4oUJnE+skoiNGgvU7weFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486150; c=relaxed/simple;
	bh=LwkdfZotq1hx58KAFWErKk1aUJPY8PMP/SIJ8TfQ6TQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jnekg0iklmwKMbEM0IgyTj9jhXWJTQ/8WWfJvAxaW7i7ejCwieedNnzqiIKziOhiilAqteg0lcBlnJ0DKOFB1LyKm/EBcyUg7OppHk9nJiu0OxLGpACSWD4B+0xcMKrQ+VenkGYXRIx0Ob25KzHQOf/4hwVllZnZUGFMTQNych0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MzRpHoUg; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ef69c619-697a-412a-bddb-b363221302f9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749486134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UfE1cuGyccM+ctL/xI1AAmrwxz/Q6xclkDdRjMgfvGw=;
	b=MzRpHoUg4hXHXqcAIGuehASoFiIWASzqUKv0zKCDga+VGB4R1HmdVr3N14gBxxmkyh/Vp5
	3p2UEjHnTLa1d7zJBJtXw+M82rMXS8ChTXGwYzOP6C/irkQW/v9l0BvWaM2yp0H39QshdH
	YfN7pB3BSIpN6/F0h6/JA3cvxHsQzmQ=
Date: Mon, 9 Jun 2025 12:22:09 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: xilinx: axienet: Configure and report
 coalesce parameters in DMAengine flow
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "vkoul@kernel.org" <vkoul@kernel.org>,
 "Simek, Michal" <michal.simek@amd.com>,
 "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
 "horms@kernel.org" <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "git (AMD-Xilinx)" <git@amd.com>, "Katakam, Harini" <harini.katakam@amd.com>
References: <20250525102217.1181104-1-suraj.gupta2@amd.com>
 <679d6810-9e76-425c-9d4e-d4b372928cc3@linux.dev>
 <BL3PR12MB6571ABA490895FDB8225CAEBC967A@BL3PR12MB6571.namprd12.prod.outlook.com>
 <d5be7218-8ec1-4208-ac24-94d4831bfdb6@linux.dev>
 <BL3PR12MB6571A48E5FD0092231D0B0A5C961A@BL3PR12MB6571.namprd12.prod.outlook.com>
 <e6f20d3c-65fb-4809-a105-36ad8f2b2645@linux.dev>
 <BL3PR12MB65710F24C2260A07FEBE65F1C96DA@BL3PR12MB6571.namprd12.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <BL3PR12MB65710F24C2260A07FEBE65F1C96DA@BL3PR12MB6571.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/3/25 07:07, Gupta, Suraj wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Sean Anderson <sean.anderson@linux.dev>
>> Sent: Saturday, May 31, 2025 2:15 AM
>> To: Gupta, Suraj <Suraj.Gupta2@amd.com>; andrew+netdev@lunn.ch;
>> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>> pabeni@redhat.com; vkoul@kernel.org; Simek, Michal <michal.simek@amd.com>;
>> Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; horms@kernel.org
>> Cc: netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>; Katakam, Harini
>> <harini.katakam@amd.com>
>> Subject: Re: [PATCH net-next] net: xilinx: axienet: Configure and report coalesce
>> parameters in DMAengine flow
>>
>> Caution: This message originated from an External Source. Use proper caution
>> when opening attachments, clicking links, or responding.
>>
>>
>> On 5/30/25 06:18, Gupta, Suraj wrote:
>> > [AMD Official Use Only - AMD Internal Distribution Only]
>> >
>> >> -----Original Message-----
>> >> From: Sean Anderson <sean.anderson@linux.dev>
>> >> Sent: Thursday, May 29, 2025 9:48 PM
>> >> To: Gupta, Suraj <Suraj.Gupta2@amd.com>; andrew+netdev@lunn.ch;
>> >> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>> >> pabeni@redhat.com; vkoul@kernel.org; Simek, Michal
>> >> <michal.simek@amd.com>; Pandey, Radhey Shyam
>> >> <radhey.shyam.pandey@amd.com>; horms@kernel.org
>> >> Cc: netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> >> linux- kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>;
>> >> Katakam, Harini <harini.katakam@amd.com>
>> >> Subject: Re: [PATCH net-next] net: xilinx: axienet: Configure and
>> >> report coalesce parameters in DMAengine flow
>> >>
>> >> Caution: This message originated from an External Source. Use proper
>> >> caution when opening attachments, clicking links, or responding.
>> >>
>> >>
>> >> On 5/28/25 08:00, Gupta, Suraj wrote:
>> >> > [AMD Official Use Only - AMD Internal Distribution Only]
>> >> >
>> >> >> -----Original Message-----
>> >> >> From: Sean Anderson <sean.anderson@linux.dev>
>> >> >> Sent: Tuesday, May 27, 2025 9:47 PM
>> >> >> To: Gupta, Suraj <Suraj.Gupta2@amd.com>; andrew+netdev@lunn.ch;
>> >> >> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>> >> >> pabeni@redhat.com; vkoul@kernel.org; Simek, Michal
>> >> >> <michal.simek@amd.com>; Pandey, Radhey Shyam
>> >> >> <radhey.shyam.pandey@amd.com>; horms@kernel.org
>> >> >> Cc: netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> >> >> linux- kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>;
>> >> >> Katakam, Harini <harini.katakam@amd.com>
>> >> >> Subject: Re: [PATCH net-next] net: xilinx: axienet: Configure and
>> >> >> report coalesce parameters in DMAengine flow
>> >> >>
>> >> >> Caution: This message originated from an External Source. Use
>> >> >> proper caution when opening attachments, clicking links, or responding.
>> >> >>
>> >> >>
>> >> >> On 5/25/25 06:22, Suraj Gupta wrote:
>> >> >> > Add support to configure / report interrupt coalesce count and
>> >> >> > delay via ethtool in DMAEngine flow.
>> >> >> > Netperf numbers are not good when using non-dmaengine default
>> >> >> > values, so tuned coalesce count and delay and defined separate
>> >> >> > default values in dmaengine flow.
>> >> >> >
>> >> >> > Netperf numbers and CPU utilisation change in DMAengine flow
>> >> >> > after introducing coalescing with default parameters:
>> >> >> > coalesce parameters:
>> >> >> >    Transfer type        Before(w/o coalescing)  After(with coalescing)
>> >> >> > TCP Tx, CPU utilisation%      925, 27                 941, 22
>> >> >> > TCP Rx, CPU utilisation%      607, 32                 741, 36
>> >> >> > UDP Tx, CPU utilisation%      857, 31                 960, 28
>> >> >> > UDP Rx, CPU utilisation%      762, 26                 783, 18
>> >> >> >
>> >> >> > Above numbers are observed with 4x Cortex-a53.
>> >> >>
>> >> >> How does this affect latency? I would expect these RX settings to
>> >> >> increase latency around 5-10x. I only use these settings with DIM
>> >> >> since it will disable coalescing during periods of light load for better latency.
>> >> >>
>> >> >> (of course the way to fix this in general is RSS or some other
>> >> >> method involving multiple queues).
>> >> >>
>> >> >
>> >> > I took values before NAPI addition in legacy flow (rx_threshold:
>> >> > 24, rx_usec: 50) as
>> >> reference. But netperf numbers were low with them, so tried tuning
>> >> both and selected the pair which gives good numbers.
>> >>
>> >> Yeah, but the reason is that you are trading latency for throughput.
>> >> There is only one queue, so when the interface is saturated you will
>> >> not get good latency anyway (since latency-sensitive packets will get
>> >> head-of-line blocked). But when activity is sparse you can good
>> >> latency if there is no coalescing. So I think coalescing should only
>> >> be used when there is a lot of traffic. Hence why I only adjusted the
>> >> settings once I implemented DIM. I think you should be able to
>> >> implement it by calling net_dim from axienet_dma_rx_cb, but it will not be as
>> efficient without NAPI.
>> >>
>> >
>> > Ok, got it. I'll keep default values used before NAPI in legacy flow (coalesce count:
>> 24, delay: 50) for both Tx and Rx and remove perf comparisons.
>>
>> Those settings are actually probably even worse for latency. I'd leave the settings at
>> 0/0 (coalescing disabled) to match the existing behavior. I think the perf comparisons
>> are helpful, especially for people who know they are going to be throughput-limited.
>>
>> My main point is that I think extending the dmaengine API to allow for DIM will have
>> practical benefits in reduced latency.
>>
> Sure, will implement DIM for both Tx and Rx in next version. However, I noticed it's implemented for Rx only in legacy flow. Is there any specific reason for that?

There's no latency issue with sending packets. It doesn't matter when we
process Tx completions as long as we refill the ring in time to send
more packets. So we can aggressively set the Tx coalescing for maximum
throughput.

--Sean

