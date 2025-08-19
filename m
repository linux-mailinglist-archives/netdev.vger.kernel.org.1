Return-Path: <netdev+bounces-214955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B4FB2C482
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5AA65A7FF3
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 13:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B9E342CA0;
	Tue, 19 Aug 2025 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YlaE6LXC"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013071.outbound.protection.outlook.com [52.101.72.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61615341AC1;
	Tue, 19 Aug 2025 12:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608357; cv=fail; b=Wm6ei15UxnTd2Qcr/Y9giMpsmqzeubzL7KyMMEEU7FC99YiaYCWp9WpvwwVoZ2DQ6fDnEgZJPMqM9AVHp3wyHMnl2ERYq/uxQNWFYyzA+qmpWBY4KeF5rehDYy3kEp3dDtJscSzcwPAJaTNVmy21T79u/LZPY5DKJhwwB/qMWN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608357; c=relaxed/simple;
	bh=HDWyzpBeTidlaXmInevvymPexgnqo5g2qvY2vWYyN58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s/Iamda6t9OxIrDYdFq15bA6KWSvhiZyLnUrTfIsxTyut0iADZbCRB3nXXRAIMshcVRzRBTlhhd/HC2/kc9RQItzrjFX7on4vG3HwvDBKtyd1LcOzpqg1zUUu5iKixL0XsBpGZQW3vQlwd8k3q3bU0FH09uITgF1ROMZq1eEoBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YlaE6LXC; arc=fail smtp.client-ip=52.101.72.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sx5sYaZ3oz+Ft2UlnC5rBbF2Bme9/Fdawk5EqSuQILrAcGBPx2hnXre5kDxhAHqqrZDLOT6+WGLSRWGEgKKOvET1zWeCltJ7mOnjqAQqcf+svBokDFOzhJQc4KQ71tGKs4D6CrSfHt+byfb3fjGvPl1LS4W6Pmwex1uii6FHdk8sev1HcZr1VP6kKrZG4ZktSCp+tlQxvNdyoXqkV03dWD1atIZ/4k+KX7vb0QHzFVybYNU5IXd75c/k+yISrZzmWniRStNWqBh0CHo3MOh8xT3bQv8WdPkGfWB+d7SoLAxHZOTBJ/Kr6pod2BA09w5x83/jOPHfvYKFoxr4LRqiRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3SGyOd6t371OonmwbX0SjP3Q+adE+9/do0Hx3bzAi4=;
 b=QOQxG7dscImdpISz/06a9eOP8ipf6QvjgMKJmosz8I23GFhxtgAoJm9va+QhUXwUO+JjAmgz7GCra960KTolt1civqkUiiO3NRGYulFv7YKgnAlJ8AhB0jVYEEBrc9G0nAGRDygPtAshsdDwYQhyCkt2twfiqMjZ60cY662RRXmBKM2vv2U2cUD+tlHGE87zpTrgYARB8B10EgaPEj5Sr3ClDVUE9zHTrIxb5pZN1pOV1xVNdCaSRJubJl5nMDBOKaM6s8K//swgQw/EhUNcOrKvqLt/35J0uq6PL8eJtjcXFtKKwwuXTgeyJmO4x6ZJ2OWpE9SPsmxzokSXaxUKYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3SGyOd6t371OonmwbX0SjP3Q+adE+9/do0Hx3bzAi4=;
 b=YlaE6LXCRBQYZs9zbhuD0GUFzfbXA061X6hQ2T/8Cu3aySvQ8j1TXnAQnlrlTFCn1ltGI48PkJHq8+YQG7WsX44UZ+lRqJuUYxKDpAW7zMlOT2YAz9hjailkTEUQ2k1lVUSfhD2hmdtVqjRh1ETcdPXIvbkFPaG0LS5dylisD4KgDOpCt42uQxoNqGhT8StYXkx8Kz76WCzgMlwNSSJoK3B6L01Jo1219Zor1q2CmyzAuInmcwDhaut0vcjaiiYKbyriC7zvR+gZdIL/6cnzrYsMbrFAUglJFV/VqUztvhTTj9q3XvK2QEMWeQQIw+JXN5x1DO2J4MFdp7P5BAkFQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DUZPR04MB9946.eurprd04.prod.outlook.com (2603:10a6:10:4db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Tue, 19 Aug
 2025 12:58:45 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 19 Aug 2025
 12:58:45 +0000
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
Subject: [PATCH v4 net-next 05/15] ptp: netc: add PTP_CLK_REQ_PPS support
Date: Tue, 19 Aug 2025 20:36:10 +0800
Message-Id: <20250819123620.916637-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819123620.916637-1-wei.fang@nxp.com>
References: <20250819123620.916637-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DUZPR04MB9946:EE_
X-MS-Office365-Filtering-Correlation-Id: cd0af2c3-c101-4270-b81f-08dddf201f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nMPlzQHa0zIMvW03ZWpGImgd/EsMwboJNZSaj9zszo5OFlakONfWT93ZwGxK?=
 =?us-ascii?Q?RTGWRyknWpwn4n6RPCeN1WwC+CoXdmX0Cz34jyPaaABBPXlJettI0WaS2/aI?=
 =?us-ascii?Q?4YY2bgbHK9lMAfgFdSb2Y8Myw78KLhDf/Z0qk/cbPHYY91aDZXc0yB27OJOk?=
 =?us-ascii?Q?BEsluCgi16m/cchVnPlrHq2wESCr0vUabbxlLykmsZl9UxSJsrT1cN0fERfP?=
 =?us-ascii?Q?XDMNfB8IU1nxPfkU7bFOYbv3HmQ2UF9cjxGRGmGYW7SLML3oMS9VGE53NGSU?=
 =?us-ascii?Q?iNoSKoqTCvZ9qbJ1UVTsP8lj2Qfv0IEPcknSGYIbXKcbQV2+iavYOcdOKt0q?=
 =?us-ascii?Q?RiGCcKf4WIunQRktigbgLL0AIfow+5sbnRNyeAposESVneso337BQhRyg+jZ?=
 =?us-ascii?Q?ilySVcdk9GFXaMXklYUnziZJQvEQYymNPCm0C2Vg3eldM/CgvMUekC4KHI4k?=
 =?us-ascii?Q?z/Ae3VdJloNDYBpobE94EB7E7mapPtGUe/6DB/hgsFeIVDwL5tfqAbqpD3uB?=
 =?us-ascii?Q?6D3/DAFATnyTAIvKMrl2+J0AKMN6h8PWrKHBb1V1sZ34lbmlmduPDI8VcRbS?=
 =?us-ascii?Q?8iMDzAX29hWcSi/qeIC8N+6JvGd6wZivj0yf9WkcfxZGjJ+EkyD66SDMRLip?=
 =?us-ascii?Q?VwLNNEAB4Tz5SS0/FYQyJmQkYH9h8py+3CnzWUxog/ttX2oDWR3ozpACyDF9?=
 =?us-ascii?Q?LInQk7WfBuXPJwNg+Qgi5GwVy3FJVuTgRfztQOjpyxK+L8NzbwobcI9J0HTp?=
 =?us-ascii?Q?fGH63npq9CGdQp9pE6Rq3QU7xJYHMZlr6wzHt7Wp6Hoa6paENRKhgeDmvpjo?=
 =?us-ascii?Q?ZvPVCzPb09LrB6rNy6ITqMjfpWZvyd61NErfVAe31bdebyi/HEMgKpznGP6U?=
 =?us-ascii?Q?xYMT87EfVHOv4aX2oJMLgjbxgU15mxwmJ1IfBaB3q1/FVmPuMO2wVTX6psJh?=
 =?us-ascii?Q?Rop+sQYWWrfl8ysqvPuDiJe2o3i+AfQQokiA7Xs5MhXxxTJR3+iI6HWOZRen?=
 =?us-ascii?Q?3Est7fPgtMmOiHl3HCBvy88M0rKVPlHth6B07aFaPIJ3wL/akXArsI3cu7sy?=
 =?us-ascii?Q?YdRTUZnNTXfAZgiVWxOgJYJTy54LhYLkKEQS5M+47H7rM5abcWzfM8yREuJL?=
 =?us-ascii?Q?gNsObK0R4+YToPvXVMflV/JwgU6VKig3L+rzBaKJV9mn/TO7W9SzNII4iIh3?=
 =?us-ascii?Q?VifEyJUVP5a7NcmcUKno5jiECYCDrImAFmjghvgVrmjgyqQj0g6K5QR4nol7?=
 =?us-ascii?Q?+VAYH0R76XYssIh1b3bemgNzL4P6/JcyiK1RJsTbkDJttvFdQ2o5oSmBmmXp?=
 =?us-ascii?Q?e/Tq9qO/OnVN12G0Wv3klnxG+kEiTdZM46Wy/jRhP8Mzp28v+7zCXp8oZKgo?=
 =?us-ascii?Q?pQ0ZPsHGBcRx78Gmw2BMbFaFUdP4P7RNCJnvWn5CLmmmXasVItCcDbhyp04n?=
 =?us-ascii?Q?vbZvVjT6NFqpJ9vh/wMk7doIoR7Haa6u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DeRmO0ndPzDRYNrtMdEJZjJgcABz2Y+OpMgyMrvgqjE0ZSlPrS9LrEQrysXA?=
 =?us-ascii?Q?8ChR6cJeF/gX+xwc5byV806kE/OdralptZp+Z2PzJhQc4iXYQ7xN1JRhIP6s?=
 =?us-ascii?Q?G3q1H2RrWdKqwnI4aTbqPF8p/ZY/OVstRMRhFPlAmJSqYn7hKaEEZps9nTyf?=
 =?us-ascii?Q?/g7opkKoJtxWTVwIgIdO2NSUEumAn0XQo7auaI9+OxWIdzljkzfxAuOcOkS2?=
 =?us-ascii?Q?xb4/tEqKooz7XJuj9zZITld5X6aH1kONyvaUDiGFqvvMhoHpaqBVBCkj96OW?=
 =?us-ascii?Q?r82R63gLjAnBDlUwNwpixSF2wf7qdpEPpjiFrQMHMyPFx4psBXTP24zj53EY?=
 =?us-ascii?Q?S7P77uZIVIQnGM9vLbYXoJNxj6d6XVDfFNXcwKcNKiutf7pAuP7mEB93fLCk?=
 =?us-ascii?Q?1kqlon6odC6hYTj7yITXZbMtcUHwFvjkuqIWqSNlfv+RtVP6Tp0np5QJPHvc?=
 =?us-ascii?Q?dY8EgnO+mVv2EpE5uY0JTktPQI+1vkv16Tgp8t0EKNmI7k+jJucM2gKdQYG5?=
 =?us-ascii?Q?J4HUnOMF7SZlrepZ25Z5G6WL8V+KoZygq0UY/zwJORVSkgtvK36o+WYqqoUI?=
 =?us-ascii?Q?6B2mr6PX/4nOnp99O+BCkUCM6kqLhK+5jhhWXxlY8+l9ZgTV+ZaeoF0CmEh3?=
 =?us-ascii?Q?Q6wGTUyrrYgSnzU31wjcyWcOHCsftyPvtpt5Ok/mpyJ7HI0vuaoWaCqu+u3N?=
 =?us-ascii?Q?lyc8Gf3NAxoTuj5QuKsI/HGVqzIIriWkXIKgdwveo3hOidGKZT1HiJTIaT95?=
 =?us-ascii?Q?jcsxbwqPcHHuZxriW0g79jHi3oC+imCi1NjFhpwR79NJGOAagC+BYCQNSP2h?=
 =?us-ascii?Q?SDrkx9uoAvFBtq90as8+eq9s998sLc+Dleg6RVATB7ioezeFthdUZOG1kusy?=
 =?us-ascii?Q?PbWnTIdrzL26Wa/10eta1FSylAEyrqM4EFvqwQTWEnXt5FKf/6h7DGbcnZzo?=
 =?us-ascii?Q?zgIBYP3pGxEgkx1XbTgd6Gw3umt37QznvvodEU39I2U1F+O1XfTuJmU/JlOv?=
 =?us-ascii?Q?34b7zzHyvOYvjxVasJ58XvIQRfUrVg8dFqbNp+k6Wm4QdcNbyQRwLWrTvoQq?=
 =?us-ascii?Q?EXgDFA2mOM3UxuzKefTS027OnwEQUAR0JgMgs7G5PCTQxUx9qK5d9k0wFnRa?=
 =?us-ascii?Q?ebf0aLdJw2nwNZ36Ec/FXqNSVIsq0X8JEpTntJYvZjqEX07UK2WShv68j0YR?=
 =?us-ascii?Q?6bvpHj+8m642gaVxdg+zfsMWWOMBKx0h4GO6AOQ1MVyLtmfFTIWONqufHDzJ?=
 =?us-ascii?Q?KfVGvAiejZQXEjfoY4aJJ9GrklvTfmAwP1UhGT4SO9YiAnSeC3cKa3llhf5V?=
 =?us-ascii?Q?xGjdRhkFf3jvsOcviDVLYcVUSrn9OTXrh3OmDSQcCou4IX0DwCgIeME9I2OZ?=
 =?us-ascii?Q?KwX+/9GX4K9Grj812h738F4oBd/mQKdJF18hPwmfC2HnC2tznsH9DLnlxu9+?=
 =?us-ascii?Q?ORpzJayNZhrMWPR2CNs+0F/eoTZcyukHBp1x53+X+M1TbK16P5uXUvZbLmnS?=
 =?us-ascii?Q?Tt2RiF+SpEoRsEiB46tMmZO9WYL+UMgJmy9lST3FFgTK656PvYlkyM5s5CrY?=
 =?us-ascii?Q?S9VzfFIsYI7CBxZ79NPCFuG4nCPDrgrNVL7/InF6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0af2c3-c101-4270-b81f-08dddf201f9f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 12:58:44.9664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sbrXzsVfER5+HAShsboaeTCpgmHXCu2OAET9RrRPW3mKiVyl82j8snHAxUitai1kuirWD3OqwHr16aVkZTXHbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9946

The NETC Timer is capable of generating a PPS interrupt to the host. To
support this feature, a 64-bit alarm time (which is a integral second
of PHC in the future) is set to TMR_ALARM, and the period is set to
TMR_FIPER. The alarm time is compared to the current time on each update,
then the alarm trigger is used as an indication to the TMR_FIPER starts
down counting. After the period has passed, the PPS event is generated.

According to the NETC block guide, the Timer has three FIPERs, any of
which can be used to generate the PPS events, but in the current
implementation, we only need one of them to implement the PPS feature,
so FIPER 0 is used as the default PPS generator. Also, the Timer has
2 ALARMs, currently, ALARM 0 is used as the default time comparator.

However, if the time is adjusted or the integer of period is changed when
PPS is enabled, the PPS event will not be generated at an integral second
of PHC. The suggested steps from IP team if time drift happens:

1. Disable FIPER before adjusting the hardware time
2. Rearm ALARM after the time adjustment to make the next PPS event be
generated at an integral second of PHC.
3. Re-enable FIPER.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v2 changes:
1. Refine the subject and the commit message
2. Add a comment to netc_timer_enable_pps()
3. Remove the "nxp,pps-channel" logic from the driver
v3 changes:
1. Use "2 * NSEC_PER_SEC" to instead of "2000000000U"
2. Improve the commit message
3. Add alarm related logic and the irq handler
4. Add tmr_emask to struct netc_timer to save the irq masks instead of
   reading TMR_EMASK register
5. Remove pps_channel from struct netc_timer and remove
   NETC_TMR_DEFAULT_PPS_CHANNEL
v4 changes:
1. Improve the commit message, the PPS generation time will be inaccurate
   if the time is adjusted or the integer of period is changed.
---
 drivers/ptp/ptp_netc.c | 260 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 257 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 477d922dfbb8..ded2509700b5 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -19,7 +19,14 @@
 #define  TMR_CTRL_TE			BIT(2)
 #define  TMR_COMP_MODE			BIT(15)
 #define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
+#define  TMR_CTRL_FS			BIT(28)
 
+#define NETC_TMR_TEVENT			0x0084
+#define  TMR_TEVNET_PPEN(i)		BIT(7 - (i))
+#define  TMR_TEVENT_PPEN_ALL		GENMASK(7, 5)
+#define  TMR_TEVENT_ALMEN(i)		BIT(16 + (i))
+
+#define NETC_TMR_TEMASK			0x0088
 #define NETC_TMR_CNT_L			0x0098
 #define NETC_TMR_CNT_H			0x009c
 #define NETC_TMR_ADD			0x00a0
@@ -27,9 +34,19 @@
 #define NETC_TMR_OFF_L			0x00b0
 #define NETC_TMR_OFF_H			0x00b4
 
+/* i = 0, 1, i indicates the index of TMR_ALARM */
+#define NETC_TMR_ALARM_L(i)		(0x00b8 + (i) * 8)
+#define NETC_TMR_ALARM_H(i)		(0x00bc + (i) * 8)
+
+/* i = 0, 1, 2. i indicates the index of TMR_FIPER. */
+#define NETC_TMR_FIPER(i)		(0x00d0 + (i) * 4)
+
 #define NETC_TMR_FIPER_CTRL		0x00dc
 #define  FIPER_CTRL_DIS(i)		(BIT(7) << (i) * 8)
 #define  FIPER_CTRL_PG(i)		(BIT(6) << (i) * 8)
+#define  FIPER_CTRL_FS_ALARM(i)		(BIT(5) << (i) * 8)
+#define  FIPER_CTRL_PW(i)		(GENMASK(4, 0) << (i) * 8)
+#define  FIPER_CTRL_SET_PW(i, v)	(((v) & GENMASK(4, 0)) << 8 * (i))
 
 #define NETC_TMR_CUR_TIME_L		0x00f0
 #define NETC_TMR_CUR_TIME_H		0x00f4
@@ -38,6 +55,9 @@
 
 #define NETC_TMR_FIPER_NUM		3
 #define NETC_TMR_DEFAULT_PRSC		2
+#define NETC_TMR_DEFAULT_ALARM		GENMASK_ULL(63, 0)
+#define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
+#define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
 
 /* 1588 timer reference clock source select */
 #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
@@ -58,6 +78,10 @@ struct netc_timer {
 	u32 oclk_prsc;
 	/* High 32-bit is integer part, low 32-bit is fractional part */
 	u64 period;
+
+	int irq;
+	u32 tmr_emask;
+	bool pps_enabled;
 };
 
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
@@ -122,6 +146,155 @@ static u64 netc_timer_cur_time_read(struct netc_timer *priv)
 	return ns;
 }
 
