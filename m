Return-Path: <netdev+bounces-286884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAoEGPBzAmqAtAEAu9opvQ
	(envelope-from <netdev+bounces-286884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 02:27:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8997517DCD
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 02:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A64D30237F0
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 00:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE96E1FBEBC;
	Tue, 12 May 2026 00:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sH7Hh4nl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1DF1E5207;
	Tue, 12 May 2026 00:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778545645; cv=none; b=czdQY/bmIp5RVAGs3h1IpHZByDIfnEotY/0ZOp83Bv5bXC5yBEWJFHm+7tre4cDm9uxw4PDUvbmVeBbCvd6Y3YpxHgb0zBTHkEAj0Q3Pa+wJeClFc5hhM97B2tottWMaRsdhwgkVRX4uU7DTw88G4bUEBRtJ14hDVx2wF3Fy5Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778545645; c=relaxed/simple;
	bh=7B6mqILzOafZ5FNuX6Q8RkR6+qHrviQS9ErqUJNiffw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4nlzZjVPe8iUpRQm4+SQcgd8nzC/0fJeM0n0ESJPY1FVPton4ewwNUjsOb+K2tqiCYGyAKscnQFgFkk/RH24Ysr8M3u3+594WgihA9SAEClYL/SXzF9yJdH2gXwblbLVnhT1xdH0NTh5lCbZve6fPfB/fOjymB1ZYhaQJ54Dwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sH7Hh4nl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9886C2BCB0;
	Tue, 12 May 2026 00:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778545645;
	bh=7B6mqILzOafZ5FNuX6Q8RkR6+qHrviQS9ErqUJNiffw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sH7Hh4nlNQNcBDF2/Lr0GjS9v7+FlgRXHLAUZpe5wuVQXX4yb3WZHTjyZ8qelohsx
	 Plh9lfTKygJbhwTRUFEviUP3chHDprPafvcb9YrjxaNOhLLtYcwyzDoWDznDgdVJYa
	 mkYp04RZ6u1hpGkzgLeO87UETX+f8hWG5kqQ5DbvikOWZ+1z0YIU9Dur/3xg07w2nW
	 NxzPlO9Q11WDUwMkbVuuYR2b6BZ9XcuVI0vlUjs1WqHTYdnpkkyKPZdXps206DoZDz
	 wwmtd+8MxQoSyJnliUj1O7OYkuPeeeGodeeBO0023p5grTkytk32sCOhadWakVeQ+1
	 Rfq09IyR5YZzA==
From: Jakub Kicinski <kuba@kernel.org>
To: ntspring@meta.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] tcp: rehash onto different local ECMP path on retransmit timeout
Date: Mon, 11 May 2026 17:27:19 -0700
Message-ID: <20260512002719.739807-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507171319.1259115-2-ntspring@meta.com>
References: <20260507171319.1259115-2-ntspring@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C8997517DCD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286884-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
tcp: rehash onto different local ECMP path on retransmit timeout

This commit updates ECMP path selection logic to use the socket's txhash
on RTO, PLB, and spurious retransmissions by invalidating the cached dst
and setting fl6->mp_hash for IPv6. It also moves txhash initialization
earlier in tcp_conn_request().

> diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
> index 37534e1168992..fc4b75de6af8e 100644
> --- a/net/ipv6/inet6_connection_sock.c
> +++ b/net/ipv6/inet6_connection_sock.c

[ ... ]

> @@ -70,6 +73,9 @@ struct dst_entry *inet6_csk_route_socket(struct sock *sk,
>  	fl6->saddr = np->saddr;
>  	fl6->flowlabel = np->flow_label;
>  	IP6_ECN_flow_xmit(sk, fl6->flowlabel);
> +
> +	/* >> 1 for 31-bit mp_hash range matching nhc_upper_bound. */
> +	fl6->mp_hash = sk->sk_txhash >> 1;
>  	fl6->flowi6_oif = sk->sk_bound_dev_if;
>  	fl6->flowi6_mark = sk->sk_mark;
>  	fl6->fl6_sport = inet->inet_sport;

Does this leave active IPv6 connections and syncookie-created sockets vulnerable
to spontaneous ECMP path flapping upon natural route invalidation?

The patch updates inet6_sk_rebuild_header() and inet6_csk_route_socket() to
use sk_txhash for ECMP path selection, but it appears to miss two critical
paths:

1. tcp_v6_connect() (active open): fl6.mp_hash is 0 during
   ip6_dst_lookup_flow(). sk_set_txhash(sk) is called only after the route
   is cached.

2. cookie_v6_check() (IPv6 syncookies): fl6.mp_hash is 0 during
   ip6_dst_lookup_flow(), despite treq->txhash having been generated in
   cookie_tcp_reqsk_alloc().

In both cases, the initial dst is selected via the standard 5-tuple hash,
but the socket is assigned a random txhash. If the route is later naturally
invalidated (e.g., via PMTU discovery), the rebuild functions will apply
sk_txhash >> 1. Because this new hash is uncorrelated with the 5-tuple, the
connection could unpredictably flap to a different ECMP path, potentially
breaking connections passing through stateful firewalls/NATs and causing
severe packet reordering.
-- 
pw-bot: cr

