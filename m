Return-Path: <netdev+bounces-212923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76047B2290F
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D5D1BC5778
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6210289346;
	Tue, 12 Aug 2025 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Mdf7U1Mc"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012061.outbound.protection.outlook.com [40.107.75.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87689283FD7;
	Tue, 12 Aug 2025 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005586; cv=fail; b=cE8SZHhAPKCSqwNsG4j8AxlTf/ZE+LxhZfM3Q0EHcrE1ckeoPV0QhqUK0mGKlAezIjbbAQNACHsJDJ22AIXahnHjvNlvUI6H+CKqMfnQ272+o8x1/gEGw/lEq9YHq3fdTwyZoixCnFFr4EAnAVeE2XJh/vEcEGWShahyNuilc8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005586; c=relaxed/simple;
	bh=+cgst0tWy6TVadZydKMQfeGoZhqE8vTwUDQ8nO6aBzw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kN8pMGlxRvWOxXetS0vCRl8vf5FQLWkb2N95SAVkH1kpCwLnprYO0isp6F3L9dntnkXLH/qTi6QqGGBKc5YyjrG+BmyI9HsYekow/3M5iNzDMaHKluq9myr2lWJ+XZZcTFC81Sd8DdtbzFPMe7U5gQkpuN7zm46RhK8AcX373lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Mdf7U1Mc; arc=fail smtp.client-ip=40.107.75.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKb2tTXv/R58hab2bqlquwrQwnHlcF6Ewcf/G5ePOooO0S7GBeNaWj7C4QrgmMj+Z4AVT+rtmSr6G2qe1YUqPJHcWZH2pPbngZvDGq8Ckr1Bg3dIbpk78udOO+w0u4vvL+uXZOdhPdRCiJ+hxvQ1CIyzpYqiaeUo2+H9KbbTpYZ2FmF/mDTwc3r+AmwDtvtIgEHsGz9OxiV6+9DW5uIpYwC924xa79UiBuhDptuocppOf4w5LjcB+CUuTMI+8y5dZTBv9mR8BtLpEJ9nmX3TCEd0RgfsvVIZH9/jRVAXZJmadzA5XGLhn+x3V6qic7RGfwnWNccUUN8a3C8uvFsNFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzSpo9+Hdazw03FKQfo8wZQp+u26CC0iWuXz1Jg2kcw=;
 b=Uj/SJFSkXj//dKAqk7JFz6iur+Ucu0hRdmu/HMihNynmYoxCNn3RsVBGqOlKhlu6K8c8G05K4/TEj4kd/WmaGQHnjO5rzHmr4Z6IVqi7s/PZZNee1j23XQxpYwot0zQ7oQ+xIicwsy6NLPCQ8ByoN4eRU6x8vIbjQnrYC2mraoYcp04r+4iquheYVCUZwo7X5fJzZBik+5iLWsZnfqJounmXrRjEtu7xfD9W48BDHVZjj5V9LqR3a9AUVmB0MX/Gaztd4dZjXI3adtFlctGhaQaZn95Kun46ZpB4bFdVeETbYFpd6+xSj7Tp1DF6n4fyVMhb6V6ZhnDv67tAT/gKPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzSpo9+Hdazw03FKQfo8wZQp+u26CC0iWuXz1Jg2kcw=;
 b=Mdf7U1McecX15bZ7N2XYTRYgfrTcW+dCLQaKevsbkMFbQi0+bucEkqflJa/NyYmAoNqpSru+urQcPQYCIP6DtkgkaVldSZGk5gIT4fs9vF7I3lOfbbL7o695J3Sx2KBXuLZFtC8xIvamnkozMlF2XKud/JQHofFBcCNxgTZVMoXT6MStv9vA9UAilzQUwuzAdCtfZ0qTIwpk7dwkzMxcaUL+g1v0dd4tPKhJE1i+J7fjXQPqCTrv9tclK5pS23euL55gkQVhT6Pg2oJNwnH/YccNUGBmQ8xmyAelXutXYGAqrhJ9kCl5KUT+EUCMGvUAGqFJf7mp47xSgVT9cJ6LVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB5040.apcprd06.prod.outlook.com (2603:1096:101:54::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Tue, 12 Aug 2025 13:33:02 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 13:33:02 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/5] ppp: use vmalloc_array() to simplify
