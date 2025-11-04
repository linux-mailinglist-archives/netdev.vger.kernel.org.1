Return-Path: <netdev+bounces-235395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C89C2FC1C
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 09:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABA0D4E74B7
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 08:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7EB3101D8;
	Tue,  4 Nov 2025 08:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IdGdpJp9"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013053.outbound.protection.outlook.com [52.101.83.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE3D29993A;
	Tue,  4 Nov 2025 08:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762243396; cv=fail; b=N/w3FIArMBBenbCTIF3yPNmkGLhZrwMKi5WPXaZ6Hwl5Vb1rCAmE3TuVMcRHLxTwKWLaWvzhWHW4+7hHemiTQbI82pScLeOdN2GR3YmQXGxtDQCd6xGI1X69jmotjcq1+ifbOb/CHf9EMIpMw2kZJkQNp+xZzUM2v6HOemDUbAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762243396; c=relaxed/simple;
	bh=9oVUfIFlOA1xMvmAC30NjxpA2yFB7Wv0pfIeoUwLfYk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bDHmEUfILam8psSOkUPbrXZeznzxmV+nu1z/8aWlNHE98kfjSkkyGfRUDfV2zvP7vBTEwlvsSQnWKZIo8D6wAIV7CG4y/QvzXNeCyYI7Mb70Y2aFovAtg+4RjGH00uPR6ZdBA9P6nsI/OMjMZ27c8mkPb1sRmv2AYVaYUM3kIsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=IdGdpJp9; arc=fail smtp.client-ip=52.101.83.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FA+wJjHFYsmqlLAZPa4S3cwK5Cw/2J6YbEVmZlwcfOXc8N8W3SvQI1npyVXQOxx2ke3Su7foEHDrobAzPEpsE2Pr4Hjn5kAeG/2hEdZuHuUqgLtk44uQcTGzYb85/1h+7Gl59QOo2PHpYSTmHlRELSbSKs/B09S4EVjuPNRVCW23x2AxoSNcvJbE5CMRS9r5aD49yWchBkexEVHTvphcrtQQWCoFxc3Senglzr2IWeUSoeNSOX90pJg7BTr0EA5/U6ckHnY+Mks3Y/s5Ee8KxXo22zGc6GL4XkLZnup/eOp4edYs+fyXheTqEppnu41MHQfV9lOfS+G2Snjji1hr2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oVUfIFlOA1xMvmAC30NjxpA2yFB7Wv0pfIeoUwLfYk=;
 b=QVmka2AVUNktGeRrHUjblALQdIAPXkzeRVGtnglWTslsodrktKB5cwRAR1HHO/Tz6MjzlONgapNO37Ao98dTA41gTMqB5xs8V7q1RWU/VksFGLbwCN5AIF0YhD1owPkGLy3uOroWwcsom+IrYdFUgMtISGg/DB6Oyv7UUtp8YjzzLCUBAcIhoLFzcc7/RP7R89b+cnBWuQl7JUhsE/bxKBUDWyo45zrx+z9jOATOLrDUI4nFJTcqntjRFnfpKuu4KW/ffpK0C7RattFbpHlPET3NeoJ2GOxpj/ak/YxEqSPZr5TVPYJcAuHKmUSDQNukObnAkmG0bjEWFNTv7RYtLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oVUfIFlOA1xMvmAC30NjxpA2yFB7Wv0pfIeoUwLfYk=;
 b=IdGdpJp9Fhi1EB5iUnyBFcAvqUNLUuOC987g3XRw5KQlpyYuQm9a4K9kKx2miQtODcncAAJD/1q9b0l2UnVAt6Fx0i228giUpMxUHY9atjFh05l88odtJwO0n/LRrRBfwkNR3/v3b2tV6+t6Rr9ZPfiNhuTdLwbV7T+jNOnQbgnayaT0MrlV+rOR6lLmsNV86PYyoVYOa9WTOFSgDoxNNwDMreI7++K0pKv2ame0D7oMNnERiKIy23JOFc/WXB6bI78hypI1s4eYTxgfoclsCM34zsL980l99PuVZvdSZwgA/eY5LTZbrINCTK/GuGKboP4eub44s7yt4WINFUd0Dw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by VI1PR10MB3471.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 08:03:07 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 08:03:07 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "daniel@makrotopia.org" <daniel@makrotopia.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "robh@kernel.org" <robh@kernel.org>, "lxu@maxlinear.com"
	<lxu@maxlinear.com>, "john@phrozen.org" <john@phrozen.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "yweng@maxlinear.com"
	<yweng@maxlinear.com>, "bxu@maxlinear.com" <bxu@maxlinear.com>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"fchan@maxlinear.com" <fchan@maxlinear.com>, "ajayaraman@maxlinear.com"
	<ajayaraman@maxlinear.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"hauke@hauke-m.de" <hauke@hauke-m.de>, "horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "jpovazanec@maxlinear.com"
	<jpovazanec@maxlinear.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v7 12/12] net: dsa: add driver for MaxLinear
 GSW1xx switch family
