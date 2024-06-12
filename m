Return-Path: <netdev+bounces-102956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 433E69059BD
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 19:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE05F285305
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 17:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B96181D06;
	Wed, 12 Jun 2024 17:18:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E09181CF3;
	Wed, 12 Jun 2024 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718212713; cv=none; b=uTe0g8vazM9vVOZ5x+bl7GkqJRKSS4JarPqPNktoI0Yz1MyPI6gyagt2cpnJQcDOwl9sh6dyYHMgyomtUPEYGCrJmUl+njjf+yPPjRn8WF7E7P1ZD6VvUMFNO3MEzeLrbpgr9c1gI8LmnJF6jn4MpgmPBFwewMs1s/78/nYb5bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718212713; c=relaxed/simple;
	bh=RlO+aaT++s2x82CDZH+vpEhG43YuOlTihcVA8EJmFI0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=st8Nui8+7Zo5lubqfTDC4qOcIgT0fW8FAZcAugJV/j4o8JnTTaBOKTEP5cfGVACnU2o/fOk4/ZVQVe4Dnw+NvnvZmx6jlm/EL01VzzXBfMZOOdlwoZ3GvSHHQUXn1xRiPGNkqKlcNOV3NKCbksko4mlsCZX5cgrnHYhXevCO4Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F0EC116B1;
	Wed, 12 Jun 2024 17:18:30 +0000 (UTC)
Date: Wed, 12 Jun 2024 13:18:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Daniel Bristot de Oliveira <bristot@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Eric Dumazet <edumazet@google.com>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Waiman Long
 <longman@redhat.com>, Will Deacon <will@kernel.org>, Ben Segall
 <bsegall@google.com>, Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli
 <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
 <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v6 net-next 08/15] net: softnet_data: Make
 xmit.recursion per task.
Message-ID: <20240612131829.2e33ca71@rorschach.local.home>
In-Reply-To: <20240612170303.3896084-9-bigeasy@linutronix.de>
References: <20240612170303.3896084-1-bigeasy@linutronix.de>
	<20240612170303.3896084-9-bigeasy@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 18:44:34 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Softirq is preemptible on PREEMPT_RT. Without a per-CPU lock in
> local_bh_disable() there is no guarantee that only one device is
> transmitting at a time.
> With preemption and multiple senders it is possible that the per-CPU
> recursion counter gets incremented by different threads and exceeds
> XMIT_RECURSION_LIMIT leading to a false positive recursion alert.
> 
> Instead of adding a lock to protect the per-CPU variable it is simpler
> to make the counter per-task. Sending and receiving skbs happens always
> in thread context anyway.
> 
> Having a lock to protected the per-CPU counter would block/ serialize two
> sending threads needlessly. It would also require a recursive lock to
> ensure that the owner can increment the counter further.
> 
> Make the recursion counter a task_struct member on PREEMPT_RT.

I'm curious to what would be the harm to using a per_task counter
instead of per_cpu outside of PREEMPT_RT. That way, we wouldn't have to
have the #ifdef.

-- Steve


> 
> Cc: Ben Segall <bsegall@google.com>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/netdevice.h | 11 +++++++++++
>  include/linux/sched.h     |  4 +++-
>  net/core/dev.h            | 20 ++++++++++++++++++++
>  3 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index d20c6c99eb887..b5ec072ec2430 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3223,7 +3223,9 @@ struct softnet_data {
>  #endif
>  	/* written and read only by owning cpu: */
>  	struct {
> +#ifndef CONFIG_PREEMPT_RT
>  		u16 recursion;
> +#endif
>  		u8  more;
>  #ifdef CONFIG_NET_EGRESS
>  		u8  skip_txqueue;
> @@ -3256,10 +3258,19 @@ struct softnet_data {
>  
>  DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
>  
> +#ifdef CONFIG_PREEMPT_RT
> +static inline int dev_recursion_level(void)
> +{
> +	return current->net_xmit_recursion;
> +}
> +
> +#else
> +
>  static inline int dev_recursion_level(void)
>  {
>  	return this_cpu_read(softnet_data.xmit.recursion);
>  }
> +#endif
>  
>  void __netif_schedule(struct Qdisc *q);
>  void netif_schedule_queue(struct netdev_queue *txq);
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 61591ac6eab6d..a9b0ca72db55f 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -975,7 +975,9 @@ struct task_struct {
>  	/* delay due to memory thrashing */
>  	unsigned                        in_thrashing:1;
>  #endif
> -
> +#ifdef CONFIG_PREEMPT_RT
> +	u8				net_xmit_recursion;
> +#endif
>  	unsigned long			atomic_flags; /* Flags requiring atomic access. */
>  
>  	struct restart_block		restart_block;
> diff --git a/net/core/dev.h b/net/core/dev.h
> index b7b518bc2be55..2f96d63053ad0 100644
> --- a/net/core/dev.h
> +++ b/net/core/dev.h
> @@ -150,6 +150,25 @@ struct napi_struct *napi_by_id(unsigned int napi_id);
>  void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu);
>  
>  #define XMIT_RECURSION_LIMIT	8
> +
> +#ifdef CONFIG_PREEMPT_RT
> +static inline bool dev_xmit_recursion(void)
> +{
> +	return unlikely(current->net_xmit_recursion > XMIT_RECURSION_LIMIT);
> +}
> +
> +static inline void dev_xmit_recursion_inc(void)
> +{
> +	current->net_xmit_recursion++;
> +}
> +
> +static inline void dev_xmit_recursion_dec(void)
> +{
> +	current->net_xmit_recursion--;
> +}
> +
> +#else
> +
>  static inline bool dev_xmit_recursion(void)
>  {
>  	return unlikely(__this_cpu_read(softnet_data.xmit.recursion) >
> @@ -165,5 +184,6 @@ static inline void dev_xmit_recursion_dec(void)
>  {
>  	__this_cpu_dec(softnet_data.xmit.recursion);
>  }
> +#endif
>  
>  #endif


