Return-Path: <netdev+bounces-96147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA968C47EB
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 21:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA70283090
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 19:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67F378C9B;
	Mon, 13 May 2024 19:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/cmjbZd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D9C3C08A;
	Mon, 13 May 2024 19:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715630215; cv=none; b=bT6NORGrP2HwaTdBRxOoPuGMDx6BR3p81rG35oekHRKL7qgbWlA+HuZVaFkvPZjsYrtsSxKetFoQV0EfBTD4J+kGQt9H4E1e6VSu5w9sC29Ftkg0PFVVAOgmzltreMGldVBcCrHLHTEIRCJfZLNoI8uEaJpsUaXLSlWZpkEFbug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715630215; c=relaxed/simple;
	bh=wVrCYAqrup8syMMMZL9tLVORbn9Co7XWkPqPW6wAFuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhHTIxfUfXiHnRLKrY2chkQg6Ma1zXE9OWWB8SEe0aA+gpEmvIApy8lo4Yt9Q6mjeL5ZKovh3kLu1YcWoW+LtspAEdOPU5V25Wo79IChD0fSBoixOxU/AilTu7QJiCE/bHsih/HvOpKM5zjXn9n4024vF/OW+fgKzTVPHgEfBSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/cmjbZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66545C113CC;
	Mon, 13 May 2024 19:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715630215;
	bh=wVrCYAqrup8syMMMZL9tLVORbn9Co7XWkPqPW6wAFuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S/cmjbZdCBk/3Ayuu5OwujnOaJESu+1DwgXVdlrQh8dEClczdzlMYQX0izHXQcszx
	 oWRMcOuW5rT591OelN2TTSMqbogi9V4IjypJiz8JT5SwnjeJVl/ke+plEUjL85r37h
	 SGLqlThJxHmBDdbRpnP/i1gr6esr6GKSEsvH6X/kLP452u+jSbtEiLDdX1nN65EaHy
	 84SkGbBKu5kSzqr3oVT0ke9XLA9oqjoZyAz1m/TpM5FNUlIqop6K9aCKRPN7ISfK0m
	 DvEATrUTujjZvbY5E/xsnGVm1G4ZYAMwkMAQPqDjx8YgzlgMVJClZn4E5zXqIJ1qOn
	 oaqxyFai26xoQ==
Date: Mon, 13 May 2024 20:56:49 +0100
From: Simon Horman <horms@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
	richardcochran@gmail.com, andrew@lunn.ch, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net] net: fec: avoid lock evasion when reading pps_enable
Message-ID: <20240513195649.GY2787@kernel.org>
References: <20240513015127.961360-1-wei.fang@nxp.com>
 <20240513195459.GX2787@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513195459.GX2787@kernel.org>

On Mon, May 13, 2024 at 08:54:59PM +0100, Simon Horman wrote:
> On Mon, May 13, 2024 at 09:51:26AM +0800, Wei Fang wrote:
> > The assignment of pps_enable is protected by tmreg_lock, but the read
> > operation of pps_enable is not. So the Coverity tool reports a lock
> > evasion warning which may cause data race to occur when running in a
> > multithread environment. Although this issue is almost impossible to
> > occur, we'd better fix it, at least it seems more logically reasonable,
> > and it also prevents Coverity from continuing to issue warnings.
> > 
> > Fixes: 278d24047891 ("net: fec: ptp: Enable PPS output based on ptp clock")
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Sorry, I convinced myself this is correct.
But I now see that questions have been raised by others.
So please ignore the above.

