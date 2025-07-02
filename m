Return-Path: <netdev+bounces-203206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF530AF0BB5
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 08:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4592441142
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 06:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3971531C1;
	Wed,  2 Jul 2025 06:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="LAQs7oQZ"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013070.outbound.protection.outlook.com [40.107.159.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA63F10F9
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 06:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751438070; cv=fail; b=i0Pp7U+jeKeMBSnxlxfmG2K/+UiSXW8I06yv7AI01HM/VUoqOKdNWhewanRirtbIRqCT6ZIdNAEyenddDJrfa6DTSwmDyn5p8sMw1JVO39xFeQdGv3ykZQmeQvnkWhMJylwJrcI1sJWHHzObywJACNtGZBFWyL6uFgR0gYqxhEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751438070; c=relaxed/simple;
	bh=Y3G2pgeTWi2YGXDwI19tF77NHeqOs4lh7vD4iqZRLa8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=amtSy8fU8b44CU/3ZbLOV9q6afk4Wh8a4r04fJF3RYypcvK1kZHoh8og1fdL+hic8L6ARhJQnpmNIcBoBTBmpju2C/Gbwxsr9143eO1baSC0zTh3TFETpVLyaARWbk9ASW7QSj3IKrj8Ox6jpBXhVlYWvPjX/2akNOfTn/Vmcu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=LAQs7oQZ; arc=fail smtp.client-ip=40.107.159.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHSXN8RsUV99heM0GrR7vhpLWO9M3drQjNTgBesvdg+movC2itG1jQMr52WfWJlLY389CZRfAoTg+FKTthkavBSILj5TQfGyA1/bsVOeuHmXVjJ2oCxDtqv5fuyZFFg53MyWVHBmYj1iFw0tf1pUFORrfbfbksPdklVQ2j9LgGSorrgHKwz1gaGxLC648uHsFHnRQuO/IdOdKMG6phKk0yio3ftra45QFijHw35cfO1ht+9wkYwMToUhn90BYXlmlFvtkLV5TRjG0u6WUIOebs0YCu3pL9bolnGBf9frvpDY0GTKB1f9PLhFs/Gr69M0myKUtAbY4Zw+6wXcHyaIRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3G2pgeTWi2YGXDwI19tF77NHeqOs4lh7vD4iqZRLa8=;
 b=LUfGwrsa7P7p+OtAK+rOHAkmoDGPb4HXd4hDYAnDhdMIaQiqWG0AI2m7/BZK4voxhgQsJKNI12ECBL1m8QwBpBdB7Q46Ert3Zh1YcTjBlYcB/1jmHhAcHVZ1+lf+FZwjktBmyoo9rnsOPlElrLmdKjfQjeqMTzYArfYVQhJ5VC5FaEhMRLQKSuHLJZILZt8H+N5dGbgj44a5+8DrxR4VlBjIyfkQ2Cd2PKMZPIxA/3xXghJwv8Zh8hqRGyy7WracfUAxyqRc5bCnjmdP43A7XwLhzSH94KfuiKlAbLncsTFTLFCzs48UfcyUbsUuNbddCOmnpeHJfbFGVm1IZ8obSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3G2pgeTWi2YGXDwI19tF77NHeqOs4lh7vD4iqZRLa8=;
 b=LAQs7oQZIka0eqOg6PaPQgronKIBk5fjlaBSFHOthA/FYhJaloj7l8y1gkNvLZiKm7v2+2n1kJRZhoCLCXT4guDsBrTHka+ywnX4gLpz5tFX3YEjjTMOJA+erL1NiKOgJ9BXgopw+ccpUZN8tUa7iff4Ndho/siTNQhtBORTVus09iad9TtdjZyJ4idIqw/Ad8dyLHsb+RDVAyfoBJxPoqhnO3uUXkzFBb9sgNokWTl4DEWGmRJDVy6gYwPwpVqJBJmdQiB+64LYEJFEZsf43m0dUnJV9qXyFdeJ+y6CDhDHlWOjlzMAiNNKqoqKo1+d0Jl5Hvj8NnKWXD207paR+g==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 GVXP189MB2735.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:1dd::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20; Wed, 2 Jul 2025 06:34:25 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::43a0:f7df:aa6d:8dc7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::43a0:f7df:aa6d:8dc7%4]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 06:34:24 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Kuniyuki Iwashima <kuniyu@google.com>, Jon Maloy <jmaloy@redhat.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Ying Xue <ying.xue@windriver.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>,
	"syzbot+d333febcf8f4bc5f6110@syzkaller.appspotmail.com"
	<syzbot+d333febcf8f4bc5f6110@syzkaller.appspotmail.com>
