Return-Path: <netdev+bounces-215687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBC9B2FE5C
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7597272D3
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081FE287247;
	Thu, 21 Aug 2025 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W9tOBoW4"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0830127F736;
	Thu, 21 Aug 2025 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789686; cv=fail; b=rNFTR0NmHfnSbTk3fHxOOe1neeF0eVgUZCGmbAhXrY8RLo/nXwsEx818NEXjedQnTtY6nMgQ5FJ5qCxxdxK7qwaAEZONu0+AMQYdmJPAyRBnGUF1WvTCTBVtkkHv8mnSxNscii47gxrAO8a5EwZBT8tsVRAFYq/oKa2G9ZXKVqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789686; c=relaxed/simple;
	bh=InyQxz7S4p2wbXghCsbEExf7hF4o/+lqfKV8QfzBYD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WYPrF0QOgTCSz1eLnqVL099fe22wFJtXRcjjhjVYfGon/bwjt1/7MbysKf8SAKGb/BeKD6X9JJtxMzYxG1xROKojYw69tlrQoH7/G/N5VazBZhRPWgS9HlqQEsyy7z92bM3pZh6OFjv87X9E08wI5ZHxd4g9DOm00x+F9yOfvfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W9tOBoW4; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7Gu2i5NdQCpqO4DJi4EnRmHIo4esbbB6ghjK2VwQW+ZCBU/DtGVPzb5bS32oWB3v7lTDDNsAtXKbWwF/5Zn6Nfe8/3VxyaKl3j3B3ejInsKxRzFujsA5KaIz8nP2Kxpbnb1bYJnZhvu1XjkS2OyMtUrmJxAMnTt3tOnBLMKRIy5PzXN0qS3KIyYzPgTGBuzaX1rud1WEnFTtSL8/ozF/PBEAihgqWF25wBVTGAEIgRpegTm0763zTDpEfmLNVN+fFcr3n+nqO0OAdPPun+Ss+P3ScVBy1foCZWIWAcfzSJbyTyDEScDdju/dUeo2fbr2auVBujvSBXrXSgKIQ3xJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tg3HaDcxr2LKt4Sg+IoS9/N2ky3o9nJtSEAioyQzFug=;
 b=KcPY62T27DFjRCyQSh7xqcKv9Tm32ZidGGyNaiPBcvhqkkQInfhuetHE+2cTAZ3l3uOkGTx/db5WtMT5XJjGeJaMVpNtZNiO7Ne1C9gJyjlJo4zUg4UiYhDJHIu5CooMFidf9gz32uZOLPCKPS2rVrDL8TQW7byzN5jWGhXafvakondjvF1ImbqVw6ghY7pmZBdBmBrCA2wA6QIHBrJLfdxhmpj/n+rm+eZGlAdAdoQM49eCj9ukMP5dVpB/5CJaqFBuOOGPetv45JkKc5uH2pykRk3RYZIASUCEHrC4YvOljeusCADOdqHUKXiRrYCYjEghu+htiAja0Xy/Xj09RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tg3HaDcxr2LKt4Sg+IoS9/N2ky3o9nJtSEAioyQzFug=;
 b=W9tOBoW4rpqUyzbNTXEUXrvC6CvQQGJ2YaRn2QBF3xSolp4eMPNbcbqrMdDGfYgY/SRYzvPin4vS2QKglH4HEC2WTfKCNT3rWzK5Ib92itFQcOJQb0nc/8zi1sHKlugX6xuAVk6DaBWhC+uJAtKyWumQ+tgRjfgLcG+SGQTz9gws0MA0FJTYQIUkjAaL4smLU30HV+OMzKKjk3KSY05g0QnasMLYBQtbyA6J0ydxzM9rmbb3rTmOHL0X5za0HgcMr8kRWk1NWdRb1y/zSSdW+Hd9DZw9xsqNazfWpXYWImeGUAY5KdfEJhHZaxj6xYIwk+V+ZpCSr6YH8hjuC9S/Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10809.eurprd04.prod.outlook.com (2603:10a6:800:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.11; Thu, 21 Aug
 2025 15:21:17 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 15:21:17 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-kernel@vger.kernel.org,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>,
	=?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH net-next 03/15] net: phy: aquantia: reorder AQR113C PMD Global Transmit Disable bit clearing with supported_interfaces
