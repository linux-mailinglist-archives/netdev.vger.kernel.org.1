Return-Path: <netdev+bounces-105029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B9890F75B
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 22:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCABB1C20CAF
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13D915AAD7;
	Wed, 19 Jun 2024 20:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="drHIWSvW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2136.outbound.protection.outlook.com [40.107.92.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C2715990C;
	Wed, 19 Jun 2024 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718827569; cv=fail; b=CwUqkiZMTsIXmGHi7XugLxKlRGk2E17xJO4Kv/hZVbbSXcYosyUeyWhkzXVMaJ9NtEYhd5iR1ouoPhVJz0eAJaX9/kE0M+FeyU1DIi0QvdnSrXZXORzQIpNdjeLeTg7XkwkMEMfHpPAZRiAyokcexvtjuNcMwtpaUqN+UCd6XaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718827569; c=relaxed/simple;
	bh=+6n7XMOZw6uKbqbz/+NGjek1tKGEGd7c1pOvVl8S+GE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yhdcwz1r+gW2z7gCNpG7BXK627iuy89vS1TYp5mp9A5dfsvI1RlSFIKeyBnH5xyl8OdC6NGh6EJhCKMxd2MpZzWGx5FhwwJysf4UW+ps5dVknGrhEMdga9ujk6Ni8gc/RFXUWTu0t/PPzOp/dnl51sPweaWqnA9qPRpOxKKb2Y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=drHIWSvW; arc=fail smtp.client-ip=40.107.92.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOtHIlgASuofjhwJXxAE/Kb2MptlHpD/u+DTlemGqVptQChIYO71heQbyCX1V8kTjzOhnYV6eR5mvcLFAuSnQvkHU0B7M2I+bejVERgA7H9mwsOeSnoRdaeqmKgAc2ZoimE3qvkV2h5SAxNpTruLRlIf0UymCeYWixpZDPxft0Ay+2SMK1PsOk4eH7AQhMyHbjBK1mNdrvUxuhTw5eRJbldpAw9thqtxp/AnNV2s8mzq8Ll9thGusUMw/EctD3MxDy/920UHZcl42spRy09NRYB4BMBsr2P+W6xyEsl3n+EM/DURZW2ZWQczjwMCyzOpkZp7w8SsJvVRLvqFiPVLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q29wiy5+HBvTfdWDl7GntSBgtThBvZwXKEfvGZCKocI=;
 b=XvBd5Hj/t285zpLke7+DS957v9V8t7szJY2HxUd8OItgg1SU3nYwZDOdg7L5FdpeLLg9Y5AkuIsz78QXHMi9ToECkiwHEQaq4947F9cP/ZRh7X52fwQY41S490MWRSWcnVPIbuQRJDRDDQFQnwpDNvtAbQngN3sZnvxRWjgQjR8u7Fw9pntCSTw0Z2GGS+IeGRZbwDJh15YBqX1cY4irgDBVFUXffxlF06uVMVH/c8WPeTWEh9NrFZqHfUVAtDOOdaei3zRAJSByxOy3+Ud0FzehSSyckgCnejwtuVnfQKs1/auRFDoue7LWso+bAQWbzfTpailnJtGx+CJcn/I+GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q29wiy5+HBvTfdWDl7GntSBgtThBvZwXKEfvGZCKocI=;
 b=drHIWSvWZZ3UG9lrejU0QhaVoGgbr+BFguSg4wXTSBiP/NC8tbd5iFsVf8OVM6ylBQl2PuGRSD5KAgdYSHyYrmV41uGu496mvzSX/gjegD2Jr60ckXD5Fxbw0ggDHcOTthhxVwYZoYYjt1cRrGiBPLS1AmrjGP1AL1alM6uZBY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 BN0PR01MB7086.prod.exchangelabs.com (2603:10b6:408:14a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.19; Wed, 19 Jun 2024 20:06:05 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 20:06:05 +0000
From: admiyo@os.amperecomputing.com
To: Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] mctp pcc: Allow PCC Data Type in MCTP resource.
Date: Wed, 19 Jun 2024 16:05:51 -0400
Message-Id: <20240619200552.119080-3-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619200552.119080-1-admiyo@os.amperecomputing.com>
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
 <20240619200552.119080-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0100.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::41) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|BN0PR01MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: b545b527-801b-4d51-b44d-08dc909b4045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|52116011|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i5mx28Gwc9tuufi3Txf0FqPhNxPgRSPTHFlt51xAdJrzQyUF2L0ysYtmyLoe?=
 =?us-ascii?Q?fjYVc+T6y91B7GfOaP/CSLFk5oYXJZLfHxM+jgTh/QeHoKGPsZt0SFlJX2vS?=
 =?us-ascii?Q?eiT4QYkUEdSPOasCnEx9LJ9ATWyieqpGy6wx9X+f0x1wEFxJu87hJkovl5Cj?=
 =?us-ascii?Q?v0U3F3P3No/60OP3Sffh59srVrvSDMw8yp3wZ0XHEc/JNhVwAyBSnP632sP+?=
 =?us-ascii?Q?Ky7S6gFQ7O94TAhWw6b671JCUyTENKnm00OrHpEiwXToVvWHa32yU6TgogOe?=
 =?us-ascii?Q?hEU1gsDFecoWhFvK9zTuYf3eoQfx999DIhK+5+idRgUbEeLPeqjmmaRDyS6A?=
 =?us-ascii?Q?+e83wYscQXEbkOFNLP3XszxvRZP5fXlH0ImD0UcrtfqCoLibtcDCOp9wfI0L?=
 =?us-ascii?Q?BJOdk/XRcTDsPzYEc+yrxFiPin2FdKdDWex/2GtC+mNtHars9wSy/uAbtUv6?=
 =?us-ascii?Q?e8uPJ/DcL3aSVgxLETvPWDfw9tg0zC1MpIVprJKKegxmSnZ0wdegQeL3h3bo?=
 =?us-ascii?Q?es6dxxHyKDESWzSmTbW8PS5jfkNIbV8LEiImRHlb4w2yzwGG0ylddCfMvyHe?=
 =?us-ascii?Q?Y9IBSQgzlLB1uW5nqi2DJ9J1H6/kXnbVgMscqJtYCIJbBpWjRV5i7ngApB3h?=
 =?us-ascii?Q?DEjc2EExYOar98ni6vJm2Il92ddc/dsu3zs4TDk9DEpnonGpV1mfKoaHo8UU?=
 =?us-ascii?Q?bBE8SINO7kC26CQ8KU5NCcrQ/QD4DkGPvU+fN1m/BgLHOyysAI++HrBy6790?=
 =?us-ascii?Q?1Cw9QYmgDjL+yc5PLypRSwd7qQAzUD/+ujM6An01mSeqIXyktRX2BLzKZEUk?=
 =?us-ascii?Q?59qxu8yX+LeejwO/0gwzm4errkzywxLKG7UTSPmTlwgCdky56bk3sbWruOBe?=
 =?us-ascii?Q?qNNfMKExSWaZyE9U/yf5BQH1xRykHFKzHK8hbN3q7SS4XU8dXNMe6QYdtUXN?=
 =?us-ascii?Q?dM8eeXoEg9jautbZcnOV/e0kckz1DwPjlOOzJ9uVmFLAAMSOfckZCtI3Aa7u?=
 =?us-ascii?Q?Jjxh8RvGlEjNNDjou9V9/vA0Vplj+odt/MG4PkyMkhtelb2mNQ2hfW+Bi0CW?=
 =?us-ascii?Q?ppAbclOIEsU/BPAHuD4XFUQMSL+eIY2wICirulF3quJQCk+OkOW6JsNUq+aU?=
 =?us-ascii?Q?KQxBAoReV9kpMXjtUTL3V2WqU9sHShSpwmcHuRaK+AQjmUsHHVu6NAKrOfnM?=
 =?us-ascii?Q?VAcd5XBBX8gpBSvMCt5LDbiwcDDz7pj0AXT6inBRkr/y02lLYWfyDy+XL9SH?=
 =?us-ascii?Q?wIYCbFS1CWtk8wleNzvrBPl6x376WZCcQC6Cp3/SHd9VFSbJ0avX3+pC0vmW?=
 =?us-ascii?Q?FvI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(376011)(366013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HR32AVVONK4NJST0Awb/gmryFgu8QOSNxEV1UFuTTFDR/Ih4Ntcg0CbJIFF3?=
 =?us-ascii?Q?FiuhYKpD1UwXeeLiHUUzg1JSJPH9CT6YXY5uPQrHOXLczm/FH5oaVW36lHiq?=
 =?us-ascii?Q?RRWgqTBbAC87no0ZR7JrERb8+Jij9uBEPEOtP8lWIV6Dtw28SjfLXU6TGGzA?=
 =?us-ascii?Q?KZjdhA/s1spBJhkBrR7iAEtJAbxxgc93eSvVidtb0W8AIILBgPnORhVllD2p?=
 =?us-ascii?Q?Qa2cRdOrbUiSBNs+61IDecUjWCVQhjqzMHEs/hOuuyiWAUcgtr6lbwHX3xXu?=
 =?us-ascii?Q?WpqI/faCuO85zpPQZH/hfl86vLuX/Fc7fkKTF5Ei/QeEpT1rpwhaXxqe9vpg?=
 =?us-ascii?Q?ewSsjT+b63lGTyef//DFa/ZZWff5BVp1/6Y9S6Wi17YQ18N5RW/9AMsR4Wbm?=
 =?us-ascii?Q?Q7G0pxUExKtA2/yPKBYO6UnNbSRuB5xu/DdkrGsietGVbqcFA02xcTJL8dVX?=
 =?us-ascii?Q?EEO8H8ycCu0qBTwZ/08kCX4rRXhydSCzx6W+6TYFR48gN2sGVD01TCRZMqXr?=
 =?us-ascii?Q?UXP5RP/ptinANIkRmO/I1n08ybY5/W74oOsIwM2TehX+A88IuBhiC7cwDUYr?=
 =?us-ascii?Q?sYgMN0wgSenrWuDhAHeAICvawEdT+xj5jtkW0ao4NUwEz4DKTvE3daFUVeI6?=
 =?us-ascii?Q?JWxsRbjxXeI7CbXvThCakLGvsMebek9oo7/6m+J/zj8qFUJJ99U4bJ2Z4fTf?=
 =?us-ascii?Q?aH7mPZJeytgY37B+/ZC45jqoeW38OJ7mJRr7L7BksDzdeBKUEf0Z3uUkORsC?=
 =?us-ascii?Q?5FMjT07TRDgwWm8ugVSd4YYcWw9kCtTX7se0rU6YXJvFgG8/WmD6si2Z/epn?=
 =?us-ascii?Q?dA0UIMdtlUmAhDx/sxjoGuF5NiEP00/kqzijqRNd6WAYUVt+Qv1l/jL5Jsy1?=
 =?us-ascii?Q?pKxd0fS1RUs0NZa5tqMUH7tCcNsjbCU8MmiGCo5LtEUEpOvaIOM4Y9rg8nwz?=
 =?us-ascii?Q?8yEOlGqGmWEdBKCcKSL4dz8Sc6fRDt+LzIZKdzQxbXcqEwaEB9t92CP0L7Av?=
 =?us-ascii?Q?c67ZDUeT81c087EcD3o/I/NM3kXFLzdNc1/gmS/XHaluuZjDptuuiB4Aj8U5?=
 =?us-ascii?Q?bO9e5rjtDpmCORcI4Rro4Wb7BmgCZd5bGVI5TvQzap/DwVs4TGV5mvdP3egc?=
 =?us-ascii?Q?kgAFTsC9C4dzBirWQkE/c5nF3QobHlx+glaH6Z16uLAst3eVYizmlaZi1Ta4?=
 =?us-ascii?Q?uAeL1DWH4GPi1HkzDyFVJdgStzTw1uuCinym3E0meduNZZaOUscqTviFlwCW?=
 =?us-ascii?Q?h/R5eBoNnCwiSqbTgbwJCVuslNbkjGgxvIVjuL0gl3KluU89RBYt2de59mEj?=
 =?us-ascii?Q?g+6dqHtgdamkF3lFa8FN5aHn9FPEcEP0Hw16DDyMA/kycP0yFsVYgIhUv4mW?=
 =?us-ascii?Q?X3dFjJUgtpJb8htCSz3BxWdFBnRh8A4KYFVsOUKNQgrvq4LB80oTjIZCjLhg?=
 =?us-ascii?Q?vB+jIFPWZfXpX2KvRVOkgCSyWe3DMBwcKf4CLbdpRLyk2i1BxwWLz0CoYFBK?=
 =?us-ascii?Q?05dyKmiBndAKE7Iw+hPqzfZxSWBZu7ozGENbazd9pDQMEkqUbrq+7dNguBW9?=
 =?us-ascii?Q?pMscyHVPwwGeSz8XwalibKbdN4+xf1plX2Ll6FKwJNOd35aT6BLlteG7fRuN?=
 =?us-ascii?Q?PynUAC81ehl5l492nM2lwd1WLVIjpK+K9r1OYgEVayxFjOjwPNTc/gz/mSh5?=
 =?us-ascii?Q?ERAOgFLorerfmCgEq+c0zPlb7xo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b545b527-801b-4d51-b44d-08dc909b4045
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 20:06:05.3083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvaUto4BWrZhT81AEbBftwf9xGqDqDjC9+c+Q89KJ/rrhxd+A9PESpeRkDVOKKL6BUyrB979StZoNdCduKyveej2u5jlFJCNXZv3kwdGHjgHD0yx5X0pgipWNt2IKOe6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7086

From: Adam Young <admiyo@amperecomputing.com>

Note that this patch is for code that will be merged
in via ACPICA changes.  The corresponding patch in ACPCA
has already merged. Thus, no changes can be made to this patch.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/acpi/acpica/rsaddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/rsaddr.c b/drivers/acpi/acpica/rsaddr.c
index fff48001d7ef..7932c2a6ddde 100644
--- a/drivers/acpi/acpica/rsaddr.c
+++ b/drivers/acpi/acpica/rsaddr.c
@@ -282,7 +282,7 @@ acpi_rs_get_address_common(struct acpi_resource *resource,
 
 	/* Validate the Resource Type */
 
-	if ((address.resource_type > 2) && (address.resource_type < 0xC0)) {
+	if ((address.resource_type > 2) && (address.resource_type < 0xC0) && (address.resource_type != 0x0A)) {
 		return (FALSE);
 	}
 
-- 
2.34.1


