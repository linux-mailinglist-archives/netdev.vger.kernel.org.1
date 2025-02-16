Return-Path: <netdev+bounces-166825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF55A377B6
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 22:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCC23A6BB5
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 21:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0BD1A238B;
	Sun, 16 Feb 2025 21:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8P8HEof"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB0A1922E1
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 21:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739740462; cv=none; b=L3N+JrIRDGTSEfJu64iKzWVzDPTx23XSVBjX5Dbjta5NqP0uVSb3qHPK4fur9RXOEwtDHxStdCt9AXNqqajQcfSySRyTpcELHPvEPPVgXWv4c3eSovzjqNSfOstk9V7Ux64F1HCOUCx3r9yzQaQXcY5hvDe1xMufs57pdyWe33g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739740462; c=relaxed/simple;
	bh=6Qr/BtILgtGeQ/ldhpeXoQU9xVNrUcBcbBxWzyjvevA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=qJtHKk15341SH5bC2Ww1bV2Xa39uGRt2dFcsVilFs8xMvHwwMJ+23qsINz5v7OWuDqayEQ9OJx7OyUjXT6ZnpehoKUenfWflI3YvD767aRX9ExVyWAzi6W/TtZwNHCohRfTHgJx3wL4f1es307R+zIM8DsmKnBlVdkkMR+CIrig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8P8HEof; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43690d4605dso22897435e9.0
        for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 13:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739740459; x=1740345259; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjgMhZyARrh9Kn+E9/Tv1ftct8121B//jSwqxpefjXk=;
        b=T8P8HEoflbBZYobhr8cYW6Zsu6VyeBXvR+vqVvgywq9IUqD6ZttewvH/bwGZ3fwYS0
         Wu+I6E0i9pqvlal50nUzdNtO1YXUrlMTRs/5aox0UqJuuoDMqYsswaosaGgRelR8+NaP
         T2N3GH/7cHxy4AGSugHK6v7nCTL5zLQd/R8pH5wFG+QHXD0/m24JNSgCo1LtnS1FvSsX
         eYdSuBXfthVtIH2fKk/CV0K+tKYlQO0J02/JSyqRsbFzQThqiO6nIh2Ina9lw1tYj50L
         ci4ewm1GCXwY/i5EFoge5NVHHbhs+5PnDRDm0hh6P6uDbHaEgOIEe96JPBp89IE0hVqx
         mZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739740459; x=1740345259;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjgMhZyARrh9Kn+E9/Tv1ftct8121B//jSwqxpefjXk=;
        b=YEj46OYYwtGIZVhqPi8gNnmq/nrz+BGXuCzlMz5wdEyqWrmRwKoHn/6nZWQYTq4/Yq
         Gu0EzKspORdmLs3RnJhXMLm/Rj4VCELdnqnQlrj9eZdDg4uFICmyAD24NPKiommkqHFK
         Eb6gahIyVylkZGSZP932lQRNKJ9lLUatjyzzLAz8//ak26+40Ed0EwMtvIndVWyCFJSX
         Wg6EDK+z5rq4tRBoHcESftXdqc8pkT/HBMhbuDM/WOGYY5vkdHxix6ZE/8mbXTU/8eor
         4TKCRe/PoWaWb9wwyzW7V2dtbtUf6DBcY0dtSlla7G+P+MTf/PmoK03mK0rw/zviwxLE
         iVcQ==
X-Gm-Message-State: AOJu0Yz84E/+N3XMNcMQQZ4i9ZTprk4y37fSG6zbKzuG77/VTXee8Bg4
	xW0pYf9NNqTCyE4kDskBsDv4jCcmVAqKNMA8lS2kBAQ0zq3JaC/I
X-Gm-Gg: ASbGnct+rtP7pYxCxS17UQaLdYbyoymvFx8mCmwWjqL0rlo7JDRDpByUDWSyiICBIzc
	oDiSdg6aLxwzYqmAbrjpdfYlArPItXxeHucoZEBmUA38/29zQywPbDSgznJakoLCj4lhJ4vW483
	bCbEKJMCzMclNZ2igjsVqANQ7eas6PQOIId7fPSrbVQdg/Yimj7wi1G9yBwmrnibCHDbmHUbAzJ
	x82uwhSDrevXQLAdNN8P4YL8116YyW/azMnTtWINF479FsXlUwMfZF88FYST6b0Rf1WUQOpKBcY
	QQ9tALF7gHcfly1hsN6N3R/VZrasA+m+G8m90PVAoKplzXULo1i0mUfQORt4ckvNICVHwYWkAIN
	xTXSGdIZnSD2GmR9UXrjCAW1doDQBLXjUTnmil88enxoQuDq5+alUSuoYiEnhLVx9uc7nkEty41
	GXKiGW/Tg=
X-Google-Smtp-Source: AGHT+IFOaJtQllKiG7peaV5Tux4BdS8XuKSKDADpLqGKH7qPDAVWkzY3cYzCpzfc7T4l3iQ8kGL+gA==
X-Received: by 2002:a05:600c:1ca8:b0:434:a734:d268 with SMTP id 5b1f17b1804b1-4396e7015f0mr64675155e9.14.1739740459024;
        Sun, 16 Feb 2025 13:14:19 -0800 (PST)
Received: from ?IPV6:2a02:3100:a14d:c000:1d06:77f1:27f3:ba49? (dynamic-2a02-3100-a14d-c000-1d06-77f1-27f3-ba49.310.pool.telefonica.de. [2a02:3100:a14d:c000:1d06:77f1:27f3:ba49])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38f259d5ef9sm10434758f8f.76.2025.02.16.13.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 13:14:17 -0800 (PST)
Message-ID: <3caa3151-13ac-44a8-9bb6-20f82563f698@gmail.com>
Date: Sun, 16 Feb 2025 22:14:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/6] net: phy: improve and simplify EEE handling in
 phylib
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This series improves and simplifies phylib's EEE handling.

Heiner Kallweit (6):
  net: phy: move definition of phy_is_started before
    phy_disable_eee_mode
  net: phy: improve phy_disable_eee_mode
  net: phy: remove disabled EEE modes from advertising in phy_probe
  net: phy: c45: Don't silently remove disabled EEE modes any longer
    when writing advertisement register
  net: phy: c45: use cached EEE advertisement in
    genphy_c45_ethtool_get_eee
  net: phy: c45: remove local advertisement parameter from
    genphy_c45_eee_is_active

 drivers/net/phy/phy-c45.c    | 40 +++++++++++-------------------------
 drivers/net/phy/phy.c        |  4 ++--
 drivers/net/phy/phy_device.c | 21 +++++++++----------
 include/linux/phy.h          | 20 ++++++++++--------
 4 files changed, 35 insertions(+), 50 deletions(-)

-- 
2.48.1


