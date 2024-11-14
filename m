Return-Path: <netdev+bounces-145095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 008659C9608
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 00:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8DD281011
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 23:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFA71B0F05;
	Thu, 14 Nov 2024 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOg8631n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D505B1AED3F
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731626432; cv=none; b=op5eC8olEnW9zWIZPIVi3tbm4gs7BkuN3bOyVIFtJYk1vr4FBVQeOk9kgvtzz54jDhgokYCPxDZQ3iobskasTwn9VjEHS+oPjZObXDOvJzYxylnNxlddeKWCBrhcO5fy2zJvyj9hrk7ELCAH+ODQ+J7bvqWfZpSiHPTjZMgDQc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731626432; c=relaxed/simple;
	bh=n2gMre4zaPjIrECP12coQMzm9rntlacAG/jFSdYtaS8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Uq0XNj4dNTvV7bLBR3ec/heEqvhL2W5sREWALV10IzrnEIZTGeeEwaubPzxSeJ1Blp5/JS8Z4Sl5AD1FP4xvUJfrbdiuTbHuvje9zmdWa45JzqTmCHtJwkKb/otcwRON5O55nDKVrMbhKzCal5nuMZSBy33lM6EpwKkn6i9wyXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOg8631n; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-460c1ba306bso7872131cf.2
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 15:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731626430; x=1732231230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hhbJF3cqdx94LP72fGPi0HCh8zamC8+LLvMwRDyU2Y=;
        b=dOg8631nBLFLoXXZJWgZ30wEajBS8hKbTaEvwNNqgL+N8M8FeAByrAL0BJUtkZg186
         PKV3AwimanLU0ilSTh1cu3MtNxetyGTm2W+7DXKxxBREpjoLc4ntzVJlH348sbXwSeiI
         355tvdmlMbY2X/ko/JN8nJSDZjg0z1E9AqU9I7xcF35++D2L7wg2Wy8Oq5ly1VtdUQXr
         X3eqli45PYzw72p2ut+vVgnuefHFRhLbl7AuMDygOqX1yeMBuqomso60mrGnJI9tGke/
         1LXev7vq3yIy0LOK/LWiNaOSyiZjv+dlRPBtmYOIEvbbwi4zPBEAynfRMeyFcr6RzZfz
         1hIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731626430; x=1732231230;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3hhbJF3cqdx94LP72fGPi0HCh8zamC8+LLvMwRDyU2Y=;
        b=OLQf2m8rG6ELVIS6DweYOWAydox3iMnpiJ3EL6+o69IKTnLwAHvDhlZiyigb6B/TT0
         Bpd3e1Bg6bV+t3jg8XJpC42fzVSyikSzDdhMkAf3qzsDGs8FGB+Ltq/BmPchz32KHF6m
         Y4NqdJqZPyuT2kRuXOgXZGKxUNA6nPvV2G9otY701OTTP70ZcvXKLOANAUROiPggikTW
         G+Bh01rU0YaritUIc4v0ZhXqAg2jqRUJB7tZubSqDjY3eWN5mXWAkhIkyw3paDTBN3uZ
         IQLnqkbhwN5XziD8rz2nFz75CUGgS28Un3iAznKVD5ZIIQOMFnlyv2z6zYg5dn0r2+6q
         RO6w==
X-Gm-Message-State: AOJu0YxnBb/gSfwFf5txlDCh8PapoN+GyYzndGo9rL2sflLmZvu0eCfE
	MMJSZe6jy9pVhX62QuQ5TyRkhwgaYwWYePb2tV057i2KnvF0URpr
X-Google-Smtp-Source: AGHT+IFBkFYf+uKEeJ8CjGMvCgBoPu/aNRVqF3CBQ9iXH6VfXdAn3//iS3Lq91AJxSKor0v5LOQ0iw==
X-Received: by 2002:a05:622a:4b0d:b0:458:2894:984e with SMTP id d75a77b69052e-46363de1df5mr8400321cf.3.1731626429701;
        Thu, 14 Nov 2024 15:20:29 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635ab62fb9sm11712591cf.73.2024.11.14.15.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:20:29 -0800 (PST)
Date: Thu, 14 Nov 2024 18:20:28 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Milena Olech <milena.olech@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, 
 anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, 
 Milena Olech <milena.olech@intel.com>, 
 Josh Hay <joshua.a.hay@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <673685bc9ef98_3379ce2948@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241113154616.2493297-9-milena.olech@intel.com>
References: <20241113154616.2493297-1-milena.olech@intel.com>
 <20241113154616.2493297-9-milena.olech@intel.com>
Subject: Re: [PATCH iwl-net 08/10] idpf: add Tx timestamp flows
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Milena Olech wrote:
> Add functions to request Tx timestamp for the PTP packets, read the Tx
> timestamp when the completion tag for that packet is being received,
> extend the Tx timestamp value and set the supported timestamping modes.
> 
> Tx timestamp is requested for the PTP packets by setting a TSYN bit and
> index value in the Tx context descriptor. The driver assumption is that
> the Tx timestamp value is ready to be read when the completion tag is
> received. Then the driver schedules delayed work and the Tx timestamp
> value read is requested through virtchnl message. At the end, the Tx
> timestamp value is extended to 64-bit and provided back to the skb.
> 
> Co-developed-by: Josh Hay <joshua.a.hay@intel.com>
> Signed-off-by: Josh Hay <joshua.a.hay@intel.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf.h        |   4 +
>  .../net/ethernet/intel/idpf/idpf_ethtool.c    |  63 +++++
>  .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |  13 +-
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    |  40 +++
>  drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 265 +++++++++++++++++-
>  drivers/net/ethernet/intel/idpf/idpf_ptp.h    |  57 ++++
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 136 ++++++++-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  10 +-
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   |   6 +-
>  .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   | 232 +++++++++++++++
>  10 files changed, 813 insertions(+), 13 deletions(-)
> 

> +/**
> + * idpf_set_timestamp_filters - Set the supported timestamping mode
> + * @vport: Virtual port structure
> + * @info: ethtool timestamping info structure
> + *
> + * Set the Tx/Rx timestamp filters.
> + */
> +static void idpf_set_timestamp_filters(const struct idpf_vport *vport,
> +				       struct kernel_ethtool_ts_info *info)
> +{
> +	if (!vport->tx_tstamp_caps ||
> +	    vport->adapter->ptp->tx_tstamp_access == IDPF_PTP_NONE)
> +		return;
> +
> +	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
> +				SOF_TIMESTAMPING_RX_SOFTWARE |
> +				SOF_TIMESTAMPING_SOFTWARE |
> +				SOF_TIMESTAMPING_TX_HARDWARE |
> +				SOF_TIMESTAMPING_RX_HARDWARE |
> +				SOF_TIMESTAMPING_RAW_HARDWARE;
> +

Drivers no longer need to set various software timestamping options
since commit "ethtool: RX software timestamp for all"

> +	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
> +}
> +
> +/**
> + * idpf_get_ts_info - Get device PHC association
> + * @netdev: network interface device structure
> + * @info: ethtool timestamping info structure
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int idpf_get_ts_info(struct net_device *netdev,
> +			    struct kernel_ethtool_ts_info *info)
> +{
> +	struct idpf_vport *vport;
> +	int err = 0;
> +
> +	idpf_vport_ctrl_lock(netdev);
> +	vport = idpf_netdev_to_vport(netdev);
> +
> +	if (!vport->adapter->ptp) {
> +		err = -EOPNOTSUPP;
> +		goto unlock;
> +	}
> +
> +	idpf_set_timestamp_filters(vport, info);
> +
> +	if (idpf_is_cap_ena(vport->adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_PTP) &&
> +	    vport->adapter->ptp->clock) {
> +		info->phc_index = ptp_clock_index(vport->adapter->ptp->clock);
> +	} else {
> +		pci_dbg(vport->adapter->pdev, "PTP clock not detected\n");
> +		err = ethtool_op_get_ts_info(netdev, info);
> +	}
> +
> +unlock:
> +	idpf_vport_ctrl_unlock(netdev);
> +
> +	return err;
> +}
> +
>  static const struct ethtool_ops idpf_ethtool_ops = {
>  	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
>  				     ETHTOOL_COALESCE_USE_ADAPTIVE,
> @@ -1336,6 +1398,7 @@ static const struct ethtool_ops idpf_ethtool_ops = {
>  	.get_ringparam		= idpf_get_ringparam,
>  	.set_ringparam		= idpf_set_ringparam,
>  	.get_link_ksettings	= idpf_get_link_ksettings,
> +	.get_ts_info		= idpf_get_ts_info,
>  };

> +/**
> + * idpf_ptp_tstamp_extend_32b_to_64b - Convert a 32b nanoseconds Tx timestamp
> + *				       to 64b.
> + * @cached_phc_time: recently cached copy of PHC time
> + * @in_timestamp: Ingress/egress 32b nanoseconds timestamp value
> + *
> + * Hardware captures timestamps which contain only 32 bits of nominal
> + * nanoseconds, as opposed to the 64bit timestamps that the stack expects.
> + *
> + * Return: Tx timestamp value extended to 64 bits based on cached PHC time.
> + */
> +u64 idpf_ptp_tstamp_extend_32b_to_64b(u64 cached_phc_time, u32 in_timestamp)
> +{
> +	u32 delta, phc_lo;
> +	u64 ns;
> +
> +	phc_lo = lower_32_bits(cached_phc_time);
> +	delta = in_timestamp - phc_lo;
> +
> +	if (delta > S32_MAX) {
> +		delta = phc_lo - in_timestamp;
> +		ns = cached_phc_time - delta;
> +	} else {
> +		ns = cached_phc_time + delta;
> +	}
> +
> +	return ns;
> +}

