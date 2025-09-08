Return-Path: <netdev+bounces-220715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5442B48560
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A323A8E1E
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 07:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9822E2DDD;
	Mon,  8 Sep 2025 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DH1RhtlB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C96323371B;
	Mon,  8 Sep 2025 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316913; cv=fail; b=IZkKe+AletUkXZeQMX2CjC106tXxXUOCap9eXwiI1wLeBCV1zlfywFPSmQTNnQ3WQvxuboofhZYQHj2mOPlQqFhcFXfZV7hNJd4ddubce0G/AxURa3G+sOg+6eZq9VOabp7bXsAI0XGGBkMO398/I1BHB/PMtkbH0X2MuaPZ8lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316913; c=relaxed/simple;
	bh=A/KSY/XKTcYU88MEZqQfaf7NfHXMX3pPdCh09pyrzkc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6VYSfUbI+fbSJw+ZraWX4mhVaiaAVx8Zio64TbL5pL/CQ6LoVT5J2XegX0bjp5Y+oEk/QRdzQkZoLeQT1oCHNN4RAh5tEEMGjfZQkZfncIpGGAGRZtarsUjuvMlQ/A9iWD2PCXfAnsbYJGNG3Tt1WQaCzCVvA7ywPytNEmJ1cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DH1RhtlB; arc=fail smtp.client-ip=40.107.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3/n/BHOmpWbrlC7NAzZUt7d/vtU9E+IAkeGxSdwuyicsN78xUEa67f4aWsqTN/VtDYBaBViL7BPzrBmUOgQB2+C58lIomnZ77iu3D6AoW9vJRjm02b9BSQEFTGUbVZE1uKTHtjUx+xeo6YjWy3NugjeOt5ziP8L57VG3M5c32CWGLguJr7Ill/v2KWfu375ZLfBMhb6GD/yAeO+fD00BSC1scg8bgjUpqfnk3euu9S/WxZOg6myZNX2mFAfMcSXy9yj4zdSutBniW830lkTHcPuXNO2Z/LduG28c0f5xOa5k940kUaCegVxod3uip8qVzZ9zcMBILEqapueB6EQjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATbP7E9qmY+kl4q77Pm8aIE6s2rE4IWl/YcMbT+MD6A=;
 b=krpFwqGmohugZvjjwY64cFTSWQKD5RpZsARzK73E1ew2lyk4FHNIu/SnzDmxfURW4OIVjoqzYMATRXhlqYtwXQVpzXUKXndj5Sbl901BSG8o6UOGNdTa6T+f9xDDY8kVMMiPF9nKMjnYPUHlRO5dz1LIPgv9vtVBWnmibCU0/RWKY5rp3NAHP1yaOqmXO2knSblMlroCTIhlVv5fy9yx9OD5CA49hiuFOtQTTVmrgUE4PACd3eoCpuLryHMsBHCFOxWUkSSXZJBDWi2QZiVT+/Jq2OYDdiCfZ9fxeJtDkgcpr6gE9aZdmG1yF/7HkNqRa+0AQn5KpTFzdm2J7Uxf5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATbP7E9qmY+kl4q77Pm8aIE6s2rE4IWl/YcMbT+MD6A=;
 b=DH1RhtlBdj27iGRa167BPP3bzNT5IR1ee2j9kG8LJzZqJDDaqh3aGTiArMSd6/4yHG62htwPwPZarwRIwdUOnQ3y4xn1+BchW5/22vgl7hOsXPvLduoZ0HW7B8Dxk8R8/ztgVMvqY6Ccw/tN9KjBiHw4UGl4wM/z6LbbCTlEt7adzfD1GTIb20uRFM05gY2y/U9S8i4PynPdEED3O4hWtbPBBY2hHHD8bxs03YpcE/xyyWyl7rrm24NdsQXsFVkQknbPSORNHCJLGoNljkKwCE+CiDqviGTjqmN19YjzyyMGYNdXwplInpcGdp/FQoS0LtOoG5CeKDdsq/obT1pmAw==
Received: from CH0P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::25)
 by IA1PR12MB8357.namprd12.prod.outlook.com (2603:10b6:208:3ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 07:35:07 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::50) by CH0P220CA0023.outlook.office365.com
 (2603:10b6:610:ef::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 07:35:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 07:35:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 00:34:43 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 00:34:24 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <paul@paul-moore.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>,
	<linux-security-module@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 1/8] ipv4: cipso: Simplify IP options handling in cipso_v4_error()
