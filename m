Return-Path: <netdev+bounces-99634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 013518D58E4
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 05:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDF62839CC
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 03:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D03678C75;
	Fri, 31 May 2024 03:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="ZYPvVuNZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2131.outbound.protection.outlook.com [40.107.237.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACF778C87
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 03:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717124901; cv=fail; b=HdeTNFBsEescts3nZzESuk2A8YZyl/L4Z1QAd0Ay2MBRA+zcBaUSH0O5L246j/mvCgAm/BDvi7EkOTqJPJseLWrY8e1N0ukSvS0aNa3YUhTX6wlsFQTyeJaHCrgqreiNmgx8WVy+XK1hmqaw8FtF9SO70igmjJl8BP+L+di/5r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717124901; c=relaxed/simple;
	bh=R8Fs3MKoHNKvpOyBahd51ijJ2+whhG0MfZ0m4s2sd0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OHoCrUr6Q9uDWTg37tS8OsEFgkABcl5PiawK1qQL1jk8CUzM6Q1Z6TZrHN3Vs+FgLFYiVd6v/RJQ0ZV4E9Wz6YxRhvEd+SlOr/XFY83ToD+ldWVisCZJ7u4cSyg0p5v5oOOloFToUHJL/nkAAiQWKmSf5MrXcI5w7zWHUdOmaEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=ZYPvVuNZ; arc=fail smtp.client-ip=40.107.237.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kriiWqAHhpPsSieVhaREBdsjcAnvm/psOiIi3pMMuxGDVNJ32u5KMpS/5NHQVwKOjyZwRhumHgE59ytCh3ZcPgVnPLnlEygGMtDOy9MqY1OxWg4kaHAmfLRyrQ7o7eRaQkQld3At//I2L6AKZL3a06PCv7IDa6pJvANtQwTMUVajQHhrbeh0NogxxyrE/PH6PLUakd2eDdWkeUl8Q4lKwLc7VoCyH+46RwM98E3eJ9M27aXiYnkKXl6lF7eASeLndtOV0zKDRMxm1SspB0JUeq1j4T1Wvdsh33SyLifRE2O8ZPnvWDAkMflWR3x1L6dvCJjWpkUmwaBqo5PduOrA/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ar/FL/jlhgIGRWqR4AT4HV9fDo4pp+1mEMSMvzLOtK4=;
 b=novps22nAj3PGPoppoG0WRy3oRs/w9Ogpe0xE8nO04ARb6QKsrfwUiv/D0pFYAVqsrC0CJk05lzpAn8PQkjsQB06iFXFCvdDBv3Pet/2iXgErsgugfz0OObgriEU/VSoB6VVWMlRcj4X43KUntjw00oKQuEJ8f6f8RE1RRdVPNP2WlkVA0t2TXrUyDE5uTe+6cpR+k1BZWXhMD4tHkbiLxAu1JheD01NVM/7CKudLoEH12za0Bg9nYma91cpdr2+MYGoIXfbqRyTmq/tPjA4DnNyR3G8WtGgpJ8yPelFw/150mbQMud7CLtSxCIdBVi1MPLqo8WUum9LPvvVtvwV5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ar/FL/jlhgIGRWqR4AT4HV9fDo4pp+1mEMSMvzLOtK4=;
 b=ZYPvVuNZG1PFvr2IJ6n+NheL4QChE0ZbUWUK3EQH1QNgBB2gOrIzRq1afpVy46KRDJdpY1ngcQoxOOWQMJ+7J4Tm+iMpOJ8c8rBVWIhR6UOzCnXomluxPs/vgQZdDMLny8F3VKgOrafREFL7NMZ3yCBnMGqYWn3fv6LcEJMZolE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by CY8PR10MB6729.namprd10.prod.outlook.com (2603:10b6:930:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 03:08:15 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea%7]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 03:08:14 +0000
