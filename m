Return-Path: <netdev+bounces-202660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C0FAEE8A7
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 22:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967EB1BC1377
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 20:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49F123497B;
	Mon, 30 Jun 2025 20:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V8NreWXs"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010050.outbound.protection.outlook.com [52.101.69.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FF11F3B97
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 20:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751317007; cv=fail; b=ixwvv0LiJJaIoBaDM5/IqkFTldjkVtSG0MD2P1SSay8MJDIgo25oQO5UdP6Mu9ObVYb+lrbCq19td8PC5ELUR7bKTWYsWYVys2/Nu9EYGd7XnzQMQlAdvEadqWG452McSf9gmVXz1Tygs+hTaz+DNFdDJCGbTzEoclvrM5wTD8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751317007; c=relaxed/simple;
	bh=7yHugjsUFH9SiNPiVLgM8gsPffSPLG2fR34hU4Lb0kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GbG3YzUsDEO4B1nfEkcfXH1/TbL6blkIJBTMpM7hOBDU9ALsT6sXcnS5QnwDdqkUI7EcfsgSKlK08htEjqhksR8hNV0oS9Q4RpYHGObpML8vyWbemqRl+FEveTIGnTIRWUEPWDF/xfh9uXJTqr2l9N0aztV3LtS4HWgmBtWvKhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V8NreWXs; arc=fail smtp.client-ip=52.101.69.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pe357pJfvHmyepStPv5dJm/QkILMWOs62gA/FMm8QVT6LUB+HuUBapWEciuFt3OZourXZrBLwqgRcXenwfRoIxKJmq/2uVuFx3NPSLivUSOZ+B3O/yC6vOiheOZYbETBBeG7ZvlWNCVVuOw16Z1sVT5WLj1DUvyaZVkVZWfpl3D2pUrkZA+09+xZ1A8f+0rYb/EmW4A8rZ/X/Hs4vg9AV0WCXoKAUvq3YxRqD/yQo/ZZ6c/6YbkH6VLjTF9mH4OFx9GqrWC8dNBLpsj0exWoG/fAgsVx7TGdmN1oW9H7LMJqVAr/1ldrc/8JtBVWStKURSjP3QVfV9vyJcH+KchMdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DE8GKubG4DyXTyEr05INcKThMPj46bFstezt/WO7MSA=;
 b=E+2xrzVrOkWRwZYl9O+7kF0G0FMdtfVWAofQO5JVRQVsCabsSyC+LH+zLCJo07iux59w0lT475wfXigo4XYuCRhLeY21EegiVag89h1AWcbSWj0FL/NC0BfpOz2+n4o5OzGTCP4Fu87XI+TNDhpY//5yIhyU1lXn5wqJabIhErk3LfGIFHX98yCecENoS6NWsfvQAz1IU6c42LgB6KFbHnYp+4DtOqijf8vbMIL/boTeKlScE+kOE+4PZGCk46I4STFfECAqameQpe0+WYBCPOudGAxklCoJefJ9sjgUY3bCdx3vjqH01at/A2Rgmx92F+AxNDNI0TAwZ3jn3IkHEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DE8GKubG4DyXTyEr05INcKThMPj46bFstezt/WO7MSA=;
 b=V8NreWXsUkG90xZAchGjXeVqjq/uuqo+0LSFucc/ULICHSXo99B2b1Q0FU+iBLelIrLYBmuPHSanO8gk64EzlIaXy0XLqomDaJyglb6fF8QYWIkf9f4qsevvVjRj3KhqyFik9BaQ0thMvVOcMfo3PZFIZeMmAEpEwJeaYmhQPLWAGjMdgv85EjSS/XjbXbgXeikNJ6hWNmJHzjw3bvMxOAebKZyWhEwKpFaHdIK7sBI6JumJlsgYRXVt6bQvYgTadnk1PnkTXwqkM/zAh7qh8KN97punyLXBo5wZR7wC/cWOrycJodzh0VZ6VXFweKZaM7JgzDEQ/E9olFcES0gAIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GV4PR04MB11379.eurprd04.prod.outlook.com (2603:10a6:150:29b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 20:56:42 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.8880.030; Mon, 30 Jun 2025
 20:56:42 +0000
Date: Mon, 30 Jun 2025 23:56:39 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH iwl-next 4/5] ixgbe: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Message-ID: <20250630205639.ayydzdmh6et2zlyb@skbuf>
References: <20250513101132.328235-1-vladimir.oltean@nxp.com>
 <20250513101132.328235-5-vladimir.oltean@nxp.com>
 <7d330d84-42ab-43aa-94f1-5240b67c49dc@intel.com>
 <a9d50186-bffa-4b3c-9d97-831269a84fbe@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9d50186-bffa-4b3c-9d97-831269a84fbe@intel.com>
