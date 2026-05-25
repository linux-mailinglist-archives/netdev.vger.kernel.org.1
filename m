Return-Path: <netdev+bounces-291473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAbCECS8FGpUPwcAu9opvQ
	(envelope-from <netdev+bounces-291473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 23:16:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A16EF5CED5E
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 23:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09D603006391
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D8F2868B4;
	Mon, 25 May 2026 21:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQoaUe0H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FE5280035
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779743772; cv=none; b=DwBjzVou/C5rfIo1EOYQdlzvWmmGUEyhqUSe4JgGZEk7+4XRGB4gVcxzIiyPTHsqax/Y0UZ3ceJmnKs6U5UyDWLbthluuIDjYG9r5LGXNfLIkG1oa/8Yz1adsS7kkOZVNtdb0PP3WFCAAQB3Eeatc09Tp7FOEbZ9A66VhZ67DLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779743772; c=relaxed/simple;
	bh=2uveLxS721PGxlm7aRyzdj9ithO0gwpN9FYpSghE7EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ue5H016rn8NLn3kFRdIjEsXXNbvZJ+v/Pv97pwaNmEUQ5h6XR90kAQ6CEiFqR1bG2USZMBWTr/vP8N08Me8Ao6caPzPtu9xg25BW9bCbHqIgcBw+FGqu1MCltNnrYTK6fv+H0glaHOGVyxAp4O+KJYCxKVwjfv1CmU0NhbecJyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQoaUe0H; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7D01F000E9;
	Mon, 25 May 2026 21:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779743770;
	bh=elaOtML8yb66Eiu8q5hrAIM9ik4LbtoxLG/BEAclGmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OQoaUe0HuOFI2Ja8Esmrqq5GZ6u/NRJYaFvrP8Nn4J8GugsKx7onZUzMksZPtfIla
	 f2HgIeC7GNJgrU0NZBeFSGLs5mVBA9XWMIw9DlBDdKEY8p7ZD3DqMVPgfLnb5T4tRL
	 VO5vAr0KmzADmXV2tv53Fjv0HU8iI7m2gk/4yZdwJukCr3/6sLy/03P1mg58w05AQ+
	 cWVxMkFVPQhWTZUPH4rQPL44+9KLf/8GEw1Qw2L9ouCONMSp8NQeQscRVIfCQFVmfE
	 IbRjseXYZVGaEUXGx7S39khvMQR3Uovf/HC4w7l4/YqgdjjCfawfqGhAb3WHCvGbXX
	 Rwisnm9nSpVvw==
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
Subject: Re: [PATCH v14 6/9] tls: device: add TX KeyUpdate support
Date: Mon, 25 May 2026 14:16:08 -0700
Message-ID: <20260525211608.2508449-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515212715.3151307-7-rjethwani@purestorage.com>
References: <20260515212715.3151307-7-rjethwani@purestorage.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,gmail.com,queasysnail.net,davemloft.net,redhat.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-291473-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A16EF5CED5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
tls: device: add TX KeyUpdate support

This adds TX-side TLS 1.3 KeyUpdate support for HW-offloaded sockets by
installing a temporary SW context with the new key, deferring the HW
reinstall until all old-key records have been ACKed, and falling back to
permanent SW mode if the HW reinstall fails.

Thanks for the patch.  A few questions inline.

> diff --git a/include/net/tls.h b/include/net/tls.h
> index 2512a3799b21..c1085873ee01 100644
> --- a/include/net/tls.h
> +++ b/include/net/tls.h

[ ... ]

> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index 7a98d2f6cbd3..c435b3450872 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c

[ ... ]

> @@ -222,6 +246,19 @@ static void tls_tcp_clean_acked(struct sock *sk, u32 acked_seq)
>  	}
>  
>  	ctx->unacked_record_sn += deleted_records;
> +
> +	/* Once all old-key HW records are ACKed, set REKEY_READY to
> +	 * let sendmsg know it can finish the rekey and switch back
> +	 * to HW offload.
> +	 */
> +	if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags) &&
> +	    !test_bit(TLS_TX_REKEY_FAILED, &tls_ctx->flags)) {
> +		u32 boundary_seq = READ_ONCE(tls_ctx->rekey.boundary_seq);
> +
> +		if (!before(acked_seq, boundary_seq))
> +			set_bit(TLS_TX_REKEY_READY, &tls_ctx->flags);
> +	}
> +
>  	spin_unlock_irqrestore(&ctx->lock, flags);
>  }

