Return-Path: <netdev+bounces-190212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A5FAB5886
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B96169A2D
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350DC1C07C3;
	Tue, 13 May 2025 15:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Jr+lo/ND"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB5618E1F;
	Tue, 13 May 2025 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149772; cv=fail; b=BGnQWKGujIx+SGUw0T9GA4gYS24RavdML+jcKshTPqERQIdskuorWIpbynpEhl1PheH2TtdrnqmhT0cxxJk423GLiVXRj5MMHaKZXrJYXX1aecfgnCmaYeZhZAWfSAi60zPCNlTgnosNSYQnIJDUeFcxqHO2/pnEIYuVXm9dRp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149772; c=relaxed/simple;
	bh=JoGXNa0g8vJQRZW5lkdYg5te154lI4VAxQqzRPp4ZKI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WVKIhVEiMLVrayKbjL5t71QGRtTYGBPFyNsSU9jRdQdIn2g+Tm1/WeITQbBwlUg5dTtfUCBXvwPa0EYTJ8V7GJWiBqW6LE0uqk9Vk6YIRTIYi3sh/y1LXrtlOsbw/6ze069C4MDzURPOFxMprhndLpkqgT8mDO2Y659ssLwIk1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Jr+lo/ND; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FygZ0B3IgCkJwQldPQnLb2gJQDcdNQ03J1cvYFY1wmWhkk2IwgKeSbQj01XUOjfgQzxs0gnobbS9asnCOShD3m26mkPSvppfjwQ+ZyrgzKM9UmBZ27Yb3LZKi8d/eVYRRIdSRlV+VexnmXhk0bM5LtF1ulCICwJAfTAWlMBjQlpRLt2NRzG57fMHOLKW/W6MjGl92YNXV+vYvf2H0XGWsj3ZUY9GUjUoMJac54JycW1hEsm5FEmqjfPungazwPecpWv3ie05n4dW3FmA5Sear3muGNi+gw+tf3DL11xG+muoTBgnngjHvikDdUHfYqr0Np0m2Ku5AqQn9a2L0QvcdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5gn0GQvV1VSjPRNpchTeiptXvULg5AHgRRjlIx1IKg=;
 b=L9ppMeyMsMlJJ0qVQyvMIMuOtZRISoy4EYbMCca0Qv7WP1ZfyLgO8epGKtxTJ5cb6+jp0kXm8K3PdgbLdT0J4RCVrZC71Ih7TbaCt+ekDPmjaQii+9/8OAQ0Y6fgD22DnyD5d/uhmbT4hHhayXnr9UQCMm6FA1XBPIDYBCMMBDdw/khwOSWEcFXT9UQevbWWoMj+CfzcEDe4Jf5w9NDAPZvnnDnY6fDRfEf818Ztf3NJ8k+dJBCx1Z0WbPqou3XIdkld2sZ6fh8lLmz2TN/mzldKheG7SAfxvOLGJu7iX28xRYFSULkFWrgTpyaCxyajIafgquFzVqepYJdtYQLLYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5gn0GQvV1VSjPRNpchTeiptXvULg5AHgRRjlIx1IKg=;
 b=Jr+lo/NDBTGvoz8jemKSDXIiP7vt5raFzor+IkdEafxFODmjKb1YlKfwOD31hNaIg/NJ+InFfnQPY+VgzXoEShoVV1n2R4rChGGM3Va6hcjLBn7zqpbtrevosfGhYYBc55MRC57pjxtvERJCITgLbifpKsbNECfhwu4uEqqYZUiWSDLdG5XpzouoXIbd9T56zzRU2Wh6QA6Rq+E0sz6G/jP6ptD9YLTecUgkDJ/RQ28P0Gm1PW6TrLm5QfVdIeMYP/Gu9UGaRpm+fidJzxAJAcpNGcr1hwqQFGxm+6atHDGJl/MOnoJqAIp4+z3L6yoraM/kT9W/Qo/ZRGFCCasS4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by DS0PR03MB7653.namprd03.prod.outlook.com (2603:10b6:8:1f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 15:22:47 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 15:22:47 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	richardcochran@gmail.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mun Yew Tham <mun.yew.tham@altera.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH] dt-bindings: net: Convert socfpga-dwmac bindings to yaml
