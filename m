Return-Path: <netdev+bounces-212280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ECDB1EEB6
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 21:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D14A02731
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 19:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286C11F4289;
	Fri,  8 Aug 2025 19:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Db1XJ4G8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E8E1CA81;
	Fri,  8 Aug 2025 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754679936; cv=none; b=KggoOh+xJ5aUyPTn3Fttyw3mrey3xOygTBBZW/F/0lLiwCsIfOT/4bEcu7GQuqf2n+AOlAlsbogoSphJPT6501L3w2O6TosQzsJU3PMEkiXo7bEQcVrMfusEE3lb0Vzx/jQXStqCPCfScWi3pYdEDMsU8kkiXnG1JXb/zWZauug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754679936; c=relaxed/simple;
	bh=9sNZifZ906dYt7wIbV9eoAh1hSVh4+0uqV8iP9M7bIw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQYyDgppFoy09sOFjMr2d4B3tBvVbA/WZlJqCNF9wd/GZ1Sywd1lGPqDP8767tx5+AjBb9PqZX+X93Tb3ynIZIyXhX2+Y/Mf0OFHCWx9mRMD9L/RXeMsCbqsXEZvc962NIPNZscqTjM/9NTGFV0wUm6O37MSaftBYHlUhqHJW14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Db1XJ4G8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FB2C4CEED;
	Fri,  8 Aug 2025 19:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754679935;
	bh=9sNZifZ906dYt7wIbV9eoAh1hSVh4+0uqV8iP9M7bIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Db1XJ4G8RHVrCzWfz7X+y6PLjFRKCtezVLfArElwa49X52xu0y0wb6fzwZrtOrW9e
	 RMnQRFOZaNXpa21Kqqr5QiK4V3xMkEeHujpZ07QczjdcmfQU618W5zEiJ17LieCfq1
	 iINq8vBHGZMWU4qnv02JN2genYJBfNm7A22qVqem5xL6rBjYYBc/k6CGwXAHVhZRI7
	 eTFmJed6OFXe5tLcP6rcwsVBiDwaPyAStPzggj3y53kBOAfa5HhPuYMfAq2JfLosJd
	 +7N3L8sQPGWbHdoD5Q5WG/1QkS4zolLfOlbYqHSIq5JYPrcVb2kCX7i0RFyk7cxraX
	 LDyxQrjRODaKQ==
Date: Fri, 8 Aug 2025 12:05:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <michal.simek@amd.com>, <sean.anderson@linux.dev>,
 <radhey.shyam.pandey@amd.com>, <horms@kernel.org>,
 <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <harini.katakam@amd.com>
Subject: Re: [PATCH net] net: xilinx: axienet: Increment Rx skb ring head
 pointer after BD is successfully allocated in dmaengine flow
Message-ID: <20250808120534.0414ffd0@kernel.org>
In-Reply-To: <20250805191958.412220-1-suraj.gupta2@amd.com>
References: <20250805191958.412220-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Aug 2025 00:49:58 +0530 Suraj Gupta wrote:
> In DMAengine flow, AXI DMA driver invokes callback before freeing BD in
> irq handling path.
> In Rx callback (axienet_dma_rx_cb()), axienet driver tries to allocate
> new BD after processing skb.
> This will be problematic if both AXI-DMA and AXI ethernet have same
> BD count as all Rx BDs will be allocated initially and it won't be
> able to allocate new one after Rx irq. Incrementing head pointer w/o
> checking for BD allocation will result in garbage values in skb BD and
> cause the below kernel crash:
> 
> Unable to handle kernel paging request at virtual address fffffffffffffffa
> <snip>
> Internal error: Oops: 0000000096000006 [#1]  SMP
> pc : axienet_dma_rx_cb+0x78/0x150
> lr : axienet_dma_rx_cb+0x78/0x150
>  Call trace:
>   axienet_dma_rx_cb+0x78/0x150 (P)
>   xilinx_dma_do_tasklet+0xdc/0x290
>   tasklet_action_common+0x12c/0x178
>   tasklet_action+0x30/0x3c
>   handle_softirqs+0xf8/0x230
> <snip>

Do you mean that we're incrementing lp->rx_ring_head before we know
that the submission will succeed? Potentially leaving an uninitialized
entry (say at index n), next attempt will try to use the next entry 
(n + 1) but the completion will not know about the skip so it will
try to complete entry n ?

This is really not coming thru in your explanation.

The fix itself seems incomplete. Even if we correctly skip the increment
we will never try to catch up with the allocations, the ring will have
fewer outstanding Rx skbs until reset, right? Worst case we drop all
the skbs and the ring will be empty, no Rx will happen until reset.
The shutdown path seems to be checking for skb = NULL so I guess it's
correct but good to double check..
-- 
pw-bot: cr

