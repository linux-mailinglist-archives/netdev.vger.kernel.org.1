Return-Path: <netdev+bounces-99790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 025CC8D6784
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 18:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57C91F2660D
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 16:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C117617622E;
	Fri, 31 May 2024 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vimy6Tsk"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD81916E867;
	Fri, 31 May 2024 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174710; cv=none; b=fMeGX2vZ6jdoEjvVo7s4ID3hWS8esWhdC6UDql80J+uFFrKAVBxsr4mjR/+pyGuLboJvbXxHx+VP7uAiHUe9G1lWYTlzLvyWXxl6UuBGB4QGfUJEAa1yjtyjKHziMaOqHOkP6DaAvKrHApGBosVoPAgNKpAe0LX3pIFIiwy3AJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174710; c=relaxed/simple;
	bh=aGRrRjKhc2q1dy0PbGkr1B3BphvFlUHcgPTDtktT34s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SwV/c9e6R6KtAIZ+V3CykQuv++2G5Ph73gYDG+GA1uKKst3J1C0x7vFN2Euq8sQ5dqsBGu+CeF1bGPHsjpzcuM+Z4TL+1p2tK160NeeQPatgorvimMuRc+lsH4Qpzr5YjysdytB37dRy6lGzaDe/U/ytTJaXreECNAm64AbGvLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vimy6Tsk; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44VGvpkq059573;
	Fri, 31 May 2024 11:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717174671;
	bh=1q9tDaD0alJjEVrUhFUirlBLwy8o73Gn1mGNhE6sui8=;
	h=From:To:CC:Subject:Date;
	b=vimy6Tsk4Y5bo9v2s9c8x023VB9kV+38nCCP7sFcZBlUAofKFiaVD/wpaDBmDNuwj
	 +PlEcUQjB7ObLSGCw1MMLSwJFm434ZJawoHE/+bxe35wP/T6f89xOOxol705TSBVg7
	 WgImnnxZgdIkpq7zrkMHx6jhp5yquiDd8tVJHLkg=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44VGvp1g007698
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 May 2024 11:57:51 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 31
 May 2024 11:57:51 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 31 May 2024 11:57:51 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44VGvjiU023353;
	Fri, 31 May 2024 11:57:46 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <vigneshr@ti.com>, <nm@ti.com>, <tglx@linutronix.de>, <tpiepho@impinj.com>,
        <w.egorov@phytec.de>
CC: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Udit Kumar <u-kumar1@ti.com>,
        Kip
 Broadhurst <kbroadhurst@ti.com>
Subject: [PATCH v2] dt-bindings: net: dp8386x: Add MIT license along with GPL-2.0
Date: Fri, 31 May 2024 22:27:25 +0530
Message-ID: <20240531165725.1815176-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Modify license to include dual licensing as GPL-2.0-only OR MIT
license for TI specific phy header files. This allows for Linux
kernel files to be used in other Operating System ecosystems
such as Zephyr or FreeBSD.

While at this, update the GPL-2.0 to be GPL-2.0-only to be in sync
with latest SPDX conventions (GPL-2.0 is deprecated).

While at this, update the TI copyright year to sync with current year
to indicate license change.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Trent Piepho <tpiepho@impinj.com>
Cc: Wadim Egorov <w.egorov@phytec.de>
Cc: Kip Broadhurst <kbroadhurst@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Changelog:
Changes in v2:
- Updated Copyright information as per review comments of v1
- Added all authors[0] in CC list of patch
- Extended patch to LAKML list
v1 link: https://lore.kernel.org/all/20240517104226.3395480-1-u-kumar1@ti.com/

[0] Patch cc list is based upon (I am representing @ti.com for this patch)
git log --no-merges --pretty="%ae" $files|grep -v "@ti.com"

Requesting Acked-by, from the CC list of patch at the earliest


 include/dt-bindings/net/ti-dp83867.h | 4 ++--
 include/dt-bindings/net/ti-dp83869.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/dt-bindings/net/ti-dp83867.h b/include/dt-bindings/net/ti-dp83867.h
index 6fc4b445d3a1..b8a4f3ff4a3b 100644
--- a/include/dt-bindings/net/ti-dp83867.h
+++ b/include/dt-bindings/net/ti-dp83867.h
@@ -1,10 +1,10 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
 /*
  * Device Tree constants for the Texas Instruments DP83867 PHY
  *
  * Author: Dan Murphy <dmurphy@ti.com>
  *
- * Copyright:   (C) 2015 Texas Instruments, Inc.
+ * Copyright (C) 2015-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #ifndef _DT_BINDINGS_TI_DP83867_H
diff --git a/include/dt-bindings/net/ti-dp83869.h b/include/dt-bindings/net/ti-dp83869.h
index 218b1a64e975..917114aad7d0 100644
--- a/include/dt-bindings/net/ti-dp83869.h
+++ b/include/dt-bindings/net/ti-dp83869.h
@@ -1,10 +1,10 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
 /*
  * Device Tree constants for the Texas Instruments DP83869 PHY
  *
  * Author: Dan Murphy <dmurphy@ti.com>
  *
- * Copyright:   (C) 2019 Texas Instruments, Inc.
+ * Copyright (C) 2015-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #ifndef _DT_BINDINGS_TI_DP83869_H
-- 
2.34.1


