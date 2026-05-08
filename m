Return-Path: <netdev+bounces-285909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEkpBlQF/mm7mAAAu9opvQ
	(envelope-from <netdev+bounces-285909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:46:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C37D4F8F21
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 98B753011F73
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 15:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D503F23A3;
	Fri,  8 May 2026 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3pbmeuP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22423DB647;
	Fri,  8 May 2026 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778254944; cv=none; b=JVg7xiRhlwaTJ3SjAoDQBKKUcyTMk1HFN12qYIezaxQMHv1yr8T/0WDb8VTzFRnriP6896V0R/zp1JlK6sOVJ20MgMV2jiKUTXytBXWGVdRbRFV4jDnX14P21K/Jz7u7XCtZv5tzMRnEkNgACVoCm8q7QRp2a3Mu423F3pZucuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778254944; c=relaxed/simple;
	bh=hpyMjuuhAA498YiMJD/7ERK/AlvHaCx8MmWRt7EyM+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CeMoDgWuANnB9RYAzl6rak2UG2X/tTpDyzjpmg+//pk6KIsPqEFJ7D4eiochJN3XhVNx92BZsj9Hdxu3jL3kIlzrxEON5n/AVLmfOJdTyyYmRuZk1bBTTp3A6LkHZItrOuA0+NDA0CCtxrLg00iSpB4beFzLMXgaxH+za+puEJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3pbmeuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D37C2BCC9;
	Fri,  8 May 2026 15:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778254943;
	bh=hpyMjuuhAA498YiMJD/7ERK/AlvHaCx8MmWRt7EyM+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r3pbmeuPmFgZURnUdoN1bDWlA7HIgEWcv02J2eJLqk59Bm/CpTuOteR+/WLaQyYkZ
	 17zYddFItB9pnhfy3LpCjzdgyYta+tHjzqTx1TyFYoWKuT7Ir83XJFQPbDlIv1t6oa
	 2eQOMaQ6LoV/Ik8zcEv6cdOs+vUR42Kg07xoyB1lDG4PNTfndVJMoIf9nw5pUtWK/4
	 XBzZFOB1b+ZxjAP2QVXRxPXPqrxPo2zYCjJ9BZZT4XI6UCWixIZBSDrv//YCB78eJK
	 ZyCGQFP/ZSbQhFkFVUYQL02kYrpaHabc+xf3rNsCKutfqooxKuX8/KqAS6xrX4OB8C
	 YcmVPpMaTP1ow==
From: Simon Horman <horms@kernel.org>
To: aleksander.lobakin@intel.com
Cc: 'Simon Horman' <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kohei@enjuk.jp,
	jacob.e.keller@intel.com,
	aleksandr.loktionov@intel.com,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next v5 5/5] ice: add support for transmitting unreadable frags
Date: Fri,  8 May 2026 16:42:00 +0100
Message-ID: <20260508154159.1250696-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505152923.1040589-6-aleksander.lobakin@intel.com>
References: <20260505152923.1040589-6-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1C37D4F8F21
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-285909-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ice: add support for transmitting unreadable frags

This commit advertises netmem Tx support in the ice driver. It modifies
the transmit path to conditionally set the buffer type to ICE_TX_BUF_FRAG
only when the fragment is not a net_iov, allowing the driver to skip DMA
unmapping operations for unreadable fragments.

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index a88f9e3c00771..0e61b38e53a5e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3453,6 +3453,7 @@ static void ice_set_ops(struct ice_vsi *vsi)
>  
>  	netdev->netdev_ops = &ice_netdev_ops;
>  	netdev->queue_mgmt_ops = &ice_queue_mgmt_ops;
> +	netdev->netmem_tx = true;
>  	netdev->udp_tunnel_nic_info = &pf->hw.udp_tunnel_nic;

By setting netmem_tx to true here, the driver accepts packets containing
net_iov fragments. If a net_iov packet exceeds ICE_MAX_BUF_TXD fragments, it
appears it will fall back to linearization in the transmit path.

Since __skb_linearize() uses CPU memory accessors that expect a valid struct
page, will this cause an invalid memory access when skb_frag_page() returns a
net_iov pointer?

Should the driver explicitly drop highly fragmented net_iov packets instead of
attempting to linearize them?

[ ... ]
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 43b4670760273..1d97e2cc2adee 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -113,11 +113,17 @@ ice_prgm_fdir_fltr(struct ice_vsi *vsi, struct ice_fltr_desc *fdir_desc,
>  static void
>  ice_unmap_and_free_tx_buf(struct ice_tx_ring *ring, struct ice_tx_buf *tx_buf)
>  {
> -	if (tx_buf->type != ICE_TX_BUF_XDP_TX && dma_unmap_len(tx_buf, len))
> +	switch (tx_buf->type) {
> +	case ICE_TX_BUF_DUMMY:
> +	case ICE_TX_BUF_FRAG:
> +	case ICE_TX_BUF_SKB:
> +	case ICE_TX_BUF_XDP_XMIT:
>  		dma_unmap_page(ring->dev,
>  			       dma_unmap_addr(tx_buf, dma),
>  			       dma_unmap_len(tx_buf, len),
>  			       DMA_TO_DEVICE);
> +		break;
> +	}

Does removing the dma_unmap_len() check alter the safety of the DMA error
recovery path?

If a mapping fails in ice_tx_map(), execution jumps to dma_error and calls
ice_unmap_and_free_tx_buf(). Since the failure happens before
dma_unmap_len_set() updates the descriptor, it seems this might unconditionally
unmap using stale descriptor state. 

Could this result in 0-length unmaps or erroneously unmapping persistent
net_iov memory?

[ ... ]
> @@ -338,12 +344,14 @@ static bool ice_clean_tx_irq(struct ice_tx_ring *tx_ring, int napi_budget)
>  			}
>  
>  			/* unmap any remaining paged data */
> -			if (dma_unmap_len(tx_buf, len)) {
> +			if (tx_buf->type != ICE_TX_BUF_EMPTY) {
>  				dma_unmap_page(tx_ring->dev,
>  					       dma_unmap_addr(tx_buf, dma),
>  					       dma_unmap_len(tx_buf, len),
>  					       DMA_TO_DEVICE);
> +
>  				dma_unmap_len_set(tx_buf, len, 0);
> +				tx_buf->type = ICE_TX_BUF_EMPTY;
>  			}
>  		}

When mapping a net_iov fragment in ice_tx_map(), the descriptor is populated
with the length and DMA address, but tx_buf->type remains ICE_TX_BUF_EMPTY.

Because dma_unmap_len_set(tx_buf, len, 0) is now placed inside the
tx_buf->type != ICE_TX_BUF_EMPTY check, does this skip clearing the len and
dma fields for net_iov descriptors when they are returned to the free pool?

If these descriptor fields are leaked, could they be incorrectly unmapped later
if the descriptor is reused and a subsequent mapping fails?

