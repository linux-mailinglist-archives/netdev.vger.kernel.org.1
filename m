Return-Path: <netdev+bounces-69830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E44C84CC28
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3E829008B
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 13:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B2477F20;
	Wed,  7 Feb 2024 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxVPdrK/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCBD1E499
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707314232; cv=none; b=cgs5icIDo9LMGCS2stirjiPkfzAokcSrl4t5JJNJrHSkZAjwIdee03AI9C6aaeJoBIAgdiN6i91vvevY/Jm2EVIDUjHXU6LfndcuCJqc1O2v3gJvin/lK2BMztMtpB1bDDVYooWtofwfXTf+hSyP8KI1LNrcICpUWXzaa5t6pOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707314232; c=relaxed/simple;
	bh=ZKbHAdPSxFjL+QsWSRsm1Xq856avq8hYQeDJezdKKdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MB6JeIpNIFqgI00VBCZ0gi2L90k+hc+V1Qrnw5Oes3CADm2W2uz6x+rL3nPM49YW5GdS9FZbs3G/tgVvz7ttzcs7ZB2Y6WCaLcYwZyQ6JkJeK6C6u7pfbopp54FSXv4Zvb2P7SpUcYzC0svLHD2X/hW72Wqmm182N/QXnQQ0QPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OxVPdrK/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707314229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SJWbOOPpNp6pIwb5DBnwYalBOWA2pdGW/NlT+/6riTc=;
	b=OxVPdrK/cBfpwxXc4/+jXckZA0kvvxlRS1IP6pjv9Rl9kTfLgXkTAJFo86kTBmCQ57A6lV
	d3iHt+k7NFDjrnd1VmUDIRi5YPCbycCcfvwVN3sLjrBSElilYJCdPRW92CuhhN1+7Vvrij
	0foFXjJqhHcbYQNLLHWNLN1k1Q3vDfA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-PWcOvnFoN2SfCsupwSLdbQ-1; Wed, 07 Feb 2024 08:57:03 -0500
X-MC-Unique: PWcOvnFoN2SfCsupwSLdbQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99BAB84ACA3;
	Wed,  7 Feb 2024 13:57:02 +0000 (UTC)
Received: from [10.45.225.55] (unknown [10.45.225.55])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B19DA2026D06;
	Wed,  7 Feb 2024 13:57:01 +0000 (UTC)
Message-ID: <0294ada0-b0ae-47ea-8b58-247c916468dd@redhat.com>
Date: Wed, 7 Feb 2024 14:57:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iwl-net 1/2] i40e: avoid double calling
 i40e_pf_rxq_wait()
Content-Language: en-US
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 magnus.karlsson@intel.com, Simon Horman <horms@kernel.org>
References: <20240206124132.636342-1-maciej.fijalkowski@intel.com>
 <20240206124132.636342-2-maciej.fijalkowski@intel.com>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20240206124132.636342-2-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 06. 02. 24 13:41, Maciej Fijalkowski wrote:
> Currently, when interface is being brought down and
> i40e_vsi_stop_rings() is called, i40e_pf_rxq_wait() is called two times,
> which is wrong. To showcase this scenario, simplified call stack looks
> as follows:
> 
> i40e_vsi_stop_rings()
> 	i40e_control wait rx_q()
> 		i40e_control_rx_q()
> 		i40e_pf_rxq_wait()
> 	i40e_vsi_wait_queues_disabled()
> 		i40e_pf_rxq_wait()  // redundant call
> 
> To fix this, let us s/i40e_control_wait_rx_q/i40e_control_rx_q within
> i40e_vsi_stop_rings().
> 
> Fixes: 65662a8dcdd0 ("i40e: Fix logic of disabling queues")
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 6e7fd473abfd..2c46a5e7d222 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -4926,7 +4926,7 @@ int i40e_vsi_start_rings(struct i40e_vsi *vsi)
>   void i40e_vsi_stop_rings(struct i40e_vsi *vsi)
>   {
>   	struct i40e_pf *pf = vsi->back;
> -	int pf_q, err, q_end;
> +	int pf_q, q_end;
>   
>   	/* When port TX is suspended, don't wait */
>   	if (test_bit(__I40E_PORT_SUSPENDED, vsi->back->state))
> @@ -4936,16 +4936,10 @@ void i40e_vsi_stop_rings(struct i40e_vsi *vsi)
>   	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
>   		i40e_pre_tx_queue_cfg(&pf->hw, (u32)pf_q, false);
>   
> -	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++) {
> -		err = i40e_control_wait_rx_q(pf, pf_q, false);
> -		if (err)
> -			dev_info(&pf->pdev->dev,
> -				 "VSI seid %d Rx ring %d disable timeout\n",
> -				 vsi->seid, pf_q);
> -	}
> +	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
> +		i40e_control_rx_q(pf, pf_q, false);
>   
>   	msleep(I40E_DISABLE_TX_GAP_MSEC);
> -	pf_q = vsi->base_queue;
>   	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
>   		wr32(&pf->hw, I40E_QTX_ENA(pf_q), 0);
>   
Reviewed-by: Ivan Vecera <ivecera@redhat.com>


