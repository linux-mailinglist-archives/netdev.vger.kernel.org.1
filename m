Return-Path: <netdev+bounces-175392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF20A659E5
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 18:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF96519C0CAE
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1E01A0BCD;
	Mon, 17 Mar 2025 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dngOUl7r"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011040.outbound.protection.outlook.com [52.101.70.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF21187876;
	Mon, 17 Mar 2025 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231120; cv=fail; b=Neoqv+nQb693QOyLolQTw/dq7Jfh8Z8pTQ/a29mOURIiJ50GzXslJpdxFL2GWJdBwzG8GzbWAEYlnDy/+SRU9gWkKqodK7AHAbPitZmMlqdHJk0wnnf6VOY8u+/c3G0NbYvFSPXWeDH0886SYYZmNRpJu1QZe+3ho90DKIworkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231120; c=relaxed/simple;
	bh=WrTaYgdBj4ammcs8v2Z2eDvrqrtEAMU4L8qE3hrcQwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UlhNIa4vvXgZvP+6fSetZVSeoeAyth+o1Lx75vOHxMffpxz2Npik406XIx7lC0ct7ZFPDqilJaqjOwJf3eYa0OfEMD9zJhH9m2my8XeTiNhO+FT7gocNQTYg4bNhExC4jiDFFWIHD3Yzx0E9un62wlhwOwN8lHcw90MjfmNg2Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dngOUl7r; arc=fail smtp.client-ip=52.101.70.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFCnGkcKQmpC1JpafBDMmmgnoY9W1eP1ul2jMTOS/hzrQ5TCqCgD069p+rj5Opwb10klGqko0PmWIAanyWZdbf8odui9AxYzXhxhxJyDwEEuLpcLsbBYixOLSRhuRArIvLLZpyFLy9gCtCmfaL4lf+L4HweuGoOmqy6Y9BnNoS3lXZlsJZwwSeyxV6F1Bz7NCJ0GH7irYkVcCI++hvAJuznFl1d7juVbtqlOBIZJJzxWQ24UaszwQ4Ie3vGJzHQ8kOpwq58AVj35Y+lqTI38qFzmcNxgieK9F1vmZRKdICGKpdRb1EMiqEddhaHdFLY882/MAtwPLeblNNYT01c7Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oiZHaycKfefRGUy8dFL2MGzVcybPR9nl4NBZbQbXzE=;
 b=PVW4Q9IbpBqmW1fVkIIhbrdTwWvJ7bT+k6/UCcHlmfw0sG6APYHKfZUFTjA04MOPbW5wWJYbyn/CFY9mzMaO2qFXFsQ+RuxVg8rZn8HIkf8XrgFm//jO1w1RmVatQ7Z/TrIJMn18O1N4wP/tCgYeH0ZAOzqqnbxV9aX9uCKnETO5D+kCTtFPe1qAuhS9XaywAQ6L+6Q0S7+vpa+mf5RNH9JO9rx6KsM+z+3s2929XywKnzgAaP7JwIEhTS4o9OwGv96M7fEDfG659T/hgWY0ap81EDn9T4SWyyOYc4WLX1+aZJYtc28rNwiu76wqTq/DEJ25wnKEV18rUSsROfYVZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oiZHaycKfefRGUy8dFL2MGzVcybPR9nl4NBZbQbXzE=;
 b=dngOUl7rSSFqufU0RsgQDK2AT4B16O1b7683sSWfdXpsVYgKjs+BG3uFDsRFP41/1HNAPswGk73XcK1xeJmUAxHeAUjTcrtH0xOVGMWkaq6HyZQxg7CQhFblKEg4ALbk8rAPRljCIhgJhx7VyGNPXJRRjNV5eDLy5p4HEHhQ2xuvOuuUJixDoK2xjNq+gceKr/lxZWlEQk1tlR1ZkqHJj2tAFRh9CwVhe37WhFfxW3TnHYajJ0emc5uCXn1LH5Q38WzrMxoEGl0sGh4G5UqOCvLPE3N+A5qS/eawk4k+xbGDNnH/xyUs4Iva9P5z0m5HuUEN2LcF9sFCEAMDT9aGJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU0PR04MB9299.eurprd04.prod.outlook.com (2603:10a6:10:356::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 17:05:14 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 17:05:14 +0000
Date: Mon, 17 Mar 2025 19:05:11 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, christophe.leroy@csgroup.eu,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 net-next 10/14] net: enetc: move generic VLAN filter
 interfaces to enetc-core
