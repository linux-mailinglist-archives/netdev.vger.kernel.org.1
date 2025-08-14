Return-Path: <netdev+bounces-213669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66452B262BE
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 12:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF33B1CC4ADD
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 10:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE422FD7CB;
	Thu, 14 Aug 2025 10:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="L5D2Pz61"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013033.outbound.protection.outlook.com [40.107.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D791A2FD7B5;
	Thu, 14 Aug 2025 10:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166914; cv=fail; b=uAXJgSZfZUPpFUc2Jq1xgW2fXK5TeVIH5vmTBrWxzuClMr7RbFfGGkjbswTvR7MClvPzh++aaLSv0hiSAVOipsG/eg8tXzyEyXmm+u31IwTJ0kwz3E7DCpS+d1F0XJrtzV55sv+DthiOYNdvBybJwipTcFg8E4ckAWxZ2L/9bfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166914; c=relaxed/simple;
	bh=RONMa2ikn2wsB/Ey7wpwT7gSToCq7xrR/pCzIBwe1wM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Svauz886ynSSipCokuxu1AkFj71pPMCxi/j60NpT9PP7V+wLWv8NOTokFmTha/WcBBfkS6VnLIgRzNWlDe1PdagnIvGrIqMlN/UDuixVGYZ7jxDZcTPOV8AzQxwmvprrqJkdyo0OrLh+ftfD3yWzrk9Bb9pIyOinFtmP0hQMJ54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=L5D2Pz61; arc=fail smtp.client-ip=40.107.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJ/VA49XoWX5FNn+rENOFDiFXOsL8GZrbeaQ28zByikw/XkVBl+YWR5Si1vdow86Bs3RSctWYBmrP0nD+OD9WsZzUk/Zf8sd5f8zOvhiErgpI4dWNfjiEMr4VNTI+ThWaxLEomSaGfNyFdvlKE0uo6cDdhrz1WrwscpVnpbDa5v+cGBqgTfscEULgNsetuoZBMmZ/44nsn+B4ePBQZOzBx9qNItPa8oGpO2+lEUD0J36hlBKjdIMwHftVwc4KGLYKqwoCV/A30Bt/mukbWDECEuiqroRNZAGNe19OIYJzRB1a5Pw7lo32B2PwW3xM9g0uzh0nabIV9/bKhzcGiz37g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtBoFe1vdZ9oleHWyUJUi+QZsigTWaqMmO/4a1oBhSY=;
 b=SFp3T28s44o9Z+CSRudTSxu3Mv07Xk3Btd/eUn0mO72C7fCXwMRugJPGQYu76xq2DU+cwGrxA8PppJiS/eQXIOcIRP5iGTbuo+RvgmzotuxdA1w8YQZsip/A9sSNnQ6tMFYPFRN85voU9twAo3Ix/FLY7T8WRm4jeQSKVQ1b2S1IEdgcoIlWHUUV10Z6eCnpuXTLCeLhdPcADe672Sp3wN+ucu/Y1SspYyrNxklEC9xCwl2a+pq9wskRwieToY545KUuV17nuwfqAWtzkk5xb6FDTyvSu4Vg56EUnGGUlXc9Q7ScVAPxWjMmZ65ypc7JebpC1upVnYkz+VOj9/MeXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtBoFe1vdZ9oleHWyUJUi+QZsigTWaqMmO/4a1oBhSY=;
 b=L5D2Pz610R8o+Ii7VCcXQp5IPzkVNCefC5Yhuzpkks16/FflWTYYbaoGjJLm1EWecAQ/cjpc3nyqnMN+mMW+10qzeivl+gw7e14Kx1gqu7JYWYDNRclkDlTc56VOl8SR1AYtGCDWjIbOOHQOPdTV+B4O2SHyNPvILelqJeohhJ54UP/9F/WAPWNQomPamIKK3srEzkrKwsTUYBLwTM+gM8I8K4XVviYRIpWcp5ZTmfp/zb2ODFm4tEHpPYARo4WV1Bb7fq/HtWywFajwcveBZjT1ndhRJPz4TsIXtYCSX5lDOEHU6cF0jpMfCKrdMLMCGSfSJRz2sTi+VzcSDDeljQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB6699.apcprd06.prod.outlook.com (2603:1096:400:45b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.15; Thu, 14 Aug 2025 10:21:50 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 10:21:50 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH v2 3/3] ppp: use vmalloc_array() to simplify code
Date: Thu, 14 Aug 2025 18:20:55 +0800
Message-Id: <20250814102100.151942-4-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814102100.151942-1-rongqianfeng@vivo.com>
References: <20250814102100.151942-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0149.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::17) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: a7984ae7-6975-4d2d-50f3-08dddb1c61b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TJ/kCgdOttnjZBmm4Wt6tn/oS9k2CtwzGvKlJ9/HbJt95RNRmuh2+ICs70fR?=
 =?us-ascii?Q?H7UMZf3rsWrvQn0j0gjpD/fpNP1zU6bSYmLQ16f1/ZV3MTIgsyDtsEQ16atH?=
 =?us-ascii?Q?3sLHz5XMVZeLhl+sdnV0IKZ6PPP9Wnw2uYjfwcjt58po21AGs36/SM6b+pvZ?=
 =?us-ascii?Q?3tCaI1IbUei6Vs3oVwleptVO4ka8KeNxdNq2JMVjtuw1nISh2kMftqOmYn2W?=
 =?us-ascii?Q?qbaQ5QMrTRvpk/ag/xJPCxjPZk16DkniZM8AaTzQRaVPMx5itlXr4nZ1R2yo?=
 =?us-ascii?Q?NnfEZ7QhPS6VtJgBOvp6dP8NXi4ZmH3JyJF0iiHApzjYAGK5cdNsasmZOiFJ?=
 =?us-ascii?Q?1hnJLYuymi5votME7Q+T3p/iNWW7xn0Z9gDYTcuoIpROlEHDbann6xImmrEn?=
 =?us-ascii?Q?GOecACX+oSvdhy08wFXnzm9EVsdZ/06iFZIBuI4l3MUeMuPvsHxWPxRH/r53?=
 =?us-ascii?Q?7eR0jlobZVvONcDD0ahn1FE2OzC2WkawQ2bOLo7Bg7dqIDa0gOSG1Vowf+nJ?=
 =?us-ascii?Q?9xhFxvkgehYIsIU7/+4/Ucs5MP1TpUhMzQGTSkqHeRRzIrcO5U1nU71NJi2k?=
 =?us-ascii?Q?I/zeWSkNHZ7hIYtqL9S2rfAhGwDz1+ECl16PLXE31iGjYnEKuASk+w92Ykci?=
 =?us-ascii?Q?CWNrGcGysHdBIZbGRzJdrpLMhvk9OO33cq08cBXYO+KNE0MKJ+WzlR+2gvAh?=
 =?us-ascii?Q?KTbdlPwQ+PlZa8OYiZ0y/QPy1YQfMu5kmx4JhDyeiChvC+BYqnHY8yk901y6?=
 =?us-ascii?Q?1aKzsSlJaMw0A2TCHO7WRdx6aRs+JPaCEexiuTRA7gP5lIspH4OiyX/B/Wy1?=
 =?us-ascii?Q?8l6uN6lHBCSDc0Gm0IBo8fVBlLpQOp47R5PrBwjvwLhgrahzwoNpYhNrw8ml?=
 =?us-ascii?Q?6L2PDPbWe2pIwHm3aL8vwgE1c+jE5s66X9OMamwNohUa+NcYCApNeOAUORbq?=
 =?us-ascii?Q?IcE2e8Kj7xqtD3gwVkahlpMNI9gq3KnEFWtHF6nh9tyugL54BxLQym44tEht?=
 =?us-ascii?Q?+dx5jzQNt2rRNTwpS2PkT5XU+jl2UQMYRbLUVTAAcGMftmZDHozW2xqKTpNI?=
 =?us-ascii?Q?W3o5c6By2cyyD1nR30kPrhYZSBcPu2dNBE9zaYb0C1KiZZuHNRNiwofR20OD?=
 =?us-ascii?Q?//t7M3GuhaxAORmMOra7hglLRi0suxbGmZuSqXjenVyu2GF6qrMb4M6hjL4C?=
 =?us-ascii?Q?x5it0SzfRNEpnCOBpiCTTuhA61TCy10jHQvmPaC3kwPECOTV69yckOuAiXhX?=
 =?us-ascii?Q?okshiPINgN9kn+plzIQ4QwkVP7oljoipOY8q6I3B7/7wrFYIyNphGmSJvtDr?=
 =?us-ascii?Q?pmAcSzs0YKfLM5wrAZFNNSRVLEqSKt2ojpvTg6FNImJ/nDuyCN3rUgV2JlN5?=
 =?us-ascii?Q?9C2qnYbmxLQywpVeQcgtQhFCoNU4/hEKbpBbuBwOU/Fbw8ckUTOhAYiyP2QM?=
 =?us-ascii?Q?QgKl5S1gbLGThiVjKrHeuEkx2X8wuDFZ129TNe8JFT/eqiGT83A9rA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/8GSfLM2FUrCr0WafxavvsgGu44/mW6GW5HMmVLtJ67PEvLZkrS49giFpLIR?=
 =?us-ascii?Q?bFoUqSO5K/IRdJYFzyvyIsXix/SUiBoB0RcLdMmGCwEw06xRGBboqsjjAtTT?=
 =?us-ascii?Q?2hQHd8Jdz9ex0uocQDih8GV1HKKeCAluCZ+GiREzwS2AzmzbCMSAuxU7R3bh?=
 =?us-ascii?Q?H3Th4OkSIub26msQrbVwN9OVb1BX7Hr7fq7Fb15WGO3XOv2PgtZXI/39jWFv?=
 =?us-ascii?Q?VG8YtPI7PYKmzawOCnBZ88TfUb8Xuzn/zNgI1Y86M8sRqqseUF0uJLEOyuP3?=
 =?us-ascii?Q?ifNrcV4I/ah8LB0/jIOZ/TVByTvISyXDhI2YXbZEQmsAPVsAF9Bzfv97r72z?=
 =?us-ascii?Q?5XqG3f83StwcDUQDZlafbSYz3/ryHhflCHycYhcuizQmibI6w8N0B6VsGlFL?=
 =?us-ascii?Q?uQO8Gvi+wNWWIkJSVKxPTzx7E0YJu0vKzqJbbt5s0acA3Fia+QwWDAQhMWwd?=
 =?us-ascii?Q?aOU/jEaD01D70ahxFRuCiZWLh1fDMZuZTY1RXs2bc+SkffUnZY1ng+mDmPMn?=
 =?us-ascii?Q?2FnsmIa6LNBYtpoow9/NMVg1UUeFB5CRqXMExxk6Dqg3wssfM2X8upQC9/tB?=
 =?us-ascii?Q?YaW/Kqn8piSCH3js+POvedaoxw515pEWIsppqi7XZyfClp7u3Reks45rY9eC?=
 =?us-ascii?Q?SZ/yXQlPthzQkFiwqHNFN5ugHxulkO75DheaTsyv+XOqEXr/jkCqIpZVEflK?=
 =?us-ascii?Q?deIGSEFYrtJ7oeXcUpP8ojvOrSB4fOBCfUfGBORGMRXIb7kHYqxM/XPSrVLW?=
 =?us-ascii?Q?5jB+piwsvE8/9du9kPLJ148T9VBe6ewy6fWYebYD1iYn1+X9T8RkaLuIC5/H?=
 =?us-ascii?Q?mUeLYwgoSwQ2LGn0gsfBRvuD1tQWH9jE5TibqhXmHCU7m5OyGtopE3rtDVZq?=
 =?us-ascii?Q?YHqkNwwgy7o/JB4Ha7ccRG+IbRoOoSvvf9T895XACCqq1RlO3ZzNEPtsHCb7?=
 =?us-ascii?Q?g+MGVNMO/4bTEwIw3qMUKENObAU+QMoJmSt1GG7BwuvZSnfEL9nxuSCRWJEs?=
 =?us-ascii?Q?DEgQXX02brvVN+UzKEodbngKAnongd+mVg17k4HyCI0gU4Zp7IPM98qfF+lC?=
 =?us-ascii?Q?p/NITcYWFXxoz8rcyqlHWKKpFIyXEhZseBWjpPyjRRWuJ01bnNWiOy6YfxMu?=
 =?us-ascii?Q?OXIVp1ff5CQV/pwvgOsWuhgBtbhTWmZ1cECLVEgyto7pO9MT2eOJozim64s6?=
 =?us-ascii?Q?BK0mfVJQTUUX3nGcZmROE3NSYIuGVocARH1+0TiEH7F7byjcTg8SxczVpUsU?=
 =?us-ascii?Q?IOgbhj7PHCJGmhKHbbGUj8S92B2XH2T5ZsejGto723nwLkji6KsCGlov8oVZ?=
 =?us-ascii?Q?s13R8w4B5qw0mysKh2EkpgL64UyQWXgnKHBu4Ha2oS3HMuWBIA/IywwUAlta?=
 =?us-ascii?Q?ksP4s61CMGlNGai27tUlyiL1bkMLRY4Tn4sPj1n+VwkgaVGbUnJkQaRb8Nwk?=
 =?us-ascii?Q?AYWEwADeXi5toIlW9De3KH+5oGfG9Cm/qdfU/F2mzEoD4vewdvvesZqKleZ4?=
 =?us-ascii?Q?9JAqAB902CXafvDowDup/GpXArjwvR4Ll3LAgNQOCJBdY4dkILyExTMlL0yv?=
 =?us-ascii?Q?Mgix+8VHiWi4B+KQt2quDJu0LmwlbqoJbVfR8aZe?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7984ae7-6975-4d2d-50f3-08dddb1c61b6
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 10:21:50.3465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2g25PYvCwzI3hshfNMHwaWYRlhdamGOHBQKwMbtuZWgazDuKqduDR5VOFCZU0Bo18Qy8nYaFkMCDA6bzNXd/ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6699

