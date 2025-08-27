Return-Path: <netdev+bounces-217340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B590DB385D7
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 307827AE1B4
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97E727467E;
	Wed, 27 Aug 2025 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OJ75MMUL"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010012.outbound.protection.outlook.com [52.101.84.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF3E26FA5A;
	Wed, 27 Aug 2025 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307529; cv=fail; b=tP/99bmBOEqU7YQtMj7c2lMsYY3hiOWvmvgWE+lX933ztPocX/6tLgtah0pdZJL3Gmn7TM0WtLBKTmgSTRXvuBOmKiRUUIfUVUs4UX/JVOMB43r7/04kqRqVlLxhi9V9HP3zqLd7yMps88/nsO98H/u9frBQ9PLTCB4YhuY2XTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307529; c=relaxed/simple;
	bh=izFflqaAYfeJWHBju6pfe83bijkrwSLsIZaHaezlgwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sDF/QSoXXSdhza3Dk2/SlOTDP/mQWemGr/qT5NKNSJALKV8EhsU4JtwwN44YS6tZLmsIITTgVWv9QiGj40+/G2Nwbvf7NAd77jze0ZFtICND6p9cgWH+mP1k1gOgFf0Xm3NqoIGq8k/0RiqTYceme8DncH/hQhswzsUGh2vOz3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OJ75MMUL; arc=fail smtp.client-ip=52.101.84.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0Sjb9djFTGYPN1O7J6uUP0TO8zkq/Hcdz3uGyCniReg4qxwmpM0KIudccp11mn0JtPR9roZDremHzUe/2KUh/hDDFgRkciG3OKqg4NEFFvdso+Sk7KTspInzB5EtEq7OwYuDYIW57gAz10Vm2WITKA4a7zbXxGWw/R9hwBsXooqWCyDOrXsvy/2u6he0Wi3aVD9rgGW3W7UvyexIxwOPVJFtrEqtSA0Qx9W5wqvhfoVq9/Se/hbc7TlhmhjO7UJm9EjZFFedEAVXOBuyGk9CAgbFEerbknqRnVRVwNmahwXQJS2L2aVnloLMX6xXDziN+QGJ5k2FNPgdO0Hfi00RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bf82RXFJnR5uXjMzMO4KHtSPK1AkZn7yLdEQdasEcT8=;
 b=g1p/zTNUOvyhHUfrPwRlI0dxpQn+5Bevvl0D1Dc8qIZRRurZ7zW44I780//EXY1LJa037dZLwtWF1NPrwtqAi7RpeJGhpBg5rU0royWvZQQBFkdo4gvzJFl1TBdPdT6feZosxf3DHHRr0PPnBNPAM+qJ+WNydgcnV3pUffH90iR6NiaF/CC1DcAKL50yjt9xqAyGBdKAMO9nHQnTKDOTMv6ya+3XGRQnqPSnaUjLDbfXMnAWfVXirPcC50JS2AYJvEra+ATUFOXAB/lHuvEJmA1/HNeMPvCEyT5mVhuhe+cPCxz5g1O/65tewzWBwjvH2dxaFDspKpOaHl08hw0WMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bf82RXFJnR5uXjMzMO4KHtSPK1AkZn7yLdEQdasEcT8=;
 b=OJ75MMULEC2RPxIQynxI7hKSWNfGABUuw18Z1h9kMTyOBnh+H0hwbY0zWK0ogdLy9T+unNeFrYMVwBYZOTg0pdK+0ouOP5j0WeYEgxy6KmgRicbAAH/aB/OOwTRX8JxAYRe8toaXUAZ8Vs1E9thUVut7+JVgsHEkBI+GKK4sENKxlq0z3KVI2F7NnOIH53BFvgoP3v3++cCsFMxGU8vfFFl7UJvArx2okJLG/aXaWFAQIuetoBITn6mX0N7/ETrRO9gx9cMx4MZVs8neTjuim/RDHy/a6UhKX2H5X+jntSWX4rNfS/W14qDyEfGjeKoAqCVWdG4nL7kbiljp2odWYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GVXPR04MB9778.eurprd04.prod.outlook.com (2603:10a6:150:110::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Wed, 27 Aug
 2025 15:12:02 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Wed, 27 Aug 2025
 15:12:02 +0000
Date: Wed, 27 Aug 2025 11:11:52 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	shawnguo@kernel.org, fushi.peng@nxp.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v6 net-next 04/17] ptp: add debugfs interfaces to loop
 back the periodic output signal
