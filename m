Return-Path: <netdev+bounces-228439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 048D6BCADB3
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 22:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC74B426038
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 20:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F43C2749E3;
	Thu,  9 Oct 2025 20:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xGbvZfi0"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010019.outbound.protection.outlook.com [52.101.46.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5625B2741A0;
	Thu,  9 Oct 2025 20:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760043382; cv=fail; b=myqODCJtmOB+6xUcDA0gZrmq9ZGEC68XL5olxTckHasA9uDDEdO/2ftX2UnMab0y67IC06sbTv5gf6FgO0N/8A1IV0E8+95fNYBiy1T6rdPqJJpp3AwMLmo45TewNR7fkWJqf4R9wTaOdbFIDiu1gaUnP2YK4K0bc3M3p/klbfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760043382; c=relaxed/simple;
	bh=iPU1ti2wEruLweNCg3UgNVZPEbzZAS8MPRheEK0UBww=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=JN77X6EwgeppQtejr4pVXRR6SnhYSzgzoZzUllv2G8YRNNTmz3420KGAqF3QQsAyy/EFcxCNRGmGIiv2ZNC+9qq/6gMNAJVbp9ioDsPMPvisy+IZZwYJ6iwfyHt/urn8vzYiXeI6ijiY2zpzjAIIqTKoRTk0aOYZjYLfo7vYLi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xGbvZfi0; arc=fail smtp.client-ip=52.101.46.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2K3cL08grRTSBvXnDuWPR6KXJUJ+vF95i+NLBWzhJEe19VZ2hbXHfsEplU0Lnnb5K8V4AfTfnEwxk0/DR1G8GUEl6N4jbsuewcNL5axvEf1TdLbPNY8V3TBysRmzmfuoJ1oo/wc4V2buo195JWhx0lm+39F9ve8msQ9dWmzq5hVY/Qc+EAfcq97aDMBnBTgYCspVvNBEvcL1pBir6yc1XcoR7ljIRHo+fEZFbWf1BkOODwJMd9qnsi99PrLlrqnzsY3yh/2gkMyfU2IyV8IuzR5UsWdBOG8fRNkc0Vk3xw0VfCUTW09yDyN1yb1w6z79o5jLLyNI15Pc/frVSNCPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psDD/BTUlC5nzidQCLGw/a5kYY0e0zJ79k87JiZInr0=;
 b=mi9Qb2XoVKR6JIFPAVsZiahGEKpkUbjPQYhSkKM2tJ9fE1TxuWoRKBqrXdbUJDoo3uy2loGNpHwYEZioqs4NYXzxMx/4BVVHQo4N67R8uWsbSQzWxzsQI4ZbbuPclL2fwHCWC6EqXs+Vp1kJe9UISygiDfFmYLDwjC+MwMYBFLkuFYFyGFgAoRSiq3shKhlOOxTZVaQyBeIrh3xYZ3JCXDL1u0AS0botK7q+Ke+qfZsOTfu32ouoeQdMui8YVt6aFQf4Fd5HMP9xRsKz8rISQbh7Mn6nWmDuSLL09h1aQBeNxznnn7HHyY5+fbI1nxYRvPzcWOBUUyLV5rgE3HjU8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psDD/BTUlC5nzidQCLGw/a5kYY0e0zJ79k87JiZInr0=;
 b=xGbvZfi0JORhAmK20JsTqjWag2ejIdKpZldAPtA9x5LFUJwyPBT+RGwHQ/C0PRIIcs2UEbhdwUo6WJ5ZKWztHD1lE0stFJRR0zT5C6LEzAvm29pC5wiQaxPDl/Sw3BXc6Pqm4henWX4EuMRA+eX1clm4WastdnSC1CX0XO+gjOk=
