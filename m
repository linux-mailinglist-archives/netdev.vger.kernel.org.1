Return-Path: <netdev+bounces-292837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB5PN02nGGp+lwgAu9opvQ
	(envelope-from <netdev+bounces-292837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 22:36:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDA55F916A
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 22:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C11D31DB7D4
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 20:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AA22F8E83;
	Thu, 28 May 2026 20:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovR6ITyw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884C32D9787;
	Thu, 28 May 2026 20:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999668; cv=none; b=Pg864k4JHzPnI2ajgxQh3oKudo7FBWY8nO9X1EHATm2oLOycn4QGy/+Q47ISoausYLFMM+Cpw5UxKdflTcbGwJcPPBvt7e7HKA3infrekzxZuAiAlEEsU4wqPGzmGjF3I2V8U3Kt4WG+zKvOwEy3lBYG/vnoyHlIHII9uDNCa6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999668; c=relaxed/simple;
	bh=Jwgu1uWohqE8+JEjjhyrCKMGbHKCzl40Xp0G/F4utNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSa5c5kMZdM2UxHrXxC8aL11cJrtc30mszCCUzCYLAbbs3kJdaj16jNEFxvTn3tn6+f++TMdhg25ZwzkAURhJ87oxqa+R3l0FIoRgM4c7boOGHy92pMOl+5/Ifw/ijjnjRCe5RvSbz03GndQURPa8h3griALvAph7burV7YIgJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovR6ITyw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198441F000E9;
	Thu, 28 May 2026 20:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779999667;
	bh=5eONnNKTCQ7J+VL/0T2D8f46O9JGX3erMF4ccylrlRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ovR6ITyw4vDUWE3RAN7s5rmwZZT9QGWXAxvYxNiYGVjOQH72Ng1iLDTcMIioCcKh/
	 7FJhVtQAwPkKYjj/nYaNEQU+Uhzy+GE/GQxqNYp8y9cEGrteoGGf89XT5t1vlK5HgE
	 AwgZSAhrWKQRAs95eiVfxtgwA5PgbWndNO3wra/2RMpj87u1Us3OMP/ZT0DRBDvN2k
	 s3dkZmsi2bvL17OAsz5ErZMhM6+IeAAqjvKDfqnTHH7Tyx5wXUSvYO+sFn8cenhIWo
	 yYj/ZaDR/XKX1lL6+9RM4SwfsANDNeXi8el+udy47j3jS2kJYQefQ+r6xxz+5XkoMe
	 pY77GVYPSqTNg==
From: Simon Horman <horms@kernel.org>
To: kipreyyy@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	david+nfc@ixit.cz,
	kuba@kernel.org,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH nfc] nfc: nci: fix double completion race in nci_data_exchange_complete
Date: Thu, 28 May 2026 21:16:26 +0100
Message-ID: <20260528201624.2730799-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526103121.47957-1-kipreyyy@gmail.com>
References: <20260526103121.47957-1-kipreyyy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-292837-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,nfc];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3BDA55F916A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
Subject: nfc: nci: fix double completion race in nci_data_exchange_complete

This patch attempts to resolve a double completion race condition by
replacing clear_bit() with test_and_clear_bit() on the NCI_DATA_EXCHANGE
flag. This is intended to prevent a socket refcount underflow when
nci_close_device() and nci_rx_work() execute concurrently.

