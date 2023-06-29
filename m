Return-Path: <netdev+bounces-14663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1EA742E46
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 22:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37691C20A97
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 20:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DE1154A2;
	Thu, 29 Jun 2023 20:28:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA6AC8C9
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 20:28:50 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09659213D;
	Thu, 29 Jun 2023 13:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JJTXlY6wtDO/dgQsOAsZ3Cbbd06wnHj1OxnXQLvZ2zI=; b=haFASrG5nuBS3YS6DPaEq5i3eU
	iG8shjOJk5clS1phTvX2/t7l5yi8/7S7fEGgWWP4cXtyjngzHPC58j6Wme6xu5g8PybcnmI0MinKg
	WgLr1Q62+MO60OcPMn6wOWP37Yo6Lo5Q1HFuUHsERfvn68mc6VHjMW+yrccNUntQAKJw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qEyFu-000FjX-2B; Thu, 29 Jun 2023 22:28:42 +0200
Date: Thu, 29 Jun 2023 22:28:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
	alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
	bhupesh.sharma@linaro.org, vkoul@kernel.org,
	bartosz.golaszewski@linaro.org
Subject: Re: [PATCH 1/3] net: stmmac: dwmac-qcom-ethqos: Return
 device_get_phy_mode() errors properly
Message-ID: <5b46e92f-0f32-46f2-85ef-94f7c6a7ca9f@lunn.ch>
References: <20230629191725.1434142-1-ahalaney@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629191725.1434142-1-ahalaney@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 29, 2023 at 02:14:16PM -0500, Andrew Halaney wrote:
> Other than -ENODEV, other errors resulted in -EINVAL being returned
> instead of the actual error.
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index e62940414e54..3bf025e8e2bd 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -721,6 +721,9 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	ethqos->phy_mode = device_get_phy_mode(dev);
> +	if (ethqos->phy_mode < 0)
> +		return dev_err_probe(dev, ethqos->phy_mode,
> +				     "Failed to get phy mode\n");

If this every used on anything other than device tree?

of_get_phy_mode() has a better API, there is a clear separation of the
return value indicating success/fail, and the interface mode found in
DT. You can then change phy_mode in struct qcom_ethqos to be
phy_interface_t.

	Andrew

