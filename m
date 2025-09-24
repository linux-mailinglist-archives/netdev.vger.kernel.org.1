Return-Path: <netdev+bounces-226063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 621BCB9B892
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 20:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F8E325C55
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 18:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C261529DB6E;
	Wed, 24 Sep 2025 18:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAMo1Qb9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1DD199230;
	Wed, 24 Sep 2025 18:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739279; cv=none; b=UOoqhOEO/oeIINtJ82B4FCtB3Hz3a/ss7BejsnyMlgnJFUsQ87CVNJ8N/eu2byDYoRnNleA2Q9A2H4SsnKQ0bNs3/nereTFWsGkhewuZ4RDCRT8v4sm14ywtk45qg9Pb5utjVVJSs7m6ikXW1GbH13hvKk8BcUlZMYL94+plBxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739279; c=relaxed/simple;
	bh=ea8coFrJO1bcM1fHRBo5eWQPSWZqx7Wy+8665WkWPA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+UtXkYH/JLXSbgxDboVnDyzWyYMB9Etlvbi5AzIte319xqJf0nsk4ly3AK1CGFQGcEHrN49ozmL+FsKJ6KZyWCU7DkV6kZKg+yQRr3o7mhmxITxV5tkbO+BTwvd7qfV6UBr5XvJfvOgXSojVId+yBYRU60thqDGSFByQAkVn8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAMo1Qb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBBCC4CEE7;
	Wed, 24 Sep 2025 18:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758739279;
	bh=ea8coFrJO1bcM1fHRBo5eWQPSWZqx7Wy+8665WkWPA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DAMo1Qb9TEy/uEfx7VtG0STtdFSucvHS6l9/zb6xbwTYQFXVF0sr2YhnhYiTT3RXv
	 CtWlL0nkb9mpaM1yA5TkA98tgq24fnZOfKVANsmtE2MWRDB4nY+sNUGmd7qoZkPqzA
	 Nm7rrwxk78r26CU9IdOfeAr0xFrgf4FNQsy/+/NMpVlZ9Qh/slgegLdDUCQRoSA/YX
	 94H0yHQ4qmt6P2jijXzF0lsYgndaPH8n6NzSuKrmdUL9EzwdouWLEx/CIsVK7qd/uG
	 kyctJWHY9nyGQg+BNoZ/Cvf9wWZz4678Li+OYM04mUJMuEoFKaU0uD+BPtCmJX6QEr
	 QDeI45MkYhPmQ==
Date: Wed, 24 Sep 2025 19:41:15 +0100
From: Simon Horman <horms@kernel.org>
To: Deepak Sharma <deepak.sharma.472935@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, pwn9uin@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
Subject: Re: [PATCH] Fix the cleanup on alloc_mpc failure in
 atm_mpoa_mpoad_attach
Message-ID: <20250924184115.GS836419@horms.kernel.org>
References: <20250923132427.74242-1-deepak.sharma.472935@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923132427.74242-1-deepak.sharma.472935@gmail.com>

On Tue, Sep 23, 2025 at 06:54:27PM +0530, Deepak Sharma wrote:
> Syzbot reported a warning at `add_timer`, which is called from the
> `atm_mpoa_mpoad_attach` function
> 
> The reason for this warning is that in the allocation failure by `alloc_mpc`,
> there is lack of proper cleanup. And in the event that ATMMPC_CTRL ioctl is
> called on to again, it will lead to the attempt of starting an already 
> started timer from the previous ioctl call
> 
> Do a `timer_delete` before returning from the `alloc_mpc` failure
> 
> Reported-by: syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=07b635b9c111c566af8b
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Deepak Sharma <deepak.sharma.472935@gmail.com>
> ---
>  net/atm/mpc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/atm/mpc.c b/net/atm/mpc.c
> index f6b447bba329..cd3295c3c480 100644
> --- a/net/atm/mpc.c
> +++ b/net/atm/mpc.c
> @@ -814,7 +814,10 @@ static int atm_mpoa_mpoad_attach(struct atm_vcc *vcc, int arg)
>  		dprintk("allocating new mpc for itf %d\n", arg);
>  		mpc = alloc_mpc();
>  		if (mpc == NULL)
> +		{
> +			timer_delete(&mpc_timer);
>  			return -ENOMEM;
> +		}
>  		mpc->dev_num = arg;
>  		mpc->dev = find_lec_by_itfnum(arg);
>  					/* NULL if there was no lec */

Hi Deepak.

I have a few questions about this.

1. Is timer_delete() sufficient, or is timer_delete_sync() needed
   to avoid the timer being rearmed?

2. If timer_delete_sync() is needed here, then it is probably
   also needed a few lines above, in place of an existing call to
   timer_delete().

3. Is timer_delete()/timer_delete_sync() also needed for the error condition a
   few lines below the hunk above? That code looks like this:

        if (mpc->mpoad_vcc) {
                pr_info("mpoad is already present for itf %d\n", arg);
                return -EADDRINUSE;
        }

Also, this patch is probably for net. So, for reference, it should
be targeted at that tree like this:

Subject: [PATCH net] ...

And the patch subject should have a prefix. Looking at git history, "atm:"
seems appropriate.

Subject: [PATCH net] atm: ...


