Return-Path: <netdev+bounces-182105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81134A87DB3
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89861886CE2
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 10:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CF21922E7;
	Mon, 14 Apr 2025 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EulHrz1L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31EA143888;
	Mon, 14 Apr 2025 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744626668; cv=none; b=K7kt6WRLYc8yqPMr4jskgHVKXN7n1hp4pvZs4OMd46zeXnEciuspM1wb8bqcP6GD2iSTNiVlBmk7jD+zlqp8VsLh9n5kTvjW+Cy/1gLPTciB/G2IFu8hqTIWQY5RbAdTMcRzIE4CikyV75iCrNIk/EB81OQyKTnJLroskGLWiYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744626668; c=relaxed/simple;
	bh=2SjgsR5rEurzq/lf6UQlsK0f+M8/wpHfMI0wbCe0tkA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzgEYtHt5YlkY0lEV0jvUyoyQI3R5ys8fnwpbl/62vq25s1vh2OOZJyKiizjgLi9fgfTqZOsDZBt8frTubDjlflpYiDFwR/BHplEK/ZF2Jo2E3Ta91bKgnv5iGYpqiCJ9pNFr+ZsLiNCgo9h6F+d8JS/4kqrW+AKvNzu5ejHYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EulHrz1L; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39ac9aea656so4038408f8f.3;
        Mon, 14 Apr 2025 03:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744626665; x=1745231465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RkKnU5A/U7u3KgcdHnsgsllco8Z2H8MX4iAV2Z12d/k=;
        b=EulHrz1LttJQ1k6S7Cm94biJkg0u4C82BNekq9QSlA7rgPiMa7PMVhKU0uJxBOyPXc
         Vs9Djb5oIs2OSOxkZ4gKGTMflusH3YhjcyRyWa7IYXP8RXs17otXBqtn9WQWJmgTHo8p
         nFxFQ/GLwU3yCEo8lhcFJ/BQDRgfcy/6F4xUfpfzzB0kwM4qTvlPvhP0pr6wNNEs1syw
         3S4IyuTBUxpVskxLigE4GBFZkxxZbxmVwsudKM2iUe+xVnPPzPx+PQospge9e0KCjO3B
         z/K9db+OQF36f75DT108oxdmx+rmwkzhHvqY4wI9ljiu4NDCmG/YLxQeSf78Mz8moJTM
         cy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744626665; x=1745231465;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkKnU5A/U7u3KgcdHnsgsllco8Z2H8MX4iAV2Z12d/k=;
        b=AjJMl5zM5GbUsIX+ISfc+9+e96Oak8JyJaKRwNUw0H9XJTDSwuE4QCpuNRRWEiy+Ag
         16KHvl8cDoXzFKFORXkvOCk1mswm0JMQ334aRILOnny9F95v/r4/Lv8s89+Y3R0BdcIx
         tDSm0pyChIAhhj/gqD3+gyOoea1EBknnEalzY7OBRg3jVs0XYfL1F2R3be1438DIB6m2
         UOKSd/gD5ZC5B3FHVghbmOoSeHt45GpJaQngUVRt7b3/WTTSAfXHetdsB1dTdvm8Fv+X
         BLzPoLsHi2cP15q4GfP5Qg7dKZ9c/Q7WWZn8XZJX2DtRJNj1yujg3YkwmQbmp42M/OuG
         4asQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOWXd6oGMhuSmwtjkrYSFgGSdI/w5Yk4ecMXgAidFfQ3OvNG5fVV5IjmKtfZTVMX2diTki6gP0A9pPVxg=@vger.kernel.org, AJvYcCWpHadm79bdVFZGQVrSjZldkCW9RJxSda69Obty6bJ4wEfHGojeuekukldsVTenrZ1xek6xBrK9@vger.kernel.org
X-Gm-Message-State: AOJu0YzsOdl8izxYZ4Z09IEMzNNQ6JWyA54CwHmPO30R8NY72/pdFIs0
	TQP6jsdX5GhkQ0b5Sos6wZtkmDrxyuJt8OmUfaQa6hBjePpo5R6X
