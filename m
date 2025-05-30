Return-Path: <netdev+bounces-194387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C963AC928F
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 17:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65422173E74
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 15:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525E322D9E5;
	Fri, 30 May 2025 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="bhIqo7QZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F64623182E;
	Fri, 30 May 2025 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748619172; cv=fail; b=bekMkkTB1XQLhoSsprLS4Eoztvi6KBLLXHfSl2POhqic1XLvP8RJMj/2haX2oyEpVKt9nLucMvX6HTT6pPTivMSoR3M8+60o4P9WvMnvHdYcKO0+0IxQQC1qFFJEp0j+sFA6uhTh6Ff5ZDVLOZcapR6J7+3i1irneloPxxJITKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748619172; c=relaxed/simple;
	bh=1ZMtpaoGVi0B3LsE1zeazNWFmpFBh4/s7jLs5/fbN4c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WZ7OcikKZRWj+LXft6V52/cxolV28yU5hffzYJOJlBSC+skNy+U9oPe3TG95Ls9aWJI7TB5tsZMlDqrY3DGDP2oiM3QISFsnjK6G2gqIwXRmaY/qTxzNHqXKxFmxWNEb0SNj+adklLHQrTEE5mIruxHxMzlITucoGK4weeQFVsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=bhIqo7QZ; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFELXhPLB7JDB2L4ikgn4aNDxbQT/cbEHvvS97MjZJREqGKsBVdgwgKj/ikf8P5rAQHDWHyWPI9l4NJ4xbWeb7gR5bO9c2u3BmiN2xIAVTY2vcuFQnQKxfb6p1ACfU1z+it4jDtDyG2/HXlBmNdkTJQBWOW+kJ5kGK/KnRryA+b9V4KJ2MNvv01FXcHIBsImjrT7ZQbEKDXJR6Au+Q68yrThp0XthFBHxQrwZ4mIkG6VazuTOQB7L3zQkxFHkOvheRzL65tKo431i10OV7oTV50n0fZl1TO+CnuXzx2QBn2Vabb7iEE3QEc/WtqplcBN+mbIpPZYN+Zn8zO/MnRSbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRcaumTjv7pyTCE7O1y8g+p3ac/vuGWzQY05TZ1gpYI=;
 b=ZWollFdssvxmCc9gRe7MmSQAoX/4YZGAN5UHxlRg7u5mYpx35iZYzUFCR9TxxGn4w65lWBErhIIkoiZ3WdLSWflJ8YRqlDS7q7noaEUFr2n7InGjkoYUwpA8xY9AQ7oc/irMlu2QjYglrRIlhDBKaGpuGvzkSYl00cC07JhTvs8QbqPN6i+ngWRwj8pjw4lZFQPA529E0auTX2CRhqAUwUzsFycCuTi/CJPmOprgPTVcpAF5GXT2pZ+CUZqpDn3+otS8aN3R+S0qhrgSLgFDCsnL5atG6x0O3JJSX3lxLnQS9CNZGk6d8/fRpK+3Vwr5nVFNSD+Wphea04WYcRQCzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRcaumTjv7pyTCE7O1y8g+p3ac/vuGWzQY05TZ1gpYI=;
 b=bhIqo7QZd0FTae0F3bgA2snMad3YntOXGRZevfzcbheXrvFh204w4zEM+gwdwwtpdIWghISBXQBZjI7q6l+VyrijaZkX9wphS4xIigoVuPBplM7IqUG+qKBatMZcSoEiK4uEN7QKEhta+4PjHXUK9r1lfJh+hnAZyxEXiYSyamB9atgk4Hzqzyc4TmzWyw+s+ETOSnEsKvI9wT0cn1dcDlKNH7fpPWyNpDvJKRlkffRPG5nT0ax0wZqJJSOCSIViAwMMJ27zcW7hySLYfiuDmsAw75+2quq4hcE/t4EQC9QZNgZEVOxoO8ceOzfq1NcScesGSGKf50HNrTWwhEaVOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by DM4PR03MB6126.namprd03.prod.outlook.com (2603:10b6:5:395::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Fri, 30 May
 2025 15:32:48 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%4]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 15:32:48 +0000
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
	richardcochran@gmail.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mun Yew Tham <mun.yew.tham@altera.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH v3] dt-bindings: net: Convert socfpga-dwmac bindings to yaml
