Return-Path: <netdev+bounces-106520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429A7916A8A
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3218281224
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBD02E403;
	Tue, 25 Jun 2024 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h44z17U+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03D61BC57
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326127; cv=none; b=YKanY4XTiutEsZ43bEwAro2ZHXIRPjfDUj54xpqUFksgMgOXa6C0OmgBzwY/Y6BKahXQ7A5hWTc6Zk8ZoBvvSW/iDQyLHoEs1o/r93M/XlPwpW6H2M48EN6WWT3BZWU8rMjyfyjxaew/5DUPM0JZrR3nahWOy9sQMB0oB1Lz9EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326127; c=relaxed/simple;
	bh=IAUPYadbgDwMiKZqfd5rFzgmRATBgya3Nmgiif1m6BY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwfp3r7vV2aYb48+yOdQssXvDuaZQL2v3ylSP1NBnvh3FVo3gHpSAWAy8WECpHrtnMXSw++tV87/kWyqCh5bnVdE5xclYKYwpvzQoPh4oDCNEFab8WBzUNQ1dDUDt9QKIle6i/N4vTbtoZ0GG+KxPYx3xX/xJ/hL7eapSqrnEV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h44z17U+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC95AC32781;
	Tue, 25 Jun 2024 14:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719326126;
	bh=IAUPYadbgDwMiKZqfd5rFzgmRATBgya3Nmgiif1m6BY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h44z17U+aWtz95SBOQzLbViZVZ6BZzfOAb6Bfp8Hjt6GR9nut2Yk4B7NfYrM/dETz
	 adX8WPqL7v9INcqBqXBe6LSu4WBuwFZEl10/wVTlREjJG8mVWOYIOT++OdXvr64hLK
	 Ytr0e2fj41s2rz0X22p190IJBsh+14NlEvzI5mQK5L5WULyvywpV2pTnWJSvMFNAzg
	 GF7mmgVf0GorOoh7A7p5oUsmBw7g0iE52XvLG4/lUQNXTvNJTGFejq7HRkvKbs5JuR
	 kExZKBRQdicVABIubcwbaZGG6Umkxmh7umBhwkAEgWL3cpHFHDvmsCYnESkxoYAt3y
	 ZIlhMJn8xrWXg==
Date: Tue, 25 Jun 2024 07:35:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Amit Cohen <amcohen@nvidia.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <hawk@kernel.org>, <idosch@nvidia.com>, <petrm@nvidia.com>,
 <mlxsw@nvidia.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH RFC net-next 0/4] Adjust page pool netlink filling to
 non common case
Message-ID: <20240625073525.5b1b30a1@kernel.org>
In-Reply-To: <20240625120807.1165581-1-amcohen@nvidia.com>
References: <20240625120807.1165581-1-amcohen@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 15:08:03 +0300 Amit Cohen wrote:
> Most network drivers has 1:1 mapping between netdevice and event queues,
> so then each page pool is used by only one netdevice. This is not the case
> in mlxsw driver.
> 
> Currently, the netlink message is filled with 'pool->slow.netdev->ifindex',
> which should be NULL in case that several netdevices use the same pool.
> Adjust page pool netlink filling to use the netdevice which the pool is
> stored in its list. See more info in commit messages.
> 
> Without this set, mlxsw driver cannot dump all page pools:
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> 	--dump page-pool-stats-get --output-json | jq
> []
> 
> With this set, "dump" command prints all the page pools for all the
> netdevices:
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> 	--dump page-pool-get --output-json | \
> 	jq -e ".[] | select(.ifindex == 64)" | grep "napi-id" | wc -l
> 56
> 
> From driver POV, such queries are supported by associating the pools with
> an unregistered netdevice (dummy netdevice). The following limitations
> are caused by such implementation:
> 1. The get command output specifies the 'ifindex' as 0, which is
> meaningless. `iproute2` will print this as "*", but there might be other
> tools which fail in such case.
> 2. get command does not work when devlink instance is reloaded to namespace
> which is not the initial one, as the dummy device associated with the pools
> belongs to the initial namespace.
> See examples in commit messages.
> 
> We would like to expose page pool stats and info via the standard
> interface, but such implementation is not perfect. An additional option
> is to use debugfs, but we prefer to avoid it, if it is possible. Any
> suggestions for better implementation in case of pool for several
> netdevices will be welcomed.

If I read the code correctly you dump all page pools for all port
netdevs? Primary use for page pool stats right now is to measure
how much memory have netdevs gobbled up. You can't duplicate entries,
because user space may double count the memory...

How about we instead add a net pointer and have the page pools listed
under loopback from the start? That's the best we can do I reckon.
Or just go with debugfs / ethtool -S, the standard interface is for
things which are standard. If the device doesn't work in a standard way
there's no need to shoehorn it in. This series feels a bit like checkbox
engineering to me, if I'm completely honest..