Date: Thu, 30 May 2024 22:08:10 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next 0/8] Probing cleanup for the Felix DSA driver
Message-ID: <Zlk/GmpxUq/iOqs4@colin-ia-desktop>
References: <20240530163333.2458884-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530163333.2458884-1-vladimir.oltean@nxp.com>
X-ClientProxiedBy: BL1PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:208:2be::18) To DS0PR10MB6974.namprd10.prod.outlook.com
 (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|CY8PR10MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a31b18-0086-4d90-c942-08dc811ee977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/TZM0EGi/Mb9mv3DvWxn2r6ZLCthiuubejTz6hEVIL23Qp5UpF9laZvN2yt8?=
 =?us-ascii?Q?wKZUTVZ71XdpxlaP6gpIHK7Gg72gyWLlnHkdK3ThLaz1/+s66zsnzBf8RBO4?=
 =?us-ascii?Q?39GvJu+mgTTxGiRChv5ZIjtgavpwFtxneY1MII3sMYaqEB9A/IdwJx4OxPDH?=
 =?us-ascii?Q?bX4yht0/V/bGl7gRVDswWZ9cfrKoMf7bCJ6QtKLDXBpg8nIEvy5Qt8HMG0W5?=
 =?us-ascii?Q?+cGGfSWcaAzshQyWFrSj2lqXiGnCYwk3E7l7KrI4MD2sZiQjvz8f67Mmu6OS?=
 =?us-ascii?Q?fs2eSPvvLAwlCPZNJGN66v1MCRm+p9GoGHBl7ECJdIcyhGGB/wDRHiKegQmn?=
 =?us-ascii?Q?/xTlDkmaFxrb8+e27v9Aw3BjOSXL6E18Agowvj7KaLbMcsuYAfLeXfHe8+aK?=
 =?us-ascii?Q?5C1k9T1tGMJbxrDoglvdfQxMeOapf6E7dWp/vAYhMmXIZUOno0xpwKpaQv2E?=
 =?us-ascii?Q?vBE/qcIiUI52Um4IVi0BJ36/+a7mKYaauIq16ooKin/JFc9eNHOebS/ETxw1?=
 =?us-ascii?Q?Hw/ce+eSJqVbXUq9CoS1r4xc4n63b35tNXMrEmwhqVtITeR6JTbrdL2i93b/?=
 =?us-ascii?Q?0oWuhocSjigIa4m/SlFMgnvaluOEKXxNTojCLu3yM64rB3i0GFEPFejLWD+F?=
 =?us-ascii?Q?XkaS4a5la5MWzgSOSyHKM/UzsjKFokFQMdpk7OpQyGSb9opiftxzEZkbRyTP?=
 =?us-ascii?Q?BRVGO9o8X/EjG1qGllVrDg937Zo2bjpDSkRwi46T61lC7P/6SZLylozOzqcO?=
 =?us-ascii?Q?UtFs+KOoAltLg6mXndpWGhqLAgNAJoaL7nvtr9Ovdg3GtlUfwjgzgi+YegV/?=
 =?us-ascii?Q?VanLpNplIzNP7/UcwIbpiDS5hiWguBzILLNdFccKjXf19l03x11c8UgILtj5?=
 =?us-ascii?Q?4CJ+zdOgsz9PY1eiBsWl+T7EpYbwt9egXduNnph7T3qmB172P1IbOpqBqqoW?=
 =?us-ascii?Q?hAg4x2rAkAwmPVUpfk++BvzA46WR3j1VDx2aMP1d7YcPXJMuBmsyR7PJIdQS?=
 =?us-ascii?Q?/XS0/fCAvkvbv/9Nl27s4euV3uoVYzxSO04GR5yz431K3Jj3W/Y/2HZOxzJu?=
 =?us-ascii?Q?V79Ugu2x2GAhN+sQZA+LJgDHxPwBgamXAW5xAfv6EAopFQWHhM9sp74q1pW1?=
 =?us-ascii?Q?ufE8nsRy+hfSXug5AR6ah1FYhvwOHLJZujFO63ykJA4qaLlMlcXl3heQSLBK?=
 =?us-ascii?Q?xcjd43lXclxOFsLIm3dXwSn3HoWpkquK7wGokgIh+H52dd6cL15aOq4Tv6g?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?siixdlzGCtGVJmrw0t5z0WWzFkneVVmIF5ndpH8GDt7/L8s0J0QJtqKVCYFL?=
 =?us-ascii?Q?1w+d1lC+NGlEUB8VV07yxykLIZH/d6+eEMwtJmQ7oosWCjZVniFQUSS4nTgC?=
 =?us-ascii?Q?LtrTuMdHkjaMc7hR/D2U15408EC6qHc3lMYzNnR9RFlY3ebr1zdDLd627PFH?=
 =?us-ascii?Q?qucENEUDs80MVD+bbsUXDwe4i6s4Y8HsLSgT9DWqB9V8SiQ5S2ljLLJ4Lb5G?=
 =?us-ascii?Q?sJQ/eMjbYwxVZYtZ7WhDvkwrNZ5kV6ErLauNV4I1/r6etM1mgYxadvmnFAa/?=
 =?us-ascii?Q?LOVaHo4AYvT2sY5DjO38r/+h8w4urnbUuEroL3erKo2KwL/bTrDkGHiIeGsC?=
 =?us-ascii?Q?ZBXZfZsERQtzFEitmL6dOKDfb+DS1FMEPexL/7BtkPJiPcQ20jp+lWcdX1xh?=
 =?us-ascii?Q?x+qSxObAyslK2p3FrciyDhzXjoKX3ZglWx7KvTYR5caj19KLKHuXxLQk8cS5?=
 =?us-ascii?Q?FHBsjm//22ifsGn+imzRzMqBUMb/9T4CeX6/gDCfyWIC/QaVovZVkJx5ZIIV?=
 =?us-ascii?Q?UlYK87+Ia2GzChGKeX9S0wVjU0iS/E7Z9bqz1RvlB8sUPs8Rra3zroLMqwXQ?=
 =?us-ascii?Q?oZMsPKOV0ii9/3pU/JDr+Yi3MmU5/9cZqVgYso6jdoJFpInP+MAsQkN9tgrY?=
 =?us-ascii?Q?HJv+6YwRMDTxHBaZyLYQ4d2DAgRbXZHX6zxiINRebmi/Ew6AEJV1xDuAvC0K?=
 =?us-ascii?Q?WkBVBkdq78xm61Q6ucLhX4bDGF0bic4mCWLR5lB2OPgWargB9yknt+zUAQGo?=
 =?us-ascii?Q?5CV6PWXLTwGIJo5yhTzCn9aqOvFmGUSMyf3OB1MViVOtC5fyOv1/XbERgppl?=
 =?us-ascii?Q?DWME7FHHa+ZCq/uUyx8AkKoYZOzb6fyPuOfxNMws95K/Utli4hoeaLKJiLmx?=
 =?us-ascii?Q?9faq67v6BMFDA0artFHiCEwhERKSvL8ghcMYzck094aUZaWQCYPGPPS8ywiL?=
 =?us-ascii?Q?mInnDtfwz7/OWmG/uiniS9yK9AszQ6hY7PdG2CqZevMl+2O2ySeW9aGWRpFL?=
 =?us-ascii?Q?kyY2O+tv6WBG+sc3zA4G3DnCUz/i/mLOLrCveJEtyn2dzk2rOYK3PGFYr248?=
 =?us-ascii?Q?y3FILH9VqXCUISo5w5ZpELgBOdMLNyfOTr+lxlRXc2ASa20S7B5bHNQ4dMTb?=
 =?us-ascii?Q?8dH/nuyeG/FRSh5xSyrMHNaf50DZz+/g1cHliqzzcXsevmysFPATUCsx3S8f?=
 =?us-ascii?Q?I1kUeR9ahu+PUiJw59rv20rejK43jK9qiVbPKc/GXqx7eA6UelPW72BW+hi/?=
 =?us-ascii?Q?YiXroT/fNqlNpjKvFIyzZlC8leu0lk+84AivXKbBYXWu8aHHt+zZ0uvFjjwW?=
 =?us-ascii?Q?XjY9vfyvfVLSW7KWkQTZgJPF+9hC4xlqBQ4nduE9SqUTmEjUj2E3j3AOgmca?=
 =?us-ascii?Q?EwSJpoTXpryEW7Lf7+xqEYNR0HBxKl598y1RA+34jwKSb3bhTTVc04fnSy/9?=
 =?us-ascii?Q?dTTe9Z4wKZ7AUhJr/RVMZfnqH7z53fh5YQwGeWD6Ro3PjwvC44tmRHqSCThx?=
 =?us-ascii?Q?ocSjo70fFNWjvRcOXp7RBmpcPVjKMpImfZX9u+yphXYkK1RKgafkbF0OjJSP?=
 =?us-ascii?Q?iFxtRQaqdKsoXkQhRpk37B8e4CqZZWEaQ4mgRtmKmoTtktX8wbgaGP/aLRyZ?=
 =?us-ascii?Q?BdgA/3WhQmoL6J64QP0UX7I=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a31b18-0086-4d90-c942-08dc811ee977
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 03:08:14.7651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENxACDNT0CBP9OBu6gpwrZK6uXF0gHnUMriS2WTHwn6IEu3HRTWvC7rxhjqRwFvbrqUNd0pTMJ3DEYIfowmCVrQz2+UPwoYsZ7UjXnR6Og4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6729

Hi Vladimir,

On Thu, May 30, 2024 at 07:33:25PM +0300, Vladimir Oltean wrote:
> This is a follow-up to Russell King's request for code consolidation
> among felix_vsc9959, seville_vsc9953 and ocelot_ext, stated here:
> https://lore.kernel.org/all/Zh1GvcOTXqb7CpQt@shell.armlinux.org.uk/
> 
> Details are in individual patches. Testing was done on NXP LS1028A
> (felix_vsc9959).
> 
> Vladimir Oltean (8):
>   net: dsa: ocelot: use devres in ocelot_ext_probe()
>   net: dsa: ocelot: use devres in seville_probe()
>   net: dsa: ocelot: delete open coded status = "disabled" parsing
>   net: dsa: ocelot: consistently use devres in felix_pci_probe()
>   net: dsa: ocelot: move devm_request_threaded_irq() to felix_setup()
>   net: dsa: ocelot: use ds->num_tx_queues = OCELOT_NUM_TC for all models
>   net: dsa: ocelot: common probing code
>   net: dsa: ocelot: unexport felix_phylink_mac_ops and felix_switch_ops
> 
>  drivers/net/dsa/ocelot/felix.c           |  62 ++++++++++++-
>  drivers/net/dsa/ocelot/felix.h           |  10 +-
>  drivers/net/dsa/ocelot/felix_vsc9959.c   | 113 +++++++----------------
>  drivers/net/dsa/ocelot/ocelot_ext.c      |  55 +----------

Just FYI I tried testing this but hit an unrelated regression in 6.10,
and a `git b4` on 6.9.3 has conflicts. So I'm still alive, but probably
won't get to testing this tonight. Looks good though.

Colin Foster