+static void netc_timer_alarm_write(struct netc_timer *priv,
+				   u64 alarm, int index)
+{
+	u32 alarm_h = upper_32_bits(alarm);
+	u32 alarm_l = lower_32_bits(alarm);
+
+	netc_timer_wr(priv, NETC_TMR_ALARM_L(index), alarm_l);
+	netc_timer_wr(priv, NETC_TMR_ALARM_H(index), alarm_h);
+}
+
+static u32 netc_timer_get_integral_period(struct netc_timer *priv)
+{
+	u32 tmr_ctrl, integral_period;
+
+	tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+	integral_period = FIELD_GET(TMR_CTRL_TCLK_PERIOD, tmr_ctrl);
+
+	return integral_period;
+}
+
+static u32 netc_timer_calculate_fiper_pw(struct netc_timer *priv,
+					 u32 fiper)
+{
+	u64 divisor, pulse_width;
+
+	/* Set the FIPER pulse width to half FIPER interval by default.
+	 * pulse_width = (fiper / 2) / TMR_GCLK_period,
+	 * TMR_GCLK_period = NSEC_PER_SEC / TMR_GCLK_freq,
+	 * TMR_GCLK_freq = (clk_freq / oclk_prsc) Hz,
+	 * so pulse_width = fiper * clk_freq / (2 * NSEC_PER_SEC * oclk_prsc).
+	 */
+	divisor = mul_u32_u32(2 * NSEC_PER_SEC, priv->oclk_prsc);
+	pulse_width = div64_u64(mul_u32_u32(fiper, priv->clk_freq), divisor);
+
+	/* The FIPER_PW field only has 5 bits, need to update oclk_prsc */
+	if (pulse_width > NETC_TMR_FIPER_MAX_PW)
+		pulse_width = NETC_TMR_FIPER_MAX_PW;
+
+	return pulse_width;
+}
+
+static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
+				     u32 integral_period)
+{
+	u64 alarm;
+
+	/* Get the alarm value */
+	alarm = netc_timer_cur_time_read(priv) +  NSEC_PER_MSEC;
+	alarm = roundup_u64(alarm, NSEC_PER_SEC);
+	alarm = roundup_u64(alarm, integral_period);
+
+	netc_timer_alarm_write(priv, alarm, 0);
+}
+
+/* Note that users should not use this API to output PPS signal on
+ * external pins, because PTP_CLK_REQ_PPS trigger internal PPS event
+ * for input into kernel PPS subsystem. See:
+ * https://lore.kernel.org/r/20201117213826.18235-1-a.fatoum@pengutronix.de
+ */
+static int netc_timer_enable_pps(struct netc_timer *priv,
+				 struct ptp_clock_request *rq, int on)
+{
+	u32 fiper, fiper_ctrl;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+
+	if (on) {
+		u32 integral_period, fiper_pw;
+
+		if (priv->pps_enabled)
+			goto unlock_spinlock;
+
+		integral_period = netc_timer_get_integral_period(priv);
+		fiper = NSEC_PER_SEC - integral_period;
+		fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
+		fiper_ctrl &= ~(FIPER_CTRL_DIS(0) | FIPER_CTRL_PW(0) |
+				FIPER_CTRL_FS_ALARM(0));
+		fiper_ctrl |= FIPER_CTRL_SET_PW(0, fiper_pw);
+		priv->tmr_emask |= TMR_TEVNET_PPEN(0) | TMR_TEVENT_ALMEN(0);
+		priv->pps_enabled = true;
+		netc_timer_set_pps_alarm(priv, 0, integral_period);
+	} else {
+		if (!priv->pps_enabled)
+			goto unlock_spinlock;
+
+		fiper = NETC_TMR_DEFAULT_FIPER;
+		priv->tmr_emask &= ~(TMR_TEVNET_PPEN(0) |
+				     TMR_TEVENT_ALMEN(0));
+		fiper_ctrl |= FIPER_CTRL_DIS(0);
+		priv->pps_enabled = false;
+		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
+	}
+
+	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
+	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+
+unlock_spinlock:
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static void netc_timer_disable_pps_fiper(struct netc_timer *priv)
+{
+	u32 fiper_ctrl;
+
+	if (!priv->pps_enabled)
+		return;
+
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	fiper_ctrl |= FIPER_CTRL_DIS(0);
+	netc_timer_wr(priv, NETC_TMR_FIPER(0), NETC_TMR_DEFAULT_FIPER);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+}
+
+static void netc_timer_enable_pps_fiper(struct netc_timer *priv)
+{
+	u32 fiper_ctrl, integral_period, fiper;
+
+	if (!priv->pps_enabled)
+		return;
+
+	integral_period = netc_timer_get_integral_period(priv);
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	fiper_ctrl &= ~FIPER_CTRL_DIS(0);
+	fiper = NSEC_PER_SEC - integral_period;
+
+	netc_timer_set_pps_alarm(priv, 0, integral_period);
+	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+}
+
+static int netc_timer_enable(struct ptp_clock_info *ptp,
+			     struct ptp_clock_request *rq, int on)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+
+	switch (rq->type) {
+	case PTP_CLK_REQ_PPS:
+		return netc_timer_enable_pps(priv, rq, on);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
 {
 	u32 fractional_period = lower_32_bits(period);
@@ -134,8 +307,11 @@ static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
 	old_tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
 	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
 				    TMR_CTRL_TCLK_PERIOD);
-	if (tmr_ctrl != old_tmr_ctrl)
+	if (tmr_ctrl != old_tmr_ctrl) {
+		netc_timer_disable_pps_fiper(priv);
 		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+		netc_timer_enable_pps_fiper(priv);
+	}
 
 	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
 
@@ -161,6 +337,8 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 
 	spin_lock_irqsave(&priv->lock, flags);
 
+	netc_timer_disable_pps_fiper(priv);
+
 	/* Adjusting TMROFF instead of TMR_CNT is that the timer
 	 * counter keeps increasing during reading and writing
 	 * TMR_CNT, which will cause latency.
@@ -169,6 +347,8 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	tmr_off += delta;
 	netc_timer_offset_write(priv, tmr_off);
 
+	netc_timer_enable_pps_fiper(priv);
+
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
@@ -203,8 +383,12 @@ static int netc_timer_settime64(struct ptp_clock_info *ptp,
 	unsigned long flags;
 
 	spin_lock_irqsave(&priv->lock, flags);
+
+	netc_timer_disable_pps_fiper(priv);
 	netc_timer_offset_write(priv, 0);
 	netc_timer_cnt_write(priv, ns);
+	netc_timer_enable_pps_fiper(priv);
+
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
@@ -215,10 +399,13 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
 	.name		= "NETC Timer PTP clock",
 	.max_adj	= 500000000,
 	.n_pins		= 0,
+	.n_alarm	= 2,
+	.pps		= 1,
 	.adjfine	= netc_timer_adjfine,
 	.adjtime	= netc_timer_adjtime,
 	.gettimex64	= netc_timer_gettimex64,
 	.settime64	= netc_timer_settime64,
+	.enable		= netc_timer_enable,
 };
 
 static void netc_timer_init(struct netc_timer *priv)
@@ -235,7 +422,7 @@ static void netc_timer_init(struct netc_timer *priv)
 	 * domain are not accessible.
 	 */
 	tmr_ctrl = FIELD_PREP(TMR_CTRL_CK_SEL, priv->clk_select) |
-		   TMR_CTRL_TE;
+		   TMR_CTRL_TE | TMR_CTRL_FS;
 	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
 	netc_timer_wr(priv, NETC_TMR_PRSC, priv->oclk_prsc);
 
@@ -355,6 +542,66 @@ static int netc_timer_parse_dt(struct netc_timer *priv)
 	return netc_timer_get_reference_clk_source(priv);
 }
 
+static irqreturn_t netc_timer_isr(int irq, void *data)
+{
+	struct netc_timer *priv = data;
+	struct ptp_clock_event event;
+	u32 tmr_event;
+
+	spin_lock(&priv->lock);
+
+	tmr_event = netc_timer_rd(priv, NETC_TMR_TEVENT);
+	tmr_event &= priv->tmr_emask;
+	/* Clear interrupts status */
+	netc_timer_wr(priv, NETC_TMR_TEVENT, tmr_event);
+
+	if (tmr_event & TMR_TEVENT_ALMEN(0))
+		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
+
+	if (tmr_event & TMR_TEVENT_PPEN_ALL) {
+		event.type = PTP_CLOCK_PPS;
+		ptp_clock_event(priv->clock, &event);
+	}
+
+	spin_unlock(&priv->lock);
+
+	return IRQ_HANDLED;
+}
+
+static int netc_timer_init_msix_irq(struct netc_timer *priv)
+{
+	struct pci_dev *pdev = priv->pdev;
+	char irq_name[64];
+	int err, n;
+
+	n = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
+	if (n != 1) {
+		err = (n < 0) ? n : -EPERM;
+		dev_err(&pdev->dev, "pci_alloc_irq_vectors() failed\n");
+		return err;
+	}
+
+	priv->irq = pci_irq_vector(pdev, 0);
+	snprintf(irq_name, sizeof(irq_name), "ptp-netc %s", pci_name(pdev));
+	err = request_irq(priv->irq, netc_timer_isr, 0, irq_name, priv);
+	if (err) {
+		dev_err(&pdev->dev, "request_irq() failed\n");
+		pci_free_irq_vectors(pdev);
+		return err;
+	}
+
+	return 0;
+}
+
+static void netc_timer_free_msix_irq(struct netc_timer *priv)
+{
+	struct pci_dev *pdev = priv->pdev;
+
+	disable_irq(priv->irq);
+	free_irq(priv->irq, priv);
+	pci_free_irq_vectors(pdev);
+}
+
 static int netc_timer_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -375,15 +622,21 @@ static int netc_timer_probe(struct pci_dev *pdev,
 	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
 	spin_lock_init(&priv->lock);
 
+	err = netc_timer_init_msix_irq(priv);
+	if (err)
+		goto timer_pci_remove;
+
 	netc_timer_init(priv);
 	priv->clock = ptp_clock_register(&priv->caps, dev);
 	if (IS_ERR(priv->clock)) {
 		err = PTR_ERR(priv->clock);
-		goto timer_pci_remove;
+		goto free_msix_irq;
 	}
 
 	return 0;
 
+free_msix_irq:
+	netc_timer_free_msix_irq(priv);
 timer_pci_remove:
 	netc_timer_pci_remove(pdev);
 
@@ -395,6 +648,7 @@ static void netc_timer_remove(struct pci_dev *pdev)
 	struct netc_timer *priv = pci_get_drvdata(pdev);
 
 	ptp_clock_unregister(priv->clock);
+	netc_timer_free_msix_irq(priv);
 	netc_timer_pci_remove(pdev);
 }
 
-- 
2.34.1


