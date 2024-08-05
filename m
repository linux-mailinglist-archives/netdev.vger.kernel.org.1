Return-Path: <netdev+bounces-115791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B96947CAB
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 16:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED209281CF2
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 14:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CEB4DA00;
	Mon,  5 Aug 2024 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qsc.com header.i=@qsc.com header.b="k1zQ+5sc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-160.mimecast.com (us-smtp-delivery-160.mimecast.com [170.10.133.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CB32A1CA
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722867398; cv=none; b=MskWQIfDNKBgQdb+xd81gSND73v59VzEBX9G2bD6Te8De7aTSE2TFshnS0rwN+7HqMscgE3IzpVfsMVjRqxnUVKdMpfc7eG5vgWxQNeI/BtlR/8NedsZQfD7H3+ePMmENuoAqhOSJ6Y6+sZvrP0eTlHZDYAMxGoUgXOCG50LZME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722867398; c=relaxed/simple;
	bh=BAYzLhkNyMNuK16xL6C7ZKxYXMbLUcchmKBpJ0ymGkk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=K7BVd2T4ZeYWw4Yk1lxSaPm3fQ0PbDqniJQZ7B657qHprIqAAIhSO3MvA+V5NXWnHkKANVqnvPkh8kLVbGt3UO1mUSAcCUplGEiFGzwKfuUen7ttvJMbx9wZJ7ebkXX+INyfZs5clAAB9mcLfq0lG0Cu0XoMrnqdhjoX/aKZ/pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qsc.com; spf=pass smtp.mailfrom=qsc.com; dkim=pass (1024-bit key) header.d=qsc.com header.i=@qsc.com header.b=k1zQ+5sc; arc=none smtp.client-ip=170.10.133.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qsc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qsc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qsc.com; s=mimecast20190503;
	t=1722867395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BAYzLhkNyMNuK16xL6C7ZKxYXMbLUcchmKBpJ0ymGkk=;
	b=k1zQ+5sc/NOzp+fRc9ie7SPk6p1RNPxiWjg3CcwB+WzQoU09Bcj4QW6a2XlUlDxI2rGWaq
	tx7mfO+KxZEGcEShpLSBoRnQzGBQg9UW3QIZ6kr/e9k8Pc050x2CKfcj6EWsV7le7D4zmc
	MmcoXZKltLc67Jn8ndfSFX1rkHYpmz8=
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-vPo0xJhwNSa36D-HcG4biw-1; Mon, 05 Aug 2024 10:16:32 -0400
X-MC-Unique: vPo0xJhwNSa36D-HcG4biw-1
Received: from BLAPR16MB3924.namprd16.prod.outlook.com (2603:10b6:208:274::20)
 by PH7PR16MB5137.namprd16.prod.outlook.com (2603:10b6:510:2a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 14:16:27 +0000
Received: from BLAPR16MB3924.namprd16.prod.outlook.com
 ([fe80::b2a:30e5:5aa4:9a24]) by BLAPR16MB3924.namprd16.prod.outlook.com
 ([fe80::b2a:30e5:5aa4:9a24%3]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 14:16:27 +0000
From: "Oleksandr Makarov [GL]" <Oleksandr.Makarov@qsc.com>
To: Eric Dumazet <edumazet@google.com>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: BUG: UDP Packet Corruption Issue with stmmac Driver on Linux
 5.15.21-rt30
Thread-Topic: BUG: UDP Packet Corruption Issue with stmmac Driver on Linux
 5.15.21-rt30
Thread-Index: AQHa5yw/Yex3DnaEcEmG8NwWlW8TpbIYsdYAgAADkNw=
Date: Mon, 5 Aug 2024 14:16:27 +0000
Message-ID: <BLAPR16MB392430582E67F952C115314CF0BE2@BLAPR16MB3924.namprd16.prod.outlook.com>
References: <BLAPR16MB392407EDC7DFA3089CC42E3CF0BE2@BLAPR16MB3924.namprd16.prod.outlook.com>
 <CANn89iL_p_pQaS=yjA2yZd2_o4Xp0U=J-ww4Ztp0V3DY=AufcA@mail.gmail.com>
In-Reply-To: <CANn89iL_p_pQaS=yjA2yZd2_o4Xp0U=J-ww4Ztp0V3DY=AufcA@mail.gmail.com>
Accept-Language: ru-RU, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR16MB3924:EE_|PH7PR16MB5137:EE_
x-ms-office365-filtering-correlation-id: ec8c14dc-5379-4779-c2af-08dcb5593204
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018
x-microsoft-antispam-message-info: =?utf-8?B?dVJ5M05WT0lpZ2hzaGN1SHl6Mlc3T3h6aTRhUEhzYUtFWEJZQ2NCenhYalFn?=
 =?utf-8?B?dEVmMWdjUCtjZlROZlJIcktWNFVpYzA2TG1NazJMVFFsdk0xT05rdVNaK2wy?=
 =?utf-8?B?MHhBR3orbUo4cXpBVlR0S0dEQkFwNy8rajluZmNRZGZwcXhJelY5YnlFRndK?=
 =?utf-8?B?ZG9uWTAvbDNWQ1NmVHE1THAwUmxjT1QrbWFKSVA4WXpLU3RTVnozT2FrdVIz?=
 =?utf-8?B?RldQcnR2S2JCRVpoMVRnbzVTNjhqS0tyRFRQTDcwMXZoK1J4elRYVG9xMnUx?=
 =?utf-8?B?ZFZmTWJNRGlJbjNJUVVCQ2ZQSzdMTnVYZjRqdzJzNEpob3lPZVVDb28zOXFB?=
 =?utf-8?B?QXJLQkl6NmF2N0NCY2w0TU5haU1rcjhkQmxrVFErdjMrYnlScXZZVlNUYkI1?=
 =?utf-8?B?VW40WFdlTjV4NmhaUG1jVm5Ja0NUcE1aS2c0K2tOMEVWQ0tRN1M5KzQ5MTUv?=
 =?utf-8?B?K2V5NmJVNE4wQ2haaVNnaHEyVFpkZkU4bnJ6SHV5VkNlTDFYNjk0Z3ljVCtJ?=
 =?utf-8?B?NS9MV21QMksrd01QbFhyQjNSdlNYV0d0allqYWZnRkkrR2dPZEZBN3RrVm5m?=
 =?utf-8?B?Mk9iaTNLKzJBQ3RKSGlVOXpTSVhoMXRFVW9DZ2FRTmxRcUFGV2dobVZQOEto?=
 =?utf-8?B?WjNlaXcraG9CLzF2eFFLcjJIMXhUTlBoc1UxVEdxVDA0d0J1MU13YWRzZVkz?=
 =?utf-8?B?eUNuVlFXVlNySU94bktYSldVbGhiaFdieWtzZGk1UEh4WUJ2SFZqeXRadEVU?=
 =?utf-8?B?d2FvZGFFaWcyQit0TldkQkdXL0FmWWNxaXQ4ejJpQTFDQmN3WFNza290bmFW?=
 =?utf-8?B?OUtiT1JjWWMyWWU3WTh0dmZGUjRNVE5kazJQVm44MEFhKzVDWlBVZWh5WS9R?=
 =?utf-8?B?MkNNU0VCeXVTTEpwbmJRWFNwQkFEWUpuWW44K0xQSzRVUDFHS0lrRTUvMkhz?=
 =?utf-8?B?VkNTcWRMZXp1NDJ4ZVlFbEFMVTVpdThzTlphcUpaS1lEMW5ZUDhsWkNnc25P?=
 =?utf-8?B?cEEyeTFCelJVUnhYWFQyeEJmbUgrQm94Zlpib0IzODlVa3MvUEhqRGZySUdX?=
 =?utf-8?B?ZXJoTkZHTHJOWjU5QThSK29xaXJxWVZmR0tKalh0QnB0dm5KV1NjUlZVWkNa?=
 =?utf-8?B?M0pwS1l5czJvM0xrM1J2Q0N4RWFSK1FzWWEvNXdVcFVpbi9Jc0xGZ0xFelF1?=
 =?utf-8?B?YW1kVGpoWVhuVU1CNTFNclZMamQ3SzBDajRuSk9RUTNDaVFMSVp3YW1DWC9s?=
 =?utf-8?B?R2hrclVrTFJLVXFzTVZCRlZCSHVFOGVranpRbjJlU3p0bzBpdDhnYlBUZDNm?=
 =?utf-8?B?V1Y1S3hoNmVQcmtaSGcrcDVXNERzTE9mYVA5SmVrK29RVnFBTlVoeDUvZHB5?=
 =?utf-8?B?R1htQ2tpb2paNW9GUEVydnkyZ1pRTzI4d0hQd2sxRmovNkRNNjJERXp4SkNi?=
 =?utf-8?B?My9JemRPL0wvSUFEOGR1YWVVWnVibUFLZElQaDdud3piV2xEa2t1WHhIaEpw?=
 =?utf-8?B?S1pFNTk4VGRFTm1ra3RvWU84ZWcxczFRdlhDaGF6WTh6QWpMUGVlR1ZIdnVx?=
 =?utf-8?B?NGFWSFVGbVdGQlZqNEVFdVVPMlpuSmRtYitvMUhyb2s0STBWRStwWitrbnl1?=
 =?utf-8?B?VEJvaG1XbHM4ZGJBMVFtQ3FrS3JQcWVXSDlGUmNlcjdzUGgxNUZMNmpieE9K?=
 =?utf-8?B?c1JpblM5c0ZmaTZBUXlNOFJURTR5U1Y2MnJOa2NNTnRvbFp1Rko5TFdVcy9y?=
 =?utf-8?B?SWFnd0tGT2JNMFhhRUJIbG14WHp2Rnp5WTc1ZW9Gb3p5K20ybWVZNjZJVkRY?=
 =?utf-8?B?ZUo4bjV1dGsyVGlVdWpnYVpFMjloM1pUdi83enB5d0prYjZDZktIMmg2V2Z1?=
 =?utf-8?B?eGovaCtuZm1TYmFHa3J3ZGhpdFBwbEFRQTdpdUtpT0o5OUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR16MB3924.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y25EYVl0ZkowKzgyNEFJai9LampjWlcwQXRNK0xkOVBSQm1vM3hWY1Y1ZWFR?=
 =?utf-8?B?M2UzN2MvNmk5ZGgzZUh0ajZkRUpwZ1VVaVlrdzJyRkhWNDhVRFZVQklIYStL?=
 =?utf-8?B?a21Mejl4Tm90QTVSRXhCcU9UNUttNVBvaElVdEt0VWlMRWk4UC96Mnc1OWln?=
 =?utf-8?B?d2NBOUE4WG1renQwNWY1UWRKNFBIdDlNdmJGK3dEd2pZcGtwRkd4eVZ6d25w?=
 =?utf-8?B?V0xJZkpoTlRmbVRiM1VLeU1IQmhLL0Q1cVdQTFZCMDdjSUxtZnc1a25jWEpv?=
 =?utf-8?B?Q1IvaVY0OTNtbjM2Uzg5eDA5cWVHSmYvVE5xR1F4TU1ZdVgxZElLenNmbUlE?=
 =?utf-8?B?UlFsWUdOMU5sOGI4UFRCVkpqRE51NHVqZDBXbE43WjArcTVTaDVlQXJzYXVI?=
 =?utf-8?B?OFhpTTVoTFYwY3FyYi96cm9VQk9RUUE3T1NVVmdLUDRlUkJ6b2pYVWNtMDJo?=
 =?utf-8?B?Z3BMNmw2Z2Q4NUgyNHlQVFdBM3Rod1RLZ09md1JWTFhDTVFZNTlNWFVVVkVi?=
 =?utf-8?B?ait0d3h6QnNQcFZTR0E5eE43aDFvQldiOCtzbnVPT1VRQTkxRTlEdS91TXNP?=
 =?utf-8?B?NTZzaWVMRUpZOFVlODZZdkNYNGoyeUhKSVZZc2IvYy9RNHhCdEVSc3ZqWVp3?=
 =?utf-8?B?b0pSS1plT3QyTHlFQ1UwUVRlOG1GbW9jWENRTHlDSXdxM1d0bVJwOUt1MGdI?=
 =?utf-8?B?ZEFDRHlRVGhUakkyTWlxNjZlZ3lJemR1c2J0cE9XaUcydDlpREwrYWNmVFQ1?=
 =?utf-8?B?WURCd294R2RLZ2xabFJ3Wi9qSi9vNVY4US9FaDBCVnNwRjR3STJHSnBDLytY?=
 =?utf-8?B?UEZEQWcrUFVFbndBVXpHajNvK2owL1NEWVdTU1dQUGhMZDdJQUlqM0pNMEt3?=
 =?utf-8?B?cEQzdGNpMWFuQmZMZUpuSkFYek93QW12K3I1bVg0K1JGY1EydE56VlNuK2Ir?=
 =?utf-8?B?d3Zqd1NwbDVHcDJBdnlTMXlTVk9FRVg0elRIUkJySXc4c1BySHp3M2RJakNF?=
 =?utf-8?B?dy9TdmNSU2VMd1JjWWYxZ0RjRjRVVG1SUVJEMjFjNkJ0MU1lVkd4M0JrV0FZ?=
 =?utf-8?B?ZDFtQUluY1BWVlFETmp0bGhsOXh3OUwvRnQzNHovMzMrUjlmYlhMYWRYdDFC?=
 =?utf-8?B?bVRmZk1vUUQzdEZzdkRacEpoVldNUEpsY3FHaDdzTUV0bjR1azBUV2czOUky?=
 =?utf-8?B?bDRiN2kyM3BJZFBoWURaWE5ybFBtbXdMU1lPamgzZWR4aDR2MlgwL2Zqbmp6?=
 =?utf-8?B?OS9RNFdTK3ZDYVppUlFPOSs1dSs3bXVDd2dSUlM4cFlBTkhmQkcxY2xRU1lB?=
 =?utf-8?B?MndlUDl5OER4VnlvUTVFbkFlRmp0VlZGdFJaUDdvRHlqTDJJUFZJSGdRNy9K?=
 =?utf-8?B?bVNLMkVULzhwVFV6aDBKODdtb1hxNEtFb3RZcVh4czZJWGsrcWttUmNnL1d3?=
 =?utf-8?B?dGgzR0FqWHpzZ1ZuVW5teW5jQ2t0dU9UNDA5Yi93d1ZSOWZWUk81cXhuVlhV?=
 =?utf-8?B?N21aWk1KZFFONnJQVDJpa2NUeTJsUFBsVHhSYzBUY0JXdFBsZW84aWtpbCs4?=
 =?utf-8?B?bWx6c3M3d3ZGblpNeFZ6MVNtc2tINC84RUZaNTlkYm5EUXZsSktITVF1Mkg3?=
 =?utf-8?B?ckZhYTJPY2VkUk1CS2VEL05jRitsbUkwN3o1MmhaZTBuWUpJTm5LL0FGVTYv?=
 =?utf-8?B?TGV0VllMelVicWQvT3piUnFQdEI3NmpWbXE0OW05bEV0WGtoSVZ1UjZCTGJ3?=
 =?utf-8?B?cnNNblVFMFNpcU5vQWI4d3RuQ3o5b2YwRXpTUkk4Y1BqcTdxRmkwNG9jQ1k0?=
 =?utf-8?B?L0pleU0zNkxBeFoyZ1hyTi9FVENQMXpVN3N3VldPdUlzRVcxWis0N01HU3JZ?=
 =?utf-8?B?LzlBVW5JS2lFaHFEQ3BIUFJjTkhBaHRpZmw1THUzYXBGYXlDTGhkTGUrU3BK?=
 =?utf-8?B?L1NIVGJYNFlXQmM4QWxmZnE3WW1hUWpCRTMvVStQRlNqTFlWOGExQ05RakNI?=
 =?utf-8?B?bDhBRWU2M1ozRDV4ai9EbnJMMHBXZjV3R1ovazFGenpKVE5SUTVmb05DMVNv?=
 =?utf-8?B?Z0lOdXZZMkwxWSt6ejlmOERJZ0NBcVJwdFBDd2picmtDbGF1VUZJRmxiK0Vr?=
 =?utf-8?Q?WNlTTKhY8W2+G9oqg5fA3S2Qu?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: qsc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR16MB3924.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8c14dc-5379-4779-c2af-08dcb5593204
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 14:16:27.5463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23298f55-90ba-49c3-9286-576ec76d1e38
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o9rxBevHdM7c0OFXC/WbLbVBFsP/hOynmv3fdcp5UbHjAMgvfjH/tjKsIdz72qjkkCh/YXRXeGV4sZYV7UBx0NGmc2fKRFy28SQ36hBXN8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR16MB5137
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: qsc.com
Content-Language: ru-RU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

SGkgRXJpYwoKVGhlIElQIHRvb2wgcmVwb3J0cyBubyB4ZHAgcHJvZ3JhbXMgb24gcmVjZWl2aW5n
IGludGVyZmFjZToKCiQgaXAgbGluayBzaG93IGV0aDAKMjogZXRoMDogPEJST0FEQ0FTVCxNVUxU
SUNBU1QsVVAsTE9XRVJfVVA+IG10dSAxNTAwIHFkaXNjIG1xIHFsZW4gMTAwMAogICAgbGluay9l
dGhlciAwMDozMDpkNjoyOTo4ZDpjNCBicmQgZmY6ZmY6ZmY6ZmY6ZmY6ZmYKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18K0J7RgjogRXJpYyBEdW1hemV0IDxlZHVtYXpl
dEBnb29nbGUuY29tPgrQntGC0L/RgNCw0LLQu9C10L3QvjogNSDQsNCy0LPRg9GB0YLQsCAyMDI0
INCzLiAxNzowMgrQmtC+0LzRgzogT2xla3NhbmRyIE1ha2Fyb3YgW0dMXQrQmtC+0L/QuNGPOiBB
bGV4YW5kcmUgVG9yZ3VlOyBKb3NlIEFicmV1OyBEYXZpZCBTLiBNaWxsZXI7IEpha3ViIEtpY2lu
c2tpOyBQYW9sbyBBYmVuaTsgTWF4aW1lIENvcXVlbGluOyBuZXRkZXZAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1zdG0zMkBzdC1tZC1tYWlsbWFuLnN0b3JtcmVwbHkuY29tOyBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcK0KLQ
tdC80LA6IFJlOiBCVUc6IFVEUCBQYWNrZXQgQ29ycnVwdGlvbiBJc3N1ZSB3aXRoIHN0bW1hYyBE
cml2ZXIgb24gTGludXggNS4xNS4yMS1ydDMwCgotRXh0ZXJuYWwtCgpPbiBNb24sIEF1ZyA1LCAy
MDI0IGF0IDE6NDDigK9QTSBPbGVrc2FuZHIgTWFrYXJvdiBbR0xdCjxPbGVrc2FuZHIuTWFrYXJv
dkBxc2MuY29tPiB3cm90ZToKPgo+IEhlbGxvIGFsbCwKPgo+IE9uIG15IE1TQyBTTTJTLUVMIFsx
XSB0aGVyZSBpcyBhbiBFdGhlcm5ldCBkZXZpY2UgZHJpdmVuIGJ5IHRoZSBzdG1tYWMgZHJpdmVy
LCBydW5uaW5nIG9uIExpbnV4IHZlcnNpb24gNS4xNS4yMS1ydDMwLiBJJ3ZlIGVuY291bnRlcmVk
IGFuIGlzc3VlIHdoZXJlIFVEUCBwYWNrZXRzIHdpdGggbXVsdGlwbGUgZnJhZ21lbnRzIGFyZSBi
ZWluZyBjb3JydXB0ZWQuCj4KPiBUaGUgcHJvYmxlbSBhcHBlYXJzIHRvIGJlIHRoYXQgdGhlIHN0
bW1hYyBkcml2ZXIgaXMgdHJ1bmNhdGluZyBVRFAgcGFja2V0cyB3aXRoIHBheWxvYWRzIGxhcmdl
ciB0aGFuIDE0NzAgYnl0ZXMgZG93biB0byAyNTYgYnl0ZXMuIFVEUCBwYXlsb2FkcyBvZiAxNDcw
IGJ5dGVzIG9yIGxlc3MsIHdoaWNoIGRvIG5vdCBzZXQgdGhlICJNb3JlIGZyYWdtZW50cyIgSVAg
ZmllbGQsIGFyZSB0cmFuc21pdHRlZCBjb3JyZWN0bHkuCj4KPiBUaGlzIGlzc3VlIGNhbiBiZSBy
ZXByb2R1Y2VkIGJ5IHNlbmRpbmcgbGFyZ2UgdGVzdCBkYXRhIG92ZXIgVURQIHRvIG15IEVsa2hh
cnQgTGFrZSBtYWNoaW5lIGFuZCBvYnNlcnZpbmcgdGhlIGRhdGEgY29ycnVwdGlvbi4gQXR0YWNo
ZWQgYXJlIHR3byBwYWNrZXQgY2FwdHVyZXM6IHNlbmRlci5wY2FwLCBzaG93aW5nIHRoZSByZXN1
bHQgb2YgYG5jIC11IFtFSEwgbWFjaGluZSBJUF0gMjMyMyA8IHBhdHRlcm4udHh0YCBmcm9tIG15
IHdvcmtzdGF0aW9uLCB3aGVyZSB0aGUgb3V0Z29pbmcgVURQIGZyYWdtZW50cyBoYXZlIHRoZSBj
b3JyZWN0IGNvbnRlbnQsIGFuZCByZWNlaXZlci5wY2FwLCBzaG93aW5nIHBhY2tldHMgY2FwdHVy
ZWQgb24gdGhlIEVITCBtYWNoaW5lIHdpdGggY29ycnVwdGVkIFVEUCBmcmFnbWVudHMuIFRoZSBj
b250ZW50cyBhcmUgdHJpbW1lZCBhdCAyNTYgYnl0ZXMuCj4KPiBJIHRyYWNrZWQgdGhlIGlzc3Vl
IGRvd24gdG8gZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvc3RtbWFjX21haW4u
Yzo1NTUzLCB3aGVyZSB0aGUgZGF0YSBjb3JydXB0aW9uIG9jY3VyczoKPgo+IGBgYAo+IGlmICgh
c2tiKSB7Cj4gdW5zaWduZWQgaW50IHByZV9sZW4sIHN5bmNfbGVuOwo+Cj4gZG1hX3N5bmNfc2lu
Z2xlX2Zvcl9jcHUocHJpdi0+ZGV2aWNlLCBidWYtPmFkZHIsCj4gYnVmMV9sZW4sIGRtYV9kaXIp
Owo+Cj4geGRwX2luaXRfYnVmZigmY3R4LnhkcCwgYnVmX3N6LCAmcnhfcS0+eGRwX3J4cSk7Cj4K
PiBgYGAKCkhpIE9sZWsKCkRvIHlvdSBoYXZlIGFuIGFjdGl2ZSBYRFAgcHJvZ3JhbSA/CgpJZiB5
ZXMsIHdoYXQgaGFwcGVucyBpZiB5b3UgZG8gbm90IGVuYWJsZSBYRFAgPwoKCj4KPiBBZnRlciB0
aGUgZHJpdmVyIGZpbmlzaGVzIHN5bmNocm9uaXppbmcgdGhlIERNQS1tYXBwZWQgbWVtb3J5IGZv
ciBjb25zdW1wdGlvbiBieSBjYWxsaW5nIGRtYV9zeW5jX3NpbmdsZV9mb3JfY3B1LCB0aGUgY29u
dGVudCBvZiBidWYtPnBhZ2UgaXMgaW5jb21wbGV0ZS4gQSBkaWFnbm9zdGljIG1lc3NhZ2UgdXNp
bmcgcHJpbnRfaGV4X2J5dGVzIHNob3dzIHRoYXQgYnVmLT5wYWdlIGNvbnRhaW5zIG5vdGhpbmcg
KG9yIHNvbWV0aW1lcyBnYXJiYWdlIGJ5dGVzKSBwYXN0IHRoZSAweGZmIG1hcms6Cj4KPiBgYGAK
PiBbIDYwNi4wOTA1MzldIGRtYTogMDAwMDAwMDA6IDMwMDAgMjlkNiBjNDhkIGJmMDggMzBiOCA2
MjgwIDAwMDggMDA0NSAuMC4pLi4uLi4wLmIuLkUuCj4gWyA2MDYuMDkwNTQ1XSBkbWE6IDAwMDAw
MDEwOiBkYzA1IGIzNzMgMDAyMCAxMTQwIDI1YWYgYThjMCA2ZDU4IGE4YzAgLi5zLiAuQC4uJS4u
WG0uLgo+IFsgNjA2LjA5MDU0N10gZG1hOiAwMDAwMDAyMDogN2E1OCAxM2MyIDEzMDkgY2EwNSA0
ZTZjIDMwMzAgMzEzMCAyMDNhIFh6Li4uLi4ubE4wMDAxOgo+IFsgNjA2LjA5MDU0OV0gZG1hOiAw
MDAwMDAzMDogNmY1OSA3Mjc1IDczMjAgNzI3NCA2ZTY5IDIwNjcgNjU2OCA2NTcyIFlvdXIgc3Ry
aW5nIGhlcmUKPiBbIDYwNi4wOTA1NTFdIGRtYTogMDAwMDAwNDA6IDMwMGEgMzAzMCAzYTMyIDU5
MjAgNzU2ZiAyMDcyIDc0NzMgNjk3MiAuMDAwMjogWW91ciBzdHJpCj4gWyA2MDYuMDkwNTUzXSBk
bWE6IDAwMDAwMDUwOiA2NzZlIDY4MjAgNzI2NSAwYTY1IDMwMzAgMzMzMCAyMDNhIDZmNTkgbmcg
aGVyZS4wMDAzOiBZbwo+IFsgNjA2LjA5MDU1NV0gZG1hOiAwMDAwMDA2MDogNzI3NSA3MzIwIDcy
NzQgNmU2OSAyMDY3IDY1NjggNjU3MiAzMDBhIHVyIHN0cmluZyBoZXJlLjAKPiBbIDYwNi4wOTA1
NTZdIGRtYTogMDAwMDAwNzA6IDMwMzAgM2EzNCA1OTIwIDc1NmYgMjA3MiA3NDczIDY5NzIgNjc2
ZSAwMDQ6IFlvdXIgc3RyaW5nCj4gWyA2MDYuMDkwNTU4XSBkbWE6IDAwMDAwMDgwOiA2ODIwIDcy
NjUgMGE2NSAzMDMwIDM1MzAgMjAzYSA2ZjU5IDcyNzUgaGVyZS4wMDA1OiBZb3VyCj4gWyA2MDYu
MDkwNTYwXSBkbWE6IDAwMDAwMDkwOiA3MzIwIDcyNzQgNmU2OSAyMDY3IDY1NjggNjU3MiAzMDBh
IDMwMzAgc3RyaW5nIGhlcmUuMDAwCj4gWyA2MDYuMDkwNTYyXSBkbWE6IDAwMDAwMGEwOiAzYTM2
IDU5MjAgNzU2ZiAyMDcyIDc0NzMgNjk3MiA2NzZlIDY4MjAgNjogWW91ciBzdHJpbmcgaAo+IFsg
NjA2LjA5MDU2NF0gZG1hOiAwMDAwMDBiMDogNzI2NSAwYTY1IDMwMzAgMzczMCAyMDNhIDZmNTkg
NzI3NSA3MzIwIGVyZS4wMDA3OiBZb3VyIHMKPiBbIDYwNi4wOTA1NjZdIGRtYTogMDAwMDAwYzA6
IDcyNzQgNmU2OSAyMDY3IDY1NjggNjU3MiAzMDBhIDMwMzAgM2EzOCB0cmluZyBoZXJlLjAwMDg6
Cj4gWyA2MDYuMDkwNTY3XSBkbWE6IDAwMDAwMGQwOiA1OTIwIDc1NmYgMjA3MiA3NDczIDY5NzIg
Njc2ZSA2ODIwIDcyNjUgWW91ciBzdHJpbmcgaGVyCj4gWyA2MDYuMDkwNTY5XSBkbWE6IDAwMDAw
MGUwOiAwYTY1IDMwMzAgMzkzMCAyMDNhIDZmNTkgNzI3NSA3MzIwIDcyNzQgZS4wMDA5OiBZb3Vy
IHN0cgo+IFsgNjA2LjA5MDU3MV0gZG1hOiAwMDAwMDBmMDogNmU2OSAyMDY3IDY1NjggNjU3MiAz
MDBhIDMxMzAgM2EzMCA1OTIwIGluZyBoZXJlLjAwMTA6IFkKPiBbIDYwNi4wOTA1NzNdIGRtYTog
MDAwMDAxMDA6IDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAuLi4uLi4u
Li4uLi4uLi4uCj4gWyA2MDYuMDkwNTc1XSBkbWE6IDAwMDAwMTEwOiAwMDAwIDAwMDAgMDAwMCAw
MDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgLi4uLi4uLi4uLi4uLi4uLgo+IFsgNjA2LjA5MDU3N10g
ZG1hOiAwMDAwMDEyMDogMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIC4u
Li4uLi4uLi4uLi4uLi4KPiBbIDYwNi4wOTA1NzhdIGRtYTogMDAwMDAxMzA6IDAwMDAgMDAwMCAw
MDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAuLi4uLi4uLi4uLi4uLi4uCj4gYGBgCj4KPiBJ
IHdvdWxkIGFwcHJlY2lhdGUgYW55IGluc2lnaHRzIG9yIHN1Z2dlc3Rpb25zIG9uIGhvdyB0byBy
ZXNvbHZlIHRoaXMgaXNzdWUuCj4KPiBCZXN0IHJlZ2FyZHMsCj4KPiBBbGVrc2FuZHIKPgo+IDEg
LSBodHRwczovL2VtYmVkZGVkLmF2bmV0LmNvbS9wcm9kdWN0L21zYy1zbTJzLWVsLzxodHRwczov
L2VtYmVkZGVkLmF2bmV0LmNvbS9wcm9kdWN0L21zYy1zbTJzLWVsPgoNCg==


