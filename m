Return-Path: <netdev+bounces-199785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80641AE1C7F
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 824A27AA409
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C4128B4FD;
	Fri, 20 Jun 2025 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Ar9xuEGE"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013066.outbound.protection.outlook.com [40.107.162.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004F123183F;
	Fri, 20 Jun 2025 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427178; cv=fail; b=b4c6OrkRJ4GK4v9InqRI2VJXU9UnCmUulEQlnTvuvJMAgV2Os6ueDnL+kGNRWoELpSE5uvW658iuEDrqzsAy7j2ZiaxpV7SWQtsyqHn7zTbdFYYNj6cmySYkqKXCLhBO2Y4+Gr9iGrcE74CT1oq4JNfjntr0t1/v+tWIYYeacVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427178; c=relaxed/simple;
	bh=zTfF8T2IBIF/AzTdT+/t0wieCiYi/VPmcfTWllZQNn0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HcEmlGTNEqPEj/b5XYbf8XJyXsv5bk63whDwbO7wQ9xE5glSSPfplkeaMg3GkHUJzLyQgUEiPRrKMaI6Td+1STwiVh6q5ds/cs8xJrjVqcSJSLiW65Z8Qx4ypHaTZl1CibjF8wA5gzRpb7D2ijIrwVo3n08TSruQa3WFkePRaLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Ar9xuEGE; arc=fail smtp.client-ip=40.107.162.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8GUgLlS9Juk0cqUnN/vrgFzBZLo2mBEDYlNIsOvHrU7igvjT9JNlTdWLvPoKwoOcT/xGSJSkcagcdbFfN96ABG4M/kl7Jztpofa8cXk+lsOSt1TtldQM6mx2yrzccYX3N6pRu2+j8FDjf5PJcTs6J+j0YHjteBvHbOv+YG/ikTBHabdWdVgcFiuHhx/TpUgCBINBamT0FI384keOgylmFHh72m1NxXvmij8RjDHCOq1oOy4OOdopMhAAns4360Usbk8wIMPUZXEHSFIS5mikTu8bxcQ06cGqWp84Dtr5rn+AFKMUWcZbNq3MQprx+sHMZv89K2HrXd1GgiAuAOLFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4O5pvQPjY6w2YDCvZlJemF2XrW/T5buj51NREF5YScU=;
 b=igcRDVs8gCyVkf/GYzYWgW9oNS42sN+M07mCP1+EUi6NJl7EzObwVqO6Y2TySp1/rip+inS6knS5/R74pRR1V85GDOZjTRu6oi6A8n9FaqRWOkyqKNAbOO/0VFl/lteAXhB28PvbjsgHTqScVVcx22IAmewzY8RbRvNvayPwmB4F0kpWG0d3LMSwjzU+URMoLpuRtuHmmolqAYQjRnDf3jWB8E3Egapo3LEv7cmT4inaLFWXpCU0pPAI2glWcc+8Mk2uDfWE/GWO+woF8krW/ZmFh3rPB8ja73/iIv0+WPD2NOxuP3Rwhxv+1B/FaRjZq2fva47KCIdoQMUe21DLjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4O5pvQPjY6w2YDCvZlJemF2XrW/T5buj51NREF5YScU=;
 b=Ar9xuEGEqbphoY0bIEdDOonO66MLYJy/UQEtWtWXw+8sw2ycYPcTaSrCbyf97J5I4mY79HHj286HHdJ+nU+ommaANOvgqCDmdmT4jvhwDa6nJwHx6EXkC5e80PS/5FUSyeg9b4L8y4zb34YBomhiaNb8+ubiurPfojUZhEMFDj0=
