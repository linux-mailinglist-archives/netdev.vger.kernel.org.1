Return-Path: <netdev+bounces-229999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 520CBBE2E19
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33DBA5015CB
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DA03203BA;
	Thu, 16 Oct 2025 10:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OLvAuC+G"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010049.outbound.protection.outlook.com [52.101.84.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C3C31A7F8;
	Thu, 16 Oct 2025 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611381; cv=fail; b=Jqlvfxuq//FlpoRUCXjroff5/GHihyfyX594nkiC/crzrpEc5t5RzcQJaAWNr+fWUCDnRJmeLYWUzVVC0cknWpc0zy/E+8VDP7TLPSDvw5mdNDlEZYlEYe2lo9nr1BpHO1L3eqKoFiv50SlromY5s43eMsZbsNQ83VzsDseO2DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611381; c=relaxed/simple;
	bh=KaupXlC4I6ZNSoTc7ypB/4XoZ7c7hNTdiL7hLDG5mfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VC5RHrpMBdkD8j0bn2J0Uen+gjOHC8tO/lgHV0iygBKGZkdSpwGfRSb1JkTwMYMOeC0dpmwiWxxqNXJlmsylVOJ8CM22FyoRAQK97g0u390oU+PqUKzmQ+T9oLrQ7U9OIssjiBPBDPPBeotFV5cdRZuVmmL9HPIUnW7/am2KHIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OLvAuC+G; arc=fail smtp.client-ip=52.101.84.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtd0v4FicgAbKXrXr7pUALkXYtCmoYt7u3t32yCe5DgghW5IJYzw2P0XWLwredK1t6bs1ploxPLc+feXwkVWmDdcObdFkepvTNEh5wMzSp7um1hOnlMK8/udqSO5BCSBGk86axBN/ibdZMB7Jt+7ZSTXXOnnFlgoD98PJO5nQHMRSoRqFltXVcTtzdheCZQ10/OOi0NHLuMDJJvmTICXFY4FAP6Dumdyy0xF48kHU7ad6+W/22GbWQmA3i2lthlalZe9z/BLEhLp7fba7rCpdJv/BFLImVR+dnVgh2siw5fUP1YlWo6a+E1dbvDc8RyUBCyu4CR0K+UDBXqWX+EFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvPC1jsOiM6R4TvPH5DY9CVvskWjzcg2eR5KUkgHRSI=;
 b=lGZPR2aWsaEqI/9Zg0YZIMcGHL4ig+e/W+OSRTjCxuYpdGowAWj7wMmmc9qMrR0ltiiF5R2TZ3FB5I2In7kmzweWy0eLJMLpPYxchWu0smxB/N2v78ZUAKq4fLZ8TEf4ij1hQi7e37Uok9kQsqwXWV2DoemQdph4aeFQ1H5T2KyKJS7oqCUK1y+Xf4ZmSoT/8qljrfKRix+z8O5y1FTWs7fGYmPmDvoV0zWYtXrWYt93ds6ORHEe5DhaEJAInNLMohr1+uk4CLWnZv0JLuoI2sjdY0XlLQZ8KvOULAtklMp9gE0A/bcUvBJvRISNKWnzePqts30wT66De0tsDjT++g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvPC1jsOiM6R4TvPH5DY9CVvskWjzcg2eR5KUkgHRSI=;
 b=OLvAuC+GRf5914vcnqyTH5pTgqous0mOJ+ORQ+DOe+HM0+bDpHVFfWj4tu1VdNyuW1+Czjg7Q2mvfzJl0zRZ3OJc5yW2OnFXeehDEtnYYrUK4+j8LimYZyecK4JDnVrpy6DeS68iLPm653xa47aBMcmAfU6ObbQynqIajkUtBU5xe9gVcMCLCRimjHXiwjCJ5tBUg3+vpPn219LiLUpBiems7rACa9CkJPghiWs0+7gaTQ3KhOSQXq+vADJ2ZBVvrR0r6Og/qhnqv86qJbp6KtGw0AL/k87et2K9K6gx7cUcdwFYsKgnrTnaAtKWsRiB9vmHJ6HrunBZRFbwNnAAHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7361.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Thu, 16 Oct
 2025 10:42:56 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 10:42:56 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next 1/8] dt-bindings: net: netc-blk-ctrl: add compatible string for i.MX94 platforms
