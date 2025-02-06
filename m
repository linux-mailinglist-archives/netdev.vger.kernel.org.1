Return-Path: <netdev+bounces-163458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2936AA2A4D7
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 10:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71A13A3221
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E64E226539;
	Thu,  6 Feb 2025 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYIgfyov"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953C422652D;
	Thu,  6 Feb 2025 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834827; cv=none; b=bGZHXw3ooPx8JFhewDNwriLG8xfHsMtcZtM2ZVegIvZ2fkgx0SiZT+E2SckxlzpjqdM/z0PAlTA2UsIGRpHewae2/+eny9yMC6gPZmnMv0KxE+ybdFM2HoQWHzTmfCrSP2fqhSyGOoY5EjfLwREA1rc6kUfrzLYZmRVfxVojh8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834827; c=relaxed/simple;
	bh=5HaMqH6ACPaZZ+jYPKdOVGdO5CJDeUWtDjJRtpOQNSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJEIpkKf2BdUMuRJ7MFxcDDYOLG500WGvdKqljJZ9hH2ThiMyurBThXkWMCnRmoIRAOxya6x8xfu4ZEBEnwTBQfV1nMxDkdHO2aIxmu3+/Ltp1/RLRqdWIPoP5yJ4bJZoUdPgaC5RUYZLIAjivEmkiEZQ1Jh/ZOdSHnh2ai0sxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYIgfyov; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso4272095e9.0;
        Thu, 06 Feb 2025 01:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738834824; x=1739439624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QFKBSoOVGRBtSVzPGty71l+771OyWvjkU/yq+7DfWR4=;
        b=dYIgfyovCiD/JMawQ/hnenbVlah/uWGR3rwxz8eNepX5rIl7wJVWtXwCXeuctYyjJH
         43r4e8DZo3PmoOaIF1GGGEor4nOtii01iolE7WCO7b1br7tAzYj1d3kghl4w7D+vbdnB
         sPChPNfcs8G63GDmg47082o3nAHDEuuafap8m6w+fY3p4rfTBbXNnkCZzMO1Ns8PlKXV
         iDeVH3GdqQXWbZVoNn2ZSpfY/TOCM78m4cnfT44FJ5ARwA9lyIHWIRK76DvOkKbd7S5R
         9ukCQw6VknVXTL2fst7iimXhNWxxN6EXlrsDCwmklFFtDAi8Pu4TARTtnZnJH921Z9+p
         OTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738834824; x=1739439624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFKBSoOVGRBtSVzPGty71l+771OyWvjkU/yq+7DfWR4=;
        b=rq7az9lJ5elFLeUo5xpEbm8rhFlfzZGRhqc96/yKyNUsN6IuvkZBV51/0/WQI3le7n
         AEOZemE6+jbrkpJLFVp029MFygcBGyDX6cWhEBjcRAcG7yCIJkHe0tieKRS8ZjycyUBz
         aE6iYJjwY59iswQ9GNp8SStIYzpiwx9Nsezv4WsB1yGqG87W/H6NKZWf1pd7EH5HXnf5
         e8Luw5i3zA1MjlELFaZwjPZxGxN0M2omYHe1t3kTwPjk2feHHXmxZqoNwynrQgitN2bV
         /GS+0ruf661kVRFCNJh6hA+SH8xLUy2oJkzQOj8fCUtIowQzD1g2eBU12/FVuLl/EUcU
         Y2BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp3FOIBKn0JbzEN2SQKdsHhMvsoGjiDJfR+CpnJWI6CdynSaScOltqr/oih+nCpuNuw+0m4+3cKpRC@vger.kernel.org, AJvYcCWOnhF/2G5ednQg3mJ6ZOWcRHJp7ZI+XpJWJg3JMPpMvkoiAeMWTgHtk5Eim/SDVsoHkwnJvkLA@vger.kernel.org, AJvYcCX2DfWGrB8DVjnxqIWEzoiNp16FHu8M63QOZr27DEMDFC6cFVlUDAtzuZsVwcObLIqZgK7eqn5H/MSE5oyR@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr6UsqmOPUk3UwAdSG2VG6LGIV+E41giQC10YceA+AI8u1BZWX
	ScdZQlpyV5huevhwhd2pQctLoBG14TwXYMXziR5Pm3EX9PEORMmw
X-Gm-Gg: ASbGncvywmdthgXxyQq+OAadBH+0+0KtBaX6/bHbC4fgxBsL9Eiu5alvE4Rdzc7PLYi
	QsLpOMvF0vbtKFCORt2oiSUiXkX/rZZHwe9KsYNScwxlc4GtX4ghWi1UR/A98kyuhtnhWa4nsmj
	zcHBXMHMDaHLRVAVQf/j06HJwv3a0E2LNh13siS/Ks0XfM1v5TVD9LXU5MF3nBBzYDyyHz45Szj
	PsLlgx79YlVRmmBWmI7+/TBPt/psS8pzLGZZOWJaDXVLOhUarhMJtGo2z8emDCcJUXcg8i780/t
	5LlykE3MA/Nf
