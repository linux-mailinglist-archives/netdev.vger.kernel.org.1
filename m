Return-Path: <netdev+bounces-239780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 950A9C6C650
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0051D4EC070
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2F52857EF;
	Wed, 19 Nov 2025 02:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnvYUKIw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DEB28504D;
	Wed, 19 Nov 2025 02:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763519487; cv=none; b=UzDOGPMqp181FASIfFmtmWQk7qKtQb5LHG07h4xe+6XVIaImFfwT/peKqsdAsE/8hdW/oe5/z7Myf3Kz8s03DjlUCFv4kWOstMsO/AfvXnaofuf2ejibFXoERkgF/pUdkB5FPiRnUE+TNgV3+0XiGMvQqEMjYqNVM5Uvunqiyvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763519487; c=relaxed/simple;
	bh=S9W8gkoeYjNMe+6rgI6EFcOH/IKti0OINsGGXg2iwls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WY7W+7TuSuYzaGWmOsagfeeBmMwRE40X1zQTmjNNhZIWoSdfye/xR5dHgtMyI0K2i5rPdumVGQXAvlii15lB90GPYGvDxpCKmuNnxNjYx8EHwi6Gah25VOTrJKE7S2zmOU3VIlG2OLojWt4Pne46q7Ao/+pCNS9QmbdlSsvsVH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnvYUKIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09EEC2BCB4;
	Wed, 19 Nov 2025 02:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763519485;
	bh=S9W8gkoeYjNMe+6rgI6EFcOH/IKti0OINsGGXg2iwls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XnvYUKIwHKhKz/6+F3HrfZIvOcLLX+6Ub40noQNgkL1e9BvA0MKobnvEWZ79o728K
	 nkPYZuyUrsFwVQvchy2qtySYBLqj5/JeA64rLX5w9ACg54sH6NrWI9CxHmkTnG6+Xr
	 nYUhCRXb64cZgmiCZI6bme/mgqhjgv3lrMlyCa7CGZfy787JBW5e5R59S9hkO45QR5
	 W60HePA5U8fAcSCA99udl5vSiIW+pQkF8wbgDanfLqDaSVqi80Myw/cP1s88IlWoip
	 /SOTObeF7zX5rQN6xsdvCR1qA1GLP6J2DVwe08AOOAHwIV9cK0W0Argk66ccsdgNJ2
	 WNbZYkGx9FyEw==
Date: Tue, 18 Nov 2025 18:31:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
Cc: Byungho An <bh74.an@samsung.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Siva Reddy
 <siva.kallam@samsung.com>, Girish K S <ks.giri@samsung.com>, Vipul Pandya
 <vipul.pandya@samsung.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net] net: samsung: sxgbe: handle clk_prepare_enable()
 failures in sxgbe_open()
Message-ID: <20251118183122.6e74a6fa@kernel.org>
In-Reply-To: <20251114153616.3278623-1-Pavel.Zhigulin@kaspersky.com>
References: <20251114153616.3278623-1-Pavel.Zhigulin@kaspersky.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Nov 2025 18:36:14 +0300 Pavel Zhigulin wrote:
> sxgbe_open() didn't check result of clk_prepare_enable() call.
> 
> Add missing check
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 1edb9ca69e8a ("net: sxgbe: add basic framework for Samsung 10Gb ethernet driver")
> Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
> ---
>  drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
> index 75bad561b352..6b8e54391d7f 100644
> --- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
> +++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
> @@ -1063,7 +1063,12 @@ static int sxgbe_open(struct net_device *dev)
>  	struct sxgbe_priv_data *priv = netdev_priv(dev);
>  	int ret, queue_num;
> 
> -	clk_prepare_enable(priv->sxgbe_clk);
> +	ret = clk_prepare_enable(priv->sxgbe_clk);
> +	if (ret < 0) {
> +		netdev_err(dev, "%s: Cannot enable clock (error: %d)\n",
> +			   __func__, ret);
> +		goto clk_error;

Just:

		return ret;

no need for a goto here.

> +	}
> 
>  	sxgbe_check_ether_addr(priv);
> 
> @@ -1195,6 +1200,7 @@ static int sxgbe_open(struct net_device *dev)
>  phy_error:
>  	clk_disable_unprepare(priv->sxgbe_clk);
> 
> +clk_error:
>  	return ret;
>  }
-- 
pw-bot: cr

