Return-Path: <netdev+bounces-244266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F075CB3628
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 16:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71413304E54E
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 15:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064D8270553;
	Wed, 10 Dec 2025 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKifVMD6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF11F271A9D
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765381976; cv=none; b=XThMnGmc0ys8aooqormf4wqBNHI33gEwhKNLWEkUgtyZ1XutmVJGNMfHUG//HgtH96+GpHl2r/sHK2MKL7moWk9oBEjVx7bVFJkVvFHPtrtz+/w+69EhrdGYb2HLY2ShhdvKBMvmJPb1hyteJubZU51c+dmUTiIs5PzBouH6+VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765381976; c=relaxed/simple;
	bh=AiymlGso9/l7KvarglyyENHLycDqtNJS/1x321h4ArA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lC8/Gkcvb+MJMqfueh7SQjAcn8XVEKka/KzPaVXouQNRxe4ZrQ96BFMSd2n3tXzf3h9vdFgsgw3I7n5P3NfFojVQ+xzDc/QafvnhIP1/qYeVkmp8oYJDvQNCzZ5Ghu1JuEJXv5B6k6Y8s5fUd8/RVVyFhtzOn6s9hJ52+xFDQiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKifVMD6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b5dfa4e9eso310246f8f.0
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 07:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765381973; x=1765986773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7GCNrDLONIkcl6CGzLO5FkEHA3pLr289CxP+twY4mp4=;
        b=JKifVMD6wvPQU5bGVUePVJ6jR4Cx1FQ307mD0p9/EI+fWt5WWly8Oth1MAdPOvKXzA
         t+Kx6xk0QA/RS5skyGIOqh0WpKjZO8LOoIv3tGAADfBLZSWXkgPzYMF83nSFb62tmL/+
         W7vHGDzvaXb0GVfr9lDRbcdOyrLZ93ox6+dhV0wu1Bw8+7y9dVTtXxqaHD2P7OCsvmdM
         vLQBJj284GfnoAlNMKnnomrGFTvuh92Cruz5Ri2abq8t8rN/fXez73J+Cql9yIhxLxJE
         3yYUNkDduKAulLreVCupC+eYDkkn6dcNL/Rn9lRAG2oLk0Aq8Na5xxYXnCDwWacU3U9o
         fKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765381973; x=1765986773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GCNrDLONIkcl6CGzLO5FkEHA3pLr289CxP+twY4mp4=;
        b=sqUVQ4SgY+0FJm+o86sWUcKzML7KuQ3wF1ZrmxmSYDVrFjGbs7+HpY0UbvacBohiYT
         yv7L4Th109pVSlGaBHwEpKnMVXAHOGGNO2j5h97JY5LArgnvSpPHaYrA7wwa5/xiljHr
         cZM9FInwHMXwZnk7+AyfD4o/lQb3sOSun8svG99TFiEkAS9oXvnLUKNtH5zTne7FDCNC
         JwSPdjP/3ZP2Rbcwo0fXQNlPbcj9UB9bJP/i52BzKMoLpfJZljQNLCqvyL2PjBBoCnUJ
         u/+MvNQsOQHQh5d5lSzF/ciXrRyYZzkGg2IdttMIq2HKV0JMPKpxj4uL74nW0f7b6gP1
         V+Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWNz9+asDgt0DbfpRgKenBe1xTlbTDiK6mzLLyCH+k546Rsh49NMDPBwcR4J8ob30WqRnOB9jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZHOjJTD3YqZEpw9fUvErHtRSX5EUAVH07aD3z4LBGfUa2ehiO
	s9M4lTLpIq+aSot48IzGW9OIXO1tJZzFVLZJPj4R9Dc5i2NjgNtIEqkR3/tF4g==
