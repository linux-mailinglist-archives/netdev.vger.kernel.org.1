Return-Path: <netdev+bounces-74849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF2B866EEB
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 10:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86122877B8
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 09:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7707B3D7;
	Mon, 26 Feb 2024 09:07:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC2A7AE64
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938472; cv=none; b=eg6kkI4umzsOf6gSkhNooToTKNpPz7qu81LGhHlxsCxYjjNKTPVuQULRrm6wByWHr/EWbltAB0qM0gE4vX8FxEXfPvbVx26R1a8KD5CjsWPYeXCUwbF4oCj65PDTlc2lxRjPsfiYNrfrG5IljMsilcB7eApPWqmIVOAMveTX1tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938472; c=relaxed/simple;
	bh=mFsejBxedUYkfl53PwVrlxDbOleTrlowHBxZKX2wWJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KeSUtLav/zXs4c6NuO0lGxeXBmyxuBxali8ngpGi4L1tCgk8xERKB6tzbqT8Q5HAsROuMcEEIy+x2U+LHAvZM63LA2djaO3Zd4hDZL337egUa2VZt+ZplA+qtddCFVwQbjNcDEmS7YIR5OX4yUR0Rw3QvzV6XO9Wu9ZI6tWp+zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.6] (ip5f5af3a7.dynamic.kabel-deutschland.de [95.90.243.167])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 511C961E5FE04;
	Mon, 26 Feb 2024 10:06:53 +0100 (CET)
Message-ID: <fa67869c-3060-430e-a1c5-c67305e848c2@molgen.mpg.de>
Date: Mon, 26 Feb 2024 10:06:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] igc: Add MQPRIO offload
 support
Content-Language: en-US
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, netdev@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 intel-wired-lan@lists.osuosl.org
References: <20240212-igc_mqprio-v1-1-7aed95b736db@linutronix.de>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240212-igc_mqprio-v1-1-7aed95b736db@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kurt,


Thank you for the patch. Some nits from my side.

Am 26.02.24 um 09:51 schrieb Kurt Kanzenbach:
> Add support for offloading MQPRIO. The hardware has four priorities as well
> as four queues. Each queue must be a assigned with a unique priority.
> 
> However, the priorities are only considered in TSN Tx mode. There are two
> TSN Tx modes. In case of MQPRIO the Qbv capability is not
> required. Therefore, use the legacy TSN Tx mode, which performs strict
> priority arbitration.

You could reflow this paragraph. The second line breaks too early.

> Example for mqprio with hardware offload:
> 
> |tc qdisc replace dev ${INTERFACE} handle 100 parent root mqprio num_tc 4 \
> |   map 0 0 0 0 0 1 2 3 0 0 0 0 0 0 0 0 \
> |   queues 1@0 1@1 1@2 1@3 \
> |   hw 1

Thank you for the example. How can you check that it actually works? No 
errors are shown?

Also, could you please mention the datasheet name, revision and section, 
and on what exact device you tested this?

> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>   drivers/net/ethernet/intel/igc/igc.h         | 10 +++-
>   drivers/net/ethernet/intel/igc/igc_defines.h |  9 ++++
>   drivers/net/ethernet/intel/igc/igc_main.c    | 69 +++++++++++++++++++++++++++
>   drivers/net/ethernet/intel/igc/igc_regs.h    |  2 +
>   drivers/net/ethernet/intel/igc/igc_tsn.c     | 71 +++++++++++++++++++++++++++-
>   5 files changed, 157 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index 45430e246e9c..c95919f085eb 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -227,6 +227,10 @@ struct igc_adapter {
>   	 */
>   	spinlock_t qbv_tx_lock;
>   
> +	bool strict_priority_enable;
> +	u8 num_tc;
> +	u16 queue_per_tc[IGC_MAX_TX_QUEUES];
> +
>   	/* OS defined structs */
>   	struct pci_dev *pdev;
>   	/* lock for statistics */
> @@ -343,9 +347,11 @@ extern char igc_driver_name[];
>   #define IGC_FLAG_RX_LEGACY		BIT(16)
>   #define IGC_FLAG_TSN_QBV_ENABLED	BIT(17)
>   #define IGC_FLAG_TSN_QAV_ENABLED	BIT(18)
> +#define IGC_FLAG_TSN_LEGACY_ENABLED	BIT(19)
>   
> -#define IGC_FLAG_TSN_ANY_ENABLED \
> -	(IGC_FLAG_TSN_QBV_ENABLED | IGC_FLAG_TSN_QAV_ENABLED)
> +#define IGC_FLAG_TSN_ANY_ENABLED				\
> +	(IGC_FLAG_TSN_QBV_ENABLED | IGC_FLAG_TSN_QAV_ENABLED |	\
> +	 IGC_FLAG_TSN_LEGACY_ENABLED)
>   
>   #define IGC_FLAG_RSS_FIELD_IPV4_UDP	BIT(6)
>   #define IGC_FLAG_RSS_FIELD_IPV6_UDP	BIT(7)
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index 5f92b3c7c3d4..73502a0b4df7 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -547,6 +547,15 @@
>   
>   #define IGC_MAX_SR_QUEUES		2
>   
> +#define IGC_TXARB_TXQ_PRIO_0_SHIFT	0
> +#define IGC_TXARB_TXQ_PRIO_1_SHIFT	2
> +#define IGC_TXARB_TXQ_PRIO_2_SHIFT	4
> +#define IGC_TXARB_TXQ_PRIO_3_SHIFT	6
> +#define IGC_TXARB_TXQ_PRIO_0_MASK	GENMASK(1, 0)
> +#define IGC_TXARB_TXQ_PRIO_1_MASK	GENMASK(3, 2)
> +#define IGC_TXARB_TXQ_PRIO_2_MASK	GENMASK(5, 4)
> +#define IGC_TXARB_TXQ_PRIO_3_MASK	GENMASK(7, 6)
> +
>   /* Receive Checksum Control */
>   #define IGC_RXCSUM_CRCOFL	0x00000800   /* CRC32 offload enable */
>   #define IGC_RXCSUM_PCSD		0x00002000   /* packet checksum disabled */
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index ba8d3fe186ae..c5d3cc3c4fa9 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -6424,6 +6424,13 @@ static int igc_tc_query_caps(struct igc_adapter *adapter,
>   	struct igc_hw *hw = &adapter->hw;
>   
>   	switch (base->type) {
> +	case TC_SETUP_QDISC_MQPRIO: {
> +		struct tc_mqprio_caps *caps = base->caps;
> +
> +		caps->validate_queue_counts = true;
> +
> +		return 0;
> +	}
>   	case TC_SETUP_QDISC_TAPRIO: {
>   		struct tc_taprio_caps *caps = base->caps;
>   
> @@ -6441,6 +6448,65 @@ static int igc_tc_query_caps(struct igc_adapter *adapter,
>   	}
>   }
>   
> +static void igc_save_mqprio_params(struct igc_adapter *adapter, u8 num_tc,
> +				   u16 *offset)
> +{
> +	int i;
> +
> +	adapter->strict_priority_enable = true;
> +	adapter->num_tc = num_tc;
> +
> +	for (i = 0; i < num_tc; i++)
> +		adapter->queue_per_tc[i] = offset[i];
> +}
> +
> +static int igc_tsn_enable_mqprio(struct igc_adapter *adapter,
> +				 struct tc_mqprio_qopt_offload *mqprio)
> +{
> +	struct igc_hw *hw = &adapter->hw;
> +	int i;
> +
> +	if (hw->mac.type != igc_i225)
> +		return -EOPNOTSUPP;
> +
> +	if (!mqprio->qopt.num_tc) {
> +		adapter->strict_priority_enable = false;
> +		goto apply;
> +	}
> +
> +	/* There are as many TCs as Tx queues. */
> +	if (mqprio->qopt.num_tc != adapter->num_tx_queues) {
> +		NL_SET_ERR_MSG_FMT_MOD(mqprio->extack,
> +				       "Only %d traffic classes supported",
> +				       adapter->num_tx_queues);

I’d also log `mqprio->qopt.num_tc`.

> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* Only one queue per TC is supported. */
> +	for (i = 0; i < mqprio->qopt.num_tc; i++) {
> +		if (mqprio->qopt.count[i] != 1) {
> +			NL_SET_ERR_MSG_MOD(mqprio->extack,
> +					   "Only one queue per TC supported");

I’d also log the i and the count value.

> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
> +	/* Preemption is not supported yet. */
> +	if (mqprio->preemptible_tcs) {
> +		NL_SET_ERR_MSG_MOD(mqprio->extack,
> +				   "Preemption is not supported yet");
> +		return -EOPNOTSUPP;
> +	}

Please mention this in the commit message, maybe also included, if a 
patch is coming soon, or what would need to be done to implement it.

> +
> +	igc_save_mqprio_params(adapter, mqprio->qopt.num_tc,
> +			       mqprio->qopt.offset);
> +
> +	mqprio->qopt.hw = TC_MQPRIO_HW_OFFLOAD_TCS;
> +
> +apply:
> +	return igc_tsn_offload_apply(adapter);
> +}
> +
>   static int igc_setup_tc(struct net_device *dev, enum tc_setup_type type,
>   			void *type_data)
>   {
> @@ -6460,6 +6526,9 @@ static int igc_setup_tc(struct net_device *dev, enum tc_setup_type type,
>   	case TC_SETUP_QDISC_CBS:
>   		return igc_tsn_enable_cbs(adapter, type_data);
>   
> +	case TC_SETUP_QDISC_MQPRIO:
> +		return igc_tsn_enable_mqprio(adapter, type_data);
> +
>   	default:
>   		return -EOPNOTSUPP;
>   	}
> diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
> index d38c87d7e5e8..548764cceba4 100644
> --- a/drivers/net/ethernet/intel/igc/igc_regs.h
> +++ b/drivers/net/ethernet/intel/igc/igc_regs.h
> @@ -237,6 +237,8 @@
>   #define IGC_TQAVCC(_n)		(0x3004 + ((_n) * 0x40))
>   #define IGC_TQAVHC(_n)		(0x300C + ((_n) * 0x40))
>   
> +#define IGC_TXARB		0x3354 /* Tx Arbitration Control TxARB - RW */
> +
>   /* System Time Registers */
>   #define IGC_SYSTIML	0x0B600  /* System time register Low - RO */
>   #define IGC_SYSTIMH	0x0B604  /* System time register High - RO */
> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
> index 22cefb1eeedf..5e2e1c6076f3 100644
> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
> @@ -46,6 +46,9 @@ static unsigned int igc_tsn_new_flags(struct igc_adapter *adapter)
>   	if (is_cbs_enabled(adapter))
>   		new_flags |= IGC_FLAG_TSN_QAV_ENABLED;
>   
> +	if (adapter->strict_priority_enable)
> +		new_flags |= IGC_FLAG_TSN_LEGACY_ENABLED;
> +
>   	return new_flags;
>   }
>   
> @@ -84,7 +87,7 @@ void igc_tsn_adjust_txtime_offset(struct igc_adapter *adapter)
>   static int igc_tsn_disable_offload(struct igc_adapter *adapter)
>   {
>   	struct igc_hw *hw = &adapter->hw;
> -	u32 tqavctrl;
> +	u32 tqavctrl, txarb;
>   	int i;
>   
>   	wr32(IGC_GTXOFFSET, 0);
> @@ -106,7 +109,26 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
>   	wr32(IGC_QBVCYCLET_S, 0);
>   	wr32(IGC_QBVCYCLET, NSEC_PER_SEC);
>   
> +	/* Reset mqprio TC configuration. */
> +	netdev_reset_tc(adapter->netdev);
> +
> +	/* Restore the default Tx arbitration: Priority 0 has the highest
> +	 * priority and is assigned to queue 0 and so on and so forth.
> +	 */
> +	txarb = rd32(IGC_TXARB);
> +	txarb &= ~(IGC_TXARB_TXQ_PRIO_0_MASK |
> +		   IGC_TXARB_TXQ_PRIO_1_MASK |
> +		   IGC_TXARB_TXQ_PRIO_2_MASK |
> +		   IGC_TXARB_TXQ_PRIO_3_MASK);
> +
> +	txarb |= 0x00 << IGC_TXARB_TXQ_PRIO_0_SHIFT;
> +	txarb |= 0x01 << IGC_TXARB_TXQ_PRIO_1_SHIFT;
> +	txarb |= 0x02 << IGC_TXARB_TXQ_PRIO_2_SHIFT;
> +	txarb |= 0x03 << IGC_TXARB_TXQ_PRIO_3_SHIFT;
> +	wr32(IGC_TXARB, txarb);
> +
>   	adapter->flags &= ~IGC_FLAG_TSN_QBV_ENABLED;
> +	adapter->flags &= ~IGC_FLAG_TSN_LEGACY_ENABLED;
>   
>   	return 0;
>   }
> @@ -123,6 +145,50 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
>   	wr32(IGC_DTXMXPKTSZ, IGC_DTXMXPKTSZ_TSN);
>   	wr32(IGC_TXPBS, IGC_TXPBSIZE_TSN);
>   
> +	if (adapter->strict_priority_enable) {
> +		u32 txarb;
> +		int err;
> +
> +		err = netdev_set_num_tc(adapter->netdev, adapter->num_tc);
> +		if (err)
> +			return err;
> +
> +		for (i = 0; i < adapter->num_tc; i++) {
> +			err = netdev_set_tc_queue(adapter->netdev, i, 1,
> +						  adapter->queue_per_tc[i]);
> +			if (err)
> +				return err;
> +		}
> +
> +		/* In case the card is configured with less than four queues. */
> +		for (; i < IGC_MAX_TX_QUEUES; i++)
> +			adapter->queue_per_tc[i] = i;
> +
> +		/* Configure queue priorities according to the user provided
> +		 * mapping.
> +		 */
> +		txarb = rd32(IGC_TXARB);
> +		txarb &= ~(IGC_TXARB_TXQ_PRIO_0_MASK |
> +			   IGC_TXARB_TXQ_PRIO_1_MASK |
> +			   IGC_TXARB_TXQ_PRIO_2_MASK |
> +			   IGC_TXARB_TXQ_PRIO_3_MASK);
> +		txarb |= adapter->queue_per_tc[3] << IGC_TXARB_TXQ_PRIO_0_SHIFT;
> +		txarb |= adapter->queue_per_tc[2] << IGC_TXARB_TXQ_PRIO_1_SHIFT;
> +		txarb |= adapter->queue_per_tc[1] << IGC_TXARB_TXQ_PRIO_2_SHIFT;
> +		txarb |= adapter->queue_per_tc[0] << IGC_TXARB_TXQ_PRIO_3_SHIFT;
> +		wr32(IGC_TXARB, txarb);
> +
> +		/* Enable legacy TSN mode which will do strict priority without
> +		 * any other TSN features.
> +		 */
> +		tqavctrl = rd32(IGC_TQAVCTRL);
> +		tqavctrl |= IGC_TQAVCTRL_TRANSMIT_MODE_TSN;
> +		tqavctrl &= ~IGC_TQAVCTRL_ENHANCED_QAV;
> +		wr32(IGC_TQAVCTRL, tqavctrl);
> +
> +		return 0;
> +	}
> +
>   	for (i = 0; i < adapter->num_tx_queues; i++) {
>   		struct igc_ring *ring = adapter->tx_ring[i];
>   		u32 txqctl = 0;
> @@ -339,7 +405,8 @@ int igc_tsn_offload_apply(struct igc_adapter *adapter)
>   	 * cannot be changed dynamically. Require reset the adapter.
>   	 */
>   	if (netif_running(adapter->netdev) &&
> -	    (igc_is_device_id_i225(hw) || !adapter->qbv_count)) {
> +	    (igc_is_device_id_i225(hw) || !adapter->qbv_count ||
> +	     !adapter->strict_priority_enable)) {
>   		schedule_work(&adapter->reset_task);
>   		return 0;
>   	}


Kind regards,

Paul

