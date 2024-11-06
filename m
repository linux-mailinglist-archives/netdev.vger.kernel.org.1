Return-Path: <netdev+bounces-142220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB8A9BDE22
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 06:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2A81C21F56
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 05:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3882191499;
	Wed,  6 Nov 2024 05:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCv2xM3K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7924190696;
	Wed,  6 Nov 2024 05:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730869421; cv=none; b=lnvxwnLxQLTkWNmoRo1UhReNKoICi8s1EkRh92wg8YLm0Uf8zfM7GxVo3FD9vJqpXDp60YrVqqQGssLJbz8NJ4ln7+EJWja5Ltt5oPrOPnXpRy3y0akMuL5ZmcvwSXgJYJZlDEusEWYxbwZrbfN1KXZRMsFykRgiEhSdLJcCrJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730869421; c=relaxed/simple;
	bh=Lz0dx6DXASIIdjcXuzaj6FZKZ861s3Djg0W7klVVcM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2nPQSotlbfGW3hFWreAmfOiyH1mrRqcvdM7PNsam/5rTYH/psSm0vAzCmMS6EQPRiTb8EJxKAJRt8Ddbzc/QLOg1S5cOmAVek6SRdzzGGi6jea+GrZMoB0pP1EQrU0B6ckchMAf+T2phgG1qIpiNx/UcvIPBtYyI/djDvCCZz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCv2xM3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172B3C4CECD;
	Wed,  6 Nov 2024 05:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730869421;
	bh=Lz0dx6DXASIIdjcXuzaj6FZKZ861s3Djg0W7klVVcM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DCv2xM3Ko0rBUz7+v+M5YnaAfixXYSPkHyWp+b8YOcScdtTpGc6pXObAIbdX00X0l
	 x/iqEUUpJQhnp15nmKdtwkB5enb+o+kiP4X7UvRubBa71owQ8RsyAVZe1RQ//iy5Ls
	 8T02g5OaYza+xdd/f8AWJNhcQxbfn64/EYUpaBc2+ZLgyyNxlnZzRiwV9mlRXPx/HJ
	 +eJ9G7D2QKGCHkNKEGU9L/y3hoEFqlUSFgdc2qzNapbwFxYgtfAeXssuBoasHBKpAp
	 Y0QDA/2jWKq71zRD7l8oI6U7bj6TlekaAtVNSNCrLbE7WK7GC86uXEwQf6FjXiq3Ar
	 +BKAz8LovEaVQ==
Date: Tue, 5 Nov 2024 21:03:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, corbet@lwn.net, hdanton@sina.com,
 bagasdotme@gmail.com, pabeni@redhat.com, namangulati@google.com,
 edumazet@google.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
 m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
 willy@infradead.org, willemdebruijn.kernel@gmail.com, skhawaja@google.com,
 Martin Karsten <mkarsten@uwaterloo.ca>, "David S. Miller"
 <davem@davemloft.net>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next v6 2/7] net: Suspend softirq when
 prefer_busy_poll is set
Message-ID: <20241105210338.5364375d@kernel.org>
In-Reply-To: <20241104215542.215919-3-jdamato@fastly.com>
References: <20241104215542.215919-1-jdamato@fastly.com>
	<20241104215542.215919-3-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Nov 2024 21:55:26 +0000 Joe Damato wrote:
> From: Martin Karsten <mkarsten@uwaterloo.ca>
> 
> When NAPI_F_PREFER_BUSY_POLL is set during busy_poll_stop and the
> irq_suspend_timeout is nonzero, this timeout is used to defer softirq
> scheduling, potentially longer than gro_flush_timeout. This can be used
> to effectively suspend softirq processing during the time it takes for
> an application to process data and return to the next busy-poll.
> 
> The call to napi->poll in busy_poll_stop might lead to an invocation of

The call to napi->poll when we're arming the timer is counter
productive, right? Maybe we can take this opportunity to add
the seemingly missing logic to skip over it?

> napi_complete_done, but the prefer-busy flag is still set at that time,
> so the same logic is used to defer softirq scheduling for
> irq_suspend_timeout.
> 
> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Co-developed-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>  v3:
>    - Removed reference to non-existent sysfs parameter from commit
>      message. No functional/code changes.
> 
>  net/core/dev.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 4d910872963f..51d88f758e2e 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6239,7 +6239,12 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
>  			timeout = napi_get_gro_flush_timeout(n);
>  		n->defer_hard_irqs_count = napi_get_defer_hard_irqs(n);
>  	}
> -	if (n->defer_hard_irqs_count > 0) {
> +	if (napi_prefer_busy_poll(n)) {
> +		timeout = napi_get_irq_suspend_timeout(n);

Why look at the suspend timeout in napi_complete_done()?
We are unlikely to be exiting busy poll here.
Is it because we need more time than gro_flush_timeout
for the application to take over the polling?

> +		if (timeout)
> +			ret = false;
> +	}
> +	if (ret && n->defer_hard_irqs_count > 0) {
>  		n->defer_hard_irqs_count--;
>  		timeout = napi_get_gro_flush_timeout(n);
>  		if (timeout)
> @@ -6375,9 +6380,13 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
>  	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
>  
>  	if (flags & NAPI_F_PREFER_BUSY_POLL) {
> -		napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
> -		timeout = napi_get_gro_flush_timeout(napi);
> -		if (napi->defer_hard_irqs_count && timeout) {
> +		timeout = napi_get_irq_suspend_timeout(napi);

Even here I'm not sure if we need to trigger suspend.
I don't know the eventpoll code well but it seems like you suspend 
and resume based on events when exiting epoll. Why also here?

> +		if (!timeout) {
> +			napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
> +			if (napi->defer_hard_irqs_count)
> +				timeout = napi_get_gro_flush_timeout(napi);
> +		}
> +		if (timeout) {
>  			hrtimer_start(&napi->timer, ns_to_ktime(timeout), HRTIMER_MODE_REL_PINNED);
>  			skip_schedule = true;
>  		}


