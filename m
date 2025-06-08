Return-Path: <netdev+bounces-195558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F28BDAD1295
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 16:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7F63AA8C3
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 14:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6B724DCE9;
	Sun,  8 Jun 2025 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ML0TWDWl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5661F0992
	for <netdev@vger.kernel.org>; Sun,  8 Jun 2025 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749392682; cv=fail; b=JCxLwmaIvs1O1yicwCAuy2dG41qc+mhUU3nVLmhKkt2WZi1gwmvEczBAavGVjN5VMVeMlyXpV2FkxLFP0fDlxWKs6HG66sfZL2Xu4Sf3ey5wKOJqu5INW0fRGjH5KzMrQTYuieT8i8RdtAqzl/JXDKQf/+uVdMnwNafeAEn0rH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749392682; c=relaxed/simple;
	bh=J+uJUFzEka6WF/x2LywY89fapomaTlKzyRjbIT1wFYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SRBClgM997P3UuSKIeR5Bd3Hi9ZOuk+BTImj3TpJSpkzsfY8DCIm6RmAuZEya0Kfft7vc5mpAE0ai6YL9B7eMJEk9whhnRDIb9Mr0Dkfw5fHXAeG37BwY1kkW2p5ANYswAHvETzt3AfoJ33dXe9fMtyq7eYTGO9Yv1bgqlvL+Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ML0TWDWl; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xo8PBvoe4XhbBJN4ZIPYlqiC2jggZvcOGe8AWTA6CnvUUUxEGozzl2A/b7SgQvEH9MPX1aoRI1OB7FaYJcQ5frpTI807LkRBqYfsm/J7RhlgWBdp8u0D05GlrSNXRv7Tk81nK9kJqDgs9KzCiMGJEejFCVoCHuJN/a3ZIKRL/dTDDtZT31QlDXWOoVncQwDw0GBl88M3xvFjYMMMw2hAExohAtmnOsySlZbY1Tch9eOeQih5uKdu1Gr0pKDe3R95ksAjYtUd3EqZroFvcIPP1R78lV4tXIqQkHwd4I4Rhtq3zWyvSLUy6pjpdnlhU0qBZvI5e3Q2VwPH3Py6hA1flA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ug3itiyYXby0WavBuAdMtBah2/Z10QYWiC22fcmOhsw=;
 b=POgUS/+yqdTe3Ofpsfbb50ZRr6IphjPLpfJiQF0N68LzK6V7fnh9rFTVnVKDkTkNMFVJ4cPpgb0BCgK1NF7a8Baog8Rx6t/kYo8LkkeXXa0kgr/8nxqH0BSPUK1MEH6KVb/m/foOTi7IUr5b4jj6U5LjDFZSYfss/US2l+2WCt94PR6EfNUVrvdgMcMTQkJeB5ota52/NYXBuGPsbhU7w+3bhlf43UmUVdli+IFgRcFCgE+I0CScU2YFFKRXMBJUWAQRQPi80WaZz2flTMc+o1xJ4/eEC+gETHCyTnkWfPBy6UvHMSOIfTJMCgqBw+d031VclbCckgEyt+Y2i6555A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ug3itiyYXby0WavBuAdMtBah2/Z10QYWiC22fcmOhsw=;
 b=ML0TWDWlIp0dIXCcX/6plFf2+rb9BR8f5tNZvVZTYkdr0fvhXCdn55QzBMC+dmCtC43qY746Wy+MGZekIG59K1lWFpQkN76stR8VfXHtAY2BXf3I4fjfNArgjPxcuSPpDY1QyIUDONk8ouqc20YPIRaBe1seI4PYJTznoGCrxKywRFTjqT9cUpA9JlJKncHXDB8olEhz+Ji1v3pgOOaRj3dbIvaaaIF5iULn/jMw9BlBHoI6Nl42+qYrT6PGkFDt9HcmRyupId3GeLdzrM6390MSmVoxVCHSpvg3MOPlrUeRmDMGL8CGyPQWbGgShkAR+afny2EGRnDCCKcHYI7hSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ2PR12MB8159.namprd12.prod.outlook.com (2603:10b6:a03:4f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Sun, 8 Jun
 2025 14:24:38 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8792.034; Sun, 8 Jun 2025
 14:24:38 +0000
Date: Sun, 8 Jun 2025 17:24:28 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH iproute2-next 2/4] ip: ip_common: Drop
 ipstats_stat_desc_xstats::inner_max
Message-ID: <aEWdHLHgjR1b3hCL@shredder>
References: <cover.1749220201.git.petrm@nvidia.com>
 <2295631ffdf81687e4cc7eb2b1ff09e2434c623d.1749220201.git.petrm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2295631ffdf81687e4cc7eb2b1ff09e2434c623d.1749220201.git.petrm@nvidia.com>
