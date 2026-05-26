Return-Path: <netdev+bounces-291674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFCFGASLFWrUWQcAu9opvQ
	(envelope-from <netdev+bounces-291674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:59:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E305D53A2
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 302C53058E33
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7373F54C8;
	Tue, 26 May 2026 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NqL57GyA"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1090C3F6C2F;
	Tue, 26 May 2026 11:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779796382; cv=fail; b=L2hJqQ69Mukzq2OhpoZ+bQVaXZJ4s6KP5Gx2HoF8ivrxGfAU3q3ZT+dgq0W/VzkIExR6mt2iTYdRYljzzW7qDGlBnoJ8GFL9iWSnXCzcCtKHNASU9Wc1HoBmQWSWkBYCBQ9cqhmyYNLwtL1AQYZ9HUa3vvTARqT6z5bOjpCtBEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779796382; c=relaxed/simple;
	bh=y0c3qLCtraulT1lChHoF0Q4FFQKWOwRBDsnVS0lQ0TA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ErxX/X2VRQdNTPOY5aU15aNqn0haY+7ULHV7w/NmIi+CwtkPUxIdxP43xrJx/Q5X1EH5cInHvfq4egURF+QhpRA0k45QBIYYMpGfbTsvO/DgbHNRCw1VLdGMuDfxcjjnJiinh15wE/wtz0aQbQOW/HObVg6j1b81aEs/MTrk2G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NqL57GyA; arc=fail smtp.client-ip=52.101.43.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EytFJ/mpV9jAjrSR1dOdFL6OKBFvnrFqwPa9azN6CHyXPa1ncPWnqbXVxWb4i2mnWVt1VvpPMXCUr8Vp87GA/XkUCe550zclQYRwQarWOxIX++ov0DhfmKMHcIHvNYkRyec845aS3c3bqAwEVfYLPX/0DvipoGGwgEVQRxMOE7IRaNkalvNNH5NLWbZhMrdBMy/ieScdz839AEhbPJRq+/+4WT/uUIINpnGyDUFRsM7lt6x8qiu86D78CiHrIS+toQTvufbS4t2vRG4gwrj8RND4p2B6Z+GvC45y1Iqc/6JWzT6epXyRf7wRl3hkaqievE1x9J+CPpqgr256SyxEiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RFfsGAYoOvy/AlHmBfGGYsPu7cYnjwOCKNoBfcKIzI=;
 b=UTfjxprArLAv26LEr1/0s8kpoZghOXacnBOSJS5qC5xCpe9OlkLS1H6Pgf3qxxtYPTYaIB5im1XxBgEqt4SSQp1r8PtMw4xKKfJAtMesR86Dg8llbH+HmoyNl6VyhZHwUiz92dqQcLc5ZHT/rLZiVFO4XR7Ww6+DSoNhJ1xfU88sFd9kbakjUqkqNfck6gM/sk9H9LEVWUrce1RZ0gMOOLqnLECU+SVccto7dgpjoLiU3nGDO+/O4thFz1nJazjdT+GblrVlN7crAKVRM2sIKdmuDgOsE5aFh4ppUMPyMVT7bR1azmAJT8mM+/new5Kw5t961FphgTGQX2NorKudnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=ew.tq-group.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RFfsGAYoOvy/AlHmBfGGYsPu7cYnjwOCKNoBfcKIzI=;
 b=NqL57GyAZbrbUv2oHS9llwzJgZHcf1wU69DjUTb3zjFi5amTIj8G+EEXlZaBd0fp2229teub8Qigm5GY69EGAsav7bQhoSiK1DbhnyRu2C9Y7d4Up+cydPcWtXCL75INdGuH57unsYmz+/9zdfhx6oksX/F2kTUo2TpKv9lzM94=
Received: from BL1PR13CA0357.namprd13.prod.outlook.com (2603:10b6:208:2c6::32)
 by CO6PR10MB5792.namprd10.prod.outlook.com (2603:10b6:303:14d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 11:52:47 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::e) by BL1PR13CA0357.outlook.office365.com
 (2603:10b6:208:2c6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 11:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 11:52:46 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 26 May
 2026 06:52:45 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 26 May
 2026 06:52:45 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 26 May 2026 06:52:44 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64QBqi9E816194;
	Tue, 26 May 2026 06:52:44 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Nora Schiffer <nora.schiffer@ew.tq-group.com>
CC: Nishanth Menon <nm@ti.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Siddharth
 Vadapalli" <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-phy@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux@ew.tq-group.com>
Subject: Re: (subset) [PATCH v4 0/5] J722S SGMII support
Date: Tue, 26 May 2026 06:52:43 -0500
Message-ID: <177979634620.2039539.2170816510689676943.b4-ty@b4>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1775559102.git.nora.schiffer@ew.tq-group.com>
References: <cover.1775559102.git.nora.schiffer@ew.tq-group.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|CO6PR10MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: 757dc2b5-ea7c-46ff-4bde-08debb1d4da1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	FCMnxqJAh0TSbVl5o3cIR0ikR9c7LEfQqvUn1goFoh9ijxqQ8Mmw6BsISnYNmZqBw35meaRGxboM45Zpomg4YY/tmyI2iZ3osDbbNiqao3fMg2b9tQLiGijjcUXWBXFdoqCbImyd1Twrw4/a+ZPRIw8x/uzaadBblggvhfcwszhLOfWnrOXbgB7KmJmB8MO4KVu17gbO8Inb0EnhFqUnaDXMaDnw8cxPBk6JactNxUx0xmifQMd1hZZADq+A2VCFOchgS70ggmhn+J6XVUhoEZrnuRKVkG33GuE1f0EzjSTnMDKGCR//Ja/muAtY6R+LP/zXHiIhA2nSUPGKwXWI9rCjIBsDU3n10ohjrrpIjemXug9KkO1KOeM8piRjAjxFeE7+b8c/pW6aw1/1tG64uc5BsZa6a6GUiJCDt7Z53lzP8K+PMcytSzEAiTMS3n6bqh2BS+KEaFOZ1FEB4LMrroWPKdnsy3GPgY++Ap2zyfZJ1iAgIt34WRf4esnwuf61h5o1HIhY+Pc5816ko4OUeoxxECGZNpjDyt8HO+xJxoz5G1x5hwSgCu76ropIP4FkxoBvz8caIelH90cGlVnePWjNbQFZDUXQ9yGMtftUZpKi9HvKgCcbgFZwMMhXRn5bC18c1TN/qcOAW9xSKirXifjFStAHQkIg/yFk8Q2dEW4gNSRFIZIV1YKRWPBkoc+97ywXREweSdA+9gK7RL1LboaoxDAwnzDy7EHAJdfsulU=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F3xQi+zeBSP0Jxb9B1mJCAIeRhIV7I1lWljsIfSuC7tk0F1FuyGcs0wPJKqYozDQZ1qkXqEnxGf60zfUJf3XXkFUMueBBpRyUoiRfk5X5A4Y2FGYqi+PSD3OAnM5cuKcZ4fn3LK4M8CaegdjHQfIFeSp2ds82TwHdTdiI4WciQ6tFf+adHHq/UH9P8NBDpGhUWm6by+SPdEqzPrmENgc5d4qPq9ChWBQMhYGkEa006dFxodbjnKb9eqGbaXTnh0esNRRiXw5aJwxvEyKhZycYgZWMs0Mvm38Ss451/DErlK4yO/W+5yKtxtLbtO670FbTmrFPs1hmT06fJ2UMjqT6zknCmDonYc9Ih4uBxHJdWgtPq/XMGyuZAif7dWNeR5kQD1nfo2+AVr65ThLoEqvXPUoV876VghSA/sQ+UuMpjdXXmIUtxigyXxF4KTmRG2F
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 11:52:46.2835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 757dc2b5-ea7c-46ff-4bde-08debb1d4da1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5792
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291674-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ti.com:url,ti.com:dkim];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nm@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E8E305D53A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Nora Schiffer,

On Tue, 07 Apr 2026 13:42:32 +0200, Nora Schiffer wrote:
> The J722S CPSW and SERDES are very similar to the variants found on the
> AM64, but they additionally support SGMII. Introduce new compatible
> strings for the J722S to add this support to the drivers.
> 
> This is a prerequisite for the Single-Pair Ethernet interface of the
> TQ-Systems MBa67xx baseboard for the TQMa67xx SoM, which will be
> submitted separately.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[5/5] arm64: dts: ti: k3-j722s-main: use J722S compatibles for WIZ, gmii-sel and CPSW3G
      commit: 2bdc0ea4e7304f6aa7e87089609fd902d9de7a2d

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
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource


