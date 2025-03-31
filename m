Return-Path: <netdev+bounces-178378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFF5A76C96
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 19:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6187F3A922D
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E34210186;
	Mon, 31 Mar 2025 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPawjLH7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804811DF270
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 17:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743442459; cv=none; b=LTj0Qsgb6yXcsVVLg9pS38oCiD61Sb6w7ceAcqfDdusbNK1vNv0Agn3UpGCJTLuQJbf0TMA9PgEbHBhXmJRXfL1ctJYdG0/2sXcnj4HkMbq+7N52HVDx3m3u6vrhgWYiVitBfkZNVkPGtSPoGbN9tC0FVtITat3f3AvHeQL9A/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743442459; c=relaxed/simple;
	bh=yczRD+ELivexE+bk8yahNPgnb4hdq0snpJN+Es9kdRI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XimxdTDA7W4yPcB0TegawHUUmmPQquxGRRBut+j8iU9NQeb2+Sd/a8x0SDt7Xfr+UqRInPG6Ox6H9UNbruRPcqeFsoCyyj22wsY4kHfYjsIGBiiNdmtUMCCnmOjEhoeTqx+s+uwvpIhmwE+WmBggTQUnFj3PPuNfYW357lEtYp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPawjLH7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C86C4CEE3;
	Mon, 31 Mar 2025 17:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743442458;
	bh=yczRD+ELivexE+bk8yahNPgnb4hdq0snpJN+Es9kdRI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kPawjLH7TvM5e/DnZrS1yMDvyiL0eGHiAj7XKZiyffwntshj3Qdfde+zpAmgbRmIS
	 2LfcLZzKg4JiMtcROjf3A+iGOLnUcKRhxcBvLSSEis7MRxd6CSMcvSbkd7ht9mD2nv
	 AezuRZxeT3tnEGmRKO7bxeaHZY8RNze+g25ziQUF3O1OsBeCNZI0UATmUwAh65i5hy
	 htz5ykRp5taM4zI8CrXt07MJeDn2xhElz9v0uZXvz6iBB+07r+3FV3pt5WReDk5Qn+
	 XggCLbPxDysHEXfYY2XB3963J8e0G7VMUvlq/iRm7EyYELSmVdpjeJoxR8wC9U1rYy
	 xXRqnWBdN0KRA==
Date: Mon, 31 Mar 2025 10:34:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, ilias.apalodimas@linaro.org, dw@davidwei.uk,
 netdev@vger.kernel.org, kuniyu@amazon.com, sdf@fomichev.me,
 aleksander.lobakin@intel.com
Subject: Re: [RFC net-next 1/2] eth: bnxt: refactor buffer descriptor
Message-ID: <20250331103416.7b76c83c@kernel.org>
In-Reply-To: <20250331114729.594603-2-ap420073@gmail.com>
References: <20250331114729.594603-1-ap420073@gmail.com>
	<20250331114729.594603-2-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 11:47:28 +0000 Taehee Yoo wrote:
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

LGTM, could you split this into two patches, tho?
One for the BD change and one for the syncing changes?

> -	dma_sync_single_for_device(&pdev->dev, mapping, bp->rx_copybreak,
> -				   bp->rx_dir);
> -
> +	page_pool_dma_sync_for_device(rxr->head_pool, page_to_netmem(page),
> +				      bp->rx_dma_offset, bp->rx_copybreak);

I think we should add a separate helper for this instead of extending
the existing page_pool_dma_sync_for_device(). Let's call it
page_pool_dma_sync_for_device_frag() ?

The use case here is that the driver recycles a frag directly, rather
than following the normal PP recycling path.

