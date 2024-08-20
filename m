Return-Path: <netdev+bounces-120232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2F3958A02
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B199F1C21651
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEDF198E75;
	Tue, 20 Aug 2024 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvP0yVC9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07D3192B6F;
	Tue, 20 Aug 2024 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165023; cv=none; b=rWfnX5EPL55sDzWD8x80fgif2V2MJyzQbEGHqZ255ZHyvW4XfS7v+RDwiVhGCdh6YyRevYWk1D+KD4erkSl61OkqpJEKPgdRpmnXuvscFM8n/zmSWhEiKOwWu8xJGbrtWBj35156tIay5+eRO0YzR4Z44JgFn29QetkrUh2RY1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165023; c=relaxed/simple;
	bh=qKVWR2bAYFjX4EnvEKN/nM7t6D7ZiPXtCFfUKjHWsmY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idIG4S4xYDSdApY97AIWg4KBeYXrukSXpjaETGRMlBSyPiIV09q7ElreDwGoxHwbyWpt+1bgCbwUA5gw3EP+IqwIjC8U5vBg+1d/nXykx4RzzIkErJVZ6KpS6tlqjjwiSjnLscAictFYMdanRmYgD6UgJwig7NS1imDxIl0ii0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvP0yVC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876FEC4AF0B;
	Tue, 20 Aug 2024 14:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724165022;
	bh=qKVWR2bAYFjX4EnvEKN/nM7t6D7ZiPXtCFfUKjHWsmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jvP0yVC9+ktb07008ryrlvI+J8gqmlyEQfRbAnctHjVCiZp7Qz+hK/Vq4bKBkiC5Y
	 yOz9KxTEO93iX9v+f/FPi/EuLJh9I3KGu1ZAEtGW+xu4mijbw+f+L3I2XE3anS+72p
	 P9x7TNI6/8lDRg0higKB2QCeNuMSNDTdshkSwlxuNVwfGkObNSct2tbh4Wb6NbKO4B
	 h3t0q+0sXn4OAPbJEuGAiteC4cd5oNJCExgVYWCGonHOqOZa5583BD/hNWo4+0nIjh
	 MxSjnFx/mAD5Czxm2+Y9QdYU2YOpiI7e7yjZQ9H/AwHzi1cLPrAXeOaZ0/F03qJbqk
	 bGeHTpt7bgmbQ==
Date: Tue, 20 Aug 2024 07:43:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Somnath Kotur
 <somnath.kotur@broadcom.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Yonglong Liu <liuyonglong@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, pabeni@redhat.com, ilias.apalodimas@linaro.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Duyck
 <alexander.duyck@gmail.com>, Alexei Starovoitov <ast@kernel.org>, "shenjian
 (K)" <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
 joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev
Subject: Re: [BUG REPORT]net: page_pool: kernel crash at
 iommu_get_dma_domain+0xc/0x20
Message-ID: <20240820074340.6de9282d@kernel.org>
In-Reply-To: <CAHS8izP-MWSFJi8zMW2P144-5p+KyWwNT2+UXBwSf=ocseQycQ@mail.gmail.com>
References: <0e54954b-0880-4ebc-8ef0-13b3ac0a6838@huawei.com>
	<8743264a-9700-4227-a556-5f931c720211@huawei.com>
	<e980d20f-ea8a-43e3-8d3f-179a269b5956@kernel.org>
	<CAOBf=musxZcjYNHjdD+MGp0y6epnNO5ryC6JgeAJbP6YQ+sVUA@mail.gmail.com>
	<ad84acd2-36ba-433c-bdf7-c16c0d992e1c@huawei.com>
	<190d5a15-d6bf-47d6-be86-991853b7b51d@arm.com>
	<5b0415ff-9bbe-4553-89d6-17d12fd44b47@huawei.com>
	<ae995d55-daa9-4060-85fa-31b4f725a17d@arm.com>
	<20240806135017.GG676757@ziepe.ca>
	<CAHS8izP-MWSFJi8zMW2P144-5p+KyWwNT2+UXBwSf=ocseQycQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 09:22:39 -0400 Mina Almasry wrote:
> Is it for some reason not feasible for the page_pool to release the
> pages on driver unload and destroy itself, rather than have to stick
> around until all pending pages have been returned from the net stack?

Normal page pool does not track all the pages it allocates.

