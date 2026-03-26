Return-Path: <netdev+bounces-272237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBOKJQiYxWmK/wQAu9opvQ
	(envelope-from <netdev+bounces-272237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:33:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1438133B75E
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF2DB303A48B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7B733EB1A;
	Thu, 26 Mar 2026 20:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gd8DUgy8"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010058.outbound.protection.outlook.com [52.101.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73CC1427A
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 20:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557187; cv=fail; b=CizK9D33STcimNq+MsPtSL7ujIck2brOmMMA+emcnhS2WF4C1R3TjQKxnN0JbqN03ydbgmdGQFNa95k20ZGu+HlddIXq4QXla47LWUw+srW+MqkFo3/jxvd+iNbNct3FdoPJlX4FqhLpM9wKWH5s7eabTA2mmReDPpIrzXWbgWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557187; c=relaxed/simple;
	bh=W/S5zgRx36yqOkq4D01ePpb5SppPxXPkESukes0W280=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HHAeqLOaPzQA9uGG+E9zJ+hNFWh3hxHapb8BzlBdcPjJh3BKAxMgrRwdj9qB7Rs4KAZDzBm6Zr9zfY9C3tFJo6F1BdkAySffZpXcaIB2AzoBmpBjNjlmV84kbx68qskR6qas+8SlK6jEfF9Lcr5oY1+94jC35T2J688fTl7Is90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gd8DUgy8; arc=fail smtp.client-ip=52.101.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRXKG1bzKqBx+WLHhLdwRpMWaASAhoc/v/gK1tROpYMREx7lKhrv/wVejwkvIfM8SjIglK3+8P23/Ft4fDL/AvmBHUb5IexVYW4hC5zedE3ljl2WIO3nsExP0TPDDyO0P5dmoQNmhJDu0nBcs55aVPMzuEBJRiqc39DCAqhOPpKBnrT4Id4ewt260+zc2Kks2MIhAZdIsK4G6TPBKqxbeHQfkDUcGL499JcwbKyhRuMjWGXLdZdvlCLMpUFp1tqE7zfC+m6CXeOPcMk3e7EZTGWnta+0+TSp+eu5FPq/trwPzb2FeJQpEjX6PdDebV+D1wK6xs+ovEaN4888C+e1Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQz7ldQP58HcdLwNpAOjIbL0IivxdPLr/Q0v6yE55CQ=;
 b=v2lB5Po51iyuEz/lODVMpC/DcYSK35I67+4Onlhx1Gvn1ByiNegMdlpIsyQ3UkO9rGnyu8EnieinVjAq61UPys00FrksL6N3JMmNoSw7w1gWizqi6NIEheYJ3FZ+gIE8kEi9t69rWnGmA1PeEwGwa5RwYdIJK+dQn/1hs3D6H045jR3rdhCAwmcKW4fexuztowjm7Q/SvoSUzPyIC/B1pcvA0P59oLebD3j3IFmsZcx2iHJa0JYTTQqZCeqr9nha8xYAFhh3Pu5pOIcCSVpqHdQCMmfbDIXA3D0eQZspB05gF9MQYT9EIGEaAteRq8qjc47jUxWrZUr+Z52xLrVvIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQz7ldQP58HcdLwNpAOjIbL0IivxdPLr/Q0v6yE55CQ=;
 b=gd8DUgy8Nq2a9jgx/RLdO2kplvZGdCavK20pCgpONJdVEnsobgU9VdEWwy3jC7wJYdsq4zZldRKpWDP06bD7k/zOugUVbQaOZr7LFiIEMpT4NQQzeCFwBS8u9sKlHoBGzO1tXuagST3bCvnTw9rFVy1rqp5foVR6r+6Ezn59Bi+rBEI2vwljFVrDMI5ZEiHDXVEpmZftgxT7/QEOFe2BH+qwFerH6678NK2srj0zVsEkDhMIydVHlhevbVp5+n+1HNId8pFnSXtmiZtBPAkqSBcpIUcL97xcdUSI5bEwvavuOsWpr5G1J9N+5tlmwlnZCuxXq8Q3gtKPTP0GCD+w/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB7770.namprd12.prod.outlook.com (2603:10b6:8:138::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 20:33:01 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 20:33:01 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	andrew+netdev@lunn.ch,
	petrm@nvidia.com,
	lirongqing@baidu.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 1/3] vrf: Remove unnecessary NULL check
Date: Thu, 26 Mar 2026 22:32:31 +0200
Message-ID: <20260326203233.1128554-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326203233.1128554-1-idosch@nvidia.com>
References: <20260326203233.1128554-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 766e3c9a-f6cf-4933-3f11-08de8b76e00c
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	578JLWITv29GUpdUJ8sKVbpufY7jWc88WGQ6gqiUvt2FtDt7bu2VeydwhPITrrmdf3xhrPr9gPUT9SJM2F3RHlqp1g3KXa+0H/zJN3mYGXrgb4dKhdlG/DVN7truHGc4JfuoJ4UofSM3vwcn3qxkHXfZURKFquqZWZUNdDQq5Kr/MYgRD6b8LO/9Qapkell+cvyPx8VZNxar1WRvjTl4p075g9QRng2ngEn6xgoC1+iTq+IJzZ1mTu9j1jnEbEYxuiRN55pZke1sfHk9c3/bp1eaa2D7uPJGWCTBmDvWD/ukRltEqe5BnoKJ8WWbFRWQvvXv52GNmI1reqDCRZYYUHDKib5eNg6AZWlhXNo4RK0jmmyAif7YatZIT46oj+9IY90S/+PN3AkZW88RFqSURkAfZbd8iiSJHI7MryHSo/aVRnPdWPEuWD6sLUFHend7+5D7iFQjv4/AvbhqOr5YQQEG0WslhmyoumHsX02mFkaVJaesYuZiQiN+0vaCo8PUmxiLwLgrD0ViT4lxNcKUoom9CUnZrxSR4b0M+2F/10DtYvTgL4HI53LXqXsoeqGPBKVSatPxOgTPEa5SHEQzLKqxdtAA55rPBG9f9nb8s+ZDYfgjDGD25n1jaKf9RuPBGmwAhtNtJxJyjR0fHrCfp5YLTYhdugUxgW5SZmrGgJebRm4hSSlkdg7puVT6p1QewsEfCHByMpn6BlknEnQTDS8FbaNj5ThS9sVl26wr1dc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PM1OXcjoFDOohTUn14XNStjVkTPoZx0v6SL6l+0HPOW4JnbHQoycd8Rr7N0R?=
 =?us-ascii?Q?jLyI5nQ5tgeMjfA6P5VGnf1aJDuvX6O2qL6ok0SP8QpEUNtMDOmeaAt8p7pp?=
 =?us-ascii?Q?yr87d91dfF5UuCV+2XmDK1II3deI/ImfQFufsHPls9qnVj4H+voSeIYg1tA2?=
 =?us-ascii?Q?inguhlrUr/got7p7ixtftar6/suOaW3JuUQKbnsJ5KDjeOWL3hYSBf37HuhA?=
 =?us-ascii?Q?yqRQTYt254YFiNJftoP/5dNU/bpJoc5OlLxDGdPQnKQTgKTyHtVjD+oAdPUD?=
 =?us-ascii?Q?IooZkD7MpxF1ZymJb3xIebLuhgpmSO/cNitHRUC+YhptGll2OilrfjIee6TZ?=
 =?us-ascii?Q?EhNcz09dc72Yt+EidLyO9gz2ShjxO2Qf0tHJFn1jjIDcYLukc5LAyKunAW59?=
 =?us-ascii?Q?3q358Khd/OO0GG/Bw7pQfWQvPr+VaIBpqB+PPl0Bwg1hstBhyqjkvXBSCF05?=
 =?us-ascii?Q?FHOYGx/L3r3LDNEBqQqSDd6K/uVFtypF0MYwOIJpygnxdywhaceJOE/UhfoW?=
 =?us-ascii?Q?Sb30GNWO1aseKlYd5TCV5BHCu8WqFlMylWSi2SZb0cunHwkS4hpXCZjlAUxA?=
 =?us-ascii?Q?11hLHiXpqQ4eNhGQzCD2WB+VudjGTFCKh7l6in3zJv5GZtS9R+Z6QaR1pPrd?=
 =?us-ascii?Q?h4Ai0kYXFZDl67oreVz5v40KZn2t+6HoS5NbxB5IvpURqPpwHKdWe0jq9hKH?=
 =?us-ascii?Q?LJ1Jvd/Tw2O+Vg2qaAloWmYA/RxMHdp2GPJwsrS2uNAngC6vCAEQoZVvTi3f?=
 =?us-ascii?Q?stNMX3/2qQ5Duqy79jhQlbPR/sLRtIZ74OFXQIQnfVUEg28PDhxsdUXaWJdY?=
 =?us-ascii?Q?MpYPpJW2TpChZCWvpXOe2GUfXB50t+CZg3mjSRlmmgUzydiAeqcHMztT+UE2?=
 =?us-ascii?Q?vWMq7d449yXjlOqi5vbP4j7Jmjoql7c6V0JCcbYc7vU6ALnDsdaHqdCZwMSB?=
 =?us-ascii?Q?G5vJQt+ddnyq6SDxSURdKI8YjpbKGqYZf3c67/Kh6iKeryaHEUG9Zuy809NN?=
 =?us-ascii?Q?g/vZcPzHJWKC6iuY7e+LnHjoA3RzKs/Mx3M3hc1ZV5TSMq4wqdOW7pKqGAoR?=
 =?us-ascii?Q?zXymipUxjVLN0BJYVtWYh9OBMqETNyPNQ1FQALvZcTY7N9lf+NT+7j46zAvM?=
 =?us-ascii?Q?eV5PIeBz+xHKxBjU388umLhr12Cy25KQaUPl2UoipuCc+4XSIJvINucRX06w?=
 =?us-ascii?Q?ynxgz+kCh016+/i77uCkGp9p5bpH1IjM9oijvweeSIHhgmzVS9G3J0hv1rjH?=
 =?us-ascii?Q?0FQQKX06Cd/fw0PMJKea1k/rjPoOuC0kx1BPNeI66fIZ7u79HyYSiqubTT0s?=
 =?us-ascii?Q?zwM6Uxwgbrt8ArscqQS8AYBOk2n10S8XG4bgHBKPd+kqI+KkxoMUTLKQTumI?=
 =?us-ascii?Q?y5tWblz8ljXp2sOVHq0+ukJRTncSIBmq9k0ORqaNvY8yMlsFguIuWhGCWmT/?=
 =?us-ascii?Q?nL40kg+McOC2wz6t3EzOVES77NlJRDVdW2k2g7NLrBZYgijaqggqLFBnQWu3?=
 =?us-ascii?Q?Klohp1RaYpUgmoZSId7uNiwLK0qc+o0vP9lAbQwJCx5ULxiM8jjI9uUKeqAC?=
 =?us-ascii?Q?4AFaJYq9ui2hf6Ha3uGcM1pNvX1GCEMK/nACLtul6A8Y3V1ud00WER96ieeS?=
 =?us-ascii?Q?6+H6YF+Md6SWbJGhEwp6HpEa89VVB2QseLIXZOIN9j52O3Z09kiS+CdHUXi0?=
 =?us-ascii?Q?MODr87ZbhOGX6RhbcVoblNV3TRXN5K5lXIVGJEumyFWWoQ7tUH+Al94JWiff?=
 =?us-ascii?Q?Jv0leufR0w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 766e3c9a-f6cf-4933-3f11-08de8b76e00c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 20:33:01.6858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xLNMu9OZAtZlKTuxGQ34xWouX0tTbyt+jO4MW/zcatz9mqTAjSwMtKENocHuTv75R+a95BYfjPFA9Tyy87KPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7770
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272237-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 1438133B75E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The VRF driver always allocates an IPv4 dst entry for a VRF device and
prevents the device from being registered if the allocation fails.

Therefore, there is no need to check if the entry exists when tearing
down a VRF device. Remove the check.

Note that the same is not true for the IPv6 dst entry. Its creation can
be skipped if IPv6 is administratively disabled (i.e.,
'ipv6.disable=1').

Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vrf.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 8c009bcaa8e7..0952ab6a2571 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1007,13 +1007,11 @@ static void vrf_rtable_release(struct net_device *dev, struct net_vrf *vrf)
 	/* move dev in dst's to loopback so this VRF device can be deleted
 	 * - based on dst_ifdown
 	 */
-	if (rth) {
-		dst = &rth->dst;
-		netdev_ref_replace(dst->dev, net->loopback_dev,
-				   &dst->dev_tracker, GFP_KERNEL);
-		dst->dev = net->loopback_dev;
-		dst_release(dst);
-	}
+	dst = &rth->dst;
+	netdev_ref_replace(dst->dev, net->loopback_dev,
+			   &dst->dev_tracker, GFP_KERNEL);
+	dst->dev = net->loopback_dev;
+	dst_release(dst);
 }
 
 static int vrf_rtable_create(struct net_device *dev)
-- 
2.53.0


