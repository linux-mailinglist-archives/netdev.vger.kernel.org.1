Return-Path: <netdev+bounces-69444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAB384B376
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 12:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055111F20C28
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 11:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B5612EBE1;
	Tue,  6 Feb 2024 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nY9b2a+i"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2057.outbound.protection.outlook.com [40.107.14.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE4F12D152
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218985; cv=fail; b=ZMXD1YIGwMwvZtsRc1cS6jAN9r/OvzHoiu27nZifgiXvRph5KRU3WuwCdgIx47R4mZXkHqH4MSBZtdoqdNZh6mhucTf0hbs9jfqdAUngAfgQP5C+2FoAJoZBq4Vw3+JsUVMwFG2gOsBjyq5ujcODT8JludtoiM7rO8k52xbYoow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218985; c=relaxed/simple;
	bh=klrbzpJt01DwYKX8HWFOJTdyb/ZN7rGSBpGtoxfDR9s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Uf4GIijDIpbcPl3y8xz5w3qY6nQ0hMc2UwshRYpQG/ifU/6iuxxDVmg+9x58kaMObFBW8TnA6HIlw3M0mQVwChLZHhjq5IGom1i/8XbdH8FMU9RNhLxg4pNq1s8nkjSL+pEaPcg9QSl33p2B6evs/ExvDmRvVNgvrsHSpG48rO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nY9b2a+i; arc=fail smtp.client-ip=40.107.14.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sn7ZVVHVFMBUO/CBsgIUBvnooEmY8Ss81mjC9RVMaB6AJWAq63Cdn0Kssf3A4VcoldG/GDzXIj82oSO8KV4A8+Ue3gnUqaqbQhQg002i2XY2WLLi6UYyTl5dv7VVzROpfVUhQRKjg/kzGLwiOgwb46RFgeDglGWPjF31b7Mz6A6j7fGCrUB7pm2NtHixTOpsm/rXRL4kCydiau4iQPmizFETbXIMjV0kHCAUbnqQ429SFzr7bTbMrLNwiT1zXYWwyZVMCGorlmThAhZPymfDI6CedtKiX1PzpMxlcTLZ+wJUtEqEF+zyGeeaDntehwceRXfc3Blmeg0L3TB5XhxQLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwPiCK3y8s5IKFR4F9ymIASlpMhEvPaCFnp0zGaoWFk=;
 b=Sz6RWDFwgokPBs25ZTA5L2huBA4Q69ODYf4nA82FU3xTO2bplZE9/KCMBH9mHdf8RmF/0ipxhuGPuM25gAQB/OIpotSfP1O1KnpcfUpxJEuJRW3i8fx9OI4r36kYGTWms3dzxDB2y37ylmv2q1ER7bKBPcUMYc8uEGTV8POSdVGfNy74VfLn23JlEiCOUdiufQngsBfRQ9bKkoggYZMvZHO5nGZSc5fYl/5+Ygh6GT0kQ8Vg1j5OQiE8DscgTDLT7+gCQak/6Jc8z87WHA+a7LOSVPQ1H5jc9xt6OqhIAg1awy0ksMbMg5Au4KfbO+Fagn2OOc03/bpEt46TC/WMWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwPiCK3y8s5IKFR4F9ymIASlpMhEvPaCFnp0zGaoWFk=;
 b=nY9b2a+iTkdIkPE5UffAxeR0GFS8Btscy3a6JsPqqv0CmfYuToJ9cZF/ujCsyLG+9w/XW3SLBtSX2cIQoTKBIMyyZQSuq6FA2rn+Fk/Z4lid03Bb4J+uTeG9B8byEMeFIfcWjjeakI6o+wsN8pq71F3SX/dgE0Rt0tBc7tvhKaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by PAXPR04MB9057.eurprd04.prod.outlook.com (2603:10a6:102:230::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 11:29:40 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34%7]) with mapi id 15.20.7249.027; Tue, 6 Feb 2024
 11:29:40 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net-next 1/2] net: dsa: remove "inline" from dsa_user_netpoll_send_skb()
