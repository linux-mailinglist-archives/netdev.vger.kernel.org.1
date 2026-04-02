Return-Path: <netdev+bounces-274468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMkKBUVNzmmjmgYAu9opvQ
	(envelope-from <netdev+bounces-274468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:04:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C193880E1
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2592306C462
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 10:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A165439934A;
	Thu,  2 Apr 2026 10:56:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2129.outbound.protection.partner.outlook.cn [139.219.17.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BCE299923;
	Thu,  2 Apr 2026 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775127418; cv=fail; b=RTjnAuxebKPjJ1EdwcoA6qSvDx6oi5MxInTGtGXPODfsAz6DTQ37QhhQXsRYDp30IiccnpG4in+wXIQJi558kIWlLCftyQLbl80AMxhCK2COzMX54yFEuizoCF8T1tho8pIltgz0uVPoLCbZErZGcHGRvtqRwE3JTWcqppZcAKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775127418; c=relaxed/simple;
	bh=8kb9A18eVeU9BIMlAS09m+j6+D9IbFvJi+G6dom7p/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KOEnf+hr6F5m+1cD7skOaubvnSwqlFQG2dH2XWSjRprxxj2vPPZiYgv2Ns95Fj4J10gKGKx7WZMgB40eN2aqACrRI4GjODXeLSgwsNeOZJhh6v1keFC17MDqPbtIvlX7eTTlCXS4LeGKEwrqnYtK1lxbpLrHD9S3H0lOs6OTIjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6yfnWWeATwRkZJbws/pNAWpfEzJP2rJMXrVVSZ3BNBlI/5yIeFQnU8icSBcJkd6YQxNIftbcpZ/eqx7gfQf6h8oF+4r80XQ8A8hOrPELbRcwFrSBsqjugNPrJ6Jdx57sFslCm99gQM8TQKnxPGdULy3FEXyXOPlSqkLlqy72KMXUeVFfGHMVTaeNt54JMzfTzSpuhG49lMzdUzy7o4G7XgYpajupBijEcfxcPAInMGUve/PpVU1G97dzQ/59phg27/vlmcszZ/cLSTCZw/nJnfw/SRMaN5V2F1Z8WgTR7Uv62o2gesAuWFR+w8kMheGUDSy/vj6KKZz4DrT9IfC9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwI5pL2oFR1vNqG+G5abCqWUhOQYnZP8zdL331PSWms=;
 b=OE/tiYXP+yuCbFcQpJ5XHjMbOBtmKZVDPXJkBRDiH11hdzyC1Qw5PqtAuwC194pP4cLrrtpf7HS73wWJkMvZegpPg+ui9ZRU3kkvJnOSXHYCMMZTUU3HuFaXHAkFmdJ9RcHpQ7UJ5HMC08AFnqCIMhgRsYM6qfmL/eqIugoSnrtRBTG6qMV04ZeHjny+/KEDlfXEIqMLB2xqusS/KJvbQ4iuTQ2hw1jrdG3olZGw1+6dYAmDviOoPRGFA2GjPs69h9yPLgo9JREt/7IkHkCYCw9ikqEFF7yVWRw5EzikrJg0l7ck6fG1TuAb/OY2GJmgGUKKAzy0fe5i7/u5p5BP7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::5) by ZQ0PR01MB0951.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Thu, 2 Apr
 2026 10:55:43 +0000
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 ([fe80::63d1:b688:cab7:50cb]) by
 ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn ([fe80::63d1:b688:cab7:50cb%7])
 with mapi id 15.20.9769.017; Thu, 2 Apr 2026 10:55:43 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org,
	Sia Jee Heng <jeeheng.sia@starfivetech.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v1 02/22] reset: starfive: Convert the word "jh71x0" to "starfive"
Date: Thu,  2 Apr 2026 03:55:03 -0700
Message-Id: <20260402105523.447523-3-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260402105523.447523-1-changhuang.liang@starfivetech.com>
References: <20260402105523.447523-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0028.CHNPR01.prod.partner.outlook.cn (10.2.0.210)
 To ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn (10.2.3.165)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1208:EE_|ZQ0PR01MB0951:EE_
