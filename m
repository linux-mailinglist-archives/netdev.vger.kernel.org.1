Return-Path: <netdev+bounces-50027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E057F44CF
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 12:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3631F211A6
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 11:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32CF56453;
	Wed, 22 Nov 2023 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="M9UEP01X"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2102.outbound.protection.outlook.com [40.107.247.102])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE17F19D
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 03:20:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKE3ijsllUKLX/5nL64+3/96MSwT83BiRAro1XbLOctL0Yqs5CWtXmPyQXq5cgQps6L8B4rgl0cZ/YROFQobVlVoYga9ozAHSaOAGjMCxhhQJUvOsl/5zllhrXwzwUfnOtksRqPLTgwNnMJ6dzSEHhlQEteieOEgn0EoqXFFteJy4NmnNKG5RSKxiQoCJzqQC2i9I3+KhT8Uh8uE34P3+4iH8f/sbKMHyi3cNwYI308sIVaLarhNUYX0vtPyNj9DO02R0Dsc3hMp/X66F2NfdrKWpdjcV8luR+K8bnSDBNYzFm8hJWiKExLEx2jwZIZ7KSX9cqCRx3GhIodn1tMCjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WF9+AB4pv5obBa5Dz3WVHUzEk3+Mx4Za5QMtoPQqwEM=;
 b=K6/LzSjhXqIxNKK/nt1sJ+83oq5QpFR+VudJNTpN+oDV97jrw35zdHsI44WzDGApy+nzVzCM69mK/YDURhbxxdw7lctMGR2o7P+6UpTKc30dEWID7CpVbbI0KRXGn9O/jji1ddHE37xb7PZPx011uSiTIl2Dm9B+WhTxkqrZbexTSkHqvGj5BuGIyXyuSIkNwa25hK9M7tgh0wvg96wewBodH+9tAcOTfd8zXsZkT8FcI2uc+4+fORkZkLmxdPiwVRShUA6JyEYXBxHWv4tNuRf7oDAa43CtAPY75Whrtjk3wmS1h85QwZtqIYlxIYfiXG+hZsDD/L/AOUegVxyOCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WF9+AB4pv5obBa5Dz3WVHUzEk3+Mx4Za5QMtoPQqwEM=;
 b=M9UEP01X6juFXwdg8KT0qe5DZKvvDNTsvCxmjsmiZHPRMyUgxY/nfVfrHa1o/um8r2hdVsOELonE+eki6cJ23cP4mkgryF/74KkICvno9nqZTw3P8/rgmph0jx4+DYQey5xtxGoR6s7DMYZ0zbbwSqImF+xXpZGhgSdxP/yNuQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by VI1PR10MB8062.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 11:20:19 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15%5]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 11:20:19 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Per Noergaard Christensen <per.christensen@prevas.dk>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH net-next] net: dsa: microchip: add MRP software ring support
