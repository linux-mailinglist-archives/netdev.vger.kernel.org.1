Return-Path: <netdev+bounces-128063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C670D977C4D
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 11:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412CE1F27E87
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 09:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63861D6C6B;
	Fri, 13 Sep 2024 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hvXRenZ1"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2054.outbound.protection.outlook.com [40.107.241.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF49175D45
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726220330; cv=fail; b=s9wMMOWyt8Qmwkk2Du9yhFUbgR5WAp+ETlBzAFTD+2qNRJ37OORpPDNBcQI/dzf5Dq4epddu8LtOrjkJSHbWLKBWFklweNAdyewXDj0hSZyicCK3GHjlwi7t1J8wuepG/0ovvkIGfkTXo0PKZODe0zxLwnj0ESQY3WNDlCxcdM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726220330; c=relaxed/simple;
	bh=TnuhbsRMuKfsfNo2kov5Fzp3jMUcTwVh3lVBNEjtpbE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QbtgwtPc5EfDcR2bY7T6gBEY67nYnQQusEtjGlcgEu25sXEb5oQNIoy/y50rIVno+bUSff8Kt94R5dk8Dh2wm7Ee/PnkCrfhq1A3XVC+ieVlcUh8YhFugGhBWpcBX8QBsHtAT44hzU6MeTqNcn6DKBjJi+mmw4mzeubPPuETrs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hvXRenZ1; arc=fail smtp.client-ip=40.107.241.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tymcWO8Q1LrGnc8AJM+dkMq95YDFXlaSwdLoEnTKyhUVy8VApI8O2Cqk1xWRsXrzqheQ43Jl8U+Q3itBmBmLVpWIWpCJxoJiubs2AdC0MW36sKwPEgNO6UY1CS2IjLhBMovW5mrm30XpHPSxo9zwnbzwrRX7xdq8P+fWswjxvmFon6Hu8jlN8q/uKkKcBWy5trSsMvqYXU2AFSwsj7Ho4lDSMjzI4x+HeAgVUb1jTtfVR8vVEFHwgutWs2FcdAF4FKNPxbqJmbdw8HYfNtiOeOFzjqPX7XTHTIVUEr8C4hXU5sUPw/RbtuAuBGZYxBLb8QDqkgzyzaFUtDJt8unnxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tINhlnSwjG5cpjsfqIZTYQDUr2krk4r5cWONZcw4g80=;
 b=O4Cpw1M7YaDIOkwCDJVCbJqbQmPW1GBbeqfRn6cPuldQUly+iD1JdqL8XGhvet9W6l+vK9DElGm0w6Eumh9KlZXKbdG5hGkFiKMooo9BRnHmuSL7YZxuNaexoIZLfDjEb0KzAkBqIwS/ALh1LC13CtiSK03jKQnrISg2vNRupb2a5wbA42F65wNXIFEVkhQ2Thc3WHlk5VWnNNa1a0Dy9dckXZcKyj3qiVTuEXAF8AdgqhrTpdsWvveY7vsJ7vTkom374RH/DE+SSOHvpx+6CeXGGMxa/F/2K4rlPLj7G+8HsezxM8V9X+NJyb9VTZCbaG3h9XV2lqNorGYFeIZ8Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tINhlnSwjG5cpjsfqIZTYQDUr2krk4r5cWONZcw4g80=;
 b=hvXRenZ1abqoXiU1JCEokBqv1U8pUlHw7OabqcsehSTwsiOZjAqCFAXK/mmVbglSxaOfHRv8wsU63CgKRPP9CUVEf785EVxIMIzpxFob0XDgc+ruQK9/31kZUOliNwh5bmhUEG6Ukha7KYgw9KTNVRZSLaNLgm8mXVjkWXsgKVRAJcWHs1zum7qY8BxNgVUuAmKtc+68iJ0ltwQbYMGeeJ57ohOVa52oPoIPfGJWKl93tEl5tMTmxWPYSQilY1pmepq3DNChJsrWONv6F/3o41jTf03uICdXRyuEC29t+RJBk3afYXoS5Wwj+xnBBC1WKItnBfMWUWqKAGEDnqKSsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU4PR04MB10459.eurprd04.prod.outlook.com (2603:10a6:10:56b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 09:38:44 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 09:38:44 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Michal Kubecek <mkubecek@suse.cz>,
	Jakub Kicinski <kuba@kernel.org>,
	Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
Subject: [PATCH ethtool] netlink: rss: retrieve ring count using ETHTOOL_GRXRINGS ioctl
Date: Fri, 13 Sep 2024 12:38:28 +0300
Message-Id: <20240913093828.2549217-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0026.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::39) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU4PR04MB10459:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c24efd-dc39-407e-b7c3-08dcd3d7dbc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IV4FteE+40AuXt0oMWk6cRGOLm9VbAOrzBw/49WPx0odUPnQM3LpRDzUR0h/?=
 =?us-ascii?Q?Tjy+nikZ/E62jMbeI0wgrKqM7nLveDoOnyrM9sYHdiX7lOaN4755Ilwfe4lB?=
 =?us-ascii?Q?imu8uOOImFK3UbzDQELy+IeElFbgikpI7eyo1Fl0qPNUtdCNTRGz5g2agZAe?=
 =?us-ascii?Q?tx7bMj141hRP5WthnPXjquIduzY9aes2BvkNmmEgrU3jbE9PeTFlbg0D2bRM?=
 =?us-ascii?Q?UhyJKRgN7KMtsTYUfY4yp2NZZWbyJ/Mn0MM3YiOO438jjBNNyyR5Br11Ez8G?=
 =?us-ascii?Q?42+i+RpuW0Zjw8D9a0/0/NZ71YQaz9mZxPA0zBI+8zAdG6TKbp4C7mWvdB4G?=
 =?us-ascii?Q?TUPpdh9ClSj8SFFwyrUDqv4EiqT7U6IxtJo7OSZwg3q0cIvPAPVV2+RxpJVY?=
 =?us-ascii?Q?8oTauqxSmIt7TSiyF7xJY7ysKM3ZnE/ttoFN2I/P3Iih0dNKgImw5I/nem5V?=
 =?us-ascii?Q?6LSRBuRaKm3EpzBfGi716NFCx5saqdsE60arswb093dlNnc17IXIRsvyqAUl?=
 =?us-ascii?Q?Rh6KD36n7Fj06o5HLtJ5/psFDXSrhe0NzRWEaViPZeOBDg/xnvIYgNFa0MPm?=
 =?us-ascii?Q?RpQYPL/p9Na522hWsFQMbFGmABLO0mr9Q9XdYB21E3C8n/ndxZ/+PwHKFliB?=
 =?us-ascii?Q?sfQCED+XaacT3dvFY06RcH9wkdPgv5opOBjtf2Ennjmuids46cpbzPFIK5J+?=
 =?us-ascii?Q?AGj/RNmHupFzsGEIqn8G8wFLmskXfpwXAuvmooAyLYd364+KPpMZAtnM+WR+?=
 =?us-ascii?Q?S3+TAmaSyDISABAxFq5YEGr4kdvcUytHMk7bZZNcaWiTEc2CmkJv9edgDKRB?=
 =?us-ascii?Q?TYz+FKqa5YWt5B8FQrRUkx1fvcyh1Uu8kimar5vFQ0wSuf2EqfNw+CRA7/c0?=
 =?us-ascii?Q?Jgh78EkaxAJD7rdn2aQQS1MXCyEq7rdRF2GSTFL1zb7tclLIlAGaG6CgNjGo?=
 =?us-ascii?Q?56BEnhhBytLwStES4xAGZK9Ryz02Iq/ZAOP9xJNHBnG2iHvBE87OsEVlcKzB?=
 =?us-ascii?Q?b2V6IGgo7Wdxpw0jJN9UpwJxQhVMRgFqC/4v9UnDyPZ2kSWA5wCuI3cJAKon?=
 =?us-ascii?Q?Qks2BMnyUjqLbhOVcwTy1dLr2FKRsBE/eJoauUU2a0P7EfwtFJbP642MT/e6?=
 =?us-ascii?Q?4j1HLCWRxNS0Y8HQGTs5GxPpXd8dkohcyz79hhjjUqOndan+EZ/icIhGjmrw?=
 =?us-ascii?Q?ssiNl3x1NBnICI6HNMrMugFEw5FrnjfMayzSYYPTeMfDM/rUObAIg9T5sCNK?=
 =?us-ascii?Q?vBQXO+Nxi5h7fAbB/gV/VKWbwDTn+jX7EwWzA1UmzKO+vOEnbPW1I5PwdVar?=
 =?us-ascii?Q?UFe5TM1vl10G+5ryWxi4MdVLv5NN3Z6cB11USpGPuSUqvYH4vEd6cl46LgUa?=
 =?us-ascii?Q?M9Ih1PkAhZqqA1c7AKmOeWJ189HnEOfG+RKcgAmmD+k/0mZY4g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lYitaR5a1iw/Smz/HgTAvdfUveAq0Cz2+Z+hdNGC707FVr5JZhtN07Q9Qzke?=
 =?us-ascii?Q?FJV4SwcsiVQpA1+Lp6KYG0ZEhzQP9wlrsjOaUbfaSh0pL4/txYiccFC7MHxZ?=
 =?us-ascii?Q?nRrBv14LqLU8yz15MtGH5z5D/ZmbARjMS3xcczLGTmzmaakyxE+ux2Uxqcme?=
 =?us-ascii?Q?2KaSTMS0wIsu4zz4UkJ9aKdENL3RYgkXcWdBJunklrDvLTtKcnWXjUMIRCec?=
 =?us-ascii?Q?b0+4RHIdYHedZ+Ha/qLhbOXRPBHKkP4rqDYNx3DtAHUIzNi6iW9bGb7+O+6h?=
 =?us-ascii?Q?O7TJZvIXofBrqVE5d+kyaMn8jB/DIYmy/FXxoQay0vw/SOVWsQ1zuKr+APi9?=
 =?us-ascii?Q?OU++7VLkazbxSX2YuJF0Knu5AbgJ7zBvz4go2WKHfu6NcARzEj7dmxDomAlt?=
 =?us-ascii?Q?sBkR1290B7I0aWF5Jl7AN2JeF9A8vVIBMbOdsiH/hg3LpkgC32xlF+5dvZii?=
 =?us-ascii?Q?H7M/kuP5nFcyRsXzI240QO1gNQMCqESaC/CXetyZlqUhWq8b1L64hCgcvnv7?=
 =?us-ascii?Q?IjIHo4PXW3ZDtBKfdDDuFrJQjYAyvNnxOplUfTDgs6JBrdqxqp+QDwqsFm09?=
 =?us-ascii?Q?xFo8FXdLFk1nC01IZoA1paGXpZLTnvH/We4SLfLiTRHbCy/r/u5h6F5odeRR?=
 =?us-ascii?Q?jbE5FpQNduIDK783JCAos3BSOc9/fHacATQ+f9tXtRfCrXz5SXpx5SSxGT3H?=
 =?us-ascii?Q?Pd4e/TSRGrCEhukR0NoZUo6LXfNdAS/Y/nyn+2wP0AdEmebF7W+9SmH/vgEr?=
 =?us-ascii?Q?0fWv8jxefaAYhLXyBeNWYYyltgDKD1QTaCaoyEMOQyzN0l6PnGH9kZzXD3vy?=
 =?us-ascii?Q?94F7ZuErxy3jTwzj97LWyhdpeN5eGVT8kiYdEE8wR/uc3DXpb5T9ze65Bfjh?=
 =?us-ascii?Q?oQZX4AS0uThS1c0QKCb98lEODM6empslzhLa709uTeekyv8Vz/SjMH2YQqHs?=
 =?us-ascii?Q?3YHfKRFPOXVhQvg7+vxFauhLBLaR+FVz/ihdI6l6rC/Ws6y8nJiSH6cyB4WZ?=
 =?us-ascii?Q?G5dY2nc8v6hSgZcUWi87esK9tl25yE35/Bhy3yAgIh2zIg02DeLK2d3gC8bL?=
 =?us-ascii?Q?jmD14ngN4z2krXEFTcwCU+xeLKHoMR0Vrnexpvtw2jG2nvr7KjhJCua2ugNw?=
 =?us-ascii?Q?vsQLRIr7z/36Sn1G8ry3IWabn8zlB+aBBeu4igbSaYmQ94A5RXCuFuz08JAF?=
 =?us-ascii?Q?Fn6STTNxgdqAv6jTXZtnRidzWO61sZ21/a+2VpeZS7zZSHR/FtyNfbkX/Fpf?=
 =?us-ascii?Q?buUfB+gLJ12KR/QXMpFjcHq04/gruA10zPcXQcetVfiObBmUMkWeS3RCO2aa?=
 =?us-ascii?Q?SHclo98N0D90K68SQW6PwUmq1DCn1Jo2Fw9IaBJrMeFA5RCt2770+cpfh19n?=
 =?us-ascii?Q?Wh1WDx7+Vc428o6X9sSP4ZDX1qOoZfVOrf8wWbEZow3qdNuzqy4UFMD+RUnS?=
 =?us-ascii?Q?v5nIBuBPRagNofh0MnSQvVr1kcEQr5D5cC+ZUoZ2oH/aVk9B0r4BSx3Vga8O?=
 =?us-ascii?Q?yzpcgxNm4ppPv1EpAN39UvGXwYbezWgY+J77fK+3kADbOrjy+vLol8YO7vPh?=
 =?us-ascii?Q?Hw+QNUyFl6RkoWrhEpAlCLqPR5L2MSzP8VXn0qXlsaBJwVDOL+1nd+2odYrI?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c24efd-dc39-407e-b7c3-08dcd3d7dbc0
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 09:38:43.9823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLgW8YvrVahWjZtqb8I7g82eNlj1sAS92picEOzma/UZMT33ElWEm0qF2syqya/3pW24gVPjVByxuBQHOPNvlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10459

