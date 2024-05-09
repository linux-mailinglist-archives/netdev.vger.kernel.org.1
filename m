Return-Path: <netdev+bounces-94873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5548C0EB3
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFFE11C20C3D
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFD0130E55;
	Thu,  9 May 2024 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O7f9YAU2"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2053.outbound.protection.outlook.com [40.107.105.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D7113172A
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715253058; cv=fail; b=JHHjJzeYzFFXkj/zAEf/EsTMB9/KGpYCE4UHnNko3TgW87vZpzViDjuHWTNT8DGRmaxDG623n5Si5P1eeGPDQpxSuufCncl6B8EPmO4eIHTSL7JbauTaW+vBEAU/tYceG3eH74nqvsUsNmp58vVSwa7Bk/apgb0rOvN++lFOFtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715253058; c=relaxed/simple;
	bh=EkHWIj1GQIY88QbK/CYaFVdhNwOHV1VywRIt8GHoVPU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iqRJNW47kK2HMchy5o3n9Qs7t+ALVb2fxD5O21yiOSOnRZEbbUWJxOXf6lXG7OgGVGmiVo2QSnBKv43GGUXtRAGw6EQxYy9z5Vo2ByPtIcN2ALA6RWAAKfHYRqtaQYqWZKaM5wo7/ix6A4lAS6r6rsMoHXkBPwO5/n9K8N+n/aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=O7f9YAU2; arc=fail smtp.client-ip=40.107.105.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQsPbHy3m0mK9Jv1fgWS8G5TGwmvZYrh8QUR4deKWphAJIoRbyZvQYmBf1M/6ot80VzFd/q71qKLibn/xP/rhqEvxdi4NZUtcSOWW4jgmoWcWxan9osacllG7X2e7sOeu/jdHmeOBZXioSUFCffcp50QolNWJgpCyWatCPOpcRp+M/bq80l7b5pu23207excWGNknZg4fnRelOORIwKzgPoJXEYVwBMSK7TdoArXCchS/UlikybAcXvWTk/umuWDC3EZDf9b5vRm5g1KNmFDICfhejG88OPTzaKdbOZYozouk4h0UbUP9F7xyPUw8iktIdNSLDh3eWJh/Q2CYPv6RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkHWIj1GQIY88QbK/CYaFVdhNwOHV1VywRIt8GHoVPU=;
 b=H6PrJF0WshIACsAWWGQ/ECZ9Hf4CL6hVpw7dupCjia2ZAhbG+QWwJvdksTKYgSB1pu2ldBWDAIPTHSJ0n5uRr2k0MyJgtvImrTAc72TlYRSV/ZoMbMKA89KwzKhqn0e5CKK33DwqFqnVCMVRQGIse0lObMjns5Nmwqek3QPbJIXUUTMKIt1mqVsozGn42+FD4hrxkR5LYgllo/LZm1FoLOzdjbG6BNYZvlCwpBQH33RFsjG5Sf7LoIbgIBh1hSR0Ln5P40WE2O42NtQ7lv8XrJSFdPuoE3UITb2SXNY6jNI8k7tvX1NEPE5wTRta3tNWO+kBpbwMrngU7OWGta+vfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkHWIj1GQIY88QbK/CYaFVdhNwOHV1VywRIt8GHoVPU=;
 b=O7f9YAU2zTLn6HgKIDFlV2nAZbrXqGhGgnFtD6l8130ojcTz0YJY5mqDipTCx5guYhixMISxc31Uhk4fmFbW6zWSSnthahYLbroRUidjKUhFNuNJy8iZpx+d3IsJGXTrdCgufn4HbAA0LDYlT0tlEnd+uYYTBDQ+hYz+jo7EL/0=
