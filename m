Return-Path: <netdev+bounces-160084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE43DA180FF
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 16:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027B0163CD7
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 15:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34DF1F427D;
	Tue, 21 Jan 2025 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFxw5/xi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A831F3FF5;
	Tue, 21 Jan 2025 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737472782; cv=none; b=lhRdeXzigaaq4bQuBjs4qaCxgDq0tJtNxeDxPtZgW96RJ7B6bBPqsPLiLATyNb/3WBOTGq6taS++TxmuYiwiiynZ5n0HNvlyzWPrOT/UWlYKRz48ipkdenbk4BGXsNGDHiEXaqcgQzLbRpjC0mCj/4pZXxCHaxNQcisFhMTzt1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737472782; c=relaxed/simple;
	bh=XQqPkOmvTtbIgS6tviompcyqsrq7q7NclvQbzZBT9HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euhFii5dC4iR1x4Q3VI6Hu3azpDqrMSfK7MxSgSkJ370o6YUf3nX6U2VYffbiRt8jAqYMfsqaJkT+E/kJaJljI/UagQyqSgZ0gcuHsVopmujOIJJGXGunM5FcFr9pude+14kCsD1Rdv8v8CACBnn2GVQGH5nme6AZ8f4x9hZuh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFxw5/xi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA63C4CEDF;
	Tue, 21 Jan 2025 15:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737472781;
	bh=XQqPkOmvTtbIgS6tviompcyqsrq7q7NclvQbzZBT9HU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SFxw5/xima06xxBKWjLdTsB64SdjXSGTbez1Lz40pHcHIzsfqNFIuZ/bt3unTFi+Y
	 pEE2z1WCF4KcaFB4Zz2ejxAD++bWOu7c2IZ0FDZTuctDDkR1bq8+V/WQ6s/x/l9h8n
	 hxGlWhQYrl3cxhah2BNUfwG7jo3r9+mcS6D7/j+Rlu6PhOGnFp+++mSTZZmEs7xmXc
	 4InuZ5uryFMN7R8YSyktzPpQv4i5/2RO8iXc6bzMolkxQrxl6CDg3JNcZL55+8tkcr
	 rzAl1LqudKBHrPluuuJ7Affa4mDdFvJL6wc1coBJuH/mhaxG5JT2xhzTgLR/x7R5QW
	 HhC01qK30aAzA==
Date: Tue, 21 Jan 2025 15:19:36 +0000
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?Q3PDs2vDoXMs?= Bence <csokas.bence@prolan.hu>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Laurent Badel <laurentbadel@eaton.com>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: fec: Refactor MAC reset to function
Message-ID: <20250121151936.GF324367@kernel.org>
References: <20250121103857.12007-3-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250121103857.12007-3-csokas.bence@prolan.hu>

On Tue, Jan 21, 2025 at 11:38:58AM +0100, Csókás, Bence wrote:
> The core is reset both in `fec_restart()`
> (called on link-up) and `fec_stop()`
> (going to sleep, driver remove etc.).
> These two functions had their separate
> implementations, which was at first only
> a register write and a `udelay()` (and
> the accompanying block comment).
> However, since then we got soft-reset
> (MAC disable) and Wake-on-LAN support,
> which meant that these implementations
> diverged, often causing bugs. For instance,
> as of now, `fec_stop()` does not check for
> `FEC_QUIRK_NO_HARD_RESET`. To eliminate
> this bug-source, refactor implementation
> to a common function.
> 
> Fixes: c730ab423bfa ("net: fec: Fix temporary RMII clock reset on link up")
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
> ---
> 
> Notes:
>     Recommended options for this patch:
>     `--color-moved --color-moved-ws=allow-indentation-change`
> 
>  drivers/net/ethernet/freescale/fec_main.c | 50 +++++++++++------------
>  1 file changed, 23 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 68725506a095..850ef3de74ec 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1064,6 +1064,27 @@ static void fec_enet_enable_ring(struct net_device *ndev)
>  	}
>  }
>  
> +/* Whack a reset.  We should wait for this.
> + * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
> + * instead of reset MAC itself.
> + */
> +static void fec_ctrl_reset(struct fec_enet_private *fep, bool wol)
> +{
> +	if (!wol || !(fep->wol_flag & FEC_WOL_FLAG_SLEEP_ON)) {
> +		if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES ||
> +		    ((fep->quirks & FEC_QUIRK_NO_HARD_RESET) && fep->link)) {
> +			writel(0, fep->hwp + FEC_ECNTRL);
> +		} else {
> +			writel(FEC_ECR_RESET, fep->hwp + FEC_ECNTRL);
> +			udelay(10);
> +		}
> +	} else {
> +		val = readl(fep->hwp + FEC_ECNTRL);
> +		val |= (FEC_ECR_MAGICEN | FEC_ECR_SLEEP);
> +		writel(val, fep->hwp + FEC_ECNTRL);

Hi Bence,

It seems that this does not compile because val is not declared in this scope.

> +	}
> +}
> +
>  /*
>   * This function is called to start or restart the FEC during a link
>   * change, transmit timeout, or to reconfigure the FEC.  The network

Please observe the rule regarding not posting updated patches within 24h
when preparing v2.

-- 
pw-bot: changes-requested

