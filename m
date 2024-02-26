Return-Path: <netdev+bounces-75118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B639F868388
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 23:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C201C23162
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 22:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0867131E39;
	Mon, 26 Feb 2024 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jk4tA/v1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC01D1DFCD
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708985969; cv=none; b=VBl+rvnBAq7h43KcAXOXcc74axUNKT5jeidd0h8JWtOdIATsdoGE9D5RkVoALWWq0rDdGWfXeXaRNIjlsG4OPUhMIN726F/uRuE3d2ciK8UMaafRCJnBGmi8+AOnTXMeSL2BvFmzPUt+KjwdQgLWR30bLd7a07s+A0GL+zqc12s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708985969; c=relaxed/simple;
	bh=Kf9C5rjCshg0Rv+IgdGFp/y0eMmxUityYfRPszEf+b4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhDYn9XOedR9eb2i2QTNZ1VUBcbQt12fZHNBLseM4F0QtKanBQsbDjOM8sQ7+gW6kT59DfflArgK4qwnk79fLmjgCP8KnL9KGkO/FVzNj4V8Lt6D45kS5iyndQxXFAy+PtNQFlZ+3gfYIfuUtxu+E7WLs5IkLuLpFqWtukNcfjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jk4tA/v1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CC7C433C7;
	Mon, 26 Feb 2024 22:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708985969;
	bh=Kf9C5rjCshg0Rv+IgdGFp/y0eMmxUityYfRPszEf+b4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jk4tA/v1DFlkt5FK5OD6xEtKQyz71uMqD6Rs2cO6xu9Ktu3Yo7CWRK5/QE9Vp8fFJ
	 QiOkf/iaT6tpeqgHIYwEQ6YmisUsci/ACC7mvUBJlJgX9n0fBQOov4Jeomgo4gIh63
	 l/ZVoDVVdz+M1YzMVMvRvZUl/Asc9lMibHhnnTNgvmii1juH6smKDhsysZGvf2whm2
	 KReBEF1Twu5W9Ios6I8cN7ktDF5P5It2Sm8Szo7dYqbQqD6ycjKUn90B8D7jR/t7t2
	 Od9V7D5IYeIAdTuOo8rn/dS+iy3k2sUBWQrkI1fLUOQoYy2TZrnUE43sGOJ0fnBZ4y
	 It3WlqKaafqiA==
Date: Mon, 26 Feb 2024 14:19:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, amritha.nambiar@intel.com, danielj@nvidia.com,
 mst@redhat.com, michael.chan@broadcom.com, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next 1/3] netdev: add per-queue statistics
Message-ID: <20240226141928.171b79fe@kernel.org>
In-Reply-To: <Zd0EJq3gS2_p9NQ8@google.com>
References: <20240226211015.1244807-1-kuba@kernel.org>
	<20240226211015.1244807-2-kuba@kernel.org>
	<Zd0EJq3gS2_p9NQ8@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 13:35:34 -0800 Stanislav Fomichev wrote:
> > +  -
> > +    name: stats-scope
> > +    type: flags
> > +    entries: [ queue ]  
> 
> IIUC, in order to get netdev-scoped stats in v1 (vs rfc) is to not set
> stats-scope, right? Any reason we dropped the explicit netdev entry?
> It seems more robust with a separate entry and removes the ambiguity about
> which stats we're querying.

The change is because I switched from enum to flags.

I'm not 100% sure which one is going to cause fewer issues down
the line. It's a question of whether the next scope we add will 
be disjoint with or subdividing previous scopes.

I think only subdividing previous scopes makes sense. If we were 
to add "stats per NAPI" (bad example) or "per buffer pool" or IDK what
other thing -- we should expose that as a new netlink command, not mix 
it with the queues.

The expectation is that scopes will be extended with hw vs sw, or
per-CPU (e.g. page pool recycling). In which case we'll want flags,
so that we can combine them -- ask for HW stats for a queue or hw
stats for the entire netdev.

Perhaps I should rename stats -> queue-stats to make this more explicit?

The initial version I wrote could iterate both over NAPIs and
queues. This could be helpful to some drivers - but I realized that it
would lead to rather painful user experience (does the driver maintain
stats per NAPI or per queue?) and tricky implementation of the device
level sum (device stats = Sum(queue) or Sum(queue) + Sum(NAPI)??)

