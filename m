Return-Path: <netdev+bounces-84536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441FD897332
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 16:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63A531C21447
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF8D149DFB;
	Wed,  3 Apr 2024 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="KGY+1ZIp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2132.outbound.protection.outlook.com [40.107.94.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D04149DE2
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156300; cv=fail; b=eyIc8Abgc+AxooXXhxT/U0mufRj1lHIn7TBXC2fwW93haZlJUopmypVMRuNPTX8zn7NbG3ljexbIiJdeCAuCY8goy+ZspsyAjPaqhXp7ZxJwlie5T6WoTDGpkfeq25j/aj3d177rXe46BYERmuEJIp1tTCRMBD8LxUUASTYaKI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156300; c=relaxed/simple;
	bh=yyULfJDoWcOVstoRB1WYRtfPrE9JNSTubJFVqHiUhO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qeyftbVxWrhYY4vDraQaZTDqbGDvrhBiVFcbHEe+bhNvgi0nbWUtsX55Qqt0ujHQhTa7hatoc3Blpw2BB52kfXuCa8SduVV2xvfxiXXuO3N7EF83OTlI3Sb0PrvvI6cyU/AYiPK5ku6DjI1pmiOoNsXZkBh7CUS7RIYJ4E/gsec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=KGY+1ZIp; arc=fail smtp.client-ip=40.107.94.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcX/+B+78GrMSNklfadMd8ig8WtsH9Rdq8+ijB2YYrRtzrBjtMYqtpNfflH0h223nxq3ahUITItUTj13y0EFxzfnf+bEkgsnsgNdRavUmHv5RYfeyQ82YbD3t5JttYCGuwXhIUh2R332q0/y/z8ZJWWQeP4AnUKhYUx0ux1JshHtlHOmt3htLamwK4qmM2eY8p3VWnKqVd0u4ncYx/yMR1JlMHIecSE8cvig6CJp7vllYzMrzSrC4MRpLEnWZ4smGO2HOtNvf0QeeHPW3IwOOcHsT+/hImOTOV9uJh+o8cYKmFl2n0juCpqJ0gDguhavkb6I0juYh5YixTbDGwz0Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8+Pa4zRPIJO+kKYd0nB6E/azQ2VbO+CHvvc6kKe4x0=;
 b=BTxBLi4cg37pgszpjB2f8TFwfPEcMik0uwfI3oM7f5/+OpucfQG4hZX51HnJaJg0gld1ItUFQVW2YydBS7KblmmSbNhzMBgXUM+AQE6U2buQBkKcnjWVO922M2uQlypOY+kVWkldgLEazv09jv+GDJqplw+qxbIe6n03coybcceIcPa+arTKhK+DVjP9NQbGhOv6ZhRlfhZ9dOsUviakyLH9IKtgXxWVcT2fXLrd6LvxLf+J2JLnOl8X8s8Z2GDoB3xMdT01mItxmKQNqFoSB7fnuyHoczaXz3bqyqWUBenkQ08avnGS2xQqMx/Xy6iT9uqFwChm0rRp+3p3gpXY7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8+Pa4zRPIJO+kKYd0nB6E/azQ2VbO+CHvvc6kKe4x0=;
 b=KGY+1ZIpkhJixCkE/8xTJtPYKe/UPQEtDMJVwVtlubkaFLsY6A/z/W9GfK7BrrnsmvGDTAXj99VwBs+E5A8LO4Fp7AWJU9cpbx4c6bTeXmGJf7XSlcRdBVxcmPQcDMRbtB8uLHRWpvL0F+LSuvoC3EfOEwqCrAm63ULzwoAN8v8=
Received: from CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
 by DM6PR13MB4413.namprd13.prod.outlook.com (2603:10b6:5:1bf::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 14:58:17 +0000
Received: from CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::cd14:b8e:969c:928f]) by CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::cd14:b8e:969c:928f%4]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 14:58:17 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
	Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v3 1/4] devlink: add a new info version tag
