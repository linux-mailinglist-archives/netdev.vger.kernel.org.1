Return-Path: <netdev+bounces-177043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 371CCA6D7ED
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 11:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB64718941D1
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 10:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7B5250BF1;
	Mon, 24 Mar 2025 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iJn5OtMQ"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013043.outbound.protection.outlook.com [40.107.162.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD78136988;
	Mon, 24 Mar 2025 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742810467; cv=fail; b=T6/eWU8Zs4FbjuTbBQrG2+4/v/Xu0kE2ILKGHckgRas19o6R/wGSWGFXEYp5aLJALerHasp4fmyeF3piC3d1vp6uH/CzQB1ueghAy3NuruWbJ99mDuAF/mat7+Vu9WrlHJSe1AsVrrRQz+df/7CjZ1g7zFMTKymqLtP/+/sfCLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742810467; c=relaxed/simple;
	bh=xn57cBSlBVLM/hBz5OhdnxgflIvaZVTLf7TdENbhWs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MwBHQTavwJr5gGr3muVGy4IXx7jm+JlWt+P3Oc4cH7uc1ap5y3lhiNLm5kAREn39QK+SaMZ/BfYeOnDp6J5aFmYlRZ0aBzDyo+wz6CQJj1Rx7hwf2CryC22hXb+f6I4JnscG4dbQvfKgYkwBfNouNF1UFdYVm6Dx3qc5eDVMAMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iJn5OtMQ; arc=fail smtp.client-ip=40.107.162.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxjE8oJiI8gJCdB6e3ZcKhZJABLXZOPI3iuKWyZtip8e+JYi9rEJhx31iTHpG3Wi0kzzcMpSFDS+xKynXnqpVC2Y+SdOEFLC57/M/nV1ewuzarjKhGtffMkaV0GAqThkDD1CtzYiCfQYR58/Id35Iho72SrIF0wVPIBxZhH38scePGONj65yXdGNNAU6S6TzpuwhCTL9tTJHz48TNiArpl3Av7h6tTYzFPCkpIyfbvdh4vuGSgq1FnQK3gHf7hlE2jt0wCYImKZiURT4wpG8DbS0mFAjEW95JzuW7FMpDVxBi2LvT+b0v+g3/6xbn8HRbtC/sVpY5pb5v6VdkYOROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ei3LkgSr2eFFZC3g2qCR2DP11+xiQYgJgdWTykZh61Q=;
 b=Iu66HflvRzqhGbgeFiZP6ieWhV5bsm4+EbML5fMv+i13O9X9Ze0r7Xgq9mhs77TgnmIkjYW51ZmRbLD/mAqbkV+0zDziNlCzocFmZmV1YO8f5HnQJ2EYZgYfSSLd23t4vgnLlzibBSZqtCGb14/C/1KQVzNMNZU9Ku4Fubi5l1ToOvAPK1dp5oihWr+u0N2VtEasRYuOV9VvoNiD4U+6PXo1Oy87vyrzI1NyA65FdfOLOV/PlhWKsxw6G1Sbrthnu1VsjKIa98/KWUh+PwtCXGJuxsmFoHPNbf7wmHL372D7jOpNC5vYqKtXDJQaFvgZvSNgExuum44h0pj0OfUzBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ei3LkgSr2eFFZC3g2qCR2DP11+xiQYgJgdWTykZh61Q=;
 b=iJn5OtMQLsVD0uMp9JsMXI0nsxMOYPmbBtr7iGbo90zG7QBMDjbMnZacYY4UXVyxUPFtlJHymwUZR9Fso0p8sYfwxY350WwmUNaQiyQA/otJUGomZWHB7CdIXaKSW6fiZpiEGyA4/N6OdbK70kejS6VzQ6i69Dzrp8kzX6355H0Q98c0ewVRRPaaP4fMLJPxatddz5JgvuqL4XbDBYcGsYPQXAOlX74sCYgf7RNSXyjIGQ74AM0EaGmd7Xfe1LlCEKb26IGcpGqFHlCZ0XaH+l/Tk5zlvVc3n9pdK3s0H9DqEIAZCa1mYYh11lu3eqqVqPi57kfELtmWU27CoXN63w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU0PR04MB9299.eurprd04.prod.outlook.com (2603:10a6:10:356::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 10:00:58 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 10:00:58 +0000
Date: Mon, 24 Mar 2025 12:00:55 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Colin Foster <colin.foster@in-advantage.com>,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
	Felix Blix Everberg <felix.blix@prevas.dk>, netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: net: mscc,vsc7514-switch: allow
 specifying 'phys' for switch ports
Message-ID: <20250324100055.rqx4rle6fdtn7dg2@skbuf>
References: <20250324085506.55916-1-ravi@prevas.dk>
 <20250324085506.55916-3-ravi@prevas.dk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324085506.55916-3-ravi@prevas.dk>
X-ClientProxiedBy: BE1P281CA0204.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:89::13) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU0PR04MB9299:EE_
X-MS-Office365-Filtering-Correlation-Id: 086202cf-ed6f-4527-d334-08dd6abac670
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?S1WguimKRQDjzNq7EvZ8zZeghUffD/o4+ufjrQuPofcDloRTrdhWwPo3zNAR?=
 =?us-ascii?Q?WM2GuAaDMVWrTSCXg4EIYBX0kZ1UkVnoPpTVRADuPKjmQG1B/IqfhK6mFUco?=
 =?us-ascii?Q?UiWOdodOSEaOmJ6Q/YqygGAEDbdECwUNvQ09Sp3mOXmionKSvdqngnlmO0l4?=
 =?us-ascii?Q?7sfFD17/0MN07LTn8CKs2Tv9OsooTRQiXRXQ3+KBxu80BHNG6AcNuBZ1yeI6?=
 =?us-ascii?Q?yTViulemynR1BPdORCCRClD6OvYx7QB9VTdw8Gb6TRgYWZOiQre3L41JOogx?=
 =?us-ascii?Q?epoqYJN8TTP7ciTPzvA3hqf6nCoFeiGTmd94hDkHEqp7tyShzSdZKRx6J0nw?=
 =?us-ascii?Q?Kn6J/y8ytCYDYmvO9m0trFR+28qEujTxXyM2M4N9jtlm7Sg+T4TikxBjNZjx?=
 =?us-ascii?Q?xdno4kBrOYFP8rK/qws9IEJKHZma7HMEXl1pBuZfuICUg64rzs2hVmwpmssA?=
 =?us-ascii?Q?6D/yUKXX5F/fm/05WWCGlSbx1qVkDqhDsXuoRwkRc/d1ahTYP6vWcENK6y0q?=
 =?us-ascii?Q?24gIdY4LEaOSFEcM2CYLoHKypJ/Urq4Q39uS26wKizoe1utva7R157S5Fxl8?=
 =?us-ascii?Q?OF2k89Trpf9gtDmqW16j6nj07zqHgoTmaFjLnQeqW3tQl1P35i9Y2lUSqTBV?=
 =?us-ascii?Q?Zw5betRRj/FIcAcsRDlxb2UR9x4kkdsb0eAZbF5AjnPmSwWD3d4C6R/J6e06?=
 =?us-ascii?Q?6Ey9cN2hdgkAO492Azkmay1cq2pGmGTGXlJmqXePQvxITERQ0yUtsRR0BLI3?=
 =?us-ascii?Q?PvS5+fmznuZCZTMtnyvgbGWJL2U1I6KSJ/f5hwDhmetJ3gHQWNFdgTR5TMf3?=
 =?us-ascii?Q?qKgW1+FXfnmyeqKfkZhyBS/MjilsmTfg3aovi2PcUxyp3DReNEX6SlOqk1Hi?=
 =?us-ascii?Q?VB4dppcCooiu6vH6cdfPEPZh0CIHY3U17Gh6fUf2X+9+4z/bxMlyMwdD5P4d?=
 =?us-ascii?Q?AfeEE6Oj3WLediUrb0cKHNrwVZqoB9wMnKqP5/mF/nBmsxLs//CXNTHPK2ex?=
 =?us-ascii?Q?UvJF7/w4pnCZksex9KLWsgUIPEVVw6JetcJlxDxdLxkWm+uaozi678OBu1Xj?=
 =?us-ascii?Q?a7SpedsH//xGrTKw3ctNuXZ3NXz6sRLY1u6fVD+UZ8C3LwOZ18QDlNcTpHRQ?=
 =?us-ascii?Q?TJQl6/FOl/nNswN0B2RogFrnGIbJtyfH/T4IJdIHp2j6P5ruJmLBjhe9ghAK?=
 =?us-ascii?Q?kGM1SUdt5vJL5FaTMQn5105vwRNxPIpznBBBe30quoq9+N8kmYJwXaaMtxmI?=
 =?us-ascii?Q?8PtvLqCTXbzoaD46/M1n+gq26mppXrOCSbz1D3TAE+fta0xu1cjrIJcOEZ1n?=
 =?us-ascii?Q?8syMGJ/fTKPI+nUPFrSbCd56/2d7FiwAEZ05m8pp1xVoXnFYBQ6E7hjHyG+1?=
 =?us-ascii?Q?thWEscdjOm634VsUJru/CriowoC8?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?JSmxIUHYaB0lbj6Id9ddLSuO2DJ+C4IBEMx6MCkMD9nitQtuO7NxJOaAdTbS?=
 =?us-ascii?Q?tDP2jNtwXEAybwhYnaNLXFeLIaRpC4JhrfaMJvbl/D99G3Pg7yR+2DoYSD8V?=
 =?us-ascii?Q?zL/IAQwTmEsnbrx2UPSiDq39LN4eN81QvTFiogb5G4nvukTkwAw24ImloeuY?=
 =?us-ascii?Q?9iRFgiBv083Mn/HvJ9A4IxuWlnvMnJ8DKUj8nRMI0bJtckxCoqEx0iM2ymna?=
 =?us-ascii?Q?Qjw5/xhbQ82420K4uTPxW3yEFFWuiuh1PsU4y8KMqYJhDvPmdAuMwnqQ7ZT2?=
 =?us-ascii?Q?/wzJEo1kUOVTy3YXtVmVV7LVp6ys00WiccTzKK9hdkv3FW7MI5h+9Rr7+yKZ?=
 =?us-ascii?Q?vfIHOsBtYJlJTXykh8rVTlR0ZeaDhuKy0VqdA3gosTnFgAMS3/SwNd6vepNp?=
 =?us-ascii?Q?P5j2/dESaeFsUfqJwcQoTvqAyK8sHZdz6v6ZJ6YVVuJEGmt2uwRfFwSwk97r?=
 =?us-ascii?Q?udrGwXelIJ7/IC5myhJu0qBoIj7aktyckTsUwo6q4amATNfyV5R0WRohHEuq?=
 =?us-ascii?Q?mtBQdXbw6KqPWNhpzyNcGS6uBREqowAYEeqGeTSSwElByVNJzOEsPzgR6WU/?=
 =?us-ascii?Q?TfROAWFkZQ4aXDAdMNn59+64N7Twh2SuWJsIyKxBjfiQHnpbJnLld1MHaOOZ?=
 =?us-ascii?Q?4zxR8l62Sv0D9GI3lTqj4rAtY2ClYjFv18v4jCFGQZs2pTC+4J2mpid4OzOX?=
 =?us-ascii?Q?h7Sp2Ej1j5ZnEg0tsLAkqBK5kBJp7n+rxIK7jtxD3FNDwwuMTO5HOuxof1yt?=
 =?us-ascii?Q?WEJxrqZMAesWPlzYo3EuDMkELGgLuq4ie/PgCkZLw6VyREa7JApQKCzc5One?=
 =?us-ascii?Q?znuuRrWMXAA8xtwWJDBVWaQb9iU5fnslpoPEZ9EShJ7HkRH2RsedvXHqMxtM?=
 =?us-ascii?Q?nbjupNJnPIpDazOcu69IuFo6LKkve13LX3SLJHEYeWTSromMSKuSrgR4V7mH?=
 =?us-ascii?Q?XPCu6WorL7dTjWFzQtsHnni8fqIIlWDFTwJlCAjeGKbSoi+G04hQUTwLCEGv?=
 =?us-ascii?Q?lnyJZkOF86tJSkkGttGWUlFZAsnV4eyv2kana+nehXORRtXk3yIVAb+hGUAM?=
 =?us-ascii?Q?ZVWA9aS5kd+eo9sKZJtrAsSPbJn9Qo3i7er2h8nPh+Ji1EAkig/knXpxSvAv?=
 =?us-ascii?Q?2KNmNt/KdZYZf/AK0O6CPn67KYqXCYaupNcNjtmb/7iXmvb4QyruY1Y61x7Y?=
 =?us-ascii?Q?XYY5NUhzTzY7AMjQuMAZQcPvapItIXJj8M6mM0s/Ee12zx3e/Bn7uv7VSLDP?=
 =?us-ascii?Q?RunoLUPPtFwFxCFFxvu6Bj9Yw2LMrT8MWGi6QOsvvTWyusLQa38CxGkv0tpL?=
 =?us-ascii?Q?NmwmJnNDjOU6s+ini5og8XhuuelNMnW4tjeke+YVq0gVdx3XqmuAw+vBT5SL?=
 =?us-ascii?Q?UKhoylQ/YaABSlZj3WZdtbl77Uar8b0U8n9khEQxN2Rn/LsYuCLifO2JmWqq?=
 =?us-ascii?Q?CrtRSZgMomuegPSvixpTdGt5jYBKsc6Z0n5Ar6z8t1codpG2BU5wUq6aRQJ+?=
 =?us-ascii?Q?YeMWLxkhld+wX9ug6+kK5GuHn4LXj4hu0FyxkHGeZ9D1k8aMcI9eT2xgcq7i?=
 =?us-ascii?Q?OR89KsnV9IhSL/Vx/bNyW6b6cnLov2RZ45dQyU43PeJU4CVUr79DB7j6Pv2m?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086202cf-ed6f-4527-d334-08dd6abac670
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 10:00:58.4193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ni9Cnvo2G2zQK0AixCHPXXls08Tj98m/EIUXov++pEDr9UY0u8bu1/BdxGzIJeT+qIIxZbOaz6gP1PqFqYhzIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9299

On Mon, Mar 24, 2025 at 09:55:06AM +0100, Rasmus Villemoes wrote:
> Ports that use SGMII / QSGMII to interface to external phys (or as
> fixed-link to a cpu mac) need to configure the internal SerDes
> interface appropriately. Allow an optional 'phys' property to describe
> those relationships.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---

Oops... I had thought 'phys' and 'phy-names' would be part of
Documentation/devicetree/bindings/net/ethernet-controller.yaml...

By the way, should you also accept 'phy-names' in the binding?

