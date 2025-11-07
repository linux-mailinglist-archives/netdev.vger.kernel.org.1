Return-Path: <netdev+bounces-236751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D08B3C3FA86
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 12:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AD6B4F3287
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 11:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F13931B81C;
	Fri,  7 Nov 2025 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AMsWQQYk"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013019.outbound.protection.outlook.com [52.101.83.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD1932142A
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513728; cv=fail; b=twmAHAhIhK2Q4JRy0z9UYvb8M1/3X8D8Jw1zCtKhFaZHRh51hff9q+EOl7DyJXkbnwLAsE+EQEh3Vaa/2+GMa76d57fejVfg9DXdnbkCHiRhL/O0xvsgJ7aF3YB6uagLpYKl9bFv+Nr6rqwF3M4Th/E0Smv08T16/D35SgYTpK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513728; c=relaxed/simple;
	bh=IvmGROdT6Bbe34OhOuZ0rzNPv+GHdDHunmAYEAfkDaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QAKh4irYocHv7NfLjxBtNjdkzC0rEJNpVLBK1JJeVhLu8t0fbgzKNEXW4db5Twi7iU7z5bxkP5UpljcrnoH8yDx8AY2acvVtUE5nful4v9TThgeXAl2AlzIOLblxABselkCu/AP0cVFwGbzsCVZnxf64p3k/T9egAdWRDUBLIGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AMsWQQYk; arc=fail smtp.client-ip=52.101.83.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+NtA7mOWl9TtxDclttodNegEtg5Uqc4NspIKdimzGCAN+kTBXEmQSgjgK6xbnA/y3pcIdSxA+gKQAw8rftuTZy5CTek0Ihf01S2cnOviyYhOvV+M4oftoNKNv61kI5E5T3HTYWWZQ4svPoNQzBWO08dR/n6BV+W9TkHYAn6t9QpqEkH6QoU55SO+yfirsymkmwbl66xoRhhFgKkYZSGd8xWzOPhNa1vuhXmEJKJq/9hYZ/G8N5BHoCmcf8mmwIDFw0uY24Na52g9geNlU0BbU3F+uhEFVzWboC1jOUk+T9xqsT/JIPrGkq5FjqbGvxPGmtM0yZmtmHHPMUpHrOlQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6l8I7L84Dr9JWsS/0k86XpOfJnwO2iUu9yxZjqxwBBE=;
 b=EEiwAdZa96PgjTC5z83Z0xrH37vvUSKoNLiEY7gliKkG+E7VVhiV6Ff4jBfNAius72+ZhORAw7gWEO67j/g3nmXIbGfvNY0MAeItIpNIOHRUckrJTqhCbDtcBhb5gB6XiRanL56vYtHTmbBa2QKmfuiMFiu0/pIY+QGw9FzlFa39mc/YeZYOADEYirbd+9UfS4Sd+semUiPxtQCmGquBkHQx/7I4yaQXhY2B0AUUcekwgOscymCC3bba41QmCo6IQAU4DUIkTqduyPc72OEfradurGX4bqeqEqJvh7sJs+WClrkQmDpaVysRFuiqhWPR+5XqoZWQ/l46ge6Xh0DEpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6l8I7L84Dr9JWsS/0k86XpOfJnwO2iUu9yxZjqxwBBE=;
 b=AMsWQQYkHMcX4FgSfGbwOEkVzdTuce+Mk/ZyKCIGHM26naQbVyEoXGyzA8+CzTkDomPMCCEMxr2wCSLqr77HxFsNRrMj8NSizIgs5ITYbk05IwoFn0fjNQvYh+1MugLBr8giNdWa57jmfYyFAi/3h4RF2rGusdyUo9A8KY5Ax2fAWngyvke4JUJpTfKINnSJfl5r3NP4MkSGkaZDe49r1SkMBLwOPNErjOFTeZ+mtbG4DJ1bKAY5IWhmtCTyov4WfnvtVETuPDJbij14+Cqr8OY+in8YgVLgAFdZTlXitMs+W1489rg1YQjdQwb3zhlPpaudFJOU5Y4p3s3ZN2fQ/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS4PR04MB9505.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 11:08:37 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 11:08:37 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH v2 net-next 5/6] net: phy: realtek: eliminate priv->phycr1 variable
