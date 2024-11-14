Return-Path: <netdev+bounces-145051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AA09C937C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 21:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48AEF2819E4
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 20:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B1F19E990;
	Thu, 14 Nov 2024 20:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUrGCmSQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DAB2905
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 20:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731617622; cv=none; b=Lp18YnyJuOaIh/JRO/B4lwhyC1tLKV1lLq4a122DLJcNcDiov8iDghyA3GwxG8ZKWkZxN8CTudCZt4DlK1DaxPN9LoC5xYXBIXWin1A+1veUCoeMoVRoIX4IG21Ho3VCdvf6zEeD0YzbfJDQTMNlHlfJwvcsTKDpHki/UpCQOA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731617622; c=relaxed/simple;
	bh=jXAXwmRyyyug5MhFzZFOzL7BPIdOZwmywlyN1eU0asM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CURMa9AnBH0dUFWIR0If0cfcflzK4xhZAmQYg+bg8MiEwQzB48RdP1t+2J0/soFFQs7RzFR9gzmFSOOOcxyJU/C6wX1O/QCktFYcAmcRWhAoFuQJL7gBD2jb0o4Lz39HLbRLNJ1zAo1pWyrWKmdfmzf5GaVjif4mTMx5XXn5Z4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUrGCmSQ; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cbcc2bd800so9243776d6.0
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 12:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731617620; x=1732222420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xs4vJU+kzHF8AXBXurcYgn4Nl7S3rirwZKa799ggXkk=;
        b=LUrGCmSQuJ4yX6+uG15T4VHz8EoOS/zoII1vc25lsht44TsOQivGZvjVjV1Zd09FWe
         b5T5GMenoVt6E8etbfi1g1YCW44Poq0NS3RSvQE9LLWO7CSH/S8AeNgv9bvlFcgGXVIc
         UOLBqvHFQ7OfUrn+zXX7Ph7Eu7sQai1LGhVXkOTPre0/GgQxtWlqGBBNwri0/wHmPYh1
         PMkpEkADlSMqY7g7sybUMWtevw2kXbzWOqbvGAFtceZK2RNyl3hfhQwd4b94TTu+2gxL
         UrtKF1T3VMSt67YzwhhdMuzUoo1MrmBbiHAifmRbsK/PSpnY6c4ADJx0QSz52/OcMnOr
         caXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731617620; x=1732222420;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xs4vJU+kzHF8AXBXurcYgn4Nl7S3rirwZKa799ggXkk=;
        b=Rh25bbXswKEpd7D0ilVjTuea8XZ1OhpGdC7fX5yXCymHeJsigef7gbMrOA3fl6kz1f
         W0p8y6SfpoN4JpevQOQilDtyyQV8n/d4utS3Uthk3ub4STtOYMO2uXEwosV3GAxVO7B9
         aWemPG2KJOe/IqCfLYjexb9eFnplWJC4Hs+Gq6wWPKChSg5OKXHqqaw5RqU3DhATpRoL
         fM5VDY9QkadfF22Uop25+6JUZjmjsz524zPlUsH5KTVSKocqP19QrDXni9j3k1WI5wh7
         Qj+H9HDzW5WwKeyc/XJXqPgFPnovbjzU5vqg/QdgjNCD/KgGbno/rdfMS7jQs9mAZO7Q
         pcvQ==
X-Gm-Message-State: AOJu0Yx6v+Vi5QgqEPHN+ksy9lLPDhBBh7MPgHCC/XDtNVJMNp2GePXW
	q4BCcZLUC5p8YlH3ljYJyPZ/jLnYc1nI0aYPjeoNmQAzV3ZXUZXA
X-Google-Smtp-Source: AGHT+IExxThiz8yFS4GkRT/sNi3iT0zykfKtcp3oEj5kKylvkfzu62N9oX/R4KU5BT0e6LXKmdRB1Q==
X-Received: by 2002:a05:6214:27c5:b0:6cb:9a1c:cfae with SMTP id 6a1803df08f44-6d3e8fcb392mr76737136d6.6.1731617619727;
        Thu, 14 Nov 2024 12:53:39 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3f94882ebsm3813656d6.10.2024.11.14.12.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 12:53:39 -0800 (PST)
