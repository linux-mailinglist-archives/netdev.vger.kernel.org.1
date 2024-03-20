Return-Path: <netdev+bounces-80818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFA28812B2
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 14:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB411286246
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 13:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC424207A;
	Wed, 20 Mar 2024 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="00nZnuth"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D4E41C92
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710942697; cv=none; b=KMjBbgdTCjqbl7+5HWNkScU/akegqtBKi3Sv4Of2psMzBkMSwumnVSCoqc8SAyiQdl6bIGEqoYXeuL4vhhrtJeXCB5cgJGl6jEjh3gHHxA8lavM8Jdpa3Q0wCyA9FRlypJsm3WgLfRAUdw5Bw5Nvzd7Q1Lc7VxufF2JUuaSUWrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710942697; c=relaxed/simple;
	bh=zYX1XdCiM/J/TZCdb9pgctiZ9o4mjVDtCcATQD2Nq3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFeO3HCZguuR9/ZXqFJAcrwusqNsN16MSKUv3jjaAZpkOdaS4pKXVY+6Dn47l5zmzrbtf/8OY2W4WxOv07w0n1DobwF5JZdG4Veldas0uQKcB0z2ge/uonElwz+hD6hsP1Hx1s8CrC8D4h7aDM0A6GjPswPuvio0nuqwIhmri0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=00nZnuth; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513da1c1f26so7972544e87.3
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 06:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710942691; x=1711547491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rLgVIWrsH99Tdm6W0KA5TMaz4bhoDoQetV9XucEEMb4=;
        b=00nZnuthZXCHLm741KVYXEwP7u9rlAXTgb/c7cFAwdR1gtQ2pADCNgSPEELdhZb6au
         R19AK1siRtF+XNP/NwHEBuA2YBx4GnYZEWXyNm6vpEwb/rhqQyXnZ8BALBZkFBqoKdlX
         AU+cijJT/Ev8a0j/dyX1jv8dOUp9Dvrl7+gEyFi74qcg1USvHiimFH7kRf3Ksn6yvFX3
         frMe2Ipux359NQp4S8qJtp708kGsY2d14B3rZUmQi/E+cZkqmNfu+SqHUYjgWrXqk3Dv
         hl9y8VRviTHnzuL/QZyR4nsiiS1EDpFcwLe0YdU3hq4NYBruksSO9dNngpvYaET1sZRC
         vLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710942691; x=1711547491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLgVIWrsH99Tdm6W0KA5TMaz4bhoDoQetV9XucEEMb4=;
        b=Twa/hMromHEKoBPmxEJOZCEafjXaG1VcxCe0xqn/xrSxpz1vuRNqCdgtsaAfS8T5Cd
         y1Pl0iOSIm6lrdGBSbWkcFnIXKHGzcAQqWlfNMA+4XdvFQfVrqCxpHcUlITLn4ReQ8Yp
         KTqxDV2/s8sXyBntyoEf6RsNR1n3NdjpdDOuy99EK+NSke1mwxcZs1Gl8PGVz/P8bRi7
         bf27nXjRmKyBfC+Lea4KqMzBpEce0+furyFd8UMzC7/KCkoQivTC/KyzGlI407hw5bZU
         qtlevK1QXe2Mpa15ZK3hPC1RUnFPhcYng9+P6pVqdOG9M7Seq/f6gXfHH9YuoE/260Ll
         VRAg==
X-Gm-Message-State: AOJu0YwqM4pSljBmkaiylpBiVoIkqmwJUO39jTv7aE9FLKwi507GkH0e
	tGrGLEzqoeszKmAnb3NJRwKyaDAeVh43BYN7upKjM23Ij9PzLdFeCAoxLHwlhQ4=
X-Google-Smtp-Source: AGHT+IEsglMPSjFRtFTQ8SFDCL0ugC7y9eK0vOdPKea84vD6CAVGiDs000/3sKroYNcSGWDrgoLYWg==
X-Received: by 2002:a05:6512:538:b0:513:c5d6:8356 with SMTP id o24-20020a056512053800b00513c5d68356mr12498197lfc.12.1710942691398;
        Wed, 20 Mar 2024 06:51:31 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c4f0800b004130378fb77sm2309533wmq.6.2024.03.20.06.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 06:51:30 -0700 (PDT)
Date: Wed, 20 Mar 2024 14:51:29 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com,
	linux-kernel@vger.kernel.org, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even when
 PHY does not
Message-ID: <Zfrp4bwpC-ywjZ6_@nanopsycho>
References: <20240320042107.903051-1-Raju.Lakkaraju@microchip.com>
 <20240320042107.903051-3-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320042107.903051-3-Raju.Lakkaraju@microchip.com>

Wed, Mar 20, 2024 at 05:21:07AM CET, Raju.Lakkaraju@microchip.com wrote:
>Allow WOL support if MAC supports it, even if the PHY does not support it

Sentences like this one usually end with "."


>
>Fixes: e9e13b6adc338 ("lan743x: fix for potential NULL pointer dereference with bare card")
>Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
>---
>Change List:
>------------
>V1 -> V2:
>  - Repost - No change
>V0 -> V1:
>  - Change the "phy does not support WOL" print from netif_info() to
>    netif_dbg()
>
> drivers/net/ethernet/microchip/lan743x_ethtool.c | 14 ++++++++++++--
> 1 file changed, 12 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
>index 8a6ae171e375..7509a19269c3 100644
>--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
>+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
>@@ -1163,6 +1163,17 @@ static int lan743x_ethtool_set_wol(struct net_device *netdev,
> 				   struct ethtool_wolinfo *wol)
> {
> 	struct lan743x_adapter *adapter = netdev_priv(netdev);
>+	int ret;

You use "ret" only in "if (netdev->phydev) {" scope, move it there.


>+
>+	if (netdev->phydev) {
>+		ret = phy_ethtool_set_wol(netdev->phydev, wol);
>+		if (ret != -EOPNOTSUPP && ret != 0)
>+			return ret;
>+
>+		if (ret == -EOPNOTSUPP)
>+			netif_dbg(adapter, drv, adapter->netdev,
>+				  "phy does not support WOL\n");

How about to chenge the flow to:

		ret = phy_ethtool_set_wol(netdev->phydev, wol);

		if (ret == -EOPNOTSUPP)
			netif_dbg(adapter, drv, adapter->netdev,
				  "phy does not support WOL\n");
		else if (ret)
			return ret;

to avoid double check of EOPNOTSUPP?


> 	}
> 
> 	adapter->wolopts = 0;
> 	if (wol->wolopts & WAKE_UCAST)
>@@ -1187,8 +1198,7 @@ static int lan743x_ethtool_set_wol(struct net_device *netdev,
> 
> 	device_set_wakeup_enable(&adapter->pdev->dev, (bool)wol->wolopts);
> 
>-	return netdev->phydev ? phy_ethtool_set_wol(netdev->phydev, wol)
>-			: -ENETDOWN;
>+	return 0;
> }
> #endif /* CONFIG_PM */
> 
>-- 
>2.34.1
>
>

