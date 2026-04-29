Return-Path: <netdev+bounces-282156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJH9JtVS8WkLgAEAu9opvQ
	(envelope-from <netdev+bounces-282156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:37:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 009D048DC64
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAACD303648E
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09291A5B84;
	Wed, 29 Apr 2026 00:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPoa6uJB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0DFF9C0;
	Wed, 29 Apr 2026 00:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777423056; cv=none; b=R8BknJ35qrVNQuO+mh976bRP83jvw+gGEH3su4TIpZ654SOQOW1tcZrwEuTMuBCGm2+9XW9VRJ3zxRfqZm1WPtFNK0MtjGaYFBdVgK2usztFpfcSztzb5JZfIvCRHvdsbF0sQTTSJDHfUHFyU9b4HvgJMTU+bxUMlXo8yuEeO1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777423056; c=relaxed/simple;
	bh=IF9PBVU3Or7At1QNPU5OpYnjZKYrdCxKh4UrwLCWUDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HeF39/9iqHkGuYthp7ebT2T2g4OqeuBwC545NyuMkW3jbTgHU9YKsgSXHXVM2gJVSZQMS+8J/FeWEaxyiNBbhQrtvsf4G8ftuqWdVDCRFKVfgLk/RrskmaA71cs6Sx8P+aDyAPXnky0i20YbOXWH61nl8kQ5ssCIl3EIPh7na04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPoa6uJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5791C2BCAF;
	Wed, 29 Apr 2026 00:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777423056;
	bh=IF9PBVU3Or7At1QNPU5OpYnjZKYrdCxKh4UrwLCWUDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JPoa6uJBkgjkNHm6SlNXUeWuEofg+mxvXMlEXsd1pxkT5Ud5LsRhx8YjEuxXbTJY3
	 OJJ19XEqGbbA7iiqvmBukOdoA2Me/wo4E+LjAbARlGVoxnb2GcK7M1cRNhJ/5NcGuF
	 uJzpfAX3zIWRSdJRvooDWyxzs26kasi0es6sONCxQAp0T5YXHWoA+EpNg8aKLW8S8z
	 nZAIIyuEItB0ixGu6uh/wLSYg7v3xDzBbBA+ln5sc0fHiX2m8KUnp0chUciTtnW60U
	 p96NSNZVkkEScda/TeaumT/2DTrNbnsPJ4oOZP0rV7/m/RdbB5Vx3BQFwymjfwcJFS
	 qgdOyDiPzK8EQ==
Date: Tue, 28 Apr 2026 17:37:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Martin Karsten <mkarsten@uwaterloo.ca>, Gal Pressman
 <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Joe Damato
 <joe@dama.to>, Frederik Deweerdt <fdeweerdt@fastly.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 2/2] net: napi: Skip poll when arming GRO
 timer in busy poll
Message-ID: <20260428173734.7f4ee58d@kernel.org>
In-Reply-To: <20260428175134.1197036-4-dtatulea@nvidia.com>
References: <20260428175134.1197036-2-dtatulea@nvidia.com>
	<20260428175134.1197036-4-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 009D048DC64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282156-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,uwaterloo.ca:email]

On Tue, 28 Apr 2026 17:51:31 +0000 Dragos Tatulea wrote:
> From: Martin Karsten <mkarsten@uwaterloo.ca>
> 
> As referenced in the previous patch, having the GRO timer scheduled
> while poll is running can lead to issues.
> 
> Skip the extra call to napi->poll() when the GRO timer is armed. This
> removes the need for having a separate __busy_poll_stop routine and its
> code is moved directly into the relevant places in busy_poll_stop.

This needs to go in separately, the previous patch should be a Fix,
this is net-next material.

> @@ -6918,13 +6898,28 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
>  
>  	if (flags & NAPI_F_PREFER_BUSY_POLL) {
>  		napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
> -		if (napi->defer_hard_irqs_count) {
> -			/* Timer will be scheduled after napi poll to avoid
> -			 * firing during a slow poll which could cause the
> -			 * queue to get stuck with interrupts disabled and no
> -			 * scheduled timer.
> +		timeout = napi_get_gro_flush_timeout(napi);
> +		if (napi->defer_hard_irqs_count && timeout) {
> +			unsigned long flags;

Feels like either timeout should also be declared in closest scope or
flags at function level

> +			/* Drop prefer-busy state as in napi_complete_done(). */

sloppy comment

> +			clear_bit(NAPI_STATE_PREFER_BUSY_POLL, &napi->state);
> +			netpoll_poll_unlock(have_poll_lock);
> +
> +			/* Flush too old packets. If HZ < 1000, flush all
> +			 * packets.
> +			 */

sloppy comment

> +			gro_flush_normal(&napi->gro, HZ >= 1000);
> +			local_irq_save(flags);
> +			hrtimer_start(&napi->timer, ns_to_ktime(timeout),
> +				      HRTIMER_MODE_REL_PINNED);
> +			clear_bit(NAPI_STATE_SCHED, &napi->state);
> +			local_irq_restore(flags);
> +
> +			/* Timer started, so need for another call to
> +			 * napi->poll().
>  			 */
> -			timeout = napi_get_gro_flush_timeout(napi);
> +			goto out;

I think an else branch would do here? Let's not abuse goto


>  		}
>  	}
>  
> @@ -6938,8 +6933,12 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
>  	 */
>  	trace_napi_poll(napi, rc, budget);
>  	netpoll_poll_unlock(have_poll_lock);
> -	if (rc == budget)
> -		__busy_poll_stop(napi, timeout);
> +	if (rc == budget) {
> +		gro_normal_list(&napi->gro);
> +		__napi_schedule(napi);
> +	}
> +
> +out:
>  	bpf_net_ctx_clear(bpf_net_ctx);
>  	local_bh_enable();
>  }


