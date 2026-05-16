Return-Path: <netdev+bounces-288538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIavJG/EB2pEHwMAu9opvQ
	(envelope-from <netdev+bounces-288538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:12:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA6C559B02
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B94E302DE23
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2C528640C;
	Sat, 16 May 2026 01:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbpC6x8r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B27E2C0F6D
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 01:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778893824; cv=none; b=r0gUsfGVtjfh0rfMbnAsEUi9BJ3SjnHGejDfKXj5Zhh1poiYOIKs+NBlBOXe+MFzrKY9eondZocUy0RwtROT8EHLxfzXpz6RFXJ/nRmpHoB4WaqnwCf6nIiIS00J2llev1LtMyaJs/983SwkUWQpHUP1Z3FajiH4NWxZosSrlNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778893824; c=relaxed/simple;
	bh=E14QMIfhm3i61vwWsBLH8yga+emppA3qsdoJThtLF+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=peKXFsQxLrrxmc9CWe01FqU5uzUt8SbKl2Hf1vCRcb4KwO4Pd11DdueT0G3A21eOga5Oui5RcSgqddftOfvfx8lz7LZVBphUpRXupmK+0WxwWsR0xVamxapvOomVm4fEnRTT8oRBsNKJc+S9NmDw70IAf0IVn0mx7Z49rh8a3L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbpC6x8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0FFC2BCB0;
	Sat, 16 May 2026 01:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778893824;
	bh=E14QMIfhm3i61vwWsBLH8yga+emppA3qsdoJThtLF+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QbpC6x8rRzqbTlYSxBSF6VcjG/3oFkF2zbXSgVvwbtHKP/MCztlpRERUKKiznuNH3
	 UzfzOFk0jaX7kVj6xPC9TH81K33DiEW+vTE+vUDHytiejx8Aw4QqPunOvINNCtZGTo
	 b8rh2CJ/dR+IUjI4p2r9Z9p+8s8tIG2SfacSwTLlfxmuuRhLO3TWdkUo2F1LFyoWAH
	 3qmec6zP/1U3iBItKgKtTy8aaAO6sQCtZscb5ENBC5MvNd8v+EMQ1WACxHREGZs3NW
	 wYnIRznGMinNr0jEphFMyCA9F25w+SfuTnFHcZkcE8hhMYLfxuU6nQSm8I32hcuwqI
	 /tFDWWskvvZ8g==
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
Subject: Re: [PATCH net-next v2 13/15] bnxt_en: Implement kTLS TX normal path
Date: Fri, 15 May 2026 18:10:23 -0700
Message-ID: <20260516011023.1857772-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512212105.3488258-14-michael.chan@broadcom.com>
References: <20260512212105.3488258-14-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0FA6C559B02
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
	TAGGED_FROM(0.00)[bounces-288538-lists,netdev=lfdr.de];
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
Subject: bnxt_en: Implement kTLS TX normal path

This patch offloads TLS encryption of TX packets to hardware when the
TCP sequence number matches what the driver expects, otherwise falling
back to software encryption.  It also adds the bnxt_ktls_xmit() helper
and basic kTLS counters in ethtool -S.  A few questions inline below.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index e26980814fe7..7cae7e3024ab 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -488,6 +488,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	struct bnxt_sw_tx_bd *tx_buf;
>  	__le32 lflags = 0;
>  	skb_frag_t *frag;
> +	u32 kid = 0;
>  
>  	i = skb_get_queue_mapping(skb);
>  	if (unlikely(i >= bp->tx_nr_rings)) {
> @@ -527,6 +528,10 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  			return NETDEV_TX_BUSY;
>  	}
>  
> +	skb = bnxt_ktls_xmit(bp, txr, skb, &lflags, &kid);
> +	if (unlikely(!skb))
> +		return NETDEV_TX_OK;
> +

[Low]
Should this drop path also bump the device tx_dropped counter?  The
adjacent drop paths in bnxt_start_xmit() (queue out of range, the
skb_linearize() failure, and tx_kick_pending) all call
dev_core_stats_tx_dropped_inc(dev) before returning NETDEV_TX_OK, but
this new branch returns silently.  tls_sw_fallback() has already
freed the original skb when it returns NULL (kmalloc(GFP_ATOMIC) of
sg_in, alloc_skb() of nskb, or fill_sg_in() can each fail), so these
drops would otherwise be invisible in tx_dropped — exactly the
counter operators look at when memory pressure causes TLS fallback to
fail.

>  	length = skb->len;
>  	len = skb_headlen(skb);
>  	last_frag = skb_shinfo(skb)->nr_frags;
> @@ -675,7 +680,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	prod = NEXT_TX(prod);
>  	txbd1 = bnxt_init_ext_bd(bp, txr, prod, lflags, vlan_tag_flags,
> -				 cfa_action);
> +				 cfa_action, kid);
>  
>  	if (skb_is_gso(skb)) {
>  		bool udp_gso = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4);
> @@ -698,7 +703,8 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  					TX_BD_FLAGS_T_IPID |
>  					(hdr_len << (TX_BD_HSIZE_SHIFT - 1)));
>  		length = skb_shinfo(skb)->gso_size;
> -		txbd1->tx_bd_mss = cpu_to_le32(length);
> +		txbd1->tx_bd_kid_mss = cpu_to_le32(BNXT_TX_KID_HI(kid) |
> +						   length);

