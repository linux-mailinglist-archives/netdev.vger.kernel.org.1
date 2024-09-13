Return-Path: <netdev+bounces-128035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF46977906
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 08:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96514B2383D
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 06:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1150F1B9822;
	Fri, 13 Sep 2024 06:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqE3lE/W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980EE143C40
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 06:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726210560; cv=none; b=OfqlYTrDlF4OGNiGC5Dsbltnw5Vv+ScU0h9cSv8Mp+0Oo5KR6h1gUM08xrObocHb3gIgjal6ng6qMzOqmcixz0Y2qm83uNMFBYKduiNjZQQya3Xp/wV9KVGRFHpArmSY2GcqDwFMoi28hPBSnd1yvFv6NQU9URLAFBMwECGrQ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726210560; c=relaxed/simple;
	bh=+IB31neNBAaaK5KMZGJ0OGZ7hH8oDmyZP84LzVmuv1M=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=F2wiqY2J7V1Pmt9gq7HqqwYxwqwAJD5lpCM/5xcQ/7JmwlTiYpNlFh/2WnpisVN9clXNJA1jkPekETYWMOF7uGWygib/clrsF6xj4rUHvwlSJ1G5skTkdIzAuyKdbdr8G5HaU/+WSW2QXE5eRW7iGiNZ/p+h8jF2cA+EoPO6st4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqE3lE/W; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71781f42f75so1468167b3a.1
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 23:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726210558; x=1726815358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWjElHykvPg1H2Mb/QLtYag64jQO5JIWejhgJBgtezg=;
        b=CqE3lE/Wr8Ht3xds9EFbJ0euuc8beazvrIhdVoxY1T/1QvzAWcMMT92fVLXt6JhUbz
         xD7e43VBLf1a1a3cOd0yue7o6TV997p6QTBDCJq57csXFOBe49PNQJDt+aUdeU/+Wya4
         41d0fwb67nizXr/lQeUlPTtcpi+F13v7uGFxubY7QphJiEtSmM8Bo2dbZIr1Ue1Ef3WA
         7nkeO27mNUezP2wkMe5RlSJrpcTrtdtMm/VdLzKvz+kujeSm1ezZO0QWNQMP4nB8zDyt
         y3xx86lKEbnk1cMPrp3TRBR0TOAaPDCZnd0g1rx/iBQqArcJFMFWxQDllA6Rry7Crhz9
         bpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726210558; x=1726815358;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rWjElHykvPg1H2Mb/QLtYag64jQO5JIWejhgJBgtezg=;
        b=uuKqu0+ryQy2CqIDS7dy/kpkZ+zs9Ha/Gd+iZ4tMTyqn86RnpbvAROS4blsC1YKW3+
         ybyO46ouvXd4RLQyp9pQCLfBY249Kvq6oyrJwmKsaX1pF7i9Kgeaj1NYUtsGY5WNrNrh
         8lv5CW9Htjhi9/81iL3mics20Tc/t26v0O0C/U78mHpKxPpsQRGuh2F1YPHSQo2az+LT
         eQWEbQRFgECrHkplbgRd9Itj3+j3qiG64T14IjDhuSueRMJ0ZDVibt6eYSZFYjj8XXR6
         27dEZAV7B49Pe2ep3aHGQ0R/9IYuA+qhkn55nC+/Ek1bdudtDgnUKMosC/GclQ+SXwDH
         H+Dg==
X-Gm-Message-State: AOJu0YzJ/PE5hCAWq4ZBRDUMwggD47S+5jNqxVkb9KjlTDfompILCGzB
	ZUkL2i3O8FmwIXkgx2Pq1klMV1AKlYFMAmPbky2JuCqhUYCWLqON
X-Google-Smtp-Source: AGHT+IEGEXqQE4mBHYVh/mRAwY2CIBSRx5ZJoU/YEsKUnLcq0yAMk/upHvfYNJ4Dy73jOKiQgmR/bw==
X-Received: by 2002:a05:6a21:58d:b0:1cf:29a8:8e1c with SMTP id adf61e73a8af0-1cf75f6544fmr8665455637.28.1726210557606;
        Thu, 12 Sep 2024 23:55:57 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fba4866sm2782864a12.3.2024.09.12.23.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 23:55:57 -0700 (PDT)
Date: Fri, 13 Sep 2024 06:55:43 +0000 (UTC)
Message-Id: <20240913.065543.2091600194424222387.fujita.tomonori@gmail.com>
To: hfdevel@gmx.net
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, fujita.tomonori@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next 5/5] net: tn40xx: register swnode and connect
 it to the mdiobus
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <trinity-e71bfb76-697e-4f08-a106-40cb6672054f-1726083287252@3c-app-gmx-bs04>
References: <trinity-e71bfb76-697e-4f08-a106-40cb6672054f-1726083287252@3c-app-gmx-bs04>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,
Thanks a lot for the work!

On Wed, 11 Sep 2024 21:34:47 +0200
Hans-Frieder Vogt <hfdevel@gmx.net> wrote:

> diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
> index 4e6f2f781ffc..240a79a08d58 100644
> --- a/drivers/net/ethernet/tehuti/tn40.c
> +++ b/drivers/net/ethernet/tehuti/tn40.c
> @@ -1781,7 +1781,7 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	ret = tn40_phy_register(priv);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to set up PHY.\n");
> -		goto err_free_irq;
> +		goto err_unregister_swnodes;
>  	}
> 
>  	ret = tn40_priv_init(priv);
> @@ -1798,6 +1798,10 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	return 0;
>  err_unregister_phydev:
>  	tn40_phy_unregister(priv);
> +err_unregister_swnodes:
> +	device_remove_software_node(&priv->mdio->dev);
> +	software_node_unregister_node_group(priv->nodes.group);
> +	software_node_unregister(priv->nodes.group[SWNODE_MDIO]);

Why this workaround is necessary? The problem lies on software node
side?


> diff --git a/drivers/net/ethernet/tehuti/tn40_mdio.c b/drivers/net/ethernet/tehuti/tn40_mdio.c
> index af18615d64a8..bbd95fabbea0 100644
> --- a/drivers/net/ethernet/tehuti/tn40_mdio.c
> +++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
> @@ -14,6 +14,8 @@
>  	 (FIELD_PREP(TN40_MDIO_PRTAD_MASK, (port))))
>  #define TN40_MDIO_CMD_READ BIT(15)
> 
> +#define AQR105_FIRMWARE "tehuti/aqr105-tn40xx.cld"

This firmware is for AQR PHY so aquantia directory is the better
place?


> +static int tn40_swnodes_register(struct tn40_priv *priv)
> +{
> +	struct tn40_nodes *nodes = &priv->nodes;
> +	struct pci_dev *pdev = priv->pdev;
> +	struct software_node *swnodes;
> +	u32 id;
> +
> +	id = pci_dev_id(pdev);
> +
> +	snprintf(nodes->phy_name, sizeof(nodes->phy_name), "tn40_aqr105_phy");

This doesn't work on a system having multiple TN40 cards because it
tries create duplicated sysfs directory.

I uses a machine with TN9310 (QT2025 PHY) and TN9510 (AQR105 PHY).


> +MODULE_FIRMWARE(AQR105_FIRMWARE);

AQR PHY driver better to have the above? Otherwise, how about adding
it to tn40.c? It already has MODULE_FIRMWARE(TN40_FIRMWARE_NAME).

