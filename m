Return-Path: <netdev+bounces-93921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BD78BD976
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 04:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8D61F22C1A
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 02:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8901943AC1;
	Tue,  7 May 2024 02:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EreVdtlh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65292433AE
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 02:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715049678; cv=none; b=hYTLIoZWhqRrB+0Vg0mVR6C0f/90n/8hPO9O7NumeHOe29sSFZgnIC+tHek8fBjBpz2RsXDe89s0XbG6EcN4uJslVT25yjFVpVS9O5RJ7fwPgPVhPvgSf3kxXAEZjXX/Jh2O97tunSCw7MkBHyWuRGGUIt0MaOPB+jMflu0MHeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715049678; c=relaxed/simple;
	bh=GU1ZaUL+3eH1Fib3nPo3ivwuRvuSJqfCCxCK4vJM9wc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dqnrb6XCgB4eo5Km2lunvR555k+WqiCVUJQz/kWLrqAnvhO5qSbWXunnJGM1ZDewM9e30C0DxACziPFZiC8P+moUsuz/BK43rWoE0hsyWair+eKLR6O1XAWMIuxaMvb/O2eQeCj6VWdo1wQhO4BXU+R7as5jZfZziw2Mkt0sfWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EreVdtlh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D44C4AF65;
	Tue,  7 May 2024 02:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715049677;
	bh=GU1ZaUL+3eH1Fib3nPo3ivwuRvuSJqfCCxCK4vJM9wc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EreVdtlh94U43WlVmvEEU4i0AypThnif1yO0aD5MJrPMA3wdqkI9t3dUGm58y3sPK
	 eAHRIf9o1XzLICB3w6n7eEj4dNtk9zhMtvCPp6eokwe31gMbX78VzjBL18+/gH251s
	 DI/dGSio99qLAGCN7G42VuAENCBMWEPL6hPDMn3AAPFpfsfltNa1yEwLp3jof3OpRz
	 LcgnXibrxu9eIvth1UCKzGNyStzglNXgcTy9UO7anRq1mkmSUJY0yR2RR4TuybNkqb
	 CJmoIdyDHCrh+AGJLy4Yb4lhp8B8Zxro1paR/B6fX9MLW/EM+eew1ysMebkByoFpck
	 TYggaLswKZUsg==
Date: Mon, 6 May 2024 19:41:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq
 Toukan <tariqt@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Andrew
 Gospodarek <andrew.gospodarek@broadcom.com>, "michael.chan@broadcom.com"
 <michael.chan@broadcom.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Jiri Pirko <jiri@nvidia.com>, Alexander Duyck
 <alexander.duyck@gmail.com>
Subject: Re: Driver and H/W APIs Workshop at netdevconf
Message-ID: <20240506194116.6218cdbc@kernel.org>
In-Reply-To: <1c36d251-0218-4e9d-b6e3-0d477a5e6a02@kernel.org>
References: <c4ae5f08-11f2-48f7-9c2a-496173f3373e@kernel.org>
	<20240506180632.2bfdc996@kernel.org>
	<1c36d251-0218-4e9d-b6e3-0d477a5e6a02@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 May 2024 20:05:36 -0600 David Ahern wrote:
> On 5/6/24 7:06 PM, Jakub Kicinski wrote:
> > On Mon, 6 May 2024 13:59:31 -0600 David Ahern wrote:  
> >> Suggested topics based on recent netdev threads include
> >> - devlink - extensions, shortcomings, ...
> >> - extension to memory pools
> >> - new APIs for managing queues
> >> - challenges of netdev / IB co-existence (e.g., driven by AI workloads)
> >> - fwctl - a proposal for direct firmware access  
> > 
> > Memory pools and queue API are more of stack features.  
> 
> That require driver support, no? e.g., There is no way that queue API is
> going to work with the Enfabrica device without driver support.
> 
> The point of the above is a list to motivate discussion based on recent
> topics.

What the point of the above list is is pretty transparent.

> > Please leave them out of your fwctl session.  
> 
> fwctl is a discussion item not tied to anything else; let's not conflat
> topics here. That it is even on this list is because you brought netdev
> into a discussion that is not netdev related. Given that, let's give it
> proper daylight any topic deserves without undue bias and letting it
> dominate the bigger picture.

Obviously no objection to discussions about fwctl or whatever else 
you want. I am looking forward to you presenting about it "without
undue bias".

The other topics deserve their own sessions.

> > Aren't people who are actually working on those things submitting
> > talks or hosting better scoped discussions? It appears you haven't 
> > CCed any of them..  
> 
> I have no idea. I started with a list of well known driver contacts and
> cc'ed netdev with an explicit statement that it is open to all.