Date: Fri,  7 Nov 2025 13:08:16 +0200
Message-Id: <20251107110817.324389-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107110817.324389-1-vladimir.oltean@nxp.com>
References: <20251107110817.324389-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::13) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS4PR04MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: ab151b98-d7d0-4e92-3f8d-08de1dee0008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|52116014|376014|19092799006|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7NTZvYBd1nzRPgGmBV8NaKvezqlJ+L+h74LhMvCXQ7ohmYVq1Zy8QHLjEvka?=
 =?us-ascii?Q?jf7ZyKUdnq868keupjFa0AeOWeCvDTzn9Pa7SonrCAWfZzHkFq2UtJGIXPA1?=
 =?us-ascii?Q?mSI6gurnb7N0Bj3T8VtCgHvIEmne/mnq/T/VjNLj5A6hHW/FTKt2+KKJJHCI?=
 =?us-ascii?Q?FriRXEDz4jYvi+lZy10KSFDOHCGk1TSc1Zq9HATUeoqWMTF6lS4lctlXENMl?=
 =?us-ascii?Q?mWj6/0kHE6H5RHwMDjE0VUdGKiMcLsk++Fwvir6bWQ8FFqxQ4ppEWzPusIRq?=
 =?us-ascii?Q?il9yxPcdHbhBSFothHpYyu4GoSj50onyyLTG7q76uvTM7tw+rIz7k4o0T3HI?=
 =?us-ascii?Q?tOYNIPut7j1FXmbHuAMvYdMgaD/ANX9O16gNPMbkSf21aO0N1k4lBuMSOaHg?=
 =?us-ascii?Q?eeVElO2L+iSNa6iyxYpw6xA8KZplYy59N9TqJhbzEh7hGjct5r3QoUAtI4Xz?=
 =?us-ascii?Q?kK8suP++UfXBGCjX2LyguG6aUQg72JSdTHyZl9oPQHB87jFbkdusTHve5mHF?=
 =?us-ascii?Q?PxqEjQ2chgOJ9rOyN5rA1TPgmPKSO2Fra62Tp+n68qTxmnkggK4VjMAoIg8A?=
 =?us-ascii?Q?Qp0YmwffLpW9V4pQyG3uB6jhxOi4CfJLwoTW0H4ktuYAPUtmaXh4TTfwZsnv?=
 =?us-ascii?Q?TJaPdqo5rWFKttxG3N0I2B3m0r9xrtm7x2B8omby+mgv0qX99L+dsSf3JAOz?=
 =?us-ascii?Q?tlB3JRcPPfvajuSDiRIeoVxpeqCvkewW43QC3bi3XBOU2ix63aZaKMtYLypb?=
 =?us-ascii?Q?wMCmGFb50KYv5M3qeXIZts+n/OaHb8ZXWy9dQMuPfROywaXc/DJ6HHqi6na9?=
 =?us-ascii?Q?Q4L6UURyAcJcGesk6QUDPL+pxJnHkvCqeJ8b64TavizR8g7Dw52840NyiGVK?=
 =?us-ascii?Q?SDTIK5idxYO7BDbLzycyUQMRlalVi2u2jnJhkfjxkAOXKUbUwhHP+sqSC3kJ?=
 =?us-ascii?Q?kcsAr+NAHUk/utzqWxlYDj8fzrbxlOxcbCB6PlFDomeeC17ptd9jps2ATOol?=
 =?us-ascii?Q?3nejS20tuor8Q2DbwT42uPv0IGRjTOT9jYPQCriwLzJ7O0WOqbmRBjSid38u?=
 =?us-ascii?Q?wkWqBQUh0CGc1DtQsfLrqTDiSbskJtfp/6kSZT4oUPsdl9fwS7jXTCMEjJA4?=
 =?us-ascii?Q?dBxSp4mAZ7sIEIRc/7sVjlvqaOzKvoMcEtLwobqlsqT4jsugshvc37DO12kn?=
 =?us-ascii?Q?tY5ezwbVxukmh9elNDlgI65UyfwdKeKAJqkyo20kQI8r2TkxwidlDdDSPTxu?=
 =?us-ascii?Q?hUO1lA1OXu105N8ykzV/jkc1YVBPHmtjG3TIbopz6fCEnMqrut9gJmCesk4M?=
 =?us-ascii?Q?cGbHKAugY7qeVh/adqnzHdyvjRqCumDgU1LzZVfMC5THRSsqACvfx7yUmRCQ?=
 =?us-ascii?Q?8UjtEdJiWNHGgSSKllcr/rBP48AFondSEgR84tTcsz61UilaTMnasJdGchVf?=
 =?us-ascii?Q?jXY56DqrjEsdZcYWIBg7ckCFyLtni4LR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(52116014)(376014)(19092799006)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sYEYnQl4cZTbto3hedZLAmRgqAog+WKK1gOurgGa6T8DxRYOQoPAMvYCFFDc?=
 =?us-ascii?Q?18Jh4f+L0YNHF1xVgYmf/LaisM+9S3WFYq7q2qSEOE97EJebfbtFBXlcSRaD?=
 =?us-ascii?Q?rA0VytWj3nZCQO1Q08JYDjbUQ/4a6habwmauKL7GUAovv24rCv7vIFlEiT8O?=
 =?us-ascii?Q?L0QvU0tJ3oV/yD4qRPjh6g3o73Ap2kSaNN6yhRJpBqrJ0knu3pT1tcORRDdS?=
 =?us-ascii?Q?rPgUV8jxlXos2DRFtvODhJBUdOkYiX3SMaDnJx6vWdI+b4hQ8sAa9Tz3OfzP?=
 =?us-ascii?Q?J0BdFopZauPTavPnbf8A3fEfZ07/a21bh+1VfdQ8eD8urQyOwzEnLxc1ufE5?=
 =?us-ascii?Q?7kLAw3Tc23OaV+kItumy2yewBdL8ZXJC87+E2Wy92HZUvtiOMH3whlyftd3z?=
 =?us-ascii?Q?GEqrrfdOhpLgf/PNAnsK4SZNyFpkDxYLuktzCRyk39iFPkuE66NsBT9MReT/?=
 =?us-ascii?Q?ds8O226kkgCiqrEiK6xlr+nfz+elD2Lq8Gk0izD1ukaTtxMXvaps9kSq5wrl?=
 =?us-ascii?Q?AOK1F4GTwoY/RgF+2DgrzAlqSWd3LvhET53vR6DjlTeHJ+ERCVoDwb7FOPT3?=
 =?us-ascii?Q?JW2fLK6s5wEdAfp3qxG+T7ebwUM+ViU7Ka+XFpRjpz5yjg3EBjHdQWZI87js?=
 =?us-ascii?Q?rQJKsC6k5YWFS5RKOr6jhXUlh1Jh8/fXVZ8I31ox9N2/zsEgvfHHAzEVC59p?=
 =?us-ascii?Q?RsC819CqcxLeQwppsbEwpThmvPLDP/lssesO3JMlzH9oucpIZi2tm1Rv3X4k?=
 =?us-ascii?Q?F74lpEgqbQPvqRITClU99U6yl4WSLqUmnox+VoS4pzkuByDQSWYVEFSTP+zx?=
 =?us-ascii?Q?wpdQ4TRpZp/gAe647CJ46YR5JKViXNYbwxqcQEFSSkFwEGTgpHno/xRfhtEu?=
 =?us-ascii?Q?MpuIA/qRjf4YBZ8S9rBV1Gk2Ek+lhQX/sTNb9weqfUL/ZW9BLqeGjkPf5DkM?=
 =?us-ascii?Q?nN5WnX/bGMPDSSNvJBwKr/KN9+37QjUmyEpGjc5+0TyjmLmDczWaMZh1j+ay?=
 =?us-ascii?Q?JnBOR1WW/M8U21DXv9AGtrRQGX8Br9LyfiLgwr+IWdTWp0t4s7mjJUdt3/gK?=
 =?us-ascii?Q?2vHJIS/m0Rrs6NBhQMZuWdMrFF/2ZjUocEizR+PUXk71CJbNN7kBOR88ooDF?=
 =?us-ascii?Q?9Q//uUCRic94HfuLY3JTBQaC3eCApaQ6YjEsCqBmip3F8qGzXxD23jT+h5aj?=
 =?us-ascii?Q?LmVGm9Ds/fcU2PktDYQhX0nLqXtKO9MA+woD+l0l2651xC2vdUm0P7UC61ex?=
 =?us-ascii?Q?KPRuAdGHgSR4LSJ8GJjm28EBcYkuWbL2mdEsYlXdzY9YfUACZpBRR9wJi/JS?=
 =?us-ascii?Q?nTIn9GC3m+2jjbKC/aiKuhXa/KDWKb2zoR/oo4hAPdePwJwfYFyktHkMj0C/?=
 =?us-ascii?Q?adzuoFPMs3OL//z2BxmHWe1eo8bHtbxh09H6Idtv1KbHVqTbaWwyJGeuxFgJ?=
 =?us-ascii?Q?9GqD4ZHfHpAqyHcllr/EIOejV4yWW/6voHx4Uop4QCRUGwtfoMi4p9UYgHUu?=
 =?us-ascii?Q?sSZZc99hM+s0la+LezDxY1hCJ6/nF8JT6cxF6KtnE82r+Fw0VjP16CAEl6uE?=
 =?us-ascii?Q?pc51nBMNwd8Gxn6qN8Ib7z9fpdRMuGh+UeVqaaoODuDRzU9HH/I6VAQ21sE6?=
 =?us-ascii?Q?XI5DNQ8C0dyKFGNXSxHOERU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab151b98-d7d0-4e92-3f8d-08de1dee0008
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 11:08:37.6592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NAEn57kfVSXjNRtjg0n4pKO0A4rXz8L82UfbZjyFCkGGAaZYFv6T1zDub+9EwIZ+X0ERZy8JXzH6CU2pwGncrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9505

