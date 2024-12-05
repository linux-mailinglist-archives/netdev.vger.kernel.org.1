Return-Path: <netdev+bounces-149424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 884B69E58FA
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 15:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7CB31882C82
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 14:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59F821C199;
	Thu,  5 Dec 2024 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bJSK1vsj"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A59E21C18D
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410547; cv=fail; b=jxXZn51scMx5E72uDHX0HA7yxz93//iRRnLs2QY29WlAGc6A2H3A8wbz+eJ0+8bEKKC9EAVE4sDMP7N51ZNnSeLq5j1tInBb7ASl27u+ZbT9X56MoLIN9Df+sVRERVhOwJaXoAbIqNl0y0JwIImVxIsTdbu6ccTIhTks3PAMqQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410547; c=relaxed/simple;
	bh=9CjP2YUL/DCuo6RTJF4tuxeGc0FiaGlbb6Dgpc34PRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FgHocmjoNRtkojz+QGyHchwWNBR26YU3Dp06hlWBxZzDPYm15cP0fIp8M8s2U5Luo5tEthFJGVN5GSPnfpp9Uzl+y+nSqBLwhdvERVtGwfZnFlitZNYIxaKbhRbI1SkwSKW+VoJFA9ydLVBahNV41HjosFpQKYN34FT3m7U/EDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bJSK1vsj; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuqiEowmU3rZeCo8I7tjhBhxrN8iNeZFdDoRk2TmhMlFes+cZPfRJuxibYuO5wlHmOM3oPZpDhoORgn6t0+7/NT7c4uijLUUjxXxaZCnuxrJT0h5NRHqTp02/y6tnAUu1Y5ffmGhcQ5p3tvdFqdZI6pfgKexwkSOVs78AbYun3DnVn18oMUWgKouPFgAkdZvvy81nMPc6KOCh0RNnwrMUnjMLKM4iukP+Vs4v2H19nF+07lW6i5P/L+uU/ssO3kTPPKwtcGPgjPKtvA5lFfmsKlANNOGoiNqxsDRXsadSLwRdl2MDCCFcsGE7N1SfdoD5r7G+VS0gB6/UiNUtRkXNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RIu6EzsfsW9e2/TiGgmXSEoa6r62GIPswR/YnwcFr8=;
 b=jA418kKt+TZlm/7WrhycdFWWqyYgrdsdeU5adVidk9/zJNzp/iU3DPaJ3vHteQpniqPTc1P7lkBsmbkJEH5yT59Dyu3jrLsmzfRfSn1tO4t23HmapmjtYWxf2RYhofbuSShrkMmFoQoqIe3UlLRCDwRBa0Lr4DCHglpILTHOnyF44TkGNMdYdTaZXJiNNI4ZOoYjK2Y7CerVTogvd2NBjwzceTnVNPT/V8gY9rkzeXhLtSChoPbA/qQ3TrlTnP+vCgvb+fy3HyvBQrtyfdbpfuwsb8yuv4Lwl34B0sPWk5AiYAmHpYIlnrBtltTEoLv+c/jNEnRGkBxqIcKlTKSlyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RIu6EzsfsW9e2/TiGgmXSEoa6r62GIPswR/YnwcFr8=;
 b=bJSK1vsjCSkMyfqg4p3sjQaJRPu5AgukoD7HPeOasPhmryZH6oZ3kH3EaIdYkyyF4KEDnnj2Fa14Uj2zKD/ua+69+nXbgf5HXT8BvFcgFKxTO0YZJckXTmf6sZ/iddT1sm6HH24Y7/9JYY/+FmXh4FnPE6iWqf6C0QqIT6tA4pPxE1iMNSY+Y8uNCb+0bGs/uHQZLYZHCeeGwzqI4Hxq8wCmQMh7rR/KfXmjdyK9cGN4mFD6WwS58Bid1v4hhri6SFrjOl/9WTWkoXTwg6YdNEOK/NZgxd/sZFhsYV1/04lcP5P2MkUcG6rnx2OE7HHegd7Kli1uaCNgd2MM39/qNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10443.eurprd04.prod.outlook.com (2603:10a6:102:450::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 14:55:34 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 14:55:34 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	Yangbo Lu <yangbo.lu@nxp.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v2 net 5/5] net: mscc: ocelot: perform error cleanup in ocelot_hwstamp_set()
