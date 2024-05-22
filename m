Return-Path: <netdev+bounces-97501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E97218CBBF8
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 09:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56ABDB217DE
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 07:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AD07D08D;
	Wed, 22 May 2024 07:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LTwGILsl"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2072.outbound.protection.outlook.com [40.107.7.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979F17D06E;
	Wed, 22 May 2024 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716362888; cv=fail; b=XRsjetr6/XLG42SPXLdlbGal8XJY1xK9dhXs94p1FVarib+saSMK32H5pgbZcQywU738KBEUtTqViwhmVO7n+Ghu1VbXYCEZdIDi+1e2GETxoyZ+r8EHlLMRrUruxrcYfsmMmtyl/IOqxvR//SswwC2ueHl2vC5w6eojApP6Mc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716362888; c=relaxed/simple;
	bh=6if8QkYP42EAuKlNULnUyYXrvx1eiEgnX67KnoQq4VA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hhHb8xvPXayewthqCNdY4VnJHEpZxyXhP6ONmfngAo0q6SxrExpLfD44Y4YzWXOQzcfrzyjrEmsOYrJv4UUlonr8CRnjtbGA5PRAVruXE/ePY5BTG5cQDHceef9Ivy9b27BNkb4UimYKhaBC70pVPm0wahP9RxdWxKFj42YK6ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=LTwGILsl; arc=fail smtp.client-ip=40.107.7.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvHairbI/wKfuSudA5zdfSy/YB6cayuOSvV/T+Vy6SoKOVaZ89qXdVvf88lmXQgYDRQRa3s5ZBuo0gwgmHzc+ie/gdAHnLRJFlEW7QdH+iXQbYOWO7WeTtMpEzfc5uaIR3ND9XJl4wwkdi4tNBXhimWMKZlgk6i+qoO/1S7aj1QY8cVHjL5DPf+NY6OZOl05IwyhLu5De/8fsR1q0UlV5YveekfW4Kw21wizOl9yfhiNi1mmr3UwuGDeq+NweAdF5o7OzeYsPaGtjYJlZqIERJVQ1UiVLTXhhfih3D181IWfKrPYFiQnGDVMuhro8/sObS5DDGO6ZxPcBA9xERgg1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6if8QkYP42EAuKlNULnUyYXrvx1eiEgnX67KnoQq4VA=;
 b=AxjvdcmuZu2HB1oJn0/ZSSWLEDCmwFVYBz7/pck+sfFc1PR65aEuZW/utxvR9vO3t1NN5cOMSSEXwhpO4zQHPb4D0FWuj/Pep4VJayoVq9ldmCEcYT/T7gwN+yJt8XSdSXGDRAAwHDrYb2xzJP92PqLJSLX0MIv7siE31X5p4Le8tynGRQHdGszAzlbbGvRFspakLXaxvU05grA9gtxawN7d6AAIBsILX3zFXekuQXr0dGrbgDPxC/3jEQHsvjv0CJstacMPYgt5ztg04GuG+n9xOotxfBGJLpuhwSSc+vcAmp9Dg4tm9vDklHrHzi8F/FM8ppE25forRi4LveU7jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6if8QkYP42EAuKlNULnUyYXrvx1eiEgnX67KnoQq4VA=;
 b=LTwGILsluFOZ1X88IPIrwrEqmEmVwOaeLC194bnkmp9UhJP7GsgX1qBxoJYgyGVbO74wmIvKqOpmu7Xjgt9xwv390dgfgSDC0gIYnS5a3vDKyQQ7lFs2YEtpbiiJIWVc8mqWAd+nnLzJrNpSO4FOBa7/7DjhxIrLUG1hP4MsIho=
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB7608.eurprd04.prod.outlook.com (2603:10a6:20b:293::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 07:28:03 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::baed:1f6d:59b4:957]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::baed:1f6d:59b4:957%5]) with mapi id 15.20.7587.028; Wed, 22 May 2024
 07:28:03 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>, Xiaolei Wang <xiaolei.wang@windriver.com>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [net PATCH] net: fec: free fec queue when fec_enet_mii_init()
 fails
