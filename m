Return-Path: <netdev+bounces-235405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ADEC3016C
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 09:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6764F3AD4A8
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 08:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A962951A7;
	Tue,  4 Nov 2025 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QDVYwoLJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CB028C00C;
	Tue,  4 Nov 2025 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246244; cv=none; b=IlhhTEmFzByFRRXSvLlbW/A6kqa8HoxDXR4rAr7SrGFPYLEsyDqnmzBdfB0tmUZkcHuUaq5vFsVI4pP6MVr2u8D1xLRjtwzkvqK9SL9bK6BjrykKKiuIRCoOsiz8+4uW41DHXdCEby4u4jrguHUB/9fRjwy7XL0MqU75ixmWkMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246244; c=relaxed/simple;
	bh=kd9MzaKY2P3lAQVXy3ADyW75GH363YnfA339htZraFU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G1+hJhFEZBG/lFzas1njjiVugqj8pm40uLd9WvoNcG7RoqzbunX/YNR9CkD5nb3xfwh7t5za15xoXEA5gLRJIWwp9rezeLYe7DX9rhsGyIqnrclDlsbpuNFgdwb4+Or2A6JRhpl0yydoK/J3JLoN+DGAsE/MTPLl9vZ44oYctjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QDVYwoLJ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9BD421A1863;
	Tue,  4 Nov 2025 08:50:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6A142606EF;
	Tue,  4 Nov 2025 08:50:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CB93210B50978;
	Tue,  4 Nov 2025 09:50:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762246239; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=d9AF+LD4wSyE0B6fxtIR82H/MxtrMCNCS83FNJNmHvA=;
	b=QDVYwoLJMlzq4ptDdKkbXjoKl00ESvgtNaBY+LzMQZxUXYEkgBargyIL3EcjTJjkGNXh9z
	anRosDiQzhQbpYwUCvgK9+GHZ2iMOvjVOwI31gsbAPD7OqWbVQQG0QRUNAUgsWmhVh4+b3
	9Dz8kNkUUaJbFZpO+E1uYdhhlQIOTbvhU0eAh/5Vf6lfB3rqh2wMf0tU2yKDyVsNsEhHo1
	HGeMcsfM+wP+VArDmgRzLgBJ5lhRyhX4yRuO9api6pwydIYnIdHDZeGbEFcLccUS8O4S0t
	ONe9smKK1C11qOAGCP2SsF7KDfCHxy0qAUCNOiduV9FMty+i7NAxSMIiT82/Fw==
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next 0/3] net: phy: dp83869: Support 1000Base-X SFP
Date: Tue, 04 Nov 2025 09:50:33 +0100
Message-Id: <20251104-sfp-1000basex-v1-0-f461f170c74e@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFq+CWkC/x3MMQqAMAxA0atIZgOptiheRRyqRs1SpREpFO9uc
 XzD/xmUo7DCUGWI/IjKGQpMXcFy+LAzyloMDTXOGGpRtwsNEc1eOaEnt3S97a13FkpzRd4k/b8
 RAt8YON0wve8HIM6MTGkAAAA=
X-Change-ID: 20251103-sfp-1000basex-a05c78484a54
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Hi everyone,

This series adds support for using the DP83869 PHY as a transceiver between an
RGMII upper MAC and a downstream 1000Base-X SFP module.

Patch 1 and 2 of the series are necessary to get the PHY to properly switch its
operating mode to RGMII<->1000Base-X when an SFP module is inserted.

Patch 3 adds the actual SFP support, with only 1000Base-X modules supported for
now.

Side note: A wider-scoped series adding general SFP support to this PHY was sent
some time ago, but was not pursued, mainly due to complications with SGMII
support:

https://lore.kernel.org/netdev/20250514-dp83869-1000basex-v1-0-1bdb3c9c3d63@bootlin.com/

Best Regards,

Romain

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
Romain Gantois (3):
      net: phy: dp83869: Restart PHY when configuring mode
      net: phy: dp83869: ensure FORCE_LINK_GOOD is cleared
      net: phy: dp83869: Support 1000Base-X SFP

 drivers/net/phy/dp83869.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)
---
base-commit: 32dbca2817e3611165636113f246bed30ef21b3d
change-id: 20251103-sfp-1000basex-a05c78484a54

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


