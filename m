Return-Path: <netdev+bounces-188541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 108EBAAD44A
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 05:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81CEB4A556C
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 03:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B482A1C9EB1;
	Wed,  7 May 2025 03:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UOJZXCym"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D5D170826;
	Wed,  7 May 2025 03:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746590363; cv=fail; b=HzH5zlP9P9Hk6Cxx8f/wCf/nwNT32yzg0+29SNyO7VMgChr0/UMH6wbL9Iv9uYPECoOJ1LmEN5O9SJPkBOmfitejCAHnSCZbjLDJCKrN7GsNX49Hdo1DgiR9BMLNl1toLNVImjsU4fasYIMZg7cfyEoiU2V4lbQTxbKW6203aew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746590363; c=relaxed/simple;
	bh=8MAxptTI14rFW5Jy3JKSJolBwo7p5VKPFfXE2fThzg4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tJBz4Up/DkyuHUDS5AlwyfoINegckZF/3g6QAOsvbzG1Mn96cQiK7L3n2StDtLX0gf9DIo/8lxD/bs8R0ywFwmksJpRWIwtSoW9CyoJAAG/cXjadahax2OV6Tf6LHOEB66MUAy64ymHyOg9Y4ucYiTjtoXAhDz2K/LHD9R1E+ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UOJZXCym; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ztf7adQWLGVHZ1wGZD4WvMst/xtuVBZfvkvQt7tDc39sL2Jnp+PsgO56QzMsEmHqAx5dG6GTHnZgiNIGpnIhWWMixmNxoN0lL/JocvR3a0KPqpwFpQGVadSIBTsAJT0IQMBPwR0Lk+Ye2BL430ANT4hnTEjfYe8VOhQGSqldM/2sGzvieznrAmFWPuutODVSjFOMUGGsn73GBAjTnfApNezUS8N7jCYIirWFaGGuhV9HrFq9K54/ZDzuH3zgKNViWnkmgItwReouo2DJBAqOl73bFnfJ7fe1VYyxAnAARmmmo7eA1oLekXKOHdEtLJvg9trHw2LXzDdIaqdopDEvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MAxptTI14rFW5Jy3JKSJolBwo7p5VKPFfXE2fThzg4=;
 b=iNeV6v4NCb9H5je+hOLp5/vyq9qUAijNt7CsWDkp9Lq0U7uWYhpmcojRO9Ibc/gHWlFcH7GX0eheZYQyiFO8kLceXnuesksf5gHnrfD84wR5mP/0o0cT7ehW0fVmLe8wMBI+X2St0Z9z8XkTuXZmwFnlCsPFT2KgG8QqePU+XIZrKOAGDdYSymDfhCQQWCYfv/UWxWH61gK7gJfoPublz0RuAKC83g7V2gbG5uzmdJQEwDjxLhz1jb+vyIHJoy4YF39oUknD1HipAtIO46Iror0KUPaJfw9sHSbNtHKgVrGULiSfaVFtlHhD66Qqw62Ti6uc+YHK8ccSvVcOrbnn2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MAxptTI14rFW5Jy3JKSJolBwo7p5VKPFfXE2fThzg4=;
 b=UOJZXCym67Di7zUM8O7j75uGL63BBXsj9hqz7YXfAx65NrR3Lhd56xxJWK8ts1AI7xTxyf4D3bctZ8BrGIbd0bf+8ToYSkRuP1xL3V2KHSStT3/FjO1C4ReS+jiichJVEY1lf4rx8PioXD+HVF8IqOJ1Zw/6tbyvWjYtyHwBHUXZ4cNWNwqaWGbLdp1At2yH6wunWsSI1tmluaqRcffrqvMknwZLAzxcPkFzsbv+166L8z8IgJD80kDPP4+yZyTCXAQEyz+JRrNKdSZ03xVmiNWeKVghuGMipk6N7+/zI2gONtcitrD7dh2k9XkQDqtAGGyfQLfkxBiRg7Wed+h5gw==
