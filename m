Return-Path: <netdev+bounces-137441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B12069A65F1
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 13:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D1E1C20B9D
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 11:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C130B1E3DF9;
	Mon, 21 Oct 2024 11:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGXPHbja"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3C61E47A6
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 11:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508946; cv=none; b=EjSG+9mz8cujEDj/dLgdhDKy/FjfcU/WZt6hztP4bNqQki0jzbhegrpuhynsELKNCE1LHYXYIBjkGYjapyHq2PnMjp4qm5672+lyrKOmRixz62E+BGbwh9vkagT4oisbEK02/+kRMcPmyU2wfyVVXK5GjXdhxs7Rk3YZI5Cr46A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508946; c=relaxed/simple;
	bh=ASopMdsdh0wZPrv8GZaB6MF/oleGBZ336sWbomozVRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXAr0kAv/oxVPCzq6Q3sXk9UHACGNm7l7FOx3/I/DZdjyaTHHEyzvq2WEcQTMud3RbaW+mwdjSy/BVJP8p9jTjdkq8jrzRm4dDU6gOK+RtCwP/oDtINeo8lH6JQahWvtF6+2ucnxupHeSlaksIb7GPYRBoOkmdAeC+D122U1jiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGXPHbja; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb559b0b00so37381741fa.0
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 04:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729508943; x=1730113743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iUGUVGdsceDLrrozcw5booyD0IfXV+COgWQL2aKRCQ0=;
        b=gGXPHbjaqhrzISSwJLGAeQydiOMOqiNc65d1fkLoqGeMAr0imLgCE7tAJpFdwpCI5l
         Vj22YaTyGBk5wjamX9BzJ4DMws2lKpLi7U9IhCv155tnMI1VEP2XpT3nERc4r+O7C56R
         trBkybJJes+6sSmCiszSBRA8v7ccKvSO1881yzSJFwfulOzLByR7+AIoDxzggZt4t7lO
         QFW/uPlHqu2Nv3/cjoQ903zcJEfPylB1+FE2HODI39noC+TCZjuSNJYJrYyEz1dLhlTZ
         ABqW5O+nZhLpXGiUTqXcBVHY9erjwq46PMk9f6hnlMYIlPFOGKVFeHRqCX1vBbe0ngxI
         L+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729508943; x=1730113743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUGUVGdsceDLrrozcw5booyD0IfXV+COgWQL2aKRCQ0=;
        b=jdcsfE1dIZPq7B/o9DIl4IXxWMfFSw7GrnPlsT+8avNVUK+U4FoyHTHkl4tw6wEhEw
         4xWZBEXUJdXd8KGUM0vF1sMg9THcFr0fVdggiRf38zGKPvB1ETkE7kxQv6fcEuXVMShj
         c6/AX3/6y7WFURGJf+3zYGFn87Xr/zgixANRdmFLQwcfrx3vq17k2+2Q4MLaRwT+3GXa
         T/Upv4qQJSIxDMi6+AJOqrGhHZp8GbucROD/rVEbmRNEDbkPGIXozW6iMCQ/6EhGIw+I
         yviRY3RGxOh85BJF1kud1n1bemwHwgw28nT6k6vEgx+Q0en2FUjHk9G6wxXfkgwjzBJX
         nlug==
X-Forwarded-Encrypted: i=1; AJvYcCXALdGJflfWS0o49TwWxHZDj2kKDjhh4bBzaleCEdw8qs74wBF13O3y4avezRZw7wg1rMMFoVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb1lerKyDGAr2wuBZVFg/V2VQu9XugPcJu+tVU6bPMEecFwm/4
	tIUq+4ZUizishJstM1x7sOmyi7BkLT/wuVv88W97DxXmD3qZoMYi
X-Google-Smtp-Source: AGHT+IFXoOGSMHGHtSwAnLznnLlj4FKh6M0SI95zgn51H0VFyurB+kqAUYHayqeijcPyYUV0kJ0wxw==
X-Received: by 2002:a2e:a548:0:b0:2fa:c9ad:3d3c with SMTP id 38308e7fff4ca-2fb82e948a3mr48016551fa.6.1729508942474;
        Mon, 21 Oct 2024 04:09:02 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ad75abcsm4663041fa.46.2024.10.21.04.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 04:09:00 -0700 (PDT)
Date: Mon, 21 Oct 2024 14:08:57 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <Jose.Abreu@synopsys.com>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 0/7] net: pcs: xpcs: yet more cleanups
Message-ID: <tnlp4m7antrcpbscpvdzpntyjudgs5mivw6cqvobyjph37u3la@okz5aoowa6bm>
References: <ZxD6cVFajwBlC9eN@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxD6cVFajwBlC9eN@shell.armlinux.org.uk>

Hi

On Thu, Oct 17, 2024 at 12:52:17PM GMT, Russell King (Oracle) wrote:
> Hi,
> 
> I've found yet more potential for cleanups in the XPCS driver.
> 
> The first patch switches to using generic register definitions.
> 
> Next, there's an overly complex bit of code in xpcs_link_up_1000basex()
> which can be simplified down to a simple if() statement.
> 
> Then, rearrange xpcs_link_up_1000basex() to separate out the warnings
> from the functional bit.
> 
> Next, realising that the functional bit is just the helper function we
> already have and are using in the SGMII version of this function,
> switch over to that.
> 
> We can now see that xpcs_link_up_1000basex() and xpcs_link_up_sgmii()
> are basically functionally identical except for the warnings, so merge
> the two functions.
> 
> Next, xpcs_config_usxgmii() seems misnamed, so rename it to follow the
> established pattern.
> 
> Lastly, "return foo();" where foo is a void function and the function
> being returned from is also void is a weird programming pattern.
> Replace this with something more conventional.
> 
> With these changes, we see yet another reduction in the amount of
> code in this driver.

If you wish this to be tested before merging in, I'll be able to do
that tomorrow or on Wednesday. In anyway I'll get back with the
results after testing the series out.

-Serge(y)

> 
>  drivers/net/pcs/pcs-xpcs.c | 134 ++++++++++++++++++++++-----------------------
>  drivers/net/pcs/pcs-xpcs.h |  12 ----
>  2 files changed, 65 insertions(+), 81 deletions(-)
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 

