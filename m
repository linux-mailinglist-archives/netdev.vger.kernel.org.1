Return-Path: <netdev+bounces-288863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKbMDmWxCmpx5wQAu9opvQ
	(envelope-from <netdev+bounces-288863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 08:27:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8496D566AC8
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 08:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA6D73019803
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 06:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2916F3E3D94;
	Mon, 18 May 2026 06:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rcPMyJsv"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010017.outbound.protection.outlook.com [52.101.46.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693293E00BA
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 06:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779085402; cv=fail; b=Pz1EwQ6R0ZmjM8lCEM6vTSWvRM6AGeBmq5m4o7x/uM9g1hEAx+IVw1nwZ89Se5bs75pYZeVJYWwUPh8LOmBzbdd6q5IRjzWhbNqouvv5hYA2ND+lZGkQFL1TdErdS0je95sbXtO0P+RTcGi5cEJIVT6jWJoNhbhEH3A4SGHY+sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779085402; c=relaxed/simple;
	bh=NcSgTpm6cbD9Fd5HX2cP99u1SZyhvoGCwLMKi61ZJOs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G3o/23MC+YL7ithKswSD6/IvlNvzTclyO3Mnrv636kBCfbjjW6DPuyy/zsvdI7cFvlnHaDZs1JFHzUyJ6oCuH1qnLDAzcxKmtYMC2tOcfAd4/Y2xutLfQKTuHlD3E7Hf0QFomGNs29BpaV43wGW/lp5/HL8c8eqa623aQXox3GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rcPMyJsv; arc=fail smtp.client-ip=52.101.46.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljjKfwJIS8N0qVJSVt/f1HWRxMlU+OUjZ9gdsNw/B1o8xjdNmVZTtDERDHSL1Do9fcvXRKf1NtIwrhc55QbR1/+XE/LFYBPqrut8Ijd6BO2nupDactCL951IbwDxPSRMn0y5YYouUpYMAsBOzSI4pFkGBStHhTJMvuh4+Kn8lHXcw5z9pfL1WhnQxPFLGCM+3X6r7ain+Dd689qpRgIUiCRsNVcxkSePBJ6gX9LGw6jeBLAWDkTIKHcnI+aG5G5zrIQc8ff8M6NpHiN75swjWi/P/dIQn/z6GYizEBxLWkFSgHPwJWgpMU1j7ALSHQlDxMKrYfn6kmG7+qb2YHMhyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4rbmptH/zth9NahQBICbc6jvPrFyZ9sef+EM3QTtBI=;
 b=eaaEo193ryidgXBtO2wpTtg9FXU7jnuot3p/JwhC45j3DDEQaUI70gieNVEb8stvo1MLQcA6HtpiaadWr2vcWIkrFF0B6ZX3dM1mlOflA7hlxyAv6Rjv0YmXnt06fma7JF/XZnbN1/72XQMhofuE04AZkv7b+R0TZ/Ys/21K0GSMrqtAL07W5sM5KrLGdNYiyA2VkIa3xN/HPj3D9+wZt+rqPRBN3FBYvN5C++wiJHNxBLRkvmGQT2chDJNtruGbzr/sgWWQbpyAFdkPkR3TQUtWCUepwKY7iADtM889gKIKxbRFWJEByrCUn0Tk5xGJtBR3owI/BUedZf9xpUda5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4rbmptH/zth9NahQBICbc6jvPrFyZ9sef+EM3QTtBI=;
 b=rcPMyJsvnHbD9dX6pEqxjrnnyFLFZvXEGV+tHcHvtFsrh3N+wxXd1GxqH8GBPH+vsQNDQ24rcacr9kocytI8KGDQ0UPCMaieZ5x40INj4M0RkBJg4DjnJlx+WIEnp8/UShoDreWHHMzybH3hhKir1MnDmhPk4Bc46r+/xReAiki3fDLRFT2L5JxuHPOUcDWP3xN3e3Y24LnF4k69xHUtHu+uZQuYi/iDeNK09uAlISUnYHNXZKiy3reg7Z22svghRhy0y1ZvwJd+Rwbto73AkT5YElraifvXZcZKX2Zy5cBtyzxDO0yk/5Vd3grT8W//QL88bSsudbfACPyrcZcKKA==
Received: from SJ0PR13CA0145.namprd13.prod.outlook.com (2603:10b6:a03:2c6::30)
 by LV8PR12MB9155.namprd12.prod.outlook.com (2603:10b6:408:183::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 06:23:14 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::91) by SJ0PR13CA0145.outlook.office365.com
 (2603:10b6:a03:2c6::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.12 via Frontend Transport; Mon, 18
 May 2026 06:23:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 06:23:12 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 17 May
 2026 23:22:58 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 17 May
 2026 23:22:57 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 17
 May 2026 23:22:55 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Gal Pressman <gal@nvidia.com>, "Willem de
 Bruijn" <willemb@google.com>, Dragos Tatulea <dtatulea@nvidia.com>, "Alice
 Mikityanska" <alice@isovalent.com>
Subject: [PATCH net v2 1/2] udp: gso: Fix handling checksum in __udp_gso_segment
Date: Mon, 18 May 2026 09:22:49 +0300
Message-ID: <20260518062250.3019914-2-gal@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260518062250.3019914-1-gal@nvidia.com>
References: <20260518062250.3019914-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|LV8PR12MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a7a7166-a231-432a-7ffd-08deb4a5f04b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	/P9kx+N89ZbSoSc2SShi+YVHf3p75bdBKkNq9bksyWJIaa0w6PDyoEDOyZCiT70Q39VruOd6JlXFzwe8TPpIKCDAovTcL0lz8CZkM1Su8NMZAap1G8rUk39Xj5ZwXV2G/OlEyR8bsAIlEVD9+Dz5tZx6gmW9ELjy1SUOXhAxHMXIeK7tmz1R+gFiXDRt3E7VwW0pi1XQSaYQKhfhn1uL6VPxacv2Mn+KKuyiYoA7/LAjbJCCUMOx9gI67l4uNCnMe1j62iFcrGoe9EcexN6W2w77wVMe87ZrtUnIN5s9pwEVo8hE784Kw/reVs0XHNzbyBbG2PQjMu+75iv19wXSnYKkQ7WUa3eAISLYvjVqdUYvzCQ0fLDOb5gS3Prt6dhTzTHiv2Cf9kRoC6kDgdMPCxA73hij2lyjWkCNMnXrnGsnQ54yftcmXU5LWJubB6ci9/iKQPLvym9pypGms6nAw8fIXLaOlRVa8Kf/QXqEOdUQaAe5tydxeimyi0ABWcloGrsj5DRP9VZCDUQgvDQvD/Oaq4+X/ILX7+bybsfC54wRV0VX/FaNlLQ874E5XuJAi0HubO0OfZC1mBdb0E6x5ya/VjaXCJbnOIksIW/06AL+Azciv5oao11wOu6L7a/X96Sj0q0R98VuMThZGqtpyhDN9mPZFFwKmwsQ9pVSVcNavF0jFyyWucod57nzBS5PkHYxsqa7gQ3Ug7OP7T+hd2nlYPuLqlgVV/9Ke+X8Z0U=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LlQhn7Ru1tJ7T4zXXDYvq3IPZDhJaNPwav1BUkALSBYmv0uy8X6FmrCqrFx3S63j4QHe0JXqB/xnUn+vEIvnlho1NbXEmL/9Qr0LD3YNyglYEUImtpz0BzYtqSrhU7H4CiqYqUyyfQRFiIR8bvYDrHljOpreEw8fgqC+rsrM2XCvyC7IpR73xoKIQv0gQhVv340YX1Op8IrqFSQ5toYqAtTC6E7DbxiTLkMlJPt2LCB3YL1kxKjFOygt2eaUiYUhpJKlYnu8VXwyD7rjtMg7QAu8FDXw4TWsAMfh43Tn3Vfv7vSuSHGrrmqxz7ohSHTU/QYKhNixOXcYtldKCTpvc/D+GFPvlUgAuuzmE+8V4uj6Ho876tMeO04JCmA5nI2m617Te1FdOwWc7xBxy9v2CBE7YvMoT2P3gVJMVPt6OZseex3lLoqcgwSlYnM/wxJS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 06:23:12.5850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7a7166-a231-432a-7ffd-08deb4a5f04b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155
X-Rspamd-Queue-Id: 8496D566AC8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288863-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

The cited commit started using msslen for uh->len, but still uses newlen
to adjust uh->check. Although the checksum is ignored in most cases due
to the hardware offload, __udp_gso_segment attempts to maintain the
correct one. Fix uh->check and adjust it by the right value.

Additionally, after the fix, newlen becomes assigned and unused before
the loop. The code can be simplified a bit if mss adjustment is dropped,
so that newlen becomes equal to msslen before the loop, and msslen can
be also dropped, saving a few lines of code.

This brings us back to one variable, drops an unneeded arithmetic for
mss, and fixes the UDP checksum.

Fixes: b10b446ce7ad ("udp: gso: Use single MSS length in UDP header for GSO_PARTIAL")
Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 net/ipv4/udp_offload.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index a0813d425b71..2578aa7f9ff9 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -482,11 +482,11 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	struct sock *sk = gso_skb->sk;
 	unsigned int sum_truesize = 0;
 	struct sk_buff *segs, *seg;
-	__be16 newlen, msslen;
 	struct udphdr *uh;
 	unsigned int mss;
 	bool copy_dtor;
 	__sum16 check;
+	__be16 newlen;
 	int ret = 0;
 
 	mss = skb_shinfo(gso_skb)->gso_size;
@@ -555,15 +555,6 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 		return segs;
 	}
 
-	msslen = htons(sizeof(*uh) + mss);
-
-	/* GSO partial and frag_list segmentation only requires splitting
-	 * the frame into an MSS multiple and possibly a remainder, both
-	 * cases return a GSO skb. So update the mss now.
-	 */
-	if (skb_is_gso(segs))
-		mss *= skb_shinfo(segs)->gso_segs;
-
 	seg = segs;
 	uh = udp_hdr(seg);
 
@@ -586,7 +577,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 		if (!seg->next)
 			break;
 
-		uh->len = msslen;
+		uh->len = newlen;
 		uh->check = check;
 
 		if (seg->ip_summed == CHECKSUM_PARTIAL)
-- 
2.52.0


