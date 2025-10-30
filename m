Return-Path: <netdev+bounces-234520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DCBC22AA6
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 00:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29ED3AE010
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 23:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E64633B96C;
	Thu, 30 Oct 2025 23:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rVZ9JkW1"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013021.outbound.protection.outlook.com [52.101.72.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8D320DD48;
	Thu, 30 Oct 2025 23:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761865904; cv=fail; b=CRX7d26+b45jkn7AgEH2NwBHr/Uwb9w1LCGPMNQ0hLVw13ICTTDbx22rfnSLTu7+3Zda/i4tSjrmwoCybgak4j3U7vMWDmrFsrAGgN3K+Kj2vFQ0AJBL66wYKhPc1FvKjmIayg5TAZ6pINaCSZLa4sqQlvTP1U3gSA9frfg7xNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761865904; c=relaxed/simple;
	bh=3yqziy35RfsR7Hp2oDCK9V2t0iP/A+zWpX47QbVYLY4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nNVXUxVuYl5UW+0IgO0PwNYh+KEfXQVa6ZtHW+GLRjYzD4++X9Ilk0pZ3z15yQokl8HOgAdLwIddJDcSUsCjWa4SS/LrnUdssGMa/Hr3/DKGvYx8lFY/Ztbz+c9X90YFcVZmAd5dOgyPfhDBUaQgyFRP0qBmMW6/01pVWpezKOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=rVZ9JkW1; arc=fail smtp.client-ip=52.101.72.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEG5C3r+7wRNfcl7lW5tiXSnFnbn/3MQidyidpaSVkqgrt47fTCIridlPYLiLkTTKUWaMLkWjcCeav3n54Sx7si70QWsHVGIAYd+PMZ4UnfeEA2fbq5/7lLdmm1XnCxEZPn30VSimb0a14AfdVcp/V0XtNbpq440155zlsDEuMYloo7T7F2at6WoCWRRkVLiZfdYgbD5DPB9HOmJMeZaiJaNggfu6Y+XyyK9ltWZkVlaGzuy7ENG/snGvrf/Ouy0AlaHCV4FJ5Tplcj0UNznXl8nN4v13OwmqCAy5AGIDHRsPrj50jtAWmOMwedY+G8gNlxtTsQfiTZw00e7khdDOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yqziy35RfsR7Hp2oDCK9V2t0iP/A+zWpX47QbVYLY4=;
 b=SKbyDAHxWtq0UDKurbc3tOE5o45/hQEAAUFvS2ZyW2YcjsqarbwN9fSqN+rgp1nBiO/NHk6OnjvfLviiGjfz7BgrDEAIADnlvf/vxl8Ujf8JYE3VZcwux3e0J7F58UTc3P4q4kCnrCy7jt8IeCcxW28y2pBVSbaB4h4J/Go/hIMXfOzvbCu8HoBmCBsAsL/58mYc90TgRFtDjQWjqXBkE0t6uHHiGkPtfpn9AEENPal2X2VfeCLtJlAMZTAioT+S1q8m70+fb7Oy5NENF/Kew+9Y/v5ztoDp/rClnVsQl/fEvzhukh15avLYxtsFNksbvSPina+YoMZxP8Xej2Qdew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yqziy35RfsR7Hp2oDCK9V2t0iP/A+zWpX47QbVYLY4=;
 b=rVZ9JkW1AsotduwMR63c6BtEg9vhpxetCw+aKcTTU5R4PfbQvetoidxZ89p61wA33DqV9StOTdxF9GuLu8NYupVyjQj0yIA10dR3V4saMaRhCCTpK9aZjKp0M/XjrWHG4POsWMHAPqklZgKy0L9r+qcgzbJ1AGmBCBNl7tBh1QAj3nyN6cYo9wG5dv0WDU+Pl/AAzJidSCjOzTTPyyvv7TO61Ifl5HFvP8DmVoJB9F0KaGOkhwlX3I3zerNjjLwCUL4BUs7FLwTjHH+JyZkn2zG3EXDyr5F+l+ahh8m23zwt8Y0w0Ghel4H7jss6Pf2V85r+mr24YmnzyGjcKIA7Lg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB9PR10MB7628.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:339::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Thu, 30 Oct
 2025 23:11:38 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 23:11:38 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "olteanv@gmail.com" <olteanv@gmail.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "robh@kernel.org" <robh@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "daniel@makrotopia.org" <daniel@makrotopia.org>,
	"horms@kernel.org" <horms@kernel.org>, "hauke@hauke-m.de" <hauke@hauke-m.de>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "lxu@maxlinear.com" <lxu@maxlinear.com>, "john@phrozen.org"
	<john@phrozen.org>, "yweng@maxlinear.com" <yweng@maxlinear.com>,
	"bxu@maxlinear.com" <bxu@maxlinear.com>, "fchan@maxlinear.com"
	<fchan@maxlinear.com>, "ajayaraman@maxlinear.com" <ajayaraman@maxlinear.com>,
	"jpovazanec@maxlinear.com" <jpovazanec@maxlinear.com>
