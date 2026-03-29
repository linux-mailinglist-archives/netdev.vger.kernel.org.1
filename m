Return-Path: <netdev+bounces-272924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAoaLC88yWkMwQUAu9opvQ
	(envelope-from <netdev+bounces-272924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 16:50:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2503527DC
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 16:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28C45300A12E
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 14:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D414037AA8F;
	Sun, 29 Mar 2026 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hIfOyBdZ"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0912C21D0;
	Sun, 29 Mar 2026 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774795819; cv=fail; b=MeI9nf+7GDdaCaLXLCZ2cmDWYuVofl3E9Hrpapg7bIjlBRbDv8Q0W7fSh5iy28uJQLIipeaE9Cf9IW/xuQV0sYDxW1B5mwWLAliclVofIJ1KgLg0Yn6rTrgiTGlaHUW2EHEB6XGo8dOy+Wlp/Fj9+4fE5H6cYdE4AiMxjz5L8R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774795819; c=relaxed/simple;
	bh=acC8T1Mc3Iq9HQ61FgIM4/BgF3wzYBPaXIxtAd/FzNI=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=LJO3nXkdjt5VqUkI3w67JscMkE1IsQVNLVdtoUoRlgemHFP2h9m8HTiaIG1BNiLynUVc1Fh7eNZjV7pNjfgnBBU8rgfX5t4CNwk7+5mEyQthzxfXrz7NOXlNHn4QxjWSzZCXqEseAeXO/Xow1LBjkMaI0IFOj0m1L2GZOvNQMpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hIfOyBdZ; arc=fail smtp.client-ip=52.101.43.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BA6yGTE9nxK4o/ndq4AQ3vf5AftLYvBi8bKr//VIEvkjRKcE1fw5hbcPzMukUeCTPqt+d3FtdXLs/JlmOv9Cu2JQhaevbx3YG/xR5uAOSf9jYQQZZeGTOZlXbzAegZ7DSvuFFZ3hRcvZNsvMSQ+0jvJAmjxBT1qJsCAs4QJUWJfCf8cbbPatGkwyMjCEzysDmWM8r8L15INddKeK9kziAiIF5OojyPYBocdxPKxED6oTQfdeuXaGKV4t826Gkcf04eh4BtGZQbPcAxuMIWMxRmOpmhStZxla5HUV071Ow64aujASuoq4fRhxAVZswHzta4Q1flpvraEa9xe+CuWpuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuJXO71fNumNJ8Vb5VvXekITqgQ85yEBTZ0rMblhv3w=;
 b=mNAJl+gjOFAJJdS+VvoVBZX5ulEzoDTZCHYQbzJCGHbiiAztzisFXIPY4JkpZhiIMNgGq4U4OpJdNflb6n/7Pya6udJX7fBRfAAePXPE9cxmT31QNPmDbEDoCrtAaTOAHPaHDEN103otTiv1NhkLw/h81ZemTfwGk9/A32hKW2ckAjsDbpJAtTsfFlMnvJ496c4ZLiwTZxLiRReT/tm8uCCc9d7Fyr49I5OtlE8gir9Fz1l6Tf5SPmO/PmNEkSUbJaIZHgeq7C3QVqjyv+rR0ineN66kgeSMdoOn07LkxQY8u6BB5Av/laFcAJ5XO9NWYBARHwcjBcA8vdps6rLiug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuJXO71fNumNJ8Vb5VvXekITqgQ85yEBTZ0rMblhv3w=;
 b=hIfOyBdZHRiiliBZNUQSnBeFUFFeJoRM6C9HtaeUuTPWJ9zG+JP/OvdLaTPBKgmPijds36l48Er57ShUcl0Qx4Iwf3L+himK98AgcHfwZl+mpACEyOVyC99XqEy3IJCD1+QVxJ59tOe1Nc3ep0VvVeCno9YV3KS+TX33jHm1zgI=
Received: from BL1PR13CA0013.namprd13.prod.outlook.com (2603:10b6:208:256::18)
 by MW4PR10MB6346.namprd10.prod.outlook.com (2603:10b6:303:1ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Sun, 29 Mar
 2026 14:50:13 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:256:cafe::d6) by BL1PR13CA0013.outlook.office365.com
 (2603:10b6:208:256::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.25 via Frontend Transport; Sun,
 29 Mar 2026 14:50:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Sun, 29 Mar 2026 14:50:12 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 29 Mar
 2026 09:50:11 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 29 Mar
 2026 09:50:11 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 29 Mar 2026 09:50:11 -0500
Received: from [127.0.1.1] (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62TEo7DO2794910;
	Sun, 29 Mar 2026 09:50:08 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Meghana Malladi <m-malladi@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
	<danishanwar@ti.com>
In-Reply-To: <20260323090358.632329-1-m-malladi@ti.com>
References: <20260323090358.632329-1-m-malladi@ti.com>
Subject: Re: (subset) [PATCH net-next v4 0/2] Add ICSSG0 dual EMAC support
 for AM642 EVM
Message-ID: <177479577753.2178400.13868702439057938066.b4-ty@b4>
Date: Sun, 29 Mar 2026 20:19:37 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1548; i=vigneshr@ti.com;
 h=from:subject:message-id; bh=acC8T1Mc3Iq9HQ61FgIM4/BgF3wzYBPaXIxtAd/FzNI=;
 b=owGbwMvMwCHG7GTPG/5e9jrjabUkhsyTNvI1wrI2P9On3X3Ys6bIT+YpD/cWh1TV8vP2Guwrl
 2mGT3nTUcrCIMbBICumyBLAtmuWVYrF44iKxK0wc1iZQIYwcHEKwEQiFzIyHJSbdHhPUI/jc847
 s/OmTsnS/vEkYOft2488Zs3j2NMe58PI8LC9IpLrcMkEnqpGwS37yh7GHJT5MH3mpAbfiW8Udkk
 bcwIA
X-Developer-Key: i=vigneshr@ti.com; a=openpgp;
 fpr=4A5A711E8E7E44F9F12F2CFAF903332F551A78E9
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|MW4PR10MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: bac34c5a-88d4-4947-c52a-08de8da27b31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ERZZgAUdGngc5/FLJM1E9JPU7KV0xAwGIBm4ipSrqodXFPwPcrdRfp0czvC2Mch0xOukWy5qGTjaE1/XfU3mXVD+8H7030A6CBiufATavE5WfBmDmE0/T86WT7P9+MTYWsmq/ZoQyfDf+rdO2L/Ht11cpQwmFpEtSSVp18upK+hyzrO5+UBrZtau3wsmVtVF4tYr+xkSct+lIVSjcWMw/zJfuQT1EQsBB2Cvoik7GC+mlk/NJMNzOmSNY3NvbK1TfHWQYu2kC2uN0RZoI/c2NuaQTd1f2sywSvPY+aEhbTQoUzBrp7hdB4vzXr69J45heX1tFl0Xl1AZ3KCjgwtb5bAex5tYUGja+n6f5sgr+0DV9k8YaqwG3YvXz19uXr9VJ9gHoFn/CCae2H4MXLfuTi3/bu8O9G83TtB3oWCJeOBjJIcPAKFsTo/Ja993WqkD44aYXjG3W9MUDkt/0qsuv75QvSWckHaF44+mGqN7m+gpyGeuhxJjlpFsqjfBbJdAmXD/SHKGn3cUWmMmrt6RbilU+qV2hm8KC2/XgLkIM81TmjlJhzYT3AtnMLZd5OedV91Ryd1wT2gYWaOgNNF7WAOG3oPopXy79leIXnsjY4xJQkRcPnR0slM+jQZgFsiBZvA2+Cx1W2/yTiAHXEh6PC/KWbP+3o2kz0EDOvF23vaUTemfEpenLxbB+bUkeVxg0kGmbkmDMP7muxlNAbeGF6KF/VpWAs7qSIMzginNwqAaKImXydPQxgaMpNU0SPdu2Z8zVdY+xnXdl3RkrgggqQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2JRyTCIwupXQZkLPpsUoP22tHwI/1IWjgvLd1ngwmMS6VbAf6mKSfhRCSZ1iyq5kKk5tWGNv/U+5/A1aldfsBjyntqpdSwhVqTLTkGvuNVBj6kEYr1XzM/nFlRTRWNmotaCSTuFJk+Ek4USG3XPelGiBtHbtXYicOuPle7G34JuWceqJLr3kid2wVVqQj7ZUEaUUK0IjujmDrOkkYeG9W41KS6aeVQ+VAuBIYKCYiAfOn3Yx+RKndXfmOIccisVGYfN9Vz9/75gg5aUmriNNKzn9hNYcvX2Bkogr+0VwBi/LNGzQESrfKOs43t1GpK3jJsZ9VGDYDlAG7DiGVpBDikuMFJzlDvwgL8d7iMzuNeDiuWhSjwytnwlmiCCuWzbayjR5Wwzr53AybFkfwyyYwugJjj9qi0MunOo32gnrFlaMQW8mfk+JGaJfd5I6Oamm
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2026 14:50:12.3042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bac34c5a-88d4-4947-c52a-08de8da27b31
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6346
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272924-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vigneshr@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2C2503527DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Meghana Malladi,

On Mon, 23 Mar 2026 14:33:56 +0530, Meghana Malladi wrote:
> Add ICSSG0 dual EMAC support for AM642 EVM
> 
> This series adds device tree overlay support for enabling ICSSG0 dual EMAC
> on the AM642 EVM, along with the necessary PHY driver configuration.
> 
> The overlay enables both ICSSG0 Ethernet interfaces (port0 and port1) in
> dual EMAC mode and can be combined with the existing ICSSG1 overlay to
> enable all four ICSSG interfaces if needed.
> 
> [...]

I have applied the following to branch ti-k3-config-next on [1].
Thank you!

[2/2] arm64: defconfig: Enable DP83TG720 PHY driver
      commit: 192c7f34d2f63552211ef4cb8bbd2933f95106e2

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



