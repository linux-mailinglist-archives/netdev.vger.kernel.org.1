Return-Path: <netdev+bounces-126813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E46A97296B
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C8EAB23C65
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD0D1779BC;
	Tue, 10 Sep 2024 06:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="Lw9TFoml"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2117.outbound.protection.outlook.com [40.107.215.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7ED176AA5;
	Tue, 10 Sep 2024 06:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725949203; cv=fail; b=IBBBGFrPerNCrwJ2VnRh8ibflSPx35nd+UJYE303VPmhzYH8zRCdBtqdlWRBRyqxq87WbPATtK6VQYfksjilRkNUeAatXXqbQovze5964jmsHa8jt8Oh58U6bLpAedD30tImsfBA7G00qg7uOAhQpoGvDCrr4MXU863KjN5aMhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725949203; c=relaxed/simple;
	bh=yUKYtleZhgN9wJeV1hjn3mjGfJkfuxFRMhM9WslEhxA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dK1ofhdfFBG+pGPZzR0sbpEDYTbhiHVXvSJs9SOUkPYqdHhpWgU9X0xy7I1Aa+Y86kMLDHdBDJOBQ6XDvlyHt7E9vHV22VrirNGcaXns6p5iGJ8Z1lATQ/jKDZb2J2ZJXA5cTByAcjZY/nHuXoeTPtyVHwSzWr7S3RWE/gRg30Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=Lw9TFoml; arc=fail smtp.client-ip=40.107.215.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jgd0q6PepVZVKPCobgljMQVf0yayOcyaHnG8+QNWdFAYu761gIZqs7qFgViuNfvQn4V/LrlF9nLHdyK1QBuYWEwwQ7zmqYPp44j01QbyYce1/vDOHscUBk8vaPEMlEMaNcKHzum0mIxcxiWWCEshr7U+3zvAwVQQEzHrn4yL6gBm3wya0GdRg5qSUgr8v49AdNOTcOuod3tXLHqu0a+nlmlDnTYsS4n6R+kpShvQjrHopY4LdU9NEjnYroE4tKRqAUCF2ULhaIMNZgDCIOJUad2ITurmaxOfKF6io1cNF0zPzf3fKPmiFSlEx4xh+TJYpAvnRq4UGRDvVcGV21wJ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUKYtleZhgN9wJeV1hjn3mjGfJkfuxFRMhM9WslEhxA=;
 b=Ut1T5l3I8G7wqXezoNa6qU+MBAXogyC1QVDyZwopBH4bzkvXQOS2/VKzMIPwSrIR5sT88b/nLjCJ3CXqOOb2UuUPdb1aV4+ip/8oF4pa88Ynk0/b7+hPiWTN6VazOaFit8rK7s3utMpz+ecFZ7TGRkdnqbQcBKXFgvDCWIjDrH2LREJysdV3Myu4oPVYQDvBmFinuVqdFiSsWmGcJWCzHBmnZ/HCyqJ0I571aP+uerrbazoISfVR6FBwYjsg/uv+64jTy6HB8mYY1RsoZIf45D51/yQj13hmbMmHBtfZetynok0J33mHvar0/vI2W1GApdAyIfhfbnLCfRWF6E8UAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUKYtleZhgN9wJeV1hjn3mjGfJkfuxFRMhM9WslEhxA=;
 b=Lw9TFomlMKPRZCa3fQzrD0om6pLGgmCxC+74Y4hek6aV7RTO1aj0mpnVqCOziVKeVu/j/zKwV4TlwK9CjlfagMHGmuYN0MMbDH+8fDLwV1fdaBnVRO3k0YR8Fp2Ih/XNT51YRjgmDYBK1CuYz4NVCAK4LWlGb+f809uRxK4/E2pCc5u0QgMFj6v4sQjQjWky8c8+pwjGQTFnFfjWa2dBtd0swdFWt3M6rNm61drn5eDzizf/rgAvS5mIntcOGzAhJVQIf1/J9JtpwT7DTxTTfoE5wov1NxQWpUIhGn2+zmXHFdODibDWgcZSNu6Rc6jG+fyjnW5isvv+Vv4qLhKp2g==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYZPR06MB7255.apcprd06.prod.outlook.com (2603:1096:405:b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 06:19:54 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 06:19:54 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Andrew Lunn <andrew@lunn.ch>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>, Jacob Keller <jacob.e.keller@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue6KaGOiDlm57opoY6IFtQQVRDSCBuZXQtbmV4dF0gbmV0OiBmdGdtYWMx?=
 =?utf-8?B?MDA6IEZpeCBwb3RlbnRpYWwgTlVMTCBkZXJlZmVyZW5jZSBpbiBlcnJvciBo?=
 =?utf-8?Q?andling?=
Thread-Topic:
 =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggbmV0LW5leHRdIG5ldDogZnRnbWFjMTAwOiBGaXgg?=
 =?utf-8?Q?potential_NULL_dereference_in_error_handling?=
Thread-Index:
 AQHa/1rfMsgzpIAVIUKgpr/yLMfBE7JKRNDwgACk0ACAA8oWYIAArigAgAEmb4CAAAsCwA==
Date: Tue, 10 Sep 2024 06:19:54 +0000
Message-ID:
 <SEYPR06MB5134C7E0E578CB8AB92AA76F9D9A2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <3f196da5-2c1a-4f94-9ced-35d302c1a2b9@stanley.mountain>
 <SEYPR06MB51342F3EC5D457CC512937259D9E2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <6c60860b-dd3c-4d1c-945b-edb8ef6a8618@lunn.ch>
 <SEYPR06MB513433B0DBD9E8008F094CE39D992@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <6261c529-0a15-4395-a8e9-3840ae4dddd6@lunn.ch>
 <a2dba28a-6ac4-4770-b618-acfdd59cbbf4@stanley.mountain>
In-Reply-To: <a2dba28a-6ac4-4770-b618-acfdd59cbbf4@stanley.mountain>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYZPR06MB7255:EE_
x-ms-office365-filtering-correlation-id: afbee7c7-b9fb-403e-9eb9-08dcd16095f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MGFGcTJJUjBSLzlCMzhzMzg0eUFUR1J4Z01TTEpLWkNVb2lVdDFMdTg1bWZV?=
 =?utf-8?B?RFJEU2lMSkZFdy9Yeks3UWtmS0d3b1ZRN3lLUmFYN0lGNUlaWFpIdGZiNy9k?=
 =?utf-8?B?QkkwQzdWdStIblcyYWxZVmU4OXRoZkZxVG1jUGVCcWJNRmdnUTRoUWVxb3NC?=
 =?utf-8?B?bGd6Si9Oby8wWVdsc2diMUVvcm9XRnlUQU9qS3duQ09aeXJoeitRRm1SSnRM?=
 =?utf-8?B?aXBNWEtMS1VsTHYvNXowbjZrcklDNE9hVlFTRGUzOHFBZzN4UysyRzRXVCtj?=
 =?utf-8?B?NUFqYlVuS1NMMWdKWDBFblU5dmo1Skg4SjFsN1NQOGVGRlB1TWg2bHpWVkNX?=
 =?utf-8?B?THJrdEdmeFgzVDdyemZNc0dEam0vRDNicjcrc3RsekJtUHJnek56WTIvRlU3?=
 =?utf-8?B?eWhhcXhSd3JxQjZkMU1tS296MksvZ3lHZXozQjgrblQrZFpVQ3pRRk8rQlc3?=
 =?utf-8?B?THhZbVBIRFdKK2tKbm9BQnVoK3pnQS93ajNnNTAwYnQvbDdZS0lCQ25VekxM?=
 =?utf-8?B?WnlzUk1qbjIyVFVEMkJqVTRhdlpYUEwyb2diRFJyRnhqa0pvVmV0akNpTlZH?=
 =?utf-8?B?ZGFSOGk4SUNhY1JCN0hXOTg4bDFxdjh6SzJmcXR6Y2V4VmpIejdrV0RqU09W?=
 =?utf-8?B?cGd4dDFTTG5FUE4yYVE5eTZvcDZSaDFrdUtMbFhVOFlkSTJicEJoQWt1NHRi?=
 =?utf-8?B?NEYwUFdUdzNSZ3FkWVhxbXJ5bzU5LzgvQjYvNDdabytEajZsL0l6SG9hSU9R?=
 =?utf-8?B?RXlIOWdCWGt6WEt5UGVZUGdyZTJIOWN5QjdpY3dhWVFHTE9xMklKMHZtbTA1?=
 =?utf-8?B?UGFYTVFad2lhT09KL2tOb2dvdVg2VHJKblkwREliQXdwbGpxT3BwcElpSzE3?=
 =?utf-8?B?UitKK3NCaEY4K3RnQ292eHdwd2FLNzZya2ZHQ2JRY1NldVpndDRnclhNQ0dC?=
 =?utf-8?B?b0NaWktiTllKSjNRdWZIRmJEbmo4RUVjUmtJS0FnQ3JlNW5kcTJ1YlpwaTF3?=
 =?utf-8?B?czVSVmErY2dhTWxqZkg0aERxNUM0d2tCeEc3VTZSVWNXV1ArSGRzSkpVbUhn?=
 =?utf-8?B?VVRGK3JBdVJNVCttamMzSVNSVTc3dkg1alRONi9oM2RuUW1HK0w1SnpIT21G?=
 =?utf-8?B?bk55WWZzVStseHZUUmdzZ092MXhOc2FSbnkyb0VWaEZpdkxxd1E1U2ZoUHR5?=
 =?utf-8?B?M3U3ZDU3YVpQb1BNa0wvV09YYWJ4SjlZZE1rQ3NMaXY0dWtmbWVTeXNNV0Jy?=
 =?utf-8?B?SS9zaVUvKzYxNXZJSFRSUVE5aFBBRC9tNWtYMUhLM3dRcysyaUJjbUdsK1VU?=
 =?utf-8?B?aWtMSmhwTi9tOEVCTTRjMlZHNHAyZS84V0h5MEJGUVE2aXhQVHNhNjNQSzNK?=
 =?utf-8?B?NHJPd0JNZVc0aE9lN0hiWXJ2R2NYZSs2cko1TTlHdE1tVnY1NEM1eThFMExI?=
 =?utf-8?B?Nm5IMmdSSkN1cy9pcXM4cUhsSUpDOG9hbnhaaDVWVGczZjBMcm9NWjhoNEox?=
 =?utf-8?B?Zi9QU0FkZ2wrMXkzV2dHU2NaZldHZ0lZWFp0UUY1eGUxeVNCdmV0eThWVGhw?=
 =?utf-8?B?ZjFjOXBSSEJPLzc2WmRWeXdBVC9ndmZkN3BjT1ZzZlB2SXpvenJYdEY3MW9U?=
 =?utf-8?B?UVJZaEZxRloxUjdkVTMvdmJaNVF5Z0NIM1dqQnFMYnY1aFNoZU0raWZHMktv?=
 =?utf-8?B?L2k1MDZJZm5hN3FDcU9FMlNKa2NYRXBHR2xkS2lCbVVsUnFkeVVnako4M3hp?=
 =?utf-8?B?bE9zbWs3bGhuTG1ubGh3WkdnMTl5S1E5a3JaQkdpam5ac3N3NnlQMlNmVmtJ?=
 =?utf-8?B?VlltMEc0L3o4eU9OQitZL2pqNVdVMXJhMjFiSEJzY29RUG1WbDNTeDU2ZFo1?=
 =?utf-8?B?Q2tiVjlQM2VIL1BUVzJPdHFiNHVmbWplVHdoYU9jYld5Tnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZE44K0laektmcnJkSllTY3VsVVZkNEJaSVIrclZyZ29CRnV0ZzJaRWs0R2k2?=
 =?utf-8?B?TWhnWlJoTHhsUDFoOUU2enBlYytQckJnc3pRUm9PUnVmL09jbFFrUlhLVE5j?=
 =?utf-8?B?ZjF6Q21WR01sRThsdjBCOGtmOVpQZVVHT1Bjbk15NDY4OE9wVlF6Rk94MWZv?=
 =?utf-8?B?aXI3R0tkY2hCb1ZreXR6V2lwUUMwbkRYaWxtRW9pSmpTdi9QVDRWaHVsVGtu?=
 =?utf-8?B?ODVRUlhPU29Ta0IrOHZvcWRsK1BBclphRFFoWnQzL3laajkvY05XelFrNFB2?=
 =?utf-8?B?dkFZYmJ2NlR1SHJseVZiZ0dQVWJSYjF1VE80TDV3RlRlTWttSkMvOEc1RFBp?=
 =?utf-8?B?cFBMMFk1SCt6YnpmRWJEVGVqd2I3eVloRDR1STZvTms5M2VpSXFKSWs3L1ZN?=
 =?utf-8?B?YktPd3E2aWtzOHdTRGJqQWNPSGpHQnhCUXlGc1BxVStWakNqbjZPcmwwRmJI?=
 =?utf-8?B?eStBZ1lJcmRLVWpSNjRBTlhtZWpMdjFyMlFHRlpDSlczb2ZZS21NeEVrczE3?=
 =?utf-8?B?T1FpMWdlTVRIUG50Y3dVQ3lWWTUxTWZNeSsvS2ZQM2R3VVk5d2RBbWl1amxo?=
 =?utf-8?B?TmFhWkVIY2tPYzV4TVYwdmxQeFJUTGFSOU1oZ0owb1ltSm9uMzBQMlgwbnhY?=
 =?utf-8?B?NWEvc1docUhWN1BManB2REdjZEd5SENPaTI5UXZZSExyZGNDNHVLU1RIa1BP?=
 =?utf-8?B?YzJ5V3ZucmFVc2FOMGd3ODdCaTJEWG9LTXkvQVJTSFpyLyt3Z1NXNGRQdFpB?=
 =?utf-8?B?ZjJoWDY3eWVLRXdpVDFnbjhCY1Q0SGVpRGlPUDRXZ2x2dHlKdHdBb1lJSjZ2?=
 =?utf-8?B?WHc5SG13eGhTNS9aM1J1dHk2UFNlVkhkd2haYy9KQ0hTeUd4RFNqTWdSdEh6?=
 =?utf-8?B?TVFxeCtQSTdpREhEdXBaNlRCL2NBNHBCTzVaUmMwb282eUFLYjBEQXdWZkFV?=
 =?utf-8?B?OHZBOHoyUGx4RmtMY014K0FwM201ZUdpTGhHTHY2c0FJaE5Rb0hJMFNvSXoz?=
 =?utf-8?B?a0ZxSnc2bDVGb2twcmExUlRWMU1iWEFsN3gwL3EraTZTOFhIVTcwODhEY1Vi?=
 =?utf-8?B?YnEwR01FZDJWeUxwdGhPZDAvaWhaTlRMMzVXandxNGdvdkVIenFPSFJwd0cr?=
 =?utf-8?B?TUx3bDdtYXNzblZLdktTakNIbHdnV1gxOThxZHN5SmdDcDFkSTYvVkdCR1Nz?=
 =?utf-8?B?b2U3dDZlQXZscTkyWmhLV244cldJOXVlL3ZJMmUvZmFiZ0ZDWlhxWE5rdXB2?=
 =?utf-8?B?eGlvMjRYVU8rWHBQQjc2dlJMeW5iaDc1ZWp1OEdMTVh1MlpGUjlpYnVTcHY4?=
 =?utf-8?B?WDhHa1JBOHBZV0M5c2p2Y083WGpxYkRqbGx1Uk9sL0hkSnAxTXFwSE90MGFT?=
 =?utf-8?B?ais0QTJHbVl5OStRQ2szMTVuRWN6R2RsRlN0VVRaYk9LdVVST3ZoVERSN2w2?=
 =?utf-8?B?Q2tiMXFDZTc0c3dCVkJrVzZBeVhoQTRrK1BVTk14akx5UU9IczRHRUtHUkE3?=
 =?utf-8?B?WkxJSDJrZE5rVXo2cHhZamwyaDdWWXNmRjV3MlpUS2JhWmRQdVhjSE81MHFM?=
 =?utf-8?B?TkZXak9aQzZZbzB2MHVocFVqMWMvdFNVSDV0dld2QlN0RnE0eEpjZXVuQTIy?=
 =?utf-8?B?YnFWamw2aWlxR3VJc2FnajVJWjFSaGw3R2lOUDNIbU1GSUhmeVR3Ri9ROHpY?=
 =?utf-8?B?U0FTUGp1SHpQVkdKb3EwTWN3NzJNYU9EZWsrYS95YW05K2VvWGUxZ29xTWJM?=
 =?utf-8?B?b0pPak5kQnJ4VW9JRFJFOXVYYWYzZHhkODIvSFg2WkMwM2VYQks1TnI3MG1G?=
 =?utf-8?B?L09CUTZMTERjeGoyVU5ZTTc1N1dRR1dwKzYyeERQT25zZ2tUaTJCbCtkQUNz?=
 =?utf-8?B?V0o1TU0yUVNHMml5WHNnT0pDZExhZlpnZklDeU5icmJwVEhKN1Vvci84UHZv?=
 =?utf-8?B?bWlWMk9uZ3YreHhQK3kwWlBGQzNKQnpQMm93SWhEeEpSUG8rRERpWm5FYTI0?=
 =?utf-8?B?RE52c2dhaUZMRlRQbGppdjU4Q0g0MkVUMzZzS2FRMFNtdHRQaXl2SjVYM1Z1?=
 =?utf-8?B?dHQ1QlhRNzBwaGRDK0NsYkFSc3lIL05GSTAvRTBpdlJiTnJYZmFwbnZtend6?=
 =?utf-8?Q?nIBJdzOsxqeW3X7Km+SGf/UGl?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: afbee7c7-b9fb-403e-9eb9-08dcd16095f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 06:19:54.2505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /piT8D7K119xFXDSBYQ2E7XUI7fOewthYvyk5+2KO36tsGeRApNx3Mvmam49fg3QUqkieNIIgRH8Tvr4Dh5X++Zp+I2wzwa2Wf/z3bmLM44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7255

SGVsbG8sIERhbg0KDQo+IE9uIE1vbiwgU2VwIDA5LCAyMDI0IGF0IDAyOjAzOjMyUE0gKzAyMDAs
IEFuZHJldyBMdW5uIHdyb3RlOg0KPiA+ID4gPiBBcmUgeW91IGFjdHVhbGx5IHNheWluZzoNCj4g
PiA+ID4NCj4gPiA+ID4gICAgICAgICBpZiAobmV0ZGV2LT5waHlkZXYpIHsNCj4gPiA+ID4gICAg
ICAgICAgICAgICAgIC8qIElmIHdlIGhhdmUgYSBQSFksIHN0YXJ0IHBvbGxpbmcgKi8NCj4gPiA+
ID4gICAgICAgICAgICAgICAgIHBoeV9zdGFydChuZXRkZXYtPnBoeWRldik7DQo+ID4gPiA+ICAg
ICAgICAgfQ0KPiA+ID4gPg0KPiA+ID4gPiBpcyB3cm9uZywgaXQgaXMgZ3VhcmFudGVlZCB0aGVy
ZSBpcyBhbHdheXMgYSBwaHlkZXY/DQo+ID4gPiA+DQo+ID4gPiBUaGlzIHBhdGNoIGlzIGZvY3Vz
IG9uIGVycm9yIGhhbmRsaW5nIHdoZW4gdXNpbmcgTkMtU0kgYXQgb3BlbiBzdGFnZS4NCj4gPiA+
DQo+ID4gPiAgICAgICAgICBpZiAobmV0ZGV2LT5waHlkZXYpIHsNCj4gPiA+ICAgICAgICAgICAg
ICAgICAgLyogSWYgd2UgaGF2ZSBhIFBIWSwgc3RhcnQgcG9sbGluZyAqLw0KPiA+ID4gICAgICAg
ICAgICAgICAgICBwaHlfc3RhcnQobmV0ZGV2LT5waHlkZXYpOw0KPiA+ID4gICAgICAgICAgfQ0K
PiA+ID4NCj4gPiA+IFRoaXMgY29kZSBpcyB1c2VkIHRvIGNoZWNrIHRoZSBvdGhlciBjYXNlcy4N
Cj4gPiA+IFBlcmhhcHMsIHBoeS1oYW5kbGUgb3IgZml4ZWQtbGluayBwcm9wZXJ0eSBhcmUgbm90
IGFkZGVkIGluIERUUy4NCj4gPg0KPiA+IEknbSBndWVzc2luZywgYnV0IGkgdGhpbmsgdGhlIHN0
YXRpYyBhbmFseXNlcnMgc2VlIHRoaXMgY29uZGl0aW9uLCBhbmQNCj4gPiBkZWR1Y2luZyB0aGF0
IHBoeWRldiBtaWdodCBiZSBhIE5VTEwuIEhlbmNlIHdoZW4gcGh5X3N0b3AoKSBpcyBjYWxsZWQs
DQo+ID4gaXQgbmVlZHMgdGhlIGNoZWNrLg0KPiA+DQo+ID4gWW91IHNheSB0aGUgc3RhdGljIGFu
YWx5c2VyIGlzIHdyb25nLCBwcm9iYWJseSBiZWNhdXNlIGl0IGNhbm5vdCBjaGVjaw0KPiA+IHRo
ZSBiaWdnZXIgY29udGV4dC4gSXQgY2FuIGJlIE5VTEwgZm9yIHBoeV9zdGFydCgpIGJ1dCBub3Qg
Zm9yDQo+ID4gcGh5X3N0b3AoKS4gTWF5YmUgeW91IGNhbiBnaXZlIGl0IHNvbWUgbW9yZSBoaW50
cz8NCj4gPg0KPiA+IERhbiwgaXMgdGhpcyBTbWF0Y2g/IElzIGl0IHBvc3NpYmxlIHRvIGR1bXAg
dGhlIHBhdGhzIHRocm91Z2ggdGhlIGNvZGUNCj4gPiB3aGVyZSBpdCB0aGlua3MgaXQgbWlnaHQg
YmUgTlVMTD8NCj4gDQo+IEFkZGluZyBhIGNoZWNrIGhlcmUgaXMgdGhlIGNvcnJlY3QgdGhpbmcu
ICBUaGUgY3VycmVudCBjb2RlIHdvcmtzIGJlY2F1c2Ugd2UNCj4gb25seSBoYXZlIHRoZSBvbmUg
Z290byBhZnRlciB0aGUgY2FsbCB0byBwaHlfc3RhcnQobmV0ZGV2LT5waHlkZXYpLCBidXQgYXMg
c29vbg0KPiBhcyB3ZSBhZGQgYSBzZWNvbmQgZ290byB0aGVuIGl0IHdpbGwgY3Jhc2guDQoNCkNv
dWxkIHlvdSBzaGFyZSBtb3JlIGRldGFpbCBhYm91dCB0aGUgY3Jhc2ggaXMgaGFwcGVuaW5nIHdo
ZW4geW91IGFkZCBhIHNlY29uZCBnb3RvPw0KSSdtIHdvbmRlcmluZyBpZiB0aGVyZSBhcmUgb3Ro
ZXIgdGhpbmdzIEkgbWlzc2VkLg0KVGhhbmsgeW91Lg0KDQo+IA0KPiBTaWxlbmNpbmcgdGhpcyB3
YXJuaW5nIG1lYW5zIHR5aW5nIHRoZSBpbmZvcm1hdGlvbiBmcm9tIHByb2JlKCkgaW50byBpdC4g
IEl0J3MgYQ0KPiBmdW4gcHJvYmxlbSBidXQgbm90IHNvbWV0aGluZyBJJ20gZ29pbmcgdG8gZG8g
dGhpcyB5ZWFyLg0KPiANCg0KSmFja3kNCg==

