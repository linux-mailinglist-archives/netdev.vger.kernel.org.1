Return-Path: <netdev+bounces-234325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD47C1F623
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 45FC334DA3F
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 09:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5F034AB06;
	Thu, 30 Oct 2025 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTP2xGv8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4980934B67B
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817726; cv=none; b=F1TVWG8T+W0VXvA00k39Pv3cdwzOFI48oekDSNfj+eyYj6ihd98zXGrn9bJXPBcu3FYItgxm2bmFNoEHPvjd7xlm6uByuWizaTSOfhV1T23ZoIBo8PkAOfp1rFxpABotyOR9rcmj5larBEx0tRtJDX1qM5x9Rr5KbBrNRUtub80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817726; c=relaxed/simple;
	bh=rdqCn+79FDkOmCNTnGw9wMoJ+Aqp8+MEUttWpdsgiPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EolYC4PC3vL9CnF/HkX5AQZLqKDUnopQFd+ZRDjNuKqGtQ8zP1ux4JU+SbJwgiCALHBmdFn+yUadmryisAsGcCcYFE5+S04tqqxxInDzuyoQrqI0pJ8JB57hdH2/KedY8cneXEHC9qaP84xW2dHa2JmBk1nkCAqC7IjG0cZ4Fx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTP2xGv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DD4C4CEFD;
	Thu, 30 Oct 2025 09:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761817725;
	bh=rdqCn+79FDkOmCNTnGw9wMoJ+Aqp8+MEUttWpdsgiPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pTP2xGv86bok05OHQKUZlC+vufhd15vb4LGupYK0Jmr7MgU/AG8sAEZIeFKPoZPH8
	 6q4Owu6GJ8vWqVtmZJNBYa76Vj7iWQ8HSEWO1g0PRLYg1SSRlKzcNIfLUf+PltE/xP
	 hRbbmrGLRO2DIEQItdHh9Fl4emH7usJqZ28cPpsoZcFMlFrIS2PrLvgYA0+otnqjOG
	 R6A2/cEoQJzpXpFlOxKMVOp9hG/MI1LLYkwKEdhp9Y0mtlI+p1SAlo10E7bNKZV11x
	 8V0r9DNp5kNMACAnQVcR8RiejAbmAQz4+v6qxOc3IaLQsd563gKsVN7f/RTjJBH/oR
	 sEKa2vE2IQagA==
Date: Thu, 30 Oct 2025 09:48:42 +0000
From: Simon Horman <horms@kernel.org>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, Tim Hostetler <thostet@google.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net 0/2] gve: Fix NULL dereferencing with PTP clock
Message-ID: <aQM0eqE2klsOq6A0@horms.kernel.org>
References: <20251029184555.3852952-1-joshwash@google.com>
 <aQMzWoIQvSa9ywe4@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQMzWoIQvSa9ywe4@horms.kernel.org>

On Thu, Oct 30, 2025 at 09:43:57AM +0000, Simon Horman wrote:
> On Wed, Oct 29, 2025 at 11:45:38AM -0700, Joshua Washington wrote:
> > From: Tim Hostetler <thostet@google.com>
> > 
> > This patch series fixes NULL dereferences that are possible with gve's
> > PTP clock due to not stubbing certain ptp_clock_info callbacks.
> > 
> > Tim Hostetler (2):
> >   gve: Implement gettimex64 with -EOPNOTSUPP
> >   gve: Implement settime64 with -EOPNOTSUPP
> > 
> >  drivers/net/ethernet/google/gve/gve_ptp.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> 
> Hi Joshua and Tim,
> 
> I think that the approach of enhancing the caller to only
> call these callbacks if they are non NULL, as per the patch below,
> seems more robust. It would fix all drivers in one go.
> 
> - [PATCH] ptp: guard ptp_clock_gettime() if neither gettimex64 nor
>   https://lore.kernel.org/all/20251028095143.396385-1-junjie.cao@intel.com/

Oops, I see that I should have read to the end of that thread
where Tim joins the discussion.

It seems that this patchset is appropriate as it's expected
that drivers expect an implementation of a variant of these callbacks.

