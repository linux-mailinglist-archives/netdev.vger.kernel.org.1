Return-Path: <netdev+bounces-67480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 671CB843A14
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 10:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B041F2F78B
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 09:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637D360888;
	Wed, 31 Jan 2024 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="eYTGaQzQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2098.outbound.protection.outlook.com [40.107.212.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18236996B
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691338; cv=fail; b=Z8cuEDyJCON2RoeJOPwvqiay6ftCPCvo4cZxPpT8hvfGclH1f9swHbr70Z07urck84dV0IcGNlcJAfVUqtF64K1ZlBvDYfugsXnoZxydshqskv/wmjLPscO1Eo7NrOs1yR7Bg04uhausQC5cQ0gi2PE3ftccf9x/RH2553BrL84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691338; c=relaxed/simple;
	bh=zz+rGST3SQy8Jfj37k96CD9PRq503i/pvGKF6LaWBYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qPKrjM7FEmjJgPYTAyBwIHeFD8U73sUQJ/iXz57M4tiPcOZWEXyTOiTNvuD5f7yoiVZEWcNMknJJUl4Szl0YioH6LuIbh0yefE6pNzSRl+b1xFh2gUv3vkqS0UyyQcqfgaSuhA9gY2QR7n9CHlqzq0kU7yedUd8/XBGdlDBpaWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=eYTGaQzQ; arc=fail smtp.client-ip=40.107.212.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4JL69F63h30j8Kawi6rdyC/wTiE7253xNzvXz9nXMpzJ/IaMmvHlMb4wIn82Gq17/BvNPkStMRRTDCHwAb5t2bGIqc2E03ZSbRpCTYF2l2yandlr/KOTxduaV1my/OfT1JhIkLXkhcla+9Nl5QdLSn/+qOi6cabYw9ffN5RSidaLA3egc81T5d3UNMSwiCLBxSEbSMQufb0a+TM+AOMRWB89qcc/PrlK1Vh5wZ+7g0EWE5wz6MA8PdSv/RPkLRltOofu26hsbDjIPQCfizeiKDcekdKzxM+aS5nPT+4fFEzrmwozHj5R7lUFhfI/DlrTYgjAwatEG39D6TrJ4YFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNqF+8zYkNjga15n96mMWyQRPIYVooz7DuNgcMdkEZU=;
 b=PmTkl0AN+Wu+/n1ir/FP1txJ9mFSV2J/C2PnJlxPXpcpI027AO9pNZtNZcHIF45lLJERYADafRY9SnVeMgM7RbZun61kyYJFjy1gWoCtB6AoVtAIWEnh+1O2b4r+9ZaZB2Y28cEIZZv2SebpehHVKj7nYGP3g30agsIPOK5P5K89iG3vHIa+vr/qwMS2J+eP4+CQKaSX1cHAqF80m6QpQoWGqojzfMKnC/ni34N9mSMKHol61f3BC4uCSVkl+pqIBPvoHhXP527G5FU11JvQFC0AKAPnLujjIb+P6E4V0jiacv7mxMDvkw8OWNseYnQ5tqz/D2INpN++Rk3gPKsiCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNqF+8zYkNjga15n96mMWyQRPIYVooz7DuNgcMdkEZU=;
 b=eYTGaQzQ/C49mGC1dXaesuIy1dMZWLaD2nYfB7pc1zeAEyJt7gQxFHWQKmGOKd604eOe9I7ZmDTykh73UQLTCTtsdFq1OR5OV9KZ2CmzXDY2H9peX4GlrrbDndOSMY84NUP2xyENzJZC1Tfps2QscB88QaV7OmyAYp9qEz+RlKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by PH8PR13MB6248.namprd13.prod.outlook.com (2603:10b6:510:238::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 08:55:32 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::2e1b:fcb6:1e02:4e8a]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::2e1b:fcb6:1e02:4e8a%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 08:55:32 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next 2/2] nfp: customize the dim profiles
