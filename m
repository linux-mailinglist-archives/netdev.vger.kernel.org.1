Return-Path: <netdev+bounces-211394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E1EB18864
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 22:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAD624E01CB
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 20:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ED32139CE;
	Fri,  1 Aug 2025 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCsGMyJo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FA61DE4DC
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 20:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754081713; cv=none; b=eu4Otdw4jlGWc5WocnCc8B3VrIHl/MdkFtbzBzqE9DK4R04qEebWN1a7oOVZiTX2xxM5bdxGC+Kx2a/VvGJnQLHKj5kCi98J/ryWDcChfIcIR7sRP3H9Vm6kMFZSfZ+PoM+RIn5xj2K3FAhOFGJMnpoPImH6TloIHVUgE9I7TjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754081713; c=relaxed/simple;
	bh=RphfbN1K9QjlSYHxXSO6JCle9kcD12wT3PFCsmokbIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5wqkhtgOgKGVwGtDjQynxnjDPvDzLZLLn8ao8HG4HqgX54S12wNGGt9ov8nX7Qs7e1I5dFEnYnc3Gfz/FmaNzjeF25iGOkbJ/DJZpIvB2UtFUl4Yt6yMZpzQH8+9SpLg8bnwRWrzT92GlS4EQtzvM9XEwEekURAHQT7uuiGY60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCsGMyJo; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76bc55f6612so2407776b3a.0
        for <netdev@vger.kernel.org>; Fri, 01 Aug 2025 13:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754081711; x=1754686511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uOCcOrxk362DuZGsDQKcARe5nE3FJWpKVGHVBSHCxd0=;
        b=KCsGMyJo8U/r/Uw4xcWPdtw2i6FLY4BzPZmbV5RUAj0YKH/UeXwkdFAxRH21sOMUUS
         RwPtnZdGuf8DkesjirJBmNQgMSWART04WxlNHE1nDdrvp67zevtW9l2ZC4sMroTXnULZ
         YbLnblKfFTg4N5ebhrzfTFKI9S1Nywsnoo/ZJ9pkpzmKH3CPN1AXGBpfm2/u559HpEcr
         E9i/x2SFT3GRk3kzspcyeJ3uLiHaso+KGaMKTJxJHT/Jxbu/hvylTueJ1WBdMUf/4B6n
         tJyC+T3px9NG+sPWd7MHDdLewHsimhUjjiMJ5lIbakh/pZx7Of6nEQ4ghx8kpKb2+Ku1
         /xAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754081711; x=1754686511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOCcOrxk362DuZGsDQKcARe5nE3FJWpKVGHVBSHCxd0=;
        b=MQm7icHwfDBAgs4blXcVn71YoDoJO10HDoiB5RF+XrTl/Xy82zicYwlt4iYY2Bn1j2
         ccoKIg71scA5VIgrF4QcwUIX4OnKXc8TCY0PgkWBukA00zlyKpk18pbRMcbdf8qSbQ5p
         l4pF/4Axbn0ZltWStunPSEY54Y1M1V4n9AsYRAoQGONLKJ07gVKOHKI9ini7wTX3sFPK
         3LUN0xBq4nl7zLXICuLwavgNh/qNA1iCWMFtftgOjitlLhytDjXtg6XGG9Q1nj0HAuZ8
         0NMRweCUNr9Zun5j5wNBlUQJ0hKX0jmN70ZD091GOAPtSwYJWqWDKWjEm/Kf3CR1Dz3v
         dxSg==
X-Forwarded-Encrypted: i=1; AJvYcCX92pW0NJOL9ZKyJRikg7HP6Sg3QspIhHUvOdY+RKwiDlvQph0dJFb9Kem9s2h6auEQwFMy2aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0bAYNJmo/c5NazIG38N+O7qoQy4aQDC9OXZZYnr5YQVlHlVUD
	tXYGufV/n9aoSPyxK9VMYvGC21FphM8Oe9kaybzeoRd4Xiqc3w8LFsI=
X-Gm-Gg: ASbGncs1iCqCi7WJNJcRDJeIyjFiAX7hAOTcab6124XCl9h7ObURW01W8BR0nOmD1D8
	uZmaAFIsMT9ktOt+Y0hH8LVQIjtk+5FyViA1UYc8ePbCADn1dkqE1rd2xaO87rniz7R7++B7c8D
	+uETrn24gVIPf6z6ubeQwMIHVRY0xbTAMwNi/GHszYRYg4fxRt5SO8RAGOWFxrFBuFFnCuBOZrg
	rq1tDhAp/K8vjxWd6nNkOiL9qwsJuQrlFjR0N7+49c0fVrs17bFekoEE8IMAYVtYsCkvzXNZxOX
	5WQyd3cMLlouD+3NsIiWb8GF5b7hNNDn+DMuEBjocOc5zQmlejprMitOeYFqgtF8ObIBFHkQQ+T
	Z6I2C8dcCiyK9Fo9A5wINru38vSAk+Oz847vj3pPTpa7W1IwAGP/uBmrMC0riJju04n31CQ==
X-Google-Smtp-Source: AGHT+IHd+i/mV7It3aA5vVTmAvkXJXow2G3eWKfQZDwfR06bBqnldAUvxi4+zWoPWQC5eNqy6fkQmA==
X-Received: by 2002:a05:6a21:99a5:b0:232:9530:22fe with SMTP id adf61e73a8af0-23dd7af2be1mr12920877637.6.1754081710864;
        Fri, 01 Aug 2025 13:55:10 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b422bae94d6sm4374243a12.49.2025.08.01.13.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 13:55:10 -0700 (PDT)
