Return-Path: <netdev+bounces-85311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE8C89A25D
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 18:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42281F23753
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 16:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD680171078;
	Fri,  5 Apr 2024 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7HPlOMD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1983D16EC0B
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334066; cv=none; b=HgAlS+PGs7NSMuFSLQNCIBvx7SOeWY4k8jTiT2XJy3e0lZmn4t0y43VA7rJT0BkXGwYjyCkRuR3y6CM6NGZVBe/VDStJp/NiLXz5Z5LPh1DKoEu+yEiHIdluIoXvbm+2CPpch44Xeh1+fIRR2en9FGPaxEWK17yak7dsOEWBmm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334066; c=relaxed/simple;
	bh=Y4QB/nC+1352wgA4QHKxgZGUp1UwVlNE8mUKOM8RYMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQtcOD7NLsmVtWeWZaI9r73wt131Pt3tk26aFegjvWYLnwEpb6VPfnhseYAXsQnYfRC62T22Kgx16Ikrld0o/Knvc0VRFYEwcUJdUbG+kW9vDHt1PkF70M8SLP85a5wsZcI2cyI1ULkPrj45fLS2m4vvrTT9d4hWtnZpBV1kE3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7HPlOMD; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso2903899a12.0
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 09:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712334063; x=1712938863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vUB4LWdrxzHQpA54Z8b2EujmuEdyXj7qjrQ8XUdHzic=;
        b=A7HPlOMDYgXmXiWblspg6gWa4C3kNL+5BCEzPFdpBfn9pNwn5AoCtkaH4CB/qbINb7
         +++2lQGjA6fYP6nVpbBmet4yoK5uH4PCgeZ2+ePoMqOZFRr8QmB7ArTtu5DQ3PmkibXR
         NLuRFIMVURDquCXL2fpKYZmzpvFfN0Anac4dnfIGjaVrBZVaJLEQZ6dTlUDhXy3dOIq1
         0rCAbvEurkGe5eUN/dgHNcGlxJm41qkZX51IvqyFbN43Rz2ZPuv7QODUHUzQikWl70o/
         qwnoYOI0oY29SsgiUATzlIwDOFa7G9/0AJvy+oOkf3CBKJuX0o1Kjma1PvZco0WBTb5G
         GfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712334063; x=1712938863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUB4LWdrxzHQpA54Z8b2EujmuEdyXj7qjrQ8XUdHzic=;
        b=iiBpHNgOMRGGPc1fMhdV7CtLq92ac3yNOrfXW1D36fv08c7c5BLmSsc2LAtpyuoaKG
         13ML3KfqovsAfS5Y0Bn0AiE4SuqGpeZVy+zd8AqSNtcFf9i/MPveyYk0oJHZoWv52/AW
         Ws6fr6H/KtYHCtMHLdjx9wswISpzWPpCdQpm0JkVthGGFqkhKzcLoBPvxCLzDdw+TqU1
         R0X8lRkY0RhaWNGc9DyNbegfCq1vLWtRGZE573bWZJxtoXpSl16bETW55h7LUDcCiwg0
         Qnz+NuG/IHHpMdSZOwppjPm2azlD5cZoueVDVTg1u74jr86PlC/c8MfMWxNOWSbQTOWu
         9s9g==
X-Forwarded-Encrypted: i=1; AJvYcCWRem9kO45uxo25TYKNCdr14VDSPh35VKETI2ZCd/TCvzVfzHRtIThLXFGUQPq5jl3fYc3IlryybXW2HuwzjoTpdmf8JGIN
X-Gm-Message-State: AOJu0YxQpnDlGce7ervfCZNAOXFrCcXUL4QBRgyGLwm/ooUQVdmBhgcp
	yeLxfm0PtoA8BPgKbV/vAHpNfV0gnJ8CKFpKiqCewqGLW62vMh2A
X-Google-Smtp-Source: AGHT+IHjLXdz8JxbVnLNZB0drHzowLxE5hc3zxT7lG/Ye/9aC6ERcSQXHVgocnqhPVcE7g0Tf5ntsQ==
X-Received: by 2002:a17:906:412:b0:a4e:fe3:ceff with SMTP id d18-20020a170906041200b00a4e0fe3ceffmr1223895eja.57.1712334063178;
        Fri, 05 Apr 2024 09:21:03 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id g15-20020a170906198f00b00a4e2bf2f743sm988291ejd.184.2024.04.05.09.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 09:21:02 -0700 (PDT)
Date: Fri, 5 Apr 2024 19:21:00 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 2/3] net: dsa: allow DSA switch drivers to
 provide their own phylink mac ops
Message-ID: <20240405162100.5iy2k66bqnhprej4@skbuf>
References: <Zg1lEJR4bcczFekm@shell.armlinux.org.uk>
 <E1rs1Rp-005g7S-3j@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rs1Rp-005g7S-3j@rmk-PC.armlinux.org.uk>

On Wed, Apr 03, 2024 at 03:18:41PM +0100, Russell King (Oracle) wrote:
> diff --git a/net/dsa/port.c b/net/dsa/port.c
> index 02bf1c306bdc..4cafbc505009 100644
> --- a/net/dsa/port.c
> +++ b/net/dsa/port.c
> @@ -1662,6 +1662,7 @@ static const struct phylink_mac_ops dsa_port_phylink_mac_ops = {
>  
>  int dsa_port_phylink_create(struct dsa_port *dp)
>  {
> +	const struct phylink_mac_ops *mac_ops;
>  	struct dsa_switch *ds = dp->ds;
>  	phy_interface_t mode;
>  	struct phylink *pl;
> @@ -1685,8 +1686,12 @@ int dsa_port_phylink_create(struct dsa_port *dp)
>  		}
>  	}
>  
> -	pl = phylink_create(&dp->pl_config, of_fwnode_handle(dp->dn),
> -			    mode, &dsa_port_phylink_mac_ops);
> +	mac_ops = &dsa_port_phylink_mac_ops;
> +	if (ds->phylink_mac_ops)
> +		mac_ops = ds->phylink_mac_ops;
> +
> +	pl = phylink_create(&dp->pl_config, of_fwnode_handle(dp->dn), mode,
> +			    mac_ops);
>  	if (IS_ERR(pl)) {
>  		pr_err("error creating PHYLINK: %ld\n", PTR_ERR(pl));
>  		return PTR_ERR(pl);
> -- 
> 2.30.2
> 

This is not sufficient. We will have to make DSA call the driver through
the mac_ops it provides, rather than through ds->ops, here:

dsa_shared_port_link_register_of()

	if (!ds->ops->adjust_link) {
		if (missing_link_description) {
			dev_warn(ds->dev,
				 "Skipping phylink registration for %s port %d\n",
				 dsa_port_is_cpu(dp) ? "CPU" : "DSA", dp->index);
		} else {
			if (ds->ops->phylink_mac_link_down)
				ds->ops->phylink_mac_link_down(ds, port,
					MLO_AN_FIXED, PHY_INTERFACE_MODE_NA);
			~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

			return dsa_shared_port_phylink_register(dp);
		}
		return 0;
	}

Coincidentally mv88e6xxx is exactly one of those drivers which needs the
early mac_link_down() call that isn't driven by phylink.

