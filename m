Return-Path: <netdev+bounces-197243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47685AD7E48
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 00:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F643A01EC
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3189224893;
	Thu, 12 Jun 2025 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="vYpX8GqW"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013040.outbound.protection.outlook.com [40.107.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836F2522F;
	Thu, 12 Jun 2025 22:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749766601; cv=fail; b=EJqeFj1U+YROGs8yOlmqr1OYErXxKfdndEwlK5lOySJ0K7OIHRvHXK7gok6EC0rqvnNHUqTppaGlOuekitpr/9QETXA0483Z6E/AVgtqa7mNikmV/bPAyU10ArhDvARLzowFMfWXHHec/Mh5VzTUI1CRFnU5rCr22if265ZCxlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749766601; c=relaxed/simple;
	bh=yYIr+ea2XuS0p5bI3aWxZ9BBoAvSQeMv7QEh9BDVPhY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RM75nRhEFhR+5EiAREWX96CEiZNSJpsGR8DkdPxW8K6ba4bhJnLEzIX26t/zuwAMrdrEZD3DSsWGO3rOuUkyZPaLLomJdVtl4ZNvxleRrRDrhurtI2YCd5iXFFfJwVECc+wl1Kd+d2TnL0oIx7A6v26M8MFW2AfCjr27+RyCVIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=vYpX8GqW; arc=fail smtp.client-ip=40.107.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUFANYQfpSgR/9Ukz90NOd0HWFAvEaKO1WQgb3fZeFljK39hihZhzPd81hDHLvDCwAHG3AUhg42BJeqk2cY7gL2T2hAQCll/aCyrS+Rcqtxab8NKYbhduQRKmAgswgPRt3FgOJb2OEp/Fmb94nXR32BRqfj64blcIP67RKDZwwuXR8opHJ2iTKMg9fuSTlRQQ7jYszk8yXXnhoIkNL0zXciwnpuqc1E+9fYWC4j2U6c2qe7l6IL4U2oS+WErljnKUpcTlDyX+nlPUlmJzliasZzWBTetTzm8dKaUWbxZ8mydi9Z+rAsALtuIoQEMdgHcoMpXl60W7wcMd8ZlZxEORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCrf2dWoqxi7qBorfxi68XMsLE4nKtVCX+GjBvyiMMI=;
 b=VtOHsGJ13XjVpHf7UlnTB36g81rwTM8hoYkL4H8XC6LsTcSy5ZOi96ZJt6EqHK/xx+Lrfxlr9cg0Tg6qp2CG3ybp7PdY+J/aWne6utd3K0SjZ+QXcIqiib6eXWGyAoF1OkDUkGdkeo6K6BpSe0XABjWKs7eehnRfca1xOaUjDJS28YIWii+0N9XWN66hoN3ks//M7czR2jPlaklKYILc2nBpW5ZaH7TBjydkRByqSoJKGs8cCzoGHFiVfDlGe7hwalH+BXnsDGApZ0wTpB9Zt4dlEJfkLp3Jf4wARhNKEg1cTnDSVxL4oaSj47iMpIDveB+SxkXP3ZtHTM3ndbayTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCrf2dWoqxi7qBorfxi68XMsLE4nKtVCX+GjBvyiMMI=;
 b=vYpX8GqWUHMAQPAakwN9SiV1ccmXubGCQBrr4dfglXZPYAthduPSV/3/5K7ibt1lzgcZVztMWSwJ9QMUkmiGc6/e4ZD7mPD/qz2d++xC3ESHFM26hP0i7j/xwjswTL3vx4T3UmtMutQXq7XO1Zq8+GPJ9fnUGHaZS+ywQL8H7RBUJnGC2MY4cAoxac74BY+mwPjiHz5JFqvjMhelHmxACjCpOQO7qmLmAFECp1/DHrYoOW1FlmiXqAdIMPnRrQApgLESy8bQZRrhTneS23t8fOao+POq1bqIML+AkGzDLCtk6RCkzmDePDFAuvdYQ2o/binszRYPg5ZpCq8JyNMZ/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by SA0PR03MB5449.namprd03.prod.outlook.com (2603:10b6:806:bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 22:16:36 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%5]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 22:16:36 +0000
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
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>,
	Mun Yew Tham <mun.yew.tham@altera.com>
Subject: [PATCH v5] dt-bindings: net: Convert socfpga-dwmac bindings to yaml
Date: Thu, 12 Jun 2025 15:16:30 -0700
Message-Id: <20250612221630.45198-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:a03:254::11) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|SA0PR03MB5449:EE_
X-MS-Office365-Filtering-Correlation-Id: f223a267-7e83-41f4-8528-08dda9fecbd9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z3t2hRmcuXeKG5K9iS6FLWgN+0dtM41rWv6tLgwzKHb2oqFw6cvP1of8/4OR?=
 =?us-ascii?Q?ZxOEibbRyRJ4MVGT1XEtNTvgt4RHaKWJPoQZ+Ue5WSSRsStrsA1xBmUuTEps?=
 =?us-ascii?Q?mY+JLKAg+Qz34p//VIVWOcxt/Rt9m8Bcaw6h9sFslI9lYqcl3qaH1BWC0bvv?=
 =?us-ascii?Q?HBC21tzZbQpS6ttAsdO7408/M0cbHG+fC0avRGD4DcwFsbCnwu6u3ntKOc/3?=
 =?us-ascii?Q?VqFWYfTh7OXb0ZaPz4NEf2a6v4IcKhjk3wDBQ4TcBe3vvOXUzaUlqAEX0x6r?=
 =?us-ascii?Q?9Hk+dLfNJ9U8y3AmzHKAMYHYcOapwAefuHHuF4bK/OssUioCGMgqok24BGMX?=
 =?us-ascii?Q?gfHSLUr0392aOQ/ZTnRY93mJKLJ5iElKRFOL1Is2DkhG2qRjQAA4pC8LL1fW?=
 =?us-ascii?Q?C1i5v4yLKqYBINIEsfFn+MdadWemRlzYGxWGAtf/2oFFWfq0Ln/H3Y9V77fF?=
 =?us-ascii?Q?NOI9cYuz8h70GFmGxNu6f5z97j+PDDq4A2Oxft5hfIiZID6v/+KTbTs7PUi8?=
 =?us-ascii?Q?6eHpz1g0GjfN5z8Eivbg0anaWUwoHJMB3ksxakSgsR6p0GLiYY3bfH+Dp2vU?=
 =?us-ascii?Q?nzhJUmM5tHsHAy1XSY0y6OOnaRHB8E4fExFP/N65/spk4wh3ZtQqibhSRvPD?=
 =?us-ascii?Q?/yR/wLOBtqPKxpGkKYShfdLHaqUYU4Xgo4rb7cmY652gLmVxoWsIPiZL3z6a?=
 =?us-ascii?Q?2Jt4S9aHYdydLhDsLbH869+tuET4uJje2bHL75d1uJz7qEFqLyKnA5ICZJ7Y?=
 =?us-ascii?Q?c+W89uJoFTTE+XyhgubTPp/qgPwEbOo7kjmtnNaxZo50qV0TRDRNSiRR/bvQ?=
 =?us-ascii?Q?GimVSppnEH6uZIGuVh9LuZTX6qNcrxEB9WrrAIk3Ht29VDse6d5OCRnIL78B?=
 =?us-ascii?Q?LPsP0lD6Gk8jsbtn30QOk+aFQQfU90SAD1n0QyI5ZKD/gKvqJXm8IcRIrm9q?=
 =?us-ascii?Q?TgoYuFZOi6yiBQAKs2Ab2b8Tt9X+Bz8Q7PUd9TQ5FVr/I7weMpCfcqsgPSkT?=
 =?us-ascii?Q?NZPbzeRnpfYcLpOAPgFlH2a1UuxnvNkJ71HzUHK6sAvh5Rxg+6nrh2lQ3i+p?=
 =?us-ascii?Q?FqkfW8OMP2pmRgaJ+8Ht0FRi+NDHfiQMQsPbaimRkULt75O+TMZM9zThvdIw?=
 =?us-ascii?Q?H4UqVwY+2SokH1wJFJ7v5c+3HVPZWIIiwvCxq08rt6eNC2clJ9JRxZF/Pevt?=
 =?us-ascii?Q?RddNbaFFk5+rkhU5ElNyvGo8z6obkAPKOTzS5TTX3CbO6q6xu3zxGapYONAP?=
 =?us-ascii?Q?9ChNcJ5YD/hOokHdta4gvt2ONSs7kQL/wSDN4lM8Fw0053r8LZdkDB3lAMmj?=
 =?us-ascii?Q?o22fEhJdPHyjFZCpUwjUSEoJq4ihqErwudlNkum6TPYKz39StVjE4Q+sq8/+?=
 =?us-ascii?Q?iLmct9WmjQI7boU9R3Jahf4+Co2h7CQRLOxhDfTb+CK/f+beeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KRmw90wUUR/Rw9lmuIvQ3tTUlVjA5cy1gajYtTR7FZjgxtrVc8NK2RAR5duZ?=
 =?us-ascii?Q?+ehOX1mR8/PABVuLSQLbn6wgdKixE7I5fUYlBpgjb+IlVGXz979uFkqHJ/oi?=
 =?us-ascii?Q?f29ou8NgqIHmTA6Vc+s8/o1taHI2sRJRtrNT3FAfbGUhzk+v61mcGNfsGLwk?=
 =?us-ascii?Q?nBPzQrTjErRiFL47Bx8p6A2FJYYJ0lfrWt6AIlG6P4ZGfRrHGazAgQ4JtKqY?=
 =?us-ascii?Q?Oej9LDYMI1L20XlzVPPesUB1VfJmkqPI5AvU86CGhw8J+nE9IvpmE4U0SFUo?=
 =?us-ascii?Q?W60Rf8LsXZVelukAcSpwI9Np6Q3JkBENOhOYbt0j0Xy+UAPfOtblqXTfIbxL?=
 =?us-ascii?Q?TZFnuDId13sGe23FZzajItdsaXsJRsqjkrGGmzm3SOhm01IrwBci0a3kqOGJ?=
 =?us-ascii?Q?Z7TZupaGgrVcoNbxEKN9GxawbgAvqEjMKHWLXlV4p89jrYYsQLOaYEEog703?=
 =?us-ascii?Q?RjSkYneBBWZX9A2bBxvFcFirqXZUIadtIUcWd4aItG37ZB3qYb4RX8YUWKKp?=
 =?us-ascii?Q?BQdM8G373jetLBoy+8eja5G7xVzCbNRt4g93pVb8PzYquHCFMoSv+3SGZmjd?=
 =?us-ascii?Q?dV0RL1UVXKn9gRo/4z6fP2d+immEuZapewXQ47AtgyRTADZ/eIsUoIfdFiBI?=
 =?us-ascii?Q?+igk9RZ7gwFl+AE1ZP+/ed2KzKNNhiQkfHPEFTxU3jXbLV8dKQRcQnwzdlSE?=
 =?us-ascii?Q?/6Sxt2v1PJk7ljZrerOuJrmbuxKIzitAVKtUbCwONYeWEskatFfdIcUc5tYm?=
 =?us-ascii?Q?3ek6+hPMT6jyud59kcgInXf+iEgiBV/aQ6BM3z/SIVP44gkb3k6Fq8FLv3pl?=
 =?us-ascii?Q?zsx18sZziEmcgFmdNsJD1K+YLv5G/ZtogyBupd9COiM8yNetpc18392LEZXz?=
 =?us-ascii?Q?u1GHgjNo8YtutFeTJ+Re6wXi9YsJv0EVOuCjEgmMiJfghzYVM4ZJbLt098OM?=
 =?us-ascii?Q?CXtaV1vQ2UGLVzQ9UlCBJtoJBVpLPsR4kg+u+6bhXPFyxRFORGqpEsTcgRrW?=
 =?us-ascii?Q?HRGI1hK6gyaPfETARD0IFR1GShC9V3kjKRxjcrDwomYEXyM5qvABBfsEXoMF?=
 =?us-ascii?Q?OGvk74/QQzsLF4FQQLVNRF2/qyzzJASbep5esL6334Mj8g+Cd2uhYK/5qAXB?=
 =?us-ascii?Q?f9LkVjGFetSh63QRI6Wmd8gXTEgHS5vYiLpvi4Lb5GM9ABgxx3l4u4lMCVgk?=
 =?us-ascii?Q?Y2zTpzX7+ve6mFCluTIV/NKCcebzZChfQ4YoYukfWa0jxc98K53nh3LjIJcu?=
 =?us-ascii?Q?MIfvqD7XTl6S0EFVXs+wSgVtSneFV+puAGa/MG/rDeD8HV3nx2x7RgddORMc?=
 =?us-ascii?Q?BruoCdHayIRp3rH8NGdN5zHdm124LQdyTFZwH9cZ+Zrl/82i/ZGHiuTCRfCB?=
 =?us-ascii?Q?wCq+2Kf1EWXb8Z7R516wfnNEWS6Xk4KJ9j6N+vxL9bzjZBTnYcndqJi2HqxG?=
 =?us-ascii?Q?o6pa3QegQ0UPL8rQp7pkjPI/BuYI6HeOMCFfQQMAd5Pn5IiYnGP2n4yuP8PQ?=
 =?us-ascii?Q?NxyH9MDRKvDWg/hHFm4vAExsJ8PfM9qeXv3PtnQIvm+3wcT0rggdHNGBlSjp?=
 =?us-ascii?Q?zPJ6hCQl1q2Fvx/GXSZR4euy6Qxx8NlyuR5/QUvKLJyQC9HS+/Xi4vv7wX3u?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f223a267-7e83-41f4-8528-08dda9fecbd9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 22:16:36.6166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y58XvfqSVeuCV5FNe4JmNodsMh14qDwiRHUQyB/X5jsIDdJLmyNeTBrBjrBiFlI6FIJR9PwV8md/n5I+AuG9GmPspz+sRJhVmwaAr4qFFFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5449

Convert the bindings for socfpga-dwmac to yaml. Since the original
text contained descriptions for two separate nodes, two separate
yaml files were created.

Signed-off-by: Mun Yew Tham <mun.yew.tham@altera.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
v5:
 - Fix dt_binding_check error: comptabile.
 - Rename altr,gmii-to-sgmii.yaml to altr,gmii-to-sgmii-2.0.yaml

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
 .../bindings/net/altr,gmii-to-sgmii-2.0.yaml  |  49 ++++++
 .../bindings/net/altr,socfpga-stmmac.yaml     | 162 ++++++++++++++++++
 .../devicetree/bindings/net/socfpga-dwmac.txt |  57 ------
 MAINTAINERS                                   |   7 +-
 4 files changed, 217 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
 create mode 100644 Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/socfpga-dwmac.txt

diff --git a/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml b/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
new file mode 100644
index 000000000000..aafb6447b6c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+# Copyright (C) 2025 Altera Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/altr,gmii-to-sgmii-2.0.yaml#
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
+  compatible:
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
index b8f217c7d92b..3e5aef9e1538 100644
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


