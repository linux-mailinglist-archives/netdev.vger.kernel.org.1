Return-Path: <netdev+bounces-159619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A265A161CA
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 13:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2A88162DED
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 12:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F99B1DED45;
	Sun, 19 Jan 2025 12:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qsc.com header.i=@qsc.com header.b="fSwIv4TH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-160.mimecast.com (us-smtp-delivery-160.mimecast.com [170.10.129.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1438C1DED72
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737290825; cv=none; b=NQCzhlmDcRYW9yQpirNLaStrjyN9qHlkQ5Lkn6QI90rK10gqOTufmWOWf/5Ql4tlPmSOrT+/JdsC3UdsOje07OHF7BKi+Jm1kKCHehjOKRdmtUqZ5hI4hfieBElNtpI6uUegIJUWwRt67rXEWWomrXcJ9B2YzCFtcbwD6HTLBWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737290825; c=relaxed/simple;
	bh=/fKq3Y7irsp+5PHDDY9I6ggZaeozl+Smqi/AmxQIH1A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=fRiGWLEIaLmFpPD2VL6D61xg9n0rw75TXoMQQ3EyIpcQCeG9Y2DNmuD1UWmUhzTS2y1ucpGdEgkv0L/P1hoc548kSY/QuGxYu6FhSPudi43f/Eh8tpuQcZZIKrE2UAsYjbyW94+MXlPEmsHrLRyMbGYBLlrJxsIFqoh6kijlQak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qsc.com; spf=pass smtp.mailfrom=qsc.com; dkim=pass (1024-bit key) header.d=qsc.com header.i=@qsc.com header.b=fSwIv4TH; arc=none smtp.client-ip=170.10.129.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qsc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qsc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qsc.com; s=mimecast20190503;
	t=1737290821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/fKq3Y7irsp+5PHDDY9I6ggZaeozl+Smqi/AmxQIH1A=;
	b=fSwIv4THYjSD9wzRZ3UCkdtJdRb0xZm9bR9uylSmgk/vqbXSIKkXPPSNzoZasRce8PQIug
	L1VxyklEoBg0KUviI/jh/2fkfWJQXbwJJZoNimYuX/bwEKeOK2BPYYh9fvtu4NlldMOs/l
	4ZgGFcBvW3RXRNBxfYwRPgxwGt/RX0Y=
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-gkDB-52IPrmu9Au03Ozrsg-2; Sun,
 19 Jan 2025 07:46:58 -0500