Received: from DM6PR11MB3209.namprd11.prod.outlook.com (2603:10b6:5:55::29) by
 DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 03:59:15 +0000
Received: from DM6PR11MB3209.namprd11.prod.outlook.com
 ([fe80::18d6:e93a:24e4:7924]) by DM6PR11MB3209.namprd11.prod.outlook.com
 ([fe80::18d6:e93a:24e4:7924%3]) with mapi id 15.20.8699.012; Wed, 7 May 2025
 03:59:15 +0000
From: <Thangaraj.S@microchip.com>
To: <andrew+netdev@lunn.ch>, <rmk+kernel@armlinux.org.uk>,
	<davem@davemloft.net>, <Rengarajan.S@microchip.com>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <kuba@kernel.org>
CC: <phil@raspberrypi.org>, <kernel@pengutronix.de>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v8 4/7] net: usb: lan78xx: move LED DT
 configuration to helper
Thread-Topic: [PATCH net-next v8 4/7] net: usb: lan78xx: move LED DT
 configuration to helper
Thread-Index: AQHbvZneMxjC/QRS8UasajxZOMdIXLPGjIkA
Date: Wed, 7 May 2025 03:59:15 +0000
Message-ID: <3b28a0dce9c56a1ddf8ed91863d7d16a0732cb10.camel@microchip.com>
References: <20250505084341.824165-1-o.rempel@pengutronix.de>
	 <20250505084341.824165-5-o.rempel@pengutronix.de>
