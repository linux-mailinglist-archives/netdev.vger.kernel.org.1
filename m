Return-Path: <netdev+bounces-131643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6459998F1DA
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D21B282F04
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B39319F13A;
	Thu,  3 Oct 2024 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IydSYX7w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0500D19F10C
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967070; cv=none; b=dKr03WsJBGBa/J7iXeaNG7wMSNcZBKyHhMPeSAk6Pjhi0xHBL9l0X6lcI6ocIshFkEEptzLMjvDbM7LwMFDy6IqP1LTJd1/eCAhd5aTriCc11WlVc2zplxEWx94jwSEIaAh8iqDu3o860Sd9eBW1XSqRBQNcrpHT5JERXmF3SDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967070; c=relaxed/simple;
	bh=t+ye/okkhM/HmL1Hq5Rec+1gDGlwQ+ffNuELh8DibHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5BgeWTkSaLzC8IPR6e2L4NknEWGXQQruwiXZv3n1uEo/eEgSbZVd0wFTSi8u+C6nMy6jZ028fxpiaGWzQRf4mSynQqZ5jb9gGcBZUdP1BzcNjQKq7kjVm1YSW3Q0sheLvvqCQYdEGFgisT4tHihL8+g6LDb2cXT6mAfSeSTgh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IydSYX7w; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb1e3b449so1509125e9.3
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 07:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727967067; x=1728571867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mu20pGLalUvdOIjk5AqKfh2gkoDLetINeYilnuFghq0=;
        b=IydSYX7wx1n4PJCDFDCSpezDwatoi1uMN7s/s6QW8iE6KDK0F6OEI4a38gICeJMjlG
         zCj8UjGJs69Y3qo5PlbjQG8hY8N7UYm1MQVvk3M5gpG6Y6HJg90B+NlvZM0PbzlJEHeZ
         5iIuX46NRPq67xVK49JHcdcELCKbnMio8UNNVnhVbHivNkCd/Dvhq+hqc2KaZ9inGMFq
         otRlVRsm5mCJkTSQtseydrXdzxqBn7yu8yv97tfBd2N9bvHVsduAFx17ix3t/defYuIy
         XUo24e0fCqL9cm64LaKGZAvyxNbZwiaST8h9Fpct/TKO+COuAJGeDRxvm+F4OkGI3Uo5
         IXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727967067; x=1728571867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mu20pGLalUvdOIjk5AqKfh2gkoDLetINeYilnuFghq0=;
        b=blUPrrgYu1tNPu6iUwYMsWim+gnovJdu68KczHZQnr2TWdLXHATlTvkM1WAojcJrxP
         geoKT52txBFspFi1a45p5TGn3xkp7rTWSCwQTUwTgtPzIxbWqc0PbQ01t7F26/P3obQE
         LKIFyvdpMZdoidaiQ1bY2FrTFoeYi+0HBWlgaqRSCAPQ2bLjyrNbptzlv2BinwpS3SwR
         mjX4rq8ZZHiu2gV+1sTdNbnBZWCBZDJDqkoSd+IL8aBtaKPQ9ixvvujOylLPIfy2qYrd
         SnUzDe4hbMTB25H8jTWBhfgAOpT29FK8tfUHF5iQwGqij/BLkOWxSQGR8ONZ9KBcy/3c
         qMzg==
X-Forwarded-Encrypted: i=1; AJvYcCVA/+TE/BF3OG1ceW62PmQZ3wMdTwck4NVIo9DC+bDfBH0NKmChpzz7bW97VZgdabcfp6hsink=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBKNrAmIZ6+8ggq+hceUGbkvaGw1RTQeWUAjBVXkyN5Rq7Iev2
	kLjgaAQGBFdAQe0hiNZ9XiLlLYNLXaGH0lyZJ5RdNKTBJBRsJsWw
X-Google-Smtp-Source: AGHT+IHi4LKkqq4XvFUv13REHl3dl8De86NgJp7tuzIL1+ECK4mWYyn7KUhjZFG6d9RbaUQLX8Zanw==
X-Received: by 2002:a05:6000:2cc:b0:374:c8d9:9094 with SMTP id ffacd0b85a97d-37cfb8b56d9mr2704482f8f.5.1727967067105;
        Thu, 03 Oct 2024 07:51:07 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8ca4d65b8sm773335a12.63.2024.10.03.07.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 07:51:06 -0700 (PDT)
Date: Thu, 3 Oct 2024 17:51:03 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: remove obsolete phylink dsa_switch
 operations
Message-ID: <20241003145103.i23tx4mpjtg4e6df@skbuf>
References: <E1swKNV-0060oN-1b@rmk-PC.armlinux.org.uk>
 <E1swKNV-0060oN-1b@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1swKNV-0060oN-1b@rmk-PC.armlinux.org.uk>
 <E1swKNV-0060oN-1b@rmk-PC.armlinux.org.uk>

On Thu, Oct 03, 2024 at 12:52:17PM +0100, Russell King (Oracle) wrote:
> No driver now uses the DSA switch phylink members, so we can now remove
> the method pointers, but we need to leave empty shim functions to allow
> those drivers that do not provide phylink MAC operations structure to
> continue functioning.
> 
> Signed-off-by: Russell King (oracle) <rmk+kernel@armlinux.org.uk>
> ---
> diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
> index 668c729946ea..09d2f5d4b3dd 100644
> --- a/net/dsa/dsa.c
> +++ b/net/dsa/dsa.c
> diff --git a/net/dsa/port.c b/net/dsa/port.c
> index 25258b33e59e..f1e96706a701 100644
> --- a/net/dsa/port.c
> +++ b/net/dsa/port.c
> @@ -1579,40 +1579,19 @@ static struct phylink_pcs *
>  dsa_port_phylink_mac_select_pcs(struct phylink_config *config,
>  				phy_interface_t interface)
>  {
> -	struct dsa_port *dp = dsa_phylink_to_port(config);
> -	struct phylink_pcs *pcs = ERR_PTR(-EOPNOTSUPP);
> -	struct dsa_switch *ds = dp->ds;
> -
> -	if (ds->ops->phylink_mac_select_pcs)
> -		pcs = ds->ops->phylink_mac_select_pcs(ds, dp->index, interface);
> -
> -	return pcs;
> +	return ERR_PTR(-EOPNOTSUPP);
>  }

dsa_port_phylink_mac_select_pcs() didn't have to stay, as phylink_mac_select_pcs()
is entirely optional in phylink. Otherwise:

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com> # sja1105, felix, dsa_loop

