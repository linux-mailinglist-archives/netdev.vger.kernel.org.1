Return-Path: <netdev+bounces-148520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EC79E1F51
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F3F2166A62
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B131F6690;
	Tue,  3 Dec 2024 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="etYd4pvC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529EF1F666B
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236444; cv=fail; b=TQGGLN8P2IeNnZ+Akh4x7BaZ196Gc4TbIiXS1K7vQROvNpHsKqo1rc2N+EBo0RRFsevUsfeuhI6ETt062p9gBcN2Btqh/U5PSODKvF/aMmBxfD04zoAsvz9FO+5+hnBxkRZZAI32EtJE/t+sBxJu8yX0h7hZkSOpx13QiM3nND8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236444; c=relaxed/simple;
	bh=0QmFPrVoeljshE3RVJrLrbOfvHDE7gM+PG2kPH3o+z8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJs0AHs1ySQ9EUrRRdKiOXl7loxhkh7bllXA6ACprRkJmu14d3SPK24zO/YFDnf66fXEi10j6nOBVOUK/sTqJb/3TvxPYMasIraDp110xjF/nnJMh5PXdRHmA6zJKD/d58h+1QxQXAk0vaJB/hy1sohiFFxilbDhJpngNyPDmUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=etYd4pvC; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y71/o8AfPTFRD1ttTAT3gJ+tUawtChMpz9RKLao7qsUGd1QD5EyanVC/Ruzsn7WgD9vUJSOowg/aoBzSWxaQGG82dybPEyHoQr0Ak5c7h3os9xFUB6mG6xinit5Ox8GQz2prS60bMIAsA+9fA8pe3ktpOff16VJQPlg3GbyrPP7G8J0XaPCfWnoDRxtZuparXJGRRBR4xDd1JymkvNAWs7pcmK2Hcdr1ajZL9hQxsrPqA6ROIOaSguBIQ/YJrlqneI7+kkHbtIen5+3XOJNCarVryiwdbi1gyixQ5zrVy4c5cz/sIULBn06Agh3xa7qUHGKCkqSjf2mHqOC9v5S3Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPCMipYqGYR39DZ+39R6SbaLySfENKqOpks0LSsdB1Q=;
 b=xl5NfV+fkbnU5fMTz9+0LvyG0z6ZBNJ1bn+4qWTrl/Rf6+tJuFz78MfvtBURewmeP2eOjkvgV5Hu9eILBQZFw4FB0jcqIH4Y2bGl0i6CbkVsiit4An/KF0HDQ0nCcFcVn5RaUW7WGAz1Ic/JyyNLhZ+P7fhjmIQ3dufcIeXYM0SqbfNKhUWscJ/tkuEpFbtvVCd1RJnVPO+2dfXh/1xIhB63NSM1oDK9gd6SuQNSH14z9qHHg1My8fQG0j7/RnHDxOipx+rmHvQ5YwkINcTmVENtdK1Lqt4/7BCesYyk57vuGMHQ7uSSALDRS5EyAK1v815xFIggUe1lFnvtKWKplQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPCMipYqGYR39DZ+39R6SbaLySfENKqOpks0LSsdB1Q=;
 b=etYd4pvC5x9dTJ59dPfe4Vo8WXPUZQ0WPxpeiNNBVg6VdjsBgMPVHclkRVtKTmHosiOE3F2zwuu5TfDYxa2nnRfQ+xfYZos4KL5hpJ+QCvlPxevd0krxoCv6id6k9yDj2nMELK0DVVEWmsNkNBO1tcqrPPOb0wudh1d8GncWGrsQjlaugGYHJ7LB5m4x2EhSetzUEN65HB1Yp3jC5fC2vpgzBvo/3KWJA1O0I8d+cJR8ewzbt9X+YTPyoyZU8m/RQPyOKAcv4X4IPTXSGtYwP7ziE+wjU51Bikuqc3rSKJFvUjNR0QGbFmNsn9KVknHpyDAbBc/+kPBUAxBrHW7trQ==
