Return-Path: <netdev+bounces-139830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A849B9B457D
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 10:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F9C1F22E51
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 09:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E261E0DA9;
	Tue, 29 Oct 2024 09:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j50kJLm5"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C9718FDBC;
	Tue, 29 Oct 2024 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730193555; cv=fail; b=WEF6VJ79wXmW2qKbtq42Z4X9YgArC+NGekbyDBw5lKqXT5gaAKsr0Mn411/TcvaGPpeX37RQgIXLZ9wAW1kRS8XE1KJMoYO11aScfrVXuaUzqegU2bxkpafhGdWTv2cnn0fYpPF0b54P4QcMeB09BxTjfbYCGj308Rd1Z6CYb2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730193555; c=relaxed/simple;
	bh=vXgipNSSz/OST9DZqCro/ViqJm5FIupoIF+e02kDDAM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sfuYqPF04ZWknhsZSnIFn+HSLIhQG6YT1x6ys8lLTbvYnnsHLegK/TtzBxo+jHXhJpShW/GC0H/j7fB0L5O8ivm5+MD5KCE1TQ1gQyzXMpradDU4YGNm6c6gx7aAfjzYnIIatMbpNDmT+d0j6QbQx8hAYdTZSgmXJW6IPN/DqsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j50kJLm5; arc=fail smtp.client-ip=40.107.20.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8kmmAf5GLRB4ph9RGXKj6BGMhJdCOLm+3AHrRZSrjbu+quMRA7nHr3q/gQIC6OikORQ9SwyAlwgQ9/mpuDh4Ckta3iYvkV0H8t+PmmLhEWFNqKjPYlktFjBfI9/1M9Ld9PiDFjw12G90Bewxm2gNCUBOMgQKghqAdkVgLOKUHCApFhuxm5j1tDh2Z7Fiebonw1juClz1hEvvi/aYxDngRN8IH7GjrDFBgJMost2NZ/sUHDI0K5yJbt/Pee5Sa4Irsr8iBogCadDBCLonh5wrMLh0GrJIvq6flzOnHNnACzhDGPI0A3/k/Zzkygw8kABkmB/2G5YcCXJ8nq/fvKxhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8q9M/gXiSbRS0ll4fcer1vDPVDFaxVhRabq849YTYOs=;
 b=bauBvxCliDjtFCwcZNZ8Alev2+Qgg3R303brdxGFSC3QOvNK37mgQjg2cUguZ1CJGTU+Wf3mGWTFh3PFWLYT/YVX7fCLGgv1gh9soBQFU6rjIAC+8rK4QE27y7f8U5U7CPI+QtpQtxtZ/8GondbEj3FN1srQvbiIINjNkn9P1kNMhTc9zrNkg1aX+Yn6HWWR68PXkRIulFWfjbFGQXIdgIMkGVmlv1Dkiig/hP9gY0YJpOl1GMb5ko8QNJtk+q42PFXceFlFB6ehWJKYgwNmXBMWyriHOdQ7/tpRJ7B0++6qBYO/koVI+5LXB+GSVC5Xa1PvyEoevATNlYpGKGXBtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8q9M/gXiSbRS0ll4fcer1vDPVDFaxVhRabq849YTYOs=;
 b=j50kJLm5E1cDzICsxKpqzLwnE8jVFQOGpPTtvQRsqcImz6UMeBMv6UwRpGTZRb8C3bn572Sre3cWMCdDIcrzL5iid1A/GpIxrLbrC6sMVXWzn1CYubAOITVJFtgx5zfr9tow1G5FPybvhBUUdRqVq8nPdgH3m6it85g1zu7pKkz0CT2AI36rUEhUgZ0DtxKRY9PLxqQM99+FKfAy0FEj+aG04//c11NzVkE5vTcDmt60Bwx1ztFLMwyRaMdJzEYCkPbduzmIRvkisnhvR5T3kzHyHni+MVOcN7rULmwhmWM13DhyxdDSPZK7jpdpc87oY4xYXG1IxJjW729kyyougA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8662.eurprd04.prod.outlook.com (2603:10a6:10:2dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29; Tue, 29 Oct
 2024 09:19:10 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 09:19:09 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net] net: enetc: set MAC address to the VF net_device
