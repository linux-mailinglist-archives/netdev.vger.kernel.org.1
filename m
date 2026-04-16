Return-Path: <netdev+bounces-279095-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBfBKAcY4WmmpAAAu9opvQ
	(envelope-from <netdev+bounces-279095-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 19:10:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA5E412643
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 19:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE5E93037E42
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 17:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E7730C62D;
	Thu, 16 Apr 2026 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Rj9dC7pj"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012064.outbound.protection.outlook.com [52.101.66.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F64226158C;
	Thu, 16 Apr 2026 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776359359; cv=fail; b=Uyqdq4H5FaKvKJgrtp/GcbrJ8ILujnDekjEi912kRLwgNpuZazINZF90BDXYJLVQOI/4XmAyVO+svXGOdzS607QK4Q4C9fpmxatochqa9V+lpZdFGUnU/aReMTzo2BEKPEmE9C7TDWknatcpDL2y9HTjH+8zP36LFkb/p9CP0xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776359359; c=relaxed/simple;
	bh=2cu9TOYdn0wQItyHIPNxoLNRVFRN1ipU1kOGyw0LeZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iCTUBlLt6FNEH8ulqS3KMYw5nV8BMD/bFX6ILdEW9wyOKdk8E4d6wCEiaoaNBCNCK08FIzc+EszkADhmZWco1cPZWqrbowvw1vjW4wzftR5CO7CpMXPAgU61tcQToydojvhX8i0A7OEez1lUz4tEERGqAY/OKNo9ni8p8rn+R9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Rj9dC7pj; arc=fail smtp.client-ip=52.101.66.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nb5T2dtMSvR2XMHC5TD10WSXbQOVczkL4o4mZvFOKj3P0Q62/TzVw/aLulK8iizta99PXINEWW25C48GKT/E50e1HSDOF99I+N9FEQlJXSVYhF0vxxRXKjRrHnIR6PSf+jsUoO70Akcjd19nxgqWjGLFPYwSE5ybcT42osaB2+uAE4fRfRImqWs2Essm6s6UUIVSkqMAuktDG/k7DetLiti2HaKsca/nCXDKosinxucddNZ8kiYms/poXZN5Ctm2aH/1/kB7+Nha8/DpO5i+Oq42BgEUeq2X5ewQwHHCSO9MFFMNF8nsPB7vPICwWJn1/tk8n+67L3C5Lhg1/+TfuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STZZbFXZ9Qu7Kixf3lHyhWEDpQs5MkcsPicgdSvnXjI=;
 b=VYmzgehw9q6gdD3PkI890e3ndaYO90XV5YqJ2S3AU5+vFWyzXJsP7uqcAjt8srUVnl814wQCFYMkKRyq4yMU02btDpKUF791y99bg6nFBlLUKSR6Xhk1ccMcsOy9w1tIOYwHGr9b0+nIuLTwo3GQByhjeS/kCTuz6RWAP5lh+0h6s/G/c4lyRuenEwQJ3gt3BAFsQ1nUdQ1Ls7hgWxk1Y8CyGiXw3sa3ypculIcmv48yBizos+S5G7/R0lvC5EbQSFOaCJfHk4tntnxkPxoo8lq+9vpf1AN+R5ly6rIpT1OkRfl5nzfoYRZNcGQ1YgrvzU16PwUA2KmbfPN/mvK+6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.85) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STZZbFXZ9Qu7Kixf3lHyhWEDpQs5MkcsPicgdSvnXjI=;
 b=Rj9dC7pj/NNfF7KRzxDIFV5M1rt6T3xBd6A1oafnKT1f8eIGR0gem/pcam81+fdfUvYfwxmwubPzWWm2zm9ZII4Es+hGZsOxXWpdWRO1GFwgSu+11vnxPJSvSv0s4cqq2JmtjRBiH2P4o+SDopq1NM6Ztgn8UGhm9dlVcHbZByJnhyO0pswkqruFh8XQbPCc4MyGzGOrSHDn6584oivk7jJELjYFzYPTaZl/gjq9vhVdJIZWxb6DGLcAdyH9mjWoQkj4WnnZiiIU7z61bkgvlSkoDbBBq9fuswbtB2cAVjTbZVwW4wKin+0egIdpy7ubq1op6wuKx18drflDkP+l0A==
