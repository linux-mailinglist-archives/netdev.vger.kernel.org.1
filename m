Return-Path: <netdev+bounces-56476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C9B80F09B
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 16:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC5F1C20CC9
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 15:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EA177F01;
	Tue, 12 Dec 2023 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHX5pL6o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B43AA;
	Tue, 12 Dec 2023 07:26:23 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2ca0f21e48cso74882821fa.2;
        Tue, 12 Dec 2023 07:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702394781; x=1702999581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RzfykjqVsJboNXe+GyM6OYXbP3W5WNnJ1aGISEQJa3Q=;
        b=YHX5pL6oJFUsSwBk8s91P4GP016767zDZ3xGtKlET9cPh6G2ogZ3OcXLZsFNF5OHfz
         cR0ySMmXZUsmIlbCAUAJWtBG7R0TsGpP+WkbPkz/q6NWxO/Fj1gPIZJCKMHVcEG0G5Ld
         Ae4De6TUtKxQRtYqYZ2sS8+SiOhp0OBRXfQlllJhDIIUz+fUOAcEN1/O25kWS7c6sc7l
         JPgxq6k5tmcInCnHg4AM32SmIzaRcBidVyWRfYP5/xSV9gG3wSSgk3jnU9sZCWR79NFO
         v5rZpeb5sjIefZYyS28z4FmBfr0zsFkxgYQOD69hV1VdrC+PC4BrfY2h2uTvWymc+nJp
         e1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702394781; x=1702999581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzfykjqVsJboNXe+GyM6OYXbP3W5WNnJ1aGISEQJa3Q=;
        b=huKyYmnDjkz3BN16Tettb7ikFPm7FlHVbl5qfB2MGHv/zS6jwoEZDe0YnUDLGmupKn
         Rp8vn0r/g1LbVPg+JwVHkUM3pK05H8/FIqCBc1Ujoboiwea6tJFM0hmADYJ3p3MR/0OQ
         JjGXMtS+p1Ru1gjutMtsm33XvZFqHEYGAv7gbAugW9fi1cyW8ysABrHdypuOiOhpdvyS
         UC6MynOvPNKbXq9L+Io4ztVEKZKefzgFP5xfVNYXiRWB2d3Klo2wzS4+YA3YnCjMNtIc
         M5Z+y+mkZ+1e7OL7g9Vt6WyrcnJ6f6DsSd5Tgms1uymXsSI8zBB6wsKz400QwoBPvhqg
         4NVw==
X-Gm-Message-State: AOJu0YyTmt5LfL5OUlk374E+F0XvbmNFWXY/l0Khp6gGvp5TjLYfFvOT
	keKNTh01MmW+v0HL2E7N4cw=
X-Google-Smtp-Source: AGHT+IFitWMolf9+MGbv8J/HUGRQFIiJq5Iv39LqC9IhSSbGgybQNYWznOea4pt3phQe2oNaB8bqQQ==
X-Received: by 2002:a2e:9ec4:0:b0:2ca:752:24a3 with SMTP id h4-20020a2e9ec4000000b002ca075224a3mr2851858ljk.22.1702394780915;
        Tue, 12 Dec 2023 07:26:20 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id z18-20020a2ebe12000000b002c9f59f1748sm1537789ljq.7.2023.12.12.07.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 07:26:20 -0800 (PST)
Date: Tue, 12 Dec 2023 18:26:16 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Jose Abreu <Jose.Abreu@synopsys.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Tomer Maimon <tmaimon77@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, openbmc@lists.ozlabs.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 06/16] net: pcs: xpcs: Avoid creating dummy XPCS
 MDIO device
Message-ID: <kagwzutwnbpiyc7mmtq7ka3vhffw4fejuti5vepnla74rocruh@tryn6lxhwbjz>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-7-fancer.lancer@gmail.com>
 <ZW8pxM3RvyHJTwqH@shell.armlinux.org.uk>
 <ZW85iBGAAf5RAsN1@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW85iBGAAf5RAsN1@shell.armlinux.org.uk>

On Tue, Dec 05, 2023 at 02:54:00PM +0000, Russell King (Oracle) wrote:
> On Tue, Dec 05, 2023 at 01:46:44PM +0000, Russell King (Oracle) wrote:
> > For your use case, it would be:
> > 
> > 	mdiodev = bus->mdio_map[addr];
> 
> By the way, this should be:
> 
> 	mdiodev = mdiobus_find_device(bus, addr);
> 	if (!mdiodev)
> 		return ERR_PTR(-ENODEV);
> 
> to avoid a layering violation.

I would have used in the first place if it was externally visible, but
it's defined as static. Do you suggest to make it global or ...

> At some point, we should implement
> mdiobus_get_mdiodev() which also deals with the refcount.

... create mdiobus_get_mdiodev() instead?

* Note in the commit message I mentioned that having a getter would be
* better than directly touching the mii_bus instance guts.

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

