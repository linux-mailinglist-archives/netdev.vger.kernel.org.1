Return-Path: <netdev+bounces-122690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40E2962335
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 11:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49CDF2841AB
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 09:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F85165EF2;
	Wed, 28 Aug 2024 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aJB2znXt"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544EC15E5C0;
	Wed, 28 Aug 2024 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724836771; cv=none; b=pw7Il3D1wsdDUokupzVM2EcOKIYu+AD5xdS8yYN/2ZgFuvV5PgvqOtJBF2C/DpjPkb20xharS4QcddB9xYnae+SInXhPIEw96EmAnD66+hhm9JB3OpKgMgF+Hd0ehcNt/S7tt5Y7lIZ+qR87aZoStY611AKd/qkAZ0quszBvUA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724836771; c=relaxed/simple;
	bh=YS8s7hqMHXPLmRWSaqobJ29nAjkCTC7bzdPzFKXXhZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o6jR8O5ohDnCMW+nx07GWGiE52aiQuhkrKCc1URhmphoVWHP0tkOsVqi87SlZnH7dzL/5s9Ov7myJECql6iWyQTrO/mw+S6dOP8LSInpeFj8L4VBzgSA6seIL2yt2/xd8tWdvlnwFgcvCiYitj2V9R48YKBu1Uz/v9KwQGORPqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aJB2znXt; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47S9J82I084252;
	Wed, 28 Aug 2024 04:19:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724836748;
	bh=fGSqJxeNPlVFQrJ8sOjHd/jgvCCwNcm2NbUIMzfiAMg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=aJB2znXtgi1c1E9F1cL8Jl0SGE90BDTqsF2UY6ISYrLK+Jst+K0KSf1UlijqzmDwF
	 0hi2SiUAYjcOXgzjpo4zZiPmh22mA4lmuf0p4CPhQcvmyODZT8HNtQcI2e/KyH8dfc
	 ULlPCl6fR0VCLvhvxR8LQTtFJ6vSmfc06haqW3x4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47S9J8EC068043
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 04:19:08 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 04:19:08 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 04:19:07 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47S9J7IF126833;
	Wed, 28 Aug 2024 04:19:07 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 47S9J7VC007467;
	Wed, 28 Aug 2024 04:19:07 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew@lunn.ch>, Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Javier Carrasco
	<javier.carrasco.cruz@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman <horms@kernel.org>,
        Richard
 Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v3 2/6] net: ti: icssg-prueth: Stop hardcoding def_inc
Date: Wed, 28 Aug 2024 14:48:57 +0530
Message-ID: <20240828091901.3120935-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828091901.3120935-1-danishanwar@ti.com>
References: <20240828091901.3120935-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The def_inc is stored in icss_iep structure. Currently default increment
(ns per clock tick) is hardcoded to 4 (Clock frequency being 250 MHz).
Change this to use the iep->def_inc variable as the iep structure is now
accessible to the driver files.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index f623a0f603fc..641e54849762 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -365,7 +365,8 @@ static void prueth_iep_settime(void *clockops_data, u64 ns)
 	sc_desc.cyclecounter0_set = cyclecount & GENMASK(31, 0);
 	sc_desc.cyclecounter1_set = (cyclecount & GENMASK(63, 32)) >> 32;
 	sc_desc.iepcount_set = ns % cycletime;
-	sc_desc.CMP0_current = cycletime - 4; //Count from 0 to (cycle time)-4
+	/* Count from 0 to (cycle time) - emac->iep->def_inc */
+	sc_desc.CMP0_current = cycletime - emac->iep->def_inc;
 
 	memcpy_toio(sc_descp, &sc_desc, sizeof(sc_desc));
 
-- 
2.34.1