[Low]
Should length be masked with TX_BD_MSS here?  The patch redefines

    #define TX_BD_MSS                                       0x7fff
    #define TX_BD_KID_HI                                    (0x1ffff << 15)

so the MSS field is now only the low 15 bits of the word, with the KID
HI bits sharing the same 32-bit slot.  BNXT_TX_KID_LO/HI both apply
defensive masks (TX_BD_KID_LO_MASK, TX_BD_KID_HI_MASK) but the
length term in this OR does not.  If gso_size ever has bit 15 or
higher set, those bits spill into KID_HI and corrupt the crypto
context lookup on a TLS packet.  Would something like

    txbd1->tx_bd_kid_mss = cpu_to_le32(BNXT_TX_KID_HI(kid) |
                                       (length & TX_BD_MSS));

or a BUILD_BUG_ON-style guard be appropriate?

>  		length += hdr_len;
>  	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
>  		txbd1->tx_bd_hsize_lflags |=
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index a947b9420a7a..ab3a86634a20 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -101,10 +101,18 @@ struct tx_bd_ext {
>  	#define TX_BD_FLAGS_LSO					(1 << 5)
>  	#define TX_BD_FLAGS_IPID_FMT				(1 << 6)
>  	#define TX_BD_FLAGS_T_IPID				(1 << 7)
> +	#define TX_BD_FLAGS_CRYPTO_EN				(1 << 15)
>  	#define TX_BD_HSIZE					(0xff << 16)
>  	 #define TX_BD_HSIZE_SHIFT				 16

[Low]
Does placing TX_BD_FLAGS_CRYPTO_EN at bit 15 collide with the LSO
hdr_len encoding in bnxt_start_xmit()?  The LSO path writes:

    txbd1->tx_bd_hsize_lflags |= cpu_to_le32(TX_BD_FLAGS_LSO |
                                TX_BD_FLAGS_T_IPID |
                                (hdr_len << (TX_BD_HSIZE_SHIFT - 1)));

with TX_BD_HSIZE_SHIFT == 16, so this is hdr_len << 15.  The LSB of
hdr_len lands directly on bit 15 — the new CRYPTO_EN flag.  Today all
hdr_len sources are even (TCP doff*4, IPv4 base 20, IPv6 40, UDP 8,
Ethernet 14, VLAN 4) so bit 0 is always 0, but the encoding contract
is now fragile — any future encapsulation that yields an odd hdr_len
or a refactor that changes the shift would silently set CRYPTO_EN
with kid=0 on a non-TLS LSO segment.  Would encoding as
((hdr_len >> 1) << TX_BD_HSIZE_SHIFT) (or masking with TX_BD_HSIZE)
make this less prone to future breakage?

> -
> -	__le32 tx_bd_mss;
> +	#define TX_BD_KID_LO					(0x7f << 25)
> +	 #define TX_BD_KID_LO_MASK				 0x7f
> +	 #define TX_BD_KID_LO_SHIFT				 25
> +
> +	__le32 tx_bd_kid_mss;
> +	#define TX_BD_MSS					0x7fff
> +	#define TX_BD_KID_HI					(0x1ffff << 15)
> +	 #define TX_BD_KID_HI_MASK				 0xffff80
> +	 #define TX_BD_KID_HI_SHIFT				 8

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index 11cb1b841359..66b323e94140 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -653,6 +682,16 @@ static void bnxt_get_ethtool_stats(struct net_device *dev,
>  	for (i = 0; i < BNXT_NUM_RING_DRV_STATS; i++, j++, curr++, prev++)
>  		buf[j] = *curr + *prev;
>  
> +	if (bp->ktls_info) {
> +		struct bnxt_tls_info *ktls = bp->ktls_info;
> +		struct bnxt_tls_sw_stats tls_stats = {};
> +
> +		bnxt_get_ring_tls_stats(bp, &tls_stats);
> +		for (i = 0; i < ARRAY_SIZE(bnxt_ktls_data_stats); i++, j++)
> +			buf[j] = tls_stats.counters[i];
> +		for (i = 0; i < ARRAY_SIZE(bnxt_ktls_ctrl_stats); i++, j++)
> +			buf[j] = atomic64_read(&ktls->counters[i]);
> +	}

[High]
Can this block dereference a freed bp->bnapi when ethtool -S runs on
a closed interface?  The function starts with:

    if (!bp->bnapi) {
        j += bnxt_get_num_ring_stats(bp);
        goto skip_ring_stats;
    }

skip_ring_stats:
    [ ... existing ring drv stats accumulator ... ]

    if (bp->ktls_info) {
        ...
        bnxt_get_ring_tls_stats(bp, &tls_stats);

bp->bnapi is freed and cleared in bnxt_free_mem() during interface
close, but bp->ktls_info has a longer lifetime — it is allocated at
probe and freed only at remove.  The new ktls block sits after the
skip_ring_stats label, so it executes even when the !bp->bnapi guard
fired.  bnxt_get_ring_tls_stats() then loops bp->cp_nr_rings (which
is not zeroed on close) and dereferences bp->bnapi[i]:

    for (i = 0; i < bp->cp_nr_rings; i++) {
        ring_stats = &bp->bnapi[i]->cp_ring.sw_stats->tls;

Should the ktls block be guarded by the same bp->bnapi check, and/or
should bnxt_get_ring_tls_stats() bail out when bp->bnapi is NULL?

>  	if (bp->flags & BNXT_FLAG_PORT_STATS) {
>  		u64 *port_stats = bp->port_stats.sw_stats;
>  
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
> index ac5d927ded1c..263b075af621 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
> @@ -287,3 +288,51 @@ int bnxt_ktls_init(struct bnxt *bp)
>  	dev->features |= NETIF_F_HW_TLS_TX;
>  	return 0;
>  }
> +
> +struct sk_buff *bnxt_ktls_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
> +			       struct sk_buff *skb, __le32 *lflags, u32 *kid)
> +{
> +	struct bnxt_sw_stats *sw_stats = txr->tx_cpr->sw_stats;
> +	struct bnxt_tls_info *ktls = bp->ktls_info;
> +	struct bnxt_ktls_offload_ctx_tx *kctx_tx;
> +	struct tls_context *tls_ctx;
> +	u32 seq, payload_len;
> +
> +	if (!IS_ENABLED(CONFIG_TLS_DEVICE) || !ktls ||
> +	    !tls_is_skb_tx_device_offloaded(skb))
> +		return skb;
> +
> +	seq = ntohl(tcp_hdr(skb)->seq);
> +	tls_ctx = tls_get_ctx(skb->sk);
> +	kctx_tx = __tls_driver_ctx(tls_ctx, TLS_OFFLOAD_CTX_DIR_TX);
> +	payload_len = skb->len - skb_tcp_all_headers(skb);
> +	if (!payload_len)
> +		return skb;
> +	if (kctx_tx->tcp_seq_no == seq) {
> +		kctx_tx->tcp_seq_no += payload_len;
> +		*kid = BNXT_KID_HW(kctx_tx->kid);
> +		*lflags |= cpu_to_le32(TX_BD_FLAGS_CRYPTO_EN |
> +				       BNXT_TX_KID_LO(*kid));
> +		sw_stats->tls.counters[BNXT_KTLS_TX_PKTS]++;
> +		sw_stats->tls.counters[BNXT_KTLS_TX_BYTES] += payload_len;

[High]
Can advancing kctx_tx->tcp_seq_no here desynchronise driver and HW
state if the packet is dropped later in bnxt_start_xmit()?  The
sequence and stats are bumped before the BD is built, but the caller
can still drop the skb after this returns — skb_pad() failure goes to
tx_kick_pending, dma_map_single() failure to tx_free, the
bnxt_lhint_arr oversize check and skb_frag_dma_map() failure to
tx_dma_error.  On any of those drops the BD never reaches HW, so the
HW-side TCP sequence variable remains at the old position, while the
driver-tracked kctx_tx->tcp_seq_no has already advanced by
payload_len.

The next aligned TLS data send will then hit:

    if (kctx_tx->tcp_seq_no == seq) {
        ...
        *lflags |= cpu_to_le32(TX_BD_FLAGS_CRYPTO_EN | ...);

with seq matching the inflated tracker, so the driver flags it as
in-order and HW encrypts from a stale TLS record state.  The follow-up
patch that adds bnxt_ktls_tx_ooo() handles seq < kctx_tx->tcp_seq_no
via tls_get_record(), but does not appear to detect this driver-ahead
case.

Would it be safer to defer the kctx_tx->tcp_seq_no advance and the
counter updates until after the BD is committed (near the doorbell),
or to roll them back on the failure paths?

[Medium]
Are these u64 increments safe against concurrent xmit on different TX
queues that share the same sw_stats?  bnxt_alloc_cp_rings() aliases
all sub-CP rings of a bnapi:

    cpr2->sw_stats = cpr->sw_stats;

so multiple bnxt_tx_ring_info entries in one bnapi have distinct
txr->tx_cpr but the same txr->tx_cpr->sw_stats.  Different netdev TX
queues hold different __netif_tx_lock instances, so two CPUs can
transmit concurrently on TX queues mapped to the same bnapi and race
on these counters with plain ++ and +=.  The reader
bnxt_get_ring_tls_stats() also reads them from process context with
no synchronisation, and on 32-bit the BNXT_KTLS_TX_BYTES u64 update
is a torn read/write.  The pre-existing bnxt_sw_stats fields are only
written from a single NAPI context per bnapi, which is why the
aliasing was previously safe; the new TLS counters introduce a new
multi-writer pattern.

Would u64_stats_sync (or per-CPU + SNMP_ADD_STATS64-style helpers) be
more appropriate here, in line with the networking guidance for
shared per-bnapi 64-bit counters?

> +	} else {
> +		skb = tls_encrypt_skb(skb);
> +		if (!skb)
> +			return NULL;
> +	}
> +	return skb;
> +}
> +
> +void bnxt_get_ring_tls_stats(struct bnxt *bp, struct bnxt_tls_sw_stats *stats)
> +{
> +	struct bnxt_tls_sw_stats *ring_stats;
> +	int i, j;
> +
> +	if (!bp->ktls_info)
> +		return;
> +	for (i = 0; i < bp->cp_nr_rings; i++) {
> +		ring_stats = &bp->bnapi[i]->cp_ring.sw_stats->tls;
> +		for (j = 0; j < BNXT_KTLS_MAX_DATA_COUNTERS; j++)
> +			stats->counters[j] += ring_stats->counters[j];
> +	}
> +}

[ ... ]

