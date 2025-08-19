Return-Path: <netdev+bounces-214965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7177AB2C4B6
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9022410E0
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 13:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988F7350858;
	Tue, 19 Aug 2025 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VMGAT83M"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010067.outbound.protection.outlook.com [52.101.84.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97182350830;
	Tue, 19 Aug 2025 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608440; cv=fail; b=M8eJ1NUeAbdFpe2ZwZsiI/l50CGJMezwEeULvdUkYSSYkvVw5FfyiY5dYQBDVH7Rk1PlSldtdMeTgsfLaEOstzDPMvitXcvA0QZWwTOXfRbKJ/rllWjyTjuG4S+t7S5czSOW+V4vKE6mT627aasJ27WwRmme6DjKijavNzqf5OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608440; c=relaxed/simple;
	bh=XKim+Apovg3ClzFH9GZkEj197hgDaqrgI4nW5tEW1BQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ocyrXQ6E284p0HZ0Ch/eO5gVtmwW/E2AkEiAGe2Tu80Mh/HCkHq42Ma4jGVasaa6wRiawqzdrK1j9utaqSHUUu+w5alwYhX0JLvq18s+2whfBPwNMWuEyH/ThbbXcQ3gR+/+Zk/nHwkIYjH02bKFtWFAU4eCNcVxDSWo1qhh3Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VMGAT83M; arc=fail smtp.client-ip=52.101.84.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkWuv0HeaSKNCzH1vk5n4x9J/JLmpCo5SjdVeKYlFrItz7oewmdmRJAYOXDnu94dynrhbvU/u+49YA9XCq2IkyZD3SEE3Ro+/XBiIhVsgUvQ8mABuRXiVPjlVeUWLSyyM5c9lZWO4YYIARjaGMRZgSjkH1ewuaLDzEZyy8RrOlmLXFEoMuQP8imOcbusrNrhDUftiqEPVqTRfEJWarXQ+th8Bw4eifPenRLSScMhwPvu5EBM1mHybFtmgO3OOqVjptdZ24YUjPDJ2Z1PrsBBKcNDy2q0A936SyraUvIuHUS1598BgRJ+n/GoBlB0Xb+xDPPPCXb0x6VZ4lGn+2KylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fns7vHhTNw0Yois9nPhia4cGOxAlxUkAeByIM4Ln0oE=;
 b=MCMwWfNkT0WX3Us++MIwFwjeS7elDYQxWZck7mP0IFWh1MCr77v6rhsDSB5QScV1De00Uqugpf9vrBg0Yvt6LpkbNIgHNPPEZDKAo2RQjo82F+XQedYpMFNUVBLE1NQMVYU+fYW4tnIbieuoaLH5ywiBmiBsvWg1gq1JFkLxo0aIEhxUUyJH6DxZiROn77ePS/vXakIccj85TOlNZBgXiTfvm2nI/PO1u0MNpJeFVObjNS+NGfZnuciKknHlCg8he88eq+6OSmBFFtM4MgS+sMpOst9DJrf/hfCApfjYRZlQGAolEGx7k6wukTprhbz+PktK8dowxl7DrJtyxzKrBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fns7vHhTNw0Yois9nPhia4cGOxAlxUkAeByIM4Ln0oE=;
 b=VMGAT83Mc4HZjkCrw3g6kbPZfxRemXCdHjfC1qpSFn9GIrFfQ7ahi4c3a0i2tHeuBxzivXxzjd6T6AYsQoVU4DFdjWOvKfhPps9ONc5BWfEFhaHlMEXLk+6vFSZ5UhRVTAoEvqFDk2Bhefwz3OzKyH3ti7wWKYt3gyar9gDsPcfC+lfBf8J/4SS/4W6e5i1SfNfkwIuHpAHwgyYGbMW2DYgF8o5QjMzUuusEDeGiEkwloDqFxa5f3t2Bg8gSyZ08PlmkZGHX3eJZVI0ljneTHYPwRvFZvTOacuHtV+j5OveoQT4FyLXjXHB/IdPi9+oc4qBn11md8z7ym6cYH+gimg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8992.eurprd04.prod.outlook.com (2603:10a6:102:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 12:59:50 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 19 Aug 2025
 12:59:49 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v4 net-next 14/15] net: enetc: don't update sync packet checksum if checksum offload is used
