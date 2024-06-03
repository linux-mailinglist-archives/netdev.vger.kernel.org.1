Return-Path: <netdev+bounces-100193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E433B8D81AF
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 13:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130EA1C21C0F
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9038627C;
	Mon,  3 Jun 2024 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4TQkDJU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AA484A49
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 11:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717415712; cv=none; b=E9RODa7mPd5TGzcJE/nUxt3g27OPovvSI49Wifm7JmjPjVlBMxsN5lRF5rjiQHivzuM1S8QEhlqsD6mC9JbP2jlLyTLvgvCInabODmKLwOnkt8BY1RXZXCmCkj29GsDmpheZ5gYaNVjXdEBL3JzQmwlYUhSAG/+oVJ6jnLJKAEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717415712; c=relaxed/simple;
	bh=UNwXNRXhETYgEVTAc0pkHOLuQwRWQ7c5IFFaR4wWrpA=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZjzoUKsEauF57IjkI7Z+dphElEBsCdORZ4iN17GeR7A8jTAd7SfU3/to0pvCR65OQYuWmCTb+YLGsZR5AwMinOS1GgDl2pMXs+3IymrdUdL7DJJCmkUci2R2DpJZfAazIaKWiT5gPK4ixO/yxlU+HOEU1zTVixJpvpOtSInDH5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4TQkDJU; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6c9cd96e485so144020a12.3
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 04:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717415710; x=1718020510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xM56IKHGZXFA/y3IJJ0E05Uip3ihxC6pONCPTVtvNH4=;
        b=k4TQkDJUNqOxcJLyZ97NSs/7O2v0nnYporiFXm+ikW1cLcv6SIMGk77lS3Jk4Ks1oC
         5cq8YLTVHBt7SAZ2G+H9M9JP5gVfEBJa9VaXE9o4hhTacXxklTEbylwICzs1YVhqortB
         WQU2K1YGLmhTrbUq1H2AUJn8S497VTkQiAAZxIoygY+dwCrf2zq8iHU0nb8+9ODnQs78
         yIPy4Xd6cK3c0c5GaVe9cK7b/oiOSf2kWGQOLX7DpG6PGvB5Aem/HngOpN56B2u3fKF/
         ButKjwyIzgOLLvAA6wyW+WAHyK8Y+2e/DnBJ1a7+09OygGBoyrdr7zZD0p7UEq/4xi02
         wG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717415710; x=1718020510;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xM56IKHGZXFA/y3IJJ0E05Uip3ihxC6pONCPTVtvNH4=;
        b=F0L6az8hxCrqbUv6ECq65T+kiddSlpdM/UN1zY2DrPWh6GKOcdEJJu7l2eMysotSGy
         zBKCzrKaZhS4iiqa9TNPt3MJAc92H1CVyCwrZ0qZk9/wPRVZoCdc51yd/XO5aMjfEeUJ
         InRejg6uE6dZO0tPnl6dojeqbXWd6OstF2M16Q3nbGnyB9vet2SCWSAEEpE7Fc2GZoDc
         5tv5ULcMLnSulifCCg6KMOnLfH7WKzF8+5k12T6bO7dAsUJ4YkFv6227T+fjVTgaDZhW
         HuU0CMGdR9u6iu4P59Y5L+1l/IVbg3RonFG4bKKXNJXUiEK1iYEyHnPbrY07Pp6jsN8t
         1C1A==
X-Forwarded-Encrypted: i=1; AJvYcCWoAYelX0yysnxwype6Bo1Mr7CroXTdlbhb/kKO80AybwW6eejrOoeEuIIFOuYAW95VEKNl4nNO94CJR0gMRiObAHSLai8r
X-Gm-Message-State: AOJu0YyO3qRFitXZ4QliG2OlhTMJiGXN43+ZqE/PI/eeWwnpPWYE0xIp
	YCCi3MJSub6wsfKXYMiqZWbVlzIBoOGdQs9gbGB68E+ffZoJXhJHZik1DqHi
X-Google-Smtp-Source: AGHT+IG6yeFM7jDI75yO4qGw7xJpTbAAf0FuY6P6Qsolmfmj8PdGY/AzLRCAyBvezk8qb6Og4SMecw==
X-Received: by 2002:a05:6a20:5651:b0:1ad:455e:4ae4 with SMTP id adf61e73a8af0-1b26f3a313fmr7732527637.6.1717415709845;
        Mon, 03 Jun 2024 04:55:09 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323eb1fdsm63542965ad.204.2024.06.03.04.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 04:55:09 -0700 (PDT)
Date: Mon, 03 Jun 2024 20:54:55 +0900 (JST)
Message-Id: <20240603.205455.1265693633847576919.fujita.tomonori@gmail.com>
To: linux@armlinux.org.uk
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 horms@kernel.org, kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
 hfdevel@gmx.net, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v8 6/6] net: tn40xx: add phylink support
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <Zl2LSfGqvPUvUoRT@shell.armlinux.org.uk>
References: <20240603064955.58327-1-fujita.tomonori@gmail.com>
	<20240603064955.58327-7-fujita.tomonori@gmail.com>
	<Zl2LSfGqvPUvUoRT@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 3 Jun 2024 10:22:17 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Mon, Jun 03, 2024 at 03:49:55PM +0900, FUJITA Tomonori wrote:
>> @@ -1374,6 +1375,10 @@ static void tn40_stop(struct tn40_priv *priv)
>>  static int tn40_close(struct net_device *ndev)
>>  {
>>  	struct tn40_priv *priv = netdev_priv(ndev);
>> +
>> +	phylink_stop(priv->phylink);
>> +	phylink_disconnect_phy(priv->phylink);
> 
> There is no need to pair both of these together - you can disconnect
> from the PHY later if it's more convenient.

I see. Seems that there is no reason to call phylink_disconnect_phy()
later so I leave this alone.

>> +
>>  	napi_disable(&priv->napi);
>>  	netif_napi_del(&priv->napi);
>>  	tn40_stop(priv);
>> @@ -1392,6 +1397,14 @@ static int tn40_open(struct net_device *dev)
>>  		return ret;
>>  	}
>>  	napi_enable(&priv->napi);
>> +	ret = phylink_connect_phy(priv->phylink, priv->phydev);
>> +	if (ret) {
>> +		napi_disable(&priv->napi);
>> +		tn40_stop(priv);
>> +		netdev_err(dev, "failed to connect to phy %d\n", ret);
>> +		return ret;
>> +	}
> 
> Again, no need to pair phylink_connect_phy() close to phylink_start()
> if there's somewhere more convenient to place it. Operation with the
> PHY doesn't begin until phylink_start() is called.
> 
> My review comment last time was purely about where phylink_start()
> and phylink_stop() were being called. It's the placement of these
> two functions that are key.

Understood. Calling phylink_connect_phy() first in this function looks
simpler. I modified the code in the following way:

@@ -1385,13 +1390,20 @@ static int tn40_open(struct net_device *dev)
 	struct tn40_priv *priv = netdev_priv(dev);
 	int ret;
 
+	ret = phylink_connect_phy(priv->phylink, priv->phydev);
+	if (ret) {
+		netdev_err(dev, "failed to connect to phy %d\n", ret);
+		return ret;
+	}
 	tn40_sw_reset(priv);
 	ret = tn40_start(priv);
 	if (ret) {
+		phylink_disconnect_phy(priv->phylink);
 		netdev_err(dev, "failed to start %d\n", ret);
 		return ret;
 	}
 	napi_enable(&priv->napi);
+	phylink_start(priv->phylink);
 	netif_start_queue(priv->ndev);
 	return 0;
 }


Thanks a lot!

