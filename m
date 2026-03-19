Return-Path: <netdev+bounces-269640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOPmI9lZvGlxxQIAu9opvQ
	(envelope-from <netdev+bounces-269640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:17:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DA32D1FE4
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E3FD301828A
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AA6371046;
	Thu, 19 Mar 2026 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nyCzkzl1"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010043.outbound.protection.outlook.com [52.101.85.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE5435839D;
	Thu, 19 Mar 2026 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951445; cv=fail; b=MLU2d2ed8LiouuMKfSil6VRyVjsJ+XqKeA1U/cGgVoAQenc321eDeMCTFF8XLH0x/jtrUasvtZT2d3N0UXd25xv18oSFhTzAnCDEYj44xsMfTAF2RuE9pgS5PCsfuBKANJXeH771j532xjJwE7HyrrkjXE/1OJI63yizBNZU1M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951445; c=relaxed/simple;
	bh=YctdmMk1IZ+2UUBDtS4Xzj9LVbn6S/hsF9u0sO18iRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sDmsm5Xl7hkoqPDPcR6JZ+MuBXS8jU4LAtaGSLY+FpS4YfvAPWQ5Ko+Bh0iLBTxIF2z50CDF+3W+Cdyq0AWFrIJ30ND4vKKgBjXRKRrURsdrrWOvf8DUTGq+Ozle2Gl7HVYpo39nZBFeF0E0v0vbArv9EOGpWtOFf6e0gUwGknc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nyCzkzl1; arc=fail smtp.client-ip=52.101.85.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkpHdUTuWE7WiNSv3nPouYzl8g3ODTijMbUHaaTA4VFXsvpaz+PAJdDIJ8+G5PLHjKG2dkOnqOyco8FbD0F4vJCHzalzrIywezC52n3PpuQUtBXNRGhyJnP4niTXuRqkrJjxdA48vYxb6vl21An6oXXEDDArtniqJXFlwz+01LHzkUEAOgkPAkwweoG+J/iYUSk4mc96gJQGo3CIjviqiSzCKxRD2rq7jE3Fj6zyIhQM9c7gqr+dEOOubcbXnqclTBLqMLKAHfFoqDK0+0z1nZe89knPGfXVCdukJo559Uvqko7abMZVbT0XpPJZxIU8h2WBwwgvD7nUKvlej2Rggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJdxCt8pkD9Bp3hLDJ63MYDfL3TPK9g4tOJGNDGU/k0=;
 b=KeHKk+vq/KaZncFg75mrKqap2cI+EuGKKnTW/of7CnvHtlgqx80JqBQLBBQynnAV8P3CMOv6WcE3HXiTpX6lRcU3auzPt2NFZIqk5MaIr516xHP+qdpu6YKUDj9AgjGNiI6uiuagjh3AehD3G3C+x4Cg0ktTqZqhI7BYEZNlcJSWt8kbtJ/H5vwQ3WVoFkzaVCAdyJuQ/SV9MyM3hFdLFbqWFiB9mvMbA7ioRAAGIumWTvAs2hK2ovt44p4WnxDP5FkCAs9z0GUd2keonphCakE3ns/9NAWevOuCF59/4dXNjB9kYI4dQ025OWj1VGhHLOdVDenBQAn73Tncc5YfKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJdxCt8pkD9Bp3hLDJ63MYDfL3TPK9g4tOJGNDGU/k0=;
 b=nyCzkzl1wHWIv4udz+utUwUUKAQDv7GybBFK1YHX+xT+xhlV+Gd7yoNwUO9Q/8X1cM2dLQhXFs2eYbisBWj0rXBuz3P/WH2Av6kncaDQXbiC8myvJo/dHQjRRK9MXoZp2SSYewwcxFEGf1/8/GeqHgwhqtbMPq8b7GwMFWIdP5mFB6XJ+/10wdABpqPzf/fvBu3n1XPt30bl/9RfHjtm9SShb7JQqCYWcHGJd7+qwcIjjG5OXUbB3r99iUxwrYTcWQDJTfzDvJ+RqZDHTKWPPQVGPGcN+V3MQreb9btc0Z58UgwCfZFsekaf+qVCY6tiD/kC/fxpU4quwkZB9t3PFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by DS5PPFFF21E27DC.namprd12.prod.outlook.com (2603:10b6:f:fc00::66b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Thu, 19 Mar
 2026 20:17:18 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 20:17:18 +0000
From: Yury Norov <ynorov@nvidia.com>
To: "To : Jakub Kicinski" <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Yajun Deng <yajun.deng@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 1/2] octeontx2-af: simplify rvu_debugfs
Date: Thu, 19 Mar 2026 16:17:10 -0400
Message-ID: <20260319201713.941956-2-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319201713.941956-1-ynorov@nvidia.com>
References: <20260319201713.941956-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0088.namprd04.prod.outlook.com
 (2603:10b6:408:ea::33) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|DS5PPFFF21E27DC:EE_
X-MS-Office365-Filtering-Correlation-Id: decef168-283d-4090-7d23-08de85f484af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|7416014|1800799024|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cYu5SoohsRGAqIJlVO2UjUPXht6LNEX6cOxLc0zs1s16ecvIy1nkIp8RR2h204GsV4e4gsoeuP0tpurYsHOmUKzpbVGmPPhRlZKo5r4YaLs7VIv62p+VYYgTLikt9X2Aoa0/+dT5m73hQAm7DckjUxeivbKUZKOVrzMj6QWqMIY3ZJIjrd3WZkaxHzPdrXxEMLg+muHNVODHdO+0qJqInK+P1n6rYFwHaXlbasvI00z2LySLcFOurJaKsajNo0b6z5ptyjaqP+vmLpD3lLpp8aDKJ9WBslY2NdVauiAZM5lyzTZfQ97+99zDSQPuF1R7nVOsD3nAcBGpDjZrt17+W3sFav5jrk5IT3HXpC9DarB6cF7Hjsv7toZ3U3aIRFuaUTacax6qKiYh+LPuLAf+ZfW9PDvt+q6bTyDFB2rzS9oGl24U0uSdEtup1yiwIc12XhLgHsTdTFWOdpPzDI589+xxQT0ufEF510p3RPy6ikzbLjoD8uu1tepWT+zXdS5JE90VPqtqsmOrssSoTdtZ2OwPZSzm0FT/bm2H/pkwvrUtOm22ug+fRwQcTcdDl3Qq6+mYwo7CxyIbew8Nn+UKonCZu/XniCNLUj39mXF4wuiC7DfOUc9PPznSRiJLXdkMdopcT9HGdErNx8DGv6DZ3PNeh1BCgmVidvukzex6+EfmLun7btBRV5A2q0i3OCh0Rgr0+OV3t4dCNfjVS5fslSI4E2aa20v2k2fz+MwC769peJXXvv7D/t1SbNztWDQMaZXGZaTq8dR/3b2cqWVXHg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(7416014)(1800799024)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xWghUygVo2O+wCP30/1sKQ8E+q2UtZ9ADJPM7CKJqhWXR7aTJT1FvZjXxo+l?=
 =?us-ascii?Q?/RQuZLe12j3JBXfeeQuT1daKnObk/V5sBhKP2JNfiJ/stY1qSWU8Yhap2hSy?=
 =?us-ascii?Q?QXXQ5agUUJWaWSlWwBpC5lgFESjqwiS5ro9QwfCd7HdPkzlr5LavZ9WeJeaV?=
 =?us-ascii?Q?NDSEtUU2EZEfHBWKKMSEVM8VcpHyhqHJlHi/GVFOpaUD99pLZ9yDOOOmHNh+?=
 =?us-ascii?Q?Fs52nEW8pFfYWoi/9xG6QWbT/OpOjdYH09nqKak8+aFWx5n3G2rDGEJKVNDT?=
 =?us-ascii?Q?dAha2EGhu63Rq17FpxbLGGFjmiPEiLT23abnunFOUkWub+HTwP2xOj41xfis?=
 =?us-ascii?Q?e1paLnzUOzTeyNpxDp8pdx2u273M0tmqy1T/B5R5gr8NyRhxNUifTCRxFDa5?=
 =?us-ascii?Q?lFAVdFeUZkmTKBow440/LS7h7Wg78Rw+awOcxgqWiUCfhJQsvVh8+BtTO4iA?=
 =?us-ascii?Q?64UkpCFicsHb/b5BjLmmZEp+5mq63URFx/qVBBgdMNFOTeT12d5+bLRvUdUS?=
 =?us-ascii?Q?7i+44iL3pDwTCk4y/0ZbE6V0qBSMVrltaBo7/0sZ+pHVM3p8HJZ1EDdaK2wy?=
 =?us-ascii?Q?YK+Z8zqU4s7P1bayr5NZoppXaFk+ydt3S75qldcYhdHuTbBFYoQ9EPycNa1U?=
 =?us-ascii?Q?fbQ2DbrJqSXC+pMhzxeFV5v48KC6+2yv5+XyXOcRKPlbdv5Q95XUHRjMxSo3?=
 =?us-ascii?Q?HQ0we3hSJy5En9XKhKQRNoFCd71bio+PrpbZqyR+nOHah86bZIhNZCL6ht0b?=
 =?us-ascii?Q?510uosskXKNHuaLEEsZjpBZM5ANR7i/aOPUi9nUXu2JzTvzWp960tEW392VL?=
 =?us-ascii?Q?0sv1zIuxZYhk5EkaiY0swxZPFDc/RKGr7JVguITwoVZaNKuqNo91GAXP78PL?=
 =?us-ascii?Q?VNJ+gtnR8eEBw5+UHHx6vNuyONELif1IGsYBkYF1/IllI7RMZfkhxXV2fNhk?=
 =?us-ascii?Q?XWEiYD0oD7lNhS5q2HyUmpBLDXFNRfgBH6jd8lxBY27L3yaE0W4Mu38vrJF9?=
 =?us-ascii?Q?GyoIHZLbyfbHFbFInun7ototB1oOL9+AqLRdKmDsHymtNrCA+BH0nY3yZ6Ua?=
 =?us-ascii?Q?VWeTrUnkmvyORiHE6+xIWu0D5vJfrKY+o+cP3ZlQudHQMiNORJ65imvbrHi+?=
 =?us-ascii?Q?1LlJpIltbmTnqw8Q/mmehbfs04Se7MXPlqeA2ifrt4DUKXaD8pBlTkxPmkXR?=
 =?us-ascii?Q?vy3ua5HqBKF9yZMav6hMb1h8o+VXE1MwS3CYoz7fuWIDRdpsJ/YC6fDfab+V?=
 =?us-ascii?Q?bq5ptyAtHMbZYzqAT3NA+TXZj5w4pAyj1gV/vV01fxcXVCDmCXu2WFS5DLWN?=
 =?us-ascii?Q?nu+/f8y8/Dpwlt/+HmFrZ/vOL+YTIGjKNzwFZeDgtQEV4Nl9vvdLgN1Usy8y?=
 =?us-ascii?Q?t7PiNnzGvxDuoJaDgqeufzycKEfSOjKU5PTj91eoC68U1H7AsVbjHs6TZxdc?=
 =?us-ascii?Q?HOWtYfhIvaD73V74dG9iPRAOYv7v+yBtD+NYa7bOacruSusLnM43Kto+uGlu?=
 =?us-ascii?Q?YUSOd/1NE1oy1ZmtzqTiYvZQXfM9s7xI57XF0yZo9TfJOtfmE24z8q4GY/nt?=
 =?us-ascii?Q?09Bbybi+ry9Z5nmEclqflE7ImuYHYCPATQy2K+iy1SZik1nY5rTE+I+2E42u?=
 =?us-ascii?Q?s+AGpzj3hLFwbspHyRHA5n3g1drungq2pz36b1zanOAmqqJfvv2S7iNbkoFg?=
 =?us-ascii?Q?Rnw5iExigZBqXvsAf084IshsJurJ8kdx/G1vwxR+wdLBsxf7Eya6G+dOy+z7?=
 =?us-ascii?Q?obBDSeiVXFpCL0kwXYoQWjh2Nr0mg3l8OtSl7UJYvxl+p0x6L0/I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: decef168-283d-4090-7d23-08de85f484af
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 20:17:17.9530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0DmdUfYx0mAMmXfai/Nc5Sjx0pkYifVKaL76rJN9cg8e9BUIDTpz15L5nwC5TurjlHqZkw+aWl5t7JVgc4hUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFFF21E27DC
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,weissschuh.net,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269640-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.926];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09DA32D1FE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver uses bitmap_print_to_pagebuf() to store human-readable
bitmaps representations in a temporary buffers; and then feed
seq_printf() with it.

