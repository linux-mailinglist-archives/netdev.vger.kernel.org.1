Return-Path: <netdev+bounces-250211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 89516D250C4
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E5563026D92
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 14:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F8A3A783F;
	Thu, 15 Jan 2026 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jAcOIXjO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpdnQP5G"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C8E3A63F9
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768488409; cv=none; b=L46dq5PupKEFrhcA52NrXkeF194N7KxZssRfVMJcHWKTD+yJlU4JzdtC5Np0jiNnnwu9eYHp4ldW/crvg3LkYkFSi20FpUILSsXiTUe7xfcHNhdCLmzmkt9CAVDB1AHqyprPIJQalwF+ZXMa2LJEauDs+nzzLMNLQQxD4huP6+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768488409; c=relaxed/simple;
	bh=WEHN4IWd1y6e8dsdWX3hME+/Bk24ObPC5PdrGZM1HZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HeMBN5zmNq5QiXL3c5Baui4NEwCb0kVQ4Wfi4I9h69vPK5k+1KPxdGZdWIIVZwR1IlYJa9NOnCDNm9Ukh0D5ja1VCmUY9AqOs+Vwg7uJLO8Moj2wL7+c4i4KfFLbcApmxgPjMiFcVkcTpUtG7EejZ5xO8fxAlHSfDvl/FPmn/iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jAcOIXjO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NpdnQP5G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768488402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+tIoFq2Ynomn0h/2+d0fn3D3qKOWhPMVpU8ZpiU8r08=;
	b=jAcOIXjOEYfOUKHmZuiQQOz27SQ9dxQhGtCAJmWLBNJt0X86/jcVPYtvMF4exqDZZ8+K9w
	jWodD2k9Cwa3ZTACSPSi8qXDI3Cpw/ZJ/wQNquzx3jW4Ti5h7ZiNsk891SmZmTRI+DZJnP
	d0iCckwe+XE1xaOQEtpACYsMklpOPdA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82--ImcWwyEMaqge5DJWaODWw-1; Thu, 15 Jan 2026 09:46:40 -0500
X-MC-Unique: -ImcWwyEMaqge5DJWaODWw-1
X-Mimecast-MFC-AGG-ID: -ImcWwyEMaqge5DJWaODWw_1768488399
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477964c22e0so7741065e9.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 06:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768488399; x=1769093199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+tIoFq2Ynomn0h/2+d0fn3D3qKOWhPMVpU8ZpiU8r08=;
        b=NpdnQP5GKkIKNAtAI8eMoai8Aj2dxGtuN0kiTf2aqAvX7BwQ41/5uLu7WsIOpHEh80
         Mo49TCF2gAKp+5D2ZfKFz00Ebdjk1r6pwjcI5GNXOH2Gagq3mXqJh/4uQAovpxEw3pP9
         7jf9xPxV9oG9zdhG/O2Om4g6kPh2SjwlcU2zIneRoJGGvl+GjKDxmPIe/t0/84hKrorq
         TZJB1LKzvO2ynSFUDTpmXIbfZ+2x8YzA74XfuBXtDTNpBfmGzekVRwaNUMwu/j0Xe7YK
         4sFQjT+0sYtNaxjck8x+MZ2RgNTK6TUoQYP4sx+l967BpaW5H+tFBl+eH6gqDjRY/yq/
         c5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768488399; x=1769093199;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tIoFq2Ynomn0h/2+d0fn3D3qKOWhPMVpU8ZpiU8r08=;
        b=j+cTnzsO6czP+x16USlFUnaM9wYyW8HC2EGRkGeOT58HdopdNzQOhQfv5CEvIIuD/9
         TKzKAfvmPJNf2x0zttta7t8csr3rUkQCPXdwEc/iFmSsvI+VtaKXcbG8nhdpTFJAaQUF
         jQKcAvma6qfAS67R2A1rPO/sEVuBaAQ2KfC9ZWAw3YLDf+EN6IyI7ZtRAfZ9cBixj6Vp
         nNagIhMFzpxl9aQqQWj6gUWQty3jvaC52ACI8tTpAYLSI5JAxMkgiltDMGjQEcXL+DOF
         nGyt2Aq/uHQot4Z6ff6AxBgO53/w12uTntM+TUAJ4cTYX5gjpx2D7eVRjkW3qu9J+xUU
         0lLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaYtmQxaNdr9dXVe4YYD5r75twGFYqPa2EBXgHs/LmaMMJmlT8I7xU/Q6gsGNT4wePa5Jzpsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS4+szl0fnFJiZ8dxo0yZZC52QmuECs5RXkgx2tufrs0HSPa8+
	pgnXf9YxtJeldLMvujJJ3tuMDNWaDIfyutRntaNqG+1aZRN6FoP73iAZmA1f7SpEhXU2CEX8ELm
	W4pQS3vf5L4M0SoNUnstfevy44BeGnjZAblR9deLyfNXMXJURDG+PYqgMhA==