Message-ID: <aK8gODZD15OP//V7@lizhi-Precision-Tower-5810>
References: <20250827063332.1217664-1-wei.fang@nxp.com>
 <20250827063332.1217664-5-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827063332.1217664-5-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::8) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GVXPR04MB9778:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b5ac48-31f3-40d8-0982-08dde57c133e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1fBFSwsmZnFh2cVO5mL4d7RlvvIiVkI1ykcmXFyDxrrFR/0HQG/ro9MQCMi8?=
 =?us-ascii?Q?aUgZ1DHyAwZiDn++2CM9OpsH8fuQDMs55Lh78CNV1UqOafFyFeLujk0NPJrM?=
 =?us-ascii?Q?DvVZa1TIz3fpF4rURkQgi9xFYx4p3Ztbywgzt6oCeStM47CeiylPkee3G20n?=
 =?us-ascii?Q?RoTyowNaCPS6JKnATAGkzpRkkp9n3YqHQ9UmmCUnef1Rbb99PhVZBrAsbZqs?=
 =?us-ascii?Q?sVoM7k26NV0tCJFhpSuw7It9KlKuNeRV7TXAm/taqXVQbOAxoprKFXEZ9pT9?=
 =?us-ascii?Q?eoYbVuuu2L/b5Lu2GFtPcclWO62WrImOZegLrbt0auj2TXd4tMGOLhAGZiCU?=
 =?us-ascii?Q?XtLbWZybq5Th8m/Cdq2Wdn1ZkE0RMii+AfcIXUs10a8TONsJnA/1HZnSTxH2?=
 =?us-ascii?Q?+5/mcpeoKy/zgJQtZpWJ3wNp9K3koevAUXHT4AEzx22IyP2tfNkcRbzAKMZj?=
 =?us-ascii?Q?WyTsmF/P0d3BrW2W1sNxD2OdasTLRKDuBUsBp2HcB7kWtG8kHzdCJgJ+zmvj?=
 =?us-ascii?Q?yG28yhIAkf3SmTi0ORomrz6b14RYkQ6JrpHoYSxrrJlmFoYrDJFSyGUXBjDM?=
 =?us-ascii?Q?mtC3/TiRgmv3e/0AeTixzUwGogXPUF1E8Tk7GzECh6fgOps2zckCWFJT+2LN?=
 =?us-ascii?Q?lgLnuegT8epgObhpl+ybOxCcTEiQN5kdJfaKAZgQp55Q/I7omtFm/EkI96II?=
 =?us-ascii?Q?pnakDnLRAdrxKXO/wQgsgvrWej103tZjPQExGb6nzvMiXhGwBF2pIgdG/9GE?=
 =?us-ascii?Q?SjOveRrx5pwWaryOgW0QPQSvgbEepCjUQCy07tpJac+LmAno2Xu2HN11+zT0?=
 =?us-ascii?Q?+QGopR7D8qUMYvIPOsB2yPUXcCzJEJ2eQguUz95eStxUagdikW1hCVt1ioUg?=
 =?us-ascii?Q?OdBn41eGPp01FhOM+Wvycqu5XS2XDyPeiWMBaIPX9gi21vGzc/wVRSdhwaQ3?=
 =?us-ascii?Q?RL6FA3vExKrbr49rjYwC9JCUuNmZdHdtymUDG5BhrOPv8OVLa7tBADbV693C?=
 =?us-ascii?Q?ANFhrN+Q2rozd6eUtgUanjQIPXQRSVzHSceWAwlLHeFHm/VE2KHU3Iw0GucH?=
 =?us-ascii?Q?mA7cN6eA9oeVMsrLIi5MYe2dAK4ih0qFXjkVy24YMbtuncI59FW5BZkMnkTJ?=
 =?us-ascii?Q?PvH6vg5QU2SkVgSHgzu0Ci010K8bMT39SjqT+pcSjIJpuhGcKC8PMQtoMQrc?=
 =?us-ascii?Q?UAoEoUL1H9kRh/fGB0E+i106cpPLFb18dP5MdNioYn0dcaEYNiwk0zVKvoSt?=
 =?us-ascii?Q?kXfTvQiRbEZ8GnTuB2aCgGLHt+Gr/8Udb8f0jHCE2kJdPw2kSs0vom5vmKEF?=
 =?us-ascii?Q?mgrEIwZJfwGSkW3Vx1jZh18l9S74u0CxsiaRZGNO5A05n3IEhoc1J51XIrmf?=
 =?us-ascii?Q?vXYi1VWIVA9YhYaAI8rgNYAbXYHQkXcCbMVyjEGD7yhSd9n/Q7J8+F6eDGh0?=
 =?us-ascii?Q?6KuoqUU1ZfKnYc/xoa/nzIHwxH7J/Utnyh0XRZOVty4khb2wEd+E2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y573z/Tc/W1HImn3HE/JVYevWGa2kBLL+d/QP9jKFmearr8VQPwLcG6ybGVz?=
 =?us-ascii?Q?0BhXBPQ3SZ+N8cMVPlfyhSBRTb3DqJcJ+7x9NO4bzTZ02VKHhV/iQmV2mO6l?=
 =?us-ascii?Q?wBwwfdY1wIQ3nAFYDj41sHemk5ALNTpvKg/WJAHSDj+BfkSTGTEJhNirgo6Y?=
 =?us-ascii?Q?JxPQEuaPkHPxhUaE3/RkcMPtV29MZRNKtVlisb1Dv3sMS87IB1qwyRJ+TxRQ?=
 =?us-ascii?Q?OY89D1TuCAkAzeKtgNGp3J1I7PVHQrLWeOiteJuRDWCrUulUC3G5K+p/JYXP?=
 =?us-ascii?Q?bkDWbyFo9+EN7qgZPeqRO6eChemT1erT+otbfxY/Q6mwVD/N1YAUmdnbXYng?=
 =?us-ascii?Q?DeZzXaungo89ze+9D/2rlcyvPjnLGIyhC7xQkKxdveE2evHpOps1OIsZWHOc?=
 =?us-ascii?Q?A/9BMzqQtCog9gH7rpOW6PXkfkoVWfBaAgohzy79+S0fb3hyFmND/buqABiF?=
 =?us-ascii?Q?meezjxJzV3qiBdZD3SBmZnz4bRSW6VHW2meZiUeICOxxIqUuduJToOfI5T0j?=
 =?us-ascii?Q?rHaoUYQ8ToBRcFZ3t+d+tGR5tt55Jsh5mQz2H/FHf/ywARAXpu0OLwRluHfH?=
 =?us-ascii?Q?npbMUhoy2nAkVOv+UbkJs2ZVRqrZtr4til35NbZJ6nfIZO/o7mcQC5IQQ1gA?=
 =?us-ascii?Q?EyGaNk84rov0hKKjEndGXv4604JFWtr/zli7UeABqGwvp3U4Vg1DR5LyoUzU?=
 =?us-ascii?Q?h2olszM2eEWJdTuPdzkAwbBuREzUqpmLufmrytU+8HHEKg1yaOE2/ZfSkjxj?=
 =?us-ascii?Q?vKIx0daRwMTdQbtQ82FrdxzhYRgf47QKMnGLbaDTDC3F40OEBDqX4sHvM4J2?=
 =?us-ascii?Q?VMYVpX9GmtrsoKehFloyI+FhfPWX0uUNotDGpT6Y9FisTwZLgXIZuDKfYwJ8?=
 =?us-ascii?Q?VFD/+rZcRx1BxuTgVGkpSZdMkLaUFAJsZ0Ie9mzRLTK9Kv3jvAADLRrWkcs5?=
 =?us-ascii?Q?beWFWmegAsQeQvLVHZ4n+x1BzzmNZ35wPKYiuXyj8cf+6N8Qnhej2PW0XKWw?=
 =?us-ascii?Q?TRx6YMUkLFpAGVu/Rj33IKwWp1f51ZpybFE7cor3iEvi6YyepSzGoE5mz0Mg?=
 =?us-ascii?Q?1XNFdWNBajwZ4eWUu9xZF1APn+V/PoJawkdFxfTs6MrLBvTKYgF4I0YjHwjC?=
 =?us-ascii?Q?58Qm0R41VEG6350589/q6hqbAblGg5Pn9ZA+K8GxS3MmeD895JIszM4WDtT/?=
 =?us-ascii?Q?np1Fjj16iKSEU+kcs97JQ5k6v+U1Qk9si0XghKnZbpCzGwx0bRb3sESOs/9T?=
 =?us-ascii?Q?Dk/5oArjxpBNE5rTeoFPlDOen4Pcv03j+ZRYaQG0oSk227LCwvGXNrr06ew2?=
 =?us-ascii?Q?ogi8DN4BrgL61Kv0Jr91LMQuFcSMIm/abdzQn1mqbHsY5YHkVKexk2ONKsZL?=
 =?us-ascii?Q?Me9MdOS2oHws+dFdDChE6qrCSxdfqzD0byUPC0X5Pb3tPX7dPIePHdLfURYa?=
 =?us-ascii?Q?RNBy5TCd1GAl4QCxtf0RVHHxrATMJIMGFVedPUtyGEu7BZ7qzZs4h9aRsSQe?=
 =?us-ascii?Q?xhvLpwB1hLoGtZJS1sUwy1wrvvv1shWiFi72Nw9nIauF+xOioc3uCGFwNUr5?=
 =?us-ascii?Q?O7bMl3/O52PMOGQGhevf7cTIWQ2zHF8c5oPZy62p?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b5ac48-31f3-40d8-0982-08dde57c133e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 15:12:02.0270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CyoxtSN7MN1Y+6JCI+jW0QRG/pCKmpUUh8lgXfLrhz14H2fTytTl60ccwCB//byCqrJH+MzYua7n1BUzoQkKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9778

