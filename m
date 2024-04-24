Return-Path: <netdev+bounces-91003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3F78B0E1D
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 17:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD9F1C2559B
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BFC15F3F7;
	Wed, 24 Apr 2024 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="to1QzR1R"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F064D15F406
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972449; cv=fail; b=BLi8tzz7h3ey3ZpIBXJcz2+R0TJDj8x0cmi8A/qlrCcWou/MYDIUOf57JpCY1Dld2E5zeXJksIcN522TU50iNu4nfiqIXXlh+HoM7Djz6nrO9On6FjJH8cgeRnAbLrJKLapyKEu4Hl9Xx9QzvPM4Z3S/13RNNkqJdkF8GS1VbgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972449; c=relaxed/simple;
	bh=n4JZ0d69b9j1OkfWn2oOafZ8viKtajLVGA+wDF2aj2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VMgX4DcFGbSPxxYee7kKVBbfO9H/TW9tdVNH7YXQm/RGo1vmY2qTrBYQK2X02A7r8eZkQ5uf/4kqEozww3h/o/Iw26pPFjQE5HADzoZiXIzEdpyx/GjS1lZprBgxcPUrsyTi9VtcvroYdOiHn/8rAvMJGiuAeA9ChQzJe+xkrnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=to1QzR1R; arc=fail smtp.client-ip=40.107.95.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arM/TRZX/2lTEnUe9cXhtl9HxmEkyKsm0nxL5aDIbZO5fvKtnp1Za4SF5BXTR/FgyYHMl3oliuFW73r88FUZREsg2wb9FsJX3D5qdOtH4K28vd4piGBEKAIZ+2dyW8tCe8c3SFTt5QBNMgb3eiydNJdm9Yur8RMsIkDBQ59YAGm37svUIwXjxMVjXjEeoBEYlSqwTz61TbQE2h7ZRmlrmW0NVIBVB2OLpWZLqOYeOgQZwwZGkemBM1IZOoCtrGT2zw4bC9+S62KIIbd/fwMNfc+O9/ipJSoEk+f/mtBHlSylH6sHemakF7lEmLyxSwGrNrqO/F/+hgBCuzS9Nfjb2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vh00bZ6UCGDa3LJzMl2zEeKJJ4AargU5o3eVY/CYpTE=;
 b=doERS8zZTa5GcQXIxKKYbzL0mZtZRfuUq1zCJu8uUc81ySGei+ZPb+cPP1N6eW8vrOt6fVPG4QOxpsS1F8iUNHb/N6GjeE0NUYhQ4gNJRh6MaQjg/x4FsYD6r08DDr0gk8TV+Z5Jt+e52DlaDXfJeL3JMlYina9x80iRoekP7McC3HIHkwcSDoRAsvT9virrd9hD7DYwpr6crN/Wi7a67msKQ+99SBKlzugomdJGWD9zctOttwfACNFWjvR3yoE3ayqLB/uf8aUKS+Hdy+mzM/elSNY7Kh9vKY5C0XKFMNkwz4VRSs6nwn+S/+LjRp1KC5dja9T8HRGiV+64uZvN1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vh00bZ6UCGDa3LJzMl2zEeKJJ4AargU5o3eVY/CYpTE=;
 b=to1QzR1Rr9TopA3E7O8RlPCMiUNncgX5C7HEc/M5j6PH3jfBLoAeChlI8vrNuJZpA0wyw4TsH3yY/pvWwLSBQ+oJ/HMb2KBFr3GdFdGevAfNFDHAH/2GEwEkFQepo9OC1hiSqLaIM3aO/PPbweTraj90tpSFiLLNIXqy4nfyb5qo3oW0IpcLwTUp5Abkop489jlLq890w2YmE8nlOKvpjaHcjy4XFGsHqTnfMxTnTdJriRczLN1R4r/l+5OwHFrw3+kIBokHZrGCxsw7yW6B+h8T3aWzaLWItNIxgvTLWagknj7U9lcqE42eHMBgOmTElXmT1RW240fQB/HxGHM/ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DM4PR12MB6086.namprd12.prod.outlook.com (2603:10b6:8:b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Wed, 24 Apr
 2024 15:27:25 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::35b1:d84c:f3ea:c25e]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::35b1:d84c:f3ea:c25e%3]) with mapi id 15.20.7519.023; Wed, 24 Apr 2024
 15:27:25 +0000
Date: Wed, 24 Apr 2024 11:27:22 -0400
From: Benjamin Poirier <bpoirier@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v6 2/5] selftests: forwarding: add ability to
 assemble NETIFS array by driver name
Message-ID: <Zikk2uK4suJD7dKa@f4>
References: <20240424104049.3935572-1-jiri@resnulli.us>
 <20240424104049.3935572-3-jiri@resnulli.us>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424104049.3935572-3-jiri@resnulli.us>
