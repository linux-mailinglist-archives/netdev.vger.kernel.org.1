Return-Path: <netdev+bounces-177842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336BBA7209E
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 22:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1938F7A276C
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 21:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA2019FA93;
	Wed, 26 Mar 2025 21:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gKPU9Qei"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FBC17A2F8
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743023890; cv=fail; b=dEZhJRNy4Axg080xEYgu1rtC2Vl/1WKA0BQC653JHfsIlIEfBJmtOfSQ9FLnwCWBv6vxJzIVZb149nF7JKCmc18oYaUIHo6ZvNafAjtcdWge1gUgTVa5YaAbUh+Gx8/xwHshUxABgVBLMDMskcGrNHrNHH+lRClpg8uw2/4uljQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743023890; c=relaxed/simple;
	bh=7aTV/zGUhjjUKjnV+5exB5nQ0ytKF6EsAHK8jJzEwSI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RDVfI/CA7lQhKePeZ+HpLWqwQgNHS4qBqZtOgTR5OP4qf+oOXmACJZe0LgOCdhuN71wYE2CNSS4pQjEheYlNxyIG/1vFqHepe2A7n5yd4R8GXXgWFLh1nMdTiJ0sCMw+Dx2mxW9BN7CJYc3ngPSYiUo1A5eVDhUw24P1RdAJgGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gKPU9Qei; arc=fail smtp.client-ip=40.107.212.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJhcXr2kbck97lV6zUI6zOZH+kGMhvgEMS019JjShP+N0Yf4Z2JPq3vgYskkXEHL5/gu9i6bh0Z0HiH0YnaoTR0xSERy/GYKxLHIELsLyh07YkJ+X0Bq2k4qHJ2KMeEflGgct0pw4ky/e+7YsfcOD7ayUff57lxoB8Oqhtj5wbYR1MWuTcE9AOIhVfUq3CxrQmI6bYFAREYC8GxykE/vXc+a2ENAncM/3G7L5BcFle+/TWzcu1nQSCMjifN4UzKhpDugKZ9SVkf73jZq9jypHSlYvB0GeVxFtm00UCA9B+OJybLr1QMrRZP+yxwfnthEnveph96Xip2zGZFEZmhSPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aTV/zGUhjjUKjnV+5exB5nQ0ytKF6EsAHK8jJzEwSI=;
 b=dlYFRHxZnxTKcTS5CdG/FgugjMR+B453652zS4tfav+NVs338weTGmONZLWVaKj03X7MbP9PjWmqVC5GPbkqz9J2b4SFJ4ptO+m/LlxCw0tvLqzozla70exrvTc8oorXCr30S17QdBPslVoyOYvPA3uti/j20QDPYfdnbQSqjo7bnijYkNRRRSzqr6jAESRydxc70/Bxc21EGdfhh3zOCKxh8OUeKprkcYIz937XvAxsL2bsdzF38kqcQCIPvUBlW/KWTH3BzXVwdLM8i8Rng1kY5kiD+UZSKaSjofOAdQtmH7+9CZ1JNQJ5yTbEwmA6SGHaGwbtSxVGq31spLNIqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aTV/zGUhjjUKjnV+5exB5nQ0ytKF6EsAHK8jJzEwSI=;
 b=gKPU9QeijvfD8im9weayeC46SdV/T7SJbRhC6jOV6Mvs3ruW5G5dn0TWXhoJ1zvbgEoQhlMOSSv4tw001y+rw6wiNQMdw0kgxLMWgAcY/YPZBKETeN6ru27RSPzTKIP6YMvRu81h/rqB37CtHsi1N8y/UcoS5HNNgqm9AnFqJur66ujDpEnWldjnuGZgfwvdwAn9R5RzDJK/fUojuoKlg99tbqyFqLPGU2eBxQ9jwPE0UCivtHbE4S8JjpYiBD29hSnqjtDgpgDi6NjZgsAPSIad8DgnIhYIZ2ETYTr1EiZt/QRojNRL+0c1LqryOtD3RSpGexCerdoitikAs6roXQ==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 CH3PR12MB9252.namprd12.prod.outlook.com (2603:10b6:610:1ba::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Wed, 26 Mar 2025 21:18:02 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%2]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 21:18:02 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "stfomichev@gmail.com" <stfomichev@gmail.com>
