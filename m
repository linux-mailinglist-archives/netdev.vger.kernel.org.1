Return-Path: <netdev+bounces-125806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5921396EB71
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 09:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07D831F21A25
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 07:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7444414BFA2;
	Fri,  6 Sep 2024 07:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RImlA/LC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4561314BF8F;
	Fri,  6 Sep 2024 07:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725606222; cv=none; b=qNkn+Gf0WA96BeviOzXgmk1yXEWMucdOIhxD9A85BAyl4yDR+sM8VZNnr+X0USB0nnQK/kWsc6oxwwRyRxqEhcdqIFRt/0MqCenyDu+wOOMYlDbWsBGEejeNnggS7jTgjujEeDESj5T5KkU19q/igf8ATCqWjXUhrMfbazjVUNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725606222; c=relaxed/simple;
	bh=XosyfNwJeFXOQHRLgM+l6NjMHrTnOYEKaf5JavecBl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2cKFFEoCziCosA3OgjOZbzJFmQN0BxPQc/mN8Vq/9BMvjLyyUtrCXyzR9de0UmIS6YxFRN4SpdjNMbAzvL/EDOFuUee/plfGy1Dib5oR5E5aWL9AP7VIMqpo7i7ZQemDLSIfWBrtGtc9Y+hI6mcYCqr2GPL0Z2EoTYKLp0uN0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RImlA/LC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900ABC4CEC4;
	Fri,  6 Sep 2024 07:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725606220;
	bh=XosyfNwJeFXOQHRLgM+l6NjMHrTnOYEKaf5JavecBl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RImlA/LCGzIxQrv5on0OCtCoLNLx/B45N3EYOs+TSxZqcJteZxindT458nHNTnff9
	 LX+sY++09mpOpLReSItz4hujPrkjUxLAzF7Pq7OoxS1nQWeCX23dYH2g30msvL+esR
	 LuEnSwVxmyM6QXIL0Isqsy9i3V2DpXgJbaP4Hz6pQYfUo29u/IKwwew3KXf1CD9eAu
	 W0TJca3+CcuULOCkW8HkFq0cqJqbBbph567PFu+0VYEDXnrog93eplHSsQJvdNUbqN
	 jfEBT9ADPOtD31MgpHJhGFIAayZYfiZZiCqyJe0TgDy4n8V0Q1KXLeBhn7K1KF4m1G
	 eeHB9rbN69T8A==
Date: Fri, 6 Sep 2024 08:03:36 +0100
From: Simon Horman <horms@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next 0/2] net: xilinx: axienet: Enable adaptive IRQ
 coalescing with DIM
Message-ID: <20240906070336.GJ1722938@kernel.org>
References: <20240903192524.4158713-1-sean.anderson@linux.dev>
 <20240904163503.GA1722938@kernel.org>
 <d2470924-78a2-4905-a24f-afb127644d70@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2470924-78a2-4905-a24f-afb127644d70@linux.dev>

On Thu, Sep 05, 2024 at 10:27:00AM -0400, Sean Anderson wrote:
> On 9/4/24 12:35, Simon Horman wrote:
> > On Tue, Sep 03, 2024 at 03:25:22PM -0400, Sean Anderson wrote:
> >> To improve performance without sacrificing latency under low load,
> >> enable DIM. While I appreciate not having to write the library myself, I
> >> do think there are many unusual aspects to DIM, as detailed in the last
> >> patch.
> >> 
> >> This series depends on [1].
> >> 
> >> [1] https://lore.kernel.org/netdev/20240903180059.4134461-1-sean.anderson@linux.dev/
> > 
> > Hi Sean,
> > 
> > Unfortunately the CI doesn't understand dependencies,
> > and so it is unable to apply this patchset :(
> > 
> > I would suggest bundling patches for the same driver for net-next
> > in a single patchset. And in any case, only having one active
> > at any given time.
> > 
> 
> Well, I would normally do so, but that patch is a fix and this series is
> an improvement. So that one goes into net and this one goes into net-next.
> 
> I've been advised in the past to split up independent patches so they can be
> reviewed/applied individually.

Thanks Sean,

Understood. Given the first point, which I had missed earlier,
I'd would have suggested marking this patch-set as an RFC,
then reposting it once the dependency hits net-next (via net).

