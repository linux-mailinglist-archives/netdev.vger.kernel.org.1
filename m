Return-Path: <netdev+bounces-292847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIdYLx6vGGrLmAgAu9opvQ
	(envelope-from <netdev+bounces-292847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:09:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 225D35FA46D
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D95730166C5
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0668D352019;
	Thu, 28 May 2026 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="uuCXoUBe"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013061.outbound.protection.outlook.com [52.101.83.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6B82FFFA4;
	Thu, 28 May 2026 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780002215; cv=fail; b=S0TMpRP3aY5eeqxVOd/a/n6w9dW330UknxjLkKDorQgO8KcD7Y9AKh9n3A3W24S1LxzzJuC23ahjZGu2qJ2v+Tw7gixc3HGEyruSXngISTKkpKlj+1XL7Go4Cmbzy1Z8AGXontyRSKbRaSNcoW6IxLz7quyZlJNPkJmYt6w9698=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780002215; c=relaxed/simple;
	bh=bMlf4awGRFu3kYGzJHNt7Iv8Qx5gIDh48yjGGRL/mAE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hhOsn5FQiGgS24SNXDSApqa98cQVxaUhYycoVMO+7g77V/W6TprHNoZ0omExVFPxoNYWQ4t8IRB9nXuxAkEUSVxDsJ5djad6TdcuhzRArMR9iePFxjiD6BjkBDRYSlvPnU6u82t7XubkZoHFfYtfSCyhjPKUEcoaFrg9RSf8vmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=uuCXoUBe; arc=fail smtp.client-ip=52.101.83.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHBzyurnkpyHyz7o3pRHgjcoEmOtysMZe9k3M1w1dJO+TGNI2iZVcLQfFG9t+ROxOPrZtKRHzYGGRHDcINHaNMAf3quKxSbxUUdatyXFVID5aKrkjze6rJu0NNTYRed5ydMTQpozFzrDIkfuJyxC1PkJEOUZJiSKU0qP3Ll04l32esDCVBcaq+DF4CKYZ7iuDcYBlbPDhTe+wkfUQUCL+ltsE8WhOHZMA2xZJZBeQdcszuz1q5r7WATNSG3S0G3cFnfponHu4BKp+Vm12wBvLJIjGgr2tr16ib/idCGnYGtP4yqysEzya/8Y4Bg78oO3wXjYxlGH1wShrYm4/PIKTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lC9/jwtEaFfQCSHIuBWMrP3H+vRNuisUiq1VbpFlPAs=;
 b=KJacNnw7MCpIQhKNEA7aeAw5Ou7fvvqr9jTOPSTvEc/i1j7bSg4RtHptuk9b8FboA3TR4pH2iOJIkTFb9IjddBoBDTWHWISjOPnlAYc6vygNTyNXrFEAoENBbyOPoE1BAUgvn/S4ajIZ+ytnsjC51JKYjdJKx5KWA4d9rTdKCTlZI9RWwqoUiKFZLr5H3rjY5TSa8aMhx+vfrJMtFaGqSBMDZEo3PBe4okUhi6RPfKugfLk4/a6uhKFQm8SG8kBl9sXqjv9ax1emOkK2n8mEcrUUg8BX4rIoXUrpfpXXGD2wrlKwQLfM0sT53TkQ8QlvrfEc35t3KISyimDSH9I3nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lC9/jwtEaFfQCSHIuBWMrP3H+vRNuisUiq1VbpFlPAs=;
 b=uuCXoUBenMffeXQiDOo+If7ULWh48kk1oeDWQMoWIahYs7SpFsKNQM5RKuQCL/k3Ij61pmZ00vPlrTkxPTpiXvK4e8BDmat+HW+OeCxYPfy9XntibZOlVYvljbKPANWRjbAuooZCu6PHhc1j74I3fHdPoKK80PJHNbGTSQAHfi0iL63kuNUUi12VYxigjTW6vOECoN0JAd4POz6tTNI0j8Y+vRgmDP8on/NnTAxjVYPdlXe3FJjoopM3s9p6rKP3zv1QH2rXQw8zNmwjM8iqeUg258UxGBwzLAiOW/GGzUcDtZs18x2GmMKpaBAgCThv/aFOh8zTMmAnr/VJPFq9Kw==
Received: from DB9PR06CA0028.eurprd06.prod.outlook.com (2603:10a6:10:1db::33)
 by DB9PR07MB8428.eurprd07.prod.outlook.com (2603:10a6:10:36f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 21:03:30 +0000
Received: from DB1PEPF000509F3.eurprd02.prod.outlook.com
 (2603:10a6:10:1db:cafe::59) by DB9PR06CA0028.outlook.office365.com
 (2603:10a6:10:1db::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 21:03:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB1PEPF000509F3.mail.protection.outlook.com (10.167.242.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 28 May 2026 21:03:29 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 28 May 2026 23:03:28 +0200
Received: from seroius06448.sero.gic.ericsson.se (seroius06448.sero.gic.ericsson.se [10.117.92.228])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id 637254020B69;
	Thu, 28 May 2026 23:03:28 +0200 (CEST)
Received: by seroius06448.sero.gic.ericsson.se (Postfix, from userid 7434092)
	id 4D1801005D6A; Thu, 28 May 2026 23:03:28 +0200 (CEST)
From: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<marek.behun@nic.cz>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<fidan.aliyeva.ext@ericsson.com>
Subject: [PATCH net-next v3 0/3] mv88e6xxx: SERDES on mv88e6321
Date: Thu, 28 May 2026 23:03:07 +0200
Message-ID: <20260528210310.1365858-1-fidan.aliyeva.ext@ericsson.com>
X-Mailer: git-send-email 2.36.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F3:EE_|DB9PR07MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: ab64713b-6860-4e7e-5fd4-08debcfc91b0
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|13003099007|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Rn0vaRZ4YB9hs8PYIU5E27RGwXl18hxZZHXTu9RAlfFLrewe7Df7L4UBEe2L2O4uGrIIawE9c0o2wlbBFD5LuA1xNyQTujHFEnPXjeAFKxDYCMpD8p0Hs73SS9IpvrFS+2caB+KvyK1Uj4K9mDZM92E47USoHsmQ09USPQ1+eSI9AufM+1VMY7ULDn79x+zui5AUXWDj+CXuNPLB0jl38RHQ4EjwkrvtM82hqcPHoIkKMIpUxtylZe6jfEVXmFr/LGbf1XtwuMW9XoEdjamSz/3Qvcs9dRcyYElnD+1qeIfoMMPSUUQOf/vg40OQ+aPKANNwJBzsMm31Gas3ENVPdtYkregSBganorvpSFcAHGgPcog2zRRtUJ+LWeifHY5FCeDz5zx7PiX0b8YdmaTXTCzYFHnN+6G5pGfUzEi+FJIA4jiZnLgD5Hudx6A+jdxYl3jYPaMV+vjAO8lA1VsYxtKH8TNACAgzxU85661xF16Fhvd0EMZjgQB3svKhHcI1jKW3v8Lt9/hf6urXC/2zgm0nadAWFnfDmdcr9MJc16ik2s63mCWki/4+rV51wg+K/RadNQEWE7q0r3lNvvVMUQmtRSdWOSqHJhyusg+l8KHF6ntmF50vhVTzF55FqSyDfxEEQH12RI/nDcvRG4U9jRuW9fO3XyjKwdL4eamAgtLH8K6KZQMPoXn2GxudLZnR
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(13003099007)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FFP1cyLXJ650FCT6TOZyxYKQ9JTPnpQY5CsP+HdiUlVEwgWVJrOqGPq7Z07IzaaXTVETK9L+P1i5OoR5Q/hQ7lcS78eHawn6DOBkHxp3wJKz9VCfkyNwQFM+bAWAudU1sSokR4dowA/I412lNMfbpAteWYnLyTMANOX0e1xjx3cX4mO7/8m2NJIjYXTDeDo2fypKuSut3k1zbE5TOV7pI3ik8d+8GlI6KDDlkJorTVhG2JqRnKPQOc46skYF8LH3s11hyUFOiBDP7xdcGKWhtNHY9TCdSn17vIxolLNkVdENSJXKhG1aukQU4f4Gi6q7gBZN23RPhctRF2Svr5SO2QCNMZ5sLychtOCC6TZsNEYbHoQQdndh0lrcqGkqb8uZ/rQZ+JCyFFd2pXsRS0d9POcIiE9kKJAGDtRCF5m9+f/++cMedLBIpwVce311Xa/1
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 21:03:29.4472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab64713b-6860-4e7e-5fd4-08debcfc91b0
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8428
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ericsson.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ericsson.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292847-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nic.cz];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ericsson.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fidan.aliyeva.ext@ericsson.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 225D35FA46D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series add code support to be able to use SERDES feature of
mv88e6321 version of Marvel mv88e6xxx series. mv88e6321 has 2 ports to
support high speed SERDES but the support is lacking in the driver.

mv88e6321 version has a similar architecture to mv88e6352 version making it
possible to reuse its pcs functions. That's why the patch series consist of
2 parts:

1. Refactor the serdes functions and pcs_init of mv88e6352 to be more
generic (patches 1-2).
2. Add the SERDES support for mv88e6321 reusing 6352's pcs functions

The final code has been tested on mv88e6321 ethernet device directly by ip
ping tests, performance tests and also verifying the switch's expected
register values.

Referred document: 88E6321/88E6320 Functional Specification

---
Changes in v3:
  - After 'Cache scratch config3 of 6352' series, make all the serdes
  related functions of 6352 in serdes.c generic and make 6321 reuse them.

v2 link:
https://lore.kernel.org/netdev/20260507200109.3726627-1-fidan.aliyeva.ext@ericsson.com/

Above mentioned series:
https://lore.kernel.org/netdev/20260521202924.727929-1-fidan.aliyeva.ext@ericsson.com/

Changes in v2:
  - Removed 6321-specific pcs_init and made 6352's pcs_init more generic
  as suggested by Andrew Lunn
  - Added the correct mailing list

---
Fidan Aliyeva (3):
  mv88e6xxx: Add mv88e6352_serdes_get_lane
  mv88e6xxx: Refactor 6352's serdes functions
  mv88e6xxx: Add SERDES Support for mv88e6321

 drivers/net/dsa/mv88e6xxx/chip.c     |  8 +++
 drivers/net/dsa/mv88e6xxx/pcs-6352.c | 10 ++--
 drivers/net/dsa/mv88e6xxx/serdes.c   | 82 +++++++++++++++++++---------
 drivers/net/dsa/mv88e6xxx/serdes.h   |  4 ++
 4 files changed, 74 insertions(+), 30 deletions(-)

--
2.36.0


