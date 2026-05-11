Return-Path: <netdev+bounces-286704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFokFe3xAWpfmgEAu9opvQ
	(envelope-from <netdev+bounces-286704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:12:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B22510EB9
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2ED3730F4E39
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D442FB965;
	Mon, 11 May 2026 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ken5V7n7"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013028.outbound.protection.outlook.com [52.101.72.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0F22820AC;
	Mon, 11 May 2026 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511653; cv=fail; b=GYoYBak5nrVhGvhMoRulzdY61SHzZ4sED+Tlz6EH07X3jIavu6edqZBYK4MvgkAuKgVzZjaYDZIRrBNNE4mqV2Sbg4s4tJH5rsikVkQc7XWE9E/H+kp8JEIv7RKBKCDonSDc1ySqzU4V2U+XUwNQjg86zIoCrARSKpb6389Ku2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511653; c=relaxed/simple;
	bh=boMYKeB0AljesexDLRI5Q5RSVGQ6JNiRUjNwxv0ZHhY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OS2sqEnW7/uyVNfmxFDaSiG+CosO2giwbXNa/cljPMc96d2zGBgOhoPEUnQpp7W+0w9IT0bPabfdZwXUSUo3TQD40a1f7AC30eCBTUbeVD38F/fDnUi2P49l5ejMd3oGigll+l/O0qe82jLMINZUiBgavOafrf5Z9mets8zzAIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ken5V7n7; arc=fail smtp.client-ip=52.101.72.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPYwmbtD5p3Gjx2AnI/T9Enpmsyr8ze35GKpdnbRZ8Zgts5GIIvrinHR394VLebn7d6gIyJ8radKLi9glvIW/Cu6h7e/qNlgYMdyRhStE4YYFFxI7K3pLl7X4LQWEzYDTKbX/ti0RInHT9j/5RHCOuHpI4zZ8G/Uee0LEBnJmhIyiud9g+QxLvp7Km5kGPTc+LcfjAdBsiADFwOleLHV7GjYXtCQtUt098igY6jvNpC2aLfeYMh7b6r4NSBEVOfKdWnw8Ro4/gMj7sjE3PUQ/7Hq9fmt1nvR0rwSMX81J/+quhktFFt13sbKzRV2a4nQ6fidugkA1Lp1l538gjEB6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t40qYh/t44bcFs+prRyKspRg2TEnuCwOcw9PBVH7ytg=;
 b=Eb3dZ2WIB9O4pENkdIDHMmpzTT3aWGt0y/ZLVgyTFf8VuAt628ugw9UOyQja1QhMIU7brimU9NwmzCMnacqux/U7NABrdDSAUYyYlwWvCO+pLtAxYGJz1RzVAoPkiNVRrZJuhRbpGVHAuBIQi3RnKVBCgpFKbGf1wD1yHigjAEZTxRX7xpBxZMhBPGzsWiSQirrRwd/MAi4a/xhhNK0G8L/fpTbk7iE1OrAOekTWpSGD0U1XGwMQvbSxHSIDh+fq1NKOE9XOdvB5jBmhpemH+VjJvDMUeFPx1Jz3EkFd0deT0qj2yS3Tp7RgJutOV3Z/kuSQj46KeRypC9tt4CSDmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t40qYh/t44bcFs+prRyKspRg2TEnuCwOcw9PBVH7ytg=;
 b=ken5V7n7hKYZWYlXsGPbQTUhne0gs3s335pIX19MZx2kskh+yV4HIfwfFzPt/ApHZSAJuqw5iqS57YurQig7+FsyDi1nEo9wSbZ+oFtGNUc9FF6Zr8EakBhdSaODTAlBk47tK6qO9GGw01S+zddylMNtcpYHYwEU7cLoGKaYbQqZdBxgsCs0QIAayRV6U6JPCE7Sri7k9JoqU1mtxMpUw35idgSVLy69os/vqp9phCAoL9LPMLPSPGkqHpNzDDl+mLvJnIxsfhnsrML4x2+hOEYED8v/OiId34+jO+LwUULefZ5TPcldDoLh4kUa5fK7C0ZYDtdnA+zhmF/29mzZ3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GVXPR04MB9976.eurprd04.prod.outlook.com (2603:10a6:150:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 15:00:44 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Mon, 11 May 2026
 15:00:44 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH phy-next 5/5] phy: lynx-28g: add support for 25GBASER
Date: Mon, 11 May 2026 18:00:23 +0300
Message-Id: <20260511150023.1903577-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511150023.1903577-1-vladimir.oltean@nxp.com>
References: <20260511150023.1903577-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0033.eurprd03.prod.outlook.com
 (2603:10a6:205:2::46) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GVXPR04MB9976:EE_
X-MS-Office365-Filtering-Correlation-Id: 923e7e3d-8da8-4651-d649-08deaf6e13c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|3023799003|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VKUH03+eLtiR/Oc/RN6VR/RxzcRZ58vUTTfkii15FJ+LUnNaLTC8y68gibySSJ3r6pOTZezmjNwScURBPYuXzrzjtXRpLJteLotbYU3ir3bQunDr0fniKPY+t3TjFnM2c31MyWy5K9oPnhHy7bISzIc7KVPBpTEfyjxs27rQ8ENMZj6WO9GerwrdSD0vmphkTNVxlbFLhFNndO34nO/X265IajGSN/mxNDQOfDd4Gmr6/6XZ+nQnjyKWxyzC2d0xIV91ZZ5c6PvyJb4HdrxaMqTNjPphqTzGRmBquNuslwi56RaofeA+3fW0o9331MwjfFLRxABx60pc4PTb9hH69SPxN3tzQ7yd/wWp0rjaPkZc2yeQfNKaZM7gAe+I4hkyYULfAym4ZEl4fnvu+u+0HUvTDHdyNQspDzBOjNbdtt0c6gOs8qVtpXkVc/xZE9q8YIKUcaPoTuwyxSdKwypz7mC7Ti6PdG+L3496wKYEiWeDIwiym1zV60h3zidzaYlbnjzWfxXho7tPvZs16/F9bCwIpt0a8zlwe1YcBH+A2SEzer4e7SzRwEp51alr8wQBeiZJWUF3fykOuGHQMAYuib8KLzvTRn3fpcBya4k7lec5P3J7WqaaOb4psC9FjKGb3MxLvYeLZTDLETKgCKNbt3oMQhZaipm7mVmJ2B6Bgz8jTQiWk7ogX4EK+ScFPNSf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(3023799003)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ULHsjnGNbUs1zBR4xKYGWVRnPxC65ahNnVN+lTDO+CjBXED/E3NrnbyjK5/q?=
 =?us-ascii?Q?4UOR/l/N8DyfemRKBCGhDMVVyJpkVLs0MO5yYVANIZVWngDMKBAbEqotzJGi?=
 =?us-ascii?Q?wuGHUSyzoeK3/EhVidjLFR7FDUVdZH4cUImF5A1lV2mJTvBwMRXJPVBagaKd?=
 =?us-ascii?Q?yEVjE9MW45CTvoKyhenCVHtjkZv5VzCBr1ZaUjc7i7kJXL7zlK7BXfMVIwYn?=
 =?us-ascii?Q?ARzxjpKJzGIO8HqqECgmca2tgCxK4zKO24K0WX9r/eAHvXCB0Sx58WyeaLGz?=
 =?us-ascii?Q?Yj7kSKKj8VQz8UYTUump4nKRs8vDg/t3X4sQUBoGTcQrXFCZ0jAHfVfFt8nf?=
 =?us-ascii?Q?BPUv9vmwgKyUtCOzQNOjlkamVHqVZ8LQb46iJJtp1wyaYeiJGReuudCg6Inz?=
 =?us-ascii?Q?hdHIkYiqS/pUL2dFeaUrmwQ97hiXd1+boqhCkoGNOExBw01IEStZBhkF6hOb?=
 =?us-ascii?Q?hVFNuV3ubGqkSzEOY4Wk5W990ea0PrVlh5QxKSOqhHmyIy/PFXBc+0VmL9ae?=
 =?us-ascii?Q?ghYPTbNVc1O0wtA6Fw3K78z1KLe90FavZbPpmXyh9Oa51gP2zMSO7rDKMtZb?=
 =?us-ascii?Q?47RnEsQANW1DAnZA16rz+WC3qXEuwcSIe3mqAddCOfAiwTmEKcFHE+sCyCcX?=
 =?us-ascii?Q?RUVR69OAx7xyRg4hhZTlKGGZXq7d9ExySkA607J6feBmT7GwV0omQzTDp/ft?=
 =?us-ascii?Q?y/K63UQs7EWoA44gJ38Rmd2frv4ityOskOZOKgRoNnUO0xzqpvSDKdHq8Fyt?=
 =?us-ascii?Q?aS1d5U0hO5deh3/BqvXFYsFl009tR+uQi3vPVz81L5zXRq16o5GpG6/UZV3o?=
 =?us-ascii?Q?6dQeNfy+hgjIeTjgkYAsViUxad2zPbZNTf0yfEU8vQf9B31k6XD1B1xZihe1?=
 =?us-ascii?Q?LhD4G/7EjAzAwayWw/WSjH2iV8hFyJyNL+hJ6ieqhgKUFQkeSByPYKIvmb8h?=
 =?us-ascii?Q?TH139p2t7e6CFrhk7U8jjh0j29FEVivnq8qCqn6N66wrWvP+w9EkOQu4RVSe?=
 =?us-ascii?Q?MQanEI5V7U6iBb2IjGZLnamqDtiVeRMqXX6tel6QXEY/vgK0/3wAIodhmyLl?=
 =?us-ascii?Q?O7L0vthEwz0OISdoTivkFOZ1f/H+4X+fJ6sb30gc0DkWMaSH5cMYWPpTSNjV?=
 =?us-ascii?Q?nCOjTx9VK+SqZVQIwRBR+aMTeY9Z48gWsd8koRZ+oCetqDiyC44RLKK6KiWg?=
 =?us-ascii?Q?a6vh8NjH0Y2BGbXVV54rGNxEvrOaQazhUSIPBD21g7rBMpYepOboYAXtamR4?=
 =?us-ascii?Q?DORJEcz0dvERyeYskPNOqxJBL3U3IdVBIKEnKn5xlL7v5M8QVmQZv2VctfwN?=
 =?us-ascii?Q?hWlp8oRoQKLTTun9QFkiZsZcXvIC/secjip/+k4Koeglo2eXMcM7GR1aKjlP?=
 =?us-ascii?Q?r8V0S8E6JtbpGvcheCQT8hzBH05bSH+wmedLrgcXxadOjUK2iQWXJ8QQw7jX?=
 =?us-ascii?Q?J8c6Bdx3CFCJs92eEP/DdYpZq1WVOtkRHZ6sRt+VEQ5pqaD1eCHhb1T4mX7e?=
 =?us-ascii?Q?SxGOoEF0Ojq2GYHOnMMuv0fsFjOW5bobJXeF+JfcudbvR0nPvg6AvgwthRqd?=
 =?us-ascii?Q?gXGV7sSYUP0ta29iInla+WpeH5UlIWzTrpa8AEA1sRJcBw67ZGx8Gj3s8L9d?=
 =?us-ascii?Q?9X/dyqKr4MCMgDP6vsvRgqO+MMx6tpJziJ0Zk2Zau+pbzsXry21PjXtfdNxq?=
 =?us-ascii?Q?vSYyrvR779xH6NVPVxZXsW6nr59y1pgpRHPLnQi6x5kQCcUymvahWs9oG+xl?=
 =?us-ascii?Q?pSAjFLr5ew=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923e7e3d-8da8-4651-d649-08deaf6e13c1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 15:00:44.7537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjzRqRRfufL5VC8LXaGJMq0XUVaLRpJzihLV9k0rSoWdrcP6fW430RjvL6Wx2uilvQ7ffavrWXxC8WXb9Y1N1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9976
X-Rspamd-Queue-Id: C6B22510EB9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286704-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Add support for 25GBASE-R in the Lynx 28G SerDes PHY driver. This will
be used by the dpaa2-mac consumer on LX2160A with:
- phy_validate(phy, PHY_MODE_ETHERNET, PHY_INTERFACE_MODE_25GBASER) to
  detect support.
- phy_set_mode_ext(phy, PHY_MODE_ETHERNET, PHY_INTERFACE_MODE_25GBASER)
  to reconfigure the lane for this protocol.

The intended use case for dynamic protocol switching to 25GBase-R is
with SFP28 modules, and protocol switching is triggered by the SFP
module insertion. There also exists a 25GBase-KR use case, where the
protocol switching is covered by IEEE 802.3 clause 73 auto-negotiation.
However, that is not handled here; it merely needs the support added
here as basic ground work.

The lane frequency for 25GbE is sourced from a clock net frequency of
12.890625 GHz, as produced by PLLF or PLLS, further multiplied by the
lane by 2. The clock net frequencies produced by the PLLs are treated as
read-only by the driver, so the absence of a PLL provisioned for the
right clock net frequency implies absence of 25GbE support, even though
a lane might have the appropriate protocol converter for it.

In terms of implementation, the change consists of:
- determining at probe time if any PLL was preconfigured for the
  required clock net frequency for 25GbE
- adding the default lane parameters for reconfiguring a lane to 25GbE
  irrespective of the original protocol
- allowing this operating mode only on supported lanes, i.e. all lanes
  of LX2162A SerDes #1, and LX2160A SerDes lanes 0-1, 4-7.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Change previously submitted at:
https://lore.kernel.org/linux-phy/20260114152111.625350-6-vladimir.oltean@nxp.com/

Changes:
- reword commit message
---
 drivers/phy/freescale/phy-fsl-lynx-28g.c | 90 +++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 5eddc2723e78..92bfc5f65e0b 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -57,6 +57,7 @@
 #define PLLnCR1_FRATE_5G_10GVCO			0x0
 #define PLLnCR1_FRATE_5G_25GVCO			0x10
 #define PLLnCR1_FRATE_10G_20GVCO		0x6
+#define PLLnCR1_FRATE_12G_25GVCO		0x16
 
 /* Per SerDes lane registers */
 /* Lane a General Control Register */
@@ -64,9 +65,11 @@
 #define LNaGCR0_PROTO_SEL			GENMASK(7, 3)
 #define LNaGCR0_PROTO_SEL_SGMII			0x1
 #define LNaGCR0_PROTO_SEL_XFI			0xa
+#define LNaGCR0_PROTO_SEL_25G			0x1a
 #define LNaGCR0_IF_WIDTH			GENMASK(2, 0)
 #define LNaGCR0_IF_WIDTH_10_BIT			0x0
 #define LNaGCR0_IF_WIDTH_20_BIT			0x2
+#define LNaGCR0_IF_WIDTH_40_BIT			0x4
 
 /* Lane a Tx Reset Control Register */
 #define LNaTRSTCTL(lane)			(0x800 + (lane) * 0x100 + 0x20)
@@ -85,6 +88,7 @@
 #define LNaTGCR0_N_RATE_FULL			0x0
 #define LNaTGCR0_N_RATE_HALF			0x1
 #define LNaTGCR0_N_RATE_QUARTER			0x2
+#define LNaTGCR0_N_RATE_DOUBLE			0x3
 
 #define LNaTECR0(lane)				(0x800 + (lane) * 0x100 + 0x30)
 #define LNaTECR0_EQ_TYPE			GENMASK(30, 28)
@@ -116,6 +120,7 @@
 #define LNaRGCR0_N_RATE_FULL			0x0
 #define LNaRGCR0_N_RATE_HALF			0x1
 #define LNaRGCR0_N_RATE_QUARTER			0x2
+#define LNaRGCR0_N_RATE_DOUBLE			0x3
 
 #define LNaRGCR1(lane)				(0x800 + (lane) * 0x100 + 0x48)
 #define LNaRGCR1_RX_ORD_ELECIDLE		BIT(31)
@@ -282,6 +287,7 @@ enum lynx_lane_mode {
 	LANE_MODE_1000BASEX_SGMII,
 	LANE_MODE_10GBASER,
 	LANE_MODE_USXGMII,
+	LANE_MODE_25GBASER,
 	LANE_MODE_MAX,
 };
 
@@ -420,6 +426,41 @@ static const struct lynx_28g_proto_conf lynx_28g_proto_conf[LANE_MODE_MAX] = {
 		.ttlcr0 = LNaTTLCR0_TTL_SLO_PM_BYP |
 			  LNaTTLCR0_DATA_IN_SSC,
 	},
+	[LANE_MODE_25GBASER] = {
+		.proto_sel = LNaGCR0_PROTO_SEL_25G,
+		.if_width = LNaGCR0_IF_WIDTH_40_BIT,
+		.teq_type = EQ_TYPE_3TAP,
+		.sgn_preq = 1,
+		.ratio_preq = 2,
+		.sgn_post1q = 1,
+		.ratio_post1q = 7,
+		.amp_red = 0,
+		.adpt_eq = 48,
+		.enter_idle_flt_sel = 0,
+		.exit_idle_flt_sel = 0,
+		.data_lost_th_sel = 0,
+		.gk2ovd = 0,
+		.gk3ovd = 0,
+		.gk4ovd = 5,
+		.gk2ovd_en = 0,
+		.gk3ovd_en = 0,
+		.gk4ovd_en = 1,
+		.eq_offset_ovd = 0x1f,
+		.eq_offset_ovd_en = 0,
+		.eq_offset_rng_dbl = 1,
+		.eq_blw_sel = 1,
+		.eq_boost = 2,
+		.spare_in = 3,
+		.smp_autoz_d1r = 2,
+		.smp_autoz_eg1r = 2,
+		.rccr0 = LNaRCCR0_CAL_EN |
+			 LNaRCCR0_CAL_DC3_DIS |
+			 LNaRCCR0_CAL_DC2_DIS |
+			 LNaRCCR0_CAL_DC1_DIS |
+			 LNaRCCR0_CAL_DC0_DIS,
+		.ttlcr0 = LNaTTLCR0_DATA_IN_SSC |
+			  FIELD_PREP_CONST(LNaTTLCR0_CDR_MIN_SMP_ON, 1),
+	},
 };
 
 struct lynx_pccr {
@@ -499,6 +540,8 @@ static const char *lynx_lane_mode_str(enum lynx_lane_mode lane_mode)
 		return "10GBase-R";
 	case LANE_MODE_USXGMII:
 		return "USXGMII";
+	case LANE_MODE_25GBASER:
+		return "25GBase-R";
 	default:
 		return "unknown";
 	}
