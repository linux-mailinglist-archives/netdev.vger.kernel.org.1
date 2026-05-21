Return-Path: <netdev+bounces-290203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAn2Db1rDmob+gUAu9opvQ
	(envelope-from <netdev+bounces-290203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:19:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB4F59DFF1
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B7003013B9A
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653933644D4;
	Thu, 21 May 2026 02:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVnty3VD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D3F262A6
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 02:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329976; cv=none; b=ZHqiCSiRCwja5P+Fw/kdh1B/iWohvHHt5pbFfa7qaDc9vCCf+lDXPWL4fcOKuFpR8GkLfceiSJT3zahbwceYjIZq26F5CDTvO+YgW6ZTgGuWkknTGLw9EKuRIPAnwlnPIYvyJbcR0utcNiR89vFOWFncBG/53wUlnpaQmrkAPlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329976; c=relaxed/simple;
	bh=MJJWJjFQO1tvTUXM49tXnOL6TTRE3K5kXfe94A9tbio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxW6uFcjQITGEUBPzhr03mgT5Z8lG2XNaBeGgZQwm0fqKYJOt+mNEPFFpoj4qlfSE1R6cJPvuXmWPs2XqGdKAZ00vErL/+uSGsF8NQL/vJGbG5Ta2Rawc3pKmHDklFi0U9nGIVt5qPsJfWoRql2RJe50Lo2Q1Q3yTCr/iFl5ltg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVnty3VD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99ABB1F000E9;
	Thu, 21 May 2026 02:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779329963;
	bh=IZMsp9VVUkxohN2N1/noF25ZmTTG1KRgWvp5nTOpuck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TVnty3VD/Z15AutxH3Xh9UQMTmyLpCoHBqPfLNm/9Y1ThEioJkyX/K/xFlsbDeHIx
	 EERIbWhbaUmznX9O/7otr2O8p8Hf0VovwJx2W8rovMIkD4LsfdVf/94oDm/7WnGO3U
	 j+9Uc0fuC1kIYf7J0ijABy6ZmI/5XujeBGjbeg6IJkmgcN6RHumvfxuTMeW3D4OjJD
	 U1lSWiupo09QfMSakkgt7I0pJwZSug7XhQIQwyDJlp1QexF9yi4JQqtFr99PzskOL6
	 i6XDFdyjcQ0VcFK10L2oGcYg0S7pIdc4udW2m2WTd+odpXtvwXjCSKx8I2uCNNTBtz
	 dhK3isVjL+ZmA==
From: Jakub Kicinski <kuba@kernel.org>
To: dhowells@redhat.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	michael.bommarito@gmail.com,
	marc.dionne@auristor.com,
	jaltman@auristor.com,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-afs@lists.infradead.org,
	stable@kernel.org
Subject: Re: [PATCH net] rxrpc: Fix the ACK parser to extract the SACK table for parsing
Date: Wed, 20 May 2026 19:19:11 -0700
Message-ID: <20260521021910.687776-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <488970.1779144259@warthog.procyon.org.uk>
References: <488970.1779144259@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,auristor.com,google.com,davemloft.net,redhat.com,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-290203-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BFB4F59DFF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
rxrpc: Fix the ACK parser to extract the SACK table for parsing

This commit fixes modification of the received skbuff and incorrect access
of the buffer in fragmented UDP packets during SACK table parsing. It copies
out the contents of the SACK table into a flat stack buffer instead of
relying on skb_condense().

Link: https://lore.kernel.org/r/20260513180907.2061972-1-michael.bommarito@gmail.com

> diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
> index 24aceb183c2c3..0c15ebf19eae9 100644
> --- a/net/rxrpc/input.c
> +++ b/net/rxrpc/input.c
> @@ -963,21 +963,34 @@ static void rxrpc_input_soft_acks(struct rxrpc_call *call,
>  	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
>  	struct rxrpc_txqueue *tq = call->tx_queue;
>  	unsigned long extracted = ~0UL;
> -	unsigned int nr = 0;
> +	unsigned int nr = 0, nsack;
>  	rxrpc_seq_t seq = call->acks_hard_ack + 1;
>  	rxrpc_seq_t lowest_nak = seq + sp->ack.nr_acks;
> -	u8 *acks = skb->data + sizeof(struct rxrpc_wire_header) + sizeof(struct rxrpc_ackpacket);
> +	u8 sack[256] __aligned(sizeof(unsigned long));
> +	u8 *acks = sack;

[ ... ]

>  	for (unsigned int i = 0; i < sp->ack.nr_acks; i++) {
>  		/* Decant ACKs until we hit a txqueue boundary. */
>  		shiftr_adv_rotr(acks, extracted);
>  		if (i == 256) {
> -			acks -= i;
> +			acks = sack;
>  			i = 0;
>  		}

Can this lead to an out-of-bounds access and an infinite loop if
sp->ack.nr_acks is greater than 256?

If a received packet has sp->ack.nr_acks > 256, on the 257th iteration
(where i == 256), the shiftr_adv_rotr(acks, extracted) macro will execute
before the wrap-around check resets the acks pointer.

Since the acks pointer has been incremented 256 times by previous iterations,
wouldn't it point to sack + 256 at this point, causing an out-of-bounds read
and write on the sack[] array?

Furthermore, resetting i to 0 inside the loop means the loop's i++
operation will set it to 1 for the next iteration. Because the counter is
reset without breaking out of the loop, will this ever terminate if
sp->ack.nr_acks > 256, or will it cycle infinitely and eventually cause a NULL
pointer dereference when tq->next runs out of transmit queues?
-- 
pw-bot: cr