Date: Tue, 19 Aug 2025 20:36:19 +0800
Message-Id: <20250819123620.916637-15-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819123620.916637-1-wei.fang@nxp.com>
References: <20250819123620.916637-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a13fbd8-7258-4afb-2892-08dddf2047df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O7CyrmVIlifZKj1zQLXoWFlCxN1JrR92JkeX40ihjVh5ZWgjR4zStTg6Qw+E?=
 =?us-ascii?Q?lmJp4z8h2qPVrwjfcLkya6J+bToDX11gTf7dowaid22fZx2JDx2gUjLoaxPH?=
 =?us-ascii?Q?6wZYjKAiWNAPEQr3uxmMj4qiqKImy89j5a24u5SgTzfPFKWf//n2CB3zyowV?=
 =?us-ascii?Q?PRpjGnGutMlslnKrK+NvoVHRLsazni1yi/5aQir5LCExv6cfasB+aIZSgPVY?=
 =?us-ascii?Q?mYQvl1IDykWE6UjXQzGfRJUEraA3Qytnfp7kaDVwxPyz2+h192PlYaxTr6m5?=
 =?us-ascii?Q?k7wy+Yp6TrBqo/Imag5mZ+Q4pNsOe1E4TuC+12L3JPTqf0deeByfUf4ckkzY?=
 =?us-ascii?Q?D5R9W6b1NgXC9+X76epDryrw3OIbPx5kAoZbw7vbfVf1CJUoebfOQubtLW/p?=
 =?us-ascii?Q?LrA2ew5t5jKEveHKAoNl5VdDOVNVvoKJw+OW12aAxzdql7jBs64TYK5+L1yq?=
 =?us-ascii?Q?mec/C5HMD9f+D1fSSa7C54UMCIB54eG7J8RXmdMscqBEHfVIU4/hw4dxfXiP?=
 =?us-ascii?Q?+a82hR1r1h/87MLpDikp3uaunO4wMtuzkM38dKJB7m2FDoj28T7RY/ThDTCE?=
 =?us-ascii?Q?0GE9DQhMOassGvC8OBSZRGrvDVKOwRMvN6X+yxg0J8MSsNcA5RINfV99Iq/T?=
 =?us-ascii?Q?7lrW9yhWzp0PfYjWElHIRZnO/yV8E+aXva+0vpSY4tBAQCO8V8stl0Ll4NwA?=
 =?us-ascii?Q?vLgyOwIKA+GFdzdluWA8d1p+vMJ27O16cnj0A2kqumoQKOFbCT91D/UQebkl?=
 =?us-ascii?Q?bNZPZyHCzLRcYOkR1EIAKzN2VNVSb113BIDR4dw2+8LaMGjYHN899+Xz4qU1?=
 =?us-ascii?Q?aWNK5wVvNTBrdCfxNdKpsEOVu9cV9v55gpBG6LheQxKohmkX7hczQN0A53gV?=
 =?us-ascii?Q?vWCC40j6We+r9KjQ3m44/J2P8h1uEpEW8PuiHkSgzD49fvl7HcNtAHIyfj7q?=
 =?us-ascii?Q?jUdotM5IM6SUP+2cd5G5cUk0hT4w9MmEXv7t53mSr3zvfZ8NQLMY6MxmcWcD?=
 =?us-ascii?Q?a6b+QNaNrMNMMdbyA//90FouTO2W/ZvXJLQpSfuftIlAMgYU5gfuwnvItb6v?=
 =?us-ascii?Q?/P60HQFgwkx2z70I+WdN0YpECRovGigckCqf92KL0a67Gl1VtnoZcTNjakQo?=
 =?us-ascii?Q?DW123cewktUiWeEGaK1KELJfk9ijZEHmxaQo33N1JSI/0gVyWgvkso2oBSjE?=
 =?us-ascii?Q?VR12jATGWdX/wG/axhxv5EGdIQUXziYAg88XU64em247lgQgB3RUIVSIkDLH?=
 =?us-ascii?Q?YZSfvowVk4Xvtevs360Az0wXv38KMDF3ItNjO0NfmrJS9bvee0C7JdZVFgzv?=
 =?us-ascii?Q?tcUYP+ge6vIPqwwGkjFBWNfsk2bUkJzQtxr1pF6N7Nvc1EwCTRfzwMnrS8Li?=
 =?us-ascii?Q?APlsorn14T53pVmDAl8ykFGySyW52Utw8gNOpMAQP0A9BRC6mddlHR24JF6s?=
 =?us-ascii?Q?H/dXtQ8LZGrf9cUJeb8qbe/7PjjaNh07xqBgwY3+88SW+cfIG6shrK8WRYSZ?=
 =?us-ascii?Q?qqTSWWf7z1+HntI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q8CR7a232bY7wu4tJ8zMFEIgt/49RzTy5K7QlZ7yMGCApyDRa5ueDos/JTtI?=
 =?us-ascii?Q?FRIJn5Uk8LlkkL0yrUiuD5pvNPq7LTy3QnfnG8pyCSoJRkkqB187Nf08INCT?=
 =?us-ascii?Q?m6CPRzzgUPGIKM4I0qxS+sajnhSsmcD8S1DH/c/bGiefn5Xm5vu7kI/DL5lt?=
 =?us-ascii?Q?5P6dPHGiP+W/uu6r6+RQVIMQoE/nggZjJeUYdsDF0wRn8bMXzupPgKQT8DgD?=
 =?us-ascii?Q?sZaWhgmkusZpdKDjtacjI1eeEn4StLaHvYElm9Qi+W+BX+NwOXKc0+ji6twv?=
 =?us-ascii?Q?zNsK/Yz0BTtG4WxzOom0T6UjsK+la0dWmFtH9UcwviymaTZb4GBBSJhYsKRG?=
 =?us-ascii?Q?pGBseMVMcxcYgENEU1q3SFomHEMqpiKUQHSLiWHppSRIwIE/EczcgxFQJRnh?=
 =?us-ascii?Q?6LFFLNRXq/ZeluftzF6t710Fpc9tb225RHwpZp4XwzAoTmCT3jwxbrmIC26o?=
 =?us-ascii?Q?zyATX16p4tIdmuwhBw3LA/QyWoZpXnqiE6F60I1jYM/lu2+3SUZRcewwfmOo?=
 =?us-ascii?Q?E2hQlNs5XuWGWpOG7XyKQuJohlbwxx3NV1TQGjdwg24E2qT42y6OwkYWKOzg?=
 =?us-ascii?Q?5SLlwr+jzDcAUXishx/AjodG8lr3S1KhiybRi0FOKODe/MiIw8kZL9YuBtbd?=
 =?us-ascii?Q?PF6gtYIss6zvUKix2INssUmlc3yBOc7Zu2uzadnrX1tUOECQfVLGcojia7zr?=
 =?us-ascii?Q?9Ypw8Ns7IV4yoSjgyK5H5tYMng4ybZ1UYDz5NpCDe+cctRh55T+qkX4p4WAe?=
 =?us-ascii?Q?DaR9GytPg2xTycFU+BQX8dl9ke3x7IDNIu31C+sQfrfeXSel6dvXuDn05+Ao?=
 =?us-ascii?Q?i0fedyHs3lDzZWswlfO3FoMZy4iulqaTowtiWIzKECRiRqqePIQEpoxUJC4y?=
 =?us-ascii?Q?leM+1WnFOEsHML/6daUk8CwQ/sSbLyrUDn9qPQMuodtSI+EWGJgG2pR8CgFn?=
 =?us-ascii?Q?CW418tUeMQMy9J1kfzSj7QitJ1kMJWB2JWPJDHVU35FOsQQ7Fs21kj65DE4K?=
 =?us-ascii?Q?1okImEjvb2aWhFFqAxM/lqt9XieL9NF9oyGm8+DwmdfoS8JfrT5UuLafIqMA?=
 =?us-ascii?Q?vdC8F5JQAen9KDCRI4bcazjukVISfZ//hYLmMFzVHEDYzsXNxML4Bh4ELmt8?=
 =?us-ascii?Q?cGQOyVnpwNOpzjlii7/V6TCFUpxdYVcVt1SF0FFxtfG+R19MXNbkuzdaHb7/?=
 =?us-ascii?Q?+lQ0jNROu8rRwohv3Lv8oBVqyCM/PyatqzlXO4lon7IwWdEp7F7eBLYWiBkc?=
 =?us-ascii?Q?40jGF4BxdCoO8zcUEC/Ax/q/47TthAKyJ5p6VmRABxkQztqzoaoVBw0067Wu?=
 =?us-ascii?Q?gYRAmHjBg1qTvOtLJPSTG0MUxrKvyasNCPoyQaZ1PUHMyXGbgx00/XTx0QGT?=
 =?us-ascii?Q?SLPdg8ULReXjn47KMb7dTfpCSK3clrqey0KFrfQhXNCpbEGuDggIX1G9tMTI?=
 =?us-ascii?Q?a7vELsCiB+JEyLuIb8N7EvuLdedSIFuvGI7pcVkEgeeeZ4v9hGAGhQU6XsLK?=
 =?us-ascii?Q?wZ/72S5H0mymFxRw9CqnGLtYXkAIMIdaH0KS9RKj72i2JSGwGXKB/Z6+qFaG?=
 =?us-ascii?Q?kSBMvnig5XaQsWJXyS8FLMBl7LNe9y8ot8qZ6Prw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a13fbd8-7258-4afb-2892-08dddf2047df
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 12:59:49.6888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZciruKf2b7NjcLRiEq5t1zz1Z9vKzJTGQCTMHtTC0Rhh+4Lub88RrncAT/NeccwG5lfLdBhvoVGkxgAWPst0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8992

