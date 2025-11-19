Return-Path: <netdev+bounces-239766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF06C6C408
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C23174E2E5C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 01:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE611C84DE;
	Wed, 19 Nov 2025 01:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTLr6arQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8598F1DFF0;
	Wed, 19 Nov 2025 01:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763515940; cv=none; b=j64aw6wTBoMOr9CC2jP21MPre5Rm2KTE8XswcI5gKvolV7KiMiDJEc7mW4dPfrT1uMq5zTqgKI/vXcws8V+kJnNLnHngkmEEijYywEsMOdDXjoMcBTtLVSsbWYhR3IcQa0wcTuvBtWGK2imtEZVU7qTRmKxP0MY0rBXtkIb1Hfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763515940; c=relaxed/simple;
	bh=g/GSHDcuXKB4Hww2s39FmtkTvNado/saKz5/DQTC3ug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2rAHvFs+/MEVSHl2FqFYxSuL1eyGtnMO5iQ6jXrPrZL75uN+lzl5Er0YJsMwEYmULUm+cKDIL1Wtv0m+LniRs3HZMx3ZjT7ewuj7apZ+ZPJC8IxtPAGfdbjkaJ/2hVRtnF00TDxgX6H9ZcmhBX2ShQko79rjVIvHvGzZDLLoGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTLr6arQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09263C19423;
	Wed, 19 Nov 2025 01:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763515940;
	bh=g/GSHDcuXKB4Hww2s39FmtkTvNado/saKz5/DQTC3ug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WTLr6arQogzsOkCJPLHx8qeqiPps7HWjRidq2Z4GhS0z7VJoR7ihKZ6VfPIlJ4ygb
	 rnZVz6f/fEjS/LWwMW3d797NBEXc6xxJ3A4hxRB148xvDXpoT1QaBjggIM+xUSph7I
	 YcsOBy0QpExhTPDx6rkdGX73bTSgjJne89j7bCRlm73QIZUqAnQI9UJ2F7rymXh/qt
	 REfj/9GWvHjI6UeKYfYdQ/hD4EtKZwV4gSoC7VfnfxaPi2cJguZolP+obFMeMgfxdL
	 JRizWgguJV0WDCRm4gE4JQHA4+A+VlFR6DzOaFAi2vvHOSHRb8LWMxwGX4Yw6htybU
	 ByhPhw14D630w==
Date: Tue, 18 Nov 2025 17:32:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Byungchul Park <byungchul@sk.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel_team@skhynix.com, harry.yoo@oracle.com,
 hawk@kernel.org, andrew+netdev@lunn.ch, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 ziy@nvidia.com, willy@infradead.org, toke@redhat.com,
 asml.silence@gmail.com, alexanderduyck@fb.com, kernel-team@meta.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 mohsin.bashr@gmail.com, almasrymina@google.com, jdamato@fastly.com
Subject: Re: [RFC net-next] eth: fbnic: use ring->page_pool instead of
 page->pp in fbnic_clean_twq1()
Message-ID: <20251118173216.6b584dcb@kernel.org>
In-Reply-To: <20251119011146.27493-1-byungchul@sk.com>
References: <20251119011146.27493-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 10:11:46 +0900 Byungchul Park wrote:
> With the planned removal of @pp from struct page, we should access the
> page pool pointer through other means.  Use @page_pool in struct
> fbnic_ring instead.
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
> I should admit I'm not used to the following code.  So I'd like to ask
> how to alter page->pp to avoid accessing @pp through struct page
> directly.  Does the following change work?  Or can you suggest other
> ways to achieve it?

@ring in this context is the Tx ring, but it's the Rx ring that has the
page_pool pointer. Each Rx+Tx queue pair has 6 rings in total. You need
the sub0/sub1 ring of the Rx queue from which the page came here.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> index b1e8ce89870f..95f158ba6fa2 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> @@ -653,7 +653,7 @@ static void fbnic_clean_twq1(struct fbnic_napi_vector *nv, bool pp_allow_direct,
>  				 FBNIC_TWD_TYPE_AL;
>  		total_bytes += FIELD_GET(FBNIC_TWD_LEN_MASK, twd);
>  
> -		page_pool_put_page(page->pp, page, -1, pp_allow_direct);
> +		page_pool_put_page(ring->page_pool, page, -1, pp_allow_direct);
>  next_desc:
>  		head++;
>  		head &= ring->size_mask;