X-ClientProxiedBy: VI1PR03CA0045.eurprd03.prod.outlook.com
 (2603:10a6:803:50::16) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GV4PR04MB11379:EE_
X-MS-Office365-Filtering-Correlation-Id: fde16e37-fb73-4b31-8d69-08ddb8189dab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OM8nM7p4ieC3caadkOl5gPkA3FKCVWgxx4C+OmHtQTlrqPfqS4NPQdJ9yKAe?=
 =?us-ascii?Q?ZHihXyADV4DGbFeHqX4g+QQroCmi2+JA5oW7UMk8+vhGiLkl/D7TjgAwLbog?=
 =?us-ascii?Q?T5RJkNpW04HWq8me+mFBp41N8+M/9m8S5WjjoooxzttBvzwJ6zJXrR7imfs6?=
 =?us-ascii?Q?zcHmQ9y66nDr0V1z8T80dJ/bUy3rZI12uPs81RbZP4l8sXa9DKAD0Dl7cH/7?=
 =?us-ascii?Q?porMv/ouJicxU61zxnUXZOWmOG7Hbijr0zFCc+6fylNlVQEpJCZbZNc/dMGE?=
 =?us-ascii?Q?3deWBP55XTVRlfVObXce8YrQgm3YwOtBNmTvslYN59CkrR4kMRpDc9TzwwKo?=
 =?us-ascii?Q?wpSn4FPZ1cGi0pZSqY+HQVQEuIVueAwZ3bgeAonmbW1MbpI9J+sBROc4PHjU?=
 =?us-ascii?Q?7bCSE2WitblD2q4Q6YoM6ZQBYhMmz8PaEhzbl4e9gQJGK45M+wMF3CwfpDbN?=
 =?us-ascii?Q?+q4UDlf/cEgSQf6Jka3mqFdqly4bw/2kV63BhmfunieT8byf6rHP5NVNtuen?=
 =?us-ascii?Q?6swp5S2zo/v/dpP3QHF46TUoNaIVxfE1WsL62fUKjy8je+K9pfyp56NUJZQL?=
 =?us-ascii?Q?nD6osAvW9rNaUHENi5S9cOpEUiUCB9yYiixLAWkEb/yf5zcHKLaSqNllgagg?=
 =?us-ascii?Q?HkKMSA5BgpRAqWCDiwcZMemJK72HiWuAKmQDMsITfDPUvzVdEem2dLYjWGny?=
 =?us-ascii?Q?wbjvlOJN/E6u31r8yg3cIUEwiyVS/1YI2x/fr3Q1tXwyKY9HYxw0Q2Rc7uzI?=
 =?us-ascii?Q?7DgAUVgCaxIxrbvOlm5C6zBevG67H+ozb3F4DErOlyytj9KndzoxLraX1NPe?=
 =?us-ascii?Q?e1G3HBA9pfAF8dksSXzZ4HwKySXYMqIjbhWkxFHZC+kz+uHWuni5UZYe9/OH?=
 =?us-ascii?Q?akzeK0vOVmVOysmRDGWtlj0OyTUP51aAE0WPTfVLdyGfV+bsux5gWq7cx/OS?=
 =?us-ascii?Q?ROduUL76r4/LuGXgu0Si+Z3qczG7zpqnNovho8j9C8U0s6jn4XMlQtJzq+Qc?=
 =?us-ascii?Q?X+MuEZ/LkgiUIJPiUOV0TKt5ki/dcMoqaiOcu4P/p+aQSYUmlkQV1QOCI0Lg?=
 =?us-ascii?Q?qqlrF7gvsWKkbrPEUUK3ulCJ6D+v58Rbn8/tTfU2JTPOYnizPOap8PdmTgfC?=
 =?us-ascii?Q?hc8ua/pgFmsW+YRUc/I8YkX9bMY+n+AMypiZlK3C7RlYDIQ4sCkz2TPKCFag?=
 =?us-ascii?Q?KgDSeu92SknpjlgGmhw7KNnT84XWGTBB6u+7/MXjju5Dw1axoL2FdKdobEzh?=
 =?us-ascii?Q?SXRh1La8pKrqwlTEvV0fPIVCc4hba4BQjz70Vgp4iSS8qDELYiAety4H8+et?=
 =?us-ascii?Q?OfNrlPW6agHeDZaCj43HnTJ/ACP4kDL/xw1ePCSoXyAO2VaW73GxQKKrMsSk?=
 =?us-ascii?Q?tAbP2OtQ4ECdAJAITTSxqJZpW+KU7MG+aE5FAT2CbqL9YQFkOCEDznwbNnIk?=
 =?us-ascii?Q?y7GC5X8Je7M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BrnGlb+RS09Ud5DIDbxute9Fr0oUt0OZZpDsr2erQxKDmq/e9a0cyMbNvlos?=
 =?us-ascii?Q?OFfRvbEUzhTmecQQ6CKE0baKcs0LyEq32SbewY3J1Tt9lIrf9+Q24/inYPA0?=
 =?us-ascii?Q?eY9BaXsN9a0cEq18nddE14Zk+KALQDfxTExyc46kTm5i1+1+wQFofmiySErR?=
 =?us-ascii?Q?vXFM+Aq8lb7XpvDOW9u++WEjh+9+asM2i7xvQwJx2TWCVkGiJvXjsaAFRqlz?=
 =?us-ascii?Q?rXifmZGLYv4WHwlo1ejEEkt0VSkZHpH+URM0QiPnQq6HhYe80kld+JPEtyXN?=
 =?us-ascii?Q?FeGRimBGSj/hDEJ+zBpSRI4Lz0ffbs7nOIqpWo7ZjC51YdIlJmJy+3u0+7L9?=
 =?us-ascii?Q?RWOIe502UHmSN3dZ3CxCFM5tynLPlxzPkdRmzYRfAxZ/GNsJZRpcgzLo1mWs?=
 =?us-ascii?Q?u1sOkWNWpESBUGn90p5U7HGd//IH7jalxFS4ovUtZeQtlXDGxy+vImB0ZjNv?=
 =?us-ascii?Q?peAGoS/gdtZMWK+Wplv3jHbye7/WHX2xSO1FHkbP9HRnwHunOqNv5XlxAMZA?=
 =?us-ascii?Q?V3FGYj562pdGas/b377/ZzAMBwGwfQGom5g0ynSBH2h0QeB6AN0QmcBHJuVY?=
 =?us-ascii?Q?50MQGJpUrvud94AdBlkNc/T2qThB+zfIakWrsStRTexMs9dGvLHAQgqTWitT?=
 =?us-ascii?Q?Av+1IAy99BaL1XgaCBECmDA69N0OuKrGKFBJMP8vZddDQlhUZ/dtjTUUxhRw?=
 =?us-ascii?Q?Bl3oQNSVlwMBR5imB+PT0BVThqYgH80Qsnst8oPquWgbtBTZh/OZJPA9Kp+h?=
 =?us-ascii?Q?eSeAWJeSzToiIlMFWA6QwwWMAzaW/2uNcs0fMCNpFAHmtOm2NZXzOdYZhf47?=
 =?us-ascii?Q?2r5vVeplwy0qrGwL7hR6hsl5SwNl4J63Pax59Cwh3EQuUldkUWPHZVxAxGIW?=
 =?us-ascii?Q?eYh3RjDJfbnSHn/2HSXhiAfG6fT6yc27j+Z07Q7Sc3cOkZR8a2DLdjaQ+WzW?=
 =?us-ascii?Q?Jot7pLGZmbUl5tqz5GxEHOMh6WfEZPSqtL4fyuskrIRpScqx90qE+KhF9N+Q?=
 =?us-ascii?Q?77aQTl8ivcz4gMUt2cyL9Ac26vpEXeu3V0tdxfO17yxWw7oLA1gK011Tcv9J?=
 =?us-ascii?Q?yAndspnmjugEhlmjvioSsxwSY0e7W32eC0orTnDx1dhkRoLLe4mLjZfGP8e/?=
 =?us-ascii?Q?r0Y60hC4b71423D9I6eWX0lYquff4EoN4NkQxOzg29Q/kwPqwjNCCDAeWV8J?=
 =?us-ascii?Q?KaBEnnw/bmmdhu5/tgLwa8VbIQeTG/mCRa4a2FWYnSfgZOvC04VnpO7iiGGs?=
 =?us-ascii?Q?nAPKRyjFCcuFdKnNSrtqNV77sOCgkq4d3GkVLMzsmXyVYAwhNUTTuC1LCJVJ?=
 =?us-ascii?Q?cT0DoVp8FrRSaK1jtqN9ocS3JcvG9aIi/15R36x7aGwsCxpVmS9kiHzIhqkN?=
 =?us-ascii?Q?bQ/47e3TXdMUW3SBrMoqHdo18x+x7lhZpDgqdNWNiMYcKdR0l3xdjLiONjvb?=
 =?us-ascii?Q?k/+ycZAsuQd4iYXv7z5AKOpjKnkWK6ZLK16qqmV1CZ8GWnjPJVDwpI55GdZW?=
 =?us-ascii?Q?sLQmUdKS1ewBF47LjNzR6AUnk5W4dE3ha0X5NreIH+cQzPLKFDRM0PFaZtTz?=
 =?us-ascii?Q?jDSODnNVrMAClAS0c76mLU6ffflz+iWVM/OShhVHqG2YHvZJ1mjXXHXq6zM7?=
 =?us-ascii?Q?Xx+q+ZGH2Fu7+pos9zwzjPuuctFj8at4/uO00JjbLObMRNgDjhAjISr4U+0+?=
 =?us-ascii?Q?cx9ZnQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde16e37-fb73-4b31-8d69-08ddb8189dab
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 20:56:42.1662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OiPTkq0jWY3BujekFg1EvwM9LJQvna1Bn4oOutVrN6MTEn8OTTIpJve5Zb5O8XFnhT1SEP4ByNxuMFS9qyB3Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11379

