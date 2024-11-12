Return-Path: <netdev+bounces-143911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8079C4BA9
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 02:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7165BB23DC9
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 01:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E698204921;
	Tue, 12 Nov 2024 01:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D9eFLVUM"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2057.outbound.protection.outlook.com [40.107.104.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0205D2038BA;
	Tue, 12 Nov 2024 01:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731374650; cv=fail; b=E35YNq3bJKaMKS4DxJC1wAtat9cj70RzK4zhkXjZjELcZbl2CIIXG54Yrt6B3uFsVvEJjNWxSVj4pbbU9yLMCP67w5OvI7FzmiAntn/cX8riwSSc7KsOxJIW5pBFj5BMaYhuSHgHGdsIQLpGf/t60vtkztLhZ6ZbzyLb2oqPavw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731374650; c=relaxed/simple;
	bh=Rpts7wbWelwMUn0iYk71boYSQy/Ayqc6aBjbOtWn4T0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CrqqVfxDWoj1r/tBj3SUGuqlMslc3/Jd9D24gSILpxpATdUOqLRIELsVzXcgzAtLyCB+YWSfASYdMi82SOQfAOwfxnEjWGyAQ+S15tsqU7pWi9utDx2VwOwcVqicQMJiLR5E2cgn6xMYmfu5NGHD2ktUvRUZ7shYAh7ifepnajY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D9eFLVUM; arc=fail smtp.client-ip=40.107.104.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRMw15TEsgsIQJsuoJpl+Ka4oA/hqq3Ah5/7DqUQ/XvBywO2YshpJPwXdywYgL+4SQHX/MMDCcsIDSeHd/Ns43vIWx+H2hCxQ7cvHjbFa0UtlUJUZSX8BCTuawcHpPyOECdGa7a34lYRzxDPJiNL8KwHFud9Uf2IMZqxFIhK94v/28h1p9ubM4tzibqTDy4jbwtAvIb/xh/3+b+GZ6hvyK+GJIf+v3iMv3Yz9FcQRvGTI5THZu6aFdxe2IQKa/Xd3+GeDxYIPG4rfcoeSsti3xCkao89MsGicR0tZMmkJC4/zc+EoxCO4JobwBTO9gcdizL0irVaH6zGAh2bJMRs4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rpts7wbWelwMUn0iYk71boYSQy/Ayqc6aBjbOtWn4T0=;
 b=TKgReNzzMT05nX24wlBw9Y5VwFPeQrRMAqhQlCE8vPJGDQEu6YHKL/bbM166+jQGyG7yt56Vr0gMLFOBQ9X3AzUyXNfgrar/B48Jq9waD5s2SoHqSR+pTS15bIe5H5Ea5izARpfEXPJkYfNardBAF0FDtY50+0x0l3MLNnIs73DANQ0FiZ/j6wjh74VFgWmSnoIVrQeVC5RPoqt9IGt+rui3SH4sEKE7HW+w4mZ5ouWApZB7nxrLDWN+ofwQnajj1YBuHRDBQUI9rF2wmJXIApnfe0lKqe2/OH38m9NOHB1n17rPEM1kg6g29UIddnqe17OpRK+YCePQ/6N2JnY9Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rpts7wbWelwMUn0iYk71boYSQy/Ayqc6aBjbOtWn4T0=;
 b=D9eFLVUMmU3/hOypbLKVFmtNGh0oztx0uMm0SPqkjn+IQsbuMkF/VhNqcJBA+lhzqN7qhmZPihA7b6jx3Dgxv9sthv1R4jvpP/nnlAW3ipi1CXGsuhf7/KrfeNZKIkU75nx1/sPThVDfQOAFJ6k74xQiNqvllD/5JRkYq3sNX03wNmez4ki6JjBQajFYeiozHeL0HZTyVzKUA7n3Pe3coHo7pqz+fd49qEZiNV7bJxUlSQrfgQUrt2MfXyLfj8pO+StsDMMYIvhAfmfyzKCnl++9IRIFkdVokDmBg5H3JSvsU2469zS88WBeg8s+4AZ0TYhvN++H1T+SFtJN5/SUMQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7840.eurprd04.prod.outlook.com (2603:10a6:102:ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 01:24:04 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 01:24:03 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH v2 net-next 2/5] net: enetc: add Tx checksum offload for
 i.MX95 ENETC
