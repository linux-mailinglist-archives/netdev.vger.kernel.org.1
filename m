Return-Path: <netdev+bounces-28944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717F178132A
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946DC1C216B0
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD03F1B7E7;
	Fri, 18 Aug 2023 18:58:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0A71B7C2
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 18:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8BAC433C8;
	Fri, 18 Aug 2023 18:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692385106;
	bh=S9jeBHuU4qW9pmm3rJ9vHy0XmaVc4eMiB+8Vi9ww+XM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F6LJT1MJGIo/HrWULfJiMWpmVKWP1UJ8zXrlD3owNgFnCvUvucbZHpVhbJz/OisoK
	 LkRtYiH0DN8H3OB07e48Hrei2GCaGxWuA7lBsTeP3D9bCGivDO0djjfEtzJSnRhwXI
	 mP0G4oeC0UEMSSQ3r5lsgbck/Et5ruKChHw3xUJ48NzMpeJIFMsQCYSRYuot0NN97L
	 3xMPoh3bYF751tWlGiRD5LK54ImMNKDIiY4UsdY23H6W2PnEflXjC3a+kOo5iiw+Qg
	 oOZ6smoHD/HQUPagLMbtoJ9Ger1eh9oMJG4TIM9+aBAnsm5TmQWFMaYBseYVb4SbJV
	 O3FmltI/UMyCA==
Date: Fri, 18 Aug 2023 11:58:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Alan Brady <alan.brady@intel.com>,
 pavan.kumar.linga@intel.com, emil.s.tantilov@intel.com,
 jesse.brandeburg@intel.com, sridhar.samudrala@intel.com,
 shiraz.saleem@intel.com, sindhu.devale@intel.com, willemb@google.com,
 decot@google.com, andrew@lunn.ch, leon@kernel.org, mst@redhat.com,
 simon.horman@corigine.com, shannon.nelson@amd.com,
 stephen@networkplumber.org, Alice Michael <alice.michael@intel.com>, Joshua
 Hay <joshua.a.hay@intel.com>, Phani Burra <phani.r.burra@intel.com>
Subject: Re: [PATCH net-next v5 14/15] idpf: add ethtool callbacks
Message-ID: <20230818115824.446d1ea7@kernel.org>
In-Reply-To: <20230816004305.216136-15-anthony.l.nguyen@intel.com>
References: <20230816004305.216136-1-anthony.l.nguyen@intel.com>
	<20230816004305.216136-15-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Aug 2023 17:43:04 -0700 Tony Nguyen wrote:
> +static u32 idpf_get_rxfh_indir_size(struct net_device *netdev)
> +{
> +	struct idpf_vport *vport = idpf_netdev_to_vport(netdev);
> +	struct idpf_vport_user_config_data *user_config;
> +
> +	if (!vport)
> +		return -EINVAL;

defensive programming? how do we have a netdev and no vport?

> +	if (!idpf_is_cap_ena_all(vport->adapter, IDPF_RSS_CAPS, IDPF_CAP_RSS)) {
> +		dev_err(&vport->adapter->pdev->dev, "RSS is not supported on this device\n");
> +
> +		return -EOPNOTSUPP;

Let's drop these prints, EOPNOTSUPP is enough.
Some random system info gathering daemon will run this get and
pollute logs with errors for no good reason.

> +	}
> +
> +	user_config = &vport->adapter->vport_config[vport->idx]->user_config;
> +
> +	return user_config->rss_data.rss_lut_size;
> +}