Switch to using seq_printf("%*pb") directly and drop intermediate
buffer.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 .../marvell/octeontx2/af/rvu_debugfs.c        | 28 ++++---------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 15d3cb0b9da6..9e5a85998ccc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -960,30 +960,21 @@ static bool rvu_dbg_is_valid_lf(struct rvu *rvu, int blkaddr, int lf,
 
 static void print_npa_qsize(struct seq_file *m, struct rvu_pfvf *pfvf)
 {
-	char *buf;
-
-	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!buf)
-		return;
-
 	if (!pfvf->aura_ctx) {
 		seq_puts(m, "Aura context is not initialized\n");
 	} else {
-		bitmap_print_to_pagebuf(false, buf, pfvf->aura_bmap,
-					pfvf->aura_ctx->qsize);
 		seq_printf(m, "Aura count : %d\n", pfvf->aura_ctx->qsize);
-		seq_printf(m, "Aura context ena/dis bitmap : %s\n", buf);
+		seq_printf(m, "Aura context ena/dis bitmap : %*pb\n",
+			   pfvf->aura_ctx->qsize, pfvf->aura_bmap);
 	}
 
 	if (!pfvf->pool_ctx) {
 		seq_puts(m, "Pool context is not initialized\n");
 	} else {
-		bitmap_print_to_pagebuf(false, buf, pfvf->pool_bmap,
-					pfvf->pool_ctx->qsize);
 		seq_printf(m, "Pool count : %d\n", pfvf->pool_ctx->qsize);
-		seq_printf(m, "Pool context ena/dis bitmap : %s\n", buf);
+		seq_printf(m, "Pool context ena/dis bitmap : %*pb\n",
+			   pfvf->pool_ctx->qsize, pfvf->pool_bmap);
 	}
-	kfree(buf);
 }
 
 /* The 'qsize' entry dumps current Aura/Pool context Qsize
@@ -2545,17 +2536,8 @@ RVU_DEBUG_SEQ_FOPS(nix_cq_ctx, nix_cq_ctx_display, nix_cq_ctx_write);
 static void print_nix_qctx_qsize(struct seq_file *filp, int qsize,
 				 unsigned long *bmap, char *qtype)
 {
-	char *buf;
-
-	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!buf)
-		return;
-
-	bitmap_print_to_pagebuf(false, buf, bmap, qsize);
 	seq_printf(filp, "%s context count : %d\n", qtype, qsize);
-	seq_printf(filp, "%s context ena/dis bitmap : %s\n",
-		   qtype, buf);
-	kfree(buf);
+	seq_printf(filp, "%s context ena/dis bitmap : %*pb\n", qtype, qsize, bmap);
 }
 
 static void print_nix_qsize(struct seq_file *filp, struct rvu_pfvf *pfvf)
-- 
2.43.0


