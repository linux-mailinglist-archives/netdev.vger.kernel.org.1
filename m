Return-Path: <netdev+bounces-285428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gC+yAgu8/GnSTAAAu9opvQ
	(envelope-from <netdev+bounces-285428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 18:21:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B454EC1E4
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 18:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 899783059596
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 16:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47353F7A98;
	Thu,  7 May 2026 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2BDwGeA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11593EFD2A;
	Thu,  7 May 2026 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170382; cv=none; b=hFMFJw0ElRlJKmYc1HxqaobaFbNdNlEwSW99S4G1AqvixhgSIE05u/coR/KtppmeLSQwavfBlIw1UZWefG7XdLNBSjXHXfj3xSscL5r+94Mjs6WDwP4gNUAZxP9aAStNn+NSpNh+tuFHQ3FypGiwr/Wlzd5v2mKWgEQScKfaq1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170382; c=relaxed/simple;
	bh=ex2k+tQzCOViUN/yUnsO5c6ctZ5+/pBXAtFzWgkCChY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rty6YNetbdwT6I/f4Wh2EeDV/MJfAdqsX0LYi0o7aZG9Vw4RWP48BirK7iqion/0Un0fbujbnRJ6mZtvJ+L8inZqy1dHNSDT0F5oaOHmLloc+HOzlnzwWeuSSLhGLwpO/0z7QmWALGgoFSgdF343YvUlCfDUHK9wQNQqnfvPhm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2BDwGeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F0FC2BCB2;
	Thu,  7 May 2026 16:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778170382;
	bh=ex2k+tQzCOViUN/yUnsO5c6ctZ5+/pBXAtFzWgkCChY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L2BDwGeA+qWMKfoIi44IilHZ6osHmbOC/wdCJrh4Mdkf5tDKK/tfXpMKGwmQ64745
	 bWvBT/EFIYqASy7P13+YlU6aWy4tM3e86TYFczDuBJNHJoFstBqlZ7eN6yj8jzKO2t
	 j+XG6L4YR6MHl7W8bggDAQiBaDrVXpKmUaZU9ijpKhlkz0IVwE4KZSsnC50bbwl68O
	 7zRdzyHg8hdPoWCbldwlog3y1HUeJVyJak8rz6y09mgnF+DCFKFKwzuD6DTaFSNt3F
	 zQgB4zerHO9ZEdjbf5ZkDJti5iT89L27WBG4/JCWhQ/EWhaLYquUWcMvvBCmxPscAc
	 B05nudQhDXT2A==
Message-ID: <e04af31d-d472-4064-9490-c6554cd9ccc5@kernel.org>
Date: Thu, 7 May 2026 18:12:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] mptcp: serialize subflow->closing with RX path
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>, martineau@kernel.org,
 mptcp@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: shardul.b@mpiricsoftware.com, janak@mpiric.us, kalpanjani009@gmail.com,
 shardulsb08@gmail.com
References: <20260507072802.612125-1-kalpan.jani@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: fr
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260507072802.612125-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 83B454EC1E4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mpiricsoftware.com,mpiric.us,gmail.com];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285428-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

Hi Kalpan,

On 07/05/2026 09:28, Kalpan Jani wrote:
> There is a race between mptcp_data_ready() (RX path) and
> mptcp_close_ssk() (teardown path) when accessing subflow->closing.

Thank you for sharing this patch!

Sadly, this patch doesn't apply and looks corrupted:

  Applying: mptcp: serialize subflow->closing with RX path
  error: corrupt patch at line 44
  error: could not build fake ancestor

Did you manually edit it without changing the line references?

While at it, please follow the rules from:

  https://docs.kernel.org/process/maintainer-netdev.html

=> designate your patch to a tree: [PATCH net]

It might be easier if you send new versions only to the MPTCP ML (not
ccing netdev).

