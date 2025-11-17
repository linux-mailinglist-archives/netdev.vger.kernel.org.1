Return-Path: <netdev+bounces-239116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3791C64434
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 14:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id C60F623F70
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 13:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0106C32E723;
	Mon, 17 Nov 2025 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sxN/eDWL"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E8032E6B1
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763384766; cv=none; b=T5fWbRbSonstC7XNgSCrEcDJPlrqLHA59HX99JeOl7/FACD3V8aXExBta7+sh9H2K5Pqcag5mVgVwb6kVm+eiu2f3BPBx6z/MU3ia6k70ASYjzL9QOkqa4V6yZQ25orIQ/Yrwicqb4pXBTFpsHW/D6ld8luwrq1vhOyXWM4UUfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763384766; c=relaxed/simple;
	bh=O35jfAIV60r8XSEq4Ew9JZqreKp5zxMWXBKrjcAzhzM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sgri1EeNGAXF0PoNkFWg03XhOpgd/z5xn8QLQrOQdZgHF/kgX1Ue+GMuxcQKI0Wz20JQDgCSfDrwkW/jmKa5iVREJeLxKUZVAsbl+VH45iM/lsDFLFsrpQtEM4RSbwftyTImcRGQooVdOy/iBabWnQHzV/yPn7MgGnNsb/w2rvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sxN/eDWL; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 17F361A1B77;
	Mon, 17 Nov 2025 13:06:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E04AD606B9;
	Mon, 17 Nov 2025 13:06:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D78451037160D;
	Mon, 17 Nov 2025 14:05:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763384761; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=IaNispOv0L7RVd6pdEtnw1JjXMEHsLEzTd72c0w/57M=;
	b=sxN/eDWLSG7HQy2o2LoIVBjqnyyCL/WkUy0KYgsCErr8H59tm7xeWEAn+j+gonsF8BTL16
	SGye7ZSWWV7Vei5Qkt9QkKN996f7Kj3+fQegKcpmrbC7b+6pFb06BN0T0LOV5qXvsXSxJm
	Sv6bmLaHphU2W+ycKRd8fpmYi0iKhfs9Ynf79x6XqS+gjDJ+ngjMWMv6uY/3kzBBajnyjZ
	habkMKjla8J/eNW1HpW7hAus8ZXaFB09kgqdOUoDsrSTuaTt1T2EfdybTc0xHz3gDdtbTo
	sL8C+i5+Jj6m8S/tJPzmxXbEUuX/XkI/GG4MrLIHtxgclTRTbmSKU7LT18SfbA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: [PATCH net v4 0/5] net: dsa: microchip: Fix resource releases in
 error path
Date: Mon, 17 Nov 2025 14:05:41 +0100
Message-Id: <20251117-ksz-fix-v4-0-13e1da58a492@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKUdG2kC/2XMQQ7CIBAF0KsY1mIYoLR15T2MiwKDJWoxpSFq0
 7tL2FTT5f8z788k4ugxkuNuJiMmH30YcpD7HTF9N1yRepsz4YxXwATQW/xQ51/UaiEr62olKkf
 y93PEXJelMxlwIpdc9j5OYXyX9QTltBlKQBmtUSqLbduihZMOYbr74WDCo6wkvkpgapU8S1ZD0
 zjFmqYWWyl+JMhViiw7o7XQrTGCu3+5LMsXdERpmRkBAAA=
X-Change-ID: 20251031-ksz-fix-db345df7635f
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

I worked on adding PTP support for the KSZ8463. While doing so, I ran
into a few bugs in the resource release process that occur when things go
wrong arount IRQ initialization.

This small series fixes those bugs.

The next series, which will add the PTP support, depend on this one.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
Changes in v4:
- PATCH 1 & 2: Add Andrew's Reviewed-By.
- PATCH 3: Ensure ksz_irq is initialized outside of ksz_irq_free()
- Add PATCH 4
- PATCH 5: Fix symetry issues in ksz_ptp_msg_irq_{setup/free}()
- Link to v3: https://lore.kernel.org/r/20251114-ksz-fix-v3-0-acbb3b9cc32f@bootlin.com

Changes in v3:
- PATCH 1 and 3: Fix Fixes tags
- PATCH 3: Move the irq_dispose_mapping() behind the check that verifies that
  the domain is initialized
- Link to v2: https://lore.kernel.org/r/20251106-ksz-fix-v2-0-07188f608873@bootlin.com

Changes in v2:
- Add Fixes tag.
- Split PATCH 1 in two patches as it needed two different Fixes tags
- Add details in commit logs
- Link to v1: https://lore.kernel.org/r/20251031-ksz-fix-v1-0-7e46de999ed1@bootlin.com

---
Bastien Curutchet (Schneider Electric) (5):
      net: dsa: microchip: common: Fix checks on irq_find_mapping()
      net: dsa: microchip: ptp: Fix checks on irq_find_mapping()
      net: dsa: microchip: Ensure a ksz_irq is initialized before freeing it
      net: dsa: microchip: Free previously initialized ports on init failures
      net: dsa: microchip: Fix symetry in ksz_ptp_msg_irq_{setup/free}()

 drivers/net/dsa/microchip/ksz_common.c | 21 +++++++++++----------
 drivers/net/dsa/microchip/ksz_ptp.c    | 22 +++++++++-------------
 2 files changed, 20 insertions(+), 23 deletions(-)
---
base-commit: 50617b23e1bbe59e092327dcf21acc9512a1461c
change-id: 20251031-ksz-fix-db345df7635f

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>


