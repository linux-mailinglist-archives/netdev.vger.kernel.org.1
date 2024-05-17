Return-Path: <netdev+bounces-96944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813DC8C8505
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 12:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45BC1C2293C
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 10:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53AA3A1DA;
	Fri, 17 May 2024 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GxiHN3AN"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DFA39AC3;
	Fri, 17 May 2024 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715942590; cv=none; b=SxsiOC3DctNC4xwT4bdXvCUBMWC6Xyq2HH9pBaiydIv5Rq4akzlVJ4tserDYYi2ZLWgQt2BvDpkrx7lAIcsuGTehH0QzimS5wb5UuT9+4fefMFGsEqjyo+8OnLq17bTyzMG3LDRLjxAdjczdkVIE/puk47ELzQMOwcA+/t4DMrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715942590; c=relaxed/simple;
	bh=SJuo25o9LoMUEm/F94EbRLfquKMxEdPWPXj7az7yy40=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tr/kjN7qbl6n1dyh9IwuWadeu9rj0UztrJi8jKq+PEWwlgfEt4qSp13PCfGrT4CvdaYCj6alAybuUs7SiTaym+CYPpeYxnQci3W42Bc15y932sMj1mZXUK7bCxbcejb/uEMVTIc+I5V6y5Yli6wtzlW/zlrBYeuyEv3/e6H5wkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GxiHN3AN; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44HAgo7B015708;
	Fri, 17 May 2024 05:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715942570;
	bh=hCY2MlVKCECjcvQ9bJMFL5Y1YG+Xc59NVUViWmYbtBE=;
	h=From:To:CC:Subject:Date;
	b=GxiHN3ANJg9fTsZdBRzH8VQ6z6Rg/jmQxo+ijplzgZ8aS6bKp/D2yzO7fkzPhxfNB
	 VlJHPVGcgDcXLApR+hzkPQfdLj2wF86uZoalRPbYnoRQ/+HBq3lrroKVVMaWgQ4Aas
	 xYLPMpj78x9AuCOrFMc/NS6ffrzjSA2FPpay4XsM=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44HAgoZ4008214
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 17 May 2024 05:42:50 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 17
 May 2024 05:42:49 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 17 May 2024 05:42:49 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44HAgjiT021387;
	Fri, 17 May 2024 05:42:46 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <vigneshr@ti.com>, <nm@ti.com>, <davem@davemloft.net>
CC: <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Kip Broadhurst
	<kbroadhurst@ti.com>
Subject: [PATCH] dt-bindings: net: dp8386x: Add MIT license along with GPL-2.0
Date: Fri, 17 May 2024 16:12:26 +0530
Message-ID: <20240517104226.3395480-1-u-kumar1@ti.com>
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

While at this, update the TI copyright year to sync with current year
to indicate license change.

Cc: Kip Broadhurst <kbroadhurst@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 include/dt-bindings/net/ti-dp83867.h | 4 ++--
 include/dt-bindings/net/ti-dp83869.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/dt-bindings/net/ti-dp83867.h b/include/dt-bindings/net/ti-dp83867.h
index 6fc4b445d3a1..2b7bc9c692f2 100644
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
+ * Copyright:   (C) 2015-2024 Texas Instruments, Inc.
  */
 
 #ifndef _DT_BINDINGS_TI_DP83867_H
diff --git a/include/dt-bindings/net/ti-dp83869.h b/include/dt-bindings/net/ti-dp83869.h
index 218b1a64e975..fbf5601070dc 100644
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
+ * Copyright:   (C) 2019-2024 Texas Instruments, Inc.
  */
 
 #ifndef _DT_BINDINGS_TI_DP83869_H
-- 
2.34.1


