Return-Path: <netdev+bounces-239690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FDCC6B5EC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 20:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D46B234E6E9
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63468366DDC;
	Tue, 18 Nov 2025 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D0mFeGJH"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013035.outbound.protection.outlook.com [40.107.162.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472D8366544;
	Tue, 18 Nov 2025 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492770; cv=fail; b=IzmccJKZOQJ2G6YHzxmiDvfbcesVK37ntBRcNjG0e976yZ4T+BUX+glnYIPSfL2iUN4Z1tzPIgYJV5DLI7apVKyMVbQ54bO8Ppqu4QLBu1lChyViw5IZkUjljBqEHgxtfHSx/PHq2fhHw7EG7xvyKAvbExNDdqgRo4AVQF4Gmuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492770; c=relaxed/simple;
	bh=WnZajlIvWm2AF+zASSBQVUpMkaL5dUMVFRknuaFYMHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dJtzl9ynVvqHS6vfYka0DD+2APwixHbouvwLn0ZnI1SQh3wJDE2G+hF0lGQwCdU0naNOBddAoysVOQ98GRU2Ia/fLHhjKa3hjbJEAWaxXaSFxtPguTEtn9WEcfxuQfKi346jTmljZiUMovhM2waZ2RjfwTAMxqGrOQvPgqlOzUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D0mFeGJH; arc=fail smtp.client-ip=40.107.162.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khYXFtqmxTx/gGBqLue6KtkfnOGy9BmcY3d+YEtD3jqISxvMpsloqkPYcB3B8vAKwSlKOBPOUHE6P9iHFTTldVm5nSeDNEKGbJPvZfjun2Rm2N7mqhn1Sa6u7ZOGDsDIbbcwyLC3hNsC6+B00kUh/1sq/I3/3NsGf6/5xmwqWHjyI0vEKFSFdjtW6QBmJhIjiU4+G8t6NJAF2IlPSUrhexdZyJlGkyahbgTM784nK0VQVMwDN2WInU5jWVZgKLzW+xNxM2APlgKWBYXBL0jjUGd1tkKwnv0xr9KPcLJ0WsYTbR1mXjdw83/GauHQylvdJNqTQ23LkfVBrRbLds2HMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sP7UPxyDJVGXZCSRIxtDQ7YL4LSF8sVpjb+knqDL7k=;
 b=FPBLuzPMwN8nl2WvEVqI/XM0xL9gFWvYLnFzMu+AVnmr2ZyDZBzwiDnFaUL3HOQqSTo97IoVHxfAuwM5+ytZLR3FrskHAVDODGcadkSdV1AcdhEzPMxGLaNA2GvRmgyDHjE+bvv7jqEHUztg7y3f6eN7npHbHBbjwpAd4JEe6Hk5OybrKtWmM3tkyTMbm0Cozg3MpVwdqLOaC1caf1jTH+Rd+3iRnoIHthO0dWQMaBeMETHplTUpFKsHLSCZY8lvar1zTtemF7iZm8Ry9hEVJO5E5fjZ5wakBxZsBywOCTdH2vzRURbIyDWUsO+H2/4UunXotSif3UQIjizQu8l17A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sP7UPxyDJVGXZCSRIxtDQ7YL4LSF8sVpjb+knqDL7k=;
 b=D0mFeGJH0whM+Xbb3WsTZajElxw2bTTwnjBaVXDr0uOzMUjiXSSjDi+PQsdfUAvij+xbDtGF4gtP0y8QVRQDtmbDeXRur9slCIqVlSxDi4bfJL89TOfOtUQk0EjCsOEdEmfapZSxViGU6RWaY3lrYTWfB7c4Uqkec5ni+sMVWVheEPGsXhuEzAkF3Cuc32y32NnYq6kEsQZXCNCfyJOTrHqIqdqm7byj0xmoVCcM1+Dyt5i164PzG3WzLP0p91JYzWBRLWgyKJbEfW8DxNpLEpoEo/pfA6PSX9ZO/0jDO//yZEsElNcS4yfdigRpga9AJc89E4eYalPDxTBnWu680w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by PA4PR04MB7695.eurprd04.prod.outlook.com (2603:10a6:102:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 19:05:58 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 19:05:58 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 10/15] net: pcs: xpcs: introduce xpcs_create_pcs_fwnode()
