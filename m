Return-Path: <netdev+bounces-124829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDF496B18D
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF1C1F26FC6
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 06:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A83E12FF70;
	Wed,  4 Sep 2024 06:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axp78i71"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C910E839E3;
	Wed,  4 Sep 2024 06:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725431276; cv=none; b=Y4JXdsuS6ZMV8YRhcAxagFijtZKVLTpG+qShVbSteoCMyX7fL47lTz+9sV6cEPyOnvhnQ6t9ef3zVLKApV/59secGVLF6X7ktrwJLWBwkM3ZUHKHSStdM6CVRthMJvEeH+gKoRFO0t54lX9pxtrkSKJHoEYBjkWxW19NZDQhi0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725431276; c=relaxed/simple;
	bh=/hR7oE5rD34yYMNFtglnDXIIRWhzxe9ZiozA9ZnY0AI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jEY9LnSp41iEkrgWtg467FV2eLo6LUf3VZkHYVyC4tvLpuhXvVT1ZpEEeSb77K84W72Hh7KRQmKZV06Do4KAbGyB9MDrKNOBVsHjwqFJ2htZ3JFIE/dgRMvvFHn0YtRlK1rJ8tluWolqHC5AcjWp+TjOs7rQSRpIGW7zXONDbiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axp78i71; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8696e9bd24so726863466b.0;
        Tue, 03 Sep 2024 23:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725431273; x=1726036073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3cR17WKmnO3O1r/gxAkuWpcX3/AmzMnfS+4RPLgbtek=;
        b=axp78i71trqDiGNDiGXrRJrAYbQ5C+2qcJv0i1Y9W0XxxpnjDntlh/bKsEYUtXh5Xl
         kuHKr9vRu6v+cRWVNAwCH7QIvNVS06jjqALj0dsoDNMyVfhZAEaNd1d3+xLR/ZJo38mL
         +kz8RD6DpJfH1133E+M7hzDv02MRm2/pmjHZabg5qW7DocS/lXdzjI0aCJXxhv9oFNMa
         LX6nM74uLwfUyLvcNloVfdua4Ybs0Y8Pq4sQiBWWPoVjj2PNP/NuK6fgubmPjIX8Sy2H
         zX2YY8ZvVTDV1DbCvh0P/Lpxio1+BK68Uw9w1gOKWBkAvz+kNaaHE4FzEvzdgpgfnLYH
         kjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725431273; x=1726036073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3cR17WKmnO3O1r/gxAkuWpcX3/AmzMnfS+4RPLgbtek=;
        b=pQeojc6aTICiL6SSRjs8qXump3AGUqM4eBK8/zgoBUhccJPfNdiwWnZeBoTpRpNtdR
         EYlxxFlO/AB6cb8mICEjp4hlcI8Q8wlsX8iev1O12d5x1tnLcOINvzwHEFOmo2m9Brzd
         wNF3EsVj3LKGJ9tfLoyE0BhoOXN64k54q3vzJE6CqqAw5oogHZ5p/qmcS14KDOW6ILb8
         CIUA5biCT5Vhopk0WF2Hg0N2GMxZummIR6dV/m7LkizbdpRSohC0tIXyVEPOQff38sKm
         Pr6qlYrBwkz7fDS8VowcG77Qg/PfrHKBUGi+6VuAET71bJXe22ay29+IMNflyMvfRSGM
         rZTw==
X-Forwarded-Encrypted: i=1; AJvYcCXUFQnRKvv0BYYNkjWxebBqJWwZ3+dZS2ZsuR1ZbttAn6T8mgz5neu4QNN54aW2fCCSNMRXUzITms/AAiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOmT02npBj5FHqPCE4ifK/TG0KFpGHkPRMQbd7asJSnJrZZ5e3
	jIM+JxA69jD2rf3qBxgAH1AVutprJbm9t+m9GMjnYP18iWw4qhAV
X-Google-Smtp-Source: AGHT+IGxt/6cM1zV52278ktD9kIm7uvWmSOe912Z/g3/5IxC8jx7LnbTZNGTR45Iqv2VBWyJ8ME+5g==
X-Received: by 2002:a17:907:1c0a:b0:a7a:ab8a:380 with SMTP id a640c23a62f3a-a897fad872amr1585706366b.69.1725431272652;
        Tue, 03 Sep 2024 23:27:52 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988ff0465sm768659666b.29.2024.09.03.23.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 23:27:52 -0700 (PDT)
From: vtpieter@gmail.com
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Arun.Ramadoss@microchip.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristram.Ha@microchip.com,
	o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH net-next v4 0/3] net: dsa: microchip: rename and clean ksz8 series files
Date: Wed,  4 Sep 2024 08:27:39 +0200
Message-ID: <20240904062749.466124-1-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

The first KSZ8 series implementation was done for a KSZ8795 device but
since several other KSZ8 devices have been added. Rename these files
to adhere to the ksz8 naming convention as already used in most
functions and the existing ksz8.h; add an explanatory note.

In addition, clean the files by removing macros that are defined at
more than one place and remove confusion by renaming the KSZ8830
string which in fact is not an existing KSZ series switch.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
v4:
 - correct once more Kconfig list of supported switches

v3: https://lore.kernel.org/netdev/20240903072946.344507-1-vtpieter@gmail.com/
 - rename all KSZ8830 to KSZ88X3 only (not KSZ8863)
 - update Kconfig as per Arun's suggestion

v2: https://lore.kernel.org/netdev/20240830141250.30425-1-vtpieter@gmail.com/
 - more finegrained description in Kconfig and ksz8.c header
 - add KSZ8830/ksz8830 to KSZ8863/ksz88x3 renaming

v1: https://lore.kernel.org/netdev/20240828102801.227588-1-vtpieter@gmail.com/

Pieter Van Trappen (3):
  net: dsa: microchip: rename ksz8 series files
  net: dsa: microchip: clean up ksz8_reg definition macros
  net: dsa: microchip: replace unclear KSZ8830 strings

 drivers/net/dsa/microchip/Kconfig             |  9 ++--
 drivers/net/dsa/microchip/Makefile            |  2 +-
 .../net/dsa/microchip/{ksz8795.c => ksz8.c}   | 13 +++--
 drivers/net/dsa/microchip/ksz8863_smi.c       |  4 +-
 .../microchip/{ksz8795_reg.h => ksz8_reg.h}   | 15 +++---
 drivers/net/dsa/microchip/ksz_common.c        | 48 +++++++++----------
 drivers/net/dsa/microchip/ksz_common.h        |  4 +-
 drivers/net/dsa/microchip/ksz_spi.c           |  6 +--
 include/linux/platform_data/microchip-ksz.h   |  2 +-
 9 files changed, 57 insertions(+), 46 deletions(-)
 rename drivers/net/dsa/microchip/{ksz8795.c => ksz8.c} (99%)
 rename drivers/net/dsa/microchip/{ksz8795_reg.h => ksz8_reg.h} (98%)


base-commit: e5899b60f52a7591cfc2a2dec3e83710975117d7
-- 
2.43.0


