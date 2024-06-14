Return-Path: <netdev+bounces-103691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3F1909129
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 19:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2A491C21828
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 17:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B29519D09C;
	Fri, 14 Jun 2024 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qVVpcqTR"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB69B16D339;
	Fri, 14 Jun 2024 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718385328; cv=none; b=tiO/z/0FQ2vmXMNxQ2VIsusDaBBjTgzoJFfmVeEIp8ftj/nBAantOHdjkWniN4/COOZH9/NwOhjHePVOso+xmhZyS6WjBv7U90ghzL7eXKRxLIJvtSpG2sWFGcJ3dv9LzxjPlfNkK5UBScHrzGHl35EZ5KLA1h4TThWHhMbGUqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718385328; c=relaxed/simple;
	bh=riOoqu/bsmYryWoPNq+qSSg4e9AZz4xSKxN54pv5OL0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZCfHja/l32wKMiYg9z5O2GdUVeFnmlKByJs4mm8JhBVNw6ocU0t0xLke0f/gEvGL4yZYSItp/jOtDiAVPtO4UWcFz5ry5ryXYFwaPnjFY9Lqn1w4b5/0wu0kmFBr2rMv70BV1HKEM8TucAP8I/AJTQEdNdPWSKhOfzUpnWP2Nsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qVVpcqTR; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718385327; x=1749921327;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=riOoqu/bsmYryWoPNq+qSSg4e9AZz4xSKxN54pv5OL0=;
  b=qVVpcqTRoQLLcef4rneU4bb2gHer2aGrLji/yAtuYV0mSdBJY/V8OADT
   tPNPQNZ78nBoIvUV8qftgq7YxiDT4yuOQn+I9uUIEQjqsuzKqMysxkO8I
   pzWwVkHl9klPB4LMeH7DSjGlcApGJd3r855I8WmE1zHGqzaTm8nt4bQZ6
   aAjHYjpNT/u8UNGrp8ET5OsJjPmNUZ+uDZQt2khBjNCTVRBe3FnRFUYqO
   8bk2aDe9SLHR7kV66Xivxy3mWT7v9XD8iJR/OPrreZZaF7I3XmEt339An
   CSshonqNxxddeqFidVwtfQ+bfRRSkLPOFvr35+QBS1XmNNWP29qxxvFBj
   g==;
X-CSE-ConnectionGUID: ARXfGER+SECGbybsuTH9RQ==
X-CSE-MsgGUID: ZTLUcUdIRhmxObbGeYPugQ==
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="258450492"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2024 10:15:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 14 Jun 2024 10:14:58 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 14 Jun 2024 10:14:53 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<bryan.whitehead@microchip.com>, <andrew@lunn.ch>, <linux@armlinux.org.uk>,
	<sbauer@blackbox.su>, <hmehrtens@maxlinear.com>, <lxu@maxlinear.com>,
	<hkallweit1@gmail.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<wojciech.drewek@intel.com>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net V5 0/3] net: lan743x: Fixes for multiple WOL related issues
Date: Fri, 14 Jun 2024 22:41:54 +0530
Message-ID: <20240614171157.190871-1-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series implement the following fixes:
1. Disable WOL upon resume in order to restore full data path operation
2. Support WOL at both the PHY and MAC appropriately 
3. Remove interrupt mask clearing from config_init 

Patch-3 was sent seperately earlier. Review comments in link: 
https://lore.kernel.org/lkml/4a565d54-f468-4e32-8a2c-102c1203f72c@lunn.ch/T/

Raju Lakkaraju (3):
  net: lan743x: disable WOL upon resume to restore full data path
    operation
  net: lan743x: Support WOL at both the PHY and MAC appropriately
  net: phy: mxl-gpy: Remove interrupt mask clearing from config_init

 .../net/ethernet/microchip/lan743x_ethtool.c  | 44 ++++++++++++--
 drivers/net/ethernet/microchip/lan743x_main.c | 48 ++++++++++++---
 drivers/net/ethernet/microchip/lan743x_main.h | 28 +++++++++
 drivers/net/phy/mxl-gpy.c                     | 58 ++++++++++++-------
 4 files changed, 146 insertions(+), 32 deletions(-)

-- 
2.34.1