Date: Tue, 13 May 2025 08:22:37 -0700
Message-Id: <20250513152237.21541-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0054.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::31) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|DS0PR03MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: f7d50582-d5bf-4a14-9978-08dd92320402
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kjb9waa7j1Gxg9FIuqZ2k1zNZetVrE4Bfb8pcXOItE/o/RvezpEygol0RAeE?=
 =?us-ascii?Q?/UzuymVQpbSJuvULmQIJxr5bpcBE3DadCfP9agpbjKxkQFcjxxGymDMwM1vS?=
 =?us-ascii?Q?ryL7g67htOwMyNTYfXqhg8wvzGwBEi6goL8rC+GQglKrpEfqDdWtCbxpB7SK?=
 =?us-ascii?Q?SfVEakUreKKbEu+bKgzdret9okW0oP+hhMdfvZUi+dOLSH6+c3kn+8auWGnU?=
 =?us-ascii?Q?et52axQyuFG/pUEK+FWz4Rv0CDHD4H4v8id2uYrOkUtqsXbWAUPRGWfUjXu3?=
 =?us-ascii?Q?NKd8xn1O+ptZe+UbVmHWkC40JIcMxd7zJi1kAUPwMBoBYitx23doDqlf4YSG?=
 =?us-ascii?Q?K3+/xOiDprezfXnvOMShDgrl6Kgli1AkriidngmFYRIcWHGJWmIDExCBj9yl?=
 =?us-ascii?Q?Im9bk8Shir9+HZz9m6JMYZjqadBUKNzObYQhP8z300/CL9mBe5bEr6MZBtn1?=
 =?us-ascii?Q?fBtTB/ERUtkTfhCRBZ+9iqsyy53hyB7lCBMF+tcyMEj69p+yVDZmUfZmKT0V?=
 =?us-ascii?Q?YPyDRlh8JiEoeNMfyvGf867MFSWONAx3RlGB3SLDIcdL2nk2DLtib1FwGLI7?=
 =?us-ascii?Q?debN/lC/W5Sy2iymb73qdGBmJtygJa3GSR8o8dJlDwumtyuAVTzRhwACaFsB?=
 =?us-ascii?Q?uC7Q/CnCaTHsTwF9enLE+ADFJE1aqocWVSZn2rRBL1nHvQCI/f7HGho4aTaN?=
 =?us-ascii?Q?FjVuhvfYCnD9rNbcd446xiejE90E0kMeB2MEZWll5iGPhTSFRhfJ6TXbPbfF?=
 =?us-ascii?Q?F6xP3FP1uymtn2tUFGzPshrGs1DQPbFlj+cQJHDNJx60J3K/i4ozc5WzrVMo?=
 =?us-ascii?Q?PHvVi0MiYfif84MUdUhtSLyt5BXzcedvF5BLee9JACNmmPyPSqa3sAHDw/rL?=
 =?us-ascii?Q?cJUiUbGE9sw39Rhau5E8V2bjz3Rt9jh5ir0kcOpln3cOl290GZ0PkNamivl5?=
 =?us-ascii?Q?noOGgSgz4bfCJBQhLqffYlTETQCFgmYntsKjJCeh0yteLPxC2JwW1stprTnx?=
 =?us-ascii?Q?OQ2Ju4Ds4AVN9AOn9/gUtN5PYV3iDw2NH2UH2TWm+8n/WOBakI47uLzFNFBd?=
 =?us-ascii?Q?sEyARVG7GdURFREgWdHP1oDi46it/9IIAs31QDCS4kzOhxhmPgZrPUX4Wlh6?=
 =?us-ascii?Q?a0ngC1LiQ9aXxWXnq9kl3PGJzo7YXoqqePjb7MnvknR1H84HwHxYvsYtYFVX?=
 =?us-ascii?Q?eyRf46GvCE91Khy1QxtjmrCi2J+yiNGroNRLk5kaEJ13gsUB8zzAWZvqJ7F6?=
 =?us-ascii?Q?1k87Wpf22s35ci7gIsRthnvXqt8giw0M3spjYUOe7XbCwCOQsejJ6Sr3FTUC?=
 =?us-ascii?Q?8bvSwVP3/UQSfgZ0g1xOht/bwRv5QQAMHxCJYvaXYqJEKQpcJqZcY0Xhjh+d?=
 =?us-ascii?Q?f8LBevH8Dmo/UiU0kyUVF1HiCNjsrTPGoqZI2Z3jkh5Mlh7QTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U+2HvFz6WQ/37nEoilAEiNr7dTsyHbm0Vg9zlawKNwTmUIusqX2LnF6CRfLU?=
 =?us-ascii?Q?znOmKq//pW4uhM2xYs5NH14/2xI/d0D5GHkpf+Tq1RdMVJEFA+9QZGvzhGIC?=
 =?us-ascii?Q?f4jKxiVlQR+8IvTBgiWRU218uYRSg/YMapHaKXJ7vU7xVbiNh/dY0YkCxB/b?=
 =?us-ascii?Q?Q65P9l5JFhECzUi4/xPcTTAyJgV0+se0gBLhCpq4iRoLsElN7opAXV9HBicF?=
 =?us-ascii?Q?2in/Y5uOM+ZfiLe8DZxwYPGeE8wcQM8gePn6KgX1o1cVuNk/KntK0yD6Hy9d?=
 =?us-ascii?Q?gbYzGtD6SvgF2FqkxVgD5nYrWGEoC1wDgWeYYJbEguRDKjR5HlCFgoCISOVJ?=
 =?us-ascii?Q?exEpJgYK1psp3Ho6+evj/HMDm1DAHmAdIybLyz6CrVkvYT0frUDOXBPSX8ch?=
 =?us-ascii?Q?4yShTVcOV4oicvPmZa+vjmVS52r+er7v3XGrfeW0qyWbchpoPCIPMmQX9WXd?=
 =?us-ascii?Q?E6W+3RUeg/etUUEq09Eq0h8tdoUdxtlUFM/D+Cveaz63IbzPd7laMxn1XvVZ?=
 =?us-ascii?Q?8S0kUIANT6mfOa/Fq48apFUeeHOfCY+ghTsfDXtFnjYLDhDlJUhrEZXufa3i?=
 =?us-ascii?Q?KCnDzhivACseS76bwFlCeNxNAAiW0mulLv+4xokFEzwXzpeRTCycN5oQ6ooV?=
 =?us-ascii?Q?y9chAm0pgYFzv3geYw6pPbwlXvnhm0rlNszq3pGA4zUeL+JTP8ZG53GmsyRg?=
 =?us-ascii?Q?j9ynBeARgq5zLkfDPzq7d3sScqh40iZ3aMmn8uhXOKPvI6K1FfNmZ2dxqQD/?=
 =?us-ascii?Q?cXjfD3hMGmMqdIU74JUwVGC9W55xQlxJM5oBUI8Vs0E2ezYV1iByyXdP/hTU?=
 =?us-ascii?Q?p4bwmTe5mRXBaDP7JDMhbQPWLtanhik8iTIlzyyWkr94almzKsqaojI/mUh/?=
 =?us-ascii?Q?v5SgL9suDnJ+L8tohYckdZFPkIyrrmJhunphNzgMlTJP+wNOSMzMNxVR9smV?=
 =?us-ascii?Q?fkJHbmeFLHR/anIDkRBQPgHKeNoAMpdC7jDH5J5sFC9I6Mo4GrkPHxmwJnz1?=
 =?us-ascii?Q?Z6O2mRb9WcyGI2HQX85//RIYaD29m4c6YsnvBPzM1D/Cb9Z0gFKiXysPv3Nn?=
 =?us-ascii?Q?HHITM154FlCEDxKMHeJaqTBaVCO100AgLGcdrCeHXOLlpCeelmY8VFUOov/+?=
 =?us-ascii?Q?z4oRAL9Tj6vim4JYrR2nWCJ2oj/BMD/e+aag5OS5mz9mIKIgWJkq0OcRqfVZ?=
 =?us-ascii?Q?CMZYseHD6XZ+j+LPFoUA/KkjALuxRCzGwvYNPXcEFA8g5KXp7j1RKbsw+H6P?=
 =?us-ascii?Q?UYSAtQXjRF2Tp+UECUZT4vTVIfjsO1E+doI2+wFxq1nbCoR6imoC5j0ENiz1?=
 =?us-ascii?Q?BoqfrNUPnDJjJju/dgtJJDcANCtWNO9QjE1TFsVo2MX5gs2TC8k8oH5hZuR2?=
 =?us-ascii?Q?ZkyQmCwFNvxyuCKRzuM6EbeoQmHHerPtOCMoDapKkB5QuxWksFyoIXwsAQJg?=
 =?us-ascii?Q?JO01cl9+WltMjiU9/U8aQDwOd2jEoWSZ25CNp0otLY+7dzk6aFFVhPZy619B?=
 =?us-ascii?Q?1e1UxwlFOaQflit2EB3SaEWFD8iof7OkyOy+RQPz8vYw6h5GdJvALFXFBJUA?=
 =?us-ascii?Q?TZWNnGLTmBz/iRWvPYu6K5j5DijvyMkK4RyyBVhQoHs18Q5eeX1zjKCMlREV?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d50582-d5bf-4a14-9978-08dd92320402
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 15:22:47.1413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MlyUyDNq5KWMN1N4JvvYrW2BaBqXx73y4q/Ede19aGQqiWTqS/XLWvL1OmEsrKgUoMu17BwNAJkwjsZY3Ve3V7/CMo/HQR9ajBm279IJHaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7653

