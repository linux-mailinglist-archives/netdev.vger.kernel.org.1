Return-Path: <netdev+bounces-219579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C91B42096
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4DC37B4580
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C9530146B;
	Wed,  3 Sep 2025 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I9ZWf2Kq"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013051.outbound.protection.outlook.com [40.107.159.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EFE3009F8;
	Wed,  3 Sep 2025 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904883; cv=fail; b=Sd3/rsiqo79o6KHiOkjhc5uEZxBahJSIDXkdnf+sd2ltgyqiK45baJAtGiCSydn4hgxQAVoU1koemX+JdRJ3cVZCwZlXn1MTizgHY3icOf3nunrNIkZ2j6SrcKqhc24goqExy17w0/dV3+jmD5OeX95adf7EJ/kwtko4I9b7pP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904883; c=relaxed/simple;
	bh=oLyVzgUEkGvuEVIjuz2iHqNY4MQDSO3ZlkJduBHaTvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=doPTYE+vIuB7EnWiP46vcN7T1kyNoqgk2OJi85pPEKup/r+nPdDgzYNgyir8RqP4gQohsLOwnv+pFAOoXeQZI76NLIEq5dAqqQmiR47k/uKEA63FnIWI+IK/Ye2AS8BMNAwjhfRzbX/zY01pt8xH5QWwts3PwFRoewffg+yqm/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I9ZWf2Kq; arc=fail smtp.client-ip=40.107.159.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQu8rpxaiKsoI8Ol3iq3gf5kS3/4c2o+Amw7d/MgaESqy00Xu0So44isHpRRSfrv7f1alDF+X1OoTKKCWvDmy7mKPggc23ZEeUInkplKzmp3lC/tAIA1NhaW/yuqiE/uNSAuMvIxl5ZtkaGByykC/ubO2EWtDW91qHAbx7Y50TKxiFdgVeTOUrMP0c/4p2oq8Qfkw/Do8n62v2FHG4VSODfTsoLWFKLQ2B9J1fS04jdUoyFYJS0qD49um9qCnvxf/tmxpKEz5VqvUh8MAhVeuQ/6hvcxJpj6fXmMJ9VcTZ/2KBR0iN1qQNSGBixh1piOwB9op0S7eDnK2GKsBUHOng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBlMAdRXtXyNi88wueKiFEV8Jw8/7mGeBA4F6QjJONo=;
 b=H/wJ6+hfqhpdiii4Bn8oS2WHga3sOOumWuF9YMo3kv7FamA955DZ1oNlaK7D5JajY4PzNN84n9+weThmoh6lCbIDtccnjhFQCuN0AeXBape+ItToKc+THrK0Fff4EX3+Jczr32LhYx1fbwl4NcuYl/mODcZICdhLBvhCl1ataDaWqN0nkBfOIAxoo7P0gGk57dodPOkCoZfcLBgkpslqSiNQLBQFVE2MSnDvFomVekr/S4HwXJkTzzcy59xznSPhe/ZZd/PaQ+0lUWQipy+cHJ84h1E+GL6rbHzwokbzGKh6dUqDFkcIsmJ/NbWCh7O+ABR3sObvz7pgvSmg8A5q2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBlMAdRXtXyNi88wueKiFEV8Jw8/7mGeBA4F6QjJONo=;
 b=I9ZWf2Kqb8V96ovcieJer6raj9xoCPcEuDQdNTHlxraMIg2jISVnmmcreKzwEtCFPgR6t23kew757P/XzS497UQIC2MdHoKEb7JyjiHON9e54AWTYE00h90KerVfJhBeWchMWga+RHFiaqTWkHWjqZC/GSVBNNFzeoQTQN4kJMHe9SBOoF4vv6WGwt42joi8yjI05oVNgBckXcQyIVi2z+d6jAISDPIvk7Six2umP54aupYXfAFu7gydU4lBWbPjTbN0IBcrzuXdej+z9jaccsvmCuA2K6mKQuxlUz6KSayhKGEbFOVIsuGqdDwYKq91kyNlI4GLL1GiALV3yVzbhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI0PR04MB10420.eurprd04.prod.outlook.com (2603:10a6:800:21a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 13:07:54 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 13:07:54 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>,
	Luo Jie <quic_luoj@quicinc.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/6] net: pcs: lynx: support phy-mode = "10g-qxgmii"
