Return-Path: <netdev+bounces-178629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA0BA77ECB
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 17:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76680188FE90
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 15:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E6B20AF63;
	Tue,  1 Apr 2025 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="vCnAKf3a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D388920487D
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743520818; cv=none; b=t40cj3JE4alIlogfsRN8NnkgXN9XU4KrdBQY157jnaSu1lb+s0bHiXd/qEWxSWyzU9IFoNstXRxIS74lA+GP1tkDun4047kOrUZ0l4arV+BAGby7v0f0H4VqOz2Tf0qaB+a2acOjMrzk4iy2FCAq4KG8dJccZisoc6RvnDRd750=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743520818; c=relaxed/simple;
	bh=+AZtruNF2slaQ2pW+XbtDx6RQe/JY4tZmaizs714skE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NdZOEdDZhYuVRSA7fQhnFSHmMDB60vRHPKksJd/sbTOkZWv/tbvWpqKvwjB7VUHRNpOflK8CnHKKhDzOpdSqVxc7nZXyexIvQJp9PZkDQOrx5i3yd0uKcT+6x5lqnj6WV58nd94paCSfw6q/Hk0T1T35Wk4TFkLyjuHg+w6eFko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=vCnAKf3a; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-226185948ffso110451825ad.0
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1743520814; x=1744125614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KYEEeuDUK0c4tCya15zU0U36ES4DSsfjDlwanwz0lTg=;
        b=vCnAKf3aSWBSwiSYoBif7AJoUhZNLXu7w6fNck+j+1y6N1gMjZ/zk2cCQ9NptraLi5
         kRoTI3ljV+nfIG9r5CHpQ4E/MwkGK69cSoIpUYOIGwrSWMAgmaRw83vLWPGdYoW72nxU
         lbIlPLta2JRJdT9oBibx06urt+OMESd21rZvekBSD44A06YC4V24KFlt+HgG4luHxriF
         UyNb+VXD44Jvzkn5Ilp8f6V/DBDFm292kI0zd2rNB2EiKDcMdApm4Maj7Zd4znARrzxH
         r3gi4y9zKAVYzKeXhtGAp/KE4vurW/0345fmeNAKX9sOchijrobaT8rokW1MJr40SgM3
         gwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743520814; x=1744125614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYEEeuDUK0c4tCya15zU0U36ES4DSsfjDlwanwz0lTg=;
        b=NnqoUW4ccZq2ulnavXXwp5DghQCdOWxihujgLjXPrU9J4for7V3qRN3FMxUMsYwcoG
         irGbKGnCeN4euytpufVZOIq4pglzgIdcsyvRKGXh5rzF/XgVwPokp7jUZtmxGsFHKKoL
         a/uqKfqBd6b7keglSda6iSbIgjhkd/fnnC9N/O9jRhiEBy1KPmZtGKFjoaAWWwiO+L/u
         UY2mTOmElWyn6gV4FwN3v09IerrvaSeebGIOMo427QbAiFTTywj0TeoD9ZOE+yMDiCuz
         dPf2GCre9oJuf0RlBhDySS3fTPL9pW5OBtugcgiQ+oXW2YA5STxxaa76Rcv9CDJ1CQCa
         pa9g==
X-Forwarded-Encrypted: i=1; AJvYcCVJ5BM0CDes0YP0ZlIS+rX4Vc+wEeLC0ug8yi2fpEjCgeWJ8PBjOZblBvAMBMUiTG9/18qVASM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVi7xsD/q296ouZxGkQ2DZVJPy87FlBpk7CWkb15p1imE4P6Y5
	txCfa2Zz2ETZc1OQWoNtBOsRTPE+z31wHyDw+RJOPCnqwSrerqq3jq6X8iESqDE=
X-Gm-Gg: ASbGncuYZ+pkJCb+W8PtBcSVbLXXI1+VqJS3jR+DlQOStYIIFp9SXzIYX14a+YXbbld
	GuFCHYdOJIlltjo66XQNu/Eg3T5kQxpHbJJEBeiZAxN7ecS1mLLON76Jw+Nrdz3UPLGX5F9LkEv
	3DJdUI7NR/jxxkNZaXL2HvNoDRgo6MNZO8ejwEIHBnygM1s36N47pfoYLs4srcAX6G51U4P2gI6
	fer+Zzf4rFiz97xWAouslgEMNMmnP1vT5S0awRaTpzdS8ZqZcRZg7wqQGsDM3oJsHoUkRdcOw95
	a+jtdKdn6lS1E42KKLXb+baDeIQ4Y6fnGYDgIEO8+DB2MpPJ0F1g4eTsDV54idX5K5rOHyl2jcu
	KWwXiaPM=
