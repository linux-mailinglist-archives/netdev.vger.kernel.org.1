Return-Path: <netdev+bounces-146145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B146D9D21B8
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 09:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C661F220CF
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 08:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A05B1AA1F8;
	Tue, 19 Nov 2024 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TSkXCkvs"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040DC19D880;
	Tue, 19 Nov 2024 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732005589; cv=fail; b=dAFS6XUjmJs23D7Mx/mZKV9T2XTtHW/RxbxXR+2A5B9RlwlMm5HoVlSMjLPWP+7cQH0OO0hIxMYsQUPXn1NP8JMmk/6xfE1J5JqYQ0PQmUmOkfel/GTIfIkRYldfJYMiKmoBnSjcL2EAXiSGPd0JxX6kBqa+D5Y9/ol0Z9JxWiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732005589; c=relaxed/simple;
	bh=dBgSruQc4iCWuV6d0hp1J4VLYF6KlK5z8YPXzSPoJJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PmwGCy4xs5ksa0EbhQI5R5nj0AtA+EehRYnady9ujNh3U/du6UGOVi1/TR5oc5MtoNZWa+HGpj2Fc8vQkFGPadRIGziKgh310kUujXC8DvZd+1boGbpNGAPTl3/CWx+GdXCLUYpsu5Kbs0RUzyN+OxX9I3E2OoYT8y2LaUcoIR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TSkXCkvs; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNpWB9x6uAYvok/H+3PZmzv5ROTXjKCNt5Ofsx+gQqY+fTaUFgfvC+DBJCGZOjsJDHno4cCwmnNewxcyyxx1ynixg+hl36C1LQ1/o3dyckqz0fEYMHi2tGyngUBQOX8Iphl9ORGIpgbBP5wtTueuzD2termc94ZfByRQ4tZAuTKBrmzILIAwe5kM1D0sjj2tmYSXYQKBgZRcRsNt1BjANEm+1REOz8QRAet5j8TSR1qu1oySPM1QjJQc1mOznwytJdDG12KBuvtSexR1jZF1OxztXW5NQLPLIAiZpRjV7ugXETBmEuV0TwEddrTjNMUQAGwKjjqU9dX18KVVQdiZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8X64OoeC+GrtxcnK5uPV681Wn+knyykExbwg4HZ5bI=;
 b=LoqSpeaujSjCFRcCXG3beXmuo622VtPf0qEbElopKGhkceNxSUlLy1dwaGMeq4vPBnA3MK3uJbbkxI93m4I8As5SbNjoLCQ5nmAjfX52L+o/WNbvQ2LgLdy+M1BytI22644qAY/+92f4B+r3TeBAtC6Q4nmJKnmAsKnjeyzW/yrGfW6DYg8lNN1hrQwoDgJq7RK1tdAxBdQwf9F1T7vagodletvZXnZ1IwtEmkGB9FxhA7lv42MYRSF4oz/SmcHaCW8tC3Z0LxCDcCwf1B2hqQ3UqVeqO3f/yVHUbYXzLkbBHh1YZ0PQhTw/MMC7BZZMpJy3sUSPJUurL0e05CQzag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8X64OoeC+GrtxcnK5uPV681Wn+knyykExbwg4HZ5bI=;
 b=TSkXCkvsgTcBCKsdWuvCawokivg76d5hIcCZ3Ds+Xbd8XjCeuSc81nQrXBL55oVZ6oaLBpwqzTl/ql1XAC7plh3hcJo4RABGLmvAH0f05oD9eDjJb7J2/aoJH+WNO2so/XXFX2dKs7J0KYMstuAyvCfZBKQLafndho4UdTydiGQlEABD4sziJ6/ZAsaF3gMll/XLuZZZCEdRkj1C/AjfBV0t2Sqm6/8kDj4z6DS6jsPeQRWS31lj89g9JZDenXQYV+Mn5B8qBWzefsa2BcLu6B/hTEEtmjRp28TnkemKVw8eN0ZYeHzKNjz3dXrVrb5pSEiWEfcvjtA3UmlKkX4d7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB7160.eurprd04.prod.outlook.com (2603:10a6:20b:119::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 08:39:45 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 08:39:45 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v6 net-next 2/5] net: enetc: add Tx checksum offload for i.MX95 ENETC
