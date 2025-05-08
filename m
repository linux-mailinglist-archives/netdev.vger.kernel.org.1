Return-Path: <netdev+bounces-189083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6345AB053B
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 23:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5199525D88
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 21:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEC4220F28;
	Thu,  8 May 2025 21:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IeIdzCu8"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5E31F582E;
	Thu,  8 May 2025 21:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746738722; cv=fail; b=jA+rVkaZLyl9JkAxV5Ob7M+5H/6F/cBOGIz4kA79eEQLbdBhjJYxHpz/GlOQBeZQmhJ78LBa7bzKOzAT31BgA2QMajdJ5c8r52E7ba/F/DYcnAmZikFnkUm8arsn5Y2qE19jcMOB13hBHWBFGO4/Uy95r0fB58tplkOOaOqiEBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746738722; c=relaxed/simple;
	bh=CJMs2HNOU6qXS0L5Bjps655J3/NtGYE/ZTgONsbXI6w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PzIrLLnKb2RzkVW/xTlyFFpw+51XgMBlUeBry2NTMJsvaCMagp2HzTUvbKmj80rVGwtXKJtwy02Fu/caEX/rvfC9LuMdFQ70db3XGGy6aw6PTVxqueIe+cCRDxExiJUPrKGIyr4pJa6pr4LjG9kQ/xdMUWtqdsoGA61Gtn+DVXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IeIdzCu8; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mg9pfbBdhtANJzN0vz7VdfiwqhGDESz0jyp1+RhFfaE22W8L+XTiV2bP+bzz+XppIa9uHM67kUjUdGXCPOZBK54LjrvrQ+uMqgLwcZoDXZFfdUIW1kHzL5WUXiWpFS5TPIOKsN6kFuAMFgfHcWGW43hKMYqIany9h1/hOvONL7IOwJf9EF4LjcWF3uijPA73UytpkCsEM9BDzOwYncHqBBxO5UOzPVd4UmBnDEozPd/A7as1v9fipg99MyNIr3p0oUuBSMikRlTb40j7wZHi42arpg5FI1BvONWEgmVxsZt5r1/wUFU8F9+Q2rA+Ak4ZnDxTJXopqEsLo9+A5XjQjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBjGmcV+MlGYesFK/GTfipvbjJvmq4ZEcuBEOEvPX4I=;
 b=x7sVbGtnw0r0ff+LCTvpVmP9ELJ5lJIic2LqIwHsjDoWp+ZoenBovqkeFPglNZLrTLsPf1nAt/c8JsrvPZdyH5bMRej/0pTAO3ZViexHIZsWHhU0quyHhevEtg8YByeRkAlqepUueuib0onpV6/CQZF8zMSkHvbVmWIOyl51R+eXWlj3mkgsIOMkoJpx/9sD1iIEVTQavjllidDANp9zOPljlzvT6eXVfwssSTNZ9h/rnaYQSk63qBlmiiSZLYCb0jAsIrqU6GY7MILg7kQLYtrzEWEySsG29zIWpG/96n2f6gJB3hWweRgU8AfJ5Yn//8uotIVLA5X2eZHLkwHP/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBjGmcV+MlGYesFK/GTfipvbjJvmq4ZEcuBEOEvPX4I=;
 b=IeIdzCu8hOf1pZPxa1jf6jQoxyvsHi9gwTwjRdLkquPG3akzB2mvuu2lnJ3Zx9MOuNPbd5ygd8cRaRBPi3UWRhqcoIHg2ygtkjdpkUPzO5cEnab2EtNKDJ6nT6dUUgRypW8pDf5QwzZSr8u7wJnkXOrMClLzvSf8CkqHiZSncqmuyCJted3S1NclEWXlb5dQOTKZKXn8XDROAT5j0sZgFowL13QZCHk/ZIoHtZI8fBkmBHhCbJ5V9hnXSbVE9PEuDe0A86iHhj4RpdIQI8+aMrDikxnicuEXvF5r/8PsnhtnlS/YX55ycsDtNHXIeV8nS30HUpiBFQoWxK0DzBn/Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAXPR04MB8272.eurprd04.prod.outlook.com (2603:10a6:102:1c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 21:11:56 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 21:11:56 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Linus Walleij <linusw@kernel.org>,
	Imre Kaloz <kaloz@openwrt.org>,
	linux-arm-kernel@lists.infradead.org,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: ixp4xx_eth: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Fri,  9 May 2025 00:10:42 +0300
Message-ID: <20250508211043.3388702-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0175.eurprd09.prod.outlook.com
 (2603:10a6:800:120::29) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAXPR04MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 99689093-7da0-40b6-7881-08dd8e74f694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HlrJVE1nsyEtrk5XleCPWd5LfwV9bOk6DE+OWmLwyxoWu9DLvPpdZp+xhrwI?=
 =?us-ascii?Q?RM/lsM/b2FR4fdp2CG3OmL26IVAxqhElq5k3eF/1uwnN+pX4IRU2LS4gv1+X?=
 =?us-ascii?Q?nZcDtnK65hJxKrlEmEatrxd7u3CLAOhT8tUQBuI4O44niAwue0md60q/eSYK?=
 =?us-ascii?Q?xSlX+W1WiwssgkkIk3dZibRyKTffk41B/5Hw0DUsqdjgDVm9et9o5T4CMrjn?=
 =?us-ascii?Q?0enqob96TmUukWjgGDA7fjn5WjQ4C/B27WOdmoDfv8dwV+lkfmngEeIQPw6g?=
 =?us-ascii?Q?ax6RD+21fjGYbG9TuzUqcc7cBtA0LN1+NSSjZeaxWkPJNjU6FSbDL6gOkpn0?=
 =?us-ascii?Q?ar/a1cT2ldXsezH9rDB+/qNrR/deNNzAevx0zjnAb07T07pLDlumPfmghTaU?=
 =?us-ascii?Q?AqO+wieLGey772p0wOO6LvALC22kSerioaAs9I5/iBNXzgxjPPbcH/RFbT5A?=
 =?us-ascii?Q?+/g7s+1zkrkTT+ybUFXzpUrEx/lxmB1WWPrvG6l6GUZX2HfRhT+17VROX9M0?=
 =?us-ascii?Q?GSb3NLZydBp4DoZ1MTlVMteomLMpVm/wLezr9sBCQkop5lPNJsZjGX0paxRU?=
 =?us-ascii?Q?5HvL17wnD8+658/wR1G+l2PPjWP6S5zNIWyVidiy4j885uR2jH5lo/7W/4Gl?=
 =?us-ascii?Q?3byVnR8DYUc/w2zLiU7YDLlHWQtcMH3TMkGxk+9WiIx+hZdmMLx6O/k/olWk?=
 =?us-ascii?Q?ozdxZqviI6mWdf/6OZPJQdFJN1OsQfZJkiKHLiQ6FOgs/RPXduMqMmt8Qcjs?=
 =?us-ascii?Q?iem16xQjzxZ0LVoY/Eneq7BwIIDDVabtOtuHe1BC6bG+p9ctTJXovQ7K3FPr?=
 =?us-ascii?Q?K89mmwEQHPhwpVseB66QPxJKlnimliuUeqoN5ye5b8mRmZ3pmJzZRBkYatIV?=
 =?us-ascii?Q?mIU+zGVl+rnc1Taummi6eZH44jI0268vx9qNMjPu3FYfPaVOveiENd/ebVM8?=
 =?us-ascii?Q?60UVmUSUqlFF7n7atuJosEubWZ1kTTm6CNbedoVP5pfm/Cg/6NZPm5qOxUoY?=
 =?us-ascii?Q?LapA19B24W7Vpn0T0ZBG/kjFb7TluLEIrqF8209cUwbPBci74n9RW6QkCPzW?=
 =?us-ascii?Q?NQpCEDnlmNysDYLrKomxcsx91lENGztweZxd1humju50iJ9BfEtq/3doc55h?=
 =?us-ascii?Q?5pfhjpRHkRTfJ6EiyrUYODhUdQTz/lnIPn2VMkqOOofLJqn/0MBrifn8b4q0?=
 =?us-ascii?Q?8KuShOyOAn7Pr6s/D0aqKC12dzMnQiPqSxpybeghkWUkn++dvsUa4M6YnrFY?=
 =?us-ascii?Q?4tzvf12bxbpf+B3ituPbpZVl5nbgGhuWe3pwDlCeuWcs6qPeRmWvG7bCtkur?=
 =?us-ascii?Q?iOtTmyNonHPPwtCHhUmJu63+NheFuozLfGN4qd42ePEmMBEO+n1nxIiRJE7S?=
 =?us-ascii?Q?GLxBCvUN3XQTQgYd7SyYHEXNepJxVcaWncwrv+h8PEduu+ZxiSOLNjyyq5Br?=
 =?us-ascii?Q?KRMqO8/8YE8xVY7h+XTZT7t5Y6SgeuammVZx7o0zute1s6Lgh35v4Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wPu/3TLqDZ5Jd0sELUUZ5cdrC91GzQ2xeNmLLoewmt+zRCT3rQhKY3djH3cz?=
 =?us-ascii?Q?NuV+wlpun04Z3sqptzJE9En4yvai5fJVJwxKmmt/4+RAo4dYoMQ14W8RhnFQ?=
 =?us-ascii?Q?8wabm2Nz6TTmn0dE+E0ErzFJcK5VcIVgXQ+1j+zIwn1c8SdmEB8g+3zW5ymS?=
 =?us-ascii?Q?1t+mS+9An9Rxd7EgZJErGHV4+3d+nbavOBZxLDBh3RC46IjMMFao2vr27Ylm?=
 =?us-ascii?Q?SVTehuG74eDZJlCbQGh6izWh6bmNsNNIPy4zYeme2olUQJxnpgwHzoQgHb0X?=
 =?us-ascii?Q?M1Uc+U1DQLAMAaGv9AUz8kw/5QnL42Jw7WxC062nDCiQYE6tPG04pVyLy73l?=
 =?us-ascii?Q?Iiqps+T1U1+DglxXVtjcJPEEBlqUcEViE9/mhuSlddN/S9dVkXJR0uhzfRYP?=
 =?us-ascii?Q?u/C6fbVdRwt7dm3M+E8wCNljOFhERU0n5GFaCgwRe0v0VGAgc4E6Ci/i/fbc?=
 =?us-ascii?Q?euHUUWD7VWOUSkDgNOcimB2tkjcnt1KMot61MTYLkTQ5PsP39/cXy+SW4ch5?=
 =?us-ascii?Q?L+friiiSLpFw7G+J8jW+z1BRwO8Kaf1GNl9Y5S63vcOJeePlV1GZQZKGpPeQ?=
 =?us-ascii?Q?xW839YrXfN0qeGLsMApemHSJKzqjzHdGSGd6FhaJ87s4AtTFVxx/PGZZDL0+?=
 =?us-ascii?Q?jNnK23Ubt7+g8LEZ3A7r3InGdHFPMVrYLKQIg2B3DplUK6I+Bg47ZMf7jaET?=
 =?us-ascii?Q?w9h6CQgvViMFOQGE+n8gggxLodh4vtI8SxEdA0jqLoETeJuYjGh5Ws8mbN1r?=
 =?us-ascii?Q?qgvI+PGJGc8kDYu8yydjzWI1BoyeXezAn/SC7WrwNbLv4eDrsSfPLVDOaJ1Q?=
 =?us-ascii?Q?5zkcXaF/Ehq1Od/HwJ6OJKkXpbsot+eqvtKWn8bSVlTFwKwWDpfQ0g46gxfZ?=
 =?us-ascii?Q?BW84Tz8ujJhfVcuou4s7haxkAMHIXLucUHAd8KlMACwLeGRLLuaMkM/1qn0u?=
 =?us-ascii?Q?Vhx/vO170m5D8GTkMEyGExzXN+fmfGqfRfi1ohRrwLpDkCc6oQ9aXf7N0RbP?=
 =?us-ascii?Q?vfiom/2ub/9R0D5pLy8Pu2R/3KsU1E7Rp0myCQEgaUCdeqeHNcSRreMoCDte?=
 =?us-ascii?Q?+dDbn/h15BTtvocMtNpsM/WB3dYrd1z4A6hyVhO951X784cMV9uz3YgmkzYA?=
 =?us-ascii?Q?//aGKgnzlRzWCZo5yQ/upjbkL0MWKbiYRsBVVOxU5GDg4qpnXpttTP2NlJFD?=
 =?us-ascii?Q?ZmdVNBI8rwJyV+NmPuTb29zqKUfIdDgNvlnWF6pj7dQ+s5Kjff3c7safIcFX?=
 =?us-ascii?Q?bAOkM0OaGEyQp2mzPruBNZs2gOtWVOuRSNEmQj8fRw/NmPcxhCQPd7ZeFGDy?=
 =?us-ascii?Q?1RWPiR50p6lzY860zONekgmaxE2ftot8TjG83P4ysw9Sadje25sPm2pM/yeN?=
 =?us-ascii?Q?jJsz4br0XMIP0DJPSjcpOpo2h4Pi8STK77lHcVFbzBSvDlUdmr7Z5ntFuvDE?=
 =?us-ascii?Q?yd4ApX1mfpauxCr1tsz4rAHB/xlv0OKw+6haVTMC9hILiHoHtHnDQHNWgS9S?=
 =?us-ascii?Q?qBGaMKPL21Up5LwlJt7uxh6ZdfEaru1xRZfRfcKNqU1fsKPXD+my+KXlaLRE?=
 =?us-ascii?Q?FAddlhSAA+ypekRqy1t6gm9WP7X9su3Jcv2H8THgHGpKUkZOsSorBG/ZLSK8?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99689093-7da0-40b6-7881-08dd8e74f694
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 21:11:56.2028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVJ4P5/8zB6CD8AAZNDOR9svl2K6AGd9LeMyz/9O3IAf2RIeBw43twxWfZk6OanVa0rLzbiipmSKEmnhqABsoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8272

New timestamping API was introduced in commit 66f7223039c0 ("net: add
NDOs for configuring hardware timestamping") from kernel v6.6. It is
time to convert the intel ixp4xx ethernet driver to the new API, so that
the ndo_eth_ioctl() path can be removed completely.

hwtstamp_get() and hwtstamp_set() are only called if netif_running()
when the code path is engaged through the legacy ioctl. As I don't
want to make an unnecessary functional change which I can't test,
preserve that restriction when going through the new operations.

When cpu_is_ixp46x() is false, the execution of SIOCGHWTSTAMP and
SIOCSHWTSTAMP falls through to phy_mii_ioctl(), which may process it in
case of a timestamping PHY, or may return -EOPNOTSUPP. In the new API,
the core handles timestamping PHYs directly and does not call the netdev
driver, so just return -EOPNOTSUPP directly for equivalent logic.

A gratuitous change I chose to do anyway is prefixing hwtstamp_get() and
hwtstamp_set() with the driver name, ipx4xx. This reflects modern coding
sensibilities, and we are touching the involved lines anyway.

The remainder of eth_ioctl() is exactly equivalent to
phy_do_ioctl_running(), so use that.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/xscale/ixp4xx_eth.c | 61 +++++++++++-------------
 1 file changed, 29 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
index a2ab1c150822..e1e7f65553e7 100644
--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -394,16 +394,20 @@ static void ixp_tx_timestamp(struct port *port, struct sk_buff *skb)
 	__raw_writel(TX_SNAPSHOT_LOCKED, &regs->channel[ch].ch_event);
 }
 
-static int hwtstamp_set(struct net_device *netdev, struct ifreq *ifr)
+static int ixp4xx_hwtstamp_set(struct net_device *netdev,
+			       struct kernel_hwtstamp_config *cfg,
+			       struct netlink_ext_ack *extack)
 {
-	struct hwtstamp_config cfg;
 	struct ixp46x_ts_regs *regs;
 	struct port *port = netdev_priv(netdev);
 	int ret;
 	int ch;
 
-	if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
-		return -EFAULT;
+	if (!cpu_is_ixp46x())
+		return -EOPNOTSUPP;
+
+	if (!netif_running(netdev))
+		return -EINVAL;
 
 	ret = ixp46x_ptp_find(&port->timesync_regs, &port->phc_index);
 	if (ret)
@@ -412,10 +416,10 @@ static int hwtstamp_set(struct net_device *netdev, struct ifreq *ifr)
 	ch = PORT2CHANNEL(port);
 	regs = port->timesync_regs;
 
-	if (cfg.tx_type != HWTSTAMP_TX_OFF && cfg.tx_type != HWTSTAMP_TX_ON)
+	if (cfg->tx_type != HWTSTAMP_TX_OFF && cfg->tx_type != HWTSTAMP_TX_ON)
 		return -ERANGE;
 
-	switch (cfg.rx_filter) {
+	switch (cfg->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		port->hwts_rx_en = 0;
 		break;
@@ -431,39 +435,45 @@ static int hwtstamp_set(struct net_device *netdev, struct ifreq *ifr)
 		return -ERANGE;
 	}
 
-	port->hwts_tx_en = cfg.tx_type == HWTSTAMP_TX_ON;
+	port->hwts_tx_en = cfg->tx_type == HWTSTAMP_TX_ON;
 
 	/* Clear out any old time stamps. */
 	__raw_writel(TX_SNAPSHOT_LOCKED | RX_SNAPSHOT_LOCKED,
 		     &regs->channel[ch].ch_event);
 
-	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
+	return 0;
 }
 
-static int hwtstamp_get(struct net_device *netdev, struct ifreq *ifr)
+static int ixp4xx_hwtstamp_get(struct net_device *netdev,
+			       struct kernel_hwtstamp_config *cfg)
 {
-	struct hwtstamp_config cfg;
 	struct port *port = netdev_priv(netdev);
 
-	cfg.flags = 0;
-	cfg.tx_type = port->hwts_tx_en ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
+	if (!cpu_is_ixp46x())
+		return -EOPNOTSUPP;
+
+	if (!netif_running(netdev))
+		return -EINVAL;
+
+	cfg->flags = 0;
+	cfg->tx_type = port->hwts_tx_en ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
 
 	switch (port->hwts_rx_en) {
 	case 0:
-		cfg.rx_filter = HWTSTAMP_FILTER_NONE;
+		cfg->rx_filter = HWTSTAMP_FILTER_NONE;
 		break;
 	case PTP_SLAVE_MODE:
-		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_SYNC;
+		cfg->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_SYNC;
 		break;
 	case PTP_MASTER_MODE:
-		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ;
+		cfg->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ;
 		break;
 	default:
 		WARN_ON_ONCE(1);
 		return -ERANGE;
 	}
 
-	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
+	return 0;
 }
 
 static int ixp4xx_mdio_cmd(struct mii_bus *bus, int phy_id, int location,
@@ -985,21 +995,6 @@ static void eth_set_mcast_list(struct net_device *dev)
 }
 
 
-static int eth_ioctl(struct net_device *dev, struct ifreq *req, int cmd)
-{
-	if (!netif_running(dev))
-		return -EINVAL;
-
-	if (cpu_is_ixp46x()) {
-		if (cmd == SIOCSHWTSTAMP)
-			return hwtstamp_set(dev, req);
-		if (cmd == SIOCGHWTSTAMP)
-			return hwtstamp_get(dev, req);
-	}
-
-	return phy_mii_ioctl(dev->phydev, req, cmd);
-}
-
 /* ethtool support */
 
 static void ixp4xx_get_drvinfo(struct net_device *dev,
@@ -1433,9 +1428,11 @@ static const struct net_device_ops ixp4xx_netdev_ops = {
 	.ndo_change_mtu = ixp4xx_eth_change_mtu,
 	.ndo_start_xmit = eth_xmit,
 	.ndo_set_rx_mode = eth_set_mcast_list,
-	.ndo_eth_ioctl = eth_ioctl,
+	.ndo_eth_ioctl = phy_do_ioctl_running,
 	.ndo_set_mac_address = eth_mac_addr,
 	.ndo_validate_addr = eth_validate_addr,
+	.ndo_hwtstamp_get = ixp4xx_hwtstamp_get,
+	.ndo_hwtstamp_set = ixp4xx_hwtstamp_set,
 };
 
 static struct eth_plat_info *ixp4xx_of_get_platdata(struct device *dev)
-- 
2.43.0


