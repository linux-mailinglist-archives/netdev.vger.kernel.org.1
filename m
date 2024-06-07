Return-Path: <netdev+bounces-101796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6456F9001FE
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684051C21CE2
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF42B18F2E7;
	Fri,  7 Jun 2024 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNtTbi1T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391E3156972;
	Fri,  7 Jun 2024 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759116; cv=none; b=q4Y3DaxbASYYqdsDTw+ujDzi6qV4FHWQ6dgTr18cebraYqMm/howYbwmxXoByNLkh0J/KndS3SK4y9GQKPlNEEYgzX0woNY8ST1SW7nVkGPwaTWCH8VSLDdYEmRTEG+Ahox4wtIQ8yubUavPZFQwHNDP4zYwjzEq2WwtTGX8Deo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759116; c=relaxed/simple;
	bh=44+u75EqDodHqwbf+PBRqWE5SQOeRGUg3wnKokEYnzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwpP1QJfSsQdzLbh4SA3iRBcpxxzN4VmQY4kA25yp8totjLZ1BBm6b3IKP85094YJPuAraphGoPuti2i5jxQQy0//XEO7cIUssA0E9KOaXTs4wxaT+aUP5MHq+5POQgiE7kICt3T/v7UnefmDkC/Tm6DiUp79fYv7Jq75XLQYKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNtTbi1T; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6c828238dcso191661266b.0;
        Fri, 07 Jun 2024 04:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717759113; x=1718363913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ihZMC8zYkmSYDgrob6mjYe5JS7698nSED6xpRSGYLKg=;
        b=MNtTbi1TWPB8Shzn86a9XjOGyvIJyHltV/aFDk/+hqFsRAfhlEbU9epqLHKw96dbni
         062DB7ePJbRTUn4yMvzSygXjNAPLIuUp2G5aX7bfp1DTnlw7eDAFCu3mjBr93/0FT3LN
         X53+oJKvUvQDoVZgYTfBAZZAgvXeMaDkw3BI6vW9J6lO80Q1A+/EU/IMWgn5lq/VYaKP
         M1Kn63e2B6J1UkVV3GTgqnk3vqNzbiV1BESV1VitjMV+04+YTctOf8rmnsexc6iCkXYS
         baAeE3ovf1xTkn1AJDWP/UQsTpnk2VxXNaRv45MBlRkUpWy/jo7g3AtECmJM+uB8H49j
         u58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717759113; x=1718363913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihZMC8zYkmSYDgrob6mjYe5JS7698nSED6xpRSGYLKg=;
        b=YLGP2sXRn43AYr5msNU67lW7vfqBn20zlqB9+Q3XfcjiNgnbh/5fg8rei5lYASb2uu
         AWM2NMCLIlLKlUIMTTjH6hCBR/K1HklEAPaHNom6xM8imPqFdTmHMgKX1mmpalCVTa2u
         1DE+6mpdnV9rxWeXog7GDNRGjggIEwqQdqTYItw7ggrj4+S6bpdj9BGP4JkrsZClGGgI
         3qsKc5G9cLB2LD/LdrnrsdyPkyzVZEwCtv9tJ3+Y349o3I9EDo8xV9fTQOpiJ/u6DVzB
         OR52gn+IgGR38Zr1tVSQzgAU2TlV+V5L0pKv3axvfHkuCg+Eh0/fmhQeS71kZw5eex9E
         pTjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWApINCLgdseF6EFtPcrB98ihsO8MGyjAsfyQif7ZROu8o14dgbczzHxPdRrNQ/ggVguDwP84SI/dzsjSuiToaiwnFf5GMjGQmqZIdfC8f+P8g6yT4ym+GzDTntvPuxWW9RvgjwUvVEv2yIGjtW+YqnwEZZz/SkV/z0AsgY47hrDA==