Subject: RE: [PATCH v1 net] tipc: Fix use-after-free in tipc_conn_close().
Thread-Topic: [PATCH v1 net] tipc: Fix use-after-free in tipc_conn_close().
Thread-Index: AQHb6vLMLrMvuei31EmYpqiwaFXq1rQeYJ9w
Date: Wed, 2 Jul 2025 06:34:24 +0000
Message-ID:
 <GV1P189MB1988EC63CDCBE8DFE53CFD61C640A@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20250702014350.692213-1-kuniyu@google.com>
In-Reply-To: <20250702014350.692213-1-kuniyu@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|GVXP189MB2735:EE_
x-ms-office365-filtering-correlation-id: d9ab8134-cb06-4687-2d27-08ddb9327cb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UHd0QWJHdm10bW42Ky95L0tUTzFtaWpUVkdRWTRoR1Y4Zkw1RTJxN2RhdlNq?=
 =?utf-8?B?OG5CSDJFNE1BU20rQkIxcGMwRWhPM29yNEdkMHJvVTV6cmpvMkFYbm5QU0NV?=
 =?utf-8?B?UUYzYnVGVWhiODFpbExFUWw2NGcyNnRWejA2dTZOUDdXREpEVGFyaERaRjBl?=
 =?utf-8?B?dlZDMEVqVjh3cTNjTDhXcFlVTDhyQkJ4Vkh2TWw5cUcyRHRTeTRTWEpuQ3VE?=
 =?utf-8?B?ZDhpdmZXNW14MHY5SEtlL3hJTEY1ZkQ3ZWVUeVFFakU1S2o4ViswK1h5a1d5?=
 =?utf-8?B?bU9VcjM0YzIwUU1jQWhVQ2tLMVF3SERMQlo4bkF5SHhHM0NQL2hadW9DZkxN?=
 =?utf-8?B?ZUpqazdlU0lZN29VL05meGZtQ1BCakNySXlnZzQwWEJoTUkxRE9XWjhaWjF3?=
 =?utf-8?B?ajNLamRqRFJqSE1IWXJtTzJ1V1hsY2kxcGhUVGpMRk1peUxYVnJXTDI3UWNC?=
 =?utf-8?B?YjNZR3EwU2VvSDNBb0QzM0Y0dDNWT05yekRhb3pLMk5YMHVSQnBvZWFoaFQ2?=
 =?utf-8?B?aXlBZ0Zsb2RkVXNLbDRTWHNRV29EWHdla1VJekYyWFlOUmNXUkRHdWVlOHJE?=
 =?utf-8?B?WXlHY3p1MmFzaU8vM1I4cDdURmlnUlFDcXRCaDB2R3p5bG1CbWJXd0FLTWYy?=
 =?utf-8?B?L0FZTTVkQSttRlB1dG5HSUdUTS96MmR2eXM2ZDh3SCtOVGwrTEt1YlcrVWNi?=
 =?utf-8?B?QnhsTUJCdFY0eTRNaTZibVEwZjdrL0d2ZjVRNEVLK3V1TFFmQjVsQkFRZVhT?=
 =?utf-8?B?N3lBYXRxbEpGaDB3RGVCemdvL3JTOVJNSUorZ0VBcDRSK1E1WjhiMXZEUWRF?=
 =?utf-8?B?RFlJcGlPaURvdzNtZ0ZVTzVlWVhoWHVYRGw2dTh5M3RjZjhSbkxCSUtUUzYv?=
 =?utf-8?B?YktpR0lHVEdISVpsa000d01WNWNKR0dvZHpseEVRMlY0VUFBN09MTGU0RGZu?=
 =?utf-8?B?MVcrNG9zTHZTL1hFdEhVT3dSOGJJTXlwQXkwQnNmZGdZeU04b3lHNzRZVW1L?=
 =?utf-8?B?Ti9ueldhYTUwdkZxMDQwSkJHQnRWRHpTNm1UeWhtNk9pY28rd0tOcDhFUUEr?=
 =?utf-8?B?R1VRSkFUUHFvSFV2YUNjWFY0QVk3dnFFdDVtcFVFazFvZUY1MXBjY1B6Nzhq?=
 =?utf-8?B?M2w3Y3FDL3ljOUplWm5jV2t5WDBOMmhIWFdzZjIrbk5TZUs4YVlaaExsM1JO?=
 =?utf-8?B?bE9iM0dzUnBSblZVUVp3bG1peDJjeGVNbG9sR28rNkFOb0ovc1FhR1BZb2t2?=
 =?utf-8?B?a0dZQWMvZEpabTN1Skw5L1NCZDl4bEtKbHdvUWg0Mmk2UXp1QUx4TDVkb3NB?=
 =?utf-8?B?QTJhY2Y0aWhvYUJLNEtST003WTRza3I3T3RhMmloTWhickllUEtyb3oxejZm?=
 =?utf-8?B?MFQvaEsyN1Q3VmtXVUNDcXAzUDExWlByVlYrTER2Zk5OSFg1TlN1VDdld0Uy?=
 =?utf-8?B?ellXUytVbUcrdEFwVG9KOFZSRWwyZURyT1VzZGFMQjFjZi84TkprY0tSQXNx?=
 =?utf-8?B?RCtjRG5yc1lVckczWk14VWJmRGw2eUJWRFdHcVpNSXhDVTl1MDdDUkNFTk1Z?=
 =?utf-8?B?TU9MajZaRWZzTWpUeUJSWHdDMk1NZE00SWczZGNxYmN5L3lkTThpTUxaVlhQ?=
 =?utf-8?B?N045R3piUlFXeWxFaWlOR0w4ZkN1R2VNQXFpNEVqWEVZTkpiVGJiWU9ZQis4?=
 =?utf-8?B?ZjRjRXI1YjNlUWVndVN1NmIzVmxXVWtNUWV5aWhDUEZxbmNZTE8xeURoU3BY?=
 =?utf-8?B?dE1vblJ1eDczSFlQc05keFJKaXRMWGViSjlpZkR6TWVuekpJZGhicVdSQWRq?=
 =?utf-8?B?OXB0T0M5ZHpwdlpJcXBXYmdOeis4U3J3ZUttM21kQklRYzlZVjl2em5IY3JX?=
 =?utf-8?B?cDFpdGQwTmFsbXh0eGFFTzlSQVlVRDBwd1RZRTZ4RnBiMi9NZXBlSW9WM0Vt?=
 =?utf-8?Q?GyBUhNJrYBM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TytaK1BLZEc4c3FFQ01YZi85VFdFMU11a3NJZUs2ckNOcVZiSFFxNTFZeFRy?=
 =?utf-8?B?NzJRWWFzVFpNK1NYQ0haUW5CMVdoVS84dlh5VWNmZWtFZWhkaURFRHdraDVj?=
 =?utf-8?B?TmlWUStjczRGZGdFOUxsMVJyMnhCcjdOcGFSbVZnd3pkVXFzYzZ5c0NkWVFT?=
 =?utf-8?B?SnE4K0VNcUc3VVl4Z3lGSm81elZGajlIQ3pLalg4cXFkU0lYTCtKcnhkYjBP?=
 =?utf-8?B?Myt2Z1ByMlZ6cFRxRXZjeDJ5enpWZFNnRjdtL3BOa1FoVzB2VXl2SzNBckRV?=
 =?utf-8?B?bGtMSEI4TUFXdlVRR1NTYm5DT0M0anZFaGJBbWpGTVdyN2I2QU9TY2hzbkFz?=
 =?utf-8?B?WFlGS2lzZzROUzFkTTdXa1BFd0ZSUjBvSWlyelI3dHd4a3loNFRoQ25JYVNw?=
 =?utf-8?B?RWJmVkoxM2NxWG80WlJ3VHBSTDhRYWJObUdESDZBdzBiMnBYOE5RRkpUaDZp?=
 =?utf-8?B?VUxrUm5NaG9oS2JBZzJNcXIzZjJwdk4yVDBxaFRZUEVMMEVjQ1dZUDRxR1Qv?=
 =?utf-8?B?SXlYQmtsR2dWa25uWTV6Y3NUOUQweFN6QWpWUHBKR2diMjRVQnNLbTNZbkVM?=
 =?utf-8?B?d2NrT1BobWpEblhURDMwR0h0d2NOYWozNVkyTGVkN0lOaVpNS2d5U3ozbE9V?=
 =?utf-8?B?UWVkNE83LzZWNXdRSkNhNVFpL1dTUzIwTUNEQWh5aTVLQlZ3ZG5DV0VlVWJT?=
 =?utf-8?B?UlQ2R1FldnduWjNtSjhaOWRyWnlKSlFPb2hSN3FTbWM1ZC9rdnBGSFpVcjg2?=
 =?utf-8?B?VmE5b2ZBMVA2enE2Q0pVSnhJbjIvMXZjZElVZXJ0M25tNyt3cnpRMkJXZ0JQ?=
 =?utf-8?B?VHhXMWVLc3ExREYrRnRKNTI0S1UybUxRRy84alcyZGRXS09OWm5aWG9kams3?=
 =?utf-8?B?L0t6WENwTWpjMHZWN1BTaC9RVHdHcXZPb21rNVVXZGpnZXBjVkJLV1ZsZEFG?=
 =?utf-8?B?K0VxZjJrb2RQWk45U2NiTnJEYTJNWFVTNUIwczNCeVQ2Vkt5dVZySkxLMVdp?=
 =?utf-8?B?bWpuR05lOG00dUVFeG01c3dFcXB5Z1I0UnpMbVIzSVpaR0E0QXhpSVdSZDRB?=
 =?utf-8?B?YXhvT3BiRFhzaUQ4MEMrb0lIdnhBZE93VXFjaXI5MHhybklZZmcwTEJSdVkx?=
 =?utf-8?B?TVBsU1BPTENFV0FsdjlMTkxhR29yRzh1WURxYXk4eGFRQVFWN0ZMMVVjNVpM?=
 =?utf-8?B?K1ZqNWRlQ0U1ejlkL1puQWVCZ3RwYUFxY25SYUNPUnI3YWEzT1FYRWJXZExF?=
 =?utf-8?B?ME1kRjgzbGhuNERFRkU3TFdVWVBlR3FOeWJvM0FyUlV6M0I5UFp3dGxjeWcz?=
 =?utf-8?B?QUp2TnU4bkhrWldKRXVLa3FWV2N4WmRZK0llbTFENHgxcW5aaHZDR2VZOFho?=
 =?utf-8?B?TmMrQUNEWjZ4RFpOUFZCenRQS0JaejdyUVMrMFhDMXBaU2VOQW5VRkZWS1M2?=
 =?utf-8?B?NTBVdWlmbGpibk1VNURTQkdqemMvNmVIY2hMcWRDTFdFZTdLYXByS1RBQ25P?=
 =?utf-8?B?MEsyOXVpS3lFWldTYUtnV0YxTytYeGlZZ0lmWlNWd1E3QnV2S2lEMUJJWUZU?=
 =?utf-8?B?NndRWXVjR3pUdENoanRYTEZkYy94VGhaQ3NWWFFWYXNJUERDUnFTRE15bEFE?=
 =?utf-8?B?aStaLzVlVlFUWDBlWTBuVDQ0eXh6eVNWeEFFdWIxVE05WWhCR3drZS9hUGdI?=
 =?utf-8?B?K3dWeVB2MDZ5SXBiZHVIRkxNcjNNNjFqcDkzaDVYcGxCSDFwcHpWWGdmVDQ0?=
 =?utf-8?B?WnlzTzI5V25HUUQ3UG15b3RyOWlvVzJBOGdWcmxKa3VwMkJlZXRTbyt5YkNs?=
 =?utf-8?B?ZUNKdkNTMnhNS2EwMCtWems3NXd2V0dMb0N4YXAxZUJPbm1WMGF6bDdyWVF2?=
 =?utf-8?B?Z3RjeXJiYUF5RGd3M1k1Nk1aQTlKVnNDU0dCemdMTlZTcUJKYUZQWFYwL0hy?=
 =?utf-8?B?Y1A3SnBaOHE4TllqRkZvMVg4TEc0cDNDNm9uN1llY3ZwWHByV2M5NmUrMndX?=
 =?utf-8?B?YVlNTFlXUXpNektIR2VJeWQ3ZVR3QnFBaXRIWGtZRzdNQVBwZEJxb29mbGw1?=
 =?utf-8?B?eVA3YmFvcEZXdXVmUExtY0Zqc3NVYWlEZjdQVlUvd2psOENXekxzUkhNaHVk?=
 =?utf-8?Q?r0LUQbeDiqPvSOPCabkIYGPpH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ab8134-cb06-4687-2d27-08ddb9327cb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 06:34:24.7528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yEQs6HAt3PAoagD/IWeXtGLodD0FxxRatXfsbqZSTms4HW6aCpb2Mi+LxGrU8rZpT9/nxa41/9hVPqQ1PvGl2DOFt2srr7taMuJToRywXIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP189MB2735

