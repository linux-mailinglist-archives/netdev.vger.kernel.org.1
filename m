Return-Path: <netdev+bounces-135233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 684B499D14F
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827DC1C22439
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDB11ABEDC;
	Mon, 14 Oct 2024 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="ELeGwVaH"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2056.outbound.protection.outlook.com [40.107.241.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160E91AB517;
	Mon, 14 Oct 2024 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918793; cv=fail; b=XKgS96kSHnvVkx7ivH9mRqj2S2GOKdz0bIAtAMI2Ktx8tDEQGehIR4Igj6SSViGY0iun0TKohXBp58mCLz4i0P2cyig04LNOUDDKZZTK9aJYqA7QwRhKd98zubEiA4qQ6+3t2C6AbP31aXIgTeIEuIjU8A0SRrFf+YeK6/iRWmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918793; c=relaxed/simple;
	bh=ib6Faai4OQRqmtopYKqjOO0SsweiMc5aOUhyF3/iuI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JnJdnyj+VxAqt0t8ch5i4wVqwaynXozG1U+s1F4wh+rYpbaLsQHwUl6pZsXvcCqtt4LrN1Fb6hk+kfr1PBKmFFCIxeBxwFb4jRXosVNhVL2kcraSwqBuEMnzDyoKkAokrNaXSmQpCgEzmu9IN4yCKhKI9yGZXnU9N/+Agz4Un5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=ELeGwVaH; arc=fail smtp.client-ip=40.107.241.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeT5XLWfnbqds7Cmog+9hqqeqX7uSIB7SmHLvDTvrzwARjNHeHgRfRSMiCxSNCx90RLY1V0B4gS2C3ehGiAqHnO2N2xMrNhMNmdfLKh0gr2AmrQN/C9qPw4hlq3hdYax6grpOxTvz/r7sZMs+v/a2/Nlv73IWfwPSuljdOpLbfAavyG7DI1UuMrsT/AlAAZ6HJ7lFNHB4/mypvyYgsKqceF0+PuZdOJZ4W1DrmwkrW5r+PoP/0HpOhyJpS+7D8PBv4NySiwIZEEK+PyEvz4Kid6v5heSIUtffcWx20cXQkrTQIeVFi9rUhz+lPoYFx+s13YAsPf5vihmbOyD6+1bJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tWeL6x6otq58JBciWHLWg2V3W5/9/f7qlubIloiMjU=;
 b=HXEjJ8RJWxw1PML3m9xkODWeQYomRk4pskQu3irb3gSHXpz/SP78XLJAke7SGTihSyOTJVlzJWMxvLangZe7M/mIi8cKwmZiV7Fq0BmuZmrajbl0kcN6Zix6TCksHPMk6sZP/BA2PQSqupWRihIK0r3lf1xnPF2PuLNOtU8Jrai8zLqrWBcL+A2ruvDgnAReEQu7tTAsDsOhp8IzhGrc1WJ9qa7346EyUC/MESQ+yJPB7TZ3y7UOviGIBZchymZ8/XkzSbc0M/QeCxJX0cadcDHkBQmiI8nYHyLhNqjiE9g5H+VD4iyQRX8/o55m5CaHYa3XOlVN9H7JHW2gPpo4ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tWeL6x6otq58JBciWHLWg2V3W5/9/f7qlubIloiMjU=;
 b=ELeGwVaHMEOAcoZXnrDF7C/d4xN/+oQAl0HeSL+Kg8/uzuk3htjYCsUlOL7dB2WS2to9szbtYHBXZ8sEHfP4fmY9yfIxZQmai1Itfx5HejiTHBNPJEskJ+XCMmvl9ZjDW5dV5J7On/8wOZTQC4Dl1vsbr4loV0b2B98Wv9lDyXbYDKk+K1ILtOvzTBp6YODOYJ3y7q9oKj3dW7YDiqsVX/Fpl+/O9QQ2PmhlrOFCejU5afmKPPgLT24N6vNmjrg5u8Z0JvM5HcN4hdE7OSgx8xv5yvgzZrbYGrOGpKUpBNpLjNvG7xA7Ue/c2n3H/aJCGN/bE2+hpgUD2woLf5YPCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DU0PR07MB8905.eurprd07.prod.outlook.com (2603:10a6:10:316::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 15:13:08 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 15:13:08 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v5 01/10] ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_vif_seq_start()
Date: Mon, 14 Oct 2024 17:05:47 +0200
Message-ID: <20241014151247.1902637-2-stefan.wiehler@nokia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6889c552-e995-4c3b-e8b7-08dcec62b5e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FKELyt/cclV6SAxbE1RG85j/cFQy9sYksR3YeWhQnF6pmuExA+1fmxuV/Mlk?=
 =?us-ascii?Q?2UhSoSqxAEpKicfLvOIK7xM66xD/G8LBmlneE1hKBjtmTYxY09LZm73Tm4mz?=
 =?us-ascii?Q?4wS2YEh030Zu1uOV0QF7rhL8/MXKUhlfmkSIBCncS5AvkncCQEw2PSUsJ7r2?=
 =?us-ascii?Q?xbETp8dS1lA+AqS/FCosPDI+jP3HksA99NY4ORIvWsmeb1j1x2UJRzKXrUx6?=
 =?us-ascii?Q?D6Ezrq/dduaFa93vpMFRQ38ef4TLf4B4JSeB4INksnjkUokRiDQ220WQMEKu?=
 =?us-ascii?Q?M2PnmzzgUKrGRIoACiYaieYnQsIW+aPSEN5SLTd1ZZi2RBxMEWNxKmtlcQmk?=
 =?us-ascii?Q?xA7vec6y60FKjYfN3frmny8o9ndLxjQhe5pWFPALGArDS51yF9nGTF44uw5y?=
 =?us-ascii?Q?laCgK2gk33js5VHjQhOQ8qcXiW22ZS0urEgPRl4HqJefQTexajQsjaAxJ4zy?=
 =?us-ascii?Q?TOvc7GOBk4s4RytUZ0TSIYvrpIIJlbpVZMz3ZWbOm1CoshEvzxZ26vQnWtPV?=
 =?us-ascii?Q?GOpdlAygOW1FPh383aCh4Qk7R34q4PNKMXnMWHyKK3V3MoVp0notL+tqJkGS?=
 =?us-ascii?Q?SWgFeqramg+5z0lZtDwOAisCcvdtx1dfYvTYO6O7uA/V8FQ3VVi11VUXmKTz?=
 =?us-ascii?Q?9uMOMMjFLV8EwkKypfnLNqTNzKn0RW379ZE1DMflY7YFZen+fwHAZYZMcIoA?=
 =?us-ascii?Q?rRKY6DStXDYtNeirku7plF4dWxj8nWX1HTd2DpdpmSvy7KC8u1iqcqSgCmk8?=
 =?us-ascii?Q?SyBZ7HY2yoUsFh4ui/yE938HUV1Mv3zblnOUC/zbC/NfufNOv7jQpP6fDtDX?=
 =?us-ascii?Q?rcJz9QJcTzp8rhZMdmT0vd/HvmAHJfhpHyV0ATdqbRRaDHJv3pKkirtjk0mV?=
 =?us-ascii?Q?iqvhnQPTi4OOl1nt3V/AsKh5YWS3/5vQtuT+PvFoy+lcJXO96H+C+9HL55sT?=
 =?us-ascii?Q?Il0PvbbSo1Kk/5FWfPI8yA3NuRXxnt9K3EVu2l0DjzBJeWEGvaDjHZ0ZcrAA?=
 =?us-ascii?Q?q/T7u7S/l2b68H9KTKyCq8zmONfUmLfX6A3p44uo5o1xcLJZE220pn/pa36B?=
 =?us-ascii?Q?oFYPJ8+HMMMWHxC0qDaewKvkhfDRBjbBac13tv/Aw+xpG5ZtvidK8RDDcgw/?=
 =?us-ascii?Q?gUn1q7+LJp/yk5tPMAAfq/gbAwouU+BSPt6YIh5G9JL/IrRqjD8kUFoLTqIt?=
 =?us-ascii?Q?KiBY/KQjUSK2B8PlfgrNgEpjSkPtM2h+SWdiyLWIfCtmrzzHoewCz8dEfONs?=
 =?us-ascii?Q?kmokH0dUDpeuw1Nkxb3Sypfm7QeEoSKB1lNTtv7TenSr058f5px8GySrZTOo?=
 =?us-ascii?Q?DT1K4by6zx6P1/GYEuruWujjiigsyw6E+o6m+Oal4ajmTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5HDNvlpxR5g+kZBVSiPQH01JNocLM5ppJuiv+CRYqul/8tKBuXqV2dDzQ1JJ?=
 =?us-ascii?Q?B0bLqj0ZS/VNrk8FqTSqoj9XZEZSrQUUMWVQpH/vpqow7IEkdXYtcdmpp/vX?=
 =?us-ascii?Q?0W/gaWYbd/+4xCExH0HGUBK0G/ExNPTUibJf+1d71oLSqRLYZ8V1SpntSFRR?=
 =?us-ascii?Q?U+xWiOxzC1EGPVdDwvyMdKVgC/3bAlkAcniGdFxkjIa+bqkyVjrDss/wLxUW?=
 =?us-ascii?Q?eAvg3745/i5CV2thIXbSfdJrvEHtTxEjWHqJY9hMJE5NbKMFLkGczKnzHuhn?=
 =?us-ascii?Q?k38Gkx5S9jOYWU9ViMIak/Cd75q9UqKBL/pPXcN1vdD+vEiCefRAWs7kXkHS?=
 =?us-ascii?Q?RF0FvuJO3RqLTATqXZ3HXDmbW4uDGcsBUoyj0o5pFC+V/vy4blsEYXdBANlU?=
 =?us-ascii?Q?ytLTxp0PRWtZG8h73DiSef9G6Lt2WuAp3bKWQ+b1ritzuQuhzEAIzF750ah0?=
 =?us-ascii?Q?qwM0hbLnrM4sqj3DG2w7lptIXYlOEewuJA8ZkGwDhvVHEJlf+RRTA4uTpuel?=
 =?us-ascii?Q?+kA65ubJg5zERbdXwEjESuMJ2vmgejbm+3FLqd6q3OTRmsVRcAHqQHsMu2PY?=
 =?us-ascii?Q?70YGdrbLvePsMQoaKOlHPoL5/Gj9hPBmNC1uVs87rzBifUTG7QAF7VxN3pxC?=
 =?us-ascii?Q?51aHLqihfxH8kDxTo3hWnYfrtXlkQatrRlUEfr4W/5kXGuc30/IVEcjE/AHe?=
 =?us-ascii?Q?IYY6h4iUqFBmu0yDKKWHiOG9gCU4D0D+Mn4Py2v6YPUM4FY3AWbcihrggfA3?=
 =?us-ascii?Q?H/irTF+F5dnLJ1g2D9P4F+IWn4pFqSmv/lDYcDGPYruju2vyceBzF8AJtYex?=
 =?us-ascii?Q?TDhFpbWSiPbCfYukEu0QHH+00NCBqBkSk+Ggr5dv+YuCddWa56GTT4S+ONr2?=
 =?us-ascii?Q?w632Iz4saY5RBXs0SiDeO0VSpIqiD530tRlGjXOGSZoTD6vArDy+sZdX5+R5?=
 =?us-ascii?Q?7mSBiruyIp0HZrqQqCR62y3xG4lzU1Sm22qFgF9fELFultUJ2eYqojSFPcMW?=
 =?us-ascii?Q?4TH6nozC8vED5ZEUm/wSXHOWO5d4V4SfMM48USd1scJLcZCBlmt5mtfsr579?=
 =?us-ascii?Q?tHkF9Cbb8ebOmXqA6KY2wWHbqtmEslNdHO3ijoisjlOV17gItjh1C36WLYSn?=
 =?us-ascii?Q?qd4NZYEXf1bpqM1DwXxnpZsIi0w3+4qYb+dZYCDMyorTXzkv8iK99apjQc/T?=
 =?us-ascii?Q?323P+NR24siacaFOvNUXqqmr6ofkUxYG9XzSXH1VE3uz34ZU7VLgv+ah1yST?=
 =?us-ascii?Q?clQ+e5jwQzhsIJYCVFZOzG7RnBEy9nVW9F/lXo4dLbrSG6xCasCEEUSFSSz4?=
 =?us-ascii?Q?pc1c86gll29oeMqggN8oyfuN2BZh4ZgS8m7p3+Pc7qnb7joEXewMzO7V6ZdL?=
 =?us-ascii?Q?kbjm4uigGqoUyRAeWdIyYnIzcxrytRu6KnZfXivACoPBNFpMTjMorKtfr0Yf?=
 =?us-ascii?Q?XIgY/NqohJQhXoV7IuZn/OmzwwjG5wRvudsHBnIMxrpYx6IuC3aB4Hr/CmCT?=
 =?us-ascii?Q?+HFGvOFo+dvNN7PD8OZNuxJl4QTJfSPvbaWZTporwZP6aNdxBteBGSon1OLo?=
 =?us-ascii?Q?JSWZahgYfU8aEyAmW4IYViffS+MQmuI4y8Zv3I4IsLd85LsE/D+GJGExwpVt?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6889c552-e995-4c3b-e8b7-08dcec62b5e8
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 15:13:08.3608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKEKEXOcLrnK643H5gRvlJZMgaXgQD/90iK2DUlOWqg6gtJKEPqheX2oPs4oUwH+WYhL/C4qkrVIW3vT7DUyu01PmUwIi7QEeXyBMMNCRKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8905

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to ip6mr_get_table()
must be done under RCU or RTNL lock.

In case ip6mr_vif_seq_start() fails with an error (currently not
possible, as RT6_TABLE_DFLT always exists, ip6mr_get_table() cannot fail
in this case), ip6mr_vif_seq_stop() would be called and release the RCU
lock.

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 2ce4ae0d8dc3..268e77196753 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -411,13 +411,13 @@ static void *ip6mr_vif_seq_start(struct seq_file *seq, loff_t *pos)
 	struct net *net = seq_file_net(seq);
 	struct mr_table *mrt;
 
+	rcu_read_lock();
 	mrt = ip6mr_get_table(net, RT6_TABLE_DFLT);
 	if (!mrt)
 		return ERR_PTR(-ENOENT);
 
 	iter->mrt = mrt;
 
-	rcu_read_lock();
 	return mr_vif_seq_start(seq, pos);
 }
 
-- 
2.42.0


