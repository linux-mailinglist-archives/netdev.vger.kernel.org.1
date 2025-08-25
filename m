Return-Path: <netdev+bounces-216373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BA3B3354A
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2D53A72AE
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 04:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13A6286422;
	Mon, 25 Aug 2025 04:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A0k8F2kg"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013054.outbound.protection.outlook.com [52.101.72.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6385927B323;
	Mon, 25 Aug 2025 04:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096640; cv=fail; b=GO3vfmf/Q0mglcGiAAs8fhYgse5I1oFvcVwVTYcXb39m9EhiykDiDzMi9mV7bt16JKAHi0IRynTpemUSxFN09F7yMEtsA6BlWfiECjnqFw+U2Xbex0L/TuoKxGc+pOj27O7vKfAX1dWE8oJ3iwuXBf9RiC7qkLCkqf79wW4n2Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096640; c=relaxed/simple;
	bh=DL5bOaJDocN4fXYFUW33I345ceVxBmVAmrypWI1MnNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=THoVOH268DMGczHBHsuoLJd+zbvK+7kk0Iepi18BQorKUHbM3NOFW7mrARjYYZc9JeKWmYAby5FBtbwMca67r0LQM99CLQ3nbR5d/D3cjuyfKJN781zk5xbyMuEXLIPfBcMgtBwgo+AAZaEI1NSRbGhQ1Ghf9n/a7O29OnoSM30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A0k8F2kg; arc=fail smtp.client-ip=52.101.72.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CnICcB9edYCkV6By8Pht3EFWr8AH/9vzZeFXFHeu7OFr4vmX5iBj5WSoHH9dAR1zs6PKiXEDTp9JD+2v+jOh/fZRmZWK2u15n9J1u5aDLJAr2QuVvV87rLn0hC/upLUtyVH63KSSY4Tfu8AWbtmVeuz0amxAnTHyyop50LQa2Iz7u17hr22tejwt0oCxgxZpL+CEHr8Zy6wLpYOJ26JbYRP4sv9SoDkzxnhvKCpwu9H2vevgwA/hoB9eIdfLHuHIg5M67+ZpQAblcDvunFrxCLx5i8wdQGoNQ3Tjqr1LWVXi3rkVO3J81s2VbCxTO1SAIAMcVA0pL+v5p7FyJE1Z8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azIUn1xJ/wfV/DmIV5Ze1U6Lm8gV+/16RaH3Pr9sEq4=;
 b=Z7TOhUF2KCPauF9Gd0LfzLG4sDBel6qmM01BF4E4/f1GAVw3RKpVMDAs5t6yo8ABS411YcMRtU40h3pGO8vVHI4nYcgy7vg0CAcfEAeDAlR82jys4+aPRuH7chx/B2Yq9mXvlvc93ly4s6K6K/WaHudPQJfplS7UEVNJoAEvKjJlfaKX1aknraeuJqwLtYjHsv7lofRQ+bsBtOeb5iwVNeBMNL6WbM6qJO4QcgR8P8LkrY12BEweEgXJFB/m7oUc8frKmsVvErUC09139GzKFBdYYZOMiWWpO8RzzOuad+zDIo5nwpUm5CxSOgOWRCWBwOxeprwv+XUuXwwL2z9xqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azIUn1xJ/wfV/DmIV5Ze1U6Lm8gV+/16RaH3Pr9sEq4=;
 b=A0k8F2kgVCk4yV0niEPz0sln5eeAxrEbKIdmlnEGeIj3fTOZmdXZ6GrzuslhQ4yHX1QaewHjzpz4jr6JIQIBEb6Cil7ByQg/DMF83mYZIUT501CmHWLy14W0WKf8zYoKWaAEIx12uZFriB0bK17tXHSTxniL9Q+/5fbG83T+Y6/8OKqlC/J29oogJ0H+gEgngIX+WC1f+al+7fmBATcat5iaJAuQB66J6GWQEx7e3ulXM8yghCu10E4ivDiZBDXstSdUlr82AFpo0mbDsA+cxyRhSmvTR1dKWYB2GZ9K9BD1Q1VBNaXT99ZLmZMGtklZSensm6Ni3O8IIHdm5vIbAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9661.eurprd04.prod.outlook.com (2603:10a6:102:273::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 04:37:15 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Mon, 25 Aug 2025
 04:37:15 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v5 net-next 08/15] ptp: netc: add debugfs support to loop back pulse signal
