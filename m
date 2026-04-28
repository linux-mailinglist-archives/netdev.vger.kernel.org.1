Return-Path: <netdev+bounces-281570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPdRHVAF8GlmNQEAu9opvQ
	(envelope-from <netdev+bounces-281570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:54:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA94947C43C
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C4D730210FA
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7243527B35F;
	Tue, 28 Apr 2026 00:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pas6MoeF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F24218050;
	Tue, 28 Apr 2026 00:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777337677; cv=none; b=XrKHq+ac1nNMVwV7GPSD5H5EqFfhI+jVBT9e/AoPmHMXvILjvPICRTvThBEvFuFVMZI8zSGkfBOK1za/VRuB3mcH5uJUnt6mIO2LWk8kw4TzjJOiWUrzTlRfYC1uuLgKD1mm3u0Xpd8WGXqYNxKYEKW2yyfH7dEanaSndtmpF8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777337677; c=relaxed/simple;
	bh=X75MVNvjU8CUB5hX8gQqxDnohTIIiU5w7KfPBsoiy/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Md8t9kHkVBZJyB2Vz8tVDYBqfuHWr+0xbRA5LNp4kCiLZhXRalQX+8t9DZb+NEta9SfBBidA+K1pP0j/HbLsHpVhEMo1T+cOOSDeir6oFszt+2F7X9HWXwribySLqRNGEZ8H+oMhoGaCtqubSrI+Hsn2WAZ8r563ymKQ4Rvba00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pas6MoeF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853ADC19425;
	Tue, 28 Apr 2026 00:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777337677;
	bh=X75MVNvjU8CUB5hX8gQqxDnohTIIiU5w7KfPBsoiy/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pas6MoeFDkAmdKwzRfA20vvWP6ha0UmnhOKaCrXYF2Kro2fzWBqnimvDQ8gZN+9j7
	 rsp0GtL/6WoEz6IlRn1t5mp57PX2NArtViHCNXXi24MEkjWBorsSe+ZtD/2+96SjA/
	 H8MB17kX8lQWKl5w5nw9w8DMRz/l7WLCWtOvnHOGsrET/s6dnlftzJ20yZqAqbOemA
	 7hNsSSZ6opxAc/6m3IdAT96l4Bbav14npLvYVKrnpKvf25IMnrbm19e3Puh5i0K6Ww
	 t1FjwOyD01cR64Lx/SEyrItiGM1HM1cTtmVSFe7JN4GfrZ8r4sw+FvBZWKjv5R24Aw
	 p1x9srkK1cqgA==
From: Jakub Kicinski <kuba@kernel.org>
To: kartikey406@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	syzbot+706f5eb79044e686c794@syzkaller.appspotmail.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	courmisch@gmail.com
Subject: Re: [PATCH] net: phonet: fix BUG_ON() in pn_socket_autobind()
Date: Mon, 27 Apr 2026 17:54:33 -0700
Message-ID: <20260428005433.716529-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422021533.16987-1-kartikey406@gmail.com>
References: <20260422021533.16987-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CA94947C43C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,vger.kernel.org,syzkaller.appspotmail.com,google.com,davemloft.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-281570-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,706f5eb79044e686c794];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: phonet: fix BUG_ON() in pn_socket_autobind()

This commit fixes a kernel crash in pn_socket_autobind() by checking
the socket's bound state directly before calling pn_socket_bind(),
eliminating ambiguous -EINVAL interpretation.

Closes: https://syzkaller.appspot.com/bug?extid=706f5eb79044e686c794

> pn_socket_autobind() calls pn_socket_bind() and treats
> -EINVAL as a signal that the socket was already bound,
> then uses BUG_ON() to verify it:
>
>     if (err != -EINVAL)
>         return err;
>     BUG_ON(!pn_port(pn_sk(sock->sk)->sobject));
>
> However, pn_socket_bind() returns -EINVAL in multiple
> cases:
>
>   1. address length too short

The commit message lists "address length too short" as a cause of the
BUG_ON crash, but is this accurate?

Looking at pn_socket_autobind(), it always passes
len=sizeof(struct sockaddr_pn) to pn_socket_bind():

    err = pn_socket_bind(sock, (struct sockaddr_unsized *)&sa,
                         sizeof(struct sockaddr_pn));

While pn_socket_bind() does have this check:

    if (len < sizeof(struct sockaddr_pn))
        return -EINVAL;

This case cannot be triggered through pn_socket_autobind() since it
always passes the correct length. The BUG_ON is only reachable through
pn_socket_autobind(), so listing this as a cause seems misleading.

Should the commit message be updated to remove case 1, or clarify that
it's describing pn_socket_bind() in general rather than paths that can
trigger the BUG_ON?

>   2. socket not in TCP_CLOSE state

Can case 2 (socket not in TCP_CLOSE state) actually trigger the BUG_ON
crash with sobject still zero?

The combined check in pn_socket_bind() is:

    if (sk->sk_state != TCP_CLOSE || pn_port(pn->sobject)) {
        err = -EINVAL;
        goto out;
    }

For the BUG_ON to fire, we need sk_state != TCP_CLOSE while sobject
remains zero (unbound). Looking at phonet state transitions:

- pn_socket_connect() binds the socket before changing state
- pn_socket_listen() binds the socket before changing state
- pep_sock_accept() creates sockets with state=TCP_SYN_RECV but also
  sets sobject
- pep_ioctl(SIOCPNENABLEPIPE) checks sobject before changing state

Is there a code path that changes sk_state to non-TCP_CLOSE without
first binding the socket? The syzbot crash is real, but the mechanism
described couldn't be verified. Could this involve a race condition or
a different code path?

>   3. socket already bound  <- only intended case
>
> When -EINVAL comes from cases 1 or 2, sobject is still
> zero (never assigned), causing BUG_ON to fire and crash
> the kernel.

Given the issues with cases 1 and 2 above, is the explanation of the
crash mechanism accurate? Case 1 cannot happen from pn_socket_autobind(),
and case 2's ability to leave sobject at zero while triggering -EINVAL
could not be verified.

The syzbot crash is confirmed (RIP at pn_socket_autobind
net/phonet/socket.c:213 via pn_socket_sendmsg), but could the commit
message more accurately describe how the crash actually occurs?

> diff --git a/net/phonet/socket.c b/net/phonet/socket.c
> index c4af26357144..5a55e7d14e85 100644
> --- a/net/phonet/socket.c
> +++ b/net/phonet/socket.c
> @@ -204,14 +204,14 @@ static int pn_socket_autobind(struct socket *sock)
>  	struct sockaddr_pn sa;
>  	int err;
>
> +	if (pn_port(pn_sk(sock->sk)->sobject))
> +		return 0; /* socket was already bound */
> +
>  	memset(&sa, 0, sizeof(sa));
>  	sa.spn_family = AF_PHONET;
>  	err = pn_socket_bind(sock, (struct sockaddr_unsized *)&sa,
>  			     sizeof(struct sockaddr_pn));
> -	if (err != -EINVAL)
> -		return err;
> -	BUG_ON(!pn_port(pn_sk(sock->sk)->sobject));
> -	return 0; /* socket was already bound */
> +	return err;
>  }

The fix itself is correct and removes the dangerous BUG_ON(). However,
the pn_port(sobject) check is performed without holding any lock. Could
a concurrent pn_socket_bind() race with this check? This is likely
benign since pn_socket_bind() re-checks under lock_sock(), but is this
the intended behavior?
-- 
pw-bot: cr

