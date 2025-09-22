Return-Path: <netdev+bounces-225391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2631EB9358E
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34DA17B092
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 21:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B8C279DC9;
	Mon, 22 Sep 2025 21:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tA6Winl7"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013044.outbound.protection.outlook.com [40.107.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206DB244660;
	Mon, 22 Sep 2025 21:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575424; cv=fail; b=Cg6K5lHlmyCpNn0K6TADe8WoM3Li6KBewXHYuojvKAdImZGo6GUbDBKxFXAVNsDlR+TTsga/wF7OkmjNxRpXCOF6fjnaBVFC1cS0TZDE+u+KDPefsXiV5nnAMm9+DTLbzXpPjFRHWqB1nPvnIvgyt2pjYkTxLhaIY12pTS/tKlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575424; c=relaxed/simple;
	bh=4CgL/CZhGyFUpfMBEFCsNq691buifC+SSVaqEy9PrWY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=u7OgqYVr9d5HiwvgTPotnQQdY3zoad13ghBQkmqVmZekilLm0m9JRALAfHcvkpyRCSDSRJma/i0CmPEXqT52QzxWDLRxpiqvO4s1uwT2o66plIPQZpOWhopXh3XvWxBHV54C+CsEqlwhHvMMxvFzNhWaOSTlshMcC5Kca8I/KOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tA6Winl7; arc=fail smtp.client-ip=40.107.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v02W5pgr7vF1TCrIDqfqBzcrWlVwWWjtpWdcXhk98T1cDqb/4MF1O7Hv8tTVnW7o0ihHx5tfhpCHE6Ql0/B2rFlizkK4U6HkznCDRfrkLXbNVJJ87C3g8vQfcIOaBm1+WssZXxNMsP3LYfu7MTcYzeEK3/sA++bZFJ2AaAzuAhzfT6K4m5qX13DvfgRPhsCriNQbSss55BH9kLZWAYf9iJ49SO52ilrTPRQk8+sKlu60ABMWypvRyxEMw7kCaTF1tGX9/B8hrwxbsptyQE7zFux070jZnuHzCOkKotOktscScCPEKLbkjrsc7/RsCmhtNG0QDOYPJeVSNtIlUlq8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+fVzq0YEokaXp+tAO+X9JePfP1NdLWWZko1f9BOQmo=;
 b=SiTOPnMwXpb/0fksGEXyaJTWW3qBSy4HGjRJ1e04VsExfNm5OTYYsav1R8zO08HEe8oUuihBl8wgnE5/eZ3cSZDxn7lINt4TjOXIZFsJlMhwsgFryE7BKpjgE76xKMHiY5ZBK2bDUTKemTVLjOGMRlpLpqB+V05isCHQ12yqqsZy3RqYpoSoxOYl8JS809o0nWpyi/IoSbCTagexqF6RFC0czdbi3WQN3YSF8n7xNuj7Ojf0A4f9MDrcG4vk7IUGA9t3X9lOdPjTICAL4v/iuBOGWXK0xjYhBkmAwyEfEW8Isax123Bci8vHB92+3wdzxE4y/yrMrIhtGBUf6EelTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+fVzq0YEokaXp+tAO+X9JePfP1NdLWWZko1f9BOQmo=;
 b=tA6Winl7sFl1VH9e81j6UCtuo94sTpf0hiEuiTqkwry+XzpPPXex2woijrX99ecBdNrDjbobN1yAXfrg8frwOuYgypd/Zi02WKjUWJ4qoOzH3i/rbyNPZTWMHcXDL7hIFoSddD/pG8ahx4yJqXrC/Ed6Ja3BM31PPBpkgvw6ad0=
