Return-Path: <netdev+bounces-218115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1C4B3B27D
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 07:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945233BB25B
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 05:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182AD241674;
	Fri, 29 Aug 2025 05:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cBLcsfNv"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011029.outbound.protection.outlook.com [40.107.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4383423F40C;
	Fri, 29 Aug 2025 05:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756445282; cv=fail; b=Kt/DUWVvs14Fpmv8OVAsxZYm9ES9k2pJ1PzQWAMHfvG9HIVVSJk3eBemXb+mEBstxvhK3jiEd7ljy29eMrCRmX38R01h+kqX6RfsKbdUO1XpntbCsBp0Cr2ajqwl0mgwF8TU9QByl86r/zZPnRi+3E5JxPN+dBrZCkMyDD8YVCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756445282; c=relaxed/simple;
	bh=38Z0yxZBhs5yWyuG92ncgFhx4bDoz40jUTfEhxUUN84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=okJzvMi+W74cN3VMzuvmCLl6wi2ZVYzV0Nxw0vigauoT9oCtO5aL8CQ66XDyu8KsVhKzDVefR7t5ACFuUYMk+oOUq5vJwdFD6BQdcmzMV106DCouzvnukTio9YbAySeo+4tci8Rm3DQaqHvomOwpa2CoipZv/hr+K7u4/pwSW+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cBLcsfNv; arc=fail smtp.client-ip=40.107.130.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSUbiQg3GesjrwScyURBKASQaTT5LvmBCFJFXK6F8fUSBK+x8Dn3E9g0GeaSdNWk1ygXkzcmwNMPAHHmG5RiVpf+lYUw2cKf1XJfcVWpwwXpr/hemYeW633rejYDwjtkBkGcA0+Fr0QwRBAjPWGbX+b7CRVoN+YXr535U5cg2yZdy/UVzT9dF3i40u+b4Ge/GVw3eaONg7lX8WB0zl+bogbQ4hbhC3lhUKh4Z+8Ccgl5V5lmk2WkND+4Uzkv+WXGmRqD3NeAvO+yCFD0FjSZuxkOwaiWjQifhb1233UXK8osRM+JAjxLmDOroma4K31l+SBVHv+EOXbey3OAXChbog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yt6KRkf0gXwfOGivmY7luvsu/hENg3cVSlJV+2SoKOU=;
 b=AV1SSoMAznNnZsUWaNnDCR43LT86oH+CIterrETwu61UPBNgHybyMV0jbupeDCx4iLWuh/T2IgAIX13XuBRQm3o7fSxEIZT+kQK0gIco5coE2UGKVhfoS09jhoul7WfGI7ShDTW+EujsmV4metc6k78mKlDrjSu/6gl5lz3U7qQzRcI3GIU4lXaAWqNmp+soTGBkXUpniYyDL2jNPWP+uJQ0VYfWO0F0rLd5xQIbmaFXA3yqz1TIi452aTf8M7zH0AWOkoBqdh3S4mnCqa1EeCOuvSMiETuoi/0SkByiGVtRZAzgUQxtQba0JTM0qNqKOaiPbrhaPnOM5hpwAv7sug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yt6KRkf0gXwfOGivmY7luvsu/hENg3cVSlJV+2SoKOU=;
 b=cBLcsfNvA/BWR6lBcGyppYKNbuxGzoatULUo5UpQQXAvBM0MfT8OC4uInmrwbvCb0a9jbXpIOniazXH9FscmBU0RKuLE5h9cT9890huHr33NqWFsM7/WEYuVd4aSvax9uDOkQDmIqqRVZRXq6/+wHNjIrwdW/Jm/4KNGmzQZ8O6X5fEKWWWA772rhbo6ylkoFC+z/SSYkG3Krvk+Ck0LFsHj9cpwTEJPASQHhAadRrRWqsUAJEJ/9w4ZyXicQWzCxrnrvgi5LCMkUY0zQ99kBdll43JTdaTZZga1Hs615FHADjk1oKEpKDtNU8HqZn4vEpj4CW9kWpYFPN0KeDeZjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB6828.eurprd04.prod.outlook.com (2603:10a6:10:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Fri, 29 Aug
 2025 05:27:57 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 05:27:57 +0000
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
	shawnguo@kernel.org
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v7 net-next 08/14] MAINTAINERS: add NETC Timer PTP clock driver section
Date: Fri, 29 Aug 2025 13:06:09 +0800
Message-Id: <20250829050615.1247468-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829050615.1247468-1-wei.fang@nxp.com>
References: <20250829050615.1247468-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB8PR04MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: d35b668d-51f2-4550-df9d-08dde6bccfeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?87qre5gCG2sjfyG7mLMQrHC6qoGPy02E4Lm+1uVodEG2t66tSO4gfCXZ90Bq?=
 =?us-ascii?Q?4fCnoOfaLJOpjeGPMur8Ty6CQQ2rajUAeA+eGci6IPmOTIuI9HEGnLdHTTxb?=
 =?us-ascii?Q?Mr8807ymb1Peov5Hfwk1PcAkZhKg8HysVFZWxfJGQ/Ibi62k06rPdSz8lacd?=
 =?us-ascii?Q?k/rPy7x1+YOfMTMiXeijvZ+kBEtmo38EieoW2sH1aasy6hC7xIVG7GGsFUf7?=
 =?us-ascii?Q?oPlbptCMsppx8CzwGxNVJE2q3PuY7sLz+wgkcv4aVhahQ8wMVFKoy76AyPyJ?=
 =?us-ascii?Q?opUQJ4FofHPSo4d1QTr1+9xYov/npvuO1tPvxfwAYWNjyMBzhrKI+sBE3YH9?=
 =?us-ascii?Q?S1JY8OzqtCvCZeVyioru5Itzvu3ZB2FEfYmZHgBcuA+kUdtYt12bMuguAgv/?=
 =?us-ascii?Q?ZuCH5XMdyZpKjmrDSQixw1Jp4F4sml5bnMqmNJ38j/7ilQkoyCnNTBk/TvzM?=
 =?us-ascii?Q?WEwzLIQSAMAkuyyb1EZA5srjp56NUHa1+i3kL2iLeGCztYNyYFL/MXnGHtSb?=
 =?us-ascii?Q?VXXkgpxgw991iY1ZRHs4PaHxU3Dce8XGBYXJPILsDQC5oJFwg27D8smxS0JX?=
 =?us-ascii?Q?RevnkDzB9CECSmW+633Xd3iXbNEiqLCHjtymzIu2TEc8kJxbJCeYNg/BpTJL?=
 =?us-ascii?Q?6s4r1kf6ty39noZRNW9H70RFzby+W3Ic33yT+dXeWIMdjmnvI+9ypufdH8bx?=
 =?us-ascii?Q?VxGmInheCVTqm9zUknmvGk3O+K6DkfNE2V2lG4ank206FByPDRDR6m11k73A?=
 =?us-ascii?Q?RZF8uz1asSfnZtWTH4L+yk3T7tHNGruhXpvZkx2KWJ46wBbn+nkWHwstGMbN?=
 =?us-ascii?Q?y3EVDCEl71tisFqN1pUEZmWV2LLQiU6xkSv1rc+YHwBvD+dbeTcS9AHcsE8U?=
 =?us-ascii?Q?spAiBNNwda4b3LU42FD1QxCKNsy49TBO81Q370u4i1yfypcD4zoZ1+PUMJA5?=
 =?us-ascii?Q?8VWXMPb6axUrWeYXWJjbD+w4NTY6Z3oD0jS5PXH2uNbbeCi2DT9ZP2Dy917/?=
 =?us-ascii?Q?5HsJYuzTBZ5OE4spJFurhccz8pPQPKTwF1Ir97MSNoi/VeaiMvAIJU0z1ix4?=
 =?us-ascii?Q?m8Ns8P7PWJyEng+b6b5K4efdUYXGZVeDcJcMBh92tQKIjvswsJ6E4ONDgqUV?=
 =?us-ascii?Q?ZWbf3Qwk1wcuVZzRvTirEnJ0UNz2jsWS/ZVLeDVOFbphIEIzDMk2ebqxrfe6?=
 =?us-ascii?Q?cC0YVz/1krOwkRMmzCaIaw/Ma2jSw7mhjSCrAzKmlmyu2yOpsD+TadgldkHL?=
 =?us-ascii?Q?mdGkiBMYm92qeUfd0/YQeijaM4EYixnVxyGSV9IuQTFSfbd9YZg/2TbM338e?=
 =?us-ascii?Q?U3x5u9XLv9fQoQggd2iMUtEBGVDg6Y7lP5Gj3hkI2Nx2EjBdVdHRWM4RGxTL?=
 =?us-ascii?Q?9/1u/NPY28Py47pNtjP+e8Zlx9xGCv+LpPmj99/oDapEQoLq5Y+DsJ2MCM4K?=
 =?us-ascii?Q?cgNs/p/K5W6fWMjJCoKvPQrrN7Y/hkEjS+Ejr6LhlUKJy5ME65MODQpz4sU1?=
 =?us-ascii?Q?WsZz13x656BWQHc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9TYgWZLZINJkqjQQ4UKWVP9UkkN82uZ2EWEXqE4gMJCmMK4QXMQ7xiBAoJZv?=
 =?us-ascii?Q?LZUY+TV3S4aTshBla4HllREm96pIjyKfgQ4nHB74V9UoOW5e581d5//TxEvA?=
 =?us-ascii?Q?d1/PHOYnhHBwJgfgM+KaGavtoghFgFsp3fZidLsiwrMGd46jGZKjT7/Yj42C?=
 =?us-ascii?Q?htmuh+7FShriz+IGWZVRAtoHlsyi9lTKrhRjfMd27oJ168taKyFzXSgL+ELW?=
 =?us-ascii?Q?01/1STWyTZIffT/Q5/b4O6/so/rbRvHAs8YVBzE/Nz90ZzTM5iXxJv4UoJV+?=
 =?us-ascii?Q?IMaqF1gEklrEfk1fNxyiHDIGrR2QW+LDZ+Vw182q6WI13IUhK1azLzH3SRKA?=
 =?us-ascii?Q?HNudM+UtXezWUWhTbY7Pv1QUeQ+LqV5QxqS554Bq8xLQnkIslCiD0vlSVM4p?=
 =?us-ascii?Q?F5YClXHFavEsh9iwxeMP88MC2R+8yoigzhEPV3TzXUNBGL4He+Y8xGTN0WY4?=
 =?us-ascii?Q?IlkldKDf6FdWJv+pLHRFFkkiGlL7jBx0M0ApP1MEXRPOcK9IE9HZ/BjRCU8b?=
 =?us-ascii?Q?c87FROJ933ljhCWYlETx6vA4mQMFhioa1uvm6emlz08Nd/OrF32ll0iMzxVd?=
 =?us-ascii?Q?wqQncKBZEVQv7WJ84+TtCPcB3biHCCZpZCkiGmx8I2uM+aHfj6cUNZQDoTSI?=
 =?us-ascii?Q?iyD8an+/0ES6VQLltb2hEPwloFq7Yi+/7gU7Qsc7BzbPf3mMtrCAio9xN5L/?=
 =?us-ascii?Q?0xeoh9yhPgSyuWoOURXRRSEezTi8FhlN7sw5nlXO4/jmBw88UesfxBz1yjfH?=
 =?us-ascii?Q?PAOEVcqN7v93OmsDRQPFpkH6S5yNeA2x9pADJ2ZT83+4ecpyb0SLjf371v5u?=
 =?us-ascii?Q?Rr8RZD5PMx2rI+xBdq3uLl4JKlectEcXptmPJIwy1bGeHvDp8UtS9NuxDsA4?=
 =?us-ascii?Q?Nrjbt/liQaF95hFNGahuPs8J0qVV9oCjfQah5FmR8XiZsrgn+z6qf+Shjvxk?=
 =?us-ascii?Q?Zw/Hd20c/qXy+vYzhzmvjgi+GXASZgxyhxpRjLa31Scj2JHnThGIhR1fa/M7?=
 =?us-ascii?Q?KzjUM6kqGkaH7MsiIBs7JckoKqEHpUYQkT94wtZ1PoWtYBiotG6OcRMzPV+H?=
 =?us-ascii?Q?FqaD1IEW1xZRFbGqM7POowEe9EZyYHl0DqibP0ZX4jppotGe1/UTTq23baJ2?=
 =?us-ascii?Q?AFv9Uh2cZxY88qemPhC8HQ+R6mGyxFXzBth1ps8LpjnHDXBxhKst68bYjb+9?=
 =?us-ascii?Q?ujzqMj1ZoEidyiMYAWJ9ckRWopWZAlZfP64/Ge5Uy82mcXxnnkXCOWm03/Bb?=
 =?us-ascii?Q?pFAZxnnLqcEODBELr8hInAYLuLZpe3EXKIR5jQysfyEHLFIB28wKfOqyvhbY?=
 =?us-ascii?Q?MCb/ADjQqwXgKA5Jk38JKQVy5PQLWEzODzPRJWJtwOkSL2F3/zShbQRkxHeF?=
 =?us-ascii?Q?L8OPFhHOuuNBYMwxXhn2WLDQ0bMjjBpS9d+FaZb8UlvJYlZShfcadISSnz0r?=
 =?us-ascii?Q?nbZm8DiMBZZ2HvNKjMYqIu7IVIH5nnqIKv7MB1NrfYZUs7qxeNoyPKVwBMFo?=
 =?us-ascii?Q?llTCv2TqCv7HnJGmDaZJ4zT0UBU54a9Lp2cdZuGN5ubq9T6HYIb1cN7IDTp6?=
 =?us-ascii?Q?oK1VIsg/GzMi05EuEbkSl9ohIOwDeZIqe8hCwi7q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35b668d-51f2-4550-df9d-08dde6bccfeb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:27:57.5971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7e2IOT8LaR6ZC6v2QOhqFS0bRvmvvy96zqP4+eG0S+O4p7LASXfm75oNUenSW/irbHetA0lhyQZQQeGKZrvrNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6828

Add a section entry for NXP NETC Timer PTP clock driver.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v2,v3: no changes, just collect Reviewed-by tag
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bce96dd254b8..eb33acf9e3ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18263,6 +18263,15 @@ F:	Documentation/devicetree/bindings/clock/*imx*
 F:	drivers/clk/imx/
 F:	include/dt-bindings/clock/*imx*
 
+NXP NETC TIMER PTP CLOCK DRIVER
+M:	Wei Fang <wei.fang@nxp.com>
+M:	Clark Wang <xiaoning.wang@nxp.com>
+L:	imx@lists.linux.dev
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
+F:	drivers/ptp/ptp_netc.c
+
 NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
-- 
2.34.1


