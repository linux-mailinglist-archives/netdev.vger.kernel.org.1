Return-Path: <netdev+bounces-164675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DADFEA2EA90
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D77160492
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7C116F271;
	Mon, 10 Feb 2025 11:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQSoFPO1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8650E14F70
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185563; cv=none; b=a9n16pAqiGhEQE/pR385KwYZpY2+rXvGSsYRn1iHPBzguWxYeviSEhy7tA9Cfr36MQEpq2TqqaVgyAGDeb0v/TI/KhR6y0eNzCEFPyoEH4QcAczON2hGi+wKFLcGYclJIFgUrSOYfv0OHs/fob4A8XniwHKJyNkKfes6xnnmkMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185563; c=relaxed/simple;
	bh=0P02ERo8mSAr9Ujd+Twu1poV4P4BBhTYx5MHoRzNRcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eD4tTcwl/YhxNSGcq+9n1sBebq+boX5FNEm0TI0peYsxO7/WKN5ZaR1q/qb3D87oGU7LAz+gvWwnA5zIukKPerN2HnPKKL2kcwgasGPH0R3DSEvHKM0K1/z0r3+S55e/MYDqdqI3SyS/3yQRkezUB5GIRis6gK7i+Ve7452Ix3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQSoFPO1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4394b6c0bf8so160695e9.3
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 03:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739185560; x=1739790360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U71UHX3B+lezYUGQ+P3oAlgY8+iB/Qfd8k//6/xwYLU=;
        b=WQSoFPO1mNW7fl+W2iU7gngXsmsn19486hMFzhyBtKidKAXl6Kd5+1DVn9owQrvZVX
         +0RAv/cZQWjiWWvAakEw1gOIbu56vgoBjtGc+Cicw+VPZBGc0fjSU+bpHDKxMS7/YCTJ
         1varICrxZDE81zofwZjsQPm/H0Zl5jHyMwwwEaLmWih/dDGlzdE19IrODTzii5vmkAph
         rCPkp1iy9X8RLgvyLaMg/H/Nsz8EvdLe1OcdvPquDwHc8dQfmBMEn8JFmNEZO2aB+Iwq
         heuLdBVBanWnKrz7Juf+bnKR4y8UEgdn/p8XsAFc26SRsiTrGLeTgaWy871qQWUoEH0Y
         lDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739185560; x=1739790360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U71UHX3B+lezYUGQ+P3oAlgY8+iB/Qfd8k//6/xwYLU=;
        b=HOmGhSAz2Oyqqw6isMcXI91g4rb/5SrEy0YRj3KsVg93PXEKNhvnlYLN8fFf6Q6dOz
         C2I+m4UpDhy5X3frzVZbMFQmqaermjlPbMfbvYbp2pcdtBZ1+egz293dsUOuP4e1n8Hw
         f2JwvPKHlvX7npT7KKoNX9bN7SLUv+rpxMWjsIz/9K0TtC4zO7Kf6O27DgRDJBJ92AKh
         KEUgAWh8spWFhXT4Xr1U81fajg0aXOYrBMsJtQYITsl8k+55m27JcGqoQHp/WKuRzthp
         fu32sVRP6K5ioSZdJj/mQ6dq43kjpgaxKR0WpuANVsTSgEaOePOny6QIUyRU5JHbAPf+
         hCyw==
X-Forwarded-Encrypted: i=1; AJvYcCWV3fSezkdoLiUJP39ggl3AoFjFp5IJDxlvoDvfSDx/5sQ9P9CYSuVHZQA9bNleHTL4kTDOYOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwZVRcVfc+7YJ5SybkGY+/V+TcWRZyLevYePDh2UUTeBGtFAk6
	YHv8BCUhc4AXA6ae67kVZMRKIrg4gcZXCpQgSbz80ElKKg3AV6/6
X-Gm-Gg: ASbGncu9Q4sq9VKBuxhx5WqK7K8hpFzrFYf6+y9PsYQrFXEAviuLeTkLTWxrwDgFQVX
	+Nto+Q4tIhJTyDgBuwfhdIU+IgE5jwMuHkthj6wzzA+Ixv+F1lLipuAFK+ceXBpKLSDvFfwDzfR
	1poha1TJuwSUVjiERvuaVeBni/LcyygmLgze6adFfHHRF1k7nq+lTz5seWpKqe4TXEypxcdAl7L
	Uu7HQRRb+Ze2En9D8nmFvxtsB4yLgzhDfbs5ABchzSfyF2QAePY0LP8wgS0d1CD9ISjvO3Tt0GQ
	ndI=
