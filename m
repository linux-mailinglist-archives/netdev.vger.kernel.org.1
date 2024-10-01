Return-Path: <netdev+bounces-130845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041CC98BBD1
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B518C282973
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5491C1AB3;
	Tue,  1 Oct 2024 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rrvD+Xc7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A641A0AEA
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727784570; cv=fail; b=TrXOrZwzQjH5jdFjEDDB5n7HFJ8c91rrACp4ASokpZqvOSs4XIOXIRR5lXj//r+YKhJqe+IWfCt4QKLsuLTwb3RnHXwhWqYtQRXgpZg4YXpOz0XzGUN4QhCUMhLzH8SUh0tmJxvxRDdUt730RicRIO5erLdaCBfkxh4LhUCpotI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727784570; c=relaxed/simple;
	bh=ZDaBcOaQclIUWmOaUIHr971bdUInhyRyuYg1mvbgahI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PL0nzqAISD+oVTF0gp0HsNL6Lfwd1AKE/VRgrMvyJTSr1FLCn6yQvtJ+J6WS0a62jptBGiqCY8xgBZwsZfOhth1jQlnoO+/V8oz4W7yLA6Q7GUtg+tafvMWww6EkFrKdZfblsNykIU+4fvX+V/+ulKYE8RovxBuQrw5rDOgUOHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rrvD+Xc7; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KK7yIFing2SRGCIdp5U3lYRX+XwvcHSYjyIf35yZqQ9mjsd4dn1raPNfrj4QQW7j9ebtI7BdPHO+KaOiXDj0SRq9iy7BHGlWCIXqk8SwGL7Gufv/0BMV63wVDFBg4/PYPUsNHtnloD2dT+zTlKm+VzGOw8oeQa3ERQXN/esnWd2xba/8x/psYR/kFPgkPgmMAWI7FTpl1IgvWE1qSW58AAPOj4NX4vzqJlE4/jdSegJEiRVZGmWVHWK4yWIZuS3H4zwP+KY3n9FQa95WKkxBR8NHDV8cZ5ektypQfOTOKxBGuj6IgxTdhzaV4taoagaXz4pEWw2CPFnQ6ucCF/gD8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDaBcOaQclIUWmOaUIHr971bdUInhyRyuYg1mvbgahI=;
 b=CHsn4SKQvAglR9kOvWQAVKlpsGA5PHqf3CFhXg5NnmR1Jq8Wb2YLp8ey9ZpCBBmm6H5KAoSbpqmzBCwJtznerNGwkUef8v8jtS/l7m4mdSnsp08bm6CwGWHvPD+kEsE0pqiqAUKwur1E71cUs9QO1H2gg3T/nwEpO6Avoqnp5x3OWWV2/R/MCZBnKsEVJRejMrC1Mw01xnFrxfHYMfjVvTGMteekj1LePpYrHMbYyaRBUkjDPpmuhezy1BHjAgE4dQ69sZ8tPggL7a1piyCmO+ji3JeO2+pySsDN1sG9CSN/m1xnQ3yWnwJHOrgkgzmOw/+6QeCyulNvZAQ7I9Hb2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDaBcOaQclIUWmOaUIHr971bdUInhyRyuYg1mvbgahI=;
 b=rrvD+Xc7t8OzZs9//U5CQzTuwXVRBJZtzdTzRewRA6O/ccyo9B1xNF8NjClDnvYlRiFLSnY/EMHN2eEJ2Dy1r+/WFwXEfKGLOOYC3DqZHOyuoy5y7DLVgNKhjUSFEqMSZcl0nDi53VDwfmaaL0qKa0f+PFp8jSZTl0lE6+9ZV5vi+PZpgR/aYUTixenzCyVsb7QfhFs6e+BlowrnySKKLNnPZXDttu0WpNZbJADFzg+1K5mwzmB4iWUBDFB6C/2VNfxfiQ+JcyfY+mCZHulSlX6qpk57c793zNSmgOZaFkF2jVee5ka226BnNVKJWW3GHN/HnHFTg2zPCXweAHZqSQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by DS0PR11MB8182.namprd11.prod.outlook.com (2603:10b6:8:163::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 12:09:21 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 12:09:21 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <alexander.sverdlin@siemens.com>, <netdev@vger.kernel.org>
