Return-Path: <netdev+bounces-132302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92946991300
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 01:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227F91F23AD8
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8B61547E8;
	Fri,  4 Oct 2024 23:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmU79ac2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38416153838
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 23:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084558; cv=none; b=HGCaEY3UrAmk0eyV9b0PbN9UKelzvG6h7jNAhcf4F/IArJm5EYrlK9SavIahQcXdL1IdV53IDpFgcjSW2b2wecfycdKN9V/7ok6ZERPvehE0O+69g8gRBgjpOadcHcDyAhIg41Non1T0mxGS4vDUyssQ/nKX8QQhcF1c2t3uxf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084558; c=relaxed/simple;
	bh=OCh8q2auD+yO6nkDFuBd+m4P4hzIevuKQZOpnT0EOvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMuD2v4yqVKcQhAeEn9AmWDST2TejT9QgRTkeNzkBVYMvy/2QljhLBsBYp78qjXSklSESAzDnpwXdCCxkKnQS662qdbM+mPon3tHZjLt1xxSeGiqyOof6hvHbBOOCfir0njRWrlcHaczw51Pz9dcoEf5QTOH6ukVxIQIPnFU6+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmU79ac2; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53988c54ec8so3162430e87.0
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 16:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728084554; x=1728689354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ex2CqobCrHYMdEDOFvV3TgWiBh8tlgxqvWb2s/WawSY=;
        b=GmU79ac2tR8nC2oXfs+F2Q3L3qc5bi0ClXI4elgJcdF+avh8WaclnYFRre/jrGvjAR
         ppQ2UhaXoAoAZYj55I5ai1MMh5HwI6/uaehQjAxJM1ZZlTW8l0jJSQPM/25nUb1rdrKQ
         M1+ZZ9775k59ApId3qJPtnhrk/qxVK/wbOp7q3sPYNqKqlhcy3+OV6WynCwOakF20PU1
         Xb43r6JDGM8Af4NPUUiYSwgQzZj6+Hc1/lXE0+BOtC583THfKjlHQskUDJklcNzpZuPj
         STV9PH17ypSFxhe9bvx+cHqBj9MG0JV3O9YNeMTptoX3XvBHIVgb16683QiWEmxzdfDt
         G31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728084554; x=1728689354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ex2CqobCrHYMdEDOFvV3TgWiBh8tlgxqvWb2s/WawSY=;
        b=cUv6nNDRSeVHlFrgPKXx01wQaB/daxkvBRRUL9nl+6hUgHF9dP6vNLFjl+tOJqN4GD
         5NahPZCejq3L9jY2awTSOIfKVxUUmVzFhBYQFwX8/0pOPpkkSFcuCFvQKF01Q+fsj26I
         KDFcYZNpnWMp+TtvhyVAA2a87WVMhKokxosQOM2Xe7e1bKT3UCmY5zCRwOe88WkP2y3P
         8zXSJa8evQaWVn4OvezYZ9/byuVf9wrpy3XRemo9nCnSGWOgIg3Oz5P1b2OvRaji1s6/
         +scA6OyqvIvbUkVAsK7YRc68GSkDDHa8t1K/UxcEYTY18kKjorw8QBln8D3QrcKdAlAG
         jy3g==
X-Forwarded-Encrypted: i=1; AJvYcCW0zAEDbX9ZUhqa1wUu4GxyE0tI8f/cWxPHeO1gpAOPf+68OPheQdAZ1t6s1KO/YHPJ/KVylTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7x4coK+QKzGOwr2TWJHUwJlrUplysNsh2s2fkmnv9I0CO/PMU
	+TxsvyAEZ430lOkneKAIuNe3n3p8omFAcaTtixWcaENtZBbkApNs
X-Google-Smtp-Source: AGHT+IH+tDh+zT+JlQyYhGaogqDETgzJYe2wwGAq406JNg1paWVoGvp/OoTKcL1enGDkx3qwp3/0Xg==
X-Received: by 2002:a05:6512:3d0b:b0:536:a533:c03a with SMTP id 2adb3069b0e04-539ab87801bmr2666309e87.17.1728084553875;
        Fri, 04 Oct 2024 16:29:13 -0700 (PDT)
Received: from mobilestation ([95.79.225.241])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539afec828csm84367e87.77.2024.10.04.16.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 16:29:13 -0700 (PDT)
Date: Sat, 5 Oct 2024 02:29:10 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Jose Abreu <joabreu@synopsys.com>, 
	Jose Abreu <Jose.Abreu@synopsys.com>, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next 00/10] net: pcs: xpcs: cleanups batch 1
Message-ID: <dxkpa2abcz4nxmmrhrg5stwgenwdsyeah2box33fob2ssoot22@52smn4gv2qrb>
References: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>

On Tue, Oct 01, 2024 at 05:02:48PM GMT, Russell King (Oracle) wrote:
> Hi,
> 
> First, sorry for the bland series subject - this is the first in a
> number of cleanup series to the XPCS driver. This series has some
> functional changes beyond merely cleanups, notably the first patch.
> 
> This series starts off with a patch that moves the PCS reset from
> the xpcs_create*() family of calls to when phylink first configures
> the PHY. The motivation for this change is to get rid of the
> interface argument to the xpcs_create*() functions, which I see as
> unnecessary complexity. This patch should be tested on Wangxun
> and STMMAC drivers.
> 
> Patch 2 removes the now unnecessary interface argument from the
> internal xpcs_create() and xpcs_init_iface() functions. With this,
> xpcs_init_iface() becomes a misnamed function, but patch 3 removes
> this function, moving its now meager contents to xpcs_create().
> 
> Patch 4 adds xpcs_destroy_pcs() and xpcs_create_pcs_mdiodev()
> functions which return and take a phylink_pcs, allowing SJA1105
> and Wangxun drivers to be converted to using the phylink_pcs
> structure internally.
> 
> Patches 5 through 8 convert both these drivers to that end.
> 
> Patch 9 drops the interface argument from the remaining xpcs_create*()
> functions, addressing the only remaining caller of these functions,
> that being the STMMAC driver.

Better later than never. Just reached my hardware treasury and managed to
test the series out on the next setup:

DW XGMAC <-(XGMII)-> DW XPCS <-(10Gbase-R)-> Marvell 88x2222
<-(10gbase-R)->
SFP+ fiber SFP+
<-(10gbase-r)->
Marvell 88x2222 <-(10gbase-r)-> DW XPCS <-(XGMII)-> DW XGMAC

DW XGMAC was working under the STMMAC driver control.

No problem has been spotted. So

Tested-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> As patch 7 removed the direct calls to the XPCS config/link-up
> functions, the last patch makes these functions static.
> 
>  drivers/net/dsa/sja1105/sja1105.h                 |  2 +-
>  drivers/net/dsa/sja1105/sja1105_main.c            | 85 ++++++++++----------
>  drivers/net/dsa/sja1105/sja1105_mdio.c            | 28 ++++---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c |  7 +-
>  drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c    | 18 ++---
>  drivers/net/ethernet/wangxun/txgbe/txgbe_type.h   |  2 +-
>  drivers/net/pcs/pcs-xpcs.c                        | 92 ++++++++++++++---------
>  include/linux/pcs/pcs-xpcs.h                      | 14 ++--
>  8 files changed, 132 insertions(+), 116 deletions(-)
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 

