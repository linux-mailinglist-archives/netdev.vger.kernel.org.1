Return-Path: <netdev+bounces-135536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B9A99E3DD
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B9C280E45
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760891C7269;
	Tue, 15 Oct 2024 10:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="QXC3sbmI"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6914683
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988210; cv=fail; b=Gij5dufWf1fZdgaND42pDjFDwxsbM7B6qqJiLLGURo9v0H/esPoUrCqZz2iw/XJXsI1uLtODHuH26g9PTD/0a+BBQICBEyTSjq5WjU6Q7RkUvdLiQyHgUW43PgOQMPAs7sAQeDnGuPYe+KKn6pmVwiQotu8nHq8kRsNbBDmiidI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988210; c=relaxed/simple;
	bh=aqRI2ufGxWxMdy6PCtZw+0GVTJZkdJFYFJBxBfiAiPs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qx+Vw8hi3ZakYjoN92gQU7YTr/DddMrWy5/oE3tkvDAigrzXVnsT0ANtXaC+vt/JpmDwhsM2HFLiRSuKsEe9n2GLBxnWQoZk2uRYC/h6AsepT0Rgm9CL2cXhhrNAs0/fh+7d0hnjZD6dYDrGzyuvzrU9uMWH5/Q6bGrK9Rf2LQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=QXC3sbmI; arc=fail smtp.client-ip=40.107.20.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwnR1MRm5wA4Wx9lkyGANfPOatz/scGqfZ4/wJTEoUjuWI0z6SoWcdJb/A27wO819sKaZWwhLHLkJ/hM6dY6L5j/hKelVamcA53tPFd5NFLMYelk91yvfl7YbVfg0fhNYXzaKUMHDmojACxu+kAFUWUUciaNUZXgSzuH66Rh1yMds1axcrnX/K7M/vLiigC+u5dOHJHs3xeQS+Epu9cMBkf+1B4ySQBNmn9g+uHZ8RpwVrufCnbudVPUuUabXEUvBidw3gUqZGYoPTRDfkL+9BmOGt9E5JdBXhKFCNcZfd2dFW/0GjFqxUEKhbKUcwcX75h42qQJ6keClR3egb8N7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsBdypBk56+RcfmEeCIcYfFEC7Ize0ckJwyLXxxwVLY=;
 b=jH2FYbnAAu3lx30qyG+AeQHcMwgp4ZnL/JwvHTLYk4mK7IuMFCCRDG1ZuwMAwxKy6SjruPuj0vo5kfznd9DD1Tv6u1FivTnlMluh3VdBqaRRbLdy41GFqCHyYv7ZT7veCmfzlF6N17frtdI5255KQgoA6GaxW49FEdZdoAYP6ApMe5MzPUzLHpZoJRhJYWzvUH3v0Ab0LL1+V0OUrSnTzDv3IXbDEx3mYQleIQLLfzX06qPgrGUsZWnVKb9AnHLxUbTwugYLtH5qgGaVo3qivIwkV1tY3h5e7w4IVxphTpsnPalxxqnupNFiUSFmNLl+9TtJBgcTFaqEVRrLbto46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsBdypBk56+RcfmEeCIcYfFEC7Ize0ckJwyLXxxwVLY=;
 b=QXC3sbmICQO952dnefBj4qbSIwanfmREJ17qJIN5IsK1/52Fk+mJin1I0aIVCb+D6mtrcTXqG0KdUrvtvU/11HD41aqtcIqxV9gKxAABPOR+KC5csrcLSRhREWjHLIvNPwUzNO9arhQX7tUBqDQ1evKxgi4euuvsFY5zjLSXLAHIQZLeCdfwU3qkecXKXXqnC6bwUp8fQewXGGckWj68gtaLavjc/F+B+7/PSRa5IFp/M8C0oBVyfX3lER5TFzS3WKreJWlSt4TA1s+Wu2SYW7Cqf/VjJhwLL9BdwedY0Aw+ZlqecSoPJmaj+ckjMxuOed3o0sPYPx/WMjmcfuxPyQ==