Date: Wed, 31 Jan 2024 10:54:26 +0200
Message-Id: <20240131085426.45374-3-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131085426.45374-1-louis.peens@corigine.com>
References: <20240131085426.45374-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JNXP275CA0038.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::26)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|PH8PR13MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c47807f-8f5b-4b54-7d28-08dc223a61ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kfpQJdArGcxDTJt4mIFLvmIXcLbh8ivo3xac0jbnNw/S9AscFjBAQDqhexXdYOTeauSAvn7iAvVb7cQPimZs0UtiputlKxx07S3YcNsWIHbmY64TnU0hSGbDhWQ1qQzaBbPMui8ARQ5sKDP+mMIia0yCjx6ykrQON5QOaggdGjLYy/aS71mNYn+H1VVzm56Qv38f9dmR9/qJNegx3VPCDcnE1xaq9xMkLE8SpdiLonIY7iZj1wYpDNetKDpG9keS4bYH/W0Ifm/rCQv30V22lZRZuU/Cu27c6LbFWnktg+/pnn59kTIjbtDWnk63N7ILtzGkphNgsaIAyConxWHGz/PCY98nsj34O68aVqZmBC+C/vpKlwfWcizwvKJH1d1X16FvShE+FnZ8eq2zD2yZAYLxGz0i0twDhALZTvJ08FS2EaeO+oxuY7C1iTaBrabl0U/lS7y68Nj0Do8BhFoOf/aQgbvuUN2kE1BGyrD1BUMtS2l105BTSMvnzwYC58pXwM20Wtd4bhRU3zzRCE2Sfl9iB2XoKsw5Uq+F8RP/82QpWcYqif9/acBdCLiFt0Xdj8dkXEEYD+qjiLvz5TLTPBWIFXUYt4n0deLeNvLapUBPoV2lUSif8ssrOPsCXojY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39840400004)(396003)(346002)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(2616005)(107886003)(38100700002)(6512007)(44832011)(6506007)(52116002)(6666004)(1076003)(83380400001)(26005)(6486002)(36756003)(478600001)(66556008)(316002)(66476007)(8676002)(8936002)(38350700005)(4326008)(66946007)(110136005)(41300700001)(2906002)(5660300002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4W8ZDCWp3XR7Rd6W8MCV5Yn7gQmQKaR1F5W5Lz0STOKbG8X8DgKDp7SBq0K8?=
 =?us-ascii?Q?Y4B00sFEcIfXr5q40jyLmj268LZtOEiYUqWCUg5gFZC0udRoaVBw5Yn0hst0?=
 =?us-ascii?Q?S28dLbxQt7bfGxo/TFi8oBIdz5tg+ZFuCzUuQSoQCd8Hn9t1X+Pj/gAHPWZL?=
 =?us-ascii?Q?rYPX8o43wxKai7sT1yUYyHXB32jcsw+wrFMDZ1BxOWpS5QDQUKkMvCSfWvOM?=
 =?us-ascii?Q?DMVtQUDPv7X82O7u2ciszk5mJ2qj/EbYVBOQ0PS1Jyg19amVxAdTQN9EjzZI?=
 =?us-ascii?Q?Jh9K0HvXpRANQohagAO8g6t2JItn97ca5ON+7P9NPSLIwLtHLbjPFv94azkr?=
 =?us-ascii?Q?NmB6d3d91mOqvvBV29Z4N8Pb7Rf2TvsrAuvTsLGdE+edaHqILvipW4zroIXB?=
 =?us-ascii?Q?eSDZ6eIC1LcMU4XRVa27qdfjaEnZx5IWRQIfEYVy87ofsNCbJa8AwwpQiapy?=
 =?us-ascii?Q?BPxi7HwUe/oTisVYfvkEfKjh0rYXx3YCHIy1YXmQVVF09k0JoGDFrqXsXqvY?=
 =?us-ascii?Q?4o+HY6gtX2vcb/HZf5RIehj9r2f6COwhwkSNtagbwxe7z5vckPSF+Tk4ebVs?=
 =?us-ascii?Q?QeVlPK9QfHLWyAoCNhCk4zE2dL2SBlE1/k7z6NTwIFDLSzaLglROMBm1sjM4?=
 =?us-ascii?Q?JzAKmxcZgms1J4IHzBYqExJGsBu2w/LCaQpUAUDHpNgd9u9cRzGv5k2APuUs?=
 =?us-ascii?Q?4o8bCP8JqLl4WNOnszluBz7hjpG3PiC3lIKIoyXc/qAp1WzW3unP1zHgJgC0?=
 =?us-ascii?Q?xHRFUHXRskowdjUNm+ysu2RsZsGDRjpvdlUHyrgIVfg8m5tdm93kT+IIDDTw?=
 =?us-ascii?Q?B6StWUOJjo8fraJrv8puD2reKuXgztTRm5YSstJ1tawKcCK4CMDiRrhmSdUx?=
 =?us-ascii?Q?R04lWPVNXmWR+96uIC1AXCFgmcAjf7nRYO6b4OoyiOYH5ganFNMMEzP+GtwQ?=
 =?us-ascii?Q?BpVyTKdKESfpN2O2jjqxT+Tcng0dluKB6AwiLFDzfYHx0/VGenr83uKkeX4J?=
 =?us-ascii?Q?QDNprOr2FYUWprkfUR60EBMvUQfT3FCGFLU22IZJnHK3QGcZSP2VOTKqQJJV?=
 =?us-ascii?Q?wu355UctVXwKFDJ54tDVq9mAPrEiOODmEbf7HHTNDbNbXYTWN/p8kIIa1Fk5?=
 =?us-ascii?Q?sa+i/oEYqnTusoHKxwoaNI9BVMvuSUsNTLuXZGpFs/e0ZNGyQj09+EMtBmLW?=
 =?us-ascii?Q?WIb6ifD2HyJuBjEpBHbXinklnUc2oXyaB4tzfMgCujBrNLrGEpfVURVmxtMT?=
 =?us-ascii?Q?TTEB6prJHbKpjFzh9ZdEciqC8jgsTwVvAF56nv8OcYk98xsvfiaczUWcWWF2?=
 =?us-ascii?Q?oGf8xnj8fpshCUNdqTIzEbHvUjRcyZ5ZbQt2LxIMsUQ+jVIn7TBuqKcimvne?=
 =?us-ascii?Q?tm+DcqCsx7IgX0JNhF9xkpeJMSP4fkSR83bFOTmC73vaO7gCLIHtiiI8nlR9?=
 =?us-ascii?Q?oyo82rWzkzrSzegBTF1W3tLV6LnGtsXdGa0HdcD76m3YgL3L+Vtr1pkzsdzX?=
 =?us-ascii?Q?1Jx4gmU4958/kpNh1NrnC+uRrir+Q7xrkErMtl7UPbh+JAhGTVj3H+9d63/W?=
 =?us-ascii?Q?BvJ3xqq7TymcOljkud+zfxe0bAgX+Dtx0avlhRyvQ1QMRC07i0s1NoXNvkxV?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c47807f-8f5b-4b54-7d28-08dc223a61ce
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:55:32.5007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h57NaYoZ5r5Zu/XYPe9PYPw9vVoL7+F6AyiYXg+LXX3Del6RSg3wxNa6NI+QTSwKoEY54EwY1fFNrfENl+gR7PnRtAX9sDxtmDCz2dihGvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR13MB6248

From: Fei Qin <fei.qin@corigine.com>

The latency with default profiles is not very good when adaptive
interrupt moderation is enabled. This patch customizes the dim
profiles to optimize the latency.

Latency comparison between default and customized profiles for 5
different runs:
                                     Latency (us)
Default profiles     |   158.79 158.05 158.46 157.93 157.42
Customized profiles  |   107.03 106.46 113.01 131.64 107.94

Signed-off-by: Fei Qin <fei.qin@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 .../ethernet/netronome/nfp/nfp_net_common.c   | 27 ++++++++++++++++---
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 3b3210d823e8..cfbcec3045bf 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -1158,16 +1158,28 @@ void nfp_ctrl_close(struct nfp_net *nn)
 	rtnl_unlock();
 }
 
