Return-Path: <netdev+bounces-147871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA3B9DE9EE
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 16:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E478D282A04
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 15:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74518145324;
	Fri, 29 Nov 2024 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQ8D3Pqp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C9113D619
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732895183; cv=none; b=EXMD4P/bkT6cMqgxzC7MjA6a0EjmaBHKofv39yye/ClCk4eGoa8hKZ7M0G6O3dgNLqkS1x2nkC4kovrlxTyPMXflabZP34X//A/LPw3iY8qLwp64GUaEurNsi/NdYdGKZ+lH0N3bBxjYmoY5qDRPynAaFuBfZNcR4IxLjubBmyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732895183; c=relaxed/simple;
	bh=6d6VzwdlWq1q354a+1wNljtYfURBDYq0F4W7Ym/7mLQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VGBc2mrBB5r7B061LBL1B9MhxL3xDoGB7SH4+4TiA46X80rpyplN1CD1BSyXT4F9Hb/xmAhAYlR0nZ8aa7hOie+GfgOUpj8VE5A8VKuNXOGyNsJje7P8OnvGblpq+cHpbugFjvg94VKXMAsd+B1jDxL6GirFYNUj6QxaUQctOzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQ8D3Pqp; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-46695dd02e8so19167511cf.2
        for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 07:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732895180; x=1733499980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcN/VjQsWEr8cckNhEae5YA0C7hq6vEXjZlBRJIXtGM=;
        b=MQ8D3PqpD7g7/E1Lk7l724C6tdW2jlK8YqP5LLk1R2T5zTLJXm5LN3fJafl38bG7FE
         +FH3nj2nyYirvxKlcLlhYshZ9Seim7GsINn9lAMtNqtfCBeF+ga7zpL69YKrA1tDzyj+
         fXXJ34mW16NnvLNbJfuzua4mK/Gl9FxcxOx5waTBrsBQXLSBn4NfC4nMTMaISy6oFIKO
         7sZsQ72VFt3FoCAMmCa3SyOtPHJ+YDaeFT5cPOog7n18HFMs647bMiVaO/bs05VD+qJ2
         b9LQ8bEhdnXkRUuS4WHhKUOwyhms+gug8GBmRO4wXKbEAz6BR49Mv4peZ2OUqTCZQCrK
         PNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732895180; x=1733499980;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rcN/VjQsWEr8cckNhEae5YA0C7hq6vEXjZlBRJIXtGM=;
        b=Z6y/qU9rfGvaHl5Fqbd6xA6niCkNL0Zz1G3V2NC0Wpg8h6qoGefygWYw5D9ezKlOeH
         mAIrgPSQcH2TOC5ckE/XcoAXZr7x2H8J7YqduZheCreZgIA/IhjnnqJBzhQ/wITKEz3S
         RwQoXF//VbHpmqqJi3etP8K+x6VZayNj7TO84hTmO0vKWzlgK/KVHJ99bZSc6uRySgTu
         eGl8zzQA2myhdDv3AtrE+ex/q5jVJxgnVYIn+QepFd8Ojx6xLut3h/O0tLVcN1ycGrBN
         bqP2K4C0yg+C++jgNZPTDO14Z8khonrPW7V3pIWuiVo0gVs88MbUa6SS2KRnkMWa5mSl
         voMQ==
X-Gm-Message-State: AOJu0YwD6nO2bK6uch6SeJZdypKJuho9zrAkAZBPiqxJ4CGu7Qg/Hrgb
	k2IUfVMPGrkFzcMmB+867eK2YSM/rnK7uX2JUaDIs0EOHR/wJT1y
X-Gm-Gg: ASbGnculDz8egJsBOA8HBwObBwyIOqRIbFSpcBbLqZ7mgZtskULWnUYO3pqrFJsaLhY
	Hh1oHMx2+5qXU2PvtgS+fTgsASEQXQ2P0CH3vGza0LgQjkcDXcBQl+ag0nc0X90ZP1Vd5Tg4qGF
	cvgjMgjxAJUaptp4ZFAhY2v+CTjUqx9LpqzqtEfj/gbflalRfbtFOrUVVjEKR5aSSZfuTMCea1p
	zRYWjgPvTNLDPtYmCuXzTmBwRCjYea46S8TUEjg99T/OzrNxRB6C4SxCcQool7uWXRoXgxR+QNT
	bplIAUaUR8PcWPqriaruXA==
X-Google-Smtp-Source: AGHT+IHYyrbyrklERwq9PyaRMbk3QF4tKiBra/sb4wYtb1bzFFpjwstgScktKEVHHZIRccgHBQEnBg==
X-Received: by 2002:a05:620a:6086:b0:7b6:6701:7a48 with SMTP id af79cd13be357-7b67c4a0ea8mr1987376985a.61.1732895180542;
        Fri, 29 Nov 2024 07:46:20 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b684946dc0sm150709585a.57.2024.11.29.07.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 07:46:20 -0800 (PST)
