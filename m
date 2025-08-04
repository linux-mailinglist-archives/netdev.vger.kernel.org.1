Return-Path: <netdev+bounces-211609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDC1B1A583
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 17:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30943AEA7B
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 15:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9BC219A8E;
	Mon,  4 Aug 2025 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="faFx5S5X"
X-Original-To: netdev@vger.kernel.org
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020084.outbound.protection.outlook.com [52.101.169.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008AD946C;
	Mon,  4 Aug 2025 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754320121; cv=fail; b=f7m9RxtvJgiuJbeoFlnzdOb0rY7tjutPexbgdKkMQKnW58IuCXw0c7mtgas4OQiPZaHniCnL//H5p70G+pf5JFnMNkKMtLRm/RoghLnBlCaQ2Uho8rfD3wkBjgBaVUbupga9RPN6Njrx21s156tSdrBYkXZp55rMe3J5ZHTsU2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754320121; c=relaxed/simple;
	bh=NhLENZPWwRjHzqDtN7qFh1gAqpoMArAu7BtEqXTe460=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FAtqmWSQTQv4dxLtmiyzY/XEQeGdPENDyZ5lMiL/wXcldHxnm0X7RaZkC7l+tnZfVCnJIGeVWiXp9kG94yHZyhIwDkVet/B8LwBtcixYk2OprKMOaEFB20lveHfCJLe14BsE+/3EbUO68NS37fNS3OOYEoPaoWX5ow1DckjPVXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=faFx5S5X; arc=fail smtp.client-ip=52.101.169.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNctI1yPfeB0eaMpIdePILMEk7t0yU9MxBwP/LOQ37NUj56lUfJ8QGzrgNl90mFh3piCtYrLF8TMlXfmxDkpCBgkrNobk5rnI7jtoiBh3Imbuo7RCFEj4ScDwk3BG0QETseol/EwjVa9EaNAsvq5EGQRp4/sChbHh/6h06DkIF3fcs+MmLDAt7y1vLCdMbgetFi4wakmeUSezRGKMcgl/82IAL9uGNNJAeZCUeXDAd/BZet6gppPkTnvcJ1PFuLFb0U7+YgVCFyvOOdWQUWAWVvggCxMVHRRSwYfLYKfHbTrSazCjDtKhaKTCZWXSOM9N/AuN0CcFuqW+nouuO/ONQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhLENZPWwRjHzqDtN7qFh1gAqpoMArAu7BtEqXTe460=;
 b=dkAdS2fRo3LGuvB4h3kGip3XV9UdsNpL08Ls1o7/cD/YUvGd/o1wgL1PMvpEjcs1qndq9cyjmCwogapejlMAtuxlTEB3iTSjt1aiviFLRpImgVbbUqJq/dkhQfl4U3PpL/rjStPGJeEaTk073pPgFJJFP5+HKY6+OIt6+lyCeGMKp48dOkWKHh8lAzd9IoxITZ1lz+N3jyrwir4jb3mB8p5M8LDbESHrrzCR/kOgLN6eSQStE5yGrAqJnDdcSQgKOGeWJAt0duu5JEDUlABq1S+djOdqpM+TA7xzgKUQEdpDNlUbM5P8Uh+GBQxPOGbwiY1VYvakuP8PhPHNB17WoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhLENZPWwRjHzqDtN7qFh1gAqpoMArAu7BtEqXTe460=;
 b=faFx5S5XkRI7tKo/K5KaMOXWHnN5XgVUAPt8pXw2JEk4moBlDON30VXbRl1M8udSPpX7DDsb2WWDAMHIx1MZ9rtyK0UV+T645WH8kqB+JeGz8+/QbmPAPkPsAnqLEPhPXgCMtBHxEYEpIzME1UruRUHYhxGZU3CyUunlT0usPAQ=
Received: from FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::126)
 by FR4P281MB4479.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:125::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 15:07:59 +0000
Received: from FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM
 ([fe80::934d:b034:c445:f67f]) by FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM
 ([fe80::934d:b034:c445:f67f%8]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 15:07:59 +0000
From: Piotr Kubik <piotr.kubik@adtran.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
	<kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v6 1/2] dt-bindings: net: pse-pd: Add bindings for
 Si3474 PSE controller
Thread-Topic: [PATCH net-next v6 1/2] dt-bindings: net: pse-pd: Add bindings
 for Si3474 PSE controller
