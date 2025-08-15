Return-Path: <netdev+bounces-213891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C96CCB2743A
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A9E3B1EC1
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 00:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B061224F3;
	Fri, 15 Aug 2025 00:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/qz0bzy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25654C8EB
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 00:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755218892; cv=none; b=uHDAq6sMb+aTMGYNFdWtwiRvxwZrtOdkAN5WBVUyF8IucEhQUUzipuKq684MPOu6CUydF3IcxEtmfSGSVzeG4hhNe3r4qsMhcvi2QajIBruFLyQ8k3x4aHpSALHPNRwwOhUYUXxSCP8JPvPyAIqCsKVneOmywgg0aYEsam1AVpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755218892; c=relaxed/simple;
	bh=9xuHR9yEMaYoCQlVCOJnNAhVRweYn88H6OWA3/FpgP0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZzd0ZqOopezgJI3bp1u0M2n+vp//u5+jQEoeHRcuCwAaivY16gp5jLfsTwkvka5/dsiHn7nVh1qjTGvdVrhkeF9eSTdxhyIqoV3e7SIu6h+PFewe+H19teBen2GXFgfBIF2s6dyeKcfT0GOS8Bv6l9e2zUV9OjkFe4TwxvXPyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/qz0bzy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DED4C4CEED;
	Fri, 15 Aug 2025 00:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755218891;
	bh=9xuHR9yEMaYoCQlVCOJnNAhVRweYn88H6OWA3/FpgP0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G/qz0bzyl3rsonm371fiWgCPonG3C1aE4o908UPChQ7YVIJP5KzLoEkoKo7maMMDC
	 y3MA4grVB7sN2CUk9xxS5z7LQXHo/tE2rYuZQNER99LGMdbLr5sCBzEyKXpF5iIIf/
	 uDF40q42cHBDbqhpasMaKL0PClE02CzLouLs4g+LMKMIJ3vXnh6uUvEMDnT/kybkat
	 2Ig3fEHQvHWFgC69yaIuiWQvJ/cJxLqiq1CXcTT2ItuhGH/Tfz2cHheOXelEbELi7K
	 fQvMLYW55x/kWT4CTa2fFppmRjYsPMu279hl+Tv1FN6xfPMRn1IJvTlxRfsJpwkBN7
	 VapN4t3VVOV9Q==
Date: Thu, 14 Aug 2025 17:48:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 razor@blackwall.org, petrm@nvidia.com, horms@kernel.org
Subject: Re: [PATCH net-next 1/2] bridge: Redirect to backup port when port
 is administratively down
Message-ID: <20250814174810.4a5b2c9a@kernel.org>
In-Reply-To: <aJ2eSgyoj4JuxXrG@shredder>
References: <20250812080213.325298-1-idosch@nvidia.com>
	<20250812080213.325298-2-idosch@nvidia.com>
	<20250813172017.767ad396@kernel.org>
	<aJ2eSgyoj4JuxXrG@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 11:28:58 +0300 Ido Schimmel wrote:
> On Wed, Aug 13, 2025 at 05:20:17PM -0700, Jakub Kicinski wrote:
> > On Tue, 12 Aug 2025 11:02:12 +0300 Ido Schimmel wrote:  
> > >  	/* redirect to backup link if the destination port is down */
> > > -	if (rcu_access_pointer(to->backup_port) && !netif_carrier_ok(to->dev)) {
> > > +	if (rcu_access_pointer(to->backup_port) &&
> > > +	    (!netif_carrier_ok(to->dev) || !netif_running(to->dev))) {  
> > 
> > Not really blocking this patch, but I always wondered why we allow
> > devices with carrier on in admin down state. Is his just something we
> > have because updating 200 drivers which don't manage carrier today
> > would be a PITA? Or there's a stronger reason to allow this?
> > Hopefully I'm not misreading the patch..  
> 
> Probably the first reason.

Thanks, let me add clearing carrier to our list of potential cleanup
projects.

