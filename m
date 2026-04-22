Return-Path: <netdev+bounces-280433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG0aAFLW6GklQQIAu9opvQ
	(envelope-from <netdev+bounces-280433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:08:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 260B744710F
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EAF19300E1A8
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4F73ECBE2;
	Wed, 22 Apr 2026 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ds8cO1hN"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084353EAC71;
	Wed, 22 Apr 2026 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776866868; cv=fail; b=UUJA1aW1Pc/137chghR/7qKT+D6lkDb2KB4YPYIJL/TjccBh8M+C8DtEjk2h34Z42sA2GgxTGPRe2m1z20EE5aRqh5Ci8smFdqQVAS+6JEnaxaqM9Qyf5XmStSrMe+x47paIV5bTt3Ymo38Usuuey7O5L0sIB6MTJrvf/IZw3pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776866868; c=relaxed/simple;
	bh=u8edVsZexsfWKP68dqEw3lebywbfrFhhDDjao1Va7/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZqE8WWqkKgiBKmJcqQR3kQz09spGFy2dGHcxWXK17xrqyWQ0GctWD7c7aoz+LW4uU0BSBYO+vE/I5D2om4ni1MTJ2yJDMeWvMFYCxF7ddnA0qF2S1dryDvM9dPkEI5KVUt+XXHTI9lucsyzhiuBKMEBEagHQ66/HgRXa5Dvtqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ds8cO1hN; arc=fail smtp.client-ip=40.107.208.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aD4qsF5pLSqZ1Z5dT/7P5i9Rxny/z+n8680S3uom+yiLUblKunWYGqUSgThJHHpZtipCSYh2EzTwotdTP0R/47YQPrc4Jsdv9roxkxUZb3BceOHyboVpYac8DPaZ7rzPWCo9uoB3dW9NzPnW3EOl+NlXYDU1etINc8G7KY2LiTvtxswgWHqLC+jfUCPEpMSXKbwfm/8YK/WtTeNoM071A8tpRYumyvNMZTsUcOsug04/oGjTiFxInuZGIBfVFQe2M0gazSujoDUe/9LlLa7iAtaLJ4jL2AwKwubMNyIIfJHJAmaU0x/QXuoBVmmHd/S1zjFQOopwda078iXys4dn1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyF1dEH1GB14JE+i7Ekd0CdqgTU6cwjODk6bRZJiAJY=;
 b=eRVzpHQNCxaIFbobhoDyLKiV8K4BsMafL+VBQbz5kaMJ7U6FwdjDoM5kUQbLfHhXZeY015AF7Jckq+MmiuirfX7HhFedUzcDKxZW5UiRA1oNmHAfKYo+BRyauiNLuDcDQyXxLpf8nvYHNbp9RnrOjrGHr1ECbvPsPNou9MUmZe0SjBEr4P4SUzX1RVvJhpnKLRe2ysirnIbe88YKJM+gGo+A04i9DMolG50N9sRQ5PGmG4MZdhD4i4ILYj8S6fAF2+qUtoX95KwWdi2+Mth1HIfrQMsO5l4GpSbOYCUnY0jUR1lL6HCYN3iqYJN/+h69Q/UMxRE11BUEWRulTCCr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyF1dEH1GB14JE+i7Ekd0CdqgTU6cwjODk6bRZJiAJY=;
 b=ds8cO1hNdMpr4dWVHDzqg8MgJkHyaznzlw2kINhgGNoI69EjAU3g/g27KlpEUieiuN/DU/BaDifexBUvqwD2QP+8lVWB8xy1effYPqCG6ugNo1OhRyR7mCvuikM8uVLNFbhI4KNiZc9wnXxW6kUunMr4sKlzS2UXfa9RIKVVJy6h0hh71ivdYks96bbiqaHYEI5qeHrzCbhoMZvVEvvKBHGxzM9qbETX6SomnlssK+1lSTAq6pAStWQy9fYhDLE9o3hA/RD+E9PB+GcUmcDRv8cBn2QIN84Wrp/8cpAf70mwmJitA7YRwP+DhlrnICzgtT7xFRme4ETlhbe6AfyxvA==
Received: from BY3PR03CA0012.namprd03.prod.outlook.com (2603:10b6:a03:39a::17)
 by CH3PR12MB9024.namprd12.prod.outlook.com (2603:10b6:610:176::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 14:07:41 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::8e) by BY3PR03CA0012.outlook.office365.com
 (2603:10b6:a03:39a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 14:07:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 14:07:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Apr
 2026 07:07:24 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 22 Apr 2026 07:07:19 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH ipsec 3/3] xfrm: Don't clobber inner headers when already set
Date: Wed, 22 Apr 2026 17:06:48 +0300
Message-ID: <20260422140648.3877129-4-cratiu@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422140648.3877129-1-cratiu@nvidia.com>
References: <20260422140648.3877129-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|CH3PR12MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: a1bbd940-880a-4491-e27f-08dea0788477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700016|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BrronTY3Y1aQ5Ycjk6QELiLd0lrQH6jM/L1lynhDMKCK7GjAN13ymoJprInSTPLyKZr083b20zJnnGHRH1rpPaDqeLX7LdEE0CC5HBJDv/oVQoPafAszYbpUpVnsu7iAoD+kbYmw6BvutO4rmbjPLuKKTX+2hCht24YDp93bzhN+e1X+r5B7WrmZT/J6LzDh2qxcIba54SU+EV8hYWBqom0GGSR40r6nHlHu5QKbWE+lWKa3p1u29YpihcQVY+fefGcQb06l1vXYJV8rhX4aB/g6SGOqdX1wtOCCbG1EHjgWDNiiDCCIx5dz90NI1ry3K87OnRtml4NWwWW3amAhckywl4T07jOEyTHgwTKG2hDon5uEhTQEmg870OYPffR6hLZF4XUEhs+7RVBYkDLJY8V1CZo4lduDi1PnnuKAZzKn7ldIBAoRThk/aIE0Lg0+NRR0rFB41hXAa1O0XvIvOXxlK2o3sWpyLKQXaGSwAd5XVEPKcgwWt0+l+JlfqKlc8I/q9cZ+L9YxilEj+Ma3POppIb48X1DAVFGv0oHen1adO03jn/T72jNiv/OaLkyHbX3CGKmRHU767vYFWZuHaDag6sgyVs0+PeP/LJVcd+mEU3PNcDDS7hBy/dL7VTsLA8knBBNJjKUcY/U3ws4kVDgCVbVqGOBcQJDZzAQAgFX4Tqfs1xSoPbFHpJPickpRE4+2YSRy1Q1lOXQJLKFj6vp63BVo2UEBfnHwepUAMh2kLwFs6J345qkKrNyD/YYWD8Tai4BW7dhCoi4wcLwqPw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	S23Ypuy0OGS8XBsAXivcLj/ePxkQgwzuxbi9kylqQCXqZKFNZsEl3jcUQ1jtoY2tQwUihHDklAB5cEPx6RCKsyBJcnwTkdS+AniFC+bIsw4ZHfJWTml7AYFvxBN1g5czRFMXeY1PuovQz4n6KxvcHx89pWi+XWcoRp8nDZa9/Jrdjr4fF9GC4n8hlXqPZuhDDvxwSzKmC4LRRx42xyJH4d7LxceVjWZeEwKQgNcsDQNjTon+fwU9jfbKvHxcm2Y8nr/+5FB83TFHW8dq+LiNq0LIBSjnpaerdMFC2UaYt/fi+B1d0tfpdMmFBA5KQwmE4E+9ftGbENQ1Vci29SkNNga4Q453SsFalEp/ZpzIGc6lZLbJtXDmQme04rmge0gIssXSzpcV7kQ6Z6wgDHh7TXwF035OhFRGcCO5G5AU0+jWiDfCs3Th88tKWNyTv5cU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 14:07:41.1589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bbd940-880a-4491-e27f-08dea0788477
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9024
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-280433-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MAILSPIKE_FAIL(0.00)[104.64.211.4:server fail];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 260B744710F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On VXLAN over IPsec egress, xfrm{4,6}_transport_output() blindly
overwrite inner_transport_header (== the inner TCP header saved in VXLAN
iptunnel_handle_offloads() -> skb_reset_inner_headers()) with the
current transport_header (== the VXLAN outer UDP header set by
udp_tunnel_xmit_skb()).

This was a latent bug, harmless until commit [1] added a doff validation
check in qdisc_pkt_len_segs_init() for encapsulated GSO packets. With
the wrong inner_transport_header set by xfrm, qdisc_pkt_len_segs_init()
interprets inner_transport_header as a TCP header, reads doff=0 from the
upper byte of the VNI and drops the packet with DROP_REASON_SKB_BAD_GSO.

Besides the use in GSO to determine the header size of segmented
packets, inner_transport_header might be used by drivers to set up
inner checksum offloading by pointing the HW to the inner transport
header. A quick browse through available drivers shows that mlx5 uses
skb->csum_start specifically for this scenario, while others either
don't support VXLAN over IPsec crypto offload (ixgbe) or the HW is
capable of parsing the packets itself (nfp, Chelsio).

But in all cases, it is more correct to let the inner_transport_header
point to the innermost header instead of overwriting it in xfrm.

So fix this by guarding all four inner header save sites in
xfrm_output.c (xfrm{4,6}_transport_output, xfrm{4,6}_tunnel_encap_add)
with a check for skb->inner_protocol. When inner_protocol is set, a
tunnel layer (VXLAN, Geneve, GRE, etc.) has already saved the correct
inner header offsets and they must not be overwritten. When
inner_protocol is zero, no prior tunnel encapsulation exists and xfrm
must save the inner headers itself. The tunnel mode checks are only
added for completion, since they aren't strictly required, as
xfrm_output() forces software GSO in tunnel mode before encap.

This makes the previously added test pass:
 # ./tools/testing/selftests/drivers/net/hw/ipsec_vxlan.py
 TAP version 13
 1..4
 ok 1 ipsec_vxlan.test_vxlan_ipsec_crypto_offload.outer_v4_inner_v4
 ok 2 ipsec_vxlan.test_vxlan_ipsec_crypto_offload.outer_v4_inner_v6
 ok 3 ipsec_vxlan.test_vxlan_ipsec_crypto_offload.outer_v6_inner_v4
 ok 4 ipsec_vxlan.test_vxlan_ipsec_crypto_offload.outer_v6_inner_v6
 # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0

[1] commit 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
Fixes: f1bd7d659ef0 ("xfrm: Add encapsulation header offsets while SKB is not encrypted")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 net/xfrm/xfrm_output.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index a9652b422f51..cc35c2fcbbe0 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -66,7 +66,9 @@ static int xfrm4_transport_output(struct xfrm_state *x, struct sk_buff *skb)
 	struct iphdr *iph = ip_hdr(skb);
 	int ihl = iph->ihl * 4;
 
-	skb_set_inner_transport_header(skb, skb_transport_offset(skb));
+	if (!skb->inner_protocol)
+		skb_set_inner_transport_header(skb,
+					       skb_transport_offset(skb));
 
 	skb_set_network_header(skb, -x->props.header_len);
 	skb->mac_header = skb->network_header +
@@ -167,7 +169,9 @@ static int xfrm6_transport_output(struct xfrm_state *x, struct sk_buff *skb)
 	int hdr_len;
 
 	iph = ipv6_hdr(skb);
-	skb_set_inner_transport_header(skb, skb_transport_offset(skb));
+	if (!skb->inner_protocol)
+		skb_set_inner_transport_header(skb,
+					       skb_transport_offset(skb));
 
 	hdr_len = xfrm6_hdr_offset(x, skb, &prevhdr);
 	if (hdr_len < 0)
@@ -276,8 +280,10 @@ static int xfrm4_tunnel_encap_add(struct xfrm_state *x, struct sk_buff *skb)
 	struct iphdr *top_iph;
 	int flags;
 
-	skb_set_inner_network_header(skb, skb_network_offset(skb));
-	skb_set_inner_transport_header(skb, skb_transport_offset(skb));
+	if (!skb->inner_protocol) {
+		skb_set_inner_network_header(skb, skb_network_offset(skb));
+		skb_set_inner_transport_header(skb, skb_transport_offset(skb));
+	}
 
 	skb_set_network_header(skb, -x->props.header_len);
 	skb->mac_header = skb->network_header +
@@ -321,8 +327,10 @@ static int xfrm6_tunnel_encap_add(struct xfrm_state *x, struct sk_buff *skb)
 	struct ipv6hdr *top_iph;
 	int dsfield;
 
-	skb_set_inner_network_header(skb, skb_network_offset(skb));
-	skb_set_inner_transport_header(skb, skb_transport_offset(skb));
+	if (!skb->inner_protocol) {
+		skb_set_inner_network_header(skb, skb_network_offset(skb));
+		skb_set_inner_transport_header(skb, skb_transport_offset(skb));
+	}
 
 	skb_set_network_header(skb, -x->props.header_len);
 	skb->mac_header = skb->network_header +
-- 
2.53.0