> Currently, mptcp_data_ready() checks subflow->closing before acquiring
> mptcp_data_lock(), while mptcp_close_ssk() may concurrently set
> subflow->closing and purge backlog entries. This creates a classic
> time-of-check vs time-of-use (TOCTOU) race:
> 
>   CPU A (close path)              CPU B (RX path)
>   ----------------------         -------------------------
>   set closing = 1
>                                  read closing == 0
>   purge backlog
>                                  enqueue skb to backlog
> 
> As a result, skb entries referencing the subflow socket (ssk) may be
> enqueued after the subflow is marked closing and scheduled for cleanup.
> This can lead to:
> 
>   - WARN in inet_sock_destruct() due to non-zero sk_rmem_alloc
>   - potential use-after-free via stale skb->sk references

By chance, do you have (decoded) calltraces to share in the commit
message? And even better: a reproducer? Or explaining how you found this
issue, and eventually which tool helped you find it.

> Fix this by serializing both the closing check and backlog enqueue
> under mptcp_data_lock(). This ensures that subflow->closing state and
> backlog operations are observed atomically, preventing new skb from
> being enqueued once teardown begins.
> 
> Also protect backlog cleanup in mptcp_close_ssk() with the same lock
> to guarantee mutual exclusion with the RX path.
> 
> This restores proper synchronization between RX and teardown paths
> and prevents stale skb references to closing subflows.

Also, for fixes, the "Fixes:" tag is required.

> Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
> ---
>  net/mptcp/protocol.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 718e910ff..295f8e1c0 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -910,14 +910,34 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
>  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  
> +	/*
> +	 * The close path can set subflow->closing while we are racing
> +	 * from BH context here. The old check was done before taking
> +	 * mptcp_data_lock(), leaving a TOCTOU window:
> +	 *
> +	 *   CPU A: close path sets closing = 1 and purges backlog
> +	 *   CPU B: already observed closing == 0 and later enqueues skb
> +	 *
> +	 * That skb keeps skb->sk == ssk and can later trigger:
> +	 * - WARN in inet_sock_destruct() (ssk->sk_rmem_alloc != 0)
> +	 * - UAF in backlog purge via stale skb->sk
> +	 */

I don't think that's useful to add a comment referring an old behaviour.

> +
>  	/* The peer can send data while we are shutting down this
>  	 * subflow at subflow destruction time, but we must avoid enqueuing
>  	 * more data to the msk receive queue
>  	 */

Instead, I suggest moving this comment below as well, and merge it with
the new one you added.
> -	if (unlikely(subflow->closing))
> -		return;
>  
>  	mptcp_data_lock(sk);
> +
> +	/* Serialize closing check with backlog enqueue */
> +	if (unlikely(subflow->closing)) {
> +		mptcp_data_unlock(sk);

When locks are used, we usually prefer having one exit path: please add
a new label above mptcp_data_unlock() below, and a goto here.

> +		return;
> +	}
> +
>  	mptcp_rcv_rtt_update(msk, subflow);
>  	if (!sock_owned_by_user(sk)) {
>  		/* Wake-up the reader only for in-sequence data */
> @@ -2653,9 +2673,12 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  	if (sk->sk_state == TCP_ESTABLISHED)
>  		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
>  
> -	/* Remove any reference from the backlog to this ssk; backlog skbs consume
> +	/* Remove any reference from the backlog to this ssk.
> +	 * Serialize cleanup with RX-side enqueue using mptcp_data_lock().

Easier to add this new line at the end of the comment to reduce the diff.

> +	 * Backlog skbs consume
>  	 * space in the msk receive queue, no need to touch sk->sk_rmem_alloc
>  	 */
> +	mptcp_data_lock(sk);
>  	list_for_each_entry(skb, &msk->backlog_list, list) {
>  		if (skb->sk != ssk)
>  			continue;
> @@ -2663,6 +2686,8 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  		atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
>  		skb->sk = NULL;
>  	}
> +	mptcp_data_unlock(sk);
> +
>  

No double empty lines. I think 'checkpatch' would tell you that.

>  	/* subflow aborted before reaching the fully_established status
>  	 * attempt the creation of the next subflow

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


