Return-Path: <netdev+bounces-64611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C07835EAA
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 10:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E3AFB216A4
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 09:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A01E3A1A0;
	Mon, 22 Jan 2024 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqReZBA1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28443C6A4
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 09:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705916925; cv=none; b=C9WHe5uP2Mi8H8InmMtYn1XJxhuPnEAYLiDcL2EQBcbHIzgGHvBXp36feulJxxNLnO9xJNm6RrPuaNv4yswOk6S2czW6wuw3LP7wwna/DwnRuhx8nyJnHSnSbKEH1WW2tVvyGPuWDK6nD72wZ3NdWF6zKs6HJHl3AQtS5MXg7X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705916925; c=relaxed/simple;
	bh=5K8tPnMFa+QKo6kdGyT8j7IyjQOFivKvAkI+ZSEhqg4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZCAfa5FyfKTjx2AkQBg7NbOMIAMhMLY3RXwKhhWYgENaQMI6+oif0qx8gW7NqNjZu2I+dJv6MXO2ET81LhcXWG6XemXMG+eFwG0/vgfM9xUQIGs68o4NnZ8BlITzzybs/GIuNo3d2CvpplXqqPS4faDatfQOTi1o9KNkRLdkaO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqReZBA1; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55790581457so3839148a12.3
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 01:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705916922; x=1706521722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NTW4B+3J6fWtPaE3vAIyW/f9uxJ4MJ00NaVmb9ONWFU=;
        b=aqReZBA1yg08yh+M5akecjzBlqaklxNFlpKHdW/alUNrYlgiYYYiXjNyyByA1pWSpC
         y3RWnEJl5CjXzBTf1HLA0cOXerykKzbJSx52Tat/ZbMrsxD0Zhz6gkghp3COJeb9SSRc
         qmGdYY+HzobMa2aKjsFudFiMZh13DFRK2biR0mK8BBNTalxaCipRF0wA43Spz9VFxaLe
         0GimC1GrgXjPcoqpFfAxTpoHFqxQneg0sNL7l4jgWiNPbsymgqlcGJs5N+pzn/6X781b
         gbDQA/81fNcxcSMWxTmXpxNWUhHW4+aOO/vf55wpPufs52hukIXQYqucuKytHKMOWnhT
         Cqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705916922; x=1706521722;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTW4B+3J6fWtPaE3vAIyW/f9uxJ4MJ00NaVmb9ONWFU=;
        b=E1G4ETOUN+VuH6YTgR0QibJXR1jAtDCqas9h9XmPHeeoV5+O2onKkG3SwI8bf8H0R/
         BFFDq8iOhXUHSq0sXAZ9qWOEVDcW5gVePxH/W2eXmGSrGNfuJtahiZQXsmmBZJYG8HtS
         8gvaMbJ8ninydJ7F9SyUSo30fErSH4g6pwa9cbl8wOEewKIG1/mjaAKTvj2LXqGhSB9K
         KW377QO7gAG6PtbUehpGkcPtX5IcAA4dh20ekJZ49swInLSpaECfR1hGcl4YdC7zXX4G
         XjWxoMT9UBwbCDE+oA4aVpkA0mVRI9nk04xWcRkf2U3Yq6xCJ1C5a63r5PqakC72kAQ1
         BalQ==
X-Gm-Message-State: AOJu0Yw4G5e/II7xpwJ6fQ0jWyqsrxGyY0oFqUWhATtk4efHfw+AS1SF
	N6xRpAMiOuq0oKIqdDYAhtSJ9xPX1Y55EepcAH+gmvvhuN7feZF9h11QOeN9
X-Google-Smtp-Source: AGHT+IEavQ83XZ2/jzwSqH4YJChVMGe/+aLkCu/cbbfBqRQfJwxeJzVG8anxRq6Jw45FzrlOyOhjjw==
X-Received: by 2002:a17:906:c9d5:b0:a27:be67:1743 with SMTP id hk21-20020a170906c9d500b00a27be671743mr1739408ejb.40.1705916921542;
        Mon, 22 Jan 2024 01:48:41 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id vk6-20020a170907cbc600b00a2ecec00a88sm6197060ejc.99.2024.01.22.01.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 01:48:41 -0800 (PST)