X-Gm-Message-State: AOJu0YwHp1MZSH2dSru8f5YspmxHWNF6ur1wE7H7ZlaN3sYDgiLdyWYw
	qOIHwE6+NFm2QXNNsw2j+FTmZthByiMsCfWxYUUPzIjhprEfiqBF
X-Google-Smtp-Source: AGHT+IEJOL/AU4/c7xYsb10Aa4JO9qVYLN5DE+vsGLCe54VbAbC12ABTB2xsbyG9cFl5XVrznDxWSg==
X-Received: by 2002:a17:907:6d27:b0:a62:2eca:4f13 with SMTP id a640c23a62f3a-a6cdb0f5404mr201233266b.59.1717759113234;
        Fri, 07 Jun 2024 04:18:33 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c806eb64csm229420966b.117.2024.06.07.04.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:18:32 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:18:30 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 05/13] net: dsa: lantiq_gswip: do also enable or
 disable cpu port
Message-ID: <20240607111830.jfi3roiry27bmwih@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-6-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606085234.565551-6-ms@dev.tdt.de>

On Thu, Jun 06, 2024 at 10:52:26AM +0200, Martin Schiller wrote:
> Before commit 74be4babe72f ("net: dsa: do not enable or disable non user
> ports"), gswip_port_enable/disable() were also executed for the cpu port
> in gswip_setup() which disabled the cpu port during initialization.

Ah, you also noticed this.

> 
> Let's restore this by removing the dsa_is_user_port checks. Also, let's
> clean up the gswip_port_enable() function so that we only have to check
> for the cpu port once.
> 
> Fixes: 74be4babe72f ("net: dsa: do not enable or disable non user ports")

Fixes tags shouldn't be taken lightly. If you think there's a functional
user-visible problem caused by that change, you need to explain what
that problem is and what it affects. Additionally, bug fix patches are
sent out to the 'net' tree, not bundled up with 'net-next' material
(unless they fix a change that's also exclusive to net-next).
Otherwise, just drop the 'Fixes' tag.

> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> ---
>  drivers/net/dsa/lantiq_gswip.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
> index 3fd5599fca52..38b5f743e5ee 100644
> --- a/drivers/net/dsa/lantiq_gswip.c
> +++ b/drivers/net/dsa/lantiq_gswip.c
> @@ -695,13 +695,18 @@ static int gswip_port_enable(struct dsa_switch *ds, int port,
>  	struct gswip_priv *priv = ds->priv;
>  	int err;
>  
> -	if (!dsa_is_user_port(ds, port))
> -		return 0;
> -
>  	if (!dsa_is_cpu_port(ds, port)) {
> +		u32 mdio_phy = 0;
> +
>  		err = gswip_add_single_port_br(priv, port, true);
>  		if (err)
>  			return err;
> +
> +		if (phydev)
> +			mdio_phy = phydev->mdio.addr & GSWIP_MDIO_PHY_ADDR_MASK;
> +
> +		gswip_mdio_mask(priv, GSWIP_MDIO_PHY_ADDR_MASK, mdio_phy,
> +				GSWIP_MDIO_PHYp(port));
>  	}
>  
>  	/* RMON Counter Enable for port */
> @@ -714,16 +719,6 @@ static int gswip_port_enable(struct dsa_switch *ds, int port,
>  	gswip_switch_mask(priv, 0, GSWIP_SDMA_PCTRL_EN,
>  			  GSWIP_SDMA_PCTRLp(port));
>  
> -	if (!dsa_is_cpu_port(ds, port)) {
> -		u32 mdio_phy = 0;
> -
> -		if (phydev)
> -			mdio_phy = phydev->mdio.addr & GSWIP_MDIO_PHY_ADDR_MASK;
> -
> -		gswip_mdio_mask(priv, GSWIP_MDIO_PHY_ADDR_MASK, mdio_phy,
> -				GSWIP_MDIO_PHYp(port));
> -	}
> -
>  	return 0;
>  }

It would be good to state in the commit message that the operation
reordering is safe. The commit seems to be concerned mainly with code
cleanliness, which does not always take side effects into account.

