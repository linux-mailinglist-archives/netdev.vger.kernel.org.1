Return-Path: <netdev+bounces-86242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F299289E2C6
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 20:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D39FB22368
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 18:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C12E156C5F;
	Tue,  9 Apr 2024 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLi1EjK6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069F115699E
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712688914; cv=none; b=Mqxg3SuVo1n1pAvlPkUhfKZdDx7MTtzLglyNLvEiNJJhdXMF9UMTsiNS3I2GDKIjV6NJwgmaKsx9JqKMv2MV3DSi3S4GEhYcJAnZ+C/M+Uhtm1g6BpGwgtD9CnGxqSO8uhYAUEHZtOLsHAkiKzgn9scACt336T0jVLf/vuCPYp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712688914; c=relaxed/simple;
	bh=CfUBlepbfDbVm3pnj0iWJL8rZ5aLiXADXf0AEKpxJq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHYjTilfWschChDYremKyu8gEEXvR7Z735MkolNhB5tapvytqBRJ45BcryfY9MYlPA6lSUx1EWAMb6xpu0T0Ph4Fvsv/NULfzmCd482KLqAMRadQEicgNXfbNBba0oGc+Wr7ufEMxOdSk0mohCRlX5+EhwmvfY+a1o8nGE+eQeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLi1EjK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F5BC433F1;
	Tue,  9 Apr 2024 18:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712688913;
	bh=CfUBlepbfDbVm3pnj0iWJL8rZ5aLiXADXf0AEKpxJq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kLi1EjK66Gsn8PISs8GDnK3B0HAMBrQWj/B4L87Y7KF1J0o5AX97qbZfZMMivf8et
	 FnCSwoV0cRpc0sXhga3iayvY7nsodIp0zSUAdKQbUgtoOoCVbNL/VQi2u71CqFf2TA
	 ecO3iTqShMlSxgiQ5KqxchVSQFGc4bARW43WrnG6XZaga0Vb94xhk0tKm6SET7iKUX
	 uMp8kcP4z/rXZa2OLKcHC2g1PjmFLwIME6PFfNCY7lm5PIj3g1n9LHPlOSUv0blCnw
	 3/RCE9sb9444kJ9DJPerlQdtHMKG9PfyZNpcXP1C5Ej2HJ1JyA9C0MT9FE9cSf+rG1
	 6jCx59a1twN1A==
Date: Tue, 9 Apr 2024 19:55:08 +0100
From: Simon Horman <horms@kernel.org>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	fancer.lancer@gmail.com, Jose.Abreu@synopsys.com,
	chenhuacai@kernel.org, linux@armlinux.org.uk,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v10 2/6] net: stmmac: Add multi-channel support
Message-ID: <20240409185508.GM26556@kernel.org>
References: <cover.1712668711.git.siyanteng@loongson.cn>
 <2c3fcab1f5bfa0afc7dc523cf5d8f2f7e3520e79.1712668711.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c3fcab1f5bfa0afc7dc523cf5d8f2f7e3520e79.1712668711.git.siyanteng@loongson.cn>

On Tue, Apr 09, 2024 at 10:00:02PM +0800, Yanteng Si wrote:
> DW GMAC v3.x multi-channels feature is implemented as multiple
> sets of the same CSRs. Here is only preliminary support, it will
> be useful for the driver further evolution and for the users
> having multi-channel DWGMAC v3.x devices.
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>

...

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index e1537a57815f..e94faa72f30e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -420,6 +420,12 @@ stmmac_ethtool_set_link_ksettings(struct net_device *dev,
>  		return 0;
>  	}
>  
> +	if (priv->plat->flags & STMMAC_FLAG_DISABLE_FORCE_1000) {

Hi Yanteng Si, Yanteng Si, all,

STMMAC_FLAG_DISABLE_FORCE_1000 is used here but it is not defined
until PATCH 6/6. This breaks bisection.

I expect this can be resolved by defining STMMAC_FLAG_DISABLE_FORCE_1000
as part of this patch.

> +		if (cmd->base.speed == SPEED_1000 &&
> +		    cmd->base.autoneg != AUTONEG_ENABLE)
> +			return -EOPNOTSUPP;
> +	}
> +
>  	return phylink_ethtool_ksettings_set(priv->phylink, cmd);
>  }
>  

-- 
pw-bot: changes-requested