X-Gm-Gg: AY/fxX42UEY8codaFzkmnWpjqm1eG7fwNxQ7suJ8LN8r6FSHaqikL0UMQ5Dk1cYYChL
	zrsn6nnWrP/mo/2ecxp8oXG7HA/IPVTZbIx7ADrpD1kY7UMfnxxNh+HM3fjetiFV47xeamKdWG1
	nW0YCXpcEwddQmVsWV2IDVZmCVEhIS5bdDevQVjj+tKdOLQncRFu0a7/IU3NyE/kGrwHQWBimCF
	Ty04kS+mdiwLiKB9ImYgcWTwhPxnpMh2huaokVKnDfVY2bZACpXubzwtBO/maacYV5eWhsU964s
	9VUZQPjMO8suMPnQq+gnltSc7zxkt2CHnTL0hU3haoTsqiyHo/rcOyN7SLSwjEAvXwWRilYWkXH
	zVl1+/hWBGehhBly3kBfjqv2vmiqQoJFh7eABnO54QB9u1+Nl9wi4pWU41SVsHq2nVNbS6u0yvd
	7ya4Y=
X-Google-Smtp-Source: AGHT+IGYAeUdeuynb6UwYU8J9HyCofNd2644Jfj9NCblZV+BVgK0+/dbPuJSj7x85Pn3xdVivORRkw==
X-Received: by 2002:a05:6000:2903:b0:42b:2da3:ac30 with SMTP id ffacd0b85a97d-42fa39dc3e9mr1853606f8f.2.1765381972915;
        Wed, 10 Dec 2025 07:52:52 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:6346:5010:4ce7:245c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d331a4fsm41684065f8f.33.2025.12.10.07.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 07:52:52 -0800 (PST)
Date: Wed, 10 Dec 2025 17:52:49 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rasmus Villemoes <ravi@prevas.dk>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net v4 4/4] net: dsa: mxl-gsw1xx: manually clear RANEG bit
Message-ID: <20251210155249.bpjm2hkvujstxt4i@skbuf>
References: <cover.1765241054.git.daniel@makrotopia.org>
 <cover.1765241054.git.daniel@makrotopia.org>
 <76745fceb5a3f53088110fb7a96acf88434088ca.1765241054.git.daniel@makrotopia.org>
 <76745fceb5a3f53088110fb7a96acf88434088ca.1765241054.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76745fceb5a3f53088110fb7a96acf88434088ca.1765241054.git.daniel@makrotopia.org>
 <76745fceb5a3f53088110fb7a96acf88434088ca.1765241054.git.daniel@makrotopia.org>

