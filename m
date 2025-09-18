Return-Path: <netdev+bounces-224511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B511B85C42
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C754717BF9E
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944303126BD;
	Thu, 18 Sep 2025 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JmeyWm+E"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2811F9F70
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210438; cv=fail; b=r8JEfoVNLHmGDNSCl5EmLNwChIJONH7SEo2AK0IEJTN65mexij3MV10lSpSpr44AmbTsc3S0ph2vq2SwRHiR2f7q79PXuwZ5ZTD9JBRuw5nQI+1Qmoje42+IGSVvZIOQJgYICmbNQMWPu2SL5d4IypPc3QMgDjcaC3YP2Tz7nD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210438; c=relaxed/simple;
	bh=1X359HIOEe8Q0otvBYCATIkQ55LQLBSLjbxymsN2fP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=usVWGgpm03y3Y/3oBKrnejSr/CeY5EJLwBsXhhIXsV3xeiGOEoFWHri3xFTi9CeboWHVTecYAXUPSRS7U4RxR/aRUdcPrDHr9a0ldFLcAc5VWWBApv/wBKP8iraCmPXO5Czrxa8LqWtHuTIJiSvWgfojbKSWEkBU0um5XLqCiS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JmeyWm+E; arc=fail smtp.client-ip=52.101.53.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2AVr+En0ol3O6IQh3c+FuaGRicn8tWAWkkZ3HdPljNWQhoWuDTTRyRfNJXNy2FzU3p9D11pNp7SVUvSVS8Y8S68IBjeRDSlSL8Dl0IDpPLVZ4UpIhil0XR5NNtz9ciagILOnT8t9X+6Gfej00/osYz6uQ56fo8lfqY03GB+O3EojH8TRdnpBQ5ofip+DN/JXzUydHMavrESth8BS/NIVcmZ6klUvR37fw1SOYQpXzCDTsvmn6rYXLzlOkWgQvxTgeBmV0672lnzP5ngrCoYl2Y/j93/biZ71rwzLtb6aUhnDG8g/bvbasMuJxYPQ2cGUIUG6Jf57Oc+ieuaGorzyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DX+jbKeUWtrM2mGSa4iGjE6Dv2G+w5J/p72B8YWfPDQ=;
 b=bmbffnF453hjSX+Xvfbt++OomBqTeVz7LSFNEwbVi41CVJILxIHRgREpHkiU1qBZ8efiDFxJ400Pc3iFAieCP+WhMe3F5099QGWKrZHqhRCv+3v/fdQeoSqqU7piaUme/rKrZoWcjADdKU9YmWrUbzpYOBxBdmrk3v2i3LdU2Q9HD2L7VaCSp9Z9y+rndeFjoQOpRFVLRFDPPTm4NtGSVLjLD8ROUHEo9M461r1lf67XdcoAX1SyHsGoXznYOshu6C5C82uD/egXZGPrR7DyAtG5LBTyJU1T6kOLJxphB+Xi1b2cp3DNbav6dZVfL6SsmJea5mprGXxh6+kBgbMurg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DX+jbKeUWtrM2mGSa4iGjE6Dv2G+w5J/p72B8YWfPDQ=;
 b=JmeyWm+EA5FMvRAmurqyHJDHvG2MDfVx8513PjSKcHiEuTUvaxBPDC4Pj3i3rR/FKQzFOxi1EaSw31nC126TJE+2e8XxPCINC8hgRO/0QvgQd2ch2X7WmMR4fPNHO4rB6N/Q+CPXNYIOXFICbpGMmn9zYcGI23YWax295KcSg58Q5Nhfuz4sUwlEBnJzZvF1EVvCBXWU4QUXosdVKvQ7pyjVOEByTjaFjeAAJQWLEuQo6uQE2IGq/Gvk7YM+L1yAc+4MfuZzuTSyu+w9yYm9BoszqZ0U6RPbCNEoqv8C/Vb7vGKbJ8y+L77Y6lBKoVk/aK2s5V+lPl3c2lsuHTW1tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS5PPFA3734E4BA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 15:47:10 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%7]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 15:47:10 +0000
Date: Thu, 18 Sep 2025 18:46:55 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	bridge@lists.linux-foundation.org
Subject: Re: [PATCH iproute2-next v3] ip: iplink_bridge: Support
 fdb_local_vlan_0