Received: from BYAPR01CA0064.prod.exchangelabs.com (2603:10b6:a03:94::41) by
 LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 20:56:16 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::ec) by BYAPR01CA0064.outlook.office365.com
 (2603:10b6:a03:94::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Thu,
 9 Oct 2025 20:56:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 20:56:15 +0000
Received: from [10.236.184.171] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 13:56:05 -0700
Message-ID: <c42081c1-09e6-45be-8f9e-e4eea0eb1296@amd.com>
Date: Thu, 9 Oct 2025 15:56:04 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v19 18/22] cxl: Allow region creation by type2 drivers
To: <alejandro.lucero-palau@amd.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-19-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20251006100130.2623388-19-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 00687d8d-b55c-4294-50d5-08de07764964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Si93MVM0cXcvcjE5SWhJTmRzOFlJMzNtUFBZeWRRNHpncmZOVmVTUjNpdVFk?=
 =?utf-8?B?c2s5RjREa3RjQjY4N1Fac09yWlhwODdFTWlqQ1BnTVZJUy9YejVMY1lWaGtR?=
 =?utf-8?B?a2laQlBKNFl3bXFiaU8xZWs3ajhUWGFaTEIzdFZQb2xjUFIyNDNWb2RVV0dB?=
 =?utf-8?B?WHpRQXY3MWZrOTNyQkdhVTFjNzZZclVHTjhkakhWcGc3WXgvN2w4NEoza1pX?=
 =?utf-8?B?V0YxMnpkNGtkSTB5VGV6bzF1M09iUVZlOEVmaHp2Z2pmbnpwaHEzV1VhMzl6?=
 =?utf-8?B?cmM3eUszUE1COUpoYXoxU3gwMFB4WnZ0T2xJYWk4L3BVcXBnMm8vYUZWNnBW?=
 =?utf-8?B?S09IWWRlK2dWemZzWm90RGV2Rm9xbUVpQ0xIRnlXejV4VG9WbVAzMjl3amFj?=
 =?utf-8?B?Q1I5RVVwVnVKZllZMzF6dHhEY3FqUW9EV1hmWlQwOURXbGkxVmE2RXJ2YmJu?=
 =?utf-8?B?eUxyMnlxNDZyYmZoSEdNTE9EQUJuRWFsTWtXei81dzBtRUhUYVVTSmNGanhu?=
 =?utf-8?B?M2x3V2JiR1EyMXBrSTRWVUNrTzVsMlBPVWJLb1FSSEhCdHVhOGJ1MStRc0NC?=
 =?utf-8?B?U3J6RlFHclFHdjhVTXlFcGVUOUY4Zm5xWmZHUlNXQXJPeVc4UHJsNThTclVO?=
 =?utf-8?B?czdEWTV3ZllNb1BMcEpqN1hWQ2oyRGhMNEh2Y3JEcFRuK1cvOUM5YVExdnVQ?=
 =?utf-8?B?Zk0rMVZJUytZbDZiSGJWUG16L0dzRzBzWS82TnAraktkYzZHZHVGV1RlK1BE?=
 =?utf-8?B?UmlnYWFQY29wd29Qd003c1JRQlhoWXFJY085eGtnQ2c0d1pVMkdFb29QQys0?=
 =?utf-8?B?RndCb3BoSW40emZ0R0twTXo5UlNsWWpQOUU3ZzNoRlV4YW9ic0d6ZXV1UTQ4?=
 =?utf-8?B?a1NXZ0lrRm9xTW82eWZTWUoyZURoUnV6azRhS3NuUzg2clR5anM5WVlWS3o3?=
 =?utf-8?B?RldZMVh1aVNIcklHYTNXNmxDNDh0QXZlRTlWbWhwNUpUc0xJbFV0cThiQU5z?=
 =?utf-8?B?UnhidTkyM205RHh3TGg2WVMwNVBHNFVzR0hqNTgwQ2EydUxVS2xqTjlFL2RP?=
 =?utf-8?B?d2JJdVByQnY2bk1teW1rL1QvUUtvaGhJYjNoZXViYWllazFZeWw1Y0JXYTNh?=
 =?utf-8?B?LzRLakdWVVBsQ1JLamFVdk1OTWUyMG5rRjBhRmFVTHV5WGxhbmxPQzJLNXUz?=
 =?utf-8?B?WVJJdnRYWWlSYkRoaDRtTy82b25iN1RlZTMwbjBuT013bUxkSGJBSyt6bmNl?=
 =?utf-8?B?cHlnTUFkUlhvUUZHeGFqbEZPbXlRcDFadW5PRjhKR3pMYVYyR3BjL29WeDZ5?=
 =?utf-8?B?d245WVg3OHFDMDJ5TG85OFBMa2Q0STFwTTVXQmVWTXFNWWJ0dlY3MkVCTm1k?=
 =?utf-8?B?emhXd0RoQzJLOWt6Q0M0TXJ4QndvUHdVV1hDUUxxVDMvdHZYcjNwa0ZBbjRJ?=
 =?utf-8?B?MHF3bEZ6M3IvVXM3ekRhVDJQb3AzVnYwTXR0eXJIOTdxUmNjQVF5VFppcnBM?=
 =?utf-8?B?dVJldFJEMVRveFRUaTRYMUpuTWQvWEd4M2lDMjdmT09ObnJ5cFJGMmpLM2N4?=
 =?utf-8?B?SWdBYVpGMHkyeVQwUll0K2NwZUpIcWFHZXlYZXZxeThkQmMzSWErdjJkdGRl?=
 =?utf-8?B?S29Ob3g5R1VoSElvK2hUaW5IbVZsdlZ6SURZVlIrN0tycXJUeHNoL2V6NjFR?=
 =?utf-8?B?MFpObTY4emNpRFRrSnk0TWMwMDFSUXlLZld1WkszNENFdTYvWXQwUVJmbXk1?=
 =?utf-8?B?c0I5MFZoVm1LOFdMUENpSmdwa0NTTUV1bXhrR3ZPMmo0TUxjWG96aTJzdWZF?=
 =?utf-8?B?TStKUVJ5Tlp1NGpZMUdXazFoT3huY2JlbW11TFVUcElvcTZGNngyVFRsaXRl?=
 =?utf-8?B?YmdaVlpOQklMOXc1aGhyS1lKYVJaZWxqdUp0UjZlMzJMaUlUbXExQVI0OVBN?=
 =?utf-8?B?YU5ZbmVHRWdwOFRob3BhSUdtRW5CcnlHVTBQakUvdDl5MHJvc1ZpM2p5Y3VZ?=
 =?utf-8?B?azRsWWVrUTJnQ0hNMDlIcmNWenFEMjY0QTlVYlJMaVhhVjNoYUEyMEFjckdv?=
 =?utf-8?Q?oQOopx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 20:56:15.0693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00687d8d-b55c-4294-50d5-08de07764964
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896

