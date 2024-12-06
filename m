Return-Path: <netdev+bounces-149673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6755E9E6C81
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 11:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04EA21883425
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F7D1F4269;
	Fri,  6 Dec 2024 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QWSsMKrw"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012009.outbound.protection.outlook.com [52.101.66.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8011AAE10;
	Fri,  6 Dec 2024 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733482016; cv=fail; b=ZA7ANZS4RJTitrBBY+tnzViQiflOrJ9OvLSvzQLb+W4ZV5A7/c5Z/VUXTNxGr9Hf2SO636z/S6DnGrNwYzJ2rAOFR4MlciPuufeLWAMvEpwJUBs/3h4sBykjpxEU7229e9FobinU6W3piE8ryn7rhVM6M40JzlWHmE/PsynAcVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733482016; c=relaxed/simple;
	bh=g5C1e63ohk6ztqN2NyW0J8SIaIN4vmxLeexUr9Xb5Dw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qopk9lz3OzPynOdGoNfS6LTlhFwLhO34vtRJtxC18uVKpsBIaBYHEf4K3jtXWYcrKSH6To19PXqYVe67dhGysXIIXY8C6HyewsZEmN5uEVTSQj1AwkNkwd4wKJiXY9cdeUisWECKO+QKM/J+9YrWRmp3tiqSHkdEdo3DwMn+A48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QWSsMKrw; arc=fail smtp.client-ip=52.101.66.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emvSgmnqnnrjSUOZRFYvKTC2vbiJ9FJZzbXTe8R0Sgd2mkDSo7vsSjIM3Xd6EOzf5RoRqj/OD2K+N0gL3xUA2Xw2UiUWkE6WTYTechBmx86XP5njPXrnoUdqzNVRW8Q5K8rVRocPnkcdQsyoMSPMQWFf9Q+FHsRfgSOGi1Mx0wpjyo1BR8jGvuIdleYaox5KmKrnlxGav7P4m0dxUJ0NULnJ1DedX2+5fGCW/i2PXn8+3QDR5GYwy2HKyYP+Sb1XLNiuFhBQD9EHcTKtmz4L9f54tpX2g9tg+r6eQIPA5+YU2R/KDEie5SfQhqZ9v6mGz1fSW1qaIaABWgHIMwjleQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5C1e63ohk6ztqN2NyW0J8SIaIN4vmxLeexUr9Xb5Dw=;
 b=wYK+OOcVg+/ciLA1hbatVnDjwPSegpnWR9+GKcgYzAYs0xix9LyXZBhQzPcVohclZRg0kRAe6pM//V0uZYpwOdNyHk6wNUbkAqHKZGQfQ/c5sc3ONFp1JtR7t61U6wGOaTtE0XwSD2oBE/wQHyvLoB3H5OE8fqwgTztS4ihn693Ak57SK7SeC8GYrr1e0fhF8aHMcOWUxXzRA9dkAHIADey8zuwbayqIx5dM6v/ZyKzzaWZcdtowuixWuuuaCOdjK60uq80LOZVKQohU/D1wXIRutdaCgjnlesPIlcsmaLficIS/rGZ1IdtJiAYDp9nDuQ9kQ5J7TgR30N7syHFyRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5C1e63ohk6ztqN2NyW0J8SIaIN4vmxLeexUr9Xb5Dw=;
 b=QWSsMKrwAjVUw9TWwHOpzzU7CMyHOY9T6EcVLEcRM8DltLf9xs073LKM5J9uflQx6yjpWKS/l/II2BXegtffQBm6Q71QIE1D/Gr6d1cuQBVIvHD9D7xChYP1uYRl/4ySCUJ105u+F7XX5qCje9/KvpDm7IbZ9o2q48U3uXGqyaRkjGC8pzBS8rjfGR53nphfZ0RNai16XKV47qFgOR3bBU215cc7Bm4PkfDXfp2ma3wcT4+iSgJyoWp37eybAhU4DvB5It+cLJgWDat6Y+HRnwyYvUGuskgsuj/ZR+X9enCHA2480VgbmL0UHzHzJHTC4zqkgZ1HDNrwIFFWyQW9uw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8503.eurprd04.prod.outlook.com (2603:10a6:10:2d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 10:46:49 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 10:46:49 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Simon Horman <horms@kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Frank Li <frank.li@nxp.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v6 RESEND net-next 2/5] net: enetc: add Tx checksum
 offload for i.MX95 ENETC