In-Reply-To: <20250505084341.824165-5-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3209:EE_|DS4PPF0BAC23327:EE_
x-ms-office365-filtering-correlation-id: 01c8fb46-ee82-4927-4770-08dd8d1b8894
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?KzZiMDh1Q2FuYlpzWlRwN1hOSGRJdE15YzBGUjN2Smx0OHpMZWRpRzFXeXpa?=
 =?utf-8?B?NkZaNDdTTWRoMEdoYUVjcEdBanUxNnFFb1lGNy9QbE1CeHFxaUVxT0NTMEsy?=
 =?utf-8?B?a1VWR0NCZERPTE10bktlVnYyS1QvaHJ6eVZ5ZEtsWXlTc3FkTWJiclJvWHJs?=
 =?utf-8?B?MGtoWmNwc0tVK2xHVE1LamtHL3RuMUJRMWdQZkZMbVZQSzZpLytBaXhBYlRD?=
 =?utf-8?B?cjJaVndwWWZ4RTczNDFZWkRSNXVsSi85bkdtMkM5VEY2VjhXVmlQOUFNbnho?=
 =?utf-8?B?V29BamZGQWRlZi9iRmRvZk52N2dQT0lmZmx3WWpsSzk0YW40S3E1clU0T3Mz?=
 =?utf-8?B?UjdidDZXaUtXZEVFVHdyRHBIc0tlMzZyaytlNkhudHhSenZPRjE3SkZFRXB3?=
 =?utf-8?B?Y0k5QkozbGUxUndKL2ZBbEdFRDIvdTJtcklWVWJUbllLdzFDalFuYlBiTGlo?=
 =?utf-8?B?Q3hKVmRyeS96UVJSQVRXcWpjRlQrdW9MTnMwT0tVeDIyZHJLVnpNc2tidXc1?=
 =?utf-8?B?Nk1BMFV5NHh5NVIyWTc3ZEtwWkliVjkwSVJSRkk4djhiWUZhbEpXZVp6aENh?=
 =?utf-8?B?SkFFUmdzaUw2TjZKNGh4UDI4L3RhdTJ0TVM5aE52akd3My9ScWhOd09sSDV6?=
 =?utf-8?B?NUdCaWJERWtnYlFlNE9YM2RPeERjNVA0cmZBNzh6Uk00T3lXbHA3RjVlMVNy?=
 =?utf-8?B?Q1FDMkFEclovZTJaU3RmYmpFV1FTQnY4VERBclBTL3p0M2JKMnNMcFplYVp2?=
 =?utf-8?B?bldoZk9wYXZQdDBsRzhidWQyMEVXZTdHNVd5dTVzS2ZrMkcvNzk1Rnl3bGF4?=
 =?utf-8?B?QXFyS1g5ZlVKNWtRWEVrd3hseVE0bEFic1g1SXRHNzIyNzZja0dPWlNneGx5?=
 =?utf-8?B?WTJRaTA2Nk5EME00K2pKLzBLWWNvUGp0VExDbGpPdWU1RzBNR1llSHdIcjZt?=
 =?utf-8?B?K1Z6ZlJ2U1dPMW94YmRZNWZGSGY0N1RJVjVBMXdmbzh4R2hhTUREVUo1T1lq?=
 =?utf-8?B?MEFQRHVkclhzMEM0ZlBXTjVTanJrdzVxVzVQRXg3dkZsVXNoc1dGbURLU29N?=
 =?utf-8?B?N1BESGdTZ2x2M2RwUDByNExxR1RHdXROb1orcmpRL0NkUnlzTjJlVEUyK3Jo?=
 =?utf-8?B?VXFGa3JaSjhRdW02MTZYRGNRL3cwLzg2cVF6cXNCZk81OTZSdGRaMTRBajkx?=
 =?utf-8?B?aCtTeVJPQ1pxcXFvUUhvejdDWUJpRHlsZVlOWGkzV3RTdXlBWm9IVkVqOGV6?=
 =?utf-8?B?eUZIbUh1UUhhRE9wMWNrM3EwWVVIY04vUGRzUFIrVDZIdEdKOUI0bDB6dmYv?=
 =?utf-8?B?YkNLQjZOamRQbXpXR3BiYlh3SDNhV1dKMnlJdlJOS2JFdE53Njc3aHArRm9B?=
 =?utf-8?B?UFVEMXoySHlvQ1FTRUgrYjJGNzZNYXdCT3hwZHFkRzJDdnFzZCtTUjNrcTZx?=
 =?utf-8?B?aHk0Y0ZuUytDT3B5cURJQVFiMjJrb1lrRG8yQjA0NmJ4VzlOR2NWQlVEVklk?=
 =?utf-8?B?eTFvYXhIY2xaMnNXb3NhN2hBaVRhSHMzU2RmMnhyaGhtY2krWEM4d3p1YWpi?=
 =?utf-8?B?RDQyY2VrMHNPVVJ5S0NsNGJlSm1ibEVyVitzSm4zM1pJdzcwUEZEMGF3WWhv?=
 =?utf-8?B?M0tYbGVxM0pRbVNqVUo4L24vUFhVZDFVaTY4eTUzQm80eS9RYmFRakhFSjVG?=
 =?utf-8?B?R3dLY3Q2VHZzN1I0dUlMbHVHQzlGd2IvWkNiVlBZYTk1akFvZUYxT24xdm9C?=
 =?utf-8?B?ZWNvVkdtSmgwbTJLcXBRNGJLV2szbGo3WmJZNEVVUi9kckRkZUt5RUx3R3ND?=
 =?utf-8?B?K0FLSWh5ODViYldxY0JQVEtycXRyblQ3T3NTZ2plajMyM1kvNjVOOVFsMGV6?=
 =?utf-8?B?aGZuRzMvSU9xVjQ0MU9zVWFqbDBDV0ZvcEFycm9aUU9NWkplbzh1ZHFLYmRM?=
 =?utf-8?B?cnhhOGJ3ZmgycWlJaU1wdC8wbGs4TTc2SmVKV1JMU3BQUjNmdm1oalFia0x0?=
 =?utf-8?B?T0tvb1ZyU2JRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3209.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?clpWVHU4UEFpVXBiSmtObHlCdTBsckJlSDlCZ1g0RmNBTldSTmszdWpvZ0hR?=
 =?utf-8?B?NlVDeHJwMmRSWG1kMmdzeXlqUmRhRUE2ckI5V2d3N3I2ME53SHZ6YnlKR2NE?=
 =?utf-8?B?QnVTR09tM2FnVlBpVzU3OE4xdlQvL1RnVEFsbjZscXgzRHIvVFZDWXBsaDlz?=
 =?utf-8?B?TkN5MmZ1T3VxUkNLNXhJWG5nVFBucCs3WnpTSzdwYS8rU05aTUV4bVovMHcx?=
 =?utf-8?B?MVVueEtjMlg4a0F2ZkZqQmRscCszNFU1SGVKczM4ZlFDbENHSWtMWTBFeGFB?=
 =?utf-8?B?c1YwNFJCbk01R1dNa1lFS2hnUEhZd0VBUDJtM2ZsY1U2ZmtKL3A3eHBrUmxB?=
 =?utf-8?B?dFlLUWFyS2xOeC93elVjSXE4c1gyT3owSEMxbEEvdG94NTdhNytPNWttNWha?=
 =?utf-8?B?b0REMSsxOHJueDd5cU1ncU91aTZPd3MxNkwyanVuRm04THNvOEUxb2Y4ZVhW?=
 =?utf-8?B?d25XSWgwOUFYZENqdXdoOUwwaGlLVkFvZ1JubEwwWWdQOVV2OWRqbkxuSnRU?=
 =?utf-8?B?VnBsTDFkY3pZWEtrSWc2K0M0YXNzUXQ4aUIzZ1l0Qm5zMjdnTjc3cHo3VXVE?=
 =?utf-8?B?MFpCNVdPVy9ZWkZoeTd3Sk9jUjM4NmZ0VUdVZUR4aW5sWmpFNGNuc2d4Y1NF?=
 =?utf-8?B?ZG5jaFRvb0phc3JuMllSOFk1dk9lODhkeXI5WlU1VDcrNXpxY0xodzVtVlQ1?=
 =?utf-8?B?WlZxUThMMkxNNU9rd1BIVFV0SkdONXpHQS9GQlNlMG9RTmhmc3hwSzlmQWxX?=
 =?utf-8?B?a1NESGZzOFZjeEZHbUYxTzZyd2VtZzlzSkdlRW91QVlWZUM4dGxpN3NFekF0?=
 =?utf-8?B?RncwRmx3aTQ3R3lLQjRIczVySmlnY0JuV1IvVkpCMU10L2Z5N2F0a2NJODcx?=
 =?utf-8?B?V09ET3hyVTh5SjFIamRYQi80SFE0aW4wd2trSjdoTzRhMU1FMzBnZVo1dFBX?=
 =?utf-8?B?V2hSU2JDMmQ3NHJPUURQU0FLc1I5ZGdPek5tV0pPZng1OEFCemQ2dzlUaHlj?=
 =?utf-8?B?NzRqMTNTR0JST25NYks5NGN6SmlIaHBCZ1AxUE1BSEtiOWQ5NWRNVW95aXV4?=
 =?utf-8?B?dXpKYks5OS9OWFVRVlVWbWhDYkRoc3YzeThYWmtVOFNVT3YwNGJjaW1Nc2hP?=
 =?utf-8?B?cTUzM25NVWdqalprN2VNTVAxTE9uN3pNc3pKUTllZ09iMUtqL0FlbjFHM3J6?=
 =?utf-8?B?bVNWWHI2ZEYvNzZPRXZnb2hKYTR2V2piWWFNaXBReFBJNnNrOG9VMWxiczhN?=
 =?utf-8?B?TTRWVFdyRzBoNzFOckhkSXI0cEwvRHdJalZsNFVKRURaeFhueVhCWTJWMm5r?=
 =?utf-8?B?ZGpYTHJyaisxeVlwYnFwY3lzazlUZFJMamg1a2plWUt4Z0dkLzQ1LzlZNjJL?=
 =?utf-8?B?bHYzN2tFYmVySGYxd2I0UTJjTlo2bmZxaG9mNlB1VmJFK1I0TEg0ZFVCSHpT?=
 =?utf-8?B?S0ZMaXZTY24vYUp6eHNubUswamc4SG5HNzV6K0I3R3hlbEJ3Q2luOUI2Y05x?=
 =?utf-8?B?b2dQbnErQlRqQTVPUE5Ib1FsM0NxdWVyRFNSRlBwSGlGSDZ1eExaTHQyQ2Mz?=
 =?utf-8?B?Z253dVh3N0FONDVvK2xzaEtaa1JaYnpNeE5UUWxreHFmdlMxakM5aTBBQ0I0?=
 =?utf-8?B?QjRPMjFRQmhqZEt4U0xUclowMFVZRnpCOWZPVGtub09RdjBvQ29NMUwrV3pR?=
 =?utf-8?B?RWl5eXRxM05PeWZWTDE3WFlkSy9pUDlYaGxZekpEeWFSZ2dRQmVPa1NrZEMy?=
 =?utf-8?B?WStXRXVDTHBNU0xUWmhja1c4dExhcUw1UjJucU5yd0hWOTdnQm5maStUWS9C?=
 =?utf-8?B?alBLSERXUGJZS1BmdElCTGx6R2g1NFRaYU91bFlEV29SRmdBb0tPR21LMy80?=
 =?utf-8?B?RGNQRktLYVROeUV4K3R3UjVZNnROc0JRaXB1N2pMOVNGOThMVEREdWhZVW1o?=
 =?utf-8?B?L0xpS3ZzVFlhNTJVdTI0MHd2S014RHpGTkdIVFh1aytOR3hJbFN6bExkNEpG?=
 =?utf-8?B?YldLNkFTYmxQOTErb1F6a3oyUUlKVzNleG5DUjIvS0VYc1VhV3A3STN1cEx0?=
 =?utf-8?B?UWlINU9rNU5jUmM0MkV5dUhYWFBudTc3TTVSb3k3aGt0bWxBZXBGck1MZmVL?=
 =?utf-8?B?OG9CTVVxMWY2QWRjOHBicFc4TkRMTkFHaUI4RlMveHZ4MkhJRkNGQVk4TGZD?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BAD4DB3D2B18C478EF04A3A522447E1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3209.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c8fb46-ee82-4927-4770-08dd8d1b8894
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 03:59:15.1499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S57WknRPh55hople4c/faOGAVk5r/uMXlscFQnRSwANV3cEWoywxCSiCXS4Drlk+8Xa0wEeg8xDPpiLskiEAyq+1j9Q6fl5QRD9Bfl4jblw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF0BAC23327

