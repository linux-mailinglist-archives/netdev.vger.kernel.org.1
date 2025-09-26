Return-Path: <netdev+bounces-226668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A6BBA3D7B
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38A5741E32
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 13:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74312F60CF;
	Fri, 26 Sep 2025 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b="HgBYV4I5"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-007fc201.pphosted.com (mx08-007fc201.pphosted.com [91.207.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682C72F60A1;
	Fri, 26 Sep 2025 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892554; cv=none; b=Z9jzFKWhb0cKxPdiMGFHsU1Eygoo9Yj6PoN1+STtlJkeCH0Bceh+GPJ4mZ3aOVIWtjhQUFWIeNjfvJOew59+xhem3TwjbBbNHwp3Uf68vuJb6SFhzq3qW2r9MbAOS/+OzO6X/dxccZBZChzebeDeV33iyTVMBYeaFrIMy0RElog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892554; c=relaxed/simple;
	bh=pHvE4KDYnokts7iUsjnv2s4phTCcZJgN6xikZBe/E0k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DhYJ3/4V5XElvX6/4fhhkLOYL7GeWqAAU6HUjJgVYVQgBiRIc4JL6r54NvT2GkgLVAmExplYLX3V1YKi0YcX2COMRivFgmFGoe8ruWm0ry83PEwAU1GIIsKBw1TkMlpXjJb9v8exVmKCZFmSi2LS4pItMT/rZIkyZTLBwEFlyhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de; spf=pass smtp.mailfrom=cab.de; dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b=HgBYV4I5; arc=none smtp.client-ip=91.207.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cab.de
Received: from pps.filterd (m0456229.ppops.net [127.0.0.1])
	by mx08-007fc201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58QDFIsI2121870;
	Fri, 26 Sep 2025 15:15:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cab.de; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp-2025; bh=++/HOBx2e8hoVzw3KFC+buI1
	aYSbbCH1TuLA4AUPMi4=; b=HgBYV4I5A4kYVaMAyUZzFI2ZG3mIOs5fYB5vV0o0
	b2BUWyOX8DB6RilWomsvXWlWjWFgm91QuU31WGYug814uumrowjR5bdJOdXkJgC/
	efWmj5F8SVJ3nRg7QwJYq73QbNh1u1ilv/pCkrpVKHvJLqf1H77ldhBDSodBD1uA
	LNoi32Am3OXmAbhvx749/X73ilvWd0LTr4fOIB4u083m544Qy+DAbo7ptIY/x62+
	CP65UxZhbMWPG65txjUUgT91aMlmkJ9FP3bdlA3/30wIoRZHnUjXfzdHKP9vmfHD
	DiqHaW1OM2UtEYNBPOeoqTdg8C6xSssXit7/Vq1fL6RMJA==
Received: from adranos.cab.de (adranos.cab.de [46.232.229.107])
	by mx08-007fc201.pphosted.com (PPS) with ESMTPS id 49dbt4g9m9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 15:15:39 +0200 (MEST)
Received: from KAN23-025.cab.de (10.10.3.180) by Adranos.cab.de (10.10.1.54)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Fri, 26 Sep
 2025 15:15:55 +0200
From: Markus Heidelberg <m.heidelberg@cab.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
CC: Russell King <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, Markus Heidelberg <m.heidelberg@cab.de>
Subject: [PATCH] docs: networking: phy: clarify abbreviation "PAL"
Date: Fri, 26 Sep 2025 15:15:20 +0200
Message-ID: <20250926131520.222346-1-m.heidelberg@cab.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Adranos.cab.de (10.10.1.54) To Adranos.cab.de (10.10.1.54)
X-Proofpoint-GUID: 68IbeNNJ5Ot_pcxvNQKzqiFradQo8V1A
X-Authority-Analysis: v=2.4 cv=XdWEDY55 c=1 sm=1 tr=0 ts=68d691fb cx=c_pps
 a=LmW7qmVeM6tFdl5svFU9Cg==:117 a=LmW7qmVeM6tFdl5svFU9Cg==:17
 a=kldc_9v1VKEA:10 a=yJojWOMRYYMA:10 a=UOiGSZXgOsTjZooIdzQA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 68IbeNNJ5Ot_pcxvNQKzqiFradQo8V1A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDEyMiBTYWx0ZWRfX/C4QMwMz9MY4
 XoFIT3nNkJw3QiirRkOUBAW30fVzAvrQyNuiq3uBMl9MtUNXh0rfPHVmFPaE234E9TY7fZPEWgL
 DsMLvcPAaW0wjLgGdAlCGOatPpyUrHZUJDCxgN1hPKY/Cvvr27GLzlte0VjdYrk1QRyRkzUI3+T
 76DBbwZfZGfdKa96VsBV1ZEQ8Za2F9SVbhonSMqrU88D3QGUKvWW7NO2OEJ771LTsWl4yoRJ02Q
 LIQlPa158Um//ZBbQDlxnTGgXFVwG6UD22pZrSp47SEe1bP1SHaXEd9dhieOBdBfar87JBvZSYc
 kHt+uh6T5JIy9Vd9uLiOtEdqkeD97Bl7xJpGW4HhrP0RxhdOZzqCwW7HtP4/MPozeV1+3SxJ/R7
 +3lhfsa+KbHnCwC6DE57bPEgp6c7eQ==

It is suddenly used in the text without introduction, so the meaning
might have been unclear to readers.

Signed-off-by: Markus Heidelberg <m.heidelberg@cab.de>
---
 Documentation/networking/phy.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/phy.rst b/Documentation/networking/phy.rst
index 7f159043ad5a..b0f2ef83735d 100644
--- a/Documentation/networking/phy.rst
+++ b/Documentation/networking/phy.rst
@@ -20,7 +20,7 @@ sometimes quite different) ethernet controllers connected to the same
 management bus, it is difficult to ensure safe use of the bus.
 
 Since the PHYs are devices, and the management busses through which they are
-accessed are, in fact, busses, the PHY Abstraction Layer treats them as such.
+accessed are, in fact, busses, the PHY Abstraction Layer (PAL) treats them as such.
 In doing so, it has these goals:
 
 #. Increase code-reuse

base-commit: 203e3beb73e53584ca90bc2a6d8240b9b12b9bcf
-- 
2.43.0


