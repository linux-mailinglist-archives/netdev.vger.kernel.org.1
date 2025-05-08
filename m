Return-Path: <netdev+bounces-188971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC56AAFA6B
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E051BC64FB
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 12:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2A922B8B1;
	Thu,  8 May 2025 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iEYqB+vY"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51152165E7;
	Thu,  8 May 2025 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746708527; cv=fail; b=H6WCdaVPI8RbRsmrVDlB4Vi6BCgt6AvK/yAuFDD6AnH3AJTY1yG837d/hJn6w0WSk1xuypgbUpsJsoRPtw1WNmn5SF6jYXtBQUqJroE2fDgkWn/iRNOWCp3lMcFhdZyXHtWbNxxqA2/o3sW5tOd8ldRoRd3PfHb93XtNSovlhg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746708527; c=relaxed/simple;
	bh=yWNtKqH6vxHvwty8mB7OXmjfHL1KrA+wPADs/++60Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q2aDzLFYHlVTJzVtPwkFdB+gHf/J1tBZBex8HsTc+EIttqz6La7gOOwSI98x0E5tKLJQpjotO3e5wde9ukUrjJGO2UB7aBJoCWVCsQSlJwloXymIXxy4XPDPTy+vay+WhwWoHvFLGrb39A7AybNsrZ3GbDs5IBwDd7SfypFS4gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iEYqB+vY; arc=fail smtp.client-ip=40.107.22.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTnGNY4R0NwvKIvj64HykqMLBKb96Cfo4PUjFWnH3hkG24I00kFfsB1zfHOdJ0pQI9lPmxoY/szQeuO4t02umCyvm52XenBNq/YVy3iodtKmmThqPS89jmxjJIqDaV4IaP9hptMnk/R8HzmCc9tuDHJ/JoLqGRP5uuYtjLRK8jYoRWj3vP0OfFx2Dmj9J0MVVBX/zKocJemgTYr3+OUm+OTfQe4FnZm1e5xe9jL2M3p5loDsmjkNqRgoG44pXZJa61NPTvOKWzYRPpTmyjfaYzB0lZw80DFHYjc8usbT5W/hJFak0Qoz4EY9l7hvPFz/G3mz9oxVAKHEGs2pvieo5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eka+vaopp+3xUs6GTcDz1hd2PSBtRbEZ3mjG/wTg+CM=;
 b=Ksp9OyQRipaDqkixcploBspBGavdZK07UVJPU09a4Xy1qIxUjPZSr7lApr1YC2i+JHRzcXnRUtJIYMXO0fEXMzgpaIIHiigsMZhaQrpCWNApWCNCexyGB2SLciMXE1my70vtGpnpfkCMn7FTwwd76AMA7hIK2BkzokLpcWL6583jsUG9FWw5yh9gydKxO4IfCSctq2ZBwmNIMTfff4TkDQlFxKxPou13AEw5NGzoYhzlDIhfTQQxEGGlI04bepyVl6gJvoImSxUMv2aPasDDMtMk3xsg37O4vJ0ooLz6TRlXi4GavNjgNZVBakHInmxS9b1nHuToy2KwkBdSSksRQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eka+vaopp+3xUs6GTcDz1hd2PSBtRbEZ3mjG/wTg+CM=;
 b=iEYqB+vYqWh2Mae+VxxSwmHqvHDZ4NHArRo/fHh+5/rdBOjHrlIMsfG6xHFXC90UASZc2lahVSzJn9hfuQkZxXoef+2sdxVKUtAwBDS1OgmFnsL6PbtuTLm5RX8N2LTJSa+AHHiuzzcad5fb+2mSBLA0Vl4V2Zc4Gk054f2JJxbHamRy85j1Mo4LsmvXNn0f1w94orzcUdBJvcUdxnPD+gndGsYXv6iRsvHb6rphEErorVF0uXtL01JhcJqkjbQyOj5cWhPxk3aXyR/sSnloeF+z2t7/7NvMLbh+tPsJgMbTIk+6uQvI6VnDoMC+quy54SZaiAF8ulwAhrfzyG+3lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10398.eurprd04.prod.outlook.com (2603:10a6:102:44d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 12:48:39 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 12:48:39 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/3] net: dpaa_eth: simplify dpaa_ioctl()
