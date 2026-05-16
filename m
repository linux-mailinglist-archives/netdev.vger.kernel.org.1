Return-Path: <netdev+bounces-288534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF4xLB7EB2pEHwMAu9opvQ
	(envelope-from <netdev+bounces-288534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:10:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC8B559AE5
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44019300B2B2
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D0428640C;
	Sat, 16 May 2026 01:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnQfQQuq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CE42857CC
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 01:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778893818; cv=none; b=c/lLr97vSKpToJT17gyZmpa4FsUhTfo6qDzMGLo/tC7Iy06P0FrE2nvDJ/VKsrSiRIIu8N9EGDXZA1Joh/ULzI7QwHxVNwKTso6XaiLBag2X7HL57LKTtnAnV29oNWrEs1w/cugkTKDhadrwfey3/RZIkCmZuOPDyJ0KB2kFjHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778893818; c=relaxed/simple;
	bh=ZNTPgj9dNqgW+DuxWcf+FDn/LuarrOrlwuQgTAu7jwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NiU1BGsc8YI0Xcx8wTyhDuM+bFCMaUxPTFNMdHDy30rDJAGOLgwn8I+v03x1ET8viH8Aqs4gP+IrR2nr2Z8tvsjFy1gCpv+QFj6ewQ2WAstkjx2DgCP4M9gI7uyunHJZeHQwLz+gnoupv9XhPKEmG4WzmsfW+Fgyoo8YbdQUHvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnQfQQuq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B2CC2BCB0;
	Sat, 16 May 2026 01:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778893818;
	bh=ZNTPgj9dNqgW+DuxWcf+FDn/LuarrOrlwuQgTAu7jwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PnQfQQuq8eGd5jjb++ezR9s01Am3EZJfkaA320nl+AB8fTUwmj4kZbgAA6TdgAjjx
	 mhmUKbuw0euyF8XXmOCkqkAPfBIMEQXcA+l0G9C5IBNeS/jHfltdnFJ0mY1sb/HfUg
	 u1ChZ7Ytzf71ZWFXJf4+pv5D4j3jnLI2T0/DkyfKFvcZB9tszWRrjzrhuzX28UPCYy
	 Xuy0sICRW3GAxvr2UyD71rAxvrW0kDD44xy3/qIkKNvM5j5YhHE7wKZlaypi093A6i
	 uJKvbJU7KkgvZifG1sn/QDrmjB+wErQUfJS/lM7dAlhNrEz4auMOjxkYQaslPgqeu+
	 nFGDIObKOg/yg==
From: Jakub Kicinski <kuba@kernel.org>
To: michael.chan@broadcom.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v2 09/15] bnxt_en: Add infrastructure for crypto key context IDs
Date: Fri, 15 May 2026 18:10:16 -0700
Message-ID: <20260516011017.1857586-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512212105.3488258-10-michael.chan@broadcom.com>
References: <20260512212105.3488258-10-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DEC8B559AE5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288534-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: bnxt_en: Add infrastructure for crypto key context IDs

This patch adds a kid_info data structure plus APIs to allocate and free
crypto key context IDs (KIDs) for kTLS in the bnxt_en driver.  Batches
of KIDs are obtained from the firmware and tracked in an RCU-walked
linked list with a per-batch bitmap.

Reviewing the changes raised a few questions, inline below.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 926665c8bb79..4f5de41d4e86 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -17219,6 +17219,9 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	rc = bnxt_dl_register(bp);
>  	if (rc)
>  		goto init_err_dl;
> +	rc = bnxt_crypto_init(bp);
> +	if (rc)
> +		bnxt_free_crypto_info(bp);

[Low]
The other init steps in this function uniformly do an "if (rc) goto
init_err_*;" with at least a netdev_warn() logged.

Here, on failure rc is silently overwritten by the next assignment
(rc = register_netdev(dev) further down), so a transient HWRM error or
DMA-slice ENOMEM during probe ends up leaving the device up with kTLS
permanently disabled and no message in dmesg.

Additionally, if the TX HWRM_FUNC_KEY_CTX_ALLOC succeeded but the RX one
failed, the in-file comment

  /* Note that the driver does not free the key contexts.  They are freed
   * by the FW during FLR and HWRM_FUNC_RESET.
   */

