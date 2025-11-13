Return-Path: <netdev+bounces-238437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 278EFC593D2
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DC234EFF85
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8671735CB64;
	Thu, 13 Nov 2025 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KT4euzXT"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012064.outbound.protection.outlook.com [52.101.66.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678E135C1A5;
	Thu, 13 Nov 2025 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051240; cv=fail; b=BpvSy97MrJXkHnaeAwu7/5XCj/MRn9WPvEj1KGdYhxGRH39KqEWLMV4yuHlj2cRYz6z/Hh5EbrB9CQyFwrzp0Q6v1kA9oVK15wEZmTb92Bp1ykwvbIbdHNyrNU86K4nlcCxavtUSe/4hpEzNJEZ1mpzwikQtcimHFxyyQVRu/KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051240; c=relaxed/simple;
	bh=8opysdOsBGsAu+RgUebHsK7FWvCEuSb3dLcPBgH+XWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EM770js5gGdapRaxIdwHyDBHL5D555teWXivPL0cdkg2X8sfR+Yf8/1rsjZbjZKkE4wUJoaDwwRTp7tutLzsgHnp59auTw2M2RpgHrQ1mwgAHP9dAgx2ohYtyeJ35K9P6JZ2a560F9rHgBzAaj61/4/2EEQieWLff9NW0Pw7Ad0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KT4euzXT; arc=fail smtp.client-ip=52.101.66.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=joqMhOPeFXGZ9T7eKPosFA+MrHNN7IWitWWe5xY9garuVKdZZVaDSM8LlQbzOWau3+Meom1xR3+5LNW4bbSgk1OBF9Cq4i9JpJzgXLHR1C7eL/LX5g+DZtvQj+G9jI6dJmGVQlogeU3G1rJXa0y02m71jbtHgzxDDRjGp9KD3S7TZ9sDy/+ItI4PQ8FwbE2SAoX2F1n3FmqhRhIj9i5OoMjkKrQru41xcyN18MlyC9FqczAmtr7a0roqoKzwAViT6lPrrs/RxIXWt1K/oFyCWo3CPPDLHkh2b7VXPnkqJB68CTWJoRhQt3HCQ6ouKvPpBvOVOFtglYhWuE9SyU6NkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oX+Cfr7euQRZWAWhF3L+lXZ9nSxJdDVWg8jXc8IFzw=;
 b=ePeLuHw6atqarYbhXT+QA+/V7SvNH/Bgmpmi1ivo66QsAIwHRmzYHLOFtMeAYYOTNtYO7inXggQ1KjMwWIokPiwiE6LzMnp/99sioLDXMCHLooDfH21feY5eNRwgKJw+1cgtrSy7S4O02seOf/F8UDGJTtZugyucuj06EH6fmz53djFiksSjazjthyIGll77w/W7C9ZKtHcuhigF9ek7E6CKc+mRtC5Sog8TYf3lnjpg96y68LV5p3XiFq/hhh5FeEH1RK5g9E0Y7Vmb6KJKxWUsVxR1oKCq3KcTBdnLKjdoj55S1bulkZR+SkfTdwoiGZetTJb+ZyZrZpi08Qknow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oX+Cfr7euQRZWAWhF3L+lXZ9nSxJdDVWg8jXc8IFzw=;
 b=KT4euzXTL5Tti8urP792uFhAW6XV9Kldrikp1dm5jG+5OPV14eaBj1boZhYBRwNdzzR7Y6ko3HOx/y/kH4e0eAfPWBOwe8n1jDpA4F+9MCx8kloVNg1IuGXPdMquRzV4wQzDp3KiW1MVGuDYszAiNG2hbsvYXUYmssMAh5jBVilJEEXQbOwERgeRJ088SF8fgl+rbpjWy/G08V3pzb01GwnS/vX+Jqvm2V9BWbgiWnlQ09c1OZnO1jmE/ylpfamGK6byRWGe3mA3wHtxHjoFf0byhIUOjGlt0rTt9tr5112mdqe9WlD+65YcU42zaQi8c28sxneXkEU7bvMkWL4i3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM8PR04MB7762.eurprd04.prod.outlook.com (2603:10a6:20b:241::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 16:27:14 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 16:27:13 +0000
Date: Thu, 13 Nov 2025 11:27:05 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"eric@nelint.com" <eric@nelint.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/5] net: fec: simplify the conditional
 preprocessor directives