[Medium]
Is the ordering between the boundary_seq publish and the PENDING bit
publish in tls_device_start_rekey() strong enough for this read site?

In tls_device_start_rekey() the sequence is:

	WRITE_ONCE(ctx->rekey.boundary_seq, tcp_sk(sk)->write_seq);
	...
	set_bit(TLS_TX_REKEY_PENDING, &ctx->flags);

set_bit() does not document any implicit memory barrier
(Documentation/atomic_bitops.txt).  On weakly-ordered architectures, can
this reader observe PENDING=1 with a stale boundary_seq, set REKEY_READY
prematurely, and let tls_device_complete_rekey() run before the old-key
records are actually ACKed?

Would an smp_wmb() (or smp_mb__before_atomic()) between the write of
boundary_seq and the set_bit, or moving both writes under
offload_ctx->lock that this reader already holds, be appropriate?

> @@ -253,6 +290,14 @@ void tls_device_free_resources_tx(struct sock *sk)
>  	struct tls_context *tls_ctx = tls_get_ctx(sk);
>  
>  	tls_free_partial_record(sk, tls_ctx);
> +
> +	if (unlikely(tls_ctx->rekey.sw_ctx))
> +		tls_sw_release_resources_tx(sk);
> +
> +	if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags)) {
> +		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
> +		TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYINPROGRESS);
> +	}
>  }

[Medium]
Should a rekey that was still PENDING at socket teardown count as
TlsTxRekeyOk?  The rekey never completed, but the counter is bumped as
if it had succeeded.  Should this be a separate "aborted" counter, or
just omit the OK increment in this path?

> @@ -624,6 +672,19 @@ int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>  			goto out;
>  	}
>  
> +	/* Old-key records all ACKed; switch back to HW. */
> +	if (test_bit(TLS_TX_REKEY_READY, &tls_ctx->flags))
> +		tls_device_complete_rekey(sk, tls_ctx, true);

[Medium]
Should the return value of tls_device_complete_rekey() be checked here?

tls_device_complete_rekey() can return non-zero from its early
tls_sw_drain_tx() path:

	rc = tls_sw_drain_tx(sk, ctx);
	if (rc)
		return rc;

In that early-return case none of REKEY_PENDING, REKEY_READY, or
REKEY_FAILED is updated.  The caller falls through to
tls_sw_sendmsg_locked(), and on the next sendmsg the same READY bit is
still set, so complete_rekey is retried, drain returns -EAGAIN again,
and so on.  Is there a way out of this state?  Should persistent drain
failure transition to FAILED, or at least bump a counter so it is
observable?

> +
> +	/* Use SW path if rekey is in progress (PENDING) or if HW rekey
> +	 * failed (FAILED).
> +	 */
> +	if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags) ||
> +	    test_bit(TLS_TX_REKEY_FAILED, &tls_ctx->flags)) {
> +		rc = tls_sw_sendmsg_locked(sk, msg, size);
> +		goto out;
> +	}
> +
>  	rc = tls_push_data(sk, &msg->msg_iter, size, msg->msg_flags,
>  			   record_type);

[High]
What happens to a HW open_record across this transition?

If userspace previously sent with MSG_MORE, offload_ctx->open_record
holds buffered plaintext and tls_ctx->pending_open_record_frags is true.
A subsequent setsockopt KeyUpdate then routes future sendmsg calls into
tls_sw_sendmsg_locked(), which builds into sw_ctx->open_rec (initially
NULL) and never touches the HW open_record.  At socket close,
tls_device_sk_destruct() does:

	if (ctx->open_record)
		destroy_record(ctx->open_record);

so the buffered plaintext is freed without ever being transmitted.

Also, since pending_open_record_frags stays true, would
tls_sw_drain_tx() see tls_is_pending_open_record(ctx) as true and return
-EAGAIN, blocking tls_device_complete_rekey() until something on the SW
side coincidentally clears it?

The tcp_write_collapse_fence() in tls_device_start_rekey() only handles
records already in the TCP write queue; it does not appear to flush this
HW open_record.