Date: Tue, 29 Oct 2024 17:04:06 +0800
Message-Id: <20241029090406.841836-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU2PR04MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff24ef4-79c5-4725-6b89-08dcf7fabee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?socKcnhgHUYj2GPzXqN4ky1vdOmDcdGMXv57g+e6axpChEgdVrsCbQkvrO7B?=
 =?us-ascii?Q?dDqfic2uK6CRIFkn6dFIRBuPEjfb0786i3AlC9tfFg8Kz9n7/SbKzO7NkFuX?=
 =?us-ascii?Q?qVtEMuZThSenl5xyZEtB8uF/Lpv5OuiItdSRFGjUn2qhGURDGUtpb1K8Fm4/?=
 =?us-ascii?Q?LOo1ZHDoeYADX3nuxQJSDWJ+r8PBNv5XAw+9u6ARNVdmVw5dxciKovAgUZ+c?=
 =?us-ascii?Q?buWUhO0JbcIWP3T1tuR4aVLyjsxwy6+SvrgCFgkye/cgfn0lttAtqTko5XMh?=
 =?us-ascii?Q?rGQYuPZC++Kk6QolZUQxaoM+tf5fONmzwlVWZJgSqWfwABqg3Zd5ioKzF1rt?=
 =?us-ascii?Q?lX/IQ8Noaex6GV7hpEqevKqxQnhQrBtWXIHjzoI2mg2+l2Nc+q894sPfwj4Q?=
 =?us-ascii?Q?Rv6CuZ+wi+Egds+qu6D/RLrwnKeInwjZcgdEkAJ2fTfe45lMUDPtGttwR3ns?=
 =?us-ascii?Q?DiIcpWdHV7Pl7Dd5KYs+X52jUAgCof+Klx5Ch9OBX4/5EwMAV78ZtMuO5jw8?=
 =?us-ascii?Q?9yyWbrcueqARjldzgXEqRKXFQw/0uXzJ6WavB1ndPad5/XVZj7uY2XteeLKp?=
 =?us-ascii?Q?SXVqyalmTE8owJUrRGyh+Zve4210GPmb+0+GTaAsttuqqnXveufg92bNc4ZR?=
 =?us-ascii?Q?/8r3cheIStYF6YKbfxXi8HWv1tmYMj2WQgPJnuqH8JV96/ZikOO9bLunVmsm?=
 =?us-ascii?Q?/zvsh6CFL3U9HGGFt7eKrnGAY1DwxYrSWqt7/6M2DUZG5CJtunRXSWd5ox+t?=
 =?us-ascii?Q?unEE/aiPKtdThLOWGsdes2hKj0b/2JoK61tOtv2uybs3zsa++ZXFBnIaEpQC?=
 =?us-ascii?Q?NIJbLlWpMkaOP0alXP6WlNf4Z02DTSIyxEgV0Ja8wePJEnhLTsVov8p+nLdw?=
 =?us-ascii?Q?CWs9v2NDhwuuUZY3zCV9MX9xdwiTAUxcZQyhxeSFGP7uYJPa0Bdn2ecFcnE8?=
 =?us-ascii?Q?T9f/OdCbLcQ5nw1Cpst6eslyVCwHMJ5Y99AWAnyoU0mJSpVDrDbYydqdIMGk?=
 =?us-ascii?Q?gX4e0U6Z8Mksse/DBJzG2yMtIPMDFnAGhQRC6w1qiXFItQad+SuGKMNHoIXe?=
 =?us-ascii?Q?8xY/oDi5APV1uKBgwKcMS+8piQTqOD6lGFv0I+HWYo6YMEsmYtELI4DxF4JM?=
 =?us-ascii?Q?unYk7znKJI1IWDLAF1AnBIYG0kkCYFmspeRiiZGv96ouPxPUKvojq/6Els6D?=
 =?us-ascii?Q?xlNv8wiOq5u/JQOBNL32Oqwae4fKjeUlYR76yqS/seFy1oMkqxri06wbhWzZ?=
 =?us-ascii?Q?/WcjawU9oP0jVNanbUkNCtUdJxsVRuie7Jt+2fncKTsaNtOKr6yddLf3QLCW?=
 =?us-ascii?Q?htRgCfZomiUKGkWICP+xskPJQ+r1Ku2h0Ho1mEm/bOYMaLWI+IdGbDSvpq+H?=
 =?us-ascii?Q?q7625drbwym6SpR0uYbclDBZQn1W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RS8XbBIOc6sgx2YWcAslVtVmj6Wx+1itEvKwN8cJW80r/+J4gJfbmITCz64P?=
 =?us-ascii?Q?ECcXLb0b743LVnFhzUW613I1IOzT5t3evxCTCCmHcB9Ab1wM1qKkYWiVTW35?=
 =?us-ascii?Q?RUpdpXc94Au/r+9q5l2TFEioTrOq1L+fquQzpFnUfX4HC+jA16MUSQqtxmy0?=
 =?us-ascii?Q?LDPEwfGgu0aRtezY7/IBR+WK70FcgT4jIYZEsjzgBLnnO+ejcvDYyXx8Cwu7?=
 =?us-ascii?Q?enSLnh6kW/37im+xPbjtO5gX/eqY1ah2tlN4qylj4UMnxJU3TTB+yK94TxqX?=
 =?us-ascii?Q?XoobhN8scteozDQjR3D3whoFEAoUW3r5gAjy+zfCh8wt5RFtWI9u3woj8t0V?=
 =?us-ascii?Q?2VRt1QI9Owwd/6XwxDP/syrTr8SyrwuJPqESrQm/ZsD2IB86hHslzANsHeCm?=
 =?us-ascii?Q?wxGOY+JOcbJW+g5LbrftZvuwBXeDTzS2W1qTOGmyKsgyfBVKezFH8qB3FhPk?=
 =?us-ascii?Q?3iDJGGkRvb+ctUwq/NP6wDJsWiDcUhZpm4K4RGIG0EZkrDbjS7DRUGbucWlG?=
 =?us-ascii?Q?IcxX1YYIu0wjL994q+2ac/agQLSdbckNMl1JHYPrrP0OraFB8rV61m3U425s?=
 =?us-ascii?Q?XWjlxzSXxR7RW7gkdQPuGge07PmOLM/SVgx8LkMV3kD/I0xg3FrChOka065N?=
 =?us-ascii?Q?L28+5tp7+A4G3h/qsM8KbOjl2GPKZZUssPg/OEStLVH28mfRHyYfiNnjlyr1?=
 =?us-ascii?Q?I/RAbjGDY9e0a1JhQl4L1hUDhcx8gb7WLd2VmMMO6yI8xuT6pr0JasCPPQdv?=
 =?us-ascii?Q?AgmrNE/GOVzS6VjMVyn5FzTZP1hSoyVegEvAOCQvRWbremp8InUzUK7NitpZ?=
 =?us-ascii?Q?RZ1oXuWVvFfWpS8NQabims3QfiEd7pntGH59q7pbQwaslz+zowkTmYx40uG3?=
 =?us-ascii?Q?uD/aDgRa8MxVtD6th7731shNVlF9qUeCwS9thBnKFuPJh9ljKUGYLAfynl5B?=
 =?us-ascii?Q?MC3URckhtgXVrUJ0jixUpn8bckS7PJQiS6V8eEiHNn6CmUZLCJDy+zjSERem?=
 =?us-ascii?Q?FGCG7+yzoT3vyGbZ0LCGMgxDlo7EaeX7KzSsnhvGatJtH/rZJgS4QQV+XLKR?=
 =?us-ascii?Q?MS+QoWa2DAr2Fhyu1FMcJX2Z0usrLfQCOhplCac6HCC3F19d+diJkIGUg+Ur?=
 =?us-ascii?Q?OegqfogDHITGE7hcFsTWQpEzI1ey67lbcrjoUa5utfrLlfuSaWaJXmgplXPM?=
 =?us-ascii?Q?N8JP2UxXnSa1esVrEyfMrEjPrgYtEDNxPS2knE93DyxqZPqiLx4fFxqUgzyI?=
 =?us-ascii?Q?lTe69Dxs5c575xPugRRzhXphXMH8PCtb/NbWLBEfQ5U29GPbYDIxQl7BDr8o?=
 =?us-ascii?Q?0jn9hh3QY6SqoU7Vb3XoNm3rstWBHyV08RU3baeMphVxVP9gjLcI00m6zUzW?=
 =?us-ascii?Q?SVvcG7Iy8qJPtZhQ32kyXFHYApJUblt+EsQpGvtfd67mlkpntAlqkQzym1Pt?=
 =?us-ascii?Q?M2a7a0eCi3DGkZsyWN+cKmZuHsXoiYPBa5fxnpU4YPgaDK9NuaS55hBmrplF?=
 =?us-ascii?Q?hogsQZtZJHyrgr84vleS04+t8Gspvl7xAIHX/+LqAQEEUzVnG4x1lGRsQgu5?=
 =?us-ascii?Q?7+iSbtTGSx8cFc4Aqk7uKwbhlIDf1Wt+5tpHwVcy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff24ef4-79c5-4725-6b89-08dcf7fabee3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 09:19:09.8683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yh4z13tMJILpBbgbS/yOX++tnE7s2X8f6BMNa7q4X61BYZEAUnCQZ0uhsCDbTJiSojGu+IwbqBWpcluj5b9dYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8662

