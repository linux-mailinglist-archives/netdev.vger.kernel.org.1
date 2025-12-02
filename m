Return-Path: <netdev+bounces-243177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8BFC9ACA7
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 10:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26F014E13CB
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 09:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4C83093DD;
	Tue,  2 Dec 2025 09:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="LyyQBrin"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013042.outbound.protection.outlook.com [52.101.83.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D163093AE;
	Tue,  2 Dec 2025 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764666496; cv=fail; b=mm81qexHEfv6kOAxuclKHdK4tXq8vvpe4EbITJy8yadYhRoNIeSUk4ocMc/BCq0HTTpt1P3aE5SMvsmbXdP0plg9lom/Peqy3/qqW7u8Q7Mk6WEsuvftkh0rPBeOxYVwgh53ED/muP99ax03YLpfWlxAT3g3A1zUVyhAdZDeMvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764666496; c=relaxed/simple;
	bh=Nd3yNSPy1s/pwRh8a0d8todqDQUT6ln02i+Qb6NiEh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=gQ6Nkj3qJvNZXL+IDF61tWv2HN4ws4ES9upyCWLWdBO/XGelrl1oixqMEPftAoRLLMpJy+UE8Jb6ZmbpKDs4gbvlFb+bldZOXmW5QqejlnXywKjcgAh6KmPZhiVsGknqAvS0Sqskm0EfwL6HHmpbm1P6tWNFbasUxrg4YJ4SsXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=LyyQBrin; arc=fail smtp.client-ip=52.101.83.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CP/9djCfhFKBV0oIO4M+odaNUnNBmVSSl7cDvfXnB53vlOwqpiXytkwVDmYAcHcbVrUwGtiuTJOIbMnbkIDZrxTAgY78OejuKet+OPcYbcR8wrVlNkEkTG1IqmmiPE4Hry1Y4kfDAqJWg82jddpyUSbEBJltL9K7R72NZsQ9Pe8ohSXGbe4Li0/6vKiLXxVxrGunHAtI1Tepum5Is4JSCGBSRxu+p4jPWu04HmkgWp3H9hP7ao23Sv4rp9/qcnDd6Odx8q2wz41jmkCjEh9tWgDtdD/OdJM6D2a8CK1q92ronfNkt9BjfqDBU2e8MQjgagE6G8BRJ7Az7FfflyQhiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIqDkRmFgKK4AzEsAUwTe2ojXXYWFjwPXPFStavus8g=;
 b=Xe4p9tNondNnHiwZbHOYJdQNRdmP38zbqrHt+wVn92IXMCkZFSj1t4ze9yhNfFOz+BOHaLIpBC7AR0ODea8UYgCO7bL2ehiJo3uF+wFmSq/sUWt9xJtRU5Rdcpn8F1emrwJy1uHe7/SBuc1olV2cU8PyDPnqVIrjHA81R74WibmabEVyhKgqpILasaHY7QntUz0S7hnUkV6u4psbQbbnO81mE+/oyKMF9J75p4YwdApZaL1D+FAPwlQh8C/oChiuAPoNTJ8qoahknmrVrfGx7YZR76xHjPW2oZVel+Avn95h197cQgQGpFXcAy6819DbeW+HhmnNuyWY19OlX66CVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIqDkRmFgKK4AzEsAUwTe2ojXXYWFjwPXPFStavus8g=;
 b=LyyQBrinpZ0Io9MT0jZ/emtf2TdFCO6LjH/vkm+ZRZLlkAWbsB9wEC+pwpdmI7aZ+pZEDEF1SO91zD0lMkh91ugF3JWEFJwXK4QuzyuxKEDoHYzQzOthgBW+NQ3idwTFR0HacjnCN+39bz+C7x260XvdopDWStOVsDMsbezi9bE=
Received: from DU2PR04CA0045.eurprd04.prod.outlook.com (2603:10a6:10:234::20)
 by AS5PR02MB11486.eurprd02.prod.outlook.com (2603:10a6:20b:6c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 09:08:10 +0000
Received: from DU2PEPF00028D0B.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::ef) by DU2PR04CA0045.outlook.office365.com
 (2603:10a6:10:234::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Tue, 2
 Dec 2025 09:08:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D0B.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 2 Dec 2025 09:08:10 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Tue, 2 Dec
 2025 10:08:08 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Tue, 2 Dec 2025 10:08:08 +0100
Received: from lap5cd336lbht.sto.se.axis.com (lap5cd336lbht.sto.se.axis.com [10.133.4.14])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id BF262127C;
	Tue,  2 Dec 2025 10:08:08 +0100 (CET)
Received: by lap5cd336lbht.sto.se.axis.com (Postfix, from userid 19016)
	id B4B5543FA9A1; Tue,  2 Dec 2025 10:08:08 +0100 (CET)
From: Ivan Galkin <ivan.galkin@axis.com>
Date: Tue, 2 Dec 2025 10:07:42 +0100
Subject: [net-next PATCH] net: phy: RTL8211FVD: Restore disabling of
 PHY-mode EEE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251202-phy_eee-v1-1-fe0bf6ab3df0@axis.com>
X-B4-Tracking: v=1; b=H4sIAF2sLmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIwND3YKMyvjU1FTdZBMTAwPTJMtUo2RzJaDqgqLUtMwKsEnRsbW1AFI
 i/SJZAAAA
X-Change-ID: 20251201-phy_eee-c44005b9e2c7
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Russell King (Oracle)"
	<rmk+kernel@armlinux.org.uk>, Marek Vasut <marek.vasut@mailbox.org>, "Maxime
 Chevallier" <maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>, Ivan Galkin <ivan.galkin@axis.com>
X-Mailer: b4 0.14.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0B:EE_|AS5PR02MB11486:EE_
X-MS-Office365-Filtering-Correlation-Id: 6978b7e8-0b73-4be0-8560-08de318250fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEpoQ2tDbXpWbXEySlMwZWdTdzAzZFo3a0poWnJKdlVKV081TGVaT0NGQU0w?=
 =?utf-8?B?UHBwUzZHVFRtdGpMcDcyOWREMFVGREZVNTVoQWYwWTVLYnVZM3VXR1R2VGpL?=
 =?utf-8?B?RFpZVzdvR051T2UvZEFPSUtGbk9STFk4by82dzZEVmdWdjlwTzVoN0VzMGo4?=
 =?utf-8?B?ejJ3U2hCNStheUxWcGxkTldaRmdScHhZVFdnK1k4UUp3djZmZU1QdFVxWjhR?=
 =?utf-8?B?WllvZ09nUTVaRnNOUm5KbDRCS2FBRkFBZUk3MVh3STN2VkYzc1VHRzFwbXJV?=
 =?utf-8?B?bDM3ZXlrdG5XOGs1OElzN0krZjZULzZMSXFROC9jZzZpaFRPUzl0T0tZSjV6?=
 =?utf-8?B?RkxCSWdMRUtnY2w0cjBHTGtmM3MvbTd1THZHSHJLdkwxY210ZG9uS2UvdWVG?=
 =?utf-8?B?aEVUNDVHWC9GWUcrOXlmWDl2WFBleVZnZmRQMERoSkdBbzliRlZwVUpFYmw2?=
 =?utf-8?B?V0pMYkhucUpvalVpaFEvSVczN3VReEw5NExwSndqdUtaTHk4Wk1TZThMcW5z?=
 =?utf-8?B?QndSSVhUZHMxWWhvdUNDbDBsaXIvVUZpU2pZWGJHSkdBRVc0d0Vyd0N1STAv?=
 =?utf-8?B?MzI4ZTJMNUQ1TnY3TitKVlJucFh0OGZBRFJYdzhFdXZqdE9YQzROU2JyZkF4?=
 =?utf-8?B?V0hyMmZZTU0xNU0wVWZPNTZNYkl1Y0xoWWxNR0ttZlQ2endFZ3UxVm5rc09J?=
 =?utf-8?B?M0U0dnhMM09ieXE3WmNvejRpR3Q4MWIyZ0xKMmd1eVNqMzlYSE5lcmxmNDRo?=
 =?utf-8?B?NHpRZkRFMDVQL3BWbnhOUys3RGIxYmQzdGpacFhTNlZlQXlvSW9RYjhBN0ht?=
 =?utf-8?B?WFlCcktCaXVNUllQYUZWY3l3eHNqaVY3ekwyUXlSdjVucXlROEZmSStQem5j?=
 =?utf-8?B?dGtXQW1MSTFkbUZ2RkFpbS83eWJLZGNKOTZlZGFRK2I0Tk1JcHFpUmdKN3U3?=
 =?utf-8?B?NHJzRzFWQWEySktaUjFuM1pLSjRBclFVRWRrUFVuSnhwSGN0cW44UzVTNlda?=
 =?utf-8?B?c1ZLTk4wVkx5V3JPc1FPZEFsUzlKeHVjWnhtMXZ4T1dhZDRRV2FPWUkwbVVa?=
 =?utf-8?B?dzRqV3R3dnBRYUFORjUzdVVCVFdQU0Rnanlib3JucWJJWHhqOThxdWdUSFU4?=
 =?utf-8?B?VlVKSnhwcE5aNWR3WmxxcUMyRHhqZ0g4MmllcTgzOUd6LzhwRmxhTndtcEZl?=
 =?utf-8?B?ci9TNHZtaVh5dUFQRGN5YzQ5QkUydEl4RWlxQk1OaUZlVlcwREY0QTArOFNw?=
 =?utf-8?B?SXUvWnNRWW8yZUFLS1h1ajBaczRrZDdQSFQ2aHFLckR0ZVROU0FtdWVUSHNo?=
 =?utf-8?B?SlhPRWtvcnA5WVJiR2RWcjFYV0k5Uzlmc1p3YnhxZnBNMjlvQmFwSzJVMTBz?=
 =?utf-8?B?V2tYNmFjTURwR281Wk5LVXloN3J0c3RQOTZvejg4STBhUlI5aHRaYjZKSGVa?=
 =?utf-8?B?NDhsa2E3T2Npd1NlN0oxMTJkL2o3SFpJTURTMC9tSGh0VVZlcXJxK0h6WDFn?=
 =?utf-8?B?VXZ1MS9yaklHWkpaYWR0Z1dYZnBXQ1JZdUltKzZiVk54Y01WZHo4UDRrNWRm?=
 =?utf-8?B?QjVrWkIyaVlodXFaNk9yMnRCdzZuc3ZOY0ZTK3hVWHpMdkxFOTRyTlNyMG9m?=
 =?utf-8?B?RVg3WlVCem40L0NIUXNLNXNsK29HZ0tVeHViUENYQitnWUFST0xxTysyNnda?=
 =?utf-8?B?WFdBajZ6T0NGSlF4ellPbUpaVlduWURoMnlOdjFUeEpPN01Rc0U4aGdJQmtN?=
 =?utf-8?B?aXgvcEU2cG9wZGY0dWx0RnZMdjY3NzZDZlhyWVZ0SVl1aHRQY2t3STd4Sjky?=
 =?utf-8?B?UXd2a2hXeXZPOXZaZ1lFemtKM1pzK0dyZytpZWYzVXFYbjk1dmlxandza2Zy?=
 =?utf-8?B?aDRJZUJ5MlphV1RNZFVDZk1jYXl2RmJEMHNEYnowK1RuZ0phL3YxN0FWYm5H?=
 =?utf-8?B?Ui9DYjBSQUVLVGV2bU51aWhrM3J6VUh3Qm5JRXlSUnRzZVhVeUg4b1Jyc1dB?=
 =?utf-8?B?dzB1NHZYWjZMM2NZSWYzYmVtZXg0dCsvc1o5NGlOYU1WdmFwellYcVJsZk95?=
 =?utf-8?B?K0U2L213NExVKzY0UGdwQ3hOOWFkaW1GdHhTQ3dsNnNjSDhZOTdPeDMzWDJT?=
 =?utf-8?Q?lT560ScfJL3LcW+5H9p5tWgnL?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 09:08:10.6823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6978b7e8-0b73-4be0-8560-08de318250fb
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR02MB11486

When support for RTL8211F(D)(I)-VD-CG was introduced in commit
bb726b753f75 ("net: phy: realtek: add support for RTL8211F(D)(I)-VD-CG")
the implementation assumed that this PHY model doesn't have the
control register PHYCR2 (Page 0xa43 Address 0x19). This
assumption was based on the differences in CLKOUT configurations
between RTL8211FVD and the remaining RTL8211F PHYs. In the latter
commit 2c67301584f2
("net: phy: realtek: Avoid PHYCR2 access if PHYCR2 not present")
this assumption was expanded to the PHY-mode EEE.

I performed tests on RTL8211FI-VD-CG and confirmed that disabling
PHY-mode EEE works correctly and is uniform with other PHYs
supported by the driver. To validate the correctness,
I contacted Realtek support. Realtek confirmed that PHY-mode EEE on
RTL8211F(D)(I)-VD-CG is configured via Page 0xa43 Address 0x19 bit 5.

Moreover, Realtek informed me that the most recent datasheet
for RTL8211F(D)(I)-VD-CG v1.1 is incomplete and the naming of
control registers is partly inconsistent. The errata I
received from Realtek corrects the naming as follows:

| Register                | Datasheet v1.1 | Errata |
|-------------------------|----------------|--------|
| Page 0xa44 Address 0x11 | PHYCR2         | PHYCR3 |
| Page 0xa43 Address 0x19 | N/A            | PHYCR2 |

This information confirms that the supposedly missing control register,
PHYCR2, exists in the RTL8211F(D)(I)-VD-CG under the same address and
the same name. It controls widely the same configs as other PHYs from
the RTL8211F series (e.g. PHY-mode EEE). Clock out configuration is an
exception.

Given all this information, restore disabling of the PHY-mode EEE.

Fixes: 2c67301584f2 ("net: phy: realtek: Avoid PHYCR2 access if PHYCR2 not present")
Signed-off-by: Ivan Galkin <ivan.galkin@axis.com>
---
 drivers/net/phy/realtek/realtek_main.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 67ecf3d4af2b..6ff0385201a5 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -691,10 +691,6 @@ static int rtl8211f_config_aldps(struct phy_device *phydev)
 
 static int rtl8211f_config_phy_eee(struct phy_device *phydev)
 {
-	/* RTL8211FVD has no PHYCR2 register */
-	if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
-		return 0;
-
 	/* Disable PHY-mode EEE so LPI is passed to the MAC */
 	return phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR2,
 				RTL8211F_PHYCR2_PHY_EEE_ENABLE, 0);

---
base-commit: 31a3ed492dd41908b60b57d82f0ba878eae685fd
change-id: 20251201-phy_eee-c44005b9e2c7

Best regards,
-- 
Ivan Galkin <ivan.galkin@axis.com>


