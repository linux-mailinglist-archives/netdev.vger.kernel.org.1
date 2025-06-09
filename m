Return-Path: <netdev+bounces-195653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A215AAD1A2C
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 11:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 720DB7A59F2
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 08:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7896524EA90;
	Mon,  9 Jun 2025 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="P8zKbqbF"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012029.outbound.protection.outlook.com [52.101.71.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E491E3DF2;
	Mon,  9 Jun 2025 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749459610; cv=fail; b=aHAybg0TU8ejNOlHOG1v1kUR7ev4vjVo7xAno20vMGLL9vZf/uD7Jb9gMAjxxqxZIcb3ooSZC4UoQUNUMUcQ0F12BlbZEB3hTjlrY/SIk+plOE5zf6QRad5CnwmiJ0DICa/O1U8o7hEfyrCJXHv7VT9niKXBr8zJS1dU/vBKrT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749459610; c=relaxed/simple;
	bh=Xg3uqwLau6uRT2rxwp9wbYuLM7oEmnYIWqsqRPmi9SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fGfHl/Q3vMr7CmQQ/AjomLRzcw8g3X9bsPzodI4Vv/fzw+eiNPanja+0t6mxU3VpbEDQNHdb5hnjNtRgqmjerCNt6+Jfvgo4qGwXdutQ3c17465y44O6qHl9w+4DUhWoEXk8IjjNgODqflPVcEWAVAwZgMJLSqDXnFCvZJEHZMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=P8zKbqbF; arc=fail smtp.client-ip=52.101.71.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCeYa5gBC+z1zhKUiF2JHcu72KG/dAESdkG84gDRlVL0F5pGfwoaGBlpXcPittw0Q3wIE6Z7V8LWiFAaxH+dy8hOKTqZXDyjU3jFSisCxNTd5cf6+VY+cFs5rf3cMznxfUAMXG+MriynzIOkKQoONnMfh56TPzAhWKOq1E23zYp39TuSY2x8u0dFxmV9+vpXZ0/q3hnXxjIHhcrGhKwjPerbgVZlnaTzKNeG2/BQ2bAHM4DJGv3ql0mTCQ6wVWSLAM4g3LsgYVqQt98CSWhcUIJR1PMoAL+47c59AZ24FIwkRzUzi+KdD1tx0BKtr3Max039/5c2tVAMMZapDfvBqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xg3uqwLau6uRT2rxwp9wbYuLM7oEmnYIWqsqRPmi9SE=;
 b=gFIw/hG/3eyAIUWeMKa/k2HMUgX5Ccq5X3DUdV8qJ9/yV23GcX9tgK19mbk7qrEk3Drytyqvpsuni1FbwO/XdXU9HHoBPNk9wkE8trS9Wh7n1bf/Ahh9W97CcZG+mXll5uU1D+NDH8R0IFkgL9IztQIS6qn0YaoEzZvL9P1yE52gJGunGaPJLhwWmdC4hzQQJJNpJk/nz26V5l3Is8M3l6ivIba42WEI63nl28H0VdHAcJm/JkTGeF7qa2CIoiSOd663RuEslCTcunur5baxNzEuN/zp5edfbJYghsLniTTpkBkOvwwiViXTOZDBZIpq9DlE1/L8zvOkdbZNjGEpsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xg3uqwLau6uRT2rxwp9wbYuLM7oEmnYIWqsqRPmi9SE=;
 b=P8zKbqbFlNPIsyUGkI7uM3lvjaipzqs6453d3eiyp72lvf2IVlD/74vo8+7ZH3FF+l3caffvTrBPX+NY8I+t//a4C7bXTg9e0uCm3/dDh+t8V1OOe9l6eDfuzHZuWmd/BQ4LhBa0wD7w1v1Vv6zXwdPbdFABo3lez3I6w1SG02it9nm5DhxZEQ8w6Yf3j8iT9qJTUoZwVlEbARn02zB/5elN6MHE4wXv2+dcsLBdDyfbJ3Mbiju5daEQ2+BH/f2JeDbXXZLNs/+WSBN3qpc6mct96TAwFGOrwDe4y80KVHuIfnu9tWqekHlBN84GSlzdKT/MkAgTOAYJPsIWVtJxig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8628.eurprd04.prod.outlook.com (2603:10a6:20b:42b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Mon, 9 Jun
 2025 09:00:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 09:00:05 +0000
Date: Mon, 9 Jun 2025 18:10:12 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:b|_)ptp(?:b|_)" <netdev@vger.kernel.org>
Subject: Re: [PATCH 2/6] arm64: dts: imx93: remove eee-broken-1000t for eqos
 node
