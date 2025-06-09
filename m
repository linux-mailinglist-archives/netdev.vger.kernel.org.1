Return-Path: <netdev+bounces-195667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF059AD1C23
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 13:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A523A3DFA
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 11:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E3C25229C;
	Mon,  9 Jun 2025 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NJwoJYBG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03CE747F;
	Mon,  9 Jun 2025 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749467040; cv=fail; b=ZMNbvtTIoPIF0HJV6GyXToHXjioDg3dZm1VdyDKTpJH+RF6e9r0PzHuWVGSo3nASo7QFlXVjG1InFzVh8hWYC8MpnKa9G6uTN05GlZFeg9jVKNnawMbVnrt+GkTjtelBUKvUYLcXxfVw4BysicHw6lJjfCl0W6vpZJ3fhldB2Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749467040; c=relaxed/simple;
	bh=o5NmmEhG7y2kqMTI8v2ad0enGnJjzlfGlfRK0iG2N7k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dSnM5FQsCq7WuQee+H0at0w4vOWeyEYRVkAtamTl3Bsgq84TfhPD+WvvC48CmWQcvq787Hkyn3bEiIrM6hML0YP+wjhavHJYvDngJWFE6LY3IlgaRA28+uViYbTQhI5RhflUL0pYtMVec7vLLHvrGafPQvfYMuNkXVPLwXmAHyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NJwoJYBG; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLmDh87wgm+CkJa2FI+GtotEd9XuKhN04SlOxzH0HhA1nzv34gLuVagPYfbcCdeKi7G9PfMB1sKAJ1qH0L6TlAFtzm/ESUBBiuN0hbLGrYTVRYyq8Wp0OiEp8gBzhZiM8gbFKjt7b3lIbmRUO0ssfzB5YDz1RyBOt+hPFQpGsLrGhHa5ZN0GoFEh4EouryqnUK7uGgsfXMygQBn4PnuXbRVd37+vblR5xjKgJlLe93VTK5yYo7+VB70Ml/wN2erFmlqJdV/nB9BmUIlcwS2DnehkDVxVJaqTw0pXicMrLvO1FXuTaQ7BinLDyB+yO8+FCHgbKykckPzZZzrvDbGj5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eH7H0oJ2f0YCJe+GUM7R+XzSTkhbkrGNNdELtPVnjw=;
 b=TFx7Z7j0Wa05MHWEfNKR85t7Daq5oqhl7fBVfmFOULiHbgCDls6nlXK+DyaTzjGdVxaFkLvO6K9cwm5eCr1J6+VoWcWO4M7u2FqOH5GyNsOfb267pJtrwUzpQ0laqtHRdSVaiTLOXvnEbLi33PC9IHkRrYws+IlSslOxiDktRKhYxfY6Bvj2aa55Ru6stlIkuRK22jdDyCLPa8ltCZDMJRqseUbphZ0ofjN5xfbM6/4Wv7843XGVLfCEo6BMlgU50HHlsT/eNbOh9rtvNP2ewyngSjTHY+izYukxn6nZtoj3UN18hxYryUVjuWb43dqWnQQhSMk/UmecenySz0e5Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eH7H0oJ2f0YCJe+GUM7R+XzSTkhbkrGNNdELtPVnjw=;
 b=NJwoJYBGNG8sljUKUSOpipLXniEvh7eJ8nhCux+otIfmYEMXVcvuoFj/ZkvBVHsKw137NQedwslUH8rjLA1XBdmTeLod/8T0WFuufBf/A7Dxm/ZjcDckyF7yNST/wc/rPrCFzDe1+GxJjqusae1J5Wf79FsmQJD47VBT8kDst6Q0D4Rngv3nc18wUgXfQFVTsBO0K3L9QtHf4tHEc948hzaPVvEYsbOPTSrXStL+ttCgKvifsoEcInKPNNLnEpYzwQf4er0a5CRieS525MWiwN2APiX1dVSMTEBKCZeyW9VGveSdWi5Ftqr3K0pq7JXm357IDUnb2lV88LLmpcEjhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by SA1PR12MB6946.namprd12.prod.outlook.com (2603:10b6:806:24d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Mon, 9 Jun
 2025 11:03:54 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8792.034; Mon, 9 Jun 2025
 11:03:54 +0000
Message-ID: <f5fb49b6-1007-4879-956d-cead2b0f1c86@nvidia.com>
Date: Mon, 9 Jun 2025 14:03:46 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 00/13] Add support for PSE budget evaluation
 strategy
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Donald Hunter <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250524-feature_poe_port_prio-v12-0-d65fd61df7a7@bootlin.com>
 <8b3cdc35-8bcc-41f6-84ec-aee50638b929@redhat.com>
 <71dc12de-410d-4c69-84c5-26c1a5b3fa6e@nvidia.com>
 <20250609103622.7e7e471d@kmaincent-XPS-13-7390>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250609103622.7e7e471d@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0013.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::20) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|SA1PR12MB6946:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a15437d-1f52-410d-2201-08dda74552f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzU0b0JsUlc3b0FjRnVwRkNqWHRNdUZRN2tJS2QxY2dqZXZ4K2krOTdyVWZx?=
 =?utf-8?B?SVdsajF4Z1VweGFBbGxYS2crNldpblFPRVBWTU51NVltbHRoMVNxd2IrMzdU?=
 =?utf-8?B?bDdpdVRGNk8zbFJTdGIvaEliNlN1NUVGaU5KbnFSWWFUV1pkTW4wVTJ3VjFR?=
 =?utf-8?B?Zno5K1o2RkVjanJ2WUxIdHM2RVR5YW5wWmFqajdkcGo4cGJ6Tm1DRU5sUWpk?=
 =?utf-8?B?Y2dkUXhtYm1ISDllRHRaR2JFczVXcTRVRzcwTFp2QjY0bmxCbFpvTzdDb0Ny?=
 =?utf-8?B?dTRkNFBGazhJd2FkenV4ZkxHbVRBVUJxcG5WdE5adnFsQUYyamdUWFB3cXJa?=
 =?utf-8?B?VXFhQjZqTk5mQWRBRVphM0QxMUw5RVo0ZjRPVndvWENlbEZtenVWY2NnNlRi?=
 =?utf-8?B?TE5TV0MxMEE3ejBBK2FEUERWNzdISjJqVVgvV1Rmekkvb1VSbE1zdmlITWg1?=
 =?utf-8?B?RU1sZlk1aFJUb0crVnV0V3BLZ1Rxbjd2aGx2RnlEVUhxQWN4ZDBrU0tVZHN2?=
 =?utf-8?B?YTllMnFWUnc0SURlVDVaWC8wc2o2N0Y0V2lLcjVFUkIrZ005THEvWDUzd1Jt?=
 =?utf-8?B?L2ZaaU83cWNMMThLM0l1VmV2dnhCcW1Hemg3TFhQOU1EL0ZIY3VoN1FpQm5k?=
 =?utf-8?B?V0VqRkRaTWswWXZ0Qjd2dTNsZ25FV01BVS94YW45SlAxY21XYUVudytnNEUr?=
 =?utf-8?B?VVc4cUdXZitKQnVZYVhkLzN4bDdPNkkvbDlJTjNZOTFEaTJxZ2hXTjB0WHlp?=
 =?utf-8?B?cTlwVklaaFhteTBTOWRBMDlhR1VnUlFiVVBMeVhDTENNeE5PVkhnQ1VseWFI?=
 =?utf-8?B?cHh5bmZ0TDErMWlqYTB0Mkc3a2hlNGdBdUxxU3BhU2dwTFA2MHNJYWMzeXVz?=
 =?utf-8?B?ckluOFNTSS93MUhsRktKdnhCZGo3SURpdUVZRGtrRC82T1kwM0IyVUdveVA2?=
 =?utf-8?B?ZGF6R0Q0N3phRERIUzh5dzFjL1BXTjdZRGhmN292R3B0a09XMFlXSTFWQi84?=
 =?utf-8?B?ZmhIdUltczE2Rm9mdDFRbjl5U1FINE9wU2pOMGRXMS9mbDBCRzV1UDFZNk5z?=
 =?utf-8?B?ZXlTelRjSndvZ2g3SHlIWXMxanNTbHFRcDNDRDNRNzVqOE9hTThUaDRMcW9R?=
 =?utf-8?B?R2V1VGJDaWZpUUovc3I0c0xhWGxIQ1lpV1Y5aXE0MENkQXRmek9udjd2Q2dX?=
 =?utf-8?B?ajZkbmNKdTZWR1JWMEQ0dW9HQ2Y4U0IwM1hQQW9SRkFlOHEvS0dlSEVtbElJ?=
 =?utf-8?B?RHduRmxzZythNTVvOWpIbnlnR1F3aEdOaDU1Q21uQWdyd2I5K1MxSEZDTGR5?=
 =?utf-8?B?WXUvbFFpTFRER0o1ZlZodFJJRmRwWlh3dExVc2p4M1lyaFJKbmJIZHhvck5D?=
 =?utf-8?B?dUFrRTA1bnJjUGJvTzM5Yk9lUTNtRS9udEFVT1F2My94Sjd6Vzk2ZUp2MVVQ?=
 =?utf-8?B?NFFxbkJtblBJemxJdzBZYWZhUlBNYmc4YzR0SCtRdnQ4V3RtWVB0OFhhTFVP?=
 =?utf-8?B?SVo4dzdmRjhjbVJyMzBoT2RmUTVLNlE4UXF2Z0Myb2NFRTY3MGhZY0tWVjNR?=
 =?utf-8?B?cktFcDRYUUE0dmVEcnZ2dUt2OHhwdURQYkxIb3Q0bHVMTjZvVW1GV0JLdVpH?=
 =?utf-8?B?TUc3bzByZWQ0Nm1ER29tRitNajR3N1hEZkFnQXNYejZaci9ad1A2ZUg2dEor?=
 =?utf-8?B?bFJPeEFoaWszbVMyejJkdFhGT3U0eDFvbjFIb0ZRL2pBYXptZzVnckJ5WThy?=
 =?utf-8?B?WnFZK042enVDdVlJUlU5NkRPVWYwdzMxaFBCTGlDU2t5T1AvdFNPQWVXZTZ0?=
 =?utf-8?B?NjVnWDFaSnc2MVNnSTVHV0ZHZUNJQjVPOURjekdYSlBwa3M3VEFUSjRTenNw?=
 =?utf-8?B?ZE4rSElZL1RDQ3NlWmY1aFhSVDFTNlNnZVZ6RE9kcXdHcXlCNUhQT1U2Wmdp?=
 =?utf-8?Q?sSnQrRDSsag=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blNIUE52aWs2eWpqeVdHQ2U1RTA2QjdOQ1laa1pGNmtjdlhiZFN4K1lBeFVW?=
 =?utf-8?B?aGtEZ243U1VZWm9YTFN0N3NEY2d3S1dlRDRMNGNnbWFxVWtabk5tRXpnNFI2?=
 =?utf-8?B?OXpRTGE4T2FnbDdGSk1NeGwxZTBKNVJ1TnIxWXl4QXVvWThBYmZmd2F0MTBP?=
 =?utf-8?B?T3ZvN3JCcEcxZi8reDRYVnBaYUJ1MFY2Y2V1WStEMG5LT0V0N3VPRnNUdXU1?=
 =?utf-8?B?a3kwTk1OV1I3bVh3NnIvTkppZEZNbHoydS8rQ3JFeC9aRmVaTWJlUVpnaUgw?=
 =?utf-8?B?ZW1SYTVHZXQ4NWZCQWhvVE9xOVlaUCszS2Y4YzVzRVFJMnBkSmFDRFdzUXpY?=
 =?utf-8?B?VTZEUXp4VlpOS1BFWis5Qm9hOUxvQ2V3WnVwbE9lVlIwMlpWN2NWVkpaNXp2?=
 =?utf-8?B?aHhHeTVXV3IrRnVzMHhWTlBqWHlOV2orbDVYdnRGdHJ2UUF6OHorQzdyYnJH?=
 =?utf-8?B?aDRxKzRSU3lKMWswd0lXZkErUXgrNWt4SDNOUkwrVXhLc3gyVnl2ZzVNZEt6?=
 =?utf-8?B?VHJHVWJJcC9NSlRvV3QvSVplMDFYQlRXNzJ4V3JWd3JIL3ZuQUxnM3U1OVdq?=
 =?utf-8?B?c1VCRUhZYzVhR1I4bk5UQXdEVEV0SHY0dlVBaUc1Wlh4a29EUFg5dVd5aXZs?=
 =?utf-8?B?RCtpR3lNcGV4bXVmb3NxalI0N09UN0g3T1RFY1RxcDJOcTVyMW5YUkJCRVR5?=
 =?utf-8?B?ZjYrcXNvTzVGU1N3WlA1N2dvSE9hQW8wYzhyV3QwckYzcG9sMm1NME1BMnAv?=
 =?utf-8?B?Q3NmWEhjZ2NkT2tEY3dqN3RZRS9sSEtvZ2FvUnl0VXBaZkV5UEd6RTU3aEd4?=
 =?utf-8?B?LzRZbi9OTXpEa2h6SHR4TlZJNWk0blphSTBYWGhzeHNQUkxqeVNxd0h5ZXJn?=
 =?utf-8?B?RUxhdEZQeTZ0bklGWENQcmN3Wmx6a0IyeEZOcHF4Yy9GRUg3Mjl3SGZlNjl6?=
 =?utf-8?B?Z1hjZmtGNWpud0pKOGtwSXYwMk5vMlpyOUZsNTd3WW1JSmpEOXFROFg4OXpR?=
 =?utf-8?B?TG9zTE5MTERNMGYrMEZocEtpdnc3ODNHcnNMNDlvTFAxaDVDS2R3ajhCZEhK?=
 =?utf-8?B?VFZKZnFxQmJzU0hXM2NWWWRWTkJqd2plbStuN09oYzIxeHNxZENUajJva3l3?=
 =?utf-8?B?dVZNM3RGbFo2d3UrdkZONEticG9MbmtIOWlzSm4xWm8ra0JxSlcrSndiSTM5?=
 =?utf-8?B?K1VhN2pJdTdHbTdUMStWaUMrUlF0SmVzaHJPMnFhT3M3SWdzZStwdFJTaEtX?=
 =?utf-8?B?Vm1FczZvSjBCVUNNazV2a3gyN1VLVmdVaGxxa2RiYStYNGFUTUVtMEd6aWNH?=
 =?utf-8?B?a1dZMDFvOUhkVnNWdjZ3MWtxRTRBT3phVmROSktobjcyTWh2dkgzL3E4c0NF?=
 =?utf-8?B?cE9Pa2E5YW1TeXRtT3lZNWs1RzlEbkxnOU10anQxMUdBaENzWVdQYXZIclVP?=
 =?utf-8?B?dHBlUFRVanBERUlIUUIxOVZidUJNT0RoTzY0K1VnY1R5UGtVekZSektEbFVK?=
 =?utf-8?B?cGxzZVBnLzhabTZPaC9haldqTXFhYVhFa1o1MFRKOVdRRXJETjZ0NmxNSEV5?=
 =?utf-8?B?c3MwNnArRFdNRFYzSEFmajdIbnBBL2NHNFE2enMzbHpoSTVVdXJ1MEpSZXdW?=
 =?utf-8?B?TS9WTjhJRlJoWlZ6aUd4NnkweGJyZEhGQ25ZRUVmS01QR2VXZmh1ZUpiOHAv?=
 =?utf-8?B?KzdPWVdTOGo2NWNrMVo5ZzV3YlZ1QmF3WnE0WHB0bmRtYW5sS2sxRkd2TXh4?=
 =?utf-8?B?bmtBR3pQc25VRnMyRkcvRk9lZ2l5cXlHd29Sd1ZvbjRPU051bVBZQ21peFBO?=
 =?utf-8?B?eERXT0trL2xQaU5PaXVpei9aVVM4V2NBbW5RWHRVbHVkMk56VzQ5TmVYVm9T?=
 =?utf-8?B?TEtyblNCSC91RTJ6N1FpY2tWN3NHQ0JXblJNVTZLTVhTYW5tMHYyS2pjZk41?=
 =?utf-8?B?NERtTi9jM0JYU1ZoRTJKNVpSTWFDck9JV3FDQkVZZE9aWWZUYjBvOFJkbFMw?=
 =?utf-8?B?azZmb2lRMW0vQjIraTR4SWJBVnhEODd2aDRQSmF1SGxyb0hwV0g2bGVaQ0Jv?=
 =?utf-8?B?VEdkZGJSWGQ0OXRFekVJNlQyUjl4ZTJPQWVrZmxlQ2N6SnBGT3AzRlVFN0w1?=
 =?utf-8?Q?+iLAhvEy3rtuVSNYn+VwbDp1C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a15437d-1f52-410d-2201-08dda74552f1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 11:03:54.5417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dRzYxpZf7Jos7kU1OMgUO/qAIApQYtiPda5HxqYgSusqAIH71UnlElLpmt98HqZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6946

On 09/06/2025 11:36, Kory Maincent wrote:
> Le Sun, 8 Jun 2025 09:17:59 +0300,
> Gal Pressman <gal@nvidia.com> a écrit :
> 
>> On 28/05/2025 10:31, Paolo Abeni wrote:
>>> I'm sorry, even if this has been posted (just) before the merge window,
>>> I think an uAPI extension this late is a bit too dangerous, please
>>> repost when net-next will reopen after the merge window.  
>>
>> Are all new uapi changes expected to come with a test that exercises the
>> functionality?
> 
> I don't think so and I don't think it is doable for now on PSE. There is nothing
> that could get the PSE control of a dummy PSE controller driver. We need either
> the support for a dummy PHY driver similarly to netdevsim or the support for the
> MDI ports.
> By luck Maxime Chevallier is currently working on both of these tasks and had
> already sent several times the patch series for the MDI port support.
> 

We shouldn't rule it out so quickly, testing is important, let's try to
accommodate to our rules.

Why can't this be tested on real hardware using a drivers/net/hw
selftest? The test can skip if it lacks the needed hardware.
Or rebase this over Maxime's work?

