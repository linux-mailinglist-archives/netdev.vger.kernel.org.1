Return-Path: <netdev+bounces-98752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ABD8D2486
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 21:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA431F29DC0
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 19:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51BA176FA4;
	Tue, 28 May 2024 19:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="pXWpsaMJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2091.outbound.protection.outlook.com [40.107.223.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459E550285;
	Tue, 28 May 2024 19:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923918; cv=fail; b=cobRij1CZyWPQmt45AYkt89uj5mTzdZcSrBl9AP0hDQkx/yF4U/Cl8OPZxUW6ZG23TRN9Kj3rEIYrG4CfnS9jBszclFpogxRHK9W0lhRaO+GK4rthrxxttPe9A5J8nRKTfbUu72HYoqpy3chAtlAd8y1/lTZikef4iueklRGN9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923918; c=relaxed/simple;
	bh=yDVybaumJa9PVfk1Pezam8ITVgO2B+pSBKSrYKTzXTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ae2nzkwnYCDjfgy+xv/Uim4OzGJjT7PAwqynVdG2v+GQCHLwGZl5fMJal+9ISfEBNXHnK6udcTHMsG7Fzejz+lavFo9ENNqTi3LAsyTzufNCE0wF30SJ+yAcz7ixU6Mqf/SBLIm74conkmVs/eRJKDJODBY0LFnWGUKRaaq3Ahk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=pXWpsaMJ; arc=fail smtp.client-ip=40.107.223.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZdVlC3+aMHJ0rcZW4EuM9eL01s0IITezm9osupf/awGkMa1CLk8UaAbWhMMn3itSDWsuYVNn99QG6dJI9y7OjyTQya9HpfB+IDSDWJKK1LEVH65CS3oqXbiM2tyW0RCqGAS6Q8DBPyOTMLjiFCRnpfFQ1UeT6Q+SjKrTaqDvaAszEp6AJ46b/QUFFKCf9EuEARQqv7E9YbsC/eZ+0nQD5+S2Bs6lyS0wPnNyYbtmLYFtQ6W5kbbdoskIcZI2pq47pfXtFck59OenZW+9j7ahyJ1B5F3Hm6Urc6cZ0yIRrhK/KAJWauiBNnb2Bd5L46vorgdwrOjD00MMHHetpnw0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7s9zx4LhO9JWlaDrRNO7NBlyXoackNaEPwP28wCYR64=;
 b=PRSeW+wfCnBZLf8qKimukyWD8gqDMu+JbOUeJBo4z8VpuimgQ6MxPrcYnkhfHKQAE5ajPSom+rfND5l72usQBYK/lGp24Hm9tZ93GBQcHmjuKQs77g9t41xzAo2F8MFtcfTc5umrgk5B2TP/cwpP4u6hOTUzcabzsA68Wfur01d3Y0AxbwY7BIju+JaH1b13m17pXl18z9JyJhGo9Wv/+RKq3/UlT+xCiFzk8+FQMFSEiq5hMFoa1wpgEh3//wJZlfzhnB994hXdJlwOVPqZ9Mje0Il4lAqsYFmwdOp9Rw+S6rMEORmRur4f1xbw2UZgvnTSKdpSxDgM1ObQR7C92Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7s9zx4LhO9JWlaDrRNO7NBlyXoackNaEPwP28wCYR64=;
 b=pXWpsaMJUPiLXEIQNITD7m6PeXoZYJ56PuozMpWXOENB78ujPhRoaYD4x54yZhUglGdnwVaZu+SjqGYO/p7S1+PHtg+ZY3ouweK+duGekMLIkveWo1FTy5MwN+Z9J/OB+JF3akXn2X4qgtLfVz/+Xw6rK7jDaV1X4i43McaUsgg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SJ2PR01MB8403.prod.exchangelabs.com (2603:10b6:a03:547::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.29; Tue, 28 May 2024 19:18:36 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%4]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 19:18:36 +0000
