Return-Path: <netdev+bounces-125894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3030496F28F
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 13:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D113B1F24B89
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 11:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C1B1C9EC1;
	Fri,  6 Sep 2024 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SE9ftqer"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EFC1C9EAB;
	Fri,  6 Sep 2024 11:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621367; cv=none; b=Xv8wMVJlj8Yq9ZWy1FyGop1Tj4Au+bdi+3YXLh2BwsusM8AQrXycJ7IsFo9Bu3PQvL/ott6D/Z7TNTl9okpcL4JOAYmSBZEyllLkH9/HMHV50xawKd1qRHIeY8D/g4dAGZmL/Gi/l/1o3JUn/4uiUW/jyFHaRzsXG7g/r9XES8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621367; c=relaxed/simple;
	bh=99x9LOhzAKmIKJolGf7DXFQ8lOBlWU5ll8+oMQt1pZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTSUT/bWlmxAbKYJOffeNBVOLuMgKUVx/fbYXccwXHa7CYgyEKQ06v7tg/Yl/lXTlymqRALWjZmL3yiCEUPV+n/jBVvt0rrMVRu5j3kEz/PLlMv1OB15KKLfAMLecCQcdHEt5/6FPww+oa/A5c9EalzHIok9s789rguh+G2i1Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SE9ftqer; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 486BFjib069129;
	Fri, 6 Sep 2024 06:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725621345;
	bh=YyhnYXJbgwXefLRiYF5LF1r9dRyItK4quGc+m3iHDZ4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SE9ftqer3RRFBn1xxmdEDl6Zzm419p2j0dG+2wZjg10rS1avXrDmsRMPxOmKoM9VW
	 KJrVsLpyCVim/HKlzkkTqPNdOmW7l6C1E3VsK1c3IkYHis5mtpiqh3RC8QoCF12oSM
	 fAup9GENlolk8bjdXA3/7mZ5NzA4R0LuhUDS3ohU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 486BFjan025638;
	Fri, 6 Sep 2024 06:15:45 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Sep 2024 06:15:45 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Sep 2024 06:15:45 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 486BFjrE045321;
	Fri, 6 Sep 2024 06:15:45 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 486BFiUo000318;
	Fri, 6 Sep 2024 06:15:45 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: <robh@kernel.org>, <jan.kiszka@siemens.com>, <dan.carpenter@linaro.org>,
        <saikrishnag@marvell.com>, <andrew@lunn.ch>,
        <javier.carrasco.cruz@gmail.com>, <jacob.e.keller@intel.com>,
        <diogo.ivo@siemens.com>, <horms@kernel.org>,
        <richardcochran@gmail.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v5 2/5] net: ti: icssg-prueth: Stop hardcoding def_inc
Date: Fri, 6 Sep 2024 16:45:35 +0530
Message-ID: <20240906111538.1259418-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906111538.1259418-1-danishanwar@ti.com>
References: <20240906111538.1259418-1-danishanwar@ti.com>
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

Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index becdda143c19..1dcd68eefdc3 100644
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


