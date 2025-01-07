Return-Path: <netdev+bounces-155847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1BDA040BD
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B8E3A1A66
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55FA433AD;
	Tue,  7 Jan 2025 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z8e52sLN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDED83D97A
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736256118; cv=fail; b=jUVtSwYakG92AAZj0u3Pv3X1aM7QK7mAEQ6YPaO7Y77dayRLxj3s/QD9xLtsQHyCB5hOwzgnlt1Lyg2a8FypPVrpmZi+0Rrf1v5NRJbWQy0Kxq2OLbC0/bomIBja2mqFK65uw9cs50eiK9JuFHaWa/QFuPYxaz7kM1jxJw6oO/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736256118; c=relaxed/simple;
	bh=QtFA6N6GZ0LyYSZ3mwxzpHzpCWKAQFJP36txrY7uRHA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rskwS93y7s9kewLclnfvuabV0qio7BClZ6Kf/LZgZXCYV8wknCXeOvM8UZofg4KODXS1VvVrrGPGmSjxATydo90GJuOcAdQ4aPUinuIse+vxd3K42d9mT1CeWXnfIj2c0EVrL1cxaC5qVWWNPuoyUiseuhbPeS1KI+sxhZ64TNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z8e52sLN; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVPY3mr8A9kZGMBV0JniWJwwLR9yv8S7D5GvI5khPK7uaVwkG97JVK+rgH7YyS1mvOEjXgYOHQVjhAPAIKTdsteIiDsxdwjikin5xIqmgLftK+K6AaiUplBwFs8kD85TAsesUJcPv7wOSIba+hYi/goHkE8xAyN/1hXFqOJd1K+BvqBmVh0TP2f+RkMayZjBKR+p5BInBmneK7rmw4qR474hvwhEBAf63XTZ6ICNA9z0ARadREvgtUfJevO0J/9mZEU0bCigjjOlF+1Eg9Nufq1qz3oGWlO4T2sakcq4Q0XpJ0pRKsmANfEKxJBMUd5wwrJUNbyKw+CzUn7ZMWqNnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtFA6N6GZ0LyYSZ3mwxzpHzpCWKAQFJP36txrY7uRHA=;
 b=Ykn90BsFgjE1V2xoHU/qD9WFbafikTCRyfPzLOhXHccFW7uXSdzdMAllST4PAz7r0MK8tEhUqfXOMv3TNF7/RErl50oe3vUftuOTdkVltGhYoutk3IuAFIgEdSKPJf6rg81aoEU7J5ouWFXa5akVNhMwuv8r6zv9Zyn8SQZaT3NIEPOhOJXR0ijjcHmERSsCid/ejmQlIb9gHM55tjRbZt46leutjHn62n3+Ci2/EWWVxLCld4a7TAUh5aflYL5v+GpI5lvs0YwFqYiAuk/m20V2nX1wwipJ0omKDL2JwlDA3NeCJ/NfAzCEFvqeu+CuhbD7mZyyR4x+uH9ZLIzdPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtFA6N6GZ0LyYSZ3mwxzpHzpCWKAQFJP36txrY7uRHA=;
 b=Z8e52sLNFVqqJ8gAk1kCmJBK5eHYZp/zsrxkKayuTvMjv+Pswico7ZD50JpkbZmU5amyELp0jEX0JBXbPWT2+vbTUBheoyIcNFhHLLGldXbbrE23DC+rc1ZynouJ8bwOTllIucY8ob+q/Iv7HMw6wYL5mLhujry7posssbFTEnLJ8un4Xu2ufzRiCWq6TSDXyVuPfMCaejzniUInCkX9C8YWRSSwGeo0m6VZQL6v04H5A28PdfXxTBM/tlvmK1FeRDgqx8yeQss3FqtcVWS5IgC7RZwTHd4f53ldzwQvP0fUReIMjpnomzMS3Uw1nxBMWyTWvFoA5w1Q57ktXUY7gQ==