X-ClientProxiedBy: TLZP290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ2PR12MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: c502b02e-37da-406c-79bb-08dda6983361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FJSZnvHO+GsmvXNOJgFs67w0H0+WU74CVO2Zj9XK16/4scqcxWyQgg7DU6//?=
 =?us-ascii?Q?bVohdFYIztJuactJUQWNWL+XXxkXIB9IZCSUEpcjUn2lp0s2zGYAvXVSsdpZ?=
 =?us-ascii?Q?8OrrTURjxok4IU09d81jXuwKlBpyTF1hySiSQVD34xADZFrT6ltrqmxG3+CH?=
 =?us-ascii?Q?PYeA3vL3nvmVSvm2YVD9hCG+WLcAhSGah2BIvE04vqSg352jrneOX+lWaJur?=
 =?us-ascii?Q?chfKWs2WfRcUG7C8Et3fG6x5+2yZhj1AzCnZDNX8xzoQ83kKURQTQF8+JdZa?=
 =?us-ascii?Q?VkJags6O0z3Z3K9oZK+aUpLwzdPgVTfuQJxdNy5OgwAWgh4tXsb++0cLKse4?=
 =?us-ascii?Q?/L3MGzSGNJG5S+8K3Vjs+UY6bTBx3LO6FhwBpcz8uOp+brmaZFdeROJshN+M?=
 =?us-ascii?Q?fP/rUBTWK0dJStCNKVT3K7q3354/vnHld3XbB20VALv3p2JEW4u0u1JVpZ2X?=
 =?us-ascii?Q?VOEqlr9dTSRctNvYYwtYwcXwKS6+GOuPa5NZfnwPGHF6O4ZymoBGAqFPGY9H?=
 =?us-ascii?Q?ZM+J1Cb0DgmHdPBRBN0CEgnWnYJ3REeqFgQKVcHCG7EdXV02iMzdte7f00xM?=
 =?us-ascii?Q?hl9NHf+CEn+WMtYzzu9g2ywJsLUrPXmzKhIYQWgps+/MljS4hBiLq4L+JKX+?=
 =?us-ascii?Q?jjBHX+4ezcvEHNy/Ml8NxLlWsN65nG3zi0L7lDRPbR3S0zUIdqxH9e43C4GG?=
 =?us-ascii?Q?zoXqHL2teBDrELdO3EoxOng472Qa2z34rV9NjGZ6miMPmR/FrzK7lF76h8jB?=
 =?us-ascii?Q?aLaWFwl4HBA4yb5bZczzZG4b3qEgBIe//kPzZE3Xo0RxlrYlDQiu52TrC11q?=
 =?us-ascii?Q?w3PqbNH2i7UMuQwithyHLCY5eWhjJ2WOBL2fysQ7oi9Msh1l7Oq4vsmEYtdK?=
 =?us-ascii?Q?fuWo3VdU6+Jetj4k+8mjaG6wa0w2lB1m0gJNn6pqrrfaLE6KvktwxfVDd+ds?=
 =?us-ascii?Q?HOW34sBYSWRL3y1reigxKt/WnngV97h5AnD/zug1YQ9hReKD27NYK9DRIRtg?=
 =?us-ascii?Q?KJg+oqfxPwvlU4uVCz8uJPm7rSz55rZ0V4NhlQltrX0qtpBP47f2kjeZdeUr?=
 =?us-ascii?Q?/Gy0fY+Iohu8wytb/gLJ1IgTVDktmsLIvzIEr0UCEvuBL688/eKl1f+ftOFF?=
 =?us-ascii?Q?bHIpx9CYgftW8WGuVcaD5TfcLkoCsZWbeqz8ql2VoKNlF7tx+XHe/ENs85y0?=
 =?us-ascii?Q?viiUbI86GFTTEmqxYsxVL87W/dFaGwZX4oAkbPRO8l977zCY7Twu6dl2o5eZ?=
 =?us-ascii?Q?zeJZtxuiQgCSWrmo8TgztiH5cBLKa/B7FOXA3qkgerd8opJjbFzlzPVMrURj?=
 =?us-ascii?Q?LB7UZ1MhzlZ6RX6eBgkuh4ULTK+CAheIkhzOHEfWYs5UMdrjYcU0qrfQGk5R?=
 =?us-ascii?Q?84XU0X4GzmLNYkuApsGwRgxt1pqVjCzyr3IKj0qxiBY7BOpI6fyqtGaeuLCI?=
 =?us-ascii?Q?QjYbq1mM8fc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cQN/0r4BvN4tJDCLPs4hqYDQViCttoX1VNcep8zrGkRM3Zuafw7lgFJKJrn5?=
 =?us-ascii?Q?WKdYIKu52TCXBF8lBAf7A9n5CVj67Hpbpnct3rSKUk4I5LL9zPEPHLsmCuXy?=
 =?us-ascii?Q?N/r6mfhhTyPDZLv+LK3RMKWRC3zR5krNHIoIqkCokw1Ds/KQVnf6lm9MzsND?=
 =?us-ascii?Q?S3idn4I6u9a9WVKPTHVy8Ic2ijdTEVC+vdyD2cKtMsTL413h5MeK28C8oKRu?=
 =?us-ascii?Q?OGBi2Sy0s+jyXx1XiNNNRnUN/WJBy6ckdOObBM81ycRenDi1dX3SiuNI9Irc?=
 =?us-ascii?Q?ISwewMZSlqsiLpqR2yJOXkf3XS+a5hOscU4GMBSN0ykoNcHydKA3XY9VQe3L?=
 =?us-ascii?Q?Z+zn6LfvF9izQnTMeTTN88w3lxEgMrRbF7ti5AKdrwQrZCdfr9GFLEVBdoj7?=
 =?us-ascii?Q?LONKZfi0ExJOlIQU1dG444LCDIKC9/eirwxp1d9HSoUByF4e2p1EveFc6jVD?=
 =?us-ascii?Q?l5cyhMNPEn/g12I7qbXXAU6rYGKKkcNLzjXeEPzzY+xZM43SHtcnAcutQqMR?=
 =?us-ascii?Q?rWPugmwA4Xp1Dz+NoWu8fVU4OUaP8YJndUuOO63IQdsCQ1HPn8NSsSeMdM49?=
 =?us-ascii?Q?Ca88P9vNH3slAtSJZjwD3cYw1JA0ZN4jQd+ZdM2FZ6Jf2FNIPfCSxw6wLPsg?=
 =?us-ascii?Q?TLaLSk3zasWc8Bf+zdSQYP1d625ygmPqTXPJB7965m4dj2Vso4rknrQBj5Fh?=
 =?us-ascii?Q?M2568pzfLiVJJWy76cARAsfA227ZTGbxUwBFhyvcVn60JIW7XVIFuKfAp6uh?=
 =?us-ascii?Q?b+kvI8At8hqMsFIZQyTDIZLQ9OjQcswVxhqGaHocnYkSN9X0EImqZd7FViv6?=
 =?us-ascii?Q?40MQ27SGu48iw3WiXXf2IPH5BfGTQgMA3usM0J0UEU2s7yZ+LPVnwuc65KRR?=
 =?us-ascii?Q?zkMsED+10Lt5tXAxB1BeqVCGxaDAJF263qNqxIQtJev8du+ixPlMRlEaT45t?=
 =?us-ascii?Q?86KqPLVSxhvL0P2Nj2gFY+RVDEC3qEsJrfHtfnoxPuW1aPbTaXv8ld/S9Sz1?=
 =?us-ascii?Q?7ufb9THABYN9m9nGsq7yELN00Kc+qaYeyK0ADCNxvB1eYdzUhNMKK78F4TcF?=
 =?us-ascii?Q?MDDUvrayVl3DncnZ26KBGoP0ytCeBhiKd0AfatCt+sYG+BrSAH0kEFFCK2Nh?=
 =?us-ascii?Q?Tf3hsh++bpoO8eecYw35uUp/uEoQwjD3Ss1johs9kmmSN5w2Lh/D1KSAQ8vj?=
 =?us-ascii?Q?UfN5UVRpIvxidS6ahETqH47QhCOJ8r6GJUrl9AnMKybfuXaRX7caxfQEtRLp?=
 =?us-ascii?Q?Yl86lJk6anmwtJ7eyHwxomMH1PuVgG8aRi9Xux8Hi/p5QzkiYD1GdpNLS6ms?=
 =?us-ascii?Q?Vqht0Hxf44DxyTqpWzaozFvQDZ+FJXr+BAINxup5c45e9U3mPJqPs59qfQGI?=
 =?us-ascii?Q?SdDXuAXzA0cZPmZZn0US1O07ztJMZsdBS65QGX7aTW/7TGw/XVRiwviKjFoa?=
 =?us-ascii?Q?+77XjILcKekVn/iOTpXXurnPbi+3qabSe+Io55sHoP0eoOSv/zC90Bsi3QJx?=
 =?us-ascii?Q?W9A4UqgLw9MPdcOgCer3Y8/wJdM+VhU1jsH8cLoX6d/O2bJS+Qoa5VujN33F?=
 =?us-ascii?Q?y1F7sAzMVtPjp/azU4zIQyRS2UXPB4TYEFUFLRDt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c502b02e-37da-406c-79bb-08dda6983361
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2025 14:24:38.4727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPGq2+BgZ0S4drsmvcJw9ClItXQ2/aMrdyWOo7qPD4lJQfD9IUuDKK5Y/LO0+3xiAZTsGM46nnoFpbMJnVKsHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8159

On Fri, Jun 06, 2025 at 05:04:51PM +0200, Petr Machata wrote:
> After the previous patch, this field is not read anymore. Drop it.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

