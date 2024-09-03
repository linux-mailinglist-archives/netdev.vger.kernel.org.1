Return-Path: <netdev+bounces-124696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A14F396A786
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 21:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1E851C239EB
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 19:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C91F19149E;
	Tue,  3 Sep 2024 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTiFQ/vS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38F918E379;
	Tue,  3 Sep 2024 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392411; cv=none; b=fext9XqVSgeNBl0linB+gzimWgawOP/WzkXO3LPAST3WMw5mLswU8gr1rNpmwM1mMTTd0jfMU7JgK/K5auEQKoJBucuCTXQudC104MJ3HXT6dx21RZuwhfAZfFEWzsbxushoiLpEElz9YEmNmSF/kTh1XBid68eEj5Dx0e7IE3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392411; c=relaxed/simple;
	bh=XC9fpM68GCykaJ0+llPct0MH1DbK7uxfWC50qejoiWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SbClggBygeJ7Fukg+15h0SrQJhxF6NgbRLoxpizkNF4mpislm4XwKet3AsXw/mrWbtfLhqmyEmAYfm7R6i1DaU4XKKdnKANeF4QnAeunkiFmPx8/UmAWUvLUtC7kqhLu2xQbdR4AvT6kQXEgWsXAKzB2cDjieZK0KjgwNfzLEIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTiFQ/vS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99307C4CEC4;
	Tue,  3 Sep 2024 19:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725392410;
	bh=XC9fpM68GCykaJ0+llPct0MH1DbK7uxfWC50qejoiWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YTiFQ/vSeJiEZhoFjPH0CtCM7fNBeEOmIL/WiDgnDa9dSCXvL082SjqmYnFJi3n9i
	 4VJmtrHgRYDw4rx9bgw2PPGO6juFFSAd8L3qaLkz6Cmvpsp7xPMAo+e7Fn2nh9hLt/
	 KHrKTQrxH9e02hfJtlq9JyrgL9amv1KjzGbrRdLo3AyCUXnPxQFS3b0gd+WrZUCojP
	 cULac79qH1Wo/HdS4/4GI1Fv54v5lRh9zbx8DsSzSZd2hROp5HJ+08uGdXSnHMmqcb
	 vV1yw7ACLEOKtZkqZbKo0AtdJU4EC+8LfpXQSB/0HY0vpJgIydZeHWYJUZPP6IpJL2
	 03FxoOeuTnGXg==
Date: Tue, 3 Sep 2024 12:40:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
 edumazet@google.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
 hch@infradead.org, willy@infradead.org, willemdebruijn.kernel@gmail.com,
 Martin Karsten <mkarsten@uwaterloo.ca>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>, Daniel Jurgens <danielj@nvidia.com>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 5/5] netdev-genl: Support setting per-NAPI
 config values
Message-ID: <20240903124008.4793c087@kernel.org>
In-Reply-To: <CAAywjhTG+2BmoN76kaEmWC=J0BBvnCc7fUhAwjbSX5xzSvtGXw@mail.gmail.com>
References: <20240829131214.169977-1-jdamato@fastly.com>
	<20240829131214.169977-6-jdamato@fastly.com>
	<20240829153105.6b813c98@kernel.org>
	<ZtGiNF0wsCRhTtOF@LQ3V64L9R2>
	<20240830142235.352dbad5@kernel.org>
	<ZtXuJ3TMp9cN5e9h@LQ3V64L9R2.station>
	<20240902180220.312518bc@kernel.org>
	<CAAywjhTG+2BmoN76kaEmWC=J0BBvnCc7fUhAwjbSX5xzSvtGXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Sep 2024 12:04:52 -0700 Samiullah Khawaja wrote:
> Do we need a queue to napi association to set/persist napi
> configurations? 

I'm afraid zero-copy schemes will make multiple queues per NAPI more
and more common, so pretending the NAPI params (related to polling)
are pre queue will soon become highly problematic.

> Can a new index param be added to the netif_napi_add
> and persist the configurations in napi_storage.

That'd be my (weak) preference.

> I guess the problem would be the size of napi_storage.

I don't think so, we're talking about 16B per NAPI, 
struct netdev_queue is 320B, struct netdev_rx_queue is 192B. 
NAPI storage is rounding error next to those :S

> Also wondering if for some use case persistence would be problematic
> when the napis are recreated, since the new napi instances might not
> represent the same context? For example If I resize the dev from 16
> rx/tx to 8 rx/tx queues and the napi index that was used by TX queue,
> now polls RX queue.

We can clear the config when NAPI is activated (ethtool -L /
set-channels). That seems like a good idea.

The distinction between Rx and Tx NAPIs is a bit more tricky, tho.
When^w If we can dynamically create Rx queues one day, a NAPI may 
start out as a Tx NAPI and become a combined one when Rx queue is 
added to it.

Maybe it's enough to document how rings are distributed to NAPIs?

First set of NAPIs should get allocated to the combined channels,
then for remaining rx- and tx-only NAPIs they should be interleaved
starting with rx?

Example, asymmetric config: combined + some extra tx:

    combined        tx
 [0..#combined-1] [#combined..#combined+#tx-1]

Split rx / tx - interleave:

 [0 rx0] [1 tx0] [2 rx1] [3 tx1] [4 rx2] [5 tx2] ...

This would limit the churn when changing channel counts.