Previous changes have replaced the machine-level priv->phycr2 with a
high-level priv->disable_clk_out. This created a discrepancy with
priv->phycr1 which is resolved here, for uniformity.

One advantage of this new implementation is that we don't read
priv->phycr1 in rtl821x_probe() if we're never going to modify it.

We never test the positive return code from phy_modify_mmd_changed(), so
we could just as well use phy_modify_mmd().

I took the ALDPS feature description from commit d90db36a9e74 ("net:
phy: realtek: add dt property to enable ALDPS mode") and transformed it
into a function comment - the feature is sufficiently non-obvious to
deserve that.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: patch is new

 drivers/net/phy/realtek/realtek_main.c | 44 ++++++++++++++++----------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index dc2b0fcf13b2..4501b8923aad 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -201,7 +201,7 @@ MODULE_AUTHOR("Johnson Leung");
 MODULE_LICENSE("GPL");
 
 struct rtl821x_priv {
-	u16 phycr1;
+	bool enable_aldps;
 	bool disable_clk_out;
 	struct clk *clk;
 	/* rtl8211f */
@@ -252,7 +252,6 @@ static int rtl821x_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
 	struct rtl821x_priv *priv;
-	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -263,14 +262,8 @@ static int rtl821x_probe(struct phy_device *phydev)
 		return dev_err_probe(dev, PTR_ERR(priv->clk),
 				     "failed to get phy clock\n");
 
-	ret = phy_read_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR1);
-	if (ret < 0)
-		return ret;
-
-	priv->phycr1 = ret & (RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF);
-	if (of_property_read_bool(dev->of_node, "realtek,aldps-enable"))
-		priv->phycr1 |= RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF;
-
+	priv->enable_aldps = of_property_read_bool(dev->of_node,
+						   "realtek,aldps-enable");
 	priv->disable_clk_out = of_property_read_bool(dev->of_node,
 						      "realtek,clkout-disable");
 
@@ -669,17 +662,36 @@ static int rtl8211f_config_clk_out(struct phy_device *phydev)
 				RTL8211F_PHYCR2, RTL8211F_CLKOUT_EN, 0);
 }
 
