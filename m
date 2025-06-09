Return-Path: <netdev+bounces-195797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED402AD2439
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 18:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D3663A6236
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 16:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7376621ABB9;
	Mon,  9 Jun 2025 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="soCAw42q"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11013046.outbound.protection.outlook.com [52.101.44.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DA03A1B6;
	Mon,  9 Jun 2025 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749487054; cv=fail; b=XmWy1nOcOI2ERMwKooXfE8T7Il6PIYxiCayOzv0hNk6bKNkRzLfM5Y+AGTCe3y5AQ8KA2C3ledOGABlx6U+Uvdu+0CAQVW9qoO4bkc97s6fswZVi1+CKZSS/DxSXe0r0nYPeKgxy7bXUdwRFtMLVfcvakIn7al+N1HDkRxMM5Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749487054; c=relaxed/simple;
	bh=V3379ECHImEBF+Z89i5WmkQ/g5K4BOAch3RuNEj7VyM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bq7NZIuYchGfKGmg7iE8fFJzKyG6vOjwUdLcOy/l4npxUN91Ct/bMApwkb5472AL5F5N5n4Sgp4+mBfkhqil45+QUk3u6UQTDqDZZmZFRbPFJgmgPZnM/LGCfoifPG0HVm9GigVQob2GLIM64YAe1BBXcmvMQ9/2ph5tEfqs/bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=soCAw42q; arc=fail smtp.client-ip=52.101.44.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxxF/VOQ2YBgvdLK9zxlLWyNO53MR+sT62ln8r25tpcbXGLc0lB/pVPj3fVGbSYYCr84moQmaUbghP5waZ2iIJVBh/9VncEbhhQrCCHV+T3jJcD5/luC1KDR/ifrA4f5Yzs+dEz+7rF+t3bSa8ZDExyYJapTyApqVcW14hy5ICNi+JAngi17ya03a9Vq2PF+y59TvhEkSYVe6NVgOzJVcpfl9HDikgjeQGGkitQ/GmWKT3Vqi5loKc87+GGRxY7T6bcAfpFmYHqxYs6Bog4G5XqO+Pg/XURXdm1hFPLJBtVWl2xRUlzgeoZyg80OlMGu25b5lfNGEKNbZQ2HvBddEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMVwXlLTFzz/yyWT6E9gSfnwOwJy222wgUaqz/Ze3X4=;
 b=JqXovzXBpV1KbB78f9tDPPplxQccl87y7hTH6cZToKPkO7iLOzkk6WGLTeD3H4HdK5P5fTi4Qf48aI3W+J6dgG1uGkVsFAk9Wc19Uq6R4EhYnvFTdUaQ41XeUSw5182cbHVllAY5Mil84b7zjfU4cjRKiaLRLkKocmIzCzC4esBHcMZwx16mzHA12C2oybRb45UpCNLzN9ix/KrbR3K5hoXQYuPj0xPrKFb/hpjqYnpRZxR+j3JnreGnnbLYdlPmpypNMBXB0x4yXm33967iCyIEuvFUMuorqLtyjbTlGRfCOg4Ix251bzTAiAzUpeO1XmKfkn83FzdqSHauDdEC+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMVwXlLTFzz/yyWT6E9gSfnwOwJy222wgUaqz/Ze3X4=;
 b=soCAw42q2pTv/14Qf4glBJbRFhzWEOsLNvNnHKxi7n3+DKtd9O5Kx8qypxM7qFhB5zgct3YH/TTUIWsUETgWTvcAZRp5zMUdSmEXr0gobzmL7+gztPVfqSgxBdrve8IJBHoS0CPip8gmzsU9txArdwACBzZxaSsgi54rY/nPF/W5s4MPu4zAKQLhkCn5XJClTro3dKZkuUq/PqzVMYx/obpGit76ArIFEDY86UrhBAvzlXcEaNOAqMbgP0yYo5oXwFCrUnOeWd7fO4eI0wVyCGhGsmv7dNUSQpqwqBpo/L27VzEWJ6j2i7q5jm2dHqlVK4dY7HNqyOrYgJjeWBGPBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by SA1PR03MB7147.namprd03.prod.outlook.com (2603:10b6:806:336::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 16:37:29 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%5]) with mapi id 15.20.8792.040; Mon, 9 Jun 2025
 16:37:29 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	richardcochran@gmail.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>,
	Mun Yew Tham <mun.yew.tham@altera.com>
