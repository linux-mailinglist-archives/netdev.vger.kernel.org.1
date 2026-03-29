Return-Path: <netdev+bounces-272923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oL8SBso7yWkMwQUAu9opvQ
	(envelope-from <netdev+bounces-272923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 16:48:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6FF3527B1
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 16:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CDDF300FC7B
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 14:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA156379ECC;
	Sun, 29 Mar 2026 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GfRtqn8g"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3682E7F3E;
	Sun, 29 Mar 2026 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774795715; cv=fail; b=XGL3gV/FMSPNfdDsicY1oXsVLcFiApk8qlbLZhHFm5fCaLPp18tsxqAgxH2mGXsecX3jVAu2RxTRzA3MnKFtNvKx0QX4IVODmU904frsnaOQkzZKS3w/o5JI+/f9SzeRGJCMOUfqrHvkAJ0zyCUCo2UyzjjvdNeC7WsPX6Bxogc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774795715; c=relaxed/simple;
	bh=jVrQx6r9JOSNFSFP85MTvdey7ksEtKRl/PGEh4AYQpo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0+6IE2vbC0cBBrROTzrI++6q1cR8c6O86REKuT4nOMSwtk5+LA9t8Wnl0zJmZ1PfaVDqJH7Uq8467HtB7Aw4mtmQZ8M6Q9MpLO5p6+sDGuwMY81tPROmlIUlZlgVwZp8+D9XT0mCpAeptTR0jQC2V6PSdJtys92a9Pjf8/Z1Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GfRtqn8g; arc=fail smtp.client-ip=40.107.209.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXCeus9+2inOQVcpRiKrBeKONMJn4IMinx2awRX8IN8AYS/OiGM1CXPvgJ1Yv9inSy8TFhewIC+Z84yRKd+5YTSc72vDG31KuVjK1KQdyCwzNARLziTrmVJDAz44Ng7zZskFYtAiWYqKH39pECiLyQHKaE40vdsp+iD+klH+QJtcCgZbZv/W58SIGzp+HoCTLP34WOhW+w0aRTJYmouurHbdajlQC0WyvmFQVi2Tutmj9T/v7YzcaIE8v89v2vDRVmUIQQelsexyPKExmf09vOAxVN8M89a2wAxVNNHkuiLJp5WXBjqNpVX6iKyNnD26yRG14Xt3DTVGkG/+hZsV2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpMIWxlgywMEqLQv5zSVQimAvUIfI6o/TiivW9uj3tw=;
 b=Aq62DyD1JGALhcF/SUP0DelaVPHCS35tHRhu2yQLAaMUsZWXPMVDiPfsA+TEl/vPvkBFJ9qhrZeDn6PuFHKRfP7/uS5LwDU4C6VBOFPhWY8+BjzrofrbdbSBwmCtfViKb3a6W8IkbLgoeYGZDQaPFFkBYXpW8PwoLxsxAxwdJkDbQ1doYbaWru95tWkgLCRrFCNr5hveQVcSCAWaWEqIaZ9NIeRLvPgenpMRVoCbiMmeUfgbBiZKrt0V0Sk7BZ5qtFuXIKWJ1HKVMyiYNNXq+5CZm2xjfFb2vGiZ9Jfb3PBA9wY6ZKkw3OFwYiYccAJU6kgrWF8dRJiunMsNUbf2Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpMIWxlgywMEqLQv5zSVQimAvUIfI6o/TiivW9uj3tw=;
 b=GfRtqn8g2q6H+OLVzPbzspOXPeKDdMoCKmfeht8RRokAtpjZ0XuktwMXoHra2kPZc1YI0F4EWkgorJOlOMJPw8bSfyt7eWQEgJfdUqRxLOM3kpPdql9nnhpX74LNjQ5EkG6uZPWL/rPlrbHtTNIR/Yg/tqyBr0qhg5LvHCtz0E0=
Received: from BL1PR13CA0373.namprd13.prod.outlook.com (2603:10b6:208:2c0::18)
 by BN0PR10MB5045.namprd10.prod.outlook.com (2603:10b6:408:116::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Sun, 29 Mar
 2026 14:48:32 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:2c0:cafe::8c) by BL1PR13CA0373.outlook.office365.com
 (2603:10b6:208:2c0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.27 via Frontend Transport; Sun,
 29 Mar 2026 14:48:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Sun, 29 Mar 2026 14:48:32 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 29 Mar
 2026 09:48:31 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 29 Mar
 2026 09:48:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 29 Mar 2026 09:48:31 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62TEmRUS3261270;
	Sun, 29 Mar 2026 09:48:27 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Meghana Malladi <m-malladi@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <srk@ti.com>, <danishanwar@ti.com>
Subject: Re: (subset) [PATCH v3 0/2] Add ICSSG0 dual EMAC support for AM642 EVM
Date: Sun, 29 Mar 2026 20:18:19 +0530
Message-ID: <177479566270.2177634.4781035540543493303.b4-ty@b4>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260311053852.1034244-1-m-malladi@ti.com>
References: <20260311053852.1034244-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|BN0PR10MB5045:EE_
X-MS-Office365-Filtering-Correlation-Id: f14e52c8-ccd3-4a0e-e420-08de8da23f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Ln3DxGl/do28/YG6fnw+EcI89yKkF3fMShwL8muCGTXtUQDjeBpqVAeLZhtLBgpSYaJCUhOwz4NZmV/4j1dMaJpYrbAqU3vEwil5/lwjGFb3+esbxxmCr8w9HFaiRJkhuS9yFf42gNqK7NnZ3Q5ugoG4Rbd8yXSg4cv/nFjh8B+hStZDjsJ+/WGXXX6RvlmlPtvhS5JwcV4ApCfdbvMhsOu8RQPb4986W4CXjdRe/ct28OJkSu9m3Awd+o0tm2HcOIyeihZOo846nGFfXkic+PKeYxNLXlt490j47oYZZa1P686onVSwPOBfSAUvHKy45CcLQykHfi2uERUWeyJzLykxEAK5i8yYeJ4v9XhFtpwjEVA0pre4eZF931b4LeISC/omK+pGN6UBYgXReMAfU9hY3d1TqTuSRD0itDo8WxiuE6s2vImI1DqWCcptAqn4kxCe8gR+MQnwrEP1Dxm650Q4YhVjW3PFzck0kL1qDJnxyKNqba/kMYmxKCslS4m8ezeK01AaPJpUcANtmVWwuf5mYLLZzAFYtwZrO1TONJL/J+xktYQGoXuHGe2TgfaGKCfVLa8dWR9UnJfQ1hxXCbjXE4472F9S6ljc8hDC9h1GEFHXDatseOtSdbGAAoGS+pxbEXAtgYw8B5BEYvAr1ZwV+z+dBlH/2/BOq1z05wixpiXWxCxZKEWAF5qQYNbPUsRL4RqLxGDy3ZDoPmnW5om/cfv5WD16/RJvrRh+Ls61E/eID/SOZsP7apZtzeSC6KzCZrO6pabAF/mNz2puVA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4J+y6fQJdxQDLhgfHesiywtBzijPwSxPLCMJycV1WJ73uYDWDqgTNWp8U61LstSs2PDZRTSLqB3zbFf46w+Dn3CrcGp5RfW2Vlcq/hVPcWGorz3BmK2lzT54YGhs3Vd4GOS+IYprrBRO9htv+Dp/3uqAVvWbZNsDTEThtg1ZawAvFEqRTV48j3hEQ/6zBJgNZukPu/O7r/YQmbvzoVRhurO7fVml7m5J5Rxeauyvklin0GDbmSlRqMulu3rmxXDZWzxSYvLQAxOr/8W85ZrG9q+pqZn7DARpnIxt4DRoy6uhmrX5mgF59b3fCDg/9wCZ6U2SZEK0NyKwsi0of1rqOX8DL1a51JqhQ3urwz8aDk+uhjMOxH/it+fWhB4oVEC84HBV+47BLgDx47ldniRHXkdITAaHwqg0cnkrFXDWwB6ifYB6moCyIc52F+hfPF22
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2026 14:48:32.0110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f14e52c8-ccd3-4a0e-e420-08de8da23f69
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5045
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272923-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vigneshr@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6D6FF3527B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Meghana Malladi,

On Wed, 11 Mar 2026 11:08:50 +0530, Meghana Malladi wrote:
> This series adds device tree overlay support for enabling ICSSG0 dual EMAC
> on the AM642 EVM, along with the necessary PHY driver configuration.
> 
> The overlay enables both ICSSG0 Ethernet interfaces (port0 and port1) in
> dual EMAC mode and can be combined with the existing ICSSG1 overlay to
> enable all four ICSSG interfaces if needed.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-am642-evm: Add ICSSG0 overlay for dual EMAC support
      commit: 8bafdf5dd89b961b698d8bd2cfcebc8e4d3764fd

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh


