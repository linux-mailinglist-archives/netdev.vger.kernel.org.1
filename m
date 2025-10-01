Return-Path: <netdev+bounces-227508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A48DBB1962
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 21:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA47C16F526
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 19:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7002D593E;
	Wed,  1 Oct 2025 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CImxcNHq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987BC258EDF
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346780; cv=none; b=BDEny+MyB7ohIkC/iB53jSyGGWw2uZA9+UDefW7mPMC21tOLBOqP9YGxvYKPG6t8+XNtt61WYeokXvDuzPlpMvwROT1gdQGN0BQmLcmVUGTKXoFnIlLJoTiowNFSpWY/K5TgidQQ26IQl3ZMzBnHNN0lcxYaf+e8/q9HynJgo1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346780; c=relaxed/simple;
	bh=9inNhe9u/d0VR0nGFnVkfFMxC2NNBvijwmRd9P2e+ew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BX+mNicgpyxssQbZrp+v1ohDGeFinUhb/7W3Q83uVkOT/IYcqVU2macG0rBZZ7uCrEFftDSBvvUcZh0S2VhTYtdIIc7a2kvNQVRQ17HlrrXHFAaYrNzKWw/bCxPm69M+W+ux/21eXOkRggQeLF7yE/uGqhOQxk68YmrHR665S7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CImxcNHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36FCC4CEF1;
	Wed,  1 Oct 2025 19:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759346780;
	bh=9inNhe9u/d0VR0nGFnVkfFMxC2NNBvijwmRd9P2e+ew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CImxcNHqQuLtX6kkNb+m/s+BlG2JMtLE+e8JkWSp3XENxUIBSd7URVP4IJzINCaco
	 UqVoV6IJE+oJSQjrHrnxCBVZCbNME/TllipE+uDKgifiocpWQgCtnN8VSdThCsaryc
	 NFtuB30rjghfJizIn/ndUPywMdBc4qx5EAVii0igPKu1EVEJ+bCjBL4lC3TotVKQ1S
	 ihU5HVPOr27d6gE8hQkHYc98kHSwliYASbMPH7rFx8ePg3z/ZQXeEgfQgD68DJNNqg
	 G0CZsok2uMBIGpCiaxr6t0GUuVZ3w9OPseRtmBiht/RtpUrbeo7L2eiGt/qfhg4dF5
	 jBZJsmEwgHjfQ==
Date: Wed, 1 Oct 2025 12:26:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, fw@strlen.de, netdev@vger.kernel.org,
 pabeni@redhat.com, willemb@google.com
Subject: Re: deadlocks on pernet_ops_rwsem
Message-ID: <20251001122618.4cf31f3b@kernel.org>
In-Reply-To: <20251001185310.33321-1-kuniyu@google.com>
References: <20251001102223.1b8e9702@kernel.org>
	<20251001185310.33321-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  1 Oct 2025 18:50:22 +0000 Kuniyuki Iwashima wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Wed, 1 Oct 2025 10:22:23 -0700
> > To be clear -- AFAICT lockdep misses this.
> > 
> > The splat is from the "stuck task" checker. 
> > 
> > 2 min wait to load a module during test init would definitely be a sign
> > of something going sideways.. but I think it's worse than that, these
> > time out completely and we kill the VM. I think the modprobe is truly
> > stuck here.
> > 
> > In one of the splats lockdep was able to say:
> > 
> > [ 4302.448228][   T44] INFO: task modprobe:31634 <writer> blocked on an rw-semaphore likely owned by task kworker/u16:0:12 <reader>
> > 
> > but most are more useless:
> > 
> > [ 4671.090728][   T44] INFO: task modprobe:2342 is blocked on an rw-semaphore, but the owner is not found.
> > 
> > (?!?)  
> 
> Even when it caught the possible owner, lockdep seems confused :/
> 
> 
> [ 4302.448228][   T44] INFO: task modprobe:31634 <writer> blocked on an rw-semaphore likely owned by task kworker/u16:0:12 <reader>
> 
> modprobe:31634 seems to be blocked by kworker/u16:0:12,
> 
> 
> [ 4302.449035][   T44] task:kworker/u16:0   state:R  running task     stack:26368 pid:12    tgid:12    ppid:2      task_flags:0x4208060 flags:0x00004000
> [ 4302.449872][   T44] Workqueue: netns cleanup_net
> ...
> [ 4302.460889][   T44] Showing all locks held in the system:
> [ 4302.461368][   T44] 4 locks held by kworker/u16:0/12:
> 
> but no lock shows up here for kworker/u16:0/12,
> 
> 
> [ 4302.461597][   T44] 2 locks held by kworker/u18:0/36:
> [ 4302.461926][   T44]  #0: ffff8880010d9d48 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x7e5/0x1650
> [ 4302.462429][   T44]  #1: ffffc9000028fd40 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0xded/0x1650
> [ 4302.463011][   T44] 1 lock held by khungtaskd/44:
> [ 4302.463261][   T44]  #0: ffffffffb7b83f80 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x36/0x260
> [ 4302.463717][   T44] 1 lock held by modprobe/31634:
> [ 4302.463982][   T44]  #0: ffffffffb8270430 (pernet_ops_rwsem){++++}-{4:4}, at: register_pernet_subsys+0x1a/0x40
> 
> and modprobe/31634 is holding pernet_ops_rwsem ???
> 
> 
> Was there any update on packages (especially qemu?) used by
> CI around 2025-09-18 ?

No updates according to the logs. First hit was on Thursday so I thought
maybe it came from Linus. But looking at the branches we fast forwarded
2025-09-18--21-00 and there were 2 hits earlier that day (2025-09-18--03-00,
2025-09-18--15-00)

