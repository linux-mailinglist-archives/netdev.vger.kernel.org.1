Return-Path: <netdev+bounces-99101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDC18D3BAB
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573E5286AC6
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3B6181D10;
	Wed, 29 May 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fofaJ1qz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B10181CFA
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998512; cv=fail; b=eONjVL7tKoPV3jXpz6q1HBNZHCejOfX5vKB/aDfX+tgTzitszt5i5JUcrLJAmiIzOv1cabuSd0ZHbukURl7pq1301C42x9cHfQkW8FLvF6OmB/9TEBVhYw5hLH00oyXvrD4qGxhq0YMjI+TkxqqZkiAcNuIvNWfq+3y9X2Xn0d8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998512; c=relaxed/simple;
	bh=aEAraWSEIBlowd8r9fMkEamosHVPtl+CxsHrtg4VhJc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FMzlHuQRpi9aIIYKQEGNkk6aNtQ6WSdU8OilBdqfUeBkxH62vM89lxp3ep0Bc9QN0xby3v8ZXT7YQcqIvRYVaTHd5Jy9nDciGlQwg9YWIYkdhRQDGRgzWJGARSmttBYT+PcI5ZiU12p+nTU6DVCLlGYQltczuVDpzJp0wBN7TFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fofaJ1qz; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTThEsrV10ACLfhBNGUISa/3B0rp3mXoJXSmHRPMNV2KH1fpzup2nyWJFda8PdtIx/Kx76V85LkNsNRA2iPPeUfaywVAY5+3RWFuopsUJP/lOHX9TTkeYLFngtU0pYYtg7MWBs2w7ynGkVQC6OtpLiM4dx2/Dz2uM5XSOrcnsYNRvEXUY0665Ir4i8nNuI5Iiu82hHZR8T32z75rWr7V5hAaiAtd/mmJYLk+KlfYYQonjoLl5e4QghwL79N8xdBmTHvdq6eVjf70JyUn0n0a9xjWCZPEkiJqboA27ximD/caw0H6hENCMMlXoik+FJIjdgWSooS1ilVivr2uk/AyRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBzBsHzgstaL/HlbZ4NmU0fuN1WLTNZHunNfVnTXWvU=;
 b=ClVQRVb068+MDpWG9IwQ5FRXZHjPPDt9BZQu/uDXQoim8Lp60p6LUF1+n4SWDFIH/93iF5FnBdXd4ue6Lc4u9O5xybe76gapC6GITL3bmtfgqOQiHy6c5063SxSNqLw82YM5o6AW/GmdShu7C4f3WMB8CcV15XRNpF8djThmkYoteg5F7oMfCezSa/zZUAuuLF33jAYVQUiQn0XxeOWxSi9tylxLr4dtXRfGwt6efH3d5bstJf+NMjILbgsneh2oFL0uDI+9iGGqXP4BZqPxlN9zPz1dYjDsD/iEpxqYZG/V3fi6RyqdNrfDPr9CMHTfIH3Oe7WRs6zQglSjJnUM5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBzBsHzgstaL/HlbZ4NmU0fuN1WLTNZHunNfVnTXWvU=;
 b=fofaJ1qzaNWTUWDEYOrhe8wm+iz2nLOzAIXPId9w+FGlS31G8xfe5lOXO2riiRda+m/ZS9qpvVkBkCGaL/2K6K4BV4L8aXE8IPKv9frGpgIOlPzIPEV+wmmfACOO0pexkswHyKpCPRs3qyZ4rWbkwOP8Sa/NC+eXJPi3MweXxwxESabIxpj+36lV56xTi+w0F6bDSABkw0CcyKOjOdWuzdvqpJEI2uPaLGSQfD2Wd6rbcWyGburphe2NR+ArhOMekuLAvuq20PLGMh2W5ditUkKzOFPgQjH8EFSQr/oHCNwT2x9TIPOUfrrUszm0mLq5kCOMf3mitb0ehoXzJKdWzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DS0PR12MB7972.namprd12.prod.outlook.com (2603:10b6:8:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 16:01:28 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%6]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 16:01:28 +0000
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
Subject: [PATCH v25 05/20] nvme-tcp: Add DDP offload control path
Date: Wed, 29 May 2024 16:00:38 +0000
Message-Id: <20240529160053.111531-6-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529160053.111531-1-aaptel@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::15) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DS0PR12MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e88176e-7bb6-4f0b-f1b2-08dc7ff8995d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uc9zEzcMFkqA5ojDdXeOn3baQcfDIpdDlc3I35bktSdmchP0m2ngsWftrnSf?=
 =?us-ascii?Q?rWkScCCvdocPGz8ntPlli5nkYM3p1cOET8gN81530XA4sTo8EaRkt6BvRjRE?=
 =?us-ascii?Q?ScuFf2d7WhKiSiVbUWasaRBddSAYxIooLSwXRWMjsotEFUFbSmGn4W8lSoxQ?=
 =?us-ascii?Q?k1Z7j9ycEgNDGehi20EBCJ+tnSQ33uv09YyXjrRywKPJTiMQMPTWZZEfQqi0?=
 =?us-ascii?Q?Y24YTSO3Ylm2MlTsg3JqVM0BLdBp2o6B1E2sM4MWtp4HvJuzAWDM3SzsiHwW?=
 =?us-ascii?Q?ROqY61Mz/7XBv5p+Wz6U7/KgKnCuoOBDLCNPcvl60nbOpOYM9p+AEe5dL5Va?=
 =?us-ascii?Q?9s9c2GVlUF8dmNCyy2iVozlfbL6cx/12JiFG5JAXOGA1SvV6oZP+I6VgAu9m?=
 =?us-ascii?Q?H1tB5/wgknc+cy1mpfezN3m5mHhIHvbH1NXmZ6+qDDOc+k7C4oCS2O7OaKeR?=
 =?us-ascii?Q?kUkVjJ+SjTKJzKsMioek+ueS7cvTcPpf0WwMOOuCAs1k+yA/EcZj2U7Z3PNq?=
 =?us-ascii?Q?VVjBS5B7AHZYYBlV7vxJUmqhjIzl8IZSBOG4Rc6tHnCPQeCDLEUYnUMbXb/5?=
 =?us-ascii?Q?4ul7bvN7DLq014mSir+2eI2rUQjlie9YSR1evhZmfjTe8gyghUvYdSb9ik/7?=
 =?us-ascii?Q?F9DRO7akr+dXFoa1N5I9yToQ0OtqAPDYr8vZ7tgyPmWWZ8tjVVrApN+0lAho?=
 =?us-ascii?Q?go9tOCDv4ZvFQ0DEc9gWy+KEwSSMgoN9CxfCTwLGjJAPfFT/qyeGkj4qs/Ns?=
 =?us-ascii?Q?Alx+5foEiW1bvXVX61BysGV3IHebvWJBPhHkmIY2VbJRdC+vyl/HEZH72Swj?=
 =?us-ascii?Q?UJOaXHdZMU7GoWKtxKThBo1ekQjSjev7jMGx9OXZemXBIPHlgHX0aucdbxE+?=
 =?us-ascii?Q?ncrmF2A5eeSvO9hSsG6ghYiW44GXoI5gC8aY22zP8b73XHgpbWsErhBzi6Gh?=
 =?us-ascii?Q?Jw7JU6RHL5sbh+5JTNyqRJBArJ0qy5yGNoKEqEXGsNSawp55B8udwNZT/Pax?=
 =?us-ascii?Q?X/0K6SLr1r5kYFG6jQsZXIJinIqi9Ev7vuY8jFjLtZ6o/SFtjT2yZLgizvMj?=
 =?us-ascii?Q?2bdh6DF8+zO/lSFp3khii8ua3eosX3t4new3ljE2lk96+/b52TxwuiO40mGj?=
 =?us-ascii?Q?ygry+kQ7aaA09piQ9lUs93gmxnaiGD+3Uy4flfentJTI6zNJMeiOsVYRuQ66?=
 =?us-ascii?Q?s9bEcSX/IhwQUJSHffRe4ir9W1lDPo6VxQhHqy7KTisNE0T5Krdpp8MIniIL?=
 =?us-ascii?Q?jYhUJ/cZoZw1xUo6vyOPCGYLecjex3rRjsEw8A1qKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jbdd7RoWdW5U2jSVP2zq5yiuFAkLSSN0dSxHoWGw1Bk3ogo2J1+4nRj6d9ci?=
 =?us-ascii?Q?k261mpnVsh6F7RhZKW0RNeJ99sXvufYbjEl88h+hbe3l76fNqnEfm2dhnx0H?=
 =?us-ascii?Q?blYn00lQ4zIp50bzGHssgBbjAKxTWJY8H54MWMeJr4MMyGvQtpHNHdamUTCO?=
 =?us-ascii?Q?Obequc2FwtCDFEfF3ZI/LZ0ULG6w5mtOl3sp4KFyzE5EsDBRlzgNfTNnasRL?=
 =?us-ascii?Q?v6VAYv3KF19c8g9AnOX7EluHl8an89WebHixLxZwUoK+q/rDEA48J8CsCRML?=
 =?us-ascii?Q?SaQOyKGx+NSCNQ4vLy6nwcqEc5OUuuuNE+MXtfEVmM5dA+b3p9X2s1pmAuqK?=
 =?us-ascii?Q?pH5+Ge9lVTjEMbdo5H+vtjmiXiR+FY9WJIgWC1oBvQpRnMOMzqCr2IsIFG3O?=
 =?us-ascii?Q?QjQFKjFHaY8fpFLj/2xOhKIKZiKVtCoEwJj2H9lxG5QahIjWDE4L5OQCKAS0?=
 =?us-ascii?Q?FEaZccAhM8QqpTrBpwxl1EOBGQvxW9Y0SOiCaR3mz3JPDFjF5TXIauGvSAPh?=
 =?us-ascii?Q?wOta/0V8fLIqUKT18ncxqvXXlHbI/i6xpY0kOun+V4LozvLB+ivZG+/W1Yc6?=
 =?us-ascii?Q?j0mzvwuakY+4npCG0WDzy1TfTD198iAnRQIebbA5vwWocFADN8V/lPrnix3y?=
 =?us-ascii?Q?GnRe25YrWTp+7VKS2OKygfIYwYAcv/dbSSHHrLZZFfcvvQ9HUo3LnlmJI94k?=
 =?us-ascii?Q?tPPMJBR8r3HY6okJ6Pc7Nnn/IvHBjAinq9a+L17El3ijlQY/m4enH/VzInYc?=
 =?us-ascii?Q?RXmg0ym2qHd/migeuX144tFrBQPNgynqa+bNEDUS5Mlww8urkXnRYaT5mN8c?=
 =?us-ascii?Q?sv7wllMQ6yWG63Uvv9sLNF1Xb6L+oV20h7H01Tp8kdRnZdVUA2VrvchDwBwh?=
 =?us-ascii?Q?15qSEUVmYirturji7ujh7GdmY4bdSRSwDXUO5wm6gOi/+GhmOv2k+yK9P+DK?=
 =?us-ascii?Q?LsvqXyYq2/vWR7Ro5ZxAwMSj01yveP1DlLxfWDf/Bhtx8pTPY3QSeOHDm4+O?=
 =?us-ascii?Q?PXcMDlsARL3WVZ4V23oE+jRcF9MS6o/qm2VgkVDYrmVt0Ye2HCXut1xQHYzr?=
 =?us-ascii?Q?RUmegJ8woa4UJBMchMlctP/04uj18eHDE2PAPYotRB7w9Mso+O+F5wLplnf7?=
 =?us-ascii?Q?bLFw4iOXWws0ZANRoUL1OVkwipBcvIeY8oCk5RWojn/rvEPQ3kwoBzE5r6DM?=
 =?us-ascii?Q?WekL2GSVN6oArZaUMYM5BO17TQaYNTAEL9+9wt0cRcQekR50NRS5ZKG1Vlr+?=
 =?us-ascii?Q?YZl/7IYz5rQljK5Z5ChsT+q3rufs3FJAiNkBvQXYaDT508Myxv6lvDKkbyw1?=
 =?us-ascii?Q?r7yWh9tzNYymouJLgy11o3OtM1P3txoZgl/S96lhoXRv40gYPjdIBdoUogT/?=
 =?us-ascii?Q?Rg+p/yJ7BGwqhG90XRLW06XVdcBiTGxIfgL6iMfVM5+XTlEwAI9jTpqYoFRZ?=
 =?us-ascii?Q?c1raDW8Ct9bO9Dz4gEvxxntLKwtpphkwhh2sx24l5KGgSjahM5i89bWN/trw?=
 =?us-ascii?Q?ijGHf4GDtDjfEpDo6e/n0Rh9j0oaa9Uq3kaup8m6Xye68FVw9nn9GVnauP5+?=
 =?us-ascii?Q?aAoXYuuBzlvphL0Ur1WgKKLdhTDfyu47buAOS8LY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e88176e-7bb6-4f0b-f1b2-08dc7ff8995d
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 16:01:28.3281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0CI6dG7cay+34tAWMRqHbwwCk/5v7BfK6OHyLxGWL4vP0vuAdm+IaYr4FqQbUfFmq4UxBcK5us3aCfH9ZfJ6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972

