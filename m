Return-Path: <netdev+bounces-201535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C71AE9CF0
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B979188E089
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 11:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1903169AE6;
	Thu, 26 Jun 2025 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="gYbONZD3"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013021.outbound.protection.outlook.com [40.107.162.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3611DDD2;
	Thu, 26 Jun 2025 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939001; cv=fail; b=euxJ0YVthKK2ox4UJlcZoSqjn91aSk+zuyO5oNMysShdvN3b/AZHHQHxBmOvBaWC89JUeMyBze7AsJRHRCvD/Y/P4iYLxqpJSDnlakha2gqhNoF6Ddk7a+JVjKL8T1ttebARjmfUXNbrlRbYuqzCmI6tYwZjJJ2pShMhaZbOxjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939001; c=relaxed/simple;
	bh=KodxMG/bWpdbAVmj0tQHjsJ4bhH70nPqwkhW/Tz2o8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HiQFIdW83uEttLedf41ChV+QVB7V7qdrbmnz0IpQey+hIn/2Bz4k+c7bGm4puYPebtbEbTzQ4hQrmSjtSlcrzTaLeen8gQ/BCYziCNl4tB3sTyd129xfcTIPYGy760EgskToLOoGkVeTF1jzIzbtnwllc+aqondTgMkbgC5JjPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=gYbONZD3; arc=fail smtp.client-ip=40.107.162.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RESvORMMtF2mZDBDe10ZEYH1kbIe87nDtilJRGpNp/ojmYdXBmqUvvdhIUjG72AQPtbc2vIcgju4VsvP4nP7nJezXV6K2Oh1ggjxXl3qXdMolzitOCIq/LoCYZqIxPhRFQKFWCECP9JTTY9Q5ciOI7p62zr9CyVj+OVhKUweJh1no9hsv/19yNrYuerPuDqGuP2WI/tMtZsuTPN4D+9QWdp4Ct1RTm09z/+XWkf+dE3I9J8s0DfI593INgC73A+Hx6PAwuN8W5jgSwZ+s1feDKDdnZPiDE5gtapyQqMMa6sNknockJMpnGHnNa3lwWS9QXBYyP7oh5AlQ0QcHdv8Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbWzNYcIT5pVWZty1VpC2lyykUMZTe9BHDowDayvUFQ=;
 b=r2hivP2lIQ9vvf4Oi/Lv9YbuhuDuPEo/OGQ5CxZwziAr6oRybMs1Lc0lWa8TOh5baq8/VKL6t+PevZX0d3h28h6Ils02f9/aYNP5VAm5aSZcarDEgLWQrguBkUwzoCorwJVxIzLpLzYqt9wxSZNWXgOKgQ30Q6e69Eo2xbE4gtWwMM7KlreNAGDaCHTqP/RX80dyta/daXYARXgF+ykTiEKPD+A6tNN96YmwEmx5x6L0JDtAyu6vAEKSIKQeEOkDIIjNI546ltEmn7uyTYq+PG3Du8njdXnYKTaBIDSvOQtfzxx6GywnnywHeqfhlXGOuJubD8PUhVEBkBtcNR6urg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbWzNYcIT5pVWZty1VpC2lyykUMZTe9BHDowDayvUFQ=;
 b=gYbONZD3ZefgTjlNmh1dc6cZYkRXHj/KS0dxNtT8pkGew/yrTr0bkx6Z7KVr9u/bBPRJdAMSxSZNkMoJQHoAJhvnIqo0FYE8FAdypEvOI7FWZ8muxOBgrD073ShybyJvLTTqk3J5ceqOWSB4Fr8MfLh8J9pahCT8iRbmckcYQ8Q=
Received: from AS9PR07CA0011.eurprd07.prod.outlook.com (2603:10a6:20b:46c::18)
 by DU0PR02MB9704.eurprd02.prod.outlook.com (2603:10a6:10:42c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Thu, 26 Jun
 2025 11:56:36 +0000
Received: from AM4PEPF00027A60.eurprd04.prod.outlook.com
 (2603:10a6:20b:46c:cafe::60) by AS9PR07CA0011.outlook.office365.com
 (2603:10a6:20b:46c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.15 via Frontend Transport; Thu,
 26 Jun 2025 11:56:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A60.mail.protection.outlook.com (10.167.16.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 11:56:36 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 26 Jun
 2025 13:56:35 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>
Subject: [PATCH 2/3] dt-bindings: ethernet-phy: add MII-Lite phy interface type
Date: Thu, 26 Jun 2025 13:56:18 +0200
Message-ID: <20250626115619.3659443-3-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250626115619.3659443-1-kamilh@axis.com>
References: <20250626115619.3659443-1-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A60:EE_|DU0PR02MB9704:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d9b680-e27a-4d9e-b83b-08ddb4a880a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHpOaUg2QWxIOUlPb0srZ04rZTFYa2toSmVDY3pzak5oY29YNEZkM1FUcW5p?=
 =?utf-8?B?cVlob2puS3h3WjRzcmx4dDJuc2djTUdlZzJhZFFCMmVSbDl4TUFKQXFEOGpS?=
 =?utf-8?B?Wk56Smd6bmpMc2hTWGI0dTdGWEJGZEFpeWM3dUluRVBOcjExVkJhZ0RXanJo?=
 =?utf-8?B?dDYvSTQxcFlrZTFldm8rVUJRaDhFcjBRVk8zMkQ3elJQTXdGbmN0VEhheEdX?=
 =?utf-8?B?cWdCMkUvMFZtTWdqbEViOUNHRTRyZGFNSWFOcTBZdzdSN2VEdzkrQitJVkpM?=
 =?utf-8?B?dWxDK2RCS3NoVkUwTlQ1aHBTcVdXQnhXd0V0MkRkYVJlVVBSREpGeGN1UnNp?=
 =?utf-8?B?dXhsMVZRdmRzR2MvZGdMd1hUQlZsOVpDYitMZWd3SGwvWFEyMFE5Y25qM01o?=
 =?utf-8?B?d0p0dUFRT2ttdUJhT0dpN3BYMThzdXpIV0NWR0ZHWjRsa0w5bGpkQXplV2lj?=
 =?utf-8?B?RXA3SlhRb3FTMW1zOXZEWGx0d3ZMMlN4QnVIYmhZZDhuQXNkT0o0SC9UOEsr?=
 =?utf-8?B?ZGk4UGVVbWh4czJacC8rSHFlNE9EUXI2ZHhreXJaZXRGYUFmbUxEd3pOWFVR?=
 =?utf-8?B?RDJRdDBkeUVSWWw1YTYvREMyUE9rbkRkZUsvbGM1cTZqd0VkVlg2V1QxaWFl?=
 =?utf-8?B?OURSOEhMcGJ3Y01zVFVoUERoVFRLRjJ5Q29mQnBwMkFZQzZKOXhNcG9QekI5?=
 =?utf-8?B?SnltSVVwVVZ2aysrNkhMK3BUbDhCTkU0UFVaaURTeFQvSzh1NmN2WVNBdWdy?=
 =?utf-8?B?TzZYNmR4dWdVYkVPZzVuMnlKNmFoMFdCcG5EeE1lR2dXWTN5VUxGdDQxUkVn?=
 =?utf-8?B?WE53Z0ZIQmxNQjRVdEMyS3FzQmRXNDc4Vy9UTnRnVW9ZQ0FGbE0vcmczcmJp?=
 =?utf-8?B?bElTdWNpRGJ6eC9hTmRlQkVmVFU2cVdXUko2WHhkOTV4N0cvaC93Tzgzanla?=
 =?utf-8?B?R3pQTFk3dmtoVkhBaWYraXp4RGpKdWJzeUZZRHJ1enJWbEx6V0hVY1lBZkRz?=
 =?utf-8?B?MjMrL3hLcGVUQzNVZ0xlOUJnVkZQL0pCUkorRVBGZHpnZDFueEpmUzBRTWlu?=
 =?utf-8?B?M1JDdWpxTkVrTFRqeXBDTG1ScG1NZDNPZEdiL01obGxmWDY0c3dMQzE2T0xq?=
 =?utf-8?B?dVNpdVZ5YlVJWFFPSHRFSWI2aC9kVDBaa0pNRXI4UkwwZGI4ZXVSZGNTdEtM?=
 =?utf-8?B?eUNramNhWEYzTWVuQTZ3UEVCRDcxUEFnek4ybWM5MHkrWXJvY1R5S3dzMmo3?=
 =?utf-8?B?SjNqUTdXZTRZQ0hwT1ppNUJ1cGYwcVNmWjdmRzVKam10Y3N0N0NSYVI3STBn?=
 =?utf-8?B?MmlMdko4T242SkZZTkhkOGM2bW1HOEtuVWFKdFcwMVplVTJDWWF4cGV0K09D?=
 =?utf-8?B?Zi9MTE4xT2lFTmNIZjRkSHA5Mis5aG1VS0ZsR0ZtUEdXdWRrMVI1UXNKZ2sv?=
 =?utf-8?B?WTJ6TENZYWI1dGYrc1VQdTB4ZmJWQmY4OElVUCtZa2o4NFR6aW51aGZFSUdE?=
 =?utf-8?B?enl6djBIazYrWWJwSUc3R0o2ZXVOS2VQcEpGcjY5REw5dGhVMVVIN2lMT3Np?=
 =?utf-8?B?YzNBNDlaaDZ3ZXVvQm9lY1JNRGZGbXdaSWR6S1lid2IwOGlGanRLZ1Z4aEdO?=
 =?utf-8?B?eTlvVmJkVEVGc0FXanhnRDhMWmo4LzJXZUVsWUE2d3RSbVhzTEdyMmpvK1U1?=
 =?utf-8?B?dmJOYWFoeVJ3WW0wWmJMZG1Mei90bXNRSnV0cUh2N1JHSTJBbTlYb1hZWURk?=
 =?utf-8?B?SzJBb0svNUR1Y0lEd0c4WStFREFYMGFRaVFEeEVnRnFXdFd0NEFyMGw3T28y?=
 =?utf-8?B?dktkOGJQNHdoTDcvZkRxcTRXWkxYOVFpQlNqeWRiVlc3aThCenlQWHVobUJZ?=
 =?utf-8?B?cnF2M2hxdXNQb1g4V1lISFlJZlVUM1VKdEEwek1mM2RuTkRLSUtkZkJwOWVT?=
 =?utf-8?B?MVFtcVNzZkw4aXB6eVkrYjkvZDUweGVxWFowNFdVOVlEbFJyYW9ZUklJWjcz?=
 =?utf-8?B?cE5MSjRGQnB6cjEwTDBpdnFmankxdVovOG4zbE9SUXdPZjdyZy9LWk5qSjZJ?=
 =?utf-8?B?cTR6R3RlTWZEME9DK2crWGkxUGlkbjBWQmpjZz09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 11:56:36.2039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d9b680-e27a-4d9e-b83b-08ddb4a880a7
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9704

Some Broadcom PHYs are capable to operate in simplified MII mode,
without TXER, RXER, CRS and COL signals as defined for the MII.
The MII-Lite mode can be used on most Ethernet controllers with full
MII interface by just leaving the input signals (RXER, CRS, COL)
inactive. The absence of COL signal makes half-duplex link modes
impossible but does not interfere with BroadR-Reach link modes on
Broadcom PHYs, because they are all full-duplex only.

Add new interface type "mii-lite" to phy-connection-type enum.

Fixes: 03ab6c244bb0 ("net: phy: bcm-phy-lib: Implement BroadR-Reach link modes")
Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
---
 Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 7cbf11bbe99c..66b1cfbbfe22 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -39,6 +39,7 @@ properties:
       # MAC.
       - internal
       - mii
+      - mii-lite
       - gmii
       - sgmii
       - psgmii
--
2.39.5