On 10/6/2025 5:01 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Creating a CXL region requires userspace intervention through the cxl
> sysfs files. Type2 support should allow accelerator drivers to create
> such cxl region from kernel code.
> 
> Adding that functionality and integrating it with current support for
> memory expanders.
> 
> Support an action by the type2 driver to be linked to the created region
> for unwinding the resources allocated properly.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Fix for this one should be split between 13/22 and this patch, but the majority of it is in this one. The idea is
if we don't find a free decoder we check for pre-programmed decoders and use that instead. Unfortunately, this
invalidates some of the assumptions made by __construct_new_region().

__construct_new_region() assumes that 1) the underlying HPA is unallocated and 2) the HDM decoders aren't programmed. Neither
of those are true for a decoder that's programmed by BIOS. The HPA is allocated as part of endpoint_port_probe()
(see devm_cxl_enumerate_decoders() in cxl/core/hdm.c specifically) and the HDM decoders are enabled and committed by BIOS before
we ever see them. So the idea here is to split the second half of __construct_new_region() into the 2 cases: un-programmed decoders
(__setup_new_region()) and pre-programmed decoders (__setup_new_auto_region()). The main differences between the two is we don't
allocate the HPA region or commit the HDM decoders and just insert the region resource below the CXL window instead in the auto case.