CC: "kuba@kernel.org" <kuba@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "sdf@fomichev.me" <sdf@fomichev.me>
Subject: Re: [PATCH net-next 2/9] net: hold instance lock during
 NETDEV_REGISTER/UP/UNREGISTER
Thread-Topic: [PATCH net-next 2/9] net: hold instance lock during
 NETDEV_REGISTER/UP/UNREGISTER
Thread-Index:
 AQHbnc04GLropLE/UEietC5IV/U+Q7OFhLuAgAAF24CAAAOvAIAAJRWAgAA0UICAAAXTAA==
Date: Wed, 26 Mar 2025 21:18:02 +0000
Message-ID: <66a15c52d68a2317dfa65093ecd227b0ad4684cc.camel@nvidia.com>
References: <20250325213056.332902-1-sdf@fomichev.me>
	 <20250325213056.332902-3-sdf@fomichev.me>
	 <86b753c439badc25968a01d03ed59b734886ad9b.camel@nvidia.com>
	 <Z-QcD5BXD5mY3BA_@mini-arch>
	 <672305efd02d3d29520f49a1c18e2f4da6e90902.camel@nvidia.com>
	 <Z-Q-QYvFvQG2usfv@mini-arch>
	 <e7cbdbf24019ba5deac18ccf5eea770d4c641455.camel@nvidia.com>