> @@ -1103,6 +1164,260 @@ static struct tls_offload_context_tx *alloc_offload_ctx_tx(struct tls_context *c
[ ... ]
> +static int tls_device_start_rekey(struct sock *sk,
> +				  struct tls_context *ctx,
> +				  struct tls_offload_context_tx *offload_ctx,
> +				  struct tls_crypto_info *new_crypto_info)
> +{
> +	bool rekey_pending = test_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
> +	bool rekey_failed = test_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
[ ... ]
> +	if (rekey_pending || rekey_failed) {
> +		rc = crypto_aead_setkey(offload_ctx->rekey.sw.aead_send,
> +					key, cipher_desc->key);
> +		if (rc)
> +			return rc;

[High]
Can there be in-flight async crypto requests on this aead_send when
crypto_aead_setkey() is called here?

While a rekey is PENDING, sendmsg has been encrypting via
offload_ctx->rekey.sw.aead_send through tls_sw_sendmsg_locked().  Async
backends can return -EINPROGRESS and complete later.  Other call sites
that mutate AEAD state (tls_sw_release_resources_tx, tls_sw_drain_tx,
tls_set_sw_offload) call tls_encrypt_async_wait() first.  Should the
same wait happen here before re-keying the same tfm, so in-flight
encryptions cannot pick up K2 instead of the K1 they were submitted
with?

[ ... ]
> +	} else {
> +		rc = tls_device_init_rekey_sw(sk, ctx, offload_ctx,
> +					      new_crypto_info);
[ ... ]
> +		WRITE_ONCE(ctx->rekey.boundary_seq, tcp_sk(sk)->write_seq);
> +
> +		/* Prevent a partial record straddling the SW/HW boundary. */
> +		tcp_write_collapse_fence(sk);
> +
> +		ctx->rekey.sw_ctx = &offload_ctx->rekey.sw;
> +		ctx->rekey.cipher_ctx = &offload_ctx->rekey.tx;
> +
> +		set_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
[ ... ]
> +	unsafe_memcpy(&offload_ctx->rekey.crypto_send.info, new_crypto_info,
> +		      cipher_desc->crypto_info,
> +		      /* checked in do_tls_setsockopt_conf */);
> +	memzero_explicit(new_crypto_info, cipher_desc->crypto_info);
> +
> +	return 0;
> +}

[Medium]
new_crypto_info is zeroized after the copy, but is the staging area
itself ever scrubbed?

offload_ctx->rekey.crypto_send.info, offload_ctx->rekey.tx.iv, and
offload_ctx->rekey.tx.rec_seq receive the same key bytes via
unsafe_memcpy/memcpy.  tls_device_complete_rekey() does not scrub them
on success, and tls_device_free_resources_tx() / tls_device_tx_del_task()
kfree the offload_ctx without a memzero_explicit().  Should those sites
zero the staging area to limit the window in which key bytes are
recoverable from slab memory after rotation?

> +static int tls_device_complete_rekey(struct sock *sk, struct tls_context *ctx,
> +				     bool deferred)
> +{
[ ... ]
> +	if (!test_bit(TLS_TX_DEV_CLOSED, &ctx->flags)) {
> +		netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
> +						TLS_OFFLOAD_CTX_DIR_TX);
> +		set_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
> +	}
> +
> +	memcpy(crypto_info_rec_seq(&offload_ctx->rekey.crypto_send.info, cipher_desc),
> +	       offload_ctx->rekey.tx.rec_seq, cipher_desc->rec_seq);
> +
> +	rc = tls_device_dev_add_tx(sk, netdev, &offload_ctx->rekey.crypto_send.info,
> +				   tcp_sk(sk)->write_seq);
> +
> +release_lock:
> +	up_read(&device_offload_lock);
> +
> +	spin_lock_irqsave(&offload_ctx->lock, flags);
> +	memcpy(&rcd_sn, offload_ctx->rekey.tx.rec_seq, sizeof(rcd_sn));
> +	offload_ctx->unacked_record_sn = be64_to_cpu(rcd_sn) - 1;
> +	spin_unlock_irqrestore(&offload_ctx->lock, flags);
> +
> +	memcpy(ctx->tx.iv, offload_ctx->rekey.tx.iv,
> +	       cipher_desc->salt + cipher_desc->iv);
> +	memcpy(ctx->tx.rec_seq, offload_ctx->rekey.tx.rec_seq,
> +	       cipher_desc->rec_seq);
> +	unsafe_memcpy(&ctx->crypto_send.info,
> +		      &offload_ctx->rekey.crypto_send.info,
> +		      cipher_desc->crypto_info,
> +		      /* checked during rekey setup */);
> +
> +	if (rc)
> +		goto rekey_fail;
> +
> +	clear_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
> +
> +	key = crypto_info_key(&offload_ctx->rekey.crypto_send.info, cipher_desc);
> +	rc = crypto_aead_setkey(offload_ctx->aead_send, key, cipher_desc->key);
> +	if (rc)
> +		goto rekey_fail;

[High]
Can these unconditional copies of the new key material into ctx->tx.iv,
ctx->tx.rec_seq, and ctx->crypto_send.info before the rc check leave
inconsistent state on failure?

If tls_device_dev_add_tx() failed, control reaches rekey_fail with:

  - HW context removed (TLS_TX_DEV_CLOSED set)
  - ctx->crypto_send.info advertising the NEW key
  - ctx->tx.iv and ctx->tx.rec_seq holding the NEW salt/IV/rec_seq
  - offload_ctx->aead_send still holding the OLD key (the setkey for it
    is reached only after the rc check)

Userspace getsockopt(SOL_TLS, TLS_TX) would then read NEW key bytes that
no kernel AEAD ever absorbed.  Any subsequent fallback that builds IVs
from ctx->tx and encrypts via offload_ctx->aead_send would mix NEW salt
with the OLD key.

Could the memcpy block move below the rc check?

[High]
On the success path, is there a window where tls_device_down() sees
stale TLS_TX_DEV_CLOSED?

The success path here:

	if (!test_bit(TLS_TX_DEV_CLOSED, &ctx->flags)) {
		netdev->tlsdev_ops->tls_dev_del(...);
		set_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
	}
	...
	rc = tls_device_dev_add_tx(...);   /* installs NEW HW ctx */

release_lock:
	up_read(&device_offload_lock);
	...
	if (rc) goto rekey_fail;
	clear_bit(TLS_TX_DEV_CLOSED, &ctx->flags);

Between dropping device_offload_lock and clear_bit(), can
tls_device_down() take down_write(&device_offload_lock) and run:

	if (ctx->tx_conf == TLS_HW &&
	    !test_bit(TLS_TX_DEV_CLOSED, &ctx->flags)) {
		netdev->tlsdev_ops->tls_dev_del(...);
		set_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
	}

It sees TLS_TX_DEV_CLOSED still set, skips tls_dev_del() for the
freshly-installed NEW HW context, and proceeds to clear ctx->netdev.
Would the new NIC-side TLS state then be leaked until the netdev is
unregistered?

Should TLS_TX_DEV_CLOSED be cleared while still holding
device_offload_lock?

> +
> +	/* Start marker: the NIC passes through everything before
> +	 * write_seq unencrypted (already SW-encrypted during rekey),
> +	 * same as during initial offload setup.
> +	 */
> +	tls_device_commit_start_marker(sk, offload_ctx, start_marker_record);
[ ... ]
> +rekey_fail:
> +	kfree(start_marker_record);
> +	set_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
> +	clear_bit(TLS_TX_REKEY_READY, &ctx->flags);
> +	clear_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
> +	if (deferred)
> +		TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYINPROGRESS);
> +	TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYFALLBACK);
> +
> +	return 0;
> +}