implies the firmware-side TX KIDs remain allocated until the next
FLR/FUNC_RESET, while the driver has dropped its bookkeeping for them.
Would it be reasonable to log a netdev_warn() and/or short-circuit the
probe path here?

>  
>  	INIT_LIST_HEAD(&bp->usr_fltr_list);
>  
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
> index ee154f1e4e19..4ea3e67be9f5 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c

[ ... ]

> +void bnxt_clear_crypto(struct bnxt *bp)
> +{
> +	struct bnxt_crypto_info *crypto = bp->crypto_info;
> +	struct bnxt_kid_info *kid, *tmp;
> +	struct bnxt_kctx *kctx;
> +	int i;
> +
> +	if (!crypto)
> +		return;
> +
> +	/* Shutting down or FW reset, no need to protect the lists. */
> +	for (i = 0; i < BNXT_MAX_CRYPTO_KEY_TYPE; i++) {
> +		kctx = &crypto->kctx[i];
> +		list_for_each_entry_safe(kid, tmp, &kctx->list, list) {
> +			list_del(&kid->list);
> +			kfree(kid);
> +		}
> +		kctx->total_alloc = 0;
> +		kctx->epoch++;
> +	}
> +}

[Medium]
The kid nodes are published into kctx->list with list_add_tail_rcu() in
bnxt_key_ctx_store() and read by bnxt_kid_valid(), bnxt_alloc_one_kctx()
and bnxt_free_one_kctx() under list_for_each_entry_rcu() inside
rcu_read_lock().

Here they are torn down with plain list_del() followed by an immediate
kfree(), with no list_del_rcu(), no synchronize_rcu() and no kfree_rcu()
(struct bnxt_kid_info has no rcu_head).  The comment says "no need to
protect the lists" because the function "assumes serialization (called
during shutdown)", but the kerneldoc above also lists "firmware reset"
as a use case.

If a future caller invokes bnxt_clear_crypto() from a path where an
RCU reader is concurrently walking kctx->list, list_del() will turn
kid->next into LIST_POISON1 and the immediate kfree() will return the
memory the reader is about to dereference.

Would it be safer to use list_del_rcu() plus kfree_rcu() (adding an
rcu_head to bnxt_kid_info) so the API is self-contained, regardless of
caller serialization assumptions?

[Low]
Also on the epoch bump: kctx->epoch is a u8, and BNXT_KID_EPOCH_MASK is
0xff000000 (8 bits).  Each call to bnxt_clear_crypto() does
kctx->epoch++, so after 256 shutdown/reset cycles the value wraps back
to a previously-used epoch.

The kerneldoc states that the increment is used to "invalidate any
outstanding key references", but a stale KID encoding the wrapped
epoch will silently pass the "epoch != kctx->epoch" check in
bnxt_kid_valid() and be matched against a freshly-allocated KID range.

Should the epoch field be wider, given that there are 24 free bits in
the KID encoding?

> +
>  /**
>   * bnxt_free_crypto_info - Free crypto offload resources
>   * @bp: pointer to bnxt device

[ ... ]

> +static int bnxt_key_ctx_store(struct bnxt_kctx *kctx, __le32 *key_buf, u32 num,
> +			      bool contig, u8 kind, u32 *id)
> +{
> +	struct bnxt_kid_info *kid;
> +	u32 i;
> +
> +	for (i = 0; i < num; ) {
> +		kid = kzalloc_obj(*kid);
> +		if (!kid)
> +			return -ENOMEM;

[Low]
On a kzalloc failure partway through a non-contiguous batch, this
returns -ENOMEM with kids from earlier iterations already linked into
kctx->list.  The remaining keys in key_buf[i..num-1], and in the
contig=true case all "num" keys, were already allocated by the
firmware, but the driver now has no record of them.

Per the comment

  /* Note that the driver does not free the key contexts.  They are
   * freed by the FW during FLR and HWRM_FUNC_RESET.
   */

these IDs stay allocated on the firmware side until the next reset.

