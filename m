Return-Path: <netdev+bounces-217131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D4DB37785
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 04:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 069754E06F3
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 02:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7B41E1DE7;
	Wed, 27 Aug 2025 02:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qAYkQVPd"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012066.outbound.protection.outlook.com [52.101.126.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B0D14AD0D;
	Wed, 27 Aug 2025 02:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756260494; cv=fail; b=mvOOifZHun5oJDx73Ntwo8Zr1ib4NIqOyoWcyiYmQ78asYV2R3xjHX2r0d2J8n33JBIClqjrHbGQSkPzOZtW2sBzH2WMHxLzcHn7W9dE56IxG4zIHei/NnwhYMjLmMTw6AErQc/wMx9DcLGxgXXcT1GMDxvCs8UOnHbB9NRdSQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756260494; c=relaxed/simple;
	bh=l8ET86Lpo8/fWI5hG9bOKER00zZPSGPXZpQ3sZFmLpY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dn26g/ev/PoIyKvfIzOy9/pWSprPt+3JJwMkPn1CRh2tSqO1cntNtuj06QBGMI5aNJKEljRjXukdu5LDkGDBFzqlmbfKylrrREylFF7SOXYSVBffIoGIlawBl8Tn31Lp0FjhHzX/o7dbA0AAJu5xmQ1JkybHTHVpXMBaTOHV3IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qAYkQVPd; arc=fail smtp.client-ip=52.101.126.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZIB0N5fm8pTZW16kal2Vy1Mw5b7XNsCAap5d7QSGciyTz6dwDRd8XO4+507Q6BAihmuWxAxzXXTMzeafyHIZTfYM86Z5DpDpOziPA+jLThGxTyqnJi71miTtQ03czJPzHXwV5JWi9V3ziRMrVuhYxZFwFVotopmy/Z8+pLA/s8qCs9W7/HLFD/At2iHt6pOk+uSa3zS5ysJvmeawyERz5Sma4PIAUymbZC8lXhKkZgtxQhV24gSHs4240faI/2WxO2f82ZneJ6DUFOAVKXEK/iUDUH372+l/5KPcLsJ/xOVHn2InhRN9NrhQZ2+q+ku37WTjtnO2MoKF3itwMw8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGMBnrIoqKceYGziwNDhdphtIYjX4L8O7MXyE4sSyD4=;
 b=UtIvPsHQMiUk0cP3mu+gfP8oeC0heEJHFNC95l2/IjFV/s5HgKD9eVUqFgrEHXZGAMOA579nxEkQPTu8PyXxFh9idXFfDmzwb8oLS8AQhOWEKq4Skw4Xxrh5G68evTwq4FMaYULRGxgl8POFUSs2RnZNcWk1hWLIWOBIJM3QlxW4jM+cLLn/9N+N9wEG1Q6yCfKWn6JMY0jR+fnbrCPbHoInk86qzg+fKU3hMDn6RyLUqZ1NfFU/mrv/01dw549/p3lEHosKCpciIXxAYzCHMUow2V2aZV9XbUrY93XfScZrsYOL/T7Rbbi/USUWnBT5joieAoNLaHMGn+DxTqOlhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGMBnrIoqKceYGziwNDhdphtIYjX4L8O7MXyE4sSyD4=;
 b=qAYkQVPdOJbwr19YXvTvHKXZ7pPIAB6rVOyBoADcAUM92KrTKBjJoLdprCIkthXoyM3PCVS5PnJAWBhRIBeDTJq3LJ+LoI+0nSCc3Vheyz7Q/CB10t7AUCI6cB56p4mmLm/Z9hjJktOVb9Qt3hOQPmnYW6HCknr9W7dpl9SHZwAXsaxFDNNn6ci3GnmMhsiTfeahgRLyhAATc2X0MtI05iGj3XP5Z72gCvzAxYKJAX0N49fcWlguhC2dKwstj6uZ38eNYKZwRJOgZUUr4N7z8DsyWO27lUyEmi30LLRpbn0BPm9VNSrslSQ0bddkj3hoqsatAWcKEV1ZA4Z0/Rs0pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYSPR06MB7157.apcprd06.prod.outlook.com (2603:1096:405:8b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 02:08:08 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 02:08:08 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] net: stmmac: use us_to_ktime() where appropriate