Received: from SJ0PR03CA0277.namprd03.prod.outlook.com (2603:10b6:a03:39e::12)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 14:33:56 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:39e:cafe::d0) by SJ0PR03CA0277.outlook.office365.com
 (2603:10b6:a03:39e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 14:33:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 14:33:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 06:33:35 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 06:33:29 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Menglong Dong <menglong8.dong@gmail.com>, "Guillaume
 Nault" <gnault@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v1 05/11] vxlan: Track reserved bits explicitly as part of the configuration
Date: Tue, 3 Dec 2024 15:30:31 +0100
Message-ID: <a7fe29b08af2ea4745659ca3f89e0634d0ba7eca.1733235367.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733235367.git.petrm@nvidia.com>
References: <cover.1733235367.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|MN6PR12MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: e1401fd3-60cc-43f1-c4ba-08dd13a7848c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BwuM5INChk3JovyRYodudxgDpyQ/OORhWzIdLUKlJ25WR+fpp3HPL6WduRgP?=
 =?us-ascii?Q?lzJQ2uynJTZsAFYi+tKIJ881nMD62VP9r3WORDO+I2gP/5asr43O1ox9jzjS?=
 =?us-ascii?Q?1Tee8fjxIuvFiXUx4p3mjmFPRgv4RZAwq/9/opX1nddIriPIVzniS5nvv2Hd?=
 =?us-ascii?Q?FJp0g5nwwIuI8PX+5+HtOPN31NEqrVjBne/E1dA0hi5gvO/DZlVYp7WVCgJ7?=
 =?us-ascii?Q?aMD7Sb90kUoLxNa3V+KgDHjyriWvnsJW+plL/EPeBFgJHMqsmWgxUGZ0x4X4?=
 =?us-ascii?Q?aHYOjVjmhe0ptfH3ZyTsXiWfvbWJljgQRWTEi9ozod+UrqsbH4d7RYXFcC9/?=
 =?us-ascii?Q?XlfTYizgj2cq+587VWDcXbEaSy0gUigoogHpduta51FVesTh5T0YurJs2BRZ?=
 =?us-ascii?Q?vVxFsfkW/NCqcIXGqbOD9EJbKoQ+auI1IBag5h9IXwxpIcZP6kKG22tfQ9sp?=
 =?us-ascii?Q?4T1g4Mhl4nALEDW7TyNdNfAESOxaKnJbvpTeOnjcbKSxQDNpSsqQmXIYC0zl?=
 =?us-ascii?Q?cCZFK3NJWfoJsGeuIWZbbHbgqmo6bdnIq4amxqyBVNJLJ2Dth5qR1Af8uy79?=
 =?us-ascii?Q?ZZzhnUyZPpFeVXCHAkN1PsEkTKiAsMv7oYakpfwMPW9QbUXIlOc2VcQWYzko?=
 =?us-ascii?Q?jm9WRlqDyAtbFeaClTLT4HQNnawW1Zc1V4bBbH/kZgwVYqdvJyIt0u/PkqTz?=
 =?us-ascii?Q?aBdtym52n6DeN/l9p4BMlNV8gKYotrfus3J//MNsbsrgPtUeTsEynlPpmLNh?=
 =?us-ascii?Q?FWsqLodjg7Mh3PdMNnmmpdV3Z6d0bFa0vk8qKw9cwI8SIu1tNV/WzZoEGcoh?=
 =?us-ascii?Q?aUheQW4nrzynOD5+Nyjx2PmFoFewcKxFOwGg8bFXCeJnikMaBZDGoV7TlKvn?=
 =?us-ascii?Q?UpjGEfSHSfy6CMRJG4eS9jx8veK3WES+2WXPyNDALLFDdxIsnyoFOslbuvq/?=
 =?us-ascii?Q?1EBlWlJffIy/Ar+tJN4MR4sB6ssaL0pzK5REMHdnBpPiL0jpfKjbVnUlvHDQ?=
 =?us-ascii?Q?5jKdtNezyb27wix/8XTL25+kbjRbNDPoHUsUixPsTqh6AvHWQ/maKlqmpaVM?=
 =?us-ascii?Q?PD6qN+WijiY2gijQfsFoVdFvh66JiskgBOBB04cpgeESV042DPydxwBI8U2T?=
 =?us-ascii?Q?/wQHQQq8zYrNanplFUviRKE/wsCDeMS12kngm16HqmCa6VEYnq/Ma8ar0Lpx?=
 =?us-ascii?Q?ZOB3FVJeia2RXtpQ+Zmtrqp8AtU9sDTOuwVkqPhf4dBChrcfN3BZ8O+TQUY6?=
 =?us-ascii?Q?weu6CDRktsQz+KHFb/1XGc9jnD+5laUYpQsa8rwWxFO0syD0+/93AOhzrgqE?=
 =?us-ascii?Q?08dV/SyMnaRj4W38mz/DLATMQYIPQpR4+5/F6IwFnQ5qr8ZmxHWAfv+ZHFFW?=
 =?us-ascii?Q?Mx4PGjWF2orx0YDM2v7YOXdViOHk4jpd7pNPm1WLViUzfkbpfKMY7gvD6vhf?=
 =?us-ascii?Q?NG/UGQIzb2YhG0vX+7qfrrGaVhDQM9bH?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:33:55.9512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1401fd3-60cc-43f1-c4ba-08dd13a7848c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8590

In order to make it possible to configure which bits in VXLAN header should
be considered reserved, introduce a new field vxlan_config::reserved_bits.
Have it cover the whole header, except for the VNI-present bit and the bits
for VNI itself, and have individual enabled features clear more bits off
reserved_bits.

(This is expressed as first constructing a used_bits set, and then
inverting it to get the reserved_bits. The set of used_bits will be useful
on its own for validation of user-set reserved_bits in a following patch.)

The patch also moves a comment relevant to the validation from the unparsed
validation site up to the new site. Logically this patch should add the new
comment, and a later patch that removes the unparsed bits would remove the
old comment. But keeping both legs in the same patch is better from the
history spelunking point of view.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: Menglong Dong <menglong8.dong@gmail.com>
CC: Guillaume Nault <gnault@redhat.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Breno Leitao <leitao@debian.org>

 drivers/net/vxlan/vxlan_core.c | 41 +++++++++++++++++++++++++---------
 include/net/vxlan.h            |  1 +
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 257411d1ccca..f6118de81b8a 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1710,9 +1710,20 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	}
 
