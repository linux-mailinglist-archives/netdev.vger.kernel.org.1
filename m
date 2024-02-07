Return-Path: <netdev+bounces-69811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F6A84CAA9
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 13:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62681C212E1
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 12:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92D225570;
	Wed,  7 Feb 2024 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="LOZaYC+G"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135835A0EF
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707308664; cv=fail; b=KtvqmJO5x5TsJgn/2iRjs0xr90V8tQc/0SY31Q92T6NT6Yd1hFrE3g30/sAkNfiKP2od0NvwhXuQxaufvtNSzk1+dcyhySKZaQVPuQKuqYofgOV1KEJCq8wiT+o0J88NWo6d9nXdFKVjr149sH2nj0tmbjgpCagsx0O96z0AFss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707308664; c=relaxed/simple;
	bh=k7Lbl6AzekW8ifjUZQd96NyZTYP0bZwcmrldnQLnz4I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Arpp8UI3OYxaKZXBaCqwu0oWuHPvCI55hD7skF3/59hdIv1JTWK6pyhtF+KznakS16iGuCUAEh1AysjN5NqhmkqufUJBSBEQo4tXkGePrYEqgD2kJ1OVKRK9XUZXd/bKXFblxeKYHyi3cW+OgO53TvPbDHG8HUI41rTUpYtY4ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=LOZaYC+G; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4170fBZh007435;
	Wed, 7 Feb 2024 04:24:19 -0800
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3w38u86x47-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 04:24:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5hUTOUf7qGncZ7FwuJJH8GnuqvijvhxBs2c6aYG5RICpzdmGmE7Q0k7A9Lb/DxD9uYrT3Ab3zcVYu5HVih9IM5OLNOTxNhIKC3Ze0ZMKcv+5l7gWoThTL1HGYtZcCMIuM+INUmXJ9QdxHayTvQaH4ku9nICVN4vUPEcfXsfzhqldtkb+BPNcajgfvJHSTWt+A/HcemfIlk278KQvCSDVgvjGR+IdDiEWVep/ks+v1BLy/iMLgq2IR7UWgfhO+z6eIz6G7WQMhcppyF8ji/XABpFnN7HKOzWN6BuM0UOAr8EtvRdrm5/AV6oKX/BCWsjI+fh/ko0dCD5NDEcjLEiWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7Lbl6AzekW8ifjUZQd96NyZTYP0bZwcmrldnQLnz4I=;
 b=ZLVAE7pLdzwYxx8CctFXgwpbnLARYQM6yb7rf5tpYxSaF3XWrhNe+VyQYgw3vGLLH/fSK5XxGUj2pzNvwpNhr8lvaRbea4UtV9BT1tal8wmPloOrXevG6jKCqCzPA3Jj5p//22/TZY4iMSL5P3UXvPRakW6SZ2abqyUvwWkcZKJQAqkZDit9gsqMJbheY7BftIXdSjNMb6Gz/SXxtGvhcrHx5WR7KVvJcpCcoUco1c/LkGVGnAjsFOry3jPzEADgwaZDZie+9kXhKteEGExZfwQRG4oTUcNM3DmHivDI4aHDtDeNsiQ1ylp6ErW+0hWv4TBKPpNhg0wA50R8jN0KCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7Lbl6AzekW8ifjUZQd96NyZTYP0bZwcmrldnQLnz4I=;
 b=LOZaYC+GNgml/4EMHofCdkT6ks8oggahJ23kSu6bOlRlnh14+MpppGcJUdQZ4G4tnE+X3vsViwsFXcarowqXcnkOoa1uLDdMi4UEV3Op3tC9cdPowJbcRsi/mmjZLlIjKSazJyX9oslLlgaeAvL9A565A6gLkC24TTrhnweBrcA=
Received: from BN9PR18MB4251.namprd18.prod.outlook.com (2603:10b6:408:11c::10)
 by LV8PR18MB6077.namprd18.prod.outlook.com (2603:10b6:408:228::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 12:24:16 +0000
Received: from BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::9b7a:456c:8794:2cae]) by BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::9b7a:456c:8794:2cae%4]) with mapi id 15.20.7249.038; Wed, 7 Feb 2024
 12:24:16 +0000
From: Elad Nachman <enachman@marvell.com>
To: =?utf-8?B?S8O2cnkgTWFpbmNlbnQ=?= <kory.maincent@bootlin.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Taras Chornyi
	<taras.chornyi@plvision.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: RE: [EXT] Prestera driver fail to probe twice
