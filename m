Return-Path: <netdev+bounces-118889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B809536DB
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E0328BD84
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310DF19F49B;
	Thu, 15 Aug 2024 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iMWwoxYW"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF686FBF
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723734941; cv=none; b=cdpt5UWCom9afj8U1nJfnk1d/8JT0tpit6hAc8MI0aF1M1K4VzN4gYg7n3ooyikpBN4WS3Zv5W15Uy2Vayvb1QCzK4xe5+UP+52wXCw5UOBFBH5WS57g5QZQGzvxzjC4fD570JOG2JpDzJQJerY62ZpCwBHfT2ArYlB86O01Yao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723734941; c=relaxed/simple;
	bh=vE16knDDPEhIOws2TpQRIKWJVED7xSXQPEzP3dgG+vY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNmGwsQ4/BCnh0O60FCmao++1aPy7LLFlnDcmmZAc1D3PsUTwRX+roaOtnJrNCFnX1esiyhhrNcDtfDJyW49cEzhhqCtZC6nl+f2ZAWQFMaLYeAUhg0wJ061aAhBqrwAQOYkGJ1S6M26ib1AQ/8V5sIDJLJoKtQMxhxEKGvPVOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iMWwoxYW; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c0520caa-7c73-4a96-a21e-f0bbac95b5d3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723734937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYigmxDcwTho9rKIrBqACxBsAtA/H5Uwy4J6Qcv76Sw=;
	b=iMWwoxYWoxVV3br3wv3lYpuelL+1sxO1ZDaDiSYqRX+AgNekDU7y49SUjwNLmgVQc4K2U7
	1rVgBz9Rf3aNzY+1H39r5lpnbUUSj+qqypIC+0Nm1XGG1ns3vRP1YMdrSWUIlu6hmphLWS
	pkGIS+EulsBWdq3QSDfLkCIdrI4DHQ4=
Date: Thu, 15 Aug 2024 11:15:32 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 3/4] net: xilinx: axienet: Don't print if we go
 into promiscuous mode
To: Simon Horman <horms@kernel.org>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Michal Simek <michal.simek@amd.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 linux-arm-kernel@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 Ariane Keller <ariane.keller@tik.ee.ethz.ch>
References: <20240812200437.3581990-1-sean.anderson@linux.dev>
 <20240812200437.3581990-4-sean.anderson@linux.dev>
 <20240815145948.GH632411@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240815145948.GH632411@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/15/24 10:59, Simon Horman wrote:
> On Mon, Aug 12, 2024 at 04:04:36PM -0400, Sean Anderson wrote:
>> A message about being in promiscuous mode is printed every time each
>> additional multicast address beyond four is added. Suppress this message
>> like is done in other drivers. And don't set IFF_PROMISC in ndev->flags;
>> contrary to the comment we don't have to inform the net subsystem.
> 
> Hi Sean,
> 
> FWIIW, this feels like two things that could be two patches.
> 
> ...

OK