From: Boris Pismenny <borisp@nvidia.com>

This commit introduces direct data placement offload to NVME
TCP. There is a context per queue, which is established after the
handshake using the sk_add/del NDOs.

Additionally, a resynchronization routine is used to assist
hardware recovery from TCP OOO, and continue the offload.
Resynchronization operates as follows:

1. TCP OOO causes the NIC HW to stop the offload

2. NIC HW identifies a PDU header at some TCP sequence number,
and asks NVMe-TCP to confirm it.
This request is delivered from the NIC driver to NVMe-TCP by first
finding the socket for the packet that triggered the request, and
then finding the nvme_tcp_queue that is used by this routine.
Finally, the request is recorded in the nvme_tcp_queue.

3. When NVMe-TCP observes the requested TCP sequence, it will compare
it with the PDU header TCP sequence, and report the result to the
NIC driver (resync), which will update the HW, and resume offload
when all is successful.

Some HW implementation such as ConnectX-7 assume linear CCID (0...N-1
for queue of size N) where the linux nvme driver uses part of the 16
bit CCID for generation counter. To address that, we use the existing
quirk in the nvme layer when the HW driver advertises if the device is
not supports the full 16 bit CCID range.

Furthermore, we let the offloading driver advertise what is the max hw
sectors/segments via ulp_ddp_limits.

