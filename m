Return-Path: <netdev+bounces-138737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D0F9AEAFB
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 17:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9F751C2201F
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819E61F7084;
	Thu, 24 Oct 2024 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaTdw5l/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8281F5851
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784708; cv=none; b=BFxWTxOgzOHXgDtPisJn+ePPkg2jqmImdDMqo+EVyOW1jRFuEi4Ajb38FJ/ybJYTPFtJvFtJrQlT83s4ZC2NBcchZ902rHSwDucwa4DoHnbw/zjQ0EmbDpxG7pkz1I1rkrvQvl/V7YVB6FfoH0cepCZev35XEkfujXeTAJGRUbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784708; c=relaxed/simple;
	bh=u3+Jz+gAd5z8t166boy8SZz88zfTlvPTHwnjyNDFn/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Le8Ru0lDC8qn4ZTJUuEJ6KGk9oQy+w5txo5g6YvdN05KUJTlCcgyV7vZ1UqZSPWRkecLXQFyuMKfQscYR8lcvBzXfJCZZWrDrcYlnYdhccMhzJOv2s/Asa5F13uJBSvenHs6NBgyUVfyP7bU5kaJqcgDVhuZ/yHL05SyxeEtyaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaTdw5l/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A31AC4CEE4;
	Thu, 24 Oct 2024 15:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729784708;
	bh=u3+Jz+gAd5z8t166boy8SZz88zfTlvPTHwnjyNDFn/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gaTdw5l/pL2TZ6k6a8q5ZDabTxxVV6QEAygWLZmpVJyJg4tYVg9ZQMtcDbfIdPb2/
	 wEDPA7wJIE5uiXdiHbUhPfEI0WXerhXqAjfQG8cH9RiuEbVMq7FDIIlkpf2Kqj+oJM
	 ZGl2yco+7z2+9ilCJWRowhKgf0eUpy0dYyDRGkpWw6U4nFdcs0em+Zliz13VtyTLvW
	 4oLaHDbHDVzZT2y798i0awM1YUonkuSaQpSCpcys1aNS1S4AAyH2X14Q2wOX1yRT03
	 Wr9/HogRJ5bR7LYzVHK5svMPOL61mTJmHJNHoGMYUA9hc/O4YD84zvnyI02AxrHRG+
	 P+eHzQtuKtrZg==
Date: Thu, 24 Oct 2024 16:45:03 +0100
From: Simon Horman <horms@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Praveen Kaligineedi <pkaligineedi@google.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, willemb@google.com,
	jeroendb@google.com, shailend@google.com, hramamurthy@google.com,
	ziweixiao@google.com, jacob.e.keller@intel.com
Subject: Re: [PATCH net-next] gve: change to use page_pool_put_full_page when
 recycling pages
Message-ID: <20241024154503.GB1202098@kernel.org>
References: <20241023221141.3008011-1-pkaligineedi@google.com>
 <cf13ffde-2a5f-4845-a27d-d4789a384891@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf13ffde-2a5f-4845-a27d-d4789a384891@huawei.com>

On Thu, Oct 24, 2024 at 10:36:02AM +0800, Yunsheng Lin wrote:
> On 2024/10/24 6:11, Praveen Kaligineedi wrote:
> > From: Harshitha Ramamurthy <hramamurthy@google.com>
> > 
> > The driver currently uses page_pool_put_page() to recycle
> > page pool pages. Since gve uses split pages, if the fragment
> > being recycled is not the last fragment in the page, there
> > is no dma sync operation. When the last fragment is recycled,
> > dma sync is performed by page pool infra according to the
> > value passed as dma_sync_size which right now is set to the
> > size of fragment.
> > 
> > But the correct thing to do is to dma sync the entire page when
> > the last fragment is recycled. Hence change to using
> > page_pool_put_full_page().
> 
> I am not sure if Fixes tag is needed if the blamed commit is only
> in the net-next tree. Otherwise, LGTM.

I think it would be best to provide a fixes tag in this case.
It can be done by supplying it in a response to this email thread.
(I think it needs to start at the beginning of a line.)

> Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
> 
> > 
> > Link: https://lore.kernel.org/netdev/89d7ce83-cc1d-4791-87b5-6f7af29a031d@huawei.com/
> > 
> > Suggested-by: Yunsheng Lin <linyunsheng@huawei.com>
> > Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>

...

