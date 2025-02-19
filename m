Return-Path: <netdev+bounces-167682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B324A3BC21
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 11:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DEE33B3D04
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 10:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFF71DE891;
	Wed, 19 Feb 2025 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhjK3uw7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057B61D5142;
	Wed, 19 Feb 2025 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962504; cv=none; b=eXrTDEQA2DotkFtpSmyLc30ebZW1I0iynR9v1gLRkdw4lzuS5lvNj95ziIhU/46oR+ArV7pUKJ6C9SFDdWXw5LUdrGb4jf074wqRYCPiMEcRgW+ZBcg6KDBIZCCKJZoqX9+MNgyVZ2KyqT5ulYKqbRnr4wkKLu2nkZ7ejwob7FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962504; c=relaxed/simple;
	bh=f2wGNXtYwMeXQW+P/MGlrJEmmHcHxmjrzIIhWnOeqRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+raH+BOYdDEoQ4vR0HxNV9lYlxR8XVj/YbOxsQgneTGBg1P4CDwKsqcmQWijMuDN4Y3QQIwpjjzCi/+l0+bhvs+zoiVTCwOZ3wnat5nz+pIg90af0jD8HBS7Djmjn4Vkw4xQ4CSn/yvJyxf2+JFlV+AN2/M1gF6zXMDAuOxXb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhjK3uw7; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso998063766b.1;
        Wed, 19 Feb 2025 02:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739962501; x=1740567301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ys4aX0kZ2RnwhLm0CFrbF54OKLgPiywuwcJ3LXl47U=;
        b=HhjK3uw7sICG5Z9BiwcddXkosPYcLsRlDUIHv9JN3OKAtWM87kwC/fmItENSSm0KyZ
         sfj5GtyNvLZalAN16Zm/YL9zgzFrB7zBdtS5Hc5ayTA+2gqhIlQoeyWs1fdhl6ZQxQ2B
         5JWUca9rGysKLwHCIXh1icNOLSlcCVa8f17Bx9ot0IBWdhjTbkjUgT3uCKtCA03Ie2oA
         9PXwwlGtb0vV2k9fgDMafAGRwKsgn6xrp21w+Nhg6kxJ3yXiyqrDYNBnT+XJPgzTrUM3
         K4zAlXtLTjd31IRNCFMJ1Mo0fiSILsOvsbCURzXXEbcPZsUhnzvf2YKACu0+hJ1N2Jv0
         3VzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739962501; x=1740567301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ys4aX0kZ2RnwhLm0CFrbF54OKLgPiywuwcJ3LXl47U=;
        b=V/AtewuNSSpO/21h73tLuyFmMCnUjSA/dMoFeoGBeiBrGrOQ9qH3oUhyV75VpS3kPG
         V2OOf9R7tLD19S/UMTmRq5Ly/a3NqLNM3zDSjsrGN1WoKEfBnYC43TaLwueIUjlsC4jG
         DPpJZE+JwAkSGXMiJEA1eSae/o4f99JTNea0GhvNPErWIT7GtK19Aej8ZtTaNW/BQw6t
         X5Oxdn/EArJ8SpruZcTLWQkbCFo//4z10GBNWcePfcNMb9jGyxrLW3wzJKQoD21O+RJ0
         6eDhVTIAySpyJXcbO+OM9SKK1HrhToslxAutv24rr5rXInBQnYAhv6KHZiXKFkfBKo2B
         QtUA==
X-Forwarded-Encrypted: i=1; AJvYcCWKcutmnyDrYbinglvIIQ3GSbLCCNIkHe5hj2sBH6TlfUR9ssb6HqOmGUzgObDAI5RoRpcsXHhzcAKt54E=@vger.kernel.org, AJvYcCXEzHjOVepZDk7za2ngmaSNlWLRzz2OFC8pQXI7s2RuErH0ynBvAFB3A+wPfT7I8UHf+8fcPBjH@vger.kernel.org
X-Gm-Message-State: AOJu0YySfsrLnzT7OOk22wn/niOUiJpmJhcMNjn2iccM+tXCdreyIIqx
	ihsQmAMNgd+8JTyP8osfFfsa9M76zzQDkF3CnLCBmUxN9obfG5lD
