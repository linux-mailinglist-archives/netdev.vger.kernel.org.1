Return-Path: <netdev+bounces-217173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24521B37AE4
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91EE1B665BD
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB42314A68;
	Wed, 27 Aug 2025 06:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="US0lHqsZ"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A2E3148D8;
	Wed, 27 Aug 2025 06:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277702; cv=fail; b=ZFFkHl9WaqsQLt5cb4rP/iceGkW3O2xzjEU0d4Z3RQp2Kx6FIJukfU/LIyDKgm2iaTzfUP/wFT28VvnYJCdbFUi+NkIchngSYr/C33AtVZal9MkPPNlq2O/8jmFwAx5hqlNK5a3UIbFEeKH/mK+Mk0oH7Pn/jayOc12h7ZE+QL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277702; c=relaxed/simple;
	bh=UcNkfAzeVBv6G/F2PAmoquwPKD07u5owQ54frFhFApk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cCXr6GTp9Kvx2/VNcgxzSqTqnXoKEWWrFiYVCxc20hxQ7mZgR88Ou52km7peNxqhP00bkfIsY33Zfr0vLXh/3ou+31w4nvDpUqPnH+4oSpgmfJttGH6DsnIZFtsB2ECKCAgOXTtTtBZU4K4bxJ+CuL2BytOttp+5WtrUNoGd9To=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=US0lHqsZ; arc=fail smtp.client-ip=52.101.72.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEXtrp6iA8HHN0hvthX8hJQk63nTdfQiszOdhegOc1s2XWJeC+Z6/i3czyKQhUIf1BCkqySRuM0ix4JiYFdcFo8m5poxTBKw5p91wl2+spO1kKUJruticB3NtHrD1wkMcu1ldJfup9W4YVRnnBDFhDiTB5rMKJD4uxs1UROL37n17HLabAk+7XGrshW9rHSjiGo3KMzyfdrcda9Y6DWDAVzcKG4QQDktmm26RlsILOXsEj+xM9fFp+Zl9yILgN90yvaFQB7o3g5pUWrvkDM4dYfatLhmFJlUbN8Szi5LzEb9CwarCJJteQsmy7oKVx2RoyD1ZSjtuhZEv6DfWSXRLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1g49v6KdAzAIJsZ7tj60RrXqfXw7WQ2W1b53YEZK7cg=;
 b=Mpvv4tFrpO60976n7bRNvg+J7T6kEDnrWEc76qS5lMiipqLrN2hn2wJ+mAsLfxo0HG0T+6j8IUM5ANPyiR4gUoi1Z6jL9WqI5SfYctG02k+ajmgVmBPWUgzYg6J/iEIGp5QOmD5mpH1PWMYoKcscGEnlQA1ZV0LKfSyw5N4IjUjxuIHlIEQjlBJy0zwDE9rHGKUtkSUwcFfMNaAopuLEP5nAQ/tJmKpHYm44mONhTMrZfYRDh/yfkavrlRco/QpfNL/zvwsOzE4UHv7Tz9P50kWyiUqPFRGmMxZqJ/x1AQfzN59gLvhfSuYoHupx4pKBB5qGUz2c2GvUw716NA2gJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1g49v6KdAzAIJsZ7tj60RrXqfXw7WQ2W1b53YEZK7cg=;
 b=US0lHqsZ6ucKr3T2/fyOpvIfxLnTA5jgeB8Jc+cBbyPy9NBxnz2M85lvTJnUCZ9PPUgCz4mH/EY6eJtPzm7pQht9Br6h7jLh8bB5jYxO+dOeyqJNKuUgUO0kGtktKrdv75PFt4GVKW6Hd63LtuqApPOtMYoj8s/xH/0de6LQOEG9OB2+D4uKWlvx5J8/TL6h6SPVFPqfFM+DrRzVsFw/BgmBDcrYNXZafny7PdVlQntPQffr9i99L0s27LVk7eDsUVfW+MGHoOdeOKrKJYCw3QCLheitZiHc0fbvPuyb6bjysRKUpg79bBbLIN46ET6md/uHzpf0ueOSBIv2msYisQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PR3PR04MB7449.eurprd04.prod.outlook.com (2603:10a6:102:86::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Wed, 27 Aug
 2025 06:54:56 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 06:54:56 +0000
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
Subject: [PATCH v6 net-next 01/17] dt-bindings: ptp: add NETC Timer PTP clock
Date: Wed, 27 Aug 2025 14:33:16 +0800
Message-Id: <20250827063332.1217664-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827063332.1217664-1-wei.fang@nxp.com>
References: <20250827063332.1217664-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PR3PR04MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: d7915af0-11df-414b-02b5-08dde536a203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IAsx3wGl0zDrWP7jYBnSQI6tpPWETz3GzGAgZjqQCdPUB+MAH9Vb/jQX/D0q?=
 =?us-ascii?Q?6hNvuENs6C4g+mvLl3N88tC52v5DWqnGcBJ1BCbuc5L4ZIYixB1C8Qk21ymZ?=
 =?us-ascii?Q?U1z2lKECYu2EJutY0McMSdPYCxwAKuaVl2cuxQrgD0BgbC244PEdSmVb+s2Z?=
 =?us-ascii?Q?poUth0qHeT67nBeqIwQnaB151pVSySgw4RRdj1HOYTWOJaJ9RmbNSW/Nj3gm?=
 =?us-ascii?Q?B5s6EDH0JoPzULoSrNKWasPJxN2uzQtp2A2HHAxY1XkEPXiFfJtJm6X2Ahf5?=
 =?us-ascii?Q?5wSmrCo4fzTQW1AT9itmQPPSE6kUArpa8+cwmNRt5pkMHIm7ebIjQoQo9JoZ?=
 =?us-ascii?Q?5/V7tqwPOnGf9Ge0+SrN/ya6GT5yUterhBkeHysDbCrOPMfkZYVC3ei7i6Dm?=
 =?us-ascii?Q?bDBPeoNP4VaHd1kJjtq6J19jltGknUibDn36E9nP+P2iu8d3mhcB42mPrlRw?=
 =?us-ascii?Q?4FofEyBW0mk5ZpNoI0HaVTyX8WUzRFGTL4ziGV7CUlRrHJkTWufmjdwsy2Lc?=
 =?us-ascii?Q?Z4I5O5ioAtp3NzPYHAbzzH/X4YpYdAMyIr1eOLlSkjbYttCgGvGeT9VLGHSB?=
 =?us-ascii?Q?CY01FLXiT+KAEwG5UO1Ys7RoZfwGtkP4QaCllnskd7oFlgpMdH6wtlT4D5nQ?=
 =?us-ascii?Q?Az/cqKzuIpDmlzyZNFVc2L9lSmK5vuxL+dyXqCutjn6WXzMqEyh8duY414he?=
 =?us-ascii?Q?3h5FryMk3sAkCS4YTj+UAcpL0rfD//mmR2YyWw6a6S6iPoCUflUqaMuggn0l?=
 =?us-ascii?Q?drEBP9tqeqwuw9ugMSXrCFPx/dSF7L2FJC8KQjeHlLqoIc/i1kM3RijJ6QML?=
 =?us-ascii?Q?9aIaYXfDBKAGtg7+mmeQf15YD2Ug+TqF0y5EMufoyFCFd/s+L4TC8sbBDgz1?=
 =?us-ascii?Q?2W2Z0EuzEiSgTPKxODhKrOGFwo0VC1xkQbIjyqsdfeaxnD1RUg+eZXn0OJdI?=
 =?us-ascii?Q?NFzR8jkMRmQB1cIIcsA9uF54r39C3G82BIcix9pnYoY8L2YDMpQt0i+dNqLb?=
 =?us-ascii?Q?eD2UT6b3fMsw9S/WaA3k95wPgzV/1QS40F0u7Ky8/a5Z0Hs/woDcuOf4Yy3r?=
 =?us-ascii?Q?rfUFhxDlJugVwH66+LVHeoaY2sHCiJopg9SqHiv/Lp1ncUwBJIFyg1crpeLa?=
 =?us-ascii?Q?5nyWwKAn7O4EinCO/Ye7yviHp+e0KLEaMDvm1k/DY65qm27NAAHg4rxLE2Ej?=
 =?us-ascii?Q?CDj+tkQCoAxqG6shpkcE3hU12lH1ihbozF2nh2E+F3xwtS/4/J9HlPLng04d?=
 =?us-ascii?Q?oHKbKyQZoVlk97AJK8ALTEY/01E67yWrTPkgorLlF1wttfO/l8a1CszR7VnQ?=
 =?us-ascii?Q?GASswXpw5mWMxWoCnVSMxS8NRR8aYN14zHoFqa1uyOPaHmujtiOeIByLUKkL?=
 =?us-ascii?Q?apKfJPRMtC4PvZ2ja4Sgz9I71F+1leAJL53BCICOFa6NnxxykCZWYdSjgEoH?=
 =?us-ascii?Q?+YzUU91pppqk/iKHusvumCvncd0pkXX7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LH3DvGHtBm4zNUHsezdWTuccP50RR+tz5iWcy/4mupeHyLpLP12/katCOszj?=
 =?us-ascii?Q?7rkAS9nYGDIOOMMaEPpOtU1IwBl2KTYLyzVU6M17bNd2+/WvAmbsg6CBTJmf?=
 =?us-ascii?Q?AdCZNTZmog3sqJW+FkDvZBt/nZRAlwwbbC0rJgYJ5FhGpG3Ix7xGM3cJ7yko?=
 =?us-ascii?Q?hUGewl2MJ5C42Lc/9VQCXbE7hQlb/kuuc/uBSD8RCP2ZogAD3NGtRa7MHWWI?=
 =?us-ascii?Q?cSVAM7GhJiKf0VhUgFZbS3X7EcICjKTXCbbt1sXZw6usyxum/c0L9v7wlK5/?=
 =?us-ascii?Q?kul57x3Rnr7knblbI3+X5J+mNSVCstMSFZ6MRFzHRu3jh/vkj2R+R9zT64b+?=
 =?us-ascii?Q?VcX2POa2NwS8/a5rQ/evmfuxovsoD3ABWBNjt+OQGkTZwCQf1O4mzsj2ojGf?=
 =?us-ascii?Q?PRTD11h6Rw+PUadPZNo2FnYoe1BaObmRDrrQ+1t/x5OIRXnMZyLvKAw5Uy7q?=
 =?us-ascii?Q?RDIm0BK5yBxDSU1Ms5FrVv/G0hOCAJtLrYH93XU65H6rFWMJ2a8qbTZNJIyE?=
 =?us-ascii?Q?ulDO07p+IfKjIaKEe+IULD3u9kif8CaoyMaK4UfXxT6CXOdbuiFMKfk0KL0s?=
 =?us-ascii?Q?vs4VMyy1TyLMQ2CzQgeXUUwS+n55xVHGqJeMjSBtcuQ7lWd0gwZ7EqvBZBel?=
 =?us-ascii?Q?UBHDlkoaKQNlFbZlqdINuzSzVRtxckcUi7OIxQypCvyjC+Wf56mmBtPcpcB+?=
 =?us-ascii?Q?Z8aglFVoW2ZwUNqHD/tiQYAeBkYNmEnM7fxGdY9R3wVqEoY/ELE/EJhgWNGg?=
 =?us-ascii?Q?5AC/xfm+gqUm+LwFtW8NsI1QRusW2bHNSYzyG/DD14RZkulILY6PAQaU58eD?=
 =?us-ascii?Q?1h0/siViGPUhtgfbxlQ1Zn1kQuVzKOGqB9jSNOvjvOj6LhN5hIkMAf4B9jIC?=
 =?us-ascii?Q?v/dq4xdXbM9WJ/b8eSgcRRugCohYpcjqbvLccjk3U0RzKfL6AlWhB25XkzaN?=
 =?us-ascii?Q?FnmkABNaFiW0qNZEWApPTbqZ2LtMFGon9vdX2wrN7CMLWBz/UMMFS/i3vyF4?=
 =?us-ascii?Q?g9fmSn4JM2RvlBVo8R+VyUI8Zoaymxpu0pAH1lsgdUjpXNRNzsUp2k5DRZY+?=
 =?us-ascii?Q?CY6jRLVeF5mcPTLIIRgseTpzaoMqElp+pt81LKLhII+ypq0JXmLrvW62TURy?=
 =?us-ascii?Q?1cGNM/gj/SkSBP/hwKGgC9XuXf0YG+KzxM+6C1kYfvy/SHPaE+qZIe/N7zjf?=
 =?us-ascii?Q?AjUv7ITHKPt4NPS5vwlPjMUFKBfeK9Zr/VsnbjbK/ct/XSHtimNsegleKmoD?=
 =?us-ascii?Q?pF/8qxcnaMsiIXT7GgiUhZaI0+UIZhWAFluhJZSEV8aGauoW1oH3tMRmyjve?=
 =?us-ascii?Q?Zv23i6xcGf0o9Ode7WCRrD+m7Uz7ujKvLLAzp/Yafdqd5ga/dPjPMAypj6X7?=
 =?us-ascii?Q?kW/gCx768fmry9kwO859n/YcPqjbc0JadZXOkv42qI58jsgIGBnrE3mCZ0uD?=
 =?us-ascii?Q?GIrHoZb497cKA/dcOt4MMbZuSfv0qjHoC/CHtEip28FEJmLfFYxgVVWdfraH?=
 =?us-ascii?Q?W6tIc8XqfoPPgIkZDsnh4k6DtyEyBbP7rpRBsJ9eY2dJk6Z3DOQGqQvMaiku?=
 =?us-ascii?Q?CQAyMJSRfuQix5QwujfSIJoTkyJhZtmbBaQPAdOm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7915af0-11df-414b-02b5-08dde536a203
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 06:54:56.8144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/FN9uZl8x6WxPRZ4v1mMnxDjOGuvJ6B0n2FKMZwM1CaAt+O1w/Av9fcSG/8HlKiO2uJWEUO55Q7XHSjUwoZZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7449

NXP NETC (Ethernet Controller) is a multi-function PCIe Root Complex
Integrated Endpoint (RCiEP), the Timer is one of its functions which
provides current time with nanosecond resolution, precise periodic
pulse, pulse on timeout (alarm), and time capture on external pulse
support. And also supports time synchronization as required for IEEE
1588 and IEEE 802.1AS-2020. So add device tree binding doc for the PTP
clock based on NETC Timer.

NETC Timer has three reference clock sources, but the clock mux is inside
the IP. Therefore, the driver will parse the clock name to select the
desired clock source. If the clocks property is not present, NETC Timer
will use the system clock of NETC IP as its reference clock. Because the
Timer is a PCIe function of NETC IP, the system clock of NETC is always
available to the Timer.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v6 changes:
Improve the commit message slightly and collect the Reviewed-by tag
v5 changes:
Only change the clock names, "ccm_timer" -> "ccm", "ext_1588" -> "ext"
v4 changes:
1. Add the description of reference clock in the commit message
2. Improve the description of clocks property
3. Remove the description of clock-names because we have described it in
   clocks property
4. Change the node name from ethernet to ptp-timer
v3 changes:
1. Remove the "system" clock from clock-names
v2 changes:
1. Refine the subject and the commit message
2. Remove "nxp,pps-channel"
3. Add description to "clocks" and "clock-names"
---
 .../devicetree/bindings/ptp/nxp,ptp-netc.yaml | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml

diff --git a/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
new file mode 100644
index 000000000000..042de9d5a92b
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
+      The "ccm" means the reference clock comes from CCM of SoC.
+      The "ext" means the reference clock comes from external IO pins.
+      If not present, indicates that the system clock of NETC IP is selected
+      as the reference clock.
+
+  clock-names:
+    enum:
+      - ccm
+      - ext
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
+            clock-names = "ccm";
+        };
+    };
-- 
2.34.1