CC: <agust@denx.de>, <olteanv@gmail.com>, <f.fainelli@gmail.com>,
	<andrew@lunn.ch>
Subject: Re: [PATCH net-next] net: dsa: lan9303: ensure chip reset and wait
 for READY status
Thread-Topic: [PATCH net-next] net: dsa: lan9303: ensure chip reset and wait
 for READY status
Thread-Index: AQHbE+6wsAOYmn77hESnYe4KVx9MTbJxwr6AgAAHgYCAAANhAA==
Date: Tue, 1 Oct 2024 12:09:21 +0000
Message-ID: <c2d901c2-0e76-4661-acd1-d9835afa76e0@microchip.com>
References: <20241001090151.876200-1-alexander.sverdlin@siemens.com>
 <aafbddb5-c9d4-46b4-a5f2-0f56c58fc5df@microchip.com>
 <60008606d5b1f0d772aca19883c237a0c090e7d3.camel@siemens.com>
In-Reply-To: <60008606d5b1f0d772aca19883c237a0c090e7d3.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|DS0PR11MB8182:EE_
x-ms-office365-filtering-correlation-id: c63430df-b881-49b7-faac-08dce211e1ef
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eEdETnNUbXEvZFF0Y3VJdUtocG10MmJwWmszK0N2cDlzTExFWE5WdEJPUVZB?=
 =?utf-8?B?bG1CMkVkR3UxbDRLaFVMUGVxTW1VZ3FLanVIanpwT2RRMXBZTnJrMFFLU1dQ?=
 =?utf-8?B?Uy82M0V3RTRhY05DcGZUdGloSGo2WVNOR3dKai9wMEhoUGtoY2MyMVExTjNq?=
 =?utf-8?B?WFNadWlVblNra2ltbnQ5bTF0bWVvT0hOR0pzNVBYcEM1NmpQQzYzMUgrUVVT?=
 =?utf-8?B?QTltbVc1SkRlYWFYdkExekc0WUYvZU9PRENyYnRST1Zhc2hrZ3V5Y1h1N0Jm?=
 =?utf-8?B?YklvaTFQN0tablF1dkNicmxibkMzcTNJaW1sZFliRDQxQVZsbk0zeTB3UUhm?=
 =?utf-8?B?WTc5R2NML3VnRVNrTnFlTXF0U1EraXZOU1d5aTgwdUNRTXJHc05OeEtXTEkr?=
 =?utf-8?B?dUUybmNCWFp3VjZsVnJlOTBkV3hHQ0tsSTQxWnVMN1QwdFU3TDFtaHhJTjJi?=
 =?utf-8?B?a1cxNUE4QlM2WktvYlF5bStGT3lOM0tBQWJEL09KRkE5ZmxacGI5dmMrUis2?=
 =?utf-8?B?YTZTRGduQm40eVRGSWE1VTFleGE5VkF0VFU4a0o3R25EM1RCRWE5Q3dnQUc4?=
 =?utf-8?B?anNYcmcxSXNrcnI0NHZ4d3J2KzcwSHR4dytMU1dqNitZRTk1Wm1aTzVVSks1?=
 =?utf-8?B?eHlFclppekRLQjdGc201SWNDUFFzWmRLUWNsK0tqNHZ6OHIwcS80a01mcWk0?=
 =?utf-8?B?VUpuazVPVUx3SmYrMUZzUnhFWms1elNtNEhSRlFTTVB5aENOZWk3bHdURGZk?=
 =?utf-8?B?SWFKcTBSblk5dnVMcEh0M1NwRm05SEpMejBzWUpwSncxblVQV1lHaDI1RlN0?=
 =?utf-8?B?allhQ3VhN041NG9wR3IwYU02ampXWXdrQzZPT0hqdnN6aDltOXl5YVVydkJs?=
 =?utf-8?B?WnNvbEdRbk9MRmo3T1pwV0VRWXFBS3QzRDNmK1lkVVFUbVRvMDNrT29aR0c4?=
 =?utf-8?B?cTZpNkY4dURMZnRiQXFEZThINGVzcmVNbmNmOXBGZjVtUmpUang5SVNBUjY4?=
 =?utf-8?B?emxjVHJ4UHYzM3RVejN5OGl4bFU2OERKWlNvcHJ6YUpZSVJpbXF6NlZ5MVJI?=
 =?utf-8?B?cnZYRTB1OVpmLzA4SnNlTmlNRFpiODlVOVJHZXA4MXRoZEZpU2ExamhBVnQ0?=
 =?utf-8?B?QmpqVjZOWHJkU2tKZE1SRXNMd2x6NE1qSFhNTEVka1Ewa2I0OG5Nc1RxeElV?=
 =?utf-8?B?U0RLQjIzUjAwUHJlVGVOMi9UakZITHdUNXlhMWN1cmxoSk9nRjZQMTFxVjJx?=
 =?utf-8?B?ZDQ2ZXZMRnZNczVvZ0pBUGM0R3c4TEZITU9tNy9ReHQwOXR0Y1lCL0pDWldv?=
 =?utf-8?B?dkYrNDMvbS9EQXNlNGhqTEx0N1QxWm54VCs0bkhyeWtyeWN1a2pOTlZhTnFv?=
 =?utf-8?B?KytOZ0VUUmFrb0tueE9mSjJuK1FRQThyRU9Zc1QvMUI5YUVPTXNaUlZPZDFG?=
 =?utf-8?B?UEVCcHlUZWRraytxMTAzN2IzeXVnekZyMXppT3pkY0xsTEdObzN0bnRQRm5M?=
 =?utf-8?B?ZlBWUHZqUThPMGZkdkV2RmozY3Q1VHVBcnRvTGdtdzd6M1F3R1Y1a2JsVjd6?=
 =?utf-8?B?Nk5kaHpuaXZ5eWV0Ulk4eEpUNVNiWEdZNTNzK3dSOVd2WUhPWFFTQlhLNjh2?=
 =?utf-8?B?Ri9uYVUzdnFtRlpsZlpsK3Q3N09STG5Eb0JUTDhOYnFFZ1I2dExxMUxkdFdk?=
 =?utf-8?B?Wm9mN1UvOVN0NDVKQkltWHd6bEpocmVPVkMwL0FYbSs1a3NyV2VCU05HV2Ny?=
 =?utf-8?Q?u5AwVhgq/bxxfq6MW8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YnZJd2ZqQ0ljY3cwQWRYYU4rU3JCTG11cWZmS1lQYjBFcnpBKzJNSUgzNHFl?=
 =?utf-8?B?dVJ1U2lodEh0alY2eFpOT3pzemhrb1ZIblh0ZTNWWVhBT1crSTd0RW9nRHY2?=
 =?utf-8?B?UEVpbG9qbXY2TytudUFWc1BBeDhFV29XOG84cUJCUmxFOGE0ZCtpN3NHakZP?=
 =?utf-8?B?TGpmcFBJeXNCYXBtN2RxQzVzVjVzRWFVMndUVWp5WnBFdm13bFlPZ2VKZWlR?=
 =?utf-8?B?Z0h2alhQWTBOMHJLKytzSWxpd3ljZS9jaFNxY1NQaVRKZWx1Zy9pWHRFaTZB?=
 =?utf-8?B?YXdaRzE1VElhdDNOM1BERjRBY3lESlFYenhwVnJBVlhYTjEwQW0yZUJuS002?=
 =?utf-8?B?OUsyWUMrcWNrS240RXZXWWlPblRMY1JXdlRoVlpFcmFzTi80dHUzQU1zdDlX?=
 =?utf-8?B?T0MybFVGSGpranBEK2ZQQmVCL1Y4NlFjbmNobFFDNVhSMXoxMWVWZGlOR1Jy?=
 =?utf-8?B?OGczQjBDbllRVHlncmlEQ3h3N3VOR0MwQ0RyU0l2R1hMM3pnSG1TYUduTERh?=
 =?utf-8?B?M3Y5NldUTm9EZTB6VG53a3N2eEZCemxLa1ovT1MrMHhHUG05am42bERZblNo?=
 =?utf-8?B?anFDTmhIekZGYVBXSTJndTlOSHZRRU50TENieXJKWjEyQU11dmZDQlduYm4z?=
 =?utf-8?B?d2phZFlQclRldmdJRThkcFVTN2tBdU1TTVlHblN0NFVMbmJ2c2dVL0xVL0dE?=
 =?utf-8?B?VHpjMXc3OVQvU3lIUU1pdi9WWFgvMHAycnpwK0FhYUg3c1Vkb01ZWUE3eUp2?=
 =?utf-8?B?VitDeDRVL1hVYmpNU2syUjdQYzJXVEprQWgrSno1QkV6V2FoVWtEdlc4a0NG?=
 =?utf-8?B?M0drUlFsODRKVUlFTlJvZHJlajdjZlQrUjY2YjR0ZVBoNFRHbndKVDl3dmF5?=
 =?utf-8?B?bTA3bnVhYm5DOXhUeW9nVDJvZkJpWlhGV2ZvYityY2NKQkxYWklFcG5ORWlF?=
 =?utf-8?B?aE9LVWhJWC94eTNDV2grM0xlSU0rUHVVWUQ5TnEvOFd3ZFowTDVObG9IU0Fp?=
 =?utf-8?B?cGdwZkFPRDJkYVp3NlZQekZmb1RZTjF2NmVPd1JKbGVYMklXWDZwbjlNMGV3?=
 =?utf-8?B?Qkk3MHFXN1pWUVk2c2tQNHE1NHBadTgydGNyZUVDL2VmUXlXaDkxVWk2N2cw?=
 =?utf-8?B?L1pRSVhqcHR2OU9DWVV4NkRTT0ViSDVmTkZqREJ3a1BUMEpuQ3prektNRkZo?=
 =?utf-8?B?bEpqZEdaYWxyZFVHZkkzcmliWjlpUHZaRzdtUjNBSlVEMHdTZ2lsdHQxMmNM?=
 =?utf-8?B?UE5PK3pIY016YUk1U3JNUHhVRll0U3FnYmZWTUpENFFSRS9DRG13bVAvR281?=
 =?utf-8?B?c2hwY1VXSnozamhOMkdaQ1ZxWTNxaDhVRDVSVTBIWFpDVmt0OUZsQWZiWmpH?=
 =?utf-8?B?SlpXbTgwN1lCclE2UGdsR3Q1dW9Hc0tvNXgxZkZLWGNWR213cEIwOUNmYmxF?=
 =?utf-8?B?YTc1QytZZ3hMSEFacFdtVnZMMTFtV3dtbXl5aFc1SEc3TTlmUUtCR0krc2Nl?=
 =?utf-8?B?cC9ZUmNLUU9BVFhQaVJrQlgyenBXRysyY3NoUFRyTURzcWQyc0hnU1FlRDlI?=
 =?utf-8?B?ZW5vdlVYV0F3TDc3TkNJWEVuTnM3cjRWUDNDOTRiUDFVRm5YUFpyUFVJdUli?=
 =?utf-8?B?eEl4T1R1bVY4TnVZb05Bb1BOWlhmcXdiNmRjUGVPRmZoV1dPcDVMRi93d2JK?=
 =?utf-8?B?WHJJSWcvVEd1S0txdEk1YWNDZkd5MUJjdW1xRElKSmd1SFZUQ2xTNVByRm9F?=
 =?utf-8?B?NmVWRENMRmcwSTZaUjIrdUtCSnVaUU1oUHkwNkNlQ3FnVzFuQTEwY3V6SVRr?=
 =?utf-8?B?NVE1aUJTSnBWSXVab3pzcWFvUGlzcUpqUjl1STloVG9iZVltdU9Ec3VLN08v?=
 =?utf-8?B?ZW1Ha0JBekJiL1RZbDVGQmRURDQ5aktwOEN5bVRGMkxkKytnRGFxLzFRM3BB?=
 =?utf-8?B?Wkt0WlJtMytVU2JNa3YwVk1kNUdoeGlwendPMmVMN0Nwbmh6bTAxamRFZTFP?=
 =?utf-8?B?UVRkd0xDc2VtaTN1TXNCSlhVc25UUG50dE5TSXVnMlp4RUdpeUdTREtUQm91?=
 =?utf-8?B?eUNybWlLL09QSWFMYU1tTThKUGgrQmJEZkhGeWtBZlhhZlV4RmpPWTU0Z1hk?=
 =?utf-8?B?djlaRnVrWnJ3LzM1VjdLQTBqdjNudlYvNmNvZlk4NzZwZDlRY290SXhmV0Jw?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F6CF82DE826BF46987FBBE7A45A88ED@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63430df-b881-49b7-faac-08dce211e1ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 12:09:21.2081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OS5eMMZ9HTi+cRTOuveumTLPGJOCJpqCHxridwmNHU7UnZcNjxBAnNwL/BOH3oJC0nyJkJOaeEiiATKoat294c0HmU5F5Q3GS9OufFPK3c0+1shESlIGvf7PFwUHZTTG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8182

