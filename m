Return-Path: <netdev+bounces-71824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB728553CC
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 21:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 600C2B2ABDE
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 20:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5072113EFEE;
	Wed, 14 Feb 2024 20:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvtGXx36"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9577313EFE4
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707941736; cv=none; b=unD+cEUCAdOml9qqsvEomBgF2Zv/J8yVksYSsIj7vLb+78vh86JvptHAoMALCWpZ5i12bQ8JqAeZzNMaGG4Ysa+bWcnnxzFSsWSr9HkjaGcu0VVWX7yScUDOEw2wLDdKZzn0akefAiP1Gfknzwve3qC4wly7AMS4mJuq6SJ0VzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707941736; c=relaxed/simple;
	bh=CvVv07RsXcrbHmBl3QuBIWaXYcDAnSBH0ZeC6I2pdto=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ahodNse367AO2NHp+rnesRl9gud81d3E39CcTjHWhKWHGgNc2pqRLtRzq5hpBb+u2SqPpm6FUypHwnTbZkBotUjQ+g69yMGFqMFZxAnBRszTtYTvnEsg/JX1wcQ/hRWlGjcCC4bBoEazzNG4kPNj7v1foBf4WCfx9WsNa5IEBcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvtGXx36; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-562131bb958so178051a12.2
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 12:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707941733; x=1708546533; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ol1dHzSVC5ATcr9eevtIefIWfG1qVDwkbLNrbEFgmYc=;
        b=AvtGXx36OmKLmZvnUXQiV/CuxLHkiCkKHJdNi2HPVrC3/9Ubx2WxljFJo5nHspmKyk
         deKi2cZc7Pm0LCbgfBIJqLSmGkdzxltEPH2CQmIL6LJltNtA7Iwm5O0JTmQKRX1mR2pH
         zuzgJGisyEhalRGtncCuoizPMh7vh9YbXNw27UJL2Q2stsmaRY2vOxq7HwN+ExxC+2+E
         G+EJNG9jUuPLSzrVScXwLDHGlCpGmDbOkyLYJxXWP98pLnl+bQEfw+WkZ0+p/A41OdTO
         2ZjGc91CVKLSd3+V4MdSxAHqnCiU5+28tTYgkg0ya4UJuIHUH3GqMAWHL/mtOES/Dc6v
         wcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707941733; x=1708546533;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ol1dHzSVC5ATcr9eevtIefIWfG1qVDwkbLNrbEFgmYc=;
        b=OZNn3IVjzIGYrK/U3GByYWCnfMvS9KIqyePU8Bk/XtqdSR6qMwzLcVnaLrcK2jFcox
         yECzGQ9sCBqr75GCRzoftftI8KtwTdorGkA36IZ7neA9A1xNn56orpIyAwbxjaFLjWc2
         Gdud6kt6sm+yFCp6XI33PiZny6fpEATLlgtLsvLf900hTrsadrflb5YYSZPyWW43MYvo
         TQJW3XD+M+mqoT0KeD73Djvzy2Ij4pyQB67x7ifMp8rS5VyNquqDi5ptiOupU773TjA1
         Jjk9pG1FYKWv+iqZPAsDlRlVEgiC4lwvF8fHlQIZOEI9x8xpGcRQeo/twpd9uMPMVxhH
         dw+A==
X-Gm-Message-State: AOJu0YwRYKKWW6yw5/fufOwNMhhm1nv4k2K9w/X1IVC4kZ8wP/6gOVsU
	Dy7wgE0Ai/5ZlKHtFeAPTQ+ipxNQwXee0M9u116S0sNTH7dnXMscgrDQ8Oo+
X-Google-Smtp-Source: AGHT+IF9h7q59HFqKQ1h2JIyockqwAaowCB0I2ELC3BzH1ZRL7DzFR23I0uZD5hsU2uwgUa+FHwm3Q==
X-Received: by 2002:a05:6402:1254:b0:562:db7:ce19 with SMTP id l20-20020a056402125400b005620db7ce19mr2749102edw.10.1707941732448;
        Wed, 14 Feb 2024 12:15:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWx1qIBl63xd/F8po0BWGB5RndfCrgd+3dyhb5cyg8tS5h1izff+shDw0B1iD2ioRTXO3y1ZOqf2FKDMIGMcWxW8vvZjFLaI+UKP7rUZGvjlCUo6GtvTWC8n+D30Ya78lmI7aRTogZZ/ISYkNpi4n0mm0D08YG6O7jPq4VH0Pmf5jrBF83/I1Pb7DiE/a4+TpAyz0M=
Received: from ?IPV6:2a01:c23:c153:4a00:f92b:249d:fae6:3a40? (dynamic-2a01-0c23-c153-4a00-f92b-249d-fae6-3a40.c23.pool.telefonica.de. [2a01:c23:c153:4a00:f92b:249d:fae6:3a40])
        by smtp.googlemail.com with ESMTPSA id en14-20020a056402528e00b0055fef53460bsm4979118edb.0.2024.02.14.12.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 12:15:32 -0800 (PST)
Message-ID: <558e122f-e900-4a17-a03a-2b9ec4fed124@gmail.com>
Date: Wed, 14 Feb 2024 21:15:31 +0100
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
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/5] net: phy: add support for the EEE 2 registers
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This series adds support for the EEE 2 registers. Most relevant and
for now the only supported modes are 2500baseT and 5000baseT.

Heiner Kallweit (5):
  net: mdio: add helpers for accessing the EEE CAP2 registers
  net: phy: add PHY_EEE_CAP2_FEATURES
  net: phy: c45: add and use genphy_c45_read_eee_cap2
  net: phy: c45: add support for EEE link partner ability 2 to
    genphy_c45_read_eee_lpa
  net: phy: c45: add support for MDIO_AN_EEE_ADV2

 drivers/net/phy/phy-c45.c    | 69 ++++++++++++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c | 11 ++++++
 include/linux/mdio.h         | 55 ++++++++++++++++++++++++++++
 include/linux/phy.h          |  2 ++
 4 files changed, 137 insertions(+)

-- 
2.43.1


