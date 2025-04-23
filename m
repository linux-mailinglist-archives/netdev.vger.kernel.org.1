Return-Path: <netdev+bounces-185330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454CBA99C64
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 01:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E081D3AAFBF
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 23:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07341242D65;
	Wed, 23 Apr 2025 23:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtRERTYi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AD2223DC5;
	Wed, 23 Apr 2025 23:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745452580; cv=none; b=Aj3Cgf82lkFNYEJBvMWViwE4pdb3Q1yTFzV28bSL+iX80GLVot3ir1efZsGH3uKvK/n59qIlRYLIBOJjU6DuGESyCL3rmmcA3zS8blRMrnu5LAMY9wNYNwGZ0V2CcDdEzG1qR7sF45t/8Lx69CmcnL20gwKkfJUze5qEr9F/vcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745452580; c=relaxed/simple;
	bh=H78yLHBJB30n00t0Fz5nldwEa0TXPfc00B/IIw46tdY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PKMNB4oM5J5mZtPHe6n4BBBX8Bgk2uoVk6idZ/APOuFUkUUeqUl5j59l6psp9iL0Al1s6EceukNwgW+9DNNOvcChM+kAKK8PHqUD4ecp0w8NWldMTdwy7TCdKsunQHN2p11hW32MVCUGD3cw+CTGtDp0ronW4qnSpUOwg8xPfhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtRERTYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFCBC4CEE2;
	Wed, 23 Apr 2025 23:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745452580;
	bh=H78yLHBJB30n00t0Fz5nldwEa0TXPfc00B/IIw46tdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jtRERTYiY9EFQnYaVONH5QHgmJXrThdUoi/4cTr6vt5F0xq4/sxDzgWJJWagDpgw8
	 DGweeQNkowJqZCEgDszSeYkTvj7G/rqUMQb5fo3soFTYWRFPHr0xTcqyFeko0xyqCE
	 v7/kFwXRvEtRM7DTTAiKRMZvBe0L6EPonrJXtC7ymIBdvIEyeozO+8gmYgpXwXFNi2
	 m7+9+dskaK1D+SSKD6k7334jbilzjoagiHwNS9hjzLmzaeccUrKwjOjQLnYLYoMJn2
	 HJkp4ShgI8XnATPhKnDVqhGxfVk2YGuYr8IsHf6jbqsoc8vqJcGrtCcLFHCrpo0X7/
	 4NfvwIi/vhfNg==
Date: Wed, 23 Apr 2025 16:56:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "David S. Miller"	
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni	
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima	
 <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, Nathan Chancellor	
 <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Thomas
 =?UTF-8?B?V2Vpw59zY2h1aA==?=	 <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH v4 0/7] ref_tracker: add ability to register a debugfs
 file for a ref_tracker_dir
Message-ID: <20250423165619.588e9d29@kernel.org>
In-Reply-To: <874384e751867bf994662844238d0f248aa339d1.camel@kernel.org>
References: <20250418-reftrack-dbgfs-v4-0-5ca5c7899544@kernel.org>
	<20250423164431.7b40ecae@kernel.org>
	<874384e751867bf994662844238d0f248aa339d1.camel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 19:48:29 -0400 Jeff Layton wrote:
> On Wed, 2025-04-23 at 16:44 -0700, Jakub Kicinski wrote:
> > On Fri, 18 Apr 2025 10:24:24 -0400 Jeff Layton wrote:  
> > > This version should be pretty close to merge-ready. The only real
> > > difference is the use of NAME_MAX as the field width for on-stack
> > > sprintf buffers.  
> > 
> > Merge via which tree?  
> 
> Good Q. get_maintainer.pl says Andrew owns the ref_tracker code:
> 
> $ ./scripts/get_maintainer.pl lib/ref_tracker.c
> Andrew Morton <akpm@linux-foundation.org> (maintainer:LIBRARY CODE)
> linux-kernel@vger.kernel.org (open list:LIBRARY CODE)
> LIBRARY CODE status: Supported
> 
> ...but I think he ends up owning anything without an explicit
> maintainer.
> 
> Eric Dumazet wrote the ref_tracker originally though, and the new files
> are only added for networking stuff. If you wanted to pick it up, I
> doubt Andrew would mind.

My moderate excitement about the churn in the core networking core
aside :) - also no strong preferences on the tree. Looks like the
patches don't apply to net next:

Applying: net: register debugfs file for net_device refcnt tracker
Using index info to reconstruct a base tree...
M	net/core/dev.c
Falling back to patching base and 3-way merge...
Auto-merging net/core/dev.c

so we could save a conflict by rebasing and routing them via the
networking trees?

