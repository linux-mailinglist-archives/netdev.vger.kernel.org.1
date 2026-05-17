Return-Path: <netdev+bounces-288731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /bwlCoG0CWowmAQAu9opvQ
	(envelope-from <netdev+bounces-288731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 14:28:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8819B560F50
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 14:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E113300820D
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 12:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51EA3590A9;
	Sun, 17 May 2026 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+k2aFOx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE842DA756
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779020920; cv=none; b=YzZcNkryQtMnh36ud+NXDIA57LwwgHnzKbWKqDxsz61xBm3BwiNxJqnBK8JYnhwwTCS9oJTZldsSv8CBhlQA4GdJXcsX/kKk5jtg64KSw4bN/bJAIMkQ2KOESTgbBrxFmtZiPjtdIAhHO5fRTdFchzP+aDXN8ZllLae2h2b/SjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779020920; c=relaxed/simple;
	bh=G2oWO+6ikoHMseavY/u78fs5jjvjUDU7IhWzea/m3Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PO8mtIZip1HkUMS5VEJ5SZw0tuqUbfN+daPkqfhtmuGLcwSq5k7clrfBFy3mI7NfWysobYuPHb4FScMhaoLHIDtDkMh4zd1Bet2i0zrpaBgdnIroOmHfl+ZZUJZniPZLsThLLbVgjuVVIoIyciVHLPtoBIoXp1K78xq0eidbqjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+k2aFOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7B3C2BCB0;
	Sun, 17 May 2026 12:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779020920;
	bh=G2oWO+6ikoHMseavY/u78fs5jjvjUDU7IhWzea/m3Kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m+k2aFOxmaTOTG9phz/vyy6SE09BbSK9iZu9eyvjfiq7oiytSxj2va3B0vRqOtB51
	 26falRdGnORvZYFVdDUd6HmZK1JhkgCp8LfxH+3YNrJnN/X9jSd+X2PSsbKd+WijgI
	 1amH3Db6AArPXJA/VoNsZm/7LGVesImi1+qUe8gXzoKlxPQpEzFnOkoN3jk7jZpGu9
	 nmmNULv8/3/VzmEtWgLIiAccdXTaF1lY5KE1C/7iTUOj70pTErMRUder20/Uvje32E
	 iemULYmS2snW6sLqXj9Kcbo14qkxX/1rDpuGKA9b/6W3ORPwyBpEfRKEhJNdQSc2Xt
	 J+cCNsyRFm/Pw==
From: Simon Horman <horms@kernel.org>
To: n05ec@lzu.edu.cn
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn
Subject: Re: [PATCH net 1/1] llc: conn: drop out-of-service state in llc_conn_service
Date: Sun, 17 May 2026 13:25:00 +0100
Message-ID: <20260517122459.266554-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <5f646c530f4a0820060499054c46b8dbecebd7be.1778638129.git.zlian064@ucr.edu>
References: <5f646c530f4a0820060499054c46b8dbecebd7be.1778638129.git.zlian064@ucr.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8819B560F50
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com,gmail.com,lzu.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288731-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
llc: conn: drop out-of-service state in llc_conn_service

The commit adds a check for LLC_CONN_OUT_OF_SVC in llc_conn_service() to
avoid indexing state tables with an invalid state. It returns success for
this state to ignore repeated packets to a stale reachable socket.

> diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
> index 5c0ac243b248f..715d5a3140716 100644
> --- a/net/llc/llc_conn.c
> +++ b/net/llc/llc_conn.c
> @@ -360,6 +360,10 @@ static int llc_conn_service(struct sock *sk, struct sk_buff *skb)
>  	struct llc_sock *llc = llc_sk(sk);
>  	int rc = 1;
>  
> +	if (llc->state == LLC_CONN_OUT_OF_SVC) {
> +		rc = 0;
> +		goto out;
> +	}

Can this check still race with llc_sk_free() setting llc->state locklessly?

llc_ui_release() drops the socket lock via release_sock(sk) and calls
llc_sk_free(sk), which sets llc->state = LLC_CONN_OUT_OF_SVC (0) without
holding a lock.

Concurrently, a packet processed by llc_conn_handler() can acquire
bh_lock_sock(sk) and call llc_conn_service(). Since llc->state is checked
without READ_ONCE(), could the compiler emit multiple loads?

If llc->state is > 0 during this check, it passes. If CPU 1 then locklessly
changes llc->state to 0, the subsequent call to llc_qualify_conn_ev() could
read llc->state again from memory as 0.

This would evaluate llc->state - 1 as 255, causing an out-of-bounds array
access on llc_conn_state_table[255]. The garbage data could be interpreted
as curr_state->transitions, leading to unconditional dereferences and a
kernel panic. Does this lockless concurrency need to be addressed to
properly fix the issue?

Additionally, this highlights a potential timer race during socket teardown.
llc_sk_free() stops timers via llc_sk_stop_all_timers(sk, true).

CPU 1 starts socket destruction in llc_ui_release(), calling release_sock(sk)
followed by llc_sk_free(sk).

Concurrently, CPU 2 (finding the socket under RCU via __llc_lookup) receives
a packet in llc_conn_handler(), acquires bh_lock_sock(sk), and since
!sock_owned_by_user(sk) is now true, directly processes the packet.

If CPU 2 processes state transitions and triggers an action (like
llc_conn_ac_start_ack_timer) that calls mod_timer(), it could re-arm the
timer AFTER CPU 1 has stopped it, because CPU 1's timer_delete_sync() does
not wait for the packet handler.

When CPU 1 drops its reference, and CPU 2 finishes processing and calls
sock_put(sk), the socket memory is scheduled to be freed. Will the timer
re-armed by CPU 2 fire later on the freed socket memory, causing a
use-after-free regression?

>  	if (llc->state > NBR_CONN_STATES)
>  		goto out;
>  	rc = 0;