Date: Thu, 21 Aug 2025 18:20:10 +0300
Message-Id: <20250821152022.1065237-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821152022.1065237-1-vladimir.oltean@nxp.com>
References: <20250821152022.1065237-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0016.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::8) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB10809:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa80c7b-3fcb-40f8-6d43-08dde0c65fef
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?5+AcXqaD3PNbiIPXo0sNagDcIjeOWRoMyDbU+75VkGo+Q11sstT0GexXBGj8?=
 =?us-ascii?Q?ouJIK9KEmUR0M0+Hj0P4iYZXCIce7t+i+nqlCXR8oDV59CHg/G5PSh48vw4K?=
 =?us-ascii?Q?uC+W6NtV7ideVcVpHsc+TwRYKSGlPDZo72joJEsKzPCvRVjp3uVfP7Yn4mqz?=
 =?us-ascii?Q?d7a8hiypOxMM6VNfW0zmcy1W8ORPUU4o01r8GfbVL8OLleqaoO8Gr8UNLC/U?=
 =?us-ascii?Q?sM2b3Rwt8xnTmJ7WVjc4/m3dcUnb5KGbmclh1NHXLderD9OsiGlMXX8NfIEU?=
 =?us-ascii?Q?w5qDHsioYhZTuWRAlX+SYfhrDQfsLCoYYRSk5Qvu7O7zYyo/WMf0rs53Bf4d?=
 =?us-ascii?Q?2TrfYSIbJVo3Pao2XwZ06nM2TdECAk4/jzak6sY+AXLjUAVMnZsNtr+HchE3?=
 =?us-ascii?Q?UQ+xxFkg2QAMXC3HVqo90dJlO2gAh2z3ifmSr5jlYqEnqzEp6IPmzGPWPcL7?=
 =?us-ascii?Q?SsgdVmW768qcJSW5Bz+CeYaqaEi9S7SSyIECPsoYi05fCoab0S72s5u6R4WX?=
 =?us-ascii?Q?5vVe7Lk756Xhf2YtjOeyRco7m3Qx5RSxTle7dgaJ2aua2IfjMENuSeUdHw8U?=
 =?us-ascii?Q?XTScKcCUByD9cTj7+UvWLXLHRjAWA8Q8WbcZk72LV9UpUBZCVEpwq6Yjdwbg?=
 =?us-ascii?Q?KHEbcoBTvC7sHP/pkp0XjJcdxhLavkn8aiLG6ue3kFskDLCbw4+fY2YhDLc3?=
 =?us-ascii?Q?23At7eR7MgGiB2Rfg7xVh9zGOKIzBzW9R+exkkbScLOA1vh35X938OgRFVlU?=
 =?us-ascii?Q?VJWcruSfxrJvAA2h8iEbUllfpPK0bX0N5SoNJJUMIxGUuP2RPHwpQh1X0ONE?=
 =?us-ascii?Q?ZtSqs5iQN1lZ6cdRtV/wsXRJvgj4gzPDPEpP570teYiuEtkKayVI5N6Mzw/8?=
 =?us-ascii?Q?BCvUzMAaxsT9/dg+pdRM5M8phO51ij2mjNjb+DWpm1IosC1uxBErCn+QoNd6?=
 =?us-ascii?Q?wmsB4vd5vUsjTwRjgh6a2O3FCeLuiCtjsxXdHqoh5M04s2Kf75Ery4MOSu17?=
 =?us-ascii?Q?L30mfPnBgOBMPa9qmfsJDC0aMAxigqm18skxzVR+AlZeehAyiG9HljWB76QW?=
 =?us-ascii?Q?b1KBpxVPgcgLgaigRjtOuFpCAPEVmtgR1g8RFHZMjkQgpwdaKQJ4lUnL08W9?=
 =?us-ascii?Q?SscRmiQkwZ1/aVTqySB7tZLt5qcSSEkS2UcF/dS0iXmDj4Jtj1Hz1jD1DFd8?=
 =?us-ascii?Q?3Q1q9x5ci6T8cduwcKnpjLHksawgkjpUNUC8whCbudGG8m4mPDBvvC+k19dJ?=
 =?us-ascii?Q?OsSyjea9yU4fQKFXNtk5XLnyGyTO3348/ix55c/cJZMLcWZa/CLZXXHHQfPE?=
 =?us-ascii?Q?1LT0sWjbYbR8dt1rxFe2h5NfkuZXAdo+kzQRdnfQjOFGaLCdRO/rdasqg78v?=
 =?us-ascii?Q?teQt8U3085Mfp8OjGFXS3SLLBcwNN9nkIA4FFOFWMvfe8o/xJDGKCgx+yJ2K?=
 =?us-ascii?Q?7CUKPfYb7gUoN1E1GB0b/lqGZ5srdOQEPfwtLgAg8XT9E74rKP3Lgw=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?L8sHDgybQk1jI4u41FdIi6gYvIt2cOGnwJM6jFMyf74L6hvdtZbkryNNRza5?=
 =?us-ascii?Q?QiySoif9+xqjsZLgYN6sNb5Gs1ASP45pL720upJ8B6rxk6BdHA6rL+/ZoPfY?=
 =?us-ascii?Q?Enx9DLvXeZwIeMbEsvd84Zhx0o6ABBGVEW+Ipsv5OUxvW08ngoXNMG/0q6Xq?=
 =?us-ascii?Q?ePa5+CMP7r4c6r7sTYsE2kBkFSs/7ZVKE/us2Rke7RAyWgqinjOSxj8Ev8Ex?=
 =?us-ascii?Q?g9suh6Gt3s0f8j/5dePEpzBwFdPdHbvEdBf7APhcwcteZA7gzOFIyAczI1Kd?=
 =?us-ascii?Q?WfSvRYPW9GIYa24pTIhaiJQ9uGIAhxKB4zKf+LAXHmTM2NOyOnzEj012S7Jm?=
 =?us-ascii?Q?PxvJIJgWsbW/58hqStrS0Unn7NZbmciibDF0Asoom6x+V0xuL3/GqHc3XR2c?=
 =?us-ascii?Q?T9Jqej5weevDacKN/7VxZmt8HiBIayYZCkD56EzX23wXC/F4Rjl9ZNpS1WZh?=
 =?us-ascii?Q?wXvzAYqLMP+0vzrnKKAMyq0ukUm/8EbXXc7IapCjb/SfAIDBQvAYdr5j9BOV?=
 =?us-ascii?Q?q6eK/C8kKziV3D9J7D5ONkRFtURqRRm2eAPGCpxeZS2+WZPey8gJlJaKBxoX?=
 =?us-ascii?Q?FetoCb3hZas4k5GAtAiXkkKPSqpqkQocdVGWnVq8L7yPa56u5wYLJ+lHIQ9W?=
 =?us-ascii?Q?ku1gwljJm7CZLxhIsOok9s6JLhe2Sq8rnA2cnVLfc0mFULRH3Awn7tVO79NJ?=
 =?us-ascii?Q?NjFdibXNnWG1aUH2DN6F6W2IbcmaGAV4RIdBYpeQLVr81PuEZnYVPxH4oYex?=
 =?us-ascii?Q?n8upNiZmemIM4bD4GHBlXyGVTC29etjvTTIxHB95W5fD4SCPf+WRBXk4aAo4?=
 =?us-ascii?Q?ivc03egmqKsfd3ImoviNclicKtdWM8aNsEayMh+S6bbmdB9Okhq76Sa4dn7e?=
 =?us-ascii?Q?xOk2dy/RgIVRHglXZPl9f3CtrPxu0MwnWGwoW7POqwAWliGVHyrH7TptFjEG?=
 =?us-ascii?Q?J75UHrTQiRZwzvodh2H0xvsoS45+UVkBgbtNL4iv092r0jyjcCZFczvY2GJT?=
 =?us-ascii?Q?3YWllYw2Z8cY88KI1PDRv0cki24L/5PluZBFRoY3+fr1WgPqVIEJy8v4ioqO?=
 =?us-ascii?Q?ndKQoEw04jxfnItC8VHAEIAUozXS62mZb5Qgq4KK7AAEe6E6wx1HmQw1EZMM?=
 =?us-ascii?Q?6HGfXdZybezqpQ3Z/jOCZFJK6XymmYIEsxpUSynjOCwMuALXVEQqx+N94P99?=
 =?us-ascii?Q?EMN9JdIyq3b46fe7WS7RFktp7ZY5zhHjswlgrd80OO1dtsLZX7uCVknsQcqF?=
 =?us-ascii?Q?Jfi6gZP7PA59ZNxqxUZF2OoxWva6RGe1uv2hzevL5ykpElPbw3iLN0/dwckS?=
 =?us-ascii?Q?i49aaoYEsa7kK+FX/7TLOW8VxEm64WFwh+9mvMNpsmX0cPVBsidwiLxNUxAJ?=
 =?us-ascii?Q?gCiV8I5kcUQB6bFEjDdfQmcCMvqKTp3+1WtkYB3GaC3qFYcDQPKxDMPwc3tZ?=
 =?us-ascii?Q?G+o9Xw50cZ98lm5Y8s7uTfqStsjOJpQficzZjs1YDhgZXvkamCKoWNqZfe7t?=
 =?us-ascii?Q?SXHcVTftCNVf/IQkPpcZ9hCslHyDE6DA7J8FLw4xAOJ7TbL8qbZ2haYex/iw?=
 =?us-ascii?Q?/+b+5mH4HZ7vK0fwSSLA6V87idwfQHT5fXfZNZ+R?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa80c7b-3fcb-40f8-6d43-08dde0c65fef
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:21:17.5555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulA36Hj6owfMEHmKakeATJ3Efx7sW+lMSkeHhZk0GAQd2/umPnxGlPx6buX3r7wolvp78LeJPA0ySbTWV3Dl5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10809

