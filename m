Return-Path: <netdev+bounces-212969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E89AB22ADD
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927671888087
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 14:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B492EBB99;
	Tue, 12 Aug 2025 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fSjeyxg2"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013011.outbound.protection.outlook.com [52.101.72.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DAF2D0278;
	Tue, 12 Aug 2025 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009522; cv=fail; b=oTH51z/2YNcuwqZ09Xek934qRTM0pYdk6jExffhKnoPgcmJRjdPMqLYt++sjgnsx0n6ks2Ye4s0HuXaeqmO8DjDh9dWiUy1kqKs7MxKMZD64JARXTuuq1R0UzdSPeYbmJ/Ls/krhIt1RW4sbXpPCmJ6LlltJAPdZZ2DhN1L+/uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009522; c=relaxed/simple;
	bh=+zFikMzQEtigNUTgaAvjj3UAeZEWh0Qx03ZTW0BeXDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j9lCMqx9sJf5YIBBA/9zMJ8T6qzvBCsy3Hud/uU59wlE9o6llZwv4ckhj4o+AKDhxDaW2Gb0pjZAIfkgog6bDUKNK40DGFOqjZz20CGx+ZQPF6Wevy87Um8K8aSO+A8c3KSwszBqXmruAwx+c6XjfgUNkvb16wHqVllAcyTOLm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fSjeyxg2; arc=fail smtp.client-ip=52.101.72.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpDpsvc6719dCHhhW4kQNJdguReHhEfma86ncEgOCOx8noFeFhwMnZu2C18f1zBZ98zklR3dHjBOpQH9y7muS/CmiaRRuLoFdHBEbKHTpkveHt7gqg9Eu1mIVy0HQXINp8aJ516U1oHpsQf3zP1211uXrjClSY6NqeeyhKanuSH/WJkp4MKzoICF2IZYg0qjLJJJpgoybGNDuxE04MTM3/ENTsSR6knw7wqNE9H6bJvRyFDHa/jieJk2br1nG+pbiVgk0KUjGiLIgMPDbvMi015NZJM+dHt/ZTIUsVtYCJS4qWEdNl8p8lVkQPa+L4dxKi9AlmA44ciz+yQaAOmdqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQrb+klTEU5VY6p345sxHNNKpNvxsdpipRwVgX1GERQ=;
 b=ZHBXOaDXdj204IE7UJlIRWz0TCEZnYM104VHJHpEHRRh20gwpWHMUV3mqolDwN0YNTukT8pz/38TMib0ylGL0uBXtF0SOEPBic9iRfKcXOm+ueEK7gjgjBf7lD/HrFdn1xvz2u8LS4mjTpzQ+1lbVh0WXBlwS8MkIV/nLY41nNoXQ8ms2NDbIUv9EQxlyaUawf1k7mIojiGMgNndyhdAZV/MMRmXJus/V+WEZ8Jn3Xmxnf2Amb+JDdMLCfmQP2LpFnBiOMjftSrs2P7sBvUxjlVOqkgfDq/F/VbM81JSykVqLco7HBN/UpWc2t6cbAmtveUeiQGwOP5yO1iN9cpdOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQrb+klTEU5VY6p345sxHNNKpNvxsdpipRwVgX1GERQ=;
 b=fSjeyxg22ZZjiEIyL5ZrBTjXBIiIGhcBpjtPlDozyArkzx5sIIKHIJpUVEY4NuMimzWeQ9qujOXeVDt2n4C9XFVry3X3TwrbaY664InifB/KxZMSrHeb0ObL5a6MKIoey/rjfufqY0XH/XgXY6/d1PqRkjI8MUnutzB6rOv7YwvjC+wSG/X0dCSZL+Hw7KwzbSvKyLvZBOOhcW+wMZAIOwuqVlTzE0OeAaeX1EgNLSpduQZLz6WHmRAa/YtKiqcNEtUjEy1MPeqPuYDIYaTMTV0W6peBMY0T+cmaOOD2t8MkpltBe+thmUO41Z1+Xvsub+7aHR4BTPakE+7fHOORDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 14:38:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.011; Tue, 12 Aug 2025
 14:38:37 +0000
Date: Tue, 12 Aug 2025 10:38:26 -0400
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
Subject: Re: [PATCH v3 net-next 03/15] dt-bindings: net: add an example for
 ENETC v4