> +/**
> + * idpf_set_channels: set the new channel count
> + * @netdev: network interface device structure
> + * @ch: channel information structure
> + *
> + * Negotiate a new number of channels with CP. Returns 0 on success, negative
> + * on failure.
> + */
> +static int idpf_set_channels(struct net_device *netdev,
> +			     struct ethtool_channels *ch)
> +{
> +	struct idpf_vport *vport = idpf_netdev_to_vport(netdev);
> +	struct idpf_vport_config *vport_config;
> +	u16 combined, num_txq, num_rxq;
> +	unsigned int num_req_tx_q;
> +	unsigned int num_req_rx_q;
> +	struct device *dev;
> +	int err;
> +	u16 idx;
> +
> +	if (!vport)
> +		return -EINVAL;
> +
> +	idx = vport->idx;
> +	vport_config = vport->adapter->vport_config[idx];
> +
> +	num_txq = vport_config->user_config.num_req_tx_qs;
> +	num_rxq = vport_config->user_config.num_req_rx_qs;
> +
> +	combined = min(num_txq, num_rxq);
> +
> +	/* these checks are for cases where user didn't specify a particular
> +	 * value on cmd line but we get non-zero value anyway via
> +	 * get_channels(); look at ethtool.c in ethtool repository (the user
> +	 * space part), particularly, do_schannels() routine
> +	 */
> +	if (ch->combined_count == combined)
> +		ch->combined_count = 0;
> +	if (ch->combined_count && ch->rx_count == num_rxq - combined)
> +		ch->rx_count = 0;
> +	if (ch->combined_count && ch->tx_count == num_txq - combined)
> +		ch->tx_count = 0;
> +
> +	dev = &vport->adapter->pdev->dev;
> +	if (!(ch->combined_count || (ch->rx_count && ch->tx_count))) {
> +		dev_err(dev, "Please specify at least 1 Rx and 1 Tx channel\n");

The error msg doesn't seem to fit the second part of the condition.

> +		return -EINVAL;
> +	}
> +
> +	num_req_tx_q = ch->combined_count + ch->tx_count;
> +	num_req_rx_q = ch->combined_count + ch->rx_count;
> +
> +	dev = &vport->adapter->pdev->dev;
> +	/* It's possible to specify number of queues that exceeds max in a way
> +	 * that stack won't catch for us, this should catch that.
> +	 */

How, tho?

> +	if (num_req_tx_q > vport_config->max_q.max_txq) {
> +		dev_info(dev, "Maximum TX queues is %d\n",
> +			 vport_config->max_q.max_txq);
> +
> +		return -EINVAL;
> +	}
> +	if (num_req_rx_q > vport_config->max_q.max_rxq) {
> +		dev_info(dev, "Maximum RX queues is %d\n",
> +			 vport_config->max_q.max_rxq);
> +
> +		return -EINVAL;
> +	}

> +	if (ring->tx_pending > IDPF_MAX_TXQ_DESC ||
> +	    ring->tx_pending < IDPF_MIN_TXQ_DESC) {

Doesn't core check max?

> +		netdev_err(netdev, "Descriptors requested (Tx: %u) out of range [%d-%d] (increment %d)\n",
> +			   ring->tx_pending,
> +			   IDPF_MIN_TXQ_DESC, IDPF_MAX_TXQ_DESC,
> +			   IDPF_REQ_DESC_MULTIPLE);
> +
> +		return -EINVAL;
> +	}
> +
> +	if (ring->rx_pending > IDPF_MAX_RXQ_DESC ||
> +	    ring->rx_pending < IDPF_MIN_RXQ_DESC) {
> +		netdev_err(netdev, "Descriptors requested (Rx: %u) out of range [%d-%d] (increment %d)\n",
> +			   ring->rx_pending,
> +			   IDPF_MIN_RXQ_DESC, IDPF_MAX_RXQ_DESC,
> +			   IDPF_REQ_RXQ_DESC_MULTIPLE);
> +
> +		return -EINVAL;
> +	}


> +static const struct idpf_stats idpf_gstrings_port_stats[] = {
> +	IDPF_PORT_STAT("rx-csum_errors", port_stats.rx_hw_csum_err),
> +	IDPF_PORT_STAT("rx-hsplit", port_stats.rx_hsplit),
> +	IDPF_PORT_STAT("rx-hsplit_hbo", port_stats.rx_hsplit_hbo),
> +	IDPF_PORT_STAT("rx-bad_descs", port_stats.rx_bad_descs),
> +	IDPF_PORT_STAT("rx-length_errors", port_stats.vport_stats.rx_invalid_frame_length),
> +	IDPF_PORT_STAT("tx-skb_drops", port_stats.tx_drops),
> +	IDPF_PORT_STAT("tx-dma_map_errs", port_stats.tx_dma_map_errs),
> +	IDPF_PORT_STAT("tx-linearized_pkts", port_stats.tx_linearize),
> +	IDPF_PORT_STAT("tx-busy_events", port_stats.tx_busy),
> +	IDPF_PORT_STAT("rx_bytes", port_stats.vport_stats.rx_bytes),
> +	IDPF_PORT_STAT("rx-unicast_pkts", port_stats.vport_stats.rx_unicast),
> +	IDPF_PORT_STAT("rx-multicast_pkts", port_stats.vport_stats.rx_multicast),
> +	IDPF_PORT_STAT("rx-broadcast_pkts", port_stats.vport_stats.rx_broadcast),

how are the basic stats different form the base stats reported via
if_link?

Also what's up with the mix of - and _ in the names?

> +	IDPF_PORT_STAT("rx-unknown_protocol", port_stats.vport_stats.rx_unknown_protocol),
> +	IDPF_PORT_STAT("tx_bytes", port_stats.vport_stats.tx_bytes),
> +	IDPF_PORT_STAT("tx-unicast_pkts", port_stats.vport_stats.tx_unicast),
> +	IDPF_PORT_STAT("tx-multicast_pkts", port_stats.vport_stats.tx_multicast),
> +	IDPF_PORT_STAT("tx-broadcast_pkts", port_stats.vport_stats.tx_broadcast),
> +	IDPF_PORT_STAT("tx_errors", port_stats.vport_stats.tx_errors),

> +static void idpf_add_stat_strings(u8 **p, const struct idpf_stats *stats,
> +				  const unsigned int size)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < size; i++) {
> +		snprintf((char *)*p, ETH_GSTRING_LEN, "%.32s",
> +			 stats[i].stat_string);
> +		*p += ETH_GSTRING_LEN;

ethtool_sprintf()

> +	}
> +}