Date: Wed,  3 Apr 2024 16:56:57 +0200
Message-Id: <20240403145700.26881-2-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403145700.26881-1-louis.peens@corigine.com>
References: <20240403145700.26881-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JNAP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::10)
 To CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR13MB4411:EE_|DM6PR13MB4413:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YpHy25oGQtu3EmPSr3MyddPWf2AgDr6HaRk+i16CAR2dJCCvGIm+yZdlJmnP9OzOLb7mTQjObOHtWyx0UOqfXEIj29+RKHka3YC4NeMYHEsZTQlx2azyDlUEzzg6cPSXlPo8es6pZCJPmIbhwKVk06sga9fPpzcXMqV5G99Iig9YF2uqkP9sUsXu6Yv2ZxVYJGrzYfqXD110xlKCl+VlC4J+ZHRUU8Hb250fyddCNFNw6kXt7wWP6mbekOCAFPBKvwoA6h4osyBWLcnoacDxtUyPBu5hjZZXgYFW6FYGcA0gVIlueIBkOkmqW0RagXF9BJpAlNLr3AEs69+SHBZ3Nw5lC6HFuuJlkig0y/4t0lTp/DmgZbV9xqRDGiieSF2obUPo5a8dKTl7gAQbgz+hPqDxm0IcW8BB1j8ioafnctqy556JipKyiUxTy1jQmk4sTS2RD2fWj1vJivtp+TNFFsqVMKjLs0LX/i0Me3X8Q4MTMnMDMy+BuGeRhoIMsuEyReX9FaPejH+uPW0DLyecnJVM9/lF5rzoFq4ihhazoNr5FMYpNjbBeFKjwgK4mYnqXfAF0N/6xqjlDlPvQVHvNc/YbvHkLAPBK/65DccpVXsml+2Uk9VWOsow7VAQdnt0kOxppmCMNJtGXmae4BHd5uvJ+FbpszAxgVTXKWbA+xDpM01gsnRQTp4IFtnMisz/39p3J95P7cZzRHKzUYekNh4a8TZSjd2m1Lo5hsTETlY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB4411.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i9xUEwMpQzZWDhNWzCN0cd68DC198QAL1JRZQ1ZCsOBLXk/2X/eHfApy9eKU?=
 =?us-ascii?Q?NKcOnb+zK55JB4Km20zotHfSh9RcMt9vpwKyHcgwEcIGsClQGrj/KwB5rL66?=
 =?us-ascii?Q?zUB/HWCB4Xou2w7NIDwrnhDrbRTQqgb2xt3S3H+Rv0PUJDFr9UY1zSsPwonQ?=
 =?us-ascii?Q?XENTAeLSRAS7vd7SQ1YrCo3HlovUaDPUtG/zBYxPApr28FLbw9cj1fCcPAnM?=
 =?us-ascii?Q?HiWQMAFd9dQhqxRj8YvFCndvi1Y1nEJn2SmVHHtQRPh7QzGlir4RX6YaL35B?=
 =?us-ascii?Q?VtoM26z0R4pPdm5KpgCWwTp9C2t+335lauXPdHtl0KZ9o6hB+oMb63dSehAL?=
 =?us-ascii?Q?G1QXk8z/VgE9/IP16tFMFGyWDMUnjAWCc3FKLBUDsX4rs4a2zzr37kjgQw6E?=
 =?us-ascii?Q?rr7tPuARAAETRrW12udIxwlUgtkgxsh9mzWRyHTjSakrwteNoMqmt3YvQzVs?=
 =?us-ascii?Q?BwWR68E+1wyBMIldxLd4HUXA9O9CpzFr4G0xZuOS93THbiFYOJ5WDmOG8tJT?=
 =?us-ascii?Q?W5o0K1e4y70S0319CZPzCZoTC1PQFKN4+UDSYvPGvDqvFXgYaEr6MblVj8uV?=
 =?us-ascii?Q?Vvdd5ImBbRm/sHB5kCKU5iuNtVIM2ywIbIlv83RKa6cGXgielM81T3BUMj5C?=
 =?us-ascii?Q?1dWRvQlDADsBq2INLFI8WckJUeR2w0fLM9KWWVWXhh2raxlwq+xC0A400aKq?=
 =?us-ascii?Q?yYfZ5TiCnYEusGMyj00Q9FwVBSOkYSpxr6k/dzC4fjXid72cM0gC//3GlbGo?=
 =?us-ascii?Q?3zp9LrGAVkLgBMglfESSZoCowzZyfHJJyrhw9PV/8D4o1zn915UFA+nPUayh?=
 =?us-ascii?Q?ghIo4hPeg69ns/G7SyW6eNY8pWTGe418QdgHpUG9GmLyKMSo9cc0aXvHn1fj?=
 =?us-ascii?Q?D2DKFZULIJaf5688FHEpdF8su1NfX9xzcyqkOrL5M4hwHQXuKDk8ns4B0qFN?=
 =?us-ascii?Q?KEKkZHqeQzrMewUzwGW792uO6RmW/epugJ427KdJAg3CKAbmtw2C9yoxmadY?=
 =?us-ascii?Q?anphuAnva793unjEQhqjElpjbbntvp4QhdQpNrZ/buHV0o7JQCFWbmJpFi76?=
 =?us-ascii?Q?DNRgQvlceuSj6BG8MyNcN6fMQl9mAcgwcedt91envwTYi2a0SENda0hseyn/?=
 =?us-ascii?Q?gOj8xOEatt8aCyyCCSBl2JzvWItneSbCkTr8jVDJgrH74NwHTIIHiMyUSlJw?=
 =?us-ascii?Q?grLtZlfp7LWp+5B+BgK7cTL0gFGqr8BCTzfFPHIHXc/gXrXYT0EEEm+qRnAf?=
 =?us-ascii?Q?dSeAR3ETc9Y5XBIppn/7zOQRI0r1TdWaDdjb2EgBRRDNiLBeaTnCdunU5idW?=
 =?us-ascii?Q?rzbY2O5E47/IwbgbU0lmTxvD/6dCveLzlUYzUQ0W3qgumXJSAcIwSCV17Djy?=
 =?us-ascii?Q?7p1P/xB/qQ96MqFI/um0aepDbC9PEfRHOCJzIezsZpPtXzgfsMKe+lYFlyq1?=
 =?us-ascii?Q?5C2LURPI6JB0oNqlJv9+mjI/wEWBu7/htjZRIiL/NB7Y3uc5eut84bBwNwza?=
 =?us-ascii?Q?kmUnaIhuK1JTItAw04L1vAfpXqSLHYNhuANNaNy0bejgvlLb8lUfdYSYW61I?=
 =?us-ascii?Q?lTxk9aiypqxiR78fsS8KWiNcjFiyCc6wbOjeKh49YWgsp/1+wGEnjuTqg0vY?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406fadce-91f3-4764-b335-08dc53ee7eb6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB4411.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 14:58:17.4067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Jmn+mqqitMYziB9EBu+xgyVqeCyDVYtY1bF/04+l0TnmaQo7PMDaCKt76WZGQwvrc1vjT1Hmm15HB2nnqk5L7O8wxp9mezoiv/RWpDMd8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4413