Date: Tue, 19 Nov 2024 16:23:41 +0800
Message-Id: <20241119082344.2022830-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119082344.2022830-1-wei.fang@nxp.com>
References: <20241119082344.2022830-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM7PR04MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: bf9424a3-0bd2-4764-c799-08dd0875b83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eklhrLTOQNBSPIr73mVFkQe7ZbqYRahmk194VFO2BAJKoh1HS77di6ZHuh6r?=
 =?us-ascii?Q?+gWzByZpeBwEYWJggpfTSMj0ZBVH6qTBq3LP+jTZse09y7vWBWACOiPUqdeX?=
 =?us-ascii?Q?GiVcv3IaNJqTmRX4nKh6we8anRnDBXeaNzO/4QaWO9LrrXgbSSJdLHPdKaqh?=
 =?us-ascii?Q?Q3tCPEwPB9ZyiwjmT0w7pbXT0/8mpnCQaodeFZ0MEkDcCSVelLoWD4WrZ/Hz?=
 =?us-ascii?Q?rB5c9sKSk6zpcZAhuIAjV4XORhTWtswedJgTfk12AOYdE6TaygNUw+0seICi?=
 =?us-ascii?Q?D8PmK7Cj5yv2zvWYAuq5iUhBsAMJQYShOkTYpABZoSheyWl9Lq/xohkgUBwL?=
 =?us-ascii?Q?mEPKCoc0tkplhqh6zqjoOntqXC8SKx/L/nYFp95FXM1A+79dThrYuOJF/8lB?=
 =?us-ascii?Q?mucN0Wd83EtIKEZ9cKADM8+05g3+C/0vaVdjdXhwTejOOhL1LAuXiwUQ7UTU?=
 =?us-ascii?Q?K9coYapdGOWpz3g4kkeHWKPkl59GRaSfNtDaLagTP2NQFhNosrKtJlLDtkO9?=
 =?us-ascii?Q?rkIeKlH5fhzU6beVrewCI7qCCF30pcynp4/sEa9LbrJycZuS3YFlObAFGd3h?=
 =?us-ascii?Q?6tJQLrQ1mCsrK97cwaPuf8UyyqjOLXXyIYLVbXi9BJQUFGNccy0F6dBz9E+D?=
 =?us-ascii?Q?OKAFgCilYKobt/e4uVBnHTeprhVNpQjD5vs1hD9Wtpb1M0FOLzK0ebv54yHV?=
 =?us-ascii?Q?/9aNf/DFfW1SB4tnp/No8HkwBcVNWur1Ib6uF2Rd1OHdoV68uMzO/MB9RtMt?=
 =?us-ascii?Q?Aew/haXlUOby8hvMD49uPJ6IWsuWlPfVDNzlyt1H/D1Ehqy7aitghwEhF93P?=
 =?us-ascii?Q?5jMGoo/y8i7xjmlgOTk7JatRVayJ/EX3c6t+ANIu0humlS9qdPrq0Dbnzu1t?=
 =?us-ascii?Q?SzIRgAZwgGV5VRIo8CnTLsmepTLur2BMLyglw8ufcKmEqk8E0S1P1xgikaop?=
 =?us-ascii?Q?XfjoT3OFy41tpnWDwVAPTUqbGaoSigmCBgHO7+H8GzDgibKtxTLhpDpQ7mXY?=
 =?us-ascii?Q?Kw8FLpiwTzd5dLAx7cjiOpu2kIAarvQ2er+TzJXRPC/CuH9OyTmPzrCb/UQp?=
 =?us-ascii?Q?3VPwfm5bWJ8hFg37Rdh7Ye2mGf3hQlY8ccq0DCWERSJ6vHm3FkfAZf9E8bry?=
 =?us-ascii?Q?PAmOioMlyzsPZSrms3uovSoqDYFMayiYdyA1zf3p/To3lUnJOcGycUdUbXnG?=
 =?us-ascii?Q?ig0CBzNCWdfcSaAcFXqwFVXAOGN53R92kYbKqp+4lxmhAdWfoJ/qFsxUY6oc?=
 =?us-ascii?Q?9K6XU9yUj8E45fH3nFBcJlTb1NJcI3egRgBDXgvVA/5MTFa24wza/vNDDSMG?=
 =?us-ascii?Q?X7qWQc3LXYOKIk+83EFVkas0M2PDY6xJvmodnU4hz76y4VK2WQFqwTgogtW7?=
 =?us-ascii?Q?Cmwdlfg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fQlmWH1hriSr1JNP+p7jfI6qxOalWQ8Tas7MzUZ2GK89Kv63TXvsnoDfk+Bh?=
 =?us-ascii?Q?PtlCF2I0OE/M7gSd5DX8IopClNjSBqlXqqC2OkRphXMM3insKoAf5a6AhnPZ?=
 =?us-ascii?Q?Brds+gDBF5qS5cG/hsqu0Igv1fvoLdmLOEAqloPrlgqLwZpqmp1kfQdtssGI?=
 =?us-ascii?Q?YwTlg3QblKeFs7dzEh5cvQTDgBksST41/soVg8L1mLwLwzFBqIvRsYqMscxy?=
 =?us-ascii?Q?nDWI93JSfx+q14XnJ4AOoBoF8luF/H5BjvgkiBqmJo+CwCmlixHztwayTqWE?=
 =?us-ascii?Q?i2tUAMRBfpv28+NT7n1CJLcgpzZlqGbWNh8LE3Bln6Rufayqd9cQFglx1i4h?=
 =?us-ascii?Q?r9997CoZd0eonaFxUqWb6/oHdaJwyAv6ryXDagDNjgNF5T9TqEfA5R3HVHBN?=
 =?us-ascii?Q?mG3Q9ovxVJ3QP97m2fCfz4/4ZXvaxN6/+zkP2i6QDK2csHxjXqoB3RV6F4V7?=
 =?us-ascii?Q?Sb2krQ/AFpif+6mgE55gvd4Q0oL7h22tLtXBsWlOWELcDKCxCMmLLITU+4G0?=
 =?us-ascii?Q?YL7pw9Q+hwdXdZfIFw7Y0a3VzGul4XkYCDYxGWq1vN5I0zBMkLcYbuVb482X?=
 =?us-ascii?Q?hjOONXx/fF0PnO/GwlIr8xiK8438psH7agtMI+myUfPI6xhbukk/OOc+5Zyc?=
 =?us-ascii?Q?3L77oLoF69GLydy3hxlY08P9tc6Z3wKlgosZwnAmBRaLoSqUCbYJOW/WJJMk?=
 =?us-ascii?Q?utYo8jfJmGvE9D8ThBwkWaBdsAGacKvvEmgZUfIXuUMJff4mGpojZRySbnCt?=
 =?us-ascii?Q?lVpRiBQQd+fTNBzHlejIhLByjBiX/2Fp54aJZajJGPPgEgH51F6MheY+JPZa?=
 =?us-ascii?Q?r1mY3v/RzCb/0EJJDY15d6Rl8TnjLEHifbJqzxuUVghIJJsunBh3rR7FnPNx?=
 =?us-ascii?Q?t4s8wko/Kh6mD4bpM7prXO6hGuJRykwf971X6B0Ybrzj2csa7OH4LCb6ZPJe?=
 =?us-ascii?Q?BmZ1djhJ4+U1+DNNO1DdaghKQRgK1HDd9pnyMatqnwtACh9OVfUcsDL1gMtY?=
 =?us-ascii?Q?PJVQpI9/Y8+sl6uQnVt3rk+O4YZL+I2yi7rDaMeWVNlETM5Su5VqKy9Rjktx?=
 =?us-ascii?Q?ggRdqZsmWIoz35hwg7D9slaQxUlkpJ9kc7puOVKOpGVnHW6Hh1ksZ7fJN76n?=
 =?us-ascii?Q?+yiNt2ThwuDbAfC1boKDQ00YO8K3oj5acxgYXsueZ21jX7rqXpKBYuxKPwnn?=
 =?us-ascii?Q?nCwXrhJl4c6HODz8CFtMrNUlex1F7+W9G8lm5cWAyTG/kOOGPeQw+amYLiAT?=
 =?us-ascii?Q?Z6JVdcgZX4FXHfXVg2e2NZOKhfoODKW+piXK6aUIFpXfXGPUn/iT77KbIznS?=
 =?us-ascii?Q?m8aS4R1ibz1ReXHLENAd0HPbzcGovMvLHOu0zwtzwgzjCXYij4mShOpULwpi?=
 =?us-ascii?Q?rc2Cc2nPwzE+wFYewIc8iqjC2yX2TYs0nndsMZ8a4v3Das6aafFFU1W4WK0l?=
 =?us-ascii?Q?qt7YzA3uaU1qD+s5KSzC9V5/k1x4p3wir6nyjPVPoh3CnJTdoDcuTxDclIZR?=
 =?us-ascii?Q?k5RqmAXqFoYJXG1IJNSRkL403W2CsJfed42Dfoh+aH5vA6T/Gtkl2w5xSyq+?=
 =?us-ascii?Q?yUZywWorb5C67RyiMc3wg4Pz9kgwV3cpsNACnHn4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9424a3-0bd2-4764-c799-08dd0875b83e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 08:39:45.4652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90Ob5RoVdDEL7SxKnZgePivDL5DkURJ2YGsDV8n4SjWXpUJdXiOaRK+OVfEMoAryOj/iSC45ZFYoy2nqsOTVrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7160

