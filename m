Return-Path: <netdev+bounces-136812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 399A39A329C
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D6C1C23868
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBAD1465B8;
	Fri, 18 Oct 2024 02:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="qnOKKMIw"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFB482488
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 02:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218073; cv=fail; b=HGgJYpuJRj16QaiQRTp3QTf1ZCGG7DiaKBpCr2TAKlom9/XVQyJvQkpG5oRtSfsrVMXMsjhPfprC8oSGI7y3md9j/fCIN3gB4d7ohLb2VFRQ+XRYNG3D0QLuXJ2fcmpwM7OQR2HXxKnyJWC8VXRbuX0qbw2DJbj0+UV+aSgdipY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218073; c=relaxed/simple;
	bh=YGKMkNZ3aAm9eukBslO3OmQNlZGHPjcxaZGy2Bgdj2k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=I8EbbTwPsGFmaUxMSnIxQrgSO5ixlPDvjjjgIQ/A3vQKQo61hCBZLoP2h4NWJ2qsCvn3V/lFZAiI1wCHaClMvsMwy+aFwXUxp3qGGP4C9qNg07Tag+7bvdpVUsOlwHNPdsk7+muTTM6yagesJWdXTIB4tHimcf41Y1yhwGayqvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=qnOKKMIw; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7RU5xXvAKId2jlgplgr8ETXEyMT2mAtmNDt1GlbSuempcYHUDFe2DhV61rw+P/i4W6KcjEqj2rQMYg7dZwJHrHTFk+qtuOGxN2jOKQcQPjZAofAJHmCUcAIi2b+ul+k8KLseva7U3WQv2YQ+weL0OAoDckPehN3BJxs9GumV2NMFzlJUDQ5EU7cISmWUnln8Ze5D+ptujsP92AdolN6Ewonc6oSgst0kvPT/w3MkdJ7GGnUgIFSRMaX1Dy8yBp875YfnwYeIjgYEFFR4hgXUOZtiU+82d8OgqV4/tOBMeIIgRI3b2P+HUGgy47DvwoTY/rm8HbFNo6J1SBSd00zUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1GniyA0oNZaWZ3hYJBf1UMy85pPBhxwnim1KCZWz6E=;
 b=gzzR/F1mhJDkvM4zTiyv8L0ASGZ2thhfK80beepY7HJ/gf7bJY1sgpTWDGNoe0n+9L46iHNJfUsrmkfOV0Wc5VTzK5505EA4t0EzjoUblj8+2C++ucnXk2ZM6ByeH8KZvsUV2aiEtszq65PUlK4oX7QFJU8ul4MgY2+6w9LND1dx4+CLUuA4vnj3NIzUv6J0Xp1q6C4E9eOFKGOYmYQWJ2Fkda3Gx8MYQNAWjt0zIjsqjkQMH4VLZX1PU0N/mDKzlriElzVqGOTfdpKVpSA2+SWnO0WwCjMRZOk2dQ4LnU8TfIPgBYhuBqS2LnjFCr6WSFyoOyGe0J8C0S/bqY5ONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1GniyA0oNZaWZ3hYJBf1UMy85pPBhxwnim1KCZWz6E=;
 b=qnOKKMIwkl9Ukym8Ndvb1jDcq79t8HwZf2d7cY83aWbl4B0xZhGbtC2MIeRvl2peVT3UPgQ8jQf0VzXv1fppBu/R2Xbi/P0MHOeaWnp27OjmgFwBvUdbL2M5kOW36owDRHaJzApWpmEyZCM45BzXIk0EIlRm1j0EElcDOmlCUzc/PB2GDHpM4nXBnUqzNe8Kc68OU0S2Ww0k1qDEeJ7zkp0iadrfusuH0gbF9Q2WnEEw6NWpNCRAS0az4Y6/68CQXdSl9CglcgYx25Xis0o9388yzWH6ykS5FUycY4mmHl5nJQi/1MPKjGovPp0T0jlAwyavAw4y0rAIVYkATfNMAg==