Thread-Topic: [net PATCH] net: fec: free fec queue when fec_enet_mii_init()
 fails
Thread-Index: AQHaq+22vnaNT3PSDE643JvjIPXkobGiiaOggAAK4ICAAEYVQA==
Date: Wed, 22 May 2024 07:28:02 +0000
Message-ID:
 <PAXPR04MB85100FA1D553CE1E8523269088EB2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240522021317.1113689-1-xiaolei.wang@windriver.com>
 <PAXPR04MB8510B1D6C8B77D7E154CC6CF88EB2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <8bbf2c1d-5083-4321-bded-f83aba5428fa@lunn.ch>
In-Reply-To: <8bbf2c1d-5083-4321-bded-f83aba5428fa@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB7608:EE_
x-ms-office365-filtering-correlation-id: c35650bf-4b0a-4387-ff2f-08dc7a30b743
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?gb2312?B?VThzR1JpbExNZDFUM0c0ZFp2VUpzQmRjaFcrL2wrRy9PMjlRdUZxRXhMRUlC?=
 =?gb2312?B?NTAyU1dtSTZPWnJoS3Q0ZElrc1BoQXd3VVovS0FvTEFqeCtBZys5c0IvREl0?=
 =?gb2312?B?OWEyZkg1Mk5UUzlLaUlVRjQ2aHlrV1JhVEdhcktiV041Z1hCWnJiZ2IvcnFs?=
 =?gb2312?B?OENxbGhsczFVRGt1VmdrV0JqUWJrdmREamNmQXBSbWhxVzNqZ2pVUEV3U2s0?=
 =?gb2312?B?SmhoS1FBNzdFM0d0TG9ZTGdMcXRzRmpqTzB5UFprNll2VzR6VE01RjlwNFhl?=
 =?gb2312?B?TnJjZkJzM3dpY3cyK2FndHJIdm8zVEVMNXl0dERDOS9ZL1c0ZHUyM1JWcnU2?=
 =?gb2312?B?Qjd3akVxdVQ1cTV0V1BJNkk3T0tOcFFQWklLRzkxRk0zY2crUG5oZmVldDB3?=
 =?gb2312?B?bUJlR2NKaTN0WUloN1hzQUdPblREVVRWRmFkYkNJZXM0cVlRZmYrVDdRMk40?=
 =?gb2312?B?MS9xdTBuVEx1cGY4clJOWXBxaWJrOHg0eG04SHRSdXFGR0pzZDY5UTVpZXNo?=
 =?gb2312?B?MFg0ZVFQL1FxQmlUSVM1SFFVRTVPSk40SS9YMnpXaVlteEd5MTdpS09wZUJB?=
 =?gb2312?B?V095M1k2VHEyall6V0UxbWhsL1FFc2NuOG9FZU1KT1F1MTYxOTNhR1JZdWtv?=
 =?gb2312?B?ZkNpTUc4a0V0UkVQOENHZVlQQ2NnbXpnd1gwYmFTZy9TYThRQXhqaVdRZ05j?=
 =?gb2312?B?UVFEb2c2MHBrTFpPTkhIYStYdWdPRlhYMUhzbkNHeG84bjhGMnNyMnl6Q0ll?=
 =?gb2312?B?ZCtlQUxVTjU3ajBpcUxtQ0xNbnB4bmIvUDBxMEVNT3dvaG00eUJ4anllWEg4?=
 =?gb2312?B?K3R4RmZVZjlVL1NIWGFHb3ZUNnltNHVNMzYzSVVUaXNFWEZJK2ppejVSaGto?=
 =?gb2312?B?cXBQN1o3S1NpQ0Vlb054djN5c04zcVFULzdhTWVhYmlzeG5PLzdCZ3ovNTIr?=
 =?gb2312?B?V3V0eCtJeWdyRGE2WkZ1cFAzREgwd3hRYmdRTzVjRFVpd3NIMzl6VjN6Y0Rw?=
 =?gb2312?B?UWNQK3ZvYm5HejkrcDRkR0w0UFdSRjI4LzZKYlZTa3NVMlozTlVvWGtKd3lw?=
 =?gb2312?B?aWtRdEtsWmxGMVVWelpQK3lrL0pocUNLdEJwM1gxSlJtbnFjVWRYaEtmNVpu?=
 =?gb2312?B?STdpWElmQy9YdWlGVmpKVDBROG5EMGRHZG1zNDdORVp6Njhvb1UzT3Rpazlx?=
 =?gb2312?B?RXRoa2RTa1VPL0VUQlVNZCtsZjdNcGtnNlJPRHEyaVZubWlvZms2cDJ0MFZK?=
 =?gb2312?B?aTNyUUlaWWlnRWZCdmVreU9LM0pCTWRRWjhpNHhDTkozTmViY1c1SFVqbzRo?=
 =?gb2312?B?anNMZlZPWTZKM3pGNzFVOGZud0plOG5XcjNGaU9Fek5KQi9NL1ZWSUZRNE9L?=
 =?gb2312?B?STBrUENEMWVHNk5lUUJxT2RMaTR0T2ttdThxYmtqVk5oOFFxd2hqbFZOWk1X?=
 =?gb2312?B?UkdXY2RoRHlzUWdEVk9kaUErbGszYy9mbGhYTEVmTFNaRnp5U3lGTTlyWnpC?=
 =?gb2312?B?T3VOMEhUTzNiYk5Zdk1nMEZjMzZUNi9IV1VTZ2EyT1BldUN6UTR4TTRmRzRm?=
 =?gb2312?B?cjFka01FaFJyaCswRFcybS9Ncy9VUGFlM1Axd1JOcXhmT24vVE45ODRKT0N4?=
 =?gb2312?B?NEl6emoyMU9OSEQrdTdyME5CLysyMXRpWWJKSFZvaE5Ec2JVUmhvc1B3UExW?=
 =?gb2312?B?a3hyQlRjbmo0UHQzVVJyMGRrdEtiNStlQnhwL29BR1ZZbjluMzR3ZG5FMm4z?=
 =?gb2312?B?T2xKaTdvTzZvUlB1ZjIrSlpqSC8zWnJjK05FU1VtTDlKZUEvVE1QSlNSUnVR?=
 =?gb2312?B?azIwa1p3aXJNQ2Z2MGMxQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?RWhnV2pFcmpWeUo0bEZkL051ZDdINENQLytSZHpiclpZV0ZKdjRudlhhUGFj?=
 =?gb2312?B?cU93TWhLWXZpS3hYSGhjWjVyRWdVRUxwQlZBanZsMVBpaVFDVWdGK3hTdCtj?=
 =?gb2312?B?QnBrTzFZckphSzR5Y3BWZkFOaW5aY2JSZzZmREFUQ3FTRG1DYlNPb2NRNmY1?=
 =?gb2312?B?VmdpaXpDVHJKbFp2dC9jaDZMQ1MzdzVFNlNUQzgrdUNRMWVmUEF0eDZkZStM?=
 =?gb2312?B?RjBBWm5NWWFPcHJDbGV6OUZNaXhrOUN3cXl0eS9YTVZIT0c1ZjdxYVdaOEIv?=
 =?gb2312?B?c1hhYWh2U1FlemhpOGhYRGswTTJ4WnRpdkZ6cGpvTWVZSGRJNDkxcFZYOXR1?=
 =?gb2312?B?SHRiQ3UzZTJCWlkvV1lmUTFxMzYyRmExWHZtY0U2Vm1jeXNLcEZocHRockJB?=
 =?gb2312?B?aEFDa2ZteGF3amlTdFpmNThXOVR0UktjZkFSb0M3NG5OeWZoSEpuY3JDa3Z4?=
 =?gb2312?B?N0dwSGIzNnl3R2pFMjk5VkhTNjJMUEhZMlJpZG9kOVJEL3lUUzNwcHBBVGhG?=
 =?gb2312?B?dlBSSmF0OG50eDd0NHowWU5VQTVUQWRmZFFwRTczVXBoTGs2a3E0TWp6R3lm?=
 =?gb2312?B?bENOWTRmN0JnTnNFanROZ0pRbU5McVN1U3N2OElMWS9DOUhDS1hYYjlsRUVk?=
 =?gb2312?B?QXBqOE8xcC84bXRDR3BxSm5GMmdtSWVtS2pYcFlIOGk1Ump5cHc2VjlFTE5G?=
 =?gb2312?B?bHNhblR1RUNrbnRtTXprbEVGWWJFdUlTQ2NBZXZJbS9DcFdBWEpoOEpCQjNV?=
 =?gb2312?B?SkN6VHYvZ2dmRlhYREJtK0haQzlMVUNZZWF2NXkyL2daK1J5Q0FHQ2krM0lC?=
 =?gb2312?B?a1dlS1ZkWktuMFB6MXAzU3Y2emlEYTVvQXV1clF5N0tjT2RUMlNQbXU0Z2FM?=
 =?gb2312?B?dEsrSzBQWFBXSmZiUDEwczZibDZoNFMrZHl0Q1VVQWF6U2lxNzl4S2orMDdW?=
 =?gb2312?B?aTNDMk93SUU4d2lpRjJzK0tYN3JJOG1QUjRpYnk4N0I4c1A5VUVsSlNFNHUy?=
 =?gb2312?B?K3U1QmtDeEs5VzVNZFZneVFKWlJ0Z2hqWS9KS0tEYnMzUDRIa0JVVDJ4cXR0?=
 =?gb2312?B?NUlVUGJYbTVoaGx0bEVqOS94azJ3a3gxNUZRZDg5a2JKQ0VjSkoyS0RFWnk4?=
 =?gb2312?B?Z092Yit4Sm5UNktnYUlkUFpQdjhKS1lLdGZJR2w3Z3dqRUg2eVU4YkJNejd2?=
 =?gb2312?B?bnBqbmVnb2t4aHlxd0ZLcnh4KyttdlBEcGM5RlROZW84ckZGMnRSN3Rmdk4v?=
 =?gb2312?B?MHhHMzVqWENIRktBWjdoM2RIcUdaUWg0YlNtbkRxK0l3SnJROVJCUW50cHB1?=
 =?gb2312?B?a0dMcWVienVkSHQxZU9MWnpCRnpPWVZGbVJjN0VsQlpobURXYzVEczUvQ29O?=
 =?gb2312?B?Ti9zYm5GNG9hUXBBK2I5UEJ3MStKWGd4T0d5bFlNMm9wU2xBeXRDc2l6WjRn?=
 =?gb2312?B?azFyc3FualpSMWMxaUt1THRiYnFFVDhqaUFhTEhVZktyK3hnaWRPeERNcXF1?=
 =?gb2312?B?QkVYMUdWcFpJekVtNm1wekY0YXNHY21wMzcrRllnKzU1T280alE2K1VQV2Y1?=
 =?gb2312?B?akJ6QWpWUSsrQlZTWitla29BYTVEVy9mWHBBWThNdHpZNmJDV1NNWWtaYkhO?=
 =?gb2312?B?eGxIaHdpNTBFNVh3MXJwMU1EblRtVXNtbGxkQUJwMWZaYW9odWlNSnozbmxK?=
 =?gb2312?B?Sjlac1NQRVh5bk45b1pZYjI4dHZrVGI5NFhYY3NDdjAyQWZRMGJRdHFrV2gw?=
 =?gb2312?B?S29qSU4vdzJXTmlGcitvZXdKRUtOZHREcFpGZ0hqcWQ0RmovMkdZQVBnMU5l?=
 =?gb2312?B?d05BR2xYZnl5QWU3VHRtOEF6ajB5bFE2V1VES1M3SlR5OFBsZkRKUkc1NllF?=
 =?gb2312?B?T1FJMkpKN29ocXVDM095cDVndHhQR2VPTURLZUhrMFVWdnkwMDc2eXlHMk5j?=
 =?gb2312?B?R29QZkd3Y2RSWUUrWEtEblJTb2lKd3cxTWdTNng5anFiUVV2UjVVcmZEYUhs?=
 =?gb2312?B?ekFTVDdPZW1yYm5RTFRnWDFtR2JHaXNvNTN2T21VcWhIOWZMY0hNSkxIOFRV?=
 =?gb2312?B?N0JqS2ZERDFFaEZ3bUF1ekxMeFdnNFBKcXYwaGtHZG4rS2tnWmM2SkpINEFr?=
 =?gb2312?Q?R5io=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c35650bf-4b0a-4387-ff2f-08dc7a30b743
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 07:28:03.0873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XV6KpsaxtWeYAzq3/9nxc7xpFnYgnrWWuDnk9VXclv7FVOXloboPJU/33EH1DFw2VIBuyovB524E9cWzxaHrKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7608

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuZHJldyBMdW5uIDxhbmRy
ZXdAbHVubi5jaD4NCj4gU2VudDogMjAyNMTqNdTCMjLI1SAxMToxNQ0KPiBUbzogV2VpIEZhbmcg
PHdlaS5mYW5nQG54cC5jb20+DQo+IENjOiBYaWFvbGVpIFdhbmcgPHhpYW9sZWkud2FuZ0B3aW5k
cml2ZXIuY29tPjsgU2hlbndlaSBXYW5nDQo+IDxzaGVud2VpLndhbmdAbnhwLmNvbT47IENsYXJr
IFdhbmcgPHhpYW9uaW5nLndhbmdAbnhwLmNvbT47DQo+IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVk
dW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFiZW5pQHJlZGhhdC5jb207
IGlteEBsaXN0cy5saW51eC5kZXY7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtuZXQgUEFUQ0hdIG5ldDogZmVj
OiBmcmVlIGZlYyBxdWV1ZSB3aGVuIGZlY19lbmV0X21paV9pbml0KCkgZmFpbHMNCj4gDQo+ID4g
VGhlIGNvbW1pdCA1OWQwZjc0NjU2NDQgKCJuZXQ6IGZlYzogaW5pdCBtdWx0aSBxdWV1ZSBkYXRl
IHN0cnVjdHVyZSIpDQo+ID4gd2FzIHRoZSBmaXJzdCB0byBpbnRyb2R1Y2UgdGhpcyBpc3N1ZSwg
Y29tbWl0IDYxOWZlZTllYjEzYg0KPiA+ICgibmV0OiBmZWM6IGZpeCB0aGUgcG90ZW50aWFsIG1l
bW9yeSBsZWFrIGluIGZlY19lbmV0X2luaXQoKSAiKSBmaXhlZA0KPiA+IHRoaXMsIGJ1dCBpdCBk
b2VzIG5vdCBzZWVtIHRvIGJlIGNvbXBsZXRlbHkgZml4ZWQuDQo+IA0KPiBUaGlzIGZpeCBpcyBh
bHNvIG5vdCBncmVhdCwgYW5kIGkgd291bGQgc2F5IHRoZSBpbml0aWFsIGRlc2lnbiBpcyByZWFs
bHkgdGhlIHByb2JsZW0uDQo+IFRoZXJlIG5lZWRzIHRvIGJlIGEgZnVuY3Rpb24gd2hpY2ggaXMg
dGhlIG9wcG9zaXRlIG9mIGZlY19lbmV0X2luaXQoKS4gSXQgY2FuDQo+IHRoZW4gYmUgY2FsbGVk
IGluIHRoZSBwcm9iZSBjbGVhbnVwIGNvZGUsIGFuZCBpbiBmZWNfZHJ2X3JlbW92ZSgpIHdoaWNo
IGFsc28NCj4gYXBwZWFycyB0byBsZWFrIHRoZSBxdWV1ZXMuDQo+IA0KWWVzLCB0aGlzIGlzc3Vl
IGFsc28gZXhpc3RzIHdoZW4gdGhlIGZlYyBkcml2ZXIgaXMgdW5ib3VuZCwgbWF5YmUgWGlhb2xl
aSBjYW4NCmhlbHAgaW1wcm92ZSBpdCBpbiBoaXMgcGF0Y2guDQo=