For ENETC v4, the hardware has the capability to support Tx checksum
offload. so the enetc driver does not need to update the UDP checksum
of PTP sync packets if Tx checksum offload is enabled.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v3: no changes, just collect Reviewed-by tag
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 6dbc9cc811a0..aae462a0cf5a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -247,7 +247,7 @@ static void enetc4_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
 }
 
 static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
-				     struct sk_buff *skb)
+				     struct sk_buff *skb, bool csum_offload)
 {
 	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
 	u16 tstamp_off = enetc_cb->origin_tstamp_off;
@@ -269,18 +269,17 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 	 * - 48 bits seconds field
 	 * - 32 bits nanseconds field
 	 *
-	 * In addition, the UDP checksum needs to be updated
-	 * by software after updating originTimestamp field,
-	 * otherwise the hardware will calculate the wrong
-	 * checksum when updating the correction field and
-	 * update it to the packet.
+	 * In addition, if csum_offload is false, the UDP checksum needs
+	 * to be updated by software after updating originTimestamp field,
+	 * otherwise the hardware will calculate the wrong checksum when
+	 * updating the correction field and update it to the packet.
 	 */
 
 	data = skb_mac_header(skb);
 	new_sec_h = htons((sec >> 32) & 0xffff);
 	new_sec_l = htonl(sec & 0xffffffff);
 	new_nsec = htonl(nsec);
-	if (enetc_cb->udp) {
+	if (enetc_cb->udp && !csum_offload) {
 		struct udphdr *uh = udp_hdr(skb);
 		__be32 old_sec_l, old_nsec;
 		__be16 old_sec_h;
@@ -319,6 +318,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	struct enetc_tx_swbd *tx_swbd;
 	int len = skb_headlen(skb);
 	union enetc_tx_bd temp_bd;
+	bool csum_offload = false;
 	union enetc_tx_bd *txbd;
 	int i, count = 0;
 	skb_frag_t *frag;
@@ -345,6 +345,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 				temp_bd.l4_aux = FIELD_PREP(ENETC_TX_BD_L4T,
 							    ENETC_TXBD_L4T_UDP);
 			flags |= ENETC_TXBD_FLAGS_CSUM_LSO | ENETC_TXBD_FLAGS_L4CS;
+			csum_offload = true;
 		} else if (skb_checksum_help(skb)) {
 			return 0;
 		}
@@ -352,7 +353,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 
 	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
 		do_onestep_tstamp = true;
-		tstamp = enetc_update_ptp_sync_msg(priv, skb);
+		tstamp = enetc_update_ptp_sync_msg(priv, skb, csum_offload);
 	} else if (enetc_cb->flag & ENETC_F_TX_TSTAMP) {
 		do_twostep_tstamp = true;
 	}
-- 
2.34.1


