Return-Path: <netdev+bounces-158212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492C4A1111E
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 20:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 957CC16A4EE
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 19:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B281FDA73;
	Tue, 14 Jan 2025 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnPJG1qc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0083C1FA8DE
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736882824; cv=none; b=HFWqX8Z6B29zA5r5E/00TJzgng4z4B9NMwLgDhZ1I/PxVnLmZseaRrVh0j+75B8MCyF5pmv4Ey/X9qLb1rYTXWDlZHZ1ATM8ag8f1xbYNgp0FGXg0yxstUEEMA39UiD26THv2b55/XwRHR1VR37MyQ3ofe1zdaGIbRN9BSvnqe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736882824; c=relaxed/simple;
	bh=rw5QFIaT9MvhfSBWXrOjcuxUxWDKSEDF783Dp3d+dP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tl3rQ2O8Dmjmm/OXF+RZDcjV7atPTo0wwiT8sO2KV4nCl59gqyf5j+EDjQjxlz9Ik1IttWt+/39pR5Psazo2aurVnjLmIwB3r4Miy9eoenKHMEKEBYiRSbTaiM07Pe+TG264/8cVmNWyCK3w9RTAAKP2e0zgOPRMlIusbQ5vX+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnPJG1qc; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385e0d47720so434852f8f.0
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 11:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736882821; x=1737487621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QPDOC2//XkjZODpmg0y0cTcEshGv93e+h8EC+PgTW2w=;
        b=DnPJG1qcndH7sTkHGDYGzyL4xgbIZQffw+babOln/qqLm73s28fOqG0rVatQv+ANEy
         qqqpd40wzO4A8Fx0IJ/6VhMlzyzYAF00ZKGRmou2BTNzLEEVUjUcrguaQ1uUnYK55Z8q
         gvTzvvKBxi1yF7xgya5ubqPwWHXJ50D2rIG2Wtbl/BxhQCBpQQTLG1c4H59CAGnLlWFH
         DH7nTIlW0YTGKARkYheWGPRu7jfUb5HDVZvjpNVKLASK42/iz4bM5XfFDWnddx5DgxfA
         NnL3MVpPYNceLkMrxCi+mo37mB4xMpwkTGA40y8+kNlEjMhnSX9iQJVJ/z7/eyj06VgA
         4zVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736882821; x=1737487621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPDOC2//XkjZODpmg0y0cTcEshGv93e+h8EC+PgTW2w=;
        b=XrKMcWD+HgjHglcWfT3OP4IwL6GNZy1CrqRFS5NwU/Bd0fYf6YT3+sW93AfhKGVsoD
         3VbGzLlkYfyhOY767loiJ21cocFzs0xzqRfGhv+G4ejBJsBYNmSZ71nXOPZivBbeBPNQ
         +9Y1/+w4VFCTvUiKkpwuJBRAJGya8anfdvHYye1OU2V2K2BJGas6Pp8MOEPwPpz+YR7T
         yHaUodbv9OS0wlSwalNGddBRd3JdQkvOYp8RT5yT3Yhgfyfyag7ePKpxA03AlDzprAsv
         qD90RRLoTCnZ4GZWkBpHInBV+9x0x7FdDjvXLOK9gT8QQcdPLEKuutwpENU8FWpDQji6
         FM5w==
X-Forwarded-Encrypted: i=1; AJvYcCVOXURVThds0XsHKxx+zy2D5AYt1L1UkDhpZFG4+58Cp4WsBmy3XA/JaEt3ORo9GyflOY2SjVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo0UVDkQf4EYIHVQjBbDEDEcDeTCOEpKpJ1lSB2vssVRmhvMuI
	5pAn+J69UhWr1BntRYvyWlhMtd7UT8VAYfVH8yC+axXegIhvCN5i
