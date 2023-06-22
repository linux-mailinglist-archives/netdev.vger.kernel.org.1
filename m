Return-Path: <netdev+bounces-12960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC38A73996D
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17102817FC
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EFD15AFE;
	Thu, 22 Jun 2023 08:25:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED23313AEB
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:25:45 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC7E1BE1
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:25:44 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30fcda210cfso6864319f8f.3
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687422342; x=1690014342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tj5C+I7HeG1vpL6n+8jLNCbj2isj+XEX8Di7Bm48+qw=;
        b=oKdr2pCRPDWXIy1kqKz+GQzoNsep5MGxpbwUXovmfx7o029cboskRdzrXQzPMfSeA2
         gx7/SZCfNdlfBudmGdfJ7DYMBHxXzxk1RezMw7RAQYtSViRXJQkHltzIg0e7kNaiU3XQ
         thR/x9sBIit/GsueiK1NR6+hqZ6gShTC76vtaDqDULqp4rLFT5xRAdh2AGp081IAyROv
         +d6e69NzMiEa+l++Af+5acj3vDtpbsY+dJcX9Mv7GxhCRkH2zSdLlcoqfNyrDC5lfVDl
         jddCuoJcbp9QgyS93vgfXanQFiyrpHiaht5lq13lC6/PVMd8rF93uP/4zATEdilZGrcb
         fZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687422342; x=1690014342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tj5C+I7HeG1vpL6n+8jLNCbj2isj+XEX8Di7Bm48+qw=;
        b=INyvjXqjJAt35PEoLAhU1dfReL2HviCSQDhE2OfxZ46Y8HpC4FxmGbggScl2Aqknct
         2Hcm65MlsrMMSkFwsps0Zija4z2I9mnl6bxiDyzdzYAdMpXOM4RlYud5/r7EavXo0sqz
         QJGscScxpx3sLsgCJMFBW0hVb4xj4YBUzE/F0OuOdVt4ktG5w2h9bczLC25nxTx6czyu
         DxIqXxilUgMAplRKvYcaDiYDTLzuLVQ9m6T8a+i6LACKNGHVdoQRPPLyTxgFAUKEftp7
         PNTKtak8U0a7ai4VN8bbaF6c4f7te+tQK7ckus43t+CF0QAae6wh79mEFGHCntJsqqku
         cq+g==
X-Gm-Message-State: AC+VfDzmsZuR+Om/To4lMW28C8ciNryRyGyvJVpAhfFn2HF5TYmFv4/I
	VNXVQ6fr19Q2srymaIeY8X+c8A==
X-Google-Smtp-Source: ACHHUZ7XFfsYPuPByW/01qxDBsnw6NFSD2C7skL84s9Wdwc3Ow8C/fjvbrY7Uw7P/Gg+U/HeyjusyQ==
X-Received: by 2002:a5d:518a:0:b0:30c:5e52:5bad with SMTP id k10-20020a5d518a000000b0030c5e525badmr12585022wrv.18.1687422342565;
        Thu, 22 Jun 2023 01:25:42 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id z13-20020adff74d000000b0030af15d7e41sm6561594wrp.4.2023.06.22.01.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:25:41 -0700 (PDT)
Date: Thu, 22 Jun 2023 10:25:41 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Maxim Kochetkov <fido_max@inbox.ru>
Cc: netdev@vger.kernel.org,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] net: axienet: Move reset before DMA detection
Message-ID: <ZJQFhYGeYATpZB6B@nanopsycho>
References: <20230621112630.154373-1-fido_max@inbox.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621112630.154373-1-fido_max@inbox.ru>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Jun 21, 2023 at 01:26:30PM CEST, fido_max@inbox.ru wrote:
>DMA detection will fail if axinet was started before (by boot loader,
>boot ROM, etc). In this state axinet will not start properly.
>So move axinet reset before DMA detection.
>
>Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>

You are missing a "Fixes:" tag here pointing out to the patch that
introduced the issue.


>---
> drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>index 3e310b55bce2..734822321e0a 100644
>--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>@@ -2042,6 +2042,11 @@ static int axienet_probe(struct platform_device *pdev)
> 		goto cleanup_clk;
> 	}
> 
>+	/* Reset core now that clocks are enabled, prior to accessing MDIO */
>+	ret = __axienet_device_reset(lp);
>+	if (ret)
>+		goto cleanup_clk;
>+
> 	/* Autodetect the need for 64-bit DMA pointers.
> 	 * When the IP is configured for a bus width bigger than 32 bits,
> 	 * writing the MSB registers is mandatory, even if they are all 0.
>@@ -2096,11 +2101,6 @@ static int axienet_probe(struct platform_device *pdev)
> 	lp->coalesce_count_tx = XAXIDMA_DFT_TX_THRESHOLD;
> 	lp->coalesce_usec_tx = XAXIDMA_DFT_TX_USEC;
> 
>-	/* Reset core now that clocks are enabled, prior to accessing MDIO */
>-	ret = __axienet_device_reset(lp);
>-	if (ret)
>-		goto cleanup_clk;
>-
> 	ret = axienet_mdio_setup(lp);
> 	if (ret)
> 		dev_warn(&pdev->dev,
>-- 
>2.40.1
>
>