In addition to supporting Rx checksum offload, i.MX95 ENETC also supports
Tx checksum offload. The transmit checksum offload is implemented through
the Tx BD. To support Tx checksum offload, software needs to fill some
auxiliary information in Tx BD, such as IP version, IP header offset and
size, whether L4 is UDP or TCP, etc.

Same as Rx checksum offload, Tx checksum offload capability isn't defined
in register, so tx_csum bit is added to struct enetc_drvdata to indicate
whether the device supports Tx checksum offload.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v2: refine enetc_tx_csum_offload_check().
v3:
1. refine enetc_tx_csum_offload_check() and enetc_skb_is_tcp() through
skb->csum_offset instead of touching skb->data.
2. add enetc_skb_is_ipv6() helper function
v4: no changes
v5:
1. remove 'inline' from enetc_skb_is_ipv6() and enetc_skb_is_tcp().
2. temp_bd.ipcs is no need to be set due to Linux always aclculates
the IPv4 checksum, so remove it.
3. simplify the setting of temp_bd.l3t.
4. remove the error log from the datapath
v6: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 47 ++++++++++++++++---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  2 +
 .../net/ethernet/freescale/enetc/enetc_hw.h   | 14 ++++--
 .../freescale/enetc/enetc_pf_common.c         |  3 ++
 4 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 3137b6ee62d3..94a78dca86e1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -143,6 +143,27 @@ static int enetc_ptp_parse(struct sk_buff *skb, u8 *udp,
 	return 0;
 }
 
