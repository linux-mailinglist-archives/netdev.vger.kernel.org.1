Return-Path: <netdev+bounces-134130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8D09981C7
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1561C243E2
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 09:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6A31BE239;
	Thu, 10 Oct 2024 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="mgf30k59"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2085.outbound.protection.outlook.com [40.107.249.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC9B1B5ED6;
	Thu, 10 Oct 2024 09:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551551; cv=fail; b=AeTM+c+Vsi0HB5fSXWiuqt+XikxoJ+TBP3WrdDQVFxPO6e9OfbM94iJQ9aMfuf0rna7yXc2LEb6Fyr5Kx5ZKovEPnEEGwgd6E9Fpy1waYbZAl0IcZAZuLBuIW8qIOa4tvlBSABbLr2V83Re5730/FUlblvdo2p9TDAjpMxP0PK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551551; c=relaxed/simple;
	bh=oWJfv7n0moS66M5NUU6/0w6G92QQlvIRNK6fSLlXeBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ph0a2yQyqb67rgfBqQU4zbz5Rvb+ZgcRNAVGb1o7Gy3X0NMVPwGBHNYJSayuUt93bEpKeYyG/ADMcf/Hx0s9qcVbqzk276tNN78ecKeb1F+zXZRHiRBhgTWSYr7OAPV+By5V/ODfHkYrDDN0fhV7wZ2qfPEbOFNZu9nNMppGPug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=mgf30k59; arc=fail smtp.client-ip=40.107.249.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0tCDoLCCxj1dNdyxXpfmcduMWTIZjm8GyOiV0HNQemZvj6WI4h6EAkx4AyZh/bZxlX9FS2bvkYd5Zom5eeDFTWFiN1QCoRbj1hHfuqftgesaL9D15ETskArbDdqQRShGZDodi4MfzfZDwv+JXjz5wdrQMNTdIXgnP6F3wKJtqZt5HxMHf1MccuC4FQgH/iwguv0SIHXKmcKkzpEpXy1wxZ7F+3EUw2sUR63LKjWATrJ9rhPlu8ubpforrBk4lK5Y2pQ4uG2cLpRh3KXN+FnqNx4ChNzsKlYyouPmrlaNmS29748sGu6YpcargF0tryIYIHUtsUXkHTyyC7RAfqHNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQaOgy/+o9lLTYAKrT+lbChtHdwIEenLzXIFZDT1pnA=;
 b=x4g8UriJ9rIoa4vYRsbf42trhY7nCdF0ume4LEKoXgOjAUwBsscrFOnetYuUlGQznHvvm+rLmXSQ389+yOcNwIHiW/+6s/zKKRf7yYPdf6eiuuTLkv/0VS3rqT7zYscn+NHupagmF1RqZ8qHrqbtL53E68XSEzbAaAwnB6a2xu9ZE5fTSMO1nf+K4jc3yKvI3gAMCuJsqEcYdz7YFhteQqFeBUxzXLvsjYnkBcz2iEra0Il0soPR60c/UsaWkljrT/jEu91wAMfJ5Lln72u0heMJ+AIXNGIdMTYQoo5BeyQGLKF7ltnmTLlp6yV/HMIoo169VaJtdTU0DR1A7UsN/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQaOgy/+o9lLTYAKrT+lbChtHdwIEenLzXIFZDT1pnA=;
 b=mgf30k592FFsZ6yCT+Kiygck1QuNTwSf8gpEYA6Mwle335DVuPgMFIx/Hc06e/zjA+6O+qxtWwTT6IoZ4UBUFclDeRb5i21usgW+EroPYioOYYsiWrZB4tuk4OEYS9rL2OVERkulKqPyEqwwVcdhkIHSvWWwBmefcZlq4M+oCWWTutqyx3fgIxkhhiytCw86UC4t67jkwFtqmGdNUlgaAt5Xjo4aOJ/csX4yzHei7mOnFJclHFdrDFmDhoLbaAPZZNguVJcSlvwO0Se+WKAGqJK2zdNYcDroZ0KOqBDNqu4bZA0YZOZGF6C/qQUVm/dnewpdjm4IzVxWuquIYvBHcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DB9PR07MB9768.eurprd07.prod.outlook.com (2603:10a6:10:4c2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 09:12:25 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 09:12:25 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v3 4/4] ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_get_route()
Date: Thu, 10 Oct 2024 11:07:46 +0200
Message-ID: <20241010090741.1980100-9-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241010090741.1980100-2-stefan.wiehler@nokia.com>
References: <20241010090741.1980100-2-stefan.wiehler@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::20) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|DB9PR07MB9768:EE_
X-MS-Office365-Filtering-Correlation-Id: e89bdbe4-93d5-422e-8532-08dce90ba7d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+hPWKmyeNOVlsRfih2lUWqLu8EGQb0DvxnaD86ETOEcO2yHY7xJMFWpkbLNW?=
 =?us-ascii?Q?rvt+Q2VDCU865UX+bHRBf6Cvv4RzB6ohAx74UBd3kBSH1s1ohiQz07daWj7Q?=
 =?us-ascii?Q?BQCdk1zkCrVBh39NqIUpbCyU8Dp7rCZnD6P5mA9JMMCblEtCgUR8spN3mCoY?=
 =?us-ascii?Q?6euDLnqokqlTJh6/+4O8uAwn5MKADkw0J9DqvLy9mzzS+C+Fni8Ej0EGf2Pc?=
 =?us-ascii?Q?+ln32QBwDNelm8pGgUh0bCQqxzaaijR+A9ehFZFjCPGF4rlv2Bu0fHx8UY/x?=
 =?us-ascii?Q?aejeR8R1pChZoEHrLeq9rWSHmzXXO9M2rbtAcFvbAauWFR/u5IybowKfgclY?=
 =?us-ascii?Q?2xMMTHO5grlHneDJ++6i3DH4FnuQaKwPJPzMtyh6viy0aNU5KvZ1xh3rRYrh?=
 =?us-ascii?Q?1RAe/rnOTr6v3UnXw1ApRXHeItPCJvolU0vSMwWmnVlB4BmFmveWHyzJoRVv?=
 =?us-ascii?Q?46w+9LCozCA+VK77SehUvFAHnAqyWE2AndOoglqxENg+VnSDRDEQKVQltKZp?=
 =?us-ascii?Q?dRdhUzabEpDLK2FaJzu5s5nyCYP2U1avPWgSW1b80bvdO5CmXXxCGMXeK1qX?=
 =?us-ascii?Q?L5IkTpsSCmq2M0DGnp8ax9casCPXmZlSp8To/51VTQqlT1YYYAs94wrLaueB?=
 =?us-ascii?Q?dRsQEETl2KFCpQrA2SxHFlm2AEpuphGZVMZlAwCBwhbEnXoris0X1NMyoL9P?=
 =?us-ascii?Q?NMZzcwA+iYI8b8gpPEk/PbpNKUzEQUVek4/1xG29POjMp7NvKQJbE3UQlCbH?=
 =?us-ascii?Q?keZ37S8RMuHwBl1lv7jzwhuvG2pRzk36fthfmxRlM43ZH6t4FaLG7LLSaPcK?=
 =?us-ascii?Q?VHvDNbEtSErbjyZ0e14J/QJfkuwK0iTvWBq2Si1pOKJfi3TNV6EvJlpYpr9y?=
 =?us-ascii?Q?NV6OIKCYEEnTaA1J/nuvbIGS9WN6fgQmTCNWqq40+pXLSijFSZKhupyMLRTX?=
 =?us-ascii?Q?/yoSCTAjipFsh+L4AP0UR7JNxh3YBnk6Icy+K7tgNAALqOC/kKWAIzDU7YH3?=
 =?us-ascii?Q?KAdpKhSfW++qqH+E493/DWIEObaD3lVp3ihT3/Gwkf7VhqwMGpn5bBCN8DjR?=
 =?us-ascii?Q?i/9h90mM0SxcV41ldnwk69HAclNGkS9TPMAkjg/jalYnaIBT/A8/5Be6n/9b?=
 =?us-ascii?Q?mGHc2tcTh1s8PA/3L6UfNC0gPJgqqGUvBRZ+riPZCFxr15rAV4KnHj/IQgLZ?=
 =?us-ascii?Q?+BTBbHCMD2yTx8FOIUpridZsrQ9iIa5jm6Jl48CS+iaZuylKmR8UiSu6oQyz?=
 =?us-ascii?Q?w0zAdj+UvmnVOYUGhuVNXqj+fL9KOFXiljMxp7kbSGOJ/CMQT0LLK9zoLjoD?=
 =?us-ascii?Q?DsxxjcGolRWmQMXrXY5J4anEyiA1Q1GmeRV6Y9q985Ebcg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NOlYx7qzWvG59+Rs/6ulSFQt21SQ4fq5oix0GhptiCrY+umKAvFxqeO/HMeB?=
 =?us-ascii?Q?EFBUn61ozq+ssd/X2x7lE1zmrSptMonU7PKjcV6ZzEhdsw/EIlo4hwgi9IZW?=
 =?us-ascii?Q?EQjHkKfaWK07ohNXR3ywxq77nFe4k/dESwyRh/PV3dplMTRkY2Q9e5SwubW5?=
 =?us-ascii?Q?3Zy+kixDZZFJG+SLqNzWo5EyYfpp4QPB2Q9oKtr3zDNWq17IVhBmq1IhNfBi?=
 =?us-ascii?Q?8ZB0LXQysK5PGygoyPUTAZdONoZNryHX6i2bgmhULgzCtLCTPtxzCpE8iVAt?=
 =?us-ascii?Q?S6Hj3CywOd9tWOFy/hq8NmblaixVHfkuU1FHgqiLKwN8eovejAJUEA/ipOQR?=
 =?us-ascii?Q?V5Tittz/ZgQg7dLnDmHw7TSc+XNmZW1c3ZuBcflaJSPU9WactaeB6SZhBGIV?=
 =?us-ascii?Q?UTIF/PkIvhVZzpRPoej6t3XHA3WoFkzRLwLDrcXDEx1pETA5WIHKdGGiZ/8o?=
 =?us-ascii?Q?eqM2Q795cdu/xLYUbHNO0Hkzu1xh9D5Dfyf0e3AV0rtRLr2bYBfk3qKDePQ1?=
 =?us-ascii?Q?g8eNpJs6ZwgVblTxGl+MFVzD0NYHQjmIgRH6ooTwcGhDYvP0FX82bKt26Iz1?=
 =?us-ascii?Q?o/47s4WYcWHhB0OQLUIoHzvy2HjOu8+v2u61qEd5FJjDaniiTxhONaSe0YOS?=
 =?us-ascii?Q?A4oFvrsuVkH5fDjgK9PYIKeHjcGicg+tFvIRnrIJetTLvTO4hpySr0BMcEbn?=
 =?us-ascii?Q?yJDlam/KcLZKEJT8DySfPRBdqGwSLHOaAE0BzznZAsKRyNKjRVgsRaLS2gxV?=
 =?us-ascii?Q?UqlX7Mt7C2TyTpjhCdU4szF35/WzVl6XTusDEZF3GB9M+c/jWz/gPeViiC+s?=
 =?us-ascii?Q?RCb/+/Q3P4M1o966+Jh9jykeJQ3wIDuFwwbTLHIi5Ad2NRSYQ7c0U7/B/236?=
 =?us-ascii?Q?bLDOfLvsw5XRZgl6jy4uvpHGBGEqL9ZSV++LvQ/wTAYZ1T8nIkLui6UG+PMc?=
 =?us-ascii?Q?3f13ukFSIQaay5Fg/DZPvC9i//QgZ9cU9Qmiror/U/0j4XcE6b91DS0m6EtT?=
 =?us-ascii?Q?0efZnUCGUtVvoDrA45balxbXoavcGYf/jFywHWEKkIbH6Kk9rF2PwuELFLye?=
 =?us-ascii?Q?vWz7cmZTwdXRcLNsW6+JNVIClnU9r6GlKIrtC/5FA+NkjHIxf4G03cxIfFE8?=
 =?us-ascii?Q?J3ekdLhGpcXWywGrGKnXneolpmzvqd0VRHnc1uZbgZB6U54cJ2ncjAoMN2Aw?=
 =?us-ascii?Q?iRF9QJuUAcO8uhT3m0jERs38ka5foY/Qn4vu4OvftKh9rOv7W3uad6zdvV65?=
 =?us-ascii?Q?554qkmD1/OMmPOB8tlKbA38IP8HwaaLPdcgaLIy90gTeydyD5Rgr7K0Q69x0?=
 =?us-ascii?Q?hIUnY2KOPrZLgJJjh50knzRcwNgUPs8+cjosKP/jSXsAm0T86AIpln2QLWH2?=
 =?us-ascii?Q?WBzFwL0KV90ai1UUJbp2AO3yK8I9IrgKJVJY6wzsn9RzkU8D/nSVmq4KO4U5?=
 =?us-ascii?Q?/AGWeM4l7oHz1gUx+jOgxKLoVVEd+f0S1CDE4xUlKUkRhVwoRmZKj5itAvYW?=
 =?us-ascii?Q?y8YW1B9Gc8+G60l9JolapXOLQOrGfnXqx9b4TuZesuF4AVK5oOv7YnjzI9Nf?=
 =?us-ascii?Q?Gs6gA8aV+0GQ7K5IaQH2IfQisy6rXPorW7avTaZzG+OF7sKH13c7bBLOE9jd?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e89bdbe4-93d5-422e-8532-08dce90ba7d7
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 09:12:25.0284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EiL7tyGd35PQcFhTFv6NTAqyyPzu3RyoTK+2igAQQBvLgmvbHpC8nadyTQ2CxhM81BXuFhpcDpIsP9hg8G/fWb7Lf9NbNegobECU6qb5yU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9768

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to ip6mr_get_table()
must be done under RCU or RTNL lock.

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
---
v3:
  - split into separate patches
