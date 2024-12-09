Return-Path: <netdev+bounces-150217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C579E97D0
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F861283197
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6271ACEBC;
	Mon,  9 Dec 2024 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H71hXKx0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3194E233143;
	Mon,  9 Dec 2024 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752331; cv=none; b=BJsEqzkChr2B3Ju2HC80be+eYrur/8FFvw7bzrrsHr5j8agmJ5D/v822JA55j05tg++5Wv7h5jdHYzgfrbtu/AYOBGHiX9m9lYunTfS4uzkVKJMOKM8W06S34lPkQuYkgRaLFMmkE+zCrUwxnM5dWgoOO2wT/Dp32tsRXnYja9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752331; c=relaxed/simple;
	bh=SNjMhfcOqr/2FO2iF7EA+2wyAorUyazYpsjpQjK7AC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hU6ptD9Yv2N5SDHBEUfC8LMLUReLnk8fSUPRLsBxsJZ6TUx9tVDBS49k7N6f573IE0H5gQZBhq4RZJDsrFq/SBob0gTxUMpKFzl6GqGCEimZU9dbnotAPwfx9oGL/4+23wq3MgBC9YJX3LYz1KXSLIo9ueTZ3vHORsiFvxdK3kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H71hXKx0; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa68d0b9e7bso163551266b.3;
        Mon, 09 Dec 2024 05:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733752328; x=1734357128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x3k8PAFjXCzW1A3crmS3iem8JuhgrdJrW/SGusHwGXM=;
        b=H71hXKx0qimCHzU48LSqs03SUnOzJumhHa/waGuwQHqYOks4OBQDHDy4Zj7mKx9mMh
         NWvvftrjiLQuGeW1Uu1f0/QXLnmtSrqrrDUQElOdMRzdWtyVDwozev6arNiNkYcs9WHy
         Pu/qMUYmc9bG/fiqJSZYbt51vnLdKwHjkBLAXuu/rlqnpzfn8Qm6aBiqWXFx89eoDL/Y
         bJwRfhLHW00HnhJJJySfkAG65/gAPh4Zsbh/SDotKD1uRBc2xLZ2ge1e1WW2n1REDMLd
         ox+UA1ie4USAzLnYhtX8oozRqvjlpv5zhrQWcff06a8jmrG43clCCapPQ3p42yTymrtp
         MFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733752328; x=1734357128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3k8PAFjXCzW1A3crmS3iem8JuhgrdJrW/SGusHwGXM=;
        b=syQ0iT3sDWdwbKFKcJFo2tFjJvCmJdi7zJtvmZDVX4cVuOiWmjMlx9ygTF69D9PeG6
         XlbMqH+jaVKEVJgjvU4eNVGBIFiW+jy/iBPl+VUxM7V3hAuqVKKavvCdtL8HxwAXtC+O
         YEnnSrxcN426sOKpQpDWk5+6xqzHpU4+QvDOUpFV3XNxFoUXcD/mS+VRHgf8Pi8DGyZj
         qJU0fU7s+ah74mEO/F3mua01dYoqMPNRCjX30VZ3X4E+zqNAGij+hiI8VYO6TqPWXoyQ
         KbLaznVn6TNoXL0RAyB0cXm/IJ+LuyUHBMSfSA9gX1gsQdXuu22bY5YYsnE0u5E90EDZ
         3yAw==
X-Forwarded-Encrypted: i=1; AJvYcCVMyaTuAMDFAaujdQ8iC5lvygay72UnzTf/ONE97YE2LWpcRtHVNNLP31mxU1QsSzRVAmDHqH1z@vger.kernel.org, AJvYcCVOz+m0WQzkn0DazLDl3kfDVcbLcTDpc7zRL3yPo5KjeBaY+xpVDktrL82Fup5PtdbYZxBvhCoXXr4k@vger.kernel.org, AJvYcCW3Uymt8T4yMuVOKF2WvgrCoBjRCrn+4BWpGrvUIk8xGPL1OmG2OLE0RM8G6WPRZvd9q70jEO9BGwZbJXoY@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ78HsdkoHBxa1gRnPWYgYewh8Zx7IbGtU6BuJuVtq6caQpqb/
	n4WoMb+yAYXt6Ar27PTeJGlekXRn7PRdxgafAE2qw5h4aFpS2Jrd
