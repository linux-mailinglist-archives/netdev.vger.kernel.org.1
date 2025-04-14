Return-Path: <netdev+bounces-182117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D935A87E2F
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7FE1885051
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 10:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A17B27D799;
	Mon, 14 Apr 2025 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BptUTXwK"
X-Original-To: netdev@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011038.outbound.protection.outlook.com [52.103.43.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C5727D774;
	Mon, 14 Apr 2025 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628183; cv=fail; b=MMwKuBSW+kAhac3CCq47Hcn732LzUZwyRZe1p8K2xZDetekNUNRROKPqTX1SOXiZP0FSeZZQ0xYG3vZjZrqQyvFpMcaMVkql2EHPQ40SJkdGkR+5ibA3+VzjL/JOsr0BIZOWrvTvw/8aeeARbB8R8eEF7GMKF8/NeGQgluw3n6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628183; c=relaxed/simple;
	bh=PacMVHLy3VNRqqpG239cDaTJgM/56zMo2ncSMRJLu9c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CO/mBPauaS88BfTlcw/dOVeC1YRAPX9MrsO4Oao6sZ1OcaaT0gBIuqL5gAnlr+VS/wPyttkzLojqLOjvIDKisERymzGvZWn8XM/unEVFPyKTKSE067K1tw83Btkebx41iwW0EpM2WXOvFn7PmawyZ1G9GP+n6uIRKGXEDO5oSzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BptUTXwK; arc=fail smtp.client-ip=52.103.43.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0W8pM3Gqp+n5+4fSi8Y1wTzjQAjXETESZhcoOuWvIchnInHQnBVPHVR8tYc41RVa5utgbYGmwBygl/tSgPbccFR6oVasG9577dYc2r2gY5Yio2uz7XiY/eapyk2vfikl5e42yESEHc/k337fp5hlLJgDYUjdRYj3iJNObdP5HbZnkUjI+qMzMP1EQfF8Rl0hyY5qy1ogXbj5uTD8i5MLb07IQYRn7cxzY+yWbxagEn1CNWJ2lsabQGlMDhtxgLUvAyV8MPTBW/D7VI+pVkJ0VWV9NAXmTbdLEQHocTMBXF17SBsF+kib+/I4QNZr0OLS9lnXYCzZ2buxkkWJ2T1Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoxi1tatPdJRb6kxphS1Zx5K/5VHNaRYx1a9QYgl6y0=;
 b=HU/PYpz511f1cCM1HE4OQ3lbqLKcqQhebYqYDt4IEgPNVMbTkYaQidJbdx7xq06VfUB7iD1xVzaR3R4qCDluqvmFyrFarns6dA7EUct32HTniBrorSZDOtbuM3QxObiG9mNVNxns5jaRxLp8v38Ec1jDbB++rFJz19USP3UR5AZJI5blyYEQZPbD4qAWMPAg5g6Jq601+Sljv0xJj4A0qcof/tknA0h67fOhVyvRWsSvF390YycfD4rEd4MW2fK9IdfJnHs2yYkKCrMebv0P6KtHiIS25J1AS2r91g4h1mmU1v4H7wtbNMoqUBxrVPO1Nwqq900EyPOfLOv7/UQKEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoxi1tatPdJRb6kxphS1Zx5K/5VHNaRYx1a9QYgl6y0=;
 b=BptUTXwKxs/OUa/KaGxRFfBLviFGy0BtSvYq3UQ8eX67pa9mJbsS2c8jsHWC+cBjCT+LvjECn0iqbEXdPr6OCCGbSOZJY9K6H8Zj7YvjQyn5Bj1JYgz/iaonz0kTH2Kai1n3U95bV8pojwImelaOydKUK2BYAsBPfSaAjj6rUHnis8KzPUTaZKkhCqp3bwFy2PDiZDBwReGEOXjnvL2NNJd9U9vU/lEU/I4AaXGZlDawEzVkIn2pHzbUY6XEQdeqKkw7OeeGBptv/o7lFbSPHwN2T9SaKy9T7FQFug0a19BG5KIfXvIF1Mx1z4M3hdvX0aDsD6n+O+GILib+p9MSwQ==
Received: from OSZPR01MB8434.jpnprd01.prod.outlook.com (2603:1096:604:183::12)
 by TY4PR01MB14482.jpnprd01.prod.outlook.com (2603:1096:405:238::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 14 Apr
 2025 10:56:11 +0000
Received: from OSZPR01MB8434.jpnprd01.prod.outlook.com
 ([fe80::7c3f:73bc:3c62:fe7]) by OSZPR01MB8434.jpnprd01.prod.outlook.com
 ([fe80::7c3f:73bc:3c62:fe7%5]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 10:56:11 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Shengyu Qu <wiagn233@outlook.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH net-next v3] net: bridge: locally receive all multicast packets if IFF_ALLMULTI is set
Date: Mon, 14 Apr 2025 18:56:01 +0800
Message-ID:
 <OSZPR01MB8434308370ACAFA90A22980798B32@OSZPR01MB8434.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To OSZPR01MB8434.jpnprd01.prod.outlook.com
 (2603:1096:604:183::12)
X-Microsoft-Original-Message-ID: <20250414105601.8083-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZPR01MB8434:EE_|TY4PR01MB14482:EE_
X-MS-Office365-Filtering-Correlation-Id: ed9acf4e-685b-4c88-638e-08dd7b42f7c9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5062599005|8060799006|19110799003|5072599009|15080799006|7092599003|3412199025|440099028|10035399004|26104999006|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?INfcNy6T6DA3DOZimRW/E3KDWjQ+qvj+M+CROdsFM+7N/+Dk/kG3qE81gcPL?=
 =?us-ascii?Q?tuhKqpLQ3ugtWRX7DfFvSFFIlJCLMXxw0Z+YoB8wmJ0R4+je6JT8QSzFVtpM?=
 =?us-ascii?Q?swTMzyfje/XE+27r8wZoNv02eowNildcq84HZfobul1NOqBQdCH4yhjHAmeZ?=
 =?us-ascii?Q?duifkn5BWF/Ys98O5xw4Kmh5ogmbrKt8s7vbcTzJt4qDBKoyWSXfy1JFERJG?=
 =?us-ascii?Q?q0BVtptHc4JFUMRXZxt63efeMODtxSkdgtUzaEE1O3tkArdBF2A0ESyfxDgj?=
 =?us-ascii?Q?gaHBKE4s08IUYfmTx4FRrcTJnviMHjx9DUUAb324iad3seUmCL7hXj4HPfgh?=
 =?us-ascii?Q?ZqR+n9f7nAQVg68LNf9pD4pA9RAWRFekGmpRe2myPz55MD5WZ33XiS9Dk+MY?=
 =?us-ascii?Q?g2S4RthbwOdCQViVr/xfgCCPj4g/xzpms7HqOqP+VEqDs358bqcKMsucgND/?=
 =?us-ascii?Q?WhRPAV4YhpIBwDdxutjFcKgYMWQsaP3LbnQZq/iI/nBOVppCp7Nus5oH1bIN?=
 =?us-ascii?Q?pZVAKnmbEOykKVzM8mKTxexkFjowHiHmS4PVmYDymLvs9kDv81BqraEA0fe+?=
 =?us-ascii?Q?nqjkXJVkImg8a51p9OAlTHdRu9LhIJOT41UfYHniVRWSTVBD7wK1JUfCMzT8?=
 =?us-ascii?Q?EBFQLWJUSGIXflH0AXZOJ6i0eVIpLgzJALS0Ppd+dvx9RVjZO1ts/Rzi9tMM?=
 =?us-ascii?Q?/hmGnZhD6WFYglM3WLBw8v4ZvE0Fn5Gw0jSLdMNc1FC/gcruRDkGNDCTasEA?=
 =?us-ascii?Q?4bdq3PGcm8/1cuVXCo48cVOGMgOJ5TVkT/h2BAE51MwHaUj2Ff8LO/VlXvMQ?=
 =?us-ascii?Q?nmAryEc570lhwtWGZU8/rRquElSlrwcAHTta1TY5Rv3TbdEZSW6OedHbjXzi?=
 =?us-ascii?Q?SVXjbZOHQkvmOkuJ/OHNerY4EQa9f1Dv4thjjWWEsok0qJijIMTU7oVZMv3n?=
 =?us-ascii?Q?b5p8Xg3UaaZCft6nlZiyG3UuZTaiYMCYyutl6IgA84BPXW0lFRXM4eN2L05L?=
 =?us-ascii?Q?ZAfof/+zFAOj10bH4KvdZoqL9hv2zYVO78LZTzLGC0gjmtoIDdSgADxP/nK3?=
 =?us-ascii?Q?bwX3j3gX7ZTmVoseyuF1uJsVQKJceaLjXhxuagDq2b306uG7GexP66xeOIr4?=
 =?us-ascii?Q?qTPttALJAeDapiEYmn+crqH5Exlf1FQOEU+2acEnk2IXOS5z+O0kfBMAIskS?=
 =?us-ascii?Q?sMFtkuPQOJdMFLAGMcpI5321cy33lm+bJw2QsCZTLUfVsXbQlTY7YbreDLwo?=
 =?us-ascii?Q?p2Kddz4HZGMz+y059dLE?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?42rBFRDdHoUVduO3OUcQa7joMibNIBS/oEJJJMA6PIuSl1ZHsKTldrwf/QBv?=
 =?us-ascii?Q?5cboPtHiOK9fJZoXXGmLPrYGfsOCDMgAPBLuFwj+7jB2EhLiN0a/pK77kjhm?=
 =?us-ascii?Q?Plq/NpURHyZDmYcR0fFAZ7Cc/KvxEbohtWcPLC0dS5ABi4FEpMw4O+fwcc79?=
 =?us-ascii?Q?hBtRugPrQ1kCDOuhAsFdgXnjaQ6SfwM9vNQoUIr+LcF/RM5AeqRAoc2cmm0I?=
 =?us-ascii?Q?DdWG4X+OeRrm6HdyVCydYUkW7AwuN5T86vOe+TKk8pcRxdqqLGGfMAc3ysET?=
 =?us-ascii?Q?XJxuGKBFZQYj8YwbhrJtlQfhtNi6IKrvd5Ng2RgAS4Q4jUwVQeZw4n8Q8VoH?=
 =?us-ascii?Q?t3YncS//TuOllCp3bqctqfInFgQ30uNT2CMEJsg9NF6DSPcS65t0ZwgcOWYy?=
 =?us-ascii?Q?X/j5QtVdrfHb4zYbwSYYWOdjSJpeUaAIJNKHHzoSomTt73262KMk57Hg1MkF?=
 =?us-ascii?Q?tlvzBcVL2Ka4qVf1L6SH7XHqMMGzdYS2WNxAnMWF3LOMHJmFnm/BWKWmJeVV?=
 =?us-ascii?Q?dNYD2e5IEqKxL+/hxK9RE7jqGLijdQT2FYP3UAiXax3UoryWxDArsX/hCb09?=
 =?us-ascii?Q?LIyUFywMsnHW5y7KT688h9bDwWk+84DHPIQ5jYVhMenhtOmc+3atU0CUEaDa?=
 =?us-ascii?Q?nV0oUY+kzrM4z1e9H/ebwwZHatpaTteCjrqRtqTFk11jKJPnHmlgs+Zswu6C?=
 =?us-ascii?Q?v0bezXD25ue3RlrqF5Cvm5/KoiTg6rLISgEBswBRVRn9FALd4KuYu0GBIrq0?=
 =?us-ascii?Q?JyNADeJYCWmmhu9evz00BdZ3ibrt1xUMTiH8CeMV/fjQu33WRlx28wa8nVAX?=
 =?us-ascii?Q?kRu3oURwGLP7d4Ny+otb8ukcxvbCfKNkymSCH5mh1T5G5V6wZqJ62j9W+uRP?=
 =?us-ascii?Q?4Iqb/7BC96Ac+ODMOsVwZavsT0678hLlbNzK+Qh3kPlgW41j/KXggfQSjBPO?=
 =?us-ascii?Q?7Y+vaOkzwjXC4lF4KswJJ7hLRp4YuqE3VdnpyZeDTic29STmIsRbsFYFXSaO?=
 =?us-ascii?Q?R7P+CbO/lnoYaTsiz4oWpgbrscd3TVRLLOG+g8KgLsF+a9kXHiIlsCSD4deo?=
 =?us-ascii?Q?wcsjYoGmBqMwmobC5qX+lEMFZTp6jWM9ePkHVk7eNTgd5xkLqa5rZuspui2u?=
 =?us-ascii?Q?A1ufMFWzIUyaya4vvUnaQJE6AdMszndgiwZwQ0xcrkg1lFoz9X6BVNG3rKoY?=
 =?us-ascii?Q?s5VQTzKKj37XslUBf/qeulVHyNrp13XIynnFISPtx/xET/78cf6X5/4vSKKV?=
 =?us-ascii?Q?zHdZZg6zSYk5ViYDhnzbBmmiyS38AKBnLVFtEUwkZr8o2DV7C1AjwJIERGF0?=
 =?us-ascii?Q?ZmU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9acf4e-685b-4c88-638e-08dd7b42f7c9
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8434.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 10:56:11.3783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14482

If multicast snooping is enabled, multicast packets may not always end up
on the local bridge interface, if the host is not a member of the multicast
group. Similar to how IFF_PROMISC allows all packets to be received
locally, let IFF_ALLMULTI allow all multicast packets to be received.

OpenWrt uses a user space daemon for DHCPv6/RA/NDP handling, and in relay
mode it sets the ALLMULTI flag in order to receive all relevant queries on
the network.

This works for normal network interfaces and non-snooping bridges, but not
snooping bridges (unless multicast routing is enabled).

Reported-by: Felix Fietkau <nbd@nbd.name>
Closes:https://github.com/openwrt/openwrt/issues/15857#issuecomment-2662851243
Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
Changes since v1:
 - Move to net-next
 - Changed code according to Nikolay's advice

Changes since v2:
 - Fix alignment
 - Remove redundant parenthesis
 - Add more infomation in commit message
---
 net/bridge/br_input.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 232133a0fd21..5f6ac9bf1527 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -189,7 +189,8 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
 		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst)) {
 			if ((mdst && mdst->host_joined) ||
-			    br_multicast_is_router(brmctx, skb)) {
+			    br_multicast_is_router(brmctx, skb) ||
+			    br->dev->flags & IFF_ALLMULTI) {
 				local_rcv = true;
 				DEV_STATS_INC(br->dev, multicast);
 			}
-- 
2.43.0


