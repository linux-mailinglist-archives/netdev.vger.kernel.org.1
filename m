Return-Path: <netdev+bounces-178385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56659A76CF7
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 20:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9996E188CE64
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 18:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219F52147F3;
	Mon, 31 Mar 2025 18:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmdaPVYD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE511BD9E3;
	Mon, 31 Mar 2025 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743446000; cv=none; b=cBe03CrOhHbXLh+sMNlRsWxGBGfwKrW3fKduWugI9woAlBrcDRyWkzMq8zuyPm51cIdLmmwXyMCKVgr3lpJ+jbTDdrnlBNyFIYVGN0etYptv+XfNZboR85k3q67IM4/vQnvwQpazkCBxYKp0wXzrC8oRejrJn+X3ULDstfrhNis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743446000; c=relaxed/simple;
	bh=zDWOwFQTHeMBAotV1k71vCBut0m7pH1xrfDhXj83BXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MW/o2tfxbqgyJP5/6kBBKwqQ2TBmslRy2VGf6WMoJmZY0pntbMizRoD0QJaTAi8dra+K0gxXgWRSFlAy3DU69UAnxzyzF+XqQj54lLJhNRkkNNymLzwZVhymE4MnP+DnAT2pEZ26sZfnz8qIpxyDleZoB7XcYLTmGpTPOH3uzHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmdaPVYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15568C4CEE3;
	Mon, 31 Mar 2025 18:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743445996;
	bh=zDWOwFQTHeMBAotV1k71vCBut0m7pH1xrfDhXj83BXU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=rmdaPVYD8I07t6FEch0gu8o46+cK/Kql1duOCBIaoLc1Czyos4g5xSA5cZN8FhOrU
	 3rb2BJbjLgmpDGzRgqWMRN3QmvFUSB6TqqgUUEgBnK4FVd5CxK/FexgcUheiMjXQUu
	 tlWotJh5kkhJiVFWtNe/+FxmH/0gwue3Xsjdu75cbqWl6Ae5TnbSXrFGXuCt3Pq80Z
	 Y/olo8lScj2pJmyx/AOB8ecNmJ+24ODSWl3RcRgd5dVXz1uNvMFnIHNSyKP31Xok+M
	 POavC+cAOWE/N7b4wFfPPgYGD06TDaZ/MhoGS+S3ZNpBg1RYHqG9RqeA3VAgqw40Ak
	 Cj1fR68ZKsXWg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AD420CE0869; Mon, 31 Mar 2025 11:33:15 -0700 (PDT)
Date: Mon, 31 Mar 2025 11:33:15 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Eric Dumazet <edumazet@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Breno Leitao <leitao@debian.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, aeh@meta.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with
 expedited RCU synchronization
Message-ID: <35039448-d8e8-4a7d-b59b-758d81330d4b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <Z-Il69LWz6sIand0@Mac.home>
 <934d794b-7ebc-422c-b4fe-3e658a2e5e7a@redhat.com>
 <Z-L5ttC9qllTAEbO@boqun-archlinux>
 <f1ae824f-f506-49f7-8864-1adc0f7cbee6@redhat.com>
 <Z-MHHFTS3kcfWIlL@boqun-archlinux>
 <1e4c0df6-cb4d-462c-9019-100044ea8016@redhat.com>
 <Z-OPya5HoqbKmMGj@Mac.home>
 <df237702-55c3-466b-b51e-f3fe46ae03ba@redhat.com>
 <Z-rQNzYRMTinrDSl@boqun-archlinux>
 <9f5b500a-1106-4565-9559-bd44143e3ea6@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f5b500a-1106-4565-9559-bd44143e3ea6@redhat.com>

On Mon, Mar 31, 2025 at 01:33:22PM -0400, Waiman Long wrote:
> On 3/31/25 1:26 PM, Boqun Feng wrote:
> > On Wed, Mar 26, 2025 at 11:39:49AM -0400, Waiman Long wrote:
> > [...]
> > > > > Anyway, that may work. The only problem that I see is the issue of nesting
> > > > > of an interrupt context on top of a task context. It is possible that the
> > > > > first use of a raw_spinlock may happen in an interrupt context. If the
> > > > > interrupt happens when the task has set the hazard pointer and iterating the
> > > > > hash list, the value of the hazard pointer may be overwritten. Alternatively
> > > > > we could have multiple slots for the hazard pointer, but that will make the
> > > > > code more complicated. Or we could disable interrupt before setting the
> > > > > hazard pointer.
> > > > Or we can use lockdep_recursion:
> > > > 
> > > > 	preempt_disable();
> > > > 	lockdep_recursion_inc();
> > > > 	barrier();
> > > > 
> > > > 	WRITE_ONCE(*hazptr, ...);
> > > > 
> > > > , it should prevent the re-entrant of lockdep in irq.
> > > That will probably work. Or we can disable irq. I am fine with both.
> > Disabling irq may not work in this case, because an NMI can also happen
> > and call register_lock_class().
> Right, disabling irq doesn't work with NMI. So incrementing the recursion
> count is likely the way to go and I think it will work even in the NMI case.
> 
> > 
> > I'm experimenting a new idea here, it might be better (for general
> > cases), and this has the similar spirit that we could move the
> > protection scope of a hazard pointer from a key to a hash_list: we can
> > introduce a wildcard address, and whenever we do a synchronize_hazptr(),
> > if the hazptr slot equal to wildcard, we treat as it matches to any ptr,
> > hence synchronize_hazptr() will still wait until it's zero'd. Not only
> > this could help in the nesting case, it can also be used if the users
> > want to protect multiple things with this simple hazard pointer
> > implementation.
> 
> I think it is a good idea to add a wildcard for the general use case.
> Setting the hazptr to the list head will be enough for this particular case.

Careful!  If we enable use of wildcards outside of the special case
of synchronize_hazptr(), we give up the small-memory-footprint advantages
of hazard pointers.  You end up having to wait on all hazard-pointer
readers, which was exactly why RCU was troublesome here.  ;-)

							Thanx, Paul