Subject: Re: [PATCH net-next v5 12/12] net: dsa: add driver for MaxLinear
 GSW1xx switch family
Thread-Topic: [PATCH net-next v5 12/12] net: dsa: add driver for MaxLinear
 GSW1xx switch family
Thread-Index: AQHcSZCXaB6f1YuNi0uvpiLknDgJsLTbUfIA
Date: Thu, 30 Oct 2025 23:11:38 +0000
Message-ID: <3945b89128c71d2d0c9bda3a2d927f3c53b50c87.camel@siemens.com>
References: <cover.1761823194.git.daniel@makrotopia.org>
	 <229278f2a02ac2b145f425f282f5a84d07475021.1761823194.git.daniel@makrotopia.org>
In-Reply-To:
 <229278f2a02ac2b145f425f282f5a84d07475021.1761823194.git.daniel@makrotopia.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB9PR10MB7628:EE_
x-ms-office365-filtering-correlation-id: 9f493231-2e61-4605-f198-08de1809adce
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?ekZWSkxINTJuU1gyMHpURkFza0tBcUNXd3JiRjRXK3ZxbEZjNTIzTlM1S3gy?=
 =?utf-8?B?aEI3NmwwVWtuS3dBWTBXa3BjNzRPNngxSlBVTzFtejBBdFJEcHhXNXkwVVo0?=
 =?utf-8?B?UWRwYmE1ZjNnZWpRZUpEYUYydkRWT1FDWFlYMmlrZ1Z2V3hybzBSS3FGVjh2?=
 =?utf-8?B?VXpCVEpxV1RoRHE3SmZQQnhXN1I2NjU5cnZXVzZNbDFVbGNvcmdPZUpPKy9M?=
 =?utf-8?B?V280RndCS2JZcnl6ZXVnTmRKYzRoaFU5VCt1dlJZU0dmWjcrNG9aazZYaTZa?=
 =?utf-8?B?WWtNZ09XQlRtdjNuakNrbXBRSFMxMzlveGQyMmlSV2orNDJMeWlPMjZKRjlU?=
 =?utf-8?B?ZU5hR2tIVmxhRTRUTHQ1WGVPSlQzbFQ4Ly9MeU9LTUs1dW9ZcWlwbExPYWVt?=
 =?utf-8?B?ZXpmRjVvZmJUMDhpMFFMOFpqb0V3bDI5cGNaRWd5cklXMTlHdXFZQnVsQkpk?=
 =?utf-8?B?MmZ4cEZaZGxqQm1vK1FJOE0wV3EycHFTaE1vaUlLMnY4RTg2MHQvelFlWHZR?=
 =?utf-8?B?OTNYK3F0VUIvVGc1NFMyT2dhOHVWTmRFVVVBOGVWWDl1eHRlSWR5QklJcE9C?=
 =?utf-8?B?VUp6b1IvWVRRaGJVL0R5a2l4Y0EzdTYySlJmYitWdEZjL3BNQ3JvOU42Mk9V?=
 =?utf-8?B?TmJEdmVVU3VmNjlubnVvS21FSU5CM3pRdEFFRGdudjlWR3FIeFB0SVREck9O?=
 =?utf-8?B?VnI5VUNNSkh1QXJoaDVldnRZS0ZoektUMkhmNzVnci9mVG93QUIxcFNyZHpp?=
 =?utf-8?B?VEdzc1FaeHo4aWRldjZUaGVwU2ptOGRmUlIwaUFGbnlJNzcwQU1kak9tMDkx?=
 =?utf-8?B?SWpyUDFBZmd4bjU3ekMyRE9uV3NjRVNWSmpRT09hSjJ1R29BNmJyUFA3Q2d3?=
 =?utf-8?B?QjN1M3F5Ly9GcERvblBBelFvZHY3dUwxT0pJM0prbjFUMDlnUGVIS2hkem9P?=
 =?utf-8?B?R0hYd1ovVUE0UjFoTldqSHIxYXJicDQvQ1pjTUxnR04wVFEyaTQ3cUdYRWI0?=
 =?utf-8?B?MEp4dEY2UTAwMXZ6a0xORlFWOHpZNWhKaHdDeG9SMDV2MThPRDRqQzE0UzJY?=
 =?utf-8?B?RG9tbWJtN3VSRHAzeVZWSXNUVWFkMGE3SnBOQ1pZNVZ2RzJhUWFOcVF1RXI0?=
 =?utf-8?B?T095ZUFQU1VucnFZTnJlQlhPbzJIaTY5L01LbWtVOHJrNUw3UFdwNHdWeCty?=
 =?utf-8?B?dDhVVnJuYWxMNFJjVWxRNnNBQS83a1Rrb1lMWXBPMUM4dzdjbXVYQVpSTXRJ?=
 =?utf-8?B?bnRrS2ZyOGdrYmkxNDVMTDU3Z2hTcHJlUTZYbXlWRGFaZmo2cHlvVDhMUXFm?=
 =?utf-8?B?d1I1Z2grSFkyRlNyNjZieGtlQktqSlluNExtdktqcEtVaThlNW4yZS8wdEN3?=
 =?utf-8?B?emVPaEVBZEk3K2hkcEdENWFMWXB6TFNrSjdwVVJDUDJPUElVR2xwOHdWWnZU?=
 =?utf-8?B?QWhmNktWWm9ISmoxRzVVVXA2bW9qclI5V2tKMFRCWUVsNnVEWFRQQ3VOZDA5?=
 =?utf-8?B?RzBEdms2eFVWWEUvRStvNWtML0Nta2g5RnI0NmFrQTBQQkIySlloNkptSGVN?=
 =?utf-8?B?OWU5NmNNNTl1cE1wRUV2WHZWR1NEWjF6NFVycTNadmtvSE8xeWhlQ244Vlo2?=
 =?utf-8?B?OGRlZUl5ZjExZkcwMDV2MEtuOTFoSWNGMGY4WFdmRE4vVUpUUExyZVRIUVp3?=
 =?utf-8?B?R09JQU9xVG9XZUF3dStzZHZwUkI4TFA4OU5KZU82dUdrSkJ1V0ZSUWRqZ3Bo?=
 =?utf-8?B?UDVIQ1kzRE1JSXY5SFJPeGFtNDFaNGhaQUdnejFFN3l6Q1BuL3hUMGV5RXU1?=
 =?utf-8?B?QUkvMWo1TGN6MHlPMmp0VWxEOEoxWTQ3NTVsblN2RWF2Q0RRVkZKRHByRy9T?=
 =?utf-8?B?SnN2bC9HTjI3dThUcUdXRUdKSFdqWXpoU2ZLbXNYejgrVStoOVNXTlFYWm4x?=
 =?utf-8?B?N210Wm4vbmhQY2ZkdkY0VnQ3QTVzYk5ZT3I0WXVzOTMwZnNkVjlqLythaTEx?=
 =?utf-8?Q?K4Wa63Jj7AVfT9FDfQP2geblsV/ZG0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWtiK2hyWmY1VGFIbm5GMWZkWXVEMW1jS0ZvcHd1YnVja2svTktkSkRsdUo4?=
 =?utf-8?B?bkFiNm9WM29VdGtmaXlBd0Y3dEEzVm1sSjFxN2NBU0F6a3A0QnJNbjhLQ3RC?=
 =?utf-8?B?eHBxTzU0TXI4YXZTK3ZzbmFoYm9SOTlvbmlVMXJKYVExN1lWV21LQlRsOVVF?=
 =?utf-8?B?T05NVUpYSGtmMVVSQUg2Y25ERGFub2tHL0ZhNXdHN2hDSGs1Y0NjWGlBK01Y?=
 =?utf-8?B?RTZwMHBnOGsrS2dtVG9JcTJhQWcxT2gvSnc3MnZIV2FIUCszWFlEYWUzUGl3?=
 =?utf-8?B?b3NqdktuVDhmL0FHZC9uU3d4ZEpxN0ZFbWJ4eDM1dUtpSTE1a1A2WkgvdHVy?=
 =?utf-8?B?VkxFQ0VRVnF4WWYvUEc1cTRveWM2L01tQ21DNkNFamNwQ3VJb0I4Ti9WTWFM?=
 =?utf-8?B?QmFyOHIvNXV4Zi90R0NCVWFXVW8zeDB0NnBTakp0Q0VJYktSN3BteCs0RmF6?=
 =?utf-8?B?clpXRUVGa0RUWnVXT3JUN1lNMmpRMVZOWGh0THNRYVEwRm9aU2VPVmlSbSta?=
 =?utf-8?B?RlZQcE5qQ3p4V1JGRSszM0tWWUpCTnMxNW1LVllUQW41V0QrOTRUVjNhK3BL?=
 =?utf-8?B?Qlg0bHFweTdGQk5Sb1J5ZVVYUUpxUFYyUkZNUUhMdHJWS0g0c0UvOGdpdUZN?=
 =?utf-8?B?VnVVWTRSQ3Z4bnVJVkVsNU54MHRuMmZqTWRGclFzd0dMOTJjYWlVTXhqVGxw?=
 =?utf-8?B?YU1MZzlDN0pWbGJLMHVxN2RwTGZxbFgzK2JMZzBMMksvVnNmTEk0YjlSeHN6?=
 =?utf-8?B?VTZLd0hpZTVRMThWdk1ySm54V0NRWEd4b3B0VVBFNFNaRm01ekRKS0w5ODJu?=
 =?utf-8?B?UExyKzJVUUdqeHMrcnZsc0l1Y0dYcFMrTHJLME5oTVpjZ2d4KzB0UUthOURM?=
 =?utf-8?B?dHpTcTk5c0Y3VW9WZjEyN0pnV2FQU1FKcXQ2cU9sNHJWOG9pbnMvOE8vdm1p?=
 =?utf-8?B?aGwwK2Q2QzlOYy9SSVVsN2I1QVRUbklEMGZIZ01hZjFaRDJmZmpXSFo1L0NQ?=
 =?utf-8?B?Q1hqUTl3QlFUTzRhWmRmUzBqdHN3WWJJZEIzU1pPRVFxVyszNHJvQ083WXZH?=
 =?utf-8?B?RUp1azViRHhSVU9ENlg5UUE4eC9nL2NSb1dpTGZZL0tmeHQwNGk5L21yOGJJ?=
 =?utf-8?B?eXUxdFlEMXhsc0dValpZWDhqY1NmRmVSbmtQL2lrYmJlK1VkSU9SQXB3aU13?=
 =?utf-8?B?eFNPRlQxMlZYdkFhSFI5aTVXaDI0K1lDMlhyMWhLaS9uYTVGeVZQQlY5T2tF?=
 =?utf-8?B?SmdTV09ya2wxeFZmdzB6MGhEOGE2OG5xeklIMHJWY2FuZlZMNnlHSzR5UFpo?=
 =?utf-8?B?ZXBHc2pWTlNrbWVmME5pM1lhbkwySFcrYTBZYkRDSktsR3hEMC9WUUpqalNX?=
 =?utf-8?B?dml5M2VKSWNNSlk3YVFZbGh4T0NLVS9MdWhOamtUNUFGR1YzdkZFZlBDeGRi?=
 =?utf-8?B?a1Rza2tvMCt2N0V1cXFpTXNiTERmaUdaN29Ba3YrQURlZUozMjlYdWZNYStk?=
 =?utf-8?B?dXc1NjdNT0NQQVBhNmVWZllQcU81RWVVQ0V1TFRiNW5TK1VsS1UzNzhJSHhj?=
 =?utf-8?B?am5OVW5iV2ZOd0pjRkxOZndzVGhzaFphRDFkbjE3WTExMjc0Tk5rTENvM2RN?=
 =?utf-8?B?aWNyRHlESEVlNVVOMmVjdlVldUVTNlV6Q1UwVlZYOWIxSVRRWWplb2xkQm8y?=
 =?utf-8?B?RDZhaHZNVC9aYmVma0tRR1AyUWZUTU5Gcm5ISlZCWEFQellCZ0hzaHNnS2hs?=
 =?utf-8?B?RFFVc3EvY0tTVmNoVTBSMFhPQUdVRXcrQU1nUmdSQ3pScmpkaU5IWEdlR3NG?=
 =?utf-8?B?dHNsdDdSa2lPYTk3ZTJqVHlYK28zZDh2dUZhTkdlR01QNm1ndnN5a1dKZkw3?=
 =?utf-8?B?T0Z3aTR6cWpSSHBtUWZoRFZKMlA3dWlZTzR4a0ZDRGlNK2l2Mm05NVJaZ2Jp?=
 =?utf-8?B?S2hBYzhXaHR6S1JaTllEWklOY3ZpaElheEFUb29WajQ0MEVpTjloL1NzSGpJ?=
 =?utf-8?B?aXlUZEdHVExuOG9sVWpRa3I4eDFxSzF3ZTIrREQzbVArakgzcmplQ3EyWGFs?=
 =?utf-8?B?d2F1SWJWeGMrdjdpZFlMV1FnNTUrY0JQbWd0bEdURm1qVFNLL2l5WGEzN2FS?=
 =?utf-8?B?SUh5Zjl2UHJBTU93WEZTNWt6QVk1bTMxV2U1R2tXSytHZHhJNkR0dzNDcW5N?=
 =?utf-8?Q?LlVU8ITcMo+Onv4GBjdS69w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BAD347D3369ED47BFDEAB7D00183421@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f493231-2e61-4605-f198-08de1809adce
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 23:11:38.2455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sEacBRC7Tg/aMdDIxDjWAYVzCLFfAhWnt4YaQuxw6vPJF9c7lIiHAgUe3ngQSUmwCwqegiagWzKz5XpZhPkYAw80iMUgolByiSLuCvmMy70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7628