The MAC address of VF can be configured through the mailbox mechanism of
ENETC, but the previous implementation forgot to set the MAC address in
net_device, resulting in the SMAC of the sent frames still being the old
MAC address. Since the MAC address in the hardware has been changed, Rx
cannot receive frames with the DMAC address as the new MAC address. The
most obvious phenomenon is that after changing the MAC address, we can
see that the MAC address of eno0vf0 has not changed through the "ifconfig
eno0vf0" command and the IP address cannot be obtained .

root@ls1028ardb:~# ifconfig eno0vf0 down
root@ls1028ardb:~# ifconfig eno0vf0 hw ether 00:04:9f:3a:4d:56 up
root@ls1028ardb:~# ifconfig eno0vf0
eno0vf0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        ether 66:36:2c:3b:87:76  txqueuelen 1000  (Ethernet)
        RX packets 794  bytes 69239 (69.2 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 11  bytes 2226 (2.2 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v1 Link: https://lore.kernel.org/imx/20241028085242.710250-1-wei.fang@nxp.com/
v2 changes:
1. Fix a typo in the commit message
2. Add Reviewed-by tags
---
 drivers/net/ethernet/freescale/enetc/enetc_vf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index dfcaac302e24..b15db70769e5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -78,11 +78,18 @@ static int enetc_vf_set_mac_addr(struct net_device *ndev, void *addr)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct sockaddr *saddr = addr;
+	int err;
 
 	if (!is_valid_ether_addr(saddr->sa_data))
 		return -EADDRNOTAVAIL;
 
-	return enetc_msg_vsi_set_primary_mac_addr(priv, saddr);
+	err = enetc_msg_vsi_set_primary_mac_addr(priv, saddr);
+	if (err)
+		return err;
+
+	eth_hw_addr_set(ndev, saddr->sa_data);
+
+	return 0;
 }
 
 static int enetc_vf_set_features(struct net_device *ndev,
-- 
2.34.1


