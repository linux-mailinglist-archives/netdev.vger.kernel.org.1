Return-Path: <netdev+bounces-270133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOSUMRnxvWlkEAMAu9opvQ
	(envelope-from <netdev+bounces-270133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:15:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C74932E2BEC
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C53C03009F1A
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3706B28B7DA;
	Sat, 21 Mar 2026 01:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LCppQ+Xc"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013063.outbound.protection.outlook.com [40.107.162.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5AA225417;
	Sat, 21 Mar 2026 01:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774055699; cv=fail; b=ZbRMH+1IkkQ+mDa7F/TnikI3ypFbmfnyH3jTYQGsTAsTyIjcGEEAku/C9sPQhJQWBNh77mEVfQoib/3a1K3JCfq3lvnAwE4D0gNv6/NERJHsypU0/qCECeVx16/QrhrZiFpl35ch2ylXyhh7u6QJyOoFYIP5O3rJO7bEQkVKWug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774055699; c=relaxed/simple;
	bh=1p+YRWfmFFemmDUH56uUsTEB4wfaQpBL2KC0lMd7gjo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fhp1VwOWnGEPgfDZluXsy6lJ+ChkU35Mj//LI9/Onda6eeHzIP3/PzmoPjzcPmEkShCJpsYLDivzEnxUVM6wBet28moehsOmA04hi9Cl1hznXjRYU6lGrHp1+X8p3VW2jRIhkMY2+CbkDpWmjc+oSk6ELK5h+YcAt6825Dgrr6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LCppQ+Xc; arc=fail smtp.client-ip=40.107.162.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prJikQqQYHtclCLBTEZCgsq4WpuaJ5APNkTiia4WUd4mh5Wq66NfHUwOXaKX35ZeZeppjXd6+erU/fQTR6us4iGx16vTqdGMOG9P+FAbCTTyT1sjJvqT3TUQABY7tdSindQt5bPVBE9kTGmCQv9qShWjqxmHYK6lzDBpHJA+/nsstbtRtL9zuGkpSLgZOGvsTk3z0ZSBO4EwiS7Du/FkaJCQccRdjkI5xQgJ+u6gGJ0jCmon0FRt/Pcs0xTHpWJBPo36XktQ+zrrfT0hQfM7LTUeOMjqtzPq6mfWIrjBPdE+bXe/0l6xtdW1jonC+jPpbG/7kV1yYbsdlZvvKq/tng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0cMpv5CeALb2BGgrwQJtD78Tt3oAhU6GOp6WM/P1GA=;
 b=OkB28xeWZpCPTlazBcn/vLv143AAdqwZTVE2mDyR2ocWR4K8pp3zERyS1jfnNv9KA+KjFt3QYxvhYbYbTJ+JYoDgfKDzyaY1AxQKk1gYwp0J80IEFN9vTP5IbRhIxTc1tT7GV1ovdfN9eOLjgZdQbI2uxB9T1WzgcwZPg0uaXA4EGEQdWfw4C7zWo2pZWVNrndBXwRPZBBsSRj4MdE1hFnUkJGoXyYqle8HUEnczq0S8bzHgwFcBoJQvE2jthcCwQX3XS2dvk1YwTu6pRtBc4qTKzVPPSPUgY7B+Lbx4e0yl8/8e3rI7FIDf8KIMfcUmZqbtx9slOcF42EWBeEYQiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0cMpv5CeALb2BGgrwQJtD78Tt3oAhU6GOp6WM/P1GA=;
 b=LCppQ+XcaNewh+cZlmt5eHE8P11g1NbJghphI+N113zGLq6zw1rwha+YZplicPzq/TaMVhXqv6w9bigf+muaRmQyp9J/eOC5QSCzh8dL2lsBwkskBF3QdgrfSk4dy5aDK2257TXJ54z2WDiObhbWS+osHGBlfmcX6Kv1A/q6idos65MVSts2AjexATqNzRwaDAczw66Y+5DxHGnqRvr9odWVoPOUXNv1MIZQQ+Q3EbwG37NGRx/ZkxxCzCXxsSnWUiQF1mm5DtEoUOW6m7pjAaPIaHmOEBR20dut8NtkOpaWfLk3PYi4L8nP4ndkwgSayPEUUXTZrJlapPcVllakfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VE1PR04MB7360.eurprd04.prod.outlook.com (2603:10a6:800:1a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Sat, 21 Mar
 2026 01:14:38 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Sat, 21 Mar 2026
 01:14:39 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH phy-next 0/3] Lynx 28G: better init(), exit(), power_on(), power_off()
Date: Sat, 21 Mar 2026 03:14:48 +0200
Message-Id: <20260321011451.1557091-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0039.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::19) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VE1PR04MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b928a22-592b-4927-5cff-08de86e73929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|10070799003|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	z03rBMh5AehSO2fcf/cAP+h/D3UWEP4YF7OvzUziQTu9mHY4kZ0MWF7bI6+VPuirgnZeEcfTOgy75iOEvy3Qzds9jby1i6rxi7BlPUq+MyVF68H+7pbWNaqc7YlxQpDKw8WREPXt1nVkgMI7vFjloab+CpzPBIrgP9WdTptvwQao0IRNrsPg3OaPoc17SupcteaUmEBSdueRqSWkVsiOmY5EdL/mVohqmJWCFp9dp4DcssTwxVnf1apjSxYHcMcm8iYcb/Pi8Bqu157YV9FMpGETxQfDRZDHKJwTSF9y9XFDfJIGlCNKKbI9APrjcD6J9psDgD7QG9+uvXSYLdlotCnmdEefdkztqFRi7Fxamg4YdV/Q4QUf4UOC7CsBTCVpzap+IXwQXOZYTUqhtQHATbr882jaGdhIAGtAxZcMYrGNm94tzj0kP3dsNudkhmY1YSqBn7t5cSIqnVDZrPH6b9GeTsOfwc67I0WFF1SlmPJYcrdA8TUV/zHN27AUbvywUndN3ojXCVJUYFcj4vL0hanbxS5W5fK4oxdG9Ccp03XrIj9erf6Et6yU0Hbvwr46DAMsz5xrYON/wX5anXVDwZRKeM9sT9h8n1lH5LeOlznBAJcZqr6YAKahA6UfXm5+fV8YsZ+j3LwBEqAa1Ev9JHj7FIvQALTKPPXpvjQpoM9FtFNyqjYSDY6taJVCWpHEJXvzLfXSXxLWwSi+TwbGODtmTwvnoFL1CLovrneIOCQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(10070799003)(376014)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZJ7eToPnSph2l3PFx4HmCDmlSSon2kO++a4uDvLFNWHLFoUshj0qOQOTvR8B?=
 =?us-ascii?Q?/kMVfdvXtk+MHmoHjOzNEsr2mFZLgLRh2CwEEbqOSfjr501LtOKfe2Wn4dSl?=
 =?us-ascii?Q?xe/vEd4fPBJ4eCuiPVq4m8aRmpuU2nPG1o94bpjprWVriaJvdgJk1C9kdUPT?=
 =?us-ascii?Q?z+DgbdAvlJtjyTqmnnsUxudKQADnqMyETC0cQDYafaRmAlf0Ob187xJ0WSIg?=
 =?us-ascii?Q?4DlkcafhI+YdpT7+2X8hHvxaYaHZhNrZ7AAk4goRqc/SwFB2nafOrWmgcLjV?=
 =?us-ascii?Q?8/7cF0gIF5uHFyp2K9+FYfd3zcbVjpc1RUqKpPw0gUVDI86d2dU6bLtPKIc7?=
 =?us-ascii?Q?fkgKgZkbtBhI9p2CcdAXtPKmLWUhkEluafIrN2LorPPizvyyAbGftwU6pnpY?=
 =?us-ascii?Q?57sCPfMWjRZpTg703O+8B8NjaXzU88RgkzWLUoVVli84RxPmkVxTs91mOtGw?=
 =?us-ascii?Q?hJ06RmsUNCym0rFPfCpzub1Y73RyAEz914jj/mbtf7C6pandgKi56z9zJO14?=
 =?us-ascii?Q?9V+EXn2Xo0sATmQ2Ft769brICtmPnE7R6mmksr8cMxMHhq4SkH66ydX21I9X?=
 =?us-ascii?Q?+f2vGQFVsVOOqEnHg7AaiK9bih+JXaVY3B8S99sFPFRguFNQxGB9lZ1FFS9j?=
 =?us-ascii?Q?as5XU1K1XDq0i6X9KcakunQmlvTGxKztt7QjWhCW5+xWhevQ6mb9INfD6hhm?=
 =?us-ascii?Q?tiJHH5RoEAfncJuG5Lvl4UjEvivAVuJkwj67N6F0iSQCfvWQmDs0c45DN4RY?=
 =?us-ascii?Q?O5q4ktr6cH33lQlKDiG/QW3VDa85hyD/XOGq9kjSKvAbBOGYCGop+5W/7wMx?=
 =?us-ascii?Q?jaMLn+cFQXaroNiDxZltWE/zz9pj+xPpvYGI+VKRCqs2zgG/HBPCHglVC1VL?=
 =?us-ascii?Q?spiXlGvmR8jVwaBx2pSa3YR2qSAjTszfCxHFgDF5PVZRRfEM/V6SHKzqbi2l?=
 =?us-ascii?Q?6Mcrt9mZ7lkfUwzxqJLn+zqMpyS6epVWjKtuLzgU/SnbNKptxBj2sIalM8mH?=
 =?us-ascii?Q?mhhdumaje35BXXwHs/6L0J8bqyuM+YPY3sDW3Z5z+EtfZjshC17ov5YJlRxg?=
 =?us-ascii?Q?8HKAIfKvHyzxmDHmUtJpcwBMyrtn9hbbsRvuL1Yj/st2lNYDW8uJaOGeU10g?=
 =?us-ascii?Q?VrAOK2ujDvwJhiq3f4j751qKC3RZqwo8Ld375N8PqjfCZ7GFpIBSse0D7Gjy?=
 =?us-ascii?Q?BsV1ZcRC9ADyxZeNqnODA6QEABsfrfc7KES+K4ahuAa2pouH1Q+dxUgAuYjF?=
 =?us-ascii?Q?KPwLPR18sq4qV84xqDnwrIn8npxFWal2eM6P0gQH2RUdUG4FKChM1UabZv2F?=
 =?us-ascii?Q?qDY1ipkDYkVVcXsMAQCBVh+K29yOhxcFwym3B0NU8FXDmeLa+99w/pLNn8OQ?=
 =?us-ascii?Q?pSLQSdOMV4nzplbcZVgicb3FhESq5ZjexvbEJKIwjaN9ynC259KKFoAcn5tJ?=
 =?us-ascii?Q?TKclGCEaTfoeEJGpu8IC1IDm+cX7KJMy0OUBQ3Ep/1FX4CHEpi7Jsfy6GI6e?=
 =?us-ascii?Q?ThrWiddwPrXpAONhkJAhzd72NEmftWD7x5VQMviTWMO9AsfQz2QR9UcEIzL7?=
 =?us-ascii?Q?DUxiXIrtd+4AWHmSEayoW2moz/0v51FAV/plFS2XmyJB+20wARF7pUqhnSeX?=
 =?us-ascii?Q?342mJWCH/Vwx3bhv6bbj4QSe2EdRJ/UyP1aOscSoUK6kejNoncdjEAnp0wZ5?=
 =?us-ascii?Q?4p+RyR204ZcOnl0n43PRIhWn/gyTJOLj2jPQmN9M57YXk3OwtKfvo8geWRlO?=
 =?us-ascii?Q?mXlS7qXDbBtRRKy0fKy+FQwLuuMfBfi9K4iPnGtdq2zTJYbWrOqG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b928a22-592b-4927-5cff-08de86e73929
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 01:14:38.9470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dw0U+3A7+Vpmr/cuiRgprhKOvY0kJn2OL2yPe9qNAQvN6TFmx55ucPT3l07KO04S3/0idMTc4JYErUQnPa06aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7360
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270133-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: C74932E2BEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a set of 3 improvements to the 28G Lynx SerDes driver as found
on NXP Layerscape:
- avoid kernel hangs if lane resets/halts fail due to other bugs
- actually have phy_power_down() cut power from lanes, not just halt them
- allow consumers to call phy_exit(), to balance the phy->init_count

Especially change 3 will allow further development of the dpaa2-eth
consumer. To permit phy_exit() and other patches in net-next to be
submitted in this development cycle without functionally breaking
networking, please apply this change on top of v7.0-rc1 and provide
it as a stable tag to be pulled in netdev.

Vladimir Oltean (3):
  phy: lynx-28g: use timeouts when waiting for lane halt and reset
  phy: lynx-28g: truly power the lanes up or down
  phy: lynx-28g: implement phy_exit() operation

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 190 +++++++++++++++++++----
 1 file changed, 157 insertions(+), 33 deletions(-)

-- 
2.34.1


