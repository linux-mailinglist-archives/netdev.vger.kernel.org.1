Return-Path: <netdev+bounces-150633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FC99EB073
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 13:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D91E169A66
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 12:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD9A1A2643;
	Tue, 10 Dec 2024 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFRAl5Cg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9651A262A;
	Tue, 10 Dec 2024 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832398; cv=none; b=ID0xf05YfI0fU7SYyJi3UkFe15Cb+2u09yGD881eAZ4hFn1mbPFuvL2OuZeJVt2dsa8XUyjIuFxrgmoTRNq+InkhsyMBGK0B5KWxYfgxGxHynSzwyaEuEcrbJ/dhmsHCmwxPtSc48379ODe7RWWpfC8IYA3CJf3Y6l8KTzsdMSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832398; c=relaxed/simple;
	bh=tac7FU1HS14XQp9BMuUMwuSzdZ33pnoQf7dmpahU5IM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jhb3mLawgXTcIaSWJ72P1DKF+lnlKwKsauN7Bt9j+4GiGv9y1Dqn/ViayF6dUG0BpL52i17Zb0ZChL9zMkNlP1cMGgUMRNamFbBnXPsvc3e8ZGFxDXr55GrYR8HvJjqSvo4RNooNCX68pdrUfo1DRk8cZEoOs7iFeeUV2bVXC5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFRAl5Cg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434f74e59c7so23979415e9.3;
        Tue, 10 Dec 2024 04:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733832395; x=1734437195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=46aYL8Qujac4/4V9g8K6BMoI6Lwj7kmEE7LxrwnxQWE=;
        b=DFRAl5Cgv+dEMJGLYK7Cex7eXQw5NnfMpX4ZOkkf2cAa3vwxw/Hcg0RPhZ4hb4y9YZ
         Z5yJUtqF52wcPImGfMULE4rL4RfToitKywOZrCeTvXfXnYQl+mo7XJORsDPHyV+J8LZv
         Q/tAI/QZ3Sf5ttuEo/uQUQ6yfFdsfN2f2vZC/PZ+9YdpCl9w6q3QL5KBkgtF8d0ysuPI
         8Lk+TouRZmwq1oSkvxUFMynRaKbJfwz91fjE1+G9WT0zVdHsv3q5BCFor9S+4WaJv4jh
         LZef/pZeoVGrZCDKiI1okC2Sj8wZI9po6dD86dyTH4hRsk0SO+IJj5Hdi6CrIkWCmkst
         BnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733832395; x=1734437195;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46aYL8Qujac4/4V9g8K6BMoI6Lwj7kmEE7LxrwnxQWE=;
        b=u9e7HIjruaIdjn+IHGqoATTpWqF64Q6sHP3a1hA7eSBIqknMX5eJTONGpcxluZoTeQ
         oKzqQJI/UH8nak7xBVmTEMUH8k+Tob4WyT1U/lR/m8HFUjr76MFWxXnCjnnpfR96YtjY
         CMw+vvJ7jgbFAHC5EkunnRFsB1DKXMaXJzAnf4L2o94oOslUmD8JBobqSfSyddhoUGMy
         ZqKWfZc5E9z4m17aJ+e9h9lQtPihSTiCOy+fuTRfUCyAoBzNwNf5GH2rj92Ir/IDIAKz
         Wco8v8sjGWiCD1/RCjarEyhyrZPtE0jE6mJSeafYqhWhzI0HHECjBf8YqYVE9JK8eNOl
         SkMA==
X-Forwarded-Encrypted: i=1; AJvYcCUdrSjbcAAWI8F+OmwOAvQINC+9Z5u+bFT6SgCxL2niz0QAfZWU/KbLqnO+b/pA3vWH7vl/WWMF@vger.kernel.org, AJvYcCVWhyYzLU5JGBUB+o67uV6wqw1bBWh/oPyol6O8HuTJxbyLaifLetzPJKZ8s2985+bP/4UkQqzsyzCE3zRc@vger.kernel.org, AJvYcCVzCcB+wbFUn+XtZnwDHoXZDLIqzHEUhQgcTuFyQCeGL/f+x9F2keGg8QEhHY1Perv1ZY5zeGdLYrbv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5CYa56CxiD7G5UbQqVrbAHvwSCR9cOqKZbrbA08eovdlk/6lK
	bs0gk+UC8xUGWfqB0Qovqt1BlDenLuO5nPtnyNBmwpmwX2Vv8k89