X-Google-Smtp-Source: AGHT+IE2ZXhL25w95Ym+FyjWVTcoOfJ0kXxZ580OV5rAWk/84Phgnu6DV55adBaAc56meiaO9Sk0jg==
X-Received: by 2002:a05:600c:46c7:b0:434:a30b:5433 with SMTP id 5b1f17b1804b1-43924b5dcdfmr43076985e9.5.1739185559389;
        Mon, 10 Feb 2025 03:05:59 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dc9ff64sm139638195e9.9.2025.02.10.03.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:05:57 -0800 (PST)
Date: Mon, 10 Feb 2025 13:05:55 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Tristram.Ha@microchip.com, UNGLinuxDriver@microchip.com,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 4/4] net: xpcs: allow 1000BASE-X to work
 with older XPCS IP
Message-ID: <20250210110555.stuowh5l6hmz2yxh@skbuf>
References: <Z6NnPm13D1n5-Qlw@shell.armlinux.org.uk>
 <Z6NnPm13D1n5-Qlw@shell.armlinux.org.uk>
 <E1tffRT-003Z5u-CY@rmk-PC.armlinux.org.uk>
 <E1tffRT-003Z5u-CY@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tffRT-003Z5u-CY@rmk-PC.armlinux.org.uk>
 <E1tffRT-003Z5u-CY@rmk-PC.armlinux.org.uk>

On Wed, Feb 05, 2025 at 01:27:47PM +0000, Russell King (Oracle) wrote:
> Older XPCS IP requires SGMII_LINK and PHY_SIDE_SGMII to be set when
> operating in 1000BASE-X mode even though the XPCS is not configured for
> SGMII. An example of a device with older XPCS IP is KSZ9477.
> 
> We already don't clear these bits if we switch from SGMII to 1000BASE-X
> on TXGBE - which would result in 1000BASE-X with the PHY_SIDE_SGMII bit
> left set.

Is there a confirmation written down somewhere that a transition from
SGMII to 1000Base-X was explicitly tested? I have to remain a bit
skeptical and say that although the code is indeed like this, it
doesn't mean by itself there are no unintended side effects.

> It is currently believed to be safe to set both bits on newer IP
> without side-effects.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/pcs/pcs-xpcs.c | 13 +++++++++++--
>  drivers/net/pcs/pcs-xpcs.h |  1 +
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> index 1eba0c583f16..d522e4a5a138 100644
> --- a/drivers/net/pcs/pcs-xpcs.c
> +++ b/drivers/net/pcs/pcs-xpcs.c
> @@ -774,9 +774,18 @@ static int xpcs_config_aneg_c37_1000basex(struct dw_xpcs *xpcs,
>  			return ret;
>  	}
>  
> -	mask = DW_VR_MII_PCS_MODE_MASK;
> +	/* Older XPCS IP requires PHY_MODE (bit 3) and SGMII_LINK (but 4) to
                                                                   ~~~
                                                                   bit

> +	 * be set when operating in 1000BASE-X mode. See page 233
> +	 * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/KSZ9477S-Data-Sheet-DS00002392C.pdf
> +	 * "5.5.9 SGMII AUTO-NEGOTIATION CONTROL REGISTER"
> +	 */
> +	mask = DW_VR_MII_PCS_MODE_MASK | DW_VR_MII_AN_CTRL_SGMII_LINK |
> +	       DW_VR_MII_TX_CONFIG_MASK;
>  	val = FIELD_PREP(DW_VR_MII_PCS_MODE_MASK,
> -			 DW_VR_MII_PCS_MODE_C37_1000BASEX);
> +			 DW_VR_MII_PCS_MODE_C37_1000BASEX) |
> +	      FIELD_PREP(DW_VR_MII_TX_CONFIG_MASK,
> +			 DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII) |
> +	      DW_VR_MII_AN_CTRL_SGMII_LINK;
>  
>  	if (!xpcs->pcs.poll) {
>  		mask |= DW_VR_MII_AN_INTR_EN;

I do believe that this is the kind of patch one would write when the
hardware is completely a black box. But when we have Microchip engineers
here with a channel open towards their hardware design who can help
clarify where the requirement comes from, that just isn't the case.
So I wouldn't rush with this.

Plus, it isn't even the most conservative way in which a (supposedly)
integration-specific requirement is fulfilled in the common Synopsys
driver. If one integration makes vendor-specific choices about these
bits, I wouldn't assume that no other vendors made contradictory choices.

I don't want to say too much before Tristram comes with a statement from
Microchip hardware design, but _if_ it turns out to be a KSZ9477
specific requirement, it still seems safer to only enable this based
(at least) on Tristram's MICROCHIP_KSZ9477_PMA_ID conditional from his
other patch set, if not based on something stronger (a conditional
describing some functional behavior, rather than a specific hardware IP).

