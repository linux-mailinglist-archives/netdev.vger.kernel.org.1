Return-Path: <netdev+bounces-214985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5785FB2C763
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 16:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAF95E6A09
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 14:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDB327B4EB;
	Tue, 19 Aug 2025 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A0rCJxQq"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013029.outbound.protection.outlook.com [40.107.159.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04DC1FF7D7;
	Tue, 19 Aug 2025 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614744; cv=fail; b=R9CxzkXTY+mmq/nPzex6BBNEXl3kZoc+0a031tK8UAaasNgilBE6Pby1oB8beWMV+HjUf1mQFa0LMk3/xnyTRx7+gsFGFam9D+Yylt+8C+BbM+fafSyPGM8tz41HeTah7BYad4/FMf+UbokdRapj43r15opARoYnsCG0BDmbHk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614744; c=relaxed/simple;
	bh=6hgBJQ1O/l9aH6iu4x+aMRx8uf2Pmx50IdHp2upALl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UsKZCLLS/ZSKf5UPdiUa+vJBjRp1qJKsEtS61yXhLsRYR+RpZoaqaInoi5jSW1mejvp0ghCAS1R65YHfjLf+fmF3ODzqkoUIvkR7D3UR48fl9rcPVOw9AC5qnUqgmgFJi4SRAsdNpmXKi7KOD2wrrfa6QmVfdh1rjsmAad52Ie4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A0rCJxQq; arc=fail smtp.client-ip=40.107.159.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHD5mV7rvE2nuaqs0hZoFaPvC4/1q/FiF1MGeix9ikb9DmC4RJ2iblVcQQOLhGbF8MHxdwQK8l283PDq55g84IlD5OUjbjVVunsyRD+cpPr6cHmLUdiE7hlp+AApvD+4xS88DbkwK++IRBlszhkdOJVWy67rUQCO6V9afRPXANYIVvfJ958LJnp8/J/9EaTfwq6qd5quMA58sGBOoamZ/P5L6JU+EFGj+4Ux3jaoNSGK91tNtNi37MImfy/V4K9OAou2CHddWut+VJ7DupPuVpV87EMLrJ/n1pqUkACVj0CqLjxOHydvkYDtVDObW7QWfBVoIGCaZ+ElRzE5C5r/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErG5qomNHRmXr0XCtdbWeCf7IhIbpSmClDtG8hSPH4Y=;
 b=wWjQHCWMKy87ZV8YNrGE4j7lzzOV3WbO1/Y5pEXmD7xUMtsQt0GY4byAJhE+SKpgWoLXu0/hkw3TCPpQv+XekAwPyM8PJ5emorUCnhWALL30sHJH5jnvSNniqtxvDIz1IYIaeF4WsMAGP5LcRKRQwsehuF/JJTSKkchYdgdqgIYoozHbUpiKJ+qL4z0fSAYp+rGUjwRMd/9cgvz44nRLILSvwEirLaQcbhAkL1N2+o1mISKZ4rGu/E5N89O5L1TJdzuRIGYiW9uauy9fp3dMr3Z0XKVJyVeO0TR+ZyQlanw7C6qRtZjSpuBvQh4gWIJOybzQMa65CKDbgZbH9pebTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErG5qomNHRmXr0XCtdbWeCf7IhIbpSmClDtG8hSPH4Y=;
 b=A0rCJxQqxUjTYaJziuO8lzxsrwpgKAn5uNDYigHuqd7OkMJ3r7KCXuAAi1BDE3nzU3zqQsMv8pFlERoZtNPl7qhl2/nx31/JYyrtTZr12MnoW3UdHsa04+9CRWNYNFGhiisH+Yhdp7mwp8v7YvFhaZvqt7w3aZIOEC846sgwHuG8yknmNu4SvnAPvju4WGwGEG4eEHXngXqXbxWm7tWdMPKWikZU7satuKPLURWPeZLZBTO8OY4JHOfdDw6qVD2WTZKtRpV/LtSIYdY73TUJaXhCkhaQitqLRDZO7OfTMC7wXM1BTeJfFBfbGmISeHUWpHODb1BUXlYLlrOcXPeINQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6896.eurprd04.prod.outlook.com (2603:10a6:803:12e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 14:45:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 14:45:39 +0000
Date: Tue, 19 Aug 2025 10:45:29 -0400
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
Subject: Re: [PATCH v4 net-next 03/15] ptp: add helpers to get the phc_index
 by of_node or dev
Message-ID: <aKSOCbuKcwRkBe82@lizhi-Precision-Tower-5810>
References: <20250819123620.916637-1-wei.fang@nxp.com>
 <20250819123620.916637-4-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819123620.916637-4-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d9ee84-7264-4778-23cf-08dddf2f10de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uu9D1hwOIlGlE0FywX316JcUY6+rW9xEjOqaG1T8IQsq2cH6Wke6joxjbAp1?=
 =?us-ascii?Q?1s6MQ94X7z+wabX89UDvKpciKOvdIWoKM0NNe8kRhrqaHNgxVJ6UfUqFjhOn?=
 =?us-ascii?Q?j+gZ16OCRvD9f1IgUDie1pCgW/B1GXbQywI7dqe3xQGA5RNWq+29lcUae+Lr?=
 =?us-ascii?Q?/9JNPNSnwBrAo1qY10K9T6s7JfZcUPkyihzRkv++PFH3MJPhxNFOYSCZGbDq?=
 =?us-ascii?Q?b1XnaKoiRNTLOk2GG7ImFzhLTILepNte7k8OJFYgRH/h7it8wY05WeXEXjDn?=
 =?us-ascii?Q?tUX9s0xBO/6bwjgl9mwdRo6jZD+owhyjBzEp7YyV5rk1f+WfvFUlXbkjO5h8?=
 =?us-ascii?Q?gqSVjgTOY0zXra6rMTrBcQPIEfYdN7L2+F91z0QyuLY3+s7VHs3hXMqkWkxb?=
 =?us-ascii?Q?ifeBvU3oUyAub9hYVn9leMmubG9RPHGGSkmJW2lztFfv9xAjqH3JKP7W++OG?=
 =?us-ascii?Q?2ql/Is+lDfE8RdbJMe+j9ugJTHi0EdiURy7pmMKIKtuscNOVkDc0XPagCMsA?=
 =?us-ascii?Q?rywI0b3hjqkJUMopudGst6zme+SNXMK+iX1K2ZH+B2xBLyrv8/hXukL30d7+?=
 =?us-ascii?Q?5jLT3SB8phYMELX9ioEdyR0XJCRcyOGH5dgP02kQmg5muGGqoSmDiNQ5iKm9?=
 =?us-ascii?Q?egM7Ivb1uU49Ool4RFjNbHDbkKrCSBM9Z/fxzO6JwnY21cthqc3N1foCZVR/?=
 =?us-ascii?Q?DC1rpnZS1qGN7BH0ybj4TdaC8wymZFZfK9M9cA/v9+axoNncePNJacliQBeX?=
 =?us-ascii?Q?Kpf4T/tIdLnUAzqMwFFz+jTUPuuVTY4pdAH4k5PvrL/lxstXv5hOAVR/igCx?=
 =?us-ascii?Q?8sJJYJK9Z+Ifa7Jn1pLvpqJjhD7VtIqbwUOhBED9vNgUgu2/IJiESq5lTA9f?=
 =?us-ascii?Q?Wlkk5uQ7G4yrBHNYkjxp+lz8x8ezzW9lQGr3/QovABNfgOIPWh7Ry3EUpcYR?=
 =?us-ascii?Q?dmYMn0wzfK7bNIcRC4DpbV+S7QiPYxkDgHTSott5gfpa/GCv+CU2l4vEgMQ0?=
 =?us-ascii?Q?K/TSw2ptCQJ3ztDClfDva2k8iE9ujYv1HCzephxcVswFo/z4V6HMTNP8RrjT?=
 =?us-ascii?Q?G/efwU7+JGI2h6b4CoaJ+i/zd1dDx+uCLHOq+z6yQRM+SwkarR/qIkO9uoNJ?=
 =?us-ascii?Q?powQtYKj5kKeFKoazD7YYykIzBJRRDPaipbwKpmhNcYBQowp45Ie+WhqpM24?=
 =?us-ascii?Q?zzO7BPoK1hEZXlgcZ6ddPa/AQrOoBFbrATu+d+g+bnXqavbGtKArWxZVhl+Q?=
 =?us-ascii?Q?KB6M1NZkA9uzR6/H7725fSph0kVlFbjfhSvztq2BsgD8SM7CrXM+5la+2idv?=
 =?us-ascii?Q?H8M2+CUqh44B+qP+PXliD/34i2iCrlF5VCTa5dt1o9z5g1KuvsDfX0WYI+7W?=
 =?us-ascii?Q?xJ2L1F0AB9EhhR52ANAfT1Ht/M5979l0tfkwTu67UmfY63E4Jgk52gcnaSl9?=
 =?us-ascii?Q?4tuljK5vtPGUPR/ksmQ6/HkiB+VaGpRQHlWtotoJ/XDC4uXlK6yrRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7T5dpFE6QbCFoJVgUwfRXSP2QlkBBYIuRZGSpTxYadjm0xHwBar+4A7bKzbV?=
 =?us-ascii?Q?qkXF9pfPA9fnsfM5gpToereCvNXfVsawgwTDvn0DvCvm1HTsjouASY7yjRXa?=
 =?us-ascii?Q?5+IbWR7UuPIgUJN9T+n0cFyTE70weJDyB3xe+iP3PARiwUc7LLvtEJ4hm9lK?=
 =?us-ascii?Q?xreQ63v4yz3toWwwY3T9EC9+f9U0t2vjwMxJ2drzeHGeqoMHhX7kdffmJLwU?=
 =?us-ascii?Q?Ufav28PaymymcI9l4opJ5k3Ekk/eZRsd5aMY7Dh9mscGORTLMJ6+ZFr6bMKX?=
 =?us-ascii?Q?tmYX293EU0uiIIXnRx7N9xvZnEL3ZrZNaZ3xDUPD4+KAL3mSRaFvCYBP0gHg?=
 =?us-ascii?Q?BB3z8g1jdXrLzXy6Z+/8MKXQYjdRBR0KUDLFutE/a5l/5IPZ2O4XboQrMfRd?=
 =?us-ascii?Q?EtXt2W8q2NcHAU0s7TGFTN+KCbSpb4k9ggXMS9/OucohWM4wyfXBaatSWbH6?=
 =?us-ascii?Q?uuyiAXorTfvXfJVXmrAZtjVG6kxv9Rrti6kutXAMdO8erZvagOT8IRZwc4mF?=
 =?us-ascii?Q?IBKJ/74RNL9ojqacODw65BHreR7ql4lTCsWXt0/7AxuFQ/+rEYMJzlNPQ5M5?=
 =?us-ascii?Q?bWUwZwLFd0QVSFHE+54o3HSF0mr6QPF1RhBlP4f6FCCSk/WM+DseqC5u6ZX8?=
 =?us-ascii?Q?51q/FCvXinaG6Gk5h46GWOeUlYzmsJgr/kwFMGb3LiCYhL1HJgh+N9q7cWy5?=
 =?us-ascii?Q?0xHIxNK0WNyjju0QKBO0325cznpvA/aLkYCe8KF9I1NtCqKzPsSmCeq6dFkK?=
 =?us-ascii?Q?yW6DPQJJ+YFvqrTrKxS+zDh5ceMbf9slkQRnARI1Z+k922uyzO9MS99WO77T?=
 =?us-ascii?Q?AL2sTXkzdobgJmvV1uCjKIa2SM9AY5+MZs5KfQROrg1QfslXuOpJT+TDDX2h?=
 =?us-ascii?Q?etXaalFK12Tqd64+Yjrek3XHJqnh0QZViFNPElwyY4N/EoSk/auQ2w4Lwn1R?=
 =?us-ascii?Q?uMRkJzgY8STKiPlxExiqqjUzlQ59mfsrMZxXLOq2MmD+vpZxu7pNqeyQ2Jnv?=
 =?us-ascii?Q?p4YZfE8n1ktSCSwqiwPyUW2+MuGmN0xkgHn1rp9OjmBur6eUtyW/A6I2eNq7?=
 =?us-ascii?Q?gZopP/9KzE8diTVghDaTigW0glhrkvhP9/k20Z/PyBYH2bwxSoasGKFDd6pF?=
 =?us-ascii?Q?j7CkwLBQ8sYripyRctmY0yniQuFAKcdVEnsylRuK5JE8yPoLOZUPdLBKrTv1?=
 =?us-ascii?Q?3f9NbnSF1tXhCVAx7RIGdty+At7vnqiggZnnL1JGtIkztoKxi0pAYW1TLbSz?=
 =?us-ascii?Q?jFRRwY5RpUpAMZL1UozHEJwUoHtFbw8IfBpCAaMPyISKdQKWYIhtI2GNao1u?=
 =?us-ascii?Q?zG0Y28GedWfQ7IT1HeeigwFfSGuPMFPQ3R3XCVteeJyDHO9RkYwtWSfEszqI?=
 =?us-ascii?Q?zsYgT2EM+gIZsQPSQVx3DMvXceyEv7jZt4ELbCg+sK+YjHadmNr8pq+toBPb?=
 =?us-ascii?Q?wTa2I+1pfLRLC6bWEsptuX1lvTYx8y3sOMBkY8K1/iggx/n7+MLB1OUthhk3?=
 =?us-ascii?Q?EFQ+2gySxhihD1opo1aIcMzlzQBalhEgMH09C1ub83lBUur34qGhsA3mrevo?=
 =?us-ascii?Q?E1zppfrAdRZtJiArM1gBE2XYDPjMPCNCM44G9gbl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d9ee84-7264-4778-23cf-08dddf2f10de
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 14:45:39.7214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SeKoURgesONv0LP5naynDczA3hWjYbkX0uSZYi7X+DJne6L6/eRAa5/8UhqKiY5H98OhaQyHXNayrJsWCWODuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6896

On Tue, Aug 19, 2025 at 08:36:08PM +0800, Wei Fang wrote:
> Some Ethernet controllers do not have an integrated PTP timer function.
> Instead, the PTP timer is a separated device and provides PTP hardware
> clock to the Ethernet controller to use. Therefore, the Ethernet
> controller driver needs to obtain the PTP clock's phc_index in its
> ethtool_ops::get_ts_info(). Currently, most drivers implement this in
> the following ways.
>
> 1. The PTP device driver adds a custom API and exports it to the Ethernet
> controller driver.
> 2. The PTP device driver adds private data to its device structure. So
> the private data structure needs to be exposed to the Ethernet controller
> driver.
>
> When registering the ptp clock, ptp_clock_register() always saves the
> ptp_clock pointer to the private data of ptp_clock::dev. Therefore, as
> long as ptp_clock::dev is obtained, the phc_index can be obtained. So
> the following generic APIs can be added to the ptp driver to obtain the
> phc_index.
>
> 1. ptp_clock_index_by_dev(): Obtain the phc_index by the device pointer
> of the PTP device.
> 2.ptp_clock_index_by_of_node(): Obtain the phc_index by the of_node
> pointer of the PTP device.
>
> Also, we can add another API like ptp_clock_index_by_fwnode() to get the
> phc_index by fwnode of PTP device. However, this API is not used in this
> patch set, so it is better to add it when needed.

Needn't this paragraph.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>
> ---
> v4 changes:
> New patch
> ---
>  drivers/ptp/ptp_clock.c          | 53 ++++++++++++++++++++++++++++++++
>  include/linux/ptp_clock_kernel.h | 22 +++++++++++++
>  2 files changed, 75 insertions(+)
>
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index 1cc06b7cb17e..2b0fd62a17ef 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -11,6 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/posix-clock.h>
>  #include <linux/pps_kernel.h>
> +#include <linux/property.h>
>  #include <linux/slab.h>
>  #include <linux/syscalls.h>
>  #include <linux/uaccess.h>
> @@ -477,6 +478,58 @@ int ptp_clock_index(struct ptp_clock *ptp)
>  }
>  EXPORT_SYMBOL(ptp_clock_index);
>
> +static int ptp_clock_of_node_match(struct device *dev, const void *data)
> +{
> +	const struct device_node *parent_np = data;
> +
> +	return (dev->parent && dev_of_node(dev->parent) == parent_np);
> +}
> +
> +int ptp_clock_index_by_of_node(struct device_node *np)
> +{
> +	struct ptp_clock *ptp;
> +	struct device *dev;
> +	int phc_index;
> +
> +	dev = class_find_device(&ptp_class, NULL, np,
> +				ptp_clock_of_node_match);
> +	if (!dev)
> +		return -1;
> +
> +	ptp = dev_get_drvdata(dev);
> +	phc_index = ptp_clock_index(ptp);
> +	put_device(dev);
> +
> +	return phc_index;
> +}
> +EXPORT_SYMBOL_GPL(ptp_clock_index_by_of_node);
> +
> +static int ptp_clock_dev_match(struct device *dev, const void *data)
> +{
> +	const struct device *parent = data;
> +
> +	return dev->parent == parent;
> +}
> +
> +int ptp_clock_index_by_dev(struct device *parent)
> +{
> +	struct ptp_clock *ptp;
> +	struct device *dev;
> +	int phc_index;
> +
> +	dev = class_find_device(&ptp_class, NULL, parent,
> +				ptp_clock_dev_match);
> +	if (!dev)
> +		return -1;
> +
> +	ptp = dev_get_drvdata(dev);
> +	phc_index = ptp_clock_index(ptp);
> +	put_device(dev);
> +
> +	return phc_index;
> +}
> +EXPORT_SYMBOL_GPL(ptp_clock_index_by_dev);
> +
>  int ptp_find_pin(struct ptp_clock *ptp,
>  		 enum ptp_pin_function func, unsigned int chan)
>  {
> diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
> index 3d089bd4d5e9..7dd7951b23d5 100644
> --- a/include/linux/ptp_clock_kernel.h
> +++ b/include/linux/ptp_clock_kernel.h
> @@ -360,6 +360,24 @@ extern void ptp_clock_event(struct ptp_clock *ptp,
>
>  extern int ptp_clock_index(struct ptp_clock *ptp);
>
> +/**
> + * ptp_clock_index_by_of_node() - obtain the device index of
> + * a PTP clock based on the PTP device of_node
> + *
> + * @np:    The device of_node pointer of the PTP device.
> + * Return: The PHC index on success or -1 on failure.
> + */
> +int ptp_clock_index_by_of_node(struct device_node *np);
> +
> +/**
> + * ptp_clock_index_by_dev() - obtain the device index of
> + * a PTP clock based on the PTP device.
> + *
> + * @parent:    The parent device (PTP device) pointer of the PTP clock.
> + * Return: The PHC index on success or -1 on failure.
> + */
> +int ptp_clock_index_by_dev(struct device *parent);
> +
>  /**
>   * ptp_find_pin() - obtain the pin index of a given auxiliary function
>   *
> @@ -425,6 +443,10 @@ static inline void ptp_clock_event(struct ptp_clock *ptp,
>  { }
>  static inline int ptp_clock_index(struct ptp_clock *ptp)
>  { return -1; }
> +static inline int ptp_clock_index_by_of_node(struct device_node *np)
> +{ return -1; }
> +static inline int ptp_clock_index_by_dev(struct device *parent)
> +{ return -1; }
>  static inline int ptp_find_pin(struct ptp_clock *ptp,
>  			       enum ptp_pin_function func, unsigned int chan)
>  { return -1; }
> --
> 2.34.1
>

