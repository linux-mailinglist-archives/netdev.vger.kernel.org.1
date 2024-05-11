Return-Path: <netdev+bounces-95666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A858C2F3C
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 05:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D56E1C211EA
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 03:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DFA24B29;
	Sat, 11 May 2024 03:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IP7hit/z"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2088.outbound.protection.outlook.com [40.107.7.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF0824205;
	Sat, 11 May 2024 03:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715397224; cv=fail; b=AwG1ijHh3SQKWTiAg4tls5wlpAAh5ml49f/gEmfwB8WAJnwLuhOyACsevE6eGUibA1sK5LAaU9FW0yq9BKHJbWh22e7sKP+z98bxmuqqyxNQg58x/KPUZmaw0XAsxGcHJDqxDw5DX5tHjZf6JksC3BqK8hPiMzP958YKAdDeq/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715397224; c=relaxed/simple;
	bh=H2/jmSpj3Y6alagG8Aq7JZcCh7RLiKS4pVGYP5mWWpk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kNe100VIr9wzLtsBClUNYAcUKSAKdLreudto10g7WLjs6y8AHegeOufA8/7BS2r6ic6mMYkPQffan3Jzot5miaTZLIVgAuR+p8Oz+8x4KlSf0kTFRVz4xsko1psYjCChEHUtDjuUgOR8Wdbt2YuzPkVbKjUsDg8+dpeu2N3Hmpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IP7hit/z; arc=fail smtp.client-ip=40.107.7.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgX8AOxHPWEhWMjySzJT2YCMGGXI+e0gbJuOwOPhN+sLWCE0AHe8b7GAJpxOU0aPG1702tVezQ32OgziQoBClOF1rhPtWpzVoOzeGSrsn4MlAY/RbkgVuXnUWLB5TFZDZfBdp6hFAfjtGSYfH9EciCt6kLAkK7jp1QuQRSPyNo8L7nIwzuV3jlSbWIYJ5zvsb9pICf5r5UXr+Izsrz2LzfkjmzgNb0PXzkRAET0O3KC4px2GgIeGBE+oLfnWGQ++GgKEdDJ6461cnB7wF7Abaa5H66YXWkoHag5dp8+9CvXQaA3+WJQF4e4RWH1XlVbJVPsX3lXTHnaJOt09EC+J1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aURlTuFR/GgtbC2cctXbJC72dg0lfvJkyvdmlUxZlVk=;
 b=ibO//c8zzZTGglzABXdJXnObk7EglI3z4bz1j/HWfjy5i5fbVyNUgU8fV7nLoQEd3ub+fc5hv2v9vCm7Elj/SzfhyTcXs+hd2awPnbeYk99Pd7B6mIhmHAKqJ1+MvuYvx1TdmM6OwBps+q4ebyOUfk05DehKnYgq9EByTGVy3TmSl2MHjGCGh8rraL0dNIKMvGQ22v+zZaJbonWF33poA0qm66yv6608pnNQyknkh7MSWXyRmX2cVVXClX2dy+HgsAPTLZOf230jtpX+xNA/VbXcReCJKvHHB9tbg+HLI1nL6un7ttejrbNQz4Ll7tV53zvTKZrJo/5uZymAE8Sj3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aURlTuFR/GgtbC2cctXbJC72dg0lfvJkyvdmlUxZlVk=;
 b=IP7hit/z59eECJ3tsApIHGY4W8HMrZHFcGjb3m2DU9ilHqQ4aUMpAv8F1QBLa3HMU0CYhWSgA1nyviffLoEVB/3FEX4ES5EnMmPYZZvmLuQUujRkfsENv5ztG0S7QKpJqeuhlKFohAnvUnk1MLSJ4j208plN5NrjyxAJUytv1Vg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR0402MB3891.eurprd04.prod.outlook.com (2603:10a6:208:f::23)
 by AM9PR04MB8129.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Sat, 11 May
 2024 03:13:38 +0000
