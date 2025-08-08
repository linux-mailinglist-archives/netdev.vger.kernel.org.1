Return-Path: <netdev+bounces-212267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB18B1EE26
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 20:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ACB55A3C75
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 18:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E273A1DE8A4;
	Fri,  8 Aug 2025 18:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NA+6lfXh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2721DA3D;
	Fri,  8 Aug 2025 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754676206; cv=none; b=IGtZx46XZ7MOZPbui4S1RYW8Tn5pNgZba5a79Wrux0uj3HleSF5e8UXPREY6jV0c8tTCWAGSVCx5AO5W+GDwqh95zxaPjFPhz+cPchxF3rCY0mjL6MNEjvGS5CAcPSpOWk1htlQtJqZrSxaOZ9uGT9gLuY/pRTj+XZYL5T26jZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754676206; c=relaxed/simple;
	bh=jquBVnZjCw255TTTcDjpqQS3Zd2zougjDfYAO2Kqa4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyQfR6A38Lrq78K1KyPlDOFqoOq18w1zhky9ppNBH79tFl6sS2zbrYxHbsDSp6j3GKbKJoQkB2FIFybQFEyByqmJm0JgvHFiIxPNs+UoiVbT2x92vZf0jIBQd1O+OXyf2rn5sDbnB4AGd58hpu750EmInL0EyZdLgD9xELML3+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NA+6lfXh; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76bdc73f363so2410528b3a.3;
        Fri, 08 Aug 2025 11:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754676205; x=1755281005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bdpbMeYSMpsMt1914y/TUI6RCSE8LWRE4aRT+cIx/ic=;
        b=NA+6lfXhps6200YcmpgjXqI32+Oace2R2xUnYSkq9q4VhNhTNWb9PEwAKAnwPa+WGS
         rZvt0FsIXnnUDzVf2hqsMzbt60bD11EtACRbGrTBp1PohdHhXtTUbvHPQx2st4PM6kV+
         BKxKXuOuH8YUJuzBVAcxTlo291c34X65r15WBVpnpTJGEfj2fb+mE6ZdRR/ej2XIkbwp
         G1vPW1joqoeZXHt5gasCxvPhvoBs1+gQIiL/Hh+HlAp9I9h4KfDH7fheobKWZz4dc8r+
         7hTndt7GJrIJwBci8wMqNS9014W3ZhwXqO8I2Ew/9t58baUsx4Hi9ddMQ4TAcm2biN/r
         lhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754676205; x=1755281005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdpbMeYSMpsMt1914y/TUI6RCSE8LWRE4aRT+cIx/ic=;
        b=j11tA+pbGC7zmaJ+N/iNbxpf/+u6X9Rr54TDxfsn5vVLLs2l0q2X9anyw6l1pcEemk
         1m7Yf6K+5p37aNqcC8k2WH0S0I5ZgJdy6F8SXJk7pWxNoeCzw88nr+uhXN38h3nl/qHn
         t1yZeCF3+OmDz+JrdYK99Hyj0xBsWuYNzTMCeZYx4DuOfMukdxW+XVE3nzsw4FDis4mb
         nE/Y82V2sglNKM9KpbSLjb8Q9YOwhDF+yZaeltNaOg+lf5G3FJp/UKiw12Hn2h8OkDHp
         8FqaXYoBHjKfMfypJ7CtMFTjQGHLhFQA39FZ9Odog0NV3nXYqtzIXBswYCMWo6mzP/R/
         JDlw==
X-Forwarded-Encrypted: i=1; AJvYcCUVwBYygclPXSejW9MgU9RFnp2f6Yf32mLyHgytqYQYcNI3MYvSW4HbO2bHaHfcuozpr33AAOlmCyx4D2Y=@vger.kernel.org, AJvYcCWbUYHX3vWA0VFO3Hoa1AZWhJn+wHqRA86rcnva/qQvgibG19AzHRCb/oQTQgcPfloBAjsHvKGl@vger.kernel.org
X-Gm-Message-State: AOJu0YyxZrBgZ2/t6mm/qqmD2afRvW3VSfk02l56ijRYMdxIAqXo2+Yp
	WVm9NKwcP7e/7eW6IUvbzjcVvxXdYCMcASIPIrqLJAU9PSGG0h0ykSU=
