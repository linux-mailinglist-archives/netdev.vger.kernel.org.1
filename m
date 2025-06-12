Return-Path: <netdev+bounces-197245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FDBAD7E62
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 00:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F6818980E0
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB6822A7EF;
	Thu, 12 Jun 2025 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLaeI0GY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7771F537F8
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749767439; cv=none; b=SHncN3+Epn5IqhNfPJZ1W770aXZnl+yCUE2a9Tocgl9F9yWdu9cIgOXXSjAOncANjVIYQjql20HMfwouoZJgYUR4WzFfrwAP1d3JGRDjCoZ/TXO2Lg61Ad+c2J/xLNPrdwihSdg81x0AvGTLE5o6Us4Pw4yQ9L61EvAkFr4+ySU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749767439; c=relaxed/simple;
	bh=z3JqDN0RurhEs11enwMifDFI8raS3dimrYvetn4orAU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=loVDW7Zm7RzzPTDEobo8eFPdpU4X2q76CqahxIAP1au1cp0e81MqcEskrmnovnD8BJBRuqagXx1kfpPnMnIYNnJhj+FrtdIoyv0Q+rnRAhcn08jOboxskNDXhMZ4NwLzZf8nDyAFGIFx82ujQwxW0q3GH1XDPENVSy58uE86Yuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLaeI0GY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E102C4CEEA;
	Thu, 12 Jun 2025 22:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749767439;
	bh=z3JqDN0RurhEs11enwMifDFI8raS3dimrYvetn4orAU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TLaeI0GYPWIQAHrfNlHxZ6uS1TPrmeEmFjCluE5KpodKsHNnrvaubjStl8Fn/f5MF
	 nNI/jxkP/cWV4mAUDC3zJDZLHYxepY5eV6u9r19GNe0irvw58GR7BkNsYpMxQ1yHWA
	 ZgQuIAd76eMYwzdFIltvVBUg9pA/aILEuTsT7t0u8JF4mX9stBJEU8kyg+8c+iIyH8
	 7Xq6mVxyiij2kOv+FtGgN+k5Ww4N9DOMjBSsJvhyKlhD7BG3iPFu1nmxlFJAx5vBM7
	 4sJVt/lYtFtZ7KMSQ+2BCh8B0fc47wMaRtZVYFx4x0I8aU4uGiqFF41Qy4blI9tS8C
	 icHn5DxqCSqPw==
Date: Thu, 12 Jun 2025 15:30:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, almasrymina@google.com,
 dw@davidwei.uk, asml.silence@gmail.com, ap420073@gmail.com,
 jdamato@fastly.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 19/22] eth: bnxt: use queue op config validate
Message-ID: <20250612153037.59335f8f@kernel.org>
In-Reply-To: <vuv4k5wzq7463di2zgsfxikgordsmygzgns7ay2pt7lpkcnupl@jme7vozdrjaq>
References: <20250421222827.283737-1-kuba@kernel.org>
	<20250421222827.283737-20-kuba@kernel.org>
	<5nar53qzx3oyphylkiv727rnny7cdu5qlvgyybl2smopa6krb4@jzdm3jr22zkc>
	<20250612071028.4f7c5756@kernel.org>
	<vuv4k5wzq7463di2zgsfxikgordsmygzgns7ay2pt7lpkcnupl@jme7vozdrjaq>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 15:52:12 +0000 Dragos Tatulea wrote:
> On Thu, Jun 12, 2025 at 07:10:28AM -0700, Jakub Kicinski wrote:
> > On Thu, 12 Jun 2025 11:56:26 +0000 Dragos Tatulea wrote:  
> > > For the hypothetical situation when the user configures a larger buffer
> > > than the ring size * MTU. Should the check happen in validate or should
> > > the max buffer size be dynamic depending on ring size and MTU?  
> > 
> > Hm, why does the ring size come into the calculation?
> 
> There is a relationship between ring size, MTU and how much memory a queue
> would need for a full ring, right? Even if relationship is driver dependent.

I see, yes, I think I did something along those lines in patch 16 here.
But the range of values for bnxt is pretty limited so a lot fewer
corner cases to deal with.

Not sure about the calculation depending on MTU, tho. We're talking
about HW-GRO enabled traffic, they should be tightly packed into the
buffer, right? So MTU of chunks really doesn't matter from the buffer
sizing perspective. If they are not packet using larger buffers is
pointless.

> > I don't think it's a practical configuration, so it should be perfectly
> > fine for the driver to reject it. But in principle if user wants to
> > configure a 128 entry ring with 1MB buffers.. I guess they must have 
> > a lot of DRAM to waste, but other than that I don't see a reason to
> > stop them within the core?
> >  
> Ok, so config can be rejected. How about the driver changing the allowed
> max based on the current ring size and MTU? This would allow larger
> buffers on larger rings and MTUs.

Yes.

> There is another interesting case where the user specifies some large
> buffer size which amounts to roughly the max memory for the current ring
> and MTU configuration. We'd end up with a page_pool with a size of one
> which is not very useful...

Right, we can probably save ourselves from the corner cases by capping
the allowed configuration at the max TSO size so 512kB? Does that help?

> > Documenting sounds good, just wanna make sure I understand the potential
> > ambiguity.  
> Is it clearer now? I was just thinking about how to add support for this
> in mlx5 and stumbled into this grey area.

Yes, thanks!