Date: Mon, 8 Sep 2025 10:32:31 +0300
Message-ID: <20250908073238.119240-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908073238.119240-1-idosch@nvidia.com>
References: <20250908073238.119240-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|IA1PR12MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: 47dc4dd1-dfd6-4f04-bbc3-08ddeeaa3bb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bia4Tg7l34vc7YFhjofqS/fIc1KbFgeqSd96UZGY3m2F7uZuHshEOOwdWreq?=
 =?us-ascii?Q?Lgnfo7AF53VgcaA5cVcROPGfivXDMuOVZ++zyPAboJW9E2HODR6MscxFOr2G?=
 =?us-ascii?Q?jdezeDeOpD05gA8RnsCF+BVOe3rRQL15HSz64e56pdN/BMn6Tr8EmsQLUh2h?=
 =?us-ascii?Q?4GjHfJwtGiWGGk9ozDlWJjVbyGhAaSbo8Ey20AGgzkV2F4toC/lhud3JMJpG?=
 =?us-ascii?Q?kv78tVQy/3kOui8jSOxO+LnmWVEdzcodfGlxd1vSP2l0Jhr6IKM3RsDs1KIq?=
 =?us-ascii?Q?HGzHgZh5vE5deTtNTdcOpHtwUIzh5moncsWyL63U6zE97t5AlXo6Y21g5YQs?=
 =?us-ascii?Q?jzkJpuh9b9iUgxi2tI5q5NCUMgztJ0Jhg/G3ZhXhF7vtC8bmVhUNx4Hb57nd?=
 =?us-ascii?Q?mAox0AY31U41z8Kmo8ajA6a7WqA0aEipQZbV9yCutWNdAi0ZJAjZq9Ha7Ctc?=
 =?us-ascii?Q?cFZZIJFKJ92ruFi7D8n/zh4xJCsvKZkDb+2FOev4ed9LSqULBlMGmrv2X6t3?=
 =?us-ascii?Q?k5OslYRedPW3tqqssHosvRW5B/5Eokpl59MpIupHtxQsFN6qqsjvh52+LX/S?=
 =?us-ascii?Q?iqJTfwHiMb5DIicF//QBSHI4QZLKugfm1LPIU38Mb5BjYcBXv7jnUGHoW3BH?=
 =?us-ascii?Q?RUaExu9jhAwRtAlSMNKMMbfx25ZDu+YDYtlK+mae1mpkqyvfxPqNTiirKYXl?=
 =?us-ascii?Q?jXiUYefXf4oFw0DlDOBOcuaTJJGqv9auW0KTDSzLpOUp2PaUqFfzWncM3jfZ?=
 =?us-ascii?Q?ZhtT637nDXpRPlUhdB8dRmdebYKhbIziqR7B8VvbULTQWCz4TFE39rkKBxcb?=
 =?us-ascii?Q?EtrXWN/cE84ontYOnaMLqympNfD1zuXGtmWp6Afxqmws27w6yYYS34pOUWQ/?=
 =?us-ascii?Q?KHYJjgkyBH0xu3t6CEM8N6aLMvhzQmoPBB7bDwWhOKYgndSRh52wsQZ4hQqt?=
 =?us-ascii?Q?DM0DXdD25cNhEwfu2R+lZR33/3+J8U2eKMjpk+xqFrqENBZ4qTdJiAeKhKph?=
 =?us-ascii?Q?/CZynNu/tBJcBeDg4oWJUmJj0jYSHO4a9+ut662oFZyzBUdfGnL/x2fQ+b/o?=
 =?us-ascii?Q?fgQRhke4Ee4HSOT/EguAfpqsIrA6bg1wUOfrSiFssS6wF5B69QQ8IvIPVYag?=
 =?us-ascii?Q?r6uR6bO/LVOBCgQpthISaF0L4vdILQ9cgP+fpxckuYh9NZeNe1pXZIkYJlnV?=
 =?us-ascii?Q?25eAdJqMEdVUvTkIIcmNR5ADB7adKuKPAMJDduwpH3i4Kq6jvXJPQztHx4Hg?=
 =?us-ascii?Q?IGC0qS0vsUvLRooZT7NzPzT9+1YK9lXDVaCIwc2K2kokklwcBIqxxJvZmE0I?=
 =?us-ascii?Q?vBHXg1Ja0XUHhuBehY043OrhfmNWHfS/O4zdqXQlulPMuAcajByUz3b+ocmB?=
 =?us-ascii?Q?Rly6KbM6qWhmA+Trq/poeXcviVURrEDbD5SQUBO2wx5+QK3XnBOoDdqxK9Dv?=
 =?us-ascii?Q?ps1Cut5QemCt9IikHnguWikWy6xeCSV1WTvqAHQ4/6AJxQVAHnZlaUYz15zN?=
 =?us-ascii?Q?fK5XiBlf54CMQdmL9AIA7+Vf7ktJ9q63aHiU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 07:35:06.5923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47dc4dd1-dfd6-4f04-bbc3-08ddeeaa3bb1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8357

When __ip_options_compile() is called with an skb, the IP options are
parsed from the skb data into the provided IP option argument. This is
in contrast to the case where the skb argument is NULL and the options
are parsed from opt->__data.

Given that cipso_v4_error() always passes an skb to
__ip_options_compile(), there is no need to allocate an extra 40 bytes
(maximum IP options size).

Therefore, simplify the function by removing these extra bytes and make
the function similar to ipv4_send_dest_unreach() which also calls both
__ip_options_compile() and __icmp_send().

This is a preparation for changing the arguments being passed to
__icmp_send().

No functional changes intended.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/cipso_ipv4.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 740af8541d2f..c7c949c37e2d 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1715,8 +1715,7 @@ int cipso_v4_validate(const struct sk_buff *skb, unsigned char **option)
  */
 void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
 {
-	unsigned char optbuf[sizeof(struct ip_options) + 40];
-	struct ip_options *opt = (struct ip_options *)optbuf;
+	struct ip_options opt;
 	int res;
 
 	if (ip_hdr(skb)->protocol == IPPROTO_ICMP || error != -EACCES)
@@ -1727,19 +1726,19 @@ void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
 	 * so we can not use icmp_send and IPCB here.
 	 */
 
-	memset(opt, 0, sizeof(struct ip_options));
-	opt->optlen = ip_hdr(skb)->ihl*4 - sizeof(struct iphdr);
+	memset(&opt, 0, sizeof(opt));
+	opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
 	rcu_read_lock();
-	res = __ip_options_compile(dev_net(skb->dev), opt, skb, NULL);
+	res = __ip_options_compile(dev_net(skb->dev), &opt, skb, NULL);
 	rcu_read_unlock();
 
 	if (res)
 		return;
 
 	if (gateway)
-		__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0, opt);
+		__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0, &opt);
 	else
-		__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0, opt);
+		__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0, &opt);
 }
 
 /**
-- 
2.51.0


