Return-Path: <netdev+bounces-141386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8009BAAF7
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 03:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CDAC1C20B61
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 02:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BB415B987;
	Mon,  4 Nov 2024 02:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ixnNk6I6"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F120C2F5A;
	Mon,  4 Nov 2024 02:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730688084; cv=fail; b=ruwsAxKcldVI9uImslP6KSunnHkNiSSTOQy1Fo4/WZRqLHucnEz95x4Hr6fJunvFub84+g+f+1UhBilljZdyH+X2C0CYuu6tFOfOqFVtRz9eGXBRPCZLIxzklL91a2GuBoZ/8mijNyL+To3Kou2P1JpnQwvhLWnXckUMgBwueuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730688084; c=relaxed/simple;
	bh=miUkxkvRHRb8lLNNqUC5gouDgYaAXNkYUTULGCIhGJg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eySNIWQyJDz6ODjysYT0yERoZVKbZZcrV8v4iUQ9zlphwmUeErnO00Ck1+GPtj1hqOOOF4dVDBdj88t608q9/pOJZhvJ2YgJyw0UFRmQqkUPds9ENwtZfhStEK8GNEcZLJY0Re9Jyc6xzUVJb8JiZNmmEAQqpeOyNsDJWrTx4Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ixnNk6I6; arc=fail smtp.client-ip=40.107.105.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRlfa3CoycoqQUFtJLCtOVHs/q2GcIz3NKbok8Vk3PvHMNCpU8hEfiWWewSBYsIwgnc/kOZZUIGGl6NRzN5PcWoDfGhfMjJbspEEgUedi9EDteGk6n9k09rUVxAqchcEF8144mKWQaesnXaeEfCic2TfiUpA53EOsmCN3wCR2SZqFqUENwiJQWv1rcfAuIj3TD/7tqZWcfEt36Au4qt+a428kYohSTkzJEldvqykBml3sVeymXvgnYaEPDJ3+F3tvKSgwZ73SE0CSzGc6OUf1Tapg8APqrbiIZqGnrPdRt62+nHCP2il5jLh8BuIJYe1krfhNDMtFTP+b/CzHqHFxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miUkxkvRHRb8lLNNqUC5gouDgYaAXNkYUTULGCIhGJg=;
 b=rEe5WzmbNTTbjsF5ZrboeMyT7d5TfTtZhgL92EhTKTJSynghNPpyopECHic1In4sbp9FCWLqTJ58BUlXNLs+FbOBtwcj7ED3a7AfWtp9iYUG8oTK4I5F7bqOprHJE5OEphjUO7qzNsKhToOA2pDjMSUifSS5QyKdDCC4pMiEPjHIYcufr1Rcz6Em0r375LxnqDnYUAu5R0WWi2dVlfx5FJ7ByZndUH033uKSj9sjvQq1/lLKYCxqA/iNEeAcZGDmruMeof5WussRdKy1bVxqSE0GhE8Mq1Lp2y3TeGWuBbeItx6iD8qiuBQj1Cx++8GoFxskqsxwZKGGsnC25Tqe8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miUkxkvRHRb8lLNNqUC5gouDgYaAXNkYUTULGCIhGJg=;
 b=ixnNk6I6XTjiXce0kX9vSF1mnw1cevt6+v+LRZoEyjXsfSUgm3RlipZDe9kvSw/T7/WLZ7t8pfZXPMudCjFijAZWcHwak60a4FH86Sbw7Z9AWz0PSQIGo4/6xgL5lGrR5L7kM+usZV0XxcVSQYDfhSULcwUZb+oYdbmMISnAosToyEaPVrPtJb6+1XO2ugETw3oePBhJ9SxWyR4o01hrZqfQihZjAOfcdTDtycQZmQG0tnsIdiyG9xI5Zsy7flUzGL3UXtsLog0zSIWEjugTgWhIILM7T55zv2Z7aGPzUZcgjlShxVJmOdcgLYC10sLCEppMZXWLk9vTqU5u36DKsQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10698.eurprd04.prod.outlook.com (2603:10a6:102:492::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Mon, 4 Nov
 2024 02:41:18 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 02:41:18 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net 0/2] Fix issues when PF sets MAC address for VF
