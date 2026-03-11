Return-Path: <netdev+bounces-266485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMf5J///sGn1pgIAu9opvQ
	(envelope-from <netdev+bounces-266485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:39:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3B125C7BA
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1476304B383
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA49D32572F;
	Wed, 11 Mar 2026 05:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wiymi2mj"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD7228CF4A;
	Wed, 11 Mar 2026 05:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773207548; cv=fail; b=sOD01L7JsKDZTtg5at7zHXnKYBTSXtRXey+I7FT97XJMD6K2ORNkK6ZiFPMQ3VT7AS/lKMKp0ifS4Rcn/sWKaKQXOfuGvCZtIsP+Yt0CEY9x7jQQU7AqBEUoa4OUNHeLVgNm/2tWDLNoabTts4DTPGHbGUfX6WAKLeGMLy62A3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773207548; c=relaxed/simple;
	bh=yZWfc4d0Pfi10DW+k6GeFjL7GH47qMb7rk6we9j0R3E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uA0AdDAuMyY7N/yR96XKzEDeP7nhS2KUFujeBHEmb/O46rVnbsSMlQSI5JFXCAqmlAFKDWWkXaW/327dBt1xe+bdsbsVx0cWpGQ4kfSmN3TDAZzVN4e8XRzN7lSlEsJU5dlZzBFUQKYt3TP/NSMAzSIZEMyF4rQM4zUUBjPrYFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wiymi2mj; arc=fail smtp.client-ip=52.101.85.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQirerLAx96nCfwFqHcG2kBD5TjXlZMv/vIpOY/8FB4iF2bg/5VEzG61CHvJtBY33lyiSgwJhOqcXdH/HOfJnjwwJFv6QYGD3ctFm8j8BFwpfd7nskWR+btxIGHBjhSac3foqJPyRiVK6/5AFV+XSDpWPK44V4oeUapyXkH9FsXoVoU3eNXPajKnpSBf1Hd3YzaPuuNnsI7OG3ysf01s0mFigi4Ik4lMSYuMRUw7VMKnTE6AC9Rq1GQ0W4Ixut9fkaNk+VbngsoV36DO3DrOtfaM5+sY+regOHeSwp5o+WL7/9aEQPqZgrwzNVh3N5WNJDIYO++QVVulSG7zVZjLoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RamBF01yXqMY5BetOf1iIqqKwFOFswVOHDrfq4/JpuE=;
 b=EK92ZhrZaloYF0K1t+19RbzB895ilecLX5dIPAaihVJI1ixQbXguWmorn6XdP58xnSY3OacJiSTGI81v/rKiZb5TyU8FGfrFfDnbsYnP9Pjb5XTzweDkS8ka03qZ/TIXS56M4cYHEM3oaq4r/Qw4zxEjZS3nmWsMjwJMIWQ/ajDlgEWP3PXoEW3vU7JJkRyXZy+myVFEIjG2cEQLnLZUYCc+0kU61QJqwEH1P7/K6fnGwV+fNBPNNcLAK0agtWA+hlkbKTG6jjy+Ij7eDbcxeUMqN8S0/AF9L2+r9RSG57RUzWtIFUxeXhsvY3yz+zEI76xZSb9EJN8thETX+MIFKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RamBF01yXqMY5BetOf1iIqqKwFOFswVOHDrfq4/JpuE=;
 b=wiymi2mjnLmO1s9VG091Dk0Mv0VQExfkn3SqKX+rdXSSyYEtOFpVqNLoOJOSJDqPaNPRatIt1Y0afIC1DxRAi4WL6tUu2gxRBFxRlGQ35MVsoqAW3t7Ya1O6nrzgkUlmaJM0tnt2QRy9pPyKD9nA666c9VN5MkWbvpf/8RVir1k=
Received: from SJ0PR03CA0088.namprd03.prod.outlook.com (2603:10b6:a03:331::33)
 by MN2PR10MB4366.namprd10.prod.outlook.com (2603:10b6:208:1dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Wed, 11 Mar
 2026 05:39:04 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::57) by SJ0PR03CA0088.outlook.office365.com
 (2603:10b6:a03:331::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 05:38:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 05:39:03 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 00:39:03 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 00:39:02 -0500
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 00:39:02 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62B5d2mj4179354;
	Wed, 11 Mar 2026 00:39:02 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 62B5d1Yd028451;
	Wed, 11 Mar 2026 00:39:02 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
	<danishanwar@ti.com>, <m-malladi@ti.com>
Subject: [PATCH v3 0/2] Add ICSSG0 dual EMAC support for AM642 EVM
Date: Wed, 11 Mar 2026 11:08:50 +0530
Message-ID: <20260311053852.1034244-1-m-malladi@ti.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|MN2PR10MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: 2684f002-ff60-4306-d63c-08de7f308155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ev1A1L7J3tTPhIpwNklmzur0wyns+OBz3/Flz8Xv1a1JkvcBs97IjDelQlu7U+lbQHHhwFJtICy/ao1QKlXphr+x8WZxD/LDJLtkTo/+Atxp6y9/5EmUwt1PM0cp3AmJ7e+90lnM+kvFrNZdumjp3ob6ggwnD3HtmQxT5GKFXevKsnSuvmDkK2UpnLxByv3ktWRx6QBKoikD+t1R2JmcGd+ftc5aS1QIfUzjA49ALFiCkMhS3rvAWzuBCbst7Wac/LziLOhTm873lvit/TF+5AvLpEFUmLaS5vxgvFSoaO29fGeR22pkLLaiRiCfQKJyWsXZOVkmU4h2ZiumLxSlluF0KUPoEyO/51D8xEFt4p12EJ+IHhD3nQck0nUuQa375dRCdElr4lvZFw6KcmiUQAxXUaSatgYWk4/fchbA0X26WnKnP+fQNjlfc+58eFUY7PM+6guR+368B1VFmlmoe0Bd6TRo2jH2KlCU0zVieVpYfXXQ76Wm3cYooh8gMVd3Zl/N9tqtBnmyQnlf3YHYIjB7r9qqVMH1LEb+vgwJhzba5ICrsYteq7zK+Zf8IHfSs91QMYDvvZ7FQzztAML4B5ZLugPW9vwiMx/UQiE2KHVxdM7DA7sf+DhMqov1ZvqdSWiJVeg3MShPFv4y0qghMjB2Shz8hQ2tc0hvGzaS1J86+HnbpR4nk4rlNXgUbpV2r/lC7QMgklpGwLZS+bTx2rrcWEmJ4ky8/zXHmsYO0uI=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OrNvzw9H5s6+aT1kTPrCPJyCJiy/6hRq6+Mq2QvrJhwR3khXPxy9qQqsL2qxDuLVG1Tdqf9fl5OYUdWvlj2hTi7Rj5DjJam7Y5NWITmoGE9AgpNsoJYpm92ayUk4Kv45dD6e7tryiOfBdV40mZrN1Tf3/Zb2h0bc4DRFDmDpW1EgD3TQRFUfZOZam38xIELcjviOiKFW9nEO5HTXIeVVWxAlAgaSeI02a4BPH2eDsPXWg7qki854vIfOCBRZAc4CGUqBqOnUTNLP8hbsZACMGSPqbu/UGJXa/TAFmodGQ+1WooLePwQimXNLVNGEoseMwvX1eYKs9Cs7+7c8MakB0W0JP/XAsVT/UYRoXT1wv86cLnkGjS8oWIRK2jrsJ5nSoihXuVbOSfU0lZ/sVdEeQg3IG9pmGWNwi8p+0fZ+PKEdfrcm1NVVo+wB28NBX88h
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 05:39:03.7012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2684f002-ff60-4306-d63c-08de7f308155
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4366
X-Rspamd-Queue-Id: 1E3B125C7BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266485-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ti.com:dkim,ti.com:mid];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

This series adds device tree overlay support for enabling ICSSG0 dual EMAC
on the AM642 EVM, along with the necessary PHY driver configuration.

The overlay enables both ICSSG0 Ethernet interfaces (port0 and port1) in
dual EMAC mode and can be combined with the existing ICSSG1 overlay to
enable all four ICSSG interfaces if needed.

The series also enables the DP83TG720 PHY driver required for the
DP83TG720-IND-SPE-EVM daughter card used with the ICSSG0 interface.

v2: https://lore.kernel.org/all/20260228113203.498839-1-m-malladi@ti.com/
logs: https://gist.github.com/MeghanaMalladiTI/20e9e661c3e1075694097bc02f5a3916

Meghana Malladi (2):
  arm64: dts: ti: k3-am642-evm: Add ICSSG0 overlay for dual EMAC support
  arm64: defconfig: Enable DP83TG720 PHY driver

 arch/arm64/boot/dts/ti/Makefile               |   4 +
 .../boot/dts/ti/k3-am642-evm-icssg0.dtso      | 168 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 3 files changed, 173 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-icssg0.dtso


base-commit: 0bcac7b11262557c990da1ac564d45777eb6b005
-- 
2.43.0