Received: from AM0PR0402MB3891.eurprd04.prod.outlook.com (2603:10a6:208:f::23)
 by AM8PR04MB7777.eurprd04.prod.outlook.com (2603:10a6:20b:236::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Thu, 9 May
 2024 11:10:46 +0000
Received: from AM0PR0402MB3891.eurprd04.prod.outlook.com
 ([fe80::6562:65a4:3e00:d0ed]) by AM0PR0402MB3891.eurprd04.prod.outlook.com
 ([fe80::6562:65a4:3e00:d0ed%7]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 11:10:46 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Erhard
 Furtner <erhard_f@mailbox.org>, "robh@kernel.org" <robh@kernel.org>,
	"elder@kernel.org" <elder@kernel.org>, "bhupesh.sharma@linaro.org"
	<bhupesh.sharma@linaro.org>, "benh@kernel.crashing.org"
	<benh@kernel.crashing.org>
Subject: RE: [PATCH net] eth: sungem: remove .ndo_poll_controller to avoid
 deadlocks
Thread-Topic: [PATCH net] eth: sungem: remove .ndo_poll_controller to avoid
 deadlocks
Thread-Index: AQHaoU3yS0gmIXnbQk2szQsAvRq5NbGOvVjg
Date: Thu, 9 May 2024 11:10:46 +0000
Message-ID:
 <AM0PR0402MB3891AD9FB1D365D243AFFCF388E62@AM0PR0402MB3891.eurprd04.prod.outlook.com>
References: <20240508134504.3560956-1-kuba@kernel.org>
In-Reply-To: <20240508134504.3560956-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR0402MB3891:EE_|AM8PR04MB7777:EE_
x-ms-office365-filtering-correlation-id: 87b93b18-0693-4f97-d0ac-08dc7018acd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|366007|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?gb2312?B?TjFvN1JXOVRVT2VMT2tBbWNDUnprZGsyVFdWSitqSml1b0syUGZWR0lydnYy?=
 =?gb2312?B?VnU3dm50UFVsTkJibjJXV3hoTVcxWEdCeDljUGxGOVdMb2lQVndIdG5MOHM2?=
 =?gb2312?B?ZDdxQzlJVXFrMDBqNDhubVBMYVpqdFMybW9uaG82WkpxdTd2SGxkRTNZUFFQ?=
 =?gb2312?B?d1BLcVRCQ3dHVWtNTE5vMWdCSXdJR1Z2NVM2YnA1S3dHMytmWEdIeHZQSDMv?=
 =?gb2312?B?Vmtib0xaZTZlOHNpcjdDL1IzQityMmFOYlBSSnJmQkgyb3lwZW81Z1E4RTJr?=
 =?gb2312?B?NUtDNTVwSGsyWnl3cy9samVKM2swL3k0SDRzUitpL2YzbTdpdFZob1lhNE1K?=
 =?gb2312?B?S2ZxRURiN0orL25MdGVDanJOMEtzc3ZPRk1sbG1wMHU3QW9wWDJ0SmdmcVgr?=
 =?gb2312?B?V1FGajU5OFdOdTgrdmFHTm00Zjh5azZGenpaNmxJUHNLZWpiK21JQ2Vpa0p0?=
 =?gb2312?B?MjcyemdlNjJEM2NFNGwzRVFLaWVXQldrUVpvZHhISjFhRVFrUklLYWpIZVRT?=
 =?gb2312?B?bUpkZDExTWsrTjBzMGZKVmp4dS9uZHVuay9GQjQxbS9PVXBuZG5UblNQRyt4?=
 =?gb2312?B?VmFOdGFON3RIQ2RQaDZTZGVMUFlJSFVMWDRGTitEREhHUUR2QUx0cDNpTUZ2?=
 =?gb2312?B?RVV5NGFhenpFT3pFZ3RYOU5HdWNpMFBkeU90SVRDTi96MDhuOGZnR3BUYUtW?=
 =?gb2312?B?blpXRmNUM0NrREtLS0M5Z1I5WU1lYzJ4V3QvdEowdkZvRnlqL3RDcjk1YURX?=
 =?gb2312?B?dTgwb0tvbnNLblpBTzRwM05WWHNnRkZ0Y21XNWRwNHBhZHdvdzBwNmkzK05p?=
 =?gb2312?B?MEp3RU5TRFdZdkdzSFZubXBZOG9MNmEzNTYyUUhZMFBIaGF2NGZoRXZvdlVJ?=
 =?gb2312?B?cmFsQjhwT25vYnArY3pSbUhHdUtIUUNBejV4N3NRQ1FGZnhNVHl4Z2xVajRr?=
 =?gb2312?B?SEVSakNIUk81b1U1K0ZqUlB5d2wvN2RnWlA3MnliT0h5ZGMyWjJvOFdhaHhJ?=
 =?gb2312?B?S3VxNVZkZjBwRkJ5eWgxbExOdHhLK2tvNTlqOEhuRWFwTGw0N1F0R2dmSmZE?=
 =?gb2312?B?ZmlnSkQ3Y2Q1andSbmNsb2VCTnFzbGVNRnhyelBYUllZVjllZGNhSnJjdGht?=
 =?gb2312?B?Y3JKLzFPQnkyZXVrU25Cd1dkRnZEOHc1MU9LQ0V6bjg4aVZaVDFaSDd4Y05t?=
 =?gb2312?B?N252UUNJY2xtMkNDQm8rcHRHelR4Vk1lQUpIYjV0SXg0Y0U2TXFjOFUvc3F6?=
 =?gb2312?B?WU9xREE4TDNYdFljOVhNU2dYdm1IRzNmNFpVYXpyUWhTMWZFdEpibmUzQkxO?=
 =?gb2312?B?TlkrOU4za2E3blh5dWg1Tnh3ZTF1aGx6cXI4TU9RSDJrQW9xQktJL3RRZGMr?=
 =?gb2312?B?cEI4ck10SXRyYlhsdERtekF5VW96WkM4S0ErSnBBcSt2R0pEb0kzbjY3U1A2?=
 =?gb2312?B?VlIwZldVemZRSjhrWHNZR2kxOVFQVERiNHdKdk5oUEdaUUdSMWdCc0dSUFNL?=
 =?gb2312?B?bDF0eHdDeTZjZXR3RHk3YUVyQjJLam04Ky9aeERXNHB0czc2bHNmMzRLRHQ0?=
 =?gb2312?B?OVQrc0pxbDRLNXh0aHZQd2F4TDYwN0t3a1NxM2ljRGxwLzZaeGJ0dDJZZVR3?=
 =?gb2312?B?bkI1emVmNEQ0WTQyUElsOFE3U3pWblVRWTRkeC9lUllNMk1wekZ1d0x3WHdI?=
 =?gb2312?B?YjduUEYxU3JuMnE1WUVxL09QMUJDTW5JNnRvYnhieVNTcEpSYTd1QnU0OUxp?=
 =?gb2312?B?MDJFNFNiY2FkSmxLV2dNV2NRaUlzSnU0NTYzalQ0ckJxTlJMZFlIUzdXcGtO?=
 =?gb2312?B?Rld5RXhMUTRPMXZwdytpdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3891.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?dUttcGhlTUpXR0Qwb0ZGdGdLOURyNW5Eb1JERHdpdXBJS2Vza3ZmWEFnak5T?=
 =?gb2312?B?SDVib3BncnF3ODdXV3ZDYVBYdWJ0TFErekp2K2FBVzg1TDNCc1pFTDFZcVZ5?=
 =?gb2312?B?ZVRVbEpKWFZwWHFkZmZkejVIZ1NWYTZVZk92L2d5UkFSZkJOQktMbHdCelYz?=
 =?gb2312?B?bWRZbVdna0xFTkFZOWZxSmt2TnVOZTFoR055TEtUSWFrYWxIb1BPaExuUUVo?=
 =?gb2312?B?WmxkcUtBc1dCdXo2aEhwRzBKR0VBejF5N2ZnWU5lMXdjY3haTEFudXFGVk02?=
 =?gb2312?B?cGFqamNLaGVzQmJHMlExVURrUlRIaHVwMlRrNVUyU0FFSkVvcXFPdWFqeDVD?=
 =?gb2312?B?eU95NkUwa1ozSGdBckd1S0dnZDlscWI5NVVaOVdwOHJiUzMvQ210L21ubml5?=
 =?gb2312?B?dnVTSUNkcktHdzRkaUFjcW0wZFVtZW5UaGFJOWthNnJHQk16WlA1cWZqdU9G?=
 =?gb2312?B?VmVaYnM4SG9xcFBrZTBxNHc0eExKS0ZYTjg0UHYxaGFSODF4dnVpcGxXcDZU?=
 =?gb2312?B?OGNkWUE0aUJFNGdGdmxCZjBOaDF1bDNPM2dZZm8yeFBvTWRKK1JNQ1RiMk5s?=
 =?gb2312?B?bXY3RkJMdXRBZ08rZVJFVjFKVGYzUWU0c08rZ2JiektQWk84a0hvTmxGaWVR?=
 =?gb2312?B?Zmd2eGJlYXk5ajRsTHlhL1lNTUV3WXd1RWhpa1lYVjNNNDY4aFBhNk1odGFu?=
 =?gb2312?B?Q2ZmeTVBZTQrNXlDZWV2NEdLaW9sRVZZRGhrVlUwbGMydHN3VTVZdzNGR1dz?=
 =?gb2312?B?TW5hQmxzUXRkOUkxNGJGNVRnMVJJYVBMeGJhMUVJWkxjOWRIU3V0Z1lrVXZs?=
 =?gb2312?B?MmxnM0JsVEsyb2tpM3l3bGdaSmluWXdVNGY1UnMwVVcyS25aUlovQTNYYThu?=
 =?gb2312?B?cVJIakVBZVpZS3RUbXNsczFSZlNkWDVESlNPdURwekpzMm9iS01SNWRsdnpl?=
 =?gb2312?B?UUx1N2xVSjNldkk1NTFqZysxalVycEZqbi9abWRQSjBmQTZDS0lrMkZOcTVo?=
 =?gb2312?B?bGVwaWdCNGFXZkJ2bkhVRjhmQUpKVGIxQktObFR6OE5aSVlqVjhzMS9vRjBN?=
 =?gb2312?B?dDhnem9xSHlBNXNDVFJaekZJb1B4UnBjdzBQT1NmcTNDdTJ3YjVyTXpwcFRi?=
 =?gb2312?B?dEJyaGdrZXFQMWNGUW1VZ0F2a3ViOGZ3SldJZTR3VnhNTHRVM2k3dHdOREpo?=
 =?gb2312?B?OHlqYjk4dHJZQVZJYytkSlpzR0hrQ3phN05rOG0rRUF3cDJwS3RaY1p1a3hN?=
 =?gb2312?B?RTRZSThEbmkzTS9jZ1ZLaDdLTGxpRGtXSHRhZkZObnp2Sjd4TllJR1VKaHY0?=
 =?gb2312?B?UGxMWTBYTTlDRVNsUDFZY3haQ1VDa1c0V0lXeG05bHpNMXh5MVl0KzVOdGdp?=
 =?gb2312?B?WjlYeEhaZVgyLzQ2ZjVMbmVYeFUyN0x1TGVPU3V5aGpmUEVpTnI0WkVoUzhv?=
 =?gb2312?B?WGprV3Z6c0RIVWtxemg4bE9jVDdMZHEyRllsRnM4Y1Z3MnZLTlJ4NzdqdjNL?=
 =?gb2312?B?U3k5aGZYSXV4YnNDbi94NUk5Z3ExZXNUNGFsNTdaMmxqUGhTOVF1c254dGto?=
 =?gb2312?B?ckFDcGJ0czY5ZmNpcWtmdkt0aC96M2Fueis2VmFZNFJMYVorVWEyNUxhOVN1?=
 =?gb2312?B?RVpISEV5cTZ0R3RFUTlkYjhuTitvSURVRktjV21lS2pFTEpqVmF0WUw3bVUv?=
 =?gb2312?B?MW5LZjBnV2lxNWg2T1V3bGJ5Sjg0Y2xpeTFDTkJ0YjlUUWl3YytsdmR6R1Qw?=
 =?gb2312?B?YThFSmh5aS9qU2VXQnJaYnZuY3lWYmkvdlhuNFhUcEQ3VXJjUUZqelVic2NE?=
 =?gb2312?B?Uk00K1VJbnBLQTV1QWlpZHAxOVllc24zYVJ2VVRPSEtkR1JRdjFlZVdSVENq?=
 =?gb2312?B?WmcvaVVxeGVXUk92ckRIbysvMDJLNHFZOFBJVUdhaXkvV3RKR2ZpTThlKzZI?=
 =?gb2312?B?LzRGU05rUEM3QU1JSHJ5dmVaeG91ZXJMWWZ3ZFhrZDJHZmRHTUtBTEZwd000?=
 =?gb2312?B?NnJqK0dXYU56dDFPdXRyM0ZSenprRCs2eDJjRlEzaEJZSDh6Ynk0Vm5tU0N2?=
 =?gb2312?B?UVVpVFBRWVQwcWRvTXZUa3B5S3pzcG8vbElBM0NOalc1RFlWalpqN1k0Y0Fi?=
 =?gb2312?Q?Ae0g=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3891.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b93b18-0693-4f97-d0ac-08dc7018acd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 11:10:46.1054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vYpe+C9ewhT7HTUpcndAWfwjqt1Wlbv5iFELrH/Boa7KX/C9prPNDdAOm7B3Qk5XKXff494N+pm5ikseBpDg9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7777

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpha3ViIEtpY2luc2tpIDxr
dWJhQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTE6jXUwjjI1SAyMTo0NQ0KPiBUbzogZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldA0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZWR1bWF6ZXRAZ29v
Z2xlLmNvbTsgcGFiZW5pQHJlZGhhdC5jb207DQo+IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5l
bC5vcmc+OyBFcmhhcmQgRnVydG5lciA8ZXJoYXJkX2ZAbWFpbGJveC5vcmc+Ow0KPiByb2JoQGtl
cm5lbC5vcmc7IGVsZGVyQGtlcm5lbC5vcmc7IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPjsN
Cj4gYmh1cGVzaC5zaGFybWFAbGluYXJvLm9yZzsgYmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnDQo+
IFN1YmplY3Q6IFtQQVRDSCBuZXRdIGV0aDogc3VuZ2VtOiByZW1vdmUgLm5kb19wb2xsX2NvbnRy
b2xsZXIgdG8gYXZvaWQNCj4gZGVhZGxvY2tzDQo+IA0KPiBFcmhhcmQgcmVwb3J0cyBuZXRwb2xs
IHdhcm5pbmdzIGZyb20gc3VuZ2VtOg0KPiANCj4gICBuZXRwb2xsX3NlbmRfc2tiX29uX2Rldigp
OiBldGgwIGVuYWJsZWQgaW50ZXJydXB0cyBpbiBwb2xsDQo+IChnZW1fc3RhcnRfeG1pdCsweDAv
MHgzOTgpDQo+ICAgV0FSTklORzogQ1BVOiAxIFBJRDogMSBhdCBuZXQvY29yZS9uZXRwb2xsLmM6
MzcwDQo+IG5ldHBvbGxfc2VuZF9za2IrMHgxZmMvMHgyMGMNCj4gDQo+IGdlbV9wb2xsX2NvbnRy
b2xsZXIoKSBkaXNhYmxlcyBpbnRlcnJ1cHRzLCB3aGljaCBtYXkgc2xlZXAuDQo+IFdlIGNhbid0
IHNsZWVwIGluIG5ldHBvbGwsIGl0IGhhcyBpbnRlcnJ1cHRzIGRpc2FibGVkIGNvbXBsZXRlbHku
DQo+IFN0cmFuZ2VseSwgZ2VtX3BvbGxfY29udHJvbGxlcigpIGRvZXNuJ3QgZXZlbiBwb2xsIHRo
ZSBjb21wbGV0aW9ucywgYW5kDQo+IGluc3RlYWQgYWN0cyBhcyBpZiBhbiBpbnRlcnJ1cHQgaGFz
IGZpcmVkIHNvIGl0IGp1c3Qgc2NoZWR1bGVzIE5BUEkgYW5kIGV4aXRzLg0KPiBOb25lIG9mIHRo
aXMgaGFzIGJlZW4gbmVjZXNzYXJ5IGZvciB5ZWFycywgc2luY2UgbmV0cG9sbCBpbnZva2VzIE5B
UEkgZGlyZWN0bHkuDQo+IA0KDQpUaGFua3MgZm9yIHJlbWluZGVyLg0KVGhlIGZlYyBkcml2ZXIg
c2hvdWxkIGhhdmUgdGhlIHNhbWUgaXNzdWUsIGJ1dCBJIGRvbid0IGtub3cgbXVjaCBhYm91dCBu
ZXRwb2xsLA0KaXMgbmRvX3BvbGxfY29udHJvbGxlcigpIG5vIG5lZWRlZCBhbnltb3JlPyBzbyBp
dCBjYW4gYmUgc2FmZWx5IGRlbGV0ZWQgZnJvbQ0KZGV2aWNlIGRyaXZlcj8NCg==