I'm not sure if I've done everything correctly, but I don't see any errors and get the following iomem tree:
	1050000000-144fffffff : CXL Window 0
  	  1050000000-144fffffff : region0
    	    1050000000-144fffffff : Soft Reserved

---

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 4af5de5e0a44..a5fa8dd0e63f 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -137,6 +137,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
                        struct cxl_endpoint_dvsec_info *info);
 int cxl_port_get_possible_dports(struct cxl_port *port);

+bool is_auto_decoder(struct cxl_endpoint_decoder *cxled);
+
 #ifdef CONFIG_CXL_FEATURES
 struct cxl_feat_entry *
 cxl_feature_info(struct cxl_features_state *cxlfs, const uuid_t *uuid);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 1f7aa79c1541..8f6236a88c0b 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -712,16 +712,33 @@ static int find_free_decoder(struct device *dev, const void *data)
        return 1;
 }

+bool is_auto_decoder(struct cxl_endpoint_decoder *cxled)
+{
+       return cxled->state == CXL_DECODER_STATE_AUTO && cxled->pos < 0 &&
+              (cxled->cxld.flags & CXL_DECODER_F_ENABLE);
+}
+
+static int find_auto_decoder(struct device *dev, const void *data)
+{
+       if (!is_endpoint_decoder(dev))
+               return 0;
+
+       return is_auto_decoder(to_cxl_endpoint_decoder(dev));
+}
+
 static struct cxl_endpoint_decoder *
 cxl_find_free_decoder(struct cxl_memdev *cxlmd)
 {
        struct cxl_port *endpoint = cxlmd->endpoint;
        struct device *dev;

-       scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
-               dev = device_find_child(&endpoint->dev, NULL,
-                                       find_free_decoder);
-       }
+       guard(rwsem_read)(&cxl_rwsem.dpa);
+       dev = device_find_child(&endpoint->dev, NULL,
+                               find_free_decoder);
+       if (dev)
+               return to_cxl_endpoint_decoder(dev);
+
+       dev = device_find_child(&endpoint->dev, NULL, find_auto_decoder);
        if (dev)
                return to_cxl_endpoint_decoder(dev);

@@ -761,6 +778,9 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
        if (!cxled)
                return ERR_PTR(-ENODEV);

+       if (is_auto_decoder(cxled))
+               return_ptr(cxled);
+
        rc = cxl_dpa_set_part(cxled, mode);
        if (rc)
                return ERR_PTR(rc);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 2d60131edff3..004e01ad0e5f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3699,48 +3699,74 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
 }

 static struct cxl_region *
-__construct_new_region(struct cxl_root_decoder *cxlrd,
-                      struct cxl_endpoint_decoder **cxled, int ways)
+__setup_new_auto_region(struct cxl_region *cxlr, struct cxl_root_decoder *cxlrd,
+                       struct cxl_endpoint_decoder **cxled, int ways)
 {
-       struct cxl_memdev *cxlmd = cxled_to_memdev(cxled[0]);
-       struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
-       struct cxl_region_params *p;
+       struct range *hpa = &cxled[0]->cxld.hpa_range;
+       struct cxl_region_params *p = &cxlr->params;
        resource_size_t size = 0;
-       struct cxl_region *cxlr;
-       int rc, i;
+       struct resource *res;
+       int rc = -EINVAL, i = 0;

-       cxlr = construct_region_begin(cxlrd, cxled[0]);
-       if (IS_ERR(cxlr))
-               return cxlr;
+       scoped_guard(rwsem_read, &cxl_rwsem.dpa)
+       {
+               for (i = 0; i < ways; i++) {
+                       if (!cxled[i]->dpa_res)
+                               goto err;

-       guard(rwsem_write)(&cxl_rwsem.region);
+                       if (!is_auto_decoder(cxled[i]))
+                               goto err;

-       /*
-        * Sanity check. This should not happen with an accel driver handling
-        * the region creation.
-        */
-       p = &cxlr->params;
-       if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
-               dev_err(cxlmd->dev.parent,
-                       "%s:%s: %s  unexpected region state\n",
-                       dev_name(&cxlmd->dev), dev_name(&cxled[0]->cxld.dev),
-                       __func__);
-               rc = -EBUSY;
-               goto err;
+                       size += resource_size(cxled[i]->dpa_res);
+               }
        }

-       rc = set_interleave_ways(cxlr, ways);
-       if (rc)
+       set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
+
+       p->res = kmalloc(sizeof(*res), GFP_KERNEL);
+       if (!p->res) {
+               rc = -ENOMEM;
                goto err;
+       }

-       rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
+       *p->res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
+                                      dev_name(&cxlr->dev));
+
+       rc = insert_resource(cxlrd->res, p->res);
        if (rc)
