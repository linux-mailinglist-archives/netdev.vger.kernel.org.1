Return-Path: <netdev+bounces-302093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8+/+CbL3PWoB9ggAu9opvQ
	(envelope-from <netdev+bounces-302093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 05:53:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6396A6C9F6E
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 05:53:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=bDt2wv0T;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302093-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302093-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19A8230459E6
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 03:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BFA396565;
	Fri, 26 Jun 2026 03:53:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D3B33F582;
	Fri, 26 Jun 2026 03:53:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782445993; cv=fail; b=UO4a56RJ3EOxuLeyAAO5TB35CUQDVgwfJzOpsEWWl8wcL3liZaD53wXg6K+C4bi1yTzY9YmJ31qewDcncTHXhBvA41sLOyESwRfjW4rr03w6LmpFr9GV90F4wPnDlLPG7MbwZJTyxwfOvSC5zGDuvfZBn7+AWTu007ePJYgdXxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782445993; c=relaxed/simple;
	bh=vuGKmZTIc34c4nsL0U7yNGEKOOkYGM/p9p8GTUvKmh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ewdecgGDJEgZRo95yyrohZ0rcPxBH9EJHOEZ738mzjGD6xKCFs/Yia88wPO3lRuOkgaexJSewNwiRdnADPv1MWSl8CFLshwnBD8feU5gpe+rMI3aZH8Cs5pnz4iFtfG9X1+elrGfQJ+ZAxpD/r540woKg8a8e34sT2MT6a3OMyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bDt2wv0T; arc=fail smtp.client-ip=52.101.53.22
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7Q1joGlwRKCFXGcPVH4XfqGZGiDRpTnOx7t7aWwP5KDt4+KylOgeMBjrey5AOVIR8WXV6whh3IgQ6IgjBAmd+JWtR6AP5UvxlyPJ5wmV44599gvv8kRZ1uRTDD8QFV5SSL7mfAXQtkEHfLc/vKGE81u6IqlNgrugQvKa29GJvaGoJHepNvtkGN56gXdvsjr93TUNE+82NikTthjruf3TWZcD/aTKTj/94/G66PJb9tNcdZ0vvZWzqZr1h1M7Fx0Aga/Rr95UIvO4POPBL7UGU3R3ETILDNXDjfQeyn+pPOURjpuMLdWN0hVCZWOUcPltdGiPzSuXiYKHQuTwZr3sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHyq107M5kLkM0Ofsel7KJjk8GndZT+AresbQWvPeDo=;
 b=amGbRWZMkOkLFT0yF4NyylR5tcb6UtAg7qSxML0F5kENln7DwtzO8iLEsMoynpq7jHJYj7kmxJlLJ8L+8aUIXabgGGkdtQ8y1IB4ZMHmGwRZI6hhbgbtmZAA99gsLy85Pg8ebJO1bzcGzgPLxH4fpxseT8aCyt/FuFr+O3AULlGT9+BpEPtDLA7XQaYse/K5IZ5hf0m6BcW7/AFUsuz5AvN7fGxlmXoVAZDpuiQx5vUQXHoNOYhQ9/SptFMa662NcK1VAWNrwVtk1QeB8Lj3aO1kKC9t88YcBlV5C4FKtBvofkInkuAZ27FNiYVV9xDXc7o8QTd3K98v+mNpUJbEHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHyq107M5kLkM0Ofsel7KJjk8GndZT+AresbQWvPeDo=;
 b=bDt2wv0TPgOnWl+kLTQcUdk62CR66eOLcuUd9OXjFEeFJ4LGvCqiSeMHQwffyRyvUbxTsHG/21s5N7QcMKOgcj32eU0z9knKjM2VjK+P6mB+FzFUPR6GACJoZzp4ETteF3qMsqTfrd0n7PupO4I+k2mwBGpToJHtlxGguqMqVjD7ahZ6osTmUqRODcG15x7HBCRv68naCr0fGxd3W+6LLegKPGeST/dualfQ/NkXIOxxvZzND7F8Du4zLPAd3l0Pv/lxKAro1a2RAmFzs7HE46V15j9y22lrT3NNMwgly52yZoT5BHGoy6AMR50lNaxW7BaGHcbp+BLjS9+QC4SG6w==
Received: from MW2PR12MB2380.namprd12.prod.outlook.com (2603:10b6:907:4::32)
 by CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 03:53:06 +0000
Received: from MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5]) by MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5%6]) with mapi id 15.21.0159.015; Fri, 26 Jun 2026
 03:53:06 +0000
