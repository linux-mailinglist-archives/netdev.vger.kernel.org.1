Return-Path: <netdev+bounces-168752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9403A40756
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 11:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7852F17FC27
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 10:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B0220010C;
	Sat, 22 Feb 2025 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="slWSy4fx"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012024.outbound.protection.outlook.com [52.101.66.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AF713C3F2
	for <netdev@vger.kernel.org>; Sat, 22 Feb 2025 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740219455; cv=fail; b=DkmWosYNouBfdADRV1U1aCZaWq0uB+pzRtaQEEZ1fQjRYB5pffFKta05xu7xkINHWD3kqcKDRb3VqbmUCcn+alPzvqvMeTWiUG8Nu6vox/c9Duz0r+oJ1FZODoYe/yeHQZGPWsePcI5JbZxB8KiqryPz0gO9jN9aRfSpBp4x6do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740219455; c=relaxed/simple;
	bh=iBEQFkeF6QNL+an3bpPrucu4JHGAa3Yd7RzqGFURaOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idLRuj3oXrRXabqtHlHTlVJgkHhYVBzRg4RRquGNwShYPlK+nbiiRebwTNrIoUpbBXUOO5tS/2uukpkZCJSAOlIKmtcP/cZn/TKmDP5oaRl86LQfQvQNCMERAg7aZLZZ18E9FvYtu1MJiA3QEuWD15fEmJX5aeyRs1ybu83LzU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=slWSy4fx; arc=fail smtp.client-ip=52.101.66.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fv7AU6m8J/yp3y4znngNSOirWaeN9LhVm2bjJ8JIu3IGGii1NLD8Cq1r01Z8U7PHOzbIcxPeXuEwQjC7YdaROpRxd4jxzXh2ywPyesCKEfd3Dl+pn4QCDoQfsZ7Xd6YRPaN2ozvHK7wmGsoFLh/Oig75KgdIJIaMRz8CegnXhfFQq3gq4+hT1IUoR+xau/PHzyekwcbTSHMM89qOXIqX0hvo2wKYAhPtimxD5RJXHPPP2F1sBLj331zhCDbDcyno16o/e98/vhttfI5n3ZpPXAvHlq12h9oUazgYXQ7iIjNh70I2hN0SiaCrPHEIjNgmvaYn8G9ddYbwqg0AQiUEvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NU5rJnKYacWzLAFHyVp3rgiz7aPPWA5AzrSvqfXa8+4=;
 b=clZZyXqPIBb0n2doPqmqhXVWsxCzWH+HbaPAq9iQZNhNat/XnhY9suxXhAV+k61zRJ1ZvgPcAHnYllQAce3a45UNLzou9ZRlQmoiBHisyKYepeLrIdg0RJl8Ec/XHxJ5zTOYSLZlmhjk6DYy3eJHCkfI+vntIw5oWOliuKm+jrjAj1095Vh9OjrByB2zh+cklZGUufzYSfh9DsxSV+NUH8BSEpzWFjfqfTVHCLn+3ygLpYFJiIKg/oR+HpUbJowi82R3H/xYoxD/D1yJ/oe73kmbDFVPOWEHRKI4VLSIhpPak6jN6IvzbpqG0MMLVOXrmdc5WISCNNm2ldAXVYMQqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU5rJnKYacWzLAFHyVp3rgiz7aPPWA5AzrSvqfXa8+4=;
 b=slWSy4fxf/UsDYWmbbZO2WhfH5ZdHDyzBsVScLNhicrFBLWFU+viJ7qCts1X4C7/ILM1fXEzOBpU4TLjVqXtn19MFZ5OQCX73CKLxLZar6LqdJkOuY0LdZUuRVgn/1gfttrqSwgYOjJlGOJTdIjuv2Favs+EJboCcKj4MUiNv+m+Mt4rxSyTVrMpfWw/aYU0xl5F5PhYpu9c7E8gtMuQE5upWkNDXzYSKlVxb+AqeR16On6BqeiiwHbdB5OGjpG2OiCqWMK9ePZBWNo7K1iPexGEkveBiK/NsavgDXByxPK1IBWaQzQJTqY6R36Ca2FIMRhhW6AvmDGn1o0kc/Tklw==
Received: from DU7PR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::6) by AM7PR07MB6643.eurprd07.prod.outlook.com
 (2603:10a6:20b:1ae::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Sat, 22 Feb
 2025 10:17:25 +0000
Received: from DB1PEPF00039231.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::c8) by DU7PR01CA0006.outlook.office365.com
 (2603:10a6:10:50f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Sat,
 22 Feb 2025 10:17:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB1PEPF00039231.mail.protection.outlook.com (10.167.8.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sat, 22 Feb 2025 10:17:25 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 51MAHEnN009925;
	Sat, 22 Feb 2025 10:17:28 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
        ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Olga Albisser <olga@albisser.org>,
        Oliver Tilmans <olivier.tilmans@nokia.com>,
        Bob Briscoe <research@bobbriscoe.net>,
        Henrik Steen <henrist@henrist.net>,
        Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 iproute2-next 1/1] tc: add dualpi2 scheduler module
Date: Sat, 22 Feb 2025 11:17:02 +0100
Message-Id: <20250222101702.27909-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250222101702.27909-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250222101702.27909-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00039231:EE_|AM7PR07MB6643:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e93192e7-5581-4d04-f60c-08dd532a1a9a
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?C9CC9V/Xf4NvSn9M0aMPd7CTBZDBb3NO/O8c4+njrmZrNdP73xVZgiIGPKwo?=
 =?us-ascii?Q?L4NchTTEy1aFhdNOTbCLoQ0Lk3cKvNtO9B7YGJ3P0IAlv9jlSNrtBL57VLoX?=
 =?us-ascii?Q?mw5dehV3BQ6VqpFTVdjLEpRvJr8kbTMR9rgQpJ2yKCUtZd2DHvJu1rMyPL/o?=
 =?us-ascii?Q?YX/btc0J4BE8+j8b8zuwLbXQPgzo8KwXjHyQGdwNCaRctpYqJk8hZQwQ/UU5?=
 =?us-ascii?Q?4+e5pov1mEfFeY0anvirirQSxS+0zo7qM6e5g6aKRyskK50jvrwVm2e7S3ye?=
 =?us-ascii?Q?yhzdJtwqRiqxzqcPDnbTBXQJ1Arj4GMPwN9W+zNhneEm0sctJzyIVoA52z1B?=
 =?us-ascii?Q?fi50nYdAILdjg3TVwmYYbo547J1Ipdx6S/X94xbfS0n4sT0FGsOvqBTHMoc1?=
 =?us-ascii?Q?n3bCP8IyNyVFhTywekJ2AznEJveu643oIDku01n0QyDybF/QGoorrGdspo9W?=
 =?us-ascii?Q?MyfE4pw15DJoSHdExbzJeIqXaidVpx7bfT65cjKBYaxzg2sdHWKso3YrNVtu?=
 =?us-ascii?Q?GsSNyTVPuLhTqknAY8EKyYUypGfN6XwecMKrEHDW0r6QIONupm1mbFzMGON5?=
 =?us-ascii?Q?ECedk9prPLsfTmAV4v5bHaFXRyXkuE8TSnDTpVFkNBybRDdsiH3wtZ5+Mmf2?=
 =?us-ascii?Q?kswp9nnnA7CKEmaDcNlI3H8HMD4Yk4QcTXHN4YIyXPVybhQPPvX86ss21yrm?=
 =?us-ascii?Q?IaAs0GPeMrVqVdIwuErVpIeuahoRRGYjf6VhXqx0+HQoqeZ/SlOnSLKBN8Hp?=
 =?us-ascii?Q?vGSkC/a/1zOGJ91ClDljHeEGZz2HFnBDzr0nsYqe4bf69Xf7IdHvacUp0bpR?=
 =?us-ascii?Q?kya0d08ckFs/H9pBCTcAWuJ1aRWgCKXNctU+Ok/xcQQZeYQBwTL/HH21qM0I?=
 =?us-ascii?Q?k6kyuYnTJkle3SVPfXL5coSp5w3HKt36+UerIrntdkrniPzYj/h/D75iX67T?=
 =?us-ascii?Q?+7kzWQMbzCplkk78v38i9fnk4q5KMLZ1+cDaYFAsHI2FIXrjnf5N+ki8Y1+U?=
 =?us-ascii?Q?0W/chCJUNI9UGX/cU9s9MMnrvTwE9ltg1VYoCi1CFjUtIK18D18Osm4Q6zo7?=
 =?us-ascii?Q?ZJX7voNgRuRzDY0MVm0vsaY/9/zL8YDc4gq+Kla3GbRAPdMiPKv2/BNy05My?=
 =?us-ascii?Q?9s1cr5sAanLj2/pu5sK+knAbOTX01Dl4qHAJGhUC3a111crPBMhxsgKYl8/Q?=
 =?us-ascii?Q?0DHGjoWiFM+QThMD+Os4mThQsYAuWdAZvcjUloxf88xX75AYD44xKeOZCRrD?=
 =?us-ascii?Q?y1HInkGc/vbRkwhsJURGJgq4s/cI3cE/M+jiT/1h+MmHniJiwkDwHZ+80JZK?=
 =?us-ascii?Q?IjDFl6BZRuOfKmKSOZwwry+u9elCfRWGz4wL0q+MDbk3Iki7Zq3bUAtAuXPO?=
 =?us-ascii?Q?HhzGTa6b7awE2rhNbhMSH8v5BF3mYv4Br63f4zAYdYdxrzxSklIkd19hPWPo?=
 =?us-ascii?Q?euFjkHo4a6Lka19NDGMQHreaQQoDDhFj?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 10:17:25.4542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e93192e7-5581-4d04-f60c-08dd532a1a9a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00039231.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6643

From: Olga Albisser <olga@albisser.org>

DUALPI2 AQM is a combination of the DUALQ Coupled-AQM with a PI2
base-AQM. The PI2 AQM is in turn both an extension and a simplification
of the PIE AQM. PI2 makes quite some PIE heuristics unnecessary, while
being able to control scalable congestion controls like TCP-Prague.
With PI2, both Reno/Cubic can be used in parallel with Prague,
maintaining window fairness. DUALQ provides latency separation between
low latency Prague flows and Reno/Cubic flows that need a bigger queue.

This patch adds support to tc to configure it through its netlink
interface.

Signed-off-by: Olga Albisser <olga@albisser.org>
Co-developed-by: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
Signed-off-by: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
Co-developed-by: Oliver Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Oliver Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Bob Briscoe <research@bobbriscoe.net>
Co-developed-by: Henrik Steen <henrist@henrist.net>
Signed-off-by: Henrik Steen <henrist@henrist.net>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 bash-completion/tc             |   9 +-
 include/uapi/linux/pkt_sched.h |  38 +++
 include/utils.h                |   2 +
 ip/iplink_can.c                |  14 -
 lib/utils.c                    |  30 ++
 man/man8/tc-dualpi2.8          | 240 ++++++++++++++++
 tc/Makefile                    |   1 +
 tc/q_dualpi2.c                 | 494 +++++++++++++++++++++++++++++++++
 8 files changed, 813 insertions(+), 15 deletions(-)
 create mode 100644 man/man8/tc-dualpi2.8
 create mode 100644 tc/q_dualpi2.c

diff --git a/bash-completion/tc b/bash-completion/tc
index 61f0039d..52b16b3c 100644
--- a/bash-completion/tc
+++ b/bash-completion/tc
@@ -4,7 +4,7 @@
 
 QDISC_KIND=' choke codel bfifo pfifo pfifo_head_drop fq fq_codel gred hhf \
             mqprio multiq netem pfifo_fast pie fq_pie red sfb sfq tbf \
-            drr hfsc htb prio qfq '
+            drr hfsc htb prio qfq dualpi2'
 FILTER_KIND=' basic bpf cgroup flow flower fw route u32 matchall '
 ACTION_KIND=' gact mirred bpf sample '
 
@@ -366,6 +366,13 @@ _tc_qdisc_options()
             _tc_once_attr 'default r2q direct_qlen debug'
             return 0
             ;;
+        dualpi2)
+            _tc_once_attr 'limit coupling_factor step_thresh classic_protection \
+                max_rtt typical_rtt target tupdate alpha beta'
+            _tc_one_of_list 'drop_on_overload overflow'
+            _tc_one_of_list 'drop_enqueue drop_dequeue'
+            _tc_one_of_list 'split_gso no_split_gso'
+            ;;
         multiq|pfifo_fast|drr|qfq)
             return 0
             ;;
diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 25a9a470..8a46cc36 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -1210,4 +1210,42 @@ enum {
 
 #define TCA_ETS_MAX (__TCA_ETS_MAX - 1)
 
+/* DUALPI2 */
+enum {
+	TCA_DUALPI2_UNSPEC,
+	TCA_DUALPI2_LIMIT,		/* Packets */
+	TCA_DUALPI2_MEMORY_LIMIT,	/* Memory limit in Bytes */
+	TCA_DUALPI2_TARGET,		/* us */
+	TCA_DUALPI2_TUPDATE,		/* us */
+	TCA_DUALPI2_ALPHA,		/* Hz scaled up by 256 */
+	TCA_DUALPI2_BETA,		/* HZ scaled up by 256 */
+	TCA_DUALPI2_STEP_THRESH,	/* Packets or us */
+	TCA_DUALPI2_STEP_PACKETS,	/* Whether STEP_THRESH is in packets */
+	TCA_DUALPI2_COUPLING,		/* Coupling factor between queues */
+	TCA_DUALPI2_DROP_OVERLOAD,	/* Whether to drop on overload */
+	TCA_DUALPI2_DROP_EARLY,		/* Whether to drop on enqueue */
+	TCA_DUALPI2_C_PROTECTION,	/* Percentage */
+	TCA_DUALPI2_ECN_MASK,		/* L4S queue classification mask */
+	TCA_DUALPI2_SPLIT_GSO,		/* Split aggregated packets */
+	TCA_DUALPI2_PAD,
+	__TCA_DUALPI2_MAX
+};
+
+#define TCA_DUALPI2_MAX   (__TCA_DUALPI2_MAX - 1)
+
+struct tc_dualpi2_xstats {
+	__u32 prob;			/* current probability */
+	__u32 delay_c;			/* current delay in C queue */
+	__u32 delay_l;			/* current delay in L queue */
+	__s32 credit;			/* current c_protection credit */
+	__u32 packets_in_c;		/* number of packets enqueued in C queue */
+	__u32 packets_in_l;		/* number of packets enqueued in L queue */
+	__u32 maxq;			/* maximum queue size */
+	__u32 ecn_mark;			/* packets marked with ecn*/
+	__u32 step_marks;		/* ECN marks due to the step AQM */
+	__u32 memory_used;		/* Meory used of both queues */
+	__u32 max_memory_used;		/* Maximum used memory */
+	__u32 memory_limit;		/* Memory limit of both queues */
+};
+
 #endif
diff --git a/include/utils.h b/include/utils.h
index 9a81494d..91e6e31f 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -146,6 +146,8 @@ int read_prop(const char *dev, char *prop, long *value);
 int get_long(long *val, const char *arg, int base);
 int get_integer(int *val, const char *arg, int base);
 int get_unsigned(unsigned *val, const char *arg, int base);
+int get_float(float *val, const char *arg);
+int get_float_min_max(float *val, const char *arg, float min, float max);
 int get_time_rtt(unsigned *val, const char *arg, int *raw);
 #define get_byte get_u8
 #define get_ushort get_u16
diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index fcffa852..9f6084e6 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -67,20 +67,6 @@ static void usage(void)
 	print_usage(stderr);
 }
 
