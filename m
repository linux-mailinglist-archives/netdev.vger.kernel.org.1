Return-Path: <netdev+bounces-240534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F40C75F96
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 19:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C899D4E1294
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 18:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E691F3BA4;
	Thu, 20 Nov 2025 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J4zymTbL"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013009.outbound.protection.outlook.com [52.101.83.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE1A1DA62E;
	Thu, 20 Nov 2025 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763664579; cv=fail; b=uqAXb3KYB9BTh/SklpRr8xafs20byLF4xUUju9+ppzXVejG0OXmd2+XkotxS40MXGEFIGKt8PlWB5vKyWegwGXCLxvcTPcKDxwpjYH7068uK7GyyfLkwFvNmJE5XioDKOvG61STquvBdvaQLcMXK4iQcnBQE+iandm7+gylIDkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763664579; c=relaxed/simple;
	bh=pFg7jw/X/VmfOOpmxVEJBSzv5W8QHx0AE5yFaGuSO74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B7NJNN4fSlDT3d8L+h3hDu1k6d8L0zIgFPO8F+WOikF99P/6N+SzzwBYkKWhoLGhPK4W7bZ+uoJD8chxsf80WYl0445G+PUYI0i/1XkgnrV+j/IgC04osZrIto1Yzq4wXgdjY+ZEWAztkol3D2vqS3G6vbM6mOEiIXSbY3C48s8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J4zymTbL; arc=fail smtp.client-ip=52.101.83.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yp3bTcpj96XmMkEwJ3EC++gxe92mf8HkNVeIq6hpXCp1JpLc5PQCMXgatNiFYYuG7uTi15bNL7MC6LxZS3mh/AsXFLc5weF+U7ZlWj4sF3Yqndlxb8ytDLe+sNWst3ypGIoVAvjHn8L4+1oOZffwhWD80o6yuOHuhgS8bigCwfOnF/zbduDWfc6JBcYMWzI/wfnqJ2g/mrTm2ZD6o3WfM47hXdV82puV+L4jBXfWEsvPEPHPWCOxxF5LMu/n9wWInu8qedmCE7XgVguWW873C5LYmpMbHrUUIfQBKm7xL1xwnJO4xsmq9JNoO7Vxh4FEz96ScwMb/MOTSw25QUwRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mR5xDaUNxdcxAj+WZ7rSbct8Jjo5D3v+8VFJOsUusAE=;
 b=eWm4/vdiEpK5cJUKhokSPTXO/r4D+zm1YjKj1SgcyeikKRXcClCcvkbJ4iAK8PdyPyyIfbxkT1HCkknR+/M9fVzpCRQlUvo/ZrVnDU1aCYeG7j2PmQbj/s/Q9rKpCk6vs7ZN2SNWiTddXKzmT+W1SF79/KefXPG2mtWB8L7oKFtcDMbQF+7madXCBYsiVjGt7wM1GO0EtW+JRPbKSRcBpm+1si+3WFhsD0meWkhw6JGaBX92EZvAj/j3BUtsHGHpII48autrpXjJWZG4VgQpll66j2Qy5qvmu0xRbwrE+owap16x7CEGQGoki2JZuW1GICdIx/h0N6yQJiq9NM52fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mR5xDaUNxdcxAj+WZ7rSbct8Jjo5D3v+8VFJOsUusAE=;
 b=J4zymTbLZlHgd0yABnVoxij2Llil1KQ5bsqJrl3u3UiSbQSgTQ4DsZaAhtpHpDGXEf6L7TvHyZs/IYOXUjXEDeOqeOmYbkRsPbtZKSfTgHdW5wvdHUr2opUYVFOq3JYRoFswk7tUVCcoYiNoqx/4Va/Wp3XUkzBSsQnCldudi+pF0gg1Fk+R0bqwAgNFyTl3URCkgk7R9fReVYHEaR3dAEwbLtF80wo4L07PSvccVyGKw5FpphLSoNSe8/bUqIdRlDAWSHfcYSnorODJgjyz/9v/o1Kam0T0VzktiJumVoLSh97829NtJbvxFUSceRpHlMAyRaRGWlTtwQgBRR2P7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by AS5PR04MB11420.eurprd04.prod.outlook.com (2603:10a6:20b:6c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:49:35 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 18:49:35 +0000
Date: Thu, 20 Nov 2025 20:49:31 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 04/15] net: mdio: add generic driver for NXP
 SJA1110 100BASE-TX embedded PHYs
Message-ID: <20251120184931.fanw7fmcyh7d6ef7@skbuf>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-5-vladimir.oltean@nxp.com>
 <c1e5871d-2954-4595-b879-e51766b7bf48@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1e5871d-2954-4595-b879-e51766b7bf48@bootlin.com>