+struct nfp_dim {
+	u16 usec;
+	u16 pkts;
+};
+
 static void nfp_net_rx_dim_work(struct work_struct *work)
 {
+	static const struct nfp_dim rx_profile[] = {
+		{.usec = 0, .pkts = 1},
+		{.usec = 4, .pkts = 32},
+		{.usec = 64, .pkts = 64},
+		{.usec = 128, .pkts = 256},
+		{.usec = 256, .pkts = 256},
+	};
 	struct nfp_net_r_vector *r_vec;
 	unsigned int factor, value;
-	struct dim_cq_moder moder;
+	struct nfp_dim moder;
 	struct nfp_net *nn;
 	struct dim *dim;
 
 	dim = container_of(work, struct dim, work);
-	moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
+	moder = rx_profile[dim->profile_ix];
 	r_vec = container_of(dim, struct nfp_net_r_vector, rx_dim);
 	nn = r_vec->nfp_net;
 
@@ -1190,14 +1202,21 @@ static void nfp_net_rx_dim_work(struct work_struct *work)
 
 static void nfp_net_tx_dim_work(struct work_struct *work)
 {
+	static const struct nfp_dim tx_profile[] = {
+		{.usec = 0, .pkts = 1},
+		{.usec = 4, .pkts = 16},
+		{.usec = 32, .pkts = 64},
+		{.usec = 64, .pkts = 128},
+		{.usec = 128, .pkts = 128},
+	};
 	struct nfp_net_r_vector *r_vec;
 	unsigned int factor, value;
-	struct dim_cq_moder moder;
+	struct nfp_dim moder;
 	struct nfp_net *nn;
 	struct dim *dim;
 
 	dim = container_of(work, struct dim, work);
-	moder = net_dim_get_tx_moderation(dim->mode, dim->profile_ix);
+	moder = tx_profile[dim->profile_ix];
 	r_vec = container_of(dim, struct nfp_net_r_vector, tx_dim);
 	nn = r_vec->nfp_net;
 
-- 
2.34.1


