Return-Path: <netdev+bounces-150960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D0B9EC2CA
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 04:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D1A280CA2
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768291FECA0;
	Wed, 11 Dec 2024 03:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="mWbFtECK"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2122.outbound.protection.outlook.com [40.107.117.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A715A2451C5;
	Wed, 11 Dec 2024 03:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733886405; cv=fail; b=aGROLIYphWyUEbhFKOOTD4hVHaWehkFd3VXO3IoB0Y2bnp1hBAT365ek2Ln9spAJuGQERwoU65/BmHyo7DlaVRhhXYMKPeqoo2sxvbWoJIuYmrIf59QQB6EMxwHj2pVSP8/O43NY9slpJHpM7lH+u3JMHXat0B9TdXsEMfFA7/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733886405; c=relaxed/simple;
	bh=uKlhmdncKKX0FSgADeWNQ5h3EV0EUKmCPqlhyJ7ubmw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K0YMP1jRKZ75Kow9MdZ/EBGDHwzojwpmAlIaQ8/lGfeiZfciwmvzm0P7pDTCq0fN49Jvuhs8jH/ZNbf+HVOxQcRHWhqV4/YFNyeie0zjxTh1DmQCurksYecS2WcCl995vOL3K3RxFpSWVgo3aqXdXfaX+UEvnJOoLhKuccrlp0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=mWbFtECK; arc=fail smtp.client-ip=40.107.117.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFUQcH0Pk2zyF8s9p8jKB5z/YzJdyGZmQmFTXLFIh457EI1hjWw47HNrXMyQUrUOuDMdUgG8C6xtMV6OCzb8BQ8RRwHX0Vrc3oszE/6uhKVuR+o46YCPlBcxA5ZBn84IqHFs5QAeWwSYjeput6u8GHCPezYIVp6u99PsH/7YJviYOJu3kee3KhaA5n0eHAxdp0FAhTzDCvC/nimwdFkpdDXxR3w+iFJxMC8Fqj0hlh38BJEqh+iWUwggTcMXsZaHVpp0KYq0ELYMvmfTSmgWVWrz28vcbxOQ4zyQN7SoehO9L75vq8jP/LqRDwh0H4+Rxm0lla7777fy3FqrLGt2xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKlhmdncKKX0FSgADeWNQ5h3EV0EUKmCPqlhyJ7ubmw=;
 b=pwncA4SpTp1IOjqcRsMgWKqe0c2emF07FV9Mn3I5ZSk2L2gH6wMU04bO+MzwOeWC2RWDvETSJnCoiqWGjycjIkdUw020TKQXp/xNab7/KphGTogqtmbw20LCRdkF6rvp4ro+ggAD5EAEJLRcxqGKp6Ysg8xPGkYwpc26dR1Ud7L9ezounO7VU04x0tSMqdqMvK3Ohc1oZqjc50B5Vhe2QfNP9Sxaq63He0swihCmLAMWT89/N8fM0SMo8/Sqb6KU+63eGaS0XpdyCKk6+6T40uGTZW8CaKH/5HzsL/YdUkBuVZd7+huOgLMUs1s+24kL+HY0GWccOXrvxWfG4BPAmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKlhmdncKKX0FSgADeWNQ5h3EV0EUKmCPqlhyJ7ubmw=;
 b=mWbFtECKGvf4nz+UUUgpawM21Y2mBFpweT/toCFws3Q0eaUhGTaYHYtGCtyNB9FWzZhkDftf0AbPGgpQwLZGBmvtpEZ/eGDw+mPAgtU8BYH7O0J9vOEi04hiZZwgGTWb004xtudPc0KsQEmMF3oD/DCq3KAFIutK45E7RkCWG4dAXi/aaaypkb+rT0BVpyIkhuR2CC0vC7vXEY3A6I7a+WZnttx5sw6th1vB0oKFmVb9WtNhz8bipyegxaWqda5YtaXlrkG1mIZOfu4AOkWrEnM+jb1X3Vn1pazBX9bV4PRAm6c04Hjox3KEjegEwBcmbbRX0SZerj29HmO+h98lzg==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYUPR06MB5928.apcprd06.prod.outlook.com (2603:1096:400:35f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 03:06:39 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%5]) with mapi id 15.20.8230.000; Wed, 11 Dec 2024
 03:06:38 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Simon Horman <horms@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0DogW1BBVENIIG5ldC1uZXh0IHY0IDMvN10gbmV0OiBmdGdtYWMxMDA6IEFk?=
 =?big5?Q?d_reset_toggling_for_Aspeed_SOCs?=
