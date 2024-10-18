Return-Path: <netdev+bounces-136802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AB89A326A
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 104D328510A
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988A213D51C;
	Fri, 18 Oct 2024 02:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ajG7ZrPn"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2050.outbound.protection.outlook.com [40.107.247.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3784756742
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 02:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729217439; cv=fail; b=tRaM01olydfL1c+0bqcR8tKLYDvyraXyG4J/pyTAmaGfl9ZMeqNUwbqzrBiBHz10kEGHIObsrzEGBC8i2z+aLj/T9TGI9gq+MKWZdOI/ECepPAelUgE9S0uYtvu6lxxF+77mqSXG8zm5IYZSJisFhBMfcVaOU/JXb70PhROzIR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729217439; c=relaxed/simple;
	bh=8krqVDgFa3mKVvFUKT+Q7QcqBsemQBk5NDHrZ3Ow89A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IzxuUlvmao7TPTFYl6t7+DJKPbO3yM2GTeWtiuYoXFRDCDjedswkZf3+pIPNBBvMSukkq8BArhjCA6hZtfmVYuFkHC5dTl/QYQaNzyh5D0m/RkejnsNXrg3+YWBJ5i9MGXc3CtzFYxviv9GW043GVRGuuLK6qLpAErocZvdFj9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ajG7ZrPn; arc=fail smtp.client-ip=40.107.247.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLMUUBp3F8iNa0xd3dZ4O+2eVQYjcK4FbrE2gyigZb89r+73QLTUAxVlIPcd1MdrQ2W794csOTLLS3mECqFQckZOgAoidtkxCeInUH4YwLHpez/3wzX55IcL0J4PhUecZvxC0lFZCK/HKH9aiOE4yaXJVjXzlPv5BWjobwW9sLgDGTbds1x6GqNfvdk4hk7DIoZFMSd5FBQi/0NEqs5HOiRu8VvC5wppML6uHZ4nJcdCSnAojw/nST+Wcz3nhin4LdRLA48tKlWRpnF3B4CHc7UfhT3J49bvvvtAkLnKX5O7EsqwIncZ2nnfQSXTvhgOe//zj0EE94IX+08G7r3hCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcOyLgLmAEm+ZloQ8M+f/lIJZn0uAzdiFQmO/+jgQDQ=;
 b=FxpFGrUkvk+6ZbruPQOdnMCff54SP10o2+znabxJmYCRzCvRk4+FysIJGUen1Dw4MAJ6RurBV3YJuWG8sXROC7Tiyhy+FnBbNbGmoI3Fegfhh/300WVL9woWVAQ9gcUtrwjdp+HtdxWiuGmoKExAbTg1Tn96m3pa65JZreoY6ab6iJkQWc3oDnjzsn8xxPrzb2kwQIdgU2MnprnUTt5wzKbZEHbMvg1E59MNmcxRCOFoPWFkdGwM0mIxwrZzQHeI7YuRlKR0CogCkgWvNfFd4PFB6x2uqRx4Kjbx0oi6osrYJwNEItgvcUPo2l1v9whDDOuoziK/A+sxffBnxl3l1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcOyLgLmAEm+ZloQ8M+f/lIJZn0uAzdiFQmO/+jgQDQ=;
 b=ajG7ZrPnh60+BUbonJVdvubbKNS4nzTm27undyajfW3VmUIi9kdZstE7/RB6kAWjLuFtGh5AORdLlx04asAYkaVVFsAMiSaly5zgxKb5MrZhcfjUovLTQUcD12EJLH9wvPhUHJXjh1/QC7UyAUkrj1DLbst074Azlm3rA2WReXGURhKuTAhj6+e/0sMPS6C1uIUEoHhSpucJm2oGT2ykFp8Py6Pn3fUBjSfwdxwgOXvDrTQRZHYOpyCBXGCJUormw4vRLd0DxIfqdSx/pSKJJ23z3CdY+/4E3d/TN+SXV+3GkQ2WdJ0kWi4hxrOqW4eUsrKmxKaOYyIzLd+n0Q81Tw==
