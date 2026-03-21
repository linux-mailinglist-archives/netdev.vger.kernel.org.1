Return-Path: <netdev+bounces-270146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ekgdLbf4vWkZEgMAu9opvQ
	(envelope-from <netdev+bounces-270146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:47:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B56A2E2D44
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 805AA30058E5
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42AE1A681E;
	Sat, 21 Mar 2026 01:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLvc+3Rd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E3F1684A4;
	Sat, 21 Mar 2026 01:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774057652; cv=none; b=TKPlDMLP1B23dbNyJ02frwRIUtxl0me3MidpgDi6NgWRjr48mxGguL1cOkk7Mct4vjWBjD5RYpai7cTdBq5LZPdNiL8IJ1SX9UGZBhODgKscsVlUODQRLJUzhXbiokaQ0vk8MTy9JzIMDpA+1lAw414zqxMJTJHdWi0M+5i1lSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774057652; c=relaxed/simple;
	bh=OXHU1TAckiv5f6PHmo0z+bLguWAVdik7LFHVuCVfWcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEtbRVtNAzMPXD3f6vOifV89hcVmbEul8fdaOebZBQQzElAlNZgrw2ok1gSyqbQHK2gGznpnz8mkRX8Ig68bnZUAzbDEkLKOwUT2qE0uESd6ZeURsZtXtzzskmNolynYbvZYOgoQ93k1jZcti4/L0cJ315//RFzMmWeSFZJsRAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLvc+3Rd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D28C4CEF7;
	Sat, 21 Mar 2026 01:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774057652;
	bh=OXHU1TAckiv5f6PHmo0z+bLguWAVdik7LFHVuCVfWcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lLvc+3Rd2wU6fwFEF5Bb8pwt7ci4uic84IYNxWOWPQRBdGXuMtDYkXF/HPtNPN2Ga
	 1YBi9r0BGP07AR7iKviBnHgl8nnyHGXNoKg9Oy0dU5rr5bcFkyiQ2dPnJup5wvdTwF
	 ufSKmhnNvPadjKr6wsQtVojbFGQdwKR77AGSskWX6AnsX5fTj0Yr3P42/GhJkAQAep
	 P8SOFO95ZnR0CGZP/jFby2kgNhHB1fmmMGuYi4WSv2DyWwKki9krk9eubJi2KGamlK
	 IqMbJhtEBRDY5Gds0NLHlEsaHt2VQtHhJ131dpZbnpQwtBcMhZwBkeIFu9J/mzPLPR
	 FjvNcGATQ581Q==
From: Jakub Kicinski <kuba@kernel.org>
To: dhowells@redhat.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-afs@lists.infradead.org,
	horms@kernel.org,
	alok.a.tiwari@oracle.com,
	davem@davemloft.net,
	marc.dionne@auristor.com,
	linux-kernel@vger.kernel.org,
	security@1seal.org,
	stable@kernel.org,
	pabeni@redhat.com,
	anderson@allelesecurity.com,
	jaltman@auristor.com,
	edumazet@google.com
Subject: Re: [PATCH net 2/5] rxrpc: Fix use of wrong skb when comparing queued RESP challenge serial
Date: Fri, 20 Mar 2026 18:45:44 -0700
Message-ID: <20260321014543.3892478-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319150150.4189381-3-dhowells@redhat.com>
References: <20260319150150.4189381-3-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270146-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B56A2E2D44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David!

The review under --- is AI generated. It looks legit to me.

The Google reviewer also points out preexiting problems that may be worth looking at:
https://sashiko.dev/#/patchset/20260319150150.4189381-1-dhowells%40redhat.com

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
rxrpc: Fix use of wrong skb when comparing queued RESP challenge serial

In rxrpc_post_response(), the code should be comparing the challenge
serial number from the cached response before deciding to switch to a
newer response, but looks at the newer packet private data instead,
rendering the comparison always false.

Fix this by switching to look at the older packet.

> diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
> index 98ad9b51ca2c..2c27f47951f9 100644
> --- a/net/rxrpc/conn_event.c
> +++ b/net/rxrpc/conn_event.c
> @@ -557,7 +557,7 @@ void rxrpc_post_response(struct rxrpc_connection *conn, struct sk_buff *skb)
>  	spin_lock_irq(&local->lock);
>  	old = conn->tx_response;
>  	if (old) {
> -		struct rxrpc_skb_priv *osp = rxrpc_skb(skb);
> +		struct rxrpc_skb_priv *osp = rxrpc_skb(old);
>
>  		/* Always go with the response to the most recent challenge. */
>  		if (after(sp->resp.challenge_serial, osp->resp.challenge_serial))
>  			conn->tx_response = old;
                        ^^^^
Does this have the logic inverted? The comment says "Always go with
the response to the most recent challenge" and the condition checks
if the new response has a more recent serial number:

    if (after(sp->resp.challenge_serial, osp->resp.challenge_serial))

When this is TRUE (new serial is after old serial), the code keeps
the OLD response by setting conn->tx_response = old. Shouldn't it
keep the NEW response instead? Something like:

    if (after(sp->resp.challenge_serial, osp->resp.challenge_serial))
        conn->tx_response = skb;

This would cause the connection to respond to outdated challenges
rather than the most recent one.

>  		else
>  			old = skb;

When a new response is rejected here (because the old response has a
more recent challenge serial), what happens to the rejected packet?
The function assigns it to the local variable 'old' but never frees
it.

Looking at the callers:
- rxkad_respond_to_challenge() in rxkad.c sets response = NULL after
  calling this function
- rxgk_construct_response() in rxgk.c does the same

This suggests ownership transfers to rxrpc_post_response(). Should
the rejected packet be freed with rxrpc_free_skb() before returning?

>  	} else {
>  		conn->tx_response = skb;
>  	}
>  	spin_unlock_irq(&local->lock);
>  	rxrpc_poke_conn(conn, rxrpc_conn_get_poke_response);
>  }
-- 
pw-bot: cr

