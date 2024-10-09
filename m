Return-Path: <netdev+bounces-133665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0BA996A02
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBDF01C21A76
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6A119340C;
	Wed,  9 Oct 2024 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJ6L0OQU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F041922DD
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476985; cv=none; b=dGdDXbxOMrgfkLDnnm1yDKZGvp+dk33FS7VHsz2y/05ybiSo2sa1K2WTKKIZvRRWV5nTiwER89X/i2meqjz4KhjUpFS5FMpwvpgTuCPEFXV+fcs7qBjbybeaIrnKTKKiihACE/7kz4rF23foGxYwMn32JTPIpwA04lbDZ9X41oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476985; c=relaxed/simple;
	bh=RDWTcA0C4pS6XPXuXNfuvVZGZq+z+UegdRV23VHoBME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbsROWBks+JgfX+760CicVKyfw9VVjMG9bTdiY7QnP+gMdxBQ22vmTFBwU3Z8DhtRBzM6xr9++hajjuvVRqk8jqWNIrlpRNiAB5cwndYPIURG6gFWvj/Tr6ApGBwn1OY6tMZqLa6V/6ZNgIZrxZtKHpK68A7a0heKzeir8SkB9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJ6L0OQU; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a995a0fc401so39925366b.2
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 05:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728476982; x=1729081782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QHcTa6pFnbfwV57gYS3BNoyWRv1XxjSoKuszTt9jVFg=;
        b=AJ6L0OQUNIorrogqGhqWaSm+93Q78dHgmhzFcc39fX1nHPN/WSQLNweyX2zlWH5OZx
         GLj2gB8q5JK9pZH35Th0V4r0wpdy+SrqQvGYiLc9bT+RjFAMaZk0DENjSTlVn3DCmPm4
         zRWWnbor86qJKKzP97sU27c08L4QsvrCOrn26o/5xztGoBKKsO0Az76FDST2U+wqAc/d
         xmYbQp0QI3RU6MqUp/dpapANIwXms7uTvaQDi07WZTUo5wOh421U3s/K+WeWYsr9W4qP
         4QgisOo2X6iJxqkjeiMNukaO4mhXcUVODffQ9dIHz4tCEd501Sp5N/G/lcIjppkD2btH
         qwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728476982; x=1729081782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHcTa6pFnbfwV57gYS3BNoyWRv1XxjSoKuszTt9jVFg=;
        b=CzyqLpyAWz0MWpPOd94fI9M5lOGjZS9Ozv7UVo/pam/r1phDp6b0jCjEud9WR3AOVe
         EERFfxGpqdmahw7fRbMHt+tIyW95CoBRvdT2ZyBEnbv3ALWa9YbbrdOAe0dTxMAv6TN0
         JOuQ0wc870t1yyFEYoH2ii0O+p/kBTmbkh7tXnYi5Q+oLQnsTn+qwbQDXAyvDA6b7ocR
         3FcU8zt+Ot2CAsF8kSm2i1W+nHNmzStp7ir7mfEaSF+W4SntpmqdCkzmxyAv/rzaF6cS
         vwFMzrGOU/w2gun3XoNXhgL2shVILejOhQkbJkRm+OlKeP6kWdtNbR9lMxWa8NsKynh0
         xkTw==
X-Forwarded-Encrypted: i=1; AJvYcCVtAANjjh8mQakKexc/50i6ia/MqSEQO9Dy07t/wZll0Ovmk5ocQzqptKoye9rQCCXlxBCavNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNut3AhxLPHXs//2IqLHgmp3L1T53kY2c53+chm468051NPAgc
	F479Q/MhA7xRyxzJwVs5moTrenlESTZE5Aj1SESCKeHr83Yn+3Ht
X-Google-Smtp-Source: AGHT+IHoE3MwjYaW6e5GUlZm+VwhOmElWx5WIJ84OBea2Yrz0QoPTCwnWX5gW31zD/RhmT13Bp58zA==
X-Received: by 2002:a17:906:6a15:b0:a99:61c5:3d0a with SMTP id a640c23a62f3a-a998d107a31mr88490066b.1.1728476981400;
        Wed, 09 Oct 2024 05:29:41 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e5bb23bsm652201266b.34.2024.10.09.05.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 05:29:40 -0700 (PDT)
Date: Wed, 9 Oct 2024 15:29:38 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/3] net: phylink: remove "using_mac_select_pcs"
Message-ID: <20241009122938.qmrq6csapdghwry3@skbuf>
References: <ZwVEjCFsrxYuaJGz@shell.armlinux.org.uk>
 <E1syBPE-006Unh-TL@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1syBPE-006Unh-TL@rmk-PC.armlinux.org.uk>

On Tue, Oct 08, 2024 at 03:41:44PM +0100, Russell King (Oracle) wrote:
> With DSA's implementation of the mac_select_pcs() method removed, we
> can now remove the detection of mac_select_pcs() implementation.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/phy/phylink.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 4309317de3d1..8f86599d3d78 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -79,7 +79,6 @@ struct phylink {
>  	unsigned int pcs_state;
>  
>  	bool mac_link_dropped;
> -	bool using_mac_select_pcs;
>  
>  	struct sfp_bus *sfp_bus;
>  	bool sfp_may_have_phy;
> @@ -661,12 +660,12 @@ static int phylink_validate_mac_and_pcs(struct phylink *pl,
>  	int ret;
>  
>  	/* Get the PCS for this interface mode */
> -	if (pl->using_mac_select_pcs) {
> +	if (pl->mac_ops->mac_select_pcs) {
>  		pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
>  		if (IS_ERR(pcs))
>  			return PTR_ERR(pcs);
>  	} else {
> -		pcs = pl->pcs;
> +		pcs = NULL;

The assignment from the "else" branch could have been folded into the
variable initialization.

Also, maybe a word in the commit message would be good about why the
"pcs = pl->pcs" line became "pcs = NULL". I get the impression that
these are 2 logical changes in one patch. This second aspect I'm
highlighting seems to be cleaning up the last remnants of phylink_set_pcs().
Since all phylink users have been converted to mac_select_pcs(), there's
no other possible value for "pl->pcs" than NULL if "using_mac_select_pcs"
is true.

I'm not 100% sure that this is the case, but cross-checking with the git
history, it seems to be the case. Commit 1054457006d4 ("net: phy:
phylink: fix DSA mac_select_pcs() introduction") was merged on Feb 21,2022,
and commit a5081bad2eac ("net: phylink: remove phylink_set_pcs()") on
Feb 26. So it seems plausible that this fixup could have been made as
soon as Feb 26, 2022. Please confirm.

>  	}
>  
>  	if (pcs) {

