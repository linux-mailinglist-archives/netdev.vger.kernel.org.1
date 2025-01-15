Return-Path: <netdev+bounces-158455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C277A11EEF
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5BA16493E
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5266220896C;
	Wed, 15 Jan 2025 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sQ5UBkzG"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9F520AF91
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935669; cv=none; b=tiCJIhpklYjbDorD9gC+vaaNDBFq1ueHpL/L9Fe2V6HVpjnnXJtCSoUoE0azpls5A+qzZdB6H0AtHoawbHxYWKtQCgDyL10O2ELOvlxI5N84J0IEEtC8ObZIgwGJwggI9nA1nVwLky8itTqJXIekLAyG9eXeC+2a/woTvgV6MN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935669; c=relaxed/simple;
	bh=FAtZ0mm29jZ50IwyJ7GC4BVJeuSrY3btO825CGXEjrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t3MhZnd2r8Xv9COUuzLaaBI+xiIlSKnh0yCaErOmkWEkHVqfZIaiDBQGcPdnkZSWYOM6Ucw1QXfEeE4CfEqWhTvZaJW2YEsuVCXWdl5G1B0KbklYfLivTTZTBD6nJGamIjs0pGMbjprVczX2rFSThcTgD6CYtOt5y8Dv/oqbiXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sQ5UBkzG; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7b6acdc1-5151-427a-ac84-a6cb666f53ca@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736935663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ryMO4/DGARz6dpCLQgFlxwCCK8jbknJTAtU+Z1iluM=;
	b=sQ5UBkzG6Sa3qwVPFnRjJjSi78MlbdlIdHnotUb3Krv0djZP3ulfjNYrnAvnejXn9nljQU
	SvZ+0x2kBc/MdnUJ3aGiOIqMwLFJVYJUtFNSTWSgld9Cfw7zvgM3nDN7uL4BSNBcKXVIVO
	ZkT9vGUEOC1SEqDw/a7zktPocbQc8Pk=
Date: Wed, 15 Jan 2025 18:07:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 2/4] net: stmmac: Set page_pool_params.max_len
 to a precise size
To: Furong Xu <0x1207@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Joe Damato <jdamato@fastly.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
References: <cover.1736910454.git.0x1207@gmail.com>
 <538f87c8bdd0ba9e2b9cb5cd0e2964511c001890.1736910454.git.0x1207@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <538f87c8bdd0ba9e2b9cb5cd0e2964511c001890.1736910454.git.0x1207@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/1/15 11:27, Furong Xu 写道:
> DMA engine will always write no more than dma_buf_sz bytes of a received
> frame into a page buffer, the remaining spaces are unused or used by CPU
> exclusively.
> Setting page_pool_params.max_len to almost the full size of page(s) helps
> nothing more, but wastes more CPU cycles on cache maintenance.
> 
> For a standard MTU of 1500, then dma_buf_sz is assigned to 1536, and this
> patch brings ~16.9% driver performance improvement in a TCP RX
> throughput test with iPerf tool on a single isolated Cortex-A65 CPU
> core, from 2.43 Gbits/sec increased to 2.84 Gbits/sec.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Yanteng Si <si.yanteng@linux.dev>

Thanks,
Yanteng

> ---
>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
>   drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.h  | 1 -
>   2 files changed, 1 insertion(+), 2 deletions(-)