Is there a way to either record them or release them via HWRM on the
error path so the usable KID pool isn't permanently shrunk under
sustained ENOMEM during kTLS bring-up?

> +		kid->start_id = le32_to_cpu(key_buf[i]);
> +		kid->type = kctx->type;
> +		kid->kind = kind;
> +		if (contig)
> +			kid->count = num;
> +		else
> +			kid->count = 1;
> +		bitmap_set(kid->ids, 0, kid->count);
> +		if (id && !i) {
> +			clear_bit(0, kid->ids);
> +			*id = BNXT_SET_KID(kctx, kid->start_id);
> +		}
> +		spin_lock(&kctx->lock);
> +		list_add_tail_rcu(&kid->list, &kctx->list);
> +		kctx->total_alloc += kid->count;
> +		spin_unlock(&kctx->lock);
> +		i += kid->count;
> +	}
> +	return 0;
> +}
> +
> +/* Note that the driver does not free the key contexts.  They are freed
> + * by the FW during FLR and HWRM_FUNC_RESET.
> + */
> +static int bnxt_hwrm_key_ctx_alloc(struct bnxt *bp, struct bnxt_kctx *kctx,
> +				   u8 kind, u32 num, u32 *id)
> +{

[ ... ]

> +	num_alloc = le16_to_cpu(resp->num_key_ctxs_allocated);
> +	if (num_alloc > num)
> +		netdev_warn(bp->dev,
> +			    "FW allocated more keys (%d) than requested (%d)\n",
> +			    num_alloc, num);
> +	else
> +		num = num_alloc;
> +	contig = resp->flags &
> +		 FUNC_KEY_CTX_ALLOC_RESP_FLAGS_KEY_CTXS_CONTIGUOUS;
> +	rc = bnxt_key_ctx_store(kctx, key_buf, num, contig, kind, id);

[Medium]
What happens if the firmware returns success with
num_key_ctxs_allocated == 0?

The "else num = num_alloc;" branch sets num to 0 and then calls
bnxt_key_ctx_store(kctx, key_buf, 0, contig, kind, id).  Inside
bnxt_key_ctx_store():

	for (i = 0; i < num; ) {
		...
		if (id && !i) {
			clear_bit(0, kid->ids);
			*id = BNXT_SET_KID(kctx, kid->start_id);
		}
		...
	}
	return 0;

the loop body never executes, so *id is never written and the function
still returns 0.  bnxt_hwrm_key_ctx_alloc() then falls through to
key_alloc_exit_wake with rc==0, and bnxt_key_ctx_alloc_one() returns 0
on the "if (!rc) return 0;" path.

Would it be appropriate to either treat num_alloc == 0 as an error
when an id was requested, or guarantee *id is initialised before the
function returns success?

> +
> +key_alloc_exit_wake:
> +	if (pending_count >= BNXT_KCTX_ALLOC_PENDING_MAX)
> +		wake_up_all(&kctx->alloc_pending_wq);
> +key_alloc_exit:
> +	hwrm_req_drop(bp, req);
> +	return rc;
> +}

[ ... ]

