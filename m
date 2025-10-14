Return-Path: <netdev+bounces-229015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE27BD70F6
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 04:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E4E6734DDC5
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 02:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FCB303CA0;
	Tue, 14 Oct 2025 02:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C474Lgrj"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011053.outbound.protection.outlook.com [40.107.130.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3A2301017;
	Tue, 14 Oct 2025 02:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760408410; cv=fail; b=h+dZ6IsanzN+kxjE9l9ACkwam7TRJDQ8QaRN+J/p2+94W8u1zdtyMY2o1D3Z4FGAExu5qSwJRuiCVTC2XjGGYYpx/oWvCUq52JA/321Ytfk3DA8Lg9uk7Xgy6ySgUTFSAL2lomeZLQMGFnxNJ+elkUl2q3UVQ7YVVWQr1Z3ux4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760408410; c=relaxed/simple;
	bh=Yua4CBK4b6tP44YtvSwedJiavWW8IGMntqd8tZmtAbg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QEgmqVQBaMc5uJ6UrtCSGSlddZX3fvxWj+MPsJAguJPqOaMddiBmBpr0sRCinhw5WfZI5vAtctR9zLp+TmMykATZB6RTRV/1Rc+ZFR6nlLTZ9qolvGdX5dfL2aWOUWq3Zg+ztdmk7dCGqN6ZeycUXfsZONgCfDGbDrhpaDhhfWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C474Lgrj; arc=fail smtp.client-ip=40.107.130.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dj1SffwLJ6wTKWJOOpcFRyITDgCi52YwXpku451Nndk853hoYg7fo2K48z9pjux+QpQ6+olEaocVEmff9cZ+iRzBXqPKkwp/bmD44RPWFMsykxi7f8lukw9kIhXs1u1xzJmeTwZxNs/yoTByDvx3eFDwQTDDq9BsyEDo3S8rdr+u5fK4GSFeZ2WmmgmG23YW1/CYH+vIf3HKJeuOPhoE1su+4vO5v3ttWFUiZJi2fFJ/lcRaZZfr7R6yGxyp1hwOdjv0rcdPTcJC9uDkNXy9YZwQXSuNhG/j3b/qSNRygushoS5w8LA5nBJMgVCty8U2g2U2ckCF1K5WuljEpyo2Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yua4CBK4b6tP44YtvSwedJiavWW8IGMntqd8tZmtAbg=;
 b=GbFzFujhh2U/aAhXdK3fltqJqoY9RJAkdGdjXz4vm9tmh2SZE1TUuKOWqnDCsyO6G9xT9ccph37XnMT4NuLhn/VnhtdlVoqqLEgAIVkFLTlE5H47428cywjedT0U2hgV0vrePFyJR85QbgCU/mW5ErfJN/ug46hVHvlAzpCLeol0HJj5lJ3VzjAcfcNd+3uKenTz7jwwq3d/4dN6p/PIvDXwPQSpIcJsuXSOrPhD4hJSn7/ox9yT/e8YpyaNz1AP+sRFfp29gsWG7qpERF8muv3HI78oVEbg8V6yVuH6pVGYv3y4O8sSQ+jY7dmKG33x46XJ/kU8PJxLW0Yc3Nd/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yua4CBK4b6tP44YtvSwedJiavWW8IGMntqd8tZmtAbg=;
 b=C474Lgrjaiy7rkPy7X65Ni29WctV2fSItz7qexTkRKVju/YQwe5U36WoGp+7/urs6eFM4oMuIPTUQdHop5AhUGaq4M3lY6ELqqw9CmSauWZTZH82qFzwkxKEw6jv+9prpKY0QqeBV+4vffHLQEKJQ+vJSFJAUdW8eon3oo5Isme6HiZ+jxc3Dahs4mOcHh/P64QZU9l/zbOPnxdd3mIZasoThCxoD5VGmEvQz+oLEna5EzszTTGK/dIi3a+sI8vOsDRMuymySyEsbkO3vQK7l1jdgPBAzoASS8pfrF9LvV5AJ0HFGsymn51vTCLZ1O/gdQs9N6vk1zVaytfDTBrSsw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB6887.eurprd04.prod.outlook.com (2603:10a6:20b:10a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 02:20:03 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 02:20:03 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Frank Li
	<frank.li@nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: enetc: correct the value of ENETC_RXB_TRUESIZE
Thread-Topic: [PATCH net] net: enetc: correct the value of ENETC_RXB_TRUESIZE
Thread-Index: AQHcOcsiKt52zsPKAk2fo+9Vq3ZFNLS7VNgAgAA8FwCABV0XoA==
Date: Tue, 14 Oct 2025 02:20:03 +0000
Message-ID:
 <PAXPR04MB8510610DB455D9CF2D4E295088EBA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251010092608.2520561-1-wei.fang@nxp.com>
 <20251010124846.uzza7evcea3zs67a@skbuf>
 <AM7PR04MB7142CA78A2EBA90FE16DF83B96EFA@AM7PR04MB7142.eurprd04.prod.outlook.com>
In-Reply-To:
 <AM7PR04MB7142CA78A2EBA90FE16DF83B96EFA@AM7PR04MB7142.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM7PR04MB6887:EE_
x-ms-office365-filtering-correlation-id: 9dda98c6-d475-4c81-32e2-08de0ac82ef8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?gb2312?B?T3JuSEFUZ1V5VUlrWVpzUDlzcHYrUkpscncrd3dvemtha3duKzl0cTZ6eGpi?=
 =?gb2312?B?TWp6YXBDaG1oN3B0TVgvSXlJdnhaV29EdDg1WlFyZDg3dE9nNjFDWkhMYmtu?=
 =?gb2312?B?ZlU4cGhUcGRwVGtRVXJ0TVdxUVFQamVoQzVFdHBNd1BrbWZXMUpybE5WSUVa?=
 =?gb2312?B?bjNNZHptUHZkWE16TFRkUmtPbTdscDNrbVljRzRBUHVpVE5yNlpBNkNzSkt0?=
 =?gb2312?B?VWNPNnE3aEZYMTZnV25qOVFWRTkzTERLSXdEenpWTzVmUUhSTDBOTFZsVlhm?=
 =?gb2312?B?ZVVBYkdiV0p1OWRwWHFUd2hZNnNDdXZxZmZPTVpYWERYRnhGblV0bDJCSElR?=
 =?gb2312?B?WVo0QTd3UnZ4dDFuODNzdkJCV25pNG1GNEdrckNOVTFyd0pYTTlGQlU3d1RC?=
 =?gb2312?B?Z2c3QU1CK0IrQVFCTVliYi9zSzZoSW9ra2hZQWQxczBnd2ZzTXdFNG12TlBB?=
 =?gb2312?B?ZEMyODVweks4ZHZxY3ZkQTZOQmVZbys3bFVxZ2VEc21QY0xqTGo2aHpvenZs?=
 =?gb2312?B?V1M2M2xHY095bVhFUjFUam4xNEU2MTJiTnJ6aitXNGZIRlFxdHhDcUljUjlp?=
 =?gb2312?B?V1dUTWswbllhdyt2di81M3VUSkU4QjhGSC9XTzVVSzU0WDFLb1MrRFdkMitJ?=
 =?gb2312?B?bHo2emg2QkljRExPZHo3RHVGUW5YcGFzaTd6YlpyYkwwcWp5bWZ4ajNyVEg4?=
 =?gb2312?B?UWJxV2tIUkpySDdvOGtna3BMd2xaUE5xcXlBODlnOTZ2d0tBWlltbHBIdExm?=
 =?gb2312?B?MjlXaFRPUUNUcE8yZ3lzMVZGdWYrV1E1Q1N3ZzJ6Q1E2clFTNW1DT3YyTTNE?=
 =?gb2312?B?TU9iZ0xudDlJVEh2Z2didEtQWTcreUtBZmJWRXBCOHl0aDFucFJaY0p6aVRE?=
 =?gb2312?B?MFA2R1E5RlhnSmVGYnhUVVFKczJlVmovMmN0VVNQbjN2ejVKbmF3TzNIcUZP?=
 =?gb2312?B?cit4UmJtRnVqajg3N3piaHVrSWpjeW5EMDh0K0lsNGxKbVNabVhCQzlFQ2pu?=
 =?gb2312?B?MGV0WXRlV1h5OVUwU3hMaVZVUEF6c2FjdDZKdVBXa0ppN3RGM1h0N01rbGkx?=
 =?gb2312?B?WVZmeWhYRldJVStldzdxV2FIUnN6QklBamdwRTE4ODAzZjFhZEh1NDBIRHZI?=
 =?gb2312?B?UDJHKzRkTW9xV1AvRGNCcGZ4a2Q0djRNaUZuVHYwZGFsR3YzVXR1SSs3M0Jl?=
 =?gb2312?B?blRHdmo0dldXMFYzZWVaZjBsNUJZMldJNnQzZ0lZQndscDRGQjZTQU5YR0Zn?=
 =?gb2312?B?eUVBMTZlZHBEM3BsMFh5Z1pSY081VE8yWjZmUzRwdTJxT293ckg2aTR2OEpV?=
 =?gb2312?B?UUZVbzlHTTdmWnBnMk9QQ1JyVStCYVd3c0tFZ3VUMUFMY1RXVTJCSE9HT2VH?=
 =?gb2312?B?L1F3MXJwOTg5cWNhVnBSRXpRK01kV3dyOVMwbVZLc0ROait5bnJIY08yVHBn?=
 =?gb2312?B?ajBKKzdwMTUwRDhnTFFnYWpYQytod2lKNzRmUVZpR0hTRDlqMXZOSHE2OG9o?=
 =?gb2312?B?OFd0aHJlRTV2Q0NYWmxCa3F3QjNtMFdzYWxGTkJoTXY4ZS9zREJwWTcvZ1dV?=
 =?gb2312?B?Vmg0SVRyd2IwcTcvMzNiUWpPcHQyVFE2SGR5c0tqd2p4ZkJHTWVpS21Hb1FE?=
 =?gb2312?B?SzB4MzJjaXVLbmloc2F2R2huOVFReHQ5c3NPd085NGRBTnhhVk5ybkRmMGdH?=
 =?gb2312?B?MHRxc1Y5UW1HM2NheUxKRDhnZk1wdTJ4bmhkVXFZdXNvdzZXa0RvdlB5ekhJ?=
 =?gb2312?B?Q1ZFUWZvS3FLU0dwRXlINlBoUitFNnBjbE5CSVFTdGpDQWM3WUhGNm50ZFFR?=
 =?gb2312?B?VFUvUlF5eHhIeWlzUkdKK3ZWYUZwSzJlSzdiMFRUMGVvL2JLNWR0eERzMlR3?=
 =?gb2312?B?Y3d0NEx0RkN0bDNORG5RTVZobmx6aFlia2FlN3h4Y1B0RXd6OVIybUNHa2RE?=
 =?gb2312?B?Rm9rRVUrNUlQVlpaYzVQRDBzQlRXWVVHODlhYWRGVWdvTlkvU25KOXpOTDlS?=
 =?gb2312?B?T0c5TXJ0SWEwTFpvNlpJbUxuR3RzVWtRckdNRlQ1M3lUNUhmdllTd2wxYW1H?=
 =?gb2312?Q?NI+824?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?akh0dHBQWGkrRlhaWDF4UEN1c0J0Z2ZpbzlEZlE3dzJaNjZoWmZYUlJJVVkw?=
 =?gb2312?B?OFFWRE9CbmlVRmVzSkxlMnJxQ2ZVYVQ2VmFDZTU4VGE2Qi8xaG5WVHZPM1Qy?=
 =?gb2312?B?RDExaWR6SWduU3RJVDVHaUFXWVdPaVJWUWZRVjFzTE5YZUIxU2U4c05Fbjk4?=
 =?gb2312?B?b1ZuZTV4RzZQanVmb1BienkyR01wMWtrRHE4NWJsbWorQ2M1YUFaUjEydTR6?=
 =?gb2312?B?S29CaUpnZGxCYkhlZFVIODRtS1FGdjczNEluK0ZHK3NvWHhDU28vQyswZUZ5?=
 =?gb2312?B?SzdSejMxaUcrOEwvZUh3enMxbXc1VGRYVnI0MTNyYXd0Q2FUR01BZUhqUy8v?=
 =?gb2312?B?K3Q0TVBhSndGNlJkQlJjeDhYOENGdEtDWUxrajB1RVptd0dNVXd3UVNSZzVR?=
 =?gb2312?B?ckgrSEZtczdRVzU4eXBQWGNibXJCRG1iVlFRc2tCc3hwcUVPbnFoMUEyaENL?=
 =?gb2312?B?YktsL2RIZkJjazVqUkNEaW1WcEduNHYvdEdMWDk5TlNhSy9sL0drZGtjTzJD?=
 =?gb2312?B?bkgvQWJibUlMM2EwTlBrb2ZoT2ZSbVZ6bmxUMklsM3NLZitRVzhmOFJVall4?=
 =?gb2312?B?UVZkMVJ1ZEF1MnhqMmF4UkZteFU3QkRSSjJiZ1F3VEpReEdBUTBTbFNXaXBQ?=
 =?gb2312?B?WTc1a3UyV2w0MVFINHRmYmg5UVJmNnRsMWpqSTZ4STYzWGpmamRHTXhmWGt3?=
 =?gb2312?B?V3BqLzRxbUJFbGszemJ2RWI5anFuUDVORU5GeGg3UTl4NExJR1hKNU1RbDd6?=
 =?gb2312?B?bVdjbTNJdHYyODFCMEpOMjY3OXVIUzdML09uVWxFTXNtRmJDcG4vUEJwVExr?=
 =?gb2312?B?aXZ4b2lrOHhiNVZnSlVRZGlTdU11MFdyNGhDdlR3SFBzcVZsc1Jia1BGWXlR?=
 =?gb2312?B?ekFjK2FjRklyQW93MmZsd2FJUDBNeUgyVCtpOE5TNEJFUk8wL3c2Wk1ldERP?=
 =?gb2312?B?aXRJODQ5L3EyYUtiSWhtSUg2SHRZU2JTcGlXYjBLZGo5SXJScXJNUVQ5eUQz?=
 =?gb2312?B?dEMvZUdSZ0JidTN1WGdoNTlWZXlWL2lOVWF1VFZQbzhkekxtSzNKZytIemFB?=
 =?gb2312?B?cTlVYkdVdzg5d2d6NXFleDZHYjlycnFTdTdnL25pOCtybWhSVmJkVWlXaUYx?=
 =?gb2312?B?UzJSendmWWREblBnQ0NxamdWWE9JUWJnVWZqYlRmS1dKZE1IZUJNMjhpUHd5?=
 =?gb2312?B?enkyVjk4bi9zQ0xTcTlYRVkrZFZXTTRGQWs5RjJROFU2eEh0NmtqNDZMU1BF?=
 =?gb2312?B?M0pRcGxhVUFkN1RUcWQ0Q2lHUDdscC9ySjJMUUNMb1JObEJ3SGx2WEIwVktW?=
 =?gb2312?B?aGhRYnBXWnFJN1prRStjK3QwZHNzbFliMjJuUzBDWjduelNldXJIZ3F1cG13?=
 =?gb2312?B?YmFGUEpWQ1R1NGxxSHpCZXcxRlNEUHRNWUJJdUw3YjNLR1RZazM5SFl3RlBp?=
 =?gb2312?B?SHhuNVRmUUxrZFI0MGROS0xnMlgyNldVanF3bXR4amdoeGJ3K2FZbnRRYmFZ?=
 =?gb2312?B?ZWJwYm9CejhuTTFWRjdwcTVZNHpHWDNpQ0VPMlV1aDNYdHVtb3MrNjA1ZVR3?=
 =?gb2312?B?dm5nOFF0K0YxT0JuVERRVkZTTmRRVktnRDNVUFRHNktXSFdWSy9zVVIzUzlJ?=
 =?gb2312?B?K1BOV3B3TjFkVUd3RktNZ29tZC83V0RqNXdGdmswcW1oYmV6eDFFM2lsQXgy?=
 =?gb2312?B?THV6MkowejhucGNabitoVkxvRmxYU0FKRzdGdWVwbE5yaFVOL1JMY2VwT05O?=
 =?gb2312?B?TitHT0JWR3JRd20wTnp3TWZ1UWdLRjVmcVBwWGVvZU1qUFhDZFI1RU02cmVt?=
 =?gb2312?B?MkJlazVHUjRMWHd3cEFQV285WmlRREV6cmtEb0QvVk01NEozZjBrd1NVUXY4?=
 =?gb2312?B?WDBERmhhVjg5WENKUGd3QTZkNTcyMHlEdmhSRkVNaW83cm41QmEvcVV2aEZG?=
 =?gb2312?B?QVpSbnM1MWN4TWtOaWxNYW1Oa3d0eW9Dd0Nrb1o1UjhDQ0tNbjBobWNOMkNJ?=
 =?gb2312?B?VTlnOHVxVFVBM2xpVHVjK0R6dnlPUFlIQ3dPQ3hPUUEyZkFYY3RTZWl6cE5I?=
 =?gb2312?B?b0pYK1pETzlSVUovS3dyVWxRVHdrdkx5M0FqN2hVYm1yMllMTnFvRjJxQ3ND?=
 =?gb2312?Q?2Hxs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dda98c6-d475-4c81-32e2-08de0ac82ef8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 02:20:03.0460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HrDWrmG463yaQgkhrKcuJK0WwTjmIL4oQr8khASs5F77MVwqiAJgIwdpkTPQ/Oe4Qsug8nOGgZHCnID4z2Ezhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6887

DQoNCkJlc3QgUmVnYXJkcywNCldlaSBGYW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogQ2xhdWRpdSBNYW5vaWwgPGNsYXVkaXUubWFub2lsQG54cC5jb20+DQo+IFNl
bnQ6IDIwMjXE6jEw1MIxMcjVIDA6MjQNCj4gVG86IFZsYWRpbWlyIE9sdGVhbiA8dmxhZGltaXIu
b2x0ZWFuQG54cC5jb20+OyBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gQ2M6IENsYXJr
IFdhbmcgPHhpYW9uaW5nLndhbmdAbnhwLmNvbT47IGFuZHJldytuZXRkZXZAbHVubi5jaDsNCj4g
ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3Jn
Ow0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBpbXhA
bGlzdHMubGludXguZGV2Ow0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggbmV0XSBuZXQ6IGVuZXRjOiBj
b3JyZWN0IHRoZSB2YWx1ZSBvZiBFTkVUQ19SWEJfVFJVRVNJWkUNCj4gDQo+IA0KPiANCj4gPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFZsYWRpbWlyIE9sdGVhbiA8dmxh
ZGltaXIub2x0ZWFuQG54cC5jb20+DQo+ID4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDEwLCAyMDI1
IDM6NDkgUE0NCj4gPiBUbzogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+OyBDbGF1ZGl1IE1h
bm9pbA0KPiA+IDxjbGF1ZGl1Lm1hbm9pbEBueHAuY29tPg0KPiA+IENjOiBDbGFyayBXYW5nIDx4
aWFvbmluZy53YW5nQG54cC5jb20+OyBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7DQo+ID4gZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiA+
IHBhYmVuaUByZWRoYXQuY29tOyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IGlteEBsaXN0
cy5saW51eC5kZXY7DQo+ID4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0XSBuZXQ6IGVuZXRjOiBj
b3JyZWN0IHRoZSB2YWx1ZSBvZg0KPiBFTkVUQ19SWEJfVFJVRVNJWkUNCj4gPg0KPiA+IE9uIEZy
aSwgT2N0IDEwLCAyMDI1IGF0IDA1OjI2OjA4UE0gKzA4MDAsIFdlaSBGYW5nIHdyb3RlOg0KPiA+
ID4gRU5FVENfUlhCX1RSVUVTSVpFIGluZGljYXRlcyB0aGUgc2l6ZSBvZiBoYWxmIGEgcGFnZSwg
YnV0IHRoZSBwYWdlDQo+ID4gPiBzaXplIGlzIGFkanVzdGFibGUsIGZvciBBUk02NCBwbGF0Zm9y
bSwgdGhlIFBBR0VfU0laRSBjYW4gYmUgNEssIDE2Sw0KPiA+ID4gYW5kIDY0Sywgc28gYSBmaXhl
ZCB2YWx1ZSAnMjA0OCcgaXMgbm90IGNvcnJlY3Qgd2hlbiB0aGUgUEFHRV9TSVpFIGlzIDE2SyBv
cg0KPiA+IDY0Sy4NCj4gPiA+DQo+ID4gPiBGaXhlczogZDRmZDA0MDRjMWM5ICgiZW5ldGM6IElu
dHJvZHVjZSBiYXNpYyBQRiBhbmQgVkYgRU5FVEMgZXRoZXJuZXQNCj4gPiA+IGRyaXZlcnMiKQ0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+ID4gPiAt
LS0NCj4gPiA+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGMuaCB8
IDIgKy0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNj
YWxlL2VuZXRjL2VuZXRjLmgNCj4gPiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxl
L2VuZXRjL2VuZXRjLmgNCj4gPiA+IGluZGV4IDBlYzAxMGE3ZDY0MC4uZjI3OWZhNTk3OTkxIDEw
MDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2Vu
ZXRjLmgNCj4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9l
bmV0Yy5oDQo+ID4gPiBAQCAtNzYsNyArNzYsNyBAQCBzdHJ1Y3QgZW5ldGNfbHNvX3Qgew0KPiA+
ID4gICNkZWZpbmUgRU5FVENfTFNPX01BWF9EQVRBX0xFTgkJU1pfMjU2Sw0KPiA+ID4NCj4gPiA+
ICAjZGVmaW5lIEVORVRDX1JYX01BWEZSTV9TSVpFCUVORVRDX01BQ19NQVhGUk1fU0laRQ0KPiA+
ID4gLSNkZWZpbmUgRU5FVENfUlhCX1RSVUVTSVpFCTIwNDggLyogUEFHRV9TSVpFID4+IDEgKi8N
Cj4gPiA+ICsjZGVmaW5lIEVORVRDX1JYQl9UUlVFU0laRQkoUEFHRV9TSVpFID4+IDEpDQo+ID4g
PiAgI2RlZmluZSBFTkVUQ19SWEJfUEFECQlORVRfU0tCX1BBRCAvKiBhZGQgZXh0cmEgc3BhY2Ug
aWYNCj4gPiBuZWVkZWQgKi8NCj4gPiA+ICAjZGVmaW5lIEVORVRDX1JYQl9ETUFfU0laRQlcDQo+
ID4gPiAgCShTS0JfV0lUSF9PVkVSSEVBRChFTkVUQ19SWEJfVFJVRVNJWkUpIC0gRU5FVENfUlhC
X1BBRCkNCj4gPiA+IC0tDQo+ID4gPiAyLjM0LjENCj4gPiA+DQo+ID4NCj4gPiBJIHdvbmRlciB3
aHkgMjA0OCB3YXMgcHJlZmVycmVkLCBldmVuIHRob3VnaCBQQUdFX1NJWkUgPj4gMSB3YXMgaW4g
YQ0KPiA+IGNvbW1lbnQuDQo+ID4gQ2xhdWRpdSwgZG8geW91IHJlbWVtYmVyPw0KPiANCj4gSW5p
dGlhbCBkcml2ZXIgaW1wbGVtZW50YXRpb24gZm9yIGVuZXRjdjEgd2FzIGJvdW5kIHRvIDRrIHBh
Z2VzLCBJIG5lZWQgdG8NCj4gcmVjaGVjayB3aHkgYW5kIGdldCBiYWNrIHRvIHlvdS4NCj4gDQoN
CkFueSB1cGRhdGVzPw0KDQo=