Received: from DSZP220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::15) by
 LV2PR12MB5992.namprd12.prod.outlook.com (2603:10b6:408:14e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.17; Mon, 22 Sep
 2025 21:10:19 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:280:cafe::22) by DSZP220CA0001.outlook.office365.com
 (2603:10b6:5:280::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 21:10:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 21:10:18 +0000
Received: from [172.31.131.67] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 22 Sep
 2025 14:10:17 -0700
Message-ID: <acab1594-f376-425a-a82d-51df2e6bda69@amd.com>
Date: Mon, 22 Sep 2025 16:10:16 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v18 06/20] cxl: Prepare memdev creation for type2
To: <alejandro.lucero-palau@amd.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Alison Schofield
	<alison.schofield@intel.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-7-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20250918091746.2034285-7-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|LV2PR12MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: 466c493a-e5a7-425d-c504-08ddfa1c6f4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2JXNEdNdHJ3Z1duUDkrN1h2eUl2Q1UwTEUzUHNoU3FhNXVCTndiNTQ4ME04?=
 =?utf-8?B?KzVJYlUwWWx2V0hwRThSY2x0eElwMXZaeHQxZmYzRlhSYlovN21ybDc1ZkVO?=
 =?utf-8?B?YS9xNXVrSTVDMTk0KzE1WHlsWUhqbVpZQWpERWRDR1YvWnU3WHVSdkRwTU5k?=
 =?utf-8?B?QXVwM0pxcnRrNWN1d3hoMXlVNkNWY051NHNzdFMrM2VKNDJYbm5JUEUreVpH?=
 =?utf-8?B?V1BrTGFJOEdydjhJdmticlMvYUZURUhyajRYRloyb2kxaTM5dXd0SzlSRksw?=
 =?utf-8?B?cm1VM2xldkxVRUhjbktpR3hhRXEzL3VlSHpnaEFDdlQrRjVWSFUxU3BxVnlp?=
 =?utf-8?B?d3RBT1lGdGhuZGtlbWdXMHNVKzRXZFN3TU1YWVFKaFVlSW5oRDFsUC85N0pT?=
 =?utf-8?B?dWtKb3NWVWI4NTZSdHRFbFZ5aVVNN2NsQVJ0dnEzWHFST2lJZVByUkF1ZDR2?=
 =?utf-8?B?QWx3UGZBb2ovQlZqT3dvTDdwRTdDVGQzc3pQVVp0M2ExVGlRZVkyTDB0c09H?=
 =?utf-8?B?V0hPazgzSVI5d1VmSlBWT0x6QVBYNXJvSGdtVVZjTkt2Nzh0UzhpZ0JzcnlN?=
 =?utf-8?B?WHFiRFA2ZmVGeU4zSzk1Nnd6aklueHQ1TGNuZnhuU2xaYkNlK0xWNTg4OE95?=
 =?utf-8?B?dzFYSDh4NHBsYWExUkFRemxDU0lwTnhHN1lGbVpibjBDWmlqL3l1cVlHSVlQ?=
 =?utf-8?B?aE1XdkRDNWFqT2EyR0xVOWZEb3JmRFJtWGhhczdJMjkwbGNtMlRhY1piQ0Fl?=
 =?utf-8?B?Q2lCeWhIZi9STUViZ0JnYWpaM08zcHJKQjFTR2xwbHNlTHA5bVVJbzFUd2V6?=
 =?utf-8?B?RW9qZ2JobGswSmdsb1c3NjdUSFFyTlYyengvY0JISWdGeTNncnBDZ1VJUVBI?=
 =?utf-8?B?bTNzbWNiL1B6dGZyYlpMQ1diRmVsTWl0ZERQQjhpUm4vWmRvQjI2bmxOMTlJ?=
 =?utf-8?B?cUtoUXZ2ZTdmUGpoOE5sNlhQeU9MekpBZmJobjA3R3dZRktubndJU1JXT0hs?=
 =?utf-8?B?S1NTT3I4YnRhNzgva1JlYy9QMWVaYzlubVlKTkdtUExGN3JvVGZlVnVoTm56?=
 =?utf-8?B?cXkwZ3RtWTh0MWtNOWw5YUt2M0xIazVRdGNpTGVuZnZ2NWdKRjFydXBFNGpO?=
 =?utf-8?B?Q01WdS8wVGlYYUw1bU41VDFsWE1MU0l6T3pnS0tIZ1E5bzdKRG9JL3J2cDY4?=
 =?utf-8?B?RDdDRm93US8wZ25YeTlnVFh5RFBxbWZsQzd4dzl6b2Uxb3VXdTMramRLVTZO?=
 =?utf-8?B?VFJzTTE0akJuSmpnd014TG5ERmRDaFp5Z1p1MjZMVFp1cXh0Um9GZEo2VWVa?=
 =?utf-8?B?M2FIbUJ4ZVJXNlkwcmo1MmRiclFLYUdiR2VGazU2NW1iZEVodjkzTHhnQTlr?=
 =?utf-8?B?TXYyM09OYXpQL3NkWUVwZm56cGdkM21zREFORmlOU0lZWmk0Yk5ERzl6NW5n?=
 =?utf-8?B?SGZyb3V5bkVtcC9IWDBscWxhdis0QzJ0dTBIVE53VXZIclVRSzk3K3dSRzhr?=
 =?utf-8?B?MmhmOGFjK2JCMW44cVdBMEkzeW1Kai9GdGwvZDJYYnJGKzROMW5xL2o0bGJW?=
 =?utf-8?B?VUM2b2RwVUxPU1g4QjVxOFpoY253cXhQbEFXWk1UVlh5RHZBbm1zcVhMNjcx?=
 =?utf-8?B?dmZPTTZPQkllY210Qy9WVUlRNVZXaHNmOVEvSmZFZXh2cnRlWGxKZGJ3QTBv?=
 =?utf-8?B?bStPN3FGaWpMZU1ZRUhxRjNWV0hRZHdlc1BaTFJWWTlGQ3JuSExqdi96OE12?=
 =?utf-8?B?WVZSU2ErVGdWcmJ3U0ZVZGxjdHpYL3dQU2NiU0Y3allrd1k0c3dCeDV5ODhK?=
 =?utf-8?B?ZTFsVEFyVDRLSmUrdWdrNFpXTHVGOGN1dDdOSFgwOUtQQWF0ZkY5NDJNMkJZ?=
 =?utf-8?B?dGpSKy9pT3hNMXYzRGN4UlY2c1dJOFFhRXVpMlBMT0dVT2RtUGlVZmFtY2dK?=
 =?utf-8?B?M0xROHV4QXVSWG5VbEV0NzBhRkg0OUFZVTlBYUtsQUlpcjFlN05iRzBEMFBa?=
 =?utf-8?B?VGdUeDlaN0ZxOEV6OXByenJpcVR6MFRTVlhrSm9FWE9Udlo4WTZVRCtGdXkr?=
 =?utf-8?Q?6QmK9T?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 21:10:18.9004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 466c493a-e5a7-425d-c504-08ddfa1c6f4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5992