Subject: [PATCH v4] dt-bindings: net: Convert socfpga-dwmac bindings to yaml
Date: Mon,  9 Jun 2025 09:37:25 -0700
Message-Id: <20250609163725.6075-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:a03:255::17) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|SA1PR03MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c1a8f7-88a8-4cad-f774-08dda773ecd2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4dCk/gUdQadO5sGqxH7OifsIg8vnylwr5AJXIm2t5vmC0koAvcWQEKKPzdjd?=
 =?us-ascii?Q?+SL0RtQCSwS+SiU0Oqu5W8JV36a3UNEz5un4R6UwLtfxN+5aCfpEtdICHvAZ?=
 =?us-ascii?Q?DlSXcNaJirfq/EuQTggvFMZBJQsJ5pt9kH57T+2ZLoRua8gCK1ytIU1tpI4Q?=
 =?us-ascii?Q?UmgCKU99LJF69JzDF9TgmZfMiqyQ5RCbqRhzOcWnahuRBxzPho2hIsXPEGhR?=
 =?us-ascii?Q?hqZ/bhy8xdmfGCR/84/TGCYGlcmgMOIgA5igvYeteFYSPkNneARyb6gE8HME?=
 =?us-ascii?Q?tx/Iw7S8vgLV4r6hLFWlKsFRQIDE1cd1dBZvztVBUWhPWuYCgy1JzJn20mlR?=
 =?us-ascii?Q?5iC+kuZEBeiQxyeosrGFHZtdbUezkbNR8w6OJ115kaMuYQbxnNivfSFsBQND?=
 =?us-ascii?Q?1foICWC75CSa8Kxt7Mj7bXwXSUKO2CYCaZets8cyezi4nM9VdawLHLYjU/xI?=
 =?us-ascii?Q?3QlxKb9gMBAitCIEpibzOsxZIhHh7BGmhCRR85nE4Y6jn0GjpRdFMqR1XP1H?=
 =?us-ascii?Q?8I9FJL/ZHnhaazcMJ7Q38HQL9hDI+gj5EYdbKWXCSwRTDYLxFCR0UZhU9i06?=
 =?us-ascii?Q?gqzT8uVWqlv/ZxSagQaPOm0zlWIywvetIX8daU8pLw1N6XO0EghVWbh+YUBI?=
 =?us-ascii?Q?rbflvZxo4IAbQyDZaK5koS/al9LE9t8v1+RL8lh6vGv/IDw1L9MSGOz6sXWw?=
 =?us-ascii?Q?fJt4GRFxLnZZs+m3Y2Nvr9MLDFJoawRCyuo8RWj+ROLeGcvVKAzAf9JZKiMb?=
 =?us-ascii?Q?OCVnPD4LvinZKigfz4kORprOCe7D/m1l41lAccKQWdQTHPIFfYacPFpOa+Gp?=
 =?us-ascii?Q?UfmeU0ZLBYKP12hmNXikVk6yb+rHi4iRnqMyM66BgOW6L58PJr1CqDuWL3Av?=
 =?us-ascii?Q?jHSmPlMWuCB9NKAqf5uAr4sVTNGmtbxbigdRCAGjeM2CMZ53blq19hHwfqUB?=
 =?us-ascii?Q?mVJOOn0VOYtXOEuvmLIQo0PnOlvThtGN+na5mgCjSxaMpzZY4ETyK12hLQ/U?=
 =?us-ascii?Q?RiIjb5BqMAe6O7BQUwfGsX7rqAGpOIMwI5fZkve1qXl71OMHodbIj1oTXKVl?=
 =?us-ascii?Q?MlRrEHa/4vhyQP/u8eqhB5fC7iFlhx/SUuHandYyfDt3QY4OFSAj6eIx0WHB?=
 =?us-ascii?Q?p3vJsH9TY6GZt+4PHNrjkdGfi47hM9bLPACzyDOZlAO8RlV+4uLu8njAwQkE?=
 =?us-ascii?Q?SagN1mkQIautUFlb9wzPQFIk+njbRATREOhZcbqHg5NGC9AWhCPDEBj57wgV?=
 =?us-ascii?Q?AgFho7NlyWUPgfcR3jjaviScQSQhRniHpbZNE8so1MHbCNrv/Za8tnbrmjk4?=
 =?us-ascii?Q?yj2AFqRXn4hppqu1AUSYMXEELnO4fStfFe1XeHPseVAcMxJRBBjoQAXvHDkR?=
 =?us-ascii?Q?6To0m1j4W693dJpYW9g+Eko/xq7k0U3+uMXQpb8xEVKJ6P4EYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D+xynXg/D9aLfNSOWNfizXQtfTS6t1mLIaGOwnm0TbnSJfMBrC9ZiKaz95ze?=
 =?us-ascii?Q?Ln0oEtA/tBs+YHwQQLN5pun3yQ7Fxwu0LE0LYCDbVy88wAGUxaks8JT1GFg0?=
 =?us-ascii?Q?fuX5nwmJeRQzmgCYaguePiZNekT8WUAZ5LAK6ZWEKy0VWomBLlQ1lsKw52lW?=
 =?us-ascii?Q?h5gXkPQRxjYhN8qiMk1T0Y5e42r0I3D9TjmyYXxdmEPXfx1GslhQjNVU9Da6?=
 =?us-ascii?Q?vhTEhAz0QeY8KZlUKQgdLTiWuuW3NcNmSv5x1Cm0lfEIlS13LacbnpUMTTwC?=
 =?us-ascii?Q?JUDnwiNy9Y/XD4poDjr6VKh/tmWHz2C3lFYL7yW/JWnyVczPcELL95hOZ2ka?=
 =?us-ascii?Q?Kt0SkKWWoY1Rbwn2TGXLoJ3HBa0qkRMMXTaYFoEcGow3DVt5fdFtdBmRfiqc?=
 =?us-ascii?Q?ok93esHRXF7k1KEegcEIHd0oX53q/p9NmAPFODmlklFVdnsGiB7qy6HJ3U2V?=
 =?us-ascii?Q?70TLNZctmXJSO6AXhmlTH/i0cVHfPV2yZIkgDjsK2lm9GN8zyJN2/uKXAlmd?=
 =?us-ascii?Q?TAIJ3DgS5+PcwWlSYwfBYDNyf16l3TvzdLME5C8oEta/8bksNl7H5gLHvZxG?=
 =?us-ascii?Q?vXAtQWC+L4Vb4J26ZNVEidPanaHyzQkygyy70PG5m8J3njaVwkxU+Ln13Wrn?=
 =?us-ascii?Q?5qO8V6r5kNcopGL0CI6kpgTa2imqxeAJ2ndLf9jiUmlSxFYsgi2b0wbXz1Wn?=
 =?us-ascii?Q?PmfPBE7nFJH5aJpSKOOvwlX2g6x463ViIEaiyIdy21NchI4b0T4fdMj4bskB?=
 =?us-ascii?Q?Hk7Qx3RIBL7U4yGUwwwI1sYbcq+gN7zoRe/imnXpMG2QsmRt6NpZiMgIaBAB?=
 =?us-ascii?Q?d2shXADnxh64BYMU9DFLXmqh5LIotgMMbTRx+VyLUhXhU4NG/N0rlW8CEKKE?=
 =?us-ascii?Q?9+2bFY/uone+w31xaPOEhr6iL6Oonw+VIcArmHMLgsNFdMcQJmIdio+3QpO7?=
 =?us-ascii?Q?jWHF63EFeBZZVaQIyvHJDpeohfrkYi+UsNIehL+8iM5BQaZu2Iwcb67M7AVZ?=
 =?us-ascii?Q?fk8KDHlDlm99+VMDfMpqt3uE/9Gvu8rbAjAgdcOhhfnceLAAA+FumxSLs/3X?=
 =?us-ascii?Q?mdd5n2GXWDQBkJp4PZej5Yz6hwNpYJas24+fGW+EJUkyfXl5gRcUwAYl1tpR?=
 =?us-ascii?Q?NnjSNTNO8CANseplRTm1PcTG7GpCT1hqxG8TCe48vksSmZn+5BFVMw7B/LfB?=
 =?us-ascii?Q?9Ug+5d/lO9uPFNEd5iXzhYv/yxdSEg1HnQUnYEyZT6+wdyqo1/luAD1v5EuI?=
 =?us-ascii?Q?ojRmoVbniAJ0yszGb+S/jRHYUZDJAMIvqGm9bExwOUwJcDYwRMD13Q2HDZ8v?=
 =?us-ascii?Q?dqrmxZskV6B0L7BD3J9WqwhggS7dMViCLEuFs8Y0SVRKkbyZPpOq2yvHxphG?=
 =?us-ascii?Q?seAOFE0LjsCAGjYWwabL3Jo7UxIRHanx9EWDxOPZGUDD5Rh8bmhz/EtR7fMA?=
 =?us-ascii?Q?MalmX2h2Zjfk0aNCWeugTAT1a0SMLUaUeDQivP++D1cNktst4ArMXa2+wAvt?=
 =?us-ascii?Q?gin1//3XascmQl2WcPQGcBWvqP2sG3W2JZQxCRPHKY9Iyfu2Ng13WjsdN65M?=
 =?us-ascii?Q?Q4FM9cf1vKfuyzONCfvuWQ/h0UtSgJNmMkVJoLM3WUuiFSx7jTRdRY3v0TFl?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c1a8f7-88a8-4cad-f774-08dda773ecd2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:37:29.4890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQ0FhNVaJUar8/KE2lerxQuYw5a1xHFUouQMo4MpRLZ7K7QDbSgH2mqs5NCVvfP0UknmGMHNtx1dk3KriLoWCGe4sVaNYj4xgl0OFsIel2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7147

