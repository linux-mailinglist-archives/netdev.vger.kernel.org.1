Return-Path: <netdev+bounces-280249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Nl6DUXh52nMCAIAu9opvQ
	(envelope-from <netdev+bounces-280249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:42:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCC843F86C
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E789304750E
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 20:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA9C3446C7;
	Tue, 21 Apr 2026 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+3D4qsL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4818031E85A;
	Tue, 21 Apr 2026 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803936; cv=none; b=NpW65lIBx1/A5E6YHtNKJfmqxZ85+eqeyFu4UomYHxMGh6A4kIQDkLNxpdK2J1j0HmQLLghwNa+qBv7jJUrVUBaoUV1TKBJ7ByVjv+Gn1DemNX/q6t2vSjABFnw/SMohS6NYiN7UgCgmN/rrmzUiHLDlLf8pQgPPzaQI7ku2sFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803936; c=relaxed/simple;
	bh=YsvazPSctTP3K4mfC0xavdja4uCMN9VA37WX18FInmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pxj8XFNtSlAcrAOPLSZcnlYEaW50TCNtAqVKl4Bs1K38Y5rqa3w/qKjjYWDvbFptLd6OH4Hv52pPCqSZM01PUv8A3RPQRj34l6b2Mdkal9+V3o+OD6f4UvrkrNRm4fJe7YM87VQGqnHR/glvKy+s12NK/uQFkvvJ53PvYorP2pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+3D4qsL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9584EC2BCB0;
	Tue, 21 Apr 2026 20:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776803935;
	bh=YsvazPSctTP3K4mfC0xavdja4uCMN9VA37WX18FInmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u+3D4qsLmw1F5kpF0AOQY/J3AjLbEfRfyjJX0Gvac9cG1uKpfTgjsQGv1aqUh8/mL
	 6AnYwcoEfw606bChSJgE9F9hteYkL4/T6J5qwfAFubwD4HpmWMLPCj4tuKlRIwqztE
	 rAJJJVBxiEvzEU09beYrA1xAdzNxVpjywXwiK3+ukTsDZ07VsHOZpZwwCTJam+x8O1
	 EduQwvVs1Z8DRfIQCbxb/OFv861FCKJuH69tqplJlYXKs4WJf+dndZVhrXfQrcfnJW
	 4+0jH/SREb5g7rK8+v1j4OipRfX3R9CaVtq4Hwf0U6lnbnVP2TvQz/Fz367rRQjVq3
	 WPSrhJdyRKflg==
From: Simon Horman <horms@kernel.org>
To: dhowells@redhat.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	marc.dionne@auristor.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jaltman@auristor.com,
	stable@kernel.org
Subject: Re: [PATCH net 2/4] rxrpc: Fix conn-level packet handling to unshare RESPONSE packets
Date: Tue, 21 Apr 2026 21:38:33 +0100
Message-ID: <20260421203833.745240-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420145900.1223732-3-dhowells@redhat.com>
References: <20260420145900.1223732-3-dhowells@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280249-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 8BCC843F86C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
Subject: rxrpc: Fix conn-level packet handling to unshare RESPONSE packets

This commit modifies the RxRPC connection-level packet processor to unshare
RESPONSE packets before decryption. It introduces a new rxrpc_unshare_skb()
helper to safely unshare skbuffs passed via a double pointer and replaces
direct calls to skb_unshare().

Closes: https://sashiko.dev/#/patchset/20260408121252.2249051-1-dhowells%40redhat.com

> diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
> index 9a41ec708aeb9..3d56a5d233697 100644
> --- a/net/rxrpc/conn_event.c
> +++ b/net/rxrpc/conn_event.c

[ ... ]

> @@ -371,7 +379,7 @@ static void rxrpc_do_process_connection(struct rxrpc_connection *conn)
>  	 * connection that each one has when we've finished with it */
>  	while ((skb = skb_dequeue(&conn->rx_queue))) {
>  		rxrpc_see_skb(skb, rxrpc_skb_see_conn_work);
> -		ret = rxrpc_process_event(conn, skb);
> +		ret = rxrpc_process_event(conn, &skb);
>  		switch (ret) {
>  		case -ENOMEM:
>  		case -EAGAIN:

Looking at the code immediately following this hunk in
rxrpc_do_process_connection():

		switch (ret) {
		case -ENOMEM:
		case -EAGAIN:
			skb_queue_head(&conn->rx_queue, skb);
			rxrpc_queue_conn(conn, rxrpc_conn_queue_retry_work);
			break;

If rxrpc_process_event() fails with -ENOMEM because rxrpc_unshare_skb()
failed, rxrpc_unshare_skb() will have set *_skb = NULL.

Does this mean skb is NULL when we reach skb_queue_head()?

Since skb_queue_head() dereferences the skb parameter, this appears to
result in a NULL pointer dereference. Furthermore, since skb_unshare()
frees the original skb on allocation failure, the packet is already gone
and requeuing it wouldn't be possible anyway.

> diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
> index 6979569319252..0592ce644fc3d 100644
> --- a/net/rxrpc/io_thread.c
> +++ b/net/rxrpc/io_thread.c

[ ... ]

> @@ -249,19 +249,10 @@ static bool rxrpc_input_packet(struct rxrpc_local *local, struct sk_buff **_skb)
>  		 * decryption.
>  		 */
>  		if (sp->hdr.securityIndex != 0) {
> -			skb = skb_unshare(skb, GFP_ATOMIC);
> -			if (!skb) {
> -				rxrpc_eaten_skb(*_skb, rxrpc_skb_eaten_by_unshare_nomem);
> -				*_skb = NULL;
> +			skb = rxrpc_unshare_skb(_skb, GFP_ATOMIC);
> +			if (!skb)
>  				return just_discard;
> -			}

This isn't a new bug introduced by this patch, but since we are modifying
the unshare path here: when rxrpc_unshare_skb() fails, it sets *_skb = NULL
and returns just_discard.

Back in rxrpc_io_thread(), the packet is processed like this:

net/rxrpc/io_thread.c:rxrpc_io_thread() {
...
		while ((skb = __skb_dequeue(&rx_queue))) {
			struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
			switch (skb->mark) {
			case RXRPC_SKB_MARK_PACKET:
				skb->priority = 0;
				if (!rxrpc_input_packet(local, &skb))
					rxrpc_reject_packet(local, skb);
				trace_rxrpc_rx_done(skb->mark, skb->priority);
...

If rxrpc_input_packet() sets skb to NULL and returns false (just_discard),
does this cause a NULL pointer dereference when trace_rxrpc_rx_done() tries
to access skb->mark?

