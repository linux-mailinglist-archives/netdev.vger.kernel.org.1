Return-Path: <netdev+bounces-136703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4FE9A2B3A
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AEDCB2951B
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACCA1E0B79;
	Thu, 17 Oct 2024 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="hJJssVdP"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2074.outbound.protection.outlook.com [40.107.249.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1AD1E008E;
	Thu, 17 Oct 2024 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186933; cv=fail; b=B6DX2YNi/gqYmVk4dcQTMXVoFq/9ahtGoLR6+27eThowNuHFdK2gQbBMAriIApgbLuALY43mqXMZzhkg68dc7iAIY66F4sn/I23FZbuh040Npmtju0481hNKDKHiK7HvAnqSKHjAj/sJ6zEJVG8L1cISXRrAI8i7XALtMqsQCs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186933; c=relaxed/simple;
	bh=AzsqNPRCn7xT/MIsou4hdgu2fqBPg/OE+TRg4NDiFhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mc3OE+ZfzAxd3qoSCZDxUTCB5p7Vf9YAgMZCIthEvspy6TBGETjSxd7DeJoSOBWf0kt5LkvQQq8xs2kkCbI5rk1q7WK+fVTOC+u/Dn06NPQ0M/7HASiN8TfOvT+K5Cn3k3YYr7G4s53DAntMh3Gy/WrwmcQwXav5C1XbSsaveFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=hJJssVdP; arc=fail smtp.client-ip=40.107.249.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDn+kYPY4MeBvLcVsYO/GsjjO8rIQ2LWQFLshHjc78g6+0seLuB2TtySOY0CBRXIUst5iILlKnUHumXG47LclNDsaSVIfGSkXfhHGqfpWKNYvL9RMQlZi85OzzNQ0Ls+6c2APJZUld/w5KZFQLlVqlCJxjCpSzAMLoBvfBuWscA2PtKeaoHkZG0dnytl43aYWV31h8iA3COmB19UsoqMDL4GZxyTRN8dmxhYvUhkYXDZ26apRn58k44ocyh236YwkATn8Txs3DB3gyMgyzIkDfgoaKtiph3dqixpSCHPZ6KNpjl374k3Q4We3Cdv4smzbh9Ed2Eb6yHWhZK0Fmq2YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bc62ejWQEAFY/jjmMhFTB2GtcEkp5ZuMwW+WJaDXHcY=;
 b=kgJ6AlC/1IWoAGkSc0i8Ebkzb9C5IsTrx+8ftRIa3SQ3gyF5jIKb0BUZDWEe+tTo/rphxOttmS9dS8BpC+jXbalp4hbeco1SRE1dgQWGssAJ1aXuEifzL4fga48qOSIz0dh2m8+rGhT4HTb0ujEZB58iQak7kMCDTj1laYWZ1zXHard8/VE8wSHhsHDADDq6pjqX2DndBWB1mSyUpzAM5gh/bjPDY8ldpwYYVp6kcrJ9fM4DPXDboDRuf1xhlwSLiQjOz12YsMjUJL2wF6kLAhXVbdH6s8Zs4+Oh045GP3gq/oi5SthduRbUKEkt6FQ56BaYBZNuFE7mAd1yXDwPCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bc62ejWQEAFY/jjmMhFTB2GtcEkp5ZuMwW+WJaDXHcY=;
 b=hJJssVdP4RzvE6xwfgKqYl0T6/9d09DOiMRsuZRzGNptKjJZPW8qPQW2IjCTtJH9AOcJinOlti7ae2Bv78EnW4a13ecDB3FtIEjS+FDmSiVdldSqzeEE9S21IIIka+zVlHRqa/PswCQWHubBrxQ92eLt8xVuWpACciTpf0jCVYxdfspT7HBiUQbgNqGuKa486H0p2DVsIcUWA5WYhvH/UHVEYKj7FQ4cwVmqvcMtXnSbzG4OikApijNspjjnDHFqkhC/mbbfdBNAHAImeP/dMArzZWwMWfG53WAEWCLqJ9ASsJbdUBGXvYDnNbjtyIlLnUWTkHbgrrvXHbWZre27ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by GV2PR07MB9009.eurprd07.prod.outlook.com (2603:10a6:150:b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 17:41:53 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 17:41:53 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v6 03/10] ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_compat_ioctl()
Date: Thu, 17 Oct 2024 19:37:45 +0200
Message-ID: <20241017174109.85717-4-stefan.wiehler@nokia.com>
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
X-MS-Office365-Filtering-Correlation-Id: ebbf071a-8b64-4419-75e2-08dceed2f67b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9tSPrt0fLlpknzmCckgQo2rP5l+3L0oiF+Csh1ncR5tli2oRm87YFbrbXlG0?=
 =?us-ascii?Q?VW5+qOSlSPQwKvfKWZYYXsTmVLeQtg8ZcmcB62uIdqqiPUg07AAHrh+6oQQn?=
 =?us-ascii?Q?Re+22ggvgwXNyEn+NiaDkY7IUTSbO+4rIydpL+L1szkPZy0PpCrIGbV17o14?=
 =?us-ascii?Q?8nTHQIT40Oh9Np1xRktsSgFwBK4blTzWRyse0dgaT7FCdcJf08jPFC28t2uV?=
 =?us-ascii?Q?GjpTh2lpZCt2Pj5DF6whQ5GgEbfK5IGmjYwepuehWnuLCyQnlJuG0EDkaFRO?=
 =?us-ascii?Q?OLBk2Cv8GrxDIsuh3qoaCltw5uy7rxEx+GSbYVi5Bg9h66kpeMnMSVpQozdA?=
 =?us-ascii?Q?Ro/SnqjWlorSJCMV7GsG/QUr/S8WYv0EJI5Z/mJcYXBorL4Z+RnxeTCkB3BO?=
 =?us-ascii?Q?GjlKRSRkE4LR9goOjcyOHPQLaJniAOY6C0S2y1MupUGZQM65tXpeUJZFcL62?=
 =?us-ascii?Q?uJI/egc1G8aRt42kiuE66W2ZsGdKjveKYneVhwFvYA/IsZUHTJphZI6PuZfG?=
 =?us-ascii?Q?Zybpi7cHbWWigeZ7hnazBgnTjyhl7acIPAyqpfLSns3d7+iREL3e7aoYItAX?=
 =?us-ascii?Q?iR0BrTxfwymXjpZjJ1eo+t1KPRoGSAVH5kfCWyWn2h7HNfUJJMemNgbGVhyN?=
 =?us-ascii?Q?BULFJFguDfCIs4kB8oqCMRVhQT8dFjQrjd8rwNrcSo801VPc4KljEYoWlCcY?=
 =?us-ascii?Q?JFACwoUCaVyNNLyv3BryBUUPNYL3rLD9XKxTfIG5w1tvkEIyxpJcdxb2C94d?=
 =?us-ascii?Q?PMPRPQmqOpnjXGEAK75Bt9c5nIRwzk3ggPtxHpiiR2IWvtI4JSdYb90o+dnW?=
 =?us-ascii?Q?EXfr4/2xVdf3ZGZi2uAntFZz7pc8DWAYEuS5OlVCiq8/yKxftWqncApymL/v?=
 =?us-ascii?Q?woOLW4fx6pZaHlkfzDx8gSJMoCpCvZugTMZruVcHMwMnqKLmYrwO4h66QUzZ?=
 =?us-ascii?Q?GbrGhncTLBvY4ejs2+5XuYx69nfYLNYyzbkE03dngpYnjkDKDHfj5AU3vxEn?=
 =?us-ascii?Q?Q/aWh5JKOmlk7FkkdOY9v6zb7EOzxUZoZcQ2VZKgXNCS+qrF8kVHqyey6k8I?=
 =?us-ascii?Q?9NR3U9Y9D324T/431EZxu5D2afPliUeJL6dWa4w1IKfij3k3jC53CVTyfl1L?=
 =?us-ascii?Q?ncbuQ9xi+iHpCJu3vx0WV2yZBpCiJAsGZ4eFL7b1QQoqxzNPGtrSgoeP2Xeg?=
 =?us-ascii?Q?2ELyyskxcn5NemZA46VTmdW+6sAz3Dk6mF4HbISewaYJX8gu/El/0fR2PITl?=
 =?us-ascii?Q?lX/4gCNNu8E0E9VQSRPvxwj24a8TTWCLJQ13Zn44ye+xeZ2cBNNp24l267QL?=
 =?us-ascii?Q?mfJSD2q5rb+SdoHd0lN07xcDNtIX+DFlPf5bjp7YJ0iK869BbGkzQ5wKXPRq?=
 =?us-ascii?Q?JKDI/6k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PS/3oMLCatIzycVgxmwddsIl3+dC0LjV292X/bPX8EJcttyEp4MH0SxJTHDe?=
 =?us-ascii?Q?JBKjOIwZiWgvzXtsMv0cv1ATd4uK2Ebwg35Np8T44IQZIZDXXxCAT7berVDI?=
 =?us-ascii?Q?yCkpFKn2wG0uNVqoK6FEdiUHFcjrN5WjsqkQNoQCNtKKxZpIi2ukE7WngRIe?=
 =?us-ascii?Q?mv//+wT2BXsd6D9s52tJOkCI2AR4e+LWgRJHOl45sSDTJ65baZVw2XFZcq1W?=
 =?us-ascii?Q?/8Y3nXbyn8wdKgcSilern1D6c8wMRxOmCJiyhYzAcEHhoUW4XJCGjte7ezTt?=
 =?us-ascii?Q?ptmuRnRsVEvXK+bSsfle3L+hkSjUgrtUAk/6AFRtE8qPkYeG9l0IHlqwHS+5?=
 =?us-ascii?Q?nCWmNPSPhnaG6GrW7gPKB90EzUAjtvFyX7HFMMU8kjQHwibIN+8Ypc27UT27?=
 =?us-ascii?Q?g/qqdZg2Hwv1cgkd/3jfsoIL/4HiCxI4ZMv5dkc7NR1ImpGs2DeskmRBf20t?=
 =?us-ascii?Q?6p4k4PFRzwt2RSUXUXOTxK8RqaH1OGtFgCa41Nx/R/BWN76yQG53xVuE2uBY?=
 =?us-ascii?Q?It0HEp4W8EQpG6BKmicEuf2Ytcqje2Wevkmzxr2LYd/Obu+c3j/YG1rynvaZ?=
 =?us-ascii?Q?W7NMy6DfO21TweLwT+wqAlZXUglgKPVh4mSQm0QqaVi6nNLePwnkshbkoDEZ?=
 =?us-ascii?Q?nnefSNhXp4AcU0g5qQQHBUhVJP8nJ+RsDzeebNl13eeyTqmtC4BLwG+AFYz6?=
 =?us-ascii?Q?7KPXEB8JHyiTb1G7ct8PJXTlkApr2WxdMKTdXNxBGC5CsWF3pHj2BRXEkSkj?=
 =?us-ascii?Q?37LgT5ANWgrMwDBFBRbXeR2K8GXVP9yVOAqqm88ynPUSGGenL2RUF8KFpEAO?=
 =?us-ascii?Q?yU+in7CgxuRRbyRxQ1zDNc/PY8483reox26gOUYnlAmCUbT0AwB/e6ofN1dC?=
 =?us-ascii?Q?f+HN5ZOYf8GwUsdcOlL4lidu5xANZxxOwXNTPLL4PYXzaF7oHAzWgX61kIS7?=
 =?us-ascii?Q?YPA1hYvVFIUja0J/z1nzI7PB5Bgzy+BjXoXkHdASEdqMMyjADyQ5ElPz8NIP?=
 =?us-ascii?Q?kNdsFne0WYOVD2+qQT6ov7D3MRf7s2KKtxKgT2n6+Mtauf3iV+4eNstwPOsI?=
 =?us-ascii?Q?2RhNqarG5RR7G2Fm2a/r8zSpH0J9r0L95OUQS0RA0/7B9Wkwuj7UxgShj2oy?=
 =?us-ascii?Q?CiZArVme1FSRDbRDP4PFJxYIXhH+ni0K/g6TNtr7uuJbIW5orgQTthCH1ASn?=
 =?us-ascii?Q?ctkwhCAezkrua4/jQFEm/oPo5WWU9JNpZcvPv9Dau/XiEFFYf3dTzkp6M+8u?=
 =?us-ascii?Q?uhXwuAjtglv5W9fbWYMatEyVBIywCJVcIvL0HEkl8xX25DfZdN+gkO4d8oqA?=
 =?us-ascii?Q?rJcGFysmlkErAhAdkW3hwEAcrTMyGhq98aPUp7ODbhVXglD8uRR6is9Ckm77?=
 =?us-ascii?Q?np/VjJfIEamY2Wjh13rx/HJkBTUjFtgv2ru7+dePCa/gA4es87XZBZevwL9M?=
 =?us-ascii?Q?UdMKuad2cecWijyPPlcFgOg61RVF8owUFP8ZYzwmOQ8vJ/MRM9UQgkOx+juN?=
 =?us-ascii?Q?IWIvFq0vHxDBEap4pgCzhPMRYft3DzabRaM52yhtR77Xb9HmwUSgFvwZ8ZxB?=
 =?us-ascii?Q?eqa+Jf6M0kvx7PJe15eM8BaHsFgEsIUV5jwdDHVN8VCUFccHZ5S+vg6+h1XA?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbf071a-8b64-4419-75e2-08dceed2f67b
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:41:42.6425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMZqbtFPxuWaDDM87Iss6DudUq2K4wcIgp8G1etyaUKhI9py4QAq6lLCZxsf/QzS8EEei2m7DNp57Nt0uZfj8hDp1BLQZvvZvp5TeiLPxZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB9009

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, multicast routing tables
must be read under RCU or RTNL lock. Copy from user space must be
performed beforehand as we are not allowed to sleep under RCU lock.

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
---
 net/ipv6/ip6mr.c | 48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 19ce010016b9..968642bde8f8 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1964,19 +1964,35 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
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
@@ -1989,13 +2005,9 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
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
@@ -2007,11 +2019,13 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
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