Date: Tue, 12 Aug 2025 21:32:16 +0800
Message-Id: <20250812133226.258318-4-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812133226.258318-1-rongqianfeng@vivo.com>
References: <20250812133226.258318-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:404:56::17) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB5040:EE_
X-MS-Office365-Filtering-Correlation-Id: 51700dc2-df54-4659-b6e9-08ddd9a4c289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/jSKVb9pJz0gh3KWJEs9xQMHA8TUYM960xrAU2db5QpIFrNkB1ZonSGSe/cz?=
 =?us-ascii?Q?w9qFi6wrvbMFjQEFFKL5P5IqQWpdJD87yeC/WhKq/WGBGy7V33ehp2rFVRpj?=
 =?us-ascii?Q?ghThfFQzqZo0Pq20ypc/Rwzg98JLBKiDn6W255Tv7Dr72lXVzPPF96XfKa4E?=
 =?us-ascii?Q?ZeZQHW6W6G+zJKX5hQmyAvB9XlSS21rs+5eJKNnLh4b4JSDldWpixH4Ai1ni?=
 =?us-ascii?Q?ACpITGqAnlDEvwFSpBAYYQxUoZDHniSaFljfUCrM6UGAm9MoNlyWpZs4+Ezy?=
 =?us-ascii?Q?SlxoTCrFE0tDfsY5Ni7uijEa6ofKCuBxhvfwr9lN4TGa8n3ba4kqrhLg+gsn?=
 =?us-ascii?Q?Xpm2sEObkS/MmtiCG5dihnv5mOo5+g/YQJAsrfT96oOx48Ig5fdC+QhLpxuO?=
 =?us-ascii?Q?2GrVSg4LyJ6qj241FGjV4hnEMzXt38XtRSnnw7pV9D1WMdM4AQwP0Qfp95ok?=
 =?us-ascii?Q?SqoiCbsvgRLWVkYcRd/DnZhyXFhMg4P2hPzNKvP4NOk7mDvSW5hgv74kg2nm?=
 =?us-ascii?Q?e1yNsDQO8yJ1Fd1SAcYXioJT/7mfZNJ8zxXe8SNKeCnD0ScjLLaP7jCwRQSh?=
 =?us-ascii?Q?RJ38U8FKA6LOuxlMPmdevuQPHj0lvYiQRosEF3tXaifUpcBL7+VJ9o8IkghV?=
 =?us-ascii?Q?fKK4d/IE+odVu3puTIIGz4LUnj64xLf8btPQLFdULeBnt7SFvndQCgP3ajWZ?=
 =?us-ascii?Q?eza9dVTjWzgrPZwI4AkvP7xBL5bCsggvM7fUXD05v0M8moV3vFTbu3p05kiy?=
 =?us-ascii?Q?HOD1twoEVO6Ahxgvy3pf1DEmDJq8Oj+D32Gr3d2iQsQhI2OZigndIyfCnvys?=
 =?us-ascii?Q?wfmSeShJoQ7qv6ZKsPdrKPnIySeBUSFrmsTtc6clE/g8LD1suXpRMMktrw7c?=
 =?us-ascii?Q?oVZlMAjcRKAcG+7t3WuGFGQVtwpmqB33L9Qn+yyMMx9Sr159XVL3pokjms4S?=
 =?us-ascii?Q?+039s5Kv1MZGce6wSd2Y7uG9x97aTsqZ2WWAYQgYvEP395ANs3/4yHXhheA0?=
 =?us-ascii?Q?9WwVf06+DpV3PpIguJf+zX16pB+9W3izmtwmnMGRHuqBRTWYv98/tHAQwUdb?=
 =?us-ascii?Q?aXjH7fOybaTYal0rNSDG0wFd7g/HAu8tlPB/5owHZNdZEr0KCGKfST1WxvJR?=
 =?us-ascii?Q?ifLFwKOOsah/lXL372Hs5tNpbDH8RIVxQuWcLh9pSCuXZpHN2x0La2ZnhDpH?=
 =?us-ascii?Q?yy4P8WStDamOUfI6KgT5rWIHtyYNnz7QjEjhLMW/1gC4OqXVriZTI+LcibfU?=
 =?us-ascii?Q?AzoL7YVipjojAZKdVNVUT4noHZHELUKiZkgdAVqs8GogbjqtRBSqmLzYZ2mx?=
 =?us-ascii?Q?Xl+VSMcLtRRH2EnFh5Oq9L9faRBDJSOX3B6FY2sOgz2hZZ8c4nKOVJNA2LC9?=
 =?us-ascii?Q?ahwyHh96w8g5ssM65xUaVaf4eiqiJJjFloG52s+zv7muxE1Oo1EzF3Wa5CPF?=
 =?us-ascii?Q?CvseWNJ3sNDJMqDSXocWh8hdRbI9c2MRB9MVyaZvIiHeMaFLHfoPog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rfEpxjaFRKgZbNQnoR4cku6/6g/erFFCeJ7tidzZ7m1cqu7oIOdh5WG4Ytcz?=
 =?us-ascii?Q?Sx2qwkfdAtCMLoN5VvwftWuKdqv/OaLv6aTixXNvNwHqL2Dn7yWJV1w3IxCK?=
 =?us-ascii?Q?1xvsoRbSR+IfTJEVptoJlD182LWdf5afujksVoTrw/RwWDNpziC85kLrCMGR?=
 =?us-ascii?Q?mogipyNZx8JGn6oYNBkr/HHFHPWqq8Uhcxn/c++1LviuMWZc/rlwUZuzSmmO?=
 =?us-ascii?Q?y93LBXgnIjDkL9Mw1OudzEtVF0D5UACw6JZTP4/0ToQrwwfGWdNtojSvoNe7?=
 =?us-ascii?Q?eB2fEngiUQkQZX+6S3FWLWv27qLdEpT3Xxdk+RCfzE0+FVjo2HPZm5x5kM8E?=
 =?us-ascii?Q?aA++lUszh7HtXRwn4GQq3Nxu/WQ0DrWyGFApVGh37Yz0LOy65ciyqsosI5WR?=
 =?us-ascii?Q?M41Mna3/3unPaoWLTODL2NABhDAi3QaHQWdFPMxkxguLOz3nRstapbd7KzYj?=
 =?us-ascii?Q?LJhEkMMJ8bAiZaZg5rN6r3vUCws+066jWBinBdVKCRChjhFYt6no8jCcLbk6?=
 =?us-ascii?Q?2EZAGKa7f4o8NKz/WxZAg475pVj4F1OHXUfGftoXRu88zWNbXYRiLdI63Th+?=
 =?us-ascii?Q?91J5a5T1Cu4wakuisG5LiAOOQ0PjQo/aMhXjjRGwgGM77EGmXS+T0LXTQwAa?=
 =?us-ascii?Q?LfLhsDoUoxfHd5QWqmZPa2S/d7yItrx222VGpQq9sHzVrjQyij8KXG92QiMS?=
 =?us-ascii?Q?joMLNEpOUYWUVneRuNGig7REsdtftfP/fYilJg7inALRQ1rUIDUKnLibzHyh?=
 =?us-ascii?Q?FFM0jwuZd+Nr9MEFQZWa+nzDfMnpwhdRUUkwIV61IhJrH/D32hlZJjyEe/Xq?=
 =?us-ascii?Q?oN7jsWg/+VstP0cw1Jx5AMoPsqXoI6Lp22g388IXvZNMwKr5CFDtfNhS6h5I?=
 =?us-ascii?Q?3KutsyNNnq1WI2bHmdB0ju5p6Lv3asieWAcg5HaBYdBs/lHXbQcsmzfI6itU?=
 =?us-ascii?Q?Canxdv4fTVXLLSbCESPdtXr8Zwx62m61izV0j4k6tc6T/nJhuhXhTF7uqK3v?=
 =?us-ascii?Q?PKbm/KcLdiaJEu3JfFuZkwPnLoNCsyMeH04ROrFwq+SsQwGb4jtSkX0Kf6qf?=
 =?us-ascii?Q?EGh21S/VTn0rxU89TgLHiPfVwITSYJlWht1LBTIOx8zvYZM8B+t8wuS3MuzL?=
 =?us-ascii?Q?O1oGJpPjSfR6gBWJbByKb6ACMNHQwEpS7Iycv4cwdNbIzzX+HHHflK8sNbIV?=
 =?us-ascii?Q?zFnfoFOvzoglU+z74bPXLNhDlu+PEbLpaHpreWfvm0yu1XZmVdD5ghNFq5y1?=
 =?us-ascii?Q?L/3QWXF/KCJwBEv0oHh5dJ5dKZbBdqlbW5AdY1IUFXxwniRzg1IMp7kYAOs2?=
 =?us-ascii?Q?b6O7cCmZaAU+GuBBVYuaE1yhv+ktpAKoordt2AiMQSG2kp1oKpRNemqdY8wA?=
 =?us-ascii?Q?0IsiSPseDl9iDVdiwutGqfXmHcw80sSBNLwKkzI8Wd1ta87W1NCmPdGZL4+O?=
 =?us-ascii?Q?enJri2UnhrVo12xjJ86+KneZbLKsMf6eIiGlgw6lnVwYmdLBwdqUi5eLqqS2?=
 =?us-ascii?Q?RqNwjlyhIJhiW4ryRb+469bULgmhOrkVnF756wZNGcUfP8WIwX1YbkhJ3C9C?=
 =?us-ascii?Q?PHY/RpFbgZCOjitp9EjHime32cDLEdNHBZ0Nw0k6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51700dc2-df54-4659-b6e9-08ddd9a4c289
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 13:33:02.0141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UErVo1Yl0Nq3fGIVEcK4I3CfwCo9qimgyc3nkCJH8p1OSSYOf4VbxeL0KQMBd+1KCL0G31Sm3zzyqjOjJn9Szw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5040

Remove array_size() calls and replace vmalloc() with vmalloc_array() to
simplify the code.

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


