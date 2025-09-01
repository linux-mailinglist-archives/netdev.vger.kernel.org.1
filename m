Return-Path: <netdev+bounces-218654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E12C0B3DC70
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 10:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BBB93BFCDF
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 08:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79142FABE1;
	Mon,  1 Sep 2025 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YIGHweOn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597BC2F83D8;
	Mon,  1 Sep 2025 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715579; cv=fail; b=eM+BXz7tgGDQBDdB4emiN9klfIEY1ocOxRzrcWOap3WFtatTLaAqmeXtJLb2iqcaFIT0Pkyka6bXXChnq3zi5Idud9bVNlqYj2VddQnc89QqSad1NCMgT8DaxYsR2/tS2Q3k5rBdjxTbz58AFq7XB+yOD3ozp6TquBPbcYZo+Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715579; c=relaxed/simple;
	bh=O49LyqE2HcbpDdCTz+OVe0x+F8tsjUELeuz8fuH0eaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qpHS7nN7f6yCBLwVgBJ5Tv482qaFHdgSDByc0JvCegEXdXP2K+bnWuO+jGindf1jKsHFf/qMKBSvsZ/06QCHDRjZ+FWo/pmcdeHGx/veGNOhgKpWBzcVEJ6oKm/yxRL91OojqwJYi3Rkc4lWb6YPcB59YELm7gG/inCw/4/6H70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YIGHweOn; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYbwRnofYPc/EhrtPcirjtaIMG2e0rFimUosp0gzavAwLrKUoc8HdagareLwIWJkjOCKEF+nQm6QML+PBcYEzp6YNOS3EVxkip6SBsax7dUGhKuzKDZFFnzSeRPu2fFjmFoBzItY1gaKyDyo2tbaJtgHJ6lwVTYBS4qOLYOhR+k6bHI/VDWcz9UvFVOIXLV8oNcFNxZ9vWV+6P5UorrLGSfFkZrQS/fSr+ls31vLFxqSyRc8DKVsCHwnoWxWa3Mrxp406Px7AkSuwkn07Ca5Ub8oYQ0w9Wip4oZ5/70cwr7ysCJnmDEsX+HvH/RafbUMP/mVDRrMF/Tu21JBKHudWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ef2wEnbdcaWsBh7sm7YRrOS1zGMdbtYpfglltv4W1w=;
 b=baYDTQaDjlesfIF7Nn4bh60VeU2s9lcD36SRO5rRJiCYD8Lw+dk2/d36QQ26ywlzCf3HnNC180YE56qX4FXh68FObkRWs/UAIbXd7/Lu1JxJWDr4PEKoo55qchLB4BLrLm0QMGK/c7Oxy2yBEk+hUt7aC5wC+OzRjl2Dvf0XIhYQM7rJ3i25CNUaC6wEqs3x618smUm/770/kHejaXjaZz2o3KpShaK4HFwbfOuOJHPmKs8M1Tidchajb2EQ5umlVC7A6JUfZAb+L2ISOswGhRNfWt2ssZe8CqPlNavUhd3+aMRnJGKSJ1BMSw36LupjgIS9/x+dqF1QI9NqRlQOzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ef2wEnbdcaWsBh7sm7YRrOS1zGMdbtYpfglltv4W1w=;
 b=YIGHweOn1ePPwp7BVgalB7Bkzil/YWixoYTxG2QplYHXZUI/ZNANr6uK1uvJRQ4CG24nRCh4SPHij+E8p9UNRutDJSNC9Ya8HC9g994zaJ0tD1yVf2lMSWJisXJzxFFIhLVTdwh1sjAEoYqRbUgM8a59nKJqgDE9oaR3N2kE562YlJwLcyYKzDBmybdvJ1vQog0H4BxeMDP9RvAaWrNnw++AccyWKX/BQkoRPk9lVj5UPo4yqhfGfR8Ob5cP7+fnvOHFkSbPgjzsuLLzj/zzw462r1ib3taoLnAVCBZJjGAf2i311InC+8zVvSGPoXN8jX6GHixOkJult29pgedBcQ==
