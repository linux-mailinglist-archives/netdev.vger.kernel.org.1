Return-Path: <netdev+bounces-87227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8542E8A235A
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 03:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407A12851B5
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 01:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E5A6AB8;
	Fri, 12 Apr 2024 01:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOz4Vm8A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102A46AA7
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 01:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712886462; cv=none; b=Lzfy5e4OSqvUS8MASFnszP7DABbUOae4TrrQy2O2gMHp/sEHVBYjJeKIGgAwbXlpmu9iseYyMGz5/oH8niFwoTRU6TW8c6hOfb4yl7CMD0orM9TaCZNqHNvD8GgovL3XeDE86Uz5klIDw4MVsnhmNtr/4jo3/UYhQm/YSBSArUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712886462; c=relaxed/simple;
	bh=RRdxGZ5WG5yqH6GU3Wbo/t1HgLxWHEtzZaqRzFlSYYg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=htAbiwj+Q5nbvxRZjmroljQ0vZGSu6yRLyyOOl+9Ruyt7AQZqU1BCjYe80rXv0Xfx5TQLYOlYrYjSqrB4Q/bKFh18elZtt6y/uC9Vh1NWi63166ElpjpNkdjGcZNWmvk08gc1fpqIow4C4oD37Z4U18qX7Ig4kQPtxYfHnh5CFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOz4Vm8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A28FC072AA;
	Fri, 12 Apr 2024 01:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712886461;
	bh=RRdxGZ5WG5yqH6GU3Wbo/t1HgLxWHEtzZaqRzFlSYYg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vOz4Vm8ABtANQl6OVPLAcyNRDSL8+thOGBrJKv9UzfgHXF6r79Z3z8cjskpaYRUWz
	 gYwwliYhhR2brAw3rUp5ABkzgYeRUH8/mHSG9GUrFUzqoHSTfwCMukJ3IeOYYJB4tL
	 czLJVPWmTs6hNKDErdciRCXLyLHi6unHIcy4QARWmxGnhojcOt7DZ4YvkEtGqFsZSG
	 EBVcRxNZf4sJxqGHyAEbV3/+xGOUuebSkp1cUA0h7tyrX85JfM01U9eCKFnqHrvml/
	 I0ZQti74myCJJq8RvZzXfusI78Ri8wYnd1kusWusY7v3a/DE/6gcO+TpVzKByu454k
	 fkG0gXMBefO0A==
Date: Thu, 11 Apr 2024 18:47:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <ast@kernel.org>, <sdf@google.com>,
 <lorenzo@kernel.org>, <tariqt@nvidia.com>, <daniel@iogearbox.net>,
 <anthony.l.nguyen@intel.com>, <lucien.xin@gmail.com>, <hawk@kernel.org>,
 <sridhar.samudrala@intel.com>
Subject: Re: [net-next,RFC PATCH 0/5] Configuring NAPI instance for a queue
Message-ID: <20240411184740.782809eb@kernel.org>
In-Reply-To: <94956064-9935-4ff3-8924-a99beb5adc07@intel.com>
References: <171234737780.5075.5717254021446469741.stgit@anambiarhost.jf.intel.com>
	<20240409162153.5ac9845c@kernel.org>
	<94956064-9935-4ff3-8924-a99beb5adc07@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 15:46:45 -0700 Nambiar, Amritha wrote:
> On 4/9/2024 4:21 PM, Jakub Kicinski wrote:
> > On Fri, 05 Apr 2024 13:09:28 -0700 Amritha Nambiar wrote:  
> >> $ ./cli.py --spec netdev.yaml --do queue-set  --json='{"ifindex": 12, "id": 0, "type": 0, "napi-id": 595}'
> >> {'id': 0, 'ifindex': 12, 'napi-id': 595, 'type': 'rx'}  
> > 
> > NAPI ID is not stable. What happens if you set the ID, bring the
> > device down and up again? I think we need to make NAPI IDs stable.
> 
> I tried this (device down/up and check NAPIs) on both bnxt and intel/ice.
> On bnxt: New NAPI IDs are created sequentially once the device is up 
> after turning down.
> On ice: The NAPI IDs are stable and remains the same once the device is 
> up after turning down.
> 
> In case of ice, device down/up executes napi_disable/napi_enable. The 
> NAPI IDs are not lost as netif_napi_del is not called at IFF_DOWN. On 
> IFF_DOWN, the IRQs associations with the OS are freed, but the resources 
> allocated for the vectors and hence the NAPIs for the vectors persists 
> (unless unload/reconfig).

SG! So let's just make sure we cover that in tests.

> > What happens if you change the channel count? Do we lose the config?
> > We try never to lose explicit user config. I think for simplicity
> > we should store the config in the core / common code.
> 
> Yes, we lose the config in case of re-configuring channels. The reconfig 
> path involves freeing the vectors and reallocating based on the new 
> channel config, so, for the NAPIs associated with the vectors, 
> netif_napi_del and netif_napi_add executes creating new NAPI IDs 
> sequentially.
> 
> Wouldn't losing the explicit user config make sense in this case? By 
> changing the channel count, the user has updated the queue layout, the 
> queue<>vector mappings etc., so I think, the previous configs from set 
> queue<>NAPI should be overwritten with the new config from set-channel.

We do prevent indirection table from being reset on channel count
change. I think same logic applies here..

> > How does the user know whether queue <> NAPI association is based
> > on driver defaults or explicit configuration?  
> 
> I am not sure of this. ethtool shows pre-set defaults and current 
> settings, but in this case, it is tricky :(

Can you say more about the use case for moving the queues around?
If you just want to have fewer NAPI vectors and more queues, but
don't care about exact mapping - we could probably come up with
a simpler API, no? Are the queues stack queues or also AF_XDP?

> > I think I mentioned
> > this in earlier discussions but the configuration may need to be
> > detached from the existing objects (for one thing they may not exist
> > at all when the device is down).
> 
> Yes, we did have that discussion about detaching queues from NAPI. But, 
> I am not sure how to accomplish that. Any thoughts on what other 
> possible object can be used for the configuration?

We could stick to the queue as the object perhaps. The "target NAPI"
would just be part of the config passed to the alloc/start callbacks.

> WRT ice, when the device is down, the queues are listed and exists as 
> inactive queues, NAPI IDs exists, IRQs associations with the OS are freed.
> 
> > Last but not least your driver patch implements the start/stop steps
> > of the "queue API" I think we should pull that out into the core.
> 
> Agree, it would be good to have these steps in the core, but I think the 
> challenge is that we would still end up with a lot of code in the driver 
> as well, due to all the hardware-centric bits in it.

For one feature I think adding code in the core is not beneficial.
But we have multiple adjacent needs, so when we add up your work,
zero copy, page pool config, maybe queue alloc.. hopefully the code
in the core will be net positive.

> > Also the tests now exist - take a look at the sample one in
> > tools/testing/selftests/drivers/net/stats.py
> > Would be great to have all future netdev family extensions accompanied
> > by tests which can run both on real HW and netdevsim.  
> 
> Okay, I will write tests for the new extensions here.