On Tue, Dec 09, 2025 at 01:29:34AM +0000, Daniel Golle wrote:
> Despite being documented as self-clearing, the RANEG bit sometimes
> remains set, preventing auto-negotiation from happening.
> 
> Manually clear the RANEG bit after 10ms as advised by MaxLinear.
> In order to not hold RTNL during the 10ms of waiting schedule
> delayed work to take care of clearing the bit asynchronously, which
> is similar to the self-clearing behavior.
> 
> Fixes: 22335939ec90 ("net: dsa: add driver for MaxLinear GSW1xx switch family")
> Reported-by: Rasmus Villemoes <ravi@prevas.dk>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v4:
>  * fix order of operations in remove and shutdown functions
> 
> v3:
>  * fix wrong parameter name in call of cancel_delayed_work_sync
> 
> v2:
>  * cancel pending work before setting RANEG bit
>  * cancel pending work on remove and shutdown
>  * document that GSW1XX_RST_REQ_SGMII_SHELL also clears RANEG bit
>  * improve commit message
> 
>  drivers/net/dsa/lantiq/mxl-gsw1xx.c | 34 ++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> index 4dc287ad141e1..f8ff8a604bf53 100644
> --- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> +++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> @@ -11,10 +11,12 @@
>  
>  #include <linux/bits.h>
>  #include <linux/delay.h>
> +#include <linux/jiffies.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/of_mdio.h>
>  #include <linux/regmap.h>
> +#include <linux/workqueue.h>
>  #include <net/dsa.h>
>  
>  #include "lantiq_gswip.h"
> @@ -29,6 +31,7 @@ struct gsw1xx_priv {
>  	struct			regmap *clk;
>  	struct			regmap *shell;
>  	struct			phylink_pcs pcs;
> +	struct delayed_work	clear_raneg;
>  	phy_interface_t		tbi_interface;
>  	struct gswip_priv	gswip;
>  };
> @@ -145,7 +148,9 @@ static void gsw1xx_pcs_disable(struct phylink_pcs *pcs)
>  {
>  	struct gsw1xx_priv *priv = pcs_to_gsw1xx(pcs);
>  
> -	/* Assert SGMII shell reset */
> +	cancel_delayed_work_sync(&priv->clear_raneg);
> +
> +	/* Assert SGMII shell reset (will also clear RANEG bit) */
>  	regmap_set_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
>  			GSW1XX_RST_REQ_SGMII_SHELL);
>  
> @@ -428,12 +433,29 @@ static int gsw1xx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
>  	return 0;
>  }
>  
> +static void gsw1xx_pcs_clear_raneg(struct work_struct *work)
> +{
> +	struct gsw1xx_priv *priv =
> +		container_of(work, struct gsw1xx_priv, clear_raneg.work);
> +
> +	regmap_clear_bits(priv->sgmii, GSW1XX_SGMII_TBI_ANEGCTL,
> +			  GSW1XX_SGMII_TBI_ANEGCTL_RANEG);
> +}
> +
>  static void gsw1xx_pcs_an_restart(struct phylink_pcs *pcs)
>  {
>  	struct gsw1xx_priv *priv = pcs_to_gsw1xx(pcs);
>  
> +	cancel_delayed_work_sync(&priv->clear_raneg);
> +
>  	regmap_set_bits(priv->sgmii, GSW1XX_SGMII_TBI_ANEGCTL,
>  			GSW1XX_SGMII_TBI_ANEGCTL_RANEG);
> +
> +	/* despite being documented as self-clearing, the RANEG bit
> +	 * sometimes remains set, preventing auto-negotiation from happening.
> +	 * MaxLinear advises to manually clear the bit after 10ms.
> +	 */
> +	schedule_delayed_work(&priv->clear_raneg, msecs_to_jiffies(10));
>  }
>  
>  static void gsw1xx_pcs_link_up(struct phylink_pcs *pcs,
> @@ -636,6 +658,8 @@ static int gsw1xx_probe(struct mdio_device *mdiodev)
>  	if (ret)
>  		return ret;
>  
> +	INIT_DELAYED_WORK(&priv->clear_raneg, gsw1xx_pcs_clear_raneg);
> +
>  	ret = gswip_probe_common(&priv->gswip, version);
>  	if (ret)
>  		return ret;
> @@ -648,16 +672,21 @@ static int gsw1xx_probe(struct mdio_device *mdiodev)
>  static void gsw1xx_remove(struct mdio_device *mdiodev)
>  {
>  	struct gswip_priv *priv = dev_get_drvdata(&mdiodev->dev);
> +	struct gsw1xx_priv *gsw1xx_priv;
>  
>  	if (!priv)
>  		return;
>  
>  	dsa_unregister_switch(priv->ds);
> +
> +	gsw1xx_priv = container_of(priv, struct gsw1xx_priv, gswip);
> +	cancel_delayed_work_sync(&gsw1xx_priv->clear_raneg);
>  }
>  
>  static void gsw1xx_shutdown(struct mdio_device *mdiodev)
>  {
>  	struct gswip_priv *priv = dev_get_drvdata(&mdiodev->dev);
> +	struct gsw1xx_priv *gsw1xx_priv;
>  
>  	if (!priv)
>  		return;
> @@ -665,6 +694,9 @@ static void gsw1xx_shutdown(struct mdio_device *mdiodev)
>  	dsa_switch_shutdown(priv->ds);
>  
>  	dev_set_drvdata(&mdiodev->dev, NULL);
> +
> +	gsw1xx_priv = container_of(priv, struct gsw1xx_priv, gswip);
> +	cancel_delayed_work_sync(&gsw1xx_priv->clear_raneg);

Nitpick: why did you place this after dev_set_drvdata(dev, NULL) and not before?
The work item doesn't call dev_get_drvdata(), true, but it's one more refactoring
step that needs to be taken care of if it should.

>  }
>  
>  static const struct gswip_hw_info gsw12x_data = {
> -- 
> 2.52.0