Received: from AS9PR07CA0060.eurprd07.prod.outlook.com (2603:10a6:20b:46b::31)
 by AS2PR07MB9053.eurprd07.prod.outlook.com (2603:10a6:20b:544::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Fri, 18 Oct
 2024 02:21:07 +0000
Received: from AM1PEPF000252DB.eurprd07.prod.outlook.com
 (2603:10a6:20b:46b:cafe::cf) by AS9PR07CA0060.outlook.office365.com
 (2603:10a6:20b:46b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.10 via Frontend
 Transport; Fri, 18 Oct 2024 02:21:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM1PEPF000252DB.mail.protection.outlook.com (10.167.16.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 02:21:07 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49I2L0MU023685;
	Fri, 18 Oct 2024 02:21:01 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v2 net-next 00/14] AccECN protocol preparation patch series
Date: Fri, 18 Oct 2024 04:20:37 +0200
Message-Id: <20241018022051.39966-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DB:EE_|AS2PR07MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: 304b8e29-404a-4abc-9a00-08dcef1b8664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTlEL2tINnFJemI2Zyt5QVl5V09tQldUZnpBZGNQWXcyVWFTV24zeXJNYitV?=
 =?utf-8?B?M2QwUzFnayt5VHlwVS9ldTJDMXI4djNUMlZ2SmZZb3hkQlhVTzRLVW1XVld1?=
 =?utf-8?B?ZHorSStaZTk0cXdZdFZUNHpqZCt0RFVkeUkwK1doQ3FWaml1amYyZVV3UnR3?=
 =?utf-8?B?Y0dPSlZMNWxUdmZuMDJPT09PNkVnNWZGZmw2R0lCb3ZEOUR2M3Jsc3QwcENC?=
 =?utf-8?B?UkhVeFI1eW9YWktyOGYyRjZoNnFHVVhaVGZraFU1ZStGSmhacTZ0bWNTdHA3?=
 =?utf-8?B?WE9ieUR4dDZ5VW1pTXhnLzdjZ3pqRS9ydlBRdE5pZk1kR3RQUGNnUlN0RG1z?=
 =?utf-8?B?Rmw2VUppcmZHVUE2ZHdGNWJuemNyK2lYTFhqSnQ1NkhxS28xS1Vpc1kzV3Jp?=
 =?utf-8?B?dG13ZFdRTGlic3JOc1pBbGhzUTM4WXY0ODhucWZhMklCV2gvS3NIc3A2dXdi?=
 =?utf-8?B?QzRtdDVIZ0hsclFNdkFSRmh6dHlsL3cwTW1WcVBDVVBWWmM2ODlQK0xKSW5t?=
 =?utf-8?B?VnZrWjZ1VlJUUFc1a0dCcGJuc1pyZUs1Zk4rcUJQWWtGOFlidEg4SE5MYmdK?=
 =?utf-8?B?SkFic3dhNmRvYnZ4WWpFSDErTDhqZE1laHFTRDNxR1MrMDRIQ01vaStTMXRB?=
 =?utf-8?B?R3AxTFJIcExVdURHR1VMUUw5U1MvV1AzZ1R3TWFuNnVHSVFlbXI0Q1NCYUlZ?=
 =?utf-8?B?U3RXb1BBdEJacm9Sd09MSVFoYi9qMTJzQ2NHVmVNYmNaY3pxZzRzRytGNXNQ?=
 =?utf-8?B?cmtnbW9sck9WTE9iRk1QbHNKcmpaWlV6Mlg4K2J1K2lBdUN4NTZkOXQveXB4?=
 =?utf-8?B?YlZteGdBN1pXMmltbllpWlpmS1o4UnNRdjhwdktvMFdEMnJ5K0NaSjFydXZV?=
 =?utf-8?B?U053azVsTHRJSnZjS1FSb1EvYzZMK0g1c3BnWDVjMmg2elNIUUgrcm5TOUVJ?=
 =?utf-8?B?V3loanFGUVJPTUFOTFpkUDRHcCtFdGtZVFB0NHpneTFOdE9hOTlwcFZ6VkN0?=
 =?utf-8?B?dkk0TVU2ZmJuMXN0QWUyZ3BCS3kyWE9ncDdwWS94VU9uN3JuZjN5aloyc2ZG?=
 =?utf-8?B?N0ltSjJCOWlQTDNEY0lhcXNnTHBWOXpSTmNuU0RnbXdrN29mRDl3VkhnanNj?=
 =?utf-8?B?QWF2bUppbWd0dDNSUWJVY2orWFVSSXNFVms4K2pJYXVjYzgvMHR6aGFOTllh?=
 =?utf-8?B?UnUwSUluLzVndVNmeXNTajNSUmdlTUgzN3EvNXF1dzFEOS9ub2I2WERSdVY2?=
 =?utf-8?B?U1hISlNIZDM0SVVleXQvTEpXeWRGMkFydHpHUUw0amxKcTVWcWJwMXlTQy9S?=
 =?utf-8?B?Uk1QelplYUhjODBaNVd5U2xaSHNwT3dTR3V4N3B2cFBKRThUanlpM2dxN2w5?=
 =?utf-8?B?VURGbitBOEJtNGVvcC9wbHptbkNUbnVYTDNYbkFSeG5BYldRTTBYN2t5Yjg4?=
 =?utf-8?B?QytLQ3lpbEhlRU03dEgwWTE4VHl2RkRHS3FGZ0R4d2d2eDF4eWxtM0hlMlhu?=
 =?utf-8?B?L0VHZllXR1NYKzg3UXNYTFNkVnRGWWpCM2QwSnVnSFZQazNzMGhmaDZpMDRa?=
 =?utf-8?B?Ui9IcUZEUGEzdlQ1bUtTMXZQQWNybzc2MlIvbytkbE1lQ2dqeFRaMXVWazlx?=
 =?utf-8?B?blpHSTh5dzhWSDBWSks2Q09HMDZCL25VSU9WMnZVYW5nQTMxcER2THVuaFMr?=
 =?utf-8?B?RjFIV2dMWjZQKytqd0ZwZUt5MXAwNEYrSk8ranBOcUNNY25UbnczWUgzNThH?=
 =?utf-8?B?Vm4rUjZodDFxbVV0b3hrbEd1UXB5WXZSNlBTUFdJSEVXRncyMFlqT1VIRkRh?=
 =?utf-8?B?T0p5MW9keHo1M0dxR2JlL0Q0NzdneG10U1ZLTGlJdTcrZlpnaDdDbEZPVExp?=
 =?utf-8?B?L3MwbURHcThUNDNtcnQ3cWM3RWRTbnRqVUtMK3RSb2ZsQWhoVGtZZEZubFpR?=
 =?utf-8?Q?BzZwkOZqW94=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 02:21:07.6569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 304b8e29-404a-4abc-9a00-08dcef1b8664
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DB.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9053

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

This patch series is grouped in preparation for the AccECN protocol, and is
part of the full AccECN patch series.

The full patch series can be found in
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

The Accurate ECN draft can be found in
https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28

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

 include/linux/netdev_features.h |   5 +-
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
 20 files changed, 252 insertions(+), 147 deletions(-)

-- 
2.34.1


