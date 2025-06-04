Return-Path: <netdev+bounces-195026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFC1ACD86E
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 09:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 322407A9E9A
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 07:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A214D1F30A4;
	Wed,  4 Jun 2025 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNQerjUk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B90E1EF395
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749021579; cv=none; b=rZTJRi/TLx4LXpi/vJ79R6YAWWSpNH8J5sUjmE8ymRcK+HV6GuRjIQfYiXkYFV49O2w60LqvHLmq5G5/P0e/B8Mh5St8ChmUX/ywGKbczkgmRGzN7kc/ihzaStwhb/IDi1u9uQfQPMx177tOvpp+ZdQnMYnWDFcZF8RWGRJ9nyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749021579; c=relaxed/simple;
	bh=wq53DOaAoLJyLG80BiM+4b3BhydmWNVKvXCgbJlRxA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFcBzyVtTXx//RLoz7qdTVRkXbhsaWMPz8nZ/VvEGqpXWkJ9XojMPlKqX4vbD7DFcol17CjIRUOvIpLJrjpLOAHSDUtR7dQkP2zV8NbTBjLPjgtHfTIruiKCelys2zDr5GmH9jk+GwJiHFocSfaUvGs3oDaOoK0gikdwQyE072g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNQerjUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E0AC4CEE7;
	Wed,  4 Jun 2025 07:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749021579;
	bh=wq53DOaAoLJyLG80BiM+4b3BhydmWNVKvXCgbJlRxA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WNQerjUkBYNwmbhaRujBC3sYM5k6oy2rJSd/SdS5J8kGtcZJ7Bd13/xvha4IRKN7V
	 6hoejZAGZIISDU4rtBwrOAwwryJozJf5aWRB+i9jj0+E8sWzxJbi3T9u1DHi7eIHkG
	 LhhCHWcyTysRFKoGDsCtm0Yr3S75yvI8bakKPaLQV46GYWavOHzYVIntRU8xC9aWtn
	 CLj84stvxWw4bO96IUzOEXbKGe8SxMVl3cl9Btq3QHUs979WolKNFJC96xTINB4OJt
	 FVu7noyg51tqfmjDMYUk4tIJjStexUaHJMO/66FuQgAAI9kOCwcq59ycOp9YPfFbPA
	 3gckqXCWzPAgQ==
Date: Wed, 4 Jun 2025 08:19:35 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: convert control queue
 mutex to a spinlock
Message-ID: <20250604071935.GA1675772@horms.kernel.org>
References: <20250523205537.161754-1-ahmed.zaki@intel.com>
 <20250528095521.GZ365796@horms.kernel.org>
 <06e4f649-0442-42cf-b1db-d88bd8556d39@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06e4f649-0442-42cf-b1db-d88bd8556d39@intel.com>