Date: Thu,  8 May 2025 15:47:53 +0300
Message-ID: <20250508124753.1492742-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508124753.1492742-1-vladimir.oltean@nxp.com>
References: <20250508124753.1492742-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0157.eurprd07.prod.outlook.com
 (2603:10a6:802:16::44) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10398:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b27f07-14b2-4cf5-5828-08dd8e2ea7f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ky72mGuVHhQgENmObpDmVkdb7QRX+uKx1gy12F9WVrw4aQwJC5TRTxx2Vail?=
 =?us-ascii?Q?J1suuO97Pf7E024BPCRgUgn9kT29liOdIYF29IjoFpgF9Q2D6hMxKzSa2JQm?=
 =?us-ascii?Q?bKskC+HDVePui70aI8j2HP797EPJPQnbfWPNniBiaZTvsbhDw2XbJiaMZ+9T?=
 =?us-ascii?Q?oUxsFC9h8OlYfBUV64JudMPBZFTVnZVCRYTKUNLelcGt2L3kdG0YJ/P1ZfVU?=
 =?us-ascii?Q?h3ccmErY7Ui3vJr1Ho1Fgs8diiSK78JVdI11BJS22OT67RngdKOBYCenSn1B?=
 =?us-ascii?Q?BnDzqhwrrkg4VNgCcstCh1Eujpfy1uQHz5ui+Z06mFnWkg2brQ/QqZYmZvAX?=
 =?us-ascii?Q?w8DkngdnyOtdIdNxb1/ggXZJNW5sGQlVun+2f0fq1Ol6GXIgGeoTFH3p1MrL?=
 =?us-ascii?Q?YIcYWF2gHMRfbNoLZja3V/KCs4dCor+AQxZgnQRqIhlH1Wrrq3Xsex4girsK?=
 =?us-ascii?Q?76rAn9odRkqcv/0slwqGCs9xv3mNOGJa9QBhiycIffXVL5b1nh9pXteae3bw?=
 =?us-ascii?Q?wlyrpK3ele/BKAp11ETfsZc0e209fOvOV/fUDLIilE2RMDjfw4e+CmXBSi+c?=
 =?us-ascii?Q?hBn+7mVsNz6UwSZi27rZ7M5HZB2o44zFGQyEVYswwK1mkU+2Anf/XhZYSIiA?=
 =?us-ascii?Q?QTNBAqu0auWcssupAu55vPwElVv75vt+t3ANAvKn4mlhOsR6weB5bg3HcKoh?=
 =?us-ascii?Q?H0XNpQCv+vHoHWnG6t1ZEqYuPjjp1rZzYfIe3N9y5GLMA2XWxnH/75uzZbOW?=
 =?us-ascii?Q?yiOTh+/ErZrNBJYkCAjjur1pPoLEiHUnp/vYWVLD1UH3D9lh0HgvctSUJjfZ?=
 =?us-ascii?Q?hP0gPcf5yc/G7YQbgEMxwTuugdafjKxhN3+Fl7cFU4dWzEuTzffX4f4Xok6Z?=
 =?us-ascii?Q?xgXvm/ZXlUQqHeztWk6cMu3D4gAvkfLkFOLRDiNPe10vZJ4gxfKvrINVSQo4?=
 =?us-ascii?Q?6kmotevcJii2WNt23Inp8DOvO0xWGvrC2PbXVp0Ht+EmT+vfAC93yf0A2p0x?=
 =?us-ascii?Q?EbbjpaMM935c0dcaHWVDV22zwvAn9BpwqBKqgcSFwK0E2kxRSdG6I+xBIfAl?=
 =?us-ascii?Q?XS+zoqiU1vTuoicoJ5T2xcK3HKDlXQ31Ny050bNkn6pRMXwlI4H50jeDzhRL?=
 =?us-ascii?Q?KC/lh0oJ8DbNMGGRkRapoVs2BgsSKH/aSrViK8R/5rPycrAumjAGbLuYpOMA?=
 =?us-ascii?Q?N4MrNonkklwFJWGBEl/kT+Y91s3TGoxDrtKbTsA0bmR0u35PUyRg61TW1JW7?=
 =?us-ascii?Q?lkSfMlqtRi+EIZiBzVdKMVuRV8rl4qbn/kVmAnJOgmRHBN3izM0pZIWgSJR6?=
 =?us-ascii?Q?y3CfkkuxVrdbdWr+Zp2dFXLiQBgC5VDZzU70BNyIUGzrWr/QI54kPgk97iF4?=
 =?us-ascii?Q?Sdfs1pW4mk0YS11mRBczLQFMcCaSjma9dxD4wzPl0bJYusLNGqDIs0upDSyJ?=
 =?us-ascii?Q?8K/HWb8UUEIANSdQm3IVqh6AOvD/HPuF4Jb9/0JFHCdj5DUZJdLG0Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uxUhFrBOOzSQ0Frwg7taFDhjX4W3/osRv6IwsXq5Kgy1L2gsaTC+LvlDhex2?=
 =?us-ascii?Q?WWhyKaarIOZQ/8zsLgZYLApjhkiXcIviqNz8Z1jGk7vd0JhxiWew4G3/gohv?=
 =?us-ascii?Q?J0eLwQZPn8g+68ypB0hcUVYYgD2bKYVgEU+H/wDxELU2y3W3Of4jTcv/+884?=
 =?us-ascii?Q?K8ZA5YaEIK5jP1IODpV5OU9XtmpjBzyKMpxdG4bv8FPDuYXDOQCFlloVMg93?=
 =?us-ascii?Q?d7Jrzl+ZlkkQzyPnWuNePNja8MIyCvlcyI25motxHg7j4r0gSkgM39YICm3o?=
 =?us-ascii?Q?sPupiwoygrGVqkJJa3E2uU5JXOzniOjRzwHQh8QF9FIGm/bk6WmTmpEJvmmK?=
 =?us-ascii?Q?L9ikvAj/uiAU6+j7fF0UY44y5BhCIm7TmkFb1JWAODLYg4rnxN4ZFx0G57kx?=
 =?us-ascii?Q?npAY8lvfgh8amF0zfMyR4F9ryn+npxRETVeOwqfEk9PPZ9NWYy/561KiVUB0?=
 =?us-ascii?Q?41Z/99fMX/kt/uJcPJQ4A5PxAvd2Ol55dxnAXDW9fmsykMsEJZP21EJPFQCT?=
 =?us-ascii?Q?6Pq2FhRueQAOAQCDtIZBFirKf78olbuahPbkG+TnhbCz4Sg8K1nn9cPQYeGw?=
 =?us-ascii?Q?g/XFRvIGXP2YeqjEStY7dCT3EEFrGhduOMQiizxRlffq0J5qhkVMLZ+1GdMk?=
 =?us-ascii?Q?/GwlvvrcUK9oTA+RkRv6Fd6H7K4hSATg4sIgr0FDmhW+cyhqdYotUbfXrKhC?=
 =?us-ascii?Q?K1xikg3M75ROOlGVBchyQpg3FCvy5X8IfrvL5ek9qfX6Dg4UjvvzPhxlxtJb?=
 =?us-ascii?Q?tjlqZXVoOWwPnJmAFL65Zi8uzjFdj5kyIwXT9CfsnxZLF/EQsn8U0thd1dSG?=
 =?us-ascii?Q?vVgDOSCITlQYfNYNxGNOAabiwns9nR6ANb1bmLkQtBLqJDe0u9hUrAagTwq3?=
 =?us-ascii?Q?ZXDrwbKRHZdfrVY4KP6YwvIaLxre4orjU8EJYzGZnl94zbe5vwvhBYnhLaws?=
 =?us-ascii?Q?AlCIcRo+MhIgQwqXmwdKpwq1AkPMSyT7FtXSCDRkvdU43kT4SgmWG+24KopX?=
 =?us-ascii?Q?3wQaCxby65twLZnGUIZIAxLAwT4LtSQ8jGVcjJlt/nCefdBTGLFwLfPcfJRM?=
 =?us-ascii?Q?J9SBIyBEvMaf82xAGn7PxtaHjTxsh3biwF5gZNscv1SSRJxuemoRrCj29RdZ?=
 =?us-ascii?Q?B8eZG2kWflZHY7QswD3d+nfC5XEmKiBJeriUTw6lT3db/GX6uZ9sVe6oF0Z2?=
 =?us-ascii?Q?4ZlZCTDAUQpifdG9Sum3olgAf/M16zIR0A6FeFHvTYjxmVtr5LrmdUn5Y38c?=
 =?us-ascii?Q?yHl9wAeqd9cDO1wpkjAQhzuIv5UOhoMtTaABGADkCqwllFJLv1DnSi4dtnAR?=
 =?us-ascii?Q?Z4vQAJnTy7nuxpi/eVmxlSh2AHHT3PYdgIPxYhhiGDixSckcoy2g9QLM0Ao5?=
 =?us-ascii?Q?xU+/l5SxpmCXfQTK8j/MsOQJAYaXyfCztKo+QynW5/1UHm/fFDDk/PzzaPwH?=
 =?us-ascii?Q?iBfBOVpVEuNbNTsZAcoLD9rBAk/Uvod1AaDu1KTghi+B7ND4PWMF0eK0SpZj?=
 =?us-ascii?Q?n9xXaxOYS9MUKR5u7Yszx7fWrcxCxrZXAeAFb39rDkVHrUVb7XAl719Da9eO?=
 =?us-ascii?Q?dE7dQkdochRYdeQ8Q46o9kbIdYYyu8z7l1E2CFg1BiK0xNlKbWKE2ZxOp1yf?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b27f07-14b2-4cf5-5828-08dd8e2ea7f8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 12:48:39.6358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVlx4+Iw9XbshRQrFrWy540RFLFQjVs2tHM9IcQvLu7lrxk7zVLSa6+UcH/qwzMVN7oHinFkBqcPw55yfqq3zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10398

phylink_mii_ioctl() handles multiple ioctls in addition to just
SIOCGMIIREG: SIOCGMIIPHY, SIOCSMIIREG. Don't filter these out.

Also, phylink can handle the case where net_dev->phydev is NULL (like
optical SFP module, fixed-link). Be like other drivers and let phylink
do so without any driver-side call filtering.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 5b8d87a0bf82..23c23cca2620 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -3139,16 +3139,9 @@ static int dpaa_hwtstamp_set(struct net_device *dev,
 
 static int dpaa_ioctl(struct net_device *net_dev, struct ifreq *rq, int cmd)
 {
-	int ret = -EINVAL;
 	struct dpaa_priv *priv = netdev_priv(net_dev);
 
-	if (cmd == SIOCGMIIREG) {
-		if (net_dev->phydev)
-			return phylink_mii_ioctl(priv->mac_dev->phylink, rq,
-						 cmd);
-	}
-
-	return ret;
+	return phylink_mii_ioctl(priv->mac_dev->phylink, rq, cmd);
 }
 
 static const struct net_device_ops dpaa_ops = {
-- 
2.43.0


