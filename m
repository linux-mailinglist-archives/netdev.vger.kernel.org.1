Return-Path: <netdev+bounces-97947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CDF8CE39A
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 11:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DAFAB20E8F
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 09:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECE285275;
	Fri, 24 May 2024 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HOv3IoQI"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067A97E59A;
	Fri, 24 May 2024 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716543461; cv=none; b=Uosnxb4QNSMtD9CNrOoM8CpkmsFL0iY7qfRPXOlLmBYggL7Bx2qI/TeJV2GPU2spCkJT4LcWFwnxI7wnoQQt9mEwgP/xg9eoFieDunqHBfrjskPld0j2KgRZ/cBnU8jAiDILNNhjvRULXRzCKBTjHhNWy6bUqDB7/ff15YjxvAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716543461; c=relaxed/simple;
	bh=nskFY061nvdxurhLvpgKaDrjxBFg8YVAPRFrNqlkAek=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dvzBuPSIqohWUv5SAtAMYW8cH1AyiETpz9nUoZ+XcvUAcoVsiXOX9b5HZKwevqjcuYaqNydi98jfVu5SH2/35Xh12BXWUdErTbOn23g8cuL1iwuE9X1EDRxYRghIvz1oIYYolrNSZkOWe7rr3tpem51yH+g47YsgWg0cuY1ZeMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HOv3IoQI; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44O9bMY9083434;
	Fri, 24 May 2024 04:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716543442;
	bh=kwgshCgvayp6v4jsfvgDe4a2RylQ6yIoENWX/sS83rw=;
	h=From:To:CC:Subject:Date;
	b=HOv3IoQICoReU0UqUv2s0zMygYFNbzjQbWKacNI9X7xT8ggznpaScAv8BAdVONE4e
	 iT0VenwBH4mzAwINZfc/C9TidedDPU23yVkNgHdKCXMWqhI8HlaAGgUc1Igz8iOcU1
	 l+qNaG/R0HgrvfhUnvQcPb2sj+Xl/C1sGNCRED6s=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44O9bMMb025079
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 04:37:22 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 04:37:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 04:37:22 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44O9bLnI063520;
	Fri, 24 May 2024 04:37:21 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 44O9bLFG030149;
	Fri, 24 May 2024 04:37:21 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew@lunn.ch>, Diogo Ivo <diogo.ivo@siemens.com>,
        Jan
 Kiszka <jan.kiszka@siemens.com>, Paolo Abeni <pabeni@redhat.com>,
        Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar
	<danishanwar@ti.com>
Subject: [PATCH net] net: ti: icssg-prueth: Fix start counter for ft1 filter
Date: Fri, 24 May 2024 15:07:19 +0530
Message-ID: <20240524093719.68353-1-danishanwar@ti.com>
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

The start counter for FT1 filter is wrongly set to 0 in the driver.
FT1 is used for source address violation (SAV) check and source address
starts at Byte 6 not Byte 0. Fix this by changing start counter to 6 in
icssg_ft1_set_mac_addr().

Fixes: e9b4ece7d74b ("net: ti: icssg-prueth: Add Firmware config and classification APIs.")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_classifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_classifier.c b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
index 79ba47bb3602..8dee737639b6 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_classifier.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
@@ -455,7 +455,7 @@ void icssg_ft1_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac_addr)
 {
 	const u8 mask_addr[] = { 0, 0, 0, 0, 0, 0, };
 
-	rx_class_ft1_set_start_len(miig_rt, slice, 0, 6);
+	rx_class_ft1_set_start_len(miig_rt, slice, 6, 6);
 	rx_class_ft1_set_da(miig_rt, slice, 0, mac_addr);
 	rx_class_ft1_set_da_mask(miig_rt, slice, 0, mask_addr);
 	rx_class_ft1_cfg_set_type(miig_rt, slice, 0, FT1_CFG_TYPE_EQ);

base-commit: 66ad4829ddd0b5540dc0b076ef2818e89c8f720e
-- 
2.34.1


