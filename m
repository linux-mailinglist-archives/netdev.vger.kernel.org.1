Return-Path: <netdev+bounces-215242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C82B2DBE2
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 13:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 997E94E1AE9
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0B32E542F;
	Wed, 20 Aug 2025 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qLap144k"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344B51ACED7;
	Wed, 20 Aug 2025 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755691084; cv=fail; b=KHZvOn/z/SODaiVVqQ1zcA6T57PSZASWnqFrx9cjTvqcOj4TiX7j5dj6EfUpfYNzezTqvCIAlVbDVR6ckuwKg/MS2r33VTMqur4vpT2is7rhokwUV7LiOoyXgaB9T236102ltfYyp/aNoAaqKABUxiSJPkW3cWXH5zxV5KGbUFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755691084; c=relaxed/simple;
	bh=olIUlNqlAiIM3blOfM5AD+TqNxCWi8GB9KnB8UHFF30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nLibo5lH5TeCa8DoN1Ho5oqM9wDBaRNBWi5Lv4P/I/kMWCvF3W60UUrpGQ4xJe1d3UHcsndr9nQzRFQaKCFMYZNyFlpFSjc1xt9sgAhdT/mWrGS9c9e6KLlG3hgyg04tUaVmWBl3jcbHwqYA3QtuunuysNHxtMs2SXbkyBsSyeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qLap144k; arc=fail smtp.client-ip=40.107.102.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGXXIEZ0/idZdDsDUiLUZX6tmywxsE5yEWlS5AXV5+AUwD4OVN8NARIknOsVfZW8VtzXjGdL/wMzET9seft1b9QaEH4dLaRdt2YARv7mSSdJbdbJPdqNZYXMUd4zhJCCGF6q3d4kemYZfLe8wXwmex2KYQsXbpoBWNZvKRHWHsSxxq/yTeigc667LcirZhFJrZCnY6Kdu0ftGtqAYsPiMenxXHwpGinEJSEQNrVVmnNkXaFgUS7++KazyHEFQTe6p1BCnWx75ojEGV2vB7Y9mNO68QF9nBJqfAOgn6AIj2TDzqSKvDdWtaT+L0J6KxVUyOhFIdfvmo3deuJdPI2M2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wa6vABdnM093bNzF+yoOWjt4zvPAciGNgONiMZlbzsY=;
 b=kLhOhO7U28fIkjkQUG2MGBn2WG480+1h/2/ji14j6hZakK08KhsR/UI08Hml2iVy5w55xSO0DO/OAh8knUEchXAKHrbcfZy5AC+CUKKkqbfT8kHxGGpqVoKRdr8icVmaAmXS3nI1ig78OdLG81Yld58EpoP9hUNg3XBA/fhpygWkJdAbkZJdKaljqJVcR6xSFbWF1duyke9FsrRpmlTZPT3GIGOtaSZHTYUu0bvb3MPYmU6ahKBrgcVWNHc/is6Etd87OXNKPKja+/o15h8Qd61AU1aSvj9XuphIFZvYVGqzPVTWWVmMbIz4h1CfgSbY6txFKU9XgNXAsDNekFepPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wa6vABdnM093bNzF+yoOWjt4zvPAciGNgONiMZlbzsY=;
 b=qLap144k+veVUA71VSOtMhBE9/W5JDTBwsq7hX2jRQmBjf0RWy0NxLTKM0gkixkbCOVyfj6aSyAmUbfLE+Qg0z2cL4HK6Hh6t2heN5hPpYIxQmp60flNmpMwDXUWpgK0htw6tJuFJrYe8S1QSU54rry4haFcZKTCme4fJMIW2LNCKMSWLEJOKIhGTpyf8j7pYTx2uDWKaDaMLfwUps9AV2rOMWkNCoz1rmpk+yFrP3yNS6c+IScLZPgX6Xessb8pACwCYfwd3xWb8RdzoRdbj7j7U3ZmvN9AkSqgHXDlzw/dQD9q4anamDCdltANBS+Z1sQq4Wr+L2vAJ0NhQPss0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7729.namprd12.prod.outlook.com (2603:10b6:930:84::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 11:58:00 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 11:58:00 +0000
Date: Wed, 20 Aug 2025 14:57:47 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
	rrendec@redhat.com, menglong8.dong@gmail.com, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: vxlan: remove unused argument of
 vxlan_mdb_remote_fini()
Message-ID: <aKW4Ow61whhnM__V@shredder>
References: <20250820065616.2903359-1-wangliang74@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820065616.2903359-1-wangliang74@huawei.com>
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: 63fe02ee-8325-4ba8-6da7-08dddfe0cf82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?og09NQuTBl2oukZSxlYwvKn30ds6w9eQoq8yiCeiMXTX2Vrj2LAzYnoP376k?=
 =?us-ascii?Q?6X3k4kHxXcdMV/piS9Ntan2nciTkZVXSor9AdIuoZ1n0FbnvhF9XA7Sogdew?=
 =?us-ascii?Q?qezgeRPvsNuPDDl+rUGE+LbwF5EZ9YU75LRGz4C/mwgHGMB/gQrmn65KhE0i?=
 =?us-ascii?Q?plX4Twkd1fCPZJPO7nEWIenQWG1PAVm3FZ2lgiWROKumHtFvJ/ZKZXLAh6ta?=
 =?us-ascii?Q?joILVTORqlkKqZXMcK8UZR8QCo4HkeRNCxxMRJ4HzZWjQ4D0OyhNQzD4r0fm?=
 =?us-ascii?Q?GhfPIxZlSv7mPqQMA/ZJhBJU4vJTVPpB66cleUyM5OS4jo9Hn9WOJ+KPYEc5?=
 =?us-ascii?Q?oV3+pT7acB4uQ4cM3GnrLM9FEd/M/WWfupAgs/t6EljYqAJ95VlS3LtkgyuX?=
 =?us-ascii?Q?U8DUCFE7kYsOU3w+MUdjCiiKVnOl/CL4xGH+wwY/jCNX1WgBexRboxxf/e1b?=
 =?us-ascii?Q?iiQ97d4VHS/j7T7XgR7oJqlWi5KgzoUr22XJyNVqOZX8MhndFIonqLii8mM8?=
 =?us-ascii?Q?2XUXjx81/MtGlqcM6JiBI2QvltfMpSE/15XyEVYq+9rrh5y0/vFJKLkXo3o2?=
 =?us-ascii?Q?KsV9HzcKAF/ce9A8jzc+5wKy9rPF1p46owuP/x8/yYODzk/Do/eioT6eee0g?=
 =?us-ascii?Q?fjMWKMpa70wXFFL8dsSQIBc/VcPVNT03NW78hn16usZSOjhSCwiAxAbegIFb?=
 =?us-ascii?Q?3NS+I8TlCbrP2e09iCeI82e+bi46cSUWhvYGzW/V7bMCnpLCs9SPIkxwD381?=
 =?us-ascii?Q?nfzC31MALb7UO/sSO+b6nnMpx+fcOLTVlR3qiRV+tJQYIeOi/eTIk73WXtSC?=
 =?us-ascii?Q?wdlsjprRdPXvXCLUGcN83ny68J6lWnTgwBTQT3p9OcQDfzVzY5RkDOxeWXyb?=
 =?us-ascii?Q?H6tSTzGAJJlX7p+n3n3ITnts+aHJ/nZghFLKLG70wtGIG1AxwxjbJyzf7RbU?=
 =?us-ascii?Q?+G2q6le8Trc0aFZ9zuyUEOfXX4zn18ohShbRyLG3UgMVeKSVpOXMdflAYYrI?=
 =?us-ascii?Q?QbVLoL8gCZYUdL0X2fyyR/PGe33wYApgaouP7l+1yMTb7+2dWZnu9myZe6au?=
 =?us-ascii?Q?zR5Oz5B5uhdruqi4hEhOffQbnZk4ZQZ0d3WboGiR/VKdANNnOLwtWhnTSsVh?=
 =?us-ascii?Q?37BRdD/8Se9I+Jhq4AZjgDvFZhYOfhCWUP3Q/tYaLjA69YiA9GOKlQqLuyGs?=
 =?us-ascii?Q?gpdJqwTaOO3QHcQXgCOXOAz9uvDNXFbSyHivc5Nmtj7HHeG+QwJLPzAbt3e1?=
 =?us-ascii?Q?/0LQVi3L+DdR49bbGNuUye+YbWCYFv/5pFk5d0TxVNkgxZQdqhKuSqAFyAXa?=
 =?us-ascii?Q?qn73DTjWP1a0kxlLNjSfRG5F5dJFWZnRGqlhbXyFzzXs0DG1WjRgHB/Q2hHl?=
 =?us-ascii?Q?wYPX69usJBxxtI6RhDUfk801boaqrRacL2Odz64AdbhYHR1Ty4njqpHWea3c?=
 =?us-ascii?Q?YWTBW8rztZU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?49HRtla0yY1cC0VuGXAz6tnSqpseNfoZ4+jW9mxkxdg5OJp1R6wbubTCa5oS?=
 =?us-ascii?Q?V2Qdz9SidmZ+qw17dYyLWezlGD3ySBnO8KkH3wHafoNBU1cSysqchochYHH0?=
 =?us-ascii?Q?3F9yqq1XqRxGirPyF/p+4sKhEqTRtNWD6bEHiB5LmMkFUpGDd7pBYhL0xqRj?=
 =?us-ascii?Q?GxId0XNK8m9XI3NJK2jZka+sEY2a0ljd3Lr4RZy6sKgvCQpjJljUhvin6IeO?=
 =?us-ascii?Q?zsW6acpykFxnhnne2hwNx+kEt5zX4dAZqDvDC9cM2QzWvhr1oHJzemUVE1h6?=
 =?us-ascii?Q?UiuvY34wimTe9gT5UdABFdRlM8Ji9y/wdFnetSIaaLrGb4HeiIYHgZCKrBe5?=
 =?us-ascii?Q?CL0GyiM/SoL36NZVMMrMKpzvx8SB545La1JxpAx6Ah3+jObGtTOSm9vQLxsB?=
 =?us-ascii?Q?BplvrG8L6Tkha86jXXznr5QdB8W+t9WUyEGA3jj20guwnT8MUr5A/XXZQgXD?=
 =?us-ascii?Q?2Po22ZNdfldIdNAkevGTfd6cVPsvilhOaRo1cbtTqnfttq+NWiJQlws2bqbp?=
 =?us-ascii?Q?fk6+KeDE99cFAxpUIGyqY6UR2epnStltpl7aNc9/Q5hN6DUef6qPtKk7aP+P?=
 =?us-ascii?Q?48p6NlULi4rZ/oLxljVIn6AWoAli9DsZFE9NQOd8/bXCZE4h1jM5YroO3VF0?=
 =?us-ascii?Q?OuinVHyqY6xGpRc9X+knJP0c8gFVMwKbTA/BONeQZwQV1BRabNnvLltRmDv6?=
 =?us-ascii?Q?BN80ZdU6OT35P9RpAJJuHNjgxBrDI9H2+mBdDN2WX14FCStMMcxnwC/BSgGM?=
 =?us-ascii?Q?PEJOW7fvxUZxEmYs4ptdW++0T8pIOYocZRe6QnzT8FeyeBGg/c//Zae/W6k4?=
 =?us-ascii?Q?4Z0sHN6Ztztge7nqxyOvoG0XWxUuT+iIZBrfK09da3VGMsyPH5wPKaQ46hbt?=
 =?us-ascii?Q?YYIYbO+cO48fhZBO5VcFHUbn5+d5YuCbdYYJvp/DH0i2LdsBBtCe61FR+nNq?=
 =?us-ascii?Q?bqfkOMuiegOGqMtS6KI6Oltqp/Qe6lmvVTkpZkY3X6MMB+HX2Ctm0mOxvhT0?=
 =?us-ascii?Q?cybet588pf8jpw9mzPVEnboe6wi5LLBxqVbCKJkT3TIA9cqB/FGHBIHWppFs?=
 =?us-ascii?Q?iEVqZGAgaNaNc8TbqjKTfkEfbRyzcY4ToxlfsKGLMsdYhUcF5H/Rz+UWffQB?=
 =?us-ascii?Q?d62BuDeYhCGiuW58z29XjSmGHib+5hCM0DDuCincQ0q7GngWDB7LUYGDMLJx?=
 =?us-ascii?Q?CBAH7QEziH7S0Xyi9NGLAquRrJFrvIM/akh5OXiZFeIvAzBExwL590eSQs1K?=
 =?us-ascii?Q?6FVSaZuZt8/am2RBlXRkEyIkfuTqZ4XKhzsJBXkVdcXxm7zEYrzOpUaPlvOy?=
 =?us-ascii?Q?LkyHADkp0wB5A/jKaPtN3ip/Yhao7dCGwYXSapgaNVTPpCz1GdZUe8s7yN4N?=
 =?us-ascii?Q?EyMIZZsSXXrHdcodoehe6to7oAXAQWrCrGwIEz1BVF8iaEHc7mmSYyIFtArn?=
 =?us-ascii?Q?FdAzvF1EF7ccMLS+XAYjMODgDtF8HBkdysrKNIXYcqrcBYVOxj4JhH8GkDIb?=
 =?us-ascii?Q?TDEZhfXOieNWmh+HxFcxvO7I5pT1S5mggZNbbtDNmqtZaQemK33DLi/6TnXi?=
 =?us-ascii?Q?ZqwSAWdRWb4/QZLLiEgG/T4Zn5cwxa5q4BgXOPA7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63fe02ee-8325-4ba8-6da7-08dddfe0cf82
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:58:00.5042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPZwFaapOxGcb6bLHG19IKkLmWU6p9BhUUD8h+dq1O3FoT2JhqpY0nu2M0oRZHh1xxHBBIsHtPN8wx5z9y4+5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7729

On Wed, Aug 20, 2025 at 02:56:16PM +0800, Wang Liang wrote:
> The argument 'vxlan' is unused, when commit a3a48de5eade ("vxlan: mdb: Add
> MDB control path support") add function vxlan_mdb_remote_fini(). Just
> remove it.
> 
> Signed-off-by: Wang Liang <wangliang74@huawei.com>

OK, but personally I wouldn't bother with such patches unless they are a
part of a larger body of work.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