> diff --git a/net/nfc/nci/data.c b/net/nfc/nci/data.c
> index 5f98c73db5afd..4253edea5c8db 100644
> --- a/net/nfc/nci/data.c
> +++ b/net/nfc/nci/data.c
> @@ -46,11 +46,11 @@ void nci_data_exchange_complete(struct nci_dev *ndev, struct sk_buff *skb,

1.
Simon says: Although the issue flagged below is pre-existing, it appears
            to be exacerbated by this patch and thus I believe it
	    needs to be considered in that context.

[Severity: High]
This is a pre-existing issue, but does an NTF packet with an invalid
connection ID improperly clear the transceive state?

Looking earlier in nci_data_exchange_complete():

    conn_info = nci_get_conn_info_by_conn_id(ndev, conn_id);
    if (!conn_info) {
        kfree_skb(skb);
        clear_bit(NCI_DATA_EXCHANGE, &ndev->flags);
        return;
    }

If a misbehaving or malicious NFC hardware sends an error NTF packet with an
invalid connection ID while a valid RF transceive operation is active, it
would execute clear_bit(NCI_DATA_EXCHANGE, &ndev->flags). Would this abort
the ongoing transceive state machine and drop the actual response when it
arrives?

2.
Simon says: Conversely, the issue flagged below seems to be orthogonal
            to this patch. And I think it can be treated in the context
	    of possible follow-up.

[Severity: Critical]
This isn't a bug introduced by this patch, but is there a use-after-free
race condition in nci_transceive()?

In nci_transceive(), the NCI_DATA_EXCHANGE flag is set using
test_and_set_bit() before the data_exchange_cb and data_exchange_cb_context
pointers are updated on the conn_info structure.

Since incoming packets and notifications are processed concurrently by
nci_rx_work, could an exceptionally fast response or a concurrent interface
error notification trigger nci_data_exchange_complete() immediately after
the bit is set but before the callback pointers are updated?

This could cause the lockless reader to fetch the stale callback and context
pointers from a previous transceive socket and execute them.

>  	timer_delete_sync(&ndev->data_timer);
>  	clear_bit(NCI_DATA_EXCHANGE_TO, &ndev->flags);
>  
> -	/* Mark the exchange as done before calling the callback.
> -	 * The callback (e.g. rawsock_data_exchange_complete) may
> -	 * want to immediately queue another data exchange.
> -	 */
> -	clear_bit(NCI_DATA_EXCHANGE, &ndev->flags);
> +	/* Claim completion atomically -- both close and rx_work may race here */
> +	if (!test_and_clear_bit(NCI_DATA_EXCHANGE, &ndev->flags)) {
> +		kfree_skb(skb);
> +		return;
> +	}

3.
Simon says: Like issue 1. I believe the issue below should be considered
            in the context of this patch.

[Severity: High]
Will this change cause valid HCI and loopback packets to be dropped?

The NCI_DATA_EXCHANGE bit is only set during RF transceive operations in
nci_transceive(). Subsystems like HCI (via nci_hci_send_cmd()) and loopback
send data without setting this global flag.

If valid HCI or loopback data packets arrive, won't they fail this bit
check, causing the SKB to be dropped and skipping callbacks like
nci_hci_data_received_cb?

Additionally, if an asynchronous packet arrives concurrently while a valid
RF transceive is active, could it falsely consume the NCI_DATA_EXCHANGE bit?
When the actual RF response arrives, it would then fail the check, drop the
packet, and permanently leak the socket's reference count.

>  
>  	if (cb) {
>  		/* forward skb to nfc core */
>  		cb(cb_context, skb, err);

4.
Simon says: And like issue 3. I believe this is orthogonal to this patch
            and can be considered in the context of possible follow-up.

[Severity: High]
This is a pre-existing issue, but does this code leak the SKB when an
error status is returned?

When nci_add_rx_data_frag() processes an incoming fragment with a non-zero
status byte, it passes both the valid skb and the err code to
nci_data_exchange_complete(), which forwards them to the cb here.

Looking at core callbacks like rawsock_data_exchange_complete():

net/nfc/rawsock.c:rawsock_data_exchange_complete() {
    ...
    if (err)
        goto error;
    ...
error:
    sock_put(sk);
}

The error label bypasses the error_skb label where kfree_skb(skb) is called.
Does this result in an unconditional memory leak of the SKB whenever the
hardware or external target responds with an error status?

>  	} else if (skb) {
>  		pr_err("no rx callback, dropping rx data...\n");
[ ... ]