Received: from AM0PR0402MB3891.eurprd04.prod.outlook.com
 ([fe80::6562:65a4:3e00:d0ed]) by AM0PR0402MB3891.eurprd04.prod.outlook.com
 ([fe80::6562:65a4:3e00:d0ed%7]) with mapi id 15.20.7544.052; Sat, 11 May 2024
 03:13:38 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	richardcochran@gmail.com,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net-next] net: fec: Convert fec driver to use lock guards
Date: Sat, 11 May 2024 11:02:29 +0800
Message-Id: <20240511030229.628287-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To AM0PR0402MB3891.eurprd04.prod.outlook.com
 (2603:10a6:208:f::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3891:EE_|AM9PR04MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 066ec02e-1c98-4c93-6d28-08dc716859e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|52116005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5F2VIwcAKeejay7s/UWFtnqD6Oh96t7nYyIUWsaUqGEydlBJLRhQggo/Z4So?=
 =?us-ascii?Q?uhA/irXhPA350tC2ujvKRIhTs1zs3W+f+V2p4eMqCSEflrBn7SOYsuxIJE4G?=
 =?us-ascii?Q?VG4jFI/IdDByvql4CpB4HEQpzaU36MTMU5oSMdz6RUwIyTVzeTxBCIyu/wSC?=
 =?us-ascii?Q?BavkiSsG3PQUdi4wcFJGtYWr3Z2ONx+aV9JMImecbFOpbEedyTcyBfXBwbNd?=
 =?us-ascii?Q?0BAvkme65QwiVd1zlBUeTAHjHJLmP2tYnvDLFDQV4TzmLaIUbCF7vpfmHYCD?=
 =?us-ascii?Q?6lpVDg5/Xun3rsEBd78V0SHjx8YCfQYX4LQajipLrKL6HwuupbbbilB9mceB?=
 =?us-ascii?Q?W3gQTOs2rZqmQmSQlsW3u9LIazBntARXVgu0M2KtOG2KMzJik3Gk9GmUF+D/?=
 =?us-ascii?Q?LyVkH9ByBTzv78fbqNpBUQpGu5kLPm7C5e71iZVU5e97i+0xHlvoTv7JEIRv?=
 =?us-ascii?Q?IFO5lwFnwxTjJMAmL8mZA/Obo6/XpWQzYaPX6eGFuSYL9Y9Rb9Ezeji5UOiG?=
 =?us-ascii?Q?gbiBIcB3FMCnKxTRDYca6s1JTLqc/Gnqh0KpP9SjCxT/yzWZZ9bEm7+jyCMH?=
 =?us-ascii?Q?DCN6ztBc5mGabJzwdS0kjrg16TSuuHJcK6OSZQLR9pH9batgFm9XlR8FX778?=
 =?us-ascii?Q?2zo3Iyl90A687dA098vOKEKw087bVeS7cw6zcrb77a+fucYjKJ8uRXPtKBzN?=
 =?us-ascii?Q?2BXJ8usvrmrBJVzVKmjgnQT4qJk9PWF0c20VhvgmkktyejGyYA8hC2Bk9FNP?=
 =?us-ascii?Q?Ku/qOo5/SDv9Ha0GG3UUPmaNKckLg66TjYA/XEiWaEcy0RGwCiTa0e3jIXYF?=
 =?us-ascii?Q?QoqAV4xdF6a+G7AoF8mi45mIm8IcyxL9uMzW8qjCIuyGTy4fyQxfLkKh8lks?=
 =?us-ascii?Q?ZaVYvHKf+nv7Wwbz1tewqXOxTxH2gXKLjkCT/yINmlveBwQNTrZm0UYSz37/?=
 =?us-ascii?Q?iMFTn5IdEXX3Fa1z+cKlQ7Aiv6yl3BhgrHgOF8s9kODkiA22RpW0B7ai9oZj?=
 =?us-ascii?Q?uEiUBF9n0rIYIkI4kdUL9RisBg4vWSdnB/bXUMrqPsbuPcuGZ2iya0odnHYS?=
 =?us-ascii?Q?ys7Wdfs/MYenYIKQyOWtlvn3eAh1t69uqFO7ZlFuA7WRhk0Yr3QIwWh8+mJD?=
 =?us-ascii?Q?Qy5DMk0cvXh/lgTDrt2jmcLGyrvzheWZZ/uhafDuvC7SqALlt6gFb8vJUtlj?=
 =?us-ascii?Q?JzDcRHDS82ahbaVc+9u95CL/zFnnr+8vFx9NxnsmX3r9YJwDGQNuRmoBAWVl?=
 =?us-ascii?Q?QVxN0zkrK3+bnBOEHKfTe1RhydAvDJ/Rh1k2OjWsbfkXuUvVQ46Y79hGcGg8?=
 =?us-ascii?Q?t5jmTDiJ2NaZ6lkIa3f+DD8G/oAhCqY7WdMdtA3kxfRtGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3891.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zi4Px9c7C1KKOjMJUMCkuoX4YNhfWFGYQecixXzqRqvjt0hBaPlTWCqGlUi+?=
 =?us-ascii?Q?3oYYmojZ4d55H4eRe5szAuvMy7RJxRj5lGh2/hnRvp8OWbEXBAxA9XyUr8a5?=
 =?us-ascii?Q?hscvGGCLfzs8qtdilHZBETk9WTBfmhbICWz6H3hGHaaLNtXVrg2++/TsBqi2?=
 =?us-ascii?Q?MUjnborLbPvqbQc+56gdELlOJkObhLyOttzagPszUsHabkeqIZ3/KsYu/V5g?=
 =?us-ascii?Q?3Yx4e5a8TMCTVV9N4mvm3r07P6nTBagndy+8WkJPE+u9DcHvGBfA6xRs5Kmi?=
 =?us-ascii?Q?w7pL1ehlY7dKcpObof2kMwL/gOmssU6G1qNSSulRm91E1tzu9TeKOc0RfDCE?=
 =?us-ascii?Q?ruk3LDalqxb6QK2IBKg3Jm5IheZAgviai2+sa+DEAOSjZtZPcQL/Osg8bgC7?=
 =?us-ascii?Q?z8osfdmDzH6/hr8SVKbHNsJRCnHb5UEJ+mmoM/AGy3jfdYgcxypqcJMbCMZD?=
 =?us-ascii?Q?gnWoIDIIa4NIoxsvGEMojhxuE/nTJ2JCiffO9VcXjrd/mcyFdcc9cIw3imQa?=
 =?us-ascii?Q?6YJGgyaJUPMbE/2qOga/V8nPIPjwNWBDuYqOkfsviqJQPXMQEtuwHH2RnFuP?=
 =?us-ascii?Q?uWtyK1EXpsG+GObVbBAbHqXsf9/gr+VmTHkNOzBkraVcVgJM/KThs7gRgloE?=
 =?us-ascii?Q?UUzxFoWA4pkGLYWZLcN7VTrCKP6kAda6bik1xB5KHFUp4OdgV98UIpslNr4v?=
 =?us-ascii?Q?pPGNhUmmtPGrJui5gFSZhvWsh7FD+kwB+dP5w9kOdUMPZJQZWGKAz6j0RMGW?=
 =?us-ascii?Q?gFFnBxxcToFbsUdHni0AdctrgvyDyWdLbleYSKqmxajZBggpaly9OWR3XFQL?=
 =?us-ascii?Q?nuhzdeTgm7xmSWsRK0FtTPU2m60xapYoxlFOnlO8qmtyc8r7ALScfjsvRMyh?=
 =?us-ascii?Q?QahxD0ZFDBXDH6uyrTkKFe20o9iYI3ZlWM6nmkv3v46Bxa7qQbIyiEhovK85?=
 =?us-ascii?Q?1xHwvhwPUXAWsey+W0bqFRP1kTsuXM+NbLpIjq+t8m0AwcqkqlQAIewxEfqy?=
 =?us-ascii?Q?Sb2AKHXoDn4tl8X+imvCUVhN+5bxFh7RnATzV/gsnp9llWJyS7hZMUgzW/Ai?=
 =?us-ascii?Q?7T4sR7piFUbTcrG73v8L1Eex3lpIjJZkLOS36+ZTMsgmH7nCOHogup7HhjNc?=
 =?us-ascii?Q?I5JsYpP4uFMeUWC+jyOLVCZyGIJenVxJAT/IHc8sDX5jOeN4Nk34hhoegnQR?=
 =?us-ascii?Q?qd67TAUZ6KtwyKY4kkGuqCMXmuPXlzvZjY5EpaCLYpInjIPW7fs3s/XxQkbZ?=
 =?us-ascii?Q?gKOS6sO+DHkemn08ZmT8LRCR66RPoYh2qsVMkXLKKlzU1sPcrVgvWmsXTQB1?=
 =?us-ascii?Q?1s206OKYHObNtlxSRxhhU2DXTQdEpJu59okUYHAoeH+4X98RdTww2iVE/YvJ?=
 =?us-ascii?Q?BpU5uSeucMK3CgivlcjvMw6218k3Ds9Wg/atBG0JDmEv8KyjfECr1Jb2NMzs?=
 =?us-ascii?Q?xZBuvN3B1emwqIZTp9JNwsoAoVRjBkLjmNuCD2JtajoMhGQeQZEUY+NS35Ic?=
 =?us-ascii?Q?zmTKw8v1YODumLG/arDEBP/zBrBOoV8yghFDCAIw8JKUFGlNq1AWo5ZjL3oN?=
 =?us-ascii?Q?Do40qg4B1VyrVIQEOevVSKHiLEynE4HfxjsuVuYp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 066ec02e-1c98-4c93-6d28-08dc716859e5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3891.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2024 03:13:38.2000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJ6aymGQ3CJZxmyErlbtdhiPWvRpPP75Vx1EueOC41j0QmldRFVweKxwkUbSNW3GAeY23lX5gYgTUlxkOK4EsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8129

The Scope-based resource management mechanism has been introduced into
kernel since the commit 54da6a092431 ("locking: Introduce __cleanup()
based infrastructure"). The mechanism leverages the 'cleanup' attribute
provided by GCC and Clang, which allows resources to be automatically
released when they go out of scope.
Therefore, convert the fec driver to use guard() and scoped_guard()
defined in linux/cleanup.h to automate lock lifetime control in the
fec driver.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
V2 changes:
1. Rephrase the commit message
2. Remove unnecessary '{}' if the scope of scoped_guard() is single line
---
 drivers/net/ethernet/freescale/fec_main.c |  36 ++++----
 drivers/net/ethernet/freescale/fec_ptp.c  | 101 ++++++++--------------
 2 files changed, 54 insertions(+), 83 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 8bd213da8fb6..8bf1490c07e1 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1397,12 +1397,10 @@ static void
 fec_enet_hwtstamp(struct fec_enet_private *fep, unsigned ts,
 	struct skb_shared_hwtstamps *hwtstamps)
 {
-	unsigned long flags;
 	u64 ns;
 
-	spin_lock_irqsave(&fep->tmreg_lock, flags);
-	ns = timecounter_cyc2time(&fep->tc, ts);
-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+	scoped_guard(spinlock_irqsave, &fep->tmreg_lock)
+		ns = timecounter_cyc2time(&fep->tc, ts);
 
 	memset(hwtstamps, 0, sizeof(*hwtstamps));
 	hwtstamps->hwtstamp = ns_to_ktime(ns);
@@ -2313,15 +2311,13 @@ static int fec_enet_clk_enable(struct net_device *ndev, bool enable)
 			return ret;
 
 		if (fep->clk_ptp) {
-			mutex_lock(&fep->ptp_clk_mutex);
-			ret = clk_prepare_enable(fep->clk_ptp);
-			if (ret) {
-				mutex_unlock(&fep->ptp_clk_mutex);
-				goto failed_clk_ptp;
-			} else {
-				fep->ptp_clk_on = true;
+			scoped_guard(mutex, &fep->ptp_clk_mutex) {
+				ret = clk_prepare_enable(fep->clk_ptp);
+				if (ret)
+					goto failed_clk_ptp;
+				else
+					fep->ptp_clk_on = true;
 			}
-			mutex_unlock(&fep->ptp_clk_mutex);
 		}
 
 		ret = clk_prepare_enable(fep->clk_ref);
@@ -2336,10 +2332,10 @@ static int fec_enet_clk_enable(struct net_device *ndev, bool enable)
 	} else {
 		clk_disable_unprepare(fep->clk_enet_out);
 		if (fep->clk_ptp) {
-			mutex_lock(&fep->ptp_clk_mutex);
-			clk_disable_unprepare(fep->clk_ptp);
-			fep->ptp_clk_on = false;
-			mutex_unlock(&fep->ptp_clk_mutex);
+			scoped_guard(mutex, &fep->ptp_clk_mutex) {
+				clk_disable_unprepare(fep->clk_ptp);
+				fep->ptp_clk_on = false;
+			}
 		}
 		clk_disable_unprepare(fep->clk_ref);
 		clk_disable_unprepare(fep->clk_2x_txclk);
@@ -2352,10 +2348,10 @@ static int fec_enet_clk_enable(struct net_device *ndev, bool enable)
 		clk_disable_unprepare(fep->clk_ref);
 failed_clk_ref:
 	if (fep->clk_ptp) {
-		mutex_lock(&fep->ptp_clk_mutex);
-		clk_disable_unprepare(fep->clk_ptp);
-		fep->ptp_clk_on = false;
-		mutex_unlock(&fep->ptp_clk_mutex);
+		scoped_guard(mutex, &fep->ptp_clk_mutex) {
+			clk_disable_unprepare(fep->clk_ptp);
+			fep->ptp_clk_on = false;
+		}
 	}
 failed_clk_ptp:
 	clk_disable_unprepare(fep->clk_enet_out);
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 181d9bfbee22..0b447795734a 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -99,18 +99,17 @@
  */
 static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
 {
-	unsigned long flags;
 	u32 val, tempval;
 	struct timespec64 ts;
 	u64 ns;
 
-	if (fep->pps_enable == enable)
-		return 0;
-
 	fep->pps_channel = DEFAULT_PPS_CHANNEL;
 	fep->reload_period = PPS_OUPUT_RELOAD_PERIOD;
 
-	spin_lock_irqsave(&fep->tmreg_lock, flags);
+	guard(spinlock_irqsave)(&fep->tmreg_lock);
+
+	if (fep->pps_enable == enable)
+		return 0;
 
 	if (enable) {
 		/* clear capture or output compare interrupt status if have.
@@ -195,7 +194,6 @@ static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
 	}
 
 	fep->pps_enable = enable;
-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
 
 	return 0;
 }
@@ -204,9 +202,8 @@ static int fec_ptp_pps_perout(struct fec_enet_private *fep)
 {
 	u32 compare_val, ptp_hc, temp_val;
 	u64 curr_time;
-	unsigned long flags;
 
-	spin_lock_irqsave(&fep->tmreg_lock, flags);
+	guard(spinlock_irqsave)(&fep->tmreg_lock);
 
 	/* Update time counter */
 	timecounter_read(&fep->tc);
@@ -229,7 +226,6 @@ static int fec_ptp_pps_perout(struct fec_enet_private *fep)
 	 */
 	if (fep->perout_stime < curr_time + 100 * NSEC_PER_MSEC) {
 		dev_err(&fep->pdev->dev, "Current time is too close to the start time!\n");
-		spin_unlock_irqrestore(&fep->tmreg_lock, flags);
 		return -1;
 	}
 
@@ -257,7 +253,6 @@ static int fec_ptp_pps_perout(struct fec_enet_private *fep)
 	 */
 	writel(fep->next_counter, fep->hwp + FEC_TCCR(fep->pps_channel));
 	fep->next_counter = (fep->next_counter + fep->reload_period) & fep->cc.mask;
-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
 
 	return 0;
 }
@@ -307,13 +302,12 @@ static u64 fec_ptp_read(const struct cyclecounter *cc)
 void fec_ptp_start_cyclecounter(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	unsigned long flags;
 	int inc;
 
 	inc = 1000000000 / fep->cycle_speed;
 
 	/* grab the ptp lock */
-	spin_lock_irqsave(&fep->tmreg_lock, flags);
+	guard(spinlock_irqsave)(&fep->tmreg_lock);
 
 	/* 1ns counter */
 	writel(inc << FEC_T_INC_OFFSET, fep->hwp + FEC_ATIME_INC);
@@ -332,8 +326,6 @@ void fec_ptp_start_cyclecounter(struct net_device *ndev)
 
 	/* reset the ns time counter */
 	timecounter_init(&fep->tc, &fep->cc, 0);
-
-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
 }
 
 /**
@@ -352,7 +344,6 @@ void fec_ptp_start_cyclecounter(struct net_device *ndev)
 static int fec_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 {
 	s32 ppb = scaled_ppm_to_ppb(scaled_ppm);
-	unsigned long flags;
 	int neg_adj = 0;
 	u32 i, tmp;
 	u32 corr_inc, corr_period;
@@ -397,7 +388,7 @@ static int fec_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 	else
 		corr_ns = fep->ptp_inc + corr_inc;
 
-	spin_lock_irqsave(&fep->tmreg_lock, flags);
+	guard(spinlock_irqsave)(&fep->tmreg_lock);
 
 	tmp = readl(fep->hwp + FEC_ATIME_INC) & FEC_T_INC_MASK;
 	tmp |= corr_ns << FEC_T_INC_CORR_OFFSET;
@@ -407,8 +398,6 @@ static int fec_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 	/* dummy read to update the timer. */
 	timecounter_read(&fep->tc);
 
-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
-
 	return 0;
 }
 
@@ -423,11 +412,9 @@ static int fec_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 {
 	struct fec_enet_private *fep =
 	    container_of(ptp, struct fec_enet_private, ptp_caps);
-	unsigned long flags;
 
-	spin_lock_irqsave(&fep->tmreg_lock, flags);
+	guard(spinlock_irqsave)(&fep->tmreg_lock);
 	timecounter_adjtime(&fep->tc, delta);
-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
 
 	return 0;
 }
@@ -445,18 +432,15 @@ static int fec_ptp_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
 	struct fec_enet_private *fep =
 	    container_of(ptp, struct fec_enet_private, ptp_caps);
 	u64 ns;
-	unsigned long flags;
 
-	mutex_lock(&fep->ptp_clk_mutex);
-	/* Check the ptp clock */
-	if (!fep->ptp_clk_on) {
-		mutex_unlock(&fep->ptp_clk_mutex);
-		return -EINVAL;
+	scoped_guard(mutex, &fep->ptp_clk_mutex) {
+		/* Check the ptp clock */
+		if (!fep->ptp_clk_on)
+			return -EINVAL;
+
+		scoped_guard(spinlock_irqsave, &fep->tmreg_lock)
+			ns = timecounter_read(&fep->tc);
 	}
-	spin_lock_irqsave(&fep->tmreg_lock, flags);
-	ns = timecounter_read(&fep->tc);
-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
-	mutex_unlock(&fep->ptp_clk_mutex);
 
 	*ts = ns_to_timespec64(ns);
 
@@ -478,15 +462,12 @@ static int fec_ptp_settime(struct ptp_clock_info *ptp,
 	    container_of(ptp, struct fec_enet_private, ptp_caps);
 
 	u64 ns;
-	unsigned long flags;
 	u32 counter;
 
-	mutex_lock(&fep->ptp_clk_mutex);
+	guard(mutex)(&fep->ptp_clk_mutex);
 	/* Check the ptp clock */
-	if (!fep->ptp_clk_on) {
-		mutex_unlock(&fep->ptp_clk_mutex);
+	if (!fep->ptp_clk_on)
 		return -EINVAL;
-	}
 
 	ns = timespec64_to_ns(ts);
 	/* Get the timer value based on timestamp.
@@ -494,21 +475,18 @@ static int fec_ptp_settime(struct ptp_clock_info *ptp,
 	 */
 	counter = ns & fep->cc.mask;
 
-	spin_lock_irqsave(&fep->tmreg_lock, flags);
-	writel(counter, fep->hwp + FEC_ATIME);
-	timecounter_init(&fep->tc, &fep->cc, ns);
-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
-	mutex_unlock(&fep->ptp_clk_mutex);
+	scoped_guard(spinlock_irqsave, &fep->tmreg_lock) {
+		writel(counter, fep->hwp + FEC_ATIME);
+		timecounter_init(&fep->tc, &fep->cc, ns);
+	}
+
 	return 0;
 }
 
 static int fec_ptp_pps_disable(struct fec_enet_private *fep, uint channel)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&fep->tmreg_lock, flags);
+	guard(spinlock_irqsave)(&fep->tmreg_lock);
 	writel(0, fep->hwp + FEC_TCSR(channel));
-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
 
 	return 0;
 }
@@ -528,7 +506,6 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
 	ktime_t timeout;
 	struct timespec64 start_time, period;
 	u64 curr_time, delta, period_ns;
-	unsigned long flags;
 	int ret = 0;
 
 	if (rq->type == PTP_CLK_REQ_PPS) {
@@ -563,17 +540,17 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
 			start_time.tv_nsec = rq->perout.start.nsec;
 			fep->perout_stime = timespec64_to_ns(&start_time);
 
-			mutex_lock(&fep->ptp_clk_mutex);
-			if (!fep->ptp_clk_on) {
-				dev_err(&fep->pdev->dev, "Error: PTP clock is closed!\n");
-				mutex_unlock(&fep->ptp_clk_mutex);
-				return -EOPNOTSUPP;
+			scoped_guard(mutex, &fep->ptp_clk_mutex) {
+				if (!fep->ptp_clk_on) {
+					dev_err(&fep->pdev->dev,
+						"Error: PTP clock is closed!\n");
+					return -EOPNOTSUPP;
+				}
+
+				scoped_guard(spinlock_irqsave, &fep->tmreg_lock)
+					/* Read current timestamp */
+					curr_time = timecounter_read(&fep->tc);
 			}
-			spin_lock_irqsave(&fep->tmreg_lock, flags);
-			/* Read current timestamp */
-			curr_time = timecounter_read(&fep->tc);
-			spin_unlock_irqrestore(&fep->tmreg_lock, flags);
-			mutex_unlock(&fep->ptp_clk_mutex);
 
 			/* Calculate time difference */
 			delta = fep->perout_stime - curr_time;
@@ -653,15 +630,13 @@ static void fec_time_keep(struct work_struct *work)
 {
 	struct delayed_work *dwork = to_delayed_work(work);
 	struct fec_enet_private *fep = container_of(dwork, struct fec_enet_private, time_keep);
-	unsigned long flags;
 
-	mutex_lock(&fep->ptp_clk_mutex);
-	if (fep->ptp_clk_on) {
-		spin_lock_irqsave(&fep->tmreg_lock, flags);
-		timecounter_read(&fep->tc);
-		spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+	scoped_guard(mutex, &fep->ptp_clk_mutex) {
+		if (fep->ptp_clk_on) {
+			scoped_guard(spinlock_irqsave, &fep->tmreg_lock)
+				timecounter_read(&fep->tc);
+		}
 	}
-	mutex_unlock(&fep->ptp_clk_mutex);
 
 	schedule_delayed_work(&fep->time_keep, HZ);
 }
-- 
2.34.1


