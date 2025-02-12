Return-Path: <netdev+bounces-165679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5712CA32FDD
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 20:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCD6168E87
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 19:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7AE1FF1DA;
	Wed, 12 Feb 2025 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCRsPeDi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ED61FECA2;
	Wed, 12 Feb 2025 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739389000; cv=none; b=VtwkvdNjYsxanVscSPxU3ApmpQB4xCCZ+Es+79cQdzpGWgmlgiFWfb4fmU5pfxyPIQBxuJusfFffhshuTicWMxKnh46isQ8LR0oPWqFjycatLvWosALRvALeTybKTJJ0PEbTdax0UkKThSLOUa2RMaIdZzwOyohAuNWF6uEKALY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739389000; c=relaxed/simple;
	bh=//U/YEf4GTn80X/Yqah8NCCGVUUA/kgq9Vwzb7fid1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLpkGR6nfiwpfllwcg+QG40gyHyGeCudUwD1fIqvUaO93QjqnJH3B7bYd5gLIA6vGOFIf/rLgLYt3246/Au/uKsMJDRVEFIAAn+V2Z73HS4Ve+K/ta5XAeCp5uvF5gFh5424vVrELVoIM1WCF5655coT73GAErJ4jiBLS/retvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCRsPeDi; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7d583d2afso223171666b.0;
        Wed, 12 Feb 2025 11:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739388997; x=1739993797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xrkhdUFQwi4/lCMpN9Y5pmHU3syxsdq4GG+NHqwz2EU=;
        b=fCRsPeDidHSXbqfT9QA+RcXH+KwqJAso69utADADSTp9QNzyvASU+rdazj/J3j6uEb
         E0xpDT1nWwpmgeyhmT/UPDQpnQRVS83/ydc7Pua5qspkKBXkR1bbInGupJrnBe6KMw8h
         NPCnx1RLu3ygXm8ZggKAIFTeqT/LE+dmwtmdXrNEkMhZB+pZaoWimGLX5jPsQFO340Ku
         oEtx8niqK+xfyV5BXldslLRKZkiLYJVIp/ec7hEBEskRhTkHMR74uUbowGiPkpqThjMU
         oyGqDFrl6Ha9fHnkFV30jdDlcbtktE4ayhWG5qh5CXx/GWBAql/9bhswrTsuTOiUI0Az
         FKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739388997; x=1739993797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrkhdUFQwi4/lCMpN9Y5pmHU3syxsdq4GG+NHqwz2EU=;
        b=lojY54psPx5zg2CWrpJxZxLVdZQq2VDAtx6n3j5lnYctPh22jx+7ua2UWvVe7DsoXb
         vbSkJO+D8VgViokKFDTObL+L1TFRiHMaxSSyZnZrN2PlHrJjUk9iKXhj+Ly+XKrx3t+Z
         xpTt3cZVXptridhTtI5TKInUTB6oq47+HjkD0+4WZiIjVlxg0qVUOTeRuCZkYiu+KR82
         vU8iNK/VL/ECRNZKSgUCFS/1fmkQWK3xO47enJ1npJHySIIvdESTAuhyxhJfDLVMOckq
         gJzGJX2jb9I4cyPxLgyxfyZeykQg646TnVksBRnCjzWOpH31B+2rVOCB8YFBpZzVILr6
         ncVg==
X-Forwarded-Encrypted: i=1; AJvYcCUAjf7CGE7GzyAIXTWIE9mvfU40iGYJ33sCXNVHhw4mU1wVIaWw+OinMLnBbm1unp8vulSJdY+11j6qe7MW@vger.kernel.org, AJvYcCVZ01jKD4d1npidL38+9+jetTLWoTQvXKUp3qWDBu50q2tlZJaYsG2JFz9IdcK1HMeepGDHXk6C1Lq8@vger.kernel.org, AJvYcCWi++cTvAtFABzNX1fWyViEN8QyO8MbW04yGJ9wwIZU3N9y0jDNsPHOFWy64kX1AW8pMG13xgiR@vger.kernel.org
X-Gm-Message-State: AOJu0YzD/2XgYg908mJE7STdTDK5BI5NxvQXS1kLmdKT5wzrTdIuvTwP
	VOWtZ6w+TwaavvmpiLKvvUwUY4b8FjBxh4lK2aJrRaVeXCg5tSBN
