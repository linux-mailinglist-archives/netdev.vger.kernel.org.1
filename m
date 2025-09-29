Return-Path: <netdev+bounces-227177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15ACBA981A
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 16:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CCE4206C2
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 14:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDB3305943;
	Mon, 29 Sep 2025 14:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tn5KEe5I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F732FE07F;
	Mon, 29 Sep 2025 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155122; cv=none; b=uuhODoGb/0AVG8zG55mdhD9+6Frs4TPvCme5nN0nt7GvfbgHtsAQQXx1rwr6Emiy4EzSg5ZnUamWa/J3xX8TSmH8yXEROvR8vvVxCyw6WVHDicu7cr3WSjCPlEsOadA3SSe0K4B8+putpHwPMIrLkIZgM3ZpsWjBrEm92yHUNxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155122; c=relaxed/simple;
	bh=slCDiUU06Q4F/rnOMHNPxytY46U+eubzlvdVrMsb6k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzbvAIrq7gaXJGCiyVVd2gpwz4Q3gqSgvgqg4nwnRL8i46Ygda6dJZ3LdFy/9haGBVMvnwD2F75iwkwaK6/vCP2EpfdFG5IBdteZXHRdrUqBlMn/0mu3kJYNVRKigHaQQrvAFq+uOPbYG2wJj4fBVNxaraXD6JKkcIRlGMQcvms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tn5KEe5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF79C4CEF4;
	Mon, 29 Sep 2025 14:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759155121;
	bh=slCDiUU06Q4F/rnOMHNPxytY46U+eubzlvdVrMsb6k4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tn5KEe5IX4agGO59SOHNa2NwDo8gLlJMZH/bdrfW2lfbUUs3ejS9ymjxu5eLbMb06
	 Ik/8RXohWqc/FMvItYZSYIPQEsQF0r324+ErEfsXS6gO3LCuFduPFjSBSlX6KudUUX
	 fERIfusIBewmcVAUgNGz7wdbkbC4NAaZkS5b0/jrN6G+0iKWZot2ozjE2XRJZxy84g
	 cwvPTmYlwrcSssLnxFBslqoQNt2bWjvciSRB9OrIeljy3lD3EY2mUkIM1clhWGM1QE
	 PggkvGJUl1XgG+clUZFkrGt402iL+mgqCilAqJQJBHikzF4+FC6xuZJUnzjK6JU4/Q
	 M3U8GRh6DOe5Q==
Date: Mon, 29 Sep 2025 15:11:57 +0100
From: Simon Horman <horms@kernel.org>
To: Byungchul Park <byungchul@sk.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, almasrymina@google.com,
	hawk@kernel.org, toke@redhat.com, asml.silence@gmail.com
Subject: Re: [PATCH net-next v3] netmem: replace __netmem_clear_lsb() with
 netmem_to_nmdesc()
Message-ID: <aNqTrWsvvvSw8GM4@horms.kernel.org>
References: <20250926035423.51210-1-byungchul@sk.com>
 <aNau1UuLdO296pJf@horms.kernel.org>
 <20250929014619.GA20562@system.software.com>
 <20250929074840.GA19203@system.software.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929074840.GA19203@system.software.com>

On Mon, Sep 29, 2025 at 04:48:40PM +0900, Byungchul Park wrote:
> On Mon, Sep 29, 2025 at 10:46:19AM +0900, Byungchul Park wrote:
> > On Fri, Sep 26, 2025 at 04:18:45PM +0100, Simon Horman wrote:
> > > On Fri, Sep 26, 2025 at 12:54:23PM +0900, Byungchul Park wrote:
> > > > Changes from RFC v2:
> > > >       1. Add a Reviewed-by tag (Thanks to Mina)
> > > >       2. Rebase on main branch as of Sep 22
> > > >
> > > > Changes from RFC:
> > > >       1. Optimize the implementation of netmem_to_nmdesc to use less
> > > >          instructions (feedbacked by Pavel)
> > > >
> > > > --->8---
> > > > >From 01d23fc4b20c369a2ecf29dc92319d55a4e63aa2 Mon Sep 17 00:00:00 2001
> > > > From: Byungchul Park <byungchul@sk.com>
> > > > Date: Tue, 29 Jul 2025 19:34:12 +0900
> > > > Subject: [PATCH net-next v3] netmem: replace __netmem_clear_lsb() with netmem_to_nmdesc()
> > > >
> > > > Now that we have struct netmem_desc, it'd better access the pp fields
> > > > via struct netmem_desc rather than struct net_iov.
> > > >
> > > > Introduce netmem_to_nmdesc() for safely converting netmem_ref to
> > > > netmem_desc regardless of the type underneath e.i. netmem_desc, net_iov.
> > > >
> > > > While at it, remove __netmem_clear_lsb() and make netmem_to_nmdesc()
> > > > used instead.
> > > >
> > > > Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
> > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > > Reviewed-by: Mina Almasry <almasrymina@google.com>
> > > 
> > > Hi Byungchul,
> > > 
> > > Some process issues from my side.
> > > 
> > > 1. The revision information, up to including the '--->8---' line above
> > >    should be below the scissors ('---') below.
> > > 
> > >    This is so that it is available to reviewers, appears in mailing
> > >    list archives, and so on. But is not included in git history.
> > 
> > Ah yes.  Thank you.  Lemme check.
> > 
> > > 2. Starting the patch description with a 'From: ' line is fine.
> > >    But 'Date:" and 'Subject:' lines don't belong there.
> > > 
> > >    Perhaps 1 and 2 are some sort of tooling error?
> > > 
> > > 3. Unfortunately while this patch is targeted at net-next,
> > >    it doesn't apply cleanly there.
> > 
> > I don't understand why.  Now I just rebased on the latest 'main' and it
> > works well.  What should I check else?
> 
> I think 1 and 2 ends in 3.  I will fix it and resend it after the merge
> window.

Great, thanks!

