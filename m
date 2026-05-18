Return-Path: <netdev+bounces-288952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPofAQDaCmoA8wQAu9opvQ
	(envelope-from <netdev+bounces-288952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:21:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA635698FD
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DCC3302086B
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 09:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384003E558C;
	Mon, 18 May 2026 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYMbqMjU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB233E1CFF;
	Mon, 18 May 2026 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095664; cv=none; b=V/kkfJZTeA9LYv1Wg0CnPzEXPYbsW4Ry2pzD/DXHujI2K1jFpNP6fRxoYNDJHroYNelk4EHB9pwtfCnWTQ/olH41+zvXzSkK9GUeJP7y3YzfI5PSQhJu9mMTYlZv9gAfIKKr+OapPhQOy1QvNQmau6jgotJlGmQ7Kdhs3ILZ41s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095664; c=relaxed/simple;
	bh=dhY3CKr2XCza+nlc8BVgspVXkSxeR632VvA4y6UIJqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmo0s4uacmf1B4SZxIYCwsxJGEEAFfN8ZtiACZS8pZy0n+c/yUagQMPSxo+iIZ6rXTCXJmqY3DNZhtt3FQ6qb9OBOCBR2d0E73QUpoI+mfhZd/oPaDuh4nnfYEdRhPzDKk5yCK093jziP//5XYbYM/gtkmUYLNIKpzY+Jw2kiVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYMbqMjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB37C2BCB7;
	Mon, 18 May 2026 09:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779095663;
	bh=dhY3CKr2XCza+nlc8BVgspVXkSxeR632VvA4y6UIJqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VYMbqMjUp19nUJcz6fP9igsmEaUvSTuW+yi9MVpeCxp4Ll8x+phM13j8d3TVDIqpQ
	 C3NrUjwcXvuzATxTIiDVIdD9ipuJErP/pn9jH5Z2VwFf2pGf6ABci2qRyrRRsznma0
	 DXNRXhKx2aUT/Ldv401PAa4g9ksOLD4jbwI0Hux9oqtmDAx+waUZn+KwCw+o3jCSlp
	 8+1ZB9I4i4wt7OtnN0vk5Jpc6WCxpFWYpYRCi2nNmI/UGbchaVcIJDQUQ2DoNhz3TT
	 Dte/0iRX4bv9M3hfVEWc1p7D0fxKCRkPgXD9x0GXcdYSZ7HE8cyoj34jdOmVAYqSF3
	 I7YmoFAdoO6VA==
From: Simon Horman <horms@kernel.org>
To: leitao@debian.org
Cc: 'Simon Horman' <horms@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	david+nfc@ixit.cz,
	sameo@linux.intel.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	kernel-team@meta.com
Subject: Re: [PATCH net] nfc: llcp: avoid userspace overflow on invalid optlen
Date: Mon, 18 May 2026 10:11:04 +0100
Message-ID: <20260518091103.427351-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513-fix_llc-v1-1-33c76f931ff6@debian.org>
References: <20260513-fix_llc-v1-1-33c76f931ff6@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6FA635698FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-288952-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,nfc];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
nfc: llcp: avoid userspace overflow on invalid optlen

This commit attempts to fix a userspace buffer overflow in
nfc_llcp_getsockopt() by rejecting calls where the provided optlen is less
than the size of a u32.

> diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
> index f1be1e84f6653..dc74e725ddd05 100644
> --- a/net/nfc/llcp_sock.c
> +++ b/net/nfc/llcp_sock.c
> @@ -319,6 +319,9 @@ static int nfc_llcp_getsockopt(struct socket *sock, int level, int optname,
>  	if (get_user(len, optlen))
>  		return -EFAULT;
>  
> +	if (len < sizeof(u32))
> +		return -EINVAL;

Since len is a signed int and sizeof(u32) is an unsigned size_t, does C
integer promotion cause negative lengths to bypass this check?

If a user provides an optlen of -1, it appears it would be promoted to a
large positive number, making this condition false.

It would then be explicitly cast to u32 in the min_t() call below, allowing
the code to continue and overflow the userspace buffer exactly as this
patch was attempting to prevent.

> +
>  	local = llcp_sock->local;
>  	if (!local)
>  		return -ENODEV;

While looking at this, is there a potential use-after-free regression here
if llcp_sock->local is read outside of the socket lock?

If another thread calls llcp_sock_bind() on the same socket, it might
successfully set llcp_sock->local, but then hit an error path. In that
error path, bind() would drop the reference and set llcp_sock->local
to NULL.

If the getsockopt() thread reads local here, gets the valid pointer, and
then blocks waiting for lock_sock(sk):

getsockopt() thread:
local = llcp_sock->local;
// blocks on lock_sock(sk)

bind() thread:
// hits error path
nfc_llcp_local_put(llcp_sock->local);
llcp_sock->local = NULL;
release_sock(sk);

Will the getsockopt() thread wake up, acquire the lock, and then
dereference the now-freed local pointer in the switch statement below?