Thread-Topic: [PATCH net-next v7 12/12] net: dsa: add driver for MaxLinear
 GSW1xx switch family
Thread-Index: AQHcTLxDDivhhsZUI0Sg1sdKzKnvuLTiKW4A
Date: Tue, 4 Nov 2025 08:03:07 +0000
Message-ID: <8f36e6218221bb9dad6aabe4989ee4fc279581ce.camel@siemens.com>
References: <cover.1762170107.git.daniel@makrotopia.org>
	 <b567ec1b4beb08fd37abf18b280c56d5d8253c26.1762170107.git.daniel@makrotopia.org>
In-Reply-To:
 <b567ec1b4beb08fd37abf18b280c56d5d8253c26.1762170107.git.daniel@makrotopia.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|VI1PR10MB3471:EE_
x-ms-office365-filtering-correlation-id: 38f48c0e-468d-40a7-b781-08de1b7896c9
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cHFrQ0doRUdyRTltNUFobkVLd0xpWUxBT0xnWGFjYUVtbWxjUE9aQzBqalNs?=
 =?utf-8?B?NWo5V0lEQnNkQ1h0TkRvRTRWVlRBcDFwY1RTbExBbzlEUFFvNTJDWFIvdFVF?=
 =?utf-8?B?RzVoMDhvZXNqVXRLVmRhdjJMbkQyeCs1YU9oNHNRS3dicmk3N3RIWGd0bTNo?=
 =?utf-8?B?S2xlZ3V4OTNDanp5QkthVmNuRXRZVVJFNGZPR0hWVWxxMEpWVXl5SlhPR3Bj?=
 =?utf-8?B?dk83TkZNaXBPdllvN2REYSt5NW4vL0F6aGU3ZjBqZHVDaHFKNFlsUXRMTERM?=
 =?utf-8?B?bkNoQ3RROHBGWmcrellBYSsvdTA4SERiNzBleHVpQnB6YjlaRTBhQTFHbzdS?=
 =?utf-8?B?Ly9jVXlYd3RqRTdyWTErOXpkcU45OXRtK24vT1VkNjNueWNnSHJRRk84Skk1?=
 =?utf-8?B?bHZHWTl3Wko5VGJQNWh5Wld0clloWXZWRXJXbkFnaGxMNHRpK1pjOXY3ek4r?=
 =?utf-8?B?RUVESVcyQTR5bmtrOUUrSHdiVUpqYks5ck1ZL2lPaEw3VU91cjE1N214eGRj?=
 =?utf-8?B?RWN6azBua3Z1SThGRTliaXZPRkl4SU1rRWJSTVVEU1BvYUREWTlwOXU2eUdR?=
 =?utf-8?B?a3Y4VXR3eTgxQVh5Z1JWcGF3Q1RHN0hudmRHd3IyZVJkUlVmVklZRXAvNjlo?=
 =?utf-8?B?Wm9uanAyYmRsbGFGc3pkM3ZKbUw0T1NRTlczWXB1bThESzlISVhpMWFWSjdn?=
 =?utf-8?B?bFBhUzJmekY0aHlTMmcyM3JXZUM2Mzd6YUlXSExzQkpKS3JRK0NIRlZCc1Va?=
 =?utf-8?B?SndiR1VkeGxxOFQwN0cvMGpSRFZneDE1OUlOWXBmMXl2WkhlVndpUW1uaHNQ?=
 =?utf-8?B?RUVuZ0V4MnhGeXdGeG5YSkt5dHREZ2RKK0hsYlBjSDRwWjRIMzkzTUVaYUNo?=
 =?utf-8?B?RG1JVEkvQXd6Q2xMZmp3WnRvbmZ5eG9CRkpkUE9wVE91ejhjcVdITGRJblpQ?=
 =?utf-8?B?NzRWbE1rSm1BZndySGdvbS9sWFNreVpxdzdqK25qVjAzQ2JxcnVlNmo4VlNj?=
 =?utf-8?B?QlZxbVNuUWM1N1dNQ2RjdEJWazNReG9Uc3hyVXZVZ29sR0poOUZNS3ZoY1Ji?=
 =?utf-8?B?c2o0TlBWQ0Jqekp3MGsremt0Q0dmbjVPSmNSaThhMy9sK1hTNmpVR1ZYcVRV?=
 =?utf-8?B?eXN5Vjh0cFI4SHZuNzZKMzFFeklaQVdBQ0VlL1BKRDdmbUhSYVhxRTRaOUU1?=
 =?utf-8?B?RExYV0diZjVtUnVVeHpiU1FFTTBUZ1RBYk9vZlJia2sySU9WalJKSi9PV09y?=
 =?utf-8?B?MzJtVDJZd3RzT3EyclNCK0ZpaFZSQ1BKSCsyazJqQUFmWExrYlhDR0ErZFlC?=
 =?utf-8?B?TWpwamQwQVExbnV2WmVvNk1pVlZWNVVJREZwMkQxa1Q4SzA5L3dZQUxGTkhM?=
 =?utf-8?B?NXZ0U2liQnZ2UGRIRUNTb0p3SjQ0YTNENEtTeWg4eVRDUm50dXJIcnJvLzUx?=
 =?utf-8?B?a1ovK0ZFQlE3aG5DenJQQUFDSkJJd0V0aGJHNXUxdTYzT3Q4T2dUZTVIdDlK?=
 =?utf-8?B?YVdZWDM2NXVrdndiUmpVN2xZek5Sb2t2TjBZa01jTkkySXA4eEpyWW1Cb2p4?=
 =?utf-8?B?ekRBOHNmdytoTGZYZi81Q1ZTNjRUR1pEZU42bStXbS81NmEwRTlvZWZaVEZn?=
 =?utf-8?B?NVdEYndNRnR5THd5WTYyazBRQzlUTXAvRndjYlNMOS9FbjAvWk03M1l0cTlq?=
 =?utf-8?B?eFg2cDcyYVhGYkpKU1k0S042ZmVCWlRpRWRuck5LSkhIRXIyT3dURlpnQW1T?=
 =?utf-8?B?bmoweE14OEZXU0x2aWhyUDBSMTU1Vms5azA5SzZ5SGNVYWxSRWJ5TkdyMEFZ?=
 =?utf-8?B?SDdlYVhnUDJIMUZNTlI3Y3NMdUFwa2dMYUsrMDAraXdUMnlNajVycTI1clQ3?=
 =?utf-8?B?SmdoMGNmeTFOdnpMcU4yT2pGanZzRTRwYXhlT1pia1dpdlVaWDVMSXl6d2Np?=
 =?utf-8?B?UnhMaDdSUXlQclI2NkZBbjhEeHVXenNrOGx3bEloS0VSQjM0Zm1kbkVGU1h4?=
 =?utf-8?B?bWVCbEUwdkhnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bi9JOVZSSzZEWHBxd0FQTE1Pem5xL09oK24yeEZVT2VzRkVldGdsSnRmT0JY?=
 =?utf-8?B?bFVjWXRYQTVFM2kwRTZ6NEJiYzVMaUR5STVSK0dJQnA5QVV4dTZSSS9ZK2VW?=
 =?utf-8?B?UVRDbnZqQmRmTW1pdFU3bEhHWHk1eGgyR1prK0tsWWQ4ZVkzZE5yUWIxUStl?=
 =?utf-8?B?NzVOTUNDSEFUNjRqSTY2bThHRE4rWnYrY2dQRnZ1MEtROFZqRjdLbHZrc3RG?=
 =?utf-8?B?VUZ0N3R5dFJjdTludmNEeFhEWTZmMkR3eWR5MFlBN1lpS3ZkLzFnZVVEaExN?=
 =?utf-8?B?Q0dIekk2czJlaExaMXBUSkJ1aGpTQUR3QTdjU3dKTXJiRFNCMjEzQmZwNUtl?=
 =?utf-8?B?S2FkQTNEc2NoQlE4V2pvQ29jWThGUW9KSGZ5NlF1eEFtVm1IVThtV3pwOE01?=
 =?utf-8?B?ZHZpUmh0Rm5ZY29hVFdHdzA0NGZ5MkdKUUFyZlNzQWhIYk0xdDd2RzI3cW5n?=
 =?utf-8?B?SGlrNlNKVHl3WlBaeW1Ca3ZSdG5vT09YVXZCTXVRRURNcVZVdTlzb1MxaWFn?=
 =?utf-8?B?ZWtqMWpiWVpkMWRRTWgzUm1ZeWpMVlJrVmtCSXZzam1HVkViMXh5eWg1emQw?=
 =?utf-8?B?TUNhd2hNdkZ1amM3SWFpR1llRXh0UjJmeW5LODVkbllTcjR1Q1cxMUFXTm5Y?=
 =?utf-8?B?V3hFV3FhWmRkbUVsdC9hNXNyYk1FNEZTdXhpSFgvYkpNQzRQcTI4T0lwYVdH?=
 =?utf-8?B?U0dYY3VYTEdxTDBKUVpaNWRXbWZDNWIzQ2g4UzRUTGVvZ29vc0phRVBGa05N?=
 =?utf-8?B?TXpoMVlDcGdhU1dkcWNhdXd2dzRCdytFRnFnY3BwNGZNY2RoRzVLdG1uNnJq?=
 =?utf-8?B?eHV2ZTRnTDZOMTFSb0ZWN3dRWVR4dEo0YmwvaWN6dU83N3g1OVp6dEVNWExl?=
 =?utf-8?B?VW1EUVVaR2hDVElPcDRJMlVicndJRHpoMmlLOTBKL2ZUYm4rVFJQR2NNalBl?=
 =?utf-8?B?TE4vRHpVWVhKYWZZMzlIOFhvUG4vVG5mOXl3K2QzS01DL0VRUHd5eEhGRHNz?=
 =?utf-8?B?WFRQeFlLYlg0QWJvbFowYzJnckwxSDRyWFpWODY2S0lxMGVvZkhoaXk3cTc1?=
 =?utf-8?B?Umd3R3FydnJiSUpEdThLaHQwUUpONFVUM3ZHMDF1R1NVVTZWS3hBWjRlc0dn?=
 =?utf-8?B?SkpLMDkxcmxQWFVlc05sb0NRb0ZmTHNUWDQyQ3dteVlWUklySk4xZ0RpUEti?=
 =?utf-8?B?cHJxS1BzeWUrcEowTUF0NGVnT0ZxRnd1VEI5MmIxOHpsdThvZlRSME1LYnhX?=
 =?utf-8?B?TS91U1BkRDgrUXI3OGIwU3lQN05IK0ZSVUNSY2JXd0tyK2hRZlc4dkZxMytJ?=
 =?utf-8?B?WUE0T1hLMyt4eEJxUkxwbzZhNXREdmJVZEx2MnZFdTJwRlV1OHZ6Tm8rUlEw?=
 =?utf-8?B?TGxDOE5PVGF2V2Rma1FiZlVEUTFhdDdGaDR3eTlyMjFhUjd0bWc5MFF1bWNm?=
 =?utf-8?B?U3BRc0xNb3J6Uk41b3JlbGdVQWcrbHZsQXZzTEZ1R3ArTm55ait6a3FMN1dp?=
 =?utf-8?B?ci9NMmtFWmNhVVVkbjdzSFBhQ1VzWXFNblVvLzBXVm1lVWdmT2lsMitWNDJi?=
 =?utf-8?B?bU9mYWZJOFVHVkJzVU5hcEZ1dnJrcG5KSDFSUSs1RFg1SXcxMU54ZXcyRmxV?=
 =?utf-8?B?ZnB3QTNtRmtLN3gxaUdKWFVWWlFQN01EQW1EZkRadjVwMUxmZk9qTXlpOHVo?=
 =?utf-8?B?UDJEYlV5c25JeHFvZkdhWjkzY2FMWEtFajBvdHNoQ2xENHQ4L0s3YUZrSUNO?=
 =?utf-8?B?WWFMeFVpV2JQb0VRYXpjYVQ4TVpEeHFPRFQ4dUJSV09CcCtPMmxQTzRhZUpZ?=
 =?utf-8?B?VXl6WlpLM0FqTCtDejRHeW40QmcyN0JiUnVqWFN3UklYZHFMUUJrQTkzT2pY?=
 =?utf-8?B?bys0L3J3N2oyYlNER1MzMUh4TE5JMnIxblpNcUtpaG5TVHBoMnFrdXFlei9r?=
 =?utf-8?B?ZGhtQjcxN2N5YVZEWkhJVHo5c1l1RlBSeUwzM3RydGJTNnZjQ2RMeE9CTjNn?=
 =?utf-8?B?d3J0ZEp1UndyVVhiZ3JNR2JYYkQrSktyZDVKclVtOU0xMTVueVdnbVBBcHN3?=
 =?utf-8?B?WjdkUGx0OFRZQ2RXMkpWczg1ZVZxcTVaZ0xIUU9KL2dzay9Lbk5kYXF6aHdB?=
 =?utf-8?B?azJlS0VpVEozUnBjVjcvcVdlaG9XMWFySWpQVFlYYTJxVWVjZXY1dnIzc1RS?=
 =?utf-8?Q?wC9mcaHkKSDhNlE9QeOALW0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25450CC7CEB1924C93DA5D878395C5BA@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f48c0e-468d-40a7-b781-08de1b7896c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 08:03:07.2060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9y0Y35uLJy3wrNZT6lnMWGUoNM/6To/l15ipDLNvHcp1IfjM7V0CVttXB/XFnIcPZu0puWWRMreYvuYgcqmaLMqgLxEPqhs5PeRuZYoEQ0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3471