Received: from AS4P251CA0016.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d3::8)
 by AS2PR02MB9761.eurprd02.prod.outlook.com (2603:10a6:20b:60f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 13:46:11 +0000
Received: from AM3PEPF0000A791.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d3:cafe::cd) by AS4P251CA0016.outlook.office365.com
 (2603:10a6:20b:5d3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.25 via Frontend Transport; Fri,
 20 Jun 2025 13:46:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF0000A791.mail.protection.outlook.com (10.167.16.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Fri, 20 Jun 2025 13:46:10 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 20 Jun
 2025 15:46:09 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20=282N=29?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <robh@kernel.org>
Subject: [PATCH 0/3] net: phy: bcm54811: Fix the PHY initialization
Date: Fri, 20 Jun 2025 15:44:27 +0200
Message-ID: <20250620134430.1849344-1-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A791:EE_|AS2PR02MB9761:EE_
X-MS-Office365-Filtering-Correlation-Id: 070be9af-2790-403f-2908-08ddb000d0e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VU5sbWZKNUlkaFN1aUlqVWdueEY0MnVOT3NnYmpGL3gzSW81T0xuR1F5aTlG?=
 =?utf-8?B?WVo2OVA0OHRLK2k3aXdiUDdnMkZnT1JyRzF0aThXRHhodzBYSjRWc09YeGtZ?=
 =?utf-8?B?eDQ1alc3a0NLeDdPcSsveS9mY24yNE1RQkRoQlIrVmlPMXVrTmh0dWcyeXYy?=
 =?utf-8?B?djlpSnc4MUU4K1BjQnN0UTVUZFZ5OHRvUkQzbG5sV0paUm4xTytSRm9QWlRo?=
 =?utf-8?B?T3FQSE1mZi9aZEorb3kyMU5OVmpSQ0c3eU1GVXV2bDhKdGJWYXpqQWh4Y2xp?=
 =?utf-8?B?T1pYdU9OdmdCdHpyU0NQRWRKNDRFaDNmN0R0THVEa0ltWGxiaEx4VHM3Rmxu?=
 =?utf-8?B?b0JVOWd0RVdVZkNKRUVNRmlLMllnOEp6S2NZQWUydFR2c2FhRjlML21OTUxJ?=
 =?utf-8?B?bFhOam1QS09jS212MVRaNlN5OS9SZlBrYjJmUmY1NTlMSDhOK0FMcSt0ZmRz?=
 =?utf-8?B?c1Q0ckRGSzhBbWNqa3dhbUo0a0tmcURGc1p4QW4xTVl2TkU1aGdzanV3cjBa?=
 =?utf-8?B?M1k0UEdPUURQTFh4bW5ZRWdRbzNlOWR1V1ZiRzVodjdUYzV0N0FFY0VXdi8x?=
 =?utf-8?B?T0hZMXFEZWJmQTljVlQ1cU5PUmFrSExQMWhDVkwyZUZKcGtlbzNjbzFkUFc3?=
 =?utf-8?B?bTlxUC9sVGtWbnlYSFBQaFFTNFBGSnBJcGRXYzdVaWhJOU9aTGp5d0hwMXlP?=
 =?utf-8?B?RVkxMXFwdm9lZE9zbFNxOWpkeUVJdVdaMHJVa0JFME8vTXRROUk1UjRYUHlR?=
 =?utf-8?B?Wjczc3Y3TnpiZnFiQTROOU91M2JOSkVaRnB0b1VZNnpQZW9LMkx2ODFKeGxT?=
 =?utf-8?B?UGgvYzN2WjRvQ2FqQXBIWWwyS3FOVTErMUhTVEdjck1taXcyV2N2anJ5MlNx?=
 =?utf-8?B?SjdyY1BiVzA1UzJ2Qk5kVTFRbWo5M0hHS3hBend5S2Zzc2pQQVFaSEdMb0Vr?=
 =?utf-8?B?ZWNqZzlnSE1ZL1RJVldqN1N6M0tOczZpNWxDT0VJRHVuVm4zcnQ0K3oxb1Vl?=
 =?utf-8?B?eUViVDVNcHRlSS9kR01vRWdoT0FRdFFMMUtra2RGYkFWeEZUTWJnSUVoZHpx?=
 =?utf-8?B?U1hMN2tLdzM0KzZya3FXbHQwOFRaYmNOTWtpR1FNbERvbkthRzd4TWdPUHc5?=
 =?utf-8?B?b285NXpMK21pU2xHbHc1UXJuS0lGdWxuVkRUakZsNVRZL2h4K2I4azdMVEpT?=
 =?utf-8?B?U1kvcSs3UkJyaStrMjN2YVRHYy80aEVXbFYyNzdOai9iUDB3Zm42d1dRVGFv?=
 =?utf-8?B?SHJNclZwUGROclROa0JnZlprSkRaODdmNFZLa0VCakJTQWZKU2UrVzhNeW94?=
 =?utf-8?B?SE8wQ0lyYjZHcHZ2cmFseFFGQ2dGK2hjYjAwU0pRV0VISUxuNzJzdVpjckhY?=
 =?utf-8?B?TVVqN2V6ZzdpMVdXOHNSZ1FHTnRYYkhXKzFNSm5PNU9YWlFBN0RiMkNxdUpm?=
 =?utf-8?B?MWFOYlVjVWs5TGZkQVNYOUJUdG5kTHhYT05FQllEaVVOdXBXaE92b0sxUWx5?=
 =?utf-8?B?dm1HZEQ3bUJ3dmdqeGVCU1hzMG9PYWp2L0k4K2hPSG1ibFBCeGliN0xSRGFq?=
 =?utf-8?B?MUFxWVV4M3JjMmM0elViS3FzSThuNG83S3BYK2FYN0JNYjlHKzR5WjEvK2VF?=
 =?utf-8?B?dXJ1YUo3aFJTWkZrTXVrY0dVWGpJTllBY1NhMU5HMEc2NzdGNXpETjVWVHpr?=
 =?utf-8?B?OFdqcTBiNGpxaTNzd1I3YXZVMWF3K2Zoc0hZeHJUemF6VDZDV2VranIwbW9a?=
 =?utf-8?B?VCtHaHNMZ2RtL3lwUHYySElsNVdKV3lvRVJEUjhRWW93cEhscUszcnNJMEdJ?=
 =?utf-8?B?Y3EvNWlNWkV1MXdwKzZsMEYvTzBPbFU2ZlZRVkpRVStuUTc0a1c4b2ZwM0cr?=
 =?utf-8?B?OW14MjBCTUxqZjRsd2t1WFVIM1BkZ2tKYWxhckZDcVM4MXpXYitjT0IwdzRn?=
 =?utf-8?B?UkZqVk9MY25CaGszRmU1NTdTYkRqWlFxNVlSeG9UVHpZUDJuVmVtNXN3RkJ1?=
 =?utf-8?B?ellURWpGa3JRaGo1UjV5ek40YndPTWJWK0VBamlaOGRDajBDUVdJd3h3Znhu?=
 =?utf-8?B?UnY1Rk5EZnVLTElHT3AvYUh0b3ppTmtmT0Jvdz09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 13:46:10.6876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 070be9af-2790-403f-2908-08ddb000d0e0
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9761

PATCH 1 - Fix the BCM54811 PHY initialization so that it conforms
   to the datasheet regarding a reserved bit in the LRE Control
   register, which must be written to zero after every device reset.

PATCH 2 - Fix the BCM54811 PHY initialization by implementing MII-Lite
   mode switch

PATCH 3 - Add optional mii-lite-mode flag to switch the PHY to MII-Lite

Kamil Horák (2N) (3):
  net: phy: bcm54811: Fix the PHY initialization
  net: phy: bcm5481x: Implement MII-Lite mode
  dt-bindings: ethernet-phy: add optional mii-lite-mode flag

 .../devicetree/bindings/net/ethernet-phy.yaml |  8 +++
 drivers/net/phy/broadcom.c                    | 54 +++++++++++++++++--
 include/linux/brcmphy.h                       |  7 +++
 3 files changed, 66 insertions(+), 3 deletions(-)

-- 
2.39.5


