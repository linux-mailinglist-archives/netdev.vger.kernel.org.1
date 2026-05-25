Return-Path: <netdev+bounces-291474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGoOOT28FGpUPwcAu9opvQ
	(envelope-from <netdev+bounces-291474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 23:16:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 563775CED6D
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 23:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CABF300D16D
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3BA2868B4;
	Mon, 25 May 2026 21:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeuj0MLH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1692DAFCB
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 21:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779743774; cv=none; b=eFCvMIzWFhhitMHSap2DNo5Aly8mWAbCJJ7xtEbYcvrRsPmYI4d7ZLxTedRcLZQk55NGAu+TmCuN5wuygP7E09vroWhBMw4geRkvr5+FgBl4U9jB0oP/5lYO29mEXru8hv5VmiohdsRF0CJfRV/xTYMCtvaqoqO4x0cve2aJF4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779743774; c=relaxed/simple;
	bh=eBQnPiySiCO3hsCXvVVtrQyjMIv++nG/mnVHUuvT5t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWbAaA+HIaJiE7TWph/KfTXMttiZfT/jicAoyP4vKU2idt78PIQs9YKnZdVNvnD1QVcn6tNnKNlkLEk+Ahd+qQ5tnuJNgZCoe2Ck2PHpTHZ8+qBo0mlxytepSWkW2/UBDmugdWr4MjZ8J/U4Qb0L/kDi+FQKCsaq45dmDOIaf+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeuj0MLH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18FA1F00A3A;
	Mon, 25 May 2026 21:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779743772;
	bh=QM84L2OS8dssoDRinKwTU8JGRDVW9dk5dJQz60gWMbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eeuj0MLHl6OiPnSbfWLmlO5PiQ79Fukcfu4y/dRhZ9fiPhs+Hyi2Xk2qT8FXe8WPT
	 geErWmz2thnFqg03mXEPLFCF7VFLvLge+jS1o+q/s6ESHqT7Ej3W+8yFOWee9+oAEN
	 gu36n9/c2aNFillxMIlfNEGsAWAtTAaVqIr5GytaeE8HvHSSoarz2oFr/HVXthfUXB
	 Qr2RXR8pD7Z1IDr4W3fbUeLeWSOgkBFCn2AncbBUePSL/fepY5JkNPfcvT2zpnutQd
	 FisM5hVRMUZGAjzsd0GGgNx+MUeKwqXNx4I0z5dbbtIs0tW3DjHikCB3IbpHinf1B7
	 m8V5v+9LUJ5PQ==
From: Jakub Kicinski <kuba@kernel.org>
To: rjethwani@purestorage.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org
Subject: Re: [PATCH v14 7/9] tls: device: add RX KeyUpdate support
Date: Mon, 25 May 2026 14:16:10 -0700
Message-ID: <20260525211610.2508479-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515212715.3151307-8-rjethwani@purestorage.com>
References: <20260515212715.3151307-8-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291474-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,gmail.com,queasysnail.net,davemloft.net,redhat.com,google.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 563775CED6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
tls: device: add RX KeyUpdate support

This adds RX-side TLS 1.3 KeyUpdate support to the device offload path,
keeping the old AEAD/IV/rec_seq around to handle in-flight records that
the NIC already decrypted with the retired key, and deferring tls_dev_add
of the new key until the old key has fully drained.

> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index c435b3450872..1c58cbd55ffb 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c

[ ... ]

> @@ -1552,13 +1722,30 @@ int tls_set_device_offload(struct sock *sk,
>  	return rc;
>  }
>  
> -int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
> +int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx,
> +			      struct tls_crypto_info *new_crypto_info)
>  {

[ ... ]

> +	if (new_crypto_info) {
> +		struct tls_sw_context_rx *sw_ctx = tls_sw_ctx_rx(ctx);
> +
> +		if (!test_bit(TLS_RX_DEV_CLOSED, &ctx->flags)) {
> +			set_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
> +			synchronize_net();
> +			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
> +							TLS_OFFLOAD_CTX_DIR_RX);
> +		}
> +
> +		if (context->rekey.old_aead_recv &&
> +		    before(copied_seq, context->rekey.old_nic_boundary)) {

[ ... ]

> +			context->dev_add_pending = 1;
> +		} else {
> +			u32 rcv_nxt;
> +
> +			if (context->rekey.old_aead_recv) {
> +				crypto_free_aead(context->rekey.old_aead_recv);
> +				context->rekey.old_aead_recv = NULL;
> +			}
> +
> +			/* flush the backlog so rcv_nxt is accurate */
> +			__sk_flush_backlog(sk);
> +			rcv_nxt = tcp_sk(sk)->rcv_nxt;
> +
> +			if (before(copied_seq, rcv_nxt)) {
> +				context->rekey.old_aead_recv = sw_ctx->aead_recv;
> +				sw_ctx->aead_recv = NULL;
> +				memcpy(context->rekey.old_iv, ctx->rx.iv,
> +				       sizeof(context->rekey.old_iv));
> +				memcpy(context->rekey.old_rec_seq, ctx->rx.rec_seq,
> +				       sizeof(context->rekey.old_rec_seq));
> +				context->rekey.old_nic_boundary = rcv_nxt;
> +				context->dev_add_pending = 1;
> +			}
> +		}
> +	}
> +
> +	rc = tls_sw_ctx_init(sk, 0, new_crypto_info);
>  	if (rc)
>  		goto release_ctx;

[High]
In the rekey branch, sw_ctx->aead_recv has just been moved into
context->rekey.old_aead_recv (with sw_ctx->aead_recv set to NULL) and the
NIC offload has already been torn down via tls_dev_del with
TLS_RX_DEV_CLOSED set.

If tls_sw_ctx_init() then fails (for example crypto_alloc_aead, setkey,
setauthsize, or an ENOMEM in the strparser init), control jumps to
release_ctx, and for the new_crypto_info case that label is essentially a
no-op:

	release_ctx:
		if (!new_crypto_info) {
			kfree(ctx->priv_ctx_rx);
			ctx->priv_ctx_rx = NULL;
		}

So sw_ctx->aead_recv stays NULL, the rekey state stays populated,
TLS_RX_DEV_CLOSED stays set, and tls_sw_ctx_finalize() is never called.

The error returns to do_tls_setsockopt_conf() and, because
update && rx_conf == TLS_HW, it goes straight to err_crypto_info without
restoring anything, while rx_conf is still TLS_HW and the socket remains
open.

Can a subsequent recvmsg on this socket then NULL-deref in tls_decrypt_sg(),
which uses ctx->aead_recv unconditionally to compute
sizeof(*aead_req) + crypto_aead_reqsize(ctx->aead_recv)?

Should this path roll back the rekey state (restore sw_ctx->aead_recv from
rekey.old_aead_recv, clear rekey state, clear dev_add_pending) on
tls_sw_ctx_init() failure?

[High]
The error path renaming from tls_sw_free_resources_rx() to
tls_sw_release_resources_rx() in free_sw_resources, combined with a later
kfree(ctx->priv_ctx_rx), looks like it drops the strparser anchor cleanup:

> free_sw_resources:
>  	up_read(&device_offload_lock);
> -	tls_sw_free_resources_rx(sk);
> +	tls_sw_release_resources_rx(sk);
>  	down_read(&device_offload_lock);
>  release_ctx:
> -	ctx->priv_ctx_rx = NULL;
> +	if (!new_crypto_info) {
> +		kfree(ctx->priv_ctx_rx);
> +		ctx->priv_ctx_rx = NULL;
> +	}

tls_sw_free_resources_rx() previously did three things: release_resources_rx
(frees aead_recv, stops strparser), __tls_strp_done() ->
tls_strp_anchor_free() which consume_skb()s the anchor allocated in
tls_strp_init() during tls_sw_ctx_init(), and finally tls_sw_free_ctx_rx().

The new code only does steps one and three — calling kfree(priv_ctx_rx)
without first doing the anchor consume_skb().

Since tls_strp_init() runs inside tls_sw_ctx_init() during the
!new_crypto_info path, and free_sw_resources is reached only after
tls_device_dev_add_rx() fails (i.e. after init succeeded), is the
strp->anchor SKB leaked on every initial-setup failure here?

> +	if (!context->dev_add_pending) {
> +		rc = tls_device_dev_add_rx(sk, ctx, netdev, src_crypto_info,
> +					   copied_seq, !!new_crypto_info);
> +		if (!new_crypto_info) {
> +			if (rc)
> +				goto free_sw_resources;
> +			tls_device_attach(ctx, sk, netdev);
> +		}
> +	} else if (!was_dev_add_pending) {
> +		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYINPROGRESS);
> +	} else {
> +		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
> +	}

[Medium, Medium]
For the rekey path, context->dev_add_pending is set to 1 before
tls_sw_ctx_init() is called, but the matching
TLS_INC_STATS(LINUX_MIB_TLSRXREKEYINPROGRESS) only happens later in the
"else if (!was_dev_add_pending)" branch after init has succeeded.

If tls_sw_ctx_init() fails, the goto release_ctx is a no-op for
new_crypto_info, leaving dev_add_pending == 1 with no prior
REKEYINPROGRESS increment.

When the socket closes, tls_device_offload_cleanup_rx() then runs:

	if (rx_ctx && rx_ctx->dev_add_pending) {
		rx_ctx->dev_add_pending = 0;
		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
		TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYINPROGRESS);
	}

Does this decrement TLSRXREKEYINPROGRESS without a prior matching
increment, wrapping the per-CPU SNMP counter to a very large unsigned
value, and bump TLSRXREKEYOK for a rekey that never installed a new key
on the NIC?

Separately, in the same cleanup tail, dev_add_pending == 1 means the
deferred tls_dev_add never ran, so the new key was not installed on the
NIC. Should this path really increment LINUX_MIB_TLSRXREKEYOK, given that
tls_device_dev_add_rx() is the documented place that bumps REKEYOK after
the NIC accepts the new key?

[Medium]
In the same hunk, when was_dev_add_pending is 1 (a previous rekey is still
draining) and a new rekey arrives, the third arm runs:

	} else {
		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
	}

dev_add_pending is still 1 here and the new key has not been installed on
the NIC yet. The eventual tls_device_deferred_dev_add_rx() will also call
tls_device_dev_add_rx() with is_rekey=true, which on success increments
LINUX_MIB_TLSRXREKEYOK again.

Is the same successful rekey getting counted twice in this case, and a
never-completed nested rekey getting counted as success?

