Return-Path: <netdev+bounces-124979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A4F96B7CB
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886EE1C24867
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3551CFEBE;
	Wed,  4 Sep 2024 10:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="d266KDy2"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2520E1CF5D6;
	Wed,  4 Sep 2024 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725444344; cv=none; b=YPTldx/llDqfuckbzPxbIf15oPMNmdxLZb2C1yXVBXYAsqjnWWzwE4U77yC2dYF29G51Jz9HRLLi23vleK9+t0jtYchWw0EB+xaDh9JlWdBjH/T4f72nzyuYv0hK5jFCl3xRLqGeN/XHJj9/qWv488nJn8PyxaZUx/vQ6sQPP0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725444344; c=relaxed/simple;
	bh=XvUEwmdwJobbs9Cbf2SzKMtjkHGyAoFWVZYQApeMiDs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+tSBsJHKJnT8EESPz0DIp9OEFc7Ac0E9pLNFbCRIQQMQ6RPVbJroD40Q5ZMp/Cmykkelc1blncl3fVsn7Bo2FkOSn3UvdaHdZcy0osyskTJ1UD30muBoVfssnKSSFCr8kMFT3v+4CJ4AAOabyBY3LrVuFc52U0WyfKXwmXHAvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=d266KDy2; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 484A5CWl092564;
	Wed, 4 Sep 2024 05:05:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725444312;
	bh=+4AiGnZTWSgMvgu2JQgbvNhsgTy/VZWp6AtaeAQqDTM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=d266KDy2mRrixwrgI7sazySlAAsYTVjG3UhGzsoUxw3Yn5Xph2sn7QBAQAJqLqfXA
	 ktnllf+/wVFGBJmmbvND8KNYCEFHO6F9XujGMQYX5VCxnL0rDRCVrAK+Ggfb7MALxj
	 Orlu2lMKMhWLB1EY7O+AX3aZhGfgjb/2iYaFdn84=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 484A5Cot012745;
	Wed, 4 Sep 2024 05:05:12 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Sep 2024 05:05:12 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Sep 2024 05:05:12 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 484A5Bx0111686;
	Wed, 4 Sep 2024 05:05:11 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 484A5B0H015373;
	Wed, 4 Sep 2024 05:05:11 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Andrew Lunn <andrew@lunn.ch>,
        Dan
 Carpenter <dan.carpenter@linaro.org>,
        Sai Krishna <saikrishnag@marvell.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Javier Carrasco
	<javier.carrasco.cruz@gmail.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Simon
 Horman <horms@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo
 Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v4 2/5] net: ti: icssg-prueth: Stop hardcoding def_inc
Date: Wed, 4 Sep 2024 15:35:03 +0530
Message-ID: <20240904100506.3665892-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904100506.3665892-1-danishanwar@ti.com>
References: <20240904100506.3665892-1-danishanwar@ti.com>
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