v2: https://patchwork.kernel.org/project/netdevbpf/patch/20241001100119.230711-2-stefan.wiehler@nokia.com/
  - rebase on top of net tree
  - add Fixes tag
  - refactor out paths
v1: https://patchwork.kernel.org/project/netdevbpf/patch/20240605195355.363936-1-oss@malat.biz/
---
 net/ipv6/ip6mr.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 415ba6f55a44..0bc8d6b0569f 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2302,11 +2302,13 @@ int ip6mr_get_route(struct net *net, struct sk_buff *skb, struct rtmsg *rtm,
 	struct mfc6_cache *cache;
 	struct rt6_info *rt = dst_rt6_info(skb_dst(skb));
 
+	rcu_read_lock();
 	mrt = ip6mr_get_table(net, RT6_TABLE_DFLT);
-	if (!mrt)
-		return -ENOENT;
+	if (!mrt) {
+		err = -ENOENT;
+		goto out;
+	}
 
-	rcu_read_lock();
 	cache = ip6mr_cache_find(mrt, &rt->rt6i_src.addr, &rt->rt6i_dst.addr);
 	if (!cache && skb->dev) {
 		int vif = ip6mr_find_vif(mrt, skb->dev);
@@ -2324,15 +2326,15 @@ int ip6mr_get_route(struct net *net, struct sk_buff *skb, struct rtmsg *rtm,
 
 		dev = skb->dev;
 		if (!dev || (vif = ip6mr_find_vif(mrt, dev)) < 0) {
-			rcu_read_unlock();
-			return -ENODEV;
+			err = -ENODEV;
+			goto out;
 		}
 
 		/* really correct? */
 		skb2 = alloc_skb(sizeof(struct ipv6hdr), GFP_ATOMIC);
 		if (!skb2) {
-			rcu_read_unlock();
-			return -ENOMEM;
+			err = -ENOMEM;
+			goto out;
 		}
 
 		NETLINK_CB(skb2).portid = portid;
@@ -2354,12 +2356,13 @@ int ip6mr_get_route(struct net *net, struct sk_buff *skb, struct rtmsg *rtm,
 		iph->daddr = rt->rt6i_dst.addr;
 
 		err = ip6mr_cache_unresolved(mrt, vif, skb2, dev);
-		rcu_read_unlock();
 
-		return err;
+		goto out;
 	}
 
 	err = mr_fill_mroute(mrt, skb, &cache->_c, rtm);
+
+out:
 	rcu_read_unlock();
 	return err;
 }
-- 
2.42.0


