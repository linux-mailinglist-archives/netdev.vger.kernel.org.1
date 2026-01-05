Return-Path: <netdev+bounces-247046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04636CF3BBC
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 14:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52EDD315A93E
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 13:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEDE22126C;
	Mon,  5 Jan 2026 13:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mi4wJvXK"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F8718C02E
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767618506; cv=none; b=Jb0D8UzNxXPipuTeoTbncF4zxwIXk4yzBO1OTFaGUmvXypcFX2ldKS+3aW6icAajUXRq9vW2+dPqd0kAxK8rvOMHswpX7kGE5F8kIITEZoD2bpT2l/NhmoLORnOGYoNdtSZwP+ZYqgmoioWUkDb1t3n+PCfndo1mIBIiXPBrwc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767618506; c=relaxed/simple;
	bh=ZMJmuucZPZqcB67IIEHgiUnPMYb2B7shbHTAoGvzTFw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cLSNwFe9yXYEQNpOmLOmoOYNBsDedlHPWVsgxu0PrsCDusV+bu4ih0pIDNWjRW0Mma9QbZeggjBmEEmO0HnUvOduyvtVNVaKdFi/pOlCaVP9QhW52HIWYQ/Lhey0/HHZbGL2Y0xj44HFTqvNymRrXMiP/SYhsv69V/4cVXIBw3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mi4wJvXK; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C71CA1A2602;
	Mon,  5 Jan 2026 13:08:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9AC3060726;
	Mon,  5 Jan 2026 13:08:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C0BCF103C8510;
	Mon,  5 Jan 2026 14:08:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767618500; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Xd+4PYI34oxOI6pautgYHulQjPAwKq68/IewyYQx3XM=;
	b=mi4wJvXKs3tyTaM/BXbk4am6DS5cvJcVjAMHQwN+Bwq9/OqKSxX4Q0h2+j8zROwt2qUtby
	AODPGSll4H0PafNaiNRj5D86+f0jrdMSL3NfWkzAwI7SVIaC2BjfB/+KDaxENip63ZGJkR
	K7MbrW9KQLaFlDqpyHbQEU6b4ca8KN0T8adLBe3aUJJlnKvuzRZ98lQtUcOwciFUjKG/FJ
	UTjElEQgh7o3LAfHt363KWzPXzbkOkI/nzD6GfcnpbYAKiKv777qVMIoRWFf1kak3MhfOF
	cWqmRpFfs4zpMQxauFqKKgOg4+iQCBBkY41j+2Lzl1gBYbKnDg87ZJJjSqn/4g==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: [PATCH net-next 0/9] net: dsa: microchip: Adjust PTP handling to
 ease KSZ8463 integration
Date: Mon, 05 Jan 2026 14:07:59 +0100
Message-Id: <20260105-ksz-rework-v1-0-a68df7f57375@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK+3W2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwMz3eziKt2i1PL8omzdROPUVFNzcwuTRHNjJaCGgqLUtMwKsGHRSnm
 pJbp5qRUlSrG1tQCrGJLcZgAAAA==
X-Change-ID: 20251106-ksz-rework-a3ee57784a73
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

This series aims to make the PTP handling a bit more generic to ease the
addition of PTP support for the KSZ8463 in an upcoming series. It is not
intented to change any behaviour in the driver here.

Patches 1 & 2 focus on IRQ handling.
Patches 3 to 9 focus on register access.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
Bastien Curutchet (Schneider Electric) (9):
      net: dsa: microchip: Initialize IRQ's mask outside common_setup()
      net: dsa: microchip: Use dynamic irq offset
      net: dsa: microchip: Use regs[] to access REG_PTP_CLK_CTRL
      net: dsa: microchip: Use regs[] to access REG_PTP_RTC_NANOSEC
      net: dsa: microchip: Use regs[] to access REG_PTP_RTC_SEC
      net: dsa: microchip: Use regs[] to access REG_PTP_RTC_SUB_NANOSEC
      net: dsa: microchip: Use regs[] to access REG_PTP_SUBNANOSEC_RATE
      net: dsa: microchip: Use regs[] to access REG_PTP_MSG_CONF1
      net: dsa: microchip: Wrap timestamp reading in a function

 drivers/net/dsa/microchip/ksz_common.c  | 15 +++++++-
 drivers/net/dsa/microchip/ksz_common.h  |  7 ++++
 drivers/net/dsa/microchip/ksz_ptp.c     | 63 ++++++++++++++++++++-------------
 drivers/net/dsa/microchip/ksz_ptp_reg.h | 16 +++------
 4 files changed, 64 insertions(+), 37 deletions(-)
---
base-commit: cb2200c26cb670ce973b084129a5ff0dcb99b3b4
change-id: 20251106-ksz-rework-a3ee57784a73

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>


