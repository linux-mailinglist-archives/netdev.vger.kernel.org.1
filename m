Return-Path: <netdev+bounces-69831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2685184CC29
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEFCE1F23CBC
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 13:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1EC77F0E;
	Wed,  7 Feb 2024 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQNT7IFU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A377F15
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707314242; cv=none; b=QAblqm761hsWSeL5rRgGYjOKdyghgd4QaGMM/D8L1l3NwcKWet4ohX0GWdis3l6s6hgMoZcsad5aqDS2Z70zj75mWqhGK0Ql5WTODRiZagozT0jGUyWgCXxhk7ZcUQcTzrovsNuRNDn/pj4L7lHsy3oBh5sVFiDCx9OYZwWwbdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707314242; c=relaxed/simple;
	bh=b9nGuLqZCjuj/fpSUmuM2+XviWPOJHk0Qf7EvJ03S1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccEaCRrpeQgw8r7P67na2il/QpqH6MPT23VKH9R+ooeEoYfJbfVfa4M6k6T644PkM6kMbE7IeZfilI/k5C3m0Ac2ItcVhLZpMPaFyUR5Ixe9I79D77QP6d4THwc3HwUqBpoiPw7bXVBVPJCoWUHvKmbbhRTH9BMqxER4gC3UkGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OQNT7IFU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707314238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOYK+82yGzIKU8yYT0XwUz/WbF1TF9+/dmqGrNc2hhE=;
	b=OQNT7IFUfTOhIi0IeafLRXUCq3U/krHmW0PPlGRHvnZfSAeK1GXv+TJaJEvy5LxYiAjVif
	ygGHO91Y/JkBWEdXg+F/8JMj/SJd2jZUM1idMCQjJf8DSCj6/fGT7YX984Dss3kEwT4c90
	Qg5fhbQlEzKwQ1baClMTd7UU7pfnOIc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-SxQE5mJGP3aGiHdmtW_77A-1; Wed, 07 Feb 2024 08:57:16 -0500
X-MC-Unique: SxQE5mJGP3aGiHdmtW_77A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57DCB84ACA0;
	Wed,  7 Feb 2024 13:57:16 +0000 (UTC)
Received: from [10.45.225.55] (unknown [10.45.225.55])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 191332026D06;
	Wed,  7 Feb 2024 13:57:14 +0000 (UTC)
Message-ID: <63233433-0608-47df-93fc-36487a91148a@redhat.com>
Date: Wed, 7 Feb 2024 14:57:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-net 2/2] i40e: take into account
 XDP Tx queues when stopping rings
Content-Language: en-US
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 Seth Forshee <sforshee@kernel.org>, Simon Horman <horms@kernel.org>,
 magnus.karlsson@intel.com
References: <20240206124132.636342-1-maciej.fijalkowski@intel.com>
 <20240206124132.636342-3-maciej.fijalkowski@intel.com>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20240206124132.636342-3-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 06. 02. 24 13:41, Maciej Fijalkowski wrote:
> Seth reported that on his side XDP traffic can not survive a round of
> down/up against i40e interface. Dmesg output was telling us that we were
> not able to disable the very first XDP ring. That was due to the fact
> that in i40e_vsi_stop_rings() in a pre-work that is done before calling
> i40e_vsi_wait_queues_disabled(), XDP Tx queues were not taken into the
> account.
> 
> To fix this, let us distinguish between Rx and Tx queue boundaries and
> take into the account XDP queues for Tx side.
> 
> Reported-by: Seth Forshee <sforshee@kernel.org>
> Closes: https://lore.kernel.org/netdev/ZbkE7Ep1N1Ou17sA@do-x1extreme/
> Fixes: 65662a8dcdd0 ("i40e: Fix logic of disabling queues")
> Tested-by: Seth Forshee <sforshee@kernel.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 2c46a5e7d222..bf1b32a15b5e 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -4926,21 +4926,23 @@ int i40e_vsi_start_rings(struct i40e_vsi *vsi)
>   void i40e_vsi_stop_rings(struct i40e_vsi *vsi)
>   {
>   	struct i40e_pf *pf = vsi->back;
> -	int pf_q, q_end;
> +	u32 pf_q, tx_q_end, rx_q_end;
>   
>   	/* When port TX is suspended, don't wait */
>   	if (test_bit(__I40E_PORT_SUSPENDED, vsi->back->state))
>   		return i40e_vsi_stop_rings_no_wait(vsi);
>   
> -	q_end = vsi->base_queue + vsi->num_queue_pairs;
> -	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
> -		i40e_pre_tx_queue_cfg(&pf->hw, (u32)pf_q, false);
> +	tx_q_end = vsi->base_queue +
> +		vsi->alloc_queue_pairs * (i40e_enabled_xdp_vsi(vsi) ? 2 : 1);
> +	for (pf_q = vsi->base_queue; pf_q < tx_q_end; pf_q++)
> +		i40e_pre_tx_queue_cfg(&pf->hw, pf_q, false);
>   
> -	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
> +	rx_q_end = vsi->base_queue + vsi->num_queue_pairs;
> +	for (pf_q = vsi->base_queue; pf_q < rx_q_end; pf_q++)
>   		i40e_control_rx_q(pf, pf_q, false);
>   
>   	msleep(I40E_DISABLE_TX_GAP_MSEC);
> -	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
> +	for (pf_q = vsi->base_queue; pf_q < tx_q_end; pf_q++)
>   		wr32(&pf->hw, I40E_QTX_ENA(pf_q), 0);
>   
>   	i40e_vsi_wait_queues_disabled(vsi);

Reviewed-by: Ivan Vecera <ivecera@redhat.com>


