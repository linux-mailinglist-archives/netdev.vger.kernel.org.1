Return-Path: <netdev+bounces-251272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC8CD3B789
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D39A3016F98
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B062DB786;
	Mon, 19 Jan 2026 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfxHnXWv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC092DAFA4;
	Mon, 19 Jan 2026 19:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768851957; cv=none; b=dNv2NM92ULTUv1eO8DZHzZWLsKd/o1tUHHGdpjPGF9gz4cpwjDKYZ5XUVp+VJb+4wj5K2hsl95H1c9NMieRtFCJ9rKTC9Awd10c+dgGAw+HNj9R5N7z8BmjsooX19A26nv3VbNQk71SodtsVBgLhUxDTSf7QJYhxzCLEdQK35ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768851957; c=relaxed/simple;
	bh=fDWSKoLf6xiGrPGaL47iQ4/AVpN/ayfSFbJOyM1bnN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opP4ZM0R1ML2/5USzMkgd+HRenSOiemO/JxbxCjjxkc8San+nc8YZ1bG1NjInwaHRJx9qQvmmSXiBtHlLXvLVVcEoB4+4ey+iwW3I3vlT2Pm5qVMOq1HAHsEMUMBa39ZIcmYDsSI3MMMpQuNDBJcT/N8BsPytBwNaQ5MurfhKKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfxHnXWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B766C116C6;
	Mon, 19 Jan 2026 19:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768851954;
	bh=fDWSKoLf6xiGrPGaL47iQ4/AVpN/ayfSFbJOyM1bnN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rfxHnXWvsOuFtQ/xyKSFe2H1jnlc8Pn0wgQsf9r+Xl+vO71/Qjcn00LitgN/PsMeb
	 FLOSp99fSyylHUUjSVYQoHRbLOPVdi/O58Olj+bXAaBaWMz8sAIEuRwstmCZXbl8fJ
	 VrsRO5xYMyNp1AaMoZApSPDNOURLg1/aBhNPlfTEI3xniOm9EKQIx6XfIkseV9MUW+
	 li798MgWFBeZzhi0ZcN5fsCSB1akuy1IZGcFg71pie+qYxFOfd6/X73IiIghmKob7N
	 5/bd7138Ifk/Gxo8VeBsjpG00XEfuVCiowyuTvEj1wiZ96aNQWcXLVmiPhsdZH3Ly0
	 gMAtWawj69W4Q==
From: Jakub Kicinski <kuba@kernel.org>
To: bhargava.marreddy@broadcom.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	vikas.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	pabeni@redhat.com,
	rajashekar.hudumula@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	horms@kernel.org,
	ajit.khaparde@broadcom.com,
	michael.chan@broadcom.com
Subject: Re: [v5,net-next,8/8] bng_en: Add support for TPA events
Date: Mon, 19 Jan 2026 11:45:53 -0800
Message-ID: <20260119194553.1264793-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116193732.157898-9-bhargava.marreddy@broadcom.com>
References: <20260116193732.157898-9-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
bng_en: Add support for TPA events

This patch enables TPA (Transparent Packet Aggregation) functionality
in the VNIC and adds functions to handle TPA events for LRO/GRO
processing.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h

[ ... ]

