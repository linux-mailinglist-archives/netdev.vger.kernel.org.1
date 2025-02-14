Return-Path: <netdev+bounces-166583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F823A3680D
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 23:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25EF21892E32
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783641FBEB4;
	Fri, 14 Feb 2025 22:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8zDjj9H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496221DC198;
	Fri, 14 Feb 2025 22:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739571013; cv=none; b=T6HL97DEZFLJs5Vr17T9BwAHZGVwq8TnkbUqOum+lmQl1dZbdAs3zkcAFoYQrG9mJ28512THUrZI18Jp4GNG7HoPorJFlAP1+PXPJi6fnwBNFTdbQi21JVS8yQKtcEfFxg0H40cnjewtEbbDxfQbjDScjhx/GVTfK6jItCl5ly8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739571013; c=relaxed/simple;
	bh=2lmBOZ1d2qXbAloPFesGofjAzJUey6sxCfusp2YdXcE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sP8gc/3s6qiNga4ziANtBd7bO1cqH4MP1Wgn3JH2e5rmDQpKfZcrE7DcNELLo4dlgS45JU4VZVJuiFNnF3DicAfwA6sQAmV78Y/IDL0N2rYX7usHnxm+xrsKWvyxjwgddySXAxxcrlnwloxZOqo3kU8kvx/5dw99aOuFAKQ4n3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8zDjj9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493B1C4CED1;
	Fri, 14 Feb 2025 22:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739571012;
	bh=2lmBOZ1d2qXbAloPFesGofjAzJUey6sxCfusp2YdXcE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I8zDjj9HEl+11XI7gXGB+sy5GOfjPqXp07BJcks1KDgiZCZJb7MJom6/X62XW/+ds
	 9iEl6LBaklQ0o2lj9xun0kwZt8EvTKkm9UUa7iqQvIUMEiP2bnRlfzwCPJqJzlqtNB
	 QtV4AU124DyhwWWnjoHhfvIezYjfzXb5cWftQbaoTOim1MpYvDDqODsDzsgNjwm69T
	 xlW58zmLkZAmNPqwS+i+1a/umI9CFolg1z68vX8Izv0NZS1RvF09HP1S/7qezwLh6q
	 Y5TUNutR7QS4bqJjouzje8IDIoQzXkV1NcYCLjIz5SdNKHGPkEYXI6kLhpuB8bbBnx
	 8UKg2BAPTPHlg==
Date: Fri, 14 Feb 2025 14:10:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Hayes Wang
 <hayeswang@realtek.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] net: Assert proper context while calling
 napi_schedule()
Message-ID: <20250214141011.501910f3@kernel.org>
In-Reply-To: <20250214-grinning-upbeat-chowchow-5c0e2f@leitao>
References: <20250212174329.53793-1-frederic@kernel.org>
	<20250212174329.53793-2-frederic@kernel.org>
	<20250212194820.059dac6f@kernel.org>
	<20250213-translucent-nightingale-of-upgrade-b41f2e@leitao>
	<20250213071426.01490615@kernel.org>
	<20250214-grinning-upbeat-chowchow-5c0e2f@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 08:43:28 -0800 Breno Leitao wrote:
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index 42f247cbdceec..cd56904a39049 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -87,7 +87,7 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	if (unlikely(nsim_forward_skb(peer_dev, skb, rq) == NET_RX_DROP))
>  		goto out_drop_cnt;
>  
> -	napi_schedule(&rq->napi);
> +	hrtimer_start(&rq->napi_timer, ns_to_ktime(5), HRTIMER_MODE_REL);

ns -> us

We want to leave the timer be in case it's already scheduled.
Otherwise we'll keep postponing forever under load.
Double check that hrtime_start() does not reset the time if already
pending. Maybe hrtimer_start_range_ns(..., 0, us_to_ktime(5), ...)
would work?

>  	rcu_read_unlock();
>  	u64_stats_update_begin(&ns->syncp);
> @@ -426,6 +426,25 @@ static int nsim_init_napi(struct netdevsim *ns)
>  	return err;
>  }
>  
> +static enum hrtimer_restart nsim_napi_schedule(struct hrtimer *timer)
> +{
> +	struct nsim_rq *rq;
> +
> +	rq = container_of(timer, struct nsim_rq, napi_timer);
> +	napi_schedule(&rq->napi);
> +	/* TODO: Should HRTIMER_RESTART be returned if napi_schedule returns
> +	 * false?
> +	 */

I think not, ignore the return value

> +	return HRTIMER_NORESTART;
> +}


