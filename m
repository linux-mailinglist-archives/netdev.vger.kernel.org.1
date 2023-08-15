Return-Path: <netdev+bounces-27760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DC677D1C4
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 20:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72071281592
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 18:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C8018021;
	Tue, 15 Aug 2023 18:26:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0772A154AC
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 18:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73F9C433C7;
	Tue, 15 Aug 2023 18:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692123963;
	bh=RyNIXN83QHxSVLtO+IEVs/MXXMI1+uNpytdp2lq0x4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rXH4lr3ZY2re3nsFyVfq8E7tcLVAQs1ATVJ/TP97OOox4/9Tp8Gr6TcEWCvBG47xr
	 ci1h1lUj+1S4cFGNGmklKwZJPS1QSztMZn98mCtel7+zEh1bnMsMtPh+upKVsI+EVL
	 /uyzSea6z6FfSuMJXnZq74j1/HwhmGcvp7zRR1s392aadIUBEPyJjrjpA3clC3C/g0
	 vvaMXg0wpkcmS5nzPMtGpS0QOexVEeI9UrwqRrBjyq3An8fgbzDeayJnimkxY0vKru
	 /vqe6b0oAG9hPHBuOlFq8W0czri9BliEt0E26zktjtXjF5bUzvulQ0kkgoHOq7gj5m
	 oxXsBEJJ/vzEw==
Date: Tue, 15 Aug 2023 21:25:58 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: hns3: move dump regs function to a
 separate file
Message-ID: <20230815182558.GP22185@unreal>
References: <20230815060641.3551665-1-shaojijie@huawei.com>
 <20230815060641.3551665-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815060641.3551665-2-shaojijie@huawei.com>

On Tue, Aug 15, 2023 at 02:06:38PM +0800, Jijie Shao wrote:
> The dump register function is being refactored.
> The first step in refactoring is put the dump regs function
> into a separate file.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/Makefile  |   4 +-
>  .../hisilicon/hns3/hns3pf/hclge_debugfs.c     |   1 +
>  .../hisilicon/hns3/hns3pf/hclge_main.c        | 558 +----------------
>  .../hisilicon/hns3/hns3pf/hclge_main.h        |   2 -
>  .../hisilicon/hns3/hns3pf/hclge_regs.c        | 567 ++++++++++++++++++
>  .../hisilicon/hns3/hns3pf/hclge_regs.h        |  17 +
>  .../hisilicon/hns3/hns3vf/hclgevf_main.c      | 121 +---
>  .../hisilicon/hns3/hns3vf/hclgevf_main.h      |   1 +
>  .../hisilicon/hns3/hns3vf/hclgevf_regs.c      | 127 ++++
>  .../hisilicon/hns3/hns3vf/hclgevf_regs.h      |  13 +
>  10 files changed, 731 insertions(+), 680 deletions(-)
>  create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c
>  create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.h
>  create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c
>  create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.h
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

