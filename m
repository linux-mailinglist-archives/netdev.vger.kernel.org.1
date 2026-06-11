Return-Path: <netdev+bounces-298199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MKIWIVLgKmqFygMAu9opvQ
	(envelope-from <netdev+bounces-298199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:20:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A53673687
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:20:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nokia-bell-labs.com header.s=selector1 header.b=UZj84KkM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298199-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298199-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nokia-bell-labs.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8C4E30B3D98
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FE1408608;
	Thu, 11 Jun 2026 16:15:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010037.outbound.protection.outlook.com [52.101.69.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F643AA4EF;
	Thu, 11 Jun 2026 16:15:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194516; cv=fail; b=PRM+2tu1CmbUvOFVQxaTbxIgySYjwt5YUh7keeVgQ4I6GBKQmBhrHTqygKmlH8qCwcapstUbOsYXYeFOm8usytu3F9+rMmT4ALOnkJ8CVtlX//EF2aDg8RnnOz8pAHLYcWoDF4zyZllqo11R7hzInvE3WWWjuGs5pVXD/u33gHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194516; c=relaxed/simple;
	bh=+VaSjzJYvLW3xeQJ3t6twUl8c2qLhYKGl7OdupPUtAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GnkxdEkHoA4FVUMQnzmPtwEA2rKFtzrBV55eVv3WnnwN5TvNiTkM+9/56vdtJnnlHTOiAjM5A42I9bPUw8rLuDoCsL7ViGZk6Kw8Beew0vNVJUQeiGvPe4GzKxFd/P81WqzsTV7ejCxcxEroGD4oY9DapKVvcD2iDqZzFsUVPN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=UZj84KkM; arc=fail smtp.client-ip=52.101.69.37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUZ6+h9JYGcvjZtdL1d/Q3xKuzChpH/gnYZOIjR2N1kTtr/rLdk6dUxTr6/ydEupSyoOIp7xV9wa/ZmdyvcmOqGOw9hc7dG95Yyctss0GsXjlONKwf3ufeXdU8HMri342xgeko/PUdUzj9oNUqZEiOHhePUKeZk+6nBYa2s9gUmQTzf+d+bv81TcUnZGwPYRvbW004U2rtvEZVCEz7zxkBaPPD84SgyUaYH83/HZUIGemmva2mplxS1LKdf9rl84RfzO6eThx82pV6FHsF7uYR8EgsUkE8GZPMFQ13n0dW66dotGyU5nMqrncVkLIXdsKPQVZWbV8K6sglo7QEf7sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZoDyoonIsvEPHYPbJdACPnjBcbvLqElyxCdqilJlH4=;
 b=dtqx8l9Z9E4JGRfxj7Z2gFeQ9g6go/66jY+Oicnb6cXvw/R56QgPCJr/EoVW00cX0IDOAdppdVi8OdEyEEz3ZKN4rma2TU74hXNjNXjIxDzZIQWjNl0crkE/MKkXJMQkMy0ncTbaCYTFhJhERZjl6fuW2+Mq9vnGeRke8yuB/UAr6H1qo7aQSJRartYYtYAmws79H/wMRG3psouCHhMKFzQjEkJdrIkNF8K7/UAtr8rF8Uct/PFZ6p4U5aKP+dVuVS8XNSu7/vsr5tzfbhpCTCpwDA1x4wmUHAS1Rn/c2Q3ii+sp/AlN8ek6I0BqpV8xVizk3tf1fd6sd3KXmIPk6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZoDyoonIsvEPHYPbJdACPnjBcbvLqElyxCdqilJlH4=;
 b=UZj84KkMkSBovZ0ilAkbJ43tipUM6jHaSBxsFm6i822OG5r4acpODeqQAhegfhTMkRHocWPTYUljCSDHEscqQJuDPZ9kAOBrdiKyfJh3aDp5IhWfT3zC9fUsGNnvNCHzA0x0DpigItAvzTjaJ/FHxQRc0l3SITk26MKeDMPLEy12vt4cUlnOdTknMDiUIlkU48acYhBzqMBlNvIKHUe1lVPgnD91WrH9taa/UeSob2HLjLYbZVT6DkpeNmxBKpkXutqgAL7ZjZWP1qZOT03X8eP40Q1aSYTOM+/OD1CUUhoJK4dgTWEKwqAck3rE/3tSI0p7upDSEBYLSsgKC5yxxw==
Received: from CW1P302CA0027.GBRP302.PROD.OUTLOOK.COM (2603:10a6:400:297::15)
 by GVXPR07MB9823.eurprd07.prod.outlook.com (2603:10a6:150:118::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 16:15:07 +0000
Received: from AMS0EPF000001AB.eurprd05.prod.outlook.com
 (2603:10a6:400:297:cafe::88) by CW1P302CA0027.outlook.office365.com
 (2603:10a6:400:297::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Thu, 11
 Jun 2026 16:15:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AMS0EPF000001AB.mail.protection.outlook.com (10.167.16.151) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Thu, 11 Jun 2026 16:15:07 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id D6C3A68003E;
	Thu, 11 Jun 2026 19:15:05 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org,
	dsahern@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	kuniyu@google.com,
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
Subject: [PATCH v1 net-next 0/4] TCP Prague preparation series
Date: Thu, 11 Jun 2026 18:15:00 +0200
Message-Id: <20260611161504.228319-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AB:EE_|GVXPR07MB9823:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e2e7b9-db91-4498-6375-08dec7d49a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|23010399003|18002099003|921020|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	XgDb3PjI/LhRR4trn0FFTK7G1gzNRet+7JzXFLJ0b5SdIT2/CnuDHHsKbuJdgTS/GW7mUyq/HN4MHMaMM16BcnCLZRakHU0dfBk6P18KcEnYbBE3HwTHKKFPx7uKseYmLlr2EytnGEhDTrMtWVCVlbYbLb0BoKImPrAa9Gv4PbaKEbq13o/uS8hcfdmISkgonIqDwRld/HuVSM4P00VwiMFF7Uc5hR/7cHppiMmhpr04Jm2lc3XsncGnWdgJAvIsnFeP9iYOLE3B6dKzHG2ooPVwwv78hQXFO9uwbVCeExDj32a7OZyKnwG3HARNNQJgFYhWTtcr59v8DWg7S74KVupKLxb7DQpdAofdspxx0IgoWp6zHPyerrwX39Y16hCwtmNDrYDLYj8ZwEGZUUIxnYtzmtL0AFaTcbLc6+n3YLM0DmU5QgARqaEHz/lmSQO8DGVIVzlb443aa23bf7HTBvtmzG25XouR5RTRFyf0g//GDaKEYjUfA5Stxs38Fa1vLoH0FznL0oDWSjX0SlRE7/vtfPVYZGUCHUWdy5ndhcMZgMLL2oH3BIt/vs6H+ZFnaD4EvUVVM6cRZ7O29rsjmEg7EtbJdU6OCA2xBYk/6VjfFuMvAcdfKYvNZz9sQ9LSwImXpFRdopUXOIBe5KUyHCKQnfL3y7vyBEJB8hbjF3SlqEJpHw/7BG5hecY3ga57VVwtZik/U/ZKknw15MD4G51wKyj7KH38s7RT+dL8jj4D6tw+VOI7YGfbO6Fr5ozdny29LrpwfIfDQe3NFN22Ig==
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(23010399003)(18002099003)(921020)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	M0zOeG6l9gGpRRpoewMVuIuGQeQPq+N4HbDkrjAjijYx1KWLIgySnvHxdSCUuhNuDqWTXRMFE79YstZh7GzDu3Slpmz3vYMFCkU40WqACkuwRI/byInVS9zCdPiC/SVFvJDKPIvJHd8es8il2QLZaK/igy3ID8hJQ0iiSgZYqq7PDT6cjSqaa1iWYZkM5bKLejddx9TrFeqQdjM8nEj1msbfCeh9ZCXB9Z1Bni/E7ArVHsspykr5WLpw27Qerfjd7iItjO6Mb46jRPMUq3ylSM5//wMs5dwpAui06CahrFVXX7rsyJD7jLCzePQM4gz9MXFWst/PGiCj4M/3o6MfRsKeD1MkJ9xaU+7PxPIhLnaH2K9JzM4ZI5yc6mO2L6gRbf0ApGZw8lAcGaLV94niFB9VNVwVMjzZrkDpt7gVOLIsq6YcC2a91jwU+ir29O3Z
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:15:07.1278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e2e7b9-db91-4498-6375-08dec7d49a7f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF000001AB.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9823
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,redhat.com,mojatatu.com,networkplumber.org,davemloft.net,google.com,lunn.ch,gmail.com,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	TAGGED_FROM(0.00)[bounces-298199-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:dsahern@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:kuba@kernel.org,m:stephen@networkplumber.org,m:davem@davemloft.net,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:donald.hunter@gmail.com,m:kuniyu@google.com,m:ij@kernel.org,m:ncardwell@google.com,m:koen.de_schepper@nokia-bell-labs.com,m:g.white@cablelabs.com,m:ingemar.s.johansson@ericsson.com,m:mirja.kuehlewind@ericsson.com,m:cheshire@apple.com,m:rs.ietf@gmx.at,m:Jason_Livingood@comcast.com,m:vidhi_goel@apple.com,m:chia-yu.chang@nokia-bell-labs.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:dkim,nokia-bell-labs.com:email,nokia-bell-labs.com:mid,nokia-bell-labs.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D9A53673687

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the v1 TCP Prague preparation series, and TCP Prague will
be submitted after this series.

This patch includes the following additions:
(1) Add ece_delta to rate_sample;
(2) Add ECT_1_ESTABLISH identifier for use with ECT_1 in negotiation;
(3) Add tso_segs() CC callback function for Prague to set the TSO seg number;
(4) Add mss_cache_set_by_cca function for Prague to set the MSS_cache size.

Best regards,
Chia-Yu

---
Chia-Yu Chang (3):
  tcp: ECT_1_ESTABLISH identifier for CA
  tcp: Add tso_segs() CC callback for TCP Prague
  tcp: Add mss_cache_set_by_cca for CC algorithm to set MSS

Ilpo Järvinen (1):
  tcp: accecn: Add ece_delta to rate_sample

 include/linux/tcp.h   |  3 ++-
 include/net/tcp.h     |  5 +++++
 include/net/tcp_ecn.h |  6 ++++++
 net/ipv4/tcp.c        |  1 +
 net/ipv4/tcp_cong.c   |  4 +++-
 net/ipv4/tcp_input.c  | 41 +++++++++++++++++++----------------------
 net/ipv4/tcp_output.c | 11 +++++++----
 7 files changed, 43 insertions(+), 28 deletions(-)

-- 
2.34.1