[Medium]
After REKEY_FAILED, the connection is structurally encrypting in SW even
though ctx->tx_conf stays TLS_HW.  TLSCURRTXDEVICE is never decremented
and TLSCURRTXSW is never incremented in this path.  Should the
current-mode gauges in /proc/net/tls_stat reflect the actual encryption
mode for these connections?

> +static int tls_set_device_offload_rekey(struct sock *sk,
> +					struct tls_context *ctx,
> +					struct net_device *netdev,
> +					struct tls_crypto_info *new_crypto_info)
> +{
> +	struct tls_offload_context_tx *offload_ctx = tls_offload_ctx_tx(ctx);
> +	bool rekey_pending = test_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
> +	bool rekey_failed = test_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
> +	bool defer = true;
> +	int rc;
> +
> +	if (!rekey_pending && !rekey_failed)
> +		defer = tls_has_unacked_records(offload_ctx);
> +
> +	down_read(&device_offload_lock);
> +
> +	rc = tls_device_start_rekey(sk, ctx, offload_ctx, new_crypto_info);
> +	if (rc) {
> +		up_read(&device_offload_lock);
> +		return rc;
> +	}
> +
> +	up_read(&device_offload_lock);
> +
> +	if (defer) {
> +		if (!rekey_pending)
> +			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYINPROGRESS);
> +		else
> +			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
> +		return 0;
> +	}
> +
> +	return tls_device_complete_rekey(sk, ctx, false);
> +}

