Return-Path: <netdev+bounces-144093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CFB9C5A84
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 15:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44456B29464
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717601422D8;
	Tue, 12 Nov 2024 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uY2tL0PP"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC1142AA4;
	Tue, 12 Nov 2024 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418644; cv=none; b=Jsdm5mKLGt2tatlVJSDvDGyYpXXadBIEtVWObCIozC1BvzJf6LxCX2Vr5oFRxThlH+ONyzRYkjrHmP33CKrbivRjTdyCA71L7F3JudLTEmsAiOBTmtY9qvv/rAzwLMk+Q2ZEOMgpNTHmsZAFsyAmobJWb4PiWbLIvrs5FUCklZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418644; c=relaxed/simple;
	bh=EVYtzQGT3MSF63g4iCllL2nKr5PUl0YgthsgBXSWCjo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P9WB9Wq5a388qZBtqqE3FMG09iLo2ZwRQdbaapuM/L0KqQULCzrXKT1v+tdg4becMu6N3zb24QeGrSd0JWm3nppKnxoCc3RJBETfVGTPio/DiOiBEQGT5h7YPdX2cCTBqgWMsWBmFPdjkXgrLKY4iX0saYhlGS4OEIXK8ieh0Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uY2tL0PP; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731418642; x=1762954642;
  h=from:to:subject:date:message-id:mime-version;
  bh=EVYtzQGT3MSF63g4iCllL2nKr5PUl0YgthsgBXSWCjo=;
  b=uY2tL0PPtCMJhMNZ2jWuI0Y/ABpZN0GlP9IGS4yi/sCb9TXxtE76TbP/
   /H0esl3SVGNLDvsCACts8jzUqvfT8Few7OE4FkH0sGO+Qq4aKuyoLxBXJ
   ktXs+rNZW2QXTG8OSgC3r/sUk5SC9rfW1cuKQ+OA2RtnwVU3QRf1DzCHP
   SXJSftW/uvWPDLOSUeA8SM9XUAMqqz9XT1aQZbjMqC1vDGSri4mBq7ETy
   IO6qOr1h7gqKrUTVtwWyUUSLw+Q0KMlqLW2FPMrdEGfpLDNFzrEewfa5/
   SFCyM38X+gfz0dSRXh8toP91rC574h830e6OxcBQyB+oiazuC1nHWoE2A
   w==;
X-CSE-ConnectionGUID: MrNChj17QCGoNOgRM4DkTw==
X-CSE-MsgGUID: pxuDztyERIyMkw3B1dHC1w==
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="201634987"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Nov 2024 06:37:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Nov 2024 06:37:05 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 12 Nov 2024 06:37:01 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v3 0/5] Add ptp library for Microchip phys
Date: Tue, 12 Nov 2024 19:07:19 +0530
Message-ID: <20241112133724.16057-1-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adds support of ptp library in Microchip phys

Divya Koppera (5):
  net: phy: microchip_ptp : Add header file for Microchip ptp library
  net: phy: microchip_ptp : Add ptp library for Microchip phys
  net: phy: Kconfig: Add ptp library support and 1588 optional flag in
    Microchip phys
  net: phy: Makefile: Add makefile support for ptp in Microchip phys
  net: phy: microchip_t1 : Add initialization of ptp for lan887x

 drivers/net/phy/Kconfig         |   9 +-
 drivers/net/phy/Makefile        |   1 +
 drivers/net/phy/microchip_ptp.c | 997 ++++++++++++++++++++++++++++++++
 drivers/net/phy/microchip_ptp.h | 217 +++++++
 drivers/net/phy/microchip_t1.c  |  40 +-
 5 files changed, 1260 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/phy/microchip_ptp.c
 create mode 100644 drivers/net/phy/microchip_ptp.h

-- 
2.17.1


