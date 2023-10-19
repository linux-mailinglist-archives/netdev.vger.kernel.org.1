Return-Path: <netdev+bounces-42635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B039F7CFA67
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7F11C20DDC
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B393225D4;
	Thu, 19 Oct 2023 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF761A290;
	Thu, 19 Oct 2023 13:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA301C433C8;
	Thu, 19 Oct 2023 13:09:40 +0000 (UTC)
Message-ID: <280c1e25-1848-4369-9d1b-7641d3e954b0@linux-m68k.org>
Date: Thu, 19 Oct 2023 23:09:38 +1000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fix the non-coherent coldfire dma_alloc_coherent v2
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Wei Fang <wei.fang@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org,
 netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, Jim Quinlan <james.quinlan@broadcom.com>
References: <20231016054755.915155-1-hch@lst.de>
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20231016054755.915155-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christoph,

On 16/10/23 15:47, Christoph Hellwig wrote:
> Hi all,
> 
> this is the next attempt to not return memory that is not DMA coherent
> on coldfire/m68knommu.  The last one needed more fixups in the fec
> driver, which this versions includes.  On top of that I've also added
> a few more cleanups to the core DMA allocation code.
> 
> Jim: any work to support the set_uncached and remap method for arm32
> should probably be based on this, and patch 3 should make that
> selection a little easier.
> 
> Changes since v1:
>   - sort out the dependency mess in RISCV
>   - don't even built non-coherent DMA support for coldfire cores without
>     data caches
>   - apply the fec workarounds to all coldfire platforms with data caches
>   - add a trivial cleanup for m68k dma.c

This looks good to me for the ColdFire changes. I tested it on a 5208
(version 2 core) with all combinations of cache (instruction only,
data only and both) and it worked good in all cases - with the one
configuration fix to patch 9 I sent earlier. So for ColdFire:

Tested-by: Greg Ungerer <gerg@linux-m68k.org>
Reviewed-by: Greg Ungerer <gerg@linux-m68k.org>

I don't have a 532x ColdFire board, so I can't directly test the case
of a version 3 core with the FEC hardware block.

Regards
Greg