-static int rtl8211f_config_init(struct phy_device *phydev)
+/* Advance Link Down Power Saving (ALDPS) mode changes crystal/clock behaviour,
+ * which causes the RXC clock signal to stop for tens to hundreds of
+ * milliseconds.
+ *
+ * Some MACs need the RXC clock to support their internal RX logic, so ALDPS is
+ * only enabled based on an opt-in device tree property.
+ */
+static int rtl8211f_config_aldps(struct phy_device *phydev)
 {
 	struct rtl821x_priv *priv = phydev->priv;
+	u16 mask = RTL8211F_ALDPS_PLL_OFF |
+		   RTL8211F_ALDPS_ENABLE |
+		   RTL8211F_ALDPS_XTAL_OFF;
+
+	/* The value is preserved if the device tree property is absent */
+	if (!priv->enable_aldps)
+		return 0;
+
+	return phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR1,
+				mask, mask);
+}
+
+static int rtl8211f_config_init(struct phy_device *phydev)
+{
 	struct device *dev = &phydev->mdio.dev;
 	int ret;
 
-	ret = phy_modify_paged_changed(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR1,
-				       RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF,
-				       priv->phycr1);
-	if (ret < 0) {
-		dev_err(dev, "aldps mode  configuration failed: %pe\n",
+	ret = rtl8211f_config_aldps(phydev);
+	if (ret) {
+		dev_err(dev, "aldps mode configuration failed: %pe\n",
 			ERR_PTR(ret));
 		return ret;
 	}
-- 
2.34.1


