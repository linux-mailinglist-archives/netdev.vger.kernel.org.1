Return-Path: <netdev+bounces-111008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C339592F40E
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 04:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 461A6B229AB
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 02:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7912DDD2;
	Fri, 12 Jul 2024 02:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ADNS8h16"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020139.outbound.protection.outlook.com [52.101.61.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BED8BE40;
	Fri, 12 Jul 2024 02:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720751801; cv=fail; b=bKYi6sD7B4eVH9CfvK+QXYkwmuH+osrK9yngDctAQ/gvK2ONlLCS/E+yze2OWdXn+3mt5AmLmxbxso0eAXjva7lG+tJnqwPr+PFTJFGvW9qWR9FqIO8uPazq6XVp4lPVbab/938cqfhW4yidLAI2/qxN0BgEQeF4F1fwxJcWv2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720751801; c=relaxed/simple;
	bh=7/mpKJqBj8h3i9RYk695nN7TEY3tyWK4mrNcWkOxf/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WWXUhXVYJc2EMEkOzmjXtcVTjK3HDNdKOUIw9vKoM6Y94SQRzXoDswxw9/7NDZkW7Jwg22FHJc8StfLphsMH/U1vgQsIfjAIvaPCy6WhL14jgSaDuPnCvKL08tOG58Z4mDMddoGnm5AFIVTeRChJvVy9iLE+5/kDYCsgxq5A2tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ADNS8h16; arc=fail smtp.client-ip=52.101.61.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcKC+ElvBJsBaVqtEShIcRGdrurplKl8HWlZyWn6OgQyKTbp2VICNGtq1qY5s5d1BChXewdE2PREieGH29cG9tX6LRY6dzaj7n3kyz2yx76lZEIIahbxIkf1EWw/3gqd00DIVT6mYnqd7UhcYWuxsUPwLtfvGCxAzbg/SoDKZGQAvxemPqSegK/0KJ0m8QhyM7x+zhDw7gtUo+DS24yX8N4MqOt/CpH/Kv3DW2MQc5ASyn0s5TVIsvTWkIgPtBzPJvk1jlatgwSqq1OUfgdlM4tO32wVMQd7D/ttG+RvDcESk72u+IqxMHZsiYri7gYqNu/uUlT1pE9nsqgTNgobkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLmDnb74UMEqmDUa7C4rYwRuOaILczcikPwDD0zqBM8=;
 b=eAhxBTA3uyodQYIRMjL91/u+VAaXbu0lIhbI5YX2k//3H4tnF9qbanyw0/f6Uk2i76POGzpeZgyfuQfNH/hgRBPgn5IP7D1eHuSiWMonfdJ0tVGK/11rH8LcCFPzxa1MDf/+VLVUbuHutsNc7guKBUlBkm8SpSbgnBWQaFWmLpwF5cFNLZcDf/t2kTUQ060N6t+OkRysy4MuP7dW8VggJUyjcvxlLPIHOUxjeE6DevjNSEmSke3DrYc27AOPkEfa3Wz2EQygYSvK54Or5uudGRdu/kisV7gro5VNXunm5RkaWJI3ThBAEflxh6MlGLjLkebIqKkG9GetlqdVLDlMAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLmDnb74UMEqmDUa7C4rYwRuOaILczcikPwDD0zqBM8=;
 b=ADNS8h16tQ/IzKVi3pZRVQUUa9lzWHPFZuqkxLjal6wng/cu/mgDEHJWgcTySB0E6LoSlpLiVz2HMSyDCjU/TebYcVwbzKwcMN2az1DqNtJt6u4uuMtI3gQiADSTowJnA58cuu9EU5hIJ05VAyv4gw7zzQCXJ2eFHyIwtNBeNFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 BN0PR01MB6990.prod.exchangelabs.com (2603:10b6:408:16d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.22; Fri, 12 Jul 2024 02:36:38 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%5]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 02:36:38 +0000
