Return-Path: <netdev+bounces-136708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CB89A2B44
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C37287C8C
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEFE1E766D;
	Thu, 17 Oct 2024 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="USnMNFZP"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2077.outbound.protection.outlook.com [40.107.241.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F591E132E;
	Thu, 17 Oct 2024 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186949; cv=fail; b=t5/uHBNVLrJpBMWqjTanp1r0Rx4WCaLQqNjMVuORqIsrt7XZFvBjmPTyl39DngJIqIwC9Go+NensjPVQ5sFM1u8WaDCfoZ9nS6d0HRHnmws4tYmccyHyVjux44EreNW0sd6yNxmOo7ubOelzo84/LyyPR/Rzi0fhyiJ/BnzUPKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186949; c=relaxed/simple;
	bh=lxtjnhc7l4hQrdQRQxsYKC8wR7e/j1c2jF2grs1cCn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SAlwSlLEfEyJcNTQVN+ykl0UmtoqkGqek5dh4y6c20cmgcGXaHy4kMFJ2RJRukr9Ov1H4/FtQrbz1PENyxfQUcmTSvDA9T2WViRdxvH/OKkAvz+34+uwfFKP0tO52+SRpMCaNSe5pdLYeQ8czziOq6BOZOqpu8ZES3k50dkBpO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=USnMNFZP; arc=fail smtp.client-ip=40.107.241.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFX/+sI/NoaDMpsaCcZdCih4J63aNIJE6b2QBaoi+hYk2+w9y5qSb2eTcS/DKD3KuvEShsxHgwH38qM2d3h9wltKhGcK0yvOrA7gW6rITg/f15j+djnYY2na9ej5n/1ZlY4AU17v2y7DMRoHkuec48akRVicXligf078yUkBcQKcwv04K3cRcgUH3F6OambXJ5UvVqhTNbhwuj38ukuZVRgGFOnByQmSa+pZxLRI4PYXgyl8ZxT17WkBLtJxHueGiS6vwtOVC3PmwAjreVSI9Y6YI7aaWREbbhHSLgSsGzpBA2RglJLPBx2x1JEfddzI+0ZSDQQzvUcmapLp9NjP1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuokgqduQgCWV9bbIJLzlimTFKYrKb9Dnwoo8X/5dWA=;
 b=OE3mnrIQYCScUcW2qM0JcbxgYcAtPiQIm7NzGS63U2D/3YhWTm/ZFqfMiantp9JfHcRH+87Ypptw8b4FrZUF0LRTfUx50AMO71gkbGYEHwNTfSAqAHG5EcOok2IFA7/f1SHBDgbOktl3bCCFjDhuRa6oBho1agp7ru557gaVeGA2/8ZmLcp3o0lykTLWIhcAzUzh2up4u75i2u8fsPcR6xGGA7PbH8HnCQBNqOHN/vMIq/doSsFRXUPmEaXLN6jljpZ4+v90YUHxGmsLiENxrcx4fpGM7x0rvR7vSKT7qa7Xm3EKdSrOmOo26bREO3quxA+PHXYggmtqs3y1YJ/FcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuokgqduQgCWV9bbIJLzlimTFKYrKb9Dnwoo8X/5dWA=;
 b=USnMNFZP8a144RCtOjEfPUfyYeqC+ISJ0CovqFEvZK+32Ohv50Qv5X0Wx4CDIfWY255GGDnI1Wf/aJPQF2V+V8i5s6z/gmdKz9LHRGvGui1OIqTZSmUaIMNCCsuzSV90RsejV6EI2/XuCCu2fYlxVdmEXmdpzCEsyRLx+rReRprHJqD4qwZKRcA/AagEPe8pMYwdC+rJP3l3XdCLoRWLhIbBrgAdPZoBsSNnRW/atXVaOfDjUv1HWga8MO7DS95eGtSo3HqoI6C5/18mwiPqrqx4WrXcyz1i26ftu7fMQ7nUfetLgaA+zZnO9XShE5W/tvf2MRkOWoAU4sM7uKuUfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by GV2PR07MB9009.eurprd07.prod.outlook.com (2603:10a6:150:b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 17:42:02 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 17:42:02 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v6 09/10] ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_rtm_getroute()
Date: Thu, 17 Oct 2024 19:37:51 +0200
Message-ID: <20241017174109.85717-10-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241017174109.85717-1-stefan.wiehler@nokia.com>
References: <20241017174109.85717-1-stefan.wiehler@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::20) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|GV2PR07MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: e2127cca-5e8e-49af-02b7-08dceed2f794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kwX8wPYQ889jbjHblMh10EsiCZq9RMW+wwfMhG9dFInna8QStKOX3OF5XR8M?=
 =?us-ascii?Q?t3lXy1nfqEFqJkA4K2+zeXijWRAhSjQrhA3UXzUt2uzCP/7S78A/n5tIT4eg?=
 =?us-ascii?Q?73H0167YCsntrC/SkpM6iJ1XR4LEaTd85kQ9gtgNghurWcrJMzbrmIPHCY4q?=
 =?us-ascii?Q?CvVKhwkRV21mKvaFwTxrdObsDeXfBVuN3Gl6Plj2OSOGh5egDRVqiEDa8xQd?=
 =?us-ascii?Q?49RHkSls4zvt9uIGWQL0c08qWyAV5LrwY/B92xEkz595/4g8l4feBb8ClsE4?=
 =?us-ascii?Q?DMychDh5lxSa2I79xseYDC04R5QIWtgvDrxoLNEtkoSC1A72dDY3idxcVP6+?=
 =?us-ascii?Q?U7kGCnA3XylYglxAW0anDklMTvirtL9U+llSzHF7xX3dzmVwFSDY3+T3TbZ3?=
 =?us-ascii?Q?A04xfpX6GNeRL3cAU2X9A4RE0TAn2XH72goCm+dAHa+qjJoYhQRU2V4Pj1uG?=
 =?us-ascii?Q?jitVmWIWslO7opKniqw9DCuIbSpCuY1MoTTx3JZDIGwCzNZc1aAdHpyIN1No?=
 =?us-ascii?Q?M/JjdvdqyA02T4202CCT/FI9LbnAgW8CgSDmcG7NO28F4fO9W4NBL5VnL/px?=
 =?us-ascii?Q?kcXQVWmny3x4YC58+6bJLoIRgiLxifTb9BmtxWRx8o+tqdhk+xlDNkFxe2R+?=
 =?us-ascii?Q?2r51fA0Ww9hSEdBWYUhMZeYBQnSSH3kKMYHzmLI6MQHOd9NgmGkhIpCOcSMB?=
 =?us-ascii?Q?FMjtTMbhWMhoQk2YrQW6Uzu030wJdk3XxmHeiKg7v0ugu834ZDXGvGjswiWo?=
 =?us-ascii?Q?LDU6cwdwwb2mwo4wLocIYFKI1NqyNYtujOJx/3C9DJd6IXAfIc6jAUfpApe+?=
 =?us-ascii?Q?piFcEsiJ8THQfrabb92qs/Vz1o6yY8W480e+YN/FPggVruNKWHtGfQ6/wyWN?=
 =?us-ascii?Q?UaGW8XqEUtCag+W3NFy+aMTeOPJipZ38nl54r/ffbVe3lALSbMitTNkoSiVc?=
 =?us-ascii?Q?nmUgF9qv2HtJtAmvaheIBf1OFVSJlNMcj26NNvIjIiY4KWAC91VMNQtvV3Pf?=
 =?us-ascii?Q?8JM/Ss24St297GMLrnIef6mnidV41Ra9JA/oKh80bYAMvtxlAqMqIH17+qKD?=
 =?us-ascii?Q?4y+emdtzFYlOE6Tz7uph7DoS3yXsls08ccKuXBjtDGaNdfAbJyo/717De+Wd?=
 =?us-ascii?Q?6mkmWxvfCcvy0O2RrtqvWWAEUk4KrnfuxbSVwoiYMjNoLYqA29q04sKWlQjD?=
 =?us-ascii?Q?JV8JMfuOoqfVMX1ZqgbSd3EBkGekRGHwJEg7CsRwvOd0ZXlsDqJMATo7BuTH?=
 =?us-ascii?Q?oZoXVJH41ChISK4BljRRMf9zvt1vv1S67Bk8CizyTSUrWHDYAtzyDSlDZhjv?=
 =?us-ascii?Q?kw9LH4rq8M1PE/iATBQTX8jWuGWMfTi4ubkFpZWVF/u7bgHxtNOZcVNzJrU2?=
 =?us-ascii?Q?80I98m4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fQbVi0O+/CqDrzC/4QG5Vk4MsxvpfHtWTW7+0tkT68VSWCU3CbzEbsIZVzer?=
 =?us-ascii?Q?qbtb+h5sPqRUj0qpuYcSb1hCwIKEg1MXjrg6JF8CZWB4jTSCmJ81IOO43FdJ?=
 =?us-ascii?Q?11bd5S906gvF8WsDD/iFLAFWsOkL2f8U8XkzVd4ztAbezfiRJLVK9t27vlOh?=
 =?us-ascii?Q?eKF9kbMtela+d13bFVj3tw7Ffi0LywOFwfNIU2PuBZUt5j8nXryesrn8faOt?=
 =?us-ascii?Q?CIjNgWZibAYffmrRsYfP0cK2Fh/EJChoJZvYUn9l3W4h+TVW5cov3UlQkPGl?=
 =?us-ascii?Q?3ImTkoUIDVYVLiny8dATTMG4Q62QWB+xJkoy+m/s8NnVtof/5zpK9a8wXHor?=
 =?us-ascii?Q?2DMZogslTCpbHAnM07Dyc1gBdiKA8Ka9W9lBV8goQ276wrMDhWZ+x1pOcP5s?=
 =?us-ascii?Q?gXTOnPZdNCwJaofYwJPlLj9wOqMK6vMmkwaKGchiVe38IO+9S7BQ0A0qr9MB?=
 =?us-ascii?Q?7OKEMlGTavbURwBX3rZauKkvp4Y3J33MJIRLUVJ9gLn8jeSU22UnAA0KkZ0I?=
 =?us-ascii?Q?yFqjyVoDn0yjQC6Z3vRgzB7Jt/tHTwmFxgprj5g8HWr3E+N8OgB2sLovMmRy?=
 =?us-ascii?Q?WOM8QIQ1qgqyox1wngrtBbsaFk8E1zSTRLfucW6Tw00Z0HUHIXkjsVz5VW21?=
 =?us-ascii?Q?fUM6jl527uY0ZFSlQ6sa40yGwRWkoLqHArxJWDYi8U8wJfjfDlbd3zObM1Fv?=
 =?us-ascii?Q?bX/XJ1VhMZwyxm+fMt5sKB2wD9lAeH+0WJ175R29wZl2T8NLZk0vKhOM8sz1?=
 =?us-ascii?Q?MnQkB0pA/e0uzRXQXLDFCX/k3Qbgxs+0J1qRx7NHG39rkJnv9hGOQ1SA7ZBV?=
 =?us-ascii?Q?GW9WKaKuKrXhJoUln34pNcfHqFJsb1KJG77pJvfP78PbU8gGsLBS7lPbLDmQ?=
 =?us-ascii?Q?6Qs/ddzHQvcjH/w4+FzdvH7ZzbGb/0Fzsf7zCs+k/lrLgREvZ2e5pqs28zVS?=
 =?us-ascii?Q?+dOtkAk7MAXvRV1ruGpnzx1SNf6IL3RnzCCeXF4sPAloNCAWF18FZtA5qv+h?=
 =?us-ascii?Q?u59DRxFhUoeZbPf9t39tuXx8K+xG/1oQcUeVLhawDlqZJAgmSmrZna5x4ov+?=
 =?us-ascii?Q?aMyLBKkXAq0cFH7kCko1QYpY8FvtNQJBGKWJSVhFJosRCB+LZTurVAZfULPS?=
 =?us-ascii?Q?MEX6yJHCGxBjBOTICLpyKoNS+3Sutc/kPKSeIRFoNQKh6MYsP25XfocGuhQ7?=
 =?us-ascii?Q?YkNp3SrbLvOXEl3I0VsgYcbzKSPE9+9E9xZ190AI2maDiDmDCMfZDef0Ce85?=
 =?us-ascii?Q?VlxA3yXOUR3hKS4yo1cVcTbIZ6jUjFecAFF3LbQwR8aITpCBYoiEH027Tw7/?=
 =?us-ascii?Q?EdnKtrGcKX0emrIOt6AVDb7Ec2hfyiRYEq1NXvhOFwWyw52KQRjqhRvs1zrV?=
 =?us-ascii?Q?0tfu8SxC9surhIOkeKwN/4jVDENpti3iyiJBkPfHSqXRnwn8D44nMcidQMWM?=
 =?us-ascii?Q?Dli+vHDk4fvUywGEHwzqQgFeest6DGn0ueWsK5iX5HPJH5PU7QJ3HkxcJJbw?=
 =?us-ascii?Q?TtN4LTNNCvfbsl3m6OMIPL2Z/UsBSrJ8fbUcfIy7+vX/cw01UJ0UVZrlrf9l?=
 =?us-ascii?Q?6hl6xat2ao8Oz44e+riQZgvdPrGBvCjtgyDmx148RS/6Oq0aW2hg9iPDykKl?=
 =?us-ascii?Q?jQ=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2127cca-5e8e-49af-02b7-08dceed2f794
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:41:44.4869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udh2sh8nwLyHBxC89moN6pK0e7H4VyFJBXGVkjdKRyEW6yuRlthG8IDbvrnjbuihXX23UZHO0abwSDD56cWEEkW3EMWRFZhEqo8T4Ol4ZVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB9009

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, multicast routing tables
must be read under RCU or RTNL lock.

Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
 net/ipv6/ip6mr.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index b169b27de7e1..39aac81a30f1 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2633,27 +2633,31 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		grp = nla_get_in6_addr(tb[RTA_DST]);
 	tableid = tb[RTA_TABLE] ? nla_get_u32(tb[RTA_TABLE]) : 0;
 
+	rcu_read_lock();
 	mrt = ip6mr_get_table(net, tableid ?: RT_TABLE_DEFAULT);
 	if (!mrt) {
+		rcu_read_unlock();
 		NL_SET_ERR_MSG_MOD(extack, "MR table does not exist");
 		return -ENOENT;
 	}
 
 	/* entries are added/deleted only under RTNL */
-	rcu_read_lock();
 	cache = ip6mr_cache_find(mrt, &src, &grp);
-	rcu_read_unlock();
 	if (!cache) {
+		rcu_read_unlock();
 		NL_SET_ERR_MSG_MOD(extack, "MR cache entry not found");
 		return -ENOENT;
 	}
 
 	skb = nlmsg_new(mr6_msgsize(false, mrt->maxvif), GFP_KERNEL);
-	if (!skb)
+	if (!skb) {
+		rcu_read_unlock();
 		return -ENOBUFS;
+	}
 
 	err = ip6mr_fill_mroute(mrt, skb, NETLINK_CB(in_skb).portid,
 				nlh->nlmsg_seq, cache, RTM_NEWROUTE, 0);
+	rcu_read_unlock();
 	if (err < 0) {
 		kfree_skb(skb);
 		return err;
-- 
2.42.0


