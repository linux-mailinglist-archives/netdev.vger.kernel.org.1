Return-Path: <netdev+bounces-288739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMYcJnXMCWq2qAQAu9opvQ
	(envelope-from <netdev+bounces-288739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 16:11:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FC0561811
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 16:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E816F300CC0D
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 14:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F762F8EA1;
	Sun, 17 May 2026 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uh2YlwOM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B122E1F02
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779027055; cv=none; b=QHE5cmeG56NCc2fEsDpyuwWbrYz06wwXIq/PNEtvVhPtFl00mOF8TzfNcb9NG7rE9rKwinxZCDm8K78XlvlO0Mhz8sqxgR9azbNDsLT2z2X48RaRJTHVDbGdZuN+kAHH/8Ushi1q03Rj1iHYGgFfVpiICi2sMb9+sgnQzj8h35Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779027055; c=relaxed/simple;
	bh=xI8rlXdpV89cG2LXZuV2WflqErvHETEclNBHEngVwPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aScNW3IKFxlWN7XRpnFnVH1fbmrNno/bALqiEJwjFTXKjr/CpJ8uKn30+wwy0PVyn9ViEl9IRQDGPRzyYanlH2SPvKsnymZOyyTTVnrvKKKYg6GM9oAHthSQvvl8dPKjBUdY8uWAuL8ABJc5OiC3Tso0IPsbwQmtA4q+9d10UYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uh2YlwOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93335C2BCB0;
	Sun, 17 May 2026 14:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779027054;
	bh=xI8rlXdpV89cG2LXZuV2WflqErvHETEclNBHEngVwPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uh2YlwOM65S8ZEw9HtGrEtR+VHqfvU+YL35oBGp64AVfsJUfW4Tx0UwSKF1HdGaqk
	 AWksiI3qJHN5f2AHX3v2MCRMVwhpYiMaLgpxBkT3ZRH7xd8kk1TqczQORFszsWvZGd
	 ZYlvT0h28rDdnoNBkCHEcwwMVhz2eaZtThMoPatAMGJRNoq58/hJu71T/O5sGPFyJc
	 VjFD59H2sMIsAH7uYr6ZSuNph5WJpjM3HShzEitEE7EgOGroYXq9S/O/JA3CKmSCej
	 tl71JpI513YO8dUNJvCIHqYMZWQrT45CNoSnJ7EVKLdqdjSt/Ebu2FldDQaN2P8aUN
	 q9n2L8Nxilkmw==
From: Simon Horman <horms@kernel.org>
To: maciek@machnikowski.net
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	richardcochran@gmail.com,
	milena.olech@intel.com,
	willemdebruijn.kernel@gmail.com,
	andrew@lunn.ch,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH v6 net-next 2/3] netdevsim: Implement basic ptp support
Date: Sun, 17 May 2026 15:07:45 +0100
Message-ID: <20260517140744.330136-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513094520.325693-3-maciek@machnikowski.net>
References: <20260513094520.325693-3-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 06FC0561811
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,intel.com,lunn.ch,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288739-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
netdevsim: Implement basic ptp support

This patch wires two ptp_mock clocks into netdevsim, implements
ndo_hwtstamp_get/set, and samples PHC timestamps from nsim_start_xmit()
to attach TX/RX hardware timestamps to forwarded skbs.

> diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
> index 36a201533aae..5b709033cc5f 100644
> --- a/drivers/net/netdevsim/ethtool.c
> +++ b/drivers/net/netdevsim/ethtool.c

[ ... ]

> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index a750768912b5..5caf60e73941 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -122,7 +124,11 @@ static int nsim_forward_skb(struct net_device *tx_dev,
>
>  static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
> +	struct skb_shared_hwtstamps shhwtstamps = {};
>  	struct netdevsim *ns = netdev_priv(dev);
> +	struct ptp_clock_info *ptp_info;
> +	struct timespec64 tx_ts, rx_ts;
> +	struct sk_buff *skb_orig = skb;
>  	struct skb_ext *psp_ext = NULL;
>  	struct net_device *peer_dev;
>  	unsigned int len = skb->len;
> @@ -164,6 +170,36 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  		skb_linearize(skb);
>
>  	skb_tx_timestamp(skb);
> +
> +	/* Generate RX timestamp using the peer's PHC if RX timestamping is enabled */
> +	if (peer_ns->tstamp_config.rx_filter != HWTSTAMP_FILTER_NONE) {
> +		ptp_info = mock_phc_get_ptp_info(peer_ns->phc);
> +		ptp_info->gettime64(ptp_info, &rx_ts);
> +	}

[High]
Can the value of peer_ns->tstamp_config.rx_filter change between this
read and the second read further down that gates the write to
skb_hwtstamps(skb)->hwtstamp?

nsim_set_ts_config() updates ns->tstamp_config from its own ndo
context with no lock or barrier shared with nsim_start_xmit(). If a
concurrent ndo_hwtstamp_set on the peer flips rx_filter from
HWTSTAMP_FILTER_NONE to HWTSTAMP_FILTER_ALL between the two reads,
the first branch is skipped (rx_ts remains uninitialized on the
xmit stack) and the second branch executes:

    if (peer_ns->tstamp_config.rx_filter != HWTSTAMP_FILTER_NONE)
        skb_hwtstamps(skb)->hwtstamp = timespec64_to_ktime(rx_ts);

Eight bytes of uninitialized stack are then placed into
skb_hwtstamps and forwarded to the peer, where they are delivered
to userspace via SO_TIMESTAMPING ancillary data.

Would caching the decision in a local boolean alongside rx_ts (only
true on the path that actually called gettime64) and reading the
config field once via READ_ONCE or a lock close this?

> +
> +	/* If TX hardware timestamping is enabled, generate and attach a TX timestamp */
> +	if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&
> +	    peer_ns->tstamp_config.tx_type == HWTSTAMP_TX_ON) {
> +		ptp_info = mock_phc_get_ptp_info(ns->phc);
> +		ptp_info->gettime64(ptp_info, &tx_ts);

[High]
Should the predicate consult ns->tstamp_config.tx_type rather than
peer_ns->tstamp_config.tx_type?

The standard ndo_hwtstamp_set contract is that enabling
HWTSTAMP_TX_ON on a device controls TX timestamping for transmits
from that device. As written, configuring HWTSTAMP_TX_ON on the
local netdevsim has no effect on its own transmits, and ptp4l
running on the local end would never see SCM_TSTAMP_SND completions
unless the operator also configures the peer, which contradicts the
commit message statement that this "enables running ptp4l on
netdevsim adapters".

There is also a NULL dereference path on VFs. nsim_vf_netdev_ops
shares nsim_start_xmit but does not install ndo_hwtstamp_set, and
nsim_init_netdevsim_vf() never assigns ns->phc, so a VF has
ns->phc == NULL. If a VF is peered with a PF that has tx_type set
to HWTSTAMP_TX_ON, an unprivileged sender on the VF with
SOF_TIMESTAMPING_TX_HARDWARE reaches:

    ptp_info = mock_phc_get_ptp_info(ns->phc);
    ptp_info->gettime64(ptp_info, &tx_ts);

with ns->phc == NULL. Since info is the first field of struct
mock_phc, mock_phc_get_ptp_info(NULL) returns NULL and gettime64
dereferences a NULL function pointer.

Switching the predicate to ns->tstamp_config.tx_type also closes
the NULL deref because nsim_set_ts_config() returns -EOPNOTSUPP
when ns->phc is NULL, so tx_type==HWTSTAMP_TX_ON implies a non-NULL
phc on the local device.

> +
> +		/* Create a copy of the SKB to forward to peer and prevent
> +		 * from reporting incorrect TX timestamp when skb_hwtstamps is set.
> +		 */
> +		skb = skb_copy(skb_orig, GFP_ATOMIC);
> +		if (skb) {
> +			shhwtstamps.hwtstamp = timespec64_to_ktime(tx_ts);
> +			skb_tstamp_tx(skb_orig, &shhwtstamps);
> +			consume_skb(skb_orig);
> +		} else {
> +			skb = skb_orig;
> +		}
> +	}