From: admiyo@os.amperecomputing.com
To: Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] mctp pcc: Allow PCC Data Type in MCTP resource.
Date: Tue, 28 May 2024 15:18:22 -0400
Message-Id: <20240528191823.17775-3-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528191823.17775-1-admiyo@os.amperecomputing.com>
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
 <20240528191823.17775-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::32) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SJ2PR01MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ea64f0-aa52-4e94-43d1-08dc7f4af8d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|52116005|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vr1GqleTtlebGsmhE3tME+EdEGHGR5kCFWbXifX/75ymYEv1F4hLUBaIeY9x?=
 =?us-ascii?Q?5WrAj8+erlKycP5kHOVpx3+qzSEvfWlKyncDnROvcvh5L1gh+ikV/9ugEhAP?=
 =?us-ascii?Q?FI+No1Xz8alZrIBgcJeEmj+PtnHmifUD7Ie8GQxU7se7JPUpdi8KRTIiWSo/?=
 =?us-ascii?Q?oBamjoPhvT9GOIJSt2991fnW3LUOAVmo99bO9Ae49MH5nnit3PzvD6BZVDfh?=
 =?us-ascii?Q?33ZyZvdwY6QW8r3fhJgyOFab6FoZfkc9YTnFSrH6jthhUHNuSXXIMsNkb2lF?=
 =?us-ascii?Q?m8UrwHqtppaVOVwpSM/s9d808TbXslyZTO5yCb3Rp0VjrevugjOT4LANgMP1?=
 =?us-ascii?Q?B56LwqmTgNy7HQMSLsUhV1Q8zwf+xgb4U1PGmYMcjnLZyT/o/wymfYqmgM65?=
 =?us-ascii?Q?l+qSsG8yUPcBtljriRwP/qoLJMSYY0la8Ue6jA+Hg8uB+Q6Bs+SZgHaAfmTn?=
 =?us-ascii?Q?GjKyQi30YwkaNedmemCqtUG0Vg8SCX8KBNker9W6TgmYANiHS13XQWKR7Ppv?=
 =?us-ascii?Q?LKo/qqweS/8TnlabjTSLqyrTcJo17u8Rfg/Ff0ifnfhdvxnj5Zi91DMl55Ra?=
 =?us-ascii?Q?tlk0NaiKkyiqTb0NNkeAH50EP6YjumYp7UjL4N+UuHmrc1p0vTGiW7uwbNg4?=
 =?us-ascii?Q?aD2ip7sYQw2bP+HwmfDBoTFwRLgrkGdpWfc3f5Q5hG1UcZmnucIdKq5xKjeV?=
 =?us-ascii?Q?ZS1HfA8MoWe44SMGbCjPAWIvYMX2JdokLgIYlagvYYPglqM6N0IVpZUdGdFZ?=
 =?us-ascii?Q?+sZMXtRogKmWxSFDMKVXQHynjn/obq3nJ+2hnXftJifgF6xDitoo0yDwlk8q?=
 =?us-ascii?Q?GFtjahkl7uIRuHKvbeTU+9eRyh1wkKB3r6/pP7SQGgvIxbvS0y7uKUtikDna?=
 =?us-ascii?Q?FYRr27xuT5x2W8ml30q4pxqO8V/pyiKFTsB4IzAgQOLzKfVDOe37TamHyHI0?=
 =?us-ascii?Q?doKDOyzbL7nFgMrBco6bVx5HVP7Zm5XoPuWRB2iJv7J5hQzrgfhegQkZ9hBN?=
 =?us-ascii?Q?gxkepTpfgdy02B+2HCaojWG3HEykv25XmprbyAqCUjoTklquryfZ//pb01pW?=
 =?us-ascii?Q?vdQYPp7ovkYFpnomxXiCvp67efXycghaHiVGyganCuKXC6yqe+XvE7WuKb1Q?=
 =?us-ascii?Q?DMU82Mzp2ObYsSkYKUmSOJSCmfvq9oli1+giRJR9qQbqgAKVwj5AepWLk26+?=
 =?us-ascii?Q?iGCPoxbJ03510+J5jiQKHyIoEkc+0xXHo4QcQAu3XWNmNziD87GzgaAE0BJP?=
 =?us-ascii?Q?xytxewsyAV8Kg9zsDbhiHU6uxNSvgMSIhv2OHYj7ZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6tBpMs84mOGRqTGIj9R+B9byjSyUDGVfmHuCbwDyfAXL3ZOAKA02RHiv+FSV?=
 =?us-ascii?Q?F+e12EMvQyFfXy1+36lvZ1oUGKeQtFt3GDNGjVhmRyzKkC0S5XjalArj24Kx?=
 =?us-ascii?Q?EDnYIBgnQPEtO4Zx4h8gOax2MFGbciUrAKOpQiJRyWKA+vvQgsvEpMuKfi6B?=
 =?us-ascii?Q?z/uhzznGSvh2fhW5woCW92LFVQkPFaiLxNBsvqDTBK+A+qV0fC+9r9w7OS3z?=
 =?us-ascii?Q?LE3j63iE3tOJmqq44lMNtgGFXqNgqivX8gHhDmEf18bJO5dY+kf8VIHbS03s?=
 =?us-ascii?Q?n5AEXoq15CkyRrYJNASm6WKv8EhAjcK/RdOCgHS/Q8uY3mygtmIKsc4K97Nr?=
 =?us-ascii?Q?qIrvQyX4S1hKW4QNDkBcxbpmTaKzqTUNd+i6BLBDCztlK3qHPby/6e5EhQH9?=
 =?us-ascii?Q?Tnql+zDkUWItfyu/RrCfzRRM8tY0ViGTK2GkDFFxIEl5rU//t5DLC/2SJpy1?=
 =?us-ascii?Q?v+LJ+/mCelRTv/UMd5DnXBzGkCd32T8gdT2618fMskvQLbxneopl8cU9sxRM?=
 =?us-ascii?Q?YAAfYZwT6dYWBJqqsNze25sKuxv8p82ndOPIf7hbYpTt7TGp7Lfqbs0on1cz?=
 =?us-ascii?Q?vbOaln7xfykhR42YBKxLirStnLTMBzBPV8lDSxzcRnViq508LKou3NIUA9sp?=
 =?us-ascii?Q?4YsmpuNaxLWwWiodw6K85Z6BgT9iKWikXlJsgQB1TIenqnBH4GQd5jiPWz14?=
 =?us-ascii?Q?ef1Z0F4cPbL2POPPGTmxKBGSumsDlooiVpPURd5SRamnsgbJrRrOr9oovk6T?=
 =?us-ascii?Q?YrtGf6QGtYBkwiWDsUyMf+dGmTIw+hrstv5oiTMZPhKOo55k12h3NjnI1mRI?=
 =?us-ascii?Q?nCB2va4GrPxwFwsSXna4cWgR0wStxjT8bKf/hWcT24rT+1aOezgl4rP+1ccH?=
 =?us-ascii?Q?XhqRjZHhxPjzGsWdcwMWDukCH+9nEv9ekjpab2AmGP5jHicT/h4BkftIF6+q?=
 =?us-ascii?Q?yGtiXyOZwar1ZOmkeTzUF7HuNZsFFiC/Abq+oSWexBkH8LqsIe+H5QnAqXGA?=
 =?us-ascii?Q?l3xau4JRElcOlN68XNapuuzhMG6nLbbANc3S5xniSTIwoI1VJSUdlvuqBfTr?=
 =?us-ascii?Q?GA+e0zEIwHwI/XmcbEVN4sbGEcogWtPAVnPf2y7PL5RN1s7qwTUs/GMs0gIT?=
 =?us-ascii?Q?j21OWX4hRq+p1dq5B3WU3SCJvYjl0q0/FmJ1F8OKjouluz3t8Lb0mOF8qlfu?=
 =?us-ascii?Q?x0I/HzJCof8/sP7Um/UgB7boBdw/ripPzcO3XjDVEZhtNAdgDU0Hk1+Q3tCR?=
 =?us-ascii?Q?HbKcK73J6MZJckYbd/S+GTgADQXZ5OFGEE/3FVtYn36EfY0L4R6DijQutSCA?=
 =?us-ascii?Q?WYAgFeQE4G/cYQVfAkBO2yaJzYL+SynVsRdSkyYAraodyDdUbxkeLJ73Lg7q?=
 =?us-ascii?Q?te7C+g0mnbdFr3rgZMp28o0fA9C7toeDwzccCgrv+1EYNw9O+3Vxx/kENZFC?=
 =?us-ascii?Q?nqXIakhISQXZSQSIryAPP0zGy9Pc2btdFi1DtneoEU1H4RIH9h5tKNwBu3OQ?=
 =?us-ascii?Q?URb4beil9lEirIWJ/LH7DBaZyB79lK54clTlL8w0fJ8i5J/bj9COtFdKw6W1?=
 =?us-ascii?Q?PyFKTjtAMQnNielYPfRtRqVJeUx1qTs3rp0WUs8/FmaYXbVm3mam3ATb1Nrc?=
 =?us-ascii?Q?IA6F7hCD70Yxswzw3gMb2XN1U54IMH8/hR62kBgUwe6sDKBUOJKg429iBi5N?=
 =?us-ascii?Q?UBstuLeO31+rDyTULk6UpZGIVJU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ea64f0-aa52-4e94-43d1-08dc7f4af8d9
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 19:18:35.9589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcj5yOT9Rcwz6O+x6zmP/+CtoVnXxeeWHQgGSh/sQaAEHmZuq0GfPChWkn7OLZ7NHYD3wxU48Z0W2olT5uXnp5PXxt5MUPS4ebhEwJ1JlmQ8z6DGYng7TMf1oGrSJB2B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8403

From: Adam Young <admiyo@amperecomputing.com>

Note that this patch sfor code that will be merged
in via ACPICA changes.  The corresponding patch in ACPCA
has already merged.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/acpi/acpica/rsaddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/rsaddr.c b/drivers/acpi/acpica/rsaddr.c
index fff48001d7ef..6bd9704f17b0 100644
--- a/drivers/acpi/acpica/rsaddr.c
+++ b/drivers/acpi/acpica/rsaddr.c
@@ -282,7 +282,7 @@ acpi_rs_get_address_common(struct acpi_resource *resource,
 
 	/* Validate the Resource Type */
 
-	if ((address.resource_type > 2) && (address.resource_type < 0xC0)) {
+	if ((address.resource_type > 2) && (address.resource_type < 0xC0) && (address.resource_type != 10)) {
 		return (FALSE);
 	}
 
-- 
2.34.1


