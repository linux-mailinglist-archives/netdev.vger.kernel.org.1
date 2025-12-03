Return-Path: <netdev+bounces-243383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E87C9E8CA
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 10:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1CAC3A8FCA
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 09:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248A22E7F30;
	Wed,  3 Dec 2025 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BkhlFkgr"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010022.outbound.protection.outlook.com [52.101.69.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB4E2E7BB6;
	Wed,  3 Dec 2025 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764754954; cv=fail; b=tbNwCR7df0MvraSAGy6k9OUtzixWwRvaU07aBT97ry5T/2scwMwPBTVCumlusL958ZcjgJG00DKl3BvV5jdz2w55eebv6t99HB/8RcVDuPZRet1ts6cMyF9iFZmF574njwL81Q6Pi1xXwvPmbjIn3eisz/Zrsjdmcrl5tfiGe3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764754954; c=relaxed/simple;
	bh=cw1c5Lt/FaYjfZqwAyFqs6sBxSRPO8YnvqTCofbjmmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p0WpdeNMw/q/iv7RDZT8BGLmg3RK5ZqU1tVxltzfqEWyuzevW0jVK45lMM4ge6cQdcCtbfpWqkGMnKfk++CDDPXDO1yUMlsCEV80utLKtUqfa0Pj1Xt3WvUqGqWWRUjDG6zgXn0zd7PK81x10HseDByMpcUhB7wXdFUk32knmfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BkhlFkgr; arc=fail smtp.client-ip=52.101.69.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1GLbkm0GM4+h6enpwN4e0V6y9Rjh4MmcZKcpI8sOy0mifts61nncZFvec36THhyEMC3nPaZLa6VeVsFFi2nlV4voLp1d9ut7FHrmzSnHiEV9bNOVH5iIYgENjoyILDf7tQUHy/VSYmemLaArzrXP0iqlZHsH/UXDyq8oJPMatXT5B00Q8naHS68zaovZPQ3RRe5kCi4DYOoT9Wa8GzFaxwapVgO5v448N+TV22jBTLkjGil14naWMOOmkjhOSuN8Rs91OxyyVuta1EUkzHJUPrMDrFMMB6LGhm7ZoCY5tuTuY/OUiVMdbBx91bFhT6Fodp1WKpED5JGCBGoo6oa8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTcVy83/hJ8RoK37xp3YSpXcnuAU6IsveIso1UI6Ce4=;
 b=Mx+EVBgITLAA2tqVBHaBCis2EqTDwbIoX7OgkfbSC+EcYyNQE3NJV51krmU/4HHIiQGh7GPEtYpH9rMqAVSsnCzXphCe062e6GCn48rdK0f4UEcZ28ogbNGhxfO8VPLmDhlxd0pl5GAoEx7KS4QOqac1TNzeWt5LK1jO32D2iXt+JSA1monPeL2L2Zc5J3kWq1pmOYta5927Ba0Rdjax/ZHJoXVYpPWXEhFvXK6G5Kpj+jtfOhGTm/KCcl3shW0E31CF5/xXSZEUCBdsLj4zrXnKuRHKp1XEhxhYN3dFI1zOyDidjNEg4P1ebMHyhNvwBMxBMpg8Lnq+ATin43wWaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTcVy83/hJ8RoK37xp3YSpXcnuAU6IsveIso1UI6Ce4=;
 b=BkhlFkgrgezHhSV7AvFqg3QSY/AF+O744JdkOZMofHSB6Z7FK1DX0tbHFrtvUZF5YWaeZYZpbKJQi9vHAzdEtSxcrDN8M/qYRwFaQ+Bz3qdgxSNMvVZ9Hv8od6QEoL1+Gq3bx10Rp4xxaRrwkTj1i1SKfJ55oSy7OmJll2trTGJ9rucBKmO+v/LwAtMnGt4KB5FsQJADLA8KFEeEXhlWeB9bHxfKUStCFJTTyP2VPT8t3jnNVYbT/qEwprs7SZEZR7Vjn7gLArUSNff3cwOx2KbcoqgBBkI6UqKgef08giu+oQsyh5lZ1mv1NfMefjlm55uEkeFcK7x+diSqMo+1pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DUZPR04MB9982.eurprd04.prod.outlook.com (2603:10a6:10:4db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 09:42:28 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 09:42:28 +0000
Date: Wed, 3 Dec 2025 11:42:24 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>,
	Ivan Galkin <ivan.galkin@axis.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Klein <michael@fossekall.de>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org
Subject: Re: [net-next,PATCH 3/3] net: phy: realtek: Add property to enable
 SSC
Message-ID: <20251203094224.jelvaizfq7h6jzke@skbuf>
References: <20251130005843.234656-1-marek.vasut@mailbox.org>
 <20251130005843.234656-3-marek.vasut@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251130005843.234656-3-marek.vasut@mailbox.org>
X-ClientProxiedBy: VIZP296CA0021.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::7) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DUZPR04MB9982:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6ab6c1-f0a3-41ae-c78e-08de32504595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|19092799006|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AIDy0r9T/j8K6ESiNAji5OZZrfhobYiFmsK1CCqaqXs7LCuYddScXIU8pSjR?=
 =?us-ascii?Q?SFj+JxlGjkZKogS30qwXLdy5OBRlvFDBwqTh98cc8Ap9F/IZDXrqOLa7n9Sp?=
 =?us-ascii?Q?lUNvwbnBQbExH+g3mRbjbU5zpB4+Laob40uZclayOdETFCK5NlMYUk0R0p5X?=
 =?us-ascii?Q?IWfN8lJnL2C3SevDRs9xuf900MO1xa5RkOfpPE9sqX/gp1tW3lI7RRGIDfRZ?=
 =?us-ascii?Q?KwnXe/c+TAvXs68FGVFjGTcGi2qrdTjlKii2O5D1cKtCLovRq1gJ7bofoDNo?=
 =?us-ascii?Q?U1TKnO2+PW+nHipg1F8tGOKft7VqOptxzLS8XkiohlnWN0Ynt1T6e1KvbN0I?=
 =?us-ascii?Q?6E4uoEEEwD68Wyvpb/WnzxFZDqzj3lcmxzVz6yCrC8tY512RswAYMFlR0cfK?=
 =?us-ascii?Q?tOgL03haTjY+3Vl2ZPWhm+Kaz8hlg3szo6jAOoyt9Gn5kGW0VJhRZ+Y1LaB8?=
 =?us-ascii?Q?hq/kgj1egF5SnI58DMnpMncvOGs/pM+TY4mrkI3SOeRgdW+sr/GCCYFL8Xjd?=
 =?us-ascii?Q?WGqpA4ErtDVO5QAfQisepxirp+m3tv29OsjBt+QT7MabStCKpPnPql1aMOuU?=
 =?us-ascii?Q?rDWy3fP16wjSOoqNIDvN5Z32bw6vVqRJHp4nZPuyV1wfonUZwazPYCGeHRWV?=
 =?us-ascii?Q?HHgG24e1M87hUohuyBmh44sKUuAY4kj/9inBzzufT6zxbJsqa0O5+tfQVKPe?=
 =?us-ascii?Q?8WYt1OsbDsfYi5l8/5rzlXUBWHw6Xkv02AZ85locujUDXh9IfFwayxVjVHI1?=
 =?us-ascii?Q?9UR8ijKHfFCBH8yiImPC0yfaa2dzj15kpKDYTh+QpOzkj0Pq1gqHdKxqwh5p?=
 =?us-ascii?Q?8v/FH5HEPFVQNwS0hyUSEmjZcFxiB4yRWNozmC5fvylrRBZMmKh2GvZP75Ug?=
 =?us-ascii?Q?55JtcIL5Fzo7t1GWQSNNe8d24iURBWLYIRKit1PSBqxXW/aLCRNkPyk2yRoq?=
 =?us-ascii?Q?TlMtXRazLM3EwE2g+s2MEDhJvu0fAoGuGWEJWkXJloxZyPLxHr/WKABHVJtd?=
 =?us-ascii?Q?KefFPaGrqGCh56Vgtnp6HJlaYCvQBaPX646puFOqus64jmNLjy68EQ3oc96R?=
 =?us-ascii?Q?CJO4M2A3uvlw1j30ELOc2+rmj3orTNNL/Zoe6IeQnrJrJk3TxDj+x5XgdJdp?=
 =?us-ascii?Q?Ha1pskoaiSQugJahusYrvCmoJBL/l1yOaUM2NXuVaXS/f14HXj4ofK1bO93r?=
 =?us-ascii?Q?NvkxEM5CXYjsxadFJhr85LIRUYT7Zy28RUhyLHViitr47r+ftYUc8DowtqBV?=
 =?us-ascii?Q?b4OicMkV5PEXZxwQCQICu/5Xt6bKM8tJaBNxvYXKyr6ekQa06Lc7VcBYM5AJ?=
 =?us-ascii?Q?y+6ZIrdHwCcqDIQjr5blItm5RmnZL/TCUUrjU2zEzto+hH3RATw0JhWcUTEK?=
 =?us-ascii?Q?DPOMC9nJD/Dyo2nskLXrmyC21hr63o1vs+Dcqr6EUD1aDhoHk2PpZlDyT5LP?=
 =?us-ascii?Q?8w3za6IBSV/7//h1tMimXftENTsJZo5+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(19092799006)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4RPs4cN4zI7BCEWS7y61CFUDWH0/RQ8bHvrZKuilo3VpJJOHrPTm90J3ftK4?=
 =?us-ascii?Q?0Bp2ABiQEkLt67lrxgURofRSSQPBxDM9v/IROAsDBc+PIxsjlexa03atrIYx?=
 =?us-ascii?Q?tJ6zm7rBQqZSlpvkCyuts8RXHs/2tQEO5vGGIpAJ60bw+MXv/zGH3XuINUo7?=
 =?us-ascii?Q?fhFhUQdi8UikfToBTGE58WQuqpL8zljTP5f+sceDF43Ay+SpLuQuKVnsZuAk?=
 =?us-ascii?Q?abiQVtMPKODKqD6/vC0MdnarhWzBeNUweMc42ZG5g7Y/pBnGY4qtm5WPhaSY?=
 =?us-ascii?Q?+9DjnsT+iDaO7W+GoWuBkY+M0Gz9YwX4sgSgsD19t81b9BQHwDubId+c9N6X?=
 =?us-ascii?Q?ByDRYM22vgEiNkRcYwLzIotzBaCHhnhFlVfSNw3ETTkboDUs4qHDGH6/IaHh?=
 =?us-ascii?Q?wT3E7HJ0+zmLuLSVyJyremuSt3ppbPvDf8Y1JrA9fEWnOGnwc4y+RNku1CjS?=
 =?us-ascii?Q?BrivTs8Eztb43fJxDM6MR5y+n1EspgazSYJ7Pfay567zuxmCBTu9o3/q8OCV?=
 =?us-ascii?Q?sBWseS6RD9djjF1BFU9IsLJFmtuuJ1ZLXaL4yCMixxzn4T8vu+xvLVt1xVTU?=
 =?us-ascii?Q?2la+XfO6ZVdY9oLsI1JbfCP4UWGIEL/WMUzBijHqBVT5pgCQcJABOuY34iZD?=
 =?us-ascii?Q?G0cJfIelnHVrxjdrUL4EMzbn0IzvByLgEcM8Le/mcVZftg/WKTOGszr7MtI3?=
 =?us-ascii?Q?WLv5vsHKfGxHRgUP052zaw1a3Xtky7HtdHi7MoeFSJA+6JNwhEEdrebkF3Xc?=
 =?us-ascii?Q?dnGD/SC/K0n5kF3u2kzLvkRzoHfZ8DDHia4LVxrldS9EqaouY9QH/XuDDE9p?=
 =?us-ascii?Q?vdSaqN7Bh6tVzLGp5WS5QcRS5P7hWNt3Xm+bOxbHSWM/SJPREHXm0dCEigRR?=
 =?us-ascii?Q?8sv7mhB7XyDsxAkE86uqMiPZgFK3HVypWiipqweZ803E8bP1t3/44d/rr5r1?=
 =?us-ascii?Q?ssBB+f5gJkLwmQM4+VxfZSDMA01brbwA7i67qcybbcE2pRGVTFySL68n7naM?=
 =?us-ascii?Q?5V/sIYnZFxS9O9ZGxYnPavmnybIE8AixGnUZ2dQzON0wJnq8kYHucRzd3CFq?=
 =?us-ascii?Q?/fkCiggsID/+KnOdZYJ8k/LRlnwpUG1JYVUjPrWrUBso2KOghFr/Dk5J+JRC?=
 =?us-ascii?Q?mrnPtgiBFiLg34EDD4aCZzrHSgIX15haX5MMpdJP6dgvjyjUTk/w2e9nYnk6?=
 =?us-ascii?Q?+TlUgWBuW74j8SAKZm8Oo2ofvsh9BLo0vXG6jejFBKdf85xLf4D2NqbEDM8T?=
 =?us-ascii?Q?nL7bPMDkLkd02Pvg1ZFMFcd2wlMTjkPsiIDiZsn8PjUt2pgxZjV51gBfB7Rj?=
 =?us-ascii?Q?gQnsCU6AWmxymN9v2g89DFG+YuU8i+kOUTDvL3w3qOvp8NBU6ZnTI5d1gIaK?=
 =?us-ascii?Q?Sb+MT6JA+xJW5CveFOPtzUsAyiKNkRkvvFDOYvw1h8Ui44WsOFtSxlh/Wafj?=
 =?us-ascii?Q?RfFu/gybRoK1T8ctoiPR0wuosott/CnvP3hRKITC9Waf4qKod3ZAiyISdoUC?=
 =?us-ascii?Q?8ctxoxWO3mlSsKC9W/60ElFlicDHDMNpRfHIdVu8ADFrJMEf6xjtL5TrjgOV?=
 =?us-ascii?Q?3MEuyd59G3v3Jse92CwmAIsjDs6VFsyD3v44YnAP9r5qReA9e5Dq0oHqHxrW?=
 =?us-ascii?Q?PCXwM2fUAvZbG6Pd67yQZ7k5DD8tuM8OYQpPWPyKydNUwSWzKmP93PAvIbPp?=
 =?us-ascii?Q?FhQ7Kw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6ab6c1-f0a3-41ae-c78e-08de32504595
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 09:42:28.1181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFdyhEYSDXGJGmiwMsHHa9n9ViUHUhdzBQbgJgDBr8ybpPKbj5X/BU+6RlU5VIrVTvrpwe8j0UneoobwAmKXYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9982

