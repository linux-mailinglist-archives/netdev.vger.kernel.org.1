Return-Path: <netdev+bounces-266433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHNaJrrXsGnLngIAu9opvQ
	(envelope-from <netdev+bounces-266433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:47:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F18E225B229
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2753030A4743
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 02:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D446299A84;
	Wed, 11 Mar 2026 02:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcHY7YfN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AB5131E49;
	Wed, 11 Mar 2026 02:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773197152; cv=none; b=uKGjCu0f+4eOVyLA6Jm9mqNAQ3Hl4eo9IxJsY4debmb5/uBrjO5dBlBr5mmg+zIlqQMzNP8f/ISHfLKPGz+OF9UYhcIBDklJD3f1ZAzAwoKkz1YxQjEUbtItLNq9bnZF5KHnNQ4qyc36BjfpfU2D/CClwc0d4uxWQZxqkelbWIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773197152; c=relaxed/simple;
	bh=tJBY0oKmShmrimbu8kR6Ic6jyXUaR6ocSPOVb/7bF74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlRPLykqDvRswyCCdCmILj2VVnLMaWXllMtAYqEjLNWZ4W/bK0U/2MAMuQ9MAlRjfKGl7AFq6VrRJXc6kS2MCsTkveC66Osmsqf/YJsNXfYFL88UdJevbtwKoG9UmGvh41DV/6UovFnOyJzFMPvrWtiL0rIY6BZ1XGisGcvRnLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcHY7YfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D43C19423;
	Wed, 11 Mar 2026 02:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773197151;
	bh=tJBY0oKmShmrimbu8kR6Ic6jyXUaR6ocSPOVb/7bF74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bcHY7YfN0xxDYZkDgeIQqDhJxYQKS3t9xkkhjK+gZcdVXRFjaRYMhaU3K1/7IoHLm
	 c+JPAszQ7UsaEJK1fqct9fywnOofUd1wWopM47nNuBRwTHmFGOhP++dVqMIJRp8P3e
	 N8u3Rs2PSegu1Pa469mxsRNraYBip86fn2biNOfH4EsNn4bhE3q6y5zM3guiQ/3jUH
	 iLEGYN87rbWCQp3A4pmK7eOFe9qVnSHNKYtu3lrNzt5t70ghSCsmrSbJkcORtfkY+3
	 RsbJjvseKn1Dbp0BJ4TfzeadsYFYxFmeHMBSpVUCJhLuYfeShOtbbR6PWk3vCgT5qd
	 zUW9gWKcGrG7w==
From: Jakub Kicinski <kuba@kernel.org>
To: matttbe@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	martineau@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	fw@strlen.de,
	horms@kernel.org,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	geliang@kernel.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Subject: Re: [net-next,1/2] mptcp: better mptcp-level RTT estimator
Date: Tue, 10 Mar 2026 19:45:47 -0700
Message-ID: <20260311024547.361027-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309-net-next-mptcp-reduce-rbuf-v1-1-8f471206f9c5@kernel.org>
References: <20260309-net-next-mptcp-reduce-rbuf-v1-1-8f471206f9c5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F18E225B229
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266433-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
mptcp: better mptcp-level RTT estimator

The current MPTCP-level RTT estimator has several issues. On high speed
links, the MPTCP-level receive buffer auto-tuning happens with a
frequency well above the TCP-level's one. That in turn can cause
excessive/unneeded receive buffer increase.

On such links, the initial rtt_us value is considerably higher than the
actual delay, and the current mptcp_rcv_space_adjust() updates
msk->rcvq_space.rtt_us with a period equal to the such field previous
value. If the initial rtt_us is 40ms, its first update will happen after
40ms, even if the subflows see actual RTT orders of magnitude lower.

Additionally:
- setting the msk RTT to the maximum among all the subflows RTTs makes
  DRS constantly overshooting the rcvbuf size when a subflow has
  considerable higher latency than the other(s).

- during unidirectional bulk transfers with multiple active subflows,
  the TCP-level RTT estimator occasionally sees considerably higher
  value than the real link delay, i.e. when the packet scheduler reacts
  to an incoming ACK on given subflow pushing data on a different
  subflow.

- currently inactive but still open subflows (i.e. switched to backup
  mode) are always considered when computing the msk-level RTT.

Address the all the issues above with a more accurate RTT estimation
strategy: the MPTCP-level RTT is set to the minimum of all the subflows
actually feeding data into the MPTCP receive buffer, using a small
sliding window.

> While at it, also use EWMA to compute the msk-level scaling_ratio, to
> that MPTCP can avoid traversing the subflow list is
> mptcp_rcv_space_adjust().

This isn't a bug, but there are two typos here that make the sentence
hard to parse. Should this be 'so that MPTCP can avoid traversing the
subflow list in mptcp_rcv_space_adjust()'?

Use some care to avoid updating msk and ssk level fields too often.

Fixes: a6b118febbab ("mptcp: add receive buffer auto-tuning")

[ ... ]

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 0bd1ee860316..6ec65c0ae655 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h

[ ... ]

> @@ -422,6 +435,27 @@ static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
>  	return msk->first_pending;
>  }
>
> +static inline void mptcp_init_rtt_est(struct mptcp_sock *msk)
> +{
> +	int i;
> +
> +	for (i = 0; i < MPTCP_RTT_SAMPLES; ++i)
> +		msk->rcv_rtt_est.samples[i] = U32_MAX;
> +	msk->rcv_rtt_est.next_sample = 0;
> +	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
> +}
> +
> +static inline u32 mptcp_rtt_us_est(const struct mptcp_sock *msk)
> +{
> +	u32 rtt_us = msk->rcv_rtt_est.samples[0];
                         ^^^^

Is samples[0] missing a READ_ONCE()?

The function comment says 'Lockless access of collected samples' and the
writer mptcp_rcv_rtt_update() uses WRITE_ONCE() for all sample indices
(including index 0) with a comment 'Pairs with READ_ONCE() in
mptcp_rtt_us_est()':

net/mptcp/protocol.c:mptcp_rcv_rtt_update() {
	...
	/* Pairs with READ_ONCE() in mptcp_rtt_us_est(). */
	id = msk->rcv_rtt_est.next_sample;
	WRITE_ONCE(msk->rcv_rtt_est.samples[id], rtt_us);
	...
}

However, samples[0] is read with a plain load while samples[1..4] correctly
use READ_ONCE():

> +	int i;
> +
> +	/* Lockless access of collected samples. */
> +	for (i = 1; i < MPTCP_RTT_SAMPLES; ++i)
> +		rtt_us = min(rtt_us, READ_ONCE(msk->rcv_rtt_est.samples[i]));
> +	return rtt_us;
> +}

The writer runs under mptcp_data_lock (spin_lock_bh) while the reader runs
under the socket lock (msk_owned_by_me) -- these are different locks, so
WRITE_ONCE/READ_ONCE pairing is required. KCSAN would flag this as a data
race.

> +
>  static inline struct mptcp_data_frag *mptcp_send_next(struct sock *sk)
>  {
>  	struct mptcp_sock *msk = mptcp_sk(sk);

[ ... ]

> @@ -523,6 +557,8 @@ struct mptcp_subflow_context {
>  	u32	map_data_len;
>  	__wsum	map_data_csum;
>  	u32	map_csum_len;
> +	u32	prev_rtt_us;
                    ^^^^

Is this field used anywhere?

The field 'prev_rtt_us' is added to struct mptcp_subflow_context but doesn't
appear to be referenced anywhere in the codebase. Only 'prev_rtt_seq' is used
in mptcp_rcv_rtt_update().

> +	u32	prev_rtt_seq;
>  	u32	request_mptcp : 1,  /* send MP_CAPABLE */
>  		request_join : 1,   /* send MP_JOIN */
>  		request_bkup : 1,
-- 
pw-bot: cr