A follow-up patch introduces the data-path changes required for this
offload.

Socket operations need a netdev reference. This reference is
dropped on NETDEV_GOING_DOWN events to allow the device to go down in
a follow-up patch.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 268 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 255 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 28bc2f373cfa..95a36b48fd0c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -21,6 +21,10 @@
 #include <net/busy_poll.h>
 #include <trace/events/sock.h>
 
+#ifdef CONFIG_ULP_DDP
+#include <net/ulp_ddp.h>
+#endif
+
 #include "nvme.h"
 #include "fabrics.h"
 
@@ -54,6 +58,16 @@ MODULE_PARM_DESC(tls_handshake_timeout,
 		 "nvme TLS handshake timeout in seconds (default 10)");
 #endif
 
+#ifdef CONFIG_ULP_DDP
+/* NVMeTCP direct data placement and data digest offload will not
+ * happen if this parameter false (default), regardless of what the
+ * underlying netdev capabilities are.
+ */
+static bool ddp_offload;
+module_param(ddp_offload, bool, 0644);
+MODULE_PARM_DESC(ddp_offload, "Enable or disable NVMeTCP direct data placement support");
+#endif
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /* lockdep can detect a circular dependency of the form
  *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
@@ -127,6 +141,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_ALLOCATED	= 0,
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
+	NVME_TCP_Q_OFF_DDP	= 3,
 };
 
 enum nvme_tcp_recv_state {
@@ -154,6 +169,18 @@ struct nvme_tcp_queue {
 	size_t			ddgst_remaining;
 	unsigned int		nr_cqe;
 
+#ifdef CONFIG_ULP_DDP
+	/*
+	 * resync_tcp_seq is a speculative PDU header tcp seq number (with
+	 * an additional flag in the lower 32 bits) that the HW send to
+	 * the SW, for the SW to verify.
+	 * - The 32 high bits store the seq number
+	 * - The 32 low bits are used as a flag to know if a request
+	 *   is pending (ULP_DDP_RESYNC_PENDING).
+	 */
+	atomic64_t		resync_tcp_seq;
+#endif
+
 	/* send state */
 	struct nvme_tcp_request *request;
 