[Medium]
On the rekey_pending path here, TLSTXREKEYOK is incremented before any
HW reinstall actually happens.  Combined with the increment in
tls_device_complete_rekey() on success and the increment in
tls_device_free_resources_tx() when PENDING is set at close, can a
single logical successful rekey produce more than one TLSTXREKEYOK
increment?

[Medium]
tls_has_unacked_records() inspects offload_ctx->records_list only.  Is
that sufficient to decide whether to defer?  pending_open_record_frags
or offload_ctx->open_record can still hold pre-rekey state, in which
case the !defer path falls into tls_device_complete_rekey(deferred=false),
tls_sw_drain_tx() returns -EAGAIN, setsockopt returns the error to
userspace via err_crypto_info, and none of the state transitions from
tls_device_start_rekey() (PENDING bit, sw_ctx, cipher_ctx, boundary_seq,
sk_validate_xmit_skb) are rolled back.  Should the failure path either
roll those back or transition to a defined recovery state?

[ ... ]

> diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
> index 1110f7ac6bcb..64ac4ef4012b 100644
> --- a/net/tls/tls_device_fallback.c
> +++ b/net/tls/tls_device_fallback.c
> @@ -435,6 +435,30 @@ struct sk_buff *tls_validate_xmit_skb_sw(struct sock *sk,
>  	return tls_sw_fallback(sk, skb);
>  }
>  
> +struct sk_buff *tls_validate_xmit_skb_rekey(struct sock *sk,
> +					    struct net_device *dev,
> +					    struct sk_buff *skb)
> +{
> +	struct tls_context *tls_ctx = tls_get_ctx(sk);
> +	u32 tcp_seq = ntohl(tcp_hdr(skb)->seq);
> +	u32 boundary_seq;
> +
> +	if (test_bit(TLS_TX_REKEY_FAILED, &tls_ctx->flags))
> +		return skb;
> +
> +	/* If this packet is at or after the rekey boundary, it's already
> +	 * SW-encrypted with the new key, pass through unchanged
> +	 */
> +	boundary_seq = READ_ONCE(tls_ctx->rekey.boundary_seq);
> +	if (!before(tcp_seq, boundary_seq))
> +		return skb;
> +
> +	/* Packet before boundary means retransmit of old data,
> +	 * use SW fallback with the old key
> +	 */
> +	return tls_sw_fallback(sk, skb);
> +}

[Critical]
Can this leak plaintext on the wire after REKEY_FAILED?

The first branch returns the skb unchanged whenever
TLS_TX_REKEY_FAILED is set, regardless of where tcp_seq is relative to
boundary_seq.

After tls_device_complete_rekey() has called tls_dev_del() and then
landed in rekey_fail, there is no NIC TLS context for the socket.
SKBs from before the boundary are still sitting in the socket write
queue with plaintext payload, because HW-offload semantics expected the
NIC to encrypt them at TX time.  When TCP retransmits one of those old
skbs:

	tcp_seq < boundary_seq, but TLS_TX_REKEY_FAILED is set
	-> early return skb unchanged
	-> NIC has no TLS context for this flow
	-> driver transmits the skb as-is

Should the FAILED branch still route pre-boundary packets through
tls_sw_fallback() with the old key, the same way the non-failed branch
does, so that pre-boundary retransmits are encrypted?

> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index fd04857fa0ab..2548ad2b2219 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -371,6 +371,8 @@ static void tls_sk_proto_close(struct sock *sk, long timeout)
>  
>  	if (ctx->tx_conf == TLS_SW)
>  		tls_sw_cancel_work_tx(ctx);
> +	else if (ctx->tx_conf == TLS_HW && ctx->rekey.sw_ctx)
> +		tls_sw_cancel_work_tx(ctx);
>  
>  	lock_sock(sk);

[High]
Is reading ctx->rekey.sw_ctx before lock_sock(sk) safe?

ctx->rekey.sw_ctx is published by tls_device_start_rekey() under
lock_sock.  Here close reads it before taking lock_sock, so a concurrent
setsockopt rekey can publish sw_ctx after this read but before close
acquires the socket lock.  Close then proceeds without canceling the
delayed tx_work, while later cleanup
(tls_device_free_resources_tx -> tls_sw_release_resources_tx) frees
aead_send.

If a tx_work_handler scheduled by the rekey path runs after that, can it
touch the freed delayed_work or aead_send?

Should the read be moved under lock_sock, or should
tls_sw_release_resources_tx() internally cancel the delayed work?

[ ... ]
-- 
pw-bot: cr

