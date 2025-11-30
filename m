Return-Path: <netdev+bounces-242804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E542FC95002
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 14:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 189CD4E1B9D
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 13:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BE5283FE3;
	Sun, 30 Nov 2025 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TwsPAX6j"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010044.outbound.protection.outlook.com [52.101.69.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E04E280CFC
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764508668; cv=fail; b=RLtjX4MJmIlJX71DHP/jMMUYVotmL6U/lUSodJHaAL4OCIKB32gvZpjUOO2H+4Mf+JKnsCwRuQ7O/Nqd3cLw2g8iuR/l2/L+n1SjoULjxjuLkDy7IQY6Mhp2AaKOwO7+mK17vI6WllUZgYjbdjL9Wpw/CvANwO+t76h4g+V5Gwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764508668; c=relaxed/simple;
	bh=IOlq6DgrjYceDZbeSQRvGWwpDbz1n2WlOvRJ73Y89Kw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FcaHn+X/TtT9tw9DdLvQMum44khS5c/YLtAQsl4iQnxYGWPHeyE7Icg7ZFTXtsbWzpB3VguiYUJV+WEzMgOzT7kjER16olbTVUDH/85/JToaE9aflw/C6r3Wf0OMDVWpd/WQlAtLUmsbHNaz3EdCddXXKjFgQl2XrRiqqSPyfbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TwsPAX6j; arc=fail smtp.client-ip=52.101.69.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idaZtAH0HQUaqSvyw6Gf9xiPCvP782X/2rvLDA8MouBzAPydWF/ziP2v13Go3JvGYfYiDoNhWDwUknn/NKzT+H6cCzlPSNwuKgcN2n/JDjYZsZp7fBN91zVcL9HsrrYL8dQSUj/s+LHefZCm+/zzNCDtdafHqF45pgA6PA+Q+riGat8BpdeD9O7X1WKldHaStbT1bqSpi5FcdyJSgapI/H2maS2SQMytCJ32mCI6DI8eV5UQ7WQ+80Bkgevf9348cpUrvRdPkIAAEcp8fxfyuQl0Oq8jc56ddWEiDQOzBdY+grf8/jaP0vA5xpPoz5tElOiUqraB2+FFlxLVpAeupw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Drn61dFef42eb8rS6EpjEBl4yt24jRPmad9Z4pDZ7+4=;
 b=Q3+f8Xgk19P6QB/MpxXOVarO+D/pEovDfpMq8MFrD8nU70zTvOhXfcK0so3/PHOwEpobEIFx9jt2bDOWrSZRiRBh+d5uS9VOteukUvZ5m5fyyuShUaTpZuzm6evAza2pm0CA/jj1KARUs4N1ALV30hMhzCASajGtTDI/uaFdY3kVZacFWvN4Nns9wL5PNpbqcC4mPHhQAAmsVb9O1hhcj1YSpSfabEJELnFAi5dBVKTX3lcqxZdNlo9jKC60LBLPxb3fqK9LOEuCUPCdU+KRV5B2tW9WsYAqbICVT/a/DKhoNUr/gzQ80Eo5MrOGmLIqJMAtTn+4Y0A/im6N5AR12Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Drn61dFef42eb8rS6EpjEBl4yt24jRPmad9Z4pDZ7+4=;
 b=TwsPAX6jN4+MdsmUbuv7FGHhUe4QtCWemdic8YgOsbHuWOfKFv7+oM3IsqPEzZs99pS+pFYvWHu6jrYNyF6jAJcT0s0nkCSlCAYPg8lgJNLyg9S6tz9HL2IpfzJbz3uXHL1Z2oDJcCwc3Ea+Azn6ZBAP6t/JMEj+TBST6ATP4DSFb1iu4+MAlQN96ge5J2nUrF4V5t1gv+b/E0Gaalk+VBkjtTHQbOspVP+klLl2yx9tgwxmE04qqrYEU8gEEgC1MbduNJJ6glRyaH65Pg0P4XORylCMi9+AGGxnp/8/2KzWmiJZWXAh4p+3l6pwsC5BYdg/Gq5xZQ0s38/4/OHj9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM0PR04MB12034.eurprd04.prod.outlook.com (2603:10a6:20b:743::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 13:17:36 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Sun, 30 Nov 2025
 13:17:36 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH net-next 09/15] net: dsa: lantiq_gswip: use simple HSR offload helpers
