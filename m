Return-Path: <netdev+bounces-171587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 703F4A4DBB2
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 12:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D1E3B3093
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A752E1FF5F9;
	Tue,  4 Mar 2025 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rMw6y7wr"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105101FECB8;
	Tue,  4 Mar 2025 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085906; cv=none; b=Tvb2xKP8DqB2F2GHTwN2x32wV7NvNZPDeEF94pUGaboGeLJcMBonuyEssqeKk3bo0Oqk59HMACpeXEF8/MGm2J1KkmmWL2pVKdAZU30b+Dw3yW3Fb0CPwQ6IxTJYavFTs79C/uTN0r6eQ03VzKXOD/9xD/XLQ7GAXQQ5C765iXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085906; c=relaxed/simple;
	bh=paKWdJ3ekMpBkfGupgOm2SFeo8YGolII6hImtEkYrEY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WLxDHcOQB0B6IsYxyNy+A411MLyvZIK1aqrfic7fBgXVI8naLdmmxnrWGDs5HgP5hlafYEFBp9XxnSEXFIWW4HhRdE7sulp8tXukJSC64rBUpQEl9vQQaizf0QQNE25ZvV0HhotpmzV+C8gr7mJE86hWTeeY5wgIWQPsOKtGljU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rMw6y7wr; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 524Aw1RV3625146
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 4 Mar 2025 04:58:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741085881;
	bh=lNe+MRgzHHHs1aTDaEH9R1smMuYuwJxzycPtlvXhGEM=;
	h=From:To:CC:Subject:Date;
	b=rMw6y7wrvZBPP+r1BP9bYM/PxKatgtKryTO/UXNNOu3FdLMvXL/OZWGaFtL6vmPqx
	 6kR3If52bykURMlc/+FQDaMCiiRC2jgFX2j2IGUMLWc2PS66PGP+OqkhasF9RWdZy0
	 d2GPlfBENaD9vOX+mqmOGj8qhstnjHIkoY8SGOyU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 524Aw1K5067940;
	Tue, 4 Mar 2025 04:58:01 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Mar 2025 04:58:01 -0600
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Mar 2025 04:58:01 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 524Aw1xq027462;
	Tue, 4 Mar 2025 04:58:01 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 524Aw0DC016815;
	Tue, 4 Mar 2025 04:58:01 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <javier.carrasco.cruz@gmail.com>, <diogo.ivo@siemens.com>,
        <m-malladi@ti.com>, <horms@kernel.org>, <richardcochran@gmail.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v4 0/2] Add perout configuration support in IEP driver
Date: Tue, 4 Mar 2025 16:27:51 +0530
Message-ID: <20250304105753.1552159-1-m-malladi@ti.com>
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

IEP driver supported both perout and pps signal generation
but perout feature is faulty with half-cooked support
due to some missing configuration. Hence perout feature is
removed as a bug fix. This patch series adds back this feature
which configures perout signal based on the arguments passed
by the perout request.

This patch series is continuation to the bug fix: 
https://lore.kernel.org/all/20250227092441.1848419-1-m-malladi@ti.com/
as suggested by Jakub Kicinski and Jacob Keller:
https://lore.kernel.org/all/20250220172410.025b96d6@kernel.org/

v3:https://lore.kernel.org/all/20250303135124.632845-1-m-malladi@ti.com/

Meghana Malladi (2):
  net: ti: icss-iep: Add pwidth configuration for perout signal
  net: ti: icss-iep: Add phase offset configuration for perout signal

 drivers/net/ethernet/ti/icssg/icss_iep.c | 63 ++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 4 deletions(-)


base-commit: f77f12010f67259bd0e1ad18877ed27c721b627a
-- 
2.43.0