Thread-Topic: [PATCH net 0/2] Fix issues when PF sets MAC address for VF
Thread-Index: AQHbK1yeDe4ZejdFvUqPmab83DIwz7KmDVQAgABXPkA=
Date: Mon, 4 Nov 2024 02:41:18 +0000
Message-ID:
 <PAXPR04MB8510E1F902CE9F68676D7E6F88512@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241031060247.1290941-1-wei.fang@nxp.com>
 <20241103125034.27c43c51@kernel.org>
In-Reply-To: <20241103125034.27c43c51@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA1PR04MB10698:EE_
x-ms-office365-filtering-correlation-id: b24a21cd-7a95-4cab-668a-08dcfc7a28f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?Q2RhKzlLMU41T2VoNS9XMENwbmpyeVdxbEwwUW5kNjdFb1BxK1RrZUlveitu?=
 =?gb2312?B?ZXlEVFNJTHhhQWdyTEFkREttTVFlTDJoNWVaWm1zRXowY3pmWEZ6aTlZTCs2?=
 =?gb2312?B?N00vM0RyOHdLdXlaMG0vNHcrZmRpczl3V1hsOWV0NkFXUGNMMU9VdzdGY0JR?=
 =?gb2312?B?aUExSE92bFBOYVY0cWZCQll6S0tCR1FTemZmK3JQVnhYOE9BNW1IUnkra1VR?=
 =?gb2312?B?UmxlUytUVUxpR1h3ekJnQnpyQ0RFd0RZcVI5TVpCaWZWSm1FTEozOXlqZTVU?=
 =?gb2312?B?Y2s4VjhXa2xidldWbVRFTmtnY3lUV0F6eDNOWWpjY0dBT3Z4a2F1UkpoZHox?=
 =?gb2312?B?YUZ2US9lMysvTXNxRkJDUlhWaTNYUzduZXloSktBeDlYT2Q0UnVrMDVvTk9k?=
 =?gb2312?B?NWJvZDByOEEvQlFSUkNoZzJmQjFhT2c3ODY1TFRiZWs1bTFGaUFNQVcwK0dX?=
 =?gb2312?B?RjhGQXY2d3UyVENPdHJzRzlLNnVsNEhmSjFHaGN1WjZqdW13MGxDeFhMZGFP?=
 =?gb2312?B?UlF3NmpCQU96bWhBU3pjTXp4bU9wUkdabnVYd2xIQkpKT0dZV2RaOUxRSXdz?=
 =?gb2312?B?S3FaaFphV1RmOHBIV0ZKL2dRa3ZjTHRJd2JTd0gydmRDMGFKRGM0b1RlanZW?=
 =?gb2312?B?V1dqcXBrTmhEVGFlYkF2TVUxOWZwQkxBSXhFVXQ1VHV1RTR6VEhZVUlkNkJL?=
 =?gb2312?B?TVN1QjV0UFdtcHQxSm83ODl1VVcrcnBOWkJybGFzYXdaNzdXdkw2SnkxWVZY?=
 =?gb2312?B?QlpjOTFCb0FkbDdYb3pqTHFZZlRwdnhRdWxUcGNIcjZ3aWNCQ1RmT2pqQ3A0?=
 =?gb2312?B?ekZBQ3dDVWg5RldURUdYY0srQmIwSXZXOWttSHJrdWorZnBqaDVyRnBiT2RG?=
 =?gb2312?B?ZUNkclpnRzJsU1VPUFhFOGF4VzZ5clMvajFIV0ZKRlAzeko5bTRObnRWVkhl?=
 =?gb2312?B?bExaOFhRZklhdW1TNkdZYzVkL3ZoNStnakF1TTdwRWVqTjg2akJtcldsV29S?=
 =?gb2312?B?dXl3dG5vQmJMRVhuUDFtbUV2OFIrZGVvNUdRYjA1Y2ZVY0dZYlJ1dW1HZWRh?=
 =?gb2312?B?Q2M5U3dqN3FvRWQxb1NsakM3cFdjemtyRXZiQm43ODBBKys0ZUFzM1lQNXVx?=
 =?gb2312?B?RlRRcmZzbXFqbkp6eWRFKzJ6WEE5SS85QUpiUkZaMTd4TDRRSGdQK252U1FX?=
 =?gb2312?B?aWduRENsZ0dJT0pndWJDeGhuL2VUNHZCdHMyNXNncTBlZTlxSDdFd3JFUXNY?=
 =?gb2312?B?ZmVINW16Rkc3MjFPakh4MzA2LzJlNDNvME14Z2N0YTRqdnNxVEU2Nm1FdlZN?=
 =?gb2312?B?NDF5TVA4b3NDRVRYeHJ4WmZNRUZYR25qb1N3NXgyRmIvWlRySmVMN3B5T1V4?=
 =?gb2312?B?MGgzcVNPOWd5eUlWejBzWHhtUlhvT0luVjJmWnR4Qlp5VXlGbE9qUGJJblV1?=
 =?gb2312?B?Y3U2MHAxR3JwRERrN0RJSHJrQkkzSU9wQUg0UVRYMG1BZWhzSlFBYkd5dDl0?=
 =?gb2312?B?aUx3bDJoZkNtb3BVU1J2S091MVAwc0prTGVtbFV3MEpsTFJwQkJnSEp3c3px?=
 =?gb2312?B?R21wM3pBT21ZMGJwL01GNlZOZEtUYkJWczJrTk5saXc3V2xKNXlETUQ3RDU0?=
 =?gb2312?B?eW5XV1VsSllQeVdodU15SGowOHVKRjV2STcwWGVMamdEWk5tUDlRZFFjS0lm?=
 =?gb2312?B?V01tU01mOHpZd0gvRGZ6anhuNzloak1LT29kbzU2SWNEamhmb3htVkZIbUpi?=
 =?gb2312?B?TkNOVDJiSkVPYi9PNkFyZmJ5eGdUSG9qYll0cWt1c2ZQc2JoeDdTNVJWanlk?=
 =?gb2312?Q?CuNcnOesvWHtykkMqYpD1061roQfVYjWiFdjs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Mlprb1UvTUI2WWs0LzdOeFNmNmNwRWxSMU1PV3k1T0VQUThrMlZwTEN3emVl?=
 =?gb2312?B?OGtickhIMjIzbWliSmdMT3AvR3pMQnNUS0tMZ3hiNnpLSC9aTWVTdW8vSExU?=
 =?gb2312?B?MjlYNjYvSlBoV1dXcGpjSHVOS3AwSVFNMDJ1WGw2T1psWmFlVnBXemhaRCtV?=
 =?gb2312?B?NkxqNW93NFh5dSswTytPdDIxWnAvaTdoaGkrd2Q5WWk0NG0rK25zMWppWWQv?=
 =?gb2312?B?d0FqU2swMU9pYnJKN29vOG5LazdvOUJ5WWd3U0JVcjg0eFYyNCtmREMwUmxX?=
 =?gb2312?B?eXZMVVdxV1BLZys4dFZGWUpOR0ZwY3VUb2dWQTlncTRmV1llbU56Y2RqZVZ3?=
 =?gb2312?B?T1NPZmo3bDEramZkbXI5em9zYmFkV0dnVUhvMHNPbjVPdWFTWGxDZklwN3c4?=
 =?gb2312?B?NkhHK3g2YkgyZkxTdXJmVStneUdXTFBpd0hFTS9Nck10MDRxSXo5MkJQdzhU?=
 =?gb2312?B?VVFtWGJFSjgvTGVYRHJ2ZHBlc09GK0RkOEREWVZrbmxDRmNoNXRzM21aWjhN?=
 =?gb2312?B?c2RnRlFIY2gxb0h5UUhzQ0E4VjVjZDhMRTVkV3JzbkFkODdGNkoxM2dpRTA3?=
 =?gb2312?B?MmpEOHZsSG5YTUVmWDVyZDhEZmEyMmsyNlRCNHZkdFBkRnVmbmZtU2Zsbytu?=
 =?gb2312?B?eWdEejFDWmxyeW50NWNucWNHU1JIQUU2enFLS0ttcTVwblcyMUdpZlRUUG9I?=
 =?gb2312?B?SnJsbk1GM0VEbGo1UzNHT1VRd2E1WDlRMmZ5ck1IZFRXb0JKbTNDdTN0THQ3?=
 =?gb2312?B?alphM244UUJBNkg4Q3FBRHFKOVlzYW1BT2xVdWlGa0NJUForZmRFRC9DcXhR?=
 =?gb2312?B?NnVORlpwSit0Qjh2QVdYVUFiU3padkVYSzFOSmhGaks5RHZJaXJxZFhNNnk5?=
 =?gb2312?B?NXNOZ2E4L0R3Q3VyZlRXOFBlOVRqNW9vUzNVQ2ZCRnljejY1MU4rU25YVG9k?=
 =?gb2312?B?NVBUSDV5ajQ2T3Z4Q01JOXRCaklaTUliRmVPSG1yOXVUWk1tQ0V3MHBMdkdQ?=
 =?gb2312?B?MWpyd2pQSVBTUVk1RnlTNW8raDlvWmVydHZGMGdEWDhEL00xbHhJaVlvdnhq?=
 =?gb2312?B?MEU0SlI2VHN1QmhycTBQU2lOUUNuaDc1L1lCNVJGRVY2UitMMXFDMWlPdmtn?=
 =?gb2312?B?ckx1ZjU0UnBQeVpwQWdacmRXY1V6T0ZsV215S09OQzRicUFsYStnVzYxeU1x?=
 =?gb2312?B?TUtkNmZKU2NubkFwWlJPK0hyV2xCNnp4TENTbThEUVVRVUpsSXQxV3ZmaHov?=
 =?gb2312?B?ck9vVW5XS0hJN0E4UGlPKzhBdVBPbEp6RENzMGwvbFgweW13Rk92dUdGVjFr?=
 =?gb2312?B?bkJWOGMwMWQyMGJ1RENSbnBEUm8vZDFsN2xZTlV1dUdRN2V0YkRjcG1SSjlD?=
 =?gb2312?B?bW42a2JsMzVMRGM3K3lEaHEzdEVVakd3Yk1RTTc4MGthUFNZc2tiZkZTdy84?=
 =?gb2312?B?aDNtWkt5R3oyNVZlN2FRR3I5SnEzYlRPdGdoc1U4aXlVYmZvVzMwU1lNNUtj?=
 =?gb2312?B?Zm9URTZEN3IvOXRyRi9ISDdjSjJiUENPbFVETlBjQ2U1MHJHa2E0UGM1a1V2?=
 =?gb2312?B?MGgvK1hkL0JyaXlZRDNWeGo1eHVkOXVIcUpBTXN4blc0bWlIMjdKMFVTam9w?=
 =?gb2312?B?MUQ3SDR0TzQvUDMzclZQWWNOOUMvRUh6bzdZS1VqSU5FTmhJUHV2R0FmNi9u?=
 =?gb2312?B?QTB1WnVmOEtydExQcnJUTDVuc3hHS2JiRVF4ZkNTc290ZERSekJZNTUySURu?=
 =?gb2312?B?V3dqYU5qYmYxQyswYklGZGFZeGFsUXdYUEZiWFZNNFQ3NzRsZjdUWVFVQkh1?=
 =?gb2312?B?VHlBLzIwMit3bmpucTN5RG9kakI4S0lieU80bXZnbDA0RnBOSnlSbWVvWHBY?=
 =?gb2312?B?aVlsRDFHaElzWitCUVVRL2tlM2J4UmpFWEhNa2p4TWVtd2xHbWdsYnl5TEU4?=
 =?gb2312?B?M1MxaUVsWVMxQkZ1UWFDb0VkMFdSc2FDT0szNEttUCtLQUtSZXM5MDB4WmFx?=
 =?gb2312?B?Rkt4YS9NNFRFajFSZjh3cDZITk5RNVpTZEw1eXFxZkloK1Q2REdyczNHUnJa?=
 =?gb2312?B?ejlZRXdKSnZiVTRyZk9QUE1uKzI3cEJmQVowRzY5emRBd3l0LzViZ0diL2k1?=
 =?gb2312?Q?Lahs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b24a21cd-7a95-4cab-668a-08dcfc7a28f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 02:41:18.2782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VS4ImytgT+oF8rSBRoqXcOhKJlVgnGhvI9zyCLJj5KWh5o76oU+2RNJdReQChNo0jUZESFhrnQjTIEBaKlqLOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10698

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDI0xOoxMdTCNMjVIDQ6NTENCj4gVG86IFdlaSBGYW5n
IDx3ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRA
Z29vZ2xlLmNvbTsgcGFiZW5pQHJlZGhhdC5jb207DQo+IGFuZHJldytuZXRkZXZAbHVubi5jaDsg
Q2xhdWRpdSBNYW5vaWwgPGNsYXVkaXUubWFub2lsQG54cC5jb20+Ow0KPiBWbGFkaW1pciBPbHRl
YW4gPHZsYWRpbWlyLm9sdGVhbkBueHAuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsNCj4g
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIG5ldCAwLzJdIEZpeCBpc3N1ZXMgd2hlbiBQRiBzZXRzIE1BQyBhZGRy
ZXNzIGZvciBWRg0KPiANCj4gT24gVGh1LCAzMSBPY3QgMjAyNCAxNDowMjo0NSArMDgwMCBXZWkg
RmFuZyB3cm90ZToNCj4gPiAgIG5ldDogZW5ldGM6IGFsbG9jYXRlIHZmX3N0YXRlIGR1cmluZyBQ
RiBwcm9iZXMNCj4gPiAgIG5ldDogZW5ldGM6IHByZXZlbnQgUEYgZnJvbSBjb25maWd1cmluZyBN
QUMgYWRkcmVzcyBmb3IgYW4gZW5hYmxlZCBWRg0KPiANCj4gVGhpcyBjb21iaW5hdGlvbiBvZiBj
aGFuZ2VzIHdvdWxkIGltcGx5IHRoYXQgbm9ib2R5IHNldHMgdGhlIE1BQw0KPiBhZGRyZXNzIG9u
IFZGcyB2aWEgdGhpcyBkcml2ZXIsIGNvcnJlY3Q/IFBhdGNoIDEgZml4ZXMgYSBjcmFzaA0KPiBp
ZiBhZGRyZXNzIGlzIHNldCBiZWZvcmUgVkZzIGFyZSBlbmFibGVkLCBwYXRjaCAyIGZvcmNlcyBz
ZXR0aW5nDQo+IHRoZSBNQUMgYmVmb3JlIFZGcyBhcmUgZW5hYmxlZCAod2hpY2ggd291bGQgcHJl
dmlvdXNseSBjcmFzaCkuDQo+IFdoaWNoIGxlYWRzIG1lIHRvIGJlbGlldmUgdGhpcyB3aWxsIGNh
dXNlIHJlZ3Jlc3Npb25zIHRvIGFsbCB1c2VycywNCj4gaWYgc3VjaCB1c2VycyBleGlzdC4NCg0K
VG8gYmUgaG9uZXN0LCBJIGRvbid0IGtub3cgbXVjaCBhYm91dCB0aGUgTFMxMDI4QSBwbGF0Zm9y
bS4gQXBwYXJlbnRseSwNCkJlZm9yZSB0aGlzIHBhdGNoLCB1c2VycyBjb3VsZCBvbmx5IG1vZGlm
eSB0aGUgTUFDIGFkZHJlc3Mgb2YgVkYgdGhyb3VnaA0KdGhlIFBGIGRyaXZlciBhZnRlciB0aGUg
VkYgaXMgZW5hYmxlZC4gSG93ZXZlciwgdGhlIFZGIGRyaXZlciBvbmx5IG9idGFpbnMNCnRoZSBN
QUMgYWRkcmVzcyBmcm9tIHRoZSByZWdpc3RlciBhbmQgc2V0IGl0IGludG8gbmV0X2RldmljZSBk
dXJpbmcgcHJvYmUuDQpTaW5jZSBWRiBoYXMgYmVlbiBlbmFibGVkLCB0aGUgVkYgZHJpdmVyIGhh
cyBhbHJlYWR5IGNvbXBsZXRlZCB0aGUgcHJvYmUuDQpUaGVyZWZvcmUsIGlmIHVzZXJzIHdhbnQg
dG8gdGhlIFZGIG5ldHdvcmsgdG8gd29yayBwcm9wZXJseSwgdGhleSBuZWVkIHRvDQpyZS1wcm9i
ZSB0aGUgVkYgZHJpdmVyLiBJZiB1c2VycyBkbyBkaXNhYmxlL2VuYWJsZSBTUklPViBvciB1bmJp
bmQvYmluZA0KVkYgZHJpdmVyIHRvIHJlLXByb2JlIHRoZSBWRiBkcml2ZXIsIHN1Y2ggYXMgeW91
IG1lbnRpb25lZCBiZWxvdywgYXNzaWduDQp0aGUgVkYgdG8gYSBWTSwgcGF0Y2ggMiB3aWxsIGlu
ZGVlZCBjYXVzZSBhIHJlZ3Jlc3Npb24gaXNzdWUuDQoNCj4gDQo+IFRoZSBmYWN0IHRoYXQgdGhl
IE1BQyBhZGRyZXNzIGlzIG5vdCBwaWNrZWQgdXAgYnkgYSBydW5uaW5nIFZNIGlzDQo+IG5vcm1h
bCwgSSdkIHNheSBldmVuIG1heWJlIGV4cGVjdGVkLiBJSVVDIGh5cGVydmlzb3Igd2lsbCBlbmFi
bGUNCj4gU1JJT1YgYXQgdGhlIHN0YXJ0IG9mIGRheSwgdGhlbiBhbGxvY2F0ZSwgY29uZmlndXJl
IGFuZCBhc3NpZ24gVkZzDQo+IHRvIFZNcy4gSXQgd2lsbCBGTFIgdGhlIFZGIGFmdGVyIGNvbmZp
Z3VyYXRpb24uDQo+IA0KPiBZb3VyIGNoYW5nZSB3aWxsIG1ha2UgaXQgaW1wb3NzaWJsZSB0byBy
ZWNvbmZpZ3VyZSBWRiB3aXRoIGEgTUFDDQo+IG9mIGEgbmV3IFZNLCBpZiBhbnkgb3RoZXIgVkYg
aXMgaW4gdXNlLg0KPiANCj4gTG9uZyBzdG9yeSBzaG9ydCwgSSBkb24ndCBiZWxpZXZlIHRoZSBw
YXRjaCAyIGlzIG5lY2Vzc2FyeSBhdCBhbGwsDQo+IG1heWJlIHlvdSBjYW4gcHJpbnQgYSB3YXJu
aW5nIHRvIHRoZSBsb2dzLCBpZiB5b3UgcmVhbGx5IHdhbnQuDQoNCkkgdGhpbmsgeW91ciBjb25j
ZXJuIGlzIHJlYXNvbmFibGUsIHRoZSBiZXN0IHdheSBpcyB0aGF0IHdlIGFkZCB0aGUNClBTSS10
by1WU0kgbWVzc2FnaW5nIGluIHRoZSBmdXR1cmUsIHNvIHRoYXQgaXMgd29udCBjYXVzZSByZWdy
ZXNzaW9uDQppc3N1ZS4gVGhhbmtzLg0KDQo=

