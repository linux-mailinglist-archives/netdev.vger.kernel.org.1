Return-Path: <netdev+bounces-72964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C47685A6D6
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 16:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8891F2151F
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 15:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A550F38396;
	Mon, 19 Feb 2024 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="kubRPGpm"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73A637716
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355093; cv=fail; b=F+3SciT92FTFNuOkeYtdaSIli1nqoDuDnFTYxzxms3m4D/v7M60b3vLWuS0fjHIg4V61O5Lfgin/GK8f/3HQ3D9HolyVcT7aqcaULsxe2Qp5567HSbrclQsFzuRhE2Mih0VGSX9e2lZK4U0DLGLFG7/UWTLukL6jeaUeEATrIUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355093; c=relaxed/simple;
	bh=ahBX7CjlSYyEGX5mMX2iAYxhCSolSBesKgme0aktqaY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NPe1t5/GJZQ1wWvXe3EWVvpU8llMXnqJOUVfYcQ/KVIFL8ztfAh1yhtqJnN7mD5xQvnkEqJOTI6MTUYN3pCg2lF5sBiFZ0iAWxuR7e/UlmXt+TbYDT/nTUONUrFFiGuucRaeQHdQJibjdxfBxdtq0j5TsiqUvXMm2H1HMh54Lyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=kubRPGpm; arc=fail smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41J8l0x6003654;
	Mon, 19 Feb 2024 09:16:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=boJI2J7Hib2ANMiIZYCNxCBzNRAe0cVWc4LMuG48EYA=;
 b=kubRPGpmH2nKgXsrOBlunhmAmnDLWU5EYmGYAMdm58FPx9U+uM3QPZdal8HLpeUeWKsK
 yd8EJtWCL6R8hLgxCCDv1UJYd62+RO3mxgEPxqqWGIOWdgLmY4QQSK8DxCMIsq/XIbmN
 LU/Gw8eBBYemJFC03YgPaRSEYnEuPKg1gwieQVs+9NIhGcAghXFUPbKOOcBdRmApA3ge
 CtkSgUy39EgWSOBACaj95QTC1dExamMtdonbqUKNUj1z977KOHHmpMHR6y42gfuCEOoD
 9im31LVbK1wfvOe6OTK5/8btHqTH8jqfNw/aCZ3vxsPD+wk8GOMX4RmTxDAL4C2gnqYI Fw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3war8bfgr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 09:16:48 -0500
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JDw1kG029314;
	Mon, 19 Feb 2024 09:16:47 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3wc8a18d6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 09:16:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVDH5tQkAbZdLzM2n/1Unglg+fSoxB6pgq0l/Rhf2D74kbaH/0p4DOIsDebd1jNkmceQJYdnaK27zCSsWF5VEgU/IVTiD0b14rxPOiMv85FnD3++/jJSefEnfogEHxU+viDKIQiFsVhO2eibADLdbxJYhUvg/q/nbgcs5TSxTJFGFOZ9PE8yke3xY4QWr/Usd4cfccvSWt96eg1sUZMs9wcH1Clju5PTZxPpziEOUticgwEzdp1qmlWQc6i+ugvrWWclde284s2zYTO6bYXzo1+L1Gpq1ka7OEnMRkRItWpWUWXEWROLe6xw2x/IktC1FGI+1tp1rr6H+R4s3fTSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boJI2J7Hib2ANMiIZYCNxCBzNRAe0cVWc4LMuG48EYA=;
 b=MLm5DvCVRFwEGwwofv4eWdW/JzHh1RNoX1Ql81nRvTTcxYsTDxT/YW6YFT7Lg1sOXp9Vk8ZQB/fwO7KcmP8FO9E9i14INOZI2sJ2LjSpN4kCg4EwPzFgIUJVLYrCFCN1GJzL12vrPCtXlQBLx5kP2Kr1c7si8VP5QhsCTb458Q226zcPCwGSMehedj2bi9Xuh/nnGnh2sBfgXQr6QCGJ9FxE+Qqv79jC58nNENQDWmg6HjRQ2WR2BVxz3VA6QcHEdCGtMkbrrQ0egjl/QSEDfOZ/8RodLQpn2Rql2Ed3ZQeDUdcL+zO52ip3UGkgHb0PF1yMM/rhHj1ea0rcAAtXjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4415.namprd19.prod.outlook.com (2603:10b6:a03:286::17)
 by CH0PR19MB7933.namprd19.prod.outlook.com (2603:10b6:610:188::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Mon, 19 Feb
 2024 14:16:42 +0000
Received: from SJ0PR19MB4415.namprd19.prod.outlook.com
 ([fe80::5707:d1a7:932a:1f45]) by SJ0PR19MB4415.namprd19.prod.outlook.com
 ([fe80::5707:d1a7:932a:1f45%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 14:16:42 +0000
From: "Ramaiah, DharmaBhushan" <Dharma.Ramaiah@dell.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "matt@codeconstruct.com.au"
	<matt@codeconstruct.com.au>
Subject: RE: MCTP - Bus lock between send and receive
Thread-Topic: MCTP - Bus lock between send and receive
Thread-Index: Adpg8C5ifGasYxkxT4mqclzjy1NmXQARbn0AAIIPXGA=
Date: Mon, 19 Feb 2024 14:16:42 +0000
Message-ID: 
 <SJ0PR19MB4415E78B5C71405579E78F9987512@SJ0PR19MB4415.namprd19.prod.outlook.com>
References: 
 <SJ0PR19MB44153C87D151BA76C93DD289874C2@SJ0PR19MB4415.namprd19.prod.outlook.com>
 <86a4f9a9f1cd6e47b2e85731d5d864644ec25bc4.camel@codeconstruct.com.au>
In-Reply-To: 
 <86a4f9a9f1cd6e47b2e85731d5d864644ec25bc4.camel@codeconstruct.com.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=4070360b-77a3-428a-8465-691f9cb6f7d8;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2024-02-19T14:15:53Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4415:EE_|CH0PR19MB7933:EE_
x-ms-office365-filtering-correlation-id: 11a621bf-3b0a-47aa-b1b9-08dc315565a1
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 njJYXuPXK0yXaqM3qbXAAg8sm8kzTfYYS0kyGfXmkRfax3AuYIA/FxJ/rqtEdVu1Fa8zHxzi+YVeOKfY1xZpGEPhPC6L9Vs3TIEwW5WIb8yjtXx7XIlOGGOJz/h0mAfUopPEA3Qa5+AT4pjafCCX+TW+xo45hHMdV0BHhV84B9F/WxZ1pSiXgzh9PNynLrrsiQ/dTZUXIZx+GuYhuM4HdNh/Y+bUNQcxhW0bmmpnROTJp3C4BEL08aaQz9iE5lyyRhvRSID7fseegrkFbMQT8mhnNSrh0eOU/2Rap1DaxFlq1ED3a94+PLvDEn/WT1bF72QOoFnBP7Yzycq8DFUrUSaPsopuVD3wFg5EuyzvvXFNYkmnmgFaFs8xu8TnuIdNAqbD24UrR4upuW1SHbiwUpJQ/QWMkcAsQKJKWNIwk19gs2mGeUwVQdlVkVK0E5EDpH37LcFBWUWvgely6IprQnWWSDS3L98lSjc/Po579TMrNNgroz+at8iCCYhKhltGtTl2xw7COGCxsAJVaLCFMBQYCdbSf4sc/P59iNoSTZaiYksATCfD7pNoBtXkkgniTA31d2y2JlXw5jHIq5HMr7OS0aE2e6iPZLuKayHJ7KQ=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR19MB4415.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-7?B?NzNpdEVYd25EZEcrLTh0c1lIejVwaWt3NzZ3RXp2Yk0yMmNMcVc1ejFHYTFW?=
 =?utf-7?B?SnM4cGwzQjlhZkV4RlJmT0swRG5hVEZObldGRXYvUUx3b3R5SDNsZjNoYmFS?=
 =?utf-7?B?Zk9BRFVUS1BtQ0llKy1wVWhLMTQ5TW0rLVl6WnhQVWlWVUtEcWFWdzBxOWRQ?=
 =?utf-7?B?bGY5MEJ2YzlUZUE5V2hHdE5tOUxZMkxYMEVWYXlmVTB5dGlQOFZWOXIyZ1hX?=
 =?utf-7?B?bDAzUTlpUDQzYlFBVG9pMVBIVUdveVRIck51VXpHMnFXV0lOKy03bXhGMjhS?=
 =?utf-7?B?Z2tKNm1TdHZFbTRRaVdaYXRiQ1M4VjQ0ZHZLb3oyd3V2V09tbDVGN0FaZDhv?=
 =?utf-7?B?R09aSm9oVEwvcU1oL1pldkFnVkxTQmhrdm9zZ2pZdVVoSTlWdXE0eFVFVW1U?=
 =?utf-7?B?QldLUlMrLXBJT3BqSXJqdlFxWTNHay9HWVkrLVY1S3RQdDloMjRlbEtRVmo=?=
 =?utf-7?B?UCstZHpzaHo5R2VqTk9YODBYS2dtd21WMXVhRk5UMzVoZ25UOTZXZVJZZzRB?=
 =?utf-7?B?N1FwZk54SHQ1aEJlMnUzcEtHKy1pY0t3NDdmVEp3Mk1FVFg5eEJLTjdQSm50?=
 =?utf-7?B?Rnhnak1LS3ZmeENVRkdxbWRzZVB1aHBkL1BtNzF4UDJST3NDaVZYSWNBYVBL?=
 =?utf-7?B?ZkZscGZCRWlvdnBEaHUzcjhpUWxSQlN0Tm16MjZZWElMOEJhd3pCTmcrLUlk?=
 =?utf-7?B?NnUzNE9RYVNOWEdYMVpXRERHNWszdistbmV4Q01kejZkaEczQ2tBVkFSNzJv?=
 =?utf-7?B?TkdSQU1nNDI4d0R5eXQyU0plL0grLWY5Mk1DR1pyejUvYkpOMFVsaGkzQ3Nr?=
 =?utf-7?B?Qkw1VnFBRW1rKy0zYk5lQ1l2TXNvNFUzRllOSTdmTHB2NnJuaVJiYVJhRFhW?=
 =?utf-7?B?Y0VKN1NWdFpISHRWNElnZ2w3N29iNlBaSy82MWhiKy1IdXc1NUZOQS9PWWds?=
 =?utf-7?B?SjduTW15MzZ4ZjNQeHl3cDA5elhIYjJ3UVBYVTJFYTVRTk50bWtUN2V3ZGFn?=
 =?utf-7?B?YTZNTVo1QXdzUWJWNmtENVhpVmFKTG82dHVIazllcVZLejBtb1FrOXFlVmlj?=
 =?utf-7?B?WGdjU2RCbzQwWThqUHpDVUpyOXJoVm9kcTZRTWtGRHJpY2R3UmRRUksvelZP?=
 =?utf-7?B?QmhjWDFtWW5VVVU1Y1lXYm50ektGemV6WnRORmU0UjVTT2prbkVFeWxVaWJT?=
 =?utf-7?B?WWVDTUExUno2Q0ZnMENvdFFFdCstNVNTZWpWemVDV3NCdUcrLWE5ZUVwUWda?=
 =?utf-7?B?MXlmQktSdEsxRndLcHlla1ZlL1ZNTkp6WGhlcUdnNkNJWWtoeVE3Z3EvR2E3?=
 =?utf-7?B?MUZBRmJ6dkNIdHR1WjNmdTNBb1psWi9HR3JWR1pYdXpYZ1Q5UnJoQXNJejRu?=
 =?utf-7?B?Uk90bHJEbVM2dEVvajBOOGhQd3RENzExUjlFUzFnYystRjNKY3BSNzZweGhO?=
 =?utf-7?B?Y1FzSDd5c0YvVHlBRnQyQzhPZGc2VisteEFidHpMOEprWDg3SC9RUkpCWTNS?=
 =?utf-7?B?T1ZNbTVjVzFrdVBMM1g0TjA4MlhLUlZZM3hqMlR6V3hZOVpFVjlOazI3d1I2?=
 =?utf-7?B?UlFFV1IzOSstM1l1SFJ1QWR4UmJ2c0h2VTQ1VHFZVUN4cURvTURCUTVNOUpz?=
 =?utf-7?B?a1NHUHJBOEdZRWpvOXBTMGJEOUtkUXplY3pVa2l6UVdsbmcwdkxuV1RTbEp4?=
 =?utf-7?B?NnM5aU5hNlowYi9VVlMxeTRzKy1Ob1FuaElmcXhnL2gvMW44M3I5cVRhYzJy?=
 =?utf-7?B?ak5RSEVETUtsc2MrLVZncEFKdWhXQTVrTUFYZWhmVG1JUEtVaVl6YkxhbzE=?=
 =?utf-7?B?aSstMzA0T2VBKy1PRW9uYlluQ09aTkJSKy0vL1RMTU4zdWhmN0NTUmg3aEdY?=
 =?utf-7?B?YnBpQXh4aVRXOHNNVUhyN0NFbUdsT0RNTUd4YTJMVnFWdjMzdWxOcHplSi9Z?=
 =?utf-7?B?eFFLYSstUUsycEhHTExtcy9UTmpvUHpuNHhnRistbmg3Ky1YNUsvUnNLSzZF?=
 =?utf-7?B?Q2lDc1JWMVRjTmJKclF0VnJCbG1DVTR6MSstZEErLWJWMnFaUlNuOG80czdZ?=
 =?utf-7?B?Vkh1MUpBZFl6R0lMa3VZWmg0Q0hyM01wTU96ZWVMRENsNVN0cXExVnVMbkNa?=
 =?utf-7?B?WWlGT3MzKy1BUDl1OUh1YkNiamNPZlRJeEEwM3p2eERrTTZQZnNKRjg4QXIw?=
 =?utf-7?B?WEFtQWpRWC8yQjY=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a621bf-3b0a-47aa-b1b9-08dc315565a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 14:16:42.6441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 89mvO8wrKcdEVR1vjYu3ocUm8r7ZU1b6odz3J46ShWk6V2fAslKXG6AcGLk6quN5iWxThC417PC1Ir0SYA3b3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR19MB7933
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_10,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402190106
X-Proofpoint-ORIG-GUID: e96hxsyhYjKpuVj9t4Zj4B4nzExrdVnB
X-Proofpoint-GUID: e96hxsyhYjKpuVj9t4Zj4B4nzExrdVnB
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 clxscore=1011 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402190106

Hello Jeremy,

Thanks for the reply.

Regards,
Dharma


Internal Use - Confidential
-----Original Message-----
From: Jeremy Kerr +ADw-jk+AEA-codeconstruct.com.au+AD4-
Sent: 17 February 2024 05:42
To: Ramaiah, DharmaBhushan +ADw-Dharma+AF8-Ramaiah+AEA-Dell.com+AD4AOw- net=
dev+AEA-vger.kernel.org+ADs- matt+AEA-codeconstruct.com.au
Subject: Re: MCTP - Bus lock between send and receive


+AFs-EXTERNAL EMAIL+AF0-

Hi Dharma,

+AD4- Linux implementation of the MCTP is via sockets and is realized using
+AD4- the +IBw-sendto+IB0- and +IBw-recvfrom+IB0-. Requestor intending to s=
end a request
+AD4- uses +IBw-sendto+IB0- and the response is obtained using +IBw-recvfro=
m+IB0-. From the
+AD4- basic code walkthrough, it appears that the i2c bus is not locked
+AD4- between the +IBw-sendto+IB0- and +IBw-recvfrom+IB0- i.e., bus is not =
locked till the
+AD4- response is received.

We do take the i2c bus lock over the duration of the MCTP request/response =
(or timeout if there is no response). Most of the logic is here:

  https://urldefense.com/v3/+AF8AXw-https://git.kernel.org/pub/scm/linux/ke=
rnel/git/torvalds/linux.git/tree/drivers/net/mctp/mctp-i2c.c+ACo-n483+AF8AX=
wA7-Iw+ACEAIQ-LpKI+ACE-j8A9vrL45XMbUzdOWjkdRqBoFoPVYG3HQqorpuNpk8Y2xXZfDufp=
8rrzJeQfQ3pzWfoY2si1o7ltjgI6yc8+ACQ- +AFs-git+AFs-.+AF0-kernel+AFs-.+AF0-or=
g+AF0-

+AD4-  This presents following problems.
+AD4-
+AD4-    1. If multiple applications are communicating to the same device,
+AD4- device may end up receiving back-to-back requests before sending the
+AD4- response for the first request. Few of the devices may not support
+AD4- multiple outstanding commands and few of the cases depending on the
+AD4- protocol it might throw device into unknown state.

The bus lock does not exclude this. MCTP, as well as some upper-layer proto=
cols, have specific provisions for multiple messages in flight, and we assu=
me that the devices will generally behave correctly here. If not, we can ge=
nerally quirk this in an upper layer application.

If there are misbehaving devices that require special handling across proto=
cols, we could look at implementing specific behaviours for those, but woul=
d need details first...

+AD4-    1. Consider a case of mux on the I2C bus and there are multiple
+AD4- MCTP devices connected on each mux segment. Applications intending to
+AD4- communicate to a device on a different mux segment at the same time
+AD4- might mux out each other causing the response to be dropped.

Yes, this is the primary use-case for the bus locking.

+AD4- Is my understanding correct and is this a known limitation of MCTP on
+AD4- Linux?

No, this is not correct - we do have bus locking implemented.

Cheers,


Jeremy