X-MS-Office365-Filtering-Correlation-Id: 286b5ed5-7356-446c-5591-08de90a66305
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	VizgIbI81l4rQ0OSmG2iusFO6BmEt48E+o5RWPLxR7IBZZVGwb47WK57sSsS2a8OR2E2AI2sEXZNw0aDJyLea3/aNnS6yRp9A7rWKbi1V3O/EQ0DD+qav7KlR9l8CqCC6jS3rUw97oB9Ruen460cscxOKffAHCmqryKhHIBVT9x6OBFAoGzgwKg42S32L7qeg729U5SziclFU5PExCZ0FeHF898DIHSRnxCHT/G3BOnIFiHJaIKf6gYXvgtOuWaKgE9Ysdz/Ai3P2110OR9ZAdG+sQOZkG/DwIhc44JDmCQD3oWgrYUHz+rqZv6BxMKsWZ7L+kKGSfAwYRb6i+mHQgC9m+ydLKRomb4th1uJWSZFawxbnUQKFR7WmeigETYJpnZfp3kpEEVR4VRisci53MrovAenEjuzFJ4aXYAxgEFOaZEvXkdnapcR8neJQPfKSm/4h19TNU0ETbz6iZRTY4KnRSRiaLg/YQE0LGeP9j57Uw0dEKcCpXFo0pKzM58IX41QJCjwdcOlbniU+JhktKyeJZFfo+eaoIK8Romr8IT2zAe4ZutEQPvMHCZaawqqQb+8yAQ5GLNb/qX++ZWVI0pmz7UAcNGE6CXBThUBBhI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Ajso64HyHZgTlIQ7CB+ixtWnZtKzkU33Ff3crWRNd5vM8XS0UBpcZPUShBs?=
 =?us-ascii?Q?kZoybVgOO84iwm4Fvip8GS9MCZu0TqlHoStuZdwU1S/40zdw3O4IOHWtIjrf?=
 =?us-ascii?Q?a3X4KbRpsADqnbB6jZBnkkmEVNwO7qxIP5PKkAsWgO1tBfuytn1bPfjn8R/n?=
 =?us-ascii?Q?BMN4v/rWRmPUQ79kE/2tY1vecj+qyv6i1TI6C5HAL6vy8BsjP7FfiyO7Xl6p?=
 =?us-ascii?Q?yrtBu4UPiAI8iwMl4k3tiBE9WA2/50P+ppuwj268dIJv1hZP6YRpJIBVpDRG?=
 =?us-ascii?Q?nrF8H+htsLL+PXGuqCnrPdHnKGmcutaS2xhNIpVitREO2odx0ya+UzR3AXou?=
 =?us-ascii?Q?lEPD6NpE5nE0AzKCWGHEq2aaE0tPCBxYbpKltuB9Tji2OygptbzNI4L3SKFk?=
 =?us-ascii?Q?r2bt8kA61nSOEStJyt2oP9Z7HW92Q1kApFF1kc1JWVbECD+S2EddRnIU3gOo?=
 =?us-ascii?Q?SzHPcB2jvYcde8SjZGGXov6R23BAawvLW41oOcR1bO5uPKM5ykZwUOJ29ioB?=
 =?us-ascii?Q?+tLJwpf7xxLyKGXzgWdsfoCZHfsuhpzT6SmWuTHJ1BETGLOTAilGKUQBphI/?=
 =?us-ascii?Q?IULPo3XKadGSyb8OLQ4BX2jZcgZejmJ+tBnqnaTZe8rUGZx6+TbGL900CfhA?=
 =?us-ascii?Q?ABoiJwZKA6ghb8Zlt1pBi0oNvl92p2K0HcH9h1S/qdkK/D2dWSPqXCo/6mSo?=
 =?us-ascii?Q?H870T8TNGZKdIL7r+43ODrwghHbNzaj3NMFD9Sw2EaZvwiCdZiKGdYJdvzXy?=
 =?us-ascii?Q?ugerYiVB0N6gEiLBcY6ND4fM6BLde9/pflJ9hewdpqoRhF5zsOTKwDU/3Qo0?=
 =?us-ascii?Q?BwA/J6SeHm3TVxS15cHHVA5e436aqqxmrw6YJnGHJZj3DVVGdFpB0YQlIkhq?=
 =?us-ascii?Q?F/PvTp13U19I2qNIHL9SiXxZcQUZGR7sPWMEuigb7j/oK9+P/BZVfnmU3kTk?=
 =?us-ascii?Q?11YNbyXnpFhqZ954rJsZFmi8/6XvxO+LPJNRXrEZOc5xTjT/++BzJV9/Nx6M?=
 =?us-ascii?Q?88b/8ikv+2hjCsvrm0suEGO246cG0fxOBAlR+SmF0Nw2vvRnLkhE7kNWzovY?=
 =?us-ascii?Q?66bcbzWwdGyoqLOALVxRVdaUB2ad8Kq5xzZx1oLtLxiKn5zU0p2IEavpY6m+?=
 =?us-ascii?Q?ix5cMWIeArR/jBbONLTaxXh5eLJfQHkPmFUI+VUl0+6bHazdVzcRHGYCFLd5?=
 =?us-ascii?Q?EsIwtb+kiGDHdvvb9emJxBEnMcNAtvayDrp9Nlk7TsEloxO3Sf/BP14ZaZF3?=
 =?us-ascii?Q?aTZxR8KdGVWt2t2R4aQk2/QGMr6swrhaMXe6Xe2XH87pv0NUUAI7cTKl8ULN?=
 =?us-ascii?Q?eiNe0tRh9SesGw7HJ7+sNEsXZNDp7PP7Fv9jxbWhodhWzZv5st17waoAtDgg?=
 =?us-ascii?Q?qWpPywZ1/rwEp6OkhaNJS5Q0GHkQIYGmjljju5OSltagqDDwYDUVtR9UqAxp?=
 =?us-ascii?Q?Y4LA1P7eAsvPTG0lRvUu91sCFjU8N+G7K2ajN0y3kaQOTj4giK0lASv3ox6W?=
 =?us-ascii?Q?jBtLY1f0HYE/thcRrqcDt3LbDjpG2ssbYFBIUqfST+B/VGlMqLL3+C/uVpPe?=
 =?us-ascii?Q?1NQMQHJsDK7s+J7FmzrLnPgljLhY/UzLOGIVy5TTy89EdLGB5pJZy99fXAxu?=
 =?us-ascii?Q?LPKtFI1nRzGaYIUcQjokB9aXPr7beVU8Sf81AdswzwFV+2fT3aFiShDJSHoL?=
 =?us-ascii?Q?L4L+SyfW5IX8WO2mVhdiHf7y0JGP7UbBmN6nhJyhJI0qtYVPUxGUkdWz/INR?=
 =?us-ascii?Q?TPbZCp3yUPVKuNMVo+hKXJ5nErW9wYE67l95UEmJDlpYxFnlh2g2?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 286b5ed5-7356-446c-5591-08de90a66305
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:55:43.4957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+5HNnJpIHtacTAIFCqK0UNyVpUnhXry3GhPsA6Nz4mTDEbvTs7+N9sDyPW7HNJShHn1ZsLgaYh3MYKOcv4Iq/V0gjlFTgscxTtB38PXB214YCW20DQpm2M2wZBLeRNr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB0951
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274468-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.916];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,canonical.com:email,starfivetech.com:email,starfivetech.com:mid]
X-Rspamd-Queue-Id: 76C193880E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sia Jee Heng <jeeheng.sia@starfivetech.com>

