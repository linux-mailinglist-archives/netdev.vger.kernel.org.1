Return-Path: <netdev+bounces-205293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B66AFE162
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55C7189973A
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 07:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35C42701CC;
	Wed,  9 Jul 2025 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWL0ZbRz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E874626E703;
	Wed,  9 Jul 2025 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046510; cv=none; b=iL2HHAVaonbnYya/DvPQw3z1g13v4WtTf3lP4+L+80aKhdVgMmB9JjoulnYP6GQauimtTo4rqEayc8u6+3SSnsa7p1pfpfZaCiw2JPvhyahiDFh+hcnqW/DnpnZ09O0vCV9DqDWvtBwsqzUEEvtmzvkakpknRG4i4TVfSoNK+4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046510; c=relaxed/simple;
	bh=apSbOoS9U6mfq0x0t2Vyc3+pyxqm4tbUjGVu9pXo85w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onBXhk7bKetRntPKmXKE5KbVy4nWcHwGzxi5aCg5xBYhBBaDqLp7dD3mSa5VUlY8cTMBWnM4euXVLeevICwrbRETPsyf//qooaGf1d4FryFxkL0gPH84j6JuHQEwlKG0n6NI6FOgJwtbXZNoQQ26AX0qRar2Cwr9Ib7nVLmCqvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWL0ZbRz; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae3a4b3fa38so68648266b.1;
        Wed, 09 Jul 2025 00:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752046507; x=1752651307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9KDScy/49LwB4Dsg3PbSQr/zqgdUQnfyUC8yK70O68Y=;
        b=gWL0ZbRzTf5pR7g5Hi05Z/vPHfCQmM0u15w6rDeEVRZPgea9hHhbeS5Rs02jgwntZS
         RNdm6wTI7P/hw21RjRu6ctX/tFCiHXDvigCBoLmCJUpYQm1z2cBSVzmk4AF9PX86K919
         JyEPkZ/IzHQ8mUizmG0lw93YSrXEJB2k9QVMxKl+BpAetFL8iChvQQq1FSI1YL//tcu5
         i+1lcXSB440eFZT2SEcerBqhuCGZhXzKK473d4CtGVRQjbewyAB/h5fYMnIgbBvpVhMo
         mgVfoFhcTRXu7WEsR3IzsLY16+W4T1dst446+GfLPRGXgETJI5XRiN0OoOayx2TKdO5g
         49Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752046507; x=1752651307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KDScy/49LwB4Dsg3PbSQr/zqgdUQnfyUC8yK70O68Y=;
        b=OxU7OQz89CpCh11USXKp0LH2v7Hm7BNwBbTj2Y3kMqnB+O4q0DMFgaZuAS36mN8osU
         w3fwKEu2Bvv5tCrP4l7zdXYrFSeUgcFbdAmiYU8pytBkcpJ/fjfAZTbt5yL/pUX+dKDF
         0iFxt5/0naP6vnjRTHg8qljA0DZbG5omjMxdsIIXrdT/BLPl4GFgs2xSNyhJCEKUCFSS
         dxaPOO2bpCynxFgxtsweaLKUSl+NVXMEwW4iyk/YPgQ0jniokQ1P7Atzz3mygSzA7UO3
         /rH5W+W6DDPl1v0SEKd9XtSAXPZrkBLFrKsaVPjm8ffmGy9kN+hA3tKZ1NWH/Vqv426t
         SnEA==
X-Forwarded-Encrypted: i=1; AJvYcCVi+BXQwgSQGozQPaJlNYjT3BIDftAjgLPZFf6cW5z4eN8NmwZrZCRhkWybSDijJxCR/brdhpho7A6s@vger.kernel.org, AJvYcCWJccXi7919jYalHjAFiKFcM3H1sA2M56cXe8lzy1GW85y1XEyewsmII1CrivxLOdqa4qUduU7+@vger.kernel.org, AJvYcCXWc9hilS6vyIQHwO0rH+YVSW0YUXATOiWw0pfUX8PyUxCiR8DwPlJrtMXmC6VjVRRw+pZgTsgY8Vv4rxuy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5lTmhf4bFGFPOyxEKfSaEhi8HC6KWH3dy5iMjtilEpTkzEnzT
	xoRVV0/7PZ5iz3FqUhhFgHw0xutyUXTzJMX7P81WtBtkOuRkF3lTVuJM
