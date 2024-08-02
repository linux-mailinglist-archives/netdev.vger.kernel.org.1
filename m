Return-Path: <netdev+bounces-115410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3637F946482
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 22:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684001C2120E
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 20:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C12A7173C;
	Fri,  2 Aug 2024 20:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRucuQRE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD9B7404E;
	Fri,  2 Aug 2024 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722631242; cv=none; b=mL0lR+/lGgZrpj0ihPzkPfv5pLb+xCYy5CW+JaY8IzXm7Nnc3PM0qPZIvLiZioAk+hj0z2Lyh0nAJ6+31xYx+qn+4dlYCdfU9Oik/JLyZygV5p7LM/C/LGtLC/ows/UDprYqfq1sD229Icr1AhyHNYwGDqrrayrrj6uAmHB8AXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722631242; c=relaxed/simple;
	bh=RnizNcBwSuHwX6fqzn4/5AvMydA1gJ+LrC6OpBuAXi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKOfRzf8a7p56DpKZSEnA0RPGf/wXbyGYO4uAfrcrCGyZ+uM6IVOGI8evFIrZf3eMRhT6EiDh/ChGvwMrKQcBcvLlrNlqoZRplwlxt4jXBfjqcizjnja+eQmuatpuMDZ+pa/iSqxE4BTeFC22hr8f6DnIqkFl96sl7NDIT9urdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRucuQRE; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e03caab48a2so3142008276.1;
        Fri, 02 Aug 2024 13:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722631239; x=1723236039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnizNcBwSuHwX6fqzn4/5AvMydA1gJ+LrC6OpBuAXi8=;
        b=fRucuQREwXXByzRHG6Kfm6uzKcLvKGRsDl+ZYblYNoD0s40ISzrUs9raDaLcYJdie9
         UP8PIEaQW1d71PyAh3fQpOh5GQwrUDu1Y60cJ8+/lUUt3qmUEvW8mwNy+0/KzY0BHEgy
         s1Yj+E8GZrG17CiBZ5l8ty8gGqjNsHgyV1lAytDeszz/wx+E1b6mCIQPDZ01MVSRtlqi
         PCfZZCPrp2SvhpvFpLJo08Tdildn5VZbUspRgXHmYyr9GwyGy7iGNZGFn52RSRapFgS4
         JlKGuGnaBSzylPLKdqNxDaKWPgcR87Q8CVE3BSEtcjYJL2Pm70LGST4r1hx6Nl+91RRP
         rSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722631239; x=1723236039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnizNcBwSuHwX6fqzn4/5AvMydA1gJ+LrC6OpBuAXi8=;
        b=LsV0pwAJDhQCx/tmHUvjZwCIYO1SBpVKgK0UUD8gYpEysd9Ve2S6mGL3f+3riI9Kpx
         hhss6vhFq9D2nJt8pRZ8w198WZGJ9g7wrFGpMY0NsiQstK1Pivy0aHTmj7w6HtUDkRyq
         N4IMWcrYXt3z7u35nukhaR6JAdRlwGyZL58jDw5ff0naGizEEEtUQoJ2xtNXwNFq354K
         ORtPqQNb2bsw6gE/oxryOWwynymhxUg5rs7EvEbHDxJWEArszrmaetiVkKtbWZVFJk1q
         ZNUUjKM5E1IRsGk6hY1sgTJKpO1LbUlk5iYzDT+N0TKbIMPPu3LZv+0f4GFY0fEAPmy7
         4lPA==
X-Forwarded-Encrypted: i=1; AJvYcCVmaui0AZ+FBtKA/FUNo9uY/NqP+zmqt9gHq4IvDGc7cG2ISaRMlFG2EMStTq1ItIsjXfKNIb/t4x4q+9jS/O2PcOeiIZyvhUW4gYME
X-Gm-Message-State: AOJu0Ywz8RcCRmFPlGTrsTzhD/nfGFcNztE7yuR24oNvl1bwoEpAg417
	pB0dCGD1ol7GSD2n6ow6ojt48dkHswUes1x5mS0LcpW7dHn7uLEq7O4DKkWSC0QFsFjIBI/i3Qu
	QBCCv9xl4lSNFABHGkigVcZNW5LM=
X-Google-Smtp-Source: AGHT+IEJbgfNkAW0ZGvEDBSbfT3vDSkWsl9xTUObd40GABowG5vE2n5zoOfzk3yc0yyYhcRbmLeAFGiSIW/FtXLXHeE=
X-Received: by 2002:a25:8249:0:b0:e0b:e13c:38c2 with SMTP id
 3f1490d57ef6-e0be13c3b69mr3745881276.20.1722631239502; Fri, 02 Aug 2024
 13:40:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802080403.739509-1-paweldembicki@gmail.com>
 <20240802080403.739509-7-paweldembicki@gmail.com> <ZqzZH4QB5NhPYDF3@shell.armlinux.org.uk>
In-Reply-To: <ZqzZH4QB5NhPYDF3@shell.armlinux.org.uk>
From: =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date: Fri, 2 Aug 2024 22:40:28 +0200
Message-ID: <CAJN1KkxUNX_U1ib3Z-CVA8xFZ3mA6CC43JUVKYYOZT-Xgb2fVQ@mail.gmail.com>
Subject: Re: [PATCH net 6/6] net: phy: vitesse: repair vsc73xx autonegotiation
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

pt., 2 sie 2024 o 15:03 Russell King (Oracle) <linux@armlinux.org.uk>
napisa=C5=82(a):
>
> On Fri, Aug 02, 2024 at 10:04:03AM +0200, Pawel Dembicki wrote:
> > When the vsc73xx mdio bus work properly, the generic autonegotiation
> > configuration works well.
> >
> > Vsc73xx have auto MDI-X disabled by default in forced mode. This commit
> > enables it.
>
> Why not implement proper MDI(-X) configuration support so that the user
> can configure it as desired?
>

This approach is a copy of an idea from other PHYs in the 'vitesse' driver.
I can implement MDI(-X) configuration and status.
But the question is: Should I do it in this patch series or send a
separate patch to net-next after this series gets merged?