Thread-Index: AQHcBVGQ1XFXGK8iokWNT1pdlkJYGQ==
Date: Mon, 4 Aug 2025 15:07:59 +0000
Message-ID: <1fdca9e7-8cfa-4708-9a6b-90c5778ff60d@adtran.com>
References: <89e056f0-f5c2-48e0-a8c3-458bce3f0afa@adtran.com>
In-Reply-To: <89e056f0-f5c2-48e0-a8c3-458bce3f0afa@adtran.com>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3PPF3200C8D6F:EE_|FR4P281MB4479:EE_
x-ms-office365-filtering-correlation-id: e9098c13-964d-4e10-ca0f-08ddd368b343
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?VEVINzZKb29YTnh4WGR2VkZ0MXFSbjBuWS9HNE1iM2IvVy9VTkRBU2hkbHBk?=
 =?utf-8?B?L0M3eGRVdjRtOFVaVTNBM2l1bFBwZFF1cmVXdTBzR2VYWmNHbXo1ZnQ5RTcr?=
 =?utf-8?B?UnlVWEs0eFJGS08xY3lnL0p5OEU5MjEzNE4wdUVPdG8yNGdkSjJGYkJ5V2tE?=
 =?utf-8?B?RUxxMDlyb2VuWkowc042MnByYmFBTHl4a05jcWM0YTN3cHlvUzczTnhLVEI4?=
 =?utf-8?B?eEgrejVCWWJUWXlqZWxpcWVRWkN3OS96dDNqNllIM1pNSU5Fb284N1NPMTFn?=
 =?utf-8?B?ZmNBbHhaVkV2dzFrZGRZOGJqZEVFV2JjYjMyUVh0NG1pUGJLVm5HOC9BQmkx?=
 =?utf-8?B?YS94aE9pU1J5dTliZ2NUTGxJREQ1c1N1clNaeDhPQW1NTFNxQjVkanFoNWNh?=
 =?utf-8?B?VTFiMkFTMXZ0N2lCUnFYSnEvVkRVUGZoQzZ4R1pMQi9vc0ZhTHhJeVRJbzZQ?=
 =?utf-8?B?RmRPUTQ2bkZhY0VYYWNlYlNPT3RhVVhjWkt5dUxsdlhqRVMzUm9TbTZhYTJP?=
 =?utf-8?B?Z2pFdVo1ZExnWENNWndlN1poa3VONGE1bTBjemdmL2pjcmVlUmk0aU4xdysy?=
 =?utf-8?B?OFFHTERkaysySE11QjJtbHkyVTFWRmllVmM3UDBxMWlaUkU3Z2F4ZzlnRzBC?=
 =?utf-8?B?WWEvdFIzVjlGalg3TDFBbTREYTg3S1lZNFBIS1ZhR3pFakM1V2RDYWdrbDYx?=
 =?utf-8?B?Tmd2U081djZTbzltOHBKYkVZTlJoa1pxaGxjd2xFK2ZGdytNTmo0YVpJSHg1?=
 =?utf-8?B?Mi9GNElsdVRJQ0hnOGR5dm9GcXlXbS9tbDR3R2NkOVpTcFo2Y3NWUmhIUUFy?=
 =?utf-8?B?WEptTThvV0Y5bWFZbGNCWUp0OXNpMEh5MzdnWE5aamhYejN6c0hSbkd2MTZO?=
 =?utf-8?B?MUQxazMyanF5Z01xTUxKcmFMaUprekx0Y21tNi9rWCtySERBUEFYZUF1SHZQ?=
 =?utf-8?B?aWdjRzRUdmNlUThIUFA4NGtocENrdkR1ckFTWTBWR1Q1ekVQWjlvWVoxMjRK?=
 =?utf-8?B?V21ZNmJwdlBXazkwU0ZSZGNQSWdBeWwwTm1haEhKWm8vMnE0dDF4cUxrQVpO?=
 =?utf-8?B?SDlVWitPa3dtbzJkaE1RU0JUSmpqZHVFeDBCbEErdnVpSDB3T3ZzS2FhZmVS?=
 =?utf-8?B?TXhoSmZCb2F1RDJTaThxR3kxajlhTmFlWDdNNk5BRFVCTzlSeGpxaC9ZVVA2?=
 =?utf-8?B?RjRocTBldG8xSlZqRlNENGNWYlJlTEJOWFA1eWMvanFHYUZFQXpWcVdXa1Nm?=
 =?utf-8?B?WWNuZkh1WDg5c3RWa2tvN0MwNmNJRVc3UFA1SXFGdjVsbkQ4U3owZUR0OENR?=
 =?utf-8?B?bnRvMVZMdlcrR2d0dXdHNUZqL1ZKajJhajRRZnh5cDZreTdmSUMwN09FMldS?=
 =?utf-8?B?d3ZnNElwRWJjb01Ra210OTVRaDVQVWpKY2xsWE1tZUJQS09nQ0JaUGdJSkl6?=
 =?utf-8?B?dDduaFBheTVoZ2xDTUc0WkQrNThEU2s3KzVGblhnVGttSmUzVXI2MXRGbng4?=
 =?utf-8?B?RXdFWEdaZm1aVjhYdjJFZFd4dFZveVpRcU5vcFRjSWZqQTZLQnFIT1B0UVJ2?=
 =?utf-8?B?MnFmNE8vSVU4aHRzWEJSM1ptZ0gzcVRTUmgxSnlEbkQ3SENSUjkrZVo0YW9z?=
 =?utf-8?B?Vng2NndYZTVWVFFnOG5XYWR3cFZTNGNnZ3NpUkN4azZHcDNtYW4zVDVOUmth?=
 =?utf-8?B?VHdKV3ZHR0ZSa2YvV2NuWmZuWHBTbjlyQ1ZrNlJjVy9DYmR6TExKWmU1MVhW?=
 =?utf-8?B?c0QxdUIyVm11Njc3bmtLQlV2TWF6ZmtKRHB3YS9TMlhjdU0rZVNMYlV5Yll3?=
 =?utf-8?B?aG8vcHR6TWg3VXVpRGNBU2NPM2xhRVRYd3JvRGd5a2Jnd1FlN3BNejdWVVEz?=
 =?utf-8?B?cDI1dlRGcldxUEJPVmY2RUthVjhZT21jM1piVnFjQlRGNWNzbk43eTVmQzJG?=
 =?utf-8?Q?xr8ExpNB5J9V+U6685HgtQqnLUQD8TlK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkthYmthRWJsbGFQU0VUVzNUMmMwNmcxcEljb2FzdmE1SlNwd2xCVk5FNHhP?=
 =?utf-8?B?NmdiT0VSa0I2TjFRT1RVZWM0ZnJJUW5CMXUrdWlReXRydXV2ZXN5S2tyR3dF?=
 =?utf-8?B?VTdzRHZxQUdIdGJ3b1VOdmFJZ1F4Z0xKWGcyRFd2TkQ3dFVZOVJVVGg0YS9R?=
 =?utf-8?B?dnJyQnBqZEdpVEtLbUJxbU9ja1poMFdKeno2Ym1HYkUvRUFDeGhnMXY3TlN5?=
 =?utf-8?B?VlNleDdXcVk4ODV2UjJqQkRIY0liOTJvTGJoUTMveHladlhQcGxUUGZDY04r?=
 =?utf-8?B?YTF1ZWVvMUJFM3p4UzZmczhpQlZLZVlMSFlaTitDNUp3dGI0R3hQTFova1RX?=
 =?utf-8?B?N0Y5VGdVR3JkaEV4NW5UWERXOE5adXJiOEJKL1RzK1pCd1MxWXVLaVM4aXF0?=
 =?utf-8?B?aFNLMHN3eFc4ZTNPNkRIdVJicXlQZHNhdkMwVmhUaEtxM1NVRElHb29vYWlK?=
 =?utf-8?B?OUo1VnRscS9kK3NHTXhJK1NieEM0bG5hZUhLdHZrQzVnV3VQTUV2eEczM0li?=
 =?utf-8?B?bGd5OHFhWlNoOEdNRktzNGtyUXRDSzNOVFgzc291Zk0xdS9xQzhaOStSeG1u?=
 =?utf-8?B?Q05KeXZXRFpkcy82TzdZSHB2QWJvdWQwVWtrY2lGRU9ydk1peVhUUnA3N3Q0?=
 =?utf-8?B?Y1dyODJuWWlIRThQYTFZOWRHSktKOGRFeisrOHkxVzdrY0V6RGF1WVRWMFhX?=
 =?utf-8?B?a0d3czFMZTF5QjkxdGE4S2tyQlh6RTN3WW5PdklTa1Z4Qm51MmhOeWZzd3Iy?=
 =?utf-8?B?V0JwcjdEVEdxVlZmcGJXVTZTYzdqcmdSYXZVQnR6LzNaYnJ5aXdrRmc0LzNJ?=
 =?utf-8?B?bDJ1UDZZeUUwQ3pXVXdLcVIxd0RXR2hLM3dubnNlckozNjZDWXZrd1dqMXhB?=
 =?utf-8?B?STh1Tlc2NmFaT2xBRFJwWjdzYlhLNzBLL0cwN2hoSUtmcUlEL29lVmg4cEo4?=
 =?utf-8?B?SlUrNDRwdklXSElLUlZsTGZBV3F4aXd1VXN1aEFaN2hwaWtDcTBtNlhObm5j?=
 =?utf-8?B?Q2FJZGM3NzRmaXA4MVNyS0xtYjVIbFpjR1k1YnF3SFMxT3lxdDluRHlaV2xU?=
 =?utf-8?B?cncwTGE1MnB5TDFQYzhadkFSWHBQRllab2c1bUU1ejJ1akg1UktYWE0vZ0l3?=
 =?utf-8?B?TnlrQm9EcEhYS1RlUzlReHdVUFV5SXRYT2Q5OWJSTGdKZjJSSXZLLzYyL2k3?=
 =?utf-8?B?SXM0dkUxMW9PTVg2Q1FzbXEvVUkwSzNzcmNFc2dscTREalB4am1Eczl4VVdq?=
 =?utf-8?B?c2VFeHI4Tk1Pb05oRXMzc3dyaFd2dkl3KzYrd3RmenJnMU1YUkQ2TlpYaldL?=
 =?utf-8?B?R2MwOC9TRGMrbDdia0w5NEhwSXJRZlE1R2V2dVczT1lXbkVHOEtZVTh2VDdU?=
 =?utf-8?B?ZEs4TEZTczdNTzdoN2dDNmN0cmRPM0xLNlQxYWRNTlN6eGpFSVNkYmpybWZ0?=
 =?utf-8?B?T29TWDRtM1VIYU9ZRzZNMUNycjlRSXo3SlpiL1JhSk5IMHhTMGxpUWlnN3Ru?=
 =?utf-8?B?Ly9aekJ6UUJEQW9NOTVaYTA3Wk5hM0pEdFUwNE9oT1VKZzFqcHFEOXZpZWF6?=
 =?utf-8?B?NzF1ZjRpVTBtOXBHakZFUUdwdmZyZFAzem9oUTZnM2FtM292NXhNSVZ1aU9l?=
 =?utf-8?B?eHdldVpveFRObEFBRXZaRzNKR05HNGJmNGRxNlN1dGpBM05UMUg5S0pET1pp?=
 =?utf-8?B?U0pUbkdvQ0NMRUptRFd6RFI5dWZ4U1daM0hJMFVZcU9CbmlTZGxHdUdSNk9Y?=
 =?utf-8?B?K2hEaU1yZkZnaTljb0Q3eWY0QXNzVGJoTE55Z3czb0R5T0lmaDVYSHNwTE43?=
 =?utf-8?B?cEt2WTN3R2ZyV2hhd3B2MlFjZGJFTDlUSTZrTEhqeUU0SE5sVXdURWJYVzFT?=
 =?utf-8?B?Q1NDTjc1d0huTi9sWDVOT1Q3dmFlTnZXK3ZLRUp2M3J6Qld1N1cyQmNPbDgx?=
 =?utf-8?B?bzdXWUZ0MHd6QW5BY0ZUQkpvVnNHK0ltUjZwak43SllZazIzTnVES1JveExR?=
 =?utf-8?B?Z3RaR1VzWk9xK1VOMWFMRHNYSy9lQXByTmtrcTVEczZGbjI5WUdQNGV0TnBO?=
 =?utf-8?B?K0dFWVZpSWVmM21zSGVoQ3JQR3IyQVcxV1RrT0RpcGwzUlJLanB1NUJteFlI?=
 =?utf-8?Q?JyT3BIkP8jYen74sLSZf489tK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F86CB3D844BA394DA36FC6BA5E1D1089@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: adtran.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e9098c13-964d-4e10-ca0f-08ddd368b343
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 15:07:59.3963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lQ+quDTDJ6Av86BuK4g5oL/KuasxE6TY/Jt/CbT4M74vmrvD8NkaVO4RDVET5W73VpdnHWvA3XhTIs7ORYbktg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4479

