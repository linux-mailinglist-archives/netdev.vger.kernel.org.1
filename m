Return-Path: <netdev+bounces-165120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA63A3089B
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 11:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B54D3A2772
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 10:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7967E1F4E27;
	Tue, 11 Feb 2025 10:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y0kvPOqP"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996BA1F4607;
	Tue, 11 Feb 2025 10:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739270160; cv=none; b=RkrS9dCZFFGmY8dAG9IbqM31XVkMFjM++TKbMqCAMWpOlc4CN7Y3pYl7o99votEJFpX7/jRfEZMtFVYxFv9E4DYOexqwJPweAzBjkOVPVkZWbFx3IEN1cQ+KZO+W1FUS0rOABTvCjL0wTHknPwdmWMxH+Y/1RinmuWRlG0uk+4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739270160; c=relaxed/simple;
	bh=brMHdwKz56yPtHdc25PyAxCjbUQjnQOy4vUwRoQaGss=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZN8zvaHcn6HdfGDCpe3A7hB9vY0QYHJXxDQO9fILUukkV1z9F4mpTax+93pAHiU0DOVfnRFTY73grWhrUKF/KpJRs6s+hkWcfsuLUJuUmNPttmcQAuTjlwBRZg1nDaDRVGfLooIAz4egGLKWCdOu7U/yYrb4ZC1ZhcCClO3MTHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Y0kvPOqP; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51BAZYJq3587965
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Feb 2025 04:35:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739270134;
	bh=3LvUAOKH0qzhj1HGQSw+DZIp75MrFyzlwS0y8eYZNrg=;
	h=From:To:CC:Subject:Date;
	b=Y0kvPOqPFYEXdT9B2Xrl2r4HiNpdJqRC02ek2eaShc+3urlAa9dNGGV0gbqfbB2IO
	 z4DmsxlcvrQZ63yNwEqwafHJ+8BT+QGbhXmDlKd+ZcAKH702EeSIDTe34YlwNbnMXU
	 IyHYKXFjs3Ip+4iOud4tkXjSpRTMJE5evE4FnCEQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51BAZYC7073762
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Feb 2025 04:35:34 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Feb 2025 04:35:33 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Feb 2025 04:35:33 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51BAZX8g023808;
	Tue, 11 Feb 2025 04:35:33 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 51BAZWAo014179;
	Tue, 11 Feb 2025 04:35:32 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <javier.carrasco.cruz@gmail.com>, <diogo.ivo@siemens.com>,
        <m-malladi@ti.com>, <horms@kernel.org>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net 0/2] Fixes for perout configuration in IEP driver
Date: Tue, 11 Feb 2025 16:05:25 +0530
Message-ID: <20250211103527.923849-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

IEP driver supports both pps and perout signal generation using testptp
application. Currently the driver is missing to incorporate the perout
signal configuration. This series introduces fixes in the driver to
configure perout signal based on the arguments passed by the perout
request.

Meghana Malladi (2):
  net: ti: icss-iep: Fix pwidth configuration for perout signal
  net: ti: icss-iep: Fix phase offset configuration for perout signal

 drivers/net/ethernet/ti/icssg/icss_iep.c | 44 ++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 3 deletions(-)


base-commit: 8e248f2dbb1885647e259837d38200942f3591a3
-- 
2.43.0


