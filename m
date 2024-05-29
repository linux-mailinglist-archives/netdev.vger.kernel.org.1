Return-Path: <netdev+bounces-99097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785368D3BA1
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA56288038
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601671836CF;
	Wed, 29 May 2024 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TV202C3o"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D0D181D1C
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998487; cv=fail; b=K5vPijXHGI0DIZ3nRrlkdnoyKzL3fsO9/5wc+hMXfQ46ECx4cYq1cvtRegsMkuV28aeHuVSIAQkL0zm/+EZ/imx2hxeqHVlzRPze71GnG5XmN6WS0Y0oQ2LhpjdQk1a9yL9xCn1kuUolaImz9Vn00hSBfL9blSppKx9WIn10rFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998487; c=relaxed/simple;
	bh=bZD+gMPqIDYfHu+nlL9ThOqMqZjcR7LvXJ2+rJ9tbVY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V94xdGyAVubw697jYtWbVWAx7JpLg7UsFRuvZy2Lb/+UXI7vYoBexNjnsPtoj5vqWJ/s0ZcPdNBDuZuJwdpGqpous/IoCZsQB3asin35osH+sisCvHE466FU1XkRktcR1pCU2gfGhOAJdD1x7AnP2iEeGKomIbxyAU2P6s5GYes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TV202C3o; arc=fail smtp.client-ip=40.107.96.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUPT8n4RTXW4/pILOcqvt32/5jRoj65D1lXeamZ9bMQPC84lXiE7FlMtJ7WY3YTkafaWKO4x5hhvYSpjMjX2GyuYo/c8JHT79ODbac1y9JRmUdGVQozxbRq5+pPJF0gHxRC6tUTA6MgPjuIkUNfSURbir6d2aQCQDaXKQQJjBtuN4oE7YKpH/dZ6AXAakMy/ZdZHHru9fWe3TSqMK4jDqrhq1Olfkp244PLQQnmZu8F8FQSInOpNNU8dbR1DChynTlcxBpuBDh52AZeu0fXu4Ljsy7NXGOmCFu5A1eV78APnq9RKhLC7XrQ91W8nWzxFuoJW+ALrIOhjydpVQsyhgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlnLHwbMIsF0ob6kDf3LxSXe/1BbTSZwbw5IF/dtRP0=;
 b=jb9014K0gp61e/wOi3ZdTeC1HfExuXgIuoAxDJheCcNNpRbC9+G5KRqqdgB/V+7sPeO5a/7CLyC/ovsjTf+V3phhiNAXlewRJaysQLc2NvHXfUrPkcUPCch3Erubl0U5+yWj9/j2sYVkIpHwRWN66q0xS3pbatnnACnu03/FNRDtzTp/Ljr+SMyXc2jfwUPn65wW9eOBqbWWyloA5gpLeATp1WTM6s15M72sZh3QBKsQLJHwL4FY0GxvbNFZY2+HWktGZTynKXfcpNrjyTdmawK+Vk/71N90Sp3EZtiEludSpL8SdI4AVrdtc08/nMQu41iAaPrxasZJfKhX1/dltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlnLHwbMIsF0ob6kDf3LxSXe/1BbTSZwbw5IF/dtRP0=;
 b=TV202C3o+vDD6gNyMxVtPrKLCZIgac0TJEtivvYWQxbXBSo2/qGrXSxKqpiiPO0xeFGUghEIq633SpipBjqPiKdEE6LYiPJiooQCb3/EH2fjSY+E622Xtie6X8S0kSFZzsIg/5IYfpVbo9JZeDMHkH0KcDNlWx9lm5BJIB33M810BZoERa3pKzz3MBZVbS24ZxizmdNRJNsgjlhCeWJhIcdsIUVBJqN8B5PMDJsB1ZpFDHghOoiamS1xcIvE1ieY/XvtXxr7kVn6r4nljYJ0a3ajKHRqONzJiSm8KYc85o/825dZyg+4Wy8snUA7Ss2jY41b1REDNiGlcnMotSnwLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 16:01:13 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%6]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 16:01:13 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Subject: [PATCH v25 02/20] netlink: add new family to manage ULP_DDP enablement and stats
