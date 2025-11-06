Return-Path: <netdev+bounces-236351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D981DC3B098
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 13:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C5674F971B
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 12:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3930F32D0C6;
	Thu,  6 Nov 2025 12:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KYATowHQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04142D531;
	Thu,  6 Nov 2025 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433601; cv=none; b=YncuTuk+wPkWbD/8LsgfosXpc9GWg+zxt5Gkq+8xvCjU7mqdgmHz9lta2KzFHX2cDv1jlxV2FEhU9UwaDO6ItSe6j2TnN+ovg1QuhxvoAoVtvNwFq3X4Ta0pZga/GCuzkUHQKBxZE/rsCCLl7uwwqffY4rVQ8grpIoY8uHCB92U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433601; c=relaxed/simple;
	bh=T2qqAIkGOjgeE12cY01soizOVyB2zgKxML7ZlYxcWl8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kmnO3hiDKL4N0WCgU9QCeIgDk9g/7oPiJs6ltAMjHlXfxfWrt12am9dXmQPeYsOCXzzcbY1U1DcCX9arJcjo7EMYJ0SVIcrfZeuD236gxLWUoeHrnHtKaUSpa22bxry9+hZ4iJ2E+q0MNhfYldn5gX3oEGG89CjWDEtgrOq+s/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KYATowHQ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 25791C0FA8A;
	Thu,  6 Nov 2025 12:52:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F9506068C;
	Thu,  6 Nov 2025 12:53:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 446A211851002;
	Thu,  6 Nov 2025 13:53:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762433595; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=AZ1qEQt0C6rmw6jWPJAozV0mbsRRxIGiRl5di1gTL00=;
	b=KYATowHQm407dFfUrqN7izPUJ+L/5enlObTBFs+O6dqWoAeD5kgMHRGfxmTbXGhr7ZKgqy
	r8jW77VMN/ctThA/QnX9BilUF/3EpP9/bUQdpESB0/ppxzF9btNirD/2d5uA5V7+enYm4l
	FVU1DKj9gEsSZtU32SwDMNJ2zLHne0E01m0wlpgaBlFp5Wwa7u0Y4gEQLfMTh9sfaely5Q
	SwKBQsrBiszNEFuUy38kgLNl3dhHKikApZD0ZnAquBpBj0ONnjtYd7ODgiOwpuyjjJiZR7
	zVYgEgS6lzb8yRkI8kGBKtQcSrnl5zrfRVoPkkRU430QF8vomn93ZfFg/JOerw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: [PATCH net v2 0/4] net: dsa: microchip: Fix resource releases in
 error path
Date: Thu, 06 Nov 2025 13:53:07 +0100
Message-Id: <20251106-ksz-fix-v2-0-07188f608873@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADOaDGkC/2WMyw7CIBBFf6WZtRgepQ2u/A/ThS2DnahggDRqw
 79L2Lo8596cHRJGwgSnboeIGyUKvoI8dLCsV39DRrYySC614Eqwe/oyR29mZ9Vr68ZBaQf1/Yp
 YdStdwGOGqcqVUg7x0+qbaNNfaBOMsxH7waIxBq04zyHkB/njEp4wlVJ+Ifz2jKUAAAA=
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
Changes in v2:
- Add Fixes tag.
- Split PATCH 1 in two patches as it needed two different Fixes tags
- Add details in commit logs
- Link to v1: https://lore.kernel.org/r/20251031-ksz-fix-v1-0-7e46de999ed1@bootlin.com

---
Bastien Curutchet (Schneider Electric) (4):
      net: dsa: microchip: common: Fix checks on irq_find_mapping()
      net: dsa: microchip: ptp: Fix checks on irq_find_mapping()
      net: dsa: microchip: Ensure a ksz_irq is initialized before freeing it
      net: dsa: microchip: Immediately assing IRQ numbers

 drivers/net/dsa/microchip/ksz_common.c | 14 ++++++++------
 drivers/net/dsa/microchip/ksz_ptp.c    | 17 +++++++++--------
 2 files changed, 17 insertions(+), 14 deletions(-)
---
base-commit: cd2f741f5aec1043b707070e7ea024e646262277
change-id: 20251031-ksz-fix-db345df7635f

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>


