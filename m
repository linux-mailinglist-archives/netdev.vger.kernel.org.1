Return-Path: <netdev+bounces-235246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CB0C2E4E5
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 23:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1376D3B6DC2
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 22:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26442517AA;
	Mon,  3 Nov 2025 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="lXfgnmU+"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754D121FF5B;
	Mon,  3 Nov 2025 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762209980; cv=fail; b=g5daAnYLffPErmYSqE5w55kt3Hszrbvx3Ki3sR1PTDsPEilBLx4i9EIzwWMK7ZwOaOyEdG4l6aElnG0n6UkCin/Yu2c1I09xg2MvBtYqM7aFipJrlJYfiGy1qc69F7RZw+UYL6hC0gNN0Vq47kmRPbcATJg0MhTCsBn+qPT8KnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762209980; c=relaxed/simple;
	bh=gaprnPhR8PUwObVWiTmeayiG3kRiumofAqqwkfcZ47U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QsJZJ+AhtiRjXiDaPH+ok/0GklA0Zh6QN/Xy4OKQBbIocszaABBtkkNvJ2mBqqYkis+ftm0QA+XmH+nkqid6NitME2en3sv1HCt6Tecfiws/FPtg4Q9CS4gKoyLNrcyk7x1LzXVsLZk8w1nusSFWGnOz5uyxndQk3Ix0sl4AEa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=lXfgnmU+; arc=fail smtp.client-ip=40.107.159.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyHOvv6GfJE5XuwayFlzOpCm9uQreCRwwneLufiKk1dtHdp7XynzDwyImaprHV6121lZQ31f8ub0EX0LPl2Laov2VUee3J21Yo3O4YSCVBg16zxjFRJIVDTwizbbSpzUJbcIw0ATeGPvFu+YcK6I6KqFHdfACd2CeUsTlc5FGlTv8RIMcUR75lbSPN1we83jzegu8iYkhuSLC09PlRKcO4cXPPRd0EH0Yn1A7+5FUr0mQe6AdtzGacgiQCLNgOj3dpxS/BVQj+6p6I2nn7Y1/H98qAdvAsw6V6OF4iTT3v80FZwrosTPRDiU4QS6LzB3jSUx2drHqHnYTkvy6oz5Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaprnPhR8PUwObVWiTmeayiG3kRiumofAqqwkfcZ47U=;
 b=ZsLE8d8jq8WLZzW46ahfE4wKnyKLLjwvyAIIrIcxwgKNuAQy0fORIVXk2p4pxHT4+rXyHBsIWZBuWKSbTzvt/ax8G+bHTVN0svvsQWIjqS+l5WfTLxQx2XwtPR48PmpJcmc3rUn9uFhcgjt8Pro3IQckdAJXMc5BpzCwuPLoP/eYmpqIP0pznx9qbbHvjss1wWEjqOabDdqydz0gcp09w/r+/2RYBvgpYkScww4fYgGOniABt7XZjzFmFWVPO94MwSBMqvplvdDzBor6Z7xLaMrOhILVhXa0ASl4d4fW1Ajyr5KqJLeYdgSpaM/9WbYu965adYOYv3hXhrOG2xsnWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaprnPhR8PUwObVWiTmeayiG3kRiumofAqqwkfcZ47U=;
 b=lXfgnmU+9lHZn3XYpHaD/O+M2SOjmhmewLgI7LZzrgoy5etnuTKSIlLeb9gpwq9ziF8aMrh9tM7ZrcriybvJDdv510diA1KwzqdpILdhNRzwgdE4cd23JREW6RfpwO6TWYA278cr/yWlKtXLddF8/zFrsJFLyr+wKXRHXwumMv95xmLWTKn6N9bJxDY98Bs2k4m0gkwvmm2KXHrXZsgPk5IqeUei+HLe06vEMsKu5izAtWbQOL74Jd1GKmIqn8zp+ITiAFgUIThfSNQi/ZievUHQuhD0R0mW7u8QQ7BWPMFxWnlp8dtF5y68eX5gqPeg5p8qyPRM5RD0oqDGndkTcQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by GVXPR10MB8198.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 22:46:13 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 22:46:13 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "daniel@makrotopia.org" <daniel@makrotopia.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "robh@kernel.org" <robh@kernel.org>, "lxu@maxlinear.com"
	<lxu@maxlinear.com>, "john@phrozen.org" <john@phrozen.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "yweng@maxlinear.com"
	<yweng@maxlinear.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "bxu@maxlinear.com"
	<bxu@maxlinear.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "fchan@maxlinear.com" <fchan@maxlinear.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "hauke@hauke-m.de"
	<hauke@hauke-m.de>, "horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "ajayaraman@maxlinear.com" <ajayaraman@maxlinear.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "jpovazanec@maxlinear.com"
	<jpovazanec@maxlinear.com>