X-Gm-Gg: AY/fxX6gGQ8Dh8beCVhKQaXqk2ShoXHtMwflOh3kG3WdB4KUvyvDhU+aOHw8L86qtr9
	cKZs5ONPs2z2iFuT6dKiQU2Zd54aDZVx2lDS77gloOpLsHhP0yHJa9x3c9UoF+XON5SmFI2xjLT
	9zv5gBFZdOrt0UcN2s2arKAD05HLp9vDxEK/YYx5VwnYcKCLQMhmsXVWm6TnOJmxgT1XOkoHc+7
	z5BXAnJM3L17FjBYd6SVZu679+yWHFETOkZUxlWua6VOngm/a1beZGnS00XA75GUpDADz0K2fiL
	3EF9sYJRaAoq3xrhKfyyzz4pgR9HIlQE9y4jHH42CIRSfG1Carq0qi/YnufDH4+7RmVo/pKhQ3l
	UU8jKTjHBr/D5MA==
X-Received: by 2002:a05:600c:8b16:b0:47e:e981:78b4 with SMTP id 5b1f17b1804b1-47f428ecd7cmr34301825e9.12.1768488398641;
        Thu, 15 Jan 2026 06:46:38 -0800 (PST)
X-Received: by 2002:a05:600c:8b16:b0:47e:e981:78b4 with SMTP id 5b1f17b1804b1-47f428ecd7cmr34301445e9.12.1768488398197;
        Thu, 15 Jan 2026 06:46:38 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af64a671sm6373242f8f.9.2026.01.15.06.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 06:46:37 -0800 (PST)
Message-ID: <f6e226ff-8b6c-486e-96f2-024c420751ab@redhat.com>
Date: Thu, 15 Jan 2026 15:46:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net/mlx5e: SHAMPO, Switch to header memcpy
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <1768224129-1600265-1-git-send-email-tariqt@nvidia.com>
 <1768224129-1600265-4-git-send-email-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1768224129-1600265-4-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/26 2:22 PM, Tariq Toukan wrote:
> @@ -1292,15 +1065,41 @@ static void mlx5e_shampo_update_ipv6_udp_hdr(struct mlx5e_rq *rq, struct ipv6hdr
>  	skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_L4;
>  }
>  
> +static inline u32 mlx5e_shampo_get_header_offset(int header_index)

Is the above really needed to get this function inlined? Perhaps you
could use a macro insted of a function? 'static inline' in c files
should be avoided.

