Return-Path: <netdev+bounces-108622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17F6924BF0
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 00:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0018F1C22599
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 22:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B2C17DA0B;
	Tue,  2 Jul 2024 22:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="W9Y01a4O"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2134.outbound.protection.outlook.com [40.107.96.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB81A17A5B5;
	Tue,  2 Jul 2024 22:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719961143; cv=fail; b=ZkQO+tNeADC8wlHjr1XBzoyWRQtCBOL6QsaYCnYPeR8J9409Z0g7BdGzN9HUkFMaDMDu6krci3Y0RLPR4+lzyxXjH8jSac2AaezTkpBRlb7x+6cOMPkTHWAuVIALz26SpJZmdckLaY9GsnfCrNRAlvaveKj1dmKoRVaAW7kFJ2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719961143; c=relaxed/simple;
	bh=Prc3nTiN6hPUlJ83ouhK/B8iS122jeVWIy5nma8R69I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sln+wotjGq9Wxlj6/YqM0PdoI7qSz94uSI2mzP5xn5Nt7lT5xfc6RjgVFgyE1zYwHbh7x7/I4kFaOwKJEOVkxKKj6wgIuJvGYR5kS4tZm8+q01CUr6zkwMaWPGQWuBYFEQJ1Boyo3YRjsa4sH4PWfC03MH8Fzjw4B1cmo/igw84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=W9Y01a4O; arc=fail smtp.client-ip=40.107.96.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTYTytgwXuuE41CFdUuxGHoiAQxSoPnF2fwJi+LdYxbC/OpK4TTwyF6MNDAIaR8rRHzvlNzXnYmlU8TEkfBlAIpTJfxM1ARqrIH6rdM4FmlcuXzKu6+I0+dus9GHoN0kW7wOYMTzv9q8Wp3dXtRKHKLOmpXyc5hJ2xGGAoZijwUvya3o73tmGHeTEkvYCK0g1jhLmxJv5+Lw9DHRZlYFxMbT8tOVE3Js4/g5eAR+MuMqkLyPChx5grGi6Tkg0dde626V9oDWr3tQEmgLCZGuZkB9RhotAGW+nsFAzTuDTj4vtvjKUNfpkYOb8ET74AmDFbsYZyhDmNnqvPzBPHaNtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9ozymf2A9g/ABaeFwuYTMsR6Wc3N+gGkjAu0uL6FsQ=;
 b=BmNpuRxn8NnU03bbfGpMoLk98/EQgDPrrIThbzsqhB4WXXuWTKgp1gDXDZhWpWRTvf9kMTTHozQE9HqGRSjg3Y9k/O0BnROSJ9Yai0pDddYZnW6osQ9JE+/EAtV+d23fLmYYNrMGoTObBwPyCJ3K7VLyI9SXZLBB1irXkz7f8O9LcxPfX78qxR7CMVMKYriwFlXKsrjDM02K6jEOW9A1LdG1TIFJz11onH8unYwFr+IpPfDMwMrsV2ZHWoZDEDBBdVXOD/Wtxm6pKI54jS5RrYLE4zLmuAoXx8hLWUEFyQhtuoq5U+K6jWbAQk0r5ibPjO1OzG6L9fLSPkyI7AfcrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9ozymf2A9g/ABaeFwuYTMsR6Wc3N+gGkjAu0uL6FsQ=;
 b=W9Y01a4OLQqIixXdS/jiq6ZBpWhPzyks53cG6e2aZs3mX9g4vxmgLV2xvBWumkFP1Ths0K16zMSR+/FUICqmxaANEskECEsPXOq/6wICACUiOsXXbSt9ayDctEVOvIE6Lae93HI9qawjIFDPicH/XVcmD7Ev1RTKcpuc8qG380s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SJ0PR01MB6509.prod.exchangelabs.com (2603:10b6:a03:294::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.32; Tue, 2 Jul 2024 22:58:59 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 22:58:59 +0000
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
Subject: [PATCH v4 2/3] mctp pcc: Allow PCC Data Type in MCTP resource.
Date: Tue,  2 Jul 2024 18:58:44 -0400
Message-Id: <20240702225845.322234-3-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702225845.322234-1-admiyo@os.amperecomputing.com>
References: <20240702225845.322234-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::10) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SJ0PR01MB6509:EE_
X-MS-Office365-Filtering-Correlation-Id: 9541bf73-2014-4746-8955-08dc9aea8f46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8g9VAGSjX8YmPkn8RsQJ6r9SU5UsA9Ujn+7papoNahtZbKAVIcejsUEUlmCf?=
 =?us-ascii?Q?h4tmkgmn6Q+qcqlVJCzfwY90FAxrO5Bn4iIAeKLUx7j7kDoCrYk/OVBnPNI5?=
 =?us-ascii?Q?Rpqn7CS8ssgRrA7NCc5iSnvBGQ8YnyYBRuboyFDOkanDALte8WO5idMfniiX?=
 =?us-ascii?Q?wKhhU4S/s7E8Wy5IhLkqIyIG9SiI2r/JDynKmnzYBumiNQJmTiBacxRYdyGI?=
 =?us-ascii?Q?xA23zqOXTX9Pmvm9tfnUZn3SQdbIXpD5/aCVXbsry+8y+Ux6P5JIRy78m8gZ?=
 =?us-ascii?Q?WAjcs18xtzVuZgA6H5UyD5r2peXd8xpjI1+h2+26LoYF8/Y5QWaxKEh/HYi5?=
 =?us-ascii?Q?iZvfhWKaHZoF6xsjdMlQdj/Mnf5ukJQvvgAA+6EmxxjcRaxvS/4lMgLo1wob?=
 =?us-ascii?Q?RSJCS3VzTUAdUN3FGdoWP3IbiRwSJAyTYvTAJqj9Xm0Jdy+IiB1ZfojR+J0f?=
 =?us-ascii?Q?ePkNd5vO+WjFS8bKLhP1n1QKDr6E0iESBeapjUmwaNUjtbk2FmiKeDobl85l?=
 =?us-ascii?Q?2SrcORGpsSzU3qnimZDRwFy3EalTKyOnr+VanOeP4x3vtn0Ym1pVYyqic8kW?=
 =?us-ascii?Q?p98iPjhVzhW5I4LXlzlZ7Yi9pLzhtBACQaa3BkpXbHWtmr7HocWaEIA553Zq?=
 =?us-ascii?Q?Up6Wy+KMqDiOP3R5QCP6tVQiyvLQ7tG2CoJgPxMD2HsplyGAeplgTbuv+Xvg?=
 =?us-ascii?Q?z5rT/qSyGk9hZbNiZj0lPEbEMIf7/G/RwB6IUtZmkkBI+jnES/IodM+l1bDc?=
 =?us-ascii?Q?ZHgAhVGcqaDEPCeIfGrKaKHIBb803HINo9PcoLWlTZjU9eoIru4Yts8LcU8y?=
 =?us-ascii?Q?dX21aQ4iTSgRowWKNp3HGzeQmKoxoRZw5/nCteg8LcmqPKOWTz3FxQujzn/Z?=
 =?us-ascii?Q?jwSFfSXkNG97QFli8mhw6Ab9dufed8060/lvKMK8up3m8mq3jsV80LNONXy6?=
 =?us-ascii?Q?MyrbWGXFOF50xshRBEaDmT0vP1RkrBo9FhNZ8nSxU7N5wdoWhTT395WUSUPv?=
 =?us-ascii?Q?sP/8i9SOGDryMVenw4/Wq7zJkHSkHBkg5qu/spBhEHuZdp5F2uE2VHYr+lDA?=
 =?us-ascii?Q?kCXdw+qDNXlgeBPNLeKsb8hhwnSyFWQCmlOGmTzvCuL65CohueoBXJMNxrIM?=
 =?us-ascii?Q?VvBzy7N1o0/inYx2FmLFeljreFyZZmLkRD4H82eKeu5QBriJiJisUTuGuTgg?=
 =?us-ascii?Q?UNSwtDZasgAU2zmowpGF6LU0KZFQ6E3q1y3qFJFqmutMQvdfBYVVv3SpyVD/?=
 =?us-ascii?Q?DMuSmtSgNa1m8dU1FyieF+kcvUp2u2gTK1PmXPmK/kdFS8QANjQKtJCM+KN6?=
 =?us-ascii?Q?o5/cGI3PaoKMlighCwPGo6N/sFyxk5nxERVt21Pl7eLakQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EoV1jnOrzhYCdNNMGp6QjETWB7FKkOSWltwgdd8H/sbuysC8cWGAHoubTuqs?=
 =?us-ascii?Q?J1BLfzctOmG3dlEbLIVLohmhBr7RjQd/IwHmrYbASKY/gbZU1r2tcUSgBH0S?=
 =?us-ascii?Q?P4Tr8g360aGXFTULQpLDR2yNoh1X9hr3InFHFeEqd8RPsdPjzUots2iTV+Z3?=
 =?us-ascii?Q?zODX3vnMXpCojgL8zYLnvDBSZosjQPxlTA11TH8cckjmLA7uoqREdV1DcICA?=
 =?us-ascii?Q?RG0SP/PlpFo3+01wTF/K7xKNbzcO6IENWGr8fUORhz8mIPXglRqNMIe1q2oF?=
 =?us-ascii?Q?UY5DuaEqgzHPuhtsTWATAZ6YPZnthsWs8cFYCDvceFHx5jPr8oSYwMAuN3MQ?=
 =?us-ascii?Q?2Ha3vKoon3AE+q48cYrv4rQKk4n4o/2OeEwy30uRUF7hqWB+MBmRGb/SA3Dt?=
 =?us-ascii?Q?lZSlYZIqaHkrkFiDSuWPn3FRNR2J7Z+mKypt+IUsJmiKeOeftWqzC6geqn0/?=
 =?us-ascii?Q?k3wb2jJK4jQNYCHUapgdRO6S9rTj7gECpR9VdilfqQmSsqkJIP6j9wXHfzV5?=
 =?us-ascii?Q?0yDqtrH8cTO9Sr7mLhtAdu7MOVYLloqwCK7PP/D5RKNP4A6zgh4DcgPIADQj?=
 =?us-ascii?Q?W6qWcq0fwD2N/nVKm0ICCrKn+t1C1r2TiRX0heutW1wOAmM9Y08n6LypdZXF?=
 =?us-ascii?Q?rolOaa6Lxwr5rgyAVedAN2cTY/H1mi5TPlxSbsxngMO8VY5IWZ6Rs0R2iFLE?=
 =?us-ascii?Q?vSMTNnkSkcSKzzwGdceZx32C9nlI6DIN3Nj7M5Vp9UTGNXZAGvC7CIWngt8F?=
 =?us-ascii?Q?RFHMbWY3UMBkWOj7n8XXssITQJdYBJddeEPWf7vxG4P0kU+TshXSIj/xuadI?=
 =?us-ascii?Q?21p4BttAQBMMho2Rd6BnJFLvBcoH4MQlOT8k5ccYgeyie/tlkhbNo5tN6xrS?=
 =?us-ascii?Q?i5hDsB2OUIU/xrCohZ196Ja8KofyTDYAfwQ0N6Nnj4xII1YYYTi8f5Pe+4w0?=
 =?us-ascii?Q?EVQkpcRJcKr7EgQ6sx7ehZ2QmBRW+klESRzIEfLkQTHHJpNZkiigeyXri0hk?=
 =?us-ascii?Q?KaDqGGFgm+Z2CU1WpDFVVovkUponfsBcT7b9rIcJj8XliLXtj5nSAtcLztrW?=
 =?us-ascii?Q?dXHk5reBKEY56t9sjVMWkNhdnvpZT11o92UwN3gU9D+1/93VZ45gzGHs+TPF?=
 =?us-ascii?Q?SmtfGIbYg8WMl99fwo2b4RMMjo2cGg3qdUv0ZkBvP09uUc68m5wL0m4mfFOU?=
 =?us-ascii?Q?NFkKLuTpH+hmub/YDlJUjK3gZbV6uc8XOr7xDwRJIVA1T95CYTWtd9K1DmCQ?=
 =?us-ascii?Q?Ctvc0kup/nHctmeEbvfZDARuShaPqsG+Lnc/RgFS1FkrbNbjLVQYgBI8IlMd?=
 =?us-ascii?Q?9hWQkLnd3ivLY0A54cV+ZYfUWNOhKtAy0Lmax1icz3Kg5ZX6BUhw/1PvQ5j5?=
 =?us-ascii?Q?V3hP82SCy4sPzTgbhcrWWcg+PZRHPUN6cjaYIbt8EhUUyx2Dp7rBzAiBYbyx?=
 =?us-ascii?Q?Kq72HyrbG6fw5ozGwnxKIqFMxIOus9VChSt2NYClrsoSewvHQjdQ2z0LbLOC?=
 =?us-ascii?Q?DWN1MKjvNhrY/qbEn+aK+ark0UZyg8DRIuwqTwETPx9XnEtK6XV/p+Ry2eEb?=
 =?us-ascii?Q?1I8z9koV12NYlulGN9ebiGmiysewnmFz+EY26bpe4pLQ5AZkDCSsRETH30pZ?=
 =?us-ascii?Q?fIBKVpp+rukXco/3eAbt3TNzQQBw55OPhXaHWxJrBN1M2Or+hZZCHk5H13P7?=
 =?us-ascii?Q?kFxWNcwRsr0F1vPK89gikvl8WI8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9541bf73-2014-4746-8955-08dc9aea8f46
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 22:58:59.7333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vPnSGl2pxixiMt0Qfgnr4raWx+JLnUFT/GjMd14kwZEjBwYFlHn6cMqgKFyGScb0RvYFzUdRusWIoZSVpa8T8uRGxJeNPmG/GaVgyNrwrrzxg0iO+mNkrNGD1Z7EH0h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6509

From: Adam Young <admiyo@os.amperecomputing.com>

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