X-Gm-Gg: ASbGncvQj9dewgKCoRYbuttpv0gv+GQMEJiKh09cs693E2g4oKMRvM9HP7mtb33XUjJ
	f1S8HP1i3Abm2CmbIidBChsLXBoTfRWxkNXB53gGQTIgFO0tB4nR+J86zTtFyr2gtm/psHkIEd6
	6BrF01oLrQ6l+eG7vf4AHl4P5aWUITYVKnjLal7tUe6dGe/89xPcsXTt/+B9jGnlddeIGIZnB4t
	pSXJHn3GukznCt/aqEH/4dFtiIG+DN5P2EAxoWT61+Iazg=
X-Google-Smtp-Source: AGHT+IEa1yXgo0YXxleWvB+4nj5F1TeFbIRPkRLnibwvdnklQU4c0P4+RHAg2mE43H/3iqAQt/BhBQ==
X-Received: by 2002:a17:906:308d:b0:aa5:b1b9:5d6a with SMTP id a640c23a62f3a-aa69ce32f01mr48901366b.54.1733752328120;
        Mon, 09 Dec 2024 05:52:08 -0800 (PST)
Received: from debian ([2a00:79c0:660:e900:9a0b:ab67:9301:c43c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa692846b85sm97921066b.127.2024.12.09.05.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:52:07 -0800 (PST)
Date: Mon, 9 Dec 2024 14:52:05 +0100
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
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: dp83822: Add support for GPIO2
 clock output
Message-ID: <20241209135205.GA2891@debian>
References: <20241209-dp83822-gpio2-clk-out-v1-0-fd3c8af59ff5@liebherr.com>
 <20241209-dp83822-gpio2-clk-out-v1-2-fd3c8af59ff5@liebherr.com>
 <bcef90db-ca9d-4c52-9dc5-2f59ae858824@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcef90db-ca9d-4c52-9dc5-2f59ae858824@lunn.ch>

Am Mon, Dec 09, 2024 at 02:17:04PM +0100 schrieb Andrew Lunn:
> >  #define MII_DP83822_RCSR	0x17
> >  #define MII_DP83822_RESET_CTRL	0x1f
> >  #define MII_DP83822_GENCFG	0x465
> > +#define MII_DP83822_IOCTRL2	0x463
> >  #define MII_DP83822_SOR1	0x467
> 
> These are sorted, so the MII_DP83822_IOCTRL2 should go before
> MII_DP83822_GENCFG.
>
Will fix it.

> > +	if (dp83822->set_gpio2_clk_out)
> > +		phy_modify_mmd(phydev, DP83822_DEVADDR, MII_DP83822_IOCTRL2,
> 
> I would of preferred MDIO_MMD_VEND2 rather than DP83822_DEVADDR, but
> having just this one instance correct would look a bit odd.
>
Is it worth fixing it in a separate patch, replacing all DP83822_DEVADDR
with MDIO_MMD_VEND2 ?

> > +	ret = of_property_read_u32(dev->of_node, "ti,gpio2-clk-out",
> > +				   &dp83822->gpio2_clk_out);
> > +	if (!ret) {
> > +		dp83822->set_gpio2_clk_out = true;
> > +		switch (dp83822->gpio2_clk_out) {
> > +		case DP83822_CLK_SRC_MAC_IF:
> > +			break;
> > +		case DP83822_CLK_SRC_XI:
> > +			break;
> > +		case DP83822_CLK_SRC_INT_REF:
> > +			break;
> > +		case DP83822_CLK_SRC_RMII_MASTER_MODE_REF:
> > +			break;
> > +		case DP83822_CLK_SRC_FREE_RUNNING:
> > +			break;
> > +		case DP83822_CLK_SRC_RECOVERED:
> > +			break;
> 
> You can list multiple case statements together, and have one break at
> the end.
> 
Will fix it.

> I would personally also only have:
> 
> > +		dp83822->set_gpio2_clk_out = true;
> 
> if validation passes, not that it really matters because:
> 
> 
> > +		default:
> > +			phydev_err(phydev, "ti,gpio2-clk-out value %u not valid\n",
> > +				   dp83822->gpio2_clk_out);
> > +			return -EINVAL;
> > +		}
> > +	}
> 
Ok.

	Dimitri