Thread-Topic: [EXT] Prestera driver fail to probe twice
Thread-Index: AQHaWRTVYbeYsqk58kW66MDvCmD52rD9oddwgAELHICAAAjz0IAACYYAgAAPF/A=
Date: Wed, 7 Feb 2024 12:24:16 +0000
Message-ID: 
 <BN9PR18MB4251F1904C5C56381FE976C4DB452@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20240206165406.24008997@kmaincent-XPS-13-7390>
	<BN9PR18MB42519830967969DEA4E329EFDB462@BN9PR18MB4251.namprd18.prod.outlook.com>
	<20240207112231.2d555d3e@kmaincent-XPS-13-7390>
	<BN9PR18MB42510F2EA6F4091E5CA3B409DB452@BN9PR18MB4251.namprd18.prod.outlook.com>
 <20240207122838.382fd1b2@kmaincent-XPS-13-7390>
In-Reply-To: <20240207122838.382fd1b2@kmaincent-XPS-13-7390>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4251:EE_|LV8PR18MB6077:EE_
x-ms-office365-filtering-correlation-id: 3d4b661b-8059-4cc8-38de-08dc27d7b395
x-ld-processed: 70e1fb47-1155-421d-87fc-2e58f638b6e0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 QJH78bmgtbKgs7JNe+b3OdtH4rINV+OEnOUKepNInvyy12Ycau1Qfxvzha/8cM5zDMpRb4IxI4mTC539f/4fKEF95h4wy6hvBTeZGitHdxtaxmjIfoOCjbbY52EyEaGvcRbfwFqDXAlUw29K5kFfrr9fuLGW1d9FGR32aqkiKH3/qK9SVv4TFetC9vImL6plLW+YdcJS8yAAd6e/G8pJWhSkQ3tMi7plmfcmIifz3ZcBdmf/Y1JlDxOyO4Dzs1xFi8zGfMSBjZT+UEi60U7LN3CWmL1kwkxM5kPlf9wAyno08z0x/sMnUDa1xUp8PD9E1EOkFxG8kvqqqTKp/8xU/90yHpUPN6lMikKteUacG5L240piS4D298U6qLD3Ei+xG7erhTb6oCl5XJqPGKnbYlu6coiIoXpVvc96DMpZVXqOEve9oLGcCZopsFtotHKwkkjyKKjyUoAZ/gXzPaFGHVivzkKwAlo/G9Sn57MrgeG6SCvbvnz7djAULF1pcT83pj9UC8tyR76rxfVdNHtT0qEIRvQMXO2ToA9hrct9HOrY+8ef9hfNZeBKo1KwZA5Yy/1vXmvoFJGl4M0QrKGSa4nAWlyK+waZWRy/nz+8W/Q=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4251.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39860400002)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(54906003)(8936002)(966005)(76116006)(66946007)(66556008)(66476007)(66446008)(7696005)(53546011)(6506007)(64756008)(9686003)(6916009)(478600001)(71200400001)(8676002)(38070700009)(4326008)(316002)(33656002)(122000001)(38100700002)(26005)(86362001)(83380400001)(66574015)(52536014)(5660300002)(2906002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cHIxQVFjN1FDWnNkekJBTWp1QklLQ0VnTmFDTlZOUmxwOFNyQmxiMTdmTHZq?=
 =?utf-8?B?ZlZWT0cyYm9nNnR0aUJTeStMVXp6cjZqT1JhdVRHSGdnUWVZRmhlbTIvNTd3?=
 =?utf-8?B?STV2S3Roam1ocHRCMXkxNkpEVXdhMlRxM25NTjVqV1ZXWFpyT3U5aUZ3VVlK?=
 =?utf-8?B?ZTRyVUdTa3JsdFo0NGVIdHhMREJ6VWJtaDRyL05QVlJsNXpreGFWYkMxZ21l?=
 =?utf-8?B?WkdnbUR4eC9SZVJtVHNtb3BqUWJuU2Y1eGp5VjBDbDcvT0liaGh3T0xjcnl4?=
 =?utf-8?B?dDV2U3ZwZnhKQmlQQ1lRSUJPMWRRY29PbWZPZG5tUVZLLzRHdngxTnEwRzJ5?=
 =?utf-8?B?cDdON2ZScm02Vmw5K3VpeGRJV3BYSlM3YmJUc3h6d3NEbjV0SUp5ckVva2lp?=
 =?utf-8?B?WTQ4K1NYK01ibndFSDFRQXhFaXRLZnIyb0tyeGNuMEFaVmFTV2F5Nm1mdTVq?=
 =?utf-8?B?M054OHV0cnRBRjBHSDRBTjJjeDRxbDE2dVM2dkYxUTRWWXR0d2JaREVDVFFn?=
 =?utf-8?B?Zlo0c3U4aDdDNUEzcGx5b21ZT1FLajZJRVFLZmFiSWY4RVhOVnhiQlM3UXU5?=
 =?utf-8?B?dFJ1Zms4cWo2SnhVcER1bmRqVTdVRjlWU2JXZk8zZFZlTG05MmpZYlp5Rmc5?=
 =?utf-8?B?NktlYWZCU2xDa0ZEMkpMRUEycnFCUFBjajE2SWRyKzFQUzdsOFpBY3F4cE9S?=
 =?utf-8?B?MkZRVXo5cFNsUTVhUUE3a3ZGc1lKMU5vb2FrUXAwYXhMOHFDbzAwaEdtUEQx?=
 =?utf-8?B?UWhnQXNKTVpzaTlsdUNRckhkTFFyMkZ0Y0JhMWEwSEEzaG1PRnBVTkJyNWJi?=
 =?utf-8?B?NWVMZXZEaTZDL0tMNXErU21oMmx5RmVTbHVrTjRRZ3NTZ1RYUTNZZ2NDZU4w?=
 =?utf-8?B?cExlRnhIbmtJcU02WEF2V2syK1NaZG1GaExaZ2d3Sm5ONE1ONGlGZVljcnl4?=
 =?utf-8?B?aE9Manptd29rRXZhcXpQemI3a1FWT2h2OHp5YkxTYjNFSjZsRG5MMTNVNUYx?=
 =?utf-8?B?c3BNWnQxYXlrOFM4SldCQVF3Y0Q3ZHdWU3Q5SmQ5OU5hUVJ5SFFueDg1OUJ0?=
 =?utf-8?B?d3YycHZXSHJYdWNveU5MM3ozdVhvYkcwZ040bmFreDlnZkVPaHJ5eUNMd3Yv?=
 =?utf-8?B?OXBOUFlrMEROWVUzYy92WUlSeU5lRWJhcStBdmMrVVVtMUdibnVJOTJDb1g3?=
 =?utf-8?B?WWVvNzYrTDN2WlVuVmpmZXE2R09DSTdRa0RiS3kyREU4TStuQjA4WnlTWFhv?=
 =?utf-8?B?ZCttTEJ3R3lpd1BqcndLMkpCMVlSRHVnaDZ3cDY4UWI0WmRkdXh0S245MDNL?=
 =?utf-8?B?SUNQeEl3aGQvb1JlN0hyd3Jid2NhUFFvZXpldlZhREljbkU2dHVqeWcrdjFl?=
 =?utf-8?B?Y3U4U25ZSlduSE5qdndac1l3TzRtWWdraW5sNEk4cFJTM1VmZE0xeXZlZkFk?=
 =?utf-8?B?QjNyNkM0cy9hbnV1bTlTWWxYeUR3YThDZUxJc1dEM3B0QStLcW42UzBOSFdh?=
 =?utf-8?B?NUd3VHYyVmxKNXpBNnRZMmJVdHdlUThmbGN6RmN3STdWeWVFUlFOaWJRR0Ur?=
 =?utf-8?B?R3Z0SmZrbUFYOHUrMjRlOU8rVXAyNDZiOXN5SVFQZGxwY1JRNVBSY3FBKzlS?=
 =?utf-8?B?UEZ1T0x2a0hTdVJDL09oREFhZVJpSzhadVZDOGpBWkRwdmtVQmlBOFJIbTBy?=
 =?utf-8?B?MkJVVGlFZkxodHZOVy91N0hCQXpMNE1JY3Q3UEszTDJ2eG9yeERLUU14ajVi?=
 =?utf-8?B?K0dqSjBOaG9kSy9raDJEeEswb05xbGNpcm9sNEhHcDRVZGUvSzIwa2FxSGRG?=
 =?utf-8?B?VVpxYmVFN2U0R2Nta3lkQ1ZlM21qcm11bVJsRHlRWWk1RlNSSGxmbmt3bmJr?=
 =?utf-8?B?L3BBZ0xlSGsrTFBISnptVXVOL09aZmZVTlN3MEZlak1FZWJITGNGb3J3NGNH?=
 =?utf-8?B?aHhNYlFVdjI0MExDeU1pNHhUR3BibDBVQkxwSDRFT29xcFdWK2VYdXJoMUFI?=
 =?utf-8?B?WGtJK3FrT1JQN0Z5MWVYUmhtTGVGWm5qUkdudXJuQURoZnphTm93K2IrYmZH?=
 =?utf-8?B?U29uMGp4aVlma0dVSWZVdzVaYWZuN1haZVhkaXRGc1VGL0VFVWwzRlI1QUJO?=
 =?utf-8?Q?KukNiN7QT9x67pMZIBJMpkQk4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR18MB4251.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4b661b-8059-4cc8-38de-08dc27d7b395
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 12:24:16.3676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZ752Y5wSBjAWZ29aRRSZAxyt/B6r6Q5RameXF3zSyhzM2kNK7oVrTXT6f4I/PsMs+gigW038i/w/oihtDcacg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6077
X-Proofpoint-ORIG-GUID: nX_Tx44YdKoh2j80iQKfKNKrJUG42tLl
X-Proofpoint-GUID: nX_Tx44YdKoh2j80iQKfKNKrJUG42tLl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_04,2024-01-31_01,2023-05-22_02

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS8O2cnkgTWFpbmNlbnQg
PGtvcnkubWFpbmNlbnRAYm9vdGxpbi5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkg
NywgMjAyNCAxOjI5IFBNDQo+IFRvOiBFbGFkIE5hY2htYW4gPGVuYWNobWFuQG1hcnZlbGwuY29t
Pg0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgVGFyYXMgQ2hvcm55aSA8dGFyYXMuY2hv
cm55aUBwbHZpc2lvbi5ldT47DQo+IFRob21hcyBQZXRhenpvbmkgPHRob21hcy5wZXRhenpvbmlA
Ym9vdGxpbi5jb20+OyBNaXF1ZWwgUmF5bmFsDQo+IDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29t
Pg0KPiBTdWJqZWN0OiBSZTogW0VYVF0gUHJlc3RlcmEgZHJpdmVyIGZhaWwgdG8gcHJvYmUgdHdp
Y2UNCj4gDQo+IE9uIFdlZCwgNyBGZWIgMjAyNCAxMDo1NjoyOSArMDAwMA0KPiBFbGFkIE5hY2ht
YW4gPGVuYWNobWFuQG1hcnZlbGwuY29tPiB3cm90ZToNCj4gDQo+ID4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogS8O2cnkgTWFpbmNlbnQgPGtvcnkubWFpbmNlbnRA
Ym9vdGxpbi5jb20+DQo+ID4gPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDcsIDIwMjQgMTI6
MjMgUE0NCj4gPiA+IFRvOiBFbGFkIE5hY2htYW4gPGVuYWNobWFuQG1hcnZlbGwuY29tPg0KPiA+
ID4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IFRhcmFzIENob3JueWkNCj4gPiA+IDx0YXJh
cy5jaG9ybnlpQHBsdmlzaW9uLmV1PjsgVGhvbWFzIFBldGF6em9uaQ0KPiA+ID4gPHRob21hcy5w
ZXRhenpvbmlAYm9vdGxpbi5jb20+OyBNaXF1ZWwgUmF5bmFsDQo+ID4gPiA8bWlxdWVsLnJheW5h
bEBib290bGluLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbRVhUXSBQcmVzdGVyYSBkcml2ZXIg
ZmFpbCB0byBwcm9iZSB0d2ljZQ0KPiA+ID4NCj4gPiA+IE9uIFR1ZSwgNiBGZWIgMjAyNCAxODoz
MDozMyArMDAwMA0KPiA+ID4gRWxhZCBOYWNobWFuIDxlbmFjaG1hbkBtYXJ2ZWxsLmNvbT4gd3Jv
dGU6DQo+ID4gPg0KPiA+ID4gPiBTb3JyeSwgdGhhdCdzIG5vdCBob3cgdGhpcyB3b3Jrcy4NCj4g
PiA+ID4NCj4gPiA+ID4gVGhlIGZpcm13YXJlIENQVSBsb2FkZXIgd2lsbCBvbmx5IHJlbG9hZCBp
ZiB0aGUgZmlybXdhcmUgY3Jhc2hlZCBvciBleGl0Lg0KPiA+ID4gPg0KPiA+ID4gPiBIZW5jZSwg
aW5zbW9kIG9uIHRoZSBob3N0IHNpZGUgd2lsbCBmYWlsLCBhcyB0aGUgZmlybXdhcmUgc2lkZQ0K
PiA+ID4gPiBsb2FkZXIgaXMgbm90IHdhaXRpbmcgRm9yIHRoZSBob3N0IHRvIHNlbmQgYSBuZXcg
ZmlybXdhcmUsIGJ1dA0KPiA+ID4gPiBmaXJzdCBmb3IgdGhlIGV4aXN0aW5nIGZpcm13YXJlIHRv
IGV4aXQuDQo+ID4gPg0KPiA+ID4gV2l0aCB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiB3ZSBj
YW4ndCBybW1vZC9pbnNtb2QgdGhlIGRyaXZlci4NCj4gPiA+IEFsc28sIGluIGNhc2Ugb2YgZGVm
ZXJyaW5nIHByb2JlIHRoZSBzYW1lIHByb2JsZW0gYXBwZWFycyBhbmQgdGhlDQo+ID4gPiBkcml2
ZXIgd2lsbCBuZXZlciBwcm9iZS4gSSBkb24ndCB0aGluayB0aGlzIGlzIGEgZ29vZCBiZWhhdmlv
ci4NCj4gPiA+DQo+ID4gPiBJc24ndCBpdCBwb3NzaWJsZSB0byB2ZXJpZnkgdGhhdCB0aGUgZmly
bXdhcmUgaGFzIGFscmVhZHkgYmVlbiBzZW50DQo+ID4gPiBhbmQgaXMgd29ya2luZyB3ZWxsIGF0
IHRoZSBwcm9iZSB0aW1lPyBUaGVuIHdlIHdvdWxkbid0IHRyeSB0byBmbGFzaCBpdC4NCj4gPg0K
PiA+IEV2ZXJ5dGhpbmcgaXMgcG9zc2libGUsIGJ1dCB0aGF0IGlzIHRoZSB3YXkgdGhlIGZpcm13
YXJlIGludGVyZmFjZSB3YXMNCj4gPiBpbml0aWFsbHkgZGVzaWduZWQuIENoYW5naW5nIHRoaXMg
d2lsbCBicmVhayBjb21wYXRpYmlsaXR5IHdpdGggYm9hcmQNCj4gPiBhbHJlYWR5IGRlcGxveWVk
IGluIHRoZSBmaWVsZC4NCj4gDQo+IEkgZG9uJ3QgdW5kZXJzdGFuZCwgd2h5IGZpeGluZyB0aGUg
cHJvYmUgYnkgbm90IGZsYXNoaW5nIHRoZSBmaXJtd2FyZSBpZiBpdCBpcw0KPiBhbHJlYWR5IGZs
YXNoZWQsIHdpbGwgYnJlYWsgY29tcGF0aWJpbGl0eT8NCj4gRG8gSSBtaXNzIHNvbWV0aGluZz8N
Cg0KRmlyc3QsIGZpcm13YXJlIGlzIGxvYWRlZCB0byBSQU0gYW5kIG5vdCBmbGFzaGVkLg0KU2Vj
b25kLCB0aGVyZSBpcyBhIGNlcnRhaW4gY29udHJvbCBsb29wIHdoaWNoIGRpY3RhdGVzIHdoZW4g
dGhlIGZpcm13YXJlIGxvYWRlciBleHBlY3RzIG5ldyBmaXJtd2FyZSBieSBBQkksIGFuZCB0aGF0
IGNhbiBvbmx5IGhhcHBlbiB3aGVuIHRoZSBwcmV2aW91cyBmaXJtd2FyZSBjb2RlIGhhcyB0ZXJt
aW5hdGVkLg0KDQo+IA0KPiBSZWdhcmRzLA0KPiAtLQ0KPiBLw7ZyeSBNYWluY2VudCwgQm9vdGxp
bg0KPiBFbWJlZGRlZCBMaW51eCBhbmQga2VybmVsIGVuZ2luZWVyaW5nDQo+IGh0dHBzOi8vdXJs
ZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0NCj4gM0FfX2Jvb3RsaW4uY29t
JmQ9RHdJRmFRJmM9bktqV2VjMmI2UjBtT3lQYXo3eHRmUSZyPWVUZU5UTEVLNS0NCj4gVHhYY3pq
T2NLUGhBTklGdGxCOXBQNGxxOXFoZGxGcndRJm09VDQ0Zzc1WWswVUYwdXFPbFpyT2VhMDM2X2xP
cmYNCj4gZUg1ZzRvVlRUWkFCRExWTDlZYjA2cFNTSDhveHNSZ210N2cmcz1MM196Z3pKdmNlNkhF
U01BZzFVV1BlY0ktDQo+IEhxdTl1T0dkOE4wQWFaMUp3ZyZlPQ0K

