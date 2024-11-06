Return-Path: <netdev+bounces-142477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A85309BF4C7
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 19:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AAF6284255
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AC92076C8;
	Wed,  6 Nov 2024 18:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C80fcSta"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A4E8C11;
	Wed,  6 Nov 2024 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916257; cv=none; b=M7qKWke2VcSJmVp1T51RJky0ZFHqjHPVoxildrjVrOjoPC+O4tpQdaLARvjQmmmEojK4iY8X1vO0aljUcznBQnzQrtcczqXOVQwRhM4IcVyntZHnSI5RRMh2zi5JlFHnuuYFUttsUtigYmOWj7UaiU43grs+e804B+eLHhRNpkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916257; c=relaxed/simple;
	bh=Nv1nBQAiSxp9f8ngR1qR4rybkmihY6GwuRN50hS2zNw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqSOJLqWrAAHfyD9gyX4C19lM5CleqEYqgKBpqvzZZ3NvYaJpsyAuRZbVo+Y9N1obKh4kGoDjBnlKpDD5sgk1/SOOJRnr+egBdgTYVzRECkAZ3e0Hb2N1ojlcObqj/cOT84z9xwiK1T9bQ/A4VUPW7F2YPLtf0HWudeRRgy2Tw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C80fcSta; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43158625112so755185e9.3;
        Wed, 06 Nov 2024 10:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730916254; x=1731521054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jAgIf4p6278/YchMAjPlcn7XsnhPqNv2eFyDqelI99w=;
        b=C80fcSta9MI02+qxKb9WQMhxxf03MNcyTQXMqFZxfJ0gPQUMRaCpJFOiI8rttnqJfa
         M+WbVcz25aCD7zVzJ0eEPSNwGVIzEAxgXR+WxbC7Xc2jRZYJQNa8qyBfz4R9f1q2e8LY
         8WISx1O4cLDPJ7iqqqBbJ+7aHXjCR7Y51Qbv4cwOusScN9R3a61IYgodMCW2YUr0dp8C
         a1UB2nUI0pk+MQC3743vbmFuO4Bxe7v3qyHtRhTvPkp38UBZxR7LpkNDXPlTm+ZQZYxO
         FITHo7Kzf+zrmDxbPejmzS7DMVTg2aJ+rbhxTlFZOzbBNbGWGmNfkAGvgRXdg3eg2Jwx
         0wpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730916254; x=1731521054;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAgIf4p6278/YchMAjPlcn7XsnhPqNv2eFyDqelI99w=;
        b=tHBbtx+e3GsSAgABie1W03UyR67Q0VZYhFfLMk1rdT7oFyjgZTpEXCdaNdi+za18+W
         M5/11SaOsqVz1HliBFiDXoU7G/V7HnuctcjB/MZ3/shXXZ6hIJE8cwq2V6xCGYvfA7ut
         c/ORUd2n7sz/yROlf7A0hLENSPCDequY1bK8MzgZCeb3XT4ZniBUkppiAVuwqQ649pOa
         Z4mZc0jjncLcLAuAcOGoF/ZBclG90/gR33+ruWWjrKsnxawkHoin2SvSvE3IpgWwMQ1N
         PfpYQ71iO2s+mn3B2zM8FqpxAsrUrAbr84aDHZSClkYdHdrTf0C9AT6HTHmRuu7sjgrs
         Yp5w==
X-Forwarded-Encrypted: i=1; AJvYcCU4VC2q7G6SM6qIDRbVMEEJe1hj3TIf8wy6HG4Yl/f1lp0dLkGVQnLmxhI3hFE8o3Tj78zGRX/XiC/zQb43@vger.kernel.org, AJvYcCW5i+xcBxRwjjoXYydz3PsGbwwni4VqiQcx/qtGpEAMJ2bACYfVwPsxAnTqZ0J1ygSZvy7IOwnz@vger.kernel.org, AJvYcCXc2XTZpq/EzYD1BBIcmyZ8Bt5GTvsHN3S8G6v882f0NdCM91nbDP27ApCqRJV38DERMxnc2VbK/Dts@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt+ZmB0ogZ5oPcCYyrQJB7RQ0oznsIilBRQwhfgyrDTiGitdFE
	WCOKhowquqFVwGWyG6p6WB+UyOxY/UNT0bBEYyjHol+1jVPL8J1F
X-Google-Smtp-Source: AGHT+IHWPx8gOIteq17zsIZ6IuYs4C2NhdtTeClqoAZ0Tqb/e3ajHoC9WAVLlhvh/OK0YcC6B4Ee6g==
X-Received: by 2002:a05:6000:400d:b0:37c:fdc9:fc17 with SMTP id ffacd0b85a97d-381c7a4cea7mr16193774f8f.23.1730916253935;
        Wed, 06 Nov 2024 10:04:13 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa523a0esm31344865e9.0.2024.11.06.10.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 10:04:13 -0800 (PST)
Message-ID: <672baf9d.050a0220.3c71f4.9bb6@mx.google.com>
X-Google-Original-Message-ID: <ZyuvmSyxag6aJ34H@Ansuel-XPS.>
Date: Wed, 6 Nov 2024 19:04:09 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v3 3/3] net: phy: Add Airoha AN8855 Internal
 Switch Gigabit PHY
References: <20241106122254.13228-1-ansuelsmth@gmail.com>
 <20241106122254.13228-4-ansuelsmth@gmail.com>
 <20241106155458.3552cdda@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106155458.3552cdda@fedora.home>

On Wed, Nov 06, 2024 at 03:54:58PM +0100, Maxime Chevallier wrote:
> Hello Christian,
> 
> On Wed,  6 Nov 2024 13:22:38 +0100
> Christian Marangi <ansuelsmth@gmail.com> wrote:
> 
> > Add support for Airoha AN8855 Internal Switch Gigabit PHY.
> > 
> > This is a simple PHY driver to configure and calibrate the PHY for the
> > AN8855 Switch with the use of NVMEM cells.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> [...]
> 
> > +static int an8855_get_downshift(struct phy_device *phydev, u8 *data)
> > +{
> > +	int saved_page;
> > +	int val;
> > +	int ret;
> > +
> > +	saved_page = phy_select_page(phydev, AN8855_PHY_PAGE_EXTENDED_1);
> > +	if (saved_page >= 0)
> > +		val = __phy_read(phydev, AN8855_PHY_EXT_REG_14);
> > +	ret = phy_restore_page(phydev, saved_page, val);
> 
> I think this can be replaced with phy_read_paged()
> 
> [...]
> 
> > +static int an8855_set_downshift(struct phy_device *phydev, u8 cnt)
> > +{
> > +	int saved_page;
> > +	int ret;
> > +
> > +	saved_page = phy_select_page(phydev, AN8855_PHY_PAGE_EXTENDED_1);
> > +	if (saved_page >= 0) {
> > +		if (cnt != DOWNSHIFT_DEV_DISABLE)
> > +			ret = __phy_set_bits(phydev, AN8855_PHY_EXT_REG_14,
> > +					     AN8855_PHY_EN_DOWN_SHFIT);
> > +		else
> > +			ret = __phy_clear_bits(phydev, AN8855_PHY_EXT_REG_14,
> > +					       AN8855_PHY_EN_DOWN_SHFIT);
> > +	}
> > +
> > +	return phy_restore_page(phydev, saved_page, ret);
> 
> And this by phy_modify_paged() :)
>

Didn't notice those, even better! Thanks!

-- 
	Ansuel

