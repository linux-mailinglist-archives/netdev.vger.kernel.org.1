Return-Path: <netdev+bounces-142158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB879BDACE
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA697B2408E
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005681898E9;
	Wed,  6 Nov 2024 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTr9fcUi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC0B188CC6;
	Wed,  6 Nov 2024 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730854831; cv=none; b=UMNOVSNQmYAAGF903twyNXKfcLEPqRRYTsT9sMMcECT98IOxNsYwztgWlmprri4s7wi8I7NLtmIPI2feW2exf3HNQXMm3WhwsQnc0TNOvCmhorCy6WLNcMlcuraXhVd8bWNAfjHKw/4Ne7ChpNyTEyZ4+ASPyvnpfKoXXuJuiCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730854831; c=relaxed/simple;
	bh=2xq03IheQk0VtglJEByLAo5ZZJCKajQxQT8Gn6j/8M4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aFG7inVWswaXk/+nKMwWchFcBt0bCDp2MQCSBwNea47CUTD8ojHWIe7BIWzxlAAEodFET1ivHS0jM4gKg+eoJ9ep8Ga2OI05yyuYsW7Yi7gfXzfM9rSzbzafCId1g+AVrpLUYcb4sy7wBaEJKR76gaxmwhlXdjQjbSUcE+f19jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTr9fcUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A969EC4CED1;
	Wed,  6 Nov 2024 01:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730854831;
	bh=2xq03IheQk0VtglJEByLAo5ZZJCKajQxQT8Gn6j/8M4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aTr9fcUibE0gH6AAEA+tYyw0EGtpUqdJL7RxX67r+maqXeIDRfRLXZfRrvvrQbxUJ
	 NWmbErjhjkvXIQnh6SdZ/JE4YMnNpk97XEkyj8mzpAY2xuhbx3hKbWejiuil3nkzeE
	 Jfcj8XUDd9Gsp2N93INIzYlZYg9ppw7SqwwVIP9pkXMwJQkEhR5lqju9xTB4aVRP+s
	 aKxjgfwdsVGi1hEF0pbmwPXfK9TfRQiPvp/wye5faGIr9QzVQUG/QKQhnqwA93AwfM
	 9zm2MhJDa4VRyv4vSi2KO56hJ+qRIW6/5aeRug8nUxGxGAwBVZz7aa//BqW2U9Lntw
	 +NT9f6sLilmgQ==
Date: Tue, 5 Nov 2024 17:00:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davej@codemonkey.org.uk, vlad.wing@gmail.com,
 max@kutsevol.com, kernel-team@meta.com, jiri@resnulli.us, jv@jvosburgh.net,
 andy@greyhouse.net, aehkn@xenhub.one, Rik van Riel <riel@surriel.com>, Al
 Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH net-next 1/3] net: netpoll: Defer skb_pool population
 until setup success
Message-ID: <20241105170029.719344e7@kernel.org>
In-Reply-To: <20241104-nimble-scallop-of-justice-4ab82f@leitao>
References: <20241025142025.3558051-1-leitao@debian.org>
	<20241025142025.3558051-2-leitao@debian.org>
	<20241031182647.3fbb2ac4@kernel.org>
	<20241101-cheerful-pretty-wapiti-d5f69e@leitao>
	<20241101-prompt-carrot-hare-ff2aaa@leitao>
	<20241101190101.4a2b765f@kernel.org>
	<20241104-nimble-scallop-of-justice-4ab82f@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 12:40:00 -0800 Breno Leitao wrote:
> Let's assume the pool is full and we start getting OOMs. It doesn't
> matter if alloc_skb() will fail in the critical path or in the work
> thread, netpoll will have MAX_SKBS skbs buffered to use, and none will
> be allocated, thus, just 32 SKBs will be used until a -ENOMEM returns.

Do you assume the worker thread will basically keep up with the output?
Vadim was showing me a system earlier today where workqueue workers
didn't get scheduled in for minutes :( That's a bit extreme but doesn't
inspire confidence in worker replenishing the pool quickly.

> On the other side, let's suppose there is a bunch of OOM pressure for a
> while (10 SKBs are consumed for instance), and then some free memory
> show up, causing the pool to be replenished. It is better
> to do it in the workthread other than in the hot path.

We could cap how much we replenish in one go?

> In both cases, the chance of not having SKBs to send the packet seems to
> be the same, unless I am not modeling the problem correctly.

Maybe I misunderstood the proposal, I think you said earlier that you
want to consume from the pool instead of calling alloc(). If you mean
that we'd still alloc in the fast path but not replenish the pool
that's different.

> On top of that, a few other points that this new model could help more,
> in a OOM case.
> 
> 1) Now with Maksysm patches, we can monitor the OOMing rate
> 
> 2) With the pool per target, we can easily increase the pool size if we
> want. (patchset not pushed yet)


