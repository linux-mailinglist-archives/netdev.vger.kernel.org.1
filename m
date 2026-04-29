Return-Path: <netdev+bounces-282372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAuMOIf78WmElwEAu9opvQ
	(envelope-from <netdev+bounces-282372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:37:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1427C494268
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 381FB300BEB1
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9DF3BED1E;
	Wed, 29 Apr 2026 12:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dr/g0T/i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38521397E85;
	Wed, 29 Apr 2026 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466238; cv=none; b=BFwpgHIHE4RUxzAy3o1+MTBtmGh/X9ee7Nt1Ft1Oy054uaN+U/sal5hEkZvT//jp9cPz+dGFN5zB3Jbc0/Mo8a0/3QxVeMsZSRi0Hn7BLoO/LLR4WYGA9nGua053sThNBf1y1nuctAgGxM3UjEjMUc9GK4EbYtNVPGPXzs4S+iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466238; c=relaxed/simple;
	bh=hvuUMdThIwKFwbEJULtky1d689I530Q1mu8Oq7VyBwI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DjeZWKrRvHwiO4n1tZwT4QwND971JjA3x2Tk6sq69+fXIndhj7g2rZRzJvaKl9j1MEX1TG4K2UF74PzNJGtwO4cOGx6uvpG6zhtd7Ns53qhxfK2gvknaol13jRBzg6pnXlakMvxO7dDaAlDDr54RJyEV5r6z7KtnGsi3v2vrVCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dr/g0T/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F67BC19425;
	Wed, 29 Apr 2026 12:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777466237;
	bh=hvuUMdThIwKFwbEJULtky1d689I530Q1mu8Oq7VyBwI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dr/g0T/iHE3ynvq2KAdwl+wj9HFSUBzaKaIywu611UnOIRGzFM005oxs4QzepEGaM
	 kvqsxSuWSVF6F3GRnPwE4WtKMywXp2e6VYu/l+VnktkF7ZGOQXRGT2bmqjmQSQKCOU
	 c5PSeKutrmI+DRiK1bz0Tb4gWnkzXG9rb3Cft24DdhhO4BZHwwWczIXJEnlkUxcKuE
	 qgS1O50M1alQ7hCOGeqe3NHuXblCQrfE1gtiKPwlkOE1aOwWchSK5ZaTuQLnG7UGth
	 F30mV9wi49ZgqtWSfdKqocG1kGFuYm0z8vWcgRAUqANoEghgANb1MlJ1puykH3gKSG
	 PQ2VE/Pv0BRcw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Cc: Martin Karsten <mkarsten@uwaterloo.ca>, dtatulea@nvidia.com, Gal
 Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Joe Damato
 <joe@dama.to>, Frederik Deweerdt <fdeweerdt@fastly.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 2/2] net: napi: Skip poll when arming GRO
 timer in busy poll
In-Reply-To: <20260428175134.1197036-4-dtatulea@nvidia.com>
References: <20260428175134.1197036-2-dtatulea@nvidia.com>
 <20260428175134.1197036-4-dtatulea@nvidia.com>
Date: Wed, 29 Apr 2026 14:37:14 +0200
Message-ID: <87ik9ahrid.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1427C494268
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282372-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,uwaterloo.ca:email]

Dragos Tatulea <dtatulea@nvidia.com> writes:

> From: Martin Karsten <mkarsten@uwaterloo.ca>
>
> As referenced in the previous patch, having the GRO timer scheduled
> while poll is running can lead to issues.

Outline the issues here as well, so we don't need to cross-reference the
kernel logs.

> Skip the extra call to napi->poll() when the GRO timer is armed. This
> removes the need for having a separate __busy_poll_stop routine and its
> code is moved directly into the relevant places in busy_poll_stop.

Nice!

> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Co-developed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  net/core/dev.c | 61 +++++++++++++++++++++++++-------------------------
>  1 file changed, 30 insertions(+), 31 deletions(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1487d4946dcf..d4829c2484f5 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6869,26 +6869,6 @@ static void skb_defer_free_flush(void)
>=20=20
>  #if defined(CONFIG_NET_RX_BUSY_POLL)
>=20=20
> -static void __busy_poll_stop(struct napi_struct *napi, unsigned long tim=
eout)
> -{
> -	unsigned long flags;
> -
> -	if (!timeout) {
> -		gro_normal_list(&napi->gro);
> -		__napi_schedule(napi);
> -		return;
> -	}
> -
> -	/* Flush too old packets. If HZ < 1000, flush all packets */
> -	gro_flush_normal(&napi->gro, HZ >=3D 1000);
> -
> -	local_irq_save(flags);
> -	hrtimer_start(&napi->timer, ns_to_ktime(timeout),
> -		      HRTIMER_MODE_REL_PINNED);
> -	clear_bit(NAPI_STATE_SCHED, &napi->state);
> -	local_irq_restore(flags);
> -}
> -
>  enum {
>  	NAPI_F_PREFER_BUSY_POLL	=3D 1,
>  	NAPI_F_END_ON_RESCHED	=3D 2,
> @@ -6898,14 +6878,14 @@ static void busy_poll_stop(struct napi_struct *na=
pi, void *have_poll_lock,
>  			   unsigned flags, u16 budget)
>  {
>  	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
> -	unsigned long timeout =3D 0;
> +	unsigned long timeout;
>  	int rc;
>=20=20
>  	/* Busy polling means there is a high chance device driver hard irq
>  	 * could not grab NAPI_STATE_SCHED, and that NAPI_STATE_MISSED was
>  	 * set in napi_schedule_prep().
> -	 * Since we are about to call napi->poll() once more, we can safely
> -	 * clear NAPI_STATE_MISSED.
> +	 * Since we either call napi->poll() once more or start the timer,
> +	 * we can safely clear NAPI_STATE_MISSED.
>  	 *
>  	 * Note: x86 could use a single "lock and ..." instruction
>  	 * to perform these two clear_bit()
> @@ -6918,13 +6898,28 @@ static void busy_poll_stop(struct napi_struct *na=
pi, void *have_poll_lock,
>=20=20
>  	if (flags & NAPI_F_PREFER_BUSY_POLL) {
>  		napi->defer_hard_irqs_count =3D napi_get_defer_hard_irqs(napi);
> -		if (napi->defer_hard_irqs_count) {
> -			/* Timer will be scheduled after napi poll to avoid
> -			 * firing during a slow poll which could cause the
> -			 * queue to get stuck with interrupts disabled and no
> -			 * scheduled timer.
> +		timeout =3D napi_get_gro_flush_timeout(napi);
> +		if (napi->defer_hard_irqs_count && timeout) {
> +			unsigned long flags;
> +
> +			/* Drop prefer-busy state as in napi_complete_done(). */
> +			clear_bit(NAPI_STATE_PREFER_BUSY_POLL, &napi->state);
> +			netpoll_poll_unlock(have_poll_lock);
> +
> +			/* Flush too old packets. If HZ < 1000, flush all
> +			 * packets.
> +			 */
> +			gro_flush_normal(&napi->gro, HZ >=3D 1000);
> +			local_irq_save(flags);
> +			hrtimer_start(&napi->timer, ns_to_ktime(timeout),
> +				      HRTIMER_MODE_REL_PINNED);
> +			clear_bit(NAPI_STATE_SCHED, &napi->state);
> +			local_irq_restore(flags);

(Same swap arm timer/clear as patch 1.)

> +
> +			/* Timer started, so need for another call to
                                            ^
                                       "so *NO* need for another..."



Bj=C3=B6rn