Date: Mon, 25 Aug 2025 12:15:25 +0800
Message-Id: <20250825041532.1067315-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825041532.1067315-1-wei.fang@nxp.com>
References: <20250825041532.1067315-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB9661:EE_
X-MS-Office365-Filtering-Correlation-Id: d1675ee9-5264-43b9-6da6-08dde39110c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TUo7LZ2/YxefZgA8hGqfaRm4pSWBs8HskXZ4lXkZKJqBJtYGAHqg1XaUjXiK?=
 =?us-ascii?Q?zlWDeCWnHjZJoVhlMBPo869RhqPmMBQqTjgkpc25B0B6qCtv1Ri9rUHjGb/f?=
 =?us-ascii?Q?taeH4gZWJ70sNlevo2nrsUWu5hrHCvC7C1aNZWK8TK/WVulG9u7GV2q0zW+g?=
 =?us-ascii?Q?+RI/yKBXta05DVabT/QuXlShWjuOE+CrkYNJ7Ot/h6kgKj3xdEWO4DBvR708?=
 =?us-ascii?Q?qZJf80g1pI9LvRdNFGQXAGullqrwkOhzYM5srrk5SPyaQd1DpVyHGUD+3Xbr?=
 =?us-ascii?Q?sYVDrvxAp2To4PrL4NNGcdirYVXpwyKDeeEm9rTGi9kxrgsXjJ63dB5elmKd?=
 =?us-ascii?Q?GkJLIQXH5LIPIWCu6nSCYVLo5HVavGyiFTBAW6BQ0DbmP00R9yMwy98RtX8k?=
 =?us-ascii?Q?zn4nqopns4rs5R+97CWtAus1MRWLGXbSD/8Yz9LFWIIJuCf7IQ/SBfHfwwMB?=
 =?us-ascii?Q?Df7YSbD4MPF8xyNmiXh5kTd0rTPkbhCBi/iH9InUMqBE9KhBUEd9JlGjojOT?=
 =?us-ascii?Q?hy4+RKihILOrUfLEaIKWI4pqvcSa3z2wQTe+kJ2ITS+4tL2obrn4v+L2jDDu?=
 =?us-ascii?Q?xPrwnRw1dqBtgMB1sBe4xAiWUfmrlgZPzl0Vg7NygygSwtoCzYhWzMWTa+Q2?=
 =?us-ascii?Q?g+HYZGOfE6lKUACkcD0SM1Qw1JXDNLrC/ZJu2+RSE50ArpGLY+JX8RNLUIrO?=
 =?us-ascii?Q?xhycNNpBYfFvYXCngQ3ddWj2sQtKLbf58d2w3FiN5zqc/oBgnFUc1msXyv8h?=
 =?us-ascii?Q?C2WTJT8rKYfy9r/ZcMAmE4ymD+/SeQdddv+/k/slw+fu5MuTeWkpNsKYEoyH?=
 =?us-ascii?Q?Rn2ANeIG+sKu3byg1L0fIS0OY13PrDPljDFNX4BVYPBanPDXVWHw7IGD4Etr?=
 =?us-ascii?Q?kakhmO7Tnm1k6bq8KgtRzIjeh6R8cSW99qNg1wBjYqcFynbLax+HRYrNWdEI?=
 =?us-ascii?Q?HM1/sexgq4rFmKn3+99ne/Jqr/D2jXyKUiZhCfic4CX50pO5WSeqHTNzCpga?=
 =?us-ascii?Q?oH4HOvh/aMLQz9BnRBKc8CItfNbffxtr+OhqkoLqClThDKUwMnHxlQbzB84b?=
 =?us-ascii?Q?Ycxbp0wMzn4K08HXyVR6INXJXL948U8APvYKC5GidrhB06pQwiSsT8q7GJpP?=
 =?us-ascii?Q?ItGhggL+U/rwEfuBwVqvgHHkozcE2JZDhGt+otm1xNNX9QIKN/261HDaVhir?=
 =?us-ascii?Q?U8KpQvot1JSGvEmp6CRKHbu12R6WG/GVoMdYDXditku40TS1ouEi+PyDKXrf?=
 =?us-ascii?Q?Vm+9slPEzwoMV54HjiDEYbd2yPcsF1uLBbauHIFBUwecZdgHvv0pcg4YP0aJ?=
 =?us-ascii?Q?1GM8I37twlowZTvI0EHZZhPNk36W/QOShEabACmsJt7CfHi8ShybdPCUDiiV?=
 =?us-ascii?Q?FNN5lUChr7smMV+dzb+rymZk0byK+4ywe5cBiQ0NLV7dV1reEbo4TRqE15Td?=
 =?us-ascii?Q?UjxokpjOG9bSgyEqu1JiGycy1kiiS7Q7cW0GpstRbUTfQ+lxx367mzIgXZS/?=
 =?us-ascii?Q?RGy+kdefNX4aCVw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uiJvJAhUY+++wfUvVn6LdWrw0e2GL0UQhRhy/xBg3e+hwZdK8qHANxhCJrBj?=
 =?us-ascii?Q?SV8tmbgrlpIL3iGRJeuysbPKvgLskSyW/P+soy63DoDqHbrjD6V2lbGJ8L0a?=
 =?us-ascii?Q?eTlFm/mq9Ko51QLqBGUSsK9hjiPXxA5PghrohUucP93+rSoAXbgDneR05ulV?=
 =?us-ascii?Q?DlHSzTaODIsM0mm3+onQ7fukWXoBfindslOpyOQ6OXC+bBgXH3X1LCExbE77?=
 =?us-ascii?Q?dQz5dlfwTDCWbCJQlHES0px4huudMKMZtNa9t7t7FKLRb1OBEimk80kULACd?=
 =?us-ascii?Q?P5+sZGZFYPTVYL8zgi7MddECWk6NeVZVGhTq/j+0GKUomIdMWDx2VW7Fprty?=
 =?us-ascii?Q?O+O5TlCXzgKIeXZAyZwcBRS0anBQAqlLZx+ttmZ6OzfN3JslUc0oPTfAY977?=
 =?us-ascii?Q?+m0FvGezOz0cD0b8puN1k7klqpCpOtQPHnxdudeJ0nsN8Wh4NctTjPcvECcF?=
 =?us-ascii?Q?858IDKC7eWclpahW5clJ834p4ugomVfpWyMPjPcuWOIOkq/81Ay0foR34H0j?=
 =?us-ascii?Q?H/MEXo6ZXBXIsqfn/vWoU6mQsCDKaerb2U5ch1jxcEBghkIr5C0FKaPjZBmN?=
 =?us-ascii?Q?iaJkZbDBxP6isYrt1bA0IKyjo968pTjve88Vrghu4MB2S2rqPJnwoDNr6Uel?=
 =?us-ascii?Q?oNNNJvUzNl3CrZ9+S1EMKZKHa8cw/Y3cR0tSkEpEaRQBw3OYBy/DS0N4yz+Y?=
 =?us-ascii?Q?iYeAWJRvkqs4MAaNrqH8SZYbXlilGaiFE4ojFWZ2FF/yyp4cj4CIt1qBMMXW?=
 =?us-ascii?Q?ZF1yQw2HkRqQ/vwGzAE56BtLRUYdEmm3zxigL2ptN3qgUYejJaoksio4YKei?=
 =?us-ascii?Q?Mjqjn74MqW2gnz8lcloQYPbvMdOH67I2KMUYf8cEvi++krgIffb6P9qFsOS4?=
 =?us-ascii?Q?GgvrzsJ64a2RYrbo3hU1eYaNAIrPEFGXvai1/NaAYWNXtZx4Tr5Catrree+X?=
 =?us-ascii?Q?nxSjGOmYh/AW+vmUN3Z+QcReVNrHn0aSiGsbzE+2d5XyFJcDQXKSP7G14od5?=
 =?us-ascii?Q?uO2W//ox+6MQ0kVSfSY3uze1ecM7sbnNvkXPo+hqHN3pN4FLN68qoIWQnUfn?=
 =?us-ascii?Q?xXgHQ0VR3TYHGKzxbgMqkru5M7dEkCF1sedyIaBGzGM9HpXyVRD/j+pr7EDi?=
 =?us-ascii?Q?eZebQxJBkG6ZhtBjeHNSpmYaDsOyPM5H0C3IdWhz8i7omRtBcHI4iUqFaYA+?=
 =?us-ascii?Q?jpkNSqysWmZzOfM24T/Fi9k+5lX3qcP+/GeJ9nbNFgCfclNQsZdKEtlgWUzr?=
 =?us-ascii?Q?wWnZvTxB3lU0I/EW/X1c/iW+xt4vDhhANu39M1fMJSsWCc+70eeEBJwSbya9?=
 =?us-ascii?Q?oNFoL4CVw+2wdhPzDJXs9/GWvPha24iaLMPJ3aPB1YtsyWNNZWjwVzli0mYX?=
 =?us-ascii?Q?QX3dcH9z+z9VXcK54FtRT9YyWL/2Y++4jH3vZZ8WWXmLpChXjAG0ScLk6m5V?=
 =?us-ascii?Q?IwcwOkDGHtsmGbvolms1zu0f0VM3d/pd6TK37uWMD5snEMYLRZMFfWxDr92m?=
 =?us-ascii?Q?V5Lekqf6paDQX/GkBOAhskig7FHfFclsPRSAHcIN9PkjDtQ6ADW5d0u6OkqE?=
 =?us-ascii?Q?bL17T7gdo966+4N00gDjv3GIXuT2gqqgcJcR9wxv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1675ee9-5264-43b9-6da6-08dde39110c7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 04:37:14.9894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /RkMmcMrkkk3rA/+MULzR8Mez04l+0cL9fmqm9V28j0K3CJ7EUjX2AM4AqELOliz1hdb29s0FvSaZL0R+JHvYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9661

