Return-Path: <netdev+bounces-124554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94E2969F91
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1AE1C20B09
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 13:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B65629CFE;
	Tue,  3 Sep 2024 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qAJ5vzrU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2073C1CA6A1;
	Tue,  3 Sep 2024 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371821; cv=fail; b=Ko+6PAz6xLSkGaAgNT9Yw0W9+FXG5gutx+NJ/ks8iI9Y6NIIlncACIMhnhZauOFOPAUr9HrL3z70r/R1/eOqlk9xX6TuUcnmKKUHdv95dshERAazO/cBB/g7vshd1gxRTjFtPOcOkKFjl69Mj3NAxFV68EWdKha0KK/fVgP897g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371821; c=relaxed/simple;
	bh=r0FkMhZ/RfGhZ2M7jxrjv1QouvSO48zJpO2oKPw2dL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O1qLZrqzwUeTQGvn4T+xd6htKJ12WTBxaAZ2zsLSRJXuju8ymPMyl3bWE1pXAdvMWI10QxbjTyJ/zBI5umGVzdvfLLOFsIcc58VcCspiQwHeVJhysnARGus2P8WNla5uMBz8Hm61iHCvVm25RkFWspPZ9MUw27x+KpURHpnMiS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qAJ5vzrU; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdLLbAw1ygU2RxpP9IZwewEirSVYlOB2V9799LDScZ9FKJyRiVHYH3s6PslvhZxQeHLZ/hjwWEtVhpHm3UfITxcnBk+m+o8GzQPbc7winODFr35elaCnOfdLTbJ5xGcO7VinGGM6964Pl/5Td0iPw2LFxVEGeenBZembZMjE1QW2/fGkSVo0Mb19P2fazJIn0R/81PcQjViWB4jMF/tjJiUWYF+/tMnDeNSD9uW4TAHf2sdQk3VsatCYhGZKtEeJisMDKfSU6Zcci+xo4tcx6TfH6cjsycahi2SSrCfOcOT4RIOuAYVXMwKLO+3vKUjRtWQusp7sI9KnK2I5rZCRtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CU+qi9rYVgI6cvHo70YKe+C6Io2nlcn+NvFmhIRyOVE=;
 b=tfnayYk5ZkCLzXN97+uw0d9AhxIk/WQCIjvAMRgZMtrYQ+kaI5Eq9ywV+RU+2XAZg1X4cgiLhrwPg7O/Wzcu/CodEnWpMQVbs5PEuKSCgIGRkU85Yt17qITNCnoK+Fl5eKqswcTqFZK+cSgSwVOJOlkXDs7dlQAnrksrjuK1dRmvw17ylwGbCHn93DSTjIPtB90yp8acMGuzflYReQa+Bi8ub23JkxGGIV4kqgNbQ1vxqcjVSXGZ4haqce6+yGdrX/d/2UqXRkPFbXAJ/fMrhUtur9Bq7b2ltYGIP3Q2jVtVXSrUcNqx+DjjfR6qqZH8A+EEXvzovYgSOnYKH0GYYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CU+qi9rYVgI6cvHo70YKe+C6Io2nlcn+NvFmhIRyOVE=;
 b=qAJ5vzrU6Zl3OEKcKT05GximPUAEGy/CFbA+Au/Gld0sG9rAYFDD3qqYltDgY9eqnfpiEND6/l0oviRsDwMTp6BxNPdpOUsxkr1/aROB3Z+jeO20P2nb7+YVRGCX8W062eKgkT+OmW9zxKcz8ynHZN9sWi0L1exxJKoRtw/oIH0ioFcsTpI6NyNxt/C4uRnFxRXWluNgfrcWTQRImbxPkNJfbqoGsOgFfmtdHeTpEt+p2o2CFpaKSIRIlwB7RL7uEYK/367SxJjj0UGorQ8goaOisrsapr1lpBP4+y58r4AZuXqRN0VUYNrKdWbMLddZ6/zae2DdPzHQpFGMDpog+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2719.namprd12.prod.outlook.com (2603:10b6:805:6c::12)
 by LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 13:56:54 +0000
Received: from SN6PR12MB2719.namprd12.prod.outlook.com
 ([fe80::1ab4:107a:ae30:2f95]) by SN6PR12MB2719.namprd12.prod.outlook.com
 ([fe80::1ab4:107a:ae30:2f95%7]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 13:56:54 +0000
Date: Tue, 3 Sep 2024 16:56:42 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jonas Gorski <jonas.gorski@bisdn.de>
Cc: Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@mellanox.com>,
	Petr Machata <petrm@mellanox.com>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net V2] net: bridge: br_fdb_external_learn_add(): always
 set EXT_LEARN