Date: Fri, 1 Aug 2025 13:55:09 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	David Wei <dw@davidwei.uk>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, hawk@kernel.org,
	ilias.apalodimas@linaro.org, almasrymina@google.com,
	sdf@fomichev.me
Subject: Re: [PATCH net] net: page_pool: allow enabling recycling late, fix
 false positive warning
Message-ID: <aI0prRzAJkEXdkEa@mini-arch>
References: <20250801173011.2454447-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250801173011.2454447-1-kuba@kernel.org>

On 08/01, Jakub Kicinski wrote:
> Page pool can have pages "directly" (locklessly) recycled to it,
> if the NAPI that owns the page pool is scheduled to run on the same CPU.
> To make this safe we check that the NAPI is disabled while we destroy
> the page pool. In most cases NAPI and page pool lifetimes are tied
> together so this happens naturally.
> 
> The queue API expects the following order of calls:
>  -> mem_alloc
>     alloc new pp
>  -> stop
>     napi_disable
>  -> start
>     napi_enable
>  -> mem_free
>     free old pp
> 
> Here we allocate the page pool in ->mem_alloc and free in ->mem_free.
> But the NAPIs are only stopped between ->stop and ->start. We created
> page_pool_disable_direct_recycling() to safely shut down the recycling
> in ->stop. This way the page_pool_destroy() call in ->mem_free doesn't
> have to worry about recycling any more.
> 
> Unfortunately, the page_pool_disable_direct_recycling() is not enough
> to deal with failures which necessitate freeing the _new_ page pool.
> If we hit a failure in ->mem_alloc or ->stop the new page pool has
> to be freed while the NAPI is active (assuming driver attaches the
> page pool to an existing NAPI instance and doesn't reallocate NAPIs).
> 
> Freeing the new page pool is technically safe because it hasn't been
> used for any packets, yet, so there can be no recycling. But the check
> in napi_assert_will_not_race() has no way of knowing that. We could
> check if page pool is empty but that'd make the check much less likely
> to trigger during development.
> 
> Add page_pool_enable_direct_recycling(), pairing with
> page_pool_disable_direct_recycling(). It will allow us to create the new
> page pools in "disabled" state and only enable recycling when we know
> the reconfig operation will not fail.
> 
> Coincidentally it will also let us re-enable the recycling for the old
> pool, if the reconfig failed:
> 
>  -> mem_alloc (new)
>  -> stop (old)
>     # disables direct recycling for old
>  -> start (new)
>     # fail!!
>  -> start (old)
>     # go back to old pp but direct recycling is lost :(
>  -> mem_free (new)
> 
> Fixes: 40eca00ae605 ("bnxt_en: unlink page pool when stopping Rx queue")
> Tested-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Thanks to David Wei for confirming the problem on bnxt and testing
> the fix. I hit this writing the fbnic support for ZC, TBH.
> Any driver where NAPI instance gets reused and not reallocated on each
> queue restart may have this problem. netdevsim doesn't 'cause the
> callbacks can't fail in funny ways there.
> 
> CC: michael.chan@broadcom.com
> CC: pavan.chebbi@broadcom.com
> CC: hawk@kernel.org
> CC: ilias.apalodimas@linaro.org
> CC: dw@davidwei.uk
> CC: almasrymina@google.com
> CC: sdf@fomichev.me
> ---
>  include/net/page_pool/types.h             |  2 ++
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c |  9 ++++++++-
>  net/core/page_pool.c                      | 13 +++++++++++++
>  3 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 431b593de709..1509a536cb85 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -265,6 +265,8 @@ struct page_pool *page_pool_create_percpu(const struct page_pool_params *params,
>  struct xdp_mem_info;
>  
>  #ifdef CONFIG_PAGE_POOL
> +void page_pool_enable_direct_recycling(struct page_pool *pool,
> +				       struct napi_struct *napi);
>  void page_pool_disable_direct_recycling(struct page_pool *pool);
>  void page_pool_destroy(struct page_pool *pool);
>  void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 5578ddcb465d..76a4c5ae8000 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -3819,7 +3819,6 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
>  	if (BNXT_RX_PAGE_MODE(bp))
>  		pp.pool_size += bp->rx_ring_size / rx_size_fac;
>  	pp.nid = numa_node;
> -	pp.napi = &rxr->bnapi->napi;
>  	pp.netdev = bp->dev;
>  	pp.dev = &bp->pdev->dev;
>  	pp.dma_dir = bp->rx_dir;
> @@ -3851,6 +3850,12 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
>  	return PTR_ERR(pool);
>  }
>  
> +static void bnxt_enable_rx_page_pool(struct bnxt_rx_ring_info *rxr)
> +{
> +	page_pool_enable_direct_recycling(rxr->head_pool, &rxr->bnapi->napi);
> +	page_pool_enable_direct_recycling(rxr->page_pool, &rxr->bnapi->napi);

We do bnxt_separate_head_pool check for the disable_direct_recycling
of head_pool. Is it safe to skip the check here because we always allocate two
pps from queue_mgmt callbacks? (not clear for me from a quick glance at
bnxt_alloc_rx_page_pool)

