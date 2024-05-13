Return-Path: <netdev+bounces-96120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE42C8C4627
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 19:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534FB1F21FF9
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1579200DB;
	Mon, 13 May 2024 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="n9jqREXH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2126.outbound.protection.outlook.com [40.107.220.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27310199B0;
	Mon, 13 May 2024 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621761; cv=fail; b=MHaZqiVvlUY39J6CPuXD6ucxaJ48L0fZajJyQzDJoY1e3zRNZ1xVx7OPdZfldWJGJHnYrs9HI647/0Ky3MvZJksUIuYyq1w2R8MfPS6p5awekxgiaIJbcPSQRssavjSdxAf6ysVm9lvXUMZGrRn9UW6IePQzb+VTd+aHT37j8Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621761; c=relaxed/simple;
	bh=RRU3etZ6k41HXZ+0WE40yP7GRw4bhIOR08w5gFXn39c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=S/GdjZ7/SYo359TWaMyvmKaBs4YP7+9+CI+m41eIGUP4ZXWSwxSvQ1e2SsRwbR/eHSEXuS/SVDGB/LfAaVstsfi7I1bLq96wiTMh6SAAUjWD42BbLKlI1dPsqotJ/C6VN7Y44m2TOOz3bRwOQmum6f8MA4hc+689GwyBaX5J0BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=n9jqREXH; arc=fail smtp.client-ip=40.107.220.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsQhHcx0UpAMfF8IxgxxhLY/0GDVENNUD23kh3BhTXqeF025TmJjmPDOrq40BTkQU+s3XSBd+/CihkSOQ8CxqkmmxJ2+Ao1rQQP4rBsKmMsMrvULrVSbRWgvO+/Mm/I1nqUzXhbqnYgveiNByUMbkMZFGMKGHMgFyZxx6zXVXwikFjRh8QDFR/2W79JB7yGWurbWWwSx9XAedBjSnKy/XdhYK5yZxmRuibicpb2i+XHYbYZZp1kqI6iZnPSSD3tkbRWIWCDm62mXUWrHolUQge9sShPpIORzaGcP66lsQvwyx89mILbpZ1Kyq/rZhc+94R6w6HEeqUngVBapquv4dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEhuCkt5clsbSj7N3dOEC3ADY59QwPpxEUNS2OMsi/E=;
 b=ArNb3KLp00/W7PWKdIEF6m6/c2gNQnxga7HnQhftGt1Oi7ZHXE7M8FJUl28Ypswo+0qCrv9sTlSR2TWua/OM5ySVhK1NdWNiKjAFHEHQ8SPIHIGtVoKcLe1yD8rUI7bx9qVDT55LEpUbjHSz42odk1+F0I+wFkWeo0nvkwa3RdOvvl58kllmZkf0ewsViA/07uLSUWVP9LBjWMl54Au/RJScxrBfDJu1RbIGXRquh5PUo0OuyGmci/Qbqu0wQxRM0f2dxOWIxxEHDrtvH56SAT1T4uDbal1+RLqlUMYV4jaOgchMG4ztoT0E9ZmCnZt97gk7ObfA1c7i0ZFyqSIjzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEhuCkt5clsbSj7N3dOEC3ADY59QwPpxEUNS2OMsi/E=;
 b=n9jqREXHNFIWxksUNtMFSwzQwQRGCmyzc4gTOZNlRqyfcDGh6remTHYqQ1dRcXnmVU3xkoojgEi84jT/9l4NIuMRp7ek9uo15Og5ZxwP+uWsuP4YSVI+fT5C7+p/t7KfiZfUnvpEILHJHgAvPBP7C+sZCtS3jQnZsl31/daYII4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SJ0PR01MB6191.prod.exchangelabs.com (2603:10b6:a03:296::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Mon, 13 May 2024 17:35:54 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 17:35:54 +0000
From: admiyo@os.amperecomputing.com
To:
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adam Young <admiyo@os.amperecomputing.com>
Subject: [PATCH 0/3] MCTP over PCC
Date: Mon, 13 May 2024 13:35:43 -0400
Message-Id: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::11) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SJ0PR01MB6191:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a0c615-9aa0-417a-be50-08dc73732444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|52116005|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?isFb6Ex3/rq4eGtxRdYIju0/G/aPOEfNyR3dRXJm6qdpYWBiQYr9UZktuEX5?=
 =?us-ascii?Q?Q84AAbnBRCse+MBbruTmiT5uxKrOB2NZHJvJbs+QBn+K+fyQwZ+fJQ86KuGM?=
 =?us-ascii?Q?pxzNJ1zc8Rh1FM9nPaNk/iVqg1v1wvqLfvUoWz2SX9sjKock6C90cQXb7N3T?=
 =?us-ascii?Q?HydIo6FZMdHptWLiXNjeyN+akJpLE99jJ0m+l8vizNep3YsvALbyaJdky1lT?=
 =?us-ascii?Q?GO6F3v7Q6zjFvZatqQeGFAjEu5/UnuJ8USEuU2jdRONJFBfURIJ3edNXf5qI?=
 =?us-ascii?Q?rZWmLUibhnDTodYKf56yvMceigTPUqsdcCpXaZCZK/4dmiHRgtlzZFwVjsve?=
 =?us-ascii?Q?FewBH8yqOzDtwIkxa6ITo7mZ6RetIS0NQE2wz7mX5df3H9CxWxOxcPZQn1F1?=
 =?us-ascii?Q?OYTgkQU9rYoEw0TiYdEeGhJa35XLtX3jpVsViahp8dBYseyVZn0QsHJvl+uW?=
 =?us-ascii?Q?Z+TJQ719Bvvzl3IhF4L5B6vAjQhM4WYAkgDNg6l+hkcYu1vY+w1P4s/PG79r?=
 =?us-ascii?Q?Pm2GX3MHVy4uCppCwvICRy+F4ar2m6iAO6UCBgxxgrZ+c/nAuPvJHkAqF1em?=
 =?us-ascii?Q?yx++iRx8im7YczoCkNh9Xc0APIHa40tKU1faywlqFHKGv1dWjrYnxTTSKhKw?=
 =?us-ascii?Q?2jmbIZ7dnfKC+bA8NawBFluxQcs7xusy+Hl1trsbTUh5lLCnNur5RrO4utSu?=
 =?us-ascii?Q?g14FzaQl+Qs1wA9risiqbu1uelEgrjwSLgLs4eOk3iRQ+hG0gxTeoYwga0K3?=
 =?us-ascii?Q?rinBxxWwde2RafyHQzEuoH3kfLTjWv9VcYEpTQhbpgEqHzhGVAvaDvJWTUVd?=
 =?us-ascii?Q?NHmPMATZriqMmkByQz79NR6zykMtGNn562GGLTZVbHAUkbm3O+LR+II0AsB0?=
 =?us-ascii?Q?Xg6wE+B7DsuDOijjXi7OEPgJT30I3bXMB8XAgMzG+eChMt+ya/a7Nsn/9NrS?=
 =?us-ascii?Q?qdLVRjRYZp0XRnMNdAjMbdp+UjjxY27Rz0jJFTgzt8qUB9eHld8IaXT8/8xO?=
 =?us-ascii?Q?3defFlHMvhsHMliCnZGt/DdCKFiz+IL282beBwRj5MKXxLQoyJTCMe7fg0Xr?=
 =?us-ascii?Q?MVZLfFs7yM2/kE9xbXzfbywLZ+pEKLRD7B64JUQsKn3N27CQWPP1cxSnIaLj?=
 =?us-ascii?Q?lpfPfpo0PKlx9ttOxTTiWl977p5z4CM3r9Ukw5zawF+jR/CA9YKSHMtTE0XP?=
 =?us-ascii?Q?GKoS1hqeOIOGDG4F8qI8k7O5jwVQz3d4FzYWex16GeXciita4y0z4GcahcWB?=
 =?us-ascii?Q?8rkxAXXwqiuL1BrNn8Q2P/VGqBCsMSKTfU3MSISpAQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nxo1perhoGsbmi/87naADkRwD06aA7yUbUmBf2rXWtuoKg9tQmBK1DbOkNqC?=
 =?us-ascii?Q?uTDPhaJD/z7jrH2Litbx6cWBAVXON3uYtEBft62wbga8NXYKWZ7bujw2/Qr5?=
 =?us-ascii?Q?cmY1iBlQDKKB5842bmWg6rcEiRo2SQqGgWfoo4P2WK4JI/jh0gpZqXF9XGAV?=
 =?us-ascii?Q?9OJ/3gXD5VBvP9b+F2Qbs9KkJTz9Zjyq1wdBINCdJJeS80cSf0GcB5xmf1/A?=
 =?us-ascii?Q?fFxtPv3I2TmPRGPQCJ3YJQFEBrjNV1cGBR+tmneo9SUp0ua3OKBUUZ7wP3Uj?=
 =?us-ascii?Q?xJ0P/OLgZkCVq66OTQjEMn1LvAGvtFVF/98NFQh6N3h59PKFTcMm9q0/qG4v?=
 =?us-ascii?Q?KSA+W+FFK6HOaK2ixA7lmVG3i14TvouQINeFC8rXZXjzfA7Pd3BoJWbALLuU?=
 =?us-ascii?Q?BwkK2v+xUk5nd8OBN27YMam3aVNabdeD5I7OcfpCDpxiCapRpyvrvMrsPGJ5?=
 =?us-ascii?Q?mVG5Eaf+8qz0g86lRjPg4yQbNBNt1w1tH0nNVvhcFiSIbQbwlgPso3R1oqwv?=
 =?us-ascii?Q?51gTd3d8O7vZX15O5j3J+l2QPIEbblPkSKINfYVpdqUqMlw69cYk2qp6cryw?=
 =?us-ascii?Q?Pb+ilrA/pMtigpDGdtE+6b3jKYxnwUKFYWzIGUQdzFXRPwPBn/7zjH8PPUEl?=
 =?us-ascii?Q?M52KmTT49krZVDu1vp8yEp7sTEqB/vsqA6PaKPZUF78y/Xhx70RqxWVqW9au?=
 =?us-ascii?Q?R3XpNoFbsP1FxWhwsHC/8jqtswkt9GrNBfsg2r7mOxLz4fbkIkasRnuuXmbH?=
 =?us-ascii?Q?3H1V91mtQFC1JcNdLav6x6r7+RUJZmCw6XP0MA9PlnCowvKRhunxpCRCRZQI?=
 =?us-ascii?Q?Tj0tRmj3ZmUz1gWzmKp71vwgmC+0lzsgjFPkow21Cbx7F+mz1nxJLWQr7fI7?=
 =?us-ascii?Q?R3XL+afjS77/6+1Qs8oXftvoNv71xnql2Uh0A4NUmDJ9g8/ENVwMhLrdrvrm?=
 =?us-ascii?Q?9aVg5q8iNyboGMvm0paP2bhHm9aTjI33B2iWcCJNo2HBhYYANOyFkitAa/Kf?=
 =?us-ascii?Q?aNoKSlqa4321/dAdLGsl7s4kRSpqsU0tXODBEnvENeDYSDYC87HjiY06WoC0?=
 =?us-ascii?Q?T2dHC1JSVTs5wA0BOCGPjhOqh6WH5XSOcL27Mv3FFIy8Ajkd+uPr/gzqrx2d?=
 =?us-ascii?Q?pfMCwAymSBcYefULgA3zNoSlsmblSJm0Df6o92Wr0kBlysg/+5ljqQBEhtoQ?=
 =?us-ascii?Q?NJKMZ1RMtWVi6ncOlP9g5othIkaT/dPKe74wjomTN/yOH0x1Pfe9Jaf5EyLS?=
 =?us-ascii?Q?eHCw3K5m8Fpx+EVzTnUMlnO3KKHVxlZJTFFhDt4IkEac94OOYULk8Wxjngc3?=
 =?us-ascii?Q?vyQqIeB9Yp4ksIO6mf+qPg2+tgpWBYehwrZgolluwUSg6/xEG7SypdeTUrt6?=
 =?us-ascii?Q?4Ci2x8U6a6bTJ6QGRkgOrnEPQQQbBnPnEryAiU/+iWRBr2vRR3O4di7RSyq4?=
 =?us-ascii?Q?GZgyZh5whSJcpka8my1HBtHFaS/2Cq4SOdDE3YfdYdTQDvtvfGXJfYW9yM7c?=
 =?us-ascii?Q?7JdlSLJ+FYFDUw8bZZpKmxBb8mGRbcst0Oqs7CUokAzuaF/P2MC4yao0+Gef?=
 =?us-ascii?Q?XtzJQ3ufrfWK2zYVm7rs0poQXg5gb9MiyfVHVF1EFNaee9hNHbByDo4Rn3Yk?=
 =?us-ascii?Q?47yNt9opq+Y07LljUlIBZEIfFgfOybWUigQKTN193TadlpphIlaft/MOif/6?=
 =?us-ascii?Q?r8CYXSa6346JUYiPfDHQzizEWU0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a0c615-9aa0-417a-be50-08dc73732444
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 17:35:54.7367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XR2j1/KRj7C/NaBl2xGRgiP7j3bgP0SyiWrRTK5UG67aiSwRiKktlYEluvrBeC3R6FdLrEOU671GfuEe3sBBTo8aVxBwBFCOgFEiwvvYhhwM2Sr++iWVIaB0k9mNV/z6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6191