From: Mun Yew Tham <mun.yew.tham@altera.com>

Convert the bindings for socfpga-dwmac to yaml.

Signed-off-by: Mun Yew Tham <mun.yew.tham@altera.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 .../bindings/net/socfpga,dwmac.yaml           | 109 ++++++++++++++++++
 .../devicetree/bindings/net/socfpga-dwmac.txt |  57 ---------
 2 files changed, 109 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/socfpga-dwmac.txt

diff --git a/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml b/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
new file mode 100644
index 000000000000..68ad580dc2da
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
@@ -0,0 +1,109 @@
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
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - altr,socfpga-stmmac
+          - altr,socfpga-stmmac-a10-s10
+  required:
+    - altr,sysmgr-syscon
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
+      - items:
+          - const: altr,socfpga-stmmac-a10-s10
+          - const: snps,dwmac-3.72a
+          - const: snps,dwmac
+
+  clocks:
+    minItems: 1
+    maxItems: 4
+
+  clock-names:
+    minItems: 1
+    maxItems: 4
+
+  phy-mode:
+    enum:
+      - rgmii
+      - sgmii
+      - gmii
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
+    minItems: 1
+    items:
+      - description: phandle to the system manager node
+      - description: offset of the control register
+      - description: shift within the control register
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+additionalProperties: true
+
+examples:
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    soc {
+            #address-cells = <1>;
+            #size-cells = <1>;
+            gmac0: ethernet@ff700000 {
+                    compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a",
+                    "snps,dwmac";
+                    altr,sysmgr-syscon = <&sysmgr 0x60 0>;
+                    reg = <0xff700000 0x2000>;
+                    interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+                    interrupt-names = "macirq";
+                    mac-address = [00 00 00 00 00 00]; /* Filled in by U-Boot */
+                    clocks = <&emac_0_clk>;
+                    clock-names = "stmmaceth";
+                    phy-mode = "sgmii";
+            };
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