Date: Wed, 29 May 2024 16:00:35 +0000
Message-Id: <20240529160053.111531-3-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529160053.111531-1-aaptel@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::23) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW3PR12MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f5f930c-9241-4512-afc5-08dc7ff8902d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?18LO30//ZkmjC2KBEz3frnQVlZ6zfAEeIyBXz0BDFDoaEY5HoOBRXe+7Zb7o?=
 =?us-ascii?Q?kbr2K1ayVLisa87MHR4vlx5JG+gmGpy/p5tcxmna7YNLQWwGB1eDCrP5kwPo?=
 =?us-ascii?Q?fvgrjy6l+L38aJaFdc5y9lF6eQpyvpiuOotCAUE3IJJRwfx5NYGa2tSCXPl/?=
 =?us-ascii?Q?sqj04r2QfAPfymbEn2yt3UdfAehV1eFN6uRauiHC5z4N8xRTxd7ddHhtMnFU?=
 =?us-ascii?Q?Or+4PbekjHYt5vYC1BWnSrxKD77RWwntyLWYVPS1QYVL+5tRHdSP799CVZmp?=
 =?us-ascii?Q?7AH+9IzI4DZJXHRnu7rI30IlusIJRaCfIIx93/X9CfA0nUnNh5ZghPJrl64r?=
 =?us-ascii?Q?UtGxqzPwI0dts73a0rROzKOJPPi3kMeVuGEzXXPLdoU8J4YAL9HdolC16o7o?=
 =?us-ascii?Q?rsriyo/xJYQYhq1Hg3ppMgCEPu3O7i0hSIAK6KOSBribg4NM+WUciJvOrZrr?=
 =?us-ascii?Q?Jiz7M3GIN4rYM3ilPSLof0DlLZHBBlsF+VEozEdXajovaMWCd2y3EMgs1qVN?=
 =?us-ascii?Q?/y0RypoeIA4YA42+0KllFNzfEBtlydRKrfoxh5MJoPXQ00WEFYwZCmCkJ1Rw?=
 =?us-ascii?Q?CZX6NlJe8xBRCmQjqaQMtO8vv542DoZgnmsiCRJrvcUSE82z/Hn79uKxLdxb?=
 =?us-ascii?Q?ugG1MmEBH1p0ouRbyZKge2xhZMeIkoGYtm7RbCwPj/AWicKbhrfRz2ziNMRe?=
 =?us-ascii?Q?5yi2qGrSzZCQ2sQ1944oe+ZPPkj0ILU7eDSHRh1NtloOxUr+0whK6gHJURd/?=
 =?us-ascii?Q?eV9BbDX7Tg16a0DLc2hpaBoAuX27YgGwFO4v4ieSLboycB5bUXNVC1An3G3p?=
 =?us-ascii?Q?padsAq8GI6QujPckZLzzE9mGIKTgZ8Fc9YxfQYs/uoHMdC8pmSU3drDQIRxK?=
 =?us-ascii?Q?0SgV8LKyJh3nR776NZUSGVMLnq9BDKLlxzibdy2sK7onPkrumMDHAvN3LXCY?=
 =?us-ascii?Q?AVb8yDjcvl/D9vx32USrg45IEfXkfZwRRdpLhCNXUKDfYlIjdPwU+o3sG8lf?=
 =?us-ascii?Q?c58P5Lc+Gwz8bV6hCIBDBoqjKzHSXM6M+KXG+kv9VXhaqwgpV1ct/fXSd3sk?=
 =?us-ascii?Q?EzYazNnERYaCKsTVQQM9frESXDN1dVtiVAC7olXvVmtztwiy7pbws/mweDz7?=
 =?us-ascii?Q?D0lhb1k1/59tCoVswBwVnGEsCtkQCbF5r5/iih7cJxruYyhpZJom65KpQiNK?=
 =?us-ascii?Q?4OXLBIzD4frY4zJV9ogTR3G0C88S44IcgV4V0E/5m2fLBM0R6k6i9WOvSX72?=
 =?us-ascii?Q?aCpvdmW9Z1jkLoBOtpWaXUl648GxBV7OrNof4J9Sxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3YqImgNylu5P0QjHTUBfdDlHQh4zGHQV8H+nu0Nq4iTGaPAqPHSnrP5ayCsZ?=
 =?us-ascii?Q?pVv5YqbmZh7Px2g/1y1IXTx/581CrXS37otO9GluzKp0x+O3XJWl4yAp5tyg?=
 =?us-ascii?Q?+1qUFU9eMCTsmaxSn0kqWxA66kxWTSmdl+A5DOZ7Heui+ma5kNhzSLbhzIkM?=
 =?us-ascii?Q?8yrtJgIZYY4CSbvMdj37pL8Phj9k3bWrRTfof4PdZ9vlZRH+ZnNt6Wmd0n58?=
 =?us-ascii?Q?j+pUL0oiEIKENoABpBAAB29UmBlmyjMCpDGLjwd7j+hbW/uCqy4q87YoNggF?=
 =?us-ascii?Q?U3CCZZ1IK7Goea+WIijGNBj4u0Q6Aw5cxpP5z9AD856EK7T51cXhVuhjSsRI?=
 =?us-ascii?Q?sWs4lvRa2qcynGJI/H330RPh88/ciEZ12XwCycG8+5JGgKZZCpWEzz3IIShV?=
 =?us-ascii?Q?bZ2dPY265QcVMKL8rD+Mpv0XIdAlqRBdL5Pucc0CJGe5XOllEz/FU3BvhlDP?=
 =?us-ascii?Q?reFMf0B19T0l1wD9vajEQmd4fVwZrPR2fSTuI/+S+NqmsiAWFAH4goR0zsqW?=
 =?us-ascii?Q?FMEsyUdSMW33WiIB3Eyl0V89HjVwkZEwFp6yJaTJVdclqj81Vdbzui996wMv?=
 =?us-ascii?Q?f3FV0NvHoQYzfo3Kpiycio1S1rjyGuoMHMjzGkWmarfTDPABFUXoiWxVPzBR?=
 =?us-ascii?Q?lyBEBUil0cITJa5yiJJmQycMArxUXWuQhcKPtXHuFXy/R4Gz/AD1qAXm7muk?=
 =?us-ascii?Q?SPNkYzbkIQV5PTpNYLDcouYwPJIrYgjKPaJO9tXla+EJAd5NDEbJLz+RHDNA?=
 =?us-ascii?Q?bCoW3VjG/2hMpTze/sxTHKAram2JRf2USUwTTwXlyFPMwFApfAwezdWo0sYf?=
 =?us-ascii?Q?uyewPziOqEmDeOVlzIs4g2jodJUH/1zX8ZmpvWSquzbtW9CjvLFbFy84wrhH?=
 =?us-ascii?Q?gxBL+o2lvDOPc5smFwZa/cBfZzN5yfLCg5WDl6WrP+/66qxBo9A2MBEiv9Ld?=
 =?us-ascii?Q?JTljLK3+/CTAouBtwSQyhukol+EItaELaYIuIOgNdKVW3QI6uAHpch9p+RzH?=
 =?us-ascii?Q?YAhVHdtT8RwTKp5jaTZE3dn7Jq/8MNOsAKTbhr39edRwp5xK/lokc5u/NjyU?=
 =?us-ascii?Q?xFsuSf6pFfhYj9QjVXhPZL6mF038aJLXO1af7NVjkNkCV2XCT4K7JC6gQsFX?=
 =?us-ascii?Q?rbSQJze6z134qHA0fi/vEjFuMJt1ussQnKNPhZT+8HErz5HqGNRL0KroHoYy?=
 =?us-ascii?Q?+hOoMdoNww9yK6yfzd96+VRvecLetnCtS2D35CKWUaJe9IIVH1uGZsot2yEn?=
 =?us-ascii?Q?sATQWILs5kAwDZ4j+cXgywRXUEi7Xs/QOi6CWo2MfOw+uLP97d7aFMAls5mT?=
 =?us-ascii?Q?vXuAb+oTTq7gCqejSv6jRzLZBeMY1a6AuQjdLw1W5DQRnWn2JD3bdcZWZVzI?=
 =?us-ascii?Q?P1o0ygeFhTRlMEviofOYF9K01iKRYIhb1EaTVZJbAGXKO+gl4/WDXK+sQJIw?=
 =?us-ascii?Q?iJ4QP4srOy6jTvk0l/mTTF3ySoTDxqsdbAf8qIh63gaQqBeVOvxApzkThe7M?=
 =?us-ascii?Q?f1HhFYjbiaDQQv4K84d5fJ02ytmHM0BnUFkrnsmvbaYPQ5EvOwzmT77UOfxM?=
 =?us-ascii?Q?Qj8Su7JpiFwURTvQ3sqcPSp6KKZ7CFi7ZxEWy2Xy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5f930c-9241-4512-afc5-08dc7ff8902d
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 16:01:13.0189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qxedvZH2aPqhHYKE6lSasvUNacOGkz+eO2Nvix2ihz/BvoBmd8hsivlNT/KmLgvclSt9bHGW0uArxOnZqG6ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396