Date: Wed,  3 Sep 2025 16:07:25 +0300
Message-Id: <20250903130730.2836022-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903130730.2836022-1-vladimir.oltean@nxp.com>
References: <20250903130730.2836022-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::9) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI0PR04MB10420:EE_
X-MS-Office365-Filtering-Correlation-Id: be93bace-37e8-4e0f-5bc2-08ddeaeae512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GJe+l2+PR0RtQlD42zhaC/EPsK6wPx0eGBWX+HI/MqCvT0jLBFXBXW+U4L6g?=
 =?us-ascii?Q?wugHEtUiu0M2gPseNcz1jChJyfQS3qRssuNbTZ8GIm2Jfm3lnV99YMnUVO53?=
 =?us-ascii?Q?yFRttW19GJZIimPoDi4UvhKc5GbepjVLGmZiHec2/Ca09UBjWGW8xNGPFMKz?=
 =?us-ascii?Q?XITIUzIzfc673WMnXheMTFnM+zti4ZxaLTw8dJCjkzAC72mxjAXQoazhRP8G?=
 =?us-ascii?Q?Fwtud82KqJW/wflTCKONTKd0QBbd+aLHmB+C6SXY8Em5duy3YkZR9xY4OF3E?=
 =?us-ascii?Q?LZ31ZQGFW4FxRXJYw42+FQAUBy5QJ8JBJ05MPak67Ep4VGVs/ALqZ/7Dul6I?=
 =?us-ascii?Q?XgGWBwEQ/dPkCaj+Dx5fTCq0/QLg9yekRE4K8bo15YbNenmUMaEsbCMnpMeS?=
 =?us-ascii?Q?+qZgyiXUAQnZVh5jDwveXMtNKIYuwD1uRwftNUOzRYQAjWxFq+m4G+4gYPcD?=
 =?us-ascii?Q?D62yIRnyD44rbI8To33nJGhgXLIgw6+B1PDWFPfux3kZmRqIspwZWsTLFht5?=
 =?us-ascii?Q?N3CV83Ks0n01pxQT8hUDzG5fl4b79j6dTMoZc8z0fc1MyQJ3QWdyBqBr5slv?=
 =?us-ascii?Q?bChcpra0kMrniYZxoYuKrMZgFs59QVJTdN0FyFwPCrp82Xsi1Lzx1pzk84pq?=
 =?us-ascii?Q?HfUSxVLP4XO9DeH+d1PGpCvuWj/C+Zm0XxkrFhYsoYY1u5zKaLZ9NCViAHaZ?=
 =?us-ascii?Q?zv86+UT72cZipIqMrynutdLcgfTn/H7xpX9hMlwNb2K+sAH/Ke4U0sYmmQkb?=
 =?us-ascii?Q?Hw9bmVO+/TMcgWTm+JWIkpg1p0IT0kX69FxTMmZqAhTB3Jf0MCNDEnaCjS+E?=
 =?us-ascii?Q?BIGOI8sY4f5iUUBtaLf7OLej4SEU9dpiVwRBTi0AndcZUr7wen1jKyM7q9Hz?=
 =?us-ascii?Q?KOwNjK6lFuyeRc0h4zH/R1VK0cG8MDBBExD0LI8jz0S75hKuEjBGzlODgxHG?=
 =?us-ascii?Q?7zvgyMirD3Wo9ho5u6CEXRWfONJClJNOZu/CJGkkuQNqHuknjTcpIpVy49q0?=
 =?us-ascii?Q?3+KZ0gXqmNhdj/XzVxGq/xTuxw1TLbNS9Lhhh+QywGW2AApPB+OHkeDWxYS5?=
 =?us-ascii?Q?cGQvtFnnOrl1vRF4TqQT8mvDyQq9fYv5nTjNIIQ8AUlPpy6R3gj5MjaecK1s?=
 =?us-ascii?Q?KSiGZxyTwxsewDusZ+411sXmHR7QzSVSs3HCTpT85SE9EcW99O+CdUF680f8?=
 =?us-ascii?Q?i6DlQ6JBrO+8fyZPG+JZnVtzOdVJS9sL0bmWQuMKzVZdP2+sBimE/7WbEiBZ?=
 =?us-ascii?Q?7qwrK1KI419xF7Seqkyq+PTep/AUDb6ZLz1DormVxDFmgjQ95Bp41gm2yOup?=
 =?us-ascii?Q?jvvqwQqkpL4kMb60itxjSPqAaYbiMLw9MIxqlXCuyXGNRWyedvvJbC9n61ha?=
 =?us-ascii?Q?r36cupemd2KfPt/2M6hEFyQ/u+0UcqzNE2tJurGbkU1jlh82xC6skF4+uUkQ?=
 =?us-ascii?Q?m9gThoXxTOWbaBCYUmX1BM0EakXop4bW+zRi0K+imn1a5Hko+ZUmaA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i/hNQwtngE1xG28JAKjw5H7N9sEqKK8Li0GuehKvzIU/Cu9Jk/wWlBZQQ5AN?=
 =?us-ascii?Q?cITdrOBKww+OM/M3wMpd1/XLL05ZjFilvTp8jIhorRUvVBmHTFdZGPM6NZBB?=
 =?us-ascii?Q?/IZIEuabpjCUwqpghjTdcPU3wmJkrhEsXPrtyipBT4jqHL5lXFavrX+8Z9//?=
 =?us-ascii?Q?czJsLy44Uw6EF4bYlkczDVn+X71j8+q5t5rDYmlrggavaFHrwap8ONpx/JuD?=
 =?us-ascii?Q?b/M7wI/OJ82G6NT4afDAEJZpdZZhOhld4jruz/QYfZ2se6U5/imsMgQrZwgP?=
 =?us-ascii?Q?aFMgHcjLHz90f1QGocLOeVOEMlFWyz/auzF/CBUrsxlPC7e0s9xeUDPHMGdI?=
 =?us-ascii?Q?zFefjOQ6xltUqzUxG9sK4ohMKdyBMzHilgfhN52ceBqKjYuVwXQ5GEb1pLV/?=
 =?us-ascii?Q?EdN3vLoj+IAONlzvsixoB+0bpyrwzw4vLsg9MjeFlEPpXsoHCJMfvjVvSsL9?=
 =?us-ascii?Q?QeJ7r6HqTQFkYjCyu92cBnMxZkSZt/GxKtsw5kREGWxH5whGwVnFm2MZg7Bu?=
 =?us-ascii?Q?PGcpu0rObpmYDBtgJoizqlIS2LP2xCpooG00i6XEBPZglIH1aygroIMBU8IO?=
 =?us-ascii?Q?M0bkoy8s/R2heNNkx3o5HBfmPmABi1qiolS3673+g7a5lksPRhxbdvsiO21V?=
 =?us-ascii?Q?IJAlm4QD0KdH/Sn7sJVA7xL0ra2yto50zNKnt9pfugtlDzYTOuu+fgNXEYzd?=
 =?us-ascii?Q?CV0OARg0oqRFaMaFV9j4wewBUDGgLladZJwSNHVTYG+udWNxjrSzm2NmQfzw?=
 =?us-ascii?Q?sqmyvJSkzFu8f33KN0E6mAMzAkh49JI6HDxvd4cJw6slXtW5S0AltLMqfhDU?=
 =?us-ascii?Q?NorIbYix8xlFUcFeRHVGKR9YzDtP5l3jcdk7pCJYZ7fnf6FmAmq4iAJvDwlX?=
 =?us-ascii?Q?IU3RC4zMDyVypM3uZVBCGBGEFgjc6afDXIsTQm4f0pO00A4wX9yx3RNe5sev?=
 =?us-ascii?Q?+p4TQ1iMMOOU3n/jlp21rx5TJSGMIQL0W9hQN7orpa8qGAVmwn8zIbZynorO?=
 =?us-ascii?Q?hvZLqLJfS5Quu44BKRZGhMnKHF/F+fatsDl/pGAwUGhxBLNMSSxIPrtT2RYF?=
 =?us-ascii?Q?HX1qyZUbvTqQy0mTnpC6/SO+rCOlMVGzZNIEsMXijjzWaT+Snxw+5ypJuIbG?=
 =?us-ascii?Q?HmxIhDsAR815LpqsXzyDsFQ4irHudBzdWJFBP3QG1blxsV3q9LkFJJuTli4I?=
 =?us-ascii?Q?gtIdn17jYvmuqVy5XS8Cf/yAfi994RtlyhIi+3vHI5l2Oe+B7ObaRhxDlI06?=
 =?us-ascii?Q?EH2ZLio/EEUaOZSwBGGTKMz2qgdi4hmod/kCElFbCe3U6GHBlLv9VOTQeETu?=
 =?us-ascii?Q?N7Vrn/O0oXtYwi1xPnk8BnytRMnY7PshABnu61VxDydVCyMA2LYWYjiTAgOB?=
 =?us-ascii?Q?mClP3lN4JMFTH+Il0pDhXS4a0otXRJqP9CoeKlm8ESPDFU1lS5Ddjf4v8odw?=
 =?us-ascii?Q?bE/7pBYXJT2FC9MOcYo1oKX6/ZRr+LV5a455cVdlGWMhArtZx9aHibLMPChU?=
 =?us-ascii?Q?vH8z0nSbwAGCkSfUujBP6SmZubLPV/MSDsQl0L7N5uf55usf6NUlrT3KkViJ?=
 =?us-ascii?Q?BD8CCcvdF7nrApjXk/Fi8tC99j56yG0IuKFu58EN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be93bace-37e8-4e0f-5bc2-08ddeaeae512
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 13:07:54.5212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGsi5YKud+JclKHbWK2RO6UhFSMEWkoqaYOCqgYZPHQhq5/DyhDD+CNLAhjSXncdO73k/+sCeqo+4K2/ojMYew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10420

