Return-Path: <netdev+bounces-125068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B3896BD3D
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 14:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8361F2681F
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1315C1DA2E1;
	Wed,  4 Sep 2024 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TwWmIhmm"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2085.outbound.protection.outlook.com [40.107.249.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AB71CC175;
	Wed,  4 Sep 2024 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454514; cv=fail; b=s0L6DcPM0DYlY+mmFcsB4youwvWEajTSJMMwZ+jDNt48eUTWJIWWsYMVMEJ/uVfCkNaYDfymbAL5tCmxiDB8mZbImzrmsoB9Na50vuR4EDiHmsi7KW5i6eVHAlkBzUchNwPMwYFiulgb3uRkGFbV3YzNDZ5IbQGOwWWB2nib9ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454514; c=relaxed/simple;
	bh=bCNeUy4lDSFBlzsE40t8VwPt240/c+RHdtqUw+HnD90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RJhPpA5VJmCKvWulbPc12gsGi+0jvS4S29iV3MgkxSgI9JqOi67fMsRjHj9EGU0RR0HoK2FNTplNzyQSChMWRjBjsn0mNSzZe9pWkL1IHyW5yM7srn2Hbvqht49+RF3rSMwPEBjHMd/6KQXNLk0T7rkH+SEcu26qdsdpkn/hnOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TwWmIhmm; arc=fail smtp.client-ip=40.107.249.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXKRrQLHlbQ80tpnzrNpvk1XPYQMhuIgr8KYZG2tMJS+oXVYpR47NSy+11irzJN7A2HKsTspD0U4l7CTzPCDFLw5Z0QRh8qGEcpYg50MGmGEAmPptd8zvFjwTj2mr4A0m2B1bwJfEq3LEhLpMlHWT1Y9NdQA68x/uck44uuP7V/ci0mV58YRr7hYwspwnULnPNIbcJJEsnvK8xqU6SBW1bFGf4b69sazoZTfFolaCjlnNb/TeZf9p/Laq/I1A4NjNyPpyUNQ8aPjdpwLE2Aulevv6DkR/bqyGulaWR0roQLSrwku0UJxFQVKQWo+4X0iHKbTIKakSDf4+3hdYvU2Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhEHjoz+Q1MNlZ++9YV+m45E5kK0H8mvrsPEUDjJcdI=;
 b=DsPRViUxJ/D1UT19As124ciXKP5VdWM1q2t5YEl9AXbRowv/TJHxhPHJfIHGV3rjFCnJZ12vIFyDZ2ELnWXfrEcTMpM4+eJmQu0sA2Pkjml6SVwHnvsmAGmHclNNR/AOFuBVJznoAatvrmxAY3NWXiWIwieM0aL2/xs9DvGiB/Ov9eb2nJWUwvbJxQbMkJZOLDRjwxhNgimXPHzxT0pBCp7agvJZ+EMo7K+GQXqbZh7DzbYEoefbEsZhd56F6xFXYwkv1MKuSltWNvApsufXtRg8HFVHO6YNJhZU6lV6h/A1BN8jRqd0N7076R3N0d06NZ8TxmLW42TfhBweXUdGHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhEHjoz+Q1MNlZ++9YV+m45E5kK0H8mvrsPEUDjJcdI=;
 b=TwWmIhmm35K52GgNN8lwpEvyimwUeRDSYrVQwPBn0xJUZ+0PD4We9Nl5wD31QgMC/6VdLnwexMb4VijgvzB4Z/2ToTluRZb8yuXUmQHpNA3SapxYPfUo/tzFb15KXg2pk2IXXRsUDY0RzTdc+guegHf4oD8WjbnGk+VUVFEqVGHgcWcohz7+S++krVqQLZQ0rrHL9TcWDzcTeljiNzHstSt9b420XtohfgpIYVgfRfVTdszyrEio7O5G+t3CN91J5FuUO/GTyZBDEHj5V6EfKWkI6h/GTOfy5zTaDEChgeL3mr1dPXZWldOkUpB9a+SltGDkvxVemzO6ASXUN0DgRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS4PR04MB9361.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 12:55:08 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 12:55:08 +0000
