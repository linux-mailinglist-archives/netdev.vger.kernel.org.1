Return-Path: <netdev+bounces-214992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4748DB2C861
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 17:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3262B16463A
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFE5285041;
	Tue, 19 Aug 2025 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SGbjZokD"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC7B2253FC;
	Tue, 19 Aug 2025 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755617131; cv=fail; b=Romj5DmLUAJ7lBXknrTbJ3xV0k/nF80ZLDe7hBezYggg/Fl8mk6hZylG6GUQreJANIIe44ZjWgylBrab4aV1Vw9zg0JFlTkuAOqjKCxy4WpAwzaZYbKpE7d4xMO2GA/2uKh553Yj/vrtsWB8ja/Lp3X6G2e95kiEaJEAop4iRu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755617131; c=relaxed/simple;
	bh=33jJJ4a/5Ohep98yB2KFKZcq+eNIpMC/vlgA8VIw10Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=omEOzzDHxIQMcOCe9FOqMV1N5xRfq/ghXqPA9N8k4h49+KTNGf7YkrvAWlF0K7kQPjHfZJqQA6RD9RcE2siGrWT23sqmAY0JgJpXsBmfDk1Br6Iy328QWV+W3OFevN2EMJo7Qp7bZXzNfrHaP5heYkAP6aWu8PO5Zql6YS+BH5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SGbjZokD; arc=fail smtp.client-ip=40.107.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfXAIfKWks/rivRANlGv4yVdrQUjdvV3wO12GP5wDqsUzlAd9sIlUKszAU0w7u6d4Fe8L/vBp9nrX40QWx9LPhV42uvzstLrQQIoWCx0l4txLiNXwA+zmbtu1FtJgO5nbOJeiu63f4iQvqkGIIEqlx1FZVuD9d3iKAAiTRXWY/EvCdcpEIwNRyp3h3DXD1lLswJfVR4zpDxhTXuD9dzfPuaK2tPupUrBsEpmY4xFt8c+gEuqBuiAOTo1yaSXgQaKN3LNbFDsyWXheNu4WzuKn72rpjL9DHnwqIjK4Te1s3yUK1Mukni3AbBILyEeuBiFxIP0/TGnByDuu1eT+yXMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzUY6+VscFAw3zi7TUwCZ/kFpr2YNB3m0WYhuLGmcyI=;
 b=VOt3a+2yadvd3KOQl9yvtkeGIviVCzEHiQKrSHQbVDA6p82aGxlYZ4mjDVGB8CIAdO6rF0Dw+TB2uZdKBnqfr8MsiRat4+BH6FDsSrh/1/+PUAAcr6QOUNIiBHMV3PcL+JXExmPFek1fxJkPjLtJRdJNDX7ttQlCpk2Bcgofk53c//zjoq8tD2VLFDmLwD4PyHKeA31oVlLo8RKoNrl4Q/BmYNgJo0FVxEOqUdSbmrpvoxkn9NTxvtFv7SRM4jAyF+etgI0ulGYfaevZRe1eywiyygv+kQDHk/hxG+uu4/GI7AKOWvY4dUlZBWSiq7/MsBl0p3D8WJUQAVrQEOLQGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzUY6+VscFAw3zi7TUwCZ/kFpr2YNB3m0WYhuLGmcyI=;
 b=SGbjZokDeg/GUkh0S4oQBnZ0y11rcp8c9ypIlk0lFJD7Z9WW+cH1ijPQNeX/7Vl40lA7Xqy+Oai9ZUM1+ELOMRz1KCNNBVpY1ifER4jaLDqxzTJ5lAP9hK52GTbFyfzrwbum1yY/O687XNPloSsiOEunulwsYhqi0Q8MOd7QbnffxGKmcOsHaf2wJ+BinqdGUPGY8Aax+c+YCK79JFHjqYb+oYD4fZbbeIoOI6tsNxley/lqaeJuyfaLvK+Hv23xr8jphIFus2ADZX2+PGIQTvxe+7GDuoNujCmJ3ZghlS66m7VaRumQYwmfJhIKhrcMAcQbiyc8XzBIOmZ281l+Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10593.eurprd04.prod.outlook.com (2603:10a6:800:275::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.12; Tue, 19 Aug
 2025 15:25:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 15:25:24 +0000
Date: Tue, 19 Aug 2025 11:25:14 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	fushi.peng@nxp.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v4 net-next 05/15] ptp: netc: add PTP_CLK_REQ_PPS support
Message-ID: <aKSXWumC80JpNqDt@lizhi-Precision-Tower-5810>
References: <20250819123620.916637-1-wei.fang@nxp.com>
 <20250819123620.916637-6-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819123620.916637-6-wei.fang@nxp.com>
