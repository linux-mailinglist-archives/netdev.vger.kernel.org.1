Return-Path: <netdev+bounces-25779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1354C775726
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 12:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFEF281BAB
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 10:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3635847D;
	Wed,  9 Aug 2023 10:33:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492F56131
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 10:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73087C433C7;
	Wed,  9 Aug 2023 10:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691577215;
	bh=UFV0B5Ou6ORYbYaB/Chk41IlXc/kIfzxr9mFWLE2Thw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sKk14XQmvSyETZ/17nsmOMrsC+4pge9+MtTo7Yx/XStzyqAl7vfS+agNegGYOOsfJ
	 AuZhHM8MWRYWAuKA+w7m3HXRd0pS9dQPaCjjPdpDipNOlRhN50EdB3S0yZP4eK+WSk
	 nJqeChGMAAY7gjGrh3ttDQHQQGl2YTxmtmKIpsfVDYaWCZ2vKPp1xTrqVK/xErKnuB
	 hX2Jkv54V9jFjoF3yBDcZMN+OP/tBmStr4DjC8jzRh2MsgsitrjGON/NqaxskDISfi
	 FUbO7ovnqu0FkuuTDrmV13kxFpPvUHmegjl/viUAk4CsHuWSFZVmPP/adkHWf+QhEm
	 5uJ1ecYN57FHA==
Date: Wed, 9 Aug 2023 12:33:29 +0200
From: Simon Horman <horms@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Alan Brady <alan.brady@intel.com>, pavan.kumar.linga@intel.com,
	emil.s.tantilov@intel.com, jesse.brandeburg@intel.com,
	sridhar.samudrala@intel.com, shiraz.saleem@intel.com,
	sindhu.devale@intel.com, willemb@google.com, decot@google.com,
	andrew@lunn.ch, leon@kernel.org, mst@redhat.com,
	simon.horman@corigine.com, shannon.nelson@amd.com,
	stephen@networkplumber.org, Alice Michael <alice.michael@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Phani Burra <phani.r.burra@intel.com>
Subject: Re: [PATCH net-next v4 14/15] idpf: add ethtool callbacks
Message-ID: <ZNNreRbo5jB9CaWc@vergenet.net>
References: <20230808003416.3805142-1-anthony.l.nguyen@intel.com>
 <20230808003416.3805142-15-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808003416.3805142-15-anthony.l.nguyen@intel.com>

On Mon, Aug 07, 2023 at 05:34:15PM -0700, Tony Nguyen wrote:
> From: Alan Brady <alan.brady@intel.com>
> 
> Initialize all the ethtool ops that are supported by the driver and
> add the necessary support for the ethtool callbacks. Also add
> asynchronous link notification virtchnl support where the device
> Control Plane sends the link status and link speed as an
> asynchronous event message. Driver report the link speed on
> ethtool .idpf_get_link_ksettings query.
> 
> Introduce soft reset function which is used by some of the ethtool
> callbacks such as .set_channels, .set_ringparam etc. to change the
> existing queue configuration. It deletes the existing queues by sending
> delete queues virtchnl message to the CP and calls the 'vport_stop' flow
> which disables the queues, vport etc. New set of queues are requested to
> the CP and reconfigure the queue context by calling the 'vport_open'
> flow. Soft reset flow also adjusts the number of vectors associated to a
> vport if .set_channels is called.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> Co-developed-by: Alice Michael <alice.michael@intel.com>
> Signed-off-by: Alice Michael <alice.michael@intel.com>
> Co-developed-by: Joshua Hay <joshua.a.hay@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> Co-developed-by: Phani Burra <phani.r.burra@intel.com>
> Signed-off-by: Phani Burra <phani.r.burra@intel.com>
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c

...

> +/**
> + * idpf_get_ethtool_stats - report device statistics
> + * @netdev: network interface device structure
> + * @stats: ethtool statistics structure
> + * @data: pointer to data buffer
> + *
> + * All statistics are added to the data buffer as an array of u64.
> + */
> +static void idpf_get_ethtool_stats(struct net_device *netdev,
> +				   struct ethtool_stats __always_unused *stats,
> +				   u64 *data)
> +{
> +	struct idpf_vport *vport = idpf_netdev_to_vport(netdev);
> +	struct idpf_vport_config *vport_config;
> +	struct page_pool_stats pp_stats = { };
> +	unsigned int total = 0;
> +	unsigned int i, j;
> +	bool is_splitq;
> +	u16 qtype;
> +
> +	if (!vport || vport->state != __IDPF_VPORT_UP)
> +		return;
> +
> +	rcu_read_lock();
> +
> +	idpf_collect_queue_stats(vport);
> +	idpf_add_port_stats(vport, &data);
> +
> +	for (i = 0; i < vport->num_txq_grp; i++) {
> +		struct idpf_txq_group *txq_grp = &vport->txq_grps[i];
> +
> +		qtype = VIRTCHNL2_QUEUE_TYPE_TX;
> +
> +		for (j = 0; j < txq_grp->num_txq; j++, total++) {
> +			struct idpf_queue *txq = txq_grp->txqs[j];
> +
> +			if (!txq)
> +				idpf_add_empty_queue_stats(&data, qtype);
> +			else
> +				idpf_add_queue_stats(&data, txq);
> +		}
> +	}
> +
> +	vport_config = vport->adapter->vport_config[vport->idx];
> +	/* It is critical we provide a constant number of stats back to
> +	 * userspace regardless of how many queues are actually in use because
> +	 * there is no way to inform userspace the size has changed between
> +	 * ioctl calls. This will fill in any missing stats with zero.
> +	 */
> +	for (; total < vport_config->max_q.max_txq; total++)
> +		idpf_add_empty_queue_stats(&data, VIRTCHNL2_QUEUE_TYPE_TX);
> +	total = 0;
> +
> +	is_splitq = idpf_is_queue_model_split(vport->rxq_model);
> +
> +	for (i = 0; i < vport->num_rxq_grp; i++) {
> +		struct idpf_rxq_group *rxq_grp = &vport->rxq_grps[i];
> +		u16 num_rxq;
> +
> +		qtype = VIRTCHNL2_QUEUE_TYPE_RX;
> +
> +		if (is_splitq)
> +			num_rxq = rxq_grp->splitq.num_rxq_sets;
> +		else
> +			num_rxq = rxq_grp->singleq.num_rxq;
> +
> +		for (j = 0; j < num_rxq; j++, total++) {
> +			struct idpf_queue *rxq;
> +
> +			if (is_splitq)
> +				rxq = &rxq_grp->splitq.rxq_sets[j]->rxq;
> +			else
> +				rxq = rxq_grp->singleq.rxqs[j];
> +			if (!rxq)

Hi Alan, Tony, all,

Here it is assumed that rxq may be NULl...

> +				idpf_add_empty_queue_stats(&data, qtype);
> +			else
> +				idpf_add_queue_stats(&data, rxq);
> +
> +			/* In splitq mode, don't get page pool stats here since
> +			 * the pools are attached to the buffer queues
> +			 */
> +			if (is_splitq)
> +				continue;
> +
> +			page_pool_get_stats(rxq->pp, &pp_stats);

... but here rxq is dereferenced.

Flagged by Smatch.

> +		}
> +	}

...