Add a new netlink family to get/set ULP DDP capabilities on a network
device and to retrieve statistics.

The messages use the genetlink infrastructure and are specified in a
YAML file which was used to generate some of the files in this commit:

./tools/net/ynl/ynl-gen-c.py --mode kernel \
    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --header \
    -o net/core/ulp_ddp_gen_nl.h
./tools/net/ynl/ynl-gen-c.py --mode kernel \
    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --source \
    -o net/core/ulp_ddp_gen_nl.c
./tools/net/ynl/ynl-gen-c.py --mode uapi \
    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --header \
    > include/uapi/linux/ulp_ddp.h

Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/ulp_ddp.yaml | 172 ++++++++++++
 include/net/ulp_ddp.h                    |   3 +-
 include/uapi/linux/ulp_ddp.h             |  61 ++++
 net/core/Makefile                        |   2 +-
 net/core/ulp_ddp_gen_nl.c                |  75 +++++
 net/core/ulp_ddp_gen_nl.h                |  30 ++
 net/core/ulp_ddp_nl.c                    | 344 +++++++++++++++++++++++
 7 files changed, 685 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/netlink/specs/ulp_ddp.yaml
 create mode 100644 include/uapi/linux/ulp_ddp.h
 create mode 100644 net/core/ulp_ddp_gen_nl.c
 create mode 100644 net/core/ulp_ddp_gen_nl.h
 create mode 100644 net/core/ulp_ddp_nl.c