X-Google-Smtp-Source: AGHT+IGyKNrq+Ez6Do5rq2gjjPAYOznaKQ67YtgOLU60pod/oeG3KF49eKfnrIrBCjWw68ieGkh4Og==
X-Received: by 2002:a05:600c:3112:b0:438:ad4d:cf09 with SMTP id 5b1f17b1804b1-4390d43542fmr47180615e9.9.1738834823682;
        Thu, 06 Feb 2025 01:40:23 -0800 (PST)
Received: from debian ([2a00:79c0:61a:4600:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d964c7csm48555715e9.17.2025.02.06.01.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 01:40:22 -0800 (PST)
Date: Thu, 6 Feb 2025 10:40:20 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	dimitri.fedrau@liebherr.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] net: phy: Add helper for getting tx
 amplitude gain
Message-ID: <20250206094020.GA4585@debian>
References: <20250204-dp83822-tx-swing-v3-0-9798e96500d9@liebherr.com>
 <20250204-dp83822-tx-swing-v3-2-9798e96500d9@liebherr.com>
 <Z6JUbW72_CqCY9Zq@shell.armlinux.org.uk>
 <20250205052218.GC3831@debian>
 <b28755b0-9104-4295-8cd3-508818445a4b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b28755b0-9104-4295-8cd3-508818445a4b@lunn.ch>

Am Wed, Feb 05, 2025 at 06:08:47PM +0100 schrieb Andrew Lunn:
> On Wed, Feb 05, 2025 at 06:22:18AM +0100, Dimitri Fedrau wrote:
> > Am Tue, Feb 04, 2025 at 05:54:53PM +0000 schrieb Russell King (Oracle):
> > > On Tue, Feb 04, 2025 at 02:09:16PM +0100, Dimitri Fedrau via B4 Relay wrote:
> > > >  #if IS_ENABLED(CONFIG_OF_MDIO)
> > > > -static int phy_get_int_delay_property(struct device *dev, const char *name)
> > > > +static int phy_get_u32_property(struct device *dev, const char *name)
> > > >  {
> > > >  	s32 int_delay;
> > > >  	int ret;
> > > > @@ -3108,7 +3108,7 @@ static int phy_get_int_delay_property(struct device *dev, const char *name)
> > > >  	return int_delay;
> > > 
> > > Hmm. You're changing the name of this function from "int" to "u32", yet
> > > it still returns "int".
> > >
> > 
> > I just wanted to reuse code for retrieving the u32, I found
> > phy_get_int_delay_property and renamed it. But the renaming from "int"
> > to "u32" is wrong as you outlined.
> > 
> > > What range of values are you expecting to be returned by this function?
> > > If it's the full range of u32 values, then that overlaps with the error
> > > range returned by device_property_read_u32().
> > >
> > 
> > Values are in percent, u8 would already be enough, so it wouldn't
> > overlap with the error range.
> > 
> > > I'm wondering whether it would be better to follow the example set by
> > > these device_* functions, and pass a pointer for the value to them, and
> > > just have the return value indicating success/failure.
> > >
> > 
> > I would prefer this, but this would mean changes in phy_get_internal_delay
> > if we don't want to duplicate code, as phy_get_internal_delay relies on
> > phy_get_int_delay_property and we change function parameters of
> > phy_get_int_delay_property as you described. I would switch from
> > static int phy_get_int_delay_property(struct device *dev, const char *name)
> > to
> > static int phy_get_u32_property(struct device *dev, const char *name, u32 *val)
> > 
> > Do you agree ?
> 
> This looks O.K. You should also rename the local variable int_delay.
> 
> Humm, that function has other issues.
> 
> static int phy_get_int_delay_property(struct device *dev, const char *name)
> {
> 	s32 int_delay;
> 	int ret;
> 
> 	ret = device_property_read_u32(dev, name, &int_delay);
> 	if (ret)
> 		return ret;
> 
> 	return int_delay;
> }
> 
> int_delay should really be a u32. if ret is not an error, there should
> be a range check to ensure int_long actually fits in an s32, otherwise
> -EINVAL, or maybe -ERANGE.
> 
> For delays, we never expect too much more than 2000ps, so no valid DT
> blob should trigger issues here.
> 
I think you mention this because you want to avoid changes in
phy_get_internal_delay because this would lead to changes in other
drivers too. Is it worth fixing this ? Then we didn't have to workaround by
checking if int_long actually fits in an s32.

Best regards,
Dimitri Fedrau

