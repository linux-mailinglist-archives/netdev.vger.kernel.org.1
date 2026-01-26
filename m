Return-Path: <netdev+bounces-253306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKyzIO/MdmktWwEAu9opvQ
	(envelope-from <netdev+bounces-253306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 03:09:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A02883699
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 03:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22F3230056DD
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 02:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7587020E31C;
	Mon, 26 Jan 2026 02:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NfG//yzT"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013009.outbound.protection.outlook.com [40.107.162.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F024A1AC44D;
	Mon, 26 Jan 2026 02:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769393357; cv=fail; b=hX92JkBHQ7ElOEAJY5/QOfBK+ysUDg2FSwNalNhrQAm3VzoaAKGj0Rg2MkzJZ6W7mK2QbK/MqpOKY85fJHLojyHXu4BJfCDvbWdJYc6uitma4axyeCpB7zXyl3zD4N9tMDKOngkk0e/hwnTiRZWS1jzF2WS0jcikEZ4T5mHiRYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769393357; c=relaxed/simple;
	bh=j7/BeVoJcCiNKOA/oW59pI+oUf2UwPCU/SjtAAUC5EU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h6r4m9Uyg0YfLx22aFBuf8eM1iucZBg13M9rsazzxuMxgfNGdk/DKVROaT6ndzFFoJFIUkgZnC/qkOFzukSzOUxHApjFy1xbkv9u9JpJsLBlg3usAxowxkEe6UKsdTLpQeJ6iUYXa2oBA71jTYk2MKZrRX+iJtQuyE4oWjfYY0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NfG//yzT; arc=fail smtp.client-ip=40.107.162.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhP5tdP8QBNdw9cas6jGScg12anjkRzDMjfdDWeRyulCC7UT9btpBHOnqA6L0uZtXpLDvnRMAlPBp6swRYaqzCHh8XkicS7Jq2jGpbXZge4xNh/nI3J2wfWEMf5jPvNw9HUkAPCCpnLop0ghk5hkY5iPIxsf1kvbcCYYab3yEldlkF19OA00l0Oy4L44vsHneDieMv2856DQ+yrsxBl3RbYJqOTC7Q+8cbRAe1eD7OX2ybqrBTyX7P+9LRm/CfZudaH1tp7legVS5l+xO67wvaYPQk1hb91uuJO5PqOaXiTV0jJje+nTUwpKsRURcPslErnfEaSXtW3Vq6XyWDaIzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7/BeVoJcCiNKOA/oW59pI+oUf2UwPCU/SjtAAUC5EU=;
 b=d0hCSOB0M7XHnRTuyPzUroN7j2PJ8FzNaw1REcXWzDKS7CBSWCDH+J2riBfvrRoKUCCVGeJI2zv9ACSe9HWEa94ZO4R2kkbNnJhe39bso48X6P8mLdA5viEWwiYwGubCq0tsUMdo6bpVGJ2QnXl2h/ClBfQRRtJ49C7w8WcIpk+rXKmGAbHPL3mI/XXFbTpB2AUdPDVfwCbGlqk/u9Q7fXW45gtDaU/b5VS3wxSmu8fCJ8/vTQ9542c3BTizrO14FrVm0Lpim7XzvDxpR2AQ4j9iyvRYK2ir5sV3KGQkui6JTbrg5gKAB5xu8MXnVeBjr9edOZLk7HrH1vDKZXom1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7/BeVoJcCiNKOA/oW59pI+oUf2UwPCU/SjtAAUC5EU=;
 b=NfG//yzTNyyi191Ucy0PtaUcx1oCuiat4gRIB941xKqjAvWwZFlFvE7WdFeezdMNOXTNO0iXpmwccfAsQcDKCD1DArJ6AfS8UP5wQkyTP+BlL5namU9JA1PyoXLZD5+GbhHMYchwRDQx2KwRvzdoyVgAtk6HZmwJ56LvAPkaAc3TM0N/ARuw8CcXI/wfeSe4epGBEj8HB3AqBgyK0V8N9PfJOdL6w5+iOuKwsf0tvVEdKNawpDud68YHfovsS8HLO6eFN9X5QCU6mWuDlYQ62ZyWDFdgOmd1UyYRPcUqD4kIL2JgU+y0GyPd7R+dNsHC1fB+1qeiGwcs7BrD9hbPWQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB7608.eurprd04.prod.outlook.com (2603:10a6:20b:293::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Mon, 26 Jan
 2026 02:09:14 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Mon, 26 Jan 2026
 02:09:13 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shenwei Wang
	<shenwei.wang@nxp.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>, Frank
 Li <frank.li@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Clark Wang <xiaoning.wang@nxp.com>, "ast@kernel.org" <ast@kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "hawk@kernel.org"
	<hawk@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>
Subject: RE: [v4,net-next,06/15] net: fec: add fec_enet_rx_queue_xdp() for XDP
 path
Thread-Topic: [v4,net-next,06/15] net: fec: add fec_enet_rx_queue_xdp() for
 XDP path
Thread-Index: AQHcjkPovJRVPGcjrE2xmKHZuM+32LVjs3Ow
Date: Mon, 26 Jan 2026 02:09:13 +0000
Message-ID:
 <PAXPR04MB8510775746A1CAF835E365718893A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260123022143.4121797-7-wei.fang@nxp.com>
 <20260125214446.3383999-1-kuba@kernel.org>
In-Reply-To: <20260125214446.3383999-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB7608:EE_
x-ms-office365-filtering-correlation-id: 09846c57-8d86-4884-3576-08de5c7fe6ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dm14UzUxeklmVmFxWUNWTVZYV0g3TURaWEE2VVZOWEE3ZWEyWUZRNXRGc2NW?=
 =?utf-8?B?NXp6QU5vNnptQnk0Q3JFZjRNWkw4dlNpcFFIdGtrOUVERGI4N0VNUEZ6N0J2?=
 =?utf-8?B?Q3lMR0dBa1RkY0YzdXRma0J4bkNNYjlST3pFcUQvU0J1anhuNUZIMzM0blp5?=
 =?utf-8?B?b0NKK3VxUGxWOUR4NkhESnVGVXIwbnZUcnc2V2dUZVcxSDZjM3V2aXZDbGFz?=
 =?utf-8?B?UGQvaUs3VVIyZzhOTFFjY0h3WSsxQmswS044cW5KNWVoMmR5MzRtNGJ4S1Fm?=
 =?utf-8?B?eit3SEdtVmdRVzIwd2hvd2ptaEhKOG9ZT3RmU1ZrZjVhNUQ4T2Q0TFdXdG9x?=
 =?utf-8?B?L3ZpR1Y5aE1EZ1VRWHZNQktUY0d5NDhqZWJWYmttc0NGNWZQUktZVThBYWcv?=
 =?utf-8?B?U3ZnOFFLSy9ZL3RwaS85SDAwMmd0MnJxMXVFNDVWZmVMc3gzME9UYkM2RW9o?=
 =?utf-8?B?bE1GWUd5dDF6QmRnRER5dEVXNlZ6MmZDVG82WUtPd3VQZ1RpWXh0b1hBSVRu?=
 =?utf-8?B?cXZScUlpd0R4UzB0NVdmWWlDTHROeVVhdE1sWVFFcFBPSmtGb3dJajVORVRi?=
 =?utf-8?B?bDdzemNzb1FBRmxGeXNYMStSODk5UldtdEIyMU45VnpTQnVrNFdteXpZTVNE?=
 =?utf-8?B?MVYrWFZaZ09hRDMzYThoTDBqZ0RPR1NDcTJMMDJwSjhsc2Y2cVg3Ykc4VHNk?=
 =?utf-8?B?QSszbHlKL1pEWkpVdHMzNXdIQ2xEbk5aQkgxclFlNWJBZFVPOVR3Y1RKLzRT?=
 =?utf-8?B?d1ZQTDVJZmtDeWtmWERmT2tiZlU5K0pZd1A1MWlRNUxlVlVCdTNoZ1NyL2hM?=
 =?utf-8?B?VDdsRVU2NTFJMThaNFRweVBDcXFkU1VuZkRLMm5sd0poVWM4b3NtU0gzRDVj?=
 =?utf-8?B?aFFHa3NYTmdJbzV1TmpLbGtHOFJSKzNSYnNuVEFkYkNNZXdOb0FCOHlYeUhx?=
 =?utf-8?B?SmphQUxiQ1V6R1RiVk1VNTY1WElNbGJ2aXd6dldSS2xiRVRlSTBvOTFsMWlh?=
 =?utf-8?B?b1hNV2tnSFVpNHVIOVl0a09iRDg0MGJjaFBPdEdGQTRJV0RSUnJ6YlJseWdw?=
 =?utf-8?B?OGJ1SWd1T0NOK2tVL1E4SkpiOHVnNi9aSEVqQXpTMUF0QlcxWEhJOU1yNlZO?=
 =?utf-8?B?aHFDeGVlaWVDZ1QzVTVzWHpiT1lHUmNSZVBxSEZvSjhLZWRTTWk2R2lmTm1Q?=
 =?utf-8?B?QlowRmF1WTJPQ3MzUnl1ZUZiaGZWZ20wL1B4MVBFczdCRHg3a2VrVk9DeXBR?=
 =?utf-8?B?VWt1M1dqc3BoczA2SXpBYlA0NzRxVlpYVlRmZ01RWFR0cUt3Y2lHWHcwME9K?=
 =?utf-8?B?enpCUjByUXl6a0hZSGNSRTByQVY4M1V1UWVlZjJBNTlQc2lGVjBxMTl5Y2VC?=
 =?utf-8?B?c1huMVNMUG14NGhiSGtSSml3SUE1eGZwdms4V2JPVXpFdjh4R1lTbVRyQk1H?=
 =?utf-8?B?S3FsNmdEeEFrb2xxK1I5eVZQTHdtV3A2ZWlJc0xIOU16bVQ3Q2VONjhmL1BB?=
 =?utf-8?B?OEtXQ1NwRXphVm9xa0NyYkVWS0QxR1ZhdVJKeE1qWFAwRDFPcTFMUGpEM2gy?=
 =?utf-8?B?K3RPMVE0MjY3a3NNaHZRTUR6WEYxdG0zL0dCR2x2MVp2NkRiUVVyb204eVdE?=
 =?utf-8?B?dE9PbFdQeE9lNllkbW5OK0Uxa3JxeS9QT3pOaXE0V1J0TU1ib1lnOHZXenBz?=
 =?utf-8?B?bGJyNVBnQjF0dTRPcThVajZkZm1neHdhSTRhOHlOT2UySlRIWnR0cFNxeWFD?=
 =?utf-8?B?VmZ5NktMSE9TUTBJRUFJTERKNTYwYjM1Y0pSeVdwb04zKzF3blZIN25ad1Bm?=
 =?utf-8?B?UzVVb25TVDN4cjA1eTc4V0VjV2I2UitJbFd2SktlK2o3M0pEUmRRZ0pwMUor?=
 =?utf-8?B?dXBHcnk3VXc0bWFGVTBQOTZxNWkzb1J2dkcwRWVYbk5EL1dzdHY5emxwVHFG?=
 =?utf-8?B?TmxVam4zUnZJWUlnWEdwZ0tZZkdFbzNIY1RobkYzOGo4SFNHcFlEYmZxaEs4?=
 =?utf-8?B?RHZBWVpMQWZySXJvM0Q1RTVZQzdqNW8xWXNqQ0V6dStPRGlxTStmb251Mlpy?=
 =?utf-8?B?a0Rudm5Pb1IxRW9jbmZka1FhdktaS1ZmekN4UEoyQXRnNnBOQjJ4cCtNSXlo?=
 =?utf-8?B?dG1rN2JrSkhqWFU1R1Rpai9qNXpxN0E4d1FPb0dtLzVMUzVGKzFHNFJCUitu?=
 =?utf-8?Q?hieMnJhdMOFvehF25gtGTDo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UzhwK2VCQ2U0MlpsM09wdG5qM3NIUGxxSUpscExHTC9maVJ6MWdKZ1Z3QUxX?=
 =?utf-8?B?MkhWMWR6K2E4M1pJM1JmNHFESlZsKzZta1lpaUpKZ1Fod2lrT1V2dDNZZ2xB?=
 =?utf-8?B?OHlaelEvQkd6L3Q1V0E1M2Z4b3lud2NiVUpHNE5HRTA4cTA4VXJtbzZqL0Fw?=
 =?utf-8?B?QVVsbzI3SmpNUjdZaG01eFlQN0tiWDFLSElMeDVDemZnaEd4QXkweUVkYmJm?=
 =?utf-8?B?ZEVidkdXOWp5WEUwMjFNTi9mejhBL2w5ekZEbVF1MnhiT1ZNd3g4NlI2SVor?=
 =?utf-8?B?YTZpSGxocklvZGx0TUg2UlRIa014NmJvR0JYNUZwL2pJVXlGWUNLWVFQcDNj?=
 =?utf-8?B?NnpreTQzTzMvNE1LYk5tZWN6VTdlVlpxQytvMXpOUHppbU9YaVNnUnhKZFpa?=
 =?utf-8?B?alJwYUZEbWgySzk2S1RUckMvSVAxUmQ1QzJMcTNBd3prUnFxR3QvVEdJY2U4?=
 =?utf-8?B?aEFJMUlkandSaWpkZ05mT1Q0d3lsak15dmtYL3pWeUZEWWhqZDY4dUZpMmJC?=
 =?utf-8?B?ZDNBZ3pCU3ZidzVqZmJYZTh0SnNQRWkwOWhDR2JoeU4za2ZPMThDdG91aTh3?=
 =?utf-8?B?ZGFqeUdQL0YzdHhDQmtjVnIrZlh1TGV6TmN1UkpyVFhnUWYzaWNhM21rRWE3?=
 =?utf-8?B?REZKLyswcU1DakM3Wng5dmRFNTh5RXIrdnFEaXZoUmJQSFRkQXBrMU42cDFz?=
 =?utf-8?B?M0RxQ0hYbk9ybVIxME9HSlM0c083ME55Vmh1Y0d3TEhCY1FsSUZ4REpXRHVl?=
 =?utf-8?B?V2h1ajRIaER4ak4vcDdSbzFPOGFkZUhUT1U4WHJvdHFsQitxYmY3Qm84WE9Y?=
 =?utf-8?B?RnZYUVVUcGk2UW12K1NSYnVSV3lIa0V6b0h3ZzV4Z3ZPYkZQdWRubi9yMXEr?=
 =?utf-8?B?dnA0WTNUOUJMUUxzSFUwZE1iY21tWGpHWitUN0J0M010RlpodFcyL3lnbEtp?=
 =?utf-8?B?bERuY3U5TkxxcUhXSmRVLzErZThuUjBrQjFDbCt0ZVRxdGx4QnoyamRIQ0JV?=
 =?utf-8?B?QkJ3M1VjdlhkZ0pPVGVtUFZhQnlqZFAxT3Q2QnhOdU1zUHZhYUU2YXRURG1Y?=
 =?utf-8?B?VjJUTE5HNWZwRDFtbzNxbncyY0FoWlhGMGdpbTVoQitzd0k3K3V1aDhhNDhE?=
 =?utf-8?B?QkhNcTJ1Tm4wejhSVXZjTnhDN1ptZmgzL2s4TUlkdTQ4dk5lRTdlYkxiRjN2?=
 =?utf-8?B?VnlhM0VneU14QWRSazRvbjd5a0lrLzNPRnl0cWxTcHQ4SHltbWw2ZkU0bHJk?=
 =?utf-8?B?RzVhZ2VYWWRuMzF4MFpHQW52bWV4UVhQZzZFOWM2Rm5zQ0tFRmhlbTMxbDFu?=
 =?utf-8?B?MVpNL2JOb2dmTHZibG5XeEFjZ2dqRnlYdFNZVkxnejYwVHJGSmorRkFlNDk0?=
 =?utf-8?B?TVY2Vm01R0cvNS9uSld1bTVKSnZyck5CcGdUSk1sUkQ2RmVkdTd4M3hWcUxO?=
 =?utf-8?B?VnY3ZkFGNHFvbnZXdmhXR0ljOEtEa2h2ZkpHME5rZzFsQ2I5R3ZsWkFaMlBY?=
 =?utf-8?B?RmROYVNZNlRSVVY2YTJvaG5mbGZzTVdIYkdIMUVUUWFPbTVBOVdjY2hmYVdv?=
 =?utf-8?B?bUhSVTFndkNPZTJ5S1QxS2Q4UjAxc1MvR21hY2VtQWJQYUo0cEdxeEcxd2RC?=
 =?utf-8?B?bGtKcmhjL25GNDNyTG51N1JDU3IvbTRkTXV5VW0vM05FVExsaTQ1bkxCNUVX?=
 =?utf-8?B?NmkwRlpFemUySTM4bmVEcVRnZFNvMjBUK3lLOFUyTmo5NUt1MU1PazRvSzBt?=
 =?utf-8?B?akZ1clhHZWlmUFB0ZHljd2hDL1Mrcy9hT1lucjZmVzN6NWN5NTRMQlYxQ3hH?=
 =?utf-8?B?L00rTkpsb2Q4VEZGMG91SUYvYUdkeUxRNjZNN1JEYk55dUExZHJPdUNHckk5?=
 =?utf-8?B?V0ZPYVh1dGQxMGg4dVBSYnFZeXFudDZwM2lZNVJPTXZLUzdyMmpEWGdLeFJR?=
 =?utf-8?B?ZVdKQnc4bWdmdXRRdFRZS0c1ZWNZMmdQZEQ0ZHBNRjRPUnEyQWl4M2tFTGlE?=
 =?utf-8?B?aE9vZitKQUdGTkVKbWlTYmxCNzJQQ09JeG1tTmYwWW1KSk1na2ZYU1VOWFVZ?=
 =?utf-8?B?amJuZzhkaGNNQit5bFlENzNSTG8zQkZYbWxVUnUvZUc5dnp5Qkw4c0ROR0Nr?=
 =?utf-8?B?VXM3SjQ3dnQ4UXVMUHFpSzYvdm9WbCtuZUJwM3JNb0RXcFBCYUE1V1FwaXIz?=
 =?utf-8?B?bGpIdnV0c2tLazMyN0RwL3RZeFZ6MGljN2RxUmNsZjZVMWg3T3I1Qk9wd1hF?=
 =?utf-8?B?R0dQWFNReWpqZGVJWjFyMDJFRDk0djdGOC9ncWQxUGdZMUJaZGdZd2M2Q3cv?=
 =?utf-8?Q?itHFdVRhdDy+/GIKhA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09846c57-8d86-4884-3576-08de5c7fe6ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 02:09:13.7633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kho5WI7WINay1+thL9eqzE3nO0Gls0a2fK1fxm9hYdxnXIbrAzU6X/GyUXHvFr3NEp3XOLP6cBAcGwPluNrllw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7608
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253306-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,nxp.com,iogearbox.net,kernel.org,fomichev.me,lists.linux.dev,davemloft.net,google.com,redhat.com,lunn.ch];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,PAXPR04MB8510.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 0A02883699
X-Rspamd-Action: no action

