Return-Path: <netdev+bounces-105237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96180910394
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CAD32824E1
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561C31A3BD3;
	Thu, 20 Jun 2024 12:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P58NPsxb"
X-Original-To: netdev@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C540417624F;
	Thu, 20 Jun 2024 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884912; cv=none; b=cpNxAkMXDXbb4JGbkagJN0Jhz7/WeXqSKqV9YmyToeFbNGjfkIA7ARRIBnxzzWTRt/FP2K0DZXrOYAbS1+TuoX2/BunZ4sBvHwrnLUsENngNyVCf/0tSOa9xGLzE5Pu1x0Q+KKJJqr3wagphymWA2TBL5y+Q5QWanh4kc0kB5r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884912; c=relaxed/simple;
	bh=44jT47uxvSqtxPu6Hxlw+zdrnDpt/6ElaowOEbMY2fo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pb99olLzKOCgCF2EweJCpH2F9Bd2NWPI/h8p/T/Xmaj16aduN7smY05C/HFQBdL0qwVr1UR9Ivwl8sgzwSALwiPhO7VFgCy0Bsbh3qImXnQNHQQh4gpUJl6L7t061yWFYbFvL3BiFFloORHCZkVwbVfmwUAcp4cn6k5yQl/Xe2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P58NPsxb; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay5-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::225])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 274E1C43F0;
	Thu, 20 Jun 2024 12:01:40 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPA id 779E21C0009;
	Thu, 20 Jun 2024 12:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718884892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PnQ2sB04PBZJkmTZEXzRmhxrKl7ImxLHLvFpmMS5gUA=;
	b=P58NPsxbPYQi8uvzGJiRw7SZpwfZ5I2Z5gAz2+FX6xy/IbRe0kC2bNNd83yRWjgKLhBbYC
	hLE6HRMFQLEXswgX2qs2iVJRTMp/Ys8UZEpQlaz3vyuedxz4E7dsv4NLT8Nn0JjNz3C5hz
	2PdEUiIuOKmF/ChkVoJ1Mxb+lUcj/sv+e4lsPYVkL/kiLPYTmIv6LS7toMBCLxUZ9jou7K
	cqVRRvjsAtOOEmPdl2vxmCicExvyzYT+b2WY19COLnUFf0FDpsU829QlcFGkF1XVG+BGAB
	LVN0QpThvnaa9wjxL4Kh3rsy81aFX7LIOd5LTX4Adt0xdOwbRoHsnPHv5yPxxQ==
From: Herve Codina <herve.codina@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH net-next v3 0/2] Handle switch reset in mscc-miim
Date: Thu, 20 Jun 2024 14:01:23 +0200
Message-ID: <20240620120126.412323-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

These two patches were previously sent as part of a bigger series:
  https://lore.kernel.org/lkml/20240527161450.326615-1-herve.codina@bootlin.com/

v1 and v2 iterations were handled during the v1 and v2 reviews of this
bigger series. As theses two patches are now ready to be applied, they
were extracted from the bigger series and sent alone in this current
series.

This current v3 series takes into account feedback received during the
bigger series v2 review.

Best regards,
Hervé

Changes v2 -> v3
  - patch 1
    Drop one useless sentence.
    Add 'Reviewed-by: Andrew Lunn <andrew@lunn.ch>'
    Add 'Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>'

  - patch 2
   Add 'Reviewed-by: Andrew Lunn <andrew@lunn.ch>'

Changes v1 -> v2 (as part of the bigger series iterations)
  - Patch 1
    Improve the reset property description

  - Patch 2
    Fix a wrong reverse x-mass tree declaration

Herve Codina (2):
  dt-bindings: net: mscc-miim: Add resets property
  net: mdio: mscc-miim: Handle the switch reset

 Documentation/devicetree/bindings/net/mscc,miim.yaml | 10 ++++++++++
 drivers/net/mdio/mdio-mscc-miim.c                    |  8 ++++++++
 2 files changed, 18 insertions(+)

-- 
2.45.0