-static int get_float(float *val, const char *arg)
-{
-	float res;
-	char *ptr;
-
-	if (!arg || !*arg)
-		return -1;
-	res = strtof(arg, &ptr);
-	if (!ptr || ptr == arg || *ptr)
-		return -1;
-	*val = res;
-	return 0;
-}
-
 static void set_ctrlmode(char *name, char *arg,
 			 struct can_ctrlmode *cm, __u32 flags)
 {
diff --git a/lib/utils.c b/lib/utils.c
index 706e93c3..dd242d4d 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -220,6 +220,36 @@ int get_unsigned(unsigned int *val, const char *arg, int base)
 	return 0;
 }
 
+int get_float(float *val, const char *arg)
+{
+	float res;
+	char *ptr;
+
+	if (!arg || !*arg)
+		return -1;
+	res = strtof(arg, &ptr);
+	if (!ptr || ptr == arg || *ptr)
+		return -1;
+	*val = res;
+	return 0;
+}
+
+int get_float_min_max(float *val, const char *arg, float min, float max)
+{
+	float res;
+	char *ptr;
+
+	if (!arg || !*arg)
+		return -1;
+	res = strtof(arg, &ptr);
+	if (!ptr || ptr == arg || *ptr)
+		return -1;
+	if (res < min || res > max)
+		return -1;
+	*val = res;
+	return 0;
+}
+
 /*
  * get_time_rtt is "translated" from a similar routine "get_time" in
  * tc_util.c.  We don't use the exact same routine because tc passes
diff --git a/man/man8/tc-dualpi2.8 b/man/man8/tc-dualpi2.8
new file mode 100644
index 00000000..d136d6e4
--- /dev/null
+++ b/man/man8/tc-dualpi2.8
@@ -0,0 +1,240 @@
+.TH DUALPI2 8 "29 Oct 2024" "iproute2" "Linux"
+
+.SH NAME
+DUALPI2 \- Dual Queue Proportional Integral Controller AQM - Improved with a square
+.SH SYNOPSIS
+.sp
+.ad l
+.in +8
+.ti -8
+.BR tc " " qdisc " ... " dualpi2
+.br
+.RB "[ " limit
+.IR PACKETS " ]"
+.br
+.RB "[ " memlimit
+.IR BYTES " ]"
+.br
+.RB "[ " coupling_factor
+.IR NUMBER " ]"
+.br
+.RB "[ " step_thresh
+.IR TIME | PACKETS " ]"
+.br
+.RB "[ " drop_on_overload " | " overflow " ]"
+.br
+.RB "[ " drop_enqueue " | " drop_dequeue " ]"
+.br
+.RB "[ " l4s_ect " | " any_ect " ]"
+.br
+.RB "[ " classic_protection
+.IR PERCENTAGE " ] "
+.br
+.RB "[ " max_rtt
+.IR TIME
+.RB " [ " typical_rtt
+.IR TIME " ]] "
+.br
+.RB "[ " target
+.IR TIME " ]"
+.br
+.RB "[ " tupdate
+.IR TIME " ]"
+.br
+.RB "[ " alpha
+.IR float " ]"
+.br
+.RB "[ " beta
+.IR float " ] "
+.br
+.RB "[ " split_gso " | " no_split_gso " ]"
+
+.SH DESCRIPTION
+DUALPI2 AQM is a combination of the DUALQ Coupled-AQM with a PI2 base-AQM. The PI2 AQM (details can be found in the paper cited below) is in turn both an extension and a simplification of the PIE AQM. PI2 makes quite some PIE heuristics unnecessary, while being able to control scalable congestion controls like TCP-Prague. With PI2, both Reno/Cubic can be used in parallel with Prague, maintaining window fairness. DUALQ provides latency separation between low latency Prague flows and Reno/Cubic flows that need a bigger queue. The main design goals are:
+.PD 0
+.IP \(bu 4
+L4S - Low Loss, Low Latency and Scalable congestion control support
+.IP \(bu 4
+DualQ option to separate the L4S traffic in a low latency queue (L-queue), without harming remaining traffic that is scheduled in classic queue (C-queue) due to congestion-coupling
+.IP \(bu 4
+Configurable overload strategies
+.IP \(bu 4
+Use of sojourn time to reliably estimate queue delay
+.IP \(bu 4
+Simple implementation
+.IP \(bu 4
+Guaranteed stability and fast responsiveness
+
+.PP
+The detailed PI2 parameters (alpha, beta, and tupdate) of DualPI2 are hard to get right and typically give bad results if just tried or guessed. These parameters need to be calculated to a coherent set with a typical objective in mind. DualPI2 has a set of default parameters that can be used for the general Internet, where the maximum RTT is around 100ms and the typical RTT is around 15ms. It is highly recommended to use
+.I "" max_rtt
+and
+.I "" typical_rtt
+(or target) helper parameters if your deployment is deviating from the above objectives (e.g., in a data center). These helpers are used to provide the theoretically optimal PI2 parameters (alpha, beta, and tupdate) for those objectives, and that can be used as a basis for further finetuning, experimentation, and testing if desired.
+
+.SH ALGORITHM
+DUALPI2 is designed to provide low loss and low latency to L4S traffic, without harming classic traffic. Every update interval, a new internal base probability is calculated based on queue delay. The base probability is updated with a delta based on the difference between the current queue delay and the
+.I "" target
+delay, and the queue growth compared with the queuing delay during the previous
+.I "" tupdate
+interval. The integral gain factor
+.RB "" alpha
+is used to correct slowly enough any persistent standing queue error to the user specified target delay, while the proportional gain factor
+.RB "" beta
+is used to quickly compensate for queue changes (growth or shrink).
+
+The updated base probability is used as input to decide to mark and drop packets. DUALPI2 scales the calculated probability for each of the two queues accordingly. For the L-queue, the probability is multiplied by a
+.RB "" coupling_factor
+, while for the C-queue, it is squared to compensate the squareroot rate equation of Reno/Cubic. The ECT identifier (
+.RB "" l4s_ect | any_ect
+) is used to classify traffic into respective queues.
+
+If DUALPI2 AQM has detected overload (when excessive non-responsive traffic is sent), it can signal congestion solely using
+.RB "" drop
+, irrespective of the ECN field, or alternatively limit the drop probability and let the queue grow and eventually
+.RB "" overflow
+(like tail-drop).
+
+Additional details can be found in the RFC cited below.
+
+.SH PARAMETERS
+.TP
+.BI limit " PACKETS"
+Limit the number of packets that can be enqueued. Incoming packets are dropped when this limit is reached. This limit is common for the L-queue and C-queue. Defaults to
+.I 10000
+packets. This is about 125ms delay on a 1Gbps link.
+.PD
+.TP
+.BI memlimit " BYTES"
+Limit the amount of memory that can be used. Incoming packets are dropped when this memlimit is reached. This memlimit is common for the L-queue and C-queue. Defaults to
+.I 10000 * interface MTU bytes.
+.PD
+.TP
+.BI coupling_factor " NUMBER"
+Set the coupling rate factor between Classic and L4S. Defaults to
+.I 2
+.PD
+.TP
+.BI l4s_ect | any_ect
+Configures the ECT classifier. Packets whose ECT codepoint matches this are sent to the L-queue, where they receive a scalable marking. Defaults to
+.I l4s_ect
+, i.e., the L4S identifier ECT(1). Setting this to
+.I any_ect
+causes all packets whose ECN field is not zero to be sent to the L-queue. This enables it to be backward compatible with, e.g., DCTCP. Note DCTCP should only be used for intra-DC traffic with very low RTTs and AQM delay targets bigger than those RTTs, separated from Internet traffic (also if Prague compliant CC), as it does not support all Prague requirements that make sure that a congestion control can work well with the range of RTTs on the Internet.
+.PD
+.TP
+.BI step_thresh " TIME | PACKETS"
+Set the step threshold for the L-queue. This will cause packets with a sojourn time exceeding the threshold to always be marked. This value can either be specified using time units (i.e., us, ms, s), or in packets (p, pkt, packet(s)). A value without units is assumed to be in time (us). If defining the step in packets, be sure to disable GRO on the ingress interfaces. Defaults to
+.I 1ms
+.PD
+.TP
+.B drop_on_overload  |  overflow
+Control the overload strategy.
+.I drop_on_overload
+preserves the delay in the L-queue by dropping in both queues on overload.
+.I overflow
+sacrifices delay to avoid losses, eventually resulting in a taildrop behavior once the
+.I limit
+is reached. Defaults to
+.I drop_on_overload
+.PD
+.TP
+.B drop_enqueue | drop_dequeue
+Decide when packets are PI-based dropped or marked. The
+.I step_thresh
+based L4S marking is always at dequeue. Defaults to
+.I drop_dequeue
+.PD
+.TP
+.BI classic_protection " PERCENTAGE
+Protects the C-queue from unresponsive traffic in the L-queue. This bounds the maximal scheduling delay in the C-queue to be
+.I (100 - PERCENTAGE)
+times greater than the one in the L-queue. Defaults to
+.I 10
+.TP
+.BI typical_rtt " TIME"
+.PD 0
+.TP
+.PD
+.BI max_rtt " TIME"
+Specify the maximum round trip time (RTT) and/or the typical RTT of the traffic that will be controlled by DUALPI2. These values are specified using time units (i.e., us, ms, s). A value without units is assumed to be in us. If either
+.I max_rtt
+or
+.I typical_rtt
+is not specified, the missing value will be computed from the following relationship:
+.I max_rtt = typical_rtt * 6.
+If any of these parameters is given, it will be used to automatically compute suitable values for
+.I alpha, beta, target, and tupdate,
+according to the relationship from the appendix A.1 in the IETF RFC cited below, to achieve a stable control. Consequently, those derived values will override their eventual user-provided ones. The default range of operation for the qdisc uses
+.I max_rtt = 100ms
+and
+.I typical_rtt = 15ms
+, which is suited to controlling Internet traffic.
+.TP
+.BI target " TIME"
+Set the expected queue delay. Defaults to
+.I 15
+ms. A value without units is assumed to be in us.
+.TP
+.BI tupdate " TIME"
+Set the frequency at which the system drop probability is calculated. Defaults to
+.I 16
+ms. A value without units is assumed to be in us. This should be less than a third of the max RTT supported.
+.TP
+.BI alpha " float"
+.PD 0
+.TP
+.PD
+.BI beta " float"
+Set alpha and beta, the integral and proportional gain factors in Hz for the PI controller. These can be calculated based on control theory. Defaults are
+.I 0.16
+and
+.I 3.2
+Hz, which provide stable control for RTT's up to 100ms with tupdate of 16ms. Be aware, unlike with PIE, these are the real unscaled gain factors. If not provided, they will be automatically derived from
+.I typical_rtt and max_rtt
+, if one of them or both are provided.
+.PD
+.TP
+.B split_gso | no_split_gso
+Decide how to handle aggregated packets. Either treat the aggregate as a single packet (thus all share fate with respect to marks and drops) with
+.I no_split_gso
+, trading some tail latency for CPU usage, or treat each packet individually (i.e., split them) with
+.I split_gso
+to finely mark/drop and control queueing latencies. Defaults to
+.I split_gso
+
+.SH EXAMPLES
+Setting DUALPI2 for the Internet with default parameters:
+ # sudo tc qdisc add dev eth0 root dualpi2
+
+Setting DUALPI2 for datacenter with legacy DCTCP using ECT(0):
+ # sudo tc qdisc add dev eth0 root dualpi2 any_ect
+
+.SH FILTERS
+This qdisc can be used in conjunction with tc-filters. More precisely, it will honor filters "stealing packets", as well as accept other classification schemes.
+.BR
+.TP
+Packets whose priority/classid are set to
+.I 1
+will be enqueued in the L-queue, alongside L4S traffic, and thus subject to the increased marking probability (or drops if they are marked not-ECT).
+.BR
+.TP
+Packets whose priority/classid are set to
+.I 2
+will also be enqueued in the L-queue, but will never be dropped if they are not-ECT (unless the qdisc is full and thus resorts to taildrop).
+.BR
+.TP
+Finally, all the other classid/priority map to the C-queue.
+
+.SH SEE ALSO
+.BR tc (8),
+.BR tc-pie (8)
+
+.SH SOURCES
+.IP \(bu 4
+IETF RFC9332 : https://datatracker.ietf.org/doc/html/rfc9332
+.IP \(bu 4
+CoNEXT '16 Proceedings of the 12th International on Conference on emerging Networking EXperiments and Technologies : "PI2: A Linearized AQM for both Classic and Scalable TCP"
+
+.SH AUTHORS
+DUALPI2 was implemented by Koen De Schepper, Olga Albisser, Henrik Steen, Olivier Tilmans, and Chia-Yu Chang, also the authors of this man page. Please report bugs and corrections to the Linux networking development mailing list at <netdev@vger.kernel.org>.
diff --git a/tc/Makefile b/tc/Makefile
index b5e853d8..6264a772 100644
--- a/tc/Makefile
+++ b/tc/Makefile
@@ -9,6 +9,7 @@ SHARED_LIBS ?= y
 
 TCMODULES :=
 TCMODULES += q_fifo.o
+TCMODULES += q_dualpi2.o
 TCMODULES += q_sfq.o
 TCMODULES += q_red.o
 TCMODULES += q_prio.o
diff --git a/tc/q_dualpi2.c b/tc/q_dualpi2.c
new file mode 100644
index 00000000..b6cb4175
--- /dev/null
+++ b/tc/q_dualpi2.c
@@ -0,0 +1,494 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+/* Copyright (C) 2024 Nokia
+ *
+ * Author: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
+ * Author: Olga Albisser <olga@albisser.org>
+ * Author: Henrik Steen <henrist@henrist.net>
+ * Author: Olivier Tilmans <olivier.tilmans@nokia.com>
+ * Author: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
+ *
+ * DualPI Improved with a Square (dualpi2):
+ * - Supports congestion controls that comply with the Prague requirements
+ *   in RFC9331 (e.g. TCP-Prague)
+ * - Supports coupled dual-queue with PI2 as defined in RFC9332
+ * - Supports ECN L4S-identifier (IP.ECN==0b*1)
+ *
+ * note: Although DCTCP and BBRv3 can use shallow-threshold ECN marks,
+ *   they do not meet the 'Prague L4S Requirements' listed in RFC 9331
+ *   Section 4, so they can only be used with DualPI2 in a datacenter
+ *   context.
+ *
+ * References:
+ * - RFC9332: https://datatracker.ietf.org/doc/html/rfc9332
+ * - De Schepper, Koen, et al. "PI 2: A linearized AQM for both classic and
+ *   scalable TCP."  in proc. ACM CoNEXT'16, 2016.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <syslog.h>
+#include <fcntl.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <string.h>
+#include <math.h>
+#include <errno.h>
+
+#include "utils.h"
+#include "tc_util.h"
+
+#define MAX_PROB ((uint32_t)(~0U))
+#define DEFAULT_ALPHA_BETA ((uint32_t)(~0U))
+#define ALPHA_BETA_MAX ((2 << 23) - 1) /* see net/sched/sch_dualpi2.c */
+#define ALPHA_BETA_SCALE (1 << 8)
+#define RTT_TYP_TO_MAX 6
+
+enum {
+	INET_ECN_NOT_ECT = 0,
+	INET_ECN_ECT_1 = 1,
+	INET_ECN_ECT_0 = 2,
+	INET_ECN_CE = 3,
+	INET_ECN_MASK = 3,
+};
+
+static const char *get_ecn_type(uint8_t ect)
+{
+	switch (ect & INET_ECN_MASK) {
+	case INET_ECN_ECT_1: return "l4s_ect";
+	case INET_ECN_ECT_0:
+	case INET_ECN_MASK: return "any_ect";
+	default:
+		fprintf(stderr,
+			"Warning: Unexpected ecn type %u!\n", ect);
+		return "";
+	}
+}
+
+static void explain(void)
+{
+	fprintf(stderr, "Usage: ... dualpi2\n");
+	fprintf(stderr, "               [limit PACKETS]\n");
+	fprintf(stderr, "               [memlimit BYTES]\n");
+	fprintf(stderr, "               [coupling_factor NUMBER]\n");
+	fprintf(stderr, "               [step_thresh TIME|PACKETS]\n");
+	fprintf(stderr, "               [drop_on_overload|overflow]\n");
+	fprintf(stderr, "               [drop_enqueue|drop_dequeue]\n");
+	fprintf(stderr, "               [classic_protection PERCENTAGE]\n");
+	fprintf(stderr, "               [max_rtt TIME [typical_rtt TIME]]\n");
+	fprintf(stderr, "               [target TIME] [tupdate TIME]\n");
+	fprintf(stderr, "               [alpha ALPHA] [beta BETA]\n");
+	fprintf(stderr, "               [split_gso|no_split_gso]\n");
+}
+
+static int get_packets(uint32_t *val, const char *arg)
+{
+	unsigned long res;
+	char *ptr;
+
+	if (!arg || !*arg)
+		return -1;
+	res = strtoul(arg, &ptr, 10);
+	if (!ptr || ptr == arg ||
+	    (strcmp(ptr, "p") && strcmp(ptr, "pkt") && strcmp(ptr, "pkts") &&
+	     strcmp(ptr, "packet") && strcmp(ptr, "packets")))
+		return -1;
+	if (res == ULONG_MAX && errno == ERANGE)
+		return -1;
+	if (res > 0xFFFFFFFFUL)
+		return -1;
+	*val = res;
+	return 0;
+}
+
+static int parse_alpha_beta(const char *name, char *argv, uint32_t *field)
+{
+
+	float field_f;
+
+	if (get_float_min_max(&field_f, argv, 0.0, ALPHA_BETA_MAX)) {
+		fprintf(stderr, "Illegal \"%s\"\n", name);
+		return -1;
+	} else if (field_f < 1.0f / ALPHA_BETA_SCALE)
+		fprintf(stderr,
+			"Warning: \"%s\" is too small and will be rounded to zero.\n",
+			name);
+	*field = (uint32_t)(field_f * ALPHA_BETA_SCALE);
+	return 0;
+}
+
+static int try_get_percentage(int *val, const char *arg, int base)
+{
+	long res;
+	char *ptr;
+
+	if (!arg || !*arg)
+		return -1;
+	res = strtol(arg, &ptr, base);
+	if (!ptr || ptr == arg || (*ptr && strcmp(ptr, "%")))
+		return -1;
+	if (res == ULONG_MAX && errno == ERANGE)
+		return -1;
+	if (res < 0 || res > 100)
+		return -1;
+
+	*val = res;
+	return 0;
+}
+
+static int dualpi2_parse_opt(struct qdisc_util *qu, int argc, char **argv,
+			     struct nlmsghdr *n, const char *dev)
+{
+	uint32_t limit = 0;
+	uint32_t memory_limit = 0;
+	uint32_t target = 0;
+	uint32_t tupdate = 0;
+	uint32_t alpha = DEFAULT_ALPHA_BETA;
+	uint32_t beta = DEFAULT_ALPHA_BETA;
+	int32_t coupling_factor = -1;
+	uint8_t ecn_mask = INET_ECN_NOT_ECT;
+	bool step_packets = false;
+	uint32_t step_thresh = 0;
+	int c_protection = -1;
+	int drop_early = -1;
+	int drop_overload = -1;
+	int split_gso = -1;
+	uint32_t rtt_max = 0;
+	uint32_t rtt_typ = 0;
+	struct rtattr *tail;
+
+	while (argc > 0) {
+		if (strcmp(*argv, "limit") == 0) {
+			NEXT_ARG();
+			if (get_u32(&limit, *argv, 10)) {
+				fprintf(stderr, "Illegal \"limit\"\n");
+				return -1;
+			}
+		} else if (strcmp(*argv, "memlimit") == 0) {
+			NEXT_ARG();
+			if (get_u32(&memory_limit, *argv, 10)) {
+				fprintf(stderr, "Illegal \"memlimit\"\n");
+				return -1;
+			}
+		} else if (strcmp(*argv, "target") == 0) {
+			NEXT_ARG();
+			if (get_time(&target, *argv)) {
+				fprintf(stderr, "Illegal \"target\"\n");
+				return -1;
+			}
+		} else if (strcmp(*argv, "tupdate") == 0) {
+			NEXT_ARG();
+			if (get_time(&tupdate, *argv)) {
+				fprintf(stderr, "Illegal \"tupdate\"\n");
+				return -1;
+			}
+		} else if (strcmp(*argv, "alpha") == 0) {
+			NEXT_ARG();
+			if (parse_alpha_beta("alpha", *argv, &alpha))
+				return -1;
+		} else if (strcmp(*argv, "beta") == 0) {
+			NEXT_ARG();
+			if (parse_alpha_beta("beta", *argv, &beta))
+				return -1;
+		} else if (strcmp(*argv, "coupling_factor") == 0) {
+			NEXT_ARG();
+			if (get_s32(&coupling_factor, *argv, 0) ||
+			    coupling_factor > 0xFFUL || coupling_factor < 0) {
+				fprintf(stderr,
+					"Illegal \"coupling_factor\"\n");
+				return -1;
+			}
+		} else if (strcmp(*argv, "l4s_ect") == 0)
+			ecn_mask = INET_ECN_ECT_1;
+		else if (strcmp(*argv, "any_ect") == 0)
+			ecn_mask = INET_ECN_MASK;
+		else if (strcmp(*argv, "step_thresh") == 0) {
+			NEXT_ARG();
+			/* First assume that this is specified in time */
+			if (get_time(&step_thresh, *argv)) {
+				/* Then packets */
+				if (get_packets(&step_thresh, *argv)) {
+					fprintf(stderr,
+						"Illegal \"step_thresh\"\n");
+					return -1;
+				}
+				step_packets = true;
+			}
+		} else if (strcmp(*argv, "overflow") == 0) {
+			drop_overload = 0;
+		} else if (strcmp(*argv, "drop_on_overload") == 0) {
+			drop_overload = 1;
+		} else if (strcmp(*argv, "drop_enqueue") == 0) {
+			drop_early = 1;
+		} else if (strcmp(*argv, "drop_dequeue") == 0) {
+			drop_early = 0;
+		} else if (strcmp(*argv, "split_gso") == 0) {
+			split_gso = 1;
+		} else if (strcmp(*argv, "no_split_gso") == 0) {
+			split_gso = 0;
+		} else if (strcmp(*argv, "classic_protection") == 0) {
+			NEXT_ARG();
+			if (try_get_percentage(&c_protection, *argv, 10) ||
+			    c_protection > 100 ||
+			    c_protection < 0) {
+				fprintf(stderr,
+					"Illegal \"classic_protection\"\n");
+				return -1;
+			}
+		} else if (strcmp(*argv, "max_rtt") == 0) {
+			NEXT_ARG();
+			if (get_time(&rtt_max, *argv)) {
+				fprintf(stderr, "Illegal \"rtt_max\"\n");
+				return -1;
+			}
+		} else if (strcmp(*argv, "typical_rtt") == 0) {
+			NEXT_ARG();
+			if (get_time(&rtt_typ, *argv)) {
+				fprintf(stderr, "Illegal \"rtt_typ\"\n");
+				return -1;
+			}
+		} else if (strcmp(*argv, "help") == 0) {
+			explain();
+			return -1;
+		} else {
+			fprintf(stderr, "What is \"%s\"?\n", *argv);
+			explain();
+			return -1;
+		}
+		--argc;
+		++argv;
+	}
+
+	if (rtt_max || rtt_typ) {
+		double alpha_f, beta_f;
+
+		SPRINT_BUF(max_rtt_t);
+		SPRINT_BUF(typ_rtt_t);
+		SPRINT_BUF(tupdate_t);
+		SPRINT_BUF(target_t);
+
+		if (!rtt_typ)
+			rtt_typ = max(rtt_max / RTT_TYP_TO_MAX, 1U);
+		else if (!rtt_max)
+			rtt_max = rtt_typ * RTT_TYP_TO_MAX;
+		else if (rtt_typ > rtt_max) {
+			fprintf(stderr, "typical_rtt must be <= max_rtt!\n");
+			return -1;
+		}
+		if (alpha != DEFAULT_ALPHA_BETA || beta != DEFAULT_ALPHA_BETA ||
+		    tupdate || target)
+			fprintf(stderr,
+				"rtt_max is specified, ignore alpha/beta/tupdate/target\n");
+		target = rtt_typ;
+		tupdate = (double)rtt_typ < (double)rtt_max / 3.0f ?
+			rtt_typ : (double)rtt_max / 3.0f;
+		tupdate = max(tupdate, 1U);
+		alpha_f = (double)tupdate / rtt_max / rtt_max
+			* TIME_UNITS_PER_SEC * 0.1f;
+		beta_f = 0.3f / (double)rtt_max * TIME_UNITS_PER_SEC;
+		if (beta_f > ALPHA_BETA_MAX) {
+			fprintf(stderr,
+				"max_rtt=%s is too low and cause beta to overflow!\n",
+				sprint_time(rtt_max, max_rtt_t));
+			return -1;
+		}
+		if (alpha_f < 1.0f / ALPHA_BETA_SCALE ||
+		    beta_f < 1.0f / ALPHA_BETA_SCALE) {
+			fprintf(stderr,
+				"Large max_rtt=%s rounds down alpha=%f and/or beta=%f!\n",
+				sprint_time(rtt_max, max_rtt_t),
+				alpha_f, beta_f);
+			return -1;
+		}
+		fprintf(stderr,
+			"Auto-config [max_rtt: %s, typical_rtt: %s]: target=%s tupdate=%s alpha=%f beta=%f\n",
+			sprint_time(rtt_max, max_rtt_t),
+			sprint_time(rtt_typ, typ_rtt_t),
+			sprint_time(target, target_t),
+			sprint_time(tupdate, tupdate_t), alpha_f, beta_f);
+		alpha = alpha_f * ALPHA_BETA_SCALE;
+		beta = beta_f * ALPHA_BETA_SCALE;
+	}
+
+	tail = addattr_nest(n, 1024, TCA_OPTIONS | NLA_F_NESTED);
+	if (limit)
+		addattr32(n, 1024, TCA_DUALPI2_LIMIT, limit);
+	if (memory_limit)
+		addattr32(n, 1024, TCA_DUALPI2_MEMORY_LIMIT, memory_limit);
+	if (tupdate)
+		addattr32(n, 1024, TCA_DUALPI2_TUPDATE, tupdate);
+	if (target)
+		addattr32(n, 1024, TCA_DUALPI2_TARGET, target);
+	if (alpha != DEFAULT_ALPHA_BETA)
+		addattr32(n, 1024, TCA_DUALPI2_ALPHA, alpha);
+	if (beta != DEFAULT_ALPHA_BETA)
+		addattr32(n, 1024, TCA_DUALPI2_BETA, beta);
+	if (ecn_mask != INET_ECN_NOT_ECT)
+		addattr8(n, 1024, TCA_DUALPI2_ECN_MASK, ecn_mask);
+	if (drop_overload != -1)
+		addattr8(n, 1024, TCA_DUALPI2_DROP_OVERLOAD, drop_overload);
+	if (coupling_factor != -1)
+		addattr8(n, 1024, TCA_DUALPI2_COUPLING, coupling_factor);
+	if (split_gso != -1)
+		addattr8(n, 1024, TCA_DUALPI2_SPLIT_GSO, split_gso);
+	if (step_thresh) {
+		addattr32(n, 1024, TCA_DUALPI2_STEP_THRESH, step_thresh);
+		addattr8(n, 1024, TCA_DUALPI2_STEP_PACKETS, step_packets);
+	}
+	if (drop_early != -1)
+		addattr8(n, 1024, TCA_DUALPI2_DROP_EARLY, drop_early);
+	if (c_protection != -1)
+		addattr8(n, 1024, TCA_DUALPI2_C_PROTECTION, c_protection);
+	addattr_nest_end(n, tail);
+	return 0;
+}
+
+static float get_scaled_alpha_beta(struct rtattr *tb)
+{
+	if (tb == NULL)
+		return 0;
+
+	if (RTA_PAYLOAD(tb) < sizeof(__u32))
+		return -1;
+
+	return ((float)rta_getattr_u32(tb)) / ALPHA_BETA_SCALE;
+}
+
+static int dualpi2_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+{
+	struct rtattr *tb[TCA_DUALPI2_MAX + 1];
+	uint32_t tupdate;
+	uint32_t target;
+	uint8_t ecn_type;
+	uint8_t drop_overload;
+	uint32_t step_thresh;
+	uint8_t drop_early;
+	uint8_t split_gso;
+	bool step_packets = false;
+
+	SPRINT_BUF(b1);
+
+	if (opt == NULL)
+		return 0;
+
+	parse_rtattr_nested(tb, TCA_DUALPI2_MAX, opt);
+
+	if (tb[TCA_DUALPI2_LIMIT] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_LIMIT]) >= sizeof(__u32))
+		print_uint(PRINT_ANY, "limit", "limit %up ",
+			   rta_getattr_u32(tb[TCA_DUALPI2_LIMIT]));
+	if (tb[TCA_DUALPI2_MEMORY_LIMIT] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_MEMORY_LIMIT]) >= sizeof(__u32))
+		print_uint(PRINT_ANY, "memlimit", "memlimit %uB ",
+			   rta_getattr_u32(tb[TCA_DUALPI2_MEMORY_LIMIT]));
+	if (tb[TCA_DUALPI2_TARGET] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_TARGET]) >= sizeof(__u32)) {
+		target = rta_getattr_u32(tb[TCA_DUALPI2_TARGET]);
+		print_uint(PRINT_JSON, "target", NULL, target);
+		print_string(PRINT_FP, NULL, "target %s ",
+			     sprint_time(target, b1));
+	}
+	if (tb[TCA_DUALPI2_TUPDATE] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_TUPDATE]) >= sizeof(__u32)) {
+		tupdate = rta_getattr_u32(tb[TCA_DUALPI2_TUPDATE]);
+		print_uint(PRINT_JSON, "tupdate", NULL, tupdate);
+		print_string(PRINT_FP, NULL, "tupdate %s ",
+			     sprint_time(tupdate, b1));
+	}
+	if (tb[TCA_DUALPI2_ALPHA] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_ALPHA]) >= sizeof(__u32))
+		print_float(PRINT_ANY, "alpha", "alpha %f ",
+			    get_scaled_alpha_beta(tb[TCA_DUALPI2_ALPHA]));
+	if (tb[TCA_DUALPI2_BETA] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_BETA]) >= sizeof(__u32))
+		print_float(PRINT_ANY, "beta", "beta %f ",
+			    get_scaled_alpha_beta(tb[TCA_DUALPI2_BETA]));
+	if (tb[TCA_DUALPI2_ECN_MASK] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_ECN_MASK]) >= sizeof(__u8)) {
+		ecn_type = rta_getattr_u8(tb[TCA_DUALPI2_ECN_MASK]);
+		print_uint(PRINT_JSON, "ecn_type", NULL, ecn_type);
+		print_string(PRINT_FP, NULL, "%s ",
+			     get_ecn_type(ecn_type));
+	}
+	if (tb[TCA_DUALPI2_COUPLING] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_COUPLING]) >= sizeof(__u8))
+		print_uint(PRINT_ANY, "coupling_factor", "coupling_factor %u ",
+			   rta_getattr_u8(tb[TCA_DUALPI2_COUPLING]));
+	if (tb[TCA_DUALPI2_DROP_OVERLOAD] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_DROP_OVERLOAD]) >= sizeof(__u8)) {
+		drop_overload = rta_getattr_u8(tb[TCA_DUALPI2_DROP_OVERLOAD]);
+		print_string(PRINT_FP, NULL, "%s ",
+			     drop_overload ? "drop_on_overload" : "overflow");
+		print_bool(PRINT_JSON, "drop_on_overload", NULL,
+			   !!drop_overload);
+	}
+	if (tb[TCA_DUALPI2_STEP_PACKETS] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_STEP_PACKETS]) >= sizeof(__u8) &&
+	    rta_getattr_u8(tb[TCA_DUALPI2_STEP_PACKETS]))
+		step_packets = true;
+	if (tb[TCA_DUALPI2_STEP_THRESH] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_STEP_THRESH]) >= sizeof(__u32)) {
+		step_thresh = rta_getattr_u32(tb[TCA_DUALPI2_STEP_THRESH]);
+		if (step_packets) {
+			print_uint(PRINT_ANY, "step_thresh",
+				   "step_thresh %upkt ", step_thresh);
+		} else {
+			print_uint(PRINT_JSON, "step_thresh", NULL,
+				   step_thresh);
+			print_string(PRINT_FP, NULL, "step_thresh %s ",
+				     sprint_time(step_thresh, b1));
+		}
+	}
+	if (tb[TCA_DUALPI2_DROP_EARLY] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_DROP_EARLY]) >= sizeof(__u8)) {
+		drop_early = rta_getattr_u8(tb[TCA_DUALPI2_DROP_EARLY]);
+		print_string(PRINT_FP, NULL, "%s ",
+			     drop_early ? "drop_enqueue" : "drop_dequeue");
+		print_bool(PRINT_JSON, "drop_early", NULL, !!drop_early);
+	}
+	if (tb[TCA_DUALPI2_SPLIT_GSO] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_SPLIT_GSO]) >= sizeof(__u8)) {
+		split_gso = rta_getattr_u8(tb[TCA_DUALPI2_SPLIT_GSO]);
+		print_string(PRINT_FP, NULL, "%ssplit_gso ", split_gso ? "" : "no_");
+		print_bool(PRINT_JSON, "split_gso", NULL, !!split_gso);
+	}
+	if (tb[TCA_DUALPI2_C_PROTECTION] &&
+	    RTA_PAYLOAD(tb[TCA_DUALPI2_C_PROTECTION]) >= sizeof(__u8))
+		print_uint(PRINT_ANY, "classic_protection",
+			   "classic_protection %u%% ",
+			   rta_getattr_u8(tb[TCA_DUALPI2_C_PROTECTION]));
+
+	return 0;
+}
+
+static int dualpi2_print_xstats(struct qdisc_util *qu, FILE *f,
+			    struct rtattr *xstats)
+{
+	struct tc_dualpi2_xstats *st;
+
+	if (xstats == NULL)
+		return 0;
+
+	if (RTA_PAYLOAD(xstats) < sizeof(*st))
+		return -1;
+
+	st = RTA_DATA(xstats);
+	fprintf(f, "prob %f delay_c %uus delay_l %uus\n",
+		(double)st->prob / (double)MAX_PROB, st->delay_c, st->delay_l);
+	fprintf(f, "pkts_in_c %u pkts_in_l %u maxq %u\n",
+		st->packets_in_c, st->packets_in_l, st->maxq);
+	fprintf(f, "ecn_mark %u step_marks %u\n", st->ecn_mark, st->step_marks);
+	fprintf(f, "credit %d (%c)\n", st->credit, st->credit > 0 ? 'C' : 'L');
+	fprintf(f, "memory used %u (max %u) of memory limit %u\n",
+		st->memory_used, st->max_memory_used, st->memory_limit);
+	return 0;
+
+}
+
+struct qdisc_util dualpi2_qdisc_util = {
+	.id		= "dualpi2",
+	.parse_qopt	= dualpi2_parse_opt,
+	.print_qopt	= dualpi2_print_opt,
+	.print_xstats	= dualpi2_print_xstats,
+};
-- 
2.34.1


