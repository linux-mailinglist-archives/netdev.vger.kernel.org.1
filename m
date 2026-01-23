Return-Path: <netdev+bounces-252767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uExoGjZKc2mHuQAAu9opvQ
	(envelope-from <netdev+bounces-252767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:15:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE81E74229
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78069317C339
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C1F37F11B;
	Fri, 23 Jan 2026 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="b55CWx2M"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010008.outbound.protection.outlook.com [52.101.69.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F7C35C1BF;
	Fri, 23 Jan 2026 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162884; cv=fail; b=my9xtGhzvtPOaotphr/ThmWc2hhRA5tdSEOyx2KQdy32AfTE252Xn300U03F08jSFt9REhNVeteIpRTszZJW3r7fxzkFU9HsSPHHfppZZ42S24TSIDsOsudC0pDcnGhUEXq6UeRQOviIRrcm9GKWyefLp0tlHnpw8evAYi3qL0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162884; c=relaxed/simple;
	bh=35X1rl2AWPd3hHQGeIEdIEvd4S0cSyOj8uJMppKMXJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZotHjEHPZLxdyVNhPzCHDXdzJ5Hz5OtC8EWAbYUKaIbZfLTFaquJgB8LadHyPmEF9INnhdYCrE0jcvKZ5mnypBwiwpblFcwcmE5DNIqVUAySgoWXdHt+fyeOuQgiK9KvY19m51+XnOwf4QXpeOM+0/9TV9zZAku1hsgN0o07I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=b55CWx2M; arc=fail smtp.client-ip=52.101.69.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjSuhm592amy6Whp7SzM2KRcqWXXMF35wSN8QKxcJkLkhXT/4V1xJ4yiF5ZHFThyVbbvYvL19AE8zylM5xweQESNRsXmPhPtxFsGJd9ji7+iguhnPd5Zrs5f7be0i43zbMSUlQjHUcsC0svzLhgMdnTt1y3y11zVjj2QjKugZ7NHNPAoTs5oLeq+H6K0QDIMwow5WgxG0ftC/HaSCdU6zpCO8+Pf6MgHsaIXID/uGNZwmzfJd49YbrEFn7/Z/jwSdhmR+bPxWdjiznf05GdkCg6dnnpQS3f8drIq+ga40W6W5WiygQ+XOoHt3mddxkD05Z0c5BxKRVBju95v6fDmlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMaRADJA+ge4tkOgEoNpm6f1BsgWRtH61gaHuOYfqw4=;
 b=wmH7UEs0Nh5SXEQh1/2V8HShQks3ZnvlR14gl+KShtyzdBfwWjTdVcHKcdUW3HGZEKY9mGvzKyq1KXGVdoQqX9nlZ4Dv0UVDk4gSKZHb9FzQjs/Da3JOWdUsOAvYKU6CFmyh/X1A0JJHVPWdNa05j47XuTzaV/PTbTS2/z8dxi60PO1JU+Qs7jDiKy1AVZXKBUXy2guwEIcYzZrLwJMueZD6YB29yF4x7BSFVCpVJC4yrSk3oaB5/Gm7YzxtuRW91XRGqzcZiillgUyU9ACodL3Uzv//YuA3h8wQg9nQMrnnY2GFRUUo83WYi3M/y2Z5DjURwGQ32molfrE923r2Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMaRADJA+ge4tkOgEoNpm6f1BsgWRtH61gaHuOYfqw4=;
 b=b55CWx2M7xoQPp8EOG8N/6U8x6fIQ264KA8iuF6IRcLDc+OhA7Lxx52k8ebl6/diKcy5VC+RyWSdJXbuZUCtHpvtuBnnNyPvlV0xq/ZQCIbjFKIcFGVTIBqPCEQSJkTx44i+bGDePSTqjn+U3SUjLA4KprWwwEfJgodtM3e2r53ajt/GfmXCOWKMI1ePSk3NWjwpIS+byP3d3IXcAvsBk0HMxQlATVOPIl+H+51fZ79iP/DkiEF9LapI5AfyrNsoDQW43aa7DS5AWqM3MDwYSYZAmkjpO3Gw1XnMURYkFD5yi2mGEynEK7jO/mULq4YIGnhnADj2KAjDu4AoZzwcjw==
Received: from DUZPR01CA0268.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::16) by VI1PR07MB9457.eurprd07.prod.outlook.com
 (2603:10a6:800:1c9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:07:44 +0000
Received: from DU2PEPF00028D05.eurprd03.prod.outlook.com
 (2603:10a6:10:4b9:cafe::a1) by DUZPR01CA0268.outlook.office365.com
 (2603:10a6:10:4b9::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 10:08:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D05.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Fri, 23 Jan 2026 10:07:43 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 011ED1C003E;
	Fri, 23 Jan 2026 12:07:41 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
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
Subject: [PATCH v11 net-next 10/15] tcp: accecn: unset ECT if receive or send ACE=0 in AccECN negotiaion
Date: Fri, 23 Jan 2026 11:07:16 +0100
Message-Id: <20260123100721.42451-11-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123100721.42451-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260123100721.42451-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D05:EE_|VI1PR07MB9457:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e926b682-35ef-4ae9-b06f-08de5a674024
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?7yUzGgYsf+kJWZo0mfE5DgPvHNI7HoBURrEkKW1kF4iHtInlIX17jF/lJy9x?=
 =?us-ascii?Q?XTun259/CNNapV3o3byHOlEh2K38OiY73kBXk7K/mIE+IyrOkUc5S6HDi3ZN?=
 =?us-ascii?Q?fdhncbBnlSb4MVS72zV/AAJ8lfTe7ZNh5wK0KkrEJPd+G8NqiyrJNGpLskMh?=
 =?us-ascii?Q?A9F57a9/6zEVybvZvrL7UDcS4Rh7O1OzJ+kmEP2WfMYXwMujQJ/kh2UrFC5R?=
 =?us-ascii?Q?971zGp2Z/oAqJ8GHnjoH8tKq32Nqwc0hVKTqXDN5Z8wEsRFq6l/FdXjgdzy6?=
 =?us-ascii?Q?Vilia0EzlSmj35lQ7g5ER7etXqMiCBYq4PKH80VVcf+wFji5JQjXjkNFXDJs?=
 =?us-ascii?Q?nk2M8duXRgM9hlEh4FW9vTLD6rZCafjcrHMVRvbtU//XmNhqllL/Lr5VYPeY?=
 =?us-ascii?Q?QLf5ZFmbQRZkhO4HtYDFpVTVwQRGa1nnjIqJy1If4+h/2S18wAvnWXE+RUNK?=
 =?us-ascii?Q?piEYDzekt9t605lReRzz98E1W0fpCE9+fUm6jNl6oRJG6c8BNl40vweosKrB?=
 =?us-ascii?Q?Vh8ykTc9gkjLjR6Ilr4oY4SknJrUQo5/DdtQPzxDrG9vQWorPL3tVJofkc22?=
 =?us-ascii?Q?pp1Y8FuaY0J49jKpXSMZvs/AcBfg0M4jc1Az84L5QDSzdiRazdFvNwSv1M3K?=
 =?us-ascii?Q?69uVrT583twRFB0lbsBdtd4PGToaiKpu/DQOLqdplL53EWgJtSwSL17TFCQZ?=
 =?us-ascii?Q?cp0YSqJBtsduZ7qUArhGX97Iothk+GrsPUEEYhpBgjLQcl3ggECMIJUVxjfE?=
 =?us-ascii?Q?K4EqdQVFW9/yxHppJmn0U27KDu39zB+rPrQwwtwr/hTERj/OBFKPx/BXAI/M?=
 =?us-ascii?Q?H/NtbQgPKXDID8ycyKgtwce/0tUGcz+Tvfc/4xUfe2FoEI2kffclYf/YBhaW?=
 =?us-ascii?Q?fG42GCI2v6wzXJVDDHUXoUOkLj7SwmF7d9UK62BtuR7GJ5SZPJShnMgipPgg?=
 =?us-ascii?Q?+9fV47YAm1ONVOsnkPZHdT1n3zDCRlZunRUDJ4XdnA5xFWZHwfOUJRryV0UA?=
 =?us-ascii?Q?EKHH44HlsLYk2aJ1BG/o36EMBZoYeRiRcWA60fLmc3TFCYuIOkIFVk+DF0PN?=
 =?us-ascii?Q?uYQe28JZwaREuFl5/Eint3xq7JlepyuZ6lfipTMhi87gq69F7qIsC2TGJ5lL?=
 =?us-ascii?Q?6psY7Hx/W2h9OOx9xneDptPNbYWYaP7jaXuATRQGAlwz+5MVVuzsnXJrIsHe?=
 =?us-ascii?Q?L493RSGqL3BOjziX8+TxpQjAKTUzEmV9H9jBgvnrBQ7GegoAFRvP8KzbePhy?=
 =?us-ascii?Q?jhE43sDqpL6mRPof6G6cem9qmJrxnFAsd4X+Psuan6WFulGGM5jQtjsDwL8D?=
 =?us-ascii?Q?r8iaFhJmmO9nvU8Bvy1H/M7Q7WVAyeSH8iHV5eLi7edScGwIGgt28HwI506R?=
 =?us-ascii?Q?gNHNI5UFR4IblWzlTX8uJTl1NIyK20vQivheiGbRUCD86D8C+BsnX/K3GQ1K?=
 =?us-ascii?Q?2utBXc1baXoirH71PvK5XC9jxRj8x8N/0mImow5Fx4LI8h7QCQjboI07/6CW?=
 =?us-ascii?Q?8SlkU1FUuWR5Dj5cTo7tXDKdpLeFBL+DleZ5235mBAD6opl/57WB15xOq2fG?=
 =?us-ascii?Q?d+moM6F6biLaltLX6GWirp3buxofXjmGlJnlVkufXivPZ7odfeJPnYDO2g2J?=
 =?us-ascii?Q?/w7NsB9RiJEa9ylYHHWVztsC5BD5J99l+1VI3rJ0QvhBQLKlydRwF1bJ5Par?=
 =?us-ascii?Q?POEi3IQfeqIv6EsjSNZaptSs878=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:07:43.6659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e926b682-35ef-4ae9-b06f-08de5a674024
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9457
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252767-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,ietf.org:url];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BE81E74229
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Based on specification:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

Based on Section 3.1.5 of AccECN spec (RFC9768), a TCP Server in
AccECN mode MUST NOT set ECT on any packet for the rest of the connection,
if it has received or sent at least one valid SYN or Acceptable SYN/ACK
with (AE,CWR,ECE) = (0,0,0) during the handshake.

In addition, a host in AccECN mode that is feeding back the IP-ECN
field on a SYN or SYN/ACK MUST feed back the IP-ECN field on the
latest valid SYN or acceptable SYN/ACK to arrive.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v10:
- Set AccECN error flag on request itself via tcp_rsk() to avoid
  changing directly on the listener

v8:
- Add new helper function tcp_accecn_ace_fail_send_set_retrans()

v6:
- Do not cast const struct request_sock into struct request_sock
- Set tcp_accecn_fail_mode after calling tcp_rtx_synack().
---
 include/net/tcp_ecn.h           |  7 ++++++
 net/ipv4/inet_connection_sock.c |  3 +++
 net/ipv4/tcp_input.c            |  2 ++
 net/ipv4/tcp_minisocks.c        | 38 ++++++++++++++++++++++++---------
 net/ipv4/tcp_output.c           |  3 ++-
 net/ipv4/tcp_timer.c            |  2 ++
 6 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 796c613b5ef3..f5e1f6b1bec3 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -97,6 +97,13 @@ static inline void tcp_accecn_fail_mode_set(struct tcp_sock *tp, u8 mode)
 	tp->accecn_fail_mode |= mode;
 }
 
+static inline void tcp_accecn_ace_fail_send_set_retrans(struct request_sock *req,
+							struct tcp_sock *tp)
+{
+	if (req->num_retrans > 1 && tcp_rsk(req)->accecn_ok)
+		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_SEND);
+}
+
 #define TCP_ACCECN_OPT_NOT_SEEN		0x0
 #define TCP_ACCECN_OPT_EMPTY_SEEN	0x1
 #define TCP_ACCECN_OPT_COUNTER_SEEN	0x2
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 13372d2cbed5..018e8ffc0717 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -20,6 +20,7 @@
 #include <net/tcp_states.h>
 #include <net/xfrm.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <net/sock_reuseport.h>
 #include <net/addrconf.h>
 
