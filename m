Return-Path: <netdev+bounces-244404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DD6CB66EC
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 17:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54CBC30054B5
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 16:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0955311975;
	Thu, 11 Dec 2025 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMbSF1Md"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A5227FD7D;
	Thu, 11 Dec 2025 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765469686; cv=none; b=KmXinNnm21phzUp8qTbxh8UoKbkPLkzwjU8JANH02dXqTm6r7GkPtR9c38l8oAY6ApfhToellwNtDDg3oDvq81HFTqilIzPQJC8OAckSTkm6P0dfugJn7UvTLv8HLm2cwRh76TpISua2J9rxLV9+6nlCnGR8CPklqzozqWLVxnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765469686; c=relaxed/simple;
	bh=ruewS10AMQkphUc0Hpw/PUQnBZari4Sbf7a8xb+gB/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjFA5EJXxl3EUb27rt3Rk5Tx/Y6GH/12K7fKj0E5aHaL9A0EOCwMWT9GzvD9dpbYE513nUMbA315WqC89kmijGSLodLs4mKkGyxwSknv4/Z86rFEoEdYpkAJHpFxqMy1IlJet3YMM9L8GPMNxzYCZ3EcUb+pMunacH8UbDvdXVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMbSF1Md; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AC7C4CEF7;
	Thu, 11 Dec 2025 16:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765469685;
	bh=ruewS10AMQkphUc0Hpw/PUQnBZari4Sbf7a8xb+gB/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sMbSF1Md/w9rc/hzfHy4A08xDR0g88Ulg3pv9dloGHTKAEcHGj0AD1HEr6hgcectt
	 sNzdZsjCD4PcnFILDmVb8XBI4RlYTP2sPFB/SpZGue/USTYFFBmZMnp5sksMXhG9Ym
	 Lwsjg15IKeCa85ID5i5JLNCtyh2cw1cQFEpaT1sysYpkgu+j9GhtI3smInhKAXju5u
	 sDB5OtUpT7kaQzsLSlBJflCBIZcGw3p+wcP4wMd0mZ/A42X/FkOEPgzq+Vw6FZPkah
	 tYymviU1cbK6Vf7s+Rs0gPUKdjnKjWBCFRbku4SR3zXbtPqRbalE+i+KivfK4FvYln
	 fFSiAFM2IDW7A==
Date: Thu, 11 Dec 2025 16:14:42 +0000
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Dharanitharan R <dharanitharan725@gmail.com>,
	syzbot+422806e5f4cce722a71f@syzkaller.appspotmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] team: fix qom_list corruption by using
 list_del_init_rcu()
Message-ID: <aTrt8mig9TwBC3kp@horms.kernel.org>
References: <20251210053104.23608-2-dharanitharan725@gmail.com>
 <aTls21jR6BvTaV-k@horms.kernel.org>
 <pyaaf6vhfvkab4rpsgkojguixnp5vdxgzle6i6p3shuxgzwwaw@rdwgw47rgvzb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pyaaf6vhfvkab4rpsgkojguixnp5vdxgzle6i6p3shuxgzwwaw@rdwgw47rgvzb>

On Thu, Dec 11, 2025 at 10:38:43AM +0100, Jiri Pirko wrote:
> Wed, Dec 10, 2025 at 01:51:39PM +0100, horms@kernel.org wrote:
> >On Wed, Dec 10, 2025 at 05:31:05AM +0000, Dharanitharan R wrote:
> >> In __team_queue_override_port_del(), repeated deletion of the same port
> >> using list_del_rcu() could corrupt the RCU-protected qom_list. This
> >> happens if the function is called multiple times on the same port, for
> >> example during port removal or team reconfiguration.
> >> 
> >> This patch replaces list_del_rcu() with list_del_init_rcu() to:
> >> 
> >>   - Ensure safe repeated deletion of the same port
> >>   - Keep the RCU list consistent
> >>   - Avoid potential use-after-free and list corruption issues
> >> 
> >> Testing:
> >>   - Syzbot-reported crash is eliminated in testing.
> >>   - Kernel builds and runs cleanly
> >> 
> >> Fixes: 108f9405ce81 ("team: add queue override configuration mechanism")
> >> Reported-by: syzbot+422806e5f4cce722a71f@syzkaller.appspotmail.com
> >> Closes: https://syzkaller.appspot.com/bug?extid=422806e5f4cce722a71f
> >> Signed-off-by: Dharanitharan R <dharanitharan725@gmail.com>
> >
> >Thanks for addressing my review of v1.
> >The commit message looks much better to me.
> >
> >However, I am unable to find the cited commit in net.
> >
> >And I am still curious about the cause: are you sure it is repeated deletion?
> 
> It looks like it is. But I believe we need to fix the root cause, why
> the list_del is called twice and don't blindly take AI made fix with AI
> made patch description :O
> 
> I actually think that following path might the be problematic one:
> 1) Port is enabled, queue_id != 0, in qom_list
> 2) Port gets disabled
> 	-> team_port_disable()
>         -> team_queue_override_port_del()
>         -> del (removed from list)
> 3) Port is disabled, queue_id != 0, not in any list
> 4) Priority changes
>         -> team_queue_override_port_prio_changed()
> 	-> checks: port disabled && queue_id != 0
>         -> calls del - hits the BUG as it is removed already
> 
> Will test the fix and submit shortly.

Thanks, much appreciated.

...