Received: from DBBPR09CA0003.eurprd09.prod.outlook.com (2603:10a6:10:c0::15)
 by AS8PR07MB7845.eurprd07.prod.outlook.com (2603:10a6:20b:350::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 10:30:03 +0000
Received: from DU2PEPF00028D08.eurprd03.prod.outlook.com
 (2603:10a6:10:c0:cafe::4c) by DBBPR09CA0003.outlook.office365.com
 (2603:10a6:10:c0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:03 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D08.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:02 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtn4029578;
	Tue, 15 Oct 2024 10:29:56 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 00/44] DualPI2, Accurate ECN, TCP Prague patch series
Date: Tue, 15 Oct 2024 12:28:56 +0200
Message-Id: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D08:EE_|AS8PR07MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e0d65da-cfd3-44e5-e195-08dced045402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzJlcU82OWVrNkZVRnI5Tk1XVW9BOXV3cFg2TTk4UWU5R3Qxemx5dzNOTE5C?=
 =?utf-8?B?cWV5V3N0ZUg0S21hUlV6UElDRFVmTkJSeVFuZnZ0NDJTVm9oQm54VTNmNG9P?=
 =?utf-8?B?dDZVSVRWYys4K2RTWE54MnNEWTUyaHh4RTg3NmFydXk4ME9xYk1EQkF0RExZ?=
 =?utf-8?B?ZE0raVdyNDB6NTRDWVN6dHp0ZUpnbWpRcndEQ1hyNGdQZ3o4TXhMNnJEYmE5?=
 =?utf-8?B?MU03SzF5SzM0OWVDd1ZiczUxTjQ0b3ZKYzJtL2VsY2tDSUFwbDlBVUpLaSsy?=
 =?utf-8?B?c0Vqb0VkekJITGpjb2FFcEhjSkxKeW9yMkZzVWxwNWFpbllrSWVKUzZWVElh?=
 =?utf-8?B?WGNTbjE4bHp3dVpFTERvSW1qQnRJajBBWFFiLzZwUFZ2Tmd2ZmYyanFYcWVx?=
 =?utf-8?B?dXAzM3FSb2lOK25LMW1WMHRrZjdhRFdSMHpKYjYzVkVTOGRVVWczeEJTMWhm?=
 =?utf-8?B?VWRlMW5nbnZ6UlNhNzlhb0ZGUWVscG9ibGgxVW9vb1pjT0VSSWR6cUFmNzMr?=
 =?utf-8?B?TlVPc3Z4elZtVWJSTTVzbXR4MzcwYXNyVlBnaFhvckZLREl1c08xZVR1Ty94?=
 =?utf-8?B?MWNUQjFaR29MWDJnRFE3WWhVT1QycnFjc2lEaitWYlB6a3Z6alhkSFlWbW9I?=
 =?utf-8?B?R05jNjI4UnZxSkZaTUFxeDNMakdaNmVQelUybkZObFdqZGx4RDIxTXJYSHBD?=
 =?utf-8?B?c2VVaFFCK2JES3BSQjUxWjRtVXBuOG05YzEwbFY0bWd6d3dNWThRaW8vbTVE?=
 =?utf-8?B?Y0lkWUNvYU0vR28vcTdlOXBJWnFXOUlpWUNPNlhkRWdqbDkyS2xXUGRLTjVI?=
 =?utf-8?B?MGlnVFJtcERIYUozR0xNVVVWeWMrbERnVmxwQkxGS1ppUytRbVdEV0g2YXZM?=
 =?utf-8?B?ZWhEcmYvcU5MVURzaURicWwwMVdieWVtSk9wTWduT0lMSE5tTUM4N0Q0d1Q2?=
 =?utf-8?B?U0V3RXM2ejJGSFhhT2JrM3AxN0tmM2M2LzJQYXBwbllqaUgzc0VVU2xJd0I4?=
 =?utf-8?B?Nmx4eHErdnVzWTE5d3dDRnZsWVZCbnlMaUN2WjY1d3Axa01LTU16ZWtLL0xT?=
 =?utf-8?B?a0ptYnh3L3M5OXBJYnB1WkcyN29ZM2s5ZGZoRlR3a3VXcC8wTXErZHRVdVEv?=
 =?utf-8?B?VXpHR2tOV29mb3U5WW5sSE5WUWs0U0hWdmxaRTF2Z3NLQ2FncW52aWltbmFB?=
 =?utf-8?B?cytKVFl0RWhQdEU4bzlqVnQ5M0c3d1ozTkVwZFRiaVNldFJGdzcrektncWw2?=
 =?utf-8?B?WnVnUVNiOCtKSDJvZ2JTL016N3JHODJJVHFRY3N6d0pTMFpESUhvRXF3QXRP?=
 =?utf-8?B?NWlFRkYrcmJ5VkdacW94a0tqNEJMbytGY3FWa1lmRFEyYzdZR1J3Y0QyTjVo?=
 =?utf-8?B?NXhKd1pkQ3RheEV4NXU4NjNrK1E5RzZUUU5qN2VzS0s0ZGNPRjlmOUtZWUxD?=
 =?utf-8?B?eWx0L3AyTnJHazdRa1FzTzRGRG5qcC9DaVpFWk9NNkllWm05c3JKTmVpbDZK?=
 =?utf-8?B?Ri9tZHpiTTlCdXVJa2x5QTdBNXlIL1k5a0VoOXBZanArRWpCZk9vZWZBcGJZ?=
 =?utf-8?B?R2w0VVZJbzFuSzFPY2kwbUx4YmJhZG5aOU9OUGJJdE9nM1hwQ3JrVVV6TGx1?=
 =?utf-8?B?T0k2Z3NORjBWbGJLcmxBNklDZVdGZDZ6UFpDUW1XREpCWXBsYTVPRGNYSUFm?=
 =?utf-8?B?eTBleVppK2EyMTVHczdaOG5za1YvN3NvLzVRZWlTSzhkNG5lb1ZzK3BaV080?=
 =?utf-8?B?WHVpc3RvNE54M1gyemVtUUdoL1hRRmxBT2ZSTHdxUlVRL213b1ZRK1hnVVA0?=
 =?utf-8?B?OUtSYkRGS2d5ajd5a1JSZm5xMjByVk9MVnhGVU5INU1FZVJJR1hEWWJsWkht?=
 =?utf-8?B?b0IrU2NXSXVseXo2cUZFWjJORkRhNzdrR0pGeGpDajJnUXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:02.3019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0d65da-cfd3-44e5-e195-08dced045402
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D08.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7845

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the enclosed patch series covering the L4S (Low Latency,
Low Loss, and Scalable Throughput) as outlined in IETF RFC9330:
https://datatracker.ietf.org/doc/html/rfc9330

* 1 patch for DualPI2 (cf. IETF RFC9332
  https://datatracker.ietf.org/doc/html/rfc9332)
* 40 pataches for Accurate ECN (It implements the AccECN protocol
  in terms of negotiation, feedback, and compliance requirements:
  https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28)
* 3 patches for TCP Prague (It implements the performance and safety
  requirements listed in Appendix A of IETF RFC9331:
  https://datatracker.ietf.org/doc/html/rfc9331)

Best regagrds,
Chia-Yu

Chia-Yu Chang (17):
  tcp: use BIT() macro in include/net/tcp.h
  net: sysctl: introduce sysctl SYSCTL_FIVE
  tcp: accecn: AccECN option failure handling
  tcp: L4S ECT(1) identifier for CC modules
  tcp: disable RFC3168 fallback identifier for CC modules
  tcp: accecn: handle unexpected AccECN negotiation feedback
  tcp: accecn: retransmit downgraded SYN in AccECN negotiation
  tcp: move increment of num_retrans
  tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN
    SYN/ACK
  tcp: accecn: unset ECT if receive or send ACE=0 in AccECN negotiaion
  tcp: accecn: fallback outgoing half link to non-AccECN
  tcp: accecn: verify ACE counter in 1st ACK after AccECN negotiation
  tcp: accecn: stop sending AccECN option when loss ACK with AccECN
    option
  Documentation: networking: Update ECN related sysctls
  tcp: Add tso_segs() CC callback for TCP Prague
  tcp: Add mss_cache_set_by_ca for CC algorithm to set MSS
  tcp: Add the TCP Prague congestion control module

Ilpo Järvinen (26):
  tcp: reorganize tcp_in_ack_event() and tcp_count_delivered()
  tcp: create FLAG_TS_PROGRESS
  tcp: extend TCP flags to allow AE bit/ACE field
  tcp: reorganize SYN ECN code
  tcp: rework {__,}tcp_ecn_check_ce() -> tcp_data_ecn_check()
  tcp: helpers for ECN mode handling
  gso: AccECN support
  gro: prevent ACE field corruption & better AccECN handling
  tcp: AccECN support to tcp_add_backlog
  tcp: allow ECN bits in TOS/traffic class
  tcp: Pass flags to __tcp_send_ack
  tcp: fast path functions later
  tcp: AccECN core
  tcp: accecn: AccECN negotiation
  tcp: accecn: add AccECN rx byte counters
  tcp: allow embedding leftover into option padding
  tcp: accecn: AccECN needs to know delivered bytes
  tcp: sack option handling improvements
  tcp: accecn: AccECN option
  tcp: accecn: AccECN option send control
  tcp: accecn: AccECN option ceb/cep heuristic
  tcp: accecn: AccECN ACE field multi-wrap heuristic
  tcp: accecn: try to fit AccECN option with SACK
  tcp: try to avoid safer when ACKs are thinned
  gro: flushing when CWR is set negatively affects AccECN
  tcp: accecn: Add ece_delta to rate_sample

Koen De Schepper (1):
  sched: Add dualpi2 qdisc

 Documentation/networking/ip-sysctl.rst |   55 +-
 include/linux/netdev_features.h        |    5 +-
 include/linux/netdevice.h              |    2 +
 include/linux/skbuff.h                 |    2 +
 include/linux/sysctl.h                 |   17 +-
 include/linux/tcp.h                    |   31 +-
 include/net/inet_ecn.h                 |   20 +-
 include/net/netns/ipv4.h               |    2 +
 include/net/tcp.h                      |  299 +++++--
 include/uapi/linux/inet_diag.h         |   13 +
 include/uapi/linux/pkt_sched.h         |   34 +
 include/uapi/linux/tcp.h               |   16 +-
 kernel/sysctl.c                        |    2 +-
 net/ethtool/common.c                   |    1 +
 net/ipv4/Kconfig                       |   37 +
 net/ipv4/Makefile                      |    1 +
 net/ipv4/bpf_tcp_ca.c                  |    2 +-
 net/ipv4/inet_connection_sock.c        |    8 +-
 net/ipv4/ip_output.c                   |    3 +-
 net/ipv4/syncookies.c                  |    3 +
 net/ipv4/sysctl_net_ipv4.c             |   18 +
 net/ipv4/tcp.c                         |   26 +-
 net/ipv4/tcp_cong.c                    |    9 +-
 net/ipv4/tcp_dctcp.c                   |    2 +-
 net/ipv4/tcp_dctcp.h                   |    2 +-
 net/ipv4/tcp_input.c                   |  689 ++++++++++++++--
 net/ipv4/tcp_ipv4.c                    |   33 +-
 net/ipv4/tcp_minisocks.c               |  117 ++-
 net/ipv4/tcp_offload.c                 |   13 +-
 net/ipv4/tcp_output.c                  |  336 +++++++-
 net/ipv4/tcp_prague.c                  |  866 ++++++++++++++++++++
 net/ipv6/syncookies.c                  |    1 +
 net/ipv6/tcp_ipv6.c                    |   27 +-
 net/netfilter/nf_log_syslog.c          |    8 +-
 net/sched/Kconfig                      |   20 +
 net/sched/Makefile                     |    1 +
 net/sched/sch_dualpi2.c                | 1046 ++++++++++++++++++++++++
 37 files changed, 3519 insertions(+), 248 deletions(-)
 create mode 100644 net/ipv4/tcp_prague.c
 create mode 100644 net/sched/sch_dualpi2.c

-- 
2.34.1


