Return-Path: <netdev+bounces-287171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNrSAvEsA2oR1QEAu9opvQ
	(envelope-from <netdev+bounces-287171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:36:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8073752155D
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4220D30BA6A6
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA5437DAC1;
	Tue, 12 May 2026 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpRTkRs3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A52306752
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592395; cv=none; b=mctXz0DEQQ88etsn2T2w1ZU+gyq8MO/l1IARzLiVtzjrrTF/auEb3bvRo7Bdg8b126Zydc7kcrByGJt4b5tkGpQf71/e0fxZiKQhpuXC6aQMcLPrIANoFPTjyqLgPV0xYcnrcGbnrK24rWDfkbZCunlVqjxjZMO12n6+vxetD4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592395; c=relaxed/simple;
	bh=b4XhNp0UWc1yfEFniGkhv4cA1hHPcErYbeB/BzkkrtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+P/akrNtTABQPJxG5IAaYi7F2B1SHiOcocx+sXn7zAFyYAT9/URQcJgbQ0G/AX4ijhxqnZugIjFDkuT90mh2NMjSRw0wwXc8h+twwRS+NBffcC0lzQ8OzQKR8xm3zToqGW7GKlFEhXQgaBTJ8ctOyDE7gw158fLgnVELanZAM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpRTkRs3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82979C2BCB0;
	Tue, 12 May 2026 13:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778592395;
	bh=b4XhNp0UWc1yfEFniGkhv4cA1hHPcErYbeB/BzkkrtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lpRTkRs3reAncqEhKVlMocglgujtq2spqbCvRzIH+3OKtW4Re86I9yTHMYmzcrk6N
	 NT5PNL9bLk7/FBkzS7kXjcBzd+s2eaEaGqC4QZz+tEETYBSzOwfEcEm6oaeShMK3N9
	 rKI/EqdEa9CL1BOOUBMnRK4ojlxhKiFK2KaN+oSf/gAc8jTRg1rzxIlPWH9gDHyyo9
	 iiGI9AtoWMzLj0cA0q+f5I4OHQZmZpmpzL7+NOnGxx+UDRVNYUE0foxKeqORin/NV/
	 f2T1AnCy6Y9+BZJYoumf7bxy+p7nl9DKImpemrLxw7HhVLidfOu1ZTBhoy1yptY1Kn
	 5mPBqMYyXFJ4g==
From: Simon Horman <horms@kernel.org>
To: n05ec@lzu.edu.cn
Cc: 'Simon Horman' <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	dhowells@redhat.com,
	marc.dionne@auristor.com,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	d4n.for.sec@gmail.com
Subject: Re: [PATCH net 1/1] rxrpc: serialize kernel accept preallocation with socket teardown
Date: Tue, 12 May 2026 14:25:55 +0100
Message-ID: <20260512132554.387036-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <4e9e2d92be94ed4bcb43b70b36fcc3863414d61e.1778230563.git.d4n.for.sec@gmail.com>
References: <4e9e2d92be94ed4bcb43b70b36fcc3863414d61e.1778230563.git.d4n.for.sec@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8073752155D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.infradead.org,vger.kernel.org,redhat.com,auristor.com,gmail.com,lzu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287171-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
rxrpc: serialize kernel accept preallocation with socket teardown

This commit attempts to fix a use-after-free in the rxrpc accept
preallocation path by serializing the state check and backlog lookup
with the socket lock.

Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>

> diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
> index ee2d1319e69a8..47824120f1da1 100644
> --- a/net/rxrpc/call_accept.c
> +++ b/net/rxrpc/call_accept.c
> @@ -471,13 +471,26 @@ int rxrpc_kernel_charge_accept(struct socket *sock, rxrpc_notify_rx_t notify_rx,
>  			       unsigned long user_call_ID, gfp_t gfp,
>  			       unsigned int debug_id)
>  {
> -	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
> -	struct rxrpc_backlog *b = rx->backlog;
> +	struct rxrpc_backlog *b;
> +	struct rxrpc_sock *rx;
> +	struct sock *sk;
> +	int ret;
>  
> -	if (sock->sk->sk_state == RXRPC_CLOSE)
> -		return -ESHUTDOWN;
> +	sk = sock->sk;

Could the sock pointer passed to this function already be freed by the time it
executes?

The AFS subsystem afs_rx_new_call() queues charge_preallocation_work on
afs_wq. However, during socket teardown, afs_close_socket() appears to flush
afs_async_calls instead of afs_wq and doesn't cancel the work item with
cancel_work_sync().

If the stray work executes asynchronously after sock_release() has destroyed
the socket, wouldn't dereferencing sock->sk result in a use-after-free?

> +	rx = rxrpc_sk(sk);
> +
> +	lock_sock(sk);

Does lock_sock() adequately protect against concurrent socket release?

Looking at the socket release path, rxrpc_release_sock() modifies
sk->sk_state and calls rxrpc_discard_prealloc() (which frees the
backlog) without holding lock_sock().

If rxrpc_kernel_charge_accept() runs concurrently with socket release,
could rxrpc_release_sock() locklessly free the backlog from under it while
this function holds the socket lock, leading to a use-after-free when
accessing the backlog below?

> +	if (sk->sk_state != RXRPC_SERVER_LISTENING || !rx->backlog) {
> +		ret = -ESHUTDOWN;
> +		goto out;
> +	}
> +
> +	b = rx->backlog;
> +	ret = rxrpc_service_prealloc_one(rx, b, notify_rx, user_call_ID,
> +					 gfp, debug_id);

[ ... ]

