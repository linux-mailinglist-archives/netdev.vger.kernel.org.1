Return-Path: <netdev+bounces-114779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D56929440B8
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 04:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FDC1282480
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 02:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F111A4B25;
	Thu,  1 Aug 2024 01:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3aQg0uN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79EE1A4B20;
	Thu,  1 Aug 2024 01:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722476240; cv=none; b=aKuTbATc7QBXiR/j1UEfSPzM+591HPGdoiAS+HSXnl7Drp/vxFX2fYwLtWmR7JIp0UX1SXN/zHAIRRbQT39blHkHH8EBuy5S8vtnHYY73nWtP3I/xaH1NRegLIxUCPPRHxGlNtnl8xciKcrE36OCglCzfPcPxJagR6AivSOyyh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722476240; c=relaxed/simple;
	bh=CFcLagnhSPLMkv28jhrd6F2i/6gjaTbXT0G9AfzAiX8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nod947lGplONeemDCJyk2FLF+ohIIl1FDWuDY+4B4mmdMgwCwuhKios4UsUfYiLwfm7q7wxTc36d4HWJO2v2Dpgn0QmSXJF2FmPo2nzSUefBxdIT56J7wjgc6GcVHOxRK3kqqBf6qTLjrbrCNvfs2wWGWVwX7xRdZzIBL5CyC94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3aQg0uN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753ABC116B1;
	Thu,  1 Aug 2024 01:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722476240;
	bh=CFcLagnhSPLMkv28jhrd6F2i/6gjaTbXT0G9AfzAiX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k3aQg0uNsI6wVnZRrP3i5y9symMkz96EVSqcoS3Ri0uAgRy2rFKPXTvoyP0IsIBXP
	 xqAHY6YIJkmGtXZ+MhEZqu/A1KIp52DEQX5d7CDuAH/3kz5fCF1rWV4Vazs/SDH7IO
	 dqfKbNMv9TTdW5W4DWO4veiRMcJdMrMJSdbU/7t4RJXXhWmrld7mXRk7tidq7Uqx5V
	 FaRPbYfQEA+MJ9HWiHSiTaIRsV1tiiED2gJfM7lkK8t7BkckVbJ8BWK8Zb44mPy0VG
	 lHz4f6grd9fzmaLkqnB8BjYqkArT0SHnBgCAuwB7Bviw6Bgtvf7NM7JsQihUMWlGZB
	 78kIW1JFnfvdQ==
Date: Wed, 31 Jul 2024 18:37:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Elad Yifee <eladwf@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Daniel Golle <daniel@makrotopia.org>,
 Joe Damato <jdamato@fastly.com>
Subject: Re: [PATCH net-next v2 0/2] net: ethernet: mtk_eth_soc: improve RX
 performance
Message-ID: <20240731183718.1278048e@kernel.org>
In-Reply-To: <CA+SN3soFwyPs2YhvY+x33B6WsHHahu6hbKM-0TpdkquJwzD7Gw@mail.gmail.com>
References: <20240729183038.1959-1-eladwf@gmail.com>
	<ZqfpGVhBe3zt0x-K@lore-desk>
	<CA+SN3soFwyPs2YhvY+x33B6WsHHahu6hbKM-0TpdkquJwzD7Gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 08:29:58 +0300 Elad Yifee wrote:
> Since it's probably the reason for the performance hit,
> allocating full pages every time, I think your suggestion would improve the
> performance and probably match it with the napi_alloc_frag path.
> I'll give it a try when I have time.

This is a better direction than disabling PP.
Feel free to repost patch 1 separately.
-- 
pw-bot: cr