X-Gm-Gg: ASbGncupLJ+vTmV9jChtsgc8gfacO3bC9J0fsGxzHDmejr8mhvzIVSSzKLIG297JNBF
	rEy18Dr8oqqgf98mKhimN7iwRgAkfmGhPNq63RU5oNm/1hZZW2NwBBOJVBmZ/oobrY9u4T207Lc
	d8myOSMXPMRIrn8hHreo51V+WreiYuAUkyL98KcoJuWLbnUjMK3KVeMW3bkMj3oaft4nCihd2gT
	AQr/qAqiaKBAU0c0Re9XpiKPPIvzRAbTLDjyFCaHDx6
X-Google-Smtp-Source: AGHT+IFRMhm4Uswt+iLT80MZuXuKVqSaWMPJbe10Y7O9d5L2JP8nrXQetkrsSgWyKgweQMeH2SjLVA==
X-Received: by 2002:a05:600c:35c2:b0:434:941c:9df2 with SMTP id 5b1f17b1804b1-436e272c89cmr94080655e9.8.1736882820898;
        Tue, 14 Jan 2025 11:27:00 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e89f29sm219901715e9.28.2025.01.14.11.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 11:26:59 -0800 (PST)
Date: Tue, 14 Jan 2025 21:26:56 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH RFC net-next 10/10] net: dsa: allow use of phylink
 managed EEE support
Message-ID: <20250114192656.l5xlipbe4fkirkq4@skbuf>
References: <Z4ZtoeeHIXPucjUv@shell.armlinux.org.uk>
 <E1tXhVK-000n18-3C@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tXhVK-000n18-3C@rmk-PC.armlinux.org.uk>

On Tue, Jan 14, 2025 at 02:02:50PM +0000, Russell King (Oracle) wrote:
> In order to allow DSA drivers to use phylink managed EEE, changes are
> necessary to the DSA .set_eee() and .get_eee() methods. Where drivers
> make use of phylink managed EEE, these should just pass the method on
> to their phylink implementation without calling the DSA specific
> operations.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

What is the reason for including this patch with this set, where
it is of no use until at least one DSA driver provides the new API
implementations?

>  net/dsa/user.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/net/dsa/user.c b/net/dsa/user.c
> index c74f2b2b92de..6912d2d57486 100644
> --- a/net/dsa/user.c
> +++ b/net/dsa/user.c
> @@ -1233,16 +1233,23 @@ static int dsa_user_set_eee(struct net_device *dev, struct ethtool_keee *e)
>  	if (!ds->ops->support_eee || !ds->ops->support_eee(ds, dp->index))
>  		return -EOPNOTSUPP;
>  
> -	/* Port's PHY and MAC both need to be EEE capable */
> -	if (!dev->phydev)
> -		return -ENODEV;
> -
> -	if (!ds->ops->set_mac_eee)
> -		return -EOPNOTSUPP;
> +	/* If the port is using phylink managed EEE, then get_mac_eee is

set_mac_eee() is what is unnecessary.

> +	 * unnecessary.
> +	 */
> +	if (!ds->phylink_mac_ops ||
> +	    !ds->phylink_mac_ops->mac_disable_tx_lpi ||
> +	    !ds->phylink_mac_ops->mac_enable_tx_lpi) {

Does it make sense to export pl->mac_supports_eee_ops wrapped into a
helper function and call that here? To avoid making DSA too tightly
coupled with the phylink MAC operation names.

> +		/* Port's PHY and MAC both need to be EEE capable */
> +		if (!dev->phydev)
> +			return -ENODEV;
> +
> +		if (!ds->ops->set_mac_eee)
> +			return -EOPNOTSUPP;
>  
> -	ret = ds->ops->set_mac_eee(ds, dp->index, e);
> -	if (ret)
> -		return ret;
> +		ret = ds->ops->set_mac_eee(ds, dp->index, e);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	return phylink_ethtool_set_eee(dp->pl, e);
>  }
> -- 
> 2.30.2
> 