From: admiyo@os.amperecomputing.com
To: Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v5 2/3] mctp pcc: Allow PCC Data Type in MCTP resource.
Date: Thu, 11 Jul 2024 22:36:25 -0400
Message-Id: <20240712023626.1010559-3-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240712023626.1010559-1-admiyo@os.amperecomputing.com>
References: <20240712023626.1010559-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:332::23) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|BN0PR01MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e1daa92-78cb-4515-0d72-08dca21b7469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SxRNuK54say9cR37EskO0M1lBT1S7T1UmfXW63CuR93WpfXrI6rB8Cj7CbYt?=
 =?us-ascii?Q?S48nb4rLyW0fYlSHxsx/B76JaqDhACKHI/SI3NsgLVQwpVBpR45FMeiCGlny?=
 =?us-ascii?Q?1gAljuxR5uPJmHtElmMxuFB8ER6agJUsuyd81LOIyAMd9Do4IeGUVz0x/wOR?=
 =?us-ascii?Q?ZQZoepSy2/jumnuaeh+iXvthIVy6NZgzlAr+lq1FujlxxWpXY8exddjCJEMy?=
 =?us-ascii?Q?obeCBCxxkEI49ALbEN0o88dObKcd2l0mfe9Hpzry6FUPCE2wGAdPlkVMsj7d?=
 =?us-ascii?Q?4+6dCav+B/sIytmp7OuMX2YGS0/EMRaC2YydqY8s1LIP3lZsekhSkTpON8D9?=
 =?us-ascii?Q?Sx19s2dfLXZehSn4P3zCO36OZHNtVUCWsC3/2WofUf6OAJvpRCMCIgjaKnvc?=
 =?us-ascii?Q?2XL0SeiWfn/ilE2POZqNb02VtjG4NoDnqlss9DTEevk0kKx5OjQMYnwnQ3r3?=
 =?us-ascii?Q?05kc6eowF0wshjvvD98pak/R7+sgjrmafzER0EXb7OxjBoF8wfXLXq3msEUR?=
 =?us-ascii?Q?h+NuQE3J0gfy1oJpB4mwUCc6BeQTwWCUxQCU9oqxKiwA4dJVpHKdwZqzWeBQ?=
 =?us-ascii?Q?N6A7aBzpLMhIExtWsnfKUkeqsuIL/HZ7GGC/zUhv50PjTJaR3khhDk5rxNyd?=
 =?us-ascii?Q?Hopx9S1zkpO1NjxNgemTC/EAui7xBDFekcUM4Npvx38z2FYSHWVP0IQEqE7A?=
 =?us-ascii?Q?32aCmUaVbsEsGcEg5g9+MRtImZ8u4fMbAFejQf6+5mO3R+hsEDB2pRz0PvNm?=
 =?us-ascii?Q?bAmfJcWXqab14cD+gTTLiGbwGattcZcRKvFq60RwN8sJ4j1CO1O5hGH8csdz?=
 =?us-ascii?Q?YPA+mflZNxqAlppjNrRenBPd0Ozlmh3bKnh73HLUzkf5LjJz4RVYvNYCKeyC?=
 =?us-ascii?Q?afZV8RJPPyUfcks3dtfXXws5C8mI3hhNAaapT0FHYV5ALrfI1OFYNwSrk3gL?=
 =?us-ascii?Q?779/kHbmUGH5wg/NNTFda9N7uzCLxhex0YApwyx7jV13mte62gXYRkRExR+5?=
 =?us-ascii?Q?EmYtp0IFmdsgcnU/HQOmgdz2ObZCdrPYYCdmvvf309uiZWKzM+wPb1/slPhi?=
 =?us-ascii?Q?bBSuS3bODlQLSNlKYbdnuuAtMqaoaO2nzo/2SOxuFLjgTAzt/sxAtQIglTjU?=
 =?us-ascii?Q?03//6HSHl1egpntM0jKo9M6B4F3JbWV3mVmiR32o2HKM/30F7KetWqaqwv8w?=
 =?us-ascii?Q?eyqnM+1j0FW7QH/sd5zgNR+ip6FQMnlttdfdqybFn7zcc8xwfvl8n/aU3EMh?=
 =?us-ascii?Q?00TxACDBRJRVhStzQOhNKjS9aBwLIMMTda1OXaqc86MHMa5u894cGPFs0GW1?=
 =?us-ascii?Q?u7R3GRWgJcGwFsO20T4u2sUhG2kcLBjmKOeWWnnF0KDv7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dxJM7Ei2kwkJDCXp6fjQDcntXOYOci+ZhK+SpIjxdXN9Tb3YgPGecAILYzj3?=
 =?us-ascii?Q?zx6A2dmn3xwq/p/g0ZUjYdSgZEs9XJeItFhsiCcydTdM8M6olYLaOBAsxsRx?=
 =?us-ascii?Q?2jzrZ84tAHeIFeTT5Kl7ZDyhIcJB5kNDsAY5PAOIECzho1thAkOZWPrGw0r7?=
 =?us-ascii?Q?PSPo3QqoOxTEt5710rrMqJlGltvbV0fp2Y4oza7YySnfatS71g0lXVAsAp6S?=
 =?us-ascii?Q?JgKsMhHsBTzAW8OXNlkScizNeuGcwJ1TbWamls3vVEkEe5bGBysFjR5+H3E3?=
 =?us-ascii?Q?korduuKLvlrbn2kGUhkX4TOpwcmMLOOHpeGv2nnKY+VF3VhyDSX0kB/l1LSP?=
 =?us-ascii?Q?QcbtsnvYdWZWNNDbaQ97VcVZQjlzJ+HSmSyRd7OIHN+Mx+kb59nuFdjoRrJN?=
 =?us-ascii?Q?SE+uY4PLHd0p/jXewVA0/dRmlTIpOCjzLB/5AtA/sqbkef3j5/AHI4IoWTmC?=
 =?us-ascii?Q?dgbu5v/2WrEwQVEHdcfshCqtxxwcHpYu14EbFw3Ul1FpyEdDbNEVjQ89Tm7m?=
 =?us-ascii?Q?i7daNcpAOb6pQ86okc6p6ijVmGGP8mb7Yx0qFzieEYHsMfASNWoRWvnhspLR?=
 =?us-ascii?Q?MfRPA2EAV9fpBKqhzKsci52vkFFEE/s6VxvstjO/XEjcrd1BzU+C2E1jrIfm?=
 =?us-ascii?Q?B18Urd6HJKoYae0tSTBTt9Cf23ftQtRvPzvhsBwQo1uI7fDzVRSr0aQ1wB5t?=
 =?us-ascii?Q?oNI+r2G+DF4NM9k0G5LXP0htPyiVHWtFid6zTgKxjIf12wu6g+6uII/eo0AO?=
 =?us-ascii?Q?fAjXSvXZh0oUf2/HrFMIPN5exsBEHP/pGTGdYQMwO+kLX49gSzvlJihiBzYD?=
 =?us-ascii?Q?uD3ZQwgyRIXFB2KdgoOtk4DupfJCcLF3Jkb8Jl/0aHZa35SgSDQXQWBg9kth?=
 =?us-ascii?Q?mrOUatzZo1xa77AyIO4XtcA1HMAxQPyZneDf0MTH6oRFWjRYLSPMswv/4M4r?=
 =?us-ascii?Q?Hfa9g9dRjfKifkzrm+3TMdWTuI5YJopuYM1fP7X3Ss6cVMhtvB+7dL0OFB+k?=
 =?us-ascii?Q?fXHwUVZVj/V/g8a1pi40yNDkBNp12JUtWfS5HxIO7n5ufAed92ehCwPQTewe?=
 =?us-ascii?Q?3F/+NpLnwf3sfNA/FI5CA89Qdx6cCvkbENsR9uqhL/8pLJd637oW+7dr+7dp?=
 =?us-ascii?Q?korqnLNEbHqm4EriEo42G1nmRS+1oa0pDvJaIN7rYqEXKQ2UWTpVQPlweeb6?=
 =?us-ascii?Q?6EdsuBhMWBEzoJgNRIDfXph0PR87AsP/uYLi/qx8Aiasm//XZ0u95eiUl1Wj?=
 =?us-ascii?Q?bKb7PsX3iH2FpjnpHhvjLo9PoXHSgugSuMJGb08+haZgIciqQaloD/8QwUmX?=
 =?us-ascii?Q?ISDfbpsN3SimoZp4asfQFpWMHtpvRLK+xU2JVPbOpRJPq8yYopG/4njuUTsP?=
 =?us-ascii?Q?vg2COin296rv1nVzV1bfst1++2pGYppm2KvZjnlw98JFzaxJmduH+r4rpEWt?=
 =?us-ascii?Q?nlj32sHHtDB3AvLd2UwD250jAkt44bc+dG99Z23QX95RpO0fzzXy5kGoH6ve?=
 =?us-ascii?Q?Dhg2WIkNkBISUb6BH9Xmi2p3Cn/FjPaG86euQGmiA9l/glJPPmkdxOrYh3R7?=
 =?us-ascii?Q?+j/7UyQHpxTMdDfxMVK3GRMPzFvNr/KTq1huSWKxgSnRN2Wjnx9jIZGJ9zVK?=
 =?us-ascii?Q?qIHYJgVy4y/QvTT8nZM+Ub0OZbzh+tde6+3IWTYu9yD9z9of0fD4ZTbMeavQ?=
 =?us-ascii?Q?qrg4m7ybBfnrZR2doqEkoXkrpXM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1daa92-78cb-4515-0d72-08dca21b7469
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 02:36:38.1203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnySL2amWRVKjBezzcP/oq7SXWCFRYX9DHyG6UD50z222+dVqFiSCbILB+j/uhGnJgv8z7mX8ygAyxXp3+tmPfxmPR3odGgpPedTsUEdoQUr8txNoc5lL5jNGPu/8vxT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6990

From: Adam Young <admiyo@os.amperecomputing.com>

Note that this patch is for code that will be merged
in via ACPICA changes.  The corresponding patch in ACPCA
has already merged. Thus, no changes can be made to this patch.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/acpi/acpica/rsaddr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/rsaddr.c b/drivers/acpi/acpica/rsaddr.c
index fff48001d7ef..9f8cfdc51637 100644
--- a/drivers/acpi/acpica/rsaddr.c
+++ b/drivers/acpi/acpica/rsaddr.c
@@ -282,9 +282,10 @@ acpi_rs_get_address_common(struct acpi_resource *resource,
 
 	/* Validate the Resource Type */
 
-	if ((address.resource_type > 2) && (address.resource_type < 0xC0)) {
+	if (address.resource_type > 2 &&
+	    address.resource_type < 0xC0 &&
+	    address.resource_type != 0x0A)
 		return (FALSE);
-	}
 
 	/* Get the Resource Type and General Flags */
 
-- 
2.34.1


