Return-Path: <netdev+bounces-46885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FA17E6EA6
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 17:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8571C2048D
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 16:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CFE1DFD0;
	Thu,  9 Nov 2023 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qoyng9CG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B7222316
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 16:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96263C433C8;
	Thu,  9 Nov 2023 16:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699547191;
	bh=XXzMEafkX7VBExkFXCrOevq48tYgtyCzje1C5eN3KPU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qoyng9CGSa9AnUwAclbQsSULwmSvZ32gMNCYzzlrdCxj3Voee4M8E9dSEuivsW1lX
	 aXLlrAlHIgCsFy8DC4KWDei0Pf/8O7iFrIusvsBHFF4REoBu9O+AHxm/Oyy1puuxBx
	 dYWfd/x2UotHDYIHFMGoXb8uJIRJKj+Nbzqit0TIoBXF2Rk0pWTRsdOcZt2F152+BR
	 L6mJJTmPczOfzXIcJw5e8fmAOtq0Zjom0gULJZKXjrRNeDuh3gj3q8Ttgccl0vXQ9s
	 MTjx098uhjpwI1guFIfVDy2JQy1FiK8Qr9hEbCkZ/6BMLwIHT8S7pyU0YWoX7Jwh9+
	 IdPj2J8E3JaYQ==
Date: Thu, 9 Nov 2023 08:26:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, almasrymina@google.com, hawk@kernel.org
Subject: Re: [PATCH net-next 07/15] eth: link netdev to page_pools in
 drivers
Message-ID: <20231109082630.77f74839@kernel.org>
In-Reply-To: <CAC_iWjJzJp+QWCY8ES=yOr4WrKXqF_AWGJjzNdCQmGpa=5dbyQ@mail.gmail.com>
References: <20231024160220.3973311-1-kuba@kernel.org>
	<20231024160220.3973311-8-kuba@kernel.org>
	<CAC_iWjJzJp+QWCY8ES=yOr4WrKXqF_AWGJjzNdCQmGpa=5dbyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Nov 2023 11:11:04 +0200 Ilias Apalodimas wrote:
> > ---
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 1 +
> >  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 1 +
> >  drivers/net/ethernet/microsoft/mana/mana_en.c     | 1 +
> >  3 files changed, 3 insertions(+)  
> 
> Mind add a line for netsec.c (probably in netsec_setup_rx_dring),
> since that's the only NIC I currently have around with pp support?

It's a single queue / single napi device? So like this?

diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index 0891e9e49ecb..384c506bb930 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -1302,6 +1302,8 @@ static int netsec_setup_rx_dring(struct netsec_priv *priv)
 		.dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE,
 		.offset = NETSEC_RXBUF_HEADROOM,
 		.max_len = NETSEC_RX_BUF_SIZE,
+		.napi = priv->napi,
+		.netdev = priv->ndev,
 	};
 	int i, err;
 

