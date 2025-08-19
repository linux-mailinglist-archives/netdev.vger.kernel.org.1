Return-Path: <netdev+bounces-214951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2EAB2C462
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 14:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3D0D7AE2BE
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 12:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F095133A012;
	Tue, 19 Aug 2025 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SeM2j/Fn"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013044.outbound.protection.outlook.com [40.107.162.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC50133CEAB;
	Tue, 19 Aug 2025 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608298; cv=fail; b=WzPlVflgCDZlJxz44eCP4p4vLKBdd1jKaNMvKJNadUUXsjhVqLWF4drUXAkooUct5UxM5g+tBhio9uUeZFoWHtylFh2HgRP0OAXsEk4QskQChfCib0I3Rcj9Zd3tzpuJNsJzynNxMULXGkNIbXnPEHavEHrRprvt8b2EwXySnTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608298; c=relaxed/simple;
	bh=q7+3MSqyojLqJFsnCQCT7Jg5UBSToyJ/1TXsaPLyoA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EPgYrP3Ps2f7oYucKmGZqzuchqxy1hdLCzNjOt6oDwZV9kEEJBy+4LfkbWuqRk+tGeplACL0In8NvJ9XWGr2D87gbMJvVx9+TDbLnuH7BopZ8I8roFeDNI7l/OhYblzOBbAjS4mvIDJMXhXWQEk4tXJN/cmLJN3vbGaBL9+3ie0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SeM2j/Fn; arc=fail smtp.client-ip=40.107.162.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAGtP06WhlzXscCozy0372fFNTJ+R++n6ZXeaImrLlUsqxkdaG6hPtKY17AtHe2hg6rNT2OFPWQlA252M7OcJ5TwJYIRtSDBSIbFMR554HjJxSPZwQeNnxD/YMZMq7fmtKhl2uWrDMWG+TeqWvF61THlLMlgEiWu3z3e+GFz6Q7uNGt9SIE87SqqbuxIiwHGl2wgKfYFn+2T+Tfe1wsCkBAMwwDPSTe+BoNeOXykKEB6EoloW69x7rmeiKVWa0DQp5HyVK9lRqqh/r2l94Y5rn2yeQlVDCp7gimBq00ZZjEp6fRftA2Uem/fAxaNKCSwXjo+cf/bLf9hfHTYHzNxHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PBlNwHj+sEaXftaAKfhdOQB38MXdCN+91lSs16Gn6U=;
 b=UIL3F2fNRHap0Pi/bEYwvGT4LQX/8YtMGvqVPHxwi/9QGeFXH5Yfv4ydl7JXSZJQ+YNtpFUv3MPruOkkH3VlNNL+/swUkAzAq2ew+U88m7zndM3lHRDkPyfRpw/l6XUJyGlwVdIT8G0EHy3LdyXMSjsscN7R60Kg+3Tsu5Q/W7dsK985T/lJzLbAG9755vNiwVYg4OIghPjm7RdCg1eCFR39+ufHMPVV9pOXVIEXl5tx/UceKlRPmjrsxdtJpAo5T3DJ0na8AcM0T+IzHpN4gDrmwIFBlRUp2JfeFYJOcADuQRA3RiLBFa7ipzFr9C7l1fchUdvjvbZSRnZ2SzCENQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PBlNwHj+sEaXftaAKfhdOQB38MXdCN+91lSs16Gn6U=;
 b=SeM2j/Fn5A5QwsGC7m1Y/CowcTCL9lBPF21b5hULaraVhf5JM6K0f+4aa4rxtWrGof01qisurrfXExgLuHWwWRvSTlMC2rjd++7x3drh4POUxtuoTtbFGIYytTK6k1ER51Pncyh/3BVCPm6NjPtOXck/++kgtaReU7GTavs/3wrSPbpdWKRJ6WRwVLmqUN11RdmVgewdg1hKKlpkkKwtf6CDObuspsct0Piph645XZUGTJN7PXSkw6MeU2fdgkJnOKGsDBJ8s7nTH+p/4Ov67pqS9CUlDOCge7l5p4bA3FpwVeKotwyOnGAEUgallqLnVVOa0CLXE1ITnvv+zCjbQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DUZPR04MB9946.eurprd04.prod.outlook.com (2603:10a6:10:4db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Tue, 19 Aug
 2025 12:58:14 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 19 Aug 2025
 12:58:14 +0000
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
Subject: [PATCH v4 net-next 01/15] dt-bindings: ptp: add NETC Timer PTP clock
Date: Tue, 19 Aug 2025 20:36:06 +0800
Message-Id: <20250819123620.916637-2-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DUZPR04MB9946:EE_
X-MS-Office365-Filtering-Correlation-Id: 992598ea-ee96-4812-ac08-08dddf200ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5cZYytB6pBAII7L5Q969P/IkXh5RnzWMuZCJdsS/Z829JJqQS9PQmfxwQZOB?=
 =?us-ascii?Q?gVruOYp9Oss24QwB4/hkCuZ7/FmtiwMLDHuaBlIlNKpUy6cYgXtbyIxq2b8T?=
 =?us-ascii?Q?K4iTjI4prZaojOkycuf3yXOc5ZBL1HdjAGIeT6Jda8XNWXzwL30PuEow836j?=
 =?us-ascii?Q?yF5mh5yhnGhCjc9YAW1FW4V3C8UMUpgYk9DQc7E6xMzxQM1XD40vq9XBQ6LB?=
 =?us-ascii?Q?nK8FUzeT3PjVDRRPvJBhAi/KSGhD+gP/mqbebb8knoVFQjm2GesGIN5AOyzx?=
 =?us-ascii?Q?jqjbS3bGwBLZwsjDwkWbG9SbaKi/3ag7QwVeNaiKZtPkXeOGVfFUzMVvd25o?=
 =?us-ascii?Q?6bW0Q1KxmEjrGYs7OQeZjjNEYIo2Pcrk3DYMimp4yuEhLkFpUIeYPlLSuxC2?=
 =?us-ascii?Q?V6QI+o5rxvl35UW16/1oErAZEVYASGtSLI84uuJX45itk6+S9Z670QRB8Fb0?=
 =?us-ascii?Q?SLHftVnBegm98E5FAdOA0ISh/IbX/Zhk22U8b6XjEp3NQHtctRek9Jz+C3/0?=
 =?us-ascii?Q?DcduQgMRN2grbCjdW2S7YvTOE/ZXlf8/IkQwrimsFBVr3iNqsu+MhZzH+TEa?=
 =?us-ascii?Q?28vtq0Qzc5kq83it6jG//CU/DtG14YxWDqDOoJxpOnO0QFaEnLqo5HtY1RX7?=
 =?us-ascii?Q?bvLIr4++FIqtqV4Ga75ykYZNTJlxaa6lkJR95w9305eBWWQF4R5qOWI7nwKG?=
 =?us-ascii?Q?nr2AgtP6dHVUUsIn9TGtOiwUAn0XRml0C5QGwLI7CBAUR8OIHdj/4912i1BY?=
 =?us-ascii?Q?GFcCRy72lyFWg7UmBndg9ZOsRw+l3pqzN5TgYUw1t53tLccz70f1F4P1feKo?=
 =?us-ascii?Q?Drso1btm8QZCmCyIaTMhfKrPSME1atz52wYhzHvu2VA8SERMqpnLmHMElG+I?=
 =?us-ascii?Q?yZs2a+tIphhmuoqKjxsLg6AbeL9avRomlerB5wgofB1RMXGG0BrgmU8I5yXx?=
 =?us-ascii?Q?ZVSXJ0VC8vnIh+nYTNDMWoy1suaUNhWyPt6H50PzYcyv3Clns9a6ZNsLx119?=
 =?us-ascii?Q?mYyLlDYukJQQFlAk+8mtfUWwnGX3L3Xh6zNC61H7+Qor4eItrI7VAD4y+XfJ?=
 =?us-ascii?Q?0TOciPxah7/ZolChzvkd7bedlKQPhcNpQnuQPFGgmVjlXBDsm3EmM6EomH4f?=
 =?us-ascii?Q?5GYsSQzKiEt/LY1HQqSn1XhtE9wMrdrUVZ7LlwP7y1ihwYRPU09ld9+TK4Sn?=
 =?us-ascii?Q?WzN60CbXd0yRIPRb8hPKZSVRAdXXIvFYwasQUMx+UVywbxkAoebJtlVzxAFC?=
 =?us-ascii?Q?4J6tBGk9jLvIKkox0AZIsrhsEi6yP01B5TimRHQq9/VIepX4LQD7ixLs3rZL?=
 =?us-ascii?Q?2wt2eHK2E+CLysOOuOWi/saDUBySI6yyDmbDg3DlAE2QiywUKViOEtcF3vYM?=
 =?us-ascii?Q?EXIuHWIBc/PCh60XDPR5pY4mv2vklYssRfwnrwEbWjhXY0p/53B4Pe3oP7GM?=
 =?us-ascii?Q?yGh3MnrN+hCW27Eu8Z1kxSoUZHZOGsFa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ckE6DfYkKFr54dVw4q86yUrJOtmKIedx1lIXeKjVC4UMyaTt2fXKf1SiLCdO?=
 =?us-ascii?Q?7A4MAkD8cA+tLuN47EfwoFHwaOa6ugMX1kUkmOSkXu4ryhuGTlLjQ5p1F86p?=
 =?us-ascii?Q?M/kuPRYTR9Mw3iv7/4iHYzFKjkY0kFxT89ws3MVe5bXyt3mJv6GQ/AiyNd60?=
 =?us-ascii?Q?jjFzBk3vvz81eX+CmspgvNC44U3EN3gWa0qHV4s2HgRzWduPW87xueegw/IO?=
 =?us-ascii?Q?EVbUd0Nt8rZTwSQEjAw7DMimymU2+u7rz7vMKsVUeWOjezCUiHPQT5wQS1Wz?=
 =?us-ascii?Q?NGcQV4WYDqzLqspeys+Mzg8rykxQi/jYlgjRf6QTAQWv87MWFX2VtRyEbkWn?=
 =?us-ascii?Q?GCWpthRRTT0Jn3/BM/s8zkYHjR9XWnhaO78QCspybWIFHdUu/eGnxxeVT2cM?=
 =?us-ascii?Q?kwHC8LnFtOE3D8reXfMalBLWTNP95hlxrIGB7BQIaYcbGymXzbuwIqZDxZ9J?=
 =?us-ascii?Q?Zh5k7Yz88aA6UURN0HlMhWjIiuZoFIxs9x9k0c2UVx7hvBRahs2tvXIp96XF?=
 =?us-ascii?Q?qx+3uaok8sVeyEhCrHt4U8aSkK+22zcT2C1H487a9iVzBKo1cJjEIjxSP/R3?=
 =?us-ascii?Q?YC9g5WubQG28LsGTsHuj+Ng9/F2SSYoAcGXiOjcpj5GfrcoQFOL/pizaFYpf?=
 =?us-ascii?Q?sXmxgYTyydCwT2AfXc9btZSDmAmMmOrB5gRrNpHUOwMVqgY+69fAtLcvP9B+?=
 =?us-ascii?Q?nxAlV9KiMT8OtwXaMLQfW5G9E7fBkbpn8pUmRnDVrG4dKUm/Mz/CsKGh9V3T?=
 =?us-ascii?Q?nvGdDCN7Y0QLw2nv2IUZ9uDkfn8wZ3gWQHGzs1LvK46TfVB/5b5GJhwIoAAZ?=
 =?us-ascii?Q?MhbmmEY6pAC6IB8c55LhmjeDDIa/YCaNMsF+sAm4YvHbg7ByYiLLdbCK/F6g?=
 =?us-ascii?Q?690ED/tNTkGFF/kX+Mt95E9i8H/f0muxQvB94MkePaZoC+a2Os6K3xfOCIh0?=
 =?us-ascii?Q?7ZNIAdQmMajxD8ywgZAUra7gK2G3KnLybZI/LalIE+KPvvfOHUDVKMV8YvQo?=
 =?us-ascii?Q?EbPAJ9jNYtdli4otUx6QsjtANsf6eWGsqBeTzx+D6AP/wBD3RtCSq5yUCNSN?=
 =?us-ascii?Q?tSndrUHt0zsTpWM7Tw2I/oJCSBKFFJVdG51CqNPi97yPTrF9AwZjEk4qUW5l?=
 =?us-ascii?Q?JO5mFntc8321mq33l8ztpQl+E/7pUrCfbeNtlVyctf44x2vYkK4f4vR4WtCW?=
 =?us-ascii?Q?yw7cNIkgwnSNOlDoHw0a+GFYmTnFV+DeiI0KWMcWr2KRuNKOKDAyU46uoXaq?=
 =?us-ascii?Q?JlvSoM6NqNyvsITgrWKGtH4j3ufeX8ZueGu/zt0YfRUT9BqXlE49uJcHD6G6?=
 =?us-ascii?Q?S3i1iZxxUVQkh2ad4TfqbA62V7zSpRp5KX2EVPwa/y3lARtPK0e1z+46EBs2?=
 =?us-ascii?Q?QwvVDS2dkZbAoLCka5SVSRLSh/0TvsYkoqTAxp6Ji0XFXftwxlzIujWqtZ2B?=
 =?us-ascii?Q?Vh6BhPKSxjai9YMMnXXjaTfdDVliy11CdtkJWDklvWuLRbMXgDcXLfpIbDQj?=
 =?us-ascii?Q?FgQ89yARgD5yrGPEY+2rMqT7e8FFyse3xIxup6OqE99Kor0NoH7lP5IPWYl6?=
 =?us-ascii?Q?a2ts/LrfBnX9yj2+VxNaxHVWBRf3OYdrJog9lHho?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992598ea-ee96-4812-ac08-08dddf200ed2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 12:58:14.0928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Il1vq7SEaV9uLt/+zw0+OxQoPOqmNS6nV9vpCSE6bkwZqJLCAr/W9WphCfxjMZZtlblWLu74Y7wRwzHM73n/4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9946

NXP NETC (Ethernet Controller) is a multi-function PCIe Root Complex
Integrated Endpoint (RCiEP), the Timer is one of its functions which
provides current time with nanosecond resolution, precise periodic
pulse, pulse on timeout (alarm), and time capture on external pulse
support. And also supports time synchronization as required for IEEE
1588 and IEEE 802.1AS-2020. So add device tree binding doc for the PTP
clock based on NETC Timer.

It is worth mentioning that the reference clock of NETC Timer has three
clock sources, but the clock mux is inside the NETC Timer. Therefore, the
driver will parse the clock name to select the desired clock source. If
the clocks property is not present, the NETC Timer will use the system
clock of NETC IP as its reference clock. Because the Timer is a PCIe
function of NETC IP, the system clock of NETC is always available to the
Timer.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v2 changes:
1. Refine the subject and the commit message
2. Remove "nxp,pps-channel"
3. Add description to "clocks" and "clock-names"
v3 changes:
1. Remove the "system" clock from clock-names
v4 changes:
1. Add the description of reference clock in the commit message
2. Improve the description of clocks property
3. Remove the description of clock-names because we have described it in
   clocks property
4. Change the node name from ethernet to ptp-timer
---
 .../devicetree/bindings/ptp/nxp,ptp-netc.yaml | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml

diff --git a/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
new file mode 100644
index 000000000000..f3871c6b6afd
--- /dev/null
+++ b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ptp/nxp,ptp-netc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP NETC V4 Timer PTP clock
+
+description:
+  NETC V4 Timer provides current time with nanosecond resolution, precise
+  periodic pulse, pulse on timeout (alarm), and time capture on external
+  pulse support. And it supports time synchronization as required for
+  IEEE 1588 and IEEE 802.1AS-2020.
+
+maintainers:
+  - Wei Fang <wei.fang@nxp.com>
+  - Clark Wang <xiaoning.wang@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - pci1131,ee02
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description:
+      The reference clock of NETC Timer, can be selected between 3 different
+      clock sources using an integrated hardware mux TMR_CTRL[CK_SEL].
+      The "ccm_timer" means the reference clock comes from CCM of SoC.
+      The "ext_1588" means the reference clock comes from external IO pins.
+      If not present, indicates that the system clock of NETC IP is selected
+      as the reference clock.
+
+  clock-names:
+    enum:
+      - ccm_timer
+      - ext_1588
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/pci/pci-device.yaml
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pcie {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        ptp-timer@18,0 {
+            compatible = "pci1131,ee02";
+            reg = <0x00c000 0 0 0 0>;
+            clocks = <&scmi_clk 18>;
+            clock-names = "ccm_timer";
+        };
+    };
-- 
2.34.1


