Return-Path: <netdev+bounces-135576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF3A99E408
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A48F2B21597
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FDD1F8EFB;
	Tue, 15 Oct 2024 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="hRbVzjH/"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D8C1F707D
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988242; cv=fail; b=DjKWidfrOyz+cG0o0M8G6NxEANhQxplPUSaWXm8gtVo0h7aG35gk7ssnEF0OwBCK1/rDn5wUNrdhBWr54fsmsFTqd4llq3aKdDkBJQhm8xLtqbs8MrHoLz5NSEomdEfaQGuYOhnkCrQsCIiFDX8gJI5T4YlOeXwl2Toc+V9TSoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988242; c=relaxed/simple;
	bh=RZpNN8DBSjinfwIeSkm5oZif5X4XNLxtHtjeqhBfMvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6s+8ezzXFnluLXswtMwYEKBmVeEynEiweEsrljZPCg4Gf2Q2eIOws341SG1ijBeMUjswFtyhnZMRCRFNeuEaTslD/zCXhzuXgP7hM7lJ7CZno7NnbIy7tvU0lTWw1MvxCax6j7ZEagSmWT/susZ2As0DTl8wuAJa0vjgEuiMig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=hRbVzjH/; arc=fail smtp.client-ip=40.107.20.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPT9i36tg1nWlTgN54GsB/SrKfHzTU6A6hxDgXG2VfO83msC0obIIAn62l7aQgzILoDYQt5yl59cfZVCP5T7QNARB1zH3oCjG80weDEr0rs5mz0zVfNBr63p4F6gcIVbFl8SGARYx3pj5goPd7fb5Ia9hoEvea9i3IAFY0/WLjOUe8Tu51TuKHir/TA5gsjUZc+Xn1IR+aMdAF+WqaAif5cRte5VgY1WkwdG/E7dGMsoKvoOVQh4wPaCuUkTdShYRA7V/l+amCHGc47zqa57o4NyoqXml/t13IwGW3x9ZG4kAbTSE/SnP+g2vn+H631LywAc/ezUbFfOa0ADr7dkXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wt9xrQ3xg5TWde0/7aKHc8cXo5/mm6Vw3u410rgTe2w=;
 b=dahJmaBKdUScxOczbGYJjcO6HqJrisuIPHDszvPTp6+rjerdUTApJYdc6rnU2JMQ6rSjSUf3xyqBKuDbosoytWzf7STLJvpz7s1JJLLv+ZRRTFygDSPRvzZsHRXrF2ig/jzSBviDshz8lvUamSFtmaym9oV+6xukf79dM335XbN3XaqbjKIXjW6sX4P91R9K3lo/6/0yOyE13SwT15FRCG6E4ean6dKL2t8E/R/xSjUZ1gSTqTuT0PKHXwx+3yhwQZn0x/lFiwGgqarQYiMdD8P7M9kWfqrtqDxPPeEO6ZswaNSLt1QRZ+QjjRDaCRMfFnf0CrjYMFpU6txEA+Xi/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wt9xrQ3xg5TWde0/7aKHc8cXo5/mm6Vw3u410rgTe2w=;
 b=hRbVzjH/DMQ3K+Q5IvVE0CerGESPmWrzptFkj3gV/VKXUn+vhpKlDDFKJ8PP2RL5jcRYoZZQd15q62p1XVwlwE+9x5stU7QcMSLNQNiWzHSP0Ga1GJmCeFiP1kLJHPX7HfddeAkXjfGIle4TgeIm29iieDaw0kFJyAb8c0XqmiZCEBgmkKw5QzD+qMDQNH0e4MMf8gQEuOx31zbQwE7iUk9EAbR+4W4gk6/Kvrwn6WUhAdE01qicmzKoNrTwNxXCB4873vETlHX9/Zolf51WtfpJ8W0MwcEXwDNtdgVM9Tx3CzAuAMx4/uKzeUXhuprOvtRmuPndLYc60HT9RUYZZA==