X-Gm-Gg: ASbGncvy5N9yhdluTy7YOajmw2Xj6AeokHD4Pvt+WIsKaGcLhBOs3CPDc1mcHA/WM90
	OJOcrWGiVD8+26wOEqZD1UShtoNdOcG3EvIvCf/Se/AZOtkHohpiU+2mhpqtgNKQXJ/QSYHWsJp
	GCQyOmuRi7IyI2EcRNZAE4S8lliGHRbZ1zreEPIIN3zlonjF9eVrJF/aVVIHLGbwdPn5s4r4bty
	SY44KdnJx3WtPqpmI/pDPPZMc9myojLxThdwATFJ09iDwrSXJBamTSUoU5ExFO4g2769E3Zg9SI
	o7PxfLC0PA==
X-Google-Smtp-Source: AGHT+IGpcC8Z7oXmbBOkKTQCK7YHx0j6xObP8W63hf6oMmuAzbltOfilbIotkhxBgXfUoy6iy3NP7Q==
X-Received: by 2002:a05:600c:3b04:b0:434:a706:c0fb with SMTP id 5b1f17b1804b1-434fff3dcfbmr51803755e9.10.1733832395127;
        Tue, 10 Dec 2024 04:06:35 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386394dd379sm8026747f8f.24.2024.12.10.04.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 04:06:34 -0800 (PST)
Message-ID: <67582eca.050a0220.3b9b85.2de4@mx.google.com>
X-Google-Original-Message-ID: <Z1guxUhVSGLHUVUh@Ansuel-XPS.>
Date: Tue, 10 Dec 2024 13:06:29 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v11 6/9] net: mdio: Add Airoha AN8855 Switch
 MDIO Passtrough
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-7-ansuelsmth@gmail.com>
 <5aec4a94-3cea-41a4-8500-71472fae51d4@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5aec4a94-3cea-41a4-8500-71472fae51d4@lunn.ch>

On Tue, Dec 10, 2024 at 02:53:34AM +0100, Andrew Lunn wrote:
> > +static int an855_phy_restore_page(struct an8855_mfd_priv *priv,
> > +				  int phy) __must_hold(&priv->bus->mdio_lock)
> > +{
> > +	/* Check PHY page only for addr shared with switch */
> > +	if (phy != priv->switch_addr)
> > +		return 0;
> > +
> > +	/* Don't restore page if it's not set to switch page */
> > +	if (priv->current_page != FIELD_GET(AN8855_PHY_PAGE,
> > +					    AN8855_PHY_PAGE_EXTENDED_4))
> > +		return 0;
> > +
> > +	/* Restore page to 0, PHY might change page right after but that
> > +	 * will be ignored as it won't be a switch page.
> > +	 */
> > +	return an8855_mii_set_page(priv, phy, AN8855_PHY_PAGE_STANDARD);
> > +}
> 
> I don't really understand what is going on here. Maybe the commit
> message needs expanding, or the function names changing.
> 
> Generally, i would expect a save/restore action. Save the current
> page, swap to the PHY page, do the PHY access, and then restore to the
> saved page.
>

Idea is to save on extra read/write on subsequent write on the same
page.

Idea here is that PHY will receive most of the read (for status
poll) hence in 90% of the time page will be 0.

And switch will receive read/write only on setup or fdb/vlan access on
configuration so it will receive subsequent write on the same page.
(page 4)

PHY might also need to write on page 1 on setup but never on page 4 as
that is reserved for switch.

Making the read/swap/write/restore adds 2 additional operation that can
really be skipped 90% of the time.

Also curret_page cache is indirectly protected by the mdio lock.

So in short this function makes sure PHY for port 0 is configured on the
right page based on the prev page set.

An alternative way might be assume PHY is always on page 0 and any
switch operation save and restore the page.

Hope it's clear now why this is needed. Is this ok or you prefer the
alternative way? 

-- 
	Ansuel

