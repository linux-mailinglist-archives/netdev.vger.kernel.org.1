Return-Path: <netdev+bounces-258968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AI6yD1XDk2lV8QEAu9opvQ
	(envelope-from <netdev+bounces-258968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 02:24:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C14148665
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 02:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FA8F3023042
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 01:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D238B254B18;
	Tue, 17 Feb 2026 01:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JYL3pvnu"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013014.outbound.protection.outlook.com [40.93.196.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9606F20E023
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 01:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771291456; cv=fail; b=ad8prAcR+ywisb8CrzgtRVvofHGdlKdqPHRN+/Db8yigaJqoab4p1h0RFZuqAyqYrv4R1jcOUuNoNFDfQ4ol2Ph9jIKEz3gxC1/qrOxAvg3DBnileQAhCTfB0mPLXLRgh6CUHa4L0a6cJiUCXJfjBKmlrs5cDcr4fzMSQWyOsSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771291456; c=relaxed/simple;
	bh=jDlF3lpju172dhRwXMrOCwRfQcQaqZyiw+4Vft1BwSM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c1W6rdACbxLXQ4XfJPMbfUIju0PoGQP9U4n6aPmiHsNWUsgqoz+DifD+DnJMgOd3V8zPTqHYaNbEf1eAfXHJaKNTHjag+JNoKQAYkYhQzGIvT7ETy4l+wlQ+YeeZ/+3k0H2Z9bgJNuctnff/wKWcptwkEruPCJ8+GzOAABH9QZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JYL3pvnu; arc=fail smtp.client-ip=40.93.196.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1Ojicyf+4sk8vl72XkvESupPlTJIeybXb3o583p4jfKAWT7pplfoKsD2Qt8nW31T+OXDJJx7Q3aHEUVAAHBsrqLXNp0NUC+UGTpa7vZS4SGjLmnHHOyR7cnlIGbiow55JbdIOWy2YdYR3GgLA5b+zyRHo9y5S5QEQVzCpoBkss+hD7nucvaB3HNzn5E0a40Zh/HwLd63Q0UNvvRdSlyEGrkA3p5N21X0JgzP1AuFnDQAsCLJ3jmC1TK4NDnxp+6zz//elalp2RKWcN2ZEvnuydHTB14dyfZqCZFbiPcH2W78PCBs/hSobCm18EV4Fog7KGFxGgNLtX94fTj9TfHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pg/mJb/yqpsM/9hY04cOrglFaJSI0FcDr7a0H6Os1NM=;
 b=fbjMmaml9MlVdNtsZm/0VzwTWm3+1OLC3SMibgpsudDykcQntlBgvcRV7bvOsyk+hsvjYgEFI7DcWqM4paMvM47hsYoBIJyjJsTMljRMLl3TsxxHzlk5EmLSxBA07d/eyv9bYMkPRqZ4HRR0Hz+ZYACppkbTSjWtpztEimCzULhcvJvGBgnrmHlTXpwIvno6soC9KYlO3xerjjVzxKVtDlBYfWxNg+IxzkEzt1WedzJOjQwrKuZxvC13ZY/vU43V4e5IPCkZO3U+SmtnyFw2DO5DtST848zBC5KtTi+6XZO0tBsJTlQ0UzX9KgPKiJNV/hUxJHL+vuNEYeaYCmLemg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pg/mJb/yqpsM/9hY04cOrglFaJSI0FcDr7a0H6Os1NM=;
 b=JYL3pvnuNa6ApCY3ov+Cygaz6wN6BTYmQU2xApYsq0XEsEq2l+4v5MVceqYHjJ7S+z7RPufAy9mROt+nTDKUb3I+o0pCfKAlsTyM4/wh2wU5LxHbNTmacgcEi7llxTRPojsrBspQJXWa3y+vMubfmQ2gs0e1Maul2kQINGLD0p8=
Received: from PH0PR07CA0054.namprd07.prod.outlook.com (2603:10b6:510:e::29)
 by LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 01:24:12 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::c4) by PH0PR07CA0054.outlook.office365.com
 (2603:10b6:510:e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Tue,
 17 Feb 2026 01:24:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 01:24:10 +0000
Received: from ubuntu24.e2e.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Feb
 2026 19:24:09 -0600
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <nikhil.rao@amd.com>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <sdf@fomichev.me>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <kerneljasonxing@gmail.com>
Subject: [PATCH net v3 2/2] xsk: Fix zero-copy AF_XDP fragment drop
Date: Tue, 17 Feb 2026 01:22:14 +0000
Message-ID: <20260217012346.22468-3-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217012346.22468-1-nikhil.rao@amd.com>
References: <20260217012346.22468-1-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c9d9fc-101d-401a-b6c2-08de6dc340e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YxYEQJog3o87l7PFJzcD4vwyJzeD/BKd1Yy8Bl703aR5MTMyJt/6YMRorOW0?=
 =?us-ascii?Q?DH3cqO95Kc3uof12Ivnd07waQc6g88zDhgv8KidDdC//T8rqW/XYO3VolxzG?=
 =?us-ascii?Q?z5KfJj97HciQefm2XBoHn64N8qpHikfZgnBdYvlVEquXgPicrRoNaYIm7O2p?=
 =?us-ascii?Q?q/+P25U4Lop2tfdXIAfeZpHNhh+D13Clz2RsL2OWVnEnMT2RkBfektRXFp2N?=
 =?us-ascii?Q?a11w9N43/y4mhqffr+NoVU4FLNvjWSpUB3OcUh7z6KnajPkOT9l3lJG0EkYm?=
 =?us-ascii?Q?iTmmh5hfGXGpC4L07Y7wk1KaII65QdquZR658bUrhfJUL1jsNoBomy4n978d?=
 =?us-ascii?Q?Cc3nsFOl69oZ0Yyt2VWmIlCUCfZ/oV8X8XDstJ27YiQscgAWMXPhXHgiyLLa?=
 =?us-ascii?Q?GpRnkV54wr/pJkS62qtwD2nI97NwTFp4fAyLjyOaXlig0EvCrfADaqG+so4T?=
 =?us-ascii?Q?xHv78dvDJUapY+TFdUGT2f2JSYQkayBZzr2HREjrw+mwmYdTB66Af3npsc2C?=
 =?us-ascii?Q?tAVJhy4GeBhMR8MCv6jpuWE/h4tDlatt/MttjdcqPTle7pvR9mY5rEZe2FeJ?=
 =?us-ascii?Q?06f8HFyMllxSzTXrOwgEZDsCwGgpl+dblbxz+vGw75H6ar2wEz1tTLiBODCN?=
 =?us-ascii?Q?x+61Eu76va6AoHrUY0OhLHXIshXTYdzZtxg92+/Qc9XgeOqCc3ETUO9Oivrd?=
 =?us-ascii?Q?XMcJEuMzrK/J3hBlgpIzi1Zq78ncwQMN1o5VK3g++nY0R5hnYPdJV3lerV74?=
 =?us-ascii?Q?5NQcSJf8d/2pSeK3IleXIQRmKJIYm5AGx5PVvbdkSke0vHrkVqQKqKlMZd4o?=
 =?us-ascii?Q?EvieGviY5VguhxbLr/7+CT+6dRSNHPf+RxEAhbbeeiuM0jOkxMNRMA8gZirZ?=
 =?us-ascii?Q?ILdZPBMnqVmOBWRd310ehxPDWvdgUwQhH0gyA5I1AoeZ/DUNkZIAP0d6d6mD?=
 =?us-ascii?Q?4UMPuG8a1fXIb69xUqGVgOSDtTx049aoQsnUwIq0a1I7sTsxc4fn/glwsSO8?=
 =?us-ascii?Q?9FSjGDirfmCK/dpiYwkadCgd+L2ypsNvQWfKYXmKdpeCZoIBrT4Uy7cTubMp?=
 =?us-ascii?Q?kJsRphvu2dmqpOGli5sdf1ZCm3TYgQGVN1/GFpNUj3VP31vblrDV8teZDcqC?=
 =?us-ascii?Q?5VGH/8nPDzp1/27hf7TnaYA5piNEwU59/xAGd9+5b+d+IwJUEazV07p3Xnsa?=
 =?us-ascii?Q?i6tT4KCBhMPM6270cOsXSEZTkDTAo+3QQc71QVqVFfeALj9dLhfP/z+UG+Z8?=
 =?us-ascii?Q?zWEU2L4mNoMznvWDNRVB8BXq3YS0I5aFVAMykrGhDiNtbq5RhVMDFw71SExD?=
 =?us-ascii?Q?THjQuz/kwpZFDBLwGnj1xNOwbeaDx2h/ak9ArGripEIErGn2qAtst5+fRzJE?=
 =?us-ascii?Q?uR29UvrsF7omMJ8mL/fpJk7i3Rfm5+m7rflior12oGigxM+z3meaOi32pJVl?=
 =?us-ascii?Q?id9iIZ4aaACdy7hJIjy1fKJVBIbd7ZMYSGyMdgvvn3RTbnpkOjLUrZr2Z/RN?=
 =?us-ascii?Q?dXxfQoAuockNUzTI/cbwtyPYyR4d8Iy+9j0mstzy7ZAGF/s5w2tuTaanZQgA?=
 =?us-ascii?Q?aM4zDcn1kBOP9TQKKg8veTqT9dUDo7ZC1l5P1PaynD8IKVUkKOphNtPCv1kI?=
 =?us-ascii?Q?nk4Kq1qfuc0NIFtZcJqLb9HYSSEXQ0u8uiEDtIuUoRiszNkZsAXo9MP408D4?=
 =?us-ascii?Q?+WIftA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LqmgZkB16jsEW9b92H8dm0Tayt5YyxknGEtTuVlBPxSc+GKsk61gUw7kXCmekxVU8R6mgtFv8Wj23g3XoDz6V9uyKGZPdqTVYZBpRppkfmQmWNZ5Ydq7RUlT5TKybTPcxH2Fa/85s54nBe0gnFkcCXMMyC7QUwFop5hc+QmUw8qm6YwG2rH46aDanu/DP7SuS5JmVjh37LyZC1wFbWTyeUUYV79QjinTLekS5z1Zq0KwNW2mLtY+1hgwW7+Px2ERjkVwAATp/xi0MilHhbvQhrsLF1r6WyUh2m4tvj9rMfCHzBul1xjkmKeqxHtXWtL+TtdoMU3u0xWHG9vqrl79185Oc3DpbXXck5bWWjKqp/wl0Hg83dxPlkvykcOS5ucAUAdKfASVGzxBgghJ/PY6pXgWqPwFPOpwmQzSd7lScR2KhU+gg77h7yRY4/hFsfB0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 01:24:10.7585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c9d9fc-101d-401a-b6c2-08de6dc340e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,intel.com,fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258968-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B6C14148665
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
 net/xdp/xsk.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f2ec4f78bbb6..78ca343de080 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -167,25 +167,31 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 	struct xdp_buff_xsk *pos, *tmp;
 	struct list_head *xskb_list;
 	u32 contd = 0;
+	u32 num_desc;
 	int err;
 
-	if (frags)
+	if (frags) {
+		num_desc = xdp_get_shared_info_from_buff(xdp)->nr_frags + 1;
 		contd = XDP_PKT_CONTD;
+	} else {
+		err = __xsk_rcv_zc(xs, xskb, len, contd);
+		if (err)
+			goto err;
+		return 0;
+	}
 
-	err = __xsk_rcv_zc(xs, xskb, len, contd);
-	if (err)
+	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
+		xs->rx_queue_full++;
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


