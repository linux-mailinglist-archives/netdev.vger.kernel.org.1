Return-Path: <netdev+bounces-98131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F868CF923
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 08:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F4208281E6F
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 06:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFB71078F;
	Mon, 27 May 2024 06:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Pd0SQjXl"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2CCDDA5;
	Mon, 27 May 2024 06:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791436; cv=none; b=GA4ZjmKxa7/APaOiavoyWLH9jVWqxr33DU+9D8T3WIgMwoiSizhIUlOkWLOKaWCKzRGnVHFSk84rkaP6EVj7mvcnTON2BhCOt8hIHVE+bpbGX0oD+1422a90FkUs91VEldle9jsh6Jd9iz0cW+fDQGqJBimTyUvvVVB+8IU0GRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791436; c=relaxed/simple;
	bh=Zn/2jBpern3fDjh2DJoZ1OoCFMovbTXWs2MkcYdzcTE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n8j49q0pNQixklb7053ItGBsGPbdTLd80IC8lA6QUWCaMRNVqyStS5puoT8G21AtXvNugRlkiMsK6kVhJhgS+iWfn7ftiKPcyJoY/SYcnut+5MJxeaDDmRYvBRPOmjX56h7sqZtEEMwoK6KpcMajvHf6NqXr/RtOnK3b4uSJGvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Pd0SQjXl; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44R6UI7w123976;
	Mon, 27 May 2024 01:30:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716791418;
	bh=03tHTJNR6JRpcSZNxBdBLsUOYYQnOce3h4UMjr16pHg=;
	h=From:To:CC:Subject:Date;
	b=Pd0SQjXlquFv+yYHhyoBRVi2BJarhQwUk8LydogqK1fKRut1TL3kj2GZi0tJgwNgt
	 YpXo3ExwyBApGhvp5Y8+B2RDGf5ABC9EcsRgF4W98P6bxhft0MQWkie6tjj3xdcLDg
	 fUNjIv1vrZsehfr+WEI3VuV9xzLXSqT+IRNzzDzw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44R6UItR021611
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 May 2024 01:30:18 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 May 2024 01:30:18 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 May 2024 01:30:18 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44R6UIg1128224;
	Mon, 27 May 2024 01:30:18 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 44R6UHO7031809;
	Mon, 27 May 2024 01:30:18 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Diogo Ivo <diogo.ivo@siemens.com>, Andrew Lunn <andrew@lunn.ch>,
        Paolo
 Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar
	<danishanwar@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net v2] net: ti: icssg-prueth: Fix start counter for ft1 filter
Date: Mon, 27 May 2024 12:00:15 +0530
Message-ID: <20240527063015.263748-1-danishanwar@ti.com>
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
starts at Byte 6 not Byte 0. Fix this by changing start counter to
ETH_ALEN in icssg_ft1_set_mac_addr().

Fixes: e9b4ece7d74b ("net: ti: icssg-prueth: Add Firmware config and classification APIs.")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
Cc: Florian Fainelli <f.fainelli@gmail.com>

Changes from v1 to v2:
*) Using ETH_ALEN instead of hardcoding the values to 6 as suggested by
   Florian Fainelli <f.fainelli@gmail.com>

v1: https://lore.kernel.org/all/20240524093719.68353-1-danishanwar@ti.com/

 drivers/net/ethernet/ti/icssg/icssg_classifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_classifier.c b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
index 79ba47bb3602..f7d21da1a0fb 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_classifier.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
@@ -455,7 +455,7 @@ void icssg_ft1_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac_addr)
 {
 	const u8 mask_addr[] = { 0, 0, 0, 0, 0, 0, };
 
-	rx_class_ft1_set_start_len(miig_rt, slice, 0, 6);
+	rx_class_ft1_set_start_len(miig_rt, slice, ETH_ALEN, ETH_ALEN);
 	rx_class_ft1_set_da(miig_rt, slice, 0, mac_addr);
 	rx_class_ft1_set_da_mask(miig_rt, slice, 0, mask_addr);
 	rx_class_ft1_cfg_set_type(miig_rt, slice, 0, FT1_CFG_TYPE_EQ);

base-commit: 0b4f5add9fa59bfd42c1030f572db2e4c395181b
-- 
2.34.1


