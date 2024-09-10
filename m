Return-Path: <netdev+bounces-126958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3200C97365D
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 13:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32611F24D7C
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 11:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF2D18DF9E;
	Tue, 10 Sep 2024 11:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIT++JcN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C8318C34D
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725968355; cv=none; b=Dx81Hrx6qC1TnZqqQ29oGJAGIxR53zYXJTiYgaqFDbWaA+115Ei9W4hFxITXaqwuGoZn7u50g0ox6xiKUXNCJoSXafQjzRswBPX8vQASMYTHPGlOpL82/N7m1CnNeQtSLjcGu5UbtOzU0zow9+Ftpv2vx2AKuKTvrseUiW4LcLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725968355; c=relaxed/simple;
	bh=0cX3GH0xXBXVOLY6ArGBCddEcj5mgMvVcSHl7vBZh80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCvt3uRiPjE8bnkK/ElJNrmxk4lVu5vL4HaC/AwC+r6Gyx05nkQ/2cXBMe8Lv9GYej5uzFf9z9GMIK0PXRbYWXGiSxtSsTrBBfBwA4B9hbdmRTRm9Apt9RFMe2tztaNTIR6NZUnJq0y+22giSjXKFfiLDcxZelzYXQbfDaay3S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZIT++JcN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725968353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMDE+T5SYbzZ2s2lnJcF8C7qQEF7Xk3SXFs44FfYjgo=;
	b=ZIT++JcNPqJFhaI9AQ3bT403UZVM4zD2KgrdYtlgQ29RrZgkSotUB4Ml1rhNAib6Jh9rlq
	sH1Qc+ir3b0KM/Zo7v8u5L/FN9kfwGbbDyyQ28Uz2INc3lpbO2umGoHEQPYInLUVyVuJNw
	WQGceCauDM4WTj0hGTmpeGHWYQUfV/Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-U7NN9MqNM1GbAhTVSQ0CRg-1; Tue, 10 Sep 2024 07:39:12 -0400
X-MC-Unique: U7NN9MqNM1GbAhTVSQ0CRg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374c3402d93so2973746f8f.0
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 04:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725968351; x=1726573151;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMDE+T5SYbzZ2s2lnJcF8C7qQEF7Xk3SXFs44FfYjgo=;
        b=pgFFskjKfJ1/BcCEHM7ayKkA5hW7UDbVla7zaViAZ6W+jcEwzodBG97//cYbp+Z1wc
         jY8J6HrTCDrho8HQYJScmVP4YFUdAG7kOsIeDCDsPE5fFvZ5o8crM4p5vZoo8OVkjhH9
         GVfbhX2xU3Nszu9s8om5wVibo8I9S9RLQK7UISrc7nxE816n7VCL97HMZs14vHtRRgXG
         /QNIDgbHl5MsZDKoDMiXHYimJWqsSFExn2GUcmbkmUXpDbvavMg41dSGYOo/XPhzQAF5
         aiJ53tnDFyT69bsPfTlfY1VA986jSfPK5tpWTYySsky3kshj9DpP78/Z+AVX7F4pboTG
         jLgg==
X-Forwarded-Encrypted: i=1; AJvYcCWnnEus/9dz1/nZ1wk0JIp8EiqlXgl/iEA8/Tw3nQfWqofvPt9B5rlPNC/7bUrJIgPRR3OxN2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNrL0+G0//28LYrK34UAXSqSCzyLexYeJDtM1FOWPg/oGgRyLc
	BqkdBHEz3qsjbRnzbsaHS9vs5vqS4N428u+kk14KrdpaqXGhx8DOjhIb6KqkW94xkSD4qK/3Kg5
	Jyj//vri7c0Y/SYUJPWryVeQ9o7IiCQbc0XMPThWuB+3BhH/ypt0wxQ==
X-Received: by 2002:adf:f811:0:b0:374:cea0:7d3d with SMTP id ffacd0b85a97d-3788969ff56mr9440994f8f.53.1725968350838;
        Tue, 10 Sep 2024 04:39:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzz09F/XLDtA7rHhTuAJ5rYOp6SV3GI6mvztmhG9ZtOK7EYoZm27iS4MavxjCEt0DhAgB68A==
