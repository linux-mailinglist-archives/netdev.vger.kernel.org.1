Return-Path: <netdev+bounces-226737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05508BA4935
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 18:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8F527AFB89
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 16:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A329E239E9B;
	Fri, 26 Sep 2025 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgYG+uue"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B25521D3CA;
	Fri, 26 Sep 2025 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903217; cv=none; b=kO1g/XGFJMIl8W7oxUXSj1JGqCxQl96p6ikf99kjkMvq40Cf/KN7xfCMnNggCXnqcSyRdzJ+gPZjf2VQ2UldCK9fO/oCcUqMcyaA0AGc/kzLzOIFRGnSqNvIcbEqBgxY1Jc7Atvcl8W8XkU1iAMfFmg5socZSoSdlC8h2Rhcw7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903217; c=relaxed/simple;
	bh=wh9M9QTkVwk+Ja56zSTTBOIJV0Iqe7hniIh4R1RLg1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1DBDEYIQi1FMz2WP2zSLQW4WTMVqgaW0VK40Rfxgh9YpvREilQ54NksYW4HdvCokqbS0tEJ+NtwJwM+CU3Sv8euz6BxoQdXEOknmr3EG0ZUUrsMqX2TZZUW4G52c41UTQq/+OnKZLW/ywa/3U8GZZYk+xHqFg5HRvh66U2EXmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgYG+uue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0064AC4CEF4;
	Fri, 26 Sep 2025 16:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758903217;
	bh=wh9M9QTkVwk+Ja56zSTTBOIJV0Iqe7hniIh4R1RLg1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JgYG+uue4dcR73rbUpd7FW2IP/THmhCbkZJN5ATwVASV/92yg7I4LHPQQfprckKJ3
	 rLYlaJ4dIdmQSKWiO/U79+6stXY2JruZf+GW92X2DmcXKniCAm8/zbNXj4dGWT8M5s
	 FqazBYazLSvH9QiXrQ4Nqlg9Jharodw9aTmahfAwjX4JcGayP+IHycGE2sBSoV69UH
	 XSbQ7j+TK6YZQ56qUu4timJFyebojxJJfqZHQOe5wKAI1r/ieKfgjNns6d97D1JNzX
	 cHQZ1snplHDs4fbPPObXPSAe1pXoAUmgPDhAnrV+QJhV+q1di/mC8zYdYV7VHwa00l
	 r2YmUditon04g==
Date: Fri, 26 Sep 2025 17:13:32 +0100
From: Simon Horman <horms@kernel.org>
To: Nishanth Menon <nm@ti.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, "Vadapalli, Siddharth" <s-vadapalli@ti.com>
Subject: Re: [PATCH] net: netcp: Fix crash in error path when DMA channel
 open fails
Message-ID: <aNa7rEQLJreJF58p@horms.kernel.org>
References: <20250926150853.2907028-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926150853.2907028-1-nm@ti.com>

On Fri, Sep 26, 2025 at 10:08:53AM -0500, Nishanth Menon wrote:
> When knav_dma_open_channel() fails in netcp_setup_navigator_resources(),
> the rx_channel field is set to an ERR_PTR value. Later, when
> netcp_free_navigator_resources() is called in the error path, it attempts
> to close this invalid channel pointer, causing a crash.
> 
> Add a check for ERR values to handle the failure scenario.
> 
> Fixes: 84640e27f230 ("net: netcp: Add Keystone NetCP core driver")
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> Seen on kci log for k2hk: https://dashboard.kernelci.org/log-viewer?itemId=ti%3A2eb55ed935eb42c292e02f59&org=ti&type=test&url=http%3A%2F%2Ffiles.kernelci.org%2F%2Fti%2Fmainline%2Fmaster%2Fv6.17-rc7-59-gbf40f4b87761%2Farm%2Fmulti_v7_defconfig%2BCONFIG_EFI%3Dy%2BCONFIG_ARM_LPAE%3Dy%2Bdebug%2Bkselftest%2Btinyconfig%2Fgcc-12%2Fbaseline-nfs-boot.nfs-k2hk-evm.txt.gz
> 
>  drivers/net/ethernet/ti/netcp_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
> index 857820657bac..4ff17fd6caae 100644
> --- a/drivers/net/ethernet/ti/netcp_core.c
> +++ b/drivers/net/ethernet/ti/netcp_core.c
> @@ -1549,7 +1549,7 @@ static void netcp_free_navigator_resources(struct netcp_intf *netcp)
>  {
>  	int i;
>  
> -	if (netcp->rx_channel) {
> +	if (!IS_ERR(netcp->rx_channel)) {
>  		knav_dma_close_channel(netcp->rx_channel);
>  		netcp->rx_channel = NULL;
>  	}

Hi Nishanth,

Thanks for your patch.

I expect that netcp_txpipe_close() has a similar problem too.

But I also think that using IS_ERR is not correct, because it seems to me
that there are also cases where rx_channel can be NULL.

I see that on error knav_dma_open_channel() always returns ERR_PTR(-EINVAL)
(open coded as (void *)-EINVAL) on error. So I think a better approach
would be to change knav_dma_open_channel() to return NULL, and update callers
accordingly.

