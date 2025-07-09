Return-Path: <netdev+bounces-205569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB25AFF506
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 00:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3DF11895BCE
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 22:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461BB2367B8;
	Wed,  9 Jul 2025 22:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rEpDgBWg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6031821B8F8;
	Wed,  9 Jul 2025 22:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752101671; cv=fail; b=C671r1tH7XKxhNCmSHhMX8b5m5YMqs+f98olDvtQID7B6YJcJgdU884gSxXbzRRHzjJowYYMelYjZIDgOdznssP8DiFwfIGOuCaKBMUFtagcLLCNvAYXP58BPy5TRBIA8pof6C8Sh3G+KD3lnWEx5G9Dw5Fp0qGSw7vd5k7w31M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752101671; c=relaxed/simple;
	bh=+6xKEI9SKxAqSfyiAWtMDPcO2yjFNtemMFyAfenRcfM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V3QlRtAcTpjxj4ryx/l9aZefIMt6WD+mu1wwfQrUvIi3wA/x+qy/wTf0SKyjb+m1QIdiSD15k51bp6ykdQbt+0fm/++la+JyKlrh01cyUEZycoUNiKm1tpiLYj7UmcUsHI2SdboyqGpgkxPeZQcd+ySZMZBCZfZVwgMNamnuEPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rEpDgBWg; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nokqHK/1XYYdNSVuWpfMTBBs5YkgfmxU264dB5E29fKU+WHilK07MyJtQ1otpgMR/JYUtkQIz44sWqI/1maMbCCVwjBV1gkZpxpHF4mz93l+c3vEzyN2aUgtGHwsIZezsqd05AOtvpVqymPG3/PuGw6jdk9/ge3lGUaqVFkHVALv/sI8fP6LF+S1ygbZbD6EZD5rGgk1bHPJnG1rtQ8+h0TeeJvC80G7pla7V/fV6X1mUF2En2h+CJtJtvQNF0U3vJULUsn3pgJ6LLG8UuIrJ1BWIWa8HkJAS3aEb6aHHnnWuFMrjxPxp0dbUYvsSGX/bTu9gw5cBHbWmvhqppQvyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6xKEI9SKxAqSfyiAWtMDPcO2yjFNtemMFyAfenRcfM=;
 b=oS78dOBagtuu3lRSCFkmuzzUJiQtPALngvCeK55jx/n2SSXLMYKrxzZKjhuRsmiLFoodi9I/MaemL56Z9zTOdl4Rf3BRoncBqmsbzzuVAZjzdprXKKwl6yd7Lim0yrzZvSA0t66j1c5NH/D4CXh3t5WNLkUcN0NJYmhMkTBpAHQmjMVGaCL6k22uQPwyZCkhAWbArwLO4kL4RBnZJdTzx3RYMVQrIVUytq+FVd9+CDKRcukNS7LWdg1xwbBM0COc6AKnYLP0BvTqn9MPIn4nd57NSDA7p899gxprF4BKjA3LI/O5EaH6RLfrV2QV9s1Ln/l6UOkJK2jpcP0odUonzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6xKEI9SKxAqSfyiAWtMDPcO2yjFNtemMFyAfenRcfM=;
 b=rEpDgBWgOfSQM6dUAZm/gueDgSCFF41i/yNsT3+Pe6f5e6hWx6a14JHZdRbrGBC4ZEvZCWnOfvfiLzvP1PFOXKGlCcTCFFaCPG3EBV+qxUTjorUIqDfmMTz8moLJLqi5SP7Fc58T1ubSYc9+dzV9phEM3V4rv9xNwz9RuZ6XOoyLQqZDiDmjWfHkwiJ+rfpxQMHFTwtYz6M4qsxcf1iNmlO7gmzKapN8NdX63FpSM3QGldu3TUMcVJgLpGURNx/V/fazVaXOlLFLW5BJuztjXpAp64IeZPmFZ6j9k6HdO3H6zkYn0XBlsmffCs+4grHbCUBzg9f4EO7IsQ84Pbdvlw==
