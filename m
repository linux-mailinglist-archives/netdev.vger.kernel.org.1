Return-Path: <netdev+bounces-167623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF564A3B184
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 07:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60B8D3A910B
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 06:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5651AE01B;
	Wed, 19 Feb 2025 06:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMPJGomw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B62216D9AF;
	Wed, 19 Feb 2025 06:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739945825; cv=none; b=NeKvCI6kFz0ZmWyxk38XQCH/qaKh3YlXcQnuExVGEcwn8Ma5T9bd/kSQTCB6nOR7/PfV0B2cMcqtIukqBTXL9v/adJEH7D0b/WrwJVnSdUVfJK6JkVbMjgwXvhnBl2R3zg+zr9FAnRInArcTeVp48vYYW/7g6OBhYqYS5C+zJH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739945825; c=relaxed/simple;
	bh=Ny6SfcZl8SixuBLPYKC1n/I4Wz9XWrTJ0ezJeX6s8bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mD8lSKd+prue0J0wh4S9ozuY5gEOFH1tvSYe2acE/xJ5cVyrcJfM8ww2JRZzeKFP3TE36CPPc449c/UIcoPlGF4Tjixj5QQhRVK4vlpLZUsxpHMB+kRZEGh73sO48cG9bZtop0N3lAzf9o6A+wOM7ePo2x2esfC210AwfCa2y5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMPJGomw; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaec111762bso1462124366b.2;
        Tue, 18 Feb 2025 22:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739945822; x=1740550622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C0Mh+n11QGKFXLHD1zn/e43NMN7EuN42iHSLYiWebp4=;
        b=IMPJGomwfQ3JjXTblFetlbK60ysCnvn6a+ZGAIOLOmWQNs9DD4+vlItogxBdLg92Lh
         VN46JqeWZ4P+F74P6uK9In2XIsPmFZThH2/+azBPITnKpMUbj50uwneez0aVy5/vdr4T
         dmypVfD9BRWT+gr+3KXNCYpCOjVYOX7E4p5hFI+7Uh+qcAAXF23d1qB374g3IENgxVBh
         Qg1tUqV0uc7GnBshKkqqnlmOEt0w8YsHjmVE8RwIwrSQzM+qp1Xoc4WsCWI9rZTUW+tY
         wKGLrxLW3qUX4ECfoLcmtk4hgmKUYynf86M1ySCRsoJ1BhGzVJyqiyFSuCJgsj/vV3/4
         6wZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739945822; x=1740550622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0Mh+n11QGKFXLHD1zn/e43NMN7EuN42iHSLYiWebp4=;
        b=fKNdflBcGGeE66D5Z9bYxXoWlFm+W+Yj1WwJ/qWoRP4w94bVc56ZV4eLjX9civbR/v
         j6aBcTgUqFGAtOhK0vFt4KVfUi0qpllv74DvoD0/SxOPZGQ6iSihZuKaw70KkLo0dV+U
         QlZimwIV5U7u58oUFjOob1R6/CVnRy7oBnBMyNCqH/MZiyk+dPBiJpUNscJqAuf6LCyU
         RvdYjAF/qAAjj0wc2CqRPksi0wDRA5HF0SPRZ9lNAJkkWMhC4CLLlwlw1oFtKgAso0Yo
         Wr9OGe13PcPBRQjrfhZmGNRQ/StWVjOulRnPCW+LFZQIseIe/pM4b9QYfsaZ8bW7k5B1
         gdNw==
X-Forwarded-Encrypted: i=1; AJvYcCUAefZqJVUuXjkqHs5v1UcmWnrJ5D1GDULqfv4OaOGEBUtTebY78KKi9Nj9sbl0SLCVRpHSdpO+vvYwXxg=@vger.kernel.org, AJvYcCWXlsoqiH7KzzOpRNzlnwlTAlwHzcCfoqQnlxcB9xsacPiB5WYnOJXMmkflJTlrcJtEu1kygpu6@vger.kernel.org
X-Gm-Message-State: AOJu0YxEa/ARWgEoD2B/JgzP2d+uYWlVBYbdAGrhWF7xBvDH898PB4VI
	ceB7CFfsu8XNQ8pz8zjiUDrUPK/48I83EIBcvEBo5LtCrTbt6CKP
X-Gm-Gg: ASbGnctjTKf/2AoNsHRGDlHG6+lOAUE1+4fhDLQpTIMSx6WUn68u2K041ynwgShrtn5
	IgZ+zfh5FJlc20piOleJHlI0k0K8GVxtDtv41CpQOki/uvsvxwEkNSBqp0pPbG83Y37jdxh4eH4
	f+L7ksJP0qaio+yrrTt8aDIRjHC3zSkt4nN4Olocew8aVI8IyOkj2wJSgKL+OhGf3TQeLOxVOvc
	1Z3H9iaVQZCx1CnlJu6rxB4ucIF2c6u73WRNe0CcXdS3V1bbOMv8mJwnSNMphRCPL0Z9cxE9YPU
	x6MUvr8lHCIn6f+cYQ==
X-Google-Smtp-Source: AGHT+IEnKnfOnKBhfUtKb0edyU2wPAS9dcKPrNOCcz62kbU+ZYnxhBiooIXhiQYh7tvo+Gbpq0buQA==
X-Received: by 2002:a17:906:1bb2:b0:abb:1b23:67b7 with SMTP id a640c23a62f3a-abbccf12ca0mr243110466b.33.1739945821328;
        Tue, 18 Feb 2025 22:17:01 -0800 (PST)
Received: from eichest-laptop ([178.197.206.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9f3a695dsm474897966b.2.2025.02.18.22.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 22:17:00 -0800 (PST)
Date: Wed, 19 Feb 2025 07:16:58 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: phy: marvell-88q2xxx: Enable temperature
 measurement in probe again
Message-ID: <Z7V3Wsex1G7-zEYc@eichest-laptop>
References: <20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-0-999a304c8a11@gmail.com>
 <20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-1-999a304c8a11@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-1-999a304c8a11@gmail.com>

Hi Dimitri,

On Tue, Feb 18, 2025 at 07:33:09PM +0100, Dimitri Fedrau wrote:
> Enabling of the temperature sensor was moved from mv88q2xxx_hwmon_probe to
> mv88q222x_config_init with the consequence that the sensor is only
> usable when the PHY is configured. Enable the sensor in
> mv88q2xxx_hwmon_probe as well to fix this.
> 
> Fixes: a197004cf3c2 ("net: phy: marvell-88q2xxx: Fix temperature measurement with reset-gpios")
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---
>  drivers/net/phy/marvell-88q2xxx.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> index a3996471a1c9a5d4060d5d19ce44aa70e902a83f..30d71bfc365597d77c34c48f05390db9d63c4af4 100644
> --- a/drivers/net/phy/marvell-88q2xxx.c
> +++ b/drivers/net/phy/marvell-88q2xxx.c
> @@ -718,6 +718,13 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
>  	struct device *dev = &phydev->mdio.dev;
>  	struct device *hwmon;
>  	char *hwmon_name;
> +	int ret;
> +
> +	/* Enable temperature sense */
> +	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TEMP_SENSOR2,
> +			     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
> +	if (ret < 0)
> +		return ret;
>  
>  	priv->enable_temp = true;
>  	hwmon_name = devm_hwmon_sanitize_name(dev, dev_name(dev));

Is it necessary to have it enabled in probe and in config? Is that
because of the soft reset? Can it happen that the phy is reset but
config is not called, then we would end up in the same situation right?

Regards,
Stefan

