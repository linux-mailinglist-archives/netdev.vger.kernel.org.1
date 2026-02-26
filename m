Return-Path: <netdev+bounces-261485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIbgLNuGoGknkgQAu9opvQ
	(envelope-from <netdev+bounces-261485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:46:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C221ACC7A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 552BD307CDE1
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F5043E9C7;
	Thu, 26 Feb 2026 16:31:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022127.outbound.protection.outlook.com [52.101.101.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C90A410D14;
	Thu, 26 Feb 2026 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772123492; cv=fail; b=i5gsWU9rywzxzUtGVJxg8qL40lg3B3t74pZ1a8pWrD+Jcgu9SQaXYUYg/gtlqxt/ZH7sJ0CfQ8Zv/lA53jlqzSEmuNYxWiKI0Y2obZmIlUIOjnNVJmq6Y8N4SFazcyI2bgGT/Lm8zHSqBWQYWjWKqLH7P1IGF7drUMm5I0VYAs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772123492; c=relaxed/simple;
	bh=sDtwwtUS3tILPECxc/KORSbvvzzoz37f/YbTJ0LaMiw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=O6diPFKbgD5A0NE/6GzNC09Xifif5rg28IsilinRJVYhrI82rOo+IGj5SNNM8BWrSLHyQQcJjIPd2YQULLWbK6yEar/5k9WBB1EuavbMCHMvTQ3fogYALyEmzNl+6Vr5ss6tsi7tO0M1nJZ3aOBdRRpdVI5fmqBDzPSeQ4VKIxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueeDk0lTaXXZ1ezGkSz242vALAwrgWC8gsU+dDbazuLs42SobfJEcY8X9XR4S6/u1K9abY2jzFW9BgDJWztCfIQ5SChHu9ou9GlzgzXnJ/IthWUz4DXrjrFHHHhvdo0tB4di3DBGR1qk3MpuxVS9tk9C4UeG7HlpmNaXGO9iLV0r/JG3tAjM8bSBbWoZM+DQHruoYkHWvt2KkNuNAmmvQl9Mq5trb+UEWOgEhEBCyXe0v0uJ9m4fLpDw6hGSJ7uJ3hLs9JbfQ8H2D62R0lSZLCDga94C6eXzGsDMdkwVvnotsGAE3/pq4pdb40t1yvUo/Hq95Z3Jtzpqc6Se/estUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkRwvrHCvc3lIbvQg45W+53toXnaEEdxBmLBzgAO8Jo=;
 b=UnoDrNIB5kOuVV6lAo99qZaaFL3hv+XTuBKyf8T50JAjOujrIfACHjS95CLHvMR5RYm29cpVvpXauFSuAQgV+1cjQs/q29pk/jv1vwfe2uGQDuqaCBV5PTHJD2s3M9bMIG2En+AxeuX7BOX1hNXWjQ+hSOCgKc1xhH2yWffNzmbulMC5qnXPJTjT+Wsx/FofVZA+ilG+5wcfdbEG81Jn4oKENDf1wSONUiwhR26JbCUjtU4LT3AkgE5+aDCR50XEHLVFBnhhtcP7qk1zzcvp1MCY29FKcFujR3nPGXidByYlTnUHyiVaX243yeCgt+7x1Nqo4Qb8UW2+9pXNYPX3CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO4P123MB6914.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 16:31:27 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 16:31:27 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: ronak.doshi@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	atomlin@atomlin.com,
	da.anzani@gmail.com,
	sean@ashe.io,
	mproche@gmail.com,
	chjohnst@gmail.com
Subject: [PATCH v2] vmxnet3: Suppress page allocation warning for massive Rx Data ring
Date: Thu, 26 Feb 2026 11:31:21 -0500
Message-ID: <20260226163121.4045808-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0058.namprd17.prod.outlook.com
 (2603:10b6:510:325::7) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO4P123MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd0e912-d60d-4020-be84-08de75547d36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	DJgsA3kkwKWW/zHpZVMvNcl1vuKXCrL2ELTGZaKKJxWiVcVAr5PlOKB8y4Z6pp29T6XUrXF2FCICoc26HYSyd1zXIegWT2YSaSBz+7NeXw+epJ/RvnMGCFqCIsuHGrkRplJxQkBlEFjqJ95pel+jRJcojXyMSaUOAZfnE5V1mBfmubVwddBIhMFu6zwYOoovlE/oQoFlRCYDgZMS0fn+t4oftGyiNCMQU4vrvnEPG/kRtoifjHy+dMel4fsrfrWCkyFavlj7D10eHI5WzEOGV7ZcDqpiOsZ7xeCXcbg1lKwLR/B/gOQHXjlr1CwhOeQidNokKmTb136GKsFH9HWo4M+Jvq/o2LtYdpVDbh8Z0hrkoA5xNY0SSiHX4F9QAxY2qlyh8rkS7j9a9VwcdWABhzGSrLRPhebFPjMZZY9KlR+aO/0ZPKnoCNFhnW6mv4Cbd+x9dRoMitWJZbGbKrkO1z3Yq4Qg48AkD+NiTrtKkYqTaulzXCGSKRufJD5Lz6zeABvKf0TDfoOIyHMHGkN4Yfk2mQWN011lesmsZ6khvpgGl3q/WvfNWjFHYwqgUurvW+9zlkSO3t9Yb2D9fudbkUiqGr6dn4mrqF8nRlcyfTtbRa/xeaNrvD8TIhCiJT4vjAA4MctNprGL5kkxpaPv3TN8PQt4mcUd8igVoqJsslFKDK4bRqnwxpXZkKiZwLSApvlkrd65TF2Qs/+VK5oTKCXGgsCq8X951E6lS3UcRsA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?de8ecsqe8DupNFZavw9uWYCgLLb16HE/NUFcVIl4UHACGTPRbKFQt+WXEY0j?=
 =?us-ascii?Q?7rTH9qy0znxIdJJF8CbUmv7xIyg1v1mYid6hwJ99UX7phPOcL8G3BanwJyAu?=
 =?us-ascii?Q?6gYuby8UifKuJTAGX1aZAUBgtZKvijLW3TdCip7XcQFNCThP+pQPHFBNFrB+?=
 =?us-ascii?Q?BLWx+tYjqahA+rUnHw3kuhA2IlD2MgdA8e3+gQAaQHHnUV/9p4LwBZj4Tip1?=
 =?us-ascii?Q?ASlXsYcRLwV6ZxfmnWDispfnpsAZipMfrbIMVaJjxr8/LTXeOLuW9LuVP4Ht?=
 =?us-ascii?Q?AU5lvcMkrK2oX6pelhDl/q869sZOb79taNB1RIEpq3cPVASjsDVGSuENmZzZ?=
 =?us-ascii?Q?fOaEablv4U2Qu1TP608PJIoIUOqVgOoWB8nz/vRAqr6/Qdh6xbbk4QhoCMKM?=
 =?us-ascii?Q?vlLjxrmqEuXMrSOrLULifLXzw63MCzO/q+8is6UIEVbQ8KHZN2Wq807dauy0?=
 =?us-ascii?Q?MMt09hoAiJ+23QWboKm9jouPcm+69k6/MVCbvYDYCUib7uY7OcshTFBTH4Km?=
 =?us-ascii?Q?SBHReukBZjv2BFkBzAc/Iql8oWhSKBW+kZC1SlP4nvoZuhrjAX+zy5s+Rhvi?=
 =?us-ascii?Q?JwHOxPur1aptqoIqyZzvN6WR4ow5UOZF82JjPmAmYYznkzrM9YRWVTWLmVIl?=
 =?us-ascii?Q?XdtXaHREPwytQW6DzY/qpj8Uk9qJD4z53xQlTqX8PACqXYnXpwi5hkdJ42j+?=
 =?us-ascii?Q?77EfFGTAPc7QhOIu02BfsU6qfBVX4nI9561bzSPnZF4UL/5VKjkMq0crfOg1?=
 =?us-ascii?Q?NPE81i3Zkj2W319NakAZDZfTpKXwEu94sqiUUAB5jinTVlOMg3EBAuik5EdW?=
 =?us-ascii?Q?3rUQvkwwKa3R7kLM7fTFIQg26T2buA0bkwDMms9GY13OjwXOto9bG2+NasRe?=
 =?us-ascii?Q?w5viLsDNYZOq8x6y//scr+pR0mR4Nx9cf/Cr6Yph5TfTRzrwBiZlwPSuXHws?=
 =?us-ascii?Q?OkuH4rl3WJD9uzXzAhsldoJZsQZceKmdmBMUeBFfE7RyMN8d6tKhBBL+ZB8r?=
 =?us-ascii?Q?zVFhdBLJSMXo7tQFh66fjoKlSfhM5tODogDQ04osJoDiBD+6G0XU7NQXImy2?=
 =?us-ascii?Q?huv4El2VKxxoGzp2+MGi3c20DlAq3GPEcSByg8xKtyAE/C+WSZ1XF+3TghpI?=
 =?us-ascii?Q?wEl7aFmG248REmOg7CPnjuevKeUvtPLH7DmzChaiswARyWsa0Wd3FHYMeqz8?=
 =?us-ascii?Q?CnjE77asj76FFElreP7AiyCSLo5o4F6hDi5mUoNlvzeBcolxSECmqaW3Rp+d?=
 =?us-ascii?Q?KWceas3MBQqOwMlHbyTVfTzUUTA0b5RHnmTp8zFOhaoR57sWzWGQMLM/cUv1?=
 =?us-ascii?Q?1Vlhn9FnAtNChh/xHJbGB/agSF+m4sL6O7/l9+P0YMcPT10ObZoQgWFWNbxL?=
 =?us-ascii?Q?C3wHj/Hv2BviMcrzLhgZEoInBOkbOumo9Tw8ZHrL8NkJprOQdp0daeTx1mfW?=
 =?us-ascii?Q?cjTbj073E6Zn7km9Q72ypXwwTaUQPVf9gJpX6g827OGpWRzW4XVxvSZcYcGW?=
 =?us-ascii?Q?rnM1zO32/MxsNynLKej2QFjdqa+MstNFotMemuXatfyMJJ0U+A8qy4HAUATO?=
 =?us-ascii?Q?pXeOipFddjyfJC5Rl3YSbEYJgpDdzuRlygbcYS/V19PQXQ4P64JR96fVqSmf?=
 =?us-ascii?Q?lAsXjIal6LLKAWNLiIKFuV60kOZDKaTI1yzGuuir7ntwEuaIjEmUHRqEgrMA?=
 =?us-ascii?Q?ZdQOylTSUq9nQrHNWQw5O7pLchc5K3cPpxji2ILVf8xifkWCPoHlXvyRFPMQ?=
 =?us-ascii?Q?NOGuKN/naA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd0e912-d60d-4020-be84-08de75547d36
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:31:27.5401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4t68rcu2fxi+Mn+2tqmcBppBZinwr1Y+CwCEww9LcsGRp9kPonaNgakJDNobbInAsa3WCuzu4LDALdkdY+6MRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6914
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-261485-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[broadcom.com,vger.kernel.org,atomlin.com,gmail.com,ashe.io];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.874];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,atomlin.com:mid,atomlin.com:email]
X-Rspamd-Queue-Id: 73C221ACC7A
X-Rspamd-Action: no action

