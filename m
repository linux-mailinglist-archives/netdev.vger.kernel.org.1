Return-Path: <netdev+bounces-120229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 935AE9589F9
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50638287DC4
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8389191F9B;
	Tue, 20 Aug 2024 14:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O32OhsOS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF78191F94;
	Tue, 20 Aug 2024 14:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164864; cv=none; b=UbTsGWpARBciDuBvmnrRsZYSpiDj8SuRNWcKgN2/QvC9CE36ZOZvRuips5pFfmaU46TxsJr2rcUOjGLXjGDTyanEFlJGz5hHL4WQop/bvv7JCqy9lUaWxOEXVGqClu/xqtj798h+4wv3hrqo6ipooFf1fhGU1T/pmn+DwdR1Ujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164864; c=relaxed/simple;
	bh=MZ+n+nKmV2N6aH3srELSOnz9POMtf3OdquRNxHry29w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eWrNr9/5To4OGRX5g9cSyW7Wg99TBqBo6RIJdtRYOSDsecNpNV1cLC1ZNdobGimG8a1q9SDRPPXqzSqlPqls6/r4/2MTZBPskbxC8O/wkMJPBpxNbWHBTha09WA5Rp6kwG79DxEAQReAvWbfiOyOEEU1eXwnHstyQnY6Hni+im4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O32OhsOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF81C4AF0B;
	Tue, 20 Aug 2024 14:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724164864;
	bh=MZ+n+nKmV2N6aH3srELSOnz9POMtf3OdquRNxHry29w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O32OhsOSY2qbVyuWpCYx4r8brPLbVpbN15TRMNK99JdOObKBZt30mkkijGytohSeW
	 H/sXgoqUD4lxEhncYy67EXHaMoOZHZqcbkpRQLWThtXzEG8DMdu53AfFEnXzzWcUq+
	 hwnmOrxOYzgRl3smFi2CZrQzLNN7rzGUwdkGLRdiDMJ51FrBssDshY6FdCC36vWU5A
	 05sxSZnEHiiz250yy9+ptmdlDIyxoGw/WJ7jTgTiS7iMLVi+xGdOB9wYe1RjY6X1L9
	 37K7PXNwC9BAlsqbatMpVZWnMxsZqXI50vzhB98rF1qd4YdQWNaH9d24jrHMmiXZEp
	 DIAE1HrWLNntA==
Date: Tue, 20 Aug 2024 07:41:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Larry Chiu <larry.chiu@realtek.com>
Cc: Justin Lai <justinlai0215@realtek.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
 "jiri@resnulli.us" <jiri@resnulli.us>, "horms@kernel.org"
 <horms@kernel.org>, "rkannoth@marvell.com" <rkannoth@marvell.com>,
 "jdamato@fastly.com" <jdamato@fastly.com>, Ping-Ke Shih
 <pkshih@realtek.com>
Subject: Re: [PATCH net-next v27 07/13] rtase: Implement a function to
 receive packets
Message-ID: <20240820074102.52c7c43a@kernel.org>
In-Reply-To: <5317e88a6e334e4db222529287f643ec@realtek.com>
References: <20240812063539.575865-1-justinlai0215@realtek.com>
	<20240812063539.575865-8-justinlai0215@realtek.com>
	<20240815185452.3df3eea9@kernel.org>
	<5317e88a6e334e4db222529287f643ec@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 05:13:32 +0000 Larry Chiu wrote:
> > Memory allocation failures happen, we shouldn't risk spamming the logs.
> > I mean these two messages and the one in rtase_alloc_rx_data_buf(),
> > the should be removed.
> > 
> > There is a alloc_fail statistic defined in include/net/netdev_queues.h
> > that's the correct way to report buffer allocation failures.  
> 
> Hi, Jakub,
> Can we just count the rx_alloc_fail here?
> If we implement the "netdev_stat_ops", we can report this counter.

I think so.

> > And you should have a periodic service task / work which checks for
> > buffers being exhausted, and if they are schedule NAPI so that it tries
> > to allocate.  
> 
> We will redefine the rtase_rx_ring_fill() to check the buffers and
> try to get page from the pool.
> Should we return the budget to schedule this NAPI if there are some
> empty buffers?

I wouldn't recommend that. If system is under memory stress 
we shouldn't be adding extra load by rescheduling NAPI.