Message-ID: <aRYG2YqpeOr3U3XS@lizhi-Precision-Tower-5810>
References: <20251111100057.2660101-1-wei.fang@nxp.com>
 <20251111100057.2660101-3-wei.fang@nxp.com>
 <aRO3nMEu/D/kw/ja@lizhi-Precision-Tower-5810>
 <AS8PR04MB8497494755B820A2D33ED39488CCA@AS8PR04MB8497.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB8497494755B820A2D33ED39488CCA@AS8PR04MB8497.eurprd04.prod.outlook.com>
X-ClientProxiedBy: PH8PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::23) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM8PR04MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 2051d790-00e9-4ad2-e946-08de22d18096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HoL4CfQls6nOW/sdgvKVlEfee5iysAym/QObsJzyew3q3oz6KBvFLFbRWJvB?=
 =?us-ascii?Q?M8iJhTTw4FhKXDM8hFzftn+gMZkEEyWDjkIs0FRJ4U9Br6Ar/BEs92ncCvAi?=
 =?us-ascii?Q?Ftls2Wqq+HWePnjf1INe865lgf45RHeK5mUlZD6nehb/fNNnFlNvezEuUHtS?=
 =?us-ascii?Q?gyQWXLVrkRmC6mgbAhe4P1LdeHKb/14U01JqK9/ZwJwHTKn6H7wJ7Z7mdnfv?=
 =?us-ascii?Q?1ZytTQg/CVwl7JhUpawsz8u/8Aa39AzDCaGVrLqBZofKho1OpcANR5uk7z42?=
 =?us-ascii?Q?3ZB1Z/WmgNwqSjbM46adBH57B7VUu2XJke6ApnuHmdMsitqtjHrdTvnxKtRv?=
 =?us-ascii?Q?A2NEPam4kPeXGpqtb9XdgZJ2xmnUPJ4M8xCHCXwQAERJbPiVqVTuWALqy3j+?=
 =?us-ascii?Q?fIN01jQMKziqGKNkJUYnjoCoDmzVc244IP9qrpeJN/k9ipWhIZC7EonJvX30?=
 =?us-ascii?Q?QviOGilOYtUlt11YjUhSdweMim7silOoIOqdAVQmFpbAsZNDd5W/AI3shdHE?=
 =?us-ascii?Q?yIG91uMQOLTWqxtVoXY1K036rR7EV3DVA0aZWhiGzMRzvsYTfadWJ8WO/s+F?=
 =?us-ascii?Q?0YvOvbACBZ6yKMHRTaRMrfftZ1S3nx3SUGuidQACDuH6CIIt9Y3fy76WV6L2?=
 =?us-ascii?Q?JaC/Nf3DQqCa7R9zrJJgZr9utMo9c+9oHccXy6vY0gXTWci3dCx+K3Ojh65z?=
 =?us-ascii?Q?9+j5pzjbFaQEA905TbNWVQK8RaNnkG4RKSG4VLmmvcvu7ynJIHZeEjVW5EtE?=
 =?us-ascii?Q?xx2ch0CYkOVYzFkTr9qodaxjYUoACkekEDrNjqzZUuojBCoQNuJzL6FUx3sE?=
 =?us-ascii?Q?djOWlU7Tgf3rK7qf+hzmKrp0s7dCIHA+lvnQ2TLOl+cqZW2eRd3TJQX4v1i+?=
 =?us-ascii?Q?pSpS63wHhGCaDgbmVJ6Xv7FWePsKEQALFzzG3IbYSWWnFjJak7sYQYO3ol54?=
 =?us-ascii?Q?9lpcQMNAAt5XbPHLkPe9FVpsGZOiHCpHpqGUgs3oqgV0ehVBTD+uVzmp7I6R?=
 =?us-ascii?Q?Nm1eU+vjoWXJQ2AFRN4a77AtzYiVj3CqohwZ9Q6UjT8lSKhUlpXEyYLKCPY6?=
 =?us-ascii?Q?IaD/64TY+ie6/R/BR6wbWHVZjZ4mzhnTI140EkxADntBbWEb8JHqR/ib/7/P?=
 =?us-ascii?Q?GFhjfHweTZTLL+4Gw7WZEWOjwF9Fr5DEZG9oDB/HEfDBdkCnnck+ddaZnNm4?=
 =?us-ascii?Q?MqKKDFvTOh8A8BgEvi7s/FQ+BNo8QlPsMvdzcGIJ5MOAQ29mXUIPbNSeMAZr?=
 =?us-ascii?Q?m1m1BAjNtgk+sJk8keAMWl9cvH64eo71E/zgbCJ2C30pWT6sgJbOBB2qq1AE?=
 =?us-ascii?Q?74F/HjufGQM98re1JRb15ycYmp4+xg/5//jnI8TDbNW8qlKb2yrOOI2pC6Qx?=
 =?us-ascii?Q?pRyvmJnotHzDwnw3gN1qlPumNoMe6/pyHNQ7rIeqhGIjimjkNpwpa3jYwvkQ?=
 =?us-ascii?Q?OLVL0WVQ53hCL6BWSwl7IVwqdlxfwH+46ju+ZKC0lttafL3SYDZ6a1iPnkRY?=
 =?us-ascii?Q?rmGZ9xZW16zYryD9aBCK+8V1VvuAuj6dhnhP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uJorF9cT53Ap2Zll839fZixXUmv5isrCk/k7B3fyB17XQi7HUTioonUBgS9f?=
 =?us-ascii?Q?p5T6z0ktGgjkE9NPv3Y3949ytQVcgxqOMfyQVh66kNbwkuNp00mx5nmG/2wQ?=
 =?us-ascii?Q?qzw1Z0dTOHBflw0Tc9iTXVsc82Ng+YcyPEFc63KBcOnf/AWvcW40Gok33xD4?=
 =?us-ascii?Q?Fm4f1ovhsMV4lPwKpXTNXroHeWGYx5ya2a6VkOicHi0+EYWexEZso6Sk3alY?=
 =?us-ascii?Q?3QAAbn/ggBdT/O9PTU5q4Vo7K7CWTXLhOXUISVJrysc1UvbIxAMPHfwwB4RZ?=
 =?us-ascii?Q?WYT7UpYoTK/8YaGE8xsCQ4vApjUmTQhvQhGo7JFHR55OLwY76jLn61m+2rv5?=
 =?us-ascii?Q?yJvZH2WVkT8AG35KY3PKVe/9VyZmmjGnRKm3viYh6ufMPiIEs+w/SsNHskR5?=
 =?us-ascii?Q?mzRwgGu12q+hdqNn5mzjbhTCCtHyHwFuHc5tdm6UO+KQrQuj+b6fk9Sne35u?=
 =?us-ascii?Q?yWNQqvW3NRx0jx9aPFBM43PRAmcWNmX4OuycN2jdwXF5HhkSgm27c/fCNd7r?=
 =?us-ascii?Q?UQMwS+QI2IQ83TzVKn+Nb8iTgMea1+X6lxGp+vbpirtCnoCpz5alZbTLDkGV?=
 =?us-ascii?Q?g4VdUEhd/WBU6hcd0/M4DYRjnSF7tuensZovsRDZ55ADxYsQTxIetxOoITiH?=
 =?us-ascii?Q?eLg5y22bnNak7v70//MRa1++PULjy0fr7RumDFLWJikknWyfw3nVwOgFc1ja?=
 =?us-ascii?Q?Gp2P29Dq3UAXO0IZtwFCw71rCMDnl+jQDRfVL6WxkF+x8klZeW+3Cytll2Gd?=
 =?us-ascii?Q?LfzxaCihrWtSSWq29A+VyxyadPAjz1RnIlZjEPECiATAm1wJIrScDlMj7+Xv?=
 =?us-ascii?Q?JTRJTcmy9V4uCLmOOIILIalGt/z1gJTlJkWkeE4fG/ujJs1ZPUaDO5yKRlwD?=
 =?us-ascii?Q?VkkeldgT4/Ulnue3mPRcFF/lHqo2+dML6+A5NHpGhOgv0ixlRdVlskhbi+KL?=
 =?us-ascii?Q?fjXhOKzPCk0RvW5bEo5DxRpQ/e/RnSsn+LmOQ9mGC+O3k66FemMjvSNFwS/x?=
 =?us-ascii?Q?PA9eYInm9AHqPeSloQNlHU2Nzf9LhiyZNI6pUJGkW4HApyYqy/6LZJNi7ET5?=
 =?us-ascii?Q?amelz68NuMdD/A6n/yeMVQPSCkz57A2gDbDf2uJBYrAfdejlPKtklFxPgVKz?=
 =?us-ascii?Q?vc0p182C4Ydv+uFIrqspu5bBeESwLSlDhoaC/H19Sa1Z3T0omgXdaYXuKfuS?=
 =?us-ascii?Q?PCkaSQGzNXhp0goBka4GKh5Ek3VYSEzP4buaxXiX4Gdltwv8qLYdSGMUP16R?=
 =?us-ascii?Q?R0HS/Ore/2dsqDh5++rr+DUyR8B7DEy5mxEZ3+kqbI3/NWA2jaVMp9SkkC5M?=
 =?us-ascii?Q?3t1d9yLSLeu/Xi0Mi/cWYKO/2DBlMgFiLnBykgxw5HwJpTYbe1Ay63bMk1ak?=
 =?us-ascii?Q?DHRvjewBwXYgRWeM3YLNCoMLF3xVK1Om4e9urjZf43T9xusX8UxcOcNgshMH?=
 =?us-ascii?Q?bKibF8hXxK0nJwDgKEiF8JUfsLJS/wZtKJvc7/kGCxghdbTRT5N1xiqNjMcH?=
 =?us-ascii?Q?JYPoagkJUGtzZxhBKwx+GGb4OGXXdQV0ZY7F39GF7pzvK86uSvMRU2ANPZ9O?=
 =?us-ascii?Q?5wV+BF7IBBs6TwcTNPD5EVZ7XCtmSDLD2DUoq+4+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2051d790-00e9-4ad2-e946-08de22d18096
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 16:27:13.7904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9TpTrqX5vl6OzaLi3DfIGb4YeM/lIktqDrbOHmCPYj/ZjVEmlYC9iI1jTSex+b5Va86m3i8ShJT1ZI8qxKUBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7762