X-Gm-Gg: ASbGncs8ixvCC2WZRGANjPHKhe4710T8QN05GRzJdgbVPgO20TXNYzALJ+8x3qiH9G1
	Q7S5J8CQViwuPHbZMDlxVti4RqQncRpUdvJtjH3TD1PDx3cFsMc0Gx0+Li7at90Zfd7TDhMlHvk
	tAiEEhHpnuN2OpAq/8NCfK1KARE6KlXgFKfuVBLcrOW/aP1QxsZuHrXiHA4KPC4fevRLpFT9IWE
	EFFNdQkrrPSLdXMVmU0SxbidJPFNx6n9M7Ta3HY15HP/QnpctlZ3PRpd7eSX2qDz5nXo71+mQ3y
	bPYl6NFA9UneBqOD3/jsvWdqm83e/G7zovhCJ/u+ZunQO4n5g21ylK+FlRDCxZJBu/2ho89P/i+
	rDDAlVjPfN16r0sUUWhAgRlzSUPyChbSErAaHJq1EAB7xMUt2MbgUp5omzzU=
X-Google-Smtp-Source: AGHT+IHwRCSZIVwRHSDexCtbMuOZq1L8Uj0GNw8FVAMbiq1XD+XdtS2qexDakcJP0OcpbKwfqsrQ5w==
X-Received: by 2002:a05:6a20:94c7:b0:23d:f987:b033 with SMTP id adf61e73a8af0-24055230871mr6512250637.40.1754676204462;
        Fri, 08 Aug 2025 11:03:24 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76be2f2a4c2sm17968735b3a.110.2025.08.08.11.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 11:03:24 -0700 (PDT)
Date: Fri, 8 Aug 2025 11:03:23 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch,
	horms@kernel.org, davem@davemloft.net, sdf@fomichev.me,
	almasrymina@google.com, dw@davidwei.uk, michael.chan@broadcom.com,
	dtatulea@nvidia.com, ap420073@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 17/24] eth: bnxt: adjust the fill level of agg queues
 with larger buffers
Message-ID: <aJY767C6oiezskdM@mini-arch>
References: <cover.1754657711.git.asml.silence@gmail.com>
 <0a4a4b58fa469dffea76535411c188429138cc81.1754657711.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a4a4b58fa469dffea76535411c188429138cc81.1754657711.git.asml.silence@gmail.com>

On 08/08, Pavel Begunkov wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> The driver tries to provision more agg buffers than header buffers
> since multiple agg segments can reuse the same header. The calculation
> / heuristic tries to provide enough pages for 65k of data for each header
> (or 4 frags per header if the result is too big). This calculation is
> currently global to the adapter. If we increase the buffer sizes 8x
> we don't want 8x the amount of memory sitting on the rings.
> Luckily we don't have to fill the rings completely, adjust
> the fill level dynamically in case particular queue has buffers
> larger than the global size.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [pavel: rebase on top of agg_size_fac, assert agg_size_fac]
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 27 +++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 40cfc48cd439..a00c2a829b6b 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -3805,16 +3805,33 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
>  	}
>  }
>  
> +static int bnxt_rx_agg_ring_fill_level(struct bnxt *bp,
> +				       struct bnxt_rx_ring_info *rxr)
> +{
> +	/* User may have chosen larger than default rx_page_size,
> +	 * we keep the ring sizes uniform and also want uniform amount
> +	 * of bytes consumed per ring, so cap how much of the rings we fill.
> +	 */
> +	int fill_level = bp->rx_agg_ring_size;
> +
> +	if (rxr->rx_page_size > bp->rx_page_size)
> +		fill_level /= rxr->rx_page_size / bp->rx_page_size;
> +
> +	return fill_level;
> +}
> +
>  static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
>  				   struct bnxt_rx_ring_info *rxr,
>  				   int numa_node)
>  {
> -	const unsigned int agg_size_fac = PAGE_SIZE / BNXT_RX_PAGE_SIZE;
> +	const unsigned int agg_size_fac = rxr->rx_page_size / BNXT_RX_PAGE_SIZE;
>  	const unsigned int rx_size_fac = PAGE_SIZE / SZ_4K;
>  	struct page_pool_params pp = { 0 };
>  	struct page_pool *pool;
>  
> -	pp.pool_size = bp->rx_agg_ring_size / agg_size_fac;

[..]

> +	WARN_ON_ONCE(agg_size_fac == 0);

nit: do we need to make this if (WARN_ON_ONCE(...)) agg_size_fac = 1?
Otherwise you're gonna divide by zero on the next line. Or properly
return some EINVAL instead?

> +
> +	pp.pool_size = bnxt_rx_agg_ring_fill_level(bp, rxr) / agg_size_fac;

