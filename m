Return-Path: <netdev+bounces-89353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36408AA1CB
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 20:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2D9285884
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 18:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AD8175552;
	Thu, 18 Apr 2024 18:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VachFFhF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DAE16191A
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 18:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713463751; cv=none; b=DjospEpmp7AsG/A7OSV3fwNjqIDMUKBM/qteS2vVVMCH8xWH2tRHHTQ5LY5JoA77gS+uIUlsB8ut1SNDlE2cc8ytF0ccR9zL2bQQbEV3XVsA9wtfXEy0vkg52fLwB5rCV+CfZ3EmKO/S+gPyQ7t3F3TzvK0BbaHUgRU3jF0SoxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713463751; c=relaxed/simple;
	bh=3rNSkNhcUifCus/pDc/GHg+UlzdQBgfjPbeuzpI3fGg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jvUldQmw0F757bmmLmwEvWAlr8vGUJR3fRJET0ye8bU1WJidUd1BlXP3e+i7Q+TiwYLzubvb7cOQHZLLvkZ8D/bVO4dqkjWstrGjVS3unZAAapHalzi3TIybwROQGWvmkTZS9iPiy1mJd9Rd6I3RPC81MgWU4zmh9UYtsNh1i4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VachFFhF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3ACC113CC;
	Thu, 18 Apr 2024 18:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713463751;
	bh=3rNSkNhcUifCus/pDc/GHg+UlzdQBgfjPbeuzpI3fGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VachFFhFPnO/GXGGkO77/31PbuygPo1XNcGZusfNzBpeuW2uDQVckdeZRWbgHvblK
	 kLAYx35WKeQrZGkoW0wVAvtUxYypA0D+PeKCij7l+9nsxEQKNzxS4XKO3KOVCqRkwN
	 WD+SZHbNswTr6VOXE9GtuuSF7nOd+/MCamafQ/FTqk5PdZlE2SN4lYV9SHB6G2pZgR
	 qp8a4xuVhVSNlmdKr79hF5PFZKAaAzwXfIl53QpQfwwiaFM5HzeIf4DUBgP+9UpXTd
	 OdCb4pEYATch90WW8V9PBuMVid0Ydo1dgWLPre7iwKozRaN9fh7D7XVCzZfJm1+eav
	 FIyxeOqvPBi7g==
Date: Thu, 18 Apr 2024 11:09:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S . Miller"
 <davem@davemloft.net>, netdev@vger.kernel.org, Neal Cardwell
 <ncardwell@google.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 eric.dumazet@gmail.com, Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?=
 <maze@google.com>, Willem de Bruijn <willemb@google.com>, Shachar Kagan
 <skagan@nvidia.com>
Subject: Re: [PATCH net-next 1/2] tcp: conditionally call ip_icmp_error()
 from tcp_v4_err()
Message-ID: <20240418110909.091b0550@kernel.org>
In-Reply-To: <CANn89iJOLPH72pkqLWm-E4dPKL4yWxTfyJhord0r_cPcRm9WiQ@mail.gmail.com>
References: <20240417165756.2531620-1-edumazet@google.com>
	<20240417165756.2531620-2-edumazet@google.com>
	<e332d0b8fa7b116003dfd8b47f021901e66b36b9.camel@redhat.com>
	<CANn89i+-cjHze1yiFZKr-cCGG7Fh4gb9NZnS1u4u_77bG2Mf6Q@mail.gmail.com>
	<CANn89iLSZFOYfZUSK57LLe8yw4wNt8vHt=aD79a1MbZBhfeRbw@mail.gmail.com>
	<7d1aa7d5a134ad4f4bca215ec6a075190cea03f2.camel@redhat.com>
	<CANn89iJg7AcxMLbvwnghN85L6ASuoKsSSSHdgaQzBU48G1TRiw@mail.gmail.com>
	<274d458e-36c8-4742-9923-6944d3ef44b5@kernel.org>
	<CANn89iJOLPH72pkqLWm-E4dPKL4yWxTfyJhord0r_cPcRm9WiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 19:47:51 +0200 Eric Dumazet wrote:
> > You have a kernel patch that makes a test fail, and your solution is
> > changing userspace? The tests are examples of userspace applications and
> > how they can use APIs, so if the patch breaks a test it is by definition
> > breaking userspace which is not allowed.  

Tests are often overly sensitive to kernel behavior, while this is
obviously a red flag it's not an automatic nack. The more tests we
have the more often we'll catch tiny changes. A lot of tests started
flaking with 6.9 because of the optimizations in the timer subsystem.
You know where I'm going with this..

> I think the userspace program relied on a bug added in linux in 2020
> 
> Jakub, I will stop trying to push the patches, this is a lost battle.

If you have the patches ready - please post them.
I'm happy to take the blame if they actually regress something in 
the wild :(

We're pursuing this because real application suffer real problems
when routing changes cause transient ICMP errors. Users read the RFC
and then come shouting at us that Linux is buggy.

