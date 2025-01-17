Return-Path: <netdev+bounces-159160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A06A148BB
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 05:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5321603B0
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 04:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA181F63ED;
	Fri, 17 Jan 2025 04:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="uMPlYhKR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD6B25765;
	Fri, 17 Jan 2025 04:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737087123; cv=fail; b=gG400ooM2GE6pUaS3Q2O5/xi4OfkoWrgvpIHkKbdUldOapmAfP1q3Fb3aKWwTzWbzeBp8N8CA9dn4ZOKMRaUv/jg/V0HFQRlF27eeD1saZFNW/4MbX+aOisnMhAYUeoBfF2eNZJrzbx+tCOxaFi1RT76vatjIF0MjY49PSxljiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737087123; c=relaxed/simple;
	bh=8+pLGQq8ztcw8B4/2WpwZfcUooNUicZYJOFo86aZte4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qPYsq6109stMWoTC8Tkav93yqVEAZ606EgeQI0l+zW+UeKSmmkq+220u+svXn7LlCblQzQ0lgpaOfNoXxjdyrCVhnzJZznDOpXOxKASFO80KQ5H0vpBBh/YyA+NH/dWeRgD9gfIwGnJca2KKLvUxubgwACbWEEmmP81pkCqSTS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=uMPlYhKR; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H3SSRe019968;
	Thu, 16 Jan 2025 20:11:38 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 447far0210-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 20:11:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDpu3knZFUBC+SG+Co7a+bte09gB1BARfujiK8l5T9i2FcOo0kX3b3s6xvatFMxmOtCkVABf+/kTD2FO3Ki5ICEtDff8ppJ20IW29BRJ8j4UG5V7wfakBizrmx/NLnlci7YnJWC59gV3Tl4Fp24nb1vja2ALHw6i4S0juc64zDOdg20uBBDi+4rUIZe15+UQnCPZsM2EPOqNze/XUn7YSvn831RcaesDWweztj6TgmpFgZTR/cPlYQbdaHraoan+OZgAyRBX9diXZe9xPWFCiczRTApc5JamLMZO+lI0OXQpwSru/n91UrHdKD//h5Vm31UZ62/WKMwqeANFsmW8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+pLGQq8ztcw8B4/2WpwZfcUooNUicZYJOFo86aZte4=;
 b=ERh/rv0oAUax88wY9/fJNQFSrLfSXBmY1uKAf5UdBEvuzb/JCVBeP5J++wiQrOA9iyeEhwqyP7a5IHfQX27XCOSji5GqGXkzjGAnvH4OOTbLm6mYtSta7EDsCe0YHkyAxgUPc7CUxeZzoy9sj1ffpy8ODx3qk14U3KpE29wQ6gFOJBjCYQrh+5lYdz3iaNHhuErn2j9FJ6MnJ5aSjGZETKlHyeJYnbgH+3+b6EqJEkJgIcLHcek/jbgk+oP1sma6E/Mh9QAd7uPJ9FAenmkERvE3k18Gen0qiqR4kWZRNluzQDPA6m5WuQY/Z+CyvaM+lFMhN3hUmg74ABlEZSvZ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+pLGQq8ztcw8B4/2WpwZfcUooNUicZYJOFo86aZte4=;
 b=uMPlYhKRDhBmTbi44qRhVByZyjskoGpCClTReTM2mlrhaAPXn0CUaBhRk2F0ZNAPuq3Yurt0YsdCRv/BdQzqiMGkAh43nMBddwPIcExDXZTmx2ftybPBKggqHWo4T8TzKDzUSpGBu7JANHzVz31onAqeBzJXkSgTX9s7aSY6FUc=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by PH0PR18MB4782.namprd18.prod.outlook.com (2603:10b6:510:cb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 04:11:33 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::8adb:1ecd:bca9:6dcd]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::8adb:1ecd:bca9:6dcd%5]) with mapi id 15.20.8335.017; Fri, 17 Jan 2025
 04:11:33 +0000
From: Shinas Rasheed <srasheed@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>,
        Larysa Zaremba
	<larysa.zaremba@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani
	<hgani@marvell.com>, Sathesh B Edara <sedara@marvell.com>,
        Vimlesh Kumar
	<vimleshk@marvell.com>,
        "thaller@redhat.com" <thaller@redhat.com>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "kheib@redhat.com"
	<kheib@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "einstein.xue@synaxg.com"
	<einstein.xue@synaxg.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew
 Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [EXTERNAL] Re: [PATCH net v8 2/4] octeon_ep: update tx/rx stats
 locally for persistence