The vmxnet3 driver supports an Rx Data ring (rx-mini) to optimise the
processing of small packets. The size of this ring's DMA-coherent memory
allocation is determined by the product of the primary Rx ring size and
the data ring descriptor size:

    sz = rq->rx_ring[0].size * rq->data_ring.desc_size;

When a user configures the maximum supported parameters via ethtool
(rx_ring[0].size = 4096, data_ring.desc_size = 2048), the required
contiguous memory allocation reaches 8 MB (8,388,608 bytes).

In environments lacking Contiguous Memory Allocator (CMA),
dma_alloc_coherent() falls back to the standard zone buddy allocator. An
8 MB allocation translates to a page order of 11, which strictly exceeds
the default MAX_PAGE_ORDER (10) on most architectures.

Consequently, __alloc_pages_noprof() catches the oversize request and
triggers a loud kernel warning stack trace:

    WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp)

This warning is unnecessary and alarming to system administrators because
the vmxnet3 driver already handles this allocation failure gracefully.
If dma_alloc_coherent() returns NULL, the driver safely disables the
Rx Data ring (adapter->rxdataring_enabled = false) and falls back to
standard, streaming DMA packet processing.

To resolve this, append the __GFP_NOWARN flag to the dma_alloc_coherent()
gfp_mask. This instructs the page allocator to silently fail the
allocation if it exceeds order limits or memory is too fragmented,
preventing the spurious warning stack trace.

Furthermore, enhance the subsequent netdev_err() fallback message to
include the requested allocation size. This provides critical debugging
context to the administrator (e.g., revealing that an 8 MB allocation
was attempted and failed) without making hardcoded assumptions about
the state of the system's configurations.

Reviewed-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 0572f6a9bdb6..40522afc0532 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2268,10 +2268,10 @@ vmxnet3_rq_create(struct vmxnet3_rx_queue *rq, struct vmxnet3_adapter *adapter)
 		rq->data_ring.base =
 			dma_alloc_coherent(&adapter->pdev->dev, sz,
 					   &rq->data_ring.basePA,
-					   GFP_KERNEL);
+					   GFP_KERNEL | __GFP_NOWARN);
 		if (!rq->data_ring.base) {
 			netdev_err(adapter->netdev,
-				   "rx data ring will be disabled\n");
+				   "failed to allocate %zu bytes, rx data ring will be disabled\n", sz);
 			adapter->rxdataring_enabled = false;
 		}
 	} else {
-- 
2.51.0


