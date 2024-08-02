Return-Path: <netdev+bounces-115375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F44E9460D0
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 17:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBC7281B9F
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 15:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0550E136357;
	Fri,  2 Aug 2024 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQQS81qF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D221E136343;
	Fri,  2 Aug 2024 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722613722; cv=none; b=PPcBTBftbWudU3m/mrbDZnpsiBGOwDBEWiUQTHqL1vNlhw62bDA50Mkx3Yr4QRYMezl0qo4OpjQrH1KrL/1Gi4VgLym4YKb6EURqiSxGJX/fEB6L61WKuYR182dGl8I2xleSOl2odacFo4eDEABU9qKgVI0ZT71NAfhSO7R8IBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722613722; c=relaxed/simple;
	bh=Tyha5C4gVzz41FvnK6/fBCZ+kEp1ykWcmMMXkD85bjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukLurwQhnJ24vZjJ4kiptq6L7gbo6cm147/QcpC19H5CcPIzz3T/3QjMPlic5XInXPVp7BENUXyxoT4sfJvsTqo9v/Hv0cZ4OaFu3UneOwsRp1EVaZQNzLbazitWjn6mJdsnMdfS0bT6RkCY/L3w+RX3ok2F//RoTL/md5PS1TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQQS81qF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1343C32782;
	Fri,  2 Aug 2024 15:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722613722;
	bh=Tyha5C4gVzz41FvnK6/fBCZ+kEp1ykWcmMMXkD85bjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VQQS81qFSU5xugoq7RSuDa15HZdoOBrzwCwvMXmeTjAJED3ldTdM8uqdORAGQlmxb
	 95nRVRJOVnFkP+U9+0mWNyIT2aQhP7JwGESy7mnN8WLh6UVupeQVPCzwInmEG+QCAQ
	 DLNvLsv6KCQcZiKIhTQ2E7IihwGLDy2ABJTL2bwLBLXnuIzfypGz3evA4pNL1e+/6X
	 A2dTrqNb20bAJPW6RRtXWz6V1bcSOgAjOJTModkDIuR+aYv4T61j5zj+69FxeiIGz1
	 y1ieyC1o1ozhxwH5TqZYOto6z36bcVBJ/jl0P1UfH6VAxX3DgoK7l2YBPhrfdYKyPB
	 +CE+mJyTcsDTw==
Date: Fri, 2 Aug 2024 16:48:38 +0100
From: Simon Horman <horms@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, u.kleine-koenig@pengutronix.de,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ftgmac100: Get link speed and duplex for NC-SI
Message-ID: <20240802154838.GG2504122@kernel.org>
References: <20240802083332.2471281-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802083332.2471281-1-jacky_chou@aspeedtech.com>

On Fri, Aug 02, 2024 at 04:33:32PM +0800, Jacky Chou wrote:
> The ethtool of this driver uses the phy API of ethtool
> to get the link information from PHY driver.
> Because the NC-SI is forced on 100Mbps and full duplex,
> the driver connects a fixed-link phy driver for NC-SI.
> The ethtool will get the link information from the
> fixed-link phy driver.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  drivers/net/ethernet/faraday/ftgmac100.c | 37 ++++++++++++++----------
>  1 file changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index fddfd1dd5070..0c820997ef88 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> @@ -26,6 +26,7 @@
>  #include <linux/of_net.h>
>  #include <net/ip.h>
>  #include <net/ncsi.h>
> +#include <linux/phy_fixed.h>
>  
>  #include "ftgmac100.h"
>  
> @@ -50,6 +51,15 @@
>  #define FTGMAC_100MHZ		100000000
>  #define FTGMAC_25MHZ		25000000
>  
> +/* For NC-SI to register a fixed-link phy device */
> +struct fixed_phy_status ncsi_phy_status = {
> +	.link = 1,
> +	.speed = SPEED_100,
> +	.duplex = DUPLEX_FULL,
> +	.pause = 0,
> +	.asym_pause = 0
> +};

nit: This structure is only used in this file, so it should be static

> +
>  struct ftgmac100 {
>  	/* Registers */
>  	struct resource *res;

-- 
pw-bot: cr

