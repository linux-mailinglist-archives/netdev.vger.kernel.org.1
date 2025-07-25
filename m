Return-Path: <netdev+bounces-210227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E30B126FA
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 00:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CB4F3B2887
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 22:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A427123C516;
	Fri, 25 Jul 2025 22:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcyNcNqt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFB010FD
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753483518; cv=none; b=dG+JH4uJF1fAlbwF2BIyLA0aAGm4XRtjNZLXQEDYAw4wz0uBEibtduSrRjpenL1K21Y4ATjEz725hTMyQukRcqv/CfCu/rvDoF1j2fFrbcnXHNnhcjcgPyiTb6PS4/yWhn266/L7xOPr0GaQS2cYjTGh+U2NQkIHizzdAuPDxzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753483518; c=relaxed/simple;
	bh=jl8VSjn07cVzpdQW24nYilzKRFpMdpQwjTRrpolzW4M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSN8dOJyQSjycFBRpZ9V8mvmzt6UpXWfPtQBMXTIUMcw+ho2SULWM6Pw6Le+Eap5L77FkTwoTsdF4aR5V6yb7HOpiFFUVtE9kl98/JsUjD4iOTg26ffrJurcl4d8iejT61MGrlS9zy388CnAD4mGc+Z9GtVpP91QaY+HHFmi3Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcyNcNqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944A1C4CEE7;
	Fri, 25 Jul 2025 22:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753483517;
	bh=jl8VSjn07cVzpdQW24nYilzKRFpMdpQwjTRrpolzW4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VcyNcNqtMEUEyPMCdRV5/dtd69g95u+KQz2qMnUy/YXvjAy82Ep67c44XhfT0Xm3O
	 pvwjlvq7JrhhEgtM3STb9DDGb6JTZpXurRHGTFugfxurjTd8yBmgPIAsDQGzarqXbe
	 7KY0b1+ForKrdNDmlTv6rNCeemYz7ZD7VaEWX620/QA0BM2SV1zrpwk/qmbZDbyK27
	 w5p6JrVcAq53izarx3EYgQz1q2+jv8WEjFbJKrd/G0SsUyCzeIS/oLAHU0Lj4fvbTj
	 ZeCVi/lrqn4QDMEj2WVpjTFgD6NRh6Fv+vntK0uaOZi+s669K8gp/f6bsrltvrOA19
	 W3Qh8ETLTgOlA==
Date: Fri, 25 Jul 2025 15:45:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krishna Kumar <krikku@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 tom@herbertland.com, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me,
 kuniyu@google.com, ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
 atenart@kernel.org, krishna.ku@flipkart.com
Subject: Re: [PATCH v6 net-next 1/2] net: Prevent RPS table overwrite for
 active flows
Message-ID: <20250725154515.0bff0c4d@kernel.org>
In-Reply-To: <20250723061604.526972-2-krikku@gmail.com>
References: <20250723061604.526972-1-krikku@gmail.com>
	<20250723061604.526972-2-krikku@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 11:46:03 +0530 Krishna Kumar wrote:
> +#ifdef CONFIG_RFS_ACCEL
> +/**
> + * rps_flow_is_active - check whether the flow is recently active.
> + * @rflow: Specific flow to check activity.
> + * @flow_table: Check activity against the flow_table's size.
> + * @cpu: CPU saved in @rflow.
> + *
> + * If the CPU has processed many packets since the flow's last activity
> + * (beyond 10 times the table size), the flow is considered stale.
> + *
> + * Return: true if flow was recently active.
> + */
> +static bool rps_flow_is_active(struct rps_dev_flow *rflow,
> +			       struct rps_dev_flow_table *flow_table,
> +			       unsigned int cpu)
> +{
> +	return cpu < nr_cpu_ids &&
> +	       ((int)(READ_ONCE(per_cpu(softnet_data, cpu).input_queue_head) -
> +		READ_ONCE(rflow->last_qtail)) < (int)(10 << flow_table->log));

Since you're factoring this condition out you could split it up a bit.
Save the result of at least that READ_ONCE() that takes up an entire
line to a temporary variable?

> +}
> +#endif
> +
>  static struct rps_dev_flow *
>  set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
>  	    struct rps_dev_flow *rflow, u16 next_cpu)
> @@ -4847,8 +4869,11 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
>  		struct netdev_rx_queue *rxqueue;
>  		struct rps_dev_flow_table *flow_table;
>  		struct rps_dev_flow *old_rflow;
> +		struct rps_dev_flow *tmp_rflow;
> +		unsigned int tmp_cpu;
>  		u16 rxq_index;
>  		u32 flow_id;
> +		u32 hash;
>  		int rc;
>  
>  		/* Should we steer this flow to a different hardware queue? */
> @@ -4863,14 +4888,58 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
>  		flow_table = rcu_dereference(rxqueue->rps_flow_table);
>  		if (!flow_table)
>  			goto out;
> -		flow_id = rfs_slot(skb_get_hash(skb), flow_table);
> +
> +		hash = skb_get_hash(skb);
> +		flow_id = rfs_slot(hash, flow_table);
> +
> +		tmp_rflow = &flow_table->flows[flow_id];
> +		tmp_cpu = READ_ONCE(tmp_rflow->cpu);
> +
> +		/* Make sure this slot is usable before enabling steer */

This comment is less clear than the code..

> +		if (READ_ONCE(tmp_rflow->filter) != RPS_NO_FILTER) {
> +			/* This slot has an entry */
> +			if (rps_flow_is_active(tmp_rflow, flow_table,
> +					       tmp_cpu)) {
> +				/*
> +				 * This slot has an active "programmed" flow.
> +				 * Break out if the cached value stored is for
> +				 * a different flow, or (for our flow) the
> +				 * rx-queue# did not change.
> +				 */

This just restates what the code does

> +				if (hash != READ_ONCE(tmp_rflow->hash) ||
> +				    next_cpu == tmp_cpu) {
> +					/*
> +					 * Don't unnecessarily reprogram if:
> +					 * 1. This slot has an active different
> +					 *    flow.
> +					 * 2. This slot has the same flow (very
> +					 *    likely but not guaranteed) and
> +					 *    the rx-queue# did not change.
> +					 */

Again, over-commenting, the logic is clear enough.

> +					goto out;
> +				}
> +			}
> +
> +			/*
> +			 * When we overwrite the flow, the driver still has
> +			 * the cached entry. But drivers will check if the
> +			 * flow is active and rps_may_expire_entry() will
> +			 * return False and driver will delete it soon. Hence
> +			 * inconsistency between kernel & driver is quickly
> +			 * resolved.
> +			 */

I don't get this comment either, and rps_may_expire_entry() does not
exist in my tree.
-- 
pw-bot: cr