Received: from PR1P264CA0002.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19e::7)
 by GV2PR07MB9009.eurprd07.prod.outlook.com (2603:10a6:150:b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 10:30:36 +0000
Received: from AM4PEPF00025F95.EURPRD83.prod.outlook.com
 (2603:10a6:102:19e:cafe::5e) by PR1P264CA0002.outlook.office365.com
 (2603:10a6:102:19e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM4PEPF00025F95.mail.protection.outlook.com (10.167.16.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.1 via Frontend Transport; Tue, 15 Oct 2024 10:30:35 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtni029578;
	Tue, 15 Oct 2024 10:30:34 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 40/44] tcp: accecn: stop sending AccECN option when loss ACK with AccECN option
Date: Tue, 15 Oct 2024 12:29:36 +0200
Message-Id: <20241015102940.26157-41-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
References: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F95:EE_|GV2PR07MB9009:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d2f51834-5904-4657-264f-08dced0467cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iUFr+E7COKk6kEt/NtwEtXgtG1h0uXHclGy33ZUSeiQ9X2NxUS5GFRbeyef4?=
 =?us-ascii?Q?y/OahKfRbbfVhBG0T8OkA3+P1Ps/S4TRK+8EPtayijMoE+EFLJ574dFdZesb?=
 =?us-ascii?Q?XJBoMt5V00HlYVUc6F8Itis5aS9ziGwUmbyJdgSVdK+b0OJW3cAfUsEwFaM5?=
 =?us-ascii?Q?NlCAAaogu+U59vmPAXTFekCZRKPti/Akf00iiHgR39UU7SUI/QPV/9W/08fb?=
 =?us-ascii?Q?TS2NaJWB21N51a/O9sxcrieEdo4MXvg2snRgw4Y7SY51Q0JbKr9otROflAVA?=
 =?us-ascii?Q?XLYmkHdzxq9dT118OoC3WbWRbHIl1KdDcRXHRuFzObhQ432x/akIywl/3zqw?=
 =?us-ascii?Q?200lfx5NoVdroOyWSxB8MQB+kG+U59KoCCBhcHWbFSrt8fnqYSWo0T/rjtmy?=
 =?us-ascii?Q?9UpH7yhZe9enBO3+NqG84LCFCNyAJduUgsMeSIq7zXXDBKVjz0iQ+ttNJ3f3?=
 =?us-ascii?Q?y6546uAYfxjiSYZYHVKNuf9JG22OQtKwpwfTsScP8dcrC452668vAAOFhMRF?=
 =?us-ascii?Q?8X+f5iRrzNnHNRxLWN4pBsdwhjvm8dOwwKvp8ySFTY2ebYkbDtL1EAgUKKdB?=
 =?us-ascii?Q?IKeXHA6WlrWhjR4/j88L4tkHSfKVH8pn6JAO99h3CLPRh92qR0y1H9QaP1eJ?=
 =?us-ascii?Q?R8UCq2NHdqhBqbvxo6V+OcZPkUHvG/QgXqdW/auDqrQxxV2TOdDKKINDTKyp?=
 =?us-ascii?Q?6HzBS9PGTnpnPwF9N7eI4+iePWGO/vwRvi98yNn/EntZ9CAomiNJa4iPC1HK?=
 =?us-ascii?Q?j9NlfsxY39LwYnYnzIUoYynKDbMtSJ+B9SGRUCjw4V/1CdTAAt0NS+D3hd2j?=
 =?us-ascii?Q?yrvnN8MDpNNlQiQLpv2A4wg0QUhhmJehRRic6jS/sLosjGuL26c3xSkebcXc?=
 =?us-ascii?Q?WGL/l8mXUqUvXXTlhTZy99dvgZIxV4ohWkFyv7HMznvFXnWoWetdCP81FDIr?=
 =?us-ascii?Q?u0vUqKefgVqTcZ+X/DEPYuTNfBywRmi0SxIN+wA1qIQQ7KZFwYI3PzpB0G3t?=
 =?us-ascii?Q?So4riR3fOe0rwxHfYGJN01lX244c7d3ppEsl5nCzXJWoRBjxNbpAKNd79hZj?=
 =?us-ascii?Q?NLMDhj0VYldKwC5d+YClJNlMvgLOPax0MHZw0ii/isgfWR4Nx/ycSgDwMFBj?=
 =?us-ascii?Q?fTyuRoTrNh3pGx1B7gjSUUj6sipzDALsagaLYN/5at1+Y807YpdaIVQdeQJ8?=
 =?us-ascii?Q?/kVtQFbOCLVS0RYAm7iLG4Bu5+Z7vrQBO+m6pGOJFv/GfzobGr3nsB6wgCgU?=
 =?us-ascii?Q?vbtjYR+7DDf2RnMWJvzJzPN5UGzhk3r2mIBcpqDQneqIz8IdmEFdiNHQwktB?=
 =?us-ascii?Q?/h5ybjoOH5y6t4R/k/bnEPDmIwtcRvxTtHUr9mYkLOo/enR8Y1EtzSgFVUzK?=
 =?us-ascii?Q?mOzt+3SV3ix4w0Pe64GY1AJYF+C6FLL7+RLfK8enJzM5YgKq5Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:35.5758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f51834-5904-4657-264f-08dced0467cc
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F95.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB9009

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Detect spurious retransmission of a previously sent ACK carrying the
AccECN option after the second retransmission. Since this might be caused
by the middlebox dropping ACK with options it does not recognize, disable
the sending of the AccECN option in all subsequent ACKs.

Based on specification:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

3.2.3.2.2. Testing for Loss of Packets Carrying the AccECN Option -
If a middlebox is dropping packets with options it does not recognize,
a host that is sending little or no data but mostly pure ACKs will not
inherently detect such losses. Such a host MAY detect loss of ACKs
carrying the AccECN Option by detecting whether the acknowledged data
always reappears as a retransmission. In such cases, the host SHOULD
disable the sending of the AccECN Option for this half-connection.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h   | 3 ++-
 include/net/tcp.h     | 1 +
 net/ipv4/tcp_input.c  | 9 +++++++++
 net/ipv4/tcp_output.c | 3 +++
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 9dbfaa76d721..ecc9cfa7210f 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -304,7 +304,8 @@ struct tcp_sock {
 	u32	received_ce;	/* Like the above but for received CE marked packets */
 	u32	received_ecn_bytes[3];
 	u8	received_ce_pending:4, /* Not yet transmitted cnt of received_ce */
-		unused2:4;
+		accecn_opt_sent:1,/* Sent AccECN option in previous ACK */
+		unused2:3;
 	u8	accecn_minlen:2,/* Minimum length of AccECN option sent */
 		prev_ecnfield:2,/* ECN bits from the previous segment */
 		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4d055a54c645..ffb3971105b1 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1050,6 +1050,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 	tp->received_ce_pending = 0;
 	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 	__tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
+	tp->accecn_opt_sent = 0;
 	tp->accecn_minlen = 0;
 	tp->accecn_opt_demand = 0;
 	tp->estimate_ecnfield = 0;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 0786e7127064..74d66c075d6e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5098,6 +5098,7 @@ static void tcp_dsack_extend(struct sock *sk, u32 seq, u32 end_seq)
 
 static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
 	/* When the ACK path fails or drops most ACKs, the sender would
 	 * timeout and spuriously retransmit the same segment repeatedly.
 	 * If it seems our ACKs are not reaching the other side,
@@ -5117,6 +5118,14 @@ static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
 	/* Save last flowlabel after a spurious retrans. */
 	tcp_save_lrcv_flowlabel(sk, skb);
 #endif
+	/* Check DSACK info to detect that the previous ACK carrying the
+	 * AccECN option was lost after the second retransmision, and then
+	 * stop sending AccECN option in all subsequent ACKs.
+	 */
+	if (tcp_ecn_mode_accecn(tp) &&
+	    TCP_SKB_CB(skb)->seq == tp->duplicate_sack[0].start_seq &&
+	    tp->accecn_opt_sent)
+		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_SEND);
 }
 
 static void tcp_send_dupack(struct sock *sk, const struct sk_buff *skb)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 74ba08a33434..4e00ebf6bd42 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -804,9 +804,12 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 		if (tp) {
 			tp->accecn_minlen = 0;
 			tp->accecn_opt_tstamp = tp->tcp_mstamp;
+			tp->accecn_opt_sent = 1;
 			if (tp->accecn_opt_demand)
 				tp->accecn_opt_demand--;
 		}
+	} else if (tp) {
+		tp->accecn_opt_sent = 0;
 	}
 
 	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
-- 
2.34.1


