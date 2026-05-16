Return-Path: <netdev+bounces-288537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLKkMBjEB2pEHwMAu9opvQ
	(envelope-from <netdev+bounces-288537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:10:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A895B559ADD
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64C8E300F5C4
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8517B2C0282;
	Sat, 16 May 2026 01:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dM7B5qXR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632912C0261
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 01:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778893823; cv=none; b=plBwdK7VMZ4HAYFAq6+9LY/F8wReneY9j3eMNVhXMBW+Kr+Bx+IKnvWr2mSHa9+qaVggE+Sg1f5CiRJYo3/sYKSc6LIHOJcH39aDrcFCddvttEMNz1tJiRvnM+ca/J8EVPonsuJMCdbxxqWny86czQZj1ymMF2lx5zxBLSE6sIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778893823; c=relaxed/simple;
	bh=AM59XG4Otlk4khYBwCzeeUmN/SmH91uktopRz8ft4hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7Bjv4qAtwo+hX077NdAinuJgvEVA0GWtY4XLHZWAOnmWj1e1ekWFFtyXyuJEZZaxKutaJIOy8qlhaMW+dhcEDgT1+MzGAsFXfP9Xqa7lJb0vQheixp+htUWW8YkAFUoa0vA7J9CZjVJTda5AMTAm6jC/bR0HejN6fpBgyvApJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dM7B5qXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7896C2BCB0;
	Sat, 16 May 2026 01:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778893823;
	bh=AM59XG4Otlk4khYBwCzeeUmN/SmH91uktopRz8ft4hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dM7B5qXR/egKFr0js7D8yHJYiDGn4OEl7MEka1Ok6gNz6CzLJVDj9Bb2QRnHJ6p0m
	 5M/UdSk06e2SRVkO/kc7U524SbxbIZ8sAGsOBDPteSgXSXuQUCoOCeG3Q20jtyH6/C
	 pcm97WHUEHnVCsqrcmxlrZs2e4CGxrTQntZf02+ZtgRbvgSGo5wrXzmw0aHrx4EOLQ
	 rCUDUeRJBb5Nh3wc3EJZnGqGxjP4RK72JJ0qVgwz0GUbl2a0GlIsFHrFx/+DlVF8Gu
	 jnF0ZtSGjjgj7x5U15Q4BHfiWQSVS2UH9F5B5lUdvog1ZZA67MFwltXUKcDwAWQyhx
	 3eC5Lijq9mhRw==
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
Subject: Re: [PATCH net-next v2 12/15] bnxt_en: Support kTLS TX offload by implementing .tls_dev_add/del()
Date: Fri, 15 May 2026 18:10:22 -0700
Message-ID: <20260516011022.1857741-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512212105.3488258-13-michael.chan@broadcom.com>
References: <20260512212105.3488258-13-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A895B559ADD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288537-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
bnxt_en: Support kTLS TX offload by implementing .tls_dev_add/del()

This patch adds the basic infrastructure for kTLS TX offload in bnxt_en
by allocating and freeing kTLS context IDs (KIDs) via MPC commands, and
introduces bnxt_ktls_init() that wires bnxt_ktls_ops onto the netdev for
later use.

A few questions follow inline.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 74935b119569..e26980814fe7 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

[ ... ]

> @@ -13491,6 +13493,7 @@ static int bnxt_close(struct net_device *dev)
>  {
>  	struct bnxt *bp = netdev_priv(dev);
>  
> +	bnxt_crypto_del_all(bp);
>  	bnxt_close_nic(bp, true, true);
>  	bnxt_hwrm_shutdown_link(bp);
>  	bnxt_hwrm_if_change(bp, false);

[High]
Is the placement of bnxt_crypto_del_all() before bnxt_close_nic() safe
against concurrent tls_dev_add/tls_dev_del?

At this point BNXT_STATE_OPEN is still set and the pending counter has not
been drained yet (that happens inside __bnxt_close_nic()). The net/tls
core only holds device_offload_lock for read on the add path and does not
synchronize with .ndo_stop, so bnxt_ktls_dev_add() can run in parallel
with bnxt_crypto_del_all() and call into bnxt_key_ctx_alloc_one(), which
modifies kctx->list with list_add_tail_rcu() under kctx->lock.

bnxt_crypto_del_all() walks the same list with plain list_for_each_entry()
(no rcu_read_lock, no kctx->lock), while the alloc/free helpers explicitly
use list_*_rcu primitives:

> +void bnxt_crypto_del_all(struct bnxt *bp)
> +{
> +	struct bnxt_crypto_info *crypto = bp->crypto_info;
> +	struct bnxt_kid_info *kid;
> +	struct bnxt_kctx *kctx;
> +	int i;
> +
> +	if (!crypto)
> +		return;
> +
> +	/* Shutting down, no need to protect the lists. */
> +	for (i = 0; i < BNXT_MAX_CRYPTO_KEY_TYPE; i++) {
> +		kctx = &crypto->kctx[i];
> +		list_for_each_entry(kid, &kctx->list, list)
> +			bnxt_crypto_del_all_kids(bp, kid);
> +		kctx->epoch++;
> +	}
> +}

The "Shutting down, no need to protect the lists" comment seems to assume
no concurrent mutation, but with this call site preceding the OPEN-flag
clear and pending-drain, can a concurrent tls_dev_add insert a new kid
mid-traversal? The same applies to the call from bnxt_fw_reset_close()
below.

A second concern is in bnxt_crypto_del_all_kids():

> +static void bnxt_crypto_del_all_kids(struct bnxt *bp, struct bnxt_kid_info *kid)
> +{
> +	int i, rc;
> +
> +	for (i = 0; i < kid->count; i++) {
> +		if (!test_bit(i, kid->ids)) {
> +			rc = bnxt_crypto_del(bp, kid->type, kid->kind,
> +					     kid->start_id + i);
> +			if (!rc)
> +				set_bit(i, kid->ids);
> +		}
> +	}
> +}

The sequence test_bit(i) -> bnxt_crypto_del() (which can sleep inside
bnxt_xmit_crypto_cmd()) -> set_bit(i) is not atomic. If a concurrent
bnxt_free_one_kctx() does set_bit(i) and a subsequent bnxt_alloc_one_kctx()
reissues the same KID via test_and_clear_bit(i) during that sleep, can the
trailing set_bit() in this loop then mark an in-use slot as free, so the
next allocation hands the same KID out to a second TLS socket?

> @@ -14567,6 +14570,7 @@ static void bnxt_fw_reset_close(struct bnxt *bp)
>  			bp->fw_reset_min_dsecs = 0;
>  		bnxt_fw_fatal_close(bp);
>  	}
> +	bnxt_crypto_del_all(bp);
>  	__bnxt_close_nic(bp, true, false);
>  	bnxt_vf_reps_free(bp);
>  	bnxt_clear_int_mode(bp);

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
> new file mode 100644

[ ... ]

> +static int bnxt_crypto_add(struct bnxt *bp, enum tls_offload_ctx_dir direction,
> +			   struct tls_crypto_info *crypto_info, u32 tcp_seq_no,
> +			   u32 kid)
> +{
> +	struct bnxt_tx_ring_info *txr;
> +	struct ce_add_cmd cmd = {0};
> +	u32 data;
> +
> +	if (direction == TLS_OFFLOAD_CTX_DIR_TX) {
> +		txr = bnxt_select_mpc_ring(bp, BNXT_MPC_TCE_TYPE);
> +		cmd.ctx_kind = CE_ADD_CMD_CTX_KIND_CK_TX;
> +	} else {
> +		return -EOPNOTSUPP;
> +	}
> +	if (!txr)
> +		return -ENODEV;
> +
> +	data = CE_ADD_CMD_OPCODE_ADD | (BNXT_KID_HW(kid) << CE_ADD_CMD_KID_SFT);
> +	switch (crypto_info->cipher_type) {
> +	case TLS_CIPHER_AES_GCM_128: {
> +		struct tls12_crypto_info_aes_gcm_128 *aes;
> +
> +		aes = (void *)crypto_info;
> +		data |= CE_ADD_CMD_ALGORITHM_AES_GCM_128;
> +		if (crypto_info->version == TLS_1_3_VERSION)
> +			data |= CE_ADD_CMD_VERSION_TLS1_3;
> +		memcpy(&cmd.session_key, aes->key, sizeof(aes->key));
> +		memcpy(&cmd.salt, aes->salt, sizeof(aes->salt));
> +		memcpy(&cmd.addl_iv, aes->iv, sizeof(aes->iv));
> +		bnxt_copy_tls_mp_data(cmd.record_seq_num, aes->rec_seq,
> +				      sizeof(aes->rec_seq));
> +		break;
> +	}
> +	case TLS_CIPHER_AES_GCM_256: {
> +		struct tls12_crypto_info_aes_gcm_256 *aes;
> +
> +		aes = (void *)crypto_info;
> +		data |= CE_ADD_CMD_ALGORITHM_AES_GCM_256;
> +		if (crypto_info->version == TLS_1_3_VERSION)
> +			data |= CE_ADD_CMD_VERSION_TLS1_3;
> +		memcpy(&cmd.session_key, aes->key, sizeof(aes->key));
> +		memcpy(&cmd.salt, aes->salt, sizeof(aes->salt));
> +		memcpy(&cmd.addl_iv, aes->iv, sizeof(aes->iv));
> +		bnxt_copy_tls_mp_data(cmd.record_seq_num, aes->rec_seq,
> +				      sizeof(aes->rec_seq));
> +		break;
> +	}
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	cmd.ver_algo_kid_opcode = cpu_to_le32(data);
> +	cmd.pkt_tcp_seq_num = cpu_to_le32(tcp_seq_no);
> +	cmd.tls_header_tcp_seq_num = cmd.pkt_tcp_seq_num;
> +	return bnxt_xmit_crypto_cmd(bp, txr, &cmd, sizeof(cmd),
> +				    BNXT_MPC_TMO_MSECS);
> +}

[High]
The cmd buffer here is on the kernel stack and ends up holding a
cleartext copy of the AES-GCM session key in cmd.session_key. After
bnxt_xmit_crypto_cmd() returns, the function returns without zeroing the
buffer, so the key bytes remain in the freed stack frame until they are
overwritten.

Should this end with a memzero_explicit(&cmd, sizeof(cmd)) before
returning, similar to how mlx5e_ktls_add_tx() clears its key material?

[ ... ]

> +static int bnxt_ktls_dev_add(struct net_device *dev, struct sock *sk,
> +			     enum tls_offload_ctx_dir direction,
> +			     struct tls_crypto_info *crypto_info,
> +			     u32 start_offload_tcp_sn)
> +{
> +	struct bnxt_ktls_offload_ctx_tx *kctx_tx;
> +	struct bnxt *bp = netdev_priv(dev);
> +	struct bnxt_crypto_info *crypto;
> +	struct tls_context *tls_ctx;
> +	struct bnxt_tls_info *ktls;
> +	struct bnxt_kctx *kctx;
> +	u32 kid;
> +	int rc;
> +
> +	BUILD_BUG_ON(sizeof(struct bnxt_ktls_offload_ctx_tx) >
> +		     TLS_DRIVER_STATE_SIZE_TX);
> +
> +	ktls = bp->ktls_info;
> +	if (direction == TLS_OFFLOAD_CTX_DIR_RX)
> +		return -EOPNOTSUPP;
> +
> +	if (!bnxt_ktls_cipher_supported(bp, crypto_info)) {
> +		atomic64_inc(&ktls->counters[BNXT_KTLS_ERR_INVALID_CIPHER]);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	atomic_inc(&ktls->pending);
> +	/* Make sure bnxt_close_nic() sees pending before we check the
> +	 * BNXT_STATE_OPEN flag.
> +	 */
> +	smp_mb__after_atomic();
> +	if (!test_bit(BNXT_STATE_OPEN, &bp->state)) {
> +		atomic64_inc(&ktls->counters[BNXT_KTLS_ERR_STATE_NOT_OPEN]);
> +		rc = -ENODEV;
> +		goto exit;
> +	}

[Medium, Low]
Two related questions about the ktls dereferences in this function.

bp->ktls_info is read once into ktls and then immediately dereferenced
without a NULL guard. bnxt_ktls_init() (in a later patch in this series)
only assigns dev->tlsdev_ops when bp->ktls_info is non-NULL, but does the
driver ever clear dev->tlsdev_ops on teardown? bnxt_free_ktls_info()
sets bp->ktls_info = NULL and is reachable from the FW-reset path via
__bnxt_hwrm_func_qcaps() -> bnxt_alloc_crypto_info() -> bnxt_free_*
without unregistering the netdev. Can a tls_dev_add arriving in that
window dereference NULL?

Separately, the comment on smp_mb__after_atomic() says "pending is the
gate that protects ktls" but the BNXT_KTLS_ERR_INVALID_CIPHER counter is
incremented before atomic_inc(&ktls->pending). Should that counter
update be moved past the pending barrier so it follows the same
ordering as the other ktls dereferences in this function?

[ ... ]

> +#define KTLS_RETRY_MAX	100
> +
> +static void bnxt_ktls_dev_del(struct net_device *dev,
> +			      struct tls_context *tls_ctx,
> +			      enum tls_offload_ctx_dir direction)
> +{
> +	struct bnxt_ktls_offload_ctx_tx *kctx_tx;
> +	struct bnxt *bp = netdev_priv(dev);
> +	struct bnxt_crypto_info *crypto;
> +	struct bnxt_tls_info *ktls;
> +	struct bnxt_kctx *kctx;
> +	int retry_cnt = 0;
> +	u8 kind;
> +	u32 kid;
> +
> +	ktls = bp->ktls_info;
> +retry:
> +	while (!test_bit(BNXT_STATE_OPEN, &bp->state)) {
> +		if (!netif_running(dev))
> +			return;
> +		/* Prevent infinite loop if device is down but netif_running()
> +		 * returns true.
> +		 */
> +		if (retry_cnt > KTLS_RETRY_MAX) {
> +			atomic64_inc(&ktls->counters[BNXT_KTLS_ERR_RETRY_EXCEEDED]);
> +			netdev_warn(dev, "%s retry max %d exceeded, state %lx\n",
> +				    __func__, retry_cnt, bp->state);
> +			return;
> +		}
> +		retry_cnt++;
> +		msleep(100);
> +	}

[High]
This loop can sleep up to 100 * 100 ms = ~10 seconds while holding
device_offload_lock from the net/tls caller. tls_device_down() takes
that lock for write and walks every offloaded TLS context on the netdev,
so a FW-reset that overlaps teardown of N TLS sockets could multiply the
delay across all of them and stall every other tls_set_device_offload()
on the system for that period.

Could this be coupled to the FW-reset completion path via wait_event()
or a completion instead of an open-coded msleep retry on a state bit?

The fixed retry budget also means that if the device stays out of
BNXT_STATE_OPEN longer than ~10 seconds, the function returns having
done nothing -- the HW key context stays programmed and the in-driver
KID slot is leaked until driver unload. Is that intended, and where is
the leaked slot reclaimed in that case?

[ ... ]

> +	crypto = bp->crypto_info;
> +	kctx_tx = __tls_driver_ctx(tls_ctx, TLS_OFFLOAD_CTX_DIR_TX);
> +	kid = kctx_tx->kid;
> +	kctx = &crypto->kctx[BNXT_TX_CRYPTO_KEY_TYPE];
> +	kind = BNXT_CTX_KIND_CK_TX;
> +	atomic64_inc(&ktls->counters[BNXT_KTLS_TX_DEL]);
> +	if (bnxt_kid_valid(kctx, kid) &&
> +	    !bnxt_crypto_del(bp, kctx->type, kind, kid))
> +		bnxt_free_one_kctx(kctx, kid);
> +
> +	atomic_dec(&ktls->pending);
> +}

[Medium]
bnxt_free_one_kctx() is only called when bnxt_crypto_del() returns 0.
bnxt_crypto_del() can return -ENODEV when bnxt_select_mpc_ring() returns
NULL, and any nonzero value from bnxt_xmit_crypto_cmd() (timeout, MPC
ring busy, completion error, allocation failure).

In all of those cases the bit corresponding to this KID in kid->ids is
never cleared back to "free", so the slot stays consumed. The close-time
fallback bnxt_crypto_del_all_kids() also only sets the bit on rc == 0,
so it does not reclaim slots that fail repeatedly either.

Can the KID pool slowly drain over runtime ifdown/ifup cycles with
intermittent MPC errors? Should the slot be released on the local side
even when the HW delete command fails?

[ ... ]