Thread-Topic: [PATCH v6 RESEND net-next 2/5] net: enetc: add Tx checksum
 offload for i.MX95 ENETC
Thread-Index: AQHbRg+8AbbuO/ZnDUqQrVEXfplrYbLY+LYAgAAQk6A=
Date: Fri, 6 Dec 2024 10:46:49 +0000
Message-ID:
 <PAXPR04MB8510D797ABEFA1D6153A3C9A88312@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241204052932.112446-1-wei.fang@nxp.com>
 <20241204052932.112446-3-wei.fang@nxp.com> <20241206093708.GI2581@kernel.org>
In-Reply-To: <20241206093708.GI2581@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU2PR04MB8503:EE_
x-ms-office365-filtering-correlation-id: 60d465e7-5197-44cd-663d-08dd15e349f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?NUZYL1d3T0owL0xVb2E2SWVBWjBqWkZTNmY3TFhoN0tqRWNVVWdGL2xUdFBT?=
 =?gb2312?B?OHJSSkI1YXMwSmt1VFRxUXYwT1ZvcmJ0MDlIMFpkWlRNdnBKbm1RZ1B0a3hF?=
 =?gb2312?B?bWRUaHNDMjQ5VzIrRTlpQzVkQUowSERsUzM3WGpwdGFvc2Z5bjRzWUxQN3kx?=
 =?gb2312?B?ZlpqTHNXbWJHZ0pZRU1kYzVvaGFmbGpYNTF1YTB4NEhXdmQ1bVkxQmpDMllH?=
 =?gb2312?B?bjVwc2NndGZZMEQ2cGREU2VtQ1ZEdmx2N2dtc1BYL3BSY0lUMzFPcVNSKzFy?=
 =?gb2312?B?WW52MStTN05LNDZZcHd4VDRjemw1dlZuVWZMb0NkbmxRWHF3QU5paHhidjJO?=
 =?gb2312?B?QUZHL1RKT29UdjBWbjBMMHpZSytlZU82ZzJVVElKaE1Fa2hSaGlBZDh0eWt3?=
 =?gb2312?B?ZWhDcFplYjFQUnlWWUV1Qk9acVVPYkQ1RlJSaWZRQmExbVNRL1A5dGtWa2FC?=
 =?gb2312?B?bzhIKzJqQUdTV296L2JadUFxdkMrZVBtTWhrM2E3Tm9pT2R0Y1NoSU1mclZt?=
 =?gb2312?B?N3pVeGZWUGRVbHl6d3V3ZGVQR05nZW9LMEYyQzhwblJEcXo1ZkNmUThua1JR?=
 =?gb2312?B?cVV5bXpFRDhrV3F1ZTNwcXF6dktoZmN3VzI1NnNjQkFQS3ZUeVdSaFBNTG5t?=
 =?gb2312?B?TkJ4WDVWcTN5RXE4Ry94bHl6VHFtcFFiUmEyaU5VUHpUM1ZvZWZxRm1zdkNY?=
 =?gb2312?B?dTVzQ3pRRDV6cmdCSHh1MXdBL2lzdXhkaTZXYjRxbnIrb1Q4S1hUaWdhclVY?=
 =?gb2312?B?WTJza2k1bEQ4S3JDdGxydXZoL2RpbGZOcmN2Rk5GRno5UmgwRjZSamgwbDIy?=
 =?gb2312?B?RWxYSFZoSGs2YW5hcjgzZGVlcVkyV2J1eUU2c2pQV1BkT0M0ZUJxeU9DR3Ru?=
 =?gb2312?B?MnNNMjROTnViRnVaN0NmeFhyK3NLRWUxT21QRUFHbHA5UGJlZXBrSHgrQUYx?=
 =?gb2312?B?TmdtR0hNTENTU2hmdFVnU0RhNmd1MmZsMFA3WUlFZFl1eDExMG5LT2ttSm85?=
 =?gb2312?B?Z2VQRzUxakJnR2wvbG4ydjVCNWJQamd4TThxdEl5VHNkOEdhTDRIZXM4dFFR?=
 =?gb2312?B?SnFVRnFrZ3pNWmd6czFxMGFBREVMYXp6TDVmYm1PZTE4aHlUelIrN1o3Y0l6?=
 =?gb2312?B?V1d2YlhMNGgycEJXa0tHWmV3NlYyb1NOTDB4SHBLNGpoUjRic1h4Wm1ac0Yr?=
 =?gb2312?B?ZWZiUnFDN3ZqOVlvQWFpQmtpZUVib0hiQ0k5UStGellESWJLekNnN3JWMmtF?=
 =?gb2312?B?M3BJWGJwMG1rNzBtQ3BhZFZ5RzB0TzUyZGVqQzdWcmNXTFJWVmh3a0RvdkY2?=
 =?gb2312?B?cHgwNFdHZ2xRc0FTZCtIWGlsajZ4ZzJtRFlyc00yaWJjMlNLZFNKcXVDUzBx?=
 =?gb2312?B?WlNZQW41N09SNWJwbmp2OW9OWnQ1a3RKTlZJTjJmQTYvYldJWTgrY2w5a2tT?=
 =?gb2312?B?NC9IcGh6UFBydS9LaWl0NXZuSnNhTllhSkRvcFZob0NwSFh5MENTZnMwWHFp?=
 =?gb2312?B?ak14eDd0dUMwd1pESDlxcTYyalhJUklFdjlFZFBpMDBRcFpDQXpNS0JJZitj?=
 =?gb2312?B?Y1FJdFlnSitwaWVacXRxZ1RVMFp0VmpFTTB3Rms1ZGI3SEJjdlcwY0dTZjZV?=
 =?gb2312?B?K2pseFNwSVdyZXJvaTlrcU9WUE9EY256ekFOYUlDSmhtU1FlQ0dSUld4d2gy?=
 =?gb2312?B?Z3pCMnJSWmZMa1RQK3F2RU9mYlR3TWNxN2RiOHlOaXlmcXBxZEQ0eFJzbFFR?=
 =?gb2312?B?Y0NkTk9KUHphbC9hZkVpNDdDWkhDbGlXdklLNlNJeGx0SHhJTFZGR1FHNFcv?=
 =?gb2312?B?WjArVzJSUDRDWW5hR0ZJSWFGUUtEd0xGZC8yY1dDWDNLMkRZb2k1NHdRQ2JI?=
 =?gb2312?B?c0paZk5uanpOelF3dXlQRlI5Y0h4em5vNnpZWDBVWHRhVFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?TjJRUXp2WmZ2ZUJhVkhscEY3eEF0b2RjZ1hKZ3dKc3VXdU9mbXZ3TkVlYU0v?=
 =?gb2312?B?Wjh6T2ZzZzVuQWJ6bXZuVFVXbUNvcDJpMXppMHpBakV5VSt0RWR2eFh0RmFZ?=
 =?gb2312?B?TmVZUjNVbXpHc3VmWS9aTDdCMlNSVVc4M2UrTVlzYnRyaDZuaUFXeGJ5M0lJ?=
 =?gb2312?B?ZkFpd3IzbTlqUjFTdnZBa0JzMnR0c2Q4Y3lEaDczU1ZMNFExazFPcmZnMWVX?=
 =?gb2312?B?SDZkVTd5UVMxVUdjOUNRQ3VUQmRrSWZhWFlRWGV1NVN4RXI3dlVGWlA4Zlh4?=
 =?gb2312?B?cy93MzJ2SmJldTFNaDIxaE1kd2xiMForbGM4a0M5RXJsMWRydTlIdXpZR1g5?=
 =?gb2312?B?OFV5M3Y2TXJuT3dUdng4cmxzRlFGalF3eUNYR0tIZ3pST3NMSkdsVnpWQTZQ?=
 =?gb2312?B?dHFzVDFWV2hmb3ZyRkg0L2VnS0FrUlVJRGZjUGhVSnNvcUJOVzI0Nmo1Y09C?=
 =?gb2312?B?M2g3cDlFU1VzbmdLNlhJQ3dJQk1OOHpUNUhqdU9nZ1VnNXg5anM4RDNlYlVG?=
 =?gb2312?B?czNqYk05VDRNblQ3OEU3VVNSN0JzL3NFbmZma0VtcnJBSkY0djhSRDkrMFJK?=
 =?gb2312?B?UkYwdW1XcE5FYlNIaHRNamRvYVlENEpZUkVIYVpraC9hM0JEQVdTRW1iNnMy?=
 =?gb2312?B?NDQ1eWR6ZWMvcTBPTHRYcEI5eVI3VEpPZ0FJQVgzZFZHVE1OR2R2Vm9DM29r?=
 =?gb2312?B?em83Tm9vQ0J1SjlGenVWRGZnZ01XN1Vod2Q2Uk0zNks1NGtNcm5zT0xTYkQy?=
 =?gb2312?B?ZjlLT0FzRFRzN3lCN2VmU3BHdEVjWG1WR3NOMUl0VHFsWCtPalgwYjI0T3Ry?=
 =?gb2312?B?WXNGZVBvZG5jZytMVDdEQ0MwWDVaNEt1V0hpcElYL05XWWpacDBiUU9QcTJo?=
 =?gb2312?B?UmdBcWFVNFlJbTNOSTJsWkhQUWY0THVsNld4V3QxSzFGYmRna2Z6eDM3VjM2?=
 =?gb2312?B?UnA1U3JHSExkV1Vjcyt3MDlZaWlzYnVnU29YcUJwUWgvd2FuZTBLUkJYNmhS?=
 =?gb2312?B?WVliY2IrOXV6TGRqSzJuei9qalVlTmxsWDg4SVUxNEpDY2hhbmFNWFhQQkVI?=
 =?gb2312?B?WXc1UmQwL3lDaVE2RkFFdHNxdHl6SUFyNk9mSE9KNEhzUVVCNGl4dEs4bVRx?=
 =?gb2312?B?cGk0bEV1MmVyN2FrbkZ5SzZOZVU4NXJPNnh4QXBjOXExSTFyVEhrN0tOWFRB?=
 =?gb2312?B?cHlvQ092SHdEa0I3L21ONEtJZXdseVExTG5vRjRjdnhzU1V6NDhuaDJXNi9t?=
 =?gb2312?B?NnhiSWlrNk9qYVBFaDBNNmdFZEp1VjFqQW50T0g4Rzc4VjdrcythdzJ3SGMw?=
 =?gb2312?B?MktXak5DS0NNMGl3ajVVN0UyN0FqMEsxaGlrS05MVzFSN0g5YUIvV3R4TWlO?=
 =?gb2312?B?eC9rbG4rRGFrUXBMaDIwY0FyK0IybG8zWURyK3ZaUHhKMkJ6ZnVnSUsxemdM?=
 =?gb2312?B?dzNGZ2JiQnUwdFoyeFhmZDNVaTNoTWI0Z2J5MzRiY3J1eW55S0ZXbE9GQTFo?=
 =?gb2312?B?Z1lFR1BLczhLNGpaQ1pKcmxjR3F4MCtFWWdGR2dKZXAwc0JuSUxDdEhOaktJ?=
 =?gb2312?B?Nm5jSDh6cnZSR0JqQjJSNXhEV2NpVjh4bXE3WDZpcExJU3NZSmVhQitSd2pq?=
 =?gb2312?B?b1ZMMTkxUUFEN2w2KzFaY0dlOHdvcjZIdWZZUTE2M0FpemFwM3BEaENmclNk?=
 =?gb2312?B?REowSUpjQU14di9LVkNhUW9nY2g0N3JoMWZOQ3U1UjJiZExpdnNRRW9yRkFB?=
 =?gb2312?B?UWRnbjFYaDZNMXl1dUU3Y0ZQNTA4R2pBbVNKVER5SjExL1MzZUQxbDJ3RkpW?=
 =?gb2312?B?b3hTdWFXMHQwWjdiSFJucWU2alJvMlhBYy8xT2NMeFIwQzU3UkxTNEY5R2ZE?=
 =?gb2312?B?dmM0QWpvZzBjeDN4QWpBNTVSUmRQWkptalVGSUFnNXcxaG1HSmcyTHRLcHZ2?=
 =?gb2312?B?aFpET1dWbVRJK2lMa1ZGdmtYRUlaRUo5SERqMTZQeUxwNlpWZUJHeXV0RmdE?=
 =?gb2312?B?aS9ndExyUnYrODlpZy9rQTFKVGhsRnFUV1h5c3Q0OTVvNHJJVzliV1BXM3JP?=
 =?gb2312?B?VzcyMURuUkU0cDFPWGJDMDZZMnBobVA1eno1eXJjbTd2WUs0UjRaSnBkMDNZ?=
 =?gb2312?Q?m5AI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d465e7-5197-44cd-663d-08dd15e349f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 10:46:49.8598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zjqh+6RZqLEeup3uJJyFYIQVrhUAHBl/CKEguKWgjJwH+fcNpNaZtM4IzCyIZNIIIBj4hTGjqGPYBwO077I5VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8503

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaW1vbiBIb3JtYW4gPGhvcm1z
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTE6jEy1MI2yNUgMTc6MzcNCj4gVG86IFdlaSBGYW5n
IDx3ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogQ2xhdWRpdSBNYW5vaWwgPGNsYXVkaXUubWFub2ls
QG54cC5jb20+OyBWbGFkaW1pciBPbHRlYW4NCj4gPHZsYWRpbWlyLm9sdGVhbkBueHAuY29tPjsg
Q2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsNCj4gYW5kcmV3K25ldGRldkBsdW5u
LmNoOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOw0KPiBrdWJhQGtl
cm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47
DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGlteEBsaXN0cy5saW51eC5kZXYNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiBSRVNFTkQgbmV0
LW5leHQgMi81XSBuZXQ6IGVuZXRjOiBhZGQgVHggY2hlY2tzdW0NCj4gb2ZmbG9hZCBmb3IgaS5N
WDk1IEVORVRDDQo+IA0KPiBPbiBXZWQsIERlYyAwNCwgMjAyNCBhdCAwMToyOToyOVBNICswODAw
LCBXZWkgRmFuZyB3cm90ZToNCj4gPiBJbiBhZGRpdGlvbiB0byBzdXBwb3J0aW5nIFJ4IGNoZWNr
c3VtIG9mZmxvYWQsIGkuTVg5NSBFTkVUQyBhbHNvIHN1cHBvcnRzDQo+ID4gVHggY2hlY2tzdW0g
b2ZmbG9hZC4gVGhlIHRyYW5zbWl0IGNoZWNrc3VtIG9mZmxvYWQgaXMgaW1wbGVtZW50ZWQgdGhy
b3VnaA0KPiA+IHRoZSBUeCBCRC4gVG8gc3VwcG9ydCBUeCBjaGVja3N1bSBvZmZsb2FkLCBzb2Z0
d2FyZSBuZWVkcyB0byBmaWxsIHNvbWUNCj4gPiBhdXhpbGlhcnkgaW5mb3JtYXRpb24gaW4gVHgg
QkQsIHN1Y2ggYXMgSVAgdmVyc2lvbiwgSVAgaGVhZGVyIG9mZnNldCBhbmQNCj4gPiBzaXplLCB3
aGV0aGVyIEw0IGlzIFVEUCBvciBUQ1AsIGV0Yy4NCj4gPg0KPiA+IFNhbWUgYXMgUnggY2hlY2tz
dW0gb2ZmbG9hZCwgVHggY2hlY2tzdW0gb2ZmbG9hZCBjYXBhYmlsaXR5IGlzbid0IGRlZmluZWQN
Cj4gPiBpbiByZWdpc3Rlciwgc28gdHhfY3N1bSBiaXQgaXMgYWRkZWQgdG8gc3RydWN0IGVuZXRj
X2RydmRhdGEgdG8gaW5kaWNhdGUNCj4gPiB3aGV0aGVyIHRoZSBkZXZpY2Ugc3VwcG9ydHMgVHgg
Y2hlY2tzdW0gb2ZmbG9hZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlaSBGYW5nIDx3ZWku
ZmFuZ0BueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBGcmFuayBMaSA8RnJhbmsuTGlAbnhwLmNv
bT4NCj4gPiBSZXZpZXdlZC1ieTogQ2xhdWRpdSBNYW5vaWwgPGNsYXVkaXUubWFub2lsQG54cC5j
b20+DQo+IA0KPiAuLi4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Y19ody5oDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJl
ZXNjYWxlL2VuZXRjL2VuZXRjX2h3LmgNCj4gPiBpbmRleCA0YjhmZDE4NzkwMDUuLjU5MGIxNDEy
ZmFkZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5l
dGMvZW5ldGNfaHcuaA0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9l
bmV0Yy9lbmV0Y19ody5oDQo+ID4gQEAgLTU1OCw3ICs1NTgsMTIgQEAgdW5pb24gZW5ldGNfdHhf
YmQgew0KPiA+ICAJCV9fbGUxNiBmcm1fbGVuOw0KPiA+ICAJCXVuaW9uIHsNCj4gPiAgCQkJc3Ry
dWN0IHsNCj4gPiAtCQkJCXU4IHJlc2VydmVkWzNdOw0KPiA+ICsJCQkJdTggbDNfc3RhcnQ6NzsN
Cj4gPiArCQkJCXU4IGlwY3M6MTsNCj4gPiArCQkJCXU4IGwzX2hkcl9zaXplOjc7DQo+ID4gKwkJ
CQl1OCBsM3Q6MTsNCj4gPiArCQkJCXU4IHJlc3Y6NTsNCj4gPiArCQkJCXU4IGw0dDozOw0KPiA+
ICAJCQkJdTggZmxhZ3M7DQo+ID4gIAkJCX07IC8qIGRlZmF1bHQgbGF5b3V0ICovDQo+IA0KPiBI
aSBXZWksDQo+IA0KPiBHaXZlbiB0aGF0IGxpdHRsZS1lbmRpYW4gdHlwZXMgYXJlIHVzZWQgZWxz
ZXdoZXJlIGluIHRoaXMgc3RydWN0dXJlDQo+IEkgYW0gZ3Vlc3NpbmcgdGhhdCB0aGUgbGF5b3V0
IGFib3ZlIHdvcmtzIGZvciBsaXR0bGUtZW5kaWFuIGhvc3RzDQo+IGJ1dCB3aWxsIG5vdCB3b3Jr
IG9uIGJpZy1lbmRpYW4gaG9zdHMuDQo+IA0KPiBJZiBzbywgSSB3b3VsZCBzdWdnZXN0IGFuIGFs
dGVybmF0ZSBhcHByb2FjaCBvZiB1c2luZyBhIHNpbmdsZSAzMi1iaXQNCj4gd29yZCBhbmQgYWNj
ZXNzaW5nIGl0IHVzaW5nIGEgY29tYmluYXRpb24gb2YgRklFTERfUFJFUCgpIGFuZCBGSUVMRF9H
RVQoKQ0KPiB1c2luZyBtYXNrcyBjcmVhdGVkIHVzaW5nIEdFTk1BU0soKSBhbmQgQklUKCkuDQoN
Ckdvb2Qgc3VnZ2VzdGlvbiwgSSB3aWxsIHJlZmluZSBpdCwgdGhhbmtzLg0KDQo+IA0KPiBPciwg
bGVzcyBkZXNpcmFibHkgSU1ITywgYnkgcHJvdmlkaW5nIGFuIGFsdGVybmF0ZSBsYXlvdXQgZm9y
DQo+IHRoZSBlbWJlZGRlZCBzdHJ1Y3QgZm9yIGJpZyBlbmRpYW4gc3lzdGVtcy4NCj4gDQo+IC4u
Lg0KDQo=