@@ -514,6 +557,8 @@ static enum lynx_lane_mode phy_interface_to_lane_mode(phy_interface_t intf)
 		return LANE_MODE_10GBASER;
 	case PHY_INTERFACE_MODE_USXGMII:
 		return LANE_MODE_USXGMII;
+	case PHY_INTERFACE_MODE_25GBASER:
+		return LANE_MODE_25GBASER;
 	default:
 		return LANE_MODE_UNKNOWN;
 	}
@@ -601,6 +646,20 @@ static void lynx_28g_lane_set_nrate(struct lynx_28g_lane *lane,
 			break;
 		}
 		break;
+	case PLLnCR1_FRATE_12G_25GVCO:
+		switch (lane_mode) {
+		case LANE_MODE_25GBASER:
+			lynx_28g_lane_rmw(lane, LNaTGCR0,
+					  FIELD_PREP(LNaTGCR0_N_RATE, LNaTGCR0_N_RATE_DOUBLE),
+					  LNaTGCR0_N_RATE);
+			lynx_28g_lane_rmw(lane, LNaRGCR0,
+					  FIELD_PREP(LNaRGCR0_N_RATE, LNaRGCR0_N_RATE_DOUBLE),
+					  LNaRGCR0_N_RATE);
+			break;
+		default:
+			break;
+		}
+		break;
 	default:
 		break;
 	}