Date: Wed, 4 Sep 2024 15:55:04 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Martyn Welch <martyn.welch@collabora.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@collabora.com, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: enetc: Replace ifdef with IS_ENABLED
Message-ID: <20240904125504.fytmtyv3n2csnaep@skbuf>
References: <20240904105143.2444106-1-martyn.welch@collabora.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904105143.2444106-1-martyn.welch@collabora.com>
X-ClientProxiedBy: BE1P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::13) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS4PR04MB9361:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e1fab8-7d47-49ab-9548-08dccce0cd6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JmFJjydcovb83Ncicq2fuofyNfYOuhjpYbLh3xm0ojeSIPNaEuEzpGFWuGVL?=
 =?us-ascii?Q?fPgPGMYZmvTxoCyJkEdKeR3xXMc0T52bF8xczcZyfb+HZt1f/g3nGk326gP+?=
 =?us-ascii?Q?WH4P6zYVFcTmrSd/PgGM39l12Y9pTsX71+Db1aBXTLy3IxIZKDav82P5Dra/?=
 =?us-ascii?Q?lMNBG5xKG+5mQIj+wIy3XO9ReNvp2h18pNzuT+9tL8x8NfQCWRwYXuJHAlul?=
 =?us-ascii?Q?YHQvm7FYbhuGgdXQJDp6vVwsDTLlhlQEmkYNookrXJ6r1kgPup/czJemNFFI?=
 =?us-ascii?Q?kjzKlDrDQ5ybJoelbiJ8lDC9fLxx3F0NOO7t902Q6Lh/uW+KAuDBlKYS6ZaP?=
 =?us-ascii?Q?kRcjUvtWd2LC2u1A2j0BcqjbZmkWkebDiD0lH3W2WYgZr0F7wO3Xu26F767e?=
 =?us-ascii?Q?rjy68Z4BXs1NxLdozK8l7uuZEfxCVvivbH7ztEw5Z6GY3ZfhDNxThI9YAZa/?=
 =?us-ascii?Q?Ij6UAdh9NdC8qzW+8aQdN9FbCf15GKiQBiVsNrOxO5r6O+wbgwtoyAT3TPNK?=
 =?us-ascii?Q?VOFl5bI/5EG/zfuRCZOkYnEk2dJ0tcKK+AIB55yTZ5k9mVNmYBjR7vaQ4iFu?=
 =?us-ascii?Q?toa4DWFrGTiqoxx4u7L9LXc8U4L2IUfKTETTOJHIh0+z4zAHZz3wqB/9yz1M?=
 =?us-ascii?Q?xggrtn2gVVAYDFUpqjXx3nphPfRgmgKZaMHJCoTvl/6D9WPbMR573ZtPX9ij?=
 =?us-ascii?Q?GzcRMEEUaq/xjITADsVeisLk2qjOwH9sBc+UgQvR9tv07SsHP8FMhCQeSkgS?=
 =?us-ascii?Q?DIfvkYmvDsYqjP4JJjxl4e0XFZSI9SiY2O4tczYT3qxVyg/yHJW2YsLYfGdr?=
 =?us-ascii?Q?UL5B2xsI7ilby4DtNchMLF/IQ4ybVRy5/VUsuv7UpLjdXyhrWZjbptfxCdKE?=
 =?us-ascii?Q?HGqsFSd/IHl3Qc0WTHJGjmOzDbGs4YeAKurvQTKTT/F3rszdSkVb1FT3+yF8?=
 =?us-ascii?Q?R+pbyjiPdKgxb9kuYtNg9WFCDkGfSygEpcRFXiB8v1Rj027sPa8wbUqblkGi?=
 =?us-ascii?Q?AT1MOiRPhM97PWRCNsCVRIF8uhBA7m4YYm/M+Nqb5NS9hitPPeB8Ft7/IQ3K?=
 =?us-ascii?Q?JRLSDxY23MlpmMNoSeAFxTToPC8Xiu3VxhWbrOtE0iaNeOH+T5I2Eebe5/kJ?=
 =?us-ascii?Q?ll7IgZc7kJ11Rtec0G1xq38m69DY2/gttPsR6DFTzlIvwK1M2EoEEgxNrob6?=
 =?us-ascii?Q?ttVIKsjPQm6C4lFpaoEPssPkMlmJGkhJ0h6WGHK7TLjlJRUKSQ9I+G5ZPE1+?=
 =?us-ascii?Q?vrB4qNPCySuYxTBkisvJ384bAfQuJ3APsuPoMxtJ0ROp8CSbbuLeAtjx7rqR?=
 =?us-ascii?Q?8r3eVpvhXolWgYh/7Q2PCM5H0nydLTlT/d1ejTR6FQkvvA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gFvjdjOnaNsnAzSe1Y2usp6saaKBPgfc18ftbEMbQwYeLUgLokI/HIhiO2NB?=
 =?us-ascii?Q?iFek5x0ZKREgv40vSVIMdN00tT8Wa2VwxMwSd4tV3D5smE7xOxpeaSOQXF9R?=
 =?us-ascii?Q?Eq69YBQvfv+iA5rlyWByDjqlB6N19/nPTe8GAtlXNDhFOzo/bZ8izZnMhqto?=
 =?us-ascii?Q?L90yoVEAsR9uTAY4sV7c07QNPraQsdkSxSk2P5iG0ozTFnMo+r+jeiBQ192B?=
 =?us-ascii?Q?mmfuCNFEN8x7y3W+3Gu1oUGzZGWVqGmGrLEJBLnJtUsdVtCgH9WcVyNkQGYK?=
 =?us-ascii?Q?SEWrrTeYEbfdFWtc6/LelJA3F8684X2N3mtbtlKvD40RmhJq5EyRhbzVMVLe?=
 =?us-ascii?Q?FIOHCzt6ICEy867FjjFZVWROZsxyL8xcyC2u4lBF22qePAHeaLsbLpBE05jr?=
 =?us-ascii?Q?Q3PAf9JxyYAW6Wb8utoe+mGWUQxnzDL5iz0woBNnBN6MP06YchbsFnm9Zpte?=
 =?us-ascii?Q?Hvb2/2oK46ZAj4WZ3UJGMDrM1cimQJb5TpZ5/wdVXAic5aHjg379FhQZH8NG?=
 =?us-ascii?Q?NVyLTnFbzSEH0nVAdtrhVynAzap6WWTgq+lRDcKtoveDzbRcUAKvFmUXbs+f?=
 =?us-ascii?Q?pM6BE3RHcw4db33PruZEV+rqUUsLuBYOtvifN9dpUhJT1iB54i3VDrq9bYDf?=
 =?us-ascii?Q?BDiFqHET44MdCY/nGj7Dw8CghME5COF8D+60UyEW/cCat2+YKSuT+yfZtRCi?=
 =?us-ascii?Q?0hyBRmmvq4zNqilQspcDbCPz0amO9np2Gdg9y1h9aascA4Kh0MQVt+h93Guj?=
 =?us-ascii?Q?1XOrlQArSh2iru02s9Yr4tWWg3TonBUeFTfmhuezg4aYpwBgi71NVdPsGEeQ?=
 =?us-ascii?Q?wP7Ie//DUowVV27GJhg7XVfAjzWsei03iq/2+evoFbyPtKSmAhlaI3tBZSOU?=
 =?us-ascii?Q?x/Zu8MmwYxSWKGN/bbL54mszxe0m6Z33a31H9gTFjD0Ljv/BxXWyYu4KXcJb?=
 =?us-ascii?Q?vtu3aewrjAB4l8kIl/YiLNYPvw6lPNQWSYRs+eVM/XILkVVskVHZjkf3p806?=
 =?us-ascii?Q?phhJK8AKpI7cdURl6ahn0ehcvpKfvMLdxP+SbTAifUMK9IrX7znsHVZuD1f/?=
 =?us-ascii?Q?st1wYEnzx7VCGFcRsIC2XuJsFo8hWhPe46XMZhxzIT7zaNOjr9Iai7PNF7zv?=
 =?us-ascii?Q?+2Ah/8ByhnK541gI4tAlXt6Tn4C3ddik3rfgq6710PK8rKl4URw3O7LG8yXl?=
 =?us-ascii?Q?i0MJ/ZOcfK1wvz52H4Jshs7OK4RxJAE0/tLR8cTyV9hsqLzQTwiV+ai3ANQt?=
 =?us-ascii?Q?Q1Vm4SXzojL0gQywB0FBAJyB8ervBazglYlGDt5uPgAya+2K2uP+Mx3RMk18?=
 =?us-ascii?Q?d7s4qDaeaJMm1KrNc6B5PUvjlEP3i07mE3S+KwPPdedKJMT7/wD1xtsISTj2?=
 =?us-ascii?Q?LoawawzFPerzKs8CDrNnK/IfLxQjisB36j9u7eoa67XFm4eyh54ZpLun8xRq?=
 =?us-ascii?Q?S4doLkuVFlUaEx1T4xdfTQ4MaMZcwHtjg4vpPzK5nG8JQ71bvCv8mMjW2fWu?=
 =?us-ascii?Q?U4rhuc1Q+j/lioyxhidiggHVTCFZ7mMVzihpA/SCAnJ4/Nz87P8ZF4ilT5NS?=
 =?us-ascii?Q?ww+tBwEEYJQ0f5jHgrAjIiUHqqbWw2Fi2K92najb1Wzi04HxcofcS42uov87?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e1fab8-7d47-49ab-9548-08dccce0cd6a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 12:55:08.2280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2DadN1S80Hm9hp8V8d2odlUDjMW3WVVGu7lFkMg+zsSQZUWGx+ttR5f0O1FFdq8BPaHS5jmc6qrxk++vq9IoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9361

On Wed, Sep 04, 2024 at 11:51:41AM +0100, Martyn Welch wrote:
> The enetc driver uses ifdefs when checking whether
> CONFIG_FSL_ENETC_PTP_CLOCK is enabled in a number of places. This works
> if the driver is compiled in but fails if the driver is available as a
> kernel module. Replace the instances of ifdef with use of the IS_ENABLED
> macro, that will evaluate as true when this feature is built as a kernel
> module and follows the kernel's coding style.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