Message-ID: <aMwpbw5i9x6mhQzc@shredder>
References: <d23fb4f116e5540afbd564e0e3a31d91eae42c60.1758209325.git.petrm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d23fb4f116e5540afbd564e0e3a31d91eae42c60.1758209325.git.petrm@nvidia.com>
X-ClientProxiedBy: GV3P280CA0041.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS5PPFA3734E4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: 97892ac3-5045-4708-9916-08ddf6caa12a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3fnFn93IzC6K1bDJPFEeFERIKaCeh941iuEdhu2XqC8n8y0gmT82reMGaYRy?=
 =?us-ascii?Q?+FxkTSsGaUoIU2DyZl6+JnXssBQ1+F6pXcCjG3amOjTi7bAq6vPS24rt4BPg?=
 =?us-ascii?Q?NyWya2td2EiOo9xO7sHXsh5AUoXzwv5q6pCEXFa29PjnBsp9Z7aHBmjVJZvz?=
 =?us-ascii?Q?Z3E5mxiIMzt760B1rBmh5IYhLeZ8TsM2XRINJ5teKLicBJEVT39GjcWfHbza?=
 =?us-ascii?Q?PE+AtsHTFdSbnMTu0L6vk0bcRL3XpSVYehvV9RW1K10onvMujQSQnAaV7bYC?=
 =?us-ascii?Q?yomw5LVsT/eCLHZ3u/y7Kf9jftbkehEPQ1rNZUA27nha0FAN+mnV+sbxYg/8?=
 =?us-ascii?Q?JUuYxW88ItJuBbZOtfOfOqzif5ajZNGUwOzseD+lhLZ0/OlvYX/Nq5eqK8HU?=
 =?us-ascii?Q?r3u8Sl8qoXWXISy4+ptIi4Db9QVx513cEeZd8IgvPi2BAhP+XHMt9N2pBLP4?=
 =?us-ascii?Q?Sr5MZU6L+CI5ZtONmzUPJVeAFhnV4oO3TnLBO2TPpIsnGH0gaA99+jrEYOz6?=
 =?us-ascii?Q?L/OEOIf85f9X0f/T+G3R6BVZzqKPg9kRro/F08gtzMzfyMxkCz3SAYxdWafo?=
 =?us-ascii?Q?705sSz+/mhto6edEce3ZfJxsjU2MPi23YzKRTc5BZKIzBRcVIgBFv3zgLQnB?=
 =?us-ascii?Q?m4sAkytblxIn1BLPQpd8UaC+vwRi8ibiph45uF0/b4sRRq5JfR0mhzBDCXqZ?=
 =?us-ascii?Q?pDw+d8c5hbN5koPqeFTbaxEdEzQyFNljzfQz5nHLs7yyjzheM7Qh0UltOu5D?=
 =?us-ascii?Q?wB2BIhEbZ2I8o4Gk2mVjaOLyzSeohdKkO7VSfAoXJkIF4BlU/jdtp6cSn3ar?=
 =?us-ascii?Q?Lh/bZQ5WxwlZtq2HiSPyGsoyk4V5zp36evgEDpxcfU+ur0EaYeqGHLDPxwFq?=
 =?us-ascii?Q?BNCbCn7BGEQMs0Iy1QrjoYv9hrudoVEoxDX/yJbKfQKgEgBGv5wlLRYoMV6w?=
 =?us-ascii?Q?PaDP6pek4+T+QD5PK0n6ttydkfwPFec9s4tDRkEVMIri27HB3aj6Mh/0sWr9?=
 =?us-ascii?Q?u2f8zqtxDvI8tCgvvyA3RKkuk0opmOOfyEyGDeO9Quuy439PCKBsAxZVDOGD?=
 =?us-ascii?Q?dr9qBpzH3CXfM2+a0sy6AwM+TFBzNOpZQindovgE72o2OgJ4qNcccSHQcyqW?=
 =?us-ascii?Q?75jCHgswg1sV9dUx34esESe338NTdUpr59b+t1Y+mG+L/BTnITOZm3lxV/Tj?=
 =?us-ascii?Q?kFk4fp3iouiWmwsGO7g2CcTCkiVBFIkCyr4i2MG8sTP71Vg4ANiwGiNWB67f?=
 =?us-ascii?Q?wLu0ZcXfpxWSqQNMNhdm3Zii5aSFTrXtLpUHKzwnmF5UXLXfuuasTQ9z1sF0?=
 =?us-ascii?Q?NTDpAm/I+dt4uPnJrNpdGmSWbXl+goaNe8gHa5Ziw8aUS9+o4tE9kzLCfN6U?=
 =?us-ascii?Q?WLYpPxkYgVugb4VLh6wPeKH8Fkwr+wWFjCCejKiY7VtYcJ6ZguNWkLX/lJaj?=
 =?us-ascii?Q?UiGIGlTdOAk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MwnRTWZhck8431Ily2LQGwf1YRuEOUlukxr3ZZZq11xiiEv+pNDfn9H1nB23?=
 =?us-ascii?Q?cIL8y5GMY6h8s9E3fZklHu4Du9Cv/NqztlnxxEjANeqQpwMbUXhhCqqCPAjK?=
 =?us-ascii?Q?v3JTV7Tn+XsQr5AUQOMFT9W+UvZRxp0rv2VKv82vUVuqfuwujy0hTgm1VtVE?=
 =?us-ascii?Q?2Ggjl+1/lsHWEN+t0jGUNZ/y+9UAy1dy4dpTuuFBl1Gjs+wvcxBDJdJ7ne5s?=
 =?us-ascii?Q?DG0ZLFHPZt53Mmxs2gHxUKefBUwxkdG2SkqlebyNg9adC/TwpH1OaOCcGQAi?=
 =?us-ascii?Q?BrBnDkVx8oAeURg6/J9vJm1MGXm7q3IqtBkhW2riZI67i1lLuAG4HTfsgqpk?=
 =?us-ascii?Q?cPjVWO3aTkTIpXkXhdxGbgempM30GiJOSF9Gnq8SnkZLBAlFOppFoHAzCeKK?=
 =?us-ascii?Q?leV1tHnT5QEW2UoW0OwBemN6RTLMe8YlZ/557398d287UEr65ny9Fi57OewG?=
 =?us-ascii?Q?Td/3xD9qZ87nB/vwHnvnNB+wuCp5YQTov5h5SoOAJ/gDOEuGnDbqLZXFHEW2?=
 =?us-ascii?Q?6fq5+vTMFc5XD6eMylceSCBupR4qphZ+w4BXp99AlvKhnYQM6OoztvKnxOl8?=
 =?us-ascii?Q?ZZ3xIhvRDGmvXaYXTa+6KidsSYhpZDfk6OYyCucvH15oqQTNgDcSiTH9UJka?=
 =?us-ascii?Q?zX8dHqQWO7G97JBC4w/uJKcvAez6iXeh+EkAuVjTTfb857MyKNMN9fWq7Sms?=
 =?us-ascii?Q?hQ1vbKDi8vYymEjRMY9pgh5pZ4xJrLJLjwqcRi6lVva3OtS+pLlA+HbNwsyP?=
 =?us-ascii?Q?tlh+Ik7/ZyBOuLxF4jO4S0CTnbWxLNU0Xr9GqTOOaIrrJzlfmF/j6Tg4yKjT?=
 =?us-ascii?Q?OfDMoZQF+nCS2BIuCSOAPoDvjoB0UioEXGZ0BRmuAAWMVjqO45Ndie+2YYZO?=
 =?us-ascii?Q?MHqK8vaBqTr+sOrmil29b2lON8C59pj1I08cYU4zto8ZyDAdACu4gm/CfLiB?=
 =?us-ascii?Q?PucrVYaoK1TfGhyFZv0r4m98Zwzb2PJRwihrByR+/3Pqy4m6Hwu0VZ52TN6T?=
 =?us-ascii?Q?ClV2SDzdd78IjzSBth8xtOQo8WkvmHDMIfrIr5c4MT6WNj04g7vy2g94KYMh?=
 =?us-ascii?Q?1mwRjiOgZcKLqB3F+li4/WXOSNZ8mnTVZQ3RBdhz7+9ELxud/z51wobXP2ot?=
 =?us-ascii?Q?d+mk6Yf8jBrSzwd/r6QDnjJcUTzBgBjhqkPIzP6s1T2F7pHKFFwBA/kg1TtU?=
 =?us-ascii?Q?WS2RxcuCEpao3f6hc6/g/T1BPe+xTzSK6jht8IQud8aLUANK7g65ZcaO1Bhe?=
 =?us-ascii?Q?BhMNk0KxE/LVR8tb/3AGfs20ZnvHAvINhLcBVghlE+/vESp1aHVNzdaOcziX?=
 =?us-ascii?Q?J5bKWDFlO9Rme40rPX9VkwHOQAxo53c1GSNikH6eX4XrL6WNxGCxtQZe54Gt?=
 =?us-ascii?Q?hMVgpfPIsq8HkzrNRHwMbcPRipVRpz5eXxeoBJyM3vn+hJcrfDsEYyLEKyRy?=
 =?us-ascii?Q?iFeP5EQQ1V4/r0oAP+35GXOYbTUXPUm+A9MKNrDy/ad0lC3ujyLa1eKDlM6F?=
 =?us-ascii?Q?k+HQf3usYK6DktnpHBKTtK5sn7CP/fdLci8BgnxwA1UntRdQJhTdPRFnWs7I?=
 =?us-ascii?Q?tsu422SLWc6hb27luunSF7QN2W0Hgc0q5yttD0EC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97892ac3-5045-4708-9916-08ddf6caa12a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 15:47:10.5315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xI7u+zrpViW5tnYyq6b6KZfxKN92biEW8xYBazvsX45vVl3AYSRolNfP/0RzZYrm9pCwRUHyMz20b/y9Ab+wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA3734E4BA

On Thu, Sep 18, 2025 at 05:39:26PM +0200, Petr Machata wrote:
> Add support for the new bridge option BR_BOOLOPT_FDB_LOCAL_VLAN_0.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

