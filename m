Return-Path: <netdev+bounces-256887-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBG6CTfig2kxvQMAu9opvQ
	(envelope-from <netdev+bounces-256887-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 01:20:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FA4ED690
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 01:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A2523004607
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 00:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB13378F26;
	Thu,  5 Feb 2026 00:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KIyWE7gk"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52758F7D
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 00:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770250802; cv=fail; b=khX8lIpUiZwXaQK6WMtddSlUQIh/Mas5bp1OC9ToUYMQz0jruRoiliKYdM2CFrsILNSf+rSbjmvB7px+oVmOjr7BRAaSAnv2qp4AGkrPk7W2gGRfLZg67yHfWaSCz4CzaORg14MysWtxLckAWWrGlHv0mghE0YWtQZJaSFpej4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770250802; c=relaxed/simple;
	bh=2qLQT/P0aiWkj+OUdFENKPbVKZJDwxkXa+olm3kYT0k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RpSmGxEq3DOQKymDa1t71RZjGFkTaar4gAgz+LSur4nSgPIHVHwSu5nf/Lg6iwyRik+pLgreuYE2vFbDkT4r+yxnhHhuPsSDX/W3lMFSuxkgv7b3QDUNKF8Yha/KA1s/JE1LXu4ZmRt3E63MBwFPSq85jFG2C/KDZwmsvLZwkcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KIyWE7gk; arc=fail smtp.client-ip=40.107.208.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R44LM4KQGkNt7UtkCBPprNIgWekCULeZiuOJrj4qA9hufzB/sy2m9rm+B8Xc9JcGhVvxGHutEhDsytNvzgzkDwxlcsBsuqe9W1LFydbxqJxmxLHTvYLis/R0feTJedRkBeCQkHeBg6I5AvOJ6yKlHHMV+j6VGj+Ixn91jeDcaRh9jsvDiCVJWUn7I68jb0m8kRiznEQZs/dZ1zkMF41B4YmqGhniA3p3fWuEFkWR0BCPrtQDHCxYsUZy5ZULkBrVst5pRmZb4WV+SmsrVsNJ3rWUwf7V1sRUq4voI11yP6DYd8v4zh98tV6bmoK2P/r2OPWmSlWiIHF5BtUm82irqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSKJ07HNU87Bv0chQrAaqS5yN33hmyDzipIOXoOZRPE=;
 b=hMQ3Icc7Hi+US/IfGT7ZZvHsXGUbhEanGdv8kCHKMhTa+P266OmVyHZiLkd7P0z5d7dBGhVrcwuukU3EPNGGGXki2CnYFWXd+5tR93DyNfGKIxCIFykg7adEvIiK14aLF7CAa+KXgDLabTXVoCVvHMmgZrlihlgJHj1HJXXVzc0jAcm32uwcsqlEt2qFlBk8vn3pIaxXPSMb3raZfLroD8Eq46p9vgjEbykG1IVkAXdKDjMU8l1+exf3z0xtKwj1zEL/F4zKKDMOzX7xjUNiII1BlnTkBPopO6QP7LNDqxaXMH2o9Lta5P/GkP8oc3WWNBCvzRoAPDxQ70uX1WBoCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSKJ07HNU87Bv0chQrAaqS5yN33hmyDzipIOXoOZRPE=;
 b=KIyWE7gkfDaJIb1Wzq1q6EQ2GJ6CVBo+kzkLmXKi5hP6DI7s/ywniiLHOXm5e+rhkfQu/PtXy04POY2UFmynJ77lM6rrtE0rbHHOm2eS3Ja+CgCMmkq/hSMbtP/6iNTFQl91KOCDY9b5KrTTvFZEelSddQJt2oDHn7IlkcaNr1Y=
Received: from PH7P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::8)
 by BL4PR12MB9721.namprd12.prod.outlook.com (2603:10b6:208:4ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 5 Feb
 2026 00:19:59 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:326:cafe::9f) by PH7P220CA0020.outlook.office365.com
 (2603:10b6:510:326::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Thu,
 5 Feb 2026 00:19:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 00:19:58 +0000
Received: from ubuntu24.e2e.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Feb
 2026 18:19:57 -0600
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <nikhil.rao@amd.com>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <sdf@fomichev.me>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>
Subject: [PATCH net 2/2] xsk: Fix zero-copy AF_XDP fragment drop
Date: Thu, 5 Feb 2026 00:18:15 +0000
Message-ID: <20260205001935.11562-3-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205001935.11562-1-nikhil.rao@amd.com>
References: <20260205001935.11562-1-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|BL4PR12MB9721:EE_
X-MS-Office365-Filtering-Correlation-Id: 46db8dee-b5a0-4cd7-e027-08de644c4bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G/70xCeA3kluShJF03HUqTLgPEsxC/D4i/4WfPQTsaGybVdCX1pYqkYE0vlI?=
 =?us-ascii?Q?JE4RdG7rnJyryuWRN2FG1hGIwp9VWGLoinW1UkgL4hjpb2BOLUX/lIZPdhi7?=
 =?us-ascii?Q?s6KqU+PY/Tfd6efrEw6sNbWIcb6kreIAuOfXIPiuls7QECRZMJijWMlIIRoj?=
 =?us-ascii?Q?NiY+3V5u7L/RLoTrk1RxVQlc8dOBGlbDlklAsTPrAvtWpBRkp3djACHZJHJc?=
 =?us-ascii?Q?43fXkS8rnU7YtaYuR30DvtEiL32q3qiY/suhbw9BiGIkAZxsrlVv8Zuap86z?=
 =?us-ascii?Q?tdHNobPIEuyGezSGR+rSWhBEZnUYS6z/MEnf2KcbIrtm5SOfRAXmgyOVTjXJ?=
 =?us-ascii?Q?RVbdm0AGhzEfUW7ZuKDWDHoXne3QxazUp8DVywy3MNlYJxAkP41vbGBHu2HG?=
 =?us-ascii?Q?zr+1TY2f3KjkVgY4zNdvqiKrvbuimkN1iLzHOaSWfQk5sY0fpOlyjbPHMecA?=
 =?us-ascii?Q?ZagIeASQ72QMfdVSMCBQqx+RPt3qnoA537E83fGxDCrPGQVfDGD17isDtoBD?=
 =?us-ascii?Q?11OMteJOdk6D7703owNjMQuBFERdUvbcrEoAFZH2kHb0GVy/Hp3oJ9jickFK?=
 =?us-ascii?Q?4CE8CKbwR7edv0KrYwuubEUuJLs+4A9Oac0AGND35zMiQomqMxloHQXzfjaW?=
 =?us-ascii?Q?WddcyS5mmUK8C/CHs8DnK8WQX1LrFUWp0vptSiNNDOjFsdxhGmLL/I8f7nck?=
 =?us-ascii?Q?zobZ+6GvD5bGjr9VYZ8tG0oSK6OIXt8jbaKaMdg94tITutVBdqpmsRcfK0fO?=
 =?us-ascii?Q?o+DRlcMOZIg+JKXXIDJ8bN1BkLbpNp04Re+iXk/bR23p2LnhaxraQ3g1mxkt?=
 =?us-ascii?Q?/wqSrn3M6XdcHHS7sjK8dVTv2xK/5vBaBvWGL/NYN39n6aVoeQ577sAt7v/V?=
 =?us-ascii?Q?seS6QkrFxSXr5MYxVN/gvH0Ha0fokuBqhcdOKcH6GSAeROBGgKBDs8O6eFzn?=
 =?us-ascii?Q?7IgpKdiJ+p0mwokylF7JJX9WaxNpDN+lnpBiP2b0fwUWpXYhSyNfvMgRiyLo?=
 =?us-ascii?Q?s5cbvoj/G/IdS3Dw6MoaWVkuy2KfO/K9INcoDHObkITtRt/rC0/WbJB4L32k?=
 =?us-ascii?Q?MB6VXo1XmpCEzuO5A6XEKMmKfr0UrFQnSmOA/2RDt1tTDRdlFa6NgYEZI0or?=
 =?us-ascii?Q?0PfrjvcBohCaY7wFVQeOdSnpbxMTUv3EYbtWdWqZ3mCB+r2K5snYCTcovke/?=
 =?us-ascii?Q?X5owj3fVwQ6Ti3U7sJp3sQRhRIZwPZCX2VbAuy3HcwXVmhNqSw4MITXqacCk?=
 =?us-ascii?Q?K7Zl8QJSr39+nKtCjgA8yDdQjC6VA9ugZG8J4vPqScvlt5wOzPb7Bz/s4ihN?=
 =?us-ascii?Q?RvbCc/QoH+/35hZhJQPcaCEwOi+ilS6WccAH6L2wWp+1XLoOmzuzKVeVo3SI?=
 =?us-ascii?Q?6WeDY7mJGakWJ+YJogl++xrMefM34KLtYHIarSuofCm5JnYZBOOlE1+oVTWi?=
 =?us-ascii?Q?J/lkNe5nP5Ubo4cXTN8n7zEShQGZsVE57mc+y9irRZqwzYMPApKS/xxcQX23?=
 =?us-ascii?Q?+ItmQoqtL6E315OYnrp4q4g9LyIvEFGmzPlA3kj17RQcdK/BEfXiiKAur0RJ?=
 =?us-ascii?Q?Hb+scv2QiwgIde+SWwXZjiXmP6nJ4EMw5sX0zv3B+LJRa1UIxrfTWbXsJm87?=
 =?us-ascii?Q?NAcn4Bj/i3MS5YlMyPOikBaThN/e1mvpctHL2FeMjXLOh+iLkbGmfxfIkosj?=
 =?us-ascii?Q?I/5P9w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hDYEbuq2vAt7rDaxrh78dmKEEWI90QmKPl1fiUknO3Qz6/er5Il7Y5sDzICcfqzI0U67YJ7W1eeJYqgvUEVMKFmTb5Fc4paTm3HhsFnE3sm/jDoXWUd7mX4SFEStzc1SzKmq6OS0sez5ZVgk63Pt1HSVeQXCKL6hP+d9eSbxVafcnWUmP+/8H5SumrbDjEkEg5hUNLsXmUnbL5wttsp+sBViIHGxeRVvbXByQVlI20auAFaU6X0qK/FXkypuX/G39E89nay1ksGpdkbwfD5eXspXfhoS1Xxo3sNWWDfonqYuSG0tDXQVTqiBj4IC1rA059zQ2NxaIxwhxxjDGEFc5o1xUZEpqkKMwCWbt3V2w+Dc6OnjEGgadhIJwHtMhCMRbn1x6er7IRuYzfvtKc7nKvHWsiWUDDCj1a+1IoBUeOGXeYI0CkEALvIctSft/NGU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 00:19:58.4426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46db8dee-b5a0-4cd7-e027-08de644c4bcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9721
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TAGGED_FROM(0.00)[bounces-256887-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 86FA4ED690
X-Rspamd-Action: no action

AF_XDP should ensure that only a complete packet is sent to application.
In the zero-copy case, if the Rx queue gets full as fragments are being
enqueued, the remaining fragments are dropped.

Add a check to ensure that the Rx queue has enough space for all
fragments of a packet before starting to enqueue them.

Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 net/xdp/xsk.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f2ec4f78bbb6..deec5a1e2c97 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -166,15 +166,20 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 	u32 frags = xdp_buff_has_frags(xdp);
 	struct xdp_buff_xsk *pos, *tmp;
 	struct list_head *xskb_list;
+	u32 num_desc = 1;
 	u32 contd = 0;
-	int err;
 
-	if (frags)
+	if (frags) {
+		num_desc = xdp_get_shared_info_from_buff(xdp)->nr_frags + 1;
 		contd = XDP_PKT_CONTD;
+	}
 
-	err = __xsk_rcv_zc(xs, xskb, len, contd);
-	if (err)
-		goto err;
+	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
+		xs->rx_queue_full++;
+		return -ENOBUFS;
+	}
+
+	__xsk_rcv_zc(xs, xskb, len, contd);
 	if (likely(!frags))
 		return 0;
 
@@ -183,16 +188,11 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 		if (list_is_singular(xskb_list))
 			contd = 0;
 		len = pos->xdp.data_end - pos->xdp.data;
-		err = __xsk_rcv_zc(xs, pos, len, contd);
-		if (err)
-			goto err;
+		 __xsk_rcv_zc(xs, pos, len, contd);
 		list_del_init(&pos->list_node);
 	}
 
 	return 0;
-err:
-	xsk_buff_free(xdp);
-	return err;
 }
 
 static void *xsk_copy_xdp_start(struct xdp_buff *from)
-- 
2.43.0