Date: Sun, 30 Nov 2025 15:16:51 +0200
Message-Id: <20251130131657.65080-10-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251130131657.65080-1-vladimir.oltean@nxp.com>
References: <20251130131657.65080-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0128.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::21) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM0PR04MB12034:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ffc3c3-2995-4ebf-4878-08de3012d478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5G3B9uMwsvcLFyeeNR6580A6sMrFF8kBmd8PD3e5I14dA/o6OlwZUReIyFpT?=
 =?us-ascii?Q?pC1Tb4xppazeFA+wg5UmERcDxzv/nCfW/4NtHhB+xseCGe3pp9cRpeM6ULVK?=
 =?us-ascii?Q?mpWnvgC5ZTbm+v5VLWse24kvXmia7MT4CVtEumTYEXXOE/4joKqge0om3Rkz?=
 =?us-ascii?Q?4NMUMFmxqyxeFGJC/1f4b4fSXYKHSVrfomtnSEFY1m4WgZkMCt7V/QZiafRn?=
 =?us-ascii?Q?HZ8v1RasZ2uyeZVPklUcDlca6D0xYcGUyM9vQyI+NwFjFjCcCt/2xbyTZrjw?=
 =?us-ascii?Q?dFQlSTW3IBQo04X6FscX9OrkoCzdqVQ0WRp0GuZgv1bWPyZwpH4oDvU06S9H?=
 =?us-ascii?Q?laDr0Wuc4qytLEHAfa0pxSHgNFsvecp4HvDtUVpVyR+H0+pFXE9sVChSTo4U?=
 =?us-ascii?Q?XlPJoKzPpTgPBr/a3JU31UUd7YD68xrD2+5nUvgwfQ96NfcCu7S6gTmgmCUA?=
 =?us-ascii?Q?KF0K/qD64n7hatWQalJ7HsTu82RFvxxus68NLSQNIYMRCqhMP73F7TbCbsmC?=
 =?us-ascii?Q?SibaaVcZIOBRb/R+KL4t7b97PJfXhx5p49GZu+bfwtUCHq316un7NWLjUmEm?=
 =?us-ascii?Q?7gNG/38hO18WyEe/E1dj7FeHJvSSHADODSs4TDYZxqr023W1cpupyXOEJc+1?=
 =?us-ascii?Q?eY+uE/mfWbpmB9NXSLNo8lGZh7gM2zWfghPgx9SvjHg9lq3vhtk0mpq/o+Aw?=
 =?us-ascii?Q?ix4XjcapHrCSY1erujynNCn5PQQwMwuB3o8bIDNFpj3dLSAPk8Rw2dY9V0Rd?=
 =?us-ascii?Q?CiXiNNGkn5zLEt2Nx0X8/joFRy7sip/lht3pc347vf6O232rtOFvfC1vJOm0?=
 =?us-ascii?Q?+XqTu2AW5E8lcmZaNJfgbfZASUx1FzhxeQTuGFlZzwo8nhMuSCbdCXLnfZrS?=
 =?us-ascii?Q?eJf8VOcUflihoZJCBShdoUuWJWoFYhU3FkP67A5rltBRc05nFYEAo3pI9GaY?=
 =?us-ascii?Q?rY65PZLdUemP/Syi9AijLKP766pAR9NBuRvF3sLqpXw7+qimqfisc/9Q63KW?=
 =?us-ascii?Q?7li9P1k8a7Bws8wwg5qYT8FMTCJb11hQLJDrkdMQPMnSon6znQqA70UXbVTT?=
 =?us-ascii?Q?Vo5/cCuoaWfztEe9MUczy7p1qLKfrlwiJZI62oOPHnC7T7jgg8LnLbewab+E?=
 =?us-ascii?Q?Z+KlYwtSCUdOC0IWiPEXi6u1vffedsJ3sy6rfnCGlRuIR/VHTmthK6Eu0bKX?=
 =?us-ascii?Q?UNXgir54cSS8zaEJU8tRyVmDOHRtm4TAG+Krk6vGTwR+HuadsUB5N7AUTWdR?=
 =?us-ascii?Q?wEVjtpp8pOGqhdCJQHNhI+ttaWpwN+qr3cFxuZA0+qkKlNOzHB81zzsqcqN0?=
 =?us-ascii?Q?+3nuxMOctS6sVcQUr44QejczZ4qsJsX+EB0vjTyAetxkuhlJdmh/yNFQjlIS?=
 =?us-ascii?Q?77ECajtnZxAZkf49j9nvTzKwYB3mQoLVdQjTxprQIcF/mCqcM+c9i/D+i3xN?=
 =?us-ascii?Q?LyPpxHp6wtAsKE56gZzbZ+4McxoHyi7phCKWiwto2dOHAuGIcerIPumMsMoB?=
 =?us-ascii?Q?YlMfjkBFuwLFMt+KuFRLLgnHxFU/zq9NLsJd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X25wThXcL4bZd2I9gi4uQCfGPCfSKQISwfzAN+njMkUaWRpRCblGkv3S6VDp?=
 =?us-ascii?Q?9dvPhz7bOEOlo8Fegj8URspHeKbr9aPOhnu/Y6ZDcsm3KXc8atVNyvzPzH93?=
 =?us-ascii?Q?TAlHBu9iE2U4/g6l5rRtRS7dHAcAL/1mKTJhNHvnB/WgbHXZB6Ii24esnQL5?=
 =?us-ascii?Q?bqzM4Plm2W8+qa5OUzQ/9iIcOty9oz7csPD9SLRUGxGIWShLmJSbCuHKAmrt?=
 =?us-ascii?Q?o+5ELOyrizYWFTeKYUv92NDUKQpRjYs1NNqgKHg1JP1nCUlBxc778wHrY2pz?=
 =?us-ascii?Q?0uToEFWEEE9YEhncO46KWulXoiHoKzNg9azsM6e9aBW/zk0XCidALEAOspnu?=
 =?us-ascii?Q?WwvMW0/FygjL7M87QlwEPDsv/+eVcdim196s9bH0ua1LE/HjLaBGHD0rMKuP?=
 =?us-ascii?Q?91zPaV9ft9PnY5nRLVfHuLM6DseU24xll69aK+gDgLWYvmqkUzWKjRrQdBIK?=
 =?us-ascii?Q?SsotKwNFVIkg3v0Y8z9D45RYzG/Yugz0aTOaP8+zAV5qcTREk9dcyNxh5cNZ?=
 =?us-ascii?Q?BoPFCjzk6fxFgpXDLgUhkthF0aYMsHMfbifQUXIRcP4pJVKq8AXqnE9IOiBt?=
 =?us-ascii?Q?61nYkZoxVX8PYedjozJxiD2zKAk3KWQ6sSA64jxdw5yk3nS7BXYWCTRHHk/t?=
 =?us-ascii?Q?F34LDJgwjy/N2F/QMv+XcL0j5rHi9diWNuHLjw4k2OWyE9T4GllY1h24o3W1?=
 =?us-ascii?Q?DBTtfcsXxx041wOvQTzIfncLy3UIq7VIiUYOVJO4Dzo/iwygPHl+FaTxVDUW?=
 =?us-ascii?Q?ACnZKIwo1277fcvb1Thia/RwCvGmdCAlT647CzhIQg7YzdOoa6Cc70Ho1DZj?=
 =?us-ascii?Q?zP28vs5kWMQYP6LSDYMAGRHHPB9kfJYwGt0nxoT+Yu4JdeS25Xmk60s1jhlV?=
 =?us-ascii?Q?/dJf2GY6GrDkNYQfJcp8C9UbOpbpYzNApS4u6N4ILiAEisqMMPmt3vdr5koO?=
 =?us-ascii?Q?N4+raEq5bYhk1VXxDPauTuntNyYc5k1zxjDeZA2Ua0ugWlFMn7iaecBnrg7D?=
 =?us-ascii?Q?tFt7UlAMvaXwPOvkYggkPkKHWhp8NoP4zZrDayNgW5mfI5ujx6fJ06LpRsS3?=
 =?us-ascii?Q?VojTX6sUgrLN9fqMzz9ZySrfL5kFxeKWferTzJZa7lRkRqd3KsRRlQkHszbd?=
 =?us-ascii?Q?ko4AFaCWjX7DdJrq/mYnlopWNVJnIpvslf40Yc+yBx8dSCpW+mPc5nr8eOyL?=
 =?us-ascii?Q?z0didQDyalzztTHjJeL/jvcE0/rDA9XoBA75S1vcDHCfLObOWtNIXeIup66a?=
 =?us-ascii?Q?krUoCTCXIgDbpx0cldGGdmUyODs5Ecaas5bBvjNxPMLWellfyPmU7R+NEKhN?=
 =?us-ascii?Q?7by0klbWmWhqdtUcfRnVnwDrTD2pjvvwshUJBAL2OYiFCWSzQkoM2mLiQFdH?=
 =?us-ascii?Q?YlknRUe6Fo/hYKeQ1dx9EJWNAkhtY7PFx2gnP0bBRF+tz2rggZ3ezQLfGOnb?=
 =?us-ascii?Q?HVl6CkTB7Kqu9AkWcDH+WhQxYohN/2cevIxM51uhkrGcfegXuJOo6yiyps62?=
 =?us-ascii?Q?khq1dkglMoZIlPDAUjjhUo4u6nPZ7Neyf/kSom+KQ0QKBac7ruSOi/CcXFw8?=
 =?us-ascii?Q?QytDcBeebFW2EJu5nft3NHUCgsOfFe25usp2MPa27qgHGYtSxEYTOKFJNrjV?=
 =?us-ascii?Q?3g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ffc3c3-2995-4ebf-4878-08de3012d478
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 13:17:36.7009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FV6KcX4L7HQVILfchzbAxPUWj39FyAjIyzoryfipBSHP4C0ZryomOgTphmYezFpe2zzh0sMuXL+bmCfVJf2KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12034

Both the "gswip" and "gsw1xx" protocols use dsa_xmit_port_mask(), so
they are compatible with accelerating TX packet duplication for HSR
rings.

Enable that feature by setting the port_hsr_join() and port_hsr_leave()
operations to the simple helpers provided by DSA.

Cc: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/lantiq/lantiq_gswip_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
index 122ccea4057b..9da39edf8f57 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
@@ -1652,6 +1652,8 @@ static const struct dsa_switch_ops gswip_switch_ops = {
 	.get_sset_count		= gswip_get_sset_count,
 	.set_mac_eee		= gswip_set_mac_eee,
 	.support_eee		= gswip_support_eee,
+	.port_hsr_join		= dsa_port_simple_hsr_join,
+	.port_hsr_leave		= dsa_port_simple_hsr_leave,
 };
 
 void gswip_disable_switch(struct gswip_priv *priv)
-- 
2.34.1