Function names that consist of the 'jh71x0' naming convention are
renamed to use the 'starfive' wording.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../clk/starfive/clk-starfive-jh7110-sys.c    |  4 +-
 .../reset/starfive/reset-starfive-common.c    | 64 +++++++++----------
 .../reset/starfive/reset-starfive-common.h    |  8 +--
 .../reset/starfive/reset-starfive-jh7100.c    |  2 +-
 .../reset/starfive/reset-starfive-jh7110.c    |  4 +-
 include/soc/starfive/reset-starfive-common.h  |  6 +-
 6 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index edf4c45e6ff0..17fd061ee196 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -334,7 +334,7 @@ static void jh7110_reset_unregister_adev(void *_adev)
 static void jh7110_reset_adev_release(struct device *dev)
 {
 	struct auxiliary_device *adev = to_auxiliary_dev(dev);
-	struct jh71x0_reset_adev *rdev = to_jh71x0_reset_adev(adev);
+	struct starfive_reset_adev *rdev = to_starfive_reset_adev(adev);
 
 	kfree(rdev);
 }
@@ -343,7 +343,7 @@ int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
 				     const char *adev_name,
 				     u32 adev_id)
 {
-	struct jh71x0_reset_adev *rdev;
+	struct starfive_reset_adev *rdev;
 	struct auxiliary_device *adev;
 	int ret;
 
diff --git a/drivers/reset/starfive/reset-starfive-common.c b/drivers/reset/starfive/reset-starfive-common.c
index d615c4a68cc0..772bdf6763d1 100644
--- a/drivers/reset/starfive/reset-starfive-common.c
+++ b/drivers/reset/starfive/reset-starfive-common.c
@@ -14,7 +14,7 @@
 
 #include "reset-starfive-common.h"
 
-struct jh71x0_reset {
+struct starfive_reset {
 	struct reset_controller_dev rcdev;
 	/* protect registers against concurrent read-modify-write */
 	spinlock_t lock;
@@ -23,16 +23,16 @@ struct jh71x0_reset {
 	const u32 *asserted;
 };
 
-static inline struct jh71x0_reset *
-jh71x0_reset_from(struct reset_controller_dev *rcdev)
+static inline struct starfive_reset *
+starfive_reset_from(struct reset_controller_dev *rcdev)
 {
-	return container_of(rcdev, struct jh71x0_reset, rcdev);
+	return container_of(rcdev, struct starfive_reset, rcdev);
 }
 
-static int jh71x0_reset_update(struct reset_controller_dev *rcdev,
-			       unsigned long id, bool assert)
+static int starfive_reset_update(struct reset_controller_dev *rcdev,
+				 unsigned long id, bool assert)
 {
-	struct jh71x0_reset *data = jh71x0_reset_from(rcdev);
+	struct starfive_reset *data = starfive_reset_from(rcdev);
 	unsigned long offset = id / 32;
 	u32 mask = BIT(id % 32);
 	void __iomem *reg_assert = data->assert + offset * sizeof(u32);
@@ -61,34 +61,34 @@ static int jh71x0_reset_update(struct reset_controller_dev *rcdev,
 	return ret;
 }
 
-static int jh71x0_reset_assert(struct reset_controller_dev *rcdev,
-			       unsigned long id)
+static int starfive_reset_assert(struct reset_controller_dev *rcdev,
+				 unsigned long id)
 {
-	return jh71x0_reset_update(rcdev, id, true);
+	return starfive_reset_update(rcdev, id, true);
 }
 
-static int jh71x0_reset_deassert(struct reset_controller_dev *rcdev,
-				 unsigned long id)
+static int starfive_reset_deassert(struct reset_controller_dev *rcdev,
+				   unsigned long id)
 {
-	return jh71x0_reset_update(rcdev, id, false);
+	return starfive_reset_update(rcdev, id, false);
 }
 
-static int jh71x0_reset_reset(struct reset_controller_dev *rcdev,
-			      unsigned long id)
+static int starfive_reset_reset(struct reset_controller_dev *rcdev,
+				unsigned long id)
 {
 	int ret;
 
-	ret = jh71x0_reset_assert(rcdev, id);
+	ret = starfive_reset_assert(rcdev, id);
 	if (ret)
 		return ret;
 
-	return jh71x0_reset_deassert(rcdev, id);
+	return starfive_reset_deassert(rcdev, id);
 }
 
-static int jh71x0_reset_status(struct reset_controller_dev *rcdev,
-			       unsigned long id)
+static int starfive_reset_status(struct reset_controller_dev *rcdev,
+				 unsigned long id)
 {
-	struct jh71x0_reset *data = jh71x0_reset_from(rcdev);
+	struct starfive_reset *data = starfive_reset_from(rcdev);
 	unsigned long offset = id / 32;
 	u32 mask = BIT(id % 32);
 	void __iomem *reg_status = data->status + offset * sizeof(u32);
@@ -100,25 +100,25 @@ static int jh71x0_reset_status(struct reset_controller_dev *rcdev,
 	return !((value ^ data->asserted[offset]) & mask);
 }
 
-static const struct reset_control_ops jh71x0_reset_ops = {
-	.assert		= jh71x0_reset_assert,
-	.deassert	= jh71x0_reset_deassert,
-	.reset		= jh71x0_reset_reset,
-	.status		= jh71x0_reset_status,
+static const struct reset_control_ops starfive_reset_ops = {
+	.assert		= starfive_reset_assert,
+	.deassert	= starfive_reset_deassert,
+	.reset		= starfive_reset_reset,
+	.status		= starfive_reset_status,
 };
 
-int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_node,
-				   void __iomem *assert, void __iomem *status,
-				   const u32 *asserted, unsigned int nr_resets,
-				   struct module *owner)
+int reset_starfive_register(struct device *dev, struct device_node *of_node,
+			    void __iomem *assert, void __iomem *status,
+			    const u32 *asserted, unsigned int nr_resets,
+			    struct module *owner)
 {
-	struct jh71x0_reset *data;
+	struct starfive_reset *data;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->rcdev.ops = &jh71x0_reset_ops;
+	data->rcdev.ops = &starfive_reset_ops;
 	data->rcdev.owner = owner;
 	data->rcdev.nr_resets = nr_resets;
 	data->rcdev.dev = dev;
@@ -131,4 +131,4 @@ int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_no
 
 	return devm_reset_controller_register(dev, &data->rcdev);
 }
-EXPORT_SYMBOL_GPL(reset_starfive_jh71x0_register);
+EXPORT_SYMBOL_GPL(reset_starfive_register);
diff --git a/drivers/reset/starfive/reset-starfive-common.h b/drivers/reset/starfive/reset-starfive-common.h
index 266acc4b2caf..83461b22ee55 100644
--- a/drivers/reset/starfive/reset-starfive-common.h
+++ b/drivers/reset/starfive/reset-starfive-common.h
@@ -6,9 +6,9 @@
 #ifndef __RESET_STARFIVE_COMMON_H
 #define __RESET_STARFIVE_COMMON_H
 
-int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_node,
-				   void __iomem *assert, void __iomem *status,
-				   const u32 *asserted, unsigned int nr_resets,
-				   struct module *owner);
+int reset_starfive_register(struct device *dev, struct device_node *of_node,
+			    void __iomem *assert, void __iomem *status,
+			    const u32 *asserted, unsigned int nr_resets,
+			    struct module *owner);
 
 #endif /* __RESET_STARFIVE_COMMON_H */
diff --git a/drivers/reset/starfive/reset-starfive-jh7100.c b/drivers/reset/starfive/reset-starfive-jh7100.c
index 546dea2e5811..122ac6c3893b 100644
--- a/drivers/reset/starfive/reset-starfive-jh7100.c
+++ b/drivers/reset/starfive/reset-starfive-jh7100.c
@@ -51,7 +51,7 @@ static int __init jh7100_reset_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	return reset_starfive_jh71x0_register(&pdev->dev, pdev->dev.of_node,
+	return reset_starfive_register(&pdev->dev, pdev->dev.of_node,
 					      base + JH7100_RESET_ASSERT0,
 					      base + JH7100_RESET_STATUS0,
 					      jh7100_reset_asserted,
diff --git a/drivers/reset/starfive/reset-starfive-jh7110.c b/drivers/reset/starfive/reset-starfive-jh7110.c
index 87dba01491ae..c4dd21761e53 100644
--- a/drivers/reset/starfive/reset-starfive-jh7110.c
+++ b/drivers/reset/starfive/reset-starfive-jh7110.c
@@ -53,13 +53,13 @@ static int jh7110_reset_probe(struct auxiliary_device *adev,
 			      const struct auxiliary_device_id *id)
 {
 	struct jh7110_reset_info *info = (struct jh7110_reset_info *)(id->driver_data);
-	struct jh71x0_reset_adev *rdev = to_jh71x0_reset_adev(adev);
+	struct starfive_reset_adev *rdev = to_starfive_reset_adev(adev);
 	void __iomem *base = rdev->base;
 
 	if (!info || !base)
 		return -ENODEV;
 
-	return reset_starfive_jh71x0_register(&adev->dev, adev->dev.parent->of_node,
+	return reset_starfive_register(&adev->dev, adev->dev.parent->of_node,
 					      base + info->assert_offset,
 					      base + info->status_offset,
 					      NULL,
diff --git a/include/soc/starfive/reset-starfive-common.h b/include/soc/starfive/reset-starfive-common.h
index 56d8f413cf18..16df46a074bc 100644
--- a/include/soc/starfive/reset-starfive-common.h
+++ b/include/soc/starfive/reset-starfive-common.h
@@ -6,12 +6,12 @@
 #include <linux/compiler_types.h>
 #include <linux/container_of.h>
 
-struct jh71x0_reset_adev {
+struct starfive_reset_adev {
 	void __iomem *base;
 	struct auxiliary_device adev;
 };
 
-#define to_jh71x0_reset_adev(_adev) \
-	container_of((_adev), struct jh71x0_reset_adev, adev)
+#define to_starfive_reset_adev(_adev) \
+	container_of((_adev), struct starfive_reset_adev, adev)
 
 #endif
-- 
2.25.1