Received: from PH2PEPF00003847.namprd17.prod.outlook.com (2603:10b6:518:1::64)
 by DS7PR12MB6311.namprd12.prod.outlook.com (2603:10b6:8:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Mon, 1 Sep
 2025 08:32:50 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2a01:111:f403:c902::13) by PH2PEPF00003847.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.24 via Frontend Transport; Mon,
 1 Sep 2025 08:32:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.0 via Frontend Transport; Mon, 1 Sep 2025 08:32:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 1 Sep
 2025 01:32:28 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 1 Sep
 2025 01:32:25 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <paul@paul-moore.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>,
	<linux-security-module@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 1/8] ipv4: cipso: Simplify IP options handling in cipso_v4_error()
Date: Mon, 1 Sep 2025 11:30:20 +0300
Message-ID: <20250901083027.183468-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901083027.183468-1-idosch@nvidia.com>
References: <20250901083027.183468-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|DS7PR12MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a7c0d86-fefc-45ae-b303-08dde9322307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6mZHoakeE79D6h9ffQAXJrnBA0hDacsW/FQGSaf+DBFRPLkErTGNhMG8wvHH?=
 =?us-ascii?Q?37tIrLHvm+RMjIW6PtZ9QOLg/dgFISV70ubxMquLy1txYE6OYDTV3rEIZ9+j?=
 =?us-ascii?Q?gxWI7t19SlUF9rLkXX/9kk237kVwC/PAQnntlD2n++qjppB33qoDw8iE2bbt?=
 =?us-ascii?Q?55CwtK1dCnGx8XiRJA9d4jvJZydiXAYGtmvyYVQ/bY/sJxmNvXIwZpVVtQjD?=
 =?us-ascii?Q?lzaP8hlPRk2g64tD0mx5MakoRavPOIG6d9JYYtbP834pYH2eiICSGV4X5HSe?=
 =?us-ascii?Q?l9jgzFdq0zX11kzQCjRh26OySSO2qvBZ/M4nZIDwczRJB/84A9Q/Ug+/KuNx?=
 =?us-ascii?Q?LV+/oQ+kqnRYumb5JYvqpdDARfry4sxkgtM40SK3SejPcv7WzTaEAr8v53Mg?=
 =?us-ascii?Q?ZKC7prk92JD/VWFoIhM6/r/dl4pIDoQ/00SyblZC8lC7JMVsawaFQueZeSO1?=
 =?us-ascii?Q?0PjoE7nrZNCJSiyn+/vSZ8lHRkSuwVEoZMh2YGXVyC2Pt/p1Dm/p29+Lt4Kn?=
 =?us-ascii?Q?TPk51pQNXkIWzxCoqXxR8gWXFMQ4qVypA44pjumO4XpMnLk6ZQnmzzoJmhyS?=
 =?us-ascii?Q?zWnmUfcHegboSAxh8OjSTq6MYoxUyJHe2AM+s4SKh09R13Zbeq2ttH4owiKE?=
 =?us-ascii?Q?BVPt+CmuVthu6iHyQJnoV1ABB1wtRE+Fsj2feMIfxB2jTU8B1voq9FJb48bd?=
 =?us-ascii?Q?fD6WiS5TGjBDYa0JfVIrTEyMHosKpS4RXGoF/k3mwWFWXwmHcBVkni1urvQR?=
 =?us-ascii?Q?J/AMcWq4z89Fa+pT82Pc0IL+N4fIDmhun588qXvAJsPMamZ6Si7dmES2QoWS?=
 =?us-ascii?Q?14nYk8KwkPd/4IaLVw6qd0tRb+B1erP5XqSwQY6mKEMi7MD5KaEeRdk5FkEL?=
 =?us-ascii?Q?bjTTMVVdmUFzReg1672/ASDYYCEeXyeMOH/2Mkr94C6Y9WH1y+tOgKWDEWsq?=
 =?us-ascii?Q?yTxxA0ikqarfxOYNIRSGgSjNrCrrfGM37TzvPpgBYaHcg2a4vYs3kEOGgljz?=
 =?us-ascii?Q?age9iV0FytaFgt2wEtm20HvzwqIF6qY0XrR88zevc5IM/Q7KVbKijMFTVEKu?=
 =?us-ascii?Q?ADsQNtee0lC6Kf5wO6MQgKIF687aqD8/zEO4Zh6SVPKvlqVdcdCXOhiBq4s1?=
 =?us-ascii?Q?8FUqAVdKy+PBAEqkE0bertoaKjqTBlSqEoGI8/xX/cpXdWgYQE484210huWc?=
 =?us-ascii?Q?5yyFVgYIoIcIfdkKpZUWTkA356s1CVIw10fecz4lbAd7I+DNrfG8rxzmo1dP?=
 =?us-ascii?Q?Pjg0viaqrbIwWGfA7+zv5EpKll7nx4X5Fu0WQRy6gAHXzUBoXg3Hdzcluv6q?=
 =?us-ascii?Q?+MkrFY10Q07B3iGONNPHGyyg1Yz2M9JAnuoVedfAvEOfUn7UG3gM2burdIF+?=
 =?us-ascii?Q?Y9MGXP9aR/e7E3JjBn/Vz1qm/hp3mjv5M4g0tavvTUM2cTxFY8B7OqHCjfgY?=
 =?us-ascii?Q?I1P9KH/N1OLVWKopGnUZlmVj+Sbuhi7L1zgAtmeaYPMZwDWX1NaQTkhdrT+G?=
 =?us-ascii?Q?lP3aBCNSUQULiDqwISmBMa5cFq+t648QFCAb?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 08:32:50.0494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7c0d86-fefc-45ae-b303-08dde9322307
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6311