-	/* For backwards compatibility, only allow reserved fields to be
-	 * used by VXLAN extensions if explicitly requested.
-	 */
+	if (vh->vx_flags & vxlan->cfg.reserved_bits.vx_flags ||
+	    vh->vx_vni & vxlan->cfg.reserved_bits.vx_vni) {
+		/* If the header uses bits besides those enabled by the
+		 * netdevice configuration, treat this as a malformed packet.
+		 * This behavior diverges from VXLAN RFC (RFC7348) which
+		 * stipulates that bits in reserved in reserved fields are to be
+		 * ignored. The approach here maintains compatibility with
+		 * previous stack code, and also is more robust and provides a
+		 * little more security in adding extensions to VXLAN.
+		 */
+		reason = SKB_DROP_REASON_VXLAN_INVALID_HDR;
+		goto drop;
+	}
+
 	if (vxlan->cfg.flags & VXLAN_F_GPE) {
 		if (!vxlan_parse_gpe_proto(vh, &protocol))
 			goto drop;
@@ -1763,14 +1774,6 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	 */
 
 	if (unparsed.vx_flags || unparsed.vx_vni) {
-		/* If there are any unprocessed flags remaining treat
-		 * this as a malformed packet. This behavior diverges from
-		 * VXLAN RFC (RFC7348) which stipulates that bits in reserved
-		 * in reserved fields are to be ignored. The approach here
-		 * maintains compatibility with previous stack code, and also
-		 * is more robust and provides a little more security in
-		 * adding extensions to VXLAN.
-		 */
 		reason = SKB_DROP_REASON_VXLAN_INVALID_HDR;
 		goto drop;
 	}
@@ -4080,6 +4083,10 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 			 struct net_device *dev, struct vxlan_config *conf,
 			 bool changelink, struct netlink_ext_ack *extack)
 {
+	struct vxlanhdr used_bits = {
+		.vx_flags = VXLAN_HF_VNI,
+		.vx_vni = VXLAN_VNI_MASK,
+	};
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	int err = 0;
 
@@ -4306,6 +4313,8 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 				    extack);
 		if (err)
 			return err;
+		used_bits.vx_flags |= VXLAN_HF_RCO;
+		used_bits.vx_vni |= ~VXLAN_VNI_MASK;
 	}
 
 	if (data[IFLA_VXLAN_GBP]) {
@@ -4313,6 +4322,7 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 				    VXLAN_F_GBP, changelink, false, extack);
 		if (err)
 			return err;
+		used_bits.vx_flags |= VXLAN_GBP_USED_BITS;
 	}
 
 	if (data[IFLA_VXLAN_GPE]) {
@@ -4321,8 +4331,17 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 				    extack);
 		if (err)
 			return err;
+
+		used_bits.vx_flags |= VXLAN_GPE_USED_BITS;
 	}
 
+	/* For backwards compatibility, only allow reserved fields to be
+	 * used by VXLAN extensions if explicitly requested.
+	 */
+	conf->reserved_bits = (struct vxlanhdr) {
+		.vx_flags = ~used_bits.vx_flags,
+		.vx_vni = ~used_bits.vx_vni,
+	};
 	if (data[IFLA_VXLAN_REMCSUM_NOPARTIAL]) {
 		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_REMCSUM_NOPARTIAL,
 				    VXLAN_F_REMCSUM_NOPARTIAL, changelink,
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index 33ba6fc151cf..2dd23ee2bacd 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -227,6 +227,7 @@ struct vxlan_config {
 	unsigned int			addrmax;
 	bool				no_share;
 	enum ifla_vxlan_df		df;
+	struct vxlanhdr			reserved_bits;
 };
 
 enum {
-- 
2.47.0


