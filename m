Return-Path: <netdev+bounces-288539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGvROiPEB2pEHwMAu9opvQ
	(envelope-from <netdev+bounces-288539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:10:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AFB559AEC
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1973C300B589
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CA72C3261;
	Sat, 16 May 2026 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRD/0fQ1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3580B2C0F6D
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778893826; cv=none; b=q3Qa7+cD1amfCOUAizKNP/sYPyYSTl9KY0eIe+Jn1coJCPwe1MXtBOPt0xqXbMwpqDb4Nre3uwdtTGhMk8hNzJd9HdRGBvyzT3X2Q/Xp8Lq8y1swyZeqhKInMKpC+Tv6Sn9MAF7Gcj/rJh2kMiz0rUPARbi/Oc8AkwmnL7WZ7a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778893826; c=relaxed/simple;
	bh=Zg0TEpdWOk8lciyOFYA78IzhFK9IeGsHRQHRqtrsK1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ev4zfyHuIN5Ec5tJxnTNRwvqvTVlMPXBJ6Uo4P/iX+kMcpX3n9YShZWH20gKFeKThh/eYhZFApyFycmqLoVKCwFoM7Ar4rM7L30Q/xD28UNDqS8dWCLOoaNSKF0U/pyUW7rTcW0oeL3M82bGCeg1T9U693boAN8iTBm9Sa7pMkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRD/0fQ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DC1C2BCB0;
	Sat, 16 May 2026 01:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778893826;
	bh=Zg0TEpdWOk8lciyOFYA78IzhFK9IeGsHRQHRqtrsK1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SRD/0fQ1ozx/SAs6ipe84Q6qwPZSPDXwaooNnIcIYbUIwEWGPTWccEuVxZxdi5Jrs
	 sC/3+LtKsGBrZRMTzNTi4uIxGso4JRVFtYc1kC/dEfRgQDAv1fYxvkWkj8zCu/o4Tw
	 4rIC9njGyitxkz7uLeD0ajIydaTW58/hQ5kg3WJ4Szj9/xHsy/jXkpY4YK1jzaFAED
	 lcV1A9aMc0RDNS6ElZ6C3E40xiORy80wYhz0swQ+aVYyb3OhOUKS4M9VnWXd5Zg427
	 IDUOePykpTujwbMfA79Vt1PMbZ+BOJ3XFoGK8qkrArgRdKZscwMV4oTBzr3Pz12F+m
	 uv+BlNV9fsGfA==
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
Subject: Re: [PATCH net-next v2 15/15] bnxt_en: Add kTLS retransmission support
Date: Fri, 15 May 2026 18:10:24 -0700
Message-ID: <20260516011024.1857806-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512212105.3488258-16-michael.chan@broadcom.com>
References: <20260512212105.3488258-16-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D6AFB559AEC
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
	TAGGED_FROM(0.00)[bounces-288539-lists,netdev=lfdr.de];
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
bnxt_en: Add kTLS retransmission support

Adds a TX path for kTLS retransmissions that retrieves the TLS record
covering a retransmitted byte range and emits a presync TX BD carrying
the crypto prefix command so the NIC can re-encrypt the packet. The
patch also adds two new ethtool -S counters (tx_tls_ooo_packets and
tx_tls_drop_no_sync) and reorders the read of txr->tx_prod in
bnxt_start_xmit() so it happens after bnxt_ktls_xmit() may have
advanced the producer.

A few questions on the new code below.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 89c900db45ba..5697190dc541 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -499,7 +499,6 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	txq = netdev_get_tx_queue(dev, i);
>  	txr = &bp->tx_ring[bp->tx_ring_map[i]];
> -	prod = txr->tx_prod;
>  
>  #if (MAX_SKB_FRAGS > TX_MAX_FRAGS)
>  	if (skb_shinfo(skb)->nr_frags > TX_MAX_FRAGS) {
> @@ -532,6 +531,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	if (unlikely(!skb))
>  		return NETDEV_TX_OK;
>  
> +	prod = txr->tx_prod;
>  	length = skb->len;
>  	len = skb_headlen(skb);
>  	last_frag = skb_shinfo(skb)->nr_frags;

[High]
What unwinds the presync BDs if a DMA mapping fails later in
bnxt_start_xmit()?

By the time bnxt_ktls_xmit() returns, bnxt_ktls_tx_ooo() has already
called bnxt_ktls_pre_xmit() which advances txr->tx_prod past the
CRYPTO_PRESYNC_BDS presync entries and (when fwd is true) updates
kctx_tx->tcp_seq_no = end_seq. After that, bnxt_start_xmit() still has
to dma_map_single(skb->data, ...) and skb_frag_dma_map() each fragment.

If either mapping fails, control jumps to tx_dma_error / tx_free /
tx_kick_pending, which clears only the head data BD slot at txr->tx_prod
and does not move tx_prod back past the presync BDs nor revert
kctx_tx->tcp_seq_no.

Once a subsequent successful TX advances tx_prod and rings the doorbell,
won't HW read the orphan presync BDs and apply the captured TLS crypto
state to whichever data BDs follow, even if those belong to an unrelated
packet on the ring?

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index 66b323e94140..769058a6ec31 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -359,6 +359,8 @@ static const char *const bnxt_ring_drv_stats_arr[] = {
>  static const char *const bnxt_ktls_data_stats[] = {
>  	[BNXT_KTLS_TX_PKTS]		= "tx_tls_encrypted_packets",
>  	[BNXT_KTLS_TX_BYTES]		= "tx_tls_encrypted_bytes",
> +	[BNXT_KTLS_TX_OOO_PKTS]		= "tx_tls_ooo_packets",
> +	[BNXT_KTLS_TX_DROP_NO_SYNC]	= "tx_tls_drop_no_sync",
>  };

[Low]
Is the "tx_tls_drop_no_sync" name accurate?  BNXT_KTLS_TX_DROP_NO_SYNC
is bumped in bnxt_ktls_tx_ooo() when tls_get_record() returns NULL or a
record with num_frags == 0, after which -EPROTO is returned and the
caller falls back to tls_encrypt_skb() rather than dropping the packet.
Would something like "tx_tls_resync_no_record" be more descriptive of
what the counter actually counts, given that ethtool -S strings are
hard to rename once shipped?

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
> index 263b075af621..b94418ee5436 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
> @@ -289,6 +289,116 @@ int bnxt_ktls_init(struct bnxt *bp)

[ ... ]

> +static int bnxt_ktls_tx_ooo(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
> +			    struct sk_buff *skb, u32 payload_len, u32 seq,
> +			    struct tls_context *tls_ctx)
> +{
[ ... ]
> +	spin_lock_irqsave(&tx_tls_ctx->lock, flags);
> +	record = tls_get_record(tx_tls_ctx, seq, &rec_sn);
> +	if (!record || !record->num_frags) {
> +		rc = -EPROTO;
> +		sw_stats->tls.counters[BNXT_KTLS_TX_DROP_NO_SYNC]++;
> +		goto unlock_exit;
> +	}
> +	hdr_tcp_seq = tls_record_start_seq(record);
> +	hdr = skb_frag_address_safe(&record->frags[0]);
> +
[ ... ]
> +	if (tls_ctx->prot_info.version == TLS_1_2_VERSION) {
> +		u32 nonce_bytes = tls_ctx->prot_info.iv_size;
> +		u32 retrans_off = seq - hdr_tcp_seq;
> +
> +		if (retrans_off > 5 && retrans_off < 5 + nonce_bytes)
> +			nonce_bytes = retrans_off - 5;
> +		memcpy(pcmd.explicit_nonce, hdr + 5, nonce_bytes);
> +	}

[High]
Can hdr be NULL here?  skb_frag_address_safe() is documented to return
NULL when page_address(page) returns NULL, e.g. for highmem pages on
32-bit kernels with CONFIG_HIGHMEM that have not been kmap'd.

TLS records are allocated via sk_page_frag_refill() with the socket's
GFP flags, which can produce highmem pages, and the existing in-tree
caller in bnxt_start_xmit() does:

	fptr = skb_frag_address_safe(frag);
	if (!fptr)
		goto normal_tx;

For TLS 1.2, hdr + 5 is then dereferenced unconditionally in
memcpy(pcmd.explicit_nonce, hdr + 5, nonce_bytes).  Should there be a
NULL check here too, similar to the bnxt_start_xmit() pattern?

> +	memcpy(&pcmd.record_seq_num[0], &rec_sn, sizeof(rec_sn));

[High]
Does this copy the record sequence number with the byte order the NIC
expects on big-endian hosts?

rec_sn comes from tls_get_record() which returns offload_ctx->
unacked_record_sn, a host-byte-order u64 initialised via
be64_to_cpu(rcd_sn) - 1 in net/tls/tls_device.c and incremented as
plain C arithmetic.  The steady-state setup path bnxt_crypto_add()
populates the same record_seq_num field via bnxt_copy_tls_mp_data()
which is commented "Copy in reverse byte order" and reverses the
wire-format big-endian aes->rec_seq into little-endian.

On a little-endian host memcpy of rec_sn yields LE bytes, which matches
the HW format.  On a big-endian host memcpy yields BE bytes, so the NIC
sees the wrong record sequence number for the AEAD computation on every
retransmission.  Would something like

	__le64 le_rec_sn = cpu_to_le64(rec_sn);
	memcpy(&pcmd.record_seq_num[0], &le_rec_sn, sizeof(le_rec_sn));

be more correct?

> +	rc = 0;
> +	bnxt_ktls_pre_xmit(bp, txr, kctx_tx->kid, &pcmd);
> +
> +	if (fwd)
> +		kctx_tx->tcp_seq_no = end_seq;
> +
> +unlock_exit:
> +	spin_unlock_irqrestore(&tx_tls_ctx->lock, flags);
> +	return rc;
> +}
> +
>  struct sk_buff *bnxt_ktls_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
>  			       struct sk_buff *skb, __le32 *lflags, u32 *kid)
>  {
[ ... ]
> @@ -316,9 +427,18 @@ struct sk_buff *bnxt_ktls_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
>  		sw_stats->tls.counters[BNXT_KTLS_TX_PKTS]++;
>  		sw_stats->tls.counters[BNXT_KTLS_TX_BYTES] += payload_len;
>  	} else {
> -		skb = tls_encrypt_skb(skb);
> -		if (!skb)
> -			return NULL;
> +		sw_stats->tls.counters[BNXT_KTLS_TX_OOO_PKTS]++;
> +
> +		rc = bnxt_ktls_tx_ooo(bp, txr, skb, payload_len, seq, tls_ctx);
> +		if (rc)
> +			return tls_encrypt_skb(skb);
> +
> +		*kid = BNXT_KID_HW(kctx_tx->kid);
> +		*lflags |= cpu_to_le32(TX_BD_FLAGS_CRYPTO_EN |
> +				       BNXT_TX_KID_LO(*kid));
> +		sw_stats->tls.counters[BNXT_KTLS_TX_PKTS]++;
> +		sw_stats->tls.counters[BNXT_KTLS_TX_BYTES] += payload_len;
> +		return skb;
>  	}
>  	return skb;
>  }

[Low]
How is an operator expected to break the OOO counter down by outcome?

BNXT_KTLS_TX_OOO_PKTS is incremented unconditionally before calling
bnxt_ktls_tx_ooo(), so it counts every OOO attempt.  On success the
same packet then bumps BNXT_KTLS_TX_PKTS and BNXT_KTLS_TX_BYTES, while
on -EPROTO it also bumps BNXT_KTLS_TX_DROP_NO_SYNC.

The two SW-fallback cases (-ENOSPC for ring-full and -EOPNOTSUPP for
tag-bearing retransmissions) are not visible in any counter.  Given the
commit message defers tag-bearing retransmissions to future patches,
-EOPNOTSUPP is expected to be the principal SW-fallback cause for now.

Would it make sense to either move the OOO_PKTS increment to the success
branch or add per-failure-cause counters such as
tx_tls_ooo_fallback_no_sync, tx_tls_ooo_fallback_tag_retrans and
tx_tls_ooo_fallback_no_space, before the strings are picked up by
tooling?

