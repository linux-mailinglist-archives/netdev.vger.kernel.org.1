Return-Path: <netdev+bounces-151504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 550909EFCB1
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 20:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14CBD28B5D8
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 19:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA07192D97;
	Thu, 12 Dec 2024 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgmlWJhd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7362225948B
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 19:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734032667; cv=none; b=ZZ9PgSQBh8mfpvYjHbp6Dzg5Qy9GrjbcJQGwobZcfiYq4BTlxtO6gHXfi6t8GvDQUc8PnNI1MEwNgpXXJSQ5iP+VgsT/Km0ZGixIS7eQoYve2ZkBeQdk32/0rtwp7VU+5HPqbNOTcWg5YcTbuNySVIqgkc8zl9Ue60+D8mZ3yNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734032667; c=relaxed/simple;
	bh=CNgaj9Ew6XbBuZ/anKaSF18JrvLFYZT/x69cR/PfSGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbO1j9g8D3PNYK2f6xoYu5ywiyIi950GLuWfzJ6vUSs/CddatOFD7egPhhPciFX4SEsZgeLP2B8yblZ1N5saorEi51Ww0MccqAXDU1x8I6J6mt5+P2UAMEpvdrJ+4bkC+ROGq8WfJqyyGf9zHR4suYD5sq4w9FDwW0Mjcay41Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgmlWJhd; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3be7f663cso173043a12.2
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 11:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734032664; x=1734637464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4GfVxgMf6zXbYgzLQ07jaenGeKqvYzQfmIRqlRSXQ7E=;
        b=VgmlWJhd2RMux+4Mxm/9izl48O9gLZpZsoSwQ8WfvAZX+unFOTtseZCN9IvkoAlYco
         ommdtVzi45r10jilbz+9MRCZvyGFXOdGkXnD2JKSBiOwSe+IVtqqpHqV31J3LlH9kf8w
         DZUT5o02Fn/I+HA2Ss0LC1cVHsgkMhKZJ/W9VRoRR5y8i4Tf/iTUg8wWKPr5IiXj8sZy
         UfOUTyl6L8cJAwv7eHnCaWiJQOQ9sEilrT5CcSIzdLiq2l9z4+LnASFM5PtgY7YAPi36
         GvqdbjzzZhFaoXVDfmb81jbQNGwqZLpWe93jIJl36POWZFXG4v8dejGc2NUDniTzdVsm
         ohBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734032664; x=1734637464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GfVxgMf6zXbYgzLQ07jaenGeKqvYzQfmIRqlRSXQ7E=;
        b=BRr/PJ13udElnqZmHiSKGNdRNkIOvlW5YAjPl8Rh8mmCJxkd9ptoazbAVVKtzJE9ZX
         +2tkf+RFPaBabJSmsJIIhELktP1aDbwUiuDXL8OHlntEoKm65EWLJaWZ0EUBd2e5nZov
         twKVB0gSR7JzmzImPCSbsJbxLvNeuzE/r2gke5r/hmEsG/T5RxvlojF0DtZRvLQ2C/qY
         4cGKDgm9n8HN34yCxa1X8TU+86R67efW2QmzN+I0vXyyBJilukZ2cbN3ih6a+bps//p+
         C9hQqkCkdCH6tz80vUKk1rRpoGB1a246uFmu9wvsE+o6rDY/UTPelvUMFgPgs1Jk1Xbt
         Lhnw==
X-Forwarded-Encrypted: i=1; AJvYcCUrJxV1sGKpgvUyyNzppvQLJopCttzyZxnMEeOJCG3/OAmMFIBQQsKdnjBCMs0M63DwwrqTCNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsX+z+Pu0zbsK9e+2PI/QsZlyvWYf17+bUsuMspV5YV3A2ezcG
	a42bt3CD/p7daQCyseG8nJc0bDC1h9wIjw57xb0YLcKWGh3NrxKZ
X-Gm-Gg: ASbGncub4BitCqINIiRuXfLgVAZSBsI7R05Rq0TLcxI15ovA6NvOd62Gnvzgh+R+IGh
	3n0AMMjMQouL75SLrAvcyrPE0no+9ZQTOc8SjgjB4LWv+taPFscC1QVXReyxN1ORnxoLlJmSrWF
	ZNMvtsNGvcklb24s2OwuIQKkYDp7WT52E2DSrP3sj65cT71e7JVEqt/q+jDVKbIdDj+V5VciNSO
	Zo14FIpQ+/DzkBNgYkEwnT8QgQfk60tX9U5ML8hYPxU
X-Google-Smtp-Source: AGHT+IHv8vKghLEEzYScbuUtxTmHdVMcUGmpvPWGRQxZ9IEdwg4IbTA1i6W1Y/EC5d5JghFSpFwqEQ==
X-Received: by 2002:a05:6402:26d4:b0:5cf:f39f:3410 with SMTP id 4fb4d7f45d1cf-5d63236a6e8mr688925a12.2.1734032663432;
        Thu, 12 Dec 2024 11:44:23 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3cbd14892sm9196402a12.39.2024.12.12.11.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 11:44:22 -0800 (PST)
Date: Thu, 12 Dec 2024 21:44:19 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Woojung Huh <woojung.huh@microchip.com>
Subject: Re: [PATCH RFC net-next 2/7] net: dsa: no longer call
 ds->ops->get_mac_eee()
Message-ID: <20241212194419.4cbb776hc47yyl6z@skbuf>
References: <Z1hPaLFlR4TW_YCr@shell.armlinux.org.uk>
 <E1tL1Br-006cnA-KV@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tL1Br-006cnA-KV@rmk-PC.armlinux.org.uk>

On Tue, Dec 10, 2024 at 02:26:19PM +0000, Russell King (Oracle) wrote:
> All implementations of get_mac_eee() now just return zero without doing
> anything useful. Remove the call to this method in preparation to
> removing the method from each DSA driver.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  net/dsa/user.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/net/dsa/user.c b/net/dsa/user.c
> index 4239083c18bf..fb38543b29db 100644
> --- a/net/dsa/user.c
> +++ b/net/dsa/user.c
> @@ -1250,23 +1250,11 @@ static int dsa_user_get_eee(struct net_device *dev, struct ethtool_keee *e)
>  {
>  	struct dsa_port *dp = dsa_user_to_port(dev);
>  	struct dsa_switch *ds = dp->ds;
> -	int ret;
>  
>  	/* Check whether the switch supports EEE */
>  	if (!ds->ops->support_eee || !ds->ops->support_eee(ds, dp->index))
>  		return -EOPNOTSUPP;
>  
> -	/* Port's PHY and MAC both need to be EEE capable */
> -	if (!dev->phydev)
> -		return -ENODEV;

It may well be that removing this test is ok given the later call to
phylink_ethtool_get_eee() which will fail with the same return code,
but this change does not logically pertain to a patch titled
"no longer call ds->ops->get_mac_eee()", and no justification is brought
for it in the commit message (my previous sentence should be sufficient).
Please move this to a separate patch, for traceability purposes.

> -
> -	if (!ds->ops->get_mac_eee)
> -		return -EOPNOTSUPP;
> -
> -	ret = ds->ops->get_mac_eee(ds, dp->index, e);
> -	if (ret)
> -		return ret;
> -
>  	return phylink_ethtool_get_eee(dp->pl, e);
>  }
>  
> -- 
> 2.30.2
> 