X-Gm-Gg: ASbGncu2ivaCAbTYtJDbrQqU6ll36fa097UVZ/cyzBGkHppeIWgfMCFzqOsH79zcb/c
	XAVhLBQKQJcOismfJr2hrBh9BYWLCnwHnh/1wtJUeCsYNIrbluL0VKMbmUp9KTYPkjGSJHlyAkY
	Cq86LHoTzxn5bBCXSm1pXfXRQ3shlz61E19A9ubSx8QnmK5uTnL4X1j3OTHx61L7DV0xZBkAIZC
	lxMYASj9zRP5U93w6DcPhI383Y80Xc44fH2IMGnCpALBykPiqcK1ta7HvVdGcOgQfiVyCorCk/H
	4xL6fzF0G1tI
X-Google-Smtp-Source: AGHT+IGxe3suuHUwkDRetmVPIAsBXxfrQKwYy1X6Fs09X1gAUcHXLXz83wizKLs830ep2DMusTAdMw==
X-Received: by 2002:a17:907:c13:b0:aa6:9624:78f7 with SMTP id a640c23a62f3a-abbcccf9ffemr268783166b.17.1739962500889;
        Wed, 19 Feb 2025 02:55:00 -0800 (PST)
Received: from debian ([2a00:79c0:646:8200:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba0ab1457sm513570166b.73.2025.02.19.02.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 02:55:00 -0800 (PST)
Date: Wed, 19 Feb 2025 11:54:58 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: phy: marvell-88q2xxx: Prevent reading
 temperature with asserted reset
Message-ID: <20250219105458.GD3888@debian>
References: <20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-0-999a304c8a11@gmail.com>
 <20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-2-999a304c8a11@gmail.com>
 <Z7V6XZ7VRTkYNi2G@eichest-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7V6XZ7VRTkYNi2G@eichest-laptop>

Hi Stefan,

Am Wed, Feb 19, 2025 at 07:29:49AM +0100 schrieb Stefan Eichenberger:
> Hi Dimitri,
> 
> On Tue, Feb 18, 2025 at 07:33:10PM +0100, Dimitri Fedrau wrote:
> > If the PHYs reset is asserted it returns 0xffff for any read operation.
> > Prevent reading the temperature in this case and return with an I/O error.
> > Write operations are ignored by the device.
> > 
> > Fixes: a197004cf3c2 ("net: phy: marvell-88q2xxx: Fix temperature measurement with reset-gpios")
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > ---
> >  drivers/net/phy/marvell-88q2xxx.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> > index 30d71bfc365597d77c34c48f05390db9d63c4af4..c1ae27057ee34feacb31c2e3c40b2b1769596408 100644
> > --- a/drivers/net/phy/marvell-88q2xxx.c
> > +++ b/drivers/net/phy/marvell-88q2xxx.c
> > @@ -647,6 +647,12 @@ static int mv88q2xxx_hwmon_read(struct device *dev,
> >  	struct phy_device *phydev = dev_get_drvdata(dev);
> >  	int ret;
> >  
> > +	/* If the PHYs reset is asserted it returns 0xffff for any read
> > +	 * operation. Return with an I/O error in this case.
> > +	 */
> > +	if (phydev->mdio.reset_state == 1)
> > +		return -EIO;
> > +
> >  	switch (attr) {
> >  	case hwmon_temp_input:
> >  		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
> > 
> 
> It makes sense to me. However, aren't most phys that allow reading
> sensors over MDIO affected by this issue? I couldn't find anything
> similar, are they ignoring that use-case?
>
Yes, you are right, but only if the PHYs hard reset is controlled with
"reset-gpios" or similar. I didn't find anything about it too.

Best regards,
Dimitri Fedrau