Subject: Re: [PATCH net-next v5 12/12] net: dsa: add driver for MaxLinear
 GSW1xx switch family
Thread-Topic: [PATCH net-next v5 12/12] net: dsa: add driver for MaxLinear
 GSW1xx switch family
Thread-Index: AQHcSZCXaB6f1YuNi0uvpiLknDgJsLTbUfIAgAF6cgCABMfIgA==
Date: Mon, 3 Nov 2025 22:46:12 +0000
Message-ID: <cf004026f7a44fc924d71e4494ba6622682fbf64.camel@siemens.com>
References: <cover.1761823194.git.daniel@makrotopia.org>
	 <229278f2a02ac2b145f425f282f5a84d07475021.1761823194.git.daniel@makrotopia.org>
	 <3945b89128c71d2d0c9bda3a2d927f3c53b50c87.camel@siemens.com>
	 <aQUuHjhWSJgYsTEn@makrotopia.org>
In-Reply-To: <aQUuHjhWSJgYsTEn@makrotopia.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|GVXPR10MB8198:EE_
x-ms-office365-filtering-correlation-id: aa245365-69fa-490d-bef8-08de1b2aca54
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SmZaajJ4cXJvMFFZYjY1Um0vV0dkK0dlTlFEUnRlVnd3UFh6STBHYnZZaU42?=
 =?utf-8?B?TUMrUDBxb0J5T3Q0STVKdjZVK29Va1NpNWYvU01MdVQ5M3NTUjVqTXpRYUdh?=
 =?utf-8?B?aUR0WGZJNTBTTERLQjBXVUZzV2JQaFcwY05ZaUUzcHFTTm11aU1uMXN1KytE?=
 =?utf-8?B?OFNZTnhzUHEvdDJpQS9OUzcycjlRRzFHMmtkZVk4b0t0R3UrTHhTZ1pzYjRu?=
 =?utf-8?B?OWV4dVFwZkt1ZW9QUys1MVkxRVl2TmFWeXZUL21LYzhzbng3UEIxUFlWbzRT?=
 =?utf-8?B?UURjelU4NFV4NzRmaFVHV3NjeUpCRmZBMG5LYm5vS0YrbmxLRnljY1JPVGMr?=
 =?utf-8?B?cWpFV1JCMk9KQlNsOGl1RmFiNEZRajBndytPaEI2OE5rQllQeUN3SGNueFRx?=
 =?utf-8?B?cm1oNnhSdXVqcUdDTjdjcmVoOUtZekFYTkw5RW9XZjV1VFNTeERra1RDTmNn?=
 =?utf-8?B?MExoOE1FOTJCRmNRSEs2RVRhNjNqTXM1alpyR1pkTVhoMy9oSEZZRVp2MGQ5?=
 =?utf-8?B?VUxjeHRVNjFDZ1ZGbmIzcUo3TlhWcm5neGhjdzZZQlRJdndKL2d6VFVweGE5?=
 =?utf-8?B?Ny9VSHhNb2dTNDBjalVFN2pnSDhTS1RxL08ycWh3ZSs0Wm44TDFWTVNOYzdH?=
 =?utf-8?B?SFBQTytSazJpOVo5OGhHSTR1OFE1UEdMZHFWL2tybDZHVUQxYklodEUwNG5K?=
 =?utf-8?B?RFh0ZFJQRlBqR0RjV2Q4SUgzTnYvTjJjdzlWUDRUeWdvTDYyVFZ3T3E0bS80?=
 =?utf-8?B?MlQzOWVMOUh2UEdYRVdxUTFoWGxBdmZQeGhxUHpRKys2ZmZUOXRtZGl6b2tB?=
 =?utf-8?B?S0E3VWNQM1RaUFh2L3BOMGJVNTIrd3ZMZDRSQUtHbDFRaFJRd29sL253NGpZ?=
 =?utf-8?B?S0VTWmVmTitmR2Uyek1ZN0JYUzVMblhpbU5wcFFFVTdCdUV0cks4UHZUekJk?=
 =?utf-8?B?T3FDMElPM2E4YnJrRXdvZ2hyb05CbmZWK21pWUxkWjVPZk1lSXNSM3N2VHo2?=
 =?utf-8?B?ckxsMWwvbUZjd3VrSVJBdktDKy9qMGNvZzByS1pmeUF0SkVXSVltOTc4NmY0?=
 =?utf-8?B?MkUzLy9KK29TNnNxQVo0NjFKVTg4UE54Mk1OaDJyQmM1d2VXRzVsSjNvZHhu?=
 =?utf-8?B?Mm5jTDFaUXpGZk9OMjdwZTNVam5UdUJyOU9qeUtwZVVoZEFDZnpmajRqYUND?=
 =?utf-8?B?TUhmYTlRRzRwRy9NSk5UUDhqem8vbkMrVmdkeHBKQ25xQmk5VmFaZXNndU83?=
 =?utf-8?B?K0k3M25URXNqZHdqVi9RWTRhTm5GaVJWdnhGVmZGeVNQK2F3eXFGeDU2c2VP?=
 =?utf-8?B?ZGFrUlhuejAzZ0tnaEwxNjg4aGlaa1hoYnBjcXVuVG5qOHBwdXlQa2ljbFdD?=
 =?utf-8?B?QzNhNXVsUUR1ZzdvbWswdGUvZVV3b3lpRlhsUXFENmRweW56cldaT1ltTGRy?=
 =?utf-8?B?eHc3SUxpQmZOQURQbk1SaU8xWXI0d0NaTnBvYUhVTXlFTDNPNHVSNG80R1R5?=
 =?utf-8?B?T3Z6NE9mWHJUUk0wNVJoNml2V3pTcnJqUXdub29zQlFrd1pTWXVkQ1hiWjkw?=
 =?utf-8?B?OUpHYmpKOEhEL2tlWjRyV2FWRWtEdFEzUTdTUFBxYUtnbk8zd3Zud2NuZWt1?=
 =?utf-8?B?ZHRjK1JhNUE1QVEyRlNoQkJ5ZFArTllxKzZwM0lWOEJzY3R4Nm1jOXVkQmNB?=
 =?utf-8?B?aGo5bERxbVBWMkNEOVk3bHRyeXVBOEE0Wm42c29aS0Z0UkFJNVpvaU80UnZz?=
 =?utf-8?B?b29STmhiL3JiUWNOMzArMlh5aVlkRnB1Sm5vQkFkMy9adzh0U0FjdUxTUmFV?=
 =?utf-8?B?L0l3VDJ3MXd4RHVGTnB6SnpOZktXbTdJS29vZlJZOXpkMFRhTVgyQjM2M3Vs?=
 =?utf-8?B?SHJrL0EwRWlxeDI3S2ZVSzZYcTFmbWY4QUNjV3EranRta3pLWVlrTnYvTXlF?=
 =?utf-8?B?U2Jkek4vMmxPd1ZJNUYwNVVQc2U2WnMreXFURDlCcG4vQUhTNWh2MHdXRDFq?=
 =?utf-8?B?NUp5STFzWDVnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UkNaZGxyK2dIbCtYb2t0dzNRd2V1V3lWMjRVT1ZxQlJabm01T2xVaDZNOVRk?=
 =?utf-8?B?aXBvTGZJeExrWmJrUEVSRUoyVnJIVTN3azEzUnpDMjBqQjduOCtWT1NMRmY0?=
 =?utf-8?B?bnBoMmxuclZGeFcxZ2JqajVRdnlrS3JmQWNkT0NTVkwzb041S1pHZ0N6Z2Vx?=
 =?utf-8?B?enc2eFdXeEdFVVpWK1V4STBkcWs4NG1mQUVCTHRXc1RqZWQ3S2FuNE95dnQ0?=
 =?utf-8?B?NzVRRG9jcjBhT2tIdXBRYTdyY2RxVkdYSndnRUJxbWcwb0c1MnI3b1JmYkNB?=
 =?utf-8?B?djdoaG1Cek1keXFZTFhQaTRaOFY4ZmNSL0lpTDBUenBheUowVDdqYUxBSlh2?=
 =?utf-8?B?M24vQUEyZlkvZjkrY3I0L2FCRWh0UFRtVm43M3BNT1diUjMyV0FVVzluK2du?=
 =?utf-8?B?eXl1SWN4clE1ZThZVXFiQkk3cFpuUGhvc2dFaVplWG5nRTYzdmVkTnY0aWlW?=
 =?utf-8?B?VnJLRDZ2ZHlkQ2d1a25ZRlBUOUtEcGNaanViVDZYUnBHVEcwTi9MZHNDRVhG?=
 =?utf-8?B?blpDakxBS0VVSkh2YjE2bXpid0lkTGd3Y3dlTjZyNmNsWDV3SG9NU0VPREZR?=
 =?utf-8?B?SkRNYlc1bFNpeDUzQmYrVHVyVTdaZHJrbUxKVEpVa3NIUDZqN0N0c1puSlgz?=
 =?utf-8?B?NVhlNlZpenI5RFpqbnN5M0ludUhudFc3MmljSGcrbFJiYmhtdzM4b1JucDVF?=
 =?utf-8?B?MUhsYnBXQU52R0FVVTRIQi84cXRTd0kxRGVBczJOWkhoWlF1S2RsU2l0NWJH?=
 =?utf-8?B?T1FJMytVQjBGMWlnUmcvWUs2Vy9wZ3N4cG9PTmsvTytFY3BKZjBxYjFOUUZJ?=
 =?utf-8?B?UE1vYWt6bHlTUm4xOVpCdUU3Y0phUU5RQzJ0WERFL1ptanVyME9mTm1GQzYx?=
 =?utf-8?B?aWhsY1FWVmxDWFZNZlBicFltVDVCNFV6dkd4cU0rOWx5eHBKUTJwQ3BZa1M1?=
 =?utf-8?B?cUFiSWk0Mjc0cmNIV2c3N1JJdGdNYWxUc3lZd3RSMlNhVDhybUVGcXl1S0Yv?=
 =?utf-8?B?M3U2RFBQWkNjNUpITnh5bW5WeWJDK1o0anNadW5ia3k2TE1BM0c3Y1paU013?=
 =?utf-8?B?ZkVhbHFUaHlFUGFKbGNaUkJwMkxLZW8wWDgvenRGTkQ3RGdhV29DcW9NbW9n?=
 =?utf-8?B?NjhiV2IyeTFRcUlyMVZxMTNOWU9XdDloS1pUeHp6YWdMZGVSSUZ6cmhUTEZK?=
 =?utf-8?B?bU1XejkzM2VHcXdYckszVEZheXBCdU1TenNmYW5ZaUFPM0RnMGFFek1xc0NO?=
 =?utf-8?B?NTh1bGhuVnNLbk1ISmVmbm9HNE5LRFBpRXNkQzZFMDUwVE9RRVZCVG5rajlX?=
 =?utf-8?B?QklicWVKR1JtTVhSTkZ2NTgvRE9aSTQ4MCt5eVkydndqWFJDSVpWMzRkb3FR?=
 =?utf-8?B?QW9LTHdkSXYyMFZEOGU5QjhBU1FkSi8yMFlpTm5qQ1FCalRZTFdFNXVwMU5X?=
 =?utf-8?B?WTVzWVExSFl1eE1qbXVJNURnalczdTBkeUxidTNiRStJYTN6YllPd21vbGRR?=
 =?utf-8?B?ZldLZ3ZVRUZjWmFYNTdqOFFpOW5seFJGMGNDQ3Y3YXJST3lyaGlDRXJ1dWdU?=
 =?utf-8?B?Y1B5aHJpOG1JSkdWaVcwTlZONXJpSkkydjZTdis0TUc2c2xWTmZrVzlrSzBJ?=
 =?utf-8?B?dzBEZFk1NWd3MC9vNUkrR3RjS3JDdW8xTy9wY2kydnp4MWdrMTdOdFJNQ083?=
 =?utf-8?B?YVJwZE5zVEpXdmg5ZllUSG9CT20xT2NRUlpHb2NTRzFXSkpEWHIxdkMxZzNM?=
 =?utf-8?B?emszb2xVMTBmanZkejM3YWdtWUZkRnBTcGlxeUpSNC95dStZOE5HL0VmR3g4?=
 =?utf-8?B?MHRYOWoyUVRUTDFERFpualJyMEF2ZStycXpvK25PWUVWK1RHb1FiNzltM3Ez?=
 =?utf-8?B?MXlzdzdMMkJ2bXl3dWxWMG41TUlIcTNwWWpyVWlZbXBOcmxhMThnT0ZTdHlz?=
 =?utf-8?B?Tk5OUWdmdWNkMWQ2djg0SSsvMXFPakVpcEtTaVk2bDhabkUvcUpTNHB6djFI?=
 =?utf-8?B?ejdseXh5ZGhpNmh4cG10Ui82K3dRWElYZlNMS1dUZEpTanBsT0dRczZjZWVv?=
 =?utf-8?B?ejdNQjZmK2tUejRpTU1CQkFmZk1UQXJHQVFMbDB5aU11bDRVdVJNZ2NsMlNT?=
 =?utf-8?B?eXQ0cXhVWGZvcWh3WlFROVFET1hSa1pvUXRFbkdqZHYxZktxdlk5QXBUbHZt?=
 =?utf-8?Q?igSo7IaIyUQWve5tPoY6TRc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AD97CC2860C0A42A6D222B7CC6CBFEF@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: aa245365-69fa-490d-bef8-08de1b2aca54
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 22:46:12.9941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bzd7r0eD208KabRQEeHXY541SkoEfwWILYAmrC/j2ed2g1Jj5i6y7AcJ9GoNAlckKnwyuqZ7X8gYy7f/cEHuIyWqVcUBVOxLchPI0HR3tXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8198