Received: from LV3PR11MB8742.namprd11.prod.outlook.com (2603:10b6:408:212::14)
 by BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 22:54:24 +0000
Received: from LV3PR11MB8742.namprd11.prod.outlook.com
 ([fe80::d5c5:fbb6:36fe:3fbb]) by LV3PR11MB8742.namprd11.prod.outlook.com
 ([fe80::d5c5:fbb6:36fe:3fbb%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 22:54:24 +0000
From: <Tristram.Ha@microchip.com>
To: <vadim.fedorenko@linux.dev>
CC: <maxime.chevallier@bootlin.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<marex@denx.de>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Woojung.Huh@microchip.com>,
	<andrew@lunn.ch>, <olteanv@gmail.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>
Subject: RE: [PATCH net-next v3 7/7] net: dsa: microchip: Disable PTP function
 of KSZ8463
Thread-Topic: [PATCH net-next v3 7/7] net: dsa: microchip: Disable PTP
 function of KSZ8463
Thread-Index: AQHb8GkNuhIQFaBZrUSJjTnvkDtJ/bQpy0CAgACbDpA=
Date: Wed, 9 Jul 2025 22:54:24 +0000
Message-ID:
 <LV3PR11MB87427E7BBE2FFC011FD4410DEC49A@LV3PR11MB8742.namprd11.prod.outlook.com>
References: <20250709003234.50088-1-Tristram.Ha@microchip.com>
 <20250709003234.50088-8-Tristram.Ha@microchip.com>
 <96cdeb5c-dd55-4800-9046-09ebbb818e8b@linux.dev>
In-Reply-To: <96cdeb5c-dd55-4800-9046-09ebbb818e8b@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8742:EE_|BL3PR11MB6363:EE_
x-ms-office365-filtering-correlation-id: 9f73459a-3cee-40ac-b62f-08ddbf3b8d0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZFlLVGNNTEh1SFVDTk9ablo3NUg3NGVxT0lkWHdVMGhQSldLQ1N5NjR3NjZJ?=
 =?utf-8?B?TWp0eFNLbnZLSGhoTlJlZ1h2YTFGdUtMNDV0WjBMMVA1OFp0YlU1OWd0dWdQ?=
 =?utf-8?B?elA1TWRBWlR3UHlSTTlsNHJqeW51YmlpUkdYd3k5UGxjeFFndXo0d3FEdEtK?=
 =?utf-8?B?YWZ1TmhOUjJRdVRQYnlHUFFhanlEOGhNcW9zeVp6YkZaNUltdEJkWVlZZlZo?=
 =?utf-8?B?MHdwaXlCL2plZ2t3enk3MW9nUnlwYldyMkt4Z1NDeVRGZHlQU0QrOHpNeXo0?=
 =?utf-8?B?YWJjQzFYVGFHeHplREprWGZveDU3M096TldyK0RiODk3TDVoSklHZmVDdnIy?=
 =?utf-8?B?Z1FIWjAyL0gvU0pma0Q0U2twL0hZamFoc3MrS0owdVVvZXc5aXpYQjJHMnZU?=
 =?utf-8?B?cjRoUlpmMzV6cHB3dlN1Sms2ZDVFQWxEYWg2QmFQTXBpTDFMZTNCK2RkalRX?=
 =?utf-8?B?YkUwMExVUXVYMmhQSDkzWDRiNHEyMDBqRUo0SnNWTmFzZ0VzcUVVeG5IUE9D?=
 =?utf-8?B?andZWTlzd3ViT0lVUFlpTGpGMDVEdk9lWHh5U2JYQlJVb3Z2SnYrNzExKzBa?=
 =?utf-8?B?Nkw0Qnc3b252Rk5VbFA4Ym13R1IvWHU1cE5haDR6Y0lPc3pXL2VKTytidFpt?=
 =?utf-8?B?aVlkTitJdzdUdXVmMzNRTVhUV2lGNnF4aWVaaHkxUlJtT2hpbFBDNjJSdTJz?=
 =?utf-8?B?aFo4NlMxdjJHZzJaTEdvT2FwK2ZXL0ZkbllFK2xldkl6QnI5ckF0L0pjdlVm?=
 =?utf-8?B?S0JrdE5jU3FJUEZIRjEvUE91cmJ1dFNHemNJdG02THBhNktWTUd6SFg2Ymt3?=
 =?utf-8?B?K3I5NlJSK1o1emUyQnRZT3g5S0U2dkR6QnU1S3YvVGp0V1JDeVQ4MSttSTIz?=
 =?utf-8?B?ZWR6TWhXdWd6cFhVL3VCMXA4cVpGODRqMHdpaVJjbkk5SzR6MWZRaEFFR1hC?=
 =?utf-8?B?TkZ1dVROQ0N5SENtRHNCbWNGQ2xMVGFBcjJROEZ2WVJEeER2U3ZzR01DQ3lU?=
 =?utf-8?B?TmUzd0gzQ2NmeVJEZHVPR1MwaTFkRm5WSThod1dDdDJaNXl3bUtLRDJIWmhD?=
 =?utf-8?B?OTQzdTNmK2ZPWWd6ZXNaNEN3UXBiS2t6OHROazUxZHZRMHBDaWw3NWwxUmp4?=
 =?utf-8?B?a2hjeFQvZ2E2WVJoOEl3T0VTdmQxUUtrWVAzbk1jT2p0ZzdvcElIaU8ydmtN?=
 =?utf-8?B?enlPQit5dFZNQkFWbWxCanRtbWowMEdsRkFxZFUvemtaTG1OeXlyMEFzL2Jt?=
 =?utf-8?B?OVphVUE4TjBqNFphSEtJRTg0MmtTVWVGUlE0UFdFM3pYOGcyUXdSckV2czAz?=
 =?utf-8?B?VEhTZkRIZmdQMkhqbW93RXk3SEpuWS9vb2ZGa3hQbm5BTjVxekhvVjhvNXdy?=
 =?utf-8?B?MCtMak9la2t6TnhYS2RtblV4NTRYejZLanRSRlIxVnNVN2lROWlyb3QxeGQ5?=
 =?utf-8?B?elovRXJjNDEvazRIblprcU02Vkg3TUt3bmxwSXl3SEYwMnV1SllPSmluUEYv?=
 =?utf-8?B?aGJpc2tLNjVJTEs5QVl5Mm4yL3g2MTBIeTRBRS9ReFVHOFpCTUk5Q2MxbmFZ?=
 =?utf-8?B?UEhFUG9qZTJDNHZyWU9aWEJjcTY2cVJhR1hKNDB5R3FMNDRVT3d5QUxrTmZK?=
 =?utf-8?B?ZnFvRVJDeTMzTXhJVFBUZTFqT3NjSk0yZ3RFUlpjMDhrd3MxRFZ3elpCb3Fn?=
 =?utf-8?B?d2hxZllnRVRSRFVyUTY4YVhGMmlPbWhQNnhHRjdwa2cydXJRZlFNRlJnSllH?=
 =?utf-8?B?dVF2MlFjVGRWYkRUZzg3YUEzdVU1Z21GRW51dVdZRnVBRC9uSnc3UDk3UmdT?=
 =?utf-8?B?Tk5IL2ZuQUJVRkVYK1JUMURUVzR6UUNoQTR5Y2RhaENGakZERjdSK2JVcFRo?=
 =?utf-8?B?SSt5SFBOTTJVeERLTGRndDZRcHhZcHdMSW14a3hrbFpWQ2pDZGYrTUw0cE1I?=
 =?utf-8?B?amJvQnBzYmVPL2FOMXRUaEFzVlEwd3FJQU5YREdueG9CZlBSV0wveUo1dE9h?=
 =?utf-8?B?QW1RWnZVWFJ3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8742.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEYwQTRtMWFVNlROdTRpN2xPbDdRTHhiZEhLWFdJWE5zeWxwUy83VDFzdTIz?=
 =?utf-8?B?cXRrYkNHb1kwS01rZUJMMWduU0VFY1VVdktOQWVlSmNIRmM4cElZUHdiWXA5?=
 =?utf-8?B?Syt1OVYxNDNOeE80cm9uelNIYUdLTnplMXFJc3lvUHAzTk9pWUJFMWRia2RI?=
 =?utf-8?B?Uy80MklRRHh2N1RLZXhtcy9uZTF2aXJ6TlVOaGYra0dSMG51elBRUFNHMUtH?=
 =?utf-8?B?UE40eFZPSzR6QnYycnZwemc3ZFlueVVWazZvUFU1RmhZS0xQcnJjTENhYjBX?=
 =?utf-8?B?RVdjeWJ3Sm5lUEZ0Q0dEMFFhU2wyWit1Y2FPaHc4VUVKWWJtVUkrNmJXRUJ3?=
 =?utf-8?B?U1lzUlluV0QyR0VTZmZ5VVBnT0xIb2owNEpaS1EzS3ZTM3RnSm4xZDZnc1hX?=
 =?utf-8?B?cjJITE5USVZKcTM2Ty9GYTZUaDZzM1BDcVRoSERqNEtHUXhjUU5UOWRrZm9h?=
 =?utf-8?B?MStyenR0emdUWXQ4ck5zK1FSSmxBRmNFK3dGMktERFpweUpQQ01TVG9rSmh3?=
 =?utf-8?B?engvY041RnJCTXdXczRRUFFIdEErMmQwL2tBdUpvR3NvMXBSOEtZU0srZWJH?=
 =?utf-8?B?VkNpUGMvOGlqSXh1YXhreFN0MXpxWmZBbU5Wbjh5bDI1LzBaQkNOczRidnBJ?=
 =?utf-8?B?MlJTQ043TmxnRnVuLy9BYXd3cERGWFBhK3ZzUGl2akVRUVFVQ2pRQzlxa1RS?=
 =?utf-8?B?TXN3M0czREh6OExqQ2pTakg2UnNEbU5VanAwTzhJM2NyaFdaaUMwR1R2NlJD?=
 =?utf-8?B?UkJQeUs2RWlBcmpWdmFHYytGckJsTy81R2t2cFpWelBZc3ozbUlEbFVCL3Zk?=
 =?utf-8?B?djZqdVFpMTBOd2RtUE4ya1ZrUEZHMTJ0SS9QUi82U1ZNaFpCNnV4Q0djRnlx?=
 =?utf-8?B?R0lLM3hIWEY2d0o3a2lMMXZqRVFUbEZCNGhPSWJYNlk0ZVJSRCsvV3N2ekFD?=
 =?utf-8?B?bXdMclJ6ank5R1FoODVJR0ZFaDQxeWt1Vm85YlErQmhVc2ZKSU5rN0ExWWMw?=
 =?utf-8?B?N0JaWEYvazdnUGlHV1BGNTBXem1hcmg0RnpUTUJ2K3hsZldBV3U0M0YyOUxi?=
 =?utf-8?B?VWQwbXJzZzlHemptQVI3NENoTVB3TlZQbGZLREMwZmRmelJWSkNRSUZmU2Fz?=
 =?utf-8?B?VW1Jak54a0IyV2cyeVJXa2NISVdRamEybnNmUElOaENRS2hlMXprRXdHNTJO?=
 =?utf-8?B?cktOWDU5YUcwSW1jcmZwa3lER3Y0UzRLMkdwNUxaWnlkV3ZEMjNqK1YxUElv?=
 =?utf-8?B?dUw5d0RRUXlXam9jZTIwM1ViWFFuMVloOERoSDNWRksvNGgvV2w4ZnhIdkJB?=
 =?utf-8?B?d2w0dUlqVVZiQWp0L0l1NWdKNExDT0w1VFNKWDJnTkRmbnFvNWowdmgzTm00?=
 =?utf-8?B?SUFRcU1ablQ3QXFRd0gydGF0QmZ3dkNrT09nSGFhMGNMZHRFU2xUZzBDWnMw?=
 =?utf-8?B?WEFPQjUrVk91NlpETFNIWjFqbHVoV1pXOG5qK2g2RXhOQlB4MDNSR0ZNNEN6?=
 =?utf-8?B?U21MaWZRWFQ3OC90V3QzUDRCMnBFdnpOd1BQVnhhTkV4VUJheFpnaUVzeXdE?=
 =?utf-8?B?M0w3cWJ2L0c0V2pCaFlJdklMME1hZnFGUjJzdDlQOVBOTzNxaGswRkQwd1pY?=
 =?utf-8?B?VC9SZ283WmEyOFNiMmx6SUVyT2pGeVBrNjhvZWdUSGJUTWNVMUNyQ1g3Nm1Z?=
 =?utf-8?B?WnVJcWZWaUdyOXc0NnVZeW1Ea0dFOENhQXR1eXFSK0NhejNML2lreXRKSWVj?=
 =?utf-8?B?WW1INTRSRDR1ZXlZV3dlL3lUMElsRlNRTWRFL1pPekkwYnUzYUNDa1NjQmh2?=
 =?utf-8?B?WTREV2FZZ0lWbi94YVhYV2h6Q0VNSDlmeUIxU3JONlRwME00VlZIVEhaUnEv?=
 =?utf-8?B?R3c2VmNuZEJhNTI4QU1oWlJyV3p5UWVseUNIdmJuN3h0a1lkbGZmYmcvaEFM?=
 =?utf-8?B?SUdBRTFIMTlhTldRclhNem54bVcyZGVtMWlmdm9lWXErZkM3RlluaGwzTWRY?=
 =?utf-8?B?SWtzZnN2MG5VYWFPaFg5WjFSakNhSks3cFlCeUpVaFY1ZFNKdFhha0puQ2ZM?=
 =?utf-8?B?STYwZmwrNzBMcXEwbzJONGhMZmorNERaVTFkb0wxbVZrdUFqVEs5by9TY21E?=
 =?utf-8?Q?3wUPh/SCOncYp9f06qL//bZmf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8742.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f73459a-3cee-40ac-b62f-08ddbf3b8d0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 22:54:24.6443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +VMGXHPu+KmiaQ2a16K7kYi3HlSTGANjIOedKUNEawUL8wnka2I7CuSDOeUFQRcEuqMzJ1zAxl5WTkO6z05uNkipeDrdG3N6ZRqO4hPlkpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6363

PiBPbiAwOS8wNy8yMDI1IDAxOjMyLCBUcmlzdHJhbS5IYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0K
PiA+IEZyb206IFRyaXN0cmFtIEhhIDx0cmlzdHJhbS5oYUBtaWNyb2NoaXAuY29tPg0KPiA+DQo+
ID4gVGhlIFBUUCBmdW5jdGlvbiBvZiBLU1o4NDYzIGlzIG9uIGJ5IGRlZmF1bHQuICBIb3dldmVy
LCBpdHMgcHJvcHJpZXRhcnkNCj4gPiB3YXkgb2Ygc3RvcmluZyB0aW1lc3RhbXAgZGlyZWN0bHkg
aW4gYSByZXNlcnZlZCBmaWVsZCBpbnNpZGUgdGhlIFBUUA0KPiA+IG1lc3NhZ2UgaGVhZGVyIGlz
IG5vdCBzdWl0YWJsZSBmb3IgdXNlIHdpdGggdGhlIGN1cnJlbnQgTGludXggUFRQIHN0YWNrDQo+
ID4gaW1wbGVtZW50YXRpb24uICBJdCBpcyBuZWNlc3NhcnkgdG8gZGlzYWJsZSB0aGUgUFRQIGZ1
bmN0aW9uIHRvIG5vdA0KPiA+IGludGVyZmVyZSB0aGUgbm9ybWFsIG9wZXJhdGlvbiBvZiB0aGUg
TUFDLg0KPiANCj4gQ291bGQgeW91IHBsZWFzZSBleHBsYWluIHRoZSAicHJvcHJpZXRhcnkgd2F5
IG9mIHN0b3JpbmcgdGltZXN0YW1wcyI/DQo+IE1heWJlIHlvdSBjYW4gcHJvdmlkZSBzb21lIGV4
YW1wbGVzIG9mIGhlYWRlcnMgd2l0aCB0aW1lc3RhbXBzPw0KDQpUaGUgUFRQIGVuZ2luZSB1c2Vk
IGluIEtTWjg0NjMgaXMgZmlyc3QgZ2VuZXJhdGlvbiwgc28gaXQgY29udGFpbnMgc29tZQ0KcXVp
cmtzIGFuZCBjYW5ub3QgYmUgZWFzaWx5IHVzZWQgaW4gdGhlIGN1cnJlbnQgUFRQIHN0YWNrIGlt
cGxlbWVudGF0aW9uLg0KVGhlIHJlY2VpdmUgdGltZXN0YW1wIGFuZCByZWNlaXZlIHBvcnQgaW5m
b3JtYXRpb24gaXMgcHV0IGluIHRoZSAyDQpyZXNlcnZlZCBmaWVsZHMgb2YgdGhlIFBUUCBtZXNz
YWdlIGhlYWRlci4gIEFzIHRob3NlIHJlc2VydmVkIGZpZWxkcyBhcmUNCm5vdCB1c2VkIHlldCBp
biB2MiBpdCBkb2VzIG5vdCBwb3NlIGFuIGltbWVkaWF0ZSBwcm9ibGVtLiAgU29mdHdhcmUgY2Fu
DQppZ25vcmUgdGhlbS4gIEEgcmVhbCBwcm9ibGVtIGlzIHRoZSBoYXJkd2FyZSB3aWxsIHVwZGF0
ZSB0aGUgU3luYw0KdHJhbnNtaXQgdGltZXN0YW1wIHdoZW4gdGhlIG1lc3NhZ2UgaXMgc2VudCBv
dXQgYW5kIHRoYXQgd2lsbCBkZWZpbml0ZWx5DQpjYXVzZSBpc3N1ZSBpZiB0aGUgTUFDIGlzIHVz
aW5nIGl0cyBvd24gUFRQIGZ1bmN0aW9uLg0KDQpUaGUgc3dpdGNoIGFsc28gd2lsbCBmaWx0ZXIg
c29tZSBQVFAgbWVzc2FnZXMgZnJvbSByZWFjaGluZyB0aGUgTUFDDQpiZWNhdXNlIGl0IHRoaW5r
cyBzb2Z0d2FyZSB3YW50cyBpdCB0aGF0IHdheS4NCg0KVGhlIHJlY2VpdmUgdGltZXN0YW1wIGFu
ZCByZWNlaXZlIHBvcnQgaW5mb3JtYXRpb24gaXMgcHV0IGluIHRoZSB0YWlsIHRhZw0KZm9yIHRo
ZSBzZWNvbmQgZ2VuZXJhdGlvbiBQVFAgZW5naW5lIHVzZWQgaW4gS1NaOTQ3NyBhbmQgTEFOOTM3
WC4NCg0KSXQgaXMgbm90IGxpa2VseSB0aGUgRFNBIFBUUCBkcml2ZXIgd2lsbCBiZSB1cGRhdGVk
IHRvIHN1cHBvcnQgS1NaODQ2My4NCg0K

