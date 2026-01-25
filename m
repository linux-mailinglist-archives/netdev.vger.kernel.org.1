Return-Path: <netdev+bounces-253226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Nk2VMmKSdmkxSQEAu9opvQ
	(envelope-from <netdev+bounces-253226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:00:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E316C8296A
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B40C3004C71
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 21:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328AE30DD01;
	Sun, 25 Jan 2026 21:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSlUdUvV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9443EBF1B;
	Sun, 25 Jan 2026 21:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769378398; cv=none; b=ZiNTOjcm5XgFXzMLC4SRRIY6o6vlsy50hU8/poluuay4pDtKUUtRG2u4n1aDF+pADL2lOzPXbR6y4pmtYCejAAyQGm3garNFIW5rMKeWgeOEn0LuXnqVbvXbd8KV5MPrzcHeYzc/KeNA/Lw5Jx1PHGr3zY29AZFzMFDhtKb7SSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769378398; c=relaxed/simple;
	bh=ZO6A/CyKckGTfWnisljDjAqexpUHCHH98OI+U4Yo5o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJ24l2kPHfe6eBWBQRecmqZxAsiaPieWAK+nsGDhpHf0+XKRGozfEhxOvZ8uROHYf15UZ4THAEzvUkDMJJVp7nVPfXNysD+udygo2EVpONkFWAymRUYwJ6LT6sFgJmuOAjxfvXHRIHE6Yydx0L2kSwZZwiS+AmVlkZwAskXB8Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSlUdUvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DD7C4CEF1;
	Sun, 25 Jan 2026 21:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769378397;
	bh=ZO6A/CyKckGTfWnisljDjAqexpUHCHH98OI+U4Yo5o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cSlUdUvVM5CmfWzF8aFiym64cMv5fTiDkRuiguV7k65BxgFXXwrVPRsasLDxp2iB0
	 raShjIEG8AcjZLh4tUpbGULaXIaD0fyzSNXMV061U9gJ6r0vxCldrAC7ieD2tC+oIb
	 LdgJKQwR8ljyqZx/TNTXVjKyv5halCnIXnTrUyp9LWfC6lWYtA2gmtc3mlkMa6xINi
	 OFgnPbxKX5F/sfOoNcfJOP9zLPHbG5s5QiQFDBVG75gFRhi3WorFvjqE/RjOWAaJh5
	 UjAivZj/+M6zcyvctavd0sI2qla7AOgmF/aZWh+kCuOJIRzLU5ZhHd8Fl1Svpy+nq7
	 lDCpgCO8FEu3w==
From: Jakub Kicinski <kuba@kernel.org>
To: qikeyu2017@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	tglx@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	mingo@kernel.org,
	acme@mandriva.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: llc: fix resource exhaustion in llc_conn_handler()
Date: Sun, 25 Jan 2026 13:59:54 -0800
Message-ID: <20260125215954.3391727-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123202211.2082-2-qikeyu2017@gmail.com>
References: <20260123202211.2082-2-qikeyu2017@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253226-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: E316C8296A
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
llc: fix resource exhaustion in llc_conn_handler()

This patch adds accept queue limit checking to llc_conn_handler() to
prevent resource exhaustion from unlimited socket creation. It adds
sk_acceptq_is_full() check before creating sockets and sk_acceptq_added()
after successful creation.

> diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
> index 5c0ac243b248..9296b5d6b04a 100644
> --- a/net/llc/llc_conn.c
> +++ b/net/llc/llc_conn.c
> @@ -802,10 +802,15 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
>  	 * in the newly created struct sock private area. -acme
>  	 */
>  	if (unlikely(sk->sk_state == TCP_LISTEN)) {
> -		struct sock *newsk = llc_create_incoming_sock(sk, skb->dev,
> -							      &saddr, &daddr);
> +		struct sock *newsk;
> +
> +		if (sk_acceptq_is_full(sk))
> +			goto drop_unlock;
> +		newsk = llc_create_incoming_sock(sk, skb->dev,
> +						 &saddr, &daddr);
>  		if (!newsk)
>  			goto drop_unlock;
> +		sk_acceptq_added(sk);
>  		skb_set_owner_r(skb, newsk);

After sk_acceptq_added(sk) increments the accept queue counter, this code
continues to llc_conn_rcv() or sk_add_backlog(). If sk_add_backlog() fails
later in the function (around line 833), the code goes to drop_unlock which
only frees the skb:

    drop_unlock:
        kfree_skb(skb);
        goto out;

Can newsk leak on this error path? The socket was created by
llc_create_incoming_sock() and added to the SAP via llc_sap_add_socket(),
but on sk_add_backlog() failure it appears never to be freed.

Additionally, sk_acceptq_added() incremented sk->sk_ack_backlog, but
drop_unlock does not call sk_acceptq_removed(). Does this cause the accept
queue counter to become permanently inflated?

For comparison, TCP handles this atomically in inet_csk_reqsk_queue_add()
where sk_acceptq_added() is called only after the socket is successfully
added to the accept queue, and inet_child_forget() cleans up on failure.
-- 
pw-bot: cr

