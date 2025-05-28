Return-Path: <netdev+bounces-194000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49042AC6C32
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 16:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48871C00779
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 14:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0292C28B4FD;
	Wed, 28 May 2025 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Y2rnf0Ln"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E983B2AD31;
	Wed, 28 May 2025 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748443624; cv=fail; b=bJhEaY5tfWPxlFa4BrGgSXpr5anoYAaZ/CRHyfb21vRepNGVryLTCnH2L0192gxohgYWjk6ZQjixQXc7ukJ8gDBOga2QOOMo758HFSCoeC/pMUxaMGO4oDe9KT9pCdcco5VWDYIvR1YC5LJCLjZza5m36MYR0s04E8Jgv6gVJUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748443624; c=relaxed/simple;
	bh=SHDgfUWIn+UenKOEL3OLGOg+bn2HTmsbeBf9xZc9h5M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MJMzQgei159lqUt2l4yUj7a8Ag/jDH7aEHrUM+uEIOHp1mHOZdNa4hFIu6Go9U3P2nEbk5GpeNI2JP6SFTM/U8uH1eGkbucDJuu50k4Cagt+mW8FAD+QofkOgUNCeOn1JBRfP0orlCzA+NcG/2lw1pRXEMBHInVhg1zsYWb53eU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Y2rnf0Ln; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bvm866YUyiM33abZqGD8XwC1jV5yeW1Rz6HsI4tEZWwm/7S1DFOOdz+Kt0Wgr52gsffodOyZXoYgQBljOQq4x/DndnxdyzYmDYzT2mJ7SzYQrwmJ6Dk0xNOU8nJIFPevHrBpo1XVIRAIFKp8hA1pxpkvNkRXh1Mh0CwkAVsDILcN1u5WYf/X+G3r61cFgjjhxlnmdNDLTV3Y+rOb5NQweB1AxQRK+cZb6nUXC+GkNIDQpCEj9EP+9MKgKf3gI+adsDTwqUTksqpqgfIjDTtDJnbmAMcwoS3iaCMkdA2TzZkldL6mCdAJ46clsVm7fo/3eA6gGvkf0lMQXSEFJ0Ng0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gw5aM1Y+1DUB+PdxNOMnaHTImfqiN23RA2dTvv1ky4=;
 b=RY2yGoitSRzSCCDsmQvq4E1UTOprhuI4AcIiH9Tuh0OKf5Qi2JxJxcAk8AsmvNNEP/553MzfWfuGFB/Q1mfK551NIpECF4qGCHV4kgnq6OKOeS0xUshb7DN0bu3dyTqpf0IsIJTs6a8wcl5j6MFpWyrKsIJQKY9XTvZ3AAprhQr/BxnMabeoMz5TS1SSErgNFWSnb3ZyAfAk+Mw/38LpcTc6kVaiVTZCpinLgc6Hi+JJxFslEo315mnopLlqVSnnQ0QdEp9cw2BDomy8QydXYQgLLLpOi4d+rScFhbbvmn9N1l+mYJsI5esZh5d0p3qd1iJ1OlFaqkzbphXREABbxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gw5aM1Y+1DUB+PdxNOMnaHTImfqiN23RA2dTvv1ky4=;
 b=Y2rnf0LnRft9JtLpr6T33sRiFST2VqZqLpz7qGLaDOGE65etGIRuKQICs5o+gGQz/xcCl7A8LH2pqH+aLciElvwnUR6Yea4P5iVF6c2ZyNwAOkytGpg7gjmpxsT/0A1WBTjvY8i8I30c2nqW0PNJ7etvqFUpu6wcUCUO6KdjIOfj8HYPf0TFNT7PxoOGvKcgkGzi6N+HyKq2UUb7gnHiuklUXD0aokxI4TcGpTSdOVLEx/Y5Ia6K4R+EdbOdl4OlTrg7dRccaJ+MAdy0v1DOxEUky+tQVmPATgemi6FAEV3CYvwOvuFumoN+p4LhZQO04CBT4aQU0in2Ub7jhbEhSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB3465.namprd03.prod.outlook.com (2603:10b6:5:ae::19) by
 BN9PR03MB6140.namprd03.prod.outlook.com (2603:10b6:408:11d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Wed, 28 May
 2025 14:46:59 +0000
Received: from DM6PR03MB3465.namprd03.prod.outlook.com
 ([fe80::1ddf:36b:d443:f30]) by DM6PR03MB3465.namprd03.prod.outlook.com
 ([fe80::1ddf:36b:d443:f30%7]) with mapi id 15.20.8769.019; Wed, 28 May 2025
 14:46:59 +0000
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
Subject: [PATCH v2] dt-bindings: net: Convert socfpga-dwmac bindings to yaml
Date: Wed, 28 May 2025 07:46:50 -0700
Message-Id: <20250528144650.48343-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::34) To DM6PR03MB3465.namprd03.prod.outlook.com
 (2603:10b6:5:ae::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB3465:EE_|BN9PR03MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: 612ce8d3-0e3d-4810-5b2f-08dd9df67fcc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mkTgxioXJJKrTintKqocc+Lq9VWILALuAkXR9X1+zm0xs1833tYy8vtKmYUI?=
 =?us-ascii?Q?vQjWsgLVObNIolx/HH09kWbAPWEChVwj57vfZTEKaybMKUUNPRKkyxM5IpXZ?=
 =?us-ascii?Q?Kcxd2I87xDAxII4xNPkXdCCX43fgundCZZrIYZ5GIRWSz3wxatrnBtkkFRTK?=
 =?us-ascii?Q?c3p2A9UtqtCTnyQOFp5qS2O61uY9moSNowrbQbNeib4gVgZTHux/W1+14a6W?=
 =?us-ascii?Q?9K5PASskWUcgUpgK7nk6FYIo3fx/nU7shMlhBW8DQt6agNMpxYKU0gKfZ/Hw?=
 =?us-ascii?Q?D8PjO156l1IHU05FBxgHq2cba36Ja6+VtROHLgsk60rkt+A3k8Dp+thxKC0Q?=
 =?us-ascii?Q?NCTqvzIevIkl/SlBoxaYYNaBYm4FFMe2N7W5PXJGs1bJADJIhtKxMbnf9ogo?=
 =?us-ascii?Q?uVl9oRwzvM7D/UPScn/kK9/+KKpm8vMVPptzCn4Lh4hNmvxTxQk5jcyXMR0B?=
 =?us-ascii?Q?dfWXdbSRissu0ZtRoRiD3Bt1dpTkjyl41aj9h3oIOfjIKQvdzJf2uMX9DxTF?=
 =?us-ascii?Q?1guLCizyseOUwn9O6+PawJo7WtHDbt6kgrYxYO4aqT/bwbfTJnEjLhviwJ7N?=
 =?us-ascii?Q?mK9jMJ9sRNDzvH5wL2cNhoU3/MqnJ11fZgckXpQhaEoXDTYH4lKBjhqdlopr?=
 =?us-ascii?Q?X3xJyYqLNijWSZOhrJzPQp0CaWcCRCVFWqlVeEbzOIsYwWB3YrIE7AEK4/lR?=
 =?us-ascii?Q?1UMNonHHd052Fp7PqEqQ0gyajAaaoDURTflU4Qni3ViN36nML7AAigRO8uQv?=
 =?us-ascii?Q?EP3DYWinfY2n8rwEdJe3k05lUmOqozYjYq1pL/gxL6akDspyGEmcQHEIskTF?=
 =?us-ascii?Q?/7JkRlXoV9YmIRdMp81EIjwRtAwGdyDMpcvDJrm1JxToRByOizC4EFETbipD?=
 =?us-ascii?Q?5DTSSEbD83Xx2s5+++0km5drCClbmNTXiWmTQfDaqAFTuKmOXIk2IEnGOFhk?=
 =?us-ascii?Q?eQ16aH9j/QGarF8JKe0bwaau6RRB+TC2Bzuksk0CISjAkhrTz0paUP8qTZXj?=
 =?us-ascii?Q?/cBkpwFJH6SI4jRiu06Wy9+Bq7uSDuzft9ZFap9CTJ/hx+VxPztL4WpSkoqv?=
 =?us-ascii?Q?XYd5Z08uEkSMLYQL/6/3dnJn+LjZKlzPyShmQzdcNPkb73xixOFzeeKkCwTI?=
 =?us-ascii?Q?nfc5Lp3172pyZKvSNbZUUKcE4VcJ+ahGV4A1nCIxtGsMGFGGUuce6u4AuD/u?=
 =?us-ascii?Q?02FST339f0SjynLcQq1kJS7UNRhNCkfL6KueD05uudfGwkCwvLOsnHLVLSSH?=
 =?us-ascii?Q?A8L25bnw8di+eO4XUm5/jeTFREWIlRsGlYVtHOEBL7mYe+PWaAGtHMmFVTm5?=
 =?us-ascii?Q?UWAze39EXFFIAggjaCVH5Nkj+LYFAlEuvEr7vtziStdR6cqkVPm1ZNHya86v?=
 =?us-ascii?Q?LpS9v/KNSgy/qNZ8i9A74nyNNuAY2sMi0n2mj0nscqYofITqoQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB3465.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NB7caWSXitQy3TN2ZCrXWqy8PUxrsWxc5jOQ7VpJDe8NTNdBJ5Fpv7j1tGd2?=
 =?us-ascii?Q?jL4GiAeymU3BwuB3Xzb0TpWCwU3+Pcw7Z7D3jbdauzauPiVYLDBmqs/bYG2w?=
 =?us-ascii?Q?VhUcdhE+0YFaK8dmGOxIYHQAkt9mhr/t0uufLn5JXgUSyPZ8jjfu78kAWgxl?=
 =?us-ascii?Q?JFHfpbnXb6DxsCoRyNUCXEmYt3A0WHg6kDoF8hZ/HLVYtMcSbogR7xzcmQ6P?=
 =?us-ascii?Q?GI1JDwD0+t0Z6xLSe/pZvLC2CFC3fN06kNpDrcYD/DtYBQswXOKUT8qFMoZo?=
 =?us-ascii?Q?6QGQrsW0QN1nU42xFU2rLw9V+Sfw822/BCvKVfhzu6VvGxgv3nV2rjpWHbtW?=
 =?us-ascii?Q?yXPixMuEjHg473kg0KZSmtLZ+PuCXrdvMH84fDrT9PF1LqmT4JZyrBD8ZUFI?=
 =?us-ascii?Q?ep0sHZYRd3Gt4u9LC5ylxso2bhZWzgoFeaBhAnBuUovHiu1hnuaBWT9jLQVY?=
 =?us-ascii?Q?3y3zmgqoUpDl57+HG4N9pyR54Xx3BkR2kgV2FA/eye6mUydBwM7fSy17+x2A?=
 =?us-ascii?Q?8ASvr7WGJL0YSjHj8mEqKtaIXDwuLcgThxRFmHYgXnq6KVQAHf8yln3SlyXe?=
 =?us-ascii?Q?GoVIcfxvSuylY+EVkmehvnKteZ+sJ7ZjBc+J2kwNX1gMy7mXFX3R6loUpl/N?=
 =?us-ascii?Q?+U6eIihh5nGfGGt/lw9RYYUqoizhJQp0DdKB9rIn6b7BHR89jDV/ULat4pRI?=
 =?us-ascii?Q?u81UTQ/QZcIVEplOFicHN/667mgroAu41k4w3VHl304x6b8d8sl0UfAbJAxN?=
 =?us-ascii?Q?YS5uYCgjrdiv2FytRsTpZCqaJ5RyajzVS/iZYiG+YQogNWDEDAbd/LMa2I4b?=
 =?us-ascii?Q?0h0ZmKQMrct2TGgSjwQz0I0yERsoIOIwxUK7ek1Oe4Y2UknjAin3fA2NvuzP?=
 =?us-ascii?Q?BnJ1MrK6GlTrD8vKaaF9J9qiHWeI+xjN8mykJPfFn/Dd9KZt1zAPYxwUYeuD?=
 =?us-ascii?Q?1YuJazDKsItkhmv0zYKhcWQYticUso8+7Mlhe9gycHJxdLLbzV6kOr9cwkG/?=
 =?us-ascii?Q?9/FbybvHO31YOwsiCQQ8YQiTThXtpbVMWny4dLgm0MhnOH+4+uTExZSug3Rt?=
 =?us-ascii?Q?lJw1goJmw9WdCTWJeNLOv+FgLjOntPrKZbgnvx6ShklIiZlLH1ug6+6EB/8w?=
 =?us-ascii?Q?5h4W6QvGiA1amt2tqGbBhdL0PJf64V4IH3LSFTsOGWQbEBjSy4liaCSHk3P7?=
 =?us-ascii?Q?yuh8sIA5bjTpe2bEH7mp+IpVf3FZvWgEhwOFg3hQ5PKtqRoOPFUGNyHcqjhd?=
 =?us-ascii?Q?cwOpj84xIcqBDoF0F5Y+Upnz1TsMs5wxOwfnBVFa/GgH6508mKkyrftUHgNp?=
 =?us-ascii?Q?qWNXKcuESRk5mHUML7Ijr++V7f0QKxYuVAxoFOFK9DslVau2xG6WB+ErJynX?=
 =?us-ascii?Q?ErGGJaHykqM5Lfmjf+RVYkZluUL19pqzEFF5V4bvSD0jhJxmQb1kWtif5WAL?=
 =?us-ascii?Q?FT3Vsdnuxu4b0nAamDVukkMit2fStNxxNZCEs0Xj4Gx/ntIrnGJSXssJm+79?=
 =?us-ascii?Q?zWrO25XsFWhk833QV9JTzcg1sE+MYmP7Bodpo8lpKOWd69OFGHEpXz8pC3YE?=
 =?us-ascii?Q?2WpR6mj2Lqc4JR6jjKUyGz5HWxav3OfuxbDNzXqQDyKvz0/5O1GnqdpgkGho?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 612ce8d3-0e3d-4810-5b2f-08dd9df67fcc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB3465.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 14:46:58.9550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agyMVMtIV+YJWAi0Q1yvCDarWKOI6LPXOuXlvB5h+Bg+PKmV1tqSpNl4/y6RfCpUIFENgOpKf4oKbpSYvyUUqxTDbNw0159y0TGXI4Ioyp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6140

From: Mun Yew Tham <mun.yew.tham@altera.com>

Convert the bindings for socfpga-dwmac to yaml.

Signed-off-by: Mun Yew Tham <mun.yew.tham@altera.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
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
 .../bindings/net/socfpga,dwmac.yaml           | 148 ++++++++++++++++++
 .../devicetree/bindings/net/socfpga-dwmac.txt |  57 -------
 2 files changed, 148 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/socfpga-dwmac.txt

diff --git a/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml b/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
new file mode 100644
index 000000000000..a02175838fba
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
@@ -0,0 +1,148 @@
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
+      - rgmii
+      - sgmii
+      - gmii
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