-               goto err;
+               dev_warn(&cxlr->dev, "Could not insert resource\n");
+
+       p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
+       scoped_guard(rwsem_read, &cxl_rwsem.dpa)
+       {
+               for (i = 0; i < ways; i++) {
+                       rc = cxl_region_attach(cxlr, cxled[i], -1);
+                       if (rc)
+                               goto err;
+               }
+       }
+
+       return cxlr;
+
+err:
+       drop_region(cxlr);
+       return ERR_PTR(rc);
+}
+
+static struct cxl_region *
+__setup_new_region(struct cxl_region *cxlr, struct cxl_root_decoder *cxlrd,
+                  struct cxl_endpoint_decoder **cxled, int ways)
+{
+       struct cxl_region_params *p = &cxlr->params;
+       resource_size_t size = 0;
+       int rc = -EINVAL, i = 0;

-       scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
+       scoped_guard(rwsem_read, &cxl_rwsem.dpa)
+       {
                for (i = 0; i < ways; i++) {
                        if (!cxled[i]->dpa_res)
                                break;
+
                        size += resource_size(cxled[i]->dpa_res);
                }
        }
@@ -3752,7 +3778,8 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
        if (rc)
                goto err;

-       scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
+       scoped_guard(rwsem_read, &cxl_rwsem.dpa)
+       {
                for (i = 0; i < ways; i++) {
                        rc = cxl_region_attach(cxlr, cxled[i], 0);
                        if (rc)
@@ -3760,16 +3787,61 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
                }
        }

+       rc = cxl_region_decode_commit(cxlr);
        if (rc)
                goto err;

-       rc = cxl_region_decode_commit(cxlr);
+       p->state = CXL_CONFIG_COMMIT;
+       return cxlr;
+
+err:
+       drop_region(cxlr);
+       return ERR_PTR(rc);
+}
+
+static struct cxl_region *
+__construct_new_region(struct cxl_root_decoder *cxlrd,
+                      struct cxl_endpoint_decoder **cxled, int ways)
+{
+       struct cxl_memdev *cxlmd = cxled_to_memdev(cxled[0]);
+       struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+       struct cxl_region_params *p;
+       struct cxl_region *cxlr;
+       int rc;
+
+       cxlr = construct_region_begin(cxlrd, cxled[0]);
+       if (IS_ERR(cxlr))
+               return cxlr;
+
+       guard(rwsem_write)(&cxl_rwsem.region);
+
+       /*
+        * Sanity check. This should not happen with an accel driver handling
+        * the region creation.
+        */
+       p = &cxlr->params;
+       if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
+               dev_err(cxlmd->dev.parent,
+                       "%s:%s: %s  unexpected region state\n",
+                       dev_name(&cxlmd->dev), dev_name(&cxled[0]->cxld.dev),
+                       __func__);
+               rc = -EBUSY;
+               goto err;
+       }
+
+       rc = set_interleave_ways(cxlr, ways);
        if (rc)
                goto err;

-       p->state = CXL_CONFIG_COMMIT;
+       rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
+       if (rc)
+               goto err;
+
+       if (is_auto_decoder(cxled[0]))
+               return __setup_new_auto_region(cxlr, cxlrd, cxled, ways);
+       else
+               return __setup_new_region(cxlr, cxlrd, cxled, ways);

-       return cxlr;
 err:
        drop_region(cxlr);
        return ERR_PTR(rc);