Thread-Topic: [EXTERNAL] Re: [PATCH net v8 2/4] octeon_ep: update tx/rx stats
 locally for persistence
Thread-Index: AQHbZ/IIxKpUL8HISEa62Brb9QckaLMZhhUAgACXH4CAAD1vcA==
Date: Fri, 17 Jan 2025 04:11:32 +0000
Message-ID:
 <PH0PR18MB47349A17C33D8665C32513DAC71B2@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20250116083825.2581885-1-srasheed@marvell.com>
	<20250116083825.2581885-3-srasheed@marvell.com>
	<Z4klGpVVsxOPR3RZ@lzaremba-mobl.ger.corp.intel.com>
 <20250116162711.71d74e10@kernel.org>
In-Reply-To: <20250116162711.71d74e10@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|PH0PR18MB4782:EE_
x-ms-office365-filtering-correlation-id: 174d2ced-2999-4ab0-87e9-08dd36ad0713
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SERuUEhFM2pUMGQ0SWJ0WWduN3FSMkZhUDE5MEhaVndpLzl6cUd6cVhtOGhT?=
 =?utf-8?B?U3BlRzE0NkUyRktDVWR1alBoKzRZRFBCL3V6VFJUcnpGVUFoNlhsRWZUbkVI?=
 =?utf-8?B?SWtYQUUrOGNYdDYyelJVT3dhUDhnem1JUzZEMzI0Qjh1NjVvOEhjV2Y2ano1?=
 =?utf-8?B?NkhnM2xvNDdpRlNOSnA0eDhsblBVbUJnQXZFTHdocXZvZ3dLOTNXVmJTelhS?=
 =?utf-8?B?Tzdrd05pbkVseXYzd0x4d0dwdHdHZkMvM0xkTEcxUG5Xdkx5QmY3czFwczR6?=
 =?utf-8?B?TGNFLy9rblRITHBFTkZqTnNUbWpVOFFBbGVZUGdSM3JRcW1zTkYvaHFoK0x5?=
 =?utf-8?B?Qk5RV3dYS2hVZ3VQeHluVk41b29zWVVEUklnUmdHQU5qSWt0R1c4ejBRak1a?=
 =?utf-8?B?M0JXaFBaUnpaT3NjcGx1WkQvSHdta3haZGVyR0p0VTBDc3JtWVh3MFY3bDM2?=
 =?utf-8?B?eTlxVHl3WGo4S1JVYWlNVHRYek9WN0tOK1Jvb2V5QUpIL1g4Q2hPdkJwLzhm?=
 =?utf-8?B?WVc1L2V2bzU3SDNFdWk0eW1oWUY1Ym5PWEo1NWl0U2NFaGVkUVhGRCttdk5Y?=
 =?utf-8?B?VTZ5cXNqS0FhbHR4dkJva2RFOVMxdzg5N0MvUVhOVS9rWVFOR01nNG56SHBQ?=
 =?utf-8?B?Z2xtYVJwekxFYUNUL09WZHpxWDl5dS9uWkVDVkpmTVhJVzJucEk5SEhQbWxR?=
 =?utf-8?B?VkJjMlhrMHdOWXg0UzJ4SHp1aEpqYjJHcm1sNmk2WmhUbzhFUDNSTnlDNko0?=
 =?utf-8?B?UmdUdWkyOW4xRTM2YndsQjJLZ1BHbTM2QlVsaURKNi9PL1R4QjVlbklkdnpj?=
 =?utf-8?B?THpRK2hxQ29QNmJuMG5aK3pqZXF2MU5LYmNDL0pQSFppYlNKam9EeHpiNFBP?=
 =?utf-8?B?dWIwaVpac1NEOU5TS2ppcjdLazB5WnJCNDRTR3FueGF6V1Z3Zit0THVRUW9q?=
 =?utf-8?B?TDBOeExhQVd0R0ttVlVzU2RZK1FZbFdiRXdNdkhLREI0Wm5mbEM4WDRlT2xs?=
 =?utf-8?B?ZnFXQUpheEcxV2hBTmRtYTVxNlQrbFR3Zk1RRjdaK1RVWkh6NTNVQWxMbTlN?=
 =?utf-8?B?b1dwZEZxcElmSnFuS3pKV2ZFN0MyVWp5eEczaHptdERMZ0szeWgwK1BXN1pn?=
 =?utf-8?B?VEdVTTF3SWNRRk44SEQvaHF4elMwYk5hNUk5aXhRNm5TZlgrUjJjNnQzNDJn?=
 =?utf-8?B?R3g4QmZ4ZThleGw1MFdIVks3ZnI2RHBMaDY3ckhUMUZTbVNLMFBDZ0pzY3Nn?=
 =?utf-8?B?TGpVQ2c2ZTk2Qlpmcm4remdZelRaaU5IRGk4QmU0NGVvT21GbkI2VnRnZ2Y2?=
 =?utf-8?B?dDlUVDNaNUs0akRDV01VcWxPZVBES0sxa2pGNW1GN2x2c0lIUWt1VU9hTWNw?=
 =?utf-8?B?cmYwLzlMUnAwT2duWDllT2ltSDluSEFsMDBTVXViZjkvODV3N2pQMU5VQmFM?=
 =?utf-8?B?a0pWajdzNGo3L2FCeTBMNzhXUlRST1IrWUJzUVlSVWFZZE9Jemp2WEZYdGF2?=
 =?utf-8?B?aG9jeGtjV0xPRnNMUkJMYW1rS1NwQW03QW82Ym02TEtvT1NVMWozRlRYWXI1?=
 =?utf-8?B?SlJuZE8rQnRiVlFpRGppSWtvQ2hCNExGdElpRDhrUDhhZ1Q5cm9xN2hXSzFr?=
 =?utf-8?B?R3Vjc0cyTldQdkdKZ3ZZTk1rWGFaa1p0TEl4REl3ZUZ1Ym9qT21ab1crZUhq?=
 =?utf-8?B?VVRYYTNZejZCKzNyZ010YW5qWmg4dmpZTEZKK01xOHg1dTFvdFdtamYwelQz?=
 =?utf-8?B?TVdHUDlNOEdGUk1TdGtXZWY2QXI3WmNFdS9iODVGb1RwNlVtU2dKaVJpd0VE?=
 =?utf-8?B?TzFUWEJuOHFiOVIyanh2R1R0cjJqT3NWaWlkZWlXQzJLaFlyeEVDaVloTWky?=
 =?utf-8?B?aEZZV3BOK2IraXFnV1lzVXFHOUJNOUlFc0t2ZjM5WlUzaG54UDFQMFVzK1Bz?=
 =?utf-8?Q?WnPTgtpDm1DaqCGMWF4wurI/Vg6lkSex?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1RsSVZuNkkrUUIvWUtHaE1HemJCN0dVeTdrclJSWklPbVRvVk9OZXdKZE9y?=
 =?utf-8?B?RWp0ZGxnQVNJb1pEWCtrSEhyUFgrYS84LzFjb0dFdEs1M2t4UHliOEYrbzZE?=
 =?utf-8?B?L2lmcDE0TEI2RUZ0RTYzdS8rYVZjNzhMZTlvbW9qZFRpaVk1a2RIM3lzNVk2?=
 =?utf-8?B?anU2WmE3MFJZcXNsUzMwNWhxUmh2SXlJM3lDMUdQbUZ4dVJ0aHkySnRmdVgv?=
 =?utf-8?B?dE1DZ1UyY3BERHlIb3l5UTd3Vm04NklDeFhBTDdpTkpua3JpMlhWQ2VHNEZw?=
 =?utf-8?B?UktZamdpKy9zNzMzZUptVWVWY2FScm5QalkzYkpWS1ZDZE9hbWNYRUFUL2R3?=
 =?utf-8?B?QngrbGhCYVk2a1lXMWdGcHlJWHhnaHZlck5hNFpVUDk1V1dKV1RwaUxuNW4w?=
 =?utf-8?B?THlzbG9nVWZzMFJIbDI1S1UzZklwT0xUSWlZazZTNW5vK3RPWitoQ1Vob0xm?=
 =?utf-8?B?cUxXWE1DNEFrUjAvd0lTTFNNMmJwbEZhbWIrcnhJZk4xMkt3eG5JOXVxN1F2?=
 =?utf-8?B?Q3NZUjU4amMzbGViMTlhWTZuU2xYWU1KamxRNE44SFVtd04ralhkU0M5MGtJ?=
 =?utf-8?B?U2RBV1VTZzZZWGtLR3Y4cnl1Yy9jb0xaNk5pcXJlc09nZHBId1FtTWZraENL?=
 =?utf-8?B?VGRkajFjVlNMMENaVk9mZHVVajFCNkhEaUZTVTVZWm52VUs1WnhYMzRWNW8r?=
 =?utf-8?B?L3lldjZEelF6cmdIVHhUaWVtcFgyaHFmMEVwd0xpNE9xcHVLN3k0YUw4cklO?=
 =?utf-8?B?RTM2ZE5xTEtmWGxBMFlkVDFUazRvYzYvZlBhZWdGa0VwNGYxQ3ErWEhOMHR4?=
 =?utf-8?B?YkUrZ3ZrWXFzamJtdUFDRUZGcjRvNWhOZWxKNFdTM3U5c3BJUzBOcWRabko5?=
 =?utf-8?B?UmdlaFFnU1RTR25hTlZPcnNvT3Zqa3dEeDdyd21Kd28xRG1BVWNpTjFXUXBB?=
 =?utf-8?B?aFRtOWRVYVUycWVWb1RqcTY5NDk1MXhWVzlxSzZnQVNUbnN0ZUxJQlJIcm9O?=
 =?utf-8?B?eFRQU3B0M3habzY4TTdLeUpjdmdSaW4ycWI2Nm5GNnJ4TWwrZVJuRE1mK1o4?=
 =?utf-8?B?MUhTcEs3NHVIY2w0TEZScHgrMFl0bUptTjhWWE4yTnhDd3BUcVJ4YThFbDlw?=
 =?utf-8?B?Rm80T1VGK2tjTWVhdmxzcTJFQU9CRzIvNnpDdWZid21PUVZiRVN5eFRQd3Fw?=
 =?utf-8?B?bjFpbkFjc1hDMkVhY29YQzZJSVpIL1NEVTMrRlhYOXhTZGpqaHB1YTdkUldN?=
 =?utf-8?B?amQvdnRrYUh3SENpSDd3Z3I5TFVlTW9xa2hiRm1HUTQvYjlDZ2xhYUpJUXJy?=
 =?utf-8?B?QzVzVk00WWpvMXhXV3dFVmJtUXljcmpUa3BmOVM0cGJBSXYrYWlBZFE3TnJX?=
 =?utf-8?B?ZXN4VUJreGFyZm9Xck1Oc0tmUitVVFhOcWhIbTE1TldTYVdNWXJFMXFqZ0c5?=
 =?utf-8?B?YzBHUnFRMm1JS1AwVk5kR2FndUxmWThqMTQxYTBMNlc3anBwTXpXMllOM01L?=
 =?utf-8?B?MmNQRDhDWUk1QnZQWDRjYkRFZjZtdXJISEd4WGFIZGRaUk9OOFhBMms4cjdu?=
 =?utf-8?B?YXh0ZFY0YmhPdytpTS9ickdOMnZ2T2hMWU8zUmtTYmVJSmxFK2JIakM5OU5l?=
 =?utf-8?B?QjJ6Q2FiKyt1aTJieXNCTEZ3L2VkY2gwVVZqRmY0WHpyd3ZFVzFRSTVuNDRT?=
 =?utf-8?B?c3lnQmxXMjJWeElVRmxOREhTT2tIV0F1NlRoU01GenM1R2FUdlQzMzlJSGwr?=
 =?utf-8?B?NGVVTUtYcURnSjhmN0tYVW0rZk1NWW1DQ3JaR08rU2prcjhkZGlLSDBaZFpW?=
 =?utf-8?B?SmdiN1N0VFlZc2s3UXo4OUJqYlVtN0ZQbHBFSUVqUFJMMlpqemlvZ2ZYUi95?=
 =?utf-8?B?dnNHdzBXZUZlNXVId3dEa0ptc0d5QUoyb0F0N3BKMDVGU1JVNHY0WmxUbHM1?=
 =?utf-8?B?eSsrMzlxZm1tejJGZk1lUXpVYk1zeVhZSEhydW95YXpTN3RiZlRjRXJFZ2xS?=
 =?utf-8?B?ZW1YZ3FkRnAyanVJVlRCbmRDaU1JaU4wVktCb3pmdVFCaWFoZysxRlk1bXpG?=
 =?utf-8?B?RGppS1dkNmp5cWxpdzBrenIvQmZ6WU8zemw5RHg4bWVWalRyZnVMaVRIRjFW?=
 =?utf-8?Q?rexmzfCEu4+74ElO0aQU5q71q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4734.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174d2ced-2999-4ab0-87e9-08dd36ad0713
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 04:11:33.2309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rYRkp9D4cyC0zZAnd59SbrkwHA049Aw8+rNDvo/5/Q52HKSYKc0AXCgWBhLGZTu092ium5FTdGg49BI4PkOTeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4782
X-Proofpoint-GUID: P2hz3vIkL6StOwKOVclJnqLUhFhxR04r
X-Proofpoint-ORIG-GUID: P2hz3vIkL6StOwKOVclJnqLUhFhxR04r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_01,2025-01-16_01,2024-11-22_01

SGkgSmFrdWIsIExhcnlzYQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgSmFudWFy
eSAxNywgMjAyNSA1OjU3IEFNDQo+IFRvOiBMYXJ5c2EgWmFyZW1iYSA8bGFyeXNhLnphcmVtYmFA
aW50ZWwuY29tPg0KPiBDYzogU2hpbmFzIFJhc2hlZWQgPHNyYXNoZWVkQG1hcnZlbGwuY29tPjsg
bmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IEhhc2VlYiBHYW5pIDxoZ2FuaUBtYXJ2ZWxsLmNvbT47IFNhdGhlc2ggQiBFZGFyYQ0KPiA8c2Vk
YXJhQG1hcnZlbGwuY29tPjsgVmltbGVzaCBLdW1hciA8dmltbGVzaGtAbWFydmVsbC5jb20+Ow0K
PiB0aGFsbGVyQHJlZGhhdC5jb207IHdpemhhb0ByZWRoYXQuY29tOyBraGVpYkByZWRoYXQuY29t
Ow0KPiBrb25ndXllbkByZWRoYXQuY29tOyBob3Jtc0BrZXJuZWwub3JnOyBlaW5zdGVpbi54dWVA
c3luYXhnLmNvbTsNCj4gVmVlcmFzZW5hcmVkZHkgQnVycnUgPHZidXJydUBtYXJ2ZWxsLmNvbT47
IEFuZHJldyBMdW5uDQo+IDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+OyBEYXZpZCBTLiBNaWxsZXIg
PGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljDQo+IER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5j
b20+OyBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+DQo+IFN1YmplY3Q6IFtFWFRFUk5B
TF0gUmU6IFtQQVRDSCBuZXQgdjggMi80XSBvY3Rlb25fZXA6IHVwZGF0ZSB0eC9yeCBzdGF0cw0K
PiBsb2NhbGx5IGZvciBwZXJzaXN0ZW5jZQ0KPiANCj4gT24gVGh1LCAxNiBKYW4gMjAyNSAxNjoy
NjoxOCArMDEwMCBMYXJ5c2EgWmFyZW1iYSB3cm90ZToNCj4gPiA+ICsJZm9yIChxID0gMDsgcSA8
IG9jdC0+bnVtX2lvcV9zdGF0czsgcSsrKSB7DQo+ID4gPiArCQl0eF9wYWNrZXRzICs9IG9jdC0+
c3RhdHNfaXFbcV0uaW5zdHJfY29tcGxldGVkOw0KPiA+ID4gKwkJdHhfYnl0ZXMgKz0gb2N0LT5z
dGF0c19pcVtxXS5ieXRlc19zZW50Ow0KPiA+ID4gKwkJcnhfcGFja2V0cyArPSBvY3QtPnN0YXRz
X29xW3FdLnBhY2tldHM7DQo+ID4gPiArCQlyeF9ieXRlcyArPSBvY3QtPnN0YXRzX29xW3FdLmJ5
dGVzOw0KPiA+DQo+ID4gQ29ycmVjdCBtZSBpZiBJIGFtIHdyb25nLCBidXQgdGhlIGludGVyZmFj
ZS13aWRlIHN0YXRpc3RpY3Mgc2hvdWxkIG5vdCBjaGFuZ2UNCj4gPiB3aGVuIGNoYW5naW5nIHF1
ZXVlIG51bWJlci4gSW4gc3VjaCBjYXNlIG1heWJlIGl0IHdvdWxkIGJlIGEgZ29vZCBpZGVhDQo+
IHRvDQo+ID4gYWx3YXlzIGl0ZXJhdGUgb3ZlciBhbGwgT0NURVBfTUFYX1FVRVVFUyBxdWV1ZXMg
d2hlbiBjYWxjdWxhdGluZyB0aGUNCj4gc3RhdHMuDQo+IA0KPiBHb29kIGNhdGNoIQ0KDQpUaGUg
cXVldWVzIHdoaWNoIGFyZSBpdGVyYXRlZCBvdmVyIGhlcmUgcmVmZXIgdG8gdGhlIGhhcmR3YXJl
IHF1ZXVlcywgYW5kIGl0IGlzIGluIGZhY3QgaXRlcmF0aW5nIG92ZXIgYWxsIHRoZSBxdWV1ZXMu
DQpDYW4geW91IHBsZWFzZSBjbGFyaWZ5IG1vcmU/DQoNClRoYW5rcw0KDQo+IC0tDQo+IHB3LWJv
dDogY3INCg==

