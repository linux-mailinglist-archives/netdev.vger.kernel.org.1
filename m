Return-Path: <netdev+bounces-186976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEFEAA4621
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 11:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E90F1BC7A38
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 08:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC0721C19A;
	Wed, 30 Apr 2025 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TpMtuZA8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866D521B180;
	Wed, 30 Apr 2025 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003522; cv=fail; b=tVuyWfFIpYJmm8YrrWvrrItX38flL7FXTKxW1SwLKeFz3wp786aNZQo4bDu0W2DA0e07CQ+5Ke9fI8018jSN5GHmTaCPxbQ5x7vNZ24tVJkOe+1wBWiAu61I0WkrhHXp+63yA5EMJmUc2+a1cLWl0REMRelV1pDguWmtA/Dvrys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003522; c=relaxed/simple;
	bh=VtfoxHCtXyOfvw4ubyb/YAQ4gMUPx/X8vwJT/T+o69o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PYHG4ELV0fkaSgcQvbpUA5wVWexdU8UGY+mpo52C3lvFyn1QG8SH0o9D3uoOj2RUyGSu2XYlNnLloKfKJF3J4JP/eFDxhKjR6FE73jLfZat26EXh7/3xl8XtLhHOWLao3FAMc1JlZhYFowq6d8osksWpOy3XeTWuLqeWahQcBsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TpMtuZA8; arc=fail smtp.client-ip=40.107.95.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oor9DGDugqJWk2q8+8ql1l3bKpXo2g2vQm9/r8bRltB9/Yz7ACqJnrqgqnyjeoRLTUE5pznrDEHrJIDVEAcI/OGahEbKAxP7RiJwsPAaHVR5neJTKzUQrU0kqfjMfdEy//JXl4Rnt7Ro46ZLrmyROErJpJwOdWPBcuht1znuZ4F07aFx+xbB/kzM4dxB2Oc2AchSgtIfOXn/dw/mmbwdB2Y99zZDkcz3vzQ1O/UNNUXcfh9N4NbH9ibwT6HiBNHE/YHIXJOB1078XdqybCul04Nx5OIbd6mgcxCgdj3jYrWZVdUB/PZBF8BvHNaQsbqUb2z+JDiJbEgndJ1gB4omtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iESXFwQqVSypFpeVOeXE+hjYnWXEyEWDzkrEiRsf2Ek=;
 b=gkbmlk9Bx9/OAcBPJy/sfdpNvtvK/1Wfjxq3klo+E6SF5IwyQ32YHyQBwbmKQnNVhRnjvq3rY9s/oupMWpkxF9bzJhermV/WOBflCV0ciyBqVB8SPaMOUvy95gMHgtFI8CGP7CtjDp0m3yrtYtkWlpIO94vV5Y+1Nrit6CSXuph22AJdLQS9Zta+7e1/CFRtq3nXRei1OrYTXBJb+LmbiOLbqupbl6pUE2+Mm8dRsun/12m/VlNHcU/71xs5ASfIL+hUH1pmEEOW03WAX1qaZTjPegkKSi9vyU1hjgBRsofW7+wUkF+3gMb5BeqE2W6HBlYvTONkLstBG/UwT+J1rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iESXFwQqVSypFpeVOeXE+hjYnWXEyEWDzkrEiRsf2Ek=;
 b=TpMtuZA8z3IhAwj5aXq93m8Rk4ZBOfg2zt+4GIN+Fufw2kn4GOjHqud+ZHcd+XkYdcezbwPgOdVj9uslXLWBZmQmQ38StLzDW5er9ylS6YiO5h24HK6tJdLZPSCnvbjjkhoqKwtRA2En1gz1VvoASt4VNQaytmado2oIIY5igeK+LIWKYmj9SHuYq3sGuM+t2GGbuqernIhgc2MgbKXeK8pvPBFMxHTd2Ui4ER0SqWqGNXKQ/8TE6jTgMt6CLLNeCDnVluBsSCM3WWKhdVC2H69M+IXhlWxPG+zmUENebcr3o9mS582g9X7nWtf9uFM0bnjWPCRlu+hEyUU119iNdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by LV8PR12MB9208.namprd12.prod.outlook.com (2603:10b6:408:182::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 08:58:37 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 08:58:37 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Yoray Zack <yorayz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com,
	linux-doc@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	corbet@lwn.net
Subject: [PATCH v28 09/20] Documentation: add ULP DDP offload documentation
Date: Wed, 30 Apr 2025 08:57:30 +0000
Message-Id: <20250430085741.5108-10-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430085741.5108-1-aaptel@nvidia.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0010.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::14) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|LV8PR12MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf5d887-151c-48c6-9f24-08dd87c531ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wsf6Up6Yxm0FdRUfv1a5eR5zGYxxPP2WMjPXDM2PCwba0FCoMM/DsanNYgEl?=
 =?us-ascii?Q?Bi8KqG36uNuTK+QYN2KKm5xc5b4n8c7EEBvIqSUB0LwOB6NVYntZW534uoHC?=
 =?us-ascii?Q?pMyhRDinF0lZ5Bl8z0smsN+i37VuyYd+07MLAo9KoemxHmlC7ucvsGwgMda6?=
 =?us-ascii?Q?aXbbjdOAeBx3ZlmIp9CIFzh7w616p0Gv3VGZja64sw3yaHzzYkF8coM2+Uou?=
 =?us-ascii?Q?iIb0WWPVhl6+tYwhjwLnWBg+9NjHtMqqqswSTI8rGisNtQ4mG1w7+ORPcPaX?=
 =?us-ascii?Q?cas7H+j4RkziBwAtbyyBp8t03RJTobQSykSUCNJ75+RZouvSzn7Z2lqnXtan?=
 =?us-ascii?Q?NUxyGh8rhRRpk0C2Djp3bkODvhklCuxYDEk+OTSBi/qNSa3PaQNk9Hs9RpKD?=
 =?us-ascii?Q?Bw84DhqV9EefPOMdDy6tO5tw29DgkbwgZNP4DhBt5c15sgzfiiXWaj74QzVK?=
 =?us-ascii?Q?NvYLNF+tJtDIFFBIxR0ZPbVOQSds5OJnnbX1AqpnqLA1jQJL7QZBPNEhG4UW?=
 =?us-ascii?Q?ponreA9G0nEnrk3xAuxEeaqCQQTrgnGq3dPAu/0uWW2bTPqxKA0qb8iXDN20?=
 =?us-ascii?Q?Uob0RDQY6yZMZZ5+t9RphZOTw5pTS/MWUIylgtHsZp2wfozXgs7OUiUedoQt?=
 =?us-ascii?Q?m4D7v/0U1zFMpZ41l9ISX3rfJYNmjZ/ePdoJcQsDLsJoYGFXO4jj6rC0NIQz?=
 =?us-ascii?Q?XcelqXhAT0S/PZjzx+/gfOSPVff1a5eaHXJSAOgwCOi32rwwbJYZUpPKgA1S?=
 =?us-ascii?Q?/oHW+Jhr/WXRAbn+SEIPC/JpzYFLZouB2X1QqGt/pzf1S3zuzTvYCN5PgDk/?=
 =?us-ascii?Q?EoJctUyDtHj0oeJGNPYOtQlHe9QXAIFf4Wg2HxhLEfeq48gkBZsm0MBpmkzA?=
 =?us-ascii?Q?ISAMRYZwB/myr0CcR0NwU+S3xDX3HxS67bry5WX4WfuHhYElHiJ9upqRUSVo?=
 =?us-ascii?Q?jtUjpBhkzrZecKxyQ+mCMgXghnPl/OadHDAhDBPCOLNI7cJxcS12UYylUBtu?=
 =?us-ascii?Q?AJOq5y9wAC0kRBaK5Wbhc+KbCqP+b9K48EEDKrCG/tDulegJzUU+1g/uv+LM?=
 =?us-ascii?Q?8IR0J9mYvkRwvzMUmA5hRM3iXC1+W0dCWvLV2ueSBqbMtbRnxbfYL57j7ysM?=
 =?us-ascii?Q?ekH0nDbDsgkl4mzK6eqQqSacjAzFS6CdPvQCf/Tle9VfUOm49IU+uu93TVti?=
 =?us-ascii?Q?cy19cOZmfWlVqVLsEWtD1yrqtzkOW9JmyqTlkzQ/7xEtBGnn3uh2mhebYLAJ?=
 =?us-ascii?Q?4NIkVzFSxkDpJRMqW8G1HXXas/oMkJRCdzOk3Cgyw8GlR8rRyCQaRnlitvww?=
 =?us-ascii?Q?dLHb7hVNHtKTZDT9PO8SOztyrBHw2+YOYg06V+64zqwpMZxMbgJUG9AmCFIr?=
 =?us-ascii?Q?IOhQnqWXJYMkKU9vZ0tnS5lNZV7lfs/Kl2Yc1SR8G21JlVycago0rvUWkBqS?=
 =?us-ascii?Q?o/WZtWEcPyE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NzmHyYbSF+MwHmV/P2nsAJY9eXmR1BXA5NjvTHu0H33E+OpxQekUIKDCjrpF?=
 =?us-ascii?Q?ffo0vqSO3kbNDncQ9szbbL1S3W7+Jgxix3ypOjypfhlEfU43aZBpOA/5uGA2?=
 =?us-ascii?Q?cZTa791oYJdF1KE6ckBOl1qxiqUJuZkvrDcO+s3iKlVeX4Sq7fqyGeUhFTib?=
 =?us-ascii?Q?vzu8CawAkAb4GmSFk1kSEvcIsCBKtg+broEWBDJ2kKGCqrkAwfidAjz+oCXA?=
 =?us-ascii?Q?aLnBAJ2EPjwjNjgcPAg0qmVOsVdXGRext1+ykyDYXd4xlpxoywc3yz1BTiiL?=
 =?us-ascii?Q?K/KKtwsqk1bFRuowSxshC+D6s/6H89ukRFF0kCeT/IIlVUSqzeJPPVlrskai?=
 =?us-ascii?Q?yKTDfmPBa/Ef5Aaap5f/e9Oe/2AJ3/cijeADCaQUW6CHQcKJFP5cWmcLQZaD?=
 =?us-ascii?Q?W2FFT+Rb0LJZcirsWa/kE/OqDC9irQuZ4fxR0JwBS4CFbOpKuSfh5g7Vw55P?=
 =?us-ascii?Q?O6BmfqLYpT/AAgmFtl8XHDOAKCAg3qM92vUG4wbn9j2sWu0F95qiK9QWVkJJ?=
 =?us-ascii?Q?V2vHSeJ+qXIm0NjaKUbbvKQrKhJucXaIANMeqKDsiSaIUn+qNp1DwwMCNUjh?=
 =?us-ascii?Q?tAVAZCP7N4/OxnT2bAjWlvnP3TtGNElAWSDgzWLSSsTW2PdUblVP5By2sTy+?=
 =?us-ascii?Q?VPdvMuiHdXTcoXPYxYXVOk9nrFq3Mji1b3JY9RJAnxIf+bxX8wq7m3+Ii07+?=
 =?us-ascii?Q?8rJApN3sFj9HOw/rtExIMw5thZsi2VVAoM6iHzSitzaF9F8gF0s3R6POm1Ir?=
 =?us-ascii?Q?rkt8FcrQOzGVCvhiRfJ9L+Ybo2eBlmd/GoJI4PvO0jmbLVjUWTkBBb3ZvsRM?=
 =?us-ascii?Q?kNpmROdYQuQCrnySJs0N/P+t9tkGobgmx5B3dG7yhxCAdu7q6aR1K41vuQGc?=
 =?us-ascii?Q?fx4qheKvSuj6UmnfXHbb7GOL3VCJjVAwb1r9MkrsWnHBmOupHq+7KJn3AGGQ?=
 =?us-ascii?Q?meLxZ6pI56Cd2VWpxlpSHX3CnmNrKZuNnxpHIlpH5drKHii7eoSaViYRU3hz?=
 =?us-ascii?Q?Ylo2wk/CXfynRFytYmTSKY7DQXUMVlkvj6HkDY25R2+TU4ejOZk7VQJs8kFZ?=
 =?us-ascii?Q?jKJMC3t2sYDgsbbQExBEdWbmD6Hkalk4OGAjh3HR/sSkAaJMHVfqN9KvIKRX?=
 =?us-ascii?Q?3LxxB4BQlvhNyCDsAnHsLJj89jHvT3oEUrI3zv9W4TRGaTEJAVf6MYoTRRNP?=
 =?us-ascii?Q?Sx6WMlUHPrNwW8CRJweNTFVHSvjalf7NkkJrKHAc44O3bu3m/qED7ZblgxXM?=
 =?us-ascii?Q?158N9ua4IC0e5ry+nVL8HZSq6bKbeO9zoo7gjUWWfrKdVC//6bNqKdSs7CF8?=
 =?us-ascii?Q?F0AfCyyeYrnFx15Q+Z1Vr+0FWvA2Hc/EZnA6mAoJ3M3VAWqbqKemine/Uytd?=
 =?us-ascii?Q?w56rSFoab+9cqcQEKGqcTG1kCnFZ2bAwx2LDNqnCouCBm02N+H/np4jCwlo6?=
 =?us-ascii?Q?/TMg4i6LEdh0sQQlryQOUiG77m5Irho1QGC6ZUfjZHgQE9kMOEvGGXZhHzzn?=
 =?us-ascii?Q?6lZwxqokFQWtx4YSsKHGH42a13Wj7ypEQXvKSF6ewwaEY3nhC7lmcidLVNvQ?=
 =?us-ascii?Q?PVRCfrHHcGed8BB4fyKJTo7hWRUFrYpD/nwPw6CA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf5d887-151c-48c6-9f24-08dd87c531ca
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:58:37.1606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AcUNc8QQayx0E7DLtI3dIOunjyc9akg2TViQhB32W2flaSDViBsUMFcRNj/NkL75OpIRpMjI3R48Jjfr9p9bXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9208

