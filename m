Return-Path: <netdev+bounces-255527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLYkHJ2BfmlQaAIAu9opvQ
	(envelope-from <netdev+bounces-255527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:26:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1655FC4259
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98071300E0FB
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 22:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710AD38B7BC;
	Sat, 31 Jan 2026 22:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ZERoinUx"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013023.outbound.protection.outlook.com [52.101.72.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C2938A9D0;
	Sat, 31 Jan 2026 22:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769898365; cv=fail; b=iMhQkH8hy1Sdyr0Vx83tbBN4+IhyVnYznK7DWBEHp1RRbuD7H/VNM8xD7dC21yjXTbZT5rxvaMeriJ3O5Y4AVSg5rrysglQkwmY6i/GDljWoYLhS57ZSMrp/q+KubyliGC1wQKoTfbx4D4Npvq/SFX46gcj2Sp01OIgkg/Mh44E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769898365; c=relaxed/simple;
	bh=uvkt0AQea5pXvzmWW7SvV8252KtIw9Lz8Q/cE9tBFj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QZpFzwFcJ6YxEvZKF8hfrSHLtu6Ned0/gCeGe8l/esOxneGpdEDPIT1IDk1eR6brpGe/jM276kCW66JW56rAhWUGGJJzLwYJZk02tOpHQyEBl9zu2mOiov5EpeZa3ZjJV8AAVvSiLxlxtbwh3wV+GLhEQH79UsjTZ6lki21sjOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ZERoinUx; arc=fail smtp.client-ip=52.101.72.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMBVfHlY+bauuGLzBlUmtgf1yi2VfjXveWFY5+2536jCzoCFEQJtziUTBBqnhYjxqyQ+3bDPKgAMvanamzNZ+lKESRXBbbGh2oevmZG3LXrsRNTxSxgmlJIUlFvsjIGADxUlu38ndrbkWin62WuBFIdQ2e/eOkb9Kn8FhrQ7v2/5PRg0JpmdMK98pGrVHWfMrnkLpPOyFO0mKUToxMOcnDi3V4AXvlw8l087zX7hwOoiVO7ogPp3Sz56dmwrHZm3BbJo7IU5e68+xSSpGAAUv26gHBnNntl3GE0rIsqlnrfbHxdiS2O8PyOZvCt8Q7dqOhpEthiXl7XR6E+MfAs1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLm9vaJ6HaKxhNBY0KfOHsMOpkfMinjEh4Eb4r32wlM=;
 b=JoZB+4IYz2TVnkHie7t4s8BpbnTukIqEbzOr0ofSUrC16FwBq4kgk21IuSPniUMuhq3iEgNOJWtauxtVoCrtjVm75HRBWJPLDpN+no6T4o6/E9gibSyFVDLgmPshWnAHfr0dA1NDTPV546cLeU7ybQVnwLrn16feIz6LYOWfEtULeTLYn+aPP/c2Y/n9F7EjXxyQyDBe5rdfq7PAtV4d+gEfLdmm+fOkSrWG7b4LEs17UYiVsGA5MTCQX0uRNzXD/fFw0K/MAUXUYQhRBJ+u6WzyZl+bUcO7tC/OqMvhTu203IQXUjdC6SLZnvTZCQsFFQaJ7GWVWeKRb0xFF6WjkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLm9vaJ6HaKxhNBY0KfOHsMOpkfMinjEh4Eb4r32wlM=;
 b=ZERoinUxDrKxr8EtTOWavLCwPbtC1d0p+g7xM0iowWe/IxZcJgIVUMiagU7zJepzIxGYTmNxV7yCr331q7MEppDBBqd2mLHkoHeMB9GdRVs9487EO5DBuppE5rsi7AOqQ8EbxTGndyPmBcJShhe2LPDV65AoL0L9vuWfjUcMnl4phy24ayf4QIUwbTIrr29VJqZahdIUudKzbMvJO1HWCzkj2CMEdrJYCK8PchPCZc+tqKJv/nRyO/DEAWbx996JB40arElIGEXwzBLIcz6ExsWTZrGH8AMmCqXal+6EZUx+OrYGZ+wp/VRg8EaOSHEeTbkLdp/Xifmoo3Ybc8Knqw==
Received: from DU2PR04CA0255.eurprd04.prod.outlook.com (2603:10a6:10:28e::20)
 by PA6PR07MB11558.eurprd07.prod.outlook.com (2603:10a6:102:51b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Sat, 31 Jan
 2026 22:25:54 +0000
Received: from DU2PEPF0001E9C5.eurprd03.prod.outlook.com
 (2603:10a6:10:28e:cafe::63) by DU2PR04CA0255.outlook.office365.com
 (2603:10a6:10:28e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.13 via Frontend Transport; Sat,
 31 Jan 2026 22:25:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU2PEPF0001E9C5.mail.protection.outlook.com (10.167.8.74) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via
 Frontend Transport; Sat, 31 Jan 2026 22:25:54 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 00FF2238DD;
	Sun,  1 Feb 2026 00:25:52 +0200 (EET)
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
Subject: [PATCH v13 net-next 12/15] tcp: accecn: detect loss ACK w/ AccECN option and add TCP_ACCECN_OPTION_PERSIST
Date: Sat, 31 Jan 2026 23:25:12 +0100
Message-Id: <20260131222515.8485-13-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C5:EE_|PA6PR07MB11558:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1e4f3a66-8542-4368-7abc-08de6117b2e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FoW6FvB0pPNW7lrcTyHFRegKeIH0K7rZhBxy89e3b+HYTmEi9nF4Bg58y6er?=
 =?us-ascii?Q?wLt8+Ol08ZY6tr+yQ4Kdk8MuF8ZWQgUOwY4Ld0+ZHeKiU7Lvv9rH8fGp7x2/?=
 =?us-ascii?Q?UbYHoSNBLAZ4HzBUKIUnrB+iyq3Gke5vvsBkgYC80bqiMYgW71Lsfc42Ve5B?=
 =?us-ascii?Q?NTV8S/ED2cIiAfvSQmyREBhX5cvtKlM9Tb5MLLepdcfJWTTttZjrXPahkeOn?=
 =?us-ascii?Q?zV+JbzBD8m1N433jRKFWqKOPz4Qo9iGIeBxcFiupeuqK1I/7Z+HSZNhJuTKm?=
 =?us-ascii?Q?nylcizIUCpt8W6j4CunbGnsxj651C49pHG5BYtu65PVSrVTY94Y/6Ii6pvp+?=
 =?us-ascii?Q?78qRZoSMGbG3w+5vgJAPMri+VWc5uloFc5R63EHDFhChnp6nvds9qIIBmgh4?=
 =?us-ascii?Q?hWN8u3wZxL6fL0DCxzDy3npiwYYW3ZENCaTQVJ8hrGx5BjYNe1sj14c5t9mz?=
 =?us-ascii?Q?wl9rgu5lM7Cawwi2L/aFxYvZJ4q+3B1SmQ1AENUW1jSjT3FnvGc3WV6VIAAU?=
 =?us-ascii?Q?F0YZZguggh/nCbeeMvbkwwbtv/WfQeWxYT+mHCJqwO34TBEsGdqbaHO0k6lT?=
 =?us-ascii?Q?MGB7gN01SyBkBhh2U8ZqePxdpqSMcIXGN5vFZhXnrZJrRwn/FJbeesyzijd0?=
 =?us-ascii?Q?7wSMRq+CO0H+06pxUYRA8H7cBprhr5rv7+dIoJ86/5tHJDrEj72YkhtAu5Vt?=
 =?us-ascii?Q?GmLZFfB3h6UKkumwWCdLbs+ef/dKQpkLJ7JrrDrclDGxP14NqWlku2X5kZAJ?=
 =?us-ascii?Q?sE24pdp0I3G6CRx4jR7jVsJFU6XmOtOfGM80ST+2my3SbcCKWbv4UcIbQLXK?=
 =?us-ascii?Q?z97oQz5JHEeBalX+sLFR7aMoyHUmYR2BGXQ1c+xaVwV3F5BzQt7eF7GPl7E/?=
 =?us-ascii?Q?6Uk1va2X4FwRTTPOnrSpLmrU6JIvgeoGxLlY7QcqkTHOF6FzN3Ok2gios//u?=
 =?us-ascii?Q?FA6MHW/WQM7aGbwI8EHCjxJ3/ibxogY0Hus9ITVEVIpP2mKEd6jFdKFHCd9H?=
 =?us-ascii?Q?AhnKv4iYd8Mz5mbAErh2+DC6SgGlSaJPuLZa/jZbsc/VXciQlexRszRh9QVM?=
 =?us-ascii?Q?UkPRxRt1hDx8aqXmRwPKk3pzgRoiY/4qaIaDxvUr9bpT67xRFze48mnv+gns?=
 =?us-ascii?Q?eKGLbZmGTEU9s/+jTR+Xt9o88wx4n26huJ8cj9XNifMK0xg2IVqgB76+nS51?=
 =?us-ascii?Q?xcQp8ju8YO2zAvuYYTBlJdZ2LDLRDyDO1aV9W17sm6LSY7k2CKxFG7JM7z6V?=
 =?us-ascii?Q?LIzzAyNxe9Mz7vXlCfpFO0vuk8ohjTVn0XE4vZCg1ltnnJuOk41a/AREj9Sm?=
 =?us-ascii?Q?J7JPOkjwF6vBtbV4j/E8TD1hPEqpCtxt9/e/lfKW/MR5mCtLMlNWTVAG8tju?=
 =?us-ascii?Q?G1h8HZOBzlLLxnQK2fugz1BgFeUyO8QZdQZxF6LfPPlk9eikHV3V/zgdhYYD?=
 =?us-ascii?Q?lrEZ/pc31eDFukZa9UlOTsIyPaoDKH2684PnnENUzWkyWYPwe3wUOYbcLBfC?=
 =?us-ascii?Q?Yo3ekmAcxNjjHXPzGyUJ3TlMLu0/JtbIAO4p8j2JdyGS+qsjhtEV2gwbwMSK?=
 =?us-ascii?Q?2pYu3k7pohU/sVMbDTxAQrPQ9MRazdWAsvIcV6N/rFPB/1DhzG5c35iUYOl4?=
 =?us-ascii?Q?n/ulNSTf8ACstTFsSCiIUt2NFUK6jyqgZF4Sbtpgh38U5FSlsTnvca6WQ+Yd?=
 =?us-ascii?Q?Dc6D2mvZXDcBhBY+XNRCemEMDP0=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3XWO6ve04YlnOEb7L3y7nf0NSODAXw6qZOIC+rsl0tgsz0YFfO0zPWhs/ZdZQz2Fx3pwOz2rUQ6xCduBp9FDyJ7UEm2m62Rn+vC1uIjMGwFqoql9B82DxUsj0oAOxfilKCM689AgSwASdwpnmvVSw2Gh0merkrZeSryoPdfO9Uccv5kOTr2tUUfGyxIpjWTM2DcOAJaqSNPrfzWUqGXgrKLm0punPxV2MiKLegPYR1jAQC8AN8Fj7Uq9fMHgEsUndp8Stv1UPsXvcewRNjp504y3vHj2BXmE2noU9WIdRAbiGxi+xM+i3ZzhV5OuPr07oM3MxGOkkgl9unvtTXKPJakE8gbWd3k+0+yl9ETmVVPcM9ROQY1Oxyi0Z+2hcdDVCaVlHrEuFfWqZk3NbhCgKJoA3cAii6rvE6BZ12HaQng2TgSMVtZF21Aw4UoLnU3N
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 22:25:54.6146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4f3a66-8542-4368-7abc-08de6117b2e9
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF0001E9C5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR07MB11558
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255527-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1655FC4259
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Detect spurious retransmission of a previously sent ACK carrying the
AccECN option after the second retransmission. Since this might be caused
by the middlebox dropping ACK with options it does not recognize, disable
the sending of the AccECN option in all subsequent ACKs. This patch
follows Section 3.2.3.2.2 of AccECN spec (RFC9768), and a new field
(accecn_opt_sent_w_dsack) is added to indicate that an AccECN option was
sent with duplicate SACK info.

Also, a new AccECN option sending mode is added to tcp_ecn_option sysctl:
(TCP_ECN_OPTION_PERSIST), which ignores the AccECN fallback policy and
persistently sends AccECN option once it fits into TCP option space.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v11:
- Modify accecn_opt_sent_w_dsack to indicate valid prior D-SACK info

v5:
- Add empty line between variable declarations and code
---
 Documentation/networking/ip-sysctl.rst |  4 +++-
 include/linux/tcp.h                    |  3 ++-
 include/net/tcp_ecn.h                  |  2 ++
 net/ipv4/sysctl_net_ipv4.c             |  2 +-
 net/ipv4/tcp_input.c                   | 13 ++++++++++++-
 net/ipv4/tcp_output.c                  |  7 ++++++-
 6 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index bc9a01606daf..28c7e4f5ecf9 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -482,7 +482,9 @@ tcp_ecn_option - INTEGER
 	1 Send AccECN option sparingly according to the minimum option
 	  rules outlined in draft-ietf-tcpm-accurate-ecn.
 	2 Send AccECN option on every packet whenever it fits into TCP
-	  option space.
+	  option space except when AccECN fallback is triggered.
+	3 Send AccECN option on every packet whenever it fits into TCP
+	  option space even when AccECN fallback is triggered.
 	= ============================================================
 
 	Default: 2
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index fbc514d582e7..f72eef31fa23 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -291,7 +291,8 @@ struct tcp_sock {
 	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
 		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
 	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
-		unused2:4;
+		accecn_opt_sent_w_dsack:1,/* Sent ACCECN opt in previous ACK w/ D-SACK */
+		unused2:3;
 	u8	accecn_minlen:2,/* Minimum length of AccECN option sent */
 		est_ecnfield:2,/* ECN field for AccECN delivered estimates */
 		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 49e0b865fe02..e01653bbf181 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -29,6 +29,7 @@ enum tcp_accecn_option {
 	TCP_ACCECN_OPTION_DISABLED = 0,
 	TCP_ACCECN_OPTION_MINIMUM = 1,
 	TCP_ACCECN_OPTION_FULL = 2,
+	TCP_ACCECN_OPTION_PERSIST = 3,
 };
 
 /* Apply either ECT(0) or ECT(1) based on TCP_CONG_ECT_1_NEGOTIATION flag */
@@ -406,6 +407,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 	tp->received_ce_pending = 0;
 	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 	__tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
+	tp->accecn_opt_sent_w_dsack = 0;
 	tp->accecn_minlen = 0;
 	tp->accecn_opt_demand = 0;
 	tp->est_ecnfield = 0;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index a1a50a5c80dc..385b5b986d23 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -749,7 +749,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.extra2		= SYSCTL_THREE,
 	},
 	{
 		.procname	= "tcp_ecn_option_beacon",
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 988d161e9918..89526f0f2301 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5046,8 +5046,11 @@ static void tcp_dsack_extend(struct sock *sk, u32 seq, u32 end_seq)
 		tcp_sack_extend(tp->duplicate_sack, seq, end_seq);
 }
 
-static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
+static void tcp_rcv_spurious_retrans(struct sock *sk,
+				     const struct sk_buff *skb)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
+
 	/* When the ACK path fails or drops most ACKs, the sender would
 	 * timeout and spuriously retransmit the same segment repeatedly.
 	 * If it seems our ACKs are not reaching the other side,
@@ -5067,6 +5070,14 @@ static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
 	/* Save last flowlabel after a spurious retrans. */
 	tcp_save_lrcv_flowlabel(sk, skb);
 #endif
+	/* Check DSACK info to detect that the previous ACK carrying the
+	 * AccECN option was lost after the second retransmision, and then
+	 * stop sending AccECN option in all subsequent ACKs.
+	 */
+	if (tcp_ecn_mode_accecn(tp) &&
+	    tp->accecn_opt_sent_w_dsack &&
+	    TCP_SKB_CB(skb)->seq == tp->duplicate_sack[0].start_seq)
+		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_SEND);
 }
 
 static void tcp_send_dupack(struct sock *sk, const struct sk_buff *skb)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 2b356fdbf2ca..f44d60d13b9f 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -715,9 +715,12 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 		if (tp) {
 			tp->accecn_minlen = 0;
 			tp->accecn_opt_tstamp = tp->tcp_mstamp;
+			tp->accecn_opt_sent_w_dsack = tp->rx_opt.dsack;
 			if (tp->accecn_opt_demand)
 				tp->accecn_opt_demand--;
 		}
+	} else if (tp) {
+		tp->accecn_opt_sent_w_dsack = 0;
 	}
 
 	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
@@ -1189,7 +1192,9 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	if (tcp_ecn_mode_accecn(tp)) {
 		int ecn_opt = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option);
 
-		if (ecn_opt && tp->saw_accecn_opt && !tcp_accecn_opt_fail_send(tp) &&
+		if (ecn_opt && tp->saw_accecn_opt &&
+		    (ecn_opt >= TCP_ACCECN_OPTION_PERSIST ||
+		     !tcp_accecn_opt_fail_send(tp)) &&
 		    (ecn_opt >= TCP_ACCECN_OPTION_FULL || tp->accecn_opt_demand ||
 		     tcp_accecn_option_beacon_check(sk))) {
 			opts->use_synack_ecn_bytes = 0;
-- 
2.34.1