X-Gm-Gg: ASbGncsKsE07DxoK4xJ3xTjiDI1k+Y8OzPkpf4O11RhQOO4CvewQGEPKuA9zEBEVlqq
	quJs6NKSmORihTz43TJ2BfH0vWlh+DNLWLb78hgSu7dpjIzRRExHLXfHaNuCWKEDs0xQhGD9C9L
	BZOSsUytEb/pfFtn3wHDoQN+o5adAROHPt/UYq345oJKPqSQGl8aNM8FcmmAIMCFrC859sm1DdQ
	ty/LB054Em/aUtZ/oMgAccl5oDEbPHxfYPNa4kc+O9rsl+n/Ee8L8Qull7QRGtAVjNUl3BWrqup
	jIZFBLQ8oX6hLFgY7+xEi5AZbcjTkOyBQBCLgeultI7urOO+z8/uj4o=
X-Google-Smtp-Source: AGHT+IFK2ruiZ/YJPfCJE6QxsWuKBs9DtR+PyUvZgj9x+C9sJRGNUi0eRNGf4iftXnn2Vv94aD5JKA==
X-Received: by 2002:a17:907:7b88:b0:ad8:9207:b436 with SMTP id a640c23a62f3a-ae6cf74d055mr48381066b.5.1752046506830;
        Wed, 09 Jul 2025 00:35:06 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d00b:9d00:b62e:9c53:a189:bb64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6ac5fd7sm1053891966b.103.2025.07.09.00.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 00:35:06 -0700 (PDT)
Date: Wed, 9 Jul 2025 10:35:03 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 7/7] net: dsa: microchip: Disable PTP
 function of KSZ8463
Message-ID: <20250709073503.kffxy4jlezoobqpf@skbuf>
References: <20250709003234.50088-1-Tristram.Ha@microchip.com>
 <20250709003234.50088-8-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709003234.50088-8-Tristram.Ha@microchip.com>

On Tue, Jul 08, 2025 at 05:32:33PM -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The PTP function of KSZ8463 is on by default.  However, its proprietary
> way of storing timestamp directly in a reserved field inside the PTP
> message header is not suitable for use with the current Linux PTP stack
> implementation.  It is necessary to disable the PTP function to not
> interfere the normal operation of the MAC.
> 
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> ---
>  drivers/net/dsa/microchip/ksz8.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
> index ddbd05c44ce5..fd4a000487d6 100644
> --- a/drivers/net/dsa/microchip/ksz8.c
> +++ b/drivers/net/dsa/microchip/ksz8.c
> @@ -1761,6 +1761,17 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
>  					   reg16(dev, KSZ8463_REG_DSP_CTRL_6),
>  					   COPPER_RECEIVE_ADJUSTMENT, 0);
>  		}
> +
> +		/* Turn off PTP function as the switch's proprietary way of
> +		 * handling timestamp is not supported in current Linux PTP
> +		 * stack implementation.
> +		 */
> +		regmap_update_bits(ksz_regmap_16(dev),
> +				   reg16(dev, KSZ8463_PTP_MSG_CONF1),
> +				   PTP_ENABLE, 0);
> +		regmap_update_bits(ksz_regmap_16(dev),
> +				   reg16(dev, KSZ8463_PTP_CLK_CTRL),
> +				   PTP_CLK_ENABLE, 0);
>  	}
>  }
>  
> -- 
> 2.34.1
> 

What prevents the user from later enabling this through
ksz_set_hwtstamp_config(HWTSTAMP_TX_ONESTEP_P2P)?

