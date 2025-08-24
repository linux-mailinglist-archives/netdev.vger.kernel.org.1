Return-Path: <netdev+bounces-216318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BAAB3315E
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 18:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1EFF1B27471
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 16:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655D42DEA7B;
	Sun, 24 Aug 2025 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zy3rrqIJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF4C2DE706;
	Sun, 24 Aug 2025 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756051861; cv=none; b=FEBM5yohfnnJQTGvVqy6kd0Zd6Q09/RfjrfiC/ARzogilOQLe5mvunbxjvs3aLLuSsmZjtLA0BeeycSdlTxDWQ2k3XOn0NNyQKDVSRImNV2f9PW2U2tqeceryiLIIRMUsB4a1qEeX8yr8ADSb3NXBThnLNJH6Ul4/Vq9G9LfblU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756051861; c=relaxed/simple;
	bh=VAxKK35wpDESquHVaJoyEPjd1oJendGKzrDjPrvzQws=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWVQFZqg2QtoPhlEqJ3qQpz2rJGh0ol9DexDD8crih7+gEV85qS/EsDDpNcP4hhqBSnbYzGR0ZOlIzPVfbW163VUyEvUNq0H+V4vLv/GvonBjFkVXNG0KJp7w2DkC6hetCOKL/U+U8jfaHtOfbYh/RwiJQi4CI5oMmev4QYc2BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zy3rrqIJ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3c7ba0f6983so396398f8f.0;
        Sun, 24 Aug 2025 09:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756051857; x=1756656657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1I2NT4mKh7yb0BY4GOLrqjHXvrwnrXvrX4Nd7QgaVUQ=;
        b=Zy3rrqIJQLvaRtjRL7qlRZLa5az9sInNtZLdglVo8L13ftS7r6iysyvM6BOqmDi8l0
         IJE1Sveh0VVQd8/OG660nLViM/wiD52+WC9x35OofK5Ynyg+jD6+VIoo9wQp8Wr4Jk7/
         dPVvy8buqp4LANidrs+iW5aXZ5BOMCEMZOLCZ8010S8FRtNPCOdXjEihGCwty0zwqEU+
         rAzhd06TBdpGB4WUFOvvWc2Yuupk3scaiMUeHdfflVIK4nYtOj4EbFpbPHLngIcoPbIZ
         F5l8CuudeL5GaKkqaszbYGfH5Rs0VN1gSNZAKuo7Tsvy5VGElRspNnO2EPHyeoQGJbbw
         oJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756051857; x=1756656657;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1I2NT4mKh7yb0BY4GOLrqjHXvrwnrXvrX4Nd7QgaVUQ=;
        b=tzWwMQD3TX48eKNf47mgcVtXrq/cOT63S3a3FqwKKy010Y24tI+P7bwQNfmW8IqOSH
         Way3XJFvOhcY8/kitOIHrsxtFHYgwkAsXq9jjDRc3d0skpgm/y0oOJ/b+wwUjqEYWmnK
         +QUcvOQuz+gquwxzxfSiic4eyFQyfx0VH1Imq9QZKqHO1bxivwRkOzVS/av9m2VfG0Xu
         eeA9ZW3iDJsDYV7oeqUazp6hNBqZR8wRCkb7YK/HqVjoq1IkdwSZ1CMDgMhdyarHCZW6
         TJoW/xcaoXoG6dkYmonOWQhhWsDRGC9lSeVOzOWf8g9HA1fCiYKxVXITTAlUlBV6nofl
         N5dg==
X-Forwarded-Encrypted: i=1; AJvYcCU9fiAYX7ZpxSutqFU5D/pGoqQNoNH+EAyG33xqWPw430YVp50QavvUGeULH1RkU0BkDcmv6RGK@vger.kernel.org, AJvYcCWm/1PaSfPoK/3RiHi4jz8+RWSOxzG41KWeqIcNxjItGSw+jOqQSTp/HUtyMjioskiqOEfCH+ZEDosNIPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPFc2mDxkyGcO+sZ/sgtgdlX/zWPkndrubehl900bEYtL3CBdl
	PI9icSxaGpm7NmZ5Zm+QAzLOYe1iMRnr6EgcfsL8Emb/l7dSQuNdhmK2
