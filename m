Return-Path: <netdev+bounces-250233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E28D2588A
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 16:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4363D302FA18
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A7F3AA181;
	Thu, 15 Jan 2026 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aQhxvalr"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD15342C8C;
	Thu, 15 Jan 2026 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492634; cv=none; b=GcEvl837AK9ALIzHFeYPI73DK/azfhRLQTUY7g1XagKTYCLIgHJC3JA5vd2EClXnTaUAsoNH37qZ9/RtugSeYLmUDsuv5o+8wXVTp9oRbCy1sHtJgzX/fGgXGbvXPNFEN9PhjWUGJNJPZi7y+rVz9e4BzuB2TxGgMVJIdE+0ymo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492634; c=relaxed/simple;
	bh=ywR0+JyW3GhWBkZ1KB2J4rEhiXHlGT9nSW7vKvv39go=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MojlLFEyZLzfkFGf3iFC4+AoEzZUGZgDmk4a/uSSm4HynWlTehMQUzIv8Vshd3JtvApldivnGsMFluoO/MytlNUHXHA2fvmhaBmNE2lpitO0NPDisfW2vT5BT/LtFRAqjucmwcl/RvREzLlpUsSd5fqJc4WgisUaibkgDzSH90A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aQhxvalr; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D85421A2882;
	Thu, 15 Jan 2026 15:57:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A97C5606E0;
	Thu, 15 Jan 2026 15:57:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 27BC210B686A5;
	Thu, 15 Jan 2026 16:57:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768492628; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=FpRgOFqqngW/gkWxICQqQe85bw00qydcvqkHvIMosJ4=;
	b=aQhxvalr18lEXfBQysPbaE0I7Y8B1Q8yowVbbn10QE912u5ila3rjk+btdEUQ753F2LA+Y
	ZZM7QhPPuPTezZGtLRUDeFs8RNRlMboxjOJY3fZmf4uyjtFK5Zoz4BPoz5qPoRhDFSeVKz
	CALlduuTSjqOO1GAdJf3+K4JZhWGz3blObFckH1hz3cGEh5P/J8jT/1IIIIvXuQBQaA288
	NJYj/UL6CwfNk+uRAYUEU7ycPiFvo9fIm+dfe32tf/CEuMqdZKQJyYq1udWIsmXDcbI7vt
	8UpNxT8rETFmS7UHNT5rDJ5IJ0uLeNNdRt3jUOUdiQiIsp/+e0E7x1Yw6lpCAQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: [PATCH net-next 0/8] net: dsa: microchip: Add PTP support for the
 KSZ8463
Date: Thu, 15 Jan 2026 16:56:59 +0100
Message-Id: <20260115-ksz8463-ptp-v1-0-bcfe2830cf50@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEwOaWkC/y2MSw7CIBQAr9K8tSRAW2i9iumCz3tKTGkFNI1N7
 y5Rl5PJzA4ZU8AM52aHhK+QwxIriFMD7mbiFVnwlUFyqbjgI7vn99Cplq1lZdZp2TqjybgOarE
 mpLB9bxeIWFjErcD0Mwkfz7ovf21NRuaWeQ7l3LTGE0mtUPeC9wK1tth5Grwc0VjhiA+9IkswH
 ccHapPqXLMAAAA=
X-Change-ID: 20260109-ksz8463-ptp-bc723ca7fac4
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

This series aims to add two-step PTP support for the KSZ8463 driver. It
depends on a previous series that was recently applied to net-next:
https://lore.kernel.org/all/20260105-ksz-rework-v1-0-a68df7f57375@bootlin.com/

I've encountered weird behavior with IPv4 and IPv6 layers -- maybe that's
related to the incompatibility with the Linux stack mentionned by commit
620e2392db235 ("net: dsa: microchip: Disable PTP function of KSZ8463") ? --
So the support is only added for the L2 layer.

Patches 1 to 4 add IRQ support for the KSZ8463
Patch 5 adds specific dsa_device_ops for the KSZ8463
Patches 6 to 8 add PTP support for the KSZ8463

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
Bastien Curutchet (Schneider Electric) (8):
      net: dsa: microchip: Add support for KSZ8463 global irq
      net: dsa: microchip: Decorrelate IRQ domain from port
      net: dsa: microchip: Decorrelate msg_irq index from IRQ bit offset
      net: dsa: microchip: Add support for KSZ8463's PTP interrupts
      net: dsa: microchip: Add KSZ8463 tail tag handling
      net: dsa: microchip: Enable Ethernet PTP detection
      net: dsa: microchip: Adapt port offset for KSZ8463's PTP register
      net: dsa: microchip: Add two-step PTP support for KSZ8463

 drivers/net/dsa/microchip/ksz8.c        |  18 +---
 drivers/net/dsa/microchip/ksz8_reg.h    |   1 +
 drivers/net/dsa/microchip/ksz_common.c  |  95 ++++++++++++-----
 drivers/net/dsa/microchip/ksz_common.h  |   6 ++
 drivers/net/dsa/microchip/ksz_ptp.c     | 180 ++++++++++++++++++++++++++++----
 drivers/net/dsa/microchip/ksz_ptp.h     |   9 ++
 drivers/net/dsa/microchip/ksz_ptp_reg.h |  11 ++
 include/net/dsa.h                       |   2 +
 net/dsa/tag_ksz.c                       | 104 ++++++++++++++++++
 9 files changed, 369 insertions(+), 57 deletions(-)
---
base-commit: 3adff276e751051e77be4df8d29eab1cf0856fbf
change-id: 20260109-ksz8463-ptp-bc723ca7fac4

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>


