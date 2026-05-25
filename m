Return-Path: <netdev+bounces-291422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B7RHDGaFGo0OwcAu9opvQ
	(envelope-from <netdev+bounces-291422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:51:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1AC5CDCE5
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1524430028C4
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3831380FFA;
	Mon, 25 May 2026 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gzv6vKQG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5C837F72A;
	Mon, 25 May 2026 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779735081; cv=none; b=k16ljYRU/Dv+REh53lCyLDLmNtpye0GAdLHBUeWv6+zLj33SwrpTySuaQKhvAoKXCJGdytTgctfu8FDQ5AxlXMftox1bmm/MYrHDz1dMybCNkS7D3ypJD+qwdA51f8CJJzBgtHOXLwgX4/R4QTuPPgQ1ZOn36OGjyKbwYuhSbYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779735081; c=relaxed/simple;
	bh=ffUKYjSusFApFAe36A/pJsa9BFxuho5D8hLgHIaQAUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIgrrsiqTofZBYHyWgFco98E4+sUWIr6bfuYI43qtQ15RV5cziXaRa7zBb9z7QgntSKsxJh/V3kV75n44B9AkIqM5EI2t/ZsxkDmLym0jA9XOmUAxKRpxzmGU1pU4wftjmT1P1eQfCBHuTvYNJkx6QhiiP0rK0PBxWEVS6YNmqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gzv6vKQG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F1B1F000E9;
	Mon, 25 May 2026 18:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779735079;
	bh=izTTmijpKmtY2TSOSukVuFzFfaXZ1MsoWFu8RNvBIk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gzv6vKQGpftfUexVDpqma1lblk5jFjrQo0NyU9Ef87VPk15SuDR3adeNYH4YEvKKh
	 7oG76ieUWjtMpHPAvux0bUYxFiQjyC5yZG2khkAOB83NWk7ZgsJU/t/A6mjkt2Gq5F
	 6L6rFhRhYjIzEqgSkXO2YzjU9bUeD0Pub8SLqvbhIKFas8tTffhQPxUeEl/X2yEqG/
	 vxcKNUJDB+iapsws5UhfRtotqagjcZrz1PcW9ODTluA5qwzunVd/2aoH76xYigrN1V
	 wlFzRiaJzRDVHsOKelYRr1+DzyU9TU6NBD+SLh1NX8KgOFgbTC9l2y7bmbV1hGaADJ
	 4CGOsuIGux24g==
From: Jakub Kicinski <kuba@kernel.org>
To: agaur@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	gakula@marvell.com,
	hkelam@marvell.com,
	sbhatta@marvell.com,
	sgoutham@marvell.com,
	bbhushan2@marvell.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5] octeontx2-pf: Retain ethtool stats across interface down/up.
Date: Mon, 25 May 2026 11:51:16 -0700
Message-ID: <20260525185116.2396105-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520093404.1945835-1-agaur@marvell.com>
References: <20260520093404.1945835-1-agaur@marvell.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-291422-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7D1AC5CDCE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
octeontx2-pf: Retain ethtool stats across interface down/up.

This patch saves accumulated device statistics into a new
otx2_hw.old_stats structure on interface stop and adds them to the
hardware counters returned by otx2_get_stats64() so that
rtnl_link_stats64 values persist across down/up cycles.

> octeontx2-pf: Retain ethtool stats across interface down/up.

[Medium]
The subject and changelog talk about "ethtool stats", but the patch only
touches the rtnl_link_stats64 path via otx2_get_stats64() (the
ndo_get_stats64 callback).  The actual ethtool -S handlers, namely
otx2_get_ethtool_stats() and otx2vf_get_ethtool_stats() in
otx2_ethtool.c, still index pfvf->hw.dev_stats directly:

    *(data++) = ((u64 *)&pfvf->hw.dev_stats)[otx2_dev_stats[stat].index];