From: Yoray Zack <yorayz@nvidia.com>

Document the new ULP DDP API and add it under "networking".
Use NVMe-TCP implementation as an example.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/index.rst           |   1 +
 Documentation/networking/ulp-ddp-offload.rst | 372 +++++++++++++++++++
 2 files changed, 373 insertions(+)
 create mode 100644 Documentation/networking/ulp-ddp-offload.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index ac90b82f3ce9..41ab7d1f9c0e 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -120,6 +120,7 @@ Contents:
    tc-queue-filters
    tcp_ao
    tcp-thin
+   ulp-ddp-offload
    team
    timestamping
    tipc
diff --git a/Documentation/networking/ulp-ddp-offload.rst b/Documentation/networking/ulp-ddp-offload.rst
new file mode 100644
index 000000000000..4133e5094ff5
--- /dev/null
+++ b/Documentation/networking/ulp-ddp-offload.rst
@@ -0,0 +1,372 @@
+.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+=================================
+ULP direct data placement offload
+=================================
+
+Overview
+========
+
+The Linux kernel ULP direct data placement (DDP) offload infrastructure
+provides tagged request-response protocols, such as NVMe-TCP, the ability to
+place response data directly in pre-registered buffers according to header
+tags. DDP is particularly useful for data-intensive pipelined protocols whose
+responses may be reordered.
+
+For example, in NVMe-TCP numerous read requests are sent together and each
+request is tagged using the PDU header CID field. Receiving servers process
+requests as fast as possible and sometimes responses for smaller requests
+bypasses responses to larger requests, e.g., 4KB reads bypass 1GB reads.
+Thereafter, clients correlate responses to requests using PDU header CID tags.
+The processing of each response requires copying data from SKBs to read
+request destination buffers; The offload avoids this copy. The offload is
+oblivious to destination buffers which can reside either in userspace
+(O_DIRECT) or in kernel pagecache.
+
+Request TCP byte-stream:
+
+.. parsed-literal::
+
+ +---------------+-------+---------------+-------+---------------+-------+
+ | PDU hdr CID=1 | Req 1 | PDU hdr CID=2 | Req 2 | PDU hdr CID=3 | Req 3 |
+ +---------------+-------+---------------+-------+---------------+-------+
+
+Response TCP byte-stream:
+
+.. parsed-literal::
+
+ +---------------+--------+---------------+--------+---------------+--------+
+ | PDU hdr CID=2 | Resp 2 | PDU hdr CID=3 | Resp 3 | PDU hdr CID=1 | Resp 1 |
+ +---------------+--------+---------------+--------+---------------+--------+
+
+The driver builds SKB page fragments that point to destination buffers.
+Consequently, SKBs represent the original data on the wire, which enables
+*transparent* inter-operation with the network stack. To avoid copies between
+SKBs and destination buffers, the layer-5 protocol (L5P) will check
+``if (src == dst)`` for SKB page fragments, success indicates that data is
+already placed there by NIC hardware and copy should be skipped.
+
+In addition, L5P might have DDGST which ensures data integrity over
+the network.  If not offloaded, ULP DDP might not be efficient as L5P
+will need to go over the data and calculate it by itself, cancelling
+out the benefits of the DDP copy skip.  ULP DDP has support for Rx/Tx
+DDGST offload. On the received side the NIC will verify DDGST for
+received PDUs and update SKB->ulp_ddp and SKB->ulp_crc bits.  If all the SKBs
+making up a L5P PDU have crc on, L5P will skip on calculating and
+verifying the DDGST for the corresponding PDU. On the Tx side, the NIC
+will be responsible for calculating and filling the DDGST fields in
+the sent PDUs.
+
+Offloading does require NIC hardware to track L5P protocol framing, similarly
+to RX TLS offload (see Documentation/networking/tls-offload.rst).  NIC hardware
+will parse PDU headers, extract fields such as operation type, length, tag
+identifier, etc. and only offload segments that correspond to tags registered
+with the NIC, see the :ref:`buf_reg` section.
+
+Device configuration
+====================
+
+During driver initialization the driver sets the ULP DDP operations
+for the :c:type:`struct net_device <net_device>` via
+`netdev->netdev_ops->ulp_ddp_ops`.
+
+The :c:member:`get_caps` operation returns the ULP DDP capabilities
+enabled and/or supported by the device to the caller. The current list
+of capabilities is represented as a bitset:
+
+.. code-block:: c
+
+  enum ulp_ddp_cap {
+	ULP_DDP_CAP_NVME_TCP,
+	ULP_DDP_CAP_NVME_TCP_DDGST,
+  };
+
+The enablement of capabilities can be controlled via the
+:c:member:`set_caps` operation. This operation is exposed to userspace
+via netlink. See Documentation/netlink/specs/ulp_ddp.yaml for more
+details.
+
+Later, after the L5P completes its handshake, the L5P queries the
+driver for its runtime limitations via the :c:member:`limits` operation:
+
+.. code-block:: c
+
+ int (*limits)(struct net_device *netdev,
+	       struct ulp_ddp_limits *lim);
+
+
+All L5P share a common set of limits and parameters (:c:type:`struct ulp_ddp_limits <ulp_ddp_limits>`):
+
+.. code-block:: c
+
+ /**
+  * struct ulp_ddp_limits - Generic ulp ddp limits: tcp ddp
+  * protocol limits.
+  * Add new instances of ulp_ddp_limits in the union below (nvme-tcp, etc.).
+  *
+  * @type:		type of this limits struct
+  * @max_ddp_sgl_len:	maximum sgl size supported (zero means no limit)
+  * @io_threshold:	minimum payload size required to offload
+  * @tls:		support for ULP over TLS
+  * @nvmeotcp:		NVMe-TCP specific limits
+  */
+ struct ulp_ddp_limits {
+	enum ulp_ddp_type	type;
+	int			max_ddp_sgl_len;
+	int			io_threshold;
+	bool			tls:1;
+	union {
+		/* ... protocol-specific limits ... */
+		struct nvme_tcp_ddp_limits nvmeotcp;
+	};
+ };
+
+But each L5P can also add protocol-specific limits e.g.:
+
+.. code-block:: c
+
+ /**
+  * struct nvme_tcp_ddp_limits - nvme tcp driver limitations
+  *
+  * @full_ccid_range:	true if the driver supports the full CID range
+  */
+ struct nvme_tcp_ddp_limits {
+	bool			full_ccid_range;
+ };
+
+Once the L5P has made sure the device is supported the offload
+operations are installed on the socket.
+
+If offload installation fails, then the connection is handled by software as if
+offload was not attempted.
+
+To request offload for a socket `sk`, the L5P calls :c:member:`sk_add`:
+
+.. code-block:: c
+
+ int (*sk_add)(struct net_device *netdev,
+	       struct sock *sk,
+	       struct ulp_ddp_config *config);
+
+The function return 0 for success. In case of failure, L5P software should
+fallback to normal non-offloaded operations.  The `config` parameter indicates
+the L5P type and any metadata relevant for that protocol. For example, in
+NVMe-TCP the following config is used:
+
+.. code-block:: c
+
+ /**
+  * struct nvme_tcp_ddp_config - nvme tcp ddp configuration for an IO queue
+  *
+  * @pfv:        pdu version (e.g., NVME_TCP_PFV_1_0)
+  * @cpda:       controller pdu data alignment (dwords, 0's based)
+  * @dgst:       digest types enabled.
+  *              The netdev will offload crc if L5P data digest is supported.
+  * @queue_size: number of nvme-tcp IO queue elements
+  */
+ struct nvme_tcp_ddp_config {
+	u16			pfv;
+	u8			cpda;
+	u8			dgst;
+	int			queue_size;
+ };
+
+When offload is not needed anymore, e.g. when the socket is being released, the L5P
+calls :c:member:`sk_del` to release device contexts:
+
+.. code-block:: c
+
+ void (*sk_del)(struct net_device *netdev,
+	        struct sock *sk);
+
+Normal operation
+================
+
+At the very least, the device maintains the following state for each connection:
+
+ * 5-tuple
+ * expected TCP sequence number
+ * mapping between tags and corresponding buffers
+ * current offset within PDU, PDU length, current PDU tag
+
+NICs should not assume any correlation between PDUs and TCP packets.
+If TCP packets arrive in-order, offload will place PDU payloads
+directly inside corresponding registered buffers. NIC offload should
+not delay packets. If offload is not possible, than the packet is
+passed as-is to software. To perform offload on incoming packets
+without buffering packets in the NIC, the NIC stores some inter-packet
+state, such as partial PDU headers.
+
+RX data-path
+------------
+
+After the device validates TCP checksums, it can perform DDP offload.  The
+packet is steered to the DDP offload context according to the 5-tuple.
+Thereafter, the expected TCP sequence number is checked against the packet
+TCP sequence number. If there is a match, offload is performed: the PDU payload
+is DMA written to the corresponding destination buffer according to the PDU header
+tag.  The data should be DMAed only once, and the NIC receive ring will only
+store the remaining TCP and PDU headers.
+
+We remark that a single TCP packet may have numerous PDUs embedded inside. NICs
+can choose to offload one or more of these PDUs according to various
+trade-offs. Possibly, offloading such small PDUs is of little value, and it is
+better to leave it to software.
+
+Upon receiving a DDP offloaded packet, the driver reconstructs the original SKB
+using page frags, while pointing to the destination buffers whenever possible.
+This method enables seamless integration with the network stack, which can
+inspect and modify packet fields transparently to the offload.
+
+.. _buf_reg:
+
+Destination buffer registration
+-------------------------------
+
+To register the mapping between tags and destination buffers for a socket
+`sk`, the L5P calls :c:member:`setup` of :c:type:`struct ulp_ddp_dev_ops
+<ulp_ddp_dev_ops>`:
+
+.. code-block:: c
+
+ int (*setup)(struct net_device *netdev,
+	      struct sock *sk,
+	      struct ulp_ddp_io *io);
+
+
+The `io` provides the buffer via scatter-gather list (`sg_table`) and
+corresponding tag (`command_id`):
+
+.. code-block:: c
+
+ /**
+  * struct ulp_ddp_io - tcp ddp configuration for an IO request.
+  *
+  * @command_id:  identifier on the wire associated with these buffers
+  * @nents:       number of entries in the sg_table
+  * @sg_table:    describing the buffers for this IO request
+  * @first_sgl:   first SGL in sg_table
+  */
+ struct ulp_ddp_io {
+	u32			command_id;
+	int			nents;
+	struct sg_table		sg_table;
+	struct scatterlist	first_sgl[SG_CHUNK_SIZE];
+ };
+
+After the buffers have been consumed by the L5P, to release the NIC mapping of
+buffers the L5P calls :c:member:`teardown` of :c:type:`struct
+ulp_ddp_dev_ops <ulp_ddp_dev_ops>`:
+
+.. code-block:: c
+
+ void (*teardown)(struct net_device *netdev,
+		  struct sock *sk,
+		  struct ulp_ddp_io *io,
+		  void *ddp_ctx);
+
+`teardown` receives the same `io` context and an additional opaque
+`ddp_ctx` that is used for asynchronous teardown, see the :ref:`async_release`
+section.
+
+.. _async_release:
+
+Asynchronous teardown
+---------------------
+
+To teardown the association between tags and buffers and allow tag reuse NIC HW
+is called by the NIC driver during `teardown`. This operation may be
+performed either synchronously or asynchronously. In asynchronous teardown,
+`teardown` returns immediately without unmapping NIC HW buffers. Later,
+when the unmapping completes by NIC HW, the NIC driver will call up to L5P
+using :c:member:`ddp_teardown_done` of :c:type:`struct ulp_ddp_ulp_ops <ulp_ddp_ulp_ops>`:
+
+.. code-block:: c
+
+ void (*ddp_teardown_done)(void *ddp_ctx);
+
+The `ddp_ctx` parameter passed in `ddp_teardown_done` is the same on provided
+in `teardown` and it is used to carry some context about the buffers
+and tags that are released.
+
+Resync handling
+===============
+
+RX
+--
+In presence of packet drops or network packet reordering, the device may lose
+synchronization between the TCP stream and the L5P framing, and require a
+resync with the kernel's TCP stack. When the device is out of sync, no offload
+takes place, and packets are passed as-is to software. Resync is very similar
+to TLS offload (see documentation at Documentation/networking/tls-offload.rst)
+
+If only packets with L5P data are lost or reordered, then resynchronization may
+be avoided by NIC HW that keeps tracking PDU headers. If, however, PDU headers
+are reordered, then resynchronization is necessary.
+
+To resynchronize hardware during traffic, we use a handshake between hardware
+and software. The NIC HW searches for a sequence of bytes that identifies L5P
+headers (i.e., magic pattern).  For example, in NVMe-TCP, the PDU operation
+type can be used for this purpose.  Using the PDU header length field, the NIC
+HW will continue to find and match magic patterns in subsequent PDU headers. If
+the pattern is missing in an expected position, then searching for the pattern
+starts anew.
+
+The NIC will not resume offload when the magic pattern is first identified.
+Instead, it will request L5P software to confirm that indeed this is a PDU
+header. To request confirmation the NIC driver calls up to L5P using
+:c:member:`resync_request` of :c:type:`struct ulp_ddp_ulp_ops <ulp_ddp_ulp_ops>`:
+
+.. code-block:: c
+
+  bool (*resync_request)(struct sock *sk, u32 seq, u32 flags);
+
+The `seq` parameter contains the TCP sequence of the last byte in the PDU header.
+The `flags` parameter contains a flag (`ULP_DDP_RESYNC_PENDING`) indicating whether
+a request is pending or not.
+L5P software will respond to this request after observing the packet containing
+TCP sequence `seq` in-order. If the PDU header is indeed there, then L5P
+software calls the NIC driver using the :c:member:`resync` function of
+the :c:type:`struct ulp_ddp_dev_ops <ulp_ddp_ops>` inside the :c:type:`struct
+net_device <net_device>` while passing the same `seq` to confirm it is a PDU
+header.
+
+.. code-block:: c
+
+ void (*resync)(struct net_device *netdev,
+		struct sock *sk, u32 seq);
+
+Statistics
+==========
+
+Per L5P protocol, the NIC driver must report statistics for the above
+netdevice operations and packets processed by offload.
+These statistics are per-device and can be retrieved from userspace
+via netlink (see Documentation/netlink/specs/ulp_ddp.yaml).
+
+For example, NVMe-TCP offload reports:
+
+ * ``rx_nvme_tcp_sk_add`` - number of NVMe-TCP Rx offload contexts created.
+ * ``rx_nvme_tcp_sk_add_fail`` - number of NVMe-TCP Rx offload context creation
+   failures.
+ * ``rx_nvme_tcp_sk_del`` - number of NVMe-TCP Rx offload contexts destroyed.
+ * ``rx_nvme_tcp_setup`` - number of DDP buffers mapped.
+ * ``rx_nvme_tcp_setup_fail`` - number of DDP buffers mapping that failed.
+ * ``rx_nvme_tcp_teardown`` - number of DDP buffers unmapped.
+ * ``rx_nvme_tcp_drop`` - number of packets dropped in the driver due to fatal
+   errors.
+ * ``rx_nvme_tcp_resync`` - number of packets with resync requests.
+ * ``rx_nvme_tcp_packets`` - number of packets that used offload.
+ * ``rx_nvme_tcp_bytes`` - number of bytes placed in DDP buffers.
+
+NIC requirements
+================
+
+NIC hardware should meet the following requirements to provide this offload:
+
+ * Offload must never buffer TCP packets.
+ * Offload must never modify TCP packet headers.
+ * Offload must never reorder TCP packets within a flow.
+ * Offload must never drop TCP packets.
+ * Offload must not depend on any TCP fields beyond the
+   5-tuple and TCP sequence number.
-- 
2.34.1


