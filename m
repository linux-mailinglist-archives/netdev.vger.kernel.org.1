Return-Path: <netdev+bounces-93914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFC78BD934
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 03:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E07283821
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 01:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B063139F;
	Tue,  7 May 2024 01:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7WD8zIJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7706B4A0A
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 01:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715047119; cv=none; b=FpiOikJ0vCeRPRkcJE9SvshG9NiU2yAQf4sl/ZAhaAd91rjysctEW/roLHiAQnlxpa5PVU5FyURa0cQrueJ96tCNkHPKLNmVp1iD4jgBpUP36297TNAitHY9TBiZJs6C0AFoMzSwwQ1CQMjI5sgAgoeVvlaZkFBFcaCBay6oeas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715047119; c=relaxed/simple;
	bh=Elngfwk+fsCDMlbluSYtBtSitWihDgt51DhjVItnnjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUMj86EIDlshVeeFHPRXD6OXGyI+AjZjBQ6CrJLoGY7CtFOI7rKuYOFuxfX+axOmUj5BvBQUxZ5N7FfMlMtbxxFk/szPVJ9baqe54dm/+H8wEUTZGtMWb+l/9MZ8lb5T7RFGZ8jDO9ASkt5JcplS0PpWhoSLlgGwU8JIgOeSNg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7WD8zIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCFCC116B1;
	Tue,  7 May 2024 01:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715047119;
	bh=Elngfwk+fsCDMlbluSYtBtSitWihDgt51DhjVItnnjI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n7WD8zIJw4Z4m/wN1g0a7p8utSF+CUKYx/K0Qy7HOP1MSTtb93ubtgQ9uSwzynRdS
	 dGJyP0m51373uiROVRqNQiWn0MSji7vKYzwBFQSArbRePveG7BZOF9Xcd/DbSX1e+q
	 MZTUrUgcJnoqcdlu9YLM7i/2r7uDP8X6rzFA7IhY249u0zmhzh/nhQE7LGH6KenHEO
	 bz7mgGCbFXoWben+Ggd0JUz8vWjcS8fEHCezA6Fm2nHL3pIKsuTLIndDygDrMVgcrC
	 0LPon2TNdtRnIWEEqG4NZPrbUZ55D/wQR1DyUtlFvjF6zHSNtzb0rhd1AZNcuHlWCY
	 CHkC7rMoRZqBg==
Date: Mon, 6 May 2024 18:58:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
 horms@kernel.org
Subject: Re: [PATCH net-next v4 4/6] net: tn40xx: add basic Rx handling
Message-ID: <20240506185837.0f1db786@kernel.org>
In-Reply-To: <20240501230552.53185-5-fujita.tomonori@gmail.com>
References: <20240501230552.53185-1-fujita.tomonori@gmail.com>
	<20240501230552.53185-5-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 May 2024 08:05:50 +0900 FUJITA Tomonori wrote:
> @@ -745,6 +1248,21 @@ static irqreturn_t tn40_isr_napi(int irq, void *dev)
>  	return IRQ_HANDLED;
>  }
>  
> +static int tn40_poll(struct napi_struct *napi, int budget)
> +{
> +	struct tn40_priv *priv = container_of(napi, struct tn40_priv, napi);
> +	int work_done;
> +
> +	tn40_tx_cleanup(priv);
> +
> +	work_done = tn40_rx_receive(priv, &priv->rxd_fifo0, budget);
> +	if (work_done < budget) {
> +		napi_complete(napi);

napi_complete_done() works better with busy polling and such 

> +		tn40_enable_interrupts(priv);
> +	}
> +	return work_done;
> +}
> +

> +	netif_napi_del(&priv->napi);
> +	napi_disable(&priv->napi);

These two lines are likely in the wrong order