Date: Wed, 27 Aug 2025 10:07:55 +0800
Message-Id: <20250827020755.59665-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::8) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYSPR06MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: d62b9ac5-dd3a-49cf-c792-08dde50e90a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z+ALfUj5J0frGalqfclRpb8IbYKCLu+BgD01z21IUxGeMzCwX9S2eMHS6KS9?=
 =?us-ascii?Q?VKDKnGSRZKGeYOOY6iaO4cQ6HFiBzZlLzz8zU3Lu6Eci9czvgJUIWgsf0ITB?=
 =?us-ascii?Q?4fHTromEv5eMZhE1DB2F31voiikodGrlyx5b5UV37QKbnCYutjgZxDNJ+dxb?=
 =?us-ascii?Q?1jCyUmWpBS9hMhiCpzVqJCxl8J5RvZRgzu6UR0qIAlwAgO3V/RA/tHjm//CR?=
 =?us-ascii?Q?uIrpGqn2eQcPxHs1nzg8gt2O68sf4PyuI4z37jxfDiUUXkOVcoXg18v+8mgU?=
 =?us-ascii?Q?QToKTcadT47RDzCx1OUKFhJ+vhMrk4IggWuY+GsWezf5u8eNQjVSnLLiEIr1?=
 =?us-ascii?Q?mOJcwGcecqDQcKVb1jj88OexW5qRl1UhQ01qKipULn1MgbVMK+vsrRUjv1hq?=
 =?us-ascii?Q?E/q7+yPYh0CCifToAVGzdH/VZ1bbRQ9vQYK/kSi0O1vH3ZhZVqkec3fGQCC2?=
 =?us-ascii?Q?eD6qXggYaE10Wcph3ht//X9VJE3tXnVV5dR0xKW+ZnOqsm2CTBZaBj6vZhW+?=
 =?us-ascii?Q?qaG+H6xXtMZg0IxslNZG7naLvm3QDc+gt67AWs3K8KAPZ0ZtOeJfdTVKTLKd?=
 =?us-ascii?Q?eZHklKR+8lPkn+G+kPseOoAhhRoP7gmabms63rU79rmWk3pION1K5cuCCca6?=
 =?us-ascii?Q?MgViXM/HgghPa/eNza8G9PN4xN73hj36PEPDhQ23u4r76su4hDKVjvke9mop?=
 =?us-ascii?Q?NfNq90QiNlGt3GyKp1sy4VIUeIEtLBOndR6p9lIWW35UhOR38XZru5JLn9cf?=
 =?us-ascii?Q?qhynlnUcMhFoSUlYAbFcJgQzhP/+N7l/ECebrjMGH/TjHRatOZPh3fiW1ASB?=
 =?us-ascii?Q?DlXdnOF1MkN4dujJ8Lt1249ins3FUELL1fiBmS5p67KRkV7CUJ+G3/foTYYg?=
 =?us-ascii?Q?dl1yKYpup1SKcxEK47knP3VR6FL6rsI0/eeMMFa+9mR7rgIiLET75uyySjrL?=
 =?us-ascii?Q?pV/VeptxultUKu4bECtOe4tE1Ou8V5dCdGo15P0F/syOSkpJcJXUpoaUkInN?=
 =?us-ascii?Q?H+Y/3O9IEjiYx39csOZA5TF2HHN+E6bojxsrz9uWmApU1TC2VpWj748yKnPa?=
 =?us-ascii?Q?IhsuZh9pu2VISBT923zzPlW6+fDCNpMjLQhSjoyGRVh8qIvYmi0ztVziIwQb?=
 =?us-ascii?Q?RWpKtikok/xCjXJb/Wmv7hD/uNIxGqbFjLlE5zIfyzc+4w6OoexZSOhyLlrM?=
 =?us-ascii?Q?0ORbFnYXSJbn3wxMsdnh60/5mHWL39NrU4P+I4TBE3q7kO6K2Lyud9Tytm32?=
 =?us-ascii?Q?eejXnPZplbbJD8jC1ZV79z7isgfvhF6uxTxT16JSpWfCacpG2hXcQ9nCPxxB?=
 =?us-ascii?Q?OvZ/9hfEC+hqyVnj2pWn24pjOhKiTbbcNB8yi/UEKSR6psMCxDZj6iss/kLm?=
 =?us-ascii?Q?SeRw7wppycv9kZgDyUU5tn8sp/4MpS8rTTuXvxc0iogN6hZ6c6Mjbh6xPW5R?=
 =?us-ascii?Q?xyIQJDlnKU20hm07MWLgHKP0Eny+9FJJstIDbKcPvpG7Rz0CAb3jBg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hPuHB9xRuXdOyamcT+w3F4jquswPqULZLCRxn5S+AvSS6MTV9tc7zX15EtWd?=
 =?us-ascii?Q?lk+EWXPAae+0l4WyN4IofboI6TR8LjDIWHZk4JtRw0Y/Bi+FaQbr8boSnudW?=
 =?us-ascii?Q?oG8LJPxvft+2FH+QvpLIAS9xe+cQy+toE4LHadAr6f2kDtMygxLMShJixOPt?=
 =?us-ascii?Q?LX2kDb6M1DcGnc284N9//7tGkUGzNVTUWmT1cDxNRYidWccChLl6KkrVeiGH?=
 =?us-ascii?Q?kl1nMnU81r206vd4NQe+L6jQh+GKKpYivFfx5CgYdwz/YyReMy17tpbAqsRq?=
 =?us-ascii?Q?rjKTwZ1NTMmeCrvbtU+H7fZtlVZMG8a6BqFchWnfIvnC/0xocSGQ5/eBnq1m?=
 =?us-ascii?Q?s0ayNry9tM4JERNAeBX+bO1jT+mokxKYTuJrwusmSDA3l78omsRTofAH4Vwd?=
 =?us-ascii?Q?m4KuM6WOhamlf0bQMeHtfBd4YCGJ+xjJcKjAgioW2t3ZZvMHwStfPn7SJWTk?=
 =?us-ascii?Q?lmLw4dixENxAjjvQWXKXuizq0ox4bVp+jDOGlMKiTOk1GiOK4oNtVGPnG7Qn?=
 =?us-ascii?Q?6YLnQEphfiEjkIab8Z60Yq3P5nxkJpjk472UqLSybptS0UV5Ss2U51QZ4q93?=
 =?us-ascii?Q?vwqdrOZ4/ToQOVDYedtzExU5ltpumnd+q7w/DCuNSBeVs9HFcWZCNCnxpjpD?=
 =?us-ascii?Q?HIiV3BZYeMmyPxtIaL8Q+tMwKEqctXpNAiiBdB8CmiKoew42R6xuK1ng5s/E?=
 =?us-ascii?Q?59Xbst8zG78vhBhiLCTP+75Ugtasu3CFwTvjWx3Q+/syI2SvfPI/n3EVffMH?=
 =?us-ascii?Q?LbzWHc/lW/htLG3hHOHx6QeXR7zFnjW5A8jsDYWaMuOpTz9/xE0Sr8AVidUA?=
 =?us-ascii?Q?UK15yLcl/LOP//3mc1xwkB2bjVRWciquULI39sPR7GlAqgw0VI38j4H0YgNr?=
 =?us-ascii?Q?4WDrJFa8ZN2h51oxj0FtWiAriHE0/RB/VgZBa63luDhZCwJLdsczvBEiHUOO?=
 =?us-ascii?Q?ZPsp7/nhnD8jLYlwth8inUKQbS5Dm4+di8uEdlgO+YU4ZReKO8FGYZfaRAMG?=
 =?us-ascii?Q?+GeTiOfqQhot5ErfQe5md6Q8oCw4QqZcDw3UZB+crvuY3NFN24AolDvCREil?=
 =?us-ascii?Q?wbxbdzNH1tBiR10Wmaj6IpbxCg7iVIXSNOnl6Is6L/J+bP8diQKs6ajtjK97?=
 =?us-ascii?Q?CUT7J95JzygP+YgwOyUKm5j9/J6odV5twVGviZP24Dte6amszGSZul3Sy1jS?=
 =?us-ascii?Q?UiWxY0L5fw2Ycz5/vb2OtlO0FZK9crdch+OQBwlr6wyt2lt7fZECE9Mz/KtL?=
 =?us-ascii?Q?r9YGLBz3NtYF+h1JWdIK590d2bRSQLqXY2mo8m1pKbIlulcZeCUX3QpGBvZh?=
 =?us-ascii?Q?8lMTPR7Q+cl2hyQ4xfWR30vupPWeOBoC9pr2sUFgAbOfJGkk+0kYkOmn1k7B?=
 =?us-ascii?Q?8W2vgYmpsEgcsbK8bLucutdyEsKaYiMqX9872FNO2J3crwWNob5cCHPOGLxF?=
 =?us-ascii?Q?LNUl4zYEi2odaU+SgsgM/H+KfN/g/yGGaMQkT1mzHQDZZdYoTnw7nqLamab+?=
 =?us-ascii?Q?edbeK8Hm21/wBaxNMZuiXBdcbxUB6zP+Z5Udmq+1hcgYnG38Gws7BVySr/SQ?=
 =?us-ascii?Q?q0l/L2jC4dL8P+2Qv7n1w0fU5xchFeyW3k1WRo4z?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d62b9ac5-dd3a-49cf-c792-08dde50e90a7
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 02:08:07.8884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2c8+L3g3LC5UN2XGIwfXIbHEffFhmviw3LKzkHTYw7cYWoydn/q6OMSD6rDCIhwL13Uyh0H/gl2WO54ZypyqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7157

STMMAC_COAL_TIMER(x) is more suitable for using the us_to_ktime().
This can make the code more concise and enhance readability.
Therefore, replace ns_to_ktime() with us_to_ktime().

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f1abf4242cd2..dcbd180c1985 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -144,7 +144,7 @@ static void stmmac_init_fs(struct net_device *dev);
 static void stmmac_exit_fs(struct net_device *dev);
 #endif
 
-#define STMMAC_COAL_TIMER(x) (ns_to_ktime((x) * NSEC_PER_USEC))
+#define STMMAC_COAL_TIMER(x) (us_to_ktime(x))
 
 int stmmac_bus_clks_config(struct stmmac_priv *priv, bool enabled)
 {
-- 
2.34.1