Message-ID: <aJtR4j9+w5fVsJL4@lizhi-Precision-Tower-5810>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-4-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812094634.489901-4-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0127.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: a67f1205-6e1c-454d-0705-08ddd9adec50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?USSR/Ah/MH1eoIu0NA+bz4nF50oWMSmX1bgRMMSAEpQkWwFEB0yLdles1aLz?=
 =?us-ascii?Q?b9b4VFs9sZ10FqEccCube368LOBFueBFyUenoY/ITDEeyEZxqBh8/d0vIsxP?=
 =?us-ascii?Q?izQuhwZIJ3EBG9oQL/5zKl3trPu3Vq7mrimrD/E0gKSPU8SWP4jq+RSEsfc1?=
 =?us-ascii?Q?Ke+sdnBJDb9rSBTRPSzwnKacLmCaeRztAzes1lFLJ4wI5EAbvz9FNF8IzPXe?=
 =?us-ascii?Q?3uXmUJKR6OsMD3PkY9WMLgWT6VTIUiv1LXRqFpuzbRZsekKknfKVogzv2YhV?=
 =?us-ascii?Q?C0dYnE8SPYriidlDmnhC/o37wYxly+i5P5dj5ps0rjb1qBvrsimjbksneaen?=
 =?us-ascii?Q?yF4igVVLdJ3OVIEZGY8A/RLBdIeqPKDih6nmuOkz1F/mI24jp3MxDIeqVN0J?=
 =?us-ascii?Q?7Fl57kBZEtY4KL5aSRk7oRAA92u6fMwawGZrOXmjTZ13PF0JnTZW+1qDdtqa?=
 =?us-ascii?Q?BdqZOF0YAlJbJXANcS1SUxqZ0nFYfbfEo9A+kTI+owNaGL/IczLyFPO7hcuq?=
 =?us-ascii?Q?iqu3ev1o3O+Zua5mtUyJAvhDtqgbMa2D1nP+vwIWv6yKMRN4+i0Aku22l/Up?=
 =?us-ascii?Q?tBreTnyIbZFl/Eh9PFFBT2Wwy0SHtEiPA0goRRgYTnmmUf8IKjkSdc9VMK4M?=
 =?us-ascii?Q?vjvDx9vOHPdsm9GVoviSxMTFnMvyoXY0r49WIlzp31ZsnyWW52QLjOhLw/XY?=
 =?us-ascii?Q?37QBDQb4HKPpP1X4YZjoXiZdnOhLQi7aHrGN/4kvZwQn1L/wf1SPBE8FKEny?=
 =?us-ascii?Q?TeFAkECE0LnoWBUd2vIyQUKTUdqCXMwijvBFUD1hkMMvSeMu35CunHIGxAyb?=
 =?us-ascii?Q?RMUKa4tPTCoS7AmRhgc0mJJt3LgoKLPq/ygvbl1nsvEpIaKth14RkY598JU0?=
 =?us-ascii?Q?/Anvkkvp2AIaKbU06un5Pvx7kUDrxGFKjxD8QptLS8YL7xHOzw61UrgcVzNX?=
 =?us-ascii?Q?gdsMJ089+bMwK4gtD/EDukYeha5p+2H6Ez/gs2TLTsNRPKfk2V7Xlk3PBbBp?=
 =?us-ascii?Q?NX2ScYQkPszpx+f8MOyl+7EUVQa0WapbSWYu80C+fAjxTk+zswP0T2PDJh5t?=
 =?us-ascii?Q?iMtOLiGInaBYAxuY7lDe+99+wdHARS7aqDzmAd9CzsjR4o6C8XLAprxiDjng?=
 =?us-ascii?Q?1uSHYgCbaIbAQpBgOYbn/jWozd475+xGIwoDa7J5+lH72hf36YoREK6RY6p7?=
 =?us-ascii?Q?803dHGzQghxi1w+SKJ6A0YaypMCtg3iqcmAyRQoh/tgvRvsdmJkWHZQsB/4K?=
 =?us-ascii?Q?QpRsLbxbF/MJqvzuWPC64pUl4CJiot4AYgzh3SxH86oZ49EJZ02ALYj6sGrx?=
 =?us-ascii?Q?4oIkP9oNvERUrUZAP6EpgBGP9lGLXtAOoVM83ZJ1yDQOA1bwxRZu1eGjXCsp?=
 =?us-ascii?Q?VBG4qbFgFV+OIeiMgicq9UqqHCZWNytMTcRyRsScrBHchl7R7am69ghE7B+D?=
 =?us-ascii?Q?TbS68ssRKUQ0cvNNOu0vGHClUDg9G04eixpyQvdCnE1QU3HH6G3HcQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?unNjtyG/ouCmaT5iIaTFMld6s5IQd7njEhgHbpR7N+B2OYWk2uPhoLJDga9C?=
 =?us-ascii?Q?c2ZcmgtwrDWl5z0/92ydz2x/jqOH9v56xJlfnPRY/rJR9JyaR1JGP7PGJI5B?=
 =?us-ascii?Q?5ce7wd/JhqwWFi8fm2Q8nGILop9RJ7hyFmkAXt/klRokBTKs58TmPqkRfi9i?=
 =?us-ascii?Q?gDhJvszZJf9JT8ZO55YTTXYClELnnm8s11H8UsCWfzkxOQQbTJ44oqDDNf1T?=
 =?us-ascii?Q?KBE42Aaf9ipDP8j9vI/jwm2HQ7vesZLaC59mZ1eWrPjT/d5MAbIOzPLcEBhw?=
 =?us-ascii?Q?IQBTbmliWPrEu2ITBRJ/PzLgKAfkXgc7JVbl4IQPu4IurZqr6rfqkvPB4NJF?=
 =?us-ascii?Q?WLoe1ZY1hao1NxlWaltSUoY+NUs46DwYdwHQ4Ime71107oOpoMTCCY/wQTiZ?=
 =?us-ascii?Q?8yISP7V4PhaRE4j239mFkCEoN7SUuiDPIWYwan5ZRn8CaESCz6Tw64M2eaHg?=
 =?us-ascii?Q?BiYkrkYcgs6XMf9YLc2Z3vz0zlO+i+qE3qmOm7/2xULRnnoFDHh2PxKcU3nO?=
 =?us-ascii?Q?tfV2yht9WBDbVWYtbrLmWGNz62t1+mi3k65JyJ8vuntmVtpO8KmgovM+VxK3?=
 =?us-ascii?Q?cxTtFRVaYjYf2QAbatShq5p0E+OpefFrxE5+AD0b0aGT+VcrSTv1PQp6B/DN?=
 =?us-ascii?Q?rs5BvvbgFXapzDCgAO2rdwx770Ruao5yjCmEFMyTEnX6PKqoI5HFtOWvdyGz?=
 =?us-ascii?Q?gTn85EoUolU2NMeFf+b656RMmvkNm5N0zPLy1VSDKQBSR10ysSyQOVlaLDJ0?=
 =?us-ascii?Q?4NX6xynH1oO/tx3sdyjOyqoAQ3rbh9mhuzlSUK+mZWiTCnAgOljZv3+ifY7T?=
 =?us-ascii?Q?vfy/LAQnYDDxlBfyZFZlqNcP8DxJdGUeCEU3ylyp37nWUXhGnK5euebvHL3G?=
 =?us-ascii?Q?VXwD/YNP5jUOZq+fEcZomB30x4Q5F+9WjKYWXEYWHrEC3cS8VbmyE3BsPxdA?=
 =?us-ascii?Q?mMZVbebe3BFYfctUdkGGoRZ5K5odh1Yc1XnqS6m2XmMeDK5zHh+pp5fX2jbD?=
 =?us-ascii?Q?v49c6wNaA5chyx0sxT3UbGBUHA+2tnKDSiIXLtZxfIbu3ZAuwCQK1aksOUkR?=
 =?us-ascii?Q?X5fmO9Hr9vWz3VkfsC9R57g8ocQRc/pczsY0ap91uL8D6GuCEYsmqQAoG1Y2?=
 =?us-ascii?Q?6igiiyk5NTlufBcCygPTR9Obh5WqnjnvZ3TLcpwOCqmhri1DX6sOJITCBlbb?=
 =?us-ascii?Q?HeQ/rREn4qIMXKiZfQuukNgxfAE9U0F2v4nLyiflH/fjavzSKeIW9pgp434Z?=
 =?us-ascii?Q?estik2VCAxu2LPDVL7hiQi9OVv45ooafmCCTIcGVnuBJohYXu3nfGMyzw0eO?=
 =?us-ascii?Q?AjsFSUd5Hh8iOPbkbSWyeYFemJ6mP+UddRLTLZ4X5+/ibh/7MSBe3FkGXQLG?=
 =?us-ascii?Q?Kr8FLAn/POadoaz0k0k2EJUyJThZGNkuDc3mSQ3tonxj1yE60uSbzDbdq/IW?=
 =?us-ascii?Q?d/AfoYmnUQBwfN5/oJ0qmt4a0JkVk/pZSC0COCGEZKHbpItolFbeugWPcAti?=
 =?us-ascii?Q?53arY9Tud8TYenpLbvO5I2EgKOzHQ5M4n/UIunY+iSX2GXc79yl7stK0MJrv?=
 =?us-ascii?Q?QzlGbXWzUycDivWD44w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a67f1205-6e1c-454d-0705-08ddd9adec50
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 14:38:37.5388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1zzADwpRlxLWDthmBarGxG6Ixbx5xoB6xOlGoXU8AsScY4tjZKhtdVTiMkkeIJeE3RVUfi7V9PMgJw4zkIVDVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9436

On Tue, Aug 12, 2025 at 05:46:22PM +0800, Wei Fang wrote:
> Add a DT node example for ENETC v4 device.

Not sure why need add examples here? Any big difference with existed
example?

Frank

>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>
> ---
> v2 changes:
> new patch
> v3 changes:
> 1. Rename the subject
> 2. Remove nxp,netc-timer property and use ptp-timer in the example
> ---
>  .../devicetree/bindings/net/fsl,enetc.yaml        | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> index ca70f0050171..a545b54c9e5d 100644
> --- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> +++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> @@ -86,3 +86,18 @@ examples:
>              };
>          };
>      };
> +  - |
> +    pcie {
> +      #address-cells = <3>;
> +      #size-cells = <2>;
> +
> +      ethernet@0,0 {
> +          compatible = "pci1131,e101";
> +          reg = <0x000000 0 0 0 0>;
> +          clocks = <&scmi_clk 102>;
> +          clock-names = "ref";
> +          phy-handle = <&ethphy0>;
> +          phy-mode = "rgmii-id";
> +          ptp-timer = <&netc_timer>;
> +      };
> +    };
> --
> 2.34.1
>