Thread-Topic: [PATCH net-next v4 3/7] net: ftgmac100: Add reset toggling for
 Aspeed SOCs
Thread-Index: AQHbRuY5vQoJ+f6f60+UlDbLcduuTLLeJugAgAI8i3A=
Date: Wed, 11 Dec 2024 03:06:38 +0000
Message-ID:
 <SEYPR06MB513493FB37198295427938789D3E2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241205072048.1397570-1-jacky_chou@aspeedtech.com>
 <20241205072048.1397570-4-jacky_chou@aspeedtech.com>
 <20241209164946.GA2455@kernel.org>
In-Reply-To: <20241209164946.GA2455@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYUPR06MB5928:EE_
x-ms-office365-filtering-correlation-id: 4827ec98-fc36-4e86-3dcd-08dd1990d48b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?OFYvb2dFeDFieTlUVEdHZkhYTmFOMGt2L1p2b0JpdzJrZ2IzREt6M0lSUVhIMHlh?=
 =?big5?B?SUtFWmN4ZTJoNTNLUzJWR3hPSzZSZ1M2aVR6L3Q5RzNzalgxT0FGNkc3L29RbnU0?=
 =?big5?B?NFg5Ujl4d2owQWFzYnhKSW9FNEVKWEdLSVloekV2VzhqWXBkMVRxTGswZ1VxZ2lX?=
 =?big5?B?ZFJnMXNGajFWdVVINk01TGNydUFwMzFHdnU3eGxTbnNhZjJ3UkdIbGpGVDYzamFB?=
 =?big5?B?dktuYUV0eVh0QTloM0x5RVZYbnZ1bkYyT0IrTkpuaGg4WjlwQWlUbzhMQTF2c2JM?=
 =?big5?B?clpNV3hiR2Y3Ry9FVHpzSlZZcEVXdXFFMGVtSmYwSmZObDJjVGRIeVBVWjV1US8v?=
 =?big5?B?akZLT3B0TUVQOFZaNWFpQmorN016QjJTcm04NGpiUnZPNGZuSU9kcGhnY0xTUGJJ?=
 =?big5?B?Q0wwa2NMMFY4blJNK09XQkM0S1YrZDJvMDNrWlgwOWZ6NlZoMDU0TEYwOGtoeXR3?=
 =?big5?B?VkowazV4RW5rMXRmUG9uR1VFQWNES01TMmJ2L25OV0FaV3dmTU9pRERPZzhqNWQ5?=
 =?big5?B?UnlEZFhwS29hdTlzcFJhUWFGRkZ2ZG92ai9aMzlTR0lUYnMwZFR1M2JCbGEzVzZT?=
 =?big5?B?cFMwTmpPRThnQWxzd3I5M1NqZ0xzZGR4QWVhUy80ZGdidjNVVXRVTkFDdWE1cUhi?=
 =?big5?B?UEpEWmhxUUZIc3hpN09mSnUzWjk1S2VJUWtGNWdJN2F4ZXgxaEM2bVJyaHpYWUJt?=
 =?big5?B?RUgyaUViMzVKSFc0OEdBRWNnakdsVk9LU1YxVUdHS1h2QmlObnVFNTlLSmJDN29a?=
 =?big5?B?VTdxLzZGYmVlNGpZRThXMTlERUpQK0sxaTY4K1N0UWNYWFJaYTJYWER3VzdPYmtO?=
 =?big5?B?M0JBUVJNS3RRYTJ2dW5iaUUrb2liQ0VyYU50U2R5UklqaXFOUmFTN0wvOGRWKzlI?=
 =?big5?B?bXk0aU9rWTAxdDlXZS9WRVRaeWI2Yld2V0Yzd2VrclYwZWptZmN1a096R0JBbWll?=
 =?big5?B?Z29xTkM1Y0dhYnNVNDRTMnBEekhIa3ltcTFUK2l5WWpoSDlaa0s0ZGhlSjNOelh5?=
 =?big5?B?ZTNpY1BmcCtqS3lUeXV4Sk1lR2swSDFXellRbnpHZUE0NDlabHhJYWxiK3Y1Y1FX?=
 =?big5?B?WWtucUcrUjZZL0MybWRhWjhYZzY2SnlSbHhVNnVlMnA2K0d5a2plRGFscjNNTS9o?=
 =?big5?B?ZVFXR2R3dVVNckF3MVVyNlROYlZneUlJeG9HZFFXSDBoUG85SzJtdVY3aEFHYXhU?=
 =?big5?B?a3lob3NUUjBSUHVuMXNyVlZQQVcrREttK0ZIQ2h5T1pHL3p6b2QrTk1QODRWTnFY?=
 =?big5?B?TyszSHVsY1BFaGdRSTluVnA2anROTnkwNmt3ZDFiTmExaE9WUVl6N1l5aVhDK0FC?=
 =?big5?B?a1dxcUlnbDY4b1QzUGU1QWtvd2Z3U3FCdGdEaFUwckk4QTVKclM3TkZSUGoxMysv?=
 =?big5?B?QkVhWS9wZUZYcUFiekhDcVM5NmtHRTdCbVBzN3VsWEgyTkh5VE5ZTERhSEI3T1pq?=
 =?big5?B?RmlrWmJzUXg0cXRIT2xWVDB4SnVOaUJZRU1UQi9xNkdENFlKRS9BTmMrcTJRZjAz?=
 =?big5?B?andVOWFSNTJ2OGZ5eXZDOTJmaUlkM2IrQmwrWnM1MEtFWFkzVEJldFpuQ2F3R2Fk?=
 =?big5?B?Y2d2enVpQjMyYUpCQmlXRmVSaFZ3UzhVa3FZZ0pFNUtNaDBOSExQMnpwTHE4V3Fi?=
 =?big5?B?QXora0c2SWRndnZCdGFzWnNSNkdxN05aTytnMklaeW5STGJSSTV0Yngzc2dZZjln?=
 =?big5?B?TG5NOHdSQXNadjI5S3Exb0kwMmlVa3BINktYN29nRlBCWWtoRTdYUTdpYm1sZ21a?=
 =?big5?B?S0VjelppYUxHcUpmT0tpNHdCZThkRlllYTF6WGxkeUxHNGNRTmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?NmtxNCtmeXNCU1JHVG9RSk8vTHA1TldocTdZWWhQc2xEaS8vcnhGNk9mMEZWWHBT?=
 =?big5?B?bEQyVkg5Wlh2ZktweU90V0UramVNUk8zZUpDZE00SzVtTlYwa0RFVVNLMmlFYm5j?=
 =?big5?B?WUo5SC81cFZmZTNZaURwREFMU21MMGRma3N2RWR1NzlpTWt5R1oybHd3ZTgyb09a?=
 =?big5?B?T1BuOFFrenJjZkVGNi9MamJBZmxNenFLRkp6L0kyY05KRHdQdWtmRlZweEJaOGRB?=
 =?big5?B?aGJzMWdnSHlvT1ZEMS9PY3FkZVRoSHBDM0xRanhFaEhtZlFUSWZQMXhlRzVjd2Va?=
 =?big5?B?NFFtTExkTFB2MzVRYkJVS3J0SlU5WGhsWDNpeU9DZ3YwWGlkYzFYUXppMHR1ZEhP?=
 =?big5?B?L2JCM3NMZzd2VlVqZUs1ZXBhejR5a0hJYXRjdERBaEFwcGl6Wm84VnpneEg2dEsv?=
 =?big5?B?dmQrVFd0L2huVFBpZm9mR1NlWHFHS2dBcGl0NVFkTXhDSjhTOFJDeWU3NUJwbzda?=
 =?big5?B?SUVMUHVWVTBzditmV1ZhZTZzWWVERm5kV0kzc0NIbnNhdHhjWU5kZXFHUzVqSmhT?=
 =?big5?B?M1Fza25tM2k1SGluRDJxMjRTVUlTYVJFQUNvVE5KNE5ldkRWbjBmNkRSOFk5U2lC?=
 =?big5?B?clA3SFlwY2NhTWlqWUpGaWxjRHZEc21jOFZQZmF6Q244d3JQUlYxcXlJbnZLTHVX?=
 =?big5?B?U2k3ektUSHdRQ2d3NjM4RUFRUVppRGRZTFdzVGRwblNMOGxZbjJBU2dwaDNFdGla?=
 =?big5?B?cWZqZHdZV3JaQTJVNjZWQ2J5S0hGU0dLSWNmUkpJU3ZkS1I4S3NvM0NCS3k2NWRY?=
 =?big5?B?bmdMaFh6azZpbUtsVVpTK1U4RGxyWHdFNWlpcHRTS0RMSTIvYWc0SmUrZ1dTU0ph?=
 =?big5?B?S1hJejY5UXI0R203Zjg5R2pBNm1lT3pXODhqV0h4VlF5SDNtd2VkYWFwZnMvWVly?=
 =?big5?B?VnBEMCtvMVpOdmh5ODh4cXFjdEMvTUdBVzA3RC85Y2ZOS1FUNGFGaDIrYVMzR1dX?=
 =?big5?B?L3FCWkl5Wm1mV01IQy9SN29jMEpPcU8yMUVmV3dmRUlDZlR1UHhUanJ6UGpMeTFt?=
 =?big5?B?ODFpTnlRdUI0L1Noa0wwdmNOZVMvTG1rVklYaXpJL2pacWUydHY1ZlNoV1RoRlRX?=
 =?big5?B?cW5BbDF1Ly92VzF4T2tScnBIenNKdStxMVJqMTl6NG9xRm1TTFZFL3YvbjI1MmtD?=
 =?big5?B?MWl2RXhscFBHOU5TQWFXTVRjYTM4SG1EdFZvM3BDWXZJZGxHN0o5TDlyUXl5UG1Y?=
 =?big5?B?b2F4WWZ4MlZmTCtOZHhZWXlndHk3L0w0MmhrWUlCSGlYRXg3Yk50MU96d01Zcm9Q?=
 =?big5?B?ak8yWWFjeW85ZUV6UU5nRGZ2bzRPUWFOTkREV3RYTjZ4RUZHTS9BVThndTZndVoy?=
 =?big5?B?NGZOWU54Y09CTm9Kb2dyaVBPb0wrL2lCdTY1L2hFQnc2b0NYc0taR2k0cUJIVENZ?=
 =?big5?B?WTVsVzBXK1U3SnI2OEliUHhNLy81YUlyRTVoL0Vhd2Q2V0tOUWtTemIrc0ZzeEhj?=
 =?big5?B?MW5jRXB4MDJXZHdBU3VEZU10NWJmZFpKR2dRSURiWmRiYldrK0Vqem03Y3VvY1ky?=
 =?big5?B?SmN4Tjhja0NuSmxmelBCK3dQVzh3MDZwSVpIZFZ1TTlZMEg4Rk9qckdUM1lKVm84?=
 =?big5?B?MXJuUkV1M2VKQWdlS3hKOFFaaFpCaVhNbU5nL1FwYlA5ZzV2cktaWGRaR1NldGsr?=
 =?big5?B?YXpaN1F1Rmc3Vzdmd2tYa09NWk03UWUvcGdKK3gycUdWdFlYNXJSRDIrS0VSNFpP?=
 =?big5?B?NWpEdEdzRzh3MU5FQW1FcVdoS0k0R01lNGNRbDNBR2d0U01RMmMwQ2F3NXN5dFRu?=
 =?big5?B?VHNkQTlJWXd1S3ltVnA3dmpvaFR1TWZNaXNXYmF2UWNLUm1xcHRoSTlwUUZpUU9P?=
 =?big5?B?dVo3b2RQN3lvdi9mUkJGWXhhY21tTk13TUdTeTFObnFyNTZyTmNGZTV3aTF1elBJ?=
 =?big5?B?TEw1a1FabUVETmw3UjJ5NmFGN1ZUWldtQnNZaU1ORTdSTVRJaldxS1FMbDU5RjdF?=
 =?big5?B?ZnZFZXVNTlRqV0VEckpKWTNXZjE0N1NDMzZVbkpwbDVodkVhc1lQdWE1bnVMeEFu?=
 =?big5?Q?OL7aMCHjdCrf3irn?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4827ec98-fc36-4e86-3dcd-08dd1990d48b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 03:06:38.7730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4jFZKdl1QS4DwUNGuUf/e76uEmvznrXrOGB4FUt81Yx09wxb2RUu0f+eeAt4Cy85RN3z3TEdQ1Vy1SCC8jbIRbWkJ3mCr7lWXk2AthPCO5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5928

