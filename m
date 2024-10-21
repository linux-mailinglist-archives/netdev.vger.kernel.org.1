Return-Path: <netdev+bounces-137471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B699A697F
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49DC91F22CFE
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 13:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B0B1F81BA;
	Mon, 21 Oct 2024 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBbjOS2r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01691E1C3B;
	Mon, 21 Oct 2024 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515762; cv=none; b=in6tJo0TRMMWx6PtIeJfj/KdIpnJtjV+0DH8+lGa3lBYPwKWFDFqRx4ACbuIZCTAZWq9qgQ7/l8RsMUqWdtonJSIKK4Lmf4lzC63g8UYU8A9X36P58UbY62Z8IiYWRk6LKY3lgsnjpy/4hoUEyeVXwpL3ShYxu/QN2m/0rq7aiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515762; c=relaxed/simple;
	bh=4ZZXfEX4GV9IDBhS1AYZHvuhi8EIoqvqAsSYWPfhfI0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=thTU1DrNEFpkFYb1naPbT/ygH9dFHRA2XqeUa0PrwtVqi6jLP+SIS0dNoq9QwfSjEmjJQMMhE6BJgyPLdmP8Aak5a5FMJaeyimm35OdiToI4KhunW47batCGf/NLA3KxOaej3aMIfkILszCeJ3lOy+3b++rDHOXnq3QnYWVbR34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBbjOS2r; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d4b0943c7so3279285f8f.1;
        Mon, 21 Oct 2024 06:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729515759; x=1730120559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=00l+jC2uOyTPd/aiRiRrvwlSjWFTQ2XPXmYmaLpqa4g=;
        b=GBbjOS2rlDnWmGb3hKZerI5YlBlQ+pNoP+mEPYArLYSsvoBFdacCvE+3ylVSSieUWQ
         jidx4O4DgtTwrDsgSfX7hStz0BrIGaFuKbZxRfbHv9p5/8DBG1SzZboWtAq2RXj1rAGi
         sxhGi4gejrAklUum0vzI7OhxyNJoN6GLrTRgBCSXkd1IILXJhxvtV8isZjJW3KUBdiSt
         1CyqOIqmm73qu5sVcUfZxdWYfW1MgWSY0W7xFN2gDu3InWJR+Mm5/1dgV8ea6ENk1dD+
         NpmgEduwfOo74tl1O72vxmmGvs0nMAgRlCqp2cEyj4pdjLVIesVyljJ0C/vDAeRScKM/
         YT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729515759; x=1730120559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00l+jC2uOyTPd/aiRiRrvwlSjWFTQ2XPXmYmaLpqa4g=;
        b=iZaLuw7mKP2eL8QPfOjY6v0cDxOYS4VJKuYLZYutBYHxmMy4QmcI5SjboH5meObdWE
         qdAMft73pqLfmvM8u1p5vc1CI0dYsh9Ofw+DUBRS8YV2rO2zx/Z/5OTKVN6clRz+OjsN
         GVtqWXZXshLDxYum/fvjvR+7LcOYb2HRbUqgT1WlcN0pSYRyqne4tgr4ZQqcjxRpQozC
         QRY/Hx55UAn4iDnMc/3nuJkMMWsCeqdCOtZaHVJ5LYyUrrIHbHrrFFYTPy4v0G2wPbsX
         5zUCYmHTIGG48ElPnB+knO9NhGsMV6JANeILgTMwUZODdHzEbjhyPa5cWmSDSdqRbISg
         Cawg==
X-Forwarded-Encrypted: i=1; AJvYcCUr+ZQJp3sAliC8OGGxeFsuNDSqfgcdHSUJn7XPSFVkHNPBhzdoijTccD3sdIPCKk0iDXyNVEdj@vger.kernel.org, AJvYcCVIOijuQVc27XgEj1yJmhveqA5F/NL5AAhqwrwQLAfIMmjGyTmxMY42kLt8v6V9lXpNEZ2mNOR+bK8c@vger.kernel.org, AJvYcCXWhko5c0DvpTYqaO6SJ783m+2DgFkrYLVBI6no23ivvyZcCO+V0O3/End52AXTygYWY3iqpYUg9Plsr3N2@vger.kernel.org
X-Gm-Message-State: AOJu0Yylbzp8Kfb6dA6aseGrsXaMDP0hwytFcRiylx+v8FEsAYm2sGrK
	8jDkTkrxG4jVqgt1qGbTHhs21KzPTMcxoIhdxAyajLxA3K3GWGYW
X-Google-Smtp-Source: AGHT+IGi4EkVtSyQblvOmjpA4U0smdp9GUxWtw3ocNzEwJ6qTkiBx4UYhqSXBsqxX8gq/Uv/AK3uRQ==
X-Received: by 2002:adf:e787:0:b0:37d:5436:4a1 with SMTP id ffacd0b85a97d-37eab727771mr6738850f8f.3.1729515758667;
        Mon, 21 Oct 2024 06:02:38 -0700 (PDT)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bcfdsm4295329f8f.103.2024.10.21.06.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:02:38 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH 0/4] net: dsa: Add Airoha AN8855 support
Date: Mon, 21 Oct 2024 15:01:55 +0200
Message-ID: <20241021130209.15660-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series add the initial support for the Airoha AN8855 Switch.

It's a 5 port Gigabit Switch with SGMII/HSGMII upstream port.

This is starting to get in the wild and there are already some router
having this switch chip.

It's conceptually similar to mediatek switch but register and bits
are different. And there is that massive Hell that is the PCS
configuration.
Saddly for that part we have absolutely NO documentation currently.

There is this special thing where PHY needs to be calibrated with values
from the switch efuse. (the thing have a whole cpu timer and MCU)

Some cleanup API are used and one extra patch for mdio_mutex_nested is
introduced. As suggested some time ago, the use of such API is limited
to scoped variants and not the guard ones.

Posting as RFC as I expect in later version to add additional feature
but this is already working and upstream-ready. So this is really to
have a review of the very basic features and if I missed anything in
recent implementation of DSA.

Christian Marangi (4):
  net: mdio: implement mdio_mutex_nested guard() variant
  dt-bindings: net: dsa: Add Airoha AN8855 Gigabit Switch documentation
  net: dsa: Add Airoha AN8855 5-Port Gigabit DSA Switch driver
  net: phy: Add Airoha AN8855 Internal Switch Gigabit PHY

 .../bindings/net/dsa/airoha,an8855.yaml       |  146 ++
 MAINTAINERS                                   |   11 +
 drivers/net/dsa/Kconfig                       |    9 +
 drivers/net/dsa/Makefile                      |    1 +
 drivers/net/dsa/an8855.c                      | 2008 +++++++++++++++++
 drivers/net/dsa/an8855.h                      |  492 ++++
 drivers/net/phy/Kconfig                       |    5 +
 drivers/net/phy/Makefile                      |    1 +
 drivers/net/phy/air_an8855.c                  |  187 ++
 include/linux/mdio.h                          |    4 +
 10 files changed, 2864 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/airoha,an8855.yaml
 create mode 100644 drivers/net/dsa/an8855.c
 create mode 100644 drivers/net/dsa/an8855.h
 create mode 100644 drivers/net/phy/air_an8855.c

-- 
2.45.2