Several drivers regressed when ethtool --show-rxfh was converted from
ioctl to netlink. This is because ETHTOOL_GRXRINGS was converted to
ETHTOOL_MSG_CHANNELS_GET, which is semantically equivalent to
ETHTOOL_GCHANNELS but different from ETHTOOL_GRXRINGS. Drivers which
implement ETHTOOL_GRXRINGS do not necessarily implement ETHTOOL_GCHANNELS
or its netlink equivalent.

According to the man page, "A channel is an IRQ and the set of queues
that can trigger that IRQ.", which is different from the definition of
a queue/ring. So we shouldn't be attempting to query the # of rings for
the ioctl variant, but the # of channels for the netlink variant anyway.

Reimplement the args->num_rings retrieval as in do_grxfh(), aka using
the ETHTOOL_GRXRINGS ioctl.

Link: https://lore.kernel.org/netdev/20240711114535.pfrlbih3ehajnpvh@skbuf/
Fixes: ffab99c1f382 ("netlink: add netlink handler for get rss (-x)")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 ethtool.c     |  2 +-
 internal.h    |  1 +
 netlink/rss.c | 55 +++++++++++++++++++--------------------------------
 3 files changed, 22 insertions(+), 36 deletions(-)

diff --git a/ethtool.c b/ethtool.c
index 98690df05992..89c0edefe8eb 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6369,7 +6369,7 @@ static int do_perqueue(struct cmd_context *ctx)
 	return 0;
 }
 