The NETC Timer supports to loop back the output pulse signal of Fiper-n
into Trigger-n input, so that we can leverage this feature to validate
some other features without external hardware support. For example, we
can use it to test external trigger stamp (EXTTS). And we can combine
EXTTS with loopback mode to check whether the generation time of PPS is
aligned with an integral second of PHC, or the periodic output signal
(PTP_CLK_REQ_PEROUT) whether is generated at the specified time. So add
the debugfs interfaces to enable the loopback mode of Fiper1 and Fiper2.
See below typical user cases.

Test the generation time of PPS event:

$ echo 1 > /sys/kernel/debug/netc_timer0/fiper1-loopback
$ echo 1 > /sys/class/ptp/ptp0/pps_enable
$ testptp -d /dev/ptp0 -e 3
external time stamp request okay
event index 0 at 108.000000018
event index 0 at 109.000000018
event index 0 at 110.000000018

Test the generation time of the periodic output signal:

$ echo 1 > /sys/kernel/debug/netc_timer0/fiper1-loopback
$ echo 0 260 0 1 500000000 > /sys/class/ptp/ptp0/period
$ testptp -d /dev/ptp0 -e 3
external time stamp request okay
event index 0 at 260.000000016
event index 0 at 261.500000015
event index 0 at 263.000000016

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v4 changes:
1. Slightly modify the commit message and add Reviewed-by tag
v3 changes:
1. Rename TMR_CTRL_PP1L and TMR_CTRL_PP2L to TMR_CTRL_PPL(i)
2. Remove switch statement from netc_timer_get_fiper_loopback() and
   netc_timer_set_fiper_loopback()