Date: Thu,  5 Dec 2024 16:55:19 +0200
Message-ID: <20241205145519.1236778-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205145519.1236778-1-vladimir.oltean@nxp.com>
References: <20241205145519.1236778-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0118.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::47) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10443:EE_
X-MS-Office365-Filtering-Correlation-Id: ce1d1ebd-cef0-47c7-8c2c-08dd153cdf63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YF/mmgv7fqpWsBWMKwf0/+biZpI+9+u1BMl3rHeTkqLIJOmSWvQgW+PqFY9x?=
 =?us-ascii?Q?11dw0CbLPOfMremanAq3G3P0DBSXNiWsHytXIHXzKVQ32Tafint0XIeAJpLC?=
 =?us-ascii?Q?o5lcUq0cXcpUnC4NA8qd4GStJhLIf+sZcs4DIbd4xbR9U9nlu1LZIuZbukdc?=
 =?us-ascii?Q?WJv2LJ9NHA/YqFJUJjROdYhD5VvpTuPCxBVqPQ5PO+dzR/wieXO6aBuMLyf+?=
 =?us-ascii?Q?5HPpZ1xlZ3qGfRdWo31nIirTDsYVZwyjDq44eanGkqupVLtJKHnSs1Fb2jjS?=
 =?us-ascii?Q?bmnUuX2PrtfTI1PRXREUWI5t2/9yoMpHhG0NUmAFjYedlj6TLxDusAQf6whF?=
 =?us-ascii?Q?jJaJ0EauwvemQAjjLNKKd/DqAXPea6vgM4IPCzZ8ZsLqO8EO14QSvc7jFo+Y?=
 =?us-ascii?Q?DvfPSDWHziCJrAHXiXyVDrzLdHy7cKuTKUWbQ4rGdWeI2IMBuEWVpK2Nb7wa?=
 =?us-ascii?Q?RFIVSrNpIqZBJCNrgjBkJWcfKc9JSJ5bxZSpy23rhsqHaPwEfA8cAzWt9QaQ?=
 =?us-ascii?Q?JIvGzSjgJAick3fnUMBpcVExdRL1R1iLhsBhHfLMwePQdWEuON7JnjvepyWG?=
 =?us-ascii?Q?j0GuywC8dv/LhCPskcOx0xu5/WLjQb47GDDKebD63U+KeeGXFNY4eDBYC0bc?=
 =?us-ascii?Q?jbHLg8c8vrl8talzPYOa8oyrhRiaWdcHUinoro1Yb0v7wlzipmgpXiYhPNas?=
 =?us-ascii?Q?E87KiJqPK/lKxOTfJtWL9V6TPPhgxbP1Tj5LXZNLK2lr7jq/zxe2cEa+43fs?=
 =?us-ascii?Q?EX1p82JMEbcQr9IbeVmSDmxpRsmPCVsMHh6qZT6xuo9VlXhuRjawlfd8wNgs?=
 =?us-ascii?Q?GRExgdfCdYA7LS1BX8uUy76+W4B7u64/XSjM5UO6Gqsv7CsQUL+bUCM2JLrL?=
 =?us-ascii?Q?CgCkq2A6mmtLHyVA79wG8qU2M7LMMSfeQC4gfx/SGdtZAvHiUYYkmXi9giAV?=
 =?us-ascii?Q?a8IK/L+pYm76i1226tVZlXGIGk6dnLWgOFeV7xCHzASbt05+e3wBn/aEG3HA?=
 =?us-ascii?Q?iPD55a9cu2EUcRrrdx09KfSPAF6iSMQkHp0RRaiXLbv/JXhzNjE03dp88HG2?=
 =?us-ascii?Q?bL/qm/5rX+kndXsC4q737H87RLQd10NINOWRTaY/7E8+w++SOyV5Mj5j22hB?=
 =?us-ascii?Q?iMKK8W+vdfh4UwwmMxJn9hJkiq5xHEtfdybsFn0fO0rC8OmHrVIp35AfHSdd?=
 =?us-ascii?Q?aZ8F0PcRSoepa1EYUY/2e2tvT5KNT9q+YfagtCaKlZ3NKo8rwYFRcyNGeuZW?=
 =?us-ascii?Q?YlQToZ/72tKrNe7Avuhzh+Zyx7GPhF7FoQGRcEO4g27/senFMeWRnf4wE/ga?=
 =?us-ascii?Q?9Qm1WunYqfJOJArTkHsOZdGA2BB30oHQ6tcqITABpLmYIPaf+aduyUh159Ja?=
 =?us-ascii?Q?Aais4yHZgLs9OmTJYfC9XgU4I1X2dA7BNcgHlNzH/tW0IAz2Ew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ufTqthYS707YDFyOxsa/TE5zlpeswy4OvZXWnYj/K1mKbYj99WElS1CHPwJk?=
 =?us-ascii?Q?yI9MuwPOhnFt/yGX1TDFjeuU70V+uEGhMJBERDUN98zahkeoBzzUgq/PoSJg?=
 =?us-ascii?Q?xhoY8IyrPu4Fp9++bxp1N7kRbhHq9iDCACkmdXqeyyFBfTWgi53I2rzWuusQ?=
 =?us-ascii?Q?YGQ3SnRo2xseEz4Y6aR+SDhfplawNXpZ5bH8U7ZZb2e1Wga+3eZAvq2SElqO?=
 =?us-ascii?Q?DUOKief9tbLbYcJPSh8eq8QDL/Xec3whzufi5WU7l1WqAuzKh3Jf6tdgEdgN?=
 =?us-ascii?Q?efqwKmMppS4QX66SwmpiljjV+I80n8AEdpXwH7E2pNwypd6ZF4jfUZzRLlyp?=
 =?us-ascii?Q?ccm222hs3GRRpQxq6GWOPEV7wgsD5inVIq14RrkJsrTsLLx8QNMYEMzx7fPF?=
 =?us-ascii?Q?6CmkuBkLfeIlFjbNUCX9Q7uk2vvnCl/VXXiwmwNGRN+95eiLylvS4FlHSMFX?=
 =?us-ascii?Q?4ehTOdt41d3hFbe4bb/OW4E059/Wy+qtMtV0sppBpIv8HtxgJB9qI5e7ZG5a?=
 =?us-ascii?Q?ZFe/mO/vvHqo/5J3At/aWhtz0gwbd8SWP7dkCZF21oZbSdKeS6w/lfhqvSfw?=
 =?us-ascii?Q?9GY5ASpR0VE3WOPylBksYqTbOSOnSqRbvDKS3NeCfy5TcNBOZUMDdT+3DMmd?=
 =?us-ascii?Q?38Gwgwg+W4cA5GC7GihYIJts1qBaiEW2cpPcDaup+0mGm1EEXnbtcdHz2w1j?=
 =?us-ascii?Q?UPTzkD35UZlF54vlMZGFaBWWkp+DSnONIbbf4N2mVnUWouRFB1fXvzxOpmQj?=
 =?us-ascii?Q?ELExqxlfa5Uez0Eu5ZoIlexaDaY1urzmogyNbn2GZyVR+967Vm8QVpVOOsse?=
 =?us-ascii?Q?Gqf8JuERX3r36DNwWrEof+g0linZL81hd1NsGZlixWTOM3/vhLXwGzRoyHQW?=
 =?us-ascii?Q?LVOmAZivukCaiAkeK0qmifVa12Aq1Q9JLielxZIcYGlPAHQyXbVRWT9zNs6S?=
 =?us-ascii?Q?miuDsUmyiapjmMGPDv2/JM55OBlvg/RGysDanKnA1MjF8lSS0K1g9R/5imNF?=
 =?us-ascii?Q?qn/rNsqq9qEkTgyMzUb1HBWjSsEdvRRBifBxhyB9GrJWvcGPUNujnoThVOKP?=
 =?us-ascii?Q?lGu1SEWUB0TETWOkuEaaPDS0HV/MBTzr/xIlRoDlxYJTQTUMldpNgLinvu9A?=
 =?us-ascii?Q?UnAn+qNTMuRYBIBgSJs5FRCd0UAmXsaC/O50aegiHMayIaP3aHPc5UFa0/fW?=
 =?us-ascii?Q?nU+kDNwM7VXD7GrPMPqWRqQtZojKOXQdVzSCP97fvHs5pl8b9G+HCNAUZK7u?=
 =?us-ascii?Q?nH9wpdbqEKOTayjeOf+twwPkyRmq7gNfyurbByE+PtAJ667Srxj0+oizKVU1?=
 =?us-ascii?Q?YfG3uosgARjXiWeWc/vTT8F9b4JTuJeK4qD69Dui2st18IzoJIDMeSpNsDZG?=
 =?us-ascii?Q?a8DJnQCjDUOJvSwqCVNj+x8YsdnsPxMZMsjXqXghla7u32D9Vdx95wQxf98+?=
 =?us-ascii?Q?TZJj6oDRpXKXZL4v0LVgnAGosBy185oEIc+PlzKfzUoOioCVxFxK9nIG8K6l?=
 =?us-ascii?Q?qLjDSPNIJNP11tXH7/RcNMHx/y5E2Y+WLpZs8M2L4jZcluHbBxO1RDD5uD6G?=
 =?us-ascii?Q?ClZfYaxY7qfdzJDo+Qn41QDt4wxflx9WMGsvbUtmJc+EzXEXTuBE+oxnWwr8?=
 =?us-ascii?Q?Sw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1d1ebd-cef0-47c7-8c2c-08dd153cdf63
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 14:55:34.8729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QfahUaZAURzfddhzsWsjV1okOLyZb8SNGQexyPCXbauxqEa/w6JyULK9IAiiA0IVx9tyL6RkBQ+UikvyJsSnxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10443