X-ClientProxiedBy: BY5PR16CA0026.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10593:EE_
X-MS-Office365-Filtering-Correlation-Id: dbf1e4d4-47c7-445b-78b6-08dddf349e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OtD00oKcdtnioT53lp+ph3bYYvIP5FyTTKnfwnFBOvqjdEjym2X5dHhC8bWh?=
 =?us-ascii?Q?ItWDNvIXwHB4a8KgKjlboYrbQGCMWO1FaTvuHpJ6QTxjA5Q492MK0wDwG3U9?=
 =?us-ascii?Q?D1conigaxsfRWG6F0nk2QlHD/7WerFZi8Dul/A5da+pyj9WfsJRc2e7zWWSW?=
 =?us-ascii?Q?4Fa49HZ1hY4awoLvt8gJUrG7J3s0oHkX60AKp+TQuyM672lbcpxJ9WtOWLBP?=
 =?us-ascii?Q?nBbgHWglSkgGBc/vhnQwH/+G5MJUbjhs6t5X14QqNfq4vRSU5/zoEkhyIkG7?=
 =?us-ascii?Q?OxhOAKdXqy7lB1W8mF458fn5kKfJuY3je1HufC7bBMRG9MiiDfu5P/Prre62?=
 =?us-ascii?Q?26zNiWNH0iNuhZooNuzJp/mZHa7Q24yl6gcELtMpBRNHFfpOu/rA5GXgRCy9?=
 =?us-ascii?Q?u+aj/lK5Xo7Y3Q0ZuJvghLlp/YmKSn3Sa+iOKHTCn1rGfa6aJSrvdEIA6Grr?=
 =?us-ascii?Q?gucZ4jR4BV/5Iu8GnKYmoTLiY+plGlbHUnaSlczlfBWddjburGWMR4jjx1wm?=
 =?us-ascii?Q?r/XoLv8TwsrEVIFQQBdy6g5OYApXGbfNvbDWLVby1Jq4TUBV/NJCiUOUuSls?=
 =?us-ascii?Q?ynsCr0znr6Y1NhspLY0uYpXS5g/LpA3Uwg6k/35BWdipKGDRnBJqar4Ovogm?=
 =?us-ascii?Q?cBWm5/yp51+q3Cw3RH+hWaHpgxNZ9hVcz36UdwnlCtgsLXOqoZdCwwHtqrMA?=
 =?us-ascii?Q?n9mFB75/Z1LWnQH+myKtDg+kN0Cp8jP/2zWcxyMQLQOTaJ6ptSGmbrl0Sj8S?=
 =?us-ascii?Q?eWcFqUdzbYDgvBmrk0VGkR8tZEcAiAov8ZFFcLnu1Txj6f8X9ZdRmYia0K27?=
 =?us-ascii?Q?tAZ7CR3+tSoWDusVvne6qnUiic5JRq8VfGMkQhZu/ME4xlsOkEfAt2GZDjuu?=
 =?us-ascii?Q?J8df+BhVa98kpmC+J+sr/cLJTv9fVc+Xet23JL3lUYRbrodFWQQuAtP6D404?=
 =?us-ascii?Q?O6DoaT47mqRvvaj/U+q+r7sYkCvGuPsCqcQ36spAT370iGYlYYsSoZZzGbvY?=
 =?us-ascii?Q?XpXcLSl7rtOODnWfL1+MV0pW0GMTUg/FBfr49vQys+oGHLU+ch5ukuth1ndp?=
 =?us-ascii?Q?Dttp+neGVqdvGrmRRNoJLZ3BaU5/odaRDL3rkozCf71v6xsYkZkL6Xzy800k?=
 =?us-ascii?Q?G2AmxwGmm92BglhO85T+s16jy32Ufr8D2dTQIQzWXrQnv75QTCfRGgy8FdeN?=
 =?us-ascii?Q?nT4tu6DP5izqY2Jxii/wRa37i62lFpRvfJKYReWDaFBW3FLxhShRFLeZJKw7?=
 =?us-ascii?Q?XDs74oASxj9201E8lXVZqxqAPhQyXUhj1CcRW8Vzq9DQuU03tI9VsF+WrZBM?=
 =?us-ascii?Q?MR/mxdIkpn3oV23flaO9pH/RGR+sTEISFdLuGkWGbW/J2wxxeY8nFjGawJ2C?=
 =?us-ascii?Q?OWUXlkXreJZR7MCc+Q7/IS5FNCvAh8W1NQP2pyavAW5qDnINzcmOppsxql+M?=
 =?us-ascii?Q?PSVFdqe1WPE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jEsCnVMrp7D19LzBYViWqt4mQXPVBnIrZKv9iIPki4jHOOCpCuYWYgX6OeZd?=
 =?us-ascii?Q?ZrBJ0qxD1GdGbVhWGMHIE4CLJ7cWUvYQ2hIJ4mlCDXfD4a/QjoeR9N5ThOxv?=
 =?us-ascii?Q?ri/gWFFlzLJXDAnGfevUg7RYl9ghblwDo77OxSweb2MayVAJwN9lui7kzuwF?=
 =?us-ascii?Q?zXdaPcFnyrexFanrjek0S4lqODsiGx/WV8+1Om355Fr7rbFs4asriHhHFFl+?=
 =?us-ascii?Q?pKS26JzgC7YQ58l4pnF/buUaaFeDC/Sb7Q4NdIIt9aQvy0jJXgOoCetGKgtl?=
 =?us-ascii?Q?VApwv/ojjM0fIo5wnXuR8cDGz0IIESFThAEGEZSkGwTxQZCOj/jMQEPrMJID?=
 =?us-ascii?Q?wbTf02Dykbz6KSbENJ8rPux7hkNIBb4DEfLAhVSclbPKP8sLuSztHMYE/EDW?=
 =?us-ascii?Q?BuWpo+ughWolVQY9CmzuEScR60IuyXmMsFOeiqcsamIfXtj5dIld6hoFKQ4O?=
 =?us-ascii?Q?O+/KwfehHjcGHxzRMzPHiZFzxwJXZzaXbtH3LVAgkXlvIdUeL0X/VGqm4N5Y?=
 =?us-ascii?Q?NDYVN358IfMyoYk4TkTHYC0cZ8CWqaUW4sfWt/wCKS+9KvNA/SPQjLL44ne2?=
 =?us-ascii?Q?P2IJloJg6eFzP7UanC41BC+q5bpv5rmtV/NxZ4r3rSCJmcpfshLape6892BD?=
 =?us-ascii?Q?Uttiy6zqfhh4a1laPd1hTImN3fDpHqb9TFCUSOnnupbcO9cO0tohOp7o9yzX?=
 =?us-ascii?Q?P8TBWPj9RYbBb6X+CkNunZSyb91WyPkVmpumrkcTF0Cz1OMmRgXHd4nvMePJ?=
 =?us-ascii?Q?heX7inTVu2DcX5qia+YvmNr5YyxAnLuaxq/ODQhYMiZo/8aAgcTx1wKIbO2x?=
 =?us-ascii?Q?G+Gs7eAHku62D8gxUxxftRa/HNB6twRfVH7noTC1hJz0WNRUFQRQn4/YzZXp?=
 =?us-ascii?Q?w+0Mxo2Y8xEXGOeeoWkAmpk+wXkhq2kXvantIU5SLyaBZproUqPVEaybG7Wl?=
 =?us-ascii?Q?iqctmvHOoBoFfJ5MgWREai13qQGa16/UAgQBFioR5cyVR7gyKmQStPMYhCjC?=
 =?us-ascii?Q?CuaWL9aRUT41ri/Yc6xbaeKRuZYw3V6NP+Kn6erD6IJ6VtwUu4ce+bKLZ7rN?=
 =?us-ascii?Q?YSndSfh18S8c/3XO+zTgN0PfUuRii420E1J3vPp5auS0De0xDtopBDEbdkGT?=
 =?us-ascii?Q?bwE880ojWZ6FzvW1ML3Tl8OPOlKQSrftBdx7lntTQaYkXSImCNrUxSxwtXfX?=
 =?us-ascii?Q?uwRXoNy96wZ5JsjKpZqQnP7YRVp3D2z2nLYPuQXcQSfuB6M6fIW7/jhAI8vG?=
 =?us-ascii?Q?nCCc08P2d3ptXiFVBLRtoXoM+yApjox4xYyVW/9iKg3VgG/lWIkMpG02GQ2J?=
 =?us-ascii?Q?TBCrgPPdD04YA7lF6l68Y2kFG+89XinE1I3c4RNA4zfiJnhgjNh7+SuRCZoh?=
 =?us-ascii?Q?vGwgYJJuMENlC5Hb52VCBorj4QaWJ/t6NNxyst491f7XwkvvDA+xfM9rJe1R?=
 =?us-ascii?Q?Nuff8NbRRvL8vEA1yEiqHOKWPB4gncpawvx4j7BIyUQRtocW6eIX0xIaK+aK?=
 =?us-ascii?Q?xL7wb9IYMc/NYdiuXHQvGTVvQ3yfw+9U+sLDEiZWAl0c5a9T8A996NpT/biC?=
 =?us-ascii?Q?LoHndPpeR5wZammteH3sutFh+1hf4nfEHYnrKHWe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf1e4d4-47c7-445b-78b6-08dddf349e1c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 15:25:24.3532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lz4fGRuthiyelrONTQJrtrThewra4nNDzrM/6mMnBTtOd2NXv3TnDBb0FQXG9iMGlaYV+oOVmMCxzd3rl0uUIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10593