Message-ID: <05f333aa-5457-409a-8f53-148b9f4d0da9@gmail.com>
Date: Mon, 22 Jan 2024 10:48:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Race in PHY subsystem? Attaching to PHY devices before they get
 probed
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To: Network Development <netdev@vger.kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Robert Marko <robimarko@gmail.com>,
 Ansuel Smith <ansuelsmth@gmail.com>, Daniel Golle <daniel@makrotopia.org>
References: <bdffa33c-e3eb-4c3b-adf3-99a02bc7d205@gmail.com>
Content-Language: en-US
In-Reply-To: <bdffa33c-e3eb-4c3b-adf3-99a02bc7d205@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.01.2024 08:09, Rafał Miłecki wrote:
> I have MT7988 SoC board with following problem:
> [   26.887979] Aquantia AQR113C mdio-bus:08: aqr107_wait_reset_complete failed: -110
> 
> This issue is known to occur when PHY's firmware is not running. After
> some debugging I discovered that .config_init() CB gets called while
> .probe() CB is still being executed.
> 
> It turns out mtk_soc_eth.c calls phylink_of_phy_connect() before my PHY
> gets fully probed and it seems there is nothing in PHY subsystem
> verifying that. Please note this PHY takes quite some time to probe as
> it involves sending firmware to hardware.
> 
> Is that a possible race in PHY subsystem?
> Should we have phy_attach_direct() wait for PHY to be fully probed?

I don't expect this to be an acceptable solution but it works as a quick
workaround & proof of issue.

[   24.763875] mtk_soc_eth 15100000.ethernet eth2: Waiting for PHY mdio-bus:08 to become ready
[   38.645874] mtk_soc_eth 15100000.ethernet eth2: PHY mdio-bus:08 is ready now

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 3611ea64875e..cdb766b0ea22 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1435,8 +1435,21 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
  	struct device *d = &phydev->mdio.dev;
  	struct module *ndev_owner = NULL;
  	bool using_genphy = false;
+	unsigned long time_left;
  	int err;

+	if (!try_wait_for_completion(&phydev->probed)) {
+		netdev_info(dev, "Waiting for PHY %s to become ready\n", phydev_name(phydev));
+
+		time_left = wait_for_completion_timeout(&phydev->probed, msecs_to_jiffies(20000));
+		if (!time_left) {
+			netdev_warn(dev, "PHY %s is still not ready!\n", phydev_name(phydev));
+			return -EPROBE_DEFER;
+		}
+
+		netdev_info(dev, "PHY %s is ready now\n", phydev_name(phydev));
+	}
+
  	/* For Ethernet device drivers that register their own MDIO bus, we
  	 * will have bus->owner match ndev_mod, so we do not want to increment
  	 * our own module->refcnt here, otherwise we would not be able to
@@ -1562,6 +1575,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
  		phydev->devlink = device_link_add(dev->dev.parent, &phydev->mdio.dev,
  						  DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);

+	complete(&phydev->probed);
+
  	return err;

  error:
@@ -3382,6 +3397,9 @@ static int phy_probe(struct device *dev)
  	if (err)
  		phy_device_reset(phydev, 1);

+	if (!err)
+		complete(&phydev->probed);
+
  	return err;
  }

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 684efaeca07c..d95b68dfad59 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -541,6 +541,7 @@ struct macsec_ops;
   * struct phy_device - An instance of a PHY
   *
   * @mdio: MDIO bus this PHY is on
+ * @probed: Completion of PHY probing
   * @drv: Pointer to the driver for this PHY instance
   * @devlink: Create a link between phy dev and mac dev, if the external phy
   *           used by current mac interface is managed by another mac interface.
@@ -636,6 +637,8 @@ struct macsec_ops;
  struct phy_device {
  	struct mdio_device mdio;

+	struct completion probed;
+
  	/* Information about the PHY type */
  	/* And management functions */
  	struct phy_driver *drv;