SGkgRGFuaWVsLA0KDQpPbiBNb24sIDIwMjUtMTEtMDMgYXQgMTI6MjAgKzAwMDAsIERhbmllbCBH
b2xsZSB3cm90ZToNCj4gQWRkIGRyaXZlciBmb3IgdGhlIE1heExpbmVhciBHU1cxeHggZmFtaWx5
IG9mIEV0aGVybmV0IHN3aXRjaCBJQ3Mgd2hpY2gNCj4gYXJlIGJhc2VkIG9uIHRoZSBzYW1lIElQ
IGFzIHRoZSBMYW50aXEvSW50ZWwgR1NXSVAgZm91bmQgaW4gdGhlIExhbnRpcSBWUjkNCj4gYW5k
IEludGVsIEdSWCBNSVBTIHJvdXRlciBTb0NzLiBUaGUgbWFpbiBkaWZmZXJlbmNlIGlzIHRoYXQg
aW5zdGVhZCBvZg0KPiB1c2luZyBtZW1vcnktbWFwcGVkIEkvTyB0byBjb21tdW5pY2F0ZSB3aXRo
IHRoZSBob3N0IENQVSB0aGVzZSBJQ3MgYXJlDQo+IGNvbm5lY3RlZCB2aWEgTURJTyAob3IgU1BJ
LCB3aGljaCBpc24ndCBzdXBwb3J0ZWQgYnkgdGhpcyBkcml2ZXIpLg0KPiBJbXBsZW1lbnQgdGhl
IHJlZ21hcCBBUEkgdG8gYWNjZXNzIHRoZSBzd2l0Y2ggcmVnaXN0ZXJzIG92ZXIgTURJTyB0byBh
bGxvdw0KPiByZXVzaW5nIGxhbnRpcV9nc3dpcF9jb21tb24gZm9yIGFsbCBjb3JlIGZ1bmN0aW9u
YWxpdHkuDQo+IA0KPiBUaGUgR1NXMXh4IGFsc28gY29tZXMgd2l0aCBhIFNlckRlcyBwb3J0IGNh
cGFibGUgb2YgMTAwMEJhc2UtWCwgU0dNSUkgYW5kDQo+IDI1MDBCYXNlLVgsIHdoaWNoIGNhbiBl
aXRoZXIgYmUgdXNlZCB0byBjb25uZWN0IGFuIGV4dGVybmFsIFBIWSBvciBTRlANCj4gY2FnZSwg
b3IgYXMgdGhlIENQVSBwb3J0LiBTdXBwb3J0IGZvciB0aGUgU2VyRGVzIGludGVyZmFjZSBpcyBp
bXBsZW1lbnRlZA0KPiBpbiB0aGlzIGRyaXZlciB1c2luZyB0aGUgcGh5bGlua19wY3MgaW50ZXJm
YWNlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEdvbGxlIDxkYW5pZWxAbWFrcm90b3Bp
YS5vcmc+DQoNCnRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoIQ0KDQpGaW5hbGx5IEkgd2FzIGFibGUg
dG8gcnVuIHNlbGZ0ZXN0L2RyaXZlcnMvbmV0L2RzYS9sb2NhbF90ZXJtaW5hdGlvbi5zaA0Kd2l0
aCBvbmx5IDIgdW5leHBlY3RlZCBmYWlsdXJlcyBvbiBhIEdTVzE0NSBoYXJkd2FyZSAod2l0aCBU
SSBBTTYyDQpob3N0IENQVSBhbmQgaXRzIENQU1cgKG5vdCBpbiBzd2l0Y2hkZXYgbW9kZSkgYXMg
Q1BVIGludGVyZmFjZSkuDQoNClRoZSBwcm9ibGVtcyBJIGhhZCBpbiB0aGUgcGFzdCB3ZXJlIG5l
aXRoZXIgcmVsYXRlZCB0byB0aGUgR1NXMTQ1IGNvZGUsDQpub3IgdG8gYW02NS1jcHN3LW51c3Ms
IGJ1dCB0byB0aGUgdGVzdCBpdHNlbGY6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAy
NTExMDQwNjE3MjMuNDgzMzAxLTEtYWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tLw0KDQpU
aGUgcmVtYWluaW5nIGZhaWxpbmcgdGVzdCBjYXNlcyBhcmU6DQpURVNUOiBWTEFOIG92ZXIgdmxh
bl9maWx0ZXJpbmc9MSBicmlkZ2VkIHBvcnQ6IFVuaWNhc3QgSVB2NCB0byB1bmtub3duIE1BQyBh
ZGRyZXNzICAgW0ZBSUxdDQogICAgICAgIHJlY2VwdGlvbiBzdWNjZWVkZWQsIGJ1dCBzaG91bGQg
aGF2ZSBmYWlsZWQNClRFU1Q6IFZMQU4gb3ZlciB2bGFuX2ZpbHRlcmluZz0xIGJyaWRnZWQgcG9y
dDogVW5pY2FzdCBJUHY0IHRvIHVua25vd24gTUFDIGFkZHJlc3MsIGFsbG11bHRpICAgW0ZBSUxd
DQogICAgICAgIHJlY2VwdGlvbiBzdWNjZWVkZWQsIGJ1dCBzaG91bGQgaGF2ZSBmYWlsZWQNCg0K
U28gZmFyIEkgZGlkbid0IG5vdGljZSBhbnkgcHJvYmxlbXMgd2l0aCB1bnRhZ2dlZCByZWFkLXdv
cmQgSVAgdHJhZmZpYyBvdmVyDQpHU1cxNDUgcG9ydHMuDQoNCkRvIHlvdSBoYXZlIGEgc3VnZ2Vz
dGlvbiB3aGF0IGNvdWxkIEkgY2hlY2sgZnVydGhlciByZWdhcmRpbmcgdGhlIGZhaWxpbmcNCnRl
c3QgY2FzZXM/IEFzIEkgdW5kZXJzdG9vZCwgYWxsIG9mIHRoZW0gcGFzcyBvbiB5b3VyIHNpZGU/
DQoNCj4gLS0tDQo+IHY3OiBubyBjaGFuZ2VzDQo+IA0KPiB2Njogbm8gY2hhbmdlcw0KPiANCj4g
djU6IG5vIGNoYW5nZXMNCj4gDQo+IHY0Og0KPiAgKiBicmVhayBvdXQgUENTIHJlc2V0IGludG8g
ZGVkaWNhdGVkIGZ1bmN0aW9uDQo+ICAqIGRyb3AgaGFja3kgc3VwcG9ydCBmb3IgcmV2ZXJzZS1T
R01JSQ0KPiAgKiByZW1vdmUgYWdhaW4gdGhlIGN1c3RvbSBwcm9wZXJ0aWVzIGZvciBUWCBhbmQg
UlggaW52ZXJ0ZWQgU2VyRGVzDQo+ICAgIFBDUyBpbiBmYXZvciBvZiB3YWl0aW5nIGZvciBnZW5l
cmljIHByb3BlcnRpZXMgdG8gbGFuZA0KPiANCj4gdjM6DQo+ICAqIGF2b2lkIGRpc3J1cHRpbmcg
bGluayB3aGVuIGNhbGxpbmcgLnBjc19jb25maWcoKQ0KPiAgKiBzb3J0IGZ1bmN0aW9ucyBhbmQg
cGh5bGlua19wY3Nfb3BzIGluc3RhbmNlIGluIHNhbWUgb3JkZXIgYXMNCj4gICAgc3RydWN0IGRl
ZmluaXRpb24NCj4gICogYWx3YXlzIHNldCBib290c3RyYXAgb3ZlcnJpZGUgYml0cyBhbmQgYWRk
IGV4cGxhbmF0b3J5IGNvbW1lbnQNCj4gICogbW92ZSBkZWZpbml0aW9ucyB0byBzZXBhcmF0ZSBo
ZWFkZXIgZmlsZQ0KPiAgKiBhZGQgY3VzdG9tIHByb3BlcnRpZXMgZm9yIFRYIGFuZCBSWCBpbnZl
cnRlZCBkYXRhIG9uIHRoZSBTZXJEZXMNCj4gICAgaW50ZXJmYWNlDQo+IA0KPiB2MjogcmVtb3Zl
IGxlZnQtb3ZlcnMgb2YgNGsgVkxBTiBzdXBwb3J0ICh3aWxsIGJlIGFkZGVkIGluIGZ1dHVyZSkN
Cj4gDQo+IHNpbmNlIFJGQzogbm8gY2hhbmdlcw0KPiANCj4gIGRyaXZlcnMvbmV0L2RzYS9sYW50
aXEvS2NvbmZpZyAgICAgICAgICB8ICAxMiArDQo+ICBkcml2ZXJzL25ldC9kc2EvbGFudGlxL01h
a2VmaWxlICAgICAgICAgfCAgIDEgKw0KPiAgZHJpdmVycy9uZXQvZHNhL2xhbnRpcS9sYW50aXFf
Z3N3aXAuaCAgIHwgICAxICsNCj4gIGRyaXZlcnMvbmV0L2RzYS9sYW50aXEvbXhsLWdzdzF4eC5j
ICAgICB8IDczMyArKysrKysrKysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvbmV0L2RzYS9s
YW50aXEvbXhsLWdzdzF4eC5oICAgICB8IDEyNiArKysrDQo+ICBkcml2ZXJzL25ldC9kc2EvbGFu
dGlxL214bC1nc3cxeHhfcGNlLmggfCAxNTQgKysrKysNCj4gIDYgZmlsZXMgY2hhbmdlZCwgMTAy
NyBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvZHNhL2xh
bnRpcS9teGwtZ3N3MXh4LmMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC9kc2Ev
bGFudGlxL214bC1nc3cxeHguaA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L2Rz
YS9sYW50aXEvbXhsLWdzdzF4eF9wY2UuaA0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2ll
bWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=