Date: Fri, 29 Nov 2024 10:46:19 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Milena Olech <milena.olech@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, 
 anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, 
 Milena Olech <milena.olech@intel.com>, 
 Josh Hay <joshua.a.hay@intel.com>
Message-ID: <6749e1cb95bed_23772a2944b@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241126035849.6441-9-milena.olech@intel.com>
References: <20241126035849.6441-1-milena.olech@intel.com>
 <20241126035849.6441-9-milena.olech@intel.com>
Subject: Re: [PATCH v2 iwl-next 08/10] idpf: add Tx timestamp flows
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
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> ---
> v1 -> v2: add timestamping stats, use ndo_hwtamp_get/ndo_hwstamp_set

> +/**
> + * idpf_set_timestamp_filters - Set the supported timestamping mode
> + * @vport: Virtual port structure
> + * @info: ethtool timestamping info structure
> + *
> + * Set the Tx/Rx timestamp filters.
> + */
> +static void idpf_set_timestamp_filters(const struct idpf_vport *vport,
> +				       struct kernel_ethtool_ts_info *info)

This is not really a setter. It modifies no vport state.

idpf_get_timestamp_filters? Or just merge into the below caller.

> +{
> +	if (!vport->tx_tstamp_caps ||
> +	    vport->adapter->ptp->tx_tstamp_access == IDPF_PTP_NONE)
> +		return;
> +
> +	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
> +				SOF_TIMESTAMPING_TX_HARDWARE |
> +				SOF_TIMESTAMPING_RX_HARDWARE |
> +				SOF_TIMESTAMPING_RAW_HARDWARE;
> +
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
> +	struct idpf_adapter *adapter = idpf_netdev_to_adapter(netdev);
> +	struct idpf_vport *vport;
> +	int err = 0;
> +
> +	idpf_vport_cfg_lock(adapter);
> +	vport = idpf_netdev_to_vport(netdev);
> +
> +	if (!vport->adapter->ptp) {
> +		err = -EOPNOTSUPP;
> +		goto unlock;
> +	}
> +
> +	idpf_set_timestamp_filters(vport, info);

Probably move this in the below if, als it gets entirely overwritten
if the else is taken.
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
> +	idpf_vport_cfg_unlock(adapter);
> +
> +	return err;
> +}

> +/**
> + * idpf_ptp_extend_ts - Convert a 40b timestamp to 64b nanoseconds
> + * @vport: Virtual port structure
> + * @in_tstamp: Ingress/egress timestamp value
> + *
> + * It is assumed that the caller verifies the timestamp is valid prior to
> + * calling this function.
> + *
> + * Extract the 32bit nominal nanoseconds and extend them. Use the cached PHC
> + * time stored in the device private PTP structure as the basis for timestamp
> + * extension.
> + *
> + * Return: Tx timestamp value extended to 64 bits.
> + */
> +u64 idpf_ptp_extend_ts(struct idpf_vport *vport, u64 in_tstamp)
> +{
> +	struct idpf_ptp *ptp = vport->adapter->ptp;
> +	unsigned long discard_time;
> +
> +	discard_time = ptp->cached_phc_jiffies + 2 * HZ;
> +
> +	if (time_is_before_jiffies(discard_time)) {
> +		vport->tstamp_stats.tx_hwtstamp_discarded++;
> +		return 0;
> +	}
> +
> +	return idpf_ptp_tstamp_extend_32b_to_64b(ptp->cached_phc_time,
> +						 lower_32_bits(in_tstamp));
> +}

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
> +	/* only timestamp the outbound packet if the user has requested it */
> +	if (likely(!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)))
> +		return -1;
> +
> +	if (!idpf_ptp_get_txq_tstamp_capability(tx_q))
> +		return -1;
> +
> +	/* Tx timestamps cannot be sampled when doing TSO */
> +	if (off->tx_flags & IDPF_TX_FLAGS_TSO)
> +		return -1;
> +
> +	/* Grab an open timestamp slot */
> +	err = idpf_ptp_request_ts(tx_q, skb, &idx);
> +	if (err) {
> +		tx_q->txq_grp->vport->tstamp_stats.tx_hwtstamp_skipped++;

What is the mutual exclusion on these stats fields?

In ndo_start_xmit the txq lock is held, but no vport wide lock?

> +		return -1;
> +	}
> +
> +	off->tx_flags |= IDPF_TX_FLAGS_TSYN;
> +
> +	return idx;
> +}