SGkgRGFuaWVsLA0KDQpPbiBUaHUsIDIwMjUtMTAtMzAgYXQgMTE6MzAgKzAwMDAsIERhbmllbCBH
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
YS5vcmc+DQo+IC0tLQ0KPiB2NDoNCj4gwqAqIGJyZWFrIG91dCBQQ1MgcmVzZXQgaW50byBkZWRp
Y2F0ZWQgZnVuY3Rpb24NCj4gwqAqIGRyb3AgaGFja3kgc3VwcG9ydCBmb3IgcmV2ZXJzZS1TR01J
SQ0KPiDCoCogcmVtb3ZlIGFnYWluIHRoZSBjdXN0b20gcHJvcGVydGllcyBmb3IgVFggYW5kIFJY
IGludmVydGVkIFNlckRlcw0KPiDCoMKgIFBDUyBpbiBmYXZvciBvZiB3YWl0aW5nIGZvciBnZW5l
cmljIHByb3BlcnRpZXMgdG8gbGFuZA0KPiANCj4gdjM6DQo+IMKgKiBhdm9pZCBkaXNydXB0aW5n
IGxpbmsgd2hlbiBjYWxsaW5nIC5wY3NfY29uZmlnKCkNCj4gwqAqIHNvcnQgZnVuY3Rpb25zIGFu
ZCBwaHlsaW5rX3Bjc19vcHMgaW5zdGFuY2UgaW4gc2FtZSBvcmRlciBhcw0KPiDCoMKgIHN0cnVj
dCBkZWZpbml0aW9uDQo+IMKgKiBhbHdheXMgc2V0IGJvb3RzdHJhcCBvdmVycmlkZSBiaXRzIGFu
ZCBhZGQgZXhwbGFuYXRvcnkgY29tbWVudA0KPiDCoCogbW92ZSBkZWZpbml0aW9ucyB0byBzZXBh
cmF0ZSBoZWFkZXIgZmlsZQ0KPiDCoCogYWRkIGN1c3RvbSBwcm9wZXJ0aWVzIGZvciBUWCBhbmQg
UlggaW52ZXJ0ZWQgZGF0YSBvbiB0aGUgU2VyRGVzDQo+IMKgwqAgaW50ZXJmYWNlDQo+IA0KPiB2
MjogcmVtb3ZlIGxlZnQtb3ZlcnMgb2YgNGsgVkxBTiBzdXBwb3J0ICh3aWxsIGJlIGFkZGVkIGlu
IGZ1dHVyZSkNCj4gDQo+IMKgZHJpdmVycy9uZXQvZHNhL2xhbnRpcS9LY29uZmlnwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoCAxMiArDQo+IMKgZHJpdmVycy9uZXQvZHNhL2xhbnRpcS9NYWtlZmlsZcKg
wqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+IMKgZHJpdmVycy9uZXQvZHNhL2xhbnRpcS9sYW50
aXFfZ3N3aXAuaMKgwqAgfMKgwqAgMSArDQo+IMKgZHJpdmVycy9uZXQvZHNhL2xhbnRpcS9teGwt
Z3N3MXh4LmPCoMKgwqDCoCB8IDczMyArKysrKysrKysrKysrKysrKysrKysrKysNCj4gwqBkcml2
ZXJzL25ldC9kc2EvbGFudGlxL214bC1nc3cxeHguaMKgwqDCoMKgIHwgMTI2ICsrKysNCj4gwqBk
cml2ZXJzL25ldC9kc2EvbGFudGlxL214bC1nc3cxeHhfcGNlLmggfCAxNTQgKysrKysNCj4gwqA2
IGZpbGVzIGNoYW5nZWQsIDEwMjcgaW5zZXJ0aW9ucygrKQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL25ldC9kc2EvbGFudGlxL214bC1nc3cxeHguYw0KPiDCoGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL25ldC9kc2EvbGFudGlxL214bC1nc3cxeHguaA0KPiDCoGNyZWF0ZSBtb2Rl
IDEwMDY0NCBkcml2ZXJzL25ldC9kc2EvbGFudGlxL214bC1nc3cxeHhfcGNlLmgNCg0KdGhhbmsg
eW91IGZvciB0aGUgcGF0Y2ghDQoNCkZvciBzb21lIHJlYXNvbiB3aXRoIGJvdGggdjQgYW5kIHY1
IEkgY2FuIHJlbGlhYmx5IHJlcHJvZHVjZSB0aGUgZm9sbG93aW5nDQp3YXJuaW5nIChBU1NFUlRf
UlROTCgpKSBhdCB0aGUgdmVyeSBiZWdpbm5pbmcgb2YNCmRyaXZlcnMvbmV0L2RzYS9sb2NhbF90
ZXJtaW5hdGlvbi5zaCBzZWxmdGVzdDoNCg0KUlROTDogYXNzZXJ0aW9uIGZhaWxlZCBhdCBnaXQv
bmV0L2NvcmUvZGV2LmMgKDk0ODApDQpXQVJOSU5HOiBDUFU6IDEgUElEOiA1MjkgYXQgZ2l0L25l
dC9jb3JlL2Rldi5jOjk0ODAgX19kZXZfc2V0X3Byb21pc2N1aXR5KzB4MTc0LzB4MTg4DQpDUFU6
IDEgVUlEOiA5OTYgUElEOiA1MjkgQ29tbTogc3lzdGVtZC1yZXNvbHZlIFRhaW50ZWQ6IEcgICAg
ICAgICAgIE8gICAgICAgIDYuMTguMC1yYzIrZ2l0ZTkwNzkzMDAwOTRkICMxIFBSRUVNUFQgDQpw
c3RhdGU6IDYwMDAwMDA1IChuWkN2IGRhaWYgLVBBTiAtVUFPIC1UQ08gLURJVCAtU1NCUyBCVFlQ
RT0tLSkNCnBjIDogX19kZXZfc2V0X3Byb21pc2N1aXR5KzB4MTc0LzB4MTg4DQpsciA6IF9fZGV2
X3NldF9wcm9taXNjdWl0eSsweDE3NC8weDE4OA0KQ2FsbCB0cmFjZToNCiBfX2Rldl9zZXRfcHJv
bWlzY3VpdHkrMHgxNzQvMHgxODggKFApDQogX19kZXZfc2V0X3J4X21vZGUrMHhhMC8weGIwDQog
ZGV2X21jX2RlbCsweDk0LzB4YzANCiBpZ21wNl9ncm91cF9kcm9wcGVkKzB4MTI0LzB4NDEwDQog
X19pcHY2X2Rldl9tY19kZWMrMHgxMDgvMHgxNjgNCiBfX2lwdjZfc29ja19tY19kcm9wKzB4NjQv
MHgxODgNCiBpcHY2X3NvY2tfbWNfZHJvcCsweDE0MC8weDE3MA0KIGRvX2lwdjZfc2V0c29ja29w
dCsweDE0MDgvMHgxODI4DQogaXB2Nl9zZXRzb2Nrb3B0KzB4NjQvMHhmOA0KIHVkcHY2X3NldHNv
Y2tvcHQrMHgyOC8weDU4DQogc29ja19jb21tb25fc2V0c29ja29wdCsweDI0LzB4MzgNCiBkb19z
b2NrX3NldHNvY2tvcHQrMHg3OC8weDE1OA0KIF9fc3lzX3NldHNvY2tvcHQrMHg4OC8weDExMA0K
IF9fYXJtNjRfc3lzX3NldHNvY2tvcHQrMHgzMC8weDQ4DQogaW52b2tlX3N5c2NhbGwrMHg1MC8w
eDEyMA0KIGVsMF9zdmNfY29tbW9uLmNvbnN0cHJvcC4wKzB4YzgvMHhmMA0KIGRvX2VsMF9zdmMr
MHgyNC8weDM4DQogZWwwX3N2YysweDUwLzB4MmIwDQogZWwwdF82NF9zeW5jX2hhbmRsZXIrMHhh
MC8weGU4DQogZWwwdF82NF9zeW5jKzB4MTk4LzB4MWEwDQoNCih0ZXN0aW5nIHdpdGggR1NXMTQ1
KQ0KSSdtIG5vdCBzdXJlIHRob3VnaCwgaWYgaXQncyByZWxhdGVkIHRvIHRoZSBnc3cxeHggY29k
ZSwgYW02NS1jcHN3LW51c3MgZHJpdmVyDQpvbiBteSBDUFUgcG9ydCBvciBpZiBpdCdzIGEgZnJl
c2ggcmVncmVzc2lvbiBpbiBuZXQtbmV4dC4uLg0KDQpJIGNhbiBzZWUgdGhlIGFib3ZlIHNwbGF0
IGlmIEkgYXBwbHkgdGhlIHBhdGNoc2V0IG9udG8gYmZlNjJkYjU0MjJiMWE1ZjI1NzUyYmQwODc3
YTA5N2Q0MzZkODc2ZA0KYnV0IG5vdCB3aXRoIG9sZGVyIHBhdGNoc2V0IG9uIHRvcCBvZiBlOTA1
NzY4MjljZTQ3YTQ2ODM4Njg1MTUzNDk0YmMxMmNkMWJjMzMzLg0KDQpJJ2xsIHRyeSB0byBiaXNl
Y3QgdGhlIHVuZGVybHlpbmcgbmV0LW5leHQuLi4NCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4N
ClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