SGkgRGFuaWVsLA0KDQpPbiBGcmksIDIwMjUtMTAtMzEgYXQgMjE6NDYgKzAwMDAsIERhbmllbCBH
b2xsZSB3cm90ZToNCj4gT24gVGh1LCBPY3QgMzAsIDIwMjUgYXQgMTE6MTE6MzhQTSArMDAwMCwg
U3ZlcmRsaW4sIEFsZXhhbmRlciB3cm90ZToNCj4gPiBbLi4uXQ0KPiA+IEZvciBzb21lIHJlYXNv
biB3aXRoIGJvdGggdjQgYW5kIHY1IEkgY2FuIHJlbGlhYmx5IHJlcHJvZHVjZSB0aGUgZm9sbG93
aW5nDQo+ID4gd2FybmluZyAoQVNTRVJUX1JUTkwoKSkgYXQgdGhlIHZlcnkgYmVnaW5uaW5nIG9m
DQo+ID4gZHJpdmVycy9uZXQvZHNhL2xvY2FsX3Rlcm1pbmF0aW9uLnNoIHNlbGZ0ZXN0Og0KPiA+
IA0KPiA+IFJUTkw6IGFzc2VydGlvbiBmYWlsZWQgYXQgZ2l0L25ldC9jb3JlL2Rldi5jICg5NDgw
KQ0KPiA+IFdBUk5JTkc6IENQVTogMSBQSUQ6IDUyOSBhdCBnaXQvbmV0L2NvcmUvZGV2LmM6OTQ4
MCBfX2Rldl9zZXRfcHJvbWlzY3VpdHkrMHgxNzQvMHgxODgNCj4gPiBDUFU6IDEgVUlEOiA5OTYg
UElEOiA1MjkgQ29tbTogc3lzdGVtZC1yZXNvbHZlIFRhaW50ZWQ6IEfCoMKgwqDCoMKgwqDCoMKg
wqDCoCBPwqDCoMKgwqDCoMKgwqAgNi4xOC4wLXJjMitnaXRlOTA3OTMwMDA5NGQgIzEgUFJFRU1Q
VCANCj4gPiBwc3RhdGU6IDYwMDAwMDA1IChuWkN2IGRhaWYgLVBBTiAtVUFPIC1UQ08gLURJVCAt
U1NCUyBCVFlQRT0tLSkNCj4gPiBwYyA6IF9fZGV2X3NldF9wcm9taXNjdWl0eSsweDE3NC8weDE4
OA0KPiA+IGxyIDogX19kZXZfc2V0X3Byb21pc2N1aXR5KzB4MTc0LzB4MTg4DQo+ID4gQ2FsbCB0
cmFjZToNCj4gPiDCoCBfX2Rldl9zZXRfcHJvbWlzY3VpdHkrMHgxNzQvMHgxODggKFApDQo+ID4g
wqAgX19kZXZfc2V0X3J4X21vZGUrMHhhMC8weGIwDQo+ID4gwqAgZGV2X21jX2RlbCsweDk0LzB4
YzANCj4gPiDCoCBpZ21wNl9ncm91cF9kcm9wcGVkKzB4MTI0LzB4NDEwDQo+ID4gwqAgX19pcHY2
X2Rldl9tY19kZWMrMHgxMDgvMHgxNjgNCj4gPiDCoCBfX2lwdjZfc29ja19tY19kcm9wKzB4NjQv
MHgxODgNCj4gPiDCoCBpcHY2X3NvY2tfbWNfZHJvcCsweDE0MC8weDE3MA0KPiA+IMKgIGRvX2lw
djZfc2V0c29ja29wdCsweDE0MDgvMHgxODI4DQo+ID4gwqAgaXB2Nl9zZXRzb2Nrb3B0KzB4NjQv
MHhmOA0KPiA+IMKgIHVkcHY2X3NldHNvY2tvcHQrMHgyOC8weDU4DQo+ID4gwqAgc29ja19jb21t
b25fc2V0c29ja29wdCsweDI0LzB4MzgNCj4gPiDCoCBkb19zb2NrX3NldHNvY2tvcHQrMHg3OC8w
eDE1OA0KPiA+IMKgIF9fc3lzX3NldHNvY2tvcHQrMHg4OC8weDExMA0KPiA+IMKgIF9fYXJtNjRf
c3lzX3NldHNvY2tvcHQrMHgzMC8weDQ4DQo+ID4gwqAgaW52b2tlX3N5c2NhbGwrMHg1MC8weDEy
MA0KPiA+IMKgIGVsMF9zdmNfY29tbW9uLmNvbnN0cHJvcC4wKzB4YzgvMHhmMA0KPiA+IMKgIGRv
X2VsMF9zdmMrMHgyNC8weDM4DQo+ID4gwqAgZWwwX3N2YysweDUwLzB4MmIwDQo+ID4gwqAgZWww
dF82NF9zeW5jX2hhbmRsZXIrMHhhMC8weGU4DQo+ID4gwqAgZWwwdF82NF9zeW5jKzB4MTk4LzB4
MWEwDQo+ID4gDQo+ID4gKHRlc3Rpbmcgd2l0aCBHU1cxNDUpDQo+ID4gSSdtIG5vdCBzdXJlIHRo
b3VnaCwgaWYgaXQncyByZWxhdGVkIHRvIHRoZSBnc3cxeHggY29kZSwgYW02NS1jcHN3LW51c3Mg
ZHJpdmVyDQo+ID4gb24gbXkgQ1BVIHBvcnQgb3IgaWYgaXQncyBhIGZyZXNoIHJlZ3Jlc3Npb24g
aW4gbmV0LW5leHQuLi4NCj4gPiANCj4gPiBJIGNhbiBzZWUgdGhlIGFib3ZlIHNwbGF0IGlmIEkg
YXBwbHkgdGhlIHBhdGNoc2V0IG9udG8gYmZlNjJkYjU0MjJiMWE1ZjI1NzUyYmQwODc3YTA5N2Q0
MzZkODc2ZA0KPiA+IGJ1dCBub3Qgd2l0aCBvbGRlciBwYXRjaHNldCBvbiB0b3Agb2YgZTkwNTc2
ODI5Y2U0N2E0NjgzODY4NTE1MzQ5NGJjMTJjZDFiYzMzMy4NCj4gPiANCj4gPiBJJ2xsIHRyeSB0
byBiaXNlY3QgdGhlIHVuZGVybHlpbmcgbmV0LW5leHQuLi4NCj4gDQo+IERpZCB5b3UgdHJ5IHRv
IHJlYmFzZSB0aGUgcGF0Y2hlcyBuZWNlc3NhcnkgZm9yIHRoZSBHU1cxNDUgb24gdG9wIG9mIHRo
ZQ0KPiBsYXN0IGtub3duLXRvLXdvcmsgbmV0LW5leHQgY29tbWl0Pw0KPiANCj4gQWxzbyBub3Rl
IHRoYXQgSSd2ZSBzdWNjZXNzZnVsbHkgdGVzdGVkIGxvY2FsX3Rlcm1pbmF0aW9uLnNoIG9uIHRv
cA0KPiBvZiBlYTdkMGQ2MGViYzliZGRmM2FkNzY4NTU3ZGZhMTQ5NWJjMDMyYmY2LCBidXQgdXNp
bmcgdGhlIG1vZGlmaWVkDQo+IFJhc3BiZXJyeVBpIDRCIHByb3ZpZGVkIGJ5IE1heExpbmVhciwg
c28gdGhlcmUgb2J2aW91c2x5IGlzIGEgZGlmZmVyZW50DQo+IEV0aGVybmV0IGRyaXZlciBvbiB0
aGUgQ1BVIHBvcnQuLi4NCg0KSSdsbCBuZWVkIHRvIGZvbGxvdyB1cCBvbiB0aGlzLi4uIEl0IHR1
cm5lZCBvdXQgdG8gYmUgbm90IHRoYXQgcmVsaWFibGUNCnJlcHJvZHVjaWJsZSwgc28gbXkgYmlz
ZWN0IGxlZCBtZSB0byBub3doZXJlLg0KDQpJIGRvbid0IHRoaW5rIHRoaXMgaXMgcmVsYXRlZCB0
byBHU1cxNDUgY29kZSAoZXZlbiB0aG91Z2ggaXQncyBiZWluZyB0cmlnZ2VyZWQNCmJ5IEdTVzE0
NSBwb3J0IGdvaW5nIGRvd24pLCBvbmx5IGNvcmUgY29kZSBzZWVtcyB0byBiZSBpbnZvbHZlZCBo
ZXJlLi4uDQpBbmQgSSBzZWUgcXVpdGUgc29tZSBSVE5MIGhhdmUgYmVlbiBkcm9wcGVkIGluIHRo
ZSBuZXQtbmV4dC4uLg0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3
LnNpZW1lbnMuY29tDQo=