+static bool enetc_tx_csum_offload_check(struct sk_buff *skb)
+{
+	switch (skb->csum_offset) {
+	case offsetof(struct tcphdr, check):
+	case offsetof(struct udphdr, check):
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool enetc_skb_is_ipv6(struct sk_buff *skb)
+{
+	return vlan_get_protocol(skb) == htons(ETH_P_IPV6);
+}
+
+static bool enetc_skb_is_tcp(struct sk_buff *skb)
+{
+	return skb->csum_offset == offsetof(struct tcphdr, check);
+}
+
 static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
@@ -160,6 +181,23 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	dma_addr_t dma;
 	u8 flags = 0;
 
+	enetc_clear_tx_bd(&temp_bd);
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		/* Can not support TSD and checksum offload at the same time */
+		if (priv->active_offloads & ENETC_F_TXCSUM &&
+		    enetc_tx_csum_offload_check(skb) && !tx_ring->tsd_enable) {
+			temp_bd.l3_start = skb_network_offset(skb);
+			temp_bd.l3_hdr_size = skb_network_header_len(skb) / 4;
+			temp_bd.l3t = enetc_skb_is_ipv6(skb);
+			temp_bd.l4t = enetc_skb_is_tcp(skb) ? ENETC_TXBD_L4T_TCP :
+							      ENETC_TXBD_L4T_UDP;
+			flags |= ENETC_TXBD_FLAGS_CSUM_LSO | ENETC_TXBD_FLAGS_L4CS;
+		} else {
+			if (skb_checksum_help(skb))
+				return 0;
+		}
+	}
+
 	i = tx_ring->next_to_use;
 	txbd = ENETC_TXBD(*tx_ring, i);
 	prefetchw(txbd);
@@ -170,7 +208,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 
 	temp_bd.addr = cpu_to_le64(dma);
 	temp_bd.buf_len = cpu_to_le16(len);
-	temp_bd.lstatus = 0;
 
 	tx_swbd = &tx_ring->tx_swbd[i];
 	tx_swbd->dma = dma;
@@ -591,7 +628,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_bdr *tx_ring;
-	int count, err;
+	int count;
 
 	/* Queue one-step Sync packet if already locked */
 	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
@@ -624,11 +661,6 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 			return NETDEV_TX_BUSY;
 		}
 
