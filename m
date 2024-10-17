Return-Path: <netdev+bounces-136464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB7F9A1DA5
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 10:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DF5284022
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 08:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5801D6DA8;
	Thu, 17 Oct 2024 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPyePzkk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3B61D61B7
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729155407; cv=none; b=CH4hTf/rsSdpyGRG/v/yqON00xf4uzKNuEhizP8zZmOv20Rb1YzLYg6eYapzQUk2dOQjr8kpLVzNiaBI4J1ldp5ts7Aj+Re2ZzCxRHDOvVt/j/K8Zi2E/fZifLH+Xn18+OMCYwWpWLe6qeXpJzC0Wy7wvhXzqOAX9TaXQia86yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729155407; c=relaxed/simple;
	bh=0QWOubG/WuA61pVYtbUtwR5Fnidt8JdTr4ouJ136/xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQJugKENVk7D73bFSQslGUkyFcZy7MDdJJvF95v5by/bTqGkRu2ipKZKqj2Ksn1ZCvMs18eyDfpJ04efPKHOboTGPSgZ3Mh0mqmLUR6xOqcg9dk96BJtgsxBPkWRl3670YAR7MbEXRur5BV1NIBiPxTtOXH9mmFj5SYsv2TEdqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QPyePzkk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729155403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UrxwD9IPoa0hW3esM+SzEvUX3D4adUtDilN4qp1rChA=;
	b=QPyePzkkGxkjQ+Md6njQHxltSFYAmJ3wHFeyiJich88Tgkv0x+wZ8sFV7THFhxRRhPumL6
	uGawUoqudnyG/11cAufP53uT9uqIAGQo9JuPPV65PO06BQ4ffmE9dshZBEXfjwQQZBYWDe
	zg5FckfTX3N3Ax7kXTtqGHUIBjOTbDQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-ookaej2hOtaKoY9ihBtQsw-1; Thu, 17 Oct 2024 04:56:40 -0400
X-MC-Unique: ookaej2hOtaKoY9ihBtQsw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d5116f0a6so277007f8f.0
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 01:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729155399; x=1729760199;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UrxwD9IPoa0hW3esM+SzEvUX3D4adUtDilN4qp1rChA=;
        b=rEM5ZoHtQnr5ANDSK/hTIsM4UnSE9C48bHbMKrKMaUi/7GqGRrf2tMXKJsi0DCDM9Z
         0ePuqeEOT+XYxBEbRAoeCz32Qcuzf1N1SW9Z2QNx239s8iYPMKITzgKno2y14ebKe+tc
         q3P92z/v14gStOTny8zwCEEReOF+pxJh2ONDH6QcLP3e1VM+Jj6q+UxYbK1xDtBxI2LS
         PA7ug0kpzoKQM7snG/bM/RsFtCxC0Q+//xwb0FZx+tu86CJwxfozYfbJFX+q5lVL5iIZ
         qMJKSthA2uAxt59ptOeAYbfEZY84zuT/14XfvZIzYpGOc8wFAteToOaoJgsAcRtESHXa
         XCKw==
X-Forwarded-Encrypted: i=1; AJvYcCXnVLUumx+dNZiDRlpMpdta2pmEQxREPibibIyi02jjcxaE0Lfbbe+3vp9viXD7rqZdRFxyqzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9/ePKZFznPXreBiHOBtnI3HFK+q8zP9JlyJEIQz/fnqVw7cmS
	+OFL+hDjFBnegRPvunl+R6DczBETrRj1Ejz38A2kkuwh6t645aXPrej0GQ9dqmxq0rNjfZ/ZJQX
	Q9CTvdxTF7VbQ02rtBjfJyuBLEUnD8pdkWTCPYjghoAm2heL/X81Qyw==
X-Received: by 2002:a5d:5234:0:b0:37d:4ebe:164a with SMTP id ffacd0b85a97d-37d5ff9d34fmr11719242f8f.50.1729155398966;
        Thu, 17 Oct 2024 01:56:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhrSlHYpBwf2V7vPOdSMSWDh7j+UkXMjx0aSd2wqLti5QLAw6usc5GisM3cNHvTruB/I0Nqw==
