Return-Path: <netdev+bounces-74882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B17186714B
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 11:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE661C28104
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 10:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F106817;
	Mon, 26 Feb 2024 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="XN6xiLUF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCF751004
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943279; cv=fail; b=JgXan5czaPbEfnCsuUNIMwiguRhkLA4quFz6SMJQnyLOq742i4mxmErGr0FAPIH1dCm10AaDo9/I9GUM7G/AMhqyFDR+cYY0EWD3eJ7hM9k+L5UUJULkgXyMYR8C0SCtffNAMo3u5CHfEimakC4sJGkSdTosmf+EtAotY/jo7ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943279; c=relaxed/simple;
	bh=L5U87IT7yIGFlsuVgB23y9JjkTptOw2jsQJb9Z4OjOI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h4+2BXoTqvawc7IPU/o1RDxKUg2LeRtLuFRA1NOxJ9ou/ZazNeetnowIW0lq1YVyahBlI4c1Z9bDJjOm0GF8Y7BuVe76zsM2kb0ExjvxCz0RWrANZ3Cp/JmACaEDc4LBm2qQK2vR5nrXF5r7OYY9EMPoLRhsYZkStrlNGxEnOZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=XN6xiLUF; arc=fail smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41Q8Dp9N026918;
	Mon, 26 Feb 2024 05:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=ck1x3/0kB7HCDkHrInc6iqVKuHE4QSSIqLyZg7rQr4I=;
 b=XN6xiLUFVEhHw941xnJidDYbsenE7m+/+0mc2+pH3lt10NKufiikSwewR9T/PnMN59GL
 +OfvWaMqRTH7qiUZFib6MfQDFzg4d4IyxNP8MqfWaQ6C01Ls4i9rn40USUJYt+qEuBrL
 EYHBCXbQKCvP/gKEp6Mc/gpsUjtwTuwOClRzJjjBz//ALA9xpj6OsPv5U9J4LZ92fRDY
 3hRq4f5VRH10japAMSOAI2bYHy5Vw55EaVr+7utnMd6j5b7YQl2VuyGTkKqSPXpi+JVs
 NIErue6w+aQEJ1NVhKXA8DOk7mCI/p7sCmuJFJui/zSr+G4EuSqQU6AIwWLJLENso+6T 0A== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3wfd645f0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 05:27:45 -0500
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41Q94CXA029564;
	Mon, 26 Feb 2024 05:27:44 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3wghc5nf6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 05:27:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKoRfTx+UH/SMDn7ZPfJw0XLGlnwxAa9P5MwnTctHzYX70SQX2IVvbmap1s8hyVl7Q5KwEFfc39GpR32rU93ZRy1YzlQ18kQHfwqgd81GQKb15CzXp7R+M8tjxxVTmzNyDm/yLY/FaITxEp1/w2+qim+R2FvGP2SCMiy1FL8Tl8M3oCxHZeANNCwV2+DsaLPXOWNsScj9OgdOAGXtyyTkg+79OUpXGjvxT2okunTStHSdLfr6q9BGJXqobOwOq90LnzTnlDBRTVwMTskIVz6w4Cq2+bbtBEb+fl8ywfdezST3/E6YPubhZjibsGiHUkwsU3E8qabZZHy27nAFje8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ck1x3/0kB7HCDkHrInc6iqVKuHE4QSSIqLyZg7rQr4I=;
 b=esBDVpRy26nHRmw7oo2vgOCpdl0WVWDWWP++54EkRBkMobyGmL8nMqAkWerMNMTo9B2g8jwgqBZ3q/e8/A5RhsoFxGi4sB/ZJRmbA5SIXPg9rEr2B/YKITZGg/ZCy9uIxV38vievnCh5dGNh+756v3b8L3SegQK5FNsTdyMQUXhpN31vEwY1+3J2DE1T5HhxqH2/oS+gBujnnrWZVaV2awLq9fDj4AfDjWuRO5MH8V3HiroP5vT4JpE55JdW8oH2cEiD7ZcgelPuFgjXnCHV+lWzTHRyzBr/zYfHiY2mQXJaTsPt4C/3EXVNR2W1hufAnw0st3vpBgjSaO4ziAxR2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4415.namprd19.prod.outlook.com (2603:10b6:a03:286::17)
 by BL0PR1901MB4724.namprd19.prod.outlook.com (2603:10b6:208:1c8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 10:27:40 +0000
Received: from SJ0PR19MB4415.namprd19.prod.outlook.com
 ([fe80::2f11:2339:cc0e:38bf]) by SJ0PR19MB4415.namprd19.prod.outlook.com
 ([fe80::2f11:2339:cc0e:38bf%4]) with mapi id 15.20.7316.032; Mon, 26 Feb 2024
 10:27:40 +0000
From: "Ramaiah, DharmaBhushan" <Dharma.Ramaiah@dell.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "matt@codeconstruct.com.au"
	<matt@codeconstruct.com.au>
CC: "Rahiman, Shinose" <Shinose.Rahiman@dell.com>
Subject: RE: MCTP - Socket Queue Behavior
Thread-Topic: MCTP - Socket Queue Behavior
Thread-Index: 
 AdpjPln1K8p7U6IuQcSvYKsg8BomjQAZRv2AAAG16IAABwYDAAAUyJNwAA+YNYAAeH9g0A==
Date: Mon, 26 Feb 2024 10:27:40 +0000
Message-ID: 
 <SJ0PR19MB4415097526AFE55EC0EE2714875A2@SJ0PR19MB4415.namprd19.prod.outlook.com>
References: 
 <SJ0PR19MB4415F935BD23A6D96794ABE687512@SJ0PR19MB4415.namprd19.prod.outlook.com>
	 <202197c5a0b755c155828ef406d6250611815678.camel@codeconstruct.com.au>
	 <SJ0PR19MB4415EA14FC114942FC79953587502@SJ0PR19MB4415.namprd19.prod.outlook.com>
	 <fbf0f5f5216fb53ee17041d61abc81aaff04553b.camel@codeconstruct.com.au>
	 <BLAPR19MB4404FF0A3217D54558D1E85587502@BLAPR19MB4404.namprd19.prod.outlook.com>
 <da7c53667c89cb7afa8d50433904de54e6514dde.camel@codeconstruct.com.au>
In-Reply-To: 
 <da7c53667c89cb7afa8d50433904de54e6514dde.camel@codeconstruct.com.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=8391bb76-ac97-4f05-9dc9-71b52bdf582b;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2024-02-23T09:23:02Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4415:EE_|BL0PR1901MB4724:EE_
x-ms-office365-filtering-correlation-id: 07c3578c-a950-4d5b-befe-08dc36b58fb0
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 OHtdfd0cyMY7SpIhyxkGWxz6q+wkhDbPbyOOQ2HQqDMX3V6cmkMnBHPIqF7BhtUCI6ndEjQRWTc+ZZgqTD7WW4dPYJZ9PqAuuLBikdfmocNL6Xr6Srh9R+ZrNm8P5DIwlR5OgftSOBlh+AygtCE0U+FEjmt3bKTZa0KyUIRGpUG/YeTs8GLSWnsbahM3Zysk6tv3dnJf5mKhZxvKPIkR2c8fBG8WuR9QvUmR6Ar1K/D3FAeRou/K3cRFMJgAJH43Yiw4H28nan1qPIvvVqTzldhgrY22LlOHNGHrWe+IWXhACfQQc2xg+p6WEBhbyToRrFB0vlLAYL5sV8HRpLcgy8RtkC3O7mDUE8xd8B9fG0p1pUFJbbNBW1xI2cMnj4gnJX67W1Oc7uN66fmWDwniMqAEDFHEwhPjizmN024+Y6DDIdTIYmEO+gK9Sd3iCIC/rOwoxum0lktDCVY5hhVyvwDZyzeiyAvqUpTxtBgBnVudiGazr6uqd3z+I6lceludQ/qx6W7t7Pz1a3nZYvovvkG5EbXcJYUovfxRtaV7bs4dkVehpfgBjA21Gze9jhn+Zgg3qgT2FTEAWWAvVbSvF09KA2t8xe9QmAK0pFJmMnTHGghOSXok8jjlhmWY7MS3TFje03FxIt2mL1FNWcKd8vWq5KDxIX2+N7PvAdVfILcVSQgBOH7VLLGdmzQZJcorgoP4Ew7FGqm6pGx5vfzw4tMEuwhwmJ+EhlMPyrJ4hfk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR19MB4415.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-7?B?TUpNL2dHRHNtbEpkaWJGS2dsOHBKQkNqWVhqcXpxWEtpZDdqY1hPVDIrLVdz?=
 =?utf-7?B?TmNNKy0vWjkwcUR1VDRiNlBBMmMyNTFzS250dTFTRWhQeFM2VlhHeHhZZFVJ?=
 =?utf-7?B?T0VKSnNMMlEvQ1ExSW4wamZrN1I5OTA1b2tZb1FGajFrUC8rLUcydnI0MFJ1?=
 =?utf-7?B?b2FGcTEwcTEyY3dkYXhWSGN6YlFXaEVtZDJMRlFYV2UzRzZvWHpFek9mWDNH?=
 =?utf-7?B?Wk1xSWhheW1udXJrejd1ek1LOWNuZ3JLUnFmOXM0YWhUUHI2ZDNGZnFxZEhz?=
 =?utf-7?B?dUlLb2ZTZjNrQlp1dkRMT2NhY0xlWkNENUhaY1VxN083bHVvTzlaNFZtZWNq?=
 =?utf-7?B?aFhNb1dQVU80NWo5TEZOV3hNY3hYMFl1cEU1UEdkdFZJSlZsL2I1aWFpSSst?=
 =?utf-7?B?TmlQUUlSN2dmektSNDBCZ3RiR0NjS2Z6Y25oTU92TkYwTXo1TU9XTkV2UmN5?=
 =?utf-7?B?Y0oxUU5CajhIR3VibFlBWWVjbmdsRlVkcmc4VnNPS0ZiczU5em5hczJzU1ln?=
 =?utf-7?B?Y1JKNystTWdnWHpqTVJvZGNybVJaajU5Nkl0ZnBQOEJpZnVQU3NhN295c2Ux?=
 =?utf-7?B?WlFvWGRtWnQ3STF5U1duL1lubWFOUzNDQSstcistdEdwbEorLW9UZjRuVk5z?=
 =?utf-7?B?US9hU2NZZ0lUSDZqbXAwVTN1dUJaUlFPZmx6L0JZdCstYU5yOHdaekVQbzRp?=
 =?utf-7?B?dEtJaGM4NnRtT0gvTUp5cmc4ZGtsWUFuY1NXZU5abFFjWktScEo5VjZYc2h2?=
 =?utf-7?B?MUI2T1NhQistUHhtYjJjRUoxT3NtemxGOWkzMEk2aDg5ZjlWY3dUYkJ4RU83?=
 =?utf-7?B?OUtFWTREYmxrOXZSakdFbXR1Ky1yOWRGYzlISistYzFZZVdyYklhS2tHWW1L?=
 =?utf-7?B?NGZwNHRpdEtIQkRnM2IybFBPOEFPUGRLM2c1UjlCNjMwMmU3UHREMk90YkdZ?=
 =?utf-7?B?by9EWjlCUE53ZGxjaEFMMXNiejNhYVZHTXVFcHdRQlFWRXM4dDdtdm14VnZZ?=
 =?utf-7?B?V1orLVoyWUJPTm5kby9wdHZBdlo5c3IwZ2MxSDhOc1I1U096T3czVE8xMkZm?=
 =?utf-7?B?dWtTaFhrSHBJWUxCYmZRU2REa0JZamNpNUIwWUJBTmgvSzhCaVlQS0dKaTlE?=
 =?utf-7?B?YystYUROVC9sRUdHcFBLdFV2SkhjbGZJM2l3Ti9vaWpLU3hoV2dBYnBtWXND?=
 =?utf-7?B?emxpMkRETFBzWXVmVTh6TW1TQkpTdm12dFNkeVMyeGJxeCstTUNDMFcxN2M4?=
 =?utf-7?B?bko2YWFYczkyMEI0RW52enB3MlZzd2lRTVdZSTFiS1Q1eC94Qk10NUVGU3Vi?=
 =?utf-7?B?Z3NrRWJMV3IyRk9RdFpiSWhDaTIrLVVodnh4a1o1ejd2MnZ2OGwyZlRlaFNJ?=
 =?utf-7?B?bUhLQ2t5Mk01WDJoYXFnb1ZERUI2TnVQMG1vSHJteVNyb1VTNHJUWndTMUJx?=
 =?utf-7?B?S2lCRkpIeXZPSFc4cU1JYVU1MWVsZUFFNDBzV1E2SnhOSzd1RWgzQnFNRlNL?=
 =?utf-7?B?WGsyR1hkWG4zWEFWSU01Ky1yZFZZaXhSNEhFNDdCY2gyRGRhZlF3c3hJTVg=?=
 =?utf-7?B?ZystN2x2MG04SjUrLUlXR1I1eU5QdWpZTHkyMHphUkVobXNPQnMvSistRVM5?=
 =?utf-7?B?RVJOTWNEY1pPaXJpeVoxbUk3RVEyTmRGQXR4RU5ieEU4c1BYSGdYMGp6UTVG?=
 =?utf-7?B?RVJQQVF6L2RFRVB4TjltWk9OQjlYNjdveGkwdFQ5QzYwWkIrLXlPaE52bmpG?=
 =?utf-7?B?d0pMa3A4Q2hGeElqRFIyZm5lWVdMNG5vaENzOExqNDFaUUZXY0dMdjMwSk9W?=
 =?utf-7?B?QVZyMHdRUkFlTVNZdVVvSVd3enNCakRjSVdaay9Vekh4QkVoYmIzTWxId2dU?=
 =?utf-7?B?V1lsQUI0TjJWbXBzNFFWbE0rLVVWT2pndXNjeVBHajJoZ1lrQnE0cGpYMzFB?=
 =?utf-7?B?dUkweWI0LzhUTWhXVUozUjZ6VlBBdURkb0c3VHdwVVI0TkJCbSsta2gzaFpF?=
 =?utf-7?B?VExTVXhyT2I3dFpxdVNuaXR3R2dxcTJFL1AyTUhDWWo3RlRNREN5YTk4MnU3?=
 =?utf-7?B?RGdxcnMyL1I1QndaZzNlN1p0ZEtucWRUT2owMUV3V2pzQlI0SFF0V2puWEJV?=
 =?utf-7?B?UjZicSstNmplMHFqNktXOFNld2Y4QS9icUlhTjVmREtEdy9WalhlL3NoWkN0?=
 =?utf-7?B?QnI4eW0xVDZMQ3hqV05FODZsV0ZNSkxTTHFzVHMwVWx5S0hTTFV6dzJhU29G?=
 =?utf-7?B?TWdBK0FEMC0=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4415.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c3578c-a950-4d5b-befe-08dc36b58fb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 10:27:40.7041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o3UF2wOmBiaxTKfcqDUymAzGBHusshqUr+RZbIdksSBrZf3h/Fe2R8zx3Fod7/L8E12SsZ+tzr3dxl1lr/sgGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1901MB4724
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402260079
X-Proofpoint-GUID: TlI5L7bCWBk-P3bODkdM7qdL2CR0ILU3
X-Proofpoint-ORIG-GUID: TlI5L7bCWBk-P3bODkdM7qdL2CR0ILU3
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402260078

Hello Jeremy,

Please find my response below.


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: Jeremy Kerr +ADw-jk+AEA-codeconstruct.com.au+AD4-
+AD4- Sent: Wednesday, February 21, 2024 5:23 AM
+AD4- To: Ramaiah, DharmaBhushan +ADw-Dharma+AF8-Ramaiah+AEA-Dell.com+AD4AO=
w-
+AD4- netdev+AEA-vger.kernel.org+ADs- matt+AEA-codeconstruct.com.au
+AD4- Cc: Rahiman, Shinose +ADw-Shinose+AF8-Rahiman+AEA-Dell.com+AD4-
+AD4- Subject: Re: MCTP - Socket Queue Behavior
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4- Hi Dharma,
+AD4-
+AD4- +AD4- +AD4- To be more precise: the i2c bus lock is not held for that=
 entire
+AD4- +AD4- +AD4- duration. The lock will be acquired when the first packet=
 of the
+AD4- +AD4- +AD4- message is transmitted by the i2c transport driver (which=
 may be
+AD4- +AD4- +AD4- after the
+AD4- +AD4- +AD4- sendmsg() has returned) until its reply is received (whic=
h may be
+AD4- +AD4- +AD4- before
+AD4- +AD4- +AD4- recvmsg() is called).
+AD4- +AD4- +AD4-
+AD4- +AD4- From what I understand from the above bus is locked from the po=
int
+AD4- +AD4- request is picked up for transmission from SKB till response of=
 the
+AD4- +AD4- packet is received.
+AD4-
+AD4- That's mostly correct, but:
+AD4-
+AD4- +AD4- If this is case, then messages shall not be interleaved even if
+AD4- +AD4- multiple application calls multiple sends.
+AD4-
+AD4- +ACI-locking the bus+ACI- doesn't do what you're assuming it does the=
re.
+AD4-
+AD4- When an instance of a transport driver needs to hold the bus over a
+AD4- request/response, it does acquire the i2c bus lock. This prevents the=
 mux state
+AD4- changes we have been discussing.
+AD4-
+AD4- However, that same transport driver can still transmit other packets =
with that
+AD4- lock held. This is necessary to allow:
+AD4-
+AD4-  - transmitting subsequent packets of a multiple-packet message
+AD4-  - transmitting packets of other messages to the same endpoint+ADs- p=
ossibly
+AD4-    interleaved with the first message
+AD4-  - transmitting packets of other messages to other endpoints that are=
 on
+AD4-    the same segment

Basically, interleaving of the messages completely depends on the I2C drive=
r. If lock in the transport driver is designed to block the I2C communicati=
on till the existing transaction is complete, then messages shall be serial=
ized. If transport driver does the locking in the way I have mentioned does=
 this in anyway effect the Kernel socket implementation (time out)?

+AD4-
+AD4- +AD4- Since the locking mechanism is implemented by the transport dri=
ver
+AD4- +AD4- (I2C Driver), topology aware I2C driver can lock the other
+AD4- +AD4- subsegments.  E.g. if a transaction is initiated on the EP X, I=
2C
+AD4- +AD4- driver can lock down stream channel 1. Please do correct me if =
the
+AD4- +AD4- understanding is correct.
+AD4-
+AD4- That is generally correct, yes. Typically the mux's parent busses wil=
l be locked
+AD4- too.
+AD4-
+AD4- The specific locking depends on the multiplexer implementation, but i=
s
+AD4- intended to guarantee that we have the multiplexer configured to allo=
w
+AD4- consistent communication on that one segment.
+AD4-
+AD4- +AD4- +AD4- An implementation where we attempt to serialise messages =
to one
+AD4- +AD4- +AD4- particular endpoint would depend on what actual requireme=
nts we have
+AD4- +AD4- +AD4- on that endpoint. For example:
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4-  - is it unable to handle multiple messages of a specific=
 type?
+AD4- +AD4- +AD4-  - is it unable to handle multiple messages of +ACo-any+A=
Co- type?
+AD4- +AD4- +AD4-  - is it unable to handle incoming responses when a reque=
st is
+AD4- +AD4- +AD4- pending?
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- So we'd need a pretty solid use-case to design a solution=
 here+ADs- we
+AD4- +AD4- +AD4- have not needed this with any endpoint so far. In your ca=
se, I would
+AD4- +AD4- +AD4- take a guess that you could implement this just by limiti=
ng the
+AD4- +AD4- +AD4- outstanding messages in userspace.
+AD4- +AD4- +AD4-
+AD4- +AD4- We have seen a few devices which can handle only one request at=
 a time
+AD4- +AD4- and not sequencing the command properly can through the EP into=
 a bad
+AD4- +AD4- state.  And yes this can be controlled in the userspace.
+AD4- +AD4- Currently we are exploring design options based on what is supp=
orted
+AD4- +AD4- in the Kernel.
+AD4-

+AD4- OK. There are some potential design options with the tag allocation
+AD4- mechanism, and marking specific neighbours with a limit on concurrenc=
y, but
+AD4- we'd need more details on requirements there. That's probably a separ=
ate
+AD4- thread, and a fair amount of work to implement.
+AD4-
+AD4-
+AD4- So, if this is manageable in userspace (particularly: you don't need =
to manage
+AD4- concurency across multiple upper-layer protocols), the sockets API is=
 already
+AD4- well suited to single-request / single-response interactions.
+AD4-
If we can manage concurrency in the Kernel this would provide more design o=
ptions at the user space, we can discuss this in more detail.

+AD4- +AD4- +AD4- Further, using the i2c bus lock is the wrong mechanism fo=
r
+AD4- +AD4- +AD4- serialisation here+ADs- we would want this at the MCTP co=
re, likely as
+AD4- +AD4- +AD4- part of the tag allocation process. That would allow seri=
alisation
+AD4- +AD4- +AD4- of messages without dependence on the specifics of the tr=
ansport
+AD4- +AD4- +AD4- implementation (obviously, the serial and i3c MCTP transp=
ort drivers
+AD4- +AD4- +AD4- do not have i2c bus locking+ACE-)
+AD4- +AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4- Serialization at MCTP core can solve multiple MCTP requests. Bu=
t if
+AD4- +AD4- the same bus is shared with Non MCTP devices, bus lock must be =
from
+AD4- +AD4- the time request is sent out to reply received.
+AD4-
+AD4- Why do you need to prevent interactions with +ACo-other+ACo- devices =
on the bus?
+AD4-
When bus the is shared with multiple devices and requests are interleaved, =
responses are dropped by the EP points due to bus busy condition.

+AD4- Cheers,
+AD4-
+AD4-
+AD4- Jeremy