v2 changes:
1. Remove the check of the return value of debugfs_create_dir()
---
 drivers/ptp/ptp_netc.c | 95 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index a5239ea1f1ff..d313e1a5483a 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -6,6 +6,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/debugfs.h>
 #include <linux/fsl/netc_global.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -21,6 +22,7 @@
 #define  TMR_ETEP(i)			BIT(8 + (i))
 #define  TMR_COMP_MODE			BIT(15)
 #define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
+#define  TMR_CTRL_PPL(i)		BIT(27 - (i))
 #define  TMR_CTRL_FS			BIT(28)
 
 #define NETC_TMR_TEVENT			0x0084
@@ -122,6 +124,7 @@ struct netc_timer {
 	u8 fs_alarm_num;
 	u8 fs_alarm_bitmap;
 	struct netc_pp pp[NETC_TMR_FIPER_NUM]; /* periodic pulse */
+	struct dentry *debugfs_root;
 };
 
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
@@ -938,6 +941,95 @@ static int netc_timer_get_global_ip_rev(struct netc_timer *priv)
 	return val & IPBRR0_IP_REV;
 }
 
+static int netc_timer_get_fiper_loopback(struct netc_timer *priv,
+					 int fiper, u64 *val)
+{
+	unsigned long flags;
+	u32 tmr_ctrl;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	*val = (tmr_ctrl & TMR_CTRL_PPL(fiper)) ? 1 : 0;
+
+	return 0;
+}
+
+static int netc_timer_set_fiper_loopback(struct netc_timer *priv,
+					 int fiper, bool en)
+{
+	unsigned long flags;
+	u32 tmr_ctrl;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+	if (en)
+		tmr_ctrl |= TMR_CTRL_PPL(fiper);
+	else
+		tmr_ctrl &= ~TMR_CTRL_PPL(fiper);
+
+	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int netc_timer_get_fiper1_loopback(void *data, u64 *val)
+{
+	struct netc_timer *priv = data;
+
+	return netc_timer_get_fiper_loopback(priv, 0, val);
+}
+
+static int netc_timer_set_fiper1_loopback(void *data, u64 val)
+{
+	struct netc_timer *priv = data;
+
+	return netc_timer_set_fiper_loopback(priv, 0, !!val);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(netc_timer_fiper1_fops, netc_timer_get_fiper1_loopback,
+			 netc_timer_set_fiper1_loopback, "%llu\n");
+
+static int netc_timer_get_fiper2_loopback(void *data, u64 *val)
+{
+	struct netc_timer *priv = data;
+
+	return netc_timer_get_fiper_loopback(priv, 1, val);
+}
+
+static int netc_timer_set_fiper2_loopback(void *data, u64 val)
+{
+	struct netc_timer *priv = data;
+
+	return netc_timer_set_fiper_loopback(priv, 1, !!val);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(netc_timer_fiper2_fops, netc_timer_get_fiper2_loopback,
+			 netc_timer_set_fiper2_loopback, "%llu\n");
+
+static void netc_timer_create_debugfs(struct netc_timer *priv)
+{
+	char debugfs_name[24];
+
+	snprintf(debugfs_name, sizeof(debugfs_name), "netc_timer%d",
+		 ptp_clock_index(priv->clock));
+	priv->debugfs_root = debugfs_create_dir(debugfs_name, NULL);
+	debugfs_create_file("fiper1-loopback", 0600, priv->debugfs_root,
+			    priv, &netc_timer_fiper1_fops);
+	debugfs_create_file("fiper2-loopback", 0600, priv->debugfs_root,
+			    priv, &netc_timer_fiper2_fops);
+}
+
+static void netc_timer_remove_debugfs(struct netc_timer *priv)
+{
+	debugfs_remove(priv->debugfs_root);
+	priv->debugfs_root = NULL;
+}
+
 static int netc_timer_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -978,6 +1070,8 @@ static int netc_timer_probe(struct pci_dev *pdev,
 		goto free_msix_irq;
 	}
 
+	netc_timer_create_debugfs(priv);
+
 	return 0;
 
 free_msix_irq:
@@ -992,6 +1086,7 @@ static void netc_timer_remove(struct pci_dev *pdev)
 {
 	struct netc_timer *priv = pci_get_drvdata(pdev);
 
+	netc_timer_remove_debugfs(priv);
 	ptp_clock_unregister(priv->clock);
 	netc_timer_free_msix_irq(priv);
 	netc_timer_pci_remove(pdev);
-- 
2.34.1