Received: from AM0PR03CA0025.eurprd03.prod.outlook.com (2603:10a6:208:14::38)
 by AS8PR07MB7976.eurprd07.prod.outlook.com (2603:10a6:20b:352::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 02:10:29 +0000
Received: from AM3PEPF0000A793.eurprd04.prod.outlook.com
 (2603:10a6:208:14:cafe::fb) by AM0PR03CA0025.outlook.office365.com
 (2603:10a6:208:14::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Fri, 18 Oct 2024 02:10:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM3PEPF0000A793.mail.protection.outlook.com (10.167.16.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 02:10:29 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49I2ABFR008653;
	Fri, 18 Oct 2024 02:10:23 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Olga Albisser <olga@albisser.org>,
        Olivier Tilmans <olivier.tilmans@nokia.com>,
        Henrik Steen <henrist@henrist.net>,
        Bob Briscoe <research@bobbriscoe.net>,
        Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 1/1] sched: Add dualpi2 qdisc
Date: Fri, 18 Oct 2024 04:10:04 +0200
Message-Id: <20241018021004.39258-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018021004.39258-1-chia-yu.chang@nokia-bell-labs.com>
References: <20241018021004.39258-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A793:EE_|AS8PR07MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d5a0ee-fc4b-4d6a-571e-08dcef1a0a15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGo4OVVES2ZYUGdUNEw0RDFMZHhkc04wRUVMaGo0NzNXc3ZxVEp4S2NhVjU5?=
 =?utf-8?B?QlJEZ1Qxam9kWlZHS1FKaENzK0ZQNE5LdkJ3Z0VsWHk3K1ppemZNODJvb0l2?=
 =?utf-8?B?d1NrclNkdjNnay9NTG1uWFpTOEVXTjlLa0NSOUhlMTlLZmVoR0Q4eGdvTlZX?=
 =?utf-8?B?RzJZNXpQcSt0bFE5WEp3MU1KYmRseWJ2QjFwMnRhNDNqSmNOZHI5dFFwWFBF?=
 =?utf-8?B?eno1c0RZMHJXc3BURWhkR3Q1a3dnNXQzTTBlbEJEZEpKQnV4aElTRUg4NnhY?=
 =?utf-8?B?Y2NqK1BhSEdnOVRwa2JkdTk4b0lFSFNxNThmUFBPZ0tsMmF2NklhYW03OGts?=
 =?utf-8?B?RUVUVmR5RVJHYWlSVURoay9OTUVEbjd0VHdDUFFCWXZxTUZQUjFSVXFnOXpS?=
 =?utf-8?B?bzEyS2xyMWJVUEo1SUFZeUl1SlEyWUZEc0JDT0U4bFpDZTVSUHIyZHZkdjN6?=
 =?utf-8?B?NlhLeWRORWNFTGp6Q2tWZW81bnNMQ2tBN05PYTFXVUZUK3FVTktaRTRrUW1Y?=
 =?utf-8?B?Z0RiaWg4T01XVXk2RnYyWlBmRGxNSXpzQmV4SHkrU3NjTllqYkd3cnhxcW9O?=
 =?utf-8?B?ajRQbVQ2REhHUVkvd3ZyVFM1OXo4bU92cUJ4dFZtQ3pVa3JCckg3bXBKbi9o?=
 =?utf-8?B?cnJ2KzNwQWNWR2dWQUV4QjBicjdDTVgrRjlOTzNpWXMwL1BaVmp5TGFYNXZB?=
 =?utf-8?B?MDZiRldHQTZ5UjNaKzR0OEI3VXJ2YVI4Z2tYV1JIQUYzNWZWaExHekFzZDN2?=
 =?utf-8?B?OXI2c3FwVkxUUmtpem9ZU0lGSElVWGt3ejdhM3NDVDRtOEdJQXV5di9hbURC?=
 =?utf-8?B?NWRIRzAzR0g3TUMxSkZSOVhCQ1QzUzVwS3k5VE1aaFh1bi9DaHNBcEpHQVdK?=
 =?utf-8?B?cmIzZkdKUW5QcXJLWjZMTndHRS8xa1ExSVIyMnZlZCtWSHJXSVZoWVArMmYz?=
 =?utf-8?B?SFdHeVk2M0dxSHprd3lJakY0NEJEUW1naVRIR0NBZURZblFLSytQM2NVYllt?=
 =?utf-8?B?RGlvZUVvYVhObXFHejFpVHZ6Y3hTUEV1R2xaQUw0dHd5T1UrOW1QL015NlVV?=
 =?utf-8?B?SnZmNHYxODhCeERrbWtGcUpoOWN1S1UvYzNOSG9STEI5b3o0OVMzeWZvN0k4?=
 =?utf-8?B?cVk4N2JXRXgxNWdkeXRtT2RVS1VJSnlGNHN6SnNaWGNTdXcyd2NmNVcySDZ0?=
 =?utf-8?B?KzYydWhXZkd3bW5Kb3ozTUxWRnJaQVIrZDh3anFFcnJpL0QrUnhleDB1bjZn?=
 =?utf-8?B?Zk1JMkwyWnY4QXdaK25EaGFvVFd5dmh2aUdPMWRSZGtXZ3NKYUZwZkFQSHNk?=
 =?utf-8?B?dDhOcllVR0xmYWtuVGZoMnR5eGw1Y0E3TzY5OGZLRnUrRDM5RXFnQ2lWWUto?=
 =?utf-8?B?OVJIREVyVThlTkJKdHprTTg1dnN1b1ovSnA5KzVNSG9UaVdNQnlQTFU5ZS9F?=
 =?utf-8?B?cXJwQzE1Wmhxemx0QnNESW1HQWF1N2FBWElqbkFLWnR2aWxDTTR2NkZrdmY0?=
 =?utf-8?B?cVlTMUl2dTJsMEhjdlBqNDdFUVFFYTJtd1BQWmVBYjR0YTRZZWJ4cUJVQjBE?=
 =?utf-8?B?bnZNZ1Rycmg3dTlqNVNsOGMzM0dHaXZDZGd3M2ZwSXlYT0dQRVBWQWxQUkFE?=
 =?utf-8?B?bE00MlRBbXY1YXc5WWpNZytPMGs0UFNsL0hudkw2TVdJU3JGdzlJRGgzVlRw?=
 =?utf-8?B?SGVnRjdGbmsrTUM0UXJRbkFMRy9ZKytKbXhNREFhYWRCTGVHNHIzcXB2OG15?=
 =?utf-8?B?S2lRYm4zMFNWckpicGIvZVJnZXdlbUFhMDFzY3pZby8yMjFmcENmM25jVlg5?=
 =?utf-8?B?L0ZFVHNYWmt6a0E4UURNblljNGdhamxrVjNJREVLa0Z4c0xoTmF2ZWJCWFhX?=
 =?utf-8?B?UXl3ZU1XNkNNcjlVM3lUSjJLZm0rZ2VLNU83ZFljcW52UDluS1FtcmdiUmhW?=
 =?utf-8?Q?pXlhMj3lq2Q=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 02:10:29.6032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d5a0ee-fc4b-4d6a-571e-08dcef1a0a15
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7976

From: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>

DualPI2 provides L4S-type low latency & loss to traffic that uses a
scalable congestion controller (e.g. TCP-Prague, DCTCP) without
degrading the performance of 'classic' traffic (e.g. Reno,
Cubic etc.). It is intended to be the reference implementation of the
IETF's DualQ Coupled AQM.

The qdisc provides two queues called low latency and classic. It
classifies packets based on the ECN field in the IP headers. By
default it directs non-ECN and ECT(0) into the classic queue and
ECT(1) and CE into the low latency queue, as per the IETF spec.

Each queue runs its own AQM:
* The classic AQM is called PI2, which is similar to the PIE AQM but
  more responsive and simpler. Classic traffic requires a decent
  target queue (default 15ms for Internet deployment) to fully
  utilize the link and to avoid high drop rates.
* The low latency AQM is, by default, a very shallow ECN marking
  threshold (1ms) similar to that used for DCTCP.

The DualQ isolates the low queuing delay of the Low Latency queue
from the larger delay of the 'Classic' queue. However, from a
bandwidth perspective, flows in either queue will share out the link
capacity as if there was just a single queue. This bandwidth pooling
effect is achieved by coupling together the drop and ECN-marking
probabilities of the two AQMs.

The PI2 AQM has two main parameters in addition to its target delay.
All the defaults are suitable for any Internet setting, but it can
be reconfigured for a Data Centre setting. The integral gain factor
alpha is used to slowly correct any persistent standing queue error
from the target delay, while the proportional gain factor beta is
used to quickly compensate for queue changes (growth or shrinkage).
Either alpha and beta are given as a parameter, or they can be
calculated by tc from alternative typical and maximum RTT parameters.

Internally, the output of a linear Proportional Integral (PI)
controller is used for both queues. This output is squared to
calculate the drop or ECN-marking probability of the classic queue.
This counterbalances the square-root rate equation of Reno/Cubic,
which is the trick that balances flow rates across the queues. For
the ECN-marking probability of the low latency queue, the output of
the base AQM is multiplied by a coupling factor. This determines the
balance between the flow rates in each queue. The default setting
makes the flow rates roughly equal, which should be generally
applicable.

If DUALPI2 AQM has detected overload (due to excessive non-responsive
traffic in either queue), it will switch to signaling congestion
solely using drop, irrespective of the ECN field. Alternatively, it
can be configured to limit the drop probability and let the queue
grow and eventually overflow (like tail-drop).

Additional details can be found in the draft:
  https://datatracker.ietf.org/doc/html/rfc9332

Signed-off-by: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
Co-developed-by: Olga Albisser <olga@albisser.org>
Signed-off-by: Olga Albisser <olga@albisser.org>
Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Co-developed-by: Henrik Steen <henrist@henrist.net>
Signed-off-by: Henrik Steen <henrist@henrist.net>
Signed-off-by: Bob Briscoe <research@bobbriscoe.net>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 Documentation/netlink/specs/tc.yaml |  108 +++
 include/linux/netdevice.h           |    1 +
 include/uapi/linux/pkt_sched.h      |   34 +
 net/sched/Kconfig                   |   20 +
 net/sched/Makefile                  |    1 +
 net/sched/sch_dualpi2.c             | 1045 +++++++++++++++++++++++++++
 6 files changed, 1209 insertions(+)
 create mode 100644 net/sched/sch_dualpi2.c

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index b02d59a0349c..d3277d66a35c 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -856,6 +856,37 @@ definitions:
         name: memory-usage
         type: u32
         doc: Total memory across all queues
+  -
+    name: tc-dualpi2-xstats
+    type: struct
+    members:
+      -
+        name: prob
+        type: u32
+      -
+        name: delay_c
+        type: u32
+      -
+        name: delay_l
+        type: u32
+      -
+        name: pkts_in_c
+        type: u32
+      -
+        name: pkts_in_l
+        type: u32
+      -
+        name: maxq
+        type: u32
+      -
+        name: ecn_mark
+        type: u32
+      -
+        name: step_mark
+        type: u32
+      -
+        name: credit
+        type: s32
   -
     name: tc-fq-qd-stats
     type: struct
@@ -3223,6 +3254,77 @@ attribute-sets:
       -
         name: dq-rate-estimator
         type: u32
+  -
+    name: tc-dualpi2-attrs
+    attributes:
+      -
+        name: limit
+        type: u32
+        doc:  Limit the number of packets can be enqueued
+      -
+        name: target
+        type: u64
+        doc: Expected queue delay
+      -
+        name: tupdate
+        type: u32
+        doc: Frequency at which drop probability is calculated
+      -
+        name: alpha
+        type: u32
+        doc: Integral gain factors in Hz for PI controller
+      -
+        name: beta
+        type: u32
+        doc: Proportional gain factors in Hz for PI controller
+      -
+        name: coupling_factor
+        type: u8
+        doc: Probability coupling factor between Classic and L4S
+      -
+        name: step_thresh
+        type: u32
+        doc: Step marking thresohld (time/packet) for L4S
+      -
+        name: drop_overload
+        type: flags
+        doc: Control the overload strategy
+        entries:
+        - drop_on_overload
+        - overflow
+      -
+        name: ecn_mask
+        type: flags
+        doc: Configure the ECT classifier
+        entries:
+        - l4s_ect
+        - any_ect
+      -
+        name: drop_early
+        type: flags
+        doc: Decide when packets are PI-based dropped or marked
+        entries:
+        - drop_enqueue
+        - drop_dequeue
+      -
+        name: gso_split
+        type: flags
+        doc: Split aggregated skb or not
+        entries:
+        - split_gso
+        - no_split_gso
+      -
+        name: classic_protection
+        type: u8
+        doc:  Classic protection in percentage (from 0 to 100)
+      -
+        name: max_rtt
+        type: u32
+        doc: The maximum RTT of the traffic that controlled by DualPI2
+      -
+        name: typical_rtt
+        type: u32
+        doc: The typical RTT of the traffic that controlled by DualPI2
   -
     name: tc-netem-attrs
     attributes:
@@ -3700,6 +3802,9 @@ sub-messages:
       -
         value: fq_pie
         attribute-set: tc-fq-pie-attrs
+      -
+        value: fq_dualpi2
+        attribute-set: tc-dualpi2-attrs
       -
         value: fw
         attribute-set: tc-fw-attrs
@@ -3855,6 +3960,9 @@ sub-messages:
       -
         value: fq_pie
         fixed-header: tc-fq-pie-xstats
+      -
+        value: fq_dualpi2
+        fixed-header: tc-fq-dualpi2-xstats
       -
         value: hhf
         fixed-header: tc-hhf-xstats
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8feaca12655e..bdd7d6262112 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -30,6 +30,7 @@
 #include <asm/byteorder.h>
 #include <asm/local.h>
 
+#include <linux/netdev_features.h>
 #include <linux/percpu.h>
 #include <linux/rculist.h>
 #include <linux/workqueue.h>
diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 25a9a47001cd..f2418eabdcb1 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -1210,4 +1210,38 @@ enum {
 
 #define TCA_ETS_MAX (__TCA_ETS_MAX - 1)
 
+/* DUALPI2 */
+enum {
+	TCA_DUALPI2_UNSPEC,
+	TCA_DUALPI2_LIMIT,		/* Packets */
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
+	TCA_DUALPI2_SPLIT_GSO,		/* Split GSO packets at enqueue */
+	TCA_DUALPI2_PAD,
+	__TCA_DUALPI2_MAX
+};
+
+#define TCA_DUALPI2_MAX   (__TCA_DUALPI2_MAX - 1)
+
+struct tc_dualpi2_xstats {
+	__u32 prob;		/* current probability */
+	__u32 delay_c;		/* current delay in C queue */
+	__u32 delay_l;		/* current delay in L queue */
+	__s32 credit;		/* current c_protection credit */
+	__u32 packets_in_c;	/* number of packets enqueued in C queue */
+	__u32 packets_in_l;	/* number of packets enqueued in L queue */
+	__u32 maxq;		/* maximum queue size */
+	__u32 ecn_mark;		/* packets marked with ecn*/
+	__u32 step_marks;	/* ECN marks due to the step AQM */
+};
+
 #endif
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index 8180d0c12fce..c1421e219040 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -403,6 +403,26 @@ config NET_SCH_ETS
 
 	  If unsure, say N.
 
+config NET_SCH_DUALPI2
+	tristate "Dual Queue Proportional Integral Controller Improved with a Square (DUALPI2) scheduler"
+	help
+	  Say Y here if you want to use the DualPI2 AQM.
+	  This is a combination of the DUALQ Coupled-AQM with a PI2 base-AQM.
+	  The PI2 AQM is in turn both an extension and a simplification of the
+	  PIE AQM. PI2 makes quite some PIE heuristics unnecessary, while being
+	  able to control scalable congestion controls like DCTCP and
+	  TCP-Prague. With PI2, both Reno/Cubic can be used in parallel with
+	  DCTCP, maintaining window fairness. DUALQ provides latency separation
+	  between low latency DCTCP flows and Reno/Cubic flows that need a
+	  bigger queue.
+	  For more information, please see
+	  https://datatracker.ietf.org/doc/html/rfc9332
+
+	  To compile this code as a module, choose M here: the module
+	  will be called sch_dualpi2.
+
+	  If unsure, say N.
+
 menuconfig NET_SCH_DEFAULT
 	bool "Allow override default queue discipline"
 	help
diff --git a/net/sched/Makefile b/net/sched/Makefile
index 82c3f78ca486..1abb06554057 100644
--- a/net/sched/Makefile
+++ b/net/sched/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_NET_SCH_FQ_PIE)	+= sch_fq_pie.o
 obj-$(CONFIG_NET_SCH_CBS)	+= sch_cbs.o
 obj-$(CONFIG_NET_SCH_ETF)	+= sch_etf.o
 obj-$(CONFIG_NET_SCH_TAPRIO)	+= sch_taprio.o
+obj-$(CONFIG_NET_SCH_DUALPI2)	+= sch_dualpi2.o
 
 obj-$(CONFIG_NET_CLS_U32)	+= cls_u32.o
 obj-$(CONFIG_NET_CLS_ROUTE4)	+= cls_route.o
diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
new file mode 100644
index 000000000000..a31b1b62ce38
--- /dev/null
+++ b/net/sched/sch_dualpi2.c
@@ -0,0 +1,1045 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2024 Nokia
+ *
+ * Author: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
+ * Author: Olga Albisser <olga@albisser.org>
+ * Author: Henrik Steen <henrist@henrist.net>
+ * Author: Olivier Tilmans <olivier.tilmans@nokia-bell-labs.com>
+ * Author: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
+ *
+ * DualPI Improved with a Square (dualpi2):
+ * - Supports congestion controls that comply with the Prague requirements
+ *   in RFC9331 (e.g. TCP-Prague)
+ * - Supports coupled dual-queue with PI2 as defined in RFC9332
+ * - Supports ECN L4S-identifier (IP.ECN==0b*1)
+ *
+ * note: DCTCP is not Prague compliant, so DCTCP & DualPI2 can only be
+ *   used in DC context; BBRv3 (overwrites bbr) stopped Prague support,
+ *   you should use TCP-Prague instead for low latency apps
+ *
+ * References:
+ * - RFC9332: https://datatracker.ietf.org/doc/html/rfc9332
+ * - De Schepper, Koen, et al. "PI 2: A linearized AQM for both classic and
+ *   scalable TCP."  in proc. ACM CoNEXT'16, 2016.
+ */
+
+#include <linux/errno.h>
+#include <linux/hrtimer.h>
+#include <linux/if_vlan.h>
+#include <linux/kernel.h>
+#include <linux/limits.h>
+#include <linux/module.h>
+#include <linux/skbuff.h>
+#include <linux/types.h>
+
+#include <net/gso.h>
+#include <net/inet_ecn.h>
+#include <net/pkt_cls.h>
+#include <net/pkt_sched.h>
+
+/* 32b enable to support flows with windows up to ~8.6 * 1e9 packets
+ * i.e., twice the maximal snd_cwnd.
+ * MAX_PROB must be consistent with the RNG in dualpi2_roll().
+ */
+#define MAX_PROB U32_MAX
+/* alpha/beta values exchanged over netlink are in units of 256ns */
+#define ALPHA_BETA_SHIFT 8
+/* Scaled values of alpha/beta must fit in 32b to avoid overflow in later
+ * computations. Consequently (see and dualpi2_scale_alpha_beta()), their
+ * netlink-provided values can use at most 31b, i.e. be at most (2^23)-1
+ * (~4MHz) as those are given in 1/256th. This enable to tune alpha/beta to
+ * control flows whose maximal RTTs can be in usec up to few secs.
+ */
+#define ALPHA_BETA_MAX ((1U << 31) - 1)
+/* Internal alpha/beta are in units of 64ns.
+ * This enables to use all alpha/beta values in the allowed range without loss
+ * of precision due to rounding when scaling them internally, e.g.,
+ * scale_alpha_beta(1) will not round down to 0.
+ */
+#define ALPHA_BETA_GRANULARITY 6
+#define ALPHA_BETA_SCALING (ALPHA_BETA_SHIFT - ALPHA_BETA_GRANULARITY)
+/* We express the weights (wc, wl) in %, i.e., wc + wl = 100 */
+#define MAX_WC 100
+
+struct dualpi2_sched_data {
+	struct Qdisc *l_queue;	/* The L4S LL queue */
+	struct Qdisc *sch;	/* The classic queue (owner of this struct) */
+
+	/* Registered tc filters */
+	struct {
+		struct tcf_proto __rcu *filters;
+		struct tcf_block *block;
+	} tcf;
+
+	struct { /* PI2 parameters */
+		u64	target;	/* Target delay in nanoseconds */
+		u32	tupdate;/* Timer frequency in nanoseconds */
+		u32	prob;	/* Base PI probability */
+		u32	alpha;	/* Gain factor for the integral rate response */
+		u32	beta;	/* Gain factor for the proportional response */
+		struct hrtimer timer; /* prob update timer */
+	} pi2;
+
+	struct { /* Step AQM (L4S queue only) parameters */
+		u32 thresh;	/* Step threshold */
+		bool in_packets;/* Whether the step is in packets or time */
+	} step;
+
+	struct { /* Classic queue starvation protection */
+		s32	credit; /* Credit (sign indicates which queue) */
+		s32	init;	/* Reset value of the credit */
+		u8	wc;	/* C queue weight (between 0 and MAX_WC) */
+		u8	wl;	/* L queue weight (MAX_WC - wc) */
+	} c_protection;
+
+	/* General dualQ parameters */
+	u8	coupling_factor;/* Coupling factor (k) between both queues */
+	u8	ecn_mask;	/* Mask to match L4S packets */
+	bool	drop_early;	/* Drop at enqueue instead of dequeue if true */
+	bool	drop_overload;	/* Drop (1) on overload, or overflow (0) */
+	bool	split_gso;	/* Split aggregated skb (1) or leave as is */
+
+	/* Statistics */
+	u64	c_head_ts;	/* Enqueue timestamp of the classic Q's head */
+	u64	l_head_ts;	/* Enqueue timestamp of the L Q's head */
+	u64	last_qdelay;	/* Q delay val at the last probability update */
+	u32	packets_in_c;	/* Number of packets enqueued in C queue */
+	u32	packets_in_l;	/* Number of packets enqueued in L queue */
+	u32	maxq;		/* maximum queue size */
+	u32	ecn_mark;	/* packets marked with ECN */
+	u32	step_marks;	/* ECN marks due to the step AQM */
+
+	struct { /* Deferred drop statistics */
+		u32 cnt;	/* Packets dropped */
+		u32 len;	/* Bytes dropped */
+	} deferred_drops;
+};
+
+struct dualpi2_skb_cb {
+	u64 ts;			/* Timestamp at enqueue */
+	u8 apply_step:1,	/* Can we apply the step threshold */
+	   classified:2,	/* Packet classification results */
+	   ect:2;		/* Packet ECT codepoint */
+};
+
+enum dualpi2_classification_results {
+	DUALPI2_C_CLASSIC	= 0,	/* C queue */
+	DUALPI2_C_L4S		= 1,	/* L queue (scalable marking/classic drops) */
+	DUALPI2_C_LLLL		= 2,	/* L queue (no drops/marks) */
+	__DUALPI2_C_MAX			/* Keep last*/
+};
+
+static struct dualpi2_skb_cb *dualpi2_skb_cb(struct sk_buff *skb)
+{
+	qdisc_cb_private_validate(skb, sizeof(struct dualpi2_skb_cb));
+	return (struct dualpi2_skb_cb *)qdisc_skb_cb(skb)->data;
+}
+
+static u64 dualpi2_sojourn_time(struct sk_buff *skb, u64 reference)
+{
+	return reference - dualpi2_skb_cb(skb)->ts;
+}
+
+static u64 head_enqueue_time(struct Qdisc *q)
+{
+	struct sk_buff *skb = qdisc_peek_head(q);
+
+	return skb ? dualpi2_skb_cb(skb)->ts : 0;
+}
+
+static u32 dualpi2_scale_alpha_beta(u32 param)
+{
+	u64 tmp = ((u64)param * MAX_PROB >> ALPHA_BETA_SCALING);
+
+	do_div(tmp, NSEC_PER_SEC);
+	return tmp;
+}
+
+static u32 dualpi2_unscale_alpha_beta(u32 param)
+{
+	u64 tmp = ((u64)param * NSEC_PER_SEC << ALPHA_BETA_SCALING);
+
+	do_div(tmp, MAX_PROB);
+	return tmp;
+}
+
+static ktime_t next_pi2_timeout(struct dualpi2_sched_data *q)
+{
+	return ktime_add_ns(ktime_get_ns(), q->pi2.tupdate);
+}
+
+static bool skb_is_l4s(struct sk_buff *skb)
+{
+	return dualpi2_skb_cb(skb)->classified == DUALPI2_C_L4S;
+}
+
+static bool skb_in_l_queue(struct sk_buff *skb)
+{
+	return dualpi2_skb_cb(skb)->classified != DUALPI2_C_CLASSIC;
+}
+
+static bool dualpi2_mark(struct dualpi2_sched_data *q, struct sk_buff *skb)
+{
+	if (INET_ECN_set_ce(skb)) {
+		q->ecn_mark++;
+		return true;
+	}
+	return false;
+}
+
+static void dualpi2_reset_c_protection(struct dualpi2_sched_data *q)
+{
+	q->c_protection.credit = q->c_protection.init;
+}
+
+/* This computes the initial credit value and WRR weight for the L queue (wl)
+ * from the weight of the C queue (wc).
+ * If wl > wc, the scheduler will start with the L queue when reset.
+ */
+static void dualpi2_calculate_c_protection(struct Qdisc *sch,
+					   struct dualpi2_sched_data *q, u32 wc)
+{
+	q->c_protection.wc = wc;
+	q->c_protection.wl = MAX_WC - wc;
+	q->c_protection.init = (s32)psched_mtu(qdisc_dev(sch)) *
+		((int)q->c_protection.wc - (int)q->c_protection.wl);
+	dualpi2_reset_c_protection(q);
+}
+
+static bool dualpi2_roll(u32 prob)
+{
+	return get_random_u32() <= prob;
+}
+
+/* Packets in the C queue are subject to a marking probability pC, which is the
+ * square of the internal PI2 probability (i.e., have an overall lower mark/drop
+ * probability). If the qdisc is overloaded, ignore ECT values and only drop.
+ *
+ * Note that this marking scheme is also applied to L4S packets during overload.
+ * Return true if packet dropping is required in C queue
+ */
+static bool dualpi2_classic_marking(struct dualpi2_sched_data *q,
+				    struct sk_buff *skb, u32 prob,
+				    bool overload)
+{
+	if (dualpi2_roll(prob) && dualpi2_roll(prob)) {
+		if (overload || dualpi2_skb_cb(skb)->ect == INET_ECN_NOT_ECT)
+			return true;
+		dualpi2_mark(q, skb);
+	}
+	return false;
+}
+
+/* Packets in the L queue are subject to a marking probability pL given by the
+ * internal PI2 probability scaled by the coupling factor.
+ *
+ * On overload (i.e., @local_l_prob is >= 100%):
+ * - if the qdisc is configured to trade losses to preserve latency (i.e.,
+ *   @q->drop_overload), apply classic drops first before marking.
+ * - otherwise, preserve the "no loss" property of ECN at the cost of queueing
+ *   delay, eventually resulting in taildrop behavior once sch->limit is
+ *   reached.
+ * Return true if packet dropping is required in L queue
+ */
+static bool dualpi2_scalable_marking(struct dualpi2_sched_data *q,
+				     struct sk_buff *skb,
+				     u64 local_l_prob, u32 prob,
+				     bool overload)
+{
+	if (overload) {
+		/* Apply classic drop */
+		if (!q->drop_overload ||
+		    !(dualpi2_roll(prob) && dualpi2_roll(prob)))
+			goto mark;
+		return true;
+	}
+
+	/* We can safely cut the upper 32b as overload==false */
+	if (dualpi2_roll(local_l_prob)) {
+		/* Non-ECT packets could have classified as L4S by filters. */
+		if (dualpi2_skb_cb(skb)->ect == INET_ECN_NOT_ECT)
+			return true;
+mark:
+		dualpi2_mark(q, skb);
+	}
+	return false;
+}
+
+/* Decide whether a given packet must be dropped (or marked if ECT), according
+ * to the PI2 probability.
+ *
+ * Never mark/drop if we have a standing queue of less than 2 MTUs.
+ */
+static bool must_drop(struct Qdisc *sch, struct dualpi2_sched_data *q,
+		      struct sk_buff *skb)
+{
+	u64 local_l_prob;
+	u32 prob;
+	bool overload;
+
+	if (sch->qstats.backlog < 2 * psched_mtu(qdisc_dev(sch)))
+		return false;
+
+	prob = READ_ONCE(q->pi2.prob);
+	local_l_prob = (u64)prob * q->coupling_factor;
+	overload = local_l_prob > MAX_PROB;
+
+	switch (dualpi2_skb_cb(skb)->classified) {
+	case DUALPI2_C_CLASSIC:
+		return dualpi2_classic_marking(q, skb, prob, overload);
+	case DUALPI2_C_L4S:
+		return dualpi2_scalable_marking(q, skb, local_l_prob, prob,
+						overload);
+	default: /* DUALPI2_C_LLLL */
+		return false;
+	}
+}
+
+static void dualpi2_read_ect(struct sk_buff *skb)
+{
+	struct dualpi2_skb_cb *cb = dualpi2_skb_cb(skb);
+	int wlen = skb_network_offset(skb);
+
+	switch (skb_protocol(skb, true)) {
+	case htons(ETH_P_IP):
+		wlen += sizeof(struct iphdr);
+		if (!pskb_may_pull(skb, wlen) ||
+		    skb_try_make_writable(skb, wlen))
+			goto not_ecn;
+
+		cb->ect = ipv4_get_dsfield(ip_hdr(skb)) & INET_ECN_MASK;
+		break;
+	case htons(ETH_P_IPV6):
+		wlen += sizeof(struct ipv6hdr);
+		if (!pskb_may_pull(skb, wlen) ||
+		    skb_try_make_writable(skb, wlen))
+			goto not_ecn;
+
+		cb->ect = ipv6_get_dsfield(ipv6_hdr(skb)) & INET_ECN_MASK;
+		break;
+	default:
+		goto not_ecn;
+	}
+	return;
+
+not_ecn:
+	/* Non pullable/writable packets can only be dropped hence are
+	 * classified as not ECT.
+	 */
+	cb->ect = INET_ECN_NOT_ECT;
+}
+
+static int dualpi2_skb_classify(struct dualpi2_sched_data *q,
+				struct sk_buff *skb)
+{
+	struct dualpi2_skb_cb *cb = dualpi2_skb_cb(skb);
+	struct tcf_result res;
+	struct tcf_proto *fl;
+	int result;
+
+	dualpi2_read_ect(skb);
+	if (cb->ect & q->ecn_mask) {
+		cb->classified = DUALPI2_C_L4S;
+		return NET_XMIT_SUCCESS;
+	}
+
+	if (TC_H_MAJ(skb->priority) == q->sch->handle &&
+	    TC_H_MIN(skb->priority) < __DUALPI2_C_MAX) {
+		cb->classified = TC_H_MIN(skb->priority);
+		return NET_XMIT_SUCCESS;
+	}
+
+	fl = rcu_dereference_bh(q->tcf.filters);
+	if (!fl) {
+		cb->classified = DUALPI2_C_CLASSIC;
+		return NET_XMIT_SUCCESS;
+	}
+
+	result = tcf_classify(skb, NULL, fl, &res, false);
+	if (result >= 0) {
+#ifdef CONFIG_NET_CLS_ACT
+		switch (result) {
+		case TC_ACT_STOLEN:
+		case TC_ACT_QUEUED:
+		case TC_ACT_TRAP:
+			return NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
+		case TC_ACT_SHOT:
+			return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
+		}
+#endif
+		cb->classified = TC_H_MIN(res.classid) < __DUALPI2_C_MAX ?
+			TC_H_MIN(res.classid) : DUALPI2_C_CLASSIC;
+	}
+	return NET_XMIT_SUCCESS;
+}
+
+static int dualpi2_enqueue_skb(struct sk_buff *skb, struct Qdisc *sch,
+			       struct sk_buff **to_free)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	struct dualpi2_skb_cb *cb;
+
+	if (unlikely(qdisc_qlen(sch) >= sch->limit)) {
+		qdisc_qstats_overlimit(sch);
+		if (skb_in_l_queue(skb))
+			qdisc_qstats_overlimit(q->l_queue);
+		return qdisc_drop(skb, sch, to_free);
+	}
+
+	if (q->drop_early && must_drop(sch, q, skb)) {
+		qdisc_drop(skb, sch, to_free);
+		return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
+	}
+
+	cb = dualpi2_skb_cb(skb);
+	cb->ts = ktime_get_ns();
+
+	if (qdisc_qlen(sch) > q->maxq)
+		q->maxq = qdisc_qlen(sch);
+
+	if (skb_in_l_queue(skb)) {
+		/* Only apply the step if a queue is building up */
+		dualpi2_skb_cb(skb)->apply_step =
+			skb_is_l4s(skb) && qdisc_qlen(q->l_queue) > 1;
+		/* Keep the overall qdisc stats consistent */
+		++sch->q.qlen;
+		qdisc_qstats_backlog_inc(sch, skb);
+		++q->packets_in_l;
+		if (!q->l_head_ts)
+			q->l_head_ts = cb->ts;
+		return qdisc_enqueue_tail(skb, q->l_queue);
+	}
+	++q->packets_in_c;
+	if (!q->c_head_ts)
+		q->c_head_ts = cb->ts;
+	return qdisc_enqueue_tail(skb, sch);
+}
+
+/* Optionally, dualpi2 will split GSO skbs into independent skbs and enqueue
+ * each of those individually. This yields the following benefits, at the
+ * expense of CPU usage:
+ * - Finer-grained AQM actions as the sub-packets of a burst no longer share the
+ *   same fate (e.g., the random mark/drop probability is applied individually)
+ * - Improved precision of the starvation protection/WRR scheduler at dequeue,
+ *   as the size of the dequeued packets will be smaller.
+ */
+static int dualpi2_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
+				 struct sk_buff **to_free)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	int err;
+
+	err = dualpi2_skb_classify(q, skb);
+	if (err != NET_XMIT_SUCCESS) {
+		if (err & __NET_XMIT_BYPASS)
+			qdisc_qstats_drop(sch);
+		__qdisc_drop(skb, to_free);
+		return err;
+	}
+
+	if (q->split_gso && skb_is_gso(skb)) {
+		netdev_features_t features;
+		struct sk_buff *nskb, *next;
+		int cnt, byte_len, orig_len;
+		int err;
+
+		features = netif_skb_features(skb);
+		nskb = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
+		if (IS_ERR_OR_NULL(nskb))
+			return qdisc_drop(skb, sch, to_free);
+
+		cnt = 1;
+		byte_len = 0;
+		orig_len = qdisc_pkt_len(skb);
+		while (nskb) {
+			next = nskb->next;
+			skb_mark_not_on_list(nskb);
+			qdisc_skb_cb(nskb)->pkt_len = nskb->len;
+			dualpi2_skb_cb(nskb)->classified =
+				dualpi2_skb_cb(skb)->classified;
+			dualpi2_skb_cb(nskb)->ect = dualpi2_skb_cb(skb)->ect;
+			err = dualpi2_enqueue_skb(nskb, sch, to_free);
+			if (err == NET_XMIT_SUCCESS) {
+				/* Compute the backlog adjustement that needs
+				 * to be propagated in the qdisc tree to reflect
+				 * all new skbs successfully enqueued.
+				 */
+				++cnt;
+				byte_len += nskb->len;
+			}
+			nskb = next;
+		}
+		if (err == NET_XMIT_SUCCESS) {
+			/* The caller will add the original skb stats to its
+			 * backlog, compensate this.
+			 */
+			--cnt;
+			byte_len -= orig_len;
+		}
+		qdisc_tree_reduce_backlog(sch, -cnt, -byte_len);
+		consume_skb(skb);
+		return err;
+	}
+	return dualpi2_enqueue_skb(skb, sch, to_free);
+}
+
+/* Select the queue from which the next packet can be dequeued, ensuring that
+ * neither queue can starve the other with a WRR scheduler.
+ *
+ * The sign of the WRR credit determines the next queue, while the size of
+ * the dequeued packet determines the magnitude of the WRR credit change. If
+ * either queue is empty, the WRR credit is kept unchanged.
+ *
+ * As the dequeued packet can be dropped later, the caller has to perform the
+ * qdisc_bstats_update() calls.
+ */
+static struct sk_buff *dequeue_packet(struct Qdisc *sch,
+				      struct dualpi2_sched_data *q,
+				      int *credit_change,
+				      u64 now)
+{
+	struct sk_buff *skb = NULL;
+	int c_len;
+
+	*credit_change = 0;
+	c_len = qdisc_qlen(sch) - qdisc_qlen(q->l_queue);
+	if (qdisc_qlen(q->l_queue) && (!c_len || q->c_protection.credit <= 0)) {
+		skb = __qdisc_dequeue_head(&q->l_queue->q);
+		WRITE_ONCE(q->l_head_ts, head_enqueue_time(q->l_queue));
+		if (c_len)
+			*credit_change = q->c_protection.wc;
+		qdisc_qstats_backlog_dec(q->l_queue, skb);
+		/* Keep the global queue size consistent */
+		--sch->q.qlen;
+	} else if (c_len) {
+		skb = __qdisc_dequeue_head(&sch->q);
+		WRITE_ONCE(q->c_head_ts, head_enqueue_time(sch));
+		if (qdisc_qlen(q->l_queue))
+			*credit_change = ~((s32)q->c_protection.wl) + 1;
+	} else {
+		dualpi2_reset_c_protection(q);
+		return NULL;
+	}
+	*credit_change *= qdisc_pkt_len(skb);
+	qdisc_qstats_backlog_dec(sch, skb);
+	return skb;
+}
+
+static int do_step_aqm(struct dualpi2_sched_data *q, struct sk_buff *skb,
+		       u64 now)
+{
+	u64 qdelay = 0;
+
+	if (q->step.in_packets)
+		qdelay = qdisc_qlen(q->l_queue);
+	else
+		qdelay = skb_sojourn_time(skb, now);
+
+	if (dualpi2_skb_cb(skb)->apply_step && qdelay > q->step.thresh) {
+		if (!dualpi2_skb_cb(skb)->ect)
+			/* Drop this non-ECT packet */
+			return 1;
+		if (dualpi2_mark(q, skb))
+			++q->step_marks;
+	}
+	qdisc_bstats_update(q->l_queue, skb);
+	return 0;
+}
+
+static void drop_and_retry(struct dualpi2_sched_data *q, struct sk_buff *skb, struct Qdisc *sch)
+{
+	++q->deferred_drops.cnt;
+	q->deferred_drops.len += qdisc_pkt_len(skb);
+	consume_skb(skb);
+	qdisc_qstats_drop(sch);
+}
+
+static struct sk_buff *dualpi2_qdisc_dequeue(struct Qdisc *sch)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	struct sk_buff *skb;
+	int credit_change;
+	u64 now;
+
+	now = ktime_get_ns();
+
+	while ((skb = dequeue_packet(sch, q, &credit_change, now))) {
+		if (!q->drop_early && must_drop(sch, q, skb)) {
+			drop_and_retry(q, skb, sch);
+			continue;
+		}
+
+		if (skb_in_l_queue(skb) && do_step_aqm(q, skb, now)) {
+			qdisc_qstats_drop(q->l_queue);
+			drop_and_retry(q, skb, sch);
+			continue;
+		}
+
+		q->c_protection.credit += credit_change;
+		qdisc_bstats_update(sch, skb);
+		break;
+	}
+
+	/* We cannot call qdisc_tree_reduce_backlog() if our qlen is 0,
+	 * or HTB crashes.
+	 */
+	if (q->deferred_drops.cnt && qdisc_qlen(sch)) {
+		qdisc_tree_reduce_backlog(sch, q->deferred_drops.cnt,
+					  q->deferred_drops.len);
+		q->deferred_drops.cnt = 0;
+		q->deferred_drops.len = 0;
+	}
+	return skb;
+}
+
+static s64 __scale_delta(u64 diff)
+{
+	do_div(diff, 1 << ALPHA_BETA_GRANULARITY);
+	return diff;
+}
+
+static void get_queue_delays(struct dualpi2_sched_data *q, u64 *qdelay_c,
+			     u64 *qdelay_l)
+{
+	u64 now, qc, ql;
+
+	now = ktime_get_ns();
+	qc = READ_ONCE(q->c_head_ts);
+	ql = READ_ONCE(q->l_head_ts);
+
+	*qdelay_c = qc ? now - qc : 0;
+	*qdelay_l = ql ? now - ql : 0;
+}
+
+static u32 calculate_probability(struct Qdisc *sch)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	u32 new_prob;
+	u64 qdelay_c;
+	u64 qdelay_l;
+	u64 qdelay;
+	s64 delta;
+
+	get_queue_delays(q, &qdelay_c, &qdelay_l);
+	qdelay = max(qdelay_l, qdelay_c);
+	/* Alpha and beta take at most 32b, i.e, the delay difference would
+	 * overflow for queuing delay differences > ~4.2sec.
+	 */
+	delta = ((s64)qdelay - q->pi2.target) * q->pi2.alpha;
+	delta += ((s64)qdelay - q->last_qdelay) * q->pi2.beta;
+	if (delta > 0) {
+		new_prob = __scale_delta(delta) + q->pi2.prob;
+		if (new_prob < q->pi2.prob)
+			new_prob = MAX_PROB;
+	} else {
+		new_prob = q->pi2.prob - __scale_delta(~delta + 1);
+		if (new_prob > q->pi2.prob)
+			new_prob = 0;
+	}
+	q->last_qdelay = qdelay;
+	/* If we do not drop on overload, ensure we cap the L4S probability to
+	 * 100% to keep window fairness when overflowing.
+	 */
+	if (!q->drop_overload)
+		return min_t(u32, new_prob, MAX_PROB / q->coupling_factor);
+	return new_prob;
+}
+
+static enum hrtimer_restart dualpi2_timer(struct hrtimer *timer)
+{
+	struct dualpi2_sched_data *q = from_timer(q, timer, pi2.timer);
+
+	WRITE_ONCE(q->pi2.prob, calculate_probability(q->sch));
+
+	hrtimer_set_expires(&q->pi2.timer, next_pi2_timeout(q));
+	return HRTIMER_RESTART;
+}
+
+static const struct nla_policy dualpi2_policy[TCA_DUALPI2_MAX + 1] = {
+	[TCA_DUALPI2_LIMIT] = {.type = NLA_U32},
+	[TCA_DUALPI2_TARGET] = {.type = NLA_U32},
+	[TCA_DUALPI2_TUPDATE] = {.type = NLA_U32},
+	[TCA_DUALPI2_ALPHA] = {.type = NLA_U32},
+	[TCA_DUALPI2_BETA] = {.type = NLA_U32},
+	[TCA_DUALPI2_STEP_THRESH] = {.type = NLA_U32},
+	[TCA_DUALPI2_STEP_PACKETS] = {.type = NLA_U8},
+	[TCA_DUALPI2_COUPLING] = {.type = NLA_U8},
+	[TCA_DUALPI2_DROP_OVERLOAD] = {.type = NLA_U8},
+	[TCA_DUALPI2_DROP_EARLY] = {.type = NLA_U8},
+	[TCA_DUALPI2_C_PROTECTION] = {.type = NLA_U8},
+	[TCA_DUALPI2_ECN_MASK] = {.type = NLA_U8},
+	[TCA_DUALPI2_SPLIT_GSO] = {.type = NLA_U8},
+};
+
+static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
+			  struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[TCA_DUALPI2_MAX + 1];
+	struct dualpi2_sched_data *q;
+	int old_backlog;
+	int old_qlen;
+	int err;
+
+	if (!opt)
+		return -EINVAL;
+	err = nla_parse_nested(tb, TCA_DUALPI2_MAX, opt, dualpi2_policy, extack);
+	if (err < 0)
+		return err;
+
+	q = qdisc_priv(sch);
+	sch_tree_lock(sch);
+
+	if (tb[TCA_DUALPI2_LIMIT]) {
+		u32 limit = nla_get_u32(tb[TCA_DUALPI2_LIMIT]);
+
+		if (!limit) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[TCA_DUALPI2_LIMIT],
+					    "limit must be greater than 0.");
+			sch_tree_unlock(sch);
+			return -EINVAL;
+		}
+		sch->limit = limit;
+	}
+
+	if (tb[TCA_DUALPI2_TARGET])
+		q->pi2.target = (u64)nla_get_u32(tb[TCA_DUALPI2_TARGET]) *
+			NSEC_PER_USEC;
+
+	if (tb[TCA_DUALPI2_TUPDATE]) {
+		u64 tupdate = nla_get_u32(tb[TCA_DUALPI2_TUPDATE]);
+
+		if (!tupdate) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[TCA_DUALPI2_TUPDATE],
+					    "tupdate cannot be 0us.");
+			sch_tree_unlock(sch);
+			return -EINVAL;
+		}
+		q->pi2.tupdate = tupdate * NSEC_PER_USEC;
+	}
+
+	if (tb[TCA_DUALPI2_ALPHA]) {
+		u32 alpha = nla_get_u32(tb[TCA_DUALPI2_ALPHA]);
+
+		if (alpha > ALPHA_BETA_MAX) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[TCA_DUALPI2_ALPHA],
+					    "alpha is too large.");
+			sch_tree_unlock(sch);
+			return -EINVAL;
+		}
+		q->pi2.alpha = dualpi2_scale_alpha_beta(alpha);
+	}
+
+	if (tb[TCA_DUALPI2_BETA]) {
+		u32 beta = nla_get_u32(tb[TCA_DUALPI2_BETA]);
+
+		if (beta > ALPHA_BETA_MAX) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[TCA_DUALPI2_BETA],
+					    "beta is too large.");
+			sch_tree_unlock(sch);
+			return -EINVAL;
+		}
+		q->pi2.beta = dualpi2_scale_alpha_beta(beta);
+	}
+
+	if (tb[TCA_DUALPI2_STEP_THRESH])
+		q->step.thresh = nla_get_u32(tb[TCA_DUALPI2_STEP_THRESH]) *
+			NSEC_PER_USEC;
+
+	if (tb[TCA_DUALPI2_COUPLING]) {
+		u8 coupling = nla_get_u8(tb[TCA_DUALPI2_COUPLING]);
+
+		if (!coupling) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[TCA_DUALPI2_COUPLING],
+					    "Must use a non-zero coupling.");
+			sch_tree_unlock(sch);
+			return -EINVAL;
+		}
+		q->coupling_factor = coupling;
+	}
+
+	if (tb[TCA_DUALPI2_STEP_PACKETS])
+		q->step.in_packets = !!nla_get_u8(tb[TCA_DUALPI2_STEP_PACKETS]);
+
+	if (tb[TCA_DUALPI2_DROP_OVERLOAD])
+		q->drop_overload = !!nla_get_u8(tb[TCA_DUALPI2_DROP_OVERLOAD]);
+
+	if (tb[TCA_DUALPI2_DROP_EARLY])
+		q->drop_early = !!nla_get_u8(tb[TCA_DUALPI2_DROP_EARLY]);
+
+	if (tb[TCA_DUALPI2_C_PROTECTION]) {
+		u8 wc = nla_get_u8(tb[TCA_DUALPI2_C_PROTECTION]);
+
+		if (wc > MAX_WC) {
+			NL_SET_ERR_MSG_ATTR(extack,
+					    tb[TCA_DUALPI2_C_PROTECTION],
+					    "c_protection must be <= 100.");
+			sch_tree_unlock(sch);
+			return -EINVAL;
+		}
+		dualpi2_calculate_c_protection(sch, q, wc);
+	}
+
+	if (tb[TCA_DUALPI2_ECN_MASK])
+		q->ecn_mask = nla_get_u8(tb[TCA_DUALPI2_ECN_MASK]);
+
+	if (tb[TCA_DUALPI2_SPLIT_GSO])
+		q->split_gso = !!nla_get_u8(tb[TCA_DUALPI2_SPLIT_GSO]);
+
+	old_qlen = qdisc_qlen(sch);
+	old_backlog = sch->qstats.backlog;
+	while (qdisc_qlen(sch) > sch->limit) {
+		struct sk_buff *skb = __qdisc_dequeue_head(&sch->q);
+
+		qdisc_qstats_backlog_dec(sch, skb);
+		rtnl_qdisc_drop(skb, sch);
+	}
+	qdisc_tree_reduce_backlog(sch, old_qlen - qdisc_qlen(sch),
+				  old_backlog - sch->qstats.backlog);
+
+	sch_tree_unlock(sch);
+	return 0;
+}
+
+/* Default alpha/beta values give a 10dB stability margin with max_rtt=100ms. */
+static void dualpi2_reset_default(struct dualpi2_sched_data *q)
+{
+	q->sch->limit = 10000;				/* Max 125ms at 1Gbps */
+
+	q->pi2.target = 15 * NSEC_PER_MSEC;
+	q->pi2.tupdate = 16 * NSEC_PER_MSEC;
+	q->pi2.alpha = dualpi2_scale_alpha_beta(41);	/* ~0.16 Hz * 256 */
+	q->pi2.beta = dualpi2_scale_alpha_beta(819);	/* ~3.20 Hz * 256 */
+
+	q->step.thresh = 1 * NSEC_PER_MSEC;
+	q->step.in_packets = false;
+
+	dualpi2_calculate_c_protection(q->sch, q, 10);	/* wc=10%, wl=90% */
+
+	q->ecn_mask = INET_ECN_ECT_1;
+	q->coupling_factor = 2;		/* window fairness for equal RTTs */
+	q->drop_overload = true;	/* Preserve latency by dropping */
+	q->drop_early = false;		/* PI2 drops on dequeue */
+	q->split_gso = true;
+}
+
+static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
+			struct netlink_ext_ack *extack)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	int err;
+
+	q->l_queue = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
+				       TC_H_MAKE(sch->handle, 1), extack);
+	if (!q->l_queue)
+		return -ENOMEM;
+
+	err = tcf_block_get(&q->tcf.block, &q->tcf.filters, sch, extack);
+	if (err)
+		return err;
+
+	q->sch = sch;
+	dualpi2_reset_default(q);
+	hrtimer_init(&q->pi2.timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
+	q->pi2.timer.function = dualpi2_timer;
+
+	if (opt) {
+		err = dualpi2_change(sch, opt, extack);
+
+		if (err)
+			return err;
+	}
+
+	hrtimer_start(&q->pi2.timer, next_pi2_timeout(q),
+		      HRTIMER_MODE_ABS_PINNED);
+	return 0;
+}
+
+static u32 convert_ns_to_usec(u64 ns)
+{
+	do_div(ns, NSEC_PER_USEC);
+	return ns;
+}
+
+static int dualpi2_dump(struct Qdisc *sch, struct sk_buff *skb)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	struct nlattr *opts;
+
+	opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
+	if (!opts)
+		goto nla_put_failure;
+
+	if (nla_put_u32(skb, TCA_DUALPI2_LIMIT, sch->limit) ||
+	    nla_put_u32(skb, TCA_DUALPI2_TARGET,
+			convert_ns_to_usec(q->pi2.target)) ||
+	    nla_put_u32(skb, TCA_DUALPI2_TUPDATE,
+			convert_ns_to_usec(q->pi2.tupdate)) ||
+	    nla_put_u32(skb, TCA_DUALPI2_ALPHA,
+			dualpi2_unscale_alpha_beta(q->pi2.alpha)) ||
+	    nla_put_u32(skb, TCA_DUALPI2_BETA,
+			dualpi2_unscale_alpha_beta(q->pi2.beta)) ||
+	    nla_put_u32(skb, TCA_DUALPI2_STEP_THRESH, q->step.in_packets ?
+			q->step.thresh : convert_ns_to_usec(q->step.thresh)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_COUPLING, q->coupling_factor) ||
+	    nla_put_u8(skb, TCA_DUALPI2_DROP_OVERLOAD, q->drop_overload) ||
+	    nla_put_u8(skb, TCA_DUALPI2_STEP_PACKETS, q->step.in_packets) ||
+	    nla_put_u8(skb, TCA_DUALPI2_DROP_EARLY, q->drop_early) ||
+	    nla_put_u8(skb, TCA_DUALPI2_C_PROTECTION, q->c_protection.wc) ||
+	    nla_put_u8(skb, TCA_DUALPI2_ECN_MASK, q->ecn_mask) ||
+	    nla_put_u8(skb, TCA_DUALPI2_SPLIT_GSO, q->split_gso))
+		goto nla_put_failure;
+
+	return nla_nest_end(skb, opts);
+
+nla_put_failure:
+	nla_nest_cancel(skb, opts);
+	return -1;
+}
+
+static int dualpi2_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	struct tc_dualpi2_xstats st = {
+		.prob		= READ_ONCE(q->pi2.prob),
+		.packets_in_c	= q->packets_in_c,
+		.packets_in_l	= q->packets_in_l,
+		.maxq		= q->maxq,
+		.ecn_mark	= q->ecn_mark,
+		.credit		= q->c_protection.credit,
+		.step_marks	= q->step_marks,
+	};
+	u64 qc, ql;
+
+	get_queue_delays(q, &qc, &ql);
+	st.delay_l = convert_ns_to_usec(ql);
+	st.delay_c = convert_ns_to_usec(qc);
+	return gnet_stats_copy_app(d, &st, sizeof(st));
+}
+
+static void dualpi2_reset(struct Qdisc *sch)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+
+	qdisc_reset_queue(sch);
+	qdisc_reset_queue(q->l_queue);
+	q->c_head_ts = 0;
+	q->l_head_ts = 0;
+	q->pi2.prob = 0;
+	q->packets_in_c = 0;
+	q->packets_in_l = 0;
+	q->maxq = 0;
+	q->ecn_mark = 0;
+	q->step_marks = 0;
+	dualpi2_reset_c_protection(q);
+}
+
+static void dualpi2_destroy(struct Qdisc *sch)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+
+	q->pi2.tupdate = 0;
+	hrtimer_cancel(&q->pi2.timer);
+	if (q->l_queue)
+		qdisc_put(q->l_queue);
+	tcf_block_put(q->tcf.block);
+}
+
+static struct Qdisc *dualpi2_leaf(struct Qdisc *sch, unsigned long arg)
+{
+	return NULL;
+}
+
+static unsigned long dualpi2_find(struct Qdisc *sch, u32 classid)
+{
+	return 0;
+}
+
+static unsigned long dualpi2_bind(struct Qdisc *sch, unsigned long parent,
+				  u32 classid)
+{
+	return 0;
+}
+
+static void dualpi2_unbind(struct Qdisc *q, unsigned long cl)
+{
+}
+
+static struct tcf_block *dualpi2_tcf_block(struct Qdisc *sch, unsigned long cl,
+					   struct netlink_ext_ack *extack)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+
+	if (cl)
+		return NULL;
+	return q->tcf.block;
+}
+
+static void dualpi2_walk(struct Qdisc *sch, struct qdisc_walker *arg)
+{
+	unsigned int i;
+
+	if (arg->stop)
+		return;
+
+	/* We statically define only 2 queues */
+	for (i = 0; i < 2; i++) {
+		if (arg->count < arg->skip) {
+			arg->count++;
+			continue;
+		}
+		if (arg->fn(sch, i + 1, arg) < 0) {
+			arg->stop = 1;
+			break;
+		}
+		arg->count++;
+	}
+}
+
+/* Minimal class support to handler tc filters */
+static const struct Qdisc_class_ops dualpi2_class_ops = {
+	.leaf		= dualpi2_leaf,
+	.find		= dualpi2_find,
+	.tcf_block	= dualpi2_tcf_block,
+	.bind_tcf	= dualpi2_bind,
+	.unbind_tcf	= dualpi2_unbind,
+	.walk		= dualpi2_walk,
+};
+
+static struct Qdisc_ops dualpi2_qdisc_ops __read_mostly = {
+	.id		= "dualpi2",
+	.cl_ops		= &dualpi2_class_ops,
+	.priv_size	= sizeof(struct dualpi2_sched_data),
+	.enqueue	= dualpi2_qdisc_enqueue,
+	.dequeue	= dualpi2_qdisc_dequeue,
+	.peek		= qdisc_peek_dequeued,
+	.init		= dualpi2_init,
+	.destroy	= dualpi2_destroy,
+	.reset		= dualpi2_reset,
+	.change		= dualpi2_change,
+	.dump		= dualpi2_dump,
+	.dump_stats	= dualpi2_dump_stats,
+	.owner		= THIS_MODULE,
+};
+
+static int __init dualpi2_module_init(void)
+{
+	return register_qdisc(&dualpi2_qdisc_ops);
+}
+
+static void __exit dualpi2_module_exit(void)
+{
+	unregister_qdisc(&dualpi2_qdisc_ops);
+}
+
+module_init(dualpi2_module_init);
+module_exit(dualpi2_module_exit);
+
+MODULE_DESCRIPTION("Dual Queue with Proportional Integral controller Improved with a Square (dualpi2) scheduler");
+MODULE_AUTHOR("Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>");
+MODULE_AUTHOR("Olga Albisser <olga@albisser.org>");
+MODULE_AUTHOR("Henrik Steen <henrist@henrist.net>");
+MODULE_AUTHOR("Olivier Tilmans <olivier.tilmans@nokia.com>");
+MODULE_AUTHOR("Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>");
+
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1.0");
-- 
2.34.1