RnJvbTogUGlvdHIgS3ViaWsgPHBpb3RyLmt1YmlrQGFkdHJhbi5jb20+DQoNCkFkZCB0aGUgU2kz
NDc0IEkyQyBQb3dlciBTb3VyY2luZyBFcXVpcG1lbnQgY29udHJvbGxlciBkZXZpY2UgdHJlZQ0K
YmluZGluZ3MgZG9jdW1lbnRhdGlvbi4NCg0KU2lnbmVkLW9mZi1ieTogUGlvdHIgS3ViaWsgPHBp
b3RyLmt1YmlrQGFkdHJhbi5jb20+DQpSZXZpZXdlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8
a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KUmV2aWV3ZWQtYnk6IEtvcnkgTWFpbmNl
bnQgPGtvcnkubWFpbmNlbnRAYm9vdGxpbi5jb20+DQotLS0NCg0KQ2hhbmdlcyBpbiB2MzoNCiAg
LSBVcGRhdGUgY2hhbm5lbCBub2RlIGRlc2NyaXB0aW9uLg0KICAtIFJlb3JkZXIgcmVnIGFuZCBy
ZWctbmFtZXMgcHJvcGVydGllcy4NCiAgLSBSZW5hbWUgYWxsICJzbGF2ZSIgcmVmZXJlbmNlcyB0
byAic2Vjb25kYXJ5Ii4NCg0KLS0tDQogLi4uL2JpbmRpbmdzL25ldC9wc2UtcGQvc2t5d29ya3Ms
c2kzNDc0LnlhbWwgIHwgMTQ0ICsrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAx
NDQgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbmV0L3BzZS1wZC9za3l3b3JrcyxzaTM0NzQueWFtbA0KDQpkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9wc2UtcGQvc2t5d29y
a3Msc2kzNDc0LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3Bz
ZS1wZC9za3l3b3JrcyxzaTM0NzQueWFtbA0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAw
MDAwMDAwMDAwMC4uZWRkMzZhNDNhMzg3DQotLS0gL2Rldi9udWxsDQorKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3BzZS1wZC9za3l3b3JrcyxzaTM0NzQueWFtbA0K
QEAgLTAsMCArMSwxNDQgQEANCisjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1v
bmx5IE9SIEJTRC0yLUNsYXVzZSkNCislWUFNTCAxLjINCistLS0NCiskaWQ6IGh0dHA6Ly9kZXZp
Y2V0cmVlLm9yZy9zY2hlbWFzL25ldC9wc2UtcGQvc2t5d29ya3Msc2kzNDc0LnlhbWwjDQorJHNj
aGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQorDQor
dGl0bGU6IFNreXdvcmtzIFNpMzQ3NCBQb3dlciBTb3VyY2luZyBFcXVpcG1lbnQgY29udHJvbGxl
cg0KKw0KK21haW50YWluZXJzOg0KKyAgLSBQaW90ciBLdWJpayA8cGlvdHIua3ViaWtAYWR0cmFu
LmNvbT4NCisNCithbGxPZjoNCisgIC0gJHJlZjogcHNlLWNvbnRyb2xsZXIueWFtbCMNCisNCitw
cm9wZXJ0aWVzOg0KKyAgY29tcGF0aWJsZToNCisgICAgZW51bToNCisgICAgICAtIHNreXdvcmtz
LHNpMzQ3NA0KKw0KKyAgcmVnOg0KKyAgICBtYXhJdGVtczogMg0KKw0KKyAgcmVnLW5hbWVzOg0K
KyAgICBpdGVtczoNCisgICAgICAtIGNvbnN0OiBtYWluDQorICAgICAgLSBjb25zdDogc2Vjb25k
YXJ5DQorDQorICBjaGFubmVsczoNCisgICAgZGVzY3JpcHRpb246IFRoZSBTaTM0NzQgaXMgYSBz
aW5nbGUtY2hpcCBQb0UgUFNFIGNvbnRyb2xsZXIgbWFuYWdpbmcNCisgICAgICA4IHBoeXNpY2Fs
IHBvd2VyIGRlbGl2ZXJ5IGNoYW5uZWxzLiBJbnRlcm5hbGx5LCBpdCdzIHN0cnVjdHVyZWQNCisg
ICAgICBpbnRvIHR3byBsb2dpY2FsICJRdWFkcyIuDQorICAgICAgUXVhZCAwIE1hbmFnZXMgcGh5
c2ljYWwgY2hhbm5lbHMgKCdwb3J0cycgaW4gZGF0YXNoZWV0KSAwLCAxLCAyLCAzDQorICAgICAg
UXVhZCAxIE1hbmFnZXMgcGh5c2ljYWwgY2hhbm5lbHMgKCdwb3J0cycgaW4gZGF0YXNoZWV0KSA0
LCA1LCA2LCA3Lg0KKw0KKyAgICB0eXBlOiBvYmplY3QNCisgICAgYWRkaXRpb25hbFByb3BlcnRp
ZXM6IGZhbHNlDQorDQorICAgIHByb3BlcnRpZXM6DQorICAgICAgIiNhZGRyZXNzLWNlbGxzIjoN
CisgICAgICAgIGNvbnN0OiAxDQorDQorICAgICAgIiNzaXplLWNlbGxzIjoNCisgICAgICAgIGNv
bnN0OiAwDQorDQorICAgIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KKyAgICAgICdeY2hhbm5lbEBbMC03
XSQnOg0KKyAgICAgICAgdHlwZTogb2JqZWN0DQorICAgICAgICBhZGRpdGlvbmFsUHJvcGVydGll
czogZmFsc2UNCisNCisgICAgICAgIHByb3BlcnRpZXM6DQorICAgICAgICAgIHJlZzoNCisgICAg
ICAgICAgICBtYXhJdGVtczogMQ0KKw0KKyAgICAgICAgcmVxdWlyZWQ6DQorICAgICAgICAgIC0g
cmVnDQorDQorICAgIHJlcXVpcmVkOg0KKyAgICAgIC0gIiNhZGRyZXNzLWNlbGxzIg0KKyAgICAg
IC0gIiNzaXplLWNlbGxzIg0KKw0KK3JlcXVpcmVkOg0KKyAgLSBjb21wYXRpYmxlDQorICAtIHJl
Zw0KKyAgLSBwc2UtcGlzDQorDQordW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KKw0KK2V4
YW1wbGVzOg0KKyAgLSB8DQorICAgIGkyYyB7DQorICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47
DQorICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQorDQorICAgICAgZXRoZXJuZXQtcHNlQDI2IHsN
CisgICAgICAgIGNvbXBhdGlibGUgPSAic2t5d29ya3Msc2kzNDc0IjsNCisgICAgICAgIHJlZy1u
YW1lcyA9ICJtYWluIiwgInNlY29uZGFyeSI7DQorICAgICAgICByZWcgPSA8MHgyNj4sIDwweDI3
PjsNCisNCisgICAgICAgIGNoYW5uZWxzIHsNCisgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8
MT47DQorICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KKyAgICAgICAgICBwaHlzMF8wOiBj
aGFubmVsQDAgew0KKyAgICAgICAgICAgIHJlZyA9IDwwPjsNCisgICAgICAgICAgfTsNCisgICAg
ICAgICAgcGh5czBfMTogY2hhbm5lbEAxIHsNCisgICAgICAgICAgICByZWcgPSA8MT47DQorICAg
ICAgICAgIH07DQorICAgICAgICAgIHBoeXMwXzI6IGNoYW5uZWxAMiB7DQorICAgICAgICAgICAg
cmVnID0gPDI+Ow0KKyAgICAgICAgICB9Ow0KKyAgICAgICAgICBwaHlzMF8zOiBjaGFubmVsQDMg
ew0KKyAgICAgICAgICAgIHJlZyA9IDwzPjsNCisgICAgICAgICAgfTsNCisgICAgICAgICAgcGh5
czBfNDogY2hhbm5lbEA0IHsNCisgICAgICAgICAgICByZWcgPSA8ND47DQorICAgICAgICAgIH07
DQorICAgICAgICAgIHBoeXMwXzU6IGNoYW5uZWxANSB7DQorICAgICAgICAgICAgcmVnID0gPDU+
Ow0KKyAgICAgICAgICB9Ow0KKyAgICAgICAgICBwaHlzMF82OiBjaGFubmVsQDYgew0KKyAgICAg
ICAgICAgIHJlZyA9IDw2PjsNCisgICAgICAgICAgfTsNCisgICAgICAgICAgcGh5czBfNzogY2hh
bm5lbEA3IHsNCisgICAgICAgICAgICByZWcgPSA8Nz47DQorICAgICAgICAgIH07DQorICAgICAg
ICB9Ow0KKyAgICAgICAgcHNlLXBpcyB7DQorICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+
Ow0KKyAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCisgICAgICAgICAgcHNlX3BpMDogcHNl
LXBpQDAgew0KKyAgICAgICAgICAgIHJlZyA9IDwwPjsNCisgICAgICAgICAgICAjcHNlLWNlbGxz
ID0gPDA+Ow0KKyAgICAgICAgICAgIHBhaXJzZXQtbmFtZXMgPSAiYWx0ZXJuYXRpdmUtYSIsICJh
bHRlcm5hdGl2ZS1iIjsNCisgICAgICAgICAgICBwYWlyc2V0cyA9IDwmcGh5czBfMD4sIDwmcGh5
czBfMT47DQorICAgICAgICAgICAgcG9sYXJpdHktc3VwcG9ydGVkID0gIk1ESS1YIiwgIlMiOw0K
KyAgICAgICAgICAgIHZwd3Itc3VwcGx5ID0gPCZyZWdfcHNlPjsNCisgICAgICAgICAgfTsNCisg
ICAgICAgICAgcHNlX3BpMTogcHNlLXBpQDEgew0KKyAgICAgICAgICAgIHJlZyA9IDwxPjsNCisg
ICAgICAgICAgICAjcHNlLWNlbGxzID0gPDA+Ow0KKyAgICAgICAgICAgIHBhaXJzZXQtbmFtZXMg
PSAiYWx0ZXJuYXRpdmUtYSIsICJhbHRlcm5hdGl2ZS1iIjsNCisgICAgICAgICAgICBwYWlyc2V0
cyA9IDwmcGh5czBfMj4sIDwmcGh5czBfMz47DQorICAgICAgICAgICAgcG9sYXJpdHktc3VwcG9y
dGVkID0gIk1ESS1YIiwgIlMiOw0KKyAgICAgICAgICAgIHZwd3Itc3VwcGx5ID0gPCZyZWdfcHNl
PjsNCisgICAgICAgICAgfTsNCisgICAgICAgICAgcHNlX3BpMjogcHNlLXBpQDIgew0KKyAgICAg
ICAgICAgIHJlZyA9IDwyPjsNCisgICAgICAgICAgICAjcHNlLWNlbGxzID0gPDA+Ow0KKyAgICAg
ICAgICAgIHBhaXJzZXQtbmFtZXMgPSAiYWx0ZXJuYXRpdmUtYSIsICJhbHRlcm5hdGl2ZS1iIjsN
CisgICAgICAgICAgICBwYWlyc2V0cyA9IDwmcGh5czBfND4sIDwmcGh5czBfNT47DQorICAgICAg
ICAgICAgcG9sYXJpdHktc3VwcG9ydGVkID0gIk1ESS1YIiwgIlMiOw0KKyAgICAgICAgICAgIHZw
d3Itc3VwcGx5ID0gPCZyZWdfcHNlPjsNCisgICAgICAgICAgfTsNCisgICAgICAgICAgcHNlX3Bp
MzogcHNlLXBpQDMgew0KKyAgICAgICAgICAgIHJlZyA9IDwzPjsNCisgICAgICAgICAgICAjcHNl
LWNlbGxzID0gPDA+Ow0KKyAgICAgICAgICAgIHBhaXJzZXQtbmFtZXMgPSAiYWx0ZXJuYXRpdmUt
YSIsICJhbHRlcm5hdGl2ZS1iIjsNCisgICAgICAgICAgICBwYWlyc2V0cyA9IDwmcGh5czBfNj4s
IDwmcGh5czBfNz47DQorICAgICAgICAgICAgcG9sYXJpdHktc3VwcG9ydGVkID0gIk1ESS1YIiwg
IlMiOw0KKyAgICAgICAgICAgIHZwd3Itc3VwcGx5ID0gPCZyZWdfcHNlPjsNCisgICAgICAgICAg
fTsNCisgICAgICAgIH07DQorICAgICAgfTsNCisgICAgfTsNCi0tIA0KMi40My4wDQoNCg==