Date: Thu, 14 Nov 2024 15:53:38 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Milena Olech <milena.olech@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, 
 anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, 
 Milena Olech <milena.olech@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <67366352c2c5b_3379ce29475@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241113154616.2493297-10-milena.olech@intel.com>
References: <20241113154616.2493297-1-milena.olech@intel.com>
 <20241113154616.2493297-10-milena.olech@intel.com>
Subject: Re: [PATCH iwl-net 09/10] idpf: add support for Rx timestamping
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
> Add Rx timestamp function when the Rx timestamp value is read directly
> from the Rx descriptor. Add supported Rx timestamp modes.
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_ptp.c  | 74 ++++++++++++++++++++-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 30 +++++++++
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h |  7 +-
>  3 files changed, 109 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> index f34642d10768..f9f7613f2a6d 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> @@ -317,12 +317,41 @@ static int idpf_ptp_gettimex64(struct ptp_clock_info *info,
>  	return 0;
>  }
>  
> +/**
> + * idpf_ptp_update_phctime_rxq_grp - Update the cached PHC time for a given Rx
> + *				     queue group.

Why does each receive group have a separate cached value?
They're all caches of the same device clock.

> + * @grp: receive queue group in which Rx timestamp is enabled
> + * @split: Indicates whether the queue model is split or single queue
> + * @systime: Cached system time
> + */
> +static void
> +idpf_ptp_update_phctime_rxq_grp(const struct idpf_rxq_group *grp, bool split,
> +				u64 systime)
> +{
> +	struct idpf_rx_queue *rxq;
> +	u16 i;
> +
> +	if (!split) {
> +		for (i = 0; i < grp->singleq.num_rxq; i++) {
> +			rxq = grp->singleq.rxqs[i];
> +			if (rxq)
> +				WRITE_ONCE(rxq->cached_phc_time, systime);
> +		}
> +	} else {
> +		for (i = 0; i < grp->splitq.num_rxq_sets; i++) {
> +			rxq = &grp->splitq.rxq_sets[i]->rxq;
> +			if (rxq)
> +				WRITE_ONCE(rxq->cached_phc_time, systime);
> +		}
> +	}
> +}
> +

> +/**
> + * idpf_ptp_set_rx_tstamp - Enable or disable Rx timestamping
> + * @vport: Virtual port structure
> + * @rx_filter: bool value for whether timestamps are enabled or disabled
> + */
> +static void idpf_ptp_set_rx_tstamp(struct idpf_vport *vport, int rx_filter)
> +{
> +	vport->tstamp_config.rx_filter = rx_filter;
> +
> +	if (rx_filter == HWTSTAMP_FILTER_NONE)
> +		return;

Should this clear the bit if it was previously set, instead of returning immediately?
> +
> +	for (u16 i = 0; i < vport->num_rxq_grp; i++) {
> +		struct idpf_rxq_group *grp = &vport->rxq_grps[i];
> +		u16 j;
> +
> +		if (idpf_is_queue_model_split(vport->rxq_model)) {
> +			for (j = 0; j < grp->singleq.num_rxq; j++)
> +				idpf_queue_set(PTP, grp->singleq.rxqs[j]);
> +		} else {
> +			for (j = 0; j < grp->splitq.num_rxq_sets; j++)
> +				idpf_queue_set(PTP,
> +					       &grp->splitq.rxq_sets[j]->rxq);
> +		}
> +	}
> +}

> +static void
> +idpf_rx_hwtstamp(const struct idpf_rx_queue *rxq,
> +		 const struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc,
> +		 struct sk_buff *skb)
> +{
> +	u64 cached_time, ts_ns;
> +	u32 ts_high;
> +
> +	if (!(rx_desc->ts_low & VIRTCHNL2_RX_FLEX_TSTAMP_VALID))
> +		return;
> +
> +	cached_time = READ_ONCE(rxq->cached_phc_time);
> +
> +	ts_high = le32_to_cpu(rx_desc->ts_high);
> +	ts_ns = idpf_ptp_tstamp_extend_32b_to_64b(cached_time, ts_high);
> +
> +	*skb_hwtstamps(skb) = (struct skb_shared_hwtstamps) {
> +		.hwtstamp = ns_to_ktime(ts_ns),
> +	};

Simpler: skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(ts_ns);