X-Received: by 2002:a5d:5234:0:b0:37d:4ebe:164a with SMTP id ffacd0b85a97d-37d5ff9d34fmr11719227f8f.50.1729155398510;
        Thu, 17 Oct 2024 01:56:38 -0700 (PDT)
Received: from [192.168.88.248] (146-241-63-201.dyn.eolo.it. [146.241.63.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c4071esm19199775e9.27.2024.10.17.01.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 01:56:37 -0700 (PDT)
Message-ID: <cf656975-69b4-427e-8769-d16575774bba@redhat.com>
Date: Thu, 17 Oct 2024 10:56:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/2] octeon_ep: Implement helper for iterating
 packets in Rx queue
To: Aleksandr Mishin <amishin@t-argos.ru>,
 Veerasenareddy Burru <vburru@marvell.com>,
 Abhijit Ayarekar <aayarekar@marvell.com>,
 Satananda Burla <sburla@marvell.com>, Sathesh Edara <sedara@marvell.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, Simon Horman <horms@kernel.org>
References: <20241012094950.9438-1-amishin@t-argos.ru>
 <20241012094950.9438-2-amishin@t-argos.ru>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241012094950.9438-2-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/24 11:49, Aleksandr Mishin wrote:
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> index 4746a6b258f0..62db101b2147 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> @@ -336,6 +336,30 @@ static int octep_oq_check_hw_for_pkts(struct octep_device *oct,
>   	return new_pkts;
>   }
>   
> +/**
> + * octep_oq_next_pkt() - Move to the next packet in Rx queue.
> + *
> + * @oq: Octeon Rx queue data structure.
> + * @buff_info: Current packet buffer info.
> + * @read_idx: Current packet index in the ring.
> + * @desc_used: Current packet descriptor number.
> + *
> + * Free the resources associated with a packet.
> + * Increment packet index in the ring and packet descriptor number.
> + */
> +static void octep_oq_next_pkt(struct octep_oq *oq,
> +			      struct octep_rx_buffer *buff_info,
> +			      u32 *read_idx, u32 *desc_used)
> +{
> +	dma_unmap_page(oq->dev, oq->desc_ring[*read_idx].buffer_ptr,
> +		       PAGE_SIZE, DMA_FROM_DEVICE);
> +	buff_info->page = NULL;
> +	(*read_idx)++;
> +	(*desc_used)++;
> +	if (*read_idx == oq->max_count)
> +		*read_idx = 0;
> +}
> +
>   /**
>    * __octep_oq_process_rx() - Process hardware Rx queue and push to stack.
>    *
> @@ -367,10 +391,7 @@ static int __octep_oq_process_rx(struct octep_device *oct,
>   	desc_used = 0;
>   	for (pkt = 0; pkt < pkts_to_process; pkt++) {
>   		buff_info = (struct octep_rx_buffer *)&oq->buff_info[read_idx];
> -		dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
> -			       PAGE_SIZE, DMA_FROM_DEVICE);
>   		resp_hw = page_address(buff_info->page);
> -		buff_info->page = NULL;
>   
>   		/* Swap the length field that is in Big-Endian to CPU */
>   		buff_info->len = be64_to_cpu(resp_hw->length);
> @@ -394,36 +415,27 @@ static int __octep_oq_process_rx(struct octep_device *oct,
>   			data_offset = OCTEP_OQ_RESP_HW_SIZE;
>   			rx_ol_flags = 0;
>   		}
> +
> +		skb = build_skb((void *)resp_hw, PAGE_SIZE);
> +		skb_reserve(skb, data_offset);
> +
> +		octep_oq_next_pkt(oq, buff_info, &read_idx, &desc_used);

I'm sorry for not catching the following in the previous iteration (the 
split indeed helped with the review):

build_skb() will write into the paged buffer, I think you should unmap 
it with octep_oq_next_pkt() before the skb creation.

That in turn will have side effect on the following patch (the 'do {} 
while' loop should become a plain 'while' one).

Thanks,

Paolo