X-Received: by 2002:adf:f811:0:b0:374:cea0:7d3d with SMTP id ffacd0b85a97d-3788969ff56mr9440968f8f.53.1725968350251;
        Tue, 10 Sep 2024 04:39:10 -0700 (PDT)
Received: from [192.168.88.27] (146-241-69-130.dyn.eolo.it. [146.241.69.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc1375189sm16800825e9.1.2024.09.10.04.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 04:39:09 -0700 (PDT)
Message-ID: <ba514498-3706-413b-a09f-f577861eef28@redhat.com>
Date: Tue, 10 Sep 2024 13:39:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] octeon_ep: Add SKB allocation failures handling in
 __octep_oq_process_rx()
Content-Language: en-US
To: Aleksandr Mishin <amishin@t-argos.ru>,
 Veerasenareddy Burru <vburru@marvell.com>
Cc: Sathesh Edara <sedara@marvell.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Abhijit Ayarekar <aayarekar@marvell.com>,
 Satananda Burla <sburla@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240906063907.9591-1-amishin@t-argos.ru>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240906063907.9591-1-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/6/24 08:39, Aleksandr Mishin wrote:
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> index 4746a6b258f0..e92afd1a372a 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> @@ -394,32 +394,32 @@ static int __octep_oq_process_rx(struct octep_device *oct,
>   			data_offset = OCTEP_OQ_RESP_HW_SIZE;
>   			rx_ol_flags = 0;
>   		}
> +
> +		skb = build_skb((void *)resp_hw, PAGE_SIZE);
> +		if (skb)
> +			skb_reserve(skb, data_offset);
> +		else
> +			oq->stats.alloc_failures++;
>   		rx_bytes += buff_info->len;

The packet is dropped, we should not increase 'rx_bytes'

> +		read_idx++;
> +		desc_used++;
> +		if (read_idx == oq->max_count)
> +			read_idx = 0;
>   
>   		if (buff_info->len <= oq->max_single_buffer_size) {
> -			skb = build_skb((void *)resp_hw, PAGE_SIZE);
> -			skb_reserve(skb, data_offset);
> -			skb_put(skb, buff_info->len);
> -			read_idx++;
> -			desc_used++;
> -			if (read_idx == oq->max_count)
> -				read_idx = 0;
> +			if (skb)
> +				skb_put(skb, buff_info->len);
>   		} else {
>   			struct skb_shared_info *shinfo;
>   			u16 data_len;
>   
> -			skb = build_skb((void *)resp_hw, PAGE_SIZE);
> -			skb_reserve(skb, data_offset);
>   			/* Head fragment includes response header(s);
>   			 * subsequent fragments contains only data.
>   			 */
> -			skb_put(skb, oq->max_single_buffer_size);
> -			read_idx++;
> -			desc_used++;
> -			if (read_idx == oq->max_count)
> -				read_idx = 0;
> -
> -			shinfo = skb_shinfo(skb);
> +			if (skb) {
> +				skb_put(skb, oq->max_single_buffer_size);
> +				shinfo = skb_shinfo(skb);
> +			}
>   			data_len = buff_info->len - oq->max_single_buffer_size;
>   			while (data_len) {
>   				dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
> @@ -434,10 +434,11 @@ static int __octep_oq_process_rx(struct octep_device *oct,
>   					data_len -= oq->buffer_size;
>   				}
>   
> -				skb_add_rx_frag(skb, shinfo->nr_frags,
> -						buff_info->page, 0,
> -						buff_info->len,
> -						buff_info->len);
> +				if (skb)
> +					skb_add_rx_frag(skb, shinfo->nr_frags,
> +							buff_info->page, 0,
> +							buff_info->len,
> +							buff_info->len);
>   				buff_info->page = NULL;
>   				read_idx++;
>   				desc_used++;
> @@ -446,6 +447,9 @@ static int __octep_oq_process_rx(struct octep_device *oct,
>   			}
>   		}
>   
> +		if (!skb)
> +			continue;

Instead of adding multiple checks for !skb, I think it would be better 
to implement an helper to unmmap/flush all the fragment buffers used by 
the dropped packet, call such helper at skb allocation failure and 
continue looping earlier/at that point.

Thanks,

Paolo


