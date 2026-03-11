Return-Path: <netdev+bounces-266587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kL6OEw5EsWlCtAIAu9opvQ
	(envelope-from <netdev+bounces-266587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:29:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDF22622EA
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6718313199A
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED94F32BF41;
	Wed, 11 Mar 2026 09:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eeHWkhLZ"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413BF363C64;
	Wed, 11 Mar 2026 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222893; cv=fail; b=QDS9A8m2wx7e/b+wzbm1PHx3crzHh0YbDFaB3kDk3rtEr6qgiWfDYyni8c75nSSF83HQBmUAPm71ZQAkgYO1yAs7c1qecKrCm4HKMrp8uQBBJiVn6bFLye2EkoMDdnDSwQ18l/sMYw4qqANXcqjXVezH0p8eVgYkA7AFyfV/fDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222893; c=relaxed/simple;
	bh=78Ywnl+mEoFOA5eFrE1RDeCMDIhrV+r9hCItTcOmQ5I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mQmB2OMzvXSLcB4LnBiwpYX6bJajJ6ap6eeAxHfzvW3IgNjJ3k+rI/oAJVmd5G4OqbospBzzah6jeorrAlwZB2CeMwtkoLdMDE5Q67C0qCfOo7B6wk62GsP7ftqGs3SU94mW2EA7MQAPDoDFO54S0CjQKW2li3q1U9w6ro8y5Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eeHWkhLZ; arc=fail smtp.client-ip=52.101.43.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NaOcl4YdLAXsfm6W5i8bZXor30F9M7Fi4EO4X3aNXD7XlU4Nh+R9Jt2Zcqv2HMrzRaOaDhOOvSZwz5XXBeLQF/c9kOwiqh3NFAEFlYOIh1/vl4x3XWH0H5mFHDvTdi4LuxC2pPfyLNarfm6A9cZi9J1GkhT+UQTrm94HkC9C+1RjGmNMaHeOMRpofSx+xVxK+3chKn7TAzgzYh/kSiCg8LGB5ut45ghEbrk/HYLWBx5uKJs6p1T1D4MW5DMAJ0IGmeVbzgwiBa8IVW8ECDy5Tq9CPUiVYO6uRDiEJKT7BtQ29lIRcHyXJTy6+9lQ/FfpFHH5U1jmDYfBDfZsDN12sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+L2EtX2EkdEP5PMBHKpy4L8IX2sSQ3Pyxu4KTM2VmA=;
 b=R9a+xrGCJOCZXgCJjABYTFfuhEqkwa1omlx+x5nFatU5zg3ddmcMIgX+SminfDLzzMOf70lWBQRkAO94hG6Bn3Iffr3sgc/mWOb2QHQPYD60Demdj6EH07Gj92KLwwFUxazXkIY3teeROLDeAtCJIv+mVFWV2wANrFKx3ADrgd8BEfYVf8QqD2L+cZFBpd1uDwxMDQjJ+oSQeLMFMW5ZZqxIW7uA+NTfSuNhabqP7Y3XWi6Fx9Sor5vjYXXC8MhqaOZ4Dfat3CX5nf86W0ADc7wFCjinCgCrvjmdPTQvQUjmki/KBXC0pOGyBpgSpvbnar+OTSlSVlP3C3DSKUIyYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=linux.dev smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+L2EtX2EkdEP5PMBHKpy4L8IX2sSQ3Pyxu4KTM2VmA=;
 b=eeHWkhLZPTm+H8iHzIzBC2KlCrvIXUefP2IY5BsZ3X2KQRiaQQkQrSOpSSYcLvmcpCWIYgF70qB93pnSOYR2PM9Zhnjt8PlUsNotKv1INDjCsxUB/gmaL/IA+xKcPVphpx9xcy3eRjAzcUHZ2F3Ggywo2vhT8LPoAS1Bhsaj2ek=
Received: from BN9PR03CA0139.namprd03.prod.outlook.com (2603:10b6:408:fe::24)
 by MW4PR10MB6677.namprd10.prod.outlook.com (2603:10b6:303:22f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 09:54:50 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::8) by BN9PR03CA0139.outlook.office365.com
 (2603:10b6:408:fe::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 09:54:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 09:54:49 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 04:54:47 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 04:54:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 04:54:47 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62B9slMw116637;
	Wed, 11 Mar 2026 04:54:47 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 62B9sjp5019904;
	Wed, 11 Mar 2026 04:54:46 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <vadim.fedorenko@linux.dev>, <haokexin@gmail.com>,
	<jacob.e.keller@intel.com>, <m-malladi@ti.com>, <sdf@fomichev.me>,
	<john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
	<ast@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net] net: ti: icssg-prueth: Fix memory leak in XDP_DROP for non-zero-copy mode
Date: Wed, 11 Mar 2026 15:24:41 +0530
Message-ID: <20260311095441.1691636-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|MW4PR10MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: a69546e4-97a9-43d0-8bb3-08de7f543c35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|7416014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	C+9Vak+fFnFyuZoVao6QKptpLkXXva0s6i0SEVE+eXvVUViYhupBEwaM35qQuHx03BHvRPLZQ606cTPwj3Y+ordnH8OF7d96HlNbssaUKyLKNSinTQPmtx/OTwGVKJgjfFHseSW32G+XeClVanQQoC5lfDbkksJPGdOcXQnr1eS4j+g/GeXm1P4YT/EbivumomzByKIqPGztc9mm3zZqtdoN1YHXMVPLnq/7AKdazCc4n1a2s8mjvktJ2WjSVvyUu6LeHC+JjjdqSZdTbftdaFN4XS01lgik1Qs6LHRnEwasgoVMjUZXm67kykR/C1zk5OTQsN/ldW864ZgNkUC+Nkos7h8+nCtleLRHgYV0j5np2cmIggVNnobOVC/mzmTnZxDhsPRIhHdR6mH8ns3AkjlVULVy3ql1EEvse+uMhhHpDZn00Z7OnYV0weN90eDYHmKGbsbTliCiOILSkqWv9hYTVrL+AREgm4k4fCwWEldwIvuwQiMRBxAojl+G7n5whltqh8eBFSD8CHIfOPrlcHJsxldj5oTWdMMIKjwzFD/JpSGTW+RtkOAfyWTDw3oCKmxT4hNPCzciTrRu7JypY8NIGKH0mqPuN6DFe/qQLmejYWKEvJomZ47k7AumERJfsaxZTzVMA2iYSJBqI6MZIvkkl8RX0Yg00okfyc6VpzZsJwYUQZ5HVBuFiBJvuKzZeIDpyhhAkxDLQkEUSEdwiGqasPBKITpktbs4qzSF7q6GE+EEnkrzhc4KSj2AIZd0KINUrObfgoaUTSSSrW+1CzcUHvFqz8ZSCnfURG8//oMyZWGXlgSIaDbwdP5JhAmR
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hY4BO04SbH6dNGo8Cpd3SMg8ywoWNEGkA3sgA0YG4v+7o+eZVZOEcXM/72zelCR8r4yhtqdlk84Oqwo05r1YhLzpb2eM3lqrx8XX6T0KSeNwsUukJC1zOLag/QZn/6wN7766FqBks9xHqRHkoGr8wGTScUft5d+8Ffz3kAfT2Z4lI96bWAB8AlbU3HQKRNGdyBee4E4QOzLWjD/cZFmLzNLSUto7pMsJz0MPGa4bjNbz+2yDsxX09OtwseURWLoASA1sj5olJapsaFDMK2Ar78x234AKhfwRTLqPtjWJzd+RfDgs6nSmN3yqZHU0RCJrKw/Q2El79VOhKvoYDHmSkWWug1GR6JRPL/S21bcOsvcQ2t1VOzhD/oa4yPo3PgnztOoBh3fr61ZuSP/BLwpg3lemUhwQqH5pGudjUewtFzc+VIam0ITt8XrzdW5jLiFp
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 09:54:49.6208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a69546e4-97a9-43d0-8bb3-08de7f543c35
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6677
X-Rspamd-Queue-Id: DFDF22622EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com,intel.com,ti.com,fomichev.me,kernel.org,iogearbox.net,redhat.com,google.com,davemloft.net,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266587-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ti.com:dkim,ti.com:email,ti.com:mid,xdp.data:url];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