diff --git a/Documentation/netlink/specs/ulp_ddp.yaml b/Documentation/netlink/specs/ulp_ddp.yaml
new file mode 100644
index 000000000000..27a0b905ec28
--- /dev/null
+++ b/Documentation/netlink/specs/ulp_ddp.yaml
@@ -0,0 +1,172 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+#
+# Author: Aurelien Aptel <aaptel@nvidia.com>
+#
+# Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+#
+
+name: ulp_ddp
+
+protocol: genetlink
+
+doc: Netlink protocol to manage ULP DPP on network devices.
+
+definitions:
+  -
+    type: enum
+    name: cap
+    render-max: true
+    entries:
+      - nvme-tcp
+      - nvme-tcp-ddgst-rx
+
+attribute-sets:
+  -
+    name: stats
+    attributes:
+      -
+        name: ifindex
+        doc: Interface index of the net device.
+        type: u32
+      -
+        name: rx-nvme-tcp-sk-add
+        doc: Sockets successfully configured for NVMeTCP offloading.
+        type: uint
+      -
+        name: rx-nvme-tcp-sk-add-fail
+        doc: Sockets failed to be configured for NVMeTCP offloading.
+        type: uint
+      -
+        name: rx-nvme-tcp-sk-del
+        doc: Sockets with NVMeTCP offloading configuration removed.
+        type: uint
+      -
+        name: rx-nvme-tcp-setup
+        doc: NVMe-TCP IOs successfully configured for Rx Direct Data Placement.
+        type: uint
+      -
+        name: rx-nvme-tcp-setup-fail
+        doc: NVMe-TCP IOs failed to be configured for Rx Direct Data Placement.
+        type: uint
+      -
+        name: rx-nvme-tcp-teardown
+        doc: NVMe-TCP IOs with Rx Direct Data Placement configuration removed.
+        type: uint
+      -
+        name: rx-nvme-tcp-drop
+        doc: Packets failed the NVMeTCP offload validation.
+        type: uint
+      -
+        name: rx-nvme-tcp-resync
+        doc: >
+          NVMe-TCP resync operations were processed due to Rx TCP packets
+          re-ordering.
+        type: uint
+      -
+        name: rx-nvme-tcp-packets
+        doc: TCP packets successfully processed by the NVMeTCP offload.
+        type: uint
+      -
+        name: rx-nvme-tcp-bytes
+        doc: Bytes were successfully processed by the NVMeTCP offload.
+        type: uint
+  -
+    name: caps
+    attributes:
+      -
+        name: ifindex
+        doc: Interface index of the net device.
+        type: u32
+      -
+        name: hw
+        doc: Bitmask of the capabilities supported by the device.
+        type: uint
+        enum: cap
+        enum-as-flags: true
+      -
+        name: active
+        doc: Bitmask of the capabilities currently enabled on the device.
+        type: uint
+        enum: cap
+        enum-as-flags: true
+      -
+        name: wanted
+        doc: >
+          New active bit values of the capabilities we want to set on the
+          device.
+        type: uint
+        enum: cap
+        enum-as-flags: true
+      -
+        name: wanted_mask
+        doc: Bitmask of the meaningful bits in the wanted field.
+        type: uint
+        enum: cap
+        enum-as-flags: true
+
+operations:
+  list:
+    -
+      name: caps-get
+      doc: Get ULP DDP capabilities.
+      attribute-set: caps
+      do:
+        request:
+          attributes:
+            - ifindex
+        reply:
+          attributes:
+            - ifindex
+            - hw
+            - active
+        pre: ulp_ddp_get_netdev
+        post: ulp_ddp_put_netdev
+    -
+      name: stats-get
+      doc: Get ULP DDP stats.
+      attribute-set: stats
+      do:
+        request:
+          attributes:
+            - ifindex
+        reply:
+          attributes:
+            - ifindex
+            - rx-nvme-tcp-sk-add
+            - rx-nvme-tcp-sk-add-fail
+            - rx-nvme-tcp-sk-del
+            - rx-nvme-tcp-setup
+            - rx-nvme-tcp-setup-fail
+            - rx-nvme-tcp-teardown
+            - rx-nvme-tcp-drop
+            - rx-nvme-tcp-resync
+            - rx-nvme-tcp-packets
+            - rx-nvme-tcp-bytes
+        pre: ulp_ddp_get_netdev
+        post: ulp_ddp_put_netdev
+    -
+      name: caps-set
+      doc: Set ULP DDP capabilities.
+      attribute-set: caps
+      do:
+        request:
+          attributes:
+            - ifindex
+            - wanted
+            - wanted_mask
+        reply:
+          attributes:
+            - ifindex
+            - hw
+            - active
+        pre: ulp_ddp_get_netdev
+        post: ulp_ddp_put_netdev
+    -
+      name: caps-set-ntf
+      doc: Notification for change in ULP DDP capabilities.
+      notify: caps-get
+
+mcast-groups:
+  list:
+    -
+      name: mgmt
diff --git a/include/net/ulp_ddp.h b/include/net/ulp_ddp.h
index 9f2d14998cb3..f7538a5d73eb 100644
--- a/include/net/ulp_ddp.h
+++ b/include/net/ulp_ddp.h
@@ -10,6 +10,7 @@
 #include <linux/netdevice.h>
 #include <net/inet_connection_sock.h>
 #include <net/sock.h>