Received: from MN2PR12MB4517.namprd12.prod.outlook.com (2603:10b6:208:267::16)
 by SA0PR12MB4367.namprd12.prod.outlook.com (2603:10b6:806:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 13:21:49 +0000
Received: from MN2PR12MB4517.namprd12.prod.outlook.com
 ([fe80::160b:3f54:2b48:3418]) by MN2PR12MB4517.namprd12.prod.outlook.com
 ([fe80::160b:3f54:2b48:3418%4]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 13:21:49 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>
Subject: RE: [RFC ethtool] ethtool: mock JSON output for --module-info
Thread-Topic: [RFC ethtool] ethtool: mock JSON output for --module-info
Thread-Index:
 AQHbHz7DQv+I+3IfGkOF2TEcLZxABLKPd+pQgAHPmYCACQ73QIAuaH6AgAJJKNCAAGFwgIABVcQggBTmQACAANtR8IAJxpXAgAHyqoCAFWV7kIAILw+AgAAAPKA=
Date: Tue, 7 Jan 2025 13:21:48 +0000
Message-ID:
 <MN2PR12MB4517A3A429E753A4016321ADD8112@MN2PR12MB4517.namprd12.prod.outlook.com>
References: <7d3b3d56-b3cf-49aa-9690-60d230903474@gmail.com>
 <DM6PR12MB451628E919440310BC5726E5D8422@DM6PR12MB4516.namprd12.prod.outlook.com>
 <f0d2811d-e69f-4ef4-bf0f-21ab9c5a8b36@gmail.com>
 <DM6PR12MB4516A5E32EB6C663F907C24BD8492@DM6PR12MB4516.namprd12.prod.outlook.com>
 <cd258b2f-d43f-4ae6-bd7c-ca22777d35e3@gmail.com>
 <MN2PR12MB45179CC5F6CC57611E5024E2D8282@MN2PR12MB4517.namprd12.prod.outlook.com>
 <f3272bbe-3b3d-496e-95c6-9a35d469b6e7@gmail.com>
 <DM6PR12MB45169CD5A409D9B133EF3658D8292@DM6PR12MB4516.namprd12.prod.outlook.com>
 <02060f90-1520-4c17-9efe-8b701269f301@gmail.com>
 <DM6PR12MB4516F7998D67014D9835C5F5D83F2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <DM6PR12MB4516E1A2E2C99E36ECA9D87AD8062@DM6PR12MB4516.namprd12.prod.outlook.com>
 <9e022720-f413-411c-be64-77c8b324549a@gmail.com>
 <DM6PR12MB451618A6A98EA0F5D4A6A549D8142@DM6PR12MB4516.namprd12.prod.outlook.com>
 <3ab1a86f-5c37-4421-b4df-5d73729f1381@gmail.com>
In-Reply-To: <3ab1a86f-5c37-4421-b4df-5d73729f1381@gmail.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4517:EE_|SA0PR12MB4367:EE_
x-ms-office365-filtering-correlation-id: 3070a626-07a8-48b6-6530-08dd2f1e3de1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NmlveVZtVzlKNGU5RDRGOCt1NVJXVE5La1ZhakZNRVFyOGR2dSt4NEZueW9t?=
 =?utf-8?B?SnNzaWpjZis0eHJHTVpTQkt2bFlOb2tUMnJHK0xPdEpRWTU4UDFNcGgrZjcz?=
 =?utf-8?B?cDkvZUc1eGxtUCtrSDhMYUlJejNySnhYY2ZwZURZbkhQa2k3a2pCVlZnTDM4?=
 =?utf-8?B?QTkveVlTY2FOYkFsSjFTQUhpMFRNWHFNZXQ1L1Y0cDg3RzY3ODlPQnJsS0Iz?=
 =?utf-8?B?bDlIaXU5YXlxT3RLNEFoOGhydlFKbVQ4N1RRNW1WUFREM2JtcTdCWWpxT3VF?=
 =?utf-8?B?VkFMMUM2L3V0Y0xIcjkzOFBrSHJjTUFtQndscDlDcDNoUGdVcEIzc1NRU1Fm?=
 =?utf-8?B?eE1QOFEyR1NvREtZc1ZZNXptNm5kbllSMXZRcHBiWnorTzlZa3M2Ui9xWG1L?=
 =?utf-8?B?dlJXRFQ1N1R5RnVtZ0tKU3J0N2Nodk41TmNTZWNjeUpUbERjZHoycDJyMFFD?=
 =?utf-8?B?QVp2TE9rNDZDeDBXRkt0N0pqRXlCSng3ZW8yN3p2YThOSXZCVE91SFlHNk5Y?=
 =?utf-8?B?bzhTRSsvcnlMbEhBZ3lXcFlpVDFmUFUwcStMRTRsMnpVWXI4OTVGdTczUith?=
 =?utf-8?B?VFgwQmdoRmpaOTVsUXdnOTB2R2FTbDNUZ240Vk5RckI0ajNLUzFqNEhIdzJx?=
 =?utf-8?B?Y1lYd1BxOWJjVkRQK1VUd3JEdXJ0dGR0U0RUYkpNeEFSNmxTQzVDOGF4TXNO?=
 =?utf-8?B?WmJrSUFZc3hWSnZLdXRuWE1ETnMrUS9SYlhGazA0MkN3eFV6Rk1aeXdnN05H?=
 =?utf-8?B?eGNDVHpZYzU0YmErQmtVVmpQTDBIVHNQZlBhd1JHOW1IMVJ0SmgreThwMjNC?=
 =?utf-8?B?VTFueUhIZHphUVZIbjZxdFU1QWQrVkt0bWp2ZEZWZ0hGZTNYUjh5MUk1TXpy?=
 =?utf-8?B?RStNUW5GWklYK3NWRmdPeWx1ZEpuOEF6c25zVDkvcjZ0SEVqWjhLUGM5VlUw?=
 =?utf-8?B?QWZ6eStCY25DQndPQ043ckp4dVVNYlJ0dk8rK0hSZlZlbHNjdzFMOXI0UHlQ?=
 =?utf-8?B?UDlJb3kzOTVDNW9GVkQrcEwyekdEVlkyaDZkU1RqaW5LaGI1b0pTZHFLaTZM?=
 =?utf-8?B?NWNVck1GQzVWblFZd05kNUZoWjJla25WWGhnM1hNU2VyQ2I0endyek1HRWVZ?=
 =?utf-8?B?N0VoTS8wL0JuUVRmVWtiZldBRzAvV0lpSXBqNzJSRS82SFArQk4yZnBCUFpF?=
 =?utf-8?B?WWVxMkRjUm1DSGUwNXNpR1RlcTJxc0JXMTNMUGNRL2ZveFlmdlFrWU03Q2tk?=
 =?utf-8?B?VStPSVcydVphSlVUNGJtdGRqVnM2c0x3M1BaTklKQWYzTkM0M20yaVVJYTNk?=
 =?utf-8?B?enNLb1lUcEVIUGJSaDlWMlY4NmpDckRtRGFGU0ZlZmJoaFhoSG01TDUwcnBW?=
 =?utf-8?B?eGlBWU9xTkMzYmhWVDR1L05pYldRaG9qVmFseldPRHJQUDFiWmtrQ3JiVm9T?=
 =?utf-8?B?V1FQb2FLUmZUVnRKMTh0cEZxdi9pVXNodU9tcTduN3Bpak5SaXBBWmE1U2hh?=
 =?utf-8?B?Z0ZDSXh2YUlZKzBYL0VSeGM3V29EbEphTTVqWGFYc1ZTS0pSSFRGd0ZVVlhR?=
 =?utf-8?B?UTN6VFhEdDd1VklxbkdHL25NNGtiY0M5SzVZTmVsbklkcDhXbHZZb201VXdY?=
 =?utf-8?B?OGtBRkxGU09wNERnZGk0WmtBRmpXZ1gxVmdLMTlBUzBMeHljaG92Zy9EU2lT?=
 =?utf-8?B?Z09CNTFVOVBycVpvcVZoSzFBVlRjN2Vqb1VOMmxQb1ZDY3pUdEFWdWhaMjhq?=
 =?utf-8?B?VDhKaFp5ZVRSY3ExK3V6eFhNUVJteTZjZ2ZPZ3BrbkVYaDJuMGYveFl2aWxE?=
 =?utf-8?B?ck8zaUxvSG9QekJPMHhXaUs3UzZJOCtqRUxYaHNNUE8xR09ESG5nVzBXclJj?=
 =?utf-8?B?eVNndDdKMlFHbG5EOUNLVmtHSlV1bFAwZUdxQ1ZKRjhHZnFiNm9yY2thV011?=
 =?utf-8?Q?ZXL24m8di5zE/u3nt7gib6UDJl5qdlmB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4517.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WElsWVExVU1qYXFneGZ5MVJUQno3c2NFejJYemJCWGp5ODU1azRBOE5sbXlr?=
 =?utf-8?B?U2xQaWJxbElxK1pPaGFJVENGM09NQmVYVEMxcU1Dd1lzb3A4T2o1bUx1dEE2?=
 =?utf-8?B?VkhMWVFxWmhXQVpSSEtCem9VOE9MMHJTSFZZekdyanl4THhneHR0c2Y1YXZx?=
 =?utf-8?B?dmpCSkhtbFhXVEdmY2VXQjIwTDk1U0FZV2RuTnpjbDEybitkSmt0QVgvUTZI?=
 =?utf-8?B?V1RXNEZVaGdhS1hYSS9MQStVQUhYQVMySEpzQUU2TFFJd083Mk9FaVhVdm84?=
 =?utf-8?B?S295UURsSkhRK2RQaTM3clFqd2JFZ1V1YTF2anJmSXF5alNINnkxN1kzRjJJ?=
 =?utf-8?B?Q1JBTzR2NDJnRVNXcTFLYlpTVnlVc3R2cmJJNlhwVVpvay8waXZxKzhMQVpP?=
 =?utf-8?B?YkErQjNOd1NlbW41K3ltQ3M2OUNFcHdzWkM2dHdoMis0RTFLcDhGSHViRzVQ?=
 =?utf-8?B?LzgrS09SeDZObzFYUnVKTnA4R2FJWkZYc1c0RXpDNy9HUmlxUVkyQzhyQ0Vm?=
 =?utf-8?B?SDFhT0lCVVViRnlkZytEK1VNenRXVEQxVk5PUEJFajhuSExUNGh3b2JudVUv?=
 =?utf-8?B?TE9QM0MvdkNaTUFKejlIRTJKUUdmSWVTZ3hkQURhWjAyVXFyWXNlK1JwWDZr?=
 =?utf-8?B?TkxMYldUKzVaeVhyS1R0NDkxTzBqRitOd2NZZnJ1c0gvcjJyNUtFL1RJN1g0?=
 =?utf-8?B?THduOGVOLzFUQTFoOGtFYjF4aXNUZFhGTURRYWJEMXdsRG5OanQ1ejJZdTAy?=
 =?utf-8?B?bVpOMVVSbDliY2dXVnRqd01yNE5FYUpWUXlsVURpWDRETnQyM2tXbUp5b0d4?=
 =?utf-8?B?U0pRYXpHTzBjZFdSU2ZPblRWenZRc2gwTVJvYTNocHRNVGhLTk9hcytTczM4?=
 =?utf-8?B?VlNUeHVUV1U4TUFTNUtXYlp0cmgzUlB2SjAraEJoanFPTE1SamVUZ3cwcWRt?=
 =?utf-8?B?cFdHRkZ2NUFrZ29aak1rQ2NtSk9qTTZqalEzRXh3cUJBWHBOUis0aTl0RjMv?=
 =?utf-8?B?Unk1S2Z0bUhkdGR0V3ozYXFiVXdBOW11VytFMERuSUorSXpzektmNzJtN21C?=
 =?utf-8?B?b1cxSnBFOUV2YzZQRkd3Ykx4dzVDUS9UeFgvT2ZwRXdmYlIyQzNEemkvcWZt?=
 =?utf-8?B?cGJ3L0ZyWUhHS01DVURJa0IwazRHMERuQXJlQmdVQ1RzWUFaSmxMSzhGNzdM?=
 =?utf-8?B?YTE0eTFRK0VPVklFUldiSC9MOE1FSjRYeStkalJURnl4TWZFRUNvdDNONFUv?=
 =?utf-8?B?WHBjR3Q5MlM5L2hRaUp5djlVSVlPYkd1eTNWSm5GRUtKWFZJYkNQNVhBTDNs?=
 =?utf-8?B?N3BmMmdjQVV6Mkk2UTBvcWdneE1XMUxZMFdZVi96YnVFUWs4YkJKSU03ZjRi?=
 =?utf-8?B?SFB4U1crVXdzN0F1OHY5dXM4NXZyd1RIYkJVYUloZytrK3JRK21NK2R5MVFK?=
 =?utf-8?B?RkhUUklTNlE3OUYxODZVaDNVQ1RpT0dwYlRna2Rpd2F5K1RoZXJGOUZJTEpz?=
 =?utf-8?B?RDUrazN5TkU1K1AwSVFIbHJ6cVpMaW5TdDc5TDhXUXYrWWJGcW9WRmYrT1Vz?=
 =?utf-8?B?OFpSOFA1TFU0VFhwdkRMNHRkbjVQOVNnVFZiVjRmSUtSV3IrbHo4V09FV1N6?=
 =?utf-8?B?cm5mSkU4R3hpY3JwOTJ2K1NUWEh5MytUdlhIVGtJUFFHamJzcU5odGJteVI5?=
 =?utf-8?B?eEcyeGpISWcwVFVnUXVXMU1YWVVlRFZRUS9jdjNCMDBRNWtOck0wK0ZWQjli?=
 =?utf-8?B?VkR6anhtZThxMVAyLzd1czZyUFVsTjQ4aTc3Y0RTMEl6R1E5ZmF5cU01SGky?=
 =?utf-8?B?NHZKYjJGWHpTc3ZMZVA4b1lnSGFCQThtaHU0SEJLUklCUFlCSEoxbmxtbGVq?=
 =?utf-8?B?L05ScThjd2VhQUc3UFgzc3pnakxvUWR5TVFyVy9lM0E3QXVRdUY1V3pkT0ZY?=
 =?utf-8?B?YWJjZXhKZUc0ZDJjODkzN25QNTRGUEZyak8zbWlWR2J2RUtBNHdETjdxbjUv?=
 =?utf-8?B?RDZGekZjVXd3MTQ3YW82cmIvRHRCdnd1TEtOMjVWbWNNdW5vVnlzaFh2SXda?=
 =?utf-8?B?c012dmprYUNjeDBERS8zdmdmc2t6clE3Y2VIeC9OZGMvVTZJT3dZYXYrZjRo?=
 =?utf-8?Q?8+4Hn2BEevJkjdo+FGV3HuG4O?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3070a626-07a8-48b6-6530-08dd2f1e3de1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 13:21:48.9665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YhO5PC8dRwqN5H4qnkxC7Eb6L1xCOGqslwm3F+Is9TXgiOgB0ZQrBzjotTzcbjOy4GFVetppNIhyNamdbNkVwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4367

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIFphaGthIDxk
YW5pZWwuemFoa2FAZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCA3IEphbnVhcnkgMjAyNSAx
NToxOA0KPiBUbzogRGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJAbnZpZGlhLmNvbT4NCj4gQ2M6
IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+
OyBJZG8gU2NoaW1tZWwNCj4gPGlkb3NjaEBudmlkaWEuY29tPjsgbWt1YmVjZWtAc3VzZS5jeg0K
PiBTdWJqZWN0OiBSZTogW1JGQyBldGh0b29sXSBldGh0b29sOiBtb2NrIEpTT04gb3V0cHV0IGZv
ciAtLW1vZHVsZS1pbmZvDQo+IA0KPiBUaGUganNvbiBvdXRwdXQgbG9va3MgZ29vZCBvbiBteSBj
YXJkcyB3aXRoIENNSVMgbW9kdWxlcy4gT24gYSBkaWZmZXJlbnQNCj4gY2FyZCB0aGF0IGRvZXMg
bm90IHN1cHBvcnQgdGhlIENNSVMgaW50ZXJmYWNlLCB0aGUgb3V0cHV0IGZhbGxzIGJhY2sgdG8g
bm9uLQ0KPiBqc29uLCBldmVuIHdoZW4gLS1qc29uIGlzIHNwZWNpZmllZC4gTWF5YmUgdGhpcyBz
aG91bGQgcmV0dXJuIGFuIGVycm9yLiBPdGhlcg0KPiB0aGFuIHRoYXQsIGxvb2tzIGdvb2QgdG8g
bWUuIFRoYW5rcy4NCj4gDQoNClRoaXMgY29kZSBhZGRzIHN1cHBvcnQgb25seSBmb3IgQ01JUyBt
b2R1bGVzLCBJIGFtIHdvcmtpbmcgb24gY29tYmluaW5nIGFsbCB0aGUgbW9kdWxlcyBqc29uIHN1
cHBvcnQgdG9nZXRoZXIgYW5kIGRvaW5nIGEgcmVmYWN0b3Jpbmcgd29yayB0aGF0IHdhcyBuZWVk
ZWQuDQoNCkRpZCB5b3UgdGFrZSBhIGxvb2sgYXQgdGhlIGNvZGU/IEFueSBjb21tZW50cyB0aGVy
ZT8NCg0KVGhhbmtzLA0KRGFuaWVsbGUNCg0KPiBPbiAxLzIvMjUgMzoxOSBBTSwgRGFuaWVsbGUg
UmF0c29uIHdyb3RlOg0KPiA+IEhpLA0KPiA+DQo+ID4gQW55IGNvbW1lbnRzPw0KPiA+DQo+ID4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IERhbmllbCBaYWhrYSA8ZGFu
aWVsLnphaGthQGdtYWlsLmNvbT4NCj4gPj4gU2VudDogVGh1cnNkYXksIDE5IERlY2VtYmVyIDIw
MjQgMTk6MzUNCj4gPj4gVG86IERhbmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVyQG52aWRpYS5jb20+
DQo+ID4+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBKYWt1YiBLaWNpbnNraSA8a3ViYUBr
ZXJuZWwub3JnPjsgSWRvDQo+ID4+IFNjaGltbWVsIDxpZG9zY2hAbnZpZGlhLmNvbT47IG1rdWJl
Y2VrQHN1c2UuY3oNCj4gPj4gU3ViamVjdDogUmU6IFtSRkMgZXRodG9vbF0gZXRodG9vbDogbW9j
ayBKU09OIG91dHB1dCBmb3INCj4gPj4gLS1tb2R1bGUtaW5mbw0KPiA+Pg0KPiA+Pg0KPiA+PiBP
biAxMi8xOS8yNCA5OjE4IEFNLCBEYW5pZWxsZSBSYXRzb24gd3JvdGU6DQo+ID4+PiBIaSBEYW5p
ZWwsDQo+ID4+Pg0KPiA+Pj4gSSBkaWRu4oCZdCBnZXQgYSByZXBseSBmcm9tIHlvdS4NCj4gPj4+
IEFueXdheSwgaGVyZSdzIGEgbGlrZSB0byBteSBnaXQgcmVwb3NpdG9yeToNCj4gPj4gaHR0cHM6
Ly9naXRodWIuY29tL2RhbmllbGxlcnRzL2V0aHRvb2wvdHJlZS9lZXByb21fanNvbl9yZmMuDQo+
ID4+PiBUaGUgbGFzdCA0IGNvbW1pdHMgYXJlIHRoZSByZWxldmFudCBvbmVzLg0KPiA+Pj4NCj4g
Pj4+IEFsbCB0aGUgQ01JUyBtb2R1bGVzIGR1bXAgZmllbGRzIGFyZSBpbXBsZW1lbnRlZCB3ZXJl
IHNlbnQgdG8NCj4gPj4+IGludGVybmFsDQo+ID4+IHJldmlldy4NCj4gPj4+IFRoYW5rcywNCj4g
Pj4+IERhbmllbGxlDQo+ID4+DQo+ID4+IFRoYW5rIHlvdSEgSSdsbCB0cnkgaXQgb3V0IG9uIG15
IG1hY2hpbmVzLg0K