When __ip_options_compile() is called with an skb, the IP options are
parsed from the skb data into the provided IP option argument. This is
in contrast to the case where the skb argument is NULL and the options
are parsed from opt->__data.

Given that cipso_v4_error() always passes an skb to
__ip_options_compile(), there is no need to allocate an extra 40 bytes
(maximum IP options size).

Therefore, simplify the function by removing these extra bytes and make
the function similar to ipv4_send_dest_unreach() which also calls both
__ip_options_compile() and __icmp_send().

This is a preparation for changing the arguments being passed to
__icmp_send().

No functional changes intended.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/cipso_ipv4.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 740af8541d2f..c7c949c37e2d 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1715,8 +1715,7 @@ int cipso_v4_validate(const struct sk_buff *skb, unsigned char **option)
  */
 void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
 {
-	unsigned char optbuf[sizeof(struct ip_options) + 40];
-	struct ip_options *opt = (struct ip_options *)optbuf;
+	struct ip_options opt;
 	int res;
 
 	if (ip_hdr(skb)->protocol == IPPROTO_ICMP || error != -EACCES)
@@ -1727,19 +1726,19 @@ void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
 	 * so we can not use icmp_send and IPCB here.
 	 */
 
-	memset(opt, 0, sizeof(struct ip_options));
-	opt->optlen = ip_hdr(skb)->ihl*4 - sizeof(struct iphdr);
+	memset(&opt, 0, sizeof(opt));
+	opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
 	rcu_read_lock();
-	res = __ip_options_compile(dev_net(skb->dev), opt, skb, NULL);
+	res = __ip_options_compile(dev_net(skb->dev), &opt, skb, NULL);
 	rcu_read_unlock();
 
 	if (res)
 		return;
 
 	if (gateway)
-		__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0, opt);
+		__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0, &opt);
 	else
-		__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0, opt);
+		__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0, &opt);
 }
 
 /**
-- 
2.51.0