From: Fei Qin <fei.qin@corigine.com>

Add definition and documentation for the new generic
info "board.part_number".

The new one is for part number specific use, and board.id
is modified to match the documentation in devlink-info.

Signed-off-by: Fei Qin <fei.qin@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 Documentation/networking/devlink/devlink-info.rst | 5 +++++
 include/net/devlink.h                             | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/devlink/devlink-info.rst b/Documentation/networking/devlink/devlink-info.rst
index 1242b0e6826b..c7c5ef66a2fe 100644
--- a/Documentation/networking/devlink/devlink-info.rst
+++ b/Documentation/networking/devlink/devlink-info.rst
@@ -146,6 +146,11 @@ board.manufacture
 
 An identifier of the company or the facility which produced the part.
 
+board.part_number
+-----------
+
+Part number of the board design.
+
 fw
 --
 
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 9ac394bdfbe4..2100e62c2c2d 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -599,12 +599,14 @@ enum devlink_param_generic_id {
 	.validate = _validate,						\
 }
 
-/* Part number, identifier of board design */
+/* Identifier of board design */
 #define DEVLINK_INFO_VERSION_GENERIC_BOARD_ID	"board.id"
 /* Revision of board design */
 #define DEVLINK_INFO_VERSION_GENERIC_BOARD_REV	"board.rev"
 /* Maker of the board */
 #define DEVLINK_INFO_VERSION_GENERIC_BOARD_MANUFACTURE	"board.manufacture"
+/* Part number of board design */
+#define DEVLINK_INFO_VERSION_GENERIC_BOARD_PART_NUMBER	"board.part_number"
 
 /* Part number, identifier of asic design */
 #define DEVLINK_INFO_VERSION_GENERIC_ASIC_ID	"asic.id"
-- 
2.34.1


