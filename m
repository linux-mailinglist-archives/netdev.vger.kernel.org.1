Return-Path: <netdev+bounces-283177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHc3Eh6k9GlKDAIAu9opvQ
	(envelope-from <netdev+bounces-283177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 15:01:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 274DF4AC878
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 15:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 818903006013
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 13:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C1621C9EA;
	Fri,  1 May 2026 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WakF7gha"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234AC1A0728;
	Fri,  1 May 2026 13:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777640471; cv=none; b=HRSixqqGWqDlR70liAlpy4DobS+cEWq1CjCl7svvUeFPFIBAHk0MnLd69LmDBUcWPzmhxzwgGXTP2+Nb1lC/QaJLXaxV8Kre+RfIf3GF0lxWy0iQfX/tEw+HEliAXScsoB8OSluJkWR4Z4HJDj54eHLUDZ8MMny9pxQHHKw1+qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777640471; c=relaxed/simple;
	bh=anHGGlP7eUobci4qOJNwgNRVYwi3Jyjr5+UH1j30138=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LcBDp+FCYsVApNTXIuOG9b1i8nWauQNk8Z3AZyy1LyCjVsK0SCNBp3tDlCQsoEwkFUmaRSrPiQ3CxbwfCESAA8mzX5jmp0wWvc+peQXB7u8a2EoZZvDKPWPfd9m/KyicTyvc4TGXgoOiLxgFtavUt7urOiuiRqTiwZHIGW+31+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WakF7gha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFB0C2BCB4;
	Fri,  1 May 2026 13:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777640470;
	bh=anHGGlP7eUobci4qOJNwgNRVYwi3Jyjr5+UH1j30138=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WakF7gha4S92pyCJb0f2WGU9T08DKi5BS9vG6CjgEqz8zJdrDX6IhemtqYYH1SbTm
	 BvwHtCyKKaH+6xJDmkqQB7RYt+d4xqcEJNPvZahvKmGcRAS7fBi/5RbY+tCYVJzdUl
	 9EF2torHoRz7xjqo8DqUt3WoxCOntgjfBdO7xL00fe6cGjjTTfRRIVu7o3JMob7206
	 8NO8bhdjbcirxd9okt68OD6bhGEd0HwtUPfE4j40sW8TXQKRIRTPsTXFxVBcvYIl0w
	 RkaLDQh/+8UbjXqA9BOTzULreQzy3WFGzt1ZhMy3qG7ojRgjM6kCEgQKswcMJuNtzy
	 LJ9J+4MlT7tTA==
From: Simon Horman <horms@kernel.org>
To: lee@kernel.org
Cc: 'Simon Horman' <horms@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@google.com,
	mingo@kernel.org,
	kees@kernel.org,
	qjx1298677004@gmail.com,
	sameo@linux.intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nfc: llcp: Fix use-after-free in llcp_sock_release()
Date: Fri,  1 May 2026 13:58:28 +0100
Message-ID: <20260501125826.102679-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429134115.3558604-1-lee@kernel.org>
References: <20260429134115.3558604-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 274DF4AC878
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,linux.intel.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-283177-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
nfc: llcp: Fix use-after-free in llcp_sock_release()

This commit addresses a use-after-free issue in llcp_sock_release(). It
attempts to fix the problem by checking if the socket is in the connecting
state, and if so, unlinks it from the connecting_sockets list instead of the
default sockets list.

> diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
> index f1be1e84f665..feab29fc62f4 100644
> --- a/net/nfc/llcp_sock.c
> +++ b/net/nfc/llcp_sock.c
[ ... ]
> @@ -633,6 +633,8 @@ static int llcp_sock_release(struct socket *sock)
>  
>  	if (sock->type == SOCK_RAW)
>  		nfc_llcp_sock_unlink(&local->raw_sockets, sk);
> +	else if (sk->sk_state == LLCP_CONNECTING)
> +		nfc_llcp_sock_unlink(&local->connecting_sockets, sk);

Does this cover the case where a remote peer rejects a non-blocking
connection with a DM frame?

If a non-blocking connection is initiated, the socket is placed on
local->connecting_sockets with the state LLCP_CONNECTING. If the remote
peer then rejects the connection via a Disconnect Mode (DM) frame,
nfc_llcp_recv_dm() sets sk->sk_state = LLCP_CLOSED but leaves the socket
in the connecting_sockets list.

When llcp_sock_release() later checks the state, it will be LLCP_CLOSED,
causing the new LLCP_CONNECTING check to fail. The code will then fall
through to the else branch:

>  	else
>  		nfc_llcp_sock_unlink(&local->sockets, sk);

Could this corrupt the list? The nfc_llcp_sock_unlink() call for
local->sockets acquires local->sockets.lock and executes sk_del_node_init().
Since the socket is physically still on the local->connecting_sockets hlist,
this would mutate the connecting_sockets list pointers concurrently without
holding the correct local->connecting_sockets.lock.

Simon says: while I think the problem above warrants looking into in
            the context of this patch, I think the problem below pre-dates
	    this patch and does not need to block progress of it.

Is there also a race condition here with nfc_llcp_recv_cc()?

In nfc_llcp_recv_cc(), a connecting socket is unlinked from
connecting_sockets and linked to sockets without acquiring lock_sock(sk).

If llcp_sock_release() executes concurrently (since it holds lock_sock(sk)
while recv_cc does not), could it fully unlink the socket and drop its
references while nfc_llcp_recv_cc() resumes, blindly linking the now
released socket into local->sockets?

This would leave a dangling pointer in the local->sockets list. I noticed
this specific race appears to be addressed later in the series by commit
e4b0d26ffad8cf0db2a59991b8b7098890b74187 ("nfc: llcp: Fix use-after-free
race in nfc_llcp_recv_cc()").

