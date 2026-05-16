Return-Path: <netdev+bounces-288536-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IPsFkXEB2pEHwMAu9opvQ
	(envelope-from <netdev+bounces-288536-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:11:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3D7559AFA
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0C6C3027378
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B652BE7DB;
	Sat, 16 May 2026 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAWTkkZc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4061429B795
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778893822; cv=none; b=qY15NjjgO0hoMsfAHTsfiOtW7UFmk/5mNQ85njSJNcGH3C8z3t8UbNONWxxnxU8XUU18JHgB82vuXoSiqZN7RM2EVfjkFuWp0VOedxRRLNxgQEyDEgmNGc5sH/l75Np4w/MhAQR84ygenWPmJH6IqvO22qJMZQY/wH7WRxjSOFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778893822; c=relaxed/simple;
	bh=b85LetTkfSgTOmsiYpThTCHbibBqKvVG/kA3/vHlxHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5Rz1Y/oDupwY4LsvhEwVszm+vjXxi8EBZVPiZ+FlHXZ031veXKB0lJP39Ym5XKHW9J/51DdVgUWFKHsWGGmZWJJpkt2gofRDgcJn4S/I5KCft7QuCE/EMvqu7QGNRlOjCi/+cB9ZpfX25drelHDrMRT43U+c22cZLNWyI4KnrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAWTkkZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81886C2BCB0;
	Sat, 16 May 2026 01:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778893821;
	bh=b85LetTkfSgTOmsiYpThTCHbibBqKvVG/kA3/vHlxHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bAWTkkZchNfDDgoWoS0Plu0m0WLQjecjMPramjnBg/14cYHdI7aPD9nyQAMpYscFN
	 Z9Hz+/TLbP7GCmFyN5C9T9Shbr8vihkGHuigNLWiluclIXG5fVh1XLqaj85sarOryO
	 GglQb+MQPeF9jp4jS+vezzggQyKa2kw8HVsRbke9sG4FznUUD+qYiK0O/oMZbea1pu
	 kVw5St8GwBdTbVRxh5GVE3Mwp7q4auy+lw3WaoSt3OVEqH+pSQNF08DV9kdMloG+WS
	 Pj0uQ596gkBzqkr6VHaTM315zMF3zOCXZpQdOybeGNVN9G8tg/Gd9ej63sF/rdR123
	 JP3bQgXf5Qhcg==
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
Subject: Re: [PATCH net-next v2 11/15] bnxt_en: Add crypto MPC transmit/completion infrastructure
Date: Fri, 15 May 2026 18:10:20 -0700
Message-ID: <20260516011020.1857710-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512212105.3488258-12-michael.chan@broadcom.com>
References: <20260512212105.3488258-12-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EE3D7559AFA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288536-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
bnxt_en: Add crypto MPC transmit/completion infrastructure

This patch adds infrastructure to send crypto commands over the midpath
channels (MPCs).  bnxt_xmit_crypto_cmd() submits a command and sleeps with
a timeout for the completion; on timeout the MPC ring is reset.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
> index 4ea3e67be9f5..2cacce28676d 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c

[ ... ]

> @@ -113,8 +130,13 @@ void bnxt_clear_crypto(struct bnxt *bp)
>   */
>  void bnxt_free_crypto_info(struct bnxt *bp)
>  {
> +	struct bnxt_crypto_info *crypto = bp->crypto_info;
> +
> +	if (!crypto)
> +		return;
>  	bnxt_clear_crypto(bp);
> -	kfree(bp->crypto_info);
> +	kmem_cache_destroy(crypto->mpc_cache);
> +	kfree(crypto);
>  	bp->crypto_info = NULL;
>  }

[High]
Is there a guarantee that no bnxt_xmit_crypto_cmd() caller is still in
flight when bnxt_free_crypto_info() runs?

bnxt_clear_crypto() does not appear to wait for callers currently sleeping
in wait_for_completion_timeout() or in the 200 ms poll inside
bnxt_crypto_timeout(), and there is no refcount or wait_event tying ctx
lifetime to cache destruction.

If a caller is mid-flight during teardown, can kmem_cache_destroy() trigger
the "Slab cache still has objects" warning, and can the surviving caller
later call kmem_cache_free() on a destroyed cache?

> @@ -333,6 +355,90 @@ int bnxt_key_ctx_alloc_one(struct bnxt *bp, struct bnxt_kctx *kctx, u8 kind,
>  	return -EAGAIN;
>  }
>  
> +#define BNXT_CMD_CTX_RETRY_MAX	10
> +
> +static void bnxt_crypto_timeout(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
> +				struct bnxt_crypto_cmd_ctx *ctx)
> +{
> +	int i;
> +
> +	bnxt_mpc_timeout(bp, txr);
> +	/* Wait for the ctx to complete before proceeding */
> +	for (i = 0; i < BNXT_CMD_CTX_RETRY_MAX &&
> +	     !(ctx->status & BNXT_CMD_CTX_COMPLETED); i++)
> +		msleep(20);
> +	if (!(ctx->status & BNXT_CMD_CTX_COMPLETED))
> +		netdev_warn(bp->dev,
> +			    "Timed out waiting for cmd_ctx to complete for MPC ring %d\n",
> +			    txr->txq_index);
> +}

[Critical]
After this 200 ms poll the caller proceeds to kmem_cache_free(ctx)
unconditionally.  Are there paths where bnxt_mpc_timeout() does not
actually clean up ctx->handle from tx_mpc_buf_ring[] within 200 ms, leaving
the freed pointer reachable?

bnxt_mpc_timeout() returns -EINVAL when txr->tx_ring_struct.queue_id is
not BNXT_MPC_QUEUE_ID, and this rc is not checked here:

	int bnxt_mpc_timeout(struct bnxt *bp, struct bnxt_tx_ring_info *txr)
	{
		if (txr->tx_ring_struct.queue_id == BNXT_MPC_QUEUE_ID)
			return bnxt_mpc_ring_reset(bp, txr->txq_index);
		return -EINVAL;
	}

bnxt_mpc_ring_reset() also returns 0 immediately when bnxt_disable_mpc_ring()
loses the race because dev_state was already set:

	if (!bnxt_disable_mpc_ring(mpc, mpc_ring))
		return 0;

In both cases, no bnxt_clear_one_mpc_entries() runs, the loser's poll
exits after 200 ms, and the freed ctx is still pointed to from
tx_mpc_buf_ring[i].handle.  When NAPI later observes the completion (or
the winner's bnxt_clear_one_mpc_entries() iterates), bnxt_crypto_mpc_cmp()
will write ctx->status, memcpy into ctx->ce_cmp, and complete(&ctx->cmp)
on freed slab memory.

Should the timeout path arrange that the handle is removed (or the ctx
guaranteed completed) before kmem_cache_free()?

> +#define BNXT_XMIT_CRYPTO_RETRY_MAX	10
> +#define BNXT_XMIT_CRYPTO_MIN_TMO	100
> +#define BNXT_XMIT_CRYPTO_MAX_TMO	150
> +
> +int bnxt_xmit_crypto_cmd(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
> +			 void *cmd, unsigned int len, unsigned int tmo)
> +{

[ ... ]

> +	tmo_left = wait_for_completion_timeout(&ctx->cmp, msecs_to_jiffies(tmo));
> +	if (!tmo_left) {
> +		netdev_warn(bp->dev, "crypto MP cmd %08x timed out\n",
> +			    *((u32 *)cmd));
> +		bnxt_crypto_timeout(bp, txr, ctx);
> +		rc = -ETIMEDOUT;
> +		goto xmit_done;
> +	}

[Critical]
Even outside the timeout path, is the handshake between bnxt_crypto_mpc_cmp()
and the waiter safe?  bnxt_crypto_mpc_cmp() does:

	ctx = (void *)handle;
	ctx->status = BNXT_CMD_CTX_COMPLETED;
	...
	memcpy(&ctx->ce_cmp, cmpl[0].cmpl, len);
cmp_done:
	complete(&ctx->cmp);

The timeout poll loop above exits as soon as it observes
(ctx->status & BNXT_CMD_CTX_COMPLETED).  If the waiter happened to time
out at exactly the same time as a real completion, can the poll observe
status set by mpc_cmp(), then proceed to kmem_cache_free(ctx) while the
mpc_cmp() side is still inside complete(&ctx->cmp) and is touching
ctx->cmp.wait on another CPU?

[ ... ]

> +xmit_done:
> +	if (rc) {

[ ... ]

> +	if (ctx)
> +		kmem_cache_free(crypto->mpc_cache, ctx);
> +	return rc;
> +}

> +void bnxt_crypto_mpc_cmp(struct bnxt *bp, u32 client, unsigned long handle,
> +			 struct bnxt_cmpl_entry cmpl[], u32 entries)
> +{
> +	struct bnxt_crypto_cmd_ctx *ctx;
> +	struct ce_cmpl *cmp = NULL;
> +	u32 len, kid;
> +
> +	if (likely(cmpl))
> +		cmp = cmpl[0].cmpl;
> +	if (!handle || entries != 1) {
> +		if (entries != 1 && cmpl) {
> +			netdev_warn(bp->dev, "Invalid entries %d with handle %lx cmpl %08x in %s()\n",
> +				    entries, handle, *(u32 *)cmp, __func__);
> +		}
> +		if (!handle)
> +			return;
> +	}
> +	ctx = (void *)handle;
> +	ctx->status = BNXT_CMD_CTX_COMPLETED;

[Medium]
When entries != 1 with a valid cmpl, the function emits a warning and
falls through to set ctx->status = BNXT_CMD_CTX_COMPLETED without setting
BNXT_CMD_CTX_ERROR (BNXT_CMD_CTX_ERROR is only set on the kid/client
mismatch branch below).  The waiter checks:

	if (ctx->status == BNXT_CMD_CTX_COMPLETED &&
	    CE_CMPL_STATUS(&ctx->ce_cmp) == CE_CMPL_STATUS_OK)
		rc = 0;

Should the "invalid entries" branch also OR in BNXT_CMD_CTX_ERROR so that
the caller does not see a successful return for a completion the driver
itself flagged as malformed?

> +	if (unlikely(!cmpl)) {
> +		ctx->status |= BNXT_CMD_CTX_RESET;
> +		goto cmp_done;
> +	}

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
> index 67ba43b7f168..196805c2d972 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c

[ ... ]

> +/* Returns true if the ring is successfully marked as closing. */
> +static bool bnxt_disable_mpc_ring(struct bnxt_mpc_info *mpc, int mpc_ring)
> +{
> +	struct bnxt_tx_ring_info *txr;
> +	bool disabled = false;
> +	int i;
> +
> +	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
> +		if (mpc_ring >= mpc->mpc_ring_count[i])
> +			continue;
> +		txr = &mpc->mpc_rings[i][mpc_ring];
> +		spin_lock_bh(&txr->tx_lock);
> +		if (!READ_ONCE(txr->dev_state)) {
> +			disabled = true;
> +			WRITE_ONCE(txr->dev_state, BNXT_DEV_STATE_CLOSING);
> +		}
> +		spin_unlock_bh(&txr->tx_lock);
> +		if (!disabled)
> +			break;
> +	}
> +	return disabled;
> +}

[ ... ]

> +static void bnxt_clear_one_mpc_entries(struct bnxt *bp,
> +				       struct bnxt_tx_ring_info *txr)
> +{
> +	struct bnxt_sw_mpc_tx_bd *tx_buf;
> +	unsigned long handle;
> +	int i, max_idx;
> +	u32 client;
> +
> +	max_idx = bp->tx_nr_pages * TX_DESC_CNT;
> +
> +	for (i = 0; i < max_idx; i++) {
> +		tx_buf = &txr->tx_mpc_buf_ring[i];
> +		handle = tx_buf->handle;
> +		if (handle) {
> +			client = txr->tx_ring_struct.mpc_chnl_type;
> +			bnxt_crypto_mpc_cmp(bp, client, handle, NULL, 0);
> +			tx_buf->handle = 0;
> +		}
> +	}
> +}

> +static void bnxt_mpc_ring_stop(struct bnxt *bp, struct bnxt_mpc_info *mpc,
> +			       int mpc_ring)
> +{
> +	struct bnxt_tx_ring_info *txr;
> +	struct bnxt_cp_ring_info *cpr;
> +	int i;
> +
> +	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
> +		if (mpc->mpc_ring_count[i] > mpc_ring) {
> +			txr = &mpc->mpc_rings[i][mpc_ring];
> +			bnxt_hwrm_tx_ring_free(bp, txr, true);
> +		}
> +	}
> +	/* CP rings must be freed at the end to guarantee that the HWRM_DONE
> +	 * responses for HWRM_RING_FREE can still be seen on the CP rings.
> +	 */
> +	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
> +		if (mpc->mpc_ring_count[i] > mpc_ring) {
> +			txr = &mpc->mpc_rings[i][mpc_ring];
> +			cpr = txr->tx_cpr;
> +			if (cpr) {
> +				bnxt_hwrm_cp_ring_free(bp, cpr);
> +				bnxt_clear_one_cp_ring(bp, cpr);
> +			}
> +			bnxt_clear_one_mpc_entries(bp, txr);
> +		}
> +	}
> +}

[Critical]
Is bnxt_disable_mpc_ring() sufficient to fence the NAPI poller before the
ring teardown begins?

bnxt_disable_mpc_ring() takes spin_lock_bh(&txr->tx_lock) and flips
dev_state to BNXT_DEV_STATE_CLOSING, but the NAPI consumer in
bnxt_mpc_cmp() reads dev_state with bare READ_ONCE() and never takes
tx_lock:

	mpc_buf = &txr->tx_mpc_buf_ring[RING_TX(bp, tx_cons)];
	if (!READ_ONCE(txr->dev_state))
		handle = mpc_buf->handle;
	mpc_buf->handle = 0;
	...
	bnxt_crypto_mpc_cmp(bp, client, handle, cmpl_entry_arr, cmpl_num);

There is no synchronize_net() / napi_synchronize() between the dev_state
flip and bnxt_mpc_ring_stop()'s teardown.

A NAPI poll already past the READ_ONCE(dev_state) check will have captured
handle = mpc_buf->handle and is about to call bnxt_crypto_mpc_cmp() while,
on another CPU, bnxt_clear_one_mpc_entries() walks tx_mpc_buf_ring,
reads the same still-non-zero tx_buf->handle, and also calls
bnxt_crypto_mpc_cmp() on it.  Two complete()s on the same ctx; if the
waiter freed ctx after the first one, the second is a use-after-free.

Separately, bnxt_clear_one_cp_ring() memset()s cp_desc_ring pages to zero
before NAPI is fenced, so can NAPI observe partially-zeroed completion
entries while iterating?

The L2 close path in bnxt.c uses the explicit pattern of WRITE_ONCE on
dev_state followed by synchronize_net() (with the comment "guarantee no
more DMA on that ring after seeing the completion") before tearing the
ring down.  Should the MPC reset path do the same?

> +static int bnxt_mpc_ring_reset(struct bnxt *bp, int mpc_ring)
> +{
> +	struct bnxt_mpc_info *mpc = bp->mpc_info;
> +	int rc;
> +
> +	if (!mpc)
> +		return 0;
> +	if (mpc_ring >= mpc->mpc_cp_rings)
> +		return -EINVAL;
> +
> +	if (!bnxt_disable_mpc_ring(mpc, mpc_ring))
> +		return 0;

[ ... ]

> +int bnxt_mpc_timeout(struct bnxt *bp, struct bnxt_tx_ring_info *txr)
> +{
> +	if (txr->tx_ring_struct.queue_id == BNXT_MPC_QUEUE_ID)
> +		return bnxt_mpc_ring_reset(bp, txr->txq_index);
> +	return -EINVAL;
> +}

[ ... ]

> @@ -529,14 +693,17 @@ int bnxt_mpc_cmp(struct bnxt *bp, struct bnxt_cp_ring_info *cpr, u32 *raw_cons)
>  		txr = bnapi->tx_mpc_ring[client];
>  		tx_cons = txr->tx_cons;
>  		if (TX_OPAQUE_RING(opaque) != txr->tx_napi_idx)
> -			netdev_warn(bp->dev, "Wrong opaque %x, expected ring %x, idx %x\n",
> +			netdev_warn(bp->dev, "Wrong opaque %x, expected ring %x, cons idx %x\n",
>  				    opaque, txr->tx_napi_idx, txr->tx_cons);
>  		mpc_buf = &txr->tx_mpc_buf_ring[RING_TX(bp, tx_cons)];
> +		if (!READ_ONCE(txr->dev_state))
> +			handle = mpc_buf->handle;
>  		mpc_buf->handle = 0;
>  		tx_cons += mpc_buf->inline_bds;
>  		txr->tx_cons = tx_cons;
>  		txr->tx_hw_cons = RING_TX(bp, tx_cons);
>  	}
> +	bnxt_crypto_mpc_cmp(bp, client, handle, cmpl_entry_arr, cmpl_num);
>  
>  cmp_done:
>  	*raw_cons = tmp_raw_cons;

