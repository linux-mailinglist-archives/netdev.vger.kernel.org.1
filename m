Return-Path: <netdev+bounces-137762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AA99A9AA4
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680D31C22122
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 07:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5383148FE6;
	Tue, 22 Oct 2024 07:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="S2L7TCBd"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023086.outbound.protection.outlook.com [40.107.44.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420C61494CE;
	Tue, 22 Oct 2024 07:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581244; cv=fail; b=fZpRojxnrS7OUGCU47XOht8FfPxtXVR0WLBjHWkRGG9TmCh09yWI8mKFBJYKd/ckHlROOk/foABo8HjC5dn2ppcgeWF73kOs3SfnObBgnDur8SJID+ZOc0tArQ1d6rG6vgqf7s5TDj2zYeWksUWbRY59obMtisPNGSGnHwDSKBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581244; c=relaxed/simple;
	bh=UeqhsBV6MWGww143brTZoVo0id9aX2DvtMDWClmZZCQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cVmn+I7jyRjSIVUelmS2ZATSqqGztkl8CRAi4n6ahkdnJMMYZeGEtGcQFBu1w8zrE6/WEBMJMn9ej9pxRNVtYldF1mdqfeC0/ogBOxu6FCF5Ls+nKQjiO0IG9fap2OHfHPk5xFx7kgy8Uc+8rlpKd8cEB2Espn7VJAuTyo3ZUdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=S2L7TCBd; arc=fail smtp.client-ip=40.107.44.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmD4M8un8DhgOdQEGZISLQ23Y8cdPzZDkcEfYFLdKM9YcdbK4SIXEviB9RbyAbafvD6GhooP+pS30xVVo5uT4Qv91El8SWIUVuHiA5fLte6jwXXvmVwuc47L+b6BHMLAjYOSK/oLo2h2Ne/hZKOWCSJLDqcNGGwCRuuJq6z25MXydopKzXUrn60OJWvPSpFL4aeymhn7p0DzER7g3pPWv+Z1bc+MXYFlvKxeBO//GWqdbfLh3M6NIBT3L2ifvYms/8k0WtbHdcXxu/+dWSQrcaq3cyUv0wCBXZ7+D7zKkLxVPIZTykJcSQWU+GjjArAmEGeiOWc304zcD7tPOTAjaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeqhsBV6MWGww143brTZoVo0id9aX2DvtMDWClmZZCQ=;
 b=NgNFCkkVYeb9eds/gnaYc69ugfZvXm1cWxaMGRIFrmx/owCsdnlR5a5NysxY973vR6d6Ru2r/dl144g9QfoqvwqN0u1w20EPbu9aG0NaIVKyrNfqXo/3bx/mZ99vRiG7CDH9WSyWGVaQ/v6uvVDYXLUh4rVW1wRRd1U+k2HJqok229To1WtBi5nwyBlw9qHxpcIBQ7+xDqlumRo2wtb2auN7CrSt8BDItiMXXl4mLoUwVLAGwe7qW2srmQMXdrFAt5ONcb3Yn/gKbgqyeyIDTBp2cpTqDVmQOtvBM7oTojONKbwe5anSqmHPPK3QFDjdeEWgD7PJphOBPPO6l10M6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeqhsBV6MWGww143brTZoVo0id9aX2DvtMDWClmZZCQ=;
 b=S2L7TCBdaOY0Spzzm9wjfS0L5VlC2IOyo+hFBTyCd1K5T169+QfjsfTWNqPdjOds+K/8iqtqB81pHlsKkoUqdzhqs7D9Xs+eNdVkWpImnCVJHjpImoA0sgIUgd11rSGpF37BrrHzU7xSBzZoiI9rbL7tS2enQharfrZDn0U8qI/dl31r4bh/H0yZU/ronHVk80EqwS+X2PlkJ5sJN9JbKxMcZowOPk749v4DDC5Wug7L8uLrd7KEV8sG4nOinAOPEhvPtQRyIg9on8jiATAbIFcLb2tVbecrVmo+kNX/D+GYSMAEod0PBfeLkTnBukcswc4e1b1mBhSPGvuLjffF3A==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEYPR06MB5491.apcprd06.prod.outlook.com (2603:1096:101:b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.14; Tue, 22 Oct
 2024 07:13:56 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8093.013; Tue, 22 Oct 2024
 07:13:56 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Simon Horman <horms@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0DogW25ldCB2Ml0gbmV0OiBmdGdtYWMxMDA6IHJlZmFjdG9yIGdldHRpbmcg?=
 =?big5?Q?phy_device_handle?=
Thread-Topic: [net v2] net: ftgmac100: refactor getting phy device handle
Thread-Index: AQHbI2IhvteklLcydEeBo2Oz91Lq3LKSWKmAgAAC3RA=
Date: Tue, 22 Oct 2024 07:13:56 +0000
Message-ID:
 <SEYPR06MB5134C8206C6BA27BD1F761319D4C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241021023705.2953048-1-jacky_chou@aspeedtech.com>
 <20241022065753.GN402847@kernel.org>
In-Reply-To: <20241022065753.GN402847@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEYPR06MB5491:EE_
x-ms-office365-filtering-correlation-id: 14896e69-3144-4ea8-05bb-08dcf269179e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?b3JnMlVwZUFlVU5PMGs5b3hyZjVWdjNOcVFKQU9Pc0JOZDJxWm1wTHBxa2orQ29a?=
 =?big5?B?Wjd2enB3V0JRRmJoMVJ0YnB6dElQWWcvbzBURWRFdTRPS3pSUmRFWEZsV3A3V3Ru?=
 =?big5?B?Zy8ycTR0cmdBdTBLcUk5ejhkWkZjZG1YK2lueVRTZlA2cThQdmpNOFpFOGZJS2R1?=
 =?big5?B?U3M1QmtxcTVrTUFUQSs1UkhwUGc2VnBoMEc1MllFYVpnVmx3ejJkSlpwamtWK0Np?=
 =?big5?B?KzNNR25jUG5lcTZJTjgwSXI3cXFXTjBGLytLaXk1YTVDcEY5NmZtbDFoSFQ2d2or?=
 =?big5?B?d0d3eUgrQ1QxWlJRRlU3bThTcFJ3MVBsSERvZ3RET2xGYld2eEpuSU14LzdiNWp3?=
 =?big5?B?YXJJdzZOOE1tSXVsOWs3WFE2RTlueHZPdWxxRURYcFdEN3VYNDdCSE5vSi9uelYz?=
 =?big5?B?akkxd2ZsS3FqeW4wWjhaUFBwTG5DMGRYMnJ6M3d4bnIzeExpQnJMdHd4dXdkamlY?=
 =?big5?B?cFloa1psS3VWeldvUU1zSE02em8wNG5UNUtBY0ZNc09uRU9WNXZkZ0Vwb1BkTDhD?=
 =?big5?B?cDdXSEdkV2ZtZkFESzFUa3MxbjU2bWNJeW81aVJ3L3dyNTA4cUo0ZitmbEJ4TVdK?=
 =?big5?B?ekQyT1UvNVhnbHQranV5bWFGM2pZblZxVitVbDBidi9zMzducHhybk95ci9sZ0RR?=
 =?big5?B?TmllVjNrRVlST04yOVpoUFNEeHl3OVMyN0VYeHhoRE9qRUNVTE96c1JKKzNGVDhC?=
 =?big5?B?cmZYT1E0d2xlZTBKU1FycGZENnVlU1labTg5M1B5cFA2b29CUE9DTXJMZGxSL1FN?=
 =?big5?B?cWJyYzNOM2pxYlBTVFFlNG5ubzNjMUROUTVUcGh5TlkvTlE3bHZVYzlmSHFBdkxx?=
 =?big5?B?aThjNEFtamZEcGVkL2thckJEZGk3QS9nNGxjZTBLT2ZjcXJUemplZXliMWRCZFYw?=
 =?big5?B?bkp6cUVGSFF4YWF4VG5tS2s0aXhhSFBvMjI0TmFwR1FHT0VxMDh5clMydkNiUHZp?=
 =?big5?B?cUtXbEhEYlZGMkpqN1NVRkh2dEtMUzcwQkFFNlFuSFJDVVFNL3lkc1l1MVphdUN1?=
 =?big5?B?TjF3eWdjbGcxRzJFYWlYUHQ3YUlwTHk5cHZMYTI1a2QzNm1lYnhOdDlEWFlEcHl3?=
 =?big5?B?b3htTWVCSU5ZK21Zb29vSFluOUpCVThoTGROKzcvejMzc0U5NEV0OHU2SE1DU2g3?=
 =?big5?B?TGpNT25NeENGakJKV01NcDdZejZJYkRzN29HLzVmdFY2cm02dHBaSnhpNWt1Wm5x?=
 =?big5?B?d3FEZi93MHdRWlJETXRXdDFOWFhuZFl4aFZFL2xlTm40cGVZVlZIVEp6LzRWWWZM?=
 =?big5?B?d3d0T0RQYUpnaFJQZlV1YzN4WUdCbE5XZ2l6ejdRTTRDZ1lmSnIzMyt1UGxZMGts?=
 =?big5?B?MjI4UlRiN0FEZFJDL04wOU5iYTY2UTFsNjNLZ1YvUUZ1QTRpU2lxaVNhNVRPQlVN?=
 =?big5?B?a3ZNTVZoMTY0YjhxVDEzajhGeDlUNzFtejlhcjhMbUNtZXlrSDk0UEVxZ1d5YnBo?=
 =?big5?B?Q0tHcFZFMTUvVGozYUM2cWd3anlMS1RnQW40cTFNUzVCNDNUK1RKaFRNaWovd2ZZ?=
 =?big5?B?cGwxMjRVRlY2YnU1QzFpc05PUEoydmNtai9TWVdrdXdJR1QvU2xwSTBidWRpdTQx?=
 =?big5?B?ZmtmK3FZMjFwelB6TGtLRXJmU1B2bWtUNld1MUdZWms3TU5PNXd5M2JVanFqenpM?=
 =?big5?B?S1ErQWh6NnNSVHFHblhBZ1JrNnBJZ0pIOG9RQjJ4MGFZR0dYb0J5dTQ3dzN4eGNS?=
 =?big5?Q?Yu7/wuORlli7DyIWV1m5bitIAs1xS5dfjsnJuojoanw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?N3R3TGVzSUlDTFQ4a21PeDdxOVB4YlZ5eDA1MU1pSUpyc0RvTkQxeExHOXVxYmRV?=
 =?big5?B?TnJ0bm1SV2puSlUrbngzTTkzbEJNZ2tLb1NOQ0I3SEt4VUtjSWpHcjNhcUlvbUU0?=
 =?big5?B?M3NIYWJRR2k5eERBcU1zeVh4eVdzWU8yOTd1MlVhd0FjRUVLdkdJdUhsMDJxNkJG?=
 =?big5?B?bVNjRG9HeVQ3ZnpHVC9yMHdiMkZiSS9ESlRycGVNVytUVDlydXc2MmV1cUhUb3oz?=
 =?big5?B?SmFMRk5CSWc3OW5sV0NUSmFkVzFDVXUxeVZzWE0wMzVIYVBKaDcrcVgxeUF5ZEJW?=
 =?big5?B?VjYzc1JENmIxQ2ZHMGhPSzhTcjJ0NVJiTEQzcHE0SjZUY0JpaFJpNEJpME5yNzNN?=
 =?big5?B?czRsUmJIWFFWdG9qVnhzWTA3czU4Mzc1ai8zNHVXdHZnUXE3SFlZSUhrREhHWWFz?=
 =?big5?B?c0hzYUZGZkN1dFhMNGh4SlZVTm5aZXcyNVJCM1drelNYN0E1SS9OQnUvU21jS29J?=
 =?big5?B?U1FSZENURE54UUw5aVZqeVJNOWFnR1lwREZHT1A4UTZpUnVMenNjSGZuS0hjV1Vt?=
 =?big5?B?UGZXMmhXNlVPYVdvY3VEU25KNTZweVJNQlpTekw0NmcwRXdiT21vOHBZOVFhUnEz?=
 =?big5?B?UkVjU00zejFDSjN2N2ZBcER0RUxHNlVvSU5ROGhpTWpNaTV3azRneFdnTjRYUEhu?=
 =?big5?B?MXhFSEtaSzlnQ1FWaUxxTmZnN2hRUWZyVGM0UUlZMEg1eDVXZFNrYXN1aVZuODZE?=
 =?big5?B?SEovTVR4aFJOMzF5TTdlMXA0b1FhVTR2SHRPSy9CblFXWG5yQUc4MkpDU2NodWti?=
 =?big5?B?bWNPVjdhZWFVWlUxbnhxOWhaTC9ReTBLbU81WW5oK0dKT0RmcEdjNXJ3NnpESWww?=
 =?big5?B?Y2NWMGdBVFRrcjc1ejdjWnFYbHpNeEp2OXBHVHp4ZEUrY2Urd3l3UjZRalEwMVVU?=
 =?big5?B?NVVtbm9yellrYzFDclBmcHBYb3k5dm9DOFREcFJOWnJtQ2NrY3NNcnFhdzlrb0I3?=
 =?big5?B?Wm5DNTMwVVdvSDVOQzRmb2QxTi92Mjg5Q29nZ3NhdGwwMXJsaE5OYVRCdUo3Mzdj?=
 =?big5?B?TjVvakRBZGRlS1Y5NG1oSmNtb2xrckNTU2lJM2NEcDI4dTRIQ0E0a1A4Y2dENitq?=
 =?big5?B?L2RXR0cwQnBRY2oycjlnMW43Q1BzZHdSSHp4SlNUR0JpR2Z5bUxYV1FZKzJDNVVD?=
 =?big5?B?WnRHclVqbDdRSlUxTGl0OHFldFVYVERuYXBDRmplaytSL2VOblZsOGh0Q3Mxc1BB?=
 =?big5?B?aHdiM1IyOHVZSW5tMWhTTVdyVTVJT0pyNElRdHlJdmNXQjQ1UnpRRHV6ZUg2cDFQ?=
 =?big5?B?Titmbi92VE5qQnE2VVVpUWsrbG90MGJPejdUcGtNck5kYU15Wnc5VVRDYWpaNGZq?=
 =?big5?B?VEpNNWY1c3l6M1VNRTVMNjk0eUtzMnd1bXlZQWZUcnRxOWora2Rla2tVMmh0NnBs?=
 =?big5?B?NGF1OTZ0eEg4MnZsVmloWGsvMXhuUUEyYjU3SkJIMDQwKy9VVGE1RHdzM2tLcTZ6?=
 =?big5?B?ZGZxZXF5SzJ0c1ZROCtLVVZ0NkFVd0h1aHZtaE0vZlNxRE54WWQvRG83YThJalJk?=
 =?big5?B?cGpPKy8yWXFHRk1QNTBNemdYcFV2aTJPL0x1eDYvYWNSTFpZN0orQ2ZFTkN2dzI2?=
 =?big5?B?MmhoMHloYVd5SU1pSVhsa2JDVFkvMkFZYkpHc0NHUW9GakVORktYMjY3dldGNExK?=
 =?big5?B?RFVEV2JRV3FUd2lldWFJamp1M09QOHlUNjhhcXpOUWt1Mzh5aW1iazAxbzJaYlAv?=
 =?big5?B?TUR6R0RtNUlUT0xLSTBkOGNFL29Ca0M3L01XNDdkOXFla3AwQVFKdi9rRFg4emlk?=
 =?big5?B?NHJTKzVEdmpNUEpNdjJBQVhBaGljc2lUcGpJdEdtbURDd0JMOVovTERFSDk5N2tH?=
 =?big5?B?TnZOMitFMUZLMkxqYlJCb1dDVUdON2loQmJtcVU2YWdSZzNua2w1NkJpY0VhTjZk?=
 =?big5?B?NUZvaWZpWVRKekxZc1pzTE9UaVRKMGVXb1NpQnB0Wk5WbXpkK0lINE9wQWhub3k4?=
 =?big5?B?Z1BFSEp1TW53bE5WUkVndzhCL0JtenNFQkc2RGRUODNOSmxFak5sc0NGRTM2bjRE?=
 =?big5?B?d1k0dXp0b0Z0WHVVWDhMSVBqNXBHZ1JyaXgvT3RhYnVvOE1VZEE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14896e69-3144-4ea8-05bb-08dcf269179e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 07:13:56.1335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IMVl5bfAci6z6i7XLZgx+ajtDXKrXsnp1pyUZYtR6g7TyXnOz1re9e02xn17QKchxiq05W/87Tv09Hvt7Meo9Han3ggc++dZ01s3s9h0hSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5491

SGkgU2ltb24NCg0KVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5Lg0KDQo+ID4gVGhlIGZ0Z21hYzEw
MCBzdXBwb3J0cyBOQy1TSSBtb2RlLCBkZWRpY2F0ZWQgUEhZIGFuZCBmaXhlZC1saW5rIFBIWS4N
Cj4gPiBUaGUgZGVkaWNhdGVkIFBIWSBpcyB1c2luZyB0aGUgcGh5X2hhbmRsZSBwcm9wZXJ0eSB0
byBnZXQgcGh5IGRldmljZQ0KPiA+IGhhbmRsZSBhbmQgdGhlIGZpeGVkLWxpbmsgcGh5IGlzIHVz
aW5nIHRoZSBmaXhlZC1saW5rIHByb3BlcnR5IHRvDQo+ID4gcmVnaXN0ZXIgYSBmaXhlZC1saW5r
IHBoeSBkZXZpY2UuDQo+ID4NCj4gPiBJbiBvZl9waHlfZ2V0X2FuZF9jb25uZWN0IGZ1bmN0aW9u
LCBpdCBoZWxwIGRyaXZlciB0byBnZXQgYW5kIHJlZ2lzdGVyDQo+ID4gdGhlc2UgUEhZcyBoYW5k
bGUuDQo+ID4gVGhlcmVmb3JlLCBoZXJlIHJlZmFjdG9ycyB0aGlzIHBhcnQgYnkgdXNpbmcgb2Zf
cGh5X2dldF9hbmRfY29ubmVjdC4NCj4gDQo+IEhpIEphY2t5LA0KPiANCj4gSSB1bmRlcnN0YW5k
IHRoZSBhaW0gb2YgdGhpcyBwYXRjaCwgYW5kIEkgdGhpbmsgaXQgaXMgbmljZSB0aGF0IHdlIGNh
biBkcm9wIGFib3V0DQo+IDIwIGxpbmVzIG9mIGNvZGUuIEJ1dCBJIGRpZCBoYXZlIHNvbWUgdHJv
dWJsZSB1bmRlcnN0YW5kaW5nIHRoZSBwYXJhZ3JhcGgNCj4gYWJvdmUuIEkgd29uZGVyIGlmIHRo
ZSBmb2xsb3dpbmcgaXMgY2xlYXJlcjoNCj4gDQo+ICAgQ29uc29saWRhdGUgdGhlIGhhbmRsaW5n
IG9mIGRlZGljYXRlZCBQSFkgYW5kIGZpeGVkLWxpbmsgcGh5IGJ5IHRha2luZw0KPiAgIGFkdmFu
dGFnZSBvZiBsb2dpYyBpbiBvZl9waHlfZ2V0X2FuZF9jb25uZWN0KCkgd2hpY2ggaGFuZGxlcyBi
b3RoIG9mDQo+ICAgdGhlc2UgY2FzZXMsIHJhdGhlciB0aGFuIG9wZW4gY29kaW5nIHRoZSBzYW1l
IGxvZ2ljIGluIGZ0Z21hYzEwMF9wcm9iZSgpLg0KPg0KDQpBZ3JlZS4gSSB3aWxsIGNoYW5nZSB0
aGUgY29tbWl0IG1lc3NhZ2UuDQpUaGFuayB5b3UgZm9yIGhlbHBpbmcgbWUgZmluZS10dW5lIHRo
aXMgbWVzc2FnZS4NCg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFja3kgQ2hvdSA8amFja3lf
Y2hvdUBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiB2MjoNCj4gPiAgIC0gZW5hYmxlIG1h
YyBhc3ltIHBhdXNlIHN1cHBvcnQgZm9yIGZpeGVkLWxpbmsgUEhZDQo+ID4gICAtIHJlbW92ZSBm
aXhlcyBpbmZvcm1hdGlvbg0KPiANCj4gSSBhZ3JlZSB0aGF0IHRoaXMgaXMgbm90IGEgZml4LiBB
bmQgc2hvdWxkIG5vdCBoYXZlIGEgRml4ZXMgdGFnIGFuZCBzbyBvbi4NCj4gQnV0IGFzIHN1Y2gg
aXQgc2hvdWxkIGJlIHRhcmdldGVkIGF0IG5ldCByYXRoZXIgdGhhbiBuZXQtbmV4dC4NCj4gDQo+
ICAgU3ViamVjdDogW25ldC1uZXh0IHZYXSAuLi4NCj4gDQo+IFRoZSBjb2RlIHRoZW1zZWx2ZXMg
Y2hhbmdlcyBsb29rIGdvb2QgdG8gbWUuIEJ1dCBJIHRoaW5rIHRoZSB0d28gcG9pbnRzIGFib3Zl
LA0KPiBpbiBjb21iaW5hdGlvbiwgd2FycmFudCBhIHYzLg0KDQpJIHdpbGwgc2VuZCB2MyBwYXRj
aCB0byBuZXQtbmV4dCB0cmVlLg0KDQpUaGFua3MsDQpKYWNreQ0K

