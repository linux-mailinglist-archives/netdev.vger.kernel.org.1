Return-Path: <netdev+bounces-135238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A867099D15B
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EEF5B27232
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8351C1AD8;
	Mon, 14 Oct 2024 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="gx7PNFFW"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2056.outbound.protection.outlook.com [40.107.241.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA8D1B85E1;
	Mon, 14 Oct 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918802; cv=fail; b=rp99c34cp5o52AzGA+r2ZeXnPbEw+EexUYyduuTNYSe/R4GjoCUOD0/3ckeK56gEC5NBeEzEbNDRmu8tVjz8rB/0D+f43eBofxFuQv0mumPwQyAl4eOPvy358kUVJbU8zIsyunU3lb6u268w+bL7drDqKZn2CNDKJ6rQX395VNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918802; c=relaxed/simple;
	bh=bA3mYruUYHF1cPcJztzem+zh0xnfb/LwqJXi2R6yrrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JKGNlz5MqaahyQC8b/c0TJv18JpFwKlMCui/JMCNpecw968sXbKrPKsByNO7MkKGZwisqDqnM7z+xwg3HBlw3w6drVOod9qz9Gm6Hb1GHtko3s5F7HR2qlg6TIeWV0GQQsghv0kLOSJuhGp8KtWt6o02BksdpJwA1rFYdfYHZ6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=gx7PNFFW; arc=fail smtp.client-ip=40.107.241.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDZkIRJ9/4DvgrHIoR8aCdtDONni/sVxyU+EPDlsfNs1CgREjUgkUJTYOE4b/XXi40sIuITDMTgMtoqO5Oc6QnIvLQ17x6FpNMikVJNVZsSG0k9RoD/oVxAOMgRInNys4gENUc2tndZQF5WK8mhZzlTKhTHMND/4VfWFoNzKCi60Mw+e9biDc6GjTXflb+G54FtdriQ2Qnp12hoyM2nC7Tva/vPtZ4H8hV89SDoEuLUCp+53iVRQ3q38sR/jGFzLD/rJeVy1Qa4TJi76YBiW0BiD1AK1bQRzFrP7q3sji/eJrvuShJZTmAQ/RmOjCmPk/aB4v2llZDr7R17Ec1+bbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waUinzHAEBpb0n34fV4DhvrgjqrSi74LhDrjAFG/EhM=;
 b=bWwwvx5rk+tw7FTMNoTsWorMdVdP2tAli+YKz9VE7/z8mgV+iD7n/4ijHC3RN3qzTllb0VQC2mogyUNnXjJJS1/ODCr40aJ7guTuPRTVNcsdqyXjRCA16/0XDroAwxaFOLGVoZUDhb1V4Y93yVeTuKWeBxGE1iml38nt9B0t/OGJnDO98J9wzYwoVG23qyUy9RL+HWcNxmwEUkCxPWdU4BDI3jciwCA8qqqJvGbwQL8QeWAu0jG6EKbHdf/OtDsEqindsdyfOXumnRk7XaS139yP4P1fONPH+yUuS5Ep0aFDx8LNmBmZw1Vk0mJyJA/bdtYW9bnfkpu0hKq/J5OGaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waUinzHAEBpb0n34fV4DhvrgjqrSi74LhDrjAFG/EhM=;
 b=gx7PNFFWJ8fi4GTeHOEnJqlDv6+G/WQW7WVT6iBw2NQSWJDxwxDsr+Hbik4ToEea3F+NAVrQ22z5l1UZsiMAFPoY7EXFg29rZ4/QeMGaxrsbIZXCynJ59EeuTF57M9g96SmvNgS1uP7kHjhKKqh4GckH5o7cIxcgQUbjktiEDAxLMX0WmyLzOQNUB5NRWmaWZkhDUOVdlHN0IKUWxjJRSAQOTrab/sU4k76LVBA/JvE1YXbH2n6BifuaKSII+s9553UTdXSbuUDOsgOFRkPZWMzQnofK8C+fZFbHRgVI+694J7vyFXvsytShMkg4dvJQsV/9kYSv3KFFimuJDCpu6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DU0PR07MB8905.eurprd07.prod.outlook.com (2603:10a6:10:316::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 15:13:13 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 15:13:13 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v5 06/10] ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_mfc_seq_start()
Date: Mon, 14 Oct 2024 17:05:52 +0200
Message-ID: <20241014151247.1902637-7-stefan.wiehler@nokia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 22187977-bed9-4d26-9449-08dcec62b8aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AcBkGMBUK7hETshF382bvQa1k7/Hnx4G+ylD4UGCWEcJE5UTKphp1YJNzFU9?=
 =?us-ascii?Q?sJ9d2EFY61WjnbsTpGAKSmkF3STrxluoVS9zWAE8wJ4RnqJPKTIOBGdjgA7T?=
 =?us-ascii?Q?GLXd7jQSaPMa9ekurdnFvIPUGPy8+rM95+2bLqdIk/Bk8RowPvy0k/qKCjb6?=
 =?us-ascii?Q?8Z+IuygkJQgaSyouYI3Vfl97EcKfvdDbi/+1wwq1kj3YN2g2BUV/o3CARPcf?=
 =?us-ascii?Q?6JlfaABpF/D5J2ZMD/0/QMFrxoZ3X2qwZCE0sAayWrweJya3Fzfx6kVfALnE?=
 =?us-ascii?Q?IHd/0yv6Lrkesyk88kILSwsBAIUXdH2sWFM0XSmK+AL9u1a9O41sLbbWPkGx?=
 =?us-ascii?Q?4lr5C41pcxkZamo83IpUc/gN3rS1KJDc3GF+TOhIF1z5AkwQynNDku53kEZk?=
 =?us-ascii?Q?CoxiWj9+gDcc2iksSnmF5Qpam6kjbmi5CSCk0LxoxtuM3meta+gt2es8Da1C?=
 =?us-ascii?Q?ajXhNpZFO10XhEjaPRLB3NL0KKxDV8bq5pDmTapXXon3DGi83n4hOokDSyrf?=
 =?us-ascii?Q?zEBkax8l5cfDES1wWCo2ww3ZLZFTLIHq4elnPhbKyKfsb6F0lhi3oLJXbJk0?=
 =?us-ascii?Q?LXO40gzyNOq1L0hT/JVSvJtEgo82A6JeRK+fMVEDsgSACEKpYkc13lr8BAzC?=
 =?us-ascii?Q?bE+0udENQmTyQmn6HDwseQG7nHnnwp7JmAcdRwJgBqw9TMtY7i8lTex3klM0?=
 =?us-ascii?Q?/4Zc8jjP7S9yoTc3Pc2USrtX6VYlgEVTr7H7YFgi70vRKwJwMMxHNY+PcSfp?=
 =?us-ascii?Q?lWz8/VjzaU75xStcZKlSZ0E+6c5weChF9Wy8SJiOfKyRIP5/hsRus6MKK9K/?=
 =?us-ascii?Q?ieg0ta4koXa+zXRRIR+oCRmEId+JSSXG/kSzCwOwXbnoX/FKX+zRXQjIJ9rS?=
 =?us-ascii?Q?ziBS5mQ/RaIuGTuz7mdncBfy0aZUCkWRCE8zUceWI/J5dzcK3F4aV3AvU0x6?=
 =?us-ascii?Q?tZUtN0kRhwZJfqJJClwci039HNI5x4hOdA26qRwwWhHDDWUSuWqgEfJrKmXk?=
 =?us-ascii?Q?ODolji0+uaugdw0F8dIItLJJ634OwiaGF85CezQw13gID7f2sHQiVcZacHRk?=
 =?us-ascii?Q?7/Lpv7FiUFIPe6f+i5PPvCMKPkrEQXiHVtinx91Cp5Rh/v2SuBA4hDTC2SlC?=
 =?us-ascii?Q?IvRBvnhYz/O4cFD6X2OfGK606tGnOU/JkrPeLKFcvIfhRXXMiIoze7rwl1NT?=
 =?us-ascii?Q?tHQ7b3VbGEa9CBn/NUD5otWtv4DMlOEYKvXBjgzuH/DSzSsKDEK9uzRR40jK?=
 =?us-ascii?Q?iltxvOkSrxcCTmjFQVTnh6MRWPJGeXDiASMZCfh3JmVWsF6Ueps+04IUi2gE?=
 =?us-ascii?Q?I9G732FfmHu7xFz1Pn56FAW+h/fOAikZBGciV12sJBAFTA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?crxF538O18+DBFY99yF3dGaElpZ1C4LNHkd+5KZLWZBManaoOZ8xXkVCsqC+?=
 =?us-ascii?Q?tTZmWM4C47QZ2Q3Vd56PxducMLbYchOlrpd9O6zkLy9ai23oQ+11hHUK8I1M?=
 =?us-ascii?Q?zMMbsqKXDrroFI+oRbQ2cXWVPhwTyw59hKDEVqOMhzjU5zKn6+rsF1fgYkzx?=
 =?us-ascii?Q?Pgzw6yN+eORfqu13fwuIM+oXWzG2ERzFcUmkfoupkm2717m+wQxaY3qt24Om?=
 =?us-ascii?Q?kn3QVrOhh1PjGTY4EmSTvqvfORjwANJxSzpZToHNlxcGIm7/Z6IHteRdFusC?=
 =?us-ascii?Q?3ScaKkbTuEUo7XhO/xoc7YM3hk/7TOYHhwf3UtiA4dgbljRy6Dvsry4m8Xqj?=
 =?us-ascii?Q?iPj0Ir3x04UrPGBKDTd0zAHk6JtX79LVff+Vy61JVcsJclCkg+c+eKvzsdo+?=
 =?us-ascii?Q?zUZaUKaLbPNMHZJcfIUMvx+wSzD3JzvPo6KHkHvyF7VRks5gCLv++UAuNye+?=
 =?us-ascii?Q?9aXCaHnn1MWDaWkQhPMCa9knt/+nWCE+6vLcjUPlbaXuzL44TalBK9U0AWfs?=
 =?us-ascii?Q?vRhepfWxh9lerbh7UBL3WCFcSOp82gOAKVDk/xfPeUzrSXBUox37VOZcOmdY?=
 =?us-ascii?Q?UbhA7ldhUnbojb2XkpYqFBAXFtLen42gjPninDR7PNAABgtDX0dHljljWipC?=
 =?us-ascii?Q?qElZ2anCVzjmzNBpySE2oAR7caxQnOD62bSORmLYT9NkYvtp943Um7BTqHlB?=
 =?us-ascii?Q?8X5qx97aUbIWuMJEEVEVywjMBQwVEv+LWOmBj+o6aypEGErWgVnyaG3R9kGw?=
 =?us-ascii?Q?Aog4Mopr+xc2g9eC9FsUdT88wurLP3Fn8gImtvD7Hihe7WF6rxx5QPmwSNTg?=
 =?us-ascii?Q?xMNfSKDiojbBElmqjVLt8/Y+1u/DBOSLenSJRfzDhufR1GTeHJ0ce/1gar/B?=
 =?us-ascii?Q?nu4CccPwBh9OoiVoZG9Yki8bPVSlPlHvR/CUNSblWC3ms5aD0POJxUaH8Ule?=
 =?us-ascii?Q?PY0SQF+fQsarIKDTMjiGFFNcAJL4OsJf8ONnbNU0jdSLRPJaiX1Q8zbR7lLx?=
 =?us-ascii?Q?660fCzgNBzltKvglI+8iuk7Y5FywIyDY29d6GTKxPob0f7SApfFBv0KVtVl4?=
 =?us-ascii?Q?EuPqqk8vjX9VkIVHsk55s28dn7YzyyRla1evkTjxWxKt0rAwahX/edCCTwBk?=
 =?us-ascii?Q?yw8wHyfpzAqQ0JgRLemL5h+ZvGpHuooxMm0Y9XqSRQPn+1VAa/u3qlhoIJi0?=
 =?us-ascii?Q?ZilvKhJsktBTdLI3PU6fsOmQi+4kWfplv1zLFCNI87tqKPW+SCszIwf5qwza?=
 =?us-ascii?Q?jhOixQ6mxKrVHyQRwsx/ZEjwHUcRcQPKlru3A8J1fL6sRbQXsyuTtCYQpyEN?=
 =?us-ascii?Q?mlcHbgDpueT/T2v/BNTcFpBqMzeTnnIWKOkCfTCJU6LsqtgLXbUWlVozbNuU?=
 =?us-ascii?Q?UZdjOwBjQkJNeccRw692Su7CHFenK14p20arWnAvCTlQP0ZJ1PYdA42gWqPR?=
 =?us-ascii?Q?Q1/i4Mqrh5dKXpJeawBdGTRZi6/ik5/Ubv1hmve+4Iki6XDxBRaHz/rfDmtv?=
 =?us-ascii?Q?1fCgbYxHQ8/w1GI03+8gniZ2+0Zd2oJpi9xZZoh52V4KYA+1EgShlrahUCrp?=
 =?us-ascii?Q?42s5+MAhMZh/5OdIngOdJXuPFeAqhg2OZx8Ax7km5pwja/pquCz3GU0UUrE7?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22187977-bed9-4d26-9449-08dcec62b8aa
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 15:13:12.9839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFS6zMm+6rSVW4kKhwYDm3pSNJXDlp9W71IwJwnrf8SfpX4DJqNKG/Sh+R03pP9BWEp+PlUvdw3u+STTabBqs5/1zNYC/otmwNSksEZRSoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8905

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to ip6mr_get_table()
must be done under RCU or RTNL lock.

Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
 net/ipv6/ip6mr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 5171d64e046b..ecb9e86fe45a 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -467,7 +467,9 @@ static void *ipmr_mfc_seq_start(struct seq_file *seq, loff_t *pos)
 	struct net *net = seq_file_net(seq);
 	struct mr_table *mrt;
 
+	rcu_read_lock();
 	mrt = ip6mr_get_table(net, RT6_TABLE_DFLT);
+	rcu_read_unlock();
 	if (!mrt)
 		return ERR_PTR(-ENOENT);
 
-- 
2.42.0