Date: Tue,  6 Feb 2024 13:29:26 +0200
Message-Id: <20240206112927.4134375-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR08CA0028.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::41) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|PAXPR04MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: f7490dc7-674e-4cc6-3a4e-08dc2706e82a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dqDUFt48kvuaDLwCBe14F1kAtzO/ney+fFkKRa1TTxSzlZAWKOr1AfJ0NgsWR+9E0mCgOimc8yNBLMwCnvMR2swdI0LLv58w67VC6SunfqZXhT6pAOkxagUC3W5wTv8GRL8qX+l2MAkaSBa/Z6h2vxpJUyKxdLUn7oF6UEKMYctuSUH8zwUWg+o5uEXEddqyXJvaT5MxMI1Ty3haPPOxEvffXvwF0auc79KfbRwovLmFbPiN6h1Q/jW9AvfRIEfjYI1WBoegKvn2tkUIARaOWLtFSfgz642qO8LaXdi5p7GOkwCeJIsbyGK0B1oa+POzHLTDTLEPs8UKCg0XD0+B/FYaZE2jsbP/RZDHYfBuNX4nh8Jh1gIHWrBaSOvEFH6U7qHuMahvaxfNfYTe+Y8vbLEAF9bStgnE5L6RnzE3hclTfvFYmeAIC7mdBb1Z2TxE7cypRG0TxSRCPxR9bLlIIOV06PP3E98KiTsWL8hv/9uiw0y193+FQ6x0neHAbuSXRMihN5+8z34KkXj1g08pEl9VxVL4pC4mId5qILOSKo1CqzmNFEtN3bCD23351yks41V0VG80czUtJOiv7W66eoxnEorVby9Ld6Vp8S5UBh4l5FHxjS7yuZdL62fQ5MqA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(36756003)(38350700005)(4326008)(8936002)(44832011)(86362001)(41300700001)(478600001)(6486002)(66556008)(66476007)(54906003)(6916009)(316002)(66946007)(2906002)(2616005)(26005)(8676002)(38100700002)(4744005)(5660300002)(6666004)(6506007)(83380400001)(1076003)(52116002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LygfjJEqJXAb/hTdB6gVqMOKwmBDYHQRCGYRVWcjfl0f/pr6ghu7M6jS4GbU?=
 =?us-ascii?Q?mExNL+hnHuE0v3wM/lGXbXvtUvG8jTuXquM1RhL6hmhGIzPjo0zy3S13a7tJ?=
 =?us-ascii?Q?Rtc5uKOEEq/gmPQYqGngNFBblZ8NGAbzXPomvs0F5m0k27674iUXagK7fqpl?=
 =?us-ascii?Q?U7I+Zd4R/vN0zfw89XtK9tqWHDmAlETfS0lZih3kS9KP3pJjH/7aZ2WqmNcA?=
 =?us-ascii?Q?/VwnzfD5M3IMmwiLDUDFU7BeDmfZmoLL4m5bPN6dg/Dgx2ljyP+YVNxaYmlH?=
 =?us-ascii?Q?fwNYVdlDPp9YWXHrDNjurfQw/cbuave9EH31DIvdgqyJwWigeQn6Zbgn6Ehi?=
 =?us-ascii?Q?JheKAzXF/N1m+UpdIqeP1HhM71/E3nTSoiRNpr1Fg8cDSSZfZ41rZIdCPIYC?=
 =?us-ascii?Q?Gc/50jrNoiiQRg1SBjkoWGGrGLDGt6LiZWpbpVapxQEH5IP/p8ZcCcqEGS6h?=
 =?us-ascii?Q?FJ2CN555XYAXEq9X4t25VnFn4eyef4oKtBEKt6SNV8ommk2IKzYPU/VSKBB3?=
 =?us-ascii?Q?yLdaCOQc34lTRfXlYRdIZYrbhL664MklpzuiIrYhX2n00ytL4aPSkyC7IIom?=
 =?us-ascii?Q?ukSVFKD7ou9oDdX2qMBvTyX8Rz0n0jE4KyKmzQys19aXIcBkM+Hb4QlzzRSN?=
 =?us-ascii?Q?DPflPVFt/au95pYmFnt/br0hVEbTPOv1nWfSxjFo+XyVClYUtQCw1aSa5VNu?=
 =?us-ascii?Q?UMryce99I6wXrUeAEbxHDI5vT1/5bMi1iKdpa3M49SYXhFmHfHcn9TbnDA/a?=
 =?us-ascii?Q?ajP/AaxHiNsr4J3kAjItuazEXNahYRnnqTNAfZhNEgTMnoDYVVsX8ZocAykq?=
 =?us-ascii?Q?QiYlKazkr0NYyYgYWZQNRLzBgSRYKsfubt+oZ3rPR0lnDFfg6Pbb9L3cstCP?=
 =?us-ascii?Q?RNiy51Hen5dEjY7iCI9iNbJv67bMgBSG8QfKISIApwL9UPR03j4WhaoqNRw5?=
 =?us-ascii?Q?KFI/KOnxfNhFUdrG0PiTP0ENfg22lw73iJ95QTSc4J+oE9zvtj64GN9rZ0w8?=
 =?us-ascii?Q?uhacgdxQPcz82DqTlC/DBOSx/e+TH56lUpv/oJ6fYQn1PGnQo9BEyphewNz+?=
 =?us-ascii?Q?xroxRAKG72wyVDq65wv51yjIHcs2/p6/EGlGyVt6+BA2rMFkaApB90+nv0hJ?=
 =?us-ascii?Q?0n2RT4u3eM07Qws0Pvfqt52B5gcNpnyMePtu82ueqXgAx8qWQvKl1td8r5ea?=
 =?us-ascii?Q?22EJQELSOnxPBq/k1A3JDrZ+5kU3l3Q66S8UxKoxiSVKDCyrdTUZkta7KdAF?=
 =?us-ascii?Q?rXWnO3wmnhbpWGh7cnvN2tVf/v7hIFT9mu6aw5NofNU+AcSGrileYxKsftMH?=
 =?us-ascii?Q?fKQ12yg+hcyTIDNZxwB/jehYbLcLuYDAE8EUitlRg9zAEANr+pyPFYs7426E?=
 =?us-ascii?Q?MmrZ2rHGoVucqpOznmBAcXn0I1hBvJpya7TU/laxhxj/h9QpdIpBJf7ZMBQj?=
 =?us-ascii?Q?t9K2CV79C31AVkkNtnyssYWq5gp7hZQ206Y2XlzxoShUl9PgDKaxpWrWLHQh?=
 =?us-ascii?Q?CTkwoPvTXTiNjLXrm54/psRHqxru60fiIlKZbA3YekaTBhoiw4nSe+CbvOiM?=
 =?us-ascii?Q?C8qPp7viQouq1VbRXwSwS2290uHXuCO5ttwllMZ1C3ODlhcT3ZzMtIyrjPXd?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7490dc7-674e-4cc6-3a4e-08dc2706e82a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 11:29:40.0844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sa/PjMvxY7ZfYe6E8iwZKRBRCg6sx+Glyxz/8K9T67i5TuNzaeNa7/F4Q8zkrlnSLECYNHRq7MzyW1fc4Sm1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9057

The convention is to not use "inline" functions in C files, and let the
compiler decide whether to inline or not.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index ba2e53b5e16a..5d666dfb317d 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -875,8 +875,8 @@ static int dsa_user_port_obj_del(struct net_device *dev, const void *ctx,
 	return err;
 }
 
-static inline netdev_tx_t dsa_user_netpoll_send_skb(struct net_device *dev,
-						    struct sk_buff *skb)
+static netdev_tx_t dsa_user_netpoll_send_skb(struct net_device *dev,
+					     struct sk_buff *skb)
 {
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	struct dsa_user_priv *p = netdev_priv(dev);
-- 
2.34.1


