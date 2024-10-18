Return-Path: <netdev+bounces-137158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BCD9A49F7
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 01:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2483A1F2396A
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 23:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D351917DB;
	Fri, 18 Oct 2024 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="lu6ErXgF"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2065.outbound.protection.outlook.com [40.107.103.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530F819049B
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 23:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293629; cv=fail; b=jfQAihplKBs5QAiIpn25230BNl6UnvOhOMJj2tEkx1Mj7LKo7xICo+GU9MXp+Pjtj3lmDLdvnzXXY1qN9hG1R5E0hrIEzQljIb74FRH+ap0uBBIeCNKsgB/ZB0I78Xq0rFVnaWvj84RdaU/QMZlyEsWLd3cV2Jv+I6AcMcVX528=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293629; c=relaxed/simple;
	bh=q0S2pp6HwKVul9rgVo+8DnTQK+h6iXLXfkBeeLCqAe0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=aygcu6e/QQcarUXYfQtHwYYSxT3I+TMtyh2C5us+A7TkTVhhPCIvNHLSkBsGNhHqtJfGYlbwWFjVMpO6tM/s98EhbmfxsoN2fBBpdQeckQZo9Er98mD6yWDhM0x/w6LdZ7Wimuq8sbq2OnXasoS+B2inQsfJAC9PSQZnt2mNWL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=lu6ErXgF; arc=fail smtp.client-ip=40.107.103.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDBA1ti3rXHK8EeiOOX6q8mh+WrPMHdZCMyJ1qz/XISv6/H5yQPVBbLb/BN6Orki4Gvjdgdmm4MLsNEJv6B3SCR1ucP25naGUUaXljBoIsJZVVucMWiXPaDXaxwLKX6hDkmtBUwNBRY0/k9zU/LZx4TNoue+/Chkx2wEA9G6jn0lhzJvazZe9bnb2N72CX6KsMAgh0Ziyccb5hM+ppcZoxW9NJ5zwoGrNEOTfXBDChe+H00bsCFP7p9Uoo6EtNCJTTqF/4XZQkHkGQRU/NfOY/zd8GmhaJRanlGXHUB8uRulZo5JkPFX//plzNm/56pnDGHUp8PkY4tPXJ+MLOdK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8VH/bgnch7y4RrNt6tEOVkjKhfxstAp+VyfSPn5BmM=;
 b=srdZsbYwNnHeGezUNc/WebX3IINN0bGFNNx44Saky+FA8sltetO5iiVWjIDreiLdF4N37sKXLAJ99PQYmDBpXxYKir8MEHbtUutODhJi1xKMbJc40QTeKKFlj/u22XwQD8qDvCr8ff9U7RYi12oa1qbD94kfsxtKyxfM6X28NRGcpxRBVTeXvgMFjYftVcxHV9d+LtthVDLn7SQsVr3W0LpRnYQNjGpF5TpLc8A0enpTdmf8my4yfvt0QEjv0bvr5ZB7EdiKUY8JuamFAC+Ede3ofPG3ITnSnT8Gw87Mrb8W3+BcL3Tmt473GfAaJRirzFHaFhgIGElZjXmNpvV46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8VH/bgnch7y4RrNt6tEOVkjKhfxstAp+VyfSPn5BmM=;
 b=lu6ErXgFicI3Nd8TSESmoqVnMg6X1Qhsma9meJBcxcabt8W2o8ROPgnqOZaa0/WxQRl6lZrS+IMn0ofJrJni7RldcobSraPWZw89AZLg5EUWkbXoZRom6s2QEZACO3qmnGUgkXCoAR7kxKpFBiv5jTuILTx2VZcvQ/+Owzt4ysaWJSKYFYJvNp8H3DBTbKPILgFgoc95jctzRPzoNx5v6KiOfQg+KpJLCMMQ3Us14wmaST4lKpgZI67H7ZzXGnLqxZSNNqofJo8M4k7LT3pRZh0jw4j12cA7qx3bcTmqVNO18qkzbN1dTUBDefBxlHwJeDJSiW8iH5ur9+ILyYvzKA==
Received: from AS9PR06CA0069.eurprd06.prod.outlook.com (2603:10a6:20b:464::18)
 by PAXPR07MB7773.eurprd07.prod.outlook.com (2603:10a6:102:134::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Fri, 18 Oct
 2024 23:20:23 +0000
Received: from AMS1EPF0000004C.eurprd04.prod.outlook.com
 (2603:10a6:20b:464:cafe::bf) by AS9PR06CA0069.outlook.office365.com
 (2603:10a6:20b:464::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24 via Frontend
 Transport; Fri, 18 Oct 2024 23:20:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AMS1EPF0000004C.mail.protection.outlook.com (10.167.16.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 23:20:23 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49INKJJP010239;
	Fri, 18 Oct 2024 23:20:19 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net-next 00/14] AccECN protocol preparation patch series
Date: Sat, 19 Oct 2024 01:20:03 +0200
Message-Id: <20241018232017.46833-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004C:EE_|PAXPR07MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: b3edab4d-6bc5-4f7c-6b07-08dcefcb7126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2pPWFZZSzlVQ2x4TlBMUmVRVFlULzVKNllIWXdRc05KU1lHSTVsSjBJaHVt?=
 =?utf-8?B?ckt2dy9mZ0NnWlRZbC9LajZFaDlraEZTcFAzMEQ5ZTZkWFowTGhha0Q0aVo3?=
 =?utf-8?B?UnBoU2xxNTFxTStUdmhkMW5TbGkzMyt4R3hrakg1SVkvV0dReVJhRHErZ3ZN?=
 =?utf-8?B?VGFuc3JKdXErZ00zbHcyR2pIUFMvazVXbExtcENETkRJaUdWZDNYSlU2OEtK?=
 =?utf-8?B?dEpRaXVEQm9udTdKbE04VDVHY0hhVm1ScDVuVFJ2dlJpNUQwZEdyeElqNmU0?=
 =?utf-8?B?eSt6SXNzK0FpWk54SEdWTnI2K0Y4ZjZnMzkwa2tVRm5Db3lEbFpBVXArRjFP?=
 =?utf-8?B?eUMwQXEvMENWcVFBK1N2ZXIrM3l3LzJ1dWtqUzJ2SkhIT0Y3amJDMFdiYy9C?=
 =?utf-8?B?bDJxWG9zUmw2eit5cWpIRGtoVkxVR1RlWjhKaklybzNlWFJEOEJQRmZTd2tp?=
 =?utf-8?B?WEJLRWZYZ3NrOUJSb1VNM1NrUW5JbmhhT20xckpzVkRiOVJkU004bUdoK3ZZ?=
 =?utf-8?B?MEVndzZBdkluSkYzcXFydFRkaUIyclA0YmFwMmY5SDFKNzUzSFJVZWcvNWhP?=
 =?utf-8?B?K001SjhtaFFvU2lVS0lwcDlrZkJjL0EzcnVqNm1UQkduUG9lSllac3R1cnVO?=
 =?utf-8?B?d0ZuUmR2YWZGVHQ1SkJWT0crK2FJL20wZnVMU2tiV0hZOXBHMzJwVEZxR3NP?=
 =?utf-8?B?R2Q1QnU5THJpWjNyNHNHbmRwaUtHNTJDWSsvenhFTlVVdThPTHpaempqR1h0?=
 =?utf-8?B?SitBbDhvb0VJSmkvdEIxbU96UldKRTJjdnNtanI1emdvblk3SVZVUEc2aXJX?=
 =?utf-8?B?VVpJQ0VuV05CMDAwVURmaUVjMXZEaSswTkwvNG5tZkhCZjg3V1ptWS8wNTlT?=
 =?utf-8?B?R2dBdDVuZHdtNlM2UzY5Ym85Q2JwTTR6RGd3VE5pVERsQWNXR0M1WGovZWZQ?=
 =?utf-8?B?dmxwSElVTitWZVpkMkRRNHJQdFFmSEhMUFN2dnZrS0N0NUhDSFhLUEw5akhF?=
 =?utf-8?B?dDhKekZZMlorTHYyQTNNT0d6WjBGU3Y0Z1lOQzNPZ1lzRWRtbWhBeU0vME1h?=
 =?utf-8?B?QTYzUkRYM3RmUnIvVVZxek9pV3FBVmk1YzB2VGx4aXhMd3I1Ulg1eEFlUXRo?=
 =?utf-8?B?c3p4ck9MblJSZ05SaDBxMWNaUW4rUzk2YnlrYUx6bUdOdm8xMkdBMEp0UGsz?=
 =?utf-8?B?TUJpbEovbnpUVUZsQy8xZDhrU1lKRGE1OWEzY3dRaVQzelZRc1BPc1FRQktS?=
 =?utf-8?B?cDhyeFc5ZUNYb0hvVWpnaUo2Y2hlQkpXeklTQ1Y0aG1EYWR5Q3hsWmpKMHFj?=
 =?utf-8?B?YWJCVzJtTGU5Vk9yMmR0Z1pXc0NGbXBSRlQxVDRlbStaejhIMDdzWllEd29N?=
 =?utf-8?B?SUd6Tkc1bXVKVXlGTTZqRXI3amJPczdCdWhlM3U2NU9qV2I0dUpWbWVzbkRV?=
 =?utf-8?B?WEV1N2tzTXJ2RDVkM3c5VjcrcTBGY0JYSSt1dlJ3SzdwZjl5UzNLeWp1cHFs?=
 =?utf-8?B?UnBJU3NpYnREM0toK09mQ3pOcGNCUTErTXBWUVZOUi8yNnAwcHJMWEd6dXM0?=
 =?utf-8?B?dnpYRW15ZklzQU1ZZzFLQWlwaFM1VjhPSkF1N0VkbUhJMURFNmZIakdBK01M?=
 =?utf-8?B?UFJ6d1VaM0poUW1VY2NWSXVuZGx6UzNIRHF4MFJ5V2FoeUV3Ti9qdTFFTXNz?=
 =?utf-8?B?YXRzRWFhRUQvalQ5UzNJMGJra24vS2xocUQxbVJuVzVYNDloRGJnVGZVNEdj?=
 =?utf-8?B?TnJGRE9uN1JxV0NxaEwrR1BvR2FDLzVDOCtVRVgxbk9qQnA1cFhXbFYxYVZR?=
 =?utf-8?B?eGxiRmVyRlJEYk02UzFKVk9DcEFwcnBxNGdrd0JUZHFBTGtSY21WdzFxVG5Z?=
 =?utf-8?B?SzA0OXpMVXQxVm03NkYrZ1U4R1V4QTYwcEFRWmNWdW5HQTdZMkQvUDNOM0dG?=
 =?utf-8?Q?QA9fEjxOY2s=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 23:20:23.4416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3edab4d-6bc5-4f7c-6b07-08dcefcb7126
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7773

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

This updated patch series is grouped in preparation for the AccECN protocol,
and is part of the full AccECN patch series.

The full patch series can be found in
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

The Accurate ECN draft can be found in
https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28

--
Chia-Yu

Chia-Yu Chang (2):
  tcp: use BIT() macro in include/net/tcp.h
  net: sysctl: introduce sysctl SYSCTL_FIVE

Ilpo Järvinen (12):
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

 include/linux/netdev_features.h |   8 +-
 include/linux/netdevice.h       |   1 +
 include/linux/skbuff.h          |   2 +
 include/linux/sysctl.h          |  17 ++--
 include/net/tcp.h               | 133 +++++++++++++++++++++-----------
 include/uapi/linux/tcp.h        |   9 ++-
 kernel/sysctl.c                 |   2 +-
 net/ethtool/common.c            |   1 +
 net/ipv4/bpf_tcp_ca.c           |   2 +-
 net/ipv4/ip_output.c            |   3 +-
 net/ipv4/tcp.c                  |   2 +-
 net/ipv4/tcp_dctcp.c            |   2 +-
 net/ipv4/tcp_dctcp.h            |   2 +-
 net/ipv4/tcp_input.c            | 117 ++++++++++++++++------------
 net/ipv4/tcp_ipv4.c             |  28 +++++--
 net/ipv4/tcp_minisocks.c        |   6 +-
 net/ipv4/tcp_offload.c          |  10 ++-
 net/ipv4/tcp_output.c           |  23 +++---
 net/ipv6/tcp_ipv6.c             |  26 +++++--
 net/netfilter/nf_log_syslog.c   |   8 +-
 20 files changed, 253 insertions(+), 149 deletions(-)

-- 
2.34.1


