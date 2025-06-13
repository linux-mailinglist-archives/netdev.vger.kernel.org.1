Return-Path: <netdev+bounces-197414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D245AD895D
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 12:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9ADD189096D
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 10:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BFB2D239B;
	Fri, 13 Jun 2025 10:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="J9+fl7Jd"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013016.outbound.protection.outlook.com [40.107.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D4320DD4B;
	Fri, 13 Jun 2025 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749810055; cv=fail; b=dUibZ7Jbot9UhuZ2q8I/UM0ROI60lmQK/z2vEN799X4DiLVuMsWsjA0cDRu/PjEokC8wjKvmc2cp1bt2VwG07MZH9FzvpZT9CtgiHPfpvErWZZuaiCL73+T+wl9NhuUqhmrovV/wJLyhdjw3zoQvbK0oCh17WtQb5qixN15kNDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749810055; c=relaxed/simple;
	bh=A2dno9DUPVPV/0ckfzwnUPgdcBcmydpmAtob0/OBync=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mTy9AbHEj9cho9CqeT97bHVvwjJEyFuaIWnUsPMBIfWwRw/PRP/wvgrna+IZOZnxzW973VLSyGxlw3rndSqVAoJJbZX8h2tkcpQPkI8B8PMA3smQOiJ/8AfyPsC5bA4ZIvxGKYyRe67vaFEra9Oov305NNrtQBRlc1z00EoYfGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=J9+fl7Jd; arc=fail smtp.client-ip=40.107.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYtXVt8uva2zmO10Ri3zhL+IhzgAzVCT78CsvuMZINzd/7npF3hP0tYmXNq3Zn1eg0DCs/8Xg0QOH9ISFaBIfWHdUNSlKip40t9YT3qkFRwqCHK1712GuSiurBEyPByV/rTj75yGhGRsWIlxCdmbJmF8JMQ6V6ZLjnHnd1CuJhrifAPvfH/YjZiDFSAfIf2nC4boiWJgjLevuAroQlmIjIJ8Jg67MwcLYca2+pI2SSVe1ZG8+navQJz+4CWSuwdauMcBGk0m2LI8F9iikN1Z5cCmnR9BWsJPlsCw8+Q3xn9ATgCM3NA/t4aKKSZvGchbMyOH2JVcXPGjgSgLdwuRYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd5pMwmpYd/pttLRD1YjRVOvI3g763fveNCh1DIZgJc=;
 b=YGbOVR6ososZ5xvwywLsLwTZm6oPAQ38rfb+ST/5eFcPv2UjGmvwgwkxITMf8ClZu7BwrUDV4l1GGUWM+3pbIgSVtCh+0LN34rAF4vMuLBKgK4pWF3BbelIhBtMJXye+6sFb7sXqbS98dQHISa9lRgo+Xo2rsMy19LtH9onJ16hC6qQlUqXwxfVb+AItm5jRomR0zhwTWRBSB0Dql+AEwY2vofGAfrEIuKkZo+2yzOV/EDaidq08EEpUnbfiS25q2MV5TJTda8ajNLspKGua8dssWbmEb70JdHEy6ig3YD3fLgL1Jyyk/bP4iGiBLZA7SyX/TWC+6cAxK/bgdh55Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gd5pMwmpYd/pttLRD1YjRVOvI3g763fveNCh1DIZgJc=;
 b=J9+fl7JdGntU0H7hzTgZap9RLxJLiI8+AhrWPzuetI4OYnHOpFsbWWEUh0BeeI8ee35pqEgCloq4/3FwP2kKUCB4IzPVqOTXiIuztR4GHsUrIEkJuacoSlTITrN5GVbpiFbnhpPHoVawa1wKSliycKeieDJRwqpqrV9j0HNkzzz8ub+mQPedPmfsR4d4UhejR2PdfKYf+3uv+ACxmREJIGBkEgGiFMiPc3r0lF8mCbJHotEDMzX8jw5b3G5j8wKPEubstTsQJtItWZw+/Rz5YB9HWrL6BBi23meONyThVnFa0jQ+375x3AQH2e3d82uELHJZM6rF4GFAMzCDVPNBaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB4802.apcprd06.prod.outlook.com (2603:1096:4:169::8) by
 SI2PR06MB5018.apcprd06.prod.outlook.com (2603:1096:4:1a2::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.24; Fri, 13 Jun 2025 10:20:44 +0000
Received: from SG2PR06MB4802.apcprd06.prod.outlook.com
 ([fe80::685f:929d:f06c:a349]) by SG2PR06MB4802.apcprd06.prod.outlook.com
 ([fe80::685f:929d:f06c:a349%3]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 10:20:43 +0000
From: Yuesong Li <liyuesong@vivo.com>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yuesong Li <liyuesong@vivo.com>
Subject: [PATCH net-next v1] net: amt: convert to use secs_to_jiffies
Date: Fri, 13 Jun 2025 18:20:12 +0800
Message-Id: <20250613102014.3070898-1-liyuesong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0034.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::21) To SG2PR06MB4802.apcprd06.prod.outlook.com
 (2603:1096:4:169::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB4802:EE_|SI2PR06MB5018:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c5e5d8-e2b1-4fe4-956b-08ddaa63f387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8CrQ4B8gYPexKRmLgtmrowwQNcbfshEjMazMDLjBNgHWFRi5vv6XZVEWk/r9?=
 =?us-ascii?Q?EQTXGTCzSihfC4ZniQtTGdUNp6+yt6pb1RSGju6PMSPrhKJBsvuSGEV5NcTF?=
 =?us-ascii?Q?HUg39cb3Fe457DaaF3FMx58nunI60ZqQx7JZJXFvwqYSaC7BL7f5N8Oiv2d3?=
 =?us-ascii?Q?w8ropeFMOG5Xj4fd497oRV4jUMO0O2g2WPgeUT/kIjrZPz8SHD3F+Fb1d4fc?=
 =?us-ascii?Q?hxF7OauF6ILGwr327mHbh+GXxbKmqAugCtc1jLhixNSM7HoGIRGXo93hCzTJ?=
 =?us-ascii?Q?oyeF+9NEsMslG3KkCn18CY2Md2eawGEA99lmqlLELT9IyokxEAYjdBj8/6p9?=
 =?us-ascii?Q?1yhjaBkJ5dW7rWd/ssndsLOxl6K4DZM8P7HR//dQB8hbK2Xb+S/FU0vLCXLU?=
 =?us-ascii?Q?hb9yKWHhvc9OkxoDL083NMV/RvIayevfv55xCpNseyTiguAWGrve8rM0Onq3?=
 =?us-ascii?Q?IuKHkZG5uq42L9szcGEImBKHrfcP9vEO80woFWClKFeTbYs0+G2Keupz32gn?=
 =?us-ascii?Q?XEUxcKeMDMfz9VbYQHFlMqn/sP+sa7FrwVXwSwOGtb3lNrQEiFBSU9wyhtpp?=
 =?us-ascii?Q?0dkdcnS6sY4f+t2ftZStq6AQl2BvWtAVoGplhQP55HK9jFL6YInXSv3M1aHG?=
 =?us-ascii?Q?s1m8BmvKoePZzz/VvOftTHxXS+tZh7exiPg1a4GIjddNxpp/v+aJRRPD8fzE?=
 =?us-ascii?Q?LTLUE82PoGN/3BiprBpZwDDp7dcQGf7voPJ2P8W/60MOJ0IfO66IRkxn6x4z?=
 =?us-ascii?Q?bGS3nRN+2ICa61mdGf5wLOFXCcs97xDZnpfD+CnZra1h7aR1XgIJjnalkKBX?=
 =?us-ascii?Q?8AVu7Zc77Qzdx9/YCsc7QnxS2U3BalqWmqsiAiWVYodNDhKaAsa5G+j46nPn?=
 =?us-ascii?Q?VzOUVOWQ6iVwmokLExQqfXcvOuiot/2K+lkKv/KjjBmy7Dw66FW3FIx3X7sA?=
 =?us-ascii?Q?LiyrTmn4au3grRLkx4mmIKFtHJYd+yAcuGc1dlKUjShzpC6gYT4kYCIwsvXn?=
 =?us-ascii?Q?+wfRAF21aGdvUkd5VvshduvS8ORFaODQkoMhafXcIWtg0h8dTrFVrZteQLfT?=
 =?us-ascii?Q?KCR4koi4jC2Ejj5bxE895iQEwX5kXFbI4GpFtBY0/u1J6bnyFZd+AA8HPvrF?=
 =?us-ascii?Q?B4SmE+3dMgZbJpC4qsZHg4eAr5E/USKjkfhhueKEz2O5F5erirAI1dtVY5ez?=
 =?us-ascii?Q?X7/88QUxzu5HiUL7vhzB43qagMlSIzMlOSflyblomVpLzxgyYAilyy17ij0H?=
 =?us-ascii?Q?XryThUqFCak48422poCSJt7wanhbu2rsNkM4hKWmom6cZjIlFqy2m4D5QDvg?=
 =?us-ascii?Q?YleyU9ZRZviZoQBiLQO/2uWULq02C+KjSZJnmP8qmeL2RXMs/cCTcZeqGFwT?=
 =?us-ascii?Q?Lx95E110CtxANelkFeZHYKI+D40MIZzyVo6TLFT5mCmorYarg+TjdEvHjRmp?=
 =?us-ascii?Q?HN1mULukAqLJjMEeFO4UUOrf7rejcnujqI17P3bYXRNlM/p2sna8Rg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB4802.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lXr3zMlj2afN97F81d//P0dv8opfEiqtbsiK1ZT3e9iONjwNua5SKrJJHXUd?=
 =?us-ascii?Q?eGjjTuAdnbGepw0kqJPxPc8fMhVnAJ/Mp9NUyXk4kT3cn7M3eRqWWf6v8pA4?=
 =?us-ascii?Q?W/Pn/vlJd/dVxmunr8xw7Bk5vnAqMqC4tUC9qvO0gfAkfISf2Jgm6nBHSY1p?=
 =?us-ascii?Q?trqnEmxrisbe9MijPDnWOi0/FCmt3qaUON5+mBygs0zo2yceWCe4HRi+n9qp?=
 =?us-ascii?Q?Apet8a4KIrLCOSSnG27dkEadMxrteM/C7anpy/339L5+UBHJBejT1k4BW5bn?=
 =?us-ascii?Q?B22JamaL6Rig2y6Zx+86/WCdxc5MCquARN0SOlUkJp6jNUFdoRegw62z2nWu?=
 =?us-ascii?Q?JBnC5kwXDxp0J27uafFZRV+4XuziIqmU/iE61BaLJ0QropEH838Ivlu2TaBD?=
 =?us-ascii?Q?yaK1d11/kPSErc8iPW+RPqT18k3HwNosczJUA17m/6X0LLCPzl3HmAXoJoR+?=
 =?us-ascii?Q?NHPjDJenTnhka97xYGMVdh8XyyoS1hcoioKGM/CGLQuCkVPgmGvaqa5MBtQV?=
 =?us-ascii?Q?VmBUyFYN4mhGFDUnlvtud1MYMXZd12PG54vgx64jdFuAHvQDcsPRNCh2Vgv7?=
 =?us-ascii?Q?xg96+OUtgLT2dsSDS93f7LhJChbi1/RIReKohvsrkUiqa+3WqNZy06sq6Rdn?=
 =?us-ascii?Q?DLyT3Wu1sqswWj3234OqXulT+2kLvtr2zidE0uAPjvzq93gzy7OaovdL5QqB?=
 =?us-ascii?Q?s2wSUo6xoUEMHcN837PC6fVKdFp+d7xpohiW/BH5acct8wRd42U7tJa+nA3j?=
 =?us-ascii?Q?O1zFfc/aeN6CAOXM7a4o+ys0dC4Znmru85u2+m0vMZWM9biTGQ1tbmBRxICW?=
 =?us-ascii?Q?64TT+xIi13u45+8N+Khu+9BoDMi9eOVsFaWUfd9+Na0LDjgBvnsjinlCualq?=
 =?us-ascii?Q?FjIbAXCl+JETjxIkXHcmXZYMHfCSV2r9fc8y5KZPaFVfjXslfyyRklaF8TQT?=
 =?us-ascii?Q?XOZNlVC8fU0EqcydMBNRNy7kZzfjkhTQ/vupAdR9DwT8mmyhXzg50tvCfs/T?=
 =?us-ascii?Q?2TqUc7QzY2symnRPlMYvHuccOIXmZoO0zmX4eCQPUjKYLnm/jv+9nlW/DCi3?=
 =?us-ascii?Q?OgPNC7E6TmZbuM4ptMkLBlLZZHmshfNB+JFucWC7Alx0erKzipLD6jK8GDSe?=
 =?us-ascii?Q?087jrN8U91/2MwYmRSTiCuqN22cDtd8vDBiwe4yXem8jUUDS43QStMGfaoMc?=
 =?us-ascii?Q?ijBfH9mKkPxNgL35aVkT71vW8YmadVe+LvjcUWrHoFzPnC7SEhpaGJMTvzRw?=
 =?us-ascii?Q?+Sh2ztp71zliD8ahlW/50CjVRwKgLEEyXBzbM/yQp4Ih0nyEbNm1dD49gMMs?=
 =?us-ascii?Q?gs/IDZgtxs0Y3Vwbh/EpG1XtImD9ih7cX8CG0l5pyDRZp7vYTHds2lgOtiCG?=
 =?us-ascii?Q?GGGhq4bNPPydPZwI9ibDJ7KxD01YlCPzeb5lDPu2FI6qTblDuDGtqFXwxBm3?=
 =?us-ascii?Q?W/afhmNDHpDOemIZct5e4lPl/lfZZcAm/fyEMXsBmpYSH3xlfrepgrgMquix?=
 =?us-ascii?Q?uNZorK8mfrme+bxmw3mP8T/alN1F5f6g1QWfRYyAksqkDouBe4rA214v90lA?=
 =?us-ascii?Q?EwXB8CQG8pxq/EgjZopX3DWDfat28GNhmiXbIiqC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c5e5d8-e2b1-4fe4-956b-08ddaa63f387
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB4802.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 10:20:42.5157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6BKqE5Ifz2JWT0q4mXkvN1Fg0B7IvqMzyvBdJAmF4CFjnNAbfeNvAJeqXnNXJVBfGSmzTu6ZYI1GePrLwGwRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5018

Since secs_to_jiffies()(commit:b35108a51cf7) has been introduced, we can
use it to avoid scaling the time to msec.

Signed-off-by: Yuesong Li <liyuesong@vivo.com>
---
 drivers/net/amt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 734a0b3242a9..fb130fde68c0 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -979,7 +979,7 @@ static void amt_event_send_request(struct amt_dev *amt)
 	amt->req_cnt++;
 out:
 	exp = min_t(u32, (1 * (1 << amt->req_cnt)), AMT_MAX_REQ_TIMEOUT);
-	mod_delayed_work(amt_wq, &amt->req_wq, msecs_to_jiffies(exp * 1000));
+	mod_delayed_work(amt_wq, &amt->req_wq, secs_to_jiffies(exp));
 }
 
 static void amt_req_work(struct work_struct *work)
-- 
2.34.1