On Tue, Jun 03, 2025 at 11:37:30AM -0600, Ahmed Zaki wrote:
> 
> 
> On 2025-05-28 3:55 a.m., Simon Horman wrote:
> > On Fri, May 23, 2025 at 02:55:37PM -0600, Ahmed Zaki wrote:
> > > With VIRTCHNL2_CAP_MACFILTER enabled, the following warning is generated
> > > on module load:
> > > 
> > > [  324.701677] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:578
> > > [  324.701684] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1582, name: NetworkManager
> > > [  324.701689] preempt_count: 201, expected: 0
> > > [  324.701693] RCU nest depth: 0, expected: 0
> > > [  324.701697] 2 locks held by NetworkManager/1582:
> > > [  324.701702]  #0: ffffffff9f7be770 (rtnl_mutex){....}-{3:3}, at: rtnl_newlink+0x791/0x21e0
> > > [  324.701730]  #1: ff1100216c380368 (_xmit_ETHER){....}-{2:2}, at: __dev_open+0x3f0/0x870
> > > [  324.701749] Preemption disabled at:
> > > [  324.701752] [<ffffffff9cd23b9d>] __dev_open+0x3dd/0x870
> > > [  324.701765] CPU: 30 UID: 0 PID: 1582 Comm: NetworkManager Not tainted 6.15.0-rc5+ #2 PREEMPT(voluntary)
> > > [  324.701771] Hardware name: Intel Corporation M50FCP2SBSTD/M50FCP2SBSTD, BIOS SE5C741.86B.01.01.0001.2211140926 11/14/2022
> > > [  324.701774] Call Trace:
> > > [  324.701777]  <TASK>
> > > [  324.701779]  dump_stack_lvl+0x5d/0x80
> > > [  324.701788]  ? __dev_open+0x3dd/0x870
> > > [  324.701793]  __might_resched.cold+0x1ef/0x23d
> > > <..>
> > > [  324.701818]  __mutex_lock+0x113/0x1b80
> > > <..>
> > > [  324.701917]  idpf_ctlq_clean_sq+0xad/0x4b0 [idpf]
> > > [  324.701935]  ? kasan_save_track+0x14/0x30
> > > [  324.701941]  idpf_mb_clean+0x143/0x380 [idpf]
> > > <..>
> > > [  324.701991]  idpf_send_mb_msg+0x111/0x720 [idpf]
> > > [  324.702009]  idpf_vc_xn_exec+0x4cc/0x990 [idpf]
> > > [  324.702021]  ? rcu_is_watching+0x12/0xc0
> > > [  324.702035]  idpf_add_del_mac_filters+0x3ed/0xb50 [idpf]
> > > <..>
> > > [  324.702122]  __hw_addr_sync_dev+0x1cf/0x300
> > > [  324.702126]  ? find_held_lock+0x32/0x90
> > > [  324.702134]  idpf_set_rx_mode+0x317/0x390 [idpf]
> > > [  324.702152]  __dev_open+0x3f8/0x870
> > > [  324.702159]  ? __pfx___dev_open+0x10/0x10
> > > [  324.702174]  __dev_change_flags+0x443/0x650
> > > <..>
> > > [  324.702208]  netif_change_flags+0x80/0x160
> > > [  324.702218]  do_setlink.isra.0+0x16a0/0x3960
> > > <..>
> > > [  324.702349]  rtnl_newlink+0x12fd/0x21e0
> > > 
> > > The sequence is as follows:
> > > 	rtnl_newlink()->
> > > 	__dev_change_flags()->
> > > 	__dev_open()->
> > > 	dev_set_rx_mode() - >  # disables BH and grabs "dev->addr_list_lock"
> > > 	idpf_set_rx_mode() ->  # proceed only if VIRTCHNL2_CAP_MACFILTER is ON
> > > 	__dev_uc_sync() ->
> > > 	idpf_add_mac_filter ->
> > > 	idpf_add_del_mac_filters ->
> > > 	idpf_send_mb_msg() ->
> > > 	idpf_mb_clean() ->
> > > 	idpf_ctlq_clean_sq()   # mutex_lock(cq_lock)
> > > 
> > > Fix by converting cq_lock to a spinlock. All operations under the new
> > > lock are safe except freeing the DMA memory, which may use vunmap(). Fix
> > > by requesting a contiguous physical memory for the DMA mapping.
> > 
> > Hi Ahmed,
> 
> Hi Simon, Sorry for the late reply, I was off last week.
> 
> > 
> > If I understand things correctly, then by safe you mean won't sleep.  But
> 
> correct, that is what I meant.
> 
> > if so my question is if the path that frees DMA memory which is updated by
> > this patch is run in a context where sleeping is not allowed.
> 
> I am not sure I understand the question, but the current freeing path runs
> in process context and sleeping is allowed (hence the previous use of
> mutex).
> 
> With the new spinlock, we need to make sure all code in-between the new spin
> lock/unlock cannot sleep. All was safe except DMA buffer freeing which
> called vunmap(). That is avoided in this patch by requesting contiguous DMA
> memory via DMA_ATTR_FORCE_CONTIGUOUS.

Thanks for the clarification. And I agree that this is a good approach.
And sorry for my somewhat nonsensical question earlier, my mind had
gone off on a tangent.

Reviewed-by: Simon Horman <horms@kernel.org>


