Return-Path: <netdev+bounces-301197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ssDwFA2cOWpevgcAu9opvQ
	(envelope-from <netdev+bounces-301197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 22:33:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A63D26B247D
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 22:33:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Kb8HK5AQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301197-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301197-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDEB5304EBA9
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 20:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7302534E75A;
	Mon, 22 Jun 2026 20:29:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E88C34D93B;
	Mon, 22 Jun 2026 20:29:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782160177; cv=fail; b=i75TxpCc8ThC4+6ot/7mUnmONU4fYYLRfQbAgwnRIsycuCohMSjcKdQSHfaTskzxMoiJ+d+LbOfnBCiHjDl8oUip4LSiK42OipoluQVmQc/Q927T+uErmRaxSu+RfWWYqWMwcaEEx9kaHyjdMcreewZRSyN/ypPUsSl6zbC4qFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782160177; c=relaxed/simple;
	bh=gGrNT/o8JKJ3JxkDPRx40IbU9uZ2N7Zq1Omw63IGuME=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ki1sqVoll2RtcI6HatLNYyrAMMkVOya4xyb2LOaRWi9OdzTV3MzAVAV/yiU5Oho9oYj8FVo5clS2L1Wu1zxpEcLTcoLvBmqah8PGfTEgXqnV2VS7g64DZsWKHLV7OAQKLd55ryZ7WYlS3iq75kR6QH8oZdkJvWV871Xo/Y5lznY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kb8HK5AQ; arc=fail smtp.client-ip=52.101.46.9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYtiWUc+0R4jKyl3TTh2yVW1gX8PJirW8184QXEYtGacv5eQwbpN5Bow6KLHNlNlVQd1P4Pdewm2bNbr7KgAquBwVyecNM9AEdSx9ZPf/ovC4NnOav5DalMJxYOMv6gz69SoL+1oyoNrOkoD82d/EI5QIZ7DCt3bP+gWed5OYSJ/kC86lkEEHJBYCVyey5AfSam/KlasDR2RdOlZ49hVINJz7si8OiaN63Rg5YeIF2jy9ICJQ2JebnVOw+hhlCrOWx0YXMqy+Qys1HTWUfhS9ngZq/SqjQ4BCJy+duNrUTxoVH1JcYcG9fCrV30A3TrBp4VDLapPLaswvlFoCHN5jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poshX01D31s4IwXi4YvIE4tXZpVBpaIHUoSeSYmK03Y=;
 b=tMUM/HANdwuR2ErKRm7jaqlt7Ly1rfcjI5T+9Z+zocMCb1KS45w28eiMVUTvRnBQsUlQo4qp9AH+Qaqi5suLqS8oXm7NbkBcx3jE+pW1wvflv3n7JGloyiQELVjmk5V2GMByHda12eKHFee2dj3jXjzl1mzao2BiMnxtutmR8zK7DsuVesbcjZ4KFFb8vXORLA4bfDjC8tRWQh9gu+j/D5xdKuOkOII5ia6X4Dwgsuc1SQYYHp5fkrWchpHypbAPrXS9lprW5NXEoyTyqL9jKHVzi+2owFkeO/HPc5eodj3c7ymj0LMMTmPM+RJe350qu5SZBRuc7h5Wy3YeG/KNyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poshX01D31s4IwXi4YvIE4tXZpVBpaIHUoSeSYmK03Y=;
 b=Kb8HK5AQPqneCmG1XBoKId5uyePRp4LKsf8Yhk0hn0C94vif19uEovGqvFM/XKG9v4MuZBBfb+a01/plF6abLzH/gQ/lwazBpGPkWFmBktj0mevKaqTJR3XnAXDvxpFeblndpqqIXhx4+fdc/2rxyg11W/CKfYF44jb9Qs2TcwLAzVgLKpO5YgG1/0Y36/JfmhjC/EMla1Y/Lz6oE8i7jVlwAsgCDxhwlNkfMxFeqeZgXOU/OqqZ2D7NtgWs1Zx1NHwWCuBbHuA+WGEKGxebo50sPHmn8CVwxpPwglG13qvQBGJZgp7ZBEXxf1sd3wxOjLw2RNZi5T1W1D+pvod58Q==
Received: from PH8P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::27)
 by PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 20:29:31 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:2d7:cafe::17) by PH8P222CA0017.outlook.office365.com
 (2603:10b6:510:2d7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 20:29:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 22 Jun 2026 20:29:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 13:29:03 -0700
Received: from 82875d6-lcedt.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 22 Jun 2026 13:29:02 -0700
From: Nirmoy Das <nirmoyd@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
	John Fastabend <john.fastabend@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Nirmoy Das
	<nirmoyd@nvidia.com>
Subject: [PATCH net-next] selftests: tls: size splice_short pipe by page size
Date: Mon, 22 Jun 2026 13:28:47 -0700
Message-ID: <20260622202847.3944076-1-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 40d7cebb-d79c-45ed-fae9-08ded09cf73a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	8UH2nq4B09wWqnFu0ND9Nmenm2vEudFvh3nrupLRPfKx9+X0mGdiuDLcWKUhPwRhceWkP+pJWlHBMK3/UxVEoQkKgZMf4+OYchiPeiqZE7s4xZDjrlO4t/zoHhr5g7Qnn4qG+psvXUSo71mH7gM6FPWIuDKsmimaHp3WvcjK/L90fwGVHqBCSnbbvDjHlk1PzR/MemqpDXXTTSnHO4h9s4x9PT7CjbV8C6IIg+sKDA6rFegFeewdG8VLYIZIe6wYkEDKrzDJrmI4zSIQvvW0HmvsGBYdknF13N2K0WnuDZ35cLgmL5M79kEKE66Bl94jgrs+XZ2cXTyj8Dx06WMZckHSTNFDiLhitimCodtzTFqXLcD04ht0X61PqO5ixy7j8Ugh0yjS7nuUktpTsFtwj0Ikb5jqYgn2tmLEAc6nQeB/LoaoVvcfbbYFF08WVICjj5zdk9iKqQT2911vLgpTaUVBRBhybftuiWaYxDaEyhXHyFiPY7WaAaXAC4zW5zIrFmluekI614JWT4rkrt6ZUsN4ht4Eq52VuBv4Ruy5FKb6auvXmd8XEIRYdU1MQDOza9wny1deEbuvuvUQ0y8AOqGkD0MN1snuAF4J+iHQBHeL5T1NjMz8GnbnAz1TQe98Fg59+DsRBG0tNnweJgz8Tro81L+ifwQwbMCR/5qdPYQnRzlqxdmVmudaKvquyxGTK9WgiA1U0nsb8qr9s++31A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lRNTI4d0cDIPZ4tQsedKdfx2b/HpBSR4g+CiGo/5eE+4lhog2LmzRwd0bmhkkdhdssXwGTQZYXhoHSIEJ1IHNA2DoRIkeI5cxynWTmJhA1jiMaVfH9z116YKLGqcKDgjputPIGoa6No2CztHPPbCGbtzGNN440Cp1ByKDIryii8W7QTCCSk5bF7hqoIvK+Ys0+L/3S0Woap4EU3YKqNg99J9nmTVucybjoOGWfKjfK6V9ne65PBrQBniVZ+Z3quxXeIkat0KFAVKTfQGGIDVtelfRftTwr0Hgmah8YIwYuul7ipuBjBT778DPzz0dtR8Juagwoo7MWDyiebbo/rFm+Xxn9I6b0eiT22msYPNf4mI91ot/ejxCYSoc+Ud+8TT0YB0Q49+zpYnlHlvd+mScYFzrkm4lOp4F5xHEq52B3fkSIDDgt5qhdtHOqd8Fp99
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 20:29:31.3284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d7cebb-d79c-45ed-fae9-08ded09cf73a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:sd@queasysnail.net,m:john.fastabend@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nirmoyd@nvidia.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301197-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,queasysnail.net,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nirmoyd@nvidia.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nirmoyd@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A63D26B247D

splice_short grows its pipe with (MAX_FRAGS + 1) * 0x1000 so it can
queue one short vmsplice() buffer for each fragment before draining the
pipe. That assumes 4K pipe buffers.

On 64K-page kernels the request is rounded to 262144 bytes, which
provides only four pipe buffers. The fifth one-byte vmsplice() blocks in
pipe_wait_writable and the test times out before it reaches the TLS path.

Request enough bytes for the same number of pipe buffers using the
runtime page size, and assert that the kernel granted at least that much.
If an unprivileged run cannot raise the pipe above the system
pipe-max-size limit, skip the test because it cannot exercise the
intended path.

Fixes: 3667e9b442b9 ("selftests: tls: add test for short splice due to full skmsg")
Assisted-by: Codex:gpt-5
Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
---
 tools/testing/selftests/net/tls.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 30a236b8e9f73..e3bf4ade0f770 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -997,6 +997,8 @@ TEST_F(tls, splice_short)
 	char sendbuf[0x100];
 	char sendchar = 'S';
 	int pipefds[2];
+	int pipe_sz;
+	int ret;
 	int i;
 
 	sendchar_iov.iov_base = &sendchar;
@@ -1005,7 +1007,12 @@ TEST_F(tls, splice_short)
 	memset(sendbuf, 's', sizeof(sendbuf));
 
 	ASSERT_GE(pipe2(pipefds, O_NONBLOCK), 0);
-	ASSERT_GE(fcntl(pipefds[0], F_SETPIPE_SZ, (MAX_FRAGS + 1) * 0x1000), 0);
+	pipe_sz = (MAX_FRAGS + 1) * getpagesize();
+	ret = fcntl(pipefds[0], F_SETPIPE_SZ, pipe_sz);
+	if (ret < 0 && errno == EPERM)
+		SKIP(return, "insufficient pipe capacity");
+	ASSERT_GE(ret, 0);
+	ASSERT_GE(ret, pipe_sz);
 
 	for (i = 0; i < MAX_FRAGS; i++)
 		ASSERT_GE(vmsplice(pipefds[1], &sendchar_iov, 1, 0), 0);
-- 
2.43.0