Consider a standard timecounter to estimate a device clock.

> +#if (IS_ENABLED(CONFIG_PTP_1588_CLOCK))
> +/**
> + * idpf_tx_tstamp - set up context descriptor for hardware timestamp
> + * @tx_q: queue to send buffer on
> + * @skb: pointer to the SKB we're sending
> + * @off: pointer to the offload struct
> + *
> + * Return: Positive index number on success, negative otherwise.
> + */
> +static int idpf_tx_tstamp(struct idpf_tx_queue *tx_q, struct sk_buff *skb,
> +			  struct idpf_tx_offload_params *off)
> +{
> +	int err, idx;
> +
> +	if (!idpf_ptp_get_txq_tstamp_capability(tx_q))
> +		return -1;
> +
> +	/* Tx timestamps cannot be sampled when doing TSO */
> +	if (off->tx_flags & IDPF_TX_FLAGS_TSO)
> +		return -1;
> +
> +	/* only timestamp the outbound packet if the user has requested it */
> +	if (likely(!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)))
> +		return -1;

Make this the first test. This function is being called on every
outgoing packet. It should be as cheap as possible in the likely
case where the PTP timestamp is not requested.

Even move this test to the callee if this does not get inlined.

>  /**
>   * idpf_tx_splitq_frame - Sends buffer on Tx ring using flex descriptors
>   * @skb: send buffer
> @@ -2743,9 +2859,10 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
>  					struct idpf_tx_queue *tx_q)
>  {
>  	struct idpf_tx_splitq_params tx_params = { };
> +	union idpf_flex_tx_ctx_desc *ctx_desc;
>  	struct idpf_tx_buf *first;
>  	unsigned int count;
> -	int tso;
> +	int tso, idx;
>  
>  	count = idpf_tx_desc_count_required(tx_q, skb);
>  	if (unlikely(!count))
> @@ -2765,8 +2882,7 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
>  
>  	if (tso) {
>  		/* If tso is needed, set up context desc */
> -		struct idpf_flex_tx_ctx_desc *ctx_desc =
> -			idpf_tx_splitq_get_ctx_desc(tx_q);
> +		ctx_desc = idpf_tx_splitq_get_ctx_desc(tx_q);
>  
>  		ctx_desc->tso.qw1.cmd_dtype =
>  				cpu_to_le16(IDPF_TX_DESC_DTYPE_FLEX_TSO_CTX |
> @@ -2784,6 +2900,12 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
>  		u64_stats_update_end(&tx_q->stats_sync);
>  	}
>  
> +	idx = idpf_tx_tstamp(tx_q, skb, &tx_params.offload);
> +	if (idx != -1) {
> +		ctx_desc = idpf_tx_splitq_get_ctx_desc(tx_q);
> +		idpf_tx_set_tstamp_desc(ctx_desc, idx);
> +	}
> +

Called here

> +/**
> + * idpf_ptp_get_tx_tstamp_async_handler - Async callback for getting Tx tstamps
> + * @adapter: Driver specific private structure
> + * @xn: transaction for message
> + * @ctlq_msg: received message
> + *
> + * Read the tstamps Tx tstamp values from a received message and put them
> + * directly to the skb. The number of timestamps to read is specified by
> + * the virtchnl message.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int
> +idpf_ptp_get_tx_tstamp_async_handler(struct idpf_adapter *adapter,
> +				     struct idpf_vc_xn *xn,
> +				     const struct idpf_ctlq_msg *ctlq_msg)
> +{
> +	struct virtchnl2_ptp_get_vport_tx_tstamp_latches *recv_tx_tstamp_msg;
> +	struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
> +	struct virtchnl2_ptp_tx_tstamp_latch tstamp_latch;
> +	struct idpf_ptp_tx_tstamp *ptp_tx_tstamp;
> +	struct idpf_vport *tstamp_vport = NULL;
> +	struct list_head *head;
> +	u16 num_latches;
> +	u32 vport_id;
> +	int err;
> +
> +	recv_tx_tstamp_msg = ctlq_msg->ctx.indirect.payload->va;
> +	vport_id = le32_to_cpu(recv_tx_tstamp_msg->vport_id);
> +
> +	idpf_for_each_vport(adapter, vport) {
> +		if (!vport)
> +			continue;
> +
> +		if (vport->vport_id == vport_id) {
> +			tstamp_vport = vport;
> +			break;
> +		}
> +	}

idpf_vid_to_vport?

> +
> +	if (!tstamp_vport || !tstamp_vport->tx_tstamp_caps)
> +		return -EINVAL;