-		if (skb->ip_summed == CHECKSUM_PARTIAL) {
-			err = skb_checksum_help(skb);
-			if (err)
-				goto drop_packet_err;
-		}
 		enetc_lock_mdio();
 		count = enetc_map_tx_buffs(tx_ring, skb);
 		enetc_unlock_mdio();
@@ -3287,6 +3319,7 @@ static const struct enetc_drvdata enetc4_pf_data = {
 	.sysclk_freq = ENETC_CLK_333M,
 	.pmac_offset = ENETC4_PMAC_OFFSET,
 	.rx_csum = 1,
+	.tx_csum = 1,
 	.eth_ops = &enetc4_pf_ethtool_ops,
 };
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 5b65f79e05be..ee11ff97e9ed 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -235,6 +235,7 @@ enum enetc_errata {
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
 	u8 rx_csum:1;
+	u8 tx_csum:1;
 	u64 sysclk_freq;
 	const struct ethtool_ops *eth_ops;
 };
@@ -343,6 +344,7 @@ enum enetc_active_offloads {
 	ENETC_F_QCI			= BIT(10),
 	ENETC_F_QBU			= BIT(11),
 	ENETC_F_RXCSUM			= BIT(12),
+	ENETC_F_TXCSUM			= BIT(13),
 };
 
 enum enetc_flags_bit {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 4b8fd1879005..590b1412fadf 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -558,7 +558,12 @@ union enetc_tx_bd {
 		__le16 frm_len;
 		union {
 			struct {
-				u8 reserved[3];
+				u8 l3_start:7;
+				u8 ipcs:1;
+				u8 l3_hdr_size:7;
+				u8 l3t:1;
+				u8 resv:5;
+				u8 l4t:3;
 				u8 flags;
 			}; /* default layout */
 			__le32 txstart;
@@ -582,10 +587,10 @@ union enetc_tx_bd {
 };
 
 enum enetc_txbd_flags {
-	ENETC_TXBD_FLAGS_RES0 = BIT(0), /* reserved */
+	ENETC_TXBD_FLAGS_L4CS = BIT(0), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TSE = BIT(1),
 	ENETC_TXBD_FLAGS_W = BIT(2),
-	ENETC_TXBD_FLAGS_RES3 = BIT(3), /* reserved */
+	ENETC_TXBD_FLAGS_CSUM_LSO = BIT(3), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TXSTART = BIT(4),
 	ENETC_TXBD_FLAGS_EX = BIT(6),
 	ENETC_TXBD_FLAGS_F = BIT(7)
@@ -594,6 +599,9 @@ enum enetc_txbd_flags {
 #define ENETC_TXBD_TXSTART_MASK GENMASK(24, 0)
 #define ENETC_TXBD_FLAGS_OFFSET 24
 
+#define ENETC_TXBD_L4T_UDP	BIT(0)
+#define ENETC_TXBD_L4T_TCP	BIT(1)
+
 static inline __le32 enetc_txbd_set_tx_start(u64 tx_start, u8 flags)
 {
 	u32 temp;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 91e79582a541..3a8a5b6d8c26 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -122,6 +122,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	if (si->drvdata->rx_csum)
 		priv->active_offloads |= ENETC_F_RXCSUM;
 
+	if (si->drvdata->tx_csum)
+		priv->active_offloads |= ENETC_F_TXCSUM;
+
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si)) {
 		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
-- 
2.34.1