Remove array_size() calls and replace vmalloc() with vmalloc_array() in
bsd_alloc().

vmalloc_array() is also optimized better, resulting in less instructions
being used.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/ppp/bsd_comp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ppp/bsd_comp.c b/drivers/net/ppp/bsd_comp.c
index 55954594e157..f385b759d5cf 100644
--- a/drivers/net/ppp/bsd_comp.c
+++ b/drivers/net/ppp/bsd_comp.c
@@ -406,7 +406,7 @@ static void *bsd_alloc (unsigned char *options, int opt_len, int decomp)
  * Allocate space for the dictionary. This may be more than one page in
  * length.
  */
-    db->dict = vmalloc(array_size(hsize, sizeof(struct bsd_dict)));
+    db->dict = vmalloc_array(hsize, sizeof(struct bsd_dict));
     if (!db->dict)
       {
 	bsd_free (db);
@@ -425,7 +425,7 @@ static void *bsd_alloc (unsigned char *options, int opt_len, int decomp)
  */
     else
       {
-        db->lens = vmalloc(array_size(sizeof(db->lens[0]), (maxmaxcode + 1)));
+        db->lens = vmalloc_array(maxmaxcode + 1, sizeof(db->lens[0]));
 	if (!db->lens)
 	  {
 	    bsd_free (db);
-- 
2.34.1