+#include <uapi/linux/ulp_ddp.h>
 
 enum ulp_ddp_type {
 	ULP_DDP_NVME = 1,
@@ -126,7 +127,7 @@ struct ulp_ddp_stats {
 	 */
 };
 
-#define ULP_DDP_CAP_COUNT 1
+#define ULP_DDP_CAP_COUNT (ULP_DDP_CAP_MAX + 1)
 
 struct ulp_ddp_dev_caps {
 	DECLARE_BITMAP(active, ULP_DDP_CAP_COUNT);
diff --git a/include/uapi/linux/ulp_ddp.h b/include/uapi/linux/ulp_ddp.h
new file mode 100644
index 000000000000..dbf6399d3aef
--- /dev/null
+++ b/include/uapi/linux/ulp_ddp.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ulp_ddp.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UAPI_LINUX_ULP_DDP_H
+#define _UAPI_LINUX_ULP_DDP_H
+
+#define ULP_DDP_FAMILY_NAME	"ulp_ddp"
+#define ULP_DDP_FAMILY_VERSION	1
+
+enum ulp_ddp_cap {
+	ULP_DDP_CAP_NVME_TCP,
+	ULP_DDP_CAP_NVME_TCP_DDGST_RX,
+
+	/* private: */
+	__ULP_DDP_CAP_MAX,
+	ULP_DDP_CAP_MAX = (__ULP_DDP_CAP_MAX - 1)
+};
+
+enum {
+	ULP_DDP_A_STATS_IFINDEX = 1,
+	ULP_DDP_A_STATS_RX_NVME_TCP_SK_ADD,
+	ULP_DDP_A_STATS_RX_NVME_TCP_SK_ADD_FAIL,
+	ULP_DDP_A_STATS_RX_NVME_TCP_SK_DEL,
+	ULP_DDP_A_STATS_RX_NVME_TCP_SETUP,
+	ULP_DDP_A_STATS_RX_NVME_TCP_SETUP_FAIL,
+	ULP_DDP_A_STATS_RX_NVME_TCP_TEARDOWN,
+	ULP_DDP_A_STATS_RX_NVME_TCP_DROP,
+	ULP_DDP_A_STATS_RX_NVME_TCP_RESYNC,
+	ULP_DDP_A_STATS_RX_NVME_TCP_PACKETS,
+	ULP_DDP_A_STATS_RX_NVME_TCP_BYTES,
+
+	__ULP_DDP_A_STATS_MAX,
+	ULP_DDP_A_STATS_MAX = (__ULP_DDP_A_STATS_MAX - 1)
+};
+
+enum {
+	ULP_DDP_A_CAPS_IFINDEX = 1,
+	ULP_DDP_A_CAPS_HW,
+	ULP_DDP_A_CAPS_ACTIVE,
+	ULP_DDP_A_CAPS_WANTED,
+	ULP_DDP_A_CAPS_WANTED_MASK,
+
+	__ULP_DDP_A_CAPS_MAX,
+	ULP_DDP_A_CAPS_MAX = (__ULP_DDP_A_CAPS_MAX - 1)
+};
+
+enum {
+	ULP_DDP_CMD_CAPS_GET = 1,
+	ULP_DDP_CMD_STATS_GET,
+	ULP_DDP_CMD_CAPS_SET,
+	ULP_DDP_CMD_CAPS_SET_NTF,
+
+	__ULP_DDP_CMD_MAX,
+	ULP_DDP_CMD_MAX = (__ULP_DDP_CMD_MAX - 1)
+};
+
+#define ULP_DDP_MCGRP_MGMT	"mgmt"
+
+#endif /* _UAPI_LINUX_ULP_DDP_H */
diff --git a/net/core/Makefile b/net/core/Makefile
index 35345684939c..95f3ca522887 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -19,7 +19,7 @@ obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 
 obj-y += net-sysfs.o
 obj-y += hotdata.o
-obj-$(CONFIG_ULP_DDP) += ulp_ddp.o
+obj-$(CONFIG_ULP_DDP) += ulp_ddp.o ulp_ddp_nl.o ulp_ddp_gen_nl.o
 obj-$(CONFIG_PAGE_POOL) += page_pool.o page_pool_user.o
 obj-$(CONFIG_PROC_FS) += net-procfs.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
diff --git a/net/core/ulp_ddp_gen_nl.c b/net/core/ulp_ddp_gen_nl.c
new file mode 100644
index 000000000000..5675193ad8ca
--- /dev/null
+++ b/net/core/ulp_ddp_gen_nl.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ulp_ddp.yaml */
+/* YNL-GEN kernel source */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "ulp_ddp_gen_nl.h"
+
+#include <uapi/linux/ulp_ddp.h>
+
+/* ULP_DDP_CMD_CAPS_GET - do */
+static const struct nla_policy ulp_ddp_caps_get_nl_policy[ULP_DDP_A_CAPS_IFINDEX + 1] = {
+	[ULP_DDP_A_CAPS_IFINDEX] = { .type = NLA_U32, },
+};
+
+/* ULP_DDP_CMD_STATS_GET - do */
+static const struct nla_policy ulp_ddp_stats_get_nl_policy[ULP_DDP_A_STATS_IFINDEX + 1] = {
+	[ULP_DDP_A_STATS_IFINDEX] = { .type = NLA_U32, },
+};
+
+/* ULP_DDP_CMD_CAPS_SET - do */
+static const struct nla_policy ulp_ddp_caps_set_nl_policy[ULP_DDP_A_CAPS_WANTED_MASK + 1] = {
+	[ULP_DDP_A_CAPS_IFINDEX] = { .type = NLA_U32, },
+	[ULP_DDP_A_CAPS_WANTED] = NLA_POLICY_MASK(NLA_UINT, 0x3),
+	[ULP_DDP_A_CAPS_WANTED_MASK] = NLA_POLICY_MASK(NLA_UINT, 0x3),
+};
+
+/* Ops table for ulp_ddp */
+static const struct genl_split_ops ulp_ddp_nl_ops[] = {
+	{
+		.cmd		= ULP_DDP_CMD_CAPS_GET,
+		.pre_doit	= ulp_ddp_get_netdev,
+		.doit		= ulp_ddp_nl_caps_get_doit,
+		.post_doit	= ulp_ddp_put_netdev,
+		.policy		= ulp_ddp_caps_get_nl_policy,
+		.maxattr	= ULP_DDP_A_CAPS_IFINDEX,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= ULP_DDP_CMD_STATS_GET,
+		.pre_doit	= ulp_ddp_get_netdev,
+		.doit		= ulp_ddp_nl_stats_get_doit,
+		.post_doit	= ulp_ddp_put_netdev,
+		.policy		= ulp_ddp_stats_get_nl_policy,
+		.maxattr	= ULP_DDP_A_STATS_IFINDEX,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= ULP_DDP_CMD_CAPS_SET,
+		.pre_doit	= ulp_ddp_get_netdev,
+		.doit		= ulp_ddp_nl_caps_set_doit,
+		.post_doit	= ulp_ddp_put_netdev,
+		.policy		= ulp_ddp_caps_set_nl_policy,
+		.maxattr	= ULP_DDP_A_CAPS_WANTED_MASK,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+};
+
+static const struct genl_multicast_group ulp_ddp_nl_mcgrps[] = {
+	[ULP_DDP_NLGRP_MGMT] = { "mgmt", },
+};
+
+struct genl_family ulp_ddp_nl_family __ro_after_init = {
+	.name		= ULP_DDP_FAMILY_NAME,
+	.version	= ULP_DDP_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= ulp_ddp_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(ulp_ddp_nl_ops),
+	.mcgrps		= ulp_ddp_nl_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(ulp_ddp_nl_mcgrps),
+};
diff --git a/net/core/ulp_ddp_gen_nl.h b/net/core/ulp_ddp_gen_nl.h
new file mode 100644
index 000000000000..368433cfa867
--- /dev/null
+++ b/net/core/ulp_ddp_gen_nl.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ulp_ddp.yaml */
+/* YNL-GEN kernel header */
+
+#ifndef _LINUX_ULP_DDP_GEN_H
+#define _LINUX_ULP_DDP_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/ulp_ddp.h>
+
+int ulp_ddp_get_netdev(const struct genl_split_ops *ops, struct sk_buff *skb,
+		       struct genl_info *info);
+void
+ulp_ddp_put_netdev(const struct genl_split_ops *ops, struct sk_buff *skb,
+		   struct genl_info *info);
+
+int ulp_ddp_nl_caps_get_doit(struct sk_buff *skb, struct genl_info *info);
+int ulp_ddp_nl_stats_get_doit(struct sk_buff *skb, struct genl_info *info);
+int ulp_ddp_nl_caps_set_doit(struct sk_buff *skb, struct genl_info *info);
+
+enum {
+	ULP_DDP_NLGRP_MGMT,
+};
+
+extern struct genl_family ulp_ddp_nl_family;
+
+#endif /* _LINUX_ULP_DDP_GEN_H */
diff --git a/net/core/ulp_ddp_nl.c b/net/core/ulp_ddp_nl.c
new file mode 100644
index 000000000000..04feefce23c2
--- /dev/null
+++ b/net/core/ulp_ddp_nl.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ulp_ddp_nl.c
+ *    Author: Aurelien Aptel <aaptel@nvidia.com>
+ *    Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+#include <net/ulp_ddp.h>
+#include "ulp_ddp_gen_nl.h"
+
+#define ULP_DDP_STATS_CNT (sizeof(struct ulp_ddp_stats) / sizeof(u64))
+
+struct ulp_ddp_reply_context {
+	struct net_device *dev;
+	netdevice_tracker tracker;
+	struct ulp_ddp_dev_caps caps;
+	struct ulp_ddp_stats stats;
+};
+
+static size_t ulp_ddp_reply_size(int cmd)
+{
+	size_t len = 0;
+
+	BUILD_BUG_ON(ULP_DDP_CAP_COUNT > 64);
+
+	/* ifindex */
+	len += nla_total_size(sizeof(u32));
+
+	switch (cmd) {
+	case ULP_DDP_CMD_CAPS_GET:
+	case ULP_DDP_CMD_CAPS_SET:
+	case ULP_DDP_CMD_CAPS_SET_NTF:
+		/* hw */
+		len += nla_total_size_64bit(sizeof(u64));
+
+		/* active */
+		len += nla_total_size_64bit(sizeof(u64));
+		break;
+	case ULP_DDP_CMD_STATS_GET:
+		/* stats */
+		len += nla_total_size_64bit(sizeof(u64)) * ULP_DDP_STATS_CNT;
+		break;
+	}
+
+	return len;
+}
+
+/* pre_doit */
+int ulp_ddp_get_netdev(const struct genl_split_ops *ops,
+		       struct sk_buff *skb, struct genl_info *info)
+{
+	struct ulp_ddp_reply_context *ctx;
+	u32 ifindex;
+
+	if (GENL_REQ_ATTR_CHECK(info, ULP_DDP_A_CAPS_IFINDEX))
+		return -EINVAL;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ifindex = nla_get_u32(info->attrs[ULP_DDP_A_CAPS_IFINDEX]);
+	ctx->dev = netdev_get_by_index(genl_info_net(info),
+				       ifindex,
+				       &ctx->tracker,
+				       GFP_KERNEL);
+	if (!ctx->dev) {
+		kfree(ctx);
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    info->attrs[ULP_DDP_A_CAPS_IFINDEX],
+				    "Network interface does not exist");
+		return -ENODEV;
+	}
+
+	if (!ctx->dev->netdev_ops->ulp_ddp_ops) {
+		netdev_put(ctx->dev, &ctx->tracker);
+		kfree(ctx);
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    info->attrs[ULP_DDP_A_CAPS_IFINDEX],
+				    "Network interface does not support ULP DDP");
+		return -EOPNOTSUPP;
+	}
+
+	info->user_ptr[0] = ctx;
+	return 0;
+}
+
+/* post_doit */
+void ulp_ddp_put_netdev(const struct genl_split_ops *ops, struct sk_buff *skb,
+			struct genl_info *info)
+{
+	struct ulp_ddp_reply_context *ctx = info->user_ptr[0];
+
+	netdev_put(ctx->dev, &ctx->tracker);
+	kfree(ctx);
+}
+
+static int ulp_ddp_prepare_context(struct ulp_ddp_reply_context *ctx, int cmd)
+{
+	const struct ulp_ddp_dev_ops *ops = ctx->dev->netdev_ops->ulp_ddp_ops;
+
+	switch (cmd) {
+	case ULP_DDP_CMD_CAPS_GET:
+	case ULP_DDP_CMD_CAPS_SET:
+	case ULP_DDP_CMD_CAPS_SET_NTF:
+		ops->get_caps(ctx->dev, &ctx->caps);
+		break;
+	case ULP_DDP_CMD_STATS_GET:
+		ops->get_stats(ctx->dev, &ctx->stats);
+		break;
+	}
+
+	return 0;
+}
+
+static int ulp_ddp_write_reply(struct sk_buff *rsp,
+			       struct ulp_ddp_reply_context *ctx,
+			       int cmd,
+			       const struct genl_info *info)
+{
+	void *hdr;
+
+	hdr = genlmsg_iput(rsp, info);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	switch (cmd) {
+	case ULP_DDP_CMD_CAPS_GET:
+	case ULP_DDP_CMD_CAPS_SET:
+	case ULP_DDP_CMD_CAPS_SET_NTF:
+		if (nla_put_u32(rsp, ULP_DDP_A_CAPS_IFINDEX,
+				ctx->dev->ifindex) ||
+		    nla_put_uint(rsp, ULP_DDP_A_CAPS_HW, ctx->caps.hw[0]) ||
+		    nla_put_uint(rsp, ULP_DDP_A_CAPS_ACTIVE,
+				 ctx->caps.active[0]))
+			goto err_cancel_msg;
+		break;
+	case ULP_DDP_CMD_STATS_GET:
+		if (nla_put_u32(rsp, ULP_DDP_A_STATS_IFINDEX,
+				ctx->dev->ifindex) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_SK_ADD,
+				 ctx->stats.rx_nvmeotcp_sk_add) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_SK_ADD_FAIL,
+				 ctx->stats.rx_nvmeotcp_sk_add_fail) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_SK_DEL,
+				 ctx->stats.rx_nvmeotcp_sk_del) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_SETUP,
+				 ctx->stats.rx_nvmeotcp_ddp_setup) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_SETUP_FAIL,
+				 ctx->stats.rx_nvmeotcp_ddp_setup_fail) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_TEARDOWN,
+				 ctx->stats.rx_nvmeotcp_ddp_teardown) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_DROP,
+				 ctx->stats.rx_nvmeotcp_drop) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_RESYNC,
+				 ctx->stats.rx_nvmeotcp_resync) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_PACKETS,
+				 ctx->stats.rx_nvmeotcp_packets) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_BYTES,
+				 ctx->stats.rx_nvmeotcp_bytes))
+			goto err_cancel_msg;
+	}
+	genlmsg_end(rsp, hdr);
+
+	return 0;
+
+err_cancel_msg:
+	genlmsg_cancel(rsp, hdr);
+
+	return -EMSGSIZE;
+}
+
+int ulp_ddp_nl_caps_get_doit(struct sk_buff *req, struct genl_info *info)
+{
+	struct ulp_ddp_reply_context *ctx = info->user_ptr[0];
+	struct sk_buff *rsp;
+	int ret = 0;
+
+	ret = ulp_ddp_prepare_context(ctx, ULP_DDP_CMD_CAPS_GET);
+	if (ret)
+		return ret;
+
+	rsp = genlmsg_new(ulp_ddp_reply_size(ULP_DDP_CMD_CAPS_GET), GFP_KERNEL);
+	if (!rsp)
+		return -EMSGSIZE;
+
+	ret = ulp_ddp_write_reply(rsp, ctx, ULP_DDP_CMD_CAPS_GET, info);
+	if (ret)
+		goto err_rsp;
+
+	return genlmsg_reply(rsp, info);
+
+err_rsp:
+	nlmsg_free(rsp);
+	return ret;
+}
+
+static void ulp_ddp_nl_notify_dev(struct ulp_ddp_reply_context *ctx)
+{
+	struct genl_info info;
+	struct sk_buff *ntf;
+	int ret;
+
+	if (!genl_has_listeners(&ulp_ddp_nl_family, dev_net(ctx->dev),
+				ULP_DDP_NLGRP_MGMT))
+		return;
+
+	genl_info_init_ntf(&info, &ulp_ddp_nl_family, ULP_DDP_CMD_CAPS_SET_NTF);
+	ntf = genlmsg_new(ulp_ddp_reply_size(ULP_DDP_CMD_CAPS_SET_NTF), GFP_KERNEL);
+	if (!ntf)
+		return;
+
+	ret = ulp_ddp_write_reply(ntf, ctx, ULP_DDP_CMD_CAPS_SET_NTF, &info);
+	if (ret) {
+		nlmsg_free(ntf);
+		return;
+	}
+
+	genlmsg_multicast_netns(&ulp_ddp_nl_family, dev_net(ctx->dev), ntf,
+				0, ULP_DDP_NLGRP_MGMT, GFP_KERNEL);
+}
+
+static int ulp_ddp_apply_bits(struct ulp_ddp_reply_context *ctx,
+			      unsigned long *req_wanted,
+			      unsigned long *req_mask,
+			      struct genl_info *info,
+			      bool *notify)
+{
+	DECLARE_BITMAP(old_active, ULP_DDP_CAP_COUNT);
+	DECLARE_BITMAP(new_active, ULP_DDP_CAP_COUNT);
+	const struct ulp_ddp_dev_ops *ops;
+	struct ulp_ddp_dev_caps caps;
+	int ret;
+
+	ops = ctx->dev->netdev_ops->ulp_ddp_ops;
+	ops->get_caps(ctx->dev, &caps);
+
+	/* new_active = (old_active & ~req_mask) | (wanted & req_mask)
+	 * new_active &= caps_hw
+	 */
+	bitmap_copy(old_active, caps.active, ULP_DDP_CAP_COUNT);
+	bitmap_and(req_wanted, req_wanted, req_mask, ULP_DDP_CAP_COUNT);
+	bitmap_andnot(new_active, old_active, req_mask, ULP_DDP_CAP_COUNT);
+	bitmap_or(new_active, new_active, req_wanted, ULP_DDP_CAP_COUNT);
+	bitmap_and(new_active, new_active, caps.hw, ULP_DDP_CAP_COUNT);
+	if (!bitmap_equal(old_active, new_active, ULP_DDP_CAP_COUNT)) {
+		ret = ops->set_caps(ctx->dev, new_active, info->extack);
+		if (ret)
+			return ret;
+		ops->get_caps(ctx->dev, &caps);
+		bitmap_copy(new_active, caps.active, ULP_DDP_CAP_COUNT);
+	}
+
+	/* notify if capabilities were changed */
+	*notify = !bitmap_equal(old_active, new_active, ULP_DDP_CAP_COUNT);
+
+	return 0;
+}
+
+int ulp_ddp_nl_caps_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct ulp_ddp_reply_context *ctx = info->user_ptr[0];
+	unsigned long wanted, wanted_mask;
+	struct sk_buff *rsp;
+	bool notify = false;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, ULP_DDP_A_CAPS_WANTED) ||
+	    GENL_REQ_ATTR_CHECK(info, ULP_DDP_A_CAPS_WANTED_MASK))
+		return -EINVAL;
+
+	rsp = genlmsg_new(ulp_ddp_reply_size(ULP_DDP_CMD_CAPS_SET), GFP_KERNEL);
+	if (!rsp)
+		return -EMSGSIZE;
+
+	wanted = nla_get_uint(info->attrs[ULP_DDP_A_CAPS_WANTED]);
+	wanted_mask = nla_get_uint(info->attrs[ULP_DDP_A_CAPS_WANTED_MASK]);
+
+	rtnl_lock();
+	ret = ulp_ddp_apply_bits(ctx, &wanted, &wanted_mask, info, &notify);
+	rtnl_unlock();
+	if (ret)
+		goto err_rsp;
+
+	ret = ulp_ddp_prepare_context(ctx, ULP_DDP_CMD_CAPS_SET);
+	if (ret)
+		goto err_rsp;
+
+	ret = ulp_ddp_write_reply(rsp, ctx, ULP_DDP_CMD_CAPS_SET, info);
+	if (ret)
+		goto err_rsp;
+
+	ret = genlmsg_reply(rsp, info);
+	if (notify)
+		ulp_ddp_nl_notify_dev(ctx);
+
+	return ret;
+
+err_rsp:
+	nlmsg_free(rsp);
+
+	return ret;
+}
+
+int ulp_ddp_nl_stats_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct ulp_ddp_reply_context *ctx = info->user_ptr[0];
+	struct sk_buff *rsp;
+	int ret = 0;
+
+	ret = ulp_ddp_prepare_context(ctx, ULP_DDP_CMD_STATS_GET);
+	if (ret)
+		return ret;
+
+	rsp = genlmsg_new(ulp_ddp_reply_size(ULP_DDP_CMD_STATS_GET), GFP_KERNEL);
+	if (!rsp)
+		return -EMSGSIZE;
+
+	ret = ulp_ddp_write_reply(rsp, ctx, ULP_DDP_CMD_STATS_GET, info);
+	if (ret)
+		goto err_rsp;
+
+	return genlmsg_reply(rsp, info);
+
+err_rsp:
+	nlmsg_free(rsp);
+	return ret;
+}
+
+static int __init ulp_ddp_init(void)
+{
+	return genl_register_family(&ulp_ddp_nl_family);
+}
+
+subsys_initcall(ulp_ddp_init);
-- 
2.34.1


