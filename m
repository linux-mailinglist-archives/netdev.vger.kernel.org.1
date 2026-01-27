Return-Path: <netdev+bounces-253849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAXVGY60eGlzsQEAu9opvQ
	(envelope-from <netdev+bounces-253849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:50:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D452B947DB
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C069D30193A2
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE484350D58;
	Tue, 27 Jan 2026 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hb1zG06g"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE88347BA5;
	Tue, 27 Jan 2026 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769518218; cv=fail; b=MVGWlWneY6yJ5C3EYT1rs9d6llf2jANq7xaTFALYJtm4FJO9NdKBf1hxVicT+6jo+fC2t3dho6Y2tnj0s0Ewz6CIhy3GDzhJDVIg6GJUE0Gdgf1gW9nffT9ddyedxjQKnnhyR6XIaQQE4h9ZefFlTofIUH2XrW/74tgemHvtOpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769518218; c=relaxed/simple;
	bh=P1s9h/zJTgVj3CjS6+6JKFAc40uQxFF4o1b3kMGVhvc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ef0GrB5Q17BbanED8QipuBLHhwa74AkBpvKR/qjFRjDRgMaBEWWs32yoqiBX/aeNakIncK4VOBXCjF+fUTpD/oAZeag+YGRdsXybo6kSviFDHLLJGKgkOH2OxTVr0B+eOqNjVELlJy386I+I2IIBt1FKrkjPgyZINgraQl3g4Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hb1zG06g; arc=fail smtp.client-ip=40.107.208.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXZzBRWBhjVeQ2uU1dCcdRjzX4B74MWPiXksgPbu+eq+7ccN0tRZOc2NvGZsQS+iYYjRybgCVyt1OTaH7NGHJ2W8XO7GbdWiQ0c0sAGKzt/ddwMRDpSzdBW6p2KQQYqwrs4P4DA/gpVWfRrkfsw3nFJK7AzSlaOmA7KwmUFyajMX0CNH0R+erOpRnYUfTHttqbOI+rlxK9h76F6FuEQztaBFuASn06V+cC6R5v9AvPvIKeH8w91B3WD3e8W/pJ06cpWWAwKRHsAuEwDExBq+IcQKQPLgCyW/jD/+XLHFzqvjHi47x5btBGA2bZTvDRhtWoOwctPhqczSLN19QMIGmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2m1CNN5sA20Yc8S+fMdgSX8X3XHwcGdFQoitApLZTM=;
 b=UECyJez1uvKgIVv70ii1fQe+zvF5Z1qrccPNii6vUf4k1nppbuwJd8pkUJSmIaC3kUvSOKwuopK95rfBZK141dOpsdtYsKBO0oGe98EnMBpmDv1Uf41n6dIJSkMyOyjDqSQ9pPsgHmxgyEGVeXkuL2XFzMYOjsY8XPYN9Bb56J82Ua7NkWQ5lZyhQZyF/m1WepMYyyJ/D5qbT++QENFJ8e73ovxsireZPONU3uVEOCpd4t9heNjSirqumR4Kwr0goYKCLjwsveJrpoe581HlgWBGXjHMDzzj9FyGajXDZkzx29gNXUk2tVp006Zhlppt4Epgz4+4+F0kTD4auqvPzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2m1CNN5sA20Yc8S+fMdgSX8X3XHwcGdFQoitApLZTM=;
 b=Hb1zG06gjFjqDhhv9Fgtf0yeqR/jwwjRkzV5LF2xFEYsXWF02rE5YD74IpyZvItClqs+Jp0jZr6Ivtkfe5b412yuZyy+ricsi8Q/vvdUKDvaGDnFRNXZ/FoCNi+Hdf2s87/UxGYrx0BJPyK7KGeKiigwSEwybCyyvzZVffBhd5iB4+HKNIbBMuijz+wFUioHHuSd4ri7QzNw8hFD+OeyKcF0eVwN9gDxdXu5t/mVl/UN0EiMXaILKwBGJC9L1LJ+b1FkoSop74kQjLciQQGE4dyoLCKLYMZcjo8F8gXNiiWopTM78CJUPo5b+Nt2vHg1v7r5aSgMWfpriotTr1MCMw==
Received: from BY5PR17CA0046.namprd17.prod.outlook.com (2603:10b6:a03:167::23)
 by SJ0PR12MB8089.namprd12.prod.outlook.com (2603:10b6:a03:4eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Tue, 27 Jan
 2026 12:50:12 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::dd) by BY5PR17CA0046.outlook.office365.com
 (2603:10b6:a03:167::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Tue,
 27 Jan 2026 12:50:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 12:50:12 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 04:49:55 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 04:49:54 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 27
 Jan 2026 04:49:49 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Alexandre Cassen
	<acassen@corp.free.fr>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net] xfrm: skip templates check for packet offload tunnel mode
Date: Tue, 27 Jan 2026 14:49:23 +0200
Message-ID: <1769518163-125874-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|SJ0PR12MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f98d860-63ea-499f-27d4-08de5da29c7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?udW9oSBkHxmqi4iAEYkBcXZYAmZeAUnHSBr/+tF/apV3yGQzBqhBbjy/6Ddn?=
 =?us-ascii?Q?k2jZMjXYTd5R8N82YBZwVrnjI+IkF5mJSgf8S0/1LSX+R+/8uMu1dBUUDlAk?=
 =?us-ascii?Q?Qv0DHqR71augXB2fg3WKfuWpbWQSpR8w80KD15s/jRCIDOu/zuWycdtpRZLj?=
 =?us-ascii?Q?u3SeSIXdCq7yCpv/2nX/XofgmX6XtzK9mos2xwRFg7R5rh3Mwv1VimxpS6xW?=
 =?us-ascii?Q?1vM+RqBOR86XBHfCIQdhPHV2a+TJQZkO92LKm2dWpGZHhePhQyz2nOAydCfZ?=
 =?us-ascii?Q?zALrCz1wotmgZVX8NJYDpVYqeoygtawIRiWzQg30gnS43LHO6dQNR5jLPvYq?=
 =?us-ascii?Q?05q87BsECeFnyv5a3EMbdrec+UuNvoMkVo4OBt07THgjQ8PS4crGrBKnG5+M?=
 =?us-ascii?Q?yqz9u+jAL8eJ80DvPzbrtlNhDkogq1wCy2WpJRW8fh3b0WzEDtd6sLz9gdna?=
 =?us-ascii?Q?koS4jVrqDOiiieQkF+mYQbJSvBPVuo1CGCkx+zRmcUA3ltNliGljifhjP4v0?=
 =?us-ascii?Q?KxWh/URy1Tp6Hrv6Tt+FuKDUyMx6oSzOc00nIYmTyKXE8RI1qnnL0AnksAF/?=
 =?us-ascii?Q?zmYWpP586KFaE858jwbR2pvtnHl/uxFHkRYcd9qP7d+Q+tbd743Tm65A1IDu?=
 =?us-ascii?Q?ReCc9b5JKsKStm0S9ct/iCiHpGRVl3Cf9LAImhs7oTZRCBFGezCLRupgiHGf?=
 =?us-ascii?Q?aMpr/AVzFAWBtPZ4cBqF4ni0U4N/KpEK8yAvyCivx4YvN3cKWjIoWPoQQ2Db?=
 =?us-ascii?Q?C0zxeo/3aUP3CftscKidgkSVaE+T9zxsSvmM/1gwjkD2COH6xGr46XDgkWZS?=
 =?us-ascii?Q?CtxgU3S7zKEpp9tddT4NtuePvVVLWvPXjUP0R3ALsVD7ahge5Mf72JpL79dy?=
 =?us-ascii?Q?OqE6Pwi51+QJQEKGDFU1C8RTr4r88y/hKaA89xtbx+75fI3RNaQn0XUoGRUL?=
 =?us-ascii?Q?FTVRA7absrUv045mwowPVPTiRP0j1NxH8oG3+m8fr/gYyl+ceRJOJI+KhTD1?=
 =?us-ascii?Q?H+4th4pf+47eQ33A3KOjBLTW/fq524sP4IRWE/Ha7Yr9KLnSPjXxQycDHMlr?=
 =?us-ascii?Q?HFXgUabvd4y/SymK8uqNvuBHGULYhToDhDk4VZb5gWDE9/t79eh7qsh0zl42?=
 =?us-ascii?Q?QOET6aX7qbDmdydrU4oEb67rNLbQHWPkNneKWKTjFb56gftn5cCgvRGcETqI?=
 =?us-ascii?Q?l4NhArd7nnChyA9R/RObhwcTeqYuRbQW+TjxINYcJPfY9C/OBEoGYc2x1hvz?=
 =?us-ascii?Q?iDBif0UncUA+5jxR5UfZyUOs5ad5L415oBSrttycGhDvBiWqxDVnYJBs6iBB?=
 =?us-ascii?Q?cqzMxAMyJefx2KY0+lCdbICuHU50ch0OCbSRvUdGRrYZ+sjL8+0xF3ip676g?=
 =?us-ascii?Q?1mswXmKNFEGosRXfknGkqFjpiwfL7umL7Xh8MWOA2WkFc0hsFKG6LjBr5kul?=
 =?us-ascii?Q?jPAKeX65Xo1U0kQb2YajmVJ0oDF/nnvuBUrxJZcRAO22Lk5HBbKHscZRQoVR?=
 =?us-ascii?Q?zuaOIJ8mIyEKDlyt3p6WY77carjslvZJgKOlHgr70Ovd++0tp8uI6RifLXY0?=
 =?us-ascii?Q?0Sd9P8i/G2N0ZMbphuRTLsvi640e6Veli4VdHwaEteupRFnINHUIpDA4GfDB?=
 =?us-ascii?Q?rJ5Jlww1B++gZsfcWpEhyNsxHeT3AJygm1PHfu7a9zeDXSWJW7Q2KCRRYvmR?=
 =?us-ascii?Q?qUEyici4STNuKTYA44jfzUn9Ntw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(41080700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 12:50:12.3307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f98d860-63ea-499f-27d4-08de5da29c7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8089
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253849-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D452B947DB
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

In packet offload, hardware is responsible to check templates. The
result of its operation is forwarded through secpath by relevant
drivers. That secpath is actually removed in __xfrm_policy_check2().

In case packet is forwarded, this secpath is reset in RX, but pushed
again to TX where policy is rechecked again against dummy secpath
in xfrm_policy_ok().

Such situation causes to unexpected XfrmInTmplMismatch increase.

As a solution, simply skip template mismatch check.

Fixes: 600258d555f0 ("xfrm: delete intermediate secpath entry in packet offload mode")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/xfrm/xfrm_policy.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 62486f866975..5428185196a1 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3801,8 +3801,8 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 		struct xfrm_tmpl *tp[XFRM_MAX_DEPTH];
 		struct xfrm_tmpl *stp[XFRM_MAX_DEPTH];
 		struct xfrm_tmpl **tpp = tp;
+		int i, k = 0;
 		int ti = 0;
-		int i, k;
 
 		sp = skb_sec_path(skb);
 		if (!sp)
@@ -3828,6 +3828,12 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 			tpp = stp;
 		}
 
+		if (pol->xdo.type == XFRM_DEV_OFFLOAD_PACKET && sp == &dummy)
+			/* This policy template was already checked by HW
+			 * and secpath was removed in __xfrm_policy_check2.
+			 */
+			goto out;
+
 		/* For each tunnel xfrm, find the first matching tmpl.
 		 * For each tmpl before that, find corresponding xfrm.
 		 * Order is _important_. Later we will implement
@@ -3837,7 +3843,7 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 		 * verified to allow them to be skipped in future policy
 		 * checks (e.g. nested tunnels).
 		 */
-		for (i = xfrm_nr-1, k = 0; i >= 0; i--) {
+		for (i = xfrm_nr - 1; i >= 0; i--) {
 			k = xfrm_policy_ok(tpp[i], sp, k, family, if_id);
 			if (k < 0) {
 				if (k < -1)
@@ -3853,6 +3859,7 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 			goto reject;
 		}
 
+out:
 		xfrm_pols_put(pols, npols);
 		sp->verified_cnt = k;
 

base-commit: 165c34fb6068ff153e3fc99a932a80a9d5755709
-- 
2.40.1