X-ClientProxiedBy: YQBPR0101CA0276.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::30) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|DM4PR12MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: 54754178-5d50-4b26-f07e-08dc64730b02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LOxlH23xXCytfWWZLswP3r9b8prUusSkhqYw2ypTyNWB4/lw682x36gpnARC?=
 =?us-ascii?Q?v6cXIdySVyq/2kAMAEDuxfXLBlEKd00tOOnarVrpbi16fNhY+ihsJ4bLneuH?=
 =?us-ascii?Q?VS4j9tWy/l4mvKhq5euVgzcbpV7nJbtqhJOQG82DxkBvO5o02Y4zRgE54a8T?=
 =?us-ascii?Q?qcVvgEgc9Px6pcHzG8yr2d2TqZiYpVQv3RkTBD0EnyyxWedyBnqDnLsI/v7B?=
 =?us-ascii?Q?rHt8n+Vvo2gbu03GacvaLsPwH8IkY6CPKvuYrS7xNi34u3Bt33bcrge/F/sH?=
 =?us-ascii?Q?ijT5yYnFd/lYvvgLL+b0kh9M8IaqmfdnQO7xuRbqoRiFEkqouszKqRq29dzV?=
 =?us-ascii?Q?Pzn/uq153nay65Mr0Tz9YiT58iB0N+niXqvB2XL0f9UbcWe086gbtRuAXeb6?=
 =?us-ascii?Q?Fd01g/evT3JZgBikYHbKslcMHxI1xpcKssLH+6oae94cV9y8j2NlZTkI2ufD?=
 =?us-ascii?Q?SXANRW6IZMyx3sn6+mZ8cceP4Hbs9Cn/O9XfeSjGsKbWTvIJHPX0p9q4U10x?=
 =?us-ascii?Q?Zn0yCDgo48TpHCaNBfdMSEHazPl+tCCR+1SAANDENBsB/A0kU0qLH82M7gEv?=
 =?us-ascii?Q?QgoLlWtmbADh/RVuQs0NKr2Iphaa8WgsMQ4jRTtPzjTpdiKwOowz53cxFKwn?=
 =?us-ascii?Q?9N75wVTnYyHzLafRwRKdhoiKup82jA+RdaFe2kupEqMurVnUmdHpeTvt63nW?=
 =?us-ascii?Q?8++wLUf6zQeS8zv0t0F/Rfbs+GA5fpZeNXq7PsdlMNEoFsnLyW5mhI19wM1q?=
 =?us-ascii?Q?sJrF2n86beFJZBjBbeVGFa3VDGlYRrx+MPiYY3SuCp73RuMkn0x7BfXlfyhS?=
 =?us-ascii?Q?FNtJrSsLs6XSwHatZLQxgZxu9IqU3AtReef/PGQFP8C2PiUBs4fCFb8I5EXk?=
 =?us-ascii?Q?y3hNI3HuTCfCeYWDChY9rB5ZpcTxP5wrLJDzOfYJ2QyBhPBTR6ZJpzXbZP7p?=
 =?us-ascii?Q?TiemPIIQHhxNr+0szINTJyBwtxBOnQQETfc7MJMblhCoXagMqPRiTLVopsh0?=
 =?us-ascii?Q?DBDniCmo/rTT6nnV7lSLQXjUjZ8f51YLe3LQP3O/GkddDLMERc4HgftVdvZy?=
 =?us-ascii?Q?tznudtFFXKQA5Kfe+0v3Kv/7lqhAjl4KPWfh1D9hJlpjR1y+j8LiXG29Dp9b?=
 =?us-ascii?Q?SZn9Rnt0vpUtFfytu2Vn2fIQQ9Im/p+6PoU+3J56o96birR1Y6zeSH/AMmxe?=
 =?us-ascii?Q?vvnqOXlScwtEE7BurqWHXO9yrc/y/WDypj9t8P+Pf0uKDWDRYgwNtxkm4KVz?=
 =?us-ascii?Q?BUDNPRc1sIUV8L3ymehC38taLT1xINl+/AHJo9fRfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iIhDFCKkgcmaBZbD4Ua7QkH6kn/Ymbu+wiEvu2Yd5yrobpXLp52znDRNLOAb?=
 =?us-ascii?Q?wIDz2T8ZptY9YRkpoNXGJuNDU68ozWuRQ3ZlkRy06q/EzkoW3iO+tXaqYLNz?=
 =?us-ascii?Q?Ybg79ivyVw+L38PSlczkTACUdSl6nif8N/09Ltw3H4EY57GRuJfKdwIGb/W5?=
 =?us-ascii?Q?U83Brv8vmK5JMYzl4D9vdkWgpViih5yPw0ta++3lVLDAqicde3K2BwedQQRl?=
 =?us-ascii?Q?Pyri/48vhM5osE4uRxoeGKIbMCUTewj7aijcMIGMzMaLsGWWQ3nS8/hkW+c7?=
 =?us-ascii?Q?l/lMoXb8tgKbYZeHCRDFtOBDzmML3cfnMq7vzIoKZn6nNl9k7g+aP9vRnZjc?=
 =?us-ascii?Q?oTTA2AnnZSMD5gXOsmO5YzGqP8khjyH+Rou8GNiS1S76rvCeqPGL0JrbFEvV?=
 =?us-ascii?Q?7PUYGpDxWYFJFes0amBIzHmyFgXA/tAcEhu0jk56kHWGRilY9KEb7JrVyJeW?=
 =?us-ascii?Q?YwlR0HOL4D88l5MRq67X3+yaSiKHfmOXreODL3y3MY1QcXrfUwqi6MlDqSab?=
 =?us-ascii?Q?Q0pDerOcGbDfekJNvz/laIg64qiSHBrNkuRdfnYiTw7XCNVPodDRy3UihSvK?=
 =?us-ascii?Q?V2fOJk5HeF3UW5xN/VA3DFQ/LMmJSx5mQhP+G4FhAE+JCcjhLgsaqKcvD6KI?=
 =?us-ascii?Q?qLWFXRBrkRwGftgqwymZpnbc3xvzWbAdgkpwLpzpq0TDKziku79OWiTlxgIt?=
 =?us-ascii?Q?8coBw3GN3vqz0mHn+VeTeKc8tIWuJDyVeg5G4poynN3X9K6xKz7dp8Q+OnRw?=
 =?us-ascii?Q?+vYiwm21AQpmeXQxcg6OZ2bQAgOGC9A2Wk1EWdx7Tagq6LhyhAIjY8A4gHYC?=
 =?us-ascii?Q?OoxMFpW5RxA5mTVl4tOw78FOgY2g+8GUVt3tLBLWd1mtf8/vc0FCNmDQfjPK?=
 =?us-ascii?Q?eYgxl2/jCmwxyn3fbyH4iz2Tl0mxvTGOaBX+SLKoOyWZMoRrHRD9HUABSjB+?=
 =?us-ascii?Q?ZMYtGyB0e9nU7Un5KhGJRsAe/3s3yY4kUr7yhMeJ+De6Yd8Tbr7OLp5pxlVd?=
 =?us-ascii?Q?iIJ2U/U6R2nfSwTCXxLZYYAwgUGOuH5e3G1Y3ilZrxzemdV2Ty+bCzJIJGcA?=
 =?us-ascii?Q?u92xhI8yrloFe8MmWiscDebyvtbQgQkRAGWh7nZNwjVRMJ6KnNbgPMmXJ38Z?=
 =?us-ascii?Q?lGcHJ7OBZ3mBSoaQl9lpgh6fCfKhcBWF6WR/2aJjdoPI9IzmonAJV0HWvbcD?=
 =?us-ascii?Q?Cf2/yPkcW34ixONbPKYHtDEklTyY6SyW5ZyLM4YMNw/Iwm67Z7iAww3Xd4Zv?=
 =?us-ascii?Q?6KQjXPkqDcPevAflVjxFCbSYNWVEYXYyGIRetUkoYvFukal5sJxoYxWZQys9?=
 =?us-ascii?Q?HVhcdrfSs+qrthiA+qxThn38aOzcKYaiwE3xvFzzIObQwFk1of9hQMEJltOM?=
 =?us-ascii?Q?sSo7ljChSFse3lYkFE/hFCenUhWK/z0A1GV7IiPa3ANaRFkJJZWrTIyi8YTs?=
 =?us-ascii?Q?VZy6VEKZtdqvdoiYI1LMBN2RVlTT9PtPm7GC7ivd+nGWOq6WQm/o7PLPlUi6?=
 =?us-ascii?Q?/Vv4QG75k/iIB40QgqY2clTXDcV7FNFqVxJwIHJ+U3yQ0eQCdnkk3bL51R94?=
 =?us-ascii?Q?Wvu3eMI0r/0bpjkuJaslmHH5jrixx/odIYK02jV5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54754178-5d50-4b26-f07e-08dc64730b02
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:27:24.9971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dx9A/ClXCYF+stSOSz53ThhH2Hlk0cCvpEbNb2iTkHKedfFEqyUUe0n4dNlwXf9maz9/rFpNyGMuRz4xfne13w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6086

On 2024-04-24 12:40 +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Allow driver tests to work without specifying the netdevice names.
> Introduce a possibility to search for available netdevices according to
> set driver name. Allow test to specify the name by setting
> NETIF_FIND_DRIVER variable.
> 
> Note that user overrides this either by passing netdevice names on the
> command line or by declaring NETIFS array in custom forwarding.config
> configuration file.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---

Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>