@@ -1103,6 +1104,8 @@ static void reqsk_timer_handler(struct timer_list *t)
 	    (!resend ||
 	     !tcp_rtx_synack(sk_listener, req) ||
 	     inet_rsk(req)->acked)) {
+		if (req->num_retrans > 1 && tcp_rsk(req)->accecn_ok)
+			tcp_rsk(req)->accecn_fail_mode |= TCP_ACCECN_ACE_FAIL_SEND;
 		if (req->num_timeout++ == 0)
 			atomic_dec(&queue->young);
 		mod_timer(&req->rsk_timer, jiffies + tcp_reqsk_timeout(req));
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index aef6f2bbcd0c..a4d086ccb18a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6394,6 +6394,8 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	if (th->syn) {
 		if (tcp_ecn_mode_accecn(tp)) {
 			accecn_reflector = true;
+			tp->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
+					  INET_ECN_MASK;
 			if (tp->rx_opt.accecn &&
 			    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
 				u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 9776c921d1bb..1c66c3a67836 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -481,6 +481,8 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
 		tp->saw_accecn_opt = treq->saw_accecn_opt;
+		if (treq->accecn_fail_mode & TCP_ACCECN_ACE_FAIL_SEND)
+			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_SEND);
 		tp->prev_ecnfield = treq->syn_ect_rcv;
 		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters_payload(sk, skb);
@@ -749,16 +751,32 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		 */
 		if (!tcp_oow_rate_limited(sock_net(sk), skb,
 					  LINUX_MIB_TCPACKSKIPPEDSYNRECV,
-					  &tcp_rsk(req)->last_oow_ack_time) &&
-
-		    !tcp_rtx_synack(sk, req)) {
-			unsigned long expires = jiffies;
-
-			expires += tcp_reqsk_timeout(req);
-			if (!fastopen)
-				mod_timer_pending(&req->rsk_timer, expires);
-			else
-				req->rsk_timer.expires = expires;
+					  &tcp_rsk(req)->last_oow_ack_time)) {
+			if (tcp_rsk(req)->accecn_ok) {
+				u8 ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
+					     INET_ECN_MASK;
+
+				tcp_rsk(req)->syn_ect_rcv = ect_rcv;
+				if (tcp_accecn_ace(tcp_hdr(skb)) == 0x0) {
+					u8 fail_mode = TCP_ACCECN_ACE_FAIL_RECV;
+
+					tcp_accecn_fail_mode_set(tcp_sk(sk),
+								 fail_mode);
+				}
+			}
+			if (!tcp_rtx_synack(sk, req)) {
+				unsigned long expires = jiffies;
+
+				tcp_accecn_ace_fail_send_set_retrans(req,
+								     tcp_sk(sk));
+
+				expires += tcp_reqsk_timeout(req);
+				if (!fastopen)
+					mod_timer_pending(&req->rsk_timer,
+							  expires);
+				else
+					req->rsk_timer.expires = expires;
+			}
 		}
 		return NULL;
 	}
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 8536ad08a668..042e7e9b13cc 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -334,7 +334,8 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 		return;
 
 	if (tcp_ecn_mode_accecn(tp)) {
-		if (!tcp_accecn_ace_fail_recv(tp))
+		if (!tcp_accecn_ace_fail_recv(tp) &&
+		    !tcp_accecn_ace_fail_send(tp))
 			INET_ECN_xmit(sk);
 		tcp_accecn_set_ace(tp, skb, th);
 		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 160080c9021d..a07ec1e883f1 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/gfp.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <net/rstreason.h>
 
 static u32 tcp_clamp_rto_to_user_timeout(const struct sock *sk)
@@ -479,6 +480,7 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 	 * it's not good to give up too easily.
 	 */
 	tcp_rtx_synack(sk, req);
+	tcp_accecn_ace_fail_send_set_retrans(req, tcp_sk(sk));
 	req->num_timeout++;
 	tcp_update_rto_stats(sk);
 	if (!tp->retrans_stamp)
-- 
2.34.1