On Tue, Aug 19, 2025 at 08:36:10PM +0800, Wei Fang wrote:
> The NETC Timer is capable of generating a PPS interrupt to the host. To
> support this feature, a 64-bit alarm time (which is a integral second
> of PHC in the future) is set to TMR_ALARM, and the period is set to
> TMR_FIPER. The alarm time is compared to the current time on each update,
> then the alarm trigger is used as an indication to the TMR_FIPER starts
> down counting. After the period has passed, the PPS event is generated.
>
> According to the NETC block guide, the Timer has three FIPERs, any of
> which can be used to generate the PPS events, but in the current
> implementation, we only need one of them to implement the PPS feature,
> so FIPER 0 is used as the default PPS generator. Also, the Timer has
> 2 ALARMs, currently, ALARM 0 is used as the default time comparator.
>
> However, if the time is adjusted or the integer of period is changed when
> PPS is enabled, the PPS event will not be generated at an integral second
> of PHC. The suggested steps from IP team if time drift happens:
>
> 1. Disable FIPER before adjusting the hardware time
> 2. Rearm ALARM after the time adjustment to make the next PPS event be
> generated at an integral second of PHC.
> 3. Re-enable FIPER.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>
> ---
> v2 changes:
> 1. Refine the subject and the commit message
> 2. Add a comment to netc_timer_enable_pps()
> 3. Remove the "nxp,pps-channel" logic from the driver
> v3 changes:
> 1. Use "2 * NSEC_PER_SEC" to instead of "2000000000U"
> 2. Improve the commit message
> 3. Add alarm related logic and the irq handler
> 4. Add tmr_emask to struct netc_timer to save the irq masks instead of
>    reading TMR_EMASK register
> 5. Remove pps_channel from struct netc_timer and remove
>    NETC_TMR_DEFAULT_PPS_CHANNEL
> v4 changes:
> 1. Improve the commit message, the PPS generation time will be inaccurate
>    if the time is adjusted or the integer of period is changed.
> ---
>  drivers/ptp/ptp_netc.c | 260 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 257 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
> index 477d922dfbb8..ded2509700b5 100644
> --- a/drivers/ptp/ptp_netc.c
> +++ b/drivers/ptp/ptp_netc.c
> @@ -19,7 +19,14 @@
>  #define  TMR_CTRL_TE			BIT(2)
>  #define  TMR_COMP_MODE			BIT(15)
>  #define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
> +#define  TMR_CTRL_FS			BIT(28)
>
> +#define NETC_TMR_TEVENT			0x0084
> +#define  TMR_TEVNET_PPEN(i)		BIT(7 - (i))
> +#define  TMR_TEVENT_PPEN_ALL		GENMASK(7, 5)
> +#define  TMR_TEVENT_ALMEN(i)		BIT(16 + (i))
> +
> +#define NETC_TMR_TEMASK			0x0088
>  #define NETC_TMR_CNT_L			0x0098
>  #define NETC_TMR_CNT_H			0x009c
>  #define NETC_TMR_ADD			0x00a0
> @@ -27,9 +34,19 @@
>  #define NETC_TMR_OFF_L			0x00b0
>  #define NETC_TMR_OFF_H			0x00b4
>
> +/* i = 0, 1, i indicates the index of TMR_ALARM */
> +#define NETC_TMR_ALARM_L(i)		(0x00b8 + (i) * 8)
> +#define NETC_TMR_ALARM_H(i)		(0x00bc + (i) * 8)
> +
> +/* i = 0, 1, 2. i indicates the index of TMR_FIPER. */
> +#define NETC_TMR_FIPER(i)		(0x00d0 + (i) * 4)
> +
>  #define NETC_TMR_FIPER_CTRL		0x00dc
>  #define  FIPER_CTRL_DIS(i)		(BIT(7) << (i) * 8)
>  #define  FIPER_CTRL_PG(i)		(BIT(6) << (i) * 8)
> +#define  FIPER_CTRL_FS_ALARM(i)		(BIT(5) << (i) * 8)
> +#define  FIPER_CTRL_PW(i)		(GENMASK(4, 0) << (i) * 8)
> +#define  FIPER_CTRL_SET_PW(i, v)	(((v) & GENMASK(4, 0)) << 8 * (i))
>
>  #define NETC_TMR_CUR_TIME_L		0x00f0
>  #define NETC_TMR_CUR_TIME_H		0x00f4
> @@ -38,6 +55,9 @@
>
>  #define NETC_TMR_FIPER_NUM		3
>  #define NETC_TMR_DEFAULT_PRSC		2
> +#define NETC_TMR_DEFAULT_ALARM		GENMASK_ULL(63, 0)
> +#define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
> +#define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
>
>  /* 1588 timer reference clock source select */
>  #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
> @@ -58,6 +78,10 @@ struct netc_timer {
>  	u32 oclk_prsc;
>  	/* High 32-bit is integer part, low 32-bit is fractional part */
>  	u64 period;
> +
> +	int irq;
> +	u32 tmr_emask;
> +	bool pps_enabled;
>  };
>
>  #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
> @@ -122,6 +146,155 @@ static u64 netc_timer_cur_time_read(struct netc_timer *priv)
>  	return ns;
>  }
>
> +static void netc_timer_alarm_write(struct netc_timer *priv,
> +				   u64 alarm, int index)
> +{
> +	u32 alarm_h = upper_32_bits(alarm);
> +	u32 alarm_l = lower_32_bits(alarm);
> +
> +	netc_timer_wr(priv, NETC_TMR_ALARM_L(index), alarm_l);
> +	netc_timer_wr(priv, NETC_TMR_ALARM_H(index), alarm_h);
> +}
> +
> +static u32 netc_timer_get_integral_period(struct netc_timer *priv)
> +{
> +	u32 tmr_ctrl, integral_period;
> +
> +	tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
> +	integral_period = FIELD_GET(TMR_CTRL_TCLK_PERIOD, tmr_ctrl);
> +
> +	return integral_period;
> +}
> +
> +static u32 netc_timer_calculate_fiper_pw(struct netc_timer *priv,
> +					 u32 fiper)
> +{
> +	u64 divisor, pulse_width;
> +
> +	/* Set the FIPER pulse width to half FIPER interval by default.
> +	 * pulse_width = (fiper / 2) / TMR_GCLK_period,
> +	 * TMR_GCLK_period = NSEC_PER_SEC / TMR_GCLK_freq,
> +	 * TMR_GCLK_freq = (clk_freq / oclk_prsc) Hz,
> +	 * so pulse_width = fiper * clk_freq / (2 * NSEC_PER_SEC * oclk_prsc).
> +	 */
> +	divisor = mul_u32_u32(2 * NSEC_PER_SEC, priv->oclk_prsc);
> +	pulse_width = div64_u64(mul_u32_u32(fiper, priv->clk_freq), divisor);
> +
> +	/* The FIPER_PW field only has 5 bits, need to update oclk_prsc */
> +	if (pulse_width > NETC_TMR_FIPER_MAX_PW)
> +		pulse_width = NETC_TMR_FIPER_MAX_PW;
> +
> +	return pulse_width;
> +}
> +
> +static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
> +				     u32 integral_period)
> +{
> +	u64 alarm;
> +
> +	/* Get the alarm value */
> +	alarm = netc_timer_cur_time_read(priv) +  NSEC_PER_MSEC;
> +	alarm = roundup_u64(alarm, NSEC_PER_SEC);
> +	alarm = roundup_u64(alarm, integral_period);
> +
> +	netc_timer_alarm_write(priv, alarm, 0);
> +}
> +
> +/* Note that users should not use this API to output PPS signal on
> + * external pins, because PTP_CLK_REQ_PPS trigger internal PPS event
> + * for input into kernel PPS subsystem. See:
> + * https://lore.kernel.org/r/20201117213826.18235-1-a.fatoum@pengutronix.de
> + */
> +static int netc_timer_enable_pps(struct netc_timer *priv,
> +				 struct ptp_clock_request *rq, int on)
> +{
> +	u32 fiper, fiper_ctrl;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> +
> +	if (on) {
> +		u32 integral_period, fiper_pw;
> +
> +		if (priv->pps_enabled)
> +			goto unlock_spinlock;
> +
> +		integral_period = netc_timer_get_integral_period(priv);
> +		fiper = NSEC_PER_SEC - integral_period;
> +		fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
> +		fiper_ctrl &= ~(FIPER_CTRL_DIS(0) | FIPER_CTRL_PW(0) |
> +				FIPER_CTRL_FS_ALARM(0));
> +		fiper_ctrl |= FIPER_CTRL_SET_PW(0, fiper_pw);
> +		priv->tmr_emask |= TMR_TEVNET_PPEN(0) | TMR_TEVENT_ALMEN(0);
> +		priv->pps_enabled = true;
> +		netc_timer_set_pps_alarm(priv, 0, integral_period);
> +	} else {
> +		if (!priv->pps_enabled)
> +			goto unlock_spinlock;
> +
> +		fiper = NETC_TMR_DEFAULT_FIPER;
> +		priv->tmr_emask &= ~(TMR_TEVNET_PPEN(0) |
> +				     TMR_TEVENT_ALMEN(0));
> +		fiper_ctrl |= FIPER_CTRL_DIS(0);
> +		priv->pps_enabled = false;
> +		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
> +	}
> +
> +	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
> +	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
> +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> +
> +unlock_spinlock:
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}
> +
> +static void netc_timer_disable_pps_fiper(struct netc_timer *priv)
> +{
> +	u32 fiper_ctrl;
> +
> +	if (!priv->pps_enabled)
> +		return;
> +
> +	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> +	fiper_ctrl |= FIPER_CTRL_DIS(0);
> +	netc_timer_wr(priv, NETC_TMR_FIPER(0), NETC_TMR_DEFAULT_FIPER);
> +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> +}
> +
> +static void netc_timer_enable_pps_fiper(struct netc_timer *priv)
> +{
> +	u32 fiper_ctrl, integral_period, fiper;
> +
> +	if (!priv->pps_enabled)
> +		return;
> +
> +	integral_period = netc_timer_get_integral_period(priv);
> +	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> +	fiper_ctrl &= ~FIPER_CTRL_DIS(0);
> +	fiper = NSEC_PER_SEC - integral_period;
> +
> +	netc_timer_set_pps_alarm(priv, 0, integral_period);
> +	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
> +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> +}
> +
> +static int netc_timer_enable(struct ptp_clock_info *ptp,
> +			     struct ptp_clock_request *rq, int on)
> +{
> +	struct netc_timer *priv = ptp_to_netc_timer(ptp);
> +
> +	switch (rq->type) {
> +	case PTP_CLK_REQ_PPS:
> +		return netc_timer_enable_pps(priv, rq, on);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
>  static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
>  {
>  	u32 fractional_period = lower_32_bits(period);
> @@ -134,8 +307,11 @@ static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
>  	old_tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
>  	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
>  				    TMR_CTRL_TCLK_PERIOD);
> -	if (tmr_ctrl != old_tmr_ctrl)
> +	if (tmr_ctrl != old_tmr_ctrl) {
> +		netc_timer_disable_pps_fiper(priv);
>  		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> +		netc_timer_enable_pps_fiper(priv);
> +	}
>
>  	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
>
> @@ -161,6 +337,8 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
>
>  	spin_lock_irqsave(&priv->lock, flags);
>
> +	netc_timer_disable_pps_fiper(priv);
> +
>  	/* Adjusting TMROFF instead of TMR_CNT is that the timer
>  	 * counter keeps increasing during reading and writing
>  	 * TMR_CNT, which will cause latency.
> @@ -169,6 +347,8 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
>  	tmr_off += delta;
>  	netc_timer_offset_write(priv, tmr_off);
>
> +	netc_timer_enable_pps_fiper(priv);
> +
>  	spin_unlock_irqrestore(&priv->lock, flags);
>
>  	return 0;
> @@ -203,8 +383,12 @@ static int netc_timer_settime64(struct ptp_clock_info *ptp,
>  	unsigned long flags;
>
>  	spin_lock_irqsave(&priv->lock, flags);
> +
> +	netc_timer_disable_pps_fiper(priv);
>  	netc_timer_offset_write(priv, 0);
>  	netc_timer_cnt_write(priv, ns);
> +	netc_timer_enable_pps_fiper(priv);
> +
>  	spin_unlock_irqrestore(&priv->lock, flags);
>
>  	return 0;
> @@ -215,10 +399,13 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
>  	.name		= "NETC Timer PTP clock",
>  	.max_adj	= 500000000,
>  	.n_pins		= 0,
> +	.n_alarm	= 2,
> +	.pps		= 1,
>  	.adjfine	= netc_timer_adjfine,
>  	.adjtime	= netc_timer_adjtime,
>  	.gettimex64	= netc_timer_gettimex64,
>  	.settime64	= netc_timer_settime64,
> +	.enable		= netc_timer_enable,
>  };
>
>  static void netc_timer_init(struct netc_timer *priv)
> @@ -235,7 +422,7 @@ static void netc_timer_init(struct netc_timer *priv)
>  	 * domain are not accessible.
>  	 */
>  	tmr_ctrl = FIELD_PREP(TMR_CTRL_CK_SEL, priv->clk_select) |
> -		   TMR_CTRL_TE;
> +		   TMR_CTRL_TE | TMR_CTRL_FS;
>  	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
>  	netc_timer_wr(priv, NETC_TMR_PRSC, priv->oclk_prsc);
>
> @@ -355,6 +542,66 @@ static int netc_timer_parse_dt(struct netc_timer *priv)
>  	return netc_timer_get_reference_clk_source(priv);
>  }
>
> +static irqreturn_t netc_timer_isr(int irq, void *data)
> +{
> +	struct netc_timer *priv = data;
> +	struct ptp_clock_event event;
> +	u32 tmr_event;
> +
> +	spin_lock(&priv->lock);
> +
> +	tmr_event = netc_timer_rd(priv, NETC_TMR_TEVENT);
> +	tmr_event &= priv->tmr_emask;
> +	/* Clear interrupts status */
> +	netc_timer_wr(priv, NETC_TMR_TEVENT, tmr_event);
> +
> +	if (tmr_event & TMR_TEVENT_ALMEN(0))
> +		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
> +
> +	if (tmr_event & TMR_TEVENT_PPEN_ALL) {
> +		event.type = PTP_CLOCK_PPS;
> +		ptp_clock_event(priv->clock, &event);
> +	}
> +
> +	spin_unlock(&priv->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int netc_timer_init_msix_irq(struct netc_timer *priv)
> +{
> +	struct pci_dev *pdev = priv->pdev;
> +	char irq_name[64];
> +	int err, n;
> +
> +	n = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
> +	if (n != 1) {
> +		err = (n < 0) ? n : -EPERM;
> +		dev_err(&pdev->dev, "pci_alloc_irq_vectors() failed\n");
> +		return err;
> +	}
> +
> +	priv->irq = pci_irq_vector(pdev, 0);
> +	snprintf(irq_name, sizeof(irq_name), "ptp-netc %s", pci_name(pdev));
> +	err = request_irq(priv->irq, netc_timer_isr, 0, irq_name, priv);

https://elixir.bootlin.com/linux/v6.11.7/source/kernel/irq/manage.c#L2109

request_irq can't copy irq_name, so irq_name is out of scope after
netc_timer_init_msix_irq() return.

cat /proc/interrupt will show garbage string for ptp timer.

use devm_kasprintf().

Frank

> +	if (err) {
> +		dev_err(&pdev->dev, "request_irq() failed\n");
> +		pci_free_irq_vectors(pdev);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static void netc_timer_free_msix_irq(struct netc_timer *priv)
> +{
> +	struct pci_dev *pdev = priv->pdev;
> +
> +	disable_irq(priv->irq);
> +	free_irq(priv->irq, priv);
> +	pci_free_irq_vectors(pdev);
> +}
> +
>  static int netc_timer_probe(struct pci_dev *pdev,
>  			    const struct pci_device_id *id)
>  {
> @@ -375,15 +622,21 @@ static int netc_timer_probe(struct pci_dev *pdev,
>  	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
>  	spin_lock_init(&priv->lock);
>
> +	err = netc_timer_init_msix_irq(priv);
> +	if (err)
> +		goto timer_pci_remove;
> +
>  	netc_timer_init(priv);
>  	priv->clock = ptp_clock_register(&priv->caps, dev);
>  	if (IS_ERR(priv->clock)) {
>  		err = PTR_ERR(priv->clock);
> -		goto timer_pci_remove;
> +		goto free_msix_irq;
>  	}
>
>  	return 0;
>
> +free_msix_irq:
> +	netc_timer_free_msix_irq(priv);
>  timer_pci_remove:
>  	netc_timer_pci_remove(pdev);
>
> @@ -395,6 +648,7 @@ static void netc_timer_remove(struct pci_dev *pdev)
>  	struct netc_timer *priv = pci_get_drvdata(pdev);
>
>  	ptp_clock_unregister(priv->clock);
> +	netc_timer_free_msix_irq(priv);
>  	netc_timer_pci_remove(pdev);
>  }
>
> --
> 2.34.1
>