with no contribution from the new old_stats field.  Will ethtool -S
counters continue to drop to zero on interface down despite the commit
subject, or is the intent to update those handlers too?  Could the
subject and changelog be reworded to refer to interface
(rtnl_link_stats64) statistics, or the ethtool -S handlers updated to
also account for old_stats?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 971fcab1c248..fce46816446f 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -138,20 +138,22 @@ void otx2_get_dev_stats(struct otx2_nic *pfvf)
>  void otx2_get_stats64(struct net_device *netdev,
>  		      struct rtnl_link_stats64 *stats)
>  {
> +	struct otx2_dev_stats *dev_stats, *old_stats;
>  	struct otx2_nic *pfvf = netdev_priv(netdev);
> -	struct otx2_dev_stats *dev_stats;
>  
>  	otx2_get_dev_stats(pfvf);
>  
>  	dev_stats = &pfvf->hw.dev_stats;
> -	stats->rx_bytes = dev_stats->rx_bytes;
> -	stats->rx_packets = dev_stats->rx_frames;
> -	stats->rx_dropped = dev_stats->rx_drops;
> -	stats->multicast = dev_stats->rx_mcast_frames;
> -
> -	stats->tx_bytes = dev_stats->tx_bytes;
> -	stats->tx_packets = dev_stats->tx_frames;
> -	stats->tx_dropped = dev_stats->tx_drops;
> +	old_stats = &pfvf->hw.old_stats;
> +
> +	stats->rx_bytes = old_stats->rx_bytes + dev_stats->rx_bytes;
> +	stats->rx_packets = old_stats->rx_frames + dev_stats->rx_frames;
> +	stats->rx_dropped = old_stats->rx_drops + dev_stats->rx_drops;
> +	stats->multicast = old_stats->rx_mcast_frames + dev_stats->rx_mcast_frames;
> +
> +	stats->tx_bytes = old_stats->tx_bytes + dev_stats->tx_bytes;
> +	stats->tx_packets = old_stats->tx_frames + dev_stats->tx_frames;
> +	stats->tx_dropped = old_stats->tx_drops + dev_stats->tx_drops;

[Medium]
otx2_get_stats64() is the ndo_get_stats64 callback for both PF and VF
and is callable from contexts that do not hold RTNL (for example
/proc/net/dev readers).  It now reads pfvf->hw.old_stats with no
locking, while otx2_stop() on another CPU performs a series of
non-atomic read-modify-write operations on the same fields:

    old_stats->rx_bytes     += dev->rx_bytes;
    old_stats->rx_drops     += dev->rx_drops;
    ...

Can a concurrent reader observe a torn 64-bit value on 32-bit
architectures, or an inconsistent snapshot across the thirteen fields
on 64-bit (e.g. old_stats->rx_bytes already accumulated while
old_stats->rx_frames is not)?

Additionally, both paths write pfvf->hw.dev_stats: otx2_stop() calls
otx2_get_dev_stats(pf) just before the accumulation, and any concurrent
otx2_get_stats64() also calls otx2_get_dev_stats(pfvf) and overwrites
the same fields.  Could the otx2_stop() accumulation end up adding
values that no longer match the snapshot it just took, if a concurrent
reader rewrote dev_stats in between?

Would a u64_stats_sync seqlock or a dedicated stats lock around both
the writer and reader paths be more appropriate here?

>  }
>  EXPORT_SYMBOL(otx2_get_stats64);
>  
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index ee623476e5ff..3b4e32d899b7 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -2154,6 +2154,7 @@ EXPORT_SYMBOL(otx2_open);
>  int otx2_stop(struct net_device *netdev)
>  {
>  	struct otx2_nic *pf = netdev_priv(netdev);
> +	struct otx2_dev_stats *old_stats, *dev;
>  	struct otx2_cq_poll *cq_poll = NULL;
>  	struct otx2_qset *qset = &pf->qset;
>  	int qidx, vec, wrk;
> @@ -2200,6 +2201,26 @@ int otx2_stop(struct net_device *netdev)
>  		cancel_delayed_work_sync(&pf->refill_wrk[wrk].pool_refill_work);
>  	devm_kfree(pf->dev, pf->refill_wrk);
>  
> +	/* Read final HW counters and accumulate */
> +	dev = &pf->hw.dev_stats;
> +	old_stats = &pf->hw.old_stats;
> +	otx2_get_dev_stats(pf);
> +
> +	/* Accumulate old stats */
> +	old_stats->rx_bytes     += dev->rx_bytes;
> +	old_stats->rx_drops     += dev->rx_drops;
> +	old_stats->rx_bcast_frames      += dev->rx_bcast_frames;
> +	old_stats->rx_mcast_frames      += dev->rx_mcast_frames;
> +	old_stats->rx_ucast_frames      += dev->rx_ucast_frames;
> +	old_stats->rx_frames            += dev->rx_frames;
> +
> +	old_stats->tx_bytes             += dev->tx_bytes;
> +	old_stats->tx_drops             += dev->tx_drops;

[High]
Can tx_drops be over-counted across down/up cycles?  Looking at
otx2_get_dev_stats():

    dev_stats->tx_drops = OTX2_GET_TX_STATS(TX_DROP) +
                  (unsigned long)atomic_long_read(&dev_stats->tx_discards);

The tx_discards atomic_long_t is incremented on the xmit path and is
never reset across down/up cycles (no clearing in otx2_open() or
otx2_stop(), and only ever atomic_long_inc()).

The accumulation here saves the composite dev->tx_drops
(HW TX_DROP + tx_discards) into old_stats->tx_drops.  After the next
bring-up the HW TX_DROP register starts again at 0 but tx_discards
still contains the prior session's count, so otx2_get_dev_stats()
folds the same atomic value in again.

The next otx2_get_stats64() then returns
old_stats->tx_drops + dev_stats->tx_drops, where dev_stats->tx_drops
still includes the same tx_discards.  After N down/up cycles, every
prior-session tx_discards increment is counted N+1 times.

For example, with X prior tx_discards and HW drops D1 in cycle 1, then
HW drops D2 and tx_discards growing to X+Y in cycle 2, the reported
tx_dropped becomes (D1+X) + (D2+X+Y) = D1+D2+2X+Y instead of
D1+D2+X+Y.

Would it be better to accumulate only the HW component (snapshot
OTX2_GET_TX_STATS(TX_DROP) separately and let the atomic continue to
be added at read time), zero the atomic at stop, or compute deltas
instead of full snapshots?

> +	old_stats->tx_bcast_frames      += dev->tx_bcast_frames;
> +	old_stats->tx_mcast_frames      += dev->tx_mcast_frames;
> +	old_stats->tx_ucast_frames      += dev->tx_ucast_frames;
> +	old_stats->tx_frames            += dev->tx_frames;
> +
>  	otx2_free_hw_resources(pf);
>  	otx2_free_cints(pf, pf->hw.cint_cnt);
>  	otx2_disable_napi(pf);
-- 
pw-bot: cr