X-Google-Smtp-Source: AGHT+IHrXzh7NOJm4rB0nkI45VWc5AFQfzmeAtyz7eSg+CEnlTOfwwlOX4w5rwiBW7EDP/70P/4/wg==
X-Received: by 2002:a17:902:da2d:b0:220:fe50:5b44 with SMTP id d9443c01a7336-2292f98769cmr194525895ad.31.1743520814041;
        Tue, 01 Apr 2025 08:20:14 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1cf1:8569:9916:d71f? ([2620:10d:c090:500::5:4565])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1ce07dsm89376415ad.144.2025.04.01.08.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 08:20:13 -0700 (PDT)
Message-ID: <9eba198d-c209-4057-85b6-05d0444d1d37@davidwei.uk>
Date: Tue, 1 Apr 2025 08:20:11 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 1/2] eth: bnxt: refactor buffer descriptor
Content-Language: en-GB
To: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 ilias.apalodimas@linaro.org, netdev@vger.kernel.org
Cc: kuniyu@amazon.com, sdf@fomichev.me, aleksander.lobakin@intel.com
References: <20250331114729.594603-1-ap420073@gmail.com>
 <20250331114729.594603-2-ap420073@gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250331114729.594603-2-ap420073@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-03-31 04:47, Taehee Yoo wrote:
> There are two kinds of buffer descriptors in bnxt, struct
> bnxt_sw_rx_bd and struct bnxt_sw_rx_agg_bd.(+ struct bnxt_tpa_info).
> The bnxt_sw_rx_bd is the bd for ring buffer, the bnxt_sw_rx_agg_bd is
> the bd for the aggregation ring buffer. The purpose of these bd are the
> same, but the structure is a little bit different.
> 
> struct bnxt_sw_rx_bd {
>         void *data;
>         u8 *data_ptr;
>         dma_addr_t mapping;
> };
> 
> struct bnxt_sw_rx_agg_bd {
>         struct page *page;
>         unsigned int offset;
>         dma_addr_t mapping;
> }
> 
> bnxt_sw_rx_bd->data would be either page pointer or page_address(page) +
> offset. Under page mode(xdp is set), data indicates page pointer,
> if not, it indicates virtual address.
> Before the recent head_pool work from Jakub, bnxt_sw_rx_bd->data was
> allocated by kmalloc().
> But after Jakub's work, bnxt_sw_rx_bd->data is allocated by page_pool.
> So, there is no reason to still keep handling virtual address anymore.
> The goal of this patch is to make bnxt_sw_rx_bd the same as
> the bnxt_sw_rx_agg_bd.
> By this change, we can easily use page_pool API like
> page_pool_dma_sync_for_{cpu | device}()
> Also, we can convert from page to the netmem very smoothly by this change.
> 
> Tested-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 313 +++++++++---------
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  31 +-
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  23 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |   2 +-
>  include/net/page_pool/types.h                 |   4 +-
>  net/core/page_pool.c                          |  23 +-
>  7 files changed, 199 insertions(+), 199 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 934ba9425857..198a42da3015 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
...
> @@ -1111,25 +1103,24 @@ static void bnxt_reuse_rx_agg_bufs(struct bnxt_cp_ring_info *cpr, u16 idx,
>  
>  static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
>  					      struct bnxt_rx_ring_info *rxr,
> -					      u16 cons, void *data, u8 *data_ptr,
> +					      u16 cons, struct page *page,
> +					      unsigned int offset,
>  					      dma_addr_t dma_addr,
>  					      unsigned int offset_and_len)
>  {
>  	unsigned int len = offset_and_len & 0xffff;
> -	struct page *page = data;
>  	u16 prod = rxr->rx_prod;
>  	struct sk_buff *skb;
>  	int err;
>  
>  	err = bnxt_alloc_rx_data(bp, rxr, prod, GFP_ATOMIC);
>  	if (unlikely(err)) {
> -		bnxt_reuse_rx_data(rxr, cons, data);
> +		bnxt_reuse_rx_data(rxr, cons, page);
>  		return NULL;
>  	}
> -	dma_addr -= bp->rx_dma_offset;
> -	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, BNXT_RX_PAGE_SIZE,
> -				bp->rx_dir);
> -	skb = napi_build_skb(data_ptr - bp->rx_offset, BNXT_RX_PAGE_SIZE);
> +	page_pool_dma_sync_for_cpu(rxr->page_pool, page, 0, BNXT_RX_PAGE_SIZE);

bnxt_alloc_rx_data() can allocate out of both head_pool and page_pool,
but page_pool_dma_sync_for_cpu() always takes page_pool. The only
difference is pool->p.offset; can this ever be different between the
two?