Introduced in commit bed90b06b681 ("net: phy: aquantia: clear PMD Global
Transmit Disable bit during init"), the clearing of MDIO_PMA_TXDIS plus
the call to aqr107_wait_processor_intensive_op() are only by chance
placed between aqr107_config_init() and aqr107_fill_interface_modes().
In other words, aqr107_fill_interface_modes() does not depend in any way
on these 2 operations.

I am only 90% sure of that, and I intend to move aqr107_fill_interface_modes()
to be a part of aqr107_config_init() in the future. So to isolate the
issue for blame attribution purposes, make these 2 functions adjacent to
each other again.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index b9b58c6ce686..7ac0b685a317 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -1093,16 +1093,16 @@ static int aqr113c_config_init(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_TXDIS,
-				 MDIO_PMD_TXDIS_GLOBAL);
+	ret = aqr107_fill_interface_modes(phydev);
 	if (ret)
 		return ret;
 
-	ret = aqr107_wait_processor_intensive_op(phydev);
+	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_TXDIS,
+				 MDIO_PMD_TXDIS_GLOBAL);
 	if (ret)
 		return ret;
 
-	return aqr107_fill_interface_modes(phydev);
+	return aqr107_wait_processor_intensive_op(phydev);
 }
 
 static int aqr107_probe(struct phy_device *phydev)
-- 
2.34.1