-static int ioctl_init(struct cmd_context *ctx, bool no_dev)
+int ioctl_init(struct cmd_context *ctx, bool no_dev)
 {
 	if (no_dev) {
 		ctx->fd = -1;
diff --git a/internal.h b/internal.h
index 3923719c39d5..1bd5515fc9f7 100644
--- a/internal.h
+++ b/internal.h
@@ -293,6 +293,7 @@ int test_fclose(FILE *fh);
 #endif
 #endif
 
+int ioctl_init(struct cmd_context *ctx, bool no_dev);
 int send_ioctl(struct cmd_context *ctx, void *cmd);
 
 void dump_hex(FILE *f, const u8 *data, int len, int offset);
diff --git a/netlink/rss.c b/netlink/rss.c
index 4ad6065ef698..d0045b1f0f8f 100644
--- a/netlink/rss.c
+++ b/netlink/rss.c
@@ -54,29 +54,29 @@ void dump_json_rss_info(struct cmd_context *ctx, u32 *indir_table,
 	close_json_object();
 }
 
-int get_channels_cb(const struct nlmsghdr *nlhdr, void *data)
+/* There is no netlink equivalent for ETHTOOL_GRXRINGS. */
+static int get_num_rings(struct cb_args *args)
 {
-	const struct nlattr *tb[ETHTOOL_A_CHANNELS_MAX + 1] = {};
-	DECLARE_ATTR_TB_INFO(tb);
-	struct cb_args *args = data;
 	struct nl_context *nlctx = args->nlctx;
-	bool silent;
-	int err_ret;
+	struct cmd_context *ctx = nlctx->ctx;
+	struct ethtool_rxnfc ring_count = {
+		.cmd = ETHTOOL_GRXRINGS,
+	};
 	int ret;
 
-	silent = nlctx->is_dump || nlctx->is_monitor;
-	err_ret = silent ? MNL_CB_OK : MNL_CB_ERROR;
-	ret = mnl_attr_parse(nlhdr, GENL_HDRLEN, attr_cb, &tb_info);
-	if (ret < 0)
-		return err_ret;
-	nlctx->devname = get_dev_name(tb[ETHTOOL_A_CHANNELS_HEADER]);
-	if (!dev_ok(nlctx))
-		return err_ret;
-	if (tb[ETHTOOL_A_CHANNELS_COMBINED_COUNT])
-		args->num_rings = mnl_attr_get_u32(tb[ETHTOOL_A_CHANNELS_COMBINED_COUNT]);
-	if (tb[ETHTOOL_A_CHANNELS_RX_COUNT])
-		args->num_rings += mnl_attr_get_u32(tb[ETHTOOL_A_CHANNELS_RX_COUNT]);
-	return MNL_CB_OK;
+	ret = ioctl_init(ctx, false);
+	if (ret)
+		return ret;
+
+	ret = send_ioctl(ctx, &ring_count);
+	if (ret) {
+		perror("Cannot get RX ring count");
+		return ret;
+	}
+
+	args->num_rings = (u32)ring_count.data;
+
+	return 0;
 }
 
 int rss_reply_cb(const struct nlmsghdr *nlhdr, void *data)
@@ -131,22 +131,7 @@ int rss_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 	if (ret < 0)
 		return silent ? MNL_CB_OK : MNL_CB_ERROR;
 
-	nlctx->devname = get_dev_name(tb[ETHTOOL_A_RSS_HEADER]);
-	if (!dev_ok(nlctx))
-		return MNL_CB_OK;
-
-	/* Fetch ring count info into args->num_rings */
-	ret = nlsock_prep_get_request(nlctx->ethnl2_socket,
-				      ETHTOOL_MSG_CHANNELS_GET,
-				      ETHTOOL_A_CHANNELS_HEADER, 0);
-	if (ret < 0)
-		return MNL_CB_ERROR;
-
-	ret = nlsock_sendmsg(nlctx->ethnl2_socket, NULL);
-	if (ret < 0)
-		return MNL_CB_ERROR;
-
-	ret = nlsock_process_reply(nlctx->ethnl2_socket, get_channels_cb, args);
+	ret = get_num_rings(args);
 	if (ret < 0)
 		return MNL_CB_ERROR;
 
-- 
2.34.1