PlN1YmplY3Q6IFtQQVRDSCB2MSBuZXRdIHRpcGM6IEZpeCB1c2UtYWZ0ZXItZnJlZSBpbiB0aXBj
X2Nvbm5fY2xvc2UoKS4NCj4NCj5zeXpib3QgcmVwb3J0ZWQgYSBudWxsLXB0ci1kZXJlZiBpbiB0
aXBjX2Nvbm5fY2xvc2UoKSBkdXJpbmcgbmV0bnMgZGlzbWFudGxlLg0KPlswXQ0KPg0KPnRpcGNf
dG9wc3J2X3N0b3AoKSBpdGVyYXRlcyB0aXBjX25ldChuZXQpLT50b3BzcnYtPmNvbm5faWRyIGFu
ZCBjYWxscw0KPnRpcGNfY29ubl9jbG9zZSgpIGZvciBlYWNoIHRpcGNfY29ubi4NCj4NCj5UaGUg
cHJvYmxlbSBpcyB0aGF0IHRpcGNfY29ubl9jbG9zZSgpIGlzIGNhbGxlZCBhZnRlciByZWxlYXNp
bmcgdGhlIElEUiBsb2NrLg0KPg0KPkF0IHRoZSBzYW1lIHRpbWUsIHRoZXJlIG1pZ2h0IGJlIHRp
cGNfY29ubl9yZWN2X3dvcmsoKSBydW5uaW5nIGFuZCBpdCBjb3VsZA0KPmNhbGwgdGlwY19jb25u
X2Nsb3NlKCkgZm9yIHRoZSBzYW1lIHRpcGNfY29ubiBhbmQgcmVsZWFzZSBpdHMgbGFzdCAtPmty
ZWYuDQo+DQo+T25jZSB3ZSByZWxlYXNlIHRoZSBJRFIgbG9jayBpbiB0aXBjX3RvcHNydl9zdG9w
KCksIHRoZXJlIGlzIG5vIGd1YXJhbnRlZSB0aGF0DQo+dGhlIHRpcGNfY29ubiBpcyBhbGl2ZS4N
Cj4NCj5MZXQncyBob2xkIHRoZSByZWYgYmVmb3JlIHJlbGVhc2luZyB0aGUgbG9jayBhbmQgcHV0
IHRoZSByZWYgYWZ0ZXINCj50aXBjX2Nvbm5fY2xvc2UoKSBpbiB0aXBjX3RvcHNydl9zdG9wKCku
DQo+DQo+WzBdOg0KPkJVRzogS0FTQU46IHVzZS1hZnRlci1mcmVlIGluIHRpcGNfY29ubl9jbG9z
ZSsweDEyMi8weDE0MA0KPm5ldC90aXBjL3RvcHNydi5jOjE2NSBSZWFkIG9mIHNpemUgOCBhdCBh
ZGRyIGZmZmY4ODgwOTkzMDVhMDggYnkgdGFzaw0KPmt3b3JrZXIvdTQ6My80MzUNCj4NCj5DUFU6
IDAgUElEOiA0MzUgQ29tbToga3dvcmtlci91NDozIE5vdCB0YWludGVkIDQuMTkuMjA0LXN5emth
bGxlciAjMA0KPkhhcmR3YXJlIG5hbWU6IEdvb2dsZSBHb29nbGUgQ29tcHV0ZSBFbmdpbmUvR29v
Z2xlIENvbXB1dGUgRW5naW5lLA0KPkJJT1MgR29vZ2xlIDAxLzAxLzIwMTENCj5Xb3JrcXVldWU6
IG5ldG5zIGNsZWFudXBfbmV0DQo+Q2FsbCBUcmFjZToNCj4gX19kdW1wX3N0YWNrIGxpYi9kdW1w
X3N0YWNrLmM6NzcgW2lubGluZV0gIGR1bXBfc3RhY2srMHgxZmMvMHgyZWYNCj5saWIvZHVtcF9z
dGFjay5jOjExOA0KPiBwcmludF9hZGRyZXNzX2Rlc2NyaXB0aW9uLmNvbGQrMHg1NC8weDIxOSBt
bS9rYXNhbi9yZXBvcnQuYzoyNTYNCj4ga2FzYW5fcmVwb3J0X2Vycm9yLmNvbGQrMHg4YS8weDFi
OSBtbS9rYXNhbi9yZXBvcnQuYzozNTQgIGthc2FuX3JlcG9ydA0KPm1tL2thc2FuL3JlcG9ydC5j
OjQxMiBbaW5saW5lXQ0KPiBfX2FzYW5fcmVwb3J0X2xvYWQ4X25vYWJvcnQrMHg4OC8weDkwIG1t
L2thc2FuL3JlcG9ydC5jOjQzMw0KPiB0aXBjX2Nvbm5fY2xvc2UrMHgxMjIvMHgxNDAgbmV0L3Rp
cGMvdG9wc3J2LmM6MTY1ICB0aXBjX3RvcHNydl9zdG9wDQo+bmV0L3RpcGMvdG9wc3J2LmM6NzAx
IFtpbmxpbmVdDQo+IHRpcGNfdG9wc3J2X2V4aXRfbmV0KzB4MjdiLzB4NWMwIG5ldC90aXBjL3Rv
cHNydi5jOjcyMg0KPiBvcHNfZXhpdF9saXN0KzB4YTUvMHgxNTAgbmV0L2NvcmUvbmV0X25hbWVz
cGFjZS5jOjE1Mw0KPiBjbGVhbnVwX25ldCsweDNiNC8weDhiMCBuZXQvY29yZS9uZXRfbmFtZXNw
YWNlLmM6NTUzDQo+IHByb2Nlc3Nfb25lX3dvcmsrMHg4NjQvMHgxNTcwIGtlcm5lbC93b3JrcXVl
dWUuYzoyMTUzDQo+IHdvcmtlcl90aHJlYWQrMHg2NGMvMHgxMTMwIGtlcm5lbC93b3JrcXVldWUu
YzoyMjk2DQo+IGt0aHJlYWQrMHgzM2YvMHg0NjAga2VybmVsL2t0aHJlYWQuYzoyNTkNCj4gcmV0
X2Zyb21fZm9yaysweDI0LzB4MzAgYXJjaC94ODYvZW50cnkvZW50cnlfNjQuUzo0MTUNCj4NCj5B
bGxvY2F0ZWQgYnkgdGFzayAyMzoNCj4ga21lbV9jYWNoZV9hbGxvY190cmFjZSsweDEyZi8weDM4
MCBtbS9zbGFiLmM6MzYyNSAga21hbGxvYw0KPmluY2x1ZGUvbGludXgvc2xhYi5oOjUxNSBbaW5s
aW5lXSAga3phbGxvYyBpbmNsdWRlL2xpbnV4L3NsYWIuaDo3MDkgW2lubGluZV0NCj4gdGlwY19j
b25uX2FsbG9jKzB4NDMvMHg0ZjAgbmV0L3RpcGMvdG9wc3J2LmM6MTkyDQo+IHRpcGNfdG9wc3J2
X2FjY2VwdCsweDFiNS8weDI4MCBuZXQvdGlwYy90b3BzcnYuYzo0NzANCj4gcHJvY2Vzc19vbmVf
d29yaysweDg2NC8weDE1NzAga2VybmVsL3dvcmtxdWV1ZS5jOjIxNTMNCj4gd29ya2VyX3RocmVh
ZCsweDY0Yy8weDExMzAga2VybmVsL3dvcmtxdWV1ZS5jOjIyOTYNCj4ga3RocmVhZCsweDMzZi8w
eDQ2MCBrZXJuZWwva3RocmVhZC5jOjI1OQ0KPiByZXRfZnJvbV9mb3JrKzB4MjQvMHgzMCBhcmNo
L3g4Ni9lbnRyeS9lbnRyeV82NC5TOjQxNQ0KPg0KPkZyZWVkIGJ5IHRhc2sgMjM6DQo+IF9fY2Fj
aGVfZnJlZSBtbS9zbGFiLmM6MzUwMyBbaW5saW5lXQ0KPiBrZnJlZSsweGNjLzB4MjEwIG1tL3Ns
YWIuYzozODIyDQo+IHRpcGNfY29ubl9rcmVmX3JlbGVhc2UgbmV0L3RpcGMvdG9wc3J2LmM6MTUw
IFtpbmxpbmVdICBrcmVmX3B1dA0KPmluY2x1ZGUvbGludXgva3JlZi5oOjcwIFtpbmxpbmVdDQo+
IGNvbm5fcHV0KzB4MmNkLzB4M2EwIG5ldC90aXBjL3RvcHNydi5jOjE1NQ0KPiBwcm9jZXNzX29u
ZV93b3JrKzB4ODY0LzB4MTU3MCBrZXJuZWwvd29ya3F1ZXVlLmM6MjE1Mw0KPiB3b3JrZXJfdGhy
ZWFkKzB4NjRjLzB4MTEzMCBrZXJuZWwvd29ya3F1ZXVlLmM6MjI5Ng0KPiBrdGhyZWFkKzB4MzNm
LzB4NDYwIGtlcm5lbC9rdGhyZWFkLmM6MjU5DQo+IHJldF9mcm9tX2ZvcmsrMHgyNC8weDMwIGFy
Y2gveDg2L2VudHJ5L2VudHJ5XzY0LlM6NDE1DQo+DQo+VGhlIGJ1Z2d5IGFkZHJlc3MgYmVsb25n
cyB0byB0aGUgb2JqZWN0IGF0IGZmZmY4ODgwOTkzMDVhMDAgIHdoaWNoIGJlbG9uZ3MgdG8NCj50
aGUgY2FjaGUga21hbGxvYy01MTIgb2Ygc2l6ZSA1MTIgVGhlIGJ1Z2d5IGFkZHJlc3MgaXMgbG9j
YXRlZCA4IGJ5dGVzIGluc2lkZQ0KPm9mICA1MTItYnl0ZSByZWdpb24gW2ZmZmY4ODgwOTkzMDVh
MDAsIGZmZmY4ODgwOTkzMDVjMDApIFRoZSBidWdneSBhZGRyZXNzDQo+YmVsb25ncyB0byB0aGUg
cGFnZToNCj5wYWdlOmZmZmZlYTAwMDI2NGMxNDAgY291bnQ6MSBtYXBjb3VudDowIG1hcHBpbmc6
ZmZmZjg4ODEzYmZmMDk0MA0KPmluZGV4OjB4MA0KPmZsYWdzOiAweGZmZjAwMDAwMDAwMTAwKHNs
YWIpDQo+cmF3OiAwMGZmZjAwMDAwMDAwMTAwIGZmZmZlYTAwMDI4YjZiODggZmZmZmVhMDAwMmNk
MmIwOCBmZmZmODg4MTNiZmYwOTQwDQo+cmF3OiAwMDAwMDAwMDAwMDAwMDAwIGZmZmY4ODgwOTkz
MDUwMDAgMDAwMDAwMDEwMDAwMDAwNg0KPjAwMDAwMDAwMDAwMDAwMDAgcGFnZSBkdW1wZWQgYmVj
YXVzZToga2FzYW46IGJhZCBhY2Nlc3MgZGV0ZWN0ZWQNCj4NCj5NZW1vcnkgc3RhdGUgYXJvdW5k
IHRoZSBidWdneSBhZGRyZXNzOg0KPiBmZmZmODg4MDk5MzA1OTAwOiBmYiBmYiBmYiBmYiBmYiBm
YiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYg0KPiBmZmZmODg4MDk5MzA1OTgwOiBmYyBm
YyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYw0KPj5mZmZmODg4MDk5
MzA1YTAwOiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYg0K
PiAgICAgICAgICAgICAgICAgICAgICBeDQo+IGZmZmY4ODgwOTkzMDVhODA6IGZiIGZiIGZiIGZi
IGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiDQo+IGZmZmY4ODgwOTkzMDViMDA6
IGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiDQo+DQo+Rml4
ZXM6IGM1ZmE3YjNjZjNjYiAoInRpcGM6IGludHJvZHVjZSBuZXcgVElQQyBzZXJ2ZXIgaW5mcmFz
dHJ1Y3R1cmUiKQ0KPlJlcG9ydGVkLWJ5OiBzeXpib3QrZDMzM2ZlYmNmOGY0YmM1ZjYxMTBAc3l6
a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQ0KPkNsb3NlczogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3Bv
dC5jb20vYnVnP2V4dGlkPTI3MTY5YTg0N2E3MDU1MGQxN2JlDQo+U2lnbmVkLW9mZi1ieTogS3Vu
aXl1a2kgSXdhc2hpbWEgPGt1bml5dUBnb29nbGUuY29tPg0KPi0tLQ0KPiBuZXQvdGlwYy90b3Bz
cnYuYyB8IDIgKysNCj4gMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPg0KPmRpZmYg
LS1naXQgYS9uZXQvdGlwYy90b3BzcnYuYyBiL25ldC90aXBjL3RvcHNydi5jIGluZGV4DQo+OGVl
MGMwN2QwMGU5Li5mZmU1NzdiZjZiNTEgMTAwNjQ0DQo+LS0tIGEvbmV0L3RpcGMvdG9wc3J2LmMN
Cj4rKysgYi9uZXQvdGlwYy90b3BzcnYuYw0KPkBAIC03MDQsOCArNzA0LDEwIEBAIHN0YXRpYyB2
b2lkIHRpcGNfdG9wc3J2X3N0b3Aoc3RydWN0IG5ldCAqbmV0KQ0KPiAJZm9yIChpZCA9IDA7IHNy
di0+aWRyX2luX3VzZTsgaWQrKykgew0KPiAJCWNvbiA9IGlkcl9maW5kKCZzcnYtPmNvbm5faWRy
LCBpZCk7DQo+IAkJaWYgKGNvbikgew0KPisJCQljb25uX2dldChjb24pOw0KPiAJCQlzcGluX3Vu
bG9ja19iaCgmc3J2LT5pZHJfbG9jayk7DQo+IAkJCXRpcGNfY29ubl9jbG9zZShjb24pOw0KPisJ
CQljb25uX3B1dChjb24pOw0KPiAJCQlzcGluX2xvY2tfYmgoJnNydi0+aWRyX2xvY2spOw0KPiAJ
CX0NCj4gCX0NCj4tLQ0KPjIuNTAuMC43MjcuZ2JmN2RjMThmZjQtZ29vZw0KPg0KUmV2aWV3ZWQt
Ynk6IFR1bmcgTmd1eWVuIDx0dW5nLnF1YW5nLm5ndXllbkBlc3QudGVjaD4NCg==