Message-ID: <ZtcVmsqk0m1S-XuQ@shredder.mtl.com>
References: <20240903081958.29951-1-jonas.gorski@bisdn.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903081958.29951-1-jonas.gorski@bisdn.de>
X-ClientProxiedBy: LO4P123CA0632.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::22) To BYAPR12MB2710.namprd12.prod.outlook.com
 (2603:10b6:a03:68::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2719:EE_|LV8PR12MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 29954798-84b8-4c20-dd58-08dccc20442d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yZzGZi/xzuBakQ0j+uE8+fJG9HtzxPXUKre7uZNyt10uOYRpgaMtOZEzoNSH?=
 =?us-ascii?Q?tAazdMioDBALt4h/lzEdlHv0crLEBr3J+VngZSAhLizXvfnJor+q+vcSWUz5?=
 =?us-ascii?Q?EikDNibzA4oYS8vLPW9zmu9qqIR4R0PyInJcklDbinm0sPOcSUt0psLFRSAH?=
 =?us-ascii?Q?XKR77bkl24FQTSl+VTyd2lSmWMicea5gu8hrLUgqsInINge7wjlJKCo3Y+Tl?=
 =?us-ascii?Q?TQVMeyjAImJiolL3QhR3zmDIa2afYN5dTEkwD4+K9eHTitjMfUE6gHsQp20I?=
 =?us-ascii?Q?VDVmogyEdPN7CLsoAIj/PQYmyVnk3oGwrvMX8P/sh+bimcuwVOIuddBfDTpT?=
 =?us-ascii?Q?1GKFNl3tc1f325vSgtdn3er8WISCe0DX9R45K5PZs50xeLD/7ofHl085thtn?=
 =?us-ascii?Q?EA+kRL2e4aHnAjdchvzMhMkSU2HCq1R71pACGyH+OEXnOnjhzb8Uo5cNH4KQ?=
 =?us-ascii?Q?XB60y5BlqyVGqsK83TAT3jbEA+eSSj3p5adXkIu46JhBwNQFI+N328MZ9CpV?=
 =?us-ascii?Q?YaZiRMwRsSACO4INvrCeXQSe1qH/EvoAE6JLw4xBFrtXB/ZpqPCblZSyEtDi?=
 =?us-ascii?Q?C1vkMHuRA1k1hB5wlxJTAyVJQHBraBixGEtODSFXlV/j7q8CVATloJiPuh7t?=
 =?us-ascii?Q?9sQo5s0CQQVOgAUarFI1REBScoQkoXoCQ7jsNeqfsEm4Um1l778AOjix9t26?=
 =?us-ascii?Q?+Fd8NXWlqCBZE67zr8uKImeanU0Hm2yibAfYqDJiZh2GCYZv0z/Q00oDNlzi?=
 =?us-ascii?Q?P/zO2bF1p5EBIIFZLIyFnYdiSp+Nadoq7L9tHBXxvu9cs47yRe0fRQgeC7WQ?=
 =?us-ascii?Q?cG0FBW54LTMbXAxAWAE2ANMstfsykoY9F1NTr1jSZrFlTckdBEcQzyaZCj4+?=
 =?us-ascii?Q?HkTtXLlv6VCt18fIYXW3dhn4dTzebmwyiuX+/b1s1l9b94cpO3x6opho68x4?=
 =?us-ascii?Q?eZWh451IVNgi1nV721Itw8hIJeC2FdnHbOdn0299yN07h0wqS6x+rZbLZwF/?=
 =?us-ascii?Q?RqEQQkm/U/rglMFG5XoXbdAUnhxsR4zhB34s6Ga1goD3iqeHxts7KDn4moBE?=
 =?us-ascii?Q?bzaOObgf+evUVTb60AePCCdzzfDJjxCmK7IQyTFfnDTTiC3APYHIWV9LmSbf?=
 =?us-ascii?Q?wA0sK7B2LzUeb0QJ4RRISKzZGIBOhdgMOfz3xcnTlPwrAwllPDMtNraWz9Cx?=
 =?us-ascii?Q?8Ezs+yG+iRSDbNB7DxwTaQZCsnZWOgC0mm01NX/+UlyRYTjppxQdxOZel5hT?=
 =?us-ascii?Q?2ulNBiM8hRiGcoGuqusuAbeSAAKFtWlYmqZ/tnO/rig+nchWak1MMUq7844a?=
 =?us-ascii?Q?4AMlMlzd8tUHdnN4XypjbstbKPLF7nGPp/t1Qw1ap2UV8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2719.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U4/hNiom0j8GQ1+JpIUDnj8ihYqjcjCn7ntfFhpD5Klajj85uE2xsAt1q0WG?=
 =?us-ascii?Q?5X1rUOhCaelZKTc8uCUpFkuF9vQjJCrmQAyfpw0ogYWmZQha7CVh/r2ldBf6?=
 =?us-ascii?Q?0509L73TlkzfshSI9iO0XQ2mqM5mAdi/tR5fs0NjOiKbD7c3NXJj4mi09Lwt?=
 =?us-ascii?Q?7ZESnSdDO0ObhmaeyFL6PDgi9GWbfoAUOTPjQ40ZE7zWvo0TO05igwVv3lL3?=
 =?us-ascii?Q?5C3scLj6I9rsismK+WoTx+Z4lnRHDvhq9natVIbctciBqVJC0asfzOxjQYoA?=
 =?us-ascii?Q?oIOdI33jsvpraijeSNJN8iRu3aF5S+uRRu76kFXVTNEpQBaYOdKI5JkInMnc?=
 =?us-ascii?Q?/rmxVvzHVvWlJb2G6HlGgouc1d943De9Zm4bY5ybjDcYDN56xXTAm7azcV3v?=
 =?us-ascii?Q?+vAYO4uYA3NOcTg40sgsAfy1m3cImJiM5Nljg6CKHKcdT4Uj1pbgRmhvvZuu?=
 =?us-ascii?Q?ceU28dpG6AvbVR4uCH6qTAUz1cbdo36uK3v3kvyx+XjAz8FUROcESNgDUaRm?=
 =?us-ascii?Q?Sfn+EAndHX2uDnYUtKS+NV101dt2s6GPf/mUJFFC+zFoiFfwmXUs0HIjjdqj?=
 =?us-ascii?Q?x7H0SFRWU+fOHIskNCJ+B4l1o3/2Elq7SmlwloO6Qdm7NBIXi2Miy87v8oaS?=
 =?us-ascii?Q?EqFV7cHfFtIOYx71IK3ukvSiMbhDRmX+4L8RlmXJHzRue7ZO9SHTKJC7sYUy?=
 =?us-ascii?Q?I+tnnwOA/G8WknLFUhQYJc76WrBCLk0bG+HapMAPT39ObNF9f9lMoi3FcISM?=
 =?us-ascii?Q?fE3ieRa9vq+SUqC7bsBxVCVo9QKLXWG23lE0W3r0A04APvXMTubiUsZuWU/y?=
 =?us-ascii?Q?UyqJMOnz0Ab3OXCo1uqgQAyX6vXtn64W47CH+42OThEeo58MPvd6HbccNQkD?=
 =?us-ascii?Q?7g7AEXkILmeggfUGIUM/EynDgyMDQymcRTq2NrNw0tMMIGIBf1122aT6BWfF?=
 =?us-ascii?Q?pWYKwXrmVmxq3j5S9cdd7oT5ka0Lmo2woUoi1kHAz05eQqc0vI0C+K292jFT?=
 =?us-ascii?Q?91KvQB//7HQhMgfMyU1hZVL7KRNlah7KEHspLFGXKXmJD0vDH4rCIApWud07?=
 =?us-ascii?Q?Sub012DyB0eUKL11fNKQIDKU1aB0HZXURZ80Izws57Vz4HG1pYPOWwmTdJ9S?=
 =?us-ascii?Q?uaoRFsvvVT42GG9JkRKwbdzbgn0rInb4783cFEka4PzUpY75mZvcs+EG8TRF?=
 =?us-ascii?Q?zXi5uawZGsC9TeI/CqXpBzD+YPY6rkWGkVRTXrWTCV+fYFRgtsm+RBcIBpxh?=
 =?us-ascii?Q?rcwgn+s+iVfskc2SPjFbujONBa9Q6hu1IAZzMnEX0XasSYPH32T/hF3c97qp?=
 =?us-ascii?Q?zkF+ut6R0IghW79qr9Y5rZB9kn9SA7G0Dx1hjxHaNBhGPyqqsMJkgzLsPC8G?=
 =?us-ascii?Q?8GTovAum4sBbFjzluJ7wQhDZiXxInGzvpNcVrp7wL/ePHQIo6V8MYdpr8rLu?=
 =?us-ascii?Q?6Zof+hsw1Bc3wWgEgt1phwX6Mmy+RyX8RmNYB/S1K2AHhqD2s3JbgB+XXbUj?=
 =?us-ascii?Q?dxFU8st0xFW2qZu7CwNilPSVj6r9abUhXJ9h9IIDsdIWajGv3omnGCUfRwR4?=
 =?us-ascii?Q?pnpc7UWAfzQufKrzvKDvA7UbYEVS7eteuhBxn7Ve?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29954798-84b8-4c20-dd58-08dccc20442d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2710.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 13:56:54.4868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkNR7LGMVH/4w38O/pGaTy9pR+FIo9bIx4ncKVvwtYk/tHX1RxTUJcAWAOdYaJX+GcbdXxLvAQaMmvfwvPIMmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154

On Tue, Sep 03, 2024 at 10:19:57AM +0200, Jonas Gorski wrote:
> When userspace wants to take over a fdb entry by setting it as
> EXTERN_LEARNED, we set both flags BR_FDB_ADDED_BY_EXT_LEARN and
> BR_FDB_ADDED_BY_USER in br_fdb_external_learn_add().
> 
> If the bridge updates the entry later because its port changed, we clear
> the BR_FDB_ADDED_BY_EXT_LEARN flag, but leave the BR_FDB_ADDED_BY_USER
> flag set.
> 
> If userspace then wants to take over the entry again,
> br_fdb_external_learn_add() sees that BR_FDB_ADDED_BY_USER and skips
> setting the BR_FDB_ADDED_BY_EXT_LEARN flags, thus silently ignores the
> update.
> 
> Fix this by always allowing to set BR_FDB_ADDED_BY_EXT_LEARN regardless
> if this was a user fdb entry or not.
> 
> Fixes: 710ae7287737 ("net: bridge: Mark FDB entries that were added by user as such")
> Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