PiA+ICtzdGF0aWMgaW50IGZlY19lbmV0X3J4X3F1ZXVlX3hkcChzdHJ1Y3QgZmVjX2VuZXRfcHJp
dmF0ZSAqZmVwLCBpbnQgcXVldWUsDQo+ID4gKwkJCQkgaW50IGJ1ZGdldCwgc3RydWN0IGJwZl9w
cm9nICpwcm9nKQ0KPiA+ICt7DQo+IA0KPiBbIC4uLiBdDQo+IA0KPiA+ICsJCXN3aXRjaCAoYWN0
KSB7DQo+ID4gKwkJY2FzZSBYRFBfUEFTUzoNCj4gPiArCQkJcnhxLT5zdGF0c1tSWF9YRFBfUEFT
U10rKzsNCj4gPiArCQkJLyogVGhlIHBhY2tldCBsZW5ndGggaW5jbHVkZXMgRkNTLCBidXQgd2Ug
ZG9uJ3Qgd2FudCB0bw0KPiA+ICsJCQkgKiBpbmNsdWRlIHRoYXQgd2hlbiBwYXNzaW5nIHVwc3Ry
ZWFtIGFzIGl0IG1lc3NlcyB1cA0KPiA+ICsJCQkgKiBicmlkZ2luZyBhcHBsaWNhdGlvbnMuDQo+
ID4gKwkJCSAqLw0KPiA+ICsJCQlza2IgPSBmZWNfYnVpbGRfc2tiKGZlcCwgcnhxLCBiZHAsIHBh
Z2UsIHBrdF9sZW4pOw0KPiA+ICsJCQlpZiAoIXNrYikgew0KPiA+ICsJCQkJZmVjX3hkcF9kcm9w
KHJ4cSwgJnhkcCwgc3luYyk7DQo+ID4gKwkJCQl0cmFjZV94ZHBfZXhjZXB0aW9uKG5kZXYsIHBy
b2csIFhEUF9QQVNTKTsNCj4gPiArCQkJfSBlbHNlIHsNCj4gPiArCQkJCW5hcGlfZ3JvX3JlY2Vp
dmUoJmZlcC0+bmFwaSwgc2tiKTsNCj4gPiArCQkJfQ0KPiA+ICsJCQlicmVhazsNCj4gDQo+IE9u
IHBsYXRmb3JtcyB3aXRoIEZFQ19RVUlSS19TV0FQX0ZSQU1FIChsaWtlIGkuTVgyOCksIHRoZSBv
bGQgY29kZSBwYXRoDQo+IHdvdWxkIGNhbGwgc3dhcF9idWZmZXIoKSBhZnRlciBYRFBfUEFTUyBi
ZWZvcmUgYnVpbGRpbmcgdGhlIHNrYi4gSW4gdGhlDQo+IG9sZCBmZWNfZW5ldF9yeF9xdWV1ZSgp
LCB0aGUgZmxvdyB3YXM6DQo+IA0KPiAgICAgZmVjX2VuZXRfcnVuX3hkcCgpIHJldHVybnMgRkVD
X0VORVRfWERQX1BBU1MNCj4gICAgIC0+IGlmIChyZXQgIT0gRkVDX0VORVRfWERQX1BBU1MpIGdv
dG8gZG9uZTsgLy8gY29udGludWVzDQo+ICAgICAtPiBpZiAobmVlZF9zd2FwKSBzd2FwX2J1ZmZl
cihkYXRhLCBwa3RfbGVuKTsNCj4gICAgIC0+IGZlY19idWlsZF9za2IoKQ0KPiANCj4gV2l0aCB0
aGlzIGNoYW5nZSwgWERQX1BBU1MgZ29lcyBkaXJlY3RseSB0byBmZWNfYnVpbGRfc2tiKCkgd2l0
aG91dA0KPiBjYWxsaW5nIHN3YXBfYnVmZmVyKCkuIERvZXMgdGhpcyBicmVhayBYRFBfUEFTUyBv
biBpLk1YMjggd2hlcmUgdGhlIERNQQ0KPiBkZWxpdmVycyBkYXRhIGluIHdyb25nIGJ5dGUgb3Jk
ZXI/IE9uIHN1Y2ggcGxhdGZvcm1zLCBwYWNrZXRzIHBhc3NlZCB0bw0KPiB0aGUgbmV0d29yayBz
dGFjayB3b3VsZCBoYXZlIGluY29ycmVjdCBieXRlIG9yZGVyLCBjYXVzaW5nIHByb3RvY29sDQo+
IHBhcnNpbmcgZmFpbHVyZXMuDQo+IA0KPiBUaGUgY29tbWl0IG1lc3NhZ2Ugc2F5cyAiWERQIHBh
dGggZG9lcyBub3Qgc3VwcG9ydCBzd2FwX2J1ZmZlcigpIiBidXQgdGhlDQo+IHByZXZpb3VzIGNv
ZGUgZGlkIHN1cHBvcnQgaXQgZm9yIFhEUF9QQVNTIC0gdGhlIHN3YXAgaGFwcGVuZWQgYWZ0ZXIg
dGhlDQo+IFhEUCBwcm9ncmFtIHJldHVybmVkIFBBU1MgYnV0IGJlZm9yZSB0aGUgcGFja2V0IHdh
cyBoYW5kZWQgdG8gdGhlIHN0YWNrLg0KDQpBY3R1YWxseSB0aGUgcHJldmlvdXMgY29kZSBkaWQg
bm90IHN1cHBvcnQgc3dhcF9idWZmZXIoKSBmb3IgWERQIHBhdGgsDQpzZWUgZmVjX2VuZXRfYnBm
KCk6DQoNCnN0YXRpYyBpbnQgZmVjX2VuZXRfYnBmKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIHN0
cnVjdCBuZXRkZXZfYnBmICpicGYpDQp7DQoJWy4uLl0NCglzd2l0Y2ggKGJwZi0+Y29tbWFuZCkg
ew0KCWNhc2UgWERQX1NFVFVQX1BST0c6DQoJCS8qIE5vIG5lZWQgdG8gc3VwcG9ydCB0aGUgU29D
cyB0aGF0IHJlcXVpcmUgdG8NCgkJICogZG8gdGhlIGZyYW1lIHN3YXAgYmVjYXVzZSB0aGUgcGVy
Zm9ybWFuY2Ugd291bGRuJ3QgYmUNCgkJICogYmV0dGVyIHRoYW4gdGhlIHNrYiBtb2RlLg0KCQkg
Ki8NCgkJaWYgKGZlcC0+cXVpcmtzICYgRkVDX1FVSVJLX1NXQVBfRlJBTUUpDQoJCQlyZXR1cm4g
LUVPUE5PVFNVUFA7DQoJWy4uLl0NCgl9DQp9DQoNClRoZXJlZm9yZSwgeGRwIHByb2dyYW0gd2ls
bCBub3QgYmUgaW5zdGFsbGVkIGZvciB0aG9zZSBwbGF0Zm9ybXMgd2hpY2gNCm5lZWQgc3dhcF9i
dWZmZXIoKS4gQmVjYXVzZSB0aGUgWERQIHBhdGggYW5kIHRoZSB0cmFkaXRpb25hbCBwcm90b2Nv
bA0Kc3RhY2sgcGF0aCB3ZXJlIHByZXZpb3VzbHkgbWl4ZWQgaW4gZmVjX2VuZXRfcnhfcXVldWUo
KSwgdGhlIGxvZ2ljIHdhcw0KY29uZnVzZWQsIHdoaWNoIGxlZCB0byB0aGUgQUkg4oCL4oCLbWFr
aW5nIGEgbWlzanVkZ21lbnQuDQoNCj4gLS0NCj4gcHctYm90OiBjcg0K