On Wed, Nov 12, 2025 at 01:53:15AM +0000, Wei Fang wrote:
> > > -	if (!of_machine_is_compatible("fsl,imx6ul")) {
> > > -		reg_list = fec_enet_register_offset;
> > > -		reg_cnt = ARRAY_SIZE(fec_enet_register_offset);
> > > -	} else {
> > > +
> > > +#if !defined(CONFIG_M5272) || defined(CONFIG_COMPILE_TEST)
> > > +	if (of_machine_is_compatible("fsl,imx6ul")) {
> >
> > There are stub of_machine_is_compatible(), so needn't #ifdef here.
> >
>
> fec_enet_register_offset_6ul is not defined when CONFIG_M5272 is
> enabled, so we still need it here.

Is it possible to remove ifdef for fec_enet_register_offset_6ul?

Frank
>
> > >  		reg_list = fec_enet_register_offset_6ul;
> > >  		reg_cnt = ARRAY_SIZE(fec_enet_register_offset_6ul);
> > >  	}
> > > -#else
> > > -	/* coldfire */
> > > -	static u32 *reg_list = fec_enet_register_offset;
> > > -	static const u32 reg_cnt = ARRAY_SIZE(fec_enet_register_offset);
> > >  #endif
> > >  	ret = pm_runtime_resume_and_get(dev);
> > >  	if (ret < 0)
> > > --
> > > 2.34.1
> > >

