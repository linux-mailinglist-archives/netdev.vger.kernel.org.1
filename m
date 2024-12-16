Return-Path: <netdev+bounces-152271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796279F353D
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36CC7188A8DA
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88EF1494D4;
	Mon, 16 Dec 2024 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="snY3Yoj/"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451EB53E23;
	Mon, 16 Dec 2024 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365064; cv=none; b=fA3VbzixQKmFwo1E1b7+FL+6xHcBUeuPlgRXWdMkNtqf2rojOCGu+QvbzDk84M1QBwXcqPSXtBqAVC94b38zrpS9It/YjgbwxKnnueL1Qf4Kl4Yk3ypdVb91DEyRzpmMKIzDXlIRtcGcKstm/Y0Sm234fMgsmlDBCPF+KmSFUBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365064; c=relaxed/simple;
	bh=/OimIa+kX30dAA/umIi2Z1jbNGd5rj46NtkjAiAlRUM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q/eeJakxppAl5UCao3nVI3Sl/jVZhAZf9uKiCRLhtjV+wTvNNoTdUQOqzp+fWRKnIl8wCwUOO22wvuO0KFA+dRYotaY1fAiYlKB7kYEUp0ULKX0YBmtF44NCKWqmFvDseDJFIgy6dU6SJK9lF+qS+3L5cIFxV2FMJKtSyFlX5+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=snY3Yoj/; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734365063; x=1765901063;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/OimIa+kX30dAA/umIi2Z1jbNGd5rj46NtkjAiAlRUM=;
  b=snY3Yoj/kdFKHHN3Zco21rqnTOEhKhuO0SzN4TZou8n1q7w5hVBjUaIa
   w+UKCg5DC6hEgUyWNnqjOzA/9y1u7O9nW8LV2VrSpzE4+k3P9HTqNq9gE
   P6G3pX50D62D+MFX7KjleBqks0d6w5X0BGG6tKX81YIQi2E3CNPhuM6fE
   4BeYc67b8aJjEQYRFzhUN7g25+YxF+FrILvqaxvH961FWDcOfJumBqE/M
   uR0hyIdSXoPToeqdkbXOD8mfOOOwbXo+xU8hErifVtMwvM3e+vxf8W8cs
   9iNBYKzvvFPwwoEA7zkhAgRiKA/bCUSe+pXG2UF8I4te+y5Xh+l56uWX8
   g==;
X-CSE-ConnectionGUID: ppauGyd6SneWrNsUY4zGVw==
X-CSE-MsgGUID: piP2k7QyR6q3D6MDl3sF9Q==
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="39312300"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Dec 2024 09:04:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 16 Dec 2024 09:04:13 -0700
Received: from HYD-DK-UNGSW20.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 16 Dec 2024 09:04:09 -0700
From: Tarun Alle <Tarun.Alle@microchip.com>
To: <arun.ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 0/2] Add auto-negotiation support for LAN887x T1 phy
Date: Mon, 16 Dec 2024 21:28:28 +0530
Message-ID: <20241216155830.501596-1-Tarun.Alle@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Adds support for auto-negotiation and also phy library
changes for auto-negotiation.

Tarun Alle (2):
  net: phy: phy-c45: Auto-negotiation restart status check for T1 phy
  net: phy: microchip_t1: Auto-negotiation support for LAN887x

 drivers/net/phy/microchip_t1.c | 159 +++++++++++++++++++++++++++------
 drivers/net/phy/phy-c45.c      |   5 +-
 2 files changed, 136 insertions(+), 28 deletions(-)

-- 
2.34.1