Date: Thu, 16 Oct 2025 18:20:12 +0800
Message-Id: <20251016102020.3218579-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251016102020.3218579-1-wei.fang@nxp.com>
References: <20251016102020.3218579-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM8PR04MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 8efc7ccc-e3a8-4f48-1c5f-08de0ca0c44f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|1800799024|376014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gSBFD5/XnJszLZR6pJIosoCexDxpmy6nn6f9xxmN0CHRimsrDCAUXFZ+rvh0?=
 =?us-ascii?Q?D8ba/2VCwc+I9RxFpJA+dOUGGW73/I7jH9LxR4OFjbGHMFmFU7Q5jgPinqec?=
 =?us-ascii?Q?JKdDza9k+Ppb5hcbUrkWAyxwf+xvjaeIHO3LlTGK4bprJ3KcsX1oo8nfD1jw?=
 =?us-ascii?Q?xF/gcAtBCFzguMRVOoS6VSjYXwstXsvxgevQggkB2wWNtq/kKMfmIblkOaOb?=
 =?us-ascii?Q?cSkiLxCTCaHbZU64GLd9t4jmc4FqT+lBkLbduFy6lWEwdx5GTPD2B9T+yIvi?=
 =?us-ascii?Q?3z+pgIiXbavyyb8MxuNLaekiFaOKVPFOv9kgMoYe5s8d1iNpVsPMzcTKmozM?=
 =?us-ascii?Q?10zFOVFXcDOEbZB7l9zBUxaINbocsdzdsf769Z2IcPll+aSOOKMG/7wOu5CZ?=
 =?us-ascii?Q?8/UYnmRHAtP8d7DGSozqddDhC9bwVlackwU+NKMKo/JmvOOVdtW2CicgoIvl?=
 =?us-ascii?Q?tuqaMLJ8zcGrVgzB0MQaPR6xUWV+2Flw88YFJeO6ceCVYBv/HtEui25QrH0F?=
 =?us-ascii?Q?74YiQucCYnqQwQZHFQGIrwvTiO4Op61R296L9Lzjn2+EeorYor5AorwEKcCV?=
 =?us-ascii?Q?t3WX4X2t5Fk1RXKRiQ5unZpR8ShKttnNmI5wftJRgGCARW8MxPo4TYeXpSRi?=
 =?us-ascii?Q?+OX1WCGPouh8AquYE207AXuZFScKE1YgGS85B6mclrSu3z/fU+lb7n8Q8DkO?=
 =?us-ascii?Q?PXhUh/+mKPSmjepGXwGoA42D0dc2Cbcj0nH/+xvNGjOmE1noaC2DKm3bRBJM?=
 =?us-ascii?Q?YgmW//d3LiqGAQVuNRO37cmlOvIcGFAWO7NGk7H/CJW+QsdBqfWpud7dfJI9?=
 =?us-ascii?Q?VRFGhXqerLaWBTuBKMwaVtb4onPgjeluQl7z3tWVS+ybnZl6zfkNXd0+VStm?=
 =?us-ascii?Q?0xdlyNUnUN3dd1uy5hbCf2ynhyZEJ82IC0PBdfwrdDKaYuVH+ILboRM9T9/N?=
 =?us-ascii?Q?nfMc3wWqXaqqiSVS4y8cp8XyfdTDZHw0BNkapTOAsQaPnvRRENeDqWnN9ukQ?=
 =?us-ascii?Q?lT09DxTwU2vtXw8f+G01gE6y5zhdD+IKFgXjh9Rj/xYOCglUFPRE4QXUz1bI?=
 =?us-ascii?Q?YmNDfDNmRo615b4eCT8Nfek8HztwrRahERaWyZs6FSi9o3/wKFIekPIwtaFa?=
 =?us-ascii?Q?dcnRM/iGu5VbZcPUygcvItrb68+p2lUrAqvw1A61VTkVctfsq0SXNdNonB5D?=
 =?us-ascii?Q?dnTguDPykTdBaEg7Ak3tPM851s6FsSpvHX2ObHKAbn4EMhhBQ3pWOq9oOwlf?=
 =?us-ascii?Q?vLhA+BuInOl2zKfXodZ9Dfhv39M3HfhP/EY2Akps+uNa82szu9Vn2r+pYzfL?=
 =?us-ascii?Q?HtXVX/cokcD8tkwWieJEkg4TMuE+o48bY9f78Af7mM0ZpK9wSDo2exi+hwS1?=
 =?us-ascii?Q?k/eT8D8zUPrRfJ9sDykPX7egIgyz8B+YVHbEFozPSmeI8Iol7ibMeOZ3uHBI?=
 =?us-ascii?Q?+f3WZVj5yYq07tzCOMMyzWaWgxs4FRtc9DZXkdlphAjNBSt6WUGuLnxGyhEY?=
 =?us-ascii?Q?hCLDXfX5HwfwsRSDyxjoCZvTKGfq34/bKC4KLK4aDYeYGhjzK090q6X7Mg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3C3ILP0zA6DlkgEwX7eY4MmwPHEDx52WRgjXibSDbkgjY9p03ski8OFwqjAZ?=
 =?us-ascii?Q?+oWmxLf3mx0w3ki5RneY8mD02GAW5R2D/VLwKs9ePinPIBwJ7bpsMGZW0P6S?=
 =?us-ascii?Q?FlNfRlvQYlSYZ9CXioecQz0P05iHyO/+q9NGUowOs91qMornH4Cvagn/LWqu?=
 =?us-ascii?Q?RcyeB0mKAfKm5DwolSbKk8/3QOeM/lvet/gk63FWnNazNl9nK2c7Fqm7PYo3?=
 =?us-ascii?Q?7Oklviv7YCvJyA3So720kr36MT2ho7vkyZspwvO6E0mEmWESJOPmGzhoDDVp?=
 =?us-ascii?Q?kqXSwYIhw1uvUqezViLsPIna4MeTKl8dncgzTWM47VpnINiscoumvu+KDnUN?=
 =?us-ascii?Q?Pgn/kv4PNjTmrWUV+10Impc8MHDnsKeGk1bjH9ts2s9yTLknnaaoKbirK/Yz?=
 =?us-ascii?Q?BesYeA6jwERWDGcMaxOJPmgb/QN2oIPi09B2xyZ2AUuDuWggSEyxVNnCzfAD?=
 =?us-ascii?Q?jRhXnMNNpfydx1A+EvGyTCKJpSlUh2mBrVq1Wifd6JdQq/V6pcbylxT2wiN5?=
 =?us-ascii?Q?ZC6VhYVdAIuWW7P2bgXqbLeOXXjKsTATVKGBPHQodIVBEYcYvqiL7rRW5RtT?=
 =?us-ascii?Q?eBJFwIGoY0m7+CLy3VV1BEGfUKxFs1ukyb+TsPGIFmDzPjAakDvM6E6GROo7?=
 =?us-ascii?Q?+QailHTQK2Vl9gqlSd+99nine2InLI6v7LHlRm/pdR1zNAs48UO3VGngv2gt?=
 =?us-ascii?Q?1jho5N6ZEDZu8I8M0I6AME5fzWrXE2yArLIiemOcGpvfilQG0XfQYb94CF8M?=
 =?us-ascii?Q?VOvfdNpeGhpACuyePeBJgXIpu09MviDgFBm1xqXYSJAONC3lEl99nCSQ78Hd?=
 =?us-ascii?Q?oSlZXUuYKSZW0HA5YAJwBu0wPsU11N3S59BojGbd7sglFBaqyRANQn91wk97?=
 =?us-ascii?Q?rmyh8J0ZipRs4j/7lqktQJ/1oKrJeVm563L2NmcdjpILurMF8DHIyXp8zOO/?=
 =?us-ascii?Q?OwVaGc+agOHEg0LFhYLUzmq/jPnZbrTPOxTltDlcAXKKJKHqCVbwC1EKCl22?=
 =?us-ascii?Q?xwLrTTn5ACk0gHOajY4QbOt2XshYe+YOOxOFYsg69qI6FNhcdgVNIXcRcoOq?=
 =?us-ascii?Q?WWju90bH/n+tkuKMsKA4mjM2q/u5Cp75+Tsq7+lAflm60XDOWmwp5H7Hjfv0?=
 =?us-ascii?Q?F8QXeWBf/2BhL0CSRuQW3GMVoQOE1buDaad444L+E2kAIewbv5TE/+uo4yNq?=
 =?us-ascii?Q?8B99KEE3Q9Ry52G/xs1SzHlVYCWH54a5jtcMnb2pE2NIGgT5z1AabFqEwICx?=
 =?us-ascii?Q?ooFiSgtWJ4J6C2NnOhev/M0FwLoE3k3lLa6PqfcHq2habf2l/WK1F8fan4Fw?=
 =?us-ascii?Q?seGCGWMH6l34z4K+BqEDKr5aUjmFjN1MschD1lZCsKYPESV3alxtz0VaRgc9?=
 =?us-ascii?Q?hUZRetQm+EQ6Or+VgjneFOiJWV+9VTWd9JlIeZsUd0uF8Jng/zT0rGnSRp5+?=
 =?us-ascii?Q?cJXi8mHRj4ywbLvPeKPdD++gS3CvKmA3z6KwY5vGVTgDILdX40JMqSeQ+Xd2?=
 =?us-ascii?Q?wiKKehRYixHRUeXWwAkK7y0vKeYj3KwEVnGtMhq0BRpkJpjgbOPOJdoRAMUv?=
 =?us-ascii?Q?kglqdAJYtMNaVvYW67s+A5EGnbW4PhIq0/Cg2iJS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efc7ccc-e3a8-4f48-1c5f-08de0ca0c44f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 10:42:56.4904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwfcqhAIFAIfgA8hLlJZ33fC0mch2TJBYLC8KmfUk7nlRorPSvuIT+fJA6etPUL4CHi9ODy2SzkGEha3PeDndw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7361

Add the compatible string "nxp,imx95-netc-blk-ctrl" for i.MX94 platforms.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
index 97389fd5dbbf..deea4fd73d76 100644
--- a/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
@@ -21,6 +21,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - nxp,imx94-netc-blk-ctrl
       - nxp,imx95-netc-blk-ctrl
 
   reg:
-- 
2.34.1


