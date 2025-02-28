Return-Path: <netdev+bounces-170585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E9FA4915C
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 07:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD4F16C85F
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 06:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF611BD9C1;
	Fri, 28 Feb 2025 06:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AmXb5S2p"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC5A23DE;
	Fri, 28 Feb 2025 06:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740723566; cv=fail; b=eOrL1VNYaC+D1F5Jey0jWs06WZi/PwO5kLxv66GaNY/I/x6NhOG7VUqDvfe+8Dw+6TCQwQ8cazyR8mw0kkJOu4zzpWQ+0fv/BXUXRjMtdpqbJVn99/0waMaZIFpzyGWgwXMz+WjtKXd/YdjyhzfJWKZg9QZoAU966SMTz6Cxz7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740723566; c=relaxed/simple;
	bh=LXuNmDrDWkjiGIR3vuiu2X/ubnBOLjosVfZGE4OoC6Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TVn9Fhuy/9nt4MBTB2OLj4wisMugDfvQDPqMIeVZE4Bx0e9UPzSMt1//dma7oemcPOlnk1xdQEjafz9KgSohUJ3Eq8RkXSmeI3x8uiYILJWX0hy2AzgkLdL+7asXE+Wr5F4UtOKZk2IMfrgsKFGjOOc3idhPRyFUQ+m7xEsliTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AmXb5S2p; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byvGKE4QVTXPRUJMfoKlG0ev1QX7tHxcKM1QpsDplo8pPY7hJE4Ybts6OOv63vdwhSkj9ZQv7uIlQ6sNeunKsZP27y6+esgcnK04ao+q762PiscmhDANVIQn5moR3KZ//g7t3UpzRi6It+ewc9YwuaLLa+tYwUfHMuIPsODkfAr/0xvN65kPkFmYTvAtRS/6FbKR7YMFPopdKJ0HdQG4fZlqiolb1Kxn1el4yw5H4v7AnPyrMaMAck650iensMYlEA+xbq2KnKEtIeanSuUL5AKLANLbwpk7qmwLogD9PmUgiOaMbTBAr0MGCmUnS9tEXoXouvwzWmVKuKRTxbXLXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXuNmDrDWkjiGIR3vuiu2X/ubnBOLjosVfZGE4OoC6Y=;
 b=CLXkDERtZpD82UcYoaCH2UysG71QBqDYWC8Dn5Pt4aIZqNtUl1T9jwbztuXt78twu0Q5oE++WsnrLI6v9i7U2GQTukQuKssHUtdBm9WylTSUT9loQu+w6pJnxz9anWmJ4EGa+Tgz5UhumJVz7ey41Wox5BOsu7ccHeX4IUIdHH6PVHMEFsBsOVvHeN7FsK7YT0LxfDpaFKLq8T2MdCYOBXJpfiOj/GyXMIjo47dCW+o5iuE+Vn0v01dC6rGPgU3wZ3IuvEmn0WLyUKFq34S06U7X533zs7dJk5AvzBjB++PHrBktfdGPUKbW0IWFERS12MDYX4aaaYPBvZDoWETzSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXuNmDrDWkjiGIR3vuiu2X/ubnBOLjosVfZGE4OoC6Y=;
 b=AmXb5S2pxyywtWtj15Y2P/FZHGmYql6u/y2eYa5IIgT52qPrh+R1p+UGgSda45+WPs8tNrFY6/opsxM3j5Fpj8BRdTDRBbqP3MevKAKKe4hFCx75NeTHP+dwn4gkTtaM+riGLakYfq1yENQpJ2NFOxu7by9Jzg0kc3mjtUywa64OIGNem0w1KlJvymGSlFbJ5EzGrqaZqizMowGb/6rvGgma5wRqQ04avJZnio+XHindI/79mIUx/ndO0iHB+YINGc1coRshgELvF/NA4sOxzbzp4Izbd65NMznoy2y9QRkBDMuZnVti4tW5vxrZ/ZGJ7BNs/LqgE1u19IqQxkYLSg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SN7PR11MB7417.namprd11.prod.outlook.com (2603:10b6:806:345::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 06:19:18 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 06:19:18 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<thomas.petazzoni@bootlin.com>, <linux-arm-kernel@lists.infradead.org>,
	<christophe.leroy@csgroup.eu>, <herve.codina@bootlin.com>,
	<f.fainelli@gmail.com>, <vladimir.oltean@nxp.com>,
	<kory.maincent@bootlin.com>, <o.rempel@pengutronix.de>, <horms@kernel.org>,
	<romain.gantois@bootlin.com>, <piergiorgio.beruto@gmail.com>,
	<davem@davemloft.net>, <andrew@lunn.ch>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <hkallweit1@gmail.com>
Subject: Re: [PATCH net 0/2] net: ethtool: netlink: Fix notifications for
Thread-Topic: [PATCH net 0/2] net: ethtool: netlink: Fix notifications for
Thread-Index: AQHbiUTtrinD/YnqUkymVdsTdo+6mrNcPtmA
Date: Fri, 28 Feb 2025 06:19:18 +0000
Message-ID: <c6df7040-40d2-46e0-b8f3-a28227d2d98c@microchip.com>
References: <20250227182454.1998236-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20250227182454.1998236-1-maxime.chevallier@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SN7PR11MB7417:EE_
x-ms-office365-filtering-correlation-id: 5d68709a-1fbf-4b8a-167c-08dd57bfd52c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UWRxbHBKNEVNVVphczdDOWVQTElYTjh4ajVCZ3NqTm5XSTdNZHp4Sk93SzEr?=
 =?utf-8?B?bDUzbFRzeTBMSC8vV3FYTG4rNEZVeHlwVkMvb1JVU05pRk5BeldCWDJ5UVV4?=
 =?utf-8?B?ejAwakdEQ3FmcmNwQVcrQUJObnZnVEtYbEs3L2ZmTXB3QjhJbnpZcGNLUjdC?=
 =?utf-8?B?NVZuY3BtY0xYMVB4WStsQkVpd0xOVDhLMERscVZvS1F5bkNxYnhOcUxDdHpZ?=
 =?utf-8?B?UmxZYjI3MWE5VGZvbzYvUW1pSnhwYmRMd3FlR1lLUG10SHBQWE5ESGNIZ09D?=
 =?utf-8?B?WFNuc2pCRCtPc0E1YWozaHl6RUh6SUFEcGJibmpRM0trTFNBKytuaWkxN3dN?=
 =?utf-8?B?L0thMWlxcE5xMzZHUHV1YmFpQXAwK1pZSmM2TE5hK0JCRytjM3NNTm16Z1c4?=
 =?utf-8?B?dnA3ZW1hb2JRVWFSbnNjbCtIcEJ3UE1mMjRiOW83cWhQSlFpVEVmaGwzcEpI?=
 =?utf-8?B?RFRvM3VJU2xhczBENk10SlZCRUdWcmxBU2lrNUFSdjBCSnV4WDBPRWVBVVBS?=
 =?utf-8?B?QUtXV05XZUlLTUZvWXFtdVIySlFLYzBtSHhWNGloeElUcVFsZW1FWjhIRzBr?=
 =?utf-8?B?eDd0TVVHYWhPbktqSTlKcmRoeTlOWkNLbDhEWjFZNE93KzN1YWFUN0J0NEth?=
 =?utf-8?B?VTdFUzhFNjVjajdybkdUMFpsWnNUT1IvZ3NKRWk5UkhIN2JCK29xK1NpcEQz?=
 =?utf-8?B?VkRaK3VFREdwQnR6SHQwZlJIc250djkxb0EwK2xYTnlneDY2UVV1bmJZWWRE?=
 =?utf-8?B?L2tteWRhYlFJTVoxOTdZZUZYQkpxaDNDWWppZ0pQalhjSC9waVBQVDdGK2tl?=
 =?utf-8?B?aHZFdnhPVDZ3cTVDMU1PbnVsNlg5alIvcUFyV3lzOTkvZnJvZ2JNYVRHMFBB?=
 =?utf-8?B?ZGhXWHlTcytLUHpsQ0wxR3c3LzU3Mm0vc1VhZUduWnhyVXNTOTJ6YTNFdlYv?=
 =?utf-8?B?WE5zR2RtbEpjWkpaeS9ySTc4T0d6R2tHVVg3ald2cGZBTDh3cFN5a01OTXMr?=
 =?utf-8?B?VHQ4Wk5JSVJHei9icGppZ2Q3QzNlNCs3YmFRYXEvTnNKS09mano0VXQ2N2lC?=
 =?utf-8?B?b2diTkc1bUw5ZHpwVW1nbU53WGh6NjZmQno2blpXQmYzUGhXLzEvMmtic0oy?=
 =?utf-8?B?NWY0eVN6U3VxWllSSm5oSzREN1YybCtSN0dTMmFsdkNNLzk0aEhibFZVaGtN?=
 =?utf-8?B?SWUwb25ETnZ4QnpJNW9NUlBQQlhoNkw1OUJUNzVicVBleThBYkpZTGdlWmZY?=
 =?utf-8?B?dzEwYVRqMlo4OG55WmpGZ205RmlLOEo4SXdacHlDU0pSdHpLeUl3cVRrcTBy?=
 =?utf-8?B?WWVVVnJQQW81Z0Z0Y3BycUtmR2FCcG1zNFAzK0xoc3pHSjFXK09jYWFJckwr?=
 =?utf-8?B?RFNwYVZTQlUwY05CWmZCQzU4d0hjQkVDVjZzWHJTTjlBU2tVeFg4WVdwMXpo?=
 =?utf-8?B?bjY4a3JKSlFwS0tLMEZhRmluRVFkbmpRV21uZDJtYkp1dzZ5QzFXOWRmZEQ1?=
 =?utf-8?B?NTZOWG1vN1lOR3BTS0l6SUxEZStsd0hOWHpETEZTMzE0ZU9kTnpaN3F3Ry81?=
 =?utf-8?B?dDZoaEswMDJ2OEFWdm8vdEwzQ3YxYjNzdzdYTW9Cc3cyWW9VSW4zREQvQ3lw?=
 =?utf-8?B?V2x6Rm8wWFJuY3RjM1FvcFFRZzBkd1QzZi9sNnNMYTJSZmZzaGFGb1ZWN3pi?=
 =?utf-8?B?Ui85RnlUTzFkejVkKzgwWHNMWDh5QWZraHNlRjNyQWppTHFhMkRnOGtiMGZa?=
 =?utf-8?B?QzdyQlR6WStQRWxURmdLdW5GQldlalVWZ3RQSE1XRkI3ODdRbFFpWXJGRThF?=
 =?utf-8?B?cHN0eGpoVDVFVjZORWxNVkpjVWlUQmVYRVdPV1R0OGMvbkU3OEdkUEVkQXZu?=
 =?utf-8?B?N3N6UHpKTm4ySFVGVmFhbTl0a1JyZlMyK3M1eHNMOUlTeDcySmdlSkNOVm8r?=
 =?utf-8?Q?qrTEHYdnmTDdSdLbpoVhoexcJ6XZdF9a?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WHI0ZnV1R3hkNzJpQ2F6enE3UWF5TlJET3AreExsVk0wTzdJelptdGxYN3Jj?=
 =?utf-8?B?SzVZVytzTEV6NUdxaHBodC90WTVpMzlJN3FBR1ZyamFvMzBBRDhpYnVDMTBi?=
 =?utf-8?B?N1RUVlRLd1lvUlJTVk50MUZCYnhJMC9wcDBJS3l1djJnRlQxL2FHU08xbjZB?=
 =?utf-8?B?eW41bmpGcWZ0RnRkYnEvdEZFdmxmL1dVRGxVSHBhZ2tOb0FaN3NFVmY4dVdh?=
 =?utf-8?B?bnZDS1JNTlF4djMvZm12eWpNV1R6R2piaHJSWjVhai9vZGZOaytCQ1BsRlVG?=
 =?utf-8?B?V2ppUmJ3ak5CcDZkQ1I0TVc0YzhtWWVReklEUHByMGFwMnRBd0tPWTZxYWRW?=
 =?utf-8?B?OVJpUnREYlFqTDlZMlhxSWRtYWF6NFpFcjVZUW5rcTMxMG4yd3EvQjVIVUEy?=
 =?utf-8?B?cURERUx1L0NkbGxQYlQ3TlRpZG8wUFRsb29kclA1QWNua2FLYldqUTVWQ1lY?=
 =?utf-8?B?UkhMWHYxckVSQTNjQWxmeml1elBxMFFxVCtSTHdVdW80WTBiTzZzVHRhd1cx?=
 =?utf-8?B?WlhoZUR3VkNYcXZPeW5GcldtakR5QUdJM3JpZGI0cm9zcnFIMWpSa2lPYmMw?=
 =?utf-8?B?d3ZUMFEvMDdDSy8yZWd0aDUwVFhoaXovcDEwcXVoTElQZEN0UjRWUW9tSmQ4?=
 =?utf-8?B?SGNSczNld1FMVHRFOTRXa0ZSRWNPWDQwcFBiZk4yWlRFRTByOUdhMU9EZnVh?=
 =?utf-8?B?YTgvdVVrYU9PWFFKekhHRXFBMG12YndheTBocnluZWVNUTI0cVg0UWx0TUo2?=
 =?utf-8?B?THZjS0tWcWRjdy9JZm84eVozT2hOQmoyREg2YlZra09JL1pRbkczcW8rTlF4?=
 =?utf-8?B?ZE5ZL0paeW1SRFhHUjJodTdkeThDSnpZOTQyZndsa2JSekpBYmMxeTR4SU9V?=
 =?utf-8?B?a2hLdm1sL2wwSzVKdE93UmxYbHVMLzBDMzcxUTdnODcxeXFEVDVud0d1WFd0?=
 =?utf-8?B?NE04d1BHbGVpNlM5aXZxUUIzTkgzeFU0Uk5obCtwR1d5bU02ODFyaVhIcXpl?=
 =?utf-8?B?K202YTVsWUFmTURidHNQRW41TGh6dFRrRjJyMUZTQUVjMFFLcVVpcmhQaFpN?=
 =?utf-8?B?NzF6VFJvZDF1akt0Z1FUOUFtQW5lY0JhTXp1TENHRXBTVmpCeVJHNlowM0dS?=
 =?utf-8?B?Zlk5ZnlKcWxaNnIvTjBtV1RZc2hGUUUzT1cyQWZ3WFdzQm9SWUo1cTFTNkFk?=
 =?utf-8?B?R0c5Z0dwcytoVlFSWVlwbCtBTWIvTS9DSzRKMmNqZHZoMVJ0MzgyQjc4ZnpX?=
 =?utf-8?B?MDJsdHhIeUFLSWFpMFlIb2pFUkN5OEhac0thRTBEZVp3eDhtZEdrMUdLQVpw?=
 =?utf-8?B?VlRVRmU1SC9hNGs4MkZZcGw4VEN2aTByeGFTSW1uaUhDSUJwYmRUUG16WU55?=
 =?utf-8?B?b0hld0Zod0dCWlVMNGUyL1pkZTRKc1hvZm5yZHh5M1JQajZST2pzRnhXcHFG?=
 =?utf-8?B?cWFJSXJYQ285SWx1NWl3QUMwWkpRQklRcllhaDZiRzdFdVg0TVA1ZVJBNUw2?=
 =?utf-8?B?MURyRjUxSGQ0cENMQVFTYktzREpKTDdnQkdVUFVnVDNqVkZyVU1Cbkd4d1Vh?=
 =?utf-8?B?OUtNY01FajV6NzV0N2o1MnZISkZHRzRVSXVqcVBaa0xqeGh0MnRQYWVjYklo?=
 =?utf-8?B?VzRRTytadG1UU05JNTAwSlBSdkcrSWJGakI4K2VuOWZDd3ZsOUt6Q2xUVkRZ?=
 =?utf-8?B?Mi8rMFRPb1ZKSDl5Q0o1MGZlcWlEREowdmdJblJHQWpvMCsvZzM0YmVwVXho?=
 =?utf-8?B?NTVDYUN2SnlvQ2VvdlRLcnk5cld0NEFULzNiUnV5bXdGbHU1Q2FxRFM0WjZ4?=
 =?utf-8?B?cHZNSnp6cDd1MHFpTGdPLzBUVUdwTmh4M2cremMraExpS3VlTTQ1elRKM3FL?=
 =?utf-8?B?VWhrazZ0QUQwZnRWSUoyYXhWRzFtUFZEV0VNcGU1YzZ6blRiUU5ZU1psWis1?=
 =?utf-8?B?OXpKUjdZYSsxRUlvcldFazB2T2NEZk5FL3lSQW4vTHNIM1VaNGRrOVQwWFUz?=
 =?utf-8?B?MEZCSy9PWE1RZmFvK0dLZTg0aHUxRC9pcHJIczlSemVlZGhZMkMwNTJ3YUpF?=
 =?utf-8?B?cW5TeUptUFV6VjMzNWNIR2Rua3JUaWlQLzNZUkRhdTVoNHhXdEdLSXByWDBX?=
 =?utf-8?B?VHdieFBJRi9JaFl1RTlOVmVYbE90VksyOFVrMVFCMkIyaWsyU090Qk5FMnJp?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44D019C035CAA14A96852BD47D31C6AB@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d68709a-1fbf-4b8a-167c-08dd57bfd52c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 06:19:18.2923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlV7vWkajC8FZYROSNcJ+BjJMK24PF1ph+j1WADHOwOeq4grHVG6uyPoSk0B6HBuSxYIzyIdrKem3PSgwohK6cGx4+G7TySq149h6bTJIocGOFYjDUQvRp/7WSCZGvaf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7417

SGkgTWF4aW1lLA0KDQpJIGRpZCBhIHF1aWNrIHRlc3Qgd2l0aCB5b3VyIHBhdGNoZXMgYW5kIGl0
IHNlZW1zIHdvcmtpbmcgZmluZSB3aXRob3V0IA0Ka2VybmVsIGNyYXNoLg0KDQpCZXN0IHJlZ2Fy
ZHMsDQpQYXJ0aGliYW4gVg0KT24gMjcvMDIvMjUgMTE6NTQgcG0sIE1heGltZSBDaGV2YWxsaWVy
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEl0IGhh
cyBiZWVuIGZvdW5kICh0aGFua3MgdG8gUGFydGhpYmFuKSB0aGF0IHRoZSBQTENBIGV0aHRvb2wg
Y29tbWFuZHMNCj4gd2VyZSBmYWlsaW5nIHNpbmNlIDYuMTIsIGR1ZSB0byB0aGUgcGh5X2xpbmtf
dG9wb2xvZ3kgd29yay4gVGhpcyB3YXMNCj4gdHJhY2VkIGJhY2sgdG8gdGhlIGV0aG5sIG5vdGlm
aWNhdGlvbnMgbWVjaGFuaXNtLCBpbiB3aGljaCBjYWxscyB0bw0KPiBldGhubF9yZXFfZ2V0X3Bo
eWRldigpIGNyYXNoZWQgaW4gdGhlIG5vdGlmaWNhdGlvbiBwYXRoIGZvbGxvd2luZyBhDQo+IC0+
c2V0IHJlcXVlc3QuDQo+IA0KPiBUaGUgdHlwaWNhbCBjYWxsc2l0ZSBmb3IgZXRobmxfcmVxX2dl
dF9waHlkZXYoKSBsb29rcyBsaWtlIDoNCj4gDQo+ICAgICAgcGh5ZGV2ID0gZXRobmxfcmVxX2dl
dF9waHlkZXYocmVxX2Jhc2UsIHRiW0VUSFRPT0xfQV9YWFhfSEVBREVSXSwNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBpbmZvLT5leHRhY2spOw0KPiANCj4gYXMgJ3RiJyBp
cyBOVUxMIGluIHRoZSBub3RpZmljYXRpb24gcGF0aCBmb3IgdGhlIC0+cHJlcGFyZV9kYXRhIGV0
aG5sDQo+IG9wcywgdGhpcyBjYXVzZXMgY3Jhc2hlcy4gVGhlIHNvbHV0aW9uIGZvciB0aGF0IGlz
IHRvIGNoYW5nZSB0aGUNCj4gcHJvdG90eXBlIG9mIGV0aG5sX3JlcV9nZXRfcGh5ZGV2KCkgdG8g
cGVyZm9ybSBjaGVja3MgaW5zaWRlIHRoZSBoZWxwZXINCj4gKHBhdGNoIDEpLg0KPiANCj4gV2hp
bGUgaW52ZXN0aWdhdGluZyB0aGF0LCBJIHJlYWxpc2VkIHRoYXQgdGhlIG5vdGlmaWNhdGlvbiBw
YXRoIGZvciBQSFlzDQo+IGlzIG5vdCBjb3JyZWN0IGFueXdheXMuIEFzIHdlIGRvbid0IGhhdmUg
YSBuZXRsaW5rIHJlcXVlc3QgdG8gcGFyc2UsIHdlDQo+IGNhbid0IGtub3cgZm9yIHN1cmUgd2hp
Y2ggUEhZIHRoZSBub3RpZmljYXRpb24gZXZlbnQgdGFyZ2V0cyBpbiB0aGUgY2FzZQ0KPiBvZiBh
IG5vdGlmaWNhdGlvbiBmb2xsb3dpbmcgYSAtPnNldCByZXF1ZXN0Lg0KPiANCj4gUGF0Y2ggMiBp
bnRyb2R1Y2VzIGEgY29udGV4dCBzdHJ1Y3R1cmUgdGhhdCBpcyB1c2VkIGJldHdlZW4gLT5zZXQN
Cj4gcmVxdWVzdHMgYW5kIHRoZSBmb2xsb3d1cCBub3RpZmljYXRpb24sIHRvIGtlZXAgdHJhY2sg
b2YgdGhlIFBIWSB0aGF0DQo+IHRoZSBvcmlnaW5hbCByZXF1ZXN0IHRhcmdldGVkIGZvciB0aGUg
bm90aWZpY2F0aW9uLg0KPiANCj4gVGhhbmtzIFBhcnRoaWJhbiBmb3IgdGhlIHJlcG9ydCAobm90
IG9uIG5ldGRldkAgdGhvdWdoKS4NCj4gDQo+IE1heGltZQ0KPiANCj4gTWF4aW1lIENoZXZhbGxp
ZXIgKDIpOg0KPiAgICBuZXQ6IGV0aHRvb2w6IG5ldGxpbms6IEFsbG93IE5VTEwgbmxhdHRycyB3
aGVuIGdldHRpbmcgYSBwaHlfZGV2aWNlDQo+ICAgIG5ldDogZXRodG9vbDogbmV0bGluazogUGFz
cyBhIGNvbnRleHQgZm9yIGRlZmF1bHQgZXRobmwgbm90aWZpY2F0aW9ucw0KPiANCj4gICBuZXQv
ZXRodG9vbC9jYWJsZXRlc3QuYyB8ICA4ICsrKystLS0tDQo+ICAgbmV0L2V0aHRvb2wvbGlua3N0
YXRlLmMgfCAgMiArLQ0KPiAgIG5ldC9ldGh0b29sL25ldGxpbmsuYyAgIHwgMjEgKysrKysrKysr
KysrKysrKystLS0tDQo+ICAgbmV0L2V0aHRvb2wvbmV0bGluay5oICAgfCAgNSArKystLQ0KPiAg
IG5ldC9ldGh0b29sL3BoeS5jICAgICAgIHwgIDIgKy0NCj4gICBuZXQvZXRodG9vbC9wbGNhLmMg
ICAgICB8ICA2ICsrKy0tLQ0KPiAgIG5ldC9ldGh0b29sL3BzZS1wZC5jICAgIHwgIDQgKystLQ0K
PiAgIG5ldC9ldGh0b29sL3N0YXRzLmMgICAgIHwgIDIgKy0NCj4gICBuZXQvZXRodG9vbC9zdHJz
ZXQuYyAgICB8ICAyICstDQo+ICAgOSBmaWxlcyBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspLCAx
OSBkZWxldGlvbnMoLSkNCj4gDQo+IC0tDQo+IDIuNDguMQ0KPiANCg0K

