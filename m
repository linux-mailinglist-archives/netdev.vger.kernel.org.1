Return-Path: <netdev+bounces-244823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C144CBF327
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 18:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 755513054C2A
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 17:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5890E337BA2;
	Mon, 15 Dec 2025 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZMVOEwP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC81431352C;
	Mon, 15 Dec 2025 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765818650; cv=none; b=TGQASUT5C3OaV6K2E8FJSWrov1NFc4MTEyTt+MHacmjYcvq8XtSIScvublHRNvM1FxEauobtRI0z8QUBTAR+nrJWCX+SzEs1Q+yZ/qjlYCfV0HDgaqorGhfKyc+2kS1Jry6TqcK3KLfpf8HTHyhEPkx4q5iA41QkIZ0AFHk3CE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765818650; c=relaxed/simple;
	bh=cwMR/Fk5tha92MiDNpmUeFP+QNMa9XhwhgULZKix1PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mczn1qRV9iFy1wQ8mFkp6Xehrgg9QkGDjwDM9PsyfKrCCl1veT0C2o7G8wE3Mqkh7L/qCVcnkyHNriGfohRN6udTGpXpratD3xdmnLnNVkLhB1PQUZJ6Bd2AaMI1CZmXBA7mHZf62sdvxW/cEnYbBthbpM7l7l/U4Nii8c6KS2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZMVOEwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F880C4CEF5;
	Mon, 15 Dec 2025 17:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765818648;
	bh=cwMR/Fk5tha92MiDNpmUeFP+QNMa9XhwhgULZKix1PY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FZMVOEwPzqZZWOFPQ6Wa00Okn6d0OJMvDCcP+Ke/6f59VpIzMzvl9yX9EQWOGXLL3
	 k9G8gIrcVqMjIjyJBnyNy7wyFBMTpxQ0PgBtCdwsOj2DqJL8Px3KVTBbjZs3TXeW06
	 Qx3dtmbRvVyym2X9vldBHcSErJ+2/7lD6UYGgbGCAOnvcuDB874wIsHJluhHL9uTd5
	 sOqtEe4FkdAKX5H89+7i5gVZ2DT6GO/hRx+dS83zP5R+d9Do1kJmKi37Qxa0YRiMI7
	 fHE3p1zn0APIXoXguSrqvXgkJamO9sentpByvn77geIUgGt2kX7MMn7Wj7+SBHZj+8
	 XnzY4Tz4lrE2g==
Date: Mon, 15 Dec 2025 17:10:43 +0000
From: Simon Horman <horms@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: nico@fluxnic.net, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
	dongdong.deng@windriver.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] smc91x: fix broken irq-context in PREEMPT_RT
Message-ID: <aUBBE-W4kwQbsp9t@horms.kernel.org>
References: <20251212190338.2318843-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212190338.2318843-1-yeoreum.yun@arm.com>

On Fri, Dec 12, 2025 at 07:03:38PM +0000, Yeoreum Yun wrote:
> When smc91x.c is built with PREEMPT_RT, the following splat occurs
> in FVP_RevC:
> 
> [   13.055000] smc91x LNRO0003:00 eth0: link up, 10Mbps, half-duplex, lpa 0x0000
> [   13.062137] BUG: workqueue leaked atomic, lock or RCU: kworker/2:1[106]
> [   13.062137]      preempt=0x00000000 lock=0->0 RCU=0->1 workfn=mld_ifc_work
> [   13.062266] C
> ** replaying previous printk message **
> [   13.062266] CPU: 2 UID: 0 PID: 106 Comm: kworker/2:1 Not tainted 6.18.0-dirty #179 PREEMPT_{RT,(full)}
> [   13.062353] Hardware name:  , BIOS
> [   13.062382] Workqueue: mld mld_ifc_work
> [   13.062469] Call trace:
> [   13.062494]  show_stack+0x24/0x40 (C)
> [   13.062602]  __dump_stack+0x28/0x48
> [   13.062710]  dump_stack_lvl+0x7c/0xb0
> [   13.062818]  dump_stack+0x18/0x34
> [   13.062926]  process_scheduled_works+0x294/0x450
> [   13.063043]  worker_thread+0x260/0x3d8
> [   13.063124]  kthread+0x1c4/0x228
> [   13.063235]  ret_from_fork+0x10/0x20
> 
> This happens because smc_special_trylock() disables IRQs even on PREEMPT_RT,
> but smc_special_unlock() does not restore IRQs on PREEMPT_RT.
> The reason is that smc_special_unlock() calls spin_unlock_irqrestore(),
> and rcu_read_unlock_bh() in __dev_queue_xmit() cannot invoke
> rcu_read_unlock() through __local_bh_enable_ip() when current->softirq_disable_cnt becomes zero.
> 
> To address this issue, replace smc_special_trylock() with spin_trylock_irqsave().
> 
> Fixes: 8ff499e43c53 ("smc91x: let smc91x work well under netpoll")
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
> This patch based on v6.18.
> 
> History
> ========
> 
> >From v1 to v2:
>   - remove debug log.
>   - https://lore.kernel.org/all/20251212185818.2209573-1-yeoreum.yun@arm.com/
> 

Firstly, I'd like to note that it seems to me that the last
non-trivial update to this driver seems to have occurred back in 2016.
Do you know if it is still actively used?

I agree that this patch seems appropriate as a bug fix.
But I do wonder if, as a follow-up for net-next when it re-opens,
smc_special_*lock could be removed entirely.
Other than being the source of this bug (which I guess is special),
they don't seem very special anymore. Perhaps they were once,
but that time seems to have passed.

Regarding the Fixes tag. I wonder if this one, which post-dates the
currently cited commit is correct. It seems to be when RT variants of
these locks was introduced.

Fixes: 342a93247e08 ("locking/spinlock: Provide RT variant header: <linux/spinlock_rt.h>")

Lastly, for reference, when posting fixes for Networking code, please:

* Target the patches at net like this:

  [PATCH net] ...

* Allow at least 24h to pass before posting updated patch versions

More can be found here: https://docs.kernel.org/process/maintainer-netdev.html


Reviewed-by: Simon Horman <horms@kernel.org>