Date: Wed, 22 Nov 2023 12:20:06 +0100
Message-Id: <20231122112006.255811-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::16) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|VI1PR10MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d1aff37-a4ab-43b7-7eec-08dbeb4d02de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4LXTrKV53n0/JM3Mo9zS+VbJ+vljjM8Kiuu+Y7nwJFDiCxowqBm+NHXI8CT9yF6NKuPmFLKV0qZfyJFKwMdH57CEEM38Ch7C4W0v5iNrEbAOopKk6WB83cCWcQQ0Z0ZLtOYMkRGe/NqMkDBaw9PoO8lr26r2N33VTA4TSRGuR6JdgnXHZwCU8vxjmts0NkaowgHai6FZ9pBBIqp1Fnz3ZCCNUBYEY0pcW+7ZWSMKZq5l0oWXYBff1iSJ/SrSgfbM1DG4vLpQmibR5Qgf43te7L17iOtinh8YkRNvuMOiMJF7fTOytAZjw0KRj/4bqHIETJDVL+bRGeRfbZWhagax2C7v5oI31yk0kH5weV0HPbEQdjfPBfyaua42eURMd37gaZLMEyIk0QssWDHsIccXaWOovQSI8/Nh7r6enpC4ZWUwtxbdUwUBen4Y5PDboLllj3pw+RJRfOTOOQw3WoeZAEVkzQXVu5D6OO4ltpBfo81Yz6ZltqNN6Q0u2IIuTeiIIvTT0giAZt4pXfe8ErAFYc6i+LgrvfKf5V3G0mImi2DxKWyb+FLjvd/USk4hXQy/Sjypblb9J45dUWWjNCel8+HNU1Hu6MaBITa/tA2e2FCH3vx2cklSqW/C3CQkGhZe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(366004)(376002)(346002)(136003)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(66476007)(66556008)(66946007)(54906003)(6506007)(4326008)(83380400001)(110136005)(38100700002)(8976002)(8676002)(8936002)(26005)(1076003)(52116002)(316002)(6666004)(44832011)(7416002)(107886003)(2906002)(38350700005)(86362001)(6486002)(5660300002)(478600001)(6512007)(41300700001)(36756003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PStwsJD9M6Cbe71EidmxsDTrpVlbCRoY0uNkJ5zjkIhLTvTyqbCv75u5OD+D?=
 =?us-ascii?Q?vFpA5IEj8scFYqZQgc//SNnwH7Li3sUuGLpcfCbOO/WsfAJARFL+SVp7Ex/M?=
 =?us-ascii?Q?nbXrl6SrAKP7zbmkI/90lBxgbfXkPkT9ejR0C0bAInaA2YEht5xDgDPZrxZm?=
 =?us-ascii?Q?vci0Jco+gMN8Ww3EjSYH4RqSSIc69+rv4rpAIZvzDDLInJVc281c+BwLi/1S?=
 =?us-ascii?Q?aKbwVB5a2uOjGd2MbonTrrWZ/QwE0xuSE1x+3KMsuexdZFz13NMysUcvcdjT?=
 =?us-ascii?Q?8AQhtZ3xbqyl1ycTIfGPB3IYm/kUzgvlcDjCfIqsEWaKgZKA/BM8JXLAHqdC?=
 =?us-ascii?Q?PK8l65H7qd/dapELHkKSxHu3ScUDQwOPCJy6QwJmvWA6bwfQXmKO0gVdoyee?=
 =?us-ascii?Q?3euM4sjq4db1gokYiQ0d26QJoHwJqqqule7E1v+a4N60VWgE4hGRHohGL+A/?=
 =?us-ascii?Q?vyEykNTj+Eay8MU7yrL9/ZmpiS1bRhwPZYmjWG0CHEJVQMD4S8N0x0YzZFfM?=
 =?us-ascii?Q?TLyJWa4tuPnW5ZJvxunn/UOw4CrYKIp5RVGclKsBqsMLLl33GaWEwKRWyKMs?=
 =?us-ascii?Q?1XR2mLryibkbRaQlzT0Raify1qIzw4vwPd8ZgeA9h0KDtZXqiXlH34+wyg1P?=
 =?us-ascii?Q?8PoG6xqBv8E12FxKDhCSoAeZbIatRrZhQfzkEXOv3OsTXff4kx59ZAU/YWQs?=
 =?us-ascii?Q?XLYkCMnsiLHkjqPx8j3wF0CH7GVu1sVQXpGn6uZsnqQ8d1WyrXJiCch3qGFj?=
 =?us-ascii?Q?D4pzCPuy7saE/kl5SGb0EU7yUjOsdIgf8WvcfjLlgZ98L1VFWMGkm9WX91LY?=
 =?us-ascii?Q?P3qipJbeF+B28j3FYxh7Fe2vdVUl7TH0smuDuDD4BStzfpOvFV3hkhSKnX8l?=
 =?us-ascii?Q?UkDVHswUVMP609AHb7RWsFVPPKyG7mzPbxYvCA9Fsgedk/mx3MZF282lTu8+?=
 =?us-ascii?Q?kUlbCTDQp2gZIz1ZglKMQsvtqqGQab8YX6uNlDfFOBkU2YZ51lNrvJJ1dV6p?=
 =?us-ascii?Q?W/NV4sYyb/zl1jipSfDZMijAWHM4Rl3sX5yA+2YawJo9cJjhv4LJBdzvX+42?=
 =?us-ascii?Q?uq9z6heU3/oWpJ6im2DzoYsHaIjlw/RjlZZE/ir/paWCfXTFcoZZVHm29X6B?=
 =?us-ascii?Q?dH/Kgj1SK192+ges2xmxsQldf4iBJ1MuFqVOh5D3KB7pwD9MZAiHLtpS0yr0?=
 =?us-ascii?Q?fW5WTSuIUdzMPED2FOhLUSqCCxctQsRtHa8qVMKW+oL2TGYkZtYAMnO+rK0N?=
 =?us-ascii?Q?HQ0+jeEfF2MgX6kNmgcjNAvmU91P/XUyvkjeRGZjF/RNcLjs8jTEWh+C9+VQ?=
 =?us-ascii?Q?UfSmYiS3asdvYX7YBMBpHz99N1OXteU4SE4cpxo4b1CLBNgYTbt/l1JbU368?=
 =?us-ascii?Q?OLUqQUQKHLitQSfT9ObyY7c5wYEQBBiTKH3sIxCIUefClDgQZxGLRROTLl7x?=
 =?us-ascii?Q?iam62qxRBOqalkbwztxqFk5uKl1wbELN5rXvD5qrNGqsDUq+8haMnf0zkZge?=
 =?us-ascii?Q?EGSUHg3npf8olJsOELmk9yNK7fqsYORSwX4JzM4yS8pUU1DcDpsOSjsLOUJN?=
 =?us-ascii?Q?CpzhZtQKUV6jLuyFA+rmKrfaCPaA8v7yccYnu+Vcqw4eTnE3WnDHYb16Jl2Q?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1aff37-a4ab-43b7-7eec-08dbeb4d02de
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:20:19.7454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fjCrf9K6kQtONjia9fJHu/4uXlL2DruE7hiX+qoxItb81+FlasfWeTrFWPP8jMCCFT5UYTntETxJPkrjalxmkUVOngYDITbfSoJi9YjRQ7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8062

From: Per Noergaard Christensen <per.christensen@prevas.dk>

Add dummy functions that tells the MRP bridge instance to use
implemented software routines instead of hardware-offloading.

Signed-off-by: Per Noergaard Christensen <per.christensen@prevas.dk>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/net/dsa/microchip/ksz_common.c | 55 ++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz_common.h |  1 +
 2 files changed, 56 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 3fed406fb46a..b0935997dc05 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3566,6 +3566,57 @@ static int ksz_set_wol(struct dsa_switch *ds, int port,
 	return -EOPNOTSUPP;
 }
 
+static int ksz_port_mrp_add(struct dsa_switch *ds, int port,
+			    const struct switchdev_obj_mrp *mrp)
+{
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct ksz_device *dev = ds->priv;
+
+	/* port different from requested mrp ports */
+	if (mrp->p_port != dp->user && mrp->s_port != dp->user)
+		return -EOPNOTSUPP;
+
+	/* save ring id */
+	dev->ports[port].mrp_ring_id = mrp->ring_id;
+	return 0;
+}
+
+static int ksz_port_mrp_del(struct dsa_switch *ds, int port,
+			    const struct switchdev_obj_mrp *mrp)
+{
+	struct ksz_device *dev = ds->priv;
+
+	/* check if port not part of ring id */
+	if (mrp->ring_id != dev->ports[port].mrp_ring_id)
+		return -EOPNOTSUPP;
+
+	/* clear ring id */
+	dev->ports[port].mrp_ring_id = 0;
+	return 0;
+}
+
+static int ksz_port_mrp_add_ring_role(struct dsa_switch *ds, int port,
+				      const struct switchdev_obj_ring_role_mrp *mrp)
+{
+	struct ksz_device *dev = ds->priv;
+
+	if (mrp->sw_backup && dev->ports[port].mrp_ring_id == mrp->ring_id)
+		return 0;
+
+	return -EOPNOTSUPP;
+}
+
+static int ksz_port_mrp_del_ring_role(struct dsa_switch *ds, int port,
+				      const struct switchdev_obj_ring_role_mrp *mrp)
+{
+	struct ksz_device *dev = ds->priv;
+
+	if (mrp->sw_backup && dev->ports[port].mrp_ring_id == mrp->ring_id)
+		return 0;
+
+	return -EOPNOTSUPP;
+}
+
 static int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
 				    const unsigned char *addr)
 {
@@ -3799,6 +3850,10 @@ static const struct dsa_switch_ops ksz_switch_ops = {
 	.port_fdb_del		= ksz_port_fdb_del,
 	.port_mdb_add           = ksz_port_mdb_add,
 	.port_mdb_del           = ksz_port_mdb_del,
+	.port_mrp_add		= ksz_port_mrp_add,
+	.port_mrp_del		= ksz_port_mrp_del,
+	.port_mrp_add_ring_role	= ksz_port_mrp_add_ring_role,
+	.port_mrp_del_ring_role	= ksz_port_mrp_del_ring_role,
 	.port_mirror_add	= ksz_port_mirror_add,
 	.port_mirror_del	= ksz_port_mirror_del,
 	.get_stats64		= ksz_get_stats64,
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index b7e8a403a132..24015f0a9c98 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -110,6 +110,7 @@ struct ksz_port {
 	bool remove_tag;		/* Remove Tag flag set, for ksz8795 only */
 	bool learning;
 	int stp_state;
+	u32 mrp_ring_id;
 	struct phy_device phydev;
 
 	u32 fiber:1;			/* port is fiber */
-- 
2.40.1.1.g1c60b9335d