Message-ID: <20250317170511.u7kfzmqafznovpoy@skbuf>
References: <20250311053830.1516523-1-wei.fang@nxp.com>
 <20250311053830.1516523-1-wei.fang@nxp.com>
 <20250311053830.1516523-11-wei.fang@nxp.com>
 <20250311053830.1516523-11-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311053830.1516523-11-wei.fang@nxp.com>
 <20250311053830.1516523-11-wei.fang@nxp.com>
X-ClientProxiedBy: VI1P194CA0060.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::49) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU0PR04MB9299:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e717907-bb8f-4686-ad59-08dd6575e262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hXmSL2Muno26e5lsQRQESYcA+QKyibOvaPu5ezanWg+NzfFPtdB2CYkr/5Je?=
 =?us-ascii?Q?Z8PD6HOK/Cwf7WZZms5XwAA1H5Q0AO/fFPsamHdHrqhWErNJ5Sp4qMrlaG8i?=
 =?us-ascii?Q?O33l0IJIe+CONlIBYSo9kIBceGfHsNTHc3den4jtvWWOL/tHXFJ9hc84xj8A?=
 =?us-ascii?Q?857jwHPvh/oAaRrnLpk+yprl04IZ277hMlmh+pQyKRn61gCxwU69cbTKXJIr?=
 =?us-ascii?Q?lutj2WM+II4k+VsFztFObSLqxkih00oIuzcfq71ZRHoBBTmwABUNM2w7EjHt?=
 =?us-ascii?Q?uugod1wWLlvZ+55+YjZJHXTB5c7vCyF6nqXZH9TAMRA7kCNqyPmcaKV3voLs?=
 =?us-ascii?Q?dZ7rpIdrMp82pSItAqo0Esod+uVEA3GimKeKLvFjnVQkahly+WoS+xErPKap?=
 =?us-ascii?Q?57t0g+wVYJS/PFPPftS3lFrSTfeSHMqVzm768Rv2rymF/vbiTHp+DTOSQlEu?=
 =?us-ascii?Q?GTVREP9GztTJhLxg/FIv3zCQLAUHIHT44OtztNO/mUJiKy0/ZJtYq+DTmi1u?=
 =?us-ascii?Q?H57bOH7sIlee2GeWqJqIs1ij86f/hcWrvb8s3Q/D8JhWKrwHkDO0mwpGhd16?=
 =?us-ascii?Q?Xzzp9NcPp2ZtuS2nz5sg01WDL6htuX961mIYUIemAL+84uZhPE/DvnZ3lgxL?=
 =?us-ascii?Q?K0FkR238++AHgZ5HdGBdZpwsnpH9XlDwbQFmHKu0BJyXS3DVmE0F5+TWVuVd?=
 =?us-ascii?Q?HG/yvSUOr+wda1qXKLf4gvFzmuR0hVjfFztpl7xhzfQpFXOAbQvJEQ9xPIgS?=
 =?us-ascii?Q?AZfJU8AD9faI+N6IIry6BntWxmAEMIhXWz8dovxqOtAbHvPTXiwYZYbOTs4H?=
 =?us-ascii?Q?ATkrD4+3w6RFL/NOlyF0kzGfGhm7/Ma8GujB+VJ3GM9qfJ748FL3hjQzZBxK?=
 =?us-ascii?Q?MnsPbteJUfMAiR9HgQ5vDVwkCVDjJTorI5uB37HVP574AuRAecjVJh2sDkoI?=
 =?us-ascii?Q?rELCD8AtHsHOgELL9Y2QKmGjCOQ1C/yYz80i/X7fC2v1mw7SHKECeCZUeqpk?=
 =?us-ascii?Q?FQQI5z5BEQj7GsZLmOOUJ1zBrBhyRzA681xOW49Ad7INu3mgjtF58oNTZWPv?=
 =?us-ascii?Q?NB8b2JI29RfWXvoOAQUldMqKsio51WsrMW1RYetEPM8uwmPszLI/v3AYQDJr?=
 =?us-ascii?Q?OCGoxc3vE8a4l2PQb+uMwLfUoynomHB223hBnN1KvbqpboDdlJxePU30taIT?=
 =?us-ascii?Q?fgFw55vkjivT/CAW9DgHiFfGpXRh8qZ18wU5YhZwINnTMbe5P7LNkbORiB+0?=
 =?us-ascii?Q?xk0dp9Ic9qpvsqn+M8uO1WQurZTIQw2BnWMKnJggZlC07dCMoE0xsZh2moGZ?=
 =?us-ascii?Q?pj80y4hpgIC7lvpaCeeOKLVqHhSslPC3rWtiAt3nk1UG5RgoD70kmjQWiIYH?=
 =?us-ascii?Q?VPx8dkIwVIsigu5pIWaaG8w3g3++?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lRKtgAsEnAbfFlJkVzgBwR084bADbWnl2NLve3+RjB+jWQdut1cmDIxHq6LZ?=
 =?us-ascii?Q?HpMJtuahY/APa5SjkgOUWq39Au6Sz0AQovSJx/5Q7y4vLyPhsuBDQy/6SBIo?=
 =?us-ascii?Q?l2Ct5/mMFFBcs7LeJtjTIidjDn9BwVxPamUqnZhGAfOt5o9JWwb2cv31lbGb?=
 =?us-ascii?Q?ePxTuU0Ub8jg/m3btr0/H2jDdpoMeG39CnzioKN2WyFobStOROjZvWw74cF3?=
 =?us-ascii?Q?Mfr6DgDMaNR/qw0PongY9/VrQkmyVoeIKqPDoJUT0NuCaQ5nikSAkXgUzkBs?=
 =?us-ascii?Q?qU3gISn1e2/hQ+eNYQVVknze0b3yWb8UItQT8DkQVH+1WrFZcDPq5+pyE3kx?=
 =?us-ascii?Q?A9LhY0Gspg01YdAbamrIGiUjZWToR1LqPLIkMr57JOFUn80EuajGA9tfHdJR?=
 =?us-ascii?Q?NXJ6ZXffvzRxTmAt0yDvzNB+8chUkXhNj28E6pJKu8zLlUo+Kwdg7yuIAC5t?=
 =?us-ascii?Q?yq6NWlG53Mzs4Hib2/0JYbfV0pPqUyi7qAK7kKqCj1+QfEgO8dsiKEFqvNoW?=
 =?us-ascii?Q?QhmbxVPKZAqehcQ2m9Uq/kV4ZZC/PW8A8PC3EgiObvht71JHqAIGQB6qpeC+?=
 =?us-ascii?Q?Bwi1x4epOf4a5POsniyKA7VV3YdqM0+dR97i1bZbwHvWQm5k8DhpHRdazxcs?=
 =?us-ascii?Q?knEIu9c6yXqJUNJWkaIugSdoQDb5DumeRiHoi5uiQQ31kCldCKmPBPa5wVCJ?=
 =?us-ascii?Q?55HoxYbx4nIP87nnwlNtSCMwFk2x1Kfrlv7Z1HqXmKp/+adqF0xrkiV1KMmJ?=
 =?us-ascii?Q?z48v4z2+oX6cz57wWoG7B01VXYX3HAPFlCeu9ulVpPMBNq7QnrfldQy6jPr1?=
 =?us-ascii?Q?zAQZAGI4DfBTsAJe11dYQ6IOHxOcday0V7gsH6DaWAVqIS6PD5siX9ClIUTi?=
 =?us-ascii?Q?tth2icM0E6nAyazakJR8qug/ki/a31OAC57bx4B9IUI/HNyTPJYvLTKalG8N?=
 =?us-ascii?Q?4ml3VgSnu+wip1MLt4Uf+iYzjBeaYJnIkhSEJ2Y5O/BFang1mUu0nv1s920d?=
 =?us-ascii?Q?WQKh6+XGtbZ2HdNtzQDfgYaEt0AtB2Yv57bkFnKROk2lcMBDfYMMKSjvSnlL?=
 =?us-ascii?Q?FsP16W9EM5ng7eLCqzwOzCkW4YMImRgCGhWawESt+ifLE9PvQk9H7ja4XcQV?=
 =?us-ascii?Q?RaF+DZRT1sbQHmJJX/KqABUUPx7Dv1lgF6+knqv9aNLPueLEe9C1oWcYN+sK?=
 =?us-ascii?Q?7hlvagCeFkD4lzQu1MqKzT2UBlN2zIZ3iN5RRDjr8ITdoxJlcUVYnI1Y+PZM?=
 =?us-ascii?Q?VNgjX7r0hrxG1cyyOu5f+n3uMVnNIh8F3J5UddoX9OKLlJqVcUP00Ulc9MfQ?=
 =?us-ascii?Q?LxXWj38puZqzxBExBMBO4g+WFfvWt07HNm0QN9qwbxuO0zOsL2vK2I5fbrAj?=
 =?us-ascii?Q?v01sb2mX2k1wm5aduzWejxv891CxI1jBzCCcWaT3yNrcUyUbLJ0/8OnmJJFP?=
 =?us-ascii?Q?EiGqlTUAYDrl8zUTJl/G3fmU8tE7cl9QqiGAoZuBPGTnSXt2km+45AsOCki+?=
 =?us-ascii?Q?p8AV/pZUlikzeHfKKhkcM1iZS2tGtoaogGeWTDk5LQUa1ydhSFwot+39vkpT?=
 =?us-ascii?Q?zn8/ifQGrH1fPX0H7xQkrlDqSM4HC4Afg66mOJ4/uQZ9v9by8bp86q6u75fa?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e717907-bb8f-4686-ad59-08dd6575e262
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 17:05:14.1982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZ22zV+CwDdEXsmAi/RStn0jZGoFWxnr46AyuuG0W521VOdznWhSaFA4GH5tQfIWPoJ/7v2Yv5GdVHPxYKAa6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9299

On Tue, Mar 11, 2025 at 01:38:26PM +0800, Wei Fang wrote:
> For ENETC, each SI has a corresponding VLAN hash table. That is to say,
> both PF and VFs can support VLAN filter. However, currently only ENETC v1
> PF driver supports VLAN filter. In order to make i.MX95 ENETC (v4) PF and
> VF drivers also support VLAN filter, some related macros are moved from
> enetc_pf.h to enetc.h, and the related structure variables are moved from
> enetc_pf to enetc_si.
> 
> Besides, enetc_vid_hash_idx() as a generic function is moved to enetc.c.
> Extract enetc_refresh_vlan_ht_filter() from enetc_sync_vlan_ht_filter()
> so that it can be shared by PF and VF drivers. This will make it easier
> to add VLAN filter support for i.MX95 ENETC later.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

In this and the next patch, can you please separate the code movement
from the logical changes? It makes review much more difficult. With the
similar observation that, as in the case of MAC filtering, VSIs don't
yet support VLAN filtering, so the movement of the hash table structures
from per-PF to per-SI is currently premature. So I expect to see that
part removed from the next revision.