In-Reply-To: <e7cbdbf24019ba5deac18ccf5eea770d4c641455.camel@nvidia.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|CH3PR12MB9252:EE_
x-ms-office365-filtering-correlation-id: f944b2e9-a160-4986-3007-08dd6cabb0f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RkM2U0szTmdRTXBQMXF2NXNkL3IveVRXTWRpbnMxL1ROeUJnaDNoUWNuSUhk?=
 =?utf-8?B?TWp4WCtLUVM3Tk1uc3NjZjRYTEMvUjJtUWxLVUF6ZFREcktjdTNQbEpxTXoz?=
 =?utf-8?B?MHJGanJvTFR2eXp2emdMU0ZrdXRnNGl4T2N4Lzk5V0xFdkR3QUFOZ1lkTDNs?=
 =?utf-8?B?dTZjMTN1bmV0OVhiN2JkSXFuRHgyVHF2UnlNdjZQNkZJMGYvcVRSN2doVXU3?=
 =?utf-8?B?T3d5THFEVzc2OHJKZmhLUndSaE1tSzhnSkNaL0o1QWwwMWE5VWxlYWV2QUhP?=
 =?utf-8?B?UmFQQUhycmRQL0k3K042R2orL2gxd3RERDV5a004Zk00eGY3YWJpUXU0clZt?=
 =?utf-8?B?TzhMWTIrUEFHelYyVE5kMkFZaURHRFB3UkdodUZJVmFVVWQwZHZFQTlJYkhN?=
 =?utf-8?B?ejZHWXN4czJCenBocUlpREtER09pU3VaQkQ0bllCTnU1OW9aU1pUcEJhMjBP?=
 =?utf-8?B?TEhIYld0WldWWlFOK0ZuNWRXV0NyUjBPOXBjTUU4QU96Ynk3TVNSc3BUMlZ4?=
 =?utf-8?B?SEt6MG9aY0lpbHgvNVc2S2xZcTVGV1IvNjdmTkF2Q0RLRWJDczhMUzVON0tu?=
 =?utf-8?B?VGltZ2lucFBhUE4wMG1pT042clhaMGpVaEp4aXQ0cU9LY2s1K3dLRkttWi9Y?=
 =?utf-8?B?ekZvVUIxL0dFWXN5MDUxVk43aFUxdW96cHdja09waTJpZkd6TFYxTXUySi8y?=
 =?utf-8?B?R1VlMi9XTW9WZHdEUXh6Yk9DcEVCK3NiRFAvcmZydHRKQUwySVdra1BYZlpO?=
 =?utf-8?B?N0ZaRW51aHpHNWdMOGR2dmRaN1Z2Um5oMFphUVdwMDV6Z3JqWXl0MnZpZWhm?=
 =?utf-8?B?R3pzbWhTdDhmTXdPWHlLWUtEdXR5UklqSHRrUWoraE05Q1J6NnRuRUMrNjhK?=
 =?utf-8?B?ME5RSUt0SWl5bkdxSWk3QlB4T0thcTJqZWV6aWtSaHhiWGNmVjVBZWFWWnEv?=
 =?utf-8?B?RjFwRHU5aGJPeTluYUJpcFpxOVh0Sk5PVG5kWHhzcEF2eitjbGEyOUJGd09E?=
 =?utf-8?B?TnNkR0xLS0pNRkZjdU5heERvYU5jMVYzUW80am8vZkZ4Q25POWFoWHMyYUxN?=
 =?utf-8?B?OTd2QVc5Y1RBbWwrblY0VFk4T2ZuQ1QrTDYrNTVNUHZML1FGVnJUVnl6N0J6?=
 =?utf-8?B?TXhuZzd6WHBVSkVDZGFHdDhVaWdmWi82bjZXQmhQTVc0UTNQUnNkK2x2ci8w?=
 =?utf-8?B?aFpESktINzZnWTFvYys2MHBhSVJjRXBvYnhpMHJVQlFvQm8wWSt2ZnA0dWw0?=
 =?utf-8?B?QmZ2cjdXN0hmZ3MzWitMektseWEvUkxCeVpTQkdTQ2RjYmJ2cU1iNUdVTUx3?=
 =?utf-8?B?b3o4dXdnTUJ6NmtBblRvRDlpU044cDBzbjBQeXhZa1ZIa1U5b1F5UEdDYWpJ?=
 =?utf-8?B?cDkvbW8yRDEyL0ZqMWk1bXNBUklrZ2g3WXRaZEU0OFZxTTJubzU3UmxDYVBI?=
 =?utf-8?B?bDZYci9yS0tVQ1ZIaWJXM3Z0cmV0K3U5dkZ0N0NhV1NnZms3OHlveDhwc2JO?=
 =?utf-8?B?TWpBeWtENzdLUG1QYTFhOUtyYzB1R0VidnR2ME9OdEs5ZVBsN1Nnc1RsQUgv?=
 =?utf-8?B?Q3RkVHRtMzBpbU1LeDNYbVM3c1ZWYXlBTkxzOCtyTjR5WFIyVlFHS2kraFl3?=
 =?utf-8?B?RHpVU2RibG1tOVZEM0RobTlJOGs3Q0VublBFZHNWRXhnNGJiMlJhTENMTVV2?=
 =?utf-8?B?ZXBJWVYyb2N0Y1BCQzBSa2lDVGVKd0Y2czZLT1c1TlFsU2YrZEJTWW1RMjYz?=
 =?utf-8?B?MzBPQUhvQTR0czJBaDc0YS9xMzlKeWJMcUEwZDFxNG85TnV6K3FkaW9JWlVp?=
 =?utf-8?B?NVcxOG44VDF4R040WlpvYTBFNE9VdkkyOXVSZlUzZ29JMHRXVi94Vk5IV3VV?=
 =?utf-8?B?ZEZtZGJtazg3MVNjUmhFWHNQNHE5OFByeEJibDM5YlB4NVVxSmVBSTZScGNo?=
 =?utf-8?Q?lIau8wUU1bNCNCvE48lIuTc7jLo2JYWy?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dHoxWExYeFVVTDNSWExzQVBDZWxPcVl2VDNzTVdkVDVpdFVOMFlsbVB6dHVE?=
 =?utf-8?B?TTNILzJUdXJQc2xWeFBVdTJGMzhmbVlwT2tTdDZ6dWpFSHhoVXBvbzZtdGpx?=
 =?utf-8?B?ZHVvZlBaU0Roc1BSUXJVRjc2RTI4NnlqdXlQSm9CeWZEM0tUczg1eTkvK2Rp?=
 =?utf-8?B?Zm5YREF5b25NeVJZdmh1SDNZUTZzdmFLN2w2MG0yZHUzMFJyZUx0NUZzQVpG?=
 =?utf-8?B?VUpRak9YK0RROEpwam4rTEpiQi9zTkJmY2pFNnBUb1VlZzczK3plVEYzdTFI?=
 =?utf-8?B?RE9OdDBIaGtqMFQrb1ZLQXhTT0I0QklIMnBVMmRsZTBEb1pGZEZqT1o5RWhq?=
 =?utf-8?B?OTZlRnZOTzd5c0t2M0pJdXJBMWgxM09McWl1UDRXbXY4eHd2YndKd29TeHJY?=
 =?utf-8?B?eFhuLzFIbFQvejZ6TVJBRTA0STBFRXVvMWNsSFk5RHAwcGNDSVpnenZJM3Yz?=
 =?utf-8?B?Z2hQVnpKam1HRHJ6S01zUnovNFU3eXAzRWFXUVdpRk5hSFdYZEh1bklLa1ds?=
 =?utf-8?B?RjdHZWhzVDByOWJ2SGpva21XL2dUcUxtdlYvVkh0QUo4UGZTbVlZamR5cnRs?=
 =?utf-8?B?ZVJQVWFCTVd2R1FIaVdPZnFlZGlLSVdqSHY2TTFjSXdYekUvNUc2d0N6WS9G?=
 =?utf-8?B?VlZBNldNRzE5TUF5V0E1MXc4SkxwcnhuMlArY25YOEpPTmhUQ0dLdlZrU0pk?=
 =?utf-8?B?Mm1pcHZNekswd2pIeDhpUjMwK3V0NStqVHZiZXRjU3V2RDg0bGNZOE52cUxO?=
 =?utf-8?B?bU1zNjNsZGx2RjdQNnd0SzFvSExhTE44QTM1TmZLa3BxSjc2eVEzSDd3VzZO?=
 =?utf-8?B?SHRsdmpVeWtWWHdKKy9ZazlnL3o2NDRBbWY2NlA5eUpFcHEzQmE4czlIOERG?=
 =?utf-8?B?T1dObW12WHF1Q2NJTUxlNWNIWGZyTXgxOU1TUnEyL2NudzN5SUx2bFNiU3pV?=
 =?utf-8?B?SVljdVF5TUhyK0RxaTAwVWdXY3E2NmNPUmp2Umx3T2lWWmNIcldnQzFOZ3o4?=
 =?utf-8?B?dGdHK3M0M25IdG1mTlpjaG43RjhXWXVCNVpra29lUG1TRk9WVDF2NmZNWUMz?=
 =?utf-8?B?SE5UMk9KZW4vT3pkTk1rN1NtMzk1bWJHTUo2a1JSOHJ1TXRxcFBzbTYrb2Nm?=
 =?utf-8?B?eWNDMEdqdmREZzNPRXRVd2Fja1Z1TklUckR0QWplUzBVamlZZUxLbVl4cGU0?=
 =?utf-8?B?Y1FCYWZTSU1jUmNoZWo2VVViN3pPQkdsemNRVXFNQjJucVNiRWd2RVBhNkU4?=
 =?utf-8?B?V3ZhdzEzN0hROTZGaDVJOGZKancva3JZaHdsb3V1cjZwVTF5OTk0bTF3TDRI?=
 =?utf-8?B?MFZPOTB5aG9MM2loNG41ZFdyNFpMdjU2ZEo4aEgrc0NyRmwyZ3laazRvajRT?=
 =?utf-8?B?MzFzSFNWZjRsQ3JCWVY0U3U3ZEJPU2tOTno3M29KbTlreCtVckw5ekZZQSsv?=
 =?utf-8?B?enY1ZUZ0UkpkM0x4UkNXbHB2SHczS2l2Rk1sRURXc3JzejRkd292djFCV21w?=
 =?utf-8?B?NHVHdFhSb2hQUm9JTGEwd0ZhbEkxeCtwWXJZTVNtZnU3MFpZc2IvUmM0eDZM?=
 =?utf-8?B?Z3Rkc0dTTjkzTDFjOFBqMm5kS0NrZmM4RXFLTEtoaEswTnE4c1FqSWhTUWJP?=
 =?utf-8?B?TmVuZkVLdEhSSnBPektQL01CZzh3MXB4YWhmdTl0cWlFVGlGQlV6VWhBbW96?=
 =?utf-8?B?SGRDUmUyd3YrTHhIOG16Q2g2ZVdDanp5ak85Rk1HT0NFd3c2OCtPOTIzZkIw?=
 =?utf-8?B?ZFl2dnRoN3IwQ1RKVHpsRHRvekczUWMzdE5mVEJmUmcxN3hlR0F5SEppS0Vo?=
 =?utf-8?B?TDdtZEhPWTMrRTViQWQ2dloxbUF4b2ZhTUpxWmYzMWovSER1dHJiZzZvbWhi?=
 =?utf-8?B?Y0k2WmZuOUJKaW9XeThOdHNrUG5WYTJEZ0wvZkNrcERKZnZqM0tPMTNqQmJ2?=
 =?utf-8?B?SVdqQ1c2Q01hKzl6VDNJdy9OUGhoV0hZb2ZaMlFsSUVyRDN1YS85V2MzQXVM?=
 =?utf-8?B?NVB2OVIvSUtaOEgrdDBiZldZS1NoN000N2oxbEZOL2E3d3pEbmxpZmdmaGtH?=
 =?utf-8?B?MUtuSWdla3JQdC9wMjVpdUlwVERjV3JFM1o5RWkwQk1nTE9RdC9iN2JvYVpH?=
 =?utf-8?Q?vnKairHbue4agwvX7figZ/ZU8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F2E8E7593D40E488EBC0700ABC7A973@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f944b2e9-a160-4986-3007-08dd6cabb0f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 21:18:02.0157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yUhrAk6b8SmUvzmjwdALnFkVpXy6eanZhQB2wpynKbQgl6cMbkAJHpMPAyUaZdMxlzoXZUIgN6pBRf/BccyO0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9252