On Sun, Nov 30, 2025 at 01:58:34AM +0100, Marek Vasut wrote:
> Add support for spread spectrum clocking (SSC) on RTL8211F(D)(I)-CG,
> RTL8211FS(I)(-VS)-CG, RTL8211FG(I)(-VS)-CG PHYs. The implementation
> follows EMI improvement application note Rev. 1.2 for these PHYs.
> 
> The current implementation enables SSC for both RXC and SYSCLK clock
> signals. Introduce new DT property 'realtek,ssc-enable' to enable the
> SSC mode.
> 
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Michael Klein <michael@fossekall.de>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> Cc: devicetree@vger.kernel.org
> Cc: netdev@vger.kernel.org
> ---
>  drivers/net/phy/realtek/realtek_main.c | 47 ++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index 67ecf3d4af2b1..b1b48936d6422 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -74,11 +74,17 @@
> 
>  #define RTL8211F_PHYCR2                                0x19
>  #define RTL8211F_CLKOUT_EN                     BIT(0)
> +#define RTL8211F_SYSCLK_SSC_EN                 BIT(3)
>  #define RTL8211F_PHYCR2_PHY_EEE_ENABLE         BIT(5)
> 
>  #define RTL8211F_INSR_PAGE                     0xa43
>  #define RTL8211F_INSR                          0x1d
> 
> +/* RTL8211F SSC settings */
> +#define RTL8211F_SSC_PAGE                      0xc44
> +#define RTL8211F_SSC_RXC                       0x13
> +#define RTL8211F_SSC_SYSCLK                    0x17
> +
>  /* RTL8211F LED configuration */
>  #define RTL8211F_LEDCR_PAGE                    0xd04
>  #define RTL8211F_LEDCR                         0x10
> @@ -203,6 +209,7 @@ MODULE_LICENSE("GPL");
>  struct rtl821x_priv {
>         bool enable_aldps;
>         bool disable_clk_out;
> +       bool enable_ssc;
>         struct clk *clk;
>         /* rtl8211f */
>         u16 iner;
> @@ -266,6 +273,8 @@ static int rtl821x_probe(struct phy_device *phydev)
>                                                    "realtek,aldps-enable");
>         priv->disable_clk_out = of_property_read_bool(dev->of_node,
>                                                       "realtek,clkout-disable");
> +       priv->enable_ssc = of_property_read_bool(dev->of_node,
> +                                                "realtek,ssc-enable");
> 
>         phydev->priv = priv;
> 
> @@ -700,6 +709,37 @@ static int rtl8211f_config_phy_eee(struct phy_device *phydev)
>                                 RTL8211F_PHYCR2_PHY_EEE_ENABLE, 0);
>  }
> 
> +static int rtl8211f_config_ssc(struct phy_device *phydev)
> +{
> +       struct rtl821x_priv *priv = phydev->priv;
> +       struct device *dev = &phydev->mdio.dev;
> +       int ret;
> +
> +       /* The value is preserved if the device tree property is absent */
> +       if (!priv->enable_ssc)
> +               return 0;
> +
> +       /* RTL8211FVD has no PHYCR2 register */
> +       if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
> +               return 0;

Ivan, do your conversations with Realtek support suggest that the VFD
PHY variant also supports the spread spectrum clock bits configured here
in RTL8211F_PHYCR2?

> +
> +       ret = phy_write_paged(phydev, RTL8211F_SSC_PAGE, RTL8211F_SSC_RXC, 0x5f00);
> +       if (ret < 0) {
> +               dev_err(dev, "RXC SCC configuration failed: %pe\n", ERR_PTR(ret));
> +               return ret;
> +       }

I'm going to show a bit of lack of knowledge, but I'm thinking in the context
of stmmac (user of phylink_config :: mac_requires_rxc), which I don't exactly
know what it requires it for. Does it use the RGMII RXC as a system clock?
If so, I guess intentionally introducing jitter (via the spread spectrum
feature) would be disastrous for it. In that case we should seriously consider
separating the "spread spectrum for CLKOUT" and "spread spectrum for RGMII"
device tree control properties.

> +
> +       ret = phy_write_paged(phydev, RTL8211F_SSC_PAGE, RTL8211F_SSC_SYSCLK, 0x4f00);
> +       if (ret < 0) {
> +               dev_err(dev, "SYSCLK SCC configuration failed: %pe\n", ERR_PTR(ret));
> +               return ret;
> +       }
> +
> +       /* Enable SSC */
> +       return phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR2,
> +                               RTL8211F_SYSCLK_SSC_EN, RTL8211F_SYSCLK_SSC_EN);
> +}
> +
>  static int rtl8211f_config_init(struct phy_device *phydev)
>  {
>         struct device *dev = &phydev->mdio.dev;
> @@ -723,6 +763,13 @@ static int rtl8211f_config_init(struct phy_device *phydev)
>                 return ret;
>         }
> 
> +       ret = rtl8211f_config_ssc(phydev);
> +       if (ret) {
> +               dev_err(dev, "SSC mode configuration failed: %pe\n",
> +                       ERR_PTR(ret));
> +               return ret;
> +       }
> +
>         return rtl8211f_config_phy_eee(phydev);
>  }
> 
> --
> 2.51.0
>