X-ClientProxiedBy: VI1P191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::16) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|AS5PR04MB11420:EE_
X-MS-Office365-Filtering-Correlation-Id: f806bb0f-b4b7-40d9-d696-08de28658caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5H5Uv/7qbpMZOEw9pgotAB1f0DqZNPiMxuvFMh7ZxRYIgh4N3ZeSgdWEDr9f?=
 =?us-ascii?Q?5DolkRHPFOnpHnfILwgkIb87tB87elYNbr1mtnDSDMisWB8dMJzcwJLjnUoU?=
 =?us-ascii?Q?4juA7nhL7y2M9zJzsOrSHr8ID+Zvbct174N51FL3XAMDAiy4kHsc8caGrvCk?=
 =?us-ascii?Q?9PpVRazrOu3c7NUrT5wlDj9YYJcd0fTISgQs46SHMMB+cOppj60ynAs1IYWM?=
 =?us-ascii?Q?r7CRmnOAJBWt5/RiDLKZQZvvwLrDgoKsOd8vnvmY/hfBHC63U3c9FNVOjUeF?=
 =?us-ascii?Q?T6Xr16pxlmx+HhFHqv9IvUQyScgO89FbwRXcKWp4Ylhcu+4hFh0Y6fbPgkxt?=
 =?us-ascii?Q?xxLNDgGgVR2NmbOmGXUEe0A9fMCqxQ02FSLNhl9OVtI963odewaqpl7YgP32?=
 =?us-ascii?Q?PdMkgaofUeLrhZjEYK1oPKmqe4wVTH/7OFUqgW1OMQ1HeHhWiMgxtrQOZpi8?=
 =?us-ascii?Q?yo/sMV0ojXMlqwgSDticcftntYoiplkDuMFje8JCK0BbTnGc2dfvprHrh7un?=
 =?us-ascii?Q?Imu+8z8wpO5/YmV0N9FirCDlTl2Xt8BQ7sPd+dgIhmnurEVdyNH72CXoxS/V?=
 =?us-ascii?Q?tFl/x/t9rapRYf2dJQ74k5UeUGGso861faTEd8f2dgVtwlh2McMrdW2LGkQK?=
 =?us-ascii?Q?vMXrxgIbcUs7Kc/jboB0Bahhnp/MKzW2ry05nqAI5V5xw5ss4wpNbsWyZ8/z?=
 =?us-ascii?Q?/hvNNZCRroGx7qGL5zmJV9n9GxJiZX5KMZFyzLhAtB4cjdzxmWpbXNS9HbST?=
 =?us-ascii?Q?MTKKZZ9xX3oRbvHT2N0Z+EyB2Ds+YwdVMlYL1Pmr/M5gq6Sbc/RbCa+WfLAe?=
 =?us-ascii?Q?zUj8lEYYw9a3VqUWhCbgum4hz3/VIZsHgAUAMdwBznAsJvxXOFJjir8YCUL0?=
 =?us-ascii?Q?h/3ygZsVzGFhRgyPoBIkRPXbMKznq9DRWZQy3mJMIv3Re4Fxoq5fW690sZIk?=
 =?us-ascii?Q?bYjl4CpZuj7bd29eMYi8DI8c5UH6N61WX0W/gmMxUSIgG1q1YDBsctE6VKuV?=
 =?us-ascii?Q?wQ0WxmcdXz/BPBBZtLfY+Y88hUf9SWvItCB8bwazsskARBzD7lQOtwS3KOZc?=
 =?us-ascii?Q?wflSw23PlKpYYyHRn/MzK8Y9Gk2tMgsJ6BLBWXiTrNpQpUNWUF1jluvMD9fE?=
 =?us-ascii?Q?noopDdOEmu8XcKw8jUt88lr3+ksh4g3mMyfPefnNXQ16JHuKoWixgcru1rpb?=
 =?us-ascii?Q?9kCketIWFT7IlS2H3E8bw84/A8WFnLL9YXTMidvi2WiRsAHRVemWTDQO6yKh?=
 =?us-ascii?Q?mC357mSy0gJULSXH29TfvFoDSZfnnW3HHeSdJdPfiWQTik/X2WYBFwjE5/2b?=
 =?us-ascii?Q?07sYF7hzgJ9BSQXnOJCn6HLusvbvGoKV4tZJXpWwD3+7ssNb8Y34Z2/f7yzQ?=
 =?us-ascii?Q?1HCtESm1nEMdRAxb2kIOyU4qMNMwqlVxTVSkunh3eu8D1iD6gG3av6vjgIaF?=
 =?us-ascii?Q?TP+OxaWN2iP1lEDawXwrNBijFvlUPETR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(19092799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?178QTBn5yQz/few/xUeWddCFBTfBOrOmBW1iFnUwBSZPn3mLazTr1UxJXneA?=
 =?us-ascii?Q?ZliuCUT9/X9MOgTXFg/OfdNQI0gsLDtr0kyLF5dbB0X5LjGrEX0LlGus81ig?=
 =?us-ascii?Q?cdiN2Ye6gLBopQcQjU+Bxsp2dDd1JQGa4Mn3zWOUcbwWauPYVtgD1d2PKrlW?=
 =?us-ascii?Q?O7QyZaEJ3rRufslryknFvEWOkqjMKwdN4EKGJWYrEl6FSPGmeoX6GEKJH5Hk?=
 =?us-ascii?Q?epR3MJLoCa85Vb1vCQJnfGN/PH6jgauvDqqZpKWDPOMBddG6XnPr6lgcPlvi?=
 =?us-ascii?Q?7j8Ji257FzO7rp4lPcAxGicktAXIADbGyVd0vg+BbnrYNL+tIOx7dHkd3Og/?=
 =?us-ascii?Q?l0gvBBSR2K7LphOqdUjetzrwvoas3D/L/nwAf6iWAqQpUEJW5QnQmFxBatU5?=
 =?us-ascii?Q?VEm7m139phd1lPM+rxwx2wKXvfSC5ne95q/q9z8GnoFoItRF98CO/xGcnP+5?=
 =?us-ascii?Q?ct/M0Hu0RnKEKyMDeA1//hl6o8ddMMB2Cx72nWViHHvSzrZCRUv1eD4PoXUj?=
 =?us-ascii?Q?Wo7zK4EiAQyqe/NAsklf3h/pdveaFgAm+yJm5aQ/U3TrQ6360TefrrU031h5?=
 =?us-ascii?Q?q7ITBX+Ag1sTW+3FayRrnu+00moNbmbPFJc8W6JDd192fNyOB/ItxUPSj+Lq?=
 =?us-ascii?Q?CmQsEhv0/g/bT0v7iIxlDAJZKkfldxoU1aGXSCzt2NcMT867nP4ij/TyTY2Q?=
 =?us-ascii?Q?qRhCSe+K4fMVTHkx6bTyFGY8wXHtTDdkB1jngek8B5KrA+wQIBiIOnliBVkD?=
 =?us-ascii?Q?Ilv7ufXSZSe+azRvJD0H8jELdGrbmsXwKyhBaei5duwUpUWLqNV7R4PT7lMN?=
 =?us-ascii?Q?TS0L+wd2gv9g68mRi1VjcquZXIIQBcWloPIecycsEx4GYXpj8IdgqoCAlDTJ?=
 =?us-ascii?Q?vuKuLd6/2GQi2JJO4L59apDRxzVgeni++eyAZlz2fLONGWK2OyWYTG3msGYd?=
 =?us-ascii?Q?ndvLh2Bogi62HHnxLZJyJMbNTYKYONCMa/zdcOw1TMJQ3zv+HDR2yw3oWclP?=
 =?us-ascii?Q?IcyseX4PjkDm1Mxolli31Z3BetdcWupU3NggrgKzVE+k/uUqFwb8kfn75Va9?=
 =?us-ascii?Q?9Abon+Sy8xC0vm1zUWfvn24C9iuqUQqqOIFLt1nFQr9FXzHsHsLf92/e3UH3?=
 =?us-ascii?Q?SGugUZDoLD7ZPHudAt0J7ZdHyYPiqAhnnkqB/L/SOn3K60xNLT5VniW9km8l?=
 =?us-ascii?Q?pPleyriYoYW1Wi32Yh3Lgf/VbBsIxOX/EI0quEQiD5KncPgYCPItg5Ybp7DN?=
 =?us-ascii?Q?jjYqySWBqyhFx7UA1Zx5NDgJ7n80XXHp9mNWSA/FUOpJVx9pAIH5IsRF0sa/?=
 =?us-ascii?Q?p1EfsFCRZiuiuci6Ok/t+YsT0roV/JJcZUFikAeP+X7meI+XhVEAriDgTmxx?=
 =?us-ascii?Q?zH7uUrE6jnSawkQ1x89mhnj62LWzYiZzpsLSrsWCXxWEYgwfqOdYirgYoQD5?=
 =?us-ascii?Q?sfQ+IsSsONM+aDgjBa/5eKU1emUqwCocnbTNPAf7KgLtdQ283I4TIzMEWwSZ?=
 =?us-ascii?Q?EwjOC0Y4+nxv9gAAAe0NR9hESO5cDYk+BRd8/2nZA9HEMqAj0+cvPVC7MRdy?=
 =?us-ascii?Q?tGfrIxXEPKVKe34mi/pPPDfe9lDo8iB+Dg830oAJ0CqvaagWOfm7M/SrNXnQ?=
 =?us-ascii?Q?FK3TxONmYYNzdJSMxdhDTLxmz7CAjzcGYIs4JYdo2LrWPz0hpSNyPkIzKQmg?=
 =?us-ascii?Q?NcJbew=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f806bb0f-b4b7-40d9-d696-08de28658caa
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:49:35.1822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1z6VkFmOcLV574Fy0kZeH5SFHhxfw2j78wdvafZ3RpFmCMuImkXwsmQmkaHpYDbkECpZQ1QxaPwize2QZO01fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11420

On Thu, Nov 20, 2025 at 06:55:56PM +0100, Maxime Chevallier wrote:
> > +	config.regmap = regmap;
> > +	config.parent = dev;
> > +	config.name = dev_name(dev);
> > +	config.resource = platform_get_resource(pdev, IORESOURCE_REG, 0);
> 
> Just to clarify, a small comment to say that it's OK of
> platform_get_resource() returns NULL maybe ?

Good forethought. I can already imagine tens of patches to 'fix' this if
merged like that..

Thanks for the review!

