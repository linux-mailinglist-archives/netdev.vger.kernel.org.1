Return-Path: <netdev+bounces-125583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A69196DC25
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 16:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8901C262ED
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F376A19DF5E;
	Thu,  5 Sep 2024 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vwl/aVMT"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F2819DF4F
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547212; cv=none; b=nPKW9ovUmxw2QHsAzYeS3QD5PS0jFBhAAgld/zEoVznyCMyZ6kwykqb5Y0uPUmmUICwNiqTKTd20tfdEiKBTX8mehaZg1I5XiSvzfCIWo9x/imfiphzLTBiXUGPtRzGFdJdnBlQgW04N/Sfn8nPWjwN6xCVL6gprSRQA6Gd+88M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547212; c=relaxed/simple;
	bh=9Qpz9IgPPPuZRjHfAi+JxFCA4a87umQJexHCAJwAffY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwiwAjqdHoUgkvJODhRUhgH4tME0CN9Y7Jcvvsvsy/IcU5tX4J+EETwi69W3xngVIhNB7cbkuXi0EdJK28nqdiF5rpWU/k2mHoOe98i1ACnuxJYTfdM7zcQZ6G0SOCW7jZ/oZ6XOp1xNW14FYvZvJ0+6VDx0P1xCh2SI98BFMT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vwl/aVMT; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <096b8143-c6e5-4d64-9097-68d19ed514f3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725547209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rUB20QZ7/mXv4Zpypxa4c5I9430cCHuxhn0oS5odMik=;
	b=vwl/aVMTlh2nw8sihlGN7W72bvHentKRdPP5Hou1LTLFeKNUW6CVfOsqrLJ8kg5INuTHL4
	/z5FU7zZbJm9MHUeNtrePa8NRaRbBZPnIOSK519j2JhGkOPcQkqqcS4FhNJrZiZ+E6czf6
	P1WplOKIp5JoOtejC7an/VSfmiq/khw=
Date: Thu, 5 Sep 2024 10:40:03 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: xilinx: axienet: Fix packet counting
To: Jakub Kicinski <kuba@kernel.org>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Michal Simek <michal.simek@amd.com>, Andy Chiu <andy.chiu@sifive.com>,
 Daniel Borkmann <daniel@iogearbox.net>, linux-kernel@vger.kernel.org
References: <20240903175619.4133633-1-sean.anderson@linux.dev>
 <20240904170917.29692bcb@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240904170917.29692bcb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/4/24 20:09, Jakub Kicinski wrote:
> On Tue,  3 Sep 2024 13:56:19 -0400 Sean Anderson wrote:
>> axienet_free_tx_chain returns the number of DMA descriptors it's
>> handled. However, axienet_tx_poll treats the return as the number of
>> packets. When scatter-gather SKBs are enabled, a single packet may use
>> multiple DMA descriptors, which causes incorrect packet counts. Fix this
>> by explicitly keepting track of the number of packets processed as
>> separate from the DMA descriptors.
> 
> budget doubles up as a "are we really in NAPI" flag.
> You can't pass non-zero budget to napi_consume_skb() if not in NAPI.

Hm, maybe I should just determine this all from the "force" flag then.

--Sean