> +void bnxt_free_one_kctx(struct bnxt_kctx *kctx, u32 id)
> +{
> +	struct bnxt_kid_info *kid;
> +
> +	id = BNXT_KID_HW(id);
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(kid, &kctx->list, list) {
> +		if (id >= kid->start_id && id < kid->start_id + kid->count) {
> +			set_bit(id - kid->start_id, kid->ids);
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +}

[Low]
bnxt_kid_valid() rejects stale IDs via "epoch != kctx->epoch", but
bnxt_free_one_kctx() strips the epoch with BNXT_KID_HW(id) without any
such check.

If a caller passes an id captured before a bnxt_clear_crypto() epoch
bump, set_bit() will mark a currently in-use slot as free, and a
subsequent bnxt_alloc_one_kctx() can hand the same hardware KID to a
second kTLS connection — which for AES-GCM means (key, nonce) reuse.

The single in-tree consumer (introduced later in the series) does call
bnxt_kid_valid() before bnxt_free_one_kctx(), so this is not currently
reachable, but would a defensive epoch check inside this function close
the API hazard?

> +
> +#define BNXT_KCTX_ALLOC_RETRY_MAX	3
> +
> +int bnxt_key_ctx_alloc_one(struct bnxt *bp, struct bnxt_kctx *kctx, u8 kind,
> +			   u32 *id)
> +{
> +	int rc, retry = 0;
> +
> +	while (retry++ < BNXT_KCTX_ALLOC_RETRY_MAX) {
> +		rc = bnxt_alloc_one_kctx(kctx, kind, id);
> +		if (!rc)
> +			return 0;
> +
> +		if ((kctx->total_alloc + BNXT_KID_BATCH_SIZE) > kctx->max_ctx)
> +			return -ENOSPC;
> +
> +		if (!BNXT_KCTX_ALLOC_OK(kctx)) {
> +			wait_event(kctx->alloc_pending_wq,
> +				   BNXT_KCTX_ALLOC_OK(kctx));
> +			continue;
> +		}
> +		rc = bnxt_hwrm_key_ctx_alloc(bp, kctx, kind,
> +					     BNXT_KID_BATCH_SIZE, id);
> +		if (!rc)
> +			return 0;
> +	}
> +	return -EAGAIN;
> +}

[Medium]
The struct definition documents kctx->lock as

	/* to serialize update to the linked list and total_alloc */
	spinlock_t		lock;

and bnxt_key_ctx_store() does

	spin_lock(&kctx->lock);
	list_add_tail_rcu(&kid->list, &kctx->list);
	kctx->total_alloc += kid->count;
	spin_unlock(&kctx->lock);

but here total_alloc is read with no lock and no READ_ONCE().  Multiple
callers can each observe a stale value and proceed to issue their own
HWRM allocation, which combined with the BNXT_KCTX_ALLOC_PENDING_MAX
gate (8 in flight) can ask the firmware for up to
8 * BNXT_KID_BATCH_SIZE = 1024 IDs beyond max_ctx before any of them
update the counter.

Should this read be serialised under kctx->lock, or otherwise made
race-free with respect to the writers?

[Low]
On the BNXT_KCTX_ALLOC_OK gate itself, the check-then-act here is
non-atomic: BNXT_KCTX_ALLOC_OK reads alloc_pending and
bnxt_hwrm_key_ctx_alloc() does a separate atomic_inc_return().  Many
threads can simultaneously observe alloc_pending < 8 and then all
proceed to inc, raising it arbitrarily above the cap.

In addition, the wake_up_all() in bnxt_hwrm_key_ctx_alloc() depends on
its own pending_count (post-inc) being >= BNXT_KCTX_ALLOC_PENDING_MAX:

	pending_count = atomic_inc_return(&kctx->alloc_pending);
	rc = hwrm_req_send(bp, req);
	atomic_dec(&kctx->alloc_pending);
	...
key_alloc_exit_wake:
	if (pending_count >= BNXT_KCTX_ALLOC_PENDING_MAX)
		wake_up_all(&kctx->alloc_pending_wq);

If a burst of callers all happen to record pending_count values < 8 by
each racing past the check, none of them wake the wait queue, and a
waiter parked in wait_event(BNXT_KCTX_ALLOC_OK) only gets released when
some later caller happens to increment to >= 8.

Was this latency tolerated intentionally, or is the gate intended to
be exact?

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
> index e090491006db..ecdf18ba6d83 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h

[ ... ]

> +#define BNXT_SET_KID(kctx, kid)						\
> +	((kid) | ((kctx)->epoch << BNXT_KID_EPOCH_SHIFT))

[Low]
kctx->epoch is u8 and is promoted to (signed) int before the shift.
For epoch >= 128, "(int)epoch << 24" sets the sign bit of int, which
is undefined behaviour per C99/C11 6.5.7p4.

In combination with the 8-bit epoch wraparound noted earlier on
bnxt_clear_crypto(), epoch >= 128 is reachable, and a UBSan-instrumented
kernel will splat here.

Would casting epoch to u32 before the shift be acceptable?

> +
> +#define BNXT_KCTX_ALLOC_OK(kctx)	\
> +	(atomic_read(&((kctx)->alloc_pending)) < BNXT_KCTX_ALLOC_PENDING_MAX)
> +

[ ... ]

