Return-Path: <netdev+bounces-194260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D78BBAC80FA
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 18:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2CC1C02E9C
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 16:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB6D22DFAA;
	Thu, 29 May 2025 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hqLZDpOW"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D4722D4D0
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748536527; cv=none; b=LmHGlESmUxd6lcjnEkf7g8XCyQk84okm6IWonkhqiy2/xO4qPGtga1V24XeQXTwzLf1VYRssmarOgwxvpCnnZbq1oOez8YyGTSi55lmXlb7Tns1wsF/8sUCVExEeCz8oKmEmM+L/zIL/Gc8dkuY/M4vJlM1FmWNqgSfjKwRdX3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748536527; c=relaxed/simple;
	bh=IviTiIj3WvUWqOSsZPOwBlyQH4Z1m5aUiktfXlInqyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LeeklxgUS1IiQAVqk6FXFQHWLs8Y8zVghINoum2CRVzBm3wV4JbJg913IxFBSl9JwxlRDbNwVx5f5/PiE5k3lXKRvJunCexgF/TM9AVVc3jK/+UJFRCMhZGGhLEhfFlRvvm98Ap+BRjiwi0IQCJeH4rr076shbbKCHvt7YXI5io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hqLZDpOW; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f445b132-98c5-4f38-bd3e-172bc8645a03@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748536513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgchDy6+ENMwqS/G43COtFv0WHKtbEpVBzFuObLQORs=;
	b=hqLZDpOWSYQ2FckvbhD5AL4P/5BzRpqjbhLUkGbGbVjsd4GxGVI2nKradu011PJcE3efzT
	VQi7WkK/+LrbhVboZKk9NzMSWHnauDVyZz3HkGFKQD4Fy/xbTNNrc0TMuLvtbBjK8Yf/NP
	E9xhQ00BqTYAH6m9BUGtxaWj3Ih+YQA=
Date: Thu, 29 May 2025 12:35:09 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: xilinx: axienet: Configure and report
 coalesce parameters in DMAengine flow
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Gupta, Suraj" <Suraj.Gupta2@amd.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "vkoul@kernel.org" <vkoul@kernel.org>,
 "Simek, Michal" <michal.simek@amd.com>,
 "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
 "horms@kernel.org" <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "git (AMD-Xilinx)" <git@amd.com>, "Katakam, Harini" <harini.katakam@amd.com>
References: <20250525102217.1181104-1-suraj.gupta2@amd.com>
 <679d6810-9e76-425c-9d4e-d4b372928cc3@linux.dev>
 <BL3PR12MB6571ABA490895FDB8225CAEBC967A@BL3PR12MB6571.namprd12.prod.outlook.com>
 <d5be7218-8ec1-4208-ac24-94d4831bfdb6@linux.dev>
 <6c99b7f5-b529-4efd-a065-1e0ebf01468e@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <6c99b7f5-b529-4efd-a065-1e0ebf01468e@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/29/25 12:29, Andrew Lunn wrote:
>> Yeah, but the reason is that you are trading latency for throughput.
>> There is only one queue, so when the interface is saturated you will not
>> get good latency anyway (since latency-sensitive packets will get
>> head-of-line blocked). But when activity is sparse you can good latency
>> if there is no coalescing. So I think coalescing should only be used
>> when there is a lot of traffic. Hence why I only adjusted the settings
>> once I implemented DIM. I think you should be able to implement it by
>> calling net_dim from axienet_dma_rx_cb, but it will not be as efficient
>> without NAPI.
>> 
>> Actually, if you are looking into improving performance, I think lack of
>> NAPI is probably the biggest limitation with the dmaengine backend.
> 
> It latency is the goal, especially for mixing high and low priority
> traffic, having BQL implemented is also important. Does this driver
> have that?
> 
> 	Andrew

Yes, see commit c900e49d58eb ("net: xilinx: axienet: Implement BQL").

--Sean

