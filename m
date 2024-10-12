Return-Path: <netdev+bounces-134844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CD699B4EB
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 14:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A4428362A
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 12:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C8417838C;
	Sat, 12 Oct 2024 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/joYIrk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC92176AA5;
	Sat, 12 Oct 2024 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728737030; cv=none; b=E48W3r4E7IPzdeBtlbAVb1Sh9zcNDDfHJwbHHzyPH/odBA31BiEUUEnKGZ2egD11CBeOg89xUF0AzuWrXIbcOVgln8aDe2XHo5hC4CTbQcoBAcjnuYhUARtajK25SrmMPt0EgX1HCqGrKYHW2WVx6dPr2RQSCjm5ohiYTHFerEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728737030; c=relaxed/simple;
	bh=qzcTtAmaHrsaCgtz6LQLsEPr6tf59IuPVftTRthHr4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqpskAbqe9bBhcGDdppdoPsE5ux3VPug67p4Tc8TLr5AVM8DP5FmriyGCqmdu3fLFI0uHxLc67DSqVTrpxkP6wbQY9fhEFsixeUDUeSOU2e4C2QL/FUwPQ6FoAmnKTdaK/hNPNsS8CUbTPYW5gauLIwAzfnL/7jNGBzcBA4XA+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/joYIrk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8ACC4CEC6;
	Sat, 12 Oct 2024 12:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728737030;
	bh=qzcTtAmaHrsaCgtz6LQLsEPr6tf59IuPVftTRthHr4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M/joYIrkfa7OQh7/kKk924WkSSVzS07eeezovcTTnsJ5THjkQ8VDHX/IIgREA4xTr
	 AbLYJg8qcavrDzSZ6XxxpLKrSzPJRtx7gjPmCSkwx+5nRUdb5Tb4pZcCA98OPzomXJ
	 pvfdAu+79sJ+EoTB9Y+39us2jrjWc+AEshrCAjTmLiE4AidRTzXVKzdK5Zznq0xbF3
	 /pynXt3TsoonzcvhURTCcuEFfwPeS49BDnZQni5yczXVwxcGVAGGc/WkASY1PE3/LK
	 R0XOreGy3fTgqvcJg3Cw+hSRy5Q3s0cDqxHSC2/L3Hv1XSy9w+I4UBedIlN9LyNxDF
	 Zz4yRJYcZgkWw==
Date: Sat, 12 Oct 2024 13:43:45 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Breno Leitao <leitao@debian.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv6 net-next 5/7] net: ibm: emac: use devm for mutex_init
Message-ID: <20241012124345.GC77519@kernel.org>
References: <20241011195622.6349-1-rosenp@gmail.com>
 <20241011195622.6349-6-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011195622.6349-6-rosenp@gmail.com>

On Fri, Oct 11, 2024 at 12:56:20PM -0700, Rosen Penev wrote:
> It seems since inception that mutex_destroy was never called for these
> in _remove. Instead of handling this manually, just use devm for
> simplicity.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/ibm/emac/core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
> index f8478f0026af..b9ccaae61c48 100644
> --- a/drivers/net/ethernet/ibm/emac/core.c
> +++ b/drivers/net/ethernet/ibm/emac/core.c
> @@ -3021,8 +3021,14 @@ static int emac_probe(struct platform_device *ofdev)
>  	SET_NETDEV_DEV(ndev, &ofdev->dev);
>  
>  	/* Initialize some embedded data structures */
> -	mutex_init(&dev->mdio_lock);
> -	mutex_init(&dev->link_lock);
> +	err = devm_mutex_init(&ofdev->dev, &dev->mdio_lock);
> +	if (err)
> +		return err;

Hi Rosen,

It looks like this should be:

		goto err_gone;

> +
> +	err = devm_mutex_init(&ofdev->dev, &dev->link_lock);
> +	if (err)
> +		return err;

Ditto.

> +
>  	spin_lock_init(&dev->lock);
>  	INIT_WORK(&dev->reset_work, emac_reset_work);

-- 
pw-bot: cr