Thread-Topic: [PATCH v2 net-next 2/5] net: enetc: add Tx checksum offload for
 i.MX95 ENETC
Thread-Index: AQHbM96Mok4WQFp4gEq5F3KBlp1btLKxrksAgAAekwCAACwL8IAAOESAgACpfGA=
Date: Tue, 12 Nov 2024 01:24:03 +0000
Message-ID:
 <PAXPR04MB8510E069CF5426543813A62888592@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241111015216.1804534-1-wei.fang@nxp.com>
 <20241111015216.1804534-3-wei.fang@nxp.com>
 <AS8PR04MB8849F3B0EA663C281EA4EEE696582@AS8PR04MB8849.eurprd04.prod.outlook.com>
 <PAXPR04MB8510F82040BCB60A8774A6CA88582@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB85107F97E4037BAF796C69E588582@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <AS8PR04MB884990E9C4EF08D844541B7296582@AS8PR04MB8849.eurprd04.prod.outlook.com>
In-Reply-To:
 <AS8PR04MB884990E9C4EF08D844541B7296582@AS8PR04MB8849.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA4PR04MB7840:EE_
x-ms-office365-filtering-correlation-id: 92780884-cb64-4301-5c66-08dd02b8b1f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?cFVkbDJkK2lrdkNhU2JpNlFUWTNnUkpOUTJxYlg3aitRVkpqQXkwZSttY2Iv?=
 =?gb2312?B?bSt1ZExOdXRjMmVlTG90MExkUXdBZnNJTnVmbGFha0R2R2NhR1AyNjhtNDAy?=
 =?gb2312?B?WExzVFNxM09haG1HaGcwMFFvVGxFUzhBOTV4UHpjTVdoM3YrZTl6R1hMcktF?=
 =?gb2312?B?a1pkb2RDczAwMExCYnhONngwYzJhS3ZDVUlMTGtqZ0ZUcDg1MDNuVUExWkRz?=
 =?gb2312?B?RFlQbldoVXpSYkpmdWFSRUpUb1JZRmRTeGVTaDlvZTdnNHF4cUlVVkFqNkVy?=
 =?gb2312?B?RGZIREc1RUxNZW8vQyttd3hqTGUvdlllMW9hQ2pnZzlGRlZaNW5TSlVoZlJp?=
 =?gb2312?B?YWxRZEYwWm52dC9qQWVJbHJEZnFiYWE2L3RtSkZKS0JrSUx4dVIyWUw0OU5U?=
 =?gb2312?B?dzBVQ1FaOWYzNG5sTUlVeXgxUE1RbDZJQjV1VUp6Z0FGSXNYN0tSeHIyZVk1?=
 =?gb2312?B?VTh2czBWSmJUalNaNDFHL1BraXltSjIyQTFlOEFwYWJSeUI4YjhHRWhPY3oz?=
 =?gb2312?B?VmN5RVlSYXFweGJOejh2SXdyMi9wcGNPazVRNHZ5YW11R3NNRDJCd2FNMzlq?=
 =?gb2312?B?dFFZd090aDFTZ2kwbXZBbUVCTHJTZFBVMmh4U1pOWnZMdTJKc2JNcVlNV1hn?=
 =?gb2312?B?TU9oUmdpOTdqQ2FKRjdvMDFycWE0OVJmbi84dTdkd2JwUFVYMUR0RUdZUiti?=
 =?gb2312?B?UDI1YVAyUWZaMXRub1BTajlWcE5iZ1NxOXJ2bGRnN2ExQ0c4b2VvVmdNbkVC?=
 =?gb2312?B?V2VLQnJwMFFJRng2SWJ0d3Z1alhzSklFeHlndFZPOUNWQmQ4S0piQ1BkUzA3?=
 =?gb2312?B?eTM1aHFyNncxcnR0VDBaT2RWaDV4MC9LWTlPMXJaL2I3aGlwdzlENE1FWWhQ?=
 =?gb2312?B?cFQybnNkRU4yUm5iZXpPWmg4ZjMrTm5BWkZNdHBGYzZ1TGpIZTFhc091SFcw?=
 =?gb2312?B?Vk00RU9kY1ZZb1pwWUVMN3lnMkpWaWttS2JtNkdwa0tTeTMvRG1HNE9FOE1I?=
 =?gb2312?B?TUdhcm85KzVGT1V2U2o1N3JXdVlSOE41VUs2M2NNTFpvenROZTNQNDNiNHRZ?=
 =?gb2312?B?NnhybDVFb0pLYWZjaGFrK0kxTWNtMFBPd0FGaytHMWp3R0l1WisrTVE2Z3B1?=
 =?gb2312?B?UitjUnhTdlVjaG5KQUsweDFVcUpxRmQ2NnhEN3FES0pMNFloaVpEKy90QWo2?=
 =?gb2312?B?NlZoc1lmeHpaaVJ3Z2ROY2RqWmNqS0tuMWtPb1JIZFloRS9FY0ZCRE9ldU43?=
 =?gb2312?B?Uk4xQjV5MlNxaGFGd3g0cXJuUnAyck56Q0syeGhaYkp3MGZ5OUJ2cCtRNm9z?=
 =?gb2312?B?TTlnS282Z2t1M1ZzdE51SXJTeUd5Wjl3NlAyWUN5QUxEcVB6ZVhUOFJzem14?=
 =?gb2312?B?MG5EajB1NnFQbWVHT1pScndmeVh3VVBrNkF1bDNxaFJEejNGeXhkemNRVEVW?=
 =?gb2312?B?ZnVMSVI2OUdSMlFSQktHSE55OVh5MXVGbXBhbSt2V0ErWTEzRXFELzNIRG5M?=
 =?gb2312?B?VFdKeXVCM3JtcE1iRFZodGFCK2tuTTVaMWNBZ0NyS3BGMlBoZjFhZmNoVzJw?=
 =?gb2312?B?R1Vxdy9Qcmw1RmRITHJCQS9JZ3VVa0k0VmtSQlNMTmdYZ0h3N3gyM3o4a3JW?=
 =?gb2312?B?ZlZibkFBUy9KMHltTzdtUCtTSzdzY2FzSUVZTkNkYzg2dVFqakZ2OGRqZlpj?=
 =?gb2312?B?ODYrZUszem1NVzFSelpnR05WeUxKblZQNENpQ2F1aUprNHlqeUFtWTEzNFR1?=
 =?gb2312?B?UVBCY0VmeVA4QnAvbkNlTUJzajVKbTBpdFRmdVE0L1o4NUJtSFB6UHptNm40?=
 =?gb2312?Q?MMqWQ7vJ5szg8O6AFWOQpuEs6mCP1kGTb96cc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?T0sxaG5tOXNPUDVvcmJSc3NYdW0rSGQzUlQ5bUVwY1oyNWk4U0pnYXZJQXV2?=
 =?gb2312?B?cVptaDVEaTRpMHFvWkpTcWJ1OTFuS0t5U2xmSk9COEQvZ2w3dXpaUUhtOWFo?=
 =?gb2312?B?TjVESlVYaXlqdmtmck9CRTZ2VGducUlnN2ZSZU55RjBxUm9hSHVDWjcvdHV6?=
 =?gb2312?B?WlQ1dWkvZm9VRmFPV1ZCN0RRSTlLanlJMVlDbnI5OVpKOXYvNzBUVHFJYTlX?=
 =?gb2312?B?aG5JSC9FQnVHK3FBK25JNEJxVGtuT2NKSzNvc3dQVnFPWVlxZkRCeGJ0Wjlp?=
 =?gb2312?B?aEFIZS9sS0xrYUtZbEczR2pNV3hVMWNyMUUvMzV3bGJjYXhkV1V4eFBvS3hJ?=
 =?gb2312?B?bFoxdnQ5YUc4SmNpTEF6S1duS0owaHpLV3N6bkpoZS8xLzN0eVdjOWJ6NEJj?=
 =?gb2312?B?T1VRQk1CNUYvbDh6dlA2QkFMeVE2L1luVlJvSUJVallSQ3pHVVVvVlZ0WU1N?=
 =?gb2312?B?UDYwUUppODZLS0l3VWtzUkpKOXM2ZGtGOEYxRWdaVnBtS2R3blhyL1YydWt2?=
 =?gb2312?B?K0FucXNzS0tmSE5kNjNaZ3ZIbHBHNmJzN3lad2RvNDdhODZaeGVHcUJBUGEz?=
 =?gb2312?B?bVVkdWltTndOcjNSYmNra2N3NmpoUjNMR3RlZk9jbllDT05xSjFUakR4d2dj?=
 =?gb2312?B?MWJNditYeVFzSzdodFBsamhNVVRJWFFaQUE5ZklqUk0yRDB2anNheEhsNmc5?=
 =?gb2312?B?OERKU1FoRm0yMnFHQXRJNFdSWXhZL2JZSlRpTXY3dU1lOXY4anZETXFxeHlQ?=
 =?gb2312?B?bUhzd3AwUFBsdDByTmJXT1FGNExjb3cvVGErUzdkeC83cUxkMitHUzZqV1px?=
 =?gb2312?B?ckhXWmIxS1NleWRYUjhiSUtxblphTERjYVovZUZyMG1Qbm9ud1llMms0MEZZ?=
 =?gb2312?B?Z3ZEclgyK3NKQnNvKzdtUHZQUFhHTmFSWmN1Vi9qZTZYK2t6NTNyWDN0Mklp?=
 =?gb2312?B?VVN2YVBXem9qVXVVMWhsZ3h0aVFkUXJ2NWZ6amVTRW5EYVNkeFUwWktxU2FP?=
 =?gb2312?B?RnpzNE9EODVkamN0OTRxUCtsZTFFeDF1RDZvUlJlUi9XMFpFMER0Y042ODZK?=
 =?gb2312?B?UWhmNElBcFYxYzhmcDFpWHpvZ0tpUTJRU3pYTkc4ZitnUUdOT3Rza0F2alhm?=
 =?gb2312?B?MU5PM0xiSVY2SUh3WG5TUHgva3RBL3hPU1RXM2U5V3dGOE9WeXhMWjNLMjdC?=
 =?gb2312?B?NE9hRnhLOWhKdzAwbk9hZnA1Qk1FQ2F6QWYzeEJtMzBnY2hNaFVES2pSVDRu?=
 =?gb2312?B?dU5oYzIvRXNQRkgyWFlMRTFrNkswU2NqNXowaHZ2YmV0Q2lNVWIrN3VUaklX?=
 =?gb2312?B?aC9JdFJYQktRdWw3MncvaEtpaXBLVHg3QU10Zlo0T294WjU4M3hwT0ZSenNX?=
 =?gb2312?B?cDFTZ2ltWDcza2FtOFFwZnh2NjU4L0JPcmxBaVVHUFhXbE5QL1lVQjhuZDNF?=
 =?gb2312?B?NWh0N1FiSXplbTZLUEQxbEVvSHhGVFNmNi8zZ3dsQlN3SEkxYzhHVXBIVnZS?=
 =?gb2312?B?QWJGbmUvSTB3d0svTk83WFEyQy9Yais0ZFltUDlMUHJncFlrVVZLd0RpMVla?=
 =?gb2312?B?Z25lUWN4bUJrb1JSSXZDWlNpdTdUdFVlY21QYk1uOEsyQWxWRVBLMXZ0ajM1?=
 =?gb2312?B?V0xVanB3VG9nOUtRWE5HZWUzVm4rc1owMWNoSTF1c1FVSkVObm5qL0hyT2hq?=
 =?gb2312?B?VW9pWFFGRmRGM2x0Q2YyMEVPRzA1VnR6bkpqK2o3ek1oaDZhVXlTLy93Z1hO?=
 =?gb2312?B?cXQxeHZvbXRXcHRobE1LVFJSOHJaLzJBZWF5bzNCOHB3enNzdnUrWHN4cTF1?=
 =?gb2312?B?c2djSURrNjd4T3BZdFdQUndLWms1dUJ1UExpUUc4YTlGZi83WlFDYnowVC9u?=
 =?gb2312?B?dTZ5K0t1YmROQTlIYnRDQ3BoS1dZUkRmc3ExWVR3S3NKajdBeGNpU1JaYmxY?=
 =?gb2312?B?L25DVGhySTErNm5Kc2hFVlNOcTNLZDNkT3cvSTgvNTZWQ3B2dnB4aXBka0Yy?=
 =?gb2312?B?cDRDOW9OMnRCU015UkZyL3hIbHlFcVJZcDZjZnZJM0x4VXNicHI3UVY0dDN5?=
 =?gb2312?B?VGxGUUNyYVlFNnJ3K1Z6c1lESGdEVFlZc0dYbWNMME1rT0toVldTcis4ajND?=
 =?gb2312?Q?v5xw=3D?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 92780884-cb64-4301-5c66-08dd02b8b1f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 01:24:03.8893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +rYJPnorfIXwy7+zeRLEMg0FnmXMjcQZEcMkB3J5//Ww0VdAg4eHoON//U4MbI9WD4Ee1SWXj5ICAkv/1PCj4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7840

PiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFdlaSBGYW5nDQo+
ID4gPiBTZW50OiAyMDI0xOoxMdTCMTHI1SAxNzoyNg0KPiA+ID4gVG86IENsYXVkaXUgTWFub2ls
IDxjbGF1ZGl1Lm1hbm9pbEBueHAuY29tPg0KPiA+ID4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBpbXhAbGlzdHMubGludXgu
ZGV2OyBWbGFkaW1pciBPbHRlYW4gPHZsYWRpbWlyLm9sdGVhbkBueHAuY29tPjsgQ2xhcmsNCj4g
PiA+IFdhbmcgPHhpYW9uaW5nLndhbmdAbnhwLmNvbT47IGFuZHJldytuZXRkZXZAbHVubi5jaDsN
Cj4gPiA+IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2Vy
bmVsLm9yZzsNCj4gPiA+IHBhYmVuaUByZWRoYXQuY29tOyBGcmFuayBMaSA8ZnJhbmsubGlAbnhw
LmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjIgbmV0LW5leHQgMi81XSBuZXQ6IGVu
ZXRjOiBhZGQgVHggY2hlY2tzdW0NCj4gPiA+IG9mZmxvYWQgZm9yDQo+ID4gPiBpLk1YOTUgRU5F
VEMNCj4gPiA+DQo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxl
L2VuZXRjL2VuZXRjLmMNCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVl
c2NhbGUvZW5ldGMvZW5ldGMuYw0KPiA+ID4gPiA+IEBAIC0xNDMsNiArMTQzLDI3IEBAIHN0YXRp
YyBpbnQgZW5ldGNfcHRwX3BhcnNlKHN0cnVjdCBza19idWZmDQo+ID4gPiA+ID4gKnNrYiwgdTgg
KnVkcCwNCj4gPiA+ID4gPiAgCXJldHVybiAwOw0KPiA+ID4gPiA+ICB9DQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiArc3RhdGljIGJvb2wgZW5ldGNfdHhfY3N1bV9vZmZsb2FkX2NoZWNrKHN0cnVjdCBz
a19idWZmICpza2IpIHsNCj4gPiA+ID4gPiArCWlmIChpcF9oZHIoc2tiKS0+dmVyc2lvbiA9PSA0
KQ0KPiA+ID4gPg0KPiA+ID4gPiBJIHdvdWxkIGF2b2lkIHVzaW5nIGlwX2hkcigpLCBvciBhbnkg
Zm9ybSBvZiB0b3VjaGluZyBwYWNrZWQgZGF0YQ0KPiA+ID4gPiBhbmQgdHJ5IGV4dHJhY3QgdGhp
cyBraW5kIG9mIGluZm8gZGlyZWN0bHkgZnJvbSB0aGUgc2tiIG1ldGFkYXRhDQo+ID4gPiA+IGlu
c3RlYWQsIHNlZSBhbHNvIGNvbW1lbnQgYmVsb3cuDQo+ID4gPiA+DQo+ID4gPiA+IGkuZS4sIHdo
eSBub3Q6DQo+ID4gPiA+IGlmIChza2ItPnByb3RvY29sID09IGh0b25zKEVUSF9QX0lQVjYpKSAu
LiAgZXRjLiA/DQo+ID4gPg0KPiA+ID4gc2tiLT5wcm90b2NvbCBtYXkgYmUgVkxBTiBwcm90b2Nv
bCwgc3VjaCBhcyBFVEhfUF84MDIxUSwNCj4gPiBFVEhfUF84MDIxQUQuDQo+ID4gPiBJZiBzbywg
aXQgaXMgaW1wb3NzaWJsZSB0byBkZXRlcm1pbmUgd2hldGhlciBpdCBpcyBhbiBJUHY0IG9yIElQ
djYNCj4gPiA+IGZyYW1lcyB0aHJvdWdoIHByb3RvY29sLg0KPiA+ID4NCj4gPiA+ID4gb3INCj4g
PiA+ID4gc3dpdGNoIChza2ItPmNzdW1fb2Zmc2V0KSB7DQo+ID4gPiA+IGNhc2Ugb2Zmc2V0b2Yo
c3RydWN0IHRjcGhkciwgY2hlY2spOg0KPiA+ID4gPiBbLi4uXQ0KPiA+ID4gPiBjYXNlIG9mZnNl
dG9mKHN0cnVjdCB1ZHBoZHIsIGNoZWNrKToNCj4gPiA+ID4gWy4uLl0NCj4gPiA+DQo+ID4gPiBU
aGlzIHNlZW1zIHRvIGJlIGFibGUgdG8gYmUgdXNlZCB0byBkZXRlcm1pbmUgd2hldGhlciBpdCBp
cyBhIFVEUCBvcg0KPiA+ID4gVENQIGZyYW1lLg0KPiA+ID4gVGhhbmtzLg0KPiA+ID4NCj4gPiA+
ID4NCj4gPiA+ID4gPiArCQlyZXR1cm4gaXBfaGRyKHNrYiktPnByb3RvY29sID09IElQUFJPVE9f
VENQIHx8DQo+ID4gPiA+ID4gKwkJICAgICAgIGlwX2hkcihza2IpLT5wcm90b2NvbCA9PSBJUFBS
T1RPX1VEUDsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKwlpZiAoaXBfaGRyKHNrYiktPnZlcnNp
b24gPT0gNikNCj4gPiA+ID4gPiArCQlyZXR1cm4gaXB2Nl9oZHIoc2tiKS0+bmV4dGhkciA9PSBO
RVhUSERSX1RDUCB8fA0KPiA+ID4gPiA+ICsJCSAgICAgICBpcHY2X2hkcihza2IpLT5uZXh0aGRy
ID09IE5FWFRIRFJfVURQOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArCXJldHVybiBmYWxzZTsN
Cj4gPiA+ID4gPiArfQ0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArc3RhdGljIGJvb2wgZW5ldGNf
c2tiX2lzX3RjcChzdHJ1Y3Qgc2tfYnVmZiAqc2tiKSB7DQo+ID4gPiA+DQo+ID4gPiA+IFRoZXJl
IGlzIGEgbW9yZSBlZmZpY2llbnQgd2F5IG9mIGNoZWNraW5nIGlmIEw0IGlzIFRDUCwgd2l0aG91
dA0KPiA+ID4gPiB0b3VjaGluZyBwYWNrZXQgZGF0YSwgaS5lLiB0aHJvdWdoIHRoZSAnY3N1bV9v
ZmZzZXQnIHNrYiBmaWVsZDoNCj4gPiA+ID4gcmV0dXJuIHNrYi0+Y3N1bV9vZmZzZXQgPT0gb2Zm
c2V0b2Yoc3RydWN0IHRjcGhkciwgY2hlY2spOw0KPiA+ID4gPg0KPiA+ID4gPiBQbHMuIGhhdmUg
YSBsb29rIGF0IHRoZXNlIG9wdGltaXphdGlvbnMsIEkgd291bGQgZXhwZWN0IHZpc2libGUNCj4g
PiA+ID4gaW1wcm92ZW1lbnRzIGluIHRocm91Z2hwdXQuIFRoYW5rcy4NCj4gPiA+DQo+ID4gPiBG
b3Igc21hbGwgcGFja2V0cyB0aGlzIG1pZ2h0IGltcHJvdmUgcGVyZm9ybWFuY2UsIGJ1dCBJJ20g
bm90IHN1cmUgaWYNCj4gPiA+IGl0IHdvdWxkIGJlIGEgc2lnbmlmaWNhbnQgaW1wcm92ZW1lbnQu
IDopDQo+ID4gPg0KPiA+DQo+ID4gSSBkaWRuJ3Qgc2VlIGFueSB2aXNpYmxlIGltcHJvdmVtZW50
cyBpbiBwZXJmb3JtYW5jZSBhZnRlciB1c2luZyBjc3VtX29mZnNldC4NCj4gPiBGb3IgZXhhbXBs
ZSwgd2hlbiB1c2luZyBwa3RnZW4gdG8gc2VuZCAxMCwwMDAsMDAwIHBhY2tldHMsIHRoZSB0aW1l
IHRha2VuDQo+IGlzDQo+ID4gYWxtb3N0IHRoZSBzYW1lIHJlZ2FyZGxlc3Mgb2Ygd2hldGhlciB0
aGV5IGFyZSBsYXJnZSBvciBzbWFsbCBwYWNrZXRzLCBhbmQNCj4gdGhlDQo+ID4gQ1BVIGlkbGUg
cmF0aW8gc2VlbiB0aHJvdWdoIHRoZSB0b3AgY29tbWFuZCBpcyBhbHNvIGJhc2ljYWxseSB0aGUg
c2FtZS4NCj4gQWxzbywNCj4gPiB0aGUgVURQIHBlcmZvcm1hbmNlIHRlc3RlZCBieSBpcGVyZjMg
aXMgYmFzaWNhbGx5IHRoZSBzYW1lLg0KPiA+DQo+IA0KPiBNYXliZSB0aGVyZSdzIGEgYmlnZ2Vy
IGJvdHRsZW5lY2sgc29tZXdoZXJlIGVsc2UuIEkgd291bGQgY2hhbmdlDQo+IGVuZXRjX3NrYl9p
c190Y3AoKQ0KPiByZWdhcmRsZXNzLCBpbnN0ZWFkIG9mICdpZiAoaXBfaGRyKCkgPT0gNCkgLi4u
IGVsc2UgLi4uJywgeW91IGNhbiBoYXZlIHRoZSBvbmUgbGluZQ0KPiByZXR1cm4gc3RhdGVtZW50
DQo+IGFib3ZlLg0KPiANCg0KWWVhaCwgSSBjYW4gcmVmaW5lIGVuZXRjX3NrYl9pc190Y3AoKSBh
bmQgZW5ldGNfdHhfY3N1bV9vZmZsb2FkX2NoZWNrKCkNCnRocm91Z2ggY3N1bV9vZmZzZXQsIHRo
aXMgaXMgbG9naWNhbGx5IHNpbXBsZXIuDQoNCj4gQXMgY29tbWVudGVkIGJlZm9yZSwgSSB3b3Vs
ZCB0cnkgdG8gZ2V0IHJpZCBvZiBhbnkgYWNjZXNzIHRvIHBhY2tldCBjb250ZW50IGlmDQo+IHNr
YiBtZXRhZGF0YQ0KPiBmaWVsZHMgY291bGQgYmUgdXNlZCBpbnN0ZWFkLCBidXQgSSBkb24gaGF2
ZSBhIHNvbHV0aW9uIG5vdyBvbiBob3cgdG8gcmV0cmlldmUNCj4gdGhlIElQIHByb3RvY29sDQo+
IHZlcnNpb24gdGhpcyB3YXkuDQo+IA0KPiBUaGFua3MgZm9yIHRlc3RpbmcgYW55d2F5Lg0KPiAN
Cg0K

