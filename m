Return-Path: <netdev+bounces-129193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6499097E2A3
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 19:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC6A1F217D1
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 17:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613FA3716D;
	Sun, 22 Sep 2024 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tb4geJDS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386AB29CF4;
	Sun, 22 Sep 2024 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727024712; cv=none; b=BdqTrlRlbhkF3jflYMdphe2RskisUGMaeiEKKcgQ7FuxwXW452Z/E38+ICe2ceF6T7tZRqwgz6lUQIHvq+c/kcuc+4GfM538HaiOGa7lmOfTezrsvVCVB34IYCG7Z+0ZodARrJHPPRhtAo4yU45Cz/wk5K+Bg3SHv9KfQPKSujE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727024712; c=relaxed/simple;
	bh=xslP7AXvSkVuMhvWM8OqO8/hx8E19JC6RLFtS4kykIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbqXVGA9TCheo8WHYX+yBl+wNr8iinqqV3mbMS4uyACK7z6cQSx1KxzYLEFZBTRyDnNqfZQxgRTXHaGr4NaKLNGRNzCiy9DvsdPL1ODBZ+LHVuRhx9O3Zu4d1oAbKA5cCZUHRTB0701UDyVVfLd3B+x9imdBHFYdBZZleQPzhus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tb4geJDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A0DC4CEC3;
	Sun, 22 Sep 2024 17:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727024711;
	bh=xslP7AXvSkVuMhvWM8OqO8/hx8E19JC6RLFtS4kykIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tb4geJDSEjrBGmuC/mExVwIo6ha8m2jYkGkBj6kXi1blEi1GLSYSFSqGqpmc2AI+2
	 hE/VCggXEajkvH8VgpSKngkjiqvndvC3W0abooMx5qm4UQKTqHdlOEtyCHecucJiMv
	 ugt8vGVu17Y4/xUw+j8E59YCXF2ZvXkysByUFwbKmbTkxEdUKEeDoidIhqM+lrCRt3
	 wCi4IJOATxtu4RH1yUmnEKcVwNVUxs7PVHmtJJl6kriN8LdEDsmtyY/XgK/LykjZ9D
	 YDgwkmB8+/bqRfPsOb+lKZVhaJ7ljk4xspNvEDsFdNsLW28wEdFhw7OX2JLtKbg4Zo
	 PEeZzaC3VC6UQ==
Date: Sun, 22 Sep 2024 18:05:07 +0100
From: Simon Horman <horms@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Clayton Rayment <clayton.rayment@xilinx.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH] net: xilinx: axienet: Use common error handling code in
 axienet_mdio_write()
Message-ID: <20240922170507.GD3426578@kernel.org>
References: <330c2b9e-9a15-4442-8288-07f66760f856@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <330c2b9e-9a15-4442-8288-07f66760f856@web.de>

On Fri, Sep 20, 2024 at 01:01:45PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 20 Sep 2024 12:43:39 +0200
> Subject: [PATCH] net: xilinx: axienet: Use common error handling code in axienet_mdio_write()
> 
> Add a label so that a bit of exception handling can be better reused
> at the end of this function implementation.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>


Hi Markus,

This change seems reasonable to me.  However, I am assuming that as a
non-bug-fix, this is targeted at net-next.  And net-next is currently
closed for the v6.12 merge window.  Please consider reposting this patch
once net-next reopens.  That will occur after v6.12-rc1 has been released.
Which I expect to be about a week from now.

Also, for networking patches please tag non-bug fixes for
net-next (and bug fixes for net, being sure to include a Fixes tag).

	Subject: [PATCH net-next] ...

Please see https://docs.kernel.org/process/maintainer-netdev.html

...

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c

...

> @@ -153,12 +151,9 @@ static int axienet_mdio_write(struct mii_bus *bus, int phy_id, int reg,
>  		     XAE_MDIO_MCR_OP_WRITE_MASK));
> 
>  	ret = axienet_mdio_wait_until_ready(lp);
> -	if (ret < 0) {
> -		axienet_mdio_mdc_disable(lp);
> -		return ret;
> -	}

Please add a blank line here.

> +disable_mdc:
>  	axienet_mdio_mdc_disable(lp);
> -	return 0;
> +	return ret;
>  }
> 
>  /**

-- 
pw-bot: defer