Date: Tue, 18 Nov 2025 21:05:25 +0200
Message-Id: <20251118190530.580267-11-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118190530.580267-1-vladimir.oltean@nxp.com>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::32) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|PA4PR04MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: b46c3428-08bd-4148-01a2-08de26d58227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|52116014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BOCCfATBkHU2fUGsUHUxQPm4jLn49hllobKjaYz3bjAX7Gq35TBgHVRpb7OQ?=
 =?us-ascii?Q?sOdJK+q4S3iwhigQXRU+nl8Aq/y2wtGzppuKFBU1EmsIVH/l+hDOqYtusgnX?=
 =?us-ascii?Q?Bgh3a9uahHNKIPfXCfhwbISa0bSd/0gyzlSZ68QeMgFKRL3NLr1U2W5v20l4?=
 =?us-ascii?Q?Him3dix7bfOKhT/DOEio0Fk2/MgFlOyuw7lKpWnaV62rHnt4Hr6SVL97oP5n?=
 =?us-ascii?Q?hdXjP20t43Srm+Eoxxs9Eo4RURVvR8OisJLnIdhUDcx02RBodVkYx+xpToTV?=
 =?us-ascii?Q?jdLxik2ZJsaw7Jxk2MyH6AHx36ZuVp16rjs0q75Yy1Ko4N4lsq1GhxurN5Ax?=
 =?us-ascii?Q?rjdoh2kPVPUx13SX0DM2wssz4DTS8vZMFfRRPEPl+TohECAc3tDlTpsMf6VH?=
 =?us-ascii?Q?le37RzEMSy7SwSVeLT384OBi6TQwd2GnDZFv8EzyQHPYtCss2TN2bGBn/bu2?=
 =?us-ascii?Q?+9s1H47fD30VHGFJLrH1reGs1gx2H5Gm/+Fub21DUFgZjX+DMGOnhs0M52NG?=
 =?us-ascii?Q?lCStCQD2j4aZMiNs7BJYDQqS4MigSIozvpBcPXPjt7JIAzIktM+A2d6IpvZn?=
 =?us-ascii?Q?4LDIm5EWOVnmjPX5M4UTMHTyY8/ecRrYk4ea+Gu761AS1LGgusleIfRHIq2/?=
 =?us-ascii?Q?IzXTVHQAUY7Il8aa/8r1Wh61817FWjfEJtN5ol0SFtyx5ZbpysYnal/L6LuR?=
 =?us-ascii?Q?GW8kHnRj6hZ9oyJRwdozFRoxqFI2ATnasHhqap5uGbSu0e03WdKirSVRpNt1?=
 =?us-ascii?Q?H12puMtgjlD06I3YQRzX0V/5cg/lPTG4R7Q9Pp341xjckYW6vhe7m4lW3Z8Y?=
 =?us-ascii?Q?vPm20wa/ftVm1UbydpohxL3NFcAWqlksC8NWXNkhisENfx8iqM3Sr5WLfyt2?=
 =?us-ascii?Q?Ii346aRqvvKJ0KZf9oPpJROy28f81qdc9jhHe1lsJNzj9Hdi6T3cCQcIWLFm?=
 =?us-ascii?Q?HCABGCb6UexxtkXlNgrB3tw3cZbZZa0mmIbbS58wAxco9UlhS+n3M2KjHX+4?=
 =?us-ascii?Q?MjM1miXP8Wdfl5j3nc1rBNrUkL4ILNTp++PXTAiMuXd55dwQzPOUbQw7XbUN?=
 =?us-ascii?Q?wLqXfjvz25UWHI7TyerNxIFqT4PmrZC2nIIcZ/4NhyU9cvVFB019cMv25MdJ?=
 =?us-ascii?Q?LolipjvHljsfgcLlsimYn/eYEaFk7vfq3XVPDpWC6/lEmE1rt4VATb+aOY+y?=
 =?us-ascii?Q?y3Fyk0qgtStuiwGnc4uxyDIBArzEBUgbgQgq3S/cNCRChEks9faPi5dH7tDC?=
 =?us-ascii?Q?05dvVgUm/Fr/j83/cDLGs9elxB5UUcKOBICzMTVownNtJleQAY2BAxSicD7D?=
 =?us-ascii?Q?1gWOg2j4fFd1ZXsoUzyAEyCeJYcztVACiAW2JlHTVoZx3sNW6nj2lJ3fYFBf?=
 =?us-ascii?Q?KChhjRt9uKtv11VY6xYzHGXzJxcyd2K46pWP3hNYrEDpsR85JtqYAOyjhefK?=
 =?us-ascii?Q?/KvD2YYpMQet5kZkZ0CHn9nBfbecRCGr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(52116014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mUpMO9n/W72+H9o19vhayyZF+dfh5pZxrWo6dKqDOYB+q2Hb25x9EmgEwv4K?=
 =?us-ascii?Q?Zxkg+2E7/oIQa+YMjMxxJU3nMo9FnbTCcsO9JCql6DODNdEss+iR46eTAvOK?=
 =?us-ascii?Q?El21UQWqqZ7rBlNDO20ytGzC949PTrx4yYTKZBpnxAnidAnaepw3Kj+Z7m6O?=
 =?us-ascii?Q?AHiFqKg1Pyd3iGXCgL9sgObwZZ/+LSWbamHwvJPGyaquD2BuWDlZC4WnuRA0?=
 =?us-ascii?Q?RuAo4y4EwzVbEL3uoY/wVRqmpbYBGFngq9W5s+3JHGUWgT1tO1bMKTE8jT1D?=
 =?us-ascii?Q?EeA508QmtZA6+r8wgGlLBmo1jl1T4m/pma/GqpHEKKEhjmPQqWtfy7E3XJOb?=
 =?us-ascii?Q?0gWQ9+TvdLZjqNa2oyE29axlEuQU6df2UW3d/8aXRPaom7iTZ5Stv5iQBIPz?=
 =?us-ascii?Q?6iWBUdfZa9pKKgSwp1u8doCNy3BygCyfMiKe+JEsy0yNlVNS7Mz68M5hi5Kq?=
 =?us-ascii?Q?wdesYDwaN5SqpBFnxZkDvSQxLqQoWID4hh445ysgmAocHQnLRgJMgdKPczcE?=
 =?us-ascii?Q?m3HUplBFCvRwwjCBycRxf8tzi/UX+x+VyuXwiQjRQlm5NG5NEX/NUv5TIS8t?=
 =?us-ascii?Q?QmuT27hgR3LddjzQRKhXbh6lAiJ1PrvH1KyJTJzWyghyQx2raN+Yh/VSvYQC?=
 =?us-ascii?Q?+tOz/ITUNiSb9SPFCoGo7oaid9isBKoAnusBZ93sbOmvASMQqJIMYQuJwONB?=
 =?us-ascii?Q?PdHiKGnMsoo3CifzLisbE4Agbjw6/FTNGHWokTPAq3MLx9WDlnTPZH9gubVw?=
 =?us-ascii?Q?dgD5DUnrTWrLLYQDz5jqzKuvPCckjAjUqDEwTubWSnkZwKaRcv9o0NQuUmdk?=
 =?us-ascii?Q?rLo+wQOgG5QVWthXiaHf4EmV4dDqouLrFzDUI3Q67u9iO26zaMG/2tHFKvQ5?=
 =?us-ascii?Q?cZrpSDfd3nOwINbCfkvDfb61KAiYHDzKoGVgiYUNDNR3tcJE4aGggknIydhL?=
 =?us-ascii?Q?zqtmCJQ1WOKYXGKSQMX0jGNlK/1tVRfmFgyYCFF3nOlAtivWpeEc4oc4Lk6I?=
 =?us-ascii?Q?+6J/88hvnHCi9P8k1L9L+jb2oczhukMgdtWYmVF/2UKMhK0IOYvzGYqLPswO?=
 =?us-ascii?Q?XUl3vTw+rLVAEEw03XxCAub4P0I2fuyYzToxeI5jFMAZbtlkddVrCKM6rXFE?=
 =?us-ascii?Q?mANBJP4yHsGXj61j1OKv16Mf8Z0pewsnCGwItnGQvVLgdrEKVdSdsAAg07ce?=
 =?us-ascii?Q?JpCY+jDd0zhOmplmIY5o0cIybmWNUB2ydDCg9SAFXq8UbLVAETtEXdZEKf15?=
 =?us-ascii?Q?sx4i8I9QmLu5QbX8BHmHlNYKih7/Nz0Pb6kyKG958Weh76QqPHC6swM4kADH?=
 =?us-ascii?Q?KHYnj+bKd2O7E5mkvfg0w6tCInDyIsq6pOUCtitcz8VpNG4JiRwPXMqSjtww?=
 =?us-ascii?Q?Gwz7cClIDsoQuNXVd5xH1ZrGqQQ+P6w2CiXSIMuLylv5IBbeGYJtlGQiotaG?=
 =?us-ascii?Q?Cp8Sv6UeT94yC65uW0NVB3/TxSnhFSCRyvMb8G4xSiLVjbXMlVfiiSpmqfOV?=
 =?us-ascii?Q?bw7DAEcrAsaAQ2cTpEEDc5VQtdgVipRj4CvoKrnYp1ERDhr+WCZv8CUYnKxe?=
 =?us-ascii?Q?4GUqXtF956Hhz9jn06uresI7fogvFM2HLLRNNgGu75woYXtX1cO84wBuu3ge?=
 =?us-ascii?Q?Xa++tAlWeJyWehUQChNHCmk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b46c3428-08bd-4148-01a2-08de26d58227
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 19:05:58.8306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfcmKuCCC2c6NPOlCJ5qWo9Qu0UOZV00ZFTelC6v/PqKa8s3bsrX7g/pt9V/VVe/hL2XTBv3TVxkis5Kkb8ocA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7695

Introduce a wrapper over xpcs_create_fwnode() that doesn't return the
specific dw_xpcs pointer type, but the generic phylink_pcs pointer type.
For example, the NXP SJA1105 driver might use this if it has a
pcs-handle - it is already a user of xpcs_create_pcs_mdiodev().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/pcs/pcs-xpcs.c   | 12 ++++++++++++
 include/linux/pcs/pcs-xpcs.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 3d1bd5aac093..8f7c43a066c8 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1591,6 +1591,18 @@ struct dw_xpcs *xpcs_create_fwnode(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(xpcs_create_fwnode);
 
+struct phylink_pcs *xpcs_create_pcs_fwnode(struct fwnode_handle *fwnode)
+{
+	struct dw_xpcs *xpcs;
+
+	xpcs = xpcs_create_fwnode(fwnode);
+	if (IS_ERR(xpcs))
+		return ERR_CAST(xpcs);
+
+	return &xpcs->pcs;
+}
+EXPORT_SYMBOL_GPL(xpcs_create_pcs_fwnode);
+
 void xpcs_destroy(struct dw_xpcs *xpcs)
 {
 	if (!xpcs)
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index e40f554ff717..1fcbcd419ede 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -56,6 +56,7 @@ struct dw_xpcs *xpcs_create_fwnode(struct fwnode_handle *fwnode);
 void xpcs_destroy(struct dw_xpcs *xpcs);
 
 struct phylink_pcs *xpcs_create_pcs_mdiodev(struct mii_bus *bus, int addr);
+struct phylink_pcs *xpcs_create_pcs_fwnode(struct fwnode_handle *fwnode);
 void xpcs_destroy_pcs(struct phylink_pcs *pcs);
 
 #endif /* __LINUX_PCS_XPCS_H */
-- 
2.34.1