Date: Fri, 26 Jun 2026 11:52:37 +0800
From: Richard Cheng <icheng@nvidia.com>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org, 
	dan.j.williams@kernel.org, edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com, 
	Alejandro Lucero <alucerop@amd.com>, Edward Cree <ecree.xilinx@gmail.com>
Subject: Re: [PATCH v29 4/5] sfc: obtain and map cxl range using
 devm_cxl_probe_mem
Message-ID: <aj32gUuoZuTUODry@MWDK4CY14F>
References: <20260622124010.2192888-1-alejandro.lucero-palau@amd.com>
 <20260622124010.2192888-5-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622124010.2192888-5-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2380:EE_|CH3PR12MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d8d939-abc4-4a53-e5d7-08ded3366304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|6133799003|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	nzKyoJU42gadQ5OdfRCcIH1dvFRrs41YIZlXEDlYMVWE7fyoi8R50zOXUs06l+7VDDzGPSOQ2ztBqQdL+UKz1BlRvxDoBXXw5mf/gmzQGsCYc6mZ/cDgVFMGyWnLGFtGreMVEsIcKIh5EDHly39ItthoScMgfkkbza6sqKc24+0dpw0Whz4y3R7nUGp223BUeAvdks10sGKVVkyIN47Ek6TB2Jr7Acq+cKdkaegm/cNXaq7gxnSNPDGGxQWr2egUyFeMXGt4OQy2n8VIoYXUDJwhn5ZnQZDmIPcQGCUyW+ahKM1kLQ5zRocclnYZtTJ0MXbUwBdi5fx+ljimk/IvCdJ2vfArst57Gb9o0t4zWIWMYhc1m3L9rNoH/Qew1/gefsmXrxb82bMuGxYGUY1/rJHqo8vFJJM3cfiVj6TvXPjb4/0HbCUf1+09oT3akgqXaUrLKvmTy9EOJ/PAiYMXQxrWZwPIcnnrzh/Y1NblP4g4yzXjPQuylUywVZhDEjiB4/xKTlv5YPhY2dNEb2659BblhWr6DGNCF+XxuUyINSHD9/P5/ZKQxzAd+m+Gmlz9DGoEEPds+M3fzSd++Sep/HYnLV42UMstxDwHELN7Yx/sm1bRJN82RQvIB/rO/StfXSTHEd5WYGTe+P3ewDUijZGpH333ybYmRHikPNs9tYY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TG8z6F5tKOiDdoD6H5frbZonHdRaxA28KlWgtLszGd9OB7v2vjUp0bLaAdjE?=
 =?us-ascii?Q?+Aha2KXWyMVVhTkoYznzEJsiEZ4RNeDDZyZ1ufSqZP7Re7tPNW5obIZQivxj?=
 =?us-ascii?Q?Jpd3dL7Qz9e+Bw0njLAbU7N8RswDOuWGYUiQvr7kdYyD0KWlqRAEpFPehqAP?=
 =?us-ascii?Q?SdMfHC4gKv/aYBFi1tx5v3EZXW7LzyAT4p2jU6T9L8c6D+sU4SS2P8zGJ0F2?=
 =?us-ascii?Q?DaJ9BTFNhM4+Z3DiytlLBDeVdyjMCuha90ZqgUnf0CgH7RzMLdhYW0i2dAbC?=
 =?us-ascii?Q?b5KW7opIv0r6TWgu+YPrPXcFxLgtflH3dN4SkPqi6IlH2Fp28vkKR2yvXAtz?=
 =?us-ascii?Q?2T5huK288FieBn4Ok49LMjxgWF10iBjkRa6X7+yq40B3AN0s09mbeEzhiuRz?=
 =?us-ascii?Q?cYq+BPBaHW7fddtU0vnshiNUFYCtlvLXqe62LMthqqZgY2xcxaDzmqu9byEP?=
 =?us-ascii?Q?IAk/yHujCQjMxD7ZVwoWcqRGhwRE9kMipciGR/ZutytOm1RYK65HUX18Rsw0?=
 =?us-ascii?Q?p20VGOxi3JTQsBJr9l+wKWAGiT9q7E4RAhedJVsoceBTFtwA4LSpcLG4e5QM?=
 =?us-ascii?Q?yxh66dpXdYHZHyC65MJBU78f7q+4IUHSt+nUsja4+pXDHmBt1AXJGrCO2XTW?=
 =?us-ascii?Q?hhDseyRAlwoPdGwH1Q6J7WBIroFnm2maGmggHCuo7wNSW6f/ETQTCQn7dY7r?=
 =?us-ascii?Q?pLPj9fvSCyH/+w3/O2CzVD5EOC9grX+DlXEKJRL1CqasYQZP3Ov1HU51lB5W?=
 =?us-ascii?Q?wpf7a5P4Vh9VZKdD3XBuF+Bd4zeoN9PH8xbHPIhocpAOE6n1Doej4SCit6Fq?=
 =?us-ascii?Q?0ykdfCPoFz21dfgM0nw0km3YrnxbytmCiVKavKtFa+mksO0IikIzlLO6ppCD?=
 =?us-ascii?Q?xFY3Mw0Ghpt0+DD6XP3ekFLux25puFijqtjk9TPvrzvIBgnMK4hAJgzeR6Za?=
 =?us-ascii?Q?0KNTsAzj0LwMdF2OBfOsOUR/kOW//3A1BN/KYILnD8lXCOtcsI67tSoYbQlg?=
 =?us-ascii?Q?oxhau3iEKznchSZnDUI+M68rmOsSWhipMOE0YIWI17sw/9eV6izt+MH+4SQd?=
 =?us-ascii?Q?5wMnBx69+7jQxnbIYbqwNdslf4GtxkL5sGj55Dht78Wq3nUJ/WbL6aMwgPhN?=
 =?us-ascii?Q?sDpf2jQbtA7vsObWrHbt2ZScDFuUeHXFXmDq8mIkFmCmUJl2j+++MZssENuH?=
 =?us-ascii?Q?Hmsrd63tzc7k25C8VXlvKA9eR8FgoNWZsQ4Y3OMuHN/eohXjMu8hZtW7E7/x?=
 =?us-ascii?Q?WFXM6JPKlp/LsvfiUvX5vYJZUDzXzYgvH9BsyCudacAFC45Yoy6CBL5ZKDPA?=
 =?us-ascii?Q?+2UlgLSBTQYebpX/rANtdLVvvduGsGuMALTDs9cAZP2E/+jql1fZg1xzla2N?=
 =?us-ascii?Q?hG2UuKSgqGZiQYSCYdRJsV8YjubYpJlipLwLzB/44feQ57WY140nE0LGR3bP?=
 =?us-ascii?Q?pHnLKkVGNGiGg6Ww0o+u3EKCx4yKBU2rsj8O/gvU8kEpkvmNi1NghueXTlpn?=
 =?us-ascii?Q?/t/Gai7G7bLfNQ2hI4qQR4ToYo2WWE57JsiTVE5JIODPPFb1xFpXy5RcvTyW?=
 =?us-ascii?Q?0c5PlOQSCJLTbgO5VD4gA6CN6VMI6TPmFWKFvPxVapKGJqHAWgX2lR+ooZG+?=
 =?us-ascii?Q?n9xAs5SYHdvmAn4LJEyJNqF+X+WLdY9Mn//OSOlKKSbPLhwN7OhBYouOE+i7?=
 =?us-ascii?Q?GqMEX+cxParAFnHqseO8ox56KEhtnwGGrOw7mD/k8sD+RJq01QRWz6vjHTwy?=
 =?us-ascii?Q?JYEW5pjJNA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d8d939-abc4-4a53-e5d7-08ded3366304
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 03:53:05.9178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0JtTvroNgQHN4v0aHRGVN4JfVZbLIz5HydQvy+TE3ak/FrqvV/UxD5GCWVYo9rsxL7UENOUPWzog3PX5YY3hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302093-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alejandro.lucero-palau@amd.com,m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:dan.j.williams@kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dave.jiang@intel.com,m:alucerop@amd.com,m:ecree.xilinx@gmail.com,m:ecreexilinx@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[icheng@nvidia.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[icheng@nvidia.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,amd.com,davemloft.net,redhat.com,google.com,intel.com,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6396A6C9F6E

On Mon, Jun 22, 2026 at 01:40:09PM +0800, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use core API for safely obtain the CXL range linked to an HDM committed
> by the BIOS. Map such a range for being used as the ctpio buffer.
> 
> A potential user space action through sysfs unbinding or core cxl
> modules remove will trigger sfc driver device detachment, with that case
> not racing with this mapping as this is done during driver probe and
> therefore protected with device lock against those user space actions.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>  drivers/net/ethernet/sfc/efx.c     |  2 ++
>  drivers/net/ethernet/sfc/efx_cxl.c | 23 +++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h |  3 +++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> index 61cbb6cfc360..3806cd3dd7f4 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -984,6 +984,7 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>  	efx_fini_io(efx);
>  
>  	probe_data = container_of(efx, struct efx_probe_data, efx);
> +	efx_cxl_exit(probe_data);
>  
>  	pci_dbg(efx->pci_dev, "shutdown successful\n");
>  
> @@ -1242,6 +1243,7 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>  	return 0;
>  
>   fail3:
> +	efx_cxl_exit(probe_data);
>  	efx_fini_io(efx);
>   fail2:
>  	efx_fini_struct(efx);
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 18b535b3ea40..3e7c950f83e9 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -18,6 +18,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  {
>  	struct efx_nic *efx = &probe_data->efx;
>  	struct pci_dev *pci_dev = efx->pci_dev;
> +	struct range cxl_pio_range;
>  	struct efx_cxl *cxl;
>  	u16 dvsec;
>  	int rc;
> @@ -73,9 +74,31 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return -ENODEV;
>  	}
>  
> +	cxl->cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl_pio_range);
> +	if (IS_ERR(cxl->cxlmd)) {
> +		pci_err(pci_dev, "CXL accel memdev creation failed\n");
> +		return PTR_ERR(cxl->cxlmd);
> +	}
> +
> +	cxl->ctpio_cxl = ioremap_wc(cxl_pio_range.start,
> +				    range_len(&cxl_pio_range));

Hi Alejandro,

A small question here,
Is it possible that the FW would commit a region bigger than the range ?
The committed CXL region length is never validated against the PIO window size.
The legacy patch sizes wc_mem_map_size to cover the VI-strided PIO offset, but
here we ioremap whatever the BIOS comitted and assume it's EFX_CTPIO_BUFFER_SIZE.

Maybe adding
"""
if (range_len(&cxl_pio_range) < EFX_CTPIO_BUFFER_SIZE)
    return -EINVAL;
"""
Would be worthy ?

Let me know what you think.

Best regards,
Richard Cheng

> +	if (!cxl->ctpio_cxl) {
> +		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
> +			&cxl_pio_range);
> +		return -ENOMEM;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
>  }
>  
> +void efx_cxl_exit(struct efx_probe_data *probe_data)
> +{
> +	if (!probe_data->cxl)
> +		return;
> +
> +	iounmap(probe_data->cxl->ctpio_cxl);
> +}
> +
>  MODULE_IMPORT_NS("CXL");
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
> index 04e46278464d..3e2705cb063f 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.h
> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
> @@ -20,10 +20,13 @@ struct efx_probe_data;
>  struct efx_cxl {
>  	struct cxl_dev_state cxlds;
>  	struct cxl_memdev *cxlmd;
> +	void __iomem *ctpio_cxl;
>  };
>  
>  int efx_cxl_init(struct efx_probe_data *probe_data);
> +void efx_cxl_exit(struct efx_probe_data *probe_data);
>  #else
>  static inline int efx_cxl_init(struct efx_probe_data *probe_data) { return 0; }
> +static inline void efx_cxl_exit(struct efx_probe_data *probe_data) {}
>  #endif
>  #endif
> -- 
> 2.34.1
> 
> 

