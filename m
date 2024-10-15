Return-Path: <netdev+bounces-135909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A58B999FC65
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 01:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4B31F21730
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 23:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B681D63E7;
	Tue, 15 Oct 2024 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCavwmTh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A38519C542;
	Tue, 15 Oct 2024 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034549; cv=none; b=mwupl2wlXaw3yBfafcoEmkkymwih+pIbrnxjb8rP3zWMDV630wawbbXT8i39nJ8drfVo5YT62PEwQdH0I9eI1sfz7c/70C+16A+XkoKe3exIj87nPUHyar7Cpo1RpdcgpHpeJFusTy8XNl8J+wyo2bjaPhHTSd6qEOnTAfQXI64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034549; c=relaxed/simple;
	bh=SZbokGXMJZ3coHJvqdScXDpyPhe0Y00MZjJqgrpRdPs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BDz4jMiq/q/el6vETfCBqi49LDVfBvEyhiBg+aW+tiXh7Q+tp4jVR8DytX5jYdC2tLn3e6/+R4ObpPrWJ39us/ap+v9VPW8KFpZd+fNTeRyzpqf8krClaBmDHZOrxq2zfhSRSi4qKHEn70m9Gs0OcPNGfr1XpZ2zqkZtZXtF9G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCavwmTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0F3C4CEC6;
	Tue, 15 Oct 2024 23:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729034549;
	bh=SZbokGXMJZ3coHJvqdScXDpyPhe0Y00MZjJqgrpRdPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MCavwmThkKLRCH1gx9a9O0fFGORP/RNa+Dv9/0uvpZkeiuCXPVI+M9vzStMaV8jLK
	 D+dc33UWSljwE/fv6MKsEdjawDnxveO7My8XzRmVn5nr3DtGE3zpZzuIOeSX7A3pFG
	 iPyiNW0j3kOws/JWEjZwo+b/1PkI0g/jSNFWCzQVfKFLGglTLQQ1xtenTSDph9cFnY
	 AZz3mWaFyBoMAwNPi+eZd4oe/S5NfKfE4AxNM/B3EQQ6RS76QFIffgO03DA9c5TvuM
	 YaS9OrzjlmpVOnbGXkG8+ySVGvrppcUvbu1wfrFxUm7VvaPlvz4YFwoZhK90aiKm4N
	 YzR9HO48LPNPg==
Date: Tue, 15 Oct 2024 16:22:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, bryan.whitehead@microchip.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 anna-maria@linutronix.de, frederic@kernel.org, richardcochran@gmail.com,
 johnstul@us.ibm.com, UNGLinuxDriver@microchip.com, jstultz@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 RESEND 1/2] posix-clock: Fix missing timespec64 check
 in pc_clock_settime()
Message-ID: <20241015162227.4265d7b2@kernel.org>
In-Reply-To: <87v7xtc7z5.ffs@tglx>
References: <20241009072302.1754567-1-ruanjinjie@huawei.com>
	<20241009072302.1754567-2-ruanjinjie@huawei.com>
	<20241011125726.62c5dde7@kernel.org>
	<87v7xtc7z5.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Oct 2024 00:33:02 +0200 Thomas Gleixner wrote:
> > I'm guessing we can push this into 6.12-rc and the other patch into
> > net-next. I'll toss it into net on Monday unless someone objects.  
> 
> Can you folks please at least wait until the maintainers of the code in
> question had a look ?

You are literally quoting the text where I say I will wait 3 more days.
Unfortunately "until the maintainers respond" leads to waiting forever
50% of the time, and even when we cap at 3 working days we have 300
patches in the queue (292 right now, and I already spent 2 hours
reviewing today). Hope you understand.

Sorry if we applied too early, please review, I'll revert if it's no
good.