Convert the bindings for socfpga-dwmac to yaml. Since the original
text contained descriptions for two separate nodes, two separate
yaml files were created.

Signed-off-by: Mun Yew Tham <mun.yew.tham@altera.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
v4:
 - Change filename from socfpga,dwmac.yaml to altr,socfpga-stmmac.yaml.
 - Updated compatible in select properties and main properties.
 - Fixed clocks so stmmaceth clock is required.
 - Added binding for altr,gmii-to-sgmii.
 - Update MAINTAINERS.

v3:
 - Add missing supported phy-modes.

v2:
 - Add compatible to required.
 - Add descriptions for clocks.
 - Add clock-names.
 - Clean up items: in altr,sysmgr-syscon.
 - Change "additionalProperties: true" to "unevaluatedProperties: false".
 - Add properties needed for "unevaluatedProperties: false".
 - Fix indentation in examples.
 - Drop gmac0: label in examples.
 - Exclude support for Arria10 that is not validating.
---
 .../bindings/net/altr,gmii-to-sgmii.yaml      |  49 ++++++
 .../bindings/net/altr,socfpga-stmmac.yaml     | 162 ++++++++++++++++++
 .../devicetree/bindings/net/socfpga-dwmac.txt |  57 ------
 MAINTAINERS                                   |   7 +-
 4 files changed, 217 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/altr,gmii-to-sgmii.yaml
 create mode 100644 Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/socfpga-dwmac.txt