@@ -194,6 +221,13 @@ struct nvme_tcp_ctrl {
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
+
+	struct net_device	*ddp_netdev;
+	netdevice_tracker	netdev_tracker;
+	u32			ddp_threshold;
+#ifdef CONFIG_ULP_DDP
+	struct ulp_ddp_limits	ddp_limits;
+#endif
 };
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
@@ -305,6 +339,174 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 	return nvme_tcp_pdu_data_left(req) <= len;
 }
 
+#ifdef CONFIG_ULP_DDP
+
+static struct net_device *
+nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
+{
+	struct net_device *netdev;
+	int ret;
+
+	if (!ddp_offload)
+		return NULL;
+
+	rtnl_lock();
+	/* netdev ref is put in nvme_tcp_stop_admin_queue() */
+	netdev = get_netdev_for_sock(ctrl->queues[0].sock->sk, &ctrl->netdev_tracker, GFP_KERNEL);
+	rtnl_unlock();
+	if (!netdev) {
+		dev_dbg(ctrl->ctrl.device, "netdev not found\n");
+		return NULL;
+	}
+
+	if (!ulp_ddp_is_cap_active(netdev, ULP_DDP_CAP_NVME_TCP))
+		goto err;
+
+	ret = ulp_ddp_get_limits(netdev, &ctrl->ddp_limits, ULP_DDP_NVME);
+	if (ret)
+		goto err;
+
+	if (ctrl->ctrl.opts->tls && !ctrl->ddp_limits.tls)
+		goto err;
+
+	return netdev;
+err:
+	netdev_put(netdev, &ctrl->netdev_tracker);
+	return NULL;
+}
+
+static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
+static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
+	.resync_request		= nvme_tcp_resync_request,
+};
+
+static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
+{
+	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
+	int ret;
+
+	config.affinity_hint = queue->io_cpu == WORK_CPU_UNBOUND ?
+		queue->sock->sk->sk_incoming_cpu : queue->io_cpu;
+	config.nvmeotcp.pfv = NVME_TCP_PFV_1_0;
+	config.nvmeotcp.cpda = 0;
+	config.nvmeotcp.dgst =
+		queue->hdr_digest ? NVME_TCP_HDR_DIGEST_ENABLE : 0;
+	config.nvmeotcp.dgst |=
+		queue->data_digest ? NVME_TCP_DATA_DIGEST_ENABLE : 0;
+	config.nvmeotcp.queue_size = queue->ctrl->ctrl.sqsize + 1;
+
+	ret = ulp_ddp_sk_add(queue->ctrl->ddp_netdev,
+			     queue->sock->sk,
+			     &config,
+			     &nvme_tcp_ddp_ulp_ops);
+	if (ret)
+		return ret;
+
+	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+
+	return 0;
+}
+
+static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
+{
+	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	ulp_ddp_sk_del(queue->ctrl->ddp_netdev, queue->sock->sk);
+}
+
+static void nvme_tcp_ddp_apply_limits(struct nvme_tcp_ctrl *ctrl)
+{
+	ctrl->ctrl.max_segments = ctrl->ddp_limits.max_ddp_sgl_len;
+	ctrl->ctrl.max_hw_sectors =
+		ctrl->ddp_limits.max_ddp_sgl_len << (NVME_CTRL_PAGE_SHIFT - SECTOR_SHIFT);
+	ctrl->ddp_threshold = ctrl->ddp_limits.io_threshold;
+
+	/* offloading HW doesn't support full ccid range, apply the quirk */
+	ctrl->ctrl.quirks |=
+		ctrl->ddp_limits.nvmeotcp.full_ccid_range ? 0 : NVME_QUIRK_SKIP_CID_GEN;
+}
+
+/* In presence of packet drops or network packet reordering, the device may lose
+ * synchronization between the TCP stream and the L5P framing, and require a
+ * resync with the kernel's TCP stack.
+ *
+ * - NIC HW identifies a PDU header at some TCP sequence number,
+ *   and asks NVMe-TCP to confirm it.
+ * - When NVMe-TCP observes the requested TCP sequence, it will compare
+ *   it with the PDU header TCP sequence, and report the result to the
+ *   NIC driver
+ */
+static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
+				     struct sk_buff *skb, unsigned int offset)
+{
+	u64 pdu_seq = TCP_SKB_CB(skb)->seq + offset - queue->pdu_offset;
+	struct net_device *netdev = queue->ctrl->ddp_netdev;
+	u64 pdu_val = (pdu_seq << 32) | ULP_DDP_RESYNC_PENDING;
+	u64 resync_val;
+	u32 resync_seq;
+
+	resync_val = atomic64_read(&queue->resync_tcp_seq);
+	/* Lower 32 bit flags. Check validity of the request */
+	if ((resync_val & ULP_DDP_RESYNC_PENDING) == 0)
+		return;
+
+	/*
+	 * Obtain and check requested sequence number: is this PDU header
+	 * before the request?
+	 */
+	resync_seq = resync_val >> 32;
+	if (before(pdu_seq, resync_seq))
+		return;
+
+	/*
+	 * The atomic operation guarantees that we don't miss any NIC driver
+	 * resync requests submitted after the above checks.
+	 */
+	if (atomic64_cmpxchg(&queue->resync_tcp_seq, pdu_val,
+			     pdu_val & ~ULP_DDP_RESYNC_PENDING) !=
+			     atomic64_read(&queue->resync_tcp_seq))
+		ulp_ddp_resync(netdev, queue->sock->sk, pdu_seq);
+}
+
+static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
+{
+	struct nvme_tcp_queue *queue = sk->sk_user_data;
+
+	/*
+	 * "seq" (TCP seq number) is what the HW assumes is the
+	 * beginning of a PDU.  The nvme-tcp layer needs to store the
+	 * number along with the "flags" (ULP_DDP_RESYNC_PENDING) to
+	 * indicate that a request is pending.
+	 */
+	atomic64_set(&queue->resync_tcp_seq, (((uint64_t)seq << 32) | flags));
+
+	return true;
+}
+
+#else
+
+static struct net_device *
+nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
+{
+	return NULL;
+}
+
+static void nvme_tcp_ddp_apply_limits(struct nvme_tcp_ctrl *ctrl)
+{}
+
+static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
+{
+	return 0;
+}
+
+static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
+{}
+
+static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
+				     struct sk_buff *skb, unsigned int offset)
+{}
+
+#endif
+
 static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
 		unsigned int dir)
 {
@@ -753,6 +955,9 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
 	int ret;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_resync_response(queue, skb, *offset);
+
 	ret = skb_copy_bits(skb, *offset,
 		&pdu[queue->pdu_offset], rcv_len);
 	if (unlikely(ret))
@@ -1816,6 +2021,8 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	nvme_tcp_restore_sock_ops(queue);
 	cancel_work_sync(&queue->io_work);
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_unoffload_socket(queue);
 }
 
 static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
