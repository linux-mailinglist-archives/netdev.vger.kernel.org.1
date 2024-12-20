Return-Path: <netdev+bounces-153697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F879F93D1
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 14:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206631895A5D
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 13:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30E6216E1F;
	Fri, 20 Dec 2024 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7RiPE7Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51002215708
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734702633; cv=none; b=Q2+fHHXazBQQUPna6j1uflWh2jTYQC07AMXIzW5OCITRVJx9Phnr5Xr7U6kB2jzaD/w61+XilRWP5SJCl6/r5xdjF3eH0AUG8//F3VuW2kTfuW+MrHDfr272U/JN+PclvBjeur6i0EQ1rYJ9zNKey1Q9FDc2R8jBHK79gShlwsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734702633; c=relaxed/simple;
	bh=micaLZrPL6OrR7XZ+UppXRXrJJ+ALgKuZz2PTwlqwqc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ocaBDqx48hNxjyQT84aKWg63NjKgXk09ifz5SJRFztyxUgvsICGTpw6gwkrZ6gAMtgS39TUI6yg27avgLiULXLr13fbx6nY/9yILQbupD8SVxWuslGgIkpXM0HVu9o6miVJ8ClTg/FAs0jn0NXdeVCNnBjJia9z0jHTDOn6pjcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7RiPE7Z; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9e44654ae3so287816666b.1
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 05:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734702631; x=1735307431; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiRDtiX7FSZcVWrOnsEJETLWic7+NitAWtv2OzT2Tmw=;
        b=k7RiPE7Z8kCIUMfaxA3W05nJaz8nPr4bf/9dXjTil1nBYcHHk82z/IsB9MM7mIcq4/
         V5GMuNUQRXGLKq1mF41YBq76XIXIBuNVuFv5QgqolvyZ0ldiGE9LiYfTbljT0KMN/axG
         LXwzk4K3neU+ZS7qyJg0DCHco1xUOJrZ9r8RY2OmfKCRycX70Nh3mKIRt/hylZzLE1uz
         tAm/09c99PfbiMLyQXNE5wBOUUp50zKwfZdBHLY7yX0+U+yzzzGAQ/+ZSDbCBGq6LJTe
         TotmOsyMrpbnaO/y5iDwf/gh8BNrzNQZdeYiTiVMo27i2bOvZxS2aA51kwpudUV69FtR
         oIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734702631; x=1735307431;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fiRDtiX7FSZcVWrOnsEJETLWic7+NitAWtv2OzT2Tmw=;
        b=GcwTU5kJ9VT24o8cQctdNgA8nXvvw83X3C8eiW6D4fcylkDyzopvsC3C8uM1AJXqGn
         Cdofb6zHeujMDjOJHIGRlCW69aMGTlGtRF9Xkd8fik6ZbKEwW7aJ4nsmvPIAcwtbYbpP
         NvEfqbYACDlCxFiMkBSRgPxYrckFMRE988690wCL6FDR09yJu7NeN8w4l1WrrRnbGVP5
         YVqFA95Ggd4LU4Yrmj6ccP25719mfrmejk6TrabdVwvTgMsCI0PuUn0CI44NprRL5cUV
         6P915cFa/552o/us5akDjCPSatZb4U0tWqjVOI4szXhcoon47pEw62M6R4I+2/u4uNyo
         GFdA==
X-Gm-Message-State: AOJu0YwvNKCiYQ0FMZVq6f8cYW6Ijnt+IYiJhk1te9gNBDlsA090WUL2
	ih7GrImPX7Y/gcs5uT7DbJwxR3N6V+UEVdog/khSHOaelRdlnOy5
X-Gm-Gg: ASbGncvqFMBlF5ZZjtfRCQ3WUtBH7rvpyitwJVK+fSFFSgK+lvqRfV2i9CDD9zMGb3Z
	KzsEY174xFh4IJ4wx0dvyyc1PMNZ7V+SgCCTBhfUSwnolbNyY6IGbwBDfKjceQmhNViF0wiNg/T
	RYr7oVeye+IS1Dbh0Vhy+Wl07W0pHwptdJyMLxphg+b7UTYsG7ZAz3WJIqB65vDA9u/X55GhhPX
	rpyPQerzM8ocjrp3oAYRLLIAdMprQAA8X49bvoETZwQdR/XXHhI+8uoJPFFjmQ6HfiPCa9Up8pT
	uvUxZYk/DXrLbV7VpblFbMFMDyRBA2/BgoRAIYisTMruG44j9SnsL2SO84xxDa5Mjpzuxo8kPvm
	1tRp+PFIkAkQzXpOwmIifNhEFcCdHx2vMO685Wm1D4UDP6KCH
X-Google-Smtp-Source: AGHT+IEASDq5GBus8P+VWo8iEwdHmP2biyyGMoj1+MnjKOt7uZzFXPwJPps7w+sFdqDjX/pafURkrw==
X-Received: by 2002:a17:907:d9e:b0:aa6:8676:3b3b with SMTP id a640c23a62f3a-aac2cc722f0mr224746266b.30.1734702630347;
        Fri, 20 Dec 2024 05:50:30 -0800 (PST)
Received: from ?IPV6:2a02:3100:a560:5100:8565:bec9:a1c7:2d82? (dynamic-2a02-3100-a560-5100-8565-bec9-a1c7-2d82.310.pool.telefonica.de. [2a02:3100:a560:5100:8565:bec9:a1c7:2d82])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0f014decsm179556066b.149.2024.12.20.05.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 05:50:29 -0800 (PST)
Message-ID: <942da603-ec84-4cb8-b452-22b5d8651ec1@gmail.com>
Date: Fri, 20 Dec 2024 14:50:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 Woojung Huh <woojung.huh@microchip.com>,
 Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
 Tim Harvey <tharvey@gateworks.com>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/2] microchip/micrel switch: replace MICREL_NO_EEE
 workaround
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On several supported switches the integrated PHY's have buggy EEE.
On the GBit-capable ones it's always the same type of PHY with PHY ID
0x00221631, so I think we can assume that all PHY's with this id
have this EEE issue. Let's simplify the erratum handling by simply
clearing phydev->supported_eee for this PHY type.

Heiner Kallweit (2):
  net: phy: micrel: disable EEE on KSZ9477-type PHY
  net: dsa: microchip: remove MICREL_NO_EEE workaround

 drivers/net/dsa/microchip/ksz_common.c | 25 -------------------------
 drivers/net/phy/micrel.c               | 12 ++++++------
 include/linux/micrel_phy.h             |  1 -
 3 files changed, 6 insertions(+), 32 deletions(-)

-- 
2.47.1

