Return-Path: <netdev+bounces-185344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BECA7A99D0A
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 02:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E82C5A594E
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 00:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AA510F9;
	Thu, 24 Apr 2025 00:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayaEoUD5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6ED634;
	Thu, 24 Apr 2025 00:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745454753; cv=none; b=K6YrLRPrDYAiQn1Z2QieQ2g98JUgYZDE4ReNn4PPEGX/6fguANC2dZMgBOLu4JtXXOR/NTXpfrIrkynH5X0FPIfmgNRtbzBNYO6YsIAyUauvq5PdpbqBE5xCAD15Keh0ccjyK/XNilkooecVjqw2mNoMj/3KmZcsN35A5o4fuAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745454753; c=relaxed/simple;
	bh=cR3TCvLS3jMlfbS0rKdZV7/VIl42dYXU2s5/UI/x3QI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=br2gWyj9aq1TtIKruD4El/lbc+Caq/XFCB70U/r5syqJDmdeitxoTeO0rCGteI/ItUjQqA0r0TIZHKjYcWUwojrsbzVMcp+6ozY3S2nEIaa41T9bKxP2y0tx05VHRf5jvwfXpUP5MixxwDa34F65KMEf6n8v7PGb0eNF2/6c730=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayaEoUD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23C2C4CEE2;
	Thu, 24 Apr 2025 00:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745454752;
	bh=cR3TCvLS3jMlfbS0rKdZV7/VIl42dYXU2s5/UI/x3QI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ayaEoUD5+uornete260/fxlWq3b/tvUsHFY7rXlMSrgK993/YFetwx91JlQcUeYo/
	 7+aMLEkO1ELL5s4VvZ6GQZ4krrj4Cjqk5y8DU4d3YoqSGMvJTDr2nQZUPbbUfb2Bv0
	 96dDUdhNNsiYnDAIi0PX6zc/5O0eCQa3E3LnezZgDJzkhQMeD7zs0QUldHx4jwGsRt
	 d7UamGYYHvzEpOx1h53iSzX+BH1m3cdnY6Kmf2oehN9NEvEnw4KmANVbCkBc4lz6YJ
	 Y6QTISSkIjHdHgXsSTRv0kUSSuYiUTAGz0uDg6jmZG1QGcfqtR/7MRRBZ54RnvszMw
	 uYljnw2l50JKg==
Date: Wed, 23 Apr 2025 17:32:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "David S. Miller"	
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni	
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima	
 <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, Nathan Chancellor	
 <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 7/7] net: register debugfs file for net_device refcnt
 tracker
Message-ID: <20250423173231.5c61af5b@kernel.org>
In-Reply-To: <a07cd1c64b16b074d8e1ec2e8c06d31f4f27d5e5.camel@kernel.org>
References: <20250418-reftrack-dbgfs-v4-0-5ca5c7899544@kernel.org>
	<20250418-reftrack-dbgfs-v4-7-5ca5c7899544@kernel.org>
	<20250423165323.270642e3@kernel.org>
	<a07cd1c64b16b074d8e1ec2e8c06d31f4f27d5e5.camel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 20:04:58 -0400 Jeff Layton wrote:
> On Wed, 2025-04-23 at 16:53 -0700, Jakub Kicinski wrote:
> > Names are not unique and IIUC debugfs is not namespaced.
> > How much naming the objects in a "user readable" fashion actually
> > matter? It'd be less churn to create some kind of "object class"
> > with a directory level named after what's already passed to
> > ref_tracker_dir_init() and then id the objects by the pointer value 
> > as sub-dirs of that?  
> 
> That sounds closer to what I had done originally. Andrew L. suggested
> the flat directory that this version represents. I'm fine with whatever
> hierarchy, but let's decide that before I respin again.

Sorry about that :(

> When I was tracking down net namespace leaks recently, it was very nice
> to have the inode number of the leaked netns's in the filenames. I
> would have probably had to grovel around with drgn to figure out the
> address if that weren't embedded in the name. I think we probably ought
> to leave it up to each subsystem how it names its files. The
> discriminators between different types of objects can vary wildly.
> 
> One thing that might be simpler is to make ref_tracker_dir_debugfs() a
> varargs function and allow passing in a format string and set of
> arguments for it. That might make things simpler for the callers.

Yes, cutting out the formatting in the callers would definitely 
be a win. Maybe that'd make the whole thing sufficiently palatable :)

