Return-Path: <netdev+bounces-143936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6069C4CA5
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 03:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80283B2BBCF
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 02:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E830207A14;
	Tue, 12 Nov 2024 02:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRzzi2Zo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56575204F6C;
	Tue, 12 Nov 2024 02:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731378858; cv=none; b=SfJSfae0DzrIDWAirD47W+g6HRjWG+EMelvFzbb+WGOOEM29RSVuyHKdkA5W5WQPr51poDFVrX77b/zZOb4H5yA5sljiD7RPA5Lbtd5aqkcoj3uQWcsZzH8Iqzw6rf62jg1O5tqZM2TWIXds8B6pbpeeD0DVlSLvv69H/0ZIqTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731378858; c=relaxed/simple;
	bh=pxT/PFpMqEOnULmkgS1G1EWRrp2+jro36L+OqBH5e60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xas+L51PBqk04zSRrY4ST9AfF/TEQl9tdaOa+piz3oPJl5X1Rv6MqO6Ho5aCIfqpWl+StENJfzs1jYgtvtS4al04+ohTsN3xn5O0e/c3DcTDLhUFFJrDgfprBJCHkejx1qzgZiVqmE990NnsqF0gxbKtNiBC0qA3QVwSTzZzPZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRzzi2Zo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE01C4CECF;
	Tue, 12 Nov 2024 02:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731378858;
	bh=pxT/PFpMqEOnULmkgS1G1EWRrp2+jro36L+OqBH5e60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FRzzi2ZouQZGCR4CTohniMP3ZzVmmj76g9oGz/kP3hUVv0Pg408zZITfRIjLo6Sbs
	 KHE6ptB8l7NSo/APJR/80t8a2a6gtSs/WehUeagPxOulDPGTMZdDB9T2RnRKAG7L1C
	 0+lu/Aik3JjBjsMjzwxPi9X5zVNfCJ9+3Wvs5UGoU3qwaNZRyLUIw+oB9l3X7q4MNK
	 VGz2o5XQiCYMQXMEgOio/e2Sku7kzlNlABY/wUwA4x1ZxsYH3azexKsXGFf1FTAyUm
	 WhriS9lAWzfG1aR7OAXySFRKqjb1MImjAaViLD5fTZBOKhvcoRUL3iX33OaZASWrw2
	 I+VDBRreiZmyA==
Date: Mon, 11 Nov 2024 18:34:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>, Willem
 de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net-next v2 3/5] page_pool: Set `dma_sync` to false for
 devmem memory provider
Message-ID: <20241111183416.678d06d4@kernel.org>
In-Reply-To: <20241107212309.3097362-4-almasrymina@google.com>
References: <20241107212309.3097362-1-almasrymina@google.com>
	<20241107212309.3097362-4-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Nov 2024 21:23:07 +0000 Mina Almasry wrote:
> From: Samiullah Khawaja <skhawaja@google.com>
> 
> Move the `dma_map` and `dma_sync` checks to `page_pool_init` to make
> them generic. Set dma_sync to false for devmem memory provider because
> the dma_sync APIs should not be used for dma_buf backed devmem memory
> provider.

Let's start from specifying the expectations from the drivers,
and documenting them under Documentation/

We should require that drivers set PP_FLAG_DMA_SYNC_DEV on the page
pool and always use (a new form of) page_pool_dma_sync_for_cpu()
to sync for CPU.

Behind the scenes we will configure the PP to act accordingly.
For dmabuf backed PP I suspect we just say "syncing is
the responsibility of userspace", and configure the PP
to do no syncing at all.

For other providers we can keep the syncing enabled. But drivers
shouldn't be allowed to use any netmem if they don't set
PP_FLAG_DMA_SYNC_DEV, just to keep things uniform.