> +{
> +	return (header_index & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1)) *
> +	       BIT(MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE);
> +}
> +
> +static void *mlx5e_shampo_get_hdr(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe,
> +				  int len)
> +{
> +	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
> +	u32 head_offset, header_index, di_index;
> +	struct mlx5e_dma_info *di;
> +
> +	header_index = mlx5e_shampo_get_cqe_header_index(rq, cqe);
> +	head_offset = mlx5e_shampo_get_header_offset(header_index);
> +	di_index = header_index >> MLX5E_SHAMPO_LOG_WQ_HEADER_PER_PAGE;
> +	di = &shampo->hd_buf_pages[di_index];
> +
> +	dma_sync_single_range_for_cpu(rq->pdev, di->addr, head_offset,
> +				      len, rq->buff.map_dir);
> +
> +	return page_address(di->page) + head_offset;
> +}
> +
>  static void mlx5e_shampo_update_fin_psh_flags(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe,
>  					      struct tcphdr *skb_tcp_hd)
>  {
> -	u16 header_index = mlx5e_shampo_get_cqe_header_index(rq, cqe);
> +	int nhoff = ETH_HLEN + rq->hw_gro_data->fk.control.thoff;
> +	int len = nhoff + sizeof(struct tcphdr);
>  	struct tcphdr *last_tcp_hd;
>  	void *last_hd_addr;
>  
> -	last_hd_addr = mlx5e_shampo_get_packet_hd(rq, header_index);
> -	last_tcp_hd =  last_hd_addr + ETH_HLEN + rq->hw_gro_data->fk.control.thoff;
> +	last_hd_addr = mlx5e_shampo_get_hdr(rq, cqe, len);
> +	last_tcp_hd = (struct tcphdr *)(last_hd_addr + nhoff);
> +
>  	tcp_flag_word(skb_tcp_hd) |= tcp_flag_word(last_tcp_hd) & (TCP_FLAG_FIN | TCP_FLAG_PSH);
>  }
>  
> @@ -2299,52 +2098,29 @@ static struct sk_buff *
>  mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
>  			  struct mlx5_cqe64 *cqe, u16 header_index)
>  {
> -	struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
> -	u16 head_offset = mlx5e_shampo_hd_offset(rq, header_index);
>  	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
>  	u16 head_size = cqe->shampo.header_size;
> -	u16 rx_headroom = rq->buff.headroom;
> -	struct sk_buff *skb = NULL;
> -	dma_addr_t page_dma_addr;
> -	dma_addr_t dma_addr;
> -	void *hdr, *data;
> -	u32 frag_size;
> -
> -	page_dma_addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
> -	dma_addr = page_dma_addr + head_offset;
> +	struct mlx5e_dma_info *di;
> +	u32 head_offset, di_index;
> +	struct sk_buff *skb;
> +	int len;
>  
> -	hdr		= netmem_address(frag_page->netmem) + head_offset;
> -	data		= hdr + rx_headroom;
> -	frag_size	= MLX5_SKB_FRAG_SZ(rx_headroom + head_size);
> +	len = ALIGN(head_size, sizeof(long));
> +	skb = napi_alloc_skb(rq->cq.napi, len);
> +	if (unlikely(!skb)) {
> +		rq->stats->buff_alloc_err++;
> +		return NULL;
> +	}
>  
> -	if (likely(frag_size <= BIT(shampo->log_hd_entry_size))) {
> -		/* build SKB around header */
> -		dma_sync_single_range_for_cpu(rq->pdev, dma_addr, 0, frag_size, rq->buff.map_dir);
> -		net_prefetchw(hdr);
> -		net_prefetch(data);
> -		skb = mlx5e_build_linear_skb(rq, hdr, frag_size, rx_headroom, head_size, 0);
> -		if (unlikely(!skb))
> -			return NULL;
> +	net_prefetchw(skb->data);
>  
> -		frag_page->frags++;
> -	} else {
> -		/* allocate SKB and copy header for large header */
> -		rq->stats->gro_large_hds++;
> -		skb = napi_alloc_skb(rq->cq.napi,
> -				     ALIGN(head_size, sizeof(long)));
> -		if (unlikely(!skb)) {
> -			rq->stats->buff_alloc_err++;
> -			return NULL;
> -		}
> +	head_offset = mlx5e_shampo_get_header_offset(header_index);
> +	di_index = header_index >> MLX5E_SHAMPO_LOG_WQ_HEADER_PER_PAGE;
> +	di = &shampo->hd_buf_pages[di_index];

The above 3 statement are repeated verbatim in mlx5e_shampo_get_hdr();
perhaps you could factor out a common helper.

/P