This is a SerDes protocol with 4 ports multiplexed over a single SerDes
lane, each port capable of 10/100/1000/2500. It is used on LS1028A lane
1, connected to the 4 switch ports.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/pcs/pcs-lynx.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
index 23b40e9eacbb..677f92883976 100644
--- a/drivers/net/pcs/pcs-lynx.c
+++ b/drivers/net/pcs/pcs-lynx.c
@@ -49,6 +49,7 @@ static unsigned int lynx_pcs_inband_caps(struct phylink_pcs *pcs,
 		return LINK_INBAND_DISABLE;
 
 	case PHY_INTERFACE_MODE_USXGMII:
+	case PHY_INTERFACE_MODE_10G_QXGMII:
 		return LINK_INBAND_ENABLE;
 
 	default:
@@ -115,6 +116,7 @@ static void lynx_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 		lynx_pcs_get_state_2500basex(lynx->mdio, state);
 		break;
 	case PHY_INTERFACE_MODE_USXGMII:
+	case PHY_INTERFACE_MODE_10G_QXGMII:
 		lynx_pcs_get_state_usxgmii(lynx->mdio, state);
 		break;
 	case PHY_INTERFACE_MODE_10GBASER:
@@ -170,6 +172,7 @@ static int lynx_pcs_config_giga(struct mdio_device *pcs,
 }
 
 static int lynx_pcs_config_usxgmii(struct mdio_device *pcs,
+				   phy_interface_t interface,
 				   const unsigned long *advertising,
 				   unsigned int neg_mode)
 {
@@ -177,7 +180,8 @@ static int lynx_pcs_config_usxgmii(struct mdio_device *pcs,
 	int addr = pcs->addr;
 
 	if (neg_mode != PHYLINK_PCS_NEG_INBAND_ENABLED) {
-		dev_err(&pcs->dev, "USXGMII only supports in-band AN for now\n");
+		dev_err(&pcs->dev, "%s only supports in-band AN for now\n",
+			phy_modes(interface));
 		return -EOPNOTSUPP;
 	}
 
@@ -208,7 +212,8 @@ static int lynx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 		}
 		break;
 	case PHY_INTERFACE_MODE_USXGMII:
-		return lynx_pcs_config_usxgmii(lynx->mdio, advertising,
+	case PHY_INTERFACE_MODE_10G_QXGMII:
+		return lynx_pcs_config_usxgmii(lynx->mdio, ifmode, advertising,
 					       neg_mode);
 	case PHY_INTERFACE_MODE_10GBASER:
 		/* Nothing to do here for 10GBASER */
@@ -317,6 +322,7 @@ static void lynx_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 		lynx_pcs_link_up_2500basex(lynx->mdio, neg_mode, speed, duplex);
 		break;
 	case PHY_INTERFACE_MODE_USXGMII:
+	case PHY_INTERFACE_MODE_10G_QXGMII:
 		/* At the moment, only in-band AN is supported for USXGMII
 		 * so nothing to do in link_up
 		 */
@@ -341,6 +347,7 @@ static const phy_interface_t lynx_interfaces[] = {
 	PHY_INTERFACE_MODE_2500BASEX,
 	PHY_INTERFACE_MODE_10GBASER,
 	PHY_INTERFACE_MODE_USXGMII,
+	PHY_INTERFACE_MODE_10G_QXGMII,
 };
 
 static struct phylink_pcs *lynx_pcs_create(struct mdio_device *mdio)
-- 
2.34.1


