Return-Path: <netdev+bounces-56997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E33F811852
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976F328171E
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 15:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93CB85363;
	Wed, 13 Dec 2023 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2i54W6v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9442AC;
	Wed, 13 Dec 2023 07:50:38 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bfa7f7093so9155897e87.0;
        Wed, 13 Dec 2023 07:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702482637; x=1703087437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dOakPEBgPAHiEGOD9TL6ZF5Zc40kCskBgDb8Dym+yf4=;
        b=H2i54W6vFufuYo0HrUXW1b9bxvEQrJ5upMhwn8E2SoL3ujZuqO1EXU484FUQgbR9rr
         ofnKBtrwVn9BhsRD1RZazyTxajkpKI1GZ/hf+bGkv+67HPjCq6FBZWIYvwke382low4h
         LRcVajc2BmYijXOiu7hUuTq8cjHVhrwhZKihZF37XIEvYLCY1hxdlJVQ0KIKywkunJVG
         oSWM+kVN6wOXHZs8REnxd0OHRWnHb4XQiMvhrl67O4kZz+At56IV/AmPdyFE20mPNADP
         St1GWdzLSB6PAuwf/c0H1iPIhfLNPg4Nv7oINo6kQBAXssj3GW4g0OwsQoK4194AWeOk
         L+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702482637; x=1703087437;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOakPEBgPAHiEGOD9TL6ZF5Zc40kCskBgDb8Dym+yf4=;
        b=aHItIGalCPc30IYEtcUFN0vMosl4kZawlbqJNNZdpuZ96vMGL0TPS9xyvSb/HegXcl
         kVzmKPmDVBylJk6Mc+nPPAkX99CQfEplivn3XlO5yrcjdbvDx85cz8ZfKqtKeSnhijeU
         c+Z0R+giSXyV7CNAEWtd5O0H43R5vFtHbtqKYCOCREChjDGhg2GhI3sy72LsxpSQTDRL
         tY9g324NErGv/QrGnchnAr68csye+wOhAR6+F00TlhxXlDi1YM4ojYhVCVzuIDldnvGv
         wN3emYHSMJ7sLDuvn4j0JXVzZlbpfgZn3z9w6HseUmBo9VCFRfXQLTpM4dKYrf2M8gQI
         g6vQ==
X-Gm-Message-State: AOJu0YyfKIMsCail8gfuSNTfSZWghFGwvgW/4O6zI+fNfdXP2dDki7ka
	XYRvdKn0vtI39rD+zV7A5Kw=
X-Google-Smtp-Source: AGHT+IFmkUOat3pu7EkXnPLBDOtDWZRm0ytKRWIJIJFUg08MsAjULnoRyTNw6dcjEDTYuhyNRoGU/g==
X-Received: by 2002:a2e:bcc9:0:b0:2cc:2af3:5edb with SMTP id z9-20020a2ebcc9000000b002cc2af35edbmr2510066ljp.14.1702482636607;
        Wed, 13 Dec 2023 07:50:36 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c444600b0040c46ba7b66sm12056425wmn.48.2023.12.13.07.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:50:36 -0800 (PST)
Message-ID: <6579d2cc.050a0220.e6ea.d8cf@mx.google.com>
X-Google-Original-Message-ID: <ZXnSyTba0DnbC5DU@Ansuel-xps.>
Date: Wed, 13 Dec 2023 16:50:33 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	Harini Katakam <harini.katakam@amd.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v6 1/3] net: phy: extend PHY package API to
 support multiple global address
References: <20231213105730.1731-1-ansuelsmth@gmail.com>
 <ZXnRlERUGhwxKJxi@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXnRlERUGhwxKJxi@shell.armlinux.org.uk>

On Wed, Dec 13, 2023 at 03:45:24PM +0000, Russell King (Oracle) wrote:
> On Wed, Dec 13, 2023 at 11:57:28AM +0100, Christian Marangi wrote:
> > -static inline int phy_package_read(struct phy_device *phydev, u32 regnum)
> > +static inline int phy_package_read(struct phy_device *phydev,
> > +				   unsigned int addr_offset, u32 regnum)
> >  {
> >  	struct phy_package_shared *shared = phydev->shared;
> > +	int addr = shared->base_addr + addr_offset;
> >  
> > -	if (!shared)
> > +	if (addr >= PHY_MAX_ADDR)
> >  		return -EIO;
> 
> If we're going to check the address, I think we should check it
> properly, which means also checking whether it's become negative.
> 
> Alternatively, we could consider making "addr" and "base_addr"
> unsigned types, since they should never be negative. However,
> that probably should be done as a separate patch before this one.
>

Maybe I'm confused but isn't already like that?
On phy_package_join base_addr is already checked if it's negative (and
rejected)

addr_offset is unsigned so it can't be negative.

We can switch addr to unsigned just for the sake of it but if I'm not
wrong all the sanity check are already done.

-- 
	Ansuel