X-Gm-Gg: ASbGnctp1KPLYfiYu3Uj6SF87fi+RnUA/Sh1AaQhoKn2ZZJ4l7f1mbhQ8xHlsJ/pZE8
	eWrT/rHTM0ktqxPaNwmSK57YVJWxs55MxmbwSsDSGanOUwoOtlC8EU24xIebiKmrhYcWUnfHgNT
	Fm19s6cYkOPG78P0eK4LWGCeiBz42qC5sFr+FYpz8isAua4TFopD/SeIWHTzAm5q3VuV5b0VMF1
	qwbf/RKp8w4x9l5soYY82yWhDRmOH9JRr9y0ZCxtYMLzIRX6FRuCQhoz6VqUA+s1RgTGLIVF057
	RuiqSWXGKYrmoyxHdiLmgetWlI7ut3pUkb7d96haL5QXJ4ghOCrNh49lai4iRPJZna5C7gcL8RP
	LSvn3JOI=
X-Google-Smtp-Source: AGHT+IG6w0yoGulXXdUDH1dXp2zNY0ALTwTAcgDO9WvKsGR4WC17K1oIrFY9U+K+ID9KIggoFL2PMg==
X-Received: by 2002:a5d:6d82:0:b0:39c:141a:6c67 with SMTP id ffacd0b85a97d-39eaaed2101mr10246874f8f.45.1744626663402;
        Mon, 14 Apr 2025 03:31:03 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-1-248-72.retail.telecomitalia.it. [87.1.248.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43cce3sm10716010f8f.74.2025.04.14.03.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 03:31:02 -0700 (PDT)
Message-ID: <67fce3e6.df0a0220.12e377.7a1f@mx.google.com>
X-Google-Original-Message-ID: <Z_zj40O2FPE8MxZX@Ansuel-XPS.>
Date: Mon, 14 Apr 2025 12:30:59 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [net-next PATCH v2 2/2] net: phy: mediatek: add Airoha PHY ID to
 SoC driver
References: <20250410100410.348-1-ansuelsmth@gmail.com>
 <20250410100410.348-2-ansuelsmth@gmail.com>
 <20250410190733.GV395307@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410190733.GV395307@horms.kernel.org>

On Thu, Apr 10, 2025 at 08:07:33PM +0100, Simon Horman wrote:
> On Thu, Apr 10, 2025 at 12:04:04PM +0200, Christian Marangi wrote:
> > Airoha AN7581 SoC ship with a Switch based on the MT753x Switch embedded
> > in other SoC like the MT7581 and the MT7988. Similar to these they
> > require configuring some pin to enable LED PHYs.
> > 
> > Add support for the PHY ID for the Airoha embedded Switch and define a
> > simple probe function to toggle these pins. Also fill the LED functions
> > and add dedicated function to define LED polarity.
> > 
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> ...
> 
> > diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
> 
> ...
> 
> > +static int an7581_phy_led_polarity_set(struct phy_device *phydev, int index,
> > +				       unsigned long modes)
> > +{
> > +	u32 mode;
> > +	u16 val;
> > +
> > +	if (index >= MTK_PHY_MAX_LEDS)
> > +		return -EINVAL;
> > +
> > +	for_each_set_bit(mode, &modes, __PHY_LED_MODES_NUM) {
> > +		switch (mode) {
> > +		case PHY_LED_ACTIVE_LOW:
> > +			val = MTK_PHY_LED_ON_POLARITY;
> > +			break;
> > +		case PHY_LED_ACTIVE_HIGH:
> > +			val = 0;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	return phy_modify_mmd(phydev, MDIO_MMD_VEND2, index ?
> > +			      MTK_PHY_LED1_ON_CTRL : MTK_PHY_LED0_ON_CTRL,
> > +			      MTK_PHY_LED_ON_POLARITY, val);
> 
> Hi Christian,
> 
> Perhaps this cannot occur in practice, but if the for_each_set_bit
> loop iterates zero times then val will be used uninitialised here.
> 
> Flagged by Smatch.
> 
> > +}
> 
> ...

Almost impossible but yes I will post a follow-up patch fixing this!

-- 
	Ansuel

