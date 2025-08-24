Return-Path: <netdev+bounces-216295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B15A1B32E77
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 10:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB911891025
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 08:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D2C265CAB;
	Sun, 24 Aug 2025 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aELXWLP3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF727264628;
	Sun, 24 Aug 2025 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756025090; cv=fail; b=OkV5FHfxrYp3F+CUn6ZKi07oBztuh9NYq+JxrzLfYb+cfDswcoVLhWbQoS91BV7mfqJVTnbEyQkuYWQpoMlhSiM8TROLL8Q6y+qLKjSmYpQT2N1TxyPXGd/RFnXIXqy7I6SgkcIhC4C+p1ebp+wM2y9hynUU/rUn165b0kn8Bn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756025090; c=relaxed/simple;
	bh=pcHCxmr3Pnrs+Xm2lk27wl7sR69q7o5v2zMT742AdUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UtQOsjZtF33miA4k+oM+Xo5D/+aRP8TxnIyQ1RiGW+OkO3052MxAa6EFsy0w1ifIpGLwmP4+iiBeLyWqRlYNFFz4TRQbF1O9nvLU10WUFkeClQVt1Nmg0z+9ccXMKulnmhEqKx9pcBOmU2WJNjiHBC8M245/sqTE17liqaUCyVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aELXWLP3; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lv5uAFtRxAD1pAB0XO0vkNZDvjZ4pIE3y4boD30+lEYRzdXnIs4Xj8aC5PvPbR+a2I5r/VSfcdOWLL3LSFH8UdgUsZUS272w9yQgKoFNlWORLUnKJKpWIDZ+AYHA+lksHL7fLTiEA3gTSahSIb0+WlNq7ZdTF+GA8raAPiKzgbMIdIxYaQktbuAe6qu4z8ajvQwUPoc6iQcnvg5SwY6LUtmq44Pu/C1ahm32wpfqZ72NxXOaruPC8gb0SZJYdypCHu1d4yUV7HhJ7VRNpShaTRAq4CMnFzKkHOgCYOqQ4lto6853CCrXMrVrDRSigeLw5U+/MkvQspXiVxG52Cn74w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojhk3Ht1Oix4jfbENgatscQlP/4oEIY8hqGfGWO33l4=;
 b=FJ5sSeRW2T5hYHKJyEO8iH1FPY9qNhk7YC+/d/TwLMIwZ7XxeD2J2TeetG6AgtlJMIKJ7qy7R6yIFMQfa9ePMKTSpDiDiGsNJmn/7Vh3sjZuzRCSufJmtooyB/ZzaKG1kYOrxD32ai4/DM3L3WyTVysAs4gFMZXslaJrBvstbYHd6ZFbvQR9YsZEX6ONboH4KmuZgyzSWh8Ww5im6fiLGcmZZL409SLuXcoNhD3dFFfjhGpAJ0yyclpPEkzvFTU6c4tvFjdtFxwN4P43V0OoYDR1dXbKJON6CPSyANaxZDciYufMVqTpIedbd+/vO4sF7wdMO6n3+5zQkn32zBEInA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojhk3Ht1Oix4jfbENgatscQlP/4oEIY8hqGfGWO33l4=;
 b=aELXWLP3iB8nJ/3hMEeNCdR5gBknvenrTf/zNDX40R/d2nqmQc5QlPvcJfnQm0d+TYjiTUof/ZmGPeSJKIkgJXZWBRyfF35f2ppSk6KZsOO9Vaz9rulYvcbYzke/0AHV8U9GE8e59pjmzUqJwzBOhvaOGTki0BS8YU2sqj94PaOjr8zllvRmP3j6DCucR3f5dNnKak68Wh2yREixCpmDWgWA/yPQrkDyik2sVE8QxCRJW6NPDVR/LulSXLfipjQdDbz/h3S/5FXo16OSYaZwn09Hk3iI5OWP+O57BjD939UtzCZ8W8jB2AXZFxJp+f32yICk/NqpjMdyqnda0wG+gQ==
Received: from CY8PR10CA0048.namprd10.prod.outlook.com (2603:10b6:930:4b::14)
 by CY8PR12MB9036.namprd12.prod.outlook.com (2603:10b6:930:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sun, 24 Aug
 2025 08:44:41 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::8d) by CY8PR10CA0048.outlook.office365.com
 (2603:10b6:930:4b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Sun,
 24 Aug 2025 08:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Sun, 24 Aug 2025 08:44:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:44:27 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:44:26 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 24
 Aug 2025 01:44:22 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next V4 4/5] devlink: Make health reporter burst period configurable
Date: Sun, 24 Aug 2025 11:43:53 +0300
Message-ID: <20250824084354.533182-5-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250824084354.533182-1-mbloch@nvidia.com>
References: <20250824084354.533182-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|CY8PR12MB9036:EE_
X-MS-Office365-Filtering-Correlation-Id: df0a62fa-ed6e-43a4-fc79-08dde2ea77a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dG1BVVNLR1BJbmd5VkgvQ1pqMmQrOVdpbmJFc3p2bXlPL2tXaGQ5dmdsQW9O?=
 =?utf-8?B?eWpscmVJRzlRME9WMHBwTEd5Zi9VbkdsZWJEQmd5d1FHQUd4RlhlUXZSWXhx?=
 =?utf-8?B?c2ZEc1p3NnViU3Z6dGJkdzZjMzV5bktZenlRWkJpU3V4Tk9hbUc2ZzdXNHdK?=
 =?utf-8?B?c1ZWWmJZN2Z0NllDWUtqbk9lK256elAyZkhQRGJvanE0b25IaXBOSmF4VjN0?=
 =?utf-8?B?cURPb3pCZEdSMjFqWlVGUG9tQngyWW5PRU02OWdNc2hrU2xNd0NJRmVJOW1n?=
 =?utf-8?B?OHJnajJybFJnVWl4UGJVcTFVSEF4Tm1oTXBmaGUxY3Z0THNYa2VISVpCeXB0?=
 =?utf-8?B?c2FBeUlXNDRzK1lqSnFlTWJQcUN2M0tPM1NGclh4NkdUNERlSGQ2ZW5jN1FT?=
 =?utf-8?B?V3lKQ2NKNlNVbm8xa1ZTYVlRZWFHNUZwNFFpb3dBVEFJZXJiR3VJWnoxazdy?=
 =?utf-8?B?Q3hoVGlzQk9JUmM5dEFKTWhLQk5HU21mSU5tY05wWGhpdStmbXVEWW9Gd0xZ?=
 =?utf-8?B?NG5NVHZPSEpYcVF0NW5hdlR0UDVXKzNOM2FTTURMYmpvT2RtMlNmVGZodThU?=
 =?utf-8?B?cHN3b1ZaYnBQL2ZrRHlSa2xmMzIwWkZsWEpGL3F0bUU3K2E3WlRmWFRDRGJC?=
 =?utf-8?B?ZVc2MkVJOFppMW8zUSsvVEJ1UUhYUXRBVFpCQW1WVHg5RHozZ0FGamhWUDFs?=
 =?utf-8?B?eU5mU3UwbEJIb0lXZG10QXlmdDNFdkVCK2lKc0ZHaldicjlwRW9ld3RpUENs?=
 =?utf-8?B?bWlCak81b3JuUjdSR1puT204R05wR0dNbWpteVJHeVNXSWFKaXVYSHM3S1Yr?=
 =?utf-8?B?c1dtakJ6czR4MVFuVTg1c0tpWDZDeDZCQ2NFbzMvQW5odGZxcVc4QTRhREdS?=
 =?utf-8?B?TElVRlJVY1NQMTAzaHZZaDdwUkZFUG9FMmdCY0lla0pQU004SVFoVmRueHFv?=
 =?utf-8?B?UXBIc2ZmRnZaZ0IzTERyTVJXOWVGMW0rNENzcVc3WjlEcHloTHNETVdoQlRW?=
 =?utf-8?B?UjNmZ0gvVzYvSnJMRklBbzh0cFpYUDhhVWptSTdobUc3bldFc0RtR0x4RGo4?=
 =?utf-8?B?Z1NaNnJOTDZ2eVpaVnlzNEgzejllL2N0d1N1czZGUW9kdG9kRnRyTWl5Vzly?=
 =?utf-8?B?SUUrSEZ2RE1GbzY5dUlLNzN3b1RodnNjWjZSK0ZNVk5iZHdLMVJQdU5RbFhq?=
 =?utf-8?B?RkI5ZUVHYWRQczdJWUxCc0JONlMvYzdQeEw2NjVQK3BNSVlPV2JVVzRJZlVD?=
 =?utf-8?B?WWh0UnoraHp2eEFpUzFSRGNuaWpoUHBHQ0dRUVJ4eGJuNVlJRVlEcnlwL05G?=
 =?utf-8?B?U3N6OS9SMkZTRm1xb3BGa2N5d2pqVmdnOGwxMGlVaHNPSTBsR3dvMEtTeXBJ?=
 =?utf-8?B?VllCUUZPWVE5NHRrR0w4TEJIY0RhbVpIRVYyam5RWm15K0tYVVE4dStrSWwr?=
 =?utf-8?B?RTAzcWxUMzUxQXZWVGRYRXBqdnZyY0xXQlhGZyttc05sNmEyeEU3cDhkcCs4?=
 =?utf-8?B?Q0phZmxJOWtpeWxBcjg4ZVhLeU5SNGRodmVhNEQ1dTIwU2srNzM1WDVBKzNO?=
 =?utf-8?B?bkVtdDdTY3Z0VlMxcldrbFovSUppZGJOd1kzM05OMTNGdmdyemRtd3FMZXdo?=
 =?utf-8?B?L0FGZmEyTkdBZ3hpLytuazZtUDFkcjNzcEhYUlZaTDhya3ZmSW02L1Vmd3JK?=
 =?utf-8?B?aVJBYXhSMW5nUnZIeXIwTUpJUTA5VU83R2x3Q3hYSUQvTTFoSlB5Nk9mcXM1?=
 =?utf-8?B?cWVYWFJ6WmRvVnJNYVdiZTZMakhTS2R4Sys2cXJjNmlUVzY3YXIvd0hhV1Vo?=
 =?utf-8?B?SWNKaVVyUklLMVFuU1d1bjRVbk1xenZpN0FYdkpzVUFwS0VkSVE5aVdmbk81?=
 =?utf-8?B?UWVkUnhaSHFqbFg4TzdZRy9YeG1jTDJJNlYrTUpiQnVpNWtYajBkR1M5eHdO?=
 =?utf-8?B?a01SVEhCZmwwTmo2VC9TK2pRc1E2eDFBRXpRUStYZkt4LzVEWWVvaDBZZnNr?=
 =?utf-8?B?Q2E0QjlJSW5ySHpLbHJaZWZ4K1JzbndLK2FDZVRNSThNcWN1YzFVZU1GM2Ux?=
 =?utf-8?Q?Nca0qY?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 08:44:41.1827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df0a62fa-ed6e-43a4-fc79-08dde2ea77a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9036

From: Shahar Shitrit <shshitrit@nvidia.com>

Enable configuration of the burst period — a time window starting
from the first error recovery, during which the reporter allows
recovery attempts for each reported error.

This feature is helpful when a single underlying issue causes multiple
errors, as it delays the start of the grace period to allow sufficient
time for recovering all related errors. For example, if multiple TX
queues time out simultaneously, a sufficient burst period could allow
all affected TX queues to be recovered within that window. Without this
period, only the first TX queue that reports a timeout will undergo
recovery, while the remaining TX queues will be blocked once the grace
period begins.

Configuration example:
$ devlink health set pci/0000:00:09.0 reporter tx burst_period 500

Configuration example with ynl:
./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/devlink.yaml \
 --do health-reporter-set --json '{
  "bus-name": "auxiliary",
  "dev-name": "mlx5_core.eth.0",
  "port-index": 65535,
  "health-reporter-name": "tx",
  "health-reporter-burst-period": 500
}'

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml      |  7 +++++
 .../networking/devlink/devlink-health.rst     |  2 +-
 include/uapi/linux/devlink.h                  |  2 ++
 net/devlink/health.c                          | 28 +++++++++++++++++--
 net/devlink/netlink_gen.c                     |  5 ++--
 5 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index bb87111d5e16..3db59c965869 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -853,6 +853,10 @@ attribute-sets:
         type: nest
         multi-attr: true
         nested-attributes: dl-rate-tc-bws
+      -
+        name: health-reporter-burst-period
+        type: u64
+        doc: Time (in msec) for recoveries before starting the grace period.
   -
     name: dl-dev-stats
     subset-of: devlink
@@ -1216,6 +1220,8 @@ attribute-sets:
         name: health-reporter-dump-ts-ns
       -
         name: health-reporter-auto-dump
+      -
+        name: health-reporter-burst-period
 
   -
     name: dl-attr-stats
@@ -1961,6 +1967,7 @@ operations:
             - health-reporter-graceful-period
             - health-reporter-auto-recover
             - health-reporter-auto-dump
+            - health-reporter-burst-period
 
     -
       name: health-reporter-recover
diff --git a/Documentation/networking/devlink/devlink-health.rst b/Documentation/networking/devlink/devlink-health.rst
index e0b8cfed610a..4d10536377ab 100644
--- a/Documentation/networking/devlink/devlink-health.rst
+++ b/Documentation/networking/devlink/devlink-health.rst
@@ -50,7 +50,7 @@ Once an error is reported, devlink health will perform the following actions:
   * Auto recovery attempt is being done. Depends on:
 
     - Auto-recovery configuration
-    - Grace period vs. time passed since last recover
+    - Grace period (and burst period)  vs. time passed since last recover
 
 Devlink formatted message
 =========================
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 9fcb25a0f447..bcad11a787a5 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -636,6 +636,8 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_RATE_TC_BWS,		/* nested */
 
+	DEVLINK_ATTR_HEALTH_REPORTER_BURST_PERIOD,	/* u64 */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/net/devlink/health.c b/net/devlink/health.c
index 94ab77f77add..136a67c36a20 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -116,6 +116,9 @@ __devlink_health_reporter_create(struct devlink *devlink,
 	if (WARN_ON(ops->default_graceful_period && !ops->recover))
 		return ERR_PTR(-EINVAL);
 
+	if (WARN_ON(ops->default_burst_period && !ops->default_graceful_period))
+		return ERR_PTR(-EINVAL);
+
 	reporter = kzalloc(sizeof(*reporter), GFP_KERNEL);
 	if (!reporter)
 		return ERR_PTR(-ENOMEM);
@@ -293,6 +296,10 @@ devlink_nl_health_reporter_fill(struct sk_buff *msg,
 	    devlink_nl_put_u64(msg, DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD,
 			       reporter->graceful_period))
 		goto reporter_nest_cancel;
+	if (reporter->ops->recover &&
+	    devlink_nl_put_u64(msg, DEVLINK_ATTR_HEALTH_REPORTER_BURST_PERIOD,
+			       reporter->burst_period))
+		goto reporter_nest_cancel;
 	if (reporter->ops->recover &&
 	    nla_put_u8(msg, DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER,
 		       reporter->auto_recover))
@@ -458,16 +465,33 @@ int devlink_nl_health_reporter_set_doit(struct sk_buff *skb,
 
 	if (!reporter->ops->recover &&
 	    (info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD] ||
-	     info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER]))
+	     info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER] ||
+	     info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_BURST_PERIOD]))
 		return -EOPNOTSUPP;
 
 	if (!reporter->ops->dump &&
 	    info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_DUMP])
 		return -EOPNOTSUPP;
 
-	if (info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD])
+	if (info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD]) {
 		reporter->graceful_period =
 			nla_get_u64(info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD]);
+		if (!reporter->graceful_period)
+			reporter->burst_period = 0;
+	}
+
+	if (info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_BURST_PERIOD]) {
+		u64 burst_period =
+			nla_get_u64(info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_BURST_PERIOD]);
+
+		if (!reporter->graceful_period && burst_period) {
+			NL_SET_ERR_MSG_MOD(info->extack,
+					   "Cannot set burst period without a grace period.");
+			return -EINVAL;
+		}
+
+		reporter->burst_period = burst_period;
+	}
 
 	if (info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER])
 		reporter->auto_recover =
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index d97c326a9045..9fd00977d59e 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -389,7 +389,7 @@ static const struct nla_policy devlink_health_reporter_get_dump_nl_policy[DEVLIN
 };
 
 /* DEVLINK_CMD_HEALTH_REPORTER_SET - do */
-static const struct nla_policy devlink_health_reporter_set_nl_policy[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_DUMP + 1] = {
+static const struct nla_policy devlink_health_reporter_set_nl_policy[DEVLINK_ATTR_HEALTH_REPORTER_BURST_PERIOD + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
@@ -397,6 +397,7 @@ static const struct nla_policy devlink_health_reporter_set_nl_policy[DEVLINK_ATT
 	[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD] = { .type = NLA_U64, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER] = { .type = NLA_U8, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_DUMP] = { .type = NLA_U8, },
+	[DEVLINK_ATTR_HEALTH_REPORTER_BURST_PERIOD] = { .type = NLA_U64, },
 };
 
 /* DEVLINK_CMD_HEALTH_REPORTER_RECOVER - do */
@@ -1032,7 +1033,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_health_reporter_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_health_reporter_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_HEALTH_REPORTER_AUTO_DUMP,
+		.maxattr	= DEVLINK_ATTR_HEALTH_REPORTER_BURST_PERIOD,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
-- 
2.34.1