Date: Fri, 30 May 2025 08:32:41 -0700
Message-Id: <20250530153241.8737-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::24) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|DM4PR03MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f5b49f2-7752-4922-ec19-08dd9f8f3b12
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eb5E1p8WbJtFcu0uPPpwUdTnZNI2CO3yLaF2If2pTzK9YyziF7VcgWrWgr9o?=
 =?us-ascii?Q?e3L2HFBTooGvqBbEvUm6aMQbMzMDCwjAJlKYVcxeT0tMWZuu7G2BJNdYaqS8?=
 =?us-ascii?Q?Cbi7IbGT1o7ENz5fpswDrhj2CcbOmDZKJhagWS8XS0uHt1eh6y4Nn/rBninD?=
 =?us-ascii?Q?rABnsFgJXUd7PUS2/eGTYZpsX7aPsGD+YAzBvfAP2EICJ0/MdufoatKNo4/1?=
 =?us-ascii?Q?1yl/CIoeIA/qEZ697hvApQqzWRQ7PiL2EhL1Y+lrNr1RM+wm6QSF729XjKlw?=
 =?us-ascii?Q?+K3Ln1gpISIk67mT2uheFUmG0B12agx6mhlRrkFEj1RE5mgyY52JxcCOmqQQ?=
 =?us-ascii?Q?dz8Ul3jhpNu1Jm5Vqz9M5bnqfQeiz7Eo6VpqHOBxtWPBmM4WzOwbqfXCf8H6?=
 =?us-ascii?Q?gqxP4aXGf5iJ6za4Dd10uhd1KNpACru2pAkmKBHx+4RE3qbJvFu8dT0waHmH?=
 =?us-ascii?Q?j5dPlEHqljDj72Gf/ysJYiH21ibkkhfUU7nyDzjHov4NK10oe910m2u8UAOF?=
 =?us-ascii?Q?TpfhSOwfav/GM580bGSJM2Gc6pof9G8SxITXTzG4FHkzUh8xNOHRPVVszdcN?=
 =?us-ascii?Q?aONvkn6KYRnM3qjOmOyLNqMOiNQB4I2ibWpB/YcK80IoS6Ehnhr8b3J1axor?=
 =?us-ascii?Q?N1bFhJysxNBR6uuV9Ps/vg23/MLhXDhnCpPfnCS+58OcV86XheWJF8ADPZgv?=
 =?us-ascii?Q?EfqWbpa4tvWKMwJB1vd/swbPTxxBvimA8HF10Ea3XPwdfkf4SAaif0TZZD6r?=
 =?us-ascii?Q?6OrBs2AYiTaAYwJejig2QEZMU+hMk/rV5hFERvipmcFwuFBkHDK9+Xdpbh3T?=
 =?us-ascii?Q?N8c++8v6nwYqrSYSGJ6SFXe30WlPqjNaULjmhmlNjYUeu20vSB03cSHfDXUm?=
 =?us-ascii?Q?gSUZrfJtLZEDQhNImEnNpV0ZnaEFU/bgQvKsxWNKYpiyBKe0RKQg5lTKlqsi?=
 =?us-ascii?Q?leoQ4K8BSpgLMRgSKtO53tdnUjNNy+v2gDCydoj6nby5Elw9CCNba2kgrfjF?=
 =?us-ascii?Q?c/oaneCbjZh96ZYfKsUQd/ue6lOyCui97AmaYdIDNH7Tppwaw7sPPCH7eizz?=
 =?us-ascii?Q?6QUFU8FCiPBcU7nGuZ/99idVdaNG3+iqg2QmAL4mQInqX6M+fo82Xk7OaahX?=
 =?us-ascii?Q?TE/U4o68WSwzSQn66Wq2WhlrfuxuYR8nG5mZZXj5KFsOGivIYKiyksjYE9IP?=
 =?us-ascii?Q?12dNikq9eY+lx7b0mVpZvJQiwpKU1fT0bR/JuBmmcwpC8tyf35QOZCIAu5dP?=
 =?us-ascii?Q?2yohZU45HO5iRSaOPxdZBE+u//asx2Bc+4tVgcJbB9EwJsL9FynvjLnAQ4MN?=
 =?us-ascii?Q?kGMXXNvtQ8xLAcXijNX6Kr11AfDiskBFevagOQgc0Iyly2A+lkGYBVzQzKq8?=
 =?us-ascii?Q?g9li1zdRzTOTbpgcz16fasuc2ElUzszDG5d39+KsM2NLjCUIVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UfyHe2KClBA6GvRWyBfw3t0vafeGjkfANqYk65mmBUCknJRjIrFdZXxVzHwi?=
 =?us-ascii?Q?MzZYwVzUBYgHW0MG1Lc/4KaocDcY8k45qYhZfsYMINzGaphf7zheW+Spdq/a?=
 =?us-ascii?Q?nKHsD82lkOQ2AqM8AP15tIe0yKWEfKRjJCoXsmaFDjlF2vBlPFoB8UFrFQU3?=
 =?us-ascii?Q?en3vjIzagg+LkftTdWnPTu516lmE7F7xIM6hxz5ZFzZjNe5m45aF4Qzw3NaX?=
 =?us-ascii?Q?gfq9+LRkGBtHezSkZIDIO+xSffxjER/YNMdpR6st4J1YKfKniaxdyMQCPoNo?=
 =?us-ascii?Q?E65eYRIiITwDEaBacFEEeuoQeogU987Mx7veYuLyySNpMbHm3cZlk2fvY8O2?=
 =?us-ascii?Q?YUGrmaV367Rh2W5jfNqzUWVo6f+4m7dkLjeuiZN+qyOxTGTvrPGshDVqjgJH?=
 =?us-ascii?Q?gUfMgA2LdRK6oY11HiuzqhMC2yDCApBDegSPDj8Lp9IyDcVO+IY4o/ZE2I2b?=
 =?us-ascii?Q?Qi7iJ9yI0q/kKSOuDoeZZ99Nj0Mem2w9O0zpPpaAPVNnuLm3sKr09HqjKbrd?=
 =?us-ascii?Q?Mg0acLaQy5z0SlbSnVZKPwX1pemKnTfzxv/lImHiJh+wjMCSpP6QAyA2aElH?=
 =?us-ascii?Q?wVzSFJJ5k7eJBLTbmTEZS4/p0SXeo/LqQXk26/yTSeuCvIvPvJXGmVzHF3lt?=
 =?us-ascii?Q?TVLnPvlJ8WY3+D9qDa/OcZ+yRaLlBmRBQXkJcRIsfcTpM7qJBxGrCj6o65rw?=
 =?us-ascii?Q?g3si24t1CDGU1oaZB1nCJMa2O1UjR4gHnJHZnjP/CBNSu4X0B9DwKcsN+2hX?=
 =?us-ascii?Q?WzeQRs/FRihe79joMnkXZwJg2R3Qpa4JKIJh5UD/L2BqS9uGlwHZxLIE1KY/?=
 =?us-ascii?Q?C5G5jwmI1bgjKUSWvdq4KuzX44X1KVw3wAJmuIPWjsYjphAbpjwub/bU9//U?=
 =?us-ascii?Q?dGVtcSji6V3kPIUxPHa7I92pobP6Rr1YarannK2tPTI2ZNabuwbjijEXNVHh?=
 =?us-ascii?Q?6IA6P5dgR3d5QovT5HJn3CnucYLH18GBv/1Ws5ZI8RRVdvaBjtoPs5eFHhhE?=
 =?us-ascii?Q?LdmUtRrgK1vh1IKkE0zXrvtTrd4TOd28LkTNBBUZz7kmswirJCjaVQcUNNKI?=
 =?us-ascii?Q?QKhlT4ilkqaC7gNkiNKavF+efEFzi4rkcxLAbzwOPoRuGc1hMhGD7y7sCX73?=
 =?us-ascii?Q?65ETsHNfHwEpo6lmzGoWtdUxUA3ENFMg229ht9DgmzNjgRngRAdaAdyxTBYZ?=
 =?us-ascii?Q?cGqq8lNIZbH3GdANWSWZJPzL7QnRfKM4aUNahl/6/dW/gvGRc1V0NR9P++Mb?=
 =?us-ascii?Q?fruPOYxbkJ0FF3Pz/N8n5NmFPXRkm9ZBU5IPIHTbWYl2CNI3EdakYQLlB2SB?=
 =?us-ascii?Q?B6VGUf7CuEZM47PnvEv3rwIrrJo0QSlwwSTyzJ2sAjJqdPj4PFIaNTTcAazY?=
 =?us-ascii?Q?Kl293QaXhUd0bkDCICkzf7hx5k4uwWCnpjaeALyhKreRIU6xpkHGkOptfxhc?=
 =?us-ascii?Q?GBayfmsRne1cE+Ep2xC1ECMsyUXD1hwcB9n5oXOndFG+jyzefSDootqvJaYt?=
 =?us-ascii?Q?VflZvI5JigXxU114fKOgVWw0zxsNo38UacPmvq0CE89tu262BNXipTaFuNz2?=
 =?us-ascii?Q?QWgZ9FQRshvBAtQX3sKq/28XSPXF00WQGMIGS+HOkILkat4uswvd3qbAXcsG?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5b49f2-7752-4922-ec19-08dd9f8f3b12
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 15:32:48.1243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibjwhgo8gRcPYxxBDu1FCPvS03c0dbN1hKI0zwWO6he/jdwMxJTl2vZM40SfshZXgVSFekxs2n2L5/Zuqye8BqHPWKcbBFgWz1IaljfnjAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6126

From: Mun Yew Tham <mun.yew.tham@altera.com>

Convert the bindings for socfpga-dwmac to yaml.

Signed-off-by: Mun Yew Tham <mun.yew.tham@altera.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
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
 .../bindings/net/socfpga,dwmac.yaml           | 153 ++++++++++++++++++
 .../devicetree/bindings/net/socfpga-dwmac.txt |  57 -------
 2 files changed, 153 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/socfpga-dwmac.txt

diff --git a/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml b/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
new file mode 100644
index 000000000000..29dad0b58e1a
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
@@ -0,0 +1,153 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/socfpga,dwmac.yaml#
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
+      oneOf:
+        - items:
+            - const: altr,socfpga-stmmac
+            - const: snps,dwmac-3.70a
+            - const: snps,dwmac
+        - items:
+            - const: altr,socfpga-stmmac-a10-s10
+            - const: snps,dwmac-3.74a
+            - const: snps,dwmac
+
+  required:
+    - compatible
+    - altr,sysmgr-syscon
+
+properties:
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
+    maxItems: 2
+    contains:
+      enum:
+        - stmmaceth
+        - ptp_ref
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
-- 
2.35.3