T24gV2VkLCAyMDI1LTAzLTI2IGF0IDIxOjU3ICswMTAwLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+
IA0KPiBBbSBJIG1pc3Npbmcgc29tZSBsb2NraW5nIGFubm90YXRpb24gcGF0Y2g/IEEgcXVpY2sg
c2VhcmNoIGluIG5ldC0NCj4gbmV4dA0KPiB0dXJuZWQgb3V0IG5vdGhpbmcuDQoNClNvb24gYWZ0
ZXIgc2VuZGluZyB0aGUgcHJldmlvdXMgZW1haWwsIEkgZm91bmQNCm5ldGRldl9sb2NrZGVwX3Nl
dF9jbGFzc2VzIGFuZCBzYXcgdGhhdCBpdCBkaXNhYmxlcyBkZWFkbG9jayBjaGVja2luZw0KZm9y
IHRoZSBpbnN0YW5jZSBsb2NrLiBXaXRoIGl0IGluIHBsYWNlLCBpdCB3b3Jrcy4NCkkgYWxzbyBz
YXcgeW91ciBvdGhlciBlbWFpbCBpbW1lZGlhdGVseSBhZnRlci4uLg0KDQpXaXRoIHRoYXQgaW4g
cGxhY2UsIHRoaW5ncyBzZWVtIHRvIHdvcmsgZmluZSB3aXRob3V0IGZ1cnRoZXIgd2FybmluZ3MN
CmZvciBhIGZldyBxdWljayB0ZXN0cy4NCg0KSG93ZXZlciwgaXQgc2VlbXMgdGhhdCB0aGlzIGFw
cHJvYWNoIGlzIGRhbmdlcm91cywgdGhlcmUgaXMgdGhlDQpwb3NzaWJpbGl0eSBvZiBhbiBhY3R1
YWwgZGVhZGxvY2sgd2l0aCB0d28gY29uY3VycmVudA0KbmV0aWZfY2hhbmdlX25ldF9uYW1lc3Bh
Y2Ugd2hlbiB0aGUgUlROTCBpcyByZW1vdmVkIGZyb20gdGhhdCBwYXRoLg0KDQpDb3NtaW4uDQo+
IA0K