Page recycling was removed from the XDP_DROP path in emac_run_xdp() to
avoid conflicts with AF_XDP zero-copy mode, which uses xsk_buff_free()
instead.

However, this causes a memory leak when running XDP programs that drop
packets in non-zero-copy mode (standard page pool mode). The pages are
never returned to the page pool, leading to OOM conditions.

Fix this by handling cleanup in the caller, emac_rx_packet().
When emac_run_xdp() returns ICSSG_XDP_CONSUMED for XDP_DROP, the
caller now recycles the page back to the page pool. The zero-copy
path, emac_rx_packet_zc() already handles cleanup correctly with
xsk_buff_free().

Fixes: 7a64bb388df3 ("net: ti: icssg-prueth: Add AF_XDP zero copy for RX")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 0cf9dfe0fa36..0a3cf2f848a5 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -1075,6 +1075,11 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
 		xdp_prepare_buff(&xdp, pa, PRUETH_HEADROOM, pkt_len, false);
 
 		*xdp_state = emac_run_xdp(emac, &xdp, &pkt_len);
+		if (*xdp_state == ICSSG_XDP_CONSUMED) {
+			page_pool_recycle_direct(pool, page);
+			goto requeue;
+		}
+
 		if (*xdp_state != ICSSG_XDP_PASS)
 			goto requeue;
 		headroom = xdp.data - xdp.data_hard_start;

base-commit: 908c344d5cfac4160f49715da9efacdf5b6a28bd
-- 
2.43.0


