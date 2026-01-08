Return-Path: <netdev+bounces-248081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 402BBD03110
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 14:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3083730B32C1
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 13:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E52D2DB7B4;
	Thu,  8 Jan 2026 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKy9C0iP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3457C18859B
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767878544; cv=none; b=kWhVjimKnGC3Am6GMC4+OSGodPRjK4XochkPu3iTXicfUxN9A0ED+HYr+u/Z7kMYoguwXHnj6cExj0Xb/oFVdbg/AntvcKyDHVMm18fmo1MT0ixDyroWNspU07Ze1obD0aQt0J+a28PxPlCoXp/x/JDGrDW2paXduVP/nwBgOvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767878544; c=relaxed/simple;
	bh=5VC3XO65xa/3k4GCT3RsZy0cYcsebKOEvEis61s4nuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMcGuMaqk/LLTdJmT7U5FkqG8AyRxlgA3am73ZtMUTrypHKEVNKBev0APpI+xRaIOr/i4dtCtTiEczw1GbR7ZMD+nraflU+REWOKPbLB/hHbUN3an6YUUfvvr9N75M5tHQTFomDd/oqaHmU3O7w1bXmZTq5jtKJYkMk8dh9OqpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKy9C0iP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AE2C116C6;
	Thu,  8 Jan 2026 13:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767878543;
	bh=5VC3XO65xa/3k4GCT3RsZy0cYcsebKOEvEis61s4nuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IKy9C0iPwki/PsgSXscFwuR5IKQkfr5AS7wnEqKjQf6oatQuNj/YzvQ0DogAa2h5v
	 SSL+uPUvxH7vidtqGhZoMeCOgXJVBanC6xnwcQQX1u1O12zrX2AVoH5NYqiGeiyhYr
	 ZX0PQo+Zqou4UJxVo29C+wirnYgOIHMw6tzGBKokOZYwlNEgY/+unc7ULCkyEjdY1G
	 f4W2VEDrB12LLx3AlcUCestFCmQJ3VEnDPHsChd5VjFzLLqhrMWDKxS8YeBNnQ2pXw
	 meMHqTl807NSIB2iNousQNqLG5fDi81KdOP9swRmeAmG1LU+GTBWKNmqzsu4yHgBvC
	 h594bYUdX5ZBA==
Date: Thu, 8 Jan 2026 13:22:18 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net: airoha: Fix schedule while atomic in
 airoha_ppe_deinit()
Message-ID: <20260108132218.GG345651@kernel.org>
References: <20260105-airoha-fw-ethtool-v2-1-3b32b158cc31@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105-airoha-fw-ethtool-v2-1-3b32b158cc31@kernel.org>

On Mon, Jan 05, 2026 at 09:43:31AM +0100, Lorenzo Bianconi wrote:
> airoha_ppe_deinit() runs airoha_npu_ppe_deinit() in atomic context.
> airoha_npu_ppe_deinit routine allocates ppe_data buffer with GFP_KERNEL
> flag. Rely on rcu_replace_pointer in airoha_ppe_deinit routine in order
> to fix schedule while atomic issue in airoha_npu_ppe_deinit() since we
> do not need atomic context there.

Hi Lorenzo,

If I understand things correctly the key problem here is that
an allocation with GFP_KERNEL implies GFP_RECLAIM and thus may sleep.
But RCU read-side critical sections are not allowed to sleep in non-RT
kernels.

If so, I think it would be clearer to describe the problem along those
lines. But maybe it is just me.

> 
> Fixes: 00a7678310fe3 ("net: airoha: Introduce flowtable offload support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v2:
> - Update commit log.
> - Link to v1: https://lore.kernel.org/r/20251223-airoha-fw-ethtool-v1-1-1dbd1568c585@kernel.org

...