T24gTW9uLCAyMDI1LTA1LTA1IGF0IDEwOjQzICswMjAwLCBPbGVrc2lqIFJlbXBlbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBFeHRyYWN0IHRo
ZSBMRUQgZW5hYmxlIGxvZ2ljIGJhc2VkIG9uIHRoZSAibWljcm9jaGlwLGxlZC1tb2RlcyINCj4g
cHJvcGVydHkgaW50byBhIG5ldyBoZWxwZXIgZnVuY3Rpb24gbGFuNzh4eF9jb25maWd1cmVfbGVk
c19mcm9tX2R0KCkuDQo+IA0KPiBUaGlzIHNpbXBsaWZpZXMgbGFuNzh4eF9waHlfaW5pdCgpIGFu
ZCBpbXByb3ZlcyBtb2R1bGFyaXR5Lg0KPiBObyBmdW5jdGlvbmFsIGNoYW5nZXMgaW50ZW5kZWQu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBPbGVrc2lqIFJlbXBlbCA8by5yZW1wZWxAcGVuZ3V0cm9u
aXguZGU+DQo+IA0KUmV2aWV3ZWQtYnk6IFRoYW5nYXJhaiBTYW15bmF0aGFuIDx0aGFuZ2FyYWou
c0BtaWNyb2NoaXAuY29tPg0K

