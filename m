Return-Path: <netdev+bounces-143778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 554B69C41A6
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 16:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E2C282C10
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 15:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6531A08C1;
	Mon, 11 Nov 2024 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jkUQDbFG"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2077.outbound.protection.outlook.com [40.107.249.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA17142E77;
	Mon, 11 Nov 2024 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338101; cv=fail; b=ZC0dffGnZikdvTd62yzk8r/S3qXtD2kKIe6IKvwj1qFfTyA81v18ZCWVdgDKBTGSaYXzFGL+FXCRBETrNQOWnuAvFLzCgP+9/IpmIu2JhsejvlIDcx9tIpneRDPbc7DxFmlOa+BaTR2ofgr6X/bVueHF9fB6EsYjQHezncxWPOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338101; c=relaxed/simple;
	bh=N9Di+jAHHAnlRvwuJFiho6CH6sUHh96NsgyY8em7d3s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sqpTdRrZSr9nyqJaY5c6p4Tn9Kg5ZdHGPSuKkL328ybkKntHFxE8krWirCX6/OJHamy484fZOHZLFOGrlShf6/THEZJ0/f6NHj4hwTNJ8tm7DojQ0c4vrO0cjtAoKaQnkUbugsABjo7vnn/YAhI43clXgXlDPg9ogxokp9hTCrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jkUQDbFG; arc=fail smtp.client-ip=40.107.249.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMYOvXiMdsBsK6n0nbtUJNwSo3kQjGd9L1vOXcOtS8eCaLEdcL3PGN7ARt0bS/sdC2k/zeDY82XKkzTrWCoHKuHrGvzrEi87J1KWlhI428nUhQXVBVxf2CUF7I9sHlus2Wp2+rIH9tWU+/w2vnST4b3cJWktreNZkDiHzmuDCPN3jJUijOP0gBby/ygGBTKj69wyDtjC3q9x1NgCRJWlyCYmEm9VRiHUtpCvTcE2ZtvlDuYWzn/EJLfWOYJt5nLh+tlS0RLJZtmGqQCDWDgBaIIwEuyfJI1jU6nmqc2tmOWI4Md8dEYp0j6idq3iJqysWt8RvoPTtO2/M69WnXO0NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5kolSMkp2gdU6w6mK2nSSwop1g5+DvuQkKFegxm3wY=;
 b=dwtBJEuMWHzTFPvjwbTbS2TeNGJNgFRO3s44eaiba81Ojmxgk+lhwScu/XEGJiNbqJMn7vLEFcgWSjblPo+iw+ayds6pZNQGoZJvJNQ8BBU39gymgX66ap0UTzm/f1EEKz7wW3FqLnejnZWUCvYk28QNROIq/8AnfAXLXe3NkSfm2n2PHbX6fnfw5k+WEdqcvjWwLTdrM7hYfmGx0zAfCmK13qB3zRzjBcWwlEkd95n4unHsigEW3KXeJxCm7o2OdUcBV9lYx8QdWPk9wmBdboT+CoA78kpHHPFSQQRmgxb6wWC7fBs99jYoZekx+nIZdwzpdBvQteSbeJS9AObl0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5kolSMkp2gdU6w6mK2nSSwop1g5+DvuQkKFegxm3wY=;
 b=jkUQDbFG7ZNYIvr39ZrnhA+Mn4fBzc7qL/pIQeBusY8MajOYQNyvVm+aoOm1xxY87itLa45OHEzg7i28xdVyiYf9HUDIZl24/h9JaQMaSJ1zHSBeX0ydiatJJ7BicL1Fm+aXp8DreTh/QUzeW5A8eEnPoOgylE7OLKPeACtiKRcWM9U1b7I/dO5aoqu5dF1JJPLhwCvHiJ/fNspa2lQrCMHcU2ziAkFLFsUEJv/2iH0+MFIIFhGx+Toe7Otu6PBvXalyeSIbzQ0BMK86IuBiuIGmEyGJRs4mLAXFMNBp8FW9MkCXvuAG+kuZT94DOaxd5cCV4Roci9nmxjtuMftVkw==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by AM0PR04MB6932.eurprd04.prod.outlook.com (2603:10a6:208:182::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 15:14:53 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 15:14:53 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
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
Thread-Index: AQHbM96NucJF1ICp4UyDDMX2CMxvdrKxpl8ggAApWQCAAC+FgIAALrbg
Date: Mon, 11 Nov 2024 15:14:53 +0000
Message-ID:
 <AS8PR04MB884990E9C4EF08D844541B7296582@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20241111015216.1804534-1-wei.fang@nxp.com>
 <20241111015216.1804534-3-wei.fang@nxp.com>
 <AS8PR04MB8849F3B0EA663C281EA4EEE696582@AS8PR04MB8849.eurprd04.prod.outlook.com>
 <PAXPR04MB8510F82040BCB60A8774A6CA88582@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB85107F97E4037BAF796C69E588582@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB85107F97E4037BAF796C69E588582@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|AM0PR04MB6932:EE_
x-ms-office365-filtering-correlation-id: 4be2f7c2-6bdc-4160-fca7-08dd02639806
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?d1R2dmZUMWllOVZVSlIxcjRWMzRNbGJUOE9mMGhxck00NnRzUjc2aTAz?=
 =?iso-2022-jp?B?NU5sYjVYNENuSHRkOGEwb1dvbkVFMFcrV3dDQmM5citkRHdGRzg5cEJp?=
 =?iso-2022-jp?B?aEM1Wm90TnlWSWtoYkJBZTJMcFBLWEpMUktVTHprR2ljaS9maU1aWGlo?=
 =?iso-2022-jp?B?TnhkR095czRUakJPcUh5cndhNEhreUxhdkdRSzFLdGExbFpzSnpPb3V4?=
 =?iso-2022-jp?B?ejJRMGh3RXdDc0xjSmhMdVhMV1VERFJSdkl2ZnlSNEYwN2tWV1kvNm5k?=
 =?iso-2022-jp?B?T0tZd0tnMlhSSFREbGs1bENqUllEbXZESWhBZXpuMzBUSzZJZHVmbTlV?=
 =?iso-2022-jp?B?WVpiNHRsZDRJaXJnNWs4c0I2TlgxV0RicGtLTjBOcHpHajR3WFg3RWRV?=
 =?iso-2022-jp?B?OHBjSlZmN0RYamlLTTgrTVYxaWMzWnZJTGc3cDQ1dHdwcnNweFpXZ1Vu?=
 =?iso-2022-jp?B?WkZHWG5rbnhTZUpVT1p4WHJTNzhLbmp6aUtMUWV2cFBxeXgrOEpQQUZG?=
 =?iso-2022-jp?B?SVFNdGpwdUpocDNXaXk3OEhYU0RsK0FQclRqZFM0Q2Y3UnNHZ2FXSysw?=
 =?iso-2022-jp?B?Z0VTVENXUWdQYUVsaHVoMHA2UkRSWTBJbERrTTdmM0lTbUtnVC9OR3Js?=
 =?iso-2022-jp?B?YXErMWM3eUZNaENsdVVBcmZjVGcxOVM3MlV6bnFoeHlCWkQyc2ZRWUNl?=
 =?iso-2022-jp?B?N2lpSU8xMWlLUUtBRFhqa0paWTlqRWlBcUxVRmh3aFVYU1FzeGc2UXlD?=
 =?iso-2022-jp?B?Rmg3WUV6YmJzY1EvNEd1MkY5NTZ1V2ZlY3FhVVhjWHIrYm9WWHNhVktW?=
 =?iso-2022-jp?B?NXQraFJ1bXNvVVhwazlHSmk1SWMzNzFGMXRkVVpLTjdyZjlsQWVrT3NK?=
 =?iso-2022-jp?B?Rjd1QXBZYjFkY2NXanZKTWxFa2JhQTBsblpyMVBWRmZ1dzFUcmg1QmdE?=
 =?iso-2022-jp?B?N3NjQXBuU29MbU5SdEkxRHd0QWIvYm1PU0dkZjRYUmI0NGhmZFpEMVpP?=
 =?iso-2022-jp?B?c21UbnZsMkoyVk56T1dFN3NMSHRpOTluL2Y0Mzl2YVRaK29kMW4vdyto?=
 =?iso-2022-jp?B?N1pXUm5uVkFFTWFEbm14ZlZJdDZKYzcrZWtnclRlamd5QUR5YjIyNFIw?=
 =?iso-2022-jp?B?akdMeTBSZXkwY1BRL2taUUZKK2NJUDFOS3VaM0JJeWxLUW9xU0ZnTWVL?=
 =?iso-2022-jp?B?WXB5UXJPMUNYdWdNVHVadk9DN2R6M296OVp5eUVpaUdpaTRsMGdQUzM2?=
 =?iso-2022-jp?B?dm0vZXpJUVVydWtZYWtta1Z0WDZDVjJpVzRGd1V1VGcyYjdnSWhhbUZ0?=
 =?iso-2022-jp?B?UWJ2WDkrSmo2WndseUhVd2llMHdwdHJDQk1VUy9vOFdBTHVtMnI4T3Nh?=
 =?iso-2022-jp?B?TFI2TVBpeVdnSmN4UnVDM3gxTVNXUUZDL2drT3h3UFF1dHJPdW1XUjVF?=
 =?iso-2022-jp?B?SUorQmNRbkhCczZRU1Rxd2pPYWZCYUxwaTRRRnVDY0tVOEx5NDMrSnJC?=
 =?iso-2022-jp?B?cFluSGhndjBHVnJjcGM1M2JwT3MrK01EdWlmN2ZaelpYdHAyVlVoaThz?=
 =?iso-2022-jp?B?V2FCbkdaVXkxM0Z6SkVhQjNRSmxaSmY2QWQwUmRaZ1psY0dzYVNzR3R3?=
 =?iso-2022-jp?B?aG8xRVllTU1HTkhBZGJqWnZEVU9wZFc0Qno0bVRUank3RjE5RnNJaG1w?=
 =?iso-2022-jp?B?dUdUa0ptUXh2VmxybmtuY1RTelZvY1drcWtpb1BkbDdNRFFtTHk2NStG?=
 =?iso-2022-jp?B?TkpQYSswUU1FcFFKbmhqUmdFVlJxdEJZemljY0dKbGxneUJYSDdza0tu?=
 =?iso-2022-jp?B?azFDa09mRkd3UnhNMEhpVDFTZFVDRGVmalFCcTVDOWIzMHRvUDVka0lM?=
 =?iso-2022-jp?B?Z3BVeURFZ0V5RnRjVUl3Y3ZIVkwxVmpWU0ZGZkczaENNWGZXbHNJb0lt?=
 =?iso-2022-jp?B?bE9QRzBJajE4UGowbUYzRk9oSG9lODJIR01BajRxenIxYlBNeGgwVXZi?=
 =?iso-2022-jp?B?VT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?dnlEZDJTbnZ3WFpUWmdjWXp5UlBja1lCbUNXSGpXNzRIRmZEcjFlanRi?=
 =?iso-2022-jp?B?OThrNTRVcWVCK04ybHZXVTVTWStSZGdQQ0FKUnFXQ3Q3dHNGbGdTQ1dG?=
 =?iso-2022-jp?B?cDFkdkpEOGQwUUhNKzRJRXErMHR1eTZMT2JlR05Cd1poaDgveGZjV1Bu?=
 =?iso-2022-jp?B?ZjRlUVFseEtyZlpacVhUbTlSRWphL3JIa3FkakFYY0hldVd1UXpjMm00?=
 =?iso-2022-jp?B?R0loaTF1TmRaa1FmVStjTURscCtHWXlnMVplMWloaVlpZkJ6WmNxMThU?=
 =?iso-2022-jp?B?S0N0SFJtOXV3Tnl2dWRES00vaHp3OEZuSmxZTFRSYkhIZTB4aWk3dDNy?=
 =?iso-2022-jp?B?bzMwTE82cC9QVWpsLzJoTUM0amtDVktIcjVrcDBrT3hDamQzYUx6M0oy?=
 =?iso-2022-jp?B?SW9KZmp0dUNBa1hrSTd0Wk1kRzRaZ1NBMHBIdis3QnJMb0NTMUYydjdk?=
 =?iso-2022-jp?B?MmVNMEUyYzVvN3BmNVViY0VYSGprK01qUGF1ZTRmdGN3dWl5dFBSd0Qw?=
 =?iso-2022-jp?B?VU9xSHJvNXIrZnVNdGZnWGxvbjZVQzgzSzUydkVPbG5QRmVRWDNCbWNu?=
 =?iso-2022-jp?B?T2piRVBXYSt2V0VwWXNMWlA5SnFEdW4rS0RJOEF2cWs2TGtJT1IyYnBw?=
 =?iso-2022-jp?B?QVNKYW1BdzlQMTRjQWFmTmtIRHlVOGVGR2QrK2xGT1pmQXRjV3JhS3d0?=
 =?iso-2022-jp?B?enp1Zmt0cFRYYmcxaXhoYlNjRUlFU1Z2S1RhY3BzcDIwZExlNmhSWDZy?=
 =?iso-2022-jp?B?ZHBZYngrQzNZYTBjTnlkMUpTdWp0Sjlta2E5WTFWcjdWOHFEVFdGZ0xG?=
 =?iso-2022-jp?B?Unpna2hESEt1bEJzT1FJUlE1bTF6MVNVK2Y4eXVOcWVBK0lmV3F3UnB3?=
 =?iso-2022-jp?B?TWZScEJvakRqaU01bFg4eHUydU5icis1bXAvZ21PbXk0c3p2UWhKUFFN?=
 =?iso-2022-jp?B?SFAvZkZrK3FoTFIvV1J3VHhzSjlzcmhiVWY4VDZmY0VwMVRzR3JXNVcx?=
 =?iso-2022-jp?B?bjNKOTdEYUVFK3dBSUZHVHJLQnBUSG4yRHVrWktOZGZJTGpITit4Yno2?=
 =?iso-2022-jp?B?VHhLUm1RWW9yR0dEazVRM3JSeC9oWUVNZ2JXbWJFUG9LSHh1TnloWERS?=
 =?iso-2022-jp?B?eFlJY3Y4R3B6MVhkZ0Z6TitDYUh0SHV0dzdxUVhzYm5MNU1QNVliSzFO?=
 =?iso-2022-jp?B?dFd5VWJxN01XZ0ZkU1YvZDh5Q2F0RmljUGhRZkdDY2IzOG83cjZENzE0?=
 =?iso-2022-jp?B?TU9UTHczT0wyYkRucy9veDBUWFBqcC9UVXhVR3JvYWVac1ZVV25vV1Za?=
 =?iso-2022-jp?B?SWNSMjZSbjJuTjFEcW5MamhzZ3h3RjZPNHJqUXROYmd0UHR4MkVseVkv?=
 =?iso-2022-jp?B?UisvdnBhanB0UGcrTnpnTEFPbmticzhYYmJMVlQzSFFwZGJBcHZmMXhp?=
 =?iso-2022-jp?B?bzdXSTRIMGFpeGJQQ2FNT3pIcTdPYkhGLzdmN3FIQ3lEWXcvUk9qV3RD?=
 =?iso-2022-jp?B?QUZaTE5sUGYybm12NFVkYjlBZ2xvcEUvQkxLOGhFdnMrZ1pYTkNHeFJx?=
 =?iso-2022-jp?B?ZzRvM3NtTFJBSUYzeTBHM2Y1WlR6bXAzUE84QjNiQkc5YnhIenN2S3kx?=
 =?iso-2022-jp?B?ZlN2TEJPRFNjTGpsWVkvcDVaVGN0S0crSjZBcDJ4czF2L3RrQ1JIaW9t?=
 =?iso-2022-jp?B?YWt6cG03MHVXVS9KbmxSZHhFcFBPYVoxdDVCL2pBTlNYWEZjRW9RUi9I?=
 =?iso-2022-jp?B?ODU0cDVNOHNPOFJQREt1ZGg0bWEwMTNEVVhQZUZnR2pidlRJQmdUaU95?=
 =?iso-2022-jp?B?SUE4di93V1V5VkFQZUdXWGEwRGVpdHFOY05McjZFRlR6Y09BcktCMWNo?=
 =?iso-2022-jp?B?NkpRaTV2U1hLQ0prSmx2UzN0ODNkeVhteVFCNnhOdUFYOXFNNG9UVlpk?=
 =?iso-2022-jp?B?WG43SlBiazEyNUpOYkIwNmY5UFhyLzBvOURIZEQxN1hUYVZuR21XdHFz?=
 =?iso-2022-jp?B?OENMTm15TFNkbWRCRVhHNWZxS216T3N4SDRZNnI3Zm1vTzdhREI4bC9K?=
 =?iso-2022-jp?B?TnpZR2I3cFJmUm1iQnM5QlNITEVDcFZUaFlrdUZ3bzQvLzk0U1h5MW05?=
 =?iso-2022-jp?B?T25OM29oVEovWTFBdzhSUjBoc1RWM2hnSFd5UERjeFpKeVBpMFVtK3lV?=
 =?iso-2022-jp?B?WE43L0JYVVZ0ME4rcG9YZHR1Ukd3cFI4VllRTmFkUFh5VFAyZ2IwUHEy?=
 =?iso-2022-jp?B?UHpjOFNYQ2Q5eFFmSWt3YWlvWm5EUGZUY1RNYmloZ0o5TVNZVEpwak9u?=
 =?iso-2022-jp?B?dnQreA==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8849.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be2f7c2-6bdc-4160-fca7-08dd02639806
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 15:14:53.1778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ki6c9/JG6GJEwHlriowoanJB3tV5pW8KsKGbzXYUoY+QWXsyloZW7rm2EVg1qU9Clwv69lZbclXRGpJeNork8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6932



> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Monday, November 11, 2024 2:16 PM
> To: Claudiu Manoil <claudiu.manoil@nxp.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; imx@lists.linux=
.dev;
> Vladimir Oltean <vladimir.oltean@nxp.com>; Clark Wang
> <xiaoning.wang@nxp.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Frank Li <frank.li@nxp.com>
> Subject: RE: [PATCH v2 net-next 2/5] net: enetc: add Tx checksum offload =
for
> i.MX95 ENETC
>=20
> Hi Claudiu,
>=20
> > -----Original Message-----
> > From: Wei Fang
> > Sent: 2024=1B$BG/=1B(B11=1B$B7n=1B(B11=1B$BF|=1B(B 17:26
> > To: Claudiu Manoil <claudiu.manoil@nxp.com>
> > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > imx@lists.linux.dev; Vladimir Oltean <vladimir.oltean@nxp.com>; Clark
> > Wang <xiaoning.wang@nxp.com>; andrew+netdev@lunn.ch;
> > davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; Frank Li <frank.li@nxp.com>
> > Subject: RE: [PATCH v2 net-next 2/5] net: enetc: add Tx checksum
> > offload for
> > i.MX95 ENETC
> >
> > > > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > > > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > > > @@ -143,6 +143,27 @@ static int enetc_ptp_parse(struct sk_buff
> > > > *skb, u8 *udp,
> > > >  	return 0;
> > > >  }
> > > >
> > > > +static bool enetc_tx_csum_offload_check(struct sk_buff *skb) {
> > > > +	if (ip_hdr(skb)->version =3D=3D 4)
> > >
> > > I would avoid using ip_hdr(), or any form of touching packed data
> > > and try extract this kind of info directly from the skb metadata
> > > instead, see also comment below.
> > >
> > > i.e., why not:
> > > if (skb->protocol =3D=3D htons(ETH_P_IPV6)) ..  etc. ?
> >
> > skb->protocol may be VLAN protocol, such as ETH_P_8021Q,
> ETH_P_8021AD.
> > If so, it is impossible to determine whether it is an IPv4 or IPv6
> > frames through protocol.
> >
> > > or
> > > switch (skb->csum_offset) {
> > > case offsetof(struct tcphdr, check):
> > > [...]
> > > case offsetof(struct udphdr, check):
> > > [...]
> >
> > This seems to be able to be used to determine whether it is a UDP or
> > TCP frame.
> > Thanks.
> >
> > >
> > > > +		return ip_hdr(skb)->protocol =3D=3D IPPROTO_TCP ||
> > > > +		       ip_hdr(skb)->protocol =3D=3D IPPROTO_UDP;
> > > > +
> > > > +	if (ip_hdr(skb)->version =3D=3D 6)
> > > > +		return ipv6_hdr(skb)->nexthdr =3D=3D NEXTHDR_TCP ||
> > > > +		       ipv6_hdr(skb)->nexthdr =3D=3D NEXTHDR_UDP;
> > > > +
> > > > +	return false;
> > > > +}
> > > > +
> > > > +static bool enetc_skb_is_tcp(struct sk_buff *skb) {
> > >
> > > There is a more efficient way of checking if L4 is TCP, without
> > > touching packet data, i.e. through the 'csum_offset' skb field:
> > > return skb->csum_offset =3D=3D offsetof(struct tcphdr, check);
> > >
> > > Pls. have a look at these optimizations, I would expect visible
> > > improvements in throughput. Thanks.
> >
> > For small packets this might improve performance, but I'm not sure if
> > it would be a significant improvement. :)
> >
>=20
> I didn't see any visible improvements in performance after using csum_off=
set.
> For example, when using pktgen to send 10,000,000 packets, the time taken=
 is
> almost the same regardless of whether they are large or small packets, an=
d the
> CPU idle ratio seen through the top command is also basically the same. A=
lso,
> the UDP performance tested by iperf3 is basically the same.
>=20

Maybe there's a bigger bottleneck somewhere else. I would change enetc_skb_=
is_tcp()
regardless, instead of 'if (ip_hdr() =3D=3D 4) ... else ...', you can have =
the one line return statement
above.

As commented before, I would try to get rid of any access to packet content=
 if skb metadata
fields could be used instead, but I don have a solution now on how to retri=
eve the IP protocol
version this way.

Thanks for testing anyway.