[Medium]
What happens to the freshly sampled tx_ts if skb_copy() fails under
memory pressure?

In the else branch skb_tstamp_tx() is never called, so no
SCM_TSTAMP_SND completion is delivered to the application's error
queue. There is no counter increment, no warning, and no fallback
path that delivers the timestamp without the copy. ptp4l would see
phantom TX-timestamp losses with no diagnostic. Could the timestamp
be reported even on the allocation-failure path?

[Low]
Is the temporal ordering of the two PHC samples intentional?

rx_ts is sampled from peer_ns->phc before tx_ts is sampled from
ns->phc, but on a real link RX time follows TX time. With both
PHCs free-running, ptp4l can observe negative path delays for the
same packet, which can confuse the protocol's filter and one-way
delay computation. Would sampling tx_ts first (and optionally
adding a small simulated propagation delay before the rx sample)
be a better fit for the stated goal of running ptp4l on
netdevsim?

> +
> +	/* set the rx timestamp to the skb */
> +	if (peer_ns->tstamp_config.rx_filter != HWTSTAMP_FILTER_NONE)
> +		skb_hwtstamps(skb)->hwtstamp = timespec64_to_ktime(rx_ts);
> +
>  	if (unlikely(nsim_forward_skb(dev, peer_dev,
>  				      skb, rq, psp_ext) == NET_RX_DROP))
>  		goto out_drop_cnt;
> @@ -185,6 +221,59 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	return NETDEV_TX_OK;
>  }
>
> +static int nsim_set_ts_config(struct net_device *netdev,
> +			      struct kernel_hwtstamp_config *config,
> +			      struct netlink_ext_ack *extack)
> +{
> +	struct netdevsim *ns = netdev_priv(netdev);
> +
> +	if (!ns->phc)
> +		return -EOPNOTSUPP;
> +
> +	switch (config->tx_type) {
> +	case HWTSTAMP_TX_OFF:
> +		ns->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
> +		break;
> +	case HWTSTAMP_TX_ON:
> +		ns->tstamp_config.tx_type = HWTSTAMP_TX_ON;
> +		break;
> +	default:
> +		return -ERANGE;
> +	}
> +
> +	switch (config->rx_filter) {
> +	case HWTSTAMP_FILTER_NONE:
> +		ns->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
> +		break;
> +	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
> +	case HWTSTAMP_FILTER_PTP_V2_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
> +	case HWTSTAMP_FILTER_NTP_ALL:
> +	case HWTSTAMP_FILTER_ALL:
> +		ns->tstamp_config.rx_filter = HWTSTAMP_FILTER_ALL;
> +		break;
> +	default:
> +		return -ERANGE;
> +	}
> +
> +	return 0;
> +}

[Medium]
Should the coerced rx_filter value also be written back into the
caller's *config?

dev_set_hwtstamp() in net/core/dev_ioctl.c copies the
kernel_hwtstamp_config back to userspace after a successful
ndo_hwtstamp_set, and Documentation/networking/timestamping.rst
asks drivers to indicate when they timestamp more than requested.
Here the PTP_V1_*, PTP_V2_*, and NTP_ALL cases are all internally
mapped to HWTSTAMP_FILTER_ALL but config->rx_filter is left at the
caller's original value, so userspace cannot detect the widening.
Other drivers (mlx5e, igb, stmmac) write the coerced filter back
into config->rx_filter for this reason.

[ ... ]