An unsupported RX filter will leave the port with TX timestamping still
applied as per the new request, rather than the old setting. When
parsing the tx_type, don't apply it just yet, but delay that until after
we've parsed the rx_filter as well (and potentially returned -ERANGE for
that).

Similarly, copy_to_user() may fail, which is a rare occurrence, but
should still be treated by unwinding what was done.

Fixes: 96ca08c05838 ("net: mscc: ocelot: set up traps for PTP packets")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/mscc/ocelot_ptp.c | 59 ++++++++++++++++++--------
 1 file changed, 42 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_ptp.c b/drivers/net/ethernet/mscc/ocelot_ptp.c
index 7eb01d1e1ecd..808ce8e68d39 100644
--- a/drivers/net/ethernet/mscc/ocelot_ptp.c
+++ b/drivers/net/ethernet/mscc/ocelot_ptp.c
@@ -497,6 +497,28 @@ static int ocelot_traps_to_ptp_rx_filter(unsigned int proto)
 	return HWTSTAMP_FILTER_NONE;
 }
 
+static int ocelot_ptp_tx_type_to_cmd(int tx_type, int *ptp_cmd)
+{
+	switch (tx_type) {
+	case HWTSTAMP_TX_ON:
+		*ptp_cmd = IFH_REW_OP_TWO_STEP_PTP;
+		break;
+	case HWTSTAMP_TX_ONESTEP_SYNC:
+		/* IFH_REW_OP_ONE_STEP_PTP updates the correctionField,
+		 * what we need to update is the originTimestamp.
+		 */
+		*ptp_cmd = IFH_REW_OP_ORIGIN_PTP;
+		break;
+	case HWTSTAMP_TX_OFF:
+		*ptp_cmd = 0;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
 int ocelot_hwstamp_get(struct ocelot *ocelot, int port, struct ifreq *ifr)
 {
 	struct ocelot_port *ocelot_port = ocelot->ports[port];
@@ -523,30 +545,19 @@ EXPORT_SYMBOL(ocelot_hwstamp_get);
 int ocelot_hwstamp_set(struct ocelot *ocelot, int port, struct ifreq *ifr)
 {
 	struct ocelot_port *ocelot_port = ocelot->ports[port];
+	int ptp_cmd, old_ptp_cmd = ocelot_port->ptp_cmd;
 	bool l2 = false, l4 = false;
 	struct hwtstamp_config cfg;
+	bool old_l2, old_l4;
 	int err;
 
 	if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
 		return -EFAULT;
 
 	/* Tx type sanity check */
-	switch (cfg.tx_type) {
-	case HWTSTAMP_TX_ON:
-		ocelot_port->ptp_cmd = IFH_REW_OP_TWO_STEP_PTP;
-		break;
-	case HWTSTAMP_TX_ONESTEP_SYNC:
-		/* IFH_REW_OP_ONE_STEP_PTP updates the correctional field, we
-		 * need to update the origin time.
-		 */
-		ocelot_port->ptp_cmd = IFH_REW_OP_ORIGIN_PTP;
-		break;
-	case HWTSTAMP_TX_OFF:
-		ocelot_port->ptp_cmd = 0;
-		break;
-	default:
-		return -ERANGE;
-	}
+	err = ocelot_ptp_tx_type_to_cmd(cfg.tx_type, &ptp_cmd);
+	if (err)
+		return err;
 
 	switch (cfg.rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
@@ -571,13 +582,27 @@ int ocelot_hwstamp_set(struct ocelot *ocelot, int port, struct ifreq *ifr)
 		return -ERANGE;
 	}
 
+	old_l2 = ocelot_port->trap_proto & OCELOT_PROTO_PTP_L2;
+	old_l4 = ocelot_port->trap_proto & OCELOT_PROTO_PTP_L4;
+
 	err = ocelot_setup_ptp_traps(ocelot, port, l2, l4);
 	if (err)
 		return err;
 
+	ocelot_port->ptp_cmd = ptp_cmd;
+
 	cfg.rx_filter = ocelot_traps_to_ptp_rx_filter(ocelot_port->trap_proto);
 
-	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
+	if (copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg))) {
+		err = -EFAULT;
+		goto out_restore_ptp_traps;
+	}
+
+	return 0;
+out_restore_ptp_traps:
+	ocelot_setup_ptp_traps(ocelot, port, old_l2, old_l4);
+	ocelot_port->ptp_cmd = old_ptp_cmd;
+	return err;
 }
 EXPORT_SYMBOL(ocelot_hwstamp_set);
 
-- 
2.43.0