X-MC-Unique: gkDB-52IPrmu9Au03Ozrsg-2
X-Mimecast-MFC-AGG-ID: gkDB-52IPrmu9Au03Ozrsg
Received: from BLAPR16MB3924.namprd16.prod.outlook.com (2603:10b6:208:274::20)
 by EA2PR16MB6279.namprd16.prod.outlook.com (2603:10b6:303:259::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Sun, 19 Jan
 2025 12:46:54 +0000
Received: from BLAPR16MB3924.namprd16.prod.outlook.com
 ([fe80::b2a:30e5:5aa4:9a24]) by BLAPR16MB3924.namprd16.prod.outlook.com
 ([fe80::b2a:30e5:5aa4:9a24%7]) with mapi id 15.20.8356.020; Sun, 19 Jan 2025
 12:46:54 +0000
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
Thread-Index: AQHa5yw/Yex3DnaEcEmG8NwWlW8TpbIYsdYAgAADkNyARRMEp4DBSD3W
Date: Sun, 19 Jan 2025 12:46:54 +0000
Message-ID: <BLAPR16MB3924E3DF8703DDCBC1C033BBF0E42@BLAPR16MB3924.namprd16.prod.outlook.com>
References: <BLAPR16MB392407EDC7DFA3089CC42E3CF0BE2@BLAPR16MB3924.namprd16.prod.outlook.com>
 <CANn89iL_p_pQaS=yjA2yZd2_o4Xp0U=J-ww4Ztp0V3DY=AufcA@mail.gmail.com>
 <BLAPR16MB392430582E67F952C115314CF0BE2@BLAPR16MB3924.namprd16.prod.outlook.com>
 <BLAPR16MB3924BB32CE2982432BAE103FF0622@BLAPR16MB3924.namprd16.prod.outlook.com>
In-Reply-To: <BLAPR16MB3924BB32CE2982432BAE103FF0622@BLAPR16MB3924.namprd16.prod.outlook.com>
Accept-Language: ru-RU, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR16MB3924:EE_|EA2PR16MB6279:EE_
x-ms-office365-filtering-correlation-id: ab51de83-9782-4079-9d68-08dd38875a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018
x-microsoft-antispam-message-info: =?utf-8?B?cEpOd00wSm1zREN4SlBuTXhVU005RWVHQnNPNlMvaFFQN3BJZi9RSjlOVTlE?=
 =?utf-8?B?ZHk5RHMrUVkyeTZZaC9TeXg1TkEzelRndEVMTkZLTGUrOHNUU2dEeGRDWnpv?=
 =?utf-8?B?YUtTMWdrNUJOclh1dEtRSjBqTTRnU0VESTRMc0h2WFZ4K0FiVWFwbjRyWU12?=
 =?utf-8?B?THVIek15S096b3hZTTFwTG9XNm9uWE0yWWtNVHVrL1hyV0Q5SkxYNHJYZlBK?=
 =?utf-8?B?Q0E0a1pPZ2dHdER3czRVdDV1Q3lXN3RBZ2I3cnNiRHRvWmM0Ykp6TU5VVjNB?=
 =?utf-8?B?TWF3eVRrZHk1TDFyaUZzZmlBd1orVFI0ZHViQXkxV3RycDA5WjcraTFDYlZw?=
 =?utf-8?B?SHI1ckRNSjF3T3drMDNlSVp5bTRwdVh2SWdmU2dXb3ZlOFVxSnlVZlQweUF0?=
 =?utf-8?B?UjdRN0tnWFBBU1Q3R0EvVklpLzZUMmJkOFM5NWY1WVpGVE1BeG1Ga0pyNmtE?=
 =?utf-8?B?QjRTcUhmak8zQU9uZTFGOVlrc2UxZlE1VkZENldSdWsvT2VsVzVhMUtWcFhx?=
 =?utf-8?B?MDljM1hkREVrbVk4V1hOTTVDQzh5NndZTCt0NHVtcUJya2I4Mnl4OTFEcWhM?=
 =?utf-8?B?bVNxbTIveGxheC9BZ0U4aGo4SzVUTXA5bHRSb2ZmamE5czlZb1QwNHppWndt?=
 =?utf-8?B?blN6M1VBUG43YWJqWGJtODEwc2xKUmZUWGw4TTNzNWoxYWVjTVluZ1Rxamtt?=
 =?utf-8?B?aWFOMTVLMEk3N0pXdzZQM2luZkZDWWZ4R0JuMlh1L2c5YXNyeTZRZ2VHbnFt?=
 =?utf-8?B?ZTVVSFlmTERydjhTNFB5UkZPUzJLSURKUzh2Y1doVGUwN0s5bFdIc1FadzF2?=
 =?utf-8?B?ODJhdFJHajZMdXBjRFc0Z3g4bkxYbmhLbU1LcE5Kbkhaa0pjT24wZmxBU1E0?=
 =?utf-8?B?aHhwOGEvWmo5dHQ3dmp3ZUZpWUtWcHJRK0h3SmpNT3N3MSt6VjNCcStVdFA4?=
 =?utf-8?B?SjJxZ0tEbm9zNENqc1c2ZmRDSG1vWjZkaUF1WE9CMFUyV3VRS0V5KzZSbzZx?=
 =?utf-8?B?MC9ZTmNWZnc4WE8yZUd1N09CTmZ2Ynp1MmE3UHJZZE1XTVVrYzZWOTREdmo0?=
 =?utf-8?B?aWpwN3g5UkkreVZVQjRVcm15d1dSN2hxV3RZTjVoN1Y4Rnp0OVBJMTRvRjRM?=
 =?utf-8?B?NXlqbVhsL0ZqUW5OME5DRHRXZnF3aFF1OGV4MkVwRFpoV0NsTkYvMlB2OVVG?=
 =?utf-8?B?c3d0c0xvVGJuZTRKU29JWWZzbDVNcFJtRE8rN0o2enh0WWU0TmhpR21wbFJh?=
 =?utf-8?B?VExVUVZyeE5IVmxVcnR4VHZ3MTlqK2RFaUg1Z0VsNDNWRVhoNWFTV29nYWQx?=
 =?utf-8?B?bnVkaWFpb3VvYkZvTnRwVVJCanA5ODk2cjFVZlNsZnNlYld5Y0ttTXY4MHRO?=
 =?utf-8?B?eFFiTDBkeWNocEkrcndEN2lyYkJ4UXVLUktxcWxWTkptZzVmL3V3Ky92Lzkz?=
 =?utf-8?B?eXY2U1pSUUs1TjQ5czNiZHRrK0ZPNWoxYkJoUExSNFZHUEhyNFVCNWhUWWll?=
 =?utf-8?B?ak1USEhHQWZqWXJuWWhKczBsc2JTc0M4U0MrWnlLbURMczJBMnBQTWFrajhB?=
 =?utf-8?B?WG5lZmZ3dDZjcTRqQ0Q0Z1FPTlNDR0NQWEhmd2pScHBEZ3U3aEFOaUZId1FU?=
 =?utf-8?B?c01HUzV1U2tCYUdqbklvYStGN0JLazFMSEV5RHNaejhBdmxCSXhlNS9sV2Ix?=
 =?utf-8?B?RG0wa0RZdVZJTEcrZW4yOXVacVE2dEdoWVhxSmdhTi9xb1ZrS2djQlJ0NnZP?=
 =?utf-8?B?RU94Q3B4RGxUaDduai92NFZIUGdBYThValJFZ2luSDBpSEgrYkVQei9CWlJi?=
 =?utf-8?B?NzJOWUV6ZzdXVkZOWjN0c0NPNU1WeWQyaDg4eVBPRDY2Y2tFc1dJby9zUnQx?=
 =?utf-8?Q?Ci9w5ui2KXUqB?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR16MB3924.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFZuYUVLd1plT0F5UnRJZnh5TEtZZnRha290aG1rUllVQlY0NExBK3FkekdM?=
 =?utf-8?B?bnFmRWRiMHgvTVA2SmRoWm1HVXYxWUlic01XbGZSNEF6VkcrSEpmT0ViZVZq?=
 =?utf-8?B?QjZFbkVocjhvbStGYUxPTk1RRXI5aldnZm5nQkc5K3JsUlhUY3NEMmJ6WGpU?=
 =?utf-8?B?V1diQ2JadXo1bno4Z0ZKaE5sQjFKNG5lREdpMnBjMnhlVnRmR0l3SXE1YVVo?=
 =?utf-8?B?Nkk0WHcvTDFPUWZQQk5nVnc0WS83ZnJuREtIazcxK1J6SGFaOWlkMkphSFo2?=
 =?utf-8?B?Kys4N0xBTERicnhhaVhrN2tHUHpyNWNMUnkvMnRUK3B4ZjN6MElYRkVGQ2gx?=
 =?utf-8?B?YXIzU2pUQktQTC9WMGpwRW1mS1pUcDFIYy9tL0ZiWCsrU0dNQ1VRRGtUeEYr?=
 =?utf-8?B?TjM2N3FYdEk4MGE5SlFXZ1pvWkw4K2tTNm1VdEdMWXZTT2djdEduZkxCREtL?=
 =?utf-8?B?aEFuQXpUUEdUU09Iazc0UmRkMExVbWl0Qy80MkpzTFl4bE9lNHF1QjRRUzNZ?=
 =?utf-8?B?ZUQ2T3laZk1iU2dRQlgvYzYvQkhsMUEySWE3MGxFMFI0YStlRTdJcStaRFR4?=
 =?utf-8?B?L3kwUERuSnVtTW5xZTh3bmlyZnBDQTlBWEpkOWRDVnVpT09KV0taN1FlK3NL?=
 =?utf-8?B?NGk2dThqVjlVTkdCNGFEWXpWYTZ0bWN3UHV3M0tQQWdleFhGc29vaklMSnBy?=
 =?utf-8?B?cE5sWmZiTVFBSFhQRFFRbFNiSUNOQlEveHpMcERzdnlMT1FsMWpTSm9FSk1C?=
 =?utf-8?B?Q0ZCN3BVL211MzZkK0cwNHZLcjFyeFAwdnRPUnVNU3BRZnFnY0FFT0N0R3c1?=
 =?utf-8?B?TEhUaWlwM203amxNeVJBanJicWdrOHhOUGlXZ292TU9qL0cycmRWclB1QWFD?=
 =?utf-8?B?Z0RvNjArWkNHanhzUjgvdjZBMmgzTTBreVZMcFRwOVVJVkk5allpbTkyMXkx?=
 =?utf-8?B?Vm5lTnNXbms1T1huTitDNmVoUUcrSnMrOWtYVnpRNm5wZFJ0K0o2UlI4TG5a?=
 =?utf-8?B?OXdXSWZxMllUcUs0VStDdUVNdFg2QUh0RkFRZHI0cG9hcjZXVjhjeVNKTXlq?=
 =?utf-8?B?aklYRlNGcHVNNlBVcHliK2JaVmFTdjVBaTVzZTYxYno2UDFMbjh3TS9RZVBI?=
 =?utf-8?B?cUp3MkE5N0Myckh1TFBwenU0WmpVL2Q0aVF2TlAwMnE0QnVwWHpmY0szdXNH?=
 =?utf-8?B?Wk05eXdVMVkxL0dRbVg1cFRncDgwdkpVdDBxdUtiNXJ1bjQ5dHlnWm1DVENL?=
 =?utf-8?B?akV1OUJZU1JoaVZrYkRPY3NFYm53dDZidDllNDExbkFZUmRBRnZwaTFjemdn?=
 =?utf-8?B?K1NGcmpob1BMQUdXYkhuSHJiTkYybTJmOUE0Tjc4cUNYMG5ERGJHVUtsOHlX?=
 =?utf-8?B?aTFxaCtYUFdBblpnbnVrbkNxenY5bnBrOXVFbDIwNU1BZ0dITGcvUUtzM0tH?=
 =?utf-8?B?OHhBeVhacVVoYjJQSVZxeXdmM1U1QU5wN0dMN2FXSXB0Y3VRZHJIMmhEMmpR?=
 =?utf-8?B?NExwOHd3bm9FM3J5NXR4eEdXNFFieTMrZmd3d09GMTh0bEcyemR1dVBwRjVp?=
 =?utf-8?B?SldvR3J6SFd1QWRsMFhqT1NtYVU5a3J1aUVUUTkzMUFYSlhHdXpjSjN0OHB0?=
 =?utf-8?B?U1FqY1ZDNWl1a3hocUxwL3dvbTR1L0Rhc04vR25NRDk1NjhUKzVzMGFEdjIz?=
 =?utf-8?B?dWJUOHlXeHI0bGRuMmd6VkNld21pMjF2U1U3QUpBaklQRDZzKzRYTTNUU2xl?=
 =?utf-8?B?SlkxYXRRclFldnVjeXR4cnBtelZhK2o4Y2l1ekZvbC8xejBOaHd0U2ZubG5Q?=
 =?utf-8?B?OVBPQnpSR0MxMUcyam9PdmJGT2pRSXBja1dKZ0VuNDJrZG9iN3ZLWEVFU3hs?=
 =?utf-8?B?R3BJa2ZlTTVnbU03bmphd3c1dW1oOXNRNWx1TzFQRkptVWxIN3BjeklBNXNk?=
 =?utf-8?B?aHFUems2VG5Qa0hDYzByd2IxSitua3dKQmR5YXZDUGUvOUlZWC82Rm1aaVAz?=
 =?utf-8?B?aUFnenYzNFZMcEpqNEJ3dU52RUt1Y1ZuR2QyZG5ldUJ3a0xNZG0wWkVXNEJt?=
 =?utf-8?B?Uk9VdzZzditXRkdiNE5WbE13Z2VOZzJ1K3FwaXBUVy9Td3BYQVFKS2xVZjNl?=
 =?utf-8?Q?uajS5a84xojk6qWZCM5xkbEI0?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: qsc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR16MB3924.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab51de83-9782-4079-9d68-08dd38875a4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2025 12:46:54.2591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23298f55-90ba-49c3-9286-576ec76d1e38
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fi64eNBTjuDH6JCfvu6ow8kcut3UeGwlrbF2onOeU4wYy+O67tMil1Jr9mVbFFCTIUvMJYvWSybX/p0TguUWsqOEfIbaik+gzO4iSxCjW9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2PR16MB6279
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O_wxQqtlJeQEOY1as6b1FCAvrlUJBe-c8SpAEvQC3kA_1737290816
X-Mimecast-Originator: qsc.com
Content-Language: ru-RU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

SSBiaXNlY3RlZCBrZXJuZWwgZnJvbSA2LjEyLCB3aGVyZSB0aGUgaXNzdWUgd2l0aCB0cmltbWlu
ZyBmcmFnbWVudGVkIFVEUCBwYWNrZXRzIHdhcyBmaXhlZCwgZG93biB0byA1LjE1LjIxLg0KDQpJ
IGhhdmUgaWRlbnRpZmllZCB0aGF0IGNvbW1pdCAgIjQ3Zjc1M2MxMTA4ZTI4N2VkYjNlMjdmYWQ4
YTc1MTFhOWQ1NTU3OGUgbmV0OiBzdG1tYWM6IGRpc2FibGUgU3BsaXQgSGVhZGVyIChTUEgpIGZv
ciBJbnRlbCBwbGF0Zm9ybXMiIGlzIGZpeGluZyB0aGUgcHJvYmxlbS4NCg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K0J7RgjogT2xla3NhbmRyIE1ha2Fyb3YgW0dM
XSA8T2xla3NhbmRyLk1ha2Fyb3ZAcXNjLmNvbT4NCtCe0YLQv9GA0LDQstC70LXQvdC+OiAxOCDR
gdC10L3RgtGP0LHRgNGPIDIwMjQg0LMuIDE2OjA2DQrQmtC+0LzRgzogRXJpYyBEdW1hemV0DQrQ
mtC+0L/QuNGPOiBBbGV4YW5kcmUgVG9yZ3VlOyBKb3NlIEFicmV1OyBEYXZpZCBTLiBNaWxsZXI7
IEpha3ViIEtpY2luc2tpOyBQYW9sbyBBYmVuaTsgTWF4aW1lIENvcXVlbGluOyBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1zdG0zMkBzdC1tZC1tYWlsbWFuLnN0b3JtcmVwbHkuY29tOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCtCi0LXQvNCwOiBSRTogQlVHOiBVRFAgUGFja2V0IENvcnJ1cHRpb24gSXNzdWUg
d2l0aCBzdG1tYWMgRHJpdmVyIG9uIExpbnV4IDUuMTUuMjEtcnQzMA0KDQpIaSBhbGwsDQoNCmlz
IHRoZXJlIGFueXRoaW5nIEkgY291bGQgdHJ5IHRvIGFkZHJlc3MgdGhpcyBpc3N1ZT8gSSBjb250
aW51ZSB0byBzZWUgdGhpcyBvbiAgTVNDIFNNMlMtRUwgYm9hcmQgdXNpbmcgTGludXggNS4xNS4y
MQ0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQrQntGCOiBPbGVr
c2FuZHIgTWFrYXJvdiBbR0xdIDxPbGVrc2FuZHIuTWFrYXJvdkBxc2MuY29tPg0K0J7RgtC/0YDQ
sNCy0LvQtdC90L46IDUg0LDQstCz0YPRgdGC0LAgMjAyNCDQsy4gMTc6MTYNCtCa0L7QvNGDOiBF
cmljIER1bWF6ZXQNCtCa0L7Qv9C40Y86IEFsZXhhbmRyZSBUb3JndWU7IEpvc2UgQWJyZXU7IERh
dmlkIFMuIE1pbGxlcjsgSmFrdWIgS2ljaW5za2k7IFBhb2xvIEFiZW5pOyBNYXhpbWUgQ29xdWVs
aW47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXN0bTMyQHN0LW1kLW1haWxtYW4uc3Rv
cm1yZXBseS5jb207IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZw0K0KLQtdC80LA6IFJFOiBCVUc6IFVEUCBQYWNrZXQgQ29y
cnVwdGlvbiBJc3N1ZSB3aXRoIHN0bW1hYyBEcml2ZXIgb24gTGludXggNS4xNS4yMS1ydDMwDQoN
CkhpIEVyaWMNCg0KVGhlIElQIHRvb2wgcmVwb3J0cyBubyB4ZHAgcHJvZ3JhbXMgb24gcmVjZWl2
aW5nIGludGVyZmFjZToNCg0KJCBpcCBsaW5rIHNob3cgZXRoMA0KMjogZXRoMDogPEJST0FEQ0FT
VCxNVUxUSUNBU1QsVVAsTE9XRVJfVVA+IG10dSAxNTAwIHFkaXNjIG1xIHFsZW4gMTAwMA0KICAg
IGxpbmsvZXRoZXIgMDA6MzA6ZDY6Mjk6OGQ6YzQgYnJkIGZmOmZmOmZmOmZmOmZmOmZmDQoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCtCe0YI6IEVyaWMgRHVtYXpl
dCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT4NCtCe0YLQv9GA0LDQstC70LXQvdC+OiA1INCw0LLQs9GD
0YHRgtCwIDIwMjQg0LMuIDE3OjAyDQrQmtC+0LzRgzogT2xla3NhbmRyIE1ha2Fyb3YgW0dMXQ0K
0JrQvtC/0LjRjzogQWxleGFuZHJlIFRvcmd1ZTsgSm9zZSBBYnJldTsgRGF2aWQgUy4gTWlsbGVy
OyBKYWt1YiBLaWNpbnNraTsgUGFvbG8gQWJlbmk7IE1heGltZSBDb3F1ZWxpbjsgbmV0ZGV2QHZn
ZXIua2VybmVsLm9yZzsgbGludXgtc3RtMzJAc3QtbWQtbWFpbG1hbi5zdG9ybXJlcGx5LmNvbTsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQrQotC10LzQsDogUmU6IEJVRzogVURQIFBhY2tldCBDb3JydXB0aW9uIElzc3Vl
IHdpdGggc3RtbWFjIERyaXZlciBvbiBMaW51eCA1LjE1LjIxLXJ0MzANCg0KLUV4dGVybmFsLQ0K
DQpPbiBNb24sIEF1ZyA1LCAyMDI0IGF0IDE6NDDigK9QTSBPbGVrc2FuZHIgTWFrYXJvdiBbR0xd
DQo8T2xla3NhbmRyLk1ha2Fyb3ZAcXNjLmNvbT4gd3JvdGU6DQo+DQo+IEhlbGxvIGFsbCwNCj4N
Cj4gT24gbXkgTVNDIFNNMlMtRUwgWzFdIHRoZXJlIGlzIGFuIEV0aGVybmV0IGRldmljZSBkcml2
ZW4gYnkgdGhlIHN0bW1hYyBkcml2ZXIsIHJ1bm5pbmcgb24gTGludXggdmVyc2lvbiA1LjE1LjIx
LXJ0MzAuIEkndmUgZW5jb3VudGVyZWQgYW4gaXNzdWUgd2hlcmUgVURQIHBhY2tldHMgd2l0aCBt
dWx0aXBsZSBmcmFnbWVudHMgYXJlIGJlaW5nIGNvcnJ1cHRlZC4NCj4NCj4gVGhlIHByb2JsZW0g
YXBwZWFycyB0byBiZSB0aGF0IHRoZSBzdG1tYWMgZHJpdmVyIGlzIHRydW5jYXRpbmcgVURQIHBh
Y2tldHMgd2l0aCBwYXlsb2FkcyBsYXJnZXIgdGhhbiAxNDcwIGJ5dGVzIGRvd24gdG8gMjU2IGJ5
dGVzLiBVRFAgcGF5bG9hZHMgb2YgMTQ3MCBieXRlcyBvciBsZXNzLCB3aGljaCBkbyBub3Qgc2V0
IHRoZSAiTW9yZSBmcmFnbWVudHMiIElQIGZpZWxkLCBhcmUgdHJhbnNtaXR0ZWQgY29ycmVjdGx5
Lg0KPg0KPiBUaGlzIGlzc3VlIGNhbiBiZSByZXByb2R1Y2VkIGJ5IHNlbmRpbmcgbGFyZ2UgdGVz
dCBkYXRhIG92ZXIgVURQIHRvIG15IEVsa2hhcnQgTGFrZSBtYWNoaW5lIGFuZCBvYnNlcnZpbmcg
dGhlIGRhdGEgY29ycnVwdGlvbi4gQXR0YWNoZWQgYXJlIHR3byBwYWNrZXQgY2FwdHVyZXM6IHNl
bmRlci5wY2FwLCBzaG93aW5nIHRoZSByZXN1bHQgb2YgYG5jIC11IFtFSEwgbWFjaGluZSBJUF0g
MjMyMyA8IHBhdHRlcm4udHh0YCBmcm9tIG15IHdvcmtzdGF0aW9uLCB3aGVyZSB0aGUgb3V0Z29p
bmcgVURQIGZyYWdtZW50cyBoYXZlIHRoZSBjb3JyZWN0IGNvbnRlbnQsIGFuZCByZWNlaXZlci5w
Y2FwLCBzaG93aW5nIHBhY2tldHMgY2FwdHVyZWQgb24gdGhlIEVITCBtYWNoaW5lIHdpdGggY29y
cnVwdGVkIFVEUCBmcmFnbWVudHMuIFRoZSBjb250ZW50cyBhcmUgdHJpbW1lZCBhdCAyNTYgYnl0
ZXMuDQo+DQo+IEkgdHJhY2tlZCB0aGUgaXNzdWUgZG93biB0byBkcml2ZXJzL25ldC9ldGhlcm5l
dC9zdG1pY3JvL3N0bW1hYy9zdG1tYWNfbWFpbi5jOjU1NTMsIHdoZXJlIHRoZSBkYXRhIGNvcnJ1
cHRpb24gb2NjdXJzOg0KPg0KPiBgYGANCj4gaWYgKCFza2IpIHsNCj4gdW5zaWduZWQgaW50IHBy
ZV9sZW4sIHN5bmNfbGVuOw0KPg0KPiBkbWFfc3luY19zaW5nbGVfZm9yX2NwdShwcml2LT5kZXZp
Y2UsIGJ1Zi0+YWRkciwNCj4gYnVmMV9sZW4sIGRtYV9kaXIpOw0KPg0KPiB4ZHBfaW5pdF9idWZm
KCZjdHgueGRwLCBidWZfc3osICZyeF9xLT54ZHBfcnhxKTsNCj4NCj4gYGBgDQoNCkhpIE9sZWsN
Cg0KRG8geW91IGhhdmUgYW4gYWN0aXZlIFhEUCBwcm9ncmFtID8NCg0KSWYgeWVzLCB3aGF0IGhh
cHBlbnMgaWYgeW91IGRvIG5vdCBlbmFibGUgWERQID8NCg0KDQo+DQo+IEFmdGVyIHRoZSBkcml2
ZXIgZmluaXNoZXMgc3luY2hyb25pemluZyB0aGUgRE1BLW1hcHBlZCBtZW1vcnkgZm9yIGNvbnN1
bXB0aW9uIGJ5IGNhbGxpbmcgZG1hX3N5bmNfc2luZ2xlX2Zvcl9jcHUsIHRoZSBjb250ZW50IG9m
IGJ1Zi0+cGFnZSBpcyBpbmNvbXBsZXRlLiBBIGRpYWdub3N0aWMgbWVzc2FnZSB1c2luZyBwcmlu
dF9oZXhfYnl0ZXMgc2hvd3MgdGhhdCBidWYtPnBhZ2UgY29udGFpbnMgbm90aGluZyAob3Igc29t
ZXRpbWVzIGdhcmJhZ2UgYnl0ZXMpIHBhc3QgdGhlIDB4ZmYgbWFyazoNCj4NCj4gYGBgDQo+IFsg
NjA2LjA5MDUzOV0gZG1hOiAwMDAwMDAwMDogMzAwMCAyOWQ2IGM0OGQgYmYwOCAzMGI4IDYyODAg
MDAwOCAwMDQ1IC4wLikuLi4uLjAuYi4uRS4NCj4gWyA2MDYuMDkwNTQ1XSBkbWE6IDAwMDAwMDEw
OiBkYzA1IGIzNzMgMDAyMCAxMTQwIDI1YWYgYThjMCA2ZDU4IGE4YzAgLi5zLiAuQC4uJS4uWG0u
Lg0KPiBbIDYwNi4wOTA1NDddIGRtYTogMDAwMDAwMjA6IDdhNTggMTNjMiAxMzA5IGNhMDUgNGU2
YyAzMDMwIDMxMzAgMjAzYSBYei4uLi4uLmxOMDAwMToNCj4gWyA2MDYuMDkwNTQ5XSBkbWE6IDAw
MDAwMDMwOiA2ZjU5IDcyNzUgNzMyMCA3Mjc0IDZlNjkgMjA2NyA2NTY4IDY1NzIgWW91ciBzdHJp
bmcgaGVyZQ0KPiBbIDYwNi4wOTA1NTFdIGRtYTogMDAwMDAwNDA6IDMwMGEgMzAzMCAzYTMyIDU5
MjAgNzU2ZiAyMDcyIDc0NzMgNjk3MiAuMDAwMjogWW91ciBzdHJpDQo+IFsgNjA2LjA5MDU1M10g
ZG1hOiAwMDAwMDA1MDogNjc2ZSA2ODIwIDcyNjUgMGE2NSAzMDMwIDMzMzAgMjAzYSA2ZjU5IG5n
IGhlcmUuMDAwMzogWW8NCj4gWyA2MDYuMDkwNTU1XSBkbWE6IDAwMDAwMDYwOiA3Mjc1IDczMjAg
NzI3NCA2ZTY5IDIwNjcgNjU2OCA2NTcyIDMwMGEgdXIgc3RyaW5nIGhlcmUuMA0KPiBbIDYwNi4w
OTA1NTZdIGRtYTogMDAwMDAwNzA6IDMwMzAgM2EzNCA1OTIwIDc1NmYgMjA3MiA3NDczIDY5NzIg
Njc2ZSAwMDQ6IFlvdXIgc3RyaW5nDQo+IFsgNjA2LjA5MDU1OF0gZG1hOiAwMDAwMDA4MDogNjgy
MCA3MjY1IDBhNjUgMzAzMCAzNTMwIDIwM2EgNmY1OSA3Mjc1IGhlcmUuMDAwNTogWW91cg0KPiBb
IDYwNi4wOTA1NjBdIGRtYTogMDAwMDAwOTA6IDczMjAgNzI3NCA2ZTY5IDIwNjcgNjU2OCA2NTcy
IDMwMGEgMzAzMCBzdHJpbmcgaGVyZS4wMDANCj4gWyA2MDYuMDkwNTYyXSBkbWE6IDAwMDAwMGEw
OiAzYTM2IDU5MjAgNzU2ZiAyMDcyIDc0NzMgNjk3MiA2NzZlIDY4MjAgNjogWW91ciBzdHJpbmcg
aA0KPiBbIDYwNi4wOTA1NjRdIGRtYTogMDAwMDAwYjA6IDcyNjUgMGE2NSAzMDMwIDM3MzAgMjAz
YSA2ZjU5IDcyNzUgNzMyMCBlcmUuMDAwNzogWW91ciBzDQo+IFsgNjA2LjA5MDU2Nl0gZG1hOiAw
MDAwMDBjMDogNzI3NCA2ZTY5IDIwNjcgNjU2OCA2NTcyIDMwMGEgMzAzMCAzYTM4IHRyaW5nIGhl
cmUuMDAwODoNCj4gWyA2MDYuMDkwNTY3XSBkbWE6IDAwMDAwMGQwOiA1OTIwIDc1NmYgMjA3MiA3
NDczIDY5NzIgNjc2ZSA2ODIwIDcyNjUgWW91ciBzdHJpbmcgaGVyDQo+IFsgNjA2LjA5MDU2OV0g
ZG1hOiAwMDAwMDBlMDogMGE2NSAzMDMwIDM5MzAgMjAzYSA2ZjU5IDcyNzUgNzMyMCA3Mjc0IGUu
MDAwOTogWW91ciBzdHINCj4gWyA2MDYuMDkwNTcxXSBkbWE6IDAwMDAwMGYwOiA2ZTY5IDIwNjcg
NjU2OCA2NTcyIDMwMGEgMzEzMCAzYTMwIDU5MjAgaW5nIGhlcmUuMDAxMDogWQ0KPiBbIDYwNi4w
OTA1NzNdIGRtYTogMDAwMDAxMDA6IDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAg
MDAwMCAuLi4uLi4uLi4uLi4uLi4uDQo+IFsgNjA2LjA5MDU3NV0gZG1hOiAwMDAwMDExMDogMDAw
MCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIC4uLi4uLi4uLi4uLi4uLi4NCj4g
WyA2MDYuMDkwNTc3XSBkbWE6IDAwMDAwMTIwOiAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAw
MCAwMDAwIDAwMDAgLi4uLi4uLi4uLi4uLi4uLg0KPiBbIDYwNi4wOTA1NzhdIGRtYTogMDAwMDAx
MzA6IDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAuLi4uLi4uLi4uLi4u
Li4uDQo+IGBgYA0KPg0KPiBJIHdvdWxkIGFwcHJlY2lhdGUgYW55IGluc2lnaHRzIG9yIHN1Z2dl
c3Rpb25zIG9uIGhvdyB0byByZXNvbHZlIHRoaXMgaXNzdWUuDQo+DQo+IEJlc3QgcmVnYXJkcywN
Cj4NCj4gQWxla3NhbmRyDQo+DQo+IDEgLSBodHRwczovL2VtYmVkZGVkLmF2bmV0LmNvbS9wcm9k
dWN0L21zYy1zbTJzLWVsLzxodHRwczovL2VtYmVkZGVkLmF2bmV0LmNvbS9wcm9kdWN0L21zYy1z
bTJzLWVsPg0K