SGkgQWxleGFuZGVyIFN2ZXJkbGluLA0KDQpPbiAwMS8xMC8yNCA1OjI3IHBtLCBTdmVyZGxpbiwg
QWxleGFuZGVyIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4g
DQo+IEhpIFBhcnRoaWJhbiENCj4gDQo+IE9uIFR1ZSwgMjAyNC0xMC0wMSBhdCAxMTozMCArMDAw
MCwgUGFydGhpYmFuLlZlZXJhc29vcmFuQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBJIHRoaW5r
IHRoZSBzdWJqZWN0IGxpbmUgc2hvdWxkIGhhdmUgIm5ldCIgdGFnIGluc3RlYWQgb2YgIm5ldC1u
ZXh0IiBhcw0KPj4gaXQgaXMgYW4gdXBkYXRlIG9uIHRoZSBleGlzdGluZyBkcml2ZXIgaW4gdGhl
IG5ldGRldiBzb3VyY2UgdHJlZS4NCj4+DQo+PiBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9E
b2N1bWVudGF0aW9uL25ldHdvcmtpbmcvbmV0ZGV2LUZBUS50eHQNCj4gDQo+IEkgZXhwbGljaXRs
eSBkaWRuJ3QgdGFyZ2V0IGl0IGZvciAtc3RhYmxlIGJlY2F1c2Ugc2VlbXMgdGhhdCBub2JvZHkN
Cj4gZWxzZSBpcyBhZmZlY3RlZCBieSB0aGlzIGlzc3VlIChvciBoYXZlIHRoZWlyIGRvd25zdHJl
YW0gd29ya2Fyb3VuZHMpLg0KSSB0aG91Z2h0IGl0IGlzIGEgZml4IGZvciB0aGUgZXhpc3Rpbmcg
ZHJpdmVyIHNvIHByb3Bvc2VkIHRoZSBjaGFuZ2UuIElmIA0Kbm90IGp1c3QgaWdub3JlIHRoZSBj
b21tZW50Lg0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4gSG93ZXZlciwgaXQn
cyB1cCB0byBtYWludGFpbmVycyBhbmQgc2hhbGwgYWN0dWFsbHkgYXBwbHkgY2xlYW5seSB0byBi
b3RoDQo+IHRyZWVzLg0KPiANCj4gLS0NCj4gQWxleGFuZGVyIFN2ZXJkbGluDQo+IFNpZW1lbnMg
QUcNCj4gd3d3LnNpZW1lbnMuY29tDQoNCg==

