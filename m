Return-Path: <netdev+bounces-134505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C04C999E7F
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 09:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B391F24F3E
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 07:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7FD20B1E6;
	Fri, 11 Oct 2024 07:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="rzL0302N"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1AA20ADD3;
	Fri, 11 Oct 2024 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632951; cv=fail; b=orrMBZ28UCWx/lOwpTTFk1uxffiqF+PNu4AXHw1u85c1SYpiSII2YIGW8PIp2I7g/fsD4DiSX5gX7B8dL1dZmWKLWxk0V2X1I2+rIP9O/sNwPiiH4mfNfrHVCwAogcNcUWOYfaDUkHGUySpQ33YvL6Fr5pK9kmPMjZigaIiAU5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632951; c=relaxed/simple;
	bh=v7H/ZbYfUPmdLijyW/7AjMRy/iFQ9cv2Hzvpanhjp/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s5ACvkRPNy+7KjQxLlkWoFnByCTt0GC1MN7bd0SVJ9cAWH7BRdoqRDoPgz57hf7qtOO7J8dPZ1bVBZnk8sMtzV10LdxkLcIOhOCeobuh5jFxzJRQFB57hGOo/n8WwRQu9euyyZ6bE9V3se8qBU8ovXJIiPS61AMacEtFMuTvcCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=rzL0302N; arc=fail smtp.client-ip=40.107.21.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrTJW5vkEuNcqVE1MVZyXEOMM3VNJ+KF0nidd7ZS3TyzyCLmVI56m+XhKTVDBniVeHhbyefiHCkfSG4bh8PQiGEAbWEF4jYeoCmzSQuVah+j3i9c+O0Dd4n5TMUxwmGh3idQ4HynoAkxGU7YCPqJEi3Aj1LGAMsjWfFMfaG2FPaVtm/MKYhT/S+zByg5TbtPSuqjQqb5yEQyBrkIdDOk0qfTBHVW9NJFu2NrBVIi1R51SdVufnD/f7JL3ajg3d+dMqmxIUPanrtOaatI2RSbO9ak+UEBbko9M64mRBRxEf+hUQ6Q2fJQVuR+YxMybb6NRZuqUYMtwiYPlE+5bzUfMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBmCVJFmHLvxtaOHAsoEWu8L3Xc2oBXjKo1xzbnYNE8=;
 b=KvSlye7CHKTyuHH6M3m/FSOLv4SdP8yRfeuaGJD1WLJt4NRa97OjJ3OdrbK/aRHlBWGuwDV7DnWOCOYJ0dY7D4WzIIXY0oI28rTqiquIuYwYmXPYyy506h+8sJo3QQaPUSgHqdm8yATimLfnrvOcyrPe4sqyDUDY+NsNrPRreM8UTpnZCTAKewmSHSK6oQ726DQdtXiDR74+c0tZjNsdlBpaK2Cm02KhbuIePruNUgoJOtd4YR0sd5DLJx6DNDYMVh+geYgFfOjlvLftDwtFOl2NpOFcSiL+qI+sks3DREJELZan+h9er364gKFytDbAk/fWT7dBItwVkXrZLsqJvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBmCVJFmHLvxtaOHAsoEWu8L3Xc2oBXjKo1xzbnYNE8=;
 b=rzL0302NmjAXBNr+lJZpA5iz0fwIbs28bIzHbbd98icsBsgTu2+J9qQaRSSFDYLjVwzr76gJIBCACFDXvtuSiyue6eDzXp1zYGLaH5u79gAmwg1AYb+2zTpHlPFEvHfQh1f6VVsnE9Y1gIJ/Ki3HMquV2Z1uwNVH2diFe0jF11abOXRWzA2f35Qwx1f7FScInkw3kT/CP9S3JOndpuiqZG35QOHPQraBOvo4E+++hy4+WwpBBfKWp/nnTV7C4E4Eyt09u39LfOK5AaTEkBz/mHHEyjGi8yS2q7nubvh+IyLCH51/UrBO2VqmBKTTztKVKscsY+A2K8kfiy7f8L4tPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DB9PR07MB10028.eurprd07.prod.outlook.com (2603:10a6:10:4cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Fri, 11 Oct
 2024 07:49:06 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 07:49:06 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v4 3/5] ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_compat_ioctl()
