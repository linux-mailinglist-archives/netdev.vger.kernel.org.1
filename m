Return-Path: <netdev+bounces-34005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8BD7A162D
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 08:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722E22820DE
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 06:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F01663D;
	Fri, 15 Sep 2023 06:33:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBF71379
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 06:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335D2C433C8;
	Fri, 15 Sep 2023 06:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694759609;
	bh=df8KjSGqkWBXElZoWeRLQf76mAYxB8rwFbLo3Cy0rAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RspfMpfuO6tDZoafl93RwEe0tsWn64BfyjrBXAKOj1rJ5Ie6MuCjusM9+o+2Mz+iC
	 EvVyaHtWCQb4EJYwMVxB5l2IBpV2BJsPDKwDDJaZpP5Sx1EORsFHYYBevThHch13lQ
	 OTE248VuOWKjnbZxT1idEbfkrf1jW7XPiCVr8uVgJhgWb8wa48vP1yVGnmEbm8Lrkn
	 k0kUgvFSO3GFvkt7Jl5LEbhjA4nFkDic6r3G38Fm+GYavkrAVEl4YnrfuwMtt7viXK
	 FitgqiiRJYR75RJbPR+4DJV2hna9ByRMF+qE5uEHezR06MyYOzdVm5fKgj0T23RZK3
	 Dni5STX/YTDpw==
Date: Fri, 15 Sep 2023 08:33:24 +0200
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>, Andrew Lunn <andrew@lunn.ch>,
	dmaengine@vger.kernel.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] dmaengine: ti: k3-udma-glue: fix
 k3_udma_glue_tx_get_irq() error checking
Message-ID: <20230915063324.GC758782@kernel.org>
References: <5b29881f-a11a-4230-a044-a60871d3d38c@kili.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b29881f-a11a-4230-a044-a60871d3d38c@kili.mountain>

On Wed, Sep 13, 2023 at 02:05:31PM +0300, Dan Carpenter wrote:
> The problem is that xudma_pktdma_tflow_get_irq() returns zero on error
> and k3_ringacc_get_ring_irq_num() returns negatives.  This complicates
> the error handling.  Change it to always return negative errors.
> 
> Both callers have other bugs as well.  The am65_cpsw_nuss_init_tx_chns()
> function doesn't preserve the error code but instead returns success.
> In prueth_init_tx_chns() there is a signedness bug since "tx_chn->irq"
> is unsigned so negative errors are not handled correctly.

Hi Dan,

I understand that the problems are related, but there are several of them.
Could they be handled in separate patches (applied in a specific order) ?
I suspect this would aid backporting, and, moreover, I think it is nice
to try to work on a one-fix-per-patch basis.

The above notwithstanding, I do agree with the correctness of your changes.

> Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
> Fixes: 5b65781d06ea ("dmaengine: ti: k3-udma-glue: Add support for K3 PKTDMA")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> The k3_udma_glue_tx_get_irq() function is in dmaengine, but this bug
> affects networking so I think the fix should go through networking.

...

