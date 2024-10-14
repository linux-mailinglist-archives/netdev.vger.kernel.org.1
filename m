Return-Path: <netdev+bounces-135235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C53199D154
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87843B2075E
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2614E1B4F11;
	Mon, 14 Oct 2024 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="B7qodzMs"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2056.outbound.protection.outlook.com [40.107.241.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0841AE001;
	Mon, 14 Oct 2024 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918798; cv=fail; b=LFLFDMJBrG0dAIHTJkv6d1fDYCiYFzJcdZauL/GxDkQTnVf/tDhRDJEQ4CEtkgToXdkIzgRuN7PGZW/YfCThPMzuw0UgERZrreXF36woEFpfezxzBz6ztWU97oeQor3WjVc4d8oq55XqPvI83OQdRnA6N5aSfcR0GeNgwV0jijA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918798; c=relaxed/simple;
	bh=H8HZ8k8sgBQxl39lr1Vh1RDT8rQmjhbNuEaG8tfZdJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KRq5eGDc9EJ8MLQEXv+JAj8zIMtwua7ey4wE0capWy4uUjvk85OSvMMDZBzOTOe75bYWzC4TlBtX88TX6Y07rckNLF9SsLJL1bjQoQmMUj1SzX/qwsQefB0kL/nEGfavW1eD+jRjOL2OyTwoi0+aejxJgxCYvnXllny/f33XVuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=B7qodzMs; arc=fail smtp.client-ip=40.107.241.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SypPQ108WptxfXD0SqdxZlzTBppLTclez3C6f6fA+/KDlUWLCxmxhpEiJpK2Qm/QvxRqeY+w2nEPYJ94wLzEdBBN691Y4FqswcmxnDH+ahoz+zWSX62j7dGjjSx348MV52D7Ynr/2HdCkzpUPgTpP3hPbH1pG7XpA2LzZyet9K+LOlqK5HzrRhrqqvsjt8M67XSHGxI36dmj3bZzGgYxUH4r2q+ZXiBgbIVIXDbrQZxDTda/rQZp4S7a4+iDXem8Id/F+hg/zzGwzNfrZ6EGyNCSqMf7afEOkCgAwePIxvXwj6NLVDvMY8naAwnC8e8Y5oGTYs0/S+IO2mVE5CN6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiVi8tUiW0odjPphqccBtB/TmJHet0QExhsO6ZRjgl4=;
 b=hQxqLpWZTyP+3O01+nstv6TazDvVMdOmRbSXVCxyLsjY007fmO4TcIQqoXJ1WumRwexN9J53OQdcD3qfr4jeqpiTL3yjZ5iY4WbDGQogtG0m3stL1HPYF97fdm33cEEg/A85VeHmOhl7g+p00g6AquBrcwM/+4Qr8bfsCKwJ/lCmDUPGS6cADatSNkxVrrbIQ8oCy/x2ID/Vc5sRoaB/0R251zPqOf89vVznrmjgU6WoEYeDQ8osljytvkFb+9EfS6K2jPO4833N6TRiBHCH3gUtcSyXg7ZmnQIv80NS3KPUDH06pJuHZvPAk9a243qa8mr1KR8ykWuIocN8XNCRkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiVi8tUiW0odjPphqccBtB/TmJHet0QExhsO6ZRjgl4=;
 b=B7qodzMsrWwoPqnoFo2Vp1w+CNj4V7qmz372p14I45HCLuloUVR3RcSRe5NL0h4mAuAM7NMnLYxtV3SCKRv3h6S1sviIG2bHwMoeKmA64P+3tXM/7DFgVU8aDxtn59eBlIJalRajGLTbo9ARhYid2qLkEv/ABvrzyW9NZl4WJRxfr8/c4QMJJDt9wR20v8b1kDvN9LbqSt4l+/pZ10OZC5Hjotaqo1w/ohZQdM6XZI1iU+oXdJ+iu1sgMhlp5AnTwlbsA6l9PHosz640X+nYw/Lh1wu1BDNTKC+qGFBfPvqC2bs7A2ObUhgjOtKtI+XBo5uw4+Ql5sSfY6v6LDMAFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DU0PR07MB8905.eurprd07.prod.outlook.com (2603:10a6:10:316::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 15:13:10 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 15:13:10 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v5 03/10] ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_compat_ioctl()
Date: Mon, 14 Oct 2024 17:05:49 +0200
Message-ID: <20241014151247.1902637-4-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241014151247.1902637-1-stefan.wiehler@nokia.com>
References: <20241014151247.1902637-1-stefan.wiehler@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::6) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|DU0PR07MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: ec3dc677-6ab0-43d1-29bd-08dcec62b71b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?swv8TBdOurM6px9FbFLPTYbk/mcp/2IDB658NLzS800cgP566ObcmssL5/Ek?=
 =?us-ascii?Q?MJNPpxV9a0I4PQAcca3HU4C2mUu+cmsdzWqcW6JTotZowuTzZzcPl8iku0St?=
 =?us-ascii?Q?aSSTNNu0/t92ya8qE39k7ywEh/RPUxkIpPh+n5m48jhIkm58tE74NPaH+Zvz?=
 =?us-ascii?Q?qdbITZy/cEs4vJScnvGSALS/qrwT/i0EQW3Oz6ASaA5ky5Y8tItbamAkF5MQ?=
 =?us-ascii?Q?HhIGmtxCuQ2oZFlaPrdjYetAmTmnrvZ7DyeVv8FL1lt079mC22YIUdPOZ70C?=
 =?us-ascii?Q?9+mCrfxw85z3m9prCjZqs6iaeh5PKe7lmMrb+T3ycH1XvtHGp801PDV2Txfb?=
 =?us-ascii?Q?jIBYsn/Dmn+aoUoQ/cYXxtBZ2X3Wu70yhvdprv4RxosXtYar0uNrsHumHczO?=
 =?us-ascii?Q?cPQKBmIgABEXD2As+tEe1Ojs9ln7pF/yyW4HcSgoPv9uCRT/vXij1+PdrEyR?=
 =?us-ascii?Q?iXgTDxTxIkKEMzyMyP5LMC12ADtKTOS6/bbBxgPJDS6aOHCmuC8yXdfkBrQI?=
 =?us-ascii?Q?mUWC4KmIQExCR4+bbT0ilIJg/UOp0AuLxu+Ikq4CFZpk6RTjo8FM0REZKk8y?=
 =?us-ascii?Q?5iJw10h0eLTKkV1iLMR/h/HU1YhfwA8GPo19GRKVROWxuwvYyILK8zM0LQM5?=
 =?us-ascii?Q?S1VJqiUtjYQIEVvZEIFe/lFhDhLFF19jWHnyUOnjTKHjNxyy4s+pT8A9mln0?=
 =?us-ascii?Q?Af6x23h5+5IAWEAF8WSW/pfvb3NAY1FkkBXRHu06OSn1tZZdOj9AtR0rHBVI?=
 =?us-ascii?Q?BJyguf/HZuF+vG8mbCr8eJJH4A8ZYDIX2SHDejs27aC0U8/DtcEQP+3Wv+2m?=
 =?us-ascii?Q?umik4ZZc5VgpBdQx2NKFKWHrZ7z4Mi+TuJDEK3znefgqtJqenMKnuv16YLjh?=
 =?us-ascii?Q?lvBP0kaBXLB0YGIP/RG7xBB8/4DTIlp/dZB8+sT9CEWgYwCqNWgi/fivY/Qt?=
 =?us-ascii?Q?HVUxeNd3id3iEDCewr/Y93X1z29PGIACEhJBhsMd92YmNBqOJFZA67XA6Sb0?=
 =?us-ascii?Q?izTwssvj9yH8ZGQeAhOm4pHPAgU4jxQg2P6It0HZllDfJkZI4FCMjhNAcEle?=
 =?us-ascii?Q?KKX1M+BkfO0kJIxm88cu8Xcnd9RSNVt32g/zg04yE1+w+6y9gJHCS3glz28j?=
 =?us-ascii?Q?VwSSF25r/Ps2GhZmmcSvaJMZk0vmdBP8nJ3Mk1joaAoHw3DTa/Ok/j6MBggl?=
 =?us-ascii?Q?gInr2llCN0C43ul1doA3KLpjVyGaQzURs08UidBnT7dFNJq22+oa5C/YmjT4?=
 =?us-ascii?Q?YeBAdSIrtWfYf+uNpoVUESAWlWQM7KZD+ixCOTWRJfSHgzHng8zvnPJa+ygs?=
 =?us-ascii?Q?Z/ODXKMrTHBV5Jec/3/59Z3y7OZIvbSbsKGFNAkaU/Pz+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sOfGuPJfElMz3jtosIeaFF4OYX8lvEoY/AFhNEG9sZUXYcpuXD+WZ3whgNSR?=
 =?us-ascii?Q?TxfBEd0mU3KdsuLrQ6aBfiasImAsjTkcf/mK5XgLc2ZcYEcURSIsuNJYQmaq?=
 =?us-ascii?Q?H1UHuZrMC4hQQMFk3OOo/1gcOqC62CJI9DbKGOtqAGfoXdtqzz1+HX/wFQh2?=
 =?us-ascii?Q?N7dQk9kutpr1JcZ7Q43D9sQDbAwGtv1NVqvuOtjwYzzYnqcI+JL8JFk58nv+?=
 =?us-ascii?Q?/IMYejxRvgCAEJ5Woulo5N2Yw0Uax9r33PXddIJcESxluo4EW01fm0tXsxib?=
 =?us-ascii?Q?NedNJSV7KTyDxrT+QJBN7f/pKvxPwrglGUc4iDEbBxCHhFUz/YwpvvFP2g5q?=
 =?us-ascii?Q?qAbjpWdRjBdWFkTynPNFSZrfOyIG3GLPeFXomevJ/5RraVL3FVgMWvNLY8tH?=
 =?us-ascii?Q?RgxDMOc+ZmFevQkNiSJDhTsEmDAq8xRzwlIUmwbCroWsJ+rYnek2nRmx9LbP?=
 =?us-ascii?Q?YeYSN6bzobtTQIdTAlq4Vcze3LfbWDBGMaRtEuqxFJ98bNJsiuLcaDsVNxsl?=
 =?us-ascii?Q?bh2UXZevz/yl3SI064TARWx66qOURG+mUxdXEmaZyPORIIiceV9Yjfa0wx6C?=
 =?us-ascii?Q?CLwUcm7heMkDBY6/zpBEHKPtzubD2usjj+uoCyB/fH9t99FtoJBbIYHCia0D?=
 =?us-ascii?Q?4M3IX1fATVb49a3f4Moi+tbPq2WCj4n++2glcgrRO4tCsMuhrhXbLNfMfpKh?=
 =?us-ascii?Q?pyKWyUB/Q9wrPAVTAFCcsqRet6VyRAG3Hxu4Sxmx88XWm6ELww08pg/Z80Be?=
 =?us-ascii?Q?brNMI2Nq6l9IVjmluZ360iKWAdoUquB/IIRS6un6Q/5wztTEx7TD/uEjw7/j?=
 =?us-ascii?Q?tLijd/YlHc3AaINW5JjhVQVO9XTeeB+LlNjwosJPCaquK/tVNyeDVu3+HUeC?=
 =?us-ascii?Q?W1BbS6VW8tKei1XEEkKYcjXo47L2cJteTMgGi9GjHVEIj6ij61LXhoKabiWs?=
 =?us-ascii?Q?fhqAd2gMdLvBqTvkZkKCKySqQEQdKMLz+1SmPTRl9Qd+nGVc5RtkxZaXZBRk?=
 =?us-ascii?Q?1keyGAP0cUrFagCy5P1pMHHLrhGKIqxf5tleiMFi3juIX4N9onI+73bOnleG?=
 =?us-ascii?Q?36uqV/LKND3T3IX+8PU4qtZyPpvI5z/u3WU0E1BANnplcIhqHwIoXww9BwSW?=
 =?us-ascii?Q?vA4aAqFzxI0LcwaM2QhdyXZLPHGBAsmm/ojoS8WJzw4uwTf+2fjSHyUwy5uJ?=
 =?us-ascii?Q?IX3kSrsyfXA92rrWIGfPBxiIWXMPj6gS4YSljCd6BgvqxI8EF2dmcPqIZ74V?=
 =?us-ascii?Q?fsuf/V2lTvTNrE+lMlsmf4xFU2EytCXu1mI4WA+MfbOP9WtKTwQ0h2EXdHa/?=
 =?us-ascii?Q?BvDOq23xVVMqZIn/f5cIpQvrHILMh/BArHMoNJ3vAYYd/4dlabCFWbsrtqTs?=
 =?us-ascii?Q?1uZ2LcItq5e7Rp8PtpjBZMNBZdVlyesjtZog8KUNbgeiYuQAzjXIg7DyuRMf?=
 =?us-ascii?Q?DheFqmn9KOjFJ8DuMmoHdSfgRP7+Bn2gGr+GmZt45oCKIFfw/kjH8PS71wPU?=
 =?us-ascii?Q?p+ojyvru7RpWwCNls9Gl3ch9Vlmxdat5/P0GgNamQZL+5mjPc21QkE/EAg38?=
 =?us-ascii?Q?lRmPgfrSLD9b4vC43iCtY5ZlTLehUaHmKOzaJYR5mmBlT0NQlkXwVDnPLV8/?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3dc677-6ab0-43d1-29bd-08dcec62b71b
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 15:13:10.3713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rumL+390CUhLL68Z1C0KNpT34sUPr7hylH32Nsaxir1LVAUUE8TyLhGWB3aR1KJWOXPMeeVjM4YjVBYM/MjH3T4TOZLWTpyF1/q87zHdKFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8905

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to ip6mr_get_table()
must be done under RCU or RTNL lock. Copy from user space must be
performed beforehand as we are not allowed to sleep under RCU lock.

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
---
 net/ipv6/ip6mr.c | 49 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 2085342c1fcd..b84444040e0e 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1961,19 +1961,36 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 	struct mfc6_cache *c;
 	struct net *net = sock_net(sk);
 	struct mr_table *mrt;
