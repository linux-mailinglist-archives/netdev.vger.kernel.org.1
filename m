Return-Path: <netdev+bounces-216534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE5AB34547
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 17:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282183A2310
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 15:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09612FCC1E;
	Mon, 25 Aug 2025 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hHU01I/z"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B111C2FB997;
	Mon, 25 Aug 2025 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756134587; cv=fail; b=OPqq2VH6uMNyqMcSK1rH6iJsYDkPHPZOgU6eMNs9ncNaJg0jUeqvFnE1e6aIJAmMAO62UjpoCKn8KApts02JZcK9ry6ie1rtqw97wmJePlQ9abQE100Yyrp2qMomt4LpHHVPOTSvAX/NoIiMzohLfJIgcpCis6GfEG24bSkgfoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756134587; c=relaxed/simple;
	bh=pM6alg2R1Oa0GhgphNe9lq/xvK/ckye1b1BzGi/elfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M1i3bVGTI0kD/keAZIAdFnp4gyWhAM2txd9S8L/WDFNnq3MjUOx6vJy3ey/eoqrH7iiK17tcy4n7PDvX/QtVeSfxXSJ7MSIkH9bTXtjX4+3X3S1tqo8snSC4R806ruNym7McrbhD121NaLmetV1d+31oh8kFklOb3hjLsDnwOLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hHU01I/z; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSVbRHPpDQPGcoxqodd6j0BJmSe9wh86ykw8Z2KTNok6+FJ6tQPsCXwzNQbcJ666U4U1KzEjZxNQE/BjAlUJp3MtooJE9nOw/HFZvqdbP/kjW+Lu7/7NF9UO3N/kTXYg2D2TVh2ZIP191U/XLMIUNEZ1ufCNlR1N88G5UWZ3MPFBXa9pkJLK/4lqG2xYkNMA787GbMwbxOcSN9AES0ezXFPw3Scxml6oTcLBs213PHnp+g3vSqXAEhJ56HwTht4/GT5uHG4Ef1UxXjQfrki4sJFs+Fw81V94Xuvpj9GjvZjHT07auUbY4ZwIOFMytQVC8J351Gko/4vVHLZrB8+QOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M04R0y0IJISt3ICndXXU3gHvyQ4GkjGQsNzOfb4v/pI=;
 b=WuCpj+tmKpFw231z6sMCkqqyANkEw3x++gL/cJqtgU114ItrABYogkO5g6FWEY72uCLl9+wO2c5pS42Y0dM+ZCGqUWjPkOjSqETK3YCzrLYHKzh8osOjWQ8TIGpjSQZfyX6Ri/2Xh5g2LDujFN9droexDkhkc6k1GDimAbwHhOS3azOJSkSVunmtxPlkgKIwLB7nnn01eiP240x+HbV0dv6g9mjuN7z7wACN9lT1Byo0MI5MFBZNi7BJQT0U7wEJCqZNrKq8njfyCCiMjcJyZBPGKk/ANBlIwY6ucffeas8c6T6j2yfrQ1XR16UqDkEA1t3882m/twovhDUQ2kIrQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M04R0y0IJISt3ICndXXU3gHvyQ4GkjGQsNzOfb4v/pI=;
 b=hHU01I/zMT3sgy9yZwwb1+SXkqZ0vv0/ZmWBQDUSJiWSEsvKfAkHtIALRebixdPFu7CSwvulF/rwRfapAktiGVob8QPDt71GZ9zh0bj5x91pKlyNM6Rri72zjYqaflFaNVeobA7UdQ2hmNWuYnjA7jwbviVIXXIKQGOmSmMdqyuzXQ4gGuxOupKGCVI6IVC5T1XFhjH7RReHfOAIyBKeWvBCLOCbaiVWg5asz3culFkNeL1f+hZZfbBYE+ghLX2KGL/fq/NLeHQT+EJGEqiElbeQ2JvsxQK+PAMzuM4fQqoPlrX/BcmpVyEv9Kwk8nPO9zUYi2bWB530JsdwLecYqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by VI0PR04MB11022.eurprd04.prod.outlook.com (2603:10a6:800:25e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 15:09:42 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Mon, 25 Aug 2025
 15:09:42 +0000
Date: Mon, 25 Aug 2025 11:09:32 -0400
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
Subject: Re: [PATCH v5 net-next 05/15] ptp: netc: add PTP_CLK_REQ_PPS support
Message-ID: <aKx8rPX0uvRaP0KB@lizhi-Precision-Tower-5810>
References: <20250825041532.1067315-1-wei.fang@nxp.com>
 <20250825041532.1067315-6-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825041532.1067315-6-wei.fang@nxp.com>
X-ClientProxiedBy: BY3PR10CA0018.namprd10.prod.outlook.com
 (2603:10b6:a03:255::23) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|VI0PR04MB11022:EE_
X-MS-Office365-Filtering-Correlation-Id: f0579427-31a0-4798-8d1d-08dde3e96b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qHAb83VuDOc0rfc93Ts4LqiwDa39i6H7TwMqocNDY5rR1nTSNnwhU+G5yX66?=
 =?us-ascii?Q?/P8y1m3TBtjGW/quIWx3QO7miLBArGvkYfGRedX0Gg19QVUxqmCa2hLbvDkz?=
 =?us-ascii?Q?qvF75/6w7VoxCdhnWqMh7mJ6DqJBw9FvkyqVAx3A6ZOdiV3c3tYAqHSuJN7i?=
 =?us-ascii?Q?hVzQb/0hm9tW2oigTzyZ4eT9JOLhGv9bNw96kBBTflpy9/KR9tCa4OF/aSEz?=
 =?us-ascii?Q?v1EtzM529uumwK3u24li8xbVV32erbFvBSOqiAZGVfCxgUU7Me5mm/oVTopW?=
 =?us-ascii?Q?EX1Q3gLVahlrm9CbGeKbgHNHDljj84vZlMMQaf1j2p2PBzFjttB7/d0b3uOu?=
 =?us-ascii?Q?aSz6YHy2Vz8y7qf00ZE0aQpcwk+fKn3e32PQzETk7InNAbGQQM66KVivqONV?=
 =?us-ascii?Q?FOurSsRRivzX85CnrDOD4iWjaHNYXJXk2wzhh4mF6VnMtO9vaCGrQ1oY+gzi?=
 =?us-ascii?Q?hXM+8VGOcJr6EacFelBX6WIWA35MYq/PJN4F4F3TbvltYV27hpEaKn4EBF7p?=
 =?us-ascii?Q?80eHRNh+dKeERkOmYqx0pGJxEkaRCjvVHYxTb9861+2F7GwLxpuLHvam7Vry?=
 =?us-ascii?Q?kmTcxAug5Q5D1Ec3UpPXYddTYuCiFhvTKxzgmiK9GdQN69MRvxbh0QSL57aj?=
 =?us-ascii?Q?uXpEDppeEqNREfD5sXCpXNYKasZNp7ayKU02b8PxHGz2J3JonipJ8VInC3pE?=
 =?us-ascii?Q?YmsRSP3BL7DtZoj9dyC4hS+T/lOOukFjlSl87K/6VrTiyRreARVf0djzE2yH?=
 =?us-ascii?Q?1eKF57wiiNXqDuF628rtZvGiPTmbcg3nIqtJxdm+sF5rOKulsHAEVzjIpCuv?=
 =?us-ascii?Q?OPOdH1SooB8u8AqpMvZrd/u6BoPOmcsLT1HIm8P5hglJgGytSys8RCDmPd+v?=
 =?us-ascii?Q?5a3qnX9cxSrgk76GmefJ0a+J/Uppta2Kj0SSisIyrE2x4KQ53gZRLrRWHIUG?=
 =?us-ascii?Q?2L3nAghnWRYRm1OwAVl5GIOsj6/a3unQcoVc/ByjA8S7uE2bgPEYSn28evwA?=
 =?us-ascii?Q?ygU9SlZmeZvQbccawoe2oCAnNFU5JbrwKbVHJEgFVbizRpRp47XRD6eCbtcg?=
 =?us-ascii?Q?3yQu2MMga+S9zA3TwyNOYd6cNKM8nUFXZthfylug0eJTi8eIGI1amfWxK34T?=
 =?us-ascii?Q?M+m+1YQ9cgFBhTZvO7I9DkpUITOZNuFtrs/cZbjtmakwk5KBTcyxy5Gkk0Fk?=
 =?us-ascii?Q?XyFoPuifskL7xKj/vJsBmurwFKnckh2+UddIIiiEfa+yRp2a1UiixMXJWcT7?=
 =?us-ascii?Q?OGpYybxDICdeM9yILbNUS2p4795GuvYQ6RGkFsLedmv6Qrdx2aEx7U1GA8vW?=
 =?us-ascii?Q?0SBkSvLvne+3K6asAOozPVQFGDINFG+aYLNpent90HfJ1IVolBZiwxVVSFx/?=
 =?us-ascii?Q?qesKjQoNnhD2PYmQUtn0h0n3RpMiWzdgyCP8kBBFMN6uOkErUgiBqCZMKEgk?=
 =?us-ascii?Q?v6bFRVfI0FMxEnf9BButonmWrU2xiwmGVG1YBb3PbevibNvZlZZkmQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KZ2WQ17ZNmFkEI+hT2+5klsg+fDED5dVrQDdptIbm/uzZx+JZ3iIH3wns1qh?=
 =?us-ascii?Q?n8IQmn+77gJFGaFJieQZSbhlxpby0q9XJzpFkUdW0Vm8f4AEnW2eWH+vArQX?=
 =?us-ascii?Q?DgtoTNSsMnvKgVfbtP1eM07iN1VJRAIKE98WAty02yZof6RpIocz2Ix79Dog?=
 =?us-ascii?Q?S0c+SN5xQJbYhAuQicaCyKN7L3QZ3BvR0pHr7DJ3iY2uaQWNMbuooOAd6aDU?=
 =?us-ascii?Q?K9Pv+F4exmW2+V2AV68raENqFEIXu5T5DWBTTXXfjWBxA/Oz09yo3hQ7NdHR?=
 =?us-ascii?Q?Z5ODqM4vTQWx5ipS/GhQSV++ihThaTndEngOTyCLqlodRnCTYIWbiC0rOu8Y?=
 =?us-ascii?Q?sZx+8BXKXaDWP9srkuneMsyJTVOZtU6y4ggy8AcTZOH7EfLiif9jMYMN3hsf?=
 =?us-ascii?Q?fZ1hWU6+E92ZakEhfPQxyXXnN1y4wAaSt9QY204dI96DwxR4WdnloRlc/hZu?=
 =?us-ascii?Q?jujHstuyu/sxyyt/W2w7drEecFOaTsKLHw/jKsuYV1Qjt8j9RnJaRrWbrzT9?=
 =?us-ascii?Q?WdgOVDCYJbPWssPccC9N1st7jRAJakZ4czXI9scLkYyxxHqAlRZeUTLGRtpo?=
 =?us-ascii?Q?6cFCY4UAQNfblI9f9/7PKfz53C3nI0uTyGa/g6f0eOXUVgslV5yQe2wnbgup?=
 =?us-ascii?Q?mhr2OuYQ8EtdBx5MjJtlZyoJadgR5sDHXgSOcEuvkU+4hO5UVB9TNpJxPt8V?=
 =?us-ascii?Q?+iBwlbvJBXCn6CyWm/44HNiFYoRmIVMDzjfcX0YhPpDTrxqYYxAlBwTPjTFg?=
 =?us-ascii?Q?OXH2AoIx1uC4L23mJJatdibbyRs4ib9aO98vHbjQOMvyBEV0u6ynuqa1plD5?=
 =?us-ascii?Q?tlDvM9meJiC564EPuMIqRlDFg2BQXdtj7cABpaXVPsUIKslF7fPAQ8dLce2P?=
 =?us-ascii?Q?ul/w3FOLCMEXo5Dnk0h+54ZOw1qdJgoxSaXBTca9YR6CnvELM9U+yizG//PA?=
 =?us-ascii?Q?loW/BRN4s7uNXRWWx0b7QiP5JDiLVXt/B9lhUm2JtIh3pbE/ZU7s3AIumFA6?=
 =?us-ascii?Q?EefFEkTqkaTF+mibSTB0jm8vbawpxPrQtfbmexVtRsRfNreLAGTphjA9FKbf?=
 =?us-ascii?Q?o8sCEbZ6r0Yx+hJU5safcfX7szseWDt9Ybk8yC/PPPrOZmp3hqk8muO3EY4E?=
 =?us-ascii?Q?Jw6LFnwjGUJ03VYAehWLq6MQYecZU+z3PbEJXGiO/QmtBsF67OCsRCg4oPH9?=
 =?us-ascii?Q?+gblKK+1JaHn8r37usFj2Ir4BfRDugslv0tVxwLF+twyTzefyak1C0VQXVYp?=
 =?us-ascii?Q?03C34MqAS3dxvFx42yTrYmzc+j0mDcZypbxpKSKniZSxNTIiljXv8qyXSzRS?=
 =?us-ascii?Q?SOtxNtkREfmdX0iJRyqME9troQcl1VJUbDqgsIybA95pHawH7h+7KkZN+Qu/?=
 =?us-ascii?Q?wg/fFDm+EvF6nQ7ZqgiAeRMdOaU8KUR/tU/aOV69JdmaCsciEECsbgnLr+go?=
 =?us-ascii?Q?k0T20ObKFKgWLanwn4tG7Y+yPNp/3SaiK3UtD6SATForfuikzpNfx7gKuT/1?=
 =?us-ascii?Q?7RfZBN5JXq/awXAJUCEdHP6hfsU3+7RXXQ5acZhpg8j3BJrCQaQcDvHfred+?=
 =?us-ascii?Q?EezfabIERfnBmRMqPfk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0579427-31a0-4798-8d1d-08dde3e96b6f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 15:09:42.7356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uT9cZnKICA1S/CHmbhvcd9ZhqdGJPWpTnmWah3E5GdOidb6zghrVEjiwuLCCmeLVlW8uSKZGQIqzZ8ryff1AlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11022

On Mon, Aug 25, 2025 at 12:15:22PM +0800, Wei Fang wrote:
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

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> ---
> v5 changes:
> 1. Fix irq name issue, since request_irq() does not copy the name from
>    irq_name.
> v4 changes:
> 1. Improve the commit message, the PPS generation time will be inaccurate
>    if the time is adjusted or the integer of period is changed.
> v3 changes:
> 1. Use "2 * NSEC_PER_SEC" to instead of "2000000000U"
> 2. Improve the commit message
> 3. Add alarm related logic and the irq handler
> 4. Add tmr_emask to struct netc_timer to save the irq masks instead of
>    reading TMR_EMASK register
> 5. Remove pps_channel from struct netc_timer and remove
>    NETC_TMR_DEFAULT_PPS_CHANNEL
> v2 changes:
> 1. Refine the subject and the commit message
> 2. Add a comment to netc_timer_enable_pps()
> 3. Remove the "nxp,pps-channel" logic from the driver
> ---
>  drivers/ptp/ptp_netc.c | 262 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 259 insertions(+), 3 deletions(-)
>
...
>
> --
> 2.34.1
>

