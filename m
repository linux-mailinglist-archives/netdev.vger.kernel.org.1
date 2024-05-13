Return-Path: <netdev+bounces-96122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623518C462B
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 19:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171AA281DC4
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53F32E3EE;
	Mon, 13 May 2024 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="QLLeO2Bx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2126.outbound.protection.outlook.com [40.107.220.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F012942F;
	Mon, 13 May 2024 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621768; cv=fail; b=pNAaYPORsMoTby6uPshGc2BD1HSP8TEkfr2cbz40SlWDvszZsC6qqkV78RmJUT93GhZ3WiSxHoWd2PVAmVJCxvA2tpT83TK2HabsKHVP1RinNjUqSwafqyNXL/9dxXVc5DSOsn8z95K3gezjjRRSGlt7z3qyoXfBoIVRlw0AcRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621768; c=relaxed/simple;
	bh=qVD5OZHBTexxATXqWQf6ppmZ6NhfvbsEd5G7jaJjqSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r7vhctt5GqfOMCKiwNb+r4LCUKbUe9nfUvJI7t1528XgvFIm2g5CjgeiKFrZu0JeLqGiWO27t2auYZd5uVASVHpOkRH9MxaPce7/ukDINb9fz82sNfvULZzoCRui7UaM5/ayodJOq+1z5zNE3dtNIchs30zZ0EuF0d/UOyXVLkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=QLLeO2Bx; arc=fail smtp.client-ip=40.107.220.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3bO1p7ACdYY9FcCgdPT2rsCvpvagx/MtkF6jBuE2i7G1uNmANPeLEy90u40c468iNovovm94nqJ9oZu8HyFftDDa1EkfwOKJCxtK59EdhNtJYnpp03xS/Py7kFP6WDxT609NDQYxcg9R2m6lAZfPZZ+BN8NQZWmfstQqIW3D4DKDpP3UI7+hOsbcd961SO6ePtNKOHeeRHIltlIQfZ0WW/w2k36hYfaAvHphIJXbrtAxc6WEk28SFV0abIl2QdxaXuN2Szp2NP9zLbHXEe67gxHKqOaA9fWeVuLPqPMff2e7dUz9RyBpbJhuUbX/S5YyV+GhGkAo0++7q6OxWzi0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=In696VHAypxUe5gZYlP56lwMGEgQ/XhOdsatFb55nGg=;
 b=Ajy45XVvTyLMN1Z+SiFWidurz1EMZHsJgGiXNWoTaG3cMRpLsQRsmbx/KR5cuwUlIIcjtmGgSZHODr3Zpdim8KKM7+Mp1HtnllihCZB2Pu15+9YIfxu8SJe7l0kxFXCXAjeANJOpDLqSVCrR9/s+KNJ85KXV2VS0W1HUU8Rs6y9mHjWHBeKucMOyctYtQr406ryehxHDNm3dYsoNQi/sXX8TODDC50jLJd7S0KFjO3cn9Lo8u98NsCc+x/mxfu5DqWzMC6MrrhWVCOOJv6i2DD7wwvdnoyBI/XEH5DxiQVXldmothhdUCQxkJeQwtBwafGmKJp+xukzZ8zPwozIZhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=In696VHAypxUe5gZYlP56lwMGEgQ/XhOdsatFb55nGg=;
 b=QLLeO2Bx+5y2Dc14RgYp4IJfzlROI8K/uAHNUnQlVCf8ZsllxyHxO+WqUGyEDMnbH0pAtzSVkk+J9WrBjlVQ31RMiDdUbF9jzqPb1lBV4uF1AGB8NxEIgi5EuPaYmDCVtJHPizQqh4mAuu6kaCS5B4U6EsQt2jz/CKhni3uJ+HE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SJ0PR01MB6191.prod.exchangelabs.com (2603:10b6:a03:296::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Mon, 13 May 2024 17:35:59 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 17:35:59 +0000
From: admiyo@os.amperecomputing.com
To: Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adam Young <admiyo@os.amperecomputing.com>
Subject: [PATCH 2/3] mctp pcc: Allow PCC Data Type in MCTP resource.
Date: Mon, 13 May 2024 13:35:45 -0400
Message-Id: <20240513173546.679061-3-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH3P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::15) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SJ0PR01MB6191:EE_
X-MS-Office365-Filtering-Correlation-Id: cda03e03-a636-42df-4118-08dc73732738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|52116005|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f6ORLzHicEwiUCz7aH6nL/4yyKLc6RMulmVMskLrcdRK96kgS22rRa22+2rh?=
 =?us-ascii?Q?iY+JDvpetTpIF+Tx1SzOB6NlbVnIXenLbo0SO6o/9tcCgS9cRQm9wlaxbN/2?=
 =?us-ascii?Q?DM0b7kH0B+byChGd9U4FHfdcdmjwWlG0O+/JElaXiDUl0QWn2vyUhYj+ZLJf?=
 =?us-ascii?Q?ejBfAtAgvLx6NIuQPntgsJ1zSDk3/8V6ZGfJn8Bw3sTFub5Lb/0VOg6mrhWN?=
 =?us-ascii?Q?XtRsVbl/DbwMqmy6becdO5uEo1oIm5/nCCFMQ/IKo24ZHFESPTkkliNSfhg3?=
 =?us-ascii?Q?fElE46PL8EGBCWBWohvUjpHTVermv0q4Z36bL4r+s6PRoH6cyMiKQUH1qJRG?=
 =?us-ascii?Q?0T58AQJKhqy6A3jfwv5lTGAkoDzkRbPYco54Mq9uaM9TjamsRYAYsHfCTPdn?=
 =?us-ascii?Q?ip/vXM+mNSq3EGmIlyeSrqdAh+L8MObCpycDqQ9s4B8lpWrrHMZvyLliWig8?=
 =?us-ascii?Q?FFN+X9X98GRj+dVfJULuJRD6nLY/JFjtuJa0FIhmjghKBMKsGkPDxvqsOCSZ?=
 =?us-ascii?Q?NZtDd+wHYB3nEPkr0LnWF3mOJHgdGKDC97lJc8s2aCWjeQHO9LmwOn+1GJEc?=
 =?us-ascii?Q?BBXPfiYZI43HxzAT7+GfOC4OS0q9z6adnzKHEUuJY7lPtxeroHdnly5CG4Ki?=
 =?us-ascii?Q?ZqRa1JDVk1iDt+TfG+xNs+OchUUTvohLrU9TxS2J92EoAMqgQ99DwJtH9v0p?=
 =?us-ascii?Q?355G4rGOmwzOxI0JUvazaFVfrAh/dnFGHsWD1cIfPp+tiCMg11QTfKpl2AkK?=
 =?us-ascii?Q?XuFeKYjTyW5aydW9ZFeahJ2PDeLvXRCnvRkyOT+tx/3vjuGKm/bEvToDgkWv?=
 =?us-ascii?Q?Cy3kFwAs1khWJMJyVzfyOZUJYSiJCzAL3mrSQmBHg5nJQ4WJDDsF7noJVZ0y?=
 =?us-ascii?Q?OJliyuXx27+c/GJsXt+LNpkGnhsw73aB/TG5baseVduOdmzfWR+otEd548s3?=
 =?us-ascii?Q?O5BQaENiuvXyyxGAVqzTHZK9EANvfdHoY8YcklET5432fJX98e5dvikSZZTs?=
 =?us-ascii?Q?coI60Ys+yGDPmUJWnl1UX2RMtI/TGtchwOrsEwxQ/NxYETxNsWdTN37rpoGS?=
 =?us-ascii?Q?ZpNsicdR2GAOU86N2lKYQuDSFUzk7MZx/lTGyvVfF/3xlUivVtr6qw22k8Rg?=
 =?us-ascii?Q?SdHIT37BAkIs2D/U3XUXnMIXJwzYpLYsm/6RdtemxRSZpq9Xz5TNSg0N1dYf?=
 =?us-ascii?Q?3E7HD+jUBdTKwmU22L7GtFjNH69cKWB/LINMwa997ISXEYbR1zGX2byTVdAW?=
 =?us-ascii?Q?xg2vLab1xGbPaCzt8yueU3v5bPjIxBhd7fr4G2ddTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ajZBdHG5m0vNUVd2tCQBZl6ELNXMRxcXt65vqOmkF4dD3MNsWoYOlCYPhn78?=
 =?us-ascii?Q?HMf0HhZFmTh5JWw4Bi+XL5WgwDC/H0Q8J7ay3Ymzq5R5daR/JQz233jlDvCm?=
 =?us-ascii?Q?s5LxQfDyPraJ39tMZC8XZ8+1vedFnrC4AMup6+mzqz/tpzIWN3U/XxE3J0+R?=
 =?us-ascii?Q?tj+StouB5XlHaxgHd+jE2w1SByFdeg59UHttiRH4kHjtq/bOv3JpZYjmmnZN?=
 =?us-ascii?Q?Q5fa2glUH+CR58Iq8G+mKbHLhi4T23HKvVA8VrribmlQPCIpkaHxc/IPPssc?=
 =?us-ascii?Q?Jn/spDlFR/vIYotHq2KsI4HJscZa05olq1Rghfq5alY3VLu2hIXdxp0ipxKG?=
 =?us-ascii?Q?iJeDavuU1TaOOCtD1A/sCFUzLsKHt05COs0FS+ZI7OOg3Rq3CS3ICFnWsKaz?=
 =?us-ascii?Q?zTygei4NR6lZBQ67X86aMOxokTIBLZ+pH355I7gM3vwttru9DVLEtxcyBy0h?=
 =?us-ascii?Q?8o/iuvUnYDpWNbxaJXYTm6B2FY9Dgsdc6oIFAaq5QFutHglrdUOpbRRcdFA0?=
 =?us-ascii?Q?GPX5alKL4mHfB7vaym5GZupGns5ucxHiC6GTAyqP10fmzbu5WmoqjLx8fGYy?=
 =?us-ascii?Q?RVo292DeQOp/m2HhBKwFWcx0ryv7ORpuGkbq5ouCaGp7uOUI5A+C/pEz2LX1?=
 =?us-ascii?Q?1r21l+wYstGNnX3qsjNzkGpB7bEjoS8+hrlpME9umtBQYhGYd1c4CnRZbbee?=
 =?us-ascii?Q?ZKcSKAUHv9GqFBtFbHDmNxaWmgVfjms0pEQ2n/4dDrspgIz596AYouJQO61L?=
 =?us-ascii?Q?IvKdCpTsrZx0nekTKzltIxYd7SunixoBZRcrktxaYXv4PlJOvYI2NZdmwub3?=
 =?us-ascii?Q?jv/ufqCyMr6vckjvP5bhr3J0l8XUr6pnLFEiFmmcMco90ECxrm9XHV3V+Zvu?=
 =?us-ascii?Q?soSdU1BIYpg901MvesDlc/iAtOJjY4f0gLwXB51jEzt5oL2GHeXhzK4NZxl5?=
 =?us-ascii?Q?ra4nyWOQcQfNcRAAIND9TFeyG71i6GBmcxqUjMMCYvFzUzI52QGMG0RsssNa?=
 =?us-ascii?Q?ULIl5l2XypXFzDk29nWGyrazL5fzp7XbWVKx9Inkuu7TqP7Mf8GKtK15+JaJ?=
 =?us-ascii?Q?jzOnMApqyM84NIwPR26vwQ1jNFBHyzwAaDUlGHyn2rXhDSYZZLQly2oeugHp?=
 =?us-ascii?Q?FPux+8oxaw09PCc2V0Dh21X88elejEHPQI5NsqPXSNes/on2oJh/lUbzuO6t?=
 =?us-ascii?Q?EjoGFVklxAD+nTEYJtU6DtpZ2ztKU3BcBrdhyvknz+/Vq1p0VhSg2faXskwi?=
 =?us-ascii?Q?s8xYgYlAGg4Aq3i8En6eKl+arpDzYe/w1/3/5uz52SJvs5sYWo62BRv2X/Zf?=
 =?us-ascii?Q?d6vw+KbZXHghuQCAofMKcZwJg9ODKZUQ5D3Y5zM8aODSOvUUrt+Ow7sAZ9ZX?=
 =?us-ascii?Q?hVv11Ewy2f1HuJr4lu1lIHLN4j8um/WRJzOD/Et0c2xrTDvv+C8N1f2ycjhG?=
 =?us-ascii?Q?NlqOiUb7OnPdfo+fAQvbjftxYnEQ/1lFuPAMnzthPOv9WzJjm9LsXxJS16L5?=
 =?us-ascii?Q?Tca9JFxAdX3rn2ZLhG2a909u6FcDxEF7Wz/8BW1IZ9z6v9oLf7XtA/sCe6lM?=
 =?us-ascii?Q?XRM+Eqoq0Zm4H2Lnm8hVbZQ2dCthcW7HtMPwZ+uyAJ/vTDkhC/VBtYj/WxcH?=
 =?us-ascii?Q?y8s+XZp0SWetmtg/lO/WHy+qKVO/WI7uCJoOOrqvs/Yh7sbHIo7eulxmGx+g?=
 =?us-ascii?Q?WGd1Tkuq/+foq4ooasvn/lSMCL8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda03e03-a636-42df-4118-08dc73732738
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 17:35:59.6838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rIszyxfHe8GNcwFmcCFwXYwl0smcmzFEoZSVqOiHk2qMjT5SSatTKLny99UM43eGvhZfFFgReI6pxZTBrbP9gHilDJIO4mkmR1eA4umXUko9kvW4SgrN/r+KOZZUE7Sd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6191

From: Adam Young <admiyo@os.amperecomputing.com>

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


