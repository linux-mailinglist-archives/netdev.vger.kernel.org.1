Return-Path: <netdev+bounces-279353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PKULFBS4mnx4QAAu9opvQ
	(envelope-from <netdev+bounces-279353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 17:31:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C94DF41CA1A
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 17:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63FB33003E97
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 15:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32423101C0;
	Fri, 17 Apr 2026 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="J9oCVxMQ"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013013.outbound.protection.outlook.com [52.101.83.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081F222B8C5;
	Fri, 17 Apr 2026 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439560; cv=fail; b=LlX4muNfjFFnpd3PCgvzZqUsDM8Ony9ki+XW76yPqtC8IYbAtSFZy2w9OTxZ23ODZArH1kTAWy8D1aNmNA0MvbOQmkFGT1zJfdATR37ZzYymLQ8ETWw0SUDzM4qm465TiVgxZMc0R3ykKA2IK3b7Mg85zPzgD6+epgdwav/ZfHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439560; c=relaxed/simple;
	bh=JRA/729BlAcGbyJup5mN7IXy7AmnjHiZtin0nydbrsc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VLsIePqllWPWubr7N5FS7e8NvRZspAscbKVhbanDlfzWCCnvtsjsk1I7X7x3TVJPPqnls2LZZa8XJW4bhOhK/rb6zHrnGMcSI39jicyasf6Mbeb5HzDpiR9wLLTHzZKMqSamd9OaGceRTIkyJphDwR30uMjWphAb8IqHy4I3OpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=J9oCVxMQ; arc=fail smtp.client-ip=52.101.83.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D34ImskdIA1Ts1l1+ZyVllPr9+ZF1PS7QSmvANoLm/EsKl/2IZ45OuY2QXOOe8asy39CaPDIR23uIwog+6uFaCpb9pN3M04yuU+PkLhaQsjBmXe4T9faqjCGkLxaQfWVq4QjXCGFTxsByYAgGtdp6VVqMg8umkOACV5CjBwI79E/sRe09+nIlPb5hwQ/sgoKL38Q7B0APria7uxgdYI+3S4m/DZmPVBVxwRzA8XO+RdpYGrLCa2zMu7f5/++vfQ34slfEAL72cksRJl+h0N4+F3OuCf0cl8/Jilxps7OhxQm4vKK2Ze4QyUcgpkBKbUBdN/XlwQOnn8uKYLogbiW3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjiA1QP+a8hz/IBSgz0kUIIyvMPl4fPVNkjK6Cx0w7s=;
 b=S9RZ4v/wAzHmE+5GWucHctg62oGQrFjKReI3cA/XaRVLmD4IrJOxv0mKaDBCUiyFcoNOpy3ohBNAHm2gNAjoj5GMXmkUoK79CYNpXuCpXSB4z8PRY11DLbAk0l1uj/f3jy4/SZotsbQ/EQHmizbrsvu0y2PJm+wINO2bwGp1mWm606gmWQrGsfiEAcmRY79PGy1lg7mT/fVTsyBfTtlZoX650pGAoQeB/2ELtxNrSVxr8JcTNIktKyAX3gpei7nye3blYogwgSgn0NQM+jE82YQFwrAdA/qCvmVGf0qX+H1clNppIJZoHRAAx+oDbi0lOWZv/6RcuWc/PJnJ681xlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjiA1QP+a8hz/IBSgz0kUIIyvMPl4fPVNkjK6Cx0w7s=;
 b=J9oCVxMQeMgwvOQzlrUZqzfDZFig4dXzv2LsWL8fPIPn8H9XBxILhPUZxANYG32UxPkXqYjHdIRJvmZHuwsNPn3nRxUYF9HS8MKJzd0nGSig+7DYCtvXtyrgdTxc2s/uwJ708lH64krNl2mnUI3IEFT6tX7ilwAHlyFJ1g0igqPpGUTmrL1Oy9nzgwkPioWJoIeIb4r6BSDcCwT3XrrrD4vHsEJ2lhTpyFgxwIFm0e0u8pD5dphtGx7AcE+/JkXufxgin00vC4jESBI7wTeVwCnZ+kz1OSKM6KyxeWcdulQ/SGbqiLhIOgsCYaj4NICdvbtzyQK4XJmDggl8nghsTA==
Received: from DUZP191CA0011.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::9) by
 AMBPR07MB10730.eurprd07.prod.outlook.com (2603:10a6:20b:6a6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 15:25:54 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:4f9:cafe::af) by DUZP191CA0011.outlook.office365.com
 (2603:10a6:10:4f9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 15:25:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17 via
 Frontend Transport; Fri, 17 Apr 2026 15:25:54 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 2B27723625;
	Fri, 17 Apr 2026 18:25:53 +0300 (EEST)
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
Subject: [PATCH v3 net 1/1] net/sched: sch_dualpi2: drain both C-queue and L-queue in dualpi2_change()
Date: Fri, 17 Apr 2026 17:25:51 +0200
Message-Id: <20260417152551.71648-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E2:EE_|AMBPR07MB10730:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b11cb446-1bd4-4471-0733-08de9c959de5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700016|376014|921020|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XqKKbuYjrh2Dw9+dZfrm5UenNO9Z9NCs7m1m/O1NB58JKgm1PH6dPHoFg2uU8eZ/hgjQlcHnFmjRC37exujH455FgcuLLa5HhcSly4oMVZwcQVcX4XU7zJW+4S1e9ymoGXso09fruGNMQJdsg/KIf/9jZIn53Ap5mqwOUMw56eegSiTqLbGpJcR0Hmcef8dIDn6qOFkJPNwwOWesl1W/gvpjh0DKHF/tGrPC6jCBEf8dzJzzeo0PTooM63IimTasO6QqQgsZQGVA2FXu6zV3IPBU7Vt58ln5ryaG9U52M7b7sU0tI/IPO+SnL8/HJLyqXjhEJVIZ7pg5eiQULZb9ig9jiYMQP6WmExFyv2HnGvphJksXzhdGuMaBvA2TNbo90wFSkFM+1qtCtzsQf2r9eVRTq0zB0u33UfNvTeI0gC1TF93khB0mBlQhzmYYTBpSSg7K0mpNYIIc0mvUgerh7wZiQBztjUoE4TmxNo6hJEUM8LyfXsvRSrQV2IO/KVV+8Ct4mj8A4XRI+qwOSSg8RkXBIlC9e6eTC1zd1zACApKypBWi5X45M7d6QbtU3K+pTVQI6UI0xAfhBeuip32VdWkKRSX7BUcUIfa31tr24HEvCjhAm1OFWfUe1pA8k6IQHepy357S70GvSNOavBjGHjCNTPh2OtdZEm6OmZ/kliMuZuglR/Y8ZJ/0mAxllmz1ZVcxPW2flSjNoXI+oNyohg3AdmC+lZ36kp0SRXdML5C7IlgI+KZ8+784TFuJHFpcxq42ht9/cXj4M6kZBssBv+R78U8c0nqeZjvoet/4tWU9IObB5bVnepZm3U6G5XcMJ3CcQr3aRNwdR1AsyDUkEw==
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700016)(376014)(921020)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dLpgKL3J4lrp6O7l5ImRuDgPrKJIXT/5Cg43ch18kMQccwRn1Du7KbFgN+jFQ2mfe5vXreMLsdunI7/dfCgHEQoVud+G7e1LMhwsg3h8116bx+27/jUqJ9/KpqYJIWTIH+Lpi+82vyCLcmAqxXLixQFhmAuFlvzXY8ZIxnyObTRKd8L5pEs05QWpKVX7PizCrzRlNxRsL/0gwUFCoxC2kN17eYOL8vOnDbWB4YV8TnY7ARdbRAU5jUi5YssvG95Cur76HoESNP8c9Pw1KLs6WykpRdM1Yi7Af7qd/swbS11eV1xANsW0V3qsQJ9x1antJp27diryiZJs64QYdklgv9F6kvV0ShsZj7UBloNYsua+3tikEZFheCN68U0TvMfgdaMIPIOip7hTbPwJW9bmh2Gi3xuenUUbtBoWEga3BzQc82LepKMb0TqPv2m3IGOM
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 15:25:54.5223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b11cb446-1bd4-4471-0733-08de9c959de5
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB10730
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
	TAGGED_FROM(0.00)[bounces-279353-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[mojatatu.com,gmail.com,vger.kernel.org,kernel.org,resnulli.us,davemloft.net,google.com,redhat.com,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C94DF41CA1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Fix dualpi2_change() to correctly enforce updated limit and memlimit
values after a configuration change of the dualpi2 qdisc.

Before this patch, dualpi2_change() always attempted to dequeue packets
via the root qdisc (C-queue) when reducing backlog or memory usage, and
unconditionally assumed that a valid skb will be returned. When traffic
classification results in packets being queued in the L-queue while the
C-queue is empty, this leads to a NULL skb dereference during limit or
memlimit enforcement.

This is fixed by first dequeuing from the C-queue path if it is
non-empty. Once the C-queue is empty, packets are dequeued directly from
the L-queue. Return values from qdisc_dequeue_internal() are checked for
both queues. When dequeuing from the L-queue, the parent qdisc qlen and
backlog counters are updated explicitly to keep overall qdisc statistics
consistent.

Fixes: 320d031ad6e4 ("sched: Struct definition and parsing of dualpi2 qdisc")
Reported-by: "Kito Xu (veritas501)" <hxzene@gmail.com>
Closes: https://lore.kernel.org/netdev/20260413075740.2234828-1-hxzene@gmail.com/
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/sched/sch_dualpi2.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index fe6f5e889625..241e6a46bd00 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -868,11 +868,35 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
 	old_backlog = sch->qstats.backlog;
 	while (qdisc_qlen(sch) > sch->limit ||
 	       q->memory_used > q->memory_limit) {
-		struct sk_buff *skb = qdisc_dequeue_internal(sch, true);
+		struct sk_buff *skb = NULL;
 
-		q->memory_used -= skb->truesize;
-		qdisc_qstats_backlog_dec(sch, skb);
-		rtnl_qdisc_drop(skb, sch);
+		if (qdisc_qlen(sch) > qdisc_qlen(q->l_queue)) {
+			skb = qdisc_dequeue_internal(sch, true);
+			if (unlikely(!skb)) {
+				WARN_ON_ONCE(1);
+				break;
+			}
+			q->memory_used -= skb->truesize;
+			rtnl_qdisc_drop(skb, sch);
+		} else if (qdisc_qlen(q->l_queue)) {
+			skb = qdisc_dequeue_internal(q->l_queue, true);
+			if (unlikely(!skb)) {
+				WARN_ON_ONCE(1);
+				break;
+			}
+			/* L-queue packets are counted in both sch and
+			 * l_queue on enqueue; qdisc_dequeue_internal()
+			 * handled l_queue, so we further account for sch.
+			 */
+			--sch->q.qlen;
+			qdisc_qstats_backlog_dec(sch, skb);
+			q->memory_used -= skb->truesize;
+			rtnl_qdisc_drop(skb, q->l_queue);
+			qdisc_qstats_drop(sch);
+		} else {
+			WARN_ON_ONCE(1);
+			break;
+		}
 	}
 	qdisc_tree_reduce_backlog(sch, old_qlen - qdisc_qlen(sch),
 				  old_backlog - sch->qstats.backlog);
-- 
2.34.1


