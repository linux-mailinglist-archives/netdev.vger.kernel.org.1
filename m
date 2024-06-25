Return-Path: <netdev+bounces-106693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E759174D4
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 01:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F1C1C2145D
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 23:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4709617F39B;
	Tue, 25 Jun 2024 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obEQ51TJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E7D1494A3
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 23:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719358778; cv=none; b=UmdQxZjhi7kyW3TvQymBuBKBLsddYRLhKqKsusCIANFDnt4eE0mNhkqo2wl4H6rQbc/BsLEa2Gxp7Qad/7PdbH2bBJRu9xpTs8vs1Us8JzmMClM8JxjilzPtCVtiVMPkqKJ34auviSXwYMKRraynjEIaH9z73qplh3PtIzK83SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719358778; c=relaxed/simple;
	bh=TsxY4HiE/prnPeYmjrIqdGRZJU3/qLZUkkkK7VBAk2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0/pfTYc7HWlEye5Q9grMDqzO2j3kaODA9o6u2YjDjAuOpyCrOiMWC160DNu2VPhmsGTnWDGclAO120LuYQNzi1wciWSkQt+xqFbD+k0blSsiJQBhtaE6fnthrEtNymbzInX8XC3OYMty1dMNIOWkLzAnHiiZGH8rKEtRvybolc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obEQ51TJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3822CC32781;
	Tue, 25 Jun 2024 23:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719358777;
	bh=TsxY4HiE/prnPeYmjrIqdGRZJU3/qLZUkkkK7VBAk2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=obEQ51TJPNmBfK94XCrTVtjwV3d8T2MCczGcfgnuABdoMDi3Q3+i4lHGdMx+odiu+
	 wa2sNpPBXodJHducGbYxFKV9zXcB5yZp5R5WlieTmSw2ZFGK4i8AR19z7p5BjWtHeX
	 BslsdCTb5UHp7jfyYapAJlsgBiKqCXA0swNDhUIkY4SUFeQlSCRZapuNUHJGx247q+
	 k9SShaw62QuJBtDzrVPsI6cVR+x3JJ6WHuSmgf/zRP/xK00KIS+9MY4DfCWxCN86th
	 GEsaExiDLTgp13Z3ubn6eFHaSMzls5TtWnpo9BhQKwyz5i3qi9t9PuyC3TjmEAj6aT
	 Ak77dtJ804CoQ==
Date: Tue, 25 Jun 2024 16:39:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Michael Chan <michael.chan@broadcom.com>, Andy Gospodarek
 <andrew.gospodarek@broadcom.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/2] page_pool: reintroduce
 page_pool_unlink_napi()
Message-ID: <20240625163936.2bf9197b@kernel.org>
In-Reply-To: <20240625195522.2974466-2-dw@davidwei.uk>
References: <20240625195522.2974466-1-dw@davidwei.uk>
	<20240625195522.2974466-2-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 12:55:21 -0700 David Wei wrote:
>  #ifdef CONFIG_PAGE_POOL
> +void page_pool_unlink_napi(struct page_pool *pool);
>  void page_pool_destroy(struct page_pool *pool);
>  void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
>  			   const struct xdp_mem_info *mem);
>  void page_pool_put_page_bulk(struct page_pool *pool, void **data,
>  			     int count);
>  #else
> +static inline void page_pool_unlink_napi(struct page_pool *pool)
> +{
> +}

All callers must select PAGE_POOL, I don't think we need the empty
static inline in this particular case.

>  static inline void page_pool_destroy(struct page_pool *pool)
>  {
>  }
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 3927a0a7fa9a..ec274dde0e32 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -1021,6 +1021,11 @@ static void page_pool_disable_direct_recycling(struct page_pool *pool)
>  	 */
>  	WRITE_ONCE(pool->cpuid, -1);
>  
> +	page_pool_unlink_napi(pool);

No need to split page_pool_disable_direct_recycling()
into two, we can write cpuid, it won't hurt.

The purpose of the function didn't really change when Olek
renamed it. Unlinking NAPI is also precisely to prevent recycling.
So you can either export page_pool_disable_direct_recycling()
add a wrapper called page_pool_unlink_napi(), or come up with
another name... But there's no need to split it.

> +}
> +
> +void page_pool_unlink_napi(struct page_pool *pool)
> +{
>  	if (!pool->p.napi)
>  		return;
>  
> @@ -1032,6 +1037,7 @@ static void p
-- 
pw-bot: cr