On Wed, Aug 27, 2025 at 02:33:19PM +0800, Wei Fang wrote:
> For some PTP devices, they have the capability to loop back the periodic
> output signal for debugging, such as the ptp_qoriq device. So add the
> generic interfaces to set the periodic output signal loopback, rather
> than each vendor having a different implementation.
>
> Show how many channels support the periodic output signal loopback:
> $ cat /sys/kernel/debug/ptp<N>/n_perout_loopback
>
> Enable the loopback of the periodic output signal of channel X:
> $ echo <X> 1 > /sys/kernel/debug/ptp<N>/perout_loopback

Genernally sys interface only 1 input for each entry.

I suggest create one file for each channel.

/sys/kernel/debug/ptp<N>/perout<m>_loopback_enable

echo 1 > /sys/kernel/debug/ptp<N>/perout<m>_loopback_enable

Frank

>
> Disable the loopback of the periodic output signal of channel X:
> $ echo <X> 0 > /sys/kernel/debug/ptp<N>/perout_loopback
>
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>
> ---
> v6 changes:
> 1. New patch
> ---
>  drivers/ptp/ptp_clock.c          | 66 ++++++++++++++++++++++++++++++++
>  include/linux/ptp_clock_kernel.h | 10 +++++
>  2 files changed, 76 insertions(+)
>
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index 2b0fd62a17ef..0a45c5ebd904 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -237,6 +237,66 @@ static void ptp_aux_kworker(struct kthread_work *work)
>  		kthread_queue_delayed_work(ptp->kworker, &ptp->aux_work, delay);
>  }
>
> +static ssize_t ptp_n_perout_loopback_read(struct file *filep,
> +					  char __user *buffer,
> +					  size_t count, loff_t *pos)
> +{
> +	struct ptp_clock *ptp = filep->private_data;
> +	char buf[12] = {};
> +
> +	snprintf(buf, sizeof(buf), "%d\n", ptp->info->n_per_lp);
> +
> +	return simple_read_from_buffer(buffer, count, pos, buf, strlen(buf));
> +}
> +
> +static const struct file_operations ptp_n_perout_loopback_fops = {
> +	.owner	= THIS_MODULE,
> +	.open	= simple_open,
> +	.read	= ptp_n_perout_loopback_read,
> +};
> +
> +static ssize_t ptp_perout_loopback_write(struct file *filep,
> +					 const char __user *buffer,
> +					 size_t count, loff_t *ppos)
> +{
> +	struct ptp_clock *ptp = filep->private_data;
> +	struct ptp_clock_info *ops = ptp->info;
> +	int len, cnt, enable, err;
> +	unsigned int index;
> +	char buf[32] = {};
> +
> +	if (*ppos || !count)
> +		return -EINVAL;
> +
> +	if (count >= sizeof(buf))
> +		return -ENOSPC;
> +
> +	len = simple_write_to_buffer(buf, sizeof(buf) - 1,
> +				     ppos, buffer, count);
> +	if (len < 0)
> +		return len;
> +
> +	buf[len] = '\0';
> +	cnt = sscanf(buf, "%u %d", &index, &enable);
> +	if (cnt != 2)
> +		return -EINVAL;
> +
> +	if (index >= ops->n_per_lp)
> +		return -EINVAL;
> +
> +	err = ops->perout_loopback(ops, index, enable ? 1 : 0);
> +	if (err)
> +		return err;
> +
> +	return count;
> +}
> +
> +static const struct file_operations ptp_perout_loopback_ops = {
> +	.owner   = THIS_MODULE,
> +	.open    = simple_open,
> +	.write	 = ptp_perout_loopback_write,
> +};
> +
>  /* public interface */
>
>  struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
> @@ -378,6 +438,12 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>  	/* Debugfs initialization */
>  	snprintf(debugfsname, sizeof(debugfsname), "ptp%d", ptp->index);
>  	ptp->debugfs_root = debugfs_create_dir(debugfsname, NULL);
> +	if (info->n_per_lp > 0 && info->perout_loopback) {
> +		debugfs_create_file("n_perout_loopback", 0400, ptp->debugfs_root,
> +				    ptp, &ptp_n_perout_loopback_fops);
> +		debugfs_create_file("perout_loopback", 0200, ptp->debugfs_root,
> +				    ptp, &ptp_perout_loopback_ops);
> +	}
>
>  	return ptp;
>
> diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
> index 7dd7951b23d5..884364596dd3 100644
> --- a/include/linux/ptp_clock_kernel.h
> +++ b/include/linux/ptp_clock_kernel.h
> @@ -67,6 +67,8 @@ struct ptp_system_timestamp {
>   * @n_ext_ts:  The number of external time stamp channels.
>   * @n_per_out: The number of programmable periodic signals.
>   * @n_pins:    The number of programmable pins.
> + * @n_per_lp:  The number of channels that support loopback the periodic
> + *             output signal.
>   * @pps:       Indicates whether the clock supports a PPS callback.
>   *
>   * @supported_perout_flags:  The set of flags the driver supports for the
> @@ -175,6 +177,11 @@ struct ptp_system_timestamp {
>   *                scheduling time (>=0) or negative value in case further
>   *                scheduling is not required.
>   *
> + * @perout_loopback: Request driver to enable or disable the periodic output
> + *                   signal loopback.
> + *                   parameter index: index of the periodic output signal channel.
> + *                   parameter on: caller passes one to enable or zero to disable.
> + *
>   * Drivers should embed their ptp_clock_info within a private
>   * structure, obtaining a reference to it using container_of().
>   *
> @@ -189,6 +196,7 @@ struct ptp_clock_info {
>  	int n_ext_ts;
>  	int n_per_out;
>  	int n_pins;
> +	int n_per_lp;
>  	int pps;
>  	unsigned int supported_perout_flags;
>  	unsigned int supported_extts_flags;
> @@ -213,6 +221,8 @@ struct ptp_clock_info {
>  	int (*verify)(struct ptp_clock_info *ptp, unsigned int pin,
>  		      enum ptp_pin_function func, unsigned int chan);
>  	long (*do_aux_work)(struct ptp_clock_info *ptp);
> +	int (*perout_loopback)(struct ptp_clock_info *ptp, unsigned int index,
> +			       int on);
>  };
>
>  struct ptp_clock;
> --
> 2.34.1
>