> @@ -159,10 +159,9 @@ enum {
>  #define MAX_TPA_MASK	(MAX_TPA - 1)
>  #define MAX_TPA_SEGS	0x3f
>
> -#define BNGE_AGG_IDX_BMAP_SIZE	(MAX_TPA / BITS_PER_LONG)
>  struct bnge_tpa_idx_map {
>  	u16		agg_id_tbl[1024];
> -	unsigned long	agg_idx_bmap[BNGE_AGG_IDX_BMAP_SIZE];
> +	DECLARE_BITMAP(agg_idx_bmap, MAX_TPA);
>  };

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c

[ ... ]

> +static u16 bnge_tpa_alloc_agg_idx(struct bnge_rx_ring_info *rxr, u16 agg_id)
> +{
> +	struct bnge_tpa_idx_map *map = rxr->rx_tpa_idx_map;
> +	u16 idx = agg_id & MAX_TPA_MASK;
> +
> +	if (test_bit(idx, map->agg_idx_bmap)) {
> +		idx = find_first_zero_bit(map->agg_idx_bmap, MAX_TPA);
> +		if (idx >= MAX_TPA)
> +			return INVALID_HW_RING_ID;
> +	}
> +	__set_bit(idx, map->agg_idx_bmap);
> +	map->agg_id_tbl[agg_id] = idx;
                        ^^^^^^

The agg_id_tbl array is 1024 elements, but agg_id comes from hardware via
TPA_START_AGG_ID() which uses mask RX_TPA_START_CMP_AGG_ID_P5 (0xffff << 16),
allowing values up to 65535. Can this write out of bounds when
agg_id >= 1024?

For reference, the bnxt driver uses a different mask (0x0fff << 16),
limiting agg_id to 0-4095.

> +	return idx;
> +}

[ ... ]

> +static u16 bnge_lookup_agg_idx(struct bnge_rx_ring_info *rxr, u16 agg_id)
> +{
> +	struct bnge_tpa_idx_map *map = rxr->rx_tpa_idx_map;
> +
> +	return map->agg_id_tbl[agg_id];
                             ^^^^^^

Same concern here - the array lookup has no bounds check on agg_id.

> +}

[ ... ]

> +static void bnge_tpa_start(struct bnge_net *bn, struct bnge_rx_ring_info *rxr,
> +			   u8 cmp_type, struct rx_tpa_start_cmp *tpa_start,
> +			   struct rx_tpa_start_cmp_ext *tpa_start1)
> +{
> +	struct bnge_sw_rx_bd *cons_rx_buf, *prod_rx_buf;
> +	struct bnge_tpa_info *tpa_info;
> +	u16 cons, prod, agg_id;
> +	struct rx_bd *prod_bd;
> +	dma_addr_t mapping;
> +
> +	agg_id = TPA_START_AGG_ID(tpa_start);
> +	agg_id = bnge_tpa_alloc_agg_idx(rxr, agg_id);
> +	if (unlikely(agg_id == INVALID_HW_RING_ID)) {
> +		netdev_warn(bn->netdev, "Unable to allocate agg ID for ring %d, agg 0x%x\n",
> +			    rxr->bnapi->index, TPA_START_AGG_ID(tpa_start));
> +		bnge_sched_reset_rxr(bn, rxr);
> +		return;
> +	}
> +	cons = tpa_start->rx_tpa_start_cmp_opaque;
> +	prod = rxr->rx_prod;
> +	cons_rx_buf = &rxr->rx_buf_ring[cons];
> +	prod_rx_buf = &rxr->rx_buf_ring[RING_RX(bn, prod)];
> +	tpa_info = &rxr->rx_tpa[agg_id];
> +
> +	if (unlikely(cons != rxr->rx_next_cons ||
> +		     TPA_START_ERROR(tpa_start))) {
> +		netdev_warn(bn->netdev, "TPA cons %x, expected cons %x, error code %x\n",
> +			    cons, rxr->rx_next_cons,
> +			    TPA_START_ERROR_CODE(tpa_start1));
> +		bnge_sched_reset_rxr(bn, rxr);
> +		return;
                ^^^^^^

When this error path is taken, bnge_tpa_alloc_agg_idx() has already set
a bit in map->agg_idx_bmap but there is no corresponding call to
bnge_free_agg_idx(). Will this leak the TPA index, eventually
exhausting the available indices and causing subsequent TPA_START
events to fail?

> +	}

[ ... ]

> +static void bnge_tpa_agg(struct bnge_net *bn, struct bnge_rx_ring_info *rxr,
> +			 struct rx_agg_cmp *rx_agg)
> +{
> +	u16 agg_id = TPA_AGG_AGG_ID(rx_agg);
> +	struct bnge_tpa_info *tpa_info;
> +
> +	agg_id = bnge_lookup_agg_idx(rxr, agg_id);
> +	tpa_info = &rxr->rx_tpa[agg_id];

If bnge_lookup_agg_idx() returns a garbage value due to out-of-bounds
read, does this risk accessing invalid memory here as well?

> +
> +	tpa_info->agg_arr[tpa_info->agg_count++] = *rx_agg;
> +}