Date: Fri, 11 Oct 2024 09:23:26 +0200
Message-ID: <20241011074811.2308043-7-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241011074811.2308043-3-stefan.wiehler@nokia.com>
References: <20241011074811.2308043-3-stefan.wiehler@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::12) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|DB9PR07MB10028:EE_
X-MS-Office365-Filtering-Correlation-Id: bea2a1a8-36dd-45da-bf5c-08dce9c92ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?STgPE71u3+mlnRwgvqourM6m1ieoC9c0SzE87d3kNxleKyXcy2/mWpbuSMjC?=
 =?us-ascii?Q?QfVyzKnQLYHy5FaaAhbEsWMNBcIw//d/H+l6NolJKHUGLC27Ne0IVci6wlcV?=
 =?us-ascii?Q?J8gKSrieUsSwLS+92HMuUb/khqbGNL8Qdl6AGVv1Tr+hJbCw91LcvPCxuEbT?=
 =?us-ascii?Q?5EGKzTZs362AID2FvTU8evrQSDnm5hpvaLCXNTRejaBze5beRfyp5snT2Nym?=
 =?us-ascii?Q?eBFsA0Cih2tVKWesaMNGwLJKL6JJ0bjtM5gUF1tzRnNcn7nLYen3fZBQW8FA?=
 =?us-ascii?Q?L9kNDQMRw4q/CJiH/YXWiQK5CPoks5grGVLBCgJgvNDob1UqrcGPfbCJtEBd?=
 =?us-ascii?Q?fNVZtzLA7emNyvdgvG+2xkfa45n9V1hhiUlg+Mzas3Y8l0DLNi6mzp0dsxXs?=
 =?us-ascii?Q?jeO7hJg4KBOK9g+gNJ6SHv6hxgDs+ARcqvJg0YIW4tiaAjr32wEvb0fv++6u?=
 =?us-ascii?Q?nHtnQoYrDpbzSXP5WeoAvHBw1LYTdtsnx3bJHJvBNWn/3p5x4aFnZqfs6c29?=
 =?us-ascii?Q?qFk/4Ihhu/0NfaqATuYyvIOGsW+1IRYNUdxUAH1yMSHa70TZUZbHGSG16WC+?=
 =?us-ascii?Q?x4wib13u7Itwno3r/TH3YdCZpqvcI9TA0dCLDrqk7oss8Ymt0dOiYP6XCbav?=
 =?us-ascii?Q?pRtL73XXj91cblAAYhbQChcV7GEn/Y7/xAQmdgXmSj2Us4TvlDlfFL12W19m?=
 =?us-ascii?Q?4lfC/TJpw2BAT69G1tFJKAKLfscqBs/xbgNyhCijxs757rD/3Tt6QuCr9/M3?=
 =?us-ascii?Q?xN5JtS4gPNo8iJw7xSFPX6Be+OGAvP0tLLm4UvuCkx96OlI1JAD0FL7D76tP?=
 =?us-ascii?Q?4jP6iNBS5ior8p8veRhXhLavD/kpSXNCMnugs55YQqFtVX5tUxfmug7n1N+C?=
 =?us-ascii?Q?JX5D7TBJurOHIT561ws1m/KZuUFsT4immZVOTtr/yp/W5c+CnxExIyWs1Xlb?=
 =?us-ascii?Q?EL2bYW1JOD4oU14qk6OHjcT0jJ5xeyavm0ou7gZZzJFw8LAYk6Zj9eD76ocs?=
 =?us-ascii?Q?ED81WliK98P2h5sGaWNJGDibBFhgNC6AuV3UUMb6U2HPB1sT45Oh6Y/3os+F?=
 =?us-ascii?Q?+JTYCh0H4hTL0DYDjbqqZ3iqArlwNebSCJN60a1mqI8JhEYeEPKbnJKs5mfU?=
 =?us-ascii?Q?Yn2w7Wdy93cBDNMvpnfQ0qK2vlkY4ESw3Sakl3GrNDGQ4v2SrnvwF1rA6KbJ?=
 =?us-ascii?Q?OPYl1AykqlWEUq7q6u4V3o+8MU1MUiZdG+ND7A2rSQWvY+m4DEx+HXmOqJuj?=
 =?us-ascii?Q?56mb6oJq63kQOYx4fH7uiuO3+kVIDg8Cwp1wHNW7uDQyoTduexf2jmPPHRGf?=
 =?us-ascii?Q?4NTj5ik4ARKGGN0ZaFESNrHHUg1SttkO+nD2A9Gp5BMe5Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?brlg0Ubbk5lUZaEGLhPf3MUIVGsP/Tchs7VJ5ViCIJAJjBzb7zSeh3SsYOsA?=
 =?us-ascii?Q?HICUat47CtP8TPRGl31lSjP3i69XAFSR0LI67/KkW4vpWBXY+Q9ZRfOGmtSW?=
 =?us-ascii?Q?aMkTlDe6xQ7WYQVk2eJVbmHu21ji9ESQfWM4TwHXajD3sN4pGYrZNDGxugk2?=
 =?us-ascii?Q?OhdKPE9eGY9T7F65Ey7VKSkN/Sz5hrAgezdMIcJHRwsRWOHAgYEce8p2/RAU?=
 =?us-ascii?Q?rEtQbr3V6IJ2u3/7pMryd5cne39T8PCBBNnvQ+o/GB7/cYNx/YKT1NG8Op9y?=
 =?us-ascii?Q?kR8HQ+brJnA4Ig1mP/PHi0xrthrrHq4qxEpSYBLlre+o7ppcVLJdo2cydA7H?=
 =?us-ascii?Q?QKF1PKDHo1SqMy8mEKouOJgcPaJZiFKha4aqzHRWaq51/ojreypXBF8Onfym?=
 =?us-ascii?Q?L/pXm7BgwcWj3r0A7iK0BPczsQF+PxDmKFTkfh2bqFr/DuniXdSjEikgGm+W?=
 =?us-ascii?Q?uq/Ozu32I9OyUoMiIClUSlsIUWqbK/qxffecFLjqi/SqgIPDwfIgEWd8YuXU?=
 =?us-ascii?Q?tyEngbRbJgaYp6SiKCujFhYi1T1vb3nr90bQ9senT91fB7Dy5UDQulVpa5mz?=
 =?us-ascii?Q?2f7vdIIvTCPdTkvfmGHyQoNemyEVz3YKOtGcEW5omzQ514zxOW/W1Ci3uCWf?=
 =?us-ascii?Q?YnlZx2LSUmv2Wm0IX19Ol9Br6pcvlqk4QG5J9lhhLjkncrKq1m2LMv7p2sG3?=
 =?us-ascii?Q?Qzy2CmnkjPlY6ozrHJFupb7yA9LA1AbUyFy0JWnoUBa3Lok9u7RYTs4bu4ql?=
 =?us-ascii?Q?P80dmCdpaqT+hVL9gAqfPlU3mlOzNjRnmBxB5njKgguaE7hjFYus4blHMHQK?=
 =?us-ascii?Q?ikcaScbDriL5gaoL+1eEQf3sspLRTPn6Hf1uoPNcn4OMyXChR7hVGLFO7ZLp?=
 =?us-ascii?Q?RCnOW0eO0rOjuwlqo21fUqKwQlKhcLXbx3ahjNgCuEQNQKGfH9eWLZkM8qfO?=
 =?us-ascii?Q?CSVMZU3fm4xug8U/1qyWVOlhP08biaGTtXm1Ea0z3WPT2PigoZX1Qua8MAc5?=
 =?us-ascii?Q?PHnDf4L7l/xh5NghW2CiR0XKBZ2voY5qxEQ/3L+W6DASXu54rJZaKC4GrvrT?=
 =?us-ascii?Q?BkvzR+MMG5MmEY7EzSyT7XLw5g75amPUVOCa2NcQe/pijK10lLW8EWZzMK7j?=
 =?us-ascii?Q?TZXmljlZhPKKuif5iJhAt28BXfmYL+cXCL6aprSVN4uSS40u3QKdHaLBv5SA?=
 =?us-ascii?Q?SaqwJzTg0opb1PfRBgRRrSUIEZodvnVxTVMUHFvmebjDiZYqwIDUrPyaWydw?=
 =?us-ascii?Q?dKamS5v+21VWzIQe0uuGhimaVZSdFM/91gZWQ5zaJ1utCDLK43ZDe2U6Yui2?=
 =?us-ascii?Q?P/FtlHG0SYVJo+oyaMqa5CrLajIxqg/EQkm3DSmSZmItA7BiPFSL4MvwM9X7?=
 =?us-ascii?Q?2GO1E+hZNe7bLgiYXTUXJTsJxKlbtLKDJH5py/Fq4kTfino7KkIiovpZ0aub?=
 =?us-ascii?Q?i0nhuGwd9gTN6LVVYZPnKhIcDzoqyuJrWdEYfefh9XE26Yekj4kkGo4AKwtO?=
 =?us-ascii?Q?mv1erQznoXr4c+egeWh10of7uZCyWNcG3oStnVvD3aNPqBFAt9HTD18LozVW?=
 =?us-ascii?Q?LUarv71F7WZBvKT6278z++2wOytZ5TSelFG+hh4m7i5lgtbsvmbklfmNLY3X?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea2a1a8-36dd-45da-bf5c-08dce9c92ee9
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 07:49:06.5282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+ycs09KaI5S0BiU1UK3djhoOlZ3e5l62Eniez9FkshkA4BKtdgZZdwmA+ekJ9FI++I1GwsYNBtx4qnTkn+puXSS871yIXtYN7CZPsGk2YE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB10028

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to ip6mr_get_table()
must be done under RCU or RTNL lock. Copy from user space must be
performed beforehand as we are not allowed to sleep under RCU lock.

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
---
 net/ipv6/ip6mr.c | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index b18eb4ad21e4..1e233ee15d43 100644
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
@@ -1987,12 +2004,9 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 			return 0;
 		}
 		rcu_read_unlock();
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
@@ -2004,11 +2018,13 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
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