X-Gm-Gg: ASbGncsrTFGbZpRr0bYhs8tYp2lehqdI+kLoQgrV1WQfFqm6D0qtV/oLW5Q9hihOG4z
	tdnG9Rsgliu21tHvYdLA8xTa1WjzXpmq3he8YqCEH6LHBjqHFXplsgrdDhJ+3dghqILbuvT5+4H
	8RiQLFigN7CLWQ3k6NptqQLul4AKBtaMa9zo0YEJjsaaMyb7AsjRSVHYk4vv4xZh1N1f0HU2pHP
	VV2fWv4iCqs6HvjmK7M+P4G7WRI2cKjOGwOsvQ8/l7VxeSqnX+gKaeNYbifpwOtoSwIAg4ElfwN
	oPNHtvZQCKd7jYS8g65RZJBOtU0TZ4PFz9N8oO325RKrEMstkYbJDhnWZbFlvd47qIooKv8Ob7p
	HJdg8okJCn5Lf49rh4VFUCxSFH7bzndv6w9OyUW6J0aWlfxSIQsTvZCSAiwYZ/MTTuOZiTg==
X-Google-Smtp-Source: AGHT+IEDU03C+/RngngYkZV9JLD/d0UDQyHwKA89MHae3qywRVuGFrUGSHuM3Mkezi/0zu1siuGvaQ==
X-Received: by 2002:a05:6000:4182:b0:3c4:edc0:28ae with SMTP id ffacd0b85a97d-3c4edc02d8amr9093208f8f.28.1756051856518;
        Sun, 24 Aug 2025 09:10:56 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-251-209-58.retail.telecomitalia.it. [95.251.209.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7117d5977sm8022190f8f.51.2025.08.24.09.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 09:10:55 -0700 (PDT)
Message-ID: <68ab398f.050a0220.29c994.a368@mx.google.com>
X-Google-Original-Message-ID: <aKs5jPD8wr4whF4P@Ansuel-XPS.>
Date: Sun, 24 Aug 2025 18:10:52 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 1/2] net: phy: introduce
 phy_id_compare_vendor() PHY ID helper
References: <20250823134431.4854-1-ansuelsmth@gmail.com>
 <d440416f-103b-49a1-a077-c6003be9f80f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d440416f-103b-49a1-a077-c6003be9f80f@lunn.ch>

On Sun, Aug 24, 2025 at 06:08:34PM +0200, Andrew Lunn wrote:
> On Sat, Aug 23, 2025 at 03:44:28PM +0200, Christian Marangi wrote:
> > Introduce phy_id_compare_vendor() PHY ID helper to compare a PHY ID with
> > the PHY ID Vendor using the generic PHY ID Vendor mask.
> > 
> > While at it also rework the PHY_ID_MATCH macro and move the mask to
> > dedicated define so that PHY driver can make use of the mask if needed.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> Hi Christian
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> > +/**
> > + * phy_id_compare_vendor - compare @id with @vendor mask
> > + * @id: PHY ID
> > + * @vendor_mask: PHY Vendor mask
> > + *
> > + * Return: true if the bits from @id match @vendor using the
> > + *	   generic PHY Vendor mask.
> > + */
> > +static inline bool phy_id_compare_vendor(u32 id, u32 vendor_mask)
> > +{
> > +	return phy_id_compare(id, vendor_mask, PHY_ID_MATCH_VENDOR_MASK);
> > +}
> > +
> 
> broadcom.c:	if (BRCM_PHY_MODEL(phydev) == PHY_ID_BCM50610 ||
> broadcom.c:	    BRCM_PHY_MODEL(phydev) == PHY_ID_BCM50610M) {
> broadcom.c:	if (BRCM_PHY_MODEL(phydev) == PHY_ID_BCM57780) {
> broadcom.c:	if ((BRCM_PHY_MODEL(phydev) == PHY_ID_BCM50610 ||
> broadcom.c:	     BRCM_PHY_MODEL(phydev) == PHY_ID_BCM50610M) &&
> broadcom.c:		if (BRCM_PHY_MODEL(phydev) == PHY_ID_BCM54210E ||
> broadcom.c:		    BRCM_PHY_MODEL(phydev) == PHY_ID_BCM54810 ||
> broadcom.c:		    BRCM_PHY_MODEL(phydev) == PHY_ID_BCM54811)
> broadcom.c:	if ((BRCM_PHY_MODEL(phydev) == PHY_ID_BCM50610 ||
> broadcom.c:	     BRCM_PHY_MODEL(phydev) == PHY_ID_BCM50610M) &&
> 
> It looks like there is a use case of phy_id_compare_model(), if you
> feel like adding it.
> 

Thanks for pointing this out, I wasn't sure to add a _model() variant as
there wasn't an user for it. I will submit a new series after this gets
merged introducing also this variant.

-- 
	Ansuel

