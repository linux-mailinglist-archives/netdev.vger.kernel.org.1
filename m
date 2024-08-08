Return-Path: <netdev+bounces-116665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF9794B557
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 05:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9358D1C21328
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 03:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9992C1AC;
	Thu,  8 Aug 2024 03:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pmlq9oZV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D1280BFC;
	Thu,  8 Aug 2024 03:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723086561; cv=none; b=RsH69j9E2eKkHHujR213kmiB4/DwhcWPo1CHCvy1vHF7Zbq3DM3rocYnHTBBroqFu4I2DbaHNm2YYQt+6qFHPY0uVvwo9pWPN+6DVxtbUXX6SsSCfh84LecdQnl0ubQdK8pOLyIYcU3g5L3zIV/aaU1mPPH9aFf6+uP5tQM2hAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723086561; c=relaxed/simple;
	bh=3E7OR/AnaAUIdXtpfOO0q144SYQ48NLPP102QIH9TFU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o8XGLcLpJLUPaP85sPjibuuGJsh+wnZss6giDyMI4LOuaTu0SYEG4elCPiLoj5mHzRejbloskoxN9wAafC8KHgdJQj4MreH0WMlt+iS1sV6YtZTm0sUF/MLnY378hpDJXY8WBqZp510uhN3U5Nt7uMoYyUvA4EfVaYXhhII2fDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pmlq9oZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B774C32781;
	Thu,  8 Aug 2024 03:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723086560;
	bh=3E7OR/AnaAUIdXtpfOO0q144SYQ48NLPP102QIH9TFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pmlq9oZV+hoTXFKG4kW3uLpp2UhL9WOxMaS638/iV/nxT8DjQ+jibHjjIAwzEDLDl
	 CZCk5yEdVIYQnJSSY7BcV2qQHJEqUWnKCg+2MNj7qIz9VbzTtPhSIvo2HH6v7yod2U
	 HdJEY3c5Mumko75b5KwnA0Z2Rqz+azhsFgzqsZXyWWlt/aLGPrK57oAlrYRavI1V3S
	 lIIuwNs+XtzlboDbDR+U94N7B9wbJgjI05vsACrZpUNkpY77sRpLc/kjt1pHXQOhk6
	 I9icepQd3bihG61iggoFiKiJ7ctvJQme1IXHRqkYi86XmSiRQFHbiEAIhO/5ao995P
	 UPGpsiL6/+WDw==
Date: Wed, 7 Aug 2024 20:09:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/5] net: dsa: vsc73xx: check busy flag in MDIO
 operations
Message-ID: <20240807200919.5444d131@kernel.org>
In-Reply-To: <20240805211031.1689134-4-paweldembicki@gmail.com>
References: <20240805211031.1689134-1-paweldembicki@gmail.com>
	<20240805211031.1689134-4-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Aug 2024 23:10:29 +0200 Pawel Dembicki wrote:
> -	msleep(2);
> +
> +	ret = vsc73xx_mdio_busy_check(vsc);
> +	if (ret)
> +		return ret;
> +
>  	ret = vsc73xx_read(vsc, VSC73XX_BLOCK_MII, 0, 2, &val);
> +
>  	if (ret)

nit: why the empty line between call and error check?

>  		return ret;
>  	if (val & BIT(16)) {
> @@ -561,7 +593,11 @@ static int vsc73xx_phy_write(struct dsa_switch *ds, int phy, int regnum,
>  {
>  	struct vsc73xx *vsc = ds->priv;
>  	u32 cmd;
> -	int ret;
> +	int ret = 0;
> +
> +	ret = vsc73xx_mdio_busy_check(vsc);

nit: why init ret to 0 ?

