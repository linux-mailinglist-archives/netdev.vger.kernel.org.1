Return-Path: <netdev+bounces-236401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF54C3BDEA
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 15:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32203502579
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 14:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7D0345CBD;
	Thu,  6 Nov 2025 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4LcPUPS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934F73370F3
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440315; cv=none; b=Y8KQvx+GMt9Y/B14rfgUkGx8MFp0e5wfmEM7ui1ZWExXjLJ4u3pI4QSwpDQrIFMPQAhgGHogfew3dTmAjCcqVPgAxZceDvAgv4Fva3rnMujmGaPc10Qlh4BXoj59+IQyEAEzVkS9mThG9DWvB48XgdhqbF+wjhBc+MYguYKR6qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440315; c=relaxed/simple;
	bh=Q80581Prc+3nrPb4F5jxrxXb/jXURIh0xCGvL+3q5cE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PKgEC2erJKebRrTBOefoCkljRJ+0K2d4aqdBrvpJQHap/eQaeLKMWBcBPGFA8eI5ogbiqWYE6aXeoXdFbhyEPmtaMAk93+wuB3x1mY/NUV2aKnymurEdrfseeMQ/y6HbGPwIO7+GZeToPo7Qv1Uc/DGRaaBI7vdg2kbvel0Msyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4LcPUPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40846C4CEF7;
	Thu,  6 Nov 2025 14:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762440314;
	bh=Q80581Prc+3nrPb4F5jxrxXb/jXURIh0xCGvL+3q5cE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u4LcPUPS9a7VUoS/wGMOOZbcXmB6Ue2Z/QXhmTU9xN76lIn6Wv4ix20xwGvlxi2vK
	 xZSGQq5NZS081TYAc7xGcz/hj954eFUWD9BFJ0v3RIpg/cmIqQH9BkxozO0pyYeGmk
	 ZzccXxGMuJevsdeFrvIo+CB88m5/h9oMqefwcPKAi3o67EnihhYRga8rvxs90O6TpZ
	 7b4BGJvtcxePho0uxeyA4Bp41AfGbjS6Bj33Kub9dY63KJWxBlSb/jNgRvOoczRwvr
	 uWovGYjgDubBhv1zsjHZjZQ5SnisFkr0UwGlqtmfnPGrI+uQxa258fRGOG4NzKy8m0
	 som2daZobqYMw==
Date: Thu, 6 Nov 2025 06:45:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jan Stancek
 <jstancek@redhat.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?= <ast@fiberby.net>,
 Stanislav Fomichev <sdf@fomichev.me>, Ido Schimmel <idosch@nvidia.com>,
 Guillaume Nault <gnault@redhat.com>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCHv2 net-next 3/3] tools: ynl: add YNL test framework
Message-ID: <20251106064512.086e9cb9@kernel.org>
In-Reply-To: <aQwKmZ6vF9dWZzqa@fedora>
References: <20251105082841.165212-1-liuhangbin@gmail.com>
	<20251105082841.165212-4-liuhangbin@gmail.com>
	<20251105183313.66a8637e@kernel.org>
	<aQwKmZ6vF9dWZzqa@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Nov 2025 02:40:25 +0000 Hangbin Liu wrote:
> On Wed, Nov 05, 2025 at 06:33:13PM -0800, Jakub Kicinski wrote:
> > On Wed,  5 Nov 2025 08:28:41 +0000 Hangbin Liu wrote:  
> > > Add a test framework for YAML Netlink (YNL) tools, covering both CLI and
> > > ethtool functionality. The framework includes:
> > > 
> > > 1) cli: family listing, netdev, ethtool, rt-* families, and nlctrl
> > >    operations
> > > 2) ethtool: device info, statistics, ring/coalesce/pause parameters, and
> > >    feature gettings
> > > 
> > > The current YNL syntax is a bit obscure, and end users may not always know
> > > how to use it. This test framework provides usage examples and also serves
> > > as a regression test to catch potential breakages caused by future changes.  
> > 
> > And how would we run all the tests in the new directory?
> > 
> > Since we have two test files we need some way to run all.  
> 
> I didn't get your requirement. We can run them one by one in the test folder.
> 
>  # ./test_ynl_cli.sh
>  # ./test_ynl_ethtool.sh
> 
> Do you want to use a wrapper to run the 2 tests? e.g.
>  # ./run_all_ynl_tests.sh

Or make run_tests, like ksft