From: Adam Young <admiyo@os.amperecomputing.com>

This series adds support for the Management Control Transport Protocol (MCTP)
over the Platform Communication Channel (PCC) mechanism.

MCTP defines a communication model intended to
facilitate communication between Management controllers
and other management controllers, and between Management
controllers and management devices

PCC is a mechanism for communication between components within
the  Platform.  It is a composed of shared memory regions,
interrupt registers, and status registers.

The MCTP over PCC driver makes use of two PCC channels. For
sending messages, it uses a Type 3 channel, and for receiving
messages it uses the paired Type 4 channel.  The device
and its corresponding channels are specified via ACPI.

Adam Young (3):
  mctp pcc: Implement MCTP over PCC Transport
  mctp pcc: Allow PCC Data Type in MCTP resource.
  mctp pcc: RFC Check before sending MCTP PCC response ACK

 drivers/acpi/acpica/rsaddr.c |   2 +-
 drivers/mailbox/pcc.c        |   5 +-
 drivers/net/mctp/Kconfig     |  12 ++
 drivers/net/mctp/Makefile    |   1 +
 drivers/net/mctp/mctp-pcc.c  | 372 +++++++++++++++++++++++++++++++++++
 include/acpi/pcc.h           |   1 +
 6 files changed, 391 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.34.1