SGkgU21hdGNoDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXBseS4NCg0KPiA+ICsJc3RydWN0IHJl
c2V0X2NvbnRyb2wgKnJzdDsNCj4gPg0KPiA+ICAJLyogQVNUMjUwMC9BU1QyNjAwIFJNSUkgcmVm
IGNsb2NrIGdhdGUgKi8NCj4gPiAgCXN0cnVjdCBjbGsgKnJjbGs7DQo+ID4gQEAgLTE5NzksNiAr
MTk4MSwyMiBAQCBzdGF0aWMgaW50IGZ0Z21hYzEwMF9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KPiA+ICAJCQkJICBwcml2LT5iYXNlICsgRlRHTUFDMTAwX09GRlNFVF9U
TSk7DQo+ID4gIAl9DQo+ID4NCj4gPiArCXByaXYtPnJzdCA9IGRldm1fcmVzZXRfY29udHJvbF9n
ZXRfb3B0aW9uYWxfZXhjbHVzaXZlKHByaXYtPmRldiwgTlVMTCk7DQo+ID4gKwlpZiAoSVNfRVJS
KHByaXYtPnJzdCkpDQo+ID4gKwkJZ290byBlcnJfcmVnaXN0ZXJfbmV0ZGV2Ow0KPiANCj4gSGkg
SmFja3ksDQo+IA0KPiBUaGUgZ290byBvbiB0aGUgbGluZSBhYm92ZSB3aWxsIHJlc3VsdCBpbiB0
aGlzIGZ1bmN0aW9uIHJldHVybmluZyBlcnIuDQo+IEhvd2V2ZXIsIGl0IHNlZW1zIHRoYXQgZXJy
IGlzIHNldCB0byAwIGhlcmUuDQo+IEFuZCBwZXJoYXBzIGl0IHNob3VsZCBiZSBzZXQgdG8gUFRS
X0VSUihwcml2LT5yc3QpLg0KPiANCj4gRmxhZ2dlZCBieSBTbWF0Y2guDQoNCkFncmVlLg0KSSB3
aWxsIGFkZCB0aGF0IGVyciBpcyBhc3NpZ25lZCBieSBQVFJfRVJSKHByaXYtPnJzdCkgZm9yIGVy
cm9yIGhhbmRsaW5nIGluIG5leHQgdmVyc2lvbi4NCg0KcHJpdi0+cnN0ID0gZGV2bV9yZXNldF9j
b250cm9sX2dldF9vcHRpb25hbF9leGNsdXNpdmUocHJpdi0+ZGV2LCBOVUxMKTsNCmlmIChJU19F
UlIocHJpdi0+cnN0KSkgew0KCWVyciA9IFBUUl9FUlIocHJpdi0+cnN0KTsNCglnb3RvIGVycl9y
ZWdpc3Rlcl9uZXRkZXY7DQp9DQoNCk90aGVyd2lzZSwgZXJyIG1heSBiZSB6ZXJvIHdoZW4gZ2V0
dGluZyBhbiBlcnJvciBmcm9tIGRldm1fcmVzZXRfY29udHJvbF9nZXRfT3B0aW9uYWxfZXhjbHVz
aXZlKCkuDQpUaGFuayB5b3UgZm9yIHlvdXIga2luZCByZW1pbmRlci4NCg0KVGhhbmtzLA0KSmFj
a3kNCg==