X-Gm-Gg: ASbGncvbDol0OSjfzYguG8C/TUJPugWhguHjzyQlucEuIsFeRVZlD53yh6ZBWQLjFiv
	YZEWsBlmKbIxr2CoXwZ8A5VARXVXkFuv10pBjzCVoRF3bd33eD7F3XdIQFXVevy674WXjrPJYML
	jIqKHEDDXngQcqh9b6qDvK6Vvad7gWCOAygxbWidQqreIDGUh3vqv3hEGCUZI95lrjxMfSNjyuf
	EvsQpG7ASHVyYRraiO88MZdVZD1rpP/zNIqsZihTGn03pVVmmfEuGwJamvmIH300ro5A/JejxWb
	B4ZDeP5wXlo9
X-Google-Smtp-Source: AGHT+IGhGb+HhZEKckwfH7aJO5Cb7saEPI0QiOmLhZBlsGU0FWR3LegRggw8s/DtIXNo0IZ0iXpWPg==
X-Received: by 2002:a17:907:7f8c:b0:ab3:a18e:c8b6 with SMTP id a640c23a62f3a-aba5145d897mr12342666b.10.1739388996714;
        Wed, 12 Feb 2025 11:36:36 -0800 (PST)
Received: from debian ([2a00:79c0:659:fd00:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7b9bfd2c4sm731681366b.43.2025.02.12.11.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 11:36:36 -0800 (PST)
Date: Wed, 12 Feb 2025 20:36:32 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: dimitri.fedrau@liebherr.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/3] net: phy: Add helper for getting tx
 amplitude gain
Message-ID: <20250212193632.GC4383@debian>
References: <20250211-dp83822-tx-swing-v4-0-1e8ebd71ad54@liebherr.com>
 <20250211-dp83822-tx-swing-v4-2-1e8ebd71ad54@liebherr.com>
 <84b5b401-e48b-4328-84b2-f795c1404630@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84b5b401-e48b-4328-84b2-f795c1404630@lunn.ch>

Am Wed, Feb 12, 2025 at 02:15:08PM +0100 schrieb Andrew Lunn:
> > @@ -3133,12 +3126,12 @@ static int phy_get_int_delay_property(struct device *dev, const char *name)
> >  s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
> >  			   const int *delay_values, int size, bool is_rx)
> >  {
> > -	s32 delay;
> > -	int i;
> > +	u32 delay;
> > +	int i, ret;
> 
> Networking uses reverse christmass tree. So you need to sort these two
> longest first.
>
Will fix it.

> > +int phy_get_tx_amplitude_gain(struct phy_device *phydev, struct device *dev,
> > +			      enum ethtool_link_mode_bit_indices linkmode,
> > +			      u32 *val)
> 
> Since this is an exported symbol, it would be nice to have some
> kerneldoc for it.
>
Yes.

> > +{
> > +	switch (linkmode) {
> > +	case ETHTOOL_LINK_MODE_100baseT_Full_BIT:
> > +		return phy_get_u32_property(dev,
> > +					    "tx-amplitude-100base-tx-percent",
> > +					    val);
> 
> So no handling of the default value here. This would be the logical
> place to have the 100 if the value is not in device tree.
> 
I will get rid of the default value.

> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +EXPORT_SYMBOL(phy_get_tx_amplitude_gain);
> 
> I would prefer EXPORT_SYMBOL_GPL, but up to you.
>
Ok.

Best regards,
Dimitri Fedrau

