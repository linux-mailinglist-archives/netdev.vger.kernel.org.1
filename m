Return-Path: <netdev+bounces-202448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEA6AEDFD3
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE618188FC9B
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170C328C2AA;
	Mon, 30 Jun 2025 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="OnIy8f4H"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011001.outbound.protection.outlook.com [52.101.65.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86EB28B7E9;
	Mon, 30 Jun 2025 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751291942; cv=fail; b=Bc7rpZIhFzsLlcB5VkpBRYHrrVwMzXI8osZzl7P/7bZx+WqYE8KJAtszvoq4Jwx3/8r5TIymEm4csnhb6gd09rl4BSCJb9WjA5E+0GO1E/qXj3+UlCK5Fh1vZgAzpIagXbSSDV2yZBIeF8Y4D2zDD3Pznf3XKKSwGLtt3hyvyYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751291942; c=relaxed/simple;
	bh=gbMQZ0mGA9fFk6+UKivMqyZZbJm4Ub1mc1CMbI+4f78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s29m+VM11EKDvAk/F0H2MZi+5y21vtkGTzCnQX7wJinStCWlm1EHkJNI2rePaD2Mg5BwE4eDeqjxtSQC52wJ6PaypcRrTyfSt0XZHiSTmVmj/RXh9kMHvnomzrJ/hNqlIjgoALLz9UbT4xKd0Fki8avezlX1gyNUAIdTrPVX7+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=OnIy8f4H; arc=fail smtp.client-ip=52.101.65.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2n/Ti+WyzBiyi7OUbjj8hvvmX1Fn1MkIh/chnpAIqUtzjuDZvVRYw1gsf0YXD3Bwk+CeOZOUd0cQKPNveeNv8hnsHTEvLBivMqTp7Sl27bulofYtlKjSFhxplLJgjfsS4JcOhokQJxzmWrca9j5xiLJ/vC37VyqH/1GY/mIQLsafqhN9XHNByDTVyRdWcY7l8G6c2kGi74Pszdtq3urq17GsQqaz4fe9su3If2KQ1c/Jje+KoWlKlgFizvHhbAMZu34QWSAGNqlp9pbl/fPJYQ63NzNniVe6Z7jMqlQnRYG+e1dtAtFFy9ALQNawzZI91jaCGF2yM9OG4ue9/DC8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2tCBOIPou1iZQMxyp9NcFrcKLzx/7rxuwZH1IKVSsk=;
 b=NHDkDbWf+k0v7qObSarLzbEtWgXi40S9NMp9j6FKyOF1/6q/wJaSV8O+sIBe+MKMTuNr7xc5yxcrkN5iuCirgh/vJPaelDz1Y5iC34YxkDYluR8x8zAk7olZQkRma+VQIBwT/nOwha87nRIbdeCAIEYdh8b2updw+4eZxKUTQhT8FNHfvnas9FC8sNV/iz4IIujUX4agOnY2JqG3xP8I91hv+c7MhClNVEc9SU7D05CVdPJjxNYN1uTvzVh0fJ+nYYbt9SxrBUHSVLWm7azKHd/4nzjruZvE03mI/QLH2VTHrquENJpzVn38ATVetXiKZ9zTdKvJzKZZnVuK/bstiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2tCBOIPou1iZQMxyp9NcFrcKLzx/7rxuwZH1IKVSsk=;
 b=OnIy8f4HypqrXJCeI6hsFk3bVTYJhLhYgM2LKCufIvriqu40OFRBMY8cq8BbGyZAYZr71I0uE5rHR0zeGjy0/sVZml7f70X5WJECGkZIRCQ88vlDZC+04EB8vGP+j36SU317cM4YZaygFpvxBtOMkEwLPed42r18X5RKAilm3JE=
Received: from DU6P191CA0028.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::14)
 by GV2PPF59A8AC75E.eurprd02.prod.outlook.com (2603:10a6:158:401::5d3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 30 Jun
 2025 13:58:55 +0000
Received: from DB1PEPF000509F8.eurprd02.prod.outlook.com
 (2603:10a6:10:53f:cafe::41) by DU6P191CA0028.outlook.office365.com
 (2603:10a6:10:53f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.30 via Frontend Transport; Mon,
 30 Jun 2025 13:58:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F8.mail.protection.outlook.com (10.167.242.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 13:58:54 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 30 Jun
 2025 15:58:53 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net v4 1/4] net: phy: MII-Lite PHY interface mode
Date: Mon, 30 Jun 2025 15:58:34 +0200
Message-ID: <20250630135837.1173063-2-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250630135837.1173063-1-kamilh@axis.com>
References: <20250630135837.1173063-1-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F8:EE_|GV2PPF59A8AC75E:EE_
X-MS-Office365-Filtering-Correlation-Id: 8988fafe-463a-4639-f538-08ddb7de4064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|19092799006|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1lHaTA0Q29aMlN4VjdJbVYwWnhLNnAwWEdaN25oSUFseDUyVDV3eEkydTVQ?=
 =?utf-8?B?TWRmY2ExTFM3MmM5Mlc3NjlSTmt4bkkxVzFvMmRybnZDWHhZZmV2TmY3TWps?=
 =?utf-8?B?M3l6UXVhNW94VHEyeDg0YU5mSmQzR2twRC9yL0Y0Mm52Rmp0dkRSUGNvZHg3?=
 =?utf-8?B?MGFuNkRWUFo4bHJIQ2VZaGRXYVNpNmc0dnUwWDN1ai9yWXN3dUdNVW1YNVFI?=
 =?utf-8?B?SmxCL1htMmRiU1BadnlaMUxMZFpCeHc0Ylh4RFJSc1hoTHFqd2hFTmNXb1B6?=
 =?utf-8?B?UkRrRkhvLzhTTnd0RWxxMU1xcDNNRzM4bG9YdEdFTkV2WGIrTGVreGFISHB5?=
 =?utf-8?B?eGRtdDZFYTVoNzlyWDl4QkErWU5nU1hodTB0dTE1dDJEeEpFeDZWQk51SFJ4?=
 =?utf-8?B?ZmdwMys4OUY2UlRHRVZZbE9qblU3d3YzQ0ZRajdXNHNFMkdGalFaSHJhdzdy?=
 =?utf-8?B?aHNoczg5SC92NFBVeU96NWZsS01ZUVI0ZG53RFQvV3RiOXZwaVVheStpcXdT?=
 =?utf-8?B?Z2kvSnMvQUZsWjcwcmduYnNnRWk5WVZmZHVOV0MrdUpGb3BLNGxEUHZMWWNR?=
 =?utf-8?B?TUVvUGtNcG1WZUYwbHZ1ZjM4L3NJTnVDTEdoOGIwWENKRzhMMDRIazRVdXFV?=
 =?utf-8?B?eUZlSS84SHVPT0dSbUx1NDE4dk9Icm5TQzE3eVZkd0hJNVhUV1l5Yzl1aTZB?=
 =?utf-8?B?NDd1RXBSTGxkOUs0azhYS3o5RmJTRW9IMkhMZWpOVXJPempqQjBOYXRyQm13?=
 =?utf-8?B?TUpySElFZHdtUmFEL3hia0tZZkhBY21RNDhaeEd0TnR4Y21tZHRrQmxQRHBZ?=
 =?utf-8?B?QVpPeXhKUDNOcGdtWmhhMWZOS2N2SkhVNUx2aVJqYUYrazlKME5DRVpOQkh1?=
 =?utf-8?B?bC83cEJOa3FwbzlLRnJhQnUza1hLTzNkRFZ4OG5ZbG85Q2JTNVVFbitoWlB0?=
 =?utf-8?B?UUkvWkdwYXdrajRBaHhKdXNTOThQdGJpL1hhMkJkUzBtdHlVYXFFMURTekJT?=
 =?utf-8?B?bU1GUmlyVXhha3ZYOWhpaGFsdklCSDNxY3JCOGNlRXk0MU5IdXlmcEgwSnk0?=
 =?utf-8?B?RWQ0SEdsMjM1R1EyWmJXbjF4U2Y0NDZKNk5DUk9ZTC9Id1hyR1pPK05GNnpy?=
 =?utf-8?B?dEdjMVNHcnAzUUsvSmVGd1ZqenhUNUh4VTV4SU5FYUlzZGxmYUVNTzNUVUlx?=
 =?utf-8?B?azhWY3FGdzI3M0lpc0NXOHpENzBUWVVrMXJxNXM2eWN0Mmh2aEhUa2Z2Ynp3?=
 =?utf-8?B?ZHQ3cXVlRG1LNlpMeG5la2EzVjVQN2doZXdlRm4xQVZYbTFmWmpEUmM3TmdQ?=
 =?utf-8?B?S1ZqSTdrSjc1THBRUGlzd2JKS0lodlpHZzdIWGZXUDhMMklwUUFhMDZieURU?=
 =?utf-8?B?MXRadnhMUC8xR0NJdWlCWXhRRnZ4a3hHbXRZR2JqOTB1SWVUK1RsT1pIbzBo?=
 =?utf-8?B?QTRIRktQS3ZGWEN4STFhenUrWjFZa2JyZUQwSzNWUmQvZVZxWWtMdndUVFRQ?=
 =?utf-8?B?K1F4MXVFanN0Z3A1czBYMmVwRXVORGZUV0ljRTBOanBKNG5nOHQ2TkRrY2tj?=
 =?utf-8?B?aTl6ekVONHZlUko4NmRuZkZqVGcwUkRFZURVSmtHQi9WWWg3VTNxdk8wUDlj?=
 =?utf-8?B?L0VoOHdYN0t0c0VMSE1nZm9ZS0lzVXBQaFIwV3JuYnYyN21LaEJ1VG5oWHJL?=
 =?utf-8?B?dFFCaE9Qdy95UzB1SEsrTk1kSmxiU3FtKzFvd3hMc2R6aDBZTllzTTRad3hp?=
 =?utf-8?B?SHgxanliN3JDOGRvaWNrYUJSVTdRN3JZcEVkR1E1dUo0K0hYL3R3bjdPWTA1?=
 =?utf-8?B?RkFIdU84ZWd2R2ZSNzNtZ3RaN1N6SFBWMGNIQWJFc2h2eVc5MlErUTBqTnE1?=
 =?utf-8?B?YTRzM0hERFREL1h3UFJLZEdLYjZ6SG9iU2l6TmxCQUxrSEZ0ZUlONzBSaU5H?=
 =?utf-8?B?S0xrb3hhZkR5ZUl5czk0T1BSUmJkZTB6NU01RVR5WjBIZ2lCZXRPYUJpVlZi?=
 =?utf-8?B?ampTbHduY2tsRzRCQkxDMmhhT09YZ29mOTl6ZDM0cEtiN0Y1endPUFFOVUFr?=
 =?utf-8?B?OHJZR25hNmpMSDUrcUk0YTh3U3g0K3orRU9Ddz09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(19092799006)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 13:58:54.6894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8988fafe-463a-4639-f538-08ddb7de4064
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F8.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PPF59A8AC75E

Some Broadcom PHYs are capable to operate in simplified MII mode,
without TXER, RXER, CRS and COL signals as defined for the MII.
The MII-Lite mode can be used on most Ethernet controllers with full
MII interface by just leaving the input signals (RXER, CRS, COL)
inactive. The absence of COL signal makes half-duplex link modes
impossible but does not interfere with BroadR-Reach link modes on
Broadcom PHYs, because they are all full-duplex only.

Add MII-Lite interface mode, especially for Broadcom two-wire PHYs.

Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 Documentation/networking/phy.rst | 7 +++++++
 drivers/net/phy/phy-core.c       | 1 +
 drivers/net/phy/phy_caps.c       | 4 ++++
 drivers/net/phy/phylink.c        | 1 +
 include/linux/phy.h              | 4 ++++
 5 files changed, 17 insertions(+)

diff --git a/Documentation/networking/phy.rst b/Documentation/networking/phy.rst
index f64641417c54..7f159043ad5a 100644
--- a/Documentation/networking/phy.rst
+++ b/Documentation/networking/phy.rst
@@ -333,6 +333,13 @@ Some of the interface modes are described below:
     SerDes lane, each port having speeds of 2.5G / 1G / 100M / 10M achieved
     through symbol replication. The PCS expects the standard USXGMII code word.
 
+``PHY_INTERFACE_MODE_MIILITE``
+    Non-standard, simplified MII mode, without TXER, RXER, CRS and COL signals
+    as defined for the MII. The absence of COL signal makes half-duplex link
+    modes impossible but does not interfere with BroadR-Reach link modes on
+    Broadcom (and other two-wire Ethernet) PHYs, because they are full-duplex
+    only.
+
 Pause frames / flow control
 ===========================
 
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index e177037f9110..b2df06343b7e 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -115,6 +115,7 @@ int phy_interface_num_ports(phy_interface_t interface)
 		return 0;
 	case PHY_INTERFACE_MODE_INTERNAL:
 	case PHY_INTERFACE_MODE_MII:
+	case PHY_INTERFACE_MODE_MIILITE:
 	case PHY_INTERFACE_MODE_GMII:
 	case PHY_INTERFACE_MODE_TBI:
 	case PHY_INTERFACE_MODE_REVMII:
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index 38417e288611..b4a4dea3e756 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -316,6 +316,10 @@ unsigned long phy_caps_from_interface(phy_interface_t interface)
 		link_caps |= BIT(LINK_CAPA_100HD) | BIT(LINK_CAPA_100FD);
 		break;
 
+	case PHY_INTERFACE_MODE_MIILITE:
+		link_caps |= BIT(LINK_CAPA_10FD) | BIT(LINK_CAPA_100FD);
+		break;
+
 	case PHY_INTERFACE_MODE_TBI:
 	case PHY_INTERFACE_MODE_MOCA:
 	case PHY_INTERFACE_MODE_RTBI:
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 0faa3d97e06b..766cad40f1b8 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -234,6 +234,7 @@ static int phylink_interface_max_speed(phy_interface_t interface)
 	case PHY_INTERFACE_MODE_SMII:
 	case PHY_INTERFACE_MODE_REVMII:
 	case PHY_INTERFACE_MODE_MII:
+	case PHY_INTERFACE_MODE_MIILITE:
 		return SPEED_100;
 
 	case PHY_INTERFACE_MODE_TBI:
diff --git a/include/linux/phy.h b/include/linux/phy.h
index e194dad1623d..6aad4b741c01 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -103,6 +103,7 @@ extern const int phy_basic_ports_array[3];
  * @PHY_INTERFACE_MODE_QUSGMII: Quad Universal SGMII
  * @PHY_INTERFACE_MODE_1000BASEKX: 1000Base-KX - with Clause 73 AN
  * @PHY_INTERFACE_MODE_10G_QXGMII: 10G-QXGMII - 4 ports over 10G USXGMII
+ * @PHY_INTERFACE_MODE_MIILITE: MII-Lite - MII without RXER TXER CRS COL
  * @PHY_INTERFACE_MODE_MAX: Book keeping
  *
  * Describes the interface between the MAC and PHY.
@@ -144,6 +145,7 @@ typedef enum {
 	PHY_INTERFACE_MODE_QUSGMII,
 	PHY_INTERFACE_MODE_1000BASEKX,
 	PHY_INTERFACE_MODE_10G_QXGMII,
+	PHY_INTERFACE_MODE_MIILITE,
 	PHY_INTERFACE_MODE_MAX,
 } phy_interface_t;
 
@@ -260,6 +262,8 @@ static inline const char *phy_modes(phy_interface_t interface)
 		return "qusgmii";
 	case PHY_INTERFACE_MODE_10G_QXGMII:
 		return "10g-qxgmii";
+	case PHY_INTERFACE_MODE_MIILITE:
+		return "mii-lite";
 	default:
 		return "unknown";
 	}
-- 
2.39.5