Received: from DU2PR04CA0167.eurprd04.prod.outlook.com (2603:10a6:10:2b0::22)
 by AMBPR07MB11462.eurprd07.prod.outlook.com (2603:10a6:20b:734::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 17:09:12 +0000
Received: from DB1PEPF000509FC.eurprd03.prod.outlook.com
 (2603:10a6:10:2b0:cafe::f9) by DU2PR04CA0167.outlook.office365.com
 (2603:10a6:10:2b0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Thu,
 16 Apr 2026 17:09:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.85)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.85; helo=fihe02smtplvp01.emea.nsn-net.net; pr=C
Received: from fihe02smtplvp01.emea.nsn-net.net (131.228.2.85) by
 DB1PEPF000509FC.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Thu, 16 Apr 2026 17:09:12 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe02smtplvp01.emea.nsn-net.net (Postfix) with ESMTP id 29BFF8000090;
	Thu, 16 Apr 2026 20:09:11 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: victor@mojatatu.com,
	hxzene@gmail.com,
	linux-hardening@vger.kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	horms@kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v2 net 1/1] net/sched: sch_dualpi2: fix limit/memlimit enforcement when dequeueing L-queue
Date: Thu, 16 Apr 2026 19:09:06 +0200
Message-Id: <20260416170906.66432-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FC:EE_|AMBPR07MB11462:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8fd64ae0-5e6f-4461-1fa4-08de9bdae1d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	nhymQyAXhPy0fQhpB9c+dW/oUg/VvTGF5sQS5o8CBet8SOWyob7GDno/tjXt7KpBoEDpr2+ZQnaQSYz+Fv46LLieN6tfCLf3dEQ64jRo89GkMr0CMsXqMVc4ogDw1rWV+SxGN6nKVllwvSIyWMsRUop8GUsYQHfpXVZo9dXkC9BGCSSTPr0p9PurCaEM5LKD373aTKRKO+o5IEx8UEDqdBwiP/7k3GYfHs5mTfeqgif4vXr5uBFyIC0xGkUVLle+e001eXvhvqrD4AYRgCX4L8UZR9mLSFWgsvS5BqqxhjxtRtyFdFOYXxY+cwP9Q6iul9ZgQ9Po2zhdkNHk7fJRjz3nTk5/x87HdFudTTDPo5V/UDgcPtZ9pe/R7e2prohboBiMs59LNIZh9sLYI+3iByldi3/U1sIZcrvyWBwWnFRpVfhlDIrqbGH0RFODpqGOcmkfpeTDZOuPNinBRIXi8qCZGRDjI3aU04bG2+2veJyKTbvztp/R5zRuaxgESvbnXDcvdmHJgAc3e/Od5AFqp07qloOEQWfjLvJgFFCwsVT8dD44b3KBm65PmpB7Zs2VFrH+eBdbWMJxmaJy8yBo8XcsUgVFUaexwSruNUUGhUIMUI+t7W/r7wQ/W92QiaYgloAW/UJjITMjWp6g3ixJDlGjdlQW0MC0t5Jgpxa+TepTEizvAr/3v1lfFD/62MpLcfvCytXNvnROlMI+vkok+J6nF0gNUCMbEtNdyYM6pmzC2ZKR6qxRYS13KE8Y7X6nIdnxYrirs/RQ3WltqdiDo3WhBpaw2UTB670w3E7x8ABi0Tej0jlUDbjY3dZvOC/9
X-Forefront-Antispam-Report:
	CIP:131.228.2.85;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe02smtplvp01.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Fwuku6GPnxhTkbjc/PmH50vl165HMuL1wfO3Lmc7Kh9E9JRF3KrFLBB3Ey1KdPTbPdcFD3X0UeVyeAv8uvbBQiJ40Du9t+iLVz4Iq32ND7ArwrKXU72U5q7pS5DmauN16g563IsfdWGyD0IZmqG5BAVgjE1jYTQAj+CAzPkV+TkvjDdT4L0cKYiXNubE/TEs0fETSrwo0ZUrE3kQOlUK3dUHBVXhsVPFliOIHLCto8me3WjhpgCumAU2gVYTSbcCTF9BtWdTBfjLQnmqHiBmiXPYLja4vkfXqsIU9dxBtZm55aa/X1ItIOCS4lNZN74G1lYx46RZSm2iEQPjLtsp8ZR6jWeGFdOnfuCYmBAUiUmi/II8Swhq2TUwjMfM0j5TkI8uZYBGyYMDCoz3/eo+63r+DLyg+YLgtlXmNuwNNtZnC5eOw1Kyd3ZcjRITW7Wn
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 17:09:12.5877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd64ae0-5e6f-4461-1fa4-08de9bdae1d1
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.85];Helo=[fihe02smtplvp01.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB11462
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279095-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[mojatatu.com,gmail.com,vger.kernel.org,kernel.org,resnulli.us,davemloft.net,google.com,redhat.com,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EAA5E412643
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Fix dualpi2_change() to correctly enforce updated limit and memlimit values
after a configuration change of the dualpi2 qdisc.

Before this patch, dualpi2_change() always attempted to dequeue packets via
the root qdisc (C-queue) when reducing backlog or memory usage, and
unconditionally assumed that a valid skb will be returned. When traffic
classification results in packets being queued in the L-queue while the
C-queue is empty, this leads to a NULL skb dereference during limit or
memlimit enforcement.

This is fixed by first dequeuing from the C-queue path if it is non-empty.
Once the C-queue is empty, packets are dequeued directly from the L-queue.
Return values from qdisc_dequeue_internal() are checked for both queues. When
dequeuing from the L-queue, the parent qdisc qlen and backlog counters are
updated explicitly to keep overall qdisc statistics consistent.

Fixes: 320d031ad6e4 ("sched: Struct definition and parsing of dualpi2 qdisc")
Reported-by: "Kito Xu (veritas501)" <hxzene@gmail.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/sched/sch_dualpi2.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index fe6f5e889625..5fcec5e6e97d 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -868,11 +868,31 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
 	old_backlog = sch->qstats.backlog;
 	while (qdisc_qlen(sch) > sch->limit ||
 	       q->memory_used > q->memory_limit) {
-		struct sk_buff *skb = qdisc_dequeue_internal(sch, true);
-
-		q->memory_used -= skb->truesize;
-		qdisc_qstats_backlog_dec(sch, skb);
-		rtnl_qdisc_drop(skb, sch);
+		int c_len = qdisc_qlen(sch) - qdisc_qlen(q->l_queue);
+		struct sk_buff *skb = NULL;
+
+		if (c_len) {
+			skb = qdisc_dequeue_internal(sch, true);
+			if (!skb)
+				break;
+			q->memory_used -= skb->truesize;
+			rtnl_qdisc_drop(skb, sch);
+		} else if (qdisc_qlen(q->l_queue)) {
+			skb = qdisc_dequeue_internal(q->l_queue, true);
+			if (!skb)
+				break;
+			/* Keep the overall qdisc stats consistent */
+			--sch->q.qlen;
+			qdisc_qstats_backlog_dec(sch, skb);
+
+                        q->memory_used -= skb->truesize;
+                        rtnl_qdisc_drop(skb, q->l_queue);
+
+			/* After incrementing the drop counter for the L-queue
+			   via rtnl_qdisc_drop(), update the parent qdisc
+			   drop counter via qdisc_qstats_drop(sch) */
+			qdisc_qstats_drop(sch);
+		}
 	}
 	qdisc_tree_reduce_backlog(sch, old_qlen - qdisc_qlen(sch),
 				  old_backlog - sch->qstats.backlog);
-- 
2.34.1


