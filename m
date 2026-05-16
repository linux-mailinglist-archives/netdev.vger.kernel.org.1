Return-Path: <netdev+bounces-288535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FRlLybEB2pEHwMAu9opvQ
	(envelope-from <netdev+bounces-288535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:11:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6E0559AF3
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83B67302444B
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDD02857CC;
	Sat, 16 May 2026 01:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2JI3Lfe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3A7283C87
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 01:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778893821; cv=none; b=IdyRBYO0Gd/l/9SEobtB1sI02yaqGe4IsVOLBHbVF6lPjXseqkbADRC9SwZYZMRMhixklRAf30KkiRidQV/y2MamhJSXnabAXxHtzyGJuoPVBGb30BTDZjCvXNDwpa1xkxr5gX33RXb/Upg2QuGMMsjbfoPfx+OBOnOpB7JelWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778893821; c=relaxed/simple;
	bh=oZ/NOvr1/PPoKz+uYns9VUh5Swe4mjdVx1IixnxnjaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T8NRZJ+ecyTiJRhDMHLOH5h1GOHeDc43WmTmX2C0jV85YINtSZcC/HZpoQkaDUkiu48AKEwWV1CUjFtJxvp1D1378aR1xdW75abUnZJik+fBY5nnoJJE1aJVl18cE58kH0Yf7KMaG2AoSOcDx1UWf4iXiBSzMVeLRAfwBmA8vco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2JI3Lfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBC6C2BCB7;
	Sat, 16 May 2026 01:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778893820;
	bh=oZ/NOvr1/PPoKz+uYns9VUh5Swe4mjdVx1IixnxnjaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T2JI3Lfeh1G2Q+iFsw4rcl3f52OQydNAUjHj/SxkFQnrf32IlL7xc70JCqLjJt3iP
	 77asVkG/BL/qSOPedUAcJOr1PUgbEVEkiME5Ej9qcyPGVwxf5kQ5q61iewGVGVYiOT
	 7gCfMslwvY8o49HKmZh+Tou+7G6pqp81M6rOc+aMkJ8ez49h+9xHSsA6N0rRAUlZt8
	 Bscguc1NE4j844F4H1onN/L2ZJhdWRcNuko68GkwFGdQTuSDQWrr9qmLTrUdHIa4vc
	 YwMF5YJ87zmRzCrgA0n64PdgHSaRpnivWprRDTrLNa8lYrm4HfzL2PwkqMUGlxER2E
	 Sp/aBDxJs2SYw==
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
Subject: Re: [PATCH net-next v2 10/15] bnxt_en: Add MPC transmit and completion functions
Date: Fri, 15 May 2026 18:10:18 -0700
Message-ID: <20260516011019.1857679-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512212105.3488258-11-michael.chan@broadcom.com>
References: <20260512212105.3488258-11-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5B6E0559AF3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288535-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
bnxt_en: Add MPC transmit and completion functions

This patch adds transmit, ring selection, and completion handling
helpers for the bnxt midpath rings (MPC), to be used for sending
control data to the crypto engines.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 4f5de41d4e86..a772b86842c1 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
> index a121bdcf9686..67ba43b7f168 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
> @@ -404,3 +404,141 @@ void bnxt_hwrm_mpc_ring_free(struct bnxt *bp, bool close_path)

[ ... ]

> +int bnxt_start_xmit_mpc(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
> +			void *data, unsigned int len, unsigned long handle)
> +{

[ ... ]

> +	memcpy(txbd, data, len);
> +	prod += bds;
> +	txr->tx_prod = prod;

[Low]
The rest of the bnxt tx fast paths consistently use WRITE_ONCE() when
updating txr->tx_prod and txr->tx_cons, since bnxt_tx_avail() reads both
with READ_ONCE():

    static inline u32 bnxt_tx_avail(struct bnxt *bp,
                                    const struct bnxt_tx_ring_info *txr)
    {
            u32 used = READ_ONCE(txr->tx_prod) - READ_ONCE(txr->tx_cons);
            ...
    }

The new MPC paths use plain stores for txr->tx_prod here in
bnxt_start_xmit_mpc() and for txr->tx_cons in bnxt_mpc_cmp() (below).

Since bnxt_mpc_cmp() runs in NAPI context without tx_lock, while the
producer side (in a follow-up patch) takes tx_lock around
bnxt_start_xmit_mpc(), the producer's READ_ONCE(tx_cons) inside
bnxt_tx_avail() is paired with the consumer's plain store, which would
be flagged by KCSAN.

Should these stores use WRITE_ONCE() to match the convention in the rest
of the driver?

> +
> +	/* Sync BD data before updating doorbell */
> +	wmb();
> +	bnxt_db_write(bp, &txr->tx_db, prod);
> +
> +	return 0;
> +}
> +
> +static bool bnxt_mpc_unsolicit(struct mpc_cmp *mpcmp)
> +{
> +	u32 client = MPC_CMP_CLIENT_TYPE(mpcmp);
> +
> +	if (client != MPC_CMP_CLIENT_TCE && client != MPC_CMP_CLIENT_RCE)
> +		return false;
> +	return MPC_CMP_UNSOLICIT_SUBTYPE(mpcmp);
> +}

[Medium]
The header in this same patch declares three subtypes:

    #define MPC_CMP_SUBTYPE_SOLICITED    (0x0 << 8)
    #define MPC_CMP_SUBTYPE_ERR          (0x1 << 8)
    #define MPC_CMP_SUBTYPE_RESYNC       (0x2 << 8)

but MPC_CMP_UNSOLICIT_SUBTYPE() only matches MPC_CMP_SUBTYPE_ERR:

    #define MPC_CMP_UNSOLICIT_SUBTYPE(mpcmp)                          \
            ((le32_to_cpu((mpcmp)->mpc_cmp_client_subtype_type) &     \
             MPC_CMP_SUBTYPE) == MPC_CMP_SUBTYPE_ERR)

Should a RESYNC completion (which by name is not a response to a host
TX) also be treated as unsolicited? As written, bnxt_mpc_unsolicit()
returns false on RESYNC and bnxt_mpc_cmp() then advances tx_cons and
clears mpc_buf->handle for a slot the host never submitted.

Would a check like != MPC_CMP_SUBTYPE_SOLICITED (or matching both ERR
and RESYNC) be more in line with the macro name and the defined
subtypes?

> +
> +int bnxt_mpc_cmp(struct bnxt *bp, struct bnxt_cp_ring_info *cpr, u32 *raw_cons)
> +{

[ ... ]

> +	if (!bnxt_mpc_unsolicit(mpcmp)) {
> +		struct bnxt_sw_mpc_tx_bd *mpc_buf;
> +		struct bnxt_tx_ring_info *txr;
> +		u16 tx_cons;
> +		u32 opaque;
> +
> +		opaque = mpcmp->mpc_cmp_opaque;
> +		txr = bnapi->tx_mpc_ring[client];
> +		tx_cons = txr->tx_cons;
> +		if (TX_OPAQUE_RING(opaque) != txr->tx_napi_idx)
> +			netdev_warn(bp->dev, "Wrong opaque %x, expected ring %x, idx %x\n",
> +				    opaque, txr->tx_napi_idx, txr->tx_cons);
> +		mpc_buf = &txr->tx_mpc_buf_ring[RING_TX(bp, tx_cons)];
> +		mpc_buf->handle = 0;
> +		tx_cons += mpc_buf->inline_bds;
> +		txr->tx_cons = tx_cons;
> +		txr->tx_hw_cons = RING_TX(bp, tx_cons);
> +	}

[Medium]
When the opaque ring index returned by the device does not match the
locally-resolved txr (TX_OPAQUE_RING(opaque) != txr->tx_napi_idx),
control just falls through after netdev_warn() and the code still
dereferences txr->tx_mpc_buf_ring[RING_TX(bp, tx_cons)], clears
mpc_buf->handle, and advances txr->tx_cons by mpc_buf->inline_bds.

If this check ever fires (HW bug, memory corruption, compromised
firmware), would the driver be corrupting its own ring bookkeeping for
the locally-resolved txr — clearing a handle for a buffer that was not
actually completed and skipping over slots whose handles are then never
released?

Given that handle holds a kernel pointer/cookie used by the crypto
path, should this branch return early (or otherwise avoid touching
tx_cons / tx_mpc_buf_ring) instead of continuing as if the completion
were valid?

[Low]
Same WRITE_ONCE() concern as in bnxt_start_xmit_mpc() — txr->tx_cons is
written here with a plain store while producers read it via
READ_ONCE(txr->tx_cons) in bnxt_tx_avail(). Should this be
WRITE_ONCE(txr->tx_cons, tx_cons) for consistency with the rest of the
driver?

> +
> +cmp_done:
> +	*raw_cons = tmp_raw_cons;
> +	return 0;
> +}
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
> index cdc03a074963..9958d1749ffb 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
> @@ -30,11 +30,53 @@ struct bnxt_mpc_info {

[ ... ]

> +struct mpc_cmp {
> +	__le32 mpc_cmp_client_subtype_type;
> +	#define MPC_CMP_TYPE					(0x3f << 0)
> +	 #define MPC_CMP_TYPE_MID_PATH_SHORT			 0x1e
> +	 #define MPC_CMP_TYPE_MID_PATH_LONG			 0x1f
> +	#define MPC_CMP_SUBTYPE					0xf00
> +	#define MPC_CMP_SUBTYPE_SFT				 8
> +	 #define MPC_CMP_SUBTYPE_SOLICITED			 (0x0 << 8)
> +	 #define MPC_CMP_SUBTYPE_ERR				 (0x1 << 8)
> +	 #define MPC_CMP_SUBTYPE_RESYNC				 (0x2 << 8)

[ ... ]

> +#define MPC_CMP_UNSOLICIT_SUBTYPE(mpcmp)				\
> +	((le32_to_cpu((mpcmp)->mpc_cmp_client_subtype_type) &		\
> +	 MPC_CMP_SUBTYPE) == MPC_CMP_SUBTYPE_ERR)

[ ... ]

