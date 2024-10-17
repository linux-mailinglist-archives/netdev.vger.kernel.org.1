Return-Path: <netdev+bounces-136707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547369A2B41
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7797F1C21FB7
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA7B1E1333;
	Thu, 17 Oct 2024 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="ryF/GvCM"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2074.outbound.protection.outlook.com [40.107.249.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D1F1E0DF3;
	Thu, 17 Oct 2024 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186943; cv=fail; b=cw5n7XVjwUBaZi/Ymy3tZ/J+S5KB7tzfraEn8IoBGi3LZbBFogZXnfOyIRybtAAFAZ1gLESirt1IxsBnZ2KTnAPQ3iW5Vr9IziPdFZ68XdKHJlUK8Jn7odJZWZyZwfsgoY06VZedb1Lx6SVoL+ETrQxEwUv5+gLQPt5PJoXi8uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186943; c=relaxed/simple;
	bh=bsnji3s7HKifLkl783vHLUc4NahaFWDvZ8mRiX3D5yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gUSIwAZB/6vQC0sXgiPoODMhNkJD2qBkSfIyC+y9uK67UB6k/svelY0nL5dGzE7ywfdMZ8V5rUN7CnbPtFma0m2CvEcrfDhBjw/n4smsLd7wUx85zpirve8chvrkPJy3z8Gl6Dp8uyi/9z8bkzLItwkIxqQys+o9HGHA6x3WGls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=ryF/GvCM; arc=fail smtp.client-ip=40.107.249.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZyDCqU3DDBdSZf5QHbOOzllDXumRwccq33i303y+J2L+fJxKXuEebQUlj9IVhPQtpYsYExHjLhXcB9++bEGanXZTsk6XZvT2Kd3cCSDRWuzsyFVj5m02JF5DkDfpBKEJs3x0Igt0CJNFAlvFv8E7uhaMoEA1RNqpf70E6W3YXiF3NCzHP9pN8gt8KMXrQLMjNWL2kS+JmvIR99tjYm5Tw3FMBE5Mt/dhdA1UjEDr27beTwYPLQFvaSx/18ZR1bYGcw6w3cVZ4eA1NqmU2t9mh4HAXL0OdFOQy+UwytgHKdC0wCZGB6tYzLJf5xxJhJny+5G9ypu4htR1APZJaRe2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RD4rMLTIB3NVr3y185/98BGbBbtVJ/82dZM8g63EPHk=;
 b=yc2lYRnVYLhaO0a2u429ZnUwjF22IfeOT/C3y6BqIu30uge5uoQVvn/pYXf7/JQIQI09zyy2SDg+hZYX8TmWAD6JfpQh+/M4tl15iY0Y7prj55xAS4M2MW2WnGar53Ur/UV/5CBPvPyGV4j/D06OqgMeRtH9a3w+ZwGpg6qsDQW9WKUWzfCq9Qc+Lb8cfGRck4nBAdmuOHW4De+7C3SQaohjOt7otYgJPTJaiBZv2Cj7yjwp3heI+pdqk4NjQBd2+RTnUP5gSJDSogIEX3p0xTVrF113y/kUfQg/SLZ7VpwWQgeDwEpBQ/t2i3Nbh09n4iB7gVZyMhH4fN1+ZlePVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RD4rMLTIB3NVr3y185/98BGbBbtVJ/82dZM8g63EPHk=;
 b=ryF/GvCMlv+NnKPUjaoLOpE3ENiDjHgdBBG5FPSWRSeyn483GyAU9XRmmZP/4HMOFq4Z40BZBTUqMZvgoqwWuKTMeNoQ7wqXpTU0iZRaHxQsEO/pqRXDudED0DjxDgu44XmxCi+B8badeOZfU5gn/XiAIIIv1XLNXRrgXGSf7/ovOZqblcYegTBnn5C1tzp+Fnty/9ALoRAz7NMvr8WCa3B66ecWxBU3k7m009kWriEi1DtwMoVgvRNWs3l5YV7d+qIiKj7tiJExB7kD7yzIs8fom4SVp6fUfI8LNDyjRM3H3jwEnydPmE4PcxLdDz3yMyqW+REWmoOcoKOzjsVEjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by GV2PR07MB9009.eurprd07.prod.outlook.com (2603:10a6:150:b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 17:42:01 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 17:42:01 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v6 08/10] ip6mr: Lock RCU before ip6mr_get_table() call in ip6_mroute_getsockopt()
Date: Thu, 17 Oct 2024 19:37:50 +0200
Message-ID: <20241017174109.85717-9-stefan.wiehler@nokia.com>
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
X-MS-Office365-Filtering-Correlation-Id: f51742a4-531f-4d98-7c63-08dceed2f762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3JZAMVPrwAPRSquMZoKCGwFWgFB9HCSL8or7dlgTXwsPSVEflKjcwJAs4fmh?=
 =?us-ascii?Q?pfsc4bbzvgWax+Jc6QHCdM5jii5LdUZOmKezsH1k7EdcVIzsSC9Y1q0q+Id8?=
 =?us-ascii?Q?Pc7pIFSargk7KUTzlvhdT2RdcFnQw8Mqy1heY4yH2wIcQ8dg9kpiwuqhXH5u?=
 =?us-ascii?Q?yrBCDXEYAh8iCKSc1RKSIMB9YaayLqlMXrAxHrNANAydGKe1SlpD/PYxHguL?=
 =?us-ascii?Q?T3wakbdKtdUB+R8Y113zLIbBN4WUfG4m7a+7w5VzKByQ7Gp5BEgtfERrJide?=
 =?us-ascii?Q?wXSopxw+0eEeX3EtzHU5YPKSkm0VLGbPhczYmVW3NIagPA10PDew5ZMj6ZQP?=
 =?us-ascii?Q?qkaNu/aMkcWoYkxK4pmIhZAqCBzejMkf5hCkejpCDsq2C2ZkmnZ/oMI0xYBb?=
 =?us-ascii?Q?etjbkjrFyt6wibn3Rwh/bDrYIHT0PxeKP8RxUDpNSz9b5Gs+AWOj2+VPAa4L?=
 =?us-ascii?Q?HZisOnibKzOHLNaoW86suEM7X3A/6O+5baCDxciNu/fd0hxAp+iup3KEGO7Z?=
 =?us-ascii?Q?1jP7pCEqCP0UUp5eTGPLJLsjm3PzXg4SNePz73AXHOFcbsAYtgjzhZJgehNk?=
 =?us-ascii?Q?/ajQV0lUj6tU8f6twlb0CEh6lbr9cRpZ1IaGRNekA1Iirv1UXYEaS572Kp7E?=
 =?us-ascii?Q?MdeZGigAAisUTsqBr0BjI6rCc1HRrUoR/WNqUqT17gi52WQDwzglOrFzRlY2?=
 =?us-ascii?Q?Xrvv8DHoBNe0OsdMl9KHzgkA//e9U9hGUZAuQ07DhWkzQ9bbext57gO4P5lX?=
 =?us-ascii?Q?9IzhDTX/8u1m9Cl0z+dUvaldcKNexvYQIws1PVWasK9Wq2KKN3tKxEQhLJkV?=
 =?us-ascii?Q?RpNiA5eeBozG9nMStPx0sftTcV5GApB8UHPzNXFZcdjeUmAzcBezOdIhvp8S?=
 =?us-ascii?Q?tdivuhmG0o7JbzVDZWhQnV8IMhSYf6NWcTy8FrnNh97hUqxoh3mw1ANZcVJ1?=
 =?us-ascii?Q?1H9zyLdrFe+23wNZQHKg/LESJjCIO6nL2ANb+zinaSe+zBC5RR5tp0zPmtY5?=
 =?us-ascii?Q?daM6LvXAP98ceI+wv5ywL+HN2qezTP4Tw0f/6owCzlT0GCu/gcSgrE2WWQzq?=
 =?us-ascii?Q?gZcALtH15++01DXjsqyOKUR3639tfdBMzBqV/CNRleZLVcMTL7reBRdISiWZ?=
 =?us-ascii?Q?V6ksQR3Nm5lPyUGe/Q6aGZtLmhwgAY5/A6FoMcdIq0yRAIuh97mHSN17SMNf?=
 =?us-ascii?Q?3quYAjvMNUZ+suJZzKbQa+/kbpstfT/1DvZy7t8AqZOvaNII0nHjydzk416v?=
 =?us-ascii?Q?9pno6YwHdSyBMDBUWScQDtEusecupoKMVdnzwzhldGfP4N+0pA533rYtkwVP?=
 =?us-ascii?Q?zSTMziKVrGPMPl47ounT/9mbJ7V+dA58GKJDs4ol/2Gnsh9+W7xO+SdQe1p/?=
 =?us-ascii?Q?eedySuU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uGZJ/3nkYRiFSweaq9qoDNajaE0ORTu6arBa+TF0zGALb8oiZlwJhdmqHQX4?=
 =?us-ascii?Q?pwdVufYiFg3kbbI9t0ACx1eos7oZSOifQiXBZBXDBUOUrepZ6pRfoUqopOB8?=
 =?us-ascii?Q?wyS50qMn+7ihfliV+qr3Tlzo3m7P8z3UuvGe7fApj2AlTrQgWznTBghfhux0?=
 =?us-ascii?Q?9ry5JosseW2LEAZC0rJsmfG4xIy/QYMBeYnv9QBh/xwRAAaJjvrMLISPpqnM?=
 =?us-ascii?Q?/Xif0otf3Ql9Pf0QBBCECA0wxsjCO1XoBK4c1IUDSwkHsNZrRB2+pBbCc1L3?=
 =?us-ascii?Q?2ruF4lWTIAEEtxcxBSTfGfJDIRsxdwT2eUa5Crs9YJZ4tWUhBxswUpV8R8hs?=
 =?us-ascii?Q?LX7xVD+wrCoRIQjcWWAWUkGWE+xZnRiXFLxVjmapuXrLcuuKZT4CIFpK2CPb?=
 =?us-ascii?Q?qlGBDdO4iYwluIAj7ZRtCYKlUupNfbCApMW3/SxbnEbDPlxOFFeUmMreOb0O?=
 =?us-ascii?Q?CPTAsD6S8/VFAu+VNThx6NTVVYQam7iN1+UbUGjxl7IzVh+4u257/QWj/2Km?=
 =?us-ascii?Q?VZpnL0D5LSVO8dGhasdBmeqkrWFBVdpKlHriS0mFO2ZvYJ7GecIjhL6E0bde?=
 =?us-ascii?Q?Wzjp9nfT7hgbocUYJSSugTiotC2orx+R8X6XFvb9qflkmua8+UYoXdS2tNxx?=
 =?us-ascii?Q?7Te4xFPeA8ciT0CgOQyg9g2GNZb2dg2U5nAM8nQtdgjcEuhnOgqCpMePaXUb?=
 =?us-ascii?Q?MIdf0Y30xiCsehwvusciGoBZGqEKHtTfGYHmLSwx6u7ct7kb10KbctzgZ6yQ?=
 =?us-ascii?Q?Rl+D9AfGzvlKooVZUmKipDN5VPtAsgYm9JRxhTGHW+aTDlxNIL5SMyutWY3C?=
 =?us-ascii?Q?Me7fnT1zDjMXDcUIEmnylg+9a2zFVqm8AsUCUxLcTK83VM04DF4OrHhJ+jNU?=
 =?us-ascii?Q?0s+Jvu1PMWcNBKbeSscl/8aEbfMB7etjx+6HWNr8no0zz62dvRrUFQIQyUdp?=
 =?us-ascii?Q?sEKYWtJkhA0/7IAEXMquis/Ktj8a00KVsUFix4lK85wVfhTrtd+o8Di9XOrG?=
 =?us-ascii?Q?03JKXtfRmtrAEl0GbhGKxi5ZnL75O19Ufh+txODevj7BhPNBceNjzFluCt6A?=
 =?us-ascii?Q?zi2jcuiEw4Vwkicf8i9oPLg3FXK/XDiqQj9F+RKxuJS1/E9QzWeQfniIO5ks?=
 =?us-ascii?Q?NFp+DAOqx6k1cBz2R5YsLul+/JxpFlM/liJ1aZ7IuvMKKpnzJ214QA6kkXCq?=
 =?us-ascii?Q?8JkHMbZrO/WihX2djKM07yyA06tn4G3BKSxDiOfTLuCUSHP7WU1AZpErqFH/?=
 =?us-ascii?Q?KqcQdm/EWqP4PA6iJIDOvkKlDUw2CmdRoUxI848g9JURxDY2GIIP13DxAm/V?=
 =?us-ascii?Q?bqHPxhmjoEhhR2ND8bsh1d1rQGy4tiPtSZESxBzP2s7XN4LApbe4L6LkHd3L?=
 =?us-ascii?Q?zPrYENsZFJTuAFOPQSXHgZp78wlloIwsAw1O1jqJKO/DU7iJRVz3mg9e1ZLo?=
 =?us-ascii?Q?RysMglc1cXqcha3IacD1fDP9EID9a8wYQTSrlaJ+fYOc4TneKTqoIerIykQs?=
 =?us-ascii?Q?4GvBSzbQWcTLjXnaH7GlNaRKGxqEGgQPsrG59b4/fY91Y4mDwhkGpiZxkjl7?=
 =?us-ascii?Q?p3keAC/c+laTOK6O2IkEPG1f2GuJe4v/JsUWot9pIlI3uUM8RX4O4CWN1S3g?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51742a4-531f-4d98-7c63-08dceed2f762
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:41:44.1694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RWPR+dVLyVkx4JZ6o+GpUsXlOHpgHMyEriD/2wJrWUQxQY9AN5wwT82spkiodi8QBGL/YlyREd11Ad6OJxJfWjZpRhxuEBhLQA0tJ9wIaLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB9009

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, multicast routing tables
must be read under RCU or RTNL lock.

Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
 net/ipv6/ip6mr.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 4726b9e156c7..b169b27de7e1 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1878,9 +1878,12 @@ int ip6_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
 	    inet_sk(sk)->inet_num != IPPROTO_ICMPV6)
 		return -EOPNOTSUPP;
 
+	rcu_read_lock();
 	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
-	if (!mrt)
+	if (!mrt) {
+		rcu_read_unlock();
 		return -ENOENT;
+	}
 
 	switch (optname) {
 	case MRT6_VERSION:
@@ -1895,9 +1898,12 @@ int ip6_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
 		val = mrt->mroute_do_assert;
 		break;
 	default:
+		rcu_read_unlock();
 		return -ENOPROTOOPT;
 	}
 
+	rcu_read_unlock();
+
 	if (copy_from_sockptr(&olr, optlen, sizeof(int)))
 		return -EFAULT;
 
-- 
2.42.0


