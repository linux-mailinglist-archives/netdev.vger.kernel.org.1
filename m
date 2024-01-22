Return-Path: <netdev+bounces-64568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D35835B63
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 08:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5BC6B24318
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 07:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AC0DF61;
	Mon, 22 Jan 2024 07:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyFevWtu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28348DF54
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 07:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705907403; cv=none; b=SaSN+Vv11CzzbhUpu6EKEcKZwCYTE2Ou4hAleiJgWauOky94n73KcP64cgNTgm2B8L4EHIMNy3ijatrHfYG9/DLYa4asec8WDVpXSwfDNltPY39geN3CBKvgNyOFxB4LO+cXT3Fc6Vv+uv+UOKN9S4AezypR52/KOfvCv5NdSTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705907403; c=relaxed/simple;
	bh=pwFRrgKpkxKFy6hH38Kve6ZIxGaQDXFJJpqMk2XXqYw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=ZrjbNiI2nIDJP/rIXmGMGIpEdecv5AYtMhfIBH8IAAvcGvtwaF+6i0CsPDa7hEzdxtSR09Xrage7fhP49gcaKxCh1K6+MGS87nkz/I8QXKW/mRV7LjMaseO2oRCZliPTfNDLxk3tgFr5olpgJ3ry1mn2wyb+PWFJMgYhdKDNitA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyFevWtu; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55a349cf29cso3081730a12.0
        for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 23:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705907400; x=1706512200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIVpVahN8if7Ws1n8y5moE/HlMuPKFAfwUqkOSB6vLE=;
        b=TyFevWtuTjQYsjT2JRMeTAKu6NQTMprA29EfQelQNoDhzR4+lgEwI5StI/1ch0pfDU
         iqDeT7z3S0/xk8L72s3ViiaKWY2D5SbqG7bb6R4j5q4w3mr75Gsh5xQdusE3+RgJTfPl
         6aParLureTyBiDNaLx0jJQZ9LhOJ0TVfaVQzK7WnnJqJqX5UmE/sPWBVY5ITGH+4aMIC
         a/WRkXUvafnMRpPlihzuVkqGuo4fDFP+g+0CDLi44pG9442u6bR6x8vhS5Hwx0dQ4H/0
         3Etti1cEcQLSUemh9t7J4MHMLPBUvO6hwZoNOKbtli+DsVAOY5GAfNgG41kjDuXs8zLi
         KjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705907400; x=1706512200;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WIVpVahN8if7Ws1n8y5moE/HlMuPKFAfwUqkOSB6vLE=;
        b=dDkxq8PM0q26g4vYpiO3UzZp1vDwJae7GyFsLQKQ16pWcuzJJ7PjYihj74/Oza7z17
         NJvXKDrhWlRUNBtyjhlJKIvXHaip0uHjKVSCulod/V3s3xDLKRqrOuoGvBVCIv80AqHE
         r0c9UuyBJw7mCEY9UEOJldgMA06ABUvuKab2qVNTRCXbKnOTckJAJOHMbS6R+B7F9Guh
         bY52ZPvdZn2wgNKWdByjHeTM/WFclEYmgtZysvKjhjO6RxZEw5xom4RxOa4QatodF2Dq
         w0d/utPsV3Zx6yMKpzVf4x7c9lC4bejZyURKsKuJKFuN3LZbqn8Fp4ctm7IHMMojXyA4
         /VYg==
X-Gm-Message-State: AOJu0YyK7a2iLABHepqg8hcyESDVuPr4VX9rwZOCJPyAO4XELwaMO+24
	/7WDW5moSFK1mxYSARZY8OZ+bB2NGm+fbBi1986LsNvFozGDJl6aXYjfXFAC
X-Google-Smtp-Source: AGHT+IHc7ZHrcbuQZb0OmVls5+xlIwaOQmvcjqu07o7GriL917nl3GYZRhtBRhQeZs8beS2TYp0BWw==
X-Received: by 2002:a05:6402:3551:b0:559:fa58:6bdc with SMTP id f17-20020a056402355100b00559fa586bdcmr2067150edd.55.1705907400020;
        Sun, 21 Jan 2024 23:10:00 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id fd4-20020a056402388400b0055864f99f78sm13815317edb.20.2024.01.21.23.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 23:09:59 -0800 (PST)
Message-ID: <bdffa33c-e3eb-4c3b-adf3-99a02bc7d205@gmail.com>
Date: Mon, 22 Jan 2024 08:09:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Race in PHY subsystem? Attaching to PHY devices before they get
 probed
To: Network Development <netdev@vger.kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Robert Marko <robimarko@gmail.com>,
 Ansuel Smith <ansuelsmth@gmail.com>, Daniel Golle <daniel@makrotopia.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

I have MT7988 SoC board with following problem:
[   26.887979] Aquantia AQR113C mdio-bus:08: aqr107_wait_reset_complete failed: -110

This issue is known to occur when PHY's firmware is not running. After
some debugging I discovered that .config_init() CB gets called while
.probe() CB is still being executed.

It turns out mtk_soc_eth.c calls phylink_of_phy_connect() before my PHY
gets fully probed and it seems there is nothing in PHY subsystem
verifying that. Please note this PHY takes quite some time to probe as
it involves sending firmware to hardware.

Is that a possible race in PHY subsystem?
Should we have phy_attach_direct() wait for PHY to be fully probed?



I verified this issue with following patch although -EPROBE_DEFER didn't
work automagically and I had to re-do "ifconfig eth2 up" manually.

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 3611ea64875e..3be499d2376b 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1437,6 +1437,11 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
  	bool using_genphy = false;
  	int err;

+	if (!phydev->probed) {
+		phydev_warn(phydev, "PHY is not ready yet!\n");
+		return -EPROBE_DEFER;
+	}
+
  	/* For Ethernet device drivers that register their own MDIO bus, we
  	 * will have bus->owner match ndev_mod, so we do not want to increment
  	 * our own module->refcnt here, otherwise we would not be able to
@@ -1562,6 +1567,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
  		phydev->devlink = device_link_add(dev->dev.parent, &phydev->mdio.dev,
  						  DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);

+	phydev->probed = true;
+
  	return err;

  error:
@@ -3382,6 +3389,9 @@ static int phy_probe(struct device *dev)
  	if (err)
  		phy_device_reset(phydev, 1);

+	if (!err)
+		phydev->probed = true;
+
  	return err;
  }

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 684efaeca07c..29875a22ac89 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -634,6 +634,8 @@ struct macsec_ops;
   * handling, as well as handling shifts in PHY hardware state
   */
  struct phy_device {
+	bool probed;
+
  	struct mdio_device mdio;

  	/* Information about the PHY type */