@@ -761,6 +820,11 @@ static int lynx_28g_power_on(struct phy *phy)
 	return 0;
 }
 
+static int lynx_28g_e25g_pcvt(int lane)
+{
+	return 7 - lane;
+}
+
 static int lynx_28g_get_pccr(enum lynx_lane_mode lane_mode, int lane,
 			     struct lynx_pccr *pccr)
 {
@@ -776,6 +840,11 @@ static int lynx_28g_get_pccr(enum lynx_lane_mode lane_mode, int lane,
 		pccr->width = 4;
 		pccr->shift = SXGMII_CFG(lane);
 		break;
+	case LANE_MODE_25GBASER:
+		pccr->offset = PCCD;
+		pccr->width = 4;
+		pccr->shift = E25G_CFG(lynx_28g_e25g_pcvt(lane));
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -791,6 +860,8 @@ static int lynx_28g_get_pcvt_offset(int lane, enum lynx_lane_mode lane_mode)
 	case LANE_MODE_USXGMII:
 	case LANE_MODE_10GBASER:
 		return SXGMIIaCR0(lane);
+	case LANE_MODE_25GBASER:
+		return E25GaCR0(lynx_28g_e25g_pcvt(lane));
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -799,7 +870,12 @@ static int lynx_28g_get_pcvt_offset(int lane, enum lynx_lane_mode lane_mode)
 static bool lx2160a_serdes1_lane_supports_mode(int lane,
 					       enum lynx_lane_mode mode)
 {
-	return true;
+	switch (mode) {
+	case LANE_MODE_25GBASER:
+		return lane != 2 && lane != 3;
+	default:
+		return true;
+	}
 }
 
 static bool lx2160a_serdes2_lane_supports_mode(int lane,
@@ -1115,6 +1191,9 @@ static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
 	case LANE_MODE_USXGMII:
 		val |= PCCC_SXGMIIn_CFG;
 		break;
+	case LANE_MODE_25GBASER:
+		val |= PCCD_E25Gn_CFG;
+		break;
 	default:
 		break;
 	}
@@ -1259,8 +1338,12 @@ static void lynx_28g_pll_read_configuration(struct lynx_28g_priv *priv)
 			__set_bit(LANE_MODE_10GBASER, pll->supported);
 			__set_bit(LANE_MODE_USXGMII, pll->supported);
 			break;
+		case PLLnCR1_FRATE_12G_25GVCO:
+			/* 12.890625GHz clock net */
+			__set_bit(LANE_MODE_25GBASER, pll->supported);
+			break;
 		default:
-			/* 6GHz, 12.890625GHz, 8GHz */
+			/* 6GHz, 8GHz */
 			break;
 		}
 	}
@@ -1327,6 +1410,9 @@ static void lynx_28g_lane_read_configuration(struct lynx_28g_lane *lane)
 		else
 			lane->mode = LANE_MODE_USXGMII;
 		break;
+	case LNaPSS_TYPE_25G:
+		lane->mode = LANE_MODE_25GBASER;
+		break;
 	default:
 		lane->mode = LANE_MODE_UNKNOWN;
 	}
-- 
2.34.1