@@ -1832,6 +2039,20 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 	mutex_unlock(&queue->queue_lock);
 }
 
+static void nvme_tcp_stop_admin_queue(struct nvme_ctrl *nctrl)
+{
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+
+	nvme_tcp_stop_queue(nctrl, 0);
+
+	/*
+	 * We are called twice by nvme_tcp_teardown_admin_queue()
+	 * Set ddp_netdev to NULL to avoid putting it twice
+	 */
+	netdev_put(ctrl->ddp_netdev, &ctrl->netdev_tracker);
+	ctrl->ddp_netdev = NULL;
+}
+
 static void nvme_tcp_setup_sock_ops(struct nvme_tcp_queue *queue)
 {
 	write_lock_bh(&queue->sock->sk->sk_callback_lock);
@@ -1858,19 +2079,37 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	nvme_tcp_init_recv_ctx(queue);
 	nvme_tcp_setup_sock_ops(queue);
 
-	if (idx)
+	if (idx) {
 		ret = nvmf_connect_io_queue(nctrl, idx);
-	else
+		if (ret)
+			goto err;
+
+		if (ctrl->ddp_netdev) {
+			ret = nvme_tcp_offload_socket(queue);
+			if (ret) {
+				dev_info(nctrl->device,
+					 "failed to setup offload on queue %d ret=%d\n",
+					 idx, ret);
+			}
+		}
+	} else {
 		ret = nvmf_connect_admin_queue(nctrl);
+		if (ret)
+			goto err;
+
+		ctrl->ddp_netdev = nvme_tcp_get_ddp_netdev_with_limits(ctrl);
+		if (ctrl->ddp_netdev)
+			nvme_tcp_ddp_apply_limits(ctrl);
 
-	if (!ret) {
-		set_bit(NVME_TCP_Q_LIVE, &queue->flags);
-	} else {
-		if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
-			__nvme_tcp_stop_queue(queue);
-		dev_err(nctrl->device,
-			"failed to connect queue: %d ret=%d\n", idx, ret);
 	}
+
+	set_bit(NVME_TCP_Q_LIVE, &queue->flags);
+	return 0;
+err:
+	if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
+		__nvme_tcp_stop_queue(queue);
+	dev_err(nctrl->device,
+		"failed to connect queue: %d ret=%d\n", idx, ret);
 	return ret;
 }
 
@@ -2081,7 +2320,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 
 static void nvme_tcp_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
 {
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	if (remove)
 		nvme_remove_admin_tag_set(ctrl);
 	nvme_tcp_free_admin_queue(ctrl);
@@ -2124,7 +2363,7 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
 out_stop_queue:
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	nvme_cancel_admin_tagset(ctrl);
 out_cleanup_tagset:
 	if (new)
@@ -2139,7 +2378,7 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 {
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	nvme_cancel_admin_tagset(ctrl);
 	if (remove)
 		nvme_unquiesce_admin_queue(ctrl);
@@ -2431,7 +2670,10 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
 
-	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
+	if (nvme_tcp_admin_queue(req->queue))
+		nvme_tcp_stop_admin_queue(ctrl);
+	else
+		nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
 	nvmf_complete_timed_out_request(rq);
 }
 
-- 
2.34.1