Message-ID: <20250609101012.GK13113@nxa18884-linux>
References: <20250605205853.1334131-1-Frank.Li@nxp.com>
 <20250605205853.1334131-2-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605205853.1334131-2-Frank.Li@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8628:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3cfef9-1f7d-46e9-62f7-08dda7340715
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NKUZXfXeHAdfIFQWZJrWYO1nTxqtTuPKghdZTAVMENu2YNmmoLxwLsHf6mXd?=
 =?us-ascii?Q?VQujPVoPf6fMhLp98whQT1Muq+hTq00Elv4pOFF72bX1IKDY1GScgjmcOti7?=
 =?us-ascii?Q?1zGN0cn90/LaMhtQZEF4bNRk5uWL7xuF+8QE6cjDxUqqY8dBpvnu4UiXuxi3?=
 =?us-ascii?Q?DCjA9wfbO9/iwOXaKT2trBRVAE0yVMTZEY50hntT2vozqS5PEbn+eaoAy/dS?=
 =?us-ascii?Q?zDwm9AclYcz+Bkqkpx4Zz6Pboi+mnf3fkcLwMWUsG9qYJFcJ2EM3gJ8hefVs?=
 =?us-ascii?Q?qxB4NDonfz/KRqXmhz/ki4RGxuumI4CuXRAM4kHwJ4cO2jaE5ajtygl0S/i7?=
 =?us-ascii?Q?MpLHMGPm0hRS6Xik7rcE2xJy91+JCCKIlXItxXXoijHJsJT4G0MHzjfPHztQ?=
 =?us-ascii?Q?JHWwBhHSKGQsCmaGHlbTAkEHbP5ec+QvzpQkDRyIe4S1MCy5iEdWXW9oDykQ?=
 =?us-ascii?Q?zb33cj5Xv5QZd9ztubF1trFm+poHgoYuTCTqlMRAOqAlDSguMhobfDf2MIW1?=
 =?us-ascii?Q?fQKURoh0SROwasqXT0ffA7w8/rP+9SF2sX/vu5h4/+G2KCIAgAPfUSAi4SEG?=
 =?us-ascii?Q?GwirtjrQn2TZTWmsO6UFKMR5qkgUSHeZv9xN5z/GOlCraFGA3Q08YPfuBIRG?=
 =?us-ascii?Q?/kcar5xmodaqhJ+2G+TCdMMK9zV5S6fYI4Z9NiHQ8CHxBVwEpfws+0Vcvu6B?=
 =?us-ascii?Q?cPvm1Vvx6zzzle1sXXJARmv+e9YBD2YxyP6iKUaPWMlwLZ/PMvfHdH8SiRJR?=
 =?us-ascii?Q?jU0Up/BBWxwoFgiB6fhwbZbyyPE5IrYmQqPMGz4I7xR+xptWrWrLeAo2GXqt?=
 =?us-ascii?Q?Z2BYIT9rtOaIyIRXYdn/m1lEx9LvLZbeN5J7IvlcXWku99WM+0x4HZUSM0w1?=
 =?us-ascii?Q?jyUvZhFF4M5DQv9iKsXB9Cg9A/Jmq2Yg5+czO2Brz+JNQba1xyDKH4EF8OYM?=
 =?us-ascii?Q?O7FA1pMtO9AoPSZnwn4uq/B6owQvS90ju4FFI+Z+cXOG4+hq0Pu+ooZKAlhG?=
 =?us-ascii?Q?yBbUHlQhj0LUSfjp2pJmh+XYHRRw91CO7KWVtSd68xWSmzII60RKRWGeq7YV?=
 =?us-ascii?Q?9Za5pWDTuQL3NA/Bl8OhpIyjTtIA5aS/50QZd0/FXo1oWeB+SIrqiRrTabyV?=
 =?us-ascii?Q?O89tVwceri+Nwnc5fKmPBbJKMgsthQjkXqO6Kx/SanVugwsMrjC7O6u5fsUJ?=
 =?us-ascii?Q?3hVyZDIvvKtCjx7JRZeRqrR5umhdc5kTheVjH87pSVs/vS47ZsTKm7U8jWHY?=
 =?us-ascii?Q?vZFbMGTbhFvFc86aq2VPrIxvK9Sv4yLtCaslqgBzygc7D4vQu0N6nTXRFHT6?=
 =?us-ascii?Q?9EfsaEPJKkQvyc9NjX0+pMKvxBOBzLZ8RO8w+B+1Mctwr54trDiyQXPSSyVT?=
 =?us-ascii?Q?EaZdGztgyJvX8l1WX/IpkizYg+r9yfWyh9COG+mwFSmCGP0Ql7mYKLrNXITY?=
 =?us-ascii?Q?PCTVr0vnCsy3KTxeCBtUMsmIkjn6oE2mvPfdFFCXiSeqNBMrk0e5ew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G9vsKPkFRR9WlaK/0d+U5EAWquTau82kvuNBuKiWtUxeIvsMQTBl5DVJfmpi?=
 =?us-ascii?Q?0Kt2lM0btTu8eMhM5ABuEBj8z1wdpPyvGhkUWaYxiAeGnGGpEagewpfEHbfV?=
 =?us-ascii?Q?9cz7WbOLmJs4QkQpzCSezR9yB67O4dQr0rowHukrz1TD70h1x7V2OajnocT+?=
 =?us-ascii?Q?GZ2IzYreUuz6koURcO17veZ4eJ/fsdNyQaFMaC3AX+9phGQ6uztT24h+uKVf?=
 =?us-ascii?Q?M/Ymutk3ISO3BxFefRjiBUHdh8BVYu18hYHDYG+KXEYl7QHDzaNB1Sq2YFHV?=
 =?us-ascii?Q?ux8W7eXvWuVW8Z+iFtbaL1Sa521RGnc/F9kbNMaLbCYzvKKs2pH2BiP1Rui8?=
 =?us-ascii?Q?vSYyMOiF9IrWJ904wsjVzXK/IHxCUwmviq97Xm5buyspoYmV2A0F+Hht4CWo?=
 =?us-ascii?Q?CLsZv4E7EORfqbkwiKjXu19e7CgcW192U0I9PRMmNSzR48mvuY69RlehnwOa?=
 =?us-ascii?Q?V+T81vP4TC2chfmvr+TAUJdRON5YMjveoP4SNbdJogXcsaa28kd8RvsGbj8G?=
 =?us-ascii?Q?rDZbBwDEwYZK+a5TopXQTJjiSBkxfUtb35QMPH6nSFkYCAqJxqYyXAIpAW/w?=
 =?us-ascii?Q?276YRvzd4Bq9mediuv5KbpNQ8fgjyDBzJbdPvwCuAt/vRTI+QimDeefoc6l+?=
 =?us-ascii?Q?AT9MamoRbjE/zMIdrCyDG4e1CoPBgwdDfIyUezNIFAA/JIpks/eKKlpjp4CO?=
 =?us-ascii?Q?xsMCIHzvXJkhQRA4+gbKCsdq1UdKNp4tXDTQE4afqQP4ucXCs6J+U32r7rpE?=
 =?us-ascii?Q?mdfneJu8rc+78iCKOMi9JqFl5pR9YT5ngaGs1L0r1Fw+mggvhHvzuAweR7ym?=
 =?us-ascii?Q?byVrCnDB9e99DNQW41Ijw9kb4LRG3FNGU8D/WXNrz8UWmD74udkq0R4g3FrX?=
 =?us-ascii?Q?5mqfghcjdyeAQ0j4ocxk9yKuRA4jxhKFEtKyeK9VOtyZN7BpHxya1POaVMv1?=
 =?us-ascii?Q?tzp2QTi0fxeEpHkOFufOWm8Kmn2cU6MlCOuNYiYJmz/8hXHTRwCyHFGlAURE?=
 =?us-ascii?Q?NjilhSw/F5ygAtfn28FUoJdyTjngLJKp8J48n04fH/uPKjYXVUcH606jC5yA?=
 =?us-ascii?Q?OHsQVe2M+a0qP3ihsGqbKHNbRFhv10qBn1DH6agpLAxHj3oGp+0dhgZF1APD?=
 =?us-ascii?Q?MycqX59K/QHMBnSaiv31sfTj0NHVDrWV/jrcKjccHbOqtzfiHLtxg/AWEsoJ?=
 =?us-ascii?Q?gQ0NaARKzq/vWWSoFlNhUW15n5HbQKveO/kbL4Ai3S6ojBQekuAsPG/ubzu8?=
 =?us-ascii?Q?ab0j7wfy3OtbE39rWHBH+TsiVwISpCYSkHz6E0VtrsfTpmq/Ix+NtzR8F8Wb?=
 =?us-ascii?Q?PhWCrHW3/HROv3mQSFYYGi7Rkd7amO2mRpmUkt+UnXJYcFJv/qw+qUiize21?=
 =?us-ascii?Q?ukMniv3uijAO4ykCx4WlZpspIMiJxkh1kdQdkXf2nwsXAG89GnnNWcfH4h8T?=
 =?us-ascii?Q?9lv+xpT4QbAlyx/DtzdYmIEFDvWuVg9cDj1Lfz5U5ppq3ucGb4pUdbWDcG1q?=
 =?us-ascii?Q?vqadbjjGpkBaWjfnyDyGzHUqFx7JlsWdX2JeTV8qun7t5huSnYK/Sv65aIoZ?=
 =?us-ascii?Q?jrU4EZ1Xpei3Iz41dGwsEkeibDaAIPhgas87uVNk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3cfef9-1f7d-46e9-62f7-08dda7340715
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 09:00:05.7081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2ZU1S66P+oks4/9JrnGqsIpiptOaBccCQ9X8Z49Vb8IVi4wCH67rFB9DsC5YQgppqeogVXS8PvjkNHiXATYHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8628

On Thu, Jun 05, 2025 at 04:58:49PM -0400, Frank Li wrote:
>From: Clark Wang <xiaoning.wang@nxp.com>
>
>The "eee-broken-1000t" was added on 8mm for FEC to avoid issue of ptp sync.
>EQoS haven't such issue. So, remove this for EQoS phys.
>
>Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

