Return-Path: <netdev+bounces-260683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIvhCA09nmkrUQQAu9opvQ
	(envelope-from <netdev+bounces-260683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:06:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EFC18E492
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C94B30579F6
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 00:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED185E571;
	Wed, 25 Feb 2026 00:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PqaGa5IP"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F17E2BCFC
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 00:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771977952; cv=fail; b=YzMKdY3vdTRAGU3nXH5u5yPr3DrZq+y99ZzC6eT3dPM2Ge6cFW2t1c5hvIl0OHZGATEh8BiXAvQWKcv49r2xAqbDhd9A0m8/RtTTDdWoEDlxsq0XjdyqyEmfO4iJNlC675UHKxeEO80fl8bPua84sgSkqiUWzNIWrdKNiQJQu+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771977952; c=relaxed/simple;
	bh=tVlofcgDRRoICpSxRQZUFdmIcCThkyHwEft+bpFAtRo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K3cb2y1aWmmXm56At2wVU1DIO9/6uNTXYhmZMvWo88ssKY2N33EbuInrS9C3dp5mXMFscIokahAncK8XyJJ4ksIFf9YtamvoK6ueUGDaLHRsIGsvG1avcBOV+JibIRBDDSNjJNjBgyj+G19+ahMumhp2MMWccqVBWFDAiehn68U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PqaGa5IP; arc=fail smtp.client-ip=52.101.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vo9I40rGHkP7hkF6CPtBtUqDlaarBAB56shOxdrkaIkTxadN7CTcIFgVq/JJXONnLmBV6KcstFuMTz0jzenoXEW3sV7oLL1g8QlDn+4SMdLGAYkHvwKSnHMvL+xuuZ2pidbfd6jfcJKTobQ8mE6OTp6Mel9CiDvgatApgmmksJFvtd+7AXyOv7V3E+PIW0WCV+uLC7uIzm32T3b3cUW7G2u4UE0xbtM3lDRdcT7VaQK/xaQQSwHNIgPHENGct8l55G13Mz0nm5coeNaaH47Li39IKsWFPc+9w29leDEYxaDNo5O6iIG+9Cn8CMcJAMZs6Yahz9coBG4Y6RT4KF0eZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8C5aWxuFd0n8ft7oucW8zVUevrs/WoqEiesfcTPUD+4=;
 b=o5K8qUIjBEw9BfUB/MrSCB/c7IWhtMK9W4RVyS6EeGrRgMWJkbSuZF6O/QbE5Eepo/rN1xRZRex3tkbZUeCSbJnfTY7FV3HpzB6YCmeyS4yCgG5BsVmhVKg8Z+y/nwBkkxZG5x/1XY/09OyYdxeL4nxAQQpROTCYO8vIbrBNWb+IJuNWAMIkmkWKncrRn9PmH5WdgVTA89VfLwdidw6yRvPc6Rr0rRFKV6UxaLgh1AEHMJcz11ZihbYsrjixxmwMSB2B7Ytl7cj3di0Vq+9ikQ3qQyDpXE1/rJ9DUvJWA9D1ygU55H3GxmXPW1DuxFpeJxG1yu4JfarmNuvhOwat9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8C5aWxuFd0n8ft7oucW8zVUevrs/WoqEiesfcTPUD+4=;
 b=PqaGa5IP0QSh9BS5f1AyAUu7g6ukrvlHiOSCDQelQWDYWpnwTptAhiG2Yiju1ZEIcdkqUFXlvN2Q71IHMA4mMpzlhJTve1lqddV296zFaQNko8t/keJc1aJ3Pi+jJiwIcTF+xlLxPwbzKD+brTcFv4vGi00ygdLdY3zSPAy2Htk=
Received: from SA1PR03CA0001.namprd03.prod.outlook.com (2603:10b6:806:2d3::12)
 by DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 00:05:46 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:2d3:cafe::d2) by SA1PR03CA0001.outlook.office365.com
 (2603:10b6:806:2d3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Wed,
 25 Feb 2026 00:05:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 00:05:46 +0000
Received: from ubuntu24.e2e.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Feb
 2026 18:05:43 -0600
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <nikhil.rao@amd.com>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <sdf@fomichev.me>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <kerneljasonxing@gmail.com>
Subject: [PATCH net v5 2/2] xsk: Fix zero-copy AF_XDP fragment drop
Date: Wed, 25 Feb 2026 00:00:27 +0000
Message-ID: <20260225000456.107806-3-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225000456.107806-1-nikhil.rao@amd.com>
References: <20260225000456.107806-1-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|DS2PR12MB9615:EE_
X-MS-Office365-Filtering-Correlation-Id: 404c96be-d923-4c7c-1b37-08de7401a041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ULk6fMj8MjYf9apL92Crz4f1rAG7KOWBwt6xufKujg+kEh0XfQteJ0bwlVY?=
 =?us-ascii?Q?z5xResR/tK68Wp3o+tui7gL+TGCMihbGjBOk79n4aXdBxJS5pcsGzWHWNiT3?=
 =?us-ascii?Q?vF0TxTaAMoDfcemjED3Bkq8X9mBkarhvNy8QBVX7O8qn2NnLgvqV39y0lba5?=
 =?us-ascii?Q?dkL+mXFpaBvK6X6DOwfmBhYRdli0gPbdi69yiPnzknjALjWG9ZklacNPo9y0?=
 =?us-ascii?Q?CB7Nb4EbvJReTy7o7nHh+OwvTpR/SQG54zRRXQSwWC7cMg5lCDs/vOLmBFyw?=
 =?us-ascii?Q?FUVgvgklPR8OcEe97FscVJ4vXanH/NguqbFEYeKhUTJ+ZSsF066YoyRD0iZ3?=
 =?us-ascii?Q?PLYGkYZH6SyBK/WCqoUBrHz72CvFuFOLnidQupEQpYhCAFOzRIwmswP3eEmo?=
 =?us-ascii?Q?wCOQtvTt8zF788dRSVhvpMvwGOj1zzZKgCK9OIgmbS/BBahSrzC8EbaYjhTq?=
 =?us-ascii?Q?tWiXoCd8bHAo2WQIWmWhJkl+nm/uhXOOh5MwcUZjJgoyqFQafsDG2gWNaeOI?=
 =?us-ascii?Q?9bxCqdTGy+aYHfOYROl7DxUsTLi7zlPtTcgwznvPyakKqrxqVCyux1Lrv5tb?=
 =?us-ascii?Q?NP0JpbaGX9Q4vGzblA+hpXLtQwl8l8j5PZ4tY4oNflonPwopmklTXePv+81S?=
 =?us-ascii?Q?CVYc3P+4Rp1RSi2RQtFbRyiIbX3Jn+iKUKDmRG9Pw6EGjHgumrdwri9XbhL1?=
 =?us-ascii?Q?qEEp3puoE7x1j7cCV0tIjJ3jDyo1GariPaTplUGa49p6auVAoKJT2NTgI7hS?=
 =?us-ascii?Q?tpembfxGmpNQfdcmXbOuY2onZCB97dzRsYfXpPm4p9R7JOiVG499UJW20seR?=
 =?us-ascii?Q?XiCGwZb5daaJNtmtF7ie3mCALYk47hPQyQx1XfGweZS5+U9shFTwg1LsKzSz?=
 =?us-ascii?Q?0Td75JmLekYwjYp4feNID1f4LfrzdVpuqPj30QwAQgiDmxywisTIxGR3NCkQ?=
 =?us-ascii?Q?F2dTzS3yk1XPbsLutekGL4ndBIECon3GYW+cqUfmhpmqDbGL9F/DcjJFwZuw?=
 =?us-ascii?Q?LtvlRP0Xx8SMPzCDimbDG1IYSV1fh/8Y+NAY+IafAnAt2TtDd1yr4Go4Fi2J?=
 =?us-ascii?Q?HuIFU+BszETahpcVhdGjwcLE2rsLsjxO4vOLjllu1ubBPHHo9irAfUUscVGo?=
 =?us-ascii?Q?4ywtmjhV79D61xmqCBilOw0khsovyBqLl0jKx3wiaWdMl/lYcOp6pNs9lRJt?=
 =?us-ascii?Q?oeB/PEXZ4tsIUoluOGKxvUoGRkOWCkFk2THhI4DlqM+eOOScfhWDtAh6LsZL?=
 =?us-ascii?Q?h3rB6vkH4+9bckwryTAFsmSzHFbjxFAlZ6aE4y1Jdh833TCXGtJPKBxIG60m?=
 =?us-ascii?Q?aQ7C0sSrsKEkxJgiTQxI7C0+IrDr9aZFwVKjRlGLTAawFa9sFl0dCSgxX3Rl?=
 =?us-ascii?Q?DRb8DnH88irw/cjKXkNTm5SvBrGr+eXJz5UrosE0CZq5DuyYUiCuX9SSQEOp?=
 =?us-ascii?Q?ynO4f09pcIS2B6iv+jM0V6f7h7Pb2O/6RC+Vb4aPosAC4CkYcrhCfFI64ClX?=
 =?us-ascii?Q?FzKoMT0nnY1SG7YrhKohR13/5p7AnROZVdiAqxxFcdaQZjKtCB8ACUHiGlZD?=
 =?us-ascii?Q?MzySyJvfDwuceqGr00GQ5FzoLo3Sy4yQm8fk5zLaU4jK99a0Jz9vi/TnMg7m?=
 =?us-ascii?Q?gdufDZfrQtfpZ2LENSwu2gkFSq566sKVr8mV9JxOVu9e?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mco6ei/mXZ0k3fpc6R2kB/n1j/eI41mTXowdstDtNQ1QMOGnTXY91xxLpsFkB7r+wLNhtqVcaoTaJz+Lc8QOa9jxMuS140ZZ/iA5UEhHrDCHP66lNSZLkc+ZnY3OmOZMTePXQ3yox7eufCOqUNbMEV+4vfh1pP8ZJ6gi4PFIQPQvz/094Z8c1vigKOJV9SP+8G4cCEor88uACLi797j6exOcQKpkZjBM+FKePWDh9kYIbXwf+OA9T+n2TZjcwmMhlEyM2+XhVaI6hOtrTXtyXdNX39DqqP4EXxz0wKeHQ9RWAh8gMgj99d/ctdABRzGF/4ugE8INu5I+i5mCnAqampD/fOnuRNv5+TYfIR7nx7Cdw31cMd5VZXQp5v/Z+3Hqfq/+NYLLcAtpr/dWskTrDJxojt+rycYL9Z2eiSGlgakDtNSUqDXp1WSg6P2+s4Yl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 00:05:46.4949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 404c96be-d923-4c7c-1b37-08de7401a041
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9615
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260683-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,intel.com,fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 80EFC18E492
X-Rspamd-Action: no action

AF_XDP should ensure that only a complete packet is sent to application.
In the zero-copy case, if the Rx queue gets full as fragments are being
enqueued, the remaining fragments are dropped.

For the multi-buffer case, add a check to ensure that the Rx queue has
enough space for all fragments of a packet before starting to enqueue
them.

Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 net/xdp/xsk.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f2ec4f78bbb6..a6d3938154f2 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -167,25 +167,31 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 	struct xdp_buff_xsk *pos, *tmp;
 	struct list_head *xskb_list;
 	u32 contd = 0;
+	u32 num_desc;
 	int err;
 
-	if (frags)
-		contd = XDP_PKT_CONTD;
+	if (likely(!frags)) {
+		err = __xsk_rcv_zc(xs, xskb, len, contd);
+		if (err)
+			goto err;
+		return 0;
+	}
 
-	err = __xsk_rcv_zc(xs, xskb, len, contd);
-	if (err)
+	contd = XDP_PKT_CONTD;
+	num_desc = xdp_get_shared_info_from_buff(xdp)->nr_frags + 1;
+	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
+		xs->rx_queue_full++;
+		err = -ENOBUFS;
 		goto err;
-	if (likely(!frags))
-		return 0;
+	}
 
+	__xsk_rcv_zc(xs, xskb, len, contd);
 	xskb_list = &xskb->pool->xskb_list;
 	list_for_each_entry_safe(pos, tmp, xskb_list, list_node) {
 		if (list_is_singular(xskb_list))
 			contd = 0;
 		len = pos->xdp.data_end - pos->xdp.data;
-		err = __xsk_rcv_zc(xs, pos, len, contd);
-		if (err)
-			goto err;
+		__xsk_rcv_zc(xs, pos, len, contd);
 		list_del_init(&pos->list_node);
 	}
 
-- 
2.43.0


