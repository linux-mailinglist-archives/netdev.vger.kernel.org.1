Return-Path: <netdev+bounces-107312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3C891A8AF
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2439C286A97
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B95195B18;
	Thu, 27 Jun 2024 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlUyZpFP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A68195B04;
	Thu, 27 Jun 2024 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497385; cv=none; b=lTZ/8LEoivk1bxpF5IFWx3piigc9gZTYGqeT5AJo/cQg37l1VFzYBhNpJwC7f+rsUVSMtzNjbErDw4+W8k25PwdPnjSUOmcoM1kGR7Z8oI4tN5HxNHXoG6GXp8s4i36j4TAUpKcOsFThDVTQHtihWmrZsWvlC3hE/pVUtc8X6Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497385; c=relaxed/simple;
	bh=bf8xtcKWz2ekG6ZG9mxbefmEIFpXZW0+JgN9tcZmwwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paldOtX9qfZOLIWtnRqYF1pxI3azKILlUXN1Qa2RnHhb5pl7OYhVrzL5ZIfJ0w1ALDN6izjvSKolAypA8Bh/YZYI/4SJekBpWDKFZcxgN+1yREMcFd6aNU1Oa699NFG3/XNbS4VGeaCAxy5yR05pDJy0EcF/l2EXeDURn72Eb1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlUyZpFP; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52cdc4d221eso6645674e87.3;
        Thu, 27 Jun 2024 07:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719497382; x=1720102182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WxbdUF3igWgZnkX8ezz96rfrkEDeMV7VPqBBzmY6B/M=;
        b=MlUyZpFPVTOVzHrDuvOjfnbg3cLmBRJ0gEkdM+MxN5zlD571JklivsGrRhBsjkDxIL
         4UF+ihPs367R2yOTmUuRz+/f22NmfSUSlo8PZWEz7m00TIHUAfwLHw1nj40BCoxbs20N
         OCotgGIzDMkRicXfo9YzL3SoqvTPaSerYTy3pqgMNDgF4awJWFRl4WLe73F4PbtxlNEZ
         tMC/ifWbx2iPsyXfwllQovjwHIthorBD8rPkKIKaNztAz/jAA8GyIfvF2sWduXkLzA1w
         aWS4EOGSMQIuVKJcxlfcKjO/9X3o1M6vT7z9VVpB9nL9DCs3p1xcTmy7zjAfG63c1D/A
         GB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719497382; x=1720102182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxbdUF3igWgZnkX8ezz96rfrkEDeMV7VPqBBzmY6B/M=;
        b=SV67PJ08Ew+68I02f05I99qPTKnQM9cBQjbAyoYvcoBDOsTbqq9MbnVful0SzQ+6ll
         ygspUiDGe8wT179h38Q834q7/jGQJdn4E6lMhEl5AY2KrvvqWyPfDodjH7bs22M2/xn2
         hBNmyz204oKYk411TTY2Q9W+rq9ikIJ5d729kqJTRzjXWno38w8oX+gUD/iQB6B+hvwb
         UxKN3x/UF3JIsgU4zxMAJcCPP3ISaGNwDrGD/sMC6FkwCOdPDtcnkPow1rqkM4s4R6VH
         GhObRg2WKN6Num2M+XW0WW+rlWMHzyNR0dVcnB9/xwFxjQmOoDTOv01KbZpvnEKXsxRb
         ovVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrzzE/DZ66f0Z5DrI8NBg308AbgzZQ3pyq6KYsidcVtjfIReBtwlN/5RJqFUouGTQhOIkTEczfa1lAEkisF9a/7+XnVCNeNjSizTsYedHwBbc9FCSv5oUb/fWD8JIpwijVwc32Hh0QQkd81cIrHl5GUyvBdLA+O2PaEmYn8uGHkg==
X-Gm-Message-State: AOJu0YzuXlB7KOkzrMPIkWDsGYmcMKOgUZbr2CaHCgvD93A/Rz17SdmV
	IkXzMuhiKxEFHz5s2Nb11NWoHtz1Covc4lHsTP0GrBLXfY2jJ6Ra
X-Google-Smtp-Source: AGHT+IGYnYpUx4D98KzvsoiC9IwR+Ky0CtunlggIok0VAdrIJJsUBpeuWypCrzdBCggYRccbsLhkLg==
X-Received: by 2002:a05:6512:281:b0:52c:e10b:cb36 with SMTP id 2adb3069b0e04-52ce183add6mr8239966e87.33.1719497379045;
        Thu, 27 Jun 2024 07:09:39 -0700 (PDT)
Received: from mobilestation ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e71329529sm215060e87.293.2024.06.27.07.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 07:09:38 -0700 (PDT)
Date: Thu, 27 Jun 2024 17:09:36 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Jose Abreu <Jose.Abreu@synopsys.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Sagar Cheluvegowda <quic_scheluve@quicinc.com>, 
	Abhishek Chauhan <quic_abchauha@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Tomer Maimon <tmaimon77@gmail.com>, openbmc@lists.ozlabs.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 00/10] net: pcs: xpcs: Add memory-mapped
 device support
Message-ID: <nct7rbh5w7nd4jneiqzwqpwv5gy6t7q2xobv74hqgilzpykzx5@v6l2aoh5fcaj>
References: <20240627004142.8106-1-fancer.lancer@gmail.com>
 <20240627111034.nusgjux3lzf5s3bk@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627111034.nusgjux3lzf5s3bk@skbuf>

Hi Vladimir

On Thu, Jun 27, 2024 at 02:10:34PM +0300, Vladimir Oltean wrote:
> Hi Sergey,
> 
> This does not apply to net-next.
> 
> Applying: net: pcs: xpcs: Move native device ID macro to linux/pcs/pcs-xpcs.h
> Applying: net: pcs: xpcs: Split up xpcs_create() body to sub-functions
> Applying: net: pcs: xpcs: Convert xpcs_id to dw_xpcs_desc
> Applying: net: pcs: xpcs: Convert xpcs_compat to dw_xpcs_compat
> Applying: net: pcs: xpcs: Introduce DW XPCS info structure
> Applying: dt-bindings: net: Add Synopsys DW xPCS bindings
> Applying: net: pcs: xpcs: Add Synopsys DW xPCS platform device driver
> Applying: net: pcs: xpcs: Add fwnode-based descriptor creation method
> Applying: net: stmmac: Create DW XPCS device with particular address
> Using index info to reconstruct a base tree...
> M       drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> M       include/linux/stmmac.h
> Checking patch drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c...
> Checking patch drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c...
> Checking patch include/linux/stmmac.h...
> Applied patch drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c cleanly.
> Applied patch drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c cleanly.
> Applied patch include/linux/stmmac.h cleanly.
> Falling back to patching base and 3-way merge...
> error: Your local changes to the following files would be overwritten by merge:
>         drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
>         drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
>         include/linux/stmmac.h
> Please commit your changes or stash them before you merge.
> Aborting
> error: Failed to merge in the changes.
> Patch failed at 0009 net: stmmac: Create DW XPCS device with particular address
> hint: Use 'git am --show-current-patch=diff' to see the failed patch

Argg, right! I forgot to port the Russell' latest series introduced
the select_pcs() callback. Sorry for the inconvenience.

I'll get it merged in my repo (based on the kernel upstream tree with
verious plat-specific fixes) and test it out again. Then I'll _make
sure_ this time that the series is applicable onto the net-next tree
before resubmitting.

Thanks,
-Serge(y)

> 
> Thanks,
> Vladimir

