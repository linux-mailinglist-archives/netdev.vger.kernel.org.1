Return-Path: <netdev+bounces-141816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D29C29BC6CB
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 08:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA3F283C6C
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 07:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F23D1DB54C;
	Tue,  5 Nov 2024 07:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="s6ZSepf9"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023106.outbound.protection.outlook.com [40.107.201.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2150618132A;
	Tue,  5 Nov 2024 07:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730791226; cv=fail; b=tlwd/ss68TLS4TpB6iIDCYQvaqfUhhcLIlS2NcY71V/ktOvqvFzW+Kb/WSNmSa4VhiBT2gDJh+LMD4Fn1lBMX5PHV5y2IBkt9OWIIeHemwanHmqE1S0AYe3fimkr7Btsqegrbs5AbOljPQTTBBGnfY0lhgMkxdB9GM+2x8ZHgKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730791226; c=relaxed/simple;
	bh=wP7RB/ZZbrAxM7dUI4fc4JjgDaMkZb211YLsDyezJfA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PR6Lg6GhIDtsOgNXL9c45l5zS7NliZmTSdzApNXlj5mVDMwxd3TZDaCZfMsB5zfOlE1fI3FuHlbKSIao6GHSKG8ziovSxUiRUseMVx++lduKSq1w/PKMb4xY0mVXzgD2BAJkXI9KHizKgKfNki6XRnWl4sivOxFfOuSjL4PtS24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=s6ZSepf9; arc=fail smtp.client-ip=40.107.201.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s03Q48QiwoXQdHV27RL2tEB5T5EfieLjl4816/CFJJxkEpxjVQ9I7CwykVTSzuskjhQGgeDhT+lOh5lpQ+d88RymrNmlMsmKgyYYDfdpybCoo7gZcsvtJQCp10FeWUUEdDMXBWvanZcygVtTwmhJwzaEDknSbNdyZ9l1iRQRq5lyo7vGXpvU++I4wgghYKUfQGZngzE56PP1jk/iUrZhKj6NyROmP9n/TcRAr5ZnIGoV34Rl0i4Rt38ybiN63p4IHu/20YUicOPW0pgGxJkw56DvGkjvR7qCnOVMJcz0ZZ5u1IzGaLzQP3r/D0DkRuvrDUXugh//nzN6X8EQgTfPoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8mq9RVForkhwdRG+WdzcXxEIvUUVBFxdPanxWt8X0Q=;
 b=Joihc4mfzc0xAfAdMkODLglHKJYLPxWUBbBsIYWfECpdS2i0pZToQB531ba07B9xrZama8Nn5VmvEFQayUqwbLiOR+9L/Z6SXxnisEiB70r6U/KD+Rgt+oH1xZjWjRzdS6uIHjO2JYFK66irreHn1o1v+rhN7vzKdgM1dMApCWYV2pT/AXoznmd1x+rlMpp/5ScowC12cxzQZ9FG9nkilO9E3KG4tZxmoJSXRzkhsl0E/B9VAtawZF5DzBB0yjZuCcPTnUF2KbEEt5UaDFW9Z7JVU3qRVIYF1AAb2xS+wW2IXlb0rpIlg9CPW01yFWF/KUAdSW62zWahyKHh5R35SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8mq9RVForkhwdRG+WdzcXxEIvUUVBFxdPanxWt8X0Q=;
 b=s6ZSepf9KFtr2ijWo2m4KrPApyPszCB0qnE8y/BwXNr7VKstYda3dCbizt4OiccuP78hmRerhDoYutEFjHdtwjcz9TxALUlDwq3Y0irQpNhPV5JPdY1GMlW/d1XdBIKzffvfBHYITeCGCZJFIYjLkzpamBKy22TmZ5bW+wEwLXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN4PR01MB7520.prod.exchangelabs.com (2603:10b6:806:207::19) by
 BN0PR01MB7133.prod.exchangelabs.com (2603:10b6:408:150::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.15; Tue, 5 Nov 2024 07:20:20 +0000
Received: from SN4PR01MB7520.prod.exchangelabs.com
 ([fe80::3ad8:b11:de24:6087]) by SN4PR01MB7520.prod.exchangelabs.com
 ([fe80::3ad8:b11:de24:6087%4]) with mapi id 15.20.8137.014; Tue, 5 Nov 2024
 07:20:20 +0000
From: Khang Nguyen <khangng@os.amperecomputing.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ampere-linux-kernel@lists.amperecomputing.com,
	Phong Vo <phong@os.amperecomputing.com>,
	Thang Nguyen <thang@os.amperecomputing.com>,
	Khanh Pham <khpham@amperecomputing.com>,
	Phong Vo <pvo@amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Chanh Nguyen <chanh@os.amperecomputing.com>,
	Thu Nguyen <thu@os.amperecomputing.com>,
	Hieu Le <hieul@amperecomputing.com>,
	openbmc@lists.ozlabs.org,
	patches@amperecomputing.com,
	Khang Nguyen <khangng@os.amperecomputing.com>
Subject: [PATCH net-next] net: mctp: Expose transport binding identifier via IFLA attribute
Date: Tue,  5 Nov 2024 14:19:15 +0700
Message-ID: <20241105071915.821871-1-khangng@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To SN4PR01MB7520.prod.exchangelabs.com
 (2603:10b6:806:207::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR01MB7520:EE_|BN0PR01MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f5c98b3-c5af-459f-87d7-08dcfd6a4df4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RQF311FRQUipGlXBEMo/UWCveB+hpQCGABcQdFQzyHfqGRHDWv6BR3LkL6qE?=
 =?us-ascii?Q?MGTTeMbooTuvpfP0O7JlHn+O7nQWV+OvsfCdgma1WQkN17vVjuXHDlUCE2ee?=
 =?us-ascii?Q?VpsWU8hNPjuHZVIuvsoEGQKRURzpr/OMmvHuJGCEGn+VqorJCwvZULxeP9DJ?=
 =?us-ascii?Q?K3gcirTs8pWJ7rVqVlpDzZmKQ5D75ykdBPJDxXUv5+fC7tWTRlONGnXSmWeA?=
 =?us-ascii?Q?XCeAI5hCRVYPvC5+Nuj7mVxgoVLwjwDTDhS33Br6nrMI4IruhNxxtHElLmiU?=
 =?us-ascii?Q?QZOKl07vcdetOiGKnGnFvHD7QfIDO/qutpblIMyih2FXtr1DlX/W2w5Dpcrn?=
 =?us-ascii?Q?JmZ8dsFinznoMz32BtW8dQCsTdA1DSN6cewqZ1CgR90Mp8tbFJ6lrXr17AdW?=
 =?us-ascii?Q?XsXRk0ACkCjvtYlyInu4p1OfyjUr08DIV0vavUVpn+IOsQIFa2E8leKDbTH0?=
 =?us-ascii?Q?myztZ/EMEV9iiv2WsWSbWEPtNyVvxlUux3WphMNLe4uWRPE2kaU/GLQGIIEq?=
 =?us-ascii?Q?tgQjvLeI4GJTBmrQgZ9JJcpEeaMAjqsqW4cMuw47Nf2NuTyNJ61fTp61PlyQ?=
 =?us-ascii?Q?rHVhAzuAeSGZYyXXSjemufAJ3WymV/MzgBvUgB1ikNIS3ug6HwRRCUUQaUrq?=
 =?us-ascii?Q?ub3gaaYOai6pVBtEAcr1jTxCumEx/Kwc3/opKidXrIZ+hdRetc0Y8LOzU6cW?=
 =?us-ascii?Q?5WnObsOzsY6O/AYNhK3WTOmWumuKZZrQc4+L0gQCsGnzTBlam2jLfRTiV45D?=
 =?us-ascii?Q?35RJAVCWdX+ipkq6zm7SWLJOHY6/RivzzQJRg14IusTIba4loqEqIvCYynin?=
 =?us-ascii?Q?BCsgbZXwwSI/wndzV+it24761WENz6Ew+yRl1KPrRcWd5JqxynaA92M9A15V?=
 =?us-ascii?Q?zkpNBHqTnZ9nxB1r9cpYR3d0/gyPuCdW8l2/thq8GntTyAeOswdGAYCSnEvX?=
 =?us-ascii?Q?gfB3Vhp25DKUrBAPbxpD3pCcTYQxqgF+CD4jhrFeKJNH1FhgYuCMRayXnFdG?=
 =?us-ascii?Q?UK24H5Ypj8X0NZJqP+AAQ8qLNG9oNQ/IhNB2yKjHh0smzVaw19rM8gwQL2in?=
 =?us-ascii?Q?mRrua1MAy6hpIdE41bRKtOZ08vBqvBG0oKp2E/R/lkddlUlRllf5zbfihRdT?=
 =?us-ascii?Q?Nt96LQxiUt+nmoW5Hvy3ZFKu7PPI1h1d3MFOk6BUY0FhQ5rF2BrBJ8fV73O2?=
 =?us-ascii?Q?FQjSMa0yQSdEUiSB1IzjJVCl0RFdwulEbEI9jsOzpgS1XupiOI459Fsfm6J8?=
 =?us-ascii?Q?QVVlH/woeHHS4yt78XGLg+PuYkLBnRBG7vhXJu8FQDNj5vHaCUDtKHjbl5sL?=
 =?us-ascii?Q?K3pSTmyn+V8XzhkjH6IzhYbtUE9CSvpNwUE+AJNY3lZqvQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR01MB7520.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fzzfKWWfm2SBaa7v54mSzse4giwc+NQBEJgOxGZTvbqLuZx3g57Tq4MWS+oM?=
 =?us-ascii?Q?vDgd8Q7ViB7xdcJ4fXZKQ2+xcm6EoBSlcOIP3Silu0jyRdDLBPydFqtQagEk?=
 =?us-ascii?Q?1ls34pBhzkX/ycmwdPtsdGA6L4VERvbK80PunnTt1hNlKT34IeyyjJXvwMp6?=
 =?us-ascii?Q?sJF3YKzag3L9BYYFV0CUdfe7yRIY1DZkz0A/w2xK2dnvxd6hL+8KhtN96nt9?=
 =?us-ascii?Q?tVjJEVmnbX3ufqCuKRQhiekOJ8bdWwwxYtOGjKs/AmM1cG+g3BdPRnrwhEKq?=
 =?us-ascii?Q?REWYdeg1M0tXVvCpGC5l7PJNMw9sj4rk+P2bLB3PSrfWmA6yPVsdiaVXlO8e?=
 =?us-ascii?Q?0DeBsm6balw5Bt7s5+8PRNnT/G+4+5YDWDKtA+WKRyT/GzReHWlpAIfbQrla?=
 =?us-ascii?Q?XVoE0VRJ7BpCmB9unboazh67pRG0h1On0g8RqF5hkvK8s3VlI0rq52iq2hgH?=
 =?us-ascii?Q?IZT2W+1U30L5lOm/yKGd0Y0BWaYPtJCQCwkluziaXdJ84Gf5TA8IqduqknNA?=
 =?us-ascii?Q?WXsVoD5IfwEADicCq29hiM5nCjsowr/XC7nYlGCB1JYsQKouJ2j151cAsL60?=
 =?us-ascii?Q?Wlwb+NYG+pVv3Yq0JvN/bQ78pN1EFEs7Xtsk4JJ6yvSMNZ2t6mhGh6j3/6LK?=
 =?us-ascii?Q?qAFxsrXd+hLcs6S1+HZmW4FOcMVhcTXdOxSn3PifCjtZKbWVoeCq98K9w5M4?=
 =?us-ascii?Q?Qj8MTOt0iCIonkKTJcWAyawsK3LQwOqdPVaf86wNNiwL9g0/2ZiJGoiW7a3t?=
 =?us-ascii?Q?1stiO0Y4X0LOb8PqnEIiLfGq93o5+iLpwHd5b47mBEGQ6e2gP5bQn2Ssbxe+?=
 =?us-ascii?Q?nMG/QaCUHIQK+2fNg8A56hVKqGX+XBDDrg41zXR+Hzb3hY09p/sM3/y0L6tf?=
 =?us-ascii?Q?GAW+wMjDJgVQbkZWUvcG5ur5MpfxpBUlN81gmf9oZzRmCTGd6s+zZeJZFnXW?=
 =?us-ascii?Q?w3YSMkWooqCHrmMe1IGitcjvfFzByEezzdlvYByA9TZ3E/KH1jDrC3/N7XHI?=
 =?us-ascii?Q?7RiZ/GrCjfDeAQts/YpSTGrfmo9hMXBIRQTJ6YMtlQhxfGxFtaDHLKQd47p4?=
 =?us-ascii?Q?SbmrRABVTDAfeY3Z+gNf2qfM9IjKfH2KT8ZlyTWWs5k97JmBwi0Mzr0kC5xQ?=
 =?us-ascii?Q?CTY65eDWIHkCaj8FqrWRVJa9OJfBwXyPC5TWPafvctEKbveiuBvO8SehIMVI?=
 =?us-ascii?Q?qCNUhGSYx31AWFn74yQyyDAZWVfUaEU3Kd9QhGg5RaDQEgF0sJQnq7uWv4tW?=
 =?us-ascii?Q?q6ZUu1eZXb2wqVvYgRDFQ12JyGmsjfgg7k/zaQLlmpsY17/0T/jw8KEIxRAu?=
 =?us-ascii?Q?Zo4tb6Od9tpE70WhEjgltFzxe2Iz7vNl2/AXhQPbTRAGWE2JkT0sQRVF6V07?=
 =?us-ascii?Q?dudDk4rL4zapmdrMTl4wpOASgwExWxCPWSKLa/oXyYoVuhcdwWzbJikPktNC?=
 =?us-ascii?Q?xuF7c5F/YrYWXcuS9ej3LUPAYdySQJe3hOrZ5iF87P1T+qgc/cl+cmv9HqrU?=
 =?us-ascii?Q?fNypyBvCDOrI62jQhQZal0ENZJhszIfTl+nLOKpLBDjhXMXSkECkz8yFH9Zj?=
 =?us-ascii?Q?34HzRLFVr6KKi8318aDSqIa+dXgwloADiwyYXLIgEz7LlBp4wMBSMGazEyZ0?=
 =?us-ascii?Q?GdA+SRQCXKCzPMygqcmpkJ4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5c98b3-c5af-459f-87d7-08dcfd6a4df4
X-MS-Exchange-CrossTenant-AuthSource: SN4PR01MB7520.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 07:20:20.0595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7spihQyNUg9s0QaaaoAwZvT6wZGlpfSTIzWkWtC3TGGh+eDmPThXNMexF/0NLDzX7yIl4po7IF2YStIqmuyu7FDgtrnC6faK/OZgiy/Gv2T5zfxjl9HTj8c7VA124uf9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7133

MCTP control protocol implementations are transport binding dependent.
Endpoint discovery is mandatory based on transport binding.
Message timing requirements are specified in each respective transport
binding specification.

However, we currently have no means to get this information from MCTP
links.

Add a IFLA_MCTP_PHYS_BINDING netlink link attribute, which represents
the transport type using the DMTF DSP0239-defined type numbers, returned
as part of RTM_GETLINK data.

We get an IFLA_MCTP_PHYS_BINDING attribute for each MCTP link, for
example:

- 0x00 (unspec) for loopback interface;
- 0x01 (SMBus/I2C) for mctpi2c%d interfaces; and
- 0x05 (serial) for mctpserial%d interfaces.

Signed-off-by: Khang Nguyen <khangng@os.amperecomputing.com>
---
 drivers/net/mctp/mctp-i2c.c    |  3 ++-
 drivers/net/mctp/mctp-i3c.c    |  2 +-
 drivers/net/mctp/mctp-serial.c |  5 +++--
 include/net/mctp.h             | 18 ++++++++++++++++++
 include/net/mctpdevice.h       |  4 +++-
 include/uapi/linux/if_link.h   |  1 +
 net/mctp/device.c              | 12 +++++++++---
 7 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index 4dc057c121f5..86151a03570e 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -877,7 +877,8 @@ static int mctp_i2c_add_netdev(struct mctp_i2c_client *mcli,
 		goto err;
 	}
 
-	rc = mctp_register_netdev(ndev, &mctp_i2c_mctp_ops);
+	rc = mctp_register_netdev(ndev, &mctp_i2c_mctp_ops,
+				  MCTP_PHYS_BINDING_SMBUS);
 	if (rc < 0) {
 		dev_err(&mcli->client->dev,
 			"register netdev \"%s\" failed %d\n",
diff --git a/drivers/net/mctp/mctp-i3c.c b/drivers/net/mctp/mctp-i3c.c
index 1bc87a062686..9adad59b8676 100644
--- a/drivers/net/mctp/mctp-i3c.c
+++ b/drivers/net/mctp/mctp-i3c.c
@@ -607,7 +607,7 @@ __must_hold(&busdevs_lock)
 		goto err_free_uninit;
 	}
 
-	rc = mctp_register_netdev(ndev, NULL);
+	rc = mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_I3C);
 	if (rc < 0) {
 		dev_warn(&ndev->dev, "netdev register failed: %d\n", rc);
 		goto err_free_netdev;
diff --git a/drivers/net/mctp/mctp-serial.c b/drivers/net/mctp/mctp-serial.c
index e63720ec3238..26c9a33fd636 100644
--- a/drivers/net/mctp/mctp-serial.c
+++ b/drivers/net/mctp/mctp-serial.c
@@ -23,6 +23,7 @@
 
 #include <linux/mctp.h>
 #include <net/mctp.h>
+#include <net/mctpdevice.h>
 #include <net/pkt_sched.h>
 
 #define MCTP_SERIAL_MTU		68 /* base mtu (64) + mctp header */
@@ -470,7 +471,7 @@ static int mctp_serial_open(struct tty_struct *tty)
 	spin_lock_init(&dev->lock);
 	INIT_WORK(&dev->tx_work, mctp_serial_tx_work);
 
-	rc = register_netdev(ndev);
+	rc = mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_SERIAL);
 	if (rc)
 		goto free_netdev;
 
@@ -492,7 +493,7 @@ static void mctp_serial_close(struct tty_struct *tty)
 	struct mctp_serial *dev = tty->disc_data;
 	int idx = dev->idx;
 
-	unregister_netdev(dev->netdev);
+	mctp_unregister_netdev(dev->netdev);
 	ida_free(&mctp_serial_ida, idx);
 }
 
diff --git a/include/net/mctp.h b/include/net/mctp.h
index 28d59ae94ca3..1ecbff7116f6 100644
--- a/include/net/mctp.h
+++ b/include/net/mctp.h
@@ -298,4 +298,22 @@ void mctp_routes_exit(void);
 int mctp_device_init(void);
 void mctp_device_exit(void);
 
+/* MCTP IDs and Codes from DMTF specification
+ * "DSP0239 Management Component Transport Protocol (MCTP) IDs and Codes"
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0239_1.11.1.pdf
+ */
+enum mctp_phys_binding {
+	MCTP_PHYS_BINDING_UNSPEC	= 0x00,
+	MCTP_PHYS_BINDING_SMBUS		= 0x01,
+	MCTP_PHYS_BINDING_PCIE_VDM	= 0x02,
+	MCTP_PHYS_BINDING_USB		= 0x03,
+	MCTP_PHYS_BINDING_KCS		= 0x04,
+	MCTP_PHYS_BINDING_SERIAL	= 0x05,
+	MCTP_PHYS_BINDING_I3C		= 0x06,
+	MCTP_PHYS_BINDING_MMBI		= 0x07,
+	MCTP_PHYS_BINDING_PCC		= 0x08,
+	MCTP_PHYS_BINDING_UCIE		= 0x09,
+	MCTP_PHYS_BINDING_VENDOR	= 0xFF,
+};
+
 #endif /* __NET_MCTP_H */
diff --git a/include/net/mctpdevice.h b/include/net/mctpdevice.h
index 5c0d04b5c12c..957d9ef924c5 100644
--- a/include/net/mctpdevice.h
+++ b/include/net/mctpdevice.h
@@ -22,6 +22,7 @@ struct mctp_dev {
 	refcount_t		refs;
 
 	unsigned int		net;
+	enum mctp_phys_binding	binding;
 
 	const struct mctp_netdev_ops *ops;
 
@@ -44,7 +45,8 @@ struct mctp_dev *mctp_dev_get_rtnl(const struct net_device *dev);
 struct mctp_dev *__mctp_dev_get(const struct net_device *dev);
 
 int mctp_register_netdev(struct net_device *dev,
-			 const struct mctp_netdev_ops *ops);
+			 const struct mctp_netdev_ops *ops,
+			 enum mctp_phys_binding binding);
 void mctp_unregister_netdev(struct net_device *dev);
 
 void mctp_dev_hold(struct mctp_dev *mdev);
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 8516c1ccd57a..2575e0cd9b48 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1958,6 +1958,7 @@ struct ifla_rmnet_flags {
 enum {
 	IFLA_MCTP_UNSPEC,
 	IFLA_MCTP_NET,
+	IFLA_MCTP_PHYS_BINDING,
 	__IFLA_MCTP_MAX,
 };
 
diff --git a/net/mctp/device.c b/net/mctp/device.c
index 3d75b919995d..26ce34b7e88e 100644
--- a/net/mctp/device.c
+++ b/net/mctp/device.c
@@ -371,6 +371,8 @@ static int mctp_fill_link_af(struct sk_buff *skb,
 		return -ENODATA;
 	if (nla_put_u32(skb, IFLA_MCTP_NET, mdev->net))
 		return -EMSGSIZE;
+	if (nla_put_u8(skb, IFLA_MCTP_PHYS_BINDING, mdev->binding))
+		return -EMSGSIZE;
 	return 0;
 }
 
@@ -385,6 +387,7 @@ static size_t mctp_get_link_af_size(const struct net_device *dev,
 	if (!mdev)
 		return 0;
 	ret = nla_total_size(4); /* IFLA_MCTP_NET */
+	ret += nla_total_size(1); /* IFLA_MCTP_PHYS_BINDING */
 	mctp_dev_put(mdev);
 	return ret;
 }
@@ -480,7 +483,8 @@ static int mctp_dev_notify(struct notifier_block *this, unsigned long event,
 }
 
 static int mctp_register_netdevice(struct net_device *dev,
-				   const struct mctp_netdev_ops *ops)
+				   const struct mctp_netdev_ops *ops,
+				   enum mctp_phys_binding binding)
 {
 	struct mctp_dev *mdev;
 
@@ -489,17 +493,19 @@ static int mctp_register_netdevice(struct net_device *dev,
 		return PTR_ERR(mdev);
 
 	mdev->ops = ops;
+	mdev->binding = binding;
 
 	return register_netdevice(dev);
 }
 
 int mctp_register_netdev(struct net_device *dev,
-			 const struct mctp_netdev_ops *ops)
+			 const struct mctp_netdev_ops *ops,
+			 enum mctp_phys_binding binding)
 {
 	int rc;
 
 	rtnl_lock();
-	rc = mctp_register_netdevice(dev, ops);
+	rc = mctp_register_netdevice(dev, ops, binding);
 	rtnl_unlock();
 
 	return rc;
-- 
2.43.0