-
-	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
-	if (!mrt)
-		return -ENOENT;
+	int err;
 
 	switch (cmd) {
 	case SIOCGETMIFCNT_IN6:
 		if (copy_from_user(&vr, arg, sizeof(vr)))
 			return -EFAULT;
-		if (vr.mifi >= mrt->maxvif)
-			return -EINVAL;
+		break;
+	case SIOCGETSGCNT_IN6:
+		if (copy_from_user(&sr, arg, sizeof(sr)))
+			return -EFAULT;
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+
+	rcu_read_lock();
+	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
+	if (!mrt) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	switch (cmd) {
+	case SIOCGETMIFCNT_IN6:
+		if (vr.mifi >= mrt->maxvif) {
+			err = -EINVAL;
+			goto out;
+		}
 		vr.mifi = array_index_nospec(vr.mifi, mrt->maxvif);
-		rcu_read_lock();
 		vif = &mrt->vif_table[vr.mifi];
 		if (VIF_EXISTS(mrt, vr.mifi)) {
 			vr.icount = READ_ONCE(vif->pkt_in);
@@ -1986,13 +2003,9 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 				return -EFAULT;
 			return 0;
 		}
-		rcu_read_unlock();
-		return -EADDRNOTAVAIL;
+		err = -EADDRNOTAVAIL;
+		goto out;
 	case SIOCGETSGCNT_IN6:
-		if (copy_from_user(&sr, arg, sizeof(sr)))
-			return -EFAULT;
-
-		rcu_read_lock();
 		c = ip6mr_cache_find(mrt, &sr.src.sin6_addr, &sr.grp.sin6_addr);
 		if (c) {
 			sr.pktcnt = c->_c.mfc_un.res.pkt;
@@ -2004,11 +2017,13 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 				return -EFAULT;
 			return 0;
 		}
-		rcu_read_unlock();
-		return -EADDRNOTAVAIL;
-	default:
-		return -ENOIOCTLCMD;
+		err = -EADDRNOTAVAIL;
+		goto out;
 	}
+
+out:
+	rcu_read_unlock();
+	return err;
 }
 #endif
 
-- 
2.42.0