On Mon, Jun 30, 2025 at 01:47:07PM -0700, Jacob Keller wrote:
> On 6/30/2025 11:56 AM, Jacob Keller wrote:
> > On 5/13/2025 3:11 AM, Vladimir Oltean wrote:
> >> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> >> NDOs for configuring hardware timestamping") from kernel v6.6.
> >>
> >> It is time to convert the Intel ixgbe driver to the new API, so that
> >> timestamping configuration can be removed from the ndo_eth_ioctl() path
> >> completely.
> >>
> >> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> >> ---
> > 
> > Ugh. Apologies for the late reply here, but this took for ever to track
> > down what was wrong in our testing.
> > 
> > The ixgbe patch has a somewhat subtle bug which lead to failed timestamp
> > configuration and likely other forms of memory corruption.
> > 
> >>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  9 ++--
> >>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  6 +--
> >>  drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c  | 42 +++++++++----------
> >>  3 files changed, 29 insertions(+), 28 deletions(-)
> >>
> > 
> >>  
> >>  /**
> >> - * ixgbe_ptp_get_ts_config - get current hardware timestamping configuration
> >> - * @adapter: pointer to adapter structure
> >> - * @ifr: ioctl data
> >> + * ixgbe_ptp_hwtstamp_get - get current hardware timestamping configuration
> >> + * @netdev: pointer to net device structure
> >> + * @config: timestamping configuration structure
> >>   *
> >>   * This function returns the current timestamping settings. Rather than
> >>   * attempt to deconstruct registers to fill in the values, simply keep a copy
> >>   * of the old settings around, and return a copy when requested.
> >>   */
> >> -int ixgbe_ptp_get_ts_config(struct ixgbe_adapter *adapter, struct ifreq *ifr)
> >> +int ixgbe_ptp_hwtstamp_get(struct net_device *netdev,
> >> +			   struct kernel_hwtstamp_config *config)
> >>  {
> >> -	struct hwtstamp_config *config = &adapter->tstamp_config;
> >> +	struct ixgbe_adapter *adapter = netdev_priv(netdev);
> >>  
> > 
> > ixgbe doesn't directly assign the adapter to netdev_priv and this needs
> > to be ixgbe_from_netdev, since there is a wrapper ixgbe_netdev_priv
> > structure. I didn't dig into why, but both get and set are wrong here,
> > and are misinterpreting the ixgbe_netdev_priv structure as
> > ixgbe_adapter, which is obviously wrong.
> > 
> > See its definition quoted here:
> >> static inline struct ixgbe_adapter *ixgbe_from_netdev(struct net_device *netdev)
> >> {
> >>         struct ixgbe_netdevice_priv *priv = netdev_priv(netdev);
> >>
> >>         return priv->adapter;
> >> }
> >>
> > 
> > Whats odd is that the netdev priv structure is just a wrapper around a
> > pointer to the adapter:
> > 
> >> struct ixgbe_netdevice_priv {
> >>         struct ixgbe_adapter *adapter;
> >> };
> > 
> > 
> >> -	return copy_to_user(ifr->ifr_data, config,
> >> -			    sizeof(*config)) ? -EFAULT : 0;
> >> +	*config = adapter->tstamp_config;
> >> +
> >> +	return 0;
> >>  }
> > 
> > Because we're completely pointing to the wrong memory, this overwrites
> > who knows what since the ixgbe_netdev_priv is just the pointer address.
> > 
> This is an artifact of the work to refactor ixgbe to support devlink:
> 
> Both netdev and devlink want a private structure allocated as a flexible
> array member of their parent structure. They cannot both directly be
> ice_adapter, so we chose to have devlink be ice_adapter, and netdev gets
> the wrapper structure. I suspect the patches you wrote were based on a
> tree before this refactor, and/or you just did not spot the refactor
> happened.
> 
> a0285236ab93 ("ixgbe: add initial devlink support") is where the change
> took place, which merged relatively recently.
> 
> @Tony, I think this is a pretty trivial fixup on your tree if you want
> to handle it instead of forcing Vladimir to make a v2?
> 
> its really just switching netdev_priv to ixgbe_from_netdev in these two
> functions.

Ugh :-/ sorry for the trouble, and thanks for doing the hard work of
characterizing this.

Indeed, my first conversion of ixgbe was in August 2023, as this commit
can attest:
https://github.com/vladimiroltean/linux/commit/0351ebf1eee3381ccfba9d31a924d1dd887a316f

At that time, Przemyslaw's commit fd5ef5203ce6 ("ixgbe: wrap
netdev_priv() usage") didn't exist, and "struct ixgbe_adapter *adapter =
netdev_priv(netdev);" was the de facto idiom in the driver, which I then
replicated two more times, in the new ixgbe_ptp_hwtstamp_set() and
ixgbe_ptp_hwtstamp_get() functions. Not only did I not notice that this
change took place, but it also compiled just fine, making me completely
unsuspecting...

Tony, let me know how you would like to proceed.

