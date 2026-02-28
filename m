Return-Path: <netdev+bounces-262113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEpDOELSomm+5wQAu9opvQ
	(envelope-from <netdev+bounces-262113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 12:32:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCF01C28F1
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 12:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D066302F278
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 11:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1800242EECE;
	Sat, 28 Feb 2026 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rXy7rF3p"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315CA36C5AD;
	Sat, 28 Feb 2026 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772278335; cv=fail; b=F3TsMQn+YG8URKtm1WX56CHhkv6XBtKiBREPAKZYm4LaGgIiAhTco2coj1Kfh9Q3UjBaWbmYNjJ1piw34+16j0PaO07fRrPew+r349rFu4DphpmXv63OJn8YjHW3v4OqKaPFTSMgyGnp3wP00fv/nFy7wWO+fL50k5zB2n3Klq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772278335; c=relaxed/simple;
	bh=ziDGncAe1I3X9IfxOcJIgHSOCu3ufmsCXx5EZJxln2E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LGt+giljbDhNEqBWp+nbh02BT9LKPfPY76jPhMg6NgGgpZzV1MOB9tsvI5ig/LGATPbb4s0k9Czp+KbKJtQpiCEDtfBowscBUGqkkx676zuKKrAfLGJebg3n2ddwD0YUsC0QRY4vlMVWYjL1uE5ryBbYSanelCefgorzPNHD8KA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rXy7rF3p; arc=fail smtp.client-ip=52.101.62.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7LQgD0o3vxv3AUE85B2Ihc1puZjDJZ08goMxV+k0uGCGxRLlffYeqm+FgxRD5xAGLWueL9Dnt1gZA7LkI6+6mwypQVaVC1AM/jcHk5rmIDrG93M/8Ct85F6Ll6y2qOhOpc2pl3V06vNQV0SNecK3fRmQs61sf/QS+LUkNgCdRd+McTpKdVTRCkunFrHsZzZ9ISm6TM40TMgUoqoEXGeyT3ESaAzrzuwTIRRNYnKGl/wFfdYPRukKUUCJHFkRnwCrGYb8eU33AZ9FJpt236mwvF05yfA52/I5HqORAsJpLlHRL8GY5i6T68/x7BncA2Nx4MUsYURYamvFBUsfLXmBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8y/Fediq3Qr3XBKy9zET0+4qiVdSR2XuzANY8mnKOg=;
 b=xKjrRwKYnjjIk2nqMEvv8QCRX++Jn1EA6pQ8gbwOg/ppSwLmmKOXokxtkuw9q/0WCHAe5WhfN4F4c2cX+qUOiKZleVjjQmqSnyROkUWWSR5R5lb26hP7dRWRPbAOtrfUEkBwTI+14N0UmKB+rAeoE5CpXnrNFayAy5rvKJCpEkj7kDMZ4PUUlqbrxEhP9bL5BCJO7AkLlUd+BixsCMfDksdYEwwq+Ofqyf8alsRwogA6tYBElNssNH7XDSVlnln3pwLnNJ/zdAPWInasAo45HbCNClzn/iumT2A942vQgwTjd2WBVhcIu7HOKnNhKcOvz0awFfcAFkeyPY0frcDnYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8y/Fediq3Qr3XBKy9zET0+4qiVdSR2XuzANY8mnKOg=;
 b=rXy7rF3pHgEYpZnkgleTxmxbz2IRolMALATgFm33J1fwcMLOKd5UujWRjqow99zw0tB4SEX3DyKzZqmoHC14E1QT29kbQ1DIKf0axdNK7yLnQz5SfIJ49ZClpddTIWvdIl3adIp5oS9JhWcRBgSjBwoMttxNBpo+r6Yy5Gm+eaQ=
Received: from SA0PR11CA0156.namprd11.prod.outlook.com (2603:10b6:806:1bb::11)
 by BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Sat, 28 Feb
 2026 11:32:10 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:1bb:cafe::25) by SA0PR11CA0156.outlook.office365.com
 (2603:10b6:806:1bb::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.27 via Frontend Transport; Sat,
 28 Feb 2026 11:32:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Sat, 28 Feb 2026 11:32:08 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 28 Feb
 2026 05:32:08 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 28 Feb
 2026 05:32:08 -0600
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 28 Feb 2026 05:32:08 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61SBW8Hn315366;
	Sat, 28 Feb 2026 05:32:08 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 61SBW6Vi005180;
	Sat, 28 Feb 2026 05:32:07 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<kristo@kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>, <srk@ti.com>, Roger Quadros <rogerq@kernel.org>,
	<danishanwar@ti.com>, <m-malladi@ti.com>
Subject: [PATCH v2 0/2] Add ICSSG0 dual EMAC support for AM642 EVM
Date: Sat, 28 Feb 2026 17:02:01 +0530
Message-ID: <20260228113203.498839-1-m-malladi@ti.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|BLAPR10MB5009:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c079b3f-55fa-468e-884e-08de76bd01fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|34020700016|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	C9ia1/v7w/gJa7xRf79Vnw46A+DBkqybRx6gWlYs/mTaqAozAIY9E4OrTrJIzAlR6kfqrEyMXOw4726nxFONnqzwqdZtr/+GQXiiLBZMHlj/NLhJTAwI8oDqWjL2ce2P16IwckOHkKVPBkOvX30n4/+z07Z7vR4aChRN6mehFQA/IUKm+WY7b2zGgz7QxXaju/UbU4VX66dTLwosaSZYBpgp4KjLKmeojPlEMcpZzBwqFnUpzkiWbIPsPNBlxjyfotUHm9qZHt7vY5rNKRC5pvH+YbqQeK9yDtU10LUGYwkyJktcqfiRxhGnDCPCxcnNeEBupChoShKjQr+D1EgTlK/Gy3tmz9lW4ZuLsaHA6qPUJQBxC1ypSXVngLUA+zzesIwiwTgh67EvcHCi5RugF0Lx96luq4NZppmc+Dq52igthUnFzw66t0wxLuOhoDk0ktfw7wogKNivadldQsjGR64Kdvdp95M9APxl0BTyIgBERgZoiM7KcRFvVnFA1lVIog4Ya+e6j1Hi4lJzl/LRZRV1aUZ2YpHbdlXxaI8VlU2pLDAKv216FEFgPoANYW/LGTeGBZ7XFmrf52Ls5/9qiIWEUJiGefi4fa0T3Q3G77c6PLqnAXKKA6cJvJUaGtoQMer1irE6dn29RqpW/GMY340sbRNKXkx5VypXymFxlCB8iJQMbn6WOJ65SR9XQ2cwFWTPrDGt1Hmy8xoIME+25UBTRXfiLAqSD84M+pi3kza6jx4JZDwRaVYKqfFtA5R6EECyeuXj35c4O0rkhAk0Yg00TKa8Bc25XcQRIESABFFKIESfSXxR4nvjbwcUD2F+
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(34020700016)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VBW3LOjjxZZnL1pMa3H1j0sT8ImrhbHiqxDpGFMa2Xsuj/mfvtsF8EL4j6AI3dAqCE/kJLwZlcHtUvY/5ps+G/gfijqRJXEHMTGbCOvtZl8pVFxLfqrcm8JfntAk/4REF1G4EWaWsV8RI4t0Qv4DN/chGZCGgu/CMQbhM25jobU+5akdFFsDaLd/NzXDLSLe1ENx/uLdYDGkyLJe9ILrdMZyEKFui7BuZMdCVEHTwvR3uIoB0L7ObdZt7T37/oMv5d8MK26E1Zm0reZQTx5JBhhtGK5n4QmdbsZKIENy6sKWQHQtPMl82xNOFNF44qbmk3QAprk5nIPwL1xxlxc0Bdegy3ax9VEfK1oTrnW4vd66rCKmIuOclzXjvGi8fRIO9HRLCG9R7dFElFc4u5FCg2LljHHhmd2ra2wA1tCGc0xm/svimKo3SaE+rcqu+des
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 11:32:08.6622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c079b3f-55fa-468e-884e-08de76bd01fa
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5009
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262113-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:mid,ti.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 3FCF01C28F1
X-Rspamd-Action: no action

This series adds device tree overlay support for enabling ICSSG0 dual EMAC
on the AM642 EVM, along with the necessary PHY driver configuration.

The overlay enables both ICSSG0 Ethernet interfaces (port0 and port1) in
dual EMAC mode and can be combined with the existing ICSSG1 overlay to
enable all four ICSSG interfaces if needed.

The series also enables the DP83TG720 PHY driver required for the
DP83TG720-IND-SPE-EVM daughter card used with the ICSSG0 interface.

Meghana Malladi (2):
  arm64: dts: ti: k3-am642-evm: Add ICSSG0 overlay for dual EMAC support
  arm64: defconfig: Enable DP83TG720 PHY driver

 arch/arm64/boot/dts/ti/Makefile               |   4 +
 .../boot/dts/ti/k3-am642-evm-icssg0.dtso      | 203 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 3 files changed, 208 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-icssg0.dtso


base-commit: 4916f2e2f3fc9aef289fcd07949301e5c29094c2
-- 
2.43.0