diff --git a/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii.yaml b/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii.yaml
new file mode 100644
index 000000000000..c0f61af3bde4
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+# Copyright (C) 2025 Altera Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/altr,gmii-to-sgmii.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera GMII to SGMII Converter
+
+maintainers:
+  - Matthew Gerlach <matthew.gerlach@altera.com>
+
+description:
+  This binding describes the Altera GMII to SGMII converter.
+
+properties:
+  comptatible:
+    const: altr,gmii-to-sgmii-2.0
+
+  reg:
+    items:
+      - description: Registers for the emac splitter IP
+      - description: Registers for the GMII to SGMII converter.
+      - description: Registers for TSE control.
+
+  reg-names:
+    items:
+      - const: hps_emac_interface_splitter_avalon_slave
+      - const: gmii_to_sgmii_adapter_avalon_slave
+      - const: eth_tse_control_port
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    phy@ff000240 {
+        compatible = "altr,gmii-to-sgmii-2.0";
+        reg = <0xff000240 0x00000008>,
+              <0xff000200 0x00000040>,
+              <0xff000250 0x00000008>;
+        reg-names = "hps_emac_interface_splitter_avalon_slave",
+                    "gmii_to_sgmii_adapter_avalon_slave",
+                    "eth_tse_control_port";
+    };
diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
new file mode 100644
index 000000000000..ccbbdb870755
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
@@ -0,0 +1,162 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/altr,socfpga-stmmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera SOCFPGA SoC DWMAC controller
+
+maintainers:
+  - Matthew Gerlach <matthew.gerlach@altera.com>
+
+description:
+  This binding describes the Altera SOCFPGA SoC implementation of the
+  Synopsys DWMAC for the Cyclone5, Arria5, Stratix10, and Agilex7 families
+  of chips.
+  # TODO: Determine how to handle the Arria10 reset-name, stmmaceth-ocp, that
+  # does not validate against net/snps,dwmac.yaml.
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - altr,socfpga-stmmac
+          - altr,socfpga-stmmac-a10-s10
+
+  required:
+    - compatible
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: altr,socfpga-stmmac
+          - const: snps,dwmac-3.70a
+          - const: snps,dwmac
+      - items:
+          - const: altr,socfpga-stmmac-a10-s10
+          - const: snps,dwmac-3.74a
+          - const: snps,dwmac
+
+  clocks:
+    minItems: 1
+    items:
+      - description: GMAC main clock
+      - description:
+          PTP reference clock. This clock is used for programming the
+          Timestamp Addend Register. If not passed then the system
+          clock will be used and this is fine on some platforms.
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: stmmaceth
+      - const: ptp_ref
+
+  iommus:
+    maxItems: 1
+
+  phy-mode:
+    enum:
+      - gmii
+      - mii
+      - rgmii
+      - rgmii-id
+      - rgmii-rxid
+      - rgmii-txid
+      - sgmii
+      - 1000base-x
+
+  rxc-skew-ps:
+    description: Skew control of RXC pad
+
+  rxd0-skew-ps:
+    description: Skew control of RX data 0 pad
+
+  rxd1-skew-ps:
+    description: Skew control of RX data 1 pad
+
+  rxd2-skew-ps:
+    description: Skew control of RX data 2 pad
+
+  rxd3-skew-ps:
+    description: Skew control of RX data 3 pad
+
+  rxdv-skew-ps:
+    description: Skew control of RX CTL pad
+
+  txc-skew-ps:
+    description: Skew control of TXC pad
+
+  txen-skew-ps:
+    description: Skew control of TXC pad
+
+  altr,emac-splitter:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Should be the phandle to the emac splitter soft IP node if DWMAC
+      controller is connected an emac splitter.
+
+  altr,f2h_ptp_ref_clk:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to Precision Time Protocol reference clock. This clock is
+      common to gmac instances and defaults to osc1.
+
+  altr,gmii-to-sgmii-converter:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Should be the phandle to the gmii to sgmii converter soft IP.
+
+  altr,sysmgr-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Should be the phandle to the system manager node that encompass
+      the glue register, the register offset, and the register shift.
+      On Cyclone5/Arria5, the register shift represents the PHY mode
+      bits, while on the Arria10/Stratix10/Agilex platforms, the
+      register shift represents bit for each emac to enable/disable
+      signals from the FPGA fabric to the EMAC modules.
+    items:
+      - items:
+          - description: phandle to the system manager node
+          - description: offset of the control register
+          - description: shift within the control register
+
+patternProperties:
+  "^mdio[0-9]$":
+    type: object
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - altr,sysmgr-syscon
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+unevaluatedProperties: false
+
+examples:
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ethernet@ff700000 {
+            compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a",
+            "snps,dwmac";
+            altr,sysmgr-syscon = <&sysmgr 0x60 0>;
+            reg = <0xff700000 0x2000>;
+            interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "macirq";
+            mac-address = [00 00 00 00 00 00]; /* Filled in by U-Boot */
+            clocks = <&emac_0_clk>;
+            clock-names = "stmmaceth";
+            phy-mode = "sgmii";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/socfpga-dwmac.txt b/Documentation/devicetree/bindings/net/socfpga-dwmac.txt
deleted file mode 100644
index 612a8e8abc88..000000000000
--- a/Documentation/devicetree/bindings/net/socfpga-dwmac.txt
+++ /dev/null
@@ -1,57 +0,0 @@
-Altera SOCFPGA SoC DWMAC controller
-
-This is a variant of the dwmac/stmmac driver an inherits all descriptions
-present in Documentation/devicetree/bindings/net/stmmac.txt.
-
-The device node has additional properties:
-
-Required properties:
- - compatible	: For Cyclone5/Arria5 SoCs it should contain
-		  "altr,socfpga-stmmac". For Arria10/Agilex/Stratix10 SoCs
-		  "altr,socfpga-stmmac-a10-s10".
-		  Along with "snps,dwmac" and any applicable more detailed
-		  designware version numbers documented in stmmac.txt
- - altr,sysmgr-syscon : Should be the phandle to the system manager node that
-   encompasses the glue register, the register offset, and the register shift.
-   On Cyclone5/Arria5, the register shift represents the PHY mode bits, while
-   on the Arria10/Stratix10/Agilex platforms, the register shift represents
-   bit for each emac to enable/disable signals from the FPGA fabric to the
-   EMAC modules.
- - altr,f2h_ptp_ref_clk use f2h_ptp_ref_clk instead of default eosc1 clock
-   for ptp ref clk. This affects all emacs as the clock is common.
-
-Optional properties:
-altr,emac-splitter: Should be the phandle to the emac splitter soft IP node if
-		DWMAC controller is connected emac splitter.
-phy-mode: The phy mode the ethernet operates in
-altr,sgmii-to-sgmii-converter: phandle to the TSE SGMII converter
-
-This device node has additional phandle dependency, the sgmii converter:
-
-Required properties:
- - compatible	: Should be altr,gmii-to-sgmii-2.0
- - reg-names	: Should be "eth_tse_control_port"
-
-Example:
-
-gmii_to_sgmii_converter: phy@100000240 {
-	compatible = "altr,gmii-to-sgmii-2.0";
-	reg = <0x00000001 0x00000240 0x00000008>,
-		<0x00000001 0x00000200 0x00000040>;
-	reg-names = "eth_tse_control_port";
-	clocks = <&sgmii_1_clk_0 &emac1 1 &sgmii_clk_125 &sgmii_clk_125>;
-	clock-names = "tse_pcs_ref_clk_clock_connection", "tse_rx_cdr_refclk";
-};
-
-gmac0: ethernet@ff700000 {
-	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a", "snps,dwmac";
-	altr,sysmgr-syscon = <&sysmgr 0x60 0>;
-	reg = <0xff700000 0x2000>;
-	interrupts = <0 115 4>;
-	interrupt-names = "macirq";
-	mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
-	clocks = <&emac_0_clk>;
-	clock-names = "stmmaceth";
-	phy-mode = "sgmii";
-	altr,gmii-to-sgmii-converter = <&gmii_to_sgmii_converter>;
-};
diff --git a/MAINTAINERS b/MAINTAINERS
index ee93363ec2cb..bc24a6186abd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3262,10 +3262,15 @@ M:	Dinh Nguyen <dinguyen@kernel.org>
 S:	Maintained
 F:	drivers/clk/socfpga/
 
+ARM/SOCFPGA DWMAC GLUE LAYER BINDINGS
+M:	Matthew Gerlach <matthew.gerlach@altera.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/altr,gmii-to-sgmii.yaml
+F:	Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
+
 ARM/SOCFPGA DWMAC GLUE LAYER
 M:	Maxime Chevallier <maxime.chevallier@bootlin.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/net/socfpga-dwmac.txt
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
 
 ARM/SOCFPGA EDAC BINDINGS
-- 
2.35.3