On 9/18/2025 4:17 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
> creating a memdev leading to problems when obtaining cxl_memdev_state
> references from a CXL_DEVTYPE_DEVMEM type.
> 
> Modify check for obtaining cxl_memdev_state adding CXL_DEVTYPE_DEVMEM
> support.
> 
> Make devm_cxl_add_memdev accessible from a accel driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> ---

[snip]

> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 7480dfdbb57d..9ffee09fcb50 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -67,6 +67,26 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
>  DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>  			 cxl_debugfs_poison_clear, "%llx\n");
>  
> +static void cxl_memdev_poison_enable(struct cxl_memdev_state *mds,
> +				     struct cxl_memdev *cxlmd,
> +				     struct dentry *dentry)
> +{
> +	/*
> +	 * Avoid poison debugfs for DEVMEM aka accelerators as they rely on
> +	 * cxl_memdev_state.
> +	 */
> +	if (!mds)
> +		return;
> +
> +	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
> +		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
> +				    &cxl_poison_inject_fops);
> +
> +	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> +		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> +				    &cxl_poison_clear_fops);
> +}
> +
>  static int cxl_mem_probe(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> @@ -94,12 +114,8 @@ static int cxl_mem_probe(struct device *dev)
>  	dentry = cxl_debugfs_create_dir(dev_name(dev));
>  	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>  
> -	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
> -		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_inject_fops);
> -	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> -		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_clear_fops);
> +	/* for CLASSMEM memory expanders enable poison injection */

Nit: I don't think you need the comment here and in the function itself. I would
go with the one in the function personally, but either should be fine imo.

